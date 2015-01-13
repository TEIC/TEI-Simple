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

<!--Description: paragraph(.)
Description: omit()
Description: inline(.)
Description: block(.)
Description: anchor(@xml:id)
Description: index(.)
Description: body(.)
Description: list(.)
Description: listItem(.)
Description: break('column')
Description: cell(.)
Description: alternate(corr[1],sic[1])
Description: cit(.)
Description: section(.)
Description: glyph(@ref)
Description: graphic(@url)
Description: heading(.)
Description: break('line')
Description: note(.,@place)
Description: link(@target,@target)
Description: row(.)
-->


<xsl:function name="tei:matchFunction">
    <xsl:param name="elName"/>
    <xsl:param name="model"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:variable name="content"
        select="if($model/@behaviour) then substring-before(concat(substring-before(substring-after($model/@behaviour, '('), ')'), ','), ',') else '.'"/>
    
<!--    <xsl:message> content <xsl:value-of select="$content"/></xsl:message>
--><!--    <xsl:variable name="modelId"><xsl:value-of select="generate-id()"/></xsl:variable>
    <xsl:variable name="number" select="tei:findModelPosition($models, $modelId)"/>
    <xsl:variable name="class" select="if(@class) then @class else parent::node()/@ident"/>
--> 
    
    <xsl:choose>
        <xsl:when test="starts-with($model/@behaviour, 'anchor(')">
            <xsl:sequence select="tei:anchor($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'makeMarginalNote')">
            <xsl:sequence select="tei:note($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'note(')">
            <xsl:sequence select="tei:note($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'makeEndnotes')">
            <xsl:sequence select="tei:endnotes($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'block(')">
<!--            <xsl:message>block for <xsl:value-of select="$elName"/> <xsl:text> </xsl:text><xsl:value-of select="$model/@predicate"/> <xsl:text> </xsl:text> <xsl:value-of select="$model/@behaviour"/></xsl:message>
-->            <xsl:sequence select="tei:block($elName, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'heading')">
            <xsl:variable name="type" select="if($model/@behaviour) then substring-before(substring-after(concat(substring-before(substring-after($model/@behaviour, '('), ')'), ','), ','), ',') else ''"/>
            
            <xsl:sequence select="tei:heading($model, $content, $type, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'alternate(')">
            <xsl:sequence select="tei:alternate($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'makeDate')">
            <xsl:sequence select="tei:date($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'list(')">
            <xsl:sequence select="tei:list($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'listItem(')">
            <xsl:sequence select="tei:listItem($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'inline(')">
            <xsl:sequence select="tei:inline($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'makeNewline')">
            <xsl:sequence select="tei:newline($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'break')">
            <xsl:sequence select="tei:break($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'paragraph(')">
            <xsl:sequence select="tei:paragraph($model, $content, $class, $number)"/>
        </xsl:when>
        <xsl:when test="starts-with($model/@behaviour, 'figure(')">
            <xsl:sequence select="tei:figure($model, $content, $class, $number)"/>
        </xsl:when>
        
        <xsl:when test="starts-with($model/@behaviour, 'omit')"/>
        
        <xsl:otherwise>
            <xsl:sequence select="tei:makeDefault($model, $content, $class, $number)"/>
        </xsl:otherwise>
    </xsl:choose>
    
    
</xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:block" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
<!--        <xsl:message>block for <xsl:value-of select="$element"/> <xsl:text> *</xsl:text><xsl:value-of select="$content"/> <xsl:text>* </xsl:text> <xsl:value-of select="$class"/></xsl:message>
-->        
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
        <desc>Inline element. If there's something going on re class or rendition keep span and attributes, otherwise make it just text of selected content</desc>
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
                    <xsl:if test="$content!='.'"><xsl:attribute name="select"><xsl:value-of select="$content"></xsl:value-of></xsl:attribute></xsl:if>
                </xslo:apply-templates>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:heading" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="type"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:variable name="container">
            <xsl:choose>
                <xsl:when test="$type='h1'">h1</xsl:when>
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
        <desc>Choice element</desc>
    </doc>
    <xsl:function name="tei:alternate" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
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
        
        <xsl:copy-of select="tei:makeElement('span', concat($class, $number), substring-before($content, ','), '')"/>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Placeholder for doing something sensible with list items</desc>
    </doc>
    <xsl:function name="tei:listItem" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <xsl:copy-of select="tei:makeElement('li', concat($class, $number), substring-before($content, ','), '')"/>
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
        <desc>Note</desc>
    </doc>
    <xsl:function name="tei:note" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <!-- relies on css for the positioning and formatting of the note block -->
        <xsl:copy-of select="tei:makeElement('span', concat($class, $number), $content, '')"/>
    </xsl:function>
    
    

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Marginal note</desc>
    </doc>
    <xsl:function name="tei:makeMarginalNote" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        <xsl:param name="number"/>
        
        <!-- relies on css for the positioning and formatting of the note block -->
        <xsl:copy-of select="tei:makeElement('span', concat($class, $number), $content, '')"/>
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
        <desc>Block level element</desc>
    </doc>
    <xsl:function name="tei:makeHTMLHeader" as="node()*">
        <xsl:param name="element"/>
        <xsl:param name="content"/>
        <xsl:param name="class"/>
        
        <head>
                <meta charset="UTF-8" />
                <title>
                    TEI-Simple: transform to html generated from odd file.
                </title>
                <link rel="StyleSheet" href="{$css}" type="text/css"/>
            <style>
                <xsl:for-each select="$content">
                        <xsl:for-each select=".//tei:model">
                            <xsl:variable name="container"><xsl:copy-of select="tei:simpleContainer(@behaviour)"/></xsl:variable>
                            <!-- use position of a model to distinguish between classes for differing behaviours -->
                            <xsl:variable name="elname"><xsl:value-of select="ancestor::tei:elementSpec/@ident"/></xsl:variable>
                            <xsl:variable name="pos"><xsl:value-of select="position()"/></xsl:variable>

                            
                            <xsl:for-each select="./tei:rendition">
                                <xsl:variable name="scope" select="@scope"/>
                                <xsl:variable name="rendition" select="."/>
                                
                                <xsl:for-each select="$container/node()">
                                    <xsl:value-of select="."/><xsl:text>.</xsl:text><xsl:value-of select="$elname"/><xsl:value-of select="$pos"/>
                                
                            <xsl:if test="string($scope)">
                                <xsl:text>::</xsl:text><xsl:value-of select="$scope"/>
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
            </head>
    </xsl:function>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Determine the container(s) for the function</desc>
    </doc>
    <xsl:function name="tei:simpleContainer">
        <xsl:param name="name"/>

<xsl:choose>
    <xsl:when test="starts-with($name, 'anchor')"><gi>a</gi></xsl:when>
    <xsl:when test="starts-with($name, 'note')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'makeMarginalNote')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'endnotes')"><gi>div</gi></xsl:when>
    <xsl:when test="starts-with($name, 'block')"><gi>div</gi></xsl:when>
    <xsl:when test="starts-with($name, 'heading')"><gi>h2</gi><gi>h3</gi><gi>h1</gi></xsl:when>
    <xsl:when test="starts-with($name, 'alternate')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'date')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'list(')"><gi>ol</gi><gi>ul</gi></xsl:when>
    <xsl:when test="starts-with($name, 'listItem')"><gi>li</gi></xsl:when>
    <xsl:when test="starts-with($name, 'inline')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'newline')"><gi>br</gi></xsl:when>
    <xsl:when test="starts-with($name, 'break')"><gi>span</gi></xsl:when>
    <xsl:when test="starts-with($name, 'paragraph')"><gi>p</gi></xsl:when>
    <xsl:when test="starts-with($name, 'figure')"><gi>img</gi></xsl:when>
    <xsl:otherwise>div</xsl:otherwise>
</xsl:choose>
    </xsl:function>
    
    <xsl:function name="tei:findModelPosition" as="xs:string">
        <xsl:param name="models"/>
        <xsl:param name="modelId"/>
        <xsl:variable name="positions">
            <xsl:for-each select="$models">
                <xsl:if test="generate-id(.)=$modelId">
                    <xsl:value-of select="position()"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$positions/string()"><xsl:value-of select="$positions"/></xsl:when>
            <!-- why this happen? -->
            <xsl:otherwise>XYZ</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    
</xsl:stylesheet>