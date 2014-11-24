<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:els="http://www.elsevier.com/xml/ja/dtd" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all">
    
    <xsl:output encoding="UTF-8" method="xml"/>
    
    <!-- ISBN numbers (Springer: BookID) -->
    
    <xsl:template match="BookID">
        <idno type="ISBN">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <!-- Titres des séries (Springer: SeriesTitle) -->
    
    <xsl:template match="SeriesTitle">
        <title level="s">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <!-- Numéro du chapitre dans un ouvrage -->
    
    <xsl:template match="ChapterID">
        <biblScope unit="chap">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    
    
    <!-- Numéro de la série (spécifique à Springer?) -->
    
    <xsl:template match="SeriesID">
        <idno type="seriesID">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
</xsl:stylesheet>