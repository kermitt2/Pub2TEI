<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:els="http://www.elsevier.com/xml/ja/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley" 
	xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:variable name="journalList" select="document('JournalList.xml')"/>

    <!-- Article title -->
    <!-- NLM V2.0: ArticleTitle -->
    <!-- NLM V2.3 article: article-title, alt-title, atl -->
    <!-- BMJ: article-title -->
    <!-- Elsevier: ce:title -->
    <!-- Sage: art_title -->
    <!-- Springer: ArticleTitle -->
    <!-- ScholarOne: article_title, article_sub_title -->
    <!-- EDP: ArticleTitle/Title -->

    <xsl:template
        match="fm/atl |article-title/title | ArticleTitle | article-title | atl | ce:title | art_title | article_title | nihms-submit/title | ArticleTitle/Title | ChapterTitle |wiley:chapterTitle | titlegrp/title | sb:title | wiley:articleTitle | wiley:otherTitle">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="main">
                <!--xsl:choose>
                    <xsl:when test="wiley:citation[@type='book']"></xsl:when>
                </xsl:choose-->
                <xsl:if test="@Language">
                    <xsl:attribute name="xml:lang">
                        <xsl:choose>
                            <xsl:when test="@Language='--'">
                                <xsl:text>en</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="Varia2ISO639">
                                    <xsl:with-param name="code" select="@Language"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    <!--SG - <topic> dans titre remplacé par <hi>-->
    <xsl:template match="atl/topic">
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <!-- BMJ: short-title -->
    <xsl:template match="short-title">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="short">
                <xsl:if test="@Language">
                    <xsl:attribute name="xml:lang">
                        <xsl:call-template name="Varia2ISO639">
                            <xsl:with-param name="code" select="@Language"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="subtitle | article_sub_title">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="sub">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="vernacular_title">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="vernacular">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="alt-title">
        <title level="a" type="{@alt-title-type}">
            <xsl:choose>
                <xsl:when test="@alt-title-type">
                    <xsl:attribute name="type">
                        <xsl:value-of select="@alt-title-type"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type">
                        <xsl:text>alt</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <!-- Elements for general Journal components in ScholarOne (full_journal_title, journal_abbreviation) -->
    <!-- Elements for general Journal components in ArticleSetNLM 2.0 (JournalTitle, Issn) -->
    <!-- NLM 2.3 article: journal-title, journal-id, abbrev-journal-title -->
    <!-- Elements for general Journal components in SAGE (jrn_title, ISSN) -->
    <!-- Elements for general Journal components in Springer Stage2 (JournalTitle) -->
    <!-- Nature: journal-title -->
    <!-- Elsevier: els:jid, ce:issn -->

    <xsl:template match="j-title | JournalTitle | full_journal_title | jrn_title | journal-title | tei:cell[@role='Journal'] | journalcit/title | jtl | wiley:journalTitle">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    <xsl:template match="suppttl">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="sub">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout des refs book -->
    <xsl:template
        match="wiley:bookTitle">
        <xsl:if test="normalize-space(.)">
            <title level="m" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout des refs series -->
    <xsl:template
        match="wiley:bookSeriesTitle">
        <xsl:if test="normalize-space(.)">
            <title level="s" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="btl">
        <xsl:if test="normalize-space(.)">
            <title level="m" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <!-- Additional journal namings -->

    <xsl:template match="journal_abbreviation | abbrev-journal-title | els:jid | JournalShortTitle | j-shorttitle">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="abbrev">
                <xsl:value-of select="normalize-space()"/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="pubmed_abbreviation">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="pubmed">
                <xsl:value-of select="normalize-space()"/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="journal-id">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="{@journal-id-type}">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="j-edpsname | JournalEDPSName">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="EDPSName">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <!-- Issue titles -->
    <xsl:template match="issue_description | issue-title | IssueTitle">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="issue">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <!-- ISSN numbers -->
    <!-- Nature issn/@pub-type -->
    <!-- BMJ: issn/@issn_type -->
    <!-- NLM 2.3 article: issn -->
    <!-- Elsevier: ce:issn -->
    <!-- Rem.: @pub-typr not considered -->

    <xsl:template match="Issn | ISSN | issn | ce:issn">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="ISSNCode">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>ISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>
            <idno type="ISSN">
                <xsl:value-of select="$ISSNCode"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="JournalPrintISSN | issn[@issn_type='print'] | issn[@pub-type='ppub'] | PrintISSN | issn-paper | SeriesPrintISSN | issn[@type='print'] | wiley:issn[@type='print'] ">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="ISSNCode">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <!-- Vieux morceau de code du projet PEER où l'on vérifiait dans une liste de journaux... -->
            <!--<xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>pISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>-->
            <idno type="pISSN">
                <xsl:value-of select="$ISSNCode"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="JournalElectronicISSN | ElectronicISSN | issn[@issn_type='digital'] | issn[@pub-type='epub'] | issn-elec | SeriesElectronicISSN | issn[@type='electronic'] | wiley:issn[@type='electronic']">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="ISSNCode">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <!-- Vieux morceau de code du projet PEER où l'on vérifiait dans une liste de journaux... -->
            <!--<xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>eISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>-->
            <idno type="eISSN">
                <xsl:value-of select="$ISSNCode"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- SG - ajout DOI niveau book - pour matcher avec les reversement du Hub de métadonnées-->
    <xsl:template match="wiley:publicationMeta[@level='product']/wiley:doi">

        <xsl:if test="normalize-space(.)">
            <xsl:variable name="DOIValue" select="string(.)"/>
            <idno type="book-DOI">
                <xsl:choose>
                    <xsl:when test=" starts-with($DOIValue,'DOI')">
                        <xsl:value-of select="normalize-space( substring-after($DOIValue,'DOI'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($DOIValue)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- DOI numbers -->
    <!-- BMJ: doi -->
    <!-- Elsevier: ce:doi -->
    <!-- NLM 2.3 article: article-id[@pub-id-type='doi'] -->

    <xsl:template
        match="article_id[@id_type='doi'] | article-id[@pub-id-type='doi'] | ArticleDOI | doi | ArticleId[@IdType='doi'] | ce:doi | @doi | DOI | ChapterDOI | wiley:publicationMeta[@level='unit']/wiley:doi">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="DOIValue" select="string(.)"/>
            <idno type="DOI">
                <xsl:choose>
                    <xsl:when test=" starts-with($DOIValue,'DOI')">
                        <xsl:value-of select="normalize-space( substring-after($DOIValue,'DOI'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($DOIValue)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:publicationMeta[@level='unit']/wiley:idGroup/wiley:id">
            <idno type="article-ID">
                <xsl:apply-templates select="@value"/>
            </idno>
    </xsl:template>

    <!-- pii -->
    <!-- Elsevier: ce:pii -->
    <!-- Scholar one: article_id[@id_type='pii'] -->
    <!-- NLM 2.2:  article-id[@pub-id-type='pii'] -->


    <xsl:template
        match="ce:pii | article_id[@id_type='pii'] | article-id[@pub-id-type='pii'] | ArticleId[@IdType='pii']">
        <xsl:if test="normalize-space(.)">
            <idno type="PII">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
            <xsl:if test="//publisher-name = 'Cambridge University Press'">
                <idno type="publisherID">
                    <xsl:value-of select="normalize-space(.)"/>
                </idno>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <!-- Manuscript number -->
    <!-- BMJ: manuscript-number; Springer: ArticleID -->

    <xsl:template match="manuscript-number | @ms_no | ArticleID ">
        <xsl:if test="normalize-space(.)">
            <idno type="manuscript">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- Publisher IDs when different from above -->
    <!-- NLM 2.2: article-id[@pub-id-type='publisher-id'] -->

    <xsl:template
        match="article-id[@pub-id-type='publisher-id'] | els:aid  | EDPSRef | edps-ref | Article/@ID">
        <xsl:if test="normalize-space(.) and not(//publisher-name = 'Cambridge University Press')">
            <idno type="publisherID">
                <xsl:value-of select="."/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- Elements for Imprint components in ScholarOne (volume, issue) -->
    <!-- Elements for Imprint components in ArticleSetNLM 2.0 (Volume, Issue, FirstPage, LastPage) -->
    <!-- NLM 2.3 article: volume, issue, fpage, lpage -->
    <!-- Elements for Imprint components in SAGE (vol, iss, spn, epn) -->
    <!-- Elements for Imprint components in Springer Stage 2 (VolumeID, IssueID, FirstPage, LastPage) -->
    <!-- Elements for Imprint components in Springer Stage 3 (ArticleFirstPage, ArticleLastPage) -->
    <!-- Elements for Imprint components in BMJ (issue-number, volume) -->
    <!-- Elements for Imprint components in Elsevier () -->
    
    <xsl:template match="vol | Volume | VolumeID | volume | volumeref | volumeno | sb:volume-nr | vid | wiley:numbering[@type='journalVolume'] | wiley:vol">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="vol">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <!-- 2 special rules for Springer that provides, beginning and end volume number -->

    <xsl:template match="VolumeIDStart">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="vol" from="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <xsl:template match="VolumeIDEnd">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="vol" to="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>


    <!-- Rule for RCS data -->
    <xsl:template match="volumeref/link">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="iss | Issue | issue | issue-number | IssueID | issueref | wiley:numbering[@type='journalIssue']">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="issue">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <!-- 2 special rules for Springer that provides, beginning and end volume number -->

    <xsl:template match="IssueIDStart">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="issue" from="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <xsl:template match="IssueIDEnd">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="issue" to="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <!-- Rule for RCS data -->
    <xsl:template match="issueref/link">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- we do not consider the number of issues in a volume (Springer <Publisher>) -->

    <xsl:template match="VolumeIssueCount"/>

    <!-- Pagination -->

    <xsl:template match="spn | FirstPage | ArticleFirstPage | fpage | first-page | sb:first-page | ChapterFirstPage | ppf | wiley:numbering[@type='pageFirst'] | wiley:pageFirst">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="page" from="{normalize-space(.)}">
                <xsl:value-of select="normalize-space(.)"/>
            </biblScope>
        </xsl:if>
    </xsl:template>

