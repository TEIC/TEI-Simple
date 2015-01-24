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
    <xsl:copy-of select="tei:makeElement($model,'br', '', '', '', '', '')"/>
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
    <xsl:param name="type"/>
    <xsl:param name="root"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:for-each select="$model">
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
<xsl:message>START DOC</xsl:message>
<xslo:text>
\documentclass[11pt,twoside]{article}\makeatletter

\IfFileExists{xcolor.sty}%
  {\RequirePackage{xcolor}}%
  {\RequirePackage{color}}
\usepackage{colortbl}
\usepackage{wrapfig}
\usepackage{ifxetex}
\ifxetex
  \usepackage{fontspec}
  \usepackage{xunicode}
  \catcode`⃥=\active \def⃥{\textbackslash}
  \catcode`❴=\active \def❴{\{}
  \catcode`❵=\active \def❵{\}}
  \def\textJapanese{\fontspec{Kochi Mincho}}
  \def\textChinese{\fontspec{HAN NOM A}\XeTeXlinebreaklocale "zh"\XeTeXlinebreakskip = 0pt plus 1pt }
  \def\textKorean{\fontspec{Baekmuk Gulim} }
  \setmonofont{DejaVu Sans Mono}
  
\else
  \IfFileExists{utf8x.def}%
   {\usepackage[utf8x]{inputenc}
      \PrerenderUnicode{–}
    }%
   {\usepackage[utf8]{inputenc}}
  \usepackage[english]{babel}
  \usepackage[T1]{fontenc}
  \usepackage{float}
  \usepackage[]{ucs}
  \uc@dclc{8421}{default}{\textbackslash }
  \uc@dclc{10100}{default}{\{}
  \uc@dclc{10101}{default}{\}}
  \uc@dclc{8491}{default}{\AA{}}
  \uc@dclc{8239}{default}{\,}
  \uc@dclc{20154}{default}{ }
  \uc@dclc{10148}{default}{>}
  \def\textschwa{\rotatebox{-90}{e}}
  \def\textJapanese{}
  \def\textChinese{}
  \IfFileExists{tipa.sty}{\usepackage{tipa}}{}
  \usepackage{times}
\fi
\def\exampleFont{\ttfamily\small}
\DeclareTextSymbol{\textpi}{OML}{25}
\usepackage{relsize}
\RequirePackage{array}
\def\@testpach{\@chclass
 \ifnum \@lastchclass=6 \@ne \@chnum \@ne \else
  \ifnum \@lastchclass=7 5 \else
   \ifnum \@lastchclass=8 \tw@ \else
    \ifnum \@lastchclass=9 \thr@@
   \else \z@
   \ifnum \@lastchclass = 10 \else
   \edef\@nextchar{\expandafter\string\@nextchar}%
   \@chnum
   \if \@nextchar c\z@ \else
    \if \@nextchar l\@ne \else
     \if \@nextchar r\tw@ \else
   \z@ \@chclass
   \if\@nextchar |\@ne \else
    \if \@nextchar !6 \else
     \if \@nextchar @7 \else
      \if \@nextchar (8 \else
       \if \@nextchar )9 \else
  10
  \@chnum
  \if \@nextchar m\thr@@\else
   \if \@nextchar p4 \else
    \if \@nextchar b5 \else
   \z@ \@chclass \z@ \@preamerr \z@ \fi \fi \fi \fi
   \fi \fi  \fi  \fi  \fi  \fi  \fi \fi \fi \fi \fi \fi}
\gdef\arraybackslash{\let\\=\@arraycr}
\def\@textsubscript#1{{\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}
\def\Panel#1#2#3#4{\multicolumn{#3}{){\columncolor{#2}}#4}{#1}}
\def\abbr{}
\def\corr{}
\def\expan{}
\def\gap{}
\def\orig{}
\def\reg{}
\def\ref{}
\def\sic{}
\def\persName{}\def\name{}
\def\placeName{}
\def\orgName{}
\def\textcal#1{{\fontspec{Lucida Calligraphy}#1}}
\def\textgothic#1{{\fontspec{Lucida Blackletter}#1}}
\def\textlarge#1{{\large #1}}
\def\textoverbar#1{\ensuremath{\overline{#1}}}
\def\textquoted#1{‘#1’}
\def\textsmall#1{{\small #1}}
\def\textsubscript#1{\@textsubscript{\selectfont#1}}
\def\textxi{\ensuremath{\xi}}
\def\titlem{\itshape}
\newenvironment{biblfree}{}{\ifvmode\par\fi }
\newenvironment{bibl}{}{}
\newenvironment{byline}{\vskip6pt\itshape\fontsize{16pt}{18pt}\selectfont}{\par }
\newenvironment{citbibl}{}{\ifvmode\par\fi }
\newenvironment{docAuthor}{\ifvmode\vskip4pt\fontsize{16pt}{18pt}\selectfont\fi\itshape}{\ifvmode\par\fi }
\newenvironment{docDate}{}{\ifvmode\par\fi }
\newenvironment{docImprint}{\vskip 6pt}{\ifvmode\par\fi }
\newenvironment{docTitle}{\vskip6pt\bfseries\fontsize{18pt}{22pt}\selectfont}{\par }
\newenvironment{msHead}{\vskip 6pt}{\par}
\newenvironment{msItem}{\vskip 6pt}{\par}
\newenvironment{rubric}{}{}
\newenvironment{titlePart}{}{\par }

\newcolumntype{L}[1]{){\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{){\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{){\raggedleft\arraybackslash}p{#1}}
\newcolumntype{P}[1]{){\arraybackslash}p{#1}}
\newcolumntype{B}[1]{){\arraybackslash}b{#1}}
\newcolumntype{M}[1]{){\arraybackslash}m{#1}}
\definecolor{label}{gray}{0.75}
\def\unusedattribute#1{\sout{\textcolor{label}{#1}}}
\DeclareRobustCommand*{\xref}{\hyper@normalise\xref@}
\def\xref@#1#2{\hyper@linkurl{#2}{#1}}
\begingroup
\catcode`\_=\active
\gdef_#1{\ensuremath{\sb{\mathrm{#1}}}}
\endgroup
\mathcode`\_=\string"8000
\catcode`\_=12\relax

\usepackage[a4paper,twoside,lmargin=1in,rmargin=1in,tmargin=1in,bmargin=1in,marginparwidth=0.75in]{geometry}
\usepackage{framed}

\definecolor{shadecolor}{gray}{0.95}
\usepackage{longtable}
\usepackage[normalem]{ulem}
\usepackage{fancyvrb}
\usepackage{fancyhdr}
\usepackage{graphicx}
\usepackage{marginnote}

\renewcommand*{\marginfont}{\itshape\footnotesize}

  \usepackage{endnotes}
  
      \def\theendnote{\@alph\c@endnote}
    
\def\Gin@extensions{.pdf,.png,.jpg,.mps,.tif}

  \pagestyle{fancy}

\hyperbaseurl{}

	 \paperwidth210mm
	 \paperheight297mm
              
\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{3}
\clubpenalty=8000
\emergencystretch 3em
\hbadness=4000
\hyphenpenalty=400
\pretolerance=750
\tolerance=2000
\vbadness=4000
\widowpenalty=10000

\renewcommand\section{\@startsection {section}{1}{\z@}%
     {-1.75ex \@plus -0.5ex \@minus -.2ex}%
     {0.5ex \@plus .2ex}%
     {\reset@font\Large\bfseries\sffamily}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
     {-1.75ex\@plus -0.5ex \@minus- .2ex}%
     {0.5ex \@plus .2ex}%
     {\reset@font\Large\sffamily}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
     {-1.5ex\@plus -0.35ex \@minus -.2ex}%
     {0.5ex \@plus .2ex}%
     {\reset@font\large\sffamily}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
     {-1ex \@plus-0.35ex \@minus -0.2ex}%
     {0.5ex \@plus .2ex}%
     {\reset@font\normalsize\sffamily}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
     {1.5ex \@plus1ex \@minus .2ex}%
     {-1em}%
     {\reset@font\normalsize\bfseries}}


\def\l@section#1#2{\addpenalty{\@secpenalty} \addvspace{1.0em plus 1pt}
 \@tempdima 1.5em \begingroup
 \parindent \z@ \rightskip \@pnumwidth 
 \parfillskip -\@pnumwidth 
 \bfseries \leavevmode #1\hfil \hbox to\@pnumwidth{\hss #2}\par
 \endgroup}
