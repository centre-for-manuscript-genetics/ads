<?xml version="1.0"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.1"
     xmlns:saxon="http://icl.com/saxon" saxon:trace="no"
exclude-result-prefixes="saxon">
<xsl:output method="xml" encoding="iso-8859-1" omit-xml-declaration="yes"/>

<xsl:template match="TEI.2">
 <TEI.2>
    <xsl:apply-templates/>
 </TEI.2>
</xsl:template>

<xsl:template match="*|@*|comment()|text()">
<xsl:copy>
<xsl:apply-templates select="*|@*|comment()|text()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="text">
<xsl:param name="wit"/>
<xsl:if test="@id='OpdDD'">
<xsl:for-each select="//witness">
<xsl:variable name="file"
     select="concat(@id, 'search.xml')"/>
  <xsl:choose>
  <xsl:when test="element-available('xsl:document')">
      <xsl:document href="{$file}">
<TEI.2>
<text><xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
 <xsl:apply-templates select="ancestor::text/body"><xsl:with-param name="wit"><xsl:value-of select="@id"/></xsl:with-param></xsl:apply-templates>
</text>
</TEI.2>
     </xsl:document>
  </xsl:when>
  <xsl:when test="element-available('saxon:output')"
           xmlns:saxon="http://icl.com/saxon">
       <saxon:output file="{$file}"
         xsl:extension-element-prefixes="saxon" href="{$file}">
         <xsl:copy-of select="."/>
       </saxon:output>
   </xsl:when>
   <xsl:otherwise>
     <xsl:message terminate="yes">Cannot write to multiple output files</xsl:message>
   </xsl:otherwise>
  </xsl:choose>
</xsl:for-each>
</xsl:if>
</xsl:template>

<xsl:template match="body">
<xsl:param name="wit"/>
<body>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</body>
</xsl:template>

<xsl:template match="div">
<xsl:param name="wit"/>
<div>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</div>
</xsl:template>

<xsl:template match="head">
<xsl:param name="wit"/>
<head>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</head>
</xsl:template>

<xsl:template match="p">
<xsl:param name="wit"/>
<p>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</p>
</xsl:template>

<xsl:template match="hi">
<xsl:param name="wit"/>
<hi><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</hi>
</xsl:template>

<xsl:template match="seg">
<xsl:param name="wit"/>
<seg><xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute><xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute><xsl:attribute name="corresp"><xsl:value-of select="$wit"/></xsl:attribute>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</seg>
</xsl:template>

<xsl:template match="app">
<xsl:param name="wit"/>
<xsl:choose>
<xsl:when test="substring($wit,6,1)='b' and count(rdg[contains(@wit,substring($wit,1,5))])= 2">
<xsl:apply-templates select="rdg[contains(@wit,$wit)]"><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</xsl:when>
<xsl:when test="substring($wit,6,1)='b' and not(contains(rdg/@wit,$wit))">
<xsl:apply-templates><xsl:with-param name="wit" select="concat(substring($wit,1,5), 'a')"/></xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="rdg">
<xsl:param name="wit"/>
<xsl:choose>
<xsl:when test="contains($wit,'OpdP1') and $wit != 'OpdP1a'">
<xsl:if test="contains(@wit,'OpdP1b')">
 <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</xsl:if>
</xsl:when>
<xsl:when test="contains($wit,'OpdP1') and $wit = 'OpdP1a'">
<xsl:if test="contains(@wit,$wit)">
 <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</xsl:if>
</xsl:when>
<xsl:when test="not(contains($wit,'OpdP1'))">
<xsl:if test="contains(@wit,$wit)">
 <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
</xsl:if>

</xsl:when>
<xsl:otherwise>
<!-- lkj -->
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="pb">
<!-- lkj -->
</xsl:template>

</xsl:stylesheet>
