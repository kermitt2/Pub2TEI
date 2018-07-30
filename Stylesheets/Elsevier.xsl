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
            <xsl:when test="normalize-space($codeGenre1Elsevier)='mis'">
                    <xsl:choose>
                        <xsl:when test="//els1:head/ce:abstract | //els2:head/ce:abstract | //head/ce:abstract[string-length() &gt; 0]">article</xsl:when>
                        <xsl:otherwise>other</xsl:otherwise>
                    </xsl:choose>
            </xsl:when>
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
    <!-- Verbalisation titres series -->
    <xsl:variable name="codeTitle1">
        <xsl:value-of select="//els1:item-info/els1:jid |//els2:item-info/els2:jid | //item-info/jid"/>
    </xsl:variable>
    <xsl:variable name="codeTitle">
       <xsl:choose>
            <xsl:when test="normalize-space($codeTitle1)='AA'">Acta Astronautica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AADE'">Agricultural Administration and Extension</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AAETH'">Applied Animal Ethology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AAMJ'">Asia-Australia Marketing Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AANAT'">Annals of Anatomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AAP'">Accident Analysis and Prevention</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AB'">Addictive Behaviors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACA'">Analytica Chimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACALIB'">The Journal of Academic Librarianship</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACCAUD'">Journal of International Accounting, Auditing and Taxation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACCEDU'">Journal of Accounting Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACCINF'">International Journal of Accounting Information Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACCOUN'">International Journal of Accounting</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACJ'">ACC Current Journal Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACM'">Advanced Cement Based Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACMI'">Australian College of Midwives Incorporated Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACMMS'">Annales de Chirurgie de la Main et du Membre superieur</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACN'">Archives of Clinical Neuropsychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACPAIN'">Acute Pain</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACS'">Journal of the American College of Surgeons</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACTHIS'">Acta Histochemica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACTOEC'">Acta Oecologica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACTPSY'">Acta Psychologica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACTROP'">Acta Tropica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ACURO'">Actas Urologicas Espanolas</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AD'">Actas Dermo-Sifiliograficas</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADB'">Advances in Biophysics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADES'">Advances in Engineering Software</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADESW'">Advances in Engineering Software and Workstations</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADFRBM'">Advances in Free Radical Biology &amp; Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADIAC'">Advances in Accounting, incorporating Advances in International Accounting</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADPO'">Additives for Polymers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADR'">Advanced Drug Delivery Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADVENV'">Advances in Environmental Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADVES'">Advances in Engineering Software (1978)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ADWR'">Advances in Water Resources</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AEA'">Atmospheric Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AEC'">Advanced Energy Conversion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AEP'">Annals of Epidemiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AES'">Journal of African Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AESCTE'">Aerospace Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AESOLD'">Journal of African Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AEUE'">AEU - International Journal of Electronics and Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AG'">Applied Geochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGADM'">Agricultural Administration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGECON'">Agricultural Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGECOS'">Agro-Ecosystems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGEE'">Agriculture, Ecosystems and Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGG'">Archives of Gerontology and Geriatrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGISTU'">Journal of Aging Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGMET'">Agricultural and Forest Meteorology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGSY'">Agricultural Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGWAS'">Agricultural Wastes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGWAT'">Agricultural Water Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AGWE'">Agriculture and Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AICRP'">Annals of the ICRP/ICRP Publication</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIDD'">Analysis and Intervention In Developmental Disablities</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIN'">Antimicrobics &amp; Infectious Diseases Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIP'">The Arts in Psychotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIPI'">Annales de l'Institut Pasteur / Immunologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIPM'">Annales de l'Institut Pasteur / Microbiologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIPV'">Annales de l'Institut Pasteur / Virologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AIRDES'">Aircraft Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJC'">The American Journal of Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJH'">American Journal of Hypertension</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJHG'">The American Journal of Human Genetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJM'">The American Journal of Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJOPHT'">American Journal of Ophthalmology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJORTH'">American Journal of Orthodontics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJPA'">The American Journal of Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AJS'">The American Journal of Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ALC'">Alcohol</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ALCR'">Advances in Life Course Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ALLER'">Allergologia et Immunopathologia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AM'">Acta Materialia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMBSUR'">Ambulatory Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMC'">Applied Mathematics and Computation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMEEVA'">American Journal of Evaluation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMEPRE'">American Journal of Preventive Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMEPSY'">Annales medico-psychologiques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMET'">Agricultural Meteorology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMGAST'">The American Journal of Gastroenterology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMGP'">The American Journal of Geriatric Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMIT'">Accounting, Management and Information Technologies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMJ'">Australasian Marketing Journal (AMJ)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AML'">Applied Mathematics Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMM'">Acta Metallurgica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMMOLD'">Acta Metallurgica et Materialia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMBP'">Ambulatory Pediatrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMNL'">Antimicrobic Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMREP'">Advances in Molecular Relaxation Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AMRIP'">Advances in Molecular Relaxation and Interaction Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANAI'">Annals of Allergy, Asthma &amp; Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANBEHM'">Animal Behaviour Monographs</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANCAAN'">Annales de cardiologie et d'angeiologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNDUR'">Annales d'urologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANE'">Annals of Nuclear Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANGIO'">Angiologia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANIFEE'">Animal Feed Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANIHPB'">Annales de l'Institut Henri Poincare / Probabilites et statistiques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANIHPC'">Annales de l'Institut Henri Poincare / Analyse non lineaire</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANIREP'">Animal Reproduction Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANL'">Auris Nasus Larynx</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNCHI'">Annales de chirurgie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNCM'">Annales de Chirurgie de la Main</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNCSM'">Annales de chimie - Sciences des materiaux</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNFAR'">Annales Fran&#231;aises d'anesthesie et de reanimation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNGEN'">Annales de genetique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNOCC'">Annals of Occupational Hygiene</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNPAL'">Annales de paleontologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANNRMP'">Annales de readaptation et de medecine physique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANPEDI'">Anales de Pediatria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANSE'">Annals of Nuclear Science and Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANSENS'">Annales scientifiques de l'Ecole normale superieure</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANTAGE'">International Journal of Antimicrobial Agents</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANTHRO'">L'Anthropologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ANXDIS'">Journal of Anxiety Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AOB'">Archives of Oral Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AORN'">AORN Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AOS'">Accounting, Organizations and Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APAC'">Applied Acoustics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APAL'">Annals of Pure and Applied Logic</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APCATA'">Applied Catalysis A: General</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APCATB'">Applied Catalysis B: Environmental</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APEN'">Applied Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APM'">Applied Mathematical Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APNUM'">Applied Numerical Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APOR'">Applied Ocean Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPAP'">Archiv fur Protistenkunde : Protozoen, Algen, Pilze</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPBEH'">Applied Behavioral Science Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPDEV'">Journal of Applied Developmental Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPET'">Appetite</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPGEO'">Journal of Applied Geophysics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPLAN'">Applied Animal Behaviour Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPQUA'">International Journal of Applied Quality Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPSS'">Applications of Surface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APPSY'">Applied and Preventive Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APRIM'">Atencion Primaria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APSJ'">APS Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APSOIL'">Applied Soil Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APSUP'">Applied Superconductivity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APSUSC'">Applied Surface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APT'">Advanced Powder Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='APUNTS'">Apunts. Medicina de l'Esport</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQBOT'">Aquatic Botany</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQTOX'">Aquatic Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQUA'">Aquaculture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQUE'">Aquacultural Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQUECH'">Aquatic Ecosystem Health &amp; Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AQULIV'">Aquatic Living Resources</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARCMED'">Archives of Medical Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARCPED'">Archives de pediatrie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARFD'">Annual Review of Fish Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARI'">Applied Radiation and Isotopes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARIE'">Artificial Intelligence in Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARMR'">Applied Research In Mental Retardation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARTINT'">Artificial Intelligence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARTMED'">Artificial Intelligence In Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ARTPSY'">Art Psychotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AS'">Journal of Aerosol Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASD'">Arthropod Structure and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASIECO'">Journal of Asian Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASPEN'">Journal of Asia-Pacific Entomology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASTPHY'">Astroparticle Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASTQ'">Astronomy Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASTREV'">New Astronomy Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ASW'">Assessing Writing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATC'">Anesthesiology Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATE'">Applied Thermal Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATH'">Atherosclerosis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATHSUP'">Atherosclerosis (Supplements) (Component)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATMEA'">Atmospheric Environment. Part A: General Topics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATMEB'">Atmospheric Environment. Part B: Urban Atmosphere</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATMENV'">Atmospheric Environment (1967)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATMOS'">Atmospheric Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATP'">Journal of Atmospheric and Solar-Terrestrial Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATPO'">Journal of Atmospheric and Terrestrial Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATR'">Annals of Tourism Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ATS'">The Annals of Thoracic Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUCC'">Australian Critical Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUSEN'">Australian Emergency Nursing Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUT'">Automatica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUTO'">Automatica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUTCON'">Automation in Construction</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AUTNEU'">Autonomic Neuroscience: Basic and Clinical</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AVB'">Aggression and Violent Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AVR'">Antiviral Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='AVSG'">Annals of Vascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BAAE'">Basic and Applied Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACA'">Bailliere's Clinical Anaesthesiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACEM'">Bailliere's Clinical Endocrinology and Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACG'">Bailliere's Clinical Gastroenterology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACH'">Bailliere's Clinical Haematology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACOG'">Bailliere's Clinical Obstetrics and Gynaecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BACR'">Bailliere's Clinical Rheumatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BAE'">Building and Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BAMBED'">Biochemistry and Molecular Biology Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBA'">BBA - Biochimica et Biophysica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBABEN'">BBA Reviews On Bioenergetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBABIO'">BBA - Bioenergetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBABP'">BBA - Biophysics Including Photosynthesis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBABS'">BBA - Specialised Section On Biophysical Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBACAN'">BBA - Reviews on Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBADIS'">BBA - Molecular Basis of Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAEBO'">BBA - Enzymology &amp; Biological Oxidation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAEE'">BBA - Enzymology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAES'">BBA - Enzymological Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAEXP'">BBA - Gene Structure and Expression</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAGEN'">BBA - General Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBALIP'">Biochimica et Biophysica Acta (BBA) - Lipids and Lipid Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBALRS'">BBA - Specialised Section On Lipids and Related Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAMCB'">BBA - Molecular and Cell Biology of Lipids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAMCR'">BBA - Molecular Cell Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAMEM'">BBA - Biomembranes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAMUC'">BBA - Specialized Section on Mucoproteins and Mucopolysaccharides</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBANAP'">BBA Section Nucleic Acids And Protein Synthesis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBANAR'">BBA Specialized Section on Nucleic Acids and Related Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAPRO'">Biochimica et Biophysica Acta (BBA) - Protein Structure and Molecular Enzymology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAPST'">BBA - Protein Structure</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBAREV'">BBA - Reviews on Biomembranes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BBR'">Behavioural Brain Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BC'">International Journal of Biochemistry and Cell Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BCP'">Biochemical Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BE'">Biochemical Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BEHBIO'">Behavioral Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BEHNB'">Behavioral and Neural Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BEJ'">Biochemical Engineering Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BEPROC'">Behavioural Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BETH'">Behavior Therapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BICELL'">Biology of the Cell</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIO'">BioSystems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOC'">Biological Conservation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOCHE'">Biophysical Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOCHI'">Biochimie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOENG'">Biomolecular Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOINO'">Bioinorganic Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOJEC'">Bioelectrochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOM'">Biochemical medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOMAC'">International Journal of Biological Macromolecules</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOMS'">Biomass</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOOLD'">Bioelectrochemistry and Bioenergetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOPHA'">Biomedicine &amp; Pharmacotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOPSY'">Biological Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOS'">Biosensors and Bioelectronics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOSN'">Biosensors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOTEC'">Journal of Biotechnology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BIOWAS'">Biological Wastes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BITE'">Bioresource Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BJAB'">The British Journal of Animal Behaviour</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BJCHIR'">The British Journal of Chiropractic</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BJDC'">British Journal of Diseases of the Chest</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BJTDC'">British Journal of Tuberculosis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BJTUB'">British Journal of Tuberculosis and Diseases of the Chest</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BLAR'">Bulletin of Latin American Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BM'">Journal of Biomechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BMC'">Bioorganic &amp; Medicinal Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BMCL'">Bioorganic &amp; Medicinal Chemistry Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BON'">Bone</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BONMIN'">Bone and Mineral</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BONSOI'">Joint Bone Spine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BPAJ'">Beitrage zur Pathologie: "Aschoff's" Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BPJ'">Biophysical Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BPP'">Biochemie und Physiologie der Pflanzen</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BPS'">Biological Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRADEV'">Brain and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRB'">Brain Research Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRES'">Brain Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRESC'">Cognitive Brain Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRESD'">Developmental Brain Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRESM'">Molecular Brain Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRESP'">Brain Research Protocols</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRESR'">Brain Research Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRIHJ'">British Homoeopathic Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRIJOS'">British Journal of Oral Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRT'">Behaviour Research and Therapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BRY'">Biorheology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BSE'">Biochemical Systematics and Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BTEP'">Journal of Behavior Therapy and Experimental Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BTT'">Biometric Technology Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BUISCI'">Building Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BULSCI'">Bulletin des sciences mathematiques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BUSHOR'">Business Horizons</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='BVETJ'">British Veterinary Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAA'">Chinese Astronomy and Astrophysics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAC'">Computers and Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CACCN'">Confederation of Australian Critical Care Nurses journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CACE'">Computers and Chemical Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAE'">Computers &amp; Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAEE'">Computers and Electrical Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAF'">Computers and Fluids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAG'">Computers &amp; Graphics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAGEO'">Computers and Geosciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAIE'">Computers &amp; Industrial Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAIR'">Clinical and Applied Immunology Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CALPHA'">Calphad</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAM'">Journal of Computational and Applied Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAMWA'">Computers and Mathematics with Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAN'">Cancer Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CANRAD'">Cancer / Radiotherapie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAOR'">Computers and Operations Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAR'">Carbohydrate Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CARBON'">Carbon</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CARP'">Carbohydrate Polymers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CARRAD'">Cardiovascular Radiation Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAS'">Computers and Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CATCOM'">Catalysis Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CATENA'">Catena</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CATTOD'">Catalysis Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CAUP'">Computer Audit Update</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBA'">Comparative Biochemistry and Physiology, Part A: Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBAOLD'">Comparative Biochemistry and Physiology, Part A: Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBB'">Comparative Biochemistry and Physiology, Part B: Biochemistry and Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBBOLD'">Comparative Biochemistry and Physiology, Part B: Biochemistry and Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBCOLD'">Comparative Biochemistry and Physiology, Part C: Comparative Pharmacology and Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBI'">Chemico-Biological Interactions</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBINTR'">Cell Biology International Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBM'">Computers in Biology and Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBP'">Comparative Biochemistry And Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBPC'">Comparative Biochemistry and Physiology, Part C: Comparative Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CBPRA'">Cognitive and Behavioral Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCA'">Clinica Chimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCC'">Critical Care Clinics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCL'">Cardiology Clinics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCOMP'">Computer Compacts</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCR'">Coordination Chemistry Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CCT'">Controlled Clinical Trials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CECO'">Cement and Concrete Composites</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEJ'">Chemical Engineering Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEJBEJ'">The Chemical Engineering Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEJOLD'">The Chemical Engineering Journal and The Biochemical Engineering Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CELDD'">Cell Differentiation and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CELDIF'">Cell Differentiation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CELL'">Cell</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEMCON'">Cement and Concrete Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CENG'">Coastal Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEP'">Chemical Engineering &amp; Processing: Process Intensification</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CERI'">Ceramics International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CERINT'">Ceramurgia International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CES'">Chemical Engineering Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEUS'">Computers, Environment and Urban Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CEV'">Clinical Eye and Vision Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CFSB'">Computer Fraud &amp; Security</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CGC'">Cancer Genetics and Cytogenetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CGFR'">Cytokine and Growth Factor Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CGIG'">Chemical Geology: Isotope Geoscience Section</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CGM'">Clinics in Geriatric Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHAOS'">Chaos, Solitons and Fractals: the interdisciplinary journal of Nonlinear Science, and Nonequilibrium and Complex Phenomena</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHB'">Computers in Human Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHBIOL'">Chemistry &amp; Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEGLO'">Chemosphere - Global Change Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEHEA'">Chemical Health and Safety</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEM'">Chemosphere</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEMGE'">Chemical Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEMOM'">Chemometrics and Intelligent Laboratory Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHEMPH'">Chemical Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHENEU'">Journal of Chemical Neuroanatomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHERD'">Chemical Engineering Research and Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHIABU'">Child Abuse &amp; Neglect</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHIAST'">Chinese Astronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHIECO'">China Economic Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHIMAI'">Chirurgie de la main</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHQ'">Cornell Hotel and Restaurant Administration Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHROLD'">Journal of Chromatography B: Biomedical Sciences and Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHROMA'">Journal of Chromatography A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CHRREV'">Chromatographic Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIB'">Cospar Information Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CID'">Clinics in Dermatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIFST'">Canadian Institute of Food Science and Technology Journal / Journal de L'Institut Canadien de Science et Technologie Alimentaire</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIMID'">Comparative Immunology, Microbiology and Infectious Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIN'">Clinical Immunology Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIRP'">CIRP Annals - Manufacturing Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CIS'">Advances in Colloid and Interface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CJWB'">Columbia Journal of World Business</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CL'">Computer Languages</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLAE'">Contact Lens and Anterior Eye</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLAY'">Applied Clay Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLB'">Clinical Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLBC'">Clinical Breast Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLCO'">Clinical Cornerstone</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLD'">Clinics in Liver Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLINEM'">Clinics in Endocrinology and Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLINEU'">Clinical Neurology and Neurosurgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLINPH'">Clinical Neurophysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLIPOS'">Clinical Positron Imaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLITHE'">Clinical Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLLC'">Clinical Lung Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLMA'">Clinical Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLOLD'">Clinical Lymphoma</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLP'">Clinics in Perinatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLR'">ACOG Clinical Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLS'">Cellular Signalling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CLSR'">Computer Law &amp; Security Review: The International Journal of Technology Law and Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CMA'">Computer Methods in Applied Mechanics and Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CME'">Clinics in Chest Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CMIG'">Computerized Medical Imaging and Graphics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CMN'">Clinical Microbiology Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CMQ'">Canadian Metallurgical Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CNF'">Combustion and Flame</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CNSAJ'">CNSA Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CNSNS'">Communications in Nonlinear Science and Numerical Simulation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COBIOT'">Current Opinion in Biotechnology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COCEBI'">Current Opinion in Cell Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COCHBI'">Current Opinion in Chemical Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COCIS'">Current Opinion in Colloid &amp; Interface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COCOMP'">Computers and Composition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COEX'">Composites Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGDEV'">Cognitive Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGE'">Computers and Geotechnics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGEDE'">Current Opinion in Genetics &amp; Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGEL'">International Journal of Coal Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGEPH'">Comparative and General Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGNIT'">Cognition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGSCI'">Cognitive Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COGSYS'">Cognitive Systems Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COIMMU'">Current Opinion in Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COLEGN'">Collegian</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COLSUA'">Colloids and Surfaces A: Physicochemical and Engineering Aspects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COLSUB'">Colloids and Surfaces B: Biointerfaces</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COLTEC'">Cold Regions Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMAFF'">Communist Affairs</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMAID'">Computer Aided Geometric Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMBUS'">Composites Business Analyst</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMCHE'">Combinatorial Chemistry - an Online journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMCOM'">Computer Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMGEO'">Computational Geometry: Theory and Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMICR'">Current Opinion in Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMIND'">Computers in Industry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMM'">Computer Methods and Programs in Biomedicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMMAN'">Composites Manufacturing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMMAT'">Computational Materials Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMNET'">Computer Networks and ISDN Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMNWS'">Computer Networks (1976)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMPAG'">Computers and Electronics in Agriculture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMPHY'">Computer Physics Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMPNW'">Computer Networks</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMPOS'">Composites</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMRAD'">Computerized Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMSTA'">Computational Statistics and Data Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMSYS'">Computer Integrated Manufacturing Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COMTOM'">Computerized Tomography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CON'">Contraception</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CONEUR'">Current Opinion in Neurobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CONHYD'">Journal of Contaminant Hydrology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CONPRA'">Control Engineering Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CONREC'">Conservation &amp; Recycling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COPLBI'">Current Opinion in Plant Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COREL'">Journal of Controlled Release</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CORENS'">Corporate Environmental Strategy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CORFIN'">Journal of Corporate Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CORTEX'">Cortex</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COSE'">Computers &amp; Security</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COSSMS'">Current Opinion in Solid State &amp; Materials Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COST'">Composite Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COSTBI'">Current Opinion in Structural Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='COURSO'">Computers &amp; Urban Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPBM'">Computer Programs in Biomedicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPL'">Chemistry and Physics of Lipids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPLETT'">Chemical Physics Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPPED'">Current Problems in Pediatrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPR'">Clinical Psychology Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CPREP'">Computer Physics Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CRCS'">Carnegie-Rochester Conference Series on Public Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CRYENG'">Crystal Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CRYS'">Journal of Crystal Growth</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CS'">Corrosion Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSE'">Computing Systems in Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSI'">Computer Standards &amp; Interfaces</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSM'">Clinics in Sports Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSR'">Continental Shelf Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSTAN'">Computers and Standards</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CSTE'">Composites Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CTPS'">Computational and Theoretical Polymer Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CTR'">Cell Transplantation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CTT'">Card Technology Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CULHER'">Journal of Cultural Heritage</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CURBIO'">Current Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CURSUR'">Current Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CUTHRE'">Current Therapeutic Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CVP'">Cardiovascular Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='CYSR'">Children and Youth Services Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DAD'">Drug and Alcohol Dependence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DAE'">Domestic Animal Endocrinology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DAM'">Discrete Applied Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DAPRO'">Data Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DATAK'">Data &amp; Knowledge Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DCI'">Developmental and Comparative Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DECSUP'">Decision Support Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DENTAL'">Dental Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DERVEN'">Journal of the European Academy of Dermatology and Venereology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DES'">Desalination</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DESC'">Journal of Dermatological Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DET'">Dermatologic Clinics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DEVEC'">Journal of Development Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIAB'">Diabetes Research and Clinical Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIAMAT'">Diamond &amp; Related Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIAVIR'">Clinical and Diagnostic Virology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIFF'">Differentiation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIFGEO'">Differential Geometry and its Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DIRMAR'">Journal of Direct Marketing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DISC'">Discrete Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DISPLA'">Displays</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DMB'">Diagnostic Microbiology &amp; Infectious Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DN'">International Journal of Developmental Neuroscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DRUDIS'">Drug Discovery Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DRUPOL'">International Journal of Drug Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSRA'">Deep Sea Research Part A, Oceanographic Research Papers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSRB'">Deep-Sea Research Part B, Oceanographic Literature Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSRES'">Deep-Sea Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSRI'">Deep-Sea Research Part I</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSRII'">Deep-Sea Research Part II</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSROA'">Deep-Sea Research and Oceanographic Abstracts</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DSROLD'">Deep Sea Research (1953)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DYNAT'">Dynamics of Atmospheres and Oceans</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DYNCON'">Journal of Economic Dynamics and Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='DYPI'">Dyes and Pigments</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EA'">Electrochimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EAAI'">Engineering Applications of Artificial Intelligence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EABE'">Engineering Analysis with Boundary Elements</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EARCHI'">Early Childhood Research Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EARTH'">Earth-Science Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EATBEH'">Eating Behaviors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECHU'">Journal of Chiropractic Humanities</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECL'">Endocrinology and Metabolism Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECM'">Energy Conversion and Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECMARS'">Estuarine and Coastal Marine Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECMODE'">Economic Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOEDU'">Economics of Education Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOENG'">Ecological Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOFIN'">North American Journal of Economics and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOLEC'">Ecological Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOLET'">Economics Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECOMOD'">Ecological Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECONOM'">Journal of Econometrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ECPE'">Engineering Costs and Production Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EDEV'">International Journal of Educational Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EDUCOM'">Education and Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EEB'">Environmental and Experimental Botany</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EEG'">Electroencephalography and Clinical Neurophysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EEM'">Electroencephalography and Clinical Neurophysiology/ Electromyography and Motor Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EEP'">Electroencephalography and Clinical Neurophysiology/ Evoked Potentials Section</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EER'">European Economic Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EFA'">Engineering Failure Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EFM'">Engineering Fracture Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EGY'">Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EHD'">Early Human Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EI'">Environment International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EIR'">Environmental Impact Assessment Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EIVR'">Euro III-Vs Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJC'">European Journal of Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJCB'">European Journal of Cell Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJCCO'">European Journal of Cancer and Clinical Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJCOLD'">European Journal of Cancer (1965)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJCON'">European Journal of Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJINME'">European Journal of Internal Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJMECH'">European Journal of Medicinal Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJMFLU'">European Journal of Mechanics / B Fluids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJMSOL'">European Journal of Mechanics / A Solids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJOP'">European Journal of Protistology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJP'">European Journal of Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJPB'">European Journal of Pharmaceutics and Biopharmaceutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJPMOL'">European Journal of Pharmacology: Molecular Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJPTOX'">European Journal of Pharmacology: Environmental Toxicology and Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJSOBI'">European Journal of Soil Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EJUS'">European Journal of Ultrasound</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ELECOM'">Electrochemistry Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ELECST'">Electrodeposition and Surface Treatments</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ELECTR'">The Electricity Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ELSPEC'">Journal of Electron Spectroscopy and Related Phenomena</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ELSTAT'">Journal of Electrostatics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMC'">Emergency Medicine Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCAAR'">EMC - Anestesia-Reanimación</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCAOL'">EMC - Aparato Locomotor</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCCOC'">EMC - Cirugia otorrinolaringológica y cervicofacial</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCGIN'">EMC - Ginecologia-Obstetricia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCKMF'">EMC - Kinesiterapia - Medicina fisica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCPIA'">EMC - Pediatria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCTM'">Tratado de Medicina</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMCTQ'">EMC - Tecnicas quirurgicas - Aparato digestivo</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMEMAR'">Emerging Markets Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMJ'">European Management Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMPFIN'">Journal of Empirical Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMREV'">Electron Microscopy Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EMT'">Enzyme and Microbial Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENAGR'">Energy in Agriculture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENB'">Energy &amp; Buildings</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENCONV'">Energy Conversion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENDE'">Endeavour</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENDM'">Electronic Notes in Discrete Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENEECO'">Energy Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENEFIN'">Journal of Energy Finance and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENGAN'">Engineering Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENGEO'">Engineering Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENGMI'">Engineering Management International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENGTEC'">Journal of Engineering and Technology Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENPEC'">Engineering and Process Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENPO'">Environmental Pollution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENS'">Evolution and Human Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENSO'">Environmental Modelling and Software</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENSOLD'">Ethology and Sociobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENTCS'">Electronic Notes in Theoretical Computer Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENVIPO'">Environmental Pollution (1970)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENVIST'">Environmentalist</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENVPOL'">Environmental Policy and Law</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENVSCI'">Environmental Science and Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ENVTOX'">Environmental Toxicology and Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EOR'">European Journal of Operational Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPAEB'">Environmental Pollution. Series A, Ecological and Biological</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPBCP'">Environmental Pollution. Series B, Chemical and Physical</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPIRES'">Epilepsy Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPJ'">European Polymer Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPP'">Evaluation and Program Planning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPSL'">Earth and Planetary Science Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EPSR'">Electric Power Systems Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ERGON'">International Journal of Industrial Ergonomics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ESD'">Energy for Sustainable Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ESP'">English for Specific Purposes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ESPJ'">The ESP Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ESWA'">Expert Systems With Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ETF'">Experimental Thermal and Fluid Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ETHENV'">Ethics and the Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ETP'">Experimental and Toxicologic Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ETPGER'">Experimentelle Pathologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ETPOLD'">Experimental pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EUMINE'">Euromicro Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EURAGR'">European Journal of Agronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EURJVS'">European Journal of Vascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EURO'">European Journal of Obstetrics and Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EUROLD'">European Journal of Obstetrics &amp; Gynecology and Reproductive Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EURPSY'">European Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EURR'">European Journal of Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EVEDIP'">Evaluation in Education. International Progess</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EVEDU'">Evaluation in Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EVOPSY'">L'evolution psychiatrique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EVPR'">Evaluation Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EXG'">Experimental Gerontology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='EXPHEM'">Experimental Hematology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FARMAC'">Il Farmaco</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FAS'">Foot and Ankle Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FBP'">Food and Bioproducts Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FCT'">Food and Chemical Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FCTOX'">Food and Cosmetics Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FEBS'">FEBS Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FEMSEC'">FEMS Microbiology Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FEMSIM'">FEMS Immunology and Medical Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FEMSLE'">FEMS Microbiology Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FEMSRE'">FEMS Microbiology Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FERBIO'">Journal of Fermentation and Bioengineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FI'">Journal of the Franklin Institute</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FIBPRO'">Fibrinolysis &amp; Proteolysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FIBST'">Fibre Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FIELD'">Field Crops Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FIINAN'">Filtration Industry Analyst</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FINANA'">International Review of Financial Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FINEC'">Journal of Financial Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FINEL'">Finite Elements in Analysis &amp; Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FINMAR'">Journal of Financial Markets</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FINSER'">Financial Services Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FISE'">Filtration and Separation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FISH'">Fisheries Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FISJ'">Fire Safety Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FITOTE'">Fitoterapia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FLDMYC'">Field Mycology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FLUDYN'">Fluid Dynamics Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FLUID'">Fluid Phase Equilibria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FLUOR'">Journal of Fluorine Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FNS'">Fertility and Sterility</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FOCH'">Food Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FOLDES'">Folding and Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FOOAGR'">International Food and Agribusiness Management Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FOOD'">International Journal of Food Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FOOHYD'">Food Hydrocolloids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FORECO'">Forest Ecology and Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FORPOL'">Forest Policy and Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FORSCI'">Forensic Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FQAP'">Food Quality and Preference</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FRB'">Free Radical Biology and Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FRIN'">Food Research International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FSI'">Forensic Science International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FSS'">Fuzzy Sets and Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FUECEL'">Fuel Cells Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FUPROC'">Fuel Processing Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FUSION'">Fusion Engineering and Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='FUTURE'">Future Generation Computer Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GACETA'">Gaceta Sanitaria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GAIPOS'">Gait &amp; Posture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GASSEP'">Gas Separation and Purification</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GASSUR'">Journal of Gastrointestinal Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GAT'">Genetic Analysis: Biomolecular Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GCA'">Geochimica et Cosmochimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEANTE'">Gene Analysis Techniques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEGE'">Geotextiles and Geomembranes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GENE'">Gene</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOACT'">Geodinamica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOBIO'">Geobios</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOD'">Journal of Geodynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEODER'">Geoderma</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOEX'">Geoexploration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOF'">Geoforum</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOMOR'">Geomorphology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOPHY'">Journal of Geometry and Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEOT'">Geothermics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GEXPLO'">Journal of Geochemical Exploration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GHP'">General Hospital Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GLENVB'">Global Environmental Change B: Environmental Hazards</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GLOBAL'">Global and Planetary Change</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GLOFIN'">Global Finance Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GMB'">Gaceta Medica de Bilbao</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GOPURA'">Government Publications Review. Part A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GOPURB'">Government Publications Review. Part B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GOPURE'">Government Publications Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GOVINF'">Government Information Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GOVPR'">Government Publications Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GPH'">General Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GR'">Gondwana Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GTC'">Gastroenterology Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='GYOBFE'">Gynecologie Obstetrique &amp; Fertilite</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HAB'">Habitat International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HAND'">Hand</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HANTHE'">Journal of Hand Therapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HAZMAT'">Journal of Hazardous Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HCMF'">Healthcare Management Forum</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HE'">International Journal of Hydrogen Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEALUN'">Journal of Heart and Lung Transplantation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEAP'">Health policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEAPED'">Health Policy and Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEARES'">Hearing Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEI'">History of European Ideas</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEP'">Higher Education Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEPC'">Hepatology Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HEPOLD'">International Hepatology Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HFF'">International Journal of Heat and Fluid Flow</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HIGTEC'">Journal of High Technology Management Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HIM'">Human Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HIPERT'">Hipertension y riesgo vascular</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HISFAM'">The History of the Family</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HKJN'">Hong Kong Journal of Nephrology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HKPJ'">Hong Kong Physiotherapy Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HLC'">Heart, Lung and Circulation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HM'">International Journal of Hospitality Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HMT'">International Journal of Heat and Mass Transfer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HOC'">Hematology/Oncology Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HORTI'">Scientia Horticulturae</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HRS'">Heat Recovery Systems and CHP</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HUMOV'">Human Movement Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HUMRES'">Human Resource Management Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HYDROL'">Journal of Hydrology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='HYDROM'">Hydrometallurgy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IAC'">Immunology and Allergy Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IB'">Insect Biochemistry and Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IBR'">International Business Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ICA'">Inorganica Chimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ICAREV'">Inorganica Chimica Acta Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ICHMT'">International Communications in Heat and Mass Transfer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ICL'">International Contact Lens Clinic</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ICN'">Interventional Cardiology Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IDA'">Intelligent Data Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IDC'">Infectious Disease Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IE'">International Journal of Impact Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IEPOL'">Information Economics and Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IFCOM'">Interfaces in Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IIIREV'">III-Vs Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJA'">International Journal of Approximate Reasoning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJARA'">The International Journal Of Applied Radiation And Isotopes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJB'">International Journal of Medical Informatics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJBIO'">International Journal of Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJBOLD'">International Journal of Bio-Medical Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJCA'">International Journal of Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJCCLC'">International Journal of Cement Composites and Lightweight Concrete</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJES'">International Journal of Engineering Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJG'">International Journal of Gynecology and Obstetrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJHEH'">International Journal of Hygiene and Environmental Health</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJHTC'">International Journal of High Technology Ceramics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJID'">International Journal of Infectious Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJIR'">International Journal of Intercultural Relations</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJLP'">International Journal of Law and Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJMEA'">International Journal of Materials in Engineering Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJMF'">International Journal of Multiphase Flow</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJMM'">International Journal of Medical Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJNMB'">International Journal of Nuclear Medicine and Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJNP'">International Journal of Neuropharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJOS'">International Journal of Oral Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJP'">International Journal of Pharmaceutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRAIA'">International Journal of Radiation Applications &amp; Instrumentation. Part A, Applied Radiation &amp; Isotopes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRAIB'">International Journal of Radiation Applications &amp; Instrumentation. Part B, Nuclear Medicine and Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRAIC'">International Journal of Radiation Applications &amp; Instrumentation. Part C, Radiation Physics &amp; Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRAID'">International Journal of Radiation Applications &amp; Instrumentation. Part D, Nuclear Tracks &amp; Radiation Measurements</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRM'">International Journal of Research in Marketing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJRPC'">International Journal for Radiation Physics and Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJSDEE'">International Journal of Soil Dynamics and Earthquake Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJTMDR'">International Journal of Machine Tool Design and Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IJTOUM'">International Journal of Tourism Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ILIBR'">International Library Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMAGE'">Signal Processing: Image Communication</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMAVIS'">Image and Vision Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMBIO'">Immunobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMCHEM'">Immunochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IME'">International Journal of Insect Morphology and Embryology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMLET'">Immunology Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMM'">Industrial Marketing Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMMBIO'">Immuno-analyse et biologie specialisee</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMMP'">International Journal of Immunopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMMTEC'">Immunotechnology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMMUNI'">Immunity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMPHAR'">Immunopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IMTO'">Immunology Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INBI'">International Biodeterioration &amp; Biodegradation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INC'">Information Sciences - Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INCANU'">Intensive Care Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INCDIS'">Journal of Income Distribution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INCL'">Inorganic and Nuclear Chemistry Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDA'">International Dairy Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDAER'">Journal of Wind Engineering &amp; Industrial Aerodynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDAG'">Indagationes Mathematicae</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDCRO'">Industrial Crops &amp; Products</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDMET'">Industrial Metrology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INDOR'">International Journal of Industrial Organization</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INEC'">Journal of International Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFBEH'">Infant Behavior and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFDN'">Infectious Diseases Newsletter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFFUS'">Information Fusion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFMAN'">Information &amp; Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFPHY'">Infrared Physics and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFSOF'">Information and Software Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INFSR'">Information Storage and Retrieval</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INNFOO'">Innovative Food Science and Emerging Technologies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INOCHE'">Inorganic Chemistry Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INOMAT'">International Journal of Inorganic Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INS'">Information Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INSBIO'">Insect Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INSUMA'">Insurance Mathematics and Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTBD'">International Biodeterioration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTCOM'">Interacting with Computers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTELL'">Intelligence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTFIN'">Journal of International Financial Markets, Institutions &amp; Money</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTFOR'">International Journal of Forecasting</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTHIG'">The Internet and Higher Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTMAN'">Journal of International Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTMAR'">Journal of Interactive Marketing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTMED'">Integrative Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTPLA'">International Journal of Plasticity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='INTPSY'">International Journal of Psychophysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IP'">Journal of Insect Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IPL'">Information Processing Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IPM'">Information Processing and Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IPVP'">International Journal of Pressure Vessels and Piping</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IRL'">International Review of Law &amp; Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IRPHY'">Infrared Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='IS'">Information Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ISATRA'">ISA Transactions</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ISSEDU'">Issues in Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ISTR'">Information Security Technical Report</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ITOR'">International Transactions in Operational Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAAC'">Journal of the American Academy of Child &amp; Adolescent Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAAD'">International Journal of Adhesion and Adhesives</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAAGL'">American Association of Gynecologic Laparoscopists</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAAP'">Journal of Analytical and Applied Pyrolysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JABRT'">Advances in Behaviour Research and Therapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAC'">Journal of the American College of Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAD'">Journal of Affective Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAE'">Journal of Accounting and Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAER'">Advances in Enzyme Regulation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAES'">Journal of Asian Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAG'">International Journal of Applied Earth Observations and Geoinformation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAH'">Journal of Adolescent Health</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAHC'">Journal of Adolescent Health Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAICRP'">Annals of the ICRP</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JALCOM'">Journal of Alloys and Compounds</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JALL'">Journal of Allergy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAM'">Journal of the American Society for Mass Spectrometry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAMM'">Journal of Applied Mathematics and Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JANA'">Journal of the Association of Nurses in AIDS Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JANS'">Journal of the Autonomic Nervous System</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAPG'">Applied Geography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAPWOR'">Japan &amp; The World Economy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAR'">Journal of Atherosclerosis Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JARAP'">Annual Reviews in Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JAROLD'">Annual Review in Automatic Programming</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JASR'">Advances in Space Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JATM'">Journal of Air Transport Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBA'">Biotechnology Advances</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBB'">Biomass and Bioenergy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBBM'">Journal of Biochemical and Biophysical Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBCLA'">Journal of the British Contact Lens Association</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBEHEC'">The Journal of Behavioral Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBENG'">Journal of Biomedical Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBF'">Journal of Banking and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBIOSC'">Journal of Bioscience and Bioengineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBMT'">Biomaterials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBR'">Journal of Business Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBSTD'">Journal of Biological Standardization</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBUR'">Burns</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JBV'">Journal of Business Venturing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCA'">Journal of Clinical Anesthesia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCAD'">Computer-Aided Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCANE'">Journal of Cardiothoracic Anesthesia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCANNU'">Journal of Cancer Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCBM'">Construction and Building Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCD'">Journal of Communication Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCDIS'">Journal of Chronic Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCE'">Journal of Clinical Epidemiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCIT'">Cities</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCJ'">Journal of Criminal Justice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCLB'">Clinical Biomechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCLM'">Journal of The Less-Common Metals</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCLP'">Journal of Cleaner Production</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCOMA'">Composites Part A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCOMB'">Composites Part B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCOSCI'">Journal of Colloid Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCPS'">Journal of Consumer Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCRP'">Crop Protection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCRS'">Journal of Cataract &amp; Refractive Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCRY'">Cryogenics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCSR'">Journal of Constructional Steel Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCT'">Clinical Imaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCTOM'">Journal of Computed Tomography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCV'">Journal of Clinical Virology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCVS'">Cardiovascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JCYT'">Cytotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JDC'">Journal of Diabetes and Its Complications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JDIABC'">Journal of Diabetic Complications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JDST'">Design Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEA'">Journal of Electroanalytical Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEAC'">Journal of Electroanalytical Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEAS'">Journal of Experimental Animal Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEB'">Journal of Economics and Business</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEBO'">Journal of Economic Behavior and Organization</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEC'">Journal of Electroanalytical Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JECS'">Journal of the European Ceramic Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JELS'">Electoral Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEM'">Journal of Emergency Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEMBE'">Journal of Experimental Marine Biology and Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JENR'">Journal of Environmental Radioactivity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEP'">Journal of Ethnopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEPE'">International Journal of Electrical Power and Energy Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEPO'">Energy Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEPS'">European Journal of Purchasing and Supply Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JERG'">Applied Ergonomics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JEST'">Engineering Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFCO'">Food Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFD'">Journal of Fluency Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFEA'">Fuel and Energy Abstracts</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFMI'">Flow Measurement and Instrumentation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFOE'">Journal of Food Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFPO'">Food Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFRAD'">Journal of The Faculty of Radiologists</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFRBM'">Journal of Free Radicals in Biology &amp; Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFTEC'">Journal of Fermentation Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFTR'">Futures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JFUE'">Fuel</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JGEC'">Global Environmental Change</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JGI'">Journal of Government Information</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JGLR'">Journal of Great Lakes Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JHAP'">Health and Place</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JHE'">Journal of Health Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JHEPAT'">Journal of Hepatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JHRS'">Journal of Heat Recovery Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIB'">Journal of Inorganic Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIJER'">International Journal of Educational Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIJF'">International Journal of Fatigue</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIJR'">International Journal of Refrigeration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIM'">Journal of Immunological Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JIMF'">Journal of International Money and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JINC'">Journal of Inorganic and Nuclear Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JINJ'">Injury</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJBE'">Medical Engineering and Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJEK'">Journal of Electromyography and Kinesiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJIM'">International Journal of Information Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJO'">Japanese Journal of Ophthalmology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJOD'">Journal of Dentistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJPC'">Journal of Process Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JJRC'">Journal of Retailing and Consumer Services</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JKSUCI'">Journal of King Saud University - Computer and Information Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JLI'">Learning and Instruction</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JLP'">The Journal of Logic Programming</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JLPP'">Journal of Loss Prevention in the Process Industries</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JLUP'">Land Use Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMACRO'">Journal of Macroeconomics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMAD'">Materials and Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMAM'">Molecular Aspects of Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMCP'">Mayo Clinic Proceedings</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMDI'">The Journal of Molecular Diagnostics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMECH'">Journal of Mechanisms</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMG'">Journal of Molecular Graphics and Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMGOLD'">Journal of Molecular Graphics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMIC'">Micron</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMMA'">Museum Management and Curatorship</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMP'">Journal of Manufacturing Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMPG'">Marine and Petroleum Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMPO'">Marine Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMRES'">Journal of Magnetic Resonance (1969)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMSIP'">International Journal of Mass Spectrometry and Ion Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMSUR'">Journal of Maxillofacial Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMSY'">Journal of Manufacturing Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMWH'">Journal of Midwifery and Women's Health</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JMWT'">Journal of Mechanical Working Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNB'">The Journal of Nutritional Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNDT'">NDT and E International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNED'">Journal of Nutrition Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNI'">Journal of Neuroimmunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNM'">Journal of Nurse-Midwifery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNNFM'">Journal of Non-Newtonian Fluid Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNS'">Journal of the Neurological Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNUCEN'">Journal of Nuclear Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNUEN'">Journal of Nuclear Energy (1954)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JNUENA'">Journal of Nuclear Energy. Part A. Reactor Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOAES'">Journal of African Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOCCA'">Journal of Occupational Accidents</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOCD'">Journal of Clinical Densitometry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JODS'">Journal of Dairy Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOE'">Journal of Epilepsy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOEN'">Journal of Endodontics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOEP'">Journal of Economic Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOFSO'">Journal of the Forensic Science Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOLT'">Optics and Laser Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOM'">Journal of Organometallic Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JOPO'">Ophthalmic and Physiological Optics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JP'">Journal of Photochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPAA'">Journal of Pure and Applied Algebra</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPAS'">Progress in Aerospace Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPB'">Journal of Photochemistry &amp; Photobiology, B: Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPBM'">Progress in Biophysics and Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPC'">Journal of Photochemistry &amp; Photobiology, A: Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPCGCM'">Progress in Crystal Growth and Characterization of Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPCOLD'">Physics and Chemistry of the Earth</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPECS'">Progress in Energy and Combustion Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPGQ'">Political Geography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPLPH'">Journal of Plant Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPLR'">Progress in Lipid Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPM'">Journal of Pharmacological and Toxicological Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPMA'">International Journal of Project Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPMET'">Journal of Pharmacological Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPMS'">Progress in Materials Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPN'">Advances in Neuroimmunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPNE'">Progress in Nuclear Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPNMRS'">Progress in Nuclear Magnetic Resonance Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPO'">Journal of Policy Modeling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPOL'">Polymer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPP'">Journal of Accounting and Public Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPPNP'">Progress in Particle and Nuclear Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPPS'">Progress in Polymer Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPQE'">Progress in Quantum Electronics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPR'">Journal of Photochemistry &amp; Photobiology, C: Photochemistry Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPRR'">Progress in Retinal and Eye Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPS'">Journal of Pain and Symptom Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPSSC'">Progress in Solid State Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JPT'">Pharmacology and Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JQI'">Quaternary International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JQSR'">Quaternary Science Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JQSRT'">Journal of Quantitative Spectroscopy and Radiative Transfer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JRGFR'">Progress in Growth Factor Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JRI'">Journal of Reproductive Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JRPO'">Resources Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSAMS'">Journal of Science and Medicine in Sport</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSAREV'">JSAE Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSEE'">Studies in Educational Evaluation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSMS'">Supramolecular Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSOCBS'">Journal of Social and Biological Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSP'">Journal of School Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSPA'">Space Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSPI'">Journal of Statistical Planning and Inference</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSR'">Journal of Safety Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSS'">The Journal of Systems &amp; Software</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSSC'">Communist and Post-Communist Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JSTEB'">Journal of Steroid Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTEMB'">Journal of Trace Elements in Medicine and Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTMA'">Tourism Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTPO'">Telecommunications Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTRG'">Journal of Transport Geography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTRI'">Tribology International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JTRP'">Transport Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JUIP'">Utilities Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JULTR'">Journal of Ultrastructure Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JURMSR'">Journal of Ultrastructure Research and Molecular Structure Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JURO'">The Journal of Urology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVA'">Vistas in Astronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVAC'">Vaccine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVAD'">Journal of Vascular Access Devices</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVAL'">Value in Health</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVC'">Journal of Veterinary Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JVIR'">Journal of Vascular and Interventional Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JWM'">Journal of Wilderness Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='JWST'">Water Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='KNOSYS'">Knowledge-Based Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LAA'">Linear Algebra and Its Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LABECO'">Labour Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LABINF'">Laboratory Automation and Information Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LAC'">Language and Communication</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LANCET'">The Lancet</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LAND'">Landscape and Urban Planning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LANONC'">Lancet Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LANPLA'">Landscape Planning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LAPT'">Library Acquisitions: Practice and Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LEAIND'">Learning and Individual Differences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LEAQUA'">The Leadership Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LEGMED'">Legal Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LEHEMT'">Letters in Heat and Mass Transfer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LFS'">Life Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LIBCOL'">Library Collections, Acquisitions and Technical Services</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LIBINF'">Library and Information Science Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LIMNO'">Limnologica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LINEDU'">Linguistics and Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LINGUA'">Lingua</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LIPMED'">Journal of Lipid Mediators and Cell Signalling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LITHOS'">Lithos</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LIVEST'">Livestock Production Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LOCS'">Location Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LR'">Leukemia Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LRP'">Long Range Planning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LSC'">Language Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LUMIN'">Journal of Luminescence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='LUNG'">Lung Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAC'">Materials Chemistry and Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAD'">Mechanisms of Ageing and Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAGMA'">Journal of Magnetism and Magnetic Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAGMBI'">Magnetic Resonance Materials in Physics, Biology &amp; Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAMT'">Mechanism and Machine Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MANAGE'">Journal of Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MARCHE'">Marine Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MARGO'">Marine Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MARMIC'">Marine Micropaleontology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MARMOD'">Marine Models</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MARSYS'">Journal of Marine Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MASPEC'">International Journal of Mass Spectrometry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAST'">Marine Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MAT'">Maturitas</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATBEH'">Journal of Mathematical Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATBIO'">Matrix Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATCHE'">Materials Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATCOM'">Mathematics and Computers in Simulation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATECO'">Journal of Mathematical Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATPUR'">Journal de mathematiques pures et appliquees</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATSCI'">Materials Science in Semiconductor Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATSOC'">Mathematical Social Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATSR'">Materials Science Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MATTOD'">Materials Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MBDRR'">Metabolic Bone Disease and Related Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MBS'">Mathematical Biosciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MCE'">Molecular and Cellular Endocrinology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MCM'">Mathematical and Computer Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MDC'">Medical Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MDO'">Medical Dosimetry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEASUR'">Measurement</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MECH'">Mechatronics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MECIND'">Mecanique &amp; Industrie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MECMAT'">Mechanics of Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MED'">Medicine - Programa de Formación Medica Continuada acreditado</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDCLI'">Medicina Clinica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDDRO'">Medecine &amp; Droit</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDIEV'">Journal of Medieval History</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDIMA'">Medical Image Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDIN'">Medicina intensiva</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEDMAL'">Medecine et Maladies Infectieuses</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEE'">Microelectronic Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEJ'">Microelectronics Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEMB'">Membrane Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MEMSCI'">Journal of Membrane Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MENCOM'">Mendeleev Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MERE'">Marine Environmental Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MESC'">Meat Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MET'">Metal Finishing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='META'">Intermetallics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='METALG'">Metallography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICINF'">Microbes and Infection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICMAT'">Microporous and Mesoporous Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICPRO'">Microprocessors and Microsystems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICRES'">Microbiological Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICROC'">Microchemical Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICROM'">Microporous Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICRON'">Micron (1969)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MICS'">Microprocessors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MIMA'">Micron And Microscopica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MIMET'">Journal of Microbiological Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MIMI'">Microprocessing and Microprogramming</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MIMM'">Molecular Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MINE'">Minerals Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MINPRO'">International Journal of Mineral Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MINST'">Mining Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MLAOLD'">Laser-Medizin : eine interdisziplinare Zeitschrift ; Praxis, Klinik, Forschung</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MLBLUE'">Materials Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOD'">Mechanisms of Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLBIO'">Molecular &amp; Biochemical Parasitology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLCAA'">Journal of Molecular Catalysis A: Chemical</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLCAB'">Journal of Molecular Catalysis B: Enzymatic</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLCEL'">Molecular Cell</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLLIQ'">Journal of Molecular Liquids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLSTR'">Journal of Molecular Structure</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MOLTOD'">Molecular Medicine Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MONEC'">Journal of Monetary Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MPB'">Marine Pollution Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MPRP'">Metal Powder Report</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MPS'">Journal of the Mechanics and Physics of Solids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MR'">Microelectronics Reliability</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MRB'">Materials Research Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MRC'">Mechanics Research Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MRI'">Magnetic Resonance Imaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MS'">International Journal of Mechanical Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MSA'">Materials Science &amp; Engineering A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MSB'">Materials Science &amp; Engineering B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MSC'">Materials Science &amp; Engineering C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MSENG'">Materials Science and Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MSR'">Materials Science &amp; Engineering R</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MTL'">Materials Characterization</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MTM'">International Journal of Machine Tools and Manufacture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MULFIN'">Journal of Multinational Financial Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUP'">Medical Update for Psychiatrists</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUSMAN'">Museum Management and Curatorship</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUT'">Mutation Research - Fundamental and Molecular Mechanisms of Mutagenesis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTAGI'">Mutation Research DNAging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTDNA'">Mutation Research-DNA Repair</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTDRR'">Mutation Research DNA Repair Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTENV'">Mutation Research/Environmental Mutagenesis and Related Subjects</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTGEN'">Mutation Research - Genetic Toxicology and Environmental Mutagenesis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTGEX'">Mutation Research/Genetic Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTLET'">Mutation Research Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTNOM'">Mutation Research - Mutation Research Genomics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTREV'">Mutation Research-Reviews in Mutation Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MUTREX'">Mutation Research/Reviews in Genetic Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MYC'">Mycoscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MYCOBU'">Bulletin of the British Mycological Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MYCOL'">Mycologist</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MYCRES'">Mycological Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='MYRETR'">Transactions of the British Mycological Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NA'">Nonlinear Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NAMREF'">North American Review of Economics and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NATSCI'">Nature Sciences Societe</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NBA'">Neurobiology of Aging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NBR'">Neuroscience and Biobehavioral Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NCI'">Neurochemistry International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NCL'">Neurologic Clinics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NCMW'">Nuclear and Chemical Waste Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NDTEST'">Non-Destructive Testing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NDTI'">NDT International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEASPA'">New Astronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NED'">Nuclear Engineering and Design</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEDF'">Nuclear Engineering and Design. Fusion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEL'">Journal of Neurolinguistics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NESE'">Network Security</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEUCIR'">Neurocirugia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEUCLI'">Neurophysiologie Clinique / Clinical Neurophysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEUCOM'">Neurocomputing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEUPSY'">European Neuropsychopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NEURON'">Neuron</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NIMA'">Nuclear Inst. and Methods in Physics Research, A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NIMB'">Nuclear Inst. and Methods in Physics Research, B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NIMPP'">Nuclear Instruments and Methods In Physics Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NIP'">New Ideas in Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NJAS'">NJAS - Wageningen Journal of Life Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NJM'">Netherlands Journal of Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NJSR'">Netherlands Journal of Sea Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NLM'">International Journal of Non-Linear Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NM'">Nanostructured Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NMB'">Nuclear Medicine and Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NMD'">Neuromuscular Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NN'">Neural Networks</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NOC'">Journal of Non-Crystalline Solids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NONRWA'">Nonlinear Analysis: Real World Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NP'">Neuropharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NPS'">Neuropsychopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NS'">International Journal of Nursing Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSC'">Neuroscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSL'">Neuroscience Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSM'">Journal of Neuroscience Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSR'">Neuroscience Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSRSUP'">Neuroscience Research Supplements</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NSY'">Neuropsychologia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NTARM'">Nuclear Tracks and Radiation Measurements (1982)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NTD'">Nuclear Track Detection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NTR'">Nutrition Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NTRMIT'">Nuclear Tracks And Radiation Measurements (1993)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NTT'">Neurotoxicology and Teratology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUCINS'">Nuclear Instruments</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUCTRA'">Nuclear Tracks</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUIM'">Nuclear Instruments and Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUMA'">Journal of Nuclear Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUPHA'">Nuclear Physics, Section A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUPHB'">Nuclear Physics, Section B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUPHBP'">Nuclear Physics B (Proceedings Supplements)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUPHYS'">Nuclear Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUSTEN'">Nuclear Structural Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUT'">Nutrition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='NUTCLI'">Nutrition clinique et metabolisme</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OBHP'">Organizational Behavior and Human Performance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCEACT'">Oceanologica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCEMAN'">Ocean Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCEMOD'">Ocean Modelling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCESM'">Ocean and Shoreline Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCL'">Orthopedic Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCMA'">Ocean and Coastal Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OCPOL'">Oil and Chemical Pollution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OE'">Ocean Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OG'">Organic Geochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OGC'">Obstetrics and Gynecology Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OLEN'">Optics and Lasers in Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OME'">Omega</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ONCH'">Critical Reviews in Oncology / Hematology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ONG'">Obstetrics &amp; Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OO'">Oral Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPEMAN'">Journal of Operations Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPERES'">Operations Research Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPETP'">Oil and Petrochemical Pollution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPHTHA'">Ophthalmology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPPATH'">Opportunistic Pathogens</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPTICS'">Optics Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPTMAT'">Optical Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OPTTEC'">Optics Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ORAONC'">European Journal of Cancer. Part B: Oral Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ORBIS'">Orbis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OREGEO'">Ore Geology Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ORGDYN'">Organizational Dynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ORGELE'">Organic Electronics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OSOMOP'">Oral Surgery, Oral Medicine, Oral Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OTC'">Otolaryngologic Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='OTCTS'">Operative Techniques in Cardiac &amp; Thoracic Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PACFIN'">Pacific-Basin Finance Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PAID'">Personality and Individual Differences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PAIFOR'">Pain Forum</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PAIN'">Pain</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PALAEO'">Palaeogeography, Palaeoclimatology, Palaeoecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PALBO'">Review of Palaeobotany and Palynology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PARA'">International Journal for Parasitology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PARCO'">Parallel Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PARINT'">Parasitology International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PARTOD'">Parasitology Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PATCOU'">Patient Counselling and Health Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PATPHY'">Pathophysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PATREC'">Pattern Recognition Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PBA'">Journal of Pharmaceutical and Biomedical Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PBB'">Pharmacology, Biochemistry and Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCFOL'">Progress in the Chemistry of Fats and Other Lipids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCGC'">Progress In Crystal Growth And Characterization</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCL'">The Pediatric Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCS'">Journal of Physics and Chemistry of Solids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCU'">Primary Care Update for Ob/Gyns</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PCUSSR'">Petroleum Chemistry: U.S.S.R</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PDST'">Polymer Degradation and Stability</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEC'">Patient Education and Counseling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEDADO'">Journal of Pediatric and Adolescent Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEDOBI'">Pedobiologia - International Journal of Soil Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEDOT'">International Journal of Pediatric Otorhinolaryngology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEDPUE'">Journal de pediatrie et de puericulture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEP'">Peptides</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEPI'">Physics of the Earth and Planetary Interiors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PETROL'">Journal of Petroleum Science and Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PEVA'">Performance Evaluation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PGEOLA'">Proceedings of the Geologists' Association</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PGNE'">Polymer Gels and Networks</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PGQ'">Political Geography Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHAHEL'">Pharmaceutica Acta Helvetiae</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHASCI'">European Journal of Pharmaceutical Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHB'">Physiology &amp; Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHCHEA'">Physics and Chemistry of the Earth, Part A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHCHEB'">Physics and Chemistry of the Earth, Part B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHCHEC'">Physics and Chemistry of the Earth, Part C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHOGRA'">Photogrammetria</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHOTO'">ISPRS Journal of Photogrammetry and Remote Sensing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHRECO'">Pharmacological Research Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHSCTE'">Pharmaceutical Science &amp; Technology Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYLET'">Physics Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYMED'">Phytomedicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSA'">Physica A: Statistical Mechanics and its Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSB'">Physica B: Physics of Condensed Matter</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSBC'">Physica B+C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSC'">Physica C: Superconductivity and its applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSD'">Physica D: Nonlinear Phenomena</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSE'">Physica E: Low-dimensional Systems and Nanostructures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSIC'">Physica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYSIO'">Journal of Physiology - Paris</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYST'">Physiotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PHYTO'">Phytochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PIA'">Pump Industry Analyst</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PIAT'">Journal of Psychiatric Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PIM'">The Journal of Product Innovation Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PJOR'">Philips Journal of Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PLA'">Physics Letters A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PLAADD'">Plastics, Additives and Compounding</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PLAPHY'">Plant Physiology and Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PLB'">Physics Letters B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PLREP'">Physics Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PMPH'">Progress in Metal Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PNEC'">Psychoneuroendocrinology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PNEUPS'">Progress in Neuro-Psychopharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PNP'">Progress in Neuropsychopharmacology &amp; Biological Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PNU'">Pediatric Neurology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POC'">Progress in Organic Coatings</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POCO'">Polymer Contents</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POETIC'">Poetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POLECO'">European Journal of Political Economy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POLPHO'">Polymer Photochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POLSCU'">Polymer Science U.S.S.R.</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POLY'">Polyhedron</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POP'">Primary Care: Clinics in Office Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POSTEC'">Postharvest Biology and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POTE'">Polymer Testing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='POWER'">Journal of Power Sources</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PPC'">Progress in Pediatric Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PPEES'">Perspectives in Plant Ecology, Evolution and Systematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PPPATH'">Physiological Plant Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PR'">Pattern Recognition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRAGMA'">Journal of Pragmatics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRBI'">Process Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRD'">Parkinsonism and Related Disorders</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRE'">Precision Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRECAM'">Precambrian Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PREHOS'">Prehospital Emergency Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PREM'">Probabilistic Engineering Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRETR'">Progress in water%</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PREVET'">Preventive Veterinary Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRO'">Prostaglandins and Other Lipid Mediators</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROCI'">Proceedings of the Combustion Institute</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROECO'">International Journal of Production Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROGHI'">Progress in Histochemistry and Cytochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROLM'">Prostaglandins, Leukotrienes and Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROMED'">Prostaglandines and Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRONEU'">Progress in Neurobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROOCE'">Progress in Oceanography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROOLD'">Prostaglandins</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROPLA'">Progress in Planning</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROTEC'">Journal of Materials Processing Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PROTIS'">Protist</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PRP'">Pathology - Research and Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PS'">Progress in Surface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSC'">Psychiatric Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSEP'">Process Safety and Environmental Protection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSL'">Plant Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSLETT'">Plant Science Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSR'">Journal of Psychosomatic Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSS'">Planetary and Space Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSY'">Psychiatry Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSYM'">Psychosomatics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSYN'">Psychiatry Research: Neuroimaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PSYSPO'">Psychology of Sport &amp; Exercise</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PTBGSP'">Pharmacology and Therapeutics: Part B: General And Systematic Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PTCCPT'">Pharmacology and Therapeutics: Part C: Clinical Pharmacology and Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PTCTMI'">Pharmacology and Therapeutics, Part A: Chemotherapy, Toxicology and Metabolic Inhibitors</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PTEC'">Powder Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PTTT'">Plasma Therapy and Transfusion Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PUBEC'">Journal of Public Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PUBMAN'">International Public Management Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PUBREL'">Public Relations Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PUHE'">Public Health</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAB'">L'Annee Biologique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAC'">Annales de l'Institut Pasteur/Actualites</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAE'">Air &amp; Space Europe</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAP'">L'Antropologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAU'">Annales d'urologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXAZ'">Annales des Sciences Naturelles Zoologie et Biologie Animale</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXBF'">Biofutur</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCA'">Cryptogamie Algologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCB'">Cryptogamie Bryologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCC'">Cryptogamie Mycologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCF'">Revue Generale des Chemins de Fer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCOLD'">Chirurgie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXCG'">Annales de chirurgie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXDI'">Annales de cardiologie et d'angeiologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXGE'">Annales de genetique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXHOLD'">Comptes Rendus de l'Academie des Sciences Series IV Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXMOLD'">Comptes Rendus de l'Academie des Sciences Series I Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXMS'">Annales medico-psychologiques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXOLDC'">Comptes Rendus de l'Academie des Sciences Series IIC Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXOLDP'">Comptes Rendus de l'Academie des Sciences Series IIB Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXPL'">Plasmas &amp; Ions</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXPOLD'">Comptes Rendus de l'Academie des Sciences Series IIB Mechanics Physics Astronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXROLD'">Reanimation Urgences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXSM'">Bulletin des sciences mathematiques</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXTOLD'">Comptes Rendus de l'Academie des Sciences Series IIA Earth and Planetary Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXUR'">Medecine de Catastrophe</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='PXVOLD'">Comptes Rendus de l'Academie des Sciences Series III Sciences de la Vie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='QUAECO'">Quarterly Review of Economics and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='QUAMAN'">Journal of Quality Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RACSOC'">Race and Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RADBOT'">Radiation Botany</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RADION'">Radiotherapy and Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RADPC'">Radiation Physics and Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RBMNEW'">ITBM-RBM News</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RBMO'">Reproductive BioMedicine Online</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RBMRET'">ITBM RBM : Innovation et technologie en biologie et medecine, une revue de technologie biomedicale = Innovation and technology in biology and medicine.</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RBTCS'">Robotics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RCE'">Revista clinica espanola</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RCL'">Radiologic Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RCM'">Robotics and Computer Integrated Manufacturing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RDC'">Rheumatic Disease Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REACT'">Reactive and Functional Polymers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REACTI'">Reactive Polymers</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REASOL'">Reactivity of Solids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RECESP'">Revista Española de Cardiologia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RECTRA'">Recherche Transports Securite</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RECYCL'">Resources, Conservation &amp; Recycling</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REGEC'">Regional Science and Urban Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REGPEP'">Regulatory Peptides</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REGUE'">Regional and Urban Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RELENG'">Reliability Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REMN'">Revista Espanola de Medicina Nuclear</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RENC'">Revue d'electroencephalographie et de Neurophysiologie Clinique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RENE'">Renewable Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REPL'">Reinforced Plastics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESAEN'">Resources and Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESCIT'">Journal of Nuclear Energy. Parts A/B. Reactor Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESCON'">Resources and Conservation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESEN'">Resource and Energy Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESMIC'">Research in Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESP'">Respiration Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESPOL'">Research Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESREC'">Resource Recovery and Conservation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESS'">Reliability Engineering and System Safety</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESSTR'">Research Strategies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RESUS'">Resuscitation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RETAIL'">Journal of Retailing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RETREC'">Research in Transportation Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVALL'">Revue Fran&#231;aise d'Allergologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVCLI'">Revue fran&#231;aise d'allergologie et d'immunologie clinique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVECO'">International Review of Economics and Finance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVFAL'">Revue Fran&#231;aise d'Allergie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVFIN'">Review of Financial Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVFRA'">Revue Fran&#231;aise des Laboratoires</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVMED'">La Revue de medecine interne</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVMIC'">Revue de micropaleontologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVMOL'">Reviews in Molecular Biotechnology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVRAD'">Review of Radical Political Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVRHU'">Revue du rhumatisme</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVTHB'">Revue Fran&#231;aise de Transfusion et d'Hemobiologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVTIM'">Revue Fran&#231;aise de Transfusion et Immuno-hematologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='REVTRA'">Revue Fran&#231;aise de Transfusion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RHM'">Reproductive Health Matters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RIDD'">Research in Developmental Disabilities</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RIOB'">Research in Organizational Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RLFA'">Revista de Logopedia, Foniatria y Audiologia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RM'">Radiation Measurements</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RMHM'">International Journal of Refractory Metals and Hard Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RMMS'">International Journal of Rock Mechanics and Mining Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RMMSZZ'">International Journal of Rock Mechanics and Mining Sciences and Geomechanics Abstracts</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RMP'">Reports on Mathematical Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ROB'">International Journal of Radiation Oncology, Biology, Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ROBOT'">Robotics and Autonomous Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RPC'">Radiation Physics and Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RPIES'">Reactive Polymers, Ion Exchangers, Sorbents</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RPON'">Reports of Practical Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RPOR'">Reports of Practical Oncology &amp; Radiotherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RSE'">Remote Sensing of Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RSER'">Renewable and Sustainable Energy Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RTX'">Reproductive Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RUMIN'">Small Ruminant Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RUSLIT'">Russian Literature</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='RUST'">Journal of Rural Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAA'">Spectrochimica Acta Part A: Molecular and Biomolecular Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAAOLD'">Spectrochimica Acta Part A: Molecular Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAB'">Spectrochimica Acta Part B: Atomic Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAFETY'">Safety Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAMES'">Journal of South American Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAS'">International Journal of Solids and Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SAT'">Journal of Substance Abuse Treatment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SBB'">Soil Biology and Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SBMB'">Journal of Steroid Biochemistry and Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCAMAN'">Scandinavian Journal of Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCFEP'">Symposium on Combustion and Flame, and Explosion Phenomena</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCHRES'">Schizophrenia Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCICO'">Science of Computer Programming</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCIJUS'">Science &amp; Justice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCISPO'">Science &amp; Sports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCITEC'">Science and Technology of Advanced Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCJMAS'">Scandinavian Journal of Management Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCL'">Systems &amp; Control Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCRE'">Screening</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCRMET'">Scripta Metallurgica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SCT'">Surface &amp; Coatings Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SDEE'">Soil Dynamics and Earthquake Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SE'">Solar Energy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEAESO'">Journal of Southeast Asian Earth Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEARES'">Journal of Sea Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEATEC'">Sealing Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SECLAN'">Journal of Second Language Writing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEDGEO'">Sedimentary Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEMAT'">Solar Energy Materials</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEMERG'">SEMERGEN - Medicina de Familia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEP'">Separations Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEPPUR'">Separation and Purification Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SEPS'">Socio-Economic Planning Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SERIMM'">Serodiagnosis and Immunotherapy in Infectious Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SERREV'">Serials Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SG'">Journal of Structural Geology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SHPMP'">Studies in History and Philosophy of Modern Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SHPS'">Studies in History and Philosophy of Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SHPSC'">Studies in History and Philosophy of Biol &amp; Biomed Sci</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SICOM'">Symposium (International) on Combustion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SIGPRO'">Signal Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SIMPRA'">Simulation Practice and Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SISS'">Social Science Information Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SLEEP'">Sleep Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SM'">Scripta Metallurgica et Materiala</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SMABUL'">Smart Materials Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SMM'">Scripta Materialia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SMR'">Sport Management Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SN'">Sensors and Actuators</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SNA'">Sensors &amp; Actuators: A. Physical</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SNB'">Sensors &amp; Actuators: B. Chemical</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SO'">Surgical Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOCECO'">Journal of Socio-Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOCEVO'">Journal of Social and Evolutionary Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOCSCI'">The Social Science Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOCTRA'">Sociologie du travail</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOILTE'">Soil Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOLCEL'">Solar Cells</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOLMAT'">Solar Energy Materials and Solar Cells</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SON'">Social Networks</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOP'">Survey of Ophthalmology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOSCME'">Social Science and Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SOSI'">Solid State Ionics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SPA'">Stochastic Processes and their Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SPEACT'">Spectrochimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SPECOM'">Speech Communication</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SPR'">Journal of Stored Products Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SS'">European Journal of Solid State and Inorganic Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSC'">Solid State Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSE'">Solid State Electronics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSM'">Social Science &amp; Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSMA'">Social Science and Medicine. Part A Medical Psychology and Medical Sociology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSMB'">Social Science and Medicine. Part B Medical Anthropology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSMC'">Social Science and Medicine. Part C Medical Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSMD'">Social Science and Medicine. Part D Medical Geography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSME'">Social Science and Medicine. Part E Medical Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSMF'">Social Science and Medicine. Part F Medical and Social Ethics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSSCIE'">Solid State Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SSTB'">Spill Science and Technology Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STAPRO'">Statistics and Probability Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STE'">Steroids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STFODE'">Structure</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STILL'">Soil &amp; Tillage Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STOTEN'">Science of the Total Environment</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STRECO'">Structural Change and Economic Dynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STRINF'">Journal of Strategic Information Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STRUCS'">Structural Safety</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='STUCCO'">Studies in Comparative Communism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUBABU'">Journal of Substance Abuse</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUC'">Surgical Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUN'">Surgical Neurology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUPFLU'">The Journal of Supercritical Fluids</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SURTEC'">Surface Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUSC'">Surface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUSCL'">Surface Science Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SUSREP'">Surface Science Reports</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SWT'">Solar and Wind Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SYAPM'">Systematic and Applied Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SYNMET'">Synthetic Metals</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SYS'">System</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='SYSARC'">Journal of Systems Architecture</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TAFMEC'">Theoretical and Applied Fracture Mechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TAL'">Talanta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TATE'">Teaching and Teacher Education</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TB'">Journal of Thermal Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TCA'">Thermochimica Acta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TCM'">Trends in Cardiovascular Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TCS'">Theoretical Computer Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TECH'">Technovation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TECHFO'">Technological Forecasting</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TECTIP'">Technical Tips Online</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TECTO'">Tectonophysics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TELE'">Telematics and Informatics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TEM'">Trends in Endocrinology &amp; Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TER'">Journal of Terramechanics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TET'">Tetrahedron</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TETASY'">Tetrahedron: Asymmetry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TETCOM'">Tetrahedron Computer Methodology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TETL'">Tetrahedron Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TFS'">Technological Forecasting &amp; Social Change</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='THBIO'">Theory in Biosciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='THE'">Theriogenology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='THEKNE'">The Knee</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='THEOCH'">Journal of Molecular Structure: THEOCHEM</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='THESCI'">International Journal of Thermal Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIBS'">Trends in Biochemical Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIBTEC'">Trends in Biotechnology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TICB'">Trends in Cell Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TICS'">Trends in Cognitive Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIFS'">Trends in Food Science &amp; Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIGS'">Trends in Genetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIMI'">Trends in Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TINS'">Trends in Neurosciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIPS'">Trends in Pharmacological Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIS'">Technology in Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TIV'">Toxicology in Vitro</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TOP'">Topology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TOPOL'">Topology and its Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TOX'">Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TOXCON'">Toxicon</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TOXLET'">Toxicology Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TPS'">Transplantation Proceedings</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TR'">Thrombosis Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRA'">Transportation Research Part A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRAC'">Trends in Analytical Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRACLI'">Transfusion clinique et biologique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRAG'">Transportation Research Part A: General</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRANSF'">Transfusion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRARES'">Transportation Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRB'">Transportation Research Part B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRC'">Transportation Research Part C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRD'">Transportation Research Part D</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRE'">Transportation Research Part E</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TREE'">Trends in Ecology &amp; Evolution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRF'">Transportation Research Part F: Psychology and Behaviour</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRIB'">Tribology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRIM'">Transplant Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRPLSC'">Trends in Plant Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRSTMH'">Transactions of the Royal Society of Tropical Medicine and Hygiene</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TRUN'">Trait d'Union</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TS'">Transfusion Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TSF'">Thin Solid Films</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TUB'">Tubercle</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TUST'">Tunnelling and Underground Space Technology incorporating Trenchless Technology Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='TWST'">Thin-Walled Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='UCL'">Urologic Clinics of North America</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ULTRAM'">Ultramicroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ULTRAS'">Ultrasonics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ULTSON'">Ultrasonics - Sonochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='UMB'">Ultrasound in Medicine &amp; Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='URBECO'">Urban Ecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='URBSYS'">Urban Systems</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='URBWAT'">Urban Water</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='URL'">Urology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='URO'">Urologic Oncology: Seminars and Original Investigations</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='USSRCM'">USSR Computational Mathematics and Mathematical Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VAC'">Vacuum</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VACUN'">Vacunas: investigación y práctica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VETIMM'">Veterinary Immunology and Immunopathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VETMIC'">Veterinary Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VETPAR'">Veterinary Parasitology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VIBSPE'">Vibrational Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VIRMET'">Journal of Virological Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VIRUS'">Virus Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VLSI'">Integration, the VLSI Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VOLGEO'">Journal of Volcanology and Geothermal Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='VR'">Vision Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WAMOT'">Wave Motion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WAPOL'">Water Policy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WD'">World Development</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WEA'">Wear</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WEM'">Wilderness &amp; Environmental Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WHI'">Women's Health Issues</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WM'">Waste Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WOPU'">World Pumps</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WORBUS'">Journal of World Business</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WPI'">World Patent Information</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WR'">Water Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WSIF'">Women's Studies International Forum</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='WSIQ'">Women's Studies International Quarterly</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X135'">Research in Virology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X153'">Bulletin du Cancer/Radiotherapie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X157'">RBM-Revue Europeenne de Technologie Biomedicale</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X230'">Revue Generale de Thermique</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X244'">Journal of Molecular Catalysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X258'">Comptes Rendus de l'Academie des Sciences Series IIB Mechanics Physics Chemistry Astronomy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X280'">International Journal of Mass Spectrometry and Ion Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X283'">Environmental Software</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X308'">Computer Fraud and Security Bulletin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X309'">Applied Catalysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X310'">Colloids and Surfaces</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X74'">Bulletin de l'Institut Pasteur</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X83'">Research in Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='X85'">Urgences Medicales</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='XACRA'">Academic Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAAEN'">Accident &amp; Emergency Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAAJCS'">The AustralAsian Journal of Cardiac and Thoracic Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAAMA'">Advances in Applied Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YABBI'">Archives of Biochemistry and Biophysics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YABIO'">Analytical Biochemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YACHA'">Applied and Computational Harmonic Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YADND'">Atomic Data and Nuclear Data Tables</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YADPA'">Annals of Diagnostic Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAEMED'">AeroMedical Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAIMA'">Advances in Mathematics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAJCD'">American Journal of Contact Dermatitis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAJEM'">American Journal of Emergency Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAJKD'">American Journal of Kidney Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAJOG'">American Journal of Obstetrics and Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAJOT'">American Journal of Otolaryngology-Head and Neck Medicine and Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YANAE'">Anaerobe</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YANBE'">Animal Behaviour</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YANBO'">Annals of Botany</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPHJ'">The Asia Pacific Heart Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPHY'">Annals of Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPMR'">Archives of Physical Medicine and Rehabilitation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPNR'">Applied Nursing Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPNU'">Archives of Psychiatric Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YAPTCS'">The Asia Pacific Journal of Thoracic and Cardiovascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YARTH'">The Journal of Arthroplasty</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YASLE'">Atmospheric Science Letters</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBARE'">The British Accounting Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBBMT'">Biology of Blood and Marrow Transplantation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBBRC'">Biochemical and Biophysical Research Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBCMD'">Blood Cells, Molecules and Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBCON'">Biological Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBEAN'">Best Practice &amp; Research Clinical Anaesthesiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBEEM'">Best Practice &amp; Research Clinical Endocrinology &amp; Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBEGA'">Best Practice &amp; Research Clinical Gastroenterology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBEHA'">Best Practice &amp; Research Clinical Haematology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBEOG'">Best Practice &amp; Research Clinical Obstetrics &amp; Gynaecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBERH'">Best Practice &amp; Research Clinical Rheumatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBIJL'">Biological Journal of the Linnean Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBIOL'">Biologicals</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBIOO'">Bioorganic Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBJOM'">British Journal of Oral &amp; Maxillofacial Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBJPS'">British Journal of Plastic Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBLRE'">Blood Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBMMB'">Biochemical Medicine and Metabolic Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBMME'">Biochemical and Molecular Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBOJL'">Botanical Journal of the Linnean Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBRBI'">Brain Behavior and Immunity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBRCG'">Brain and Cognition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBRLN'">Brain and Language</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBRST'">The Breast</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YBULM'">Bulletin of Mathematical Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCACC'">Current Anaesthesia &amp; Critical Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCAOM'">Clinical Acupuncture &amp; Oriental Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCBIR'">Cell Biology International</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCBMR'">Computers and Biomedical Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCCOG'">Consciousness and Cognition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCDIP'">Current Diagnostic Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCECA'">Cell Calcium</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCEIN'">Clinical Effectiveness in Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCEPS'">Contemporary Educational Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCGIP'">CVGIP: Graphical Models and Image Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCGRIP'">Computer Graphics and Image Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCHEC'">Coronary Health Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCIMM'">Cellular Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCIUN'">CVGIP: Image Understanding</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCLAD'">Cladistics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCLIM'">Clinical Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCLIN'">Clinical Immunology and Immunopathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCLNU'">Clinical Nutrition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCLON'">Clinical Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCOGP'">Cognitive Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCOMP'">Comprehensive Psychiatry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCPAC'">Critical Perspectives on Accounting</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCPEM'">Clinical Pediatric Emergency Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCRAD'">Clinical Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCRES'">Cretaceous Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCRYO'">Cryobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCSLA'">Computer Speech &amp; Language</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCTIM'">Complementary Therapies in Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCTNM'">Complementary Therapies in Nursing and Midwifery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCTRV'">Cancer Treatment Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCUOE'">Current Paediatrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCUOG'">Current Obstetrics &amp; Gynaecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCUOR'">Current Orthopaedics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCVIGP'">Computer Vision, Graphics and Image Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCVIU'">Computer Vision and Image Understanding</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YCYTO'">Cytokine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YDBIO'">Developmental Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YDLD'">Digestive and Liver Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YDREV'">Developmental Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YDRUP'">Drug Resistance Updates</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YDSPR'">Digital Signal Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEBCM'">Evidence-based Cardiovascular Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEBEH'">Epilepsy &amp; Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEBHC'">Evidence-based Healthcare</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEBOG'">Evidence-based Obstetrics &amp; Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEBON'">Evidence-based Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YECSS'">Estuarine, Coastal and Shelf Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEESA'">Ecotoxicology and Environmental Safety</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEJON'">European Journal of Oncology Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEJPN'">European Journal of Paediatric Neurology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEJSO'">European Journal of Surgical Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEJVS'">European Journal of Vascular &amp; Endovascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEMYC'">Experimental Mycology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YENFO'">Environmental Forensics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YENRS'">Environmental Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEUJC'">European Journal of Combinatorics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEUJP'">European Journal of Pain</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXCR'">Experimental Cell Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXEH'">Explorations in Economic History</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXER'">Experimental Eye Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXMP'">Experimental and Molecular Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXNR'">Experimental Neurology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YEXPR'">Experimental Parasitology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFAAT'">Fundamental and Applied Toxicology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFFTA'">Finite Fields and Their Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFGBI'">Fungal Genetics and Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFIPR'">Fibrinolysis and Proteolysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFMIC'">Food Microbiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFOOT'">The Foot</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFRNE'">Frontiers in Neuroendocrinology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFSIM'">Fish and Shellfish Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YFSTL'">LWT - Food Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGAME'">Games and Economic Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGAST'">Gastroenterology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGCEN'">General and Comparative Endocrinology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGENO'">Genomics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGHIR'">Growth Hormone &amp; IGF Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGMIP'">Graphical Models and Image Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGMOD'">Graphical Models</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YGYNO'">Gynecologic Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YHBEH'">Hormones and Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YHCPR'">Home Care Provider</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YHMAT'">Historia Mathematica</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YHOAV'">Hospital Aviation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YHUPA'">Human Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YICAR'">Icarus</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YICCN'">Intensive &amp; Critical Care Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YICSE'">IMPACT of Computing in Science and Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIILR'">International Information and Library Review</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJAR'">The International Journal of Aromatherapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJHC'">International Journal of Human - Computer Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJNA'">The International Journal of Nautical Archaeology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJOA'">International Journal of Obstetric Anesthesia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJODC'">International Journal of Orthodontia and Dentistry for Children</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJOM'">International Journal of Oral &amp; Maxillofacial Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJOOS'">International Journal of Orthodontia and Oral Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJORS'">International Journal of Orthodontia and Oral Surgery (1919)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJORT'">International Journal of Orthodontia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJOSR'">International Journal of Orthodontia, Oral Surgery and Radiography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJSL'">International Journal of the Sociology of Law</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIJTN'">International Journal of Trauma Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIMMS'">International Journal of Man-Machine Studies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YIMMU'">ImmunoMethods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YINCO'">Information and Computation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YINSI'">Insight - the Journal of the American Society of Ophthalmic Registered Nurses</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJAAR'">Journal of Anthropological Archaeology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJABR'">Journal of Algebra</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJACEP'">Journal of the American College of Emergency Physicians</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJADA'">Journal of the American Dietetic Association</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJADO'">Journal of Adolescence</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJAER'">Journal of Agricultural Engineering Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJAGM'">Journal of Algorithms</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJAMT'">Journal of Air Medical Transport</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJARE'">Journal of Arid Environments</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJARS'">Arthroscopy: The Journal of Arthroscopic and Related Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJASC'">Journal of Archaeological Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJATH'">Journal of Approximation Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJAUT'">Journal of Autoimmunity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJBMT'">Journal of Bodywork &amp; Movement Therapies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCAF'">Journal of Cardiac Failure</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCAN'">Journal of Cardiothoracic and Vascular Anesthesia</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCAT'">Journal of Catalysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCEC'">Journal of Comparative Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCFM'">Journal of Clinical Forensic Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCHT'">The Journal of Chemical Thermodynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCIS'">Journal of Colloid And Interface Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCMS'">Journal of Cranio-Maxillo-Facial Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCOM'">Journal of Complexity</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCPA'">Journal of Comparative Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCPH'">Journal of Computational Physics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCPT'">Journal of Comparative Pathology and Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCRC'">Journal of Critical Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCRS'">Journal of Cereal Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCSS'">Journal of Computer and System Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCTA'">Journal of Combinatorial Theory, Series A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJCTB'">Journal of Combinatorial Theory, Series B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJDEQ'">Journal of Differential Equations</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJECP'">Journal of Experimental Child Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJEEM'">Journal of Environmental Economics and Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJELC'">Journal of Electrocardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJEMA'">Journal of Environmental Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJESP'">Journal of Experimental Social Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJETH'">Journal of Economic Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJEVP'">Journal of Environmental Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJEVS'">Journal of Equine Veterinary Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFAN'">Journal of Functional Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFAS'">The Journal of Foot and Ankle Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFCA'">Journal of Food Composition and Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFIN'">Journal of Financial Intermediation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFLS'">Journal of Fluids and Structures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJFMS'">Journal of Feline Medicine and Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHEC'">Journal of Housing Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHEP'">Hepatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHEV'">Journal of Human Evolution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHGE'">Journal of Historical Geography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHIN'">Journal of Hospital Infection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHSB'">Journal of Hand Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJHSU'">Journal of Hand Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJINF'">Journal of Infection</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJIPA'">Journal of Invertebrate Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJJIE'">Journal of The Japanese and International Economies</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJLTS'">Liver Transplantation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMAA'">Journal of Mathematical Analysis and Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMBI'">Journal of Molecular Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMCA'">Journal of Microcomputer Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMCC'">Journal of Molecular and Cellular Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMLA'">Journal of Memory and Language</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMPS'">Journal of Mathematical Psychology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMRA'">Journal of Magnetic Resonance, Series A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMRB'">Journal of Magnetic Resonance, Series B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMRE'">Journal of Magnetic Resonance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMSP'">Journal of Molecular Spectroscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJMVA'">Journal of Multivariate Analysis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJNCA'">Journal of Network and Computer Applications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJNTH'">Journal of Number Theory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJOCA'">Osteoarthritis and Cartilage</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJOCN'">Journal of Clinical Neuroscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJOMS'">Journal of Oral and Maxillofacial Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJOON'">Journal of Orthopaedic Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJOOS'">American Journal of Orthodontics and Oral Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPAI'">Journal of Pain</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPAN'">Journal of PeriAnesthesia Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPDC'">Journal of Parallel and Distributed Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPDN'">Journal of Pediatric Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPHO'">Journal of Phonetics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPMN'">Pain Management Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPNU'">Journal of Professional Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPON'">Journal of Pediatric Oncology Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJPSU'">Journal of Pediatric Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJREN'">Journal of Renal Nutrition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJRPE'">Journal of Research in Personality</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSBI'">Journal of Structural Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSCD'">Journal of Stroke and Cerebrovascular Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSCO'">Journal of Symbolic Computation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSRE'">Journal of Surgical Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSSC'">Journal of Solid State Chemistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJSVI'">Journal of Sound and Vibration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJTBI'">Journal of Theoretical Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJUEC'">Journal of Urban Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJVBE'">Journal of Vocational Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJVCI'">Journal of Visual Communication and Image Representation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJVLC'">Journal of Visual Languages and Computing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YJXRA'">Journal of X-Ray Science and Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YKNAC'">Knowledge Acquisition</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YLICH'">The Lichenologist</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YLMOT'">Learning and Motivation</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMAI'">The Journal of Allergy and Clinical Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMAJ'">Aesthetic Surgery Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMAM'">Air Medical Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMARE'">Management Accounting Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMAS'">Asthma Magazine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMATH'">Manual Therapy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMBEN'">Metabolic Engineering</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCBR'">Molecular Cell Biology Research Communications</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCD'">Current Problems in Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCM'">The Case Manager</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCN'">Current Problems in Cancer</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCNE'">Molecular and Cellular Neuroscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMCPR'">Molecular and Cellular Probes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMDA'">Disease-a-Month</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMDM'">Current Problems in Dermatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMDR'">Current Problems in Diagnostic Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMEHY'">Medical Hypotheses</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMEM'">Annals of Emergency Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMEN'">Journal of Emergency Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMETA'">Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMETH'">Methods</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMGE'">Gastrointestinal Endoscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMGME'">Molecular Genetics and Metabolism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMGN'">Geriatric Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMHJ'">American Heart Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMHL'">Heart &amp; Lung - The Journal of Acute and Critical Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMHN'">Otolaryngology - Head and Neck Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMIC'">AJIC: American Journal of Infection Control</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMIDW'">Midwifery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMJD'">Journal of the American Academy of Dermatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMJE'">Journal of the American Society of Echocardiography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMJW'">Journal of WOCN: Wound, Ostomy and Continence Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMLC'">The Journal of Laboratory and Clinical Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMMT'">Journal of Manipulative and Physiological Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMNC'">Journal of Nuclear Cardiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMNO'">Nursing Outlook</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMOB'">American Journal of Obstetrics and Gynecology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMOD'">American Journal of Orthodontics &amp; Dentofacial Orthopedics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMODI'">Molecular Diagnosis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMOE'">Oral Surgery, Oral Medicine, Oral Pathology, Oral Radiology and Endodontology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPA'">Journal of AAPOS</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPAT'">Microbial Pathogenesis</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPD'">The Journal of Pediatrics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPEV'">Molecular Phylogenetics and Evolution</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPH'">Journal of Pediatric Health Care</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPN'">Journal of the American Psychiatric Nurses Association</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMPR'">The Journal of Prosthetic Dentistry</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMSE'">Journal of Shoulder and Elbow Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMSG'">Current Problems in Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMSSP'">Mechanical Systems and Signal Processing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMSY'">Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMTC'">The Journal of Thoracic and Cardiovascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMVA'">Journal of Vascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMVJ'">Journal of Voice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMVN'">Journal of Vascular Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YMVRE'">Microvascular Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNBDI'">Neurobiology of Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNCMN'">Neuroprotocols</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNDSH'">Nuclear Data Sheets</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNDSHA'">Nuclear Data Sheets Section A</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNDSHB'">Nuclear Data Sheets Section B</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNEDT'">Nurse Education Today</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNEUR'">Neurodegeneration</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNIMG'">NeuroImage</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNIOX'">Nitric Oxide</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNLME'">Neurobiology of Learning and Memory</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YNPEP'">Neuropeptides</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOBHD'">Organizational Behavior and Human Decision Processes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOFTE'">Optical Fiber Technology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTCT'">Operative Techniques in Thoracic and Cardiovascular Surgery: A Comparative Atlas</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTGN'">Operative Techniques in General Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTNS'">Operative Techniques in Neurosurgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTOR'">Operative Techniques in Orthopaedics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTOT'">Operative Techniques in Otolaryngology - Head and Neck Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTPR'">Operative Techniques in Plastic and Reconstructive Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YOTSM'">Operative Techniques in Sports Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPAOR'">Pathology and Oncology Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPCAD'">Progress in Cardiovascular Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPEST'">Pesticide Biochemistry and Physiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPHRS'">Pharmacological Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPLAC'">Placenta</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPLAS'">Plasmid</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPLEF'">Prostaglandins, Leukotrienes and Essential Fatty Acids (PLEFA)</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPMED'">Preventive Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPMPP'">Physiological and Molecular Plant Pathology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPREP'">Protein Expression and Purification</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPRRV'">Paediatric Respiratory Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPTSP'">Physical Therapy in Sport</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPULP'">Pulmonary Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YPUPT'">Pulmonary Pharmacology &amp; Therapeutics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YQRES'">Quaternary Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRADI'">Radiography</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRAPM'">Regional Anesthesia and Pain Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRECO'">Ricerche Economiche</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YREDY'">Review of Economic Dynamics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YREEC'">Research in Economics</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRELI'">Religion</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRMED'">Respiratory Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRTIM'">Real-Time Imaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRTPH'">Regulatory Toxicology and Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YRVSC'">Research in Veterinary Science</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSAEP'">Seminars in Avian and Exotic Pet Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSANE'">Seminars in Anesthesia, Perioperative Medicine and Pain</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSARH'">Seminars in Arthritis and Rheumatism</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSCBI'">Seminars in Cancer Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSCDB'">Seminars in Cell and Developmental Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSCEL'">Seminars in Cell Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSEDB'">Seminars in Developmental Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSEIZ'">Seizure: European Journal of Epilepsy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSHEM'">Seminars in Hematology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSINY'">Seminars in Neonatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSMIM'">Seminars in Immunology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSMNS'">Seminars in Neuroscience</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSMRV'">Sleep Medicine Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSMVY'">Seminars in Virology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSNMR'">Solid State Nuclear Magnetic Resonance</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSNUC'">Seminars in Nuclear Medicine</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSODO'">Seminars in Orthodontics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YSONC'">Seminars in Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSONU'">Seminars in Oncology Nursing</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSPEN'">Seminars in Pediatric Neurology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSPER'">Seminars in Perinatology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSPID'">Seminars in Pediatric Infectious Diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSPMI'">Superlattices and Microstructures</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSRAO'">Seminars in Radiation Oncology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSROE'">Seminars in Roentgenology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSSRE'">Social Science Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSTCS'">Seminars in Thoracic and Cardiovascular Surgery</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSULT'">Seminars in Ultrasound, CT, and MRI</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YSVMS'">Clinical Techniques in Small Animal Practice</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTAAP'">Toxicology and Applied Pharmacology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTGIE'">Techniques in Gastrointestinal Endoscopy</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTICE'">Tissue and Cell</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTMRV'">Transfusion Medicine Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTOXS'">Toxicological Sciences</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTPBI'">Theoretical Population Biology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTRAP'">Techniques in Regional Anesthesia and Pain Management</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTRRE'">Transplantation Reviews</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTULD'">Tubercle and Lung Disease</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTVIR'">Techniques in Vascular and Interventional Radiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YTVJL'">The Veterinary Journal</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YUIMG'">Ultrasonic Imaging</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YVIRO'">Virology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YVLVB'">Journal of Verbal Learning and Verbal Behavior</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YWMRE'">Waste Management &amp; Research</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='YZJLS'">Zoological Journal of the Linnean Society</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBC'">Zentralblatt fur Bakteriologie, Reihe C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBHC'">Zentralblatt fur Bakteriologie und Hygiene , Reihe C</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBMHA'">Zentralblatt fur Bakteriologie, Mikrobiologie und Hygiene / A: Medical Microbiology, Infectious Diseases, Virology, Parasitology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBMM'">Zentralblatt fur Bakteriologie : medical microbiology, virology, parasitology, infectious diseases</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBMOLD'">Zentralblatt fur Bakteriologie, Mikrobiologie und Hygiene / A: Medizinische Mikrobiologie, Infektionskrankheiten und Parasitologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBPIHA'">Zentralblatt fuer Bakteriologie, Parasitenkunde, Infektionskrankheiten und Hygiene. Zweite Naturwissenschaftliche Abteilung: Allgemeine, Landwirtschaftliche und Technische Mikrobiologie</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZBPIHM'">Zentralblatt fuer Bakteriologie, Parasitenkunde, Infektionskrankheiten und Hygiene. Zweite Naturwissenschaftliche Abteilung: Mikrobiologie der Landwirtschaft, der Technologie und des Umweltschutzes</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZEO'">Zeolites</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZFPP'">Zeitschrift fur Pflanzenphysiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZHU'">Zentralblatt fur Hygiene und Umweltmedizin</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZII'">Zeitschrift fur Immunitatsforschung: Immunobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZIIOLD'">Zeitschrift fur Immunitatsforschung: Immunobiology</xsl:when>
            <xsl:when test="normalize-space($codeTitle1)='ZMLTU'">Zentralblatt fur Mikrobiologie : Landwirtschaft, Technologie, Umweltschutz</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ANNPLA'">Annales de chirurgie plastique esthetique</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ARBRES'">Archivos de Bronconeumologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ARTERI'">Cl&#237;nica e Investigacion en Arteriosclerosis</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ASOC'">Applied Soft Computing</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='AUJMI'">The Australian Journal of Midwifery</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='BBAMM'">Biochimica et Biophysica Acta (BBA) - Mucoproteins and Mucopolysaccharides</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='BIOBR'">Biobehavioral reviews</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='BJOG'">British journal of obstetrics and gynaecology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CALI'">Revista de Calidad Asistencial</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CAP'">Current Applied Physics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CBC'">Comparative Biochemistry and Physiology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CIRUGI'">Cirugia espanola</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CLCC'">Clinical Colorectal Cancer</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CLIPOL'">Climate Policy</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='CLIRES'">Clinical Neuroscience Research</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='COPHAR'">Current Opinion in Pharmacology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='DEVCEL'">Developmental Cell</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ECOIND'">Ecological Indicators</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ECOSYS'">Economic Systems</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EIMC'">Enfermedades Infecciosas y Microbiologia Cl&#237;nica</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EMCCG'">EMC - Cirugia general</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EMCCP'">EMC - Cirugia plastica reparadora y estetica</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EMCORR'">EMC - Otorrinolaringologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ENDONU'">Endocrinologia y Nutricion</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ENFCLI'">Enfermeria Clinica</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ENFI'">Enfermeria Intensiva</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EXERGY'">Exergy : an international journal</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='EXMATH'">Expositiones Mathematicae</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='FCL'">Foot and Ankle Clinics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='FEMSYR'">FEMS Yeast Research</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='FMC'">FMC Formacion Medica Continuada en Atencion Primaria</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='FT'">Fisioterapia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='GASTRO'">Gastroenterologia y Hepatologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='GINE'">Clinica e Investigacion en Ginecologia y Obstetricia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='HKJOT'">Hong Kong Journal of Occupational Therapy</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ICS'">International congress series</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='IJLEO'">Optik</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='INFORG'">Information and Organization</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='INTIMP'">International Immunopharmacology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ITBM-RBM News'">ITBM-RBM News</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JAGP'">American Journal of Geriatric Psychiatry</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JCHB'">HOMO- Journal of Comparative Human Biology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JCZ'">Zoologischer Anzeiger</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JMDA'">Journal of the American Medical Directors Association</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JNUENB'">Journal of nuclear energy. Part B, Reactor technology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JOSM'">Journal of osteopathic medicine : JOM </xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JPCGC'">Progress in Crystal Growth and Characterization of Materials</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JSCOBS'">Journal of social and biological structures</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='JSUPRA'">Journal of supramolecular chemistry</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='LANINF'">The Lancet Infectious Diseases</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='LIGMET'">Journal of light metals</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='MEEGID'">Infection, Genetics and Evolution</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='MITOCH'">Mitochondrion</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='MJAFI'">Medical Journal Armed Forces India</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='MLA'">Medical laser application</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='MODGEP'">Gene Expression Patterns</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='NEUADO'">Neuropsychiatrie de l'enfance et de l'adolescence</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='NEUTOX'">NeuroToxicology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='NEWAST'">New Astronomy</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ODE'">Organisms Diversity and Evolution</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ORTRES'">Journal of Orthopaedic Research</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='OTORRI'">Acta Otorrinolaringologica Espanola</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='PAN'">Pancreatology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='PATBIO'">Pathologie Biologie</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='PIEL'">Piel</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='POCOLD'">Progress in Organic Coatings</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='POG'">Progresos en Obstetricia y Ginecologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='PROSC'">Proceedings of the Symposium on Combustion</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='REAURG'">Reanimation</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='REFOCU'">Refocus</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='REGG'">Revista Espanola de Geriatria y Gerontologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RH'">Rehabilitacion</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RIGP'">Reviews in Gynaecological Practice</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RSSM'">Research in Social Stratification and Mobility</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RTE'">Research in Transportation Economics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='RX'">Radiologia</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='SCIBR'">Scandinavian international business review</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='SPINEE'">Spine Journal</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='TA'">Trastornos Adictivos </xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='THAREL'">Thalamus and Related Systems</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='TRASCI'">Transfusion and Apheresis Science</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='TREIMM'">Trends in Immunology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='TREPAR'">Trends in Parasitology</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='TRMOME'">Trends in Molecular Medicine</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='VSP'">Veterinary Clinics of North America: Small Animal Practice</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='X193'">Clinical Therapeutics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YEJVX'">European Journal of Vascular and Endovascular Surgery Extra</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YJBIN'">Journal of Biomedical Informatics</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YJSSH'">Journal- American Society for the Surgery of the Hand</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YMED'">Journal of Evidence-Based Dental Practice</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YNBIN'">Newborn and Infant Nursing Reviews</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YNEPR'">Nurse Education in Practice</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YSCDS'">Seminars in Cerebrovascular Disease and Stroke</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='YTUBE'">Tuberculosis</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ZBMMA'">Zentralblatt fur Bakteriologie. 1. Abt. Originale. A.</xsl:when>
           <xsl:when test="normalize-space($codeTitle1)='ZOOL'">Zoology</xsl:when>
           <xsl:otherwise> 
                <xsl:value-of select="$codeTitle1"/>
            </xsl:otherwise>
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
                        <xsl:apply-templates select="ce:dochead/ce:textfn"/>
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
                                <note type="publication-type">
                                    <xsl:attribute name="type">journal</xsl:attribute>
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
                                <!-- verbalisation titre série / journal -->
                                <xsl:if test="//els1:item-info/els1:jid |//els2:item-info/els2:jid | //item-info/jid">
                                    <title type="main">
                                        <xsl:attribute name="level">
                                            <xsl:choose>
                                                <xsl:when test="$docIssueEls//s1:issue-info/s1:jid">s</xsl:when>
                                                <xsl:otherwise>j</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                        <xsl:value-of select="$codeTitle"/>
                                    </title>
                                    <title type="abbr">
                                        <xsl:attribute name="level">
                                            <xsl:choose>
                                                <xsl:when test="$docIssueEls//s1:issue-info/s1:jid">s</xsl:when>
                                                <xsl:otherwise>j</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                        <xsl:value-of select="//els1:item-info/els1:jid |//els2:item-info/els2:jid | //item-info/jid"/>
                                    </title>
                                </xsl:if>
                                <!-- titre supplémentaire -->
                                <xsl:if test="$docIssueEls//issue-data/title-editors-group/ce:title[string-length() &gt; 0] | $docIssueEls//s1:issue-data/s1:title-editors-group/ce:title[string-length() &gt; 0]">
                                    <title type="sub">
                                        <xsl:value-of select="$docIssueEls//issue-data/title-editors-group/ce:title | $docIssueEls//s1:issue-data/s1:title-editors-group/ce:title"/>
                                        <xsl:if test="$docIssueEls//issue-data/title-editors-group/conference-info/venue[string-length() &gt; 0] | $docIssueEls//s1:issue-data/s1:title-editors-group/s1:conference-info/s1:venue[string-length() &gt; 0]">
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of select="$docIssueEls//issue-data/title-editors-group/conference-info/venue | $docIssueEls//s1:issue-data/s1:title-editors-group/s1:conference-info/s1:venue"/>
                                        </xsl:if>
                                    </title>
                                </xsl:if>
                                <!-- identifiants-->
                                <xsl:if test="//els1:item-info/els1:aid |//els2:item-info/els2:aid | //item-info/aid">
                                    <idno type="aid">
                                        <xsl:value-of select="//els1:item-info/els1:aid |//els2:item-info/els2:aid | //item-info/aid"/>
                                    </idno>
                                </xsl:if>
                                <xsl:if test="$docIssueEls//issue-info/ce:issn[string-length() &gt; 0] | $docIssueEls//s1:issue-info/ce:issn[string-length() &gt; 0] and not($docIssueEls//issue-info/ce:isbn|$docIssueEls//s1:issue-info/ce:isbn)">
                                    <xsl:for-each select="$docIssueEls//issue-info/ce:issn | $docIssueEls//s1:issue-info/ce:issn">
                                        <idno type="ISSN">
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </idno>
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="$docIssueEls//issue-info/ce:isbn[string-length() &gt; 0] | $docIssueEls//s1:issue-info/ce:isbn[string-length() &gt; 0]">
                                    <xsl:for-each select="$docIssueEls//issue-info/ce:isbn | $docIssueEls//s1:issue-info/ce:isbn">
                                        <idno type="ISBN">
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </idno>
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="$docIssueEls//issue-info/ce:doi[string-length() &gt; 0] | $docIssueEls//s1:issue-info/ce:doi[string-length() &gt; 0]">
                                    <idno type="DOI">
                                        <xsl:value-of select="$docIssueEls//issue-info/ce:doi | $docIssueEls//s1:issue-info/ce:doi"/>
                                    </idno>
                                </xsl:if>
                                <xsl:if test="$docIssueEls//issue-info/ce:pii[string-length() &gt; 0] |$docIssueEls//s1:issue-info/ce:pii[string-length() &gt; 0]">
                                    <idno type="PII">
                                        <xsl:value-of select="$docIssueEls//issue-info/ce:pii | $docIssueEls//s1:issue-info/ce:pii"/>
                                    </idno>
                                </xsl:if>
                                <!-- PL: note for me, does the issn appears in the biblio section? -->
                                <xsl:apply-templates select="//ce:issn"/>
                                <!-- Just in case -->
                                <!-- editors -->
                                <xsl:if test="$docIssueEls//issue-data/title-editors-group/ce:editors/ce:author-group[string-length() &gt; 0] | $docIssueEls//s1:issue-data/s1:title-editors-group/ce:editors/ce:author-group[string-length() &gt; 0]">
                                    <xsl:for-each select="$docIssueEls//issue-data/title-editors-group/ce:editors/ce:author-group | $docIssueEls//s1:issue-data/s1:title-editors-group/ce:editors/ce:author-group">
                                        <xsl:if test="ce:author[string-length() &gt; 0]">
                                            <xsl:for-each select="ce:author">
                                                <editor>
                                                    <persName>
                                                        <xsl:if test="ce:given-name[string-length() &gt; 0]">
                                                            <forename type="first">
                                                                <xsl:value-of select="ce:given-name"/>
                                                            </forename>
                                                        </xsl:if>
                                                        <xsl:if test="ce:surname[string-length() &gt; 0]">
                                                            <surname>
                                                                <xsl:value-of select="ce:surname"/>
                                                            </surname>
                                                        </xsl:if>
                                                    </persName>
                                                </editor>
                                            </xsl:for-each>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
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
                                    <!-- date de publication -->
                                    <xsl:choose>
                                        <xsl:when test="$docIssueEls//issue-data/cover-date/date-range/start-date[string-length() &gt; 0] |$docIssueEls//s1:issue-data/s1:cover-date/s1:date-range/s1:start-date[string-length() &gt; 0]">
                                            <date type="published">
                                                <xsl:attribute name="when">
                                                    <xsl:value-of select="$docIssueEls//issue-data/cover-date/date-range/start-date|$docIssueEls//s1:issue-data/s1:cover-date/s1:date-range/s1:start-date"/>
                                                </xsl:attribute>
                                            </date>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:if test="//item-info/ce:copyright/@year | //els1:item-info/ce:copyright/@year| //els2:item-info/ce:copyright/@year">
                                            <date type="published">
                                                <xsl:attribute name="when">
                                                    <xsl:value-of select="//item-info/ce:copyright/@year | //els1:item-info/ce:copyright/@year| //els2:item-info/ce:copyright/@year"/>
                                                </xsl:attribute>
                                            </date>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                        <!-- volume -->
                                    <xsl:if test="$docIssueEls//vol-first[string-length()&gt; 0] | $docIssueEls//s1:vol-first[string-length()&gt; 0]">
                                        <biblScope unit="volume">
                                            <xsl:value-of select="$docIssueEls//vol-first | $docIssueEls//s1:vol-first"/>
                                            <xsl:if test="$docIssueEls//vol-last |$docIssueEls//s1:vol-last">
                                                <xsl:text>&#8211;</xsl:text>
                                                <xsl:value-of select="$docIssueEls//vol-last | $docIssueEls//s1:vol-last"/>
                                            </xsl:if>
                                        </biblScope>
                                    </xsl:if>
                                    <!-- numéro -->
                                    <xsl:if test="$docIssueEls//iss-first[string-length()&gt; 0] |$docIssueEls//s1:iss-first[string-length()&gt; 0]">
                                        <biblScope unit="issue">
                                            <xsl:value-of select="$docIssueEls//iss-first |$docIssueEls//s1:iss-first"/>
                                            <xsl:if test="$docIssueEls//iss-last | $docIssueEls//s1:iss-last">
                                                <xsl:text>&#8211;</xsl:text>
                                                <xsl:value-of select="$docIssueEls//iss-last | $docIssueEls//s1:iss-last"/>
                                            </xsl:if>
                                        </biblScope>
                                    </xsl:if>
                                    <!-- supplément -->
                                    <xsl:if test="$docIssueEls//suppl[string-length()&gt; 0] |$docIssueEls//s1:suppl[string-length()&gt; 0]">
                                        <biblScope unit="suppl">
                                            <xsl:value-of select="$docIssueEls//suppl | $docIssueEls//s1:suppl"/>
                                        </biblScope>
                                    </xsl:if>
                                    <!-- pages totales facsicules -->
                                    <xsl:if test="$docIssueEls//issue-data/ce:pages/ce:first-page[string-length()&gt; 0] |$docIssueEls//s1:issue-data/ce:pages/ce:first-page[string-length()&gt; 0]">
                                        <xsl:for-each select="$docIssueEls//issue-data/ce:pages | $docIssueEls//s1:issue-data/ce:pages">
                                            <biblScope unit="page" from="{ce:first-page}">
                                                <xsl:if test="ce:last-page[string-length()&gt; 0]">
                                                    <xsl:attribute name="to">
                                                        <xsl:value-of select="ce:last-page"/> 
                                                    </xsl:attribute>
                                                </xsl:if>
                                            </biblScope>
                                        </xsl:for-each>
                                    </xsl:if>
                                </imprint>
                            </monogr>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
                <xsl:if test="//ce:doctopics|head/ce:keywords |els2:head/ce:keywords | head/ce:keywords | els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract">
                    <profileDesc>
						<!-- PL: abstract is moved from <front> to here -->
                        <xsl:apply-templates select="els1:head/ce:abstract |els2:head/ce:abstract | head/ce:abstract"/>
                        <xsl:apply-templates select="els1:item-info/ce:doctopics"/>
                        <xsl:apply-templates select="els2:item-info/ce:doctopics"/>
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
                                        <xsl:when test="@xml:lang">
                                            <xsl:value-of select="@xml:lang"/>
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
                            <xsl:apply-templates select="els1:body/*"/>
                            <xsl:apply-templates select="els2:body/*"/>
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
                <xsl:if test="els1:back/* | els1:tail/* |els2:back/* | els2:tail/* | tail/*">
                    <back>
                        <!-- Bravo: Elsevier a renommé son back en tail... visionnaire -->
                        <xsl:apply-templates select="els1:back/* | els1:tail/* |els2:back/* | els2:tail/* | tail/*"/>
                    </back>
                </xsl:if>
            </text>
        </TEI>
    </xsl:template>

    <!-- Traitement des méta-données (génération de l'entête TEI) -->

    <xsl:template match="ce:copyright">
        <!-- moved up publisher information -->
        <publisher>
            <xsl:choose>
                <xsl:when test="normalize-space(text())">
                    <xsl:value-of select="normalize-space(text())"/>
                </xsl:when>
                <xsl:otherwise>Elsevier</xsl:otherwise>
            </xsl:choose>
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
            	    <xsl:choose>
            	        <xsl:when test="normalize-space(text())">
            	            <xsl:value-of select="normalize-space(text())"/>
            	        </xsl:when>
            	        <xsl:otherwise>Elsevier.</xsl:otherwise>
            	    </xsl:choose>
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
                <term>
                    <xsl:if test="@id">
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>
                    </xsl:if>
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
            <xsl:attribute name="type">received</xsl:attribute>
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
            <xsl:attribute name="type">accepted</xsl:attribute>
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
            <xsl:attribute name="type">published</xsl:attribute>
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
            <figure>
                <xsl:if test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </figure>
        
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
                
                <xsl:if test="//ce:correspondence[@id=$localId2] ">
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
                
                <xsl:if test="//ce:footnote[@id=$localId2]">
                    <xsl:message>Trouvé: <xsl:value-of select="$localId2"/></xsl:message>
                    <affiliation ana="footnote">
                        <xsl:call-template name="parseAffiliation">
                            <xsl:with-param name="theAffil">
                                <xsl:value-of select="//ce:footnote[@id=$localId2]/ce:note-para"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </affiliation>
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
            <link source="{@locator}">
                <xsl:if test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
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
