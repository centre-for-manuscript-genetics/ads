<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>

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
<p class="inleiding">Na gebruik dient u de elektronische editie steeds af te sluiten door op de <b>Exit</b>-knop rechtsboven de werkbalk te klikken. Het icoontje onder in de taakbalk van uw computer verdwijnt dan vanzelf.

</p></div>

<center><font color="#660011">Editie bezorgd door Peter de Bruijn, Vincent Neyt en Dirk Van Hulle</font></center>
<br/>
</xsl:template>

<xsl:template name="colofon">
<div style="text-align:center;"><img src="images/colofon.jpg" usemap="#colofon_Map" border="0" alt="colofon"/></div>

<br/>
<br/>
<map name="colofon_Map">
<area shape="rect" alt="" coords="147,291,305,308" href="mailto:dirk.vanhulle@ua.ac.be"/>
<area shape="rect" alt="" coords="396,276,560,290" href="mailto:vincent.neyt@gmail.com"/>
<area shape="rect" alt="" coords="35,276,306,291" href="mailto:peter.de.bruijn@huygensinstituut.knaw.nl"/>
</map>
</xsl:template>
</xsl:stylesheet>
