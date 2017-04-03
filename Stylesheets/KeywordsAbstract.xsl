<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0" xmlns:els="http://www.elsevier.com/xml/ja/dtd" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- KEYWORDS -->

    <!-- BMJ: classinfo, keyword -->
    <!-- NLM 2.2 article: kwd-group, kwd -->
    <!-- Springer: KeywordGroup, Keyword -->
    <!-- Sage: keywords, keyword -->
    <!-- Elsevier: ce:keyword -->

    <!-- IOP: classifications/ puis comme Sage keywords/keyword
              pour l'instant directement traité dans IOP.xsl    -->

    <xsl:template match="kwd-group | classinfo | KeywordGroup | keywords | ce:keywords | BookSubjectGroup">
        <textClass>
            <keywords>
                <!-- PL: can we sometime grab a @scheme here? -->
                <xsl:apply-templates select="*[not(self::ce:section-title)]"/>
            </keywords>
        </textClass>
    </xsl:template>

    <!-- SG - ajout subject NLM/Nature -->
    <xsl:template match="pubfm/subject | suppfm/subject">
        <classCode>
            <xsl:attribute name="scheme">
                <xsl:apply-templates select="@type"/>
            </xsl:attribute>
            <xsl:value-of select="@code"/>
        </classCode>
    </xsl:template>

    <xsl:template match="keyword | Keyword | ce:keyword | kwd">
        <term>
            <xsl:apply-templates/>
        </term>
    </xsl:template>

    <xsl:template match="BookSubject">
        <label>
            <xsl:value-of select="@Code"/>
        </label>
        <item>
            <term>
                <xsl:apply-templates/>
            </term>
        </item>
    </xsl:template>

    <!-- For NLM - EDPS -->

    <xsl:template match="compound-kwd">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="compound-kwd-part[@content-type = 'code']">
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>

    <xsl:template match="compound-kwd-part[@content-type = 'keyword']">
        <term>
            <xsl:apply-templates/>
        </term>
    </xsl:template>

    <xsl:template match="kwd-group/title">
        <!-- PL: <head> not allowed under <keywords> -->
        <!--head>
            <xsl:apply-templates/>
        </head-->
    </xsl:template>

    <!-- ABSTRACTS -->

    <!-- BMJ: abstract -->
    <!-- ScholarOne: abstract -->
    <!-- NLM 2.0: Abstract -->
    <!-- NLM 2.3: abstract -->
    <!--  Elsevier:  -->
    <!-- PL: removed, Elsevier abstracts are processed in Elsevier.xsl -->
    <!-- Springer: Abstract, Heading, Para -->

    <xsl:template match="abstract | Abstract | els:head/ce:abstract | head/ce:abstract | fp | abs | execsumm | websumm"><xsl:if test=". != ''">
            <abstract>
                <!-- PL: indicate the type in case of executive summary or web summary (Nature) -->
                <xsl:if test="name() = 'execsumm'">
                    <xsl:attribute name="type">
                        <xsl:text>executive-summary</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="name() = 'websumm'">
                    <xsl:attribute name="type">
                        <xsl:text>web-summary</xsl:text>
                    </xsl:attribute>
                </xsl:if> 
	            <xsl:variable name="theLanguage">
	                <xsl:choose>
	                    <xsl:when test="@Language">
	                        <xsl:value-of select="@Language"/>
	                    </xsl:when>
	                    <xsl:when test="@xml:lang">
							<xsl:if test="@xml:lang">
								<xsl:if test="@xml:lang != ''">
									<xsl:value-of select="@xml:lang"/>
								</xsl:if>
							</xsl:if>	
	                    </xsl:when>
	                </xsl:choose>
	            </xsl:variable> 
	            <xsl:if test="$theLanguage">
					<xsl:if test="$theLanguage != ''">
	                    <xsl:attribute name="xml:lang">
	                        <xsl:call-template name="Varia2ISO639">
	                            <xsl:with-param name="code" select="$theLanguage"/>
	                        </xsl:call-template>
	                    </xsl:attribute>
					</xsl:if>
	            </xsl:if>
				<!-- PL: only paragraphs are taken because <div> are not allowed under <abstract> currently -->
				<xsl:apply-templates select="*/ce:simple-para"/>
	            <xsl:choose>
	                <xsl:when test="ce:abstract-sec">
	                    <xsl:apply-templates select="*/ce:simple-para"/>
	                </xsl:when>
	                <xsl:when test="p | Para | ce:abstract-sec | AbstractSection">
	                    <xsl:apply-templates/>
	                </xsl:when>
	                <xsl:otherwise>
	                    <p><xsl:apply-templates/></p>
	                </xsl:otherwise>
	            </xsl:choose>
			</abstract>
		</xsl:if>
    </xsl:template>


    <!--xsl:template match="abstract | Abstract">
        <xsl:if test=".!=''">
            <div type="abstract">
                <xsl:variable name="theLanguage">
                    <xsl:choose>
                        <xsl:when test="@Language">
                            <xsl:value-of select="@Language"/>
                        </xsl:when>
                        <xsl:when test="@xml:lang">
                            <xsl:if test="@xml:lang">
                                <xsl:if test="@xml:lang != ''">
                                    <xsl:value-of select="@xml:lang"/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="$theLanguage">
                    <xsl:if test="$theLanguage != ''">
                        <xsl:attribute name="xml:lang">
                            <xsl:call-template name="Varia2ISO639">
                                <xsl:with-param name="code" select="$theLanguage"/>
                            </xsl:call-template>
                        </xsl:attribute>
                    </xsl:if>
                </xsl:if>
                
                <xsl:apply-templates select="*/ce:simple-para"/>
                <xsl:choose>
                    <xsl:when test="ce:abstract-sec">
                        <xsl:apply-templates select="*/ce:simple-para"/>
                    </xsl:when>
                    <xsl:when test="p | Para | ce:abstract-sec | AbstractSection">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:otherwise>
                </xsl:choose>
            </abstract>
        </xsl:if>
    </xsl:template>-->

    <!-- Specific to SPringer: AbstractSection -->
    <xsl:template match="AbstractSection">
        <!-- PL: only paragraphs are taken because <div> are not allowed under <abstract> currently -->
        <!--div-->
        <xsl:apply-templates/>
        <!--/div-->
    </xsl:template>

</xsl:stylesheet>
