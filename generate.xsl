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
    <XSL:result-document href="headeronly.xml">
                  <constraintSpec ident="headeronlyelement" scheme="isoschematron">
                     <constraint>
                        <rule
			    xmlns="http://purl.oclc.org/dsdl/schematron">
			  <XSL:attribute name="context">
			    <XSL:value-of select="(//row[  position()&gt;1   and
						  not(cell[1]='')   and cell[10] = 'header']/cell[1])" separator="|&#10;"/>
			  </XSL:attribute>
                           <report test="ancestor::tei:text">Error:  The element <name/>
is not permitted outside the header</report>
                        </rule>
                     </constraint>
                  </constraintSpec>
    </XSL:result-document>
    <XSL:result-document href="elementsummary.xml">
      <div>
        <head>Summary</head>
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
        <p>A total of <XSL:value-of select="count(//row[  position()&gt;1   and not(cell[1]='')   and not(cell[10] = 'header')  and not(normalize-space(cell[10]) = '') ])"/> elements are selected for use in
	the <gi>text</gi> part of a document; an additional
<XSL:value-of select="count(//row[  position()&gt;1   and
		      not(cell[1]='')   and cell[10] = 'header'])"/>
elements are allowed for in the header. The following table
	shows the usage of all elements in six existing corpora, and
	classifies them 11 usage groups. There are
<XSL:value-of select="count(//row[  position()&gt;1 and
		      normalize-space(cell[10]) = ''])"/> elements 
listed which are <emph>not</emph> allowed in TEI Simple, but should be transformed
to another element.</p>
        <XSL:variable name="corpses" select="distinct-values(doc('count.xml')//elementRef/@corpus)"/>
        <table>
          <row role="label">
            <cell>Element</cell>
            <XSL:for-each select="$corpses">
              <cell>
                <XSL:value-of select="."/>
              </cell>
            </XSL:for-each>
            <cell>Group</cell>
            <cell>Use instead</cell>
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
                <cell rend="right">
                  <XSL:value-of
		      select="format-number(number(sum(doc('count.xml')//elementRef[@key=$e
			      and @corpus=$c]/@count)),'########')"/>
                </cell>
              </XSL:for-each>
              <XSL:copy-of select="cell[10]"/>
              <cell><XSL:if test="normalize-space(cell[11]) !=''">
		<gi><XSL:value-of select="normalize-space(cell[11])"/></gi>
		</XSL:if>
	      </cell>
            </row>
          </XSL:for-each>
        </table>
        <list type="gloss">
          <XSL:for-each-group select="//row[position()&gt;1 and      not(cell[1]='')]" group-by="normalize-space(cell[10])">
            <XSL:sort select="normalize-space(cell[10])"/>
            <XSL:sort select="cell[1]"/>
            <XSL:choose>
              <XSL:when test="current-grouping-key()=''"/>
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
          <XSL:when test="contains(cell[10],'header')"/>
          <XSL:when test="normalize-space(cell[10])=''"/>
          <XSL:otherwise>
            <elementRef key="{normalize-space(cell[1])}"/>
          </XSL:otherwise>
        </XSL:choose>
	</XSL:for-each>
      </specGrp>
    </XSL:result-document>

    <XSL:result-document href="mapatts.xsl">
      
      <xsl:stylesheet version="2.0">	
	<XSL:for-each-group
	    select="doc('teisimple.odd')//attDef[.//processing-instruction()[name()='exactMatch']]"
	    group-by="@ident">
	  <XSL:variable name="att" select="current-grouping-key()"/>
	  <xsl:template match="@{if ($att='rendition') then 'rend' else $att}">
	    <xsl:attribute name="{$att}">
	      <xsl:choose>
		<XSL:for-each select=".//processing-instruction()[name()='exactMatch']">
		  <XSL:variable name="val" select="parent::valItem/@ident"/>
		  <xsl:when>
		    <XSL:attribute name="test">
		      <XSL:text>.='</XSL:text>
		      <XSL:value-of select="."/>
		      <XSL:text>'</XSL:text>
		    </XSL:attribute>
		      <XSL:value-of select="$val"/>
		  </xsl:when>
		</XSL:for-each>
		<xsl:otherwise>
		    <XSL:choose>
		      <XSL:when test="$att='rendition'">
			<xsl:for-each select="tokenize(.,' ')">
			  <xsl:text>simple:</xsl:text>
			  <xsl:value-of select="."/>
			  <xsl:if test="position()!=last()">
			    <xsl:text> </xsl:text>
			  </xsl:if>
			</xsl:for-each>
		      </XSL:when>
		      <XSL:otherwise>
			<xsl:value-of select="."/>
		      </XSL:otherwise>
		    </XSL:choose>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:attribute>
	  </xsl:template>
	</XSL:for-each-group>
      </xsl:stylesheet>
    </XSL:result-document>

  </XSL:template>
</XSL:stylesheet>

