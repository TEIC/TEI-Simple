<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n="www.example.com"
		xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
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
	      <xsl:sort select="normalize-space(cell[10])"/>
	      <xsl:sort select="cell[1]"/>
	      <label><xsl:value-of
	      select="current-grouping-key()"/></label>
	      <item>
		<xsl:for-each select="current-group()">
		  <xsl:choose>
		    <xsl:when test="contains(cell[9],'header')"/>
		    <xsl:when test="contains(cell[11],'KILL')"/>
		    <xsl:when test="contains(cell[11],'merge')"/>
		    <xsl:otherwise>
		      <xsl:value-of
			  select="normalize-space(cell[1])"/>
		      <xsl:text> </xsl:text>
		    </xsl:otherwise>
		  </xsl:choose>
		</xsl:for-each>
	      </item>
	    </xsl:for-each-group>
	</list>

	    <specGrp xml:id="changes">

	      <classSpec ident="att.global.linking" mode="change">
		<attList>
		  <attDef ident="synch" mode="delete"/>
		  <attDef ident="sameAs" mode="delete"/>
		  <attDef ident="copyOf" mode="delete"/>
		  <attDef ident="next" mode="delete"/>
		  <attDef ident="prev" mode="delete"/>
		  <attDef ident="exclude" mode="delete"/>
		  <attDef ident="select" mode="delete"/>
	      </attList>
	      </classSpec>

	      <classSpec key="att.fragmentable">
		<attDef ident="part" mode="delete"/>
	      </classSpec>

	      <classSpec ident="att.global" mode="change">
		<attList>
		  <attDef ident="rend" mode="delete"/>
		  <attDef ident="style" mode="delete"/>
		  <attDef ident="rendition" mode="change">
		    <valList mode="add" type="semi">
		      <valItem ident="simple:bold"/>
		      <valItem ident="simple:italic"/>
		    </valList>
		    <constraintSpec ident="rendptr" scheme="isoschematron">
		      <constraint>
			<sch:rule context="tei:*[@rendition]">
			  <sch:assert test="starts-with(@rendition,'simple:')
					    or
					    (starts-with(@rendition,'#')
					    and //tei:rendition[@xml:id=substring(@rendition,2)])">
			    rendition attributes must point to a local
			    ID or to a token in the simple scheme</sch:assert>
			</sch:rule>
		      </constraint>
		    </constraintSpec>

		  </attDef>
		</attList>
	      </classSpec>
	    </specGrp>

	    <specGrp xml:id="transcr">
	      <!-- for sourcedoc and facsimile -->
	    <elementRef key="damage"/>
	    <elementRef key="damageSpan"/>
	    <elementRef key="facsimile"/>
	    <elementRef key="line"/>
	    <elementRef key="listTranspose"/>
	    <elementRef key="metamark"/>
	    <elementRef key="mod"/>
	    <elementRef key="redo"/>
	    <elementRef key="restore"/>
	    <elementRef key="retrace"/>
	    <elementRef key="sourceDoc"/>
	    <elementRef key="surface"/>
	    <elementRef key="surfaceGrp"/>
	    <elementRef key="surplus"/>
	    <elementRef key="transpose"/>
	    <elementRef key="undo"/>
	    <elementRef key="zone"/>
	    <classRef key="att.coordinated"/>
	    <classRef key="att.global.change"/>
	    </specGrp>

	    <specGrp xml:id="header">
            <moduleRef key="header"/>
	    <elementRef key="teiHeader"/>
	    <elementRef key="biblStruct"/>
	    <elementRef key="charDecl"/>
	    <elementRef key="glyph"/>
	    <elementRef key="monogr"/>
	    <elementRef key="imprint"/>
	    <elementRef key="resp"/>
	    <elementRef key="relatedItem"/>
	    <elementRef key="respStmt"/>
	    <!-- ban from text-->
	    <elementRef key="term"/>
	    <elementRef key="editor"/>
	    <elementRef key="email"/>
	    </specGrp>

	    <specGrp xml:id="atts">
	    <!-- attributes needed -->
	    <classRef key="att.global.facs"/>
	    <classRef key="att.citing"/>
	    <classRef key="att.measurement"/>
	    <classRef key="att.milestoneUnit"/>
	    <classRef key="att.pointing"/>
	    <classRef key="att.global.linking"/>
	    <classRef key="att.typed"/>
	    </specGrp>

	    <specGrp xml:id="simple">
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
	    </specGrp>

         <schemaSpec ident="oddbyexample" start="TEI teiCorpus">
           <moduleRef key="tei"/>
	   <specGrpRef target="#base"/>
	   <specGrpRef target="#header"/>
	   <specGrpRef target="#transcr"/>
	   <specGrpRef target="#atts"/>
	   <specGrpRef target="#simple"/>
	   <specGrpRef target="#changes"/>
         </schemaSpec>
      </body>
   </text>
</TEI>

</xsl:template>
</xsl:stylesheet>
