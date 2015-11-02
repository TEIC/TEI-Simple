<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p> TEI Simple utility stylesheet defining functions for use when generating stylesheets based on Simple ODD extension.</p>
      <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
      <p>Author: Magdalena Turska</p>
      <p>Id: $Id$</p>
      <p>Copyright: 2014, TEI Consortium</p>
    </desc>
  </doc>

  <xsl:param name="css">simple.css</xsl:param>
  <xsl:param name="js">simple.js</xsl:param>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Block level element</desc>
  </doc>
  <xsl:function name="tei:block" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'div', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Paragraphs</desc>
  </doc>
  <xsl:function name="tei:paragraph" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'p', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Sections</desc>
  </doc>
  <xsl:function name="tei:section" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'section', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Newline</desc>
  </doc>
  <xsl:function name="tei:newline" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:inline($model, '', $class, $number)"/>
    <br/>
  </xsl:function>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Page break. Only a placeholder. Needs adding to.</desc>
  </doc>
  <xsl:function name="tei:break" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="type"/>
    <xsl:param name="label"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
  
    <xsl:choose>
      <xsl:when test="string($class)">
        <xsl:copy-of select="tei:makeElement($model,'span', concat($class, $number), '', $label, '', '')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="tei:applyTemplates($label)"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:function>    
    
    
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Inline element. If there's something going on re class or rendition keep span and attributes</desc>
  </doc>
  <xsl:function name="tei:inline" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:choose>
      <xsl:when test="string($class)">
        <xsl:copy-of select="tei:makeElement($model,'span', concat($class, $number), '', $content, '', '')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="tei:applyTemplates($content)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Inline text. </desc>
  </doc>
  <xsl:function name="tei:text" as="node()*">
    <xsl:param name="content"/>
    <xslo:value-of>
      <xsl:attribute name="select">
        <xsl:value-of select="$content"/>
      </xsl:attribute>
    </xslo:value-of>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Hierarchical heading</desc>
  </doc>
  <xsl:function name="tei:heading" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="level"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xslo:variable name="depth">
	<xsl:value-of select="$level"/>
    </xslo:variable>

    <xslo:element>
      <xsl:attribute name="name">
	<xsl:text>{concat('h',</xsl:text>
	<xsl:value-of select="$level"/>
	<xsl:text>)}</xsl:text>
      </xsl:attribute>
      <xsl:if test="string($class)">
        <xslo:attribute name="class">
          <xsl:value-of select="$class"/>
        </xslo:attribute>
      </xsl:if>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    </xslo:element>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Choice element</desc>
  </doc>
  <xsl:function name="tei:alternate" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="altcontent"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <!-- alternate:
            because of how jquery tooltips work it needs a title (to make tooltips fire)
            tooltip works for elements of .alternate class and presents the content of it's span.altcontent child as a tooltip -->
    <xsl:copy-of select="tei:makeElement($model,'span', concat('alternate ', $class, $number), 'alternate', $content, '', tei:makeElement($model, 'span', 'hidden altcontent ', '', $altcontent, '', ''))"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>hyperlink</desc>
  </doc>
  <xsl:function name="tei:link" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="target"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <a>
      <xsl:attribute name="class">
        <xsl:value-of select="concat($class, $number)"/>
      </xsl:attribute>
      <xsl:attribute name="href">{<xsl:value-of select="$target"/>}</xsl:attribute>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    </a>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with lists</desc>
  </doc>
  <xsl:function name="tei:list" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'ul', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with rows</desc>
  </doc>
  <xsl:function name="tei:row" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'tr', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with cells</desc>
  </doc>
  <xsl:function name="tei:cell" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'td', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with tables</desc>
  </doc>
  <xsl:function name="tei:table" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'table', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with list items</desc>
  </doc>
  <xsl:function name="tei:listItem" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'li', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Anchor</desc>
  </doc>
  <xsl:function name="tei:anchor" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xslo:variable name="cId">
      <xslo:value-of select="generate-id(.)"/>
    </xslo:variable>
    <sup>
      <xslo:element name="a">
        <xsl:if test="string($class)">
          <xslo:attribute name="class">
            <xsl:value-of select="$class"/>
            <xsl:value-of select="$number"/>
          </xslo:attribute>
        </xsl:if>
        <xslo:attribute name="name">A<xslo:value-of select="$cId"/></xslo:attribute>
        <xslo:attribute name="href">#N<xslo:value-of select="$cId"/></xslo:attribute>
        <xslo:number level="any"/>
      </xslo:element>
    </sup>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>List of objects eg TOC</desc>
  </doc>
  <xsl:function name="tei:index" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="type"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>

    <xsl:choose>
      <xsl:when test="$type='toc'">
	<div id="toc">Table of contents</div>
      </xsl:when>
    </xsl:choose>
  </xsl:function>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Note</desc>
  </doc>
  <xsl:function name="tei:note" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="place"/>
    <xsl:param name="marker"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xslo:variable name="place" select="{$place}"/>
    <xslo:variable name="marker" select="{$marker}"/>
    <xslo:variable name="class">
      <xsl:value-of select="$class"/>
    </xslo:variable>
    <xslo:variable name="number" select="{$number}"/>
    <xslo:variable name="I">
      <xsl:attribute name="select">generate-id()</xsl:attribute>
    </xslo:variable>
    <xslo:variable name="N">
      <xslo:number from="text" level="any" count="note"/>
    </xslo:variable>
    <xslo:choose>
      <xslo:when test="$place='bottom'">
        <sup class="footnotelink">
          <a>
            <xsl:attribute name="href">#{$I}</xsl:attribute>
            <xslo:value-of select="if ($marker) then   $marker else $N"/>
          </a>
        </sup>
        <div>
          <xsl:attribute name="id">{$I}</xsl:attribute>
          <xslo:attribute name="class">
            <xslo:value-of select="($place, concat($class, $number))"/>
          </xslo:attribute>
          <xsl:sequence select="tei:applyTemplates($content)"/>
        </div>
      </xslo:when>
      <xslo:otherwise>
	<xslo:if test="string-length($marker)&gt;0">
	  <sup class="notelink">
            <a>
              <xsl:attribute name="href">#{$I}</xsl:attribute>
              <xslo:value-of select="$marker"/>
            </a>
          </sup>
	</xslo:if>
        <span>
          <xslo:attribute name="class">
            <xslo:value-of select="($place, concat($class, $number))"/>
          </xslo:attribute>
	  <xslo:if test="string-length($marker)&gt;0">
              <xslo:attribute name="id" select="$I"/>
	      <sup class="notelink">
		<xslo:value-of select="$marker"/>
              </sup>
	  </xslo:if>
          <xsl:sequence select="tei:applyTemplates($content)"/>
        </span>
      </xslo:otherwise>
    </xslo:choose>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>End notes</desc>
  </doc>
  <xsl:function name="tei:endnotes" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <hr/>
    <ul>
      <xsl:if test="string($class)">
        <xsl:attribute name="class">
          <xsl:value-of select="concat($class, $number)"/>
        </xsl:attribute>
      </xsl:if>
      <xslo:for-each>
        <xsl:if test="$content!='.' and string($content)">
          <xsl:attribute name="select">
            <xsl:value-of select="$content"/>
          </xsl:attribute>
        </xsl:if>
        <xslo:variable name="cId">
          <xslo:value-of select="generate-id(.)"/>
        </xslo:variable>
        <li>
          <xslo:element name="a"><xslo:attribute name="name">N<xslo:value-of select="$cId"/></xslo:attribute><xslo:attribute name="href">#A<xslo:value-of select="$cId"/></xslo:attribute>
                        ↵ <xslo:number level="any"/>
                    </xslo:element>
          <xslo:text> </xslo:text>
          <xslo:apply-templates/>
        </li>
      </xslo:for-each>
    </ul>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Glyph</desc>
  </doc>
  <xsl:function name="tei:glyph" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:choose>
      <xsl:when test="$content='char:EOLhyphen'">­</xsl:when>
    </xsl:choose>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Image</desc>
  </doc>
  <xsl:function name="tei:graphic" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="url"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="scale"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <img>
      <xsl:attribute name="src">{<xsl:value-of select="$url"/>}</xsl:attribute>
      <xslo:variable name="sizes">
        <xslo:if test="{$width}">
          <xslo:value-of select="concat('width:',{$width},';')"/>
        </xslo:if>
        <xslo:if test="{$height}">
          <xslo:value-of select="concat('height:',{$height},';')"/>
        </xslo:if>
      </xslo:variable>
      <xslo:if test="not($sizes='')">
        <xslo:attribute name="style" select="$sizes"/>
      </xslo:if>
    </img>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Figure</desc>
  </doc>
  <xsl:function name="tei:figure" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xslo:choose>
      <!-- if @facs use it to display figure, else display placeholder -->
      <xslo:when test="string(@facs)">
        <xsl:element name="img">
          <xsl:if test="string($class)">
            <xsl:attribute name="class">
              <xsl:value-of select="concat($class, $number)"/>
            </xsl:attribute>
          </xsl:if>
          <xslo:attribute name="src">
            <xslo:value-of select="@facs"/>
          </xslo:attribute>
        </xsl:element>
      </xslo:when>
      <xslo:otherwise>
        <div>
          <xsl:if test="string($class)">
            <xsl:attribute name="class">
              <xsl:value-of select="concat($class,  $number)"/>
            </xsl:attribute>
          </xsl:if>
          <xslo:apply-templates/>
        </div>
      </xslo:otherwise>
    </xslo:choose>
  </xsl:function>
  <xsl:function name="tei:makeElement" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="name"/>
    <xsl:param name="class"/>
    <xsl:param name="title"/>
    <xsl:param name="content"/>
    <xsl:param name="anchorName"/>
    <xsl:param name="nested"/>
    <xsl:element name="{$name}">
      <xsl:if test="string($class)">
        <xsl:attribute name="class">
          <xsl:value-of select="$class"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="string($title)">
        <xsl:attribute name="title">
          <xsl:value-of select="$title"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="string($anchorName)">
        <xsl:attribute name="name">
          <xsl:value-of select="$anchorName"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:sequence select="tei:attributes($model)"/>
      <xsl:sequence select="tei:applyTemplates($content)"/>
      <xsl:if test="$nested instance of element()">
        <xsl:sequence select="$nested"/>
      </xsl:if>
    </xsl:element>
  </xsl:function>
  <xsl:function name="tei:makeDefault" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <div>
      <xsl:if test="string($class)">
        <xsl:attribute name="class">
          <xsl:value-of select="$class"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:sequence select="tei:attributes($model)"/>
      <xslo:apply-templates/>
    </div>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>whole document</desc>
  </doc>
  <xsl:function name="tei:document" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <html>
      <xslo:apply-templates/>
    </html>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>body document</desc>
  </doc>
  <xsl:function name="tei:body" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <body>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    </body>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>doc title</desc>
  </doc>
  <xsl:function name="tei:title" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <title>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    </title>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>metadata</desc>
  </doc>
  <xsl:function name="tei:metadata" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <head>
      <xsl:for-each select="$TOP">
        <xsl:copy-of select="tei:getRenditions(//elementSpec)"/>
      </xsl:for-each>
      <xslo:call-template name="localRendition"/>
      <!-- jQuery -->
      <script type="text/javascript" charset="utf-8" src="http://code.jquery.com/jquery-1.10.2.min.js"/>
      <!-- tooltips -->
      <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"/>
      <script type="text/javascript" src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"/>
      <link rel="stylesheet" href="http://jqueryui.com/tooltip/resources/demos/style.css"/>
      <!-- table of contents generation -->
      <script type="text/javascript" charset="utf-8" src="{$js}"/>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    </head>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Determine the container(s) for the function</desc>
  </doc>
  <xsl:function name="tei:simpleContainer">
    <xsl:param name="name"/>
    <xsl:choose>
      <xsl:when test="$name = 'alternate'">
        <gi>span</gi>
      </xsl:when>
      <xsl:when test="$name = 'anchor'">
        <gi>a</gi>
      </xsl:when>
      <xsl:when test="$name = 'block'">
        <gi>div</gi>
      </xsl:when>
      <xsl:when test="$name = 'break'">
        <gi>span</gi>
      </xsl:when>
      <xsl:when test="$name = 'cell'">
        <gi>td</gi>
      </xsl:when>
      <xsl:when test="$name = 'date'">
        <gi>span</gi>
      </xsl:when>
      <xsl:when test="$name = 'graphic'">
        <gi>img</gi>
      </xsl:when>
      <xsl:when test="$name = 'heading'">
        <gi>h1</gi>
        <gi>h2</gi>
        <gi>h3</gi>
      </xsl:when>
      <xsl:when test="$name = 'inline'">
        <gi>span</gi>
      </xsl:when>
      <xsl:when test="$name = 'list'">
        <gi>ol</gi>
        <gi>ul</gi>
      </xsl:when>
      <xsl:when test="$name = 'listItem'">
        <gi>li</gi>
      </xsl:when>
      <xsl:when test="$name = 'newline'">
        <gi>br</gi>
      </xsl:when>
      <xsl:when test="$name = 'note'">
        <gi>span</gi>
      </xsl:when>
      <xsl:when test="$name = 'paragraph'">
        <gi>p</gi>
      </xsl:when>
      <xsl:when test="$name = 'row'">
        <gi>tr</gi>
      </xsl:when>
      <xsl:when test="$name = 'table'">
        <gi>table</gi>
      </xsl:when>
      <xsl:otherwise>div</xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Join together the renditions into a CSS section</desc>
  </doc>
  <xsl:function name="tei:getRenditions" as="node()*">
    <xsl:param name="content"/>
    <link rel="StyleSheet" href="{$css}" type="text/css"/>
    <style  type="text/css">
      <xsl:for-each select="$content">
        <xsl:if test="position()=1">
          <xsl:for-each select="//outputRendition[@xml:id and  not(parent::model)]">
            <xsl:text>.simple_</xsl:text>
            <xsl:value-of select="@xml:id"/>
            <xsl:text> { </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text> } 
