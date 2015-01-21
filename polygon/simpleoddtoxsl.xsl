<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="xs"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:import href="functions.xsl"/>
    <xsl:variable name="sq">'</xsl:variable>
    <xsl:output indent="yes"/>

    <xsl:param name="debug">false</xsl:param>
    
    <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
        <desc>
            <p>Prototype TEI utility stylesheet for transformation TEI Simple ODDs into XSLT stylesheet for processing TEI Simple documents</p>
            <p>Default behaviour:
                <list>
                    <item>if no @predicate, assume it means self</item>
                    <item>if no @output, means model valid for all outputs</item>
                    <item>if no @class, use default css rendition for a given element</item>
                    <item>sibling <gi>model</gi>s are considered mutually exclusive and are translated into sequence of <gi>xsl:when</gi> statements except when grouped within a <gi>modelSequence</gi></item>
                </list>
            </p>
            
            <p>To do:
                <list>
                    <item>deal with @useSourceRendition attribute</item>
                    <item>deal with styling instructions from simple namespace (eg. simple:bold)</item>
                </list>
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

    <xsl:param name="output">web</xsl:param>
    
    <xsl:variable name="TOP" select="/"/>

    <xsl:template match="/">
        <xslo:stylesheet 
	    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
	    exclude-result-prefixes="tei"
	    xmlns:xschema="http://www.w3.org/2001/XMLSchema"
            xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
            xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
	    version="2.0">

	  <xslo:output method="xhtml" omit-xml-declaration="yes"     encoding="utf-8"/>
            
          <xsl:apply-templates select="//elementSpec[.//model]"/>
	  
	  
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



  <xslo:function name="tei:escapeChars">
    <xslo:param name="letters"/>
    <xslo:param name="context"/>
    <xslo:value-of select="translate($letters,'ſ','s')"/>
  </xslo:function>
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
            <xsl:for-each select="(model | modelSequence)[@predicate
				  and (not(@output)  or
				  @output=$output)]">
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
	    <xsl:if test="(model |
				      modelSequence)[not(@predicate)
				      and (not(@output)  or
				      @output=$output)]">
              <xslo:otherwise>
		<xsl:for-each select="(model |
				      modelSequence)[not(@predicate)
				      and (not(@output)  or
				      @output=$output)]">
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


</xsl:stylesheet>
