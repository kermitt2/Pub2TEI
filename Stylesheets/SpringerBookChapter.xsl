<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="/Publisher[count(Series/Book/descendant::Chapter)=1]">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates
                            select="Series/Book/descendant::Chapter/ChapterInfo/ChapterTitle"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:apply-templates
                            select="Series/Book/descendant::Chapter/ChapterInfo/ChapterCopyright"/>
                        <xsl:if test="//ArticleGrants/BodyPDFGrant[string(@Grant)='OpenAccess']">
                            <availability status="OpenAccess">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="Series" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:choose>
                    <xsl:when test="Journal/JournalOnlineFirst">

                        <xsl:if test="Journal/JournalOnlineFirst/Article/ArticleHeader/KeywordGroup">
                            <profileDesc>
                                <xsl:apply-templates
                                    select="Journal/JournalOnlineFirst/Article/ArticleHeader/KeywordGroup"
                                />
                            </profileDesc>
                        </xsl:if>
                        <xsl:if test="Journal/JournalOnlineFirst/Article/ArticleInfo/ArticleHistory">
                            <xsl:apply-templates
                                select="Journal/JournalOnlineFirst/Article/ArticleInfo/ArticleHistory"
                            />
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="Journal/Volume/Issue/Article/ArticleHeader/KeywordGroup">
                            <profileDesc>
								<!-- PL: abstract is moved to here from <front> -->
			                    <xsl:apply-templates
			                        select="Series/Book/descendant::Chapter/ChapterHeader/Abstract"/>
								
                                <xsl:apply-templates
                                    select="Journal/Volume/Issue/Article/ArticleHeader/KeywordGroup"
                                />
                            </profileDesc>
                        </xsl:if>
                        <xsl:if test="Journal/Volume/Issue/Article/ArticleInfo/ArticleHistory">
                            <xsl:apply-templates
                                select="Journal/Volume/Issue/Article/ArticleInfo/ArticleHistory"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>

            </teiHeader>
			<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
            <!--text>
                <front>
                    <xsl:apply-templates
                        select="Series/Book/descendant::Chapter/ChapterHeader/Abstract"/>
                </front>
            </text-->
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="Series" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="Book/descendant::Chapter/ChapterHeader/AuthorGroup/Author"/>
                <xsl:apply-templates
                    select="Book/descendant::Chapter/ChapterHeader//AuthorGroup/InstitutionalAuthor"/><!-- Title information related to the chapter goes here -->
                <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterTitle"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="Book//BookHeader/AuthorGroup/Author"/>
                <xsl:apply-templates select="Book/BookInfo/BookTitle"/>
                <xsl:apply-templates select="Book/BookInfo/BookSubTitle"/>
                <xsl:apply-templates select="Book/BookInfo/BookID"/>
                <imprint>
                    <xsl:apply-templates select="../PublisherInfo/*"/>
                    <xsl:if
                        test="Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate 
                                and Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate!=''">
                        <xsl:apply-templates
                            select="Volume/Issue/Article/ArticleInfo/ArticleHistory/OnlineDate"
                            mode="inImprint"/>
                    </xsl:if>
                    <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterFirstPage"/>
                    <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterLastPage"/>

                    <xsl:apply-templates select="Volume/VolumeInfo"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDStart"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDEnd"/>
                    <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterID"/>
                </imprint>
            </monogr>
            <series>
                <xsl:apply-templates select="SeriesHeader/AuthorGroup/Author"/>
                <xsl:apply-templates select="SeriesHeader/EditorGroup/Editor"/>
                <xsl:apply-templates select="SeriesInfo/SeriesTitle"/>
                <xsl:apply-templates select="SeriesInfo/SeriesPrintISSN"/>
                <xsl:apply-templates select="SeriesInfo/SeriesElectronicISSN"/>
                <xsl:apply-templates select="SeriesInfo/SeriesID"/>
            </series>



            <xsl:apply-templates select="Volume/Issue/Article/@ID"/>
            <xsl:apply-templates select="Book/descendant::Chapter/ChapterInfo/ChapterDOI"/>



        </biblStruct>
    </xsl:template>

    <xsl:template match="VolumeInfo">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
