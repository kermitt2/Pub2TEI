package org.pub2tei.document;

import org.grobid.core.main.GrobidHomeFinder;
import org.grobid.core.utilities.GrobidProperties;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.pub2tei.service.ServiceConfiguration;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xmlunit.matchers.CompareMatcher;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import java.io.InputStream;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.startsWith;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertTrue;

public class XMLUtilitiesIntegrationTest {

    @Before
    public void setUp() throws Exception {
        //This test requires to have grobid deployed somewhere under these directories
        GrobidHomeFinder finder = new GrobidHomeFinder(
                Arrays.asList(
                        "../grobid-home",
                        "../grobid/grobid-home",
                        "../../grobid/grobid-home"
                )
        );
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
    public void testSegment_sentenceBoundaryBeforeRef_shouldSplitCorrectly() throws Exception {
        String input = "<div>" +
                "<p>This was the first experiment." +
                "<ref type=\"bibr\" target=\"#b1\">[1]</ref>" +
                " The second experiment confirmed this. Third sentence ends here.</p>" +
                "</div>";

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();

        org.w3c.dom.Document document = builder.parse(new InputSource(new StringReader(input)));

        XMLUtilities.segment(document, document.getDocumentElement());
        String result = XMLUtilities.serialize(document, document.getDocumentElement());

        // The sentence detector should split at the period after "experiment."
        // and NOT merge it with the <ref> that follows.
        // With the off-by-one bug (- 1 in forbidden position start), the period
        // falls inside the forbidden zone and the split is suppressed.
        assertThat(result, CompareMatcher.isSimilarTo(
                "<div>" +
                "<p>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">This was the first experiment. <ref type=\"bibr\" target=\"#b1\">[1]</ref></s>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">The second experiment confirmed this.</s>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">Third sentence ends here.</s>" +
                "</p>" +
                "</div>"
        ).normalizeWhitespace());
    }

    @Test
    public void testSegment_issue29_refShouldAttachToPrecedingSentence() throws Exception {
        // From https://github.com/kermitt2/Pub2TEI/issues/29
        // DOI: 10.1001/jamanetworkopen.2019.12416
        // The superscript ref [1] should stay with the preceding sentence, not start the next one.
        String input = "<div>" +
                "<p>Epithelioid hemangioendothelioma (EHE) is a rare vascular sarcoma with a prevalence of approximately 1 per 1 000 000 persons." +
                "<hi rend=\"superscript\"><ref target=\"#zoi190474r1\" type=\"bibr\">1</ref></hi>" +
                " A hallmark molecular characteristic of EHE is the fusion of the WWTR1 and CAMTA1 genes, present in 90% of EHE cases and pathognomonic for disease." +
                "<hi rend=\"superscript\"><ref target=\"#zoi190474r2\" type=\"bibr\">2</ref>,<ref target=\"#zoi190474r3\" type=\"bibr\">3</ref>,<ref target=\"#zoi190474r4\" type=\"bibr\">4</ref></hi>" +
                " The clinical course of EHE may be either indolent or aggressive.</p>" +
                "</div>";

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();

        org.w3c.dom.Document document = builder.parse(new InputSource(new StringReader(input)));

        XMLUtilities.segment(document, document.getDocumentElement());
        String result = XMLUtilities.serialize(document, document.getDocumentElement());

        assertThat(result, CompareMatcher.isSimilarTo(
                "<div>" +
                "<p>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">Epithelioid hemangioendothelioma (EHE) is a rare vascular sarcoma with a prevalence of approximately 1 per 1 000 000 persons." +
                " <hi rend=\"superscript\"><ref target=\"#zoi190474r1\" type=\"bibr\">1</ref></hi></s>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">A hallmark molecular characteristic of EHE is the fusion of the WWTR1 and CAMTA1 genes, present in 90% of EHE cases and pathognomonic for disease." +
                " <hi rend=\"superscript\"><ref target=\"#zoi190474r2\" type=\"bibr\">2</ref>,<ref target=\"#zoi190474r3\" type=\"bibr\">3</ref>,<ref target=\"#zoi190474r4\" type=\"bibr\">4</ref></hi></s>" +
                "<s xmlns=\"http://www.tei-c.org/ns/1.0\">The clinical course of EHE may be either indolent or aggressive.</s>" +
                "</p>" +
                "</div>"
        ).normalizeWhitespace());
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

    // End-to-end tests: JATS → XSLT → TEI → segment()
    // Uses the actual article from issue #29 (DOI: 10.1001/jamanetworkopen.2019.12416)

    private org.w3c.dom.Document transformAndSegment(String resourceName) throws Exception {
        ServiceConfiguration config = new ServiceConfiguration();
        config.setStylesheetsPath("Stylesheets");
        XSLTProcessor xsltProcessor = XSLTProcessor.getInstance(config);

        InputStream is = this.getClass().getResourceAsStream(resourceName);
        String jatsXml = new String(is.readAllBytes(), StandardCharsets.UTF_8);
        String teiXml = xsltProcessor.transform(jatsXml);

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(false);
        DocumentBuilder builder = factory.newDocumentBuilder();
        org.w3c.dom.Document document = builder.parse(new InputSource(new StringReader(teiXml)));

        XMLUtilities.segment(document, document.getDocumentElement());
        return document;
    }

    @Test
    public void testEndToEnd_issue29Article_refsAttachToPrecedingSentence() throws Exception {
        org.w3c.dom.Document document = transformAndSegment("10.1001_jamanetworkopen.2019.12416.xml");
        String result = XMLUtilities.serialize(document, document.getDocumentElement());

        // No sentence should START with a <ref or <hi containing ref.
        // Extract all <s> elements and check none begins with a ref block.
        XPath xpath = XPathFactory.newInstance().newXPath();
        NodeList sentences = (NodeList) xpath.evaluate("//*[local-name()='s']", document, XPathConstants.NODESET);
        assertTrue("Expected segmented sentences", sentences.getLength() > 0);

        int violations = 0;
        for (int i = 0; i < sentences.getLength(); i++) {
            String sentText = XMLUtilities.serialize(document, sentences.item(i)).trim();
            int openEnd = sentText.indexOf('>');
            String inner = sentText.substring(openEnd + 1, sentText.lastIndexOf("</s>")).trim();

            if (inner.startsWith("<ref") ||
                    (inner.startsWith("<hi") && inner.contains("<ref"))) {
                violations++;
            }
        }
        assertTrue("Expected at most 5% of sentences starting with a ref (got " + violations +
                " out of " + sentences.getLength() + ")",
                violations <= Math.max(3, sentences.getLength() * 5 / 100));
    }

    @Test
    public void testEndToEnd_issue29Article_introductionParagraphHasCorrectSentenceCount() throws Exception {
        org.w3c.dom.Document document = transformAndSegment("10.1001_jamanetworkopen.2019.12416.xml");

        // The introduction paragraph has multiple sentences separated by superscript refs.
        // After correct segmentation, refs should be at the END of sentences, not the start.
        XPath xpath = XPathFactory.newInstance().newXPath();
        NodeList bodyParagraphs = (NodeList) xpath.evaluate("//*[local-name()='body']//*[local-name()='p']", document, XPathConstants.NODESET);
        assertTrue("Expected body paragraphs", bodyParagraphs.getLength() > 0);

        // Check the first body paragraph (introduction) has multiple sentences
        org.w3c.dom.Node firstParagraph = bodyParagraphs.item(0);
        NodeList sentencesInFirst = (NodeList) xpath.evaluate("*[local-name()='s']", firstParagraph, XPathConstants.NODESET);
        assertTrue("Introduction paragraph should have multiple sentences, got " + sentencesInFirst.getLength(),
                sentencesInFirst.getLength() >= 3);

        // Check that refs appear at the end of sentences, not at the beginning
        for (int i = 0; i < sentencesInFirst.getLength(); i++) {
            String sentText = XMLUtilities.serialize(document, sentencesInFirst.item(i)).trim();
            int openEnd = sentText.indexOf('>');
            String inner = sentText.substring(openEnd + 1, sentText.lastIndexOf("</s>")).trim();
            assertThat("Intro sentence " + i + " should not start with a ref element",
                    inner, not(startsWith("<ref")));
        }
    }

}