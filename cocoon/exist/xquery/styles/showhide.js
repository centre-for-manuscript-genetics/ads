window.onload=showhideme;
function showhideme(sh, divclass){
var divclass;

if(sh) {
disp="inline";
}else{
disp="none";

}

for (i=0; i<document.getElementsByTagName("*").length; i++) {
  if (document.getElementsByTagName("*").item(i).className == divclass){
   document.getElementsByTagName("*").item(i).style.display=disp;
  }
}

}

function showhideall(sh,pass){
var divs = document.getElementsByTagName('table'); 

if(sh) {
disp="inline";
}else{
disp="none";
}

for(i=0;i<divs.length;i++){ 
if(divs[i].id.match(pass)){
	divs[i].style.display=disp;

}
}
}
