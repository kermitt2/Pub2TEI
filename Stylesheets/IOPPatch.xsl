<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0" 
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="#all">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Feb 24, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> romary</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:output encoding="UTF-8" method="xml"/>
    
    <xsl:template match="*[namespace-uri()='http://www.tei-c.org/ns/1.0']">
        <xsl:copy>
            <xsl:apply-templates select="@* | * | text() | comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* | text()">
        <xsl:copy/>
    </xsl:template>
    
   
</xsl:stylesheet>
