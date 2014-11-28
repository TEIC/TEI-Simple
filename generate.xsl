<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n="www.example.com" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="rng tei n" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
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
            <p/>
          </sourceDesc>
        </fileDesc>
      </teiHeader>
      <text>
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
        <body>
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
          <specGrp xml:id="changes">
            <p>A set of unused model classes are removed.</p>
            <classSpec ident="model.entryPart" mode="delete"/>
            <classSpec ident="model.placeNamePart" mode="delete"/>
            <classSpec ident="model.placeStateLike" mode="delete"/>
            <classSpec ident="model.egLike" mode="delete"/>
            <classSpec ident="model.offsetLike" mode="delete"/>
            <classSpec ident="model.pPart.msdesc" mode="delete"/>
            <classSpec ident="model.oddDecl" mode="delete"/>
            <classSpec ident="model.specDescLike" mode="delete"/>
            <classSpec ident="model.entryPart" mode="delete"/>
            <classSpec ident="model.placeNamePart" mode="delete"/>
            <classSpec ident="model.placeStateLike" mode="delete"/>
            <classSpec ident="model.certLike" mode="delete"/>
            <classSpec ident="model.glossLike" mode="delete"/>
            <p>Some uncommon attributes are removed from global linking.</p>
            <classSpec ident="att.global.linking" mode="change">
              <attList>
                <attDef ident="synch" mode="delete"/>
                <attDef ident="sameAs" mode="delete"/>
                <attDef ident="copyOf" mode="delete"/>
                <attDef ident="exclude" mode="delete"/>
                <attDef ident="select" mode="delete"/>
              </attList>
            </classSpec>
            <classSpec ident="att.pointing" mode="change">
              <attList>
                <attDef ident="target" mode="change">
                  <constraintSpec ident="validtarget" scheme="isoschematron">
                    <constraint>
                      <rule xmlns="http://purl.oclc.org/dsdl/schematron" context="tei:*[@target]">
                        <let name="results" value="for $t in        tokenize(normalize-space(@target),'\s+') return starts-with($t,'#') and not(id(substring($t,2)))"/>
                        <report test="some $x in $results  satisfies $x">
