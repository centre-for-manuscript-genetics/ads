xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

(: Namespace for the local functions in this script :)
declare namespace f="http://exist-db.org/xquery/local-functions";

<document xmlns:xi="http://www.w3.org/2001/XInclude">
   	
    <header>
        <title>Achter de Schermen</title>
	    <author email="wolfgang@exist-db.org">Wolfgang M. Meier</author>
        <style href="styles/ads.css"/>
	<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<script type="text/javascript" src="styles/chrome.js"></script>
	 <script language="Javascript" src="styles/query.js"></script>
	 <script language="Javascript" src="styles/rightclick.js"></script>
    </header>    

    <!-- include sidebar -->
   <xi:include href="sidebar.xml"/> 

    <body>     <center><div style="width:802px;border-left: 1px solid #660011;border-right: 1px solid #660011;border-bottom: 1px solid #660011;margin-top:0px;background-color:#DDDDDD;">
<table width="100%">
<tr><td>
<form xmlns:xi="http://www.w3.org/2001/XInclude" action="http://localhost:9999/exist/xquery/process.xq" onSubmit="defineQuery()" method="post" name="xquery">
<table class="query" width="800">
<tr>
<td colspan="2"><input type="hidden" name="collection" value="/db/ads"/></td>
</tr>
<tr>
<td colspan="2"><h2>Zoek</h2>
<!--Choose text: </select><br/><select name="text"></select>-->
<br/><br/><br/><div style="float:right;margin-right:30px; border:1px dotted #660011;padding: 10px 10px 10px 10px;"><span class="label">Zoek naar:</span>


<input name="searchterm" value="{request:request-parameter("woord", ())}" id="searchterm"/>
<input name="type" value="quick" type="hidden"/>
<!--<input name="collection" type="hidden" value="/db/search"/>--><input type="hidden" name="language" value="EN"/>
in
<select name="tag"><option value="//seg[near(., $searchterm, 1)]">de tekst</option><option value="//seg[near(., $searchterm, 1)]//seg[descendant::add[near(., $searchterm, 1)]]">een toevoeging</option><option value="//seg[near(., $searchterm, 1)]//seg[descendant::del[near(., $searchterm, 1)]]">een schrapping</option></select>
<input name="query" type="hidden"></input> <input type="submit" value="Zoek!"/><br/>Hits per pagina:<select name="howmany" size="1"><option>10</option><option selected="*">20</option><option>50</option></select></div></td>
</tr>
<tr>
<td align="left"><br/><br/><br/><br/><br/><br/><br/><br/></td><td align="right"><span class="label"></span>
<br/>
</td>
</tr>
</table>
</form>
</td></tr></table>
   </div></center>
    </body>

</document>
