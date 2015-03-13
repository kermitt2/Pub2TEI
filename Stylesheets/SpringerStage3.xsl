<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="/Publisher[not(Series/Book/descendant::Chapter)]">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="Journal//ArticleTitle"/>
                    </titleStmt>
                    <publicationStmt>
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
                </front>
            </text-->
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="Journal" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <xsl:choose>
                    <xsl:when test="JournalOnlineFirst">
                        <!-- All authors are included here -->
                        <xsl:apply-templates
                        select="JournalOnlineFirst/Article/ArticleHeader/AuthorGroup/Author"/>
                        <xsl:apply-templates
                            select="JournalOnlineFirst/Article/ArticleHeader/AuthorGroup/InstitutionalAuthor"/>
                        <!-- Title information related to the paper goes here -->
                        <xsl:apply-templates
                            select="JournalOnlineFirst/Article/ArticleInfo/ArticleTitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- All authors are included here -->
                        <xsl:apply-templates
                        select="Volume/Issue/Article/ArticleHeader/AuthorGroup/Author"/>
                        <xsl:apply-templates
                            select="Volume/Issue/Article/ArticleHeader/AuthorGroup/InstitutionalAuthor"/>
                        <!-- Title information related to the paper goes here -->
                        <xsl:apply-templates select="Volume/Issue/Article/ArticleInfo/ArticleTitle"
                        />
                    </xsl:otherwise>
                </xsl:choose>

            </analytic>
            <monogr>
                <xsl:apply-templates select="JournalInfo/JournalTitle"/>
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
                    <xsl:apply-templates select="Volume/VolumeInfo"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDStart"/>
                    <xsl:apply-templates select="Volume/Issue/IssueInfo/IssueIDEnd"/>
                </imprint>
            </monogr>

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

        </biblStruct>
    </xsl:template>
    
    <xsl:template match="VolumeInfo">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
