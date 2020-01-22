<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xpath-default-namespace="http://www.wiley.com/namespaces/wiley"
	exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>
    <!-- date de creation -->
    <!-- code genre -->
    <xsl:variable name="codeGenre1">
        <xsl:value-of select="//component/header/publicationMeta[@level='unit']/@type"/>
    </xsl:variable>
    <!--xsl:variable name="codeGenreA">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenre1)='chapter'">
                <xsl:choose>
                    <xsl:when test="contains(//header/publicationMeta[@level='unit']/titleGroup/title[@type='tocHeading1'],'Brief communications')">brief-communication</xsl:when>
                    <xsl:when test="contains(//header/publicationMeta[@level='unit']/titleGroup/title[@type='tocHeading1'],'Review Paper')">review-article</xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="//abstract[string-length()&gt; 0]">article</xsl:when>
                            <xsl:otherwise>other</xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='technicalNote'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='article'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='reviewArticle'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='editorial'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='bookReview'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='shortCommunication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='shortArticle'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='rapidCommunication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='caseStudy'">case-report</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='abstract'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='letter'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='news'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='commentary'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='meetingReport'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='rapidPublication'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='serialArticle'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='erratum'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='miscellaneous'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1)='historicalPerspective'">research-article</xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable-->

    <!-- codeLangue -->
    <xsl:variable name="codeLangue">
        <xsl:choose>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1365-2478.1963.tb02022.x' 
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1755-5825.1984.tb00925.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1365-2478.1959.tb01450.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1755-618X.1993.tb00170.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1365-2478.1963.tb02023.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1755-5825.1979.tb01509.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1365-2478.1970.tb02102.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1755-5825.1987.tb01074.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1600-0390.2012.00679.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1754-7121.2012.00236.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1600-0390.2012.00676.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1752-1718.2011.01401.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1600-0390.2012.00677.x'
                or component/header/publicationMeta[@level='unit']/doi='10.1111/j.1600-0390.2012.00678.x'">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta/issn[@type='print']='0378-5599'">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1099-0682(199809)1998:9&lt;1205::AID-EJIC1205&gt;3.0.CO;2-F' or header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199910)341:7&lt;657::AID-PRAC657&gt;3.0.CO;2-P'or header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199908)341:6&lt;568::AID-PRAC568&gt;3.0.CO;2-H'">
                <xsl:text>en</xsl:text>
            </xsl:when>
            <!-- correction ouzbeck 10.1002/asna.2103030307 -->
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1550-7408.1980.tb04229.x' or header/publicationMeta[@level='unit']/doi='10.1111/j.1365-3180.1990.tb01689.x'or header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030307'or header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030305'">
                <xsl:text>de</xsl:text>
            </xsl:when>
            <!-- correction arabe 10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S -->
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S'">
                <xsl:text>es</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00477.x' ">
                <xsl:text>de</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00484.x'">
                <xsl:text>es</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2007.00453.x'">
                <xsl:text>it</xsl:text>
            </xsl:when>
            <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00459.x'">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when test="*/@xml:lang ='be'">
                <xsl:text>nl</xsl:text>
            </xsl:when>
            <xsl:when test="*/@xml:lang='ka'">
                <xsl:choose>
                    <xsl:when test="component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00489.x'">
                        <xsl:text>it</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>de</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                    <xsl:when test="component/header/contentMeta/titleGroup/title[@type='main'][1]/@xml:lang">
                        <xsl:value-of select="component/header/contentMeta/titleGroup/title[@type='main'][1]/@xml:lang"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="component/@xml:lang"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="component">
        <!--xsl:comment>
            <xsl:text>Version 0.1 generated on </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment-->
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="$codeLangue"/>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <!-- SG - titre brut -->
                    <titleStmt>
                        <xsl:choose>
                            <xsl:when test="header/contentMeta/titleGroup/title">
                                <xsl:for-each select="header/contentMeta/titleGroup/title[@type='main']">
                                    <title level="a" type="main">
                                        <xsl:choose>
                                            <xsl:when test="header/publicationMeta/issn[@type='print']='0378-5599'">
                                                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1099-0682(199809)1998:9&lt;1205::AID-EJIC1205&gt;3.0.CO;2-F' or header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199910)341:7&lt;657::AID-PRAC657&gt;3.0.CO;2-P'or header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199908)341:6&lt;568::AID-PRAC568&gt;3.0.CO;2-H'">
                                                <xsl:attribute name="xml:lang">en</xsl:attribute>
                                            </xsl:when>
                                            <!-- correction ouzbeck 10.1002/asna.2103030307 -->
                                            <xsl:when test="header/publicationMeta[@level='unit']/doi='10.1111/j.1550-7408.1980.tb04229.x' or header/publicationMeta[@level='unit']/doi='10.1111/j.1365-3180.1990.tb01689.x'or header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030307'or header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030305'">
                                                <xsl:attribute name="xml:lang">de</xsl:attribute>
                                            </xsl:when>
                                            <!-- correction arabe 10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S -->
                                            <xsl:when test="header/publicationMeta[@level='unit']/doi='10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S'">
                                                <xsl:attribute name="xml:lang">es</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang and header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00477.x' ">
                                                <xsl:attribute name="xml:lang">de</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang and header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00484.x'">
                                                <xsl:attribute name="xml:lang">es</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang and header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2007.00453.x'">
                                                <xsl:attribute name="xml:lang">it</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang and header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00459.x'">
                                                <xsl:attribute name="xml:lang">fr</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang ='be'">
                                                <xsl:attribute name="xml:lang">nl</xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="@xml:lang='ka'">
                                                <xsl:choose>
                                                    <xsl:when test="header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00489.x'">
                                                        <xsl:attribute name="xml:lang">it</xsl:attribute>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:attribute name="xml:lang">de</xsl:attribute>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:if test="@xml:lang">
                                                    <xsl:attribute name="xml:lang">
                                                        <xsl:value-of select="translate(@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                                    </xsl:attribute>
                                                </xsl:if>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <!-- redressement des titres vides -->
                                        <xsl:choose>
                                            <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1046/j.1523-1739.1997.0110051265.x'">
                                                <xsl:text>Erratum: Diploid expected heterozygosity and haploid allelic diversity equations misprinted</xsl:text>
                                            </xsl:when>
                                            <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-401X(199809)26:5&lt;253::AID-AHEH253&gt;3.0.CO;2-S'">
                                                <xsl:text>Vertical and Annual Distribution of Ferric and Ferrous Iron in Acid Mining Lakes</xsl:text> 
                                            </xsl:when>
                                            <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-4133(199811)100:11&lt;513::AID-LIPI513&gt;3.0.CO;2-I'">
                                                <xsl:text>Die Bleichung von Speisefetten und Ölen V Aus dem Arbeitskreis "Technologien der industriellen"</xsl:text> 
                                            </xsl:when>
                                            <xsl:when test="//publicationMeta[@level='unit']/doi='10.1111/insr.12044'">
                                                <xsl:text>Table of contents</xsl:text> 
                                            </xsl:when>
                                            <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/sres.2200'">
                                                <xsl:text>Editorial</xsl:text> 
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:choose>
                                                    <xsl:when test="//header/contentMeta/titleGroup/title[@type='main']/citation[@type='book']">
                                                        <xsl:if test="//publicationMeta[@level='unit']/titleGroup/title[@type='articleCategory']">
                                                            <xsl:value-of select="//publicationMeta[@level='unit']/titleGroup/title[@type='articleCategory']"/>
                                                            <xsl:text> - </xsl:text>
                                                        </xsl:if>
                                                        <xsl:choose>
                                                            <xsl:when test="//header/contentMeta/titleGroup/title[@type='tocForm']">
                                                                    <xsl:value-of select="normalize-space(//header/contentMeta/titleGroup/title[@type='tocForm'])"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="normalize-space(//header/contentMeta/titleGroup/title[@type='main']/citation[@type='book']/bookTitle)"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:apply-templates/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </title>
                                </xsl:for-each>
                            </xsl:when>
                        </xsl:choose>
                    </titleStmt>
                    <!-- SG - ajout <enrichedObject> -->
                    <xsl:if test="header/contentMeta/enrichedObjectGroup">
                        <editionStmt>
                            <edition>
                                <xsl:variable name="ana">
                                    <xsl:value-of select="header/contentMeta/enrichedObjectGroup/@type"/>
                                </xsl:variable>
                                <xsl:for-each select="header/contentMeta/enrichedObjectGroup/enrichedObject">
                                    <ref>
                                        <xsl:attribute name="type">
                                            <xsl:value-of select="$ana"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="xml:id">
                                            <xsl:value-of select="@xml:id"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="corresp">
                                            <xsl:value-of select="@associatedDataRef"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">
                                            <xsl:value-of select="mediaResourceGroup/mediaResource/@href"/>
                                        </xsl:attribute>
                                    </ref>
                                </xsl:for-each>
                            </edition>
                        </editionStmt>
                    </xsl:if>
                    <publicationStmt>
						<xsl:if test="header/publicationMeta/publisherInfo/publisherName">
                       	 	<xsl:apply-templates select="header/publicationMeta/publisherInfo/publisherName"/>
						</xsl:if>
						<xsl:if test="not(header/publicationMeta/publisherInfo/publisherName)">
                       	 	<publisher>Wiley Publishing Ltd</publisher>
						</xsl:if>
                        <!-- SG ajout publisherLoc -->
                        <xsl:if test="header/publicationMeta/publisherInfo/publisherLoc">
                            <xsl:apply-templates select="header/publicationMeta/publisherInfo/publisherLoc"/>
                        </xsl:if>
						<xsl:if test="header/publicationMeta/copyright">
							<availability>
							    <!-- SG: ajout licence -->
								<licence>
								    <xsl:apply-templates select="header/publicationMeta[@level='unit']/copyright/text()"/>
								</licence>
							</availability>
						</xsl:if>
						<!-- date -->
						<xsl:if test="header/publicationMeta[@level='part']/coverDate">
							<date type="published">
								<xsl:attribute name="when"><xsl:value-of select="header/publicationMeta[@level='part']/coverDate/@startDate"/></xsl:attribute>
							</date>
						</xsl:if>
                    </publicationStmt>
                    <!-- SG - ajout du codeGenre article et revue -->
                    <notesStmt>
                        <!-- niveau article / chapter -->
                        <note type="content-type">
                            <xsl:value-of select="$codeGenre1"/>
                        </note>
                        <!-- niveau revue / book -->
                        <xsl:choose>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                                <note type="publication-type" subtype="book-series">
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                                <note type="publication-type" subtype="book">
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <note type="publication-type" subtype="journal">
                                    <xsl:text>journal</xsl:text>
                                </note>
                            </xsl:otherwise>
                        </xsl:choose>
                    </notesStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="header" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                
               
                <xsl:if test="header/contentMeta/abstractGroup | header/contentMeta/keywordGroup | header/publicationMeta[@level='unit']/subjectInfo | header/publicationMeta[@level='unit']/titleGroup/title[@type='articleCategory']">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
                        <xsl:if test="header/contentMeta/abstractGroup/abstract">
                            <!-- SG - reprise de tous les abstracts -->
                            <xsl:for-each select="header/contentMeta/abstractGroup/abstract">
                            <abstract>
                                <xsl:choose>
                                    <xsl:when test="@xml:lang[string-length() &gt; 0] | @lang[string-length() &gt; 0]">
                                        <xsl:attribute name="xml:lang">
                                            <xsl:variable name="codeLangue">
                                                <xsl:value-of select="translate(@xml:lang | @lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                                            </xsl:variable>
                                            <!-- correction arabe 10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S au lieu de espagnol -->
                                            <xsl:choose>
                                                <xsl:when test="$codeLangue='ar' and //component/header/publicationMeta[@level='unit']/doi='10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S'">es</xsl:when>
                                                <xsl:when test="$codeLangue='ka' and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00477.x'">de</xsl:when>
                                                <xsl:when test="$codeLangue='ka' and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00484.x'">es</xsl:when>
                                                <xsl:when test="$codeLangue='ka' and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00459.x'">fr</xsl:when>
                                                <xsl:when test="$codeLangue='ka' and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2007.00453.x'">it</xsl:when>
                                                <xsl:when test="$codeLangue='ka' and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00489.x'">it</xsl:when>
                                                <xsl:when test="$codeLangue='ka'">de</xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$codeLangue"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:if test="@type">
                                    <xsl:attribute name="style">
                                        <xsl:value-of select="@type"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="@xml:id">
                                    <xsl:copy-of select="@xml:id"/>
                                </xsl:if>
                                <xsl:apply-templates/>
							</abstract>
                            </xsl:for-each>
		                </xsl:if>
                        <xsl:if test="header/contentMeta/keywordGroup/keyword[string-length()&gt;0]| header/publicationMeta[@level='unit']/subjectInfo[string-length()&gt;0] or 
                            header/publicationMeta[@level='unit']/titleGroup/title[@type][string-length()&gt;0]">
							<textClass>
							    <xsl:if test="header/contentMeta/keywordGroup/keyword[string-length()&gt;0]">
							        <keywords>
							            <!--SG - ajout langue -->
							            <xsl:if test="header/contentMeta/keywordGroup/@xml:lang[string-length()&gt;0]">
							                <xsl:copy-of select="header/contentMeta/keywordGroup/@xml:lang"/>
							            </xsl:if>
							            <xsl:for-each select="header/contentMeta/keywordGroup/keyword">
							                <term>
							                    <xsl:copy-of select="@xml:id"/>
							                    <xsl:apply-templates/>
							                    <!--<xsl:value-of select="normalize-space(.)"/>-->
							                </term>
							            </xsl:for-each>
							        </keywords>
							    </xsl:if>
							    <xsl:if test="header/publicationMeta[@level='unit']/titleGroup/title[string-length()&gt;0]">
							        <xsl:for-each select="header/publicationMeta[@level='unit']/titleGroup/title">
							            <keywords>
							                <xsl:if test="@type">
							                    <xsl:attribute name="rend">
							                        <xsl:value-of select="@type"/>
							                    </xsl:attribute>
							                </xsl:if>
							                <term>
							                <xsl:value-of select="normalize-space(.)"/>
							                </term>
							            </keywords>
							        </xsl:for-each>
							    </xsl:if>
							</textClass>
						</xsl:if>
                        <xsl:if test="header/publicationMeta/subjectInfo/subject !=''">
                            <textClass>
                                <keywords ana="subject">
                                    <xsl:apply-templates select="header/publicationMeta/subjectInfo/*"/>
                                </keywords>
                            </textClass>
                        </xsl:if>
                        <xsl:if test="$codeLangue">
                        <langUsage>
                            <language>
                                <xsl:attribute name="ident">
                                    <xsl:value-of select="$codeLangue"/>
                                </xsl:attribute>
                            </language>
                        </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="front/article-meta/history">
                    <xsl:apply-templates select="front/article-meta/history"/>
                </xsl:if>
            </teiHeader>
            <text>
                <!-- No test if made for body since it is considered a mandatory element -->
                <!-- SG test sur body si vide information minimale à reporter pour validation TEI -->
                <xsl:choose>
                    <xsl:when test="body/p">
                        <body>
                            <xsl:apply-templates select="body" mode="bodyOnly"/>
                        </body>
                    </xsl:when>
                    <!-- SG ajout du niveau section -->
                    <xsl:when test="body/section">
                        <body>
                            <xsl:apply-templates select="body" mode="bodyOnly"/>
                        </body>
                    </xsl:when>
                    <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                        <body>
                            <div>
                                <p><xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/></p>
                            </div>
                        </body>
                    </xsl:when>
                    <xsl:otherwise>
                        <body><div><p/></div></body>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="body/bibliography|header/noteGroup/note|body/noteGroup/note|header/contentMeta/titleGroup/title/citation">
                    <back>
                        <!-- note de bas de page -->
                        <xsl:if test="header/noteGroup/note">
                            <div type="fn-group">
                            <xsl:apply-templates select="header/noteGroup/note"/>
                            </div>
                        </xsl:if>
                        <xsl:if test="body/noteGroup/note">
                            <div type="fn-group">
                            <xsl:apply-templates select="body/noteGroup/note"/>
                            </div>
                        </xsl:if>
                        <xsl:apply-templates select="body/bibliography"/>
                        <xsl:apply-templates select="header/contentMeta/supportingInformation"/>
                        <xsl:apply-templates select="header/contentMeta/titleGroup/title/citation"/>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>
    <xsl:template match="header/contentMeta/abstractGroup/abstract/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    <xsl:template match="header/contentMeta/abstractGroup/abstract/p">
        <p>
            <xsl:if test="@xml:id">
                <xsl:copy-of select="@xml:id"/>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="header/contentMeta/abstractGroup/abstract/p/infoAsset">
            <term>
                <xsl:if test="@type">
                    <xsl:attribute name="type">
                        <xsl:value-of select="translate(@type,' ','_')"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@xml:id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </term>
    </xsl:template>
    
    <xsl:template match="abstractGroup/abstract/p/i">
        <xsl:if test="normalize-space(.)"><hi rend="italic"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>
    
    <xsl:template match="abstractGroup/abstract/p/bold">
        <xsl:if test="normalize-space(.)"><hi rend="bold"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>
  

	<!-- SG - abstract content - mis de coté pour le moment / attente validation TEI board -->
	<!--<xsl:template match="/component/header/contentMeta/abstractGroup/abstract/p"> 
        <xsl:choose>
            <xsl:when test="b">
				<div>
					<head><xsl:value-of select="b/text()"/></head>
					<p><xsl:value-of select="text()"/></p>
				</div>
			</xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="p"/>
            </xsl:otherwise>
        </xsl:choose>
	</xsl:template>-->
	
    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="header" mode="sourceDesc">
        <biblStruct>
            <!-- Genre     -->
            <xsl:if test="publicationMeta[@level='unit']/@type[string-length()&gt; 0]">
                <xsl:attribute name="type">
                    <xsl:value-of select="normalize-space($codeGenre1)"/>
                </xsl:attribute>
            </xsl:if>
            <analytic>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="contentMeta/titleGroup"/>
				
                <!-- All authors are included here -->
				<xsl:if test="contentMeta/creators">
					<xsl:apply-templates select="contentMeta/creators"/>
				</xsl:if>
                
                <xsl:apply-templates select="publicationMeta[@level='unit']/doi"/>
                <xsl:apply-templates select="publicationMeta[@level='unit']/idGroup/id"/>
                <xsl:apply-templates select="publicationMeta[@level='unit']/linkGroup/link"/>
            </analytic>
            <monogr>
                <xsl:choose>
                    <xsl:when test="publicationMeta[@level='part']/creators/creator">
                        <xsl:apply-templates select="publicationMeta[@level='part']/creators"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="publicationMeta[@level='product']/titleGroup/title[@type ='main']">
                        <title level="j" type="main">
                            <xsl:value-of select="publicationMeta[@level='product']/titleGroup/title[@type ='main']"/>
                        </title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title level="j" type="main">
                            <xsl:value-of select="publicationMeta[@level='product']/titleGroup/title"/>
                        </title>
                    </xsl:otherwise>
                </xsl:choose>
                <!-- SG ajout titre alternatif -->
                <xsl:if test="publicationMeta[@level='part']/titleGroup/title/@type ='specialIssueTitle'">
                    <title level="j" type="sub">
                        <xsl:value-of select="normalize-space(publicationMeta[@level='part']/titleGroup/title[@type ='specialIssueTitle'])"/>
                    </title>
                </xsl:if>
                <!-- SG ajout titre specialIssue -->
                <xsl:if test="publicationMeta[@level='product']/titleGroup/title/@sort !=''">
                    <title level="j" type="alt">
                        <xsl:apply-templates select="publicationMeta[@level='product']/titleGroup/title/@sort"/>
                    </title>
                </xsl:if>
               
                <xsl:apply-templates select="publicationMeta[@level='product']/issn"/>
                <xsl:apply-templates select="publicationMeta[@level='product']/doi"/>
                <xsl:apply-templates select="publicationMeta[@level='part']/doi"/>
                <xsl:apply-templates select="publicationMeta[@level='product']/idGroup/id"/>
                <imprint>
	                <xsl:apply-templates select="publicationMeta[@level='part']/numberingGroup/numbering[@type='journalVolume']"/>
	                <xsl:apply-templates select="publicationMeta[@level='part']/numberingGroup/numbering[@type='journalIssue']"/>
					
	                <xsl:apply-templates select="publicationMeta[@level='unit']/numberingGroup/numbering[@type='pageFirst']"/>
	                <xsl:apply-templates select="publicationMeta[@level='unit']/numberingGroup/numbering[@type='pageLast']"/>
                    <!-- SG - ajout nombre de pages -->
                    <xsl:apply-templates select="publicationMeta[@level='unit']/countGroup/count[@type='pageTotal']"/>
					
					<xsl:if test="publicationMeta/publisherInfo/publisherName">
                   	 	<xsl:apply-templates select="publicationMeta/publisherInfo/publisherName"/>
					</xsl:if>
                    <!-- SG ajout publisherLoc -->
                    <xsl:if test="publicationMeta/publisherInfo/publisherLoc">
                        <xsl:apply-templates select="publicationMeta/publisherInfo/publisherLoc"/>
                    </xsl:if>
					
					<xsl:if test="publicationMeta[@level='part']/coverDate">
						<date type="published">
							<xsl:attribute name="when"><xsl:value-of select="publicationMeta[@level='part']/coverDate/@startDate"/></xsl:attribute>
						</date>
					</xsl:if>
                </imprint>
            </monogr>
            <xsl:apply-templates select="article-meta/article-id"/>
        </biblStruct>
    </xsl:template>

	<!-- title group -->
	<xsl:template match="titleGroup">
		    <xsl:choose>
		        <xsl:when test="//header/contentMeta/titleGroup/title">
		            <xsl:for-each select="//header/contentMeta/titleGroup/title[@type='main']">
		                <title level="a" type="main">
		                    <xsl:choose>
		                        <xsl:when test="//component/header/publicationMeta/issn[@type='print']='0378-5599'">
		                            <xsl:attribute name="xml:lang">fr</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="//component/header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1099-0682(199809)1998:9&lt;1205::AID-EJIC1205&gt;3.0.CO;2-F' or //component/header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199910)341:7&lt;657::AID-PRAC657&gt;3.0.CO;2-P'or //component/header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-3897(199908)341:6&lt;568::AID-PRAC568&gt;3.0.CO;2-H'">
		                            <xsl:attribute name="xml:lang">en</xsl:attribute>
		                        </xsl:when>
		                        <!-- correction ouzbeck 10.1002/asna.2103030307 -->
		                        <xsl:when test="//component/header/publicationMeta[@level='unit']/doi='10.1111/j.1550-7408.1980.tb04229.x' or //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1365-3180.1990.tb01689.x'or //component/header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030307'or //component/header/publicationMeta[@level='unit']/doi='10.1002/asna.2103030305'">
		                            <xsl:attribute name="xml:lang">de</xsl:attribute>
		                        </xsl:when>
		                        <!-- correction arabe 10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S -->
		                        <xsl:when test="//component/header/publicationMeta[@level='unit']/doi='10.1002/1522-239X(200210)113:5/6&lt;342::AID-FEDR342&gt;3.0.CO;2-S'">
		                            <xsl:attribute name="xml:lang">es</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00477.x' ">
		                            <xsl:attribute name="xml:lang">de</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00484.x'">
		                            <xsl:attribute name="xml:lang">es</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2007.00453.x'">
		                            <xsl:attribute name="xml:lang">it</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang and //component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00459.x'">
		                            <xsl:attribute name="xml:lang">fr</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang ='be'">
		                            <xsl:attribute name="xml:lang">nl</xsl:attribute>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang='ka'">
		                            <xsl:choose>
		                                <xsl:when test="//component/header/publicationMeta[@level='unit']/doi='10.1111/j.1439-0469.2008.00489.x'">
		                                    <xsl:attribute name="xml:lang">it</xsl:attribute>
		                                </xsl:when>
		                                <xsl:otherwise>
		                                    <xsl:attribute name="xml:lang">de</xsl:attribute>
		                                </xsl:otherwise>
		                            </xsl:choose>
		                        </xsl:when>
		                        <xsl:when test="@xml:lang">
		                            <xsl:attribute name="xml:lang">
		                                <xsl:value-of select="translate(@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
		                            </xsl:attribute>
		                        </xsl:when>
		                        <xsl:otherwise>
		                            <xsl:if test="@xml:lang">
		                                <xsl:attribute name="xml:lang">
		                                    <xsl:value-of select="translate(@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
		                                </xsl:attribute>
		                            </xsl:if>
		                        </xsl:otherwise>
		                    </xsl:choose>
		                    <!-- redressement des titres vides -->
		                    <xsl:choose>
		                        <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1046/j.1523-1739.1997.0110051265.x'">
		                            <xsl:text>Erratum: Diploid expected heterozygosity and haploid allelic diversity equations misprinted</xsl:text>
		                        </xsl:when>
		                        <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-401X(199809)26:5&lt;253::AID-AHEH253&gt;3.0.CO;2-S'">
		                            <xsl:text>Vertical and Annual Distribution of Ferric and Ferrous Iron in Acid Mining Lakes</xsl:text> 
		                        </xsl:when>
		                        <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/(SICI)1521-4133(199811)100:11&lt;513::AID-LIPI513&gt;3.0.CO;2-I'">
		                            <xsl:text>Die Bleichung von Speisefetten und Ölen V Aus dem Arbeitskreis "Technologien der industriellen"</xsl:text> 
		                        </xsl:when>
		                        <xsl:when test="//publicationMeta[@level='unit']/doi='10.1111/insr.12044'">
		                            <xsl:text>Table of contents</xsl:text> 
		                        </xsl:when>
		                        <xsl:when test="//header/publicationMeta[@level='unit']/doi='10.1002/sres.2200'">
		                            <xsl:text>Editorial</xsl:text> 
		                        </xsl:when>
		                        <xsl:otherwise>
		                            <xsl:choose>
		                                <xsl:when test="//header/contentMeta/titleGroup/title[@type='main']/citation[@type='book']">
		                                    <xsl:if test="//publicationMeta[@level='unit']/titleGroup/title[@type='articleCategory']">
		                                        <xsl:value-of select="//publicationMeta[@level='unit']/titleGroup/title[@type='articleCategory']"/>
		                                        <xsl:text> - </xsl:text>
		                                    </xsl:if>
		                                    <xsl:choose>
		                                        <xsl:when test="//header/contentMeta/titleGroup/title[@type='tocForm']">
		                                            <xsl:value-of select="normalize-space(//header/contentMeta/titleGroup/title[@type='tocForm'])"/>
		                                        </xsl:when>
		                                        <xsl:otherwise>
		                                            <xsl:value-of select="normalize-space(//header/contentMeta/titleGroup/title[@type='main']/citation[@type='book']/bookTitle)"/>
		                                        </xsl:otherwise>
		                                    </xsl:choose>
		                                </xsl:when>
		                                <xsl:otherwise>
		                                    <xsl:apply-templates/>
		                                </xsl:otherwise>
		                            </xsl:choose>
		                        </xsl:otherwise>
		                    </xsl:choose>
		                </title>
		            </xsl:for-each>
		        </xsl:when>
		    </xsl:choose>
		
	    <!-- SG - ajout conditionnel -->
	    <xsl:if test="title[@type='subtitle']">
	        <title level= "a" type="sub">
	            <!-- SG - ajout de la langue du titre -->
	            <xsl:if test="title[@type='subtitle']/@xml:lang">
	                <xsl:attribute name="xml:lang">
	                    <xsl:value-of select="title[@type='short']/@xml:lang"/>
	                </xsl:attribute>
	            </xsl:if>
	            <xsl:value-of select="title[@type='subtitle']"/>
	        </title>
	    </xsl:if>
	    <xsl:if test="title[@type='short']">
	        <title level= "a" type="short">
	            <!-- SG - ajout de la langue du titre -->
	            <xsl:if test="title[@type='short']/@xml:lang">
	                <xsl:attribute name="xml:lang">
	                    <xsl:value-of select="title[@type='short']/@xml:lang"/>
	                </xsl:attribute>
	            </xsl:if>
	            <xsl:value-of select="title[@type='short']"/>
	        </title>
	    </xsl:if>
	</xsl:template>
 
 	<!-- Body content -->
    <xsl:template match="body" mode="bodyOnly">
        <xsl:apply-templates select="section"/>
		<!--<xsl:apply-templates select="//noteGroup"/>-->
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

	<xsl:template match="creators">
		 <xsl:apply-templates select="creator"/>
	</xsl:template>

    <!-- author related information -->
    <xsl:template match="creator">
        <xsl:choose>
            <xsl:when test="@creatorRole='author'">
        <author>
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
        <xsl:choose>
            <xsl:when test="@creatorRole='author'">
                <!-- SG - ajout de @corresponding et @noteRef -->
                    <xsl:if test="@corresponding='yes'">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                <xsl:apply-templates select="* except email | * except biographyInfo"/>
                    <xsl:if test="//affiliationGroup">
                        <xsl:call-template name="affiliation"/>
                    </xsl:if>
                <xsl:if test="@corresponding='yes'">
                    <xsl:call-template name="affiliationCorresp"/>
                </xsl:if>
            </xsl:when>
            <!-- ajout SG si pas d'@creatorRole  -->
            <xsl:otherwise>
                    <xsl:if test="@corresponding='yes'">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>	
                    <xsl:apply-templates/>
                    <xsl:if test="//affiliationGroup">
                        <xsl:call-template name="affiliation"/>
                    </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        </author>
            </xsl:when>
            <xsl:when test="@creatorRole='editor' or @creatorRole='sponsoringEditor'">
                <editor>
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="i" select="position()-1"/>
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
                    </xsl:attribute>
                    <xsl:apply-templates/>
                    <!-- affiliation -->
                    <xsl:if test="../aff">
                        <xsl:apply-templates select="../aff" mode="sourceDesc"/>
                    </xsl:if>
                </editor>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="affiliation">	
		<xsl:if test="unparsedAffiliation">
	        <affiliation>
	            <!-- 
	        	<xsl:value-of select="unparsedAffiliation/text()"/>
				<xsl:if test="@countryCode">
					<address>
						<country>
				            <xsl:attribute name="key">
				                <xsl:value-of select="@countryCode"/>
				            </xsl:attribute>
						</country>
					</address>
				</xsl:if>-->
	        </affiliation>
		</xsl:if> 
        <xsl:if test="orgName | orgDiv">
            <affiliation>
                <xsl:if test="orgDiv">
                    <orgName type="division">
                        <xsl:value-of select="orgDiv/text()"/>
                    </orgName>
                </xsl:if>
                <xsl:if test="orgName">
                    <orgName>
                        <xsl:value-of select="orgName/text()"/>
                    </orgName>
                </xsl:if>
                <xsl:if test="@countryCode">
                    <address>
                        <xsl:if test="address/city">
                            <settlement type="city">
                                <xsl:value-of select="address/city/text()"/>
                            </settlement>
                        </xsl:if>
                        <xsl:if test="address/postCode">
                            <postCode type="city">
                                <xsl:value-of select="address/postCode/text()"/>
                            </postCode>
                        </xsl:if>
						<country>
				            <xsl:attribute name="key">
				                <xsl:value-of select="@countryCode"/>
				            </xsl:attribute>
						</country>
					</address>
                </xsl:if>
            </affiliation>
        </xsl:if>	
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
	
    <xsl:template match="aff" mode="sourceDesc">
        <affiliation>
			<xsl:value-of select="."/>
        </affiliation>
    </xsl:template>

    <!-- Copyright related information to appear in <publicationStmt> -->
    <xsl:template match="copyright-statement">
        <availability>
            <p>
                <xsl:apply-templates/>
            </p>
        </availability>
    </xsl:template>

    <xsl:template match="license/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="pub-date">
        <date>
            <xsl:choose>
                <xsl:when test="@pub-type='epub'">
                    <xsl:attribute name="type">e-published</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type">published</xsl:attribute>
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

	<!-- Structure a note block-->
    <xsl:template match="noteGroup">
        <xsl:apply-templates select="note"/>
    </xsl:template>
	
    <xsl:template match="header/noteGroup/note">
        <note place="inline">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
		    <xsl:if test="label">
		        <label>
		            <xsl:value-of select="label"/>
		        </label>
		    </xsl:if>
        	<xsl:apply-templates/>
		</note>
    </xsl:template>
    <xsl:template match="body/noteGroup/note">
        <note place="inline">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:if test="label">
                <label>
                    <xsl:value-of select="label"/>
                </label>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    
    <!-- SG - reprise traitement des affiliations multiples -->
    <!-- Traitement de plusieurs affiliations dans 1 seul attribut "@affiliationRef" ex: "#ffj3188-aff-0001 #ffj3188-aff-0002" -->
    <xsl:template name="affiliation">
        <xsl:choose>
            <xsl:when test="@affiliationRef">
                <xsl:call-template name="tokenize"/>
                <xsl:call-template name="tokenizeCor"/>
                <xsl:call-template name="tokenizeCur"/>
                <xsl:call-template name="tokenizeNot"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="not(//creator/@affiliationRef) and //creator/@xml:id[string-length() &gt; 0 ] and //affiliation/@xml:id[string-length() &gt; 0 ]">
                        <xsl:call-template name="affiliationLienRompu"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="not(//creator/@affiliationRef)">
                            <xsl:call-template name="affiliation2"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@affiliationRef" name="tokenize">
        <xsl:param name="text" select="@affiliationRef"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="aff">
                    <xsl:value-of select="translate($text,'#','')"/>
                </xsl:variable>
                <xsl:if test="normalize-space(//affiliation[@xml:id=$aff])">
                    <affiliation>
                        <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:call-template name="wileyParseAffiliation"></xsl:call-template>
                          <!--  <xsl:value-of select="normalize-space(//affiliation[@xml:id=$aff]/unparsedAffiliation)"/>-->
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                                <orgName type="division">
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                                <orgName>
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                            <address>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                <street>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                </street>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                <settlement type="city">
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                </settlement>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                <postCode>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                </postCode>
                                    </xsl:if>
                                 <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                <state>
                                    <p>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                    </p>
                                </state>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                <region>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                </region>
                                    </xsl:if>
                               <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
						<country>
						    <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
						        <xsl:attribute name="key">
						            <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]"/>
						        </xsl:attribute>
						    </xsl:if>
						    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                    </xsl:if>
						</country>
                        </xsl:if>
                            </address>
                        </xsl:if>
                    </affiliation>
                </xsl:if>
                <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation/email[string-length() &gt; 0 ]">
                   <email>
                       <xsl:value-of select="//affiliation[@xml:id=$aff]/unparsedAffiliation/email"/>
                   </email> 
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'#','')"/>
                    </xsl:variable>
                    <xsl:variable name="aff">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    
                    
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                            <orgName type="division">
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                            <orgName>
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                        <address>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                <street>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                </street>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                <settlement type="city">
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                </settlement>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                <postCode>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                </postCode>
                                    </xsl:if>
                                 <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                <state>
                                    <p>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                    </p>
                                </state>
                                    </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                <region>
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                </region>
                                    </xsl:if>
                               <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
						<country>
						    <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]">
				            <xsl:attribute name="key">
				                <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
				            </xsl:attribute>
						        </xsl:if>
						    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                    </xsl:if>
						</country>
                        </xsl:if>
                            </address>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:call-template name="wileyParseAffiliation"/>
                            <!--<xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>-->
                       <!-- <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                                    </address>
                        </xsl:if>-->
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="@correspondenceRef" name="tokenizeCor">
        <xsl:param name="text" select="@correspondenceRef"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="aff">
                    <xsl:value-of select="translate($text,'#','')"/>
                </xsl:variable>
                <xsl:if test="normalize-space(//affiliation[@xml:id=$aff])">
                    <affiliation>
                        <xsl:text>Correspondence address: </xsl:text>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                                <orgName type="division">
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                                <orgName>
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                            <address>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                    <street>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                    </street>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                    <settlement type="city">
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                    </settlement>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                    <postCode>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                    </postCode>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                    <state>
                                        <p>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                        </p>
                                    </state>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                    <region>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                    </region>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <country>
                                        <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                            <xsl:attribute name="key">
                                                <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                        </xsl:if>
                                    </country>
                                </xsl:if>
                            </address>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:call-template name="wileyParseAffiliation"/>
                            <!--  <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                <address>
                                    <country>
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </country>
                                </address>
                            </xsl:if>-->
                        </xsl:if>
                    </affiliation>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:text>Correspondence address: </xsl:text>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'#','')"/>
                    </xsl:variable>
                    <xsl:variable name="aff">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                            <orgName type="division">
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                            <orgName>
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                        <address>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                <street>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                </street>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                <settlement type="city">
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                </settlement>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                <postCode>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                </postCode>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                <state>
                                    <p>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                    </p>
                                </state>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                <region>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                </region>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <country>
                                    <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]">
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                    </xsl:if>
                                </country>
                            </xsl:if>
                        </address>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:call-template name="wileyParseAffiliation"/>
                        <!-- <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                            </address>
                        </xsl:if>-->
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenizeCor">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@currentRef" name="tokenizeCur">
        <xsl:param name="text" select="@currentRef"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="aff">
                    <xsl:value-of select="translate($text,'#','')"/>
                </xsl:variable>
                <xsl:if test="//affiliation[@xml:id=$aff]">
                    <affiliation>
                        <xsl:text>Current Address: </xsl:text>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                                <orgName type="division">
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                                <orgName>
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                            <address>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                    <street>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                    </street>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                    <settlement type="city">
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                    </settlement>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                    <postCode>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                    </postCode>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                    <state>
                                        <p>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                        </p>
                                    </state>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                    <region>
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                    </region>
                                </xsl:if>
                                <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <country>
                                        <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                            <xsl:attribute name="key">
                                                <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                        </xsl:if>
                                    </country>
                                </xsl:if>
                            </address>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:call-template name="wileyParseAffiliation"/>
                            <!--<xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                <address>
                                    <country>
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </country>
                                </address>
                            </xsl:if>-->
                        </xsl:if>
                    </affiliation>
                </xsl:if>
                <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation/email[string-length() &gt; 0 ]">
                    <email>
                        <xsl:value-of select="//affiliation[@xml:id=$aff]/unparsedAffiliation/email"/>
                    </email> 
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:text>Current Address: </xsl:text>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'#','')"/>
                    </xsl:variable>
                    <xsl:variable name="aff">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                            <orgName type="division">
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName/text()">
                            <orgName>
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart | //affiliation[@xml:id=$aff]/address/postCode | //affiliation[@xml:id=$aff]/address/city | //affiliation[@xml:id=$aff]/address/state | //affiliation[@xml:id=$aff]/address/country">
                        <address>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                                <street>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street/text()"/>   
                                </street>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                                <settlement type="city">
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city/text()"/>   
                                </settlement>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                                <postCode>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode/text()"/>   
                                </postCode>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                                <state>
                                    <p>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
                                    </p>
                                </state>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                <region>
                                    <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart/text()"/>   
                                </region>
                            </xsl:if>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode | //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <country>
                                    <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]">
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country/text()"/>
                                    </xsl:if>
                                </country>
                            </xsl:if>
                        </address>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:call-template name="wileyParseAffiliation"/>
                        <!-- <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                            </address>
                        </xsl:if>-->
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenizeCur">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--<xsl:variable name="cor" select="translate(@correspondenceRef,'#','')"/>
    <xsl:variable name="cur" select="translate(@currentRef ,'#','')"/>
    <xsl:variable name="not" select="translate(@noteRef ,'#','')"/>-->
    <xsl:template match="@xml:id" name="tokenize2">
        <xsl:param name="text" select="@xml:id"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="aff">
                    <xsl:value-of select="translate($text,'cr','')"/>
                </xsl:variable>
                <xsl:if test="normalize-space(//affiliation[translate(@xml:id,'aff-1-','')=$aff])">
                    <affiliation>
                        <xsl:if test="//affiliation[translate(@xml:id,'aff-1-','')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[translate(@xml:id,'aff-1-','')=$aff]/unparsedAffiliation"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                        </xsl:if>
                    </affiliation>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'cr','')"/>
                    </xsl:variable>
                    <xsl:variable name="aff">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    <xsl:if test="//affiliation[translate(@xml:id,'aff-1-','')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[translate(@xml:id,'aff-1-','')=$aff]/unparsedAffiliation"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--janvier 2016 probleme de liens incorrectes dans notices-->
    <xsl:template name="affiliationLienRompu">
        <xsl:choose>
            <xsl:when test="@xml:id">
                <affiliation> 
                    <xsl:if test="//affiliation/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation/orgDiv">
                            <orgName type="division">
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation/orgName">
                            <orgName>
                                <xsl:apply-templates select="."/>
                            </orgName>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation/address/countryPart[string-length() &gt; 0 ]
                        | //affiliation/address/postCode[string-length() &gt; 0 ] | //affiliation/address/city[string-length() &gt; 0 ]| //affiliation/address/state[string-length() &gt; 0 ]| //affiliation/address/country[string-length() &gt; 0 ]">
                        <address>
                            <xsl:if test="//affiliation/address/street[string-length() &gt; 0 ]">
                                <street>
                                    <xsl:apply-templates select="//affiliation/address/street/text()"/>   
                                </street>
                            </xsl:if>
                            <xsl:if test="//affiliation/address/city[string-length() &gt; 0 ]">
                                <settlement type="city">
                                    <xsl:apply-templates select="//affiliation/address/city/text()"/>   
                                </settlement>
                            </xsl:if>
                            <xsl:if test="//affiliation/address/postCode[string-length() &gt; 0 ]">
                                <postCode>
                                    <xsl:apply-templates select="//affiliationv/address/postCode/text()"/>   
                                </postCode>
                            </xsl:if>
                            <xsl:if test="//affiliation/address/state[string-length() &gt; 0 ]">
                                <state>
                                    <p>
                                    <xsl:apply-templates select="//affiliation/address/state/text()"/>   
                                    </p>
                                </state>
                            </xsl:if>
                            <xsl:if test="//affiliation/address/countryPart[string-length() &gt; 0 ]">
                                <region>
                                    <xsl:apply-templates select="//affiliation/address/countryPart/text()"/>   
                                </region>
                            </xsl:if>
                            <xsl:if test="//affiliation/@countryCode | //affiliation/address/country[string-length() &gt; 0 ]">
                                <country>
                                    <xsl:if test="//affiliation/@countryCode">
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation/@countryCode[string-length() &gt; 0 ]"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="//affiliation/address/country[string-length() &gt; 0 ]">
                                        <xsl:apply-templates select="//affiliation/address/country/text()"/>
                                    </xsl:if>
                                </country>
                            </xsl:if>
                        </address>
                    </xsl:if>
                    <xsl:if test="//affiliation/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:apply-templates select="//affiliation/unparsedAffiliation/text()"/>
                        <xsl:if test="//affiliation/@countryCode">
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                            </address>
                        </xsl:if>
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenizeLien"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@xml:id" name="tokenizeLien">
        <xsl:param name="text" select="@xml:id"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="aff">
                    <xsl:value-of select="translate($text,'cr','')"/>
                </xsl:variable>
                <xsl:if test="normalize-space(//affiliation[substring-after(@xml:id,'aff-1-')=$aff])">
                    <affiliation>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv">
                                <orgName type="division">
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName">
                                <orgName>
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                            | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <address>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ]">
                                    <street>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street/text()"/>   
                                    </street>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]">
                                    <settlement type="city">
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city/text()"/>   
                                    </settlement>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ]">
                                    <postCode>
                                        <xsl:apply-templates select="//affiliationv/address/postCode/text()"/>   
                                    </postCode>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]">
                                    <state>
                                        <p>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state/text()"/>   
                                        </p>
                                    </state>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                    <region>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart/text()"/>   
                                    </region>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                    <country>
                                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode">
                                            <xsl:attribute name="key">
                                                <xsl:value-of select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode[string-length() &gt; 0 ]"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country/text()"/>
                                        </xsl:if>
                                    </country>
                                </xsl:if>
                            </address>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation/text()"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode">
                                <address>
                                    <country>
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </country>
                                </address>
                            </xsl:if>
                        </xsl:if>
                    </affiliation>
                </xsl:if>
                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation/email[string-length() &gt; 0 ]">
                    <email>
                        <xsl:value-of select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation/email"/>
                    </email> 
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'cr','')"/>
                    </xsl:variable>
                    <xsl:variable name="aff">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv/text()">
                            <orgName type="division">
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName/text()">
                                <orgName>
                                    <xsl:apply-templates select="."/>
                                </orgName>
                            </xsl:for-each>
                        </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country">
                            <address>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ]">
                                    <street>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street/text()"/>   
                                    </street>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]">
                                    <settlement type="city">
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city/text()"/>   
                                    </settlement>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ]">
                                    <postCode>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode/text()"/>   
                                    </postCode>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]">
                                    <state>
                                        <p>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state/text()"/>   
                                        </p>
                                    </state>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]">
                                    <region>
                                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart/text()"/>   
                                    </region>
                                </xsl:if>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                    <country>
                                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode[string-length() &gt; 0 ]">
                                            <xsl:attribute name="key">
                                                <xsl:value-of select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country/text()"/>
                                        </xsl:if>
                                    </country>
                                </xsl:if>
                            </address>
                        </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation/text()"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode">
                                <address>
                                    <country>
                                        <xsl:attribute name="key">
                                            <xsl:value-of select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/@countryCode"/>
                                        </xsl:attribute>
                                    </country>
                                </address>
                            </xsl:if>
                        </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenizeLien">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="affiliation2">
        <xsl:for-each select="//affiliation">
            <affiliation>
                <xsl:if test="orgDiv[string-length() &gt; 0 ]">
                    <xsl:for-each select="orgDiv">
                        <orgName type="division">
                        <xsl:value-of select="normalize-space(.)"/>
                        </orgName>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="orgName[string-length() &gt; 0 ]">
                    <xsl:for-each select="orgName">
                        <orgName>
                            <xsl:value-of select="normalize-space(.)"/>
                        </orgName>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="address/street[string-length() &gt; 0 ] | address/countryPart[string-length() &gt; 0 ] | address/postCode[string-length() &gt; 0 ] | address/city |address/state[string-length() &gt; 0 ] | address/country[string-length() &gt; 0 ]">
                    <address>
                        <xsl:if test="address/street[string-length() &gt; 0 ]">
                            <street>
                                <xsl:apply-templates select="address/street/text()"/>   
                            </street>
                        </xsl:if>
                        <xsl:if test="address/city[string-length() &gt; 0 ]">
                            <settlement type="city">
                                <xsl:apply-templates select="address/city/text()"/>   
                            </settlement>
                        </xsl:if>
                        <xsl:if test="address/postCode[string-length() &gt; 0 ]">
                            <postCode>
                                <xsl:apply-templates select="address/postCode/text()"/>   
                            </postCode>
                        </xsl:if>
                        <xsl:if test="address/state[string-length() &gt; 0 ]">
                            <state>
                                <p>
                                <xsl:apply-templates select="address/state/text()"/>   
                                </p>
                            </state>
                        </xsl:if>
                        <xsl:if test="address/countryPart[string-length() &gt; 0 ]">
                            <region>
                                <xsl:apply-templates select="address/countryPart/text()"/>   
                            </region>
                        </xsl:if>
                        <xsl:if test="@countryCode | address/country[string-length() &gt; 0 ]">
                            <country>
                                <xsl:if test="@countryCode">
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="@countryCode[string-length() &gt; 0 ]"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="address/country[string-length() &gt; 0 ]">
                                    <xsl:apply-templates select="address/country/text()"/>
                                </xsl:if>
                            </country>
                        </xsl:if>
                    </address>
                </xsl:if>
                <xsl:if test="unparsedAffiliation[string-length() &gt; 0 ]">
                    <xsl:apply-templates select="unparsedAffiliation/text()"/>
                    <xsl:if test="@countryCode">
                        <address>
                            <country>
                                <xsl:attribute name="key">
                                    <xsl:value-of select="@countryCode"/>
                                </xsl:attribute>
                            </country>
                        </address>
                    </xsl:if>
                </xsl:if>
            </affiliation>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="@noteRef" name="tokenizeNot">
        <xsl:param name="text" select="@noteRef"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:variable name="note">
                    <xsl:value-of select="translate($text,'#','')"/>
                </xsl:variable>
                    <xsl:if test="//noteGroup/note[@xml:id=$note][string-length() &gt; 0 ]">
                        <xsl:for-each select="//noteGroup/note[@xml:id=$note]">
                            <note type="foot">
                                <xsl:value-of select="p"/>
                            </note>
                            <xsl:if test="p/email">
                                <email>
                                    <xsl:value-of select="p/email"/>
                                </email>  
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <affiliation>
                    <xsl:text>Note: </xsl:text>
                    <xsl:variable name="translate">
                        <xsl:value-of select="translate($text,'#','')"/>
                    </xsl:variable>
                    <xsl:variable name="note">
                        <xsl:value-of select="normalize-space(substring-before($translate, $separator))"/>
                    </xsl:variable>
                    <xsl:if test="//noteGroup/note[@xml:id=$note][string-length() &gt; 0 ]">
                        <xsl:for-each select="//noteGroup/note[@xml:id=$note]">
                            <xsl:variable name="noteRef">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($noteRef)"/>
                        </xsl:for-each>
                    </xsl:if>
                </affiliation>
                <xsl:call-template name="tokenizeNot">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="affiliationCorresp">
        <affiliation role="corresp">
            <xsl:value-of select="normalize-space(//correspondenceTo)"/>
        </affiliation>
    </xsl:template>
    <xsl:template match="subjectInfo">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="subject">
        <term>
            <xsl:attribute name="ref">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </term>
    </xsl:template>
    <xsl:template match="unparsedAffiliation" name="wileyParseAffiliation">
        <xsl:param name="text" select="@affiliationRef"/>
        <xsl:variable name="aff">
            <xsl:value-of select="translate($text,'#','')"/>
        </xsl:variable>
                <xsl:call-template name="WileyParseAffiliation2">
                    <xsl:with-param name="theAffil">
                        <xsl:value-of select="//affiliation[@xml:id=$aff]/unparsedAffiliation"/>
                    </xsl:with-param>
                </xsl:call-template>
    </xsl:template>
    <xsl:template name="WileyParseAffiliation2">
        <xsl:param name="text" select="@affiliationRef"/>
        <xsl:param name="theAffil"/>
        <xsl:param name="inAddress" select="false()"/>
        <xsl:variable name="aff">
            <xsl:value-of select="translate($text,'#','')"/>
        </xsl:variable>
        <!--xsl:for-each select="$theAffil">
            <xsl:message>Un bout: <xsl:value-of select="."/></xsl:message>
        </xsl:for-each-->
        <xsl:variable name="avantVirgule">
            <xsl:choose>
                <xsl:when test="contains($theAffil,',')">
                    <xsl:value-of select="normalize-space(substring-before($theAffil,','))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($theAffil)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="apresVirgule">
            <xsl:choose>
                <xsl:when test="contains($theAffil,',')">
                    <xsl:value-of select="normalize-space(substring-after($theAffil,','))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="testOrganisation">
            <xsl:call-template name="identifyOrgLevel">
                <xsl:with-param name="theOrg">
                    <xsl:value-of select="$avantVirgule"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($inAddress)">
                <xsl:choose>
                    <xsl:when test="$testOrganisation!=''">
                        <orgName>
                            <xsl:attribute name="type">
                                <xsl:value-of select="$testOrganisation"/>
                            </xsl:attribute>
                            <xsl:value-of select="$avantVirgule"/>
                        </orgName>
                        <xsl:if test="$apresVirgule !=''">
                            <xsl:call-template name="WileyParseAffiliation2">
                                <xsl:with-param name="theAffil" select="$apresVirgule"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <address>
                            <xsl:call-template name="WileyParseAffiliation2">
                                <xsl:with-param name="theAffil" select="$theAffil"/>
                                <xsl:with-param name="inAddress" select="true()"/>
                            </xsl:call-template>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode[string-length() &gt; 0 ]"/>
                                    </xsl:attribute>
                                </country>
                            </xsl:if>
                        </address>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="testCountry">
                    <xsl:call-template name="normalizeISOCountry">
                        <xsl:with-param name="country" select="$avantVirgule"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$testCountry != ''">
                        <country>
                            <xsl:choose>
                                <xsl:when test="//ce:doi='10.1016/S0735-1097(98)00474-4'">
                                    <xsl:attribute name="key">
                                        <xsl:text>UK</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>UNITED KINGDOM</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="$testCountry"/>
                                    </xsl:attribute>
                                    <xsl:call-template name="normalizeISOCountryName">
                                        <xsl:with-param name="country" select="$avantVirgule"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </country>
                    </xsl:when>
                    <xsl:otherwise>
                        <addrLine>
                            <xsl:value-of select="$avantVirgule"/>
                        </addrLine>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$apresVirgule !=''">
                    <xsl:call-template name="WileyParseAffiliation2">
                        <xsl:with-param name="theAffil" select="$apresVirgule"/>
                        <xsl:with-param name="inAddress" select="true()"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
