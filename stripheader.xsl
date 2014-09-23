<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei"
    version="1.0">

  <xsl:template match="/">
    <xsl:copy-of select="/*/tei:text"/>
  </xsl:template>
  
</xsl:stylesheet>
