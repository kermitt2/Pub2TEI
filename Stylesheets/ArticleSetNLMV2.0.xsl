<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="ArticleSet">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="Article">
        <!--        <xsl:variable name="localISSN">
            <xsl:value-of select="Journal/Issn"/>
        </xsl:variable>
        <xsl:variable name="journalDescription"
            select="$journalList/descendant::tei:row[tei:cell/text()=$localISSN]"/>-->

        <TEI>
            <xsl:if test="Language">
                <xsl:attribute name="xml:lang">
                    <xsl:choose>
                        <xsl:when test="Language='EN'">en</xsl:when>
                        <xsl:otherwise>en</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="ArticleTitle"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:if test="CopyrightInformation">
                            <xsl:apply-templates select="CopyrightInformation"/>
                        </xsl:if>
                        <xsl:if test="OpenAccess[string(.)='True']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="AuthorList/*"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="ArticleTitle"/>
                            </analytic>
                            <monogr>

                                <!--<xsl:when test="$journalDescription">
                                        <xsl:apply-templates
                                            select="$journalDescription/tei:cell[@role='Journal']"/>
                                        <xsl:message>Journal corrigé: <xsl:value-of
                                                select="$journalDescription/tei:cell[@role='Journal']"
                                            /></xsl:message>
                                    </xsl:when>-->

                                <xsl:apply-templates select="Journal/JournalTitle"/>
                                <xsl:apply-templates select="Journal/journal-id"/>
                                <xsl:apply-templates select="Journal/Issn"/>
                                <imprint>
                                    <xsl:apply-templates select="Journal/PublisherName"/>
                                    <xsl:apply-templates
                                        select="Journal/PubDate | Journal/Volume | Journal/Issue| FirstPage| LastPage| Journal/elocation-id"
                                    />
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="ArticleIdList/*"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="Language | Abstract">
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
                <xsl:when test="@PubStatus='epublish'">ePublished</xsl:when>
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

    <xsl:template match="Author">
        <author>
            <xsl:if
                test="@corresp='yes' or (Affiliation and not(preceding-sibling::Author/Affiliation))">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <persName>
                <xsl:apply-templates select="*[name() != 'Affiliation']"/>
            </persName>
            <xsl:apply-templates select="Affiliation"/>
            <xsl:apply-templates select="Affiliation/Email"/>
        </author>
    </xsl:template>

    <xsl:template match="/ArticleSet//Affiliation">
        <xsl:message>Affiliation</xsl:message>
        <affiliation>
            <xsl:if test="Department">
                <xsl:apply-templates select="Department"/>
            </xsl:if>
            <xsl:if test="Institution">
                <xsl:apply-templates select="Institution"/>
            </xsl:if>
            <address>
                  <xsl:apply-templates select="*[name() != 'Email' and name() != 'Department' and name() != 'Institution'] | text()"/>
                </address>
        </affiliation>
    </xsl:template>

    <xsl:template match="PubDate">
        <date>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="@PubStatus='epublish'">ePublished</xsl:when>
                    <xsl:otherwise>Published</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
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
