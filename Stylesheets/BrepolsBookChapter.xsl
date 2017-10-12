<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:param name="issueXmlPath" />
    <xsl:variable name="docIssue" select="document($issueXmlPath)" />
<!-- todo : abstract niveau supérieur book / series
    todo: issue
    todo: completer book-categories
    todo : publisher depuis $docIssue
    todo : type de publication / type de contenu-->
    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="/book">
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:if test="//body/book-part/@xml:lang[string-length()&gt; 0]">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="//body/book-part/@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="//body/book-part/book-part-meta/title-group/title"/>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <publisher scheme="https://publisher-list.data.istex.fr/ark:/67375/H02-N14T76M9-6">Brepols Publishers</publisher>
                       <!-- <xsl:if test="//ArticleGrants/BodyPDFGrant[string(@Grant)='OpenAccess']">
                            <availability status="free">
                                <p>Open Access</p>
                            </availability>
                        </xsl:if>-->
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:apply-templates select="//book-part" mode="sourceDesc"/>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="//body/book-part/book-part-meta/abstract">
                    <profileDesc>
                        <xsl:apply-templates
                            select="//body/book-part/book-part-meta/abstract"
                        />
                        <xsl:if test="//body/book-part/@xml:lang[string-length()&gt; 0]">
                            <langUsage>
                                <language>
                                    <xsl:attribute name="ident">
                                        <xsl:value-of select="//body/book-part/@xml:lang"/>
                                    </xsl:attribute>
                                </language>
                            </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
            </teiHeader>
        </TEI>
    </xsl:template>

    <!-- Building the sourceDesc bibliographical representation -->
    <xsl:template match="book-part" mode="sourceDesc">
        <biblStruct>
            <analytic>
                <!-- Title information related to the chapter goes here -->
                <xsl:apply-templates select="//body/book-part/book-part-meta/title-group/title"/>
                <!-- All authors are included here -->
                <xsl:apply-templates select="//body/book-part/book-part-meta/contrib-group/contrib"/>
                <!-- ajout identifiants ISTEX et ARK -->
                <xsl:if test="string-length($idistex) &gt; 0 ">
                    <idno type="istex">
                        <xsl:value-of select="$idistex"/>
                    </idno>
                </xsl:if>
                <xsl:if test="string-length($arkistex) &gt; 0 ">
                    <idno type="ark">
                        <xsl:value-of select="$arkistex"/>
                    </idno>
                </xsl:if>
                <xsl:if test="//book/book-meta/book-id[@pub-id-type='doi']">
                    <idno type="DOI">
                        <xsl:value-of select="//book/book-meta/book-id[@pub-id-type='doi']"/>
                    </idno>
                </xsl:if>
            </analytic>
            <monogr>
                <xsl:apply-templates select="//book/book-meta/book-title-group/book-title"/>
                <xsl:apply-templates select="//book/book-meta/book-title-group/subtitle"/>
                <xsl:apply-templates select="$docIssue//book-meta/contrib-group/contrib"/>
                <xsl:apply-templates select="$docIssue//book-meta/contrib-group/isbn"/>
                <xsl:apply-templates select="//body/book-part/book-part-meta/book-part-id[@pub-id-type='doi']"/>
                
                <imprint>
                    <!-- traiter volume numéro pubdate depuis fichier externe -->
                    <xsl:apply-templates select="$docIssue//body/book-meta/pub-date/year"/>
                    <xsl:apply-templates select="$docIssue//body/book-meta/volume"/>
                    <xsl:apply-templates select="//body/book-part/book-part-meta/fpage"/>
                    <xsl:apply-templates select="//body/book-part/book-part-meta/lpage"/>
                </imprint>
            </monogr>
            <!-- faire un if et gérer le niveau série dans fichier externe -->
            <xsl:if test="$docIssue//book-series-meta/book-title-group/book-title">
                <series>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-title-group/book-title"/>
                    
                    <xsl:apply-templates select="SeriesInfo/SeriesTitle"/>
                    <xsl:apply-templates select="SeriesInfo/SeriesPrintISSN"/>
                    <xsl:apply-templates select="SeriesInfo/SeriesElectronicISSN"/>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-id[@pub-id-type='doi']"/>
                    <xsl:apply-templates select="$docIssue//book-series-meta/book-id[@pub-id-type='publisher-id']"/>
                </series>
            </xsl:if>
        </biblStruct>
    </xsl:template>

</xsl:stylesheet>
