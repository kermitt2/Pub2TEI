This project proposes a set of style sheets for converting XML documents encoded in various scientific publisher formats into a common TEI format. Often called __document ingestion__, converting heterogeneous publisher formats into a common working format is a typical, painful and time-consuming sub-task for building scientific digital library applications.

These style sheets have been first developed in the context of the European Project PEER and have been then further extended over the last years. Depending on the publishers (see bellow), the encoding of bibliographical information, abstracts, citation and full texts are supported. 

Note: the test XML documents present in the sub-directory ```Samples``` are dummy documents with realistic publisher structures but random content.

## Requirement

XSLT __2.0__ processor.

Note that there is unfortunately no open source nor free XSLT 2.0 processor implementation, as far as we know :(

## Usage

The starting point of the transformation process is the style sheet ```Publisher.xsl```.

The resulting TEI documents follow a TEI custumisation documented under the sub-directory ```Schemas```. This TEI format is very close to the one used by [GROBID](https://github.com/kermitt2/grobid), a complementary tool trying to convert documents in PDF into TEI. 

## Coverage

The following publisher's formats should be properly processed: 
- BMJ: metadata, header, bibliography, body
- Elsevier (journals and conferences): metadata, header, bibliography, body
- IOP: metadata, header, bibliography. 
- Nature: metadata, header, bibliography, body 
- NLM: metadata, header, bibliography, body 
- OUP: ?
- PNAS: metadata, header, bibliography, body
- RSC: metadata, header, bibliography, body
- Sage: metadata, header
- ScholarOne: metadata, header
- Springer: metadata, header, bibliography, body

## License

Pub2TEI is distributed under [BSD 2-clause](https://opensource.org/licenses/BSD-2-Clause) license. 

Main author: __Laurent Romary__, Laurent.Romary@inria.fr