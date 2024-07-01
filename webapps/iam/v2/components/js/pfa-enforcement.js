//$Id$
/**
 * 
 */
var resendTimer, resendtiming, altered;
var Announcement = ZResource.extendClass({
	  resourceName: "Announcement",//No I18N
	  identifier: "type"	//No I18N 
});
var PFA  = ZResource.extendClass({
	  resourceName: "pfa", //No I18N
	  identifier: "type", //No I18N
	  parent : Announcement
});
var EnforcedPfaTOTP = ZResource.extendClass({ 
	  resourceName: "totp", //No I18N
	  identifier: "identifier",	//No I18N
	  path : 'totp', // No i18N
	  attrs : ["code"], // No i18N
	  parent : PFA
});
var EnforcedPfaMobile = ZResource.extendClass({ 
	  resourceName: "mobile", //No I18N
	  attrs : ["mobile","countrycode","code","primary", "cdigest", "captcha"], // No i18N
	  path : 'mobile', //No I18N
	  identifier: "encryptedMobile", //No I18N
	  parent : PFA
});
var EnforcedPfaEmail = ZResource.extendClass({ 
	  resourceName: "email", //No I18N
	  attrs : ["email_id","code"], // No i18N
	  path : 'email', //No I18N
	  parent : PFA
});
var EnforcedPfaPasskey = ZResource.extendClass({ 
	resourceName: "passkey",//No I18N
	path : 'passkey',// No i18N
	attrs : [ "key_name","id","type","rawId","extensions","response"],// No i18N
	parent : PFA
});
var EnforcedPassword = ZResource.extendClass({ 
	  resourceName: "password",//No I18N
	  path : 'password',//No I18N 
	  attrs : ["newpassword"], //No I18N
	  parent : PFA
});
var EnforcedMobileMakeMfa = ZResource.extendClass({ 
	  resourceName: "EnforcedMobileMakeMfa",//No I18N
	  path : 'makemfa',//No I18N 
	  //attrs : [""], //No I18N
	  parent : EnforcedPfaMobile
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
			var codePattern = new RegExp("^([0-9]{"+otp_length+"})$");
			if(codePattern.test(code)){
				return true;
			}
		}
	}
	return false;
}

