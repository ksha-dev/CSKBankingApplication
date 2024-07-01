//$Id$
var userPrimaryFactor,allowedmodes,prev_showmode,resendTimer,_time,secondarymodes,mobposition;
var isTroubleinVerify = isPasswordless = isWmsRegistered = isResend =false;
var verifyCount = 0,wmscount = 0;

function getCookie(cookieName) 
{
	var nameEQ = cookieName + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i].trim();
		if (c.indexOf(nameEQ) == 0) {return c.substring(nameEQ.length,c.length);}
	}
	return null;
}

function IsJsonString(str) {
	try {
		$.parseJSON(str);
	} catch (e) {
		return false;
	}
	return true;
}

function switchto(url){
	if(url.indexOf("http") != 0) { //Done for startsWith(Not supported in IE) Check
		var serverName = window.location.origin;
		if (!window.location.origin) {
			serverName = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
		}
		if(url.indexOf("/") != 0) {
			url = "/" + url;
		}
		url = serverName + url;
	}
	window.top.location.href=url;
}

function isValid(instr) 
{
    return instr != null && instr != "" && instr != "null";  //No i18N
}

function setFooterPosition(){
	var top_value = window.innerHeight-60;	
	if(30+$(".container")[0].offsetTop+$(".container")[0].offsetHeight<top_value){
		$("#footer").css("top",top_value+"px"); // No I18N
	}
	else{
		$("#footer").css("top",30+$(".container")[0].offsetTop+$(".container")[0].offsetHeight+"px"); // No I18N
	}
}
function sendRequestWithCallback(action, params, async, callback,method) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}	
	var serviceParam = "servicename=" + euc(service_name) + "&serviceurl=" + euc(service_url) + "&post="+post_action;	// No I18N
	action = action.indexOf("?") == -1 ? action +"?"+ serviceParam : action +"&"+ serviceParam;
	action = appendActionId(action);
	var objHTTP = xhr();
    objHTTP.open(method?method:'POST', action, async);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
    if(async){
	objHTTP.onreadystatechange=function() {
	    if(objHTTP.readyState==4) {
	    	if (objHTTP.status === 0 ) {
    			removeBtnLoading();
    			showErrorToast(I18N.get('IAM.PLEASE.CONNECT.INTERNET'));
    			return false;
			}
			if(callback) {
			    callback(objHTTP.responseText);
			}
	    }
	};
    }
    objHTTP.send(params);
    if(!async) {
	if(callback) {
            callback(objHTTP.responseText);
        }
    }
}

function pass_show_hide(){
	if($("#relogin_password_input").attr("type")=="password"){
		$("#relogin_password_input").attr("type","text");		//No I18N
		$(".pass_icon").addClass("icon-show");
	}	
	else{
		$("#relogin_password_input").attr("type","password"); //No I18N
		$(".pass_icon").removeClass("icon-show");
	}
	
}

function logoutFuntion(){
	window.location.href = contextpath+"/logout?serviceurl="+euc(service_url);
	return false;
}

function goToForgotPassword(){
	resetPassUrl = resetPassUrl + "?serviceurl="+euc(service_url); //No I18N
	if(window.location.search.indexOf("darkmode=true") > -1 ){
		resetPassUrl+="&darkmode=true"; //No I18N
	}
	var LOGIN_ID = de('login_id').innerText.trim(); // no i18n
	if(de('login_id') && (isUserName(LOGIN_ID) || isEmailId(LOGIN_ID) || isPhoneNumber(LOGIN_ID.split("-")[1]))){
		var oldForm = document.getElementById("recoveryredirection");
		if(oldForm) {
			document.documentElement.removeChild(oldForm);
		}
		var form = document.createElement("form");
		form.setAttribute("id", "recoveryredirection");
		form.setAttribute("method", "POST");
	    form.setAttribute("action", resetPassUrl);
    	form.setAttribute("target", "_parent");
		
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "LOGIN_ID");
		hiddenField.setAttribute("value", LOGIN_ID ); 
		form.appendChild(hiddenField);
        		
	   	document.documentElement.appendChild(form);
	  	form.submit();
	  	return false;
	}
	window.location.href = resetPassUrl;
}

function showAutheticationError(msg,field){
	$('#'+field+" .fielderror").html(msg);
	$('#'+field+" .fielderror").slideDown(300);
	return;
}

function remove_err(){
	$(".fielderror:visible").slideUp(300,function(){
		this.text="";
	});
}
function getToastTimeDuration(msg){
	var timing = (msg.split(" ").length) * 333.3;
	return timing > 3000 ? timing : 3000;
}
function showSuccessToast(msg){
	$(".alert_message").html(msg);
	$(".Alert").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Alert").css("top","-100px")},getToastTimeDuration(msg));
}
function showErrorToast(msg,link_ele){
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	if(link_ele){
		$(".Errormsg .helplink").show().html(link_ele);
		$(".Errormsg .error_close_icon").show();
	}
	else{
		window.setTimeout(function(){$(".Errormsg").css("top","-100px")},getToastTimeDuration(msg));
		$(".Errormsg .helplink,.Errormsg .error_close_icon").hide();
	}
}
function closeTopErrNotification(){
	$(".Errormsg").css("top","-100px");
}
function disableReauthBtn(){
	$("#reauth_button span").addClass("zeroheight");
	$("#reauth_button").addClass('changeloadbtn');
	$("#reauth_button").attr("disabled", true);
};
function removeBtnLoading(){
	$("#reauth_button span").removeClass("zeroheight");
	$("#reauth_button").removeClass("changeloadbtn");
	$("#reauth_button").attr("disabled", false);
}

function createandSubmitOpenIDForm(idpProvider) 
{
	if(idpProvider != null) 
	{
		var oldForm = document.getElementById(idpProvider + "form");
		if(oldForm) 
		{
			document.documentElement.removeChild(oldForm);
		}
		var form = document.createElement("form");
		var action = encodeURI("/accounts/sl/relogin/fs?provider="+idpProvider.toUpperCase()+"&post="+post_action); //No I18N
		action = appendActionId(action);
		var hiddenField = document.createElement("input");
   	    hiddenField.setAttribute("type", "hidden");
   	    hiddenField.setAttribute("name", csrfParam);//NO OUTPUTENCODING
        hiddenField.setAttribute("value", getCookie(csrfCookieName)); //NO OUTPUTENCODING
        form.appendChild(hiddenField);
		form.setAttribute("id", idpProvider + "form");
		form.setAttribute("method", "POST");
	    form.setAttribute("action", action);
	    form.setAttribute("target", "_parent");
	    var openIDProviders = 
	    {
       		"commonparams" : 						//No I18N
       		{
       			"servicename" : service_name,		//No I18N
    			"serviceurl" : service_url,			//No I18N
       		}
       	};
		if(isValid(idpProvider)) 
		{
    	    var params = openIDProviders.commonparams;
    	   	for(var key in params) 
    	   	{
    	   		if(isValid(params[key])) 
    	   		{
    	   			var hiddenField = document.createElement("input");
    	   			hiddenField.setAttribute("type", "hidden");
    	   			hiddenField.setAttribute("name", key);
    	   			hiddenField.setAttribute("value", params[key]);
    	   			form.appendChild(hiddenField);
    	   		}
    	   	}
    	   	document.documentElement.appendChild(form);
    	  	form.submit();
		}
	}
}

function appendActionId(url) {
	if(actionid) {
		url += ("&actionid=" + actionid); //No I18N
	}
	return url;
}
function verifyUserAuthFactor(frm){
	try{
		verifyUserAuthFactorValidation(frm)
	}
	catch(err){
		window.location.reload()
	}
	return false;
}
function verifyUserAuthFactorValidation(f){
	if(reloginAuthMode === "passkey" || reloginAuthMode === "passkeyreauth"){
		disableReauthBtn();
		enablePasskey();
		return false;
	}
	else if(reloginAuthMode === "password"){
		var passwd = f.current.value.trim();
		if(isEmpty(passwd)){
			$('#relogin #relogin_password_input').focus();
			showAutheticationError(I18N.get("IAM.ERROR.ENTER.LOGINPASS"),"password_container");	//No I18N
	    	return false;
		}
		disableReauthBtn();
		encryptData.encrypt([passwd]).then(function(encryptedpassword) {
			encryptedpassword = typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
			var jsonData = {"passwordreauth" : {"password" : encryptedpassword}}; //No I18N
			var passwordValidateUrl = "/relogin/v1/password";// : "//no i18N
			setTimeout(function(){sendRequestWithCallback(passwordValidateUrl,JSON.stringify(jsonData),true,passwordValidationCallback)},200);
			return false;
		}).catch(function(error){
			//TBD : Error should be handled
		});
		return false;
	}
	else if(reloginAuthMode === "saml"){
		enableSamlAuth();
		return false;
	}
	else if(reloginAuthMode === "totp"){
		var totp = de('mfa_totp_field_full_value').value.trim();		//No I18N
		if(isEmpty(totp)){
			showAutheticationError(I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"),"mfa_totp_container");	//No I18N
	    	return false;
		}
		if(totp.length != totp_size){
			showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"mfa_totp_container");	//No I18N
	    	return false;
		}
		var authURL = "/relogin/v1/totp/"+userAuthModes.totp.data.e_token;	//no i18N
		var jsonData = { 'totpreauth' : { 'code' : totp} };//no i18N
		disableReauthBtn();
		setTimeout(function(){sendRequestWithCallback(authURL,JSON.stringify(jsonData),true,validTotpCallback,"PUT")},200);
		return false;
	}
	else if(reloginAuthMode === "yubikey" || reloginAuthMode === "yubikeyreauth"){
		disableReauthBtn();
		enableSecurityKey();
		return false;
	}
	else if(reloginAuthMode === "jwt"){
		switchto(userAuthModes.jwt.data[0].redirect_uri);
		return false;
	}
	else if(reloginAuthMode === "otpreauth" ){ //no i18n 
		var OTP_CODE = $(f).find(".otp_input_box_full_value").val().trim();
		if(!isValid(OTP_CODE)){
			showAutheticationError(I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"),"otp_container");//No I18N
			return false;
		}
		else if(!isValidCode(OTP_CODE)){
			showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"otp_container");//No I18N
			return false;
		}
		var loginurl = "/relogin/v1/otp/"+emobile;//no i18N
	//	if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		var jsonData = { 'otpreauth' : { 'code' : OTP_CODE, 'is_resend' : false } };//no i18N
		disableReauthBtn();
		setTimeout(function(){sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,otpValidationCallback,"PUT")},200);//no i18n
		return false;
	}
	else if(reloginAuthMode=== "devicereauth"){ 
		var myzohototp;
		if(prefoption==="totp"){
			myzohototp = isTroubleinVerify ? $("#verify_totp_full_value").val().trim() : $("#mfa_totp_field_full_value").val().trim();
			if( !isValid(myzohototp) ){
				if(isTroubleinVerify){					
					showAutheticationError(I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"),"verify_totp_container");//No I18N
				}
				else{
					showAutheticationError(I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"),"mfa_totp_container");//No I18N
				}
				return false;
			}
			else if(myzohototp.length!=totp_size){
				if(isTroubleinVerify){					
					showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"verify_totp_container");//No I18N
				}
				else{
					showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"mfa_totp_container");//No I18N
				}
				return false;
			}
		}
		var loginurl="/relogin/v1/device/"+deviceid;//no i18N
		isResend = prefoption === "push" ? true : false; // no i18N
		jsonData = prefoption==="totp" ? {'devicereauth':{ 'devicepref' : prefoption, 'code' : myzohototp } } :{'devicereauth':{'devicepref':prefoption }}; ;//no i18N
		var method = "POST"; // no i18n
		var invoker = handleMyZohoDetails;
		if(prefoption==="totp"){
			method = "PUT"; // no i18n
			invoker = handleTotpDetails;
			loginurl = loginurl+"?polling=false";	// no i18n
		}
		sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,invoker,method);
		return false;
		//Resend push for myzohoapp
	}
}

