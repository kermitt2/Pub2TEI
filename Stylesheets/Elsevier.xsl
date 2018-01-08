<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" 
    xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:els1="http://www.elsevier.com/xml/ja/dtd"    
    xmlns:els2="http://www.elsevier.com/xml/cja/dtd"
    xmlns:s1="http://www.elsevier.com/xml/si/dtd"
    xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
    exclude-result-prefixes="xsi mml els1 els2 s1 sb ce xlink">
    <xsl:output encoding="UTF-8" method="xml"/>
    
    <xsl:include href="ElsevierFormula.xsl"/>
    <xsl:variable name="docIssueEls" select="document($issueXmlPath)" />
    <xsl:variable name="titre">
        <xsl:choose>
            <xsl:when test="//ce:doi='10.1016/S0140-7007(01)00037-8'">
                <xsl:text>A Word from the Director / Le mot du Directeur</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0923-5965(97)00056-8'">
                <xsl:text>Foreword</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0377-8398(00)00009-8'">
                <xsl:text>Introduction : Nannoplankton ecology and palaeoecology</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0012'">
                <xsl:text>Book review : The Pacific Islands Food Composition Tables by C. A. Dignan, B. A. Burlingame, J. M. Arthur, R. J. Quigley, and G. C. Milligan</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0165-1684(98)00205-9'">
                <xsl:text>Editorial</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0013'">
                <xsl:text>Book review : Fats and Fatty Acids in New Zealand Foods, by R. J. Quigley, B. A. Burlingame, G. C. Milligan, and J. J. Gibson</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0014'">
                <xsl:text>Book review : Quality and Accessibility of Food Related Data, by Heather Greenfield</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0142-9418(00)00029-5'">
                <xsl:text>Editorial</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0168-9002(99)01283-8'">
                <xsl:text>Index</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1053/smrv.1999.0085'">
                <xsl:text>Table of contents</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S1049-3867(01)00088-3'">
                <xsl:text>Erratum to 'An Intersection of Women’s and Perinatal Health: The Role of Chronic Disease'</xsl:text>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0009-2509(99)00312-7'">
                <xsl:text>Erratum to 'Conversion-temperature trajectories for well mixed adsorptive reactorsa'</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="textfn">
                    <xsl:value-of select="//ce:dochead/ce:textfn"/>
                </xsl:variable>
                <xsl:value-of select="normalize-space($textfn)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- code genre -->
    <xsl:variable name="codeGenre1Elsevier">
        <xsl:value-of select="//@docsubtype[string-length() &gt; 0]"/>
    </xsl:variable>
    <xsl:variable name="codeGenreElsevier">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='abs'">Abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='add'">Addendum</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='adv'">Advertisement</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ann'">Announcement</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='brv'">Book review</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cal'">Calendar</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cnf'">Conference</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='chp'">Other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='con'">Contents list</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cor'">Correspondence</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='dis'">Discussion</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='dup'">Duplicate</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='edb'">Editorial board</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='edi'">Editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='err'">Erratum</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='exm'">Examination</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='fla'">Full-length article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ind'">Index</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='lit'">Literature alert</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='mis'">Miscellaneous</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='nws'">News</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ocn'">Other contents</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='pnt'">Patent report</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='prp'">Personal report</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='prv'">Product review</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='pub'">Publisher’s note</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='rem'">Removal</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='req'">Request for assistance</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ret'">Retraction</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='rev'">Review article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='sco'">Short communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ssu'">Short survey</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='other'">other</xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="codeGenre2Elsevier">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='abs'">abstract</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='add'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='adv'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ann'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='brv'">book-reviews</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cal'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='chp'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cnf'">conference</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='con'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='cor'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='dis'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='dup'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='edb'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='edi'">editorial</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='err'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='exm'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='fla'">research-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ind'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='lit'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='mis'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='nws'">article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ocn'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='pnt'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='prp'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='prv'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='pub'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='rem'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='req'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ret'">other</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='rev'">review-article</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='sco'">brief-communication</xsl:when>
            <xsl:when test="normalize-space($codeGenre1Elsevier)='ssu'">article</xsl:when>
            <xsl:otherwise>other</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="codeGenreArkElsevier">
        <xsl:choose>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='research-article'">https://content-type.data.istex.fr/ark:/67375/XTP-1JC4F85T-7</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='article'">https://content-type.data.istex.fr/ark:/67375/XTP-6N5SZHKN-D</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='other'">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='book-reviews'">https://content-type.data.istex.fr/ark:/67375/XTP-PBH5VBM9-4</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='abstract'">https://content-type.data.istex.fr/ark:/67375/XTP-HPN7T1Q2-R</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='review-article'">https://content-type.data.istex.fr/ark:/67375/XTP-L5L7X3NF-P</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='brief-communication'">https://content-type.data.istex.fr/ark:/67375/XTP-S9SX2MFS-0</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='editorial'">https://content-type.data.istex.fr/ark:/67375/XTP-STW636XV-K</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='case-report'">https://content-type.data.istex.fr/ark:/67375/XTP-29919SZJ-6</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='conference'">https://content-type.data.istex.fr/ark:/67375/XTP-BFHXPBJJ-3</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='chapter'">https://content-type.data.istex.fr/ark:/67375/XTP-CGT4WMJM-6</xsl:when>
            <xsl:when test="normalize-space($codeGenre2Elsevier)='book'">https://content-type.data.istex.fr/ark:/67375/XTP-94FB0L8V-T</xsl:when>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="els1:article[els1:item-info] |els2:article[els2:item-info] | els1:converted-article[els1:item-info] | els2:converted-article[els2:item-info] | converted-article[item-info] | article[item-info]">
        <xsl:comment>
            <xsl:text>Version 0.1 générée le </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <xsl:if test="@xml:lang">
                <xsl:copy-of select="@xml:lang"/>
            </xsl:if>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:choose>
                            <xsl:when test="els1:head/ce:title | els2:head/ce:title |head/ce:title ='' or not(els1:head/ce:title | els2:head/ce:title |head/ce:title)">
                                <title level="a" type="main">
                                    <xsl:value-of select="$titre"/>
                                </title>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="els1:head/ce:title |els2:head/ce:title | head/ce:title"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </titleStmt>
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <xsl:apply-templates
                            select="els1:item-info/ce:copyright |els2:item-info/ce:copyright | item-info/ce:copyright"/>
                    </publicationStmt>
                    <!-- SG - ajout du codeGenre article et revue -->
                    <notesStmt>
                        <!-- niveau article / chapter -->
                        <note type="content-type">
                            <xsl:choose>
                                <xsl:when test="//@docsubtype[string-length() &gt; 0]">
                                    <xsl:attribute name="subtype">
                                        <xsl:value-of select="$codeGenre1Elsevier"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="source">
                                        <xsl:value-of select="$codeGenre2Elsevier"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="scheme">
                                        <xsl:value-of select="$codeGenreArkElsevier"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$codeGenre2Elsevier"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="not(//@docsubtype)">
                                        <xsl:attribute name="subtype">other</xsl:attribute>
                                        <xsl:attribute name="subtype">N/A</xsl:attribute>
                                        <xsl:attribute name="source">ISTEX</xsl:attribute>
                                        <xsl:attribute name="scheme">https://content-type.data.istex.fr/ark:/67375/XTP-7474895G-0</xsl:attribute>
                                        <xsl:text>other</xsl:text>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </note>
                        <!-- niveau revue / book -->
                        <!-- genre de publication -->
                        <xsl:choose>
                            <xsl:when test="$docIssueEls//issue-info/ce:isbn[string-length() &gt; 0] and $docIssueEls//issue-info/ce:issn[string-length() &gt; 0]">
                                <note type="publication-type">
                                    <xsl:attribute name="subtype">book-series</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute>
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="$docIssueEls//issue-info/ce:isbn[string-length() &gt; 0] and not($docIssueEls//issue-info/ce:issn[string-length() &gt; 0])">
                                <note type="publication-type">
                                    <xsl:attribute name="subtype">book</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="$docIssueEls//s1:issue-info/ce:isbn[string-length() &gt; 0] and $docIssueEls//s1:issue-info/ce:issn[string-length() &gt; 0]">
                                <note type="publication-type">
                                    <xsl:attribute name="subtype">book-series</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute>
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="$docIssueEls//s1:issue-info/ce:isbn[string-length() &gt; 0] and not($docIssueEls//s1:issue-info/ce:issn[string-length() &gt; 0])">
                                <note type="publication-type">
                                    <xsl:attribute name="subtype">book</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <note type="publication-type">
                                    <xsl:attribute name="type">journal</xsl:attribute>
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0GLKJH51-B</xsl:attribute>
                                    <xsl:text>journal</xsl:text>
                                </note>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                                <note type="publication-type" subtype="book-series">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0G6R5W5T-Z</xsl:attribute>
                                    <xsl:text>book-series</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                                <note type="publication-type" subtype="book">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-5WTPMB5N-F</xsl:attribute>
                                    <xsl:text>book</xsl:text>
                                </note>
                            </xsl:when>
                            <xsl:otherwise>
                                <note type="publication-type" subtype="journal">
                                    <xsl:attribute name="scheme">https://publication-type.data.istex.fr/ark:/67375/JMC-0GLKJH51-B</xsl:attribute>
                                    <xsl:text>journal</xsl:text>
                                </note>
                            </xsl:otherwise>
                        </xsl:choose>
                    </notesStmt>
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- Title information related to the paper goes here -->
                                <!-- rattrapage titres vides -->
                                <xsl:choose>
                                    <xsl:when test="els1:head/ce:title |els2:head/ce:title | head/ce:title ='' or not(els1:head/ce:title |els2:head/ce:title | head/ce:title)">
                                        <title level="a" type="main">
                                            <xsl:value-of select="$titre"/>
                                        </title>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="els1:head/ce:title | els2:head/ce:title |head/ce:title"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="els1:head/ce:presented |els2:head/ce:presented | head/ce:presented">
                                    <title level="a" type="sub">
                                        <xsl:value-of select="els1:head/ce:presented |els2:head/ce:presented | head/ce:presented"/>
                                    </title>
                                </xsl:if>
                                <!-- All authors are included here -->
                                <xsl:apply-templates
                                    select="els1:head/ce:author-group/ce:author |els2:head/ce:author-group/ce:author | head/ce:author-group/ce:author"/>
                                <xsl:apply-templates
                                    select="els1:head/ce:author-group/ce:collaboration |els2:head/ce:author-group/ce:collaboration | head/ce:author-group/ce:collaboration"/>
                                
                                <xsl:apply-templates select="els1:item-info/ce:doi |els2:item-info/ce:doi | item-info/ce:doi"/>
                                <xsl:apply-templates select="els1:item-info/ce:pii |els2:item-info/ce:pii | item-info/ce:pii"/>
                                <xsl:apply-templates select="els1:item-info/els1:aid |els2:item-info/els2:aid | item-info/els1:aid| item-info/els2:aid"
                                />
                            </analytic>
                            <monogr>
                                <!-- lien vers la donnée externe header -->
                                <title level="j" type="abr">
                                    <xsl:value-of select="//els1:item-info/els1:jid |//els2:item-info/els2:jid | //item-info/jid"/>
                                </title>
                                <xsl:if test="//els1:item-info/els1:aid |//els2:item-info/els2:aid | //item-info/aid">
                                    <idno type="aid">
                                        <xsl:value-of select="//els1:item-info/els1:aid |//els2:item-info/els2:aid | //item-info/aid"/>
                                    </idno>
                                </xsl:if>
                                <!-- PL: note for me, does the issn appears in the biblio section? -->
                                <xsl:apply-templates select="//ce:issn"/>
                                <!-- Just in case -->
                                <imprint>
                                    <xsl:choose>
                                        <xsl:when
                                            test="els1:head/ce:miscellaneous |els2:head/ce:miscellaneous | head/ce:miscellaneous">
                                            <xsl:apply-templates select="els1:head/ce:miscellaneous |els2:head/ce:miscellaneous"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:miscellaneous"
                                                mode="inImprint"/>
                                        </xsl:when>
                                        <xsl:when
                                            test="els1:head/ce:date-accepted |els2:head/ce:date-accepted | head/ce:date-accepted">
                                            <xsl:apply-templates select="els1:head/ce:date-accepted |els2:head/ce:date-accepted"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:date-accepted"
                                                mode="inImprint"/>
                                        </xsl:when>
                                        <xsl:when
                                            test="els1:head/ce:date-received |els2:head/ce:date-received | head/ce:date-received">
                                            <xsl:apply-templates select="els1:head/ce:date-received |els2:head/ce:date-received"
                                                mode="inImprint"/>
                                            <xsl:apply-templates select="head/ce:date-received"
                                                mode="inImprint"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <!-- lien vers la donnée externe header -->
                                </imprint>
                            </monogr>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="els1:head/ce:keywords |els2:head/ce:keywords | head/ce:keywords | els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
                        <xsl:apply-templates select="els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract"/>
                        <xsl:apply-templates select="item-info/ce:doctopics"/>
                        <xsl:apply-templates select="els1:head/ce:keywords |els2:head/ce:keywords | head/ce:keywords"/>
                        <!-- language -->
                        <xsl:variable name="codeLangue">
                            <xsl:choose>
                                <xsl:when test="//ce:doi='10.1016/0020-7055(75)90037-6'">ru</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/S0065-1281(77)80028-7'">it</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/S0065-1281(77)80116-5'or//ce:doi='10.1016/S0005-2795(70)80016-2'or//ce:doi='10.1016/S0899-5362(00)00024-5'or//ce:doi='10.1016/0001-6160(77)90075-X'or//ce:doi='10.1016/0029-5493(67)90024-6'or//ce:doi='10.1016/S0003-9365(11)80123-5'or//ce:doi='10.1016/0017-9310(65)90077-3'or//ce:doi='10.1016/S0044-328X(75)80002-X'or//ce:doi='10.1016/S0174-3031(83)80093-6'or//ce:doi='10.1016/S0044-328X(78)80193-7'or//ce:doi='10.1016/0140-7007(82)90068-8'or//ce:doi='10.1016/0024-3841(77)90027-4'or//ce:doi='10.1016/0028-3932(63)90018-6'or//ce:doi='10.1016/S0044-328X(82)80177-3'or//ce:doi='10.1016/S0031-8914(41)90688-2'or//ce:doi='10.1016/0043-1648(68)90552-8'or//ce:doi='10.1016/0013-4686(61)90001-9'or//ce:doi='10.1016/S0031-8914(40)90087-8'or//ce:doi='10.1016/S0031-8914(42)90109-5'or//ce:doi='10.1016/0031-8914(48)90040-8'or//ce:doi='10.1016/S0031-8914(38)80198-1'or//ce:doi='10.1016/S0399-077X(73)80142-8'or//ce:doi='10.1016/0022-2860(74)85065-9'">fr</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/0371-1951(48)80189-X'or//ce:doi='10.1016/0011-2275(64)90067-0'or//ce:doi='10.1016/0011-2275(64)90086-4'or//ce:doi='10.1016/0011-2275(64)90022-0'or//ce:doi='10.1016/0011-2275(64)90108-0'or//ce:doi='10.1016/0011-2275(64)90048-7'or//ce:doi='10.1016/S0011-2275(64)80012-6'or//ce:doi='10.1016/S0031-8663(38)80015-6'">it</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/0029-554X(69)90427-3'">de</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/S1695-4033(01)77667-9'or//ce:doi='10.1016/S1695-4033(01)77671-0'or//ce:doi='10.1016/S1695-4033(01)77666-7'or//ce:doi='10.1016/S1695-4033(01)77668-0'or//ce:doi='10.1016/S1695-4033(01)77669-2'or//ce:doi='10.1016/S1695-4033(01)77670-9'or//ce:doi='10.1016/0022-510X(68)90004-X'or//ce:doi='10.1016/0277-9536(89)90004-X'">es</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/S0005-8165(77)80120-0'or//ce:doi='10.1016/S0940-9602(98)80120-9'or//ce:doi='10.1016/S0044-4057(74)80061-4'or//ce:doi='10.1016/S0940-9602(11)80342-0'or//ce:doi='10.1016/0079-6816(94)90061-2'or//ce:doi='10.1016/S0232-4393(11)80191-5'or//ce:doi='10.1016/S0172-5599(80)80068-X'or//ce:doi='10.1016/0029-5493(74)90179-4'or//ce:doi='10.1016/0255-2701(89)85004-4'or//ce:doi='10.1016/S0344-0338(79)80035-7'or//ce:doi='10.1016/S0044-4057(77)80091-9'or//ce:doi='10.1016/0255-2701(88)87017-X'or//ce:doi='10.1016/0378-2166(89)90007-6'or//ce:doi='10.1016/S0016-2361(01)00039-4'or//ce:doi='10.1016/S0040-6090(00)00826-9'or//ce:doi='10.1016/0013-4686(78)87005-4'or//ce:doi='10.1016/0013-4694(72)90174-5'or//ce:doi='10.1016/0001-8686(90)80027-W'or//ce:doi='10.1016/S0929-693X(99)80201-2'or//ce:doi='10.1016/0013-4694(72)90174-5'or//ce:doi='10.1016/S1507-1367(01)70390-2'or//ce:doi='10.1016/S1507-1367(01)70395-1'or//ce:doi='10.1016/S1507-1367(01)70379-3'or//ce:doi='10.1016/S1507-1367(01)70393-8'or//ce:doi='10.1016/S1507-1367(01)70381-1'or//ce:doi='10.1016/S1507-1367(01)70483-X'or//ce:doi='10.1016/S1507-1367(01)70385-9'or//ce:doi='10.1016/S1507-1367(01)70374-4'or//ce:doi='10.1016/S1507-1367(01)70389-6'or//ce:doi='10.1016/S1507-1367(01)70376-8'or//ce:doi='10.1016/S1507-1367(01)70380-X'or//ce:doi='10.1016/S1507-1367(01)70387-2'or//ce:doi='10.1016/S1507-1367(01)70384-7'or//ce:doi='10.1016/S1507-1367(01)70471-3'or//ce:doi='10.1016/S1507-1367(01)70399-9'or//ce:doi='10.1016/S1507-1367(01)70391-4'or//ce:doi='10.1016/S1507-1367(01)70397-5'or//ce:doi='10.1016/S1507-1367(01)70382-3'or//ce:doi='10.1016/S1507-1367(01)70398-7'or//ce:doi='10.1016/S1507-1367(01)70394-X'or//ce:doi='10.1016/S1507-1367(01)70378-1'or//ce:doi='10.1016/S1507-1367(01)70377-X'or//ce:doi='10.1016/S1507-1367(01)70392-6'or//ce:doi='10.1016/S1507-1367(01)70396-3'or//ce:doi='10.1016/S1507-1367(01)70383-5'or//ce:doi='10.1016/S1507-1367(01)70372-0'or//ce:doi='10.1016/S1507-1367(01)70386-0'or//ce:doi='10.1016/S1507-1367(01)70375-6'">en</xsl:when>
                                <xsl:when test="//ce:doi='10.1016/S0174-3031(82)80096-6'">fr</xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="//@xml:lang">
                                            <xsl:value-of select="normalize-space(translate(//@xml:lang,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'))"/>
                                        </xsl:when>
                                        <xsl:otherwise>en</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:if test="$codeLangue">
                            <langUsage>
                                <language>
                                    <xsl:attribute name="ident">
                                        <xsl:value-of select="$codeLangue"/>
                                    </xsl:attribute>
                                </language>
                            </langUsage>
                        </xsl:if>
                    </profileDesc>
                </xsl:if>
                <xsl:if test="//ce:glyph">
                    <encodingDesc>
                        <charDecl>
                            <xsl:for-each select="//ce:glyph">
                                <char>
                                    <xsl:attribute name="xml:id">
                                        <xsl:value-of select="@name"/>
                                    </xsl:attribute>
                                </char>
                            </xsl:for-each>
                        </charDecl>
                    </encodingDesc>
                </xsl:if>
                <xsl:if
                    test="els1:head/ce:date-received | els1:head/ce:date-revised | els1:head/ce:date-accepted |els2:head/ce:date-received | els2:head/ce:date-revised | els2:head/ce:date-accepted  | head/ce:date-received | head/ce:date-revised | head/ce:date-accepted | head/ce:date-received">
                    <revisionDesc>
                        <xsl:apply-templates
                            select="els1:head/ce:date-received | els1:head/ce:date-revised | els1:head/ce:date-accepted |els2:head/ce:date-received | els2:head/ce:date-revised | els2:head/ce:date-accepted  | head/ce:date-received | head/ce:date-revised | head/ce:date-accepted | head/ce:date-received"
                        />
                    </revisionDesc>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved from <front> to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract"/>
                </front-->
                <xsl:choose>
                    <xsl:when test="els1:body|els2:body|body">
                        <body>
                            <xsl:apply-templates select="els1:body|els2:body/*"/>
                            <xsl:apply-templates select="body/*"/>
                            <xsl:apply-templates select="//ce:floats"/>
                        </body>
                    </xsl:when>
                    <xsl:when test="string-length($rawfulltextpath) &gt; 0">
                        <body>
                            <div>
                                <p><xsl:value-of select="unparsed-text($rawfulltextpath, 'UTF-8')"/></p>
                            </div>
                        </body>
                    </xsl:when>
                    <xsl:otherwise>
                        <body>
                        <div><p></p></div>
                        </body>
                    </xsl:otherwise>
                </xsl:choose>
                <back>
                    <!-- Bravo: Elsevier a renommé son back en tail... visionnaire -->
                    <xsl:apply-templates select="els1:back/* | els1:tail/* |els2:back/* | els2:tail/* | tail/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <xsl:template match="ce:copyright">
        <!-- moved up publisher information -->
        <publisher>
            <xsl:value-of select="text()"/>
        </publisher>
        <!-- PL: put the date under the paragraph, as it is TEI P5 valid -->
        <!-- LR: moved the date two nodes higher so that the encompassing publicationStmt is closer to what is expected-->
        <date when="{@year}">
            <xsl:value-of select="@year"/>
        </date>
        <availability status="restricted">
            <licence>
            	<p>
            	    <xsl:if test="@year">
            	        <xsl:text>&#169;</xsl:text>
            	        <xsl:value-of select="@year"/>
            	        <xsl:text>, </xsl:text>
            	    </xsl:if>
            	    <xsl:value-of select="."/>
            	</p>
			</licence>
        </availability>
    </xsl:template>

    <xsl:template match="ce:text">
        <xsl:choose>
            <xsl:when test="parent::ce:collaboration">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <term xml:id="{@id}">
                    <xsl:apply-templates/>
                </term>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
	<!-- PL: this could be moved to KeywordsAbstract.xsl when generalised to all publishers -->
    <!--xsl:template match="els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract">
		<abstract>
			<xsl:if test="@xml:lang">
				<xsl:attribute name="xml:lang">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="*/ce:simple-para"/>
		</abstract>
    </xsl:template-->

    <xsl:template match="els1:display |els2:display | ce:display | display">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:correspondence/ce:text">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Revision information -->
    <xsl:template match="els1:head/ce:date-received |els2:head/ce:date-received | head/ce:date-received">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Received</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els1:head/ce:date-revised |els2:head/ce:date-revised | head/ce:date-revised">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Revised</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els1:head/ce:date-accepted |els2:head/ce:date-accepted | head/ce:date-accepted">
        <change>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:text>Accepted</xsl:text>
        </change>
    </xsl:template>

    <xsl:template match="els1:head/ce:date-received |els2:head/ce:date-received | head/ce:date-received" mode="inImprint">
        <change>
            <xsl:attribute name="type">Received</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
        </change>
    </xsl:template>

    <xsl:template match="els1:head/ce:date-accepted |els2:head/ce:date-accepted | head/ce:date-accepted" mode="inImprint">
        <date>
            <xsl:attribute name="type">Accepted</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="@day"/>
                    <xsl:with-param name="oldMonth" select="@month"/>
                    <xsl:with-param name="oldYear" select="@year"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <xsl:template match="els1:head/ce:miscellaneous |els2:head/ce:miscellaneous | head/ce:miscellaneous" mode="inImprint">
        <xsl:variable name="quot">"</xsl:variable>
        <date>
            <xsl:attribute name="type">Published</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay"
                        select="substring-before(substring-after(substring-after(.,'day='),$quot),$quot)"/>
                    <xsl:with-param name="oldMonth"
                        select="substring-before(substring-after(substring-after(.,'month='),$quot),$quot)"/>
                    <xsl:with-param name="oldYear"
                        select="substring-before(substring-after(substring-after(.,'year='),$quot),$quot)"
                    />
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- Full text elements -->

    <!-- divisions -->

    <xsl:template match="ce:sections">
        <div type="ElsevierSections">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="ce:section">
        <div>
            <xsl:if test="ce:label">
                <xsl:attribute name="type" select="ce:label"/>
            </xsl:if>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id" select="@id"/>
            </xsl:if>
            <xsl:apply-templates select="*[ name()!='ce:label']"/>
        </div>
    </xsl:template>

    <xsl:template match="ce:acknowledgment">
        <div type="acknowledgment">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="ce:appendices">
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:abstract-sec">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="ce:section-title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="ce:e-address">
        <email>
            <xsl:apply-templates/>
        </email>
    </xsl:template>

    <xsl:template match="els1:author-comment |els2:author-comment">
        <note type="author-comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Figures -->
    <xsl:template match="ce:figure">
        <div type="figure">
            <figure>
                <xsl:if test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </figure>
        </div>
    </xsl:template>
    <xsl:template match="ce:caption">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>

    <!-- Fin de la bibliographie -->

    <xsl:template match="ce:bib-reference">
        <biblStruct>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </biblStruct>
    </xsl:template>

    <xsl:template match="els1:conf-name |els2:conf-name">
        <meeting>
            <xsl:apply-templates/>
        </meeting>
    </xsl:template>
    
    <xsl:template match="ce:collaboration">
        <author role="collab">
            <xsl:variable name="structId" select="ce:cross-ref/@refid"/>
            <xsl:for-each select="$structId">
                <xsl:if test="//ce:correspondence[@id=.]">
                    <xsl:attribute name="role">
                        <xsl:text>corresp</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:message>Identifier: <xsl:value-of select="."/></xsl:message>
            </xsl:for-each>
            
            <name>
                <xsl:apply-templates select="*[name(.)!='ce:cross-ref' and name(.)!='ce:e-address']"
                />
            </name>
            <xsl:choose>
                <xsl:when test="../ce:footnote[not(@id)]">
                    <xsl:message>Affiliation sans identifiant</xsl:message>
                    <xsl:for-each select="../ce:footnote">
                        <email>
                            <xsl:value-of select="ce:note-para"/>
                        </email>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>On parcourt les affiliations</xsl:message>
                    <xsl:for-each select="$structId">
                        <xsl:variable name="localId">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:if test="//ce:footnote[@id=$localId]">
                            <xsl:message>Trouvé: <xsl:value-of select="$localId"/></xsl:message>
                            <email>
                                <xsl:value-of select="//ce:footnote[@id=$localId]/ce:note-para"/>
                            </email>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ce:e-address"/>
            
            <xsl:choose>
                <xsl:when test="../ce:affiliation[not(@id)]">
                    <xsl:message>Affiliation sans identifiant</xsl:message>
                    <xsl:for-each select="../ce:affiliation">
                        <affiliation>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil">
                                    <xsl:value-of select="ce:textfn"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </affiliation>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>On parcourt les affiliations</xsl:message>
                    <xsl:for-each select="$structId">
                        <xsl:variable name="localId">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:if test="//ce:affiliation[@id=$localId]">
                            <xsl:message>Trouvé: <xsl:value-of select="$localId"/></xsl:message>
                            <affiliation>
                                <xsl:call-template name="parseAffiliation">
                                    <xsl:with-param name="theAffil">
                                        <xsl:value-of select="//ce:affiliation[@id=$localId]/ce:textfn"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </affiliation>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="../ce:correspondence[not(@id)]">
                    <xsl:message>Affiliation sans identifiant</xsl:message>
                    <xsl:for-each select="../ce:correspondence">
                        <affiliation>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil">
                                    <xsl:value-of select="ce:text"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </affiliation>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>On parcourt les affiliations</xsl:message>
                    <xsl:for-each select="$structId">
                        <xsl:variable name="localId">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:if test="//ce:correspondence[@id=$localId]">
                            <xsl:message>Trouvé: <xsl:value-of select="$localId"/></xsl:message>
                            <affiliation>
                                <xsl:call-template name="parseAffiliation">
                                    <xsl:with-param name="theAffil">
                                        <xsl:value-of select="//ce:correspondence[@id=$localId]/ce:text"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </affiliation>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:for-each select="$structId">
                <xsl:variable name="localId2">
                    <xsl:value-of select="."/>
                </xsl:variable>
                
                <xsl:if test="//ce:correspondence[@id=$localId2]">
                    <xsl:variable name="codePays"
                        select="/els1:article/els1:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text | /els2:article/els2:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text"/>
                    <xsl:message>Pays Elsevier: <xsl:value-of select="$codePays"/></xsl:message>
                    <!-- PL: test to avoid empy country block -->
                    
                    <xsl:if test="$codePays">
                        <affiliation>
                            <address>
                                <country>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="$codePays"/>
                                    </xsl:attribute>
                                    <xsl:call-template name="normalizeISOCountryName">
                                        <xsl:with-param name="country" select="$codePays"/>
                                    </xsl:call-template>
                                </country>
                            </address>
                        </affiliation>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
            
            
            <!-- PL: no reference markers in the author section -->
            <!--xsl:apply-templates select="ce:cross-ref"/-->
            
        </author>
    </xsl:template>
    
    <xsl:template match="ce:author">
        <author>
            <xsl:variable name="structId" select="ce:cross-ref/@refid"/>
            <xsl:for-each select="$structId">
                <xsl:if test="//ce:correspondence[@id=.]">
                    <xsl:attribute name="role">
                        <xsl:text>corresp</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:message>Identifier: <xsl:value-of select="."/></xsl:message>
            </xsl:for-each>

            <persName>
                <xsl:apply-templates select="*[name(.)!='ce:cross-ref' and name(.)!='ce:e-address']"
                />
            </persName>

            <xsl:apply-templates select="ce:e-address"/>

            <xsl:choose>
                <xsl:when test="../ce:affiliation[not(@id)]">
                    <xsl:message>Affiliation sans identifiant</xsl:message>
                    <xsl:for-each select="../ce:affiliation">
                        <affiliation>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil">
                                    <xsl:value-of select="ce:textfn"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </affiliation>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>On parcourt les affiliations</xsl:message>
                    <xsl:for-each select="$structId">
                        <xsl:variable name="localId">
                            <xsl:value-of select="."/>
                        </xsl:variable>
                        <xsl:if test="//ce:affiliation[@id=$localId]">
                            <xsl:message>Trouvé: <xsl:value-of select="$localId"/></xsl:message>
                            <affiliation>
                                <xsl:call-template name="parseAffiliation">
                                    <xsl:with-param name="theAffil">
                                        <xsl:value-of select="//ce:affiliation[@id=$localId]/ce:textfn"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </affiliation>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:for-each select="$structId">
                <xsl:variable name="localId2">
                    <xsl:value-of select="."/>
                </xsl:variable>
                
                <xsl:if test="//ce:correspondence[@id=$localId2]">
                    <xsl:variable name="codePays"
                        select="/els1:article/els1:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text | /els2:article/els2:item-info/ce:doctopics/ce:doctopic[@role='coverage']/ce:text"/>
                    <xsl:message>Pays Elsevier: <xsl:value-of select="$codePays"/></xsl:message>
                    <!-- PL: test to avoid empy country block -->

                    <xsl:if test="$codePays">
                        <affiliation>
                            <address>
	                           <country>
	                            <xsl:attribute name="key">
	                                <xsl:value-of select="$codePays"/>
	                            </xsl:attribute>
	                            <xsl:call-template name="normalizeISOCountryName">
	                                <xsl:with-param name="country" select="$codePays"/>
	                            </xsl:call-template>
	                        </country>
	                       </address>
                        </affiliation>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>


            <!-- PL: no reference markers in the author section -->
            <!--xsl:apply-templates select="ce:cross-ref"/-->

        </author>
    </xsl:template>

    <xsl:template match="ce:affiliation">
        <affiliation>
            <address>
            <xsl:call-template name="parseAffiliation">
                <xsl:with-param name="theAffil">
                    <xsl:value-of select="ce:textfn"/>
                </xsl:with-param>
            </xsl:call-template>
            </address>
        </affiliation>
    </xsl:template>

    <xsl:template name="parseAffiliation">
        <xsl:param name="theAffil"/>
        <xsl:param name="inAddress" select="false()"/>
        <xsl:for-each select="$theAffil">
            <xsl:message>Un bout: <xsl:value-of select="."/></xsl:message>
        </xsl:for-each>
        <xsl:variable name="avantVirgule">
            <xsl:choose>
                <xsl:when test="contains($theAffil,',')">
                    <xsl:value-of select="normalize-space(substring-before($theAffil,','))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($theAffil)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="apresVirgule">
            <xsl:choose>
                <xsl:when test="contains($theAffil,',')">
                    <xsl:value-of select="normalize-space(substring-after($theAffil,','))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="testOrganisation">
            <xsl:call-template name="identifyOrgLevel">
                <xsl:with-param name="theOrg">
                    <xsl:value-of select="$avantVirgule"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($inAddress)">
                <xsl:choose>
                    <xsl:when test="$testOrganisation!=''">
                        <orgName>
                            <xsl:attribute name="type">
                                <xsl:value-of select="$testOrganisation"/>
                            </xsl:attribute>
                            <xsl:value-of select="$avantVirgule"/>
                        </orgName>
                        <xsl:if test="$apresVirgule !=''">
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil" select="$apresVirgule"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <address>
                            <xsl:call-template name="parseAffiliation">
                                <xsl:with-param name="theAffil" select="$theAffil"/>
                                <xsl:with-param name="inAddress" select="true()"/>
                            </xsl:call-template>
                        </address>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="testCountry">
                    <xsl:call-template name="normalizeISOCountry">
                        <xsl:with-param name="country" select="$avantVirgule"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$testCountry != ''">
                        <country>
                            <xsl:choose>
                                <xsl:when test="//ce:doi='10.1016/S0735-1097(98)00474-4'">
                                    <xsl:attribute name="key">
                                        <xsl:text>UK</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>UNITED KINGDOM</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="key">
                                        <xsl:value-of select="$testCountry"/>
                                    </xsl:attribute>
                                    <xsl:call-template name="normalizeISOCountryName">
                                        <xsl:with-param name="country" select="$avantVirgule"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </country>
                    </xsl:when>
                    <xsl:otherwise>
                        <addrLine>
                            <xsl:value-of select="$avantVirgule"/>
                        </addrLine>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$apresVirgule !=''">
                    <xsl:call-template name="parseAffiliation">
                        <xsl:with-param name="theAffil" select="$apresVirgule"/>
                        <xsl:with-param name="inAddress" select="true()"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ce:correspondence">
        <note type="correspondence">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="ce:footnote">
        <note place="foot">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="ce:label">
        <xsl:if test="parent::ce:figure">
            <head>
                <xsl:apply-templates/>
            </head>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ce:link">
        <xsl:if test="parent::ce:figure">
            <link xml:id="{@id}" source="{@locator}">
                <xsl:apply-templates/>
            </link>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ce:hsp">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- vieille version qui intégre la référence dans le texte !!!???? -->
    <!--
    <xsl:template match="ce:cross-ref">
        <xsl:variable name="identifier" select="@refid"/>
        <xsl:apply-templates select="//*[@id=$identifier]"/>
    </xsl:template>-->

    <!-- Nouvelles qui se contente de créer un <ref> -->

    <xsl:template match="ce:cross-ref">
        <ref>
            <xsl:attribute name="target">
                <xsl:choose>
                    <!-- Si par hasard ELsevier bascule sur une vraie syntaxe URI, on n'ajoute pas le # devant l'identifiant -->
                    <xsl:when test=" starts-with(@refid,'#')">
                        <xsl:value-of select="@refid"/>
                    </xsl:when>
                    <!-- Dans le cas contraire, actual et le plus probale dans le futur on préfixe l'id avec # -->
                    <xsl:otherwise>
                        <xsl:value-of select=" concat('#',@refid)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- La même chose avec plusieurs référence (Ah, les URIs multiples) -->

    <xsl:template match="ce:cross-refs">
        <ref>
            <xsl:attribute name="target">
                <xsl:for-each select="tokenize(@refid,' ')">
                    <xsl:choose>
                        <!-- Si par hasard ELsevier bascule sur une vraie syntaxe URI, on n'ajoute pas le # devant l'identifiant -->
                        <xsl:when test=" starts-with(current(),'#')">
                            <xsl:value-of select="current()"/>
                        </xsl:when>
                        <!-- Dans le cas contraire, actual et le plus probale dans le futur on préfixe l'id avec # -->
                        <xsl:otherwise>
                            <xsl:value-of select=" concat('#',current())"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="not(position()=last())">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <!-- External references -->
    <xsl:template match="ce:inter-ref">
        <ref>
            <xsl:attribute name="target">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="els1:name|els2:name" mode="editors">
        <editor>
            <xsl:apply-templates select="."/>
        </editor>
    </xsl:template>

    <xsl:template match="els1:pub-id | els2:pub-id">
        <idno type="{@pub-id-type}">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>

    <xsl:template match="ce:glyph">
        <g>
            <xsl:if test="@name">
                <xsl:attribute name="ref">#<xsl:value-of select="@name"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </g>
    </xsl:template>

</xsl:stylesheet>
