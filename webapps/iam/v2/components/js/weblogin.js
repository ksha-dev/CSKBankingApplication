//$Id$
var qrimage,qrtoken,wmsid,qrvalidity;
var reload_page ="";
var wmscount = 0;
var _time;
var verifyCount = 0;
var totalCount = 0;
var isWmsRegistered = false;
var RestrictBtnErrorCode;
var qrstate = 0;
document.addEventListener('keydown', function(e){
    if (e.key === 'Escape' && qrstate==1) {
        closeQRview();
        statechange();
    }
});
var I18N = {
		data : {},
		load : function(arr) {
			$.extend(this.data, arr);
			return this;
		},
		get : function(key, args) {
			// { portal: "IAM.ERROR.PORTAL.EXISTS" }
			if (typeof key == "object") {
				for ( var i in key) {
					key[i] = I18N.get(key[i]);
				}
				return key;
			}
			var msg = this.data[key] || key;
			if (args) {
				arguments[0] = msg;
				return Util.format.apply(this, arguments);
			}
			return msg;
		}
};
function isVerifiedFromDevice() {
	if (isWmsRegistered === false && isValid(wmsid) && wmsid != "undefined") {
		try {
			WmsLite.setClientSRIValues(wmsSRIValues);
			WmsLite.setNoDomainChange();
			WmsLite.registerAnnon('AC', wmsid); // No I18N
			isWmsRegistered = true;

		} catch (e) {
			// no need to handle failure
		}
	}
	if (verifyCount > 15) {
		return false;
	}
	clearInterval(_time);
	var webloginurl = "/signin/v2/qrcode?"+loginParams;// no i18n
	$.ajax({
		type : "PUT",// no i18n
		url : webloginurl,
		data : JSON.stringify({'qrcodeauth':{'remember':$("#remember").is(":checked") }}), // no i18n
		headers : {
			"Z-Authorization" : "Zoho-ticket "+qrtoken,// no i18n
			'X-ZCSRF-TOKEN' : csrfParam+'='+euc(getCookie(csrfCookieName))// no i18n
		},
		async : false,
		success : function(data) {
			VerifySuccess(data);
		}
	});
	verifyCount++;
	if(isValid(wmsid) && wmsid!="undefined"){
		wmscount++;
		var callIntervalTime = wmscount < 6 ? 5000 : 25000;
		_time = setInterval(isVerifiedFromDevice, callIntervalTime);
		return false;
	}else{
		_time = setInterval(isVerifiedFromDevice, 3000);
	}
	return false;
}
function VerifySuccess(data) {
	if (data.qrcodeauth) {
		localStorage.setItem("isZohoSmartSigninDone","true");// no i18n
		if(qrstate){localStorage.setItem("isExpandedQR","true")}else if(localStorage && localStorage.getItem("isExpandedQR")){localStorage.removeItem("isExpandedQR")}// no i18n
		switchto(data.qrcodeauth.redirect_uri);
	}
	smartSignin ? handleSmartsignin(data):handleArattai(data);
	return false;
}
function switchto(url) {
	if (url.indexOf("http") != 0) { // Done for startsWith(Not supported in IE)
									// Check
		var serverName = window.location.origin;
		if (!window.location.origin) {
			serverName = window.location.protocol + "//"+ window.location.hostname+ (window.location.port ? ':' + window.location.port : '');
		}
		if (url.indexOf("/") != 0) {
			url = "/" + url;
		}
		url = serverName + url;
	}
	window.top.location.href = url;
}
function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}
function euc(i) {
	return encodeURIComponent(i);
}
function hideReload(){
	if($('.smartsign-initial-loading').css('display') == 'none'){
		$(".qr-reload-container").fadeOut(100);
		$('.smartsign-initial-loading').css('display','inline-block');
		$(".expand_qr span").css("opacity","").css("cursor","pointer");
		$(".qr_act_view").attr("onclick","expandQRview()");
		
	}else{
		$(".qr-reload-container").fadeOut();
	}
}
function showReload() {
	$(".qr-reload-container").css("display","flex").hide().fadeIn();
	$(".qr-container-dom").css("opacity","0.2");
	$(".expand_qr span").css("opacity","0.4").css("cursor","default");
	$(".qr_act_view").attr("onclick","");
	$(".expand_qr").hide();
	closeQRview();
}
function generateQrcode(){
	clearInterval(_time);
	verifyCount = 0;
	$.ajax({
      type: "POST",//No i18N
      url: "/signin/v2/qrcode?"+loginParams,//No i18N
	  data : JSON.stringify({'qrcodeauth':{'remember':$("#remember").is(":checked") }}), // no i18n
      headers : {
			'X-ZCSRF-TOKEN' : csrfParam+'='+euc(getCookie(csrfCookieName))// no i18n
      },
      async : "true",
      success: function(data){
    	isWmsRegistered = false;
    	qrimage = data.qrcodeauth && data.qrcodeauth.img;
    	qrtoken = data.qrcodeauth && data.qrcodeauth.token;
    	wmsid = data.qrcodeauth && data.qrcodeauth.wmsid;
    	isVerifiedFromDevice();
    	qrvalidity = data.qrcodeauth && data.qrcodeauth.validity;
    	window.setTimeout(showReload, qrvalidity);
    	$("#qr_container_dom").attr("src", qrimage);//no i18n
    	$("#qr_container_dom2").attr("src",qrimage);//no i18n
    	$(".qr-container-dom").css("opacity","1");
    	if($('.smartsign-initial-loading').is(':visible')){
    		$("#qr_container_dom").css("opacity","1");
    		$('.smartsign-initial-loading').css('display','none');
    		$(".qr_act_view").attr("onclick","expandQRview()");
    		$(".expand_qr").css("display","flex");
    		if(qrstate == 1){expandQRview();}
    	}
     }
	});
	return false;
}
function handleSmartsignin(data){
	var errorcode = data.errors && data.errors[0] && data.errors[0].code;
	if(errorcode==="R303" || errorcode==="SI508" || errorcode==="U404" || errorcode==="SI503" ||  errorcode==="D105"){ 
		handleRestricSignin(errorcode,data.localized_message);
	}
	return false;
}
function handleArattai(data){
	return false;
}
function getCookie(cookieName) {
	var nameEQ = cookieName + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i].trim();
		if (c.indexOf(nameEQ) == 0) {
			return c.substring(nameEQ.length, c.length)
		}
		;
	}
	return null;
}
function checkCookie() {
	if(isValid(getCookie(iam_reload_cookie_name))) {
        window.location.reload();
    }
}
function setCookie(x){
	var dt=new Date();
	dt.setDate(dt.getYear() * x);
	var cookieStr = "IAM_TEST_COOKIE=IAM_TEST_COOKIE;expires="+dt.toGMTString()+";path=/;"; //No I18N
	if(cookieDomain != "null"){
		cookieStr += "domain="+cookieDomain; //No I18N
	}
	document.cookie = cookieStr;
}
function onSigninReady(){
	reload_page =setInterval(checkCookie, 5000);
	setCookie(24);
	if(document.cookie.indexOf("IAM_TEST_COOKIE") != -1){ // cookie is Enabled
        setCookie(0);
        $('#enableCookie').hide();
    } else { // cookie is disabled
        $('.signin_container,#signuplink,.banner_newtoold').hide();
        $('#enableCookie').show();
    }
	if(localStorage && localStorage.getItem("isExpandedQR")){expandQRview()}
}
function RestrictSigninRedirect(){
	if(RestrictBtnErrorCode == "R303"||RestrictBtnErrorCode == "U404"){
		window.location.reload();
	}else if(RestrictBtnErrorCode == "SI508"||RestrictBtnErrorCode == ""){ //No I18N
		gotosignin();
	}
	return false;
}
function handleRestricSignin(ErrorCode,Localized_msg){
	if(qrstate == 1){
		$(".container_expand").hide();
		$(".greylayer").css("display","none");
	}
	$('#signin_div,.rightside_box').hide();
	var ErrorCodeVAl = ErrorCode=="R303"?$(".restrict_head").html(I18N.get("IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER")):ErrorCode=="SI508"?$(".restrict_head").html(I18N.get("IAM.NEW.SIGNIN.RESTRICT.SIGNIN.ONEAUTH.TITLE")):ErrorCode=="U404"?$(".restrict_head").html(I18N.get("IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE")):$(".restrict_head").html("");//No I18N
	$(".restrict_desc").html(Localized_msg);
	var restrictPageBtn = ErrorCode=="R303" || ErrorCode=="U404"?$("#restict_btn").html(I18N.get("IAM.TRY.AGAIN")):ErrorCode=="SI508"?$("#restict_btn").html(I18N.get("IAM.SMART.SIGNIN.BACKTO.EMAIL")):$("#restict_btn").hide();//No I18N
	RestrictBtnErrorCode = ErrorCode;
	$('.signin_box').css("border","none");
	$('#restrict_signin').show();
	$('.signin_container').addClass('mod_container');
	return false;
}
function expandQRview(){
	qrstate = 1;
	$(".greylayer").css("display","block");
	$(".container_expand").css("opacity","1").css("z-index","2");
	$(".container_expand").css("transform","scale(1.6)").css("transition","transform 0.3s ease-in-out");//No I18N
	$(".cancel_qr").css("transform","scale(0.65)").css("transition","transform 0.3s ease-in-out");//No I18N
	$(".cancel_qr span").css("transform","scale(1)").css("transition","0.3s ease-in-out");//No I18N
	$(".expand_qr span").css("transform","scale(0.65)").css("transition","0.3s ease-in-out");//No I18N
	if(!isDarkMode){$(".signin_container").css("border","1px solid #AFAFAF");}
}
function closeQRview(){
	$(".greylayer").css("display","none");
	$(".container_expand").css("opacity","0").css("z-index","-1");
	$(".container_expand").css("transform","scale(1)").css("transition","0.3s ease-in-out");//No I18N
	$(".cancel_qr span").css("transform","scale(1)").css("transition","0.3s ease-in-out");//No I18N
	$(".expand_qr span").css("transform","scale(1)").css("transition","0.3s ease-in-out");//No I18N
	$(".cancel_qr").css("transform","scale(1)").css("transition","transform 0.3s ease-in-out");//No I18N
	if(!isDarkMode){$(".signin_container").css("border","1px solid #DBDBDB");}
	if(localStorage && localStorage.getItem("isExpandedQR")){localStorage.removeItem("isExpandedQR")}
}
function statechange(){
	qrstate = 0;
}