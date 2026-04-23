<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">
<xsl:import href="adsOuter.xsl"/>
<xsl:import href="home.xsl"/>
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

<xsl:param name="text"/>
<xsl:param name="document"/>
<xsl:param name="page"/>
<xsl:param name="n"/>
<xsl:param name="id"/>
<xsl:param name="corresp"/>
<xsl:param name="app"/>
<xsl:param name="export" select="''"/>
<xsl:param name="view" select="'toplayer'"/>
<xsl:param name="segM2" select="//text[@id=substring($document,1,5)]//seg[@n=$n]/@base"/>
<xsl:param name="segDD" select="//text[@id='AdsDD']//seg[@n=$n]/@base"/>
<xsl:param name="seg" select="//text[@id='AdsM1']//seg[@base=$segM2]"/>
<xsl:param name="segdd" select="//text[@id='AdsM1']//seg[@base=$segDD]"/>
<xsl:param name="correspseg" select="//text[@id='AdsM1']//seg[@base=$segM2]/@base"/>
<xsl:param name="correspsegDD" select="//text[@id='AdsM1']//seg[@base=$segDD]/@base"/>
<xsl:template match="text">
<xsl:param name="segn" select="//seg[@base = $id]/@base"/>
<xsl:param name="pageid" select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@n"/>
<xsl:param name="pagefirst" select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=$document]/thumbs[position() = 1]/page[@id=$page and position() = 1]"/>
<xsl:param name="pagelast" select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=$document]/thumbs[position() = last()]/page[@id=$page and position() = last()]"/>
<xsl:if test="$export!='print'">
<div class="navigationright">
 <table align="center" width="100%">
  <tr>
     <!-- boven -->
   <td align="center" colspan="3"><p class="navigation"><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="$document"/>&amp;page=1#<xsl:value-of select="$n"/></xsl:attribute>Terug naar de tekst<br/><img border="0" src="navi/up.jpg"/></a></p></td></tr>
     <!-- links -->
    <tr><td align="right" width="49%"><p class="navigation"><xsl:if test="$segn = 'z001'"><img border="0" src="navi/left.jpg"/></xsl:if><xsl:if test="$segn != 'z001'"><a><xsl:attribute name="href">zin.htm?text=doclinlay&amp;document=AdsM1<xsl:if test="contains($document,'AdsM2')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) - 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsM1')">&amp;id=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@base"/>&amp;n=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@n"/>&amp;corresp=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsD') or contains($document,'AdsP') or contains($document,'AdsT') or contains($document,'AdsM3')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) - 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@type"/></xsl:if>&amp;view=<xsl:value-of select="$view"/></xsl:attribute>Vorige<xsl:text> </xsl:text><img border="0" src="navi/left.jpg"/></a></xsl:if></p></td>
     <!-- rechts -->
   <td width="1%"/><td align="left" width="49%"><p class="navigation"><xsl:if test="$segn = 'z324'"><img border="0" src="navi/right.jpg"/></xsl:if><xsl:if test="$segn != 'z324'"><a><xsl:attribute name="href">zin.htm?text=doclinlay&amp;document=AdsM1<xsl:if test="contains($document,'AdsM2')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsM1')">&amp;n=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsD') or contains($document,'AdsP') or contains($document,'AdsT') or contains($document,'AdsM3')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@type"/></xsl:if>&amp;view=<xsl:value-of select="$view"/></xsl:attribute><img border="0" src="navi/right.jpg"/><xsl:text> </xsl:text>Volgende</a></xsl:if></p></td></tr>
  </table>
 </div>
 </xsl:if>

 <!-- Navigation box left  -->
 <table width="200" height="50" style="float:left;">
 <tr><td></td></tr>
 </table>
 <!-- title -->
 <h1><xsl:if test="starts-with($document,'Ads')">ACHTER DE SCHERMEN</xsl:if><xsl:if test="starts-with($document,'Opd')">Opdracht</xsl:if></h1>
 <h2><xsl:if test="$text='docfacs' or $text='docfacspop'">Facsimile</xsl:if><xsl:if test="$text='docfacstopo'">Topografische transcriptie</xsl:if><xsl:if test="$text='doclinlay'">Schrijfproces</xsl:if> van<br/> <xsl:value-of select="$document"/>, zin <xsl:value-of select="substring-after($id,'z')"/></h2>
