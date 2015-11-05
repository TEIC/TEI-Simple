<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"><xsl:output method="html"/><xsl:template match="p"><p><xsl:apply-templates/></p></xsl:template><xsl:template match="hi"><span class="italic"><xsl:apply-templates/></span></xsl:template><xsl:template match="l"><span class="verse"><xsl:apply-templates/></span><br/></xsl:template><xsl:template match="ref"><span class="italic"><xsl:apply-templates select="@ref"/></span></xsl:template><xsl:template match="head"><span class="partHeader"><xsl:apply-templates/></span></xsl:template><xsl:template match="note"><xsl:variable name="cId"><xsl:value-of select="generate-id(.)"/></xsl:variable><sup><xsl:element name="a"><xsl:attribute name="name">A<xsl:value-of select="$cId"/></xsl:attribute><xsl:attribute name="href">#N<xsl:value-of select="$cId"/></xsl:attribute><xsl:number level="any"/></xsl:element></sup><span class="floating"><xsl:apply-templates/></span></xsl:template><xsl:template match="lb"/><xsl:template match="figure"><xsl:choose><xsl:when test="string(@facs)"><img><xsl:attribute name="src"><xsl:value-of select="@facs"/></xsl:attribute></img></xsl:when><xsl:otherwise><span class="verybig">�</span></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="text"><div><xsl:apply-templates/></div><hr/><ul><xsl:for-each select=".//note"><xsl:variable name="cId"><xsl:value-of select="generate-id(.)"/></xsl:variable><li><xsl:element name="a"><xsl:attribute name="name">N<xsl:value-of select="$cId"/></xsl:attribute><xsl:attribute name="href">#A<xsl:value-of select="$cId"/></xsl:attribute>
                        ↵ <xsl:number level="any"/></xsl:element><xsl:text/><xsl:apply-templates/></li></xsl:for-each></ul></xsl:template><xsl:template match="body"><div><xsl:apply-templates/></div></xsl:template><xsl:template match="div"><div><xsl:apply-templates/></div></xsl:template><xsl:template match="trailer"><div><xsl:apply-templates/></div></xsl:template><xsl:template match="byline"><div><xsl:apply-templates/></div></xsl:template><xsl:template match="titlePage"><div class="titlePage"><xsl:apply-templates/></div></xsl:template><xsl:template match="front"><div><xsl:apply-templates/></div></xsl:template><xsl:template match="/"><html><head><meta charset="UTF-8"/><title>
                    TEI-Simple: transform to html generated from odd file.
                </title><link rel="StyleSheet" href="simple.css" type="text/css"/></head><body><xsl:apply-templates/></body></html></xsl:template><xsl:template match="*"><xsl:apply-templates/></xsl:template></xsl:stylesheet>