<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:import href="adsOuter.xsl"/>
<xsl:import href="home.xsl"/>
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

<xsl:param name="text" select="''"/>
<xsl:param name="document" select="''"/>
<xsl:param name="page" select="''"/>
<xsl:param name="app" select="''"/>
<xsl:param name="view" select="''"/>
<xsl:param name="comp1" select="''"/>
<xsl:param name="comp2" select="''"/>
<xsl:param name="export" select="''"/>
<xsl:param name="cursief" select="'OpdD4 OpdD5 OpdD6 OpdP1a OpdP1b OpdP2 OpdD7 '"/>
<xsl:param name="paragraaf" select="'AdsM3 AdsM3a AdsM3b AdsT1 '"/>
<xsl:param name="paragraafinspring" select="'AdsD1 AdsD2 AdsD3 AdsD4 AdsD5 AdsP1 AdsD6 OpdM1 OpdM2 OpdT1 OpdD1 OpdD2 OpdD3 OpdD4 OpdD5 OpdD6 OpdP1a OpdP1b OpdD7 '"/>
<xsl:param name="sigil" select="//front/div/witList/witness/@sigil"/>
<xsl:param name="trans" select="''"/>
<xsl:param name="highlight" select="''"/>

<xsl:template match="teiHeader">
 <meta name="author">
  <xsl:attribute name="content">
      <xsl:value-of select="fileDesc/titleStmt/principal"/>
    </xsl:attribute>
 </meta>
 <meta name="copyright">
  <xsl:attribute name="content">
      <xsl:value-of select="fileDesc/publicationStmt/authority"/>
    </xsl:attribute>
 </meta>
 <meta name="description">
  <xsl:attribute name="content">
      <xsl:value-of select="fileDesc/titleStmt/title"/>
    </xsl:attribute>
 </meta>
</xsl:template>

<xsl:template match="text">
<xsl:param name="documentn" select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/@n"/>
<xsl:param name="pageid" select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@n"/>
<xsl:param name="pagefirst" select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs[position() = 1]/page[@id=$page and position() = 1]"/>
<xsl:param name="pagelast" select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs[position() = last()]/page[@id=$page and position() = last()]"/>
<xsl:choose>
 <!--  
   **    IMAGE STUFF **
   **                -->
 <xsl:when test="$text='docfacs' or $text='docfacstopo' or $text='docfacspop'">
   <!-- Navigation box right -->
  <xsl:if test="$export!='print'">
 <div class="navigationright">
 <table align="center" width="100%">
  <tr>
     <!-- boven -->
   <td align="center" colspan="3"><p class="navigation"><xsl:if test="$pagefirst"><img border="0" src="images/navi/up.jpg"/></xsl:if><xsl:if test="not($pagefirst)"><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid - 1]/@id"/>-<xsl:if test="$text='docfacs'">facsimile</xsl:if><xsl:if test="$text='docfacstopo'">topo</xsl:if><xsl:if test="$text='docfacspop'">popup</xsl:if>.html</xsl:attribute><xsl:if test="not(contains(document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid - 1]/@id,'a'))">p. </xsl:if><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid - 1]/@id"/><br/><img border="0" src="images/navi/up.jpg"/></a></xsl:if></p></td></tr>
     <!-- links -->
   <tr><td align="right" width="49%"><p class="navigation"><xsl:if test="$documentn = '1'"><img border="0" src="images/navi/left.jpg"/></xsl:if><xsl:if test="$documentn != '1'"><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@id"/>-<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@prev"/>-facsimile.html</xsl:attribute><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@short"/><xsl:text> </xsl:text><img border="0" src="images/navi/left.jpg"/></a></xsl:if></p></td>
     <!-- rechts -->
   <td width="1%"/><td align="left" width="49%"><p class="navigation"><xsl:if test="$documentn = '24'"><img border="0" src="images/navi/right.jpg"/></xsl:if><xsl:if test="$documentn != '24'"><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@id"/>-<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@next"/>-facsimile.html</xsl:attribute><img border="0" src="images/navi/right.jpg"/><xsl:text> </xsl:text><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@short"/></a></xsl:if></p></td></tr>
     <!-- onder -->
   <tr><td align="center" colspan="3"><p class="navigation"><xsl:if test="$pagelast"><img border="0" src="images/navi/down.jpg"/></xsl:if><xsl:if test="not($pagelast)"><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid + 1]/@id"/>-<xsl:if test="$text='docfacs'">facsimile</xsl:if><xsl:if test="$text='docfacstopo'">topo</xsl:if><xsl:if test="$text='docfacspop'">popup</xsl:if>.html</xsl:attribute><img src="images/navi/down.jpg" border="0"/><br/><xsl:if test="not(contains(document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid + 1]/@id,'a'))">p. </xsl:if><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid + 1]/@id"/></a></xsl:if></p></td></tr>
  </table>
 </div>
 </xsl:if>

 <!-- Navigation box left -->
 <xsl:if test="$export!='print'">
 <div class="navigationleft">
 <p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>.html#<xsl:value-of select="$page"/></xsl:attribute>Lineaire transcriptie</a><br/>
 <xsl:if test="$text='docfacstopo'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="$page"/>-facsimile.html</xsl:attribute>Facsimile</a><br/></xsl:if>
 <xsl:if test="$document='AdsM1' and $text='docfacs' or $text='docfacspop'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="$page"/>-topo.html</xsl:attribute>Topografische transcriptie</a><br/></xsl:if>
 <xsl:if test="$document='AdsM1' and $text='docfacs' or $text='docfacstopo'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="$page"/>-popup.html</xsl:attribute>Facsimile + Topografisch</a><br/></xsl:if>
 <!-- STATIC CONVERSION 2026-03-10: removed Flash-based zoom views (docfacszoom, docfacstopozoom)<xsl:if test="$document='AdsM1'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacszoom&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Vergrootglas facsimile</a><br/></xsl:if>
 <xsl:if test="$document='AdsM1'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacstopozoom&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Vergrootglas topografisch</a><br/></xsl:if> -->
 <img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a href="#thumbs">Thumbnails</a></p>
 </div>
 </xsl:if>
 <!-- title -->
 <h1><xsl:if test="starts-with($document,'Ads')">ACHTER DE SCHERMEN</xsl:if><xsl:if test="starts-with($document,'Opd')">Opdracht</xsl:if></h1>
 <h2><xsl:if test="$text='docfacs' or $text='docfacspop'">Facsimile</xsl:if><xsl:if test="$text='docfacstopo'">Topografische transcriptie</xsl:if> van<br/> <xsl:value-of select="$document"/>, <xsl:if test="not(contains(document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid]/@id,'a'))">pagina</xsl:if><xsl:text> </xsl:text><xsl:value-of select="$page"/></h2>
 <!-- image -->
  <center><img><xsl:attribute name="src">images/<xsl:value-of select="$document"/>/<xsl:value-of select="$document"/>-<xsl:value-of select="$page"/><xsl:if test="$text='docfacstopo'">topo</xsl:if>.jpg</xsl:attribute><xsl:if test="$export='print'"><xsl:attribute name="width">550</xsl:attribute></xsl:if></img></center>
  <!-- thumbs -->
  <xsl:if test="$export!='print'"><a name="thumbs"><table align="left" width="100%">
