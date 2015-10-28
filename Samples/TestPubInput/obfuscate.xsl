<!-- A very basic XML content obfuscation for the public version of Pub2TEI -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output indent="yes"/>
 <xsl:variable name="abc">ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789</xsl:variable>
 <xsl:variable name="cba">NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm9876501234</xsl:variable>  
 
 <xsl:template match="@*|node()">
   <xsl:copy>
     <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text()">
  	<xsl:value-of select="translate(.,$abc,$cba)"/>
 </xsl:template>
 
</xsl:stylesheet>