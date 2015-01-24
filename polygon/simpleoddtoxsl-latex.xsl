<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:import href="polygon_lib.xsl"/>
  <xsl:import href="latex_functions.xsl"/>
  <xsl:param name="debug">false</xsl:param>
  <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
    <desc>
      <p>Prototype TEI utility stylesheet for transformation TEI
	    Simple ODDs into XSLT stylesheet for processing TEI Simple
	    documents to web output</p>
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
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="output">latex</xsl:param>
</xsl:stylesheet>
