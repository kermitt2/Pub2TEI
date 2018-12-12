<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>
    
    <xsl:variable name="codeGenreSpringerBook">
        <xsl:value-of select="//Series/Book/Chapter/ChapterInfo/@ChapterType | //Series/Book/Part/Chapter/ChapterInfo/@ChapterType| //Publisher/Book/Chapter/ChapterInfo/@ChapterType | //Publisher/Book/Part/Chapter/ChapterInfo/@ChapterType"/>
    </xsl:variable>
    <!--xsl:variable name="codeGenreSB">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='OriginalPaper'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='Article'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='Report'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='Letter'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='Legacy'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='News'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='ContinuingEducation'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='ReviewPaper'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='BriefCommunication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='EditorialNotes'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='BookReview'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='Abstract'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerBook)='CaseReport'">case-report</xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="normalize-space($codeGenreSpringerBook)='Announcement' and //Abstract[string-length()&gt; 0]">article</xsl:when>
                    <xsl:otherwise>other</xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable-->
    <!--xsl:variable name="codeGenreArkSB">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreSB)='research-article'">https://content-type.data.istex.fr/ark:/67375/XTP-1JC4F85T-7</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='article'">https://content-type.data.istex.fr/ark:/67375/XTP-6N5SZHKN-D</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='other'">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='book-reviews'">https://content-type.data.istex.fr/ark:/67375/XTP-PBH5VBM9-4</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='abstract'">https://content-type.data.istex.fr/ark:/67375/XTP-HPN7T1Q2-R</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='review-article'">https://content-type.data.istex.fr/ark:/67375/XTP-L5L7X3NF-P</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='brief-communication'">https://content-type.data.istex.fr/ark:/67375/XTP-S9SX2MFS-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='editorial'">https://content-type.data.istex.fr/ark:/67375/XTP-STW636XV-K</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='case-report'">https://content-type.data.istex.fr/ark:/67375/XTP-29919SZJ-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='conference'">https://content-type.data.istex.fr/ark:/67375/XTP-BFHXPBJJ-3</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='chapter'">https://content-type.data.istex.fr/ark:/67375/XTP-CGT4WMJM-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreSB)='book'">https://content-type.data.istex.fr/ark:/67375/XTP-94FB0L8V-T</xsl:when>
        </xsl:choose>
    </xsl:variable-->
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="/Publisher[count(Series/Book/descendant::Chapter)=1]">
        <xsl:comment>
            <xsl:text>Version 0.1 generated on </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates
                            select="Series/Book/descendant::Chapter/ChapterInfo/ChapterTitle"/>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <xsl:apply-templates
                            select="Series/Book/descendant::Chapter/ChapterInfo/ChapterCopyright"/>
                        <xsl:if test="//ArticleGrants/BodyPDFGrant[string(@Grant)='OpenAccess']">
                            <availability status="free">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <notesStmt>
                        <!-- niveau book -->
                        <xsl:choose>
                            <xsl:when test="//BookBackmatter">
                                <note type="content-type">
                                    <xsl:attribute name="subtype">other</xsl:attribute>
                                    <xsl:attribute name="source">book-backmatter</xsl:attribute>
                                    <xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:attribute>
                                    <xsl:text>other</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//BookFrontmatter">
                                <note type="content-type">
                                    <xsl:attribute name="subtype">other</xsl:attribute>
                                    <xsl:attribute name="source">book-frontmatter</xsl:attribute>
                                    <xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:attribute>
                                    <xsl:text>other</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//Book/BookInfo/@BookProductType='Proceedings'">
                                <note type="content-type">
                                    <xsl:attribute name="type">conference</xsl:attribute>
                                    <xsl:attribute name="source">proceedings</xsl:attribute>
                                    <xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-BFHXPBJJ-3</xsl:attribute>
                                <xsl:text>conference</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="//Series/Book/Chapter/ChapterInfo/@ChapterType | //Series/Book/Part/Chapter/ChapterInfo/@ChapterType| //Publisher/Book/Chapter/ChapterInfo/@ChapterType | //Publisher/Book/Part/Chapter/ChapterInfo/@ChapterType">
                                        <note type="content-type">
                                            <!--xsl:attribute name="subtype">
                                                <xsl:value-of select="$codeGenreSB"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="source">
                                                <xsl:value-of select="$codeGenreSpringerBook"/>
                                            </xsl:attribute-->
                                            <!--xsl:attribute name="scheme">
                                                <xsl:value-of select="$codeGenreArkSB"/>
                                            </xsl:attribute-->
                                            <xsl:value-of select="$codeGenreSpringerBook"/>
                                        </note>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <note type="content-type">
                                            <xsl:attribute name="subtype">chapter</xsl:attribute>
                                            <xsl:attribute name="source">chapter</xsl:attribute>
                                            <!--xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-CGT4WMJM-6</xsl:attribute-->
                                            <xsl:text>chapter</xsl:text>
                                        </note>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- niveau revue / book -->
                        <xsl:choose>
                            <xsl:when test="//Series">
                                <note type="publication-type" subtype="book-series">
                                    <!--xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute-->
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//Book and not(//Series)">
                                <note type="publication-type" subtype="book">
                                    <!--xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute-->
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                        </xsl:choose>
                    </notesStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="Series" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <xsl:apply-templates select="//Book/descendant::Chapter/ChapterHeader/Abstract"/>
                    <xsl:apply-templates select="//Book/descendant::Chapter/ChapterHeader/AbbreviationGroup"/>
                    <xsl:apply-templates select="//Book/descendant::Chapter/ChapterHeader/KeywordGroup"/>
                    <textClass ana="subject">
                        <xsl:apply-templates select="//Book/descendant::SubjectCollection"/></textClass>
                    <textClass ana="subject"><xsl:apply-templates select="//Book/descendant::BookSubjectGroup"/></textClass>
                <xsl:if test="//Chapter/@Language">
                    <langUsage>
                        <language>
                            <xsl:attribute name="ident">
                                <xsl:value-of select="translate(//Chapter/@Language,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                            </xsl:attribute>
                        </language>
                    </langUsage>
                </xsl:if>
                </profileDesc>
            </teiHeader>
            <text>
                <body>
                    <div>
                        <xsl:choose>
                            <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                                <p>
                                    <xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/>
                                </p>
                            </xsl:when>
                            <xsl:otherwise>
                                <p/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="Series" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <!-- Title information related to the chapter goes here -->
                <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterTitle"/>
                <!-- All authors are included here -->
                <xsl:apply-templates select="Book/descendant::Chapter/ChapterHeader/AuthorGroup/Author"/>
                <xsl:apply-templates
                    select="Book/descendant::Chapter/ChapterHeader//AuthorGroup/InstitutionalAuthor"/>
                <!-- ajout identifiants ISTEX et ARK -->
                <!--xsl:if test="string-length($idistex) &gt; 0 ">
                    <idno type="istex">
                        <xsl:value-of select="$idistex"/>
                    </idno>
                </xsl:if>
                <xsl:if test="string-length($arkistex) &gt; 0 ">
                    <idno type="ark">
                        <xsl:value-of select="$arkistex"/>
                    </idno>
                </xsl:if-->
                <xsl:apply-templates select="Book/Chapter/ChapterInfo/ChapterID"/>
                <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterDOI"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="Book/BookInfo/BookTitle"/>
                <xsl:apply-templates select="Book/BookInfo/BookSubTitle"/>
                <xsl:apply-templates select="Book/Part/PartInfo/PartTitle"/>
                <xsl:apply-templates select="Book/BookInfo/BookDOI"/>
                <xsl:apply-templates select="Book/BookInfo/BookID"/>
                <xsl:apply-templates select="Book/BookInfo/BookTitleID"/>
                <xsl:apply-templates select="Book/BookInfo/BookPrintISBN"/>
                <xsl:apply-templates select="Book/BookInfo/BookElectronicISBN"/>
                <xsl:apply-templates select="//Chapter"/>
                <xsl:apply-templates select="//Part"/>
                <xsl:apply-templates select="Book/BookHeader/AuthorGroup/Author"/>
                <xsl:apply-templates select="Book/BookHeader/EditorGroup/Editor"/>
                <xsl:apply-templates select="Book/BookInfo/ConferenceInfo"/>
                <imprint>
                    <xsl:apply-templates select="Book/BookInfo/BookVolumeNumber"/>
                    <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterFirstPage"/>
                    <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterLastPage"/>
                    <xsl:apply-templates select="Volume/VolumeInfo"/>
                    <xsl:apply-templates select="Book/BookInfo/BookChapterCount"/>
                    <xsl:apply-templates select="Book/Part/PartInfo/PartChapterCount"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDStart"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDEnd"/>
                </imprint>
            </monogr>
            <series>
                <xsl:apply-templates select="SeriesInfo/SeriesTitle"/>
                <xsl:apply-templates select="SeriesInfo/SeriesAbbreviatedTitle"/>
                <xsl:apply-templates select="SeriesHeader/AuthorGroup/Author"/>
                <xsl:apply-templates select="SeriesHeader/EditorGroup/Editor"/>
                <xsl:apply-templates select="SeriesInfo/SeriesPrintISSN"/>
                <xsl:apply-templates select="SeriesInfo/SeriesElectronicISSN"/>
                <xsl:apply-templates select="SeriesInfo/SeriesID"/>
            </series>
        </biblStruct>
    </xsl:template>

</xsl:stylesheet>
