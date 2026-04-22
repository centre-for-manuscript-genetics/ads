<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:output method="xml" encoding="iso-8859-1" indent="yes" omit-xml-declaration="no"/>

<xsl:param name="text" select="''"/>
<xsl:param name="trans" select="''"/>
<xsl:param name="comp1" select="''"/>
<xsl:param name="comp2" select="''"/>
<xsl:param name="n" select="''"/>
<xsl:param name="app" select="''"/>
<xsl:param name="export" select="''"/>
<xsl:param name="id" select="''"/>
<xsl:param name="corresp" select="''"/>
<xsl:param name="view" select="''"/>
<xsl:param name="page" select="''"/>
<xsl:param name="document" select="''"/>
<xsl:param name="segM2" select="//text[@id=substring($document,1,5)]//seg[@n=$n]/@base"/>
<xsl:param name="segDD" select="//text[@id='AdsDD']//seg[@n=$n]/@base"/>
<xsl:param name="seg" select="//text[@id='AdsM1']//seg[@base=$segM2]"/>
<xsl:param name="segdd" select="//text[@id='AdsM1']//seg[@base=$segDD]"/>
<xsl:param name="correspseg" select="//text[@id='AdsM1']//seg[@base=$segM2]/@base"/>
<xsl:param name="correspsegDD" select="//text[@id='AdsM1']//seg[@base=$segDD]/@base"/>

<xsl:template match="TEI.2">
<TEI.2>
 <teiHeader creator="Dirk Van Hulle" date.created="2000-06-08">
 <fileDesc>
 <titleStmt>
  <title>Achter de Schermen: a machine readable transcription</title> 
  <title>Achter de Schermen: a machine readable transcription</title> 
  <author id="WE">Willem Elsschot</author> 
  <principal id="DVH">Dirk Van Hulle</principal>
  <principal id="PDB">Peter De Bruijn</principal>
 <funder>
  <name>Centre for Manuscript Genetics (UA)</name>
  <name>Huygens Instituut (HI), Koninklijke Nederlandse Akademie van Wetenschappen</name>
  <name>Centrum voor Teksteditie en Bronnenstudie (CTB), Koninklijke Academie voor Nederlandse Taal- en Letterkunde</name>
 <address>
  <addrLine>Universiteit Antwerpen (UA)</addrLine> 
  <addrLine>Prinsstraat 13</addrLine> 
  <addrLine>B-2000 Antwerpen</addrLine> 
  <addrLine>Belgium</addrLine> 
  <addrLine>tel: +32 (0)3 220 42 46</addrLine> 
  <addrLine>email: dirk.vanhulle@ua.ac.be</addrLine> 
  </address>
  </funder>
  </titleStmt>
  <extent /> 
 <publicationStmt>
  <authority>Centre for Manuscript Genetics (UA)</authority> 
  <authority>Huygens Instituut (HI), Koninklijke Nederlandse Akademie van Wetenschappen</authority>
<authority>Centrum voor Teksteditie en Bronnenstudie (CTB), Koninklijke Academie voor Nederlandse Taal- en Letterkunde</authority>
  <pubPlace>Antwerp</pubPlace> 
  <date>2007</date> 
 <availability status="restricted"> 
  </availability>
  </publicationStmt>
  <sourceDesc /> 
  </fileDesc>
 <encodingDesc>
 <projectDesc>
  <p /> 
  </projectDesc>
 <editorialDecl>
 <p>
 <list>
  <item>Correction:</item> 
  <item>Normalization:</item> 
  <item>Quotation:</item> 
  <item>Hyphenation:</item> 
  <item>Interpretation:</item> 
  </list>
  </p>
  </editorialDecl>
  
  <tagsDecl>
</tagsDecl>

  </encodingDesc>
  <profileDesc>
 <langUsage>
  <p><foreign id="Latijn">Latijn</foreign><foreign id="Duits">Duits</foreign><foreign id="Engels">Engels</foreign><foreign id="Frans">Frans</foreign>
  </p>
 </langUsage>
