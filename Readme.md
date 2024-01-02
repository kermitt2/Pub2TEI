# Pub2TEI

## Project goal

This project aims at converting XML documents encoded in various scientific publisher formats into a common TEI XML format. Often called __document ingestion__, converting a myriad of heterogeneous publisher formats into a common working format is a painful and time-consuming sub-task for building scientific digital library applications.

The target TEI XML is the same as the Grobid TEI XML format, which makes possible to ingest various publisher XML or PDF into the same XML format, avoiding then to write multiple specific parsers. The publisher XML transformation should normally preserve all the information from the source XML. 

In addition to avoid any XML publisher information loss, the converter offers various possibilities to enhanced the publisher XML:

- when the input publisher XML has raw strings for affiliations, bibliographical references, authors or date, Grobid can be used automatically to further parses the raw string into a structured representation that is added to the final TEI document,

- a sentence segmentation is possible for the final TEI document with the same sentence segmenter as Grobid, 

- the converter service will fix various problems like empty nodes, duplicated XML identifiers, and invalid NCName for attribute values. 

With Pub2TEI, it is thus possible to obtain TEI XML documents with at least the same level of structuring as Grobid TEI XML created from PDF, while preserving the high quality of publisher full text XML encoding. 

## Coverage

The following publisher's XML formats should be properly processed: 

- BMJ: metadata, header, bibliography, body
- Elsevier (journals and conferences): metadata, header, bibliography, body
- IOP: metadata, header, bibliography. 
- NPG (Nature): metadata, header, bibliography, body 
- NLM/JATS: metadata, header, bibliography, body 
- OUP: metadata, header, bibliography, body
- PNAS: metadata, header, bibliography, body
- RSC: metadata, header, bibliography, body
- Sage: metadata, header
- ScholarOne: metadata, header
- Springer: metadata, header, bibliography, body
- Wiley: metadata, header, bibliography, body

Coverage of NLM and JATS should be comprehensive (all known versions), so covering in particular PMC, PLOS and bioRxiv XML. However, unfortunately, JATS is so loose that a new JATS flavor might require some stylesheet adjustements. In case you observe some issues in the resulting TEI XML for a new JATS publisher flavor, please fill an issue in this project.  

## How it works

The project offers a web service and batch command-lines for transforming and enhancing publisher XML in an efficient parallelized manner. 

It uses a set of style sheets for converting XML documents encoded in various scientific publisher formats into a common TEI XML format. These style sheets have been first developed in the context of the European Project PEER and have been then further extended over the last years, in particular in the context of the ISTEX project. Depending on the publishers (see bellow), the encoding of bibliographical information, abstracts, citation and full texts are supported. 

Enhancement is then realized by Grobid, selecting the appropriate model dynamically from the publisher XML based on the identified raw fields that can be further structured. 

The simplest way to run the converter is to use the __docker image__ and the web service API. The docker image contains all the required stylesheets, the Grobid Deep learning models, sentence segmenter utility and XSLT __2.0__ processor for XML transformation. 

## Running the project with Docker






## Running the project as a Java application








## Only using the stylesheets

This usage should be normally avoided because the additional document enhancement and problem corrections will not take place. In addition, the transformation here are not parallelized, so less efficient for large scale document processing. However, it is useful to consider only the stylesheets when testing the transformation and working on improving the stylesheets.   

Note: the test XML documents present in the sub-directory ```Samples``` are dummy documents with realistic publisher structures but random content (due to copyrights).

### Requirement

The minimum requirement is an XSLT __2.0__ processor. For convenience, we package `saxon9he.jar` in the project.

### Usage

The starting point of the transformation process is the style sheet ```Publisher.xsl```.

The resulting TEI documents follow a TEI customisation documented under the sub-directory ```Schemas```. 

#### Example with saxon9

Here is a usage example with the Open Source Saxon 9 Home Edition (java). You can download more recent `saxon_he` versions [here](https://github.com/Saxonica/Saxon-HE) (for conveniency, one is included in the `Samples/` directory):

> java -jar localLibs/saxon9he.jar -s:Samples/TestPubInput/BMJ/bmj_sample.xml -xsl:Stylesheets/Publishers.xsl -o:out.tei.xml -dtd:off -a:off -expand:off --parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false -t 

The command will apply the Pub2TEI style sheets to a NLM file and produce a TEI `out.tei.xml`. You can remove the `-t` option for not producing the trace information. 

You can select a **directory** as input and ouput, in order to process a large amount of files, while compiling the XSLT only one time. The normal behavior is then to transform around **one hundred files per second**. If it's closer to one file per hundred seconds, see the next section... 

#### Usual troubleshooting when using stylesheets only 

It is crutial to avoid online fetching of resources - for thousand of files, online fetching will lead to abyssal runtime and something unusable. 

Remember that XML is from the W3C, so anything simple is by default complicated, painful and inefficient. In particular, pay attention to:

1) be sure that your XSLT processor does not try to fetch the DTD on the internet (this will have a disastrous impact on the performance),

For saxon, the option `-dtd:off` only applies to the XSLT part (the saxon part), which should solve point 2) above, but unfortunately it does not apply to the parsing which will always try to fetch these damn DTDs. 

2) be sure that the XML parser used by saxon does not try to fetch the DTD on the internet,

The option `--parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false` should prevent the parser to fetch the DTD (many thanks [@superdude264](https://github.com/superdude264) for the information https://github.com/kermitt2/Pub2TEI/issues/3 !)

3) the DTD declared in the source XML file should point locally to the file system.

Point 3) is a possible solution if 2) is not working. 

A further solution is to add locally empty DTD files (empty file, yes!) with the same name (see also [here](https://stackoverflow.com/a/18041141)). saxon will intercept the idiotic (but conformant) online fetching of DTD with these local version and neutralize validation. 

If it does not work, avoiding online fetching might suppose to write some preprocessing script to modify the path of the declared DTD or remove/comment them completely (but don't parse the XML in your script!). 

Alternatively, you can try to use a non-validating XML parser like [piccolo](http://piccolo.sourceforge.net/using.html), see also [here](https://www.saxonica.com/html/documentation/sourcedocs/controlling-parsing.html).

In practice, maybe with some unreasonable efforts, it is normally possible to prevent any possible idiotic online fetching of resources, combining all the above tricks, and get the expected "one hundred files transformed per second". Using the web service and application, via the Docker image in particular, solves already all these problems and should be prefered.

## License

Pub2TEI is distributed under Apache 2 license. 

Maintainer and main developer: 
* __Patrice Lopez__, patrice.lopez@science-miner.com

Stylesheet authors: 
* __Laurent Romary__, Laurent.Romary@inria.fr
* __Stephanie Gregorio__, stephanie.gregorio@inist.fr
* __Patrice Lopez__, patrice.lopez@science-miner.com