</xsl:text>
          </xsl:for-each>
        </xsl:if>
        <xsl:for-each select=".//model">
          <xsl:variable name="container">
            <xsl:copy-of select="tei:simpleContainer(@behaviour)"/>
          </xsl:variable>
          <!-- use position of a model to distinguish between classes for differing behaviours -->
          <xsl:variable name="elname">
            <xsl:value-of select="ancestor::elementSpec/@ident"/>
          </xsl:variable>
          <xsl:variable name="pos" select="if  (count(../model) &gt; 1) then position() else  ''"/>
          <xsl:for-each select="./outputRendition">
            <xsl:variable name="scope" select="@scope"/>
            <xsl:variable name="rendition" select="normalize-space(.)"/>
            <xsl:for-each select="$container/node()">
              <xsl:value-of select="concat(.,'.',$elname,$pos)"/>
              <xsl:if test="string($scope)">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="$scope"/>
              </xsl:if>
              <xsl:text> {</xsl:text>
              <xsl:value-of select="$rendition"/>
              <xsl:text>}</xsl:text>
              <xsl:text>
</xsl:text>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </style>
  </xsl:function>

  <xsl:function name="tei:processLocalRendition" as="node()*">

    <xslo:template name="localrendition">
      <xslo:if test="@rendition">
	<xslo:variable name="values">
	  <xslo:for-each
	      select="tokenize(normalize-space(@rendition),' ')">
	    <xslo:choose>
	      <xslo:when test="starts-with(.,'#')">
		<xslo:sequence
		    select="concat('document_',substring-after(.,'#'))"/>
	      </xslo:when>
	      <xslo:when test="starts-with(.,'simple:')">
		<xslo:sequence select="replace(.,':','_')"/>
	      </xslo:when>
	      <xslo:otherwise>
		<xslo:for-each select="document(.)">
		  <xslo:sequence select="concat('external_',@xml:id)"/>
		</xslo:for-each>
	      </xslo:otherwise>
	    </xslo:choose>
	  </xslo:for-each>
	</xslo:variable>
	<xslo:attribute name="class">
	  <xslo:value-of select="string-join($values,' ')"/>
	</xslo:attribute>
      </xslo:if>
    </xslo:template>
    <xslo:template name="localRendition">
      <xslo:if test="key('ALL-LOCALRENDITION',1)">
         <style type="text/css">
	   <xslo:for-each select="key('ALL-LOCALRENDITION',1)">
	     <xslo:text>&#10;.document_</xslo:text>
	     <xslo:value-of select="@xml:id"/>
	     <xslo:if test="@scope">
	       <xslo:text>:</xslo:text>
	       <xslo:value-of select="@scope"/>
	     </xslo:if>
	     <xslo:text> {&#10;	</xslo:text>
	     <xslo:value-of select="."/>
	     <xslo:text>&#10;}</xslo:text>
	   </xslo:for-each>
	   <xslo:text>&#10;</xslo:text>
         </style>
      </xslo:if>
      <xslo:if test="key('ALL-EXTRENDITION',1)">
         <style type="text/css">
	   <xslo:for-each select="key('ALL-EXTRENDITION',1)">
	     <xslo:variable name="pointer">
	       <xslo:value-of select="."/>
	     </xslo:variable>
	     <xslo:for-each select="key('EXTRENDITION',$pointer)[1]">
	       <xslo:for-each select="document($pointer)">
		 <xslo:text>&#10;.</xslo:text>
		 <xslo:value-of select="@xml:id"/>
		 <xslo:if test="@scope">
		   <xslo:text>:</xslo:text>
		   <xslo:value-of select="@scope"/>
		 </xslo:if>
		 <xslo:text> {&#10;</xslo:text>
		 <xslo:value-of select="."/>
		 <xslo:text>&#10;}</xslo:text>
	       </xslo:for-each>
	     </xslo:for-each>
	   </xslo:for-each>
         </style>
      </xslo:if>
    </xslo:template>

      <xslo:function name="tei:escapeChars">
        <xslo:param name="letters"/>
        <xslo:param name="context"/>
        <xslo:value-of select="translate($letters,'ſ','s')"/>
      </xslo:function>

  </xsl:function>

  <xsl:function name="tei:attributes" as="node()*">
    <xsl:param name="model"/>
    <xslo:if test="@xml:id">
      <xslo:attribute name="id" select="@xml:id"/>
    </xslo:if>
    <xsl:if test="$model/@useSourceRendition='true'">
      <xslo:call-template name="localrendition"/>
    </xsl:if>
  </xsl:function>




</xsl:stylesheet>
