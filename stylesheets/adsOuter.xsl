<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

<xsl:param name="text" select="''"/>
<xsl:param name="trans" select="''"/>
<xsl:param name="comp1" select="''"/>
<xsl:param name="comp2" select="''"/>
<xsl:param name="n" select="''"/>
<xsl:param name="export" select="''"/>
<xsl:param name="id" select="''"/>
<xsl:param name="corresp" select="''"/>
<xsl:param name="overl" select="'overlevering.html#'"/><!-- STATIC CONVERSION 2026-03-10: new url mapping -->
<xsl:param name="toggle"><img src="images/toggle.gif" border="0"/></xsl:param>


<xsl:template match="TEI.2">
 <xsl:if test="$text='iframe'">
 <body><img><xsl:attribute name="src">images/<xsl:value-of select="$document"/>/white/<xsl:value-of select="$document"/>-<xsl:value-of select="$page"/>.jpg</xsl:attribute></img></body>
 </xsl:if>
 <xsl:if test="$text!='iframe'">
 <html>
 <head>
 <title>Achter de Schermen</title>
 <!-- STATIC CONVERSION 2026-03-12: unused javascript
 <script language="JavaScript">
function anyObj(divName) {
	this.IE5=this.NN4=this.NN6=false
	if(document.all)this.IE5=true
	else if(document.layers)this.NN4=true
	else if(document.getElementById)this.NN6=true
	
	if(this.NN4)this.obj=eval("document."+divName)
	if(this.IE5)this.obj=eval("document.all."+divName)
	if(this.NN6)this.obj=eval("document.getElementById(\""+divName+"\")")

	this.show = showDiv
	this.hide = hideDiv
}
function showDiv() {
	if(this.NN4) {this.obj.display="inline"
	     	    // this.obj.style.position="absolute"
		    // this.obj.top="0px"
		    // this.obj.right="10px"
		    }
	else {this.obj.style.display="inline"

	     }
}
function hideDiv() {
	if(this.NN4) this.obj.display="none"
	else this.obj.style.display="none"
}
</script>
<script language="JavaScript">
function initialize() {
myObj = new anyObj("reldiv");
//myObj.hide();
}
onload=initialize
</script>-->
<script language="JavaScript">

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
</script>

  <!--<xsl:apply-templates select="teiHeader"/>-->

 <link rel="stylesheet" type="text/css" href="css/chromestyle.css" />
 <LINK rel="stylesheet"  type="text/css" href="css/ads.css" />
 <!-- STATIC CONVERSION [2026-03-12]: removed chrome.js dependency;<script type="text/javascript" src="js/chrome.js"></script> -->

 </head>
<!-- STATIC CONVERSION [2026-03-12]: -->
<body>
 <!-- ORIGINAL <body oncontextmenu="show_contextmenu(event);return false;">-->

 <!--STATIC CONVERSION [2026-03-12]<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
 <script type="text/javascript" src="js/wz_dragdrop.js"></script>-->
 <!--STATIC CONVERSION [2026-03-12]<script language="JavaScript" src="js/overlib.js"> </script> -->
 <center>
<xsl:if test="$export!='print'">
<div class="header">
<div class="vakske"><h5><a class="top" name="top">Willem Elsschot</a></h5></div>
<div class="vakske"><div class="vakskelinks"><h5>Tsjip: Opdracht</h5></div><div class="vakskerechts"><h5>Achter de Schermen</h5></div></div>
</div><!--</td>
</tr>
</table>-->
</xsl:if>
<xsl:if test="$export='print'">
<center><b>Printen: Ctrl-P</b></center><table width="100%"><tr><td valign="top">
<div align="left"><p><a href="javascript:window.close();">Sluit dit venster</a><br/><u>(alle links op deze pagina zijn uitgeschakeld)</u>______</p></div></td><td><div align="right"><p>Willem Elsschot, <i>Tsjip: Opdracht</i> / <i>Achter de Schermen</i><br/>
_________________________________<u>elektronische editie</u></p></div></td></tr></table>
</xsl:if>
<!-- outside table -->
<table class="outside" border="0" cellspacing="0" cellpadding="0" align="center"><xsl:if test="$export!='print'"><xsl:attribute name="style">border: 1px solid #660011;</xsl:attribute></xsl:if><xsl:if test="$export!='print'"><xsl:attribute name="width">804</xsl:attribute></xsl:if><xsl:if test="$export='print'"><xsl:attribute name="width">100%</xsl:attribute></xsl:if>
<tr><td>
<!-- table containing menu -->
<xsl:if test="$export!='print'">
<table class="main" border="0" cellspacing="0" cellpadding="0" width="802" align="center">
 <tr>
  <td>
<!-- STATIC CONVERSION [2026-03-12]: removed onMouseover attributes and chrome.js dependency; 
     dropdown menu now handled by CSS :hover in chromestyle.css; 
     dropmenudiv elements moved inside parent li elements -->
