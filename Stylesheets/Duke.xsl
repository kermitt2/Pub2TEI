<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:variable name="codeGenreDuke">
        <xsl:value-of select="//record/@type"/>
    </xsl:variable>
    <xsl:variable name="codeGenreDuke2">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreDuke)='article'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='frontmatter'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='backmatter'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='review'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='index'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='books-received'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='correction'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='laws'">case-report</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='lists'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='news'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='correction'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='notes'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='problems'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='publications'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke)='retracted'">other</xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- lien vers data.istex.fr -->
    <xsl:variable name="codeGenreArkDuke">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenreDuke2)='research-article'">https://content-type.data.istex.fr/ark:/67375/XTP-1JC4F85T-7</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='article'">https://content-type.data.istex.fr/ark:/67375/XTP-6N5SZHKN-D</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='other'">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='book-reviews'">https://content-type.data.istex.fr/ark:/67375/XTP-PBH5VBM9-4</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='abstract'">https://content-type.data.istex.fr/ark:/67375/XTP-HPN7T1Q2-R</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='review-article'">https://content-type.data.istex.fr/ark:/67375/XTP-L5L7X3NF-P</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='brief-communication'">https://content-type.data.istex.fr/ark:/67375/XTP-S9SX2MFS-0</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='editorial'">https://content-type.data.istex.fr/ark:/67375/XTP-STW636XV-K</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='case-report'">https://content-type.data.istex.fr/ark:/67375/XTP-29919SZJ-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='conference'">https://content-type.data.istex.fr/ark:/67375/XTP-BFHXPBJJ-3</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='chapter'">https://content-type.data.istex.fr/ark:/67375/XTP-CGT4WMJM-6</xsl:when>
            <xsl:when test="normalize-space($codeGenreDuke2)='book'">https://content-type.data.istex.fr/ark:/67375/XTP-94FB0L8V-T</xsl:when>
        </xsl:choose>
    </xsl:variable>
    <!-- codeLangue -->
    
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="euclid_issue">
        <xsl:comment>
            <xsl:text>Version 0.1 générée le </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="issue/record/@lang"/>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <!-- SG - titre brut -->
                    <titleStmt>
                        <xsl:choose>
                            <xsl:when test="issue/record/title[string-length()&gt; 0]">
                                <xsl:for-each select="issue/record/title">
                                    <title level="a" type="main">
                                        <xsl:if test="@xml:lang">
                                            <xsl:attribute name="xml:lang">
                                                <xsl:value-of select="translate(@lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:apply-templates/>
                                    </title>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="//euclid_issue and //div">
                                    <title level="a" type="main" xml:lang="en">
                                        <xsl:text>Table of Contents</xsl:text>
                                    </title>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </titleStmt>
                    <xsl:if test="issue/record/record_filename[string-length() &gt; 0]">
                        <editionStmt>
                            <edition>
                                <xsl:for-each select="issue/record/record_filename">
                                    <ref type="{@filetype}">
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </ref>
                                </xsl:for-each>
                            </edition>
                        </editionStmt>
                    </xsl:if>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <publisher>Duke University Press</publisher>
                        <pubPlace>Durham, NC 27701, USA</pubPlace>
                        <availability>
                            <licence><p>©Duke University Press, Project Euclid, Durham, NC 27701,USA</p></licence>
                        </availability>
						<!-- date -->
                        <xsl:if test="issue/issue_data/issue_publ_date/@iso8601[string-length()&gt; 0]">
							<date type="published">
							    <xsl:attribute name="when">
							        <xsl:value-of select="issue/issue_data/issue_publ_date/@iso8601"/>
							    </xsl:attribute>
							    <xsl:value-of select="issue/issue_data/issue_publ_date/@iso8601"/>
							</date>
						</xsl:if>
                    </publicationStmt>
                    <notesStmt>
                        <!-- niveau article / chapter -->
                        <note type="content-type">
                            <xsl:attribute name="subtype">
                                <xsl:value-of select="$codeGenreDuke2"/>
                            </xsl:attribute>
                            <xsl:attribute name="source">
                                <xsl:value-of select="$codeGenreDuke"/>
                            </xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="$codeGenreArkDuke"/>
                            </xsl:attribute>
                            <xsl:value-of select="$codeGenreDuke2"/>
                        </note>
                        <!-- niveau revue -->
                        <note type="publication-type" subtype="journal">
                            <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0GLKJH51-B</xsl:attribute>
                            <xsl:text>journal</xsl:text>
                        </note>
                    </notesStmt>
                    <xsl:if test="//euclid_issue/issue/record">
                        <sourceDesc>
                            <xsl:apply-templates select="//euclid_issue/issue/record" mode="sourceDesc"/>
                        </sourceDesc>
                    </xsl:if>
                    <!-- toc -->
                    <xsl:if test="//euclid_issue/issue/div/record">
                        <sourceDesc>
                            <xsl:apply-templates select="issue" mode="sourceDescDiv"/>
                        </sourceDesc>
                    </xsl:if>
                </fileDesc>
                
                <xsl:if test="issue/record/abstract[string-length() &gt; 0] |issue/record/abstract[string-length() &gt; 0]">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
                        <xsl:if test="issue/record/abstract[string-length() &gt; 0]">
                            <!-- SG - reprise de tous les abstracts -->
                            <xsl:for-each select="issue/record/abstract[string-length() &gt; 0]">
                            <abstract>
                                <xsl:if test="@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="translate(@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:apply-templates/>
							</abstract>
                            </xsl:for-each>
		                </xsl:if>
                        <xsl:if test="issue/record/subjects[string-length() &gt; 0]">
                            <textClass ana="subject">
                                <xsl:apply-templates select="issue/record/subjects"/>
                            </textClass>
                        </xsl:if>
                        <xsl:if test="issue/record/@lang">
                        <langUsage>
                            <language>
                                <xsl:attribute name="ident">
                                    <xsl:value-of select="translate(issue/record/@lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                </xsl:attribute>
                            </language>
                        </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
            </teiHeader>
            <text>
                <!-- pas de body dans les notices -->
                <body>
                    <xsl:choose>
                        <!-- body seulement pour les table of contents -->
                        <xsl:when test="//euclid_issue/issue/div/record">
                            <xsl:apply-templates select="//euclid_issue/issue/div/record" mode="bodyDiv"/>
                        </xsl:when>
                        <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                            <div>
                                <p><xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/></p>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <div><p></p></div>
                        </xsl:otherwise>
                    </xsl:choose>
                </body>
            </text>
        </TEI>
    </xsl:template>
	
    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="record" mode="sourceDesc">
        <biblStruct>
            <!-- Genre     -->
            <xsl:if test="@type[string-length()&gt; 0]">
                <xsl:attribute name="type">
                    <xsl:value-of select="normalize-space(@type)"/>
                </xsl:attribute>
            </xsl:if>
            <analytic>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="title"/>
				
                <!-- All authors are included here -->
					<xsl:apply-templates select="author"/>
                
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
                <xsl:if test="identifiers/identifier[string-length() &gt; 0]">
                    <xsl:for-each select="identifiers/identifier">
                        <idno type="{@type}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                    <idno type="issue-identifier">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                    </idno>
                </xsl:if>
            </analytic>
            <monogr>
                <title level="j" type="main">Duke Mathematical Journal</title>
                <!-- ********************************** Identifier *******************************-->
                <idno type="pISSN">0012-7094</idno>
                <idno type="eISSN">1547-7398</idno>
                <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                    <idno type="publisher-id">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                    </idno>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                    <idno type="issue-identifier">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                    </idno>
                </xsl:if>
                <xsl:if test="/euclid_issue/issue/issue_data/identifiers/identifier[string-length() &gt; 0]">
                    <xsl:for-each select="/euclid_issue/issue/issue_data/identifiers/identifier">
                        <idno type="{@type}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                    <idno type="publisher-id">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                    </idno>
                </xsl:if>
                <!-- ********************************** Editor *******************************-->
                <xsl:if test="/euclid_issue/issue/issue_data/editorial_board/editor">
                    <xsl:apply-templates select="/euclid_issue/issue/issue_data/editorial_board/editor"/>
                </xsl:if>
                <imprint>
                    <xsl:apply-templates select="/euclid_issue/issue/issue_data/journal_vol_number"/>
                    <xsl:apply-templates select="/euclid_issue/issue/issue_data/issue_number"/>
                    <xsl:apply-templates select="/euclid_issue/issue/issue_data/start_page"/>
                    <xsl:apply-templates select="/euclid_issue/issue/issue_data/end_page"/>
                    <xsl:apply-templates select="/euclid_issue/issue/record/start_page"/>
                    <xsl:apply-templates select="/euclid_issue/issue/record/end_page"/>
                    <xsl:if test="//issue/issue_data/issue_publ_date/@iso8601">
						<date type="published">
						    <xsl:attribute name="when">
						        <xsl:value-of select="normalize-space(//issue/issue_data/issue_publ_date/@iso8601)"/>
						    </xsl:attribute>
						</date>
					</xsl:if>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>
    
    <xsl:template match="issue" mode="sourceDescDiv">
        <biblStruct type="toc">
            <analytic>
                <!-- Title information related to the paper goes here -->
                <title level="a" type="main" xml:lang="en">Table of Contents</title>
                
                <!-- All authors are included here -->
                <xsl:apply-templates select="author"/>
                
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
                <xsl:if test="identifiers/identifier[string-length() &gt; 0]">
                    <xsl:for-each select="identifiers/identifier">
                        <idno type="{@type}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                    <idno type="issue-identifier">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                    </idno>
                </xsl:if>
            </analytic>
            <monogr>
                <title level="j" type="main">Duke Mathematical Journal</title>
                <!-- ********************************** Identifier *******************************-->
                <idno type="pISSN">0012-7094</idno>
                <idno type="eISSN">1547-7398</idno>
                <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                    <idno type="publisher-id">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                    </idno>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                    <idno type="issue-identifier">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                    </idno>
                </xsl:if>
                <xsl:if test="issue_data/identifiers/identifier[string-length() &gt; 0]">
                    <xsl:for-each select="issue_data/identifiers/identifier">
                        <idno type="{@type}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </idno>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                    <idno type="publisher-id">
                        <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                    </idno>
                </xsl:if>
                <!-- ********************************** Editor *******************************-->
                <xsl:if test="issue_data/editorial_board/editor">
                    <xsl:apply-templates select="issue_data/editorial_board/editor"/>
                </xsl:if>
                <imprint>
                    <xsl:apply-templates select="issue_data/journal_vol_number"/>
                    <xsl:apply-templates select="issue_data/issue_number"/>
                    <xsl:apply-templates select="issue_data/start_page"/>
                    <xsl:apply-templates select="issue_data/end_page"/>
                    <xsl:if test="//issue/issue_data/issue_publ_date/@iso8601">
                        <date type="published">
                            <xsl:attribute name="when">
                                <xsl:value-of select="normalize-space(//issue/issue_data/issue_publ_date/@iso8601)"/>
                            </xsl:attribute>
                        </date>
                    </xsl:if>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>
    <!-- back toc -->
    <xsl:template match="record" mode="bodyDiv">
        <div type="toc">
            <!-- Genre     -->
            <xsl:if test="@type[string-length()&gt; 0]">
                <xsl:attribute name="type">
                    <xsl:value-of select="normalize-space(@type)"/>
                </xsl:attribute>
            </xsl:if>
            <biblFull>
                <fileDesc>
                <!-- Title information related to the paper goes here -->
                <titleStmt>
                    <xsl:apply-templates select="title"/>
                </titleStmt>
                    <xsl:if test="record_filename[string-length() &gt; 0]">
                        <editionStmt>
                            <edition>
                                <xsl:for-each select="record_filename">
                                    <ref type="{@filetype}">
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </ref>
                                </xsl:for-each>
                            </edition>
                        </editionStmt>
                    </xsl:if>
                <publicationStmt>
                    <publisher>Duke University Press</publisher>
                </publicationStmt>
                <sourceDesc>
                    <biblStruct type="toc">
                        <analytic>
                            <xsl:apply-templates select="title"/>
                            <xsl:if test="identifiers/identifier[string-length() &gt; 0]">
                                <xsl:for-each select="identifiers/identifier">
                                    <idno type="{@type}">
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </idno>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                                <idno type="issue-identifier">
                                    <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                                </idno>
                            </xsl:if>
                            <!-- All authors are included here -->
                            <xsl:apply-templates select="author"/>
                        </analytic>
                        <monogr>
                            <title level="j" type="main">Duke Mathematical Journal</title>
                            <!-- ********************************** Identifier *******************************-->
                            <idno type="pISSN">0012-7094</idno>
                            <idno type="eISSN">1547-7398</idno>
                            <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                                <idno type="publisher-id">
                                    <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                                </idno>
                            </xsl:if>
                            <xsl:if test="/euclid_issue/header/issue_identifier[string-length() &gt; 0]">
                                <idno type="issue-identifier">
                                    <xsl:value-of select="normalize-space(/euclid_issue/header/issue_identifier)"/>
                                </idno>
                            </xsl:if>
                            <xsl:if test="/euclid_issue/issue/issue_data/identifiers/identifier[string-length() &gt; 0]">
                                <xsl:for-each select="/euclid_issue/issue/issue_data/identifiers/identifier">
                                    <idno type="{@type}">
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </idno>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test="/euclid_issue/header/euclid_journal_id[string-length() &gt; 0]">
                                <idno type="publisher-id">
                                    <xsl:value-of select="normalize-space(/euclid_issue/header/euclid_journal_id)"/>
                                </idno>
                            </xsl:if>
                            <imprint>
                                <xsl:apply-templates select="start_page[string-length() &gt; 0]"/>
                                <xsl:apply-templates select="end_page[string-length() &gt; 0]"/>
                                <xsl:if test="//issue/issue_data/issue_publ_date/@iso8601">
                                    <date type="published">
                                        <xsl:attribute name="when">
                                            <xsl:value-of select="normalize-space(//issue/issue_data/issue_publ_date/@iso8601)"/>
                                        </xsl:attribute>
                                    </date>
                                </xsl:if>
                            </imprint>
                        </monogr>
                        <xsl:if test="related_item">
                            <relatedItem>
                                <bibl>
                                    <xsl:if test="related_item/label">
                                        <title level="a" type="sub">
                                            <xsl:value-of select="related_item/label"/>
                                        </title>
                                    </xsl:if>
                                    <xsl:apply-templates select="related_item/citation"/>
                                    <xsl:apply-templates select="related_item/citation/identifiers"/>
                                    <xsl:apply-templates select="related_item/citation/identifiers/identifier"/>
                                </bibl>
                            </relatedItem>
                        </xsl:if>
                    </biblStruct>
                </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <xsl:if test="abstract | subjects">
                        <xsl:apply-templates select="abstract"/>
                        <textClass>
                            <xsl:apply-templates select="subjects"/>
                        </textClass>
                    </xsl:if>
                </profileDesc>
            </biblFull>
        </div>
    </xsl:template>
    <!-- author related information -->
    <xsl:template match="author">
        <author>
            <xsl:if test="not(//euclid_issue/issue/div)">
            <xsl:attribute name="xml:id">
                <xsl:variable name="i" select="position()-1"/>
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
            </xsl:attribute>
            </xsl:if>
            <!-- affiliation mis en exception pour ne pas interferer avec feuille scholarOne -->
            <xsl:apply-templates select="* except(affiliation)"/>
            <!-- reprise de l'affiliation -->
            <xsl:if test="affiliation">
                <xsl:apply-templates select="affiliation" mode="Duke"/>
            </xsl:if>
        </author>
    </xsl:template>
    
    <!-- editor related information -->
    <xsl:template match="editorial_board">
		 <xsl:apply-templates select="creator"/>
	</xsl:template>
    <xsl:template match="affiliation" mode="Duke">
            <affiliation>
                <xsl:if test="organization">
                    <orgName>
                        <xsl:value-of select="organization"/>
                    </orgName>
                </xsl:if>
                <xsl:if test="department">
                    <orgName type="department">
                        <xsl:value-of select="department"/>
                    </orgName>
                </xsl:if>
                <xsl:if test="address">
                    <address>
                        <xsl:if test="address/addressline">
                            <addrLine>
                                <xsl:value-of select="address/addressline"/>
                            </addrLine>
                        </xsl:if>
					</address>
                </xsl:if>
            </affiliation>
    </xsl:template>
    <!-- tomaison-->
    <xsl:template match="/euclid_issue/issue/issue_data/journal_vol_number">
        <biblScope unit="vol">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <xsl:template match="/euclid_issue/issue/issue_data/issue_number">
        <biblScope unit="issue">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <!-- pagination niveau issue-->
    <xsl:template match="/euclid_issue/issue/issue_data/start_page">
        <biblScope unit="issue-page" from="{normalize-space(.)}">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <xsl:template match="/euclid_issue/issue/issue_data/end_page">
        <biblScope unit="issue-page" to="{normalize-space(.)}">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <!-- pagination niveau article-->
    <xsl:template match="start_page">
        <biblScope unit="page" from="{normalize-space(.)}">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <xsl:template match="end_page">
        <biblScope unit="page" to="{normalize-space(.)}">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <!--relatedItem-->
    <xsl:template match="related_item/citation">
            <xsl:apply-templates/>
    </xsl:template>
    <!--relatedItem idno-->
    <xsl:template match="related_item/citation/identifiers/identifier">
        <idno type="{@type}">
        <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <!-- subject -->
    <xsl:template match="subjects">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="subject">
                            <xsl:variable name="mscSubjectCode">
                                <xsl:value-of select="."/>
                            </xsl:variable>
                            <xsl:variable name="mscSubjectVerb">
                                <xsl:choose>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00-XX'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00Axx'">General and miscellaneous specific topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A05'">General mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A06'">Mathematics for nonmathematicians (engineering, social sciences, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A07'">Problem books</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A08'">Recreational mathematics [See also 97A20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A09'">Popularization of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A15'">Bibliographies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A17'">External book reviews</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A20'">Dictionaries and other general reference works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A22'">Formularies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A30'">Philosophy of mathematics [See also 03A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A35'">Methodology of mathematics, didactics [See also 97Cxx, 97Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A65'">Mathematics and music</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A66'">Mathematics and visual arts, visualization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A67'">Mathematics and architecture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A69'">General applied mathematics {For physics, see 00A79 and Sections 70 through 86}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A71'">Theory of mathematical modeling</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A72'">General methods of simulation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A73'">Dimensional analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A79'">Physics (use more specific entries from Sections 70 through 86 when possible)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00Bxx'">Conference proceedings and collections of papers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B05'">Collections of abstracts of lectures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B10'">Collections of articles of general interest</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B15'">Collections of articles of miscellaneous specific content</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B20'">Proceedings of conferences of general interest</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B25'">Proceedings of conferences of miscellaneous specific interest</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B30'">Festschriften</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B50'">Volumes of selected translations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B55'">Miscellaneous volumes of translations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B60'">Collections of reprinted articles [See also 01A75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='00B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-XX'">History and biography [See also the classification number--03 in the other sections]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01Axx'">History of mathematics and mathematicians</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A05'">General histories, source books</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A07'">Ethnomathematics, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A10'">Paleolithic, Neolithic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A12'">Indigenous cultures of the Americas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A13'">Other indigenous cultures (non-European)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A15'">Indigenous European cultures (pre-Greek, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A16'">Egyptian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A17'">Babylonian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A20'">Greek, Roman</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A25'">China</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A27'">Japan</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A29'">Southeast Asia</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A30'">Islam (Medieval)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A32'">India</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A35'">Medieval</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A40'">15th and 16th centuries, Renaissance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A45'">17th century</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A50'">18th century</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A55'">19th century</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A60'">20th century</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A61'">Twenty-first century</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A65'">Contemporary</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A67'">Future prospectives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A70'">Biographies, obituaries, personalia, bibliographies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A72'">Schools of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A73'">Universities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A74'">Other institutions and academies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A75'">Collected or selected works; reprintings or translations of classics [See also 00B60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A80'">Sociology (and profession) of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A85'">Historiography</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A90'">Bibliographic studies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='01A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-XX'">Mathematical logic and foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Axx'">Philosophical aspects of logic and foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03A05'">Philosophical and critical {For philosophy of mathematics, see also 00A30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03A10'">Logic in the philosophy of science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Bxx'">General logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B05'">Classical propositional logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B10'">Classical first-order logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B15'">Higher-order logic and type theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B20'">Subsystems of classical logic (including intuitionistic logic)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B22'">Abstract deductive systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B25'">Decidability of theories and sets of sentences [See also 11U05, 12L05, 20F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B30'">Foundations of classical theories (including reverse mathematics) [See also 03F35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B35'">Mechanization of proofs and logical operations [See also 68T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B40'">Combinatory logic and lambda-calculus [See also 68N18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B42'">Logics of knowledge and belief (including belief change)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B44'">Temporal logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B45'">Modal logic (including the logic of norms) {For knowledge and belief, see 03B42; for temporal logic, see 03B44; for provability logic, see also 03F45}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B47'">Substructural logics (including relevance, entailment, linear logic, Lambek calculus, BCK and BCI logics) {For proof-theoretic aspects see 03F52}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B48'">Probability and inductive logic [See also 60A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B50'">Many-valued logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B52'">Fuzzy logic; logic of vagueness [See also 68T27, 68T37, 94D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B53'">Paraconsistent logics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B55'">Intermediate logics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B60'">Other nonclassical logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B62'">Combined logics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B65'">Logic of natural languages [See also 68T50, 91F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B70'">Logic in computer science [See also 68-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B80'">Other applications of logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Cxx'">Model theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C05'">Equational classes, universal algebra [See also 08Axx, 08Bxx, 18C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C07'">Basic properties of first-order languages and structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C10'">Quantifier elimination, model completeness and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C13'">Finite structures [See also 68Q15, 68Q19]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C15'">Denumerable structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C20'">Ultraproducts and related constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C25'">Model-theoretic forcing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C30'">Other model constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C35'">Categoricity and completeness of theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C40'">Interpolation, preservation, definability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C45'">Classification theory, stability and related concepts [See also 03C48]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C48'">Abstract elementary classes and related topics [See also 03C45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C50'">Models with special properties (saturated, rigid, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C52'">Properties of classes of models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C55'">Set-theoretic model theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C57'">Effective and recursion-theoretic model theory [See also 03D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C60'">Model-theoretic algebra [See also 08C10, 12Lxx, 13L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C62'">Models of arithmetic and set theory [See also 03Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C64'">Model theory of ordered structures; o-minimality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C65'">Models of other mathematical theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C68'">Other classical first-order model theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C70'">Logic on admissible sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C75'">Other infinitary logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C80'">Logic with extra quantifiers and operators [See also 03B42, 03B44, 03B45, 03B48]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C85'">Second- and higher-order model theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C90'">Nonclassical models (Boolean-valued, sheaf, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C95'">Abstract model theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C98'">Applications of model theory [See also 03C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Dxx'">Computability and recursion theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D03'">Thue and Post systems, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D05'">Automata and formal grammars in connection with logical questions [See also 68Q45, 68Q70, 68R15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D10'">Turing machines and related notions [See also 68Q05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D15'">Complexity of computation (including implicit computational complexity) [See also 68Q15, 68Q17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D20'">Recursive functions and relations, subrecursive hierarchies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D25'">Recursively (computably) enumerable sets and degrees</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D28'">Other Turing degree structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D30'">Other degrees and reducibilities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D32'">Algorithmic randomness and dimension [See also 68Q30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D35'">Undecidability and degrees of sets of sentences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D40'">Word problems, etc. [See also 06B25, 08A50, 20F10, 68R15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D45'">Theory of numerations, effectively presented structures [See also 03C57; for intuitionistic and similar approaches see 03F55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D50'">Recursive equivalence types of sets and structures, isols</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D55'">Hierarchies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D60'">Computability and recursion theory on ordinals, admissible sets, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D65'">Higher-type and set recursion theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D70'">Inductive definability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D75'">Abstract and axiomatic computability and recursion theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D78'">Computation over the reals {For constructive aspects, see 03F60}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D80'">Applications of computability and recursion theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Exx'">Set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E02'">Partition relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E04'">Ordered sets and their cofinalities; pcf theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E05'">Other combinatorial set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E10'">Ordinal and cardinal numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E15'">Descriptive set theory [See also 28A05, 54H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E17'">Cardinal characteristics of the continuum</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E20'">Other classical set theory (including functions, relations, and set algebra)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E25'">Axiom of choice and related propositions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E30'">Axiomatics of classical set theory and its fragments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E35'">Consistency and independence results</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E40'">Other aspects of forcing and Boolean-valued models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E45'">Inner models, including constructibility, ordinal definability, and core models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E47'">Other notions of set-theoretic definability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E50'">Continuum hypothesis and Martin's axiom [See also 03E57]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E55'">Large cardinals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E57'">Generic absoluteness and forcing axioms [See also 03E50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E60'">Determinacy principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E65'">Other hypotheses and axioms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E70'">Nonclassical and second-order set theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E72'">Fuzzy set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E75'">Applications of set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Fxx'">Proof theory and constructive mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F03'">Proof theory, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F05'">Cut-elimination and normal-form theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F07'">Structure of proofs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F10'">Functionals in proof theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F15'">Recursive ordinals and ordinal notations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F20'">Complexity of proofs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F25'">Relative consistency and interpretations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F30'">First-order arithmetic and fragments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F35'">Second- and higher-order arithmetic and fragments [See also 03B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F40'">G&#xC3;&#xB6;del numberings and issues of incompleteness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F45'">Provability logics and related algebras (e.g., diagonalizable algebras) [See also 03B45, 03G25, 06E25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F50'">Metamathematics of constructive systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F52'">Linear logic and other substructural logics [See also 03B47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F55'">Intuitionistic mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F60'">Constructive and recursive analysis [See also 03B30, 03D45, 03D78, 26E40, 46S30, 47S30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F65'">Other constructive mathematics [See also 03D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Gxx'">Algebraic logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G05'">Boolean algebras [See also 06Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G10'">Lattices and related structures [See also 06Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G12'">Quantum logic [See also 06C15, 81P10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G15'">Cylindric and polyadic algebras; relation algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G20'">&#xC5;&#x81;ukasiewicz and Post algebras [See also 06D25, 06D30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G25'">Other algebras related to logic [See also 03F45, 06D20, 06E25, 06F35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G27'">Abstract algebraic logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G30'">Categorical logic, topoi [See also 18B25, 18C05, 18C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03Hxx'">Nonstandard models [See also 03C62]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03H05'">Nonstandard models in mathematics [See also 26E35, 28E05, 30G06, 46S20, 47S20, 54J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03H10'">Other applications of nonstandard models (economics, physics, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03H15'">Nonstandard models of arithmetic [See also 11U10, 12L15, 13L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='03H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-XX'">Combinatorics {For finite fields, see 11Txx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05Axx'">Enumerative combinatorics {For enumeration in graph theory, see 05C30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A05'">Permutations, words, matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A10'">Factorials, binomial coefficients, combinatorial functions [See also 11B65, 33Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A15'">Exact enumeration problems, generating functions [See also 33Cxx, 33Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A16'">Asymptotic enumeration</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A17'">Partitions of integers [See also 11P81, 11P82, 11P83]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A18'">Partitions of sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A19'">Combinatorial identities, bijective combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A20'">Combinatorial inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A30'">$q$-calculus and related topics [See also 33Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A40'">Umbral calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05Bxx'">Designs and configurations {For applications of design theory, see 94C30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B05'">Block designs [See also 51E05, 62K10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B07'">Triple systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B10'">Difference sets (number-theoretic, group-theoretic, etc.) [See also 11B13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B15'">Orthogonal arrays, Latin squares, Room squares</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B20'">Matrices (incidence, Hadamard, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B25'">Finite geometries [See also 51D20, 51Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B30'">Other designs, configurations [See also 51E30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B35'">Matroids, geometric lattices [See also 52B40, 90C27]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B40'">Packing and covering [See also 11H31, 52C15, 52C17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B45'">Tessellation and tiling problems [See also 52C20, 52C22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B50'">Polyominoes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05Cxx'">Graph theory {For applications of graphs, see 68R10, 81Q30, 81T15, 82B20, 82C20, 90C35, 92E10, 94C15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C05'">Trees</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C07'">Vertex degrees [See also 05E30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C10'">Planar graphs; geometric and topological aspects of graph theory [See also 57M15, 57M25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C12'">Distance in graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C15'">Coloring of graphs and hypergraphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C17'">Perfect graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C20'">Directed graphs (digraphs), tournaments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C21'">Flows in graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C22'">Signed and weighted graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C25'">Graphs and abstract algebra (groups, rings, fields, etc.) [See also 20F65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C30'">Enumeration in graph theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C31'">Graph polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C35'">Extremal problems [See also 90C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C38'">Paths and cycles [See also 90B10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C40'">Connectivity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C42'">Density (toughness, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C45'">Eulerian and Hamiltonian graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C50'">Graphs and linear algebra (matrices, eigenvalues, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C51'">Graph designs and isomomorphic decomposition [See also 05B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C55'">Generalized Ramsey theory [See also 05D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C57'">Games on graphs [See also 91A43, 91A46]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C60'">Isomorphism problems (reconstruction conjecture, etc.) and homomorphisms (subgraph embedding, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C62'">Graph representations (geometric and intersection representations, etc.) {For graph drawing, see also 68R10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C63'">Infinite graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C65'">Hypergraphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C69'">Dominating sets, independent sets, cliques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C70'">Factorization, matching, partitioning, covering and packing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C72'">Fractional graph theory, fuzzy graph theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C75'">Structural characterization of families of graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C76'">Graph operations (line graphs, products, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C78'">Graph labelling (graceful graphs, bandwidth, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C80'">Random graphs [See also 60B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C81'">Random walks on graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C82'">Small world graphs, complex networks [See also 90Bxx, 91D30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C83'">Graph minors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C85'">Graph algorithms [See also 68R10, 68W05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C90'">Applications [See also 68R10, 81Q30, 81T15, 82B20, 82C20, 90C35, 92E10, 94C15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05Dxx'">Extremal combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05D05'">Extremal set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05D10'">Ramsey theory [See also 05C55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05D15'">Transversal (matching) theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05D40'">Probabilistic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05Exx'">Algebraic combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E05'">Symmetric functions and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E10'">Combinatorial aspects of representation theory [See also 20C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E15'">Combinatorial aspects of groups and algebras [See also 14Nxx, 22E45, 33C80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E18'">Group actions on combinatorial structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E30'">Association schemes, strongly regular graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E40'">Combinatorial aspects of commutative algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E45'">Combinatorial aspects of simplicial complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='05E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-XX'">Order, lattices, ordered algebraic structures [See also 18B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Axx'">Ordered sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A05'">Total order</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A06'">Partial order, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A07'">Combinatorics of partially ordered sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A11'">Algebraic aspects of posets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A12'">Semilattices [See also 20M10; for topological semilattices see 22A26]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A15'">Galois correspondences, closure operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A75'">Generalizations of ordered sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Bxx'">Lattices [See also 03G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B05'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B10'">Ideals, congruence relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B15'">Representation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B20'">Varieties of lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B23'">Complete lattices, completions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B25'">Free lattices, projective lattices, word problems [See also 03D40, 08A50, 20F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B30'">Topological lattices, order topologies [See also 06F30, 22A26, 54F05, 54H12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B35'">Continuous lattices and posets, applications [See also 06B30, 06D10, 06F30, 18B35, 22A26, 68Q55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B75'">Generalizations of lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Cxx'">Modular lattices, complemented lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06C05'">Modular lattices, Desarguesian lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06C10'">Semimodular lattices, geometric lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06C15'">Complemented lattices, orthocomplemented lattices and posets [See also 03G12, 81P10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06C20'">Complemented modular lattices, continuous geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Dxx'">Distributive lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D05'">Structure and representation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D10'">Complete distributivity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D15'">Pseudocomplemented lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D20'">Heyting algebras [See also 03G25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D22'">Frames, locales {For topological questions see 54-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D25'">Post algebras [See also 03G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D30'">De Morgan algebras, &#xC5;&#x81;ukasiewicz algebras [See also 03G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D35'">MV-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D50'">Lattices and duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D72'">Fuzzy lattices (soft algebras) and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D75'">Other generalizations of distributive lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Exx'">Boolean algebras (Boolean rings) [See also 03G05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E05'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E10'">Chain conditions, complete algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E15'">Stone spaces (Boolean spaces) and related structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E20'">Ring-theoretic properties [See also 16E50, 16G30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E25'">Boolean algebras with additional operations (diagonalizable algebras, etc.) [See also 03G25, 03F45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E30'">Boolean functions [See also 94C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E75'">Generalizations of Boolean algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06Fxx'">Ordered structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F05'">Ordered semigroups and monoids [See also 20Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F07'">Quantales</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F10'">Noether lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F15'">Ordered groups [See also 20F60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F20'">Ordered abelian groups, Riesz groups, ordered linear spaces [See also 46A40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F25'">Ordered rings, algebras, modules {For ordered fields, see 12J15; see also 13J25, 16W80}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F30'">Topological lattices, order topologies [See also 06B30, 22A26, 54F05, 54H12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F35'">BCK-algebras, BCI-algebras [See also 03G25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='06F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-XX'">General algebraic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08Axx'">Algebraic structures [See also 03C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A02'">Relational systems, laws of composition</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A05'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A30'">Subalgebras, congruence relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A35'">Automorphisms, endomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A40'">Operations, polynomials, primal algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A45'">Equational compactness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A50'">Word problems [See also 03D40, 06B25, 20F10, 68R15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A55'">Partial algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A60'">Unary algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A62'">Finitary algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A65'">Infinitary algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A68'">Heterogeneous algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A70'">Applications of universal algebra in computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A72'">Fuzzy algebraic structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08Bxx'">Varieties [See also 03C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B05'">Equational logic, Mal&#x27;cev (Mal&#x27;tsev) conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B10'">Congruence modularity, congruence distributivity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B15'">Lattices of varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B20'">Free algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B25'">Products, amalgamated products, and other kinds of limits and colimits [See also 18A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B26'">Subdirect products and subdirect irreducibility</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B30'">Injectives, projectives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08Cxx'">Other classes of algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08C05'">Categories of algebras [See also 18C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08C10'">Axiomatic model classes [See also 03Cxx, in particular 03C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08C15'">Quasivarieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08C20'">Natural dualities for classes of algebras [See also 06E15, 18A40, 22A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='08C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-XX'">Number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Axx'">Elementary number theory {For analogues in number fields, see 11R04}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A05'">Multiplicative structure; Euclidean algorithm; greatest common divisors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A07'">Congruences; primitive roots; residue systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A15'">Power residues, reciprocity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A25'">Arithmetic functions; related numbers; inversion formulas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A41'">Primes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A51'">Factorization; primality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A55'">Continued fractions {For approximation results, see 11J70} [See also 11K50, 30B70, 40A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A63'">Radix representation; digital problems {For metric results, see 11K16}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A67'">Other representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Bxx'">Sequences and sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B05'">Density, gaps, topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B13'">Additive bases, including sumsets [See also 05B10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B25'">Arithmetic progressions [See also 11N13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B30'">Arithmetic combinatorics; higher degree uniformity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B34'">Representation functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B37'">Recurrences {For applications to special functions, see 33-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B39'">Fibonacci and Lucas numbers and polynomials and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B50'">Sequences (mod $m$)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B57'">Farey sequences; the sequences ${1^k, 2^k, \cdots}$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B65'">Binomial coefficients; factorials; $q$-identities [See also 05A10, 05A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B68'">Bernoulli and Euler numbers and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B73'">Bell and Stirling numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B75'">Other combinatorial number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B83'">Special sequences and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B85'">Automata sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Cxx'">Polynomials and matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11C08'">Polynomials [See also 13F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11C20'">Matrices, determinants [See also 15B36]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Dxx'">Diophantine equations [See also 11Gxx, 14Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D04'">Linear equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D07'">The Frobenius problem</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D09'">Quadratic and bilinear equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D25'">Cubic and quartic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D41'">Higher degree equations; Fermat's equation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D45'">Counting solutions of Diophantine equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D57'">Multiplicative and norm form equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D59'">Thue-Mahler equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D61'">Exponential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D68'">Rational numbers as sums of fractions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D72'">Equations in many variables [See also 11P55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D75'">Diophantine inequalities [See also 11J25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D79'">Congruences in many variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D85'">Representation problems [See also 11P55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D88'">$p$-adic and power series fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Exx'">Forms and linear algebraic groups [See also 19Gxx] {For quadratic forms in linear algebra, see 15A63}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E04'">Quadratic forms over general fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E08'">Quadratic forms over local rings and fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E10'">Forms over real fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E12'">Quadratic forms over global rings and fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E16'">General binary quadratic forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E20'">General ternary and quaternary quadratic forms; forms of more than two variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E25'">Sums of squares and representations by other particular quadratic forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E39'">Bilinear and Hermitian forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E41'">Class numbers of quadratic and Hermitian forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E45'">Analytic theory (Epstein zeta functions; relations with automorphic forms and functions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E57'">Classical groups [See also 14Lxx, 20Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E70'">$K$-theory of quadratic and Hermitian forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E72'">Galois cohomology of linear algebraic groups [See also 20G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E76'">Forms of degree higher than two</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E81'">Algebraic theory of quadratic forms; Witt groups and rings [See also 19G12, 19G24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E88'">Quadratic spaces; Clifford algebras [See also 15A63, 15A66]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E95'">$p$-adic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Fxx'">Discontinuous groups and automorphic forms [See also 11R39, 11S37, 14Gxx, 14Kxx, 22E50, 22E55, 30F35, 32Nxx] {For relations with quadratic forms, see 11E45}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F03'">Modular and automorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F06'">Structure of modular groups and generalizations; arithmetic groups [See also 20H05, 20H10, 22E40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F11'">Holomorphic modular forms of integral weight</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F12'">Automorphic forms, one variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F20'">Dedekind eta function, Dedekind sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F22'">Relationship to Lie algebras and finite simple groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F23'">Relations with algebraic geometry and topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F25'">Hecke-Petersson operators, differential operators (one variable)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F27'">Theta series; Weil representation; theta correspondences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F30'">Fourier coefficients of automorphic forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F32'">Modular correspondences, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F33'">Congruences for modular and $p$-adic modular forms [See also 14G20, 22E50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F37'">Forms of half-integer weight; nonholomorphic modular forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F41'">Automorphic forms on ${\rm GL}(2)$; Hilbert and Hilbert-Siegel modular groups and their modular and automorphic forms; Hilbert modular surfaces [See also 14J20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F46'">Siegel modular groups; Siegel and Hilbert-Siegel modular and automorphic forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F50'">Jacobi forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F52'">Modular forms associated to Drinfel&#x27;d modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F55'">Other groups and their modular and automorphic forms (several variables)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F60'">Hecke-Petersson operators, differential operators (several variables)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F66'">Langlands $L$-functions; one variable Dirichlet series and functional equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F67'">Special values of automorphic $L$-series, periods of modular forms, cohomology, modular symbols</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F68'">Dirichlet series in several complex variables associated to automorphic forms; Weyl group multiple Dirichlet series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F70'">Representation-theoretic methods; automorphic representations over local and global fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F72'">Spectral theory; Selberg trace formula</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F75'">Cohomology of arithmetic groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F80'">Galois representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F85'">$p$-adic theory, local fields [See also 14G20, 22E50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Gxx'">Arithmetic algebraic geometry (Diophantine geometry) [See also 11Dxx, 14Gxx, 14Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G05'">Elliptic curves over global fields [See also 14H52]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G07'">Elliptic curves over local fields [See also 14G20, 14H52]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G09'">Drinfel&#x27;d modules; higher-dimensional motives, etc. [See also 14L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G10'">Abelian varieties of dimension $> 1$ [See also 14Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G15'">Complex multiplication and moduli of abelian varieties [See also 14K22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G16'">Elliptic and modular units [See also 11R27]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G18'">Arithmetic aspects of modular and Shimura varieties [See also 14G35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G20'">Curves over finite and local fields [See also 14H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G25'">Varieties over finite and local fields [See also 14G15, 14G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G30'">Curves of arbitrary genus or genus $\ne 1$ over global fields [See also 14H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G32'">Dessins d'enfants, Bely&#xC4;&#xAD; theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G35'">Varieties over global fields [See also 14G25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G40'">$L$-functions of varieties over global fields; Birch-Swinnerton-Dyer conjecture [See also 14G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G42'">Arithmetic mirror symmetry [See also 14J33]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G45'">Geometric class field theory [See also 11R37, 14C35, 19F05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G50'">Heights [See also 14G40, 37P30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G55'">Polylogarithms and relations with $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Hxx'">Geometry of numbers {For applications in coding theory, see 94B75}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H06'">Lattices and convex bodies [See also 11P21, 52C05, 52C07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H16'">Nonconvex bodies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H31'">Lattice packing and covering [See also 05B40, 52C15, 52C17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H46'">Products of linear forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H50'">Minima of forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H55'">Quadratic forms (reduction theory, extreme forms, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H56'">Automorphism groups of lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H60'">Mean value and transfer theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H71'">Relations with coding theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Jxx'">Diophantine approximation, transcendental number theory [See also 11K60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J04'">Homogeneous approximation to one number</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J06'">Markov and Lagrange spectra and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J13'">Simultaneous homogeneous approximation, linear forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J17'">Approximation by numbers from a fixed field</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J20'">Inhomogeneous linear forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J25'">Diophantine inequalities [See also 11D75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J54'">Small fractional parts of polynomials and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J61'">Approximation in non-Archimedean valuations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J68'">Approximation to algebraic numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J70'">Continued fractions and generalizations [See also 11A55, 11K50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J71'">Distribution modulo one [See also 11K06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J72'">Irrationality; linear independence over a field</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J81'">Transcendence (general theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J82'">Measures of irrationality and of transcendence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J83'">Metric theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J85'">Algebraic independence; Gel&#x27;fond's method</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J86'">Linear forms in logarithms; Baker's method</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J87'">Schmidt Subspace Theorem and applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J89'">Transcendence theory of elliptic and abelian functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J91'">Transcendence theory of other special functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J93'">Transcendence theory of Drinfel&#x27;d and $t$-modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J95'">Results involving abelian varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J97'">Analogues of methods in Nevanlinna theory (work of Vojta et al.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Kxx'">Probabilistic theory: distribution modulo $1$; metric theory of algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K06'">General theory of distribution modulo $1$ [See also 11J71]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K16'">Normal numbers, radix expansions, Pisot numbers, Salem numbers, good lattice points, etc. [See also 11A63]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K31'">Special sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K36'">Well-distributed sequences and other variations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K38'">Irregularities of distribution, discrepancy [See also 11Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K41'">Continuous, $p$-adic and abstract analogues</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K45'">Pseudo-random numbers; Monte Carlo methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K50'">Metric theory of continued fractions [See also 11A55, 11J70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K55'">Metric theory of other algorithms and expansions; measure and Hausdorff dimension [See also 11N99, 28Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K60'">Diophantine approximation [See also 11Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K65'">Arithmetic functions [See also 11Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K70'">Harmonic analysis and almost periodicity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Lxx'">Exponential sums and character sums {For finite fields, see 11Txx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L03'">Trigonometric and exponential sums, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L05'">Gauss and Kloosterman sums; generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L07'">Estimates on exponential sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L10'">Jacobsthal and Brewer sums; other complete character sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L15'">Weyl sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L20'">Sums over primes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L26'">Sums over arbitrary intervals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L40'">Estimates on character sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Mxx'">Zeta and $L$-functions: analytic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M06'">$\zeta (s)$ and $L(s, \chi)$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M20'">Real zeros of $L(s, \chi)$; results on $L(1, \chi)$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M26'">Nonreal zeros of $\zeta (s)$ and $L(s, \chi)$; Riemann and other hypotheses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M32'">Multiple Dirichlet series and zeta functions and multizeta values</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M35'">Hurwitz and Lerch zeta functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M36'">Selberg zeta functions and regularized determinants; applications to spectral theory, Dirichlet series, Eisenstein series, etc. Explicit formulas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M38'">Zeta and $L$-functions in characteristic $p$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M41'">Other Dirichlet series and zeta functions {For local and global ground fields, see 11R42, 11R52, 11S40, 11S45; for algebro-geometric methods, see 14G10; see also 11E45, 11F66, 11F70, 11F72}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M45'">Tauberian theorems [See also 40E05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M50'">Relations with random matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M55'">Relations with noncommutative geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Nxx'">Multiplicative number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N05'">Distribution of primes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N13'">Primes in progressions [See also 11B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N25'">Distribution of integers with specified multiplicative constraints</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N30'">Tur&#xC3;&#xA1;n theory [See also 30Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N32'">Primes represented by polynomials; other multiplicative structure of polynomial values</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N35'">Sieves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N36'">Applications of sieve methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N37'">Asymptotic results on arithmetic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N45'">Asymptotic results on counting functions for algebraic and topological structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N56'">Rate of growth of arithmetic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N60'">Distribution functions associated with additive and positive multiplicative functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N64'">Other results on the distribution of values or the characterization of arithmetic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N69'">Distribution of integers in special residue classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N75'">Applications of automorphic functions and forms to multiplicative problems [See also 11Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N80'">Generalized primes and integers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Pxx'">Additive number theory; partitions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P05'">Waring's problem and variants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P21'">Lattice points in specified regions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P32'">Goldbach-type theorems; other additive questions involving primes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P55'">Applications of the Hardy-Littlewood method [See also 11D85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P70'">Inverse problems of additive number theory, including sumsets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P81'">Elementary theory of partitions [See also 05A17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P82'">Analytic theory of partitions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P83'">Partitions; congruences and congruential restrictions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P84'">Partition identities; identities of Rogers-Ramanujan type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Rxx'">Algebraic number theory: global fields {For complex multiplication, see 11G15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R04'">Algebraic numbers; rings of algebraic integers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R06'">PV-numbers and generalizations; other special algebraic numbers; Mahler measure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R09'">Polynomials (irreducibility, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R11'">Quadratic extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R16'">Cubic and quartic extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R18'">Cyclotomic extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R20'">Other abelian and metabelian extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R21'">Other number fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R23'">Iwasawa theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R27'">Units and factorization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R29'">Class numbers, class groups, discriminants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R32'">Galois theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R33'">Integral representations related to algebraic numbers; Galois module structure of rings of integers [See also 20C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R34'">Galois cohomology [See also 12Gxx, 19A31]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R37'">Class field theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R39'">Langlands-Weil conjectures, nonabelian class field theory [See also 11Fxx, 22E55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R42'">Zeta functions and $L$-functions of number fields [See also 11M41, 19F27]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R44'">Distribution of prime ideals [See also 11N05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R45'">Density theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R47'">Other analytic theory [See also 11Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R52'">Quaternion and other division algebras: arithmetic, zeta functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R54'">Other algebras and orders, and their zeta and $L$-functions [See also 11S45, 16Hxx, 16Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R56'">Ad&#xC3;&#xA8;le rings and groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R58'">Arithmetic theory of algebraic function fields [See also 14-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R60'">Cyclotomic function fields (class groups, Bernoulli objects, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R65'">Class groups and Picard groups of orders</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R70'">$K$-theory of global fields [See also 19Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R80'">Totally real fields [See also 12J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Sxx'">Algebraic number theory: local and $p$-adic fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S05'">Polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S15'">Ramification and extension theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S20'">Galois theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S23'">Integral representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S25'">Galois cohomology [See also 12Gxx, 16H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S31'">Class field theory; $p$-adic formal groups [See also 14L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S37'">Langlands-Weil conjectures, nonabelian class field theory [See also 11Fxx, 22E50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S40'">Zeta functions and $L$-functions [See also 11M41, 19F27]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S45'">Algebras and orders, and their zeta functions [See also 11R52, 11R54, 16Hxx, 16Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S70'">$K$-theory of local fields [See also 19Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S80'">Other analytic theory (analogues of beta and gamma functions, $p$-adic integration, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S82'">Non-Archimedean dynamical systems [See mainly 37Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S85'">Other nonanalytic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S90'">Prehomogeneous vector spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Txx'">Finite fields and commutative rings (number-theoretic aspects)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T06'">Polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T22'">Cyclotomy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T23'">Exponential sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T24'">Other character sums and Gauss sums</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T30'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T55'">Arithmetic theory of polynomial rings over finite fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T60'">Finite upper half-planes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T71'">Algebraic coding theory; cryptography</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Uxx'">Connections with logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11U05'">Decidability [See also 03B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11U07'">Ultraproducts [See also 03C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11U09'">Model theory [See also 03Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11U10'">Nonstandard arithmetic [See also 03H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Yxx'">Computational number theory [See also 11-04]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y05'">Factorization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y11'">Primality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y16'">Algorithms; complexity [See also 68Q25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y35'">Analytic computations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y40'">Algebraic number theory computations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y50'">Computer solution of Diophantine equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y55'">Calculation of integer sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y60'">Evaluation of constants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y65'">Continued fraction calculations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y70'">Values of arithmetic functions; tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Y99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Zxx'">Miscellaneous applications of number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Z05'">Miscellaneous applications of number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='11Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-XX'">Field theory and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Dxx'">Real and complex fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12D05'">Polynomials: factorization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12D10'">Polynomials: location of zeros (algebraic theorems) {For the analytic theory, see 26C10, 30C15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12D15'">Fields related with sums of squares (formally real fields, Pythagorean fields, etc.) [See also 11Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Exx'">General field theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E05'">Polynomials (irreducibility, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E10'">Special polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E12'">Equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E15'">Skew fields, division rings [See also 11R52, 11R54, 11S45, 16Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E20'">Finite fields (field-theoretic aspects)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E25'">Hilbertian fields; Hilbert's irreducibility theorem</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E30'">Field arithmetic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Fxx'">Field extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F05'">Algebraic extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F10'">Separable extensions, Galois theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F12'">Inverse Galois theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F15'">Inseparable extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F20'">Transcendental extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Gxx'">Homological methods (field theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12G05'">Galois cohomology [See also 14F22, 16Hxx, 16K50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12G10'">Cohomological dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Hxx'">Differential and difference algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12H05'">Differential algebra [See also 13Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12H10'">Difference algebra [See also 39Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12H20'">Abstract differential equations [See also 34Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12H25'">$p$-adic differential equations [See also 11S80, 14G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Jxx'">Topological fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J05'">Normed fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J10'">Valued fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J12'">Formally $p$-adic fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J15'">Ordered fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J17'">Topological semifields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J20'">General valuation theory [See also 13A18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J25'">Non-Archimedean valued fields [See also 30G06, 32P05, 46S10, 47S10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J27'">Krasner-Tate algebras [See mainly 32P05; see also 46S10, 47S10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Kxx'">Generalizations of fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12K05'">Near-fields [See also 16Y30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12K10'">Semifields [See also 16Y60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Lxx'">Connections with logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12L05'">Decidability [See also 03B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12L10'">Ultraproducts [See also 03C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12L12'">Model theory [See also 03C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12L15'">Nonstandard arithmetic [See also 03H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Yxx'">Computational aspects of field theory and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Y05'">Computational aspects of field theory and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='12Y99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-XX'">Commutative algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Axx'">General commutative ring theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A02'">Graded rings [See also 16W50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A05'">Divisibility; factorizations [See also 13F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A15'">Ideals; multiplicative ideal theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A18'">Valuations and their generalizations [See also 12J20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A30'">Associated graded rings of ideals (Rees ring, form ring), analytic spread and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A35'">Characteristic $p$ methods (Frobenius endomorphism) and reduction to characteristic $p$; tight closure [See also 13B22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A50'">Actions of groups on commutative rings; invariant theory [See also 14L24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Bxx'">Ring extensions and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B02'">Extension theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B05'">Galois theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B10'">Morphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B21'">Integral dependence; going up, going down</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B22'">Integral closure of rings and ideals [See also 13A35]; integrally closed rings, related rings (Japanese, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B25'">Polynomials over commutative rings [See also 11C08, 11T06, 13F20, 13M10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B30'">Rings of fractions and localization [See also 16S85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B35'">Completion [See also 13J10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B40'">&#xC3;&#x89;tale and flat extensions; Henselization; Artin approximation [See also 13J15, 14B12, 14B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Cxx'">Theory of modules and ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C05'">Structure, classification theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C10'">Projective and free modules and ideals [See also 19A13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C11'">Injective and flat modules and ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C12'">Torsion modules and ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C13'">Other special types</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C14'">Cohen-Macaulay modules [See also 13H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C15'">Dimension theory, depth, related rings (catenary, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C20'">Class groups [See also 11R29]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C40'">Linkage, complete intersections and determinantal ideals [See also 14M06, 14M10, 14M12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C60'">Module categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Dxx'">Homological methods {For noncommutative rings, see 16Exx; for general categories, see 18Gxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D02'">Syzygies, resolutions, complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D03'">(Co)homology of commutative rings and algebras (e.g., Hochschild, Andr&#xC3;&#xA9;-Quillen, cyclic, dihedral, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D05'">Homological dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D07'">Homological functors on modules (Tor, Ext, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D09'">Derived categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D10'">Deformations and infinitesimal methods [See also 14B10, 14B12, 14D15, 32Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D15'">Grothendieck groups, $K$-theory [See also 14C35, 18F30, 19Axx, 19D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D22'">Homological conjectures (intersection theorems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D30'">Torsion theory [See also 13C12, 18E40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D40'">Hilbert-Samuel and Hilbert-Kunz functions; Poincar&#xC3;&#xA9; series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D45'">Local cohomology [See also 14B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Exx'">Chain conditions, finiteness conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13E05'">Noetherian rings and modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13E10'">Artinian rings and modules, finite-dimensional algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13E15'">Rings and modules of finite generation or presentation; number of generators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Fxx'">Arithmetic rings and other special rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F05'">Dedekind, Pr&#xC3;&#xBC;fer, Krull and Mori rings and their generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F07'">Euclidean rings and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F10'">Principal ideal rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F15'">Rings defined by factorization properties (e.g., atomic, factorial, half-factorial) [See also 13A05, 14M05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F20'">Polynomial rings and ideals; rings of integer-valued polynomials [See also 11C08, 13B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F25'">Formal power series rings [See also 13J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F30'">Valuation rings [See also 13A18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F35'">Witt vectors and related rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F40'">Excellent rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F45'">Seminormal rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F50'">Rings with straightening laws, Hodge algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F55'">Stanley-Reisner face rings; simplicial complexes [See also 55U10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F60'">Cluster algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Gxx'">Integral domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13G05'">Integral domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Hxx'">Local rings and semilocal rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13H05'">Regular local rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13H10'">Special types (Cohen-Macaulay, Gorenstein, Buchsbaum, etc.) [See also 14M05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13H15'">Multiplicity theory and related topics [See also 14C17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Jxx'">Topological rings and modules [See also 16W60, 16W80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J05'">Power series rings [See also 13F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J07'">Analytical algebras and rings [See also 32B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J10'">Complete rings, completion [See also 13B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J15'">Henselian rings [See also 13B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J20'">Global topological rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J25'">Ordered rings [See also 06F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J30'">Real algebra [See also 12D15, 14Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Lxx'">Applications of logic to commutative algebra [See also 03Cxx, 03Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13L05'">Applications of logic to commutative algebra [See also 03Cxx, 03Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Mxx'">Finite commutative rings {For number-theoretic aspects, see 11Txx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13M05'">Structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13M10'">Polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Nxx'">Differential algebra [See also 12H05, 14F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13N05'">Modules of differentials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13N10'">Rings of differential operators and their modules [See also 16S32, 32C38]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13N15'">Derivations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13Pxx'">Computational aspects and applications [See also 14Qxx, 68W30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P05'">Polynomials, factorization [See also 12Y05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P10'">Gr&#xC3;&#xB6;bner bases; other bases for ideals and modules (e.g., Janet and border bases)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P15'">Solving polynomial systems; resultants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P20'">Computational homological algebra [See also 13Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P25'">Applications of commutative algebra (e.g., to statistics, control theory, optimization, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='13P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-XX'">Algebraic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Axx'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A05'">Relevant commutative algebra [See also 13-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A10'">Varieties and morphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A15'">Schemes and morphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A20'">Generalizations (algebraic spaces, stacks)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A22'">Noncommutative algebraic geometry [See also 16S38]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A25'">Elementary questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Bxx'">Local theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B05'">Singularities [See also 14E15, 14H20, 14J17, 32Sxx, 58Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B07'">Deformations of singularities [See also 14D15, 32S30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B10'">Infinitesimal methods [See also 13D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B12'">Local deformation theory, Artin approximation, etc. [See also 13B40, 13D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B15'">Local cohomology [See also 13D45, 32C36]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B20'">Formal neighborhoods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B25'">Local structure of morphisms: &#xC3;&#xA9;tale, flat, etc. [See also 13B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Cxx'">Cycles and subschemes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C05'">Parametrization (Chow and Hilbert schemes)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C15'">(Equivariant) Chow groups and rings; motives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C17'">Intersection theory, characteristic classes, intersection multiplicities [See also 13H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C20'">Divisors, linear systems, invertible sheaves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C21'">Pencils, nets, webs [See also 53A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C22'">Picard groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C25'">Algebraic cycles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C30'">Transcendental methods, Hodge theory [See also 14D07, 32G20, 32J25, 32S35], Hodge conjecture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C34'">Torelli problem [See also 32G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C35'">Applications of methods of algebraic $K$-theory [See also 19Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C40'">Riemann-Roch theorems [See also 19E20, 19L10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Dxx'">Families, fibrations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D05'">Structure of families (Picard-Lefschetz, monodromy, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D06'">Fibrations, degenerations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D07'">Variation of Hodge structures [See also 32G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D10'">Arithmetic ground fields (finite, local, global)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D15'">Formal methods; deformations [See also 13D10, 14B07, 32Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D20'">Algebraic moduli problems, moduli of vector bundles {For analytic moduli problems, see 32G13}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D21'">Applications of vector bundles and moduli spaces in mathematical physics (twistor theory, instantons, quantum field theory) [See also 32L25, 81Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D22'">Fine and coarse moduli spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D23'">Stacks and moduli problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D24'">Geometric Langlands program: algebro-geometric aspects [See also 22E57]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Exx'">Birational geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E05'">Rational and birational maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E07'">Birational automorphisms, Cremona group and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E08'">Rationality questions [See also 14M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E15'">Global theory and resolution of singularities [See also 14B05, 32S20, 32S45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E16'">McKay correspondence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E18'">Arcs and motivic integration</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E20'">Coverings [See also 14H30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E22'">Ramification problems [See also 11S15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E25'">Embeddings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E30'">Minimal model program (Mori theory, extremal rays)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Fxx'">(Co)homology theory [See also 13Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F05'">Sheaves, derived categories of sheaves and related constructions [See also 14H60, 14J60, 18F20, 32Lxx, 46M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F10'">Differentials and other special sheaves; D-modules; Bernstein-Sato ideals and polynomials [See also 13Nxx, 32C38]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F17'">Vanishing theorems [See also 32L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F18'">Multiplier ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F20'">&#xC3;&#x89;tale and other Grothendieck topologies and (co)homologies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F22'">Brauer groups of schemes [See also 12G05, 16K50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F25'">Classical real and complex (co)homology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F30'">$p$-adic cohomology, crystalline cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F35'">Homotopy theory; fundamental groups [See also 14H30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F40'">de Rham cohomology [See also 14C30, 32C35, 32L10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F42'">Motivic cohomology; motivic homotopy theory [See also 19E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F43'">Other algebro-geometric (co)homologies (e.g., intersection, equivariant, Lawson, Deligne (co)homologies)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F45'">Topological properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Gxx'">Arithmetic problems. Diophantine geometry [See also 11Dxx, 11Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G05'">Rational points</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G10'">Zeta-functions and related questions [See also 11G40] (Birch-Swinnerton-Dyer conjecture)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G15'">Finite ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G17'">Positive characteristic ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G20'">Local ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G22'">Rigid analytic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G25'">Global ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G27'">Other nonalgebraically closed ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G32'">Universal profinite groups (relationship to moduli spaces, projective and moduli towers, Galois theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G35'">Modular and Shimura varieties [See also 11F41, 11F46, 11G18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G40'">Arithmetic varieties and schemes; Arakelov theory; heights [See also 11G50, 37P30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G50'">Applications to coding theory and cryptography [See also 94A60, 94B27, 94B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Hxx'">Curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H05'">Algebraic functions; function fields [See also 11R58]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H10'">Families, moduli (algebraic)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H15'">Families, moduli (analytic) [See also 30F10, 32G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H20'">Singularities, local rings [See also 13Hxx, 14B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H25'">Arithmetic ground fields [See also 11Dxx, 11G05, 14Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H30'">Coverings, fundamental group [See also 14E20, 14F35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H37'">Automorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H40'">Jacobians, Prym varieties [See also 32G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H42'">Theta functions; Schottky problem [See also 14K25, 32G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H45'">Special curves and curves of low genus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H50'">Plane and space curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H51'">Special divisors (gonality, Brill-Noether theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H52'">Elliptic curves [See also 11G05, 11G07, 14Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H55'">Riemann surfaces; Weierstrass points; gap sequences [See also 30Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H57'">Dessins d'enfants theory {For arithmetic aspects, see 11G32}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H60'">Vector bundles on curves and their moduli [See also 14D20, 14F05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H70'">Relationships with integrable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H81'">Relationships with physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Jxx'">Surfaces and higher-dimensional varieties {For analytic theory, see 32Jxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J10'">Families, moduli, classification: algebraic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J15'">Moduli, classification: analytic theory; relations with modular forms [See also 32G13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J17'">Singularities [See also 14B05, 14E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J20'">Arithmetic ground fields [See also 11Dxx, 11G25, 11G35, 14Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J25'">Special surfaces {For Hilbert modular surfaces, see 14G35}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J26'">Rational and ruled surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J27'">Elliptic surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J28'">$K3$ surfaces and Enriques surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J29'">Surfaces of general type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J30'">$3$-folds [See also 32Q25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J32'">Calabi-Yau manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J33'">Mirror symmetry [See also 11G42, 53D37]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J35'">$4$-folds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J40'">$n$-folds ($n>4$)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J45'">Fano varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J50'">Automorphisms of surfaces and higher-dimensional varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J60'">Vector bundles on surfaces and higher-dimensional varieties, and their moduli [See also 14D20, 14F05, 32Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J70'">Hypersurfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J80'">Topology of surfaces (Donaldson polynomials, Seiberg-Witten invariants)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J81'">Relationships with physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Kxx'">Abelian varieties and schemes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K02'">Isogeny</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K05'">Algebraic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K10'">Algebraic moduli, classification [See also 11G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K12'">Subvarieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K15'">Arithmetic ground fields [See also 11Dxx, 11Fxx, 11G10, 14Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K20'">Analytic theory; abelian integrals and differentials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K22'">Complex multiplication [See also 11G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K25'">Theta functions [See also 14H42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K30'">Picard schemes, higher Jacobians [See also 14H40, 32G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Lxx'">Algebraic groups {For linear algebraic groups, see 20Gxx; for Lie algebras, see 17B45}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L05'">Formal groups, $p$-divisible groups [See also 55N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L10'">Group varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L15'">Group schemes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L17'">Affine algebraic groups, hyperalgebra constructions [See also 17B45, 18D35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L24'">Geometric invariant theory [See also 13A50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L30'">Group actions on varieties or schemes (quotients) [See also 13A50, 14L24, 14M17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L35'">Classical groups (geometric aspects) [See also 20Gxx, 51N30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L40'">Other algebraic groups (geometric aspects)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Mxx'">Special varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M05'">Varieties defined by ring conditions (factorial, Cohen-Macaulay, seminormal) [See also 13F15, 13F45, 13H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M06'">Linkage [See also 13C40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M07'">Low codimension problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M10'">Complete intersections [See also 13C40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M12'">Determinantal varieties [See also 13C40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M15'">Grassmannians, Schubert varieties, flag manifolds [See also 32M10, 51M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M17'">Homogeneous spaces and generalizations [See also 32M10, 53C30, 57T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M20'">Rational and unirational varieties [See also 14E08]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M22'">Rationally connected varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M25'">Toric varieties, Newton polyhedra [See also 52B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M27'">Compactifications; symmetric and spherical varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M30'">Supervarieties [See also 32C11, 58A50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Nxx'">Projective and enumerative geometry [See also 51-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N05'">Projective techniques [See also 51N35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N10'">Enumerative problems (combinatorial problems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N15'">Classical problems, Schubert calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N20'">Configurations and arrangements of linear subspaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N25'">Varieties of low degree</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N30'">Adjunction problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N35'">Gromov-Witten invariants, quantum cohomology, Gopakumar-Vafa invariants, Donaldson-Thomas invariants [See also 53D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Pxx'">Real algebraic and real analytic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P05'">Real algebraic sets [See also 12D15, 13J30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P10'">Semialgebraic sets and related spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P15'">Real analytic and semianalytic sets [See also 32B20, 32C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P20'">Nash functions and manifolds [See also 32C07, 58A07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P25'">Topology of real algebraic varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Qxx'">Computational aspects in algebraic geometry [See also 12Y05, 13Pxx, 68W30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Q05'">Curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Q10'">Surfaces, hypersurfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Q15'">Higher-dimensional varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Q20'">Effectivity, complexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Rxx'">Affine geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R05'">Classification of affine varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R10'">Affine spaces (automorphisms, embeddings, exotic structures, cancellation problem)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R15'">Jacobian problem [See also 13F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R20'">Group actions on affine varieties [See also 13A50, 14L30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R25'">Affine fibrations [See also 14D06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14Txx'">Tropical geometry [See also 12K10, 14M25, 14N10, 52B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14T05'">Tropical geometry [See also 12K10, 14M25, 14N10, 52B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='14T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-XX'">Linear and multilinear algebra; matrix theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15Axx'">Basic linear algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A03'">Vector spaces, linear dependence, rank</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A04'">Linear transformations, semilinear transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A06'">Linear equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A09'">Matrix inversion, generalized inverses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A12'">Conditioning of matrices [See also 65F35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A15'">Determinants, permanents, other special matrix functions [See also 19B10, 19B14]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A16'">Matrix exponential and similar functions of matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A18'">Eigenvalues, singular values, and eigenvectors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A21'">Canonical forms, reductions, classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A22'">Matrix pencils [See also 47A56]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A23'">Factorization of matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A24'">Matrix equations and identities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A27'">Commutativity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A29'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A30'">Algebraic systems of matrices [See also 16S50, 20Gxx, 20Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A39'">Linear inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A42'">Inequalities involving eigenvalues and eigenvectors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A45'">Miscellaneous inequalities involving matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A54'">Matrices over function rings in one or more variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A60'">Norms of matrices, numerical range, applications of functional analysis to matrix theory [See also 65F35, 65J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A63'">Quadratic and bilinear forms, inner products [See mainly 11Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A66'">Clifford algebras, spinors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A69'">Multilinear algebra, tensor products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A72'">Vector and tensor algebra, theory of invariants [See also 13A50, 14L24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A75'">Exterior algebra, Grassmann algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A78'">Other algebras built from modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A80'">Max-plus and related algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A83'">Matrix completion problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A86'">Linear preserver problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15Bxx'">Special matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B05'">Toeplitz, Cauchy, and related matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B10'">Orthogonal matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B15'">Fuzzy matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B33'">Matrices over special rings (quaternions, finite fields, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B34'">Boolean and Hadamard matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B35'">Sign pattern matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B36'">Matrices of integers [See also 11C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B48'">Positive matrices and their generalizations; cones of matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B51'">Stochastic matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B52'">Random matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B57'">Hermitian, skew-Hermitian, and related matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='15B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-XX'">Associative rings and algebras {For the commutative case, see 13-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Bxx'">General and miscellaneous</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16B50'">Category-theoretic methods and results (except as in 16D90) [See also 18-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16B70'">Applications of logic [See also 03Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Dxx'">Modules, bimodules and ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D10'">General module theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D20'">Bimodules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D25'">Ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D30'">Infinite-dimensional simple rings (except as in 16Kxx)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D40'">Free, projective, and flat modules and ideals [See also 19A13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D50'">Injective modules, self-injective rings [See also 16L60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D60'">Simple and semisimple modules, primitive rings and ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D70'">Structure and classification (except as in 16Gxx), direct sum decomposition, cancellation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D80'">Other classes of modules and ideals [See also 16G50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D90'">Module categories [See also 16Gxx, 16S90]; module theory in a category-theoretic context; Morita equivalence and duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Exx'">Homological methods {For commutative rings, see 13Dxx; for general categories, see 18Gxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E05'">Syzygies, resolutions, complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E10'">Homological dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E20'">Grothendieck groups, $K$-theory, etc. [See also 18F30, 19Axx, 19D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E30'">Homological functors on modules (Tor, Ext, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E35'">Derived categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E40'">(Co)homology of rings and algebras (e.g. Hochschild, cyclic, dihedral, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E45'">Differential graded algebras and applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E50'">von Neumann regular rings and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E60'">Semihereditary and hereditary rings, free ideal rings, Sylvester rings, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E65'">Homological conditions on rings (generalizations of regular, Gorenstein, Cohen-Macaulay rings, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Gxx'">Representation theory of rings and algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G10'">Representations of Artinian rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G20'">Representations of quivers and partially ordered sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G30'">Representations of orders, lattices, algebras over commutative rings [See also 16Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G50'">Cohen-Macaulay modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G60'">Representation type (finite, tame, wild, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G70'">Auslander-Reiten sequences (almost split sequences) and Auslander-Reiten quivers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Hxx'">Algebras and orders {For arithmetic aspects, see 11R52, 11R54, 11S45; for representation theory, see 16G30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16H05'">Separable algebras (e.g., quaternion algebras, Azumaya algebras, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16H10'">Orders in separable algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16H15'">Commutative orders</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16H20'">Lattices over orders</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Kxx'">Division rings and semisimple Artin rings [See also 12E15, 15A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16K20'">Finite-dimensional {For crossed products, see 16S35}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16K40'">Infinite-dimensional and general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16K50'">Brauer groups [See also 12G05, 14F22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Lxx'">Local rings and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16L30'">Noncommutative local and semilocal rings, perfect rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16L60'">Quasi-Frobenius rings [See also 16D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Nxx'">Radicals and radical properties of rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16N20'">Jacobson radical, quasimultiplication</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16N40'">Nil and nilpotent radicals, sets, ideals, rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16N60'">Prime and semiprime rings [See also 16D60, 16U10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16N80'">General radicals and rings {For radicals in module categories, see 16S90}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Pxx'">Chain conditions, growth conditions, and other forms of finiteness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P10'">Finite rings and finite-dimensional algebras {For semisimple, see 16K20; for commutative, see 11Txx, 13Mxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P20'">Artinian rings and modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P40'">Noetherian rings and modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P50'">Localization and Noetherian rings [See also 16U20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P60'">Chain conditions on annihilators and summands: Goldie-type conditions [See also 16U20], Krull dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P70'">Chain conditions on other classes of submodules, ideals, subrings, etc.; coherence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P90'">Growth rate, Gelfand-Kirillov dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Rxx'">Rings with polynomial identity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R10'">$T$-ideals, identities, varieties of rings and algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R20'">Semiprime p.i. rings, rings embeddable in matrices over commutative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R30'">Trace rings and invariant theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R40'">Identities other than those of matrices over commutative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R50'">Other kinds of identities (generalized polynomial, rational, involution)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R60'">Functional identities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Sxx'">Rings and algebras arising under various constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S10'">Rings determined by universal properties (free algebras, coproducts, adjunction of inverses, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S15'">Finite generation, finite presentability, normal forms (diamond lemma, term-rewriting)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S20'">Centralizing and normalizing extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S30'">Universal enveloping algebras of Lie algebras [See mainly 17B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S32'">Rings of differential operators [See also 13N10, 32C38]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S34'">Group rings [See also 20C05, 20C07], Laurent polynomial rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S35'">Twisted and skew group rings, crossed products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S36'">Ordinary and skew polynomial rings and semigroup rings [See also 20M25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S37'">Quadratic and Koszul algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S38'">Rings arising from non-commutative algebraic geometry [See also 14A22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S40'">Smash products of general Hopf actions [See also 16T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S50'">Endomorphism rings; matrix rings [See also 15-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S60'">Rings of functions, subdirect products, sheaves of rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S70'">Extensions of rings by ideals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S80'">Deformations of rings [See also 13D10, 14D15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S85'">Rings of fractions and localizations [See also 13B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S90'">Torsion theories; radicals on module categories [See also 13D30, 18E40] {For radicals of rings, see 16Nxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Txx'">Hopf algebras, quantum groups and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T05'">Hopf algebras and their applications [See also 16S40, 57T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T10'">Bialgebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T15'">Coalgebras and comodules; corings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T20'">Ring-theoretic aspects of quantum groups [See also 17B37, 20G42, 81R50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T25'">Yang-Baxter equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T30'">Connections with combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Uxx'">Conditions on elements</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U10'">Integral domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U20'">Ore rings, multiplicative sets, Ore localization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U30'">Divisibility, noncommutative UFDs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U60'">Units, groups of units</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U70'">Center, normalizer (invariant elements)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U80'">Generalizations of commutativity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Wxx'">Rings and algebras with additional structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W10'">Rings with involution; Lie, Jordan and other nonassociative structures [See also 17B60, 17C50, 46Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W20'">Automorphisms and endomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W22'">Actions of groups and semigroups; invariant theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W25'">Derivations, actions of Lie algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W50'">Graded rings and modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W55'">``Super'' (or ``skew'') structure [See also 17A70, 17Bxx, 17C70] {For exterior algebras, see 15A75; for Clifford algebras, see 11E88, 15A66}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W60'">Valuations, completions, formal power series and related constructions [See also 13Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W70'">Filtered rings; filtrational and graded techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W80'">Topological and ordered rings and modules [See also 06F25, 13Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16W99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Yxx'">Generalizations {For nonassociative rings, see 17-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Y30'">Near-rings [See also 12K05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Y60'">Semirings [See also 12K10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Y99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Zxx'">Computational aspects of associative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Z05'">Computational aspects of associative rings [See also 68W30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='16Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-XX'">Nonassociative rings and algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17Axx'">General nonassociative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A01'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A05'">Power-associative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A15'">Noncommutative Jordan algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A20'">Flexible algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A30'">Algebras satisfying other identities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A32'">Leibniz algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A35'">Division algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A36'">Automorphisms, derivations, other operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A40'">Ternary compositions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A42'">Other $n$-ary compositions $(n \ge 3)$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A45'">Quadratic algebras (but not quadratic Jordan algebras)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A50'">Free algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A60'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A65'">Radical theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A70'">Superalgebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A75'">Composition algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A80'">Valued algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17Bxx'">Lie algebras and Lie superalgebras {For Lie groups, see 22Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B01'">Identities, free Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B05'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B08'">Coadjoint orbits; nilpotent varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B10'">Representations, algebraic theory (weights)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B15'">Representations, analytic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B20'">Simple, semisimple, reductive (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B22'">Root systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B25'">Exceptional (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B30'">Solvable, nilpotent (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B35'">Universal enveloping (super)algebras [See also 16S30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B37'">Quantum groups (quantized enveloping algebras) and related deformations [See also 16T20, 20G42, 81R50, 82B23]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B40'">Automorphisms, derivations, other operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B45'">Lie algebras of linear algebraic groups [See also 14Lxx and 20Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B50'">Modular Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B55'">Homological methods in Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B56'">Cohomology of Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B60'">Lie (super)algebras associated with other structures (associative, Jordan, etc.) [See also 16W10, 17C40, 17C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B62'">Lie bialgebras; Lie coalgebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B63'">Poisson algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B65'">Infinite-dimensional Lie (super)algebras [See also 22E65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B66'">Lie algebras of vector fields and related (super) algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B67'">Kac-Moody (super)algebras; extended affine Lie algebras; toroidal Lie algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B68'">Virasoro and related algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B69'">Vertex operators; vertex operator algebras and related structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B70'">Graded Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B75'">Color Lie (super)algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B80'">Applications to integrable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B81'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17Cxx'">Jordan algebras (algebras, triples and pairs)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C05'">Identities and free Jordan structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C10'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C17'">Radicals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C20'">Simple, semisimple algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C27'">Idempotents, Peirce decompositions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C30'">Associated groups, automorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C36'">Associated manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C37'">Associated geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C40'">Exceptional Jordan structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C50'">Jordan structures associated with other structures [See also 16W10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C55'">Finite-dimensional structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C60'">Division algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C65'">Jordan structures on Banach spaces and algebras [See also 46H70, 46L70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C70'">Super structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C90'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17Dxx'">Other nonassociative rings and algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D05'">Alternative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D10'">Mal&#x27;cev (Mal&#x27;tsev) rings and algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D15'">Right alternative rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D20'">$(\gamma, \delta)$-rings, including $(1,-1)$-rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D25'">Lie-admissible algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D92'">Genetic algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='17D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-XX'">Category theory; homological algebra {For commutative rings see 13Dxx, for associative rings 16Exx, for groups 20Jxx, for topological groups and related structures 57Txx; see also 55Nxx and 55Uxx for algebraic topology}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Axx'">General theory of categories and functors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A05'">Definitions, generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A10'">Graphs, diagram schemes, precategories [See especially 20L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A15'">Foundations, relations to logic and deductive systems [See also 03-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A20'">Epimorphisms, monomorphisms, special classes of morphisms, null morphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A22'">Special properties of functors (faithful, full, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A23'">Natural morphisms, dinatural morphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A25'">Functor categories, comma categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A30'">Limits and colimits (products, sums, directed limits, pushouts, fiber products, equalizers, kernels, ends and coends, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A32'">Factorization of morphisms, substructures, quotient structures, congruences, amalgams</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A35'">Categories admitting limits (complete categories), functors preserving limits, completions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A40'">Adjoint functors (universal constructions, reflective subcategories, Kan extensions, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Bxx'">Special categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B05'">Category of sets, characterizations [See also 03-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B10'">Category of relations, additive relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B15'">Embedding theorems, universal categories [See also 18E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B20'">Categories of machines, automata, operative categories [See also 03D05, 68Qxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B25'">Topoi [See also 03G30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B30'">Categories of topological spaces and continuous mappings [See also 54-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B35'">Preorders, orders and lattices (viewed as categories) [See also 06-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B40'">Groupoids, semigroupoids, semigroups, groups (viewed as categories) [See also 20Axx, 20L05, 20Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Cxx'">Categories and theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C05'">Equational categories [See also 03C05, 08C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C10'">Theories (e.g. algebraic theories), structure, and semantics [See also 03G30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C15'">Triples (= standard construction, monad or triad), algebras for a triple, homology and derived functors for triples [See also 18Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C20'">Algebras and Kleisli categories associated with monads</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C30'">Sketches and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C35'">Accessible and locally presentable categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C50'">Categorical semantics of formal languages [See also 68Q55, 68Q65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Dxx'">Categories with structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D05'">Double categories, $2$-categories, bicategories and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D10'">Monoidal categories (= multiplicative categories), symmetric monoidal categories, braided categories [See also 19D23]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D15'">Closed categories (closed monoidal and Cartesian closed categories, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D20'">Enriched categories (over closed or monoidal categories)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D25'">Strong functors, strong adjunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D30'">Fibered categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D35'">Structured objects in a category (group objects, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D50'">Operads [See also 55P48]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Exx'">Abelian categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E05'">Preadditive, additive categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E10'">Exact categories, abelian categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E15'">Grothendieck categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E20'">Embedding theorems [See also 18B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E25'">Derived functors and satellites</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E30'">Derived categories, triangulated categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E35'">Localization of categories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E40'">Torsion theories, radicals [See also 13D30, 16S90]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Fxx'">Categories and geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F05'">Local categories and functors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F10'">Grothendieck topologies [See also 14F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F15'">Abstract manifolds and fiber bundles [See also 55Rxx, 57Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F20'">Presheaves and sheaves [See also 14F05, 32C35, 32L10, 54B40, 55N30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F25'">Algebraic $K$-theory and $L$-theory [See also 11Exx, 11R70, 11S70, 12-XX, 13D15, 14Cxx, 16E20, 19-XX, 46L80, 57R65, 57R67]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F30'">Grothendieck groups [See also 13D15, 16E20, 19Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18Gxx'">Homological algebra [See also 13Dxx, 16Exx, 20Jxx, 55Nxx, 55Uxx, 57Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G05'">Projectives and injectives [See also 13C10, 13C11, 16D40, 16D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G10'">Resolutions; derived functors [See also 13D02, 16E05, 18E25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G15'">Ext and Tor, generalizations, K&#xC3;&#xBC;nneth formula [See also 55U25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G20'">Homological dimension [See also 13D05, 16E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G25'">Relative homological algebra, projective classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G30'">Simplicial sets, simplicial objects (in a category) [See also 55U10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G35'">Chain complexes [See also 18E30, 55U15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G40'">Spectral sequences, hypercohomology [See also 55Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G50'">Nonabelian homological algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G55'">Homotopical algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G60'">Other (co)homology theories [See also 19D55, 46L80, 58J20, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='18G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-XX'">$K$-theory [See also 16E20, 18F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Axx'">Grothendieck groups and $K_0$ [See also 13D15, 18F30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A13'">Stability for projective modules [See also 13C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A15'">Efficient generation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A22'">Frobenius induction, Burnside and representation rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A31'">$K_0$ of group rings and orders</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A49'">$K_0$ of other rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Bxx'">Whitehead groups and $K_1$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19B10'">Stable range conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19B14'">Stability for linear groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19B28'">$K_1$ of group rings and orders [See also 57Q10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19B37'">Congruence subgroup problems [See also 20H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Cxx'">Steinberg groups and $K_2$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19C09'">Central extensions and Schur multipliers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19C20'">Symbols, presentations and stability of $K_2$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19C30'">$K_2$ and the Brauer group</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19C40'">Excision for $K_2$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Dxx'">Higher algebraic $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D06'">$Q$- and plus-constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D10'">Algebraic $K$-theory of spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D23'">Symmetric monoidal categories [See also 18D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D25'">Karoubi-Villamayor-Gersten $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D35'">Negative $K$-theory, NK and Nil</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D45'">Higher symbols, Milnor $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D50'">Computations of higher $K$-theory of rings [See also 13D15, 16E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D55'">$K$-theory and homology; cyclic homology and cohomology [See also 18G60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Exx'">$K$-theory in geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19E08'">$K$-theory of schemes [See also 14C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19E15'">Algebraic cycles and motivic cohomology [See also 14C25, 14C35, 14F42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19E20'">Relations with cohomology theories [See also 14Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Fxx'">$K$-theory in number theory [See also 11R70, 11S70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19F05'">Generalized class field theory [See also 11G45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19F15'">Symbols and arithmetic [See also 11R37]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19F27'">&#xC3;&#x89;tale cohomology, higher regulators, zeta and $L$-functions [See also 11G40, 11R42, 11S40, 14F20, 14G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Gxx'">$K$-theory of forms [See also 11Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19G05'">Stability for quadratic modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19G12'">Witt groups of rings [See also 11E81]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19G24'">$L$-theory of group rings [See also 11E81]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19G38'">Hermitian $K$-theory, relations with $K$-theory of rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Jxx'">Obstructions from topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19J05'">Finiteness and other obstructions in $K_0$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19J10'">Whitehead (and related) torsion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19J25'">Surgery obstructions [See also 57R67]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19J35'">Obstructions to group actions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Kxx'">$K$-theory and operator algebras [See mainly 46L80, and also 46M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19K14'">$K_0$ as an ordered group, traces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19K33'">EXT and $K$-homology [See also 55N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19K35'">Kasparov theory ($KK$-theory) [See also 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19K56'">Index theory [See also 58J20, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Lxx'">Topological $K$-theory [See also 55N15, 55R50, 55S25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L10'">Riemann-Roch theorems, Chern characters</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L20'">$J$-homomorphism, Adams operations [See also 55Q50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L41'">Connective $K$-theory, cobordism [See also 55N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L47'">Equivariant $K$-theory [See also 55N91, 55P91, 55Q91, 55R91, 55S91]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L50'">Twisted $K$-theory; differential $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L64'">Computations, geometric applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19Mxx'">Miscellaneous applications of $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19M05'">Miscellaneous applications of $K$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='19M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-XX'">Group theory and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Axx'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20A05'">Axiomatics and elementary properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20A10'">Metamathematical considerations {For word problems, see 20F10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20A15'">Applications of logic to group theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Bxx'">Permutation groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B05'">General theory for finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B07'">General theory for infinite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B10'">Characterization theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B15'">Primitive groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B20'">Multiply transitive finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B22'">Multiply transitive infinite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B25'">Finite automorphism groups of algebraic, geometric, or combinatorial structures [See also 05Bxx, 12F10, 20G40, 20H30, 51-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B27'">Infinite automorphism groups [See also 12F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B30'">Symmetric groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B35'">Subgroups of symmetric groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B40'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Cxx'">Representation theory of groups [See also 19A22 (for representation rings and Burnside rings)]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C05'">Group rings of finite groups and their modules [See also 16S34]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C07'">Group rings of infinite groups and their modules [See also 16S34]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C08'">Hecke algebras and their representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C10'">Integral representations of finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C11'">$p$-adic representations of finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C12'">Integral representations of infinite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C15'">Ordinary representations and characters</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C20'">Modular representations and characters</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C25'">Projective representations and multipliers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C30'">Representations of finite symmetric groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C32'">Representations of infinite symmetric groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C33'">Representations of finite groups of Lie type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C34'">Representations of sporadic groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C35'">Applications of group representations to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C40'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Dxx'">Abstract finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D05'">Finite simple groups and their classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D06'">Simple groups: alternating groups and groups of Lie type [See also 20Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D08'">Simple groups: sporadic groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D10'">Solvable groups, theory of formations, Schunck classes, Fitting classes, $\pi$-length, ranks [See also 20F17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D15'">Nilpotent groups, $p$-groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D20'">Sylow subgroups, Sylow properties, $\pi$-groups, $\pi$-structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D25'">Special subgroups (Frattini, Fitting, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D30'">Series and lattices of subgroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D35'">Subnormal subgroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D40'">Products of subgroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D45'">Automorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D60'">Arithmetic and combinatorial problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Exx'">Structure and classification of infinite or finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E05'">Free nonabelian groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E06'">Free products, free products with amalgamation, Higman-Neumann-Neumann extensions, and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E07'">Subgroup theorems; subgroup growth</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E08'">Groups acting on trees [See also 20F65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E10'">Quasivarieties and varieties of groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E15'">Chains and lattices of subgroups, subnormal subgroups [See also 20F22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E18'">Limits, profinite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E22'">Extensions, wreath products, and other compositions [See also 20J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E25'">Local properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E26'">Residual properties and generalizations; residually finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E28'">Maximal subgroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E32'">Simple groups [See also 20D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E34'">General structure theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E36'">Automorphisms of infinite groups [For automorphisms of finite groups, see 20D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E42'">Groups with a $BN$-pair; buildings [See also 51E24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E45'">Conjugacy classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Fxx'">Special aspects of infinite or finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F05'">Generators, relations, and presentations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F06'">Cancellation theory; application of van Kampen diagrams [See also 57M05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F10'">Word problems, other decision problems, connections with logic and automata [See also 03B25, 03D05, 03D40, 06B25, 08A50, 20M05, 68Q70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F11'">Groups of finite Morley rank [See also 03C45, 03C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F12'">Commutator calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F14'">Derived series, central series, and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F16'">Solvable groups, supersolvable groups [See also 20D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F17'">Formations of groups, Fitting classes [See also 20D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F18'">Nilpotent groups [See also 20D15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F19'">Generalizations of solvable and nilpotent groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F22'">Other classes of groups defined by subgroup chains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F24'">FC-groups and their generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F28'">Automorphism groups of groups [See also 20E36]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F29'">Representations of groups as automorphism groups of algebraic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F34'">Fundamental groups and their automorphisms [See also 57M05, 57Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F36'">Braid groups; Artin groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F38'">Other groups related to topology or analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F40'">Associated Lie structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F45'">Engel conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F50'">Periodic groups; locally finite groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F55'">Reflection and Coxeter groups [See also 22E40, 51F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F60'">Ordered groups [See mainly 06F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F65'">Geometric group theory [See also 05C25, 20E08, 57Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F67'">Hyperbolic groups and nonpositively curved groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F69'">Asymptotic properties of groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F70'">Algebraic geometry over groups; equations over groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Gxx'">Linear algebraic groups and related topics {For arithmetic theory, see 11E57, 11H56; for geometric theory, see 14Lxx, 22Exx; for other methods in representation theory, see 15A30, 22E45, 22E46, 22E47, 22E50, 22E55}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G05'">Representation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G07'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G10'">Cohomology theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G15'">Linear algebraic groups over arbitrary fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G20'">Linear algebraic groups over the reals, the complexes, the quaternions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G25'">Linear algebraic groups over local fields and their integers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G30'">Linear algebraic groups over global fields and their integers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G35'">Linear algebraic groups over ad&#xC3;&#xA8;les and other rings and schemes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G40'">Linear algebraic groups over finite fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G41'">Exceptional groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G42'">Quantum groups (quantized function algebras) and their representations [See also 16T20, 17B37, 81R50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G43'">Schur and $q$-Schur algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G44'">Kac-Moody groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G45'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Hxx'">Other groups of matrices [See also 15A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H05'">Unimodular groups, congruence subgroups [See also 11F06, 19B37, 22E40, 51F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H10'">Fuchsian groups and their generalizations [See also 11F06, 22E40, 30F35, 32Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H15'">Other geometric groups, including crystallographic groups [See also 51-XX, especially 51F15, and 82D25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H20'">Other matrix groups over fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H25'">Other matrix groups over rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H30'">Other matrix groups over finite fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Jxx'">Connections with homological algebra and category theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20J05'">Homological methods in group theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20J06'">Cohomology of groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20J15'">Category of groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Kxx'">Abelian groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K01'">Finite abelian groups [For sumsets, see 11B13 and 11P70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K10'">Torsion groups, primary groups and generalized primary groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K15'">Torsion-free groups, finite rank</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K20'">Torsion-free groups, infinite rank</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K21'">Mixed groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K25'">Direct sums, direct products, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K27'">Subgroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K30'">Automorphisms, homomorphisms, endomorphisms, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K35'">Extensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K40'">Homological and categorical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K45'">Topological methods [See also 22A05, 22B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Lxx'">Groupoids (i.e. small categories in which all morphisms are isomorphisms) {For sets with a single binary operation, see 20N02; for topological groupoids, see 22A22, 58H05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20L05'">Groupoids (i.e. small categories in which all morphisms are isomorphisms) {For sets with a single binary operation, see 20N02; for topological groupoids, see 22A22, 58H05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Mxx'">Semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M05'">Free semigroups, generators and relations, word problems [See also 03D40, 08A50, 20F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M07'">Varieties and pseudovarieties of semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M10'">General structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M11'">Radical theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M12'">Ideal theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M13'">Arithmetic theory of monoids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M14'">Commutative semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M15'">Mappings of semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M17'">Regular semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M18'">Inverse semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M19'">Orthodox semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M20'">Semigroups of transformations, etc. [See also 47D03, 47H20, 54H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M25'">Semigroup rings, multiplicative semigroups of rings [See also 16S36, 16Y60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M30'">Representation of semigroups; actions of semigroups on sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M32'">Algebraic monoids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M35'">Semigroups in automata theory, linguistics, etc. [See also 03D05, 68Q70, 68T50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M50'">Connections of semigroups with homological algebra and category theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Nxx'">Other generalizations of groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N02'">Sets with a single binary operation (groupoids)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N05'">Loops, quasigroups [See also 05Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N10'">Ternary systems (heaps, semiheaps, heapoids, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N15'">$n$-ary systems $(n\ge 3)$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N20'">Hypergroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N25'">Fuzzy groups [See also 03E72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20Pxx'">Probabilistic methods in group theory [See also 60Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20P05'">Probabilistic methods in group theory [See also 60Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='20P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-XX'">Topological groups, Lie groups {For transformation groups, see 54H15, 57Sxx, 58-XX. For abstract harmonic analysis, see 43-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Axx'">Topological and differentiable algebraic systems {For topological rings and fields, see 12Jxx, 13Jxx, 16W80}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A05'">Structure of general topological groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A10'">Analysis on general topological groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A15'">Structure of topological semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A20'">Analysis on topological semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A22'">Topological groupoids (including differentiable and Lie groupoids) [See also 58H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A25'">Representations of general topological groups and semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A26'">Topological semilattices, lattices and applications [See also 06B30, 06B35, 06F30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A30'">Other topological algebraic systems and their representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Bxx'">Locally compact abelian groups (LCA groups)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22B05'">General properties and structure of LCA groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22B10'">Structure of group algebras of LCA groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Cxx'">Compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22C05'">Compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Dxx'">Locally compact groups and their algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D05'">General properties and structure of locally compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D10'">Unitary representations of locally compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D12'">Other representations of locally compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D15'">Group algebras of locally compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D20'">Representations of group algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D25'">$C^*$-algebras and $W^*$-algebras in relation to group representations [See also 46Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D30'">Induced representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D35'">Duality theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D40'">Ergodic theory on groups [See also 28Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D45'">Automorphism groups of locally compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Exx'">Lie groups {For the topology of Lie groups and homogeneous spaces, see 57Sxx, 57Txx; for analysis thereon, see 43A80, 43A85, 43A90}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E05'">Local Lie groups [See also 34-XX, 35-XX, 58H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E10'">General properties and structure of complex Lie groups [See also 32M05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E15'">General properties and structure of real Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E20'">General properties and structure of other Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E25'">Nilpotent and solvable Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E27'">Representations of nilpotent and solvable Lie groups (special orbital integrals, non-type I representations, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E30'">Analysis on real and complex Lie groups [See also 33C80, 43-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E35'">Analysis on $p$-adic Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E40'">Discrete subgroups of Lie groups [See also 20Hxx, 32Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E41'">Continuous cohomology [See also 57R32, 57Txx, 58H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E43'">Structure and representation of the Lorentz group</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E45'">Representations of Lie and linear algebraic groups over real fields: analytic methods {For the purely algebraic theory, see 20G05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E46'">Semisimple Lie groups and their representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E47'">Representations of Lie and real algebraic groups: algebraic methods (Verma modules, etc.) [See also 17B10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E50'">Representations of Lie and linear algebraic groups over local fields [See also 20G05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E55'">Representations of Lie and linear algebraic groups over global fields and ad&#xC3;&#xA8;le rings [See also 20G05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E57'">Geometric Langlands program: representation-theoretic aspects [See also 14D24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E60'">Lie algebras of Lie groups {For the algebraic theory of Lie algebras, see 17Bxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E65'">Infinite-dimensional Lie groups and their Lie algebras: general properties [See also 17B65, 58B25, 58H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E66'">Analysis on and representations of infinite-dimensional Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E67'">Loop groups and related constructions, group-theoretic treatment [See also 58D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E70'">Applications of Lie groups to physics; explicit representations [See also 81R05, 81R10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22Fxx'">Noncompact transformation groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22F05'">General theory of group and pseudogroup actions {For topological properties of spaces with an action, see 57S20}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22F10'">Measurable group actions [See also 22D40, 28Dxx, 37Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22F30'">Homogeneous spaces {For general actions on manifolds or preserving geometrical structures, see 57M60, 57Sxx; for discrete subgroups of Lie groups, see especially 22E40}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22F50'">Groups as automorphisms of other structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='22F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-XX'">Real functions [See also 54C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26Axx'">Functions of one variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A03'">Foundations: limits and generalizations, elementary topology of the line</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A06'">One-variable calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A09'">Elementary functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A12'">Rate of growth of functions, orders of infinity, slowly varying functions [See also 26A48]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A15'">Continuity and related questions (modulus of continuity, semicontinuity, discontinuities, etc.) {For properties determined by Fourier coefficients, see 42A16; for those determined by approximation properties, see 41A25, 41A27}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A16'">Lipschitz (H&#xC3;&#xB6;lder) classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A18'">Iteration [See also 37Bxx, 37Cxx, 37Exx, 39B12, 47H10, 54H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A21'">Classification of real functions; Baire classification of sets and functions [See also 03E15, 28A05, 54C50, 54H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A24'">Differentiation (functions of one variable): general theory, generalized derivatives, mean-value theorems [See also 28A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A27'">Nondifferentiability (nondifferentiable functions, points of nondifferentiability), discontinuous derivatives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A30'">Singular functions, Cantor functions, functions with other special properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A33'">Fractional derivatives and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A36'">Antidifferentiation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A39'">Denjoy and Perron integrals, other special integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A42'">Integrals of Riemann, Stieltjes and Lebesgue type [See also 28-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A45'">Functions of bounded variation, generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A46'">Absolutely continuous functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A48'">Monotonic functions, generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A51'">Convexity, generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26Bxx'">Functions of several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B05'">Continuity and differentiation questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B10'">Implicit function theorems, Jacobians, transformations with several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B12'">Calculus of vector functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B15'">Integration: length, area, volume [See also 28A75, 51M25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B20'">Integral formulas (Stokes, Gauss, Green, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B25'">Convexity, generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B30'">Absolutely continuous functions, functions of bounded variation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B35'">Special properties of functions of several variables, H&#xC3;&#xB6;lder conditions, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B40'">Representation and superposition of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26Cxx'">Polynomials, rational functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26C05'">Polynomials: analytic properties, etc. [See also 12Dxx, 12Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26C10'">Polynomials: location of zeros [See also 12D10, 30C15, 65H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26C15'">Rational functions [See also 14Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26Dxx'">Inequalities {For maximal function inequalities, see 42B25; for functional inequalities, see 39B72; for probabilistic inequalities, see 60E15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D05'">Inequalities for trigonometric functions and polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D07'">Inequalities involving other types of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D10'">Inequalities involving derivatives and differential and integral operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D15'">Inequalities for sums, series and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D20'">Other analytical inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26Exx'">Miscellaneous topics [See also 58Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E05'">Real-analytic functions [See also 32B05, 32C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E10'">$C^\infty$-functions, quasi-analytic functions [See also 58C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E15'">Calculus of functions on infinite-dimensional spaces [See also 46G05, 58Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E20'">Calculus of functions taking values in infinite-dimensional spaces [See also 46E40, 46G10, 58Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E25'">Set-valued functions [See also 28B20, 49J53, 54C60] {For nonsmooth analysis, see 49J52, 58Cxx, 90Cxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E30'">Non-Archimedean analysis [See also 12J25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E35'">Nonstandard analysis [See also 03H05, 28E05, 54J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E40'">Constructive real analysis [See also 03F60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E50'">Fuzzy real analysis [See also 03E72, 28E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E60'">Means [See also 47A64]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E70'">Real analysis on time scales or measure chains {For dynamic equations on time scales or measure chains see 34N05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='26E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-XX'">Measure and integration {For analysis on manifolds, see 58-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28Axx'">Classical measure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A05'">Classes of sets (Borel fields, $\sigma$-rings, etc.), measurable sets, Suslin sets, analytic sets [See also 03E15, 26A21, 54H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A10'">Real- or complex-valued set functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A12'">Contents, measures, outer measures, capacities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A15'">Abstract differentiation theory, differentiation of set functions [See also 26A24]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A20'">Measurable and nonmeasurable functions, sequences of measurable functions, modes of convergence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A25'">Integration with respect to measures and other set functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A33'">Spaces of measures, convergence of measures [See also 46E27, 60Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A35'">Measures and integrals in product spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A50'">Integration and disintegration of measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A51'">Lifting theory [See also 46G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A60'">Measures on Boolean rings, measure algebras [See also 54H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A75'">Length, area, volume, other geometric measure theory [See also 26B15, 49Q15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A78'">Hausdorff and packing measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A80'">Fractals [See also 37Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28Bxx'">Set functions, measures and integrals with values in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28B05'">Vector-valued set functions, measures and integrals [See also 46G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28B10'">Group- or semigroup-valued set functions, measures and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28B15'">Set functions, measures and integrals with values in ordered spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28B20'">Set-valued set functions and measures; integration of set-valued functions; measurable selections [See also 26E25, 54C60, 54C65, 91B14]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28Cxx'">Set functions and measures on spaces with additional structure [See also 46G12, 58C35, 58D20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28C05'">Integration theory via linear functionals (Radon measures, Daniell integrals, etc.), representing set functions and measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28C10'">Set functions and measures on topological groups or semigroups, Haar measures, invariant measures [See also 22Axx, 43A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28C15'">Set functions and measures on topological spaces (regularity of measures, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28C20'">Set functions and measures and integrals in infinite-dimensional spaces (Wiener measure, Gaussian measure, etc.) [See also 46G12, 58C35, 58D20, 60B11]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28Dxx'">Measure-theoretic ergodic theory [See also 11K50, 11K55, 22D40, 37Axx, 47A35, 54H20, 60Fxx, 60G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28D05'">Measure-preserving transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28D10'">One-parameter continuous families of measure-preserving transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28D15'">General groups of measure-preserving transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28D20'">Entropy and other invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28Exx'">Miscellaneous topics in measure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28E05'">Nonstandard measure theory [See also 03H05, 26E35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28E10'">Fuzzy measure theory [See also 03E72, 26E50, 94D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28E15'">Other connections with logic and set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='28E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-XX'">Functions of a complex variable {For analysis on manifolds, see 58-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Axx'">General properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30A05'">Monogenic properties of complex functions (including polygenic and areolar monogenic functions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30A10'">Inequalities in the complex domain</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Bxx'">Series expansions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B10'">Power series (including lacunary series)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B20'">Random power series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B30'">Boundary behavior of power series, over-convergence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B40'">Analytic continuation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B50'">Dirichlet series and other series expansions, exponential series [See also 11M41, 42-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B60'">Completeness problems, closure of a system of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B70'">Continued fractions [See also 11A55, 40A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Cxx'">Geometric function theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C10'">Polynomials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C15'">Zeros of polynomials, rational functions, and other analytic functions (e.g. zeros of functions with bounded Dirichlet integral) {For algebraic theory, see 12D10; for real methods, see 26C10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C20'">Conformal mappings of special domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C25'">Covering theorems in conformal mapping theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C30'">Numerical methods in conformal mapping theory [See also 65E05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C35'">General theory of conformal mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C40'">Kernel functions and applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C45'">Special classes of univalent and multivalent functions (starlike, convex, bounded rotation, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C50'">Coefficient problems for univalent and multivalent functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C55'">General theory of univalent and multivalent functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C62'">Quasiconformal mappings in the plane</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C65'">Quasiconformal mappings in ${\bf R}^n$, other generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C70'">Extremal problems for conformal and quasiconformal mappings, variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C75'">Extremal problems for conformal and quasiconformal mappings, other methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C80'">Maximum principle; Schwarz's lemma, Lindel&#xC3;&#xB6;f principle, analogues and generalizations; subordination</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C85'">Capacity and harmonic measure in the complex plane [See also 31A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Dxx'">Entire and meromorphic functions, and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D05'">Functional equations in the complex domain, iteration and composition of analytic functions [See also 34Mxx, 37Fxx, 39-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D10'">Representations of entire functions by series and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D15'">Special classes of entire functions and growth estimates</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D20'">Entire functions, general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D30'">Meromorphic functions, general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D35'">Distribution of values, Nevanlinna theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D40'">Cluster sets, prime ends, boundary behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D45'">Bloch functions, normal functions, normal families</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D60'">Quasi-analytic and other classes of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Exx'">Miscellaneous topics of analysis in the complex domain</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E05'">Moment problems, interpolation problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E10'">Approximation in the complex domain</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E15'">Asymptotic representations in the complex domain</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E20'">Integration, integrals of Cauchy type, integral representations of analytic functions [See also 45Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E25'">Boundary value problems [See also 45Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Fxx'">Riemann surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F10'">Compact Riemann surfaces and uniformization [See also 14H15, 32G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F15'">Harmonic functions on Riemann surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F20'">Classification theory of Riemann surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F25'">Ideal boundary theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F30'">Differentials on Riemann surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F35'">Fuchsian groups and automorphic functions [See also 11Fxx, 20H10, 22E40, 32Gxx, 32Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F40'">Kleinian groups [See also 20H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F45'">Conformal metrics (hyperbolic, Poincar&#xC3;&#xA9;, distance functions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F50'">Klein surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F60'">Teichm&#xC3;&#xBC;ller theory [See also 32G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Gxx'">Generalized function theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G06'">Non-Archimedean function theory [See also 12J25]; nonstandard function theory [See also 03H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G12'">Finely holomorphic functions and topological function theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G20'">Generalizations of Bers or Vekua type (pseudoanalytic, $p$-analytic, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G25'">Discrete analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G30'">Other generalizations of analytic functions (including abstract-valued functions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G35'">Functions of hypercomplex variables and generalized variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Hxx'">Spaces and algebras of analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H05'">Bounded analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H10'">Hardy spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H15'">Nevanlinna class and Smirnov class</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H20'">Bergman spaces, Fock spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H25'">Besov spaces and $Q_p$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H30'">Bloch spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H35'">BMO-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H50'">Algebras of analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H80'">Corona theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Jxx'">Function theory on the disc</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30J05'">Inner functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30J10'">Blaschke products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30J15'">Singular inner functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Kxx'">Universal holomorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30K05'">Universal Taylor series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30K10'">Universal Dirichlet series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30K15'">Bounded universal functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30K20'">Compositional universality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30Lxx'">Analysis on metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30L05'">Geometric embeddings of metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30L10'">Quasiconformal mappings in metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='30L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-XX'">Potential theory {For probabilistic potential theory, see 60J45}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31Axx'">Two-dimensional theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A05'">Harmonic, subharmonic, superharmonic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A10'">Integral representations, integral operators, integral equations methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A15'">Potentials and capacity, harmonic measure, extremal length [See also 30C85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A20'">Boundary behavior (theorems of Fatou type, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A25'">Boundary value and inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A30'">Biharmonic, polyharmonic functions and equations, Poisson's equation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A35'">Connections with differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31Bxx'">Higher-dimensional theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B05'">Harmonic, subharmonic, superharmonic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B10'">Integral representations, integral operators, integral equations methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B15'">Potentials and capacities, extremal length</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B20'">Boundary value and inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B25'">Boundary behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B30'">Biharmonic and polyharmonic equations and functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B35'">Connections with differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31Cxx'">Other generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C05'">Harmonic, subharmonic, superharmonic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C10'">Pluriharmonic and plurisubharmonic functions [See also 32U05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C12'">Potential theory on Riemannian manifolds [See also 53C20; for Hodge theory, see 58A14]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C15'">Potentials and capacities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C20'">Discrete potential theory and numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C25'">Dirichlet spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C35'">Martin boundary theory [See also 60J50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C40'">Fine potential theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C45'">Other generalizations (nonlinear potential theory, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31Dxx'">Axiomatic potential theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31D05'">Axiomatic potential theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31Exx'">Potential theory on metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31E05'">Potential theory on metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='31E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-XX'">Several complex variables and analytic spaces {For infinite-dimensional holomorphy, see 46G20, 58B12}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Axx'">Holomorphic functions of several complex variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A05'">Power series, series of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A07'">Special domains (Reinhardt, Hartogs, circular, tube)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A10'">Holomorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A12'">Multifunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A15'">Entire functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A17'">Special families of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A18'">Bloch functions, normal functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A19'">Normal families of functions, mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A20'">Meromorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A22'">Nevanlinna theory (local); growth estimates; other inequalities {For geometric theory, see 32H25, 32H30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A25'">Integral representations; canonical kernels (Szeg&#xC3;&#x85;, Bergman, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A26'">Integral representations, constructed kernels (e.g. Cauchy, Fantappi&#xC3;&#xA8;-type kernels)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A27'">Local theory of residues [See also 32C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A30'">Other generalizations of function theory of one complex variable (should also be assigned at least one classification number from Section 30) {For functions of several hypercomplex variables, see 30G35}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A35'">$H^p$-spaces, Nevanlinna spaces [See also 32M15, 42B30, 43A85, 46J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A36'">Bergman spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A37'">Other spaces of holomorphic functions (e.g. bounded mean oscillation (BMOA), vanishing mean oscillation (VMOA)) [See also 46Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A38'">Algebras of holomorphic functions [See also 30H05, 46J10, 46J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A40'">Boundary behavior of holomorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A45'">Hyperfunctions [See also 46F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A50'">Harmonic analysis of several complex variables [See mainly 43-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A55'">Singular integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A60'">Zero sets of holomorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A65'">Banach algebra techniques [See mainly 46Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A70'">Functional analysis techniques [See mainly 46Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Bxx'">Local analytic geometry [See also 13-XX and 14-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B05'">Analytic algebras and generalizations, preparation theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B10'">Germs of analytic sets, local parametrization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B15'">Analytic subsets of affine space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B20'">Semi-analytic sets and subanalytic sets [See also 14P15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B25'">Triangulation and related questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Cxx'">Analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C05'">Real-analytic manifolds, real-analytic spaces [See also 14Pxx, 58A07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C07'">Real-analytic sets, complex Nash functions [See also 14P15, 14P20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C09'">Embedding of real analytic manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C11'">Complex supergeometry [See also 14A22, 14M30, 58A50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C15'">Complex spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C18'">Topology of analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C20'">Normal analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C22'">Embedding of analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C25'">Analytic subsets and submanifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C30'">Integration on analytic sets and spaces, currents {For local theory, see 32A25 or 32A27}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C35'">Analytic sheaves and cohomology groups [See also 14Fxx, 18F20, 55N30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C36'">Local cohomology of analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C37'">Duality theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C38'">Sheaves of differential operators and their modules, $D$-modules [See also 14F10, 16S32, 35A27, 58J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C55'">The Levi problem in complex spaces; generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C81'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Dxx'">Analytic continuation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D05'">Domains of holomorphy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D10'">Envelopes of holomorphy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D15'">Continuation of analytic objects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D20'">Removable singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D26'">Riemann domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Exx'">Holomorphic convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E05'">Holomorphically convex complex spaces, reduction theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E10'">Stein spaces, Stein manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E20'">Polynomial convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E30'">Holomorphic and polynomial approximation, Runge pairs, interpolation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E35'">Global boundary behavior of holomorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E40'">The Levi problem</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Fxx'">Geometric convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F10'">$q$-convexity, $q$-concavity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F17'">Other notions of convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F18'">Finite-type conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F27'">Topological consequences of geometric convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F32'">Analytical consequences of geometric convexity (vanishing theorems, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F45'">Invariant metrics and pseudodistances</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Gxx'">Deformations of analytic structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G05'">Deformations of complex structures [See also 13D10, 16S80, 58H10, 58H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G07'">Deformations of special (e.g. CR) structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G08'">Deformations of fiber bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G10'">Deformations of submanifolds and subspaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G13'">Analytic moduli problems {For algebraic moduli problems, see 14D20, 14D22, 14H10, 14J10} [See also 14H15, 14J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G15'">Moduli of Riemann surfaces, Teichm&#xC3;&#xBC;ller theory [See also 14H15, 30Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G20'">Period matrices, variation of Hodge structure; degenerations [See also 14D05, 14D07, 14K30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G34'">Moduli and deformations for ordinary differential equations (e.g. Knizhnik-Zamolodchikov equation) [See also 34Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G81'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Hxx'">Holomorphic mappings and correspondences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H02'">Holomorphic mappings, (holomorphic) embeddings and related questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H04'">Meromorphic mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H12'">Boundary uniqueness of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H25'">Picard-type theorems and generalizations {For function-theoretic properties, see 32A22}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H30'">Value distribution theory in higher dimensions {For function-theoretic properties, see 32A22}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H35'">Proper mappings, finiteness theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H40'">Boundary regularity of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H50'">Iteration problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Jxx'">Compact analytic spaces {For Riemann surfaces, see 14Hxx, 30Fxx; for algebraic theory, see 14Jxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J05'">Compactification of analytic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J10'">Algebraic dependence theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J15'">Compact surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J17'">Compact $3$-folds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J18'">Compact $n$-folds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J25'">Transcendental methods of algebraic geometry [See also 14C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J27'">Compact K&#xC3;&#xA4;hler manifolds: generalizations, classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J81'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Kxx'">Generalizations of analytic spaces (should also be assigned at least one other classification number from Section 32 describing the type of problem)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32K05'">Banach analytic spaces [See also 58Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32K07'">Formal and graded complex spaces [See also 58C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32K15'">Differentiable functions on analytic spaces, differentiable spaces [See also 58C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Lxx'">Holomorphic fiber spaces [See also 55Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L05'">Holomorphic bundles and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L10'">Sheaves and cohomology of sections of holomorphic vector bundles, general results [See also 14F05, 18F20, 55N30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L15'">Bundle convexity [See also 32F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L20'">Vanishing theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L25'">Twistor theory, double fibrations [See also 53C28]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L81'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Mxx'">Complex spaces with a group of automorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M05'">Complex Lie groups, automorphism groups acting on complex spaces [See also 22E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M10'">Homogeneous complex manifolds [See also 14M17, 57T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M12'">Almost homogeneous manifolds and spaces [See also 14M17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M15'">Hermitian symmetric spaces, bounded symmetric domains, Jordan algebras [See also 22E10, 22E40, 53C35, 57T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M17'">Automorphism groups of ${\bf C}^n$ and affine manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M25'">Complex vector fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Nxx'">Automorphic functions [See also 11Fxx, 20H10, 22E40, 30F35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32N05'">General theory of automorphic functions of several complex variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32N10'">Automorphic forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32N15'">Automorphic functions in symmetric domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Pxx'">Non-Archimedean analysis (should also be assigned at least one other classification number from Section 32 describing the type of problem)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32P05'">Non-Archimedean analysis (should also be assigned at least one other classification number from Section 32 describing the type of problem)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Qxx'">Complex manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q05'">Negative curvature manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q10'">Positive curvature manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q15'">K&#xC3;&#xA4;hler manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q20'">K&#xC3;&#xA4;hler-Einstein manifolds [See also 53Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q25'">Calabi-Yau theory [See also 14J30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q26'">Notions of stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q28'">Stein manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q30'">Uniformization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q35'">Complex manifolds as subdomains of Euclidean space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q40'">Embedding theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q45'">Hyperbolic and Kobayashi hyperbolic manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q55'">Topological aspects of complex manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q57'">Classification theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q60'">Almost complex manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q65'">Pseudoholomorphic curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Sxx'">Singularities [See also 58Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S05'">Local singularities [See also 14J17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S10'">Invariants of analytic local rings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S15'">Equisingularity (topological and analytic) [See also 14E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S20'">Global theory of singularities; cohomological properties [See also 14E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S22'">Relations with arrangements of hyperplanes [See also 52C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S25'">Surface and hypersurface singularities [See also 14J17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S30'">Deformations of singularities; vanishing cycles [See also 14B07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S35'">Mixed Hodge theory of singular varieties [See also 14C30, 14D07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S40'">Monodromy; relations with differential equations and $D$-modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S45'">Modifications; resolution of singularities [See also 14E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S50'">Topological aspects: Lefschetz theorems, topological classification, invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S55'">Milnor fibration; relations with knot theory [See also 57M25, 57Q45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S60'">Stratifications; constructible sheaves; intersection cohomology [See also 58Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S65'">Singularities of holomorphic vector fields and foliations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S70'">Other operations on singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Txx'">Pseudoconvex domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T05'">Domains of holomorphy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T15'">Strongly pseudoconvex domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T20'">Worm domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T25'">Finite type domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T27'">Geometric and analytic invariants on weakly pseudoconvex boundaries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T35'">Exhaustion functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T40'">Peak functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Uxx'">Pluripotential theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U05'">Plurisubharmonic functions and generalizations [See also 31C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U10'">Plurisubharmonic exhaustion functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U15'">General pluripotential theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U20'">Capacity theory and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U25'">Lelong numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U30'">Removable sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U35'">Pluricomplex Green functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U40'">Currents</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Vxx'">CR manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V05'">CR structures, CR operators, and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V10'">CR functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V15'">CR manifolds as boundaries of domains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V20'">Analysis on CR manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V25'">Extension of functions and other analytic objects from CR manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V30'">Embeddings of CR manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V35'">Finite type conditions on CR manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V40'">Real submanifolds in complex manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32V99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32Wxx'">Differential operators in several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W05'">$\overline\partial$ and $\overline\partial$-Neumann operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W10'">$\overline\partial_b$ and $\overline\partial_b$-Neumann operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W20'">Complex Monge-Amp&#xC3;&#xA8;re operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W25'">Pseudodifferential operators in several complex variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W30'">Heat kernels in several complex variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W50'">Other partial differential equations of complex analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='32W99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-XX'">Special functions (33-XX deals with the properties of functions as functions) {For orthogonal functions, see 42Cxx; for aspects of combinatorics see 05Axx; for number-theoretic aspects see 11-XX; for representation theory see 22Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33Bxx'">Elementary classical functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33B10'">Exponential and trigonometric functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33B15'">Gamma, beta and polygamma functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33B20'">Incomplete beta and gamma functions (error functions, probability integral, Fresnel integrals)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33B30'">Higher logarithm functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33Cxx'">Hypergeometric functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C05'">Classical hypergeometric functions, ${}_2F_1$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C10'">Bessel and Airy functions, cylinder functions, ${}_0F_1$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C15'">Confluent hypergeometric functions, Whittaker functions, ${}_1F_1$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C20'">Generalized hypergeometric series, ${}_pF_q$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C45'">Orthogonal polynomials and functions of hypergeometric type (Jacobi, Laguerre, Hermite, Askey scheme, etc.) [See also 42C05 for general orthogonal polynomials and functions]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C47'">Other special orthogonal polynomials and functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C50'">Orthogonal polynomials and functions in several variables expressible in terms of special functions in one variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C52'">Orthogonal polynomials and functions associated with root systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C55'">Spherical harmonics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C60'">Hypergeometric integrals and functions defined by them ($E$, $G$, $H$ and $I$ functions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C65'">Appell, Horn and Lauricella functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C67'">Hypergeometric functions associated with root systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C70'">Other hypergeometric functions and integrals in several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C75'">Elliptic integrals as hypergeometric functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C80'">Connections with groups and algebras, and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C90'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33Dxx'">Basic hypergeometric functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D05'">$q$-gamma functions, $q$-beta functions and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D15'">Basic hypergeometric functions in one variable, ${}_r\phi_s$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D45'">Basic orthogonal polynomials and functions (Askey-Wilson polynomials, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D50'">Orthogonal polynomials and functions in several variables expressible in terms of basic hypergeometric functions in one variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D52'">Basic orthogonal polynomials and functions associated with root systems (Macdonald polynomials, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D60'">Basic hypergeometric integrals and functions defined by them</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D65'">Bibasic functions and multiple bases</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D67'">Basic hypergeometric functions associated with root systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D70'">Other basic hypergeometric functions and integrals in several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D80'">Connections with quantum groups, Chevalley groups, $p$-adic groups, Hecke algebras, and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D90'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33Exx'">Other special functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E05'">Elliptic functions and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E10'">Lam&#xC3;&#xA9;, Mathieu, and spheroidal wave functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E12'">Mittag-Leffler functions and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E15'">Other wave functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E17'">Painlev&#xC3;&#xA9;-type functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E20'">Other functions defined by series and integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E30'">Other functions coming from differential, difference and integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E50'">Special functions in characteristic $p$ (gamma functions, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33Fxx'">Computational aspects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33F05'">Numerical approximation and evaluation [See also 65D20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33F10'">Symbolic computation (Gosper and Zeilberger algorithms, etc.) [See also 68W30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='33F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-XX'">Ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Axx'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A05'">Explicit solutions and reductions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A07'">Fuzzy differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A08'">Fractional differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A09'">Implicit equations, differential-algebraic equations [See also 65L80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A12'">Initial value problems, existence, uniqueness, continuous dependence and continuation of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A25'">Analytical theory: series, transformations, transforms, operational calculus, etc. [See also 44-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A26'">Geometric methods in differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A30'">Linear equations and systems, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A33'">Lattice differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A34'">Nonlinear equations and systems, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A35'">Differential equations of infinite order</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A36'">Discontinuous equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A37'">Differential equations with impulses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A38'">Hybrid systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A40'">Differential inequalities [See also 26D20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A45'">Theoretical approximation of solutions {For numerical analysis, see 65Lxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A55'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A60'">Differential inclusions [See also 49J21, 49K21]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Bxx'">Boundary value problems {For ordinary differential operators, see 34Lxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B05'">Linear boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B07'">Linear boundary value problems with nonlinear dependence on the spectral parameter</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B08'">Parameter dependent boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B09'">Boundary eigenvalue problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B10'">Nonlocal and multipoint boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B15'">Nonlinear boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B16'">Singular nonlinear boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B18'">Positive solutions of nonlinear boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B20'">Weyl theory and its generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B24'">Sturm-Liouville theory [See also 34Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B27'">Green functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B30'">Special equations (Mathieu, Hill, Bessel, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B37'">Boundary value problems with impulses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B40'">Boundary value problems on infinite intervals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B45'">Boundary value problems on graphs and networks</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B60'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Cxx'">Qualitative theory [See also 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C05'">Location of integral curves, singular points, limit cycles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C07'">Theory of limit cycles of polynomial and analytic vector fields (existence, uniqueness, bounds, Hilbert's 16th problem and ramifications)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C08'">Connections with real algebraic geometry (fewnomials, desingularization, zeros of Abelian integrals, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C10'">Oscillation theory, zeros, disconjugacy and comparison theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C11'">Growth, boundedness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C12'">Monotone systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C14'">Symmetries, invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C15'">Nonlinear oscillations, coupled oscillators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C20'">Transformation and reduction of equations and systems, normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C23'">Bifurcation [See also 37Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C25'">Periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C26'">Relaxation oscillations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C27'">Almost and pseudo-almost periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C28'">Complex behavior, chaotic systems [See also 37Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C29'">Averaging method</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C37'">Homoclinic and heteroclinic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C40'">Equations and systems on manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C41'">Equivalence, asymptotic equivalence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C45'">Invariant manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C46'">Multifrequency systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C55'">Hysteresis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C60'">Qualitative investigation and simulation of models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Dxx'">Stability theory [See also 37C75, 93Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D05'">Asymptotic properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D06'">Synchronization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D08'">Characteristic and Lyapunov exponents</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D09'">Dichotomy, trichotomy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D10'">Perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D15'">Singular perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D20'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D23'">Global stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D30'">Structural stability and analogous concepts [See also 37C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D35'">Stability of manifolds of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D45'">Attractors [See also 37C70, 37D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Exx'">Asymptotic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E05'">Asymptotic expansions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E10'">Perturbations, asymptotics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E13'">Multiple scale methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E15'">Singular perturbations, general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E17'">Canard solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E18'">Methods of nonstandard analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E20'">Singular perturbations, turning point theory, WKB methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Fxx'">Equations and systems with randomness [See also 34K50, 60H10, 93E03]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34F05'">Equations and systems with randomness [See also 34K50, 60H10, 93E03]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34F10'">Bifurcation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34F15'">Resonance phenomena</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Gxx'">Differential equations in abstract spaces [See also 34Lxx, 37Kxx, 47Dxx, 47Hxx, 47Jxx, 58D25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34G10'">Linear equations [See also 47D06, 47D09]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34G20'">Nonlinear equations [See also 47Hxx, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34G25'">Evolution inclusions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Hxx'">Control problems [See also 49J15, 49K15, 93C15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34H05'">Control problems [See also 49J15, 49K15, 93C15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34H10'">Chaos control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34H15'">Stabilization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34H20'">Bifurcation control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Kxx'">Functional-differential and differential-difference equations [See also 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K06'">Linear functional-differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K07'">Theoretical approximation of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K08'">Spectral theory of functional-differential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K09'">Functional-differential inclusions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K10'">Boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K11'">Oscillation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K12'">Growth, boundedness, comparison of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K13'">Periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K14'">Almost and pseudo-periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K17'">Transformation and reduction of equations and systems, normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K18'">Bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K19'">Invariant manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K20'">Stability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K21'">Stationary solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K23'">Complex (chaotic) behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K25'">Asymptotic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K26'">Singular perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K27'">Perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K28'">Numerical approximation of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K29'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K30'">Equations in abstract spaces [See also 34Gxx, 35R09, 35R10, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K31'">Lattice functional-differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K32'">Implicit equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K33'">Averaging</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K34'">Hybrid systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K35'">Control problems [See also 49J21, 49K21, 93C23]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K36'">Fuzzy functional-differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K37'">Functional-differential equations with fractional derivatives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K38'">Functional-differential inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K40'">Neutral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K45'">Equations with impulses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K50'">Stochastic functional-differential equations [See also 60Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K60'">Qualitative investigation and simulation of models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Lxx'">Ordinary differential operators [See also 47E05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L05'">General spectral theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L10'">Eigenfunctions, eigenfunction expansions, completeness of eigenfunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L15'">Eigenvalues, estimation of eigenvalues, upper and lower bounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L16'">Numerical approximation of eigenvalues and of other parts of the spectrum</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L20'">Asymptotic distribution of eigenvalues, asymptotic theory of eigenfunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L25'">Scattering theory, inverse scattering</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L30'">Nonlinear ordinary differential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L40'">Particular operators (Dirac, one-dimensional Schr&#xC3;&#xB6;dinger, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Mxx'">Differential equations in the complex domain [See also 30Dxx, 32G34]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M03'">Linear equations and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M05'">Entire and meromorphic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M10'">Oscillation, growth of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M15'">Algebraic aspects (differential-algebraic, hypertranscendence, group-theoretical)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M25'">Formal solutions, transform techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M30'">Asymptotics, summation methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M35'">Singularities, monodromy, local behavior of solutions, normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M40'">Stokes phenomena and connection problems (linear and nonlinear)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M45'">Differential equations on complex manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M50'">Inverse problems (Riemann-Hilbert, inverse differential Galois, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M55'">Painlev&#xC3;&#xA9; and other special equations; classification, hierarchies;</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M56'">Isomonodromic deformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M60'">Singular perturbation problems in the complex domain (complex WKB, turning points, steepest descent) [See also 34E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34Nxx'">Dynamic equations on time scales or measure chains {For real analysis on time scales see 26E70}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34N05'">Dynamic equations on time scales or measure chains {For real analysis on time scales or measure chains, see 26E70}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='34N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-XX'">Partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Axx'">General topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A01'">Existence problems: global existence, local existence, non-existence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A02'">Uniqueness problems: global uniqueness, local uniqueness, non-uniqueness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A08'">Fundamental solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A09'">Classical solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A10'">Cauchy-Kovalevskaya theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A15'">Variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A16'">Topological and monotonicity methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A17'">Parametrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A18'">Wave front sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A20'">Analytic methods, singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A21'">Propagation of singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A22'">Transform methods (e.g. integral transforms)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A23'">Inequalities involving derivatives and differential and integral operators, inequalities for integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A24'">Methods of ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A25'">Other special methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A27'">Microlocal methods; methods of sheaf theory and homological algebra in PDE [See also 32C38, 58J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A30'">Geometric theory, characteristics, transformations [See also 58J70, 58J72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A35'">Theoretical approximation to solutions {For numerical analysis, see 65Mxx, 65Nxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Bxx'">Qualitative properties of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B05'">Oscillation, zeros of solutions, mean value theorems, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B06'">Symmetries, invariants, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B07'">Axially symmetric solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B08'">Entire solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B09'">Positive solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B10'">Periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B15'">Almost and pseudo-almost periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B20'">Perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B25'">Singular perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B27'">Homogenization; equations in media with periodic structure [See also 74Qxx, 76M50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B30'">Dependence of solutions on initial and boundary data, parameters [See also 37Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B32'">Bifurcation [See also 37Gxx, 37K50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B33'">Critical exponents</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B34'">Resonances</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B35'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B36'">Pattern formation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B38'">Critical points</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B40'">Asymptotic behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B41'">Attractors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B42'">Inertial manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B44'">Blow-up</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B45'">A priori estimates</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B50'">Maximum principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B51'">Comparison principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B53'">Liouville theorems, Phragm&#xC3;&#xA9;n-Lindel&#xC3;&#xB6;f theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B60'">Continuation and prolongation of solutions [See also 58A15, 58A17, 58Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B65'">Smoothness and regularity of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Cxx'">Representations of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C05'">Solutions in closed form</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C06'">Self-similar solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C07'">Traveling wave solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C08'">Soliton solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C09'">Trigonometric solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C10'">Series solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C11'">Polynomial solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C15'">Integral representations of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C20'">Asymptotic expansions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Dxx'">Generalized solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35D30'">Weak solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35D35'">Strong solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35D40'">Viscosity solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Exx'">Equations and systems with constant coefficients [See also 35N05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35E05'">Fundamental solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35E10'">Convexity properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35E15'">Initial value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35E20'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Fxx'">General first-order equations and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F05'">Linear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F10'">Initial value problems for linear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F15'">Boundary value problems for linear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F16'">Initial-boundary value problems for linear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F20'">Nonlinear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F21'">Hamilton-Jacobi equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F25'">Initial value problems for nonlinear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F30'">Boundary value problems for nonlinear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F31'">Initial-boundary value problems for nonlinear first-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F35'">Linear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F40'">Initial value problems for linear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F45'">Boundary value problems for linear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F46'">Initial-boundary value problems for linear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F50'">Nonlinear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F55'">Initial value problems for nonlinear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F60'">Boundary value problems for nonlinear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F61'">Initial-boundary value problems for nonlinear first-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Gxx'">General higher-order equations and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G05'">Linear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G10'">Initial value problems for linear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G15'">Boundary value problems for linear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G16'">Initial-boundary value problems for linear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G20'">Nonlinear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G25'">Initial value problems for nonlinear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G30'">Boundary value problems for nonlinear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G31'">Initial-boundary value problems for nonlinear higher-order equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G35'">Linear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G40'">Initial value problems for linear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G45'">Boundary value problems for linear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G46'">Initial-boundary value problems for linear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G50'">Nonlinear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G55'">Initial value problems for nonlinear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G60'">Boundary value problems for nonlinear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G61'">Initial-boundary value problems for nonlinear higher-order systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Hxx'">Close-to-elliptic equations and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35H10'">Hypoelliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35H20'">Subelliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35H30'">Quasi-elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Jxx'">Elliptic equations and systems [See also 58J10, 58J20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J05'">Laplacian operator, reduced wave equation (Helmholtz equation), Poisson equation [See also 31Axx, 31Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J08'">Green's functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J10'">Schr&#xC3;&#xB6;dinger operator [See also 35Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J15'">Second-order elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J20'">Variational methods for second-order elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J25'">Boundary value problems for second-order elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J30'">Higher-order elliptic equations [See also 31A30, 31B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J35'">Variational methods for higher-order elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J40'">Boundary value problems for higher-order elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J46'">First-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J47'">Second-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J48'">Higher-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J50'">Variational methods for elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J56'">Boundary value problems for first-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J57'">Boundary value problems for second-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J58'">Boundary value problems for higher-order elliptic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J60'">Nonlinear elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J61'">Semilinear elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J62'">Quasilinear elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J65'">Nonlinear boundary value problems for linear elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J66'">Nonlinear boundary value problems for nonlinear elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J67'">Boundary values of solutions to elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J70'">Degenerate elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J75'">Singular elliptic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J86'">Linear elliptic unilateral problems and linear elliptic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J87'">Nonlinear elliptic unilateral problems and nonlinear elliptic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J88'">Systems of elliptic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J91'">Semilinear elliptic equations with Laplacian, bi-Laplacian or poly-Laplacian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J92'">Quasilinear elliptic equations with $p$-Laplacian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J93'">Quasilinear elliptic equations with mean curvature operator</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J96'">Elliptic Monge-Amp&#xC3;&#xA8;re equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Kxx'">Parabolic equations and systems [See also 35Bxx, 35Dxx, 35R30, 35R35, 58J35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K05'">Heat equation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K08'">Heat kernel</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K10'">Second-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K15'">Initial value problems for second-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K20'">Initial-boundary value problems for second-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K25'">Higher-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K30'">Initial value problems for higher-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K35'">Initial-boundary value problems for higher-order parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K40'">Second-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K41'">Higher-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K45'">Initial value problems for second-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K46'">Initial value problems for higher-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K51'">Initial-boundary value problems for second-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K52'">Initial-boundary value problems for higher-order parabolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K55'">Nonlinear parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K57'">Reaction-diffusion equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K58'">Semilinear parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K59'">Quasilinear parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K60'">Nonlinear initial value problems for linear parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K61'">Nonlinear initial-boundary value problems for nonlinear parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K65'">Degenerate parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K67'">Singular parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K70'">Ultraparabolic equations, pseudoparabolic equations, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K85'">Linear parabolic unilateral problems and linear parabolic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K86'">Nonlinear parabolic unilateral problems and nonlinear parabolic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K87'">Systems of parabolic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K90'">Abstract parabolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K91'">Semilinear parabolic equations with Laplacian, bi-Laplacian or poly-Laplacian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K92'">Quasilinear parabolic equations with $p$-Laplacian</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K93'">Quasilinear parabolic equations with mean curvature operator</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K96'">Parabolic Monge-Amp&#xC3;&#xA8;re equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Lxx'">Hyperbolic equations and systems [See also 58J45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L02'">First-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L03'">Initial value problems for first-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L04'">Initial-boundary value problems for first-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L05'">Wave equation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L10'">Second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L15'">Initial value problems for second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L20'">Initial-boundary value problems for second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L25'">Higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L30'">Initial value problems for higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L35'">Initial-boundary value problems for higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L40'">First-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L45'">Initial value problems for first-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L50'">Initial-boundary value problems for first-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L51'">Second-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L52'">Initial value problems for second-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L53'">Initial-boundary value problems for second-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L55'">Higher-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L56'">Initial value problems for higher-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L57'">Initial-boundary value problems for higher-order hyperbolic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L60'">Nonlinear first-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L65'">Conservation laws</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L67'">Shocks and singularities [See also 58Kxx, 76L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L70'">Nonlinear second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L71'">Semilinear second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L72'">Quasilinear second-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L75'">Nonlinear higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L76'">Semilinear higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L77'">Quasilinear higher-order hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L80'">Degenerate hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L81'">Singular hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L82'">Pseudohyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L85'">Linear hyperbolic unilateral problems and linear hyperbolic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L86'">Nonlinear hyperbolic unilateral problems and nonlinear hyperbolic variational inequalities [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L87'">Unilateral problems and variational inequalities for hyperbolic systems [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L90'">Abstract hyperbolic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Mxx'">Equations and systems of special type (mixed, composite, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M10'">Equations of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M11'">Initial value problems for equations of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M12'">Boundary value problems for equations of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M13'">Initial-boundary value problems for equations of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M30'">Systems of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M31'">Initial value problems for systems of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M32'">Boundary value problems for systems of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M33'">Initial-boundary value problems for systems of mixed type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M85'">Linear unilateral problems and variational inequalities of mixed type [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M86'">Nonlinear unilateral problems and nonlinear variational inequalities of mixed type [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M87'">Systems of variational inequalities of mixed type [See also 35R35, 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Nxx'">Overdetermined systems [See also 58Hxx, 58J10, 58J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N05'">Overdetermined systems with constant coefficients</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N10'">Overdetermined systems with variable coefficients</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N15'">$\overline\partial$-Neumann problem and generalizations; formal complexes [See also 32W05, 32W10, 58J10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N20'">Overdetermined initial value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N25'">Overdetermined boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N30'">Overdetermined initial-boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Pxx'">Spectral theory and eigenvalue problems [See also 47Axx, 47Bxx, 47F05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P05'">General topics in linear spectral theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P10'">Completeness of eigenfunctions, eigenfunction expansions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P15'">Estimation of eigenvalues, upper and lower bounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P20'">Asymptotic distribution of eigenvalues and eigenfunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P25'">Scattering theory [See also 47A40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P30'">Nonlinear eigenvalue problems, nonlinear spectral theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Qxx'">Equations of mathematical physics and other areas of application [See also 35J05, 35J10, 35K05, 35L05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q05'">Euler-Poisson-Darboux equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q15'">Riemann-Hilbert problems [See also 30E25, 31A25, 31B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q20'">Boltzmann equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q30'">Navier-Stokes equations [See also 76D05, 76D07, 76N10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q31'">Euler equations [See also 76D05, 76D07, 76N10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q35'">PDEs in connection with fluid mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q40'">PDEs in connection with quantum mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q41'">Time-dependent Schr&#xC3;&#xB6;dinger equations, Dirac equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q51'">Soliton-like equations [See also 37K40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q53'">KdV-like equations (Korteweg-de Vries) [See also 37K10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q55'">NLS-like equations (nonlinear Schr&#xC3;&#xB6;dinger) [See also 37K10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q56'">Ginzburg-Landau equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q60'">PDEs in connection with optics and electromagnetic theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q61'">Maxwell equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q62'">PDEs in connection with statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q68'">PDEs in connection with computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q70'">PDEs in connection with mechanics of particles and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q74'">PDEs in connection with mechanics of deformable solids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q75'">PDEs in connection with relativity and gravitational theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q76'">Einstein equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q79'">PDEs in connection with classical thermodynamics and heat transfer</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q82'">PDEs in connection with statistical mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q83'">Vlasov-like equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q84'">Fokker-Planck equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q85'">PDEs in connection with astronomy and astrophysics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q86'">PDEs in connection with geophysics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q90'">PDEs in connection with mathematical programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q91'">PDEs in connection with game theory, economics, social and behavioral sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q92'">PDEs in connection with biology and other natural sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q93'">PDEs in connection with control and optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q94'">PDEs in connection with information and communication</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Rxx'">Miscellaneous topics {For equations on manifolds, see 58Jxx; for manifolds of solutions, see 58Bxx; for stochastic PDE, see also 60H15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R01'">Partial differential equations on manifolds [See also 32Wxx, 53Cxx, 58Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R02'">Partial differential equations on graphs and networks (ramified or polygonal spaces)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R03'">Partial differential equations on Heisenberg groups, Lie groups, Carnot groups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R05'">Partial differential equations with discontinuous coefficients or data</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R06'">Partial differential equations with measure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R09'">Integro-partial differential equations [See also 45Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R10'">Partial functional-differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R11'">Fractional partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R12'">Impulsive partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R13'">Fuzzy partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R15'">Partial differential equations on infinite-dimensional (e.g. function) spaces (= PDE in infinitely many variables) [See also 46Gxx, 58D25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R20'">Partial operator-differential equations (i.e., PDE on finite-dimensional spaces for abstract space valued functions) [See also 34Gxx, 47A50, 47D03, 47D06, 47D09, 47H20, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R25'">Improperly posed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R30'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R35'">Free boundary problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R37'">Moving boundary problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R45'">Partial differential inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R50'">Partial differential equations of infinite order</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R60'">Partial differential equations with randomness, stochastic partial differential equations [See also 60H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R70'">Partial differential equations with multivalued right-hand sides</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35Sxx'">Pseudodifferential operators and other generalizations of partial differential operators [See also 47G30, 58J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S05'">Pseudodifferential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S10'">Initial value problems for pseudodifferential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S11'">Initial-boundary value problems for pseudodifferential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S15'">Boundary value problems for pseudodifferential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S30'">Fourier integral operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S35'">Topological aspects: intersection cohomology, stratified sets, etc. [See also 32C38, 32S40, 32S60, 58J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S50'">Paradifferential operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='35S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-XX'">Dynamical systems and ergodic theory [See also 26A18, 28Dxx, 34Cxx, 34Dxx, 35Bxx, 46Lxx, 58Jxx, 70-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Axx'">Ergodic theory [See also 28Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A05'">Measure-preserving transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A10'">One-parameter continuous families of measure-preserving transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A15'">General groups of measure-preserving transformations [See mainly 22Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A17'">Homogeneous flows [See also 22Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A20'">Orbit equivalence, cocycles, ergodic equivalence relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A25'">Ergodicity, mixing, rates of mixing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A30'">Ergodic theorems, spectral theory, Markov operators {For operator ergodic theory, see mainly 47A35}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A35'">Entropy and other invariants, isomorphism, classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A40'">Nonsingular (and infinite-measure preserving) transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A45'">Relations with number theory and harmonic analysis [See also 11Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A50'">Relations with probability theory and stochastic processes [See also 60Fxx and 60G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A55'">Relations with the theory of $C^*$-algebras [See mainly 46L55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A60'">Dynamical systems in statistical mechanics [See also 82Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Bxx'">Topological dynamics [See also 54H20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B05'">Transformations and group actions with special properties (minimality, distality, proximality, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B10'">Symbolic dynamics [See also 37Cxx, 37Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B15'">Cellular automata [See also 68Q80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B20'">Notions of recurrence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B25'">Lyapunov functions and stability; attractors, repellers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B30'">Index theory, Morse-Conley indices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B35'">Gradient-like and recurrent behavior; isolated (locally maximal) invariant sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B40'">Topological entropy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B45'">Continua theory in dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B50'">Multi-dimensional shifts of finite type, tiling dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B55'">Nonautonomous dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Cxx'">Smooth dynamical systems: general theory [See also 34Cxx, 34Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C05'">Smooth mappings and diffeomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C10'">Vector fields, flows, ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C15'">Topological and differentiable equivalence, conjugacy, invariants, moduli, classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C20'">Generic properties, structural stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C25'">Fixed points, periodic points, fixed-point index theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C27'">Periodic orbits of vector fields and flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C29'">Homoclinic and heteroclinic orbits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C30'">Zeta functions, (Ruelle-Frobenius) transfer operators, and other functional analytic techniques in dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C35'">Orbit growth</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C40'">Smooth ergodic theory, invariant measures [See also 37Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C45'">Dimension theory of dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C50'">Approximate trajectories (pseudotrajectories, shadowing, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C55'">Periodic and quasiperiodic flows and diffeomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C60'">Nonautonomous smooth dynamical systems [See also 37B55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C65'">Monotone flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C70'">Attractors and repellers, topological structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C75'">Stability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C80'">Symmetries, equivariant dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C85'">Dynamics of group actions other than ${\bf Z}$ and ${\bf R}$, and foliations [See mainly 22Fxx, and also 57R30, 57Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Dxx'">Dynamical systems with hyperbolic behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D05'">Hyperbolic orbits and sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D10'">Invariant manifold theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D15'">Morse-Smale systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D20'">Uniformly hyperbolic systems (expanding, Anosov, Axiom A, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D25'">Nonuniformly hyperbolic systems (Lyapunov exponents, Pesin theory, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D30'">Partially hyperbolic systems and dominated splittings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D35'">Thermodynamic formalism, variational principles, equilibrium states</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D40'">Dynamical systems of geometric origin and hyperbolicity (geodesic and horocycle flows, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D45'">Strange attractors, chaotic dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D50'">Hyperbolic systems with singularities (billiards, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Exx'">Low-dimensional dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E05'">Maps of the interval (piecewise continuous, continuous, smooth)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E10'">Maps of the circle</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E15'">Combinatorial dynamics (types of periodic orbits)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E20'">Universality, renormalization [See also 37F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E25'">Maps of trees and graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E30'">Homeomorphisms and diffeomorphisms of planes and surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E35'">Flows on surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E40'">Twist maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E45'">Rotation numbers and vectors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Fxx'">Complex dynamical systems [See also 30D05, 32H50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F05'">Relations and correspondences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F10'">Polynomials; rational maps; entire and meromorphic functions [See also 32A10, 32A20, 32H02, 32H04]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F15'">Expanding maps; hyperbolicity; structural stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F20'">Combinatorics and topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F25'">Renormalization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F30'">Quasiconformal methods and Teichm&#xC3;&#xBC;ller theory; Fuchsian and Kleinian groups as dynamical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F35'">Conformal densities and Hausdorff dimension</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F40'">Geometric limits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F45'">Holomorphic families of dynamical systems; the Mandelbrot set; bifurcations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F50'">Small divisors, rotation domains and linearization; Fatou and Julia sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F75'">Holomorphic foliations and vector fields [See also 32M25, 32S65, 34Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Gxx'">Local and nonlocal bifurcation theory [See also 34C23, 34K18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G05'">Normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G10'">Bifurcations of singular points</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G15'">Bifurcations of limit cycles and periodic orbits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G20'">Hyperbolic singular points with homoclinic trajectories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G25'">Bifurcations connected with nontransversal intersection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G30'">Infinite nonwandering sets arising in bifurcations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G35'">Attractors and their bifurcations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G40'">Symmetries, equivariant bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Hxx'">Random dynamical systems [See also 15B52, 34D08, 34F05, 47B80, 70L05, 82C05, 93Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37H05'">Foundations, general theory of cocycles, algebraic ergodic theory [See also 37Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37H10'">Generation, random and stochastic difference and differential equations [See also 34F05, 34K50, 60H10, 60H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37H15'">Multiplicative ergodic theory, Lyapunov exponents [See also 34D08, 37Axx, 37Cxx, 37Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37H20'">Bifurcation theory [See also 37Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Jxx'">Finite-dimensional Hamiltonian, Lagrangian, contact, and nonholonomic systems [See also 53Dxx, 70Fxx, 70Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J05'">General theory, relations with symplectic geometry and topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J10'">Symplectic mappings, fixed points</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J15'">Symmetries, invariants, invariant manifolds, momentum maps, reduction [See also 53D20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J20'">Bifurcation problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J25'">Stability problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J30'">Obstructions to integrability (nonintegrability criteria)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J35'">Completely integrable systems, topological structure of phase space, integration methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J40'">Perturbations, normal forms, small divisors, KAM theory, Arnol&#x27;d diffusion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J45'">Periodic, homoclinic and heteroclinic orbits; variational methods, degree-theoretic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J50'">Action-minimizing orbits and measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J55'">Contact systems [See also 53D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J60'">Nonholonomic dynamical systems [See also 70F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Kxx'">Infinite-dimensional Hamiltonian systems [See also 35Axx, 35Qxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K05'">Hamiltonian structures, symmetries, variational principles, conservation laws</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K10'">Completely integrable systems, integrability tests, bi-Hamiltonian structures, hierarchies (KdV, KP, Toda, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K15'">Integration of completely integrable systems by inverse spectral and scattering methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K20'">Relations with algebraic geometry, complex analysis, special functions [See also 14H70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K25'">Relations with differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K30'">Relations with infinite-dimensional Lie algebras and other algebraic structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K35'">Lie-B&#xC3;&#xA4;cklund and other transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K40'">Soliton theory, asymptotic behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K45'">Stability problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K50'">Bifurcation problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K55'">Perturbations, KAM for infinite-dimensional systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K60'">Lattice dynamics [See also 37L60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K65'">Hamiltonian systems on groups of diffeomorphisms and on manifolds of mappings and metrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Lxx'">Infinite-dimensional dissipative dynamical systems [See also 35Bxx, 35Qxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L05'">General theory, nonlinear semigroups, evolution equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L10'">Normal forms, center manifold theory, bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L15'">Stability problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L20'">Symmetries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L25'">Inertial manifolds and other invariant attracting sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L30'">Attractors and their dimensions, Lyapunov exponents</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L40'">Invariant measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L45'">Hyperbolicity; Lyapunov functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L50'">Noncompact semigroups; dispersive equations; perturbations of Hamiltonian systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L55'">Infinite-dimensional random dynamical systems; stochastic equations [See also 35R60, 60H10, 60H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L60'">Lattice dynamics [See also 37K60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L65'">Special approximation methods (nonlinear Galerkin, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Mxx'">Approximation methods and numerical treatment of dynamical systems [See also 65Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M05'">Simulation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M10'">Time series analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M15'">Symplectic integrators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M20'">Computational methods for bifurcation problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M25'">Computational methods for ergodic theory (approximation of invariant measures, computation of Lyapunov exponents, entropy)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Nxx'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N05'">Dynamical systems in classical and celestial mechanics [See mainly 70Fxx, 70Hxx, 70Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N10'">Dynamical systems in fluid mechanics, oceanography and meteorology [See mainly 76-XX, especially 76D05, 76F20, 86A05, 86A10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N15'">Dynamical systems in solid mechanics [See mainly 74Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N20'">Dynamical systems in other branches of physics (quantum mechanics, general relativity, laser physics)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N25'">Dynamical systems in biology [See mainly 92-XX, but also 91-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N30'">Dynamical systems in numerical analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N35'">Dynamical systems in control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N40'">Dynamical systems in optimization and economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37Pxx'">Arithmetic and non-Archimedean dynamical systems [See also 11S82, 37A45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P05'">Polynomial and rational maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P10'">Analytic and meromorphic maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P15'">Global ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P20'">Non-Archimedean local ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P25'">Finite ground fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P30'">Height functions; Green functions; invariant measures [See also 11G50, 14G40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P35'">Arithmetic properties of periodic points</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P40'">Non-Archimedean Fatou and Julia sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P45'">Families and moduli spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P50'">Dynamical systems on Berkovich spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P55'">Arithmetic dynamics on general algebraic varieties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='37P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-XX'">Difference and functional equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39Axx'">Difference equations {For dynamical systems, see 37-XX; for dynamic equations on time scales, see 34N05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A06'">Linear equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A10'">Difference equations, additive</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A12'">Discrete version of topics in analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A13'">Difference equations, scaling ($q$-differences) [See also 33Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A14'">Partial difference equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A20'">Multiplicative and other generalized difference equations, e.g. of Lyness type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A21'">Oscillation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A22'">Growth, boundedness, comparison of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A23'">Periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A24'">Almost periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A28'">Bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A30'">Stability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A33'">Complex (chaotic) behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A45'">Equations in the complex domain</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A50'">Stochastic difference equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A60'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A70'">Difference operators [See also 47B39]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39Bxx'">Functional equations and inequalities [See also 30D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B05'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B12'">Iteration theory, iterative and composite equations [See also 26A18, 30D05, 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B22'">Equations for real functions [See also 26A51, 26B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B32'">Equations for complex functions [See also 30D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B42'">Matrix and operator equations [See also 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B52'">Equations for functions with more general domains and/or ranges</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B55'">Orthogonal additivity and other conditional equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B62'">Functional inequalities, including subadditivity, convexity, etc. [See also 26A51, 26B25, 26Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B72'">Systems of functional equations and inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B82'">Stability, separation, extension, and related topics [See also 46A22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='39B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-XX'">Sequences, series, summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Axx'">Convergence and divergence of infinite limiting processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A05'">Convergence and divergence of series and sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A10'">Convergence and divergence of integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A15'">Convergence and divergence of continued fractions [See also 30B70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A20'">Convergence and divergence of infinite products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A25'">Approximation to limiting values (summation of series, etc.) {For the Euler-Maclaurin summation formula, see 65B15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A30'">Convergence and divergence of series and sequences of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A35'">Ideal and statistical convergence [See also 40G15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Bxx'">Multiple sequences and series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40B05'">Multiple sequences and series (should also be assigned at least one other classification number in this section)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Cxx'">General summability methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40C05'">Matrix methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40C10'">Integral methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40C15'">Function-theoretic methods (including power series methods and semicontinuous methods)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Dxx'">Direct theorems on summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D05'">General theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D09'">Structure of summability fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D10'">Tauberian constants and oscillation limits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D15'">Convergence factors and summability factors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D20'">Summability and bounded fields of methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D25'">Inclusion and equivalence theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Exx'">Inversion theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40E05'">Tauberian theorems, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40E10'">Growth estimates</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40E15'">Lacunary inversion theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40E20'">Tauberian constants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Fxx'">Absolute and strong summability (should also be assigned at least one other classification number in Section 40)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40F05'">Absolute and strong summability (should also be assigned at least one other classification number in Section 40)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Gxx'">Special methods of summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40G05'">Ces&#xC3;&#xA1;ro, Euler, N&#xC3;&#xB6;rlund and Hausdorff methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40G10'">Abel, Borel and power series methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40G15'">Summability methods using statistical convergence [See also 40A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Hxx'">Functional analytic methods in summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40H05'">Functional analytic methods in summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40Jxx'">Summability in abstract structures [See also 43A55, 46A35, 46B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40J05'">Summability in abstract structures [See also 43A55, 46A35, 46B15] (should also be assigned at least one other classification number in this section)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='40J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-XX'">Approximations and expansions {For all approximation theory in the complex domain, see 30E05 and 30E10; for all trigonometric approximation and interpolation, see 42A10 and 42A15; for numerical approximation, see 65Dxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41Axx'">Approximations and expansions {For all approximation theory in the complex domain, see 30E05 and 30E10; for all trigonometric approximation and interpolation, see 42A10 and 42A15; for numerical approximation, see 65Dxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A05'">Interpolation [See also 42A15 and 65D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A10'">Approximation by polynomials {For approximation by trigonometric polynomials, see 42A10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A15'">Spline approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A17'">Inequalities in approximation (Bernstein, Jackson, Nikol&#x27;ski&#xC4;&#xAD;-type inequalities)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A20'">Approximation by rational functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A21'">Pad&#xC3;&#xA9; approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A25'">Rate of convergence, degree of approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A27'">Inverse theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A28'">Simultaneous approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A29'">Approximation with constraints</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A30'">Approximation by other special function classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A35'">Approximation by operators (in particular, by integral operators)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A36'">Approximation by positive operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A40'">Saturation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A44'">Best constants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A45'">Approximation by arbitrary linear expressions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A46'">Approximation by arbitrary nonlinear expressions; widths and entropy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A50'">Best approximation, Chebyshev systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A52'">Uniqueness of best approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A55'">Approximate quadratures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A58'">Series expansions (e.g. Taylor, Lidstone series, but not Fourier series)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A60'">Asymptotic approximations, asymptotic expansions (steepest descent, etc.) [See also 30E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A63'">Multidimensional problems (should also be assigned at least one other classification number in this section)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A65'">Abstract approximation theory (approximation in normed linear spaces and other abstract spaces)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A80'">Remainders in approximation formulas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='41A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-XX'">Harmonic analysis on Euclidean spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42Axx'">Harmonic analysis in one variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A05'">Trigonometric polynomials, inequalities, extremal problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A10'">Trigonometric approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A15'">Trigonometric interpolation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A16'">Fourier coefficients, Fourier series of functions with special properties, special Fourier series {For automorphic theory, see mainly 11F30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A20'">Convergence and absolute convergence of Fourier and trigonometric series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A24'">Summability and absolute summability of Fourier and trigonometric series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A32'">Trigonometric series of special types (positive coefficients, monotonic coefficients, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A38'">Fourier and Fourier-Stieltjes transforms and other transforms of Fourier type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A45'">Multipliers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A50'">Conjugate functions, conjugate series, singular integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A55'">Lacunary series of trigonometric and other functions; Riesz products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A61'">Probabilistic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A63'">Uniqueness of trigonometric expansions, uniqueness of Fourier expansions, Riemann theory, localization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A65'">Completeness of sets of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A70'">Trigonometric moment problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A75'">Classical almost periodic functions, mean periodic functions [See also 43A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A82'">Positive definite functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A85'">Convolution, factorization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42Bxx'">Harmonic analysis in several variables {For automorphic theory, see mainly 11F30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B05'">Fourier series and coefficients</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B08'">Summability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B10'">Fourier and Fourier-Stieltjes transforms and other transforms of Fourier type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B15'">Multipliers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B20'">Singular and oscillatory integrals (Calder&#xC3;&#xB3;n-Zygmund, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B25'">Maximal functions, Littlewood-Paley theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B30'">$H^p$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B35'">Function spaces arising in harmonic analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B37'">Harmonic analysis and PDE [See also 35-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42Cxx'">Nontrigonometric harmonic analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C05'">Orthogonal functions and polynomials, general theory [See also 33C45, 33C50, 33D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C10'">Fourier series in special orthogonal functions (Legendre polynomials, Walsh functions, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C15'">General harmonic expansions, frames</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C20'">Other transformations of harmonic type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C25'">Uniqueness and localization for orthogonal series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C30'">Completeness of sets of functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C40'">Wavelets and other special systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='42C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-XX'">Abstract harmonic analysis {For other analysis on topological and Lie groups, see 22Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43Axx'">Abstract harmonic analysis {For other analysis on topological and Lie groups, see 22Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A05'">Measures on groups and semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A07'">Means on groups, semigroups, etc.; amenable groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A10'">Measure algebras on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A15'">$L^p$-spaces and other function spaces on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A17'">Analysis on ordered groups, $H^p$-theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A20'">$L^1$-algebras on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A22'">Homomorphisms and multipliers of function spaces on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A25'">Fourier and Fourier-Stieltjes transforms on locally compact and other abelian groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A30'">Fourier and Fourier-Stieltjes transforms on nonabelian groups and on semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A32'">Other transforms and operators of Fourier type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A35'">Positive definite functions on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A40'">Character groups and dual objects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A45'">Spectral synthesis on groups, semigroups, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A46'">Special sets (thin sets, Kronecker sets, Helson sets, Ditkin sets, Sidon sets, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A50'">Convergence of Fourier series and of inverse transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A55'">Summability methods on groups, semigroups, etc. [See also 40J05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A60'">Almost periodic functions on groups and semigroups and their generalizations (recurrent functions, distal functions, etc.); almost automorphic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A62'">Hypergroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A65'">Representations of groups, semigroups, etc. [See also 22A10, 22A20, 22Dxx, 22E45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A70'">Analysis on specific locally compact and other abelian groups [See also 11R56, 22B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A75'">Analysis on specific compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A77'">Analysis on general compact groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A80'">Analysis on other specific Lie groups [See also 22Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A85'">Analysis on homogeneous spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A90'">Spherical functions [See also 22E45, 22E46, 33C55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A95'">Categorical methods [See also 46Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='43A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-XX'">Integral transforms, operational calculus {For fractional derivatives and integrals, see 26A33. For Fourier transforms, see 42A38, 42B10. For integral transforms in distribution spaces, see 46F12. For numerical methods, see 65R10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44Axx'">Integral transforms, operational calculus {For fractional derivatives and integrals, see 26A33. For Fourier transforms, see 42A38, 42B10. For integral transforms in distribution spaces, see 46F12. For numerical methods, see 65R10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A05'">General transforms [See also 42A38]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A10'">Laplace transform</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A12'">Radon transform [See also 92C55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A15'">Special transforms (Legendre, Hilbert, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A20'">Transforms of special functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A30'">Multiple transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A35'">Convolution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A40'">Calculus of Mikusi{&#xC5;&#x81;}ski and other operational calculi</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A45'">Classical operational calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A55'">Discrete operational calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A60'">Moment problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='44A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-XX'">Integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Axx'">Linear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45A05'">Linear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Bxx'">Fredholm integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45B05'">Fredholm integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Cxx'">Eigenvalue problems [See also 34Lxx, 35Pxx, 45P05, 47A75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45C05'">Eigenvalue problems [See also 34Lxx, 35Pxx, 45P05, 47A75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Dxx'">Volterra integral equations [See also 34A12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45D05'">Volterra integral equations [See also 34A12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Exx'">Singular integral equations [See also 30E20, 30E25, 44A15, 44A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45E05'">Integral equations with kernels of Cauchy type [See also 35J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45E10'">Integral equations of the convolution type (Abel, Picard, Toeplitz and Wiener-Hopf type) [See also 47B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Fxx'">Systems of linear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45F05'">Systems of nonsingular linear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45F10'">Dual, triple, etc., integral and series equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45F15'">Systems of singular linear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Gxx'">Nonlinear integral equations [See also 47H30, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45G05'">Singular nonlinear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45G10'">Other nonlinear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45G15'">Systems of nonlinear integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Hxx'">Miscellaneous special kernels [See also 44A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45H05'">Miscellaneous special kernels [See also 44A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Jxx'">Integro-ordinary differential equations [See also 34K05, 34K30, 47G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45J05'">Integro-ordinary differential equations [See also 34K05, 34K30, 47G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Kxx'">Integro-partial differential equations [See also 34K30, 35R09, 35R10, 47G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45K05'">Integro-partial differential equations [See also 34K30, 35R09, 35R10, 47G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Lxx'">Theoretical approximation of solutions {For numerical analysis, see 65Rxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45L05'">Theoretical approximation of solutions {For numerical analysis, see 65Rxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Mxx'">Qualitative behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45M05'">Asymptotics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45M10'">Stability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45M15'">Periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45M20'">Positive solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Nxx'">Abstract integral equations, integral equations in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45N05'">Abstract integral equations, integral equations in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Pxx'">Integral operators [See also 47B38, 47G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45P05'">Integral operators [See also 47B38, 47G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Qxx'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Q05'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45Rxx'">Random integral equations [See also 60H20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45R05'">Random integral equations [See also 60H20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='45R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-XX'">Functional analysis {For manifolds modeled on topological linear spaces, see 57Nxx, 58Bxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Axx'">Topological linear spaces and related structures {For function spaces, see 46Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A03'">General theory of locally convex spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A04'">Locally convex Fr&#xC3;&#xA9;chet spaces and (DF)-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A08'">Barrelled spaces, bornological spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A11'">Spaces determined by compactness or summability properties (nuclear spaces, Schwartz spaces, Montel spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A13'">Spaces defined by inductive or projective limits (LB, LF, etc.) [See also 46M40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A16'">Not locally convex spaces (metrizable topological linear spaces, locally bounded spaces, quasi-Banach spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A17'">Bornologies and related structures; Mackey convergence, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A19'">Other ``topological'' linear spaces (convergence spaces, ranked spaces, spaces with a metric taking values in an ordered structure more general than ${\bf R}$, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A20'">Duality theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A22'">Theorems of Hahn-Banach type; extension and lifting of functionals and operators [See also 46M10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A25'">Reflexivity and semi-reflexivity [See also 46B10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A30'">Open mapping and closed graph theorems; completeness (including $B$-, $B_r$-completeness)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A32'">Spaces of linear operators; topological tensor products; approximation properties [See also 46B28, 46M05, 47L05, 47L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A35'">Summability and bases [See also 46B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A40'">Ordered topological linear spaces, vector lattices [See also 06F20, 46B40, 46B42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A45'">Sequence spaces (including K&#xC3;&#xB6;the sequence spaces) [See also 46B45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A50'">Compactness in topological linear spaces; angelic spaces, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A55'">Convex sets in topological linear spaces; Choquet theory [See also 52A07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A61'">Graded Fr&#xC3;&#xA9;chet spaces and tame operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A63'">Topological invariants ((DN), ($\Omega$), etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A70'">Saks spaces and their duals (strict topologies, mixed topologies, two-norm spaces, co-Saks spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A80'">Modular spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Bxx'">Normed linear spaces and Banach spaces; Banach lattices {For function spaces, see 46Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B03'">Isomorphic theory (including renorming) of Banach spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B04'">Isometric theory of Banach spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B06'">Asymptotic theory of Banach spaces [See also 52A23]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B07'">Local theory of Banach spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B08'">Ultraproduct techniques in Banach space theory [See also 46M07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B09'">Probabilistic methods in Banach space theory [See also 60Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B10'">Duality and reflexivity [See also 46A25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B15'">Summability and bases [See also 46A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B20'">Geometry and structure of normed linear spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B22'">Radon-Nikod{&#xC3;&#xBD;}m, Kre&#xC4;&#xAD;n-Milman and related properties [See also 46G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B25'">Classical Banach spaces in the general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B26'">Nonseparable Banach spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B28'">Spaces of operators; tensor products; approximation properties [See also 46A32, 46M05, 47L05, 47L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B40'">Ordered normed spaces [See also 46A40, 46B42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B42'">Banach lattices [See also 46A40, 46B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B45'">Banach sequence spaces [See also 46A45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B50'">Compactness in Banach (or normed) spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B70'">Interpolation between normed linear spaces [See also 46M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B80'">Nonlinear classification of Banach spaces; nonlinear quotients</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B85'">Embeddings of discrete metric spaces into Banach spaces; applications in topology and computer science [See also 05C12, 68Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Cxx'">Inner product spaces and their generalizations, Hilbert spaces {For function spaces, see 46Exx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C05'">Hilbert and pre-Hilbert spaces: geometry and topology (including spaces with semidefinite inner product)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C07'">Hilbert subspaces (= operator ranges); complementation (Aronszajn, de Branges, etc.) [See also 46B70, 46M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C15'">Characterizations of Hilbert spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C20'">Spaces with indefinite inner product (Kre&#xC4;&#xAD;n spaces, Pontryagin spaces, etc.) [See also 47B50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C50'">Generalizations of inner products (semi-inner products, partial inner products, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Exx'">Linear function spaces and their duals [See also 30H05, 32A38, 46F05] {For function algebras, see 46J10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E05'">Lattices of continuous, differentiable or analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E10'">Topological linear spaces of continuous, differentiable or analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E15'">Banach spaces of continuous, differentiable or analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E20'">Hilbert spaces of continuous, differentiable or analytic functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E22'">Hilbert spaces with reproducing kernels (= [proper] functional Hilbert spaces, including de Branges-Rovnyak and other structured spaces) [See also 47B32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E25'">Rings and algebras of continuous, differentiable or analytic functions {For Banach function algebras, see 46J10, 46J15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E27'">Spaces of measures [See also 28A33, 46Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E30'">Spaces of measurable functions ($L^p$-spaces, Orlicz spaces, K&#xC3;&#xB6;the function spaces, Lorentz spaces, rearrangement invariant spaces, ideal spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E35'">Sobolev spaces and other spaces of ``smooth'' functions, embedding theorems, trace theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E39'">Sobolev (and similar kinds of) spaces of functions of discrete variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E40'">Spaces of vector- and operator-valued functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E50'">Spaces of differentiable or holomorphic functions on infinite-dimensional spaces [See also 46G20, 46G25, 47H60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Fxx'">Distributions, generalized functions, distribution spaces [See also 46T30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F05'">Topological linear spaces of test functions, distributions and ultradistributions [See also 46E10, 46E35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F10'">Operations with distributions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F12'">Integral transforms in distribution spaces [See also 42-XX, 44-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F15'">Hyperfunctions, analytic functionals [See also 32A25, 32A45, 32C35, 58J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F20'">Distributions and ultradistributions as boundary values of analytic functions [See also 30D40, 30E25, 32A40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F25'">Distributions on infinite-dimensional spaces [See also 58C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F30'">Generalized functions for nonlinear analysis (Rosinger, Colombeau, nonstandard, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Gxx'">Measures, integration, derivative, holomorphy (all involving infinite-dimensional spaces) [See also 28-XX, 46Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G05'">Derivatives [See also 46T20, 58C20, 58C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G10'">Vector-valued measures and integration [See also 28Bxx, 46B22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G12'">Measures and integration on abstract linear spaces [See also 28C20, 46T12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G15'">Functional analytic lifting theory [See also 28A51]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G20'">Infinite-dimensional holomorphy [See also 32-XX, 46E50, 46T25, 58B12, 58C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G25'">(Spaces of) multilinear mappings, polynomials [See also 46E50, 46G20, 47H60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Hxx'">Topological algebras, normed rings and algebras, Banach algebras {For group algebras, convolution algebras and measure algebras, see 43A10, 43A20}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H05'">General theory of topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H10'">Ideals and subalgebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H15'">Representations of topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H20'">Structure, classification of topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H25'">Normed modules and Banach modules, topological modules (if not placed in 13-XX or 16-XX)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H30'">Functional calculus in topological algebras [See also 47A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H35'">Topological algebras of operators [See mainly 47Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H40'">Automatic continuity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H70'">Nonassociative topological algebras [See also 46K70, 46L70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Jxx'">Commutative Banach algebras and commutative topological algebras [See also 46E25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J05'">General theory of commutative topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J10'">Banach algebras of continuous functions, function algebras [See also 46E25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J15'">Banach algebras of differentiable or analytic functions, $H^p$-spaces [See also 30H10, 32A35, 32A37, 32A38, 42B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J20'">Ideals, maximal ideals, boundaries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J25'">Representations of commutative topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J30'">Subalgebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J40'">Structure, classification of commutative topological algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J45'">Radical Banach algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Kxx'">Topological (rings and) algebras with an involution [See also 16W10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K05'">General theory of topological algebras with involution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K10'">Representations of topological algebras with involution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K15'">Hilbert algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K50'">Nonselfadjoint (sub)algebras in algebras with involution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K70'">Nonassociative topological algebras with an involution [See also 46H70, 46L70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Lxx'">Selfadjoint operator algebras ($C^*$-algebras, von Neumann ($W^*$-) algebras, etc.) [See also 22D25, 47Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L05'">General theory of $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L06'">Tensor products of $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L07'">Operator spaces and completely bounded maps [See also 47L25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L08'">$C^*$-modules</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L09'">Free products of $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L10'">General theory of von Neumann algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L30'">States</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L35'">Classifications of $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L36'">Classification of factors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L37'">Subfactors and their classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L40'">Automorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L45'">Decomposition theory for $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L51'">Noncommutative measure and integration</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L52'">Noncommutative function spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L53'">Noncommutative probability and statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L54'">Free probability and free operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L55'">Noncommutative dynamical systems [See also 28Dxx, 37Kxx, 37Lxx, 54H20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L57'">Derivations, dissipations and positive semigroups in $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L60'">Applications of selfadjoint operator algebras to physics [See also 46N50, 46N55, 47L90, 81T05, 82B10, 82C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L65'">Quantizations, deformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L70'">Nonassociative selfadjoint operator algebras [See also 46H70, 46K70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L80'">$K$-theory and operator algebras (including cyclic theory) [See also 18F25, 19Kxx, 46M20, 55Rxx, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L85'">Noncommutative topology [See also 58B32, 58B34, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L87'">Noncommutative differential geometry [See also 58B32, 58B34, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L89'">Other ``noncommutative'' mathematics based on $C^*$-algebra theory [See also 58B32, 58B34, 58J22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Mxx'">Methods of category theory in functional analysis [See also 18-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M05'">Tensor products [See also 46A32, 46B28, 47A80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M07'">Ultraproducts [See also 46B08, 46S20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M10'">Projective and injective objects [See also 46A22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M15'">Categories, functors {For $K$-theory, EXT, etc., see 19K33, 46L80, 46M18, 46M20}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M18'">Homological methods (exact sequences, right inverses, lifting, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M20'">Methods of algebraic topology (cohomology, sheaf and bundle theory, etc.) [See also 14F05, 18Fxx, 19Kxx, 32Cxx, 32Lxx, 46L80, 46M15, 46M18, 55Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M35'">Abstract interpolation of topological vector spaces [See also 46B70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M40'">Inductive and projective limits [See also 46A13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Nxx'">Miscellaneous applications of functional analysis [See also 47Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N10'">Applications in optimization, convex analysis, mathematical programming, economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N20'">Applications to differential and integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N30'">Applications in probability theory and statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N40'">Applications in numerical analysis [See also 65Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N50'">Applications in quantum physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N55'">Applications in statistical physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N60'">Applications in biology and other sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Sxx'">Other (nonclassical) types of functional analysis [See also 47Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S10'">Functional analysis over fields other than ${\bf R}$ or ${\bf C}$ or the quaternions; non-Archimedean functional analysis [See also 12J25, 32P05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S20'">Nonstandard functional analysis [See also 03H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S30'">Constructive functional analysis [See also 03F60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S40'">Fuzzy functional analysis [See also 03E72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S50'">Functional analysis in probabilistic metric linear spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S60'">Functional analysis on superspaces (supermanifolds) or graded spaces [See also 58A50 and 58C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46Txx'">Nonlinear functional analysis [See also 47Hxx, 47Jxx, 58Cxx, 58Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T05'">Infinite-dimensional manifolds [See also 53Axx, 57N20, 58Bxx, 58Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T10'">Manifolds of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T12'">Measure (Gaussian, cylindrical, etc.) and integrals (Feynman, path, Fresnel, etc.) on manifolds [See also 28Cxx, 46G12, 60-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T20'">Continuous and differentiable maps [See also 46G05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T25'">Holomorphic maps [See also 46G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T30'">Distributions and generalized functions on nonlinear spaces [See also 46Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='46T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-XX'">Operator theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Axx'">General theory of linear operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A05'">General (adjoints, conjugates, products, inverses, domains, ranges, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A06'">Linear relations (multivalued linear operators)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A07'">Forms (bilinear, sesquilinear, multilinear)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A10'">Spectrum, resolvent</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A11'">Local spectral properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A12'">Numerical range, numerical radius</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A13'">Several-variable operator theory (spectral, Fredholm, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A15'">Invariant subspaces [See also 47A46]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A16'">Cyclic vectors, hypercyclic and chaotic operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A20'">Dilations, extensions, compressions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A25'">Spectral sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A30'">Norms (inequalities, more than one norm, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A35'">Ergodic theory [See also 28Dxx, 37Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A40'">Scattering theory [See also 34L25, 35P25, 37K15, 58J50, 81Uxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A45'">Canonical models for contractions and nonselfadjoint operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A46'">Chains (nests) of projections or of invariant subspaces, integrals along chains, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A48'">Operator colligations (= nodes), vessels, linear systems, characteristic functions, realizations, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A50'">Equations and inequalities involving linear operators, with vector unknowns</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A52'">Ill-posed problems, regularization [See also 35R25, 47J06, 65F22, 65J20, 65L08, 65M30, 65R30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A53'">(Semi-) Fredholm operators; index theories [See also 58B15, 58J20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A55'">Perturbation theory [See also 47H14, 58J37, 70H09, 81Q15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A56'">Functions whose values are linear operators (operator and matrix valued functions, etc., including analytic and meromorphic ones)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A57'">Operator methods in interpolation, moment and extension problems [See also 30E05, 42A70, 42A82, 44A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A58'">Operator approximation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A60'">Functional calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A62'">Equations involving linear operators, with operator unknowns</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A63'">Operator inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A64'">Operator means, shorted operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A65'">Structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A66'">Quasitriangular and nonquasitriangular, quasidiagonal and nonquasidiagonal operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A67'">Representation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A68'">Factorization theory (including Wiener-Hopf and spectral factorizations)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A70'">(Generalized) eigenfunction expansions; rigged Hilbert spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A75'">Eigenvalue problems [See also 47J10, 49R05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A80'">Tensor products of operators [See also 46M05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Bxx'">Special classes of linear operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B06'">Riesz operators; eigenvalue distributions; approximation numbers, $s$-numbers, Kolmogorov numbers, entropy numbers, etc. of operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B07'">Operators defined by compactness properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B10'">Operators belonging to operator ideals (nuclear, $p$-summing, in the Schatten-von Neumann classes, etc.) [See also 47L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B15'">Hermitian and normal operators (spectral measures, functional calculus, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B20'">Subnormal operators, hyponormal operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B25'">Symmetric and selfadjoint operators (unbounded)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B32'">Operators in reproducing-kernel Hilbert spaces (including de Branges, de Branges-Rovnyak, and other structured spaces) [See also 46E22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B33'">Composition operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B34'">Kernel operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B35'">Toeplitz operators, Hankel operators, Wiener-Hopf operators [See also 45P05, 47G10 for other integral operators; see also 32A25, 32M15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B36'">Jacobi (tridiagonal) operators (matrices) and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B37'">Operators on special spaces (weighted shifts, operators on sequence spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B38'">Operators on function spaces (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B39'">Difference operators [See also 39A70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B40'">Spectral operators, decomposable operators, well-bounded operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B44'">Accretive operators, dissipative operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B47'">Commutators, derivations, elementary operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B48'">Operators on Banach algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B49'">Transformers, preservers (operators on spaces of operators)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B50'">Operators on spaces with an indefinite metric [See also 46C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B60'">Operators on ordered spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B65'">Positive operators and order-bounded operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B80'">Random operators [See also 47H40, 60H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Cxx'">Individual linear operators as elements of algebraic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47C05'">Operators in algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47C10'">Operators in ${}^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47C15'">Operators in $C^*$- or von Neumann algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Dxx'">Groups and semigroups of linear operators, their generalizations and applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D03'">Groups and semigroups of linear operators {For nonlinear operators, see 47H20; see also 20M20}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D06'">One-parameter semigroups and linear evolution equations [See also 34G10, 34K30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D07'">Markov semigroups and applications to diffusion processes {For Markov processes, see 60Jxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D08'">Schr&#xC3;&#xB6;dinger and Feynman-Kac semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D09'">Operator sine and cosine functions and higher-order Cauchy problems [See also 34G10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D60'">$C$-semigroups, regularized semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D62'">Integrated semigroups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Exx'">Ordinary differential operators [See also 34Bxx, 34Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47E05'">Ordinary differential operators [See also 34Bxx, 34Lxx] (should also be assigned at least one other classification number in section 47)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Fxx'">Partial differential operators [See also 35Pxx, 58Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47F05'">Partial differential operators [See also 35Pxx, 58Jxx] (should also be assigned at least one other classification number in section 47)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Gxx'">Integral, integro-differential, and pseudodifferential operators [See also 58Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47G10'">Integral operators [See also 45P05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47G20'">Integro-differential operators [See also 34K30, 35R09, 35R10, 45Jxx, 45Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47G30'">Pseudodifferential operators [See also 35Sxx, 58Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47G40'">Potential operators [See also 31-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Hxx'">Nonlinear operators and their properties {For global and geometric aspects, see 49J53, 58-XX, especially 58Cxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H04'">Set-valued operators [See also 28B20, 54C60, 58C06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H05'">Monotone operators and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H06'">Accretive operators, dissipative operators, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H07'">Monotone and positive operators on ordered Banach spaces or other ordered topological vector spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H08'">Measures of noncompactness and condensing mappings, $K$-set contractions, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H09'">Contraction-type mappings, nonexpansive mappings, $A$-proper mappings, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H10'">Fixed-point theorems [See also 37C25, 54H25, 55M20, 58C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H11'">Degree theory [See also 55M25, 58C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H14'">Perturbations of nonlinear operators [See also 47A55, 58J37, 70H09, 70K60, 81Q15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H20'">Semigroups of nonlinear operators [See also 37L05, 47J35, 54H15, 58D07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H25'">Nonlinear ergodic theorems [See also 28Dxx, 37Axx, 47A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H30'">Particular nonlinear operators (superposition, Hammerstein, Nemytski&#xC4;&#xAD;, Uryson, etc.) [See also 45Gxx, 45P05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H40'">Random operators [See also 47B80, 60H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H60'">Multilinear and polynomial operators [See also 46G25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Jxx'">Equations and inequalities involving nonlinear operators [See also 46Txx] {For global and geometric aspects, see 58-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J05'">Equations involving nonlinear operators (general) [See also 47H10, 47J25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J06'">Nonlinear ill-posed problems [See also 35R25, 47A52, 65F22, 65J20, 65L08, 65M30, 65R30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J07'">Abstract inverse mapping and implicit function theorems [See also 46T20 and 58C15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J10'">Nonlinear spectral theory, nonlinear eigenvalue problems [See also 49R05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J15'">Abstract bifurcation theory [See also 34C23, 37Gxx, 58E07, 58E09]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J20'">Variational and other types of inequalities involving nonlinear operators (general) [See also 49J40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J22'">Variational and other types of inclusions [See also 34A60, 49J21, 49K21]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J25'">Iterative procedures [See also 65J15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J30'">Variational methods [See also 58Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J35'">Nonlinear evolution equations [See also 34G20, 35K90, 35L90, 35Qxx, 35R20, 37Kxx, 37Lxx, 47H20, 58D25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J40'">Equations with hysteresis operators [See also 34C55, 74N30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Lxx'">Linear spaces and algebras of operators [See also 46Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L05'">Linear spaces of operators [See also 46A32 and 46B28]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L07'">Convex sets and cones of operators [See also 46A55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L10'">Algebras of operators on Banach spaces and other topological linear spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L15'">Operator algebras with symbol structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L20'">Operator ideals [See also 47B10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L22'">Ideals of polynomials and of multilinear mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L25'">Operator spaces (= matricially normed spaces) [See also 46L07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L30'">Abstract operator algebras on Hilbert spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L35'">Nest algebras, CSL algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L40'">Limit algebras, subalgebras of $C^*$-algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L45'">Dual algebras; weakly closed singly generated operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L50'">Dual spaces of operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L55'">Representations of (nonselfadjoint) operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L60'">Algebras of unbounded operators; partial algebras of operators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L65'">Crossed product algebras (analytic crossed products)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L70'">Nonassociative nonselfadjoint operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L75'">Other nonselfadjoint operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L80'">Algebras of specific types of operators (Toeplitz, integral, pseudodifferential, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L90'">Applications of operator algebras to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Nxx'">Miscellaneous applications of operator theory [See also 46Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N10'">Applications in optimization, convex analysis, mathematical programming, economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N20'">Applications to differential and integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N30'">Applications in probability theory and statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N40'">Applications in numerical analysis [See also 65Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N50'">Applications in the physical sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N60'">Applications in chemistry and life sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N70'">Applications in systems theory, circuits, and control theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47Sxx'">Other (nonclassical) types of operator theory [See also 46Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S10'">Operator theory over fields other than ${\bf R}$, ${\bf C}$ or the quaternions; non-Archimedean operator theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S20'">Nonstandard operator theory [See also 03H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S30'">Constructive operator theory [See also 03F60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S40'">Fuzzy operator theory [See also 03E72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S50'">Operator theory in probabilistic metric linear spaces [See also 54E70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='47S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-XX'">Calculus of variations and optimal control; optimization [See also 34H05, 34K35, 65Kxx, 90Cxx, 93-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Jxx'">Existence theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J05'">Free problems in one independent variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J10'">Free problems in two or more independent variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J15'">Optimal control problems involving ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J20'">Optimal control problems involving partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J21'">Optimal control problems involving relations other than differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J27'">Problems in abstract spaces [See also 90C48, 93C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J30'">Optimal solutions belonging to restricted classes (Lipschitz controls, bang-bang controls, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J35'">Minimax problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J40'">Variational methods including variational inequalities [See also 47J20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J45'">Methods involving semicontinuity and convergence; relaxation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J50'">Fr&#xC3;&#xA9;chet and Gateaux differentiability [See also 46G05, 58C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J52'">Nonsmooth analysis [See also 46G05, 58C50, 90C56]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J53'">Set-valued and variational analysis [See also 28B20, 47H04, 54C60, 58C06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J55'">Problems involving randomness [See also 93E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Kxx'">Optimality conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K05'">Free problems in one independent variable</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K10'">Free problems in two or more independent variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K15'">Problems involving ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K20'">Problems involving partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K21'">Problems involving relations other than differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K27'">Problems in abstract spaces [See also 90C48, 93C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K30'">Optimal solutions belonging to restricted classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K35'">Minimax problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K40'">Sensitivity, stability, well-posedness [See also 90C31]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K45'">Problems involving randomness [See also 93E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Lxx'">Hamilton-Jacobi theories, including dynamic programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49L20'">Dynamic programming method</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49L25'">Viscosity solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Mxx'">Numerical methods [See also 90Cxx, 65Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M05'">Methods based on necessary conditions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M15'">Newton-type methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M20'">Methods of relaxation type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M25'">Discrete approximations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M27'">Decomposition methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M29'">Methods involving duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M30'">Other methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M37'">Methods of nonlinear programming type [See also 90C30, 65Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Nxx'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N05'">Linear optimal control problems [See also 93C05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N10'">Linear-quadratic problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N15'">Duality theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N20'">Periodic optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N25'">Impulsive optimal control problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N30'">Problems with incomplete information [See also 93C41]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N35'">Optimal feedback synthesis [See also 93B52]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N45'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N60'">Regularity of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N70'">Differential games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N75'">Pursuit and evasion games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N90'">Applications of optimal control and differential games [See also 90C90, 93C95]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Qxx'">Manifolds [See also 58Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q05'">Minimal surfaces [See also 53A10, 58E12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q10'">Optimization of shapes other than minimal surfaces [See also 90C90]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q12'">Sensitivity analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q15'">Geometric measure and integration theory, integral and normal currents [See also 28A75, 32C30, 58A25, 58C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q20'">Variational problems in a geometric measure-theoretic setting</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Rxx'">Variational methods for eigenvalues of operators [See also 47A75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49R05'">Variational methods for eigenvalues of operators [See also 47A75] (should also be assigned at least one other classification number in Section 49)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49Sxx'">Variational principles of physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49S05'">Variational principles of physics (should also be assigned at least one other classification number in section 49)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='49S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-XX'">Geometry {For algebraic geometry, see 14-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Axx'">Linear incidence geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A05'">General theory and projective geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A10'">Homomorphism, automorphism and dualities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A15'">Structures with parallelism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A20'">Configuration theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A25'">Algebraization [See also 12Kxx, 20N05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A30'">Desarguesian and Pappian geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A35'">Non-Desarguesian affine and projective planes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A40'">Translation planes and spreads</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A45'">Incidence structures imbeddable into projective geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A50'">Polar geometry, symplectic spaces, orthogonal spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Bxx'">Nonlinear incidence geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B10'">M&#xC3;&#xB6;bius geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B15'">Laguerre geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B20'">Minkowski geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B25'">Lie geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Cxx'">Ring geometry (Hjelmslev, Barbilian, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51C05'">Ring geometry (Hjelmslev, Barbilian, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Dxx'">Geometric closure systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D05'">Abstract (Maeda) geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D10'">Abstract geometries with exchange axiom</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D15'">Abstract geometries with parallelism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D20'">Combinatorial geometries [See also 05B25, 05B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D25'">Lattices of subspaces [See also 05B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D30'">Continuous geometries and related topics [See also 06Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Exx'">Finite geometry and special incidence structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E05'">General block designs [See also 05B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E10'">Steiner systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E12'">Generalized quadrangles, generalized polygons</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E14'">Finite partial geometries (general), nets, partial spreads</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E15'">Affine and projective planes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E20'">Combinatorial structures in finite projective spaces [See also 05Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E21'">Blocking sets, ovals, $k$-arcs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E22'">Linear codes and caps in Galois spaces [See also 94B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E23'">Spreads and packing problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E24'">Buildings and the geometry of diagrams</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E25'">Other finite nonlinear geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E26'">Other finite linear geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E30'">Other finite incidence structures [See also 05B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Fxx'">Metric geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F05'">Absolute planes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F10'">Absolute spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F15'">Reflection groups, reflection geometries [See also 20H10, 20H15; for Coxeter groups, see 20F55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F20'">Congruence and orthogonality [See also 20H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F25'">Orthogonal and unitary groups [See also 20H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Gxx'">Ordered geometries (ordered incidence structures, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51G05'">Ordered geometries (ordered incidence structures, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Hxx'">Topological geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H10'">Topological linear incidence structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H15'">Topological nonlinear incidence structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H20'">Topological geometries on manifolds [See also 57-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H25'">Geometries with differentiable structure [See also 53Cxx, 53C70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H30'">Geometries with algebraic manifold structure [See also 14-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Jxx'">Incidence groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51J05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51J10'">Projective incidence groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51J15'">Kinematic spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51J20'">Representation by near-fields and near-algebras [See also 12K05, 16Y30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Kxx'">Distance geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51K05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51K10'">Synthetic differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Lxx'">Geometric order structures [See also 53C75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51L05'">Geometry of orders of nondifferentiable curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51L10'">Directly differentiable curves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51L15'">$n$-vertex theorems via direct methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51L20'">Geometry of orders of surfaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Mxx'">Real and complex geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M04'">Elementary problems in Euclidean geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M05'">Euclidean geometries (general) and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M09'">Elementary problems in hyperbolic and elliptic geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M10'">Hyperbolic and elliptic geometries (general) and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M15'">Geometric constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M16'">Inequalities and extremum problems {For convex problems, see 52A40}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M20'">Polyhedra and polytopes; regular figures, division of spaces [See also 51F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M25'">Length, area and volume [See also 26B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M30'">Line geometries and their generalizations [See also 53A25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M35'">Synthetic treatment of fundamental manifolds in projective geometries (Grassmannians, Veronesians and their generalizations) [See also 14M15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Nxx'">Analytic and descriptive geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N05'">Descriptive geometry [See also 65D17, 68U07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N10'">Affine analytic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N15'">Projective analytic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N20'">Euclidean analytic geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N25'">Analytic geometry with other transformation groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N30'">Geometry of classical groups [See also 20Gxx, 14L35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N35'">Questions of classical algebraic geometry [See also 14Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51Pxx'">Geometry and physics (should also be assigned at least one other classification number from Sections 70--86)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51P05'">Geometry and physics (should also be assigned at least one other classification number from Sections 70--86)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='51P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-XX'">Convex and discrete geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52Axx'">General convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A01'">Axiomatic and generalized convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A05'">Convex sets without dimension restrictions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A07'">Convex sets in topological vector spaces [See also 46A55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A10'">Convex sets in $2$ dimensions (including convex curves) [See also 53A04]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A15'">Convex sets in $3$ dimensions (including convex surfaces) [See also 53A05, 53C45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A20'">Convex sets in $n$ dimensions (including convex hypersurfaces) [See also 53A07, 53C45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A21'">Finite-dimensional Banach spaces (including special norms, zonoids, etc.) [See also 46Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A22'">Random convex sets and integral geometry [See also 53C65, 60D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A23'">Asymptotic theory of convex bodies [See also 46B06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A27'">Approximation by convex sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A30'">Variants of convex sets (star-shaped, ($m, n$)-convex, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A35'">Helly-type theorems and geometric transversal theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A37'">Other problems of combinatorial convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A38'">Length, area, volume [See also 26B15, 28A75, 49Q20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A39'">Mixed volumes and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A40'">Inequalities and extremum problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A41'">Convex functions and convex programs [See also 26B25, 90C25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A55'">Spherical and hyperbolic convexity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52Bxx'">Polytopes and polyhedra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B05'">Combinatorial properties (number of faces, shortest paths, etc.) [See also 05Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B10'">Three-dimensional polytopes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B11'">$n$-dimensional polytopes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B12'">Special polytopes (linear programming, centrally symmetric, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B15'">Symmetry properties of polytopes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B20'">Lattice polytopes (including relations with commutative algebra and algebraic geometry) [See also 06A11, 13F20, 13Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B22'">Shellability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B35'">Gale and other diagrams</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B40'">Matroids (realizations in the context of convex polytopes, convexity in combinatorial structures, etc.) [See also 05B35, 52Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B45'">Dissections and valuations (Hilbert's third problem, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B55'">Computational aspects related to convexity {For computational geometry and algorithms, see 68Q25, 68U05; for numerical algorithms, see 65Yxx} [See also 68Uxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B60'">Isoperimetric problems for polytopes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B70'">Polyhedral manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52Cxx'">Discrete geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C05'">Lattices and convex bodies in $2$ dimensions [See also 11H06, 11H31, 11P21]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C07'">Lattices and convex bodies in $n$ dimensions [See also 11H06, 11H31, 11P21]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C10'">Erd&#xC3;&#x85;s problems and related topics of discrete geometry [See also 11Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C15'">Packing and covering in $2$ dimensions [See also 05B40, 11H31]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C17'">Packing and covering in $n$ dimensions [See also 05B40, 11H31]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C20'">Tilings in $2$ dimensions [See also 05B45, 51M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C22'">Tilings in $n$ dimensions [See also 05B45, 51M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C23'">Quasicrystals, aperiodic tilings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C25'">Rigidity and flexibility of structures [See also 70B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C26'">Circle packings and discrete conformal geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C30'">Planar arrangements of lines and pseudolines</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C35'">Arrangements of points, flats, hyperplanes [See also 32S22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C40'">Oriented matroids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C45'">Combinatorial complexity of geometric structures [See also 68U05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='52C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-XX'">Differential geometry {For differential topology, see 57Rxx. For foundational questions of differentiable manifolds, see 58Axx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Axx'">Classical differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A04'">Curves in Euclidean space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A05'">Surfaces in Euclidean space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A07'">Higher-dimensional and -codimensional surfaces in Euclidean $n$-space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A10'">Minimal surfaces, surfaces with prescribed mean curvature [See also 49Q05, 49Q10, 53C42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A15'">Affine differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A17'">Kinematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A20'">Projective differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A25'">Differential line geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A30'">Conformal differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A35'">Non-Euclidean differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A40'">Other special differential geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A45'">Vector and tensor analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A55'">Differential invariants (local theory), geometric objects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A60'">Geometry of webs [See also 14C21, 20N05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Bxx'">Local differential geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B05'">Linear and affine connections</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B10'">Projective connections</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B15'">Other connections</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B20'">Local Riemannian geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B21'">Methods of Riemannian geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B25'">Local submanifolds [See also 53C40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B30'">Lorentz metrics, indefinite metrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B35'">Hermitian and K&#xC3;&#xA4;hlerian structures [See also 32Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B40'">Finsler spaces and generalizations (areal metrics)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B50'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Cxx'">Global differential geometry [See also 51H25, 58-XX; for related bundle theory, see 55Rxx, 57Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C05'">Connections, general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C07'">Special connections and metrics on vector bundles (Hermite-Einstein-Yang-Mills) [See also 32Q20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C08'">Gerbes, differential characters: differential geometric aspects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C10'">$G$-structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C12'">Foliations (differential geometric aspects) [See also 57R30, 57R32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C15'">General geometric structures on manifolds (almost complex, almost product structures, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C17'">Sub-Riemannian geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C20'">Global Riemannian geometry, including pinching [See also 31C12, 58B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C21'">Methods of Riemannian geometry, including PDE methods; curvature restrictions [See also 58J60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C22'">Geodesics [See also 58E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C23'">Global geometric and topological methods (&#xC3;&#xA1; la Gromov); differential geometric analysis on metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C24'">Rigidity results</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C25'">Special Riemannian manifolds (Einstein, Sasakian, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C26'">Hyper-K&#xC3;&#xA4;hler and quaternionic K&#xC3;&#xA4;hler geometry, ``special'' geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C27'">Spin and Spin${}^c$ geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C28'">Twistor methods [See also 32L25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C29'">Issues of holonomy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C30'">Homogeneous manifolds [See also 14M15, 14M17, 32M10, 57T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C35'">Symmetric spaces [See also 32M15, 57T15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C38'">Calibrations and calibrated geometries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C40'">Global submanifolds [See also 53B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C42'">Immersions (minimal, prescribed curvature, tight, etc.) [See also 49Q05, 49Q10, 53A10, 57R40, 57R42]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C43'">Differential geometric aspects of harmonic maps [See also 58E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C44'">Geometric evolution equations (mean curvature flow, Ricci flow, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C45'">Global surface theory (convex surfaces &#xC3;&#xA1; la A. D. Aleksandrov)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C50'">Lorentz manifolds, manifolds with indefinite metrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C55'">Hermitian and K&#xC3;&#xA4;hlerian manifolds [See also 32Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C56'">Other complex differential geometry [See also 32Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C60'">Finsler spaces and generalizations (areal metrics) [See also 58B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C65'">Integral geometry [See also 52A22, 60D05]; differential forms, currents, etc. [See mainly 58Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C70'">Direct methods ($G$-spaces of Busemann, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C75'">Geometric orders, order geometry [See also 51Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C80'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Dxx'">Symplectic geometry, contact geometry [See also 37Jxx, 70Gxx, 70Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D05'">Symplectic manifolds, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D10'">Contact manifolds, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D12'">Lagrangian submanifolds; Maslov index</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D15'">Almost contact and almost symplectic manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D17'">Poisson manifolds; Poisson groupoids and algebroids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D18'">Generalized geometries (&#xC3;&#xA1; la Hitchin)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D20'">Momentum maps; symplectic reduction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D22'">Canonical transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D25'">Geodesic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D30'">Symplectic structures of moduli spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D35'">Global theory of symplectic and contact manifolds [See also 57Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D37'">Mirror symmetry, symplectic aspects; homological mirror symmetry; Fukaya category [See also 14J33]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D40'">Floer homology and cohomology, symplectic aspects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D42'">Symplectic field theory; contact homology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D45'">Gromov-Witten invariants, quantum cohomology, Frobenius manifolds [See also 14N35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D50'">Geometric quantization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D55'">Deformation quantization, star products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Zxx'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Z05'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='53Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-XX'">General topology {For the topology of manifolds of all dimensions, see 57Nxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Axx'">Generalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A05'">Topological spaces and generalizations (closure spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A10'">Several topologies on one set (change of topology, comparison of topologies, lattices of topologies)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A15'">Syntopogeneous structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A20'">Convergence in general topology (sequences, filters, limits, convergence spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A25'">Cardinality properties (cardinal functions and inequalities, discrete subsets) [See also 03Exx] {For ultrafilters, see 54D80}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A35'">Consistency and independence results [See also 03E35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A40'">Fuzzy topology [See also 03E72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Bxx'">Basic constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B05'">Subspaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B10'">Product spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B15'">Quotient spaces, decompositions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B17'">Adjunction spaces and similar constructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B20'">Hyperspaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B30'">Categorical methods [See also 18B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B35'">Spectra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B40'">Presheaves and sheaves [See also 18F20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Cxx'">Maps and general types of spaces defined by maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C05'">Continuous maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C08'">Weak and generalized continuity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C10'">Special maps on topological spaces (open, closed, perfect, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C15'">Retraction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C20'">Extension of maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C25'">Embedding</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C30'">Real-valued functions [See also 26-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C35'">Function spaces [See also 46Exx, 58D15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C40'">Algebraic properties of function spaces [See also 46J10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C45'">$C$- and $C^*$-embedding</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C50'">Special sets defined by functions [See also 26A21]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C55'">Absolute neighborhood extensor, absolute extensor, absolute neighborhood retract (ANR), absolute retract spaces (general properties) [See also 55M15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C56'">Shape theory [See also 55P55, 57N25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C60'">Set-valued maps [See also 26E25, 28B20, 47H04, 58C06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C65'">Selections [See also 28B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C70'">Entropy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Dxx'">Fairly general properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D05'">Connected and locally connected spaces (general aspects)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D10'">Lower separation axioms ($T_0$--$T_3$, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D15'">Higher separation axioms (completely regular, normal, perfectly or collectionwise normal, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D20'">Noncompact covering properties (paracompact, Lindel&#xC3;&#xB6;f, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D25'">``$P$-minimal'' and ``$P$-closed'' spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D30'">Compactness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D35'">Extensions of spaces (compactifications, supercompactifications, completions, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D40'">Remainders</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D45'">Local compactness, $\sigma$-compactness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D50'">$k$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D55'">Sequential spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D60'">Realcompactness and realcompactification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D65'">Separability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D70'">Base properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D80'">Special constructions of spaces (spaces of ultrafilters, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Exx'">Spaces with richer structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E05'">Proximity structures and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E15'">Uniform structures and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E17'">Nearness spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E18'">$p$-spaces, $M$-spaces, $\sigma$-spaces, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E20'">Stratifiable spaces, cosmic spaces, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E25'">Semimetric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E30'">Moore spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E35'">Metric spaces, metrizability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E40'">Special maps on metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E45'">Compact (locally compact) metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E50'">Complete metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E52'">Baire category, Baire spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E55'">Bitopologies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E70'">Probabilistic metric spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Fxx'">Special properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F05'">Linearly ordered topological spaces, generalized ordered spaces, and partially ordered spaces [See also 06B30, 06F30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F15'">Continua and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F35'">Higher-dimensional local connectedness [See also 55Mxx, 55Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F45'">Dimension theory [See also 55M10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F50'">Spaces of dimension $\leq 1$; curves, dendrites [See also 26A03]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F55'">Unicoherence, multicoherence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F65'">Topological characterizations of particular spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Gxx'">Peculiar spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G05'">Extremally disconnected spaces, $F$-spaces, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G10'">$P$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G12'">Scattered spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G15'">Pathological spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G20'">Counterexamples</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Hxx'">Connections with other structures, applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H05'">Descriptive set theory (topological aspects of Borel, analytic, projective, etc. sets) [See also 03E15, 26A21, 28A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H10'">Topological representations of algebraic systems [See also 22-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H11'">Topological groups [See also 22A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H12'">Topological lattices, etc. [See also 06B30, 06F30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H13'">Topological fields, rings, etc. [See also 12Jxx] {For algebraic aspects, see 13Jxx, 16W80}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H15'">Transformation groups and semigroups [See also 20M20, 22-XX, 57Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H20'">Topological dynamics [See also 28Dxx, 37Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H25'">Fixed-point and coincidence theorems [See also 47H10, 55M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54Jxx'">Nonstandard topology [See also 03H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54J05'">Nonstandard topology [See also 03H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='54J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-XX'">Algebraic topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Mxx'">Classical topics {For the topology of Euclidean spaces and manifolds, see 57Nxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M05'">Duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M10'">Dimension theory [See also 54F45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M15'">Absolute neighborhood retracts [See also 54C55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M20'">Fixed points and coincidences [See also 54H25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M25'">Degree, winding number</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M30'">Ljusternik-Schnirelman (Lyusternik-Shnirel&#x27;man) category of a space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M35'">Finite groups of transformations (including Smith theory) [See also 57S17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Nxx'">Homology and cohomology theories [See also 57Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N05'">&#xC4;&#x8C;ech types</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N07'">Steenrod-Sitnikov homologies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N10'">Singular theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N15'">$K$-theory [See also 19Lxx] {For algebraic $K$-theory, see 18F25, 19-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N20'">Generalized (extraordinary) homology and cohomology theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N22'">Bordism and cobordism theories, formal group laws [See also 14L05, 19L41, 57R75, 57R77, 57R85, 57R90]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N25'">Homology with local coefficients, equivariant cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N30'">Sheaf cohomology [See also 18F20, 32C35, 32L10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N32'">Orbifold cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N33'">Intersection homology and cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N34'">Elliptic cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N35'">Other homology theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N40'">Axioms for homology theory and uniqueness theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N45'">Products and intersections</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N91'">Equivariant homology and cohomology [See also 19L47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Pxx'">Homotopy theory {For simple homotopy type, see 57Q10}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P05'">Homotopy extension properties, cofibrations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P10'">Homotopy equivalences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P15'">Classification of homotopy type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P20'">Eilenberg-Mac Lane spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P25'">Spanier-Whitehead duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P30'">Eckmann-Hilton duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P35'">Loop spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P40'">Suspensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P42'">Stable homotopy theory, spectra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P43'">Spectra with additional structure ($E_\infty$, $A_\infty$, ring spectra, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P45'">$H$-spaces and duals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P47'">Infinite loop spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P48'">Loop space machines, operads [See also 18D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P50'">String topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P55'">Shape theory [See also 54C56, 55Q07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P57'">Proper homotopy theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P60'">Localization and completion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P62'">Rational homotopy theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P65'">Homotopy functors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P91'">Equivariant homotopy theory [See also 19L47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P92'">Relations between equivariant and nonequivariant homotopy theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Qxx'">Homotopy groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q05'">Homotopy groups, general; sets of homotopy classes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q07'">Shape groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q10'">Stable homotopy groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q15'">Whitehead products and generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q20'">Homotopy groups of wedges, joins, and simple spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q25'">Hopf invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q35'">Operations in homotopy groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q40'">Homotopy groups of spheres</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q45'">Stable homotopy of spheres</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q50'">$J$-morphism [See also 19L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q51'">$v_n$-periodicity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q52'">Homotopy groups of special spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q55'">Cohomotopy groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q70'">Homotopy groups of special types [See also 55N05, 55N07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q91'">Equivariant homotopy groups [See also 19L47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Rxx'">Fiber spaces and bundles [See also 18F15, 32Lxx, 46M20, 57R20, 57R22, 57R25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R05'">Fiber spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R10'">Fiber bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R12'">Transfer</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R15'">Classification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R20'">Spectral sequences and homology of fiber spaces [See also 55Txx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R25'">Sphere bundles and vector bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R35'">Classifying spaces of groups and $H$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R37'">Maps between classifying spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R40'">Homology of classifying spaces, characteristic classes [See also 57Txx, 57R20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R45'">Homology and homotopy of $B{\rm O}$ and $B{\rm U}$; Bott periodicity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R50'">Stable classes of vector space bundles, $K$-theory [See also 19Lxx] {For algebraic $K$-theory, see 18F25, 19-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R55'">Fiberings with singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R60'">Microbundles and block bundles [See also 57N55, 57Q50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R65'">Generalizations of fiber spaces and bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R70'">Fibrewise topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R80'">Discriminantal varieties, configuration spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R91'">Equivariant fiber spaces and bundles [See also 19L47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Sxx'">Operations and obstructions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S05'">Primary cohomology operations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S10'">Steenrod algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S12'">Dyer-Lashof operations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S15'">Symmetric products, cyclic products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S20'">Secondary and higher cohomology operations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S25'">$K$-theory operations and generalized cohomology operations [See also 19D55, 19Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S30'">Massey products</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S35'">Obstruction theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S36'">Extension and compression of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S37'">Classification of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S40'">Sectioning fiber spaces and bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S45'">Postnikov systems, $k$-invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S91'">Equivariant operations and obstructions [See also 19L47]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Txx'">Spectral sequences [See also 18G40, 55R20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T05'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T10'">Serre spectral sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T15'">Adams spectral sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T20'">Eilenberg-Moore spectral sequences [See also 57T35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T25'">Generalized cohomology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55Uxx'">Applied homological algebra and category theory [See also 18Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U05'">Abstract complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U10'">Simplicial sets and complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U15'">Chain complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U20'">Universal coefficient theorems, Bockstein operator</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U25'">Homology of a product, K&#xC3;&#xBC;nneth formula</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U30'">Duality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U35'">Abstract and axiomatic homotopy theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U40'">Topological categories, foundations of homotopy theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='55U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-XX'">Manifolds and cell complexes {For complex manifolds, see 32Qxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Mxx'">Low-dimensional topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M05'">Fundamental group, presentations, free differential calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M07'">Topological methods in group theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M10'">Covering spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M12'">Special coverings, e.g. branched</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M15'">Relations with graph theory [See also 05Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M20'">Two-dimensional complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M25'">Knots and links in $S^3$ {For higher dimensions, see 57Q45}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M27'">Invariants of knots and 3-manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M30'">Wild knots and surfaces, etc., wild embeddings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M35'">Dehn's lemma, sphere theorem, loop theorem, asphericity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M40'">Characterizations of $E^3$ and $S^3$ (Poincar&#xC3;&#xA9; conjecture) [See also 57N12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M50'">Geometric structures on low-dimensional manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M60'">Group actions in low dimensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Nxx'">Topological manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N05'">Topology of $E^2$, $2$-manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N10'">Topology of general $3$-manifolds [See also 57Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N12'">Topology of $E^3$ and $S^3$ [See also 57M40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N13'">Topology of $E^4$, $4$-manifolds [See also 14Jxx, 32Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N15'">Topology of $E^n$, $n$-manifolds ($4 \less n \less \infty$)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N16'">Geometric structures on manifolds [See also 57M50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N17'">Topology of topological vector spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N20'">Topology of infinite-dimensional manifolds [See also 58Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N25'">Shapes [See also 54C56, 55P55, 55Q07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N30'">Engulfing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N35'">Embeddings and immersions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N37'">Isotopy and pseudo-isotopy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N40'">Neighborhoods of submanifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N45'">Flatness and tameness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N50'">$S^{n-1}\subset E^n$, Schoenflies problem</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N55'">Microbundles and block bundles [See also 55R60, 57Q50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N60'">Cellularity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N65'">Algebraic topology of manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N70'">Cobordism and concordance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N75'">General position and transversality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N80'">Stratifications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Pxx'">Generalized manifolds [See also 18F15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57P05'">Local properties of generalized manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57P10'">Poincar&#xC3;&#xA9; duality spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Qxx'">PL-topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q05'">General topology of complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q10'">Simple homotopy type, Whitehead torsion, Reidemeister-Franz torsion, etc. [See also 19B28]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q12'">Wall finiteness obstruction for CW-complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q15'">Triangulating manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q20'">Cobordism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q25'">Comparison of PL-structures: classification, Hauptvermutung</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q30'">Engulfing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q35'">Embeddings and immersions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q37'">Isotopy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q40'">Regular neighborhoods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q45'">Knots and links (in high dimensions) {For the low-dimensional case, see 57M25}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q50'">Microbundles and block bundles [See also 55R60, 57N55]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q55'">Approximations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q60'">Cobordism and concordance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q65'">General position and transversality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q91'">Equivariant PL-topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Rxx'">Differential topology {For foundational questions of differentiable manifolds, see 58Axx; for infinite-dimensional manifolds, see 58Bxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R05'">Triangulating</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R10'">Smoothing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R12'">Smooth approximations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R15'">Specialized structures on manifolds (spin manifolds, framed manifolds, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R17'">Symplectic and contact topology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R18'">Topology and geometry of orbifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R19'">Algebraic topology on manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R20'">Characteristic classes and numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R22'">Topology of vector bundles and fiber bundles [See also 55Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R25'">Vector fields, frame fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R27'">Controllability of vector fields on $C^\infty$ and real-analytic manifolds [See also 49Qxx, 37C10, 93B05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R30'">Foliations; geometric theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R32'">Classifying spaces for foliations; Gelfand-Fuks cohomology [See also 58H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R35'">Differentiable mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R40'">Embeddings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R42'">Immersions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R45'">Singularities of differentiable mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R50'">Diffeomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R52'">Isotopy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R55'">Differentiable structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R56'">Topological quantum field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R57'">Applications of global analysis to structures on manifolds, Donaldson and Seiberg-Witten invariants [See also 58-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R58'">Floer homology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R60'">Homotopy spheres, Poincar&#xC3;&#xA9; conjecture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R65'">Surgery and handlebodies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R67'">Surgery obstructions, Wall groups [See also 19J25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R70'">Critical points and critical submanifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R75'">${\rm O}$- and ${\rm SO}$-cobordism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R77'">Complex cobordism (${\rm U}$- and ${\rm SU}$-cobordism) [See also 55N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R80'">$h$- and $s$-cobordism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R85'">Equivariant cobordism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R90'">Other types of cobordism [See also 55N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R91'">Equivariant algebraic topology of manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R95'">Realizing cycles by submanifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Sxx'">Topological transformation groups [See also 20F34, 22-XX, 37-XX, 54H15, 58D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S05'">Topological properties of groups of homeomorphisms or diffeomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S10'">Compact groups of homeomorphisms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S15'">Compact Lie groups of differentiable transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S17'">Finite transformation groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S20'">Noncompact Lie groups of transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S25'">Groups acting on specific manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S30'">Discontinuous groups of transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57Txx'">Homology and homotopy of topological groups and related structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T05'">Hopf algebras [See also 16T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T10'">Homology and cohomology of Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T15'">Homology and cohomology of homogeneous spaces of Lie groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T20'">Homotopy groups of topological groups and homogeneous spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T25'">Homology and cohomology of $H$-spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T30'">Bar and cobar constructions [See also 18G55, 55Uxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T35'">Applications of Eilenberg-Moore spectral sequences [See also 55R20, 55T20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='57T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-XX'">Global analysis, analysis on manifolds [See also 32Cxx, 32Fxx, 32Wxx, 46-XX, 47Hxx, 53Cxx] {For geometric integration theory, see 49Q15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Axx'">General theory of differentiable manifolds [See also 32Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A03'">Topos-theoretic approach to differentiable manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A05'">Differentiable manifolds, foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A07'">Real-analytic and Nash manifolds [See also 14P20, 32C07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A10'">Differential forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A12'">de Rham theory [See also 14Fxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A14'">Hodge theory [See also 14C30, 14Fxx, 32J25, 32S35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A15'">Exterior differential systems (Cartan theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A17'">Pfaffian systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A20'">Jets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A25'">Currents [See also 32C30, 53C65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A30'">Vector distributions (subbundles of the tangent bundles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A32'">Natural bundles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A35'">Stratified sets [See also 32S60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A40'">Differential spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A50'">Supermanifolds and graded manifolds [See also 14A22, 32C11]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Bxx'">Infinite-dimensional manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B05'">Homotopy and topological questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B10'">Differentiability questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B12'">Questions of holomorphy [See also 32-XX, 46G20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B15'">Fredholm structures [See also 47A53]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B20'">Riemannian, Finsler and other geometric structures [See also 53C20, 53C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B25'">Group structures and generalizations on infinite-dimensional manifolds [See also 22E65, 58D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B32'">Geometry of quantum groups</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B34'">Noncommutative geometry (&#xC3;&#xA1; la Connes)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Cxx'">Calculus on manifolds; nonlinear operators [See also 46Txx, 47Hxx, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C05'">Real-valued functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C06'">Set valued and function-space valued mappings [See also 47H04, 54C60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C07'">Continuity properties of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C10'">Holomorphic maps [See also 32-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C15'">Implicit function theorems; global Newton methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C20'">Differentiation theory (Gateaux, Fr&#xC3;&#xA9;chet, etc.) [See also 26Exx, 46G05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C25'">Differentiable maps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C30'">Fixed point theorems on manifolds [See also 47H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C35'">Integration on manifolds; measures on manifolds [See also 28Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C40'">Spectral theory; eigenvalue problems [See also 47J10, 58E07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C50'">Analysis on supermanifolds or graded manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Dxx'">Spaces and manifolds of mappings (including nonlinear versions of 46Exx) [See also 46Txx, 53Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D05'">Groups of diffeomorphisms and homeomorphisms as manifolds [See also 22E65, 57S05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D07'">Groups and semigroups of nonlinear operators [See also 17B65, 47H20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D10'">Spaces of imbeddings and immersions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D15'">Manifolds of mappings [See also 46T10, 54C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D17'">Manifolds of metrics (esp. Riemannian)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D19'">Group actions and symmetry properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D20'">Measures (Gaussian, cylindrical, etc.) on manifolds of maps [See also 28Cxx, 46T12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D25'">Equations in function spaces; evolution equations [See also 34Gxx, 35K90, 35L90, 35R15, 37Lxx, 47Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D27'">Moduli problems for differential geometric structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D29'">Moduli problems for topological structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D30'">Applications (in quantum mechanics (Feynman path integrals), relativity, fluid dynamics, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Exx'">Variational problems in infinite-dimensional spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E05'">Abstract critical point theory (Morse theory, Ljusternik-Schnirelman (Lyusternik-Shnirel&#x27;man) theory, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E07'">Abstract bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E09'">Group-invariant bifurcation theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E10'">Applications to the theory of geodesics (problems in one independent variable)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E11'">Critical metrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E12'">Applications to minimal surfaces (problems in two independent variables) [See also 49Q05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E15'">Application to extremal problems in several variables; Yang-Mills functionals [See also 81T13], etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E17'">Pareto optimality, etc., applications to economics [See also 90C29]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E20'">Harmonic maps [See also 53C43], etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E25'">Applications to control theory [See also 49-XX, 93-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E30'">Variational principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E35'">Variational inequalities (global problems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E40'">Group actions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E50'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Hxx'">Pseudogroups, differentiable groupoids and general structures on manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58H05'">Pseudogroups and differentiable groupoids [See also 22A22, 22E65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58H10'">Cohomology of classifying spaces for pseudogroup structures (Spencer, Gelfand-Fuks, etc.) [See also 57R32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58H15'">Deformations of structures [See also 32Gxx, 58J10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Jxx'">Partial differential equations on manifolds; differential operators [See also 32Wxx, 35-XX, 53Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J05'">Elliptic equations on manifolds, general theory [See also 35-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J10'">Differential complexes [See also 35Nxx]; elliptic complexes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J15'">Relations with hyperfunctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J20'">Index theory and related fixed point theorems [See also 19K56, 46L80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J22'">Exotic index theories [See also 19K56, 46L05, 46L10, 46L80, 46M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J26'">Elliptic genera</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J28'">Eta-invariants, Chern-Simons invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J30'">Spectral flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J32'">Boundary value problems on manifolds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J35'">Heat and other parabolic equation methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J37'">Perturbations; asymptotics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J40'">Pseudodifferential and Fourier integral operators on manifolds [See also 35Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J42'">Noncommutative global analysis, noncommutative residues</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J45'">Hyperbolic equations [See also 35Lxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J47'">Propagation of singularities; initial value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J50'">Spectral problems; spectral geometry; scattering theory [See also 35Pxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J51'">Relations between spectral theory and ergodic theory, e.g. quantum unique ergodicity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J52'">Determinants and determinant bundles, analytic torsion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J53'">Isospectrality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J55'">Bifurcation [See also 35B32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J60'">Relations with special manifold structures (Riemannian, Finsler, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J65'">Diffusion processes and stochastic analysis on manifolds [See also 35R60, 60H10, 60J60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J70'">Invariance and symmetry properties [See also 35A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J72'">Correspondences and other transformation methods (e.g. Lie-B&#xC3;&#xA4;cklund) [See also 35A22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J90'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Kxx'">Theory of singularities and catastrophe theory [See also 32Sxx, 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K05'">Critical points of functions and mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K10'">Monodromy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K15'">Topological properties of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K20'">Algebraic and analytic properties of mappings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K25'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K30'">Global theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K35'">Catastrophe theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K40'">Classification; finite determinacy of map germs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K45'">Singularities of vector fields, topological aspects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K50'">Normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K55'">Asymptotic behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K60'">Deformation of singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K65'">Topological invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K70'">Symmetries, equivariance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Zxx'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Z05'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='58Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-XX'">Probability theory and stochastic processes {For additional applications, see 11Kxx, 62-XX, 90-XX, 91-XX, 92-XX, 93-XX, 94-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60-08'">Computational methods (not classified at a more specific level) [See also 65C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Axx'">Foundations of probability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60A05'">Axioms; other general questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60A10'">Probabilistic measure theory {For ergodic theory, see 28Dxx and 60Fxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60A86'">Fuzzy probability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Bxx'">Probability theory on algebraic and topological structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B05'">Probability measures on topological spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B10'">Convergence of probability measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B11'">Probability theory on linear topological spaces [See also 28C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B12'">Limit theorems for vector-valued random variables (infinite-dimensional case)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B15'">Probability measures on groups or semigroups, Fourier transforms, factorization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B20'">Random matrices (probabilistic aspects; for algebraic aspects see 15B52)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Cxx'">Combinatorial probability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60C05'">Combinatorial probability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Dxx'">Geometric probability and stochastic geometry [See also 52A22, 53C65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60D05'">Geometric probability and stochastic geometry [See also 52A22, 53C65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Exx'">Distribution theory [See also 62Exx, 62Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60E05'">Distributions: general theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60E07'">Infinitely divisible distributions; stable distributions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60E10'">Characteristic functions; other transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60E15'">Inequalities; stochastic orderings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Fxx'">Limit theorems [See also 28Dxx, 60B12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F05'">Central limit and other weak theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F10'">Large deviations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F15'">Strong theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F17'">Functional limit theorems; invariance principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F20'">Zero-one laws</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F25'">$L^p$-limit theorems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Gxx'">Stochastic processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G05'">Foundations of stochastic processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G07'">General theory of processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G09'">Exchangeability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G10'">Stationary processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G12'">General second-order processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G15'">Gaussian processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G17'">Sample path properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G18'">Self-similar processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G20'">Generalized stochastic processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G22'">Fractional processes, including fractional Brownian motion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G25'">Prediction theory [See also 62M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G30'">Continuity and singularity of induced measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G35'">Signal detection and filtering [See also 62M20, 93E10, 93E11, 94Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G40'">Stopping times; optimal stopping problems; gambling theory [See also 62L15, 91A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G42'">Martingales with discrete parameter</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G44'">Martingales with continuous parameter</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G46'">Martingales and classical analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G48'">Generalizations of martingales</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G50'">Sums of independent random variables; random walks</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G51'">Processes with independent increments; L&#xC3;&#xA9;vy processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G52'">Stable processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G55'">Point processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G57'">Random measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G60'">Random fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G70'">Extreme value theory; extremal processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Hxx'">Stochastic analysis [See also 58J65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H05'">Stochastic integrals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H07'">Stochastic calculus of variations and the Malliavin calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H10'">Stochastic ordinary differential equations [See also 34F05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H15'">Stochastic partial differential equations [See also 35R60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H20'">Stochastic integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H25'">Random operators and equations [See also 47B80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H30'">Applications of stochastic analysis (to PDE, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H35'">Computational methods for stochastic equations [See also 65C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H40'">White noise theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Jxx'">Markov processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J05'">Discrete-time Markov processes on general state spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J10'">Markov chains (discrete-time Markov processes on discrete state spaces)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J20'">Applications of Markov chains and discrete-time Markov processes on general state spaces (social mobility, learning theory, industrial processes, etc.) [See also 90B30, 91D10, 91D35, 91E40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J22'">Computational methods in Markov chains [See also 65C40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J25'">Continuous-time Markov processes on general state spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J27'">Continuous-time Markov processes on discrete state spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J28'">Applications of continuous-time Markov processes on discrete state spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J35'">Transition functions, generators and resolvents [See also 47D03, 47D07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J40'">Right processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J45'">Probabilistic potential theory [See also 31Cxx, 31D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J50'">Boundary theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J55'">Local time and additive functionals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J57'">Multiplicative functionals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J60'">Diffusion processes [See also 58J65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J65'">Brownian motion [See also 58J65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J67'">Stochastic (Schramm-)Loewner evolution (SLE)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J68'">Superprocesses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J70'">Applications of Brownian motions and diffusion theory (population genetics, absorption problems, etc.) [See also 92Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J75'">Jump processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J80'">Branching processes (Galton-Watson, birth-and-death, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J85'">Applications of branching processes [See also 92Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60Kxx'">Special processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K05'">Renewal theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K10'">Applications (reliability, demand theory, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K15'">Markov renewal processes, semi-Markov processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K20'">Applications of Markov renewal processes (reliability, queueing networks, etc.) [See also 90Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K25'">Queueing theory [See also 68M20, 90B22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K30'">Applications (congestion, allocation, storage, traffic, etc.) [See also 90Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K35'">Interacting random processes; statistical mechanics type models; percolation theory [See also 82B43, 82C43]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K37'">Processes in random environments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K40'">Other physical applications of random processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='60K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-XX'">Statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-07'">Data analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62-09'">Graphical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Axx'">Foundational and philosophical topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62A01'">Foundations and philosophical topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62A86'">Fuzzy analysis in statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Bxx'">Sufficiency and information</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62B05'">Sufficient statistics and fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62B10'">Information-theoretic topics [See also 94A17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62B15'">Theory of statistical experiments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62B86'">Fuzziness, sufficiency, and information</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Cxx'">Decision theory [See also 90B50, 91B06; for game theory, see 91A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C05'">General considerations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C07'">Complete class results</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C10'">Bayesian problems; characterization of Bayes procedures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C12'">Empirical decision procedures; empirical Bayes procedures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C15'">Admissibility</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C20'">Minimax procedures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C25'">Compound decision problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C86'">Decision theory and fuzziness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Dxx'">Sampling theory, sample surveys</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62D05'">Sampling theory, sample surveys</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Exx'">Distribution theory [See also 60Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E10'">Characterization and structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E15'">Exact distribution theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E17'">Approximations to distributions (nonasymptotic)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E20'">Asymptotic distribution theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E86'">Fuzziness in connection with the topics on distributions in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Fxx'">Parametric inference</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F03'">Hypothesis testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F05'">Asymptotic properties of tests</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F07'">Ranking and selection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F10'">Point estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F12'">Asymptotic properties of estimators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F15'">Bayesian inference</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F25'">Tolerance and confidence regions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F30'">Inference under constraints</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F35'">Robustness and adaptive procedures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F40'">Bootstrap, jackknife and other resampling methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F86'">Parametric inference and fuzziness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Gxx'">Nonparametric inference</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G05'">Estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G07'">Density estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G08'">Nonparametric regression</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G09'">Resampling methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G10'">Hypothesis testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G15'">Tolerance and confidence regions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G20'">Asymptotic properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G30'">Order statistics; empirical distribution functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G32'">Statistics of extreme values; tail inference</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G35'">Robustness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G86'">Nonparametric inference and fuzziness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Hxx'">Multivariate analysis [See also 60Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H05'">Characterization and structure theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H10'">Distribution of statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H11'">Directional data; spatial statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H12'">Estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H15'">Hypothesis testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H17'">Contingency tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H20'">Measures of association (correlation, canonical correlation, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H25'">Factor analysis and principal components; correspondence analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H30'">Classification and discrimination; cluster analysis [See also 68T10, 91C20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H35'">Image analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H86'">Multivariate analysis and fuzziness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Jxx'">Linear inference, regression</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J02'">General nonlinear regression</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J05'">Linear regression</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J07'">Ridge regression; shrinkage estimators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J10'">Analysis of variance and covariance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J12'">Generalized linear models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J15'">Paired and multiple comparisons</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J20'">Diagnostics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J86'">Fuzziness, and linear inference and regression</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Kxx'">Design of experiments [See also 05Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K05'">Optimal designs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K10'">Block designs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K15'">Factorial designs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K20'">Response surface designs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K25'">Robust parameter designs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K86'">Fuzziness and design of experiments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Lxx'">Sequential methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L05'">Sequential design</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L10'">Sequential analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L12'">Sequential estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L15'">Optimal stopping [See also 60G40, 91A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L20'">Stochastic approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L86'">Fuzziness and sequential methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Mxx'">Inference from stochastic processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M02'">Markov processes: hypothesis testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M05'">Markov processes: estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M07'">Non-Markovian processes: hypothesis testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M09'">Non-Markovian processes: estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M10'">Time series, auto-correlation, regression, etc. [See also 91B84]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M15'">Spectral analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M20'">Prediction [See also 60G25]; filtering [See also 60G35, 93E10, 93E11]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M30'">Spatial processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M40'">Random fields; image analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M45'">Neural nets and related approaches</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M86'">Inference from stochastic processes and fuzziness</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Nxx'">Survival analysis and censored data</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N01'">Censored data models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N02'">Estimation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N03'">Testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N05'">Reliability and life testing [See also 90B25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N86'">Fuzziness, and survival analysis and censored data</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Pxx'">Applications [See also 90-XX, 91-XX, 92-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P05'">Applications to actuarial sciences and financial mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P10'">Applications to biology and medical sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P12'">Applications to environmental and related topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P15'">Applications to psychology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P20'">Applications to economics [See also 91Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P25'">Applications to social sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P30'">Applications in engineering and industry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P35'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Qxx'">Statistical tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Q05'">Statistical tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='62Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-XX'">Numerical analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-05'">Experimental papers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Axx'">Tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65A05'">Tables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Bxx'">Acceleration of convergence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65B05'">Extrapolation to the limit, deferred corrections</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65B10'">Summation of series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65B15'">Euler-Maclaurin formula</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Cxx'">Probabilistic methods, simulation and stochastic differential equations {For theoretical aspects, see 68U20 and 60H35}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C05'">Monte Carlo methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C10'">Random number generation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C20'">Models, numerical methods [See also 68U20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C30'">Stochastic differential and integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C35'">Stochastic particle methods [See also 82C80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C40'">Computational Markov chains</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C50'">Other computational problems in probability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C60'">Computational problems in statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Dxx'">Numerical approximation and computational geometry (primarily algorithms) {For theory, see 41-XX and 68Uxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D05'">Interpolation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D07'">Splines</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D10'">Smoothing, curve fitting</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D15'">Algorithms for functional approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D17'">Computer aided design (modeling of curves and surfaces) [See also 68U07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D18'">Computer graphics, image analysis, and computational geometry [See also 51N05, 68U05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D19'">Computational issues in computer and robotic vision</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D20'">Computation of special functions, construction of tables [See also 33F05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D25'">Numerical differentiation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D30'">Numerical integration</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D32'">Quadrature and cubature formulas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Exx'">Numerical methods in complex analysis (potential theory, etc.) {For numerical methods in conformal mapping, see also 30C30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65E05'">Numerical methods in complex analysis (potential theory, etc.) {For numerical methods in conformal mapping, see also 30C30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Fxx'">Numerical linear algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F05'">Direct methods for linear systems and matrix inversion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F08'">Preconditioners for iterative methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F10'">Iterative methods for linear systems [See also 65N22]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F15'">Eigenvalues, eigenvectors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F18'">Inverse eigenvalue problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F20'">Overdetermined systems, pseudoinverses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F22'">Ill-posedness, regularization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F25'">Orthogonalization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F30'">Other matrix algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F35'">Matrix norms, conditioning, scaling [See also 15A12, 15A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F40'">Determinants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F50'">Sparse matrices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F60'">Matrix exponential and similar matrix functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Gxx'">Error analysis and interval analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65G20'">Algorithms with automatic result verification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65G30'">Interval and finite arithmetic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65G40'">General methods in interval analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65G50'">Roundoff error</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Hxx'">Nonlinear algebraic or transcendental equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H04'">Roots of polynomial equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H05'">Single equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H10'">Systems of equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H17'">Eigenvalues, eigenvectors [See also 47Hxx, 47Jxx, 58C40, 58E07, 90C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H20'">Global methods, including homotopy approaches [See also 58C30, 90C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Jxx'">Numerical analysis in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J05'">General theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J08'">Abstract evolution equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J10'">Equations with linear operators (do not use 65Fxx)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J15'">Equations with nonlinear operators (do not use 65Hxx)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J20'">Improperly posed problems; regularization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J22'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Kxx'">Mathematical programming, optimization and variational techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65K05'">Mathematical programming methods [See also 90Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65K10'">Optimization and variational techniques [See also 49Mxx, 93B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65K15'">Numerical methods for variational inequalities and related problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Lxx'">Ordinary differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L03'">Functional-differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L04'">Stiff equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L05'">Initial value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L06'">Multistep, Runge-Kutta and extrapolation methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L07'">Numerical investigation of stability of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L08'">Improperly posed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L09'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L10'">Boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L11'">Singularly perturbed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L12'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L15'">Eigenvalue problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L20'">Stability and convergence of numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L50'">Mesh generation and refinement</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L60'">Finite elements, Rayleigh-Ritz, Galerkin and collocation methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L70'">Error bounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L80'">Methods for differential-algebraic equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Mxx'">Partial differential equations, initial value and time-dependent initial-boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M06'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M08'">Finite volume methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M12'">Stability and convergence of numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M15'">Error bounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M20'">Method of lines</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M22'">Solution of discretized equations [See also 65Fxx, 65Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M25'">Method of characteristics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M30'">Improperly posed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M32'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M38'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M50'">Mesh generation and refinement</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M55'">Multigrid methods; domain decomposition</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M60'">Finite elements, Rayleigh-Ritz and Galerkin methods, finite methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M70'">Spectral, collocation and related methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M75'">Probabilistic methods, particle methods, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M80'">Fundamental solutions, Green's function methods, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M85'">Fictitious domain methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Nxx'">Partial differential equations, boundary value problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N06'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N08'">Finite volume methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N12'">Stability and convergence of numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N15'">Error bounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N20'">Ill-posed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N21'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N22'">Solution of discretized equations [See also 65Fxx, 65Hxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N25'">Eigenvalue problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N30'">Finite elements, Rayleigh-Ritz and Galerkin methods, finite methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N35'">Spectral, collocation and related methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N38'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N40'">Method of lines</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N45'">Method of contraction of the boundary</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N50'">Mesh generation and refinement</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N55'">Multigrid methods; domain decomposition</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N75'">Probabilistic methods, particle methods, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N80'">Fundamental solutions, Green's function methods, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N85'">Fictitious domain methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Pxx'">Numerical problems in dynamical systems [See also 37Mxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65P10'">Hamiltonian systems including symplectic integrators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65P20'">Numerical chaos</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65P30'">Bifurcation problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65P40'">Nonlinear stabilities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Qxx'">Difference and functional equations, recurrence relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Q10'">Difference equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Q20'">Functional equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Q30'">Recurrence relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Rxx'">Integral equations, integral transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65R10'">Integral transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65R20'">Integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65R30'">Improperly posed problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65R32'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Sxx'">Graphical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65S05'">Graphical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Txx'">Numerical methods in Fourier analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65T40'">Trigonometric approximation and interpolation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65T50'">Discrete and fast Fourier transforms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65T60'">Wavelets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Yxx'">Computer aspects of numerical algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y04'">Algorithms for computer arithmetic, etc. [See also 68M07]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y05'">Parallel computation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y10'">Algorithms for specific classes of architectures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y15'">Packaged methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y20'">Complexity and performance of numerical algorithms [See also 68Q25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Y99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Zxx'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Z05'">Applications to physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='65Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-XX'">Computer science {For papers involving machine computations and programs in a specific mathematical area, see Section--04 in that area}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Mxx'">Computer system organization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M07'">Mathematical problems of computer architecture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M10'">Network design and communication [See also 68R10, 90B18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M11'">Internet topics [See also 68U35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M12'">Network protocols</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M14'">Distributed systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M15'">Reliability, testing and fault tolerance [See also 94C12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M20'">Performance evaluation; queueing; scheduling [See also 60K25, 90Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Nxx'">Software</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N15'">Programming languages</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N17'">Logic programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N18'">Functional programming and lambda calculus [See also 03B40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N19'">Other programming techniques (object-oriented, sequential, concurrent, automatic, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N20'">Compilers and interpreters</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N25'">Operating systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N30'">Mathematical aspects of software engineering (specification, verification, metrics, requirements, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Pxx'">Theory of data</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P05'">Data structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P10'">Searching and sorting</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P15'">Database theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P20'">Information storage and retrieval</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P25'">Data encryption [See also 94A60, 81P94]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P30'">Coding and information theory (compaction, compression, models of communication, encoding schemes, etc.) [See also 94Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Qxx'">Theory of computing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q05'">Models of computation (Turing machines, etc.) [See also 03D10, 68Q12, 81P68]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q10'">Modes of computation (nondeterministic, parallel, interactive, probabilistic, etc.) [See also 68Q85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q12'">Quantum algorithms and complexity [See also 68Q05, 81P68]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q15'">Complexity classes (hierarchies, relations among complexity classes, etc.) [See also 03D15, 68Q17, 68Q19]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q17'">Computational difficulty of problems (lower bounds, completeness, difficulty of approximation, etc.) [See also 68Q15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q19'">Descriptive complexity and finite models [See also 03C13]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q25'">Analysis of algorithms and problem complexity [See also 68W40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q30'">Algorithmic information theory (Kolmogorov complexity, etc.) [See also 03D32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q32'">Computational learning theory [See also 68T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q42'">Grammars and rewriting systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q45'">Formal languages and automata [See also 03D05, 68Q70, 94A45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q55'">Semantics [See also 03B70, 06B35, 18C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q60'">Specification and verification (program logics, model checking, etc.) [See also 03B70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q65'">Abstract data types; algebraic specification [See also 18C50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q70'">Algebraic theory of languages and automata [See also 18B20, 20M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q80'">Cellular automata [See also 37B15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q85'">Models and methods for concurrent and distributed computing (process algebras, bisimulation, transition nets, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q87'">Probability in computer science (algorithm analysis, random structures, phase transitions, etc.) [See also 68W20, 68W40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Rxx'">Discrete mathematics in relation to computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68R01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68R05'">Combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68R10'">Graph theory (including graph drawing) [See also 05Cxx, 90B10, 90B35, 90C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68R15'">Combinatorics on words</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Txx'">Artificial intelligence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T05'">Learning and adaptive systems [See also 68Q32, 91E40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T10'">Pattern recognition, speech recognition {For cluster analysis, see 62H30}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T15'">Theorem proving (deduction, resolution, etc.) [See also 03B35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T20'">Problem solving (heuristics, search strategies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T27'">Logic in artificial intelligence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T30'">Knowledge representation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T35'">Languages and software systems (knowledge-based systems, expert systems, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T37'">Reasoning under uncertainty</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T40'">Robotics [See also 93C85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T42'">Agent technology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T45'">Machine vision and scene understanding</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T50'">Natural language processing [See also 03B65]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Uxx'">Computing methodologies and applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U05'">Computer graphics; computational geometry [See also 65D18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U07'">Computer-aided design [See also 65D17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U10'">Image processing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U15'">Text processing; mathematical typography</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U20'">Simulation [See also 65Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U35'">Information systems (hypertext navigation, interfaces, decision support, etc.) [See also 68M11]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68Wxx'">Algorithms {For numerical algorithms, see 65-XX; for combinatorics and graph theory, see 05C85, 68Rxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W01'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W05'">Nonnumerical algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W10'">Parallel algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W15'">Distributed algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W20'">Randomized algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W25'">Approximation algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W27'">Online algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W30'">Symbolic computation and algebraic computation [See also 11Yxx, 12Y05, 13Pxx, 14Qxx, 16Z05, 17-08, 33F10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W32'">Algorithms on strings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W35'">VLSI algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W40'">Analysis of algorithms [See also 68Q25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='68W99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-XX'">Mechanics of particles and systems {For relativistic mechanics, see 83A05 and 83C10; for statistical mechanics, see 82-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Axx'">Axiomatics, foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70A05'">Axiomatics, foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Bxx'">Kinematics [See also 53A17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70B05'">Kinematics of a particle</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70B10'">Kinematics of a rigid body</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70B15'">Mechanisms, robots [See also 68T40, 70Q05, 93C85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Cxx'">Statics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70C20'">Statics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Exx'">Dynamics of a rigid body and of multibody systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E05'">Motion of the gyroscope</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E15'">Free motion of a rigid body [See also 70M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E17'">Motion of a rigid body with a fixed point</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E18'">Motion of a rigid body in contact with a solid surface [See also 70F25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E20'">Perturbation methods for rigid body dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E40'">Integrable cases of motion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E45'">Higher-dimensional generalizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E50'">Stability problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E55'">Dynamics of multibody systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E60'">Robot dynamics and control [See also 68T40, 70Q05, 93C85]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Fxx'">Dynamics of a system of particles, including celestial mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F05'">Two-body problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F07'">Three-body problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F10'">$n$-body problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F15'">Celestial mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F16'">Collisions in celestial mechanics, regularization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F17'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F20'">Holonomic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F25'">Nonholonomic systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F35'">Collision of rigid or pseudo-rigid bodies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F40'">Problems with friction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F45'">Infinite particle systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Gxx'">General models, approaches, and methods [See also 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G10'">Generalized coordinates; event, impulse-energy, configuration, state, or phase space</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G40'">Topological and differential-topological methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G45'">Differential-geometric methods (tensors, connections, symplectic, Poisson, contact, Riemannian, nonholonomic, etc.) [See also 53Cxx, 53Dxx, 58Axx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G55'">Algebraic geometry methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G60'">Dynamical systems methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G65'">Symmetries, Lie-group and Lie-algebra methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G70'">Functional-analytic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G75'">Variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Hxx'">Hamiltonian and Lagrangian mechanics [See also 37Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H03'">Lagrange's equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H05'">Hamilton's equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H06'">Completely integrable systems and methods of integration</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H07'">Nonintegrable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H08'">Nearly integrable Hamiltonian systems, KAM theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H09'">Perturbation theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H11'">Adiabatic invariants</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H12'">Periodic and almost periodic solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H14'">Stability problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H15'">Canonical and symplectic transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H20'">Hamilton-Jacobi equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H25'">Hamilton's principle</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H30'">Other variational principles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H33'">Symmetries and conservation laws, reverse symmetries, invariant manifolds and their bifurcations, reduction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H40'">Relativistic dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H45'">Constrained dynamics, Dirac's theory of constraints [See also 70F20, 70F25, 70Gxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H50'">Higher-order theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Jxx'">Linear vibration theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J10'">Modal analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J25'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J30'">Free motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J35'">Forced motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J40'">Parametric resonances</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J50'">Systems arising from the discretization of structural vibration problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Kxx'">Nonlinear dynamics [See also 34Cxx, 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K05'">Phase plane analysis, limit cycles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K20'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K25'">Free motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K28'">Parametric resonances</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K30'">Nonlinear resonances</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K40'">Forced motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K42'">Equilibria and periodic trajectories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K43'">Quasi-periodic motions and invariant tori</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K44'">Homoclinic and heteroclinic trajectories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K45'">Normal forms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K50'">Bifurcations and instability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K55'">Transition to stochasticity (chaotic behavior) [See also 37D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K60'">General perturbation schemes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K65'">Averaging of perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K70'">Systems with slow and fast motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K75'">Nonlinear modes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Lxx'">Random vibrations [See also 74H50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70L05'">Random vibrations [See also 74H50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Mxx'">Orbital mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70M20'">Orbital mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Pxx'">Variable mass, rockets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70P05'">Variable mass, rockets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Qxx'">Control of mechanical systems [See also 60Gxx, 60Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Q05'">Control of mechanical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70Sxx'">Classical field theories [See also 37Kxx, 37Lxx, 78-XX, 81Txx, 83-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70S05'">Lagrangian formalism and Hamiltonian formalism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70S10'">Symmetries and conservation laws</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70S15'">Yang-Mills and other gauge theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70S20'">More general nonquantum field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='70S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-XX'">Mechanics of deformable solids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Axx'">Generalities, axiomatics, foundations of continuum mechanics of solids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A05'">Kinematics of deformation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A10'">Stress</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A15'">Thermodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A20'">Theory of constitutive functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A25'">Molecular, statistical, and kinetic theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A30'">Nonsimple materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A35'">Polar materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A40'">Random materials and composite materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A45'">Theories of fracture and damage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A50'">Structured surfaces and interfaces, coexistent phases</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A55'">Theories of friction (tribology)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A60'">Micromechanical theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A65'">Reactive materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Bxx'">Elastic materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74B05'">Classical linear elasticity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74B10'">Linear elasticity with initial stresses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74B15'">Equations linearized about a deformed state (small deformations superposed on large)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74B20'">Nonlinear elasticity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Cxx'">Plastic materials, materials of stress-rate and internal-variable type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74C05'">Small-strain, rate-independent theories (including rigid-plastic and elasto-plastic materials)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74C10'">Small-strain, rate-dependent theories (including theories of viscoplasticity)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74C15'">Large-strain, rate-independent theories (including nonlinear plasticity)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74C20'">Large-strain, rate-dependent theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Dxx'">Materials of strain-rate type and history type, other materials with memory (including elastic materials with viscous damping, various viscoelastic materials)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74D05'">Linear constitutive equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74D10'">Nonlinear constitutive equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Exx'">Material properties given special treatment</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E05'">Inhomogeneity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E10'">Anisotropy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E15'">Crystalline structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E20'">Granularity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E25'">Texture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E30'">Composite and mixture properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E35'">Random structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E40'">Chemical structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Fxx'">Coupling of solid mechanics with other effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F05'">Thermal effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F10'">Fluid-solid interactions (including aero- and hydro-elasticity, porosity, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F15'">Electromagnetic effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F20'">Mixture effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F25'">Chemical and reactive effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Gxx'">Equilibrium (steady-state) problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G05'">Explicit solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G10'">Analytic approximation of solutions (perturbation methods, asymptotic methods, series, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G15'">Numerical approximation of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G20'">Local existence of solutions (near a given solution)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G25'">Global existence of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G30'">Uniqueness of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G35'">Multiplicity of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G40'">Regularity of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G45'">Bounds for solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G50'">Saint-Venant's principle</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G55'">Qualitative behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G60'">Bifurcation and buckling</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G65'">Energy minimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G70'">Stress concentrations, singularities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G75'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Hxx'">Dynamical problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H05'">Explicit solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H10'">Analytic approximation of solutions (perturbation methods, asymptotic methods, series, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H15'">Numerical approximation of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H20'">Existence of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H25'">Uniqueness of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H30'">Regularity of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H35'">Singularities, blowup, stress concentrations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H40'">Long-time behavior of solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H45'">Vibrations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H50'">Random vibrations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H55'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H60'">Dynamical bifurcation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H65'">Chaotic behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Jxx'">Waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J05'">Linear waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J10'">Bulk waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J15'">Surface waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J20'">Wave scattering</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J25'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J30'">Nonlinear waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J35'">Solitary waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J40'">Shocks and related discontinuities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Kxx'">Thin bodies, structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K05'">Strings</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K10'">Rods (beams, columns, shafts, arches, rings, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K15'">Membranes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K20'">Plates</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K25'">Shells</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K30'">Junctions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K35'">Thin films</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Lxx'">Special subfields of solid mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74L05'">Geophysical solid mechanics [See also 86-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74L10'">Soil and rock mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74L15'">Biomechanical solid mechanics [See also 92C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Mxx'">Special kinds of problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M05'">Control, switches and devices (``smart materials'') [See also 93Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M10'">Friction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M15'">Contact</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M20'">Impact</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M25'">Micromechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Nxx'">Phase transformations in solids [See also 74A50, 80Axx, 82B26, 82C26]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N05'">Crystals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N10'">Displacive transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N15'">Analysis of microstructure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N20'">Dynamics of phase boundaries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N25'">Transformations involving diffusion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N30'">Problems involving hysteresis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Pxx'">Optimization [See also 49Qxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74P05'">Compliance or weight optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74P10'">Optimization of other properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74P15'">Topological methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74P20'">Geometrical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Qxx'">Homogenization, determination of effective properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Q05'">Homogenization in equilibrium problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Q10'">Homogenization and oscillations in dynamical problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Q15'">Effective constitutive equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Q20'">Bounds on effective properties</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Rxx'">Fracture and damage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74R05'">Brittle damage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74R10'">Brittle fracture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74R15'">High-velocity fracture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74R20'">Anelastic fracture and damage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74Sxx'">Numerical methods [See also 65-XX, 74G15, 74H15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S05'">Finite element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S10'">Finite volume methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S15'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S20'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S25'">Spectral and related methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S30'">Other numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S60'">Stochastic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S70'">Complex variable methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='74S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-XX'">Fluid mechanics {For general continuum mechanics, see 74Axx, or other parts of 74-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Axx'">Foundations, constitutive equations, rheology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A02'">Foundations of fluid mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A05'">Non-Newtonian fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A10'">Viscoelastic fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A15'">Liquid crystals [See also 82D30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A20'">Thin fluid films</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A25'">Superfluids (classical aspects)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Bxx'">Incompressible inviscid fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B03'">Existence, uniqueness, and regularity theory [See also 35Q35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B07'">Free-surface potential flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B10'">Jets and cavities, cavitation, free-streamline theory, water-entry problems, airfoil and hydrofoil theory, sloshing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B15'">Water waves, gravity waves; dispersion and scattering, nonlinear interaction [See also 35Q30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B20'">Ship waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B25'">Solitary waves [See also 35C11]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B45'">Capillarity (surface tension) [See also 76D45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B47'">Vortex flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B55'">Internal waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B60'">Atmospheric waves [See also 86A10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B65'">Rossby waves [See also 86A05, 86A10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B70'">Stratification effects in inviscid fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B75'">Flow control and optimization [See also 49Q10, 93C20, 93C95]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Dxx'">Incompressible viscous fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D03'">Existence, uniqueness, and regularity theory [See also 35Q30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D05'">Navier-Stokes equations [See also 35Q30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D06'">Statistical solutions of Navier-Stokes and related equations [See also 60H30, 76M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D07'">Stokes and related (Oseen, etc.) flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D08'">Lubrication theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D09'">Viscous-inviscid interaction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D10'">Boundary-layer theory, separation and reattachment, higher-order effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D17'">Viscous vortex flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D25'">Wakes and jets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D27'">Other free-boundary flows; Hele-Shaw flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D33'">Waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D45'">Capillarity (surface tension) [See also 76B45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D50'">Stratification effects in viscous fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D55'">Flow control and optimization [See also 49Q10, 93C20, 93C95]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Exx'">Hydrodynamic stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E05'">Parallel shear flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E06'">Convection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E07'">Rotation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E09'">Stability and instability of nonparallel flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E15'">Absolute and convective instability and stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E17'">Interfacial stability and instability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E19'">Compressibility effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E20'">Stability and instability of geophysical and astrophysical flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E25'">Stability and instability of magnetohydrodynamic and electrohydrodynamic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E30'">Nonlinear effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Fxx'">Turbulence [See also 37-XX, 60Gxx, 60Jxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F02'">Fundamentals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F05'">Isotropic turbulence; homogeneous turbulence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F06'">Transition to turbulence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F10'">Shear flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F20'">Dynamical systems approach to turbulence [See also 37-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F25'">Turbulent transport, mixing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F30'">Renormalization and other field-theoretical methods [See also 81T99]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F35'">Convective turbulence [See also 76E15, 76Rxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F40'">Turbulent boundary layers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F45'">Stratification effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F50'">Compressibility effects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F55'">Statistical turbulence modeling [See also 76M35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F60'">$k$-$\varepsilon$ modeling</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F65'">Direct numerical and large eddy simulation of turbulence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F70'">Control of turbulent flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Gxx'">General aerodynamics and subsonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76G25'">General aerodynamics and subsonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Hxx'">Transonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76H05'">Transonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Jxx'">Supersonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76J20'">Supersonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76J99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Kxx'">Hypersonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76K05'">Hypersonic flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Lxx'">Shock waves and blast waves [See also 35L67]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76L05'">Shock waves and blast waves [See also 35L67]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76L99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Mxx'">Basic methods in fluid mechanics [See also 65-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M10'">Finite element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M12'">Finite volume methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M15'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M20'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M22'">Spectral methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M23'">Vortex methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M25'">Other numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M27'">Visualization algorithms</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M28'">Particle methods and lattice-gas methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M30'">Variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M35'">Stochastic analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M40'">Complex-variables methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M45'">Asymptotic methods, singular perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M50'">Homogenization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M55'">Dimensional analysis and similarity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M60'">Symmetry analysis, Lie group and algebra methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Nxx'">Compressible fluids and gas dynamics, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N10'">Existence, uniqueness, and regularity theory [See also 35L60, 35L65, 35Q30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N15'">Gas dynamics, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N17'">Viscous-inviscid interaction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N20'">Boundary-layer theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N25'">Flow control and optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Pxx'">Rarefied gas flows, Boltzmann equation [See also 82B40, 82C40, 82D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76P05'">Rarefied gas flows, Boltzmann equation [See also 82B40, 82C40, 82D05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Qxx'">Hydro- and aero-acoustics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Q05'">Hydro- and aero-acoustics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Rxx'">Diffusion and convection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76R05'">Forced convection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76R10'">Free convection</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76R50'">Diffusion [See also 60J60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Sxx'">Flows in porous media; filtration; seepage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76S05'">Flows in porous media; filtration; seepage</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Txx'">Two-phase and multiphase flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T10'">Liquid-gas two-phase flows, bubbly flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T15'">Dusty-gas two-phase flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T20'">Suspensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T25'">Granular flows [See also 74C99, 74E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T30'">Three or more component flows</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Uxx'">Rotating fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76U05'">Rotating fluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Vxx'">Reaction effects in flows [See also 80A32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76V05'">Reaction effects in flows [See also 80A32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76V99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Wxx'">Magnetohydrodynamics and electrohydrodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76W05'">Magnetohydrodynamics and electrohydrodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76W99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Xxx'">Ionized gas flow in electromagnetic fields; plasmic flow [See also 82D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76X05'">Ionized gas flow in electromagnetic fields; plasmic flow [See also 82D10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76X99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Yxx'">Quantum hydrodynamics and relativistic hydrodynamics [See also 82D50, 83C55, 85A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Y05'">Quantum hydrodynamics and relativistic hydrodynamics [See also 82D50, 83C55, 85A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Y99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Zxx'">Biological fluid mechanics [See also 74F10, 74L15, 92Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Z05'">Physiological flows [See also 92C35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Z10'">Biopropulsion in water and in air</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='76Z99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-XX'">Optics, electromagnetic theory {For quantum optics, see 81V80}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78Axx'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A02'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A05'">Geometric optics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A10'">Physical optics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A15'">Electron optics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A20'">Space charge waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A25'">Electromagnetic theory, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A30'">Electro- and magnetostatics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A35'">Motion of charged particles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A37'">Ion traps</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A40'">Waves and radiation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A45'">Diffraction, scattering [See also 34E20 for WKB methods]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A46'">Inverse scattering problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A48'">Composite media; random media</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A50'">Antennas, wave-guides</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A55'">Technical applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A57'">Electrochemistry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A60'">Lasers, masers, optical bistability, nonlinear optics [See also 81V80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A70'">Biological applications [See also 91D30, 92C30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A97'">Mathematically heuristic optics and electromagnetic theory (must also be assigned at least one other classification number in this section)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78Mxx'">Basic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M05'">Method of moments</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M10'">Finite element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M12'">Finite volume methods, finite integration techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M15'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M16'">Multipole methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M20'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M22'">Spectral methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M25'">Other numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M30'">Variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M31'">Monte Carlo methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M32'">Neural and heuristic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M34'">Model reduction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M35'">Asymptotic analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M40'">Homogenization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M50'">Optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='78M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-XX'">Classical thermodynamics, heat transfer {For thermodynamics of solids, see 74A15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80Axx'">Thermodynamics and heat transfer</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A05'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A10'">Classical thermodynamics, including relativistic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A17'">Thermodynamics of continua [See also 74A15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A20'">Heat and mass transfer, heat flow</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A22'">Stefan problems, phase changes, etc. [See also 74Nxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A23'">Inverse problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A25'">Combustion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A30'">Chemical kinetics [See also 76V05, 92C45, 92E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A32'">Chemically reacting flows [See also 92C45, 92E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A50'">Chemistry (general) [See mainly 92Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80Mxx'">Basic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M10'">Finite element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M12'">Finite volume methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M15'">Boundary element methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M20'">Finite difference methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M22'">Spectral methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M25'">Other numerical methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M30'">Variational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M31'">Monte Carlo methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M35'">Asymptotic analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M40'">Homogenization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M50'">Optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='80M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-XX'">Quantum theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-05'">Experimental papers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Pxx'">Axiomatics, foundations, philosophy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P05'">General and philosophical</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P10'">Logical foundations of quantum mechanics; quantum logic [See also 03G12, 06C15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P13'">Contextuality</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P15'">Quantum measurement theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P16'">Quantum state spaces, operational and probabilistic concepts</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P20'">Stochastic mechanics (including stochastic electrodynamics)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P40'">Quantum coherence, entanglement, quantum correlations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P45'">Quantum information, communication, networks [See also 94A15, 94A17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P50'">Quantum state estimation, approximate cloning</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P68'">Quantum computation [See also 68Q05, 68Q12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P70'">Quantum coding (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P94'">Quantum cryptography [See also 94A60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Qxx'">General mathematical topics and methods in quantum theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q05'">Closed and approximate solutions to the Schr&#xC3;&#xB6;dinger, Dirac, Klein-Gordon and other equations of quantum mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q10'">Selfadjoint operator theory in quantum theory, including spectral analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q12'">Non-selfadjoint operator theory in quantum theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q15'">Perturbation theories for operators and differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q20'">Semiclassical techniques, including WKB and Maslov methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q30'">Feynman integrals and graphs; applications of algebraic topology and algebraic geometry [See also 14D05, 32S40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q35'">Quantum mechanics on special spaces: manifolds, fractals, graphs, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q37'">Quantum dots, waveguides, ratchets, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q40'">Bethe-Salpeter and other integral equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q50'">Quantum chaos [See also 37Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q60'">Supersymmetry and quantum mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q65'">Alternative quantum mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q70'">Differential-geometric methods, including holonomy, Berry and Hannay phases, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q80'">Special quantum systems, such as solvable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q93'">Quantum control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Rxx'">Groups and algebras in quantum theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R05'">Finite-dimensional groups and algebras motivated by physics and their representations [See also 20C35, 22E70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R10'">Infinite-dimensional groups and algebras motivated by physics, including Virasoro, Kac-Moody, $W$-algebras and other current algebras and their representations [See also 17B65, 17B67, 22E65, 22E67, 22E70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R12'">Relations with integrable systems [See also 17Bxx, 37J35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R15'">Operator algebra methods [See also 46Lxx, 81T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R20'">Covariant wave equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R25'">Spinor and twistor methods [See also 32L25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R30'">Coherent states [See also 22E45]; squeezed states [See also 81V80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R40'">Symmetry breaking</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R50'">Quantum groups and related algebraic methods [See also 16T20, 17B37]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R60'">Noncommutative geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Sxx'">General quantum mechanics and problems of quantization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S05'">Canonical quantization, commutation relations and statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S10'">Geometry and quantization, symplectic methods [See also 53D50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S20'">Stochastic quantization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S22'">Open systems, reduced dynamics, master equations, decoherence [See also 82C31]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S25'">Quantum stochastic calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S30'">Phase-space methods including Wigner distributions, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S40'">Path integrals [See also 58D30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81S99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Txx'">Quantum field theory; related classical field theories [See also 70Sxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T05'">Axiomatic quantum field theory; operator algebras</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T08'">Constructive quantum field theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T10'">Model quantum field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T13'">Yang-Mills and other gauge theories [See also 53C07, 58E15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T15'">Perturbative methods of renormalization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T16'">Nonperturbative methods of renormalization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T17'">Renormalization group methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T18'">Feynman diagrams</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T20'">Quantum field theory on curved space backgrounds</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T25'">Quantum field theory on lattices</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T27'">Continuum limits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T28'">Thermal quantum field theory [See also 82B30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T30'">String and superstring theories; other extended objects (e.g., branes) [See also 83E30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T40'">Two-dimensional field theories, conformal field theories, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T45'">Topological field theories [See also 57R56, 58Dxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T50'">Anomalies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T55'">Casimir effect</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T60'">Supersymmetric field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T70'">Quantization in field theory; cohomological methods [See also 58D29]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T75'">Noncommutative geometry methods [See also 46L85, 46L87, 58B34]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T80'">Simulation and numerical modeling</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81T99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Uxx'">Scattering theory [See also 34A55, 34L25, 34L40, 35P25, 47A40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U05'">$2$-body potential scattering theory [See also 34E20 for WKB methods]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U10'">$n$-body potential scattering theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U15'">Exactly and quasi-solvable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U20'">$S$-matrix theory, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U30'">Dispersion theory, dispersion relations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U35'">Inelastic and multichannel scattering</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U40'">Inverse scattering problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81U99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81Vxx'">Applications to specific physical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V05'">Strong interaction, including quantum chromodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V10'">Electromagnetic interaction; quantum electrodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V15'">Weak interaction</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V17'">Gravitational interaction [See also 83Cxx and 83Exx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V19'">Other fundamental interactions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V22'">Unified theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V25'">Other elementary particle theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V35'">Nuclear physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V45'">Atomic physics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V55'">Molecular physics [See also 92E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V65'">Quantum dots [See also 82D20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V70'">Many-body theory; quantum Hall effect</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V80'">Quantum optics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='81V99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-XX'">Statistical mechanics, structure of matter</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-05'">Experimental papers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82Bxx'">Equilibrium statistical mechanics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B03'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B05'">Classical equilibrium statistical mechanics (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B10'">Quantum equilibrium statistical mechanics (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B20'">Lattice systems (Ising, dimer, Potts, etc.) and systems on graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B21'">Continuum models (systems of particles, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B23'">Exactly solvable models; Bethe ansatz</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B24'">Interface problems; diffusion-limited aggregation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B26'">Phase transitions (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B27'">Critical phenomena</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B28'">Renormalization group methods [See also 81T17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B30'">Statistical thermodynamics [See also 80-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B31'">Stochastic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B35'">Irreversible thermodynamics, including Onsager-Machlup theory [See also 92E20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B40'">Kinetic theory of gases</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B41'">Random walks, random surfaces, lattice animals, etc. [See also 60G50, 82C41]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B43'">Percolation [See also 60K35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B44'">Disordered systems (random Ising models, random Schr&#xC3;&#xB6;dinger operators, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B80'">Numerical methods (Monte Carlo, series resummation, etc.) [See also 65-XX, 81T80]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82Cxx'">Time-dependent statistical mechanics (dynamic and nonequilibrium)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C03'">Foundations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C05'">Classical dynamic and nonequilibrium statistical mechanics (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C10'">Quantum dynamics and nonequilibrium statistical mechanics (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C20'">Dynamic lattice systems (kinetic Ising, etc.) and systems on graphs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C21'">Dynamic continuum models (systems of particles, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C22'">Interacting particle systems [See also 60K35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C23'">Exactly solvable dynamic models [See also 37K60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C24'">Interface problems; diffusion-limited aggregation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C26'">Dynamic and nonequilibrium phase transitions (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C27'">Dynamic critical phenomena</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C28'">Dynamic renormalization group methods [See also 81T17]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C31'">Stochastic methods (Fokker-Planck, Langevin, etc.) [See also 60H10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C32'">Neural nets [See also 68T05, 91E40, 92B20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C35'">Irreversible thermodynamics, including Onsager-Machlup theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C40'">Kinetic theory of gases</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C41'">Dynamics of random walks, random surfaces, lattice animals, etc. [See also 60G50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C43'">Time-dependent percolation [See also 60K35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C44'">Dynamics of disordered systems (random Ising systems, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C70'">Transport processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C80'">Numerical methods (Monte Carlo, series resummation, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82Dxx'">Applications to specific types of physical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D05'">Gases</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D10'">Plasmas</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D15'">Liquids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D20'">Solids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D25'">Crystals {For crystallographic group theory, see 20H15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D30'">Random media, disordered materials (including liquid crystals and spin glasses)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D35'">Metals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D37'">Semiconductors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D40'">Magnetic materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D45'">Ferroelectrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D50'">Superfluids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D55'">Superconductors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D60'">Polymers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D75'">Nuclear reactor theory; neutron transport</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D77'">Quantum wave guides, quantum wires [See also 78A50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D80'">Nanostructures and nanoparticles</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='82D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-XX'">Relativity and gravitational theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Axx'">Special relativity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83A05'">Special relativity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Bxx'">Observational and experimental questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83B05'">Observational and experimental questions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Cxx'">General relativity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C05'">Einstein's equations (general structure, canonical formalism, Cauchy problems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C10'">Equations of motion</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C15'">Exact solutions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C20'">Classes of solutions; algebraically special solutions, metrics with symmetries</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C22'">Einstein-Maxwell equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C25'">Approximation procedures, weak fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C27'">Lattice gravity, Regge calculus and other discrete methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C30'">Asymptotic procedures (radiation, news functions, $\scr H$-spaces, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C35'">Gravitational waves</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C40'">Gravitational energy and conservation laws; groups of motions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C45'">Quantization of the gravitational field</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C47'">Methods of quantum field theory [See also 81T20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C50'">Electromagnetic fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C55'">Macroscopic interaction of the gravitational field with matter (hydrodynamics, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C57'">Black holes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C60'">Spinor and twistor methods; Newman-Penrose formalism</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C65'">Methods of noncommutative geometry [See also 58B34]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C75'">Space-time singularities, cosmic censorship, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C80'">Analogues in lower dimensions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Dxx'">Relativistic gravitational theories other than Einstein's, including asymmetric field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83D05'">Relativistic gravitational theories other than Einstein's, including asymmetric field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Exx'">Unified, higher-dimensional and super field theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83E05'">Geometrodynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83E15'">Kaluza-Klein and other higher-dimensional theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83E30'">String and superstring theories [See also 81T30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83E50'">Supergravity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83Fxx'">Cosmology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83F05'">Cosmology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='83F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-XX'">Astronomy and astrophysics {For celestial mechanics, see 70F15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85Axx'">Astronomy and astrophysics {For celestial mechanics, see 70F15}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A04'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A05'">Galactic and stellar dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A15'">Galactic and stellar structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A20'">Planetary atmospheres</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A25'">Radiative transfer</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A30'">Hydrodynamic and hydromagnetic problems [See also 76Y05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A35'">Statistical astronomy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A40'">Cosmology {For relativistic cosmology, see 83F05}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='85A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-XX'">Geophysics [See also 76U05, 76V05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-05'">Experimental work</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86Axx'">Geophysics [See also 76U05, 76V05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A04'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A05'">Hydrology, hydrography, oceanography [See also 76Bxx, 76E20, 76Q05, 76Rxx, 76U05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A10'">Meteorology and atmospheric physics [See also 76Bxx, 76E20, 76N15, 76Q05, 76Rxx, 76U05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A15'">Seismology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A17'">Global dynamics, earthquake problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A20'">Potentials, prospecting</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A22'">Inverse problems [See also 35R30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A25'">Geo-electricity and geomagnetism [See also 76W05, 78A25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A30'">Geodesy, mapping problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A32'">Geostatistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A40'">Glaciology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A60'">Geological problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='86A99'">Miscellaneous topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-XX'">Operations research, mathematical programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90Bxx'">Operations research and management science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B05'">Inventory, storage, reservoirs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B06'">Transportation, logistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B10'">Network models, deterministic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B15'">Network models, stochastic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B18'">Communication networks [See also 68M10, 94A05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B20'">Traffic problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B22'">Queues and service [See also 60K25, 68M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B25'">Reliability, availability, maintenance, inspection [See also 60K10, 62N05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B30'">Production models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B35'">Scheduling theory, deterministic [See also 68M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B36'">Scheduling theory, stochastic [See also 68M20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B40'">Search theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B50'">Management decision making, including multiple objectives [See also 90C29, 90C31, 91A35, 91B06]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B60'">Marketing, advertising [See also 91B60]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B70'">Theory of organizations, manpower planning [See also 91D35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B80'">Discrete location and assignment [See also 90C10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B85'">Continuous location</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B90'">Case-oriented studies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90Cxx'">Mathematical programming [See also 49Mxx, 65Kxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C05'">Linear programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C06'">Large-scale problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C08'">Special problems of linear programming (transportation, multi-index, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C09'">Boolean programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C10'">Integer programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C11'">Mixed integer programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C15'">Stochastic programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C20'">Quadratic programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C22'">Semidefinite programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C25'">Convex programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C26'">Nonconvex programming, global optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C27'">Combinatorial optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C29'">Multi-objective and goal programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C30'">Nonlinear programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C31'">Sensitivity, stability, parametric optimization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C32'">Fractional programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C33'">Complementarity and equilibrium problems and variational inequalities (finite dimensions)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C34'">Semi-infinite programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C35'">Programming involving graphs or networks [See also 90C27]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C39'">Dynamic programming [See also 49L20]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C40'">Markov and semi-Markov decision processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C46'">Optimality conditions, duality [See also 49N15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C47'">Minimax problems [See also 49K35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C48'">Programming in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C49'">Extreme-point and pivoting methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C51'">Interior-point methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C52'">Methods of reduced gradient type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C53'">Methods of quasi-Newton type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C55'">Methods of successive quadratic programming type</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C56'">Derivative-free methods and methods using generalized derivatives [See also 49J52]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C57'">Polyhedral combinatorics, branch-and-bound, branch-and-cut</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C59'">Approximation methods and heuristics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C60'">Abstract computational complexity for mathematical programming problems [See also 68Q25]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C70'">Fuzzy programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C90'">Applications of mathematical programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='90C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-XX'">Game theory, economics, social and behavioral sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-03'">Historical (must also be assigned at least one classification number from section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Axx'">Game theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A05'">2-person games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A06'">$n$-person games, $n>2$</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A10'">Noncooperative games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A12'">Cooperative games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A13'">Games with infinitely many players</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A15'">Stochastic games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A18'">Games in extensive form</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A20'">Multistage and repeated games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A22'">Evolutionary games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A23'">Differential games [See also 49N70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A24'">Positional games (pursuit and evasion, etc.) [See also 49N75]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A25'">Dynamic games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A26'">Rationality, learning</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A28'">Signaling, communication</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A30'">Utility theory for games [See also 91B16]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A35'">Decision theory for games [See also 62Cxx, 91B06, 90B50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A40'">Game-theoretic models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A43'">Games involving graphs [See also 05C57]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A44'">Games involving topology or set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A46'">Combinatorial games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A50'">Discrete-time games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A55'">Games of timing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A60'">Probabilistic games; gambling [See also 60G40]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A65'">Hierarchical games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A70'">Spaces of games</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A80'">Applications of game theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A90'">Experimental studies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Bxx'">Mathematical economics {For econometrics, see 62P20}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B02'">Fundamental topics (basic mathematics, methodology; applicable to economics in general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B06'">Decision theory [See also 62Cxx, 90B50, 91A35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B08'">Individual preferences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B10'">Group preferences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B12'">Voting theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B14'">Social choice</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B15'">Welfare economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B16'">Utility theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B18'">Public goods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B24'">Price theory and market structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B25'">Asset pricing models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B26'">Market models (auctions, bargaining, bidding, selling, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B30'">Risk theory, insurance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B32'">Resource and cost allocation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B38'">Production theory, theory of the firm</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B40'">Labor market, contracts</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B42'">Consumer behavior, demand theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B44'">Informational economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B50'">General equilibrium theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B51'">Dynamic stochastic general equilibrium theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B52'">Special types of equilibria</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B54'">Special types of economies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B55'">Economic dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B60'">Trade models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B62'">Growth models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B64'">Macro-economic models (monetary models, models of taxation)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B66'">Multisectoral models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B68'">Matching models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B69'">Heterogeneous agent models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B70'">Stochastic models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B72'">Spatial models</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B74'">Models of real-world systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B76'">Environmental economics (natural resource models, harvesting, pollution, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B80'">Applications of statistical and quantum mechanics to economics (econophysics)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B82'">Statistical methods; economic indices and measures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B84'">Economic time series analysis [See also 62M10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Cxx'">Social and behavioral sciences: general topics {For statistics, see 62-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91C05'">Measurement theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91C15'">One- and multidimensional scaling</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91C20'">Clustering [See also 62H30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Dxx'">Mathematical sociology (including anthropology)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D10'">Models of societies, social and urban evolution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D20'">Mathematical geography and demography</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D25'">Spatial models [See also 91B72]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D30'">Social networks</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D35'">Manpower systems [See also 91B40, 90B70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Exx'">Mathematical psychology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91E10'">Cognitive psychology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91E30'">Psychophysics and psychophysiology; perception</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91E40'">Memory and learning [See also 68T05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91E45'">Measurement and performance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Fxx'">Other social and behavioral sciences (mathematical treatment)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91F10'">History, political science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91F20'">Linguistics [See also 03B65, 68T50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91Gxx'">Mathematical finance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G10'">Portfolio theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G20'">Derivative securities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G30'">Interest rates (stochastic models)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G40'">Credit risk</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G50'">Corporate finance</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G60'">Numerical methods (including Monte Carlo methods)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G70'">Statistical methods, econometrics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G80'">Financial applications of other theories (stochastic control, calculus of variations, PDE, SPDE, dynamical systems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='91G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-XX'">Biology and other natural sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92-08'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92Bxx'">Mathematical biology in general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B05'">General biology and biomathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B10'">Taxonomy, cladistics, statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B15'">General biostatistics [See also 62P10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B20'">Neural networks, artificial life and related topics [See also 68T05, 82C32, 94Cxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B25'">Biological rhythms and synchronization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92Cxx'">Physiological, cellular and medical topics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C05'">Biophysics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C10'">Biomechanics [See also 74L15]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C15'">Developmental biology, pattern formation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C17'">Cell movement (chemotaxis, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C20'">Neural biology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C30'">Physiology (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C35'">Physiological flow [See also 76Z05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C37'">Cell biology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C40'">Biochemistry, molecular biology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C42'">Systems biology, networks</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C45'">Kinetics in biochemical problems (pharmacokinetics, enzyme kinetics, etc.) [See also 80A30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C50'">Medical applications (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C55'">Biomedical imaging and signal processing [See also 44A12, 65R10, 94A08, 94A12]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C60'">Medical epidemiology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C80'">Plant biology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92Dxx'">Genetics and population dynamics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D10'">Genetics {For genetic algebras, see 17D92}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D15'">Problems related to evolution</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D20'">Protein sequences, DNA sequences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D25'">Population dynamics (general)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D30'">Epidemiology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D40'">Ecology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D50'">Animal behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92Exx'">Chemistry {For biochemistry, see 92C40}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92E10'">Molecular structure (graph-theoretic methods, methods of differential topology, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92E20'">Classical flows, reactions, etc. [See also 80A30, 80A32]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92Fxx'">Other natural sciences (should also be assigned at least one other classification number in this section)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92F05'">Other natural sciences (should also be assigned at least one other classification number in section 92)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='92F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-XX'">Systems theory; control {For optimal control, see 49-XX}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93Axx'">General</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A05'">Axiomatic system theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A10'">General systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A13'">Hierarchical systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A14'">Decentralized systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A15'">Large scale systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A30'">Mathematical modeling (models of systems, model-matching, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93Bxx'">Controllability, observability, and system structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B03'">Attainable sets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B05'">Controllability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B07'">Observability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B10'">Canonical structure</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B11'">System structure simplification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B12'">Variable structure systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B15'">Realizations from input-output data</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B17'">Transformations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B18'">Linearizations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B20'">Minimal systems representations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B25'">Algebraic methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B27'">Geometric methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B28'">Operator-theoretic methods [See also 47A48, 47A57, 47B35, 47N70]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B30'">System identification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B35'">Sensitivity (robustness)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B36'">$H^\infty$-control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B40'">Computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B50'">Synthesis problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B51'">Design techniques (robust design, computer-aided design, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B52'">Feedback control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B55'">Pole and zero placement problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B60'">Eigenvalue problems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93Cxx'">Control systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C05'">Linear systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C10'">Nonlinear systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C15'">Systems governed by ordinary differential equations [See also 34H05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C20'">Systems governed by partial differential equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C23'">Systems governed by functional-differential equations [See also 34K35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C25'">Systems in abstract spaces</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C30'">Systems governed by functional relations other than differential equations (such as hybrid and switching systems)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C35'">Multivariable systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C40'">Adaptive control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C41'">Problems with incomplete information</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C42'">Fuzzy control systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C55'">Discrete-time systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C57'">Sampled-data systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C62'">Digital systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C65'">Discrete event systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C70'">Time-scale analysis and singular perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C73'">Perturbations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C80'">Frequency-response methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C83'">Control problems involving computers (process control, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C85'">Automated systems (robots, etc.) [See also 68T40, 70B15, 70Q05]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C95'">Applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93Dxx'">Stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D05'">Lyapunov and other classical stabilities (Lagrange, Poisson, $L^p, l^p$, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D09'">Robust stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D10'">Popov-type stability of feedback systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D15'">Stabilization of systems by feedback</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D20'">Asymptotic stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D21'">Adaptive or robust stabilization</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D25'">Input-output approaches</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D30'">Scalar and vector Lyapunov functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93Exx'">Stochastic systems and control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E03'">Stochastic systems, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E10'">Estimation and detection [See also 60G35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E11'">Filtering [See also 60G35]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E12'">System identification</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E14'">Data smoothing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E15'">Stochastic stability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E20'">Optimal stochastic control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E24'">Least squares and related methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E25'">Other computational methods</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E35'">Stochastic learning and adaptive control</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='93E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-XX'">Information and communication, circuits</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94Axx'">Communication, information</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A05'">Communication theory [See also 60G35, 90B18]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A08'">Image processing (compression, reconstruction, etc.) [See also 68U10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A11'">Application of orthogonal and other special functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A12'">Signal theory (characterization, reconstruction, filtering, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A13'">Detection theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A14'">Modulation and demodulation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A15'">Information theory, general [See also 62B10, 81P45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A17'">Measures of information, entropy</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A20'">Sampling theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A24'">Coding theorems (Shannon theory)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A29'">Source coding [See also 68P30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A34'">Rate-distortion theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A40'">Channel models (including quantum)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A45'">Prefix, length-variable, comma-free codes [See also 20M35, 68Q45]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A50'">Theory of questionnaires</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A55'">Shift register sequences and sequences over finite alphabets</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A60'">Cryptography [See also 11T71, 14G50, 68P25, 81P94]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A62'">Authentication and secret sharing [See also 81P94]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94Bxx'">Theory of error-correcting codes and error-detecting codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B05'">Linear codes, general</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B10'">Convolutional codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B12'">Combined modulation schemes (including trellis codes)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B15'">Cyclic codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B20'">Burst-correcting codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B25'">Combinatorial codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B27'">Geometric methods (including applications of algebraic geometry) [See also 11T71, 14G50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B30'">Majority codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B35'">Decoding</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B40'">Arithmetic codes [See also 11T71, 14G50]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B50'">Synchronization error-correcting codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B60'">Other types of codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B65'">Bounds on codes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B70'">Error probability</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B75'">Applications of the theory of convex sets and geometry of numbers (covering radius, etc.) [See also 11H31, 11H71]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94Cxx'">Circuits, networks</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C05'">Analytic circuit theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C10'">Switching theory, application of Boolean algebra; Boolean functions [See also 06E30]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C12'">Fault detection; testing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C15'">Applications of graph theory [See also 05Cxx, 68R10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C30'">Applications of design theory [See also 05Bxx]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94Dxx'">Fuzzy sets and logic (in connection with questions of Section 94) [See also 03B52, 03E72, 28E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94D05'">Fuzzy sets and logic (in connection with questions of Section 94) [See also 03B52, 03E72, 28E10]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='94D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-XX'">Mathematics education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-00'">General reference works (handbooks, dictionaries, bibliographies, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-01'">Instructional exposition (textbooks, tutorial papers, etc.)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-02'">Research exposition (monographs, survey articles)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-03'">Historical (must also be assigned at least one classification number from Section 01)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-04'">Explicit machine computation and programs (not the theory of computation or programming)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97-06'">Proceedings, conferences, collections, etc.</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Axx'">General, mathematics and education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A10'">Comprehensive works, reference books</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A20'">Recreational mathematics, games [See also 00A08]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A30'">History of mathematics and mathematics education [See also 01-XX]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A40'">Mathematics and society</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A50'">Bibliographies [See also 01-00]</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A70'">Theses and postdoctoral theses</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A80'">Popularization of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97A99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Bxx'">Educational policy and systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B10'">Educational research and planning</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B20'">General education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B30'">Vocational education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B40'">Higher education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B50'">Teacher education {For research aspects, see 97C70}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B60'">Adult and further education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B70'">Syllabuses, educational standards</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97B99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Cxx'">Psychology of mathematics education, research in mathematics education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C20'">Affective behavior</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C30'">Cognitive processes, learning theories</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C40'">Intelligence and aptitudes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C50'">Language and verbal communities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C60'">Sociological aspects of learning</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C70'">Teaching-learning processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97C99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Dxx'">Education and instruction in mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D10'">Comprehensive works, comparative studies</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D20'">Philosophical and theoretical contributions (maths didactics)</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D30'">Objectives and goals</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D40'">Teaching methods and classroom techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D50'">Teaching problem solving and heuristic strategies {For research aspects, see 97Cxx}</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D60'">Student assessment, achievement control and rating</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D70'">Learning difficulties and student errors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D80'">Teaching units and draft lessons</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97D99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Exx'">Foundations of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E20'">Philosophy and mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E30'">Logic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E40'">Language of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E50'">Reasoning and proving in the mathematics classroom</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E60'">Sets, relations, set theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97E99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Fxx'">Arithmetic, number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F20'">Pre-numerical stage, concept of numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F30'">Natural numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F40'">Integers, rational numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F50'">Real numbers, complex numbers</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F60'">Number theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F70'">Measures and units</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F80'">Ratio and proportion, percentages</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F90'">Real life mathematics, practical arithmetic</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97F99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Gxx'">Geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G20'">Informal geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G30'">Areas and volumes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G40'">Plane and solid geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G50'">Transformation geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G60'">Plane and spherical trigonometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G70'">Analytic geometry. Vector algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G80'">Descriptive geometry</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97G99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Hxx'">Algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H20'">Elementary algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H30'">Equations and inequalities</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H40'">Groups, rings, fields</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H50'">Ordered algebraic structures</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H60'">Linear algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97H99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Ixx'">Analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I20'">Mappings and functions</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I30'">Sequences and series</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I40'">Differential calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I50'">Integral calculus</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I60'">Functions of several variables</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I70'">Functional equations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I80'">Complex analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97I99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Kxx'">Combinatorics, graph theory, probability theory, statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K20'">Combinatorics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K30'">Graph theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K40'">Descriptive statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K50'">Probability theory</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K60'">Distributions and stochastic processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K70'">Foundations and methodology of statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K80'">Applied statistics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97K99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Mxx'">Mathematical modeling, applications of mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M10'">Modeling and interdisciplinarity</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M20'">Mathematics in vocational training and career education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M30'">Financial and insurance mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M40'">Operations research, economics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M50'">Physics, astronomy, technology, engineering</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M60'">Biology, chemistry, medicine</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M70'">Behavioral and social sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M80'">Arts, music, language, architecture</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97M99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Nxx'">Numerical mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N20'">Rounding, estimation, theory of errors</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N30'">Numerical algebra</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N40'">Numerical analysis</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N50'">Interpolation and approximation</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N60'">Mathematical programming</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N70'">Discrete mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N80'">Mathematical software, computer programs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97N99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Pxx'">Computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P20'">Theory of computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P30'">System software</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P40'">Programming languages</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P50'">Programming techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P60'">Hardware</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P70'">Computer science and society</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97P99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Qxx'">Computer science education</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q20'">Affective aspects in teaching computer science</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q30'">Cognitive processes</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q40'">Sociological aspects</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q50'">Objectives</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q60'">Teaching methods and classroom techniques</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q70'">Student assessment</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q80'">Teaching units</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Q99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Rxx'">Computer science applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R10'">Comprehensive works, collections of programs</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R20'">Applications in mathematics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R30'">Applications in sciences</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R40'">Artificial intelligence</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R50'">Data bases, information systems</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R60'">Computer graphics</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R70'">User programs, administrative applications</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R80'">Recreational computing</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97R99'">None of the above, but in this section</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97Uxx'">Educational material and media, educational technology</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U10'">Comprehensive works</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U20'">Textbooks. Textbook research</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U30'">Teachers' manuals and planning aids</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U40'">Problem books. Competitions. Examinations</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U50'">Computer assisted instruction; e-learning</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U60'">Manipulative materials</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U70'">Technological tools, calculators</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U80'">Audiovisual media</xsl:when>
                                    <xsl:when test="normalize-space($mscSubjectCode)='97U99'">None of the above, but in this section</xsl:when>
                                </xsl:choose>
                            </xsl:variable>
							                <keywords>
							                    <xsl:if test="@lang[string-length()&gt;0]">
							                        <xsl:attribute name="xml:lang">
							                            <xsl:value-of select="translate(@lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
							                        </xsl:attribute>
							                    </xsl:if>
							                    <xsl:if test="@scheme[string-length()&gt;0]">
							                        <xsl:attribute name="scheme">
							                            <xsl:value-of select="normalize-space(@scheme)"/>
							                        </xsl:attribute>
							                    </xsl:if>
							                    <xsl:if test="@rank[string-length()&gt;0]">
							                        <xsl:attribute name="ana">
							                            <xsl:value-of select="normalize-space(@rank)"/>
							                        </xsl:attribute>
							                    </xsl:if>
							                    <list>
							                        <item>
							                            <label>
							                                <xsl:value-of select="normalize-space($mscSubjectCode)"/>
							                            </label>
							                            <term>
							                                <xsl:value-of select="normalize-space($mscSubjectVerb)"/>
							                            </term> 
							                        </item>
							                    </list>
							                </keywords>
							
						
    </xsl:template>
</xsl:stylesheet>
