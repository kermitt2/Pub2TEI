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
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:if test="//body/book-part/@xml:lang[string-length()&gt; 0]">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="//body/book-part/@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="//body/book-part/book-part-meta/title-group/title"/>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <publisher scheme="https://publisher-list.data.istex.fr/ark:/67375/H02-N14T76M9-6">Brepols Publishers</publisher>
                       <!-- <xsl:if test="//ArticleGrants/BodyPDFGrant[string(@Grant)='OpenAccess']">
                            <availability status="free">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>-->
                        <date type="published" when="{$docIssue//pub-date/year}">
                            <xsl:value-of select="$docIssue//pub-date/year[string-length()&gt; 0]"/>
                        </date>
                    </publicationStmt>
                    <!-- SG - ajout du codeGenre book -->
                    <notesStmt>
                        <!-- niveau chapter -->
                        <note type="content-type">
                            <xsl:attribute name="source">
                                <xsl:value-of select="$codeGenreBrepolsBook"/>
                            </xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="$codeGenreArkBrepolsBook"/>
                            </xsl:attribute>
                            <xsl:value-of select="$codeGenreBrepolsBook"/>
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
                                <note type="publication-type">
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
                        <xsl:apply-templates select="//book-part" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="//body/book-part/book-part-meta/abstract |$docIssue//subj-group/subject">
                    <profileDesc>
                        <xsl:apply-templates select="//body/book-part/book-part-meta/abstract"/>
                        <textClass>
                            <xsl:apply-templates select="$docIssue//book-categories/subj-group"/>
                        </textClass>
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
            </teiHeader>
            <text>
                <body>
                    <div>
                        <p/>
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
                <xsl:if test="//book/book-meta/book-id[@pub-id-type='doi']">
                    <idno type="DOI">
                        <xsl:value-of select="//book/book-meta/book-id[@pub-id-type='doi']"/>
                    </idno>
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
                <xsl:if test="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']">
                    <idno type="DOI">
                        <xsl:value-of select="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']"/>
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
</xsl:stylesheet>
