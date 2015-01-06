<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
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
      <p>Author: See AUTHORS</p>
      <p>Id: $Id$</p>
      <p>Copyright: 2014, TEI Consortium</p>
    </desc>
  </doc>


<xsl:param name="css">simple.css</xsl:param>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:makeBlock" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <xsl:copy-of select="tei:makeElement('div', $element/@class, $content, '')"/>
         
        
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Paragraphs</desc>
    </doc>
    <xsl:function name="tei:makeParagraph" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <xsl:copy-of select="tei:makeElement('p', $element/@class, $content, '')"/>
    </xsl:function>
    
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Newline</desc>
    </doc>
    <xsl:function name="tei:makeNewline" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:copy-of select="tei:makeInline($element, '')"/>
        <br />
    </xsl:function>
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Page break. Only a placeholder. Needs adding to.</desc>
    </doc>
    <xsl:function name="tei:makePageBreak" as="node()*">
        <xsl:param name="element"/>
        <xslo:text>[Page]</xslo:text>
    </xsl:function>
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Inline element. If there's something going on re class or rendition keep span and attributes, otherwise make it just text of selected content</desc>
    </doc>
    <xsl:function name="tei:makeInline" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <xsl:choose>
            <xsl:when test="string($element/@class)">
                <xsl:copy-of select="tei:makeElement('span', $element/@class, $content, '')"/>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="string($content)">
                <xslo:apply-templates>
                    <xsl:if test="$content!='.'"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
                </xslo:apply-templates>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:makeHeader" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>

        <xsl:copy-of select="tei:makeElement('span', $element/@class, $content, '')"/>
        </xsl:function>


    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Anchor</desc>
    </doc>
    <xsl:function name="tei:makeNoteAnchor" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <xslo:variable name="cId">
            <xslo:value-of select="generate-id(.)"></xslo:value-of>
        </xslo:variable>
        
        <sup>
        <xslo:element name="a">
            <xslo:attribute name="name">A<xslo:value-of select="$cId"/></xslo:attribute>
            <xslo:attribute name="href">#N<xslo:value-of select="$cId"/></xslo:attribute>
            <xslo:number level="any"/>
        </xslo:element>
        </sup>
        
    </xsl:function>
    
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Marginal note</desc>
    </doc>
    <xsl:function name="tei:makeMarginalNote" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <!-- relies on css for the positioning and formatting of the note block -->
        <xsl:copy-of select="tei:makeElement('span', $element/@class, $content, '')"/>
    </xsl:function>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>End note</desc>
    </doc>
    <xsl:function name="tei:makeEndnotes" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
        <hr/>
        <ul>
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
        <desc>Title Page</desc>
    </doc>
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Figure</desc>
    </doc>
    <xsl:function name="tei:makeFigure" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        
                <xslo:choose>
                    <!-- if @facs use it to display figure, else display placeholder -->
                    <xslo:when test="string(@facs)">
                            <xsl:element name="img">
                                
                        <xslo:attribute name="src"><xslo:value-of select="@facs"/></xslo:attribute>
                            </xsl:element>
                    </xslo:when>
                    <xslo:otherwise>                <span class="verybig">�</span>
                    </xslo:otherwise>
                </xslo:choose>
                
    </xsl:function>
    

    <xsl:function name="tei:makeElement" as="node()*">
        <xsl:param name="name"/>
        <xsl:param name="class"/>
        <xsl:param name="content"/>
        <xsl:param name="nameA"/>
        
    <xsl:element name="{$name}">
        <xsl:if test="string($class)"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if>
        <xsl:if test="string($nameA)"><xsl:attribute name="name"><xsl:value-of select="$nameA"/></xsl:attribute></xsl:if>
        <xslo:apply-templates>
            <xsl:if test="$content!='.' and string($content)"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
        </xslo:apply-templates>
    </xsl:element>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:makeHTMLHeader" as="node()*">
            <head>
                <meta charset="UTF-8" />
                <title>
                    TEI-Simple: transform to html generated from odd file.
                </title>
                <link rel="StyleSheet" href="{$css}" type="text/css"/>
 
            </head>
                
    </xsl:function>
    

</xsl:stylesheet>