<xsl:for-each select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs">
<tr>
<xsl:for-each select="page">
<td><p><center><a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="$document"/>-<xsl:value-of select="@id"/>-<xsl:if test="$text='docfacs'">facsimile</xsl:if><xsl:if test="$text='docfacstopo'">topo</xsl:if><xsl:if test="$text='docfacspop'">popup</xsl:if>.html</xsl:attribute><img border="0" width="100"><xsl:attribute name="src">images/<xsl:value-of select="$document"/>/thumbs/<xsl:value-of select="$document"/>-<xsl:value-of select="@id"/>.jpg</xsl:attribute></img><br/><xsl:value-of select="@id"/></a></center></p></td>
</xsl:for-each></tr>
</xsl:for-each></table></a></xsl:if>
 <!-- draggable image -->
 <xsl:if test="$text='docfacspop'"> <div class="layer" id="reldiv" style="position:absolute;top:400px;right:250px;"><center><table width="700" style="margin-bottom:5px;" cellpadding="0" cellspacing="0"><tr><td width="50%"><a class="layer" href="javascript:myObj.hide();">sluit dit venster</a></td><td width="50%">sleep dit venster bij deze grijze strook</td></tr></table></center><iframe border="0" scrolling="auto" align="center" frameborder="0" width="695" height="315"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="src"><xsl:value-of select="$document"/>-<xsl:value-of select="$page"/>-iframe.html</xsl:attribute></iframe></div></xsl:if>


 </xsl:when>
 <!-- STATIC CONVERSION 2026-03-10: the whole ZOOM section is now dead code since the links to zoom pages have been removed (because they used Flash) -->
 <!--  
   **    ZOOM STUFF **
   **               -->
  <xsl:when test="$text='docfacszoom' or $text='docfacstopozoom'">
   <!-- Navigation box right -->
 <xsl:if test="$export!='print'">
 <div class="navigationright">
 <table align="center" width="100%">
  <tr>
     <!-- boven -->
   <td align="center" colspan="3"><p class="navigation"><xsl:if test="$pagefirst"><img border="0" src="images/navi/up.jpg"/></xsl:if><xsl:if test="not($pagefirst)"><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=<xsl:if test="$text='docfacspop'">docfacs</xsl:if><xsl:if test="$text!='docfacspop'"><xsl:value-of select="$text"/></xsl:if>&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid - 1]/@id"/></xsl:attribute>p. <xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid - 1]/@id"/><br/><img border="0" src="images/navi/up.jpg"/></a></xsl:if></p></td></tr>
     <!-- links -->
   <tr><td align="right" width="49%"><p class="navigation"><xsl:if test="$documentn = '1'"><img border="0" src="images/navi/left.jpg"/></xsl:if><xsl:if test="$documentn != '1'"><a><xsl:attribute name="href"><xsl:if test="starts-with(document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@id,'Ads')">Ads.htm</xsl:if><xsl:if test="starts-with(document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@id,'Opd')">Opd.htm</xsl:if>?text=docfacs&amp;document=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@id"/>&amp;page=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@prev"/></xsl:attribute><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn - 1]/@short"/><xsl:text> </xsl:text><img border="0" src="images/navi/left.jpg"/></a></xsl:if></p></td>
     <!-- rechts -->
   <td width="1%"/><td align="left" width="49%"><p class="navigation"><xsl:if test="$documentn = '24'"><img border="0" src="images/navi/right.jpg"/></xsl:if><xsl:if test="$documentn != '24'"><a><xsl:attribute name="href"><xsl:if test="starts-with(document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@id,'Ads')">Ads.htm</xsl:if><xsl:if test="starts-with(document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@id,'Opd')">Opd.htm</xsl:if>?text=docfacs&amp;document=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@id"/>&amp;page=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@id=$page]/@next"/></xsl:attribute><img border="0" src="images/navi/right.jpg"/><xsl:text> </xsl:text><xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@n=$documentn + 1]/@short"/></a></xsl:if></p></td></tr>
     <!-- onder -->
   <tr><td align="center" colspan="3"><p class="navigation"><xsl:if test="$pagelast"><img border="0" src="images/navi/down.jpg"/></xsl:if><xsl:if test="not($pagelast)"><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=<xsl:if test="$text='docfacspop'">docfacs</xsl:if><xsl:if test="$text!='docfacspop'"><xsl:value-of select="$text"/></xsl:if>&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid + 1]/@id"/></xsl:attribute><img src="images/navi/down.jpg" border="0"/><br/>p. <xsl:value-of select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs/page[@n=$pageid + 1]/@id"/></a></xsl:if></p></td></tr>
  </table>
 </div>
 </xsl:if>

 <!-- Zoom Navigation box left -->
 <xsl:if test="$export!='print'">
 <div class="navigationleft">
 <p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=doclin&amp;document=<xsl:value-of select="$document"/>#<xsl:value-of select="$page"/></xsl:attribute>Lineaire transcriptie</a><br/>
 <img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacs&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Facsimile</a><br/>
 <img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacstopo&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Topografische transcriptie</a><br/>
 <xsl:if test="$document='AdsM1'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacspop&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Facsimile + Topografisch</a><br/></xsl:if>
 <xsl:if test="$text!='docfacszoom'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacszoom&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Vergrootglas facsimile</a><br/></xsl:if>
 <xsl:if test="$text!='docfacstopozoom'"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=docfacstopozoom&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/></xsl:attribute>Vergrootglas topografisch</a><br/></xsl:if>
 <img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a href="#thumbs">Thumbnails</a></p>
 </div>
 </xsl:if>
 <!-- zoom title -->
 <h1><xsl:if test="$text='docfacszoom'">Zoom Facsimile</xsl:if><xsl:if test="$text='docfacstopozoom'">Zoom Topografische transcriptie</xsl:if> van<br/> <xsl:value-of select="$document"/>, pagina <xsl:value-of select="$page"/></h1>
 <!-- zoom image -->
 <center><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,79,0" id="try" height="1000" width="790">
  <param name="movie"><xsl:attribute name="value"><xsl:value-of select="$document"/>/<xsl:value-of select="$document"/>-<xsl:value-of select="$page"/><xsl:if test="$text='docfacstopozoom'">topo</xsl:if>.swf</xsl:attribute></param>
  <param name="bgcolor" value="#000000"/>
  <param name="quality" value="high"/>
  <param name="allowscriptaccess" value="samedomain"/>
     <embed height="1000" width="790" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" name="try" bgcolor="white" quality="high" swLiveConnect="true" allowScriptAccess="samedomain"><xsl:attribute name="src">images/<xsl:value-of select="$document"/>/<xsl:value-of select="$document"/>-<xsl:value-of select="$page"/><xsl:if test="$text='docfacstopozoom'">topo</xsl:if>.swf</xsl:attribute></embed>
  </object></center>
 <!-- thumbs -->
  <xsl:if test="$export!='print'"><a name="thumbs"><table align="left" width="100%">
