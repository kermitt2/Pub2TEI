<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0" exclude-result-prefixes="#all">
    
    <xsl:template name="Varia2ISO639">
        <xsl:param name="code"/>
        <xsl:choose>
            <xsl:when test="$code='EN' or $code='En' or $code='--'">
                <xsl:text>en</xsl:text>
            </xsl:when>
            <xsl:when test="$code='DE' or $code='De'">
                <xsl:text>de</xsl:text>
            </xsl:when>
            <xsl:when test="$code='FR' or $code='Fr'">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$code"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    
</xsl:stylesheet>