function setReloginForm(){
	var authModes = {
			"isOTP": false,		// no i18n
			"isTOTP": false,		// no i18n
			"isJwt": false,			// no i18n
			"isSaml": false,		// no i18n
			"isFederated": false,	// no i18n
			"isNoPassword": true,		// no i18n
			"isEOTP": false,			// no i18n
			"isOIDC": false				// no i18n
	}
	isPrimaryMode =  true;
	allowedmodes = userAuthModes.allowed_modes;
	userPrimaryFactor=prev_showmode = reloginAuthMode = allowedmodes[0];
	if(allowedmodes.indexOf("passkey") != 0 && allowedmodes.indexOf("mzadevice") != 0){
		allowedmodes.forEach(function(usedmodes){
			switch(usedmodes){
				case "otp": //no i18n
					authModes.isOTP = true;
					break;
				case "totp": //no i18n
					authModes.isTOTP = true;
					break;
				case "saml": //no i18n
					authModes.isSaml = true;
					break;
				case "jwt": //no i18n
					authModes.isJwt = true;
					break;
				case "federated": //no i18n
					authModes.isFederated =true;
					break;
				case "password": //no i18n
					authModes.isNoPassword = false;
					break;
				case "email": //no i18n
					authModes.isEOTP = true;
					break;
				case "oidc" : //no i18n
					authModes.isOIDC = true;
			}
		});
	}
	var altmode = allowedmodes[1];
	var isOtherModeAvailable = typeof altmode != "undefined";//no i18n
	$(".otp_actions .showmorereloginoption,.header_for_oneauth,#try_other_options,.fed_2show").hide();	//no i18n
	if(allowedmodes[0]==="passkey"){
		if(!isWebAuthNSupported()) {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		}

		$("#relogin_primary_container,.fed_2show").hide();
		$("#reauth_button span").html(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
		if(allowedmodes.length>1){
			secondarymodes = allowedmodes;
			$("#tryAnotherSAMLBlueText").show();
		}
	} 
	if(allowedmodes[0] === "password" || allowedmodes[0] === "federated"){
		$("#relogin_password_input").attr("type","password");		//No i18N
		if(allowedmodes[0] === "password"){$("#enableforgot").show();}
		if(isOtherModeAvailable){
			if(allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("email") != -1){
				secondarymodes = allowedmodes;
				$('#enablemore').show();
				$('#enableforgot').hide();
			}
			else if(allowedmodes.length >= 2){
				enablePassword(authModes);
				if($("#enablemore").is(":visible") || $("#enableotpoption").is(":visible")){
					$("#enableforgot").hide();
				}
				setFooterPosition();
				return false;
			}
		}
		else if(allowedmodes[0] === "password"){
			$("#enableforgot").show();
		}
		else if(allowedmodes[0] === "federated"){
			$(".fed_2show").show();
			$("#relogin_password").hide();
		}
	}
	else if( allowedmodes[0] === "otp" || allowedmodes[0] === "email" ){
		$("#relogin_password_input").attr("type","password");		//No i18N
		emobile = allowedmodes[0] === "otp" ? userAuthModes.otp.data[0].e_mobile : userAuthModes.email.data[0].e_email;
		rmobile = allowedmodes[0] === "otp" ? numberFormat(userAuthModes.otp.data[0].r_mobile) : userAuthModes.email.data[0].email;
		$('#verifywithpass').hide();
		isNoPassword = true;
		enablePassword(authModes);
		$(".otp_actions .reloginwithjwt,.otp_actions .reloginwithsaml,.otp_actions .showmorereloginoption,#enablemore").hide();
		if(userAuthModes.email!=undefined && userAuthModes.email.data.length > 1 && ! (userAuthModes.email.data.some(function(obj){return obj.isPrimary}))){
			if(allowedmodes[0] === "email" && userAuthModes.email.data.length > 1){
				emobile =  userAuthModes.email.data[0].e_email;
				rmobile =  userAuthModes.email.data[0].email;
				showAndGenerateOtp(allowedmodes[0]);
				$("#otp_container .textbox_actions").show();
			}
			else if(userAuthModes.otp!=undefined){
				emobile =  userAuthModes.otp.data[0].e_mobile;
				rmobile =  numberFormat(userAuthModes.otp.data[0].r_mobile);
				showAndGenerateOtp(allowedmodes[1]);
				$("#otp_container .textbox_actions").show();
			}
			else{
				showViaSecondaryMail();
				$("#otp_container").hide();
			}
		}
	    else if(allowedmodes[0] == 'email' && userAuthModes.email.data.length == 1){
				emobile =  userAuthModes.email.data[0].e_email;
				rmobile =  userAuthModes.email.data[0].email;
				showAndGenerateOtp(allowedmodes[0]);
				$("#otp_container .textbox_actions").show();
		}
		else if(userAuthModes.otp!=undefined && userAuthModes.otp.count>1 ){
			showViaSecondaryMail();
		}
		else{
			$("#reauth_button,#password_container,#otp_container").hide();
			$(".sendotp_to_mobile .mobile_desc").html(formatMessage(I18N.get("IAM.REAUTH.SEND.OTP.TO.NUMBER"),rmobile));
			$(".sendotp_to_mobile .btn").attr("onclick","sendOtp()");
			$(".sendotp_to_mobile,#otp_container .textbox_actions").show();
		}
		setFooterPosition();
		if(allowedmodes[0] === "otp" && userAuthModes.otp.data.length>1){
			mobposition = 0;
		}
		if(allowedmodes.length>1){
			secondarymodes = allowedmodes;
			if(!authModes.isFederated && !authModes.isSaml && !authModes.isOIDC && !authModes.isJwt){
				$("#tryAnotherSAMLBlueText").show();
			}
		}
		return false;
	}
	else if(allowedmodes[0]==="mzadevice"){
		isPasswordless=true;
		$("#relogin_password_input").attr("type","text");		//No i18N
		secondarymodes = allowedmodes;
		handleSecondaryDevices(allowedmodes[0]);
		enableMyZohoDevice();
		return false;
	}
	else if(allowedmodes[0]==="saml" || allowedmodes[0]==="jwt" || allowedmodes[0] === "oidc"){
		$("#password_container").slideUp(300);
		$(".fed_2show").show();
		enablePassword(authModes);
		$(".blur,.loader,#relogin_password,.relogin_fed_text").hide();
		setFooterPosition();
		return false;
	}
	if(allowedmodes[0]==="yubikey"){
		if(!isWebAuthNSupported()) {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		}
		$("#relogin_primary_container,.fed_2show,.header_content").hide();
		$(".header_for_oneauth").show();
		$(".header_for_oneauth .head_text").text($(".header_content .head_text").text());
		$(".header_for_oneauth .header_desc").text(I18N.get('IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW'));
		$("#reauth_button span").html(I18N.get('IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY'));
		if(allowedmodes.length>1){
			secondarymodes = allowedmodes;
			$("#tryAnotherSAMLBlueText").show();
		}
	}
	if(allowedmodes[0]==="totp"){
		$(".header_content").hide();
		$(".header_for_oneauth").show();
		$(".header_for_oneauth .head_text").text($(".header_content .head_text").text());
		$("#password_container,.fed_2show").hide();
		$(".header_for_oneauth .header_desc").text(I18N.get('IAM.NEW.SIGNIN.MFA.TOTP.HEADER'));
		$("#reauth_button span").html(I18N.get('IAM.NEW.SIGNIN.VERIFY'));
		$("#mfa_totp_container").show();
		splitField.createElement('mfa_totp_field',{
			"splitCount":totp_size,					// No I18N
			"charCountPerSplit" : 1,		// No I18N
			"isNumeric" : true,				// No I18N
			"otpAutocomplete": true,		// No I18N
			"customClass" : "customOtp",	// No I18N
			"inputPlaceholder":'&#9679;',	// No I18N
			"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
		});
		$('#mfa_totp_field .customOtp').attr('onkeypress','remove_err()');
		$("#mfa_totp_field").click();
		if(allowedmodes.length>1){
			secondarymodes = allowedmodes;
			$("#tryAnotherSAMLBlueText").show();
		}
	} 
	$(".blur,.loader").hide();
}

function enablePasskey(){
	var reauthurl = "/relogin/v1/passkey/self";	//no i18N
	sendRequestWithCallback(reauthurl,"",true,passkeyActivtedCallback);
	return false;
}

function passkeyActivtedCallback(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode==="RA005"){
				getAssertionLookup(jsonStr.passkeyreauth);
			}	
		}
		else{
			if(jsonStr.cause==="throttles_limit_exceeded"||jsonStr.code === "Z225"){
				window.location.href = logoutURL;
				return false;
			}
			showErrorToast("password",jsonStr.localized_message); //no i18n
			return false;
		}
		return false;
	   	
	}else{
		showErrorToast(I18N.get("IAM.ERROR.GENERAL")); //no i18n
		changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
		return false;
	}
	return false;
}

