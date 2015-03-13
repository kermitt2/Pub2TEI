<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="article_set">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- TEI document structure, creation of main header components, front (summary), body, and back -->
    <xsl:template match="article_set/article">
        <xsl:variable name="ms_no" select="@ms_no"/>
        <xsl:variable name="localISSN">
            <xsl:value-of select="journal/issn[@issn_type='print']"/>
        </xsl:variable>
        <xsl:variable name="journalDescription"
            select="$journalList/descendant::tei:row[tei:cell/text()=$localISSN]"/>
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <xsl:apply-templates select="article_title"/>
                    </titleStmt>
                    <xsl:if test="CopyrightInformation">
                        <publicationStmt>
                            <xsl:apply-templates select="CopyrightInformation"/>
                        </publicationStmt>
                    </xsl:if>
                    <sourceDesc>
                        <biblStruct>
                            <xsl:choose>
                                <xsl:when
                                    test="configurable_data_fields/custom_fields[@cd_code='Wiley - Manuscript type']">
                                    <xsl:variable name="WileyManuscriptType"
                                        select="configurable_data_fields/custom_fields[@cd_code='Wiley - Manuscript type']/@cd_value"/>
                                    <xsl:attribute name="type">
                                        <xsl:choose>
                                            <xsl:when test="$WileyManuscriptType='Article'"
                                                >article</xsl:when>
                                            <xsl:otherwise>article</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="/article_set/article/publication_type">
                                    <xsl:attribute name="type">
                                        <xsl:choose>
                                            <xsl:when
                                                test="/article_set/article/publication_type='Research Article'"
                                                >article</xsl:when>
                                            <xsl:otherwise>article</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                </xsl:when>
                            </xsl:choose>

                            <analytic>
                                <!-- All authors are included here -->
                                <xsl:apply-templates select="author_list/*"/>
                                <!-- Title information related to the paper goes here -->
                                <xsl:apply-templates
                                    select="article_title | vernacular_title | article_sub_title"/>
                            </analytic>
                            <monogr>
                                <xsl:call-template name="fillMonogrContent">
                                    <xsl:with-param name="ref" select="journal"/>
                                </xsl:call-template>
                                <imprint>


                                    <!--                                        <xsl:when test="$journalDescription">
                                            <xsl:apply-templates
                                                select="$journalDescription/tei:cell[@role='Publisher']"/>
                                            <xsl:message>Corrected publisher: <xsl:value-of
                                                  select="$journalDescription/tei:cell[@role='Publisher']"
                                                /></xsl:message>
                                        </xsl:when>-->
                                    <xsl:if
                                        test="journal/publisher_name and journal/publisher_name!=''">
                                        <xsl:apply-templates select="journal/publisher_name"/>
                                    </xsl:if>

                                    <xsl:if test="history/ms_id[@ms_no=$ms_no]/web_publish_date">
                                        <xsl:apply-templates
                                            select="history/ms_id[@ms_no=$ms_no]/web_publish_date"
                                            mode="inImprint"/>
                                    </xsl:if>


                                    <xsl:if
                                        test="configurable_data_fields/custom_fields[@cd_code='Wiley - Published online date']">
                                        <xsl:apply-templates
                                            select="configurable_data_fields/custom_fields[@cd_code='Wiley - Published online date']"
                                            mode="inImprint"/>
                                    </xsl:if>

                                    <xsl:call-template name="fillImprintContent">
                                        <xsl:with-param name="ref" select="journal"/>
                                    </xsl:call-template>
                                </imprint>
                            </monogr>
                            <xsl:apply-templates select="article_id_list/*"/>
                            <xsl:apply-templates select="@ms_no"/>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="@lang">
                    <profileDesc>
						<!-- PL: abstract is moved to here from <front> -->
						<xsl:apply-templates select="abstract"/>
						
                        <langUsage>
                            <language>
                                <xsl:attribute name="ident">
                                    <xsl:call-template name="Varia2ISO639">
                                        <xsl:with-param name="code" select="@lang"/>
                                    </xsl:call-template>
                                </xsl:attribute>
                            </language>
                        </langUsage>
                    </profileDesc>
                </xsl:if>
            </teiHeader>
            <text>
				<!-- PL: abstract is moved to <abstract> under <profileDesc> -->
                <!--front>
                    <xsl:apply-templates select="abstract"/>
                </front-->
                <body>
                    <xsl:apply-templates select="body/*"/>
                </body>
                <back>
                    <xsl:apply-templates select="back/*"/>
                </back>
            </text>
        </TEI>
    </xsl:template>

    <!-- Generic fillers for bibliographical content (factoring out accross types -->

    <!-- Filler for <monogr> content -->

    <xsl:template name="fillMonogrContent">
        <xsl:param name="ref"/>
        <xsl:param name="pubType" select="'article'"/>

        <xsl:if test="$ref/full_journal_title and $ref/full_journal_title!=''">
            <xsl:apply-templates select="$ref/full_journal_title"/>
        </xsl:if>
        <xsl:if test="$ref/journal_abbreviation and $ref/journal_abbreviation!=''">
            <xsl:apply-templates select="$ref/journal_abbreviation"/>
        </xsl:if>

        <xsl:if
            test="$ref/issue_assignment/issue_description and $ref/issue_assignment/issue_description!=''">
            <xsl:apply-templates select="$ref/issue_assignment/issue_description"/>
        </xsl:if>
        <xsl:if test="$ref/issn and $ref/issn!=''">
            <xsl:apply-templates select="$ref/issn"/>
        </xsl:if>
    </xsl:template>


    <!-- Filler for <imprint> content -->

    <xsl:template name="fillImprintContent">
        <xsl:param name="ref"/>
        <xsl:param name="pubType" select="'article'"/>

        <xsl:if test="$ref/datepub and $ref/datepub!=''">
            <xsl:apply-templates select="$ref/datepub"/>
        </xsl:if>
        <xsl:if test="$ref/ville and $ref/ville!=''">
            <xsl:apply-templates select="$ref/ville"/>
        </xsl:if>
        <xsl:if test="$ref/dateconf and $ref/dateconf!=''">
            <xsl:apply-templates select="$ref/dateconf"/>
        </xsl:if>
        <xsl:if test="$ref/issue_assignment/volume and $ref/issue_assignment/volume!=''">
            <xsl:apply-templates select="$ref/issue_assignment/volume"/>
        </xsl:if>
        <xsl:if test="$ref/issue_assignment/issue and $ref/issue_assignment/issue!=''">
            <xsl:apply-templates select="$ref/issue_assignment/issue"/>
        </xsl:if>
        <xsl:if test="$ref/page and $ref/page!=''">
            <xsl:apply-templates select="$ref/page"/>
        </xsl:if>
    </xsl:template>



    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <!-- We do not care about components from <article-meta> which have 
    not been explicitely addressed -->
    <xsl:template match="article-meta"/>

    <!-- Generic rules for IDs -->
    <xsl:template match="article_id">
        <idno type="{@id_type}">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- +++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- author related information -->

    <xsl:template match="author">
        <author>
            <xsl:if test="@corr='true'">
                <xsl:attribute name="type">
                    <xsl:text>corresp</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <idno type="author">
                <xsl:value-of select="@user_id"/>
            </idno>
            <persName>
                <xsl:apply-templates
                    select="salutation | first_name | middle_name | last_name | suffix | degree"/>
            </persName>
            <xsl:apply-templates
                select="*[name()!='attribute' and name()!='salutation' and name()!='first_name' and name()!='middle_name' and name()!='last_name' and name()!='suffix' and name()!='degree']"
            />
        </author>
    </xsl:template>

    <xsl:template match="contrib[@contrib-type='editor']">
        <editor>
            <xsl:apply-templates/>
        </editor>
    </xsl:template>

    <xsl:template match="contrib">
        <respStmt>
            <resp>
                <xsl:value-of select="@contrib-type"/>
            </resp>
            <xsl:apply-templates/>
        </respStmt>
    </xsl:template>

    <xsl:template match="comments">
        <xsl:if test=".!=''">
            <note>
                <xsl:apply-templates/>
            </note>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dateStruct">
        <date>
            <xsl:value-of select="."/>
        </date>
    </xsl:template>

    <!-- Inline affiliation (embedded in <contrib>) -->
    <xsl:template match="affiliation">
        <affiliation>
            <xsl:apply-templates
                select="*[name(.)!='room' and name(.)!='addr1' and name(.)!='addr2' 
                and name(.)!='country' and name(.)!='city' and name(.)!='state' and name(.)!='province'
                and name(.)!='post_code']"/>
            <xsl:if test="addr-line | country">
                <address>
                    <xsl:apply-templates select="room | addr1 | addr2 
                        | country | city | state | province | post_code"/>
                </address>
            </xsl:if>
        </affiliation>
    </xsl:template>

    <xsl:template match="profile_affiliation"/>
    <xsl:template match="current_profile_affiliation"/>

    <xsl:template match="galleyDeliveryType"/>

    <xsl:template match="author-comment">
        <note type="author-comment">
            <xsl:apply-templates/>
        </note>
    </xsl:template>

    <!-- Fin de la bibliographie -->

    <xsl:template match="allowbreak"/>

    <xsl:template match="title">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>


    <xsl:template match="web_publish_date" mode="inImprint">
        <xsl:if test="year != ''">
            <date>
                <xsl:attribute name="type">ePublished</xsl:attribute>
                <xsl:attribute name="when">
                    <xsl:call-template name="makeISODateFromComponents">
                        <xsl:with-param name="oldDay" select="day"/>
                        <xsl:with-param name="oldMonth" select="month"/>
                        <xsl:with-param name="oldYear" select="year"/>
                    </xsl:call-template>
                </xsl:attribute>
            </date>
        </xsl:if>
    </xsl:template>

    <xsl:template match="custom_fields[@cd_code='Wiley - Published online date']" mode="inImprint">
        <date>
            <xsl:attribute name="type">Published</xsl:attribute>
            <xsl:attribute name="when">
                <xsl:call-template name="makeISODateFromComponents">
                    <xsl:with-param name="oldDay" select="substring-before(@cd_value,'-')"/>
                    <xsl:with-param name="oldMonth"
                        select="substring-before(substring-after(@cd_value,'-'),'-')"/>
                    <xsl:with-param name="oldYear"
                        select="substring-after(substring-after(@cd_value,'-'),'-')"/>
                </xsl:call-template>
            </xsl:attribute>
        </date>
    </xsl:template>

    <xsl:template match="flags"/>


</xsl:stylesheet>
