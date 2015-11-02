<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
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

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Block level element</desc>
  </doc>
  <xsl:function name="tei:block" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model, 'par',concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Paragraphs</desc>
  </doc>
  <xsl:function name="tei:paragraph" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'par', concat($class, $number), '', $content, '', '')"/>
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
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'linebreak', '', '', '', '', '')"/>
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
        <xsl:copy-of select="tei:makeElement($model,'inline', concat($class, $number), '', $content, '', '')"/>
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
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:for-each select="$model">
      <xslo:variable name="depth">
        <xslo:value-of>
          <xsl:attribute name="select">
            <xsl:text>count(ancestor::</xsl:text>
            <xsl:text>{name(..)}</xsl:text>
            <xsl:text>)</xsl:text>
          </xsl:attribute>
        </xslo:value-of>
      </xslo:variable>
    </xsl:for-each>
    <xslo:element>
      <xsl:attribute name="name">
        <xsl:text>{concat('h',$depth)}</xsl:text>
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
    <xsl:text>\hyperlink{</xsl:text>
    <xslo:value-of>
      <xsl:attribute name="select">
	<xsl:value-of select="$target"/>
      </xsl:attribute>
    </xslo:value-of>
    <xsl:text>}{</xsl:text>
      <xsl:sequence select="tei:applyTemplates($content)"/>
    <xsl:text>}</xsl:text>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with lists</desc>
  </doc>
  <xsl:function name="tei:list" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeEnvironment($model,'itemize', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with rows</desc>
  </doc>
  <xsl:function name="tei:row" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:sequence select="tei:applyTemplates($content)"/>
    <xsl:text>\\&#10;</xsl:text>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with cells</desc>
  </doc>
  <xsl:function name="tei:cell" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:text>&amp;</xsl:text>
    <xsl:sequence select="tei:applyTemplates($content)"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with tables</desc>
  </doc>
  <xsl:function name="tei:table" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeEnvironment($model,'table', concat($class, $number), '', $content, '', '')"/>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Placeholder for doing something sensible with list items</desc>
  </doc>
  <xsl:function name="tei:listItem" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:copy-of select="tei:makeElement($model,'item', concat($class, $number), '', $content, '', '')"/>
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
    <desc>List of objects  eg TOC)</desc>
  </doc>
  <xsl:function name="tei:index" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:param name="type"/>
    <xsl:choose>
      <xsl:when test="$type='toc'">
	<xsl:text>\tableofcontents &#10;</xsl:text>
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
            <xslo:value-of select="if (@n) then   @n else $N"/>
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
        <span>
          <xslo:attribute name="class">
            <xslo:value-of select="($place, concat($class, $number))"/>
          </xslo:attribute>
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
    <xsl:param name="content"/>
    <xsl:param name="width"/>
    <xsl:param name="height"/>
    <xsl:param name="scale"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <img>
      <xsl:attribute name="src">{<xsl:value-of select="$content"/>}</xsl:attribute>
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
    <xsl:text>\</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text> </xsl:text>
      <xsl:sequence select="tei:applyTemplates($content)"/>
      <xsl:if test="$nested instance of element()">
        <xsl:sequence select="$nested"/>
      </xsl:if>
  </xsl:function>

  <xsl:function name="tei:makeEnvironment" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="name"/>
    <xsl:param name="class"/>
    <xsl:param name="title"/>
    <xsl:param name="content"/>
    <xsl:param name="anchorName"/>
    <xsl:param name="nested"/>
    <xsl:text>\begin{</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>}</xsl:text>
      <xsl:sequence select="tei:applyTemplates($content)"/>
      <xsl:if test="$nested instance of element()">
        <xsl:sequence select="$nested"/>
      </xsl:if>
    <xsl:text>\end{</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>}</xsl:text>
  </xsl:function>
  <xsl:function name="tei:makeDefault" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    \par
      <xsl:sequence select="tei:attributes($model)"/>
      <xslo:apply-templates/>    
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>whole document</desc>
  </doc>
  <xsl:function name="tei:document" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