<!-- SG: nettoyage caractéres polluants dans les données -->
    <xsl:template match="epn | LastPage | ArticleLastPage | lpage | last-page | ChapterLastPage | sb:last-page | ppl | wiley:numbering[@type='pageLast'] | wiley:pageLast">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="page" to="{translate(.,'normalize-space(.)','')}">
                <xsl:value-of select="translate(.,'normalize-space(.)','')"/>
            </biblScope>
        </xsl:if>
    </xsl:template>
    
    <!--SG - ajout nombre de pages -->
    <xsl:template match="wiley:count[@type='pageTotal']">
        <xsl:if test="normalize-space(@number)">
            <biblScope unit="count-page">
                <xsl:value-of select="@number"/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <!-- Publishers -->
    <!-- NLM V2.0: PublisherName -->
    <!-- NLM V2.3 article: publisher-loc, publisher-name  -->
    <!-- BMJ: publisher_name ??????, publisher-loc -->
    <!-- ScholarOne: publisher_name -->
    <!-- Sage: pub_name, pub_location -->
    <!-- Springer: PublisherName, PublisherLocation -->

    <xsl:template
        match="PublisherName | publisher_name | pub_name | publisher-name | tei:cell[@role='Publisher'] | wiley:publisherName">
        <xsl:if test="normalize-space(.)">
            <publisher>
                <xsl:apply-templates/>
            </publisher>
        </xsl:if>
    </xsl:template>

    <xsl:template match="publisher-loc | pub_location | PublisherLocation | wiley:publisherLoc">
        <xsl:if test="normalize-space(.)">
            <pubPlace>
                <xsl:apply-templates/>
            </pubPlace>
        </xsl:if>
    </xsl:template>

    <xsl:template match="reftxt/cd">
        <date>
            <xsl:attribute name="when">
                <!-- SG reprise de la date (ex:nrn3258_subject.xml)(26 Aug  2011)
                cibler sur attribut @year et non plus sur le text() + PL: cleaning of alphabetical characters in the year string -->
                    <!--xsl:apply-templates select="@year"/-->
					<xsl:value-of select="replace(@year, '[a-zA-Z]', '')"/>
			</xsl:attribute> 
        </date>
    </xsl:template>
	
    <!-- SG: nettoyage caractéres polluants dans les données -->
    <xsl:template match="wiley:pubYear">
        <date>
            <xsl:attribute name="when">
                <xsl:choose>
                    <xsl:when test="@year">
                            <xsl:value-of select="translate(@year,',.[a-zA-Z]','')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(.,',.[a-zA-Z]','')"/>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:attribute>
        </date>
    </xsl:template>
	
	<xsl:template match="wiley:titleGroup/wiley:title">
		<xsl:apply-templates/>
	</xsl:template>

</xsl:stylesheet>
