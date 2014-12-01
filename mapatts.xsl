<?xml version="1.0" encoding="UTF-8"?>
<XSL:stylesheet xmlns:XSL="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <XSL:template match="@rend">
      <XSL:if test="not(../@rendition)">
         <XSL:attribute name="rendition">
            <XSL:choose>
               <XSL:when test=".='supralinear'">simple:above</XSL:when>
               <XSL:when test=".='pageTop'">simple:top</XSL:when>
               <XSL:when test=".='bot-right'">simple:bottom-right</XSL:when>
               <XSL:when test=".='bot-left'">simple:bottom-left</XSL:when>
               <XSL:when test=".='bot-center'">simple:bottom-center</XSL:when>
               <XSL:when test=".='foot'">simple:bottom</XSL:when>
               <XSL:when test=".='margin-outer'">simple:margin</XSL:when>
               <XSL:when test=".='marg1'">simple:margin</XSL:when>
               <XSL:when test=".='marg2'">simple:margin</XSL:when>
               <XSL:when test=".='marg4'">simple:margin</XSL:when>
               <XSL:when test=".='margin'">simple:margin</XSL:when>
               <XSL:when test=".='left'">simple:margin-left</XSL:when>
               <XSL:when test=".='right'">simple:margin-right</XSL:when>
               <XSL:when test=".='in'">simple:inline</XSL:when>
               <XSL:when test=".='char'">simple:chars</XSL:when>
               <XSL:when test=".='characters'">simple:chars</XSL:when>
               <XSL:when test=".='line'">simple:lines</XSL:when>
               <XSL:when test=".='page'">simple:pages</XSL:when>
               <XSL:when test=".='word'">simple:words</XSL:when>
               <XSL:when test=".='upper-roman'">simple:simple:allcaps</XSL:when>
               <XSL:when test=".='uc'">simple:simple:allcaps</XSL:when>
               <XSL:when test=".='blackLetter'">simple:simple:blackletter</XSL:when>
               <XSL:when test=".='blackletterType'">simple:simple:blackletter</XSL:when>
               <XSL:when test=".='FrakturType'">simple:simple:blackletter</XSL:when>
               <XSL:when test=".='gothic'">simple:simple:blackletter</XSL:when>
               <XSL:when test=".='b'">simple:simple:bold</XSL:when>
               <XSL:when test=".='bo'">simple:simple:bold</XSL:when>
               <XSL:when test=".='bol'">simple:simple:bold</XSL:when>
               <XSL:when test=".='strong'">simple:simple:bold</XSL:when>
               <XSL:when test=".='border'">simple:simple:boxed</XSL:when>
               <XSL:when test=".='center'">simple:simple:centre</XSL:when>
               <XSL:when test=".='decorInit'">simple:simple:dropcap</XSL:when>
               <XSL:when test=".=''">simple:simple:italic</XSL:when>
               <XSL:when test=".='italics'">simple:simple:italic</XSL:when>
               <XSL:when test=".='ITALIC'">simple:simple:italic</XSL:when>
               <XSL:when test=".='i'">simple:simple:italic</XSL:when>
               <XSL:when test=".='it'">simple:simple:italic</XSL:when>
               <XSL:when test=".='ital'">simple:simple:italic</XSL:when>
               <XSL:when test=".='large'">simple:simple:larger</XSL:when>
               <XSL:when test=".='left'">simple:simple:left</XSL:when>
               <XSL:when test=".='braced'">simple:simple:leftbraced</XSL:when>
               <XSL:when test=".='spaceletter'">simple:simple:letterspace</XSL:when>
               <XSL:when test=".='roman'">simple:simple:normalweight</XSL:when>
               <XSL:when test=".='right-aligned'">simple:simple:right</XSL:when>
               <XSL:when test=".='rotateCounterclockwise'">simple:simple:rotateleft</XSL:when>
               <XSL:when test=".='rotateClockwise'">simple:simple:rotateright</XSL:when>
               <XSL:when test=".='sc'">simple:simple:smallcaps</XSL:when>
               <XSL:when test=".='smallCap'">simple:simple:smallcaps</XSL:when>
               <XSL:when test=".='small'">simple:simple:smaller</XSL:when>
               <XSL:when test=".='sub'">simple:simple:subscript</XSL:when>
               <XSL:when test=".='sup'">simple:simple:superscript</XSL:when>
               <XSL:when test=".='super'">simple:simple:superscript</XSL:when>
               <XSL:when test=".='u'">simple:simple:underline</XSL:when>
            </XSL:choose>
            <XSL:for-each select="tokenize(.,' ')">
               <XSL:text>simple:</XSL:text>
               <XSL:value-of select="."/>
               <XSL:if test="position()!=last()">
                  <XSL:text/>
               </XSL:if>
            </XSL:for-each>
         </XSL:attribute>
      </XSL:if>
   </XSL:template>
</XSL:stylesheet>
