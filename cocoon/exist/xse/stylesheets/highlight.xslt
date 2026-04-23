<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- $Header: /cvsroot/exist/eXist-1.0/webapp/xse/stylesheets/highlight.xslt,v 1.3 2004/02/16 14:41:51 jmvanel Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
       exclude-result-prefixes=""
       xmlns="http://www.w3.org/1999/xhtml"
       xmlns:exist="http://exist.sourceforge.net/NS/exist"
       version="1.0" >

  <xsl:template match="exist:match" >
        <span class='highlight' >
          <xsl:value-of select="." />
        </span><xsl:text>
        </xsl:text>
  </xsl:template>

  <xsl:template match="text()[../@class='highlight-container'][string-length(normalize-space(.))!=0]" >
        <span class='highlight-container' >
          <xsl:value-of select="." />
        </span><xsl:text>
        </xsl:text>
  </xsl:template>


  <!-- This is a simple identity function -->
  <xsl:template match="@*|*|processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet> 
