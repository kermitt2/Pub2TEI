<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:els="http://www.elsevier.com/xml/ja/dtd" exclude-result-prefixes="#all"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    >

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="els:formula">
        <formula>
            <xsl:apply-templates/>
        </formula>
    </xsl:template>
    
    <xsl:template match="els:cp">
        <els:cp type="{@type}">
            <xsl:apply-templates/>
        </els:cp>
    </xsl:template>
    
    <xsl:template match="els:ll">
        <els:ll>
            <xsl:apply-templates/>
        </els:ll>
    </xsl:template>
        
    <xsl:template match="els:fen">
        <els:fen>
            <xsl:apply-templates/>
        </els:fen>
    </xsl:template>
    
    <xsl:template match="els:lim">
        <els:lim>
            <xsl:apply-templates/>
        </els:lim>
    </xsl:template>
    
    <xsl:template match="els:op">
        <els:op>
            <xsl:apply-templates/>
        </els:op>
    </xsl:template>
    
    <xsl:template match="els:inf">
        <els:inf>
            <xsl:apply-templates/>
        </els:inf>
    </xsl:template>
    
    <xsl:template match="els:rm">
        <els:rm>
            <xsl:apply-templates/>
        </els:rm>
    </xsl:template>
    
    <xsl:template match="els:sup">
        <els:sup>
            <xsl:apply-templates/>
        </els:sup>
    </xsl:template>
    
    <xsl:template match="els:de">
        <els:de>
            <xsl:apply-templates/>
        </els:de>
    </xsl:template>
    
    <xsl:template match="els:nu">
        <els:nu>
            <xsl:apply-templates/>
        </els:nu>
    </xsl:template>
    
    <xsl:template match="els:fr">
        <els:fr>
            <xsl:apply-templates/>
        </els:fr>
    </xsl:template>
    
    <xsl:template match="els:ul">
        <els:ul>
            <xsl:apply-templates/>
        </els:ul>
    </xsl:template>
    
    
</xsl:stylesheet>