function getAssertionLookup(parameters,isSecKey) {
	var requestOptions = {};
	requestOptions.challenge = strToBin(parameters.challenge);
	requestOptions.timeout = parameters.timeout;
	requestOptions.rpId = parameters.rpId;
	requestOptions.allowCredentials = credentialListConversion(parameters.allowCredentials);
	if ('authenticatorSelection' in parameters) {
      requestOptions.authenticatorSelection = parameters.authenticatorSelection;
    }
	requestOptions.extensions = {};
	if ('extensions' in parameters) {
		if ('appid' in parameters.extensions) {
			requestOptions.extensions.appid = parameters.extensions.appid;
		}
	}
	/*Yubikey sigin issue on android mobile issue temporary fix
	requestOptions.extensions.uvm = true;*/
	return navigator.credentials.get({
		"publicKey": requestOptions //No I18N
	}).then(function(assertion) {
	    var publicKeyCredential = {};
	    if ('id' in assertion) {
	      publicKeyCredential.id = assertion.id;
	    }
	    if ('type' in assertion) {
	      publicKeyCredential.type = assertion.type;
	    }
	    if ('rawId' in assertion) {
	      publicKeyCredential.rawId = binToStr(assertion.rawId);
	    }
	    if (!assertion.response) {
	    	showErrorToast(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse"),support_email));
			showErrorToast(I18N.get("IAM.ERROR.GENERAL")); //no i18n
	    }
	    /*Yubikey sigin issue on android mobile issue temporary fix
	    if (assertion.getClientExtensionResults) {
	      if (assertion.getClientExtensionResults().uvm != null) {
	        publicKeyCredential.uvm = serializeUvm(assertion.getClientExtensionResults().uvm);
	      }
	    }
        */
	    var _response = assertion.response;

	    publicKeyCredential.response = {
	      clientDataJSON:     binToStr(_response.clientDataJSON),
	      authenticatorData:  binToStr(_response.authenticatorData),
	      signature:          binToStr(_response.signature),
	      userHandle:         binToStr(_response.userHandle)
	    };
	    var key_data ={};
	    var authURL = "/relogin/v1/yubikey/self";	//no i18N
	    if(isSecKey){
	    	key_data.yubikeyreauth = publicKeyCredential;
	    }else{
	    	authURL = "/relogin/v1/passkey/self";	//no i18N
	    	key_data.passkeyreauth = publicKeyCredential;
	    }
	    sendRequestWithCallback(authURL,JSON.stringify(key_data),true,VerifySuccess,"PUT");//no i18N
	}).catch(function(err) {
			changeButtonAction(isSecKey ? I18N.get('IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY') : I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
			if(err.name == 'NotAllowedError' || err.name == 'AbortError') {
				showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError")); //no i18n	
			} else if(err.name == 'InvalidStateError') {
				showErrorToast(isSecKey ? I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError") : I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError")); //no i18n
			}else if (err.name == 'TypeError' && isSecKey == undefined) {
				showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.TYPE.ERROR"),formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.HELP.HOWTO"),passkeyHelpDoc)); //no i18n
			}else{
				showErrorToast(formatMessage(isSecKey ? I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred") : I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.ErrorOccurred"),support_email)+ '<br>' +err.toString()); //no i18n
			}
	});
}

function enableOIDCAuth(OIDCAuthID){
	var loginurl="/relogin/v1/oidcreauth/"+OIDCAuthID;//no i18N
	sendRequestWithCallback(loginurl,"",true,function(resp){
		if(IsJsonString(resp)) {
			var jsonStr = JSON.parse(resp);
			switchto(jsonStr.oidcreauth.redirect_uri);
		}else{
			showErrorToast(I18N.get("IAM.ERROR.GENERAL"));
			return false;
		}
	});
	return false
}

