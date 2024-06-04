"""
Pub2TEI Python Client
"""
import os
import json
import argparse
import time
import concurrent.futures
import ntpath
import requests
import pathlib

from client import ApiClient

class ServerUnavailableException(Exception):
    pass

class Pub2TEIClient(ApiClient):

    def __init__(self, pub2tei_server='localhost',
                 batch_size=1000,
                 sleep_time=1,
                 timeout=60,
                 config_path=None,
                 check_server=True):
        self.config = {
            'pub2tei_server': pub2tei_server,
            'batch_size': batch_size,
            'sleep_time': sleep_time,
            'timeout': timeout
        }
        if config_path:
            self._load_config(config_path)
        if check_server:
            self._test_server_connection()

    def _load_config(self, path="./config.json"):
        """
        Load the json configuration
        """
        config_json = open(path).read()
        self.config = json.loads(config_json)

    def _test_server_connection(self):
        """Test if the server is up and running."""
        the_url = self.get_server_url("isalive")
        try:
            r = requests.get(the_url)
        except:
            print("Pub2TEI server does not appear up and running, the connection to the server failed")
            raise ServerUnavailableException

        status = r.status_code

        if status != 200:
            print("Pub2TEI server does not appear up and running " + str(status))
        else:
            print("Pub2TEI server is up and running")

    def _output_file_name(self, input_file, input_path, output):
        # we use ntpath here to be sure it will work on Windows too
        if output is not None:
            input_file_name = str(os.path.relpath(os.path.abspath(input_file), input_path))
            filename = os.path.join(
                output, os.path.splitext(input_file_name)[0] + ".pub2tei.tei.xml"
            )
        else:
            input_file_name = ntpath.basename(input_file)
            filename = os.path.join(
                ntpath.dirname(input_file),
                os.path.splitext(input_file_name)[0] + ".pub2tei.tei.xml",
            )

        return filename

    def process(
        self,
        input_path,
        output=None,
        n=10,
        consolidate_references=True,
        segment_sentences=False,
        grobid_refine=False,
        generate_ids=False,
        force=True,
        verbose=False,
    ):
        batch_size_xml = self.config["batch_size"]
        input_files = []

        for (dirpath, dirnames, filenames) in os.walk(input_path):
            for filename in filenames:
                if filename.endswith(".xml") or filename.endswith(".nxml") or filename.endswith(".XML") or filename.endswith(".NXML"):
                    if verbose:
                        try:
                            print(filename)
                        except Exception:
                            # may happen on linux see https://stackoverflow.com/questions/27366479/python-3-os-walk-file-paths-unicodeencodeerror-utf-8-codec-cant-encode-s
                            pass
                    input_files.append(os.sep.join([dirpath, filename]))

                    if len(input_files) == batch_size_xml:
                        self.process_batch(
                            input_files,
                            input_path,
                            output,
                            n,
                            consolidate_references,
                            segment_sentences,
                            grobid_refine,
                            generate_ids,
                            force,
                            verbose,
                        )
                        input_files = []

        # last batch
        if len(input_files) > 0:
            self.process_batch(
                input_files,
                input_path,
                output,
                n,
                consolidate_references,
                segment_sentences,
                grobid_refine,
                generate_ids,
                force,
                verbose,
            )

    def process_batch(
        self,
        input_files,
        input_path,
        output,
        n,
        consolidate_references,
        segment_sentences,
        grobid_refine,
        generate_ids,
        force,
        verbose=False,
    ):
        if verbose:
            print(len(input_files), "files to process in current batch")

        # we use ThreadPoolExecutor and not ProcessPoolExecutor because it is an I/O intensive process
        with concurrent.futures.ThreadPoolExecutor(max_workers=n) as executor:
            results = []
            for input_file in input_files:
                # check if TEI file is already produced
                filename = self._output_file_name(input_file, input_path, output)
                if not force and os.path.isfile(filename):
                    print(filename, "already exist, skipping... (use --force to reprocess pdf input files)")
                    continue

                r = executor.submit(
                    self.process_xml,
                    input_file,
                    consolidate_references,
                    segment_sentences,
                    grobid_refine,
                    generate_ids)

                results.append(r)

        for r in concurrent.futures.as_completed(results):
            input_file, status, text = r.result()
            filename = self._output_file_name(input_file, input_path, output)

            if status != 200 or text is None:
                print("Processing of", input_file, "failed with error", str(status), ",", text)
                # writing error file with suffixed error code
                try:
                    pathlib.Path(os.path.dirname(filename)).mkdir(parents=True, exist_ok=True)
                    with open(filename.replace(".pub2tei.tei.xml", "_"+str(status)+".txt"), 'w', encoding='utf8') as tei_file:
                        if text is not None:
                            tei_file.write(text)
                        else:
                            tei_file.write("")
                except OSError:
                    print("Writing resulting TEI XML file", filename, "failed")
            else:
                # writing TEI file
                try:
                    pathlib.Path(os.path.dirname(filename)).mkdir(parents=True, exist_ok=True)
                    with open(filename,'w',encoding='utf8') as tei_file:
                        tei_file.write(text)
                except OSError:
                   print("Writing resulting TEI XML file", filename, "failed")

    def process_xml(
        self,
        xml_file,
        consolidate_references,
        segment_sentences,
        grobid_refine,
        generate_ids
    ):
        xml_handle = open(xml_file, "rb")
        files = {
            "input": (
                xml_file,
                xml_handle,
                "application/xml",
                {"Expires": "0"},
            )
        }

        the_url = self.get_server_url("processXML")

        # set the Pub2TEI parameters
        the_data = {}
        if consolidate_references:
            the_data["consolidateReferences"] = "1"
        if segment_sentences:
            the_data["segmentSentences"] = "1"
        if grobid_refine:
            the_data["grobidRefine"] = "1"
        if generate_ids:
            the_data["generateIDs"] = "1"

        try:
            res, status = self.post(
                url=the_url, files=files, data=the_data, headers={"Accept": "application/xml"}, timeout=self.config['timeout']
            )

            if status == 503 or status == 408:
                time.sleep(self.config["sleep_time"])
                return self.process_xml(
                    xml_file,
                    consolidate_references,
                    segment_sentences,
                    grobid_refine,
                    generate_ids
                )
        except requests.exceptions.ReadTimeout:
            xml_handle.close()
            return (xml_file, 408, None)

        xml_handle.close()
        return (xml_file, status, res.text)

    def get_server_url(self, service):
        return self.config['pub2tei_server'] + "/service/" + service

