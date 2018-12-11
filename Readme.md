This project proposes a set of style sheets for converting XML documents encoded in various scientific publisher formats into a common TEI format. Often called __document ingestion__, converting heterogeneous publisher formats into a common working format is a typical, painful and time-consuming sub-task for building scientific digital library applications.

These style sheets have been first developed in the context of the European Project PEER and have been then further extended over the last years, in particular in the context of the ISTEX project. Depending on the publishers (see bellow), the encoding of bibliographical information, abstracts, citation and full texts are supported. 

Note: the test XML documents present in the sub-directory ```Samples``` are dummy documents with realistic publisher structures but random content.

## Requirement

XSLT __2.0__ processor.

## Usage

The starting point of the transformation process is the style sheet ```Publisher.xsl```.

The resulting TEI documents follow a TEI custumisation documented under the sub-directory ```Schemas```. This TEI format is very close to the one used by [GROBID](https://github.com/kermitt2/grobid), a complementary tool trying to convert documents in PDF into TEI. 

### Example with saxon9

Here is a usage example with the Open Source Saxon 9 Home Edition (java). You can download the latest `saxon9he.jar` [here](http://saxon.sourceforge.net/) (for conveniency, one is included in the `Samples/` directory):

> java -jar Samples/saxon9he.jar -s:Samples/TestPubInput/BMJ/bmj_sample.xml -xsl:Stylesheets/Publishers.xsl -o:out.tei.xml -dtd:off -a:off -expand:off -t

The command will apply the Pub2TEI style sheets to a NLM file and produce a TEI `out.tei.xml`. You can remove the `-t` option for not producing the trace information. 

You can select a directory as input and ouput, in order to process a large amount of files, while compiling the XSLT only one time. The normal behavior is then to transform around one hundred files per second. If it's close to one file per hundred seconds, see below... 


### Usual troubleshooting

Remember that XML is from the W3C, so anything simple is by default complicated. In particular, pay attention to the fact that the DTD declared in the source XML file should point locally to the file system, and be sure that your XSLT processor does not try to fetch the DTD on the internet (this will have a disastrous impact on the performance). For saxon, the option `-dtd:off` only applies to the XSLT part (the saxon part) and not to the parsing which will always try to fetch these damn DTDs. 

Alternatively, you can add locally empty DTD files (empty file, yes!) with the same name (see also [here](https://stackoverflow.com/a/18041141)). saxon will intercept the stupid (but conformant) online fetching of DTD with these local version and neutralize validation. 

Alternatively, you can use a non-validating XML parser like [piccolo](http://piccolo.sourceforge.net/using.html), see also [here](https://www.saxonica.com/html/documentation/sourcedocs/controlling-parsing.html).

## Coverage

The following publisher's formats should be properly processed: 
- BMJ: metadata, header, bibliography, body
- Elsevier (journals and conferences): metadata, header, bibliography, body
- IOP: metadata, header, bibliography. 
- NPG (Nature): metadata, header, bibliography, body 
- NLM: metadata, header, bibliography, body 
- OUP: ?
- PNAS: metadata, header, bibliography, body
- RSC: metadata, header, bibliography, body
- Sage: metadata, header
- ScholarOne: metadata, header
- Springer: metadata, header, bibliography, body
- Wiley: metadata, header, bibliography, body

Coverage of NLM and JATS should be comprehensive. 

## License

Pub2TEI is distributed under [BSD 2-clause](https://opensource.org/licenses/BSD-2-Clause) license. 

authors: 
* __Laurent Romary__, Laurent.Romary@inria.fr
* __Stephanie Gregorio__, stephanie.gregorio@inist.fr
* __Patrice Lopez__, patrice.lopez@science-miner.com