function enableSamlAuth(samlAuthDomain){
	if(userAuthModes.saml.data[0].redirect_uri){
		switchto(userAuthModes.saml.data[0].redirect_uri);
		return false;
	}
	samlAuthDomain = samlAuthDomain === undefined ? userAuthModes.saml.data[0].auth_domain : samlAuthDomain;
	var loginurl="/relogin/v1/samlreauth/"+samlAuthDomain;//no i18N
	sendRequestWithCallback(loginurl,"",true,handleSamlAuthdetails);
	return false
}
function validTotpCallback(resp){
	remove_err();
	removeBtnLoading();
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
			reloginAuthMode = jsonStr.resource_name;
			var successCode = jsonStr.code;
			if(successCode === "RA200"){
				if(post_action)
				{
					window.close();
				}
				else
				{
					window.location.href=jsonStr[reloginAuthMode].redirect_uri;; 
				}
				return false;
			}
			return false;
		}else{
			if(jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showAutheticationError(errorMessage,"mfa_totp_container"); //no i18n
			return false;	
		}
	}else{
		showAutheticationError(I18N.get("IAM.ERROR.GENERAL"),"mfa_totp_container"); //no i18n
		return false;
	}
	return false;
}
function enableSecurityKey(){
	if(!isWebAuthNSupported()){
		showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	var authURL= "/relogin/v1/yubikey/self";	//no i18n
	sendRequestWithCallback(authURL,"",true,handleSecuritykeyDetails);
	return false;
}
function handleSecuritykeyDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			if(jsonStr.code==="RA006"){
				//show yubikey
			   	getAssertionLookup(jsonStr.yubikeyreauth,true);
			}	
		}
		else{
			removeBtnLoading();
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showErrorToast(jsonStr.localized_message);
				return false;
			}
			showErrorToast(jsonStr.localized_message); 
			return false;
		}
		return false;
	   	
	}else{
		removeBtnLoading();
		showErrorToast(I18N.get(jsonStr.localized_message));
		return false;	
	}
	return false;
}
function handleSamlAuthdetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		switchto(jsonStr.samlreauth.redirect_uri);
	}else{
		showErrorToast(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
}

function sendOtpToEmail(){
	$(".sendotp_to_email").hide();
	showAndGenerateOtp(allowedmodes[0]);
	$('#otp_container .textbox_actions,#otp_container .textbox_div').show();
	$("#reauth_button").show();
	$(".sendotp_to_email .btn").attr("onclick","");
}

function goBackToCurrentMode(){
	$('.header_content,.fieldcontainer,#relogin_primary_container').show();
	if(!$(".sendotp_to_mobile .sendotp_to_mobile_btn").is(":visible") && !$(".sendotp_to_email .sendotp_to_email_btn").is(":visible")){
		$("#reauth_button").show();
	}
	if(prev_showmode === "totp"){
		$('.header_content').hide();
		$('.header_for_oneauth').show();
		$("#mfa_totp_field").click();
	}
	$('#tryAnotherSAMLBlueText').show();
	$('#problemreloginui,#other_relogin_options').hide();
	if(prev_showmode === "mzadevice"){$(".tryanother,.devices .selection").show();$("#try_other_options,#tryAnotherSAMLBlueText").hide();}
	if(prev_showmode === "otp"){
		$('.header_for_oneauth').hide();
		if(allowedmodes.indexOf('password') == "-1"){
			$('.otp_actions #verifywithpass').hide();
		}
	}
	if(!($('.secondary_devices option').length > 1 )){
		$('.downarrow').hide();
		$('.devices .selection').css("pointer-events", "none");
	}
	if(prev_showmode === "password"){
		$("#enablemore").show();
		changeButtonAction(I18N.get('IAM.CONFIRM.PASS'));//no i18n
		$('#relogin_password_input').focus();
	}
	if(prev_showmode == "passkey"|| prev_showmode == "yubikey"){$("#password_container,#otp_container").hide();}
	if(prev_showmode == "yubikey"){$(".header_content").hide();$(".header_for_oneauth").show()}
}

function hideOtherReloginOptions(){
	if(allowedmodes[0] == "saml" || allowedmodes[0] == "jwt" || allowedmodes[0] == "passkey"){
		$('#tryAnotherSAMLBlueText').show();
	}
	else{
		$('#enablemore').show();		
	}
	if(allowedmodes[0] == "otp" || allowedmodes[0] == "email"){
		$("#otp_container").show();
	}
	$('#reauth_button,.header_content').show();
	var show_mode = prev_showmode === "email" ? "otp" : prev_showmode; //no i18n
	$("#"+show_mode+"_container").show();
	$('#other_relogin_options').hide();
	$('#other_relogin_options').html("");
	if(allowedmodes[0] !== "passkey"){$(".fed_2show").show();}
	setFooterPosition();
	return false;
} 

function enablePassword(authModes){
	$(".blur,.loader").hide();
	$("#relogin_password_input").attr("type","password");		//No i18N
	$("#relogin_password_input").focus();
	if (authModes.isOTP && authModes.isEOTP){
		secondarymodes = userAuthModes.allowed_modes;
		$("#enablemore").hide();
		$('#enableforgot').hide();
	}else if(authModes.isOTP){
		$("#enableotpoption").show();
		$('#enableforgot').hide();
		$("#enableotpoption #reloginwithotp").attr("onclick","showAndGenerateOtp('moblie')");
		emobile=userAuthModes.otp.data[0].e_mobile;
		rmobile=numberFormat(userAuthModes.otp.data[0].r_mobile);
	}else if(authModes.isEOTP){
		$("#enableotpoption").show();
		$("#enableotpoption #reloginwithotp").attr("onclick","showAndGenerateOtp('email')");
		emobile=userAuthModes.email.data[0].e_email;
		rmobile=userAuthModes.email.data[0].email;
	}
	if(authModes.isTOTP){
		$("#tryAnotherSAMLBlueText").show();
		secondarymodes = userAuthModes.allowed_modes;
	}
	if(authModes.isSaml){
		$(".fed_2show").show();
		userAuthModes.saml.data.forEach(function(data,ind){
		    $(".fed_2show #all_idps").append($(".openIDP_template .saml_temp").clone().attr("id","saml_"+ind));		//No i18N
		    var idp_ele = $(".fed_2show #all_idps #saml_"+ind);
		    idp_ele.attr("onclick","enableSamlAuth('"+data.auth_domain+"')");	//No I18N
		    idp_ele.find(".fed_text_avoid").text(formatMessage(idp_ele.find(".fed_text_avoid").text(),data.display_name));
		});
	}if (authModes.isFederated){
		$(".fed_2show").show();
		if(!authModes.isOTP && !authModes.isSaml){ $("#enableforgot").show()};
		var idps = userAuthModes.federated.data;
		if((authModes.isNoPassword && authModes.isFederated) && (!authModes.isOTP && !authModes.isEOTP)){
			$("#password_container .textbox_div,#reauth_button").hide();
		}
	}if(!authModes.isNoPassword){
		$("#verifywithpass").show();
	}
	if(authModes.isJwt){
		$(".fed_2show").show();
		userAuthModes.jwt.data.forEach(function(data,ind){
		    $(".fed_2show #all_idps").append($(".openIDP_template .jwt_temp").clone().attr("id","jwt_"+ind));	//No i18N
		    var idp_ele = $(".fed_2show #all_idps #jwt_"+ind);
		    idp_ele.attr("onclick","switchto('"+data.redirect_uri+"')");	//No I18N
		    idp_ele.find(".fed_text_avoid").text(formatMessage(idp_ele.find(".fed_text_avoid").text(),data.display_name));
		});
	}
	if(authModes.isOIDC){
		$(".fed_2show").show();
		userAuthModes.oidc.data.forEach(function(data,ind){
		    $(".fed_2show #all_idps").append($(".openIDP_template .open_id_temp").clone().attr("id","oidc_"+ind));		//No i18N
		    var idp_ele = $(".fed_2show #all_idps #oidc_"+ind);
		    idp_ele.attr("onclick","enableOIDCAuth('"+data.oidc_id+"')");	//No I18N
		    idp_ele.find(".fed_text_avoid").text(formatMessage(idp_ele.find(".fed_text_avoid").text(),data.display_name));
		});
		
	}
	if($("#enablemore").is(":visible") || $("#enableotpoption").is(":visible")){
		$("#enableforgot").hide();
	}
	return false;
}

function showPassword(){
	$("#otp_container").slideUp(300);
	$("#password_container").show();
	changeButtonAction(I18N.get('IAM.CONFIRM.PASS'));//no i18n
	reloginAuthMode="password";//no i18N
	$("#relogin_password_input").attr("type","password");		//No i18N
	$("#relogin_password_input").val("");
	//$(".mobile_message").hide();
	//$("#captcha_container").hide();
	//$("#lineseparator,.fed_2show").show();
	$("#relogin_password_input").focus();
	//$(".service_name").show();
}

function showAndGenerateOtp(pmode){
	$("#password_container").slideUp(300);
	$("#otp_container .header_desc").hide();
	if(pmode === 'email'){
		$(".email_otp_description span").text(rmobile);
		$(".email_otp_description").show();
	}
	else{
		$(".mobile_otp_description span").text(rmobile);
		$(".mobile_otp_description").show();
	}
	if(showAndGenerateOtp.caller.name == "onclick"){		
		$('#otp_container .textbox_actions').show();
	}
	$('#otp_container .textbox_div').show();
	$("#otp_container").slideDown(300);
	
	splitField.createElement('otp_input_box',{
		"splitCount":otp_length,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$('#otp_input_box .customOtp').attr('onkeypress','remove_err()');
	changeButtonAction(I18N.get('IAM.NEW.SIGNIN.VERIFY'));//no i18n
	$("#reauth_button").show();
	generateOTP();
	if(isPasswordless){
		$('#verifywithpass').hide();
		$('.relogin_head').css('margin-bottom','10px');
		//$('.username').text(deviceauthdetails.lookup.loginid);
		resendotp_checking();
		//if (!isRecovery) {allowedModeChecking();}
		allowedModeChecking();
	}
	return false;
	
}
function generateOTP(isResendOnly){
	var loginurl = "/relogin/v1/otp/"+emobile;//no i18N
	var callback = isResendOnly ? showResendInfo : enableOTPDetails;
	!isResendOnly ? sendRequestWithCallback(loginurl,"",true,callback) : sendRequestWithCallback(loginurl,JSON.stringify({"otpreauth" : {"is_resend" : true }}),true,callback)//no i18n
	return false;
}

function changeButtonAction(textvalue){
	removeBtnLoading();
	$("#reauth_button span").text(textvalue); //No I18N
	return false;
}

function resendotp_checking(){
	var resendtiming = 60;
	clearInterval(resendTimer);
	$('.resendotp').addClass('nonclickelem');
	$('.resendotp span').text(resendtiming);
	$('.resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
	resendTimer = setInterval(function(){
		resendtiming--;
		$('.resendotp span').text(resendtiming);
		if(resendtiming === 0) {
			clearInterval(resendTimer);
			$('.resendotp').html(I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
			$('.resendotp').removeClass('nonclickelem');
		}
	},1000);
}

function passwordValidationCallback(resp){
	remove_err();
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
			zuid = zuid ? zuid : jsonStr[reloginAuthMode].identifier;
			var successCode = jsonStr.code;
			if(successCode === "RA200"){
				if(post_action)
				{
					window.close();
				}
				else
				{
					window.location.href=jsonStr.passwordreauth.redirect_uri;; 
				}
				return false;
			}
			return false;
		}else{
			removeBtnLoading();
			if(jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}
			var errorMessage = jsonStr.localized_message;
			showAutheticationError(errorMessage,"password_container"); //no i18n
			return false;	
		}
	}else{
		removeBtnLoading();
		showAutheticationError(I18N.get("IAM.ERROR.GENERAL"),"password_container"); //no i18n
		return false;
	}
}

function otpValidationCallback(resp){
	remove_err();
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
			zuid = zuid ? zuid : jsonStr[reloginAuthMode].identifier;
			var successCode = jsonStr.code;
			if(successCode === "RA200"){
				if(post_action)
				{
					window.close();
				}
				else
				{
					window.location.href=jsonStr[reloginAuthMode].redirect_uri;; 
				}
				return false;
			}
			return false;
		}else{
			removeBtnLoading();
			if(jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showAutheticationError(errorMessage,"otp_container"); //no i18n
			return false;	
		}
	}else{
		removeBtnLoading();
		showAutheticationError(I18N.get("IAM.ERROR.GENERAL"),"otp_container"); //no i18n
		return false;
	}
	return false;
}

function enableOTPDetails(resp){
	if(IsJsonString(resp)) {
		remove_err();
		setTimeout(function(){$(".blur,.loader").hide()},300);
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "RA002"){
					showSuccessToast(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
					resendotp_checking();
					if(isPasswordless || allowedmodes[0] == "passkey"){$(".otp_actions .showmorereloginoption").hide()}
					$("#otp_input_box .empty_field:first").focus();
					return false;
			}
			return false;
		}
		else{
				if(jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
					window.location.href = logoutURL;
					return false;
				}
				var errorMessage = jsonStr.localized_message;
				showAutheticationError(errorMessage,"otp_container"); //no i18n
				return false;	
		}
	}
	return false;
}

function showResendInfo(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "RA002"){
				showSuccessToast( formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
				resendotp_checking();
				$("#otp_input_box .empty_field:first").focus();
				return false;
			}
		}else{
			if(jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}

			showAutheticationError(jsonStr.localized_message,"otp_container"); //no i18n
			return false;	
		}
	}
	return false;
	
}