</profileDesc>
  </teiHeader>
<xsl:if test="contains($text,'doclin') and substring($document,4,1) = 'M' and $trans!='yes'">
  <xsl:apply-templates select="descendant::text[@id=substring($document,1,5)]"/>
 </xsl:if>
 <!-- P's zonder varianten -->
  <xsl:if test="contains($text,'doclin') and substring($document,4,2) = 'P1' and $trans!='yes'">
  <xsl:apply-templates select="descendant::text[@id=substring($document,1,5)]"/>
 </xsl:if>
 <!-- M's met varianten -->
 <xsl:if test="contains($text,'doclin') and substring($document,4,1) = 'M' and $trans='yes'">
  <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </xsl:if>
  <!-- P's met varianten -->
 <xsl:if test="contains($text,'doclin') and substring($document,4,2) = 'P1' and $trans='yes'">
  <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </xsl:if>
 <!-- De rest -->
  <xsl:if test="contains($text,'doclin') and substring($document,4,1) != 'M' and substring($document,4,2) != 'P1'">
   <xsl:apply-templates select="descendant::text[@id= concat(substring($document,1,3), 'DD')]"/>
 </xsl:if>
 <!-- de facs en zo -->
 <xsl:if test="contains($text,'docfacs')">
<text><xsl:attribute name="id"><xsl:value-of select="$document"/></xsl:attribute>
  <figure><xsl:attribute name="id"><xsl:value-of select="substring($document,1,5)"/>-<xsl:value-of select="$page"/></xsl:attribute></figure>
 </text>
 </xsl:if>
 <xsl:if test="$text='overlevering'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='gebruiksaanwijzing'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='inleiding'"><xsl:apply-templates/></xsl:if>
 <xsl:if test="$text='colofon'"><xsl:apply-templates/></xsl:if>
</TEI.2>
</xsl:template>

<xsl:template match="*|@*|comment()|text()">
<xsl:copy>
<xsl:apply-templates select="*|@*|comment()|text()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="teiHeader">
<!-- <xsl:value-of select="."/> -->
</xsl:template>

<xsl:template match="text">
<xsl:param name="segn" select="//seg[@n = $n]/@n"/>
<xsl:choose>
 <xsl:when test="$text='doclin'">
<text><xsl:attribute name="id"><xsl:value-of select="$document"/></xsl:attribute>
 <xsl:apply-templates/>
</text>
</xsl:when>
 <xsl:when test="$text='doclinlay' and n=''">
<text><xsl:attribute name="id"><xsl:value-of select="$document"/></xsl:attribute>
 <xsl:apply-templates/>
