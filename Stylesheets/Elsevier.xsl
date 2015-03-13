<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:els="http://www.elsevier.com/xml/ja/dtd" exclude-result-prefixes="#all"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd">

    <xsl:output encoding="UTF-8" method="xml"/>
    
    <xsl:include href="ElsevierFormula.xsl"/>

    <xsl:template match="els:article[els:item-info] | els:converted-article[els:item-info]">
        <TEI>
            <xsl:if test="@xml:lang">
                <xsl:copy-of select="@xml:lang"/>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="els:head/ce:title | head/ce:title"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:apply-templates
                            select="els:item-info/ce:copyright | item-info/ce:copyright"/>
                    </publicationStmt>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates
                                    select="els:head/ce:author-group/ce:author | head/ce:author-group/ce:author"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="els:head/ce:title | head/ce:title"/>
                            </analytic>
                            <monogr>
                                <xsl:apply-templates select="els:item-info/els:jid | item-info/jid"/>
                                <!-- PL: note for me, does the issn appears in the biblio section? -->
                                <xsl:apply-templates select="//ce:issn"/>
                                <!-- Just in case -->
                                <imprint>
                                    <xsl:choose>
                                        <xsl:when
                                            test="els:head/ce:miscellaneous | head/ce:miscellaneous">
                                            <xsl:apply-templates select="els:head/ce:miscellaneous"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:miscellaneous"
                                                mode="inImprint"/>
                                        </xsl:when>
                                        <xsl:when
                                            test="els:head/ce:date-accepted | head/ce:date-accepted">
                                            <xsl:apply-templates select="els:head/ce:date-accepted"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:date-accepted"
                                                mode="inImprint"/>
                                        </xsl:when>
                                        <xsl:when
                                            test="els:head/ce:date-received | head/ce:date-received">
                                            <xsl:apply-templates select="els:head/ce:date-received"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:date-received"
                                                mode="inImprint"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="els:item-info/ce:doi | item-info/ce:doi"/>
                            <xsl:apply-templates select="els:item-info/ce:pii | item-info/ce:pii"/>
                            <xsl:apply-templates select="els:item-info/els:aid | item-info/els:aid"
                            />
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="els:head/ce:keywords | head/ce:keywords | els:head/ce:abstract | head/ce:abstract">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="els:head/ce:abstract | head/ce:abstract"/>
						
                        <xsl:apply-templates select="els:head/ce:keywords | head/ce:keywords"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="//ce:glyph">
                    <encodingDesc>
                        <charDecl>
                            <xsl:for-each select="//ce:glyph">
                                <char>
                                    <xsl:attribute name="xml:id">
                                        <xsl:value-of select="@name"/>
                                    </xsl:attribute>
                                </char>
                            </xsl:for-each>
                        </charDecl>
                    </encodingDesc>
                </xsl:if>
                <xsl:if
                    test="els:head/ce:date-received | els:head/ce:date-revised | els:head/ce:date-accepted | els:head/ce:date-received | head/ce:date-received | head/ce:date-revised | head/ce:date-accepted | head/ce:date-received">
                    <revisionDesc>
                        <xsl:apply-templates
                            select="els:head/ce:date-received | els:head/ce:date-revised | els:head/ce:date-accepted | els:head/ce:date-received | head/ce:date-received | head/ce:date-revised | head/ce:date-accepted | head/ce:date-received"
                        />
                    </revisionDesc>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved from <front> to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="els:head/ce:abstract | head/ce:abstract"/>
                </front-->
                <body>
                    <xsl:apply-templates select="els:body/*"/>
                    <xsl:apply-templates select="body/*"/>
                </body>
                <back>
                    <!-- Bravo: Elsevier a renommé son back en tail... visionnaire -->
                    <xsl:apply-templates select="els:back/* | els:tail/* | tail/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <xsl:template match="ce:copyright">
        <!-- moved up publisher information -->
        <publisher>
            <xsl:value-of select="text()"/>
        </publisher>
        <!-- PL: put the date under the paragraph, as it is TEI P5 valid -->
        <!-- LR: moved the date two nodes higher so that the encompassing publicationStmt is closer to what is expected-->
        <date>
            <xsl:value-of select="@year"/>
        </date>
        <availability status="restricted">
			<licence>
            	<p><xsl:value-of select="@type"/></p>
			</licence>
        </availability>
    </xsl:template>

    <xsl:template match="ce:keyword/ce:text">
        <xsl:apply-templates/>
    </xsl:template>
	
	<!-- PL: this could be moved to KeywordsAbstract.xsl when generalised to all publishers -->
    <!--xsl:template match="els:head/ce:abstract | head/ce:abstract">
		<abstract>
			<xsl:if test="@xml:lang">
				<xsl:attribute name="xml:lang">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="*/ce:simple-para"/>
		</abstract>
    </xsl:template-->

    <xsl:template match="els:display | ce:display">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:correspondence/ce:text">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Revision information -->
    <xsl:template match="els:head/ce:date-received | head/ce:date-received">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els:head/ce:date-revised | head/ce:date-revised">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Revised</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els:head/ce:date-accepted | head/ce:date-accepted">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Accepted</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els:head/ce:date-received | head/ce:date-received" mode="inImprint">
        <change>
            <xsl:attribute name="type">Received</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
        </change>
    </xsl:template>

    <xsl:template match="els:head/ce:date-accepted | head/ce:date-accepted" mode="inImprint">
        <date>
            <xsl:attribute name="type">Accepted</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <xsl:template match="els:head/ce:miscellaneous | head/ce:miscellaneous" mode="inImprint">
        <xsl:variable name="quot">"</xsl:variable>
        <date>
            <xsl:attribute name="type">Published</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(substring-after(.,'day='),$quot),$quot)"/>
                    <xsl:with-param name="oldMonth"
                        select="substring-before(substring-after(substring-after(.,'month='),$quot),$quot)"/>
                    <xsl:with-param name="oldYear"
                        select="substring-before(substring-after(substring-after(.,'year='),$quot),$quot)"
                    />
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Full text elements -->

    <!-- divisions -->

    <xsl:template match="ce:sections">
        <div type="ElsevierSections">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="ce:section">
        <div>
            <xsl:if test="ce:label">
                <xsl:attribute name="n" select="ce:label"/>
            </xsl:if>
            <xsl:apply-templates select="*[ name()!='ce:label']"/>
        </div>
    </xsl:template>

    <xsl:template match="ce:acknowledgment">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="ce:abstract-sec">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:section-title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="ce:e-address">
        <email>
            <xsl:apply-templates/>
        </email>
    </xsl:template>

    <xsl:template match="els:author-comment">
        <note type="author-comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Figures -->

    <xsl:template match="ce:figure">
        <figure>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="ce:caption">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>

    <!-- Fin de la bibliographie -->

    <xsl:template match="ce:bib-reference">
        <biblStruct>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </biblStruct>
    </xsl:template>

    <xsl:template match="els:conf-name">
        <meeting>
            <xsl:apply-templates/>
        </meeting>
    </xsl:template>

    <xsl:template match="ce:author">
        <author>
            <xsl:variable name="structId" select="ce:cross-ref/@refid"/>
            <xsl:for-each select="$structId">
                <xsl:if test="//ce:correspondence[@id=.]">
                    <xsl:attribute name="type">
                        <xsl:text>corresp</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:message>Identifier: <xsl:value-of select="."/></xsl:message>
            </xsl:for-each>

            <persName>
                <xsl:apply-templates select="*[name(.)!='ce:cross-ref' and name(.)!='ce:e-address']"
                />
            </persName>

            <xsl:apply-templates select="ce:e-address"/>

            <xsl:choose>
                <xsl:when test="../ce:affiliation[not(@id)]">
                    <xsl:message>Affiliation sans identifiant</xsl:message>
                    <xsl:for-each select="../ce:affiliation">
                        <affiliation>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil">
                                    <xsl:value-of select="ce:textfn"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </affiliation>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>On parcourt les affiliations</xsl:message>
                    <xsl:for-each select="$structId">
                        <xsl:variable name="localId">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:if test="//ce:affiliation[@id=$localId]">
                            <xsl:message>Trouvé: <xsl:value-of select="$localId"/></xsl:message>
                            <affiliation>
                                <xsl:call-template name="parseAffiliation">
                                    <xsl:with-param name="theAffil">
                                        <xsl:value-of select="//ce:affiliation[@id=$localId]/ce:textfn"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </affiliation>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:for-each select="$structId">
                <xsl:variable name="localId2">
                    <xsl:value-of select="."/>
                </xsl:variable>
                
                <xsl:if test="//ce:correspondence[@id=$localId2]">
                    <xsl:variable name="codePays"
                        select="/els:article/els:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text"/>
                    <xsl:message>Pays Elsevier: <xsl:value-of select="$codePays"/></xsl:message>
                    <!-- PL: test to avoid empy country block -->

                    <xsl:if test="$codePays">
                        <affiliation>
                            <address>
	                           <country>
	                            <xsl:attribute name="key">
	                                <xsl:value-of select="$codePays"/>
	                            </xsl:attribute>
	                            <xsl:call-template name="normalizeISOCountryName">
	                                <xsl:with-param name="country" select="$codePays"/>
	                            </xsl:call-template>
	                        </country>
	                       </address>
                        </affiliation>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>


            <!-- PL: no reference markers in the author section -->
            <!--xsl:apply-templates select="ce:cross-ref"/-->

        </author>
    </xsl:template>

    <xsl:template match="ce:suffix">
        <!-- this is the suffix in a title name, e.g. jr for junior -->
        <suffix>
            <xsl:value-of select="text()"/>
        </suffix>
    </xsl:template>

    <xsl:template match="ce:affiliation">
        <affiliation>
            <address>
            <xsl:call-template name="parseAffiliation">
                <xsl:with-param name="theAffil">
                    <xsl:value-of select="ce:textfn"/>
                </xsl:with-param>
            </xsl:call-template>
            </address>
        </affiliation>
    </xsl:template>

    <xsl:template name="parseAffiliation">
        <xsl:param name="theAffil"/>
        <xsl:param name="inAddress" select="false()"/>
        <xsl:for-each select="$theAffil">
            <xsl:message>Un bout: <xsl:value-of select="."/></xsl:message>
        </xsl:for-each>
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
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil" select="$apresVirgule"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <address>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil" select="$theAffil"/>
                                <xsl:with-param name="inAddress" select="true()"/>
                            </xsl:call-template>
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
                            <xsl:attribute name="key">
                                <xsl:value-of select="$testCountry"/>
                            </xsl:attribute>
                            <xsl:call-template name="normalizeISOCountryName">
                                <xsl:with-param name="country" select="$avantVirgule"/>
                            </xsl:call-template>
                        </country>
                    </xsl:when>
                    <xsl:otherwise>
                        <addrLine>
                            <xsl:value-of select="$avantVirgule"/>
                        </addrLine>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$apresVirgule !=''">
                    <xsl:call-template name="parseAffiliation">
                        <xsl:with-param name="theAffil" select="$apresVirgule"/>
                        <xsl:with-param name="inAddress" select="true()"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="ce:correspondence">
        <note type="correspondence">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="ce:footnote">
        <note place="foot">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="ce:label"/>

    <xsl:template match="ce:hsp">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- vieille version qui intégre la référence dans le texte !!!???? -->
    <!--
    <xsl:template match="ce:cross-ref">
        <xsl:variable name="identifier" select="@refid"/>
        <xsl:apply-templates select="//*[@id=$identifier]"/>
    </xsl:template>-->

    <!-- Nouvelles qui se contente de créer un <ref> -->

    <xsl:template match="ce:cross-ref">
        <ref>
            <xsl:attribute name="target">
                <xsl:choose>
                    <!-- Si par hasard ELsevier bascule sur une vraie syntaxe URI, on n'ajoute pas le # devant l'identifiant -->
                    <xsl:when test=" starts-with(@refid,'#')">
                        <xsl:value-of select="@refid"/>
                    </xsl:when>
                    <!-- Dans le cas contraire, actual et le plus probale dans le futur on préfixe l'id avec # -->
                    <xsl:otherwise>
                        <xsl:value-of select=" concat('#',@refid)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- La même chose avec plusieurs référence (Ah, les URIs multiples) -->

    <xsl:template match="ce:cross-refs">
        <ref>
            <xsl:attribute name="target">
                <xsl:for-each select="tokenize(@refid,' ')">
                    <xsl:choose>
                        <!-- Si par hasard ELsevier bascule sur une vraie syntaxe URI, on n'ajoute pas le # devant l'identifiant -->
                        <xsl:when test=" starts-with(current(),'#')">
                            <xsl:value-of select="current()"/>
                        </xsl:when>
                        <!-- Dans le cas contraire, actual et le plus probale dans le futur on préfixe l'id avec # -->
                        <xsl:otherwise>
                            <xsl:value-of select=" concat('#',current())"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="not(position()=last())">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- External references -->
    <xsl:template match="ce:inter-ref">
        <ref>
            <xsl:attribute name="target">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="els:name" mode="editors">
        <editor>
            <xsl:apply-templates select="."/>
        </editor>
    </xsl:template>

    <xsl:template match="els:pub-id">
        <idno type="{@pub-id-type}">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>

    <xsl:template match="ce:glyph">
        <g>
            <xsl:if test="@name">
                <xsl:attribute name="ref">#<xsl:value-of select="@name"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </g>
    </xsl:template>

</xsl:stylesheet>
