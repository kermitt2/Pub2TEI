<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:els="http://www.elsevier.com/xml/ja/dtd">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="els:article[els:item-info]">
        <TEI>
            <xsl:if test="@xml:lang">
                <xsl:copy-of select="@xml:lang"/>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="els:head/ce:title"/>
                    </titleStmt>
                    <publicationStmt>
                        <xsl:apply-templates select="els:item-info/ce:copyright"/>
                    </publicationStmt>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="els:head/ce:author-group/ce:author"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="els:head/ce:title"/>
                            </analytic>
                            <monogr>
                                <xsl:apply-templates select="els:item-info/els:jid"/>
                                <xsl:apply-templates select="//ce:issn"/>
                                <!-- Just in case -->
                                <imprint>
                                    <xsl:choose>
                                        <xsl:when test="els:head/ce:miscellaneous">
                                            <xsl:apply-templates select="els:head/ce:miscellaneous"
                                                mode="inImprint"/>
                                        </xsl:when>
                                        <xsl:when test="els:head/ce:date-accepted">
                                            <xsl:apply-templates select="els:head/ce:date-accepted"
                                                mode="inImprint"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="els:item-info/ce:doi"/>
                            <xsl:apply-templates select="els:item-info/ce:pii"/>
                            <xsl:apply-templates select="els:item-info/els:aid"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="els:head/ce:keywords">
                    <profileDesc>
                        <xsl:apply-templates select="els:head/ce:keywords"/>
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
                    test="els:head/ce:date-received | els:head/ce:date-revised | els:head/ce:date-accepted">
                    <revisionDesc>
                        <xsl:apply-templates
                            select="els:head/ce:date-received | els:head/ce:date-revised | els:head/ce:date-accepted"
                        />
                    </revisionDesc>
                </xsl:if>
            </teiHeader>
            <text>
                <front>
                    <xsl:apply-templates select="els:head/ce:abstract"/>
                </front>
                <body>
                    <xsl:apply-templates select="els:body/*"/>
                </body>
                <back>
                    <xsl:apply-templates select="els:back/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <xsl:template match="ce:copyright">
        <availability status="{@type}">
            <p>
                <date>
                    <xsl:value-of select="@year"/>
                </date>
            </p>
        </availability>
    </xsl:template>

    <xsl:template match="ce:keyword/ce:text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:correspondence/ce:text">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Revision information -->
    <xsl:template match="els:head/ce:date-received">
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

    <xsl:template match="els:head/ce:date-revised">
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

    <xsl:template match="els:head/ce:date-accepted">
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

    <xsl:template match="els:head/ce:date-accepted" mode="inImprint">
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

    <xsl:template match="els:head/ce:miscellaneous" mode="inImprint">
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

    <!-- Full text elements -->
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

    <!-- Fin de la bibliographie -->

    <xsl:template match="els:conf-name">
        <meeting>
            <xsl:apply-templates/>
        </meeting>
    </xsl:template>

    <xsl:template match="ce:author">
        <author>
            <xsl:variable name="identifier" select="ce:cross-ref/@refid"/>
            <xsl:message>Identifier: <xsl:value-of select="$identifier"/></xsl:message>
            <xsl:if test="//ce:correspondence[@id=$identifier]">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>

            <persName>
                <xsl:apply-templates select="*[name(.)!='ce:cross-ref' and name(.)!='ce:e-address']"
                />
            </persName>

            <xsl:apply-templates select="ce:e-address"/>


            <affiliation>
                <xsl:if test="../ce:affiliation[not(@id)]">
                    <xsl:call-template name="parseAffiliation">
                        <xsl:with-param name="theAffil" select="../ce:affiliation/ce:textfn"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="//ce:affiliation[@id=$identifier]">
                    <xsl:message>Trouvé</xsl:message>
                    <xsl:call-template name="parseAffiliation">
                        <xsl:with-param name="theAffil"
                            select="//ce:affiliation[@id=$identifier]/ce:textfn"/>
                    </xsl:call-template>
                </xsl:if>

                <xsl:if test="//ce:correspondence[@id=$identifier]">
                    <xsl:variable name="codePays"
                        select="/els:article/els:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text"/>
                    <xsl:message>Pays Elsevier: <xsl:value-of select="$codePays"/></xsl:message>
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
                </xsl:if>

            </affiliation>

            <xsl:apply-templates select="ce:cross-ref"/>

        </author>
    </xsl:template>

    <xsl:template match="ce:affiliation">
        <affiliation>
            <address>
            <xsl:call-template name="parseAffiliation">
                <xsl:with-param name="theAffil" select="ce:textfn"/>
            </xsl:call-template>
            </address>
        </affiliation>
    </xsl:template>

    <xsl:template name="parseAffiliation">
        <xsl:param name="theAffil"/>
        <xsl:param name="inAddress" select="false()"/>
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

    <xsl:template match="ce:cross-ref">
        <xsl:variable name="identifier" select="@refid"/>
        <xsl:apply-templates select="//*[@id=$identifier]"/>
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
