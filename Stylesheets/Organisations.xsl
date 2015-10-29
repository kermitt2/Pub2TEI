<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0" exclude-result-prefixes="#all">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 27, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> romary</xd:p>
            <xd:p>Parsing of organisation names to detect the type of orgName</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="identifyOrgLevel">
        <xsl:param name="theOrg"/>
        <xsl:choose>
            <xsl:when test="contains($theOrg,'Universi') or contains($theOrg,'Academy') or contains($theOrg,'Pasteur') or starts-with($theOrg,'Inserm')">
                <xsl:text>institution</xsl:text>
            </xsl:when>
            <xsl:when test="contains($theOrg,'Depart') or contains($theOrg,'Dept') or contains($theOrg,'Dipart') or contains($theOrg,'Départ') or contains($theOrg,'School') or contains($theOrg,'Facul') or starts-with($theOrg,'Insti')">
                <xsl:text>department</xsl:text>
            </xsl:when>
            <xsl:when test="contains($theOrg,'Unit') or contains($theOrg,'Labo') or contains($theOrg,'Servic')">
                <xsl:text>laboratory</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Org inconnue: <xsl:value-of select="$theOrg"/></xsl:message>
                <xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