function popup_blurHandler(ind) {
	$(".blur").show();
    $(".blur").css({"z-index":ind, "background-color": "#00000099", opacity: "1" });
    $("body").css({
    	overflow: "hidden" //No I18N
    });
    $(".blur").bind("click", function(){
		$(".delete-cancel-btn").click();
		if($(".msg-popups .oneauth-headerandoptions2:visible").length || $(".msg-popups .bio-steps:visible").length){
			$(".pop-close-btn").click();
		}
		if($(".msg-popups .swap-desc1:visible").length){
			$(".msg-popups .cancel-btn").click();
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
function clearError(ClassorID) {
	$(ClassorID).removeClass("errorborder");
	$(".error_msg").remove();
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
function selectandslide(e) {
	//temporary handling for one-header click
	if(e.target.classList.contains("oneauth-head-text") && e.target.parentNode.classList.contains("one-header")){ //No I18N
		window.open("https://zurl.to/mfa_enforce_oaweb", "_blank"); //No I18N
		return;
	}
	if(e.target.classList.contains("add-oneauth") || e.target.classList.contains("download") || e.target.classList.contains("common-btn")){ //No I18N
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
		e.target.querySelector(".mode-icon").classList.add("mode-icon-large") //No I18N
		e.target.querySelector(".mode-header-texts").classList.add("oneauth-head-text"); //No I18N
		e.target.querySelector(".oneauth-desc").style.display = "block";
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	else {
		$(e.target.nextElementSibling).slideDown(250);
		e.target.querySelector(".down-arrow").classList.add("up"); //No I18N
		if (prevSelect != undefined && prevSelect.nextElementSibling != e.target.nextElementSibling) {
			$(prevSelect.nextElementSibling).slideUp(250);
			prevSelect.querySelector(".down-arrow").classList.remove("up"); //No I18N
		}
	}
	prevSelect = e.target;
}

function phoneSelectformat(option) {
	var spltext;
	if (!option.id) {
		return option.text;
	}
    spltext = option.text.split("(");
    var num_code = $(option.element).attr("data-num");
    var string_code = $(option.element).attr("value");
    var ob ='<div class="pic flag_' + string_code +'" ></div><span class="cn">' + spltext[0] + "</span><span class='cc'>" + num_code + "</span>";
    return ob;
}
function phonecodeChangeForMobile(ele){
	$(ele).css({'opacity':'0','width':'60px','height':'42px'});
	$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num")); //No I18N
	$(ele).change(function(){
		$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num")); //No I18N
    })
}
function codelengthChecking(length_id, changeid) {
	var code_len = $(length_id).attr("data-num").length;
	var length_ele = $(length_id).parent().siblings("#" + changeid);
    length_ele.removeClass("textindent58");
    length_ele.removeClass("textindent66");
    length_ele.removeClass("textindent78");
    if (code_len == "3") {
		length_ele.addClass("textindent66");
	} else if (code_len == "2") {
		length_ele.addClass("textindent58");
	} else if (code_len == "4") {
		length_ele.addClass("textindent78");
	}
	length_ele.focus();
}
var isMobileSelectInit = false;
function mobileSelectInit() {
	if(!isMobile){
	$(document.confirm_form.countrycode).uvselect({
			"width": '80px', //No I18N
			"searchable" : true, //No I18N
			"dropdown-width": "300px", //No I18N
			"dropdown-align": "left", //No I18N
			"embed-icon-class": "flagIcons", //No I18N
			"country-flag" : true, //No I18N
			"country-code" : true  //No I18N
	});
}else{
		phonecodeChangeForMobile(document.confirm_form.countrycode);
	}
    phonePattern.intialize(document.confirm_form.countrycode);
    if(!showMobileNoPlaceholder){
		$("#mobile_input").on("input", function(event){
			numbOnly(event);
		})
	}
	splitField.createElement("otp_split_input", {
		splitCount: otp_length,
        charCountPerSplit: 1,
        isNumeric: true,
        otpAutocomplete: true,
        customClass: "customOtp",  //No I18N
        inputPlaceholder: "&#9679;",
        placeholder: I18N.get("IAM.ENTER.CODE")
	});
	$("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input', event)");
}

var recMobiles =[];
function addNewNumber(e) {
	$(document.verify_sms_form).hide();
	$(".new-number button.back-btn").hide();
	if(mobCount>0){
		$(".new-number button.back-btn").show();
	}
	if(e.target.parentNode.classList.contains("already-verified")){
		$(".already-verified").slideUp(200);
		$(document.confirm_form).show();
	}
	if(e.target.parentNode.classList.contains("already-verified-recovery")){
		$(".already-verified-recovery").slideUp(200);
		$(document.confirm_form).slideDown(200);
	}
	if(e.target.parentNode.classList.contains("add-new-cont")){
			$(document.confirm_form).show();
	}
	if(recMobiles.length<1){
		$(".already-added-but").hide();
	}
	$(".totp-container, .oneauth-container, .yubikey-container, .email-container, .passkey-container, .IDP-container, .password-container").slideUp(200);
	$(".add-new-number").slideUp(200);
	$(".new-number").slideDown(200, function(){
		$("#mobile_input").val("").focus();
	});
	if(nModes > 1){
		$(".sms-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(200);
	}
	if (!isMobileSelectInit) {
		if(!IPcountry == ""){
			$("#countNameAddDiv option[value=" + IPcountry.toUpperCase() + "]").prop('selected', true);
		}
		mobileSelectInit();
		isMobileSelectInit = true;
	}
}

var swapElement;
function showConfirmSwap(e){
	if(e.target.classList.contains("verified-checkbox")){
		var swap = e.target.parentNode.dataset.swapnumber;
		var arrpos = e.target.parentNode.dataset.recArr;
		swapElement = e.target.parentNode;
	}else{
		var swap = e.target.dataset.swapnumber;
		var arrpos = e.target.dataset.recArr;
		swapElement = e.target;
	}
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success")  //No I18N
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.SWAP.HEADING");  //No I18N
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".number-swap").innerHTML;  //No I18N
	document.querySelector(".msg-popups .pop-close-btn").style.display = "none";
	document.querySelector(".confirm-swap").dataset.swap = swap; //No I18N
	document.querySelector(".confirm-swap").dataset.swapArr = arrpos; //No I18N
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
}
function swapNumber(e){
	e.target.setAttribute("disabled","");
	e.target.children[0].classList.add("loader");
	mnumb = e.target.dataset.swap;
	arraypos = e.target.dataset.swapArr;
	var payload = EnforcedMobileMakeMfa.create();
	payload.PUT("pre","self",mnumb.split("-")[1]).then(function(resp){ //No I18N
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		$(".msg-popups").slideUp();
		removeBlur();
		showErrMsg(resp.localized_message,true);
		if(mobCount){
			mfaData.otp.mobile.push(mfaData.otp.recovery_mobile[arraypos]);
			mfaData.otp.count = mobCount + 1;
		} else {
			mfaData.otp.mobile =  [mfaData.otp.recovery_mobile[arraypos]];
			mfaData.otp.count = 1;
		}
		addConfiguredMobile({"mobile":[mfaData.otp.recovery_mobile[arraypos]], "count": 1 }, true); //No I18N
		$(swapElement).animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ $(this).remove()})
		smsPrevSelect ="";
		recMobiles = recMobiles.filter(function(ele){ return ele!== mnumb})
		mfaData.otp.recovery_mobile[arraypos] = {};
		newSms = $(".already-verified .verified-numb-cont")[0];
		$(".new-number").slideUp();
		$(".already-verified-recovery").hide();
		$(".already-verified").slideDown(250,function(){
			newSms.click();
		});
	}, function(resp){
		e.target.removeAttribute("disabled");
		e.target.children[0].classList.remove("loader");
		classifyError(resp);
	})
}

function smsAlreadyStepBack(){
	$(".new-number").slideUp(250);
	$(".sms-container .mode-header").click();
	$(".already-verified").slideDown(250);
}
function selectAlreadyNumbers() {
	$(".new-number").slideUp();
	$(".sms-body .already-verified, .sms-container .mode-header").slideDown(200);
	$(".totp-container, .oneauth-container, .yubikey-container").slideDown(200);
	$(".sms-container.mode-cont").css("border-bottom", "1px solid #d8d8d8");
	$(".enable-mfa").show();
}
function selectRecoveryNumbers(isSuggestion, isAlready){
	var parCont = document.querySelector(".already-verified-recovery"); //No I18N
	if( !parCont.querySelector(".verified-numb-cont")){
		for(i = 0; i < mfaData.otp.recovery_mobile.length; i++){
			var verifiedCont = document.querySelector(".verified-numb-cont").cloneNode(true); //No I18N
			var numb = mfaData.otp.recovery_mobile[i].r_mobile.split("-");
			var displayNo = "+"+numb[0]+" "+numb[1];
			verifiedCont.querySelector(".verified-number").textContent = displayNo; //No I18N
			verifiedCont.querySelector(".added-period").textContent = mfaData.otp.recovery_mobile[i].created_time_elapsed; //No I18N
			verifiedCont.querySelector(".delete-icon").style.display = "none";
			verifiedCont.dataset.swapnumber = mfaData.otp.recovery_mobile[i].r_mobile;
			verifiedCont.dataset.recArr = i;
			verifiedCont.addEventListener("click", showConfirmSwap)
			verifiedCont.style.display = "flex";
			parCont.insertBefore(verifiedCont, parCont.querySelector(".add-new-number-but")); //No I18N
		}
	}
	if(isSuggestion){
		parCont.querySelector(".suggest-recovery-desc").style.display="block";
	}else if(isAlready){
		parCont.querySelector(".already-recovery-desc").style.display="block";
		parCont.querySelector(".verified-recovery-desc").style.display="none";
		parCont.querySelector(".suggest-recovery-desc").style.display="none";
	}else{
		parCont.querySelector(".suggest-recovery-desc").style.display="none";
		parCont.querySelector(".already-recovery-desc").style.display="none";
		if(mfaData.otp.recovery_count === 1){
			parCont.querySelector(".verified-recovery-desc.one").style.display="block";
		}else{
			parCont.querySelector(".verified-recovery-desc").style.display="block";
		}	
	}
	if(parCont.querySelector(".verified-selected")){
		parCont.querySelector(".verified-selected").classList.remove("verified-selected"); //No I18N
	}
	$(document.confirm_form).slideUp(200);
	$(parCont).slideDown(200);
}
	  
function isRecoveryNumber(mobNumber){
	for(y=0; y<recMobiles.length; y++){
		if(recMobiles[y] == mobNumber){
			selectRecoveryNumbers(false, true);
			return true;
		}
	}
	return false;
}

function numbOnly(e){
	e.target.value = e.target.value.slice(0, e.target.value.length).replace(/[^0-9]/gi, "");
}
var encKey;
var mobile="";
var mobObject = {};
function sendSms(e){
	if(document.querySelector(".sms-container .send_otp_btn").disabled){
		return false;
	}
	altered = false;
	mobile = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
	if(mobile == ""){
		show_error_msg("#mobile_input",I18N.get("IAM.ERROR.EMPTY.FIELD")); //No I18N
		return false;
	}
	if(isPhoneNumber(mobile)){
		var dialingCode = $('#countNameAddDiv option:selected').attr("data-num");
		mobObject.r_mobile = dialingCode.split("+")[1]+"-"+mobile;
		mobObject.mobile = mobile;
		mobObject.dcode = dialingCode.split("+")[1];
		if(!(isRecoveryNumber(mobObject.r_mobile))){
		e.target.setAttribute("disabled",'');
		e.target.querySelector("span").classList.add("loader","miniloader","leftMargin"); //No I18N
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
		$(".resend_otp").addClass("nonclickelem");
        var countryCode = $('#countNameAddDiv option:selected').attr("id");
        var params = {"mobile":mobile,"countrycode":countryCode}; //No I18N
        mobObject.country_code = countryCode;
        var payload = EnforcedPfaMobile.create(params);
        var otpform = document.verify_sms_form;
		otpform.querySelector(".valuemobile").textContent = dialingCode+" "+mobile; //No I18N
		document.querySelectorAll(".otp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
		clearError("#otp_split_input") //No I18N
		function successCallback(resp){
			$(document.confirm_form).slideUp(200, function(){
				e.target.removeAttribute("disabled");
				e.target.querySelector("span").classList.remove("loader","miniloader","leftMargin"); //No I18N
			});
			$(otpform).slideDown(200);
			var EnforcedPfaMobile=resp.mobile;
			mobObject.e_mobile = EnforcedPfaMobile.encrypted_data;
			encKey = EnforcedPfaMobile.encrypted_data;
			setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
		}
		function errCallback(resp){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader","leftMargin"); //No I18N
			classifyError(resp, "#mobile_input"); //No I18N
		}
		payload.POST("pre","self").then(successCallback, //No I18N
		function(resp){
			if (handleCaptcha().isRequired(resp)) {
				handleCaptcha(resp, {
					callbacks: {
						beforeInit: function() {
							$(document.confirm_form).slideUp(200, function(){
								e.target.removeAttribute("disabled"); //No I18N
								e.target.querySelector("span").classList.remove("loader","miniloader","leftMargin"); //No i18N
							});
						}
					}
				}).init('#mfa-mob-captcha', payload, ["pre","self"]).then(successCallback, function(err) { //No I18N
					$(document.confirm_form).slideDown(300, function() {
						errCallback(err);
					});
				});
			} else {
				errCallback(resp);
			}
		});
		}
	}
	else{
		show_error_msg("#mobile_input",I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER")); //No I18N
	}
}

function verifySmsOtp(e){
	e.preventDefault();
	var code = $("#otp_split_input_full_value").val();
	if(code == ""){
		show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
		return;
	}
	if(!isOTPValid(code)){
		show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.VALID.OTP"));//No I18N
		return;
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No I18N
	var param = { "code":code }; //No I18N
	var payload = EnforcedPfaMobile.create(param); 
	payload.PUT("pre","self",encKey).then(function(resp){       //No I18N
		if(resp.code === "MLN201"){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18N
			$(".verify-btn").html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			mobObject.created_time_elapsed = I18N.get("IAM.JUST.NOW"); //No I18N
			showSuccessPfaPop($(".sms-container .mode-header-texts").text());
			//if one new number verified
			//if unverified number is verified (mostly unverified will be verified in add-login or block unconfirmed)
			
			//if(mfaData.otp && mfaData.otp.count == 1 && mfaData.otp.mobile[0].is_primary){
			//	var del_button = $(".verified-numb-cont:first").children('.delete-icon')[0]
			//	del_button.setAttribute("onclick","handlePrefNumDelete(event, deletePhNumber, 'sms')"); //No I18N
			//	del_button.dataset.isprimary = true;
			//}
			//if(mobCount){
				//mfaData.otp.mobile.push(mobObject);
				//mfaData.otp.count = mobCount + 1;
			//} else {
				///if(mfaData.hasOwnProperty("otp")){
				//	Object.assign(mfaData.otp, {"mobile":[mobObject]});
				//}else{
				//	mfaData.otp = {"mobile":[mobObject]};
				//}
				//Object.assign(mfaData.otp, {"count":1});  //No I18N
				//mobCount = 0;
			//}
			addConfiguredMobile(mobObject, true);
			mobObject = {};
			newSms = $(".already-verified .verified-numb-cont")[0];
			setTimeout(function(){
				$(".new-number").slideUp(250);
				$(".already-verified").slideDown(250,function(){
					newSms.click();
				});
				document.querySelectorAll(".otp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
				$(".verify-btn").html("<span></span>"+I18N.get('IAM.NEW.SIGNIN.VERIFY'));
				resendtiming = 1;
				$(".verify_sms_form").hide();
				$("#mobile_input").val("");
				$(".confirm_form").show();
				
			}, 1000);
		}
	},
	function(resp)
	{
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18N
		classifyError(resp,"#otp_split_input")  /////need to complete //No I18N
	});	
}

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
function addNewPasskey(e) {
    $(".sms-container, .totp-container, .oneauth-container, .email-container, .IDP-container, .password-container").slideUp(200);
    $(".passkey-body .already-passkey-conf, .add-new-passkey").slideUp(200);
    $(".new-passkey").slideDown(200, function(){
		$("#passkey_input").focus();
	});
    if(nModes > 1){
		$(".passkey-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(200);
	}
}
var newPasskeyObj = {};
function initPasskeySetup(e){
	parentParams = {
		type: 'passkey', //No I18N
		requestor: EnforcedPfaPasskey
	}
	e.target.setAttribute("disabled",'');
	e.target.querySelector("span").classList.add("loader","miniloader"); //No I18N
	var passkeyObj = webAuthnRegister(parentParams);
	var name = document.querySelector('#passkey_input').value; //No I18N
	newPasskeyObj = {key_name : name};
	params = {
		payload: {name: name},
		args: ["pre","self"] //No I18N
	}
	passkeyObj.init(params).then(function(resp){
		//$(".passkey-one").slideUp(200, function(){
			e.target.removeAttribute("disabled");
			e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18N
		//});
		//$(".passkey-two").slideDown(200, function(){
			passCredential(e, passkeyObj);
		//});
	}, function(resp){
		e.target.removeAttribute("disabled");
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18N
		classifyError(resp, "#passkey_input"); //No I18N
	})
}
function passCredential(e, passkeyObj){
	passkeyObj.makeCredential().then(function(resp){
		registerPasskey(passkeyObj);
	},function(resp){
		if(typeof resp === 'string'){
			respObj = {"localized_message": resp} //No I18N
			classifyError(respObj)
		}else{
			classifyError(resp)
		}
	})
}
function registerPasskey(passkeyObj){
	params = {
		payload:{},
		args: ["pre","self","self"] //No I18N
	}
	passkeyObj.register(params).then(function(resp){
		newPasskeyObj.created_time_elapsed = I18N.get("IAM.JUST.NOW"); //No I18N
		addConfiguredPasskey(newPasskeyObj);
			passkeyObject = {};
			newPasskey = $(".already-passkey-conf .verified-passkey-cont")[0];
			setTimeout(function(){
				$(".new-passkey").slideUp(250);
				$(".already-passkey-conf").slideDown(250,function(){
					newPasskey.click();
				});
				$("#passkey_input").val("");
			}, 500);
		showSuccessPfaPop($(".passkey-container .mode-header-texts").text());
		
	},function(resp){
		if(typeof resp === 'string'){
			respObj = {"localized_message": resp} //No I18N
			classifyError(respObj)
		}else{
			classifyError(resp)
		}
	})
}
function passkeyStepBack(){
	$(".new-passkey").slideUp(300);
	$(".add-new-passkey").slideDown(300);
}
function initPasswordSetup(){
	$(".new-password .new-password-step-one").slideUp(300);
	$(".new-password .new-password-step-two").slideDown(300);
	document.getElementById('set_pass').setAttribute("disabled","");
	if(password_policy==undefined)
	{
		var mix_cases=true,spl_char=1,num=1,minlen=8,maxlen=250;
	}
	else
	{
		var mix_cases=password_policy.mixed_case;
		var spl_char=password_policy.min_spl_chars;
		var num=password_policy.min_numeric_chars;
		var minlen=password_policy.min_length;
	}
	ppValidator = validatePasswordPolicy(password_policy || {
		mixed_case: mix_cases,
		min_spl_chars : spl_char,
		min_numeric_chars: num,
		min_length: minlen,
		max_length: maxlen
	});
	ppValidator.init("#password_input");//no i18n
}
function setPassword(){
	var newPass = de('password_input').value;				//no i18n
	var confPass = de('confirm_password_input').value;		//no i18n
	if(newPass != confPass){
		show_error_msg("#confirm_password_input",I18N.get("IAM.AC.REENTER.PASSWORD.EMPTY.ERROR"));		//no i18n
		return false;
	}
	encryptData.encrypt([newPass]).then(function(encryptedpassword) {
		encryptedpassword = typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
		var params = {"newpassword": encryptedpassword}; //No I18N
	    var payload = EnforcedPassword.create(params);
		payload.POST("pre","self").then(function(){	 //No I18N
			showPasswordSuccess();
		},function(resp){
			classifyError(resp);
		});
	}).catch(function(error){
			//TBD : Error should be handled
	});
}

function showPasswordSuccess(){
	$(".msg-popups").prop("onkeydown","");
	$(".popup-icon")[0].classList.add("icon-success");
	$(".popup-heading").html(I18N.get("IAM.PFA.ANNOUN.PASSWORD.SUCCESS")) //No I18N
	$(".popup-body").html($("#password_redir").html());
	$(".pop-close-btn").hide();
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
function togglePassword(ele){
	if(ele.classList.contains('icon-show')){
		ele.classList.remove('icon-show');			//no i18n
		ele.classList.add('icon-hide');				//no i18n
		ele.previousElementSibling.setAttribute("type",'password');
	}
	else{
		ele.classList.remove('icon-hide');			//no i18n
		ele.classList.add('icon-show');				//no i18n
		ele.previousElementSibling.setAttribute("type",'text');
	}
}
function thirdparty_authentication(idpProvider) {	
		if(idpProvider != null) 
		{
			var oldForm = document.getElementById(idpProvider + "form");
			if(oldForm) 
			{
				document.documentElement.removeChild(oldForm);
			}
			var form = document.createElement("form");
			var action = encodeURI("/preannouncement/pfa/linkaccount/add?provider="+idpProvider.toUpperCase()); //No I18N
			var hiddenField = document.createElement("input");
	   	    hiddenField.setAttribute("type", "hidden");
	   	    hiddenField.setAttribute("name", csrfParam);
	        hiddenField.setAttribute("value", euc(getCookie(csrfCookieName))); 
	        form.appendChild(hiddenField);
			form.setAttribute("id", idpProvider + "form");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", action);
		    form.setAttribute("target", "_self");
	    	form.appendChild(hiddenField);
	    	document.documentElement.appendChild(form);
	    	form.submit();
		}
}
function addNewTotp(e){
	if(e.target.parentNode.classList.contains("already-totp-conf")){
		$(".new-totp-codes button.back-btn").show();
		$(".already-totp-conf").slideUp();
		$(document.verify_totp_form).hide();
	}
	$(".sms-container, .oneauth-container, .yubikey-container, .email-container, .passkey-container, .IDP-container, .password-container").slideUp(400);
	if(nModes > 1){
		$(".totp-container").css("border-bottom","1px solid #d8d8d8")
		$(".show-all-modes-but").slideDown(400);
	}
	var payload = EnforcedPfaTOTP.create();
	payload.POST("pre","self").then(function(resp){ //No I18N
		if(resp.code === "TOTP200"){
		var EnforcedPfaTOTP=resp.totp[0]; 
		de('gauthimg').src="data:image/jpeg;base64,"+EnforcedPfaTOTP.qr_image;
		var key=EnforcedPfaTOTP.secretkey;
		var displaykey = "<span>"+key.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+key.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+key.substring(8,12)+"</span>"+"<span style='margin-left:5px'>"+key.substring(12)+"</span>"; //No I18N
		$('#skey').html(displaykey);
		encKey = EnforcedPfaTOTP.encryptedSecretKey;	
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
		}else{
			classifyError(resp);
		}
	},
	function(resp){
		classifyError(resp);
	});
}
var emailObject = [], isEmailInited = false;
function addNewEmail(e){
	if(e.target.parentNode.classList.contains("already-verified-email")){
		$(".new-email-add button.back-btn").show();
		$(".already-verified-email").slideUp();
		$(document.verify_email_form).hide();
		$(".new-email").slideDown(200, function(){
			document.email_add_form.querySelector("input").focus(); //No I18N
		});
	}
	$(".sms-container, .oneauth-container, .passkey-container, .totp-container, .IDP-container, .password-container").slideUp(400);
	if(nModes > 1){
		$(".email-container").css("border-bottom","1px solid #d8d8d8");
		$(".show-all-modes-but").slideDown(400);
	}
	if(e.target.parentNode.classList.contains("add-new-cont")){	
		$(document.email_add_form).show();
		$(".add-new-email").slideUp(200);
		$(".new-email").slideDown(200, function(){
			document.email_add_form.querySelector("input").focus(); //No I18N
		});
	}
	if(!isEmailInited){
		splitField.createElement("emailotp_split_input", {
        	splitCount: otp_length, 
        	charCountPerSplit: 1, 
        	isNumeric: true, 
        	otpAutocomplete: true, 
        	customClass: "customOtp", //No I18N
        	inputPlaceholder: "&#9679;", 
        	placeholder: I18N.get("IAM.ENTER.CODE")
      	});
      	$("#emailotp_split_input .splitedText").attr("onkeydown", "clearError('#emailotp_split_input', event)");
      	isEmailInited = true;
	}
}
function sendEmailOTP(e){
	e.preventDefault();
	function toggleClassNAttr(target){
		target.toggleAttribute("disabled"); //No I18N
		var spantarget = target.querySelector("span") //No I18N
		spantarget.classList.toggle("loader")  //No I18N
		spantarget.classList.toggle("miniloader") //No I18N
		spantarget.classList.toggle("leftMargin") //No I18N
	}
	clearError('#email_input'); //No I18N
    var email = $("#email_input").val()
	if(email == ""){
		show_error_msg("#email_input",I18N.get("IAM.ERROR.EMPTY.FIELD")); //No I18N
		return false;
	}
    if (isEmailId(email)) {
    	toggleClassNAttr(e.target)
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
		$(".resend_otp").addClass("nonclickelem");
		emailObject = [{email_id: email}];
        var params = {"email_id": email}; //No I18N
        var payload = EnforcedPfaEmail.create(params);
        var eotpform = document.verify_email_form;
		eotpform.querySelector(".valueemail").textContent = email; //No I18N
		document.querySelectorAll(".emailotp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
		clearError("#emailotp_split_input") //No I18N
		payload.POST("pre","self").then(function(resp){ //No I18N
			
			$(document.email_add_form).slideUp(200, function(){
				toggleClassNAttr(e.target)
			})
			$(eotpform).slideDown(200, function(){});
			var pfaEmail = resp.email;
			emailEncKey = pfaEmail.encrypted_data;
			setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
					resendOtpChecking();
				}, 1000);
			}, 800);
		},function(resp){
			toggleClassNAttr(e.target)
			classifyError(resp, "#email_input"); //No I18N
		});
		
    }else{
    	show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID")); //No I18N
    }
        
}
function verifyEmailOTP(e){
	e.preventDefault();
	var code = $("#emailotp_split_input_full_value").val();
	if(code == ""){
		show_error_msg("#emailotp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD")); //No I18N
		return;
	}
	if(!isOTPValid(code)){
		show_error_msg("#emailotp_split_input", I18N.get("IAM.ERROR.VALID.OTP"));//No I18N
		return;
	}
	e.target.querySelector(".verify_btn").setAttribute("disabled",''); //No I18N
	e.target.querySelector(".verify_btn span").classList.add("loader","miniloader"); //No I18N
	var param = { "code":code }; //No I18N
	var payload = EnforcedPfaEmail.create(param); 
	payload.PUT("pre","self",emailEncKey).then(function(resp){ //No I18N
		if(resp.code === "EMAIL203"){
			e.target.querySelector(".verify_btn").removeAttribute("disabled"); //No I18N
			e.target.querySelector(".verify_btn span").classList.remove("loader","miniloader"); //No I18N
			$(".verify-btn").html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			emailObject[0].created_time_elapsed = I18N.get("IAM.JUST.NOW"); //No I18N
			showSuccessPfaPop($(".email-container .mode-header-texts").text());
			addConfiguredEmail(emailObject);
			emailObject = [];
			newEmail = $(".already-verified-email .verified-email-cont")[0];
			setTimeout(function(){
				$(".new-email").slideUp(250);
				$(".already-verified-email").slideDown(250,function(){
					newEmail.click();
				});
				document.querySelectorAll(".emailotp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
				$(".verify-btn").html("<span></span>"+I18N.get('IAM.NEW.SIGNIN.VERIFY'));
				resendtiming = 1;
				$(".verify_email_form").hide();
				$("#email_input").val("");
				$(".email_add_form").show();
			}, 1000);
		}
	}, function(resp){
		e.target.querySelector(".verify_btn").removeAttribute("disabled"); //No I18N
		e.target.querySelector(".verify_btn span").classList.remove("loader","miniloader"); //No I18N
		classifyError(resp,"#emailotp_split_input")  /////need to complete //No I18N
	});
}
function resendEmail(){
	if($(".resend_otp").is(":visible")){
		$(".resend_otp").addClass("nonclickelem");
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	}
	var parms = {};
	var payload = EnforcedPfaEmail.create(parms);
	
	payload.PUT("pre","self",emailEncKey).then(function(resp){ //No I18N
		setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
	},
	function(resp){
		classifyError(resp);
		$(".resend_otp").removeClass("nonclickelem");
		$(".resend_otp").html(I18N.get("IAM.NEW.SIGNIN.RESEND.OTP"));
		resendTiming = 1; 
	});
}
function editEmail(){
	$(document.verify_email_form).slideUp(200);
	$(document.email_add_form).slideDown(200);
	$("#email_input").focus();
}
var smsPrevSelect;
function selectNumberDevice(e){
	var isCheckbox = e.target.classList.contains("verified-checkbox");//No I18N
	if(isCheckbox){
		e.target.classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target.parentNode &&  !e.target.parentNode.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(confData.otp.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}else{
				if(confData.devices.count>1){
					showPreferedInfo(e.target.parentNode);
				}
			}
		}
		if(smsPrevSelect && smsPrevSelect != e.target.parentNode){
			smsPrevSelect.querySelector(".verified-checkbox").classList.remove("verified-selected");//No I18N
			if(! smsPrevSelect.parentNode.classList.contains("already-verified-recovery")){
				smsPrevSelect.querySelector(".pref-info").remove(); //No I18N
			}	
		}
		smsPrevSelect = e.target.parentNode;
	}
	else if(e.target.classList.contains("verified-app-cont")|| e.target.classList.contains("verified-numb-cont")){
		e.target.querySelector(".verified-checkbox").classList.add("verified-selected");//No I18N
		if(smsPrevSelect != e.target && ! e.target.parentNode.classList.contains("already-verified-recovery")){
			if($(e.target).parents(".sms-body").length){
				if(confData.otp.count>1){
					showPreferedInfo(e.target);
				}
			}else{
				if(confData.devices.count>1){
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

function resendSms(){
	if($(".resend_otp").is(":visible")){
		$(".resend_otp").addClass("nonclickelem");
		$(".resend_otp").html("<div class='loader nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	}
	var parms = {};
	var payload = EnforcedPfaMobile.create(parms);
	
	payload.PUT("pre","self",encKey).then(function(resp){ //No I18N
		setTimeout(function(){
				$(".resend_otp").html("<div class='tick nonclic'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
	},
	function(resp){
		classifyError(resp);
		$(".resend_otp").removeClass("nonclickelem");
		$(".resend_otp").html(I18N.get("IAM.NEW.SIGNIN.RESEND.OTP"));
		resendTiming = 1; 
	});
}

function showPreferedInfo(parentEle){
	var sibEle = parentEle.querySelector(".delete-icon"); //No I18N
	var newEle = document.querySelector(".pref-info").cloneNode(true)  //No I18N
	if(parentEle.classList.contains("verified-numb-cont")){
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL") //No I18N
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC")//No I18N
	}else{
		newEle.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL")//No I18N
		newEle.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC")//No I18N
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
		$(".delete_mfa_numb, .textbox_label").hide();
		switch(mode){
			case "totp" : $(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE", I18N.get("IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR")));  //No I18N
						  break;
			case "sms":	//No I18N
			case "oneauth": //No I18N
			case "yubikey": //No I18N
				var content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				$(".delete-desc").html(I18N.get("IAM.MFA.CONFIRM.DELETE.MODE",content));  //No I18N
				break;
		}
		document.querySelector(".confirm-delete-btn").addEventListener("click",dfunc);  //No I18N
	popup_blurHandler(6);
	$(".delete-popup").show();
	$(".delete-popup").focus();
	
}

function handlePrefNumDelete(e, dfunc, mode){
		e.stopPropagation();
		deleteEvent = e.target;
		$(".delete_mfa_numb, .textbox_label").show();
		switch(mode){								
			case "sms":	//No I18N			
				var content = $(e.target.parentNode).find(".name-detail")[0].textContent;
				//msg.querySelector(".popuphead_desc").innerHTML = formatMessage(i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB.DESC"],mobile) // No I18N
				$(".delete-desc").html(I18N.get("IAM.MFA.DEL.PREF.NUMB.DESC",content));  //No I18N
				
				
				
				//var backupnumbs = $(".verified-numb-cont"); // No I18N
				var backupnumbs = mfaData.otp.mobile; 
				$(".deleteMFAPref").not(':first').remove();
				for(i=0;i<backupnumbs.length;i++){			
					if(backupnumbs[i].is_primary || !Object.hasOwn(backupnumbs[i],"r_mobile")){
						continue;
					}					
					var numb = backupnumbs[i].r_mobile.split("-");
					var displayNo = "+"+numb[0]+" "+numb[1];
					var eachbackup = document.querySelector(".radio_btn.deleteMFAPref").cloneNode(true); // No I18N
					eachbackup.querySelector("input").value = backupnumbs[i].e_mobile; // No I18N
					eachbackup.querySelector(".radiobtn_text").textContent = displayNo; // No I18N
					eachbackup.querySelector(".radiobtn_text").style.pointerEvents = "none"; //No I18N
					eachbackup.style.display = "flex"; // No I18N
					document.querySelector(".delete_mfa_numb").append(eachbackup); // No I18N
				}
				break;
		}
		document.querySelector(".confirm-delete-btn").addEventListener("click",dfunc);  //No I18N
		$(".confirm-delete-btn").attr("disabled","disabled"); // No I18N
		$(".delete_mfa_numb").on("click", function(e){
			if(e.target.classList.contains("deleteMFAPref")){
				$(e.target).children("#mfamobilepref").click();
			}else{
				e.target.click();
				if(e.target.name == "selectmode" && $(e.target).is(":checked")){
					$(".confirm-delete-btn").removeAttr("disabled");
				}
			}
		});
	popup_blurHandler(6);
	$(".delete-popup").show();
	$(".delete-popup").focus();
	
}

function deletePhNumber(){
	var enckey = deleteEvent.dataset.enckey;
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	if(deleteEvent.dataset.isprimary == 'true'){
		var primEar = $("input[name= 'selectmode']:checked").val();
		var uri = new URI(EnforcedPfaMobile,"pre","self",enckey).addQueryParam("primary",primEar); // No I18N
		
	} else {
		var uri = new URI(EnforcedPfaMobile,"pre","self",enckey); // No I18N
	}
			
	
	uri.DELETE().then(function(resp){
		if(resp.code === "MOB206"){
			$(".delete-popup").slideUp(200);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(deleteEvent).parent().animate({ "padding": "0px" , "height": "0px" , "font-size":"0px"}, 200, function(){ 
				$(this).remove();
				if(!$(".modes-container .verified-selected:visible").length){
				$(".sms-container .mode-header").click();
				smsPrevSelect = "";
				if(mfaData.otp.count == 1 && deleteEvent.dataset.isprimary == 'false'){
					var del_button = $(".verified-numb-cont:first").children('.delete-icon')[0]
					del_button.setAttribute("onclick","handleDelete(event, deletePhNumber, 'sms')"); //No I18N
					del_button.dataset.isprimary = false;
				}
			}
			});
			
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			arraypos = deleteEvent.dataset.pos;
			mfaData.otp.mobile[arraypos] ={};
			mfaData.otp.count -= 1;
			mobCount -= 1;
			if(mfaData.otp.count > 1){
				var del_button = $(".verified-numb-cont").find("[data-enckey='" + primEar + "']").siblings('.delete-icon')[0];
				del_button.setAttribute("onclick","handlePrefNumDelete(event, deletePhNumber, 'sms')"); //No I18N
				del_button.dataset.isprimary = true;
			}
			
			mfaData.otp.mobile.find(function (o){
			    return o.e_mobile === primEar;
			}).is_primary = true;			
			if ($(".sms-container .mode-header-texts span:visible").length > 1){
				document.querySelectorAll(".sms-container .mode-header-texts span")[1].remove();
			}
			var headerText = getModeHeaderText(mobCount, mobileHeader)
			if(headerText instanceof HTMLElement){ 
				document.querySelector(".sms-container .mode-header-texts").append(headerText);//No I18N
			}
			if(mobCount < 2){
				$(".sms-container .already-desc.many").hide();
				$(".sms-container .already-desc.one").show();
			}
			if(mobCount < 1){
				$(".already-verified").slideUp(250);
				$(".add-new-number").slideDown(250);
			}
		}
	},function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		classifyError(resp);
	})
}

function deleteYubikey(){
	var e_keyname = deleteEvent.dataset.eyubikeyid;
	new URI(EnforcedMfaYubikey,"pre","self",e_keyname).DELETE().then(function(resp){  //No I18N
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
		classifyError(resp);
	})
}

function deleteConfTotp(){
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(EnforcedPfaTOTP,"pre","self").DELETE().then(function(resp){  //No I18N
		if(resp.code === "TOTP202"){
			$(".delete-popup").slideUp(300);
			removeBlur();
			showErrMsg(resp.localized_message, true);
			$(".confirm-delete-btn span")[0].classList.remove("loader");
			$(".confirm-delete-btn").removeAttr("disabled");
			mfaData.totp={};
			$(".already-totp-conf").slideUp(250);
			$(".add-new-totp").slideDown(250,function(){
				$(".totp-container .mode-header").click();
			});
			document.querySelectorAll(".totp-container .mode-header-texts span")[1].remove();
		}
	},function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		classifyError(resp);
	})
}

function deleteOneAuth(){
	var enckey = deleteEvent.dataset.enckey;
	$(".confirm-delete-btn").attr("disabled","");
	$(".confirm-delete-btn span")[0].classList.add("loader");
	new URI(EnforcedMfaDevice,"pre","self",enckey).DELETE().then(function(resp){  //No I18N
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
				$(".oneauth-container .mode-header").children(".add-oneauth").slideDown(200, function(){ //No I18N
					document.querySelector(".add-qr").classList.add("qr-anim") //No I18N
					document.querySelector(".oneauth-container .mode-header").classList.add("empty-oneauth-header"); //No I18N
				});
				document.querySelector(".oneauth-container .tag").style.opacity = "0" //No I18N
				document.querySelector(".oneauth-container .mode-icon").classList.add("mode-icon-large")//No I18N
				document.querySelector(".oneauth-container .mode-header-texts").classList.add("oneauth-head-text"); //No I18N
				document.querySelector(".oneauth-container .oneauth-desc").style.display = "block";
			}

		}
	},
	function(resp){
		$(".confirm-delete-btn span")[0].classList.remove("loader");
		$(".confirm-delete-btn").removeAttr("disabled");
		cancelDelete();
		classifyError(resp);
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
	$(".delete-popup").slideUp(200);
	removeBlur();
	$(".delete-cancel-btn").unbind();
	$(".confirm-delete-btn").removeAttr("disabled");
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
	$(document.verify_totp_form).slideDown(200);
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
	e.target.querySelector("span").classList.add("loader","miniloader"); //No I18N
	var param = { "code":code }; //No I18N
	var payload = EnforcedPfaTOTP.create(param);
	payload.PUT("pre","self",encKey).then(function(resp){ //No I18N
		if(resp.code === "TOTP201"){
			showErrMsg(resp.localized_message,true);
			e.target.removeAttribute("disabled");
			$(e.target).html("<div class='verified_tick'></div>"+I18N.get('IAM.VERIFIED')); //No I18N
			showSuccessPfaPop($(".totp-container .mode-header-texts").text());
			setTimeout(function(){
				$(".new-totp").slideUp(250);
				$(".already-totp-conf-desc.before").hide()
				$(".already-totp-conf-desc.after").show();
				/*if(mfaData.is_mfa_activated && alreadyConfiguredModes.length>0){
					$(".already-totp-conf-desc.after span").html(I18N.get('IAM.CONFIGURE'));
				}*/
				if( !confData.totp || Object.keys(confData.totp).length == 0){
					var headerText = document.createElement("span");
					headerText.textContent =  I18N.get("IAM.CONFIGURED");
					document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18N
				}
				$(".verify-totp-pro-but").hide();
				$(".delete_totp_conf").show();
				$(".already-totp-conf .add-new-totp-but").addClass("change-config")
				$(".already-totp-conf .hidden-checkbox")[0].classList.add("verified-selected");  //No I18N
				$(".already-totp-conf").slideDown(250);
				document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
				$(e.target).html("<span></span>"+I18N.get('IAM.NEW.SIGNIN.VERIFY'));
				$(document.verify_totp_form).hide();
				$(".totp-container .mode-header").click();
			}, 300);
		}
	},
	function(resp){	
		e.target.querySelector("span").classList.remove("loader","miniloader"); //No I18N
		e.target.removeAttribute("disabled");
		classifyError(resp, "#totp_split_input"); //No I18N
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
	$(".new-totp").slideUp(200);
	clearError('#totp_split_input'); //No I18N
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
	$(".already-totp-conf").slideDown(200, function(){
		$(".totp-container .mode-header").click();
	});
}
function totpStepBack(){
	$(document.verify_totp_form).slideUp(200);
	clearError('#totp_split_input'); //No I18N
	document.querySelectorAll(".totp_split_input_otp").forEach(function(eachEle){ eachEle.value =""; }); //No I18N
	$(".new-totp-codes").slideDown(200);
}
var styleOrder=0;
function displayAlreadyConfigured(mode, modeData){
	switch(mode){
		case "totp":  //No I18N
		if($(".totp-container").length){
			$(".totp-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredTotp(modeData)){
		document.querySelector(".add-new-totp").style.display ="none" //No I18N
		document.querySelector(".already-totp-conf").style.display = "block"; //No I18N
		}
		break;
		case "otp": //No I18N
		if($(".sms-container").length){
			$(".sms-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredMobile(modeData)){
		document.querySelector(".add-new-number").style.display ="none"; //No I18N
		document.querySelector(".already-verified").style.display = "block"; //No I18N
		}
		break;
		case "devices": //No I18N
		if($(".oneauth-container").length){
			$(".oneauth-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredDevice(modeData)){
			if(isBioEnforced){
				$(".already-verified-app .already-desc").hide();
			}
			document.querySelector(".already-verified-app").style.display = "block";
		}
		break;
		case "yubikey": //No I18N
		if($(".yubikey-container").length){
			$(".yubikey-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredYubikey(modeData)){
		document.querySelector(".add-new-yubikey").style.display ="none"; //No I18N
		document.querySelector(".already-yubikey-conf").style.display = "block"; //No I18N
		}
		break;
		case "passkey": //No I18N
		if($(".passkey-container").length){
			$(".passkey-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredPasskey(modeData)){
		document.querySelector(".add-new-passkey").style.display ="none"; //No I18N
		document.querySelector(".already-passkey-conf").style.display = "block"; //No I18N
		}
		break;
		case "email": //No I18N
		if($(".email-container").length){
			$(".email-container").insertBefore($(".mode-cont")[styleOrder]);
			styleOrder++;
		}
		if(addConfiguredEmail(modeData)){
		document.querySelector(".add-new-email").style.display ="none"; //No I18N
		document.querySelector(".already-verified-email").style.display = "block"; //No I18N
		}
		break;
	}
}

function addConfiguredTotp(modeData){
	if(document.querySelector(".totp-container")){
	var headerText = document.createElement("span");
	headerText.textContent =  I18N.get("IAM.CONFIGURED");
	document.querySelector(".totp-container .mode-header-texts").append(headerText);//No I18N
	document.querySelector(".already-totp-conf .add-new-totp-but").classList.add("change-config"); //No I18N
	document.querySelector(".already-totp-conf-desc>span").textContent = modeData.created_time_formated; //No I18N
	//document.querySelector(".delete-totp-conf").dataset.secretkey = modeData.secretkey;  //No I18N
	return true;
	} else {
		return false;
	}
}
var mobCount;
function addConfiguredMobile(modeData, isNew){
	if(document.querySelector(".sms-container")){
	mobCount = mobCount == undefined ? 1 : mobCount + 1;
	if(mobCount){
		var headerText = getModeHeaderText(mobCount, mobileHeader)
		//// op /////
		if ($(".sms-container .mode-header-texts span:visible").length > 1){
			document.querySelectorAll(".sms-container .mode-header-texts span")[1].remove();
		}
		document.querySelector(".sms-container .mode-header-texts").append(headerText);//No I18N
	}
	if(mobCount == 1){
		$(".already-verified .already-desc.many").hide();
		$(".already-verified .already-desc.one").show();
	}else if(mobCount>1){
		$(".already-verified .already-desc.many").show();
		$(".already-verified .already-desc.one").hide();
	}
	
	//for(i = 0; i < modeData.length;i++){
		var verifiedCont = null;
		var verifiedCont = document.querySelector(".verified-numb-cont").cloneNode(true); //No I18N
		var displayNo = "+"+modeData.dcode+" "+modeData.mobile;
		verifiedCont.querySelector(".verified-number").textContent = displayNo; //No I18N
		verifiedCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.created_time_elapsed); //No I18N
		
		/*if(modeData.mobile[i].is_primary && (modeData.mobile.length > 1)){			
			verifiedCont.querySelector(".delete-icon").setAttribute("onclick","handlePrefNumDelete(event, deletePhNumber, 'sms')"); //No I18N
			verifiedCont.querySelector(".delete-icon").dataset.isprimary = true; //No I18N
		} else {
			verifiedCont.querySelector(".delete-icon").setAttribute("onclick","handleDelete(event, deletePhNumber, 'sms')"); //No I18N
			verifiedCont.querySelector(".delete-icon").dataset.isprimary = false; //No I18N
		}
		verifiedCont.dataset.enckey = modeData.mobile[i].e_mobile;
		verifiedCont.querySelector(".delete-icon").dataset.enckey = modeData.mobile[i].e_mobile;
		verifiedCont.querySelector(".verified-checkbox").dataset.enckey = modeData.mobile[i].e_mobile;
		if(isNew){
			verifiedCont.querySelector(".delete-icon").dataset.pos = (mfaData.otp.mobile.length)-1; //No I18N
		} else{
			verifiedCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}
		//need to check and set if new number is added  //No I18N */
		var exisnode = document.querySelector(".already-verified .verified-numb-cont"); //No I18N
		verifiedCont.style.display = "flex";
		exisnode.parentNode.insertBefore(verifiedCont, exisnode.nextSibling);
	//}
	return true;
	} else {
		return false;
	}
}
/*var primDev;
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
		oneCont.querySelector(".delete-icon").dataset.pos = i;  //No I18N
		if(modeData.device[i].is_primary){
			primDev = modeData.device[i].device_name;
		}
		if(parseInt(modeData.device[i].app_version)<2){
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent = ""; //No I18N
			oneCont.querySelector(".added-period").style.opacity= "1"; //No I18N
			var updatepref = document.querySelector(".pref-info").cloneNode(true)  //No I18N
			updatepref.classList.add("update-app"); //No I18N
			updatepref.style.display = "block";
			updatepref.querySelector(".pref-text span").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL");//No I18N
			updatepref.querySelector(".pref-desc").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC");//No I18N
			oneCont.querySelector(".added-period").append(updatepref);//No I18N
			oneCont.querySelector(".verified-app-details").style.pointerEvents = "auto";//No I18N
		} else if(isBioEnforced){
			if(modeData.device[i].is_primary){
				oneCont.querySelector(".delete-icon").remove(); //No I18N
			}
			oneCont.setAttribute("onclick","");
			oneCont.querySelector(".verified-checkbox").style.visibility = "hidden";
			oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		} else{			
		oneCont.querySelector(".added-period").textContent =  I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.device[i].created_time_elapsed); //No I18N
		oneCont.querySelector(".verified-checkbox").dataset.enckey = modeData.device[i].device_id;
		oneCont.querySelector(".verified-checkbox").dataset.pref = modeData.device[i].pref_option;
		}
		var exisnode = document.querySelector(".already-verified-app .already-desc.one");//No I18N
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
}*/
var keyCount;
function addConfiguredYubikey(modeData, isNew){
	if(document.querySelector(".yubikey-container")){
	keyCount = keyCount == undefined ? modeData.count : keyCount+1;
	var headerText = getModeHeaderText(keyCount, yubikeyHeader)
	if ($(".yubikey-container .mode-header-texts span:visible").length > 1){
		document.querySelectorAll(".yubikey-container .mode-header-texts span")[1].remove();
	}
	document.querySelector(".yubikey-container .mode-header-texts").append(headerText); //No I18N
	if(isNew){
		if(mfaData.is_mfa_activated && alreadyConfiguredModes.length>0){
			onedesc = I18N.get("IAM.MFA.ANNOUN.YUBI.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.YUBI.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
		}else{
			onedesc = I18N.get("IAM.MFA.ANNOUN.YUBI.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.YUBI.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
		}
		$(".already-yubikey-conf .already-desc.many").html(manydesc);
		$(".already-yubikey-conf .already-desc.one").html(onedesc);
	}
	if(keyCount == 1){
		$(".already-yubikey-conf .already-desc.many").hide();
		$(".already-yubikey-conf .already-desc.one").show();
	}else if(keyCount>1){
		$(".yubikey-body .warning-msg").show();
		$(".already-yubikey-conf .already-desc.many").show();
		$(".already-yubikey-conf .already-desc.one").hide();
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
		var exisnode = document.querySelector(".already-yubikey-conf .already-desc.one");//No I18N
		yubiCont.style.display = "flex";
		exisnode.parentNode.insertBefore(yubiCont, exisnode.nextSibling);
	}
	return true;
	}else {
		return false;
	}
}
var passCount
function addConfiguredPasskey(modeData, isNew){
	if(document.querySelector(".passkey-container")){
	passCount = passCount == undefined ? modeData.count : passCount+1;
	var headerText = getModeHeaderText(passCount, passkeyHeader)
	if ($(".passkey-container .mode-header-texts span:visible").length > 1){
		document.querySelectorAll(".passkey-container .mode-header-texts span")[1].remove();
	}
	document.querySelector(".passkey-container .mode-header-texts").append(headerText); //No I18N
	/*if(isNew){
		if(mfaData.is_mfa_activated && alreadyConfiguredModes.length>0){
			onedesc = I18N.get("IAM.MFA.ANNOUN.YUBI.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.YUBI.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
		}else{
			onedesc = I18N.get("IAM.MFA.ANNOUN.YUBI.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.YUBI.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
		}
		$(".already-yubikey-conf .already-desc.many").html(manydesc);
		$(".already-yubikey-conf .already-desc.one").html(onedesc);
	}*/
	if(passCount == 1){
		$(".already-passkey-conf .already-desc.many").hide();
		$(".already-passkey-conf .already-desc.one").show();
	}else if(passCount>1){
		$(".passkey-body .warning-msg").show();
		$(".already-passkey-conf .already-desc.many").show();
		$(".already-passkey-conf .already-desc.one").hide();
	}
	//for(i=0;i<modeData.passkey.length;i++){
		var passCont = document.querySelector(".verified-passkey-cont").cloneNode(true); //No I18N
		passCont.querySelector(".verified-passkey").textContent = decodeHTML(modeData.key_name); //No I18N
		passCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData.created_time_elapsed); //No I18N
		/*passCont.querySelector(".delete-icon").dataset.eyubikeyid = modeData.yubikey[i].e_keyName;
		if(isNew){
			yubiCont.querySelector(".delete-icon").dataset.pos = keyCount - 1; //No I18N
		} else{
			yubiCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}*/
		var exisnode = document.querySelector(".already-passkey-conf .verified-passkey-cont");//No I18N
		passCont.style.display = "flex";
		exisnode.parentNode.insertBefore(passCont, exisnode.nextSibling);
	//}
	return true;
	}else {
		return false;
	}
}
var emailCount;
function addConfiguredEmail(modeData, isNew){
	if(document.querySelector(".email-container")){
	emailCount = emailCount == undefined ? modeData.length : emailCount + 1;
	if(emailCount){
		var headerText = getModeHeaderText(emailCount, emailHeader)
		//// op /////
		if ($(".email-container .mode-header-texts span:visible").length > 1){
			document.querySelectorAll(".email-container .mode-header-texts span")[1].remove();
		}
		document.querySelector(".email-container .mode-header-texts").append(headerText);//No I18N
	}
	/*if(isNew){
		if(mfaData.is_mfa_activated && alreadyConfiguredModes.length>0){
			onedesc = I18N.get("IAM.MFA.ANNOUN.SMS.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.SMS.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.CONFIGURE")
		}else{
			onedesc = I18N.get("IAM.MFA.ANNOUN.SMS.ONE.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
			manydesc = I18N.get("IAM.MFA.ANNOUN.SMS.MANY.DESC") +" "+ I18N.get("IAM.MFA.ANNOUN.USE.SAME.ENABLE")
		}
		$(".already-verified .already-desc.many").html(manydesc);
		$(".already-verified .already-desc.one").html(onedesc);
	}*/
	if(emailCount == 1){
		$(".already-verified .already-desc.many").hide();
		$(".already-verified .already-desc.one").show();
	}else if(emailCount>1){
		$(".already-verified .already-desc.many").show();
		$(".already-verified .already-desc.one").hide();
	}
	
	for(i = 0; i < modeData.length;i++){
		var verifiedCont = null;
		var verifiedCont = document.querySelector(".verified-email-cont").cloneNode(true); //No I18N
		verifiedCont.querySelector(".verified-email").innerHTML = modeData[i].email_id; //No I18N
		verifiedCont.querySelector(".added-period").textContent = I18N.get("IAM.USER.CREATED.TIME.ADDED", modeData[i].created_time_elapsed); //No I18N
		
		/*if(modeData[i].is_primary && (modeData.mobile.length > 1)){			
			verifiedCont.querySelector(".delete-icon").setAttribute("onclick","handlePrefNumDelete(event, deletePhNumber, 'sms')"); //No I18N
			verifiedCont.querySelector(".delete-icon").dataset.isprimary = true; //No I18N
		} else {
			verifiedCont.querySelector(".delete-icon").setAttribute("onclick","handleDelete(event, deletePhNumber, 'sms')"); //No I18N
			verifiedCont.querySelector(".delete-icon").dataset.isprimary = false; //No I18N
		}
		verifiedCont.dataset.enckey = modeData.mobile[i].e_mobile;
		verifiedCont.querySelector(".delete-icon").dataset.enckey = modeData.mobile[i].e_mobile;
		verifiedCont.querySelector(".verified-checkbox").dataset.enckey = modeData.mobile[i].e_mobile;
		if(isNew){
			verifiedCont.querySelector(".delete-icon").dataset.pos = (mfaData.otp.mobile.length)-1; //No I18N
		} else{
			verifiedCont.querySelector(".delete-icon").dataset.pos = i; //No I18N
		}*/
		//need to check and set if new number is added  //No I18N
		var exisnode = document.querySelector(".already-verified-email .already-desc.one"); //No I18N
		verifiedCont.style.display = "flex";
		exisnode.parentNode.insertBefore(verifiedCont, exisnode.nextSibling);
	}
	return true;
	} else {
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
	parentform.querySelector("button").setAttribute('disabled', ''); //No I18N
	$(".error_msg").slideDown(150);
}
      
function clearError(ClassorID, e){
	if( e && e.keyCode == 13 && $(".error_msg:visible").length){
		return;
	}
	parentform = $(ClassorID).closest("form")[0];
	parentform.querySelector("button").removeAttribute('disabled'); //No I18N
    $(ClassorID).removeClass("errorborder") //No I18N
    $(".error_msg").remove(); //No I18N
}

function checkNetConnection(){
	setInterval(function(){
		if(window.navigator.onLine){
			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
		}
	}, 2000)
}

function showErrMsg(msg, isSuccessMsg){
	if(isSuccessMsg){
		document.getElementById("error_space").classList.add("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = ""; //No I18N
	}else{
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
	}
	document.getElementById("error_space").classList.remove("show_error"); //No I18N
	document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N

	document.getElementById("error_space").classList.add("show_error");//No I18N
	setTimeout(function() {
		document.getElementById("error_space").classList.remove("show_error");//No I18N
	}, 5000);;
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
			var params = {"mode" : 0, "primary" : selectedCheckbox.dataset.enckey} //No I18N
		}else{
			var params = {"mode" : selectedCheckbox.dataset.pref, "primary" : selectedCheckbox.dataset.enckey} //No I18N
		}
	} else{
		if(selectedCheckbox.parentNode.classList.contains("already-yubikey-conf")){
			var params = {"mode" : 8} //No I18N
		}else {
			var params = {"mode" : 1} //No I18N
		}
	}
	var payload = EnforcedMfa.create(params);
	payload.PUT("pre", "mode").then(function(resp){ //No I18N
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
		classifyError(resp);
	})
}
function showSuccessPfaPop(mode){
	$(".msg-popups").prop("onkeydown","");
	$(".pop-close-btn").hide();
	$(".popup-icon")[0].classList.add("icon-success");
	$(".popup-heading").html(Util.format(I18N.get("IAM.PFA.MODE.SUCC"), mode))
	$(".popup-body").html($(".pfa-success-desc").html());

	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
}
function contSignin(e){
	e.target.setAttribute("disabled","disabled"); //No I18N
	if(e.target.querySelector("span")){e.target.querySelector("span").classList.add("loader");} //No I18N
	window.location.href = next;
}

function showOneauthPop(){
	$(".oneauth-container .mode-header").click();
	document.querySelector(".msg-popups").style.maxWidth = "660px"; //No I18N
	document.querySelector(".msg-popups .popup-icon").classList.remove("icon-success")  //No I18N
	document.querySelector(".msg-popups .popup-header").style.display = "none";
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-popup").innerHTML;  //No I18N
	document.querySelector(".msg-popups .popup-body").classList.add("padding-oneauthpop");  //No I18N
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block";
	if(isMobile){
		if(/Android/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").hide()
			$(".msg-popups .macstore-icon").hide();
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
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-bio").innerHTML;  //No I18N
	document.querySelector(".bio-steps .oneauth-step b").textContent = primDev; //No I18N
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block"; //No I18N
	popup_blurHandler(6);
	$(".msg-popups").slideDown(300);
	$(".msg-popups").focus();
}
	
function showReloginPop(){
	document.querySelector(".msg-popups .popup-heading").textContent = I18N.get("IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD");  //No I18N
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-relogin").innerHTML;  //No I18N
	document.querySelector(".msg-popups .popup-body").classList.remove("padding-oneauthpop");  //No I18N
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
  var copyText = element.querySelector("#skey"); //No I18N
  navigator.clipboard.writeText(copyText.textContent);
  var tickElement = document.createElement("span");
  tickElement.classList.add("tooltip-tick"); //No I18N
  element.querySelector(".tooltip-text").innerText = I18N.get("IAM.APP.PASS.COPIED"); //No I18N
  element.querySelector(".tooltip-text").prepend(tickElement); //No I18N
  return;
}

function resetTooltipText(element) {	
	var tooltipHide = setInterval(function() {
		element.querySelector(".tooltip-text").innerText = I18N.get("IAM.MFA.COPY.CLIPBOARD"); //No I18N
		clearTimeout(tooltipHide);	
	}, 300);
	return;
}

function checkPassword(){
	if(password_policy==undefined)
	{
		var mix_cases=true,spl_char=1,num=1,minlen=8,maxlen=250;
	}
	else
	{
		var mix_cases=password_policy.mixed_case;
		spl_char=password_policy.min_spl_chars;
		num=password_policy.min_numeric_chars;
		minlen=password_policy.min_length;
	}
	var str=$("#password_input").val();
	ppValidator = validatePasswordPolicy(password_policy || {
		mixed_case: mix_cases,
		min_spl_chars : spl_char,
		min_numeric_chars: num,
		min_length: minlen,
		max_length: maxlen
	});
	var err_str = ppValidator.getErrorMsg(str);
    if (err_str == 0 && str != "" && document.getElementById('confirm_password_input').value != ""){
       de('set_pass').removeAttribute("disabled");
    }else {
       de('set_pass').setAttribute("disabled","");
    }

}