function enableMyZohoDevice()
{
	var devicedetails = userAuthModes.mzadevice.data[parseInt($(".secondary_devices").children("option:selected").val())];
	deviceid= devicedetails.device_id;
	isSecondary = allowedmodes.length > 1  && (allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1 )? true : false;
	isSecondary = (allowedmodes.length > 2 && allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1) ? true : isSecondary; // no i18n
	isSecondary = (allowedmodes.indexOf("recoverycode") === -1 && allowedmodes.indexOf("passphrase") === -1) && allowedmodes.length === 3 ? false : isSecondary;
	prefoption = devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	var loginurl="/relogin/v1/device/"+deviceid;//no i18N
	var jsonData = {'devicereauth':{'devicepref':prefoption }};//no i18N
	$(".blur,.loader").show();
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handleMyZohoDetails);
	return false;
}

function handleTotpDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			var statusmsg = jsonStr[reloginAuthMode].status;
			if(successCode === "RA200"){
				switchto(jsonStr[reloginAuthMode].redirect_uri);
				return false;
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded" || jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode = error_resp.code;
			var errorMessage = jsonStr.localized_message;
			var errorContainer = isTroubleinVerify ? "verify_totp_container" : "mfa_totp_container";		//no i18n
			showAutheticationError(errorMessage,errorContainer); 
			return false;	
		}
	}else{
		var container = isTroubleinVerify ? "verify_totp_container" : "mfa_totp_container";		 // no i18n
		showAutheticationError(I18N.get("IAM.ERROR.GENERAL"),container); //no i18n
		return false;
	}
	return false;
}

function handleMyZohoDetails(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			$(".blur,.loader").hide();
			var successCode = jsonStr.code;
			if(successCode === "RA001"){
				if(isResend){
					showResendPushInfo();
					return false;
				}
				isTroubleinVerify = false;
				if(prefoption==="totp"){
					$("#mfa_scanqr_container,#mfa_push_container,#waitbtn,#openoneauth").hide();
					enableTOTPdevice(jsonStr,true,false);
					return false;
				}
				var headtitle = prefoption ==="push" ? "IAM.VERIFY.IDENTITY" : prefoption === "totp" ? "IAM.NEW.SIGNIN.TOTP" : prefoption === "scanqr" ? "IAM.NEW.SIGNIN.QR.CODE" : "";//no i18N
				var headerdesc = prefoption ==="push" ? "IAM.RELOGIN.PASSWORDLESS.PUSH.DESC" : prefoption === "totp" ? "IAM.RELOGIN.PASSWORDLESS.TOTP.DESC" : prefoption === "scanqr" ? "IAM.RELOGIN.PASSWORDLESS.SCANQR.DESC":"";//no i18N
				$(".header_content,#password_container,.fed_2show,#otp_container,.deviceparent").hide();
				$(".header_for_oneauth .head_text").text(I18N.get(headtitle));
				$(".header_for_oneauth .header_desc").text(I18N.get(headerdesc));
				$(".header_for_oneauth").show();
				
				$('.devices .selection').css('display','');
				$("#reauth_button").hide();
    			$("#mfa_device_container").show();
    			if(prefoption === "push" || prefoption==="scanqr" ){
    				var wmsid = jsonStr[reloginAuthMode].WmsId && jsonStr[reloginAuthMode].WmsId.toString();
    				isVerifiedFromDevice(prefoption,true,wmsid);
    			}
    			if(prefoption==="push"){
    				if(isPasswordless && jsonStr[reloginAuthMode].rnd != undefined){
	    				$(".rnd_container").show();
        				$("#rnd_number").html(jsonStr[reloginAuthMode].rnd);
        				$("#waitbtn,.loadwithbtn").hide();
	    				$("#mfa_scanqr_container,#mfa_totp_container,#openoneauth").hide();
	    				$(".service_name").text(I18N.get("IAM.NEW.SIGNIN.PUSH.RND.DESC"));
	    				$(".loader,.blur").hide();
	    				resendpush_checking(time = 20);
        			}
    				else{
	    				$("#waitbtn,.loadwithbtn").show();
	    				$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
	    				$("#waitbtn").attr("disabled", true);
	    				$("#mfa_scanqr_container,#mfa_totp_container,#openoneauth").hide();
	    				$(".loader,.blur").hide();
	    				window.setTimeout(function (){
	        				$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
	        				$(".loadwithbtn").hide();
	        				$("#waitbtn").attr("disabled", false);
	        				return false;
	        				
	    				},20000);
    				}
    			}
    			if(prefoption==="scanqr"){
    				reloginAuthMode = jsonStr.resource_name;
    				$("#waitbtn").hide();
    				var qrcodeurl = jsonStr[reloginAuthMode].img;
    				qrtempId =  jsonStr[reloginAuthMode].temptokenid;
    				isValid(qrtempId) ? $("#openoneauth").show() : $("#openoneauth").hide();
    				$("#mfa_push_container,#mfa_totp_container").hide();
    				$("#qrimg").css("background-image","url('"+qrcodeurl+"')");//no i18n
    				$("#mfa_scanqr_container").show();
    				$(".checkbox_div").addClass("qrwidth");
    			}
    			$(".tryanother").show();
				$(".loader,.blur").hide();
				setFooterPosition();
				return false;
			}
		}else{
			var errorcontainer= isPasswordless ? "login_id" : prefoption==="totp"? "mfa_totp": $("#password_container").is(":visible") ? "password" : $("#otp_container").is(":visible") ?"otp" : "yubikey";//no i18n
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			if(errorCode === "D105"){
				$('.fed_2show').hide();
				showAutheticationError(jsonStr.localized_message,errorcontainer);
		//		if (!isRecovery) {allowedModeChecking();}
				return false;
			}
			$('#problemrelogin,#recoverybtn').hide();
			if(jsonStr.cause==="reauth_threshold_exceeded" || jsonStr.code === "Z225" || errorCode === "RA003"){
				window.location.href = logoutURL;
				return false;
			}

			var errorMessage = jsonStr.localized_message;
			showAutheticationError(errorMessage,errorcontainer);
			$(".loader,.blur").hide();
			return false;
	   }
		
	}else{
		var errorcontainer = reloginAuthMode ==="passwordauth"? "password":"login_id";//no i18n
		showAutheticationError(I18N.get("IAM.ERROR.GENERAL"),errorcontainer); //no i18n
		return false;
	}
	return false;
}

function resendpush_checking(resendtiming){
	clearInterval(resendTimer);
	$('.rnd_resend').addClass('nonclickelem');
	$('.rnd_resend').html(I18N.get('IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN'));
	$('.rnd_resend span').text(resendtiming);
	resendTimer = setInterval(function(){
		resendtiming--;
		$('.rnd_resend span').text(resendtiming);
		if(resendtiming === 0) {
			clearInterval(resendTimer);
			$('.rnd_resend').html(I18N.get('IAM.NEW.SIGNIN.RESEND.PUSH'));
			$('.rnd_resend').removeClass('nonclickelem');
		}
	},1000);
}

