<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>

    <!-- Revision information -->
    <xsl:template match="ArticleHistory">
        <revisionDesc>
            <xsl:apply-templates/>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="RegistrationDate">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <change>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:text>Registration</xsl:text>
            </change>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Received">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <change>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:text>Received</xsl:text>
            </change>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Accepted">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <change>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:text>Accepted</xsl:text>
            </change>
        </xsl:if>
    </xsl:template>


    <xsl:template match="Revised">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <change>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:text>Revised</xsl:text>
            </change>
        </xsl:if>
    </xsl:template>


    <xsl:template match="OnlineDate">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <change>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:text>ePublished</xsl:text>
            </change>
        </xsl:if>
    </xsl:template>


    <xsl:template match="OnlineDate" mode="inImprint">
        <xsl:variable name="theDate">
            <xsl:call-template name="makeISODateFromComponents">
                <xsl:with-param name="oldDay" select="Day"/>
                <xsl:with-param name="oldMonth" select="Month"/>
                <xsl:with-param name="oldYear" select="Year"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$theDate != '0-00-00'">
            <date>
                <xsl:attribute name="when">
                    <xsl:value-of select="$theDate"/>
                </xsl:attribute>
                <xsl:attribute name="type">
                    <xsl:text>ePublished</xsl:text>
                </xsl:attribute>
            </date>
        </xsl:if>
    </xsl:template>

    <xsl:template match="JournalID">
        <xsl:if test=".!=''">
            <idno type="JournalID">
                <xsl:apply-templates/>
            </idno>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ArticleInfo/ArticleID">
        <xsl:if test=".!=''">
            <idno type="ArticleID">
                <xsl:apply-templates/>
            </idno>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Acknowledgments">
        <div type="acknowledgments">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="Appendix">
        <div type="appendix">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="AuthorGroup/Author | AuthorGroup/InstitutionalAuthor">
        <author>
            <xsl:if test="@corresp='yes' or @CorrespondingAffiliationID">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:call-template name="createSpringerAffiliations">
                <xsl:with-param name="restAff" select="@AffiliationIDS"/>
            </xsl:call-template>
        </author>
    </xsl:template>
    
    <!-- Same for Editors -->
    
    <xsl:template match="EditorGroup/Editor">
        <editor>
            <xsl:apply-templates/>
            <xsl:call-template name="createSpringerAffiliations">
                <xsl:with-param name="restAff" select="@AffiliationIDS"/>
            </xsl:call-template>
        </editor>
    </xsl:template>

    <xsl:template name="createSpringerAffiliations">
        <xsl:param name="restAff"/>
        <xsl:message>Affiliations: <xsl:value-of select="$restAff"/></xsl:message>
        <xsl:choose>
            <xsl:when test=" contains($restAff,' ')">
                <xsl:apply-templates select="../Affiliation[@ID=substring-before($restAff,' ')]"/>
                <xsl:call-template name="createSpringerAffiliations">
                    <xsl:with-param name="restAff" select="substring-after($restAff,' ')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="../Affiliation[@ID=$restAff]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="AuthorName | EditorName">
        <persName>
            <xsl:apply-templates/>
        </persName>
    </xsl:template>

    <xsl:template match="Contact">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="Biography">
        <note type="Biography">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <xsl:template match="Biography/FormalPara">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="Biography/FormalPara/Heading">
        <name>
            <xsl:apply-templates/>
        </name>
    </xsl:template>


    <xsl:template match="Biography/FormalPara/Para">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="/Publisher//Affiliation">
        <affiliation>
            <xsl:if test="../InstitutionalAuthor">
                <xsl:apply-templates select="../InstitutionalAuthor" mode="simple"/>
            </xsl:if>
            <xsl:apply-templates/>
        </affiliation>
    </xsl:template>

    <xsl:template match="CitationRef">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>




    <!-- Références bibliographiques à la fin d'un article -->

    <xsl:template match="Bibliography">
        <div type="references">
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="Heading">
                <xsl:apply-templates select="Heading"/>
            </xsl:if>
            <listBibl>
                <xsl:apply-templates select="Citation"/>
            </listBibl>
        </div>
    </xsl:template>

    <xsl:template match="Citation">
        <listBibl type="Citation">
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="CitationNumber">
                <xsl:attribute name="n">
                    <xsl:value-of select="CitationNumber"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[name() != 'CitationNumber']"/>
        </listBibl>
    </xsl:template>


    <!-- Generic trabsformation of unstructured entries  -->

    <xsl:template match="BibUnstructured">
        <bibl>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>

    <!-- Journal article -->

    <xsl:template match="BibArticle">
        <biblStruct type="article">
            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="BibAuthorName"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="ArticleTitle"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="JournalTitle"/>
                <imprint>
                    <xsl:apply-templates select="Year"/>
                    <xsl:apply-templates select="VolumeID"/>
                    <xsl:apply-templates select="IssueID"/>
                    <xsl:apply-templates select="FirstPage"/>
                    <xsl:apply-templates select="LastPage"/>
                </imprint>
            </monogr>
            <xsl:apply-templates select="nlm-citation/pub-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Book chapter -->

    <xsl:template match="BibChapter">
        <biblStruct type="inBook">
            <analytic>
                <!-- All authors are included here -->
                <xsl:apply-templates select="BibAuthorName"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="ChapterTitle"/>
            </analytic>
            <monogr>
                <xsl:apply-templates select="JournalTitle"/>
                <imprint>
                    <xsl:apply-templates select="Year"/>
                    <xsl:apply-templates select="VolumeID"/>
                    <xsl:apply-templates select="IssueID"/>
                    <xsl:apply-templates select="FirstPage"/>
                    <xsl:apply-templates select="LastPage"/>
                </imprint>
            </monogr>
            <xsl:apply-templates select="nlm-citation/pub-id"/>
        </biblStruct>
    </xsl:template>

    <!-- Book - generic -->

    <xsl:template match="BibBook">
        <biblStruct type="book">
            <monogr>
                <!-- All authors are included here -->
                <xsl:apply-templates select="BibAuthorName"/>
                <!-- Title information related to the paper goes here -->
                <xsl:apply-templates select="BookTitle"/>
                <imprint>
                    <xsl:apply-templates select="Year"/>
                    <xsl:apply-templates select="PublisherLocation"/>
                    <xsl:apply-templates select="PublisherName"/>
                </imprint>
            </monogr>
        </biblStruct>
    </xsl:template>

    <xsl:template match="BibAuthorName">
        <author>
            <persName>
                <xsl:apply-templates/>
            </persName>
        </author>
    </xsl:template>

    <!-- Journal information for <monogr> -->

    <xsl:template match="BookTitle">
        <title level="m">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    
    <xsl:template match="BookSubTitle">
        <title level="m" type="sub">
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <!-- Macrostructure of main body if the text -->

    <xsl:template match="Section1">
        <div>
            <xsl:if test="@Type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@Type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="Section2">
        <div>
            <xsl:if test="@Type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@Type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="Section3">
        <div>
            <xsl:if test="@Type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@Type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@ID">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@ID"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="Heading">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <!-- Figures -->
    <xsl:template match="Figure">
        <figure>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@ID"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </figure>
    </xsl:template>

    <xsl:template match="ImageObject">
        <graphic>
            <xsl:attribute name="url">
                <xsl:value-of select="@FileRef"/>
            </xsl:attribute>
        </graphic>
    </xsl:template>

    <xsl:template match="CaptionNumber">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="CaptionContent">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="MediaObject">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="Caption">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="InternalRef">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="ExternalRef">
        <ref>
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="RefSource">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="RefTarget"/>


    <!-- Copyright related information to appear in <publicationStmt> -->
    <xsl:template match="ArticleCopyright">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="CopyrightHolderName">
        <authority>
            <xsl:apply-templates/>
        </authority>
    </xsl:template>

    <xsl:template match="CopyrightYear">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>

    <xsl:template match="allowbreak"/>

    <xsl:template match="title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <!-- Lists in Springer format -->
    <xsl:template match="OrderedList">
        <list type="ordered">
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="UnorderedList[@Mark='Bullet']">
        <list type="bulleted">
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="ListItem">
        <item>
            <xsl:if test="ItemNumber">
                <xsl:attribute name="n">
                    <xsl:value-of select="ItemNumber"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="ItemContent"/>
        </item>
    </xsl:template>

    <xsl:template match="ItemContent">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Tables in Springer format -->

    <xsl:template match="Table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="Caption">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <xsl:template match="CaptionNumber">
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>

    <xsl:template match="row">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="entry">
        <cell>
            <xsl:apply-templates/>
        </cell>
    </xsl:template>

    <xsl:template match="tgroup">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tbody">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="thead">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tfooter"/>
    <xsl:template match="colspec"/>

    <xsl:template match="entry/SimplePara | CaptionContent/SimplePara">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="Stack">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
