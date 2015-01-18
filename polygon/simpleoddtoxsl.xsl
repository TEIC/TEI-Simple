<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias" exclude-result-prefixes="xs"
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
    


    <xsl:template match="/">
        <xslo:stylesheet 
	    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:tei="http://www.tei-c.org/ns/1.0"
	    xmlns:xschema="http://www.w3.org/2001/XMLSchema"
            xmlns:xslo="http://www.w3.org/1999/XSL/TransformAlias"
            xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
	    version="2.0">

            <xslo:output method="html"/>
            
            <xsl:apply-templates select="//elementSpec[.//model]"/>

            <xslo:template match="/">
                <html>
                    <xsl:copy-of select="tei:makeHTMLHeader(.,
					 //elementSpec, '')"/>
		    <!-- jQuery -->
		    <script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
		    <!-- table of contents generation -->
		    <style type="text/css">
#toc {
    top: 0px;
    left: 0px;
    height: 400px;
   overflow: scroll;
    position: fixed;
    background: #333;
    box-shadow: inset -5px 0 5px 0px #000;
    width: 150px;
    padding-top: 20px;
    color: #fff;
}

#toc ul {
    margin: 0;
    padding: 0;
    list-style: none;
}

#toc li {
    padding: 5px 10px;
}

#toc a {
    color: #fff;
    text-decoration: none;
    display: block;
}

#toc .toc-h2 {
    padding-left: 10px;
}

#toc .toc-h3 {
    padding-left: 20px;
}

#toc .toc-active {
    background: #336699;
    box-shadow: inset -5px 0px 10px -5px #000;
}
		    </style>
    <script><![CDATA[
/*!
 * toc - jQuery Table of Contents Plugin
 * v0.3.2
 * http://projects.jga.me/toc/
 * copyright Greg Allen 2014
 * MIT License
*/
!function(a){a.fn.smoothScroller=function(b){b=a.extend({},a.fn.smoothScroller.defaults,b);var c=a(this);return a(b.scrollEl).animate({scrollTop:c.offset().top-a(b.scrollEl).offset().top-b.offset},b.speed,b.ease,function(){var a=c.attr("id");a.length&&(history.pushState?history.pushState(null,null,"#"+a):document.location.hash=a),c.trigger("smoothScrollerComplete")}),this},a.fn.smoothScroller.defaults={speed:400,ease:"swing",scrollEl:"body,html",offset:0},a("body").on("click","[data-smoothscroller]",function(b){b.preventDefault();var c=a(this).attr("href");0===c.indexOf("#")&&a(c).smoothScroller()})}(jQuery),function(a){var b={};a.fn.toc=function(b){var c,d=this,e=a.extend({},jQuery.fn.toc.defaults,b),f=a(e.container),g=a(e.selectors,f),h=[],i=e.activeClass,j=function(b,c){if(e.smoothScrolling&&"function"==typeof e.smoothScrolling){b.preventDefault();var f=a(b.target).attr("href");e.smoothScrolling(f,e,c)}a("li",d).removeClass(i),a(b.target).parent().addClass(i)},k=function(){c&&clearTimeout(c),c=setTimeout(function(){for(var b,c=a(window).scrollTop(),f=Number.MAX_VALUE,g=0,j=0,k=h.length;k>j;j++){var l=Math.abs(h[j]-c);f>l&&(g=j,f=l)}a("li",d).removeClass(i),b=a("li:eq("+g+")",d).addClass(i),e.onHighlight(b)},50)};return e.highlightOnScroll&&(a(window).bind("scroll",k),k()),this.each(function(){var b=a(this),c=a(e.listType);g.each(function(d,f){var g=a(f);h.push(g.offset().top-e.highlightOffset);var i=e.anchorName(d,f,e.prefix);if(f.id!==i){a("<span/>").attr("id",i).insertBefore(g)}var l=a("<a/>").text(e.headerText(d,f,g)).attr("href","#"+i).bind("click",function(c){a(window).unbind("scroll",k),j(c,function(){a(window).bind("scroll",k)}),b.trigger("selected",a(this).attr("href"))}),m=a("<li/>").addClass(e.itemClass(d,f,g,e.prefix)).append(l);c.append(m)}),b.html(c)})},jQuery.fn.toc.defaults={container:"body",listType:"<ul/>",selectors:"h1,h2,h3",smoothScrolling:function(b,c,d){a(b).smoothScroller({offset:c.scrollToOffset}).on("smoothScrollerComplete",function(){d()})},scrollToOffset:0,prefix:"toc",activeClass:"toc-active",onHighlight:function(){},highlightOnScroll:!0,highlightOffset:100,anchorName:function(c,d,e){if(d.id.length)return d.id;var f=a(d).text().replace(/[^a-z0-9]/gi," ").replace(/\s+/g,"-").toLowerCase();if(b[f]){for(var g=2;b[f+g];)g++;f=f+"-"+g}return b[f]=!0,e+"-"+f},headerText:function(a,b,c){return c.text()},itemClass:function(a,b,c,d){return d+"-"+c[0].tagName.toLowerCase()}}}(jQuery);
]]>    </script>
    <script>
 $(document).ready(function() {
            $('#toc').toc({'selectors': 'h1,h2,h3'
      });
  });
    </script>

                    <body>
                        <xslo:apply-templates/>
                    </body>
                </html>
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
	  <!-- if the text is first thing in a note, zap it,  definitely -->
	  <xslo:choose>
	    <!-- but if its in a run on inline objects with the same
	    name (like a sequence of <hi>), then the space needs
	    keeping -->
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