<xsl:for-each select="document('../../ads/xml/toc.xml')//toc/document[@id=$document]/thumbs">
<tr>
<xsl:for-each select="page">
<td><p><center><a><xsl:attribute name="href"><xsl:value-of select="substring($document,1,3)"/>.htm?text=<xsl:value-of select="$text"/>&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="@id"/></xsl:attribute><img border="0" width="100"><xsl:attribute name="src">images/<xsl:value-of select="$document"/>/thumbs/<xsl:value-of select="$document"/>-<xsl:value-of select="@id"/>.jpg</xsl:attribute></img><br/><xsl:value-of select="@id"/></a></center></p></td>
</xsl:for-each></tr>
</xsl:for-each></table></a></xsl:if>

  </xsl:when>
  <!-- apparaat -->
  <xsl:when test="$text='doclinapp'">
  <xsl:variable name="adsopd"><xsl:value-of select="substring($document,1,3)"/>Z</xsl:variable>
  <h1>Apparaat</h1><br/><br/>
  <b>Synopsis:</b>
  <xsl:if test="$comp1=''">
  <xsl:for-each select="//app[@n=$app][1]/rdg">
  <p><b><span style="font-family:Arial Narrow;"><xsl:if test="contains(@wit,'Z')"><xsl:value-of select="substring-before(@wit,$adsopd)"/></xsl:if><xsl:if test="not(contains(@wit,'Z'))"><xsl:value-of select="@wit"/></xsl:if></span></b><br/>
  <xsl:if test="substring(@wit,1,6) != ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,6)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="substring(@wit,1,6) = ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  </p>
  </xsl:for-each>
  </xsl:if>
  
  <xsl:if test="$comp1!=''">
  <xsl:for-each select="front//witness[@n = $comp1] | front//witness[@n = $comp2] | front//witness[contains(@n,concat(substring($comp2,1,3),substring($comp2,5,2)))] | front//witness[contains(@n,concat(substring($comp1,1,3),substring($comp1,5,2)))]">
  <xsl:if test="//app[@n=$app]/rdg[1][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[2][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[3][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[4][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[5][contains(@wit,current()/@n)]">
  <p><b><span style="font-family:Arial Narrow;"><xsl:value-of select="@n"/></span></b>:<br/>
    <xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
    <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></xsl:if>
  </p>
  </xsl:if>
  </xsl:for-each>
  </xsl:if>

  ________<br/><br/>
  <b>Versies:</b>
  <xsl:for-each select="front//witness">
  <xsl:if test="//app[@n=$app]/rdg[1][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[2][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[3][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[4][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[5][not(contains(@wit,current()/@n))]"></xsl:if>
  <xsl:if test="//app[@n=$app]/rdg[1][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[2][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[3][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[4][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[5][contains(@wit,current()/@n)]">
  <p><b><xsl:if test="ancestor::TEI.2//app[@n=$app]/rdg[contains(@wit,@sigil)]"><a style="font-family:Arial Narrow;"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:if test="substring($comp1,4,1) ='Z' or substring($comp2,4,1) = 'Z'"><xsl:if test="contains(@n,concat('Ads',substring($comp2,5,2))) or contains(@n,concat('Ads',substring($comp1,5,2))) "><xsl:attribute name="style">font-family:Arial Narrow;color:green;</xsl:attribute></xsl:if></xsl:if><xsl:if test="$comp1 = @n or $comp2 = @n"><xsl:attribute name="style">font-family:Arial Narrow;color:green;</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="@n"/>-varianten.html#<xsl:value-of select="$id"/></xsl:attribute><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</a></xsl:if></b>:<br/>
    <xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
    <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></xsl:if>
    <!-- toon schrijfproces -->
    <xsl:if test="@n='AdsM1'">
    <xsl:if test="$id!=''"><br/>[<a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping -->zin-AdsM1-<xsl:value-of select="//text[@id='AdsM1']//seg[@base=$id]/@n"/>-<xsl:value-of select="$id"/>-<xsl:value-of select="//text[@id='AdsM1']//seg[@base=$id]//@type"/>.html</xsl:attribute>toon schrijfproces</a>]</xsl:if>
    </xsl:if>
  </p>
  </xsl:if>
  </xsl:for-each>
  </xsl:when>
 <xsl:otherwise>
  <xsl:apply-templates/>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="front">
 <!-- <xsl:apply-templates/>-->