<div align="left" style="display:block;width:100%;">
<table width="100%">
<tr><td valign="top">
<table>
<tr><td><h4>Schrijfproces</h4><br/></td></tr>
<tr><td>
<xsl:for-each select="ancestor::TEI.2//text[@id='AdsDD']//front//witness[@n = 'AdsM1']">
<p><b><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#
<xsl:if test="not(contains($document,'AdsM2'))"><xsl:value-of select="ancestor::TEI.2//seg[@base=$correspsegDD]/@base"/></xsl:if><xsl:if test="contains($document,'AdsM2')"><xsl:value-of select="ancestor::TEI.2//seg[@base=$correspseg]/@base"/></xsl:if></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<xsl:if test="$corresp=''"><br/>|</xsl:if></p>
</xsl:for-each></td></tr>
<xsl:apply-templates select="document('http://localhost:9999/ads/toc.xml')//toc/nums/num"/>
<!-- apparaat -->
<tr><td>

<xsl:for-each select="ancestor::TEI.2//text[@id='AdsDD']//front//witness[@n != 'AdsM1']">
<xsl:variable name="jip"><xsl:value-of select="@n"/></xsl:variable>
<xsl:if test="contains($document,'AdsM')">
<xsl:if test="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]//app/rdg[contains(@wit,current()/@sigil)]">
  <p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspseg]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/>
    <xsl:for-each select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:apply-templates select="."><xsl:with-param name="wit" select="$jip"/></xsl:apply-templates><xsl:text> </xsl:text></xsl:for-each>
    <!--<xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates><xsl:text> </xsl:text>-->
  </p>
</xsl:if>
</xsl:if>
<xsl:if test="not(contains($document,'AdsM'))">
<xsl:if test="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]//app/rdg[contains(@wit,current()/@sigil)]">
  <p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspsegDD]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/>
    <xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
  </p>
</xsl:if>
</xsl:if>
<!-- als er geen variatie is -->
<!-- voor de M'n -->
<xsl:if test="contains($document,'AdsM')">
<xsl:if test="not(ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]//app)">

<xsl:if test="substring(@n,6,1) = ''"><p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspseg]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/>
<xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></p></xsl:if>
    

<xsl:if test="substring(@n,6,1) = 'a'"><p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspseg]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/><xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="concat(substring(@n,1,5), 'a')"/></xsl:apply-templates></p></xsl:if>

<xsl:if test="substring(@n,6,1) != 'a' and substring(@n,6,1) != ''"></xsl:if>
  
</xsl:if>
</xsl:if>
<!-- voor de Niet M'en -->
<xsl:if test="not(contains($document,'AdsM'))">
<xsl:if test="not(ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]//app)">

<xsl:if test="substring(@n,6,1) = ''"><p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspsegDD]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/>
<xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></p></xsl:if>
    

<xsl:if test="substring(@n,6,1) = 'a'"><p><b><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="$document=current()/@n"><xsl:attribute name="style">color:green;font-family:Arial Narrow;</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring(@n,1,3)"/>.htm?text=doclinlay&amp;document=<xsl:value-of select="@n"/>#<xsl:value-of select="ancestor::TEI.2//seg[@base=$correspsegDD]/@base"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></b>:<br/><xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="concat(substring(@n,1,5), 'a')"/></xsl:apply-templates></p></xsl:if>

<xsl:if test="substring(@n,6,1) != 'a' and substring(@n,6,1) != ''"></xsl:if>
  
</xsl:if>
</xsl:if>
  </xsl:for-each>
</td></tr>
<!-- einde apparaat -->
</table>
<!-- facsimile thumbnail -->
</td><td valign="top" width="150"><br/>
<table><tr><td align="center">  <span style="color:green;font-family:Arial Narrow;"><b><xsl:value-of select="substring($document,1,5)"/></b></span><br/>
<a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacs&amp;document=<xsl:value-of select="substring($document,1,5)"/>&amp;page=<xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]">3</xsl:if><xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)]">6</xsl:if><xsl:if test="$document='AdsM1' and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]) and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)])"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if><xsl:if test="$document!='AdsM1'"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if></xsl:attribute><img border="0" style="float:left;margin: 0px 10px 0px 0px;
border: 1px solid #666; padding: 2px;"><xsl:attribute name="src"><xsl:value-of select="substring($document,1,5)"/>/thumbs/<xsl:value-of select="substring($document,1,5)"/>-<xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]">3</xsl:if><xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)]">6</xsl:if><xsl:if test="$document='AdsM1' and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]) and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)])"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if><xsl:if test="$document!='AdsM1'"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if>.jpg</xsl:attribute></img></a>
 </td></tr><tr><td align="center"><font color="red"><a class="pb"><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute>[<xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]">3</xsl:if><xsl:if test="$document='AdsM1' and document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)]">6</xsl:if><xsl:if test="$document='AdsM1' and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['061' &gt;= substring($n,1,3) and '055' &lt;= substring($n,1,3)]) and not(document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page['130' &gt;= substring($n,1,3) and '120' &lt;= substring($n,1,3)])"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if><xsl:if test="$document!='AdsM1'"><xsl:value-of select="document('http://localhost:9999/ads/toc.xml')//toc/document[@id=substring($document,1,5)]/thumbs/page[@segn &gt;= substring($n,1,3) and @segp &lt;= substring($n,1,3)]/@id"/></xsl:if>]</a><xsl:text> </xsl:text></font></td></tr></table></td></tr>
