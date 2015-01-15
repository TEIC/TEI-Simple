<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">


    <xsl:import href="functions.xsl"/>
    
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
                    <item>make room for modelGrp and inheritance of its outcome, predicate and rendition</item>
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
    


    <xsl:template match="/">
        <xslo:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
            xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

            <xslo:output method="html"/>
            
            <xsl:apply-templates select="//elementSpec[.//model]"/>

            <xslo:template match="/">
                <html>
                    <xsl:copy-of select="tei:makeHTMLHeader(., //elementSpec, '')"/>
                    <body>
                        <xslo:apply-templates/>
                    </body>
                </html>
            </xslo:template>

            <xslo:template match="*">
                <xslo:apply-templates/>
            </xslo:template>
        </xslo:stylesheet>
    </xsl:template>


    <xsl:template match="elementSpec">
        <!--
            for each standalone model (that is not a child of modelSequence) or modelSequence create a when statement in a template for a given element;
            modelSequence child models should be translated into series of if statements
            
            if standalone model without predicate exists use it as otherwise option in a template else create otherwise option that just does apply-templates
        -->
        <xsl:variable name="models" select="model"/>

        
<xsl:variable name="template">
    
    <!-- is that right to have class equal to element name by default? -->
        <xsl:variable name="class" select="@ident"/>
    
        <xsl:variable name="iden" select="@ident"/>
    <xslo:template match="{@ident}">
            <xslo:choose>
            <xsl:for-each select="modelSequence[not(@output) or @output=$output]">
                <xslo:when test="{@predicate}">
                    <xsl:for-each select="model">
                        <xsl:variable name="modelId" select="generate-id()"/>
                        <xsl:variable name="number" select="tei:findModelPosition($models, $modelId)"/>
                        <xslo:if test="{@predicate}">
                    <!-- now find what function to apply -->
                    <xsl:sequence select="tei:matchFunction($iden, ., $class, $number)"/>
                </xslo:if>
                    </xsl:for-each>
                </xslo:when>
            </xsl:for-each>
           
                <xsl:for-each select="descendant::model[not(descendant::modelSequence)][not(@output) or @output=$output or parent::modelGrp[@output=$output]]">
                <xsl:variable name="modelId" select="generate-id()"/>
                <xsl:variable name="number" select="tei:findModelPosition($models, $modelId)"/>
                    <xsl:choose>
                    <xsl:when test="@predicate">
                    <xslo:when test="{@predicate}">
                        <xsl:sequence select="tei:matchFunction($iden, ., $class, $number)"/>
                    </xslo:when>
                    </xsl:when>
                        <xsl:otherwise>
                            <xslo:otherwise>
                                <xsl:sequence select="tei:matchFunction($iden, ., $class, $number)"/>
                            </xslo:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
            </xsl:for-each>
                <!-- if there is no behaviour to apply in all cases, go the default route and try to process children -->
                <xsl:if test="not(descendant::model[not(@predicate)][not(parent::modelSequence)][not(@output) or @output=$output or parent::modelGrp[@output=$output]])">
                    <xslo:otherwise>
                        <xslo:apply-templates/>
                    </xslo:otherwise>
                </xsl:if>
            </xslo:choose>
            
        </xslo:template>
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
