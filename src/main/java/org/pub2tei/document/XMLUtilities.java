package org.pub2tei.document;

import java.io.*;
import java.util.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.namespace.NamespaceContext;
import javax.xml.xpath.*;

import net.sf.saxon.om.NameChecker;

import org.w3c.dom.*;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import org.grobid.core.utilities.OffsetPosition;
import org.grobid.core.utilities.SentenceUtilities;

import org.apache.commons.io.FileUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *  Some convenient methods for suffering a bit less with XML
 */
public class XMLUtilities {

    private static final Logger LOGGER = LoggerFactory.getLogger(XMLUtilities.class);

    private static List<String> textualElements = Arrays.asList("p", "figDesc");

    public static String toPrettyString(String xml, int indent) {
        try {
            // Turn xml string into a document
            org.w3c.dom.Document document = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder()
                    .parse(new InputSource(new ByteArrayInputStream(xml.getBytes("utf-8"))));

            // Remove whitespaces outside tags
            document.normalize();
            XPath xPath = XPathFactory.newInstance().newXPath();
            org.w3c.dom.NodeList nodeList = (org.w3c.dom.NodeList) xPath.evaluate("//text()[normalize-space()='']",
                                                          document,
                                                          XPathConstants.NODESET);

            for (int i = 0; i < nodeList.getLength(); ++i) {
                org.w3c.dom.Node node = nodeList.item(i);
                node.getParentNode().removeChild(node);
            }

            // Setup pretty print options
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");

            // Return pretty print xml string
            StringWriter stringWriter = new StringWriter();
            transformer.transform(new DOMSource(document), new StreamResult(stringWriter));
            return stringWriter.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Change useless abstract/p/div/p into abstract/div/p allowed by Grobid TEI customization
     **/
    public static void fixAbstract(org.w3c.dom.Document doc) {
        // find abstract element
        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//abstract/p/div/p");  
            NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            if (matchNodes.getLength()>0) {
                Node abstractNode = matchNodes.item(0).getParentNode().getParentNode().getParentNode();
                NodeList abstractChildren = abstractNode.getChildNodes();
                if (abstractChildren.getLength() == 0)
                    return;

                List<Node> abstractChildrenList = new ArrayList<>();
                for (int j = 0; j < abstractChildren.getLength(); j++) {
                    abstractChildrenList.add(abstractChildren.item(j));
                }

                for(int i=0; i<abstractChildrenList.size(); i++) {
                    Node n = abstractChildrenList.get(i);
                    if ( (n.getNodeType() != Node.ELEMENT_NODE) && 
                         (n.getNodeName().equals("#text")) ) {
                        abstractNode.removeChild(n);
                    }
                    else if ( (n.getNodeType() == Node.ELEMENT_NODE) && 
                         (n.getNodeName().equals("p")) ) {
                        NodeList pChildren = n.getChildNodes();
                        if (pChildren.getLength() == 0) 
                            continue;

                        List<Node> pChildrenList = new ArrayList<>();
                        for (int j = 0; j < pChildren.getLength(); j++) {
                            pChildrenList.add(pChildren.item(j));
                        }

                        for(int j=0; j<pChildrenList.size(); j++) {
                            abstractNode.appendChild(pChildrenList.get(j));
                        }
                        abstractNode.removeChild(n);
                        //break;
                    }
                }
            }
        } catch(Exception ex) {
            LOGGER.error("abstract post processing failed", ex);
        }
    }

    /**
     * Perform a sentence segmentation of a TEI XML document object. 
     * 
     * The sentence segmenter to be used is the one defined in the Grobid configuration
     * file present in the Grobid home indicated by the Pub2TEI configuration. 
     * 
     * Currently the choices are a slightly improved Pragmatic Segmenter (higher quality 
     * more languages supported, but slower) and the OpenNLP sentence segmenter (very fast, 
     * lower quality, and designed for English only).
     * 
     * Note: we should probably avoid recursion for visiting the document nodes to be 
     * memory friendly.
     * 
     **/
    public static void segment(org.w3c.dom.Document doc, Node node) {
        final NodeList children = node.getChildNodes();
        final int nbChildren = children.getLength();

        List<Node> newChildren = new ArrayList<>();
        for (int i = 0; i < nbChildren; i++) {
            newChildren.add(children.item(i));
        }

        for (int i = 0; i < nbChildren; i++) {
            final Node n = newChildren.get(i);
            if ( (n.getNodeType() == Node.ELEMENT_NODE) && 
                 (textualElements.contains(n.getNodeName())) ) {
                // text content
                StringBuffer textBuffer = new StringBuffer();
                NodeList childNodes = n.getChildNodes();
                for(int y=0; y<childNodes.getLength(); y++) {
                    textBuffer.append(serialize(doc, childNodes.item(y)));
                    textBuffer.append(" ");
                }
                String text = textBuffer.toString();
                List<OffsetPosition> theSentenceBoundaries = SentenceUtilities.getInstance().runSentenceDetection(text);

                // we're making a first pass to ensure that there is no element broken by the segmentation
                List<String> sentences = new ArrayList<>();
                List<String> toConcatenate = new ArrayList<>();
                for(OffsetPosition sentPos : theSentenceBoundaries) {
                    //System.out.println("new chunk: " + sent);
                    String sent = text.substring(sentPos.start, sentPos.end);
                    String newSent = sent;
                    if (toConcatenate.size() != 0) {
                        StringBuffer conc = new StringBuffer();
                        for(String concat : toConcatenate) {
                            conc.append(concat);
                            conc.append(" ");
                        }
                        newSent = conc.toString() + sent;
                    }
                    String fullSent = "<s xmlns=\"http://www.tei-c.org/ns/1.0\">" + newSent + "</s>";
                    boolean fail = false;
                    try {
                        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                        factory.setNamespaceAware(true);
                        org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(fullSent)));                
                    } catch(Exception e) {
                        fail = true;
                    }
                    if (fail)
                        toConcatenate.add(sent);
                    else {
                        sentences.add(fullSent);
                        toConcatenate = new ArrayList<>();
                    }
                }

                List<Node> newNodes = new ArrayList<>();
                for(String sent : sentences) {
                    //System.out.println("-----------------");
                    sent = sent.replace("\n", " ");
                    sent = sent.replaceAll("( )+", " ");
                
                    //Element sentenceElement = doc.createElement("s");                        
                    //sentenceElement.setTextContent(sent);
                    //newNodes.add(sentenceElement);

                    //System.out.println(sent);  

                    try {
                        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                        factory.setNamespaceAware(true);
                        org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(sent)));
                        //d.getDocumentElement().normalize();
                        Node newNode = doc.importNode(d.getDocumentElement(), true);
                        newNodes.add(newNode);
                        //System.out.println(serialize(doc, newNode));
                    } catch(Exception e) {
                        LOGGER.error("Problem for segmented sentence XML element creation", e);
                    }
                }