</xsl:template>

<xsl:template match="div">
<xsl:choose>
  <xsl:when test="@type='disclaimer'">
  <center><div class="disclaimer"><xsl:apply-templates/></div></center>
 </xsl:when>
 <xsl:when test="@id and @type!='disclaimer' or not(@type)">
  <a><xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute></a><xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
   <xsl:apply-templates/>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="quote">
  <blockquote><xsl:apply-templates/></blockquote>
</xsl:template>

<xsl:template match="p">
<xsl:choose>
 <xsl:when test="contains($cursief, $document)">
 <p><i>
  <xsl:apply-templates/>
 </i></p>
 </xsl:when>
 <xsl:when test="contains($paragraaf, $document)">
 <p style="margin:0px 0px 0px 0px;">
   <xsl:apply-templates/>
 </p>
 </xsl:when>
 <xsl:when test="contains($paragraafinspring, $document)">
 <p style="margin:0px 0px 0px 0px;text-indent:20px;">
   <xsl:apply-templates/>
 </p>
 </xsl:when>
 <xsl:when test="$document='overlevering' or $document='gebruiksaanwijzing' or $document='inleiding'">
  <p><xsl:attribute name="style">margin:<xsl:if test="$document='inleiding'">1</xsl:if>0px 10px 0px <xsl:if test="@rend!='level2' and @rend!='level1'">10px</xsl:if><xsl:if test="@rend='level2'">30px</xsl:if><xsl:if test="@rend='level1'">20px</xsl:if>;text-align:justify;<xsl:if test="parent::div[@type!='quote']"><xsl:if test="parent::div[head!='Fotoverantwoording']">text-indent:20px;</xsl:if></xsl:if></xsl:attribute>
   <xsl:apply-templates/>
 </p>
 </xsl:when>
 <xsl:when test="$document='colofon' and ancestor::div/@type='colofon'">
 <p class="colofon">
   <xsl:apply-templates/>
 </p>
 </xsl:when>
  <xsl:when test="$document='colofon' and ancestor::div/@type='disclaimer'">
 <p class="disclaimer">
   <xsl:apply-templates/>
 </p>
 </xsl:when>
 <xsl:when test="contains(@id,'additionfacingleaf')">
    <xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
 <p>
  <xsl:apply-templates/>
 </p>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="seg">
<xsl:param name="wit"/>
<xsl:choose>
 <xsl:when test="@base='z011' and $document='AdsD1'">
 <xsl:if test="$text='doclinlay'"><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a><xsl:attribute name="name"><xsl:value-of select="@base"/></xsl:attribute></a><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href">zin-<xsl:value-of select="$document"/>-<xsl:value-of select="@n"/>-<xsl:value-of select="@base"/>-<xsl:value-of select="ancestor::TEI.2//text[@id='AdsM1']//seg[@base=current()/@base]/@type"/>.html</xsl:attribute><img src="images/navi/dot.jpg" border="0"/></a> <xsl:text> </xsl:text></xsl:if>
  <xsl:apply-templates/><br/><br/><br/><br/><br/>
 </xsl:when>
  <xsl:when test="@base='z011' and $document='AdsD2'">
  <xsl:if test="$text='doclinlay'"><a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a><xsl:attribute name="name"><xsl:value-of select="@base"/></xsl:attribute></a><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href">zin-<xsl:value-of select="$document"/>-<xsl:value-of select="@n"/>-<xsl:value-of select="@base"/>-<xsl:value-of select="ancestor::TEI.2//text[@id='AdsM1']//seg[@base=current()/@base]/@type"/>.html</xsl:attribute><img src="images/navi/dot.jpg" border="0"/></a> <xsl:text> </xsl:text></xsl:if><xsl:apply-templates/><br/><br/><br/><br/>
 </xsl:when>
  <xsl:when test="@base='z102' and $document='AdsM1' and $trans='yes'">
  <xsl:apply-templates/><br/><br/>
 </xsl:when>
   <xsl:when test="@base='z102' and $document='AdsM1' and $view='bovenlaag'">
  <xsl:apply-templates/><br/><br/>
 </xsl:when>
 <xsl:when test="$text='doclinlay' and $document='AdsM1'">
  <a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a><xsl:attribute name="name"><xsl:value-of select="@base"/></xsl:attribute></a><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href">zin-<xsl:value-of select="$document"/>-<xsl:value-of select="@n"/>-<xsl:value-of select="@base"/>-<xsl:value-of select="@type"/>.html</xsl:attribute><img src="images/navi/dot.jpg" border="0"/></a> <xsl:text> </xsl:text><xsl:apply-templates/>
 </xsl:when>
 <xsl:when test="$text='doclinlay' and substring($document,1,3) = 'Ads' and $document!='AdsM1'">
  <a><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute></a><a><xsl:attribute name="name"><xsl:value-of select="@base"/></xsl:attribute></a><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href">zin-<xsl:value-of select="$document"/>-<xsl:value-of select="@n"/>-<xsl:value-of select="@base"/>-<xsl:value-of select="ancestor::TEI.2//text[@id='AdsM1']//seg[@base=current()/@base]/@type"/>.html</xsl:attribute><img src="images/navi/dot.jpg" border="0"/></a> <xsl:text> </xsl:text><xsl:apply-templates/>
 </xsl:when>
 <xsl:when test="$text='doclinapp' and descendant::app[@n=$app]">
   <xsl:if test="contains($cursief,$wit)"><i><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></i></xsl:if>
   <xsl:if test="not(contains($cursief,$wit))"><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></xsl:if>
 </xsl:when>
 <xsl:when test="contains($text,'doclin')">
     <a><xsl:attribute name="name"><xsl:value-of select="@base"/></xsl:attribute></a><xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
   <!--<xsl:apply-templates/>-->
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="head">
<xsl:param name="wit"/>
 <div><xsl:attribute name="class"><xsl:value-of select="ancestor::div/@type"/></xsl:attribute>
  <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </div>
