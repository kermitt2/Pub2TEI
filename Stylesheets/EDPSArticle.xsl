<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>


    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="EDPSArticle">
        <xsl:variable name="localISSN">
            <xsl:value-of select="JournalID/PrintISSN"/>
        </xsl:variable>
        <xsl:variable name="journalDescription"
            select="$journalList/descendant::tei:row[tei:cell/text()=$localISSN]"/>

        <TEI xmlns:ce="http://www.elsevier.com/xml/common/dtd">
            <xsl:if test="ArticleID/Language">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="ArticleID/Language"/>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="ArticleTitle/Title"/>
                    </titleStmt>
                    <xsl:if test="CopyrightInformation">
                        <publicationStmt>
                            <xsl:apply-templates select="CopyrightInformation"/>
                        </publicationStmt>
                    </xsl:if>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="AuthorGroup/Author" mode="EDP"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="ArticleTitle/Title"/>
                            </analytic>
                            <monogr>
                                <xsl:choose>
                                    <xsl:when test="$journalDescription">
                                        <xsl:apply-templates
                                            select="$journalDescription/tei:cell[@role='Journal']"/>
                                        <xsl:message>Journal corrigé: <xsl:value-of
                                                select="$journalDescription/tei:cell[@role='Journal']"
                                            /></xsl:message>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="JournalID/JournalTitle"/>
                                        <xsl:apply-templates select="JournalID/JournalShortTitle"/>
                                        <xsl:message>Journal inconnu: <xsl:value-of
                                                select="Journal/JournalTitle"/></xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>

                                <xsl:apply-templates select="JournalID/JournalEDPSName"/>
                                <xsl:apply-templates select="JournalID/PrintISSN"/>
                                <xsl:apply-templates select="JournalID/ElectronicISSN"/>
                                <imprint>
                                    <xsl:apply-templates select="Journal/PublisherName"/>
                                    <xsl:apply-templates
                                        select=" IssueID/Volume | Journal/Issue| ArticleID/FirstPage| ArticleID/LastPage| Journal/elocation-id"/>
                                    <xsl:apply-templates
                                        select="ArticleID/ArticleHistory/StructuredArticleHistory/OnlineDate"
                                        mode="EDP"/>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="ArticleID/EDPSRef"/>
                            <xsl:apply-templates select="ArticleID/DOI"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="Language">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="Abstract"/>
						
                        <langUsage>
                            <language>
                                <xsl:attribute name="ident">
                                    <xsl:call-template name="Varia2ISO639">
                                        <xsl:with-param name="code" select="Language"/>
                                    </xsl:call-template>
                                </xsl:attribute>
                            </language>
                        </langUsage>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="History">
                    <xsl:apply-templates select="History"/>
                </xsl:if>
            </teiHeader>
			<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
            <!--text>
                <front>
                    <xsl:apply-templates select="Abstract"/>
                </front>
            </text-->
        </TEI>
    </xsl:template>

    <xsl:template match="History">
        <revisionDesc>
            <xsl:apply-templates/>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="History/PubDate">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="Day"/>
                    <xsl:with-param name="oldMonth" select="Month"/>
                    <xsl:with-param name="oldYear" select="Year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@PubStatus='received'">Received</xsl:when>
                <xsl:when test="@PubStatus='revised'">Revised</xsl:when>
                <xsl:when test="@PubStatus='accepted'">Accepted</xsl:when>
                <xsl:otherwise>unknown: <xsl:value-of select="@PubStatus"/></xsl:otherwise>
            </xsl:choose>
        </change>
    </xsl:template>


    <!-- Generic rules for IDs -->
    <xsl:template match="ArticleId">
        <idno type="{@IdType}">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="/EDPSArticle/AuthorGroup/Author" mode="EDP">
        <author>
            <xsl:if test="@corresp='yes'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <persName>
                <xsl:apply-templates select="AuthorName/StructuredAuthorName/*"/>
            </persName>
            <xsl:apply-templates select="AffiliationID"/>
        </author>
    </xsl:template>

    <xsl:template match="AffiliationID">
        <xsl:variable name="identifiant" select="@Label"/>
        <xsl:apply-templates select="/EDPSArticle/AuthorGroup/Affiliation[@ID=$identifiant]"/>
    </xsl:template>

    <xsl:template match="UnstructuredAffiliation">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="OnlineDate" mode="EDP">
        <date type="ePublished">
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="Day"/>
                    <xsl:with-param name="oldMonth" select="Month"/>
                    <xsl:with-param name="oldYear" select="Year"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <!-- Copyright related information to appear in <publicationStmt> -->
    <xsl:template match="CopyrightInformation">
        <availability>
            <p>
                <xsl:apply-templates/>
            </p>
        </availability>
    </xsl:template>

</xsl:stylesheet>
