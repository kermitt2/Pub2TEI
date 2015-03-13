<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:els="http://www.elsevier.com/xml/ja/dtd"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:mml="http://www.w3.org/1998/Math/MathML/"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- Macrostructure -->
    <!-- Springer: Para, SimplePara -->

    <xsl:template match="p | Para | SimplePara | ce:simple-para | ce:note-para | ce:para">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    
    <!-- Lists -->
    
    <xsl:template match="ce:list">
        <list>
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    
    <xsl:template match="ce:list-item">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>

    <!-- Formules mathématiques -->
    <xsl:template match="Formula | formula | inline-formula | disp-formula | ce:formula">
        <formula>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="label">
                <xsl:attribute name="n">
                    <xsl:value-of select="label"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@Notation">
                <xsl:attribute name="notation">
                    <xsl:value-of select="@Notation"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@notation">
                <xsl:attribute name="notation">
                    <xsl:value-of select="@notation"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@content-type">
                <xsl:attribute name="notation">
                    <xsl:value-of select="@content-type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="tex-math/@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="tex-math/@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="name(.)='inline-formula'">
                <xsl:attribute name="rend">
                    <xsl:text>inline</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="name(.)='disp-formula'">
                <xsl:attribute name="rend">
                    <xsl:text>display</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="tex-math">
                    <xsl:attribute name="notation">
                        <xsl:text>TeX</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="tex-math"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </formula>
    </xsl:template>

    <xsl:template match="disp-formula/label"/>


    <!-- Specific rule for Springer's Inline equation -->

    <xsl:template match="InlineEquation | Equation">
        <formula>
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="EquationSource/@Format">
                <xsl:attribute name="notation">
                    <xsl:value-of select="EquationSource/@Format"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="EquationSource"/>
        </formula>
    </xsl:template>

    <!-- Specific rile for Elsevier inline pathematical objects -->

    <xsl:template match="els:math">
        <formula notation="XMLLatex">
            <xsl:copy exclude-result-prefixes="#all">
                <xsl:apply-templates/>
            </xsl:copy>
        </formula>
    </xsl:template>

    <!-- References in text -->
    <!-- citref for RCS (Royal CHemical Society) -->

    <xsl:template match="citref">
        <ref type="bibliography">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@idrefs)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>

    <xsl:template match="schemref">
        <ref type="schema">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@idrefs)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>

    <xsl:template match="figref">
        <ref type="figure">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@idrefs)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>


    <xsl:template match="tableref">
        <ref type="table">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@idrefs)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>
    
    <!-- Elsevier pointers -->
    
    <xsl:template match="ce:float-anchor">
        <ptr target="{concat('#',@refid)}"/>
    </xsl:template>

    <!-- +++++ Tags de formatage +++++++ -->
    <!-- NLM 2.3 article: italic, bold, underline, sub, sup, fn, emph!!-->
    <!-- Sage: it -->
    <!-- Elsevier: ce:italic -->
    <!-- Springer: Emphasis[@Type='Italic'], Emphasis[@Type='Bold'], Subscript, Superscript -->

    <xsl:template
        match="it | ce:italic | Emphasis[@Type='Italic'] | italic | emph[@display='italic']">
        <xsl:if test=".!=''">
            <hi rend="italic"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="bold | ce:bold | Emphasis[@Type='Bold'] | emph[@display='bold']">
        <xsl:if test=".!=''">
            <hi rend="bold"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Emphasis[@Type='SmallCaps'] | ce:small-caps | sc | scp">
        <xsl:if test=".!=''">
            <hi rend="smallCaps"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Emphasis | emph">
        <xsl:if test=".!=''">
            <hi>
                <xsl:choose>
                    <xsl:when test="@Type">
                        <xsl:attribute name="rend">
                            <xsl:value-of select="@Type"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="@FontCategory">
                        <xsl:attribute name="rend">
                            <xsl:value-of select="@FontCategory"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="@display">
                        <xsl:attribute name="rend">
                            <xsl:value-of select="@FontCategory"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Subscript | sub | ce:inf">
        <xsl:if test=".!=''">
            <hi rend="subscript"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Superscript | sup | ce:sup">
        <xsl:if test=".!=''">
            <hi rend="superscript"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="underline | ce:underline">
        <xsl:if test=".!=''">
            <hi rend="underline"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="break">
        <lb/>
    </xsl:template>

    <!-- Footnotes
    Springer: Footnote/@ID-->

    <xsl:template match="fn | Footnote">
        <note place="foot">
            <xsl:if test="@ID">
                <xsl:attribute name="n">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Citation en ligne:
    Springer: BlockQuote-->
    <xsl:template match="BlockQuote">
        <cit>
            <xsl:apply-templates/>
        </cit>
    </xsl:template>

    <xsl:template match="BlockQuote/Para">
        <quote>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    
    <!-- Formarting elements that we discard -->
    
    <xsl:template match="ce:vsp"/>
    
</xsl:stylesheet>