<div id="chromemenu">
<ul>
<li><a href="#"><xsl:if test="$text='home'"><b>Home</b></xsl:if><xsl:if test="$text!='home'">Home</xsl:if></a>
<!-- home -->
<div id="dropmenu5" class="dropmenudiv">
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="index.html">Beginscherm</a>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="inleiding.html"><xsl:if test="$document='inleiding'"><b>Inleiding</b></xsl:if><xsl:if test="$document!='inleiding'">Inleiding</xsl:if></a>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html"><xsl:if test="$document='overlevering'"><b>Overlevering</b></xsl:if><xsl:if test="$document!='overlevering'">Overlevering</xsl:if></a>
</div>
</li>
<li><a href="#">Tsjip: Opdracht</a>
<!-- Tsjip -->
<div id="dropmenu1" class="dropmenudiv">
<!-- STATIC CONVERSION 2026-03-10: new url mapping: new links for all documents --><a href="OpdM1.html"><xsl:if test="$document='OpdM1'"><b>Typoscript 1 (OpdM1)</b></xsl:if><xsl:if test="$document!='OpdM1'">Typoscript 1 (OpdM1)</xsl:if></a>
<a href="OpdM2.html"><xsl:if test="$document='OpdM2'"><b>Typoscript 2 (OpdM2)</b></xsl:if><xsl:if test="$document!='OpdM2'">Typoscript 2 (OpdM2)</xsl:if></a>
<a href="OpdT1.html"><xsl:if test="$document='OpdT1'"><b>Tijdschriftpublicatie (OpdT1)</b></xsl:if><xsl:if test="$document!='OpdT1'">Tijdschriftpublicatie (OpdT1)</xsl:if></a>
<a href="OpdD1.html"><xsl:if test="$document='OpdD1'"><b>Druk 1 (OpdD1)</b></xsl:if><xsl:if test="$document!='OpdD1'">Druk 1 (OpdD1)</xsl:if></a>
<a href="OpdD2.html"><xsl:if test="$document='OpdD2'"><b>Druk 2 (OpdD2)</b></xsl:if><xsl:if test="$document!='OpdD2'">Druk 2 (OpdD2)</xsl:if></a>
<a href="OpdD3.html"><xsl:if test="$document='OpdD3'"><b>Druk 3 (OpdD3)</b></xsl:if><xsl:if test="$document!='OpdD3'">Druk 3 (OpdD3)</xsl:if></a>
<a href="OpdD4.html"><xsl:if test="$document='OpdD4'"><b>Druk 4 (OpdD4)</b></xsl:if><xsl:if test="$document!='OpdD4'">Druk 4 (OpdD4)</xsl:if></a>
<a href="OpdD5.html"><xsl:if test="$document='OpdD5'"><b>Druk 5 (OpdD5)</b></xsl:if><xsl:if test="$document!='OpdD5'">Druk 5 (OpdD5)</xsl:if></a>
<a href="OpdD6.html"><xsl:if test="$document='OpdD6'"><b>Druk 6 (OpdD6)</b></xsl:if><xsl:if test="$document!='OpdD6'">Druk 6 (OpdD6)</xsl:if></a>
<a href="OpdP1a.html"><xsl:if test="contains($document,'OpdP1')"><b>Drukproef 1 (OpdP1)</b></xsl:if><xsl:if test="not(contains($document,'OpdP1'))">Drukproef 1 (OpdP1)</xsl:if></a>
<a href="OpdP2.html"><xsl:if test="contains($document,'OpdP2')"><b>Drukproef 2 (OpdP2)</b></xsl:if><xsl:if test="not(contains($document,'OpdP2'))">Drukproef 2 (OpdP2)</xsl:if></a>
<a href="OpdD7.html"><xsl:if test="$document='OpdD7'"><b>Druk 7 (OpdD7)</b></xsl:if><xsl:if test="$document!='OpdD7'">Druk 7 (OpdD7)</xsl:if></a>
</div>
</li>
<li><a href="#">Achter de Schermen</a>
<!-- Achter de Schermen -->                                                   
<div id="dropmenu2" class="dropmenudiv">
<a href="AdsM1.html"><xsl:if test="$document='AdsM1'"><b>Manuscript (AdsM1)</b></xsl:if><xsl:if test="$document!='AdsM1'">Manuscript (AdsM1)</xsl:if></a>
<a href="AdsM2a.html"><xsl:if test="contains($document,'AdsM2')"><b>Typoscript (AdsM2)</b></xsl:if><xsl:if test="not(contains($document,'AdsM2'))">Typoscript (AdsM2)</xsl:if></a>
<a href="AdsT1.html"><xsl:if test="$document='AdsT1'"><b>Tijdschriftpublicatie (AdsT1)</b></xsl:if><xsl:if test="$document!='AdsT1'">Tijdschriftpublicatie (AdsT1)</xsl:if></a>
<a href="AdsM3a.html"><xsl:if test="contains($document,'AdsM3')"><b>Correctie-exemplaar (AdsM3)</b></xsl:if><xsl:if test="not(contains($document,'AdsM3'))">Correctie-exemplaar (AdsM3)</xsl:if></a>
<a href="AdsD1.html"><xsl:if test="$document='AdsD1'"><b>Druk 1 (AdsD1)</b></xsl:if><xsl:if test="$document!='AdsD1'">Druk 1 (AdsD1)</xsl:if></a>
<a href="AdsD2.html"><xsl:if test="$document='AdsD2'"><b>Druk 2 (AdsD2)</b></xsl:if><xsl:if test="$document!='AdsD2'">Druk 2 (AdsD2)</xsl:if></a>
<a href="AdsD3.html"><xsl:if test="$document='AdsD3'"><b>Druk 3 (AdsD3)</b></xsl:if><xsl:if test="$document!='AdsD3'">Druk 3 (AdsD3)</xsl:if></a>
<a href="AdsD4.html"><xsl:if test="$document='AdsD4'"><b>Druk 4 (AdsD4)</b></xsl:if><xsl:if test="$document!='AdsD4'">Druk 4 (AdsD4)</xsl:if></a>
<a href="AdsD5.html"><xsl:if test="$document='AdsD5'"><b>Druk 5 (AdsD5)</b></xsl:if><xsl:if test="$document!='AdsD5'">Druk 5 (AdsD5)</xsl:if></a>
<a href="AdsP1a.html"><xsl:if test="contains($document,'AdsP1')"><b>Drukproef 1 (AdsP1)</b></xsl:if><xsl:if test="not(contains($document,'AdsP1'))">Drukproef 1 (AdsP1)</xsl:if></a>
<a href="AdsP2.html"><xsl:if test="contains($document,'AdsP2')"><b>Drukproef 2 (AdsP2)</b></xsl:if><xsl:if test="not(contains($document,'AdsP2'))">Drukproef 2 (AdsP2)</xsl:if></a>
<a href="AdsD6.html"><xsl:if test="$document='AdsD6'"><b>Druk 6 (AdsD6)</b></xsl:if><xsl:if test="$document!='AdsD6'">Druk 6 (AdsD6)</xsl:if></a>
</div>
</li>
<!-- STATIC CONVERSION 2026-03-10: Visualisatie menu only in document text views, added xsl:if -->
<xsl:if test="$text='doclin' and $trans!='yes' or $text='doclincomp'"><li><a href="#">Visualisatie</a>
<!-- visualisatie -->
<div id="dropmenu3" class="dropmenudiv">
<a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:value-of select="$document"/>-bovenlaag.html</xsl:attribute><xsl:if test="$view='bovenlaag'"><b>Uiteindelijk resultaat</b></xsl:if><xsl:if test="$view!='bovenlaag'">Uiteindelijk resultaat</xsl:if></a>
<a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:value-of select="$document"/>.html</xsl:attribute><xsl:if test="$view!='bovenlaag'"><b>Volledige transcriptie</b></xsl:if><xsl:if test="$view='bovenlaag'">Volledige transcriptie</xsl:if></a>
<!-- STATIC CONVERSION 2026-03-10: removed printvriendelijke versie from menu <a><xsl:attribute name="href">javascript:MM_openBrWindow('<xsl:if test="$n='' and not(contains($document,'n'))"><xsl:value-of select="substring($document,1,3)"/></xsl:if><xsl:if test="$n='' and contains($document,'n')"><xsl:value-of select="$document"/></xsl:if><xsl:if test="$n!=''">zin</xsl:if>.htm?text=<xsl:value-of select="$text"/>&amp;document=<xsl:value-of select="$document"/>&amp;page=<xsl:value-of select="$page"/>&amp;export=print&amp;comp1=<xsl:value-of select="$comp1"/>&amp;comp2=<xsl:value-of select="$comp2"/>&amp;app=<xsl:value-of select="$app"/>&amp;trans=<xsl:value-of select="$trans"/>&amp;n=<xsl:value-of select="$n"/>&amp;view=<xsl:value-of select="$view"/>&amp;id=<xsl:value-of select="$id"/>&amp;corresp=<xsl:value-of select="$corresp"/>','','width=825,height=538,resizable=yes,scrollbars=yes')</xsl:attribute>Printvriendelijke versie</a>-->
<a><xsl:attribute name="href"><xsl:value-of select="$document"/>.xml</xsl:attribute><xsl:attribute name="onclick">MM_openBrWindow(this.href,'','width=825,height=538,resizable=yes,scrollbars=yes'); return false;</xsl:attribute>XML Bronbestand</a>
</div>
</li></xsl:if>
<!-- STATIC CONVERSION 2026-03-10: Variantenapparaat menu only in document text views, added xsl:if -->
<xsl:if test="$text='doclin' or $text='doclincomp' or $text='doclinlay' and $corresp=''"><li><a href="#">Variantenapparaat</a>
<!-- variantenapp -->
<div id="dropmenu4" class="dropmenudiv">
<a><xsl:attribute name="href"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:if test="not(contains($document,'n'))"><xsl:value-of select="$document"/></xsl:if><xsl:if test="contains($document,'n')">AdsM1</xsl:if>-kies.html</xsl:attribute>Kies 2 versies</a>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:for-each select="//front//witness[substring(@n,1,5) = substring($document,1,5)]">
  <a>
    <xsl:attribute name="href">
      <xsl:value-of select="@n"/>
      <xsl:choose>
        <xsl:when test="$document=@n and $trans='yes'">.html</xsl:when>
        <xsl:otherwise>-varianten.html</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:value-of select="@n"/>
    <xsl:if test="@rend"> (<xsl:value-of select="@rend"/>)</xsl:if>: Varianten 
    <xsl:if test="$document=@n and $trans!='yes'">aan</xsl:if>
    <xsl:if test="$document=@n and $trans='yes'">uit</xsl:if>
    <xsl:if test="$document!=@n">aan</xsl:if>
  </a>
  <xsl:text> </xsl:text>
