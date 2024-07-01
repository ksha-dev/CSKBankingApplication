//$Id$
var resendTimer, resendtiming, altered;
var ReverseAuth = ZResource.extendClass({
	resourceName: "DeviceRevAuth", //No I18N
	path: "device" //No I18N
});
var ReverseVerify = ZResource.extendClass({
	resourceName: "DeviceRevVerify", //No I18N
	path: "device/verify", //No I18N
	identifier: "token", //No I18N
	attrs : ["token", "code"] //No I18N
});
/////////////////
var Account = ZResource.extendClass({
	resourceName: "Account",//No I18N
	identifier: "zaid"	//No I18N  
});
var User  = ZResource.extendClass({
	resourceName: "User",//No I18N
	identifier: "zuid",	//No I18N 
	attrs : [ "first_name","last_name","display_name","gender","country","language","timezone","state" ], // No i18N
	parent : Account
});
var Mfa = ZResource.extendClass({ 
	resourceName: "MFA",//No I18N
	identifier: "mode",	//No I18N 
	attrs : ["activate","makeprimary","mode","primary"],// No i18N
	parent : User
});
var MfaTOTP=  ZResource.extendClass({ 
	resourceName: "TOTP",//No I18N
	attrs : ["code"], // No i18N
	path : 'totp',// No i18N
	parent : Mfa
});
var MfaMobile = ZResource.extendClass({ 
	resourceName: "MFAMobile",//No I18N
	attrs : ["mobile","countrycode","code"], // No i18N
	path : 'mobile',// No i18N
	identifier: "number",	//No I18N 
	parent : Mfa
});
var MfaDevice = ZResource.extendClass({ 
	resourceName: "Device",//No I18N
	identifier: "device_token",	//No I18N 
	parent : Mfa
});
var MfaYubikey = ZResource.extendClass({ 
	resourceName: "MFAYubikey",//No I18N
	path : 'yubikey',// No i18N
	attrs : [ "key_name","id","type","rawId","extensions","response"],// No i18N
	parent : Mfa
});
var BackupCodes = ZResource.extendClass({ 
	resourceName: "BackupCodes",//No I18N
	parent : User
});
var Phone = ZResource.extendClass({
	resourceName: "Phone",//No I18N
	identifier: "phonenum",	//No I18N 
	parent : User
});
var MobileMakeMfa = ZResource.extendClass({
	resourceName: "makemfa",//No I18N
	parent : Phone
});
var BackupCodesStatus = ZResource.extendClass({ 
	  resourceName: "status",//No I18N
	  path : 'status',//No I18N 
	  attrs : ["status"], //No I18N
	  parent : BackupCodes
});

function isOTPValid(code , istotp){
	if(code.length != 0){
		if(istotp){
			var totpsize =Number(totpConfigSize);
			var codePattern = new RegExp("^([0-9]{"+totpsize+"})$");
			if(codePattern.test(code)){
				return true;
			}
		} else {
			var codePattern = new RegExp("^([0-9]{7})$");
			if(codePattern.test(code)){
				return true;
			}
		}
	}
	return false;
}

