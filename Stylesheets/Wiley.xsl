<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xpath-default-namespace="http://www.wiley.com/namespaces/wiley"
	exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:variable name="codeGenre1">
        <xsl:value-of select="//component/header/publicationMeta[@level='unit']/@type"/>
    </xsl:variable>
    <xsl:variable name="codeGenre">
        <xsl:choose>
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
            <xsl:when test="normalize-space($codeGenre1)='miscellaneous'">other</xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="component">
        <xsl:message>Wiley.xsl</xsl:message>
        <TEI>
            <xsl:choose>
                <xsl:when test="body/section[@xml:lang]">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="body/section[1]/@xml:lang"/>
                    </xsl:attribute>
                </xsl:when>
                <!-- SG ajout langue si non contenu dans le body aller la chercher dans la racine -->
                <xsl:otherwise>
                    <xsl:if test="@xml:lang">
                        <xsl:attribute name="xml:lang">
                            <xsl:value-of select="@xml:lang"/>
                        </xsl:attribute>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <teiHeader>
                <fileDesc>
                    <!-- SG - titre brut -->
                    <titleStmt>
						<title level="a" type="main">
                        	<xsl:value-of select="header/contentMeta/titleGroup/title[@type='main']"/>
						</title>
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
                       	 	<publisher>Blackwell Publishing Ltd</publisher>
						</xsl:if>
                        <!-- SG ajout publisherLoc -->
                        <xsl:if test="header/publicationMeta/publisherInfo/publisherLoc">
                            <xsl:apply-templates select="header/publicationMeta/publisherInfo/publisherLoc"/>
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
                <!-- SG - ajout du codeGenre article -->
                <xsl:if test="header/publicationMeta[@level='unit']/@type">
                    <encodingDesc>
                        <classDecl>
                            <taxonomy>
                                <category>
                                    <catDesc>componentType</catDesc>
                                    <category>
                                        <catDesc><xsl:value-of select="$codeGenre"/></catDesc>
                                    </category>
                                </category>
                            </taxonomy>
                        </classDecl>
                    </encodingDesc>
                </xsl:if>
                <xsl:if test="header/contentMeta/abstractGroup | header/contentMeta/keywordGroup">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
                        <xsl:if test="header/contentMeta/abstractGroup/abstract/p and not(header/contentMeta/abstractGroup/abstract/p/list)">
                            <!-- SG - reprise de tous les abstracts -->
                            <xsl:for-each select="header/contentMeta/abstractGroup/abstract">
                            <abstract>
							    <!--SG - ajout langue -->
							    <xsl:if test="@xml:lang !=''">
							        <xsl:copy-of select="@xml:lang"/>
							    </xsl:if>
                                <xsl:if test="@type !='main'">
                                    <xsl:attribute name="rendition">
                                        <xsl:apply-templates select="@type"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="@xml:id !=''">
                                    <xsl:copy-of select="@xml:id"/>
                                </xsl:if>
                                <xsl:apply-templates/>
                                <!--<xsl:apply-templates select="p"/>-->
							</abstract>
                            </xsl:for-each>
		                </xsl:if>
						<xsl:if test="header/contentMeta/keywordGroup/keyword !=''">
							<textClass>
								<keywords>
								    <!--SG - ajout langue -->
								    <xsl:if test="header/contentMeta/keywordGroup/@xml:lang !=''">
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
    <xsl:template match="header/contentMeta/abstractGroup/abstract/title">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="header/contentMeta/abstractGroup/abstract/p">
        <p>
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
        <xsl:if test=".!=''"><hi rend="italic"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>
    
    <xsl:template match="abstractGroup/abstract/p/bold">
        <xsl:if test=".!=''"><hi rend="bold"><xsl:apply-templates/></hi></xsl:if>
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
				<title level="j" type="main">
					<xsl:apply-templates select="publicationMeta[@level='product']/titleGroup/title"/>
				</title>
                <!-- SG ajout titre alternatif -->
                <xsl:if test="publicationMeta[@level='product']/titleGroup/title/@sort !=''">
                    <title level="j" type="alt">
                        <xsl:apply-templates select="publicationMeta[@level='product']/titleGroup/title/@sort"/>
                    </title>
                </xsl:if>
                <xsl:apply-templates select="publicationMeta[@level='product']/issn"/>
                <xsl:apply-templates select="publicationMeta[@level='product']/doi"/>
				<xsl:apply-templates select="publicationMeta[@level='unit']/doi"/>
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
		<title level= "a" type="main">
		    <!-- SG : ajout de la langue du titre -->
		    <xsl:if test="title[@type='main']/@xml:lang">
		        <xsl:attribute name="xml:lang">
		            <xsl:value-of select="title[@type='main']/@xml:lang"/>
		        </xsl:attribute>
		    </xsl:if>
        	<xsl:apply-templates select="title[@type='main']"/>
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
	            <xsl:apply-templates select="title[@type='short']"/>
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
		 <xsl:apply-templates/>
	</xsl:template>

    <!-- author related information -->
    <xsl:template match="creator">
        <xsl:choose>
            <xsl:when test="@creatorRole='author'">
                <author>
                    <!-- SG - ajout de @corresponding et @noteRef -->
                    <xsl:if test="@corresponding='yes'">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <!--<xsl:if test="@noteRef !=''">
                        <xsl:attribute name="corresp">
                            <xsl:value-of select="@noteRef"/>
                        </xsl:attribute>
                    </xsl:if>-->
                    <xsl:apply-templates/>
                    <xsl:if test="//affiliationGroup">
                        <xsl:call-template name="affiliation"/>
                    </xsl:if>
                </author>
            </xsl:when>
            <!-- ajout SG si pas d'@creatorRole  -->
            <xsl:otherwise>
                <author>
                    <xsl:if test="@corresponding='yes'">
                        <xsl:attribute name="role">
                            <xsl:text>corresp</xsl:text>
                        </xsl:attribute>
                    </xsl:if>	
                    <xsl:apply-templates/>
                    <xsl:if test="//affiliationGroup">
                        <xsl:call-template name="affiliation"/>
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
                    <orgName>
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
	
    <xsl:template match="header/noteGroup/note">
		<note>
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
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv/text()">
                                <orgName>
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
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
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
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                                <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                                    </address>
                            </xsl:if>
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
                            <orgName>
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
                                 <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state/text()"/>   
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
                        <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation/text()"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/@countryCode">
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="//affiliation[@xml:id=$aff]/@countryCode"/>
                                    </xsl:attribute>
                                </country>
                                    </address>
                        </xsl:if>
                    </xsl:if>
                    
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
                <xsl:if test="//affiliation[@xml:id=$aff]">
                    <affiliation>
                        <xsl:text>Correspondence address: </xsl:text>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgDiv[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv">
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName">
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
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
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                            | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
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
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv">
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName">
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                        </xsl:if>
                        <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                        </xsl:if>
                    </affiliation>
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
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgDiv">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[@xml:id=$aff]/orgName">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/street[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/street"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]
                            | //affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/countryPart[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/countryPart"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/postCode[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/postCode"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/city[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/city"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/state[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/state"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/address/country[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/address/country"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                    </xsl:if>
                    <xsl:if test="//affiliation[@xml:id=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[@xml:id=$aff]/unparsedAffiliation"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
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
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ]">
                            <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName">
                                <xsl:variable name="aff2">
                                    <xsl:apply-templates select="."/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($aff2)"/>
                                <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                                    | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                        </xsl:if>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation"/>
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
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgDiv">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName[string-length() &gt; 0 ]">
                        <xsl:for-each select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/orgName">
                            <xsl:variable name="aff2">
                                <xsl:apply-templates select="."/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($aff2)"/>
                            <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                                | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/street"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]
                            | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ] | //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/postCode"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/city"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ] |//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/countryPart"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]| //affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/state"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                        <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/address/country"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
                    </xsl:if>
                    <xsl:if test="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation[string-length() &gt; 0 ]">
                        <xsl:variable name="aff2">
                            <xsl:apply-templates select="//affiliation[substring-after(@xml:id,'aff-1-')=$aff]/unparsedAffiliation"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($aff2)"/>
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
                        <xsl:variable name="orgDiv">
                            <xsl:apply-templates select="."/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($orgDiv)"/>
                        <xsl:if test="orgName[string-length() &gt; 0 ] | address/street[string-length() &gt; 0 ] | address/countryPart[string-length() &gt; 0 ]
                            | address/postCode[string-length() &gt; 0 ] | address/city[string-length() &gt; 0 ]| address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="orgName[string-length() &gt; 0 ]">
                    <xsl:for-each select="orgName">
                        <xsl:variable name="orgName">
                            <xsl:apply-templates select="."/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($orgName)"/>
                        <xsl:if test="address/street[string-length() &gt; 0 ] | address/countryPart[string-length() &gt; 0 ]
                            | address/postCode[string-length() &gt; 0 ] | address/city[string-length() &gt; 0 ]| address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="address/street[string-length() &gt; 0 ]">
                    <xsl:variable name="street">
                        <xsl:apply-templates select="address/street"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($street)"/>
                    <xsl:if test="address/countryPart[string-length() &gt; 0 ]
                        | address/postCode[string-length() &gt; 0 ] | address/city[string-length() &gt; 0 ]| address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="address/postCode[string-length() &gt; 0 ]">
                    <xsl:variable name="postCode">
                        <xsl:apply-templates select="address/postCode"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($postCode)"/>
                    <xsl:if test="address/city[string-length() &gt; 0 ]| address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="address/city[string-length() &gt; 0 ]">
                    <xsl:variable name="city">
                        <xsl:apply-templates select="address/city"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($city)"/>
                    <xsl:if test="address/countryPart[string-length() &gt; 0 ]|address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="address/countryPart[string-length() &gt; 0 ]">
                    <xsl:variable name="countryPart">
                        <xsl:apply-templates select="address/countryPart"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($countryPart)"/>
                    <xsl:if test="address/state[string-length() &gt; 0 ]| address/country[string-length() &gt; 0 ]">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="address/state[string-length() &gt; 0 ]">
                    <xsl:variable name="state">
                        <xsl:apply-templates select="address/state"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($state)"/>
                    <xsl:if test="address/country[string-length() &gt; 0 ]">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="address/country[string-length() &gt; 0 ]">
                    <xsl:variable name="country">
                        <xsl:apply-templates select="address/country"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($country)"/>
                </xsl:if>
                <xsl:if test="unparsedAffiliation[string-length() &gt; 0 ]">
                    <xsl:variable name="unparsedAffiliation">
                        <xsl:apply-templates select="unparsedAffiliation"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($unparsedAffiliation)"/>
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
                                <xsl:value-of select="normalize-space(p)"/>
                            </note>
                            <xsl:if test="p/email">
                                <email>
                                    <xsl:value-of select="normalize-space(p/email)"/>
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
    <xsl:template name="nameAut">
        <name>
            <xsl:attribute name="type">personal</xsl:attribute>
            <xsl:if test="honorifics">
                <namePart>
                    <xsl:attribute name="type">termsOfAddress</xsl:attribute>
                    <xsl:variable name="honor">
                        <xsl:apply-templates select="honorifics"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($honor)"/>
                </namePart>
            </xsl:if>
            <xsl:if test="givenNames[string-length() &gt; 0]">
                <namePart>
                    <xsl:attribute name="type">given</xsl:attribute>
                    <xsl:variable name="given">
                        <xsl:apply-templates select="givenNames"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($given)"/>
                </namePart>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="unparsedName[string-length()&gt;0]">
                    <namePart>
                        <xsl:attribute name="type">family</xsl:attribute>
                        <xsl:variable name="unparsedName">
                            <xsl:apply-templates select="unparsedName"/>
                        </xsl:variable>
                        <xsl:value-of select="normalize-space($unparsedName)"/>
                    </namePart>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="familyName[string-length()&gt;0]">
                        <namePart>
                            <xsl:attribute name="type">family</xsl:attribute>
                            <xsl:if test="familyNamePrefix">
                                <xsl:variable name="familyNamePrefix">
                                    <xsl:apply-templates select="familyNamePrefix"/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($familyNamePrefix)"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:variable name="familyName">
                                <xsl:apply-templates select="familyName"/>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($familyName)"/>
                            <xsl:if test="nameSuffix">
                                <xsl:text> </xsl:text>
                                <xsl:variable name="nameSuffix">
                                    <xsl:apply-templates select="nameSuffix"/>
                                </xsl:variable>
                                <xsl:value-of select="normalize-space($nameSuffix)"/>
                            </xsl:if>
                        </namePart>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="titlesAfterNames [string-length()&gt;0]">
                <namePart>
                    <xsl:attribute name="type">termsOfAddress</xsl:attribute>
                    <xsl:variable name="titlesAfterNames">
                        <xsl:apply-templates select="titlesAfterNames"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($titlesAfterNames)"/>
                </namePart>
            </xsl:if>
            <xsl:if test="degrees[string-length() &gt; 0]">
                <namePart>
                    <xsl:attribute name="type">termsOfAddress</xsl:attribute>
                    <xsl:variable name="degrees">
                        <xsl:apply-templates select="degrees"/>
                    </xsl:variable>
                    <xsl:value-of select="normalize-space($degrees)"/>
                </namePart>
            </xsl:if>
            <role>
                <roleTerm>
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:text>author</xsl:text>
                </roleTerm>
            </role>
        </name>
    </xsl:template>
</xsl:stylesheet>
