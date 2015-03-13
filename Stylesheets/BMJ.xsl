<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="metadata">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="articleinfo/article-title"/>
                    </titleStmt>
                    <xsl:if test="miscinfo/copyright">
                        <publicationStmt>
                            <xsl:apply-templates select="miscinfo/copyright/*"/>
                        </publicationStmt>
                    </xsl:if>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="authorgrp/*"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates select="articleinfo/article-title | articleinfo/short-title"/>
                            </analytic>
                            <monogr>
                                <xsl:apply-templates select="articleinfo/journal-title"/>
                                <imprint>
                                    <xsl:if test="history/accepted-date and history/accepted-date!=''">
                                        <xsl:apply-templates select="history/accepted-date" mode="inImprint"/>
                                    </xsl:if>
                                    <xsl:apply-templates select="articleid/volume | articleid/issue-number"/>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="articleid/doi"/>
                            <xsl:apply-templates select="articleinfo/manuscript-number"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="classinfo">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
						<xsl:apply-templates select="abstract"/>
						
                        <xsl:apply-templates select="classinfo"/>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="history/submitted-date | history/revised-date | history/accepted-date">
                    <revisionDesc>
                        <xsl:apply-templates
                            select="history/submitted-date | history/revised-date | history/accepted-date"
                        />
                    </revisionDesc>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="abstract"/>
                </front-->
                <body>
                    <xsl:apply-templates select="body/*"/>
                </body>
                <back>
                    <xsl:apply-templates select="back/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>
    
    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="first-author">
        <author type="corresp">
            <xsl:choose>
                <xsl:when test="//corrinfo">
                    <persName>
                        <xsl:apply-templates
                            select="//corrinfo/*[name()='corresponding-author-title'
                            or name()='corresponding-author-firstname'
                            or name()='corresponding-author-middlename'
                            or name()='corresponding-author-lastname']"
                        />
                    </persName>
                    <affiliation>
                        <xsl:apply-templates select="//corrinfo/corresponding-author-institution"/>
                        <address>
                            <xsl:apply-templates select="//corrinfo/*[starts-with(name(),'corresponding-author-address')]"/>
                            <xsl:apply-templates select="//corrinfo/corresponding-author-city"/>
                            <xsl:apply-templates select="//corrinfo/corresponding-author-state"/>
                            <xsl:apply-templates select="//corrinfo/corresponding-author-country"/>
                            <xsl:apply-templates select="//corrinfo/corresponding-author-zipcode"/>
                        </address>
                    </affiliation>
                    <xsl:apply-templates select="//corrinfo/corresponding-author-phone"/>
                    <xsl:apply-templates select="//corrinfo/corresponding-author-fax"/>
                    <xsl:apply-templates select="//corrinfo/corresponding-author-email"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="name"/>
                    <affiliation>
                        <xsl:apply-templates select="*[name()!='name']"/>
                    </affiliation>
                </xsl:otherwise>
            </xsl:choose>

        </author>
    </xsl:template>

    <xsl:template match="other-author">
        <author>
            <xsl:apply-templates select="name"/>
            <affiliation>
                <xsl:apply-templates select="*[name()!='name']"/>
            </affiliation>
        </author>
    </xsl:template>

    <xsl:template match="corresponding-author-phone">
        <note type="{substring-after(name(),'corresponding-author-')}">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="corresponding-author-fax">
        <note type="{substring-after(name(),'corresponding-author-')}">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="permissions">
        <availability>
            <p>
                <xsl:text>Permissions: </xsl:text>
                <xsl:apply-templates/>
            </p>
        </availability>
    </xsl:template>

    <xsl:template match="manuscript-type">
        <note type="manuscript-type">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="history/submitted-date">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(.,'/'),'/')"/>
                    <xsl:with-param name="oldMonth" select="substring-before(.,'/')"/>
                    <xsl:with-param name="oldYear"
                        select="substring-after(substring-after(.,'/'),'/')"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Submitted</xsl:text>
        </change>
    </xsl:template>


    <xsl:template match="history/revised-date">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(.,'/'),'/')"/>
                    <xsl:with-param name="oldMonth" select="substring-before(.,'/')"/>
                    <xsl:with-param name="oldYear"
                        select="substring-after(substring-after(.,'/'),'/')"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Revised</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="history/accepted-date">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(.,'/'),'/')"/>
                    <xsl:with-param name="oldMonth" select="substring-before(.,'/')"/>
                    <xsl:with-param name="oldYear"
                        select="substring-after(substring-after(.,'/'),'/')"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Accepted</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="history/accepted-date" mode="inImprint">
        <date>
            <xsl:attribute name="type">Accepted</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(.,'/'),'/')"/>
                    <xsl:with-param name="oldMonth" select="substring-before(.,'/')"/>
                    <xsl:with-param name="oldYear"
                        select="substring-after(substring-after(.,'/'),'/')"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

</xsl:stylesheet>
