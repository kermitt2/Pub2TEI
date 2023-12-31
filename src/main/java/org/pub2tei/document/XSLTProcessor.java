package org.pub2tei.document;

import org.pub2tei.service.ServiceConfiguration;

import java.io.*;
import net.sf.saxon.s9api.*;
import net.sf.saxon.lib.FeatureKeys;

import org.w3c.dom.Document;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.XMLFilterImpl;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.ErrorListener;
import javax.xml.transform.TransformerException;
import javax.xml.transform.SourceLocator;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.util.*;
import java.math.BigDecimal;
import java.net.URI;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A singleton XSLT processor using the Saxon XSLT and XQuery API.
 * Keep style sheet warm after loading them at class instance construction and support 
 * multithreaded transformations. 
 */
public class XSLTProcessor {
    private static final Logger LOGGER = LoggerFactory.getLogger(XSLTProcessor.class);
    
    private static volatile XSLTProcessor instance;

    private Processor proc;
    private XsltExecutable compiledStyleSheets;

    private ServiceConfiguration configuration;

    public static XSLTProcessor getInstance(ServiceConfiguration configuration) {
        if (instance == null) {
            synchronized (XSLTProcessor.class) {
                if (instance == null) {
                    getNewInstance(configuration);
                }
            }
        }
        return instance;
    }

    /**
     * Creates a new instance.
     */
    private static synchronized void getNewInstance(ServiceConfiguration configuration) {
        LOGGER.debug("Get new instance of XSLT Processor");
        instance = new XSLTProcessor(configuration);
    }

    /**
     * Hidden constructor
     */
    private XSLTProcessor(ServiceConfiguration configuration) {
        this.configuration = configuration;

        proc = new Processor(false);

        // avoid loading the DTD
        String featureName = FeatureKeys.XML_PARSER_FEATURE + "http%3A//apache.org/xml/features/nonvalidating/load-external-dtd";
        proc.setConfigurationProperty(featureName, false);
        //proc.setConfigurationProperty("http://saxon.sf.net/feature/parserFeature?uri=http%3A//apache.org/xml/features/nonvalidating/load-external-dtd", false);

        // do not validate input document
        proc.setConfigurationProperty(FeatureKeys.DTD_VALIDATION, false);
        proc.setConfigurationProperty(FeatureKeys.SCHEMA_VALIDATION, false);
        proc.setConfigurationProperty(FeatureKeys.XSLT_SCHEMA_AWARE, false);
        proc.setConfigurationProperty(FeatureKeys.XQUERY_SCHEMA_AWARE, false);

        proc.setConfigurationProperty(FeatureKeys.ALLOW_MULTITHREADING, true);
        proc.setConfigurationProperty(FeatureKeys.VALIDATION_WARNINGS, true);

        XsltCompiler comp = proc.newXsltCompiler();

        File xsltMainFile = new File(configuration.getStylesheetsPath() + File.separator + "Publishers.xsl"); 
        StreamSource xslSource = new StreamSource(xsltMainFile);

        // load XSLT style sheets
        //this.compiledStyleSheets = comp.compile(new StreamSource(new StringReader(stylesheet)));
        try {
            this.compiledStyleSheets = comp.compile(xslSource);
            // note: XsltExecutable is thread safe 
        } catch(SaxonApiException e) {
            LOGGER.error("Fail to load stylesheets", e);
        }
    }

    /**
     * XSLT transformation from Java String to String 
     **/
    public String transform(String input) {
        if (input == null || input.length() == 0) {
            LOGGER.error("Input string is empty");
            return null;
        }

        Serializer out = new Serializer();
        out.setOutputProperty(Serializer.Property.METHOD, "xml");
        out.setOutputProperty(Serializer.Property.INDENT, "yes");
        XsltTransformer t = compiledStyleSheets.load();
        // note: XsltTransformer is not thread safe, we have to create one per transformation and clean it

        StreamSource xmlSource = new StreamSource(new StringReader(input));
        StringWriter sw = new StringWriter();
        try {
            XdmNode source = this.proc.newDocumentBuilder().build(xmlSource);
            out.setOutputWriter(sw);
            t.setInitialContextNode(source);
            t.setDestination(out);
            t.transform();
        } catch(SaxonApiException e) {
            LOGGER.error("Fail to apply stylesheets", e);
        }

        return sw.toString();
    }

    /**
     * XSLT transformation from XML file to XML file 
     **/
    public void transform(File inputFile, File outputFile) {
        if (inputFile == null || !inputFile.exists() || inputFile.isDirectory()) {
            LOGGER.error("Input file is invalid");
            return;
        }

        if (outputFile == null) {
            LOGGER.error("Output file is invalid");
            return;
        }

        Serializer out = new Serializer();
        out.setOutputProperty(Serializer.Property.METHOD, "xml");
        out.setOutputProperty(Serializer.Property.INDENT, "yes");
        XsltTransformer t = compiledStyleSheets.load();
        // note: XsltTransformer is not thread safe, we have to create one per transformation and clean it

        try {
            XdmNode source = this.proc.newDocumentBuilder().build(new StreamSource(inputFile));
            out.setOutputFile(outputFile);
            t.setInitialContextNode(source);
            t.setDestination(out);
            t.transform();
        } catch(SaxonApiException e) {
            LOGGER.error("Fail to apply stylesheets", e);
        }
    }

    /**
     * XSLT transformation from XML file to string
     **/
    public String transform(File inputFile) {
        if (inputFile == null || !inputFile.exists() || inputFile.isDirectory()) {
            LOGGER.error("Input file is invalid");
            return null;
        }

        Serializer out = new Serializer();
        out.setOutputProperty(Serializer.Property.METHOD, "xml");
        out.setOutputProperty(Serializer.Property.INDENT, "yes");
        XsltTransformer t = compiledStyleSheets.load();
        // note: XsltTransformer is not thread safe, we have to create one per transformation and clean it

        StringWriter sw = new StringWriter();
        try {
            XdmNode source = this.proc.newDocumentBuilder().build(new StreamSource(inputFile));
            out.setOutputWriter(sw);
            t.setInitialContextNode(source);
            t.setDestination(out);
            t.transform();
        } catch(SaxonApiException e) {
            LOGGER.error("Fail to apply stylesheets", e);
        }

        return sw.toString();
    }


}

