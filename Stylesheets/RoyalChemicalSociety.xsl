<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML">
    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (abstract), body, and back -->
    <xsl:template match="article[art-admin]">
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
                        <xsl:apply-templates select="front/article-meta/kwd-group"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="toBeCompleted">
                    <xsl:apply-templates select="front/article-meta/history"/>
                </xsl:if>
            </teiHeader>
            <text>
                <front>
                    <xsl:apply-templates select="art-front/abstract"/>
                </front>
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


    <!-- Lists -->

    <xsl:template match="list">
        <list>
            <xsl:if test="@list-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@list-type"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:if>
        </list>
    </xsl:template>

    <xsl:template match="list-item">
        <item>
            <xsl:apply-templates/>
        </item>
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

    <xsl:template match="graphic">
        <graphic>
            <xsl:attribute name="url">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
        </graphic>
    </xsl:template>

    <!-- Tables -->
    <xsl:template match="table-entry">
        <figure type="table">
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="table-entry/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="table-wrap-foot">
        <ab type="table-wrap-foot">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>

    <xsl:template match="table-wrap-foot/fn">
        <note place="inline">
            <xsl:if test="@fn-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@fn-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="thead/tr">
        <row role="label">
            <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="thead">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tbody">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="table-entry/table">
        <ab>
            <table>
                <xsl:apply-templates/>
            </table>
        </ab>
    </xsl:template>

    <xsl:template match="array">
        <ab type="array">
            <table>
                <xsl:apply-templates/>
            </table>
        </ab>
    </xsl:template>

    <xsl:template match="tr">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="th">
        <cell role="th">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>

    <xsl:template match="td">
        <cell role="td">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>

    <xsl:template match="hr">
        <milestone unit="hr"/>
    </xsl:template>


    <xsl:template match="back/fn-group">
        <div type="fn-group">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="fn-group/fn">
        <note place="inline">
            <xsl:if test="@fn-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@fn-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="fn/label">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- References in main text -->
    <xsl:template match="xref">
        <ref>
            <xsl:attribute name="type">
                <xsl:value-of select="@ref-type"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="ext-link">
        <ref>
            <xsl:attribute name="type">
                <xsl:value-of select="@ext-link-type"/>
            </xsl:attribute>

            <xsl:attribute name="target">
                <xsl:choose>
                    <xsl:when test="@xlink:href">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="supplementary-material">
        <ref>
            <xsl:attribute name="type"> supplementary-material </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- Copyright related information to appear in <publicationStmt> -->
    <xsl:template match="copyright-statement">
        <availability>
            <p>
                <xsl:apply-templates/>
            </p>
        </availability>
    </xsl:template>


    <xsl:template match="title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>


    <xsl:template match="pub-date">
        <date>
            <xsl:choose>
                <xsl:when test="@pub-type='epub'">
                    <xsl:attribute name="type">ePublished</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type">Published</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <!-- Revision information -->
    <xsl:template match="history">
        <revisionDesc>
            <xsl:apply-templates/>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="date[@date-type='received']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="date[@date-type='rev-recd']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Revised</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="date[@date-type='accepted']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Accepted</xsl:text>
        </change>
    </xsl:template>

</xsl:stylesheet>
