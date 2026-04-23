<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:exist="http://exist.sourceforge.net/NS/exist"
  version="1.0">
  
<!-- the following templates pretty-print xml source code.
     All xml content contained between the xml-source tags
     is pretty printed. Modified by Vincent Neyt for the
     Beckett Edition
-->
<xsl:param name="query" select="//query"/>
<xsl:param name="collection" select="//collection"/>
<xsl:param name="lang" select="//language"/>
<xsl:param name="substringcapital3" select="concat(translate(substring($query,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),substring($query,2,3))"/>
<xsl:param name="substringcapital4" select="concat(translate(substring($query,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),substring($query,2,4))"/>
<xsl:param name="substringcapital5" select="concat(translate(substring($query,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),substring($query,2,5))"/>
<xsl:param name="substringcapital6" select="concat(translate(substring($query,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),substring($query,2,6))"/>

<xsl:param name="substring3" select="substring($query,1,3)"/>
<xsl:param name="substring4" select="substring($query,1,4)"/>
<xsl:param name="substring5" select="substring($query,1,5)"/>
<xsl:param name="substring6" select="substring($query,1,6)"/>

<xsl:param name="type" select="//type"/>

<xsl:template match="xml-source">
  <p>
    <xsl:apply-templates mode="xmlsrc"/>
  </p>
  <p class="link"><a target="_parent"><xsl:attribute name="href">http://localhost:9999/ads/<xsl:value-of select="substring(child::*/@corresp,1,3)"/>.htm?text=doclin&amp;notes=on&amp;document=<xsl:value-of select="child::*/@corresp"/>&amp;highlight=<xsl:value-of select="$query"/>#<xsl:value-of select="child::*/@id"/></xsl:attribute><sup>&gt; naar tekst</sup></a>
  </p>
</xsl:template>

<xsl:template match="text()" mode="xmlsrc">
  <xsl:choose>
    <xsl:when test="$type='thorough' and contains(.,$query)">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substring3) and not(contains(.,$substring4))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substring4) and not(contains(.,$substring5))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substring5) and not(contains(.,$substring6))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substring6)">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substringcapital3) and not(contains(.,$substringcapital4))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substringcapital4) and not(contains(.,$substringcapital5))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substringcapital5) and not(contains(.,$substringcapital6))">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$type='thorough' and contains(.,$substringcapital6)">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- 
<xsl:template match="processing-instruction()" mode="xmlsrc">
  <dd>
    <font color="darkred">&lt;?<xsl:value-of select="."/>?&gt;</font>
  </dd>
</xsl:template>
-->

<xsl:template match="comment()" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="query" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="type" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="language" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>


<!-- 
<xsl:template match="@*" mode="xmlsrc">
  <xsl:text> </xsl:text>
  <xsl:choose>
    <xsl:when test="not(namespace-uri(.)='')">
	  <font color="purple">
        <xsl:value-of select="name(.)"/>
      </font>
    </xsl:when>
    <xsl:otherwise>
		<font color="red">
        	<xsl:value-of select="name(.)"/>
      	</font>
    </xsl:otherwise>
  </xsl:choose>
  ="<font color="lime">
  	<xsl:call-template name="highlight">
  		<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
  	</xsl:call-template>
  </font>"
</xsl:template>
-->

<xsl:template match="date" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="note" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="add/note" mode="xmlsrc">
  <!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="add" mode="xmlsrc">
    <xsl:if test="@place='marginleft'">
     <font color="green">
      <xsl:apply-templates mode="xmlsrc"/>
     </font>
    </xsl:if>
    <xsl:if test="@place!='marginleft'">
     <font color="blue">
      <xsl:apply-templates mode="xmlsrc"/>
     </font>
  </xsl:if>
      <xsl:if test="not(@place)">
     <font color="blue">
      <xsl:apply-templates mode="xmlsrc"/>
     </font>
  </xsl:if>
</xsl:template>

<xsl:template match="add/add" mode="xmlsrc">
    <xsl:if test="@place='marginleft'">
     <font color="green">
      <xsl:apply-templates mode="xmlsrc"/>
     </font>
    </xsl:if>
    <xsl:if test="@place!='marginleft'">
     <font color="red">
      <xsl:apply-templates mode="xmlsrc"/>
     </font>
  </xsl:if>
</xsl:template>

<xsl:template match="del" mode="xmlsrc">
  <strike><xsl:apply-templates mode="xmlsrc"/></strike>
</xsl:template>

<xsl:template match="pb" mode="xmlsrc">
  <font color="red">[p. <xsl:value-of select="@n"/>]</font>
</xsl:template>

<xsl:template match="unclear" mode="xmlsrc">[<xsl:apply-templates mode="xmlsrc"/>]</xsl:template>

<xsl:template match="lb" mode="xmlsrc">
  <br/>
</xsl:template>

<xsl:template match="gloss" mode="xmlsrc">
  <!-- <xsl:apply-templates/> -->
</xsl:template>

