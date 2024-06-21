//$Id$
var userPrimaryFactor,allowedmodes,prev_showmode,resendTimer,_time,secondarymodes,mobposition;
var isTroubleinVerify = isPasswordless = isWmsRegistered = isResend =false;
var callmode="primary";//no i18N
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
	var serviceParam = "servicename=" + euc(service_name) + "&serviceurl=" + euc(service_url);	// No I18N
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
    			$("#nextbtn span").removeClass("zeroheight");
    			$("#nextbtn").removeClass("changeloadbtn");
    			$("#nextbtn").attr("disabled", false);
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

function verifyUserAuthFactor(f){
	if(reloginAuthMode === "passkey" || reloginAuthMode === "passkeyreauth"){
		$("#reauth_button span").addClass("zeroheight");
		$("#reauth_button").addClass('changeloadbtn');
		$("#reauth_button").attr("disabled", true);
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
		$("#reauth_button span").addClass("zeroheight");
		$("#reauth_button").addClass('changeloadbtn');
		$("#reauth_button").attr("disabled", true);
		var jsonData = {"passwordreauth" : {"password" : passwd}}; //No I18N
		var passwordValidateUrl = "/relogin/v1/primary/"+zuid+"/password";// : "//no i18N
		setTimeout(function(){sendRequestWithCallback(passwordValidateUrl,JSON.stringify(jsonData),true,passwordValidationCallback)},200);
		return false;
	}
	else if(reloginAuthMode === "saml"){
		enableSamlAuth();
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
		var loginurl = "/relogin/v1/primary/"+zuid+"/otp/"+emobile;//no i18N
	//	if(isCaptchaNeeded){loginurl += "&captcha=" +captchavalue+"&cdigest="+cdigest;}
		var jsonData = { 'otpreauth' : { 'code' : OTP_CODE, 'is_resend' : false } };//no i18N
		$("#reauth_button span").addClass("zeroheight");
		$("#reauth_button").addClass('changeloadbtn');
		$("#reauth_button").attr("disabled", true);
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
			else if(myzohototp.length!=6){
				if(isTroubleinVerify){					
					showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"verify_totp_container");//No I18N
				}
				else{
					showAutheticationError(I18N.get("IAM.ERROR.VALID.OTP"),"mfa_totp_container");//No I18N
				}
				return false;
			}
		}
		var loginurl="/relogin/v1/"+callmode+"/"+zuid+"/device/"+deviceid;//no i18N
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
	var isOTP = isSaml = isFederated = isNoPassword = isJwt = isEOTP = false;
	isPrimaryMode =  true;
	allowedmodes = userAuthModes.allowed_modes;
	userPrimaryFactor=prev_showmode = reloginAuthMode = allowedmodes[0];
	var altmode = allowedmodes[1];
	var isOtherModeAvailable = typeof altmode != "undefined";//no i18n
	$(".otp_actions .reloginwithjwt,.otp_actions .reloginwithsaml,.otp_actions .showmorereloginoption,.header_for_oneauth,#try_other_options,.fed_2show,#lineseparator").hide();	//no i18n
	if(allowedmodes[0]==="passkey"){
		if(!isWebAuthNSupported()) {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		}

		$("#relogin_primary_container,#lineseparator,.fed_2show").hide();
		$("#reauth_button span").html(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
		$("#tryAnotherSAMLBlueText").show();
	} 
	if(allowedmodes[0] === "password" || allowedmodes[0] === "federated"){
		$("#relogin_password_input").attr("type","password");		//No i18N
		if(isOtherModeAvailable){
			var samlcount = userAuthModes && userAuthModes.saml && userAuthModes && userAuthModes.saml.count;	
			if((allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("saml") != -1) || (samlcount > 1)){
				$('#enablemore').show();
				$('#enableforgot').hide();
			}else if(allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("jwt") != -1){
				$('#enablemore').show();
				$('#enableforgot').hide();
			}
			else if(allowedmodes.indexOf("otp") != -1 && allowedmodes.indexOf("email") != -1){
				$('#enablemore').show();
				$('#enableforgot').hide();
			}
			else if(allowedmodes.indexOf("saml") != -1 && allowedmodes.indexOf("email") != -1){
				$('#enablemore').show();
				$('#enableforgot').hide();
			}
			else if(allowedmodes.length >= 2){
				allowedmodes.forEach(function(usedmodes){
					switch(usedmodes){
						case "otp": //no i18n
							isOTP = true;
							break;
						case "saml": //no i18n
							isSaml = true;
							break;
						case "jwt": //no i18n
							isJwt = true;
							break;
						case "federated": //no i18n
							isFederated =true;
							break;
						case "password": //no i18n
							isNoPassword = false;
							break;
						case "email": //no i18n
							isEOTP = true;
					}
				});
				enablePassword(isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP);
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
			$("#relogin_password,#lineseparator").hide();
		}
	}
	else if( allowedmodes[0] === "otp" || allowedmodes[0] === "email" ){
		$("#relogin_password_input").attr("type","password");		//No i18N
		emobile = allowedmodes[0] === "otp" ? userAuthModes.otp.data[0].e_mobile : userAuthModes.email.data[0].e_email;
		rmobile = allowedmodes[0] === "otp" ? numberFormat(userAuthModes.otp.data[0].r_mobile) : userAuthModes.email.data[0].email;
		$('#verifywithpass').hide();
		isNoPassword = true;
		if(allowedmodes.length >= 2){
			allowedmodes.forEach(function(usedmodes){
				switch(usedmodes){
					case "otp": //no i18n
						isOTP = true;
						break;
					case "password": //no i18n
						isNoPassword = false;
						break;
					case "saml": //no i18n
						isSaml = true;
						break;
					case "jwt": //no i18n
						isJwt = true;
						break;
					case "federated": //no i18n
						isFederated =true;
						break;
					case "email": //no i18n
						isEOTP = true;
				}
			});
		}
		enablePassword(isOTP, isSaml, isFederated,isNoPassword,isJwt,isEOTP);
		$(".otp_actions .reloginwithjwt,.otp_actions .reloginwithsaml,.otp_actions .showmorereloginoption,#enablemore").hide();
		showAndGenerateOtp(allowedmodes[0]);
		$('#otp_container .textbox_actions').show();
		if(isSaml){
			$("#enablesaml").show();
		}
		setFooterPosition();
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
	else if(allowedmodes[0]==="saml"){
		$(".blur,.loader").hide();
		$("#password_container").slideUp(300);
		if(isOtherModeAvailable){$("#tryAnotherSAMLBlueText").show()}
		changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.USING.SAML'));
		$("#reauth_button").show();
		setFooterPosition();
		return false;
	}
	else if(allowedmodes[0]==="jwt"){
		
		$(".blur,.loader").hide();
		$("#password_container").slideUp(300);
		if(isOtherModeAvailable){$("#tryAnotherSAMLBlueText").show()}
		changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.USING.JWT'));
		$("#reauth_button").show();
		setFooterPosition();
		return false;
	}
	$(".blur,.loader").hide();
}

function enablePasskey(){
	var reauthurl = "/relogin/v1/primary/"+zuid+"/passkey/self";	//no i18N
	sendRequestWithCallback(reauthurl,"",true,passkeyActivtedCallback);
	return false;
}

function passkeyActivtedCallback(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode==="SI203"){
				getAssertionLookup(jsonStr.passkeyreauth);
			}	
		}
		else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showErrorToast(jsonStr.localized_message);
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

function getAssertionLookup(parameters) {
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
	     var passkey_data ={};
	     passkey_data.passkeyreauth = publicKeyCredential;
	     sendRequestWithCallback("/relogin/v1/primary/"+zuid+"/passkey/self",JSON.stringify(passkey_data),true,VerifySuccess,"PUT");//no i18N
	}).catch(function(err) {
		changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));
		if(err.name == 'NotAllowedError') {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError")); //no i18n	
		} else if(err.name == 'InvalidStateError') {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError")); //no i18n
		} else if (err.name == 'AbortError') {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError")); //no i18n
		}else if (err.name == 'TypeError') {
			showErrorToast(I18N.get("IAM.WEBAUTHN.ERROR.TYPE.ERROR"),formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.HELP.HOWTO"),passkeyHelpDoc)); //no i18n
		}
		else {
			showErrorToast(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.ErrorOccurred"),support_email)+ '<br>' +err.toString()); //no i18n
		}
	});
}
function enableSamlAuth(samlAuthDomain){
	if(userAuthModes.saml.data[0].redirect_uri){
		switchto(userAuthModes.saml.data[0].redirect_uri);
		return false;
	}
	samlAuthDomain = samlAuthDomain === undefined ? userAuthModes.saml.data[0].auth_domain : samlAuthDomain;
	var loginurl="/relogin/v1/primary/"+zuid+"/samlreauth/"+samlAuthDomain;//no i18N
	sendRequestWithCallback(loginurl,"",true,handleSamlAuthdetails);
	return false
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

function showMoreReloginOption(isMoreSaml){
	$('#enablemore,#lineseparator,.nopassword_container,#tryAnotherSAMLBlueText').hide();
	if(!isMoreSaml){
		allowedmodes.splice(allowedmodes.indexOf(prev_showmode), 1);
		allowedmodes.unshift(prev_showmode);
	}
	var problemrelogin_con = "";
	var i18n_msg = {"passkey":["IAM.RELOGIN.VERIFY.VIA.PASSKEY","IAM.RELOGIN.VERIFY.VIA.PASSKEY.DESC"],"otp":["IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"],"saml":["IAM.RELOGIN.VERIFY.WITH.SAML.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"], "password":["IAM.RELOGIN.VERIFY.WITH.PASSWORD.TITLE","IAM.RELOGIN.VERIFY.VIA.PASSWORD.HEADER"],"jwt":["IAM.RELOGIN.VERIFY.USING.JWT","IAM.NEW.SIGNIN.SAML.HEADER"],"email":["IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"]}; //No I18N
	var problemrelogininheader = "<div class='problemrelogin_head'><span class='icon-backarrow backoption' onclick='hideOtherReloginOptions()'></span>"+I18N.get("IAM.RELOGIN.VERIFY.ANOTHER.WAY")+"</div>";
	allowedmodes.forEach(function(prob_mode,position){
		if((position != 0) || isMoreSaml){
				var saml_position;
				var secondary_header = i18n_msg[prob_mode] ?  I18N.get(i18n_msg[prob_mode][0]) : "";
				var secondary_desc = i18n_msg[prob_mode] ?  I18N.get(i18n_msg[prob_mode][1]) : "";
				if(prob_mode==="otp"){
					emobile=userAuthModes.otp.data[0].e_mobile;
					rmobile=numberFormat(userAuthModes.otp.data[0].r_mobile);
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					problemrelogin_con += createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="saml"){
					var saml_modes = userAuthModes.saml.data;
					saml_modes.forEach(function(data,index){
						var displayname = userAuthModes.saml.data[index].display_name;
						var domainname = userAuthModes.saml.data[index].domain;
						secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][0]),displayname);
						secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
						saml_position = index;
						problemrelogin_con += createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
					});
				}
				else if(prob_mode==="jwt"){
					var domainname = userAuthModes.jwt.data[0].domain;
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
					problemrelogin_con += createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="email"){
					emobile=userAuthModes.email.data[0].e_email;
					rmobile=userAuthModes.email.data[0].email;
					secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					problemrelogin_con += createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
				}
				else if(prob_mode==="federated"){
					return false;
				}
				else if(prob_mode === "oadevice"){
					var oadevice_modes = userAuthModes.oadevice.data;
					oadevice_modes.forEach(function(data,index){
						var oadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var oneauthmode = oadevice_option ==="ONEAUTH_PUSH_NOTIF" ? "push" : oadevice_option === "ONEAUTH_TOTP" ? "totp" : oadevice_option === "ONEAUTH_SCAN_QR" ? "scanqr" : oadevice_option === "ONEAUTH_FACE_ID" ? "faceid": oadevice_option === "ONEAUTH_TOUCH_ID" ? "touchid" : "";//no i18N
						var secondary_header = I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC"),oneauthmode,device_name);
						problemrelogin_con += createReloginMoreOptions(prob_mode,index,secondary_header,secondary_desc);
					});
				}else if(prob_mode==="mzadevice"){ // no I18N
					var mzadevice_modes = userAuthModes.mzadevice.data;
					mzadevice_modes.forEach(function(data,index){
						var mzadevice_option = data.prefer_option;
						var device_name = data.device_name;
						var secondary_header = I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH");
						var secondary_desc = formatMessage(I18N.get("IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC"),mzadevice_option,device_name);
						problemrelogin_con += createReloginMoreOptions(prob_mode,index,secondary_header,secondary_desc,index);
					});
				}
				else{
					//if(prob_mode != "mzadevice" && prob_mode != "oadevice"){
						problemrelogin_con += createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc);
					//}
				}
		}
	});
	$('#other_relogin_options').html(problemrelogininheader +"<div class='problemrelogincon'>"+ problemrelogin_con+"</div>");
	$('#password_container,#reauth_button,.header_content,#otp_container,.fed_2show').hide();
	$('#other_relogin_options').show();
	setFooterPosition();
	return false;
}

