<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n="www.example.com" xmlns:rng="http://relaxng.org/ns/structure/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="rng tei n" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="en">
      <teiHeader>
        <fileDesc>
          <titleStmt>
            <title>TEI Simple</title>
          </titleStmt>
   <publicationStmt>
     <publisher>TEI Consortium</publisher>
    <availability>
     <licence target="http://creativecommons.org/licenses/by-sa/3.0/"> Distributed under a Creative
      Commons Attribution-ShareAlike 3.0 Unported License </licence>
     <licence target="http://www.opensource.org/licenses/BSD-2-Clause">
      <p>Copyright 2014 TEI Consortium.</p>
      <p>All rights reserved.</p>
      <p>Redistribution and use in source and binary forms, with or without modification, are
       permitted provided that the following conditions are met:</p>
      <list>
       <item>Redistributions of source code must retain the above copyright notice, this list of
        conditions and the following disclaimer.</item>
       <item>Redistributions in binary form must reproduce the above copyright notice, this list of
        conditions and the following disclaimer in the documentation and/or other materials provided
        with the distribution.</item>
      </list>
      <p>This software is provided by the copyright holders and contributors "as is" and any express
       or implied warranties, including, but not limited to, the implied warranties of
       merchantability and fitness for a particular purpose are disclaimed. In no event shall the
       copyright holder or contributors be liable for any direct, indirect, incidental, special,
       exemplary, or consequential damages (including, but not limited to, procurement of substitute
       goods or services; loss of use, data, or profits; or business interruption) however caused
       and on any theory of liability, whether in contract, strict liability, or tort (including
       negligence or otherwise) arising in any way out of the use of this software, even if advised
       of the possibility of such damage.</p>
     </licence>
     <p>TEI material can be licensed differently depending on the use you intend to make of it.
      Hence it is made available under both the CC+BY and BSD-2 licences. The CC+BY licence is
      generally appropriate for usages which treat TEI content as data or documentation. The BSD-2
      licence is generally appropriate for usage of TEI content in a software environment. For
      further information or clarification, please contact the <ref target="mailto:info@tei-c.org"
       >TEI Consortium</ref>. </p>
    </availability>
   </publicationStmt>
   <sourceDesc>
    <p>created ab initio during a meeting in Oxford</p>
   </sourceDesc>
  </fileDesc>
      </teiHeader>
      <text>
  <front>
   <titlePage>
    <docTitle>
     <titlePart type="main">TEI Simple</titlePart>
    </docTitle>
    <docAuthor>Sebastian Rahtz</docAuthor>
    <docAuthor>Brian Pytlik Zillig</docAuthor>
    <docAuthor>Martin Mueller</docAuthor>
    <docDate>Version 0.1: 30th November 2014</docDate>
   </titlePage>
  </front>
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

	  <div>
	    <head>The base TEI infrastructure</head>
	    <specGrp xml:id="base">
              <moduleRef key="tei"/>
	    </specGrp>
	  </div>

	  <div>
	    <head>The header</head>
	    <p>The default set of elements for the header are loaded
	    using the <term>header</term> module. In addition,
	    elements from other modules are loaded, if they are tagged
	    in the classification as being needed for the header only.</p>
          <specGrp xml:id="header">
            <moduleRef key="header"/>
            <xsl:for-each select="//row[position()&gt;1 and       not(cell[1]='')]">
              <xsl:sort select="cell[1]"/>
              <xsl:if test="cell[10]='headeronly'">
                <elementRef key="{normalize-space(cell[1])}"/>
              </xsl:if>
            </xsl:for-each>
            <p>Elements which are only intended to be used in the
	    header are banned from the <gi>text</gi>, using a
	    Schematron rule.</p> 
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

	  </div>

	  <div>
	    <head>Transcription</head>
	    <p>In order to support the <gi>sourcedoc</gi> and
	    <gi>facsimile</gi> elements, the basic transcriptional
	    elements are loaded, and two attribute classes.</p>
          <specGrp xml:id="transcr">
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
	  </div>

	  <div>
	    <head>Attribute classes</head>
          <specGrp xml:id="attclasses">
	    <p>The <term>tei</term> module brings with it a default
	    set of attribute classes. We need some more specialist
	    ones from other modules, and to delete some default ones
	    which we don't plan to use.</p>
            <classRef key="att.global.analytic"/>
            <classRef key="att.global.facs"/>
            <classRef key="att.milestoneUnit"/>
            <classRef key="att.global.linking"/>
            <classSpec ident="att.datcat" mode="delete"/>
            <classSpec ident="att.declarable" mode="delete"/>
            <classSpec ident="att.divLike" mode="delete"/>
            <classSpec ident="att.fragmentable" mode="delete"/>

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
            <p>Constrained value lists are added to attribute classes
	    where possible.</p>
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
                      <skos:exactMatch>pageTop</skos:exactMatch>
                      <desc>at the top of the page</desc>
                    </valItem>
                    <valItem ident="top-right">
                      <desc>at the top right of the page</desc>
                    </valItem>
                    <valItem ident="top-left">
                      <desc>at the top left of the page</desc>
                    </valItem>
                    <valItem ident="top-center">
                      <desc>at the top center of the page</desc>
                    </valItem>
                    <valItem ident="bottom-right">
                      <skos:exactMatch>bot-right</skos:exactMatch>
                      <desc>at the bottom right of the page</desc>
                    </valItem>
                    <valItem ident="bottom-left">
                      <skos:exactMatch>bot-left</skos:exactMatch>
                      <desc>at the bottom left of the page</desc>
                    </valItem>
                    <valItem ident="bottom-center">
                      <skos:exactMatch>bot-center</skos:exactMatch>
                      <desc>at the bottom center of the page</desc>
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
            <classSpec ident="att.dimensions" mode="change">
              <attList>
                <attDef ident="unit" mode="change">
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
                    <valItem ident="words">
                      <skos:exactMatch>word</skos:exactMatch>
                    </valItem>
                    <valItem ident="cm"/>
                    <valItem ident="mm"/>
                    <valItem ident="in"/>
                  </valList>
                </attDef>
              </attList>
            </classSpec>
            <classSpec ident="att.global" mode="change">
              <attList>
                <attDef ident="rend" mode="delete"/>
                <attDef ident="style" mode="delete"/>
                <attDef ident="rendition" mode="change">
                  <valList mode="add" type="semi">
                    <valItem ident="simple:allcaps">
                      <skos:exactMatch>upper-roman</skos:exactMatch>
                      <skos:exactMatch>uc</skos:exactMatch>
                      <desc>all capitals</desc>
                    </valItem>
                    <valItem ident="simple:blackletter">
                      <skos:exactMatch>blackLetter</skos:exactMatch>
                      <skos:exactMatch>blackletterType</skos:exactMatch>
                      <skos:exactMatch>FrakturType</skos:exactMatch>
                      <skos:exactMatch>gothic</skos:exactMatch>
                      <desc>black letter or gothic typeface</desc>
                    </valItem>
                    <valItem ident="simple:bold">
                      <skos:exactMatch>b</skos:exactMatch>
                      <skos:exactMatch>bo</skos:exactMatch>
                      <skos:exactMatch>bol</skos:exactMatch>
                      <skos:exactMatch>strong</skos:exactMatch>
                      <desc>bold typeface</desc>
                    </valItem>
                    <valItem ident="simple:bottombraced">
                      <desc>marked with a brace under the bottom of
		      the text</desc>
		    </valItem>
                    <valItem ident="simple:boxed">
                      <skos:exactMatch>border</skos:exactMatch>
                      <desc>border around the text</desc>
                    </valItem>
                    <valItem ident="simple:centre">
                      <skos:exactMatch>center</skos:exactMatch>
                      <desc>centred</desc>
                    </valItem>
                    <valItem ident="simple:cursive">
                      <desc>cursive typeface</desc>
                    </valItem>
                    <valItem ident="simple:doublestrikethrough">
                      <desc>strikethrough with double line</desc>
                    </valItem>
                    <valItem ident="simple:doubleunderline">
                      <desc>underlined with double line</desc>
                    </valItem>
                    <valItem ident="simple:dropcap">
                      <skos:exactMatch>decorInit</skos:exactMatch>
                      <desc>initial letter larger or decorated</desc>
                    </valItem>
                    <valItem ident="simple:float">
                      <desc>floated out of main flow</desc>
                    </valItem>
                    <valItem ident="simple:italic">
                      <skos:exactMatch/>
                      <skos:exactMatch>italics</skos:exactMatch>
                      <skos:exactMatch>ITALIC</skos:exactMatch>
                      <skos:exactMatch>i</skos:exactMatch>
                      <skos:exactMatch>it</skos:exactMatch>
                      <skos:exactMatch>ital</skos:exactMatch>
                      <desc>italic typeface</desc>
                    </valItem>
                    <valItem ident="simple:larger">
                      <skos:exactMatch>large</skos:exactMatch>
                      <desc>larger type</desc>
                    </valItem>
                    <valItem ident="simple:left">
                      <skos:exactMatch>left</skos:exactMatch>
                      <desc>aligned to the left or left-justified</desc>
                    </valItem>
                    <valItem ident="simple:leftbraced">
                      <skos:exactMatch>braced</skos:exactMatch>
		      <desc>marked with a brace on the left side of
		      the text</desc>
		    </valItem>
                    <valItem ident="simple:letterspace">
                      <skos:exactMatch>spaceletter</skos:exactMatch>
                      <desc>letter-spaced</desc>
                    </valItem>
                    <valItem ident="simple:normalstyle">
                      <desc>upright shape and default weight of typeface</desc>
                    </valItem>
                    <valItem ident="simple:normalweight">
                      <skos:exactMatch>roman</skos:exactMatch>
                      <desc>normal typeface weight</desc>
                    </valItem>
                    <valItem ident="simple:right">
                      <skos:exactMatch>right-aligned</skos:exactMatch>
                      <desc>aligned to the right or right-justified</desc>
                    </valItem>
                    <valItem ident="simple:rightbraced">
		      <desc>marked with a brace to the right of
		      the text</desc>
		    </valItem>
                    <valItem ident="simple:rotateleft">
                      <skos:exactMatch>rotateCounterclockwise</skos:exactMatch>
                      <desc>rotated to the left</desc>
                    </valItem>
                    <valItem ident="simple:rotateright">
                      <skos:exactMatch>rotateClockwise</skos:exactMatch>
                      <desc>rotated to the right</desc>
                    </valItem>
                    <valItem ident="simple:smallcaps">
                      <skos:exactMatch>sc</skos:exactMatch>
                      <skos:exactMatch>smallCap</skos:exactMatch>
                      <desc>small caps</desc>
                    </valItem>
                    <valItem ident="simple:smaller">
                      <skos:exactMatch>small</skos:exactMatch>
                      <desc>smaller type</desc>
                    </valItem>
                    <valItem ident="simple:strikethrough">
                      <desc>strike through</desc>
                    </valItem>
                    <valItem ident="simple:subscript">
                      <skos:exactMatch>sub</skos:exactMatch>
                      <desc>subscript</desc>
                    </valItem>
                    <valItem ident="simple:superscript">
                      <skos:exactMatch>sup</skos:exactMatch>
                      <skos:exactMatch>super</skos:exactMatch>
                      <desc>superscript</desc>
                    </valItem>
                    <valItem ident="simple:topbraced">
		      <desc>marked with a brace above  the text</desc>
		    </valItem>
                    <valItem ident="simple:typewriter">
                      <desc>fixed-width typeface, like typewriter</desc>
                    </valItem>
                    <valItem ident="simple:underline">
                      <skos:exactMatch>u</skos:exactMatch>
                      <desc>underlined with single line</desc>
                    </valItem>
                    <valItem ident="simple:wavyunderline">
                      <desc>underlined  with wavy line</desc>
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
	  </div>

	  <div>
	    <head>Model classes</head>
          <specGrp xml:id="modelclasses">
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
          </specGrp>
	  </div>

	  <div>
	    <head>Elements</head>
	    <p>The main part of Simple is the set of selected elements.</p>
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
	    <p>A small number of elements have constrained value lists added.</p>
            <elementSpec ident="formula" mode="change">
	      <attList>
		<attDef ident="notation"  mode="change">
                  <valList mode="add" type="semi">
                    <valItem ident="TeX">
                      <desc>Using TeX or LaTeX notation</desc>
                    </valItem>
                  </valList>
		</attDef>
	      </attList>
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
                <attDef ident="role" mode="change">
                  <valList mode="add" type="closed">
                    <valItem ident="data"/>
                    <valItem ident="label"/>
                    <valItem ident="sum"/>
                    <valItem ident="total"/>
                  </valList>
                </attDef>
              </attList>
            </elementSpec>
            <elementSpec ident="row" mode="change">
              <attList>
                <attDef ident="role"  mode="change">
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
                <attDef ident="level"  mode="change">
                  <valList mode="add" type="closed">
                    <valItem ident="a"/>
                    <valItem ident="j"/>
                    <valItem ident="m"/>
                    <valItem ident="s"/>
                  </valList>
                </attDef>
              </attList>
            </elementSpec>
          </specGrp>
	  </div>


          <schemaSpec ident="teisimple" start="TEI teiCorpus">

            <specGrpRef target="#base"/>
            <specGrpRef target="#header"/>
            <specGrpRef target="#transcr"/>
            <specGrpRef target="#attclasses"/>
            <specGrpRef target="#modelclasses"/>
            <specGrpRef target="#simple"/>
          </schemaSpec>
        </body>
      </text>
    </TEI>
  </xsl:template>
</xsl:stylesheet>
