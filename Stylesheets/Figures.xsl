<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:els="http://www.elsevier.com/xml/ja/dtd"
    xmlns:cals="http://www.elsevier.com/xml/common/cals/dtd"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley" xmlns:wiley2="http://www.wiley.com/namespaces/wiley/wiley" xmlns:m="http://www.w3.org/1998/Math/MathML/"
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

    <xsl:template match="fig/caption/p">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>
    <xsl:template match="fig/credit">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
	
    <!-- Wiley -->
    <xsl:template match="wiley:figure">
        <figure>
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="wiley:label">
                <label>
                <xsl:value-of select="wiley:label"/>
                </label>
            </xsl:if>
            <xsl:if test="wiley:title |wiley:titleGroup/wiley:title ">
                <head>
                    <xsl:value-of select="wiley:title|wiley:titleGroup/wiley:title"/>
                </head>
            </xsl:if>
            <xsl:message><xsl:value-of select="wiley:label"/></xsl:message>
            <xsl:apply-templates select="wiley:mediaResourceGroup"/>
            <xsl:apply-templates select="wiley:caption"/>
        </figure>
    </xsl:template>
    <!-- SG - mimetype -->
    <!--<media mimeType="image/png" url="fig1.png"/>-->
    <xsl:template match="wiley:chemicalStructure/wiley:mediaResourceGroup">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:mediaResourceGroup">
        <xsl:apply-templates select="wiley:mediaResource"/>
    </xsl:template>
    <xsl:template match="wiley:mediaResource">
        <xsl:choose>
            <xsl:when test="ancestor::wiley:abstract and not(ancestor::wiley:blockFixed) ">
                <media>
                    <xsl:if test="ancestor::wiley:chemicalStructure/@xml:id">
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="ancestor::wiley:chemicalStructure/@xml:id"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="@mimeType !=''">
                            <xsl:attribute name="mimeType">
                                <xsl:apply-templates select="@mimeType"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="@alt !=''">
                            <xsl:attribute name="mimeType">
                                <xsl:apply-templates select="@alt"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="mimeType">image</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:attribute name="url">
                        <xsl:apply-templates select="@href"/>
                    </xsl:attribute>
                    <xsl:if test="@rendition">
                        <xsl:attribute name="rendition">
                            <xsl:apply-templates select="@rendition"/>
                        </xsl:attribute>
                    </xsl:if>
                </media>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <media>
                        <xsl:if test="ancestor::wiley:chemicalStructure/@xml:id">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="ancestor::wiley:chemicalStructure/@xml:id"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when test="@mimeType !=''">
                                <xsl:attribute name="mimeType">
                                    <xsl:apply-templates select="@mimeType"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:when test="@alt !=''">
                                <xsl:attribute name="mimeType">
                                    <xsl:apply-templates select="@alt"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="mimeType">image</xsl:attribute>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <xsl:attribute name="url">
                            <xsl:apply-templates select="@href"/>
                        </xsl:attribute>
                        <xsl:if test="@rendition">
                            <xsl:attribute name="rendition">
                                <xsl:apply-templates select="@rendition"/>
                            </xsl:attribute>
                        </xsl:if>
                    </media>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- SG - reprise traitement des figures wiley -->
    <xsl:template match="wiley:caption">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>
    
    <xsl:template match="wiley:caption/wiley:p">
            <xsl:apply-templates/>
    </xsl:template>
    
    <!-- SG - traitement des formula mathML -->
    <xsl:template match="wiley:mathStatement">
        <formula>
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="wiley:title">
                <hi>
                    <xsl:value-of select="wiley:title"/>
                </hi>
            </xsl:if>
            
            <xsl:message><xsl:value-of select="wiley:title"/></xsl:message>
            <xsl:apply-templates select="wiley:p"/>
        </formula>
    </xsl:template>
    
    <!-- SG - WILEY traitement mathml - voir notice ZYGO.ZYGO1222.xml -->
    <xsl:template match="wiley:displayedItem[@type='mathematics']">
            <formula xmlns:m="http://www.w3.org/1998/Math/MathML" notation="mathml">
                <!--xsl:apply-templates select="m:math"/-->
                <xsl:if test="@xml:id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates />
            </formula>
    </xsl:template>
    
    <!-- PL: neutralize Wiley specific presentation attribute in MathML element math -->
    <xsl:template match="@*[local-name()='location']" mode="mathml"/>
    <xsl:template match="@altimg" mode="mathml"/>
    
   <xsl:template match="wiley:displayedItem[@type='mathematics']/wiley:label"/>
    
    <xsl:template match="wiley:displayedItem[@type='mathematics']/wiley2:math">
        <m:math>
            <xsl:apply-templates/>
        </m:math>
    </xsl:template>
    <xsl:template match="wiley2:mi">
        <m:mi>
            <xsl:apply-templates/>
        </m:mi>
    </xsl:template>
    <xsl:template match="wiley2:mo">
        <m:mo>
            <xsl:apply-templates/>
        </m:mo>
    </xsl:template>
    <xsl:template match="wiley2:mn">
        <m:mn>
            <xsl:apply-templates/>
        </m:mn>
    </xsl:template>
    <xsl:template match="wiley2:mfrac">
        <m:mfrac>
            <xsl:apply-templates/>
        </m:mfrac>
    </xsl:template>
    <xsl:template match="wiley2:mrow">
        <m:mrow>
            <xsl:apply-templates/>
        </m:mrow>
    </xsl:template>
    <xsl:template match="wiley2:msup">
        <m:msup>
            <xsl:apply-templates/>
        </m:msup>
    </xsl:template>
    <xsl:template match="wiley2:msub">
        <m:msub>
            <xsl:apply-templates/>
        </m:msub>
    </xsl:template>
    <xsl:template match="wiley2:mover">
        <m:mover>
            <xsl:apply-templates/>
        </m:mover>
    </xsl:template>
	
</xsl:stylesheet>