</table>
</div>
</xsl:template>


<xsl:template match="num">
<xsl:if test="current() &lt;= $corresp">
<tr><td><xsl:call-template name="div"><xsl:with-param name="ana" select="current()"/></xsl:call-template></td></tr>
</xsl:if>
</xsl:template>

<xsl:template name="div">
<xsl:param name="ana"/>
<xsl:param name="inkt" select="ancestor::TEI.2//text[@id='AdsM1']//seg[@n=$n]//node()[not(self::hi)][substring-after(@layer,'l') = $ana]/@rend[. != 'zwarte inkt']"/>
<xsl:param name="alphabet" select="'abcdefghijklmnopqrstuvwxyz'"/>
<!-- stappen -->
<div align="left" style="width:100%;">
  <xsl:if test="$ana=$corresp">Resultaat</xsl:if><xsl:if test="$ana!=$corresp">Stap <xsl:if test="starts-with($ana,'0')"><xsl:value-of select="substring($alphabet,substring($ana,2)+1,1)"/></xsl:if><xsl:if test="not(starts-with($ana,'0'))"><xsl:value-of select="substring($alphabet,$ana+1,1)"/></xsl:if></xsl:if> <xsl:if test="$inkt != 'zwarte inkt' and $inkt !='u' and not(//seg[@n=$n]/@rend)"><xsl:text> </xsl:text> [bevat een nieuwe laag: <xsl:value-of select="$inkt"/>]</xsl:if><xsl:if test="$inkt != 'zwarte inkt' and $inkt !='u' and //seg[@n=$n]/@rend != ''"><xsl:text> </xsl:text> [schrijfstof (grondlaag): <xsl:value-of select="//seg[@n=$n]/@rend"/>]</xsl:if><br/>
  <xsl:if test="contains($document,'AdsM')">
  <xsl:if test="$ana=$corresp"><xsl:apply-templates select="$seg"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="'toplayer'"/></xsl:apply-templates><br/></xsl:if>
  <xsl:if test="$ana!=$corresp"><xsl:apply-templates select="$seg"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates><br/></xsl:if>
  </xsl:if>
  <xsl:if test="not(contains($document,'AdsM'))">
  <xsl:if test="$ana=$corresp"><xsl:apply-templates select="$segdd"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="'toplayer'"/></xsl:apply-templates><br/></xsl:if>
  <xsl:if test="$ana!=$corresp"><xsl:apply-templates select="$segdd"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates><br/></xsl:if>
  </xsl:if>
  _________
</div>

</xsl:template>

<xsl:template match="seg">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:param name="wit"/>
 <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="p">
   <p>
    <xsl:apply-templates/>
   </p>
</xsl:template>

<xsl:template match="del">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<!--<xsl:choose>
 <xsl:when test="$view!='toplayer'">
 <xsl:if test="substring-after(@layer,'l') &lt;= $ana">
   <strike>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </strike>
 </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
   <strike>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </strike>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &gt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
 </xsl:if>
 </xsl:when>
 <xsl:otherwise> -->
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <!-- <xsl:apply-templates/> -->
 </xsl:if>
   <xsl:if test="not(substring-after(@layer,'l'))">
   <strike>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </strike>
 </xsl:if>
  <xsl:if test="substring-after(@layer,'l') = $ana">
    <strike><xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates></strike>
 </xsl:if> 
 <xsl:if test="substring-after(@layer,'l') &gt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
 </xsl:if> 
<!-- </xsl:otherwise>
</xsl:choose>  -->
</xsl:template>

