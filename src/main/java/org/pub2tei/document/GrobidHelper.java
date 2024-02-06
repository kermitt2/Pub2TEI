package org.pub2tei.document;

import org.pub2tei.sax.BiblStructSaxHandler;

import java.io.*;
import java.util.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.namespace.NamespaceContext;
import javax.xml.xpath.*;

import org.w3c.dom.*;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import static java.nio.charset.StandardCharsets.UTF_8;

import org.pub2tei.service.ServiceConfiguration;
import org.pub2tei.main.MainArgs;
import org.apache.commons.io.FileUtils;
import org.grobid.core.utilities.IOUtilities;
import org.grobid.core.engines.Engine;
import org.grobid.core.data.Affiliation;
import org.grobid.core.data.BiblioItem;
import org.grobid.core.data.BibDataSet;
import org.grobid.core.data.Date;
import org.grobid.core.data.Person;
import org.grobid.core.factory.GrobidPoolingFactory;
import org.grobid.core.factory.GrobidFactory;
import org.grobid.core.utilities.Consolidation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Static methods to call Grobid processing on raw fields in the Pub2TEI transformed document,
 * The goal is to add refined Grobid structured elements corresponding to the raw strings in 
 * the document. 
 *
 * @author Patrice
 */
public class GrobidHelper {

    private static final Logger LOGGER = LoggerFactory.getLogger(GrobidHelper.class);

    private static Engine engine = GrobidFactory.getInstance().createEngine();

    public static void refineWithGrobid(org.w3c.dom.Document doc) {
        GrobidHelper.refineAffiliations(doc);
        GrobidHelper.refineReferences(doc);
        GrobidHelper.refineAuthors(doc);
        GrobidHelper.refineDate(doc);
    }

