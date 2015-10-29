<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="SAGEmeta">
        <TEI xmlns:ce="http://www.elsevier.com/xml/common/dtd">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="header/art_info/art_title"/>
                    </titleStmt>
                    <publicationStmt>
                        <availability status="free">
                            <p>Status generated automatically by the PEER depot.</p>
                        </availability>
                    </publicationStmt>
                    <sourceDesc>
                        <biblStruct type="article">
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="header/art_info/art_author/*"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="header/art_info/art_title"/>
                            </analytic>
                            <monogr>
                                <xsl:apply-templates select="header/jrn_info/jrn_title"/>
                                <xsl:apply-templates select="header/jrn_info/ISSN"/>
                                <imprint>
                                    <xsl:apply-templates select="header/jrn_info/pub_info/pub_name"/>
                                    <xsl:apply-templates
                                        select="header/jrn_info/pub_info/pub_location"/>

                                    <xsl:apply-templates
                                        select="header/jrn_info/date | header/jrn_info/vol | header/jrn_info/iss| header/art_info/spn | header/art_info/epn"
                                    />
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="@doi"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="body/keywords">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="body/abstract"/>
						
                        <xsl:apply-templates select="body/keywords"/>
                    </profileDesc>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="body/abstract"/>
                </front-->
                <body>
                    <xsl:apply-templates select="body/*[name()!='keywords' and name()!='abstract']"
                    />
                </body>
                <xsl:if test="note">
                    <back>
                        <div type="notes">
                            <xsl:apply-templates select="note/*"/>
                        </div>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>

    <xsl:template match="note/p">
        <note>
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <!-- We do not care about components from <article-meta> which have 
    not been explicitely addressed -->
    <xsl:template match="article-meta"/>


    <xsl:template match="full_text">
        <div type="fullText">
            <head>Full text</head>
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>

    <!-- Inline affiliation -->
    <xsl:template match="affil">
        <xsl:choose>
            <xsl:when test="not(contains(.,','))">
                <affiliation>
                    <xsl:apply-templates/>
                </affiliation>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <orgName type="department">
                        <xsl:value-of select="normalize-space(substring-before(.,','))"/>
                    </orgName>
                    <orgName type="institution">
                        <xsl:value-of select="normalize-space(substring-after(.,','))"/>
                    </orgName>
                </affiliation>
                <xsl:if test="eml">
                    <xsl:apply-templates select="eml"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>


    </xsl:template>

    <xsl:template match="author-comment">
        <note type="author-comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Fin de la bibliographie -->

    <xsl:template match="per_aut">
        <author>
            <xsl:if test="position()=1">
                <xsl:attribute name="type">corresp</xsl:attribute>
            </xsl:if>
            <persName>
                <xsl:apply-templates select="fn | mn | ln"/>
            </persName>
            <xsl:apply-templates
                select="*[not(name() = 'fn') and not(name() = 'mn') and not(name() = 'ln')]"/>
        </author>
    </xsl:template>

    <xsl:template match="jrn_info/date">
        <date type="Published">
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="dd"/>
                    <xsl:with-param name="oldMonth" select="mm"/>
                    <xsl:with-param name="oldYear" select="yy"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

</xsl:stylesheet>
