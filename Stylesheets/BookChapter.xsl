<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:param name="issueXmlPath" />
    <xsl:variable name="docIssue" select="document($issueXmlPath)" />
    <!-- todo : abstract niveau supérieur book / series
    todo: issue
    todo: completer book-categories
    todo : publisher depuis $docIssue
    todo : type de publication / type de contenu-->
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <!-- ******************* Genre ******************************-->
    <xsl:variable name="codeGenreBrepolsBook">
        <xsl:value-of select="//body/book-part/@book-part-type"/>
    </xsl:variable>
    <xsl:variable name="codeGenreBrepols">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='abstract'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='addendum'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='announcement'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='article-commentary'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='book-review'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='books-received'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='brief-report'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='calendar'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='case-report'">case-report</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='chapter'">chapter</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='collection'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='correction'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='dissertation'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='discussion'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='editorial'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='in-brief'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='introduction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='letter'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='meeting-report'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='news'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='obituary'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='oration'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='other'">
                <xsl:choose>
                    <xsl:when test="article/front/article-meta/abstract[string-length() &gt; 0] and contains(//article-meta/fpage,'s') or contains(//article-meta/fpage,'S')">article</xsl:when>
                    <xsl:otherwise>other</xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='partial-retraction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='poster'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='product-review'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='rapid-communication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='reply'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='reprint'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='research-article'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='retraction'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='review-article'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepolsBook)='translation'">other</xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- lien vers data.istex.fr -->
    <xsl:variable name="codeGenreArkBrepolsBook">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreBrepols)='research-article'">https://content-type.data.istex.fr/ark:/67375/XTP-1JC4F85T-7</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='article'">https://content-type.data.istex.fr/ark:/67375/XTP-6N5SZHKN-D</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='other'">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='book-reviews'">https://content-type.data.istex.fr/ark:/67375/XTP-PBH5VBM9-4</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='abstract'">https://content-type.data.istex.fr/ark:/67375/XTP-HPN7T1Q2-R</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='review-article'">https://content-type.data.istex.fr/ark:/67375/XTP-L5L7X3NF-P</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='brief-communication'">https://content-type.data.istex.fr/ark:/67375/XTP-S9SX2MFS-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='editorial'">https://content-type.data.istex.fr/ark:/67375/XTP-STW636XV-K</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='case-report'">https://content-type.data.istex.fr/ark:/67375/XTP-29919SZJ-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='conference'">https://content-type.data.istex.fr/ark:/67375/XTP-BFHXPBJJ-3</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='chapter'">https://content-type.data.istex.fr/ark:/67375/XTP-CGT4WMJM-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreBrepols)='book'">https://content-type.data.istex.fr/ark:/67375/XTP-94FB0L8V-T</xsl:when>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="/book">
        <xsl:comment>
            <xsl:text>Version 0.1 générée le </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:choose>
                <!-- numerique premium -->
                <xsl:when test="//abstract/@xml:lang[string-length() &gt; 0]">
                    <xsl:attribute name="xml:lang">
                    <xsl:value-of select="translate(//abstract/@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                    </xsl:attribute>
                </xsl:when>
                <!-- brepols book -->
                <xsl:when test="//body/book-part/@xml:lang[string-length()&gt; 0]">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="//body/book-part/@xml:lang"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:choose>
                            <xsl:when test="//body/book-part/book-part-meta/title-group/title[string-length()&gt; 0]">
                                <xsl:apply-templates select="//body/book-part/book-part-meta/title-group/title"/>
                            </xsl:when>
                            <xsl:when test="book-meta/book-title-group/book-title[string-length()&gt; 0]">
                                <xsl:if test="@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="translate(@lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:apply-templates select="book-meta/book-title-group/book-title"/>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:if test="book-meta/book-title-group/subtitle[string-length()&gt; 0]">
                            <xsl:apply-templates select="book-meta/book-title-group/subtitle"/>
                        </xsl:if>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <xsl:choose>
                            <xsl:when test="//body/book-part/book-part-meta">
                                <publisher scheme="https://publisher-list.data.istex.fr/ark:/67375/H02-N14T76M9-6">Brepols Publishers</publisher>
                            </xsl:when>
                            <xsl:when test="book-meta/publisher/publisher-name[string-length() &gt; 0]">
                                <xsl:choose>
                                    <xsl:when test="book-meta/publisher/publisher-name[string-length() &gt; 0]">
                                        <publisher><xsl:value-of select="book-meta/publisher/publisher-name"/></publisher>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <publisher source="https://loaded-corpus.data.istex.fr/ark:/67375/XBH-XPK2D80W-F">Numérique Premium</publisher></xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:if test="book-meta/pub-date/year[string-length() &gt; 0] |$docIssue//pub-date/year[string-length() &gt; 0]">
                        <availability>
                            <licence>
                                <xsl:choose>
                                    <xsl:when test="book-meta/pub-date/year[string-length() &gt; 0]">
                                        <p>©<xsl:value-of select="book-meta/pub-date/year"/> Numérique Premium</p>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="$docIssue//pub-date/year">
                                            <p>©<xsl:value-of select="$docIssue//pub-date/year"/> Brepols Publishers</p>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </licence>
                        </availability>
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when test="book-meta/pub-date/year[string-length() &gt; 0]">
                                <date type="published">
                                    <xsl:attribute name="when">
                                        <xsl:value-of select="book-meta/pub-date/year"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="book-meta/pub-date/year"/>
                                </date>
                            </xsl:when>
                            <xsl:when test="$docIssue//pub-date/year">
                                <date type="published" when="{$docIssue//pub-date/year}">
                                    <xsl:value-of select="$docIssue//pub-date/year[string-length()&gt; 0]"/>
                                </date>
                            </xsl:when>
                        </xsl:choose>
                    </publicationStmt>
                    
                    <!-- SG - ajout du codeGenre book -->
                    <notesStmt>
                        <!-- niveau chapter -->
                        <note type="content-type">
                            <xsl:choose>
                                <!-- Numérique premium -->
                                <xsl:when test="collection-meta">
                                    <xsl:attribute name="source">book</xsl:attribute>
                                    <xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-94FB0L8V-T</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </xsl:when>
                                <!-- brepols -->
                                <xsl:when test="$codeGenreBrepolsBook">
                                    <xsl:attribute name="source">
                                        <xsl:value-of select="$codeGenreBrepolsBook"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="scheme">
                                        <xsl:value-of select="$codeGenreArkBrepolsBook"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$codeGenreBrepolsBook"/>
                                </xsl:when>
                            </xsl:choose>
                        </note>
                        <!-- niveau revue / book -->
                        <xsl:choose>
                            <xsl:when test="$docIssue//book/book-series-meta">
                                <note type="publication-type">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute>
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- niveau revue -->
                                <note type="publication-type">
                                    <xsl:attribute name="subtype">book</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="front/article-meta/volume-id">
                            <xsl:apply-templates select="front/article-meta/volume-id"/>
                        </xsl:if>
                    </notesStmt>
                    <sourceDesc>
                        <xsl:choose>
                            <xsl:when test="//body/book-part/book-part-meta">
                                <xsl:apply-templates select="//book-part" mode="sourceDesc"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="//book" mode="NP"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="//body/book-part/book-part-meta/abstract |$docIssue//subj-group/subject">
                    <profileDesc>
                        <xsl:apply-templates select="//body/book-part/book-part-meta/abstract"/>
                        <xsl:if test="$docIssue//subj-group/subject[string-length() &gt; 0]">
                            <textClass ana="subject">
                                <xsl:apply-templates select="$docIssue//book-categories/subj-group"/>
                            </textClass>
                        </xsl:if>
                        <xsl:if test="//body/book-part/@xml:lang[string-length()&gt; 0]">
                            <langUsage>
                                <language>
                                    <xsl:attribute name="ident">
                                        <xsl:value-of select="//body/book-part/@xml:lang"/>
                                    </xsl:attribute>
                                </language>
                            </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="book-meta/abstract[string-length() &gt; 0]">
                    <profileDesc>
                        <!-- PL: abstract is moved from <front> to here -->
                        <xsl:for-each select="book-meta/abstract[string-length() &gt; 0]">
                            <abstract>
                                <xsl:if test="@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="translate(@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:apply-templates/>
                            </abstract>
                        </xsl:for-each>
                        <!-- NPremium - book_collection -->
                        <xsl:if test="collection-meta[@collection-type='book collection']/title-group/title[string-length() &gt; 0]">
                            <textClass ana="collection">
                                <keywords>
                                    <xsl:for-each select="collection-meta[@collection-type='book collection']/title-group">
                                        <xsl:choose>
                                            <xsl:when test="title">
                                                <term>
                                                    <xsl:value-of select="title"/>
                                                </term>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    
                                </keywords>
                            </textClass>
                        </xsl:if>
                        <xsl:if test="book-meta/subj-group[string-length() &gt; 0]">
                            <textClass ana="subject">
                                <xsl:for-each select="book-meta/subj-group">
                                    <xsl:if test="subject">
                                        <keywords>
                                            <list>
                                                <xsl:if test="subj-group/subject[string-length() &gt; 0]">
                                                    <item>
                                                        <xsl:value-of select="subj-group/subject"/>
                                                    </item>
                                                </xsl:if>
                                                <xsl:if test="subj-group/subj-group/subj-group/subj-group/subject">
                                                    <item>
                                                        <xsl:value-of select="normalize-space(subj-group/subj-group/subj-group/subj-group/subject)"/>
                                                    </item>
                                                </xsl:if>
                                                <xsl:if test="subj-group/subj-group/subject">
                                                    <item>
                                                        <xsl:value-of select="normalize-space(./subj-group/subj-group/subject)"/>
                                                    </item>
                                                </xsl:if>
                                                <xsl:if test="subj-group/subj-group/subj-group/subject">
                                                    <item>
                                                        <xsl:value-of select="normalize-space(subj-group/subj-group/subj-group/subject)"/>
                                                    </item>
                                                </xsl:if>
                                            </list>
                                        </keywords>
                                    </xsl:if>
                                </xsl:for-each>
                            </textClass>
                        </xsl:if>
                        
                        <xsl:if test="book-meta/kwd-group[string-length() &gt; 0]">
                            <xsl:apply-templates select="book-meta/kwd-group"/>
                        </xsl:if>
                        <xsl:if test="book-meta/abstract/@xml:lang">
                            <langUsage>
                                <language>
                                    <xsl:attribute name="ident">
                                        <xsl:value-of select="translate(book-meta/abstract/@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                    </xsl:attribute>
                                </language>
                            </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
            </teiHeader>
            <text>
                <body>
                    <div>
                        <xsl:choose>
                            <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                                <p><xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/></p>
                            </xsl:when>
                            <xsl:otherwise>
                                <p></p>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="book-part" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <!-- Title information related to the chapter goes here -->
                <xsl:apply-templates select="//body/book-part/book-part-meta/title-group/title"/>
                <!-- All authors are included here -->
                <xsl:apply-templates select="//body/book-part/book-part-meta/contrib-group/contrib"/>
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
                <xsl:if test="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']">
                    <idno type="DOI">
                        <xsl:value-of select="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']"/>
                    </idno>
                </xsl:if>
                <xsl:if test="//book-part-meta/alternate-form">
                    <xsl:for-each select="//book-part-meta/alternate-form">
                        <idno type="{@alternate-form-type}">
                            <xsl:value-of select="normalize-space(@xlink:href)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
            </analytic>
            <monogr>
                <xsl:apply-templates select="//book/book-meta/book-title-group/book-title"/>
                <xsl:apply-templates select="//book/book-meta/book-title-group/subtitle"/>
                <xsl:apply-templates select="$docIssue//book-meta/contrib-group/contrib"/>
                <xsl:if test="$docIssue//book-meta/contrib-group/isbn[@pub-type='ppub']">
                    <idno type="ISBN">
                        <xsl:value-of select="$docIssue//book-meta/contrib-group/isbn[@pub-type='ppub']"/>
                    </idno>
                </xsl:if>
                <xsl:if test="$docIssue//book-meta/contrib-group/isbn[@pub-type='epub']">
                    <idno type="eISBN">
                        <xsl:value-of select="$docIssue//book-meta/contrib-group/isbn[@pub-type='epub']"/>
                    </idno>
                </xsl:if>
                <xsl:if test="//book/book-meta/book-id[@pub-id-type='doi']">
                    <idno type="DOI">
                        <xsl:value-of select="//book/book-meta/book-id[@pub-id-type='doi']"/>
                    </idno>
                </xsl:if>
                <xsl:apply-templates select="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']"/>
                
                <imprint>
                    <!-- traiter volume numéro pubdate depuis fichier externe -->
                    <xsl:apply-templates select="$docIssue//body/book-meta/pub-date/year"/>
                    <xsl:apply-templates select="$docIssue//body/book-meta/volume"/>
                    <xsl:apply-templates select="//body/book-part/book-part-meta/fpage"/>
                    <xsl:apply-templates select="//body/book-part/book-part-meta/lpage"/>
                </imprint>
            </monogr>
            <!-- faire un if et gérer le niveau série dans fichier externe -->
            <xsl:if test="$docIssue//book-series-meta/book-title-group/book-title">
                <series>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-title-group/book-title"/>
                    
                    <xsl:apply-templates select="SeriesInfo/SeriesTitle"/>
                    <xsl:apply-templates select="SeriesInfo/SeriesPrintISSN"/>
                    <xsl:apply-templates select="SeriesInfo/SeriesElectronicISSN"/>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-id[@pub-id-type='doi']"/>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-id[@pub-id-type='publisher-id']"/>
                </series>
            </xsl:if>
        </biblStruct>
    </xsl:template>
    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="book" mode="NP">
        <biblStruct>
            <!-- Genre     -->
            <xsl:if test="@type[string-length()&gt; 0]">
                <xsl:attribute name="type">
                    <xsl:value-of select="normalize-space(@type)"/>
                </xsl:attribute>
            </xsl:if>
            <analytic>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="book-meta/book-title-group/book-title" mode="analytic"/>
                
                <!-- All authors are included here -->
                <xsl:choose>
                    <xsl:when test="//contrib[@contrib-type='editor']">
                        <xsl:apply-templates select="book-meta/contrib-group/contrib" mode="analytic"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="book-meta/contrib-group"/>
                    </xsl:otherwise>
                </xsl:choose>
                
                
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
                <xsl:if test="book-meta/book-id[string-length() &gt; 0]">
                    <xsl:for-each select="book-meta/book-id">
                        <idno type="{@book-id-type}">
                            <xsl:choose>
                                <xsl:when test="//book-id[@book-id-type='doi'][string-length() &gt; 0]">
                                    <xsl:choose>
                                        <xsl:when test="starts-with(//book-id[@book-id-type='doi'],'10')">
                                            <xsl:value-of select="normalize-space(//book-id[@book-id-type='doi'])"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>10.14375/NP.</xsl:text>
                                            <xsl:value-of select="normalize-space(//book-id[@book-id-type='doi'])"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="normalize-space(.)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="book-meta/self-uri">
                    <xsl:for-each select="book-meta/self-uri">
                        <idno type="{@content-type}">
                            <xsl:value-of select="normalize-space(@xlink:href)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
            </analytic>
            <monogr>
                <!-- All authors are included here -->
                <xsl:apply-templates select="book-meta/contrib-group/contrib" mode="NP"/>
                <xsl:apply-templates select="book-meta/book-title-group/book-title" mode="monogr"/>
                <!-- ********************************** Identifier *******************************-->
                <xsl:if test="book-meta/isbn[string-length() &gt; 0]">
                    <xsl:for-each select="book-meta/isbn">
                        <idno type='ISBN' subtype="{@content-type}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <imprint>
                    <xsl:apply-templates select="book-meta/counts/book-page-count"/>
                    <xsl:if test="book-meta/pub-date/year">
                        <date type="published">
                            <xsl:attribute name="when">
                                <xsl:value-of select="normalize-space(book-meta/pub-date/year)"/>
                            </xsl:attribute>
                            <xsl:value-of select="normalize-space(book-meta/pub-date/year)"/>
                        </date>
                    </xsl:if>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>
    <xsl:template match="//book-categories/subj-group">
        <keywords>
            <xsl:attribute name="scheme">
                <xsl:choose>
                    <xsl:when test="@subj-group-type">
                        <xsl:value-of select="@subj-group-type"/>
                    </xsl:when>
                    <xsl:otherwise>subject</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="subject/@code">
                    <list>
                        <xsl:apply-templates/>
                    </list>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </keywords>
    </xsl:template>
    <xsl:template match="//book-categories/subj-group/subject">
        <xsl:choose>
            <xsl:when test="@code">
                <label>
                    <xsl:value-of select="@code"/>
                </label>
                <item>
                    <xsl:apply-templates/>
                </item>
            </xsl:when>
            <xsl:otherwise>
                <term>
                    <xsl:apply-templates/>
                </term>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Numérique Premium -->
    <!-- author related information -->
  <xsl:template match="book-meta/contrib-group">
        <xsl:apply-templates select="contrib"/>
    </xsl:template>
    
    
    <!-- page-count-->
    <xsl:template match="book-meta/counts/book-page-count">
        <biblScope unit="page-count">
            <xsl:value-of select="@count"/>
        </biblScope>
    </xsl:template>
    
    <xsl:template match="contrib" mode="NP">
        <editor>
            <xsl:variable name="i" select="position()-1"/>
            <xsl:variable name="editorNumber">
                <xsl:choose>
                    <xsl:when test="$i &lt; 10">
                        <xsl:value-of select="concat('editor-000', $i)"/>
                    </xsl:when>
                    <xsl:when test="$i &lt; 100">
                        <xsl:value-of select="concat('editor-00', $i)"/>
                    </xsl:when>
                    <xsl:when test="$i &lt; 1000">
                        <xsl:value-of select="concat('editor-0', $i)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('editor-', $i)"/>
                    </xsl:otherwise>
                </xsl:choose> 
            </xsl:variable>
            <xsl:if test="not(ancestor::sub-article | ancestor::ref)">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="$editorNumber"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </editor>
    </xsl:template>
    <xsl:template match="book-title" mode="analytic">
        <title level="a" type="main">
            <xsl:if test="@Language | @xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:choose>
                        <xsl:when test="@Language='' or @xml:lang=''">
                            <xsl:text>en</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="Varia2ISO639">
                                <xsl:with-param name="code" select="@Language | @xml:lang"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="book-title" mode="monogr">
        <title level="m" type="main">
            <xsl:if test="@Language | @xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:choose>
                        <xsl:when test="@Language='' or @xml:lang=''">
                            <xsl:text>en</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="Varia2ISO639">
                                <xsl:with-param name="code" select="@Language | @xml:lang"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="contrib[@contrib-type = 'editor']" mode="analytic">
        <author>
            <xsl:variable name="i" select="position()-1"/>
            <xsl:variable name="authorNumber">
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
            </xsl:variable>
            <xsl:if test="not(ancestor::sub-article)">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="$authorNumber"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
</xsl:stylesheet>