def main():
    parser = argparse.ArgumentParser(description="Client for Pub2TEI services")

    parser.add_argument(
        "--input",
        required=True,
        help="path to the directory containing XML files to process: .xml"
    )
    parser.add_argument(
        "--output",
        default=None,
        help="path to the directory where to put the results (optional)",
    )
    parser.add_argument(
        "--config",
        default="./config.json",
        help="path to the config file, default is ./config.json",
    )
    parser.add_argument(
        "--n",
        default=10,
        help="concurrency for service usage"
    )
    parser.add_argument(
        "--consolidate_references",
        action="store_true",
        help="use GROBID for consolidation of the bibliographical references",
    )
    parser.add_argument(
        "--segment_sentences",
        action="store_true",
        default=False,
        help="segment sentences in the text content of the document with additional <s> elements",
    )
    parser.add_argument(
        "--generate_ids",
        action="store_true",
        default=False,
        help="Generate idenfifier for each text item",
    )
    parser.add_argument(
        "--grobid_refine",
        action="store_true",
        default=False,
        help="use Grobid to structure/enhance raw fields: affiliations, references, person, dates",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        default=False,
        help="force re-processing pdf input files when tei output files already exist",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="print information about processed files in the console",
    )

    args = parser.parse_args()

    input_path = args.input
    config_path = args.config
    output_path = args.output

    if args.n is not None:
        try:
            n = int(args.n)
        except ValueError:
            print("Invalid concurrency parameter n:", n, ", n = 10 will be used by default")
            pass

    # if output path does not exist, we create it
    if output_path is not None and not os.path.isdir(output_path):
        try:
            print("output directory does not exist but will be created:", output_path)
            os.makedirs(output_path)
        except OSError:
            print("Creation of the directory", output_path, "failed")
        else:
            print("Successfully created the directory", output_path)

    consolidate_references = args.consolidate_references
    segment_sentences = args.segment_sentences
    grobid_refine = args.grobid_refine
    generate_ids = args.generate_ids

    force = args.force
    verbose = args.verbose

    try:
        client = Pub2TEIClient(config_path=config_path)
    except ServerUnavailableException:
        exit(1)

    start_time = time.time()

    client.process(
        input_path,
        output=output_path,
        n=n,
        consolidate_references=consolidate_references,
        segment_sentences=segment_sentences,
        grobid_refine=grobid_refine,
        generate_ids=generate_ids,
        force=force,
        verbose=verbose,
    )

    runtime = round(time.time() - start_time, 3)
    print("runtime: %s seconds " % (runtime))

if __name__ == "__main__":
    main()