</xsl:template>

<xsl:template match="emph">
<xsl:param name="wit"/>
<xsl:choose>
 <xsl:when test="@rend='signed'">
 <div class="signed"><!--<xsl:attribute name="class"><xsl:value-of select="ancestor::div/@type"/></xsl:attribute>-->
  <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </div>
 </xsl:when>
 <xsl:otherwise>
  <span class="emph">
    <xsl:apply-templates/>
  </span>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="app">
<xsl:param name="wit"/>
<xsl:param name="rdgs" select="count(rdg)"/>
<xsl:choose>
 <xsl:when test="$text='doclinapp' and @n=$app">
   <xsl:for-each select="current()"><span class="rdg"><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></span><xsl:if test="following::seg//app[@n=$app]"><xsl:text> </xsl:text></xsl:if></xsl:for-each>
 </xsl:when>
  <xsl:when test="$text='doclinapp' and @n!=$app">
   <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </xsl:when>
 <xsl:when test="$trans!='yes'">
  <xsl:apply-templates/>
 </xsl:when>
 <!-- kies 2 teksten -->
 <xsl:when test="substring($document,4,1) != 'Z'and $comp1!='' and not(count(rdg[contains(@wit,substring($document,1,5))])= 2)">
 <xsl:for-each select="rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]">
 <xsl:if test="ancestor::rdg[contains(@wit,$comp1) and contains(@wit,$comp2)]">
   <span class="rdgdoclin"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a></span>
 </xsl:if>
 <xsl:if test="ancestor::rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]">
   <em class="rdgdoclin2"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></em>
 </xsl:if>
 <xsl:if test="not(ancestor::rdg)">   
   <span class="rdgdoclin"><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a>
   <xsl:if test="descendant::app/rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))] and $export!= 'print'"><div><xsl:attribute name="class">variant<xsl:if test="descendant::app/@n='d0e529' or descendant::app/@n='d0e409' or descendant::app/@n='eee5412'">2</xsl:if></xsl:attribute><ul><xsl:for-each select="descendant::app/rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]"><li class="variant"><a class="variant"><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if><xsl:if test="current()=' '">|</xsl:if></a></li></xsl:for-each></ul></div></xsl:if></span>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="rdg[contains(@wit,$comp1) and contains(@wit,$comp2)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </xsl:for-each>
  <xsl:for-each select="rdg[contains(@wit,concat(substring($document,1,5), 'a')) and not(contains(@wit,$comp1))]">
  <!--<xsl:apply-templates/>-->
  <xsl:if test="current()[contains(@wit,concat(substring($document,1,5), 'a')) and contains(@wit,$comp2)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="concat(substring($document,1,5), 'a')"/></xsl:apply-templates>
  </xsl:if>
   <xsl:if test="current()[contains(@wit,concat(substring($document,1,5), 'a')) and not(contains(@wit,$comp2))]">
   <span class="rdgdoclin"><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$comp1"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a></span>
  </xsl:if>
 </xsl:for-each>
 </xsl:when>
 <xsl:when test="substring($document,4,1) = 'Z'and $comp1!='' and $text='doclin' and $trans='yes' and rdg[contains(@wit,concat($document, ' '))]">
<xsl:for-each select="rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]">
 <xsl:if test="ancestor::rdg[contains(@wit,$comp1) and contains(@wit,$comp2)]">
   <span class="rdgdoclin"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a></span>
 </xsl:if>
 <xsl:if test="ancestor::rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]">
   <em class="rdgdoclin2"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></em>
 </xsl:if>
 <xsl:if test="not(ancestor::rdg)">   
   <span class="rdgdoclin"><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a>
   <xsl:if test="descendant::app/rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))] and $export!= 'print'"><div><xsl:attribute name="class">variant<xsl:if test="descendant::app/@n='d0e529' or descendant::app/@n='d0e409' or descendant::app/@n='eee5412'">2</xsl:if></xsl:attribute><ul><xsl:for-each select="descendant::app/rdg[contains(@wit,$comp1) and not(contains(@wit,$comp2))]"><li class="variant"><a class="variant"><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if><xsl:if test="current()=' '">|</xsl:if></a></li></xsl:for-each></ul></div></xsl:if></span>
 </xsl:if>
 </xsl:for-each>
 <xsl:for-each select="rdg[contains(@wit,$comp1) and contains(@wit,$comp2)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </xsl:for-each>
  <xsl:for-each select="rdg[contains(@wit,concat(substring($document,1,5), 'a')) and not(contains(@wit,$comp1))]">
  <!--<xsl:apply-templates/>-->
  <xsl:if test="current()[contains(@wit,concat(substring($document,1,5), 'a')) and contains(@wit,$comp2)]">
   <xsl:apply-templates><xsl:with-param name="wit" select="concat(substring($document,1,5), 'a')"/></xsl:apply-templates>
  </xsl:if>
   <xsl:if test="current()[contains(@wit,concat(substring($document,1,5), 'a')) and not(contains(@wit,$comp2))]">
   <span class="rdgdoclin"><a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$comp1"/></xsl:apply-templates><xsl:if test="current()=''">|</xsl:if></a></span>
  </xsl:if>
 </xsl:for-each>
 </xsl:when>
 <!-- einde kies 2 teksten -->
 <xsl:when test="$text='doclin' and $trans='yes' and rdg[contains(@wit,concat($document, ' '))]">
 <xsl:if test="not(parent::rdg)">
   <span class="rdgdoclin"><xsl:apply-templates select="rdg[contains(@wit,concat($document, ' '))]"/></span>
  </xsl:if>
    <xsl:if test="parent::rdg">
     <xsl:if test="parent::rdg[not(contains(@wit,concat($document, ' ')))]">
   <span class="rdgdoclin"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><xsl:apply-templates select="rdg[contains(@wit,concat($document, ' '))]"/></span>
     </xsl:if>
   <xsl:if test="parent::rdg[contains(@wit,concat($document, ' '))]">
   <em class="rdgdoclin2"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><xsl:apply-templates select="rdg[contains(@wit,concat($document, ' '))]"/></em>
     </xsl:if>
  </xsl:if>
 </xsl:when>
 <xsl:when test="$text='doclin' and $trans='yes' and count(rdg[contains(@wit,substring($document,1,5))])= 2">
  <xsl:apply-templates select="rdg[contains(@wit,concat(substring($document,1,5), 'a'))]"/>
 </xsl:when>
 <xsl:when test="$text='doclin' and $trans='yes' and rdg[not(contains(@wit,concat($document, ' '))) and contains(@wit,substring($document,1,5))]">
  <xsl:apply-templates select="rdg[contains(@wit,concat(substring($document,1,5), 'a'))]"/>
 </xsl:when>
 <xsl:otherwise>
  <xsl:if test="not(parent::rdg)">
   <span class="rdgdoclin"><xsl:apply-templates/></span>
  </xsl:if>
    <xsl:if test="parent::rdg">
   <em class="rdgdoclin2"><xsl:attribute name="style"><xsl:if test="not(contains($cursief,$document))">font-style:normal;</xsl:if></xsl:attribute><xsl:apply-templates/></em>
  </xsl:if>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="rdg">