<xslo:text>
\documentclass[11pt,twoside]{book}\makeatletter
\catcode`⃥=\active \def⃥{\textbackslash}
\catcode`❴=\active \def❴{\{}
\catcode`❵=\active \def❵{\}}
\def\textJapanese{\fontspec{Kochi Mincho}}
\def\textChinese{\fontspec{HAN NOM A}\XeTeXlinebreaklocale "zh"\XeTeXlinebreakskip = 0pt plus 1pt }
\def\textKorean{\fontspec{Baekmuk Gulim} }
\DeclareTextSymbol{\textpi}{OML}{25}
\def\textcal#1{{\fontspec{Lucida Calligraphy}#1}}
\def\textgothic#1{{\fontspec{Lucida Blackletter}#1}}
\def\textlarge#1{{\large #1}}
\def\textoverbar#1{\ensuremath{\overline{#1}}}
\def\textsmall#1{{\small #1}}
\def\textsubscript#1{\@textsubscript{\selectfont#1}}
\def\textxi{\ensuremath{\xi}}
\def\titlem{\itshape}
\IfFileExists{xcolor.sty}%
  {\RequirePackage{xcolor}}%
  {\RequirePackage{color}}
\usepackage[normalem]{ulem}
\usepackage{array}
\usepackage{colortbl}
\usepackage{endnotes}
\usepackage{fancyhdr}
\usepackage{fancyvrb}
\usepackage{fontspec}
\usepackage{framed}
\usepackage[a4paper,twoside,lmargin=1in,rmargin=1in,tmargin=1in,bmargin=1in,marginparwidth=0.75in]{geometry}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{ifxetex}
\usepackage{longtable}
\usepackage{marginnote}
\usepackage{relsize}
\usepackage{wrapfig}
\usepackage{xunicode}
\renewcommand*{\marginfont}{\itshape\footnotesize}
\def\theendnote{\@alph\c@endnote}
\def\Gin@extensions{.pdf,.png,.jpg,.mps,.tif}
\pagestyle{fancy}
\hyperbaseurl{}
\paperwidth210mm
\paperheight297mm
\def\chaptername{Chapter}
\def\tableofcontents{\section*{\contentsname}\@starttoc{toc}}
\thispagestyle{empty}
\let\tabcellsep&amp; 
\IfFileExists{tei.sty}{\RequirePackage{tei}}{}
</xslo:text>
<xsl:for-each select="$TOP"><xsl:message>
  <xsl:copy-of select="tei:getRenditions(//elementSpec)"/></xsl:message>
</xsl:for-each>
<xslo:text>
\begin{document}
</xslo:text>
      <xslo:apply-templates/>
  <xslo:text>           
\theendnotes
\end{document}
  </xslo:text>
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>body document</desc>
  </doc>
  <xsl:function name="tei:body" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>

      <xsl:sequence select="tei:applyTemplates($content)"/>

  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>doc title</desc>
  </doc>
  <xsl:function name="tei:title" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    \title{<xsl:sequence select="tei:applyTemplates($content)"/>}
  </xsl:function>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>metadata</desc>
  </doc>
  <xsl:function name="tei:metadata" as="node()*">
    <xsl:param name="model"/>
    <xsl:param name="content"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
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
      <xsl:for-each select="$content">
        <xsl:if test="position()=1">
          <xsl:for-each select="//rendition[@xml:id and not(parent::model)]">
            <xsl:text>\def\simple_</xsl:text>
            <xsl:value-of select="@xml:id"/>
            <xsl:text> { </xsl:text>
            <xsl:value-of select="tei:cssToLaTeX(.)"/>
            <xsl:text> } 
</xsl:text>
          </xsl:for-each>
        </xsl:if>
        <xsl:for-each select=".//model">
          <xsl:variable name="container">
            <xsl:copy-of select="tei:simpleContainer(substring-before(@behaviour,'('))"/>
          </xsl:variable>
          <!-- use position of a model to distinguish between classes for differing behaviours -->
          <xsl:variable name="elname">
            <xsl:value-of select="ancestor::elementSpec/@ident"/>
          </xsl:variable>
          <xsl:variable name="pos" select="if  (count(../model) &gt; 1) then position() else  ''"/>
          <xsl:for-each select="./rendition">
            <xsl:variable name="scope" select="@scope"/>
            <xsl:variable name="rendition" select="tei:cssToLaTeX(.)"/>
            <xsl:for-each select="$container/node()">
              <xsl:value-of select="concat(.,'\def\',$elname,$pos)"/>
              <xsl:text>#1{</xsl:text>

	      <xsl:for-each select="$rendition/env">
	      <xsl:value-of select="concat('\begin{',.,'}')"/>
	      </xsl:for-each>

	      <xsl:for-each select="$rendition/cmd">
		<xsl:value-of select="concat('\',.,'{')"/>
	      </xsl:for-each>

	      <xsl:for-each select="$rendition/decl">
		<xsl:value-of select="concat('\',.,' ')"/>
	      </xsl:for-each>

	      <xsl:text>#1</xsl:text>

	      <xsl:for-each select="$rendition/cmd">
		<xsl:text>}</xsl:text>
	      </xsl:for-each>

	      <xsl:for-each select="$rendition/env">
	      <xsl:value-of select="concat('\end{',.,'}')"/>
            <xsl:text>}
</xsl:text>
	      </xsl:for-each>
	    </xsl:for-each>
	  </xsl:for-each>
	</xsl:for-each>
      </xsl:for-each>
  </xsl:function>

  <xsl:function name="tei:processLocalRendition" as="node()*">

    <xslo:template name="localrendition">
      <xslo:if test="@rendition">
	<xslo:variable name="values">
	  <xslo:for-each select="tokenize(normalize-space(@rendition),' ')">
	    <xslo:choose>
	      <xslo:when test="starts-with(.,'#')">
		<xslo:sequence select="substring-after(.,'#')"/>
	      </xslo:when>
	      <xslo:when test="starts-with(.,'simple:')">
		<xslo:sequence select="replace(.,':','_')"/>
	      </xslo:when>
	      <xslo:otherwise>
		<xslo:for-each select="document(.)">
		  <xslo:sequence select="@xml:id"/>
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
    

    <xslo:function name="tei:escapeChars" override="yes">
      <xslo:param name="letters"/>
      <xslo:param name="context"/>
      <xslo:value-of>
	<xsl:attribute name="select">
	  <xsl:text>replace(replace(replace(replace(replace(translate($letters,'ſ&#10;','s '), 
		  '\\','\\textbackslash '),
		  '_','\\textunderscore '),
		  '\^','\\textasciicircum '),
		  '~','\\textasciitilde '),
		  '([\}\{%&amp;\$#])','\\$1')</xsl:text>
	</xsl:attribute>
      </xslo:value-of>
    </xslo:function>
  </xsl:function>

    <xsl:function name="tei:attributes" as="node()*">
      <xsl:param name="model"/>
      <xslo:if test="@xml:id">
	<xslo:text>\label{</xslo:text>
	<xslo:value-of select="@xml:id"/>
	<xslo:text>}</xslo:text>
      </xslo:if>
      <xsl:if test="$model/@useSourceRendition='true'">
	<xslo:call-template name="localrendition"/>
      </xsl:if>
    </xsl:function>

<!--
background-color:#F0F0F0
border-bottom:solid 1pt blue
border-top:solid 1pt blue
border:1px solid black
border:solid black 1pt
color:green
color:grey
color:red
display:block
float:right
list-style:ordered
margin-bottom:0.5em
margin-bottom:2em
margin-left:10px
margin-left:1em
margin-left:2em
margin-right:10px
margin-right:2em
margin-top:1em
margin-top:2em
margin:6pt
margin:auto
max-width:80%
padding:5px
text-decoration:line-through
text-decoration:underline
white-space:nowrap
-->
    <xsl:function name="tei:cssToLaTeX" as="node()*">
      <xsl:param name="css"/>
      <xsl:for-each select="tokenize(normalize-space($css),';')">
	<xsl:analyze-string select="." regex="\s*([A-z0-9\-]+)\s*:\s*(.*)">
	  <xsl:matching-substring>
	    <xsl:choose>
	      <xsl:when test="regex-group(1)='content'">
		<text><xsl:value-of select="regex-group(2)"/></text>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='font-family'">
		<decl>
		<xsl:choose>
		  <xsl:when test="regex-group(2)='cursive'">\textcal</xsl:when>
		  <xsl:when test="regex-group(2)='fantasy'">\textgothic</xsl:when>
		  <xsl:when test="regex-group(2)='monospace'">\texttt</xsl:when>
		</xsl:choose>
		</decl>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='font-style'">
		<decl>
		<xsl:choose>
		  <xsl:when test="regex-group(2)='italic'">\itshape</xsl:when>
		</xsl:choose>
		</decl>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='font-weight'">
		<decl>
		<xsl:choose>
		  <xsl:when test="regex-group(2)='bold'">\bfseries</xsl:when>
		</xsl:choose>
		</decl>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='font-size'">
		<decl>
		<xsl:choose>
		  <xsl:when  test="regex-group(2)='large'">\large</xsl:when>
		  <xsl:when  test="regex-group(2)='larger'">\larger</xsl:when>
		  <xsl:when  test="regex-group(2)='small'">\small</xsl:when>
		  <xsl:when  test="regex-group(2)='smaller'">\smaller</xsl:when>
		  <xsl:when
		      test="matches(regex-group(2),'^[0-9]')">
		    <xsl:text>\font-size</xsl:text>
		    <xsl:value-of select="replace(regex-group(2),'(^[0-9\.]+)(.+)','{$1}{$2}')"/>
		 </xsl:when>
		</xsl:choose>
		</decl>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='text-align'">
		<env>
		<xsl:choose>
		  <xsl:when test="regex-group(2)='left'">\raggedright</xsl:when>
		  <xsl:when test="regex-group(2)='right'">\raggedleft</xsl:when>
		  <xsl:when test="regex-group(2)='center'">\centering</xsl:when>
		</xsl:choose>
		</env>
	     </xsl:when>
	      <xsl:when test="regex-group(1)='text-decoration'">
		<cmd>
		<xsl:choose>
		  <xsl:when test="regex-group(2)='underline'">\underline</xsl:when>
		  <xsl:when test="regex-group(2)='strikethrough'">\sout</xsl:when>
		</xsl:choose>
		</cmd>
	     </xsl:when>
	      <xsl:otherwise>
		<xsl:message>unrecognized CSS: <xsl:value-of
		select="regex-group(1)"/>:<xsl:value-of
		select="regex-group(2)"/></xsl:message>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:matching-substring>
	  <xsl:non-matching-substring>
		<xsl:message>unparseable CSS: <xsl:value-of select="."/></xsl:message>
	  </xsl:non-matching-substring>
	</xsl:analyze-string>
      </xsl:for-each>
    </xsl:function>


</xsl:stylesheet>
