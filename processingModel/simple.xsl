<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="tei"
                xpath-default-namespace="http://www.tei-c.org/ns/1.0"
                version="2.0">
   <xsl:output method="xhtml"
               omit-xml-declaration="yes"
               doctype-system="about:legacy-compat"/>
   <xsl:key name="ALL-EXTRENDITION"
            match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]"
            use="1"/>
   <xsl:key name="EXTRENDITION"
            match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]"
            use="."/>
   <xsl:key name="ALL-LOCALRENDITION" match="tei:rendition" use="1"/>
   <xsl:template match="ab">
      <p class="ab">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   <xsl:template match="abbr">
      <span class="abbr">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="actor">
      <span class="actor">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="add">
      <span class="add">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="address">
      <div class="address">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="addrLine">
      <div class="addrLine">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="addSpan">
      <xsl:variable name="cId">
         <xsl:value-of select="generate-id(.)"/>
      </xsl:variable>
      <sup>
         <xsl:element name="a">
            <xsl:attribute name="class">addSpan</xsl:attribute>
            <xsl:attribute name="name">A<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:attribute name="href">#N<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:number level="any"/>
         </xsl:element>
      </sup>
   </xsl:template>
   <xsl:template match="am">
      <span class="am">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="anchor">
      <xsl:variable name="cId">
         <xsl:value-of select="generate-id(.)"/>
      </xsl:variable>
      <sup>
         <xsl:element name="a">
            <xsl:attribute name="class">anchor</xsl:attribute>
            <xsl:attribute name="name">A<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:attribute name="href">#N<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:number level="any"/>
         </xsl:element>
      </sup>
   </xsl:template>
   <xsl:template match="argument">
      <div class="argument">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="author">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <span class="author2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="back">
      <div class="back">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="bibl">
      <xsl:choose>
         <xsl:when test="parent::listBibl">
            <li class="bibl1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </li>
         </xsl:when>
         <xsl:otherwise>
            <span class="bibl2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="body">
      <div class="body2">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="byline">
      <div class="byline">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="c">
      <span class="c">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="castGroup">
      <xsl:choose>
         <xsl:when test="child::*">
            <ul class="castGroup">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="castItem|castGroup"/>
            </ul>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="castItem">
      <li class="castItem">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </li>
   </xsl:template>
   <xsl:template match="castList">
      <xsl:choose>
         <xsl:when test="child::*">
            <ul class="castList">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates select="castItem"/>
            </ul>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="cb">
      <span class="cb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:value-of select="@n"/>
      </span>
   </xsl:template>
   <xsl:template match="cell">
      <td class="cell">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </td>
   </xsl:template>
   <xsl:template match="choice">
      <xsl:choose>
         <xsl:when test="sic and corr">
            <span class="alternate choice4" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="corr[1]"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="sic[1]"/>
               </span>
            </span>
         </xsl:when>
         <xsl:when test="abbr and expan">
            <span class="alternate choice5" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="expan[1]"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="abbr[1]"/>
               </span>
            </span>
         </xsl:when>
         <xsl:when test="orig and reg">
            <span class="alternate choice6" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="reg[1]"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="orig[1]"/>
               </span>
            </span>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="cit">
      <xsl:choose>
         <xsl:when test="child::quote and child::bibl">
            <div class="cit">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="closer">
      <div class="closer">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="corr">
      <xsl:choose>
         <xsl:when test="parent::choice and count(parent::*/*) gt 1">
            <span class="corr1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="corr2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="date">
      <xsl:choose>
         <xsl:when test="@when">
            <span class="alternate date3" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:value-of select="@when"/>
               </span>
            </span>
         </xsl:when>
         <xsl:when test="text()">
            <span class="date4">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="dateline">
      <div class="dateline">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="del">
      <span class="del">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="desc">
      <span class="desc">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="div">
      <xsl:choose>
         <xsl:when test="@type='title_page'">
            <div class="div1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="parent::body or parent::front or parent::back">
            <section class="div2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </section>
         </xsl:when>
         <xsl:otherwise>
            <div class="div3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="docAuthor">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <span class="docAuthor2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="docDate">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <span class="docDate2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="docEdition">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <span class="docEdition2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="docImprint">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <span class="docImprint2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="docTitle">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
         <xsl:otherwise>
            <div class="docTitle2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="epigraph">
      <div class="epigraph">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="ex">
      <span class="ex">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="expan">
      <span class="expan">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="figDesc">
      <span class="figDesc">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="figure">
      <xsl:choose>
         <xsl:when test="head or @rendition='simple:display'">
            <div class="figure1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <span class="figure2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="floatingText">
      <div class="floatingText">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="foreign">
      <span class="foreign">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="formula">
      <xsl:choose>
         <xsl:when test="@rendition='simple:display'">
            <div class="formula1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <span class="formula2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="front">
      <div class="front">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="fw">
      <xsl:choose>
         <xsl:when test="ancestor::p or ancestor::ab">
            <span class="fw1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <div class="fw2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="g">
      <xsl:choose>
         <xsl:when test="not(text())"/>
         <xsl:otherwise>
            <span class="g2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="gap">
      <xsl:choose>
         <xsl:when test="desc">
            <span class="gap1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@extent">
            <span class="gap2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:value-of select="@extent"/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="gap3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="graphic">
      <img src="{@url}">
         <xsl:variable name="sizes">
            <xsl:if test="@width">
               <xsl:value-of select="concat('width:',@width,';')"/>
            </xsl:if>
            <xsl:if test="@height">
               <xsl:value-of select="concat('height:',@height,';')"/>
            </xsl:if>
         </xsl:variable>
         <xsl:if test="not($sizes='')">
            <xsl:attribute name="style" select="$sizes"/>
         </xsl:if>
      </img>
   </xsl:template>
   <xsl:template match="group">
      <div class="group">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="handShift">
      <span class="handShift">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="head">
      <xsl:choose>
         <xsl:when test="parent::figure">
            <div class="head1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="parent::table">
            <div class="head2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="parent::lg">
            <div class="head3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="parent::list">
            <div class="head4">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="parent::div">
            <xsl:variable name="depth">count(ancestor::div)</xsl:variable>
            <xsl:element name="{concat('h',count(ancestor::div))}">
               <xsl:attribute name="class">head</xsl:attribute>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <div class="head6">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="hi">
      <xsl:choose>
         <xsl:when test="@rendition">
            <span class="hi1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="not(@rendition)">
            <span class="hi2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="imprimatur">
      <div class="imprimatur">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="item">
      <li class="item">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </li>
   </xsl:template>
   <xsl:template match="l">
      <div class="l">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="label">
      <span class="label">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="lb">
      <span class="lb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:value-of select="@n"/>
      </span>
   </xsl:template>
   <xsl:template match="lg">
      <div class="lg">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="list">
      <xsl:choose>
         <xsl:when test="@rendition">
            <ul class="list1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates select="item"/>
            </ul>
         </xsl:when>
         <xsl:when test="not(@rendition)">
            <ul class="list2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="item"/>
            </ul>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="listBibl">
      <xsl:choose>
         <xsl:when test="bibl">
            <ul class="listBibl1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="bibl"/>
            </ul>
         </xsl:when>
         <xsl:otherwise>
            <div class="listBibl2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="measure">
      <span class="measure">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="milestone">
      <span class="milestone">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="name">
      <span class="name">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="note">
      <xsl:choose>
         <xsl:when test="@place">
            <xsl:variable name="place" select="@place"/>
            <xsl:variable name="marker" select="@n"/>
            <xsl:variable name="class">note</xsl:variable>
            <xsl:variable name="number" select="1"/>
            <xsl:variable name="I" select="generate-id()"/>
            <xsl:variable name="N">
               <xsl:number from="text" level="any" count="note"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test="$place='bottom'">
                  <sup class="footnotelink">
                     <a href="#{$I}">
                        <xsl:value-of select="if ($marker) then   $marker else $N"/>
                     </a>
                  </sup>
                  <div id="{$I}">
                     <xsl:attribute name="class">
                        <xsl:value-of select="($place, concat($class, $number))"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </div>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:if test="string-length($marker)&gt;0">
                     <sup class="notelink">
                        <a href="#{$I}">
                           <xsl:value-of select="$marker"/>
                        </a>
                     </sup>
                  </xsl:if>
                  <span>
                     <xsl:attribute name="class">
                        <xsl:value-of select="($place, concat($class, $number))"/>
                     </xsl:attribute>
                     <xsl:if test="string-length($marker)&gt;0">
                        <xsl:attribute name="id" select="$I"/>
                        <sup class="notelink">
                           <xsl:value-of select="$marker"/>
                        </sup>
                     </xsl:if>
                     <xsl:apply-templates/>
                  </span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="parent::div and not(@place)">
            <div class="note2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="not(@place)">
            <span class="note3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="num">
      <span class="num">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="opener">
      <div class="opener">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="orig">
      <span class="orig">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="p">
      <p class="p">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   <xsl:template match="pb">
      <span class="pb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:value-of select="(concat(if(@n) then concat(@n,' ') else '',if(@facs) then concat('@',@facs) else&#xA;                  ''))"/>
      </span>
   </xsl:template>
   <xsl:template match="pc">
      <span class="pc">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="postscript">
      <div class="postscript">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="publisher">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="pubPlace">
      <xsl:choose>
         <xsl:when test="ancestor::teiHeader"/>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="q">
      <xsl:choose>
         <xsl:when test="l">
            <div class="q1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:when test="ancestor::p or ancestor::cell">
            <span class="q2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <div class="q3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="quote">
      <xsl:choose>
         <xsl:when test="ancestor::p">
            <span class="quote1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <div class="quote2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:call-template name="localrendition"/>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ref">
      <xsl:choose>
         <xsl:when test="not(@target)">
            <span class="ref1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="not(text())">
            <a class="ref2" href="{@target}">
               <xsl:value-of select="@target"/>
            </a>
         </xsl:when>
         <xsl:otherwise>
            <a class="ref3" href="{@target}">
               <xsl:apply-templates/>
            </a>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="reg">
      <span class="reg">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="rhyme">
      <span class="rhyme">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="role">
      <div class="role">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="roleDesc">
      <div class="roleDesc">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="row">
      <xsl:choose>
         <xsl:when test="@role='label'">
            <tr class="row1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </tr>
         </xsl:when>
         <xsl:otherwise>
            <tr class="row2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </tr>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="rs">
      <span class="rs">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="s">
      <span class="s">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="salute">
      <xsl:choose>
         <xsl:when test="parent::closer">
            <span class="salute1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <div class="salute2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="seg">
      <span class="seg">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="sic">
      <xsl:choose>
         <xsl:when test="parent::choice and count(parent::*/*) gt 1">
            <span class="sic1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="sic2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="signed">
      <xsl:choose>
         <xsl:when test="parent::closer">
            <div class="signed1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <span class="signed2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="sp">
      <div class="sp">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="space">
      <span class="space">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="speaker">
      <div class="speaker">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="spGrp">
      <div class="spGrp">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="stage">
      <div class="stage">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="subst">
      <span class="subst">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="supplied">
      <xsl:choose>
         <xsl:when test="parent::choice">
            <span class="supplied1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@reason='damage'">
            <span class="supplied2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@reason='illegible' or not(@reason)">
            <span class="supplied3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@reason='omitted'">
            <span class="supplied4">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="supplied5">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table">
      <table class="table">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </table>
   </xsl:template>
   <xsl:template match="fileDesc">
      <title>
         <xsl:apply-templates select="titleStmt"/>
      </title>
   </xsl:template>
   <xsl:template match="profileDesc"/>
   <xsl:template match="revisionDesc"/>
   <xsl:template match="encodingDesc"/>
   <xsl:template match="teiHeader">
      <head>
         <link rel="StyleSheet" href="simple.css" type="text/css"/>
         <style type="text/css">.simple_allcaps { text-transform: uppercase; } 
.simple_blackletter { font-family: fantasy; } 
.simple_bold { font-weight: bold; } 
.simple_bottombraced { padding-bottom: 2pt; border-bottom: dashed gray
              2pt; } 
.simple_block { display:block; } 
.simple_boxed { padding: 2pt; border: solid black 1pt; } 
.simple_centre { text-align: center; } 
.simple_cursive { font-family: cursive; } 
.simple_doublestrikethrough { text-decoration: line-through; color: red; } 
.simple_doubleunderline { text-decoration: underline; color: red; } 
.simple_dropcap { font-size : 6em; font-family: cursive; font-weight : bold; vertical-align:
              top; height: 1em; line-height: 1em; float : left; width : 1em; color : #c00; margin: 0em; padding:
              0px; } 
.simple_float { float:right; display: block; font-size: smaller; clear: right; padding: 4pt;
              width: 15%;  } 
.simple_hyphen {  } 
.simple_inline { display:inline; } 
.simple_italic { font-style: italic; } 
.simple_justify { text-align: justify; } 
.simple_larger { font-size: larger; } 
.simple_left { text-align: left; } 
.simple_leftbraced { padding-left: 2pt; border-left: dotted gray 2pt;  } 
.simple_letterspace { letter-spacing: 0.5em; } 
.simple_literal { font-family:monospace; white-space:pre; } 
.simple_normalstyle { font-style:roman; } 
.simple_normalweight { font-weight:normal; } 
.simple_right { text-align: right; } 
.simple_rightbraced { padding-right: 2pt; border-right: dotted gray 2pt;  } 
.simple_rotateleft { -webkit-transform: rotate(90deg); transform:
              rotate(90deg); } 
.simple_rotateright { -webkit-transform: rotate(-90deg); transform:
              rotate(-90deg); } 
.simple_rules { border: 1px solid black; padding:
              2px;border-collapse:collapse;border-spacing:0; } 
.simple_smallcaps { font-variant: small-caps; } 
.simple_smaller { font-size: smaller; } 
.simple_strikethrough { text-decoration: line-through; } 
.simple_subscript { vertical-align: bottom; font-size: smaller; } 
.simple_superscript { vertical-align: super; font-size: smaller; } 
.simple_topbraced { padding-top: 2pt; border-top: dotted gray 2pt;  } 
.simple_typewriter { font-family:monospace; } 
.simple_underline { text-decoration: underline; } 
.simple_wavyunderline { text-decoration: underline; text-decoration-style:
              wavy; } 
span.add {color: green; text-decoration: underline;}
div.address {margin-top: 2em; margin-left: 2em; margin-right: 2em; margin-bottom: 2em;}
div.addrLine {white-space: nowrap;}
div.argument {margin-bottom: 0.5em;}
ol.castList {list-style: ordered;}
ul.castList {list-style: ordered;}
div.closer {margin-top: 1em; margin-left: 1em; margin-left: 1em;}
span.corr2:before {content: '[';}
span.corr2:after {content: ']';}
span.del {text-decoration: line-through;}
div.div1 {border: 1px solid black; padding: 5px;}
div.docTitle2 {font-size: larger;}
span.figDesc:before {content: '[..';}
span.figDesc:after {content: '..]';}
span.figDesc {color: grey;font-style:italic;}
span.figure2 {display: block; border-top: solid 1pt blue; border-bottom: solid 1pt blue;}
div.floatingText {margin: 6pt; border: solid black 1pt;}
span.foreign {font-style:italic;}
span.gap1 {color: grey;}
span.gap2:before {content: '[..';}
span.gap2:after {content: '..]';}
span.gap2 {color: grey;}
span.gap3:before {content: '[...]';}
div.head1 {font-style: italic;}
div.head2 {font-style: italic;}
div.head3 {font-style: italic;}
div.head4 {font-weight: bold;}
span.hi1 {font-style: italic;}
span.hi2 {font-style: italic;}
div.l {margin-left: 1em;}
div.note2 {margin-left: 10px;margin-right: 10px; font-size:smaller;}
span.note3:before {content:" [";}
span.note3:after {content:"] ";}
span.note3 {font-size:small;}
p.p {text-align: justify;}
span.pb {display: block; margin-left: 4pt; color: grey; float: right;}
span.pb:before {content: '[Page ';}
span.pb:after {content: ']';}
div.q1 {margin-left: 10px; margin-right: 10px;}
span.q2:before {content: '‘';}
span.q2:after {content: '’';}
div.q3 {margin-left: 10px; margin-right: 10px;}
span.quote1:before {content: '‘';}
span.quote1:after {content: '’';}
div.quote2 {margin-left: 10px; margin-right: 10px;}
tr.row1 {font-weight: bold;}
span.sic2:before {content: '{';}
span.sic2:after {content: '}';}
div.signed1 {text-align: right;}
span.signed2 {font-style: italic;}
div.speaker {font-style:italic;}
div.stage {font-style: italic;}
span.supplied2:before {content:"&lt;";}
span.supplied2:after {content:"&gt;";}
span.supplied3:before {content:"[";}
span.supplied3:after {content:"]";}
span.supplied4:before {content:"(";}
span.supplied4:after {content:")";}
span.supplied5:before {content:"{";}
span.supplied5:after {content:"}";}
table.table {font-size: smaller; background-color: #F0F0F0;}
div.text {max-width: 80%; margin: auto; font-family: Verdana, Tahoma, Geneva, Arial, Helvetica, sans-serif;}
span.title2 {color: red; font-size: 2em;}
span.title4 {font-style: italic;}
span.title6 {font-style: italic;}
span.title8 {font-style: italic;}
span.title10 {font-style: italic;}
div.titlePage {text-align: center;}
div.trailer {color: green;}
span.unclear:after {content: ' [?] ';}
</style>
         <xsl:call-template name="localRendition"/>
         <script type="text/javascript"
                 charset="utf-8"
                 src="http://code.jquery.com/jquery-1.10.2.min.js"/>
         <link rel="stylesheet"
               href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"/>
         <script type="text/javascript"
                 src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"/>
         <link rel="stylesheet"
               href="http://jqueryui.com/tooltip/resources/demos/style.css"/>
         <script type="text/javascript" charset="utf-8" src="simple.js"/>
         <xsl:apply-templates/>
      </head>
   </xsl:template>
   <xsl:template match="TEI">
      <html>
         <xsl:apply-templates/>
      </html>
   </xsl:template>
   <xsl:template match="text">
      <body>
         <xsl:apply-templates/>
      </body>
   </xsl:template>
   <xsl:template match="time">
      <span class="time">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="title">
      <xsl:choose>
         <xsl:when test="parent::titleStmt/parent::fileDesc">
            <xsl:if test="preceding-sibling::title">
               <xsl:value-of select="' — '"/>
            </xsl:if>
            <span class="title2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="not(@level) and parent::bibl">
            <span class="title3">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@level='m' or not(@level)">
            <span class="title4">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
            <xsl:if test="ancestor::biblStruct or       ancestor::biblFull">
               <xsl:value-of select="', '"/>
            </xsl:if>
         </xsl:when>
         <xsl:when test="@level='s' or @level='j'">
            <span class="title6">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
            <xsl:if test="following-sibling::* and     (ancestor::biblStruct  or     ancestor::biblFull)">
               <xsl:value-of select="', '"/>
            </xsl:if>
         </xsl:when>
         <xsl:when test="@level='u' or @level='a'">
            <span class="title8">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
            <xsl:if test="following-sibling::* and     (ancestor::biblStruct  or     ancestor::biblFull)">
               <xsl:value-of select="'. '"/>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <span class="title10">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="titlePage">
      <div class="titlePage">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="titlePart">
      <div class="titlePart">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:call-template name="localrendition"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="trailer">
      <div class="trailer">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="unclear">
      <span class="unclear">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="w">
      <span class="w">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template name="localrendition">
      <xsl:if test="@rendition">
         <xsl:variable name="values">
            <xsl:for-each select="tokenize(normalize-space(@rendition),' ')">
               <xsl:choose>
                  <xsl:when test="starts-with(.,'#')">
                     <xsl:sequence select="concat('document_',substring-after(.,'#'))"/>
                  </xsl:when>
                  <xsl:when test="starts-with(.,'simple:')">
                     <xsl:sequence select="replace(.,':','_')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:for-each select="document(.)">
                        <xsl:sequence select="concat('external_',@xml:id)"/>
                     </xsl:for-each>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:variable>
         <xsl:attribute name="class">
            <xsl:value-of select="string-join($values,' ')"/>
         </xsl:attribute>
      </xsl:if>
   </xsl:template>
   <xsl:template name="localRendition">
      <xsl:if test="key('ALL-LOCALRENDITION',1)">
         <style type="text/css">
            <xsl:for-each select="key('ALL-LOCALRENDITION',1)">
               <xsl:text>
.document_</xsl:text>
               <xsl:value-of select="@xml:id"/>
               <xsl:if test="@scope">
                  <xsl:text>:</xsl:text>
                  <xsl:value-of select="@scope"/>
               </xsl:if>
               <xsl:text> {
	</xsl:text>
               <xsl:value-of select="."/>
               <xsl:text>
}</xsl:text>
            </xsl:for-each>
            <xsl:text/>
         </style>
      </xsl:if>
      <xsl:if test="key('ALL-EXTRENDITION',1)">
         <style type="text/css">
            <xsl:for-each select="key('ALL-EXTRENDITION',1)">
               <xsl:variable name="pointer">
                  <xsl:value-of select="."/>
               </xsl:variable>
               <xsl:for-each select="key('EXTRENDITION',$pointer)[1]">
                  <xsl:for-each select="document($pointer)">
                     <xsl:text>
.</xsl:text>
                     <xsl:value-of select="@xml:id"/>
                     <xsl:if test="@scope">
                        <xsl:text>:</xsl:text>
                        <xsl:value-of select="@scope"/>
                     </xsl:if>
                     <xsl:text> {
</xsl:text>
                     <xsl:value-of select="."/>
                     <xsl:text>
}</xsl:text>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </style>
      </xsl:if>
   </xsl:template>
   <xsl:function name="tei:escapeChars">
      <xsl:param name="letters"/>
      <xsl:param name="context"/>
      <xsl:value-of select="translate($letters,'ſ','s')"/>
   </xsl:function>
   <xsl:template match="text()" mode="#default plain">
      <xsl:choose>
         <xsl:when test="ancestor::*[@xml:space][1]/@xml:space='preserve'">
            <xsl:value-of select="tei:escapeChars(.,parent::*)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="context" select="name(parent::*)"/>
            <xsl:if test="matches(.,'^\s') and  normalize-space()!=''">
               <xsl:choose>
                  <xsl:when test="(parent::*/preceding-sibling::node()[1][name()=$context])">
                     <xsl:value-of select="' '"/>
                  </xsl:when>
                  <xsl:when test="position()=1"/>
                  <xsl:otherwise>
                     <xsl:value-of select="' '"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:value-of select="tei:escapeChars(normalize-space(.),parent::*)"/>
            <xsl:choose>
               <xsl:when test="last()=1 and string-length()!=0 and      normalize-space()=''">
                  <xsl:value-of select="' '"/>
               </xsl:when>
               <xsl:when test="position()!=1 and position()!=last() and matches(.,'\s$')">
                  <xsl:value-of select="' '"/>
               </xsl:when>
               <xsl:when test="position()=1 and matches(.,'\s$') and normalize-space()!=''">
                  <xsl:value-of select="' '"/>
               </xsl:when>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
