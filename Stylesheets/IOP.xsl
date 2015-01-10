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
    <xsl:template match="/article[contains(article-metadata/article-data/copyright, 'IOP')]
                   | /article[contains(article-metadata/jnl-data/jnl-imprint, 'IOP')]
                   | /article[contains(article-metadata/jnl-data/jnl-imprint, 'Institute of Physics')]">
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
                    <editionStmt>
                        <edition>TEI version</edition>
                        <respStmt>
                            <resp>Conversion from IOP XML to TEI-conformant markup</resp>
                            <name>Pub2TEI XSLT</name>
                        </respStmt>
                    </editionStmt>
                    <publicationStmt>
                        <p>this TEI version for ISTEX database (CNRS)</p>
                    </publicationStmt>

                    <!-- métadonnées décrivant l'original -->
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
                                        <xsl:attribute name="from" select="article-metadata/article-data/first-page"/>
                                        <xsl:attribute name="to" select="article-metadata/article-data/last-page"/>
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
                
                <!-- métadonnées de profil (thématique et historique du doc) -->
                <profileDesc>
                    <!-- Reprise directe de toutes les classifications de l'article -->
                    <xsl:apply-templates select="header/classifications"/>
                    <!-- textClass ==> les classCode "pacs"
                                   ==> les subj. areas (propres à une série ?)
                                   ==> les kwds (si pas d'autre meilleur endroit)-->
                    
                    <!-- history => creation/date+ -->
                    <xsl:apply-templates select="header/history"/>
                    
                    <!-- Le résumé: abstract -->
                    <xsl:apply-templates select="header/abstract-group"/>
                    <!-- L'abstract doit-il figurer ici dans profileDesc  
                        ou bien plus bas dans <front> ?  -->
                    
                </profileDesc>
                
                <!-- TODO ici <encodingDesc> ? -->

            </teiHeader>
                <text>
                    <front/>
                    <body>
                        <xsl:apply-templates select="/article[contains(article-metadata/article-data/copyright, 'IOP')]/body"/>
                    </body>
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
        <xsl:comment>
            article-data/length (de valeur <xsl:value-of select="."/>) 
            pourrait donner un biblScope unit="pp" ?
        </xsl:comment>
        
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

    <!-- Cas normal
        IN:/article/header/author-group/ (le précédent)
           
    -->
    <xsl:template match="author-group/author">
        <author>
            <persName>
                <!-- ne préjuge pas de l'ordre -->
                <xsl:apply-templates select="./*[contains(name(),'-name')]"/>
            </persName>
        </author>
    </xsl:template>

    <!-- sous-éléments AUTEURS *************
        NB: utilisables pour le header et pour les refbibs du <back>
            ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        IN: << /article/header/author-group/author/*
            << /article/back/references/reference-list/*-ref/authors/au/*
    -->
    
    <!-- prénoms -->
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
            <resp/>
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
                                 et que et pas de namespaces
        
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
        
        TODO :
          - pour l'instant seulement intertitres et <p>
             - donc il reste les citations, l'italique, le mathml, etc.
          - éviter les redondances avec FullTextTags.xsl
    -->
    
    <xsl:template match="article/body">
            <xsl:apply-templates select="*[starts-with(local-name(),'seclevel')]"/>
            <xsl:apply-templates select="heading"/>
            <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <!-- SECLEVEL ***********************
        IN: /article/body/seclevel.*  <<
        
        OUT: text/body
        >> div1, div2...
        >> head
        >> p
    -->
    
    <xsl:template match="body//*[starts-with(local-name(),'seclevel')]">
        <!-- juste le nombre entier dans "seclevel1" ou "seclevel7" -->
        <xsl:variable name="level" select="substring(local-name(),8)"/>
        
        <xsl:element name="div{$level}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- heading => tous types de titres et entêtes
        ex: "" -->
    <xsl:template match="heading">
        <head>
            <xsl:value-of select="."/>
        </head>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    
    <!-- FIN ABS *********************** -->
    
    
    
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
        
        NB: Ces 7 templates forment une structure générale qui 
            appelle ensuite les sous-éléments ad hoc (plus bas)
        
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
            <xsl:apply-templates select="multipart | *[ends-with(local-name(),'-ref')]"/>
        </listBibl>
    </xsl:template> 
    
    <!-- multipart 
          (cas refbib gigogne)
          IN:  le précédent
          OUT: listBibl
     -->
    <xsl:template match="reference-list/multipart">
        <!-- k entrées de tag parmi {journal-ref | book-ref | conf-ref | misc-ref} -->
        <xsl:apply-templates select="multipart | *[ends-with(local-name(),'-ref')]"/>
    </xsl:template> 
    
    
    <!-- références structurées
        IN:  article/back/references/reference-list/ <<
             article/back/references/reference-list/multipart <<
        OUT: biblStruct +/*
    -->

    <!--journal-ref
        (refbib article de périodique)
    -->
    <xsl:template match="journal-ref">
        <biblStruct type="article">
            
            <!-- attributs courants -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:if test="@num">
                <xsl:attribute name="n" select="@num"/>
            </xsl:if>
            
            <!-- partie analytique (article) -->
            <analytic>
                <!-- utilisation pipe xpath => ne préjuge pas de l'ordre -->
                <xsl:apply-templates select="authors 
                                           | art-title 
                                           | art-number 
                                           | crossref/cr_doi"/>
            </analytic>
            
            <!-- partie monographique (périodique) -->
            <monogr>
                <xsl:apply-templates select="jnl-title 
                                           | conf-title
                                           | crossref/cr_issn"/>
                <!-- dont imprint -->
                <imprint>
                    <xsl:apply-templates select="year 
                                               | volume 
                                               | part
                                               | issno                                             
                                               | pages"/>
                </imprint>
            </monogr>  
        </biblStruct>     
    </xsl:template>
    
    <!--book-ref
        (refbib livre)
    -->
    <xsl:template match="book-ref">
        <biblStruct type="book">
            <!-- attributs courants -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:if test="@num">
                <xsl:attribute name="n" select="@num"/>
            </xsl:if>
            
        </biblStruct>     
    </xsl:template>
    
    <!--conf-ref
        (refbib actes et confs)
    -->
    <xsl:template match="conf-ref">
        <biblStruct type="conf">
            <!-- attributs courants -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:if test="@num">
                <xsl:attribute name="n" select="@num"/>
            </xsl:if>
            
        </biblStruct>
    </xsl:template>
    
    
    <!--misc-ref 
        (refbib brevet, logiciel, lien, ...)
    -->
    <xsl:template match="misc-ref">
        <biblStruct type="misc">
            <!-- attributs courants -->
            <xsl:attribute name="xml:id" select="@id"/>
            <xsl:if test="@num">
                <xsl:attribute name="n" select="@num"/>
            </xsl:if>
            
        </biblStruct>
    </xsl:template>


    <!-- SOUS-ELEMENTS BIBLIO (1/2: pour analytic) ********************
        
        IN: journal-ref | book-ref | conf-ref | misc-ref
        OUT: biblStruct
        >> analytic/author/*
        >> analytic/title[@level="a"]
        >> analytic/idno[@type="..."]
    -->
    
    <!-- authors -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/authors">
        <!-- comme pour author-group dans le header -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- authors/au
         (cas normal)
         Remarque : ce <au> est très semblable à <author> dans le header
    -->
    <xsl:template match="authors/au">
        <author>
            <persName>
                <!-- ne préjuge pas de l'ordre -->
                <xsl:apply-templates select="./*[contains(name(),'-name')]"/>
            </persName>
        </author>
    </xsl:template>
    
    <!-- (cas rares) authors/other 
                     authors/collaboration
                     authors/collaboration/group 
        Remarque : ce <au> est très semblable à <author> dans le header
    -->
    
    <!--authors/others
         Ex: "<other><italic>et al.</italic></other>"
    -->
    <xsl:template match="authors/others">
        <author ana="other-authors">
            <xsl:value-of select="normalize-space(.)"/>
        </author>
    </xsl:template>
    
    <!--authors/collaboration 
        "Collaborateur" non spécifique => respStmt
        Ex: "the ASDEX Upgrade Team"
        
        TODO : éventuellement author/orgName
               au lieu de respStmt/name ?
    -->
    <xsl:template match="authors/collaboration">
        <respStmt>
            <resp/>
            <name>
                <xsl:apply-templates/>
            </name>
        </respStmt>
    </xsl:template>
    
    <!--authors/collaboration/group
        (optionnel) le seul sous-élément autorisé de <collaboration>
     -->
    <xsl:template match="authors/collaboration/group">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- art-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/art-title">
        <title level="a">
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>    
    
    <!-- art-number -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/art-number">
        <idno>
            <xsl:attribute name="type" select="@type"/>
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>

    <!-- crossref/cr_doi -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/crossref/cr_doi">
        <idno type="doi">
            <xsl:value-of select="."/>
        </idno>
    </xsl:template>
    

    <!-- SOUS-ELEMENTS BIBLIO (2/2: pour monogr) ********************
        
        IN: journal-ref | book-ref | conf-ref | misc-ref
        OUT: biblStruct/monogr
        >> title[@level="j"]
        >> title[@level="m"]
        >> editor/*
        >> author/*
        
        >> imprint/biblScope[@unit="vol"]
        >> imprint/biblScope[@unit="part"]
        >> imprint/biblScope[@unit="pp"]
        >> imprint/biblScope[@unit="issue"]
    -->
    
    <!-- jnl-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/jnl-title">
        <title level="j">
            <xsl:value-of select="."/>
        </title>
    </xsl:template>
    
    <!-- conf-title -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/conf-title">
        <meeting>
            <xsl:value-of select="."/>
        </meeting>
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
    
    
    <!-- Dorénavant rentre dans >> TEI/.../biblStruct/monogr/imprint -->
    
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
    
    <!-- issno  -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/issue">
        <biblScope unit="part">
            <xsl:value-of select="."/>
        </biblScope>
    </xsl:template>
    
    <!-- pages  -->
    <xsl:template match="*[ends-with(local-name(),'-ref')]/pages">
        <biblScope unit="pp">
            <xsl:value-of select="."/>
        </biblScope>
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
