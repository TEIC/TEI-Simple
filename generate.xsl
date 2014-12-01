<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n="www.example.com" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="skos rng tei n" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <xsl:result-document href="elementsummary.xml">
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
        <p>A total of <xsl:value-of select="count(//row[  position()&gt;1   and not(cell[1]='')   and not(cell[10] = 'header')  and not(cell[10] = 'headeronly')  and not(cell[10] = 'no') ])"/> elements are selected for use in
	the <gi>text</gi> part of a document.</p>
        <xsl:variable name="corpses" select="distinct-values(doc('count.xml')//elementRef/@corpus)"/>
        <table>
          <row role="label">
            <cell>Element</cell>
            <xsl:for-each select="$corpses">
              <cell>
                <xsl:value-of select="."/>
              </cell>
            </xsl:for-each>
            <cell>Use</cell>
            <cell>Action</cell>
          </row>
          <xsl:for-each select="//row[position()&gt;1 and not(cell[1]='')]">
            <xsl:sort select="cell[1]"/>
            <row>
              <xsl:variable name="e" select="normalize-space(cell[1])"/>
              <cell>
                <xsl:value-of select="$e"/>
              </cell>
              <xsl:for-each select="$corpses">
                <xsl:variable name="c" select="."/>
                <cell>
                  <xsl:value-of select="sum(doc('count.xml')//elementRef[@key=$e     and @corpus=$c]/@count)"/>
                </cell>
              </xsl:for-each>
              <xsl:copy-of select="cell[9]"/>
              <xsl:copy-of select="cell[10]"/>
            </row>
          </xsl:for-each>
        </table>
        <list type="gloss">
          <xsl:for-each-group select="//row[position()&gt;1 and      not(cell[1]='')]" group-by="normalize-space(cell[10])">
            <xsl:sort select="normalize-space(cell[10])"/>
            <xsl:sort select="cell[1]"/>
            <xsl:choose>
              <xsl:when test="current-grouping-key()='header'"/>
              <xsl:when test="current-grouping-key()='headeronly'"/>
              <xsl:when test="current-grouping-key()='no'"/>
              <xsl:otherwise>
                <label>
                  <xsl:value-of select="current-grouping-key()"/>
                </label>
                <item>
                  <xsl:for-each select="current-group()">
                    <gi>
                      <xsl:value-of select="normalize-space(cell[1])"/>
                    </gi>
                    <xsl:text> </xsl:text>
                  </xsl:for-each>
                </item>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each-group>
        </list>
      </div>
    </xsl:result-document>
    <xsl:result-document href="simpleelements.xml">
      <specGrp xml:id="simpleelements">
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
    </xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
