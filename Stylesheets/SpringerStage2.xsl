<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="Publisher">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="Article[ArticleInfo]">
        <!--xsl:comment>
            <xsl:text>Version 0.1 generated on </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment-->
        <TEI>
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:text>https://raw.githubusercontent.com/kermitt2/grobid/master/grobid-home/schemas/xsd/Grobid.xsd</xsl:text>
            </xsl:attribute>
            <xsl:if test="ArticleInfo/@Language">
                <xsl:attribute name="xml:lang">
                    <xsl:call-template name="Varia2ISO639">
                        <xsl:with-param name="code" select="ArticleInfo/@Language"/>
                    </xsl:call-template>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:for-each select="ArticleInfo/ArticleTitle">
                            <xsl:if test="not(contains(.,'? Titel ?'))">
                                <xsl:apply-templates select="."/>
                            </xsl:if>
                        </xsl:for-each>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:apply-templates select="ArticleInfo/ArticleCopyright"/>
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="ArticleInfo" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="ArticleHeader/KeywordGroup">
                    <profileDesc>
						<!-- PL: abstract is moved here from <front> -->
						<xsl:apply-templates select="ArticleHeader/Abstract"/>
						
                        <xsl:apply-templates select="ArticleHeader/KeywordGroup"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="ArticleInfo/ArticleHistory">
                    <xsl:apply-templates select="ArticleInfo/ArticleHistory"/>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="ArticleHeader/Abstract"/>
                </front-->
                <xsl:choose>
                    <xsl:when test="Body/*">
                        <body>
                            <xsl:apply-templates select="Body/*"/>
                        </body>
                    </xsl:when>
                    <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                        <body>
                            <div>
                                <p><xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/></p>
                            </div>
                        </body>
                    </xsl:when>
                </xsl:choose>
                <back>
                    <xsl:apply-templates select="ArticleBackmatter/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="ArticleInfo" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="../ArticleHeader/AuthorGroup/Author"/>
                <!-- Title information related to the paper goes here -->
                <xsl:for-each select="ArticleTitle">
                    <xsl:if test="not(contains(.,'? Titel ?'))">
                        <xsl:apply-templates select="."/>
                    </xsl:if>
                </xsl:for-each>
            </analytic>
            <monogr>
                <xsl:apply-templates select="journal-meta/journal-title"/>
                <xsl:apply-templates select="journal-meta/journal-id"/>
                <xsl:apply-templates select="JournalPrintISSN"/>
                <imprint>
                    <xsl:apply-templates select="journal-meta/publisher/*"/>
                    <xsl:if test="ArticleHistory/OnlineDate and ArticleHistory/OnlineDate!=''">
                        <xsl:apply-templates select="ArticleHistory/OnlineDate" mode="inImprint"/>
                    </xsl:if>
                    <xsl:apply-templates select="ArticleFirstPage | ArticleLastPage"/>
                </imprint>
            </monogr>
            <xsl:apply-templates select="ArticleDOI"/>
            <xsl:apply-templates select="/Article/@ID"/>
            <xsl:apply-templates select="ArticleID"/>
        </biblStruct>
    </xsl:template>

</xsl:stylesheet>