Error: Every local pointer in "<value-of select="@target"/>" must point to an ID in this document (<value-of select="$results"/>)</report>
                      </rule>
                    </constraint>
                  </constraintSpec>
                </attDef>
              </attList>
            </classSpec>
            <classSpec mode="change" ident="att.placement">
              <attList>
                <attDef ident="place" mode="change">
                  <valList type="closed" mode="replace">
                    <valItem ident="above">
                      <skos:exactMatch>supralinear</skos:exactMatch>
                      <desc>above the line</desc>
                    </valItem>
                    <valItem ident="below">
                      <desc>below the line</desc>
                    </valItem>
                    <valItem ident="top">
                      <desc>at the top of the page</desc>
                    </valItem>
                    <valItem ident="bottom">
                      <skos:exactMatch>foot</skos:exactMatch>
                      <desc>at the foot of the page</desc>
                    </valItem>
                    <valItem ident="tablebottom">
                      <valItem ident="tablefoot">
                        <desc>at the foot of the table</desc>
                      </valItem>
                      <valItem ident="margin">
                        <skos:exactMatch>margin-outer</skos:exactMatch>
                        <skos:exactMatch>marg1</skos:exactMatch>
                        <skos:exactMatch>marg2</skos:exactMatch>
                        <skos:exactMatch>marg4</skos:exactMatch>
                        <skos:exactMatch>margin</skos:exactMatch>
                        <skos:exactMatch>left</skos:exactMatch>
                        <desc>in the outer margin</desc>
                      </valItem>
                      <valItem ident="margin-left">
                        <skos:exactMatch>left</skos:exactMatch>
                        <desc>in the left margin</desc>
                      </valItem>
                      <valItem ident="margin-right">
                        <skos:exactMatch>right</skos:exactMatch>
                        <desc>in the right margin</desc>
                      </valItem>
                      <valItem ident="opposite">
                        <desc>on the opposite, i.e. facing, page.</desc>
                      </valItem>
                      <valItem ident="overleaf">
                        <desc>on the other side of the leaf.</desc>
                      </valItem>
                      <valItem ident="end">
                        <desc>at the end of the volume.</desc>
                      </valItem>
                      <valItem ident="divend">
                        <desc>at the end the current division.</desc>
                      </valItem>
                      <valItem ident="parend">
                        <desc>at the end the current paragraph.</desc>
                      </valItem>
                      <valItem ident="inline">
                        <skos:exactMatch>in</skos:exactMatch>
                        <desc>within the body of the text.</desc>
                      </valItem>
                      <valItem ident="inspace">
                        <desc>in a predefined space, for example left by an earlier scribe.</desc>
                      </valItem>
                      <valItem ident="display">
                        <desc>formatted like a quotation</desc>
                      </valItem>
                    </valItem>
                  </valList>
                </attDef>
              </attList>
            </classSpec>
            <classSpec ident="att.datcat" mode="delete"/>
            <classSpec ident="att.declarable" mode="delete"/>

	    <elementSpec ident="formula">
	      <attDef ident="notation">
		<valList mode="add" type="semi">
		  <valItem ident="TeX"/>
		</valList>
	      </attDef>
	    </elementSpec>

            <elementSpec ident="name" mode="change">
              <attList>
                <attDef ident="type" mode="change">
                  <valList mode="add" type="closed">
                    <valItem ident="person"/>
                    <valItem ident="forename"/>
                    <valItem ident="surname"/>
                    <valItem ident="personGenName"/>
                    <valItem ident="personRoleName"/>
                    <valItem ident="personAddName"/>
                    <valItem ident="nameLink"/>
                    <valItem ident="organisation"/>
                    <valItem ident="country"/>
                    <valItem ident="placeGeog"/>
                    <valItem ident="place"/>
                  </valList>
                </attDef>
              </attList>
            </elementSpec>
   <elementSpec ident="cell" mode="change">
              <attList>

      <attDef ident="role">
         <valList mode="add" type="closed">
            <valItem ident="data"/>
            <valItem ident="label"/>
            <valItem ident="sum"/>
            <valItem ident="total"/>
         </valList>
      </attDef>
	      </attList>
   </elementSpec>

   <elementSpec ident="title" mode="change">
              <attList>

      <attDef ident="level">
         <valList mode="add" type="closed">
            <valItem ident="a"/>
            <valItem ident="j"/>
            <valItem ident="m"/>
            <valItem ident="s"/>
         </valList>
      </attDef>
	      </attList>
   </elementSpec>

   <elementSpec ident="att.dimensions" mode="change">
     <attList>
      <attDef ident="unit">
         <valList mode="add" type="closed">
            <valItem ident="chars">
                      <skos:exactMatch>char</skos:exactMatch>

                      <skos:exactMatch>characters</skos:exactMatch>

	    </valItem>
            <valItem ident="lines">
                      <skos:exactMatch>line</skos:exactMatch>

	    </valItem>
            <valItem ident="pages">
                      <skos:exactMatch>page</skos:exactMatch>
</valItem>
            <valItem ident="words">                      <skos:exactMatch>word</skos:exactMatch>