<xsl:param name="wit"/>
<xsl:choose>
 <xsl:when test="$text='doclinapp' and parent::app[@n=$app]">
  <xsl:if test="contains(@wit,$wit)">
  <xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
  </xsl:if>
 </xsl:when>
 <xsl:when test="$text='doclinapp' and not(parent::app[@n=$app])">
    <xsl:if test="contains(@wit,$wit)"><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></xsl:if>
    <xsl:if test="not(contains(@wit,$wit)) and contains(@wit,substring($wit,1,5)) and not(preceding-sibling::rdg[contains(@wit,$wit)]) and not(following-sibling::rdg[contains(@wit,$wit)])"> <xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
  </xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <xsl:if test="contains(@wit,concat($document, ' ')) and $trans='yes'">
 <xsl:if test="not(descendant::app) and ancestor::rdg">
 <xsl:if test="ancestor::rdg[not(contains(@wit,concat($document, ' ')))]">
 <a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></a>
 </xsl:if>
 <xsl:if test="ancestor::rdg[contains(@wit,concat($document, ' '))] and $comp1!=''">
 <a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates/></a>
 </xsl:if>
 <xsl:if test="ancestor::rdg[contains(@wit,concat($document, ' '))] and $comp1=''">
 <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
 </xsl:if>
 </xsl:if>
 <xsl:if test="not(descendant::app) and not(ancestor::rdg)">
  <a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates/></a>

 </xsl:if>
 <xsl:if test="descendant::app">
 <a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="parent::app/@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:if test="current()=''">|</xsl:if><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></a><xsl:text> </xsl:text>
 <xsl:if test="$export!= 'print'"><div><xsl:attribute name="class">variant<xsl:if test="descendant::app/@n='d0e529' or descendant::app/@n='d0e409' or descendant::app/@n='eee5412'">2</xsl:if></xsl:attribute><ul><xsl:for-each select="descendant::app"><li class="variant"><a class="variant"><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:choose>
  <xsl:when test="$comp1!=''">apparaat_<xsl:value-of select="$comp1"/>_<xsl:value-of select="$comp2"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="@n"/>.html</xsl:when>
  <xsl:otherwise>apparaat-<xsl:value-of select="$document"/>-<xsl:value-of select="ancestor::seg/@base"/>-<xsl:value-of select="@n"/>.html</xsl:otherwise>
</xsl:choose></xsl:attribute><xsl:value-of select="rdg[contains(@wit,$document)]"/><xsl:if test="rdg[contains(@wit,$document)]=' '">|</xsl:if><xsl:if test="rdg[contains(@wit,$document)]=''">|</xsl:if></a></li></xsl:for-each></ul></div><xsl:text> </xsl:text></xsl:if>
 </xsl:if>
 </xsl:if>
 <xsl:if test="$trans!='yes' and contains(@wit,concat($document, ' '))">
  <xsl:apply-templates/>
 </xsl:if>
  <xsl:if test="$text='doclin' and $trans='yes' and not(contains(@wit,concat($document, ' '))) and contains(@wit,substring($document,1,5))">
  <xsl:apply-templates/>
 </xsl:if>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="del[not(@corresp)]">
<xsl:choose>
 <xsl:when test="$view='bovenlaag'">
   <!-- <xsl:value-of select="."/> -->
 </xsl:when>
 <xsl:otherwise>
   <strike>
    <xsl:apply-templates/>
   </strike>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="add/del">
<xsl:choose>
 <xsl:when test="$view='bovenlaag'">
   <!-- <xsl:value-of select="."/> -->
 </xsl:when>
 <xsl:otherwise>
   <strike>
    <xsl:apply-templates/>
   </strike>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="add/add">
<xsl:choose>
 <xsl:when test="$view='bovenlaag'">
    <xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
   <font color="red" class="red">
    <xsl:apply-templates/>
   </font>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="add/add/add">
<xsl:choose>
 <xsl:when test="$view='bovenlaag'">
    <xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
    <font color="green" class="green">
      <xsl:apply-templates/>
    </font>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="add">
<xsl:choose>
 <xsl:when test="$view='bovenlaag'">
    <xsl:apply-templates/>
 </xsl:when>
 <xsl:otherwise>
   <font color="blue" class="blue">
    <xsl:apply-templates/>
   </font>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="del[contains(@n,'zin')]">
<!--    <xsl:apply-templates/> -->
</xsl:template>

<xsl:template match="add[contains(@n,'zin')]">
<!--    <xsl:apply-templates/> -->
</xsl:template>

<xsl:template match="lb">
<xsl:choose>
<xsl:when test="@ed">
<xsl:if test="contains(@ed,substring($document,1,5)) and contains($paragraaf, $document)">
 <br/>
