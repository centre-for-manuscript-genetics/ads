//Disable right mouse click Script
//By Maximus (maximus@nsimail.com) w/ mods by DynamicDrive
//For full source code, visit http://www.dynamicdrive.com

///////////////////////////////////

function show_contextmenu(event){
 var txt = '';
     if (window.getSelection)
    {
        txt = window.getSelection();
             }
    else if (document.getSelection)
    {
        txt = document.getSelection();
            }
    else if (document.selection)
    {
        txt = document.selection.createRange().text;
            }
    else return;
var message="Zoeken naar '" + txt + "'?";
var answer = confirm(message)
        if (answer){
                window.location = "http://localhost:9999/exist/xquery/search.xq?woord=" + txt;
        }
        else{
        }

}
function clickIE4(){
var message="Zoeken naar '" + txt + "'?";
if (event.button==2){
 var answer = confirm(message)
        if (answer){
                window.location = "http://localhost:9999/exist/xquery/search.xq?woord=" + txt;
        }
        else{
        }
}
}

function clickNS4(e){
var message="Zoeken naar '" + txt + "'?";
if (document.layers||document.getElementById&&!document.all){
if (e.which==2||e.which==3){
 var answer = confirm(message)
        if (answer){
                window.location = "http://localhost:9999/exist/xquery/search.xq?woord=" + txt;
        }
        else{
        }

}
}
}

if (document.layers){
document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=clickNS4;
}
else if (document.all&&!document.getElementById){
document.onmousedown=clickIE4;
}

//document.oncontextmenu=new Function("confirm(message);return false")
