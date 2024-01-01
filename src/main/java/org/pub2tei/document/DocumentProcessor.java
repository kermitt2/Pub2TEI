package org.pub2tei.document;

import java.io.*;
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 *
 * @author Patrice
 */
public class DocumentProcessor {

    private static final Logger LOGGER = LoggerFactory.getLogger(DocumentProcessor.class);

    private ServiceConfiguration configuration;

    private XSLTProcessor pub2TEIProcessor = null;

    public DocumentProcessor(ServiceConfiguration serviceConfiguration) {
        this.configuration = serviceConfiguration;
        this.pub2TEIProcessor= XSLTProcessor.getInstance(serviceConfiguration);
    }

    /**
     * Process a TEI XML format
     */
    public String processTEI(File file, boolean segmentSentences) throws IOException {
        String tei = null;
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            
            org.w3c.dom.Document document = builder.parse(file);
            
            // change useless abstract/p/div/p into abstract/div/p allowed by Grobid TEI customization
            XMLUtilities.fixAbstract(document);

            // fix for problematic attribute values
            XMLUtilities.fixDuplicatedXMLIDAndNCName(document);

            if (segmentSentences) {
                org.w3c.dom.Element root = document.getDocumentElement();
                XMLUtilities.segment(document, root);
            }

            tei = XMLUtilities.serialize(document, null);
            tei = XMLUtilities.reformatTEI(tei);

            //document.getDocumentElement().normalize();
            //tei = restoreDomParserAttributeBug(tei); 

        } catch (final Exception exp) {
            LOGGER.error("An error occured while processing the following XML file: " + file.getPath(), exp);
        } 

        return tei;
    }


    /**
     * Process a TEI XML format
     */
    public String processTEI(String tei, boolean segmentSentences) throws IOException {
        if (tei == null || tei.length() == 0)
            return null;
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(false);
            DocumentBuilder builder = factory.newDocumentBuilder();
            
            org.w3c.dom.Document document = builder.parse(new InputSource(new StringReader(tei))); 
            
            // change useless abstract/p/div/p into abstract/div/p allowed by Grobid TEI customization
            XMLUtilities.fixAbstract(document);

            // fix for problematic attribute values
            XMLUtilities.fixDuplicatedXMLIDAndNCName(document);

            if (segmentSentences) {
                org.w3c.dom.Element root = document.getDocumentElement();
                XMLUtilities.segment(document, root);
            }

            tei = XMLUtilities.serialize(document, null);
            tei = XMLUtilities.reformatTEI(tei);

            //document.getDocumentElement().normalize();
            //tei = restoreDomParserAttributeBug(tei); 

        } catch (final Exception exp) {
            LOGGER.error("An error occured while processing the tei document", exp);
        }

        return tei;
    }


    /**
     * Tranform an publisher XML document (for example JATS) to a TEI document using
     * Saxon API.
     * Transformation of the XML/JATS/NLM/etc document is realised thanks to compiled 
     * Pub2TEI stylesheets.
     * 
     * @return TEI string
     */

    public String processXML(File file, boolean segmentSentences) throws Exception {
        InputStream inputStream = null;
        
        try {
            inputStream = new FileInputStream(file);
        } catch(FileNotFoundException e) {
            LOGGER.error("Invalid input file: " + file.getAbsolutePath(), e);
        }

        return processXML(inputStream, segmentSentences);
    }

    public String processXML(InputStream inputStream, boolean segmentSentences) throws Exception {
        if (inputStream == null) 
            return null;

        String tei = null;
        try {
            tei = this.pub2TEIProcessor.transform(inputStream);
            tei = processTEI(tei, segmentSentences);
        } catch (final Exception exp) {
            LOGGER.error("An error occured while processing the XML input stream", exp);
        } 
        return tei;
    }

    /**
     * Tranform an publisher XML document (for example JATS) to a TEI document with a
     * command line. 
     * 
     * ** This should not be used, except for test and benchmarking. **
     * 
     * Transformation of the XML/JATS/NLM/etc. document is realised thanks to Pub2TEI 
     * stylesheets
     * 
     * @return TEI string
     */
    public String processXMLCommandLine(File file) throws Exception {
        String fileName = file.getName();
        String tei = null;
        String newFilePath = null;
        try {
            String tmpFilePath = this.configuration.getTmpPath();
            newFilePath = XMLUtilities.applyPub2TEI(file.getAbsolutePath(), 
                tmpFilePath + "/" + fileName.replace(".xml", ".tei.xml"), 
                this.configuration.getStylesheetsPath());
            //System.out.println(newFilePath);

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            tei = FileUtils.readFileToString(new File(newFilePath), UTF_8);

        } catch (final Exception exp) {
            LOGGER.error("An error occured while processing the following XML file: " + file.getAbsolutePath(), exp);
        } finally {
            if (newFilePath != null) {
                File newFile = new File(newFilePath);
                IOUtilities.removeTempFile(newFile);
            }
        }
        return tei;
    }

    public int processDirectory(final MainArgs pGbdArgs) {
        int nbFiles = 0;
        this.inferInputPath(pGbdArgs);
        this.inferOutputPath(pGbdArgs);

        final File pdfDirectory = new File(pGbdArgs.getPath2Input());
        File[] files = pdfDirectory.listFiles();

        return nbFiles;
    }

    /**
     * Infer the input path for pdfs if not given in arguments.
     *
     * @param pGbdArgs The Args.
     */
    protected final static void inferInputPath(final MainArgs pGbdArgs) {
        String tmpFilePath;
        if (pGbdArgs.getPath2Input() == null) {
            tmpFilePath = new File(".").getAbsolutePath();
            LOGGER.info("No path set for the input directory. Using: " + tmpFilePath);
            pGbdArgs.setPath2Input(tmpFilePath);
        }
    }

    /**
     * Infer the output path if not given in arguments.
     *
     * @param pGbdArgs The Args.
     */
    protected final static void inferOutputPath(final MainArgs pGbdArgs) {
        String tmpFilePath;
        if (pGbdArgs.getPath2Output() == null) {
            tmpFilePath = new File(".").getAbsolutePath();
            LOGGER.info("No path set for the output directory. Using: " + tmpFilePath);
            pGbdArgs.setPath2Output(tmpFilePath);
        }
    }


}