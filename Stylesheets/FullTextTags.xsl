<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:els="http://www.elsevier.com/xml/ja/dtd"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:mml="http://www.w3.org/1998/Math/MathML/" 
	xmlns:wiley="http://www.wiley.com/namespaces/wiley"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- Macrostructure -->
    <!-- Springer: Para, SimplePara -->

    <xsl:template match="p | Para | SimplePara | ce:simple-para | ce:note-para | ce:para | wiley:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- SG Nature <crosshd> Titre paragraphe -->
    <xsl:template match="crosshd">
        <p><hi rend="bold"><xsl:apply-templates/></hi></p>
    </xsl:template>
    <!-- SG Nature reprise balise bi -->
    <xsl:template match="bi">
        <hi rend="bold italic"><xsl:apply-templates/></hi>
    </xsl:template>
    <!-- SG Nature reprise balise bxr texte contenu dans des box dans colonne externe-->
    <xsl:template match="bxr">
        <ref type="box">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <xsl:template match="bx">
        <!-- SG - encapsulage dans div -->
        <div>
        <floatingText type="box">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <body>
                <xsl:apply-templates/>
            </body>
        </floatingText>
        </div>
    </xsl:template>
    <xsl:template match="bxtitle">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    <xsl:template match="li">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
    <!-- SG Nature reprise fnr -->
    <xsl:template match="fnr">
        <ref type="footnote">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <!-- SG Nature reprise illustration -->
    <xsl:template match="illus">
        <figure>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            <xsl:if test="caption/p">
                <figDesc>
                    <xsl:value-of select="caption/p"/> 
                </figDesc>
            </xsl:if>
            <xsl:if test="credit">
                <p>
                    <xsl:value-of select="credit"/> 
                </p>
            </xsl:if>
        </figure>
    </xsl:template>
    <!-- SG Nature reprise deflistr -->
    <xsl:template match="deflistr">
        <ref>
            <xsl:attribute name="type">definition</xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>#</xsl:text>
               <xsl:apply-templates select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <!-- SG supplementary information -->
    <xsl:template match="sir">
        <ref>
            <xsl:attribute name="type">suppinfo</xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>#</xsl:text>
                <xsl:apply-templates select="@rid"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <xsl:template match="scientific">
        <ref>
            <xsl:attribute name="corresp">
                <xsl:apply-templates select="@id"/>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:apply-templates select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="subtype">
                <xsl:apply-templates select="@dbtype"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <xsl:template match="weblink">
        <ref>
            <xsl:attribute name="target">
                <xsl:apply-templates select="@url"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <xsl:template match="deflist">
        <list>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </list>
    </xsl:template>
    <xsl:template match="deflist/@type">
        <xsl:attribute name="type">gloss</xsl:attribute>
    </xsl:template>
    <xsl:template match="deflist/term">
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>
    <xsl:template match="deflist/defn">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
    <!-- SG - Nature: nettoyage du <bdy> polluant -->
    <xsl:template match="bdy"/>
    <!-- SG - Nature: nettoyage des auteurs coincés dans le bdy (ex:nature_body_corres.xml) -->
    <xsl:template match="bdy/corres/aug"/>
    <xsl:template match="deflist/@colwd"/>
    <xsl:template match="deflist/@sepch"/>
    <!-- SG - Nature: nettoyage du <linkgrp> polluant -->
    <xsl:template match="linkgrp"/>
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
    <xsl:template match="f|Formula | formula | inline-formula | disp-formula | ce:formula">
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
    
    <xsl:template match="wiley:link">
		<!-- for wiley we don't know in advance which type of object is referenced but 
		it seems that we can use the identifier string to have a reliable information -->
		<xsl:choose>
			<xsl:when test="string-length(@href) > 0">
				<!--xsl:message><xsl:value-of select="substring(@href,2,1)"/></xsl:message-->
				<xsl:if test="contains(@href, 'n')">
					<!-- we have a note (normally) -->
			        <ref type="note">
			            <xsl:attribute name="target">
			                <xsl:value-of select="@href"/>
			            </xsl:attribute>
						<xsl:apply-templates/>
					</ref>	
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>	
				<xsl:if test="substring(@href,2,1) = 'b'">
					<ref type="bibr">
			            <xsl:attribute name="target">
			                <xsl:value-of select="@href"/>
			            </xsl:attribute>
						<xsl:value-of select="text()"/>
			        </ref>
				</xsl:if>
				<xsl:if test="substring(@href,2,1) = 'f'">
					<ref type="figure">
			            <xsl:attribute name="target">
			                <xsl:value-of select="@href"/>
			            </xsl:attribute>
						<xsl:value-of select="text()"/>
			        </ref>
				</xsl:if>
				<xsl:if test="substring(@href,2,1) = 't'">
					<ref type="table">
		            	<xsl:attribute name="target">
		                	<xsl:value-of select="@href"/>
		            	</xsl:attribute>
						<xsl:value-of select="text()"/>
		        	</ref>
				</xsl:if>
			</xsl:otherwise>	
		</xsl:choose>
    </xsl:template>
	
    <xsl:template match="greeting">
        <salute>
            <xsl:apply-templates/>
        </salute>
    </xsl:template>
    
    <xsl:template match="bibr | bibrinl">
        <ref type="bibr">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>
    <!-- SG ajout ref <xnav> -->
    <xsl:template match="xnav">
        <ref type="bibr">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@extrefid)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>
	
    <xsl:template match="figr">
        <ref type="figure">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <!-- SG - ajout illustration à figure -->
    <xsl:template match="illusr">
        <ref type="figure">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="tablr">
        <ref type="table">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
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
        match="i | it | ce:italic | Emphasis[@Type='Italic'] | italic | emph[@display='italic'] | wiley:i">
        <xsl:if test=".!=''"><hi rend="italic"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>

    <xsl:template match="bold | ce:bold | Emphasis[@Type='Bold'] | emph[@display='bold'] | wiley:b | b">
        <xsl:if test=".!=''"><hi rend="bold"><xsl:apply-templates/></hi></xsl:if>
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

    <xsl:template match="inf|Subscript | sub | ce:inf | wiley:sub">
        <xsl:if test=".!=''"><hi rend="subscript"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>

    <xsl:template match="Superscript | sup | ce:sup | super | wiley:sup">
        <xsl:if test=".!=''"><hi rend="superscript"><xsl:apply-templates/></hi></xsl:if>
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
    
	<!-- Entity markers (NPG) -->
	<xsl:template match="named-entity"><rs><xsl:apply-templates/></rs></xsl:template>
	
    <xsl:template match="sec">
        <div>
            <xsl:attribute name="n">
                <xsl:value-of select="@level"/>
            </xsl:attribute>
            <xsl:apply-templates select="sectitle | p"/>
		</div>
    </xsl:template>
	
    <xsl:template match="sectitle">
        <head>
			<xsl:apply-templates/>
		</head>	
    </xsl:template>
	
    <xsl:template match="wiley:section">
        <div>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
			<xsl:if test="wiley:title">
		        <head>
		            <xsl:apply-templates select="wiley:title"/>
				</head>
			</xsl:if>	
			<xsl:apply-templates select="* except (wiley:title|wiley:figure|wiley:tabular|wiley:noteGroup)"/>
		</div>
    </xsl:template>
	
	<xsl:template match="wiley:section/wiley:title">
		<xsl:apply-templates/>
	</xsl:template>	
	
    <xsl:template match="wiley:url">
        <ref type="url">
          	<xsl:value-of select="@href"/>
		</ref>	
    </xsl:template>
	
	<!-- no idea what it this <sc> tag in Wiley - apparently a styling element -->
    <xsl:template match="wiley:sc">
        <xsl:apply-templates/>
    </xsl:template>
	
    <xsl:template match="online-methods"><xsl:apply-templates/></xsl:template>
	
</xsl:stylesheet>
