<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
    
    <!--
    Décommenter la ligne suivante pour éviter les imports en rouge
                                  ou si jamais cette feuille était 
                                               utilisée directement
    -->
    <!--<xsl:include href="Imports.xsl"/>-->
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>created by romain dot loth at inist.fr</xd:p>
            <xd:p>ISTEX-CNRS 2014-12</xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>

    <!-- 
        =========================
        TODO dans les entrées IOP
        =========================
          RL: 
           - je ne trouve nulle part la langue
           - les attributs en entrée sont encore souvent ignorés
             dont notamment id et corresp entre affiliations <=> auteurs
           - pour l'identification du doctype utiliser en plus le article-type/type-number ?
    -->

    <!-- 
        ****************
        SQUELETTE GLOBAL
        ****************        
        IN: /. <<
        
        OUT: 
        /TEI/teiHeader/fileDesc/titleStmt/title >>
        /TEI/teiHeader/fileDesc/respStmt
        /TEI/teiHeader/fileDesc/sourceDesc/biblStruct >>
    -->
    <xsl:template match="/article">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <!-- Ici simplement reprise du titre principal (le détail est dans sourceDesc) -->
                        <title>
                            <xsl:value-of select="header/title-group/title"/>
                        </title>
                    </titleStmt>

                    <!-- proposition d'un "stamp" Pub2TEI -->
                    <respStmt>
                        <resp>Conversion from IOP XML to TEI-conformant markup</resp>
                        <name>Pub2TEI XSLT</name>
                    </respStmt>
                    <publicationStmt>
                        <p>this TEI version for ISTEX database (CNRS)</p>
                    </publicationStmt>



                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- Titre(s) article -->
                                <xsl:apply-templates select="header/title-group"/>

                                <!-- Auteurs article -->
                                <xsl:apply-templates select="header/author-group"/>

                                <!-- Adresse(s) d'affiliation -->
                                <xsl:apply-templates select="header/address-group"/>

                                <!-- Identifiants article (DOI, PII et 3 IDS internes à IOP ...) -->
                                <xsl:apply-templates select="article-metadata/article-data/doi"/>
                                <xsl:apply-templates select="article-metadata/article-data/pii"/>
                                <xsl:apply-templates select="article-metadata/article-data/ccc"/>
                                <xsl:apply-templates
                                    select="article-metadata/article-data/article-number"/>

                                <idno type="iop-artid">
                                    <xsl:value-of select="@artid"/>
                                </idno>

                            </analytic>
<xsl:text>
                                