</xsl:if>
<xsl:if test="contains(@ed,substring($document,1,5)) and contains($paragraafinspring, $document)">
 <br/><table width="20px"></table>
</xsl:if>
<xsl:if test="contains($document,'AdsM2') and $trans='yes' and contains(@ed,'M2')">
<br/>
</xsl:if>
</xsl:when>
<xsl:otherwise>
 <br/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="pb">
<xsl:choose>
 <xsl:when test="not(contains($text,'doclin')) or $text='doclinapp'">
  <!-- <xsl:value-of select="."/"> -->
 </xsl:when>
 <xsl:when test="parent::rdg and $trans='yes' and contains(@ed,substring($document,1,6))">
 <xsl:if test="$export!='print'">
  <a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:if test="substring($document,4,1) !='Z'"><xsl:value-of select="substring($document,1,5)"/></xsl:if><xsl:if test="substring($document,4,1) ='Z'"><xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/></xsl:if>-<xsl:value-of select="@n"/>-facsimile.html</xsl:attribute><img border="0" style="float:right;margin: 0px 10px 0px 10px;
border: 1px solid #666; padding: 2px;"><xsl:if test="substring($document,4,1) !='Z'"><xsl:attribute name="src">images/<xsl:value-of select="substring($document,1,5)"/>/thumbs/<xsl:value-of select="substring($document,1,5)"/>-<xsl:value-of select="@n"/>.jpg</xsl:attribute></xsl:if><xsl:if test="substring($document,4,1) ='Z'"><xsl:attribute name="src">images/<xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/>/thumbs/<xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/>-<xsl:value-of select="@n"/>.jpg</xsl:attribute></xsl:if></img></a></xsl:if>
 <font color="#660011">[<xsl:if test="@rend"><xsl:value-of select="substring(@rend,2)"/></xsl:if><xsl:if test="not(@rend)"><xsl:value-of select="@n"/></xsl:if>]</font>
 </xsl:when>
 <xsl:otherwise>

 <xsl:if test="contains(@ed,substring($document,1,6))">
 <xsl:if test="$export!='print'">
  <a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:if test="substring($document,4,1) !='Z'"><xsl:value-of select="substring($document,1,5)"/></xsl:if><xsl:if test="substring($document,4,1) ='Z'"><xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/></xsl:if>-<xsl:value-of select="@n"/>-facsimile.html</xsl:attribute><img border="0" style="float:right;margin: 0px 10px 0px 10px;
border: 1px solid #666; padding: 2px;"><xsl:if test="substring($document,4,1) !='Z'"><xsl:attribute name="src">images/<xsl:value-of select="substring($document,1,5)"/>/thumbs/<xsl:value-of select="substring($document,1,5)"/>-<xsl:value-of select="@n"/>.jpg</xsl:attribute></xsl:if><xsl:if test="substring($document,4,1) ='Z'"><xsl:attribute name="src">images/<xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/>/thumbs/<xsl:value-of select="concat(substring($document,1,3),substring($document,5,2))"/>-<xsl:value-of select="@n"/>.jpg</xsl:attribute></xsl:if></img></a></xsl:if>
 <font color="#660011"><a class="pb"><xsl:attribute name="name"><xsl:value-of select="@n"/></xsl:attribute>[</a><a href="javascript:void(0);" class="pb"><xsl:attribute name="onclick"><xsl:if test="$export='print'">return false</xsl:if><xsl:if test="$export!='print'"><!-- STATIC CONVERSION 2026-03-10: new url mapping -->return overlib('&lt;ul>&lt;li>&lt;a href=\'<xsl:choose><xsl:when test="$trans!='yes'"><xsl:value-of select="$document"/>-varianten.html</xsl:when><xsl:otherwise><xsl:value-of select="$document"/>.html</xsl:otherwise></xsl:choose>#<xsl:value-of select="@n"/>\'>Varianten: <xsl:if test="$trans!='yes'">aan</xsl:if><xsl:if test="$trans='yes'">uit</xsl:if>&lt;/a>&lt;/li><xsl:if test="contains($document,'Ads')">&lt;li>&lt;a href=\'<xsl:choose><xsl:when test="$text!='doclinlay'"><xsl:value-of select="$document"/>-zinsvarianten.html</xsl:when><xsl:otherwise><xsl:value-of select="$document"/>.html</xsl:otherwise></xsl:choose>#<xsl:value-of select="@n"/>\'>Toon schrijfproces per zin: <xsl:if test="$text!='doclinlay'">aan</xsl:if><xsl:if test="$text='doclinlay'">uit</xsl:if>&lt;/a>&lt;/li></xsl:if>&lt;li>&lt;a href="#top">Naar boven&lt;/a>&lt;/li>&lt;/ul>', STICKY, CAPTION, 'Quicklink', CENTER);</xsl:if></xsl:attribute><xsl:attribute name="onmouseout">nd();</xsl:attribute><xsl:if test="@rend"><xsl:value-of select="substring(@rend,2)"/></xsl:if><xsl:if test="not(@rend)"><xsl:value-of select="@n"/></xsl:if></a>]</font>
 </xsl:if>
 </xsl:otherwise>
</xsl:choose>

</xsl:template>

<xsl:template match="unclear">[<xsl:apply-templates/>]</xsl:template>

<xsl:template match="note">
<xsl:if test="$export!='print'">
<xsl:text>  </xsl:text><a href="javascript:void(0);" style="text-decoration:none;"><xsl:attribute name="onclick">return overlib('<xsl:value-of select="."/>', STICKY, CAPTION, 'Noot', CENTER);</xsl:attribute><xsl:attribute name="onmouseout">nd();</xsl:attribute><img src="images/note.gif" border="0"/></a><xsl:text>  </xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="sic">
<xsl:apply-templates/><xsl:if test="$export!='print'"><xsl:text>  </xsl:text><a href="javascript:void(0);" style="text-decoration:none;"><xsl:attribute name="onclick">return overlib('lees: <xsl:value-of select="@corr"/>', STICKY, CAPTION, 'Noot', CENTER);</xsl:attribute><xsl:attribute name="onmouseout">nd();</xsl:attribute><img src="images/note.gif" border="0"/></a><xsl:text>  </xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="toc">
    <!--
    <xsl:value-of select="."/>
    -->