function enableTOTPdevice(resp,isMyZohoApp,isOneAuth){
	$(".header_content,#password_container,.fed_2show,#otp_container,#forgotpassword").hide();
	$(".header_for_oneauth .head_text").text(I18N.get("IAM.NEW.SIGNIN.TOTP"));
	$(".header_for_oneauth .header_desc").text(I18N.get("IAM.NEW.SIGNIN.MFA.TOTP.HEADER"));
	$(".header_for_oneauth,#reauth_button").show();
	
	changeButtonAction(I18N.get('IAM.NEW.SIGNIN.VERIFY'));//no i18n
	if(isMyZohoApp){
		$(".deviceparent .devicetext").text(devicename);
		$(".devicedetails .devicetext").text(devicename);
		$("#mfa_device_container").show();
		$(".tryanother").show();
		$(".header_for_oneauth .header_desc").text(I18N.get("IAM.RELOGIN.PASSWORDLESS.TOTP.DESC"));
		$("#problemrelogin,#recoverybtn,.loader,.blur,.deviceparent").hide();
		remove_err();
	}	
	$("#mfa_totp_container").show();
	splitField.createElement('mfa_totp_field',{
		"splitCount":totp_size,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$('#mfa_totp_field .customOtp').attr('onkeypress','remove_err()');
	$("#mfa_totp_field").click();
	$(".service_name").addClass("extramargin");
	if(!isMyZohoApp && !isRecovery){allowedModeChecking()};
	return false;
}

function showResendPushInfo(){
	$(".loadwithbtn").show();
	$(".waitbtn .waittext").text(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
	$("#waitbtn").attr("disabled", true);
	showSuccessToast(formatMessage(I18N.get("IAM.RESEND.PUSH.MSG")))
	window.setTimeout(function (){
		$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
		$(".loadwithbtn").hide();
		$("#waitbtn").attr("disabled", false);
		return false;
		
	},25000);
	return false;
}

function handleSecondaryDevices(primaryMode){
	if(primaryMode === "oadevice" || primaryMode === "mzadevice"){
		$('.secondary_devices').find('option').remove().end();
		var deviceDetails = userAuthModes;
		var isSecondaryDevice = false;
		var optionElem = '';
		secondaryMode = "oadevice"; //no i18n
		if(primaryMode == "oadevice") {
			secondaryMode = "mzadevice"; // no i18n
		}
		if(deviceDetails[primaryMode]){
			var oneauthdetails = deviceDetails[primaryMode].data;
			if(oneauthdetails[0].prefer_option != "push"){
				optionElem += "<option value='0' version='"+oneauthdetails[0].app_version+"'>"+oneauthdetails[0].device_name+"</option>";
				isSecondaryDevice = true;
			}else{
				oneauthdetails.forEach(function(data,index){
					optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
					isSecondaryDevice = true;
				});
			}
		}
		if(deviceDetails[secondaryMode]){
			var oneauthdetails = deviceDetails[secondaryMode].data;
			if(oneauthdetails[0].prefer_option != "push"){
				optionElem += "<option value='0' version='"+oneauthdetails[0].app_version+"'>"+oneauthdetails[0].device_name+"</option>";
				isSecondaryDevice = true;
			}else{
				oneauthdetails.forEach(function(data,index){
					optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
					isSecondaryDevice = true;
				});
			}
		}
		document.getElementsByClassName('secondary_devices')[0].innerHTML = optionElem; // no i18n
		if(isSecondaryDevice){
			try { 
				$(".secondary_devices").uvselect({
					"theme" : "auth-device", //no i18n
					"searchable" : false, //No i18N
					"prevent_mobile_style": true, // no i18n
					"onDropdown:open" : function(){	//no i18n
						$(".selectbox_options--auth-device .option p").before("<i class='select_icon icon-Mobile'></i>");
					},
					"onDropdown:select" : function(){	//no i18n
						$(".select_input--auth-device").css("width",$(".select_input--auth-device").val().length+"ch");		//No i18N
					}
				});
				$(".select_container--auth-device .select_input").before("<i class='select_icon icon-Mobile'></i>");
				$(".select_input--auth-device").css("width",$(".select_input--auth-device").val().length+"ch");			//No i18N
				window.setTimeout(function(){
					  if(!($('.secondary_devices option').length > 1 )){
						  $(".select_container--auth-device .selectbox_arrow").hide();
						  $('.select_container--auth-device').css("pointer-events", "none");
					  }
				},100);
			}catch(err){
				$('.secondary_devices').css('display','block');
				if(!($('.secondary_devices option').length > 1 )){
					$('.secondary_devices').css("pointer-events", "none");
				}
				$('option').each(function() {
					if(this.text.length > 20){
						var optionText = this.text;
						var newOption = optionText.substring(0, 20);
						$(this).text(newOption + '...');
					}
				});
			}
		}
	}
}
function secondaryFormat(option){
	return "<div><span class='icon-device select_icon'></span><span class='select_con' value="+$(option.element).attr("value")+" version="+$(option.element).attr("version")+">"+option.text+"</span></div>";
}

function isVerifiedFromDevice(prefmode,isMyZohoApp,WmsID) {
	if(isWmsRegistered === false && isValid(WmsID) && WmsID != "undefined" ){
		wmscallmode=prefmode;wmscallapp=isMyZohoApp;wmscallid=WmsID;
		try {
			WmsLite.setClientSRIValues(wmsSRIValues);
			WmsLite.setNoDomainChange();
	 		WmsLite.registerAnnon('AC', WmsID ); //No I18N
	 		isWmsRegistered=true;
	 		
	 	} catch (e) {
		//no need to handle failure
	 	}
	}
	prefmode = prefmode === undefined ? wmscallmode:prefmode;
    isMyZohoApp = isMyZohoApp === undefined ? wmscallapp : isMyZohoApp;
   // WmsID = WmsID === undefined ? wmscallid : WmsID;
	clearInterval(_time);
	if(verifyCount > 15) {
		return false;
	}
	var loginurl = isMyZohoApp ? "/relogin/v1/device/"+deviceid+"?polling=true":null;//no i18N
	//loginurl += "digest="+digest+ "&" + signinParams+"&polling="+true ; //no i18N
	var jsonData = {'oneauthsec':{'devicepref':prefmode }};//no i18N
	if(isMyZohoApp){
		jsonData = {'devicereauth':{'devicepref':prefmode }};//no i18N
	}
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),false,VerifySuccess,"PUT");//No i18N
	verifyCount++;
	if(isValid(WmsID) && WmsID!="undefined"){
		wmscount++;
		var callIntervalTime = wmscount < 6 ? 5000 : 25000;
		_time = setInterval(function () {
			isVerifiedFromDevice(prefmode, isMyZohoApp, WmsID);
		}, callIntervalTime);
		return false;
	}else{
		_time = setInterval(function () {
			isVerifiedFromDevice(prefmode, isMyZohoApp, WmsID);
		}, 3000);
	}
	return false;
}

function changeSecDevice(elem){
	var version = $(elem).children("option:selected").attr('version');
	var device_index = $(elem).children("option:selected").val();
	//mzadevicepos = device_index;
	enableMyZohoDevice();
	hideTryanotherWay();
}
function hideTryanotherWay(){
		$(".passwordless_opt_container,#trytitle,.borderlesstry,#recoverybtn,#problemrelogin,#verify_totp_container,#verify_qr_container").hide();
		$(".header_for_oneauth,#relogin_primary_container,#mfa_device_container").show();
		$('.optionstry').removeClass("toggle_active");
		prefoption = userAuthModes.mzadevice.data[parseInt($(".secondary_devices").children("option:selected").val())].prefer_option;
		if(prefoption==="totp"){$("#reauth_button").show();}
		$(".tryanother").show();
		window.setTimeout(function(){
			$(".blur").hide();
			$('.blur').removeClass('dark_blur');
		},250);
		isTroubleinVerify = false;
		$('#verify_qrimg').css('background-image','');
		$("#mfa_totp_container input").val("");
		setFooterPosition();
		return false;
}
function VerifySuccess(res) {
	if(IsJsonString(res)) {
		var jsonStr = JSON.parse(res);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			var statusmsg = jsonStr[reloginAuthMode].status;
			if(statusmsg==="success" || successCode === "RA200"){
				clearInterval(_time);
				if(post_action)
				{
					window.close();
				}
				else
				{
					window.location.href=jsonStr[reloginAuthMode].redirect_uri;; 
				}
				return false;
			}
			else if(successCode==="P500"||successCode==="P501"){
				temptoken = jsonStr[reloginAuthMode].token;
//				showPasswordExpiry(jsonStr[reloginAuthMode].pwdpolicy);
				return false;
			}
		}
		else if(jsonStr.errors && jsonStr.errors[0].code === "D103"){
			window.location.href = logoutURL;
			return false;
		}
		else if(reloginAuthMode === "passkey" || reloginAuthMode === "yubikeyreauth"){
			removeBtnLoading();
			showErrorToast(I18N.get("IAM.ERROR.GENERAL"));
			return false;
		}
	}
	return false;
}

function showTryanotherWay(){
	clearInterval(_time);
	$(".waitbtn .waittext").text(I18N.get("IAM.PUSH.RESEND.NOTIFICATION"));
	$(".loadwithbtn").hide();
	$("#waitbtn").attr("disabled", false);
	$('.optionmod').show();
	remove_err();
	var preferoption = userAuthModes.mzadevice.data[parseInt($(".secondary_devices").children("option:selected").val())].prefer_option;
	if(prev_showmode === "mzadevice"){
		$("#try"+preferoption).hide();
		//$('.blur').show();
		//$('.blur').addClass('dark_blur');
		//allowedModeChecking_mob();
	//	return false;
	}
	$('.relogin_head').css('margin-bottom','10px');
	$(".passwordless_opt_container,#trytitle").show(); // no i18n
	$("#reauth_button,#relogin_primary_container,.header_for_oneauth,#problemrelogin,#recoverybtn_mob,.verify_title,.tryanother,#totpverifybtn .loadwithbtn,#relogin_primary_container").hide();
	$("#trytitle").html("<span class='icon-backarrow backoption' onclick='hideTryanotherWay()'></span>"+I18N.get('IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER')+"");//no i18n
	if(preferoption === "totp") { $('#trytotp').hide();}
	if(preferoption === "scanqr") { $('#tryscanqr').hide();}
	preferoption === "totp" ? tryAnotherway('qr') : tryAnotherway('totp'); //no i18n	
	if(userAuthModes.allowed_modes.length>1){$('#problemrelogin').show();}
	isTroubleinVerify =  true;
	setFooterPosition();
	return false;
}

function enableQRCodeimg(){
	prefoption = "scanqr"; // no i18n
	var deviceid = userAuthModes.mzadevice.data[parseInt($(".secondary_devices").children("option:selected").val())].device_id;
	var loginurl="/relogin/v1/device/"+deviceid;//no i18N
	var jsonData = {'devicereauth':{'devicepref':prefoption }};//no i18N
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handleQRCodeImg);
	reloginAuthMode = "devicereauth";//no i18N
}

function QrOpenApp() {
	//Have to handle special case!!!
	var qrCodeString = "code="+qrtempId+"&zuid="+zuid+"&url="+iam_URL; //No I18N
	document.location= UrlScheme+"://?"+qrCodeString;
	return false;
}

