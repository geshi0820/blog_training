//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require turbolinks
//= require_tree .

if(window.addEventListener) {
	window.addEventListener( "load" , shareButtonReadSyncer, false );
}else{
	window.attachEvent( "onload", shareButtonReadSyncer );
}
function shareButtonReadSyncer(){

(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/ja_KS/sdk.js#xfbml=1&appId=1554647058123921&version=v2.3";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
}