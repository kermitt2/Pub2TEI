<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley"
	exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- Références bibliographiques à la fin d'un article -->
    <!-- ref-list: NLM article, ScholarOne -->

    <xsl:template match="ref-list | biblist | ce:bibliography | bibl | wiley:bibliography">
        <div type="references">
            <xsl:apply-templates select="title | ce:section-title"/>
            <listBibl>
               <xsl:for-each select="wiley:bib">
                <bibl>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name="corresp">
                        <xsl:variable name="bib">
                            <xsl:for-each select="wiley:citation/@xml:id">
                                <xsl:text> #</xsl:text>
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </xsl:variable>
                            <xsl:value-of select="normalize-space($bib)"/>
                    </xsl:attribute>
                </bibl>
                </xsl:for-each>
                
               <xsl:for-each select="wiley:bibSection/wiley:bib">
                    <bibl>
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <xsl:attribute name="corresp">
                            <xsl:variable name="bib">
                                <xsl:for-each select="wiley:citation/@xml:id">
                                    <xsl:text> #</xsl:text>
                                    <xsl:value-of select="."/>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:value-of select="normalize-space($bib)"/>
                        </xsl:attribute>
                    </bibl>
                </xsl:for-each>
                
                <xsl:apply-templates select="ref | citgroup | ce:bibliography-sec | bib | wiley:bib | wiley:bibSection"/>
            </listBibl>
        </div>
    </xsl:template>

    <xsl:template match="ce:bibliography-sec">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Références simples Elsevier -->

    <xsl:template match="ce:bib-reference[ce:other-ref]">
        <bibl xml:id="{@id}" n="{ce:label}">
            <xsl:apply-templates select="*[name()!='ce:label']"/>
        </bibl>
    </xsl:template>

    <xsl:template match="ce:other-ref">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:textref">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Références complexes Elsevier -->

    <!-- Traitement des références structurées Elsevier -->

    <xsl:template match="ce:bib-reference[sb:reference]">
        <biblStruct xml:id="{@id}" n="{ce:label}">
            <analytic>
                <xsl:apply-templates select="sb:reference/sb:contribution/*"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="sb:reference/sb:host/sb:issue/sb:series/sb:title/*"/>
                <imprint>
                    <xsl:apply-templates
                        select="sb:reference/sb:host/sb:issue/sb:series/*[name()!='sb:title']"/>
                    <xsl:apply-templates select="sb:reference/sb:host/sb:issue/sb:date"/>
                    <xsl:apply-templates select="sb:reference/sb:host/sb:pages/*"/>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>


    <!-- Journal paper -->

    <xsl:template match="ref[*/@citation-type='journal']">
        <xsl:call-template name="createArticle">
            <xsl:with-param name="entry" select="*[@citation-type='journal']"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Journal paper -->
    
    <xsl:template match="ref[*/@citation-type='web']">
        <xsl:call-template name="createArticle">
            <xsl:with-param name="entry" select="*[@citation-type='web']"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Journal paper in RCS -->

    <xsl:template match="citgroup">
        <xsl:call-template name="createArticle">
            <xsl:with-param name="entry" select="journalcit"/>
        </xsl:call-template>
    </xsl:template>


    <xsl:template name="createArticle">
        <xsl:param name="entry"/>
        <biblStruct type="article">
            <xsl:attribute name="xml:id">
                <xsl:apply-templates select="$entry/@id | @id"/>
            </xsl:attribute>
            <xsl:if test="$entry/article-title">
            <analytic>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="$entry/article-title"/>
                <!-- All authors are included here -->
                    <xsl:apply-templates select="$entry/person-group | $entry/citauth | $entry/name"/>
                <xsl:apply-templates select="$entry/object-id"/>
            </analytic>
            </xsl:if>
            <monogr>
                <xsl:apply-templates select="$entry/source | $entry/title"/>
                <xsl:if test="not($entry/article-title)">
                    <xsl:apply-templates select="$entry/person-group"/>
                </xsl:if>
                <xsl:apply-templates select="$entry/citauth | $entry/name"/>
                <xsl:apply-templates select="$entry/comment"/>
                <xsl:choose>
                   <xsl:when test="$entry/year | $entry/volume | $entry/volumeno |$entry/issue | $entry/descendant::fpage|$entry/descendant::lpage">
                <imprint>
                    <xsl:apply-templates select="$entry/year"/>
                    <xsl:apply-templates select="$entry/volume | $entry/volumeno"/>
                    <xsl:apply-templates select="$entry/issue"/>
                    <xsl:apply-templates select="$entry/descendant::fpage"/>
                    <xsl:apply-templates select="$entry/descendant::lpage"/>
                </imprint>
                   </xsl:when>
                   <xsl:otherwise>
                       <imprint>
                           <date/>
                       </imprint>
                   </xsl:otherwise>
               </xsl:choose>
            </monogr>
            <xsl:apply-templates select="nlm-citation/pub-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Reference to a journal article (3.0 style) -->
    <xsl:template match="ref[element-citation/@publication-type='journal']">
        <xsl:call-template name="createArticle">
            <xsl:with-param name="entry" select="*[@publication-type='journal']"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Conference paper - generic -->

    <xsl:template match="ref[*/@citation-type='confproc']">
        <xsl:call-template name="createInConf">
            <xsl:with-param name="entry" select="*[@citation-type='confproc']"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="createInConf">
        <xsl:param name="entry"/>
        <biblStruct type="inproceedings">
            <xsl:apply-templates select="@id"/>
            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="$entry/person-group"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="$entry/article-title"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="$entry/source"/>
                <xsl:apply-templates select="$entry/conf-name"/>
                <imprint>
                    <xsl:apply-templates select="$entry/year"/>
                    <xsl:apply-templates select="$entry/volume"/>
                    <xsl:apply-templates select="$entry/issue"/>
                    <xsl:apply-templates select="$entry/fpage"/>
                    <xsl:apply-templates select="$entry/lpage"/>
                </imprint>
            </monogr>
            <xsl:apply-templates select="$entry/pub-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Reference to a conference paper (3.0 style) -->
    <xsl:template match="ref[*/@publication-type='confproc']">
        <xsl:call-template name="createInConf">
            <xsl:with-param name="entry" select="*[@publication-type='confproc']"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Book - generic -->

    <xsl:template match="ref[*/@citation-type='book']">
        <xsl:call-template name="createBook">
            <xsl:with-param name="entry" select="*[@citation-type='book']"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Reference to a book (old style)

    <xsl:template match="ref[*/@publication-type='book']">
        <xsl:call-template name="createBook">
            <xsl:with-param name="entry" select="*[@publication-type='book']"/>
        </xsl:call-template>
    </xsl:template>-->

    <xsl:template name="createBook">
        <xsl:param name="entry"/>
        <biblStruct type="book">
            <xsl:attribute name="xml:id">
                <xsl:apply-templates select="$entry/@id | @id"/>
            </xsl:attribute>
            <xsl:if test="$entry/article-title">
                <analytic>
                    <xsl:apply-templates select="$entry/source"/> 
                </analytic>
            </xsl:if>
            <monogr>
                <!-- All authors are included here -->
                <xsl:apply-templates select="$entry/person-group"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="$entry/source"/>
                <imprint>
                    <xsl:apply-templates select="$entry/year"/>
                    <xsl:apply-templates select="$entry/publisher-loc"/>
                    <xsl:apply-templates select="$entry/publisher-name"/>
                    <xsl:apply-templates select="$entry/fpage"/>
                    <xsl:apply-templates select="$entry/lpage"/>
                    <xsl:apply-templates select="$entry/edition"/>
                </imprint>
            </monogr>
            <xsl:apply-templates select="$entry/pub-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Unspecified reference (old style) -->
    <xsl:template match="ref">
        <xsl:choose>
            <xsl:when test="note">
                <bibl type="note">
                    <xsl:apply-templates/>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="citation">
                <bibl type="article">
                    <xsl:choose>
                        <xsl:when test="citation/@id">
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="citation/@id"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="xml:id">
                                <xsl:apply-templates select="@id"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:apply-templates select="citation"/>
                </bibl>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="citation">
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="note">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Unspecified reference (3.0 style) -->
   <xsl:template match="ref[mixed-citation]">
        <bibl>
            <xsl:apply-templates select="@id"/>
            <xsl:apply-templates select="mixed-citation"/>
        </bibl>
    </xsl:template>

    <xsl:template match="mixed-citation">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="conf-name">
        <meeting>
            <xsl:apply-templates/>
        </meeting>
    </xsl:template>

    <xsl:template match="elocation-id">
        <idno type="elocation-id">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>

    <xsl:template match="person-group[@person-group-type='author']">
        <xsl:apply-templates select="name" mode="authors"/>
        <xsl:apply-templates select="collab" mode="authors"/>
    </xsl:template>

    <xsl:template match="person-group[@person-group-type='editor']">
        <xsl:apply-templates mode="editors"/>
    </xsl:template>

    <xsl:template match="person-group">
        <xsl:apply-templates mode="authors"/>
    </xsl:template>

    <xsl:template match="name" mode="editors">
        <editor>
            <xsl:apply-templates select="."/>
        </editor>
    </xsl:template>

    <xsl:template match="name" mode="authors">
        <author>
            <xsl:apply-templates select="."/>
            <xsl:if test="following-sibling::*[1][name()='aff']/email">
                <xsl:apply-templates select="following-sibling::*[1][name()='aff']/email"/>
            </xsl:if>
        </author>
    </xsl:template>
    <xsl:template match="collab" mode="authors">
        <author>
            <name>
            <xsl:value-of select="."/>
            </name>
        </author>
    </xsl:template>

    <xsl:template match="string-name | citauth | wiley:author">
        <xsl:choose>
            <xsl:when test="ancestor::name-alternatives">
                <persName type="byline">
                    <xsl:apply-templates/>
                </persName>
            </xsl:when>
            <xsl:otherwise>
                <author>
                    <persName>
                        <xsl:apply-templates select="surname"/>
                        <xsl:apply-templates select="given-names"/>
                        <xsl:apply-templates select="wiley:givenNames"/>
                        <xsl:apply-templates select="wiley:familyName"/>
                    </persName>
                </author>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- SG ajout refs groupName -->
    <xsl:template match="wiley:groupName">
        <author>
            <orgName>
                <xsl:apply-templates/>
            </orgName>
        </author>
    </xsl:template>
    
    <xsl:template match="wiley:url">
        <xsl:text> </xsl:text>
        <idno type="url">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    
    <xsl:template match="wiley:editor">
        <editor>
            <persName>
                <xsl:apply-templates/>
            </persName>
        </editor>
    </xsl:template>

    <!-- Journal information for <monogr> -->
    <xsl:template match="source">
        <title level="j">
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <xsl:template match="pub-id">
        <idno>
            <xsl:attribute name="type">
                <xsl:value-of select="@pub-id-type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <xsl:template match="object-id">
        <idno>
            <xsl:attribute name="type">doi</xsl:attribute>
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <!-- Generic transformation of the @id attribute -->
    <!-- If the source contains duplicated values (it does exist!) than the duplicated are renamed by order of appearance -->

    <xsl:template match="@id">
        <xsl:variable name="countIdenticalBefore">
            <xsl:value-of
                select="count(./preceding::*/@id[.=current()]) + count(./parent::*/ancestor::*/@id[.=current()])"
            />
        </xsl:variable>
        <xsl:attribute name="xml:id">
            <xsl:choose>
                <xsl:when test="$countIdenticalBefore=0">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(.,'-',$countIdenticalBefore)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <!-- Titles -->

    <!-- Elsevier -->

    <xsl:template match="sb:maintitle">
        <xsl:choose>
            <xsl:when test="ancestor::sb:series/sb:title">
                <title level="a" type="main">
                <xsl:apply-templates/>
                </title>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Dates -->

    <!-- Elsevier -->
    <xsl:template match="sb:date">
        <date when="{.}">
            <xsl:apply-templates/>
        </date>
    </xsl:template>

    <!-- Authors -->

    <xsl:template match="sb:authors">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sb:et-al">
        <author role="et-al"/>
    </xsl:template>

    <xsl:template match="sb:author | refau">
        <author>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
	
    <xsl:template match="bib">
        <biblStruct>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
			<analytic>
				<xsl:apply-templates select="reftxt/atl"/>
            	<xsl:apply-templates select="reftxt/refau"/>
			    <!-- SG : ajout de "et al." -->
			    <xsl:if test="contains(reftxt/i,'et al')">
			        <author>et al.</author>
			    </xsl:if>
			</analytic>
			<monogr>
			    <xsl:if test="reftxt/jtl | reftxt/btl">
			        <xsl:apply-templates select="reftxt/jtl | reftxt/btl"/>
			    </xsl:if>
				<imprint>
				    <xsl:choose>
				        <xsl:when test="reftxt/vid | reftxt/ppf  | reftxt/ppl  | reftxt/cd">
				            <xsl:apply-templates select="reftxt/vid | reftxt/ppf  | reftxt/ppl  | reftxt/cd"/>
				        </xsl:when>
				        <xsl:otherwise>
				            <!-- ajout <publisher> vide pour validation TEI quand <imprint> est vide -->
				            <publisher/>
				        </xsl:otherwise>
				    </xsl:choose>
				</imprint>	
			</monogr>	
        </biblStruct>
    </xsl:template>
	
	<xsl:template match="wiley:bibSection">
	    <xsl:apply-templates/>
	</xsl:template>
    <xsl:template match="wiley:bib | wiley:bibSection/wiley:bib">
        <!-- SG - reprise ref structurées et ref non structurées -->
        <xsl:variable name="id">
            <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <xsl:for-each select="wiley:citation">
        <xsl:choose>
            <xsl:when test="wiley:articleTitle | wiley:journalTitle">
               <biblStruct type="journal">
                  <xsl:attribute name="corresp">
                      <xsl:text>#</xsl:text>
                       <xsl:value-of select="$id"/>
                   </xsl:attribute>
                   <xsl:attribute name="xml:id">
                       <xsl:value-of select="@xml:id"/>
                   </xsl:attribute>
                   <xsl:if test="wiley:articleTitle | wiley:chapterTitle | wiley:author | wiley:groupName">
                    <analytic>
                        <xsl:apply-templates select="wiley:articleTitle"/>
                        <!-- SG - ajout chapterTitle -->
                        <xsl:apply-templates select="wiley:chapterTitle"/>
                        <xsl:apply-templates select="wiley:author"/>
                        <xsl:apply-templates select="wiley:groupName"/>
                    </analytic>
                   </xsl:if>
                    <monogr>	
                        <xsl:apply-templates select="wiley:journalTitle"/>
                        <!-- SG - reprise imprint vide -->
                        <xsl:choose>
                            <xsl:when test="wiley:vol|wiley:pageFirst|wiley:pageLast|wiley:pubYear">
                                <imprint>
                                    <xsl:apply-templates select="wiley:vol"/>
                                    <xsl:apply-templates select="wiley:issue"/>
                                    <xsl:apply-templates select="wiley:pageFirst"/>
                                    <xsl:apply-templates select="wiley:pageLast"/>
                                    <xsl:apply-templates select="wiley:pubYear"/>
                                </imprint>	 
                            </xsl:when>
                            <xsl:otherwise>
                                <imprint><date/></imprint>
                            </xsl:otherwise>
                        </xsl:choose>
                    </monogr>	
                </biblStruct>
            </xsl:when>
            <!-- SG - ajout book / book-series -  chapterTitle -->
            <xsl:when test="wiley:bookSeriesTitle">
                <biblStruct type="book-series">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <analytic>
                        <xsl:apply-templates select="wiley:author"/>
                        <xsl:apply-templates select="wiley:editor"/>
                        <xsl:apply-templates select="wiley:chapterTitle"/></analytic>
                    <monogr>	
                        <xsl:apply-templates select="wiley:bookTitle"/>
                        <!-- SG - reprise imprint vide -->
                        <xsl:choose>
                            <xsl:when test="wiley:vol|wiley:pageFirst|wiley:pageLast|wiley:pubYear">
                                <imprint>
                                    <xsl:apply-templates select="wiley:vol"/>
                                    <xsl:apply-templates select="wiley:pageFirst"/>
                                    <xsl:apply-templates select="wiley:pageLast"/>
                                    <xsl:apply-templates select="wiley:pubYear"/>
                                </imprint>	 
                            </xsl:when>
                            <xsl:otherwise>
                                <imprint><date/></imprint>
                            </xsl:otherwise>
                        </xsl:choose>
                    </monogr>
                    <xsl:if test="wiley:bookSeriesTitle">
                        <series>	
                            <xsl:apply-templates select="wiley:bookSeriesTitle"/>
                        </series>
                    </xsl:if>
                </biblStruct>
            </xsl:when>
            <!-- SG - reprise refs book -->
            <xsl:when test="wiley:bookTitle">
                <biblStruct type="book">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:if test="wiley:chapterTitle">
                        <analytic>
                            <xsl:apply-templates select="wiley:author"/>
                            <xsl:apply-templates select="wiley:editor"/>
                            <xsl:apply-templates select="wiley:chapterTitle"/>
                        </analytic>
                    </xsl:if>
                    <monogr>
                        <xsl:apply-templates select="wiley:bookTitle"/>
                        <xsl:if test="not(wiley:chapterTitle)">
                        <xsl:apply-templates select="wiley:author"/>
                        <xsl:apply-templates select="wiley:editor"/>
                        </xsl:if>
                        
                        <xsl:choose>
                            <xsl:when test="wiley:vol|wiley:pageFirst|wiley:pageLast|wiley:pubYear">
                                <imprint>
                                    <xsl:apply-templates select="wiley:vol"/>
                                    <xsl:apply-templates select="wiley:pageFirst"/>
                                    <xsl:apply-templates select="wiley:pageLast"/>
                                    <xsl:apply-templates select="wiley:pubYear"/>
                                    <xsl:apply-templates select="wiley:publisherLoc"/>
                                    <xsl:apply-templates select="wiley:publisherName"/>
                                </imprint>	 
                            </xsl:when>
                            <xsl:otherwise>
                                <imprint><date/></imprint>
                            </xsl:otherwise>
                        </xsl:choose>
                    </monogr>
                </biblStruct> 
            </xsl:when>
            <xsl:when test="wiley:otherTitle">
                <biblStruct type="other">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <analytic>
                        <xsl:apply-templates select="wiley:otherTitle"/>
                        <xsl:apply-templates select="wiley:groupName"/>
                        <xsl:apply-templates select="wiley:author"/>
                        <xsl:apply-templates select="wiley:editor"/>
                    </analytic>
                    <monogr>	
                        <xsl:apply-templates select="wiley:journalTitle"/>
                        <!-- SG reprise lien url dans référence -->
                        <xsl:if test="wiley:url">
                            <idno type="URI">
                                <xsl:apply-templates select="wiley:url"/>  
                            </idno>
                        </xsl:if>
                        <!-- SG - reprise imprint vide -->
                        <xsl:choose>
                            <xsl:when test="wiley:vol|wiley:pageFirst|wiley:pageLast|wiley:pubYear">
                                <imprint>
                                    <xsl:apply-templates select="wiley:vol"/>
                                    <xsl:apply-templates select="wiley:pageFirst"/>
                                    <xsl:apply-templates select="wiley:pageLast"/>
                                    <xsl:apply-templates select="wiley:pubYear"/>
                                </imprint>	 
                            </xsl:when>
                            <xsl:otherwise>
                                <imprint><date/></imprint>
                            </xsl:otherwise>
                        </xsl:choose>
                    </monogr>	
                </biblStruct> 
            </xsl:when>
            <xsl:otherwise>
                    <bibl type="other">
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </bibl>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
