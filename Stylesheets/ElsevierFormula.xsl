<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:els1="http://www.elsevier.com/xml/ja/dtd"    
    xmlns:els2="http://www.elsevier.com/xml/cja/dtd"
    xmlns:s1="http://www.elsevier.com/xml/si/dtd"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    >

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="els1:formula |els2:formula">
        <formula>
            <xsl:apply-templates/>
        </formula>
    </xsl:template>
    
    <xsl:template match="els1:cp">
        <els1:cp type="{@type}">
            <xsl:apply-templates/>
        </els1:cp>
    </xsl:template>
    <xsl:template match="els2:cp">
        <els2:cp type="{@type}">
            <xsl:apply-templates/>
        </els2:cp>
    </xsl:template>
    
    <xsl:template match="els1:ll">
        <els1:ll>
            <xsl:apply-templates/>
        </els1:ll>
    </xsl:template>
    <xsl:template match="els2:ll">
        <els2:ll>
            <xsl:apply-templates/>
        </els2:ll>
    </xsl:template>
        
    <xsl:template match="els1:fen">
        <els1:fen>
            <xsl:apply-templates/>
        </els1:fen>
    </xsl:template>
    <xsl:template match="els2:fen">
        <els2:fen>
            <xsl:apply-templates/>
        </els2:fen>
    </xsl:template>
    
    <xsl:template match="els1:lim">
        <els1:lim>
            <xsl:apply-templates/>
        </els1:lim>
    </xsl:template>
    <xsl:template match="els2:lim">
        <els2:lim>
            <xsl:apply-templates/>
        </els2:lim>
    </xsl:template>
    
    <xsl:template match="els1:op">
        <els1:op>
            <xsl:apply-templates/>
        </els1:op>
    </xsl:template>
    <xsl:template match="els2:op">
        <els2:op>
            <xsl:apply-templates/>
        </els2:op>
    </xsl:template>
    
    <xsl:template match="els1:inf">
        <els1:inf>
            <xsl:apply-templates/>
        </els1:inf>
    </xsl:template>
    <xsl:template match="els2:inf">
        <els2:inf>
            <xsl:apply-templates/>
        </els2:inf>
    </xsl:template>
    
    <xsl:template match="els1:rm">
        <els1:rm>
            <xsl:apply-templates/>
        </els1:rm>
    </xsl:template>
    <xsl:template match="els2:rm">
        <els2:rm>
            <xsl:apply-templates/>
        </els2:rm>
    </xsl:template>
    
    <xsl:template match="els1:sup">
        <els1:sup>
            <xsl:apply-templates/>
        </els1:sup>
    </xsl:template>
    <xsl:template match="els2:sup">
        <els2:sup>
            <xsl:apply-templates/>
        </els2:sup>
    </xsl:template>
    
    <xsl:template match="els1:de">
        <els1:de>
            <xsl:apply-templates/>
        </els1:de>
    </xsl:template>
    <xsl:template match="els2:de">
        <els2:de>
            <xsl:apply-templates/>
        </els2:de>
    </xsl:template>
    
    <xsl:template match="els1:nu">
        <els1:nu>
            <xsl:apply-templates/>
        </els1:nu>
    </xsl:template>
    <xsl:template match="els2:nu">
        <els2:nu>
            <xsl:apply-templates/>
        </els2:nu>
    </xsl:template>
    
    <xsl:template match="els1:fr">
        <els1:fr>
            <xsl:apply-templates/>
        </els1:fr>
    </xsl:template>
    <xsl:template match="els2:fr">
        <els2:fr>
            <xsl:apply-templates/>
        </els2:fr>
    </xsl:template>
    
    <xsl:template match="els1:ul">
        <els1:ul>
            <xsl:apply-templates/>
        </els1:ul>
    </xsl:template>
    <xsl:template match="els2:ul">
        <els2:ul>
            <xsl:apply-templates/>
        </els2:ul>
    </xsl:template>
    
    
</xsl:stylesheet>