function createReloginMoreOptions(prob_mode,saml_position,secondary_header,secondary_desc){
	var prefer_icon =  prob_mode;
	var secondary_con = "<div class='optionstry options_hover' id='secondary_"+prob_mode+"' onclick=showallowedmodes('"+prob_mode+"','"+saml_position+"')>\
							<div class='img_option_try img_option icon-"+prefer_icon+"'></div>\
							<div class='option_details_try decreasewidth'>\
								<div class='option_title_try'>"+secondary_header+"</div>\
								<div class='option_description'>"+secondary_desc+"</div>\
							</div>\
						</div>"
	return secondary_con;
}

function showallowedmodes(enablemode,mode_index){
	$(".blur,.loader").show();
	if(enablemode === 'saml'){
		enableSamlAuth(userAuthModes.saml.data[mode_index].auth_domain);
		$(".blur,.loader").hide();
		
	}
	else if(enablemode === 'jwt'){
		var redirectURI = userAuthModes.jwt.data[0].redirect_uri;
		switchto(redirectURI);
		$(".blur,.loader").hide();
		
	}
	else if(enablemode === 'otp' || enablemode === 'email'){ //no i18n
		prev_showmode= enablemode === "federated"? prev_showmode : enablemode; // no i18n
		$("#resendotp").show();
		emobile = enablemode === 'email' ? userAuthModes.email.data[0].e_email : userAuthModes.otp.data[0].e_mobile;
		rmobile = enablemode === 'email' ? userAuthModes.email.data[0].email : numberFormat(userAuthModes.otp.data[0].r_mobile);
		$("#otp_container .header_desc").hide();
		if(enablemode === 'email'){
			$(".email_otp_description span").text(rmobile);
			$(".email_otp_description").show();
		}
		else{
			$(".mobile_otp_description span").text(rmobile);
			$(".mobile_otp_description").show();
		}
		showAndGenerateOtp(enablemode);
		$('.textbox_actions,.blueforgotpassword').hide();
		goBackToCurrentMode();
		$("#lineseparator,.fed_2show,#enablemore").show();
	}
	else if(enablemode === 'password'){
		$('#enableotpoption,#resendotp,#relogin_primary_container #waitbtn').hide();
		$(".blueforgotpassword").show();
		prev_showmode= enablemode === "federated"? prev_showmode : enablemode; // no i18n
		showPassword();
		goBackToCurrentMode();	
		if(allowedmodes.length>1){$(".showmorereloginoption").show()}
		$("#lineseparator,.fed_2show").show();
		$(".blur,.loader").hide();
		$('#relogin_password_input').focus();
	}
	else if(enablemode === 'passkey'){
		$('#enableotpoption,#resendotp,#lineseparator,.fed_2show,.blur,.loader').hide();
		goBackToCurrentMode();
		changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));//no i18n
		reloginAuthMode = enablemode;
		prev_showmode = enablemode;
		$("#enablemore,#try_other_options").hide();
		$("#tryAnotherSAMLBlueText").show();
	}
	else if(enablemode === "mzadevice"){//No i18N
		isResend = false;
		isPasswordless=true;
		mzadevicepos = mode_index;
		prev_showmode = enablemode;
		secondarymodes = allowedmodes;
		prefoption = userAuthModes.mzadevice.data[mzadevicepos].prefer_option;
		reloginAuthMode = enablemode;
		handleSecondaryDevices(reloginAuthMode);
		$(".secondary_devices").val(mode_index).change();
		if(prefoption === 'totp'){
			goBackToCurrentMode();
			return false;
		}
		$("#other_relogin_options").hide();
	}
	$("#try_other_options").hide();
	setTimeout(function(){setFooterPosition()},300);
	return false;
}