function handleQRCodeImg(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "RA001"){
				temptoken = jsonStr[reloginAuthMode].token;
				var qrcodeurl = jsonStr[reloginAuthMode].img;
				qrtempId =  jsonStr[reloginAuthMode].temptokenid;
				isValid(qrtempId) ? $("#verify_qr_container #openoneauth").show() : $("#verify_qr_container #openoneauth").hide();
				var wmsid = jsonStr[reloginAuthMode].WmsId && jsonStr[reloginAuthMode].WmsId.toString();
				isVerifiedFromDevice(prefoption,true,wmsid);
				$("#verify_qrimg").css("background-image","url('"+qrcodeurl+"')");//no i18n
				$('.verify_qr .loader,.verify_qr .blur').hide();
			}
		}else{
			if(jsonStr.cause==="throttles_limit_exceeded" || jsonStr.code === "Z225" || ((jsonStr.errors)&&(jsonStr.errors[0].code === "RA003"))){
				window.location.href = logoutURL;
				return false;
			}
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			showErrorToast(jsonStr.localized_message);
			return false;
	   }
		
	}else{
		showErrorToast(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}

function tryAnotherway(trymode){
	remove_err();
	prefoption = trymode === 'qr' ? 'scanqr' : trymode; // no i18n
	if(trymode == "totp" && !$("#trytotp").hasClass("toggle_active")){
		splitField.createElement('verify_totp',{
			"splitCount":totp_size,					// No I18N
			"charCountPerSplit" : 1,		// No I18N
			"isNumeric" : true,				// No I18N
			"otpAutocomplete": true,		// No I18N
			"customClass" : "customOtp",	// No I18N
			"inputPlaceholder":'&#9679;',	// No I18N
			"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
		});
		$('#verify_totp .customOtp').attr('onfocus','remove_err()');
	}
	if(!($('#verify_'+trymode+'_container').parent().hasClass("toggle_active"))){
		$(".verify_totp").slideUp(200);
		$('.verify_qr').slideUp(200,function(){			
			$('.verify_'+trymode).slideDown(200,function(){
				setFooterPosition();
				if(trymode != 'qr'){
					$('#verify_totp .splitedText').first().focus();
				}
			});
		});
		$('.optionstry').removeClass("toggle_active");
		$('.verify_'+trymode).parent().addClass("toggle_active");
		if(trymode === 'qr' &&  $('#verify_qrimg').css("background-image") === "none"){
			$('.verify_qr .loader,.verify_qr .blur').show();
			enableQRCodeimg();
		}
	}
	return false;
}

function allowedModeChecking(){
	if(secondarymodes.length == 1 || (secondarymodes[1] == "recoverycode" && secondarymodes.length == 2)){
		if(secondarymodes[1] == "recoverycode"){
			$('#recoverOption').show();	
		}
		$('#recoverybtn').show();
		$('#problemrelogin').hide();
	}
	else{
		$('#problemrelogin').show();
		$('#recoverybtn').hide();
	}
	if(isSecondary){
		$('#problemrelogin').show();
		$('#recoverybtn').hide();
	}
	return false;

}

function problemreloginmodes(prob_mode,secondary_header,secondary_desc,index){
	return  "<div class='optionstry options_hover' id='secondary_"+prob_mode+"' onclick=showCurrentMode('"+prob_mode+"',"+index+")>\
			<div class='img_option_try img_option icon-"+prob_mode+"'></div>\
			<div class='option_details_try'>\
				<div class='option_title_try'>"+secondary_header+"</div>\
				<div class='option_description'>"+secondary_desc+"</div>\
			</div>\
			</div>"
}

function showproblemrelogin(ele){
	$(ele).hide();
	remove_err();
	$('#verify_totp_container,.devices .selection,.devicedetails,#try_other_options,#enablemore,.header_for_oneauth').hide();
	clearInterval(_time);
	$(".toggle_active").removeClass("toggle_active");
	window.setTimeout(function(){
		$(".blur").hide();
		$('.blur').removeClass('dark_blur');
	},100);
	//isMobileonly ? $(".passwordless_opt_container").removeClass("heightChange") : $(".passwordless_opt_container").hide();
	$('#trytitle').html('');
	secondarymodes.splice(secondarymodes.indexOf(prev_showmode), 1);
	var currentmode = (prev_showmode === "mzadevice") ? "showmzadevicemodes()" : "goBackToCurrentMode()"; //no i18n
	secondarymodes.unshift(prev_showmode);
	var i18n_msg = {"totp":["IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR","IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC"],"otp": ["IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"],"yubikey":["IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY","IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY.DESC"], "password":["IAM.PASSWORD.VERIFICATION","IAM.RELOGIN.VERIFY.VIA.MFA.PASSWORD.DESC"],"saml":["IAM.RELOGIN.VERIFY.WITH.SAML.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"],"jwt":["IAM.RELOGIN.VERIFY.USING.JWT","IAM.NEW.SIGNIN.SAML.HEADER"],"email": ["IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"],"federated" : ["IAM.RELOGIN.MORE.FEDRATED.ACCOUNTS.TITLE","IAM.RELOGIN.VERIFY.VIA.IDENTITY.PROVIDER.TITLE"],"oidc":["IAM.RELOGIN.MORE.OPENID.ACCOUNTS.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"]}; //No I18N
	var problemrelogininheader = "<div class='problemrelogin_head'><span class='icon-backarrow backoption' onclick=\""+currentmode+"\"></span><span class='rec_head_text'>"+ele.innerText+"</span></div>";
	var allowedmodes_con = "";
	var noofmodes = 0;
	secondarymodes.forEach(function(prob_mode,position){
		var listofmob = userAuthModes.otp && userAuthModes.otp.data;
		if(isValid(listofmob) && listofmob.length > 1 && position === 0 && prob_mode === "otp"){
			listofmob.forEach(function(data, index){
				if(index != mobposition){
					rmobile = numberFormat(data.r_mobile);
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
					noofmodes++;
				}
			});
		}
		if(position != 0){
			if(prob_mode != "recoverycode" && prob_mode != "passphrase"){
				if(prob_mode === 'passkey'){
					//$('#enableotpoption,#resendotp,#lineseparator,.fed_2show,.blur,.loader').hide();
					var secondary_header = I18N.get("IAM.RELOGIN.VERIFY.VIA.PASSKEY");
					var secondary_desc = I18N.get("IAM.RELOGIN.VERIFY.VIA.PASSKEY.DESC");
					allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc);
					//$("#enablemore").hide();
					//$("#tryAnotherSAMLBlueText").hide();
					noofmodes++;
				}
				else if(prob_mode === "oadevice"){
					var oadevice_modes = userAuthModes.oadevice.data;
					oadevice_modes.forEach(function(data,index){
						var oadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var oneauthmode = oadevice_option ==="ONEAUTH_PUSH_NOTIF" ? "push" : oadevice_option === "ONEAUTH_TOTP" ? "totp" : oadevice_option === "ONEAUTH_SCAN_QR" ? "scanqr" : oadevice_option === "ONEAUTH_FACE_ID" ? "faceid": oadevice_option === "ONEAUTH_TOUCH_ID" ? "touchid" : "";//no i18N
						var secondary_header = I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC"),oneauthmode,device_name);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}else if(prob_mode==="mzadevice"){ // no I18N
					var mzadevice_modes = userAuthModes.mzadevice.data;
					mzadevice_modes.forEach(function(data,index){
						var mzadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var secondary_header = I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC"),mzadevice_option,device_name);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}else if(prob_mode==="otp"){//no i18n
					listofmob.forEach(function(data,index){
					//	if(index != mobposition){
							rmobile = numberFormat(data.r_mobile);
							var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
							var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
							allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
							noofmodes++;
					//	}
					});
				}else if(prob_mode==="federated"){ // no i18n
					var fed_option = userAuthModes.federated.data;
					fed_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]));
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.idp);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}else if(prob_mode==="email"){//no i18n
					rmobile = userAuthModes.email.data[0].email;
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc);
					noofmodes++;
				}else if(prob_mode==="saml"){// no i18n
					var saml_option = userAuthModes.saml.data;
					saml_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]),data.auth_domain);
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.domain);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}
				else if(prob_mode==="oidc"){// no i18n
					var oidc_option = userAuthModes.oidc.data;
					oidc_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]));
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.display_name);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}
				else if(prob_mode==="jwt"){// no i18n
					var jwt_option = userAuthModes.jwt.data;
					jwt_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]));
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.domainname);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}
				else{	
					if(i18n_msg[prob_mode]){
						var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
						var secondary_desc = I18N.get(i18n_msg[prob_mode][1]);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc);
						noofmodes++;
					}
				}
			}
			else if(prob_mode === "recoverycode"){
				$('#recoverOption').show();
			}
		} 
	});
	$('#problemreloginui').html(problemrelogininheader +"<div class='problemrelogincon'>"+ allowedmodes_con+"</div>");
	if($(".tryanother").is(":visible")){
		$('.tryanother').hide();
	}
	if(noofmodes > 3){
		$('.problemrelogincon').addClass('problemrelogincontainer');
	}
	$('.optionstry').addClass('optionmod');
	$('#recoverybtn').show();
	var problemmode = allowedmodes[0];
	$('#reauth_button,#problemrelogin,.header_content,.passwordless_opt_container,#mfa_device_container,#relogin_primary_container').hide();
	$('#problemreloginui').show();
	setFooterPosition();
}

