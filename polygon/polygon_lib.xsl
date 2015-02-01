<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 		     xmlns:xschema="http://www.w3.org/2001/XMLSchema"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:variable name="sq">'</xsl:variable>
  <xsl:param name="debug">false</xsl:param>
  <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p>Prototype TEI utility stylesheet for transformation TEI
	    Simple ODDs into XSLT stylesheet for processing TEI Simple
	    documents</p>
      <p>Default behaviour:
                <list><item>if no @predicate, assume it means self</item><item>if no @output, means model valid for all outputs</item><item>if no @class, use default css rendition for a given element</item><item>sibling <gi>model</gi>s are considered mutually exclusive and are translated into sequence of <gi>xsl:when</gi> statements except when grouped within a <gi>modelSequence</gi></item></list>
            </p>
      <p>To do:
                <list><item>deal with @useSourceRendition attribute</item><item>deal with styling instructions from simple namespace (eg. simple:bold)</item></list>
            </p>
      <p>This software is dual-licensed: 1. Distributed under a Creative Commons
                Attribution-ShareAlike 3.0 Unported License
                http://creativecommons.org/licenses/by-sa/3.0/ 2.
                http://www.opensource.org/licenses/BSD-2-Clause All rights reserved. Redistribution
                and use in source and binary forms, with or without modification, are permitted
                provided that the following conditions are met: * Redistributions of source code
                must retain the above copyright notice, this list of conditions and the following
                disclaimer. * Redistributions in binary form must reproduce the above copyright
                notice, this list of conditions and the following disclaimer in the documentation
                and/or other materials provided with the distribution. This software is provided by
                the copyright holders and contributors "as is" and any express or implied
                warranties, including, but not limited to, the implied warranties of merchantability
                and fitness for a particular purpose are disclaimed. In no event shall the copyright
                holder or contributors be liable for any direct, indirect, incidental, special,
                exemplary, or consequential damages (including, but not limited to, procurement of
                substitute goods or services; loss of use, data, or profits; or business
                interruption) however caused and on any theory of liability, whether in contract,
                strict liability, or tort (including negligence or otherwise) arising in any way out
                of the use of this software, even if advised of the possibility of such damage. </p>
      <p>Author: Magdalena Turska</p>
      <p>Copyright: 2014, TEI Consortium</p>
    </desc>
  </doc>
  <xsl:variable name="TOP" select="/"/>
  <xsl:template match="/">
    <xslo:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		     xmlns:tei="http://www.tei-c.org/ns/1.0"
		     xmlns:xschema="http://www.w3.org/2001/XMLSchema"
		     xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
		     exclude-result-prefixes="tei"
		     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
		     version="2.0">
      <xslo:output method="{if ($output ='latex') then 'text' else
			   'xhtml'}"/>
      <xslo:key name="ALL-EXTRENDITION" match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]" use="1"/>
      <xslo:key name="EXTRENDITION"
	    match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]" use="."/>
      <xslo:key name="ALL-LOCALRENDITION" match="tei:rendition" use='1'/>

      <xsl:apply-templates select="//elementSpec[.//model]"/>

      <xsl:sequence select="tei:processLocalRendition()"/>
      <xslo:template match="text()" mode="#default plain">
        <xslo:choose>
          <xslo:when test="ancestor::*[@xml:space][1]/@xml:space='preserve'">
            <xslo:value-of select="tei:escapeChars(.,parent::*)"/>
          </xslo:when>
          <xslo:otherwise>
            <!-- Retain one leading space if node isn't first, has
	     non-space content, and has leading space.-->
            <xslo:variable name="context" select="name(parent::*)"/>
            <xslo:if test="matches(.,'^\s') and  normalize-space()!=''">
              <xslo:choose>
                <xslo:when test="(parent::*/preceding-sibling::node()[1][name()=$context])">
                  <xslo:value-of select="' '"/>
                </xslo:when>
                <xslo:when test="position()=1"/>
                <xslo:otherwise>
                  <xslo:value-of select="' '"/>
                </xslo:otherwise>
              </xslo:choose>
            </xslo:if>
            <xslo:value-of select="tei:escapeChars(normalize-space(.),parent::*)"/>
            <xslo:choose>
              <!-- node is an only child, and has content but it's all space -->
              <xslo:when test="last()=1 and string-length()!=0 and      normalize-space()=''">
                <xslo:value-of select="' '"/>
              </xslo:when>
              <!-- node isn't last, isn't first, and has trailing space -->
              <xslo:when test="position()!=1 and position()!=last() and matches(.,'\s$')">
                <xslo:value-of select="' '"/>
              </xslo:when>
              <!-- node isn't last, is first, has trailing space, and has non-space content   -->
              <xslo:when test="position()=1 and matches(.,'\s$') and normalize-space()!=''">
                <xslo:value-of select="' '"/>
              </xslo:when>
            </xslo:choose>
          </xslo:otherwise>
        </xslo:choose>
      </xslo:template>
    </xslo:stylesheet>
  </xsl:template>
  <xsl:template match="elementSpec">
    <xsl:variable name="iden" select="@ident"/>
    <!--
            for each standalone model (that is not a child of modelSequence) or modelSequence create a when statement in a template for a given element;
            modelSequence child models should be translated into series of if statements
            
            if standalone model without predicate exists use it as otherwise option in a template else create otherwise option that just does apply-templates
        -->
    <!-- expand modelGrp -->
    <xsl:variable name="pass1">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:choose>
          <xsl:when test="modelGrp">
            <xsl:for-each select="modelGrp/*">
              <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:if test="not(@output)">
                  <xsl:copy-of select="parent::modelGrp/@output"/>
                </xsl:if>
                <xsl:if test="not(@predicate)">
                  <xsl:copy-of select="parent::modelGrp/@predicate"/>
                </xsl:if>
                <xsl:if test="not(@behaviour)">
                  <xsl:copy-of select="parent::modelGrp/@behaviour"/>
                </xsl:if>
                <xsl:copy-of select="*"/>
              </xsl:copy>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="model|modelSequence"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:copy>
    </xsl:variable>
    <xsl:variable name="template">
      <xsl:for-each select="$pass1/*">
        <!-- is that right to have class equal to element name by default? -->
        <xslo:template match="{$iden}">
          <xslo:choose>
            <xsl:for-each select="(model | modelSequence)[@predicate       and (not(@output)  or       @output=$output)]">
              <xsl:choose>
                <xsl:when test="self::modelSequence">
                  <xslo:when test="{@predicate}">
                    <xsl:for-each select="model">
                      <xsl:sequence select="tei:doModel(.,$iden,'if',tei:findModelPosition(.))"/>
                    </xsl:for-each>
                  </xslo:when>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:sequence select="tei:doModel(.,$iden,'when',tei:findModelPosition(.))"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            <xsl:if test="(model |           modelSequence)[not(@predicate)           and (not(@output)  or           @output=$output)]">
              <xslo:otherwise>
                <xsl:for-each select="(model |           modelSequence)[not(@predicate)           and (not(@output)  or           @output=$output)]">
                  <xsl:choose>
                    <xsl:when test="self::modelSequence">
                      <xsl:for-each select="model">
                        <xsl:sequence select="tei:doModel(.,$iden,'if',tei:findModelPosition(.))"/>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:sequence select="tei:doModel(.,$iden,'if',tei:findModelPosition(.))"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xslo:otherwise>
            </xsl:if>
          </xslo:choose>
        </xslo:template>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$template//xsl:when and not($template//xsl:when[preceding-sibling::xsl:otherwise])">
        <xsl:copy-of select="$template"/>
      </xsl:when>
      <xsl:otherwise>
        <xslo:template match="{$template/xsl:template/@match}">
          <xsl:copy-of select="$template//xsl:otherwise[1]/*"/>
        </xslo:template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:function name="tei:doModel" as="node()*">
    <xsl:param name="context"/>
    <xsl:param name="iden"/>
    <xsl:param name="construct"/>
    <xsl:param name="number"/>
    <xsl:choose>
      <xsl:when test="$context/@predicate">
        <xsl:element name="xsl:{$construct}">
          <xsl:attribute name="test" select="$context/@predicate"/>
          <xsl:sequence select="tei:matchFunction($iden, $context, $iden, $number)"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="tei:matchFunction($iden, $context, $iden, $number)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:function name="tei:findModelPosition" as="xs:string">
    <xsl:param name="context"/>
    <xsl:for-each select="$context">
      <xsl:variable name="n">
        <xsl:number from="elementSpec" level="any" count="model"/>
      </xsl:variable>
      <xsl:value-of select="if  (count(parent::*/model) &gt; 1 ) then   $n else ''"/>
    </xsl:for-each>
  </xsl:function>
  <xsl:function name="tei:applyTemplates" as="node()*">
    <xsl:param name="content"/>
    <xsl:if test="string($content)">
      <xsl:choose>
        <xsl:when test="starts-with($content,'@')">
          <xslo:value-of>
            <xsl:attribute name="select">
              <xsl:value-of select="$content"/>
            </xsl:attribute>
          </xslo:value-of>
        </xsl:when>
        <xsl:when test="$content!='.'">
          <xslo:for-each>
            <xsl:attribute name="select">
              <xsl:value-of select="$content"/>
            </xsl:attribute>
            <xslo:apply-templates/>
          </xslo:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xslo:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:function>
  <xsl:function name="tei:matchFunction">
    <xsl:param name="elName"/>
    <xsl:param name="model"/>
    <xsl:param name="class"/>
    <xsl:param name="number"/>
    <xsl:variable name="task" select="substring-before(normalize-space($model/@behaviour),'(')"/>
    <xsl:variable name="parms" select="tokenize(replace(normalize-space($model/@behaviour),'[^\(]*\((.*)\)$','$1'),',')"/>
    <xsl:variable name="textcontent" select="replace(substring-after($model/@behaviour,'('),'\)$','')"/>
    <xsl:if test="$debug='true'">
      <xsl:message><xsl:value-of select="($elName,$model/@behaviour,$task,$textcontent)"/>:   <xsl:value-of select="($parms)" separator=" -- "/></xsl:message>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="$task ='index'">
        <xsl:sequence select="tei:index($model, $parms[1], $class, $number,$parms[2])"/>
      </xsl:when>
      <xsl:when test="$task ='anchor'">
        <xsl:sequence select="tei:anchor($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='graphic'">
        <xsl:sequence select="tei:graphic($model, $parms[1],$parms[2],$parms[3],$parms[4],$class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='glyph'">
        <xsl:sequence select="tei:glyph($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='note'">
        <xsl:sequence select="tei:note($model, $parms[1], $parms[2],$class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='block'">
        <xsl:sequence select="tei:block($model,$parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='heading'">
        <xsl:sequence select="tei:heading($model, $parms[1],$parms[2],$parms[3],$class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='alternate'">
        <xsl:sequence select="tei:alternate($model, $parms[1], $parms[2],$class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='link'">
        <xsl:sequence select="tei:link($model, $parms[1], $parms[2],$class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='list'">
        <xsl:sequence select="tei:list($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='listItem'">
        <xsl:sequence select="tei:listItem($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='inline'">
        <xsl:sequence select="tei:inline($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='text'">
        <xsl:sequence select="tei:text($textcontent)"/>
      </xsl:when>
      <xsl:when test="$task ='newline'">
        <xsl:sequence select="tei:newline($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='break'">
        <xsl:sequence select="tei:break($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='paragraph'">
        <xsl:sequence select="tei:paragraph($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='figure'">
        <xsl:sequence select="tei:figure($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='table'">
        <xsl:sequence select="tei:table($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='row'">
        <xsl:sequence select="tei:row($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='cell'">
        <xsl:sequence select="tei:cell($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='title'">
        <xsl:sequence select="tei:title($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='metadata'">
        <xsl:sequence select="tei:metadata($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='body'">
        <xsl:sequence select="tei:body($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='document'">
        <xsl:sequence select="tei:document($model, $parms[1], $class, $number)"/>
      </xsl:when>
      <xsl:when test="$task ='omit'"/>
      <xsl:otherwise>
        <xsl:sequence select="tei:makeDefault($model, $parms[1], $class, $number)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
