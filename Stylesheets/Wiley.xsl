<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xpath-default-namespace="http://www.wiley.com/namespaces/wiley"
	exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="component">
        <xsl:message>Wiley.xsl</xsl:message>
        <TEI>
            <xsl:if test="body/section[@xml:lang]">
				<xsl:attribute name="xml:lang">
                	<xsl:value-of select="body/section[1]/@xml:lang"/>
				</xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
						<title level="a" type="main">
                        	<xsl:value-of select="header/contentMeta/titleGroup/title[@type='main']"/>
						</title>
                    </titleStmt>
                    <publicationStmt>
						<xsl:if test="header/publicationMeta/publisherInfo/publisherName">
                       	 	<xsl:apply-templates select="header/publicationMeta/publisherInfo/publisherName"/>
						</xsl:if>
						<xsl:if test="not(header/publicationMeta/publisherInfo/publisherName)">
                       	 	<publisher>Blackwell Publishing Ltd</publisher>
						</xsl:if>
						<xsl:if test="header/publicationMeta/copyright">
							<availability>
							    <!-- SG: ajout licence -->
								<licence>
								    <xsl:apply-templates select="header/publicationMeta/copyright/text()"/>
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
                    <sourceDesc>
                        <xsl:apply-templates select="header" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="header/contentMeta/abstractGroup | header/contentMeta/keywordGroup">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
		                <xsl:if test="header/contentMeta/abstractGroup/abstract/p">
							<abstract>
							    <!-- reprise SG: apply-templates ne matche pas, remplacé par value-of + ajout <p>-->
							    <p>
							        <xsl:value-of select="header/contentMeta/abstractGroup/abstract/p"/>
							    </p>
							</abstract>
		                </xsl:if>
						<xsl:if test="header/contentMeta/keywordGroup">
							<textClass>
								<keywords>
									<xsl:for-each select="header/contentMeta/keywordGroup/keyword">
										<term><xsl:value-of 											select="text()"/></term>
									</xsl:for-each>
								</keywords>
							</textClass>
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
                    <xsl:otherwise>
                        <body><div><p></p></div></body>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="body/bibliography">
                    <back>
                        <xsl:apply-templates select="body/bibliography"/>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>

	<!-- abstract content -->
	<xsl:template match="/component/header/contentMeta/abstractGroup/abstract/p"> 
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
	</xsl:template>
	
    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="header" mode="sourceDesc">
        <biblStruct>
            <xsl:variable name="articleType" select="/article/@type"/>
            <xsl:if test="$articleType != ''">
                <xsl:choose>
                    <xsl:when test="$articleType='serialArticle'">
                        <xsl:attribute name="type">article</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="no">Article-type inconnu: <xsl:value-of
                                select="$articleType"/></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>

            <analytic>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="contentMeta/titleGroup"/>
				
                <!-- All authors are included here -->
				<xsl:if test="contentMeta/creators">
					<xsl:apply-templates select="contentMeta/creators"/>
				</xsl:if>
            </analytic>
            <monogr>
				<title level="j">
					<xsl:apply-templates select="publicationMeta[@level='product']/titleGroup/title"/>
				</title>	
                <xsl:apply-templates select="publicationMeta[@level='product']/issn"/>
               
				<xsl:apply-templates select="publicationMeta[@level='unit']/doi"/>
                <imprint>
	                <xsl:apply-templates select="publicationMeta[@level='part']/numberingGroup/numbering[@type='journalVolume']"/>
	                <xsl:apply-templates select="publicationMeta[@level='part']/numberingGroup/numbering[@type='journalIssue']"/>
					
	                <xsl:apply-templates select="publicationMeta[@level='unit']/numberingGroup/numbering[@type='pageFirst']"/>
	                <xsl:apply-templates select="publicationMeta[@level='unit']/numberingGroup/numbering[@type='pageLast']"/>
					
					<xsl:if test="publicationMeta/publisherInfo/publisherName">
                   	 	<xsl:apply-templates select="publicationMeta/publisherInfo/publisherName"/>
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
		<title level= "a" type="main">
		    <!-- SG : ajout de la langue du titre -->
		    <xsl:if test="title[@type='main']/@xml:lang">
		        <xsl:attribute name="xml:lang">
		            <xsl:value-of select="title[@type='main']/@xml:lang"/>
		        </xsl:attribute>
		    </xsl:if>
        	<xsl:value-of select="title[@type='main']"/>
		</title>
	    <!-- SG - ajout conditionnel -->
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
		<xsl:apply-templates select="//tabular"/>
		<xsl:apply-templates select="//noteGroup"/>
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
		 <xsl:apply-templates/>
	</xsl:template>

    <!-- author related information -->
    <xsl:template match="creator">
        <xsl:choose>
            <xsl:when test="@creatorRole='author'">
                <author>
                    <xsl:if test="@corresponding">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>	
                    <xsl:apply-templates/>
                    <!-- the affiliation id for this person -->
                    <xsl:variable name="affID" select="@affiliationRef"/>
                    
                    <!-- affiliation -->
                    <xsl:if test="../../affiliationGroup/affiliation[@xml:id=substring($affID,2)]">
                        <xsl:apply-templates select="../../affiliationGroup/affiliation[@xml:id=substring($affID,2)]"/>
                    </xsl:if>	
                </author>
            </xsl:when>
            <!-- ajout SG si pas d'@creatorRole  -->
            <xsl:otherwise>
                <author>
                    <xsl:if test="@corresponding">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>	
                    <xsl:apply-templates/>
                    <!-- the affiliation id for this person -->
                    <xsl:variable name="affID" select="@affiliationRef"/>
                    
                    <!-- affiliation -->
                    <xsl:if test="../../affiliationGroup/affiliation[@xml:id=substring($affID,2)]">
                        <xsl:apply-templates select="../../affiliationGroup/affiliation[@xml:id=substring($affID,2)]"/>
                    </xsl:if>	
                </author>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@creatorRole='editor'">
            <editor>
                <xsl:apply-templates/>
                <!-- affiliation -->
                <xsl:if test="../aff">
                    <xsl:apply-templates select="../aff" mode="sourceDesc"/>
                </xsl:if>
            </editor>
        </xsl:if>
    </xsl:template>
	
    <xsl:template match="affiliation">	
		<xsl:if test="unparsedAffiliation">
	        <affiliation>
	        	<xsl:value-of select="unparsedAffiliation/text()"/>
				<xsl:if test="@countryCode">
					<address>
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

	<!-- Structure a note block-->
    <xsl:template match="noteGroup">
        <xsl:apply-templates select="note"/>
    </xsl:template>
	
    <xsl:template match="note">
		<note>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        	<xsl:apply-templates/>
		</note>
    </xsl:template>

</xsl:stylesheet>