<xsl:template match="hi" mode="xmlsrc">
 <xsl:choose>
  <xsl:when test="@rend='i'">
   <i>
    <xsl:apply-templates mode="xmlsrc"/>
   </i>
  </xsl:when>
  <xsl:when test="@rend='onderstreept'">
   <u>
    <xsl:apply-templates mode="xmlsrc"/>
   </u>
  </xsl:when>
  <xsl:when test="@rend='underline'">
   <u>
    <xsl:apply-templates mode="xmlsrc"/>
   </u>
  </xsl:when>
  <xsl:when test="@rend='dotted line'">
   <strike style="">
    <xsl:apply-templates mode="xmlsrc"/>
   </strike>
  </xsl:when>
  <xsl:when test="@rend='red crayon'">
   <span style="background-color:#FF3F3F;">
    <xsl:apply-templates mode="xmlsrc"/>
   </span>
  </xsl:when>
  <xsl:otherwise>
    <!--
    <xsl:value-of select="."/>
    -->
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="exist:match" mode="xmlsrc">
	<span style="background-color: #FFFF00"><xsl:apply-templates mode="xmlsrc"/></span>
</xsl:template>

<!-- 
<xsl:template match="*" mode="xmlsrc">
  <div style="margin-left: 20px">
    <font color="navy">
      <xsl:text>&lt;</xsl:text>
    </font>
    <xsl:choose>
      <xsl:when test="not(namespace-uri()='')">
        <font color="green">
          <xsl:value-of select="name()"/>
        </font>
      </xsl:when>
      <xsl:otherwise>
        <font color="navy">
          <xsl:value-of select="name()"/>
        </font>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="@*" mode="xmlsrc"/>
    <xsl:choose>
      <xsl:when test="exist:match">
        <font color="navy">
          &gt;
        </font>
        <xsl:apply-templates mode="xmlsrc"/>
        <font color="navy">
          &lt;/
          <xsl:value-of select="name()"/>
          &gt;
        </font>
      </xsl:when>    
      <xsl:when test="text()">
      	<font color="navy">
          &gt;
        </font>
        <xsl:apply-templates mode="xmlsrc"/>
        <font color="navy">
          &lt;/
          <xsl:value-of select="name()"/>
          &gt;
        </font>
      </xsl:when>
      <xsl:when test="*">
        <font color="navy">
          &gt;
        </font>
        <div>
          <xsl:apply-templates select="node()" mode="xmlsrc"/>
        </div>
        <font color="navy">
          &lt;/
        </font>
        <xsl:choose>
          <xsl:when test="not(namespace-uri()='')">
            <font color="green">
              <xsl:value-of select="name()"/>
            </font>
          </xsl:when>
          <xsl:otherwise>
            <font color="navy">
              <xsl:value-of select="name()"/>
            </font>
          </xsl:otherwise>
        </xsl:choose>
        <font color="navy">
          &gt;
        </font>
      </xsl:when>
      <xsl:otherwise>
        <font color="navy">
          /&gt;
        </font>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>
-->

<xsl:template name="highlight" mode="xmlsrc">
  <xsl:param name="p_text" select="''"/>
  <xsl:choose>
    <xsl:when test="contains($p_text,$query)">
      <xsl:value-of select="substring-before($p_text,$query)"/>
      <span style="background-color: #FFFF00">
      <xsl:value-of select="$query"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$query)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substring3) and not(contains($p_text,$substring4))">
      <xsl:value-of select="substring-before($p_text,$substring3)"/>
      <span style="background-color: #FF0000">
      <xsl:value-of select="$substring3"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substring3)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substring4) and not(contains($p_text,$substring5))">
      <xsl:value-of select="substring-before($p_text,$substring4)"/>
      <span style="background-color: #FF0000">
      <xsl:value-of select="$substring4"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substring4)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substring5) and not(contains($p_text,$substring6))">
      <xsl:value-of select="substring-before($p_text,$substring5)"/>
      <span style="background-color: #FF0000">
      <xsl:value-of select="$substring5"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substring5)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substring6)">
      <xsl:value-of select="substring-before($p_text,$substring6)"/>
      <span style="background-color: #FF0000">
      <xsl:value-of select="$substring6"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substring6)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substringcapital3) and not(contains($p_text,$substringcapital4))">
      <xsl:value-of select="substring-before($p_text,$substringcapital3)"/>
      <span style="background-color: #FF0000">
      <xsl:value-of select="$substringcapital3"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substringcapital3)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substringcapital4) and not(contains($p_text,$substringcapital5))">
      <xsl:value-of select="substring-before($p_text,$substringcapital4)"/>
      <span style="background-color: #FFFF00">
      <xsl:value-of select="$substringcapital4"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substringcapital4)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substringcapital5) and not(contains($p_text,$substringcapital6))">
      <xsl:value-of select="substring-before($p_text,$substringcapital5)"/>
      <span style="background-color: #FFFF00">
      <xsl:value-of select="$substringcapital5"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substringcapital5)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($p_text,$substringcapital6)">
      <xsl:value-of select="substring-before($p_text,$substringcapital6)"/>
      <span style="background-color: #FFFF00">
      <xsl:value-of select="$substringcapital6"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$substringcapital6)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise> 
    <xsl:value-of select="$p_text"/>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