function goBackToCurrentMode(){
	$('.header_content,.fieldcontainer,#reauth_button,#relogin_primary_container,#try_other_options').show();
	$('#problemreloginui,#other_relogin_options').hide();
	if(prev_showmode === "mzadevice"){$(".tryanother,.devices .selection").show();$("#try_other_options").hide();}	
	if(!($('.secondary_devices option').length > 1 )){
		$('.downarrow').hide();
		$('.devices .selection').css("pointer-events", "none");
	}
	if(prev_showmode === "password"){$("#enablemore").show();$('#relogin_password_input').focus();}
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
	if(allowedmodes[0] !== "passkey"){$("#lineseparator,.fed_2show").show();}
	setFooterPosition();
	return false;
} 

function enablePassword(isOTP,isSaml,isFederated,isNoPassword,isJwt,isEOTP){
	$(".blur,.loader").hide();
	if(!isFederated && isNoPassword && isOTP){
		$("#relogin_password .textbox_div,#reauth_button").hide()
		$(".nopassword_container").css("position","unset");
		$(".nopassword_container").css("width","100%");
		$(".nopassword_container,#otp_container,#otp_container .textbox_div").show();
		return false;
	}
	$("#relogin_password_input").attr("type","password");		//No i18N
	$("#relogin_password_input").focus();
	if (isOTP && isEOTP){
		$("#enablemore").hide();
		$('#enableforgot').hide();
	}else if(isOTP){
		$("#enableotpoption").show();
		$("#enableotpoption #reloginwithotp").attr("onclick","showAndGenerateOtp('moblie')");
		emobile=userAuthModes.otp.data[0].e_mobile;
		rmobile=numberFormat(userAuthModes.otp.data[0].r_mobile);
	}else if(isEOTP){
		$("#enableotpoption").show();
		$("#enableotpoption #reloginwithotp").attr("onclick","showAndGenerateOtp('email')");
		emobile=userAuthModes.email.data[0].e_email;
		rmobile=userAuthModes.email.data[0].email;
	}
	if(isSaml){
		$("#enablesaml").show();
	}if (isFederated){
		$(".fed_2show,#lineseparator").show();
		//$(".fed_div").hide();
		if(!isOTP && !isSaml){ $("#enableforgot").show()};
		var idps = userAuthModes.federated.data;
//		idps.forEach(function(idps){
//			if(isValid(idps)){
//				idp = idps.idp.toLowerCase();
//				$("."+idp+"_fed").attr("style","display:block !important");
//            }
//		});
		if((isNoPassword && isFederated) && (!isOTP && !isEOTP)){
			$("#password_container .textbox_div,#nextbtn").hide()
			$(".nopassword_container").css("position","absolute");
			$(".nopassword_container").show();
		}
	}if(!isNoPassword){
		$("#verifywithpass").show();
	}
	if(isJwt){
		$("#enablejwt").show();
		var redirectURI = userAuthModes.jwt.data[0].redirect_uri;
		$(".reloginwithjwt").attr("href",redirectURI);
	}
	if(isOTP && isSaml && !isNoPassword){
		$('#enablemore').show();
		$('#enableforgot').hide();
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
		$('.service_name').html(formatMessage(I18N.get("IAM.NEW.SIGNIN.SERVICE.NAME.TITLE"),""));
		$('#headtitle').text(I18N.get("IAM.SIGN_IN"));
		$("#nextbtn span").text(I18N.get('IAM.SIGN_IN'));
		//$('.username').text(deviceauthdetails.lookup.loginid);
		resendotp_checking();
		//if (!isRecovery) {allowedModeChecking();}
		allowedModeChecking();
	}
	return false;
	
}
function generateOTP(isResendOnly){
	var loginurl = "/relogin/v1/primary/"+zuid+"/otp/"+emobile;//no i18N
	var callback = isResendOnly ? showResendInfo : enableOTPDetails;
	!isResendOnly ? sendRequestWithCallback(loginurl,"",true,callback) : sendRequestWithCallback(loginurl,JSON.stringify({"otpreauth" : {"is_resend" : true }}),true,callback)//no i18n
	return false;
}