<xsl:template match="add">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:choose>
 <xsl:when test="@place='overschreven'">
  <xsl:if test="substring-after(@layer,'l') = $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if> 
  </xsl:when>
  <xsl:when test="@corresp='zin2'">
  <xsl:if test="substring-after(@layer,'l') = $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
  </xsl:when>
  <xsl:otherwise>
  <xsl:if test="substring-after(@layer,'l') = $ana">
   <font color="blue" class="blue">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </font>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
   <font color="blue" class="blue">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </font>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>  
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- note -->
<xsl:template match="note"><xsl:param name="ana"/><xsl:param name="view"/> 
 <xsl:if test="$export!='print'"><xsl:if test="substring-after(@layer,'l') = $ana">
<xsl:text>  </xsl:text><a href="javascript:void(0);" style="text-decoration:none;"><xsl:attribute name="onclick">return overlib('<xsl:value-of select="."/>', STICKY, CAPTION, 'Noot', CENTER);</xsl:attribute><xsl:attribute name="onmouseout">nd();</xsl:attribute><img src="note.gif" border="0"/></a><xsl:text>  </xsl:text>
 </xsl:if> </xsl:if>
</xsl:template>

<xsl:template match="sic"><xsl:param name="ana"/><xsl:param name="view"/>
<xsl:apply-templates/><xsl:if test="$export!='print'"><xsl:if test="substring-after(@layer,'l') = $ana"><xsl:text>  </xsl:text><a href="javascript:void(0);" style="text-decoration:none;"><xsl:attribute name="onclick">return overlib('lees: <xsl:value-of select="@corr"/>', STICKY, CAPTION, 'Noot', CENTER);</xsl:attribute><xsl:attribute name="onmouseout">nd();</xsl:attribute><img src="note.gif" border="0"/></a><xsl:text>  </xsl:text>
</xsl:if></xsl:if>
</xsl:template>

<!-- Unclear -->
<xsl:template match="unclear">
<xsl:param name="ana"/><xsl:param name="view"/>[<xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>]</xsl:template>

<!-- highlighted text -->
<xsl:template match="hi">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:param name="wit"/>
 <xsl:choose>
  <xsl:when test="@rend='i'">
   <i>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </i>
  </xsl:when>
  <xsl:when test="@rend='u' or @rend='onderstreept'">
  <xsl:if test="@layer">
   <xsl:if test="substring-after(@layer,'l') = $ana">
   <u>
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </u>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
   <u>
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </u>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
  </xsl:if>
  <xsl:if test="not(@layer) and not(@n)">
    <u>
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </u> 
  </xsl:if>
    <xsl:if test="@n">
   <xsl:if test="substring-after(@n,'l') = $ana">
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>

  </xsl:if>
  <xsl:if test="not(substring-after(@n,'l'))">

     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>

 </xsl:if>
 <xsl:if test="substring-after(@n,'l') &gt; $ana">
     <u><xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates></u>
  </xsl:if>
   <xsl:if test="substring-after(@n,'l') &lt; $ana">
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>

  </xsl:if>
  </xsl:when>
    <xsl:when test="@rend='red crayon'">
      <xsl:if test="not(@layer)">
   <span style="background-color:#FF3F3F;">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </span>
     </xsl:if>
       <xsl:if test="@layer">
   <xsl:if test="substring-after(@layer,'l') = $ana">
   <span style="background-color:#FF3F3F;">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </span>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
   <span style="background-color:#FF3F3F;">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </span>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &gt; $ana">
     <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
  </xsl:if>
  </xsl:when>
 <xsl:otherwise>
    <!--
    <xsl:value-of select="."/>
    -->
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- dates -->
<xsl:template match="date">
<xsl:param name="ana"/>
<xsl:param name="view"/>
 <span class="date">
  <b>
   <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </b>
 </span>
</xsl:template>

<!-- line breaks -->
<xsl:template match="lb">
 <br/>
</xsl:template>

<xsl:template match="div1">
<xsl:param name="ana"/>
<xsl:param name="view"/>
 <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
</xsl:template>

<xsl:template match="stage">
<xsl:param name="ana"/>
<xsl:param name="view"/>
  <i> <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates> </i>
</xsl:template>

<xsl:template match="speaker">
<xsl:param name="ana"/>
<xsl:param name="view"/>
  <b> <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/>	</xsl:apply-templates> </b>
</xsl:template>

