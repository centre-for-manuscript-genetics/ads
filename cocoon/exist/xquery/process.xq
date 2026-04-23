xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

import module namespace utils="http://exist-db.org/xquery/collection-utils"
at "collections.xqm";

(: Namespace for the local functions in this script :)
declare namespace f="http://exist-db.org/xquery/local-functions";

(:  
    Display hits for the current page. The number of hits to print per page
    is read from parameter "howmany". Parameter "start" identifies the 
    current offset in the result set.
:)

declare function f:display($hits as item()*, $count as xs:int)
as element()+
{
let $language := request:request-parameter("language", ())
return
    if (empty($hits)) then
     if ($language eq 'FR') then
        <p>Aucun r&#x00E9;sultat trouv&#x00E9;! <a href="searchFR.html">Nouvelle recherche</a>.</p>
     else <p>Niets gevonden! <a href="http://localhost:9999/exist/xquery/search.xq">Terug naar het zoek formulier</a>.</p>
    else
        let $howmany := request:request-parameter("howmany", "10") cast as xs:int,
            $start := request:request-parameter("start", "1") cast as xs:int,
            $end := if ($start + $howmany le $count) then $start + $howmany - 1 else $count
        return (
            <div class="table">
            <table class="display" border="0" width="100%"
                cellspacing="0" cellpadding="4">               
                    
                { if ($type eq 'thorough') then
                 <tr>
                  <td colspan="3" align="left">
                    <p><font style="background-color:#FFFF00;">{if ($language eq 'FR') then "R&#x00E9;sultat exact" else "Exact match"}</font><br/>
                    <font style="background-color:#FF0000;">{if ($language eq 'FR') then "R&#x00E9;sultat possible" else "Possible match"}</font></p></td>
                 </tr>
                 else ()
                 }
                 <tr>
                    <td colspan="3" align="center">
                       &lt;<a href="http://localhost:9999/exist/xquery/search.xq">{if ($language eq 'FR') then "Nouvelle recherche" else "Nieuwe Zoekactie"}</a>&gt;
                    </td>
                </tr>
                { f:navbar($start, $end, $howmany, $count) }
            </table>
	    <div class="table">
	    <p><a href="javascript:showhideall(0,'xyz')">alles dichtklappen</a> - <a href="javascript:showhideall(1,'xyz')">alles openklappen</a></p>
		{    for $p in $start to $end
                     let $current := item-at($hits, $p),
                         $recurrent := if ($p eq $start) then item-at($hits, $p) else item-at($hits, $p - 1),
	                 $corresp := $current//seg/@corresp cast as xs:string,
			 $count2 := count($current//seg/@corresp eq $recurrent//seg/@corresp),
			 $docs := util:document-name($current),
			 $docid := util:document-id($current),
			 $textn := $current//seg/@textn,
                         $index := index-of($hits//seg/@corresp,$corresp),
                         $indexlast := $index[last()],
                         $indexfirst := $index[1],
			 $indextotal := $indexlast - $indexfirst + 1,
			 $c := $start to $end,
			 $style := if($p mod 2 eq 0) then "high" else "low"
                     (:order by $textn ascending:)
			 
                     return (
	                   <div><table border="0" width="100%" cellspacing="0" cellpadding="0">{if ($p eq $start) then <tr class="title"><td class="title" width="100%" colspan="3"><b>{if ($corresp eq 'AdsZM2') then "AdsM2 toplaag" else $corresp}</b>: {$indextotal} hit{if ($indextotal eq 1) then "" else "s"} <div style="float:right;vertical-align:top;"><a href="javascript:showhideme(0,'xyz{$corresp}');"><img class="minus" src="styles/minus.gif" border="0"/></a> <a href="javascript:showhideme(1,'xyz{$corresp}');"><img class="plus" src="styles/plus.gif" border="0"/></a></div></td></tr> else ""}
			    { if ($current//seg/@corresp eq $recurrent//seg/@corresp) then "" else <tr class="title" width="100%"><td width="100%" class="title" colspan="3"><b>{if ($corresp eq 'AdsZM2') then "AdsM2 toplaag" else $corresp}</b>: {$indextotal} hit{if ($indextotal eq 1) then "" else "s"} <div style="float:right;vertical-align:top;"><a href="javascript:showhideme(0,'xyz{$corresp}');"><img class="minus" src="styles/minus.gif" border="0"/></a> <a href="javascript:showhideme(1,'xyz{$corresp}');"><img class="plus" src="styles/plus.gif" border="0"/></a></div></td></tr>}</table>
		        
                        <table border="0" class="xyz{$corresp}" id="xyz" width="100%" cellspacing="0" cellpadding="0"><tr class="hits" width="100%">
                            <td valign="top" align="left" width="40" style="padding-left:5px;padding-right:5px;border-right:1px dotted #AEAEAE;border-bottom:1px dotted #AEAEAE;" class="position">{$p}</td>
                            <td colspan="2" width="96%" style="padding-left:10px;">
                                <xml-source><query>{$searchterm}</query><language>{$language}</language><type>{$type}</type>{$current}</xml-source>
                            </td>
                        </tr></table></div>
			
			)
			
                }
	    </div>(:<div style="d">{ f:retrieve-collections() }</div>:)
	    <table class="display" border="0" width="100%"
                cellspacing="0" cellpadding="0">
                { f:navbar($start, $end, $howmany, $count) }
		
                 <tr>
                    <td colspan="3" align="center">
                        &lt;<a href="http://localhost:9999/exist/xquery/search.xq">{if ($language eq 'FR') then "Nouvelle recherche" else "Nieuwe Zoekactie"}</a>&gt;
                    </td>
                </tr>
            </table></div>
             
        )
};	    

declare function f:retrieve-collections()
as element()+
{ 
    for $p in $start to $end
    let $current := item-at($hits, $p),
    $docs := util:document-name($current),
    $index := index-of($hits//seg/@corresp,$docs),
    $indexlast := $index[last()],
    $indexfirst := $index[1]
    return
        <h2>{$indexlast - $indexfirst + 1}</h2>
};

(: Display the navigation bar :)
declare function f:navbar($start as xs:int, $end as xs:int, 
$hitsPerPage as xs:int, $count as xs:int) as element() 
{
    let $uri := request:request-uri()
    return
        <tr class="navbar">
            <td align="left" width="7%">
                {
                    (: Link to previous page :)
                    if ($start gt 1) then
                        <a class="navbar" href="{$uri}?start={$start
                        - $hitsPerPage}&amp;howmany={$hitsPerPage}">&lt;&lt;</a>
                    else ()
                }
            </td>
            <td align="center" width="86%">
                {
                    (: Create page shortcuts :)
                    let $sections := $count idiv $hitsPerPage - 1,
                        $currentSection := $start idiv $hitsPerPage,
                        $lastSection :=
                            if ($sections lt 0) then 0 else
                                (: show 10 max unless current page > 10 :)
                                if ($sections gt 9) then 
                                    if ($currentSection gt 8) then $currentSection + 1
                                    else 9
                                else $sections
                    for $i in 0 to $lastSection
                    let $s := xs:int($i * $hitsPerPage + 1)
                    return 
                        if($i ne $currentSection) then
                            <a class="navbar"
                            href="{$uri}?start={$s}&amp;howmany={$hitsPerPage}&amp;searchterm={$searchterm}&amp;type={$type}&amp;language={$language}">
                                [{$i + 1}]
                            </a>
                        else
                            (: current page doesn't get a link :)
                            <b><span class="navbar">[{$i + 1}]</span></b>
                }
            </td>
            <td align="right" width="7%">
                {
                    (: Link to next page :)
                    if ($end lt $count) then
                        <a class="navbar" href="{$uri}?start={$end + 1}&amp;howmany={$hitsPerPage}">
                            &gt;&gt;
                        </a>
                    else ()
                }
            </td>
        </tr>
};

(: Auxiliary function called in add-to-history()
   to avoid having twice the same query in history
:)
declare function f:string-list-union(
   $list as xs:string*,
   $s as xs:string ) as xs:string*
{
  let $contains :=
    for $ss in $list
      return
        if ( $ss = $s ) then true
        else ""

  return
    if ( $contains ) then
      $list
    else
      ( $list, $s )
};

(:  Add the last query to the query-history. The history is
    stored in the session as an XQuery sequence.
:)
declare function f:add-to-history($query as xs:string) as empty()
{
    let $history := request:get-session-attribute("history")
    return
        request:set-session-attribute( "history",
                                       f:string-list-union($history, $query) )
};

declare function f:handleException() as element()+
{
	<h2>Defined server limits exceeded!</h2>,
	(
		if($util:exception eq
			"org.exist.xquery.TerminatedException$TimeoutException") then
			<p>The execution time of your search exceeded the predefined limits. 
			It has been forced to terminate.</p>
		else
			<p>The search exceeded the predefined size limits for 
			temporary document fragments and has been forced to 
			terminate.</p>
	),
	<p><b>Limits can be configured</b>! Please have a look at the
	"watchdog" section in the configuration file (conf.xml).</p>
};

declare function f:eval($query as xs:string) as element()+
{
	
	let $startTime := current-time(),
	$language := request:request-parameter("language", ()),
	        $searchterm := request:request-parameter("searchterm", ()),
		$collection := request:request-parameter("collection", ())
	return
		util:catch("org.exist.xquery.TerminatedException",
            util:catch("org.exist.xquery.XPathException",
                let	$result := util:eval($query, $collection),
                    $count := count($result),
                    $queryTime := current-time() - $startTime
                return 
		 if($language eq "EN") then (
                    <p>{$count} keer <i>{$searchterm}</i> gevonden 
                    ({seconds-from-duration($queryTime)} s).
                    {if($count gt 500) then "Max. 500 resultaten worden getoond." else ()}
                    </p>,
                    request:set-session-attribute(
                        "results", 
                        subsequence($result, 1, 500)
                    ),
                    f:add-to-history($query),
                    f:display($result, $count)
                 )
		    else (
                    <p>Trouv&#x00E9; {$count} r&#x00E9;sultats en
                    {seconds-from-duration($queryTime)} secondes.
                    {if($count gt 500) then "Max. 500 resultaten worden getoond." else ()}
                    </p>,
                    request:set-session-attribute(
                        "results", 
                        subsequence($result, 1, 500)
                    ),
                    f:add-to-history($query),
                    f:display($result, $count)
                 )
		,
                <p><b>Er is iets misgelopen: </b>{$util:exception-message}.</p>
            ),
			f:handleException()
		)
};

(:  The main function. If a query has been passed in parameter
    "query", execute the query and store the results into the
    session. If "query" is empty, try to retrieve the previous
    result set from the session.
:)
declare function f:main() as element()+
{   
    
    let $query := request:request-parameter("query", ()),
        $searchterm := request:request-parameter("searchterm", ()),
        $type := request:request-parameter("type", ()),
        $previous := request:get-session-attribute("results") 
    return
        if ($query) then
           f:eval($query)
        else if ($previous) then
            f:display($previous, count($previous))
        else
            <p>Please specify a query! <a href="http://localhost:9999/exist/xquery/search.xq">Back to search
            form</a>.</p>
};

<document xmlns:xi="http://www.w3.org/2001/XInclude">
   	
    <header>
        <title>Achter de Schermen</title>
	    <author email="wolfgang@exist-db.org">Wolfgang M. Meier</author>
        <style href="styles/ads.css"/>
	<script type="text/javascript" src="styles/chrome.js"></script><script type="text/javascript" src="styles/showhide.js"></script>
	<script type="text/javascript" src="styles/chrome.js"></script><script type="text/javascript" src="styles/rightclick.js"></script>
    </header>    

    <!-- include sidebar -->
   <xi:include href="sidebar.xml"/> 

    <body oncontextmenu="show_contextmenu(event);return false;">     <center><div style="width:802px;border-left: 1px solid #660011;border-right: 1px solid #660011;border-bottom: 1px solid #660011;margin-top:0px;background-color:#DDDDDD;">
      {let $language := request:request-parameter("language", ())
      return
        if ($language eq 'FR') then
        <section title="R&#x00E9;sultats"> </section>
	else
	<section title="Search Results"> </section>}
        { f:main() }
   </div></center>
    </body>

</document>
