package org.pub2tei.document;

import org.grobid.core.main.GrobidHomeFinder;
import org.grobid.core.utilities.GrobidProperties;
import org.junit.Before;
import org.junit.Test;
import org.xml.sax.InputSource;
import org.xmlunit.matchers.CompareMatcher;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;
import java.io.StringReader;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;

public class XMLUtilitiesIntegrationTest {

    @Before
    public void setUp() throws Exception {
        //This test requires to have grobid deployed somewhere under these directories
        GrobidHomeFinder finder = new GrobidHomeFinder(List.of("../grobid-home", "../../grobid/grobid-home"));
        GrobidProperties.getInstance(finder);
    }

    @Test
    public void testSegment_chunk_shouldInjectSegmentCorrectly() throws Exception {
        String input = "<div type=\"acknowledgement\">" +
                "<div xmlns=\"http://www.tei-c.org/ns/1.0\">" +
                "<head>Acknowledgements</head>" +
                "<p>Our warmest thanks to Patrice Lopez, the author of Grobid <ref type=\"bibr\" target=\"#b21\">[22]</ref>, DeLFT <ref type=\"bibr\" target=\"#b19\">[20]</ref>, and other open-source projects for his continuous support and inspiration with ideas, suggestions, and fruitful discussions. We thank Pedro Baptista de Castro for his support during this work. Special thanks to Erina Fujita for useful tips on the manuscript.</p>" +
                "</div>" +
                "</div>";

        String expected = "<div type=\"acknowledgement\">\n" +
                "\t<div xmlns=\"http://www.tei-c.org/ns/1.0\">\n" +
                "\t\t<head>Acknowledgements</head>\n" +
                "\t\t<p>\n" +
                "\t\t\t<s>Our warmest thanks to Patrice Lopez, the author of Grobid <ref type=\"bibr\" target=\"#b21\">[22]</ref>, DeLFT <ref type=\"bibr\" target=\"#b19\">[20]</ref>, and other open-source projects for his continuous support and inspiration with ideas, suggestions, and fruitful discussions.</s>\n" +
                "\t\t\t<s>We thank Pedro Baptista de Castro for his support during this work.</s>\n" +
                "\t\t\t<s>Special thanks to Erina Fujita for useful tips on the manuscript.</s>\n" +
                "\t\t</p>\n" +
                "\t</div>\n" +
                "</div>";


        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();

        org.w3c.dom.Document document = builder.parse(new InputSource(new StringReader(input)));

        XMLUtilities.segment(document, document.getDocumentElement());

        assertThat(XMLUtilities.serialize(document, document.getDocumentElement()), CompareMatcher.isIdenticalTo(expected.replace("\t","   ")));
    }


    @Test
    public void testSegment_document1_shouldInjectSegmentCorrectly() throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();

        InputStream resourceAsStream = this.getClass().getResourceAsStream("document1.tei.xml");
        org.w3c.dom.Document document = builder.parse(new InputSource(resourceAsStream));

        InputStream resourceAsStreamSegmented = this.getClass().getResourceAsStream("document1.tei.xml");
        org.w3c.dom.Document documentSegmented = builder.parse(new InputSource(resourceAsStreamSegmented));

        XMLUtilities.segment(document, document.getDocumentElement());
        String documentResult = XMLUtilities.serialize(document, document.getDocumentElement());
        String documentExpected = XMLUtilities.serialize(documentSegmented, document.getDocumentElement());
        assertThat(documentResult, CompareMatcher.isIdenticalTo(documentExpected));
    }

    @Test
    public void testSegment_document2_shouldInjectSegmentCorrectly() throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();

        InputStream resourceAsStream = this.getClass().getResourceAsStream("document2.tei.xml");
        org.w3c.dom.Document document = builder.parse(new InputSource(resourceAsStream));

        InputStream resourceAsStreamSegmented = this.getClass().getResourceAsStream("document2.segmented.tei.xml");
        org.w3c.dom.Document documentSegmented = builder.parse(new InputSource(resourceAsStreamSegmented));

        XMLUtilities.segment(document, document.getDocumentElement());
        String documentResult = XMLUtilities.serialize(document, document.getDocumentElement());
        String documentExpected = XMLUtilities.serialize(documentSegmented, document.getDocumentElement());
        assertThat(documentResult, CompareMatcher.isIdenticalTo(documentExpected));
    }

}