</text>
</xsl:when>
<!-- apparaat -->
  <xsl:when test="$text='doclinapp'">
  <text><xsl:attribute name="id"><xsl:value-of select="$document"/></xsl:attribute>
  <body>
  <div>
  <head>Apparaat</head>
  <div1>
  <head>Synopsis:</head>
  <xsl:for-each select="//app[@n=$app][1]/rdg">
  <xsl:if test="$comp1=''">
  <p><hi rend="bold"><xsl:if test="contains(@wit,'AdsZ')"><xsl:value-of select="substring-before(@wit,'AdsZ')"/></xsl:if><xsl:if test="not(contains(@wit,'AdsZ'))"><xsl:value-of select="@wit"/></xsl:if></hi><lb/>
  <xsl:if test="substring(@wit,1,6) != ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,6)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="substring(@wit,1,6) = ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  </p>
  </xsl:if>
  
  <xsl:if test="$comp1!=''">
  <xsl:if test="contains(@wit,$comp2) or contains(@wit,$comp1)">
  <p><hi rend="bold"><xsl:if test="$comp1!='' and contains(@wit,$comp1)"><xsl:if test="substring($comp1,4,1) = 'Z'"><xsl:value-of select="substring(concat('Ads',substring($comp1,5,2),substring-after(@wit,substring($comp1,5,2))),1,6)"/></xsl:if><xsl:if test="substring($comp1,4,1) != 'Z'"><xsl:value-of select="$comp1"/></xsl:if></xsl:if><xsl:if test="$comp2!='' and contains(@wit,$comp2)"><xsl:if test="substring($comp2,4,1) = 'Z'"><xsl:value-of select="substring(concat('Ads',substring($comp2,5,2),substring-after(@wit,substring($comp2,5,2))),1,6)"/></xsl:if><xsl:if test="substring($comp2,4,1) != 'Z'"><xsl:value-of select="$comp2"/></xsl:if></xsl:if></hi><lb/>
  <xsl:if test="substring(@wit,1,6) != ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,6)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="substring(@wit,1,6) = ' '"><xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="substring(@wit,1,5)"/></xsl:apply-templates></xsl:if>
  </p>
  </xsl:if>
  </xsl:if>
  </xsl:for-each>
  </div1>
  <div1>
  <head>Versies:</head>
  <xsl:for-each select="front//witness">
  <xsl:if test="//app[@n=$app]/rdg[1][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[2][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[3][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[4][not(contains(@wit,current()/@n))] and //app[@n=$app]/rdg[5][not(contains(@wit,current()/@n))]"></xsl:if>
  <xsl:if test="//app[@n=$app]/rdg[1][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[2][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[3][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[4][contains(@wit,current()/@n)] or //app[@n=$app]/rdg[5][contains(@wit,current()/@n)]">
  <p><hi rend="bold"><xsl:if test="ancestor::TEI.2//app[@n=$app]/rdg[contains(@wit,@sigil)]"><xsl:if test="substring($comp1,4,1) ='Z' or substring($comp2,4,1) = 'Z'"><xsl:if test="contains(@n,concat('Ads',substring($comp2,5,2))) or contains(@n,concat('Ads',substring($comp1,5,2))) "></xsl:if></xsl:if><xsl:if test="$comp1 = @n or $comp2 = @n"></xsl:if><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</xsl:if></hi>:<lb/>
    <xsl:apply-templates select="//seg[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
    <xsl:if test="ancestor::TEI.2//head/app[@n=$app]"><xsl:apply-templates select="//head[descendant::app[@n=$app]]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></xsl:if>
    <!-- toon schrijfproces 
    <xsl:if test="@n='AdsM1'">
    <lb/>[<a><xsl:if test="$export='print'"><xsl:attribute name="onclick">return false</xsl:attribute></xsl:if><xsl:attribute name="href">zin.htm?text=doclinlay&amp;document=AdsM1&amp;n=<xsl:value-of select="//text[@id='AdsM1']//seg[@base=ancestor::TEI.2//seg[descendant::app[@n=$app]]/@id]/@n"/>&amp;id=<xsl:value-of select="//text[@id='AdsM1']//seg[@base=ancestor::TEI.2//seg[descendant::app[@n=$app]]/@id]/@id"/>&amp;corresp=<xsl:value-of select="//text[@id='AdsM1']//seg[@base=ancestor::TEI.2//seg[descendant::app[@n=$app]]/@id]/@type"/></xsl:attribute>toon schrijfproces</a>]
    </xsl:if>-->
  </p>
  </xsl:if>
  </xsl:for-each>
  </div1>
  </div>
  </body>
  </text>
  </xsl:when>
  <xsl:when test="$text='doclinlay' and $n!=''">
  <text><xsl:attribute name="id"><xsl:value-of select="$document"/></xsl:attribute>
  <body>
  <div>
  <head>Schrijfproces</head>
<xsl:for-each select="ancestor::TEI.2//text[@id='AdsDD']//front//witness[@n = 'AdsM1']">
<p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:</p>
</xsl:for-each>
<xsl:apply-templates select="//num"/>

