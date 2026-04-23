<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:exist="http://exist.sourceforge.net/NS/exist"
        xmlns:sidebar="http://exist-db.org/NS/sidebar"
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        version="1.0">

  <!-- used by multi-form pages -->
    <xsl:param name="page"/>

    <xsl:variable name="showpage">
    <!-- ist Parameter $page gesetzt? -->
        <xsl:choose>
            <xsl:when test="$page">
                <xsl:value-of select="$page"/>
            </xsl:when>
      <!-- nein: hole name der ersten Page als Parameter -->
            <xsl:otherwise>
                <xsl:value-of select="//tabbed-form/page[1]/@name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="sidebar:sidebar">
    <center>
   <div class="header">
            <div class="vakske">
               <h5><a class="top" name="top">Willem Elsschot</a></h5>
            </div>
            <div class="vakske">
               <div class="vakskelinks">
                  <h5>Tsjip: Opdracht</h5>
               </div>
               <div class="vakskerechts">
                  <h5>Achter de Schermen</h5>
               </div>
            </div>
            <div class="vakske"></div>
</div>
         <table class="outside" border="0" cellspacing="0" cellpadding="0" align="center" style="border-left: 1px solid #660011;border-right: 1px solid #660011;border-top: 1px solid #660011;" width="804">
            <tr>
               <td>
                  <table class="main" border="0" cellspacing="0" cellpadding="0" width="802" align="center">
                     <tr>
                        <td>
                           <div id="chromemenu">
                              <ul>
                                 <li><a href="#" onMouseover="cssdropdown.dropit(this,event,'dropmenu5')">Home</a></li>
                                 <li><a href="#" onMouseover="cssdropdown.dropit(this,event,'dropmenu1')">Tsjip: Opdracht</a></li>
                                 <li><a href="#" onMouseover="cssdropdown.dropit(this,event,'dropmenu2')">Achter de Schermen</a></li>
                                 <li><a href="#" onMouseover="cssdropdown.dropit(this,event,'dropmenu3')">Visualisatie</a></li>
                                 <li><a href="#" onMouseover="cssdropdown.dropit(this,event,'dropmenu4')">Variantenapparaat</a></li>
                                 <li><b><a href="http://localhost:9999/exist/xquery/search.xq">Zoek</a></b></li>
                                 <li><a href="http://localhost:9999/ads/gebruiksaanwijzing.htm?text=gebruiksaanwijzing&amp;document=gebruiksaanwijzing">Gebruiksaanwijzing</a></li>
                                 <li><a href="http://localhost:9999/ads/colofon.htm?text=colofon&amp;document=colofon">Colofon</a></li>
                              </ul>
                           </div>
			    <div id="dropmenu5" class="dropmenudiv"><a href="http://localhost:9999/ads/Ads.htm">Beginscherm</a><a href="http://localhost:9999/ads/inleiding.htm?text=inleiding&amp;document=inleiding">Inleiding</a><a href="http://localhost:9999/ads/overlevering.htm?text=overlevering&amp;document=overlevering">Overlevering</a></div>
                           <div id="dropmenu1" class="dropmenudiv"><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdM1&amp;page=1">Typoscript 1 (OpdM1)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdM2&amp;page=1">Typoscript 2 (OpdM2)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdT1&amp;page=1">Tijdschriftpublicatie (OpdT1)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD1&amp;page=1">Druk 1 (OpdD1)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD2&amp;page=1">Druk 2 (OpdD2)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD3&amp;page=1">Druk 3 (OpdD3)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD4&amp;page=1">Druk 4 (OpdD4)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD5&amp;page=1">Druk 5 (OpdD5)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD6&amp;page=1">Druk 6 (OpdD6)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdP1a&amp;page=1">Drukproef 1 (OpdP1)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdP2&amp;page=1">Drukproef 2 (OpdP2)</a><a href="http://localhost:9999/ads/Opd.htm?text=doclin&amp;document=OpdD7&amp;page=1">Druk 7 (OpdD7)</a></div>
                           <div id="dropmenu2" class="dropmenudiv"><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsM1&amp;page=1"><b>Manuscript (AdsM1)</b></a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsM2a&amp;page=1">Typoscript (AdsM2)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsT1&amp;page=1">Tijdschriftpublicatie (AdsT1)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsM3a&amp;page=1">Correctie-exemplaar (AdsM3)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD1&amp;page=1">Druk 1 (AdsD1)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD2&amp;page=1">Druk 2 (AdsD2)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD3&amp;page=1">Druk 3 (AdsD3)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD4&amp;page=1">Druk 4 (AdsD4)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD5&amp;page=1">Druk 5 (AdsD5)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsP1a&amp;page=1">Drukproef 1 (AdsP1)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsP2&amp;page=1">Drukproef 2 (AdsP2)</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsD6&amp;page=1">Druk 6 (AdsD6)</a></div>
                           <div id="dropmenu3" class="dropmenudiv"><a>Uiteindelijk resultaat</a><a><b>Volledige transcriptie</b></a><a>Printvriendelijke versie</a><a>XML Bronbestand</a></div>
                           <div id="dropmenu4" class="dropmenudiv"><a href="http://localhost:9999/ads/Ads.htm?text=doclincomp&amp;document=AdsM1&amp;page=1">Kies 2 versies</a><a href="http://localhost:9999/ads/Ads.htm?text=doclin&amp;document=AdsM1&amp;page=1&amp;trans=yes">AdsM1: Varianten aan</a> 
                           </div>
                        </td>
                     </tr>
                  </table></td></tr></table></center>
    </xsl:template>
    <xsl:template match="document">
        <xsl:variable name="css">
            <xsl:choose>
                <xsl:when test="header/style/@href">
                    <xsl:value-of select="header/style/@href"/>
                </xsl:when>
                <xsl:otherwise>styles/default-style.css</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <html>
            <head>
                <title>
                    <xsl:value-of select="header/title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="{$css}"/>
                <xsl:if test="header/style">
                    <xsl:copy-of select="header/style"/>
                </xsl:if>
                <xsl:if test="header/script">
                    <xsl:copy-of select="header/script"/>
                </xsl:if>
		<script language="javascript">
		function setfocus() {
                document.xquery.searchterm.focus()
                }
                </script>
            </head>

            <body bgcolor="#EEEEEE" onload="setfocus();" oncontextmenu="show_contextmenu(event);return false;">
                <!--<div id="top">
                    <img src="logo.jpg" title="eXist"/>
                    <table id="menubar">
                        <tr>
                            <td id="header"><xsl:value-of select="header/title"/></td>
                            <xsl:apply-templates select="sidebar:sidebar/sidebar:toolbar"/>
                        </tr>
                    </table>
                    <div id="version-info">Site based on <xsl:value-of select="header/version"/></div>
                </div>-->
                <xsl:apply-templates select="sidebar:sidebar"/>
                <xsl:apply-templates select="rss"/>
                <xsl:apply-templates select="body"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="body">
        <xsl:choose>
            <xsl:when test="../rss">
                <div id="content"><xsl:apply-templates/></div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="error">
        <p class="error">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="exist:query-time">
        <xsl:value-of select="//exist:result/@queryTime"/>
    </xsl:template>

    <xsl:template match="exist:hits">
        <xsl:value-of select="//exist:result/@hitCount"/>
    </xsl:template>

    <xsl:template match="exist:retrieve-time">
        <xsl:value-of select="//exist:result/@retrieveTime"/>
    </xsl:template>

  <!-- templates for the sidebar

    <xsl:template match="sidebar:sidebar">
        <div id="sidebar">
            <xsl:apply-templates select="sidebar:group"/>
            
            <xsl:apply-templates select="sidebar:banner"/>
        </div>
    </xsl:template> -->

    <xsl:template match="sidebar:toolbar">
        <td align="right">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="sidebar:group">
        <div class="block">
            <h3><xsl:value-of select="@name"/></h3>
            <ul><xsl:apply-templates/></ul>
        </div>
    </xsl:template>

    <xsl:template match="sidebar:item">
        <xsl:choose>
            <xsl:when test="../@empty">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="sidebar:banner">
        <div class="banner">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!--<xsl:template match="link|sidebar:link">
        <a href="{@href}"><xsl:apply-templates/></a>
    </xsl:template>-->

    <xsl:template match="author">
        <small>
            <xsl:value-of select="text()"/>
        </small>
        <br/>
        <xsl:if test="@email">
            <a href="mailto:{@email}">
                <small>
                    <em>
                        <xsl:value-of select="@email"/>
                    </em>
                </small>
            </a>
        </xsl:if>
    </xsl:template>

    <xsl:template match="body/section">
        <h1>
            <xsl:if test="@id">
                <a name="{@id}"></a>
            </xsl:if>
            <xsl:value-of select="@title"/>
        </h1>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="section/section">
        <p></p>
        <xsl:if test="@id">
            <a name="{@id}"></a>
        </xsl:if>
        <h2>
            <xsl:value-of select="@title"/>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <xsl:template match="emphasis">
        <span class="emphasis">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="preserve">
        <pre>
            <xsl:apply-templates/>
        </pre>
    </xsl:template>

    <xsl:template match="source">
        <div align="center">
            <table width="90%" cellspacing="4" cellpadding="0" border="0">
                <tr>
                    <td bgcolor="#0086b2" width="1" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                    <td bgcolor="#0086b2" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                    <td bgcolor="#0086b2" width="1" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#0086b2" width="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                    <td bgcolor="#ffffff">
                        <pre>
                            <xsl:apply-templates/>
                        </pre>
                    </td>
                    <td bgcolor="#0086b2" width="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#0086b2" width="1" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                    <td bgcolor="#0086b2" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                    <td bgcolor="#0086b2" width="1" height="1">
                        <img src="resources/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
                    </td>
                </tr>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="abstract">
        <p>
            <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center"
                    bgcolor="#000000">
                <tr>
                    <td>
                        <table width="100%" cellpadding="3" cellspacing="1">
                            <tr>
                                <td width="98%" bgcolor="#FFFFFF">
                                    <span class=".abstract">
                                        <xsl:apply-templates/>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </p>
    </xsl:template>

    <xsl:template match="note">
        <p>
            <table width="100%" cellspacing="3" cellpadding="0" border="0">
                <tr>
                    <td width="28" valign="top">
                        <img src="resources/note.gif" width="28" height="29" vspace="0" hspace="0" border="0" alt="Note"/>
                    </td>
                    <td valign="top">
                        <font size="-1" face="arial,helvetica,sanserif" color="#000000">
                            <i>
                                <xsl:apply-templates/>
                            </i>
                        </font>
                    </td>
                </tr>
            </table>
        </p>
    </xsl:template>

    <xsl:template match="ul|ol|dl">
        <blockquote>
            <xsl:copy>
                <xsl:apply-templates/>
            </xsl:copy>
        </blockquote>
    </xsl:template>

    <xsl:template match="variablelist">
        <div class="variablelist">
            <table border="0" cellpadding="5" cellspacing="0">
                <xsl:apply-templates/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="varlistentry">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="term">
        <td width="20%" align="left" valign="top">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="varlistentry/listitem">
        <td width="80%" align="left">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="li">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="sl">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="b|em">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tabbed-form">
        <table border="0" cellpadding="10" cellspacing="0" height="20">
            <tr>
                <xsl:apply-templates select="page" mode="print-tabs"/>
            </tr>
        </table>

        <table border="0" cellpadding="15" cellspacing="0" width="100%" bgcolor="{@highcolor}">
            <tr>
                <td class="tabpage">
                    <xsl:apply-templates select="page[@name=$showpage]"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="page" mode="print-tabs">
        <xsl:variable name="highcolor">
            <xsl:value-of select="ancestor::tabbed-form/@highcolor"/>
        </xsl:variable>
        <xsl:variable name="lowcolor">
            <xsl:value-of select="ancestor::tabbed-form/@lowcolor"/>
        </xsl:variable>
        <xsl:variable name="href">
            <xsl:value-of select="ancestor::tabbed-form/@href"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$showpage and $showpage=@name">
                <td class="tab" bgcolor="{$highcolor}">
                    <b>
                        <xsl:value-of select="@label"/>
                    </b>
                </td>
            </xsl:when>

            <xsl:otherwise>
                <td class="tab" bgcolor="{$lowcolor}">
                    <a class="page" href="{$href}?page={@name}">
                        <b style="font-color: white">
                            <xsl:value-of select="@label"/>
                        </b>
                    </a>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="page">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="definitionlist">
        <table border="0" width="90%" align="center" cellpadding="5" cellspacing="5">
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="definition">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="term">
        <td valign="top" width="10%">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="def">
        <td width="90%">
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="rss">
        <div id="news">
            <div class="block">
                <h3>News</h3>
                <xsl:apply-templates select="channel/item[position()&lt;7]"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="item">
        <div class="headline">
            <div class="date">
                <xsl:value-of select="substring(dc:date, 1, 10)"/>
            </div>
            
            <a href="{link/text()}"><xsl:value-of select="title"/></a>
        </div>
    </xsl:template>
    
    <xsl:include href="xmlsource.xsl"/>
    
</xsl:stylesheet>
