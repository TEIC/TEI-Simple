<?xml version="1.0" encoding="utf-8"?>
<XSL:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#"
		xmlns:xsl="http://www.w3.org/1999/XSL/TransformAlias"
		xmlns:n="www.example.com"
		xmlns:rng="http://relaxng.org/ns/structure/1.0"
		xmlns:XSL="http://www.w3.org/1999/XSL/Transform"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="XSL xsl skos rng tei n" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <XSL:output indent="yes"/>
<XSL:namespace-alias stylesheet-prefix="xsl" result-prefix="XSL"/>
  <XSL:template match="/">
    <XSL:result-document href="elementsummary.xml">
      <div>
        <head>Summary of Simple</head>
        <!--
1. element	
2. eebo	
3. Tite	
4. TEI Lite	
5 .OTAnrs	
6. OTA	
7. DTAnrs	
8. dta	
9. use	
10. group	
11. action
-->
        <p>A total of <XSL:value-of select="count(//row[  position()&gt;1   and not(cell[1]='')   and not(cell[10] = 'header')  and not(cell[10] = 'headeronly')  and not(cell[10] = 'no') ])"/> elements are selected for use in
	the <gi>text</gi> part of a document.</p>
        <XSL:variable name="corpses" select="distinct-values(doc('count.xml')//elementRef/@corpus)"/>
        <table>
          <row role="label">
            <cell>Element</cell>
            <XSL:for-each select="$corpses">
              <cell>
                <XSL:value-of select="."/>
              </cell>
            </XSL:for-each>
            <cell>Use</cell>
            <cell>Action</cell>
          </row>
          <XSL:for-each select="//row[position()&gt;1 and not(cell[1]='')]">
            <XSL:sort select="cell[1]"/>
            <row>
              <XSL:variable name="e" select="normalize-space(cell[1])"/>
              <cell>
                <XSL:value-of select="$e"/>
              </cell>
              <XSL:for-each select="$corpses">
                <XSL:variable name="c" select="."/>
                <cell>
                  <XSL:value-of select="sum(doc('count.xml')//elementRef[@key=$e     and @corpus=$c]/@count)"/>
                </cell>
              </XSL:for-each>
              <XSL:copy-of select="cell[9]"/>
              <XSL:copy-of select="cell[10]"/>
            </row>
          </XSL:for-each>
        </table>
        <list type="gloss">
          <XSL:for-each-group select="//row[position()&gt;1 and      not(cell[1]='')]" group-by="normalize-space(cell[10])">
            <XSL:sort select="normalize-space(cell[10])"/>
            <XSL:sort select="cell[1]"/>
            <XSL:choose>
              <XSL:when test="current-grouping-key()='header'"/>
              <XSL:when test="current-grouping-key()='headeronly'"/>
              <XSL:when test="current-grouping-key()='no'"/>
              <XSL:otherwise>
                <label>
                  <XSL:value-of select="current-grouping-key()"/>
                </label>
                <item>
                  <XSL:for-each select="current-group()">
                    <gi>
                      <XSL:value-of select="normalize-space(cell[1])"/>
                    </gi>
                    <XSL:text> </XSL:text>
                  </XSL:for-each>
                </item>
              </XSL:otherwise>
            </XSL:choose>
          </XSL:for-each-group>
        </list>
      </div>
    </XSL:result-document>
    <XSL:result-document href="simpleelements.xml">
      <specGrp xml:id="simpleelements">
	<XSL:for-each select="//row[position()&gt;1 and not(cell[1]='')]">
        <XSL:choose>
          <XSL:when test="contains(cell[9],'header')"/>
          <XSL:when test="contains(cell[11],'KILL')"/>
          <XSL:when test="contains(cell[11],'merge')"/>
          <XSL:otherwise>
            <elementRef key="{normalize-space(cell[1])}"/>
          </XSL:otherwise>
        </XSL:choose>
	</XSL:for-each>
      </specGrp>
    </XSL:result-document>

    <XSL:result-document href="mapatts.xsl">
      
      <xsl:stylesheet version="2.0">
	<xsl:template match="@rend">
          <xsl:if test="not(../@rendition)">
            <xsl:attribute name="rendition">
	      <xsl:choose>
		<XSL:for-each
		    select="doc('teisimple.odd')//skos:exactMatch">
		  <xsl:when>
		    <XSL:attribute name="test">
		      <XSL:text>.='</XSL:text>
		      <XSL:value-of select="."/>
		      <XSL:text>'</XSL:text>
		    </XSL:attribute>
		      <XSL:text>simple:</XSL:text>
		    <XSL:value-of select="parent::valItem/@ident"/>
		  </xsl:when>
		</XSL:for-each>
	      </xsl:choose>
	      <xsl:for-each select="tokenize(.,' ')">
		<xsl:text>simple:</xsl:text>
		<xsl:value-of select="."/>
		<xsl:if test="position()!=last()">
		  <xsl:text> </xsl:text>
		</xsl:if>
	      </xsl:for-each>
            </xsl:attribute>
          </xsl:if>
	</xsl:template>
      </xsl:stylesheet>
    </XSL:result-document>

  </XSL:template>
</XSL:stylesheet>