</xsl:for-each>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:if test="$trans='yes'"><a><xsl:attribute name="href"><xsl:if test="not(substring($document,4,1) = 'Z')"><xsl:value-of select="$document"/></xsl:if><xsl:if test="substring($document,4,1) = 'Z'"><xsl:value-of select="substring($document,1,3)"/><xsl:value-of select="substring($document,5,2)"/>a</xsl:if>.html</xsl:attribute>Varianten uit</a></xsl:if>

</div>
</li></xsl:if>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><li><a href="gebruiksaanwijzing.html"><xsl:if test="$document='gebruiksaanwijzing'"><b>Gebruiksaanwijzing</b></xsl:if><xsl:if test="$document!='gebruiksaanwijzing'">Gebruiksaanwijzing</xsl:if></a></li>
<!-- STATIC CONVERSION 2026-03-10: new url mapping --><li><a href="colofon.html"><xsl:if test="$document='colofon'"><b>Colofon</b></xsl:if><xsl:if test="$document!='colofon'">Colofon</xsl:if></a></li>
</ul>
</div>

</td>
 </tr>
</table>
</xsl:if>
<!-- main inside table -->
<table class="main" align="center" border="0" cellspacing="0"><xsl:if test="$export!='print'"><xsl:attribute name="width">802</xsl:attribute></xsl:if><xsl:if test="$export='print'"><xsl:attribute name="width">100%</xsl:attribute></xsl:if>
 <tr><td>
 <!-- home -->
 <xsl:if test="$text='home'"><xsl:call-template name="home"/></xsl:if>
 <xsl:if test="$text='overlevering'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='gebruiksaanwijzing'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='inleiding'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='colofon'"><xsl:call-template name="colofon"/></xsl:if>
 <!-- 2 teksten vglkn -->
 <!-- M's zonder varianten -->
 <xsl:if test="contains($text,'doclin') and substring($document,4,1) = 'M' and $trans!='yes'">
 <div class="inside">
 <xsl:if test="contains($text,'doclin') and $n=''"><table width="100%"><tr><td valign="top">[<xsl:if test="substring($document,1,5) != 'AdsM2' and substring($document,1,5) != 'AdsM3'"><xsl:value-of select="//front//witness[@n=$document]"/> (<a><xsl:attribute name="href"><xsl:value-of select="$overl"/><xsl:value-of select="substring(//front//witness[@n=$document]/@n,1,5)"/></xsl:attribute><xsl:value-of select="//front//witness[@n=$document]/@n"/></a>)</xsl:if><xsl:if test="substring($document,1,3)= 'Ads' and substring($document,4,2) = 'M2' or substring($document,5,2) = 'M2'">1934: Typoscript 'Achter de Schermen' (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsM2">AdsM2</a>)</xsl:if><xsl:if test="substring($document,1,5) = 'AdsM3'">1935: Correctie-exemplaar Groot Nederland met correcties (<a href="overlevering.html#AdsM3">AdsM3</a>)</xsl:if>]</td><xsl:if test="$export!='print'"><td><div><xsl:attribute name="class"><xsl:if test="substring($document,1,3) = 'Ads'">navigationright2</xsl:if><xsl:if test="substring($document,1,3) = 'Opd' and $text='doclincomp'">navigationright2</xsl:if></xsl:attribute><xsl:if test="$text != 'doclinlay' and $text != 'doclincomp' and substring($document,1,3) = 'Ads'"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:value-of select="$document"/>-zinsvarianten.html</xsl:attribute>toon schrijfproces per zin</a></p></xsl:if><xsl:if test="$text = 'doclinlay' and substring($document,1,3) = 'Ads' and $n=''"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text>Klik op '<img src="images/navi/dot.jpg"/>' voor de zinsvarianten</p></xsl:if><xsl:if test="$text='doclincomp'"><xsl:call-template name="doclincomp"/></xsl:if></div></td></xsl:if></tr></table></xsl:if>
  <xsl:apply-templates select="descendant::text[@id=substring($document,1,5)]"/>
 </div>
 </xsl:if>
 <!-- P's zonder varianten -->
  <xsl:if test="contains($text,'doclin') and substring($document,4,2) = 'P1' and $trans!='yes'">
 <div class="inside">
 <xsl:if test="contains($text,'doclin') and $n=''"><table width="100%"><tr><td valign="top">[<xsl:if test="substring($document,1,5) = 'AdsP1'">1956-57: Tsjip/De Leeuwentemmer, eerste drukproef voor het Verzameld Werk (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsP1">AdsP1</a>)</xsl:if><xsl:if test="substring($document,1,5) = 'OpdP1'">1956-57: Tsjip/De Leeuwentemmer, eerste drukproef voor het Verzameld Werk (<a href="overlevering.html#OpdP1">OpdP1</a>)</xsl:if>]</td><xsl:if test="$export!='print'"><td><div><xsl:attribute name="class"><xsl:if test="substring($document,1,3) = 'Ads'">navigationright2</xsl:if><xsl:if test="substring($document,1,3) = 'Opd' and $text='doclincomp'">navigationright2</xsl:if></xsl:attribute><xsl:if test="$text != 'doclinlay' and $text != 'doclincomp' and substring($document,1,3) = 'Ads'"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:value-of select="$document"/>-zinsvarianten.html</xsl:attribute>toon schrijfproces per zin</a></p></xsl:if><xsl:if test="$text = 'doclinlay' and substring($document,1,3) = 'Ads' and $n=''"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text>Klik op '<img src="images/navi/dot.jpg"/>' voor de zinsvarianten</p></xsl:if><xsl:if test="$text='doclincomp'"><xsl:call-template name="doclincomp"/></xsl:if></div></td></xsl:if></tr></table></xsl:if>
  <xsl:apply-templates select="descendant::text[@id=substring($document,1,5)]"/>
 </div>
 </xsl:if>
 <!-- M's met varianten -->
 <xsl:if test="contains($text,'doclin') and substring($document,4,1) = 'M' and $trans='yes'">
 <div class="inside">
 <xsl:if test="contains($text,'doclin') and $app=''"><table width="100%"><tr><td valign="top">[<xsl:if test="not(substring($document,5,2) = 'M2')"><xsl:value-of select="//front//witness[@n=$document]"/> (<a><xsl:attribute name="href"><xsl:value-of select="$overl"/><xsl:value-of select="substring(//front//witness[@n=$document]/@n,1,5)"/></xsl:attribute><xsl:value-of select="//front//witness[@n=$document]/@n"/></a>)</xsl:if><xsl:if test="substring($document,5,2) = 'M2'">1934: Typoscript 'Achter de Schermen', toplaag (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsM2">AdsM2</a>)</xsl:if>]<br/>
 <xsl:if test="$comp1!=''">[<xsl:if test="not(substring($comp1,4,1) = 'Z')"><xsl:value-of select="$comp1"/></xsl:if><xsl:if test="substring($comp1,4,1) = 'Z'"><xsl:value-of select="substring($comp1,1,3)"/><xsl:value-of select="substring($comp1,5,2)"/></xsl:if> vs. <xsl:if test="not(substring($comp2,4,1) = 'Z')"><xsl:value-of select="$comp2"/></xsl:if><xsl:if test="substring($comp2,4,1) = 'Z'"><xsl:value-of select="substring($comp2,1,3)"/><xsl:value-of select="substring($comp2,5,2)"/></xsl:if>]</xsl:if></td><xsl:if test="$export!='print'"><td><div><xsl:attribute name="class"><xsl:if test="substring($document,1,3) = 'Ads'">navigationright2</xsl:if><xsl:if test="substring($document,1,3) = 'Opd' and $text='doclincomp'">navigationright2</xsl:if></xsl:attribute><xsl:if test="$text != 'doclinlay' and $text != 'doclincomp' and substring($document,1,3) = 'Ads'"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:if test="not(substring($document,4,1) = 'Z')"><xsl:value-of select="$document"/></xsl:if><xsl:if test="substring($document,4,1) = 'Z'"><xsl:value-of select="substring($document,1,3)"/><xsl:value-of select="substring($document,5,2)"/>a</xsl:if>-zinsvarianten.html</xsl:attribute>toon schrijfproces per zin</a></p></xsl:if><xsl:if test="$text = 'doclinlay' and substring($document,1,3) = 'Ads' and $n=''"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text>Klik op '<img src="images/navi/dot.jpg"/>' voor de zinsvarianten</p></xsl:if>
 <xsl:if test="$text='doclincomp'"><xsl:call-template name="doclincomp"/></xsl:if></div></td></xsl:if></tr></table></xsl:if>
  <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </div>
 </xsl:if>
  <!-- P's met varianten -->
 <xsl:if test="contains($text,'doclin') and substring($document,4,2) = 'P1' and $trans='yes'">
 <div class="inside">
 <xsl:if test="$text='doclin' and $app=''"><table width="100%"><tr><td valign="top">[<xsl:value-of select="//front//witness[@n=$document]"/> (<a><xsl:attribute name="href"><xsl:value-of select="$overl"/><xsl:value-of select="substring(//front//witness[@n=$document]/@n,1,5)"/></xsl:attribute><xsl:value-of select="//front//witness[@n=$document]/@n"/></a>)]<br/>
 <xsl:if test="$comp1!=''">[<xsl:if test="not(substring($comp1,4,1) = 'Z')"><xsl:value-of select="$comp1"/></xsl:if><xsl:if test="substring($comp1,4,1) = 'Z'"><xsl:value-of select="substring($comp1,1,3)"/><xsl:value-of select="substring($comp1,5,2)"/></xsl:if> vs. <xsl:if test="not(substring($comp2,4,1) = 'Z')"><xsl:value-of select="$comp2"/></xsl:if><xsl:if test="substring($comp2,4,1) = 'Z'"><xsl:value-of select="substring($comp2,1,3)"/><xsl:value-of select="substring($comp2,5,2)"/></xsl:if>]</xsl:if></td><xsl:if test="$export!='print'"><td><div><xsl:attribute name="class"><xsl:if test="substring($document,1,3) = 'Ads'">navigationright2</xsl:if><xsl:if test="substring($document,1,3) = 'Opd' and $text='doclincomp'">navigationright2</xsl:if></xsl:attribute><xsl:if test="$text != 'doclinlay' and $text != 'doclincomp' and substring($document,1,3) = 'Ads'"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:attribute name="href"><xsl:value-of select="$document"/>-zinsvarianten.html</xsl:attribute>toon schrijfproces per zin</a></p></xsl:if><xsl:if test="$text = 'doclinlay' and substring($document,1,3) = 'Ads' and $n=''"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text>Klik op '<img src="images/navi/dot.jpg"/>' voor de zinsvarianten</p></xsl:if>
 <xsl:if test="$text='doclincomp'"><xsl:call-template name="doclincomp"/></xsl:if></div></td></xsl:if></tr></table></xsl:if>
  <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </div>
 </xsl:if>
 <!-- De rest -->
  <xsl:if test="contains($text,'doclin') and substring($document,4,1) != 'M' and substring($document,4,2) != 'P1'">
 <div class="inside">
  <xsl:if test="contains($text,'doclin') and $n='' and $app=''"><table width="100%"><tr><td valign="top">[<xsl:if test="not(substring($document,4,1) = 'Z')"><xsl:value-of select="//front//witness[@n=$document]"/> (<a><xsl:attribute name="href"><xsl:value-of select="$overl"/><xsl:value-of select="substring(//front//witness[@n=$document]/@n,1,5)"/></xsl:attribute><xsl:value-of select="//front//witness[@n=$document]/@n"/></a>)</xsl:if><xsl:if test="substring($document,5,2) = 'M2'">1934: Typoscript 'Achter de Schermen', toplaag (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsM2">AdsM2</a>)</xsl:if><xsl:if test="substring($document,5,2) = 'M3'">1935: Correctie-exemplaar Groot Nederland, toplaag (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsM3">AdsM3</a>)</xsl:if><xsl:if test="substring($document,5,2) = 'P1'">1956-57: Tsjip/De Leeuwentemmer, eerste drukproef voor het Verzameld Werk, toplaag (<!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html#AdsP1">AdsP1</a>)</xsl:if><xsl:if test="substring($document,5,2) = 'P2'">1957: Tsjip/De Leeuwentemmer, tweede drukproef voor het Verzameld Werk (AdsP2)</xsl:if>]<br/>
  <xsl:if test="$comp1!=''">[<xsl:if test="not(substring($comp1,4,1) = 'Z')"><xsl:value-of select="$comp1"/></xsl:if><xsl:if test="substring($comp1,4,1) = 'Z'"><xsl:value-of select="substring($comp1,1,3)"/><xsl:value-of select="substring($comp1,5,2)"/></xsl:if> vs. <xsl:if test="not(substring($comp2,4,1) = 'Z')"><xsl:value-of select="$comp2"/></xsl:if><xsl:if test="substring($comp2,4,1) = 'Z'"><xsl:value-of select="substring($comp2,1,3)"/><xsl:value-of select="substring($comp2,5,2)"/></xsl:if>]<br/></xsl:if></td><xsl:if test="$export!='print'"><td><div><xsl:attribute name="class"><xsl:if test="substring($document,1,3) = 'Ads'">navigationright2</xsl:if><xsl:if test="substring($document,1,3) = 'Opd' and $text='doclincomp'">navigationright2</xsl:if></xsl:attribute><xsl:if test="$text != 'doclinlay' and $text != 'doclincomp' and substring($document,1,3) = 'Ads'"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text><a><xsl:attribute name="href"><xsl:if test="not(substring($document,4,1) = 'Z')"><xsl:value-of select="$document"/></xsl:if><xsl:if test="substring($document,4,1) = 'Z'"><!-- STATIC CONVERSION 2026-03-10: new url mapping --><xsl:value-of select="substring($document,1,3)"/><xsl:value-of select="substring($document,5,2)"/>a</xsl:if>-zinsvarianten.html</xsl:attribute>toon schrijfproces per zin</a></p></xsl:if><xsl:if test="$text = 'doclinlay' and substring($document,1,3) = 'Ads' and $n=''"><p class="navigation"><img src="images/navi/dot.jpg"/><xsl:text> </xsl:text>Klik op '<img src="images/navi/dot.jpg"/>' voor de zinsvarianten</p></xsl:if><xsl:if test="$text='doclincomp'"><xsl:call-template name="doclincomp"/></xsl:if></div></td></xsl:if></tr></table></xsl:if>
   <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </div>
 </xsl:if>
 <!-- de facs en zo -->
 <xsl:if test="contains($text,'docfacs') and substring($document,4,1) = 'M'">
  <xsl:apply-templates select="descendant::text[@id=substring($document,1,5)]"/>
 </xsl:if>
 <xsl:if test="contains($text,'docfacs') and substring($document,4,1) != 'M'">
  <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </xsl:if>
  <xsl:if test="contains($text,'docfacs') and $document = 'inleiding'">
  <center><img><xsl:attribute name="src">images/inleiding/<xsl:value-of select="$page"/>.jpg</xsl:attribute></img></center>
 </xsl:if>
 </td></tr>
</table>
</td></tr></table>
</center>
<!--STATIC CONVERSION 2026-03-12 <script type="text/javascript">

SET_DHTML(CURSOR_MOVE, "reldiv2", "reldiv");

</script>-->

<script>
//     STATIC CONVERSION 2026-03-12: Replace overlib.js with lightweight vanilla JS for
//     note and quicklink popups. No external library dependency. Two popup types:
//     (1) note popups: .note-inline content hidden on DOMContentLoaded, revealed via
//     .note-content span built dynamically by JS and toggled by .note-trigger click.
//     Graceful degradation: with JS disabled, note text renders inline as styled
//     .note-inline span.
//     (2) quicklink popups: .quicklink-inline hidden on DOMContentLoaded, revealed via
//     position:fixed placement calculated from trigger.getBoundingClientRect(). All
//     popup styling applied via cssText with !important to override HTML4 transitional
//     quirks mode inheritance. Graceful degradation: with JS disabled, quicklink links
//     hidden via .quicklink-inline { display: none !important } — acceptable as same
//     links available via navigation menu.
//     Close buttons handled by delegated click listener targeting .note-close class,
//     closing .note-content (notes) or .quicklink-inline (quicklinks) respectively.
//     overlib.js script include removed from page header.

document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded fired');

  // note popups
  document.querySelectorAll('.note-popup').forEach(function(popup) {
    try {
      var trigger = popup.querySelector('.note-trigger');
      var inline = popup.querySelector('.note-inline');
      var text = inline.textContent.slice(1, -1);
      var content = document.createElement('span');
      content.className = 'note-content';
      content.innerHTML =
        '<span class="note-header">' +
          '<span class="note-caption">Noot</span>' +
          '<a href="#" class="note-close">Sluit</a>' +
        '</span>' +
        '<span class="note-body">' + text + '</span>';
      popup.appendChild(content);
      inline.style.display = 'none';
      trigger.addEventListener('click', function() {
        var c = popup.querySelector('.note-content');
        c.style.display = c.style.display === 'inline-block' ? 'none' : 'inline-block';
      });
    } catch(err) {
      console.error('note-popup error:', err, popup);
    }
  });

  // quicklink popups
  console.log('quicklink section reached');
  document.querySelectorAll('.quicklink-popup').forEach(function(popup) {
    try {
      var trigger = popup.querySelector('.quicklink-trigger');
      var inline = popup.querySelector('.quicklink-inline');
      inline.style.display = 'none';
      trigger.addEventListener('click', function(e) {
        e.preventDefault();
        if (inline.style.display === 'none') {
          var rect = trigger.getBoundingClientRect();
          inline.style.cssText = 'display: block !important; position: fixed !important; top: ' + (rect.bottom + 4) + 'px !important; left: ' + rect.left + 'px !important; width: 270px !important; z-index: 9999 !important; background-color: #AEAEAE !important; padding: 1px !important;';
        } else {
          inline.style.display = 'none';
        }
      });
    } catch(err) {
      console.error('quicklink-popup error:', err, popup);
    }
  });

  // close buttons
  document.addEventListener('click', function(e) {
    if (e.target.classList.contains('note-close')) {
      e.preventDefault();
      // for note popups
      var noteContent = e.target.closest('.note-content');
      if (noteContent) noteContent.style.display = 'none';
      // for quicklink popups
      var quicklinkInline = e.target.closest('.quicklink-inline');
      if (quicklinkInline) quicklinkInline.style.display = 'none';
    }
  });

});

// STATIC CONVERSION 2026-03-13: wz_dragdrop.js dependency eliminated. Draggable popup implemented as position:fixed div for HTML4 transitional doctype compatibility. Shown on page load; closed via sluit link; dragged via vanilla JS pointer events. 

var topoDialog = document.getElementById('topo-dialog');
if (topoDialog) {
  // show on page load
  topoDialog.style.display = 'block';

  // close link
  document.getElementById('sluit-link').addEventListener('click', function(e) {
    e.preventDefault();
    topoDialog.style.display = 'none';
  });

  // drag
  var bar = topoDialog.querySelector('.topo-titlebar');
  var ox, oy, dragging = false;
  bar.addEventListener('pointerdown', function(e) {
    if (e.target.id === 'sluit-link') return;
    dragging = true;
    var rect = topoDialog.getBoundingClientRect();
    ox = e.clientX - rect.left;
    oy = e.clientY - rect.top;
    bar.setPointerCapture(e.pointerId);
  });
  bar.addEventListener('pointermove', function(e) {
    if (!dragging) return;
    topoDialog.style.left = (e.clientX - ox) + 'px';
    topoDialog.style.top  = (e.clientY - oy) + 'px';
  });
  bar.addEventListener('pointerup', function() {
    dragging = false;
  });
}

</script>
 </body>
 <!--STATIC CONVERSION 2026-03-12 <HEAD>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="-1"/>
</HEAD>-->

</html>
</xsl:if>
</xsl:template>

<xsl:template name="doclincomp">
  <!-- STATIC CONVERSION 2026-03-12: Replace JS-driven "kies 2 versies" form with two-step
     static navigation. "Kies 2 versies" links from individual witness pages now point
     directly to $document-kies2.html, bypassing step 1. Step 1 (AdsM1-kies.html etc.)
     retained as entry point for menu/home navigation. Step 2 pages (AdsM1-kies2.html
     etc.) generated by XSLT loop over all witnesses, listing all comparison links to
     $document-varianten-$comp2.html. CSS pill-button styling added for witness lists.
     javascript:warp() function and associated <form> removed. -->

<p>Vergelijk <strong><xsl:value-of select="substring($document, 4)"/></strong> met:
<ul class="kies-lijst">
<xsl:for-each select="//front/div/witList/witness/@n">
  <xsl:choose>
    <xsl:when test="substring(current(),6,1) = 'a'">
      <xsl:if test=". != $document">
        <li><a><xsl:attribute name="href"><xsl:value-of select="$document"/>-varianten-<xsl:value-of select="."/>.html</xsl:attribute><xsl:value-of select="substring(.,4,2)"/> grond</a></li>
      </xsl:if>
    </xsl:when>
    <xsl:when test="substring(current(),6,1) = 'b'">
      <xsl:variable name="zvalue"><xsl:value-of select="substring($document,1,3)"/>Z<xsl:value-of select="substring(.,4,2)"/></xsl:variable>
      <xsl:if test="$zvalue != $document">
        <li><a><xsl:attribute name="href"><xsl:value-of select="$document"/>-varianten-<xsl:value-of select="$zvalue"/>.html</xsl:attribute><xsl:value-of select="substring(.,4,2)"/> top</a></li>
      </xsl:if>
    </xsl:when>
    <xsl:when test="substring(current(),6,1) = ''">
      <xsl:if test=". != $document">
        <li><a><xsl:attribute name="href"><xsl:value-of select="$document"/>-varianten-<xsl:value-of select="."/>.html</xsl:attribute><xsl:value-of select="substring(.,4,2)"/></a></li>
      </xsl:if>
    </xsl:when>
  </xsl:choose>
</xsl:for-each>
</ul>
</p>

<!-- original (with revised url mapping) <p class="navigation"><form method="POST" name="test" style="display: inline"><script language="javascript">
function warp(){
window.location=(document.test.comp1.value + "-varianten-" + document.test.comp2.value + ".html");
}
</script>
<select name="comp1" size="1">
<xsl:for-each select="//front/div/witList/witness/@n">
<xsl:if test="substring(current(),6,1) != ''">
<xsl:if test="substring(current(),6,1) = 'a'">
<option><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/> grond</option>
</xsl:if>
<xsl:if test="substring(current(),6,1) = 'b'">
<option><xsl:attribute name="value"><xsl:value-of select="substring($document,1,3)"/>Z<xsl:value-of select="substring(.,4,2)"/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/> top</option>
</xsl:if>
</xsl:if>
<xsl:if test="substring(current(),6,1) = ''">
<option><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/></option>
</xsl:if>
</xsl:for-each>
</select> vs. <select name="comp2" size="1">
<xsl:for-each select="//front/div/witList/witness/@n">
<xsl:if test="substring(current(),6,1) != ''">
<xsl:if test="substring(current(),6,1) = 'a'">
<option><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/> grond</option>
</xsl:if>
<xsl:if test="substring(current(),6,1) = 'b'">
<option><xsl:attribute name="value"><xsl:value-of select="substring($document,1,3)"/>Z<xsl:value-of select="substring(.,4,2)"/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/> top</option>
</xsl:if>
</xsl:if>
<xsl:if test="substring(current(),6,1) = ''">
<option><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="substring(.,4,2)"/></option>
</xsl:if></xsl:for-each></select>
: <input type="radio" name="submit" onClick="javascript:warp();"/></form></p> -->
</xsl:template>
</xsl:stylesheet>
