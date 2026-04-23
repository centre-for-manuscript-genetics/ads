// Copyright J.M. Vanel 2003 - under GNU public licence
// jmvanel@free.fr
// Worldwide Botanical Knowledge Base
// http://wwbota.free.fr/
// $Header: /cvsroot/exist/eXist-1.0/webapp/xse/XPath-helper.js,v 1.3 2004/02/16 10:28:50 jmvanel Exp $

var inputID = "q";
function addCriterium(target) {
  var input = document.getElementById(inputID);
  var criterium = target.innerHTML;
  input.value += " " + criterium + ": ";
}

function addCriteriumPre(target) {
  var input = document.getElementById(inputID);
  var criterium = target.innerHTML;
  // alert( target );
  input.value += criterium;
}


function clearSearchField(){
  var input = document.getElementById(inputID);
  input.value = "";
}
