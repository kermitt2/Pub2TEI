<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
    
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
           - les éléments internes de structuration typographique :
             italic sub sup upright inline-eqn math-text sont sautés par des xsl:value-of
             dans les titres etc.
           - pour l'identification du doctype utiliser en plus le article-type/type-number ?
           
           £=> et une fois fini mettre un exemple de sortie dans Samples/TestOutputTEI
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
    <xsl:template match="article">
        <xsl:comment>
            <xsl:text>Version 0.1 générée le </xsl:text>
            <xsl:value-of select="$datecreation"/>
        </xsl:comment>
        <TEI>
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:text>https://istex.github.io/odd-istex/out/istex.xsd</xsl:text>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <!-- Ici simplement reprise du titre principal (le détail est dans sourceDesc) -->
                        <title level="a" type="main">
                            <xsl:value-of select="header/title-group/title"/>
                        </title>
                    </titleStmt>

                    <!-- proposition d'un "stamp" Pub2TEI -->
                  <!-- <editionStmt>
                        <edition>TEI version</edition>
                        <respStmt>
                            <resp>Conversion from IOP XML to TEI-conformant markup</resp>
                            <name>Pub2TEI XSLT</name>
                        </respStmt>
                    </editionStmt>-->
                    <publicationStmt>
                        <authority>ISTEX</authority>
                        <!-- Publisher jnl -->
                        <xsl:apply-templates
                            select="article-metadata/jnl-data/jnl-imprint"/>
                        
                        <!-- "printed in" ~ pubPlace -->
                        <xsl:apply-templates
                            select="article-metadata/article-data/printed"/>
                       <availability>
                           <licence>
                               <xsl:value-of select="//article-metadata/jnl-data/jnl-imprint"/>
                           </licence>
                       </availability>
                    </publicationStmt>

                    <!-- métadonnées décrivant l'original -->
                    <sourceDesc>
                        <biblStruct>
                            <analytic>
                                <!-- Titre(s) article -->
                                <xsl:apply-templates select="header/title-group"/>

                                <!-- Auteurs article -->
                                <xsl:apply-templates select="header/author-group|author-group/author
                                    | author-group/au
                                    | authors/author
                                    | authors/au
                                    | collaboration/author"/>

                                <!-- Adresse(s) d'affiliation -->
                                <xsl:apply-templates select="header/editor-group |author-group/collaboration | authors/collaboration | editors/collaboration"/>

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
                                        select="article-metadata/issue-data/coverdate"/>
                                    <xsl:apply-templates
                                        select="article-metadata/volume-data/year-publication"/>
                                    <xsl:apply-templates
                                        select="article-metadata/volume-data/volume-number"/>
                                                                                         
                                    <xsl:apply-templates
                                        select="article-metadata/issue-data/issue-number"/>
                                    


                                    <!-- Pagination de l'article dans la monographie ou le fascicule -->
                                    <biblScope unit="pp">
                                        <xsl:attribute name="from" select="article-metadata/article-data/first-page"/>
                                        <xsl:attribute name="to" select="article-metadata/article-data/last-page"/>
                                    </biblScope>

                                    <xsl:apply-templates
                                        select="article-metadata/article-data/length"/>
                                </imprint>
                            </monogr>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                
                <!-- métadonnées de profil (thématique et historique du doc) -->
                <profileDesc>
					
                    <!-- Le résumé: abstract -->
                    <xsl:apply-templates select="header/abstract-group"/>
					
                    <!-- Reprise directe de toutes les classifications de l'article -->
                    <xsl:apply-templates select="header/classifications"/>
                    <!-- textClass ==> les classCode "pacs"
                                   ==> les subj. areas (propres à une série ?)
                                   ==> les kwds (si pas d'autre meilleur endroit)-->
                    
                    <!-- history => creation/date+ -->
                    <xsl:apply-templates select="header/history"/>

                </profileDesc>
                
                <!-- TODO ici <encodingDesc> ? -->

            </teiHeader>
                <text>
                    <xsl:choose>
                        <xsl:when test="//sec-level1">
                            <body>
                                <xsl:apply-templates select="//sec-level1"/>
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
                        <!-- Lancement des refbibs -->
                        <xsl:apply-templates select="/article/back/references"/>
                        <!-- <listBibl> (<biblStruct/> +) </listBibl> -->
                        
                        
                        <!-- Notes de bas de page -->
                        <xsl:apply-templates select="/article/back/footnotes"/>
                    </back>
                </text>
        </TEI>

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
       <biblScope unit="page-count">
           <xsl:value-of select="."/>
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
        <date type="Published">
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



    <!-- AUTEURS ***************************************
        
        Ces templates servent à 2 endroits : <header> et <references>
        /article/header/author-group/* 
        /article/back/references//(journal-ref|book-ref|conf-ref|misc-ref)/authors
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        IN: author-group/* 
            authors/*
            editors/*
        
        OUT: /TEI/teiHeader//sourceDesc/biblStruct
             /TEI/text/back//listBibl/biblStruct +
             
           >> analytic/author+/*
           >> analytic/editor+/*
    -->
    
    <!-- author-group (dans le header) 
         authors (dans les références biblio)
         
         => deux conteneurs de liste d'auteurs, un même comportement
         
         TODO: (pour editors uniquement) utiliser éventuellement l'attribut optionnel @order
    -->
    <xsl:template match="header/author-group">
        <!-- Pas de liste en TEI, mais on remontera parfois à ce tag 
             car les author IOP ne sont pas tous des author TEI,
             notamment pour les editor        -->
        <xsl:apply-templates/>
    </xsl:template>
    


    <!-- author | au
         
         IN: author-group/author (templates au-dessus)
             authors/au
             editors/author
             editors/au
             
        OUT: author/persName
        
        Cas "auteur normal"
    -->
    <xsl:template match="author-group/author
                       | author-group/au
                       | authors/author
                       | authors/au
                       | collaboration/author">
        <author>
            <persName>
                <!-- ne préjuge pas de l'ordre -->
                <xsl:apply-templates/>
            </persName>
            <xsl:apply-templates select="/article/header/address-group/e-address/email"/>
            <xsl:apply-templates select="/article/header/address-group/address"/>
        </author>
    </xsl:template>
    
    <!-- idem si père = editors -->
    <xsl:template match="editors/author
                       | editors/au">
        <editor>
            <persName>
                <!-- ne préjuge pas de l'ordre -->
                <xsl:apply-templates select="./*[contains(name(),'-name')]"/>
            </persName>
        </editor>
    </xsl:template>
    
    
    <!-- (Cas rares)
        IN: (authors | author-group | editors)/.
         << short-author-list
         << corporate
         << collaboration
         << collaboration/group
         << authors/others
    -->

    
    <!-- "les auteurs" : version "condensée conventionnellement"
        Ex: "K Rahmani et al"
        Uniquement dans la référence du header (->sourceDesc)
        
        TODO <author> ou <bibl> ?
    -->
    <xsl:template match="author-group/short-author-list">
        <author>
            <xsl:value-of select="."/>
        </author>
    </xsl:template>
    
    <!-- idem si père = editors -->
    <xsl:template match="editors/others">
        <editor>
            <xsl:value-of select="."/>
        </editor>
    </xsl:template>

    <!-- corporate
        Ex: "K Rahmani et al"
        
        TODO <author> ou <bibl> ?
    -->
    <xsl:template match="author-group/corporate | authors/corporate">
        <author>
            <orgName>
                <xsl:value-of select="."/>
            </orgName>
        </author>
    </xsl:template>
    
    <!-- idem si père = editors -->
    <xsl:template match="editors/corporate">
        <editor>
            <orgName>
                <xsl:value-of select="."/>
            </orgName>
        </editor>
    </xsl:template>
    
    <!--authors/collaboration 
        "Collaborateur" non spécifique => respStmt
        Ex: "the ASDEX Upgrade Team"
        
        TODO :
          - attribut @reflist en entrée à examiner et éventuellement reprendre
    -->
    <xsl:template match="author-group/collaboration | authors/collaboration | editors/collaboration">
        <xsl:apply-templates select="author"/>
        <xsl:apply-templates select="editor"/>
        <xsl:apply-templates select="group"/>
    </xsl:template>
    
    <!--authors/collaboration/group
        (optionnel) le seul sous-élément autorisé de <collaboration>
        TODO voir si on peut ajouter quelque chose ici
    -->
    <xsl:template match="collaboration/group">
        <author>
            <name>
        <xsl:apply-templates/>
            </name>
        </author>
    </xsl:template>
    <!--authors/others
        Ex: "<other><italic>et al.</italic></other>"
        Vu uniquement dans les références de fin d'article
    -->
    <xsl:template match="authors/others">
        <author ana="other-authors">
            <xsl:value-of select="normalize-space(.)"/>
        </author>
    </xsl:template>
    
    <!-- idem si père = editors -->
    <xsl:template match="editors/others">
        <editor ana="other-authors">
            <xsl:value-of select="normalize-space(.)"/>
        </editor>
    </xsl:template>
    
    

    <!-- sous-éléments AUTEURS *************
        NB: utilisables pour le header et pour les refbibs du <back>
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        IN: << /article/header/author-group/author/*
            << /article/back/references/reference-list/*-ref/authors/au/*
    -->
    
    <!-- prénoms -->
    <xsl:template match="first-names">
        <forename type="first">
            <xsl:value-of select="."/>
        </forename>
    </xsl:template>


    <!-- nom de famille -->
    <xsl:template match="second-name">
        <surname>
            <xsl:value-of select="."/>
        </surname>
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
        <affiliation>
            <address>
                <addrLine>
                    <!--pays et/ou orgname dans une ligne "d'affiliation" plus longue-->
                    <xsl:apply-templates/>
                </addrLine>
            </address>
        </affiliation>
    </xsl:template>


    <!--      (si pays)
              IN: address-group/address/country
              OUT: ./country
              ==> rien à faire tant que apply-templates en amont 
                                 et qu'il n'y pas de namespaces
        
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
    <xsl:template match="/article/header/address-group/e-address/email">
        <email>
            <xsl:value-of select="."/>
        </email>
    </xsl:template>

    <!-- email proprement dit
        IN: address-group/e-address/email
        OUT: ./email
        Ex: "sam.gamegie@cityhall.shire"
        ==> rien à faire tant que apply-templates en amont
                            et qu'il n'y pas de namespaces
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
            <xsl:apply-templates select="abstract/heading"/>
            <xsl:apply-templates select="abstract/p"/>
        </abstract>
    </xsl:template>

    <!-- les templates pour <heading> et <p> sont plus bas
         dans la zone BODY -->


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
        <textClass ana="classification">
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
            <xsl:attribute name="scheme" select="../@scheme"/>
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
                <xsl:attribute name="scheme" select="@type"/>
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
            <xsl:attribute name="scheme" select="../@type"/>
            
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
                    <xsl:attribute name="type" select="name()"/>
                        
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
    <xsl:template match="body">
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="sec-level1">
        <div>
            <!-- id -->
            <xsl:attribute name="n" select="@id"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="sec-level2">
        <div>
            <!-- id -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- FIN BODY *********************** -->
    
    
    
    <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        dernière partie de l'input :
        
        ==============
             BACK
        ==============
        
        < REFERENCES
        < FOOTNOTES
        
    -->

   
    <!-- ^^^^^^^^^^
         REFERENCES (biblio)
         ^^^^^^^^^^
        IN: /article/back << references
        
        OUT: TEI/text/back/div[@id="references]/listBibl/
        >> biblStruct +/analytic
        >> biblStruct +/monographic
        
       NB:  Ces 7 templates forment une structure générale qui 
            appelle ensuite les sous-éléments ad hoc (plus bas)
            
       NB2: On place les identifiants à leur niveau pertinent (DOI article => analytic, ISBN, ISSN => monogr)
            mais les liens web ref[@url] en dehors d'analytic et monogr, comme dans l'exemple
            n° 4 (Coombs) de la doc sur www.tei-c.org/release/doc/tei-p5-doc/en/html/CO.html#COBICOL
        
        TODO 
          - harmoniser avec Bibliography.xsl
          - idem avec JournalComponents.xsl (volume, etc)
          - l'y incorporer éventuellement
          - étudier les cas de l'attribut body/@refstyle en input
            (valeurs observées = "numeric" ou "alphabetic")
    -->
    
    <!-- conteneur section -->
    <xsl:template match="article/back/references">
        <div type="references">
            <xsl:apply-templates select="reference-list"/>
        </div>
    </xsl:template>
    
    <!-- reference-list ***********************
          IN:  article/back/references/reference-list <<
         OUT: >>listBibl
      -->
    <xsl:template match="reference-list">
        <listBibl>
            <!-- n entrées de tag parmi {journal-ref | book-ref | conf-ref | misc-ref} 
                         ou cas "multipart" (imbrication gigogne de plusieurs entrées)
            -->
            <xsl:apply-templates select="multipart | ref-group | *[ends-with(local-name(),'-ref')]"/>
        </listBibl>
    </xsl:template> 
    
    <!-- multipart | ref-group
          (cas de refbibs gigognes éventuellement récursives)
          IN:  le précédent
          OUT: listBibl
     -->
    <xsl:template match="reference-list//multipart | reference-list//refgroup">
        <!-- k entrées de tag parmi {journal-ref | book-ref | conf-ref | misc-ref} -->
        <xsl:apply-templates select="multipart | ref-group | *[ends-with(local-name(),'-ref')]"/>
    </xsl:template> 
    
    <!-- SOUS-ELEMENTS BIBLIO (1/4: pour analytic) ********************
        
        IN:  journal-ref | book-ref | conf-ref | misc-ref
             << art-title
             << art-number
             << preprint-info/art-number
             << crossref/cr_doi
             
        OUT: biblStruct
             >> analytic/title[@level="a"]
             >> analytic/idno[@type="..."]
    -->

    <!-- art-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/art-title">
        <title level="m" type="main">
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
    
    <!-- misc-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/misc-title">
        <title level="a">
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template> 
    
    <!-- art-number | preprint-info/art-number
         @type observé parmi jcap|jstat|jhep|arxiv (donc émis par la revue ou par un site externe)
         
         NB : peut se trouver directement dans *-ref ou bien (plus rare) sous preprint-info
    -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/art-number 
                       | *[ends-with(local-name(),'-ref')]/preprint-info/art-number">
        <idno>
            <xsl:attribute name="type" select="@type"/>
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- misc-text/extdoi 
         NB: les autres misc-text sont traités en elts <note> après monogr -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/misc-text/extdoi">
        <idno type="DOI">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>
    
    <!-- crossref/cr_doi -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/crossref/cr_doi">
        <idno type="DOI">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>
    
    <!--TODO     links misc-text preprint-info-->
    

    <!-- SOUS-ELEMENTS BIBLIO (2/4: pour monogr) *********************
        
        IN: journal-ref | book-ref | conf-ref | misc-ref
        <<jnl-title
        <<book-title
        <<conf-title
        <<edition
        <<crossref/cr_issn
        <<year
        <<volume
        <<part
        <<chap
        <<issno
        <<pages
        <<source
        <<publication/publisher
        <<publication/place
        
        
        NB: <<conf-title et <<conf-place traités directement dans conf-ref
        
        OUT: biblStruct/monogr
        >> title[@level="j"]
        >> title[@level="m"]
        >> edition
        >> meeting
        >> imprint/date[@type="year"]
        >> imprint/biblScope[@unit="vol"]
        >> imprint/biblScope[@unit="part"]
        >> imprint/biblScope[@unit="chap"]
        >> imprint/biblScope[@unit="issue"]
        >> imprint/biblScope[@unit="pp"]
        >> imprint/publisher
        >> imprint/pubPlace
        
    -->
    
    <!-- jnl-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/jnl-title">
        <title level="j">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>
    
    <!-- book-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/book-title">
        <title level="m">
            <xsl:value-of select="."/>
            <!-- tei:meeting sous-catégorise le lieu -->
            <xsl:apply-templates select="../conf-place"/>
        </title>
    </xsl:template>
    
    <!-- conf-title *dans les cas rares* d'un parent journal-ref ou misc-ref
         (pour les conf-ref on ne passe pas par ici)           -->
    <xsl:template match="journal-ref/conf-title">
        <meeting>
            <xsl:value-of select="."/>
        </meeting>
    </xsl:template>
    
    <!--edition
        ex: "4th edn" -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/edition">
        <edition>
            <xsl:value-of select="."/>
        </edition>
    </xsl:template>

    <!--patent-number
        ex: "US Patent US 2003/0116528 A1" -->
    <xsl:template match="misc-ref/patent-number">
        <idno type="docNumber">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- crossref/cr_issn -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/crossref/cr_issn">
        <idno>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="@type='electronic'">eISSN</xsl:when>
                    <xsl:otherwise>ISSN</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>
    
    <!-- misc-text/~ISBN-like~
        NB: les autres misc-text sont traités en elts <note> après monogr -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/misc-text[matches(normalize-space(.), '^ISBN(-1[03])?\s?:?\s[-0-9xX ]{10,17}$')]">
        <idno type="ISBN">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>
    
    <!--   - - - - 
        >> IMPRINT 
           - - - -    -->
    
    <!-- year
         TODO: attribut ISO @when
    -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/year">
        <date type="year">
            <xsl:value-of select="."/>
        </date>
    </xsl:template>
    
    
    <!-- volume -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/volume">
        <biblScope unit="vol">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>
    
    <!-- part   -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/part">
        <biblScope unit="part">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>
    
    <!-- chap   -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/chap">
        <biblScope unit="chap">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>
    
    <!-- issno  -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/issue">
        <biblScope unit="issue">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>
    
    <!-- pages  -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/pages">
        <biblScope unit="pp">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>

    <!-- source 
        ex: l'université pour les thèses de doctorat 
            (se rencontre surtout dans les misc-ref)
        TODO : voir si tei:authority convient mieux que tei:publisher
    -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/source">
        <publisher>
            <xsl:value-of select="."/>
        </publisher>
    </xsl:template>
    
    <!-- publication/publisher -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/publication/publisher">
        <publisher>
            <xsl:value-of select="."/>
        </publisher>
    </xsl:template>
    
    <!-- publication/place -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/publication/place">
        <pubPlace>
            <xsl:value-of select="."/>
        </pubPlace>
    </xsl:template>
    

    
    
    <!-- SOUS-ELEMENTS BIBLIO (3/4: pour author+ et editor+) *****************
             +++++++++++++++++
        Déjà traités plus haut dans /article/header pour /TEI/header/sourceDesc
             +++++++++++++++++
        
    -->
    
    <!-- SOUS-ELEMENTS BIBLIO (4/4: ni analy. ni monogr.) ********************
       
    -->

    <!-- series | series/volume -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/series">
        <series>
            <title type="main" level="s">
                <xsl:value-of select="normalize-space(text())"/>
            </title>
            <xsl:if test="volume">
                <biblScope unit="vol">
                    <xsl:value-of select="volume"/>
                </biblScope>
            </xsl:if>
        </series>
    </xsl:template>
    
    <!-- misc-text
        
        NB: malheureusement très varié ! 

        Pourra devenir en TEI l'un des éléments suivants :
           - idno[@type="DOI|ISBN"]   => traités à part (ci-dessus, resp. dans analytic et dans monogr)
           - note                     => traités ici
           - ref[@type="url"]         => traités ici
        
        ex: <misc-text>in preparation</misc-text>
        ex: <misc-text>at press, <extdoi doi="10.1007/s11082-009-9349-3" base="http://dx.doi.org/">doi:10.1007/s11082-009-9349-3</extdoi></misc-text>
        ex: <misc-text>ISBN 0-9586039-2-8</misc-text>
        ex: <misc-text><italic>ICTP Internal Report</italic> IC/95/216</misc-text>
        ex: <misc-text>arXiv:<arxiv url="cond-mat/0408518v1">cond-mat/0408518v1</arxiv></misc-text>
        ex: <misc-text>On the fluctuating flow characteristics in the vicinity of gate slots <italic>PhD Thesis</italic> Division of Hydraulic Engineering, University of Trondheim, Norwegian Institute of Technology</misc-text>
        ex: <misc-text>(Book of abstracts 3)</misc-text>
        ex: <misc-text>OptoDesigner by PhoeniX Software <webref url="http://www.phoenixbv.com/">http://www.phoenixbv.com/</webref>
    -->
    <xsl:template name="autres_misc-text"
                  match="*[ends-with(local-name(),'-ref')]/misc-text[not(extdoi) 
                                                                 and not(matches(normalize-space(.), '^ISBN(-1[03])?\s?:?\s[-0-9xX ]{10,17}$'))]">
        <note place="inline">
            <xsl:value-of select="text()"/>
            <xsl:apply-templates select="webref | arxiv"/>
        </note>
    </xsl:template>
    
    <!-- liens inclus dans une note -->
    <xsl:template match="misc-text/webref | misc-text/arxiv | links/arxiv">
        <ref type="url">
            <xsl:if test="@url">
                <xsl:attribute name="target" select="@url"/>
            </xsl:if>
            <xsl:value-of select="."/>
        </ref>
    </xsl:template>
    
    <!-- preprint >> note
         NB: preprint-info/art-number déjà traité dans les templates pour analytic!
    -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/preprint-info/preprint
                       | *[ends-with(local-name(),'-ref')]/preprint">
        <note place="inline">
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    
    <!-- thesis >> note
         sert aussi comme test pour l'attribut ../biblStruct[@type]
    -->
    <xsl:template match="misc-ref/thesis | book-ref/thesis">
        <note place="inline">
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    
    <!-- links[not(arxiv)] >> | note
        ex: <links><spires jnl="GRGVA" vol="33" page="1381">SPIRES</spires></links>
        ex: <aps jnl="PRL" vol="93" page="080601" start="volume" end="pages"/>
        
        TODO actuellement cette template n'est pas référencée
    -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/links[not(arxiv)]">
        <note place="inline">
            <xsl:for-each select="//@*">
                <xsl:value-of select="concat( ., ' ')"/>
            </xsl:for-each>
            <xsl:value-of select="."/>
         </note>
    </xsl:template>

    <!-- FIN REFERENCES *********************** -->



    <!-- FOOTNOTES ***********************
        IN: /article/back/footnotes  <<
        
        OUT: /TEI/text/back/
        >> note[@place="foot"]
        
        TODO templates pour les styles de présentation à l'intérieur
             (p, bold, etc.) au lieu de value-of et normalize-space()
    -->
    
    <!-- footnotes -->
    <xsl:template match="article/back/footnotes">
        <div type="footnotes">
            <xsl:apply-templates select='footnote'/>
        </div>
    </xsl:template>

    <!-- footnote -->
    <xsl:template match="footnote">
        <note place="foot">
            <!-- id -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:value-of select="normalize-space(.)"/>
        </note>
    </xsl:template>
    
    <!-- FIN FOOTNOTES *********************** -->
   
</xsl:stylesheet>