<!-- apparaat -->
<xsl:for-each select="ancestor::TEI.2//text[@id='AdsDD']//front//witness[@n != 'AdsM1']">
<xsl:if test="contains($document,'AdsM')">
<xsl:if test="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]//app/rdg[contains(@wit,current()/@sigil)]">
  <p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/>
    <xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
  </p>
</xsl:if>
</xsl:if>
<xsl:if test="not(contains($document,'AdsM'))">
<xsl:if test="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]//app/rdg[contains(@wit,current()/@sigil)]">
  <p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/>
    <xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates>
  </p>
</xsl:if>
</xsl:if>
<!-- als er geen variatie is -->
<!-- voor de M'n -->
<xsl:if test="contains($document,'AdsM')">
<xsl:if test="not(ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]//app)">

<xsl:if test="substring(@n,6,1) = ''"><p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/>
<xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></p></xsl:if>
    

<xsl:if test="substring(@n,6,1) = 'a'"><p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/><xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspseg]"><xsl:with-param name="wit" select="concat(substring(@n,1,5), 'a')"/></xsl:apply-templates></p></xsl:if>

<xsl:if test="substring(@n,6,1) != 'a' and substring(@n,6,1) != ''"></xsl:if>
  
</xsl:if>
</xsl:if>
<!-- voor de Niet M'en -->
<xsl:if test="not(contains($document,'AdsM'))">
<xsl:if test="not(ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]//app)">

<xsl:if test="substring(@n,6,1) = ''"><p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/>
<xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="@n"/></xsl:apply-templates></p></xsl:if>
    

<xsl:if test="substring(@n,6,1) = 'a'"><p><hi rend="bold"><xsl:value-of select="text()"/> [<xsl:value-of select="@n"/>]</hi>:<lb/><xsl:apply-templates select="ancestor::TEI.2//text[@id='AdsDD']//seg[@base=$correspsegDD]"><xsl:with-param name="wit" select="concat(substring(@n,1,5), 'a')"/></xsl:apply-templates></p></xsl:if>

<xsl:if test="substring(@n,6,1) != 'a' and substring(@n,6,1) != ''"></xsl:if>
  
</xsl:if>
</xsl:if>
</xsl:for-each>

</div>
</body>
</text>
  </xsl:when>
 <xsl:otherwise>
  <xsl:apply-templates/>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- STATIC CONVERSION 2026-03-10: added conditionals to check for each attribute if it exists in source and is not empty -->
<xsl:template match="seg">
<xsl:param name="wit"/>
<xsl:param name="ana"/>
<seg>
<xsl:if test="@n and @n!=''"><xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute></xsl:if>
<xsl:if test="@id and @id!=''"><xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute></xsl:if>
<xsl:if test="@type and @type!=''"><xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:if>
<xsl:if test="@base and @base!=''"><xsl:attribute name="base"><xsl:value-of select="@base"/></xsl:attribute></xsl:if>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates>
</seg>
</xsl:template>

<xsl:template match="num">
<xsl:if test="current() &lt;= $corresp">
<xsl:call-template name="div"><xsl:with-param name="ana" select="current()"/></xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template name="div">
<xsl:param name="ana"/>
<xsl:param name="inkt" select="ancestor::TEI.2//text[@id='AdsM1']//seg[@n=$n]//node()[substring-after(@layer,'l') = $ana]/@rend[. != 'zwarte inkt']"/>
<xsl:param name="alphabet" select="'abcdefghijklmnopqrstuvwxyz'"/>
<!-- stappen -->
<p>
  <xsl:if test="$ana=$corresp">Resultaat</xsl:if><xsl:if test="$ana!=$corresp">Stap <xsl:if test="starts-with($ana,'0')"><xsl:value-of select="substring($alphabet,substring($ana,2)+1,1)"/></xsl:if><xsl:if test="not(starts-with($ana,'0'))"><xsl:value-of select="substring($alphabet,$ana+1,1)"/></xsl:if></xsl:if> <xsl:if test="$inkt != 'zwarte inkt' and $inkt !='u'"><xsl:text> </xsl:text> [bevat een nieuwe laag: <xsl:value-of select="$inkt"/>]</xsl:if><lb/>
  <xsl:if test="contains($document,'AdsM')">
  <xsl:if test="$ana=$corresp"><xsl:apply-templates select="$seg"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="'toplayer'"/></xsl:apply-templates><lb/></xsl:if>
  <xsl:if test="$ana!=$corresp"><xsl:apply-templates select="$seg"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates><lb/></xsl:if>
  </xsl:if>
  <xsl:if test="not(contains($document,'AdsM'))">
  <xsl:if test="$ana=$corresp"><xsl:apply-templates select="$segdd"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="'toplayer'"/></xsl:apply-templates><lb/></xsl:if>
  <xsl:if test="$ana!=$corresp"><xsl:apply-templates select="$segdd"><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates><lb/></xsl:if>
  </xsl:if>
