<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>
    <!-- Generic rules for the decomposing names (cf. e.g. BMJ) -->
    <xsl:template match="name | persname | auname">
        <xsl:choose>
            <xsl:when test="ancestor::ref/citation |ancestor::ref/mixed-citation and not(ancestor::person-group)">
                <author>
                    <persName>
                        <xsl:apply-templates/>
                    </persName>
                </author>
            </xsl:when>
            <xsl:otherwise>
                <persName>
                    <xsl:apply-templates/>
                </persName>
                <xsl:choose>
                    <xsl:when test="ancestor::contrib-group/aff or ancestor::article-meta/aff and not(ancestor::contrib-group/contrib/xref)">
                        <xsl:if test="ancestor::contrib-group/aff/email and not(ancestor::contrib-group/contrib/xref)">
                            <email><xsl:value-of select="ancestor::contrib-group/aff/email"/></email>
                        </xsl:if>
                        <xsl:if test="//author-notes/fn[@id=current()/ancestor::contrib-group/aff/xref/@rid]">
                            <email>
                                <xsl:value-of select="normalize-space(//author-notes/fn[@id=current()/ancestor::contrib-group/aff/xref/@rid])"/>
                            </email>
                        </xsl:if>
                        <xsl:for-each select="ancestor::contrib-group/aff | ancestor::article-meta/aff">
                            <xsl:if test="not(contains(@id,'cor'))">
                                <xsl:if test="not(break) and not(ancestor::contrib-group/contrib/xref)">
                                    <affiliation>
                                        <xsl:choose>
                                            <xsl:when test="institution | addr-line">
                                                <xsl:if test="institution">
                                                    <xsl:for-each select="institution">
                                                        <orgName type="institution">
                                                            <xsl:value-of select="."/>
                                                        </orgName>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="addr-line 
                                                    |country
                                                    |named-content[@content-type='street']
                                                    |named-content[@content-type='state']
                                                    |named-content[@content-type='postcode']
                                                    |named-content[@content-type='city']">
                                                    <xsl:for-each select="addr-line">
                                                        <xsl:choose>
                                                            <xsl:when test="institution
                                                                |country
                                                                |named-content[@content-type='street']
                                                                |named-content[@content-type='state']
                                                                |named-content[@content-type='postbox']
                                                                |named-content[@content-type='postcode']
                                                                |named-content[@content-type='city']">
                                                                <xsl:if test="institution">
                                                                    <xsl:for-each select="institution">
                                                                        <orgName type="institution">
                                                                            <xsl:value-of select="."/>
                                                                        </orgName>
                                                                    </xsl:for-each>
                                                                </xsl:if>
                                                                <xsl:if test="country
                                                                    |named-content[@content-type='street']
                                                                    |named-content[@content-type='state']
                                                                    |named-content[@content-type='postbox']
                                                                    |named-content[@content-type='postcode']
                                                                    |named-content[@content-type='city']">
                                                                    <address>
                                                                        <xsl:if test="named-content[@content-type='street']">
                                                                            <street>
                                                                                <xsl:value-of select="named-content[@content-type='street']"/>
                                                                            </street>
                                                                        </xsl:if>
                                                                        <xsl:if test="named-content[@content-type='state']">
                                                                            <state>
                                                                                <p>
                                                                                    <xsl:value-of select="named-content[@content-type='state']"/>
                                                                                </p>
                                                                            </state>
                                                                        </xsl:if>
                                                                        <xsl:if test="named-content[@content-type='postbox']">
                                                                            <postBox>
                                                                                <xsl:value-of select="named-content[@content-type='postbox']"/>
                                                                            </postBox>
                                                                        </xsl:if>
                                                                        <xsl:if test="named-content[@content-type='postcode']">
                                                                            <postCode>
                                                                                <xsl:value-of select="named-content[@content-type='postcode']"/>
                                                                            </postCode>
                                                                        </xsl:if>
                                                                        <xsl:if test="named-content[@content-type='city']">
                                                                            <settlement>
                                                                                <xsl:value-of select="named-content[@content-type='city']"/>
                                                                            </settlement>
                                                                        </xsl:if>
                                                                        <xsl:for-each select="country">
                                                                            <country>
                                                                                <xsl:attribute name="key">
                                                                                    <xsl:call-template name="normalizeISOCountry">
                                                                                        <xsl:with-param name="country" select="."/>
                                                                                    </xsl:call-template>
                                                                                </xsl:attribute>
                                                                                <xsl:value-of select="."/>
                                                                            </country>
                                                                        </xsl:for-each>
                                                                    </address>
                                                                </xsl:if>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <address>
                                                                    <addrLine>
                                                                        <xsl:apply-templates/>
                                                                    </addrLine>
                                                                </address>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                        <!--<xsl:for-each select="addr-line">
                                                            <addrLine>
                                                                <xsl:value-of select="."/>
                                                            </addrLine>
                                                        </xsl:for-each>
                                                        <xsl:for-each select="country">
                                                            <country>
                                                                <xsl:attribute name="key">
                                                                    <xsl:call-template name="normalizeISOCountry">
                                                                        <xsl:with-param name="country" select="."/>
                                                                    </xsl:call-template>
                                                                </xsl:attribute>
                                                                <xsl:value-of select="."/>
                                                            </country>
                                                        </xsl:for-each>-->
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </affiliation>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="name-alternatives">
                    <xsl:apply-templates/>
        <xsl:if test="ancestor::contrib-group/aff">
            <affiliation>
                <xsl:value-of select="ancestor::contrib-group/aff"/>
            </affiliation>
        </xsl:if>
    </xsl:template>

    <xsl:template match="collab">
        <name>
            <xsl:apply-templates/>
        </name>
    </xsl:template>
    
    <xsl:template match="sb:collaboration">
        <author role="collab">
            <xsl:apply-templates/>
        </author>
    </xsl:template>

    <!-- Elements for name components in Scholar One (first_name, middle_name, last_name, salutation, suffix, degree, role, person_title) -->
    <!-- Elements for name components in ArticleSetNLM 2.0 (FirstName, MiddleName, LastName...) -->
    <!-- NLM 2.3 article: surname, given-names, suffix, role -->
    <!-- Elements for name components in Elsevier (ce:given-name, ce:surname, ...) -->
    <!-- Elements for name components in Springer stage 2/3 (FamilyName, GivenName, Initials, Suffix, Particle...) -->
    <!-- Sage: ln, per_aut/fn, mn, suffix, role (fn ambigue avec footnote) -->
    <!-- BMJ: corresponding-author-firstname, corresponding-author-lastname, corresponding-author-middlename -->
    <xsl:template match="wiley:honorifics">
        <xsl:if test="normalize-space(.)">
            <addName>
                <xsl:apply-templates/>
            </addName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="fname |first_name | FirstName | ce:given-name | GivenName | per_aut/fn | given-names | given_name | corresponding-author-firstname | fname | fnm | wiley:givenNames">
        <xsl:if test="normalize-space(.)">
            <forename type="first">
                <xsl:apply-templates/>
            </forename>
        </xsl:if>
    </xsl:template>
    <xsl:template match="middle_name | MiddleName | mn | corresponding-author-middlename">
        <xsl:if test="normalize-space(.)">
            <forename type="middle">
                <xsl:apply-templates/>
            </forename>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Initials | inits">
        <xsl:if test="normalize-space(.)">
            <forename full="init">
                <xsl:apply-templates/>
            </forename>
        </xsl:if>
    </xsl:template>
    <xsl:template
        match="last_name | LastName | ce:surname | FamilyName | ln | surname | corresponding-author-lastname | surname | snm | wiley:familyName">
        <xsl:if test="normalize-space(.)">
            <surname>
                <xsl:apply-templates/>
            </surname>
        </xsl:if>
    </xsl:template>

    <xsl:template match="InstitutionalAuthorName" mode="simple">
        <xsl:if test="normalize-space(.)">
            <orgName type="institution">
                <xsl:apply-templates/>
            </orgName>
        </xsl:if>
    </xsl:template>

    <xsl:template match="InstitutionalAuthorName">
        <xsl:if test="normalize-space(.)">
            <orgName type="institution">
                <xsl:apply-templates/>
            </orgName>
            <persName>
                <surname>
                    <xsl:apply-templates/>
                </surname>
            </persName>
        </xsl:if>
    </xsl:template>

    <xsl:template match="salutation">
        <xsl:if test="normalize-space(.)">
            <roleName type="salutation">
                <xsl:apply-templates/>
            </roleName>
        </xsl:if>
    </xsl:template>
    <xsl:template match="degree | corresponding-author-title | person_title | degrees | ce:degrees | wiley:degrees">
        <xsl:if test="normalize-space(.)">
            <roleName type="degree">
                <xsl:apply-templates/>
            </roleName>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:biographyInfo">
        <state type="biography">
            <desc>
                <xsl:apply-templates/>
            </desc>
        </state>
    </xsl:template>
    <xsl:template match="wiley:email">
        <email>
            <xsl:apply-templates/>
        </email>
    </xsl:template>
    <xsl:template match="Particle">
        <xsl:if test="normalize-space(.)">
            <nameLink>
                <xsl:apply-templates/>
            </nameLink>
        </xsl:if>
    </xsl:template>
    <xsl:template match="suffix | Suffix | suff | wiley:nameSuffix|name_suffix">
        <xsl:if test="normalize-space(.)">
            <genName>
                <xsl:apply-templates/>
            </genName>
        </xsl:if>
    </xsl:template>

    <xsl:template match="prefix | ce:roles">
        <xsl:if test="normalize-space(.)">
            <roleName>
                <xsl:apply-templates/>
            </roleName>
        </xsl:if>
    </xsl:template>

    <xsl:template match="wiley:personName">
        <persName>
            <xsl:apply-templates select="wiley:honorifics"/>
            <xsl:apply-templates select="wiley:nameSuffix"/>
            <xsl:apply-templates select="wiley:givenNames"/>
            <xsl:apply-templates select="wiley:familyName"/>
            <xsl:apply-templates select="wiley:degrees"/>
           <!-- <xsl:apply-templates select="ancestor::wiley:creator/wiley:biographyInfo"/>-->
            <xsl:apply-templates select="wiley:biographyInfo/wiley:email"/>
        </persName>
    </xsl:template>

    <!-- SG - ajout email -->
    <xsl:template match="wiley:contactDetails">
        <email>
            <xsl:value-of select="wiley:email"/>
        </email>
    </xsl:template>

    <!-- Champs dans la description des noms qui ne sont pas retenus -->
    <xsl:template match="NoGivenName"/>
    <xsl:template match="ce:indexed-name"/>

</xsl:stylesheet>
