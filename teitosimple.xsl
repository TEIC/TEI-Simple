<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.tei-c.org/ns/1.0" 
        xmlns:tei="http://www.tei-c.org/ns/1.0" 
        exclude-result-prefixes="tei xs" version="2.0" 
        xpath-default-namespace="http://www.w3.org/1999/xhtml">
        
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
        <desc>
            <p> TEI utility stylesheet for transformation from TEI P5 to TEI Simple</p>
            <p>This software is dual-licensed:
                
                1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
                Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
                
                2. http://www.opensource.org/licenses/BSD-2-Clause
                
                All rights reserved.
                
                Redistribution and use in source and binary forms, with or without
                modification, are permitted provided that the following conditions are
                met:
                
                * Redistributions of source code must retain the above copyright
                notice, this list of conditions and the following disclaimer.
                
                * Redistributions in binary form must reproduce the above copyright
                notice, this list of conditions and the following disclaimer in the
                documentation and/or other materials provided with the distribution.
                
                This software is provided by the copyright holders and contributors
                "as is" and any express or implied warranties, including, but not
                limited to, the implied warranties of merchantability and fitness for
                a particular purpose are disclaimed. In no event shall the copyright
                holder or contributors be liable for any direct, indirect, incidental,
                special, exemplary, or consequential damages (including, but not
                limited to, procurement of substitute goods or services; loss of use,
                data, or profits; or business interruption) however caused and on any
                theory of liability, whether in contract, strict liability, or tort
                (including negligence or otherwise) arising in any way out of the use
                of this software, even if advised of the possibility of such damage.
            </p>
            <p>Author: See AUTHORS</p>
            <p>Copyright: 2014, TEI Consortium</p>
        </desc>
    </doc>
    

<xsl:variable name="transtable" select="doc('simpletrans.xml')"/>

    
    <!-- p5 to simple transform -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="tei:teiHeader">
        <!-- cut out the teiHeader -->
    
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title>Empty</title>
                </titleStmt>
                <publicationStmt>
                    <p>Empty</p>
                </publicationStmt>
                <sourceDesc>
                    <p>Empty</p>
                </sourceDesc>
            </fileDesc>
        </teiHeader>
    </xsl:template>

<!-- merge into name, keep attributes and add @type with translated name of original elements -->
    <xsl:template match="tei:persName | tei:orgName | tei:addName | tei:nameLink | tei:roleName | tei:forename | tei:surname | tei:genName">
        <xsl:variable name="lname" select="local-name()"/>
        <xsl:element name="name">
            <xsl:attribute name="type"><xsl:value-of select="$transtable//tei:item[tei:in=$lname]/tei:out"/></xsl:attribute>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
        </xsl:element>
    </xsl:template>


    <!-- merge into element named according to transl table, keep attributes and add @type with name of original elements -->
    <xsl:template match="tei:code | tei:country | tei:emph ">
        <xsl:variable name="lname" select="local-name()"/>
        <xsl:variable name="tname" select="$transtable//tei:item[tei:in=$lname]/tei:out"/>
        
        <xsl:element name="{$tname}">
            <xsl:attribute name="type"><xsl:value-of select="$lname"/></xsl:attribute>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
        </xsl:element>
    </xsl:template>
    

<!-- merge into empty element -->    
    <xsl:template match="tei:ptr | tei:caesura">
        <xsl:variable name="lname" select="local-name()"/>
        <xsl:variable name="tname" select="$transtable//tei:item[tei:in=$lname]/tei:out"/>
        
        <xsl:element name="{$tname}">
                <xsl:apply-templates select="@*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*|text()|comment()|processing-instruction()">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>