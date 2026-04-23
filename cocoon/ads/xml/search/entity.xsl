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

</xsl:stylesheet>