</p>
</xsl:template>

<xsl:template match="app">
<xsl:param name="wit"/>
<xsl:param name="ana"/>
<app><xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute>
<xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates>
</app>
</xsl:template>

<xsl:template match="rdg">
<xsl:param name="wit"/>
<xsl:param name="ana"/>
<xsl:choose>
 <xsl:when test="$text='doclinapp' and parent::app[@n=$app]">
  <xsl:if test="contains(@wit,$wit)">
    <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg>
  </xsl:if>
 </xsl:when>
 <xsl:when test="$text='doclinapp' and not(parent::app[@n=$app])">
    <xsl:if test="contains(@wit,$wit)"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg></xsl:if>
    <xsl:if test="not(contains(@wit,$wit)) and contains(@wit,substring($wit,1,5)) and not(preceding-sibling::rdg[contains(@wit,$wit)]) and not(following-sibling::rdg[contains(@wit,$wit)])"> <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg>
  </xsl:if>
 </xsl:when>
  <xsl:when test="$text='doclinlay' and contains(@wit,$wit) and $n!=''">
  <!-- normaal -->
  <xsl:if test="not(contains(substring(@wit,1,6),$wit))"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg></xsl:if>
  <!-- wann. eerst voorkomt op 2e niveau-->
  <xsl:if test="ancestor::rdg[not(contains(substring(@wit,1,6),$wit))] and contains(substring(@wit,1,6),$wit)"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg></xsl:if>
  <xsl:if test="ancestor::rdg[contains(substring(@wit,1,6),$wit)] and contains(substring(@wit,1,6),$wit)"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></rdg></xsl:if>
  <!-- wann. eerst voorkomt op 1e niveau -->
  <xsl:if test="not(ancestor::rdg) and contains(substring(@wit,1,6),$wit)"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg></xsl:if>
 </xsl:when>
  <xsl:when test="$text='doclinlay' and not(contains(@wit,$wit)) and contains(@wit,substring($wit,1,5)) and not(preceding-sibling::rdg[contains(@wit,$wit)]) and not(following-sibling::rdg[contains(@wit,$wit)]) and $n!=''">
  <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="ana" select="$ana"/></xsl:apply-templates></rdg>
  </xsl:when>
 <xsl:when test="$text='doclinapp' and not(parent::app[@n=$app])">
    <xsl:if test="contains(@wit,$wit)"><rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="wit" select="$wit"/></xsl:apply-templates></rdg></xsl:if>
 </xsl:when>
 <xsl:otherwise>
 <xsl:if test="contains(@wit,concat($document, ' ')) and $trans='yes'">
  <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates/></rdg>
 </xsl:if>
 <xsl:if test="$text!='doclinlay' and $trans!='yes' and contains(@wit,concat($document, ' '))">
  <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates/></rdg>
 </xsl:if>
  <xsl:if test="$text='doclin' and $trans='yes' and not(contains(@wit,concat($document, ' '))) and contains(@wit,substring($document,1,5))">
  <rdg><xsl:attribute name="wit"><xsl:value-of select="@wit"/></xsl:attribute><xsl:apply-templates/></rdg>
 </xsl:if>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- STATIC CONVERSION 2026-03-10: added conditionals to check for each attribute if it exists in source and is not empty -->