function showCurrentMode(pmode,index){
	clearInterval(_time);
	$(".blur,.loader").show();
    $(".sendotp_to_email,.sendotp_to_mobile,.tryanother,#mfa_totp_container,#mfa_scanqr_container").hide();
	prev_showmode = pmode === "federated" ? prev_showmode : pmode; // no i18n
	remove_err();
	//clearCommonError(pmode)
	//var authenticatemode = deviceauthdetails.passwordauth === undefined ? "lookup" : "passwordauth"; // No I18n
	if(pmode==="otp" || pmode==="email"){
		emobile= pmode==="otp" ? userAuthModes.otp.data[index].e_mobile : userAuthModes.email.data[0].e_email;
		rmobile= pmode==="otp" ? numberFormat(userAuthModes.otp.data[index].r_mobile) : userAuthModes.email.data[0].email;
		//if(isPasswordless){
		showAndGenerateOtp(pmode);
		//}
		//else{generateOTP();}
		$('#otp_container .textbox_actions').show();
		$("#mfa_otp").val("");
		mobposition = index;
		isPrimaryDevice = true;
	}else if(pmode === "mzadevice"){//No i18N
		isResend = false;
		mzadevicepos = index;
		$(".blur,.loader").show();
		prefoption = userAuthModes.mzadevice.data[mzadevicepos].prefer_option;
		reloginAuthMode = pmode;
		handleSecondaryDevices(pmode);
		$(".secondary_devices").val(index).change();
		if(prefoption === 'totp'){
			goBackToCurrentMode();
			return false;
		}
	}
	else if(pmode === "totp"){//No i18N
		$("#password_container,.fed_2show,#otp_container").hide();
		$(".header_for_oneauth .header_desc").text(I18N.get('IAM.NEW.SIGNIN.MFA.TOTP.HEADER'));
		$("#reauth_button span").html(I18N.get('IAM.NEW.SIGNIN.VERIFY'));
		$(".header_for_oneauth .head_text").text($(".header_content .head_text").text());
		$("#mfa_totp_container").show();
		reloginAuthMode = pmode;
		splitField.createElement('mfa_totp_field',{
			"splitCount":totp_size,					// No I18N
			"charCountPerSplit" : 1,		// No I18N
			"isNumeric" : true,				// No I18N
			"otpAutocomplete": true,		// No I18N
			"customClass" : "customOtp",	// No I18N
			"inputPlaceholder":'&#9679;',	// No I18N
			"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
		});
		$('#mfa_totp_field .customOtp').attr('onkeypress','remove_err()');
		$("#mfa_totp_field").click();
		$(".blur,.loader").hide();
	}
	else if(pmode === "yubikey" || pmode === "yubikeyreauth"){
		reloginAuthMode = "yubikey"; //No I18N
		goBackToCurrentMode();	
		$(".tryanother,#mfa_totp_container,#mfa_scanqr_container,#relogin_primary_container,#enableotpoption,#resendotp,#password_container").hide();
		$("#reauth_button span").html(I18N.get('IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY'));
		$(".header_for_oneauth").show();
		$(".header_for_oneauth .head_text").text($(".header_content .head_text").text());
		$(".header_for_oneauth .header_desc").text(I18N.get('IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW'));
		$(".blur,.loader,#enablemore,#try_other_options,.header_content").hide();
		$("#tryAnotherSAMLBlueText").show();
		return false;
	}
	else if(pmode === "passkey" || pmode === "passkeyreauth"){
		reloginAuthMode = "passkey"; //No I18N
		goBackToCurrentMode();	
		$(".tryanother,#mfa_totp_container,#mfa_scanqr_container,#relogin_primary_container,#enableotpoption,#resendotp,#password_container").hide();
		$("#reauth_button span").html(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
		$(".blur,.loader,#enablemore,#try_other_options").hide();
		$("#tryAnotherSAMLBlueText").show();
		return false;
	}
	else if(pmode === "password"){//No i18N
		showPasswordContainer();
		$(".showmorereloginoption,.blur,.loader,#tryAnotherSAMLBlueText").hide();
	}else if(pmode === "federated"){//No i18N
		var idp = userAuthModes.federated.data[index].idp.toLowerCase();
		createandSubmitOpenIDForm(idp);
		$(".blur,.loader").hide();
		return false;
	}else if(pmode === "saml"){ // no i18n
		enableSamlAuth(userAuthModes.saml.data[index].auth_domain);
		$(".blur,.loader").hide();
		return false;
	}
	else if(pmode === "jwt"){ // no i18n
		var redirectURI = userAuthModes.jwt.data[index].redirect_uri;
		switchto(redirectURI);
	}
	else if(pmode === "oidc"){ // no i18n
		enableOIDCAuth(userAuthModes.oidc.data[index].oidc_id);
	}
	if(pmode != 'mzadevice' && pmode != 'oadevice'){
		$('.deviceparent').addClass('hide');
	}
	goBackToCurrentMode();
	if(pmode==="otp" || pmode==="email" ||pmode === "mzadevice"){$("#enablemore").hide()}
	$('.devices .selection,#waitbtn,#problemrelogin').hide();
	if(pmode == "mzadevice"){$('#try_other_options').hide();}	// no i18n
	$("#relogin_primary_container").show();
	return false;
}
function showPasswordContainer(){
	$("#relogin_password_input").attr("type","password").val("");		//No i18N
	$('#password_container,#enableforgot').show();
	$('#enableotpoption,.textbox_actions,#otp_container').hide();
	$('#password_container').removeClass('zeroheight');
	changeButtonAction(I18N.get('IAM.CONFIRM.PASS'));//no i18n
	if(isPasswordless)  { allowedModeChecking() };
	$('.relogin_head').css('margin-bottom','30px');
	$('#relogin_password_input').focus();
	reloginAuthMode = "password";// No i18n
}
function showmzadevicemodes(){
	$('.devices .selection').css('display','');
	showTryanotherWay();
	$('#problemreloginui,#recoverybtn').hide();
	allowedModeChecking();
}

function numberFormat(params) {
        for(var i=0;i<userAuthModes.otp.data.length;i++){
            if(userAuthModes.otp.data[i].r_mobile == params){
                return phonePattern.setMobileNumFormat(params.split("-")[1],userAuthModes.otp.data[i].country_code);     
            }
        }
}
function clickedSecondaryMail(emailData,mode){
	$(".blur,.loader").show();
	remove_err();
	if(mode == "email"){
		emobile = emailData.e_email;
		var maskedMail = rmobile = emailData.email;
		$(".email_otp_description span").text(rmobile);
		$(".email_otp_description").show();
		$(".mobile_otp_description").hide();
	}
	else if(mode == "mobile"){
		emobile = emailData.e_mobile;
		var maskedMail = rmobile = emailData.r_mobile.split("-")[1];
		$(".mobile_otp_description span").text(rmobile);
		$(".mobile_otp_description").show();
		$(".email_otp_description").hide();
	}
	$(".reloginWithSecondaryEmails,.reloginWithSecondaryEmailsOTP").hide();
	$(".secondary_verify_desc")[0].childNodes[1].nodeValue=I18N.get("IAM.VERIFY.IDENTITY");					
	
	if(userAuthModes.otp!=undefined && userAuthModes.email!=undefined){
		$(".reloginWithSecondaryEmails").hide();
		$(".reloginWithSecondaryEmailsOTP").show();
	}
	if($(".secondary_email_desc").is(":visible")){
		$(".header_content").hide();
	}		
				
	$(".secondary_verify_desc").css("margin-top","20px").show();//no i18n
	$(".secondary_email_desc,.email_options,.mobile_options").hide();
	$("#reauth_button").show();
	$('#otp_container .textbox_div').show();
	$("#otp_container").slideDown(300);
	splitField.createElement('otp_input_box',{
		"splitCount":otp_length,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$('#otp_input_box .customOtp').attr('onkeypress','remove_err()');
	$(".textbox_actions.otp_actions").show();
	changeButtonAction(I18N.get('IAM.NEW.SIGNIN.VERIFY'));
	generateOTP();
}

function showViaSecondaryMail(){
	remove_err();
	$(".secondary_verify_desc,#otp_container,#other_relogin_options,#password_container,#reauth_button").hide();
	$("#relogin_primary_container,#secondary_email_container,.header_content").show();
	$(".secondary_verify_desc .backoption").attr("onclick","showViaSecondaryMail()");
	$(".secondary_email_desc").html(I18N.get("IAM.REAUTH.SELECT.ONE.EMAIL.ADDRESS")).show();
	if(!$("#secondary_email_container").hasClass("completed")){
		if(userAuthModes.otp!=undefined && userAuthModes.otp.count>1){
			for(var i=0;i<userAuthModes.otp.data.length;i++){
				var div = $("#secondary_mail")[0].cloneNode(true);
				div.setAttribute("id","secondary_mail"+(i+1));
				div.setAttribute("onclick",'clickedSecondaryMail('+JSON.stringify(userAuthModes.otp.data[i])+',"mobile")');
				div.classList.add("mobile_options");//no i18n
				div.querySelector(".icon").classList.add("icon-otp");//no i18n
				div.childNodes[1].textContent=userAuthModes.otp.data[i].r_mobile;
				document.getElementById("secondary_mail").insertAdjacentElement("beforebegin",div);//no i18n
				$("#secondary_mail"+(i+1)).show();
			}
			$("#secondary_email_container").addClass("completed");
			$("#secondary_email_verify_input").attr("placeholder",I18N.get("IAM.ENTER.PHONE.NUMBER"));
			$(".secondary_email_desc").html(I18N.get("IAM.REAUTH.SELECT.ONE.MOBILE.NUMBER"));
		}
		else{
			for(var i=0;i<userAuthModes.email.data.length;i++){
				var div = $("#secondary_mail")[0].cloneNode(true);
				div.setAttribute("id","secondary_mail"+(i+1));
				div.setAttribute("onclick",'clickedSecondaryMail('+JSON.stringify(userAuthModes.email.data[i])+',"email")');
				div.classList.add("email_options");//no i18n
				div.querySelector(".icon").classList.add("icon-email");//no i18n
				div.childNodes[1].textContent=userAuthModes.email.data[i].email;
				document.getElementById("secondary_mail").insertAdjacentElement("beforebegin",div);//no i18n
				$("#secondary_mail"+(i+1)).show();
			}
			$("#secondary_email_container").addClass("completed");
			$("#secondary_email_verify_input").text("placeholder",I18N.get("IAM.ENTER.EMAIL"));//no i18n
		}
		$("#secondary_mail").remove();
	}else{
		$(".email_options").show();
		$(".mobile_options").show();
	}
}

function showOtp() {
	remove_err();
    emobile =  userAuthModes.otp.data[0].e_mobile;
	rmobile =  numberFormat(userAuthModes.otp.data[0].r_mobile);
	showAndGenerateOtp(allowedmodes[1]);
    $("#secondary_email_container,.reloginWithSecondaryEmailsOTP").hide();
    $(".header_content,.reauth_desc,.reloginWithSecondaryEmails").show();
}

function sendOtp(){
	$(".reauth_desc").hide();
	$(".reauth_desc,.sendotp_to_mobile_btn,.mobile_desc").hide();
	showAndGenerateOtp(allowedmodes[0]);
	return false;
}