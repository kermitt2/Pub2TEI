<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:els="http://www.elsevier.com/xml/ja/dtd"
    xmlns:cals="http://www.elsevier.com/xml/common/cals/dtd"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley" xmlns:wiley2="http://www.wiley.com/namespaces/wiley/wiley" xmlns:m="http://www.w3.org/1998/Math/MathML/"
    xmlns:oasis="http://www.niso.org/standards/z39-96/ns/oasis-exchange/table"
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
    <xsl:template match="fig/credit">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!-- elsevier -->
    <xsl:template match="ce:floats">
        <xsl:apply-templates/>
    </xsl:template>
	<!-- IOP -->
    <xsl:template match="figure">
        <figure>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:if test="@height">
            <xsl:attribute name="rendition">
                <xsl:value-of select="@height"/>
            </xsl:attribute>
            </xsl:if>
            <xsl:if test="@width">
            <xsl:attribute name="rend">
                <xsl:value-of select="@width"/>
            </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="@xsrc">
            <p>
                <xsl:value-of select="@xsrc"/>
            </p>
            </xsl:if>
        </figure>
    </xsl:template>
    <xsl:template match="figure/title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    <xsl:template match="caption/p">
        <xsl:choose>
            <xsl:when test="ancestor::table-wrap">
                <head>
                    <xsl:apply-templates/>
                </head>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="fn">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="normalize-space(.)">
                            <figDesc>
                                <xsl:apply-templates/>
                            </figDesc>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="graphic-file">
        <desc>
            <xsl:if test="@version">
                <xsl:attribute name="type">
                    <xsl:value-of select="@version"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@filename">
                <xsl:attribute name="source">
                    <xsl:value-of select="@filename"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@align">
                <xsl:attribute name="rend">
                    <xsl:value-of select="@align"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@width">
                <xsl:attribute name="rendition">
                    <xsl:value-of select="@width"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </desc>
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
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:mediaResource">
        <xsl:choose>
            <xsl:when test="ancestor::wiley:abstract and not(ancestor::wiley:blockFixed) ">
                <media>
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
                    <media>
                        
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
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="wiley:lineatedText">
        <listBibl>
            <xsl:apply-templates select="wiley:line"/>
        </listBibl>
    </xsl:template>
    <xsl:template match="wiley:line">
        <bibl>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
    
    <!-- SG - reprise traitement des figures wiley -->
    <xsl:template match="wiley:caption">
        <xsl:choose>
            <xsl:when test="ancestor::wiley:supportingInfoItem">
                <desc>
                    <xsl:apply-templates/>
                </desc>
            </xsl:when>
            <xsl:otherwise>
                <figDesc>
                    <xsl:apply-templates/>
                </figDesc>
            </xsl:otherwise>
        </xsl:choose>
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
    <xsl:template match="wiley2:mi | oasis:mi">
        <m:mi>
            <xsl:apply-templates/>
        </m:mi>
    </xsl:template>
    <xsl:template match="wiley2:mo |oasis:mo">
        <m:mo>
            <xsl:apply-templates/>
        </m:mo>
    </xsl:template>
    <xsl:template match="wiley2:mn |oasis:mn">
        <m:mn>
            <xsl:apply-templates/>
        </m:mn>
    </xsl:template>
    <xsl:template match="wiley2:mfrac|oasis:mfrac">
        <m:mfrac>
            <xsl:apply-templates/>
        </m:mfrac>
    </xsl:template>
    <xsl:template match="wiley2:mrow|oasis:mrow">
        <m:mrow>
            <xsl:apply-templates/>
        </m:mrow>
    </xsl:template>
    <xsl:template match="wiley2:msup|oasis:msup">
        <m:msup>
            <xsl:apply-templates/>
        </m:msup>
    </xsl:template>
    <xsl:template match="wiley2:msub|oasis:msub">
        <m:msub>
            <xsl:apply-templates/>
        </m:msub>
    </xsl:template>
    <xsl:template match="wiley2:mover|oasis:mover">
        <m:mover>
            <xsl:apply-templates/>
        </m:mover>
    </xsl:template>
	
</xsl:stylesheet>
