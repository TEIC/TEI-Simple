<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
                    <xsl:output method="html"/>
                    <xsl:template match="ab">
                                        <p>
                                                  <xsl:apply-templates/>
                                        </p>
                    </xsl:template>
                    <xsl:template match="abbr[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="actor">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="add">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="address">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="addrLine">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="addSpan">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="am">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="anchor">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="argument">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="author">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="back">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="bibl">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="body">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="byline">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="c">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="castGroup[child::*]">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="castItem[parent::list[@rendition]]">
                                        <li class=" red">
                                                  <xsl:apply-templates/>
                                        </li>
                    </xsl:template>
                    <xsl:template match="castItem[not(parent::list[@rendition])]">
                                        <li class=" red">
                                                  <xsl:apply-templates/>
                                        </li>
                    </xsl:template>
                    <xsl:template match="castList[child::*]">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="cb">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="cell">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="choice[count(child::*) gt 1]">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="cit[child::quote and child::bibl]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="closer[child::*]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="corr[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="date">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="div">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="expan[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="floatingText">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="front">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="head[parent::div[not(@type)]]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="head[parent::div[@type]]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="head[parent::lg]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="head[parent::list]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="head">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="hi[@rendition]">
                                        <span class="italic">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="hi[not(@rendition)]">
                                        <span class="italic">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="item[parent::list[@rendition]]">
                                        <li class=" red">
                                                  <xsl:apply-templates/>
                                        </li>
                    </xsl:template>
                    <xsl:template match="item[not(parent::list[@rendition])]">
                                        <li class=" red">
                                                  <xsl:apply-templates/>
                                        </li>
                    </xsl:template>
                    <xsl:template match="list[@rendition]">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="list[not(@rendition)]">
                                        <span class=" red">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="orig[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="p">
                                        <p>
                                                  <xsl:apply-templates/>
                                        </p>
                    </xsl:template>
                    <xsl:template match="pb[@n]"/>
                    <xsl:template match="pb[not(@n)]"/>
                    <xsl:template match="quote[ancestor::p]">
                                        <xsl:apply-templates/>
                    </xsl:template>
                    <xsl:template match="quote[not(ancestor::p)]">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="reg[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="sic[parent::choice and count(parent::*/*) gt 1]"/>
                    <xsl:template match="sp">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="spGrp">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="titlePage">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="/">
                                        <html>
                                                  <head>
                                                  <meta charset="UTF-8"/>
                                                  <title> TEI-Simple: transform to html generated
                                                  from odd file. </title>
                                                  <link rel="StyleSheet" href="simple.css"
                                                  type="text/css"/>
                                                  </head>
                                                  <body>
                                                  <xsl:apply-templates/>
                                                  </body>
                                        </html>
                    </xsl:template>
                    <xsl:template match="*">
                                        <xsl:apply-templates/>
                    </xsl:template>
</xsl:stylesheet>
