<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:import href="functions.xsl"/>
    
    <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
        <desc>
            <p>Prototype TEI utility stylesheet for transformation from TEI P5 to TEI Simple</p>
            <p>Default behaviour:
                <list>
                    <item>if no @predicate, assume it means self</item>
                    <item>if no @output, means model valid for all outputs</item>
                    <item>if no @class, use default css rendition for a given element</item>
                </list>
            </p>
            
            <p>To do:
                <list>
                    <item>when @predicate not present assume default context</item>
                    <item>when @output not present assume valid for all outputs</item>
                    <item>deal with @follow_rendition attribute?</item>
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
            <p>Author: See AUTHORS</p>
            <p>Copyright: 2014, TEI Consortium</p>
        </desc>
    </doc>


    <xsl:template match="/">
        <xslo:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
            xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

            <xslo:output method="html"/>
            
            <xsl:apply-templates select="//tei:elementSpec"/>

            <xslo:template match="/">
                <html>
                    <xsl:copy-of select="tei:makeHTMLHeader()"/>
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

    <xsl:template match="tei:elementSpec">
        <xsl:for-each-group select="model[@output='render' or not(@output)]" group-by="if(@predicate) then @predicate else ''">
            <xsl:variable name="xpth" select="current-group()[1]"/>

            <xsl:variable name="xp"
                select="if(current-group()[1]/string(@predicate)) then concat(current-group()[1]/parent::node()/@ident, '[', @predicate, ']') else current-group()[1]/parent::node()/@ident"/>

            <xslo:template match="{$xp}">
                <xsl:for-each select="current-group()">

                    <xsl:variable name="content"
                        select="substring-before(substring-after(@behaviour, '('), ')')"/>
                    
                    <xsl:variable name="class" select="if(@class) then @class else ()"/>

                    <xsl:choose>
                        <xsl:when test="starts-with(@behaviour, 'makeNoteAnchor')">
                            <xsl:copy-of select="tei:makeNoteAnchor(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeMarginalNote')">
                            <xsl:copy-of select="tei:makeMarginalNote(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeEndnotes')">
                            <xsl:copy-of select="tei:makeEndnotes(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeBlock')">
                            <xsl:copy-of select="tei:makeBlock(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeHeading')">
                            <xsl:copy-of select="tei:makeHeading(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeChoice')">
                            <xsl:copy-of select="tei:makeChoice(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeDate')">
                            <xsl:copy-of select="tei:makeDate(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeList(')">
                            <xsl:copy-of select="tei:makeList(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeListItem(')">
                            <xsl:copy-of select="tei:makeListItem(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeInline')">
                            <xsl:copy-of select="tei:makeInline(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeNewline')">
                            <xsl:copy-of select="tei:makeNewline(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'showPageBreak')">
                            <xsl:copy-of select="tei:showPageBreak(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeParagraph')">
                            <xsl:copy-of select="tei:makeParagraph(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@behaviour, 'makeFigure')">
                            <xsl:copy-of select="tei:makeFigure(., $content)"/>
                        </xsl:when>
                        
                        <!-- when omit() generate empty template -->
                        <xsl:when test="starts-with(@behaviour, 'omit')"/>
                        
                        <xsl:otherwise>
                            <div>
                                <xsl:if test="string($class)">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="$class"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xslo:apply-templates/>
                            </div>

                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:for-each>
            </xslo:template>
        </xsl:for-each-group>
    </xsl:template>

</xsl:stylesheet>
