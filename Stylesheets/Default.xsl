<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:mml="http://www.w3.org/1998/Math/MathML" 
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" 
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    exclude-result-prefixes="#all">

    <!-- Default rules -->
    <xsl:template match="*">
        <xsl:message terminate="no">Element inconnu: name: <xsl:value-of
            select="name()"/> - local-name: <xsl:value-of select="local-name()"/> -
            namespace-uri: <xsl:value-of select="namespace-uri()"/> -
                <xsl:for-each select="attribute::*">
                <xsl:value-of select="name(.)"/>="<xsl:value-of select="."/>" </xsl:for-each>
        </xsl:message>
        <xsl:if test=".!=''">
            <xsl:element name="{name(.)}">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Default rules for MathML -->
    <xsl:template match="*[namespace-uri() = 'http://www.w3.org/1998/Math/MathML']">
        <xsl:message terminate="no">MathML: <xsl:value-of select="name(.)"/> - <xsl:for-each
                select="attribute::*">
                <xsl:value-of select="name(.)"/>="<xsl:value-of select="."/>" </xsl:for-each>
        </xsl:message>
        <xsl:copy-of select="."/>
    </xsl:template>

</xsl:stylesheet>
