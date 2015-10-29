<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="#all">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec. 2008</xd:p>
            <xd:p><xd:b>Author:</xd:b> Laurent Romary</xd:p>
            <xd:p>for the PEER project</xd:p>
            <xd:p>Available under creative commons CC-BY licence.</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="article[front]">
        <xsl:message>NLM2TEI-article.xsl</xsl:message>
        <TEI>
            <xsl:if test="@xml:lang">
                <xsl:copy-of select="@xml:lang"/>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="front/article-meta/title-group/article-title"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:apply-templates select="front/journal-meta/publisher/*"/>
                        <xsl:apply-templates select="front/article-meta/permissions/*"/>
                        <xsl:if test="not(front/article-meta/permissions)">
                            <xsl:apply-templates select="front/article-meta/copyright-statement"/>
                            <xsl:apply-templates select="front/article-meta/copyright-year"/>
                        </xsl:if>
                        <xsl:if
                            test="front/article-meta/custom-meta-wrap/custom-meta[string(meta-name)='unlocked' and string(meta-value)='Yes']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                        <xsl:if test="front/article-meta/open-access[string(.)='YES']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="front" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="front/article-meta/kwd-group">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
		                <xsl:if test="front/article-meta/abstract">
		                    <front>
		                        <xsl:apply-templates select="front/article-meta/abstract"/>
		                    </front>
		                </xsl:if>
						
                        <xsl:apply-templates select="front/article-meta/kwd-group"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="front/article-meta/history">
                    <xsl:apply-templates select="front/article-meta/history"/>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--xsl:if test="front/article-meta/abstract">
                    <front>
                        <xsl:apply-templates select="front/article-meta/abstract"/>
                    </front>
                </xsl:if-->
                <!-- No test if made for body since it is considered a mandatory element -->
                <body>
                    <xsl:apply-templates select="body/*"/>
                </body>
                <xsl:if test="back">
                    <back>
                        <xsl:apply-templates select="back/*"/>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>

   <!-- We do not care about components from <article-meta> which are 
    not explicitely addressed by means of an XPath in another template-->
    <xsl:template match="article-meta"/>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="front" mode="sourceDesc">
        <biblStruct>
            <xsl:variable name="articleType" select="/article/@article-type"/>
            <xsl:if test="$articleType != ''">
                <xsl:choose>
                    <xsl:when test="$articleType='research-article'">
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
                    <xsl:when test="$articleType='editorial'">
                        <xsl:attribute name="type">editorial</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='brief-report'">
                        <xsl:attribute name="type">briefReport</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType='letter'">
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
                <xsl:apply-templates select="article-meta/contrib-group/*[name()!='aff']"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="article-meta/title-group/*"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="journal-meta/journal-title"/>
                <xsl:apply-templates select="journal-meta/journal-id"/>
                <xsl:apply-templates select="journal-meta/abbrev-journal-title"/>
                <xsl:apply-templates select="journal-meta/issue-title"/>
                
                <xsl:apply-templates select="journal-meta/issn"/>
                <imprint>
                    <xsl:apply-templates select="journal-meta/publisher/*"/>

                    <xsl:for-each select="article-meta/pub-date">
                        <xsl:message>Current: <xsl:value-of select="@pub-type"/></xsl:message>
                        <xsl:if test="year != '' and year !='0000'">
                            <xsl:message>Pubdate year: <xsl:value-of select="year"/></xsl:message>
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>

                    <xsl:apply-templates
                        select="article-meta/volume | article-meta/issue 
                        | article-meta/fpage | article-meta/lpage 
                        | article-meta/elocation-id"
                    />
                </imprint>
            </monogr>
            <xsl:apply-templates select="article-meta/article-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Generic rules for IDs -->
    <xsl:template match="article-id">
        <idno>
            <xsl:attribute name="type">
                <xsl:value-of select="@pub-id-type"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="contrib[@contrib-type='author' or not(@contrib-type)]">
        <author>
            <xsl:if test="@corresp='yes'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </author>
    </xsl:template>

    <xsl:template match="contrib[@contrib-type='editor']">
        <editor>
            <xsl:apply-templates/>
        </editor>
    </xsl:template>

    <xsl:template match="contrib">
        <respStmt>
            <resp>
                <xsl:value-of select="@contrib-type"/>
            </resp>
            <xsl:apply-templates/>
        </respStmt>
    </xsl:template>

    <xsl:template match="contrib/address">
        <address>
            <xsl:apply-templates/>
        </address>
    </xsl:template>

    <xsl:template match="dateStruct">
        <date>
            <xsl:value-of select="."/>
        </date>
    </xsl:template>

    <xsl:template match="title-group/fn-group"/>

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="aff | contrib/address">
        <affiliation>
            <xsl:apply-templates select="*[name(.)!='addr-line' and name(.)!='country']"/>
            <xsl:if test="addr-line | country">
                <address>
                    <xsl:apply-templates select="addr-line | country"/>
                </address>
            </xsl:if>
        </affiliation>
    </xsl:template>

    <xsl:template match="aff/bold">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="aff/label">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- redirected affiliation by means of basic index (BMJ - 3.0 example) -->
    <xsl:template match="xref[@ref-type='aff']">
        <xsl:variable name="numberedIndex">
            <xsl:value-of select="./sup"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@rid">
                <xsl:variable name="index" select="@rid"/>
                <xsl:apply-templates select="//aff[@id=$index]"/>
            </xsl:when>
            <xsl:when
                test="ancestor::article-meta/descendant::aff/sup[normalize-space(.)=normalize-space($numberedIndex)]/following-sibling::text()[1]">
                <affiliation>
                    <xsl:apply-templates
                        select="ancestor::article-meta/descendant::aff/sup[normalize-space(.)=normalize-space($numberedIndex)]/following-sibling::text()[1]"
                    />
                </affiliation>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- specific notes attached to authors (PNAS - 3.0 example)-->
    <xsl:template match="xref[@ref-type='author-notes']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="strip-string">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:apply-templates select="ancestor::article-meta/descendant::author-notes/fn[@id=$index]"
        />
    </xsl:template>

    <!-- additional information attached to corresponding authors (Cambridge example)-->
    <xsl:template match="xref[@ref-type='corresp']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="refCorresp"
            select="ancestor::article-meta/descendant::author-notes/corresp[@id=$index]"/>
        <xsl:apply-templates select="$refCorresp/email"/>
        <!-- Cambridge may provide country in "author-notes/corresp" instead of "aff" -->
        <xsl:if test="$refCorresp/country">
            <address>
                <xsl:apply-templates select="$refCorresp/addr-line | $refCorresp/country| $refCorresp/institution"/>
               </address>
        </xsl:if>
    </xsl:template>

    <xsl:template match="author-comment">
        <note type="author-comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>



    <!-- Macrostructure of main body if the text -->
    <xsl:template match="sec[not(parent::boxed-text)]">
        <div>
            <xsl:if test="@sec-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@sec-type"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="parent::boxed-text">
                <xsl:attribute name="rend">
                    <xsl:text>boxed-text</xsl:text>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="label">
                <xsl:attribute name="n">
                    <xsl:value-of select="label"/>
                </xsl:attribute>
            </xsl:if>

            <!-- We treat boxed-text as independant divisions right after the current division 
            to avoid getting a division within a paragraph by accident -->
            <xsl:choose>
                <xsl:when test="not(descendant::sec) and descendant::boxed-text">
                    <xsl:comment>Boxed-text</xsl:comment>
                    <xsl:apply-templates/>
                    <xsl:apply-templates select="descendant::boxed-text/sec" mode="boxed-text"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <xsl:template match="sec[parent::boxed-text]"/>

    <xsl:template match="sec" mode="boxed-text">
        <div>
            <xsl:if test="@sec-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@sec-type"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="parent::boxed-text">
                <xsl:attribute name="rend">
                    <xsl:text>boxed-text</xsl:text>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="label">
                <xsl:attribute name="n">
                    <xsl:value-of select="label"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="sec/label"/>

    <xsl:template match="boxed-text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="sec/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="ack">
        <div type="acknowledgements">
            <head>Acknowledgements</head>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="statement">
        <div type="statement">
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="named-content">
        <name>
            <xsl:if test="@content-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@content-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </name>
    </xsl:template>

    <xsl:template match="comment">
        <note type="comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- The default case (when <abbrev> appears in isolation) -->
    <xsl:template match="abbrev[not(def)]">
        <abbr>
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>

    <xsl:template match="abbrev[def]">
        <choice>
            <abbr>
                <xsl:apply-templates/>
            </abbr>
            <xsl:apply-templates select="def" mode="inTerm"/>
        </choice>
    </xsl:template>

    <!-- Definitions in terms are treated through a dedicated named template -->
    <xsl:template match="abbrev/def"/>

    <!-- When they appear in <term> they need to be treated as <expan>s -->
    <xsl:template match="abbrev/def" mode="inTerm">
        <expan>
            <xsl:apply-templates/>
        </expan>
    </xsl:template>

    <!-- We just get rid of all <p>s in <def>s -->
    <xsl:template match="def/p">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="styled-content">
        <hi>
            <xsl:if test="@style">
                <xsl:attribute name="rend">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>

    <!-- Quoted passages -->
    <xsl:template match="disp-quote">
        <cit>
            <xsl:if test="attrib">
                <xsl:attribute name="rend">
                    <xsl:text>block</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <quote>
                <xsl:apply-templates select="*[not(name()='attrib')]"/>
            </quote>
            <xsl:apply-templates select="child::attrib"/>
        </cit>
    </xsl:template>

    <xsl:template match="disp-quote/attrib">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Glossaries -->
    <xsl:template match="glossary">
        <div type="glossary">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="gloss-group">
        <!-- Should be treated like glossaries in V3.0, does not exist any more -->
        <div type="glossary">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="def-list">
        <list type="termlist">
            <!-- To be compliant with the ISO style for terms and definitions ;-) -->
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="def-item">
        <item>
            <!-- To be compliant with the ISO style for terms and definitions ;-) -->
            <xsl:apply-templates/>
        </item>
    </xsl:template>

    <xsl:template match="term">
        <term>
            <!-- To be compliant with the ISO style for terms and definitions ;-) -->
            <xsl:apply-templates/>
        </term>
    </xsl:template>

    <xsl:template match="def">
        <gloss>
            <!-- To be compliant with the ISO style for terms and definitions ;-) -->
            <xsl:apply-templates/>
        </gloss>
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

    <!-- Figures -->
    <xsl:template match="fig">
        <figure>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="fig/label">
        <head type="label">
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="caption">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="caption/title">
        <head type="caption-title">
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
                <xsl:value-of select="concat('#',@rid)"/>
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

    <xsl:template match="permissions/license">
        <availability>
            <xsl:if test="@license-type">
                <xsl:attribute name="status">
                    <xsl:choose>
                        <xsl:when test="@license-type='open-access'">OpenAccess</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@license-type"/>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </availability>
    </xsl:template>

    <xsl:template match="license/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="copyright-year">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>

    <xsl:template match="copyright-holder">
        <authority>
            <xsl:apply-templates/>
        </authority>
    </xsl:template>

    <xsl:template match="allowbreak"/>

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
    
    <xsl:template match="date[@date-type='received-final']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received final</xsl:text>
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
