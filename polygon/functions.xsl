<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
		xmlns:tei="http://www.tei-c.org/ns/1.0" 
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
		exclude-result-prefixes="xs"
		version="2.0">

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

<xsl:function name="tei:matchFunction">
    <xsl:param name="elName"/>
    <xsl:param name="model"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:variable name="task" select="substring-before(normalize-space($model/@behaviour),'(')"/>
    <xsl:variable name="parms" select="tokenize(replace(normalize-space($model/@behaviour),'.*\((.*)\)$','$1'),',')"/>
    <xsl:variable name="textcontent" select="replace(substring-after($model/@behaviour,'('),'\)$','')"/>
    <xsl:if test="$debug='true'">
      <xsl:message><xsl:value-of
      select="($elName,$model/@behaviour,$task,$textcontent)"/>:   <xsl:value-of
      select="($parms)" separator=" -- "/></xsl:message>
    </xsl:if>
    <xsl:variable name="content" select="$parms[1]"/>
    
    <xsl:choose>
        <xsl:when test="$task ='index'">
            <xsl:sequence select="tei:index($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='anchor'">
            <xsl:sequence select="tei:anchor($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='glyph'">
            <xsl:sequence select="tei:glyph($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='note'">
            <xsl:sequence select="tei:note($model, $content, $parms[2], $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='makeEndnotes'">
            <xsl:sequence select="tei:endnotes($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='block'">
            <xsl:sequence select="tei:block($elName, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='heading'">
          <xsl:sequence select="tei:heading($model, $content, $parms[2], $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='multiheading'">
          <xsl:sequence select="tei:multiheading($model, $content, $parms[3], $class, $number,$parms[2])"/>
        </xsl:when>
        <xsl:when test="$task ='alternate'">
            <xsl:sequence select="tei:alternate($model, $content, $parms[2],$class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='list'">
            <xsl:sequence select="tei:list($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='listItem'">
            <xsl:sequence select="tei:listItem($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='inline'">
            <xsl:sequence select="tei:inline($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='text'">
            <xsl:sequence select="tei:text($textcontent)"/>
        </xsl:when>
        <xsl:when test="$task ='newline'">
            <xsl:sequence select="tei:newline($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='break'">
            <xsl:sequence select="tei:break($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='paragraph'">
            <xsl:sequence select="tei:paragraph($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='figure'">
            <xsl:sequence select="tei:figure($model, $content, $class, $number)"/>
        </xsl:when>

        <xsl:when test="$task ='table'">
            <xsl:sequence select="tei:table($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='row'">
            <xsl:sequence select="tei:row($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="$task ='cell'">
            <xsl:sequence select="tei:cell($model, $content, $class, $number)"/>
        </xsl:when>
        

        <xsl:when test="$task ='title'">
            <xsl:sequence select="tei:title($model, $content, $class, $number)"/>
        </xsl:when>

        <xsl:when test="$task ='metadata'">
            <xsl:sequence select="tei:metadata($model, $content, $class, $number)"/>
        </xsl:when>

        <xsl:when test="$task ='body'">
            <xsl:sequence select="tei:body($model, $content, $class, $number)"/>
        </xsl:when>
        
        <xsl:when test="$task ='document'">
            <xsl:sequence select="tei:document($model, $content, $class, $number)"/>
        </xsl:when>
        
        <xsl:when test="$task ='omit'"/>
        
        <xsl:otherwise>
            <xsl:sequence select="tei:makeDefault($model, $content, $class, $number)"/>
        </xsl:otherwise>
    </xsl:choose>
    
    
</xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:block" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        <xsl:copy-of select="tei:makeElement('div', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Paragraphs</desc>
    </doc>
    <xsl:function name="tei:paragraph" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('p', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Newline</desc>
    </doc>
    <xsl:function name="tei:newline" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        <xsl:copy-of select="tei:inline($element, '', $class, $number)"/>
        <br />
    </xsl:function>
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Page break. Only a placeholder. Needs adding to.</desc>
    </doc>
    <xsl:function name="tei:break" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('br', '', '', '')"/>
        
    </xsl:function>
    
<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Inline element. If there's something going on re class or rendition keep span and attributes</desc>
     </doc>
<xsl:function name="tei:inline" as="node()*">
        <xsl:param name="element"/>
         <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:choose>
            <xsl:when test="string($class)">
                <xsl:copy-of select="tei:makeElement('span', concat($class, $number), $content, '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="string($content)">
                <xslo:apply-templates>
                    <xsl:if test="$content!='.'"><xsl:attribute name="select"><xsl:value-of select="$content"/></xsl:attribute></xsl:if>
                </xslo:apply-templates>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
</xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Inline text. </desc>
    </doc>
    <xsl:function name="tei:text" as="node()*">
        <xsl:param name="content"/>
	<xslo:value-of>
	  <xsl:attribute name="select"><xsl:value-of select="$content"/></xsl:attribute>
	</xslo:value-of>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Simple heading</desc>
    </doc>
    <xsl:function name="tei:heading" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="type"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:variable name="container">
            <xsl:choose>
                <xsl:when test="$type='verse'">h3</xsl:when>
                <xsl:when test="$type='list'">h3</xsl:when>
                <xsl:when test="$type='table'">h3</xsl:when>
                <xsl:when test="$type='figure'">h3</xsl:when>
                <xsl:otherwise>h2</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:copy-of select="tei:makeElement($container, concat($class, $number), $content, '')"/>
        </xsl:function>


    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Hierarchical heading</desc>
    </doc>
    <xsl:function name="tei:multiheading" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="type"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        <xsl:param name="root"/>
        
	<xsl:for-each select="$element">
          <xslo:variable name="depth">
	    <xslo:value-of>
	      <xsl:attribute name="select">
		<xsl:text>count(ancestor::</xsl:text>
		<xsl:value-of select="$root"/>
		<xsl:text>)</xsl:text>
	      </xsl:attribute>
	    </xslo:value-of>
	  </xslo:variable>
	</xsl:for-each>
	<xslo:element>
	  <xsl:attribute name="name">
	    <xsl:text>{concat('h',$depth)}</xsl:text>
	  </xsl:attribute>

        <xsl:if test="string($class)"><xslo:attribute name="class"><xsl:value-of select="$class"/></xslo:attribute></xsl:if>
        <xsl:if test="string($content)">
          <xslo:apply-templates>
            <xsl:if test="$content!='.'"><xslo:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xslo:attribute></xsl:if>
          </xslo:apply-templates>
        </xsl:if>
	</xslo:element>
        </xsl:function>


    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Choice element</desc>
    </doc>
    <xsl:function name="tei:alternate" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="altcontent"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('span', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Date element</desc>
    </doc>
    <xsl:function name="tei:date" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('span', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with lists</desc>
    </doc>
    <xsl:function name="tei:list" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('ul', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with rows</desc>
    </doc>
    <xsl:function name="tei:row" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('tr', concat($class, $number), $content, '')"/>
    </xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with cells</desc>
    </doc>
    <xsl:function name="tei:cell" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        <xsl:copy-of select="tei:makeElement('td', concat($class, $number), $content, '')"/>
    </xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with tables</desc>
    </doc>
    <xsl:function name="tei:table" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('table', concat($class, $number), $content, '')"/>
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with list items</desc>
    </doc>
    <xsl:function name="tei:listItem" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('li', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Anchor</desc>
    </doc>
    <xsl:function name="tei:anchor" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xslo:variable name="cId">
            <xslo:value-of select="generate-id(.)"/>
        </xslo:variable>
        
        <sup>
        <xslo:element name="a">
            <xsl:if test="string($class)"><xslo:attribute name="class"><xsl:value-of select="$class"/><xsl:value-of select="$number"/></xslo:attribute></xsl:if>
            <xslo:attribute name="name">A<xslo:value-of select="$cId"/></xslo:attribute>
            <xslo:attribute name="href">#N<xslo:value-of select="$cId"/></xslo:attribute>
            <xslo:number level="any"/>
        </xslo:element>
        </sup>
        
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Table of contents</desc>
    </doc>
    <xsl:function name="tei:index" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>

	<div id="toc">Table of contents</div>

    </xsl:function>
    
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Note</desc>
    </doc>
    <xsl:function name="tei:note" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="place"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:variable name="location">
            <xsl:choose>
                <xsl:when test="$place='@place'">foot</xsl:when>
                <xsl:otherwise>floating</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
            <xslo:variable name="place" select="{$place}"/>
            <xslo:variable name="class" select="{$class}"/>
            <xslo:variable name="number" select="{$number}"/>
	    <xsl:element name="span">
	      <xslo:attribute name="class"><xslo:value-of select="($place, concat($class, $number))"/></xslo:attribute>
              <xslo:apply-templates>
                <xsl:if test="$content!='.'"><xslo:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xslo:attribute></xsl:if>
              </xslo:apply-templates>
            </xsl:element>
        
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>End note</desc>
    </doc>
    <xsl:function name="tei:endnotes" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <hr/>
        <ul>
            <xsl:if test="string($class)"><xsl:attribute name="class"><xsl:value-of select="concat($class, $number)"/></xsl:attribute></xsl:if>
            
            <xslo:for-each>
                    <xsl:if test="$content!='.' and string($content)"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
                
                <xslo:variable name="cId">
                    <xslo:value-of select="generate-id(.)"></xslo:value-of>
                </xslo:variable>
                <li>
                    <xslo:element name="a">
                        <xslo:attribute name="name">N<xslo:value-of select="$cId"/></xslo:attribute>
                        <xslo:attribute name="href">#A<xslo:value-of select="$cId"/></xslo:attribute>
                        &#8629; <xslo:number level="any"/>
                    </xslo:element>
                <xslo:text> </xslo:text><xslo:apply-templates/>
                </li>
            </xslo:for-each>
        </ul>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Glyph</desc>
    </doc>
    <xsl:function name="tei:glyph" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
	<xsl:choose>
	  <xsl:when test="$content='char:EOLhyphen'"/>
	</xsl:choose>
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Figure</desc>
    </doc>
    <xsl:function name="tei:figure" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
                <xslo:choose>
                    <!-- if @facs use it to display figure, else display placeholder -->
                    <xslo:when test="string(@facs)">
                            <xsl:element name="img">
                                <xsl:if test="string($class)"><xsl:attribute name="class"><xsl:value-of select="concat($class, $number)"/></xsl:attribute></xsl:if>
                                <xslo:attribute name="src"><xslo:value-of select="@facs"/></xslo:attribute>
                            </xsl:element>
                    </xslo:when>
                    <xslo:otherwise>
                        <span class="verybig">�</span>
                    </xslo:otherwise>
                </xslo:choose>
                
    </xsl:function>
    

    <xsl:function name="tei:makeElement" as="node()*">
        <xsl:param name="name"/>
        <xsl:param name="class"/>
        <xsl:param name="content"/>
        <xsl:param name="anchorName"/>
        
    <xsl:element name="{$name}">
        <xsl:if test="string($class)"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if>
        <xsl:if test="string($anchorName)"><xsl:attribute name="name"><xsl:value-of select="$anchorName"/></xsl:attribute></xsl:if>
        <xsl:if test="string($content)">
        <xslo:apply-templates>
            <xsl:if test="$content!='.'"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
        </xslo:apply-templates>
        </xsl:if>
    </xsl:element>
    </xsl:function>
    
    <xsl:function name="tei:makeDefault" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <div>
            <xsl:if test="string($class)">
                <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            </xsl:if>
            <xslo:apply-templates/>
        </div>
        
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Join together the renditions into a CSS section</desc>
    </doc>
    <xsl:function name="tei:getRenditions" as="node()*">
        <xsl:param name="content"/>
        
        <link rel="StyleSheet" href="{$css}" type="text/css"/>
        <style>

	      span.foot {
	      float: bottom;
	      display: block;
	      background-color: red;
	      font-size: smaller;
	      }
	      
              span.floating {
              float: right;
              display: block;
              background-color: #C0C0C0;
              font-size: smaller;
              }
                
              <xsl:for-each select="$content">
                <xsl:for-each select=".//model">
                  <xsl:variable name="container"><xsl:copy-of select="tei:simpleContainer(substring-before(@behaviour,'('))"/></xsl:variable>
                  <!-- use position of a model to distinguish between classes for differing behaviours -->
                  <xsl:variable name="elname"><xsl:value-of select="ancestor::elementSpec/@ident"/></xsl:variable>
                  <xsl:variable name="pos"   
				select="if  (count(../model) &gt; 1) then position() else  ''"/>        
                  <xsl:for-each select="./rendition">
                    <xsl:variable name="scope" select="@scope"/>
                    <xsl:variable name="rendition" select="normalize-space(.)"/>
                    
                    <xsl:for-each select="$container/node()">
                      <xsl:value-of select="concat(.,'.',$elname,$pos)"/>
                      <xsl:if test="string($scope)">
                        <xsl:text>:</xsl:text><xsl:value-of select="$scope"/>
                      </xsl:if>
                      <xsl:text> {</xsl:text>
                      <xsl:value-of select="$rendition"/>
                      <xsl:text>}</xsl:text>
                      <xsl:text>&#xa;</xsl:text>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:for-each>
                
            </style>

    </xsl:function>
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>whole document</desc>
    </doc>

    <xsl:function name="tei:document" as="node()*">
        <xsl:param name="element"/>
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
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <body>
          <xsl:if test="string($content)">
            <xslo:apply-templates>
              <xsl:if test="$content!='.'"><xslo:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xslo:attribute></xsl:if>
            </xslo:apply-templates>
          </xsl:if>
	</body>
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>doc title</desc>
    </doc>

    <xsl:function name="tei:title" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
      <title>
            <xsl:if test="string($content)">
                <xslo:apply-templates>
                    <xsl:if test="$content!='.'"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
                </xslo:apply-templates>
            </xsl:if>
      </title>
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>metadata</desc>
    </doc>
    <xsl:function name="tei:metadata" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
      <head>
        <xsl:for-each select="$TOP">
	  <xsl:copy-of select="tei:getRenditions(//elementSpec)"/>
	</xsl:for-each>
	<!-- jQuery -->
	<script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
	<!-- table of contents generation -->
	<script type="text/javascript" charset="utf8" src="{$js}"></script>
        <xsl:if test="string($content)">
          <xslo:apply-templates>
            <xsl:if test="$content!='.'"><xslo:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xslo:attribute></xsl:if>
          </xslo:apply-templates>
        </xsl:if>
	
      </head>
    </xsl:function>
      
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Determine the container(s) for the function</desc>
    </doc>
    <xsl:function name="tei:simpleContainer">
        <xsl:param name="name"/>

        <xsl:choose>
            <xsl:when test="$name = 'alternate'"><gi>span</gi></xsl:when>
            <xsl:when test="$name = 'anchor'"><gi>a</gi></xsl:when>
            <xsl:when test="$name = 'block'"><gi>div</gi></xsl:when>
            <xsl:when test="$name = 'break'"><gi>span</gi></xsl:when>
            <xsl:when test="$name = 'cell'"><gi>td</gi></xsl:when>
            <xsl:when test="$name = 'date'"><gi>span</gi></xsl:when>
            <xsl:when test="$name = 'endnotes'"><gi>div</gi></xsl:when>
            <xsl:when test="$name = 'graphic'"><gi>img</gi></xsl:when>
            <xsl:when test="$name = 'heading'"><gi>h1</gi><gi>h2</gi><gi>h3</gi></xsl:when>
            <xsl:when test="$name = 'inline'"><gi>span</gi></xsl:when>
            <xsl:when test="$name = 'list'"><gi>ol</gi><gi>ul</gi></xsl:when>
            <xsl:when test="$name = 'listItem'"><gi>li</gi></xsl:when>
            <xsl:when test="$name = 'newline'"><gi>br</gi></xsl:when>
            <xsl:when test="$name = 'note'"><gi>span</gi></xsl:when>
            <xsl:when test="$name = 'paragraph'"><gi>p</gi></xsl:when>
            <xsl:when test="$name = 'row'"><gi>tr</gi></xsl:when>
            <xsl:when test="$name = 'table'"><gi>table</gi></xsl:when>
            <xsl:otherwise>div</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    


    <xsl:function name="tei:doModel" as="node()*">
      <xsl:param name="context"/>
      <xsl:param name="iden"/>
      <xsl:param name="construct"/>
      <xsl:param name="number"/>
      <xsl:choose>
	<xsl:when test="$context/@predicate">
	  <xsl:element name="xsl:{$construct}">
	    <xsl:attribute name="test" select="$context/@predicate"/>
	    <xsl:sequence select="tei:matchFunction($iden, $context, $iden, $number)"/>
	  </xsl:element>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:sequence select="tei:matchFunction($iden, $context, $iden, $number)"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:function>

    <xsl:function name="tei:findModelPosition" as="xs:string">
      <xsl:param name="context"/>
      <xsl:for-each select="$context">
	<xsl:variable name="n">
	  <xsl:number from="elementSpec" level="any" count="model"/>
	</xsl:variable>
        <xsl:value-of   select="if  (count(parent::*/model) &gt; 1 ) then   $n else ''"/>
      </xsl:for-each>
    </xsl:function>

</xsl:stylesheet>

