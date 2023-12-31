<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:variable name="codeGenreSpringerJournal">
        <xsl:value-of select="//ArticleInfo/@ArticleType"/>
    </xsl:variable>
    <!--xsl:variable name="codeGenreSJ">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='OriginalPaper'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='Article'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='Report'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='Letter'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='Legacy'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='News'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='ContinuingEducation'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='ReviewPaper'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='BriefCommunication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='EditorialNotes'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='BookReview'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='Abstract'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenreSpringerJournal)='CaseReport'">case-report</xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="normalize-space($codeGenreSpringerJournal)='Announcement' and //Abstract[string-length()&gt; 0]">article</xsl:when>
                    <xsl:otherwise>other</xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable-->

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="/Publisher[not(Series/Book/descendant::Chapter)]">
        <!--xsl:comment>
            <xsl:text>Version 0.1 generated on </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment-->
        <TEI>
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:text>https://raw.githubusercontent.com/kermitt2/grobid/master/grobid-home/schemas/xsd/Grobid.xsd</xsl:text>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="Journal//ArticleTitle"/>
                    </titleStmt>
                    <publicationStmt>
                        <!-- publisher -->
                        <xsl:apply-templates select="//PublisherName"/>
                        <xsl:apply-templates select="//PublisherLocation"/>
                        <xsl:choose>
                            <xsl:when test="Journal/JournalOnlineFirst">
                                <xsl:apply-templates
                                    select="Journal/JournalOnlineFirst/Article/ArticleInfo/ArticleCopyright"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates
                                    select="Journal/Volume/Issue/Article/ArticleInfo/ArticleCopyright"
                                />
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="//ArticleGrants/BodyPDFGrant[string(@Grant)='OpenAccess']">
                                <availability status="OpenAccess">
                                    <p>Open Access</p>
                                </availability>
                        </xsl:if>
                    </publicationStmt>
                    <notesStmt>
                        <!-- niveau book -->
                        <note type="content-type">
                            <xsl:value-of select="$codeGenreSpringerJournal"/>
                        </note>
                        <!-- niveau revue / book -->
                        <xsl:choose>
                            <xsl:when test="//Journal">
                                <note type="publication-type" subtype="journal">
                                    <xsl:text>journal</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//Series">
                                <note type="publication-type" subtype="book-series">
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//Book and not(//Series)">
                                <note type="publication-type" subtype="book">
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                        </xsl:choose>
                    </notesStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="Journal" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:choose>
                    <xsl:when test="Journal/JournalOnlineFirst">

                        <xsl:if test="Journal/JournalOnlineFirst/Article/ArticleHeader/KeywordGroup">
                            <profileDesc>
                                <xsl:apply-templates
                                    select="Journal/JournalOnlineFirst/Article/ArticleHeader/KeywordGroup"
                                />
                                <xsl:apply-templates
                                    select="Journal/Volume/Issue/Article/ArticleHeader/AbbreviationGroup"
                                />
                                <textClass ana="subject">
                                <xsl:apply-templates
                                    select="Journal/JournalInfo/JournalSubjectGroup"
                                />
                                </textClass>
                            </profileDesc>
                        </xsl:if>
                        <xsl:if test="Journal/JournalOnlineFirst/Article/ArticleInfo/ArticleHistory">
                            <xsl:apply-templates
                                select="Journal/JournalOnlineFirst/Article/ArticleInfo/ArticleHistory"
                            />
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="Journal/Volume/Issue/Article/ArticleHeader/KeywordGroup |Journal/JournalInfo/JournalSubjectGroup">
                            <profileDesc>
								<!-- PL: abstract is moved here from <front> -->
			                    <xsl:choose>
			                        <xsl:when test="Journal/JournalOnlineFirst">
			                            <xsl:apply-templates
			                                select="Journal/JournalOnlineFirst/Article/ArticleHeader/Abstract"/>
			                        </xsl:when>
			                        <xsl:otherwise>
			                            <xsl:apply-templates
			                                select="Journal/Volume/Issue/Article/ArticleHeader/Abstract"/>
			                        </xsl:otherwise>
			                    </xsl:choose>
                                <textClass ana="subject">
                                    <xsl:apply-templates
                                        select="Journal/JournalInfo/JournalSubjectGroup"
                                    />
                                </textClass>
                                    <xsl:apply-templates
                                        select="Journal/Volume/Issue/Article/ArticleHeader/AbbreviationGroup"
                                    />
                                
                                <xsl:apply-templates
                                    select="Journal/Volume/Issue/Article/ArticleHeader/KeywordGroup"
                                />
                                <!-- Language -->
                                <xsl:choose>
                                    <xsl:when test="//ArticleTitle[1]/@Language">
                                    <langUsage>
                                        <language>
                                            <xsl:attribute name="ident">
                                                <xsl:choose>
                                                    <xsl:when test="//ArticleDOI='10.1007/BF02584710'">PT</xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="translate(//ArticleTitle[1]/@Language,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                        </language>
                                    </langUsage>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <langUsage>
                                            <language>
                                                <xsl:attribute name="ident">
                                                    <xsl:choose>
                                                        <xsl:when test="//ArticleDOI='10.1007/BF02584710'">PT</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="translate(//ArticleInfo/@Language,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:attribute>
                                            </language>
                                        </langUsage>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </profileDesc>
                        </xsl:if>
                        <xsl:if test="Journal/Volume/Issue/Article/ArticleInfo/ArticleHistory">
                            <xsl:apply-templates
                                select="Journal/Volume/Issue/Article/ArticleInfo/ArticleHistory"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </teiHeader>
			<text>
			    <body>
			        <div>
			            <xsl:if test="string-length($rawfulltextpath) &gt; 0">
			                <p>
			                    <xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/>
			                </p>
			            </xsl:if>
			        </div>
			    </body>
			</text>
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="Journal" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <xsl:choose>
                    <xsl:when test="JournalOnlineFirst">
                        <!-- Title information related to the paper goes here -->
                        <xsl:apply-templates
                            select="JournalOnlineFirst/Article/ArticleInfo/ArticleTitle"/>
                        <!-- All authors are included here -->
                        <xsl:apply-templates
                        select="JournalOnlineFirst/Article/ArticleHeader/AuthorGroup/Author"/>
                        <xsl:apply-templates
                            select="JournalOnlineFirst/Article/ArticleHeader/AuthorGroup/InstitutionalAuthor"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Title information related to the paper goes here -->
                        <xsl:apply-templates select="Volume/Issue/Article/ArticleInfo/ArticleTitle"
                        />
                        <!-- All authors are included here -->
                        <xsl:apply-templates
                        select="Volume/Issue/Article/ArticleHeader/AuthorGroup/Author"/>
                        <xsl:apply-templates
                            select="Volume/Issue/Article/ArticleHeader/AuthorGroup/InstitutionalAuthor"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="JournalOnlineFirst">
                        <xsl:apply-templates select="JournalOnlineFirst/Article/@ID"/>
                        <xsl:apply-templates select="JournalOnlineFirst/Article/ArticleInfo/ArticleDOI"/>
                        <xsl:apply-templates select="JournalOnlineFirst/Article/ArticleInfo/ArticleID"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="Volume/Issue/Article/@ID"/>
                        <xsl:apply-templates select="Volume/Issue/Article/ArticleInfo/ArticleDOI"/>
                        <xsl:apply-templates select="Volume/Issue/Article/ArticleInfo/ArticleID"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </analytic>
            <monogr>
                <xsl:apply-templates select="JournalInfo/JournalTitle"/>
                <xsl:apply-templates select="JournalInfo/JournalAbbreviatedTitle"/>
                <xsl:apply-templates select="JournalInfo/JournalID"/>
                <xsl:apply-templates select="JournalInfo/JournalPrintISSN"/>
                <xsl:apply-templates select="JournalInfo/JournalElectronicISSN"/>
                <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueTitle"/>
                <imprint>
                    <xsl:apply-templates select="../PublisherInfo/*"/>
                    <xsl:choose>
                        <xsl:when test="JournalOnlineFirst">
                            <xsl:if
                                test="JournalOnlineFirst/Article/ArticleInfo/ArticleHistory/OnlineDate and JournalOnlineFirst/Article/ArticleInfo/ArticleHistory/OnlineDate!=''">
                                <xsl:apply-templates
                                    select="JournalOnlineFirst/Article/ArticleInfo/ArticleHistory/OnlineDate"
                                    mode="inImprint"/>
                            </xsl:if>
                            <xsl:apply-templates
                                select="JournalOnlineFirst/Article/ArticleInfo/ArticleFirstPage"/>
                            <xsl:apply-templates
                                select="JournalOnlineFirst/Article/ArticleInfo/ArticleLastPage"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if
                                test="Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate 
                                and Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate!=''">
                                <xsl:apply-templates
                                    select="Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate"
                                    mode="inImprint"/>
                            </xsl:if>
                            <xsl:apply-templates
                                select="Volume/Issue/Article/ArticleInfo/ArticleFirstPage"/>
                            <xsl:apply-templates
                                select="Volume/Issue/Article/ArticleInfo/ArticleLastPage"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="Volume/VolumeInfo/VolumeIDStart"/>
                    <xsl:apply-templates select="Volume/VolumeInfo/VolumeIDEnd"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDStart"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDEnd"/>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>

</xsl:stylesheet>
