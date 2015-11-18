<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:variable name="c">
  <xsl:for-each select="distinct-values(//elementRef/@corpus)">
    <n><xsl:value-of select="."/></n>
  </xsl:for-each>
</xsl:variable>

<xsl:text>""</xsl:text>
<xsl:for-each select="$c/*">
<xsl:text>,"</xsl:text>
<xsl:value-of select="."/>
<xsl:text>"</xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>

<xsl:for-each-group select="//elementRef" group-by="@key">
  <xsl:sort select="@key"/>
  <xsl:text>"</xsl:text>
  <xsl:value-of select="current-grouping-key()"/>
  <xsl:text>",</xsl:text>
  <xsl:variable name="current">
  <x>
    <xsl:copy-of select="current-group()"/>
  </x>
  </xsl:variable>
  
  <xsl:for-each select="$c/*">
    <xsl:variable name="this" select="."/>
    <xsl:value-of select="number(sum($current//*[@corpus=$this]/@count))" />
    <xsl:text>,</xsl:text>
  </xsl:for-each>
  <xsl:text>
</xsl:text>
</xsl:for-each-group>
</xsl:template>
</xsl:stylesheet>
