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
						<title leval= "a" type="main">
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
                        <xsl:apply-templates select="header/publicationMeta/copyright"/>
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
		                		<xsl:apply-templates select="header/contentMeta/abstractGroup/abstract/p"/>
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
                <body>
                    <xsl:apply-templates select="body" mode="bodyOnly"/>
                </body>
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
		<title leval= "a" type="main">
        	<xsl:value-of select="title[@type='main']"/>
		</title>
		<title leval= "a" type="short">
        	<xsl:value-of select="title[@type='short']"/>
		</title>
	</xsl:template>
 
 	<!-- Body content -->
    <xsl:template match="body" mode="bodyOnly">
        <xsl:apply-templates select="section"/>
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

    <!-- author related information -->
    <xsl:template match="creator">
		<xsl:if test="@creatorRole='author'">
			<author>
	            <xsl:apply-templates/>

				<!-- affiliation -->
				<xsl:if test="../aff">
					<xsl:apply-templates select="../aff" mode="sourceDesc"/>
				</xsl:if>
			</author>
		</xsl:if>
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

    <xsl:template match="title-group/fn-group"/>

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="aff | contrib/address">
		<xsl:if test="not(/article/pubfm)">
			<!-- this only apply to NPG articles not containing a pubfm style component -->
	        <affiliation>
	            <xsl:apply-templates select="*[name(.)!='addr-line' and name(.)!='country']"/>
	            <xsl:if test="addr-line | country">
	                <address>
	                    <xsl:apply-templates select="addr-line | country"/>
	                </address>
	            </xsl:if>
				<xsl:value-of select="."/>
	        </affiliation>
		</xsl:if>
    </xsl:template>
	
    <xsl:template match="aff" mode="sourceDesc">
        <affiliation>
			<xsl:value-of select="."/>
        </affiliation>
    </xsl:template>

    <xsl:template match="aff/bold">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="aff/label">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- redirected affiliation by means of basic index (BMJ - 3.0 example) -->
    <xsl:template match="xref[@ref-type='aff']">
        <xsl:variable name="numberedIndex">
            <xsl:value-of select="./sup"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@rid">
                <xsl:variable name="index" select="@rid"/>
                <xsl:apply-templates select="//aff[@id=$index]"/>
            </xsl:when>
            <xsl:when
                test="ancestor::article-meta/descendant::aff/sup[normalize-space(.)=normalize-space($numberedIndex)]/following-sibling::text()[1]">
                <affiliation>
                    <xsl:apply-templates
                        select="ancestor::article-meta/descendant::aff/sup[normalize-space(.)=normalize-space($numberedIndex)]/following-sibling::text()[1]"
                    />
                </affiliation>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- specific notes attached to authors (PNAS - 3.0 example)-->
    <xsl:template match="xref[@ref-type='author-notes']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="strip-string">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:apply-templates select="ancestor::article-meta/descendant::author-notes/fn[@id=$index]"
        />
    </xsl:template>

    <!-- additional information attached to corresponding authors (Cambridge example)-->
    <xsl:template match="xref[@ref-type='corresp']">
        <xsl:variable name="index" select="@rid"/>
        <xsl:variable name="refCorresp"
            select="ancestor::article-meta/descendant::author-notes/corresp[@id=$index]"/>
        <xsl:apply-templates select="$refCorresp/email"/>
        <!-- Cambridge may provide country in "author-notes/corresp" instead of "aff" -->
        <xsl:if test="$refCorresp/country">
            <address>
                <xsl:apply-templates select="$refCorresp/addr-line | $refCorresp/country| $refCorresp/institution"/>
               </address>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ack">
        <div type="acknowledgements">
            <head>Acknowledgements</head>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Figures -->
    <xsl:template match="fig">
        <figure>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="fig/label">
        <head type="label">
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="caption">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="caption/title">
        <head type="caption-title">
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="graphic">
        <graphic>
            <xsl:attribute name="url">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
        </graphic>
    </xsl:template>

    <!-- Tables -->

    <xsl:template match="hr">
        <milestone unit="hr"/>
    </xsl:template>


    <xsl:template match="back/fn-group">
        <div type="fn-group">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="fn-group/fn">
        <note place="inline">
            <xsl:if test="@fn-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@fn-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="fn/label">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- References in main text -->
    <xsl:template match="xref">
        <ref>
            <xsl:attribute name="type">
                <xsl:value-of select="@ref-type"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="ext-link">
        <ref>
            <xsl:attribute name="type">
                <xsl:value-of select="@ext-link-type"/>
            </xsl:attribute>

            <xsl:attribute name="target">
                <xsl:choose>
                    <xsl:when test="@xlink:href">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="supplementary-material">
        <ref>
            <xsl:attribute name="type"> supplementary-material </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- Copyright related information to appear in <publicationStmt> -->
    <xsl:template match="copyright-statement">
        <availability>
            <p>
                <xsl:apply-templates/>
            </p>
        </availability>
    </xsl:template>

    <xsl:template match="permissions/license">
        <availability>
            <xsl:if test="@license-type">
                <xsl:attribute name="status">
                    <xsl:choose>
                        <xsl:when test="@license-type='open-access'">OpenAccess</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@license-type"/>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </availability>
    </xsl:template>

    <xsl:template match="license/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="copyright-year | cpy">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>

    <xsl:template match="copyright-holder | cpn">
        <authority>
            <xsl:apply-templates/>
        </authority>
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

    <xsl:template match="date[@date-type='received']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received</xsl:text>
        </change>
    </xsl:template>
    
    <xsl:template match="date[@date-type='received-final']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received final</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="date[@date-type='rev-recd']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Revised</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="date[@date-type='accepted']">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="day"/>
                    <xsl:with-param name="oldMonth" select="month"/>
                    <xsl:with-param name="oldYear" select="year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Accepted</xsl:text>
        </change>
    </xsl:template>

</xsl:stylesheet>
