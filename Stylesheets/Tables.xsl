<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns="http://www.tei-c.org/ns/1.0">
    
    <!-- Royal Chemical Society: table-entry; NLM: table-wrap -->
    <xsl:template match="table-entry | table-wrap">
        <figure type="table">
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>
    
    <xsl:template match="table-entry/title | table-wrap/label">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    <xsl:template match="table-wrap-foot">
        <ab type="table-wrap-foot">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>
    
    <xsl:template match="table-wrap-foot/fn">
        <note place="inline">
            <xsl:if test="@fn-type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@fn-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    
    <xsl:template match="thead/tr">
        <row role="label">
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    
    <xsl:template match="thead">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tbody">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="table-entry/table | table-wrap/table">
        <ab>
            <table>
                <xsl:apply-templates/>
            </table>
        </ab>
    </xsl:template>
    
    <xsl:template match="array">
        <ab type="array">
            <table>
                <xsl:apply-templates/>
            </table>
        </ab>
    </xsl:template>
    
    <xsl:template match="tr">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    
    <xsl:template match="th">
        <cell role="th">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    
    <xsl:template match="td">
        <cell role="td">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    
    
    
</xsl:stylesheet>