</xsl:text>
                            <monogr>

                                <!-- Titres du périodique       NB: suppose un <jnl-data> ! -->
                                <xsl:apply-templates select="article-metadata/jnl-data/jnl-fullname"/>
                                <xsl:apply-templates
                                    select="article-metadata/jnl-data/jnl-abbreviation"/>
                                <xsl:apply-templates
                                    select="article-metadata/jnl-data/jnl-shortname"/>

                                <!-- Identifiants journal (ISSN et CODEN) -->
                                <xsl:apply-templates select="article-metadata/jnl-data/jnl-issn"/>
                                <xsl:apply-templates select="article-metadata/jnl-data/jnl-coden"/>


                                <imprint>
                                    <!-- VOLUMAISON -->
                                    <xsl:apply-templates
                                        select="article-metadata/volume-data/year-publication"/>
                                    <xsl:apply-templates
                                        select="article-metadata/volume-data/volume-number"/>
                                                                                         
                                    <xsl:apply-templates
                                        select="article-metadata/issue-data/issue-number"/>
                                    <xsl:apply-templates
                                        select="article-metadata/issue-data/coverdate"/>


                                    <!-- Pagination de l'article dans la monographie ou le fascicule -->
                                    <biblScope unit="pp">
                                        <xsl:attribute name="from">
                                            <xsl:value-of
                                                select="article-metadata/article-data/first-page"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="to">
                                            <xsl:value-of
                                                select="article-metadata/article-data/last-page"/>
                                        </xsl:attribute>
                                    </biblScope>

                                    <xsl:apply-templates
                                        select="article-metadata/article-data/length"/>

                                    <!-- Publisher jnl -->
                                    <xsl:apply-templates
                                        select="article-metadata/jnl-data/jnl-imprint"/>

                                    <!-- "printed in" ~ pubPlace -->
                                    <xsl:apply-templates
                                        select="article-metadata/article-data/printed"/>
                                </imprint>
                            </monogr>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <!-- Reprise directe de toutes les classifications de l'article -->
                    <xsl:apply-templates select="header/classifications"/>
                    <!-- textClass ==> les classCode "pacs"
                                       ==> les subj. areas (propres à une série ?)
                                       ==> les kwds (si pas d'autre meilleur endroit)-->
                    
                    <!-- history => creation/date+ -->
                    <xsl:apply-templates select="header/history"/>
                </profileDesc>
                
                <!-- ici <encodingDesc> ? -->

            </teiHeader>
            <!--  
                <text>
                    <front>
                    </front>
                    <body>
                    </body>
                    <back>
                        <listBibl> (<biblStruct/> +) </listBibl>
                    </back>
                </text>
            -->
        </TEI>

        <!--durant les test TODO enlever-->
        <!--<xsl:apply-templates/>-->
    </xsl:template>


    <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        première partie de l'input :
        
        =============================
          ARTICLE-METADATA/
              [ART|ISS|VOL|JNL]-DATA
        =============================
    -->


    <!-- ARTICLE-DATA ***************************

        IN: /article/article-metadata/article-data/* <<
        La zone article-data recelle plein de trucs

        ==> templates "identifiants"
        écrivent uniquement dans header/.../analytic (d'où elles sont appelées)

        OUT: 
        teiHeader/fileDesc/sourceDesc/biblStruct/analytic/.
        >> idno
        
    -->

    <!-- identifiant DOI-->
    <xsl:template match="article-data/doi">
        <idno type="DOI">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- identifiant PII -->
    <xsl:template match="article-data/pii">
        <idno type="PII">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- identifiant commercial IOP dit "ccc" -->
    <xsl:template match="article-data/ccc">
        <idno type="iop-ccc">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- numéro d'article IOP -->
    <xsl:template match="article-data/article-number">
        <idno type="iop-no">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>


    <!-- 
        Il y a aussi des imprint-like
        
        OUT: 
        teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint
        >> pubPlace
        >> biblScope
    -->

    <!-- printed in => pubPlace  -->
    <xsl:template match="article-data/printed">
        <pubPlace>
            <xsl:value-of select="."/>
        </pubPlace>
    </xsl:template>

    <!-- length => biblScope pp range  -->
    <xsl:template match="article-data/length">
        <biblScope unit="pp">
            <xsl:attribute name="range">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </biblScope>
    </xsl:template>

    <!-- first-page et last-page utilisés directement dans monogr -->

    <!-- FIN ARTICLE-DATA *********************** -->




    <!-- JOURNAL-DATA ***************************
        IN: /article/article-metadata/jnl-data/* <<
        
        OUT: 
        teiHeader/fileDesc/sourceDesc/biblStruct/monogr
        >> title
        >> idno (ISSN, coden)
        >> ref (adresse web)
    -->

    <!-- full j title 
         ex: "Journal of Physics D: Applied Physics" -->
    <xsl:template match="jnl-data/jnl-fullname">
        <title level="j" type="full">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>

    <!-- abbrev j title 
        ex: "J. Phys. D: Appl. Phys." -->
    <xsl:template match="jnl-data/jnl-abbreviation">
        <title level="j" type="abbrev">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>

    <!-- short j title 
        ex: "JPhysD" -->
    <xsl:template match="jnl-data/jnl-shortname">
        <title level="j" type="full">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>

    <!-- ISSN
        ex: "0022-3727" -->
    <xsl:template match="jnl-data/jnl-issn">
        <idno type="ISSN">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- CODEN 
        ex: "JPAPBE" -->
    <xsl:template match="jnl-data/jnl-coden">
        <idno type="CODEN">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- web address
        ex: "stacks.iop.org/JPhysD" -->
    <xsl:template match="jnl-data/jnl-web-address">
        <ref type="URL">
            <xsl:value-of select="."/>
        </ref>
    </xsl:template>

    <!-- imprint (~publisher)
        ex: "IOP Publishing" -->
    <xsl:template match="jnl-data/jnl-imprint">
        <publisher>
            <xsl:value-of select="."/>
        </publisher>
    </xsl:template>

    <!-- FIN JOURNAL-DATA *********************** -->



    <!-- ISSUE-DATA **************************
        
        IN: /article/article-metadata/issue-data/* <<
        
        OUT: 
        teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint
        >> biblScope
        >> date
    -->

    <!-- issue number => biblScope unit issue 
        ex: "4" -->
    <xsl:template match="issue-data/issue-number">
        <biblScope unit="issue">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>

    <!-- coverdate => date type="cover"  ?? 
        ex: "April 2006" -->
    <xsl:template match="issue-data/coverdate">
        
        <!-- On tokenize sur les espaces -->
        <xsl:param name="segments" 
            select="tokenize(.,' ')"/>
        <xsl:param name="nbSegments" 
            select="count($segments)"/>
        
        <date type="issue-cover">
            <!-- l'attribut iso @when -->
            <xsl:attribute name="when">
                <xsl:choose>
                    <xsl:when test="$nbSegments = 3">
                        <xsl:call-template name="makeISODateFromComponents">
                            <xsl:with-param name="oldDay" select="$segments[1]"/>
                            <xsl:with-param name="oldMonth" select="$segments[2]"/>
                            <xsl:with-param name="oldYear" select="$segments[3]"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$nbSegments = 2">
                        <xsl:call-template name="makeISODateFromComponents">
                            <xsl:with-param name="oldMonth" select="$segments[1]"/>
                            <xsl:with-param name="oldYear" select="$segments[2]"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="makeISODateFromComponents">
                            <xsl:with-param name="oldYear" select="$segments[$nbSegments]"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            
            <!-- et bien sur la valeur d'origine -->
            <xsl:value-of select="."/>
        </date>
    </xsl:template>


    <!-- et VOLUME-DATA ***
        
        IN: /article/article-metadata/volume-data/* <<
        
        OUT: 
        teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint
        >> biblScope
        >> date
    -->
    <!-- volume-number
        ex: "Journal of Physics D: Applied Physics" -->
    <xsl:template match="volume-data/volume-number">
        <biblScope unit="vol">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>

    <!-- year-publication => année seule => date sans when
        ex: "2007" -->
    <xsl:template match="volume-data/year-publication">
        <date>
            <xsl:value-of select="."/>
        </date>
    </xsl:template>

    <!-- FIN ISSUE/VOLUME ******************** -->






    <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        ==============
            HEADER
        ==============
    -->

    <!-- TITRES DE L'ARTICLE ***********************
        IN: /article/header/title-group/* <<
        OUT: teiHeader/fileDesc/sourceDesc/biblStruct/analytic
             >> title
    -->
    <xsl:template match="/article/header/title-group">
        <!-- On évite de copier la balise <title-group> 
            mais on doit couvrir tous les cas de figure -->
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="title-group/title">
        <title level="a" type="main">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>

    <xsl:template match="title-group/short-title">
        <title level="a" type="short">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>

    <xsl:template match="title-group/ej-title">
        <title level="a" type="alt" subtype="ej">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>
    <!-- FIN TITRES DE L'ARTICLE*********************** -->



    <!-- AUTEURS ***********************
        IN: /article/header/author-group/*
    -->
    <xsl:template match="/article/header/author-group">
        <!-- On évite de copier la balise <author-group> 
            + on doit couvrir tous les cas de figure -->
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Cas normal-->
    <xsl:template match="author-group/author">
        <author>
            <persName>
                <!-- ne préjuge pas de l'ordre -->
                <xsl:apply-templates select="./*[contains(name(),'-name')]"/>
            </persName>
        </author>
    </xsl:template>

    <xsl:template match="first-names">
        <!-- TODO
            tenter de séparer first-names sur espace ou point et            
            générer plusieurs forename (pour chaque initiale) -->
        <forename>
            <xsl:value-of select="."/>
        </forename>
    </xsl:template>

    <xsl:template match="second-name">
        <surname>
            <xsl:value-of select="."/>
        </surname>
    </xsl:template>

    <!-- "Collaborateur" non spécifique => respStmt
        Ex: "the ASDEX Upgrade Team"
    -->
    <xsl:template match="author-group/collaboration">
        <respStmt>
            <name>
                <xsl:value-of select="."/>
            </name>
        </respStmt>
    </xsl:template>

    <!-- "les auteurs" : version "condensée conventionnellement"
        Ex: "K Rahmani et al"
        TODO <author> ou <bibl> ?
    -->
    <xsl:template match="author-group/short-author-list">
        <author>
            <xsl:value-of select="."/>
        </author>
    </xsl:template>

    <!-- FIN AUTEURS *********************** -->


    <!-- ADRESSES ***********************
        IN: /article/header/address-group/*  <<
        
        TODO : correspondances auteurs <=> adresses
    -->
    <xsl:template match="/article/header/address-group">
        <!-- 2 possibilités: adresse postale ou email -->
        <xsl:apply-templates/>
    </xsl:template>

    <!-- 1) adresse postale -->
    <xsl:template match="/article/header/address-group/address">
        <address>
            <!--pays et/ou orgname dans une ligne "d'affiliation" plus longue-->
            <xsl:apply-templates/>
        </address>
    </xsl:template>

    <!--      (si pays)
              IN: address-group/address/country
              OUT: ./country
              ==> rien à faire tant que apply-templates en amont
        
              Ex: "Belgium"
    -->

    <!-- (si orgname)
             IN: <orgname>
             OUT: <orgName>
             Ex: "Laboratoire de physique des plasmas—Laboratorium voor Plasmafysica, 
                  Association ‘Euratom-Etat Belge’—Associatie ‘Euratom-Belgische Staat’, 
                  Ecole Royale Militaire—Koninklijke Militaire School"
    -->
    <xsl:template match="/article/header/address-group/address/orgname">
        <orgName>
            <xsl:value-of select="."/>
        </orgName>
    </xsl:template>


    <!-- 2) email : conteneur "e-adresse" -->
    <xsl:template match="e-address">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- email proprement dit
        IN: address-group/e-address/email
        OUT: ./email
        Ex: "sam.gamegie@cityhall.shire"
        ==> rien à faire tant que apply-templates en amont
    -->

    <!-- FIN ADDR *********************** -->



    <!-- ABSTRACT ***********************
        IN: /article/header/abstract-group/*  <<
        
        OUT: teiHeader/profileDesc/abstract
             >> head
             >> p
        
        TODO passer tout ça dans KeywordsAbstract.xsl
    -->

    <xsl:template match="abstract-group">
        <abstract>
            <xsl:apply-templates select="heading"/>
            <xsl:apply-templates select="p"/>
        </abstract>
    </xsl:template>

    <xsl:template match="abstract-group/heading">
        <head>
            <xsl:value-of select="."/>
        </head>
    </xsl:template>

    <xsl:template match="abstract-group/p">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>


    <!-- FIN ABS *********************** -->



    <!-- CLASSIFICATIONS ***********************
        IN: /article/header/classifications  <<
        
       OUT: teiHeader/fileDesc/profileDesc/
            >> textClass/classCode
            >> textClass/keywords
            >> biblScope ?
    -->
    
    <!-- Déjà on met un textClass 
         (car cet elt recouvre bien tous les 
         contenus possibles de <classifications>) -->
    <xsl:template match="classifications">
        <textClass>
            <xsl:apply-templates/>
        </textClass>
    </xsl:template>

    <!-- class-codes ==> classCodes
       La tei a un niveau d'imbrication de moins => on plonge direct
       (mais on reviendra chercher l'attribut scheme ici) 
       
       Ex: <class-codes scheme="pacs"> 
              (<code>)+ 
           </class-codes>
    -->
    <xsl:template match="classifications/class-codes">
        <xsl:apply-templates/>
    </xsl:template>


    <!--  IN: celui au-dessus  <<
         OUT: profileDesc/textClass
              >> classCode +
         Ex:  "52.35.Ra"
    -->
    <xsl:template match="classifications/class-codes/code">
        <classCode>
            <xsl:attribute name="scheme">
                <xsl:value-of select="../@scheme"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </classCode>
    </xsl:template>


    <!--  keywords  ==> keywords
        
          IN: classification  <<
         OUT: profileDesc/textClass
              >> keywords
    -->
    <xsl:template match="classifications/keywords">
        <keywords>
            <xsl:if test="@type">
                <xsl:attribute name="scheme">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </keywords>
    </xsl:template>

    <!--  
         IN: celui au-dessus  <<
        OUT: profileDesc/textClass/keywords
          >> term
    -->
    <xsl:template match="classifications/keywords/keyword">
        <term>
            <xsl:choose>
                <xsl:when test="@code">
                    <xsl:value-of select="@code"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </term>
    </xsl:template>


    <!-- On traite les subject-areas comme des classCode  
        
        subject-areas ==> classCode (en enlevant une imbrication)
        
        IN: classification  <<
        OUT: skip inside
    -->    
    <xsl:template match="classifications/subject-areas">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--  
        IN: celui au-dessus  <<
        OUT: profileDesc/textClass
        >> classCode +
    -->
    <xsl:template match="classifications/subject-areas/category">
        <classCode>
            <xsl:attribute name="scheme">
                <xsl:value-of select="../@type"/>
            </xsl:attribute>
            
            <xsl:choose>
                <xsl:when test="@code">
                     <xsl:value-of select="@code"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </classCode>
    </xsl:template>
    <!-- FIN CLASSIFS ************************** -->


    <!-- HISTORY ************************ 
        
        IN : /article/header/history  <<
        OUT: teiHeader/creation
             >> date +
    
        Ex: <history received="14 January 2010" finalform="4 March 2010" online="14 April 2010"/>
        
        ==> apparement cette fois tout est dans les attributs
    -->
    
    <xsl:template match="header/history">
        <creation>
            <xsl:for-each select="attribute::node()">
                <date>
                    <!-- TODO l'attribut iso @when -->
                    
                    <!-- reprise du type annoncé par iop -->
                    <xsl:attribute name="type">
                        <xsl:value-of select="name()"/>
                    </xsl:attribute>
     
                    <!-- reprise de valeur depuis le contenu de l'attribut -->
                    <xsl:value-of select="."/>
                </date>
            </xsl:for-each>
        </creation>
            
    </xsl:template>

    <!-- FIN HISTORY ******************** -->




    <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        ==============
            BODY
        ==============
    -->

</xsl:stylesheet>
