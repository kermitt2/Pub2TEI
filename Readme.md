This project proposes a set of style sheets for converting XML documents encoded in various scientific publisher formats into a common TEI XML format. Often called __document ingestion__, converting heterogeneous publisher formats into a common working format is a typical, painful and time-consuming sub-task for building scientific digital library applications.

These style sheets have been first developed in the context of the European Project PEER and have been then further extended over the last years, in particular in the context of the ISTEX project. Depending on the publishers (see bellow), the encoding of bibliographical information, abstracts, citation and full texts are supported. 

Note: the test XML documents present in the sub-directory ```Samples``` are dummy documents with realistic publisher structures but random content.

## Requirement

XSLT __2.0__ processor.

## Usage

The starting point of the transformation process is the style sheet ```Publisher.xsl```.

The resulting TEI documents follow a TEI custumisation documented under the sub-directory ```Schemas```. This TEI format is very close to the one used by [GROBID](https://github.com/kermitt2/grobid), a complementary tool trying to convert documents in PDF into TEI. 

### Example with saxon9

Here is a usage example with the Open Source Saxon 9 Home Edition (java). You can download more recent `saxon_he` versions [here](https://github.com/Saxonica/Saxon-HE) (for conveniency, one is included in the `Samples/` directory):

> java -jar Samples/saxon9he.jar -s:Samples/TestPubInput/BMJ/bmj_sample.xml -xsl:Stylesheets/Publishers.xsl -o:out.tei.xml -dtd:off -a:off -expand:off --parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false -t 

The command will apply the Pub2TEI style sheets to a NLM file and produce a TEI `out.tei.xml`. You can remove the `-t` option for not producing the trace information. 

You can select a **directory** as input and ouput, in order to process a large amount of files, while compiling the XSLT only one time. The normal behavior is then to transform around **one hundred files per second**. If it's closer to one file per hundred seconds, see the next section... 

### Usual troubleshooting

It is crutial to avoid online fetching of resources - for thousand of files, online fetching will lead to abyssal runtime and something unusable. 

Remember that XML is from the W3C, so anything simple is by default complicated, painful and inefficient. In particular, pay attention to:

1) be sure that your XSLT processor does not try to fetch the DTD on the internet (this will have a disastrous impact on the performance),

For saxon, the option `-dtd:off` only applies to the XSLT part (the saxon part), which should solve point 2) above, but unfortunately it does not apply to the parsing which will always try to fetch these damn DTDs. 

2) be sure that the XML parser used by saxon does not try to fetch the DTD on the internet,

The option `--parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false` should prevent the parser to fetch the DTD (many thanks @superdude264 for the information https://github.com/kermitt2/Pub2TEI/issues/3 !)

3) the DTD declared in the source XML file should point locally to the file system.

Point 3) is a possible solution if 2) is not working. 

A further solution is to add locally empty DTD files (empty file, yes!) with the same name (see also [here](https://stackoverflow.com/a/18041141)). saxon will intercept the idiotic (but conformant) online fetching of DTD with these local version and neutralize validation. 

If it does not work, avoiding online fetching might suppose to write some preprocessing script to modify the path of the declared DTD or remove/comment them completely (but don't parse the XML in your script!). 

Alternatively, you can try to use a non-validating XML parser like [piccolo](http://piccolo.sourceforge.net/using.html), see also [here](https://www.saxonica.com/html/documentation/sourcedocs/controlling-parsing.html).

In practice, maybe with some unreasonable efforts, it is normally possible to prevent any possible idiotic online fetching of resources, combining all the above tricks, and get the expected "one hundred files transformed per second". 

## Coverage

The following publisher's formats should be properly processed: 
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

Coverage of NLM and JATS should be comprehensive (all versions), so covering also in particular PMC, PLOS and bioRxiv XML.  

## License

Pub2TEI is distributed under [BSD 2-clause](https://opensource.org/licenses/BSD-2-Clause) license. 

authors: 
* __Laurent Romary__, Laurent.Romary@inria.fr
* __Stephanie Gregorio__, stephanie.gregorio@inist.fr
* __Patrice Lopez__, patrice.lopez@science-miner.com