function changeButtonAction(textvalue){
	$("#reauth_button span").removeClass("zeroheight");
	$("#reauth_button").removeClass("changeloadbtn");
	$("#reauth_button").attr("disabled", false);
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
			if(successCode === "SI204" || successCode === "SI304"){
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
			if(successCode === "SI204" || successCode === "SI304"){
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
		setTimeout(function(){$(".blur,.loader").hide()},300);
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "RA002"){
				//isSecondary = deviceauthdetails.passwordauth && deviceauthdetails.passwordauth.modes.otp.count > 1 || (allowedmodes.length >1 && allowedmodes.indexOf("recoverycode") === -1) ? true : false; // no i18n
				if(reloginAuthMode === "otpreauth"){
					//clearCommonError("otp"); // no i18n
					showSuccessToast(formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),rmobile));
					resendotp_checking();
					allowedmodes.indexOf("saml") != -1 ? $(".otp_actions .reloginwithsaml").show() : $(".otp_actions .reloginwithsaml").hide();
					allowedmodes.indexOf("jwt") != -1 ? $(".otp_actions .reloginwithjwt").show() : $(".otp_actions .reloginwithjwt").hide();
					if(allowedmodes.indexOf("saml") != -1 && allowedmodes.indexOf("jwt") != -1 || allowedmodes.length>2){
						$(".otp_actions .showmorereloginoption").show();
						$(".otp_actions .reloginwithjwt,.otp_actions .reloginwithsaml,.otp_actions #verifywithpass").hide();
					}
					else{
						$(".otp_actions .showmorereloginoption").hide();
					}
					if(isPasswordless){$(".otp_actions .showmorereloginoption").hide()}
					$("#otp_input_box .empty_field:first").focus();
					return false;	
				}
				resendotp_checking();
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
	var loginurl="/relogin/v1/primary/"+zuid+"/device/"+deviceid;//no i18N
	var jsonData = {'devicereauth':{'devicepref':prefoption }};//no i18N
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),true,handleMyZohoDetails);
	//signinathmode = callmode==="primary" ?"deviceauth":"devicesecauth";//no i18N
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
			if(successCode === "SI302"|| successCode === "SI300" || successCode === "SI301" || successCode === "SI204" || successCode === "SI304"){
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
		$(".blur,.loader").hide();
		var jsonStr = JSON.parse(resp);
		reloginAuthMode = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode === "RA001"||successCode==="MFA302"){
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
				$(".header_content,#password_container,#lineseparator,.fed_2show,#otp_container,.deviceparent").hide();
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
	        				isFormSubmited = false;
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
				isFormSubmited = false;
			//	signinathmode = callmode === "primary" ? "deviceauth" : "devicesecauth";//no i18N
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
	$(".header_content,#password_container,#lineseparator,.fed_2show,#otp_container,#forgotpassword").hide();
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
		"splitCount":6,					// No I18N
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
	isFormSubmited = false;
	var mzauth = callmode==="primary" ?"deviceauth":"devicesecauth";//no i18N
	//signinathmode = isMyZohoApp ? mzauth : "oneauthsec";//No i18N
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
		isFormSubmited = false;
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
				$(".secondary_devices").select2({
			        allowClear: true,
			        dropdownAutoWidth: true,
			        templateResult: secondaryFormat,
			        minimumResultsForSearch: Infinity,
			        templateSelection: function (option) {
			              return "<div><span class='icon-device select_icon'></span><span class='select_con options_selct' value="+$(option.element).attr("value")+" version="+$(option.element).attr("version")+">"+option.text+"</span><span class='downarrow'></span></div>";
			        },
			        escapeMarkup: function (m) {
			          return m;
			        }
			      });
				window.setTimeout(function(){
					  $('.devices .select2').addClass("device_select");
					  $('.devices .select2').show();
					  $('.devices .select2-selection--single').addClass('device_selection');
					  $(".select2-selection__arrow").addClass("hide");
					  if(!($('.secondary_devices option').length > 1 )){
							$('.devices .downarrow').hide();
							$('.devices .selection').css("pointer-events", "none");
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
	var loginurl = isMyZohoApp ? "/relogin/v1/"+callmode+"/"+zuid+"/device/"+deviceid+"?polling=true":null;//no i18N
	//loginurl += "digest="+digest+ "&" + signinParams+"&polling="+true ; //no i18N
	var jsonData = {'oneauthsec':{'devicepref':prefmode }};//no i18N
	if(isMyZohoApp){
		jsonData = callmode==="primary" ? {'devicereauth':{'devicepref':prefmode }} : {'devicesecauth':{'devicepref':prefmode }};//no i18N
	}
	sendRequestWithCallback(loginurl,JSON.stringify(jsonData),false,VerifySuccess,"PUT");//No i18N
	verifyCount++;
	if(isValid(WmsID) && WmsID!="undefined"){
		wmscount++;
		var callIntervalTime = wmscount < 6 ? 5000 : 25000;
		_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\")", callIntervalTime);//No I18N
		return false;
	}else{
		_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\")", 3000);//No I18N
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
			if(statusmsg==="success" || successCode === "SI302"|| successCode === "SI300" || successCode === "SI301" || successCode === "SI204" || successCode === "SI304"){
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
		else if(reloginAuthMode === "passkey"){
			$("#reauth_button span").removeClass("zeroheight");
			$("#reauth_button").removeClass("changeloadbtn");
			$("#reauth_button").attr("disabled", false);
			showErrorToast(I18N.get("IAM.ERROR.GENERAL"));
			return false;
		}
	}
	return false;
}

function showTryanotherWay(){
	clearInterval(_time);
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
	$('#problemrelogin').show();
	isTroubleinVerify =  true;
	setFooterPosition();
	return false;
}

function enableQRCodeimg(){
	prefoption = "scanqr"; // no i18n
	var deviceid = userAuthModes.mzadevice.data[parseInt($(".secondary_devices").children("option:selected").val())].device_id;
	var loginurl="/relogin/v1/"+callmode+"/"+zuid+"/device/"+deviceid;//no i18N
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
			if(successCode === "RA001" || successCode === "SI202"||successCode==="MFA302" || successCode==="SI302" || successCode==="SI201"){
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
			"splitCount":6,					// No I18N
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
	$('#verify_totp_container,.devices .selection,.devicedetails,#try_other_options,#enablemore').hide();
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
	var i18n_msg = {"totp":["IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR","IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC"],"otp": ["IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"],"yubikey":["IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY","IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY.DESC"], "password":["IAM.PASSWORD.VERIFICATION","IAM.RELOGIN.VERIFY.VIA.MFA.PASSWORD.DESC"],"saml":["IAM.RELOGIN.VERIFY.WITH.SAML.TITLE","IAM.NEW.SIGNIN.SAML.HEADER"],"jwt":["IAM.RELOGIN.VERIFY.USING.JWT","IAM.NEW.SIGNIN.SAML.HEADER"],"email": ["IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING","IAM.NEW.SIGNIN.OTP.HEADER"]}; //No I18N
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
					changeButtonAction(I18N.get('IAM.RELOGIN.VERIFY.VIA.PASSKEY'));//no i18n
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
					var count = userAuthModes.federated.count;
					var idp = userAuthModes.federated.data[0].idp.toLocaleLowerCase();
					var secondary_header = count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.TITLE") : "<span style='text-transform: capitalize;'>"+idp+"</span>";
					var secondary_desc =  count > 1 ? I18N.get("IAM.NEW.SIGNIN.MORE.FEDRATED.ACCOUNTS.DESC") : formatMessage(I18N.get("IAM.RELOGIN.VERIFY.VIA.IDENTITY.PROVIDER.TITLE"),idp);
					allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,count);
					noofmodes++;
				}else if(prob_mode==="email"){//no i18n
					rmobile = userAuthModes.email.data[0].email;
					var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
					var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),rmobile);
					allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc);
					noofmodes++;
				}else if(prob_mode==="saml"){// no i18n
					var saml_option = userAuthModes.saml.data;
					saml_option.forEach(function(data,index){
						var secondary_header = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.auth_domain);
						var secondary_desc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),data.domain);
						allowedmodes_con += problemreloginmodes(prob_mode,secondary_header,secondary_desc,index);
						noofmodes++;
					});
				}
				else{	
					if(i18n_msg[prob_mode]){
						var jwtDesc;
						if(prob_mode==="jwt"){
							var domainname = userAuthModes.jwt.data[0].domain;
							jwtDesc = formatMessage(I18N.get(i18n_msg[prob_mode][1]),domainname);
						}
						var secondary_header = I18N.get(i18n_msg[prob_mode][0]);
						var secondary_desc = prob_mode==="jwt" ? jwtDesc : I18N.get(i18n_msg[prob_mode][1]);
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
	$('.optionstry').addClass('optionmod')
	$('#recoverybtn').show();
	var problemmode = allowedmodes[0];
	$('#reauth_button,#problemrelogin,.header_content,.passwordless_opt_container,#mfa_device_container,#relogin_primary_container').hide();
	$('#problemreloginui').show();
	setFooterPosition();
}

function showCurrentMode(pmode,index){
	clearInterval(_time);
	$(".blur,.loader").show();
	$(".tryanother,#mfa_totp_container,#mfa_scanqr_container").hide();
	prev_showmode = pmode === "federated" ? prev_showmode : pmode; // no i18n
	remove_err();
	//clearCommonError(pmode)
	//var authenticatemode = deviceauthdetails.passwordauth === undefined ? "lookup" : "passwordauth"; // No I18n
	if(pmode==="otp" || pmode==="email"){
		emobile= pmode==="otp" ? userAuthModes.otp.data[index].e_mobile : userAuthModes.email.data[0].e_email;
		rmobile= pmode==="otp" ? numberFormat(userAuthModes.otp.data[index].r_mobile) : userAuthModes.email.data[0].email;
		if(isPasswordless){
			showAndGenerateOtp(pmode);
		}
		else{generateOTP();}
		$('#otp_container .textbox_actions').show();
		$("#mfa_otp").val("");
		mobposition = index;
		isPrimaryDevice = true;
	}else if(pmode === "mzadevice"){//No i18N
		isResend = false;
		mzadevicepos = index;
		prefoption = userAuthModes.mzadevice.data[mzadevicepos].prefer_option;
		reloginAuthMode = pmode;
		$(".secondary_devices").val(index).change();
		if(prefoption === 'totp'){
			goBackToCurrentMode();
			return false;
		}
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
		$(".showmorereloginoption,.blur,.loader").hide();
	}else if(pmode === "federated"){//No i18N
		var idp = userAuthModes.federated.data[0].idp.toLowerCase();
		index === 1 ? createandSubmitOpenIDForm(idp) : showMoreFedOptions();
		$(".blur,.loader").hide();
		return false;
	}else if(pmode === "saml"){ // no i18n
		enableSamlAuth(userAuthModes.saml.data[index].auth_domain);
		$(".blur,.loader").hide();
		return false;
	}
	else if(pmode === "jwt"){ // no i18n
		var redirectURI = userAuthModes.jwt.data[0].redirect_uri;
		switchto(redirectURI);
	}
	if(pmode != 'mzadevice' && pmode != 'oadevice'){
		$('.deviceparent').addClass('hide');
	}
	goBackToCurrentMode();
	if(pmode==="otp" || pmode==="email" ||pmode === "mzadevice"){$("#enablemore").hide()}
	$('.devices .selection,#waitbtn,#problemrelogin').hide();
	pmode != "mzadevice" ? $('#try_other_options').show() : $('#try_other_options').hide();		// no i18n
	$("#relogin_primary_container").show();
	return false;
}
function showPasswordContainer(){
	$("#relogin_password_input").attr("type","password").val("");		//No i18N
	$('#password_container,#enableforgot').show();
	$('#enablesaml,#enableotpoption,.textbox_actions,#otp_container').hide();
	$('#password_container').removeClass('zeroheight');
	changeButtonAction(I18N.get('IAM.CONFIRM.PASS'));//no i18n
	if(isPasswordless)  { allowedModeChecking() };
	$('.relogin_head').css('margin-bottom','30px');
	$('#relogin_password_input').focus();
	reloginAuthMode = "password";// No i18n
	isFormSubmited = false;
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
