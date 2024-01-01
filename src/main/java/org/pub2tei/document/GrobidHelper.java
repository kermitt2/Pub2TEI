package org.pub2tei.document;

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
import org.grobid.core.data.Date;
import org.grobid.core.data.Person;
import org.grobid.core.factory.GrobidPoolingFactory;
import org.grobid.core.factory.GrobidFactory;

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
                        rawStringToProcess.add(element.getTextContent());
                    }
                }
            }

            if (elementsToProcess.size()>0) {
                // process the raw affiliations 
                // note: TBD process in batch via processingLayoutTokens, for faster application of DL models
                Engine engine = null;
                try {
                    //engine = Engine.getEngine(true);
                    engine = GrobidFactory.getInstance().createEngine();
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
                    LOGGER.error("An unexpected exception occurs. ", e);
                } finally {
                    if (engine != null) {
                        //GrobidPoolingFactory.returnEngine(engine);
                        engine.close();
                    }
                }
            }
        } catch(Exception ex) {
            LOGGER.error("affiliation refinement failed", ex);
        } 
    }

    public static void refineReferences(org.w3c.dom.Document doc) {
        // look for bib ref elements and check if we have a raw value
    }

    public static void refineAuthors(org.w3c.dom.Document doc) {
        // look for author elements and check if we have a raw value
    }

    public static void refineDate(org.w3c.dom.Document doc) {
        // look for date elements and check if we have a raw value
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


}