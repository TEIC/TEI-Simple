<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:import href="functions.xsl"/>

    <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
        <desc>
            <p> TEI utility stylesheet for transformation from TEI P5 to TEI Simple</p>
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

            <xsl:apply-templates select="//tei:elementSpec"/>

            <xslo:template match="/">
                <html xmlns="http://www.w3.org/1999/xhtml">

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
        <xsl:for-each-group select="process[@mode='render' or not(@mode)]" group-by="@xpath">
            <xsl:variable name="xpth" select="current-group()[1]"/>

            <xsl:variable name="xp"
                select="if(current-group()[1]/string(@xpath)) then concat(current-group()[1]/parent::node()/@ident, '[', @xpath, ']') else current-group()[1]/parent::node()/@ident"/>

            <xslo:template match="{$xp}">
                <xsl:for-each select="current-group()">
                    <!--
            <xsl:variable name="xp" select="if(string(@xpath)) then concat(parent::node()/@ident, '[', @xpath, ']') else parent::node()/@ident"/>
            <xsl:variable name="content" select="substring-before(substring-after(@name, '('), ')')"/>
            <xsl:variable name="class" select="if(@class) then @class else ()"/>
            -->

                    <xsl:variable name="content"
                        select="substring-before(substring-after(@name, '('), ')')"/>
                    <xsl:variable name="class" select="if(@class) then @class else ()"/>


                    <xsl:choose>
                        <xsl:when test="starts-with(@name, 'makeMarginalNote')">
                            <xsl:copy-of select="tei:makeMarginalNote(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@name, 'makeBlock')">
                            <xsl:copy-of select="tei:makeBlock(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@name, 'makeHeader')">
                            <xsl:copy-of select="tei:makeHeader(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@name, 'makeInline')">
                            <xsl:copy-of select="tei:makeInline(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@name, 'makeNewline')">
                            <xsl:copy-of select="tei:makeNewline(., $content)"/>
                        </xsl:when>
                        <xsl:when test="starts-with(@name, 'makeParagraph')">
                            <xsl:copy-of select="tei:makeParagraph(., $content)"/>
                        </xsl:when>
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
