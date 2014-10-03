<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:mml="http://www.w3.org/1998/Math/MathML">

    <!-- Default rules -->
    <xsl:template match="*">
        <xsl:message terminate="no">Element inconnu: <xsl:value-of select="name(.)"/> -
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