<xsl:template match="rdg">
<xsl:param name="wit"/>
<xsl:choose>
 <xsl:when test="$text='doclinlay' and contains(@wit,$wit)">
  <!-- normaal -->
  <xsl:if test="not(contains(substring(@wit,1,6),$wit))"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></xsl:if>
  <!-- wann. eerst voorkomt op 2e niveau-->
  <xsl:if test="ancestor::rdg[not(contains(substring(@wit,1,6),$wit))] and contains(substring(@wit,1,6),$wit)"><em class="rdgdoclin2" style="font-style:normal;color:black;"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></em></xsl:if>
  <xsl:if test="ancestor::rdg[contains(substring(@wit,1,6),$wit)] and contains(substring(@wit,1,6),$wit)"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></xsl:if>
  <!-- wann. eerst voorkomt op 1e niveau -->
  <xsl:if test="not(ancestor::rdg) and contains(substring(@wit,1,6),$wit)"><span class="rdgdoclin"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></span></xsl:if>
 </xsl:when>
  <xsl:when test="$text='doclinlay' and not(contains(@wit,$wit)) and contains(@wit,substring($wit,1,5)) and not(preceding-sibling::rdg[contains(@wit,$wit)]) and not(following-sibling::rdg[contains(@wit,$wit)])">
  <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
  </xsl:when>
 <xsl:when test="$text='doclinapp' and not(parent::app[@n=$app])">
    <xsl:if test="contains(@wit,$wit)"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <xsl:if test="contains(@wit,concat($document, ' ')) and $trans='yes'">
  <a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=doclinapp&amp;document=<xsl:value-of select="$document"/>&amp;app=<xsl:value-of select="parent::app/@n"/>&amp;trans=yes</xsl:attribute><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></a>
 </xsl:if>
 <!--<xsl:if test="$trans!='yes' and contains(@wit,concat($document, ' '))">
  <xsl:apply-templates/>
 </xsl:if>-->
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="app">
<xsl:param name="wit"/>
<xsl:choose>
 <xsl:when test="substring($wit,6,1) != '' and rdg[1][not(contains(@wit,$wit))] and rdg[2][not(contains(@wit,$wit))] and rdg[3][not(contains(@wit,$wit))] and preceding-sibling::app/rdg[contains(@wit,$wit)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="concat(substring($wit,1,5), 'a')"/></xsl:apply-templates>
 </xsl:when>
 <xsl:when test="substring($wit,6,1) != '' and rdg[1][not(contains(@wit,$wit))] and rdg[2][not(contains(@wit,$wit))] and rdg[3][not(contains(@wit,$wit))] and following-sibling::app/rdg[contains(@wit,$wit)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="concat(substring($wit,1,5), 'a')"/></xsl:apply-templates>
 </xsl:when>
 <xsl:otherwise>
 <xsl:for-each select="current()"><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:text> </xsl:text></xsl:for-each>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="ptr">
<xsl:param name="wit"/>
<xsl:param name="ana"/>
<xsl:choose>
 <xsl:when test="substring-after(@layer,'l') = $ana and contains(@corresp,$wit)">
 <xsl:if test="@type='right'">
   <xsl:text> </xsl:text><a><xsl:attribute name="href">zin.htm?text=doclinlay&amp;document=AdsM1<xsl:if test="contains($document,'AdsM2')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsM1')">&amp;n=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n=substring($n,1,3) + 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsD') or contains($document,'AdsP') or contains($document,'AdsT') or contains($document,'AdsM3')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) + 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) + 1]/@type"/></xsl:if>&amp;view=<xsl:value-of select="$view"/></xsl:attribute><img border="0"><xsl:attribute name="src">navi/<xsl:value-of select="@type"/>.jpg</xsl:attribute></img></a>
   </xsl:if>
    <xsl:if test="@type='left'">
   <xsl:text> </xsl:text><a><xsl:attribute name="href">zin.htm?text=doclinlay&amp;document=AdsM1<xsl:if test="contains($document,'AdsM2')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) - 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsM1')">&amp;id=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@base"/>&amp;n=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@n"/>&amp;corresp=<xsl:value-of select="//seg[@n=substring($n,1,3) - 1]/@type"/></xsl:if><xsl:if test="contains($document,'AdsD') or contains($document,'AdsP') or contains($document,'AdsT') or contains($document,'AdsM3')">&amp;n=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@n"/>&amp;id=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@base,2,4) - 1]/@base"/>&amp;corresp=<xsl:value-of select="//seg[@n = //seg[ancestor::text/@id='AdsM1' and substring($id,1,4)=@base]/substring(@n,1,3) - 1]/@type"/></xsl:if>&amp;view=<xsl:value-of select="$view"/></xsl:attribute><img border="0"><xsl:attribute name="src">navi/<xsl:value-of select="@type"/>.jpg</xsl:attribute></img></a>
   </xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <!-- lkj -->
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>