</xsl:template>

<xsl:template match="figure">
<xsl:if test="not(@rend)"><img><xsl:attribute name="src">images/<xsl:value-of select="@id"/></xsl:attribute></img></xsl:if>
<xsl:if test="@rend">
<div><xsl:attribute name="style">float:<xsl:if test="substring(@id,2) = '1' or substring(@id,2) = '3' or substring(@id,2) = '5'">left</xsl:if><xsl:if test="substring(@id,2) = '2' or substring(@id,2) = '4' or substring(@id,2) = '6'">right</xsl:if>; width:<xsl:value-of select="@rend + 15"/>px;margin-top:5px;</xsl:attribute><!-- STATIC CONVERSION 2026-03-10: Inleiding: removed link to printable version of illustrative photographs <a target="_blank"><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href">javascript:MM_openBrWindow('Ads.htm?text=docfacs&amp;document=inleiding&amp;page=<xsl:value-of select="substring-after(@id,'inleiding/')"/>groot&amp;export=print','','width=825,height=538,resizable=yes,scrollbars=yes')</xsl:attribute>--><img border="0"><xsl:attribute name="src">images/inleiding/<xsl:value-of select="@id"/>.jpg</xsl:attribute><xsl:attribute name="style">border:1px solid #660011;margin-right:5px;margin-left:5px;</xsl:attribute></img><!--</a>--><br/><center><span style="font-size:10px;width:50px;"><xsl:value-of select="."/></span></center></div>
</xsl:if>
</xsl:template>

<xsl:template match="hi">
<xsl:param name="wit"/>
 <xsl:choose>
  <xsl:when test="@rend='i'">
   <i>
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </i>
  </xsl:when>
  <xsl:when test="@rend='onderstreept'">
   <u>
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </u>
  </xsl:when>
  <xsl:when test="@rend='underline'">
   <u>
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </u>
  </xsl:when>
  <xsl:when test="@rend='dotted line'">
   <strike style="">
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </strike>
  </xsl:when>
  <xsl:when test="@rend='red crayon'">
   <span style="background-color:#FF3F3F;">
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </span>
  </xsl:when>
  <xsl:when test="@rend='background'">
   <span style="background-color:#AEAEAE;">
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </span>
  </xsl:when>
  <xsl:when test="@rend='background2'">
   <span style="background-color:#717070;">
    <xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates>
   </span>
  </xsl:when>
  <xsl:when test="@rend='b'">
  <b><xsl:apply-templates/></b>
  </xsl:when>
  <xsl:otherwise>
    <!--
    <xsl:value-of select="."/>
    -->
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="eg">
<xsl:choose>
<xsl:when test="@rend='tag'">
  <span class="eg">
    <xsl:apply-templates/>
  </span>
</xsl:when>
<xsl:when test="@rend='attribute'">
  <i><span class="eg">
    <xsl:apply-templates/>
  </span></i>
</xsl:when>
<xsl:otherwise>
  <span class="eg">
    <xsl:apply-templates/>
  </span>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="table">
  <table width="100%">
    <xsl:attribute name="border">
      <xsl:choose>
        <xsl:when test="contains(@rend, 'border(1)')">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:if test="@id='logos'"><xsl:attribute name="width">680</xsl:attribute><xsl:attribute name="align">center</xsl:attribute><xsl:attribute name="style">background-color:white;border:1px solid #660011;</xsl:attribute></xsl:if>
    <xsl:apply-templates/>
  </table>
</xsl:template>

<xsl:template match="row">
  <tr valign="top">
    <xsl:apply-templates/>
  </tr>
</xsl:template>

<xsl:template match="cell">
  <td align="left" valign="top">
    <xsl:if test="@cols"><xsl:attribute name="colspan"><xsl:value-of select="@cols"/></xsl:attribute></xsl:if>
    <xsl:apply-templates/>
  </td>
</xsl:template>

<xsl:template match="xref">
  
    <a><xsl:attribute name="name"><xsl:if test="@type!='extra'"><xsl:value-of select="@id"/></xsl:if><xsl:if test="@type='extra'"><xsl:value-of select="@to"/></xsl:if></xsl:attribute></a>
    
    <a><xsl:if test="$export!='print'"><xsl:attribute name="href"><xsl:if test="@type='email'">mailto:<xsl:value-of select="@to"/></xsl:if><xsl:if test="@type='intra'">#<xsl:value-of select="@to"/></xsl:if><xsl:if test="@type='note'"><xsl:value-of select="@to"/></xsl:if><xsl:if test="@type='text'"><xsl:value-of select="@to"/></xsl:if><xsl:if test="@type='extra'"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="@to"/>.html</xsl:if><xsl:if test="@type='proza'"><xsl:value-of select="@to"/>.html</xsl:if><xsl:if test="@type='url'"><xsl:value-of select="@to"/></xsl:if></xsl:attribute></xsl:if><xsl:if test="@type='url'"><xsl:attribute name="target">_blank</xsl:attribute></xsl:if><xsl:if test="@type='note'"><sup><xsl:apply-templates/></sup></xsl:if><xsl:if test="@type!='note'"><xsl:apply-templates/></xsl:if></a>
  
</xsl:template>

<xsl:template name="highlight">
  <xsl:param name="p_text" select="''"/>
  <xsl:choose>
    <xsl:when test="contains($p_text,$highlight)">
      <xsl:value-of select="substring-before($p_text,$highlight)"/>
      <span style="background-color: #FFFF00">
      <xsl:value-of select="$highlight"/>
      </span>
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="substring-after($p_text,$highlight)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise> 
    <xsl:value-of select="$p_text"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="text()">
  <xsl:choose>
    <xsl:when test="$highlight!='' and contains(.,$highlight)">
      <xsl:call-template name="highlight">
        <xsl:with-param name="p_text" select="."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>
</xsl:stylesheet>