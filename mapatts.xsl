<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/TransformAlias" version="2.0">
   <xsl:template match="@rend">
      <xsl:if test="not(../@rendition)">
         <xsl:attribute name="rendition">
            <xsl:choose>
               <xsl:when test=".='supralinear'">simple:above</xsl:when>
               <xsl:when test=".='pageTop'">simple:top</xsl:when>
               <xsl:when test=".='bot-right'">simple:bottom-right</xsl:when>
               <xsl:when test=".='bot-left'">simple:bottom-left</xsl:when>
               <xsl:when test=".='bot-center'">simple:bottom-center</xsl:when>
               <xsl:when test=".='foot'">simple:bottom</xsl:when>
               <xsl:when test=".='margin-outer'">simple:margin</xsl:when>
               <xsl:when test=".='marg1'">simple:margin</xsl:when>
               <xsl:when test=".='marg2'">simple:margin</xsl:when>
               <xsl:when test=".='marg4'">simple:margin</xsl:when>
               <xsl:when test=".='margin'">simple:margin</xsl:when>
               <xsl:when test=".='left'">simple:margin-left</xsl:when>
               <xsl:when test=".='right'">simple:margin-right</xsl:when>
               <xsl:when test=".='in'">simple:inline</xsl:when>
               <xsl:when test=".='char'">simple:chars</xsl:when>
               <xsl:when test=".='characters'">simple:chars</xsl:when>
               <xsl:when test=".='line'">simple:lines</xsl:when>
               <xsl:when test=".='page'">simple:pages</xsl:when>
               <xsl:when test=".='word'">simple:words</xsl:when>
               <xsl:when test=".='upper-roman'">simple:simple:allcaps</xsl:when>
               <xsl:when test=".='uc'">simple:simple:allcaps</xsl:when>
               <xsl:when test=".='blackLetter'">simple:simple:blackletter</xsl:when>
               <xsl:when test=".='blackletterType'">simple:simple:blackletter</xsl:when>
               <xsl:when test=".='FrakturType'">simple:simple:blackletter</xsl:when>
               <xsl:when test=".='gothic'">simple:simple:blackletter</xsl:when>
               <xsl:when test=".='b'">simple:simple:bold</xsl:when>
               <xsl:when test=".='bo'">simple:simple:bold</xsl:when>
               <xsl:when test=".='bol'">simple:simple:bold</xsl:when>
               <xsl:when test=".='strong'">simple:simple:bold</xsl:when>
               <xsl:when test=".='border'">simple:simple:boxed</xsl:when>
               <xsl:when test=".='center'">simple:simple:centre</xsl:when>
               <xsl:when test=".='decorInit'">simple:simple:dropcap</xsl:when>
               <xsl:when test=".=''">simple:simple:italic</xsl:when>
               <xsl:when test=".='italics'">simple:simple:italic</xsl:when>
               <xsl:when test=".='ITALIC'">simple:simple:italic</xsl:when>
               <xsl:when test=".='i'">simple:simple:italic</xsl:when>
               <xsl:when test=".='it'">simple:simple:italic</xsl:when>
               <xsl:when test=".='ital'">simple:simple:italic</xsl:when>
               <xsl:when test=".='large'">simple:simple:larger</xsl:when>
               <xsl:when test=".='left'">simple:simple:left</xsl:when>
               <xsl:when test=".='braced'">simple:simple:leftbraced</xsl:when>
               <xsl:when test=".='spaceletter'">simple:simple:letterspace</xsl:when>
               <xsl:when test=".='roman'">simple:simple:normalweight</xsl:when>
               <xsl:when test=".='right-aligned'">simple:simple:right</xsl:when>
               <xsl:when test=".='rotateCounterclockwise'">simple:simple:rotateleft</xsl:when>
               <xsl:when test=".='rotateClockwise'">simple:simple:rotateright</xsl:when>
               <xsl:when test=".='sc'">simple:simple:smallcaps</xsl:when>
               <xsl:when test=".='smallCap'">simple:simple:smallcaps</xsl:when>
               <xsl:when test=".='small'">simple:simple:smaller</xsl:when>
               <xsl:when test=".='sub'">simple:simple:subscript</xsl:when>
               <xsl:when test=".='sup'">simple:simple:superscript</xsl:when>
               <xsl:when test=".='super'">simple:simple:superscript</xsl:when>
               <xsl:when test=".='u'">simple:simple:underline</xsl:when>
            </xsl:choose>
            <xsl:for-each select="tokenize(.,' ')">
               <xsl:text>simple:</xsl:text>
               <xsl:value-of select="."/>
               <xsl:if test="position()!=last()">
                  <xsl:text/>
               </xsl:if>
            </xsl:for-each>
         </xsl:attribute>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