function makeCredential(options) {
  var makeCredentialOptions = {};
    makeCredentialOptions.rp = options.rp;
    makeCredentialOptions.user = options.user;
    makeCredentialOptions.user.id = strToBin(options.user.id);
    makeCredentialOptions.challenge = strToBin(options.challenge);
    makeCredentialOptions.pubKeyCredParams = options.pubKeyCredParams;
    makeCredentialOptions.timeout  = options.timeout;
    makeCredentialOptions.extensions = {};
    if ('extensions' in options) {
		if ('appidExclude' in options.extensions) {
			makeCredentialOptions.extensions.appidExclude = options.extensions.appidExclude;
		}
	}
    if ('excludeCredentials' in options) {
      makeCredentialOptions.excludeCredentials = credentialListConversion(options.excludeCredentials);
    }
    if ('authenticatorSelection' in options) {
      makeCredentialOptions.authenticatorSelection = options.authenticatorSelection;
    }
    if ('attestation' in options) {
      makeCredentialOptions.attestation = options.attestation;
    }
    return navigator.credentials.create({
      "publicKey": makeCredentialOptions //No I18N
    }).then(function(attestation){
	    $('.yubikey-two').slideUp(300);
	    $('.yubikey-three').slideDown(300, function(){
			$("#yubikey_input").focus();
		});
        var publicKeyCredential = {};
        if ('id' in attestation) {
          publicKeyCredential.id = attestation.id;
        }
        if ('type' in attestation) {
          publicKeyCredential.type = attestation.type;
        }
        if ('rawId' in attestation) {
          publicKeyCredential.rawId = binToStr(attestation.rawId);
        }
        if (!attestation.response) {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.InvalidResponse"));//No I18N
        }
        var response = {};
        response.clientDataJSON = binToStr(attestation.response.clientDataJSON);
        response.attestationObject = binToStr(attestation.response.attestationObject);

        if (attestation.response.getTransports) {
          response.transports = attestation.response.getTransports();
        }

        publicKeyCredential.response = response;
        credential_data =  publicKeyCredential;
      }).catch(function(err){ 
    	  if(err.name == 'NotAllowedError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError"));
    	  } else if(err.name == 'InvalidStateError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.InvalidStateError"));
		  } else if(err.name == 'NotSupportedError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.NotSupportedError"));
    	  } else if(err.name == 'AbortError') {
			showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError"));
    	  } else {
			showErrMsg(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.ErrorOccurred"),accounts_support_contact_email_id)+ '<br>' +err.toString()); //no i18n
    	  }
    	  yubikeyOneStepBack();
      });
}

function popup_blurHandler(ind) {
	$(".blur").show();
    $(".blur").css({"z-index":ind, "background-color": "#00000099", opacity: "1" });
    $("body").css({
    	overflow: "hidden" //No I18N
    });
    $(".blur").bind("click", function(){
		$(".delete-cancel-btn").click();
		if($(".msg-popups .oneauth-headerandoptions2:visible").length || $(".msg-popups .bio-steps:visible").length ||
			$(".msg-popups .relogin-desc:visible").length){
			$(".pop-close-btn").click();
		}
		if($(".msg-popups .swap-desc1:visible").length){
			$(".msg-popups .cancel-btn").click();
		}
		if($(".qr-cont-wrap.qr-exp:visible").length){
			collapseQR();
		}
	})
}
function closePopup(){
	//Dint implement a popup callback since the popups are less
	if($(".confirm-swap:visible").length){
		$(".already-verified-recovery .verified-selected").removeClass("verified-selected");
	}
	if($(".oneauth-headerandoptions2:visible").length){
		setTimeout(function(){
			$(".popup-body").removeClass("padding-oneauthpop");
			$(".msg-popups").css("max-width","600px");
			$(".popup-header").show();
		},200)
		}
	$(".msg-popups").slideUp(200, function(){
		removeBlur();
	});
}
function remove_error(ele) {
	if (ele) {
		$(ele).siblings(".field_error").remove();
	} else {
		$(".field_error").remove();
	}
}
function show_error_msg(sibilingClassorID, msg) {
	var errordiv = document.createElement("div");
    errordiv.classList.add("error_msg"); //No I18N
    errordiv.textContent = msg;
    $(errordiv).insertAfter(sibilingClassorID);
    $(".error_msg").slideDown(150); //No I18N
}
function submitForm(event){
	if($(".error_msg:visible").length){
		return false;
	}	
	event.target.querySelector(".verify-btn").click(); //No I18N
}
var prevSelect;
var selectObj = {};
function selectandslide(e) {
if(isPhased){
	var parID = $(e.target).closest(".modes-container")[0].id
	var prevSelet;
	if(selectObj[parID] != undefined){
		prevSelet = selectObj[parID];
	}
	//for unselecting the selected number or device
	if(e.target.parentNode.classList.contains("sms-container") || e.target.parentNode.classList.contains("oneauth-container")){
		if(e.target.parentNode.querySelector(".verified-selected")){
			e.target.parentNode.querySelector(".verified-selected").classList.remove("verified-selected") //No I18N
			$(".pref-info.pref").remove();
			smsPrevSelect = "";
		}
	} 
	//actual selectandslide
	if(prevSelet != undefined && prevSelet.parentNode.classList.contains("oneauth-container")){
		if(!mfaData.devices|| !mfaData.devices.count){
			$(e.target.nextElementSibling).slideDown(250);
			if (prevSelet.nextElementSibling != e.target.nextElementSibling ) {
				prevSelet.querySelector(".tag").style.opacity = "1"; //No I18N
				$(prevSelet.nextElementSibling).slideUp(250, function(){
				});
				prevSelet.classList.remove("empty-oneauth-header"); //No I18N
			}
		}else if(mfaData.devices.count){
			$(e.target.nextElementSibling).slideDown(250);
			if (prevSelet.nextElementSibling != e.target.nextElementSibling ) {
				prevSelet.querySelector(".tag").style.opacity = "1"; //No I18N
				$(prevSelet.nextElementSibling).slideUp(250);
			}
		}
	} else if(e.target.parentNode.classList.contains("oneauth-container") && (!mfaData.devices|| !mfaData.devices.count)){ //No I18N
		e.target.querySelector(".tag").style.opacity = "0" //No I18N
		$(e.target.nextElementSibling).slideDown(250, function(){
				//e.target.nextElementSibling.style.overflow="unset"; //No I18N
		});
		e.target.classList.add("empty-oneauth-header"); //No I18N
		$(e.target).children(".add-oneauth").slideDown(200);
		!isMobile && showReverseSignin();
		if (prevSelet != undefined && prevSelet.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelet.nextElementSibling).slideUp(250);
			prevSelet.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	} else {
		$(e.target.nextElementSibling).slideDown(250);
		if (prevSelet != undefined && prevSelet.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelet.nextElementSibling).slideUp(250);
			prevSelet.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	selectObj[parID] = e.target;
} else {
	//temporary handling for one-header click
	if(e.target.classList.contains("oneauth-head-text") && e.target.closest(".empty-oneauth-header") != null){ //No I18N
		window.open("https://zurl.to/mfa_banner_oaweb", "_blank"); //No I18N
		return;
	}
	if(e.target.classList.contains("add-oneauth") || e.target.classList.contains("down-badges") || e.target.classList.contains("download") || e.target.classList.contains("common-btn")){ //No I18N
		return;
	}
	//for unselecting the selected number or device
	if(e.target.parentNode.classList.contains("sms-container") || e.target.parentNode.classList.contains("oneauth-container")){
		if(e.target.parentNode.querySelector(".verified-selected")){
			e.target.parentNode.querySelector(".verified-selected").classList.remove("verified-selected") //No I18N
			$(".pref-info.pref").remove();
			smsPrevSelect = "";
		}
	} 
	//actual selectandslide
	if(prevSelect != undefined && prevSelect.parentNode.classList.contains("oneauth-container") && (!mfaData.devices|| !mfaData.devices.count)){
		$(e.target.nextElementSibling).slideDown(250);
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			prevSelect.querySelector(".tag").style.opacity = "1"; //No I18N
			prevSelect.querySelector(".mode-icon").classList.remove("mode-icon-large") //No I18N
			prevSelect.nextElementSibling.style.overflow="hidden"; //No I18N
			$(prevSelect).children(".add-oneauth").slideUp(200);
			prevSelect.classList.remove("empty-oneauth-header"); //No I18N
			prevSelect.querySelector(".add-qr").classList.remove("qr-anim"); //No I18N
			prevSelect.querySelector(".oneauth-desc").style.display = "none"; //No I18N
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	else if(e.target.parentNode.classList.contains("oneauth-container") && (!mfaData.devices|| !mfaData.devices.count)){
		$(e.target.nextElementSibling).slideDown(250, function(){
				e.target.nextElementSibling.style.overflow="unset"; //No I18N
			e.target.querySelector(".add-qr").classList.add("qr-anim") //No I18N
			e.target.classList.add("empty-oneauth-header"); //No I18N
		});
		$(e.target).children(".add-oneauth").slideDown(200);
		e.target.querySelector(".tag").style.opacity = "0" //No I18N
		e.target.querySelector(".mode-icon").classList.add("mode-icon-large") //No I18N
		e.target.querySelector(".mode-header-texts").classList.add("oneauth-head-text"); //No I18N
		e.target.querySelector(".oneauth-desc").style.display = "block";
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}else {
		$(e.target.nextElementSibling).slideDown(250);
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	prevSelect = e.target;
	}

}

var hardKeyTransition;
function addNewYubikey(e) {
	if(e.target.parentNode.classList.contains("already-yubikey-conf")){
		$(".yubikey-one button.back-btn").attr("onclick", "yubikeyAlreadyStepBack()");
		$(".yubikey-one button.back-btn").show();
	}
	if(isMobile && hardKeyTransition === undefined){
		$(".dot_status .dot").removeClass('grow_width');
		$(".dot_status .dot_1").addClass("grow_width");
		hardKeyTransition = setInterval(function(){
		    var cur_grow = $(".dot_status .grow_width");
		    cur_grow.removeClass('grow_width');
		    cur_grow.siblings('.dot').addClass('grow_width');
		    $(".yubikey_anim_container").toggleClass('move_pic');
		},5000)
	}
    $(".sms-container, .totp-container, .oneauth-container").slideUp(200);
    $(".yubikey-body .already-yubikey-conf, .add-new-yubikey").slideUp(200);
    $(".new-yubikey").slideDown(200);
    if(nModes > 1){
		$(".yubikey-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(200);
	}
}

function scanYubikey(e){
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No i18N
	var params = {};
	var payload = MfaYubikey.create(params);
	payload.POST("self","self","mode").then(function(resp) //No I18N
    {
		$(".yubikey-one").slideUp(200, function(){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
		});
		$(".yubikey-two").slideDown(200);
		if(resp != null)
		{
			yubikey_challenge=resp.mfayubikey[0];
			makeCredential(yubikey_challenge);
		}
    },
    function(resp){
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}

function configureYubikey(e)
{
	if(!isWebAuthNSupported()) {
		showErrMsg(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	var name=$("#yubikey_input").val().trim();
	if(isEmpty(name)) {
		show_error_msg("#yubikey_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return false;
	} else if(name.length > 50) {
		show_error_msg("#yubikey_input", I18N.get("IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR"));//No I18N
		return false;
	} else if(!isValidSecurityKeyName(name)) {
		show_error_msg("#yubikey_input", I18N.get("IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR"));//No I18N
		return false;
	} else {
		yname  = name.toUpperCase();
		if(mfaData.yubikey && mfaData.yubikey.yubikey){
			for(y=0;y<mfaData.yubikey.count;y++){
				if(mfaData.yubikey.yubikey[y].key_name && decodeHTML(mfaData.yubikey.yubikey[y].key_name.toUpperCase()) === yname) {
					show_error_msg("#yubikey_input", I18N.get("IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY"));//No I18N
					return false;
				}
			}
		}
		if(mfaData.passkey && mfaData.passkey.passkey){
			for(y=0;y<mfaData.passkey.count;y++){
				if(mfaData.passkey.passkey[y].key_name && decodeHTML(mfaData.passkey.passkey[y].key_name.toUpperCase()) === yname) {
					show_error_msg("#yubikey_input", I18N.get("IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY"));//No I18N
					return false;
				}
			}
		}
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No i18N
	credential_data.key_name = name;
	var payload = MfaYubikey.create(credential_data);
	payload.PUT("self","self","mode","self").then(function(resp){	//No I18N
		if(resp.code === "Y201"){	
		$(".configure-btn span")[0].classList.remove("loader");
		if(mfaData.modes.length==0 || (mfaData.modes.length==1 && mfaData.modes[0] == "otp")){
			setTimeout(function(){
				showSuccessMfapop();
			},1000)
				return;	
		}else{
			showErrMsg(resp.localized_message, true);
		}
		var yubiObject ={key_name: name, created_time_elapsed: I18N.get("IAM.JUST.NOW"), yubikey: true, e_keyName: resp.mfayubikey.yubikey.e_keyName}; //No I18n
		if(keyCount){
			mfaData.yubikey.yubikey.push(yubiObject);
			mfaData.yubikey.count = keyCount+1;
		}else{
			mfaData.yubikey = {"yubikey":[yubiObject]}
			Object.assign(mfaData.yubikey, {"count":1});  //No I18n
			keyCount = 0;
		}
		addConfiguredYubikey({"yubikey": [yubiObject]}, true);
		yubiObject = {};
		setTimeout(function(){
			$(".new-yubikey").slideUp(250);
			$(".already-yubikey-conf").slideDown(250);
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
			$(".yubikey-two, .yubikey-three").hide();
			$("#yubikey_input").val("");
			$(".yubikey-one").show();
			$(".yubikey-body .hidden-checkbox")[0].classList.add("verified-selected");
			$(".yubikey-container .mode-header").click();
		}, 200);
		}
    },
    function(resp)
	{
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
    		classifyError(resp, "#yubikey_input"); //No I18n
    	}
	});
}

function yubikeyAlreadyStepBack(){
	$(".new-yubikey").slideUp(300);
	$(".already-yubikey-conf").slideDown(300,function(){
		$(".yubikey-container .mode-header").click();
	});
}
function yubikeyStepBack(){
	$(".new-yubikey").slideUp(300);
	$(".add-new-yubikey").slideDown(300);
}
function yubikeyOneStepBack(){
	$(".new-yubikey .yubikey-three, .new-yubikey .yubikey-two").slideUp(300, function(){
		document.querySelector("#yubikey_input").value = ""; //No I18n
		clearError("#yubikey_input"); //No I18n
	});
	$(".new-yubikey .yubikey-one").slideDown(300);
}

function numbOnly(e){
	e.target.value = e.target.value.slice(0, e.target.value.length).replace(/[^0-9]/gi, "");
}
var encKey;

function allowSubmit(e) {
	if(mobile === e.target.value || mobile === ""){
		altered=false;
		if (!resendtiming == 0) {
			$(".send_otp_btn").prop("disabled", true);
		}
	}
	else {
		altered = true;
		$(".send_otp_btn span").html("");
		$(".send_otp_btn").prop("disabled", false);
		resendtiming = 1;
	}
}
function resendOtpChecking() {
	resendtiming = 60;
	clearInterval(resendTimer);
	$(".resend_otp").addClass("nonclickelem");
	$(".resend_otp span").text(resendtiming);
	$(".resend_otp").html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
	$(".send_otp_btn").prop("disabled", true);
	resendTimer = setInterval(function () {
		resendtiming--;
		$(".resend_otp span").html(resendtiming);
		if(!altered){
			$(".send_otp_btn span").css("margin-left","5px");
			$(".send_otp_btn span").html(resendtiming+"s"); //No I18N
		}
		if (resendtiming == 0) {
			clearInterval(resendTimer);
			$(".resend_otp").html(I18N.get("IAM.NEW.SIGNIN.RESEND.OTP"));
			$(".send_otp_btn span").html("");
			$(".send_otp_btn span").css("margin","0px");
			$(".resend_otp").removeClass("nonclickelem");
			$(".send_otp_btn").removeAttr("disabled");
		}
	}, 1000);
}
function showModes(){
	if($(".mode-cont:visible")[0] == $(".mode-cont")[nModes-1]){
		$(".mode-cont:visible").css("border-bottom", "none");	
	}
	$(".mode-cont:hidden").slideDown(200);
	$(".show-all-modes-but").slideUp(200);
}
function editNumber(){
	$(document.verify_sms_form).slideUp(200);
	$(document.confirm_form).slideDown(200);
	$("#mobile_input").focus();
}
function addNewTotp(e){
	if(e.target.parentNode.classList.contains("already-totp-conf")){
		$(".new-totp-codes button.back-btn").show();
		$(".already-totp-conf").slideUp();
		$(document.verify_totp_form).hide();
	}
	$(".sms-container, .oneauth-container, .yubikey-container").slideUp(400);
	if(nModes > 1){
		$(".totp-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(400);
	}
	var payload = MfaTOTP.create();
	payload.POST("self","self","mode").then(function(resp){ //No I18N
		
		var mfaTOTP=resp.totp[0]; 
		de('gauthimg').src="data:image/jpeg;base64,"+mfaTOTP.qr_image;
		var key=mfaTOTP.secretkey;
		var displaykey = "<span>"+key.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+key.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+key.substring(8,12)+"</span>"+"<span style='margin-left:5px'>"+key.substring(12)+"</span>"; //No I18N
		$('#skey').html(displaykey);
		encKey = mfaTOTP.encryptedSecretKey;	
		$("#gauth_code").keyup(function(event) {
			if (event.keyCode === 13) {
			        $("#auth_app_confirm").click();
			    }
			});
		if(isMobile){
			$(".qr_key_note").text(I18N.get("IAM.TAP.TO.COPY"));
		}
		$(".add-new-totp").slideUp(200);
		$(".new-totp-codes").show();
		$(".new-totp").slideDown(200);
	},
	function(resp){
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
		if(e.target.parentNode.classList.contains("already-totp-conf")){
				$(".already-totp-conf").slideDown();
				$(".new-totp-codes button.back-btn").hide();
		}
	});
}
var smsPrevSelect;
function selectNumberDevice(e){
	var isCheckbox = e.target.classList.contains("verified-checkbox");//No I18N
	if(isCheckbox){
		e.target.classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target.parentNode &&  !e.target.parentNode.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(mfaData.otp.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}else if($(e.target).parents(".oneauth-body").length){
				if(mfaData.devices.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}
		}
		if(smsPrevSelect && smsPrevSelect != e.target.parentNode){
			smsPrevSelect.querySelector(".verified-checkbox").classList.remove("verified-selected");//No I18N
			if(!smsPrevSelect.parentNode.classList.contains("already-verified-recovery") && !smsPrevSelect.parentNode.classList.contains("delpref-cont")){
				smsPrevSelect.querySelector(".pref-info").remove(); //No I18N
			}	
		}
		smsPrevSelect = e.target.parentNode;
	}
	else if(e.target.classList.contains("verified-app-cont")|| e.target.classList.contains("verified-numb-cont")){
		e.target.querySelector(".verified-checkbox").classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target && ! e.target.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(mfaData.otp.count>1){
					showPreferedInfo(e.target);
				}
			}else if($(e.target).parents(".oneauth-body").length){
				if(mfaData.devices.count>1){
					showPreferedInfo(e.target);
				}
			}
		}
		if(smsPrevSelect && smsPrevSelect != e.target){
			smsPrevSelect.querySelector(".verified-checkbox").classList.remove("verified-selected");//No I18N
			if(smsPrevSelect != e.target && !smsPrevSelect.parentNode.classList.contains("already-verified-recovery")){
				if(smsPrevSelect.querySelector(".pref-info")){
					smsPrevSelect.querySelector(".pref-info").remove(); //No I18N
				}
			}
		}
		smsPrevSelect = e.target;
	}
	
	if(nModes > 1){
		if($(".already-verified:visible").length || $(".already-verified-recovery:visible").length){
		$(".totp-container, .oneauth-container, .yubikey-container").slideUp(200);
		}else if($(".already-verified-app:visible").length){
			$(".totp-container, .sms-container, .yubikey-container").slideUp(200);
		}
		$(".show-all-modes-but").slideDown(200);
	}
}

function showPreferedInfo(parentEle){
	var sibEle = parentEle.querySelector(".delete-icon"); //No I18N
	var newEle = document.querySelector(".pref-info").cloneNode(true)  //No I18N
	if(parentEle.classList.contains("verified-numb-cont")){
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL") //No I18n
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC")//No I18n
	}else{
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL")//No I18n
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC")//No I18n
	}
	newEle.style.display="inline-block";
	newEle.classList.add("pref"); //No I18N
	if(!parentEle.querySelector(".pref-info")){
	parentEle.insertBefore(newEle, sibEle)
	}
}
var deleteEvent={};
function handleDelete(e, dfunc, mode){
		e.stopPropagation();
		deleteEvent = e.target;
		switch(mode){
			case "totp" : $(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE", I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR")));  //No I18n
						  break;
			case "sms":	//No I18n
				var content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				if(e.target.dataset.primary=="true" && mobCount > 1){
					prefDeleteNumbList(content)
					document.querySelector(".confirm-delete-btn").setAttribute("disabled", "disabled"); // No I18N
					document.querySelector(".delpref-cont").addEventListener("click", function(e){ // No I18N
						if($(e.target).children(".verified-selected").length>0){ // No I18N
							document.querySelector(".confirm-delete-btn").removeAttribute("disabled"); // No I18N
						}
					})
					document.querySelector(".confirm-delete-btn").setAttribute("isPrefDel", true); // No I18N
					break;
				} else {
					document.querySelector(".confirm-delete-btn").removeAttribute("disabled"); // No I18N
					document.querySelector(".confirm-delete-btn").removeAttribute("isPrefDel"); // No I18N
				}
			case "oneauth": //No I18n
			case "yubikey": //No I18n
				content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				$(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE",content));  //No I18n
				break;
		}
		document.querySelector(".confirm-delete-btn").addEventListener("click",dfunc);  //No I18n
	popup_blurHandler(6);
	$(".delete-popup").show();
	$(".delete-popup").focus();
	
}

function deleteYubikey(){
	var e_keyname = deleteEvent.dataset.eyubikeyid;
	new URI(MfaYubikey,"self","self","mode",e_keyname).DELETE().then(function(resp){  //No I18n
		if(resp.code === "Y404"){
			$(".delete-popup").slideUp(200);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ $(this).remove()})
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.yubikey.yubikey[arraypos] = {};
			mfaData.yubikey.count -= 1;
			keyCount -= 1;
			if ($(".yubikey-container .mode-header-texts span:visible").length > 1){
				document.querySelectorAll(".yubikey-container .mode-header-texts span")[1].remove();
			}
			var headerText = getModeHeaderText(keyCount, yubikeyHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".yubikey-container .mode-header-texts").append(headerText);//No I18N
			}
			if(keyCount<2){
				$(".yubikey-container .warning-msg").hide();
				$(".yubikey-container .already-desc").hide();
				$(".yubikey-container .new-added-desc.many").hide();
				$(".yubikey-container .new-added-desc.one").show();
			}
			if(keyCount < 1){
				$(".already-yubikey-conf").slideUp(250,function(){
					$(".yubikey-body .hidden-checkbox")[0].classList.remove("verified-selected");
					$(".yubikey-container .mode-header").click();
				});
				$(".add-new-yubikey").slideDown(250);
			}
		}
	},
	function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function deleteConfTotp(){
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(MfaTOTP,"self","self","mode").DELETE().then(function(resp){  //No I18n
		if(resp.code === "TOTP202"){
			$(".delete-popup").slideUp(300);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			mfaData.totp={};
			$(".already-totp-conf").slideUp(250);
			$(".add-new-totp").slideDown(250, function(){
				$(".totp-container .mode-header").click();
			});
			document.querySelectorAll(".totp-container .mode-header-texts span")[1].remove();
		}
	},function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function deleteOneAuth(){
	var enckey = deleteEvent.dataset.enckey;
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(MfaDevice,"self","self","mode",enckey).DELETE().then(function(resp){  //No I18n
		if(resp.code === "MYZD208"){
			$(".delete-popup").slideUp(200);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ 
				$(this).remove()
				if(!$(".modes-container .verified-selected:visible").length){
					$(".oneauth-container .mode-header").click();
					smsPrevSelesct = "";
				}
			})
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.devices.device[arraypos] = {}
			mfaData.devices.count -= 1;
			devCount -= 1;
			if ($(".oneauth-container .mode-header-texts span:visible").length > 1){
				document.querySelectorAll(".oneauth-container .mode-header-texts span")[1].remove();
			}
			var headerText = getModeHeaderText(devCount, oneauthHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".oneauth-container .mode-header-texts").append(headerText);//No I18N
			}
			if(devCount<2){
				$(".oneauth-container .warning-msg").hide();
				$(".oneauth-container .already-desc.many").hide();
				$(".oneauth-container .already-desc.one").show();
			}
			if(devCount < 1){
				$(".already-verified-app").slideUp(250);
				if(isPhased){
					document.querySelector(".oneauth-container .mode-header").classList.add("empty-oneauth-header"); //No I18N
				$(".oneauth-container .splitback").slideDown(200, function(){ //No I18N
					if(rev == undefined){
						rev =reverseSignin();
						rev.init();
					}
				});
				document.querySelector(".oneauth-container .tag").style.opacity = "0" //No I18N
				document.querySelector(".oneauth-container .oneauth-desc").style.display = "block";
				}else{
				$(".oneauth-container .mode-header").children(".add-oneauth").slideDown(200, function(){ //No I18N
					document.querySelector(".add-new-oneauth").style.overflow="unset"; //No I18N
					document.querySelector(".add-qr").classList.add("qr-anim") //No I18N
					document.querySelector(".oneauth-container .mode-header").classList.add("empty-oneauth-header"); //No I18N
				});
				document.querySelector(".oneauth-container .tag").style.opacity = "0" //No I18N
				document.querySelector(".oneauth-container .mode-icon").classList.add("mode-icon-large")//No I18N
				document.querySelector(".oneauth-container .mode-header-texts").classList.add("oneauth-head-text"); //No I18N
				document.querySelector(".oneauth-container .oneauth-desc").style.display = "block";
				}

			}

		}
	},
	function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}

function getModeHeaderText(count, modeHeaderObject){
	var configSpan = document.createElement("span");
	if(count<1){
		return false;
	}else if(count  === 1){
		configSpan.textContent = I18N.get(modeHeaderObject[1]);
	}else if(count>1){
		configSpan.textContent = I18N.get(modeHeaderObject[2], count);
	}
	return configSpan;
}

function cancelDelete(){
	$(".delete-popup").slideUp(200, function(){
		$(".delpref-cont").remove();
		removeBlur();
	});
	$(".delete-cancel-btn").unbind();
}

function escape(e){
	if(e.keyCode == 27){
		cancelDelete();
		closePopup();
	}
}
function removeBlur(){
	$(".blur").css({"opacity":"0"});
	$("body").css("overflow","auto");
	$(".blur").hide();
	$(".blur").unbind();
}

function showTotpOtp(){
	$(".sms-container, .oneauth-container, .yubikey-container").slideUp(200);
	if(nModes > 1){
		$(".show-all-modes-but").slideDown(200);
	}
	$(".new-totp-codes").slideUp(200);
	$(document.verify_totp_form).slideDown(200, function(){
		$(".new-totp .totp_split_input_otp")[0].focus();
	});
}
function verifyTotpCode(e){
	e.preventDefault();
	var code = $('#totp_split_input_full_value').val();
	if(code == ""){
		show_error_msg("#totp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return;
	}
	if(!isOTPValid(code, true)){
		show_error_msg("#totp_split_input", I18N.get("IAM.ERROR.VALID.OTP"));//No I18N
		return;
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No i18N
	var param = { "code":code }; //No I18N
	var payload = MfaTOTP.create(param);
	payload.PUT("self","self","mode",encKey).then(function(resp){ //No I18N
		if(resp.code === "TOTP201"){
			e.target.removeAttribute("disabled");
			$(e.target).html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			if(mfaData.modes.length==0 || (mfaData.modes.length==1 && mfaData.modes[0] == "otp")){
				showSuccessMfapop();
				return;	
			} else {
				showErrMsg(resp.localized_message,true);
			}
			setTimeout(function(){
				$(".new-totp").slideUp(250);
				$(".already-totp-conf-desc.before").hide()
				$(".already-totp-conf-desc.after").show();
				if(!mfaData.totp || Object.keys(mfaData.totp).length == 0){
					var headerText = document.createElement("span");
					headerText.textContent =  I18N.get("IAM.CONFIGURED");
					document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18n
				}
				$(".verify-totp-pro-but").hide();
				$(".delete_totp_conf").show();
				$(".already-totp-conf .add-new-totp-but").addClass("change-config")
				$(".already-totp-conf .hidden-checkbox")[0].classList.add("verified-selected");  //No I18n
				$(".already-totp-conf").slideDown(250);
				document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
				$(e.target).html("<span></span>"+I18N.get('IAM.NEW.SIGNIN.VERIFY'));
				$(document.verify_totp_form).hide();
				$(".totp-container .mode-header").click();
			}, 300);
		}
	},
	function(resp)
	{	
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18n
		e.target.removeAttribute("disabled");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp, "#totp_split_input"); //No I18n
		}
		return;
	});	
}

function verifyOldTotp(e){
	e.preventDefault();
	encKey = mfaData.totp.secretkey;
	$(".totp_input_container button.back-btn").attr("onclick", "totpAlreadyStepBack()");
	$(".new-totp-codes").hide();
	$(document.verify_totp_form).show();
	$(".already-totp-conf").slideUp(200);
	$(".new-totp").slideDown(200);
}
function totpAlreadyStepBack(){
	$(".new-totp").slideUp(200, function(){
		$(".totp-container .mode-header").click();
	});
	clearError('#totp_split_input'); //no i18n
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
	$(".already-totp-conf").slideDown(200);
}
function totpStepBack(){
	$(document.verify_totp_form).slideUp(200);
	clearError('#totp_split_input'); //no i18n
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No i18n
	$(".new-totp-codes").slideDown(200);
}
var styleOrder=0;
function displayAlreadyConfigured(mode, modeData){
	switch(mode){
		case "totp":  //No I18N
		$(".totp-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredTotp(modeData)){
		document.querySelector(".add-new-totp").style.display ="none" //No I18N
		document.querySelector(".already-totp-conf").style.display = "block"; //No I18N
		}
		break;
		case "devices": //No i18n
		$(".oneauth-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredDevice(modeData)){
			if(isBioEnforced){
				$(".already-verified-app .already-desc").hide();
			}
			document.querySelector(".add-new-oneauth").style.display = "none";
			document.querySelector(".already-verified-app").style.display = "block";
		}
		break;
		case "yubikey": //No I18N
		$(".yubikey-container").insertBefore($(".mode-cont")[styleOrder]);
		styleOrder++;
		if(addConfiguredYubikey(modeData)){
		document.querySelector(".add-new-yubikey").style.display ="none"; //No I18N
		document.querySelector(".already-yubikey-conf").style.display = "block"; //No I18N
		}
		break;
	}
}

function addConfiguredTotp(modeData){
	if(document.querySelector(".totp-container")){
	var headerText = document.createElement("span");
	headerText.textContent =  I18N.get("IAM.CONFIGURED");
	document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18N
	document.querySelector(".already-totp-conf-desc>span").textContent = modeData.created_time_formated; //No I18N
	document.querySelector(".delete-totp-conf").dataset.secretkey = modeData.secretkey;  //No I18n
	return true;
	} else {
		return false;
	}
}

var primDev;
var devCount;
function addConfiguredDevice(modeData){
	if(document.querySelector(".oneauth-container")){
	devCount = devCount == undefined ? modeData.count : devCount+1;
	var headerText = getModeHeaderText(devCount, oneauthHeader)
	if(devCount == 1){
		$(".already-verified-app .already-desc.many").hide();
		$(".already-verified-app .already-desc.one").show();
	}else if(devCount>1){
		$(".oneauth-body .warning-msg.many").show();
		$(".already-verified-app .already-desc.many").show();
		$(".already-verified-app .already-desc.one").hide();
	}
	document.querySelector(".oneauth-container .mode-header-texts").append(headerText); //No I18N
	for(i=0;i<modeData.device.length;i++){
		var oneCont = document.querySelector(".verified-app-cont.cloner").cloneNode(true); //No I18N
		oneCont.classList.remove("cloner"); //No I18N
		oneCont.querySelector(".verified-device").textContent = modeData.device[i].device_name;
	
		var devimage = findDeviceImage(modeData.device[i].device_info);
		oneCont.querySelector(".device-image").innerHTML = fontDevicesToHtmlElement[devimage];
		devimage = "icon2-" + devimage; //No I18N
		oneCont.querySelector(".device-image").classList.add(devimage); //No I18N
		
		oneCont.querySelector(".delete-icon").dataset.enckey = modeData.device[i].device_id;
		oneCont.querySelector(".delete-icon").dataset.pos = i;  //No I18n
		if(modeData.device[i].is_primary){
			primDev = modeData.device[i].device_name;
		}
		if(parseInt(modeData.device[i].app_version)<2){
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent = ""; //No I18N
			oneCont.querySelector(".added-period").style.opacity= "1"; //No I18N
			var updatepref = document.querySelector(".pref-info").cloneNode(true)  //No I18N
			updatepref.classList.add("update-app"); //No I18n
			updatepref.style.display = "block";
			updatepref.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL");//No I18n
			updatepref.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC");//No I18n
			oneCont.querySelector(".added-period").append(updatepref);//No I18n
			oneCont.querySelector(".verified-app-details").style.pointerEvents = "auto";//No I18n
		} else if(isBioEnforced){
			if(modeData.device[i].is_primary){
				oneCont.querySelector(".delete-icon").remove(); //No I18n
			}
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		} else{			
		oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		oneCont.querySelector(".verified-checkbox").dataset.enckey = modeData.device[i].device_id;
		oneCont.querySelector(".verified-checkbox").dataset.pref = modeData.device[i].pref_option;
		}
		var exisnode = document.querySelector(".already-verified-app .already-desc.one");//No I18n
		oneCont.style.display = "flex";
		exisnode.parentNode.insertBefore(oneCont, exisnode.nextSibling);
		if(isBioEnforced){
			$(".oneauth-body .warning-msg").hide();
			$(".oneauth-body .biometric-msg").show();
			$(".add-new-oneauth-but").hide();
		}
	}
	return true;
	} else {
		return false;
	}
}
var keyCount;
function addConfiguredYubikey(modeData, isNew){
	if(document.querySelector(".yubikey-container")){
	keyCount = keyCount == undefined ? modeData.count : keyCount+1;
	var headerText = getModeHeaderText(keyCount, yubikeyHeader)
	if ($(".yubikey-container .mode-header-texts span:visible").length > 1){
		document.querySelectorAll(".yubikey-container .mode-header-texts span")[1].remove();
	}
	document.querySelector(".yubikey-container .mode-header-texts").append(headerText); //No I18N
	if(keyCount == 1){
		if(isNew){
			$(".already-yubikey-conf .already-desc").hide();
			$(".already-yubikey-conf .new-added-desc.one").show();
		}
		else{
			$(".already-yubikey-conf .already-desc.one").show();
		}
	}else if(keyCount>1){
		if(isNew){
			$(".already-yubikey-conf .already-desc").hide();
			$(".already-yubikey-conf .new-added-desc.one").hide();
			$(".already-yubikey-conf .new-added-desc.many").show();
		}else{
			$(".already-yubikey-conf .already-desc.many").show();
		}
		$(".yubikey-body .warning-msg").slideDown(300);
	}
	for(i=0;i<modeData.yubikey.length;i++){
		var yubiCont = document.querySelector(".verified-yubikey-cont").cloneNode(true); //No I18N
		yubiCont.querySelector(".verified-yubikey").textContent = decodeHTML(modeData.yubikey[i].key_name); //No I18N
		yubiCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.yubikey[i].created_time_elapsed); //No I18N
		yubiCont.querySelector(".delete-icon").dataset.eyubikeyid = modeData.yubikey[i].e_keyName;
		if(isNew){
			yubiCont.querySelector(".delete-icon").dataset.pos = keyCount - 1; //No I18N
		} else{
			yubiCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}
		var exisnode = document.querySelector(".already-yubikey-conf .descriptions");//No I18n
		yubiCont.style.display = "flex";
		exisnode.parentNode.insertBefore(yubiCont, exisnode.nextSibling);
	}
	return true;
	}else {
		return false;
	}
}

function findDeviceImage(deviceInfo){
	deviceInfo = deviceInfo.toLowerCase();
	if((/iphone/).test(deviceInfo)){
		return "iphone"; //No I18N
	} else if((/macbook/).test(deviceInfo)){
		return "macbook"; //No I18N
	} else if((/ipad/).test(deviceInfo)){
		return "ipad"; //No I18N
	} else if((/oneplus/).test(deviceInfo)){
		return "oneplus"; //No I18N
	} else if((/samsungtab|sm-t|sm-x/).test(deviceInfo)){
		return "samsungtab"; //No I18N
	} else if((/samsung|sm-g|sm-f/).test(deviceInfo)){
		return "samsung"; //No I18N
	} else if((/pixel|google|nexus/).test(deviceInfo)){
		return "pixel"; //No I18N
	} else if((/oppo/).test(deviceInfo)){
		return "oppo"; //No I18N
	} else {
		return "mobile_uk"; //No I18N
	}
}
function show_error_msg(siblingClassorID, msg) {
	var errordiv = document.createElement("div");
	errordiv.classList.add("error_msg"); //No I18N
	$(errordiv).html(msg)
	$(errordiv).insertAfter(siblingClassorID)
	$(siblingClassorID).addClass("errorborder")
	parentform = $(siblingClassorID).closest("form")[0];
	parentform.querySelector("button").setAttribute('disabled', ''); //No I18n
	$(".error_msg").slideDown(150);
}
      
function clearError(ClassorID, e){
	if( e && e.keyCode == 13 && $(".error_msg:visible").length){
		return;
	}
	parentform = $(ClassorID).closest("form")[0];
	parentform.querySelector("button").removeAttribute('disabled'); //No I18n
    $(ClassorID).removeClass("errorborder") //No I18n
    $(".error_msg").remove(); //No I18n
}

function checkNetConnection(){
	setInterval(function(){
		if(window.navigator.onLine){
			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
		}
	}, 2000)
}

function reloginRedirect(){
	var service_url = euc(window.location.href);
	window.open(contextpath + $("#error_space")[0].getAttribute("resp")+"?serviceurl="+service_url+"&post="+true, '_blank') //No i18N
}

function showErrMsg(msg, isSuccessMsg, isRelogin){
	if(isSuccessMsg){
		document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
		document.getElementById("error_space").classList.remove("warning_space") //No I18N
		document.getElementById("error_space").classList.add("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = ""; //No I18N
	}else if(isRelogin){
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("warning_icon");//No I18N
		document.getElementById("error_space").classList.add("warning_space") //No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
		document.getElementById("error_space").setAttribute("resp",isRelogin.redirect_url)
		document.getElementById("error_space").addEventListener("click", reloginRedirect, isRelogin)
	} else {
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementById("error_space").classList.remove("warning_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
	}
	document.getElementById("error_space").classList.remove("show_error"); //No I18N
	document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N

	document.getElementById("error_space").classList.add("show_error");//No I18N
	setTimeout(function() {
		document.getElementById("error_space").classList.remove("show_error");//No I18N
		document.getElementById("error_space").removeEventListener("click", reloginRedirect);
	}, getToastTimeDuration(msg));;
}
function classifyError(resp, siblingClassorID){
	if(resp.status_code && resp.status_code === 0){
		showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
	}else if(resp.code === "Z113"){//No I18N
		showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
	}else if(resp.localized_message && siblingClassorID){
		show_error_msg(siblingClassorID, resp.localized_message)
	}else if(resp.localized_message){
		showErrMsg(resp.localized_message)
	}else{
		showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
	}
}
	  
function checkEnable(e){
	if(!e.target.closest(".already-verified-recovery") && (e.target.classList.contains("mode-header") || e.target.classList.contains("verified-app-cont") ||  e.target.classList.contains("verified-checkbox") || e.target.classList.contains("verified-numb-cont"))){ //No I18N
		setTimeout(function(){
			if($(".modes-container .verified-selected:visible").length>0){
				$(".enable-mfa").removeAttr("disabled");
			}else{
				$(".enable-mfa").attr("disabled","");
			}
		}, 350);
	}else if(e.target.classList.contains("show-all-modes-but")){ //No I18N
		return;
	}else if(e.target.classList.contains("link-btn")){ //No I18N
		$(".enable-mfa").attr("disabled","");
	}
}

function enableMFA(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	var selectedCheckbox =  $(".modes-container .verified-selected:visible")[0];
	if(selectedCheckbox.classList.contains("verified-checkbox")){
		if(selectedCheckbox.parentNode.classList.contains("verified-numb-cont")){
			var params = {"mode" : 0, "primary" : selectedCheckbox.dataset.enckey, "activate" : true, "makeprimary":true} //No I18N
		}else{
			var params = {"mode" : selectedCheckbox.dataset.pref, "primary" : selectedCheckbox.dataset.enckey, "activate" : true, "makeprimary":true} //No I18N
		}
	} else{
		if(selectedCheckbox.parentNode.classList.contains("already-yubikey-conf")){
			var params = {"mode" : 8, "activate" : true, "makeprimary":true} //No I18N
		}else {
			var params = {"mode" : 1, "activate" : true, "makeprimary":true} //No I18N
		}
	}
	var payload = Mfa.create(params);
	payload.PUT("self","self","mode").then(function(resp){ //No I18N
		if(resp.code === "MFA200"){
			e.target.children[0].classList.remove("loader");
			showSuccessMfapop();
		}else{
			e.target.removeAttribute("disabled");
			e.target.children[0].classList.remove("loader");
			classifyError(resp);
		}
	},
	function(resp){
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	})
}
function showSuccessMfapop(){
	$(".msg-popups").prop("onkeydown","");
	$(".popup-icon")[0].classList.add("icon-success");
	$(".popup-heading").html(I18N.get("IAM.MFA.ANNOUN.SUCC.HEAD")) //No I18N
	$(".pop-close-btn").hide();
	if(mfaData.bc_cr_time.allow_codes){
		if(mfaData.bc_cr_time.created_time_elapsed){
			$(".backup-codes-desc.old-codes").show();
			$(".backup-codes-desc.new-codes").hide();
			$("g-backup").text(I18N.get("IAM.GENERATE.BACKUP.CODES"));
		}
		$(".popup-body").html($(".generate-backup").html());
		if(mandatebackupconfig){
			$(".g-cancel").hide();
		}
	}else{
		$(".popup-body").html($(".no-backup-redirect").html());
	}

	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function contSignin(){
	window.location.href = next;
}
function generateBackupCode(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	var payload = BackupCodes.create();
	payload.PUT("self","self").then(function(resp){ //No I18N
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader"); //No i18N
		show_backup(resp.backupcodes);
	},
	function(resp){
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader"); //No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") {
			showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), false, resp); //No I18n
		}else{
			classifyError(resp);
		}
	});
}
function updateBackupStatus(mode){
	var params = {"status":mode}; //No I18N
	var payload = BackupCodesStatus.create(params);
	payload.PUT("self","self").then(function(resp){ //No I18N
	});
}
var pmail, userName, recHelp, newCodesHelp ;
function show_backup(resp){
	if($(".msg-popups .popup-body").hasClass("succ-popup")){
		$(".succ-popup").removeClass("succ-popup");
		$(".msg-popups .popup-header").show();
	}
	var codes = resp.recovery_code;
	var recoverycodes = codes.split(":");
	var createdtime = resp.created_date;
	pmail = resp.primary_email;
	userName = resp.user;
	recHelp = "https://zurl.to/mfa_banner_bvc_rec" //No I18N
	newCodesHelp = "https://zurl.to/mfa_banner_bvc_gen" //No I18N
	var res ="<ol class='bkcodes'>"; //No I18N
	var recCodesForPrint = "";
	for(idx in recoverycodes){
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			res += "<li><b><div class='bkcodes_cell'>"+recCode.substring(0, 4)+"</div><div class='bkcodes_cell'>"+recCode.substring(4, 8)+"</div><div class='bkcodes_cell'>"+recCode.substring(8) + "</div></b></li>"; //No I18N
			recCodesForPrint += recCode + ":";
		}
	}
	res += "</ol>";
	recCodesForPrint = recCodesForPrint.substring(0, recCodesForPrint.length -1); // Remove last ":"
	de('bk_codes').innerHTML = res; //No I18n
	$("#downcodes").attr('onclick', 'downloadCodes(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("save_text")'); //No I18N
	$("#printcodesbutton").attr('onclick','copy_code_to_clipboard(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("copy")'); //No I18N
	$(".popup-heading").html(I18N.get("IAM.TFA.BACKUP.ACCESS.CODES")); //No I18n
	$(".popup-icon")[0].classList.remove("icon-success");
	$(".popup-body").html($(".backup_code_container").html());
	$("body").css("overflow","auto")
	$(".msg-popups").css("position","absolute");
	if(isMobile){
		$(".msg-popups").css({"top":"0px", "border-top-left-radius":"0", "border-top-right-radius":"0"});
		$(".popup-header").css({"border-top-left-radius":"0", "border-top-right-radius":"0"});
	}
}
var recTxt;
function formatRecoveryCodes(createdtime, recoverycodes){
	recTxt = I18N.get("IAM.MFA.BACKUPCODE.FILE.TEXT")+"\n\n\n"; //No I18N
	recTxt = recTxt + I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES") + "\n"; //No I18N
	I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES").split("").forEach(function(){recTxt=recTxt+"-"}); //No I18N
	recTxt = recTxt + "\n# " + I18N.get("IAM.LIST.BACKUPCODES.POINT1") + "\n# " + I18N.get("IAM.LIST.BACKUPCODES.POINT3") + "\n# " //No I18N
					+ I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES3") + "\n# " + I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES4") + "\n\n\n"; //No I18N
	recTxt = recTxt + I18N.get("IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE") + "\n";		//No I18n
	I18N.get("IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE").split("").forEach(function(){recTxt=recTxt+"-";}); //No I18N
	recTxt = recTxt + "\n" + I18N.get("IAM.GENERAL.USERNAME") + ": " + pmail + "\n"; //No I18N
	
	recTxt = recTxt + I18N.get("IAM.GENERATE.ON") + ": " + createdtime + "\n\n"; //No I18N
	recoverycodes = recoverycodes.split(",");
	for(var idx=0; idx < recoverycodes.length; idx++){
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			recTxt += "\n "+(idx+1)+". "+recCode.substring(0, 4)+" "+recCode.substring(4, 8)+" "+recCode.substring(8); //No I18N
		}
	}
	recTxt = recTxt + "\n\n\n" + I18N.get("IAM.MFA.BACKUPCODE.FILE.HELP.LINK") + "\n"; //No I18N
	I18N.get("IAM.MFA.BACKUPCODE.FILE.HELP.LINK").split("").forEach(function(){recTxt=recTxt+"-";}); //No I18N
	recTxt = recTxt + "\n\n# " + Util.format(I18N.get("IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK"), recHelp) + "\n# " + Util.format(I18N.get("IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK"),newCodesHelp);	//No I18n
}
function copy_code_to_clipboard (createdtime, recoverycodes) {
	if(recTxt == undefined){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
	navigator.clipboard.writeText(recTxt).then(function () {
		$(".copy_to_clpbrd").hide();
		$(".code_copied").show();
		$("#printcodesbutton .tooltiptext").addClass("tooltiptext_copied");
		$(".down_copy_proceed").hide();
		$(".cont-signin").show();
	}).catch(function(){
		//error occured while copying
		showErrMsg(I18N.get("IAM.ERROR.GENERAL"))
	});
}
function remove_copy_tooltip() {
	$(".copy_to_clpbrd").show();
	$(".code_copied").hide();
	$("#printcodesbutton .tooltiptext").removeClass("tooltiptext_copied");
}
function downloadCodes(createdtime, recoverycodes){
	if(recTxt == undefined){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
	var filename = "RECOVERY-CODES-"+userName; //No I18N
	var element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(recTxt));
	element.setAttribute('download', filename);
	element.style.display = 'none';
	document.body.appendChild(element);
	element.click();
	$(".down_copy_proceed").hide();
	$(".cont-signin").show();
	document.body.removeChild(element);
}

function showOneauthPop(){
	$(".oneauth-container .mode-header").click();
	document.querySelector(".msg-popups").style.maxWidth = "660px"; //No I18N
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success")  //No I18n
	document.querySelector(".msg-popups .popup-header").style.display = "none";

	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-popup").innerHTML;  //No I18n
	document.querySelector(".msg-popups .popup-body").classList.add("padding-oneauthpop");  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block";
	
	if(isMobile){
		if(/Android/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").hide()
			$(".msg-popups .macstore-icon").hide()
			$(".msg-popups .winstore-icon").hide()
		} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").css({"order":1});
			$(".msg-popups .playstore-icon").hide()
			$(".msg-popups .macstore-icon").hide()
			$(".msg-popups .winstore-icon").hide()
		}
	}
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function showBioPop(){
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success") //No I18N
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD"); //No I18N
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-bio").innerHTML;  //No I18n
	document.querySelector(".bio-steps .oneauth-step b").textContent = primDev; //No I18N
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block"; //No I18N
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
	
function showReloginPop(){
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD");  //No I18n
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-relogin").innerHTML;  //No I18n
	document.querySelector(".msg-popups .popup-body").classList.remove("padding-oneauthpop");  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "none";
	$(".msg-popups").focus();
}
function storeRedirect(url){
	window.open(url, '_blank');
}
function redirectSignin(){
	window.location.href = window.location.origin+"/signin"+window.location.search;
}
	
	/////////////////////////////////////////////////////////////////////////////////

function copyQrKey(element) {
  var copyText = element.querySelector("#skey"); //No I18n
  navigator.clipboard.writeText(copyText.textContent);
  var tickElement = document.createElement("span");
  tickElement.classList.add("tooltip-tick"); //No I18n
  element.querySelector(".tooltip-text").innerText = I18N.get("IAM.APP.PASS.COPIED"); //No I18n
  element.querySelector(".tooltip-text").prepend(tickElement); //No I18n
  return;
}

function resetTooltipText(element) {
	var tooltipHide = setInterval(function() {
		element.querySelector(".tooltip-text").innerText = I18N.get("IAM.MFA.COPY.CLIPBOARD"); //No I18n
		clearTimeout(tooltipHide);	
	}, 300);
	return;
}
function tempBack(e){
	h11 && clearTimeout(h11);
	$(".splitback .qr-image").addClass("filt");
	$(".splitback .qr-refresh").css("pointer-events", "auto");
	$(".splitback .icon-Reload").css("animation", "");
	if(e.target.getAttribute("data-status") != "invalid"){
		$(".splitback .restart-txt").show();
		$(".msg-cont").removeClass("help");
		$(".msg-cont #r-step").text(rev.getCurrentStep())
		$(".msg-cont").slideDown(200);
		$(".rev .qr-cont-wrap").removeClass("active-qr")
		if(mfaData && mfaData.devices && mfaData.devices.count > 0){
			$(".warning-msg.resume-msg").slideDown(200);
			$(".warning-msg #r-step").text(rev.getCurrentStep())
		}
		$(".install-step .link-btn").hide();
	}
	$(".splitback .qr-refresh").addClass("show");
	$(".reverse-container").slideUp(500);
	$(".modes-container:first-child .rev .mode-header").click();
	$(".flex-container .modes-container:first-child").slideDown(500);
	$(".succfail-btns").fadeIn(500);	
}

function resumeStep(){
	$(".flex-container .modes-container:first-child").slideUp(500);
	$(".reverse-container").slideDown(500, function(){
		if(rev.getCurrentStep() == 3){
			$(".rev_split_input_otp")[0].focus();
		}
	})
	$(".succfail-btns").fadeOut(500);
}

/**
 * Help animation
 * 
 * help() params should include msg
 * help() params can include help btn text, success action text, fail action text, timer, succFunc action, failFunc action
 * 
 * retuns *initTimer - can be used to start the timer. Note - expand animation will be calculated by default before this.
 * 		  *destroyHelp - can be used to destroy help expand , timer  
 */
   // var inveranim, initialanim;
var openTimer = {};

    function help(id, params) {
        var msg, succTxt, failTxt, btnTxt, helpTimer,helpcode;
        var ide = document.getElementById(id);
        function defaultHelpSucc(e){
			val = e.target.dataset.value === "true" && true;
			helpAnswer(e, val)
		}
		function defaultHelpFail(e){
			val = e.target.dataset.value === "false" && false;
			helpAnswer(e, val)
		}
		function defaultShowQR(e){
			val = e.target.dataset.value === "ans" && "ans"; //No I18N
			helpAnswer(e, val)
		}
        if(Object.keys(params).length >= 1){
            msg = decodeHTML(params.msg); //mandatory
            succTxt = params.hasOwnProperty("succTxt") ? params.succTxt : "Yes" //No I18N
            failTxt = params.hasOwnProperty("failTxt") ? params.failTxt : "No" //No I18N
            btnTxt = params.hasOwnProperty("btnTxt") ? params.btnTxt : "Help" //No I18N
            helpTimer = params.helpTimer ? params.helpTimer : "60000" //in milliseconds
            helpCode = params.helpCode ? params.helpCode : "default" //No I18N
            succFunc = params.succFunc ? params.succFunc : defaultHelpSucc;
            failFunc = params.failFunc ? params.failFunc : defaultHelpFail;
            trueNo = params.trueNo ? params.trueNo : undefined;
            falseYes = params.falseYes ? params.falseYes : undefined;
        }
        var helpAns = document.createElement("div");
        helpAns.classList.add("help-ans"); //No I18N
        var newHelp = document.querySelector(".help-cont").cloneNode(true); //No I18N
        newHelp.style.display= "block";
        newHelp.querySelector(".help-btn .help-btn-txt").textContent = btnTxt; //No I18N
        if(succTxt != ''){
			newHelp.querySelector(".help-actions .h-btn.succ").textContent = succTxt; //No I18N
		} else {
			newHelp.querySelector(".help-actions .h-btn.succ").style.display= "none";
		}
        if(failTxt != ''){
			newHelp.querySelector(".help-actions .h-btn.fail").textContent = failTxt; //No I18N
		} else {
			newHelp.querySelector(".help-actions .h-btn.fail").style.display= "none";
		}
        newHelp.querySelector(".help-actions").dataset.helpCode = helpCode; //No I18N 
        newHelp.querySelector(".help-content .help-desc").textContent = msg; //No I18N
        newHelp.querySelector(".help-actions .h-btn.succ").addEventListener("click", defaultHelpSucc) //No I18N
        newHelp.querySelector(".help-actions .h-btn.fail").addEventListener("click", defaultHelpFail) //No I18N
		helpAns.append(newHelp);
        ide.style.visibility = "hidden";
        ide.append(helpAns);
        
        var box = ide.querySelector(".help-box"); //No I18N
        var wrapper = ide.querySelector(".help-wrap"); //No I18N
        var btn = ide.querySelector(".help-btn"); //No I18N
        var bord = ide.querySelector(".help-border"); //No I18N
		ide.style.height =  btn.clientHeight + "px"
        function ease(v, pow = 4) {
            return 1 - Math.pow(1 - v, pow);
        }

        function createKeyframeAnimation() {
            var helpEase = document.querySelector('.help-ease'+ id); //No I18N
            if (helpEase) {
                return helpEase;
            }
            helpEase = document.createElement('style');
            helpEase.classList.add('help-ease'+id); //No I18N

            cstate = btn.getBoundingClientRect();
            estate = box.getBoundingClientRect();
            x= cstate.width / estate.width,
            y= cstate.height / estate.height

            var animation = '';
            var inverseAnimation = '';

            for (var step = 0; step <= 100; step++) {
                var easedStep = ease(step / 100).toFixed(5);
                const xScale = (x + (1 - x) * easedStep).toFixed(5);
                const yScale = (y + (1 - y) * easedStep).toFixed(5);
                if (step == 0) {
                    initialanim = "transform: scale("+ xScale +","+ yScale +");" //No I18N
                }
                animation += step +"% {transform: scale("+ xScale +","+ yScale +");}" //No I18N
                const invXScale = 1 / xScale;
                const invYScale = 1 / yScale;
                if (step == 0) {
                    inveranim = "transform: scale("+ invXScale +","+ invYScale +");" //No I18N
                }
                inverseAnimation += step +"% {transform: scale("+ invXScale +","+ invYScale +");}" //No I18N
            }
            wrapper.setAttribute("style", inveranim);
            box.setAttribute("style", initialanim);
            helpEase.textContent = "@keyframes helpAnimation {"  //No I18N
                + animation + "}"
                + "@keyframes helpContentsAnimation {"  //No I18N
                + inverseAnimation +
                "}"
            document.body.append(helpEase);

            bord.style.width = cstate.width +3+ "px";
            bord.style.height = cstate.height +2+ "px";
            bord.querySelector("svg").style.width = cstate.width + 3 + "px";
            bord.querySelector("svg").style.height = cstate.height + 2 + "px";
            bord.querySelector("rect").style.width = cstate.width + "px";
            bord.querySelector("rect").style.height = cstate.height + "px";
            setTimeout(function(){
                ide.style.visibility = "unset";
            }, 200)
        }
        function setAnswer(str, cl){
			var m = document.createElement("div");
			m.style.display="none";
			m.classList.add(cl);
			if(str.indexOf("\:") > 0){
				var k = str.split("\:");
				str = str.substring(str.indexOf("\:")+2);
				var s = document.createElement("span")
				s.classList.add("ans-list-head"); //No I18N
				s.textContent = decodeHTML(k[0]);
				m.append(s);
			}
			var l = str.split(".");
			l.forEach(function(eac){
				if(eac.trim() !== ""){
					var s = document.createElement("span")
					s.classList.add("ans-list"); //No I18N
					s.innerHTML = decodeHTML(eac);
					m.append(s);
				}
			})
			return m;
		}
		createKeyframeAnimation();
			var parClient = newHelp.getBoundingClientRect();
            newHelp.style.transform = "translateZ("+ (parClient.height/2) +"px)" //No I18N
            ide.querySelector(".help-ans").style.height = parClient.height + "px";
            ide.querySelector(".help-ans").style.position = "absolute";
            var newE = document.querySelector(".ans-cont").cloneNode(true); //No I18N
            newE.style.display = "flex";
            newE.style.transform = "rotateX(-90deg) translateZ(-"+ (parClient.height/2) +"px)" //No I18N
            newE.style.minHeight  = parClient.height + "px"; //No I18N
            ide.querySelector(".help-ans").append(newE); //No I18N
            var newEle = document.querySelector(".ans-cont").cloneNode(true); //No I18N
            newEle.classList.add("find", "down"); //No I18N
            newEle.style.display = "flex";
            newEle.style.minHeight  = parClient.height + "px"; //No I18N
            newEle.querySelector(".help-actions").dataset.helpCode = helpCode; //No I18N
            newEle.querySelector(".help-actions").addEventListener("click", defaultShowQR) //No I18N
            ansTxt = newEle.querySelector(".ans-txt"); //No I18N
            if(trueNo){
				ansTxt.append(setAnswer(trueNo, "trueNo")); //No I18N
			}
			if(falseYes){
				ansTxt.append(setAnswer(falseYes, "falseYes")); //No I18N
			}
            ide.append(newEle);

        btn.addEventListener("click", toggleHelp);
        bord.addEventListener("click", toggleHelp);
        btn.dataset.id = id;
        bord.dataset.id = id;
        ide.dataset.initialanim = initialanim;
        ide.dataset.inveranim =inveranim;
        return {
            initTimer: function(){
				var tempSDA = 100
				rect = bord.querySelector("rect") //No I18N
				rect.style.strokeWidth = "2";
                rect.style.strokeDashoffset = "101";
                $(ide).fadeIn(200);
                stepRate = helpTimer/100;
                rect.style.transition = stepRate+"ms all linear"; //No I18N
                clearInterval(openTimer);
                openTimer = setInterval(function(){
					if(tempSDA == 1){
						ide.querySelector(".help-border").click(); //No I18N
					}
					if(tempSDA == 0){
						clearInterval(openTimer);
					}
					rect.style.strokeDashoffset =  tempSDA--;
				}, stepRate)
            },
            destroyHelp: function(){
                clearInterval(openTimer);
                openTimer = null;
                rect = bord.querySelector("rect") //No I18N
                rect.style.strokeWidth = "1";
                rect.style.strokeDashoffset = "0";
                rect.style.transition = "none" //No I18N
                ide.querySelectorAll(".ans-txt div").forEach(function(eac){eac.style.display="none";})
                ide.querySelector(".ans-cont.find .help-actions").style.display="none";
                ide.querySelector(".help-ans").classList.remove("flip-trans"); //No I18N
				ide.querySelector(".ans-cont.find").classList.add("down"); //No I18N
				ide.querySelectorAll(".help-actions .h-btn").forEach(function(eac){eac.classList.remove("opac0")}) //No I18N
				ide.querySelector(".help-load").classList.remove("opac1"); //No I18N
				if(box.classList.contains("help-expand")){
					btn.click();
				}
				
            }
        }
    }

    function toggleHelp(e) {
        var parHelp = e.target.closest("#"+ e.target.dataset.id) //No I18N
        box = parHelp.querySelector(".help-box") //No I18N
        bord = parHelp.querySelector(".help-border") //No I18N
        wrap = parHelp.querySelector(".help-wrap") //No I18N
        rect = bord.querySelector("rect") //No I18N
        if (box.classList.contains("help-expand")) {
			parHelp.style.height = parHelp.querySelector(".help-btn").clientHeight - 16 + "px"; //16 top and bottom padding
            if(rect.style.strokeDashoffset == 0){
            	rect.style.strokeWidth = "1";
            }
           	bord.style.opacity = "1";
           	box.style.border = "1px solid transparent";
            box.setAttribute("style", parHelp.dataset.initialanim);
            wrap.setAttribute("style", parHelp.dataset.inveranim);
            box.classList.remove("help-expand") //No I18N
            wrap.classList.remove("help-wrap-expand") //No I18N
            clearInterval(openTimer);
        } else {
			clearInterval(openTimer);
			openTimer = null;
			parHelp.style.height = "auto";
            bord.style.opacity = "0";
            box.style.border = "1px solid rgb(19 147 255)";
            box.style.transform = "scale(1,1)"; //No I18N
            wrap.style.transform = "scale(1,1)"; //No I18N
            window.getComputedStyle(box).transform;
            box.classList.add("help-expand") //No I18N
            wrap.classList.add("help-wrap-expand") //No I18N
            window.getComputedStyle(box).transform;
            rect.style.strokeDashoffset = "0";
        }
    }
    function helpQuestLoad(parhelp){
		parhelp.querySelectorAll(".h-btn").forEach(function(each){ //No I18N
			each.classList.toggle("opac0") //No I18N
		})
		parhelp.querySelector(".help-load").classList.toggle("opac1") //No I18N
	}
	var MFACheckClicks = 0
    function helpAnswer(e, val){
		helpcode = e.target.parentNode.dataset.helpCode;
		var topPar = e.target.parentNode.closest(".helpcont"); //No I18N
		switch(helpcode){
			case "q1": //No I18N
				if(val == true){
					forcedStep("1", {});
					'murphy' in window && sendMurphyMsg("I_rev_help1_yes") //No I18N
				} else {
					topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
					topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
					setTimeout(function(){
						$(topPar.querySelector(".ans-cont.find .ans-txt .trueNo")).slideDown(400);
					}, 500);
					'murphy' in window && sendMurphyMsg("I_rev_help1_no") //No I18N
				}
				break;
			case "q2": //No I18N
				if(val == true){
					helpQuestLoad(topPar.querySelector(".help-cont")); //No I18N
					rev.checkDownload().then(function(resp){
						$(".step3-container .step3-body").hide();
						$(".step3-container .step3-qr").show();
						data={};
						data.qr = "new"; //No I18N
						forcedStep("2", data);
					}).catch(function(resp){
						helpQuestLoad(topPar.querySelector(".help-cont")); //No I18N
						if(resp.errors[0].code === "IN103"){
							document.querySelector("body"); //No I18N
						}else if(resp.errors[0].code === "D102"){
							topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
							topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
							$(".step1-qr .cont-desc").show()
							$(".step1-qr .new-desc").hide()
							setTimeout(function(){
							$(topPar.querySelector(".ans-cont.find .ans-txt .falseYes")).slideDown(400);
							$(topPar.querySelector(".ans-cont.find .help-actions")).slideDown(200);
							}, 500);
						}else{
							classifyError(resp);
						}
					})
					'murphy' in window && sendMurphyMsg("I_rev_help2_yes") //No I18N
				} else if(val == "ans"){ //No I18N
					step = 1
					$(".step"+step+"-container .step"+step+"-qr").slideDown(200, function (){
						rev.stepSuccess(2,1, function(){
							h2.destroyHelp();
							rev.refresh(e, undefined, step)
						});
					});
					$(".step"+step+"-container .step"+step+"-body").slideUp(200);
					'murphy' in window && sendMurphyMsg("I_rev_help2_ans") //No I18N
				} else {
					helpQuestLoad(topPar.querySelector(".help-cont")); //No I18N
					topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
					topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
					$(".step1-qr .cont-desc").show()
					$(".step1-qr .new-desc").hide()
					setTimeout(function(){
						$(topPar.querySelector(".ans-cont.find .ans-txt .trueNo")).slideDown(400);
						$(topPar.querySelector(".ans-cont.find .help-actions")).slideDown(200);
					}, 500);
					'murphy' in window && sendMurphyMsg("I_rev_help2_no") //No I18N
				}
				break;
			case "q3": //No I18N
				if(val == true){
					topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
					topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
					setTimeout(function(){
						$(topPar.querySelector(".ans-cont.find .ans-txt .falseYes")).slideDown(300);
					}, 500);
					'murphy' in window && sendMurphyMsg("I_rev_help3_yes") //No I18N
				} else if(val == "ans"){ //No I18N
					step = 3
					$(".step"+step+"-container .step"+step+"-qr").slideDown(200, function (){
						h3.destroyHelp();
					});
					$(".step"+step+"-container .step"+step+"-body").slideUp(200);
					rev.refresh(e, undefined, step)
					'murphy' in window && sendMurphyMsg("I_rev_help3_ans") //No I18N
				} else {
					topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
					topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
					setTimeout(function(){
						$(topPar.querySelector(".ans-cont.find .ans-txt .trueNo")).slideDown(400);
						$(topPar.querySelector(".ans-cont.find .help-actions")).slideDown(200);
					}, 500);
					'murphy' in window && sendMurphyMsg("I_rev_help3_no") //No I18N
				}
				break;
			case "q4": //No I18N
				if(val == true){
					helpQuestLoad(topPar.querySelector(".help-cont")); //No I18N
					rev.checkMFA().then(function(){
						//success handled in callback
					}).catch(function(resp){
						helpQuestLoad(topPar.querySelector(".help-cont")); //No I18N
						if(!resp.mfadevice[0].is_mfa_activated){
							topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
							topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
							$(topPar.querySelector(".ans-cont.find .h-btn")).text(decodeHTML(I18N.get("IAM.ENABLED.MFA"))) //No I18N
							setTimeout(function(){
								$(topPar.querySelector(".ans-cont.find .ans-txt .falseYes")).slideDown(300);
								$(topPar.querySelector(".ans-cont.find .help-actions")).slideDown(200);
							}, 500);
						}
					})
					'murphy' in window && sendMurphyMsg("I_rev_help4_yes") //No I18N
				} else if(val == "ans"){ //No I18N
					if(MFACheckClicks >= 0  && MFACheckClicks < 3){
						helpQuestLoad(topPar.querySelector(".ans-cont.find")) //No I18N
						rev.checkMFA().then(function(){
							helpQuestLoad(topPar.querySelector(".ans-cont.find")) //No I18N
							//success handled in callback
						}).catch(function(resp){
							setTimeout(function(){
								helpQuestLoad(topPar.querySelector(".ans-cont.find")) //No I18N
								if(!resp.mfadevice[0].is_mfa_activated){
									$(topPar.querySelector(".ans-cont.find .ans-txt .trueNo")).slideUp(200);
									$(topPar.querySelector(".ans-cont.find .ans-txt .falseYes")).slideDown(200);
								}
							}, 500);
						})
						'murphy' in window && sendMurphyMsg("I_rev_help4_ans") //No I18N
						MFACheckClicks++;
						if(!document.querySelector(".txt2")){
							var ansL = document.createElement("span")
							ansL.classList.add("ans-list","txt2") //No I18N
							ansL.textContent = I18N.get("IAM.REV.MFA.ENABLE.THROTTLE") //No I18N
							var ansT = document.createElement("div")
							ansT.classList.add("thrott"); //No I18N
							ansT.style.display= "none"
							ansT.append(ansL)
							topPar.querySelector(".ans-cont.find .ans-txt").append(ansT) //No I18N
						}
					} else if(MFACheckClicks == -1) {
						helpQuestLoad(topPar.querySelector(".ans-cont.find")) //No I18N
						'murphy' in window && sendMurphyMsg("I_rev_help4_thrott") //No I18N
						window.location.href = remindme;
					} else {
						$(topPar.querySelector(".ans-cont.find .ans-txt .thrott")).slideDown(200);
						$(topPar.querySelector(".ans-cont.find .ans-txt .falseYes")).slideUp(200);
						$(topPar.querySelector(".ans-cont.find .h-btn")).text(I18N.get("IAM.ACCESS.MY.ACC"));
						MFACheckClicks = -1
					}
				} else {
					topPar.querySelector(".help-ans").classList.add("flip-trans"); //No I18N
					topPar.querySelector(".ans-cont.find").classList.remove("down"); //No I18N
					$(topPar.querySelector(".ans-cont.find .h-btn")).text(decodeHTML(I18N.get("IAM.ENABLED.MFA"))) //No I18N
					setTimeout(function(){
						$(topPar.querySelector(".ans-cont.find .ans-txt .trueNo")).slideDown(400);
						$(topPar.querySelector(".ans-cont.find .help-actions")).slideDown(200);
					}, 500);
					'murphy' in window && sendMurphyMsg("I_rev_help4_no") //No I18N
				}
				break;
			case "default": //No I18N
				break;
		}
	}
	function refreshQr(e, type, cStep){
		e && e.stopPropagation();
		$(".step"+cStep+"-qr .refresh-txt").hide();
		$(".step"+cStep+"-qr .qr-refresh").css("pointer-events", "none");
		$(".step"+cStep+"-qr .icon-Reload").css("animation", "spin 0.8s infinite linear");
		if(cStep == 1){
			$(".msg-cont").slideUp(200, function(){
				$(".msg-cont").removeClass("help");
				//$(".install-step .link-btn").fadeIn(100);
			});
			$(".warning-msg.resume-msg").slideUp(200);
			rev.reset();
		}
		$(".back-arrow-btn").removeAttr("data-status");
		rev.refresh(e, type, cStep)

	}
	function wmsConnectionFailure(){
		rev.setWmsRegistered(false);
		rev.notifyFailure();
	}
    function wmsRegisterSuccess(){
		rev.setWmsRegistered(true);
	}
	function wmsMessageCallBack(msg){
		rev.wmsMessage(msg);
	}
	function showReverseSignin(){
		step = 1;
		if((!mfaData.devices|| !mfaData.devices.count)){
			if(rev == undefined){
				rev = reverseSignin();
				rev.init();
			}
		} else {
			$(".step"+step+"-container").addClass("current-step")
			$(".step"+step+"-container .step"+step+"-qr").slideDown(0);
			$(".step"+step+"-container .step"+step+"-body").slideUp(0);
			$(".flex-container .modes-container:first-child").slideUp(500, function(){
				$(".sms-container, .totp-container, .yubikey-container").slideUp();
				$(".show-all-modes-but").slideDown();
				$(".step"+step+"-container .mode-header").click();
			});
			$(".reverse-container").slideDown(500, function(){
				if(rev == undefined){
					rev = reverseSignin();
					rev.init();
				} else {
					refreshQr(null, "type", 1) //No I18N
				}
			});
		}
	}
	function forcedStep(n, data){
		rev.nextSuccessStep(n, data);
	}
	function helpInQR(){
		$(".install-step .link-btn").fadeOut(100);
		clearTimeout(h11)
		$(".msg-cont").addClass("help");
		$(".msg-cont").slideDown(200);
	}
	function expandQR(e){
		if(e.target.classList.contains("qr-cont-wrap")){
			tarEle = e.target;
		} else {
			tarEle = e.target.closest(".qr-cont-wrap"); //No I18N
		}
		if(tarEle.classList.contains("active-qr")){
		tarEle.querySelector(".tap-txt .icon-expand").classList.add("icon-collapse") //No I18N
		tarEle.querySelector(".tap-txt .txt").textContent = I18N.get("IAM.SMART.SIGNIN.CANCEL.CONTENT.UPDATE") //No I18N
		$(tarEle).addClass("qr-exp")
		popup_blurHandler(5);
		$(tarEle).attr("onclick", "collapseQR()")
		}
	}
	function collapseQR(){
		$(".qr-exp").attr("onclick", "expandQR(event)")
		$(".qr-exp .tap-txt .icon-expand").removeClass("icon-collapse")
		$(".qr-exp .tap-txt .txt").text(I18N.get("IAM.SMART.SIGNIN.EXPAND.CONTENT.UPDATE"));
		$(".qr-exp").removeClass("qr-exp")
		removeBlur();
	}