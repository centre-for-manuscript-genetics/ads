function defineQuery()
{
var query = document.xquery.query;
query.value =  "let $searchterm := '*" + document.xquery.searchterm.value + "*' let $queryterm := " + document.xquery.tag.value + " return "  + document.xquery.tag.value;
}
