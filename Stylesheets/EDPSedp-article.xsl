<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>


    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="edp-article">
        <xsl:variable name="localISSN">
            <xsl:value-of select="journal-id/issn-paper"/>
        </xsl:variable>
        <xsl:variable name="journalDescription"
            select="$journalList/descendant::tei:row[tei:cell/text()=$localISSN]"/>

        <TEI>
            <xsl:if test="article-id/language">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="article-id/language"/>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="article-title/title"/>
                    </titleStmt>
<!--                    <xsl:if test="article-id/copyright">
                        <publicationStmt>
                            <xsl:apply-templates select="article-id/copyright"/>
                        </publicationStmt>
                    </xsl:if>-->
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="author" mode="EDP"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="article-title/title"/>
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
                                        <xsl:apply-templates select="journal-id/j-title"/>
                                        <xsl:apply-templates select="journal-id/j-shorttitle"/>
                                        <xsl:message>Journal inconnu: <xsl:value-of
                                                select="journal-id/j-title"/></xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>

                                <xsl:apply-templates select="journal-id/j-edpsname"/>
                                <xsl:apply-templates select="journal-id/issn-paper"/>
                                <xsl:apply-templates select="journal-id/issn-elec"/>
                                <imprint>
                                    <xsl:apply-templates select="Journal/PublisherName"/>
                                    <xsl:apply-templates
                                        select=" issu-id/volume | issu-id/issue | article-id/first-page| article-id/last-page| Journal/elocation-id"/>
                                    <xsl:apply-templates
                                        select="article-id/dateonline"
                                        mode="EDP"/>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="article-id/edps-ref"/>
                            <xsl:apply-templates select="article-id/doi"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="Language">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="abstract"/>
						
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
                    <xsl:apply-templates select="abstract"/>
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

    <xsl:template match="/edp-article/author" mode="EDP">
        <author>
            <xsl:if test="@corresp='yes'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <persName>
                <xsl:call-template name="parseEDPAuthorName">
                    <xsl:with-param name="theName" select="author-name"/>
                </xsl:call-template>
            </persName>
            <xsl:choose>
                <xsl:when test=" contains(address,';')">
                    <affiliation>
                        <xsl:call-template name="parseEDPAffiliation">
                            <xsl:with-param name="theAffiliation"
                                select=" substring-before(address,';')"/>
                            <xsl:with-param name="count" select="0"/>
                        </xsl:call-template>
                    </affiliation>
                    <email>
                        <xsl:value-of select="substring-after(address,';')"/>
                    </email>
                </xsl:when>
                <xsl:otherwise>
                    <affiliation>
                        <xsl:call-template name="parseEDPAffiliation">
                            <xsl:with-param name="theAffiliation" select="address"/>
                            <xsl:with-param name="count" select="0"/>
                        </xsl:call-template>
                    </affiliation>
                </xsl:otherwise>
            </xsl:choose>
        </author>
    </xsl:template>

    <xsl:template name="parseEDPAuthorName">
        <xsl:param name="theName"/>
        <xsl:choose>
            <xsl:when test=" contains($theName,' ')">
                <forename>
                    <xsl:value-of select="substring-before($theName,' ')"/>
                </forename>
                <xsl:call-template name="parseEDPAuthorName">
                    <xsl:with-param name="theName" select="substring-after($theName,' ')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <surname>
                    <xsl:value-of select="normalize-space($theName)"/>
                </surname>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="parseEDPAffiliation">
        <xsl:param name="theAffiliation"/>
        <xsl:param name="count"/>
        <xsl:choose>
            <xsl:when test=" contains($theAffiliation,',')">
                <xsl:choose>
                    <xsl:when test="$count=0">
                        <orgName type="department">
                            <xsl:value-of select="normalize-space(substring-before($theAffiliation,','))"/>
                        </orgName>
                        <xsl:call-template name="parseEDPAffiliation">
                            <xsl:with-param name="theAffiliation"
                                select="substring-after($theAffiliation,',')"/>
                            <xsl:with-param name="count" select="1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$count=1">
                        <orgName type="institution">
                            <xsl:value-of select="normalize-space(substring-before($theAffiliation,','))"/>
                        </orgName>
                        <address>
                        <xsl:call-template name="parseEDPAffiliation">
                            <xsl:with-param name="theAffiliation" select="substring-after($theAffiliation,',')"/>
                            <xsl:with-param name="count" select="2"/>
                        </xsl:call-template>
                        </address>
                    </xsl:when>
                    <xsl:otherwise>
                        <addrLine>
                            <xsl:value-of select="normalize-space(substring-before($theAffiliation,','))"/>
                        </addrLine>
                        <xsl:call-template name="parseEDPAffiliation">
                            <xsl:with-param name="theAffiliation"
                                select="substring-after($theAffiliation,',')"/>
                            <xsl:with-param name="count" select="2"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="cleanCountry">
                    <xsl:choose>
                        <xsl:when test=" contains($theAffiliation,'.')">
                            <xsl:value-of select="normalize-space(substring-before($theAffiliation,'.'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space($theAffiliation)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <country>
                    <xsl:attribute name="key">
                        <xsl:call-template name="normalizeISOCountry">
                            <xsl:with-param name="country" select="$cleanCountry"/>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="normalizeISOCountryName">
                        <xsl:with-param name="country" select="$cleanCountry"/>
                    </xsl:call-template>
                </country>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="AffiliationID">
        <xsl:variable name="identifiant" select="@Label"/>
        <xsl:apply-templates select="/EDPSArticle/AuthorGroup/Affiliation[@ID=$identifiant]"/>
    </xsl:template>

    <xsl:template match="UnstructuredAffiliation">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="dateonline" mode="EDP">
        <date type="ePublished">
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="substring-before(.,' ')"/>
                    <xsl:with-param name="oldMonth" select="substring-before( substring-after(.,' '),' ')"/>
                    <xsl:with-param name="oldYear" select="substring-after(substring-after(.,' '),' ')"/>
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
