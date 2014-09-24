<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n="www.example.com"
  xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="rng tei n"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

<xsl:output indent="yes"/>

<xsl:template match="/">
<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="en">
   <teiHeader>
      <fileDesc>
         <titleStmt>
            <title>TEI Simple</title>
         </titleStmt>
         <publicationStmt>
            <p/>
         </publicationStmt>
         <sourceDesc>
            <p></p>
         </sourceDesc>
      </fileDesc>
   </teiHeader>
   <text>
      <body>
	<list type="gloss">
	    <xsl:for-each-group select="//row[position()&gt;1 and
					not(cell[1]='')]"
				group-by="normalize-space(cell[10])">
	      <xsl:sort select="cell[1]"/>
	      <label><xsl:value-of
	      select="current-grouping-key()"/></label>
	      <item><xsl:value-of  select="current-group()/cell[1]"/></item>
	    </xsl:for-each-group>
	</list>
         <schemaSpec ident="oddbyexample" start="TEI teiCorpus">
            <moduleRef key="tei"/>
	    <classRef key="att.global.facs"/>
	    <classRef key="att.citing"/>
	    <classRef key="att.measurement"/>
	    <classRef key="att.milestoneUnit"/>
	    <classRef key="att.global.linking"/>
	    <classRef key="att.typed"/>
	    <elementRef key="teiHeader"/>
	    <elementSpec ident="teiHeader" mode="change">
	      <content mode="replace"/>
	    </elementSpec>
	    <xsl:for-each select="//row[position()&gt;1 and not(cell[1]='')]">
	      <xsl:choose>
	      <xsl:when test="contains(cell[9],'header')"/>
	      <xsl:when test="contains(cell[11],'KILL')"/>
	      <xsl:when test="contains(cell[11],'merge')"/>
	      <xsl:otherwise>
		<elementRef key="{normalize-space(cell[1])}"/>
	      </xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
         </schemaSpec>
      </body>
   </text>
</TEI>

</xsl:template>
</xsl:stylesheet>
