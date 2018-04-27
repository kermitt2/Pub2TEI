<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:els1="http://www.elsevier.com/xml/ja/dtd"    
    xmlns:els2="http://www.elsevier.com/xml/cja/dtd"
    xmlns:s1="http://www.elsevier.com/xml/si/dtd"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:mml="http://www.w3.org/1998/Math/MathML/" xmlns:xlink="http://www.w3.org/1999/xlink" 
	xmlns:wiley="http://www.wiley.com/namespaces/wiley"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- Macrostructure -->
    <!-- Springer: Para, SimplePara -->

    <xsl:template match="p| ce:simple-para | ce:note-para | ce:para">
        <xsl:choose>
            <!--RSC plusieurs titres dans le titre contenu par des p-->
            <xsl:when test="ancestor::title">
                <title>
                <xsl:apply-templates/>
                </title>
            </xsl:when>
            <xsl:when test="child::boxref">
                    <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="ancestor::ce:floats">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="ancestor::ce:caption">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="child::statement">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>
                            <xsl:if test="@id">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="@id"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="Para | SimplePara">
        <xsl:choose>
            <xsl:when test="ancestor::DefinitionListEntry/Description">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:if test="@id">
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="quotation">
        <quote>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    
    <!-- wiley tabularFixed -->
    <xsl:template match="wiley:tabularFixed">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:p">
        <p>
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"></xsl:value-of>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <!--<xsl:apply-templates select="*[not(self::wiley:mathStatement)]"/>-->
        </p>
        <!--xsl:apply-templates select="wiley:mathStatement"/-->
    </xsl:template>
    <!-- ajout élément sourceà <figure> -->
    <xsl:template match="wiley:source">
            <source>
                <xsl:apply-templates/>
            </source>
    </xsl:template>
    <xsl:template match="wiley:mathStatement/wiley:p">
        <xsl:text> </xsl:text>
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:biographyInfo/wiley:p">
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:infoAsset">
        <term>
            <xsl:if test="@type">
                <xsl:attribute name="type">
                <xsl:value-of select="translate(@type,' ','_')"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <!--xsl:apply-templates select="*[not(self::mathStatement)]"/-->
        </term>
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
    <xsl:template match="item">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
    
    <!-- SG - ajout des listes pour wiley -->
    <xsl:template match="wiley:list">
        <list>
            <xsl:if test="@xml:id">
                <xsl:copy-of select="@xml:id"/>  
            </xsl:if>
            <xsl:if test="@style">
                <xsl:copy-of select="@style"/>  
            </xsl:if>
            <xsl:apply-templates/>
        </list>
    </xsl:template>
   <xsl:template match="wiley:listItem/wiley:label">
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="wiley:listItem">
        <item>
            <xsl:if test="wiley:label[string-length()&gt;0]">
                <xsl:attribute name="n">
                    <xsl:apply-templates select="wiley:label"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="wiley:p">
                    <xsl:apply-templates select="wiley:p"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="wiley:accessionId[string-length()&gt;0]">
                <idno>
                    <xsl:value-of select="wiley:accessionId"/>
                </idno>
            </xsl:if>
        </item>
    </xsl:template>
    
    <!-- SG - ajout wiley floatingText -->
    <xsl:template match="wiley:blockFixed">
        <figure type="box">
                <xsl:apply-templates select="wiley:mediaResourceGroup | wiley:p"/>
            <xsl:apply-templates select="wiley:lineatedText"/>
        </figure>
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
        <xsl:choose>
            <xsl:when test="parent::mixed-citation">
                <emph>
                    <xsl:apply-templates/>
                </emph>
            </xsl:when>
            <xsl:otherwise>
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
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="disp-formula/label"/>


    <!-- Specific rule for Springer's Inline equation -->

    <xsl:template match="InlineEquation | Equation">
        <xsl:choose>
            <xsl:when test="ancestor::Description">
                <objectType>
                    <xsl:if test="EquationNumber">
                        <xsl:attribute name="n">
                            <xsl:value-of select="EquationNumber"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </objectType>
            </xsl:when>
            <xsl:otherwise>
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
                    <xsl:if test="EquationNumber">
                        <xsl:attribute name="n">
                            <xsl:value-of select="EquationNumber"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </formula>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Specific rile for Elsevier inline pathematical objects -->

    <!-- 2017-04-03: Vérifier le traitement des éléments de XMLLatex -->
    <xsl:template match="els1:math |els2:math | math">
        <formula notation="MathML">
            <xsl:copy exclude-result-prefixes="#all">
                <xsl:apply-templates/>
            </xsl:copy>
        </formula>
    </xsl:template>
    
    <!-- SG - WILEY ajout élément latex -->
    <xsl:template match="wiley:span[@type='tex']">
        <hi>
            <formula notation="TeX">
                <!-- http://www.tei-c.org/release/doc/tei-p5-doc/fr/html/examples-formula.html -->
                <xsl:apply-templates/>
            </formula>
        </hi>
    </xsl:template>
    
    <!-- SG - WILEY traitement mathml - voir notice ZYGO.ZYGO1222.xml -->
   <!-- <xsl:template match="wiley:displayedItem[@type='mathematics']">
        <formula notation="mathml">
        <xsl:apply-templates/>
        </formula>
    </xsl:template>
    <xsl:template match="wiley:displayedItem[@type='mathematics']/wiley:label"/>-->
    
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
				<xsl:choose>
				    <!-- SG ajout reference WILEY -->
				    <xsl:when test="contains(@href,'b') or contains(@href,'bib')">
				        <ref type="bibl">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:apply-templates/>
				        </ref>
				    </xsl:when>
				    <xsl:when test="contains(@href, 'n')">
				        <!-- we have a note (normally) -->
				        <ref type="note">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:apply-templates/>
				        </ref>
				    </xsl:when>
				    
				    <xsl:when test="contains(@href,'sec')">
				        <ref type="section">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:apply-templates/>
				        </ref>
				    </xsl:when>
				    <xsl:when test="contains(@href,'t')">
				        <ref type="table">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:value-of select="text()"/>
				        </ref>
				    </xsl:when>
				    <xsl:when test="contains(@href,'f')">
				        <ref type="figure">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:value-of select="text()"/>
				        </ref>
				    </xsl:when>
				    <!--SG - Enriched Object ex:<link href="#aoc1856-eo-0001"/> -->
				    <xsl:when test="contains(@href, 'eo')">
				        <!-- we have an Enriched Object -->
				        <ref type="enrichedObject">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:apply-templates/>
				        </ref>	
				    </xsl:when>
				    <!-- SG ajout lien figure et bibr --> 
				    <xsl:when test="contains(@href, 'fig')">
				        <ref type="figure">
				            <xsl:attribute name="target">
				                <xsl:value-of select="@href"/>
				            </xsl:attribute>
				            <xsl:apply-templates/>
				        </ref>	
				    </xsl:when>
				</xsl:choose>
			   <!-- <xsl:if test="contains(@href, 'bib')">
			        <ref type="bibl">
			            <xsl:attribute name="target">
			                <xsl:value-of select="@href"/>
			            </xsl:attribute>
			            <xsl:apply-templates/>
			        </ref>	
			    </xsl:if>-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="contains(@href,'bib')">
					<ref type="bibl">
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
        <ref type="bibl">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('#',@rid)"/>
            </xsl:attribute>
        </ref>
    </xsl:template>
    <xsl:template match="cite">
        <ref type="cit">
            <xsl:attribute name="target">
                <xsl:text>#</xsl:text>
                <xsl:value-of select="@id|@linkend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <xsl:template match="secref">
        <ref type="section">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@linkend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    <!-- SG ajout ref <xnav> -->
    <xsl:template match="xnav">
        <ref type="bibl">
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
    <xsl:template match="scheme">
        <figure type="schema">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:attribute name="rendition">
                <xsl:value-of select="@height"/>
            </xsl:attribute>
            <xsl:attribute name="rend">
                <xsl:value-of select="@width"/>
            </xsl:attribute>
            <xsl:if test="@xsrc">
            <figDesc>
                <xsl:value-of select="@xsrc"/>
            </figDesc>
            </xsl:if>
        </figure>
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
    
    <xsl:template match="ancref">
        <ref type="anchor" target="{concat('#',@rid)}">
            <xsl:apply-templates/>
        </ref>
    </xsl:template>
    
    <xsl:template match="anchor">
        <anchor xml:id="{@id}"/>
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
        match="i  | ce:italic | Emphasis[@Type='Italic'] | italic | emph[@display='italic'] | wiley:i">
        <xsl:if test="normalize-space(.)"><hi rend="italic"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>

    <xsl:template match="bold | ce:bold | Emphasis[@Type='Bold'] | emph[@display='bold'] | wiley:b | b|bo">
    <xsl:choose>
        <xsl:when test="ancestor::label">
                <head type="label">
                    <hi rend="italic"><xsl:apply-templates/></hi>
                </head>
        </xsl:when>
        <xsl:when test="child::volume">
            <biblScope unit="vol">
                <hi rend="italic">
            <xsl:apply-templates/>
                </hi>
            </biblScope>
        </xsl:when>
        <xsl:otherwise>
            <xsl:if test="normalize-space(.)">
                <hi rend="italic">
                    <xsl:apply-templates/>
                </hi></xsl:if>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:template>

    <xsl:template match="Emphasis[@Type='SmallCaps'] | ce:small-caps | sc | scp | wiley:sc">
        <xsl:if test="normalize-space(.)">
            <hi rend="smallCaps"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Emphasis | emph">
        <xsl:if test="normalize-space(.)">
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
        <xsl:if test="."><hi rend="subscript"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>

    <xsl:template match="Superscript | sup | ce:sup | super | wiley:sup">
        <xsl:if test="."><hi rend="superscript"><xsl:apply-templates/></hi></xsl:if>
    </xsl:template>

    <xsl:template match="ul |underline | ce:underline">
        <xsl:if test=".">
            <hi rend="underline"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>
    <xsl:template match="scr">
        <xsl:if test=".">
            <hi rend="script"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="break">
        <xsl:choose>
            <xsl:when test="ancestor::aff"/>
            <xsl:otherwise><lb/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="wiley:fc">
        <xsl:if test=".">
            <hi rend="fc"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:fr">
        <xsl:if test=".">
            <hi rend="fr"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:fi">
        <xsl:if test=".">
            <hi rend="fi"><xsl:apply-templates/></hi>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:span">
        <xsl:if test=".">
            <emph><span><xsl:apply-templates/></span></emph>
        </xsl:if>
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
	
    <xsl:template match="sectitle |heading">
        <head>
			<xsl:apply-templates/>
		</head>	
    </xsl:template>
	
    <xsl:template match="wiley:body/wiley:section">
        <div>
            <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
            </xsl:if>
            <!-- SG - ajout numéro de section -->
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="contains(@xml:id,'sec')">
                <xsl:attribute name="type">section</xsl:attribute>
            </xsl:if>
            <xsl:if test="@type">
                <xsl:attribute name="subtype">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
			<xsl:if test="wiley:title">
		        <head>
		            <xsl:apply-templates select="wiley:title"/>
				</head>
			</xsl:if>
			<xsl:apply-templates select="* except (wiley:title)"/>
        </div>
    </xsl:template>
    <xsl:template match="wiley:section/wiley:section">
        <div>
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <!-- SG - ajout numéro de section -->
            <xsl:if test="@xml:id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="contains(@xml:id,'sec')">
                <xsl:attribute name="type">section</xsl:attribute>
            </xsl:if>
            <xsl:if test="wiley:title">
                <head>
                    <xsl:apply-templates select="wiley:title"/>
                </head>
            </xsl:if>
            <xsl:apply-templates select="* except (wiley:title)"/>
        </div>
    </xsl:template>
    <xsl:template match="wiley:abstract/wiley:section">
        <xsl:apply-templates/>
    </xsl:template>
	
	<xsl:template match="wiley:section/wiley:title">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- SG ajout citation "other" -->
    <xsl:template match="wiley:citation [@type='other']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="wiley:p/wiley:url">
        <ref type="url">
          	<xsl:value-of select="@href"/>
		</ref>	
    </xsl:template>
	
	<!-- no idea what it this <sc> tag in Wiley - apparently a styling element -->
   <!-- <xsl:template match="wiley:sc">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <!-- SG reprise wiley:inlineGraphic dans body -->
    <xsl:template match="wiley:inlineGraphic | inline-graphic">
        <graphic>
            <xsl:if test="normalize-space(@location)">
                <xsl:attribute name="url">
                    <xsl:value-of select="@location"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="normalize-space(@xlink:href)">
                <xsl:attribute name="url">
                    <xsl:value-of select="@xlink:href"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="normalize-space(@alt)">
                <xsl:attribute name="rend">
                    <xsl:value-of select="@alt"/>
                </xsl:attribute>
            </xsl:if>
        </graphic>
    </xsl:template>
	
    <xsl:template match="online-methods"><xsl:apply-templates/></xsl:template>
    <xsl:template match="wiley:header/wiley:contentMeta/wiley:supportingInformation">
        <xsl:apply-templates select="wiley:supportingInfoItem"/>
    </xsl:template>
    <!-- reprise supportingInformation -->
    <xsl:template match="wiley:supportingInfoItem">
        <div type="appendice">
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>
    <!-- SG - traitement des book-reviews -->
    <xsl:template match="wiley:header/wiley:contentMeta/wiley:titleGroup/wiley:title/wiley:citation">
        <div type="review-of">
            <bibl>
                <xsl:apply-templates/>
            </bibl>
        </div>
    </xsl:template>
</xsl:stylesheet>