    public static void refineAffiliations(org.w3c.dom.Document doc) {
        // look for affiliation elements and check if we have a raw value
        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//affiliation");  
            final NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            final int nbChildren = matchNodes.getLength();

            List<Element> elementsToProcess = new ArrayList<>();
            List<String> rawStringToProcess = new ArrayList<>();

            for (int i = 0; i < nbChildren; i++) {
                Node n = matchNodes.item(i);
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) n;

                    if (checkIsRawField(element)) {
                        elementsToProcess.add(element);
                        //rawStringToProcess.add(element.getTextContent());
                        rawStringToProcess.add(XMLUtilities.getTextContentWithSpace(element));
                    }
                }
            }

            if (elementsToProcess.size()>0) {
                // process the raw affiliations 
                // note: TBD process in batch via processingLayoutTokens, for faster application of DL models
                //Engine engine = null;
                try {
                    //engine = Engine.getEngine(true);
                    //engine = GrobidFactory.getInstance().createEngine();
                    for (int i= 0; i<rawStringToProcess.size(); i++) {
                        String rawString = rawStringToProcess.get(i);
                        List<Affiliation> affiliationList = engine.processAffiliation(rawString);
                        // we have only one affiliation, so we expect one structured affiliation result
                        if (affiliationList.size() != 1 )
                            continue;

                        String affiliationTEISegment = Affiliation.toTEI(affiliationList.get(0), 4);

                        if (affiliationTEISegment == null || affiliationTEISegment.trim().length() == 0)
                            continue;

                        // put back results to the elements
                        Element element = elementsToProcess.get(i);
                        String valueKey = null;

                        // 1) raw affiliation string is moved to <note type="raw_affiliation">, with <ref> changed to <label>
                        Element theNote = doc.createElementNS("http://www.tei-c.org/ns/1.0", "note");
                        theNote.setAttribute("type", "raw_affiliation");
                        theNote.setAttribute("subtype", "original");

                        final NodeList elementChildren = element.getChildNodes();
                        // first get the value key
                        for(int j=0; j<elementChildren.getLength(); j++) {
                            Node localNode = elementChildren.item(j);
                            if (valueKey == null && 
                                localNode.getNodeType() == Node.ELEMENT_NODE && 
                                (localNode.getNodeName().equals("label") || localNode.getNodeName().equals("ref")) ) {
                                valueKey = localNode.getTextContent();
                                break;
                            }
                        }

                        if (valueKey != null) {
                            Element localLabel = doc.createElementNS("http://www.tei-c.org/ns/1.0", "label");
                            localLabel.setTextContent(valueKey);
                            theNote.appendChild(localLabel);
                        }

                        // then move the non empty nodes
                        for(int j=0; j<elementChildren.getLength(); j++) {
                            Node localNode = elementChildren.item(j);
                            if (localNode.getNodeType() == Node.ELEMENT_NODE && 
                                (localNode.getNodeName().equals("label") || localNode.getNodeName().equals("ref")) ) {
                                continue;
                            }
                            String textContent = localNode.getTextContent();
                            textContent = textContent.replaceAll(" ", "");
                            textContent = textContent.replaceAll("\n", "");
                            if (textContent.length() == 0)
                                continue;
                            theNote.appendChild(localNode);
                        }
                        while (element.hasChildNodes())
                            element.removeChild(element.getFirstChild());

                        element.appendChild(theNote);

                        // 2) structured affiliation nodes are put under <affiliation>
                        List<Node> newNodes = new ArrayList<>();
                        try {
                            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(affiliationTEISegment)));
                            //d.getDocumentElement().normalize();
                            Node newNode = doc.importNode(d.getDocumentElement(), true);
                            NodeList localChildren = newNode.getChildNodes();
                            for(int k=0; k<localChildren.getLength(); k++) {
                                Node newChildNode = localChildren.item(k);
                                newNodes.add(newChildNode);
                            }
                            //System.out.println(serialize(doc, newNode));
                        } catch(Exception e) {
                            LOGGER.error("Problem for structured affiliation TEI segment parsing", e);
                        }

                        for(Node theNode : newNodes) 
                            element.appendChild(theNode);
                        
                        // 3) affiliation get an extra key attribute value (key="aff1"), with content of ref/label or new created if none
                        if (valueKey != null)
                            element.setAttribute("key", valueKey); 
                    }
                } catch (NoSuchElementException nseExp) {
                    LOGGER.error("Could not get an engine from the pool within configured time.");
                } catch (Exception e) {
                    LOGGER.error("An unexpected exception occurs when processing affiliation string. ", e);
                } /*finally {
                    if (engine != null) {
                        //GrobidPoolingFactory.returnEngine(engine);
                        engine.close();
                    }
                }*/
            }
        } catch(Exception ex) {
            LOGGER.error("affiliation refinement failed", ex);
        } 
    }

    public static void refineReferences(org.w3c.dom.Document doc) {
        // look for bib ref elements and check if we have a raw value
        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//bibl");  
            final NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            final int nbChildren = matchNodes.getLength();

            List<Element> elementsToProcess = new ArrayList<>();
            List<String> rawStringToProcess = new ArrayList<>();

            for (int i = 0; i < nbChildren; i++) {
                Node n = matchNodes.item(i);
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) n;

                    // note: by definition, bibl is a unstructured reference, so no need to detect if we have a raw field
                    elementsToProcess.add(element);
                    rawStringToProcess.add(element.getTextContent());
                }
            }

            if (elementsToProcess.size()>0) {
                // process the raw references 
                //Engine engine = null;
                try {
                    //engine = GrobidFactory.getInstance().createEngine();

                    // batch processing
                    List<BiblioItem> structReferences = engine.processRawReferences(rawStringToProcess, 0);

                    for (int i= 0; i<rawStringToProcess.size(); i++) {
                        BiblioItem structReference = structReferences.get(i);
                        if (structReference.rejectAsReference())
                            continue;

                        String referenceTEISegment = structReference.toTEI(0);

                        if (referenceTEISegment == null || referenceTEISegment.trim().length() == 0)
                            continue;

                        // put back results to the elements
                        // introduce a <biblStruct> element
                        Element theBiblStruct = doc.createElementNS("http://www.tei-c.org/ns/1.0", "biblStruct");

                        Element element = elementsToProcess.get(i);
                        String valueKey = null;

                        // 1) raw reference string is moved to <note type="raw_reference"> under <biblStruct>, 
                        Element theNote = doc.createElementNS("http://www.tei-c.org/ns/1.0", "note");
                        theNote.setAttribute("type", "raw_reference");
                        theNote.setAttribute("subtype", "original");

                        valueKey = element.getAttribute("xml:id");

                        final NodeList elementChildren = element.getChildNodes();
                        List<Node> elementChildrenList = new ArrayList<>();
                        for(int j=0; j<elementChildren.getLength(); j++) {
                            elementChildrenList.add(elementChildren.item(j));
                        }

                        // then move the non empty nodes
                        for(Node localNode : elementChildrenList) {
                            String textContent = localNode.getTextContent();
                            textContent = textContent.replaceAll(" ", "");
                            textContent = textContent.replaceAll("\n", "");
                            if (textContent.length() == 0)
                                continue;
                            theNote.appendChild(localNode);
                        }

                        theBiblStruct.appendChild(theNote);

                        // 2) structured affiliation nodes are put under a new <biblStruct>
                        List<Node> newNodes = new ArrayList<>();
                        try {
                            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(referenceTEISegment)));
                            //d.getDocumentElement().normalize();
                            Node newNode = doc.importNode(d.getDocumentElement(), true);
                            NodeList localChildren = newNode.getChildNodes();
                            for(int k=0; k<localChildren.getLength(); k++) {
                                Node newChildNode = localChildren.item(k);
                                newNodes.add(newChildNode);
                            }
                            //System.out.println(serialize(doc, newNode));
                        } catch(Exception e) {
                            LOGGER.error("Problem for structured reference TEI segment parsing", e);
                        }

                        for(Node theNode : newNodes) 
                            theBiblStruct.appendChild(theNode);
                        
                        // 3) <biblStruct> reference get an extra xml:id attribute value, with content of ref/label or new created if none
                        if (valueKey != null)
                            theBiblStruct.setAttribute("xml:id", valueKey); 

                        // 4) delete old <bibl> as content has been moved under <biblStruct>, keep original reference element ordering 
                        element.getParentNode().insertBefore(theBiblStruct, element);
                        element.getParentNode().removeChild(element);
                    }
                } catch (NoSuchElementException nseExp) {
                    LOGGER.error("Could not get an engine from the pool within configured time.");
                } catch (Exception e) {
                    LOGGER.error("An unexpected exception occurs when processing reference string. ", e);
                } /*finally {
                    if (engine != null) {
                        //GrobidPoolingFactory.returnEngine(engine);
                        engine.close();
                    }
                }*/
            }
        } catch(Exception ex) {
            LOGGER.error("affiliation refinement failed", ex);
        } 
    }

    public static void refineAuthors(org.w3c.dom.Document doc) {
        // look for author elements and check if we have a raw value
        // possible author raw fields can be present under <persName> and <editor>, possibly <author> too?
        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//*[local-name()='persName' or local-name()='editor' or local-name()='author']");  
            final NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            final int nbChildren = matchNodes.getLength();

            List<Element> elementsToProcess = new ArrayList<>();
            List<String> rawStringToProcess = new ArrayList<>();

            for (int i = 0; i < nbChildren; i++) {
                Node n = matchNodes.item(i);
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) n;

                    if (checkIsRawField(element)) {
                        elementsToProcess.add(element);
                        rawStringToProcess.add(element.getTextContent());
                    }
                }
            }

            if (elementsToProcess.size()>0) {
                // process the raw person name 
                try {
                    for (int i= 0; i<rawStringToProcess.size(); i++) {
                        String rawString = rawStringToProcess.get(i);

                        // depending on where we are - header or citation, we can use different person name parsers
                        List<Person> personList = null;

                        //personList = engine.processAuthorsHeader(rawString);
                        personList = engine.processAuthorsCitation(rawString);

                        // we have only one affiliation, so we expect one structured affiliation result
                        if (personList == null || personList.size() != 1)
                            continue;

                        String personTEISegment = null;
                        if (personList != null && personList.size() >0)
                            personTEISegment = personList.get(0).toTEI(false, 4);

                        if (personTEISegment == null || personTEISegment.trim().length() == 0)
                            continue;

                        // put back results to the elements
                        Element element = elementsToProcess.get(i);
                        String valueKey = null;

                        // 1) raw person name string is moved to <note type="raw_name">, with <ref> changed to <label>
                        Element theNote = doc.createElementNS("http://www.tei-c.org/ns/1.0", "note");
                        theNote.setAttribute("type", "raw_name");
                        theNote.setAttribute("subtype", "original");

                        final NodeList elementChildren = element.getChildNodes();
                        // first get the value key
                        for(int j=0; j<elementChildren.getLength(); j++) {
                            Node localNode = elementChildren.item(j);
                            if (valueKey == null && 
                                localNode.getNodeType() == Node.ELEMENT_NODE && 
                                (localNode.getNodeName().equals("label") || localNode.getNodeName().equals("ref")) ) {
                                valueKey = localNode.getTextContent();
                                break;
                            }
                        }

                        if (valueKey != null) {
                            Element localLabel = doc.createElementNS("http://www.tei-c.org/ns/1.0", "label");
                            localLabel.setTextContent(valueKey);
                            theNote.appendChild(localLabel);
                        }

                        // then move the non empty nodes
                        for(int j=0; j<elementChildren.getLength(); j++) {
                            Node localNode = elementChildren.item(j);
                            if (localNode.getNodeType() == Node.ELEMENT_NODE && 
                                (localNode.getNodeName().equals("label") || localNode.getNodeName().equals("ref")) ) {
                                continue;
                            }
                            String textContent = localNode.getTextContent();
                            textContent = textContent.replaceAll(" ", "");
                            textContent = textContent.replaceAll("\n", "");
                            if (textContent.length() == 0)
                                continue;
                            theNote.appendChild(localNode);
                        }
                        while (element.hasChildNodes())
                            element.removeChild(element.getFirstChild());

                        element.appendChild(theNote);

                        // 2) structured person name nodes are put under original element
                        List<Node> newNodes = new ArrayList<>();
                        try {
                            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                            factory.setNamespaceAware(true);
                            org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(personTEISegment)));
                            //d.getDocumentElement().normalize();
                            Node newNode = doc.importNode(d.getDocumentElement(), true);
                            NodeList localChildren = newNode.getChildNodes();
                            for(int k=0; k<localChildren.getLength(); k++) {
                                Node newChildNode = localChildren.item(k);
                                newNodes.add(newChildNode);
                            }
                            //System.out.println(serialize(doc, newNode));
                        } catch(Exception e) {
                            LOGGER.error("Problem for structured person name TEI segment parsing", e);
                        }

                        for(Node theNode : newNodes) 
                            element.appendChild(theNode);
                        
                        // 3) original element get an extra key attribute value (key="aut1"), with content of ref/label or new created if none
                        if (valueKey != null)
                            element.setAttribute("key", valueKey); 
                    }
                
                } catch (NoSuchElementException nseExp) {
                    LOGGER.error("Could not get an engine from the pool within configured time.");
                } catch (Exception e) {
                    LOGGER.error("An unexpected exception occurs when processing person name. ", e);
                } 
            }   
        } catch(Exception ex) {
            LOGGER.error("person name refinement failed", ex);
        }     

    }

    public static void refineDate(org.w3c.dom.Document doc) {
        // look for date elements and check if we have a raw value

        // look for <date> element without attribute @when and with raw value, 
        // the goal is then to add a @when attribute following ISO date thanks 
        // to Grobid date model

        try {
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPathExpression xpathExp = xpathFactory.newXPath().compile("//date");  
            final NodeList matchNodes = (NodeList) xpathExp.evaluate(doc, XPathConstants.NODESET);
            final int nbChildren = matchNodes.getLength();

            List<Element> elementsToProcess = new ArrayList<>();
            List<String> rawStringToProcess = new ArrayList<>();

            for (int i = 0; i < nbChildren; i++) {
                Node n = matchNodes.item(i);
                if (n.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) n;

                    // check the @when attribute
                    String valueWhen = element.getAttribute("when");
                    if ((valueWhen == null || valueWhen.length() == 0 ) && checkIsRawField(element)) {
                        elementsToProcess.add(element);
                        rawStringToProcess.add(element.getTextContent());
                    }
                }
            }

            if (elementsToProcess.size()>0) {
                // process the raw dates 
                try {
                    for (int i= 0; i<rawStringToProcess.size(); i++) {
                        String rawString = rawStringToProcess.get(i);
                        List<Date> dateList = engine.processDate(rawString);
                        // we have only one date, so we expect one structured date result
                        if (dateList.size() != 1 )
                            continue;

                        String dateISOString = Date.toISOString(dateList.get(0)); 

                        if (dateISOString == null || dateISOString.trim().length() == 0)
                            continue;

                        // put back results to the elements
                        Element element = elementsToProcess.get(i);
                        element.setAttribute("when", dateISOString);

                        // that's it for dates
                    }
                } catch (NoSuchElementException nseExp) {
                    LOGGER.error("Could not get an engine from the pool within configured time.");
                } catch (Exception e) {
                    LOGGER.error("An unexpected exception occurs when processing date string. ", e);
                }
            }
        } catch (NoSuchElementException nseExp) {
            LOGGER.error("Could not get an engine from the pool within configured time.");
        } catch (Exception e) {
            LOGGER.error("An unexpected exception occurs when processing date raw string. ", e);
        }
    }

    private static List<String> ignoreElements = Arrays.asList("ref", "label");

    /**
     * Cehck if the element only contains a raw value 
     **/
    public static boolean checkIsRawField(org.w3c.dom.Element element) {
        boolean result = false;

        // check the child elements that are not text, ignore <ref> and <label>
        final NodeList children = element.getChildNodes();
        final int nbChildren = children.getLength();

        boolean foundStruct = false;
        for (int i = 0; i < nbChildren; i++) {
            final Node n = children.item(i);
            if ( (n.getNodeType() == Node.ELEMENT_NODE) && 
                 (!ignoreElements.contains(n.getNodeName())) ) {
                foundStruct = true;
                break;
            }
        }

        if (!foundStruct)
            result = true;
        
        return result;
    }

    /**
     * Parse a TEI biblStruct XML string into a BiblioItem object.  
     **/
    public static BiblioItem parseTEIBiblioItem(org.w3c.dom.Element biblStructElement) {
        BiblStructSaxHandler handler = new BiblStructSaxHandler();
        String teiXML = null;
        try {
            SAXParserFactory spf = SAXParserFactory.newInstance();
            SAXParser p = spf.newSAXParser();
            teiXML = XMLUtilities.serialize(null, biblStructElement);
            p.parse(new InputSource(new StringReader(teiXML)), handler);
        } catch(Exception e) {
            if (teiXML != null)
                LOGGER.warn("The parsing of the biblStruct from TEI document failed for: " + teiXML);
            else 
                LOGGER.warn("The parsing of the biblStruct from TEI document failed for: " + biblStructElement.toString());
        }
        return handler.getBiblioItem();
    }

    public static void consolidateReferences(org.w3c.dom.Document doc, int consolidateReferences) {

        // local bibliographical references to spot in the XML mark-up
        List<BibDataSet> resCitations = new ArrayList<>();
        List<org.w3c.dom.Element> biblStructElements = new ArrayList<>();
        org.w3c.dom.NodeList bibList = doc.getElementsByTagName("biblStruct");
        for (int i = 0; i < bibList.getLength(); i++) {
            org.w3c.dom.Element biblStructElement = (org.w3c.dom.Element) bibList.item(i);
            
            // filter <biblStruct> not having as father <listBibl>
            org.w3c.dom.Node fatherNode = biblStructElement.getParentNode();
            if (fatherNode != null) {
                if (!"listBibl".equals(fatherNode.getNodeName()))
                    continue;
            }

            biblStructElements.add(biblStructElement);

            BiblioItem biblio = parseTEIBiblioItem(biblStructElement);
            BibDataSet bds = new BibDataSet();
            bds.setResBib(biblio);
            bds.setRefSymbol(biblStructElement.getAttribute("xml:id"));
            resCitations.add(bds);
        }

        try {
            Consolidation consolidator = Consolidation.getInstance();
            Map<Integer,BiblioItem> resConsolidation = consolidator.consolidate(resCitations);
            for(int i=0; i<resCitations.size(); i++) {
                BiblioItem resCitation = resCitations.get(i).getResBib();
                BiblioItem bibo = resConsolidation.get(i);
                if (bibo != null) {
                    if (consolidateReferences == 1)
                        BiblioItem.correct(resCitation, bibo);
                    else if (consolidateReferences == 2)
                        BiblioItem.injectIdentifiers(resCitation, bibo);
                }
            }
        } catch(Exception e) {
            LOGGER.error("An exception occured while running consolidation on bibliographical references.", e);
        } 

        // put back the consolidated information with the reference elements
        for(int i = 0; i < biblStructElements.size(); i++) {
            org.w3c.dom.Element biblStructElement = biblStructElements.get(i);
            BiblioItem resCitation = resCitations.get(i).getResBib();
            
            String valueKey = biblStructElement.getAttribute("xml:id");
            String valueType = biblStructElement.getAttribute("type");

            String teiCitation = resCitation.toTEI(4);

            org.w3c.dom.Element newBiblStructElement = null;
            try {
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                factory.setNamespaceAware(true);
                org.w3c.dom.Document d = factory.newDocumentBuilder().parse(new InputSource(new StringReader(teiCitation)));
                //d.getDocumentElement().normalize();
                newBiblStructElement = d.getDocumentElement();
                newBiblStructElement = (Element) doc.importNode(d.getDocumentElement(), true);

                if (valueKey != null && valueKey.length()>0) {
                    newBiblStructElement.setAttribute("xml:id", valueKey);
                }
                if (valueType != null && valueType.length()>0) {
                    newBiblStructElement.setAttribute("type", valueType);
                }

            } catch(Exception e) {
                LOGGER.error("Problem for structured reference TEI segment parsing", e);
            }

            if (newBiblStructElement != null) {
                biblStructElement.getParentNode().insertBefore(newBiblStructElement, biblStructElement);
                biblStructElement.getParentNode().removeChild(biblStructElement);
            }
        }
    }


}