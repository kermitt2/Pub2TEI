<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ce="http://www.elsevier.com/xml/common/dtd"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns="http://www.tei-c.org/ns/1.0" xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd" xmlns:wiley="http://www.wiley.com/namespaces/wiley"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" method="xml"/>
    
    <!-- Generic rules for the decomposing names (cf. e.g. BMJ) -->
    <xsl:template match="name | persname | auname">
        <persName>
            <xsl:apply-templates/>
        </persName>
    </xsl:template>

    <xsl:template match="collab | sb:collaboration">
        <name type="collab">
            <xsl:apply-templates/>
        </name>
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
    
    <xsl:template match="first_name | FirstName | ce:given-name | GivenName | per_aut/fn | given-names | corresponding-author-firstname | fname | fnm | wiley:givenNames">
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
        <xsl:if test=". != ''">
            <roleName type="degree">
                <xsl:apply-templates/>
            </roleName>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:biographyInfo">
        <roleName type="biography">
            <xsl:apply-templates/>
        </roleName>
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
    <xsl:template match="suffix | Suffix | suff | wiley:nameSuffix">
        <xsl:if test="normalize-space(.)">
            <genName>
                <xsl:apply-templates/>
            </genName>
        </xsl:if>
    </xsl:template>

    <xsl:template match="role | prefix | ce:roles">
        <xsl:if test="normalize-space(.) != ''">
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
