<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" 
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:els1="http://www.elsevier.com/xml/ja/dtd"    
    xmlns:els2="http://www.elsevier.com/xml/cja/dtd"
    xmlns:s1="http://www.elsevier.com/xml/si/dtd"
    xmlns:wiley="http://www.wiley.com/namespaces/wiley/wiley"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
    <!-- ajout déclaration schema ODD-ISTEX -->
    
    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:variable name="journalList" select="document('JournalList.xml')"/>
    <!-- SAGE - ajout des issns -->
    <xsl:variable name="repriseISSNCode">
        <xsl:choose>
            <xsl:when test="normalize-space($codePublisherID1)='AAF'">0308-5759</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AAS'">0095-3997</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ABS'">0002-7642</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ACD'">1038-4162</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ACH'">1032-3732</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ADB'">1059-7123</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ADH'">1523-4223</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AED'">0004-9441</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AEI'">1534-5084</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AEQ'">0001-8481</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AER'">0002-8312</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AES'">1090-820X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AFF'">0886-1099</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AFS'">0095-327X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AHH'">1474-0222</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJA'">1533-3175</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJC'">0972-8201</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJE'">1098-2140</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJH'">1049-9091</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJL'">1559-8276</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJM'">1062-8606</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AJS'">0363-5465</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ALH'">1469-7874</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ALT'">0304-3754</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANG'">0506-4287</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANJ'">0004-8658</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANM'">1746-8477</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANN'">0002-7162</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANP'">0004-8674</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ANT'">1463-4996</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='APA'">0003-0651</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='APH'">1010-5395</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='APM'">0146-6216</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='APR'">1532-673X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='APY'">1039-8562</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ARJ'">1476-7503</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ARP'">0275-0740</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ASJ'">0001-6993</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ASM'">1073-1911</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ASQ'">0001-8392</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ASR'">0003-1224</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AUM'">0312-8962</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='AUT'">1362-3613</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BAS'">0007-6503</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BCQ'">1080-5699</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BIR'">0266-3821</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BJI'">1757-1774</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BJP'">2049-4637</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BJR'">0956-4748</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BMO'">0145-4455</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BMS'">0759-1063</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BOD'">1357-034X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BOS'">0096-3402</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BRN'">1099-8004</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BSE'">0143-6244</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BST'">0270-4676</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BTB'">0146-1079</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='BUL'">0192-6365</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CAC'">0010-8367</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CAD'">0011-1287</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CAN'">1941-4064</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CAP'">1354-067X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CAT'">1076-0296</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CBI'">1476-993X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CBR'">0886-3687</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CCJ'">1043-9862</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CCM'">1470-5958</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CCP'">1359-1045</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CCR'">1069-3971</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CCS'">1534-6501</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CDE'">2165-1434</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CDP'">0963-7214</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CDQ'">1525-7401</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CDY'">0921-3740</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CED'">0973-1849</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CEL'">0021-955X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CEP'">0333-1024</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CER'">1063-293X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CGJ'">1474-4740</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CHC'">1367-4935</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CHD'">0907-5682</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CHI'">1742-3953</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CHP'">2156-5872</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CHR'">0009-4455</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CIN'">0920-203X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CIS'">0069-9667</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CJB'">0093-8548</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CJO'">0315-1034</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CJP'">0887-4034</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CJR'">0734-0168</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CJS'">0829-5735</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CLA'">0069-4770</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CLT'">0265-6590</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CMC'">1741-6590</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CMP'">0738-8942</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CMX'">1077-5595</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CNC'">0309-8168</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CNR'">1054-7738</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CNU'">1474-5151</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='COA'">0308-275X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CON'">1354-8565</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CPJ'">0009-9228</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CPR'">2047-4873</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CPS'">0010-4140</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CPT'">1074-2484</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CQX'">1938-9655</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRC'">0973-2586</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRD'">1479-9723</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRE'">0269-2155</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRJ'">1748-8958</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRS'">0896-9205</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRW'">0091-5521</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CRX'">0093-6502</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CSC'">1532-7086</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CSI'">0011-3921</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CSP'">0261-0183</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CSX'">0094-3061</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CTJ'">1740-7745</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CTR'">0887-302X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CTX'">1536-5042</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='CUS'">1749-9755</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DAS'">0957-9265</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DCM'">1750-4813</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DEM'">1471-3012</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DIO'">0392-1921</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DIS'">1461-4456</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DMS'">1548-5129</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='DPS'">1044-2073</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EAB'">0013-9165</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EAQ'">0013-161X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EAU'">0956-2478</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EBX'">1063-4266</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ECL'">1468-7984</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ECR'">1476-718X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ECS'">1367-5494</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EDM'">1555-3434</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EDQ'">0891-2424</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EDR'">0013-189X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EEG'">1550-0594</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EEP'">0888-3254</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EHP'">0163-2787</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EHQ'">0265-6914</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EID'">0143-831X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EIM'">0046-2039</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EJC'">0267-3231</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EJD'">0959-6801</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EJT'">1354-0661</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EJW'">1350-5068</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EMA'">1741-1432</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EME'">0974-9101</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EMF'">0972-6527</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EMR'">1754-0739</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ENG'">0075-4242</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ENX'">1931-2431</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EPA'">0162-3737</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EPE'">1356-336X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EPM'">0013-1644</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EPT'">1474-8851</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EPX'">0895-9048</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ERG'">1064-8046</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ERX'">0193-841X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ESJ'">1746-1979</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ESP'">0958-9287</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EST'">1368-4310</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ETH'">1466-1381</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ETN'">1468-7968</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EUC'">1477-3708</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EUP'">1465-1165</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EUR'">0969-7764</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EUS'">0013-1245</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EVI'">1356-3890</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='EXT'">0014-5246</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FAP'">0959-3535</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FAS'">1938-6400</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FBR'">0894-4865</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FCX'">1557-0851</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FLA'">0142-7237</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FMX'">1525-822X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FOA'">1088-3576</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FOI'">0014-5858</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FRC'">0957-1558</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FST'">1082-0132</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FTH'">0966-7350</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='FTY'">1464-7001</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GAC'">1555-4120</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GAQ'">0533-3164</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GAS'">0891-2432</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GAZ'">1748-0485</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GBR'">0972-1509</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GCQ'">0016-9862</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GCT'">1076-2175</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GEI'">0261-4294</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GMC'">1742-7665</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GMT'">1048-3713</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GOM'">1059-6011</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GPI'">1368-4302</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GSP'">1468-0181</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='GTD'">0971-8524</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HAS'">0160-5976</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HEA'">1363-4593</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HEJ'">0017-8969</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HET'">0960-3271</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HFS'">0018-7208</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HHC'">1084-8223</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HHS'">0952-6951</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HIJ'">1940-1612</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HIP'">0954-0083</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HJB'">0739-9863</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HOL'">0959-6836</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HPC'">1094-3420</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HPP'">1524-8399</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HPQ'">1359-1053</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HPY'">0957-154X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HRD'">1534-4843</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HSB'">0022-1465</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HSX'">1088-7679</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='HUM'">0018-7267</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IAB'">0020-8345</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IAS'">2233-8659</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IBE'">1420-326X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ICJ'">1057-5677</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ICS'">1367-8779</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ICT'">1534-7354</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IDV'">0266-6669</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IER'">0019-4646</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IFL'">0340-0352</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IHR'">0376-9836</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJB'">1367-0069</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJD'">1056-7895</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJL'">1534-7346</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJM'">0255-7614</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJO'">0020-7497</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJR'">0278-3649</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJS'">1066-8969</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IJT'">1091-5818</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IMP'">1365-4802</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='INI'">1753-4259</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='INT'">0020-9643</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IOC'">0306-4220</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IPS'">0192-5121</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IRE'">0047-1178</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IRM'">0973-0052</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IRS'">1012-6902</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IRV'">0269-7580</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IRX'">0160-0176</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISB'">0266-2426</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISC'">1053-4512</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISP'">0020-7640</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISQ'">0020-8817</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISS'">0268-5809</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ISW'">0020-8728</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ITQ'">0021-1400</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='IVI'">1473-8716</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAB'">0021-8863</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAD'">1087-0547</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAF'">0148-558X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAG'">0733-4648</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAH'">0898-2643</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAP'">1078-3903</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAR'">0743-5584</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAS'">0021-9096</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JAX'">1936-7244</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBA'">0885-3282</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBC'">0883-9115</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBD'">0165-0254</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBP'">0095-7984</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBR'">0748-7304</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBS'">0021-9347</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JBX'">1087-0571</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCA'">1069-0727</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCC'">0022-0221</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCD'">0894-8453</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCE'">0891-2416</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCH'">0022-0094</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCI'">0196-8599</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCL'">0021-9894</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCM'">0021-9983</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCN'">0883-0738</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCR'">0731-4086</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCS'">1468-795X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JCX'">1078-3458</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JDI'">1358-2291</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JDM'">8756-4793</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JDS'">0169-796X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEA'">0272-4316</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEB'">1076-9986</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JED'">1070-4965</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEG'">0162-3532</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEI'">1053-8151</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEN'">1744-2591</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JEP'">0095-2443</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JES'">0047-2441</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFE'">1042-3915</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFH'">0363-1990</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFI'">0192-513X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFM'">1098-612X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFN'">1074-8407</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JFS'">0734-9041</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JGM'">1741-1343</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JGP'">0891-9887</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHH'">1538-1927</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHI'">1460-4582</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHL'">0890-3344</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHM'">0972-0634</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHN'">0898-0101</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHP'">0022-1678</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHS'">1753-1934</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHT'">1096-3480</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JHV'">0971-6858</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIA'">2325-9574</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIC'">0885-0666</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JID'">1744-6295</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIL'">0534-283X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIM'">1045-389X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIR'">0022-1856</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIS'">0165-5515</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIT'">1528-0837</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JIV'">0886-2605</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JLO'">1548-0518</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JLS'">0261-927X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMC'">1077-6958</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMD'">0273-4753</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JME'">1052-5629</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMH'">1557-9883</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMI'">1056-4926</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMK'">0276-1467</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMM'">1097-184X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMO'">1522-6379</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMQ'">1077-6990</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMS'">0022-2542</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JMT'">1057-0837</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JNT'">0142-064X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOA'">1932-202X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOB'">0021-9436</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOC'">1469-5405</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOD'">0022-0426</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOE'">0971-3557</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOI'">0974-9306</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOM'">0149-2063</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOP'">0269-8811</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOS'">1440-7833</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOT'">0309-0892</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JOU'">1464-8849</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPA'">0734-2829</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPE'">0739-456X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPF'">8756-0879</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPH'">1538-5132</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPL'">0885-4122</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPO'">1043-4542</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPP'">0897-1900</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JPR'">0022-3433</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JRC'">0022-4278</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JRI'">1475-2409</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JRM'">0022-4294</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JRN'">1744-9871</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JRP'">0731-6844</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSA'">1469-6053</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSD'">0973-4082</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSE'">1527-0025</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSI'">1028-3153</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSM'">1099-6362</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSP'">0951-8207</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSR'">1094-6705</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSS'">0193-7235</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JSW'">1468-0173</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JTC'">0892-7057</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JTD'">1541-3446</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JTE'">0022-4871</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JTP'">0951-6298</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JTR'">0047-2875</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JUH'">0096-1442</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JVC'">1077-5463</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='JVM'">1356-7667</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LAL'">0963-9470</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LAP'">0094-582X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LAS'">0023-8309</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LCH'">1743-8721</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LDQ'">0731-9487</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LDX'">0022-2194</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LEA'">1742-7150</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LEC'">0269-0942</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LIS'">0961-0006</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LRT'">1477-1535</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LSJ'">0160-449X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LTJ'">0265-5322</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LTR'">1362-1688</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='LUP'">0961-2033</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MAR'">0973-8010</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MCQ'">0893-3189</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MCR'">1077-5587</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MCS'">0163-4437</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MCU'">1359-1835</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MCX'">0097-7004</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MDM'">0272-989X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MEC'">0748-1756</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MEJ'">0027-4321</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MHJ'">0971-9458</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MIE'">0892-0206</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MIL'">0305-8298</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MLI'">0968-5332</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MLQ'">1350-5076</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MLS'">0258-042X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MMD'">1943-8621</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MMJ'">1745-7904</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MMR'">1558-6898</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MMS'">1081-2865</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MSJ'">1352-4585</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MSS'">1750-6980</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MSX'">1029-8649</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MTQ'">1470-5931</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='MWC'">1750-6352</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NAH'">0260-1060</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NCP'">0884-5336</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NEJ'">0969-7330</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NER'">0027-9501</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NMS'">1461-4448</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NNR'">1545-9683</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NRO'">1073-8584</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NSQ'">0894-3184</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='NVS'">0899-7640</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='OAE'">1086-0266</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='OPP'">1078-1552</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ORG'">1350-5084</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ORM'">1094-4281</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='OSS'">0170-8406</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PAA'">1030-570X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PAD'">0367-8822</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PAS'">0032-3292</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PAU'">0369-9838</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PBI'">1098-3007</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PCP'">0367-8849</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PDS'">0971-3336</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PED'">1757-9759</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PEN'">0148-6071</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PFR'">1091-1421</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIA'">1464-9934</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIB'">0954-4054</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIC'">0954-4062</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PID'">0954-4070</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIE'">0954-4089</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIF'">0954-4097</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIG'">0954-4100</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIH'">0954-4119</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PII'">0959-6518</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIJ'">1350-6501</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIK'">1464-4193</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIL'">1464-4207</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIM'">1475-0902</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIN'">1740-3499</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIO'">1748-006X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PIP'">1754-3371</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PLT'">1473-0952</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PME'">0020-3483</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PMJ'">0269-2163</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PNZ'">0032-3187</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='POM'">0305-7356</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='POS'">0048-3931</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPA'">0952-0767</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPE'">1470-594X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPG'">0309-1333</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPN'">1527-1544</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPQ'">1354-0688</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PPS'">1745-6916</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PQX'">1098-6111</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PRB'">0264-5505</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PRF'">0267-6591</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PRQ'">1065-9129</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PSC'">0191-4537</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PSP'">0146-1672</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PSR'">1088-8683</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PSS'">0956-7976</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PTX'">0090-5917</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PUN'">1462-4745</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PUS'">0963-6625</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PVS'">1531-0035</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PWM'">1087-724X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='PWQ'">0361-6843</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='QHR'">1049-7323</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='QIX'">1077-8004</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='QRJ'">1468-7941</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='QSW'">1473-3250</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RAC'">0306-3968</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RAS'">0020-8523</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RCB'">0034-3552</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='REA'">1747-0161</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='REL'">0033-6882</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RER'">0034-6543</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='REV'">1557-234X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RMI'">0974-9292</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ROA'">0164-0275</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='ROP'">0734-371X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RRE'">0091-732X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RRP'">0486-6134</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RSH'">1757-9139</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RSM'">1321-103X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RSS'">1043-4631</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RSW'">1049-7315</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='RSX'">1933-7191</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAC'">1206-3312</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAD'">0973-1741</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAE'">1391-5614</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAG'">1046-8781</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAR'">0262-7280</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAS'">0971-5231</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SAX'">1079-0632</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SCE'">0953-9468</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SCH'">0049-0857</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SCP'">0037-7686</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SCV'">1089-2532</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SCX'">1075-5470</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SDI'">0967-0106</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SDJ'">0309-1325</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SED'">0022-4669</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SEX'">1363-4607</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SGR'">8756-0275</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SHM'">1475-9217</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SIH'">0257-6430</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SIM'">0740-6797</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SIR'">0008-4298</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SJP'">1403-4948</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SLG'">0160-323X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SLR'">0267-6583</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SLS'">0964-6639</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SMJ'">1471-082X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SMM'">0962-2802</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SMQ'">1524-5004</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SMR'">0049-1241</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SMX'">0081-1750</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SOC'">0038-0385</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SOE'">0038-0407</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SOQ'">1476-1270</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SPA'">1532-4400</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SPH'">1941-7381</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SPI'">0143-0343</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SPQ'">0190-2725</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SPR'">0265-4075</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SRI'">1553-3506</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SSC'">0894-4393</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SSI'">0539-0184</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='SSS'">0306-3127</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='STH'">0162-2439</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='STS'">0971-7218</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='STX'">0735-2751</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAB'">1759-720X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAG'">1756-283X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAK'">1753-9447</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAM'">1758-8340</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAN'">1756-2856</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAP'">0959-3543</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAR'">1753-4658</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAS'">0961-463X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TAU'">1756-2872</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TCN'">1043-6596</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TCP'">0011-0000</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TCR'">1362-4806</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TCS'">0263-2764</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TDE'">0145-7217</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TEC'">0271-1214</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TES'">0888-4064</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TFJ'">1066-4807</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='THE'">0725-5136</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='THR'">1467-3584</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TIA'">1084-7138</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TIH'">0748-2337</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TIM'">0142-3312</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TJX'">0040-571X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TMT'">1534-7656</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TOP'">0098-6283</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TOU'">1468-7976</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TPA'">0144-7394</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TPJ'">0032-8855</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TPS'">1363-4615</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TRA'">1460-4086</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TRE'">1477-8785</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TRJ'">0040-5175</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TRN'">0265-3788</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TRS'">1024-2589</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TSO'">0092-055X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TTJ'">0040-5736</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TVA'">1524-8380</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='TVN'">1527-4764</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='UAR'">1078-0874</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='UEX'">0042-0859</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='UIX'">0161-7346</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='UPD'">8755-1233</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='USJ'">0042-0980</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='VAW'">1077-8012</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='VCJ'">1470-3572</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='VCU'">1470-4129</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='VES'">1538-5744</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='VIS'">0972-2629</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WCX'">0741-0883</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WES'">0950-0170</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WIH'">0968-3445</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WJN'">0193-9459</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WOM'">1048-3950</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WOX'">0730-8884</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='WPJ'">0740-2775</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='YAS'">0044-118X</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='YEC'">1096-2506</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='YJJ'">1473-2254</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='YOU'">1103-3088</xsl:when>
            <xsl:when test="normalize-space($codePublisherID1)='YVJ'">1541-2040</xsl:when>
            <!-- BMJ -->
            <xsl:when test="//journal-meta/journal-title='Association Medical Journal'">2041-9996</xsl:when>
            <xsl:when test="//journal-meta/journal-title='London journal of medicine'">2041-9988</xsl:when>
            <xsl:when test="//journal-meta/journal-title='BMJ : British Medical Journal'">0959-8138</xsl:when>
            <xsl:when test="//journal-meta/journal-title='The British Edition of the Medical Letter on Drugs and Therapeutics'">0543-2766</xsl:when>
            <xsl:when test="//journal-meta/journal-title='Provincial Medical and Surgical Journal' and //pub-date[@pub-type='ppub']/year='1842' or //pub-date[@pub-type='ppub']/year='1843' or //pub-date[@pub-type='ppub']/year='1844'">2041-9961</xsl:when>
            <xsl:when test="//journal-meta/journal-title='Provincial Medical and Surgical Journal' and //pub-date[@pub-type='ppub']/year='1840' or //pub-date[@pub-type='ppub']/year='1841'">2041-9953</xsl:when>
            <xsl:when test="//journal-meta/journal-title='Provincial Medical and Surgical Journal' and //pub-date[@pub-type='ppub']/year='1845' or //pub-date[@pub-type='ppub']/year='1846' or //pub-date[@pub-type='ppub']/year='1847'or //pub-date[@pub-type='ppub']/year='1848'or //pub-date[@pub-type='ppub']/year='1849'or //pub-date[@pub-type='ppub']/year='1850'or //pub-date[@pub-type='ppub']/year='1851'or //pub-date[@pub-type='ppub']/year='1852'">2041-997X</xsl:when>
        </xsl:choose>
            </xsl:variable>
    <!--SAGE - eissn -->
    <xsl:variable name="REPRISEeISSNCode">
                <xsl:choose>
                     <xsl:when test="normalize-space($codePublisherID1)='AAF'">1740-469X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AAS'">1552-3039</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ABS'">1552-3381</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ACH'">1749-3374</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ADB'">1741-2633</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ADH'">1552-3055</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AED'">2050-5884</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AEI'">1938-7458</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AER'">1935-1011</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AES'">1527-330X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AFF'">1552-3020</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AFS'">1556-0848</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AHH'">1741-265X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJA'">1938-2731</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJE'">1557-0878</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJH'">1938-2715</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJL'">1559-8284</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJM'">1555-824X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJS'">1552-3365</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ALH'">1741-2625</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANJ'">1837-9273</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANM'">1746-8485</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANN'">1552-3349</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANP'">1440-1614</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANT'">1741-2641</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APA'">1941-2460</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APM'">1552-3497</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APR'">1552-3373</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APY'">1440-1665</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ARJ'">1741-2617</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ARP'">1552-3357</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASJ'">1502-3869</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASM'">1552-3489</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASQ'">1930-3815</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASR'">1939-8271</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AUM'">1327-2020</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AUT'">1461-7005</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BAS'">1552-4205</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BCQ'">1552-4191</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BIR'">1741-6450</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJI'">1757-1782</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJP'">2049-4645</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJR'">1741-2668</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BMO'">1552-4167</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BMS'">2070-2779</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BOD'">1460-3632</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BOS'">1938-3282</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BRN'">1552-4175</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BSE'">1477-0849</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BST'">1552-4183</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BTB'">1945-7596</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BUL'">1930-1405</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAC'">1460-3691</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAD'">1552-387X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAN'">1941-4072</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAP'">1461-7056</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAT'">1938-2723</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CBI'">1745-5200</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CBR'">1552-3837</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCJ'">1552-5406</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCM'">1741-2838</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCP'">1461-7021</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCR'">1552-3578</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCS'">1552-3802</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDE'">2165-1442</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDP'">1467-8721</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDQ'">1538-4837</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDY'">1461-7048</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CED'">2249-5320</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CEL'">1530-7999</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CEP'">1468-2982</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CER'">1531-2003</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CGJ'">1477-0881</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHC'">1741-2889</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHD'">1461-7013</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHI'">1745-9206</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHP'">2156-5899</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHR'">1939-9790</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CIN'">1741-590X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CIS'">1939-9995</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJB'">1552-3594</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJP'">1552-3586</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJR'">1556-3839</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CLA'">1530-812X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CLT'">1477-0865</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMC'">1741-6604</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMP'">1549-9219</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMX'">1552-6119</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNC'">2041-0980</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNR'">1552-3799</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNU'">1873-1953</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='COA'">1460-3721</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CON'">1748-7382</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPJ'">1938-2707</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPR'">2047-4881</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPS'">1552-3829</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPT'">1940-4034</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CQX'">1938-9663</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRC'">0973-2594</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRD'">1479-9731</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRE'">1477-0873</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRJ'">1748-8966</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRS'">1569-1632</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRW'">1940-2325</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRX'">1552-3810</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSC'">1552-356X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSI'">1461-7064</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSP'">1461-703X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSX'">1939-8638</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTJ'">1740-7753</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTR'">1940-2473</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTX'">1537-6052</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CUS'">1749-9763</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DAS'">1460-3624</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DCM'">1750-4821</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DEM'">1741-2684</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DIO'">1467-7695</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DIS'">1461-7080</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DMS'">1557-380X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DPS'">1538-4802</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAB'">1552-390X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAQ'">1552-3519</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAU'">1746-0301</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EBX'">1538-4799</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECL'">1741-2919</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECR'">1741-2927</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECS'">1460-3551</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDM'">2169-5032</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDQ'">1552-3543</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDR'">1935-102X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EEG'">2169-5202</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EEP'">1533-8371</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EHP'">1552-3918</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EHQ'">1461-7110</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EID'">1461-7099</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJC'">1460-3705</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJD'">1461-7129</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJT'">1460-3713</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJW'">1461-7420</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMA'">1741-1440</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EME'">0975-2730</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMF'">0973-0710</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMR'">1754-0747</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ENG'">1552-5457</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ENX'">1931-244X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPA'">1935-1062</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPE'">1741-2749</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPM'">1552-3888</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPT'">1741-2730</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPX'">1552-3896</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ERG'">2169-5083</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ERX'">1552-3926</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ESJ'">1746-1987</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ESP'">1461-7269</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EST'">1461-7137</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ETH'">1741-2714</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ETN'">1741-2706</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUC'">1741-2609</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUP'">1741-2757</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUR'">1461-7145</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUS'">1552-3535</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EVI'">1461-7153</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EXT'">1745-5308</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FAP'">1461-7161</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FAS'">1938-7636</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FBR'">1741-6248</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FLA'">1740-2344</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FMX'">1552-3969</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FOA'">1538-4829</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FOI'">2168-989X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FRC'">1740-2352</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FST'">1532-1738</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FTH'">1745-5189</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FTY'">1741-2773</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAC'">1555-4139</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAQ'">1461-717X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAS'">1552-3977</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAZ'">1748-0493</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GCQ'">1934-9041</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GCT'">2162-951X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GEI'">2047-9077</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GMC'">1742-7673</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GMT'">1931-3756</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GOM'">1552-3993</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GPI'">1461-7188</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GSP'">1741-2803</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HAS'">2372-9708</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HEA'">1461-7196</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HEJ'">1748-8176</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HET'">1477-0903</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HFS'">1547-8181</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HHC'">1552-6739</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HHS'">1461-720X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HIJ'">1940-1620</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HIP'">1361-6412</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HJB'">1552-6364</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HOL'">1477-0911</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPC'">1741-2846</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPP'">1552-6372</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPQ'">1461-7277</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPY'">1740-2360</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HRD'">1552-6712</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HSB'">2150-6000</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HSX'">1552-6720</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HUM'">1741-282X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IAB'">1751-9292</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IAS'">2049-1123</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IBE'">1423-0070</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICJ'">1556-3855</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICS'">1460-356X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICT'">1552-695X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IDV'">1741-6469</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IER'">0973-0893</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IFL'">1745-2651</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IHR'">0975-5977</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJB'">1756-6878</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJD'">1530-7921</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJL'">1552-6941</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJM'">1744-795X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJR'">1741-3176</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJS'">1940-2465</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJT'">1092-874X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IMP'">1475-7583</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='INI'">1753-4267</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='INT'">2159-340X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IOC'">1746-6067</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IPS'">1460-373X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRE'">1741-2862</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRS'">1461-7218</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRV'">2047-9433</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRX'">1552-6925</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISB'">1741-2870</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISC'">1538-4810</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISP'">1741-2854</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISQ'">1939-9987</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISS'">1461-7242</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISW'">1461-7234</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ITQ'">1752-4989</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IVI'">1473-8724</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAB'">1552-6879</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAD'">1557-1246</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAF'">2160-4061</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAG'">1552-4523</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAH'">1552-6887</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAP'">1532-5725</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAR'">1552-6895</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAS'">1745-2538</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAX'">1937-0245</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBA'">1530-8022</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBC'">1530-8030</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBD'">1464-0651</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBP'">1552-4558</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBR'">1552-4531</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBS'">1552-4566</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBX'">1552-454X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCA'">1552-4590</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCC'">1552-5422</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCD'">1556-0856</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCE'">1552-5414</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCH'">1461-7250</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCI'">1552-4612</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCL'">1741-6442</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCM'">1530-793X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCN'">1708-8283</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCR'">2328-174X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCS'">1741-2897</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCX'">1940-5200</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDI'">2047-9468</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDM'">1552-5430</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDS'">1745-2546</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEA'">1552-5449</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEB'">1935-1054</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JED'">1552-5465</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEG'">2162-9501</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEI'">2154-3992</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEN'">1744-2583</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEP'">1530-8006</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JES'">1740-2379</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFE'">1532-172X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFH'">1552-5473</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFI'">1552-5481</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFM'">1532-2750</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFN'">1552-549X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFS'">1530-8049</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JGM'">1741-7090</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JGP'">1552-5708</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHH'">1552-5716</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHI'">1741-2811</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHL'">1552-5732</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHM'">0973-0729</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHN'">1552-5724</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHP'">1552-650X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHS'">2043-6289</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHT'">1557-7554</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHV'">0973-0737</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIA'">2325-9582</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIC'">1525-1489</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JID'">1744-6309</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIM'">1530-8138</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIR'">1472-9296</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIS'">1741-6485</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIT'">1530-8057</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIV'">1552-6518</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JLO'">1939-7089</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JLS'">1552-6526</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMC'">2161-4326</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMD'">1552-6550</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JME'">1552-6658</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMH'">1557-9891</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMI'">1552-6542</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMK'">1552-6534</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMM'">1552-6828</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMO'">2161-4342</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMQ'">2161-430X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMT'">1945-0079</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JNT'">1745-5294</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOA'">2162-9536</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOB'">1552-4582</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOC'">1741-2900</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOD'">1945-1369</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOE'">0973-0745</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOI'">0975-5969</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOM'">1557-1211</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOP'">1461-7285</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOS'">1741-2978</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOT'">1476-6728</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOU'">1741-3001</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPA'">1557-5144</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPE'">1552-6577</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPF'">1530-8014</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPH'">1552-6585</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPL'">1552-6593</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPO'">1532-8457</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPP'">1531-1937</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPR'">1460-3578</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRC'">1552-731X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRI'">1741-2943</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRN'">1744-988X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRP'">1530-7964</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSA'">1741-2951</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSD'">0973-4074</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSE'">1552-7794</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSI'">1552-7808</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSM'">1530-7972</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSP'">1745-5286</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSR'">1552-7379</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSS'">1552-7638</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSW'">1741-296X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTC'">1530-7980</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTD'">1552-7840</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTE'">1552-7816</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTP'">1460-3667</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTR'">1552-6763</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JUH'">1552-6771</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JVC'">1741-2986</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JVM'">1479-1870</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAL'">1461-7293</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAP'">1552-678X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAS'">1756-6053</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LCH'">1743-9752</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LDQ'">2168-376X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LDX'">1538-4780</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LEA'">1742-7169</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LEC'">1470-9325</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LIS'">1741-6477</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LRT'">1477-0938</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LSJ'">1538-9758</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LTJ'">1477-0946</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LTR'">1477-0954</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LUP'">1477-0962</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MAR'">0973-8029</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCQ'">1552-6798</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCR'">1552-6801</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCS'">1460-3675</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCU'">1460-3586</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCX'">1552-6836</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MDM'">1552-681X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MEC'">1947-6302</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MEJ'">1945-0087</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MHJ'">0973-0753</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MIE'">1741-9883</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MIL'">1477-9021</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLI'">2047-9441</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLQ'">1461-7307</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLS'">2321-0710</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMD'">1943-863X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMJ'">1745-7912</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMR'">1558-6901</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMS'">1741-3028</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSJ'">1477-0970</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSS'">1750-6999</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSX'">2045-4147</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MTQ'">1741-301X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MWC'">1750-6360</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NAH'">2047-945X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NCP'">1941-2452</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NEJ'">1477-0989</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NER'">1741-3036</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NMS'">1461-7315</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NNR'">1552-6844</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NRO'">1089-4098</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NSQ'">1552-7409</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NVS'">1552-7395</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OAE'">1552-7417</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OPP'">1477-092X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ORG'">1461-7323</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ORM'">1552-7425</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OSS'">1741-3044</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAA'">1839-2598</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAS'">1552-7514</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PBI'">1538-4772</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PDS'">0973-0761</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PED'">1757-9767</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PEN'">1941-2444</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PFR'">1552-7530</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIA'">1477-027X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIB'">2041-2975</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIC'">2041-2983</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PID'">2041-2991</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIE'">2041-3009</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIF'">2041-3017</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIG'">2041-3025</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIH'">2041-3033</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PII'">2041-3041</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIJ'">2041-305X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIK'">2041-3068</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIL'">2041-3076</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIM'">2041-3084</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIN'">2041-3092</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIO'">1748-0078</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIP'">1754-338X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PLT'">1741-3052</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PMJ'">1477-030X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PNZ'">2041-0611</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='POM'">1741-3087</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='POS'">1552-7441</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPA'">1749-4192</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPE'">1741-3060</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPG'">1477-0296</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPN'">1552-7468</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPQ'">1460-3683</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPS'">1745-6924</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PQX'">1552-745X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRB'">1741-3079</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRF'">1477-111X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRQ'">1938-2758</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSC'">1461-734X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSP'">1552-7433</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSR'">1532-7957</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSS'">1467-9280</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PTX'">1552-7476</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PUN'">1741-3095</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PUS'">1361-6609</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PVS'">1521-5768</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PWM'">1552-7549</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PWQ'">1471-6402</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QHR'">1552-7557</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QIX'">1552-7565</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QRJ'">1741-3109</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QSW'">1741-3117</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RAC'">1741-3125</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RAS'">1461-7226</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RCB'">1538-4853</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REA'">2047-6094</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REL'">1745-526X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RER'">1935-1046</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REV'">2163-3134</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RMI'">0975-4709</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ROA'">1552-7573</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ROP'">1552-759X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RRE'">1935-1038</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RRP'">1552-8502</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSH'">1757-9147</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSM'">1834-5530</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSS'">1461-7358</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSW'">1552-7581</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSX'">1933-7205</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAC'">1552-8308</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAD'">0973-1733</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAG'">1552-826X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAR'">1741-3141</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAS'">0973-0788</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAX'">1573-286X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCE'">1745-5235</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCH'">0976-3538</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCP'">1461-7404</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCV'">1940-5596</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCX'">1552-8545</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SDI'">1460-3640</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SDJ'">1477-0288</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SED'">1538-4764</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SEX'">1461-7382</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SHM'">1741-3168</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SIH'">0973-080X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SIR'">2042-0587</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SJP'">1651-1905</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLG'">1943-3409</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLR'">1477-0326</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLS'">1461-7390</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMJ'">1477-0342</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMM'">1477-0334</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMQ'">1539-4093</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMR'">1552-8294</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMX'">1467-9531</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOC'">1469-8684</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOE'">1939-8573</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOQ'">1741-315X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPA'">1946-1607</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPH'">1941-0921</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPI'">1461-7374</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPQ'">1939-8999</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPR'">1460-3608</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SRI'">1553-3514</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSC'">1552-8286</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSI'">1461-7412</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSS'">1460-3659</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STH'">1552-8251</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STS'">0973-0796</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STX'">1467-9558</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAB'">1759-7218</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAG'">1756-2848</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAK'">1753-9455</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAM'">1758-8359</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAN'">1756-2864</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAP'">1461-7447</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAR'">1753-4666</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAS'">1461-7463</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAU'">1756-2880</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCN'">1552-7832</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCP'">1552-3861</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCR'">1461-7439</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCS'">1460-3616</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TDE'">1554-6063</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TEC'">1538-4845</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TES'">1944-4931</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TFJ'">1552-3950</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='THE'">1461-7455</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='THR'">1742-9692</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIA'">1940-5588</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIH'">1477-0393</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIM'">1477-0369</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TJX'">2044-2696</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TMT'">1085-9373</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TOP'">1532-8023</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TOU'">1741-3206</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPA'">2047-8720</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPJ'">1552-7522</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPS'">1461-7471</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRA'">1477-0350</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRE'">1741-3192</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRJ'">1746-7748</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRN'">1759-8931</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRS'">1996-7284</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TSO'">1939-862X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TTJ'">2044-2556</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TVA'">1552-8324</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TVN'">1552-8316</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UAR'">1552-8332</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UEX'">1552-8340</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UIX'">1096-0910</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UPD'">1945-0109</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='USJ'">1360-063X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VAW'">1552-8448</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VCJ'">1741-3214</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VCU'">1741-2994</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VES'">1938-9116</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VIS'">2249-5304</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WCX'">1552-8472</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WES'">1469-8722</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WIH'">1477-0385</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WJN'">1552-8456</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WOM'">2154-3941</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WOX'">1552-8464</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WPJ'">1936-0924</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YAS'">1552-8499</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YEC'">2154-400X</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YJJ'">1747-6283</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YOU'">1741-3222</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YVJ'">1556-9330</xsl:when>
                </xsl:choose>
            </xsl:variable>
    
    <!-- Article title -->
    <!-- NLM V2.0: ArticleTitle -->
    <!-- NLM V2.3 article: article-title, alt-title, atl -->
    <!-- BMJ: article-title -->
    <!-- Elsevier: ce:title -->
    <!-- Sage: art_title -->
    <!-- Springer: ArticleTitle -->
    <!-- ScholarOne: article_title, article_sub_title -->
    <!-- EDP: ArticleTitle/Title -->
    <xsl:variable name="codePublisherID1">
        <xsl:value-of select="article/front/journal-meta/journal-id[@journal-id-type='publisher-id']"/>
    </xsl:variable>
    <xsl:variable name="SageJournalTitle">
        <xsl:choose>
            <xsl:when test="normalize-space($codePublisherID1)='AAF'">Adoption &amp; fostering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AAS'">Administration &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ABS'">American behavioral scientist (Beverly Hills)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ACD'">Australian journal of career development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ACH'">Accounting history (Geelong)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ADB'">Adaptive behavior</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ADH'">Advances in developing human resources</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AED'">Australian journal of education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AEI'">Assessment for effective intervention</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AEQ'">Adult education (Chapel Hill)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AER'">American educational research journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AES'">Aesthetic surgery journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AFF'">Affilia</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AFS'">Armed forces and society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AHH'">Arts and humanities in higher education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJA'">American journal of Alzheimer's disease and other dementias</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJC'">Asian Journal of Management Cases</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJE'">The American journal of evaluation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJH'">The American journal of hospice &amp; palliative care</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJL'">American journal of lifestyle medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJM'">American journal of medical quality</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AJS'">American journal of sports medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ALH'">Active learning in higher education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ALT'">Alternatives (Amsterdam)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANG'">Vascular Diseases</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANJ'">Australian &amp; New Zealand journal of criminology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANM'">Animation (London. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANN'">The Annals of the American Academy of Political and Social Science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANP'">Australian and New Zealand journal of psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ANT'">Anthropological theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APA'">Journal of the American Psychoanalytic Association</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APH'">Asia-Pacific journal of public health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APM'">Applied psychological measurement</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APR'">American politics research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='APY'">Australasian psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ARJ'">Action research (London. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ARP'">American review of public administration</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASJ'">Acta sociologica (Trykt utg.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASM'">Assessment (Odessa, Fla.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASQ'">Administrative science quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ASR'">American sociological review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AUM'">Australian journal of management</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='AUT'">Autism (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BAS'">Business &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BCQ'">Business communication quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BIR'">Business information review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJI'">Journal of infection prevention</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJP'">British journal of pain</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BJR'">British journalism review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BMO'">Behavior modification</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BMS'">BMS. Bulletin de méthodologie sociologique</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BOD'">Body &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BOS'">Bulletin of the atomic scientists</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BRN'">Biological research for nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BSE'">Building services engineering research &amp; technology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BST'">Bulletin of science, technology &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BTB'">Biblical theology bulletin</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='BUL'">NASSP bulletin</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAC'">Cooperation and conflict</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAD'">Crime and delinquency</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAN'">Infant, child &amp; adolescent nutrition</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAP'">Culture &amp; psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CAT'">Clinical and applied thrombosis/hemostasis</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CBI'">Currents in biblical research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CBR'">Compensation and benefits review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCJ'">Journal of contemporary criminal justice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCM'">International journal of cross cultural management</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCP'">Clinical child psychology and psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCR'">Cross-cultural research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CCS'">Clinical case studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDE'">Career development and transition for exceptional individuals</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDP'">Current directions in psychological science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDQ'">Communication disorders quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CDY'">Cultural dynamics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CED'">Education Dialogue (Bangalore)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CEL'">Journal of cellular plastics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CEP'">Cephalalgia (Oslo)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CER'">Concurrent engineering, research and applications</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CGJ'">Cultural geographies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHC'">Journal of child health care</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHD'">Childhood (Copenhagen)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHI'">Chronic illness</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHP'">Journal of evidence-based complementary &amp; alternative medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CHR'">China report (New Delhi)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CIN'">China information</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CIS'">Contributions to Indian sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJB'">Criminal justice and behavior</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJO'">Canadian journal of occupational therapy and physiotherapy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJP'">Criminal justice policy review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJR'">Criminal justice review (Atlanta, Ga.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CJS'">Canadian journal of school psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CLA'">Clin-alert</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CLT'">Child language teaching and therapy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMC'">Crime, media, culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMP'">Conflict management and peace science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CMX'">Child maltreatment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNC'">Capital &amp; class</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNR'">Clinical nursing research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CNU'">European journal of cardiovascular nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='COA'">Critique of anthropology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CON'">Convergence (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPJ'">Clinical pediatrics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPR'">European journal of preventive cardiology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPS'">Comparative political studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CPT'">Journal of cardiovascular pharmacology and therapeutics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CQX'">Cornell hospitality quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRC'">Journal of Creative Communications</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRD'">Chronic respiratory disease</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRE'">Clinical rehabilitation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRJ'">Criminology &amp; criminal justice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRS'">Critical sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRW'">Community college review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CRX'">Communication research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSC'">Cultural studies, critical methodologies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSI'">Current sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSP'">CSP. Critical social policy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CSX'">Contemporary sociology (Washington)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTJ'">Clinical trials (London. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTR'">Clothing and textiles research journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CTX'">Contexts (Berkeley, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='CUS'">Cultural sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DAS'">Discourse &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DCM'">Discourse &amp; communication</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DEM'">Dementia (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DIO'">Diogenes (English ed.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DIS'">Discourse studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DMS'">Journal of defense modeling and simulation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='DPS'">Journal of disability policy studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAB'">Environment and behavior</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAQ'">Educational administration quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EAU'">Environment and urbanization</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EBX'">Journal of emotional and behavioral disorders</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECL'">Journal of early childhood literacy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECR'">Journal of early childhood research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ECS'">European journal of cultural studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDM'">Journal of cognitive engineering and decision making</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDQ'">Economic development quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EDR'">Educational researcher</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EEG'">Clinical EEG and neuroscience</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EEP'">Eastern European politics and societies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EHP'">Evaluation &amp; the health professions</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EHQ'">European history quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EID'">Economic and industrial democracy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EIM'">Engineering in medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJC'">European journal of communication (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJD'">European journal of industrial relations</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJT'">European journal of international relations</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EJW'">European journal of women's studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMA'">Educational management administration &amp; leadership</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EME'">Global journal of emerging market economies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMF'">Journal of Emerging Market Finance</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EMR'">Emotion review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ENG'">Journal of English linguistics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ENX'">Electronic news (Mahwah, N.J.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPA'">Educational evaluation and policy analysis</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPE'">European physical education review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPM'">Educational and psychological measurement</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPT'">European journal of political theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EPX'">Educational policy (Los Altos, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ERG'">Ergonomics in design</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ERX'">Evaluation review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ESJ'">Education, citizenship and social justice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ESP'">Journal of European social policy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EST'">European journal of social theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ETH'">Ethnography (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ETN'">Ethnicities (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUC'">European journal of criminology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUP'">European Union politics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUR'">European urban and regional studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EUS'">Education and urban society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EVI'">Evaluation (London. 1995)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='EXT'">Expository times</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FAP'">Feminism &amp; psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FAS'">Foot &amp; ankle specialist</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FBR'">Family business review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FCX'">Feminist criminology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FLA'">First language</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FMX'">Field methods.</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FOA'">Focus on autism and other developmental disabilities</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FOI'">Forum italicum</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FRC'">French cultural studies (Chalfont St. Giles)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FST'">Food science and technology international</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FTH'">Feminist theology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='FTY'">Feminist theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAC'">Games and culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAQ'">Group analysis</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAS'">Gender &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GAZ'">The international communication gazette</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GBR'">Global Business Review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GCQ'">The Gifted child quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GCT'">Gifted child today magazine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GEI'">Gifted education international</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GMC'">Global media and communication</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GMT'">General music today</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GOM'">Group &amp; organization management</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GPI'">Group processes &amp; intergroup relations</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GSP'">Global social policy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='GTD'">Gender, Technology and Development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HAS'">Humanity &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HEA'">Health (London. 1997)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HEJ'">Health education journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HET'">Human &amp; experimental toxicology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HFS'">Human factors</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HHC'">Home health care management &amp; practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HHS'">History of the human sciences</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HIJ'">The international journal of press/politics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HIP'">High performance polymers</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HJB'">Hispanic journal of behavioral sciences</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HOL'">Holocene (Sevenoaks)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPC'">The international journal of high performance computing applications</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPP'">Health promotion practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPQ'">Journal of health psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HPY'">History of psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HRD'">Human resource development review (Thousand Oaks, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HSB'">Journal of health and social behavior</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HSX'">Homicide studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='HUM'">Human relations (New York)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IAB'">International political science abstracts</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IAS'">International area studies review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IBE'">Indoor + built environment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICJ'">International criminal justice review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICS'">International journal of cultural studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ICT'">Integrative cancer therapies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IDV'">Information development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IER'">Indian economic and social history review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IFL'">IFLA journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IHR'">Indian historical review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJB'">International journal of bilingualism</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJD'">International journal of damage mechanics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJL'">International journal of lower extremity wounds</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJM'">International journal of music education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJO'">International journal of offender therapy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJR'">The international journal of robotics research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJS'">International journal of surgical pathology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IJT'">International journal of toxicology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IMP'">Improving schools</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='INI'">Innate immunity</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='INT'">Interpretation (Richmond)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IOC'">Index on censorship</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IPS'">International political science review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRE'">International relations (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRM'">International Journal of Rural Management</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRS'">International review for the sociology of sport</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRV'">International review of victimology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IRX'">International regional science review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISB'">International small business journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISC'">Intervention in school and clinic</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISP'">International journal of social psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISQ'">International Studies (New Delhi)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISS'">International sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ISW'">International social work</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ITQ'">The Irish theological quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='IVI'">Information visualization</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAB'">The Journal of applied behavioral science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAD'">Journal of attention disorders</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAF'">Journal of accounting, auditing &amp; finance</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAG'">Journal of applied gerontology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAH'">Journal of aging and health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAP'">Journal of the American Psychiatric Nurses Association</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAR'">Journal of adolescent research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAS'">Journal of Asian and African studies (Leiden)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JAX'">Journal of applied social science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBA'">Journal of biomaterials applications</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBC'">Journal of bioactive and compatible polymers</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBD'">International journal of behavioral development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBP'">Journal of black psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBR'">Journal of biological rhythms</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBS'">Journal of black studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JBX'">Journal of biomolecular screening</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCA'">Journal of career assessment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCC'">Journal of cross-cultural psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCD'">Journal of career development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCE'">Journal of contemporary ethnography</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCH'">Journal of contemporary history</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCI'">The Journal of communication inquiry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCL'">Journal of Commonwealth literature</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCM'">Journal of composite materials</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCN'">Journal of child neurology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCR'">Conflict resolution</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCS'">Journal of classical sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JCX'">Journal of correctional health care</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDI'">International journal of discrimination and the law</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDM'">Journal of diagnostic medical sonography</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JDS'">Journal of developing societies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEA'">The Journal of early adolescence</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEB'">Journal of educational and behavioral statistics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JED'">The Journal of environment &amp; development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEG'">Journal for the education of the gifted</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEI'">Journal of early intervention</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEN'">Journal of building physics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JEP'">Journal of elastomers and plastics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JES'">Journal of european studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFE'">Journal of fire protection engineering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFH'">Journal of family history</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFI'">Journal of family issues</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFM'">Journal of feline medicine and surgery</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFN'">Journal of family nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JFS'">Journal of fire sciences</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JGM'">Journal of generic medicines</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JGP'">Journal of geriatric psychiatry and neurology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHH'">Journal of Hispanic higher education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHI'">Health informatics journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHL'">Journal of human lactation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHM'">Journal of health management. (New Delhi. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHN'">Journal of holistic nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHP'">Journal of humanistic psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHS'">Journal of hand surgery. European volume</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHT'">Journal of hospitality &amp; tourism research (Washington, D.C. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JHV'">Journal of Human Values (New Delhi)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIA'">Journal of the International Association of Providers of AIDS Care</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIC'">Journal of intensive care medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JID'">Journal of intellectual disabilities</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIL'">Journal of the Institution of Locomotive Engineers</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIM'">Journal of intelligent material systems and structures</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIR'">Journal of industrial relations</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIS'">Journal of information science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIT'">Journal of industrial textiles</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JIV'">Journal of interpersonal violence</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JLO'">Journal of leadership &amp; organizational studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JLS'">Journal of language and social psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMC'">Journalism &amp; mass communication educator</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMD'">Journal of marketing education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JME'">Journal of management education (Newbury Park, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMH'">American journal of men's health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMI'">Journal of management inquiry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMK'">Journal of macromarketing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMM'">Men and masculinities</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMO'">Journalism &amp; communication monographs</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMQ'">Journalism &amp; mass communication quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMS'">Journal of Mechanical Engineering Science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JMT'">Journal of music teacher education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JNT'">Journal for the study of the New Testament</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOA'">Journal of advanced academics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOB'">Journal of business communication (1973)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOC'">Journal of consumer culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOD'">Journal of drug issues</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOE'">Journal of Entrepreneurship</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOI'">Journal of infrastructure development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOM'">Journal of management</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOP'">Journal of psychopharmacology (Oxford)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOS'">Journal of sociology (South Melbourne. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOT'">Journal for the study of the Old Testament</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JOU'">Journalism (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPA'">Journal of psychoeducational assessment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPE'">Journal of planning education and research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPF'">Journal of plastic film &amp; sheeting</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPH'">Journal of planning history</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPL'">Journal of planning literature</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPO'">Journal of pediatric oncology nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPP'">Journal of pharmacy practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JPR'">Journal of peace research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRC'">Journal of research in crime and delinquency</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRI'">Journal of research in international education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRM'">Journal of research in music education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRN'">Journal of research in nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JRP'">Journal of reinforced plastics and composites</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSA'">Journal of social archaeology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSD'">Journal of education for sustainable development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSE'">Journal of sports economics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSI'">Journal of studies in international education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSM'">The journal of sandwich structures &amp; materials</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSP'">Journal for the study of the pseudepigrapha</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSR'">Journal of service research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSS'">Journal of sport and social issues</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JSW'">Journal of social work</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTC'">Journal of thermoplastic composite materials</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTD'">Journal of transformative education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTE'">Journal of teacher education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTP'">Journal of theoretical politics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JTR'">Journal of travel research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JUH'">Journal of urban history</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JVC'">Journal of vibration and control</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='JVM'">Journal of vacation marketing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAL'">Language and literature (Harlow)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAP'">Latin American perspectives</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LAS'">Language and speech</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LCH'">Law, culture and the humanities</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LDQ'">Learning disability quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LDX'">Journal of learning disabilities</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LEA'">Leadership (London. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LEC'">Local economy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LIS'">Journal of librarianship and information science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LRT'">Lighting research and technology (2001. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LSJ'">Labor studies journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LTJ'">Language testing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LTR'">Language teaching research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='LUP'">Lupus (Basingstoke)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MAR'">Margin - the journal of applied economic research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCQ'">Management communication quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCR'">Medical care research and review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCS'">Media, culture &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCU'">Journal of material culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MCX'">Modern China</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MDM'">Medical decision making</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MEC'">Measurement and evaluation in counseling and development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MEJ'">Music educators journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MHJ'">The Medieval History Journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MIE'">Management in education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MIL'">Millennium</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLI'">Medical law international</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLQ'">Management learning</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MLS'">Management and labour studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMD'">Music and medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMJ'">Journal of medical marketing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMR'">Journal of mixed methods research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MMS'">Mathematics and mechanics of solids</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSJ'">Multiple sclerosis</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSS'">Memory studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MSX'">Musicae scientiae</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MTQ'">Marketing theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='MWC'">Media, war &amp; conflict</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NAH'">Nutrition and health (Berkhamstead)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NCP'">Nutrition in clinical practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NEJ'">Nursing ethics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NER'">National Institute economic review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NMS'">New media &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NNR'">Neurorehabilitation and neural repair</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NRO'">The Neuroscientist (Baltimore, Md.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NSQ'">Nursing science quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='NVS'">Nonprofit and voluntary sector quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OAE'">Organization &amp; environment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OPP'">Journal of oncology pharmacy practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ORG'">Organization (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ORM'">Organizational research methods</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='OSS'">Organization studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAA'">Pacifica (Brunswick)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAD'">Proceedings of the Institution of Mechanical Engineers, Automobile Division</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAS'">Politics &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PAU'">Proceedings - Institution of Automobile Engineers; London</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PBI'">Journal of positive behavior interventions</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PCP'">Proceedings of the Institution of Mechanical Engineers Conference Proceedings Volumes 178-184</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PDS'">Psychology and developing societies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PED'">Global health promotion</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PEN'">JPEN. Journal of parenteral and enteral nutrition</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PFR'">Public finance review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIA'">Progress in development studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIB'">Proceedings of the Institution of Mechanical Engineers. Part B: Journal of engineering manufacture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIC'">Proceedings of the Institution of Mechanical Engineers. Part C: Journal of mechanical engineering science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PID'">Proceedings of the Institution of Mechanical Engineers. Part D: Journal of automobile engineering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIE'">Proceedings of the Institution of Mechanical Engineers. Part E: Journal of process mechanical engineering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIF'">Proceedings of the Institution of Mechanical Engineers. Part F: Journal of rail and rapid transit</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIG'">Proceedings of the Institution of Mechanical Engineers. Part G: Journal of aerospace engineering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIH'">Proceedings of the Institution of Mechanical Engineers. Part H: Journal of engineering in medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PII'">Proceedings of the Institution of Mechanical Engineers. Part I: Journal of systems and control engineering</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIJ'">Proceedings of the Institution of Mechanical Engineers. Part J: Journal of engineering tribology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIK'">Proceedings of the Institution of Mechanical Engineers, Part K: Journal of Multi-body Dynamics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIL'">Proceedings of the Institution of Mechanical Engineers, Part L: Journal of Materials: Design and Applications</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIM'">Proceedings of the Institution of Mechanical Engineers, Part M: Journal of Engineering for the Maritime Environment</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIN'">Proceedings of the Institution of Mechanical Engineers, Part N: Journal of Nanoengineering and Nanosystems</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIO'">Proceedings of the Institution of Mechanical Engineers, Part O: Journal of Risk and Reliability</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PIP'">Proceedings of the Institution of Mechanical Engineers, Part P: Journal of Sports Engineering and Technology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PLT'">Planning theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PME'">Proceedings - Institution of Mechanical Engineers</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PMJ'">Palliative medicine</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PNZ'">Political science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='POM'">Psychology of music</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='POS'">Philosophy of the social sciences</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPA'">Public policy and administration</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPE'">Politics, philosophy &amp; economics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPG'">Progress in physical geography</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPN'">Policy, politics &amp; nursing practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPQ'">Party politics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PPS'">Perspectives on psychological science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PQX'">Police quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRB'">Probation journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRF'">Perfusion</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PRQ'">Political research quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSC'">Philosophy &amp; social criticism</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSP'">Personality &amp; social psychology bulletin</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSR'">Personality and social psychology review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PSS'">Psychological science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PTX'">Political theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PUN'">Punishment &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PUS'">Public understanding of science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PVS'">Perspectives in vascular surgery and endovascular therapy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PWM'">Public works management &amp; policy</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='PWQ'">Psychology of Women Quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QHR'">Qualitative health research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QIX'">Qualitative inquiry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QRJ'">Qualitative research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='QSW'">Qualitative social work</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RAC'">Race &amp; class</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RAS'">International review of administrative sciences</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RCB'">Rehabilitation counseling bulletin</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REA'">Research ethics review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REL'">RELC journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RER'">Review of educational research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='REV'">Review of human factors and ergonomics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RMI'">Review of market integration</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ROA'">Research on aging</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='ROP'">Review of public personnel administration</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RRE'">Review of research in education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RRP'">The Review of radical political economics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSH'">Perspectives in public health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSM'">Research studies in music education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSS'">Rationality and society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSW'">Research on social work practice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='RSX'">Reproductive sciences (Thousand Oaks, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAC'">Space and culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAD'">Journal of South Asian Development</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAE'">South Asia Economic Journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAG'">Simulation &amp; gaming</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAR'">South Asia research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAS'">South Asia survey</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SAX'">Sexual abuse</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCE'">Studies in Christian ethics</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCH'">Social change (New Delhi)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCP'">Social Compass</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCV'">Seminars in cardiothoracic and vascular anesthesia</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SCX'">Science communication</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SDI'">Security dialogue</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SDJ'">Progress in human geography</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SED'">The Journal of special education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SEX'">Sexualities (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SGR'">International journal of small group research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SHM'">Structural health monitoring</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SIH'">Studies in History</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SIM'">Transactions of the Society for Computer Simulation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SIR'">Studies in religion</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SJP'">Scandinavian journal of public health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLG'">State &amp; local government review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLR'">Second language research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SLS'">Social &amp; legal studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMJ'">Statistical modelling</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMM'">Statistical methods in medical research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMQ'">Social marketing quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMR'">Sociological methods &amp; research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SMX'">Sociological methodology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOC'">Sociology (Oxford. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOE'">Sociology of education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SOQ'">Strategic organization</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPA'">State politics &amp; policy quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPH'">Sports health (Thousand Oaks, CA)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPI'">School psychology international</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPQ'">Social psychology quarterly</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SPR'">Journal of social and personal relationships</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SRI'">Surgical innovation</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSC'">Social science computer review</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSI'">Information sur les sciences sociales (Paris)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='SSS'">Social studies of science</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STH'">Science, technology, &amp; human values</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STS'">Science, Technology and Society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='STX'">Sociological theory</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAB'">Therapeutic advances in musculoskeletal disease</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAG'">Therapeutic advances in gastroenterology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAK'">Therapeutic advances in cardiovascular disease</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAM'">Therapeutic advances in medical oncology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAN'">Therapeutic advances in neurological disorders</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAP'">Theory &amp; psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAR'">Therapeutic advances in respiratory disease</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAS'">Time &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TAU'">Therapeutic advances in urology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCN'">Journal of transcultural nursing</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCP'">The Counseling psychologist</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCR'">Theoretical criminology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TCS'">Theory, culture &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TDE'">The Diabetes educator</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TEC'">Topics in early childhood special education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TES'">Teacher education and special education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TFJ'">The Family journal (Alexandria, Va.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='THE'">Thesis eleven</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='THR'">Tourism and hospitality research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIA'">Trends in amplification</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIH'">Toxicology and industrial health</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TIM'">Transactions of the Institute of Measurement and Control</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TJX'">Theology (Norwich)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TMT'">Traumatology (Tallahassee, Fla. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TOP'">Teaching of psychology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TOU'">Tourist studies</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPA'">Teaching public administration</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPJ'">The Prison journal (Philadelphia, Pa.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TPS'">Transcultural psychiatry</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRA'">Trauma (London)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRE'">Theory and research in education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRJ'">Textile research journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRN'">Transformation (Exeter)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TRS'">Transfer (Brussels)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TSO'">Teaching sociology</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TTJ'">Theology today (Princeton, N.J.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TVA'">Trauma, violence &amp; abuse</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='TVN'">Television &amp; new media</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UAR'">Urban affairs review (Thousand Oaks, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UEX'">Urban education (Beverly Hills, Calif.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UIX'">Ultrasonic imaging</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='UPD'">Update: Applications of Research in Music Education</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='USJ'">Urban studies (Harlow. Print)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VAW'">Violence against women</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VCJ'">Visual communication</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VCU'">Journal of visual culture</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VES'">Vascular and endovascular surgery</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='VIS'">Vision (New Delhi)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WCX'">Written communication</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WES'">Work, employment and society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WIH'">War in history</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WJN'">Western journal of nursing research</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WOM'">Word of mouth (San Antonio, Tex.)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WOX'">Work and occupations</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='WPJ'">World policy journal</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YAS'">Youth &amp; society</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YEC'">Young exceptional children</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YJJ'">Youth justice</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YOU'">Young (Stockholm. 1993)</xsl:when>
<xsl:when test="normalize-space($codePublisherID1)='YVJ'">Youth violence and juvenile justice</xsl:when>
            <xsl:when test="//journal-id[@journal-id-type='isbn']='978-0-85404-169-5'"><title>Nanotechnologies in Food</title></xsl:when>
            <xsl:when test="//journal-id[@journal-id-type='isbn']='978-1-84755-916-6'"><title>Handbook of Culture Media for Food and Water Microbiology (3rd Edition)</title></xsl:when>
        </xsl:choose>
    </xsl:variable>
    <xsl:template
        match="fm/atl |article-title/title | ArticleTitle | article-title | atl | ce:title | art_title | article_title | nihms-submit/title | ArticleTitle/Title | ChapterTitle |wiley:chapterTitle | titlegrp/title | wiley:articleTitle | wiley:otherTitle | chaptl">
        <xsl:choose>
            <xsl:when test="ancestor::news-article/art-front/titlegrp">
                    <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0140-7007(01)00037-8'">
                <title level="a" type="main">A Word from the Director / Le mot du Directeur</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0923-5965(97)00056-8'">
                <title level="a" type="main">Foreword</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0377-8398(00)00009-8'">
                <title level="a" type="main">Introduction : Nannoplankton ecology and palaeoecology</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0012'">
                <title level="a" type="main">Book review : The Pacific Islands Food Composition Tables by C. A. Dignan, B. A. Burlingame, J. M. Arthur, R. J.
                    Quigley, and G. C. Milligan</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0165-1684(98)00205-9'">
                <title level="a" type="main">Editorial</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0013'">
                <title level="a" type="main">Book review : Fats and Fatty Acids in New Zealand Foods, by R. J. Quigley, B. A. Burlingame, G. C. Milligan, and
                    J. J. Gibson</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1006/jfca.1996.0014'">
                <title level="a" type="main">Book review : Quality and Accessibility of Food Related Data, by Heather Greenfield</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0142-9418(00)00029-5'">
                <title level="a" type="main">Editorial</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0168-9002(99)01283-8'">
                <title level="a" type="main">Index</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1053/smrv.1999.0085'">
                <title level="a" type="main">Table of contents</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S1049-3867(01)00088-3'">
                <title level="a" type="main">Erratum to 'An Intersection of
                    Women’s and Perinatal Health: The Role of Chronic Disease'</title>
            </xsl:when>
            <xsl:when test="//ce:doi='10.1016/S0009-2509(99)00312-7'">
                <title level="a" type="main">Erratum to 'Conversion-temperature trajectories for well mixed adsorptive
reactorsa'</title>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.)">
                    <title level="a" type="main">
                        <xsl:if test="@Language | @xml:lang">
                            <xsl:attribute name="xml:lang">
                                <xsl:choose>
                                    <xsl:when test="@Language='' or @xml:lang=''">
                                        <xsl:text>en</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="Varia2ISO639">
                                            <xsl:with-param name="code" select="@Language | @xml:lang"/>
                                        </xsl:call-template>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates/>
                    </title>
                    <xsl:if test="//ce:dochead/ce:textfn">
                        <title level="a" type="note">
                            <xsl:if test="@fn-type">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="@fn-type"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="@id">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="@id"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="//ce:dochead/ce:textfn"/>
                        </title>
                    </xsl:if>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- elsevier -->
    <xsl:template
        match="sb:title">
                <xsl:if test="normalize-space(sb:maintitle)">
                    <title level="a" type="main">
                        <xsl:if test="@Language | @xml:lang">
                            <xsl:attribute name="xml:lang">
                                <xsl:choose>
                                    <xsl:when test="@Language='' or @xml:lang=''">
                                        <xsl:text>en</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="Varia2ISO639">
                                            <xsl:with-param name="code" select="@Language | @xml:lang"/>
                                        </xsl:call-template>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates select="sb:maintitle"/>
                    </title>
                </xsl:if>
        <xsl:if test="normalize-space(sb:subtitle)">
            <title level="a" type="sub">
                <xsl:if test="@Language | @xml:lang">
                    <xsl:attribute name="xml:lang">
                        <xsl:choose>
                            <xsl:when test="@Language='' or @xml:lang=''">
                                <xsl:text>en</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="Varia2ISO639">
                                    <xsl:with-param name="code" select="@Language | @xml:lang"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="sb:subtitle"/>
            </title>
        </xsl:if>
    </xsl:template>
    <xsl:template match="sb:subtitle">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- EDP - trans-title-group -->
    <xsl:template
        match="trans-title-group">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="alt">
                <xsl:if test="@xml:lang">
                    <xsl:attribute name="xml:lang">
                        <xsl:choose>
                            <xsl:when test="@xml:lang=''">
                                <xsl:text>en</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="Varia2ISO639">
                                    <xsl:with-param name="code" select="@xml:lang"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="trans-title"/>
            </title>
        </xsl:if>
    </xsl:template>
    <!--SG - <topic> dans titre remplacé par <hi>-->
    <xsl:template match="atl/topic">
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <!-- BMJ: short-title -->
    <xsl:template match="short-title">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="short">
                <xsl:if test="@Language">
                    <xsl:attribute name="xml:lang">
                        <xsl:call-template name="Varia2ISO639">
                            <xsl:with-param name="code" select="@Language"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="subtitle | article_sub_title|art_stitle">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="sub">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    <!-- EDP trans-title -->
    <xsl:template match="trans-title">
                <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="vernacular_title">
        <xsl:if test="normalize-space(.)">
            <title level="a" type="vernacular">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="alt-title">
        <title level="a" type="{@alt-title-type}">
            <xsl:choose>
                <xsl:when test="@alt-title-type">
                    <xsl:attribute name="type">
                        <xsl:value-of select="@alt-title-type"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="type">
                        <xsl:text>alt</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <!-- Elements for general Journal components in ScholarOne (full_journal_title, journal_abbreviation) -->
    <!-- Elements for general Journal components in ArticleSetNLM 2.0 (JournalTitle, Issn) -->
    <!-- NLM 2.3 article: journal-title, journal-id, abbrev-journal-title -->
    <!-- Elements for general Journal components in SAGE (jrn_title, ISSN) -->
    <!-- Elements for general Journal components in Springer Stage2 (JournalTitle) -->
    <!-- Nature: journal-title -->
    <!-- Elsevier: els1:jid |els2:jid, ce:issn -->

    <xsl:template match="j-title | JournalTitle | full_journal_title | jrn_title | journal-title | tei:cell[@role='Journal'] | journalcit/title | jtl | wiley:journalTitle">
        <xsl:choose>
            <!-- SAGE - traitement des titres de journaux non verbalisés -->
            <xsl:when test="normalize-space(.)">
                <xsl:choose>
                    <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                        <title level="m" type="main">
                            <xsl:apply-templates/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//article-meta/isbn[string-length() &gt; 0] |//journal-meta/isbn[string-length() &gt; 0] and //journal-meta/issn">
                        <title level="m" type="main">
                            <xsl:apply-templates/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//journal-meta/issn[@pub-type='isbn'][string-length() &gt; 0] and contains(//journal-meta/issn/@pub-type,'pub')[string-length() &gt; 0]">
                        <title level="m" type="main">
                            <xsl:apply-templates/>
                        </title>
                    </xsl:when>
                    <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                        <title level="m" type="main">
                            <xsl:apply-templates/>
                        </title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title level="j" type="main">
                            <xsl:apply-templates/>
                        </title>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$SageJournalTitle">
                    <title level="j" type="main">
                        <xsl:value-of select="$SageJournalTitle"/>
                    </title>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="suppttl">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="sub">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout des refs book -->
    <xsl:template
        match="wiley:bookTitle">
        <xsl:if test="normalize-space(.)">
            <title level="m" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout des refs series -->
    <xsl:template
        match="wiley:bookSeriesTitle">
        <xsl:if test="normalize-space(.)">
            <title level="s" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="btl">
        <xsl:if test="normalize-space(.)">
            <title level="m" type="main">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <!-- Additional journal namings -->

    <xsl:template match="journal_abbreviation | abbrev-journal-title | els1:jid| els2:jid | JournalShortTitle | j-shorttitle|JournalAbbreviatedTitle">
        <xsl:if test="normalize-space(.)">
            <xsl:choose>
                <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                    <title level="m" type="abbrev">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//article-meta/isbn[string-length() &gt; 0] |//journal-meta/isbn[string-length() &gt; 0] and //journal-meta/issn">
                    <title level="m" type="abbrev">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//journal-meta/issn[@pub-type='isbn'][string-length() &gt; 0] and contains(//journal-meta/issn/@pub-type,'pub')[string-length() &gt; 0]">
                    <title level="m" type="abbrev">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                    <title level="m" type="abbrev">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:otherwise>
                    <title level="j" type="abbrev">
                        <xsl:apply-templates/>
                    </title>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="pubmed_abbreviation">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="pubmed">
                <xsl:value-of select="normalize-space()"/>
            </title>
        </xsl:if>
    </xsl:template>

    <xsl:template match="journal-id">
        <xsl:if test="normalize-space(.) and @journal-id-type!='isbn'">
            <idno type="{@journal-id-type}">
                <xsl:apply-templates/>
            </idno>
        </xsl:if>
    </xsl:template>

    <xsl:template match="j-edpsname | JournalEDPSName">
        <xsl:if test="normalize-space(.)">
            <title level="j" type="EDPSName">
                <xsl:apply-templates/>
            </title>
        </xsl:if>
    </xsl:template>

    <!-- Issue titles -->
    <xsl:template match="issue_description | issue-title | IssueTitle">
        <xsl:if test="normalize-space(.)">
            <xsl:choose>
                <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and //publicationMeta/issn">
                    <title level="m" type="issue">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//article-meta/isbn[string-length() &gt; 0] |//journal-meta/isbn[string-length() &gt; 0] and //journal-meta/issn">
                    <title level="m" type="issue">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//journal-meta/issn[@pub-type='isbn'][string-length() &gt; 0] and contains(//journal-meta/issn/@pub-type,'pub')[string-length() &gt; 0]">
                    <title level="m" type="issue">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:when test="//publicationMeta/isbn[string-length() &gt; 0] and not(//publicationMeta/issn)">
                    <title level="m" type="issue">
                        <xsl:apply-templates/>
                    </title>
                </xsl:when>
                <xsl:otherwise>
                    <title level="j" type="issue">
                        <xsl:apply-templates/>
                    </title>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- ISSN numbers -->
    <!-- Nature issn/@pub-type -->
    <!-- BMJ: issn/@issn_type -->
    <!-- NLM 2.3 article: issn -->
    <!-- Elsevier: ce:issn -->
    <!-- Rem.: @pub-typr not considered -->

    <xsl:template match="Issn | ISSN | issn | ce:issn">
        <xsl:choose>
            <xsl:when test="normalize-space(.)">
            <xsl:variable name="ISSNCode">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>ISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>
            <idno type="ISSN">
                <xsl:choose>
                    <xsl:when test="$ISSNCode or normalize-space(.)">
                        <xsl:value-of select="$ISSNCode"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- SAGE - ajout des issns -->
                        <xsl:value-of select="$repriseISSNCode"/>
                        <xsl:value-of select="$REPRISEeISSNCode"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$repriseISSNCode or $REPRISEeISSNCode">
                <idno type="pISSN">
                    <!-- SAGE - ajout des pissns -->
                    <xsl:value-of select="$repriseISSNCode"/>
                </idno>
                <idno type="eISSN">
                    <!-- SAGE - ajout des eissns -->
                    <xsl:value-of select="$REPRISEeISSNCode"/>
                </idno>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template
        match="JournalPrintISSN | issn[@issn_type='print'][string-length()&gt;0] | issn[@pub-type='ppub'][string-length()&gt;0] | PrintISSN | issn-paper | SeriesPrintISSN | issn[@type='print'] | wiley:issn[@type='print'] ">
        <xsl:variable name="ISSNCode">
            <xsl:choose>
                <!-- BMJ -->
                <xsl:when test="//journal-meta/journal-title='Association Medical Journal'">2041-9996</xsl:when>
                <xsl:when test="//journal-meta/journal-title='London journal of medicine'">2041-9988</xsl:when>
                <xsl:when test="normalize-space(.)">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$repriseISSNCode"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
            <!-- Vieux morceau de code du projet PEER où l'on vérifiait dans une liste de journaux... -->
            <!--<xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>pISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>-->
            <idno type="pISSN">
                <xsl:value-of select="$ISSNCode"/>
            </idno>
    </xsl:template>

    <xsl:template match="JournalElectronicISSN | ElectronicISSN | issn[@issn_type='digital'] | issn[@pub-type='epub'] | issn-elec | SeriesElectronicISSN | issn[@type='electronic'] | wiley:issn[@type='electronic']|E-ISSN">
        <xsl:variable name="ISSNCode">
            <xsl:if test="normalize-space(.)">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:if>
        </xsl:variable>
            <!-- Vieux morceau de code du projet PEER où l'on vérifiait dans une liste de journaux... -->
            <!--<xsl:variable name="journalEntry"
                select="$journalList/descendant::tei:row[tei:cell/text()=$ISSNCode]"/>
            <xsl:message>eISSN: <xsl:value-of select="$ISSNCode"/></xsl:message>
            <xsl:message>Journal: <xsl:value-of select="$journalEntry/tei:cell[@role='Journal']"
                /></xsl:message>-->
            <idno type="eISSN">
                <xsl:value-of select="$ISSNCode"/>
            </idno>
    </xsl:template>
    <xsl:template
        match="journal-id[@journal-id-type='isbn'][string-length()&gt;0]|//ISBN[string-length()&gt;0]|//isbn[string-length()&gt;0]">
        <xsl:choose>
            <xsl:when test="@content-type='epub'">
                <idno type="eISBN">
                    <xsl:value-of select="."/>
                </idno>
            </xsl:when>
            <xsl:otherwise>
                <idno type="ISBN">
                    <xsl:value-of select="."/>
                </idno>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <!-- SG - ajout DOI niveau book - pour matcher avec les reversement du Hub de métadonnées-->
    <xsl:template match="wiley:publicationMeta[@level='product']/wiley:doi">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="DOIValue" select="string(.)"/>
            <idno type="book-DOI">
                <xsl:choose>
                    <xsl:when test=" starts-with($DOIValue,'DOI')">
                        <xsl:value-of select="normalize-space( substring-after($DOIValue,'DOI'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($DOIValue)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout DOI niveau book-part-->
    <xsl:template match="wiley:publicationMeta[@level='part']/wiley:doi">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="DOIValue" select="string(.)"/>
            <idno type="book-part-DOI">
                <xsl:choose>
                    <xsl:when test=" starts-with($DOIValue,'DOI')">
                        <xsl:value-of select="normalize-space( substring-after($DOIValue,'DOI'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($DOIValue)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
        </xsl:if>
    </xsl:template>
    
    <!-- SG - ajout identifiants de production-->
    <xsl:template match="wiley:publicationMeta[@level='product']/wiley:idGroup/wiley:id">
            <idno>
                <xsl:attribute name="type">
                    <xsl:apply-templates select="@type"/>
                </xsl:attribute>
                <xsl:apply-templates select="@value"/>
            </idno>
    </xsl:template>
    
    <!-- DOI numbers -->
    <!-- BMJ: doi -->
    <!-- Elsevier: ce:doi -->
    <!-- NLM 2.3 article: article-id[@pub-id-type='doi'] -->

    <xsl:template
        match="article_id[@id_type='doi'] | article-id[@pub-id-type='doi'] | ArticleDOI | doi | ArticleId[@IdType='doi'] | ce:doi | @doi | DOI | ChapterDOI | wiley:publicationMeta[@level='unit']/wiley:doi">
        <xsl:if test="normalize-space(.)">
            <xsl:variable name="DOIValue" select="string(.)"/>
            <idno type="DOI">
                <xsl:choose>
                    <xsl:when test=" starts-with($DOIValue,'DOI')">
                        <xsl:value-of select="normalize-space( substring-after($DOIValue,'DOI'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($DOIValue)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </idno>
        </xsl:if>
    </xsl:template>
    <xsl:template
        match="ms-id">
        <xsl:if test="normalize-space(.)">
            <idno type="ms-id">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
        </xsl:if>
    </xsl:template>
    <xsl:template match="wiley:publicationMeta[@level='unit']/wiley:idGroup/wiley:id">
            <idno>
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:value-of select="@value"/>
            </idno>
    </xsl:template>
    <xsl:template match="wiley:publicationMeta[@level='unit']/wiley:linkGroup/wiley:link">
        <idno>
            <xsl:attribute name="type">
                <xsl:apply-templates select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="@href"/>
        </idno>
    </xsl:template>

    <!-- pii -->
    <!-- Elsevier: ce:pii -->
    <!-- Scholar one: article_id[@id_type='pii'] -->
    <!-- NLM 2.2:  article-id[@pub-id-type='pii'] -->


    <xsl:template
        match="ce:pii | article_id[@id_type='pii'] | article-id[@pub-id-type='pii'] | ArticleId[@IdType='pii']">
        <xsl:if test="normalize-space(.)">
            <idno type="PII">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- Manuscript number -->
    <!-- BMJ: manuscript-number; Springer: ArticleID -->

    <xsl:template match="manuscript-number | @ms_no | ArticleID ">
        <xsl:if test="normalize-space(.)">
            <idno type="manuscript">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- Publisher IDs when different from above -->
    <!-- NLM 2.2: article-id[@pub-id-type='publisher-id'] -->

    <xsl:template match="els1:aid  |els2:aid  | EDPSRef | edps-ref | Article/@ID">
        <xsl:if test="normalize-space(.) and not(//publisher-name = 'Cambridge University Press')">
            <idno type="publisher-id">
                <xsl:value-of select="."/>
            </idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="article/@id">
        <xsl:if test="normalize-space(.) and //cpn = 'Nature Publishing Group'">
            <idno type="article-id">
                <xsl:value-of select="."/>
            </idno>
        </xsl:if>
    </xsl:template>

    <!-- Elements for Imprint components in ScholarOne (volume, issue) -->
    <!-- Elements for Imprint components in ArticleSetNLM 2.0 (Volume, Issue, FirstPage, LastPage) -->
    <!-- NLM 2.3 article: volume, issue, fpage, lpage -->
    <!-- Elements for Imprint components in SAGE (vol, iss, spn, epn) -->
    <!-- Elements for Imprint components in Springer Stage 2 (VolumeID, IssueID, FirstPage, LastPage) -->
    <!-- Elements for Imprint components in Springer Stage 3 (ArticleFirstPage, ArticleLastPage) -->
    <!-- Elements for Imprint components in BMJ (issue-number, volume) -->
    <!-- Elements for Imprint components in Elsevier () -->
    
    <xsl:template match="vol | Volume | VolumeID | volume | volumeref | volumeno | sb:volume-nr | vid | wiley:numbering[@type='journalVolume'] | wiley:vol">
        <xsl:choose>
            <xsl:when test="ancestor::p/citation | ancestor::p/mixed-citation |ancestor::p">
                <bibl>
                    <biblScope unit="vol">
                        <xsl:apply-templates/>
                    </biblScope>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="normalize-space(.) and ancestor::bold">
                            <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="normalize-space(.)">
                        <biblScope unit="vol">
                            <xsl:value-of select="normalize-space(.)"/>
                        </biblScope>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cd">
        <xsl:choose>
            <xsl:when test="ancestor::p/citation | ancestor::p/mixed-citation |ancestor::p">
                <bibl>
                    <date when="{.}">
                        <xsl:apply-templates/>
                    </date>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.)">
                    <date when="{.}">
                        <xsl:apply-templates/>
                    </date>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- 2 special rules for Springer that provides, beginning and end volume number -->

    <xsl:template match="VolumeIDStart">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="vol" from="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <xsl:template match="VolumeIDEnd">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="vol" to="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>


    <!-- Rule for RCS data -->
    <xsl:template match="volumeref/link">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="iid | iss | Issue | issue | issue-number | IssueID | issueref | wiley:numbering[@type='journalIssue'] | wiley:issue">
        <xsl:choose>
            <xsl:when test="ancestor::p/citation | ancestor::p/mixed-citation">
                <bibl>
                    <biblScope unit="issue">
                        <xsl:apply-templates/>
                    </biblScope>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.)">
                    <biblScope unit="issue">
                        <xsl:value-of select="normalize-space(.)"/>
                    </biblScope>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- 2 special rules for Springer that provides, beginning and end volume number -->

    <xsl:template match="IssueIDStart">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="issue" from="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <xsl:template match="IssueIDEnd">
        <xsl:if test="normalize-space(.)">
            <biblScope unit="issue" to="{normalize-space(.)}">
                <xsl:apply-templates/>
            </biblScope>
        </xsl:if>
    </xsl:template>

    <!-- Rule for RCS data -->
    <xsl:template match="issueref/link">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- we do not consider the number of issues in a volume (Springer <Publisher>) -->

    <xsl:template match="VolumeIssueCount"/>
    
    <xsl:template match="BookVolumeNumber">
        <biblScope unit="vol">
        <xsl:apply-templates/>
        </biblScope>
    </xsl:template>

    <!-- Pagination -->

    <xsl:template match="spn | FirstPage | ArticleFirstPage | fpage | first-page | sb:first-page | ChapterFirstPage | ppf | wiley:numbering[@type='pageFirst'] | wiley:pageFirst">
        <xsl:choose>
            <xsl:when test="ancestor::p/citation | ancestor::p/mixed-citation |ancestor::product/. |ancestor::p">
                <bibl>
                    <biblScope unit="page" from="{normalize-space(.)}">
                        <xsl:value-of select="normalize-space(.)"/>
                    </biblScope>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.) and not(contains(.,'n/a'))">
                    <biblScope unit="page" from="{translate(.,' ','')}">
                        <xsl:value-of select="normalize-space(.)"/>
                    </biblScope>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- SG: nettoyage caractéres polluants dans les données -->
    <xsl:template match="epn | LastPage | ArticleLastPage | lpage | last-page | ChapterLastPage | sb:last-page | ppl | wiley:numbering[@type='pageLast'] | wiley:pageLast">
        <xsl:choose>
            <xsl:when test="ancestor::p/citation | ancestor::p/mixed-citation |ancestor::p">
                <bibl>
                    <biblScope unit="page" to="{translate(.,'normalize-space(.)','')}">
                        <xsl:value-of select="translate(.,'normalize-space(.)','')"/>
                    </biblScope>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.) and not(contains(.,'n/a'))">
                    <biblScope unit="page" to="{translate(.,' ','')}">
                        <xsl:value-of select="translate(.,' ','')"/>
                    </biblScope>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="BookChapterCount">
            <biblScope unit="chapter-count">
                <xsl:apply-templates/>
            </biblScope>
    </xsl:template>
    <xsl:template match="PartChapterCount">
        <biblScope unit="part-chapter-count">
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    
    <!--SG - ajout nombre de pages -->
    <xsl:template match="wiley:count[@type='pageTotal']">
        <xsl:if test="normalize-space(@number)">
            <biblScope unit="page-count">
                <xsl:value-of select="@number"/>
            </biblScope>
        </xsl:if>
    </xsl:template>
    
    <!-- Publishers -->
    <!-- NLM V2.0: PublisherName -->
    <!-- NLM V2.3 article: publisher-loc, publisher-name  -->
    <!-- BMJ: publisher_name ??????, publisher-loc -->
    <!-- ScholarOne: publisher_name -->
    <!-- Sage: pub_name, pub_location -->
    <!-- Springer: PublisherName, PublisherLocation -->

    <xsl:template
        match="PublisherName | publisher_name | pub_name | publisher-name | tei:cell[@role='Publisher'] | wiley:publisherName |publisher/orgname/nameelt">
        <xsl:choose>
            <xsl:when test="ancestor::p/.">
                <bibl>
                <publisher>
                    <xsl:apply-templates/>
                </publisher>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.)">
                    <publisher>
                        <xsl:apply-templates/>
                    </publisher>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="publisher-name" mode="conf">
        <respStmt>
            <resp>Programme Organizer</resp>
            <name>
                <xsl:apply-templates/>
            </name>
        </respStmt>
    </xsl:template>

    <xsl:template match="publisher-loc | pub_location | PublisherLocation | wiley:publisherLoc">
        <xsl:choose>
            <xsl:when test="ancestor::p/.">
                <bibl>
                    <pubPlace>
                        <xsl:apply-templates/>
                    </pubPlace>
                </bibl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space(.)">
                    <pubPlace>
                        <xsl:apply-templates/>
                    </pubPlace>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="reftxt/cd">
        <date>
            <xsl:attribute name="when">
                <!-- SG reprise de la date (ex:nrn3258_subject.xml)(26 Aug  2011)
                cibler sur attribut @year et non plus sur le text() + PL: cleaning of alphabetical characters in the year string -->
                    <!--xsl:apply-templates select="@year"/-->
					<xsl:value-of select="replace(@year, '[a-zA-Z]', '')"/>
			</xsl:attribute> 
        </date>
    </xsl:template>
	
    <!-- SG: nettoyage caractéres polluants dans les données -->
    <xsl:template match="wiley:pubYear">
        <date>
            <xsl:attribute name="when">
                <xsl:choose>
                    <xsl:when test="@year">
                            <xsl:value-of select="translate(@year,',.[a-zA-Z]','')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="translate(.,',.[a-zA-Z]','')"/>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:attribute>
        </date>
    </xsl:template>
	<!-- conference -->
    <xsl:template match="ConferenceInfo">
        <meeting>
            <xsl:apply-templates select="ConfSeriesName"/>
            <xsl:apply-templates select="ConfEventAbbreviation"/>
            <xsl:apply-templates select="ConfNumber"/>
            <xsl:apply-templates select="ConfSeriesID"/>
            <xsl:apply-templates select="ConfEventID"/>
            <xsl:apply-templates select="ConfEventLocation"/>
            <xsl:if test="ConfEventDateStart |ConfEventDateEnd">
                <date>
                    <xsl:attribute name="from">
                        <xsl:apply-templates select="ConfEventDateStart"/>
                    </xsl:attribute>
                    <xsl:attribute name="to">
                        <xsl:apply-templates select="ConfEventDateEnd"/>
                    </xsl:attribute>
                </date>
            </xsl:if>
        </meeting>
    </xsl:template>
    <xsl:template match="ConfSeriesName">
        <title type="name">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="ConfEventAbbreviation">
        <title type="abbr">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="ConfNumber">
        <idno type="conf-number">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <xsl:template match="ConfEventID">
        <idno type="conf-ID">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <xsl:template match="ConfSeriesID">
        <idno type="{@Type}">
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <xsl:template match="ConfEventLocation">
        <xsl:if test="City">
            <settlement><xsl:value-of select="City"/></settlement>
        </xsl:if>
        <xsl:if test="Country">
            <country><xsl:value-of select="Country"/></country>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ConfEventDateStart">
        <xsl:value-of select="concat(Year,(format-number(Month,'00')),(format-number(Day,'00')))"/>
    </xsl:template>
    <xsl:template match="ConfEventDateEnd">
        <xsl:value-of select="concat(Year,(format-number(Month,'00')),(format-number(Day,'00')))"/>
    </xsl:template>
</xsl:stylesheet>
