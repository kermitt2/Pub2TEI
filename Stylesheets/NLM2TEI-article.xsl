<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="#all">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Dec. 2008</xd:p>
            <xd:p><xd:b>Author:</xd:b> Laurent Romary</xd:p>
            <xd:p>for the PEER project</xd:p>
            <xd:p>Available under creative commons CC-BY licence.</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" method="xml"/>
    <!-- code genre -->
    <xsl:variable name="codeGenre2">
        <xsl:value-of select="article/@article-type"/>
    </xsl:variable>
    <xsl:variable name="codeGenre">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenre2)='abstract'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='addendum'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='announcement'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='article-commentary'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='book-review'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='books-received'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='brief-report'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='calendar'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='case-report'">case-report</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='collection'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='correction'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='dissertation'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='discussion'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='editorial'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='in-brief'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='introduction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='letter'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='meeting-report'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='news'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='obituary'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='oration'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='other'">
                <xsl:choose>
                    <xsl:when test="article/front/article-meta/abstract[string-length() &gt; 0] and contains(//article-meta/fpage,'s') or contains(//article-meta/fpage,'S')">article</xsl:when>
                    <xsl:otherwise>other</xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='partial-retraction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='poster'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='product-review'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='rapid-communication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='reply'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='reprint'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='research-article'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='retraction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='review-article'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre2)='translation'">other</xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
   
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="article[front] | article[pubfm] | article[suppfm] | headerx">
        <xsl:message>NLM2TEI-article.xsl</xsl:message>
        <TEI>
            <xsl:if test="@xml:lang">
                <xsl:copy-of select="@xml:lang"/>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="front/article-meta/title-group/article-title | fm/atl"/>
                    </titleStmt>
                    <!-- PL: pour les suppinfo, sous fileDesc/editionStmt/edition/ref, solution de HAL --> 
                    <xsl:if test="pubfm/suppinfo">
                        <editionStmt>
                            <edition>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="pubfm/suppinfo/@id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="pubfm/suppinfo/suppobj"/>
                            </edition>	
                        </editionStmt>
                    </xsl:if>
                    <xsl:if test="suppfm/suppinfo">
                        <editionStmt>
                            <edition>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="suppfm/suppinfo/@id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="suppfm/suppinfo/suppobj"/>
                            </edition>	
                        </editionStmt>
                    </xsl:if>
                    <publicationStmt>
                        <xsl:if test="front/journal-meta/publisher">
                            <xsl:apply-templates select="front/journal-meta/publisher/*"/>
                        </xsl:if>
                        <xsl:if test="not(front/journal-meta/publisher)">
                            <publisher>Nature Publishing Group</publisher>
                        </xsl:if>
                        <xsl:apply-templates select="front/article-meta/permissions/*"/>
                        <xsl:if test="not(front/article-meta/permissions)">
                            <xsl:apply-templates select="front/article-meta/copyright-statement | pubfm/cpg/cpn | suppfm/cpg/cpn"/>
                            <xsl:apply-templates select="front/article-meta/copyright-year | pubfm/cpg/cpy | suppfm/cpg/cpy"/>
                        </xsl:if>
                        <xsl:if test="front/article-meta/custom-meta-wrap/custom-meta[string(meta-name) = 'unlocked' and string(meta-value) = 'Yes']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                        <xsl:if test="front/article-meta/open-access[string(.) = 'YES']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <!-- SG - ajout du codeGenre article et revue -->
                    <notesStmt>
                        <!-- niveau article / chapter -->
                        <note type="content-type">
                            <xsl:attribute name="source">
                                <xsl:value-of select="$codeGenre2"/>
                            </xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="$codeGenreArkA"/>
                            </xsl:attribute>
                            <xsl:value-of select="$codeGenre"/>
                        </note>
                        <!-- niveau revue / book -->
                        <xsl:choose>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                                <note type="publication-type">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute>
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                                <note type="publication-type">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <note type="publication-type">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0GLKJH51-B</xsl:attribute>
                                    <xsl:text>journal</xsl:text>
                                </note>
                            </xsl:otherwise>
                        </xsl:choose>
                    </notesStmt>
                    <!-- PL: pour les suppinfo, sous fileDesc/editionStmt/edition/ref, solution de HAL -->
                    <xsl:if test="pubfm/suppinfo">
                        <editionStmt>
                            <edition>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="pubfm/suppinfo/@id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="pubfm/suppinfo/suppobj"/>
                            </edition>
                        </editionStmt>
                    </xsl:if>
                    <xsl:if test="suppfm/suppinfo">
                        <editionStmt>
                            <edition>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="suppfm/suppinfo/@id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="suppfm/suppinfo/suppobj"/>
                            </edition>
                        </editionStmt>
                    </xsl:if>
                    <sourceDesc>
                        <xsl:apply-templates select="front | pubfm | suppfm" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="front/article-meta/abstract or front/article-meta/kwd-group or bdy/fp or fm/abs or fm/fp or //pubfm/subject or //suppfm/subject">
                    <profileDesc>
                        <!-- PL: abstract is moved from <front> to here -->
                        <xsl:if test="front/article-meta/abstract | bdy/fp | fm/abs | fm/fp | fm/execsumm | fm/websumm">
                            <xsl:apply-templates select="front/article-meta/abstract | bdy/fp | fm/abs | fm/fp | fm/execsumm | fm/websumm"/>
                        </xsl:if>
                        <!-- SG NLM subject -->
                        <xsl:if test="pubfm/subject">
                            <textClass>
                                <xsl:apply-templates select="pubfm/subject"/>
                            </textClass>
                        </xsl:if>
                        <xsl:if test="suppfm/subject">
                            <textClass>
                                <xsl:apply-templates select="suppfm/subject"/>
                            </textClass>
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
                    <xsl:choose>
                        <xsl:when test="body/* | bdy/p | bdy/sec | bdy/corres/*">
                            <xsl:apply-templates select="body/* | bdy/p | bdy/sec | bdy/corres/*"/>
                            <xsl:apply-templates select="bm/objects/*"/>
                            <!-- SG body ne contenant pas de sous-balise (ex: Nature_headerDTD_E55900BEA1B96187B075C3707A439F215C3EF07C.xml)-->
                            <xsl:if test="//headerx/bdy">
                                <p>
                                    <xsl:value-of select="//headerx/bdy"/>
                                </p>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <div>
                                <p/>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </body>
                <xsl:if test="back | bm">
                    <back>
                        <xsl:apply-templates select="back/* | bm/ack | bm/bibl"/>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>

    <!-- We do not care about components from <article-meta> which are 
    not explicitely addressed by means of an XPath in another template-->
    <xsl:template match="article-meta"/>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="front | pubfm | suppfm" mode="sourceDesc">
        <biblStruct>
            <xsl:variable name="articleType" select="/article/@article-type"/>
            <xsl:if test="$articleType != ''">
                <xsl:choose>
                    <xsl:when test="$articleType = 'research-article'">
                        <xsl:attribute name="type">article</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'review-article'">
                        <xsl:attribute name="type">article</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'correction'">
                        <xsl:attribute name="type">erratum</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'other'">
                        <xsl:attribute name="type">other</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'book-review'">
                        <xsl:attribute name="type">bookReview</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'books-received'">
                        <xsl:attribute name="type">booksReceived</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'editorial'">
                        <xsl:attribute name="type">editorial</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'brief-report'">
                        <xsl:attribute name="type">briefReport</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$articleType = 'letter'">
                        <xsl:attribute name="type">letter</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="no">Article-type inconnu: <xsl:value-of select="$articleType"/></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="article-meta/contrib-group/*[name() != 'aff']"/>
                <xsl:if test="/article/fm/aug | /headerx/fm/aug">
                    <xsl:apply-templates select="/article/fm/aug/* | /headerx/fm/aug/*"/>
                </xsl:if>
                <xsl:if test="//bdy/corres/aug">
                    <xsl:apply-templates select="//bdy/corres/aug/*"/>
                </xsl:if>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="article-meta/title-group/*"/>
                <xsl:apply-templates select="//fm/atl"/>
                <!-- ajout identifiants ISTEX et ARK -->
                <xsl:if test="string-length($idistex) &gt; 0 ">
                    <idno type="istex">
                        <xsl:value-of select="$idistex"/>
                    </idno>
                </xsl:if>
                <xsl:if test="string-length($arkistex) &gt; 0 ">
                    <idno type="ark">
                        <xsl:value-of select="$arkistex"/>
                    </idno>
                </xsl:if>
                <xsl:apply-templates select="doi"/>
                <xsl:apply-templates select="article-meta/article-id"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="journal-meta/journal-title | jtl | suppmast/jtl | suppmast/suppttl"/>
                <xsl:apply-templates select="journal-meta/journal-id"/>
                <xsl:apply-templates select="journal-meta/abbrev-journal-title"/>
                <xsl:apply-templates select="journal-meta/issue-title"/>
                <xsl:apply-templates select="journal-meta/issn | issn |parent/issn"/>
				<imprint>
                    <xsl:apply-templates select="journal-meta/publisher/*"/>

                    <xsl:for-each select="article-meta/pub-date">
                        <xsl:message>Current: <xsl:value-of select="@pub-type"/></xsl:message>
                        <xsl:if test="year != '' and year != '0000'">
                            <xsl:message>Pubdate year: <xsl:value-of select="year"/></xsl:message>
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>

                    <!-- the special date notation <idt>201211</idt> -->
                    <xsl:apply-templates select="idtidt | suppmast/idt"/>
                    <xsl:apply-templates
                        select="
                            article-meta/volume | vol | suppmast/vol | suppmast/iss | article-meta/issue | iss
                            | article-meta/fpage | pp/spn | pp/epn | article-meta/lpage
                            | article-meta/elocation-id"/>
				    <biblScope unit="count-page">
				        <xsl:value-of select="//article/front/article-meta/counts/page-count/@count"/>
				    </biblScope>
                    <xsl:apply-templates select="copyright-year | cpg/cpy"/>
				</imprint>
            </monogr>
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

    <xsl:template match="ArticleId">
        <idno>
            <xsl:attribute name="type">
                <xsl:value-of select="ArticleId"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="aug/au | aug/cau">
        <author>
            <xsl:variable name="i" select="position() - 1"/>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="$i &lt; 10">
                        <xsl:value-of select="concat('author-000', $i)"/>
                    </xsl:when>
                    <xsl:when test="$i &lt; 100">
                        <xsl:value-of select="concat('author-00', $i)"/>
                    </xsl:when>
                    <xsl:when test="$i &lt; 1000">
                        <xsl:value-of select="concat('author-0', $i)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('author-', $i)"/>
                    </xsl:otherwise>
                </xsl:choose>
                <!--<xsl:variable name="i" select="$i + 1" />-->
            </xsl:attribute>
            <persName>
                <xsl:apply-templates select="* except (bio,corf,orf)"/>
            </persName>
            <!-- PL: biography are put under author -->
            <xsl:if test="bio">
                <xsl:apply-templates select="bio"/>
            </xsl:if>
            <!-- email -->
            <xsl:if test="../caff/coid and corf and corf/@rid">
                <xsl:apply-templates select="../caff[coid[@id = current()/corf/@rid]]" mode="sourceDesc"/>
            </xsl:if>
            <!-- affiliation -->
            <xsl:choose>
                <!-- SG - cas quand les liens auteurs/affiliations sont définis dans <super> ex: nature_headerx_315773a0.xml -->
                <xsl:when test="super">
                    <xsl:for-each select="super">
                        <!-- SG: nettoyage de la balise <super> polluant l'affiliation, ne prendre que le texte -->
                        <xsl:variable name="super">
                            <xsl:value-of select="//aff[super = current()/.]/text()"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="$super">
                                <affiliation>
                                    <xsl:value-of select="normalize-space($super)"/>
                                </affiliation>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <!-- SG - cas quand les affiliations n'ont pas de liens auteurs/affiliations définis explicitement ex: nature_headerx_315736a0.xml -->
                <xsl:when test="../aff/org and not(../aff/oid)">
                    <xsl:apply-templates select="../aff" mode="sourceDesc"/>
                </xsl:when>
                <xsl:when test="../aff and not(../aff/oid)">
                    <affiliation>
                        <xsl:value-of select="following-sibling::aff"/>
                    </affiliation>
                </xsl:when>
                <xsl:when test="../aff/oid">
                    <xsl:apply-templates select="../aff[oid[@id = current()/orf/@rid]]" mode="sourceDesc"/>
                </xsl:when>
                <xsl:when test="../aff">
                    <xsl:apply-templates select="../aff" mode="sourceDesc"/>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="aufnr/@rid">
                <affiliation>
                    <xsl:value-of select="//aufn[@id = current()/aufnr/@rid]"/>
                </affiliation>
            </xsl:if>
        </author>
    </xsl:template>
    <!--SG: reprise biographie des auteurs -->
    <xsl:template match="bio">
        <state>
            <xsl:attribute name="type">biography</xsl:attribute>
            <xsl:apply-templates/>
        </state>
    </xsl:template>

    <xsl:template match="bio/p">
        <desc>
            <xsl:apply-templates/>
        </desc>
    </xsl:template>

    <xsl:template match="caff"/>
    <xsl:template match="au/super"/>

    <xsl:template match="contrib[@contrib-type = 'author' or not(@contrib-type)]">
        <author>
            <xsl:if test="@corresp = 'yes'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </author>
    </xsl:template>

    <xsl:template match="contrib[@contrib-type = 'editor']">
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
        <xsl:if test="not(/article/pubfm | /headerx/pubfm | /article/suppfm)">
            <!-- this only apply to NPG articles not containing a pubfm style component -->
            <affiliation>
                <xsl:apply-templates select="*[name(.) != 'addr-line' and name(.) != 'country']"/>
                <xsl:if test="addr-line | country">
                    <address>
	                    <xsl:apply-templates select="addr-line | country"/>
	                </address>
                </xsl:if>
                <xsl:value-of select="."/>
            </affiliation>
        </xsl:if>
    </xsl:template>
    <xsl:template match="caff" mode="sourceDesc">
        <xsl:if test="email">
            <email>
                <xsl:value-of select="email"/>
            </email>
        </xsl:if>
        <affiliation>
            <xsl:value-of select="."/>
        </affiliation>
    </xsl:template>
    <xsl:template match="aff" mode="sourceDesc">
        <affiliation>
            <xsl:choose>
                <xsl:when test="org | street | cny | zip | cty | st">
                    <xsl:if test="org">
                        <orgName type="institution">
                            <xsl:value-of select="org"/>
                        </orgName>
                    </xsl:if>
                    <xsl:if test="street | cny | zip | cty | st">
                        <address>
		                    <xsl:if test="cny | cty | zip | street">
								<xsl:apply-templates select="cty | cny | zip | street | st"/>
		                    </xsl:if>
		                </address>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </affiliation>
    </xsl:template>
    <xsl:template match="caff" mode="sourceDesc">
        <xsl:if test="email">
            <email>
                <xsl:value-of select="email"/>
            </email>
        </xsl:if>
        <affiliation>
            <xsl:value-of select="."/> 
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
    <xsl:template match="xref[@ref-type = 'aff']">
        <xsl:variable name="numberedIndex">
            <xsl:value-of select="./sup"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@rid">
                <xsl:variable name="index" select="@rid"/>
                <xsl:apply-templates select="//aff[@id = $index]"/>
            </xsl:when>
            <xsl:when test="ancestor::article-meta/descendant::aff/sup[normalize-space(.) = normalize-space($numberedIndex)]/following-sibling::text()[1]">
                <affiliation>
                    <xsl:apply-templates select="ancestor::article-meta/descendant::aff/sup[normalize-space(.) = normalize-space($numberedIndex)]/following-sibling::text()[1]"/>
                </affiliation>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- specific notes attached to authors (PNAS - 3.0 example)-->
    <xsl:template match="xref[@ref-type = 'author-notes']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="strip-string">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:apply-templates select="ancestor::article-meta/descendant::author-notes/fn[@id = $index]"/>
    </xsl:template>

    <!-- additional information attached to corresponding authors (Cambridge example)-->
    <xsl:template match="xref[@ref-type = 'corresp']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="refCorresp" select="ancestor::article-meta/descendant::author-notes/corresp[@id = $index]"/>
        <xsl:apply-templates select="$refCorresp/email"/>
        <!-- Cambridge may provide country in "author-notes/corresp" instead of "aff" -->
        <xsl:if test="$refCorresp/country">
            <address>
                <xsl:apply-templates select="$refCorresp/addr-line | $refCorresp/country | $refCorresp/institution"/>
               </address>
        </xsl:if>
    </xsl:template>

    <xsl:template match="author-comment[@content-type = 'short-author-list']">
        <author role="short-author-list">
            <xsl:apply-templates/>
        </author>
    </xsl:template>

    <xsl:template match="author-comment[@content-type = 'short-author-list']/p">
        <xsl:apply-templates/>
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
                <xsl:apply-templates select="*[not(name() = 'attrib')]"/>
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
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:if>
            <xsl:if test="li">
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
                <xsl:value-of select="concat('#', @rid)"/>
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
                        <xsl:when test="@license-type = 'open-access'">free</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@license-type"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="license-p">
                    <p>
                        <xsl:value-of select="license-p"/>
                    </p>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:apply-templates/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </availability>
    </xsl:template>

    <xsl:template match="license/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="copyright-year | cpy">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>

    <xsl:template match="copyright-holder | cpn">
        <availability>
            <!-- SG: ajout licence -->
            <licence>
                <xsl:apply-templates/>
            </licence>
        </availability>
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
                <xsl:when test="@pub-type = 'epub'">
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

    <xsl:template match="date[@date-type = 'received']">
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

    <xsl:template match="date[@date-type = 'received-final']">
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

    <xsl:template match="date[@date-type = 'rev-recd']">
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

    <xsl:template match="date[@date-type = 'accepted']">
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

    <!-- custom date format <idt>19731128</idt> -->
    <xsl:template match="idt | suppmast/idt">
        <date>
            <xsl:attribute name="when">
                <xsl:if test="string-length(text()) > 0">
                    <xsl:value-of select="substring(text(), 0, 5)"/>
                </xsl:if>
                <xsl:if test="string-length(text()) > 4">-<xsl:value-of select="substring(text(), 5, 2)"/></xsl:if>
                <xsl:if test="string-length(text()) > 6">-<xsl:value-of select="substring(text(), 7, 2)"/></xsl:if>
            </xsl:attribute>
        </date>
    </xsl:template>

    <!-- PL: supplementary info presetn as external files -->
    <xsl:template match="suppobj">
        <ref>
            <xsl:attribute name="type">
                <xsl:text>file</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="subtype">
                <xsl:value-of select="@format"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@extrefid"/>
            </xsl:attribute>
            <title>
                <xsl:value-of select="title"/>
            </title>
            <note>
                <xsl:apply-templates select="descrip/*"/>
            </note>
        </ref>
    </xsl:template>

</xsl:stylesheet>
