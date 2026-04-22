<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:param name="text" select="''"/>
<xsl:param name="trans" select="''"/>
<xsl:param name="comp1" select="''"/>
<xsl:param name="comp2" select="''"/>
<xsl:param name="n" select="''"/>
<xsl:param name="export" select="''"/>
<xsl:param name="id" select="''"/>
<xsl:param name="corresp" select="''"/>
<xsl:param name="toggle"><img src="toggle.gif" border="0"/></xsl:param>


<xsl:template name="home">
<div class="inleiding">
<p class="inleiding">Deze elektronische editie biedt de mogelijkheid om van de 'Opdracht' bij <i>Tsjip</i> en 'Achter de Schermen' van Willem Elsschot alle bronnen te verkennen en met elkaar te vergelijken, vanuit verschillende vertrekpunten. Elke versie is integraal opgenomen, zowel in een elektronisch doorzoekbare transcriptie als in een digitale facsimile. Ook kunnen per versie alle varianten worden opgeroepen of per zin de stappen in het schrijfproces worden gevolgd. In het meest complexe geval, het kladhandschrift van 'Achter de Schermen', kan bovendien een 'topografische transcriptie' worden geraadpleegd als hulpmiddel bij het 'lezen' van het manuscript.</p>

<p class="inleiding">Zie voor de verschillende mogelijkheden de <!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="gebruiksaanwijzing.html">Gebruiksaanwijzing</a>. Onder Home zijn een <!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="inleiding.html">inleiding</a> bij beide teksten en een beschrijvend <!-- STATIC CONVERSION 2026-03-10: new url mapping --><a href="overlevering.html">overzicht</a> van de opgenomen bronnen te vinden.</p>
<!-- STATIC CONVERSION 2026-04-21: removed a now defunct passage about the "Exit button" --><!--<p class="inleiding">Na gebruik dient u de elektronische editie steeds af te sluiten door op de <b>Exit</b>-knop rechtsboven de werkbalk te klikken. Het icoontje onder in de taakbalk van uw computer verdwijnt dan vanzelf.
</p>-->
</div>

<!-- STATIC CONVERSION 2026-04-21: HTML review --><!-- STATIC CONVERSION 2026-04-22: added a line about the conversion, with a link to a changelog. --><p class="editors">Editie bezorgd door Peter de Bruijn, Vincent Neyt en Dirk Van Hulle<br/> <a href="2026.html">Webpublicatie 2026</a></p>


</xsl:template>

<xsl:template name="colofon">
<!-- STATIC CONVERSION 2026-04-22: changed the colofon from image to html rendering of colophon.xml, to add a reference to the 2026 STATIC CONVERSION -->
<!--<div style="text-align:center;"><img src="images/colofon.jpg" usemap="#colofon_Map" border="0" alt="colofon"/></div>-->
<div class="colofoncontainer"><xsl:apply-templates select="document('../xml/colofon.xml')//body"/></div>

<br/>
<br/>
<!--<map name="colofon_Map">
<area shape="rect" alt="" coords="147,291,305,308" href="mailto:dirk.vanhulle@ua.ac.be"/>
<area shape="rect" alt="" coords="396,276,560,290" href="mailto:vincent.neyt@gmail.com"/>
<area shape="rect" alt="" coords="35,276,306,291" href="mailto:peter.de.bruijn@huygensinstituut.knaw.nl"/>
</map>-->
</xsl:template>

<!-- STATIC CONVERSION 2026-04-22: added a "Webpublicatie 2026" page-->
<xsl:template name="web2026">
	<div class="sectie">Webpublicatie 2026</div>
	<p class="spacer"/>
	<p class="web2026">De editie verscheen oorspronkelijk in 2007 als cd-rom publicatie. In 2026 herwerkte Vincent Neyt de originele cd-rom versie uit 2007 tot een statische webpublicatie met het oog op duurzame bewaring en vrije verspreiding.</p>
	<p class="web2026">De onderliggende HTML-code werd bijgewerkt naar huidige standaarden. Een aantal functionaliteiten werd licht aangepast: de mogelijkheid om twee willekeurige versies te vergelijken werd vereenvoudigd, en bij de afbeeldingen van het manuscript van 'Achter de Schermen' werd de zoomweergave op basis van Flash verwijderd. De cd-rom versie bood daarnaast een zoekfunctie en een printvriendelijke weergave; deze zijn in deze webpublicatie niet langer beschikbaar.</p>
	<p class="web2026">De gebruiksaanwijzing werd herzien om de huidige editie te beschrijven.</p>
	<p class="web2026">De bronbestanden (XML, XSLT) en de bouwscripts zijn beschikbaar via 
<a href="https://github.com/centre-for-manuscript-genetics/ads" target="_blank">GitHub</a>, waar ook een volledige beschrijving van de conversie en een lijst van alle wijzigingen te vinden is.</p>
	<p class="spacer"/>
</xsl:template>
</xsl:stylesheet>
