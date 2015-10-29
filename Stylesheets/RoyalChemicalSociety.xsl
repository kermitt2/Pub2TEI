<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (abstract), body, and back -->
    <!-- Le format de la RCS utilise essentiellement des composant NLM en ayant pris le soin (!) de définir ses propres constructions ici el là. -->
    <!-- On sent le travail visionaire du grouillot... -->
    <xsl:template match="article[art-admin]">
        <xsl:message>RoyalChemicalSociety.xsl</xsl:message>
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="art-front/titlegrp/title"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:if test="@price-code[string(.)='free']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="." mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="toBeCompleted">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="art-front/abstract"/>
						
                        <xsl:apply-templates select="front/article-meta/kwd-group"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="toBeCompleted">
                    <xsl:apply-templates select="front/article-meta/history"/>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="art-front/abstract"/>
                </front-->
                <body>
                    <xsl:apply-templates select="art-body/*"/>
                </body>
                <back>
                    <xsl:apply-templates select="art-back/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->


    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="article[art-admin]" mode="sourceDesc">
        <biblStruct>
            <xsl:variable name="articleType" select="@type"/>
            <xsl:if test="$articleType != ''">
                <xsl:choose>
                    <xsl:when test="$articleType='ART'">
                        <xsl:attribute name="type">article</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='review-article'">
                        <xsl:attribute name="type">article</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='correction'">
                        <xsl:attribute name="type">erratum</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='other'">
                        <xsl:attribute name="type">other</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='book-review'">
                        <xsl:attribute name="type">bookReview</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='books-received'">
                        <xsl:attribute name="type">booksReceived</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='EDI'">
                        <xsl:attribute name="type">editorial</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='brief-report'">
                        <xsl:attribute name="type">briefReport</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='LET'">
                        <xsl:attribute name="type">letter</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="no">Article-type inconnu: <xsl:value-of
                                select="$articleType"/></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>


            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="art-front/authgrp/author"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="art-front/titlegrp/*"/>
            </analytic>
            <monogr>
                <title level="j" type="main">Royal Chemical Society</title>
                <imprint>
                    <xsl:for-each select="article-meta/pub-date">
                        <xsl:message>Current: <xsl:value-of select="@pub-type"/></xsl:message>
                        <xsl:if test="year != '' and year !='0000'">
                            <xsl:message>Pubdate year: <xsl:value-of select="year"/></xsl:message>
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>

                    <xsl:apply-templates
                        select="published[@type='print']/volumeref | published[@type='print']/issueref 
                        | published[@type='print']/pubfront/fpage | published[@type='print']/pubfront/lpage"
                    />
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>

    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="/article/art-front/authgrp/author">
        <author>
            <xsl:if test="@role='corres'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="person/*"/>
            <xsl:apply-templates select="footnote"/>
            <xsl:if test="@aff">
                <xsl:variable name="affID" select="@aff"/>
                <xsl:apply-templates select="//aff[@id=$affID]"/>
            </xsl:if>
        </author>
    </xsl:template>

    <!-- Specific to RCS: references to compound -->

    <xsl:template match="compoundref">
        <ref type="compound">
            <xsl:apply-templates/>
        </ref>
    </xsl:template>


    <xsl:template match="aff/address">
        <address>
            <xsl:apply-templates/>
        </address>
    </xsl:template>
    
    <!-- What is below has not been checked... -->
    

    <xsl:template match="dateStruct">
        <date>
            <xsl:value-of select="."/>
        </date>
    </xsl:template>

    <xsl:template match="title-group/fn-group"/>

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="authgrp/aff">
        <affiliation>
            <xsl:apply-templates select="org/orgname/*"/>
            <xsl:apply-templates select="address"/>
        </affiliation>
    </xsl:template>

    <!-- Treating organisation names -->

    <xsl:template match="nameelt">
        <xsl:variable name="organisation">
            <xsl:call-template name="identifyOrgLevel">
                <xsl:with-param name="theOrg">
                    <xsl:value-of select="."/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <orgName>
            <xsl:attribute name="type">
                <xsl:value-of select="$organisation"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </orgName>
    </xsl:template>


    <!-- Macrostructure of main body if the text -->
    <xsl:template match="section">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*[starts-with(name(),'subsect')]">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template
        match="section/title | subsect1/title | subsect1/title | subsect2/title | subsect3/title | subsect4/title | subsect5/title | subsect6/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <!-- Figures (RCS OK) -->
    <xsl:template match="figure">
        <figure>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="figure/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>


</xsl:stylesheet>