<xsl:template match="del">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:choose>
 <xsl:when test="$n!=''">
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <!-- <xsl:apply-templates/> -->
 </xsl:if>
   <xsl:if test="not(substring-after(@layer,'l'))">
   <del>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@type and @type!=''"><xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </del>
 </xsl:if>
  <xsl:if test="substring-after(@layer,'l') = $ana">
   <del>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@type and @type!=''"><xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </del>
 </xsl:if> 
 <xsl:if test="substring-after(@layer,'l') &gt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
 </xsl:if>
 </xsl:when>
 <xsl:otherwise>
  <del>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@type and @type!=''"><xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </del>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- STATIC CONVERSION 2026-03-10: added conditionals to check for each attribute if it exists in source and is not empty -->
<xsl:template match="add">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:choose>
 <xsl:when test="$n!=''">
  <xsl:if test="not(substring-after(@layer,'l'))">
   <add>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@place and @place!=''"><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') = $ana">
   <add>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@place and @place!=''"><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
   </xsl:when>
 <xsl:otherwise>
   <add>
    <xsl:if test="@rend and @rend!=''"><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:if test="@place and @place!=''"><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute></xsl:if>
    <xsl:if test="@hand and @hand!=''"><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute></xsl:if>
    <xsl:if test="@resp and @resp!=''"><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute></xsl:if>
    <xsl:if test="@layer and @layer!=''"><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute></xsl:if>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!--<xsl:template match="add/add">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:choose>
 <xsl:when test="$n!=''">
  <xsl:if test="substring-after(@layer,'l') = $ana">
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:if>
  <xsl:if test="not(substring-after(@layer,'l'))">
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>  
   </xsl:when>
 <xsl:otherwise>
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="add/add/add">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:choose>
 <xsl:when test="$n!=''">
  <xsl:if test="substring-after(@layer,'l') = $ana">
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:if>
      <xsl:if test="not(substring-after(@layer,'l'))">
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
 </xsl:if>
 <xsl:if test="substring-after(@layer,'l') &lt; $ana">
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
  </xsl:if>
 </xsl:when>
 <xsl:otherwise>
   <add><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute><xsl:attribute name="place"><xsl:value-of select="@place"/></xsl:attribute><xsl:attribute name="hand"><xsl:value-of select="@hand"/></xsl:attribute><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="ana"><xsl:value-of select="@layer"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
   </add>
  </xsl:otherwise>
 </xsl:choose>  
</xsl:template>
-->

<!-- Unclear -->
<xsl:template match="unclear">
<xsl:param name="ana"/><xsl:param name="view"/><unclear><xsl:attribute name="resp"><xsl:value-of select="@resp"/></xsl:attribute><xsl:attribute name="reason"><xsl:value-of select="@reason"/></xsl:attribute><xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates></unclear></xsl:template>

<!-- highlighted text -->
<xsl:template match="hi">
<xsl:param name="ana"/>
<xsl:param name="view"/>
<xsl:param name="wit"/>
<hi><xsl:attribute name="rend"><xsl:value-of select="@rend"/></xsl:attribute>
    <xsl:apply-templates><xsl:with-param name="ana" select="$ana"/><xsl:with-param name="wit" select="$wit"/><xsl:with-param name="view" select="$view"/></xsl:apply-templates>
</hi>
</xsl:template>

<!-- pb  -->
<xsl:template match="pb">
<xsl:if test="contains(@ed,$document)">
<pb><xsl:attribute name="ed"><xsl:value-of select="@ed"/></xsl:attribute><xsl:attribute name="n"><xsl:value-of select="@n"/></xsl:attribute><xsl:attribute name="corresp"><xsl:value-of select="@corresp"/></xsl:attribute>
</pb>
</xsl:if>
</xsl:template>
</xsl:stylesheet>