                // remove old nodes 
                while (n.hasChildNodes())
                    n.removeChild(n.getFirstChild());

                // and add new ones

                // if we have a figDesc, we need to inject div/p nodes from something clean
                if (n.getNodeName().equals("figDesc")) {
                    Element theDiv = doc.createElementNS("http://www.tei-c.org/ns/1.0", "div");
                    Element theP = doc.createElementNS("http://www.tei-c.org/ns/1.0", "p");
                    for(Node theNode : newNodes) 
                        theP.appendChild(theNode);
                    theDiv.appendChild(theP);
                    n.appendChild(theDiv);
                } else {
                    for(Node theNode : newNodes) 
                        n.appendChild(theNode);
                }
            } else if (n.getNodeType() == Node.ELEMENT_NODE) {
                //XMLUtilities.segment(doc, (Element) n);
                XMLUtilities.segment(doc, n);
            } 
        }
    }

    public static String serialize(org.w3c.dom.Document doc, Node node) {
        // to avoid issues with space remaining from deleted nodes
        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            // XPath to find empty text nodes.
            XPathExpression xpathExp = xpathFactory.newXPath().compile(
                    "//text()[normalize-space(.) = '']");  
            NodeList emptyTextNodes = (NodeList) 
                    xpathExp.evaluate(doc, XPathConstants.NODESET);

            // Remove each empty text node from document.
            for (int i = 0; i < emptyTextNodes.getLength(); i++) {
                Node emptyTextNode = emptyTextNodes.item(i);
                emptyTextNode.getParentNode().removeChild(emptyTextNode);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        }

        DOMSource domSource = null;
        String xml = null;
        try {
            if (node == null) {
                domSource = new DOMSource(doc);
            } else {
                domSource = new DOMSource(node);
            }
            StringWriter writer = new StringWriter();
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.setOutputProperty(OutputKeys.METHOD, "xml");
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");

            if (node != null)
                transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            transformer.transform(domSource, result);
            xml = writer.toString();
        } catch(TransformerException ex) {
            ex.printStackTrace();
        }
        return xml;
    }

    /**
     * Apply a Pub2TEI transformation to an XML file to produce a TEI file via external command line.
     * 
     * ** This should not be used, except for test and benchmarking. **
     * 
     * -> This usage must be avoided due to very heavy additional loading/processing and warm-up. 
     *    This method is for test and comparison.
     * 
     * Input XML file must be a native XML publisher file supported by Pub2TEI.
     * Output the path to the transformed outputed file or null if the transformation failed.
     * 
     * For practical XSLT transformation, use the XSLTProcessor instance.
     */
    public static String applyPub2TEI(String inputFilePath, String outputFilePath, String pathToPub2TEI) {
        // Use an external command line, example: 
        // java -jar Samples/saxon9he.jar -s:/mnt/data/resources/plos/0/ -xsl:Stylesheets/Publishers.xsl 
        // -o:/mnt/data/resources/plos/0/tei/ -dtd:off -a:off -expand:off 
        // --parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false -t

        // remove first the DTD declaration from the input nlm/jats XML because all these shitty xml mechanisms break 
        // the process at one point or another or keep looking for something over the internet 
        try {
            String xmlContent = FileUtils.readFileToString(new File(inputFilePath), "UTF-8");
            xmlContent = xmlContent.replaceAll("<!DOCTYPE((.|\n|\r)*?)\">", ""); 
            FileUtils.writeStringToFile(new File(inputFilePath), xmlContent, "UTF-8");
        } catch(IOException e) {
            LOGGER.error("Fail to preprocess the XML file to be transformed", e);
        }

        ProcessBuilder processBuilder = new ProcessBuilder(); 
        String s = "-s:"+inputFilePath;
        File dirToPub2TEI = new File(pathToPub2TEI);

        String xsl = "-xsl:" + dirToPub2TEI.getAbsolutePath() + "/Stylesheets/Publishers.xsl";
        String o = "-o:"+outputFilePath;
        processBuilder.command("java", "-jar", dirToPub2TEI.getAbsolutePath() + "/localLibs/saxon9he.jar", 
            s, xsl, o, "-dtd:off", "-a:off", "-expand:off", 
            "--parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd:false", "-t");

        //processBuilder.directory(new File(pathToPub2TEI)); 
        //System.out.println(processBuilder.command().toString());
        try {
            Process process = processBuilder.start();
            StringBuilder output = new StringBuilder();
            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream()));

            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line + "\n");
            }

            int exitVal = process.waitFor();
            if (exitVal == 0) {
                System.out.println("XML transformation done");
            } else {
                // abnormal...
                System.out.println("XML transformation failed");
                outputFilePath = null;
            }
        } catch (IOException e) {
            e.printStackTrace();
            outputFilePath = null;
        } catch (InterruptedException e) {
            e.printStackTrace();
            outputFilePath = null;
        }
        return outputFilePath;
    }

    // the list attributes that must be valid NCName
    private static List<String> nCNameAttributes = Arrays.asList("xml:id");

    /**
     * Correct duplicated xml:id in a document. This happens usually under author level 
     * when affiliations and/or notes are copied several times for several authors. 
     * 
     * Fix attribute values not valid ncname. Note: not sure it reach the point where 
     * we have a parsed XML Document, so it might then be handled at string level :/
     **/
    public static void fixDuplicatedXMLIDAndNCName(org.w3c.dom.Document doc) {
        // collect xml:id and check for duplicate
        List<String> xmlIdentifiers = new ArrayList<>();
        List<String> dulicatedXmlIdentifiers = new ArrayList<>();

        XPathFactory xpathFactory = XPathFactory.newInstance();

        try {
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//@id");  
            NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            for(int i=0; i<matchNodes.getLength(); i++) {
                if (xmlIdentifiers.contains(matchNodes.item(i).getNodeValue()))
                    dulicatedXmlIdentifiers.add(matchNodes.item(i).getNodeValue());
                else
                    xmlIdentifiers.add(matchNodes.item(i).getNodeValue());
            }

            // if duplicate, fix the value
            if (dulicatedXmlIdentifiers.size() >0) {
                for(String value : dulicatedXmlIdentifiers) {
                    xpathExp = xpathFactory.newXPath().compile("//*[@id='" + value + "']");  
                    matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
                    for(int i=0; i<matchNodes.getLength(); i++) {
                        if (i>0) {
                            org.w3c.dom.Element element = (Element) matchNodes.item(i); 
                            element.setAttribute("xml:id", value+"_"+(i+1));
                        }
                    }
                }
            }
        } catch(Exception e) {
            LOGGER.error("Post-processing for fixing duplicated attribute values failed", e);
        }

        try {
            // avoid recursion for visiting document nodes to be memory friendly
            NodeList nodeList = doc.getElementsByTagName("*");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    // visit attributes
                    NamedNodeMap attributesMap = node.getAttributes();
                    for (int j=attributesMap.getLength()-1; j>=0; j--) {
                        Node attr = attributesMap.item(j);

                        String attributeValue = attr.getNodeValue();

                        if (!nCNameAttributes.contains(attr.getNodeName()))
                            continue;

                        // if attribute value is empty, we remove the attribute
                        if (attributeValue == null || attributeValue.trim().length() == 0) {
                            org.w3c.dom.Element element = (Element) node; 
                            element.removeAttribute(attr.getNodeName());
                        } else if (!NameChecker.isValidNCName(attributeValue)) {
                            // NCName well-formedness
                            
                            // try a fix for usual digit related error
                            if (NameChecker.isValidNCName("_"+attributeValue)) {
                                // fix attribute value if required
                                org.w3c.dom.Element element = (Element) node; 
                                element.setAttribute(attr.getNodeName(), "_"+attributeValue);
                            } else {
                                // else we remove the attribute to prevent parsing errors
                                org.w3c.dom.Element element = (Element) node; 
                                element.removeAttribute(attr.getNodeName());
                            }
                        }
                    }                    
                }
            }
        } catch(Exception e) {
            LOGGER.error("Post-processing for fixing non-NCName attribute values failed", e);
        }
    }

    public static String reformatTEI(String tei) {
        // TODO: write and compile a single regular expression
        tei = tei.replaceAll("\"\n( )*", "\" ");
        tei = tei.replaceAll("<p>\n( )*<ref", "<p><ref");
        tei = tei.replaceAll("<p>\n( )*<rs", "<p><rs");
        tei = tei.replaceAll("</ref>\n( )*<ref", "</ref> <ref");
        tei = tei.replaceAll("</rs>\n( )*<rs ", "</rs> <rs ");
        tei = tei.replaceAll(" \n( )*<rs ", " <rs ");
        tei = tei.replaceAll("</rs>\n( )*<ref ", "</rs> <ref ");
        tei = tei.replaceAll("</rs>\n( )*</p>", "</rs></p>");
        tei = tei.replaceAll("</ref>\n( )*</p>", "</ref></p>");
        tei = tei.replaceAll("</ref>\n( )*<rs ", "</ref> <rs ");
        tei = tei.replaceAll("xmlns=\"\" ", "");
        tei = tei.replaceAll("xml:id=\"\" ", "");
        tei = tei.replace("<s xmlns=\"http://www.tei-c.org/ns/1.0\"", "<s");
        tei = tei.replace("<div xmlns=\"http://www.tei-c.org/ns/1.0\"", "<div");
        tei = tei.replace("<note xmlns=\"http://www.tei-c.org/ns/1.0\"", "<note");
        tei = tei.replace("<label xmlns=\"http://www.tei-c.org/ns/1.0\"", "<label");
        return tei;
    }

}