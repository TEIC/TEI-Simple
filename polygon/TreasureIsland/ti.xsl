<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
                    <xsl:output method="html"/>
                    <xsl:template match="quote">
                                        <div class="italic">
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="p">
                                        <p>
                                                  <xsl:apply-templates/>
                                        </p>
                    </xsl:template>
                    <xsl:template match="head[parent::div[@type='div3']]">
                                        <span class="chapterHeader">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="head[parent::div[not(@type)]]">
                                        <span class="partHeader">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="head[parent::lg]">
                                        <span class="verseHeader">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="lg">
                                        <div class="verse">
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="l">
                                        <span class="verse">
                                                  <xsl:apply-templates/>
                                        </span>
                                        <br/>
                    </xsl:template>
                    <xsl:template match="floatingText">
                                        <div class="border">
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="front">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="body">
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