</valItem>
            <valItem ident="cm"></valItem>
            <valItem ident="mm"></valItem>
            <valItem ident="in"></valItem>

         </valList>
      </attDef>
     </attList>
   </elementSpec>

            <classSpec ident="att.global" mode="change">
              <attList>
                <attDef ident="rend" mode="delete"/>
                <attDef ident="style" mode="delete"/>
                <attDef ident="rendition" mode="change">
                  <valList mode="add" type="semi">
                    <valItem ident="simple:blackletter">
                      <skos:exactMatch>blackLetter</skos:exactMatch>
                      <skos:exactMatch>blackletterType</skos:exactMatch>
                      <skos:exactMatch>FrakturType</skos:exactMatch>
                      <skos:exactMatch>gothic</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:cursive">
		      </valItem>
                    <valItem ident="simple:bold">
                      <skos:exactMatch>b</skos:exactMatch>
                      <skos:exactMatch>bo</skos:exactMatch>
                      <skos:exactMatch>bol</skos:exactMatch>
                      <skos:exactMatch>strong</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:allcaps">
                      <skos:exactMatch>upper-roman</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:italic">
                      <skos:exactMatch/>
                      <skos:exactMatch>italics</skos:exactMatch>
                      <skos:exactMatch>ITALIC</skos:exactMatch>
                      <skos:exactMatch>i</skos:exactMatch>
                      <skos:exactMatch>ital</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:normalweight">
                      <skos:exactMatch>roman</skos:exactMatch>
		      </valItem>
                    <valItem ident="simple:normalstyle">
		      </valItem>
                    <valItem ident="simple:smallcaps">
                      <skos:exactMatch>sc</skos:exactMatch>
                      <skos:exactMatch>smallCap</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:doublestrikethrough">
		      </valItem>
                    <valItem ident="simple:strikethrough">
		      </valItem>
                    <valItem ident="simple:subscript">
                      <skos:exactMatch>sub</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:superscript">
                      <skos:exactMatch>sup</skos:exactMatch>
                      <skos:exactMatch>super</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:typewriter">
		      </valItem>
                    <valItem ident="simple:doubleunderline">
		      </valItem>
                    <valItem ident="simple:underline">
                      <skos:exactMatch>i</skos:exactMatch>
		      </valItem>
                    <valItem ident="simple:wavyunderline">
		      </valItem>
                    <valItem ident="simple:rotateright">
                      <skos:exactMatch>rotateClockwise</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:rotateleft">
                      <skos:exactMatch>rotateCounterclockwise</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:centre">
                      <skos:exactMatch>center</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:rightbraced "/>
                    <valItem ident="simple:topbraced "/>
                    <valItem ident="simple:bottombraced "/>
                    <valItem ident="simple:leftbraced ">
                      <skos:exactMatch>braced</skos:exactMatch>
		      </valItem>
                    <valItem ident="simple:boxed ">
		      </valItem>
                    <valItem ident="simple:letterspace">
                      <skos:exactMatch>spaceletter</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:dropcap">
                      <skos:exactMatch>decorInit</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:larger">
                      <skos:exactMatch>large</skos:exactMatch>
                    </valItem>
                    <valItem ident="simple:smaller">
                      <skos:exactMatch>small</skos:exactMatch>
                    </valItem>
                  </valList>
                  <constraintSpec ident="renditionpointer" scheme="isoschematron">
                    <constraint>
                      <rule xmlns="http://purl.oclc.org/dsdl/schematron" context="tei:*[@rendition]">
                        <let name="results" value="for $val in tokenize(normalize-space(@rendition),'\s+') return        starts-with($val,'simple:')        or        (starts-with($val,'#')        and        //tei:rendition[@xml:id=substring($val,2)])"/>
                        <assert test="every $x in $results satisfies $x">
Error: Each of the rendition values in "<value-of select="@rendition"/>" must point to a local
ID or to a token in the Simple scheme  (<value-of select="$results"/>)</assert>
                      </rule>
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
            <xsl:for-each select="//row[position()&gt;1 and       not(cell[1]='')]">
              <xsl:sort select="cell[1]"/>
              <xsl:if test="cell[10]='headeronly'">
                <elementRef key="{normalize-space(cell[1])}"/>
              </xsl:if>
            </xsl:for-each>
            <!-- ban from text-->
            <elementSpec ident="text" mode="change">
              <constraintSpec ident="headeronlyelement" scheme="isoschematron">
                <constraint>
                  <rule xmlns="http://purl.oclc.org/dsdl/schematron" context="tei:term|tei:editor|tei:email|tei:att|tei:gi">
                    <report test="ancestor::tei:text">Error: The element <name/> is not permitted outside the header</report>
                  </rule>
                </constraint>
              </constraintSpec>
            </elementSpec>
          </specGrp>
          <specGrp xml:id="atts">
            <classRef key="att.global.analytic"/>
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
          <schemaSpec ident="teisimple" start="TEI teiCorpus">
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
