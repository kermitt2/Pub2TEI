<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (abstract), body, and back -->
    <!-- Le format de la RCS utilise essentiellement des composant NLM en ayant pris le soin (!) de définir ses propres constructions ici el là. -->
    <!-- On sent le travail visionaire du grouillot... -->
    <xsl:template match="article[art-admin]">
        <xsl:message>RoyalChemicalSociety.xsl</xsl:message>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="art-front/titlegrp/title"/>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <xsl:if test="//article/published[@type='print']|published[@type='book']/journalref/publisher/orgname/nameelt">
                            <publisher>
                                <xsl:value-of select="//article/published[@type='print']|published[@type='book']/journalref/publisher/orgname/nameelt"/>
                            </publisher>
                        </xsl:if>
                        <xsl:if test="//article/published[@type='print']|published[@type='book']/journalref/cpyrt">
                            <availability>
                                <p>
                                    <xsl:value-of select="//article/published[@type='print']|published[@type='book']/journalref/cpyrt"/>
                                </p>
                            </availability>
                        </xsl:if>
                        <xsl:if test="@price-code[string(.)='free']">
                            <availability status="free">
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
                    <xsl:choose>
                        <xsl:when test="normalize-space(art-body)">
                            <xsl:apply-templates select="art-body/*"/> 
                        </xsl:when>
                        <xsl:otherwise>
                            <div>
                               <p></p>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
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
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="art-front/titlegrp/*"/>
                <!-- All authors are included here -->
                <xsl:apply-templates select="art-front/authgrp/author"/>
                <xsl:apply-templates select="art-admin/doi"/>
                <xsl:apply-templates select="art-admin/ms-id"/>
            </analytic>
            <monogr>
                <xsl:choose>
                    <xsl:when test="//article/published[@type='print']/journalref/title[@type='full']">
                        <title level="j" type="main">
                            <xsl:value-of select="//article/published[@type='print']/journalref/title[@type='full']"/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article/published[@type='print']/journalref/title[@type='full']">
                        <title level="j" type="main">
                            <xsl:value-of select="//article/published[@type='print']/journalref/title[@type='full']"/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article/published[@type='print']/journalref/title">
                        <title level="j" type="main">
                            <xsl:value-of select="//article/published[@type='print']/journalref/title"/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article/published[@type='book']/journalref/title[@type='full']">
                        <title level="m" type="main">
                            <xsl:value-of select="//article/published[@type='book']/journalref/title[@type='full']"/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article/published[@type='book']/journalref/title[@type='full']">
                        <title level="m" type="main">
                            <xsl:value-of select="//article/published[@type='book']/journalref/title[@type='full']"/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article/published[@type='book']/journalref/title">
                        <title level="m" type="main">
                            <xsl:value-of select="//article/published[@type='book']/journalref/title"/>
                        </title>
                    </xsl:when>
                </xsl:choose>
                <xsl:if test="//article/published[@type='print']/journalref/title[@type='abbreviated']">
                    <title level="j" type="abbrev">
                        <xsl:value-of select="//article/published[@type='print']/journalref/title[@type='abbreviated']"/>
                    </title>
                </xsl:if>
                <xsl:if test="//article/published[@type='book']/journalref/title[@type='abbreviated']">
                    <title level="m" type="abbrev">
                        <xsl:value-of select="//article/published[@type='book']/journalref/title[@type='abbreviated']"/>
                    </title>
                </xsl:if>
                <xsl:if test="//article/published[@type='print']/journalref/sercode">
                    <idno type="sercode">
                        <xsl:value-of select="//article/published[@type='print']|published[@type='book']/journalref/sercode"/>
                    </idno>
                </xsl:if>
                <xsl:if test="//article/published[@type='book']/journalref/sercode">
                    <idno type="sercode">
                        <xsl:value-of select="//article/published[@type='book']/journalref/sercode"/>
                    </idno>
                </xsl:if>
                <xsl:if test="//article/published/journalref/issn">
                    <xsl:for-each select="//article/published/journalref/issn">
                    <idno>
                        <xsl:attribute name="type">
                        <xsl:choose>
                            <xsl:when test="//article/published/journalref/issn[@type='isbn']">ISBN</xsl:when>
                            <xsl:when test="//article/published/journalref/issn[@type='pissn']">pISSN</xsl:when>
                            <xsl:when test="//article/published/journalref/issn[@type='eissn']">eISSN</xsl:when>
                        </xsl:choose>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </idno>
                    </xsl:for-each>
                </xsl:if>
                <imprint>
                    <xsl:for-each select="article-meta/pub-date">
                        <xsl:message>Current: <xsl:value-of select="@pub-type"/></xsl:message>
                        <xsl:if test="year != '' and year !='0000'">
                            <xsl:message>Pubdate year: <xsl:value-of select="year"/></xsl:message>
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:apply-templates
                        select="published/volumeref | published/issueref 
                        | published/pubfront/fpage | published/pubfront/lpage|publisher/orgname/nameelt"
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
                <xsl:attribute name="role">
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

    <!--<xsl:template match="title-group/fn-group"/>-->

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="authgrp/aff">
        <affiliation>
            <xsl:apply-templates select="org/orgname/*"/>
            <xsl:apply-templates select="address"/>
            <xsl:apply-templates select="email"/>
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
            <xsl:if test="@type|no">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type|no"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*[starts-with(name(),'subsect')]">
        <div>
            <xsl:if test="@type|no">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type|no"/>
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
</xsl:stylesheet>
