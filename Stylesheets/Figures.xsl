<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:els="http://www.elsevier.com/xml/ja/dtd"
    xmlns:cals="http://www.elsevier.com/xml/common/cals/dtd"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley"
	exclude-result-prefixes="#all" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0">

    <!-- NPG -->
    <xsl:template match="bm/fig">
        <figure>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="figtl | caption"/>
        </figure>
    </xsl:template>

    <xsl:template match="fig/figtl">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="fig/caption">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>
	
	<!-- Wiley -->
    <xsl:template match="wiley:figure">
        <figure>
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
			<xsl:apply-templates select="wiley:label"/>
<xsl:message><xsl:value-of select="wiley:label"/></xsl:message>			
            <xsl:apply-templates select="wiley:caption"/>
        </figure>
    </xsl:template>
	
    <xsl:template match="wiley:caption">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>
	
</xsl:stylesheet>