\def\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\def\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\def\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\def\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\@ifundefined{c@section}{\newcounter{section}}{}
\@ifundefined{c@chapter}{\newcounter{chapter}}{}
\newif\if@mainmatter 
\@mainmattertrue
\def\chaptername{Chapter}
\def\frontmatter{%
  \pagenumbering{roman}
  \def\thechapter{\@roman\c@chapter}
  \def\theHchapter{\roman{chapter}}
  \def\thesection{\@roman\c@section}
  \def\theHsection{\roman{section}}
  \def\@chapapp{}%
}
\def\mainmatter{%
  \cleardoublepage
  \def\thechapter{\@arabic\c@chapter}
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \pagenumbering{arabic}
  \setcounter{secnumdepth}{6}
  \def\@chapapp{\chaptername}%
  \def\theHchapter{\arabic{chapter}}
  \def\thesection{\@arabic\c@section}
  \def\theHsection{\arabic{section}}
}
\def\backmatter{%
  \cleardoublepage
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \setcounter{secnumdepth}{2}
  \def\@chapapp{\appendixname}%
  \def\thechapter{\@Alph\c@chapter}
  \def\theHchapter{\Alph{chapter}}
  \appendix
}
\newenvironment{bibitemlist}[1]{%
   \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
	}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}%
  {\def\@noitemerr
    {\@latex@warning{Empty `bibitemlist' environment}}%
    \endlist}

\def\tableofcontents{\section*{\contentsname}\@starttoc{toc}}
\parskip0pt
\parindent1em
\def\Panel#1#2#3#4{\multicolumn{#3}{){\columncolor{#2}}#4}{#1}}
\newenvironment{reflist}{%
  \begin{raggedright}\begin{list}{}
  {%
   \setlength{\topsep}{0pt}%
   \setlength{\rightmargin}{0.25in}%
   \setlength{\itemsep}{0pt}%
   \setlength{\itemindent}{0pt}%
   \setlength{\parskip}{0pt}%
   \setlength{\parsep}{2pt}%
   \def\makelabel##1{\itshape ##1}}%
  }
  {\end{list}\end{raggedright}}
\newenvironment{sansreflist}{%
  \begin{raggedright}\begin{list}{}
  {%
   \setlength{\topsep}{0pt}%
   \setlength{\rightmargin}{0.25in}%
   \setlength{\itemindent}{0pt}%
   \setlength{\parskip}{0pt}%
   \setlength{\itemsep}{0pt}%
   \setlength{\parsep}{2pt}%
   \def\makelabel##1{\upshape\sffamily ##1}}%
  }
  {\end{list}\end{raggedright}}
\newenvironment{specHead}[2]%
 {\vspace{20pt}\hrule\vspace{10pt}%
  \label{#1}\markright{#2}%

  \pdfbookmark[2]{#2}{#1}%
  \hspace{-0.75in}{\bfseries\fontsize{16pt}{18pt}\selectfont#2}%
  }{}
      \def\TheFullDate{1970-01-01}
\def\TheID{\makeatother }
\def\TheDate{1970-01-01}
\makeatletter 
\makeatletter
\newcommand*{\cleartoleftpage}{%
  \clearpage
    \if@twoside
    \ifodd\c@page
      \hbox{}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}
\makeatother
\makeatletter
\thispagestyle{empty}
\markright{\@title}\markboth{\@title}{\@author}
\renewcommand\small{\@setfontsize\small{9pt}{11pt}\abovedisplayskip 8.5\p@ plus3\p@ minus4\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip \z@ plus2\p@
\belowdisplayshortskip 4\p@ plus2\p@ minus2\p@
\def\@listi{\leftmargin\leftmargini
               \topsep 2\p@ plus1\p@ minus1\p@
               \parsep 2\p@ plus\p@ minus\p@
               \itemsep 1pt}
}
\makeatother
\fvset{frame=single,numberblanklines=false,xleftmargin=5mm,xrightmargin=5mm}
\fancyhf{} 
\setlength{\headheight}{14pt}
\fancyhead[LE]{\bfseries\leftmark} 
\fancyhead[RO]{\bfseries\rightmark} 
\fancyfoot[RO]{}
\fancyfoot[CO]{\thepage}
\fancyfoot[LO]{\TheID}
\fancyfoot[LE]{}
\fancyfoot[CE]{\thepage}
\fancyfoot[RE]{\TheID}
\hypersetup{linkbordercolor=0.75 0.75 0.75,urlbordercolor=0.75 0.75 0.75,bookmarksnumbered=true}
\let\tabcellsep&amp; 
\fancypagestyle{plain}{\fancyhead{}\renewcommand{\headrulewidth}{0pt}}\makeatother 
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
<xslo:text>\bodymatter
</xslo:text>
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
          <xsl:for-each select="//rendition[@xml:id and           not(parent::model)]">
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
            <xsl:copy-of select="tei:simpleContainer(substring-before(@behaviour,'('))"/>
          </xsl:variable>
          <!-- use position of a model to distinguish between classes for differing behaviours -->
          <xsl:variable name="elname">
            <xsl:value-of select="ancestor::elementSpec/@ident"/>
          </xsl:variable>
          <xsl:variable name="pos" select="if  (count(../model) &gt; 1) then position() else  ''"/>
          <xsl:for-each select="./rendition">
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

  </xsl:function>

  <xsl:function name="tei:processLocalRendition" as="node()">

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
    
  </xsl:function>

  <xsl:function name="tei:escapeChars" as="xs:string" override="yes">
    <xsl:param name="letters"/>
    <xsl:param name="context"/>
      <xsl:value-of
	  select="replace(replace(replace(replace(replace(translate($letters,'ſ&#10;','s '), 
		  '\\','\\textbackslash '),
		  '_','\\textunderscore '),
		  '\^','\\textasciicircum '),
		  '~','\\textasciitilde '),
		  '([\}\{%&amp;\$#])','\\$1')"/>

  </xsl:function>

  <xsl:function name="tei:attributes" as="node()*">
    <xsl:param name="model"/>
    <xslo:if test="@xml:id">
      <xslo:text>\anchor{</xslo:text>
      <xslo:value-of select="@xml:id"/>
      <xslo:text>}</xslo:text>
    </xslo:if>
    <xsl:if test="$model/@useSourceRendition='true'">
      <xslo:call-template name="localrendition"/>
    </xsl:if>
  </xsl:function>

</xsl:stylesheet>
