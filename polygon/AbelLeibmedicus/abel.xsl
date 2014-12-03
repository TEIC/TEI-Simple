<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                    xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
                    <xsl:template match="l">
                                        <span class="verse">
                                                  <xsl:apply-templates/>
                                        </span>
                                        <br/>
                    </xsl:template>
                    <xsl:template match="head">
                                        <span class="partHeader">
                                                  <xsl:apply-templates/>
                                        </span>
                    </xsl:template>
                    <xsl:template match="lb">
                                        <br/>
                    </xsl:template>
                    <xsl:template match="figure">
                                        <xsl:choose>
                                                  <xsl:when test="string(@facs)">
                                                  <img>
                                                  <xsl:attribute name="src">
                                                  <xsl:value-of select="@facs"/>
                                                  </xsl:attribute>
                                                  </img>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <span class="verybig">�</span>
                                                  </xsl:otherwise>
                                        </xsl:choose>
                    </xsl:template>
                    <xsl:template match="body">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="div">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="trailer">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="byline">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="titlePage">
                                        <div class="titlePage">
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="front">
                                        <div>
                                                  <xsl:apply-templates/>
                                        </div>
                    </xsl:template>
                    <xsl:template match="/">
                                        <html xmlns="http://www.w3.org/1999/xhtml">
                                                  <head xmlns="">
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
