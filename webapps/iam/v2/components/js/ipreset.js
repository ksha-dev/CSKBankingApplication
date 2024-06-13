//$Id$

var isCountrySelected = false;
var primary_factor_otp_threshold = 4;
var MFA_otp_threshold = 4;
var resendcheck = undefined;
var first_otp_sent = false;
var prev_MFA_option;
function onRecoveryReady()
{
	ipRestrictedForOrg=undefined;
	ipPersonalRestriction=undefined;
	redirect_url=undefined;
	$("input:text").val("");
	$(".real_radiobtn").prop('checked', false);
	clear_user_info();
	$("#login_id").attr("disabled", false);
    $(".recover_sections").removeClass("allowed_mode");
	login_id= login_id != "" ? login_id : undefined;
	contact_support_email=undefined;
	is_recovery_extra_modes=false;
    digest=undefined;
    zuid=undefined;
    recovery_modes=undefined;
    mfa_modes=undefined;
    mzadevicepos =  0;
    clearInterval(_time); 
    wmscount =0;
    verifyCount = 0;
    org_name=undefined;
    org_contact=undefined;
    totalCount = 0;
    isWmsRegistered=false;
    wmscallmode,wmscallapp,wmscallid=undefined;
    reload_page ="";
    isOrgAdmin=undefined;
    token = "";
	if(isValid(reqCountry))
	{
      	reqCountry = reqCountry.toUpperCase();
      	$('#country_code_select option:selected').removeAttr('selected');
      	$("#country_code_select #"+reqCountry).prop('selected', true);
      	$("#country_code_select #"+reqCountry).trigger('change');
    }
	
	if(isValid(login_id)	&&	(isUserName(login_id) || isEmailId(login_id) || isPhoneNumber(login_id.split('-')[1])))
	{
		$("#login_id").val(login_id);
	}
	
	$(".select_country_code").html($("#country_code_select").val());
	
	if(!isMobile && isEmpty(digest_id)){
		renderUV("#country_code_select", true, "#login_id", "left", "flagIcons", true, true, "country_implement", undefined, "data-num", "value", "data-num");//no i18n
		$(".select_container--country_implement").hide();
		uvselect.setIntentForCntyCode("country_code_select"); //no i18N 
	}
	
    $("#select2-country_code_select-container").html($("#country_code_select").val());
    $("#country_code_select").change(function()
    {
      $(".country_code").html($("#country_code_select").val());
    });
    hideGif();
    $("#login_id").focus();
    
}

function backToLookup(){
	var redirectURL = window.location.href.split("?")[0];
	window.location = getACParms() != "" ?  redirectURL +"?"+ getACParms() : redirectURL;
}

function switchto(url)
{
	clearTimeout(reload_page);
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


function update_user_info(user_id)
{
	var login_info = login_id!=undefined ? login_id : user_id ;
	$(".user_info .menutext").text(identifyEmailOrNum(login_info));
	$(".user_info").show();
}

function identifyEmailOrNum(login_id){
	var userLogin = login_id;
	if(isPhoneNumber(userLogin.split('-')[1])){
		return "+"+userLogin.split('-')[0]+" "+userLogin.split('-')[1];
	}else{
		return userLogin;
	}
}

function clear_user_info()
{
	$(".user_info .menutext").text("");
	$(".user_info").hide();
}

function change_user()
{
	first_otp_sent = false;
	primary_factor_otp_threshold = 4;
	resendcheck = undefined;
	MFA_otp_threshold = 4;
    var uID = $(event.target).parent().find(".menutext").text();
    var country_code = "";
    isValid(uID)?"":uID= $("#login_id").val().trim();
    if(isPhoneNumber(uID.split(" ")[1]))
    {
    	if(uID[0]=="+"){uID = uID.slice(1,uID.length)}
    	country_code = uID.split(" ")[0];
    	uID = uID.split(" ")[1];
    }
	onRecoveryReady();
	
	clear_user_info();
	$("#login_id_container").show();
	$("#lookup_div .head_info").show();
	$(".recover_sections").hide();
	$("#captcha_container").hide();
	$("#lookup_div").show();
	$("#login_id")[0].classList.value="textbox";
	$("#login_id").val(uID).focus();
	if(isMobile){
		$("#country_code_select").val("+"+country_code).change();
	}else{
		$("#country_code_select").uvselect("destroy");
		if(country_code!=""){$("#country_code_select").val('+'+country_code);}
		renderUV("#country_code_select", true, "#login_id", "left", "flagIcons", true, true, "country_implement", undefined, "data-num", "value", "data-num");//no i18n
	}
	input_checking();
	removeCaptchaError();// remove errors in captcha
	clear_allerrors();
	hip_required=false;
	//$(".recover_sections").removeClass("allowed_mode");
}



function hideGif(){
	$(".blur_elem,.loader").hide();
}

function showGif(){
	$(".blur_elem,.loader").show();
}

function format (option) 
{
	var spltext;
      if (!option.id) { return option.text; }
         spltext=option.text.split("(");
         var cncode = $(option.element).attr("data-num");//no i18N 
		 var cnnumber = $(option.element).attr("value");//no i18N
		 var cnnum = cnnumber.substring(1);
		 var flagcls="flag_"+cnnum+"_"+cncode;//no i18N
      var ob = '<div class="pic '+flagcls+'" ></div><span class="cn">'+spltext[0]+"</span><span class='cc'>"+cnnumber+"</span>" ;
      return ob;
 };



function changeCountryCode()
{
	$('.select_country_code').text($('#country_code_select').val());
}


function handleRequestCountryCode(resp)
{
	if(IsJsonString(resp)){resp=JSON.parse(resp) }
	if(resp.isd_code)
	{
		reqCountry = resp.country_code;
		reqCountry = reqCountry.toUpperCase();
      	$('#country_code_select option:selected').removeAttr('selected');
      	$("#country_code_select #"+reqCountry).prop('selected', true);
      	$("#country_code_select #"+reqCountry).trigger('change');
      	$("#login_id").removeClass("textindent62");
        $("#login_id").removeClass("textintent52");
        $("#login_id").removeClass("textindent42");
	}
}

function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}

function de(id) {
	return document.getElementById(id);
}

function euc(i) {
	return encodeURIComponent(i);
}

function showCommonError(field,message)
{ 	
	$('.fielderror').val('');
	var container=field+"_container"; //no i18N
	$("#"+field).addClass("errorborder");
	$("#"+container+ " .fielderror").addClass("errorlabel");
	$("#"+container+ " .fielderror").html(message);
	$("#"+container+ " .fielderror").slideDown(200);
	$("#"+field).focus();
	return false;
}

function clear_allerrors()
{
	$('.fielderror').val('');
	$(".fielderror").removeClass("errorlabel");
	$(".fielderror").slideUp(100);
	$(".otp_container").removeClass("errorborder");
	$(".textbox").removeClass("errorborder");
}

function IsJsonString(str) 
{
	try {
		$.parseJSON(str);
	} catch (e) {
		return false;
	}
	return true;
}


function showTopNotification(msg)
{
	$(".alert_message").html(msg);
	$(".Alert").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Alert").css("top","-100px")},5000);
}

function showTopErrNotification(msg)
{
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Errormsg").css("top","-100px")},5000);
}


function clearCommonError(field)
{
	var container=field+"_container";//no i18N
	$("#"+field).removeClass("errorborder");
	$("#"+field).nextAll(".fielderror").slideUp(100);
	$("#"+field).nextAll(".fielderror").removeClass("errorlabel");
	$("#"+field).nextAll(".fielderror").text("");
}

function callRequestWithCallback(action, params, async, callback, method, token_required, acparams_required)
{
	if (typeof contextpath !== 'undefined') 
	{
		action = contextpath + uriPrefix + action;
	}
	acparams_required = acparams_required === undefined ? true : false;
	if(acparams_required) {
		if(action.indexOf("?") != -1)//checking if extra param is already added
		{
			action +="&"+aCParams; //no i18N
		}
		else
		{
			action += "?"+aCParams; //no i18N
		}
	}
    var objHTTP = xhr();
    objHTTP.open(method?method:'POST', action, async);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
    if(token_required)
    {
    	objHTTP.setRequestHeader('Z-Authorization',head_token);
    }
    if(async)
    {
		objHTTP.onreadystatechange=function() 
		{
		    if(objHTTP.readyState==4) 
		    {
		    	if (objHTTP.status === 0 ) 
		    	{
					handleConnectionError();
					return false;
				}
				if(callback) 
				{
				    callback(objHTTP.responseText);
				}
		    }
		};
    }
    objHTTP.send(params);
    if(!async) 
    {
    	if(callback) 
    	{
            callback(objHTTP.responseText);
        }
    }
}

function input_checking()
{
	var a=$("#login_id").val().trim();
	var check=/^(?:[0-9] ?){0,1000}[0-9]$/.test(a);
	$(".select2-selection--single").attr("tabindex","-1");//no i18N
	if(!isCountrySelected)
	{
		var reqUrl = "/accounts/public/api/locate"; // no i18n
		callRequestWithCallback(reqUrl,"",true,handleRequestCountryCode, undefined, false, false); // no i18n
		isCountrySelected = true;
	}
	if((check==true)&&(a))
	{
		try{
			$(".select_container_cntry_code").show();
			//$(".select_container_cntry_code ~ input").attr("style","text-indent:105px !important");//no i18N
			uvselect.setIntentForCntyCode("country_code_select"); //no i18N
			if(isMobile)
			{
		  		$('.select_country_code,#country_code_select').show();
		  		$("#login_id").addClass("textindent62");
		  	}
		}
		catch(err)
		{
			$('.select_country_code,#country_code_select').css("display","block");
			$("#login_id").addClass("textindent62");
		}
	}
	else if(check==false)
	{
		$('#country_code_select').hide();
		$('.select_country_code,#country_code_select,.select2').hide();
		$(".select_container_cntry_code").hide();
		uvselect.setIntentForCntyCode("country_code_select"); //no i18N
		//$(".select_container_cntry_code ~ input").attr("style","text-indent:10px");//no i18n
		if($("#login_id").hasClass("placedHolder")){
			destroyPlaceholderPattern(document.login_id_container.countryselect, $("#login_id").val(), "#login_id"); //no i18n
		}
	}
}

function accountLookup(e)
{
	e.preventDefault();
	if($("#captcha_container").is(":hidden"))
	{
		hip_required=false;
		var LOGIN_ID = $("#login_id").val().trim();
		if(!isValid(LOGIN_ID)) 
		{
			showCommonError("login_id",I18N.get("IAM.ERROR.EMPTY.FIELD"));//no i18n
			return false;
		}
		var ID=LOGIN_ID.indexOf("-")!=-1?LOGIN_ID.split('-')[1]:LOGIN_ID;
		if(/^(?:[0-9] ?){2,1000}[0-9]$/.test(ID) && !isPhoneNumber(ID))
		{
			showCommonError("login_id",I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));//no i18n
			return false;
		}
		if((!isUserName(LOGIN_ID) && !isEmailId(LOGIN_ID))	&&	(!isPhoneNumber(LOGIN_ID.split("-")[1]?LOGIN_ID.split("-")[1]:LOGIN_ID.split("-")[0]))) {
			showCommonError("login_id",I18N.get("IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER"));//no i18n
			return false;
		}
		
		$("#nextbtn span").addClass("zeroheight");
		$("#nextbtn").addClass('changeloadbtn');
		$("#nextbtn").attr("disabled", true);
		LOGIN_ID = ( isPhoneNumber(LOGIN_ID) ) ? $( "#country_code_select" ).val().split("+")[1]+'-'+LOGIN_ID : LOGIN_ID;
		LOGIN_ID = isPhoneNumber(LOGIN_ID.split('-')[1]) ? LOGIN_ID.split('-')[0].trim() + "-" + LOGIN_ID.split('-')[1].trim() : LOGIN_ID;
		var lookup_url = recoveryUri + "/v1/lookup/"+LOGIN_ID+"?mode=resetip"; //no i18N
		callRequestWithCallback(lookup_url, "" ,true, handleLookupDetails);//No I18N
	}
	else
	{
		var captchavalue = $("#captcha").val();
		if(!isValid(captchavalue)) 
		{
			showCommonError("captcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"));//no i18n
			$("#captcha_container #captcha").focus();
			return false;
		}
		if( /[^a-zA-Z0-9\-\/]/.test( captchavalue ) || captchavalue.length<6) {
			changeHip();
			showCommonError("captcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.INVALID"));//no i18n
			return false;
		}
		$("#nextbtn span").addClass("zeroheight");
		$("#nextbtn").addClass('changeloadbtn');
		$("#nextbtn").attr("disabled", true);
		var captcha_verify_url = recoveryUri + "/v1/lookup/"+login_id+"/captcha"; //no i18N
		var params = "captcha=" + captchavalue + "&cdigest=" + cdigest + "&token=" + token; //no i18N
		callRequestWithCallback(captcha_verify_url, params ,true, handleRecoveryDetails);
	}

	return false;
}

function fetchLookupDetails(loginID)
{
	var lookup_url;
	if(digest_id.length>0){		
		lookup_url = recoveryUri + "/v1/lookup/"+digest_id+"?mode=digest"; //no i18N
	}
	else{
		$("#login_id").val(loginID)
		lookup_url = recoveryUri + "/v1/lookup/"+loginID+"?mode=resetip"; //no i18N
	}
	callRequestWithCallback(lookup_url, "" ,true, handleLookupDetails);//No I18N
	return false;
}



function handleLookupDetails(resp)
{
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	$(".recovery_container").css("visibility","visible");
	hideCommonLoader();
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			zuid = jsonStr.lookup.identifier;
			if(digest_id.length>0	&&	jsonStr.lookup.token==undefined)// if new token is preset then its a new request
			{
				head_token = jsonStr.lookup.jwt;
				serviceName = jsonStr.lookup.service_name;
				serviceUrl = jsonStr.lookup.service_url;
				aCParams = "servicename=" + euc(serviceName) +"&serviceurl="+euc(serviceUrl);	//no i18n
				if(jsonStr.lookup.org_details!=undefined)
				{
					org_name=jsonStr.lookup.org_details.org_name;
					org_contact=jsonStr.lookup.org_details.org_contact;
				}
				ipRestrictedForOrg=jsonStr.lookup.orgIp=="true"?true:false;
				ipPersonalRestriction=jsonStr.lookup.userIp=="true"?true:false;
				if(jsonStr.lookup.modes)
				{
					mfa_modes = jsonStr.lookup.modes;
					initialize_MFAModes();
				}
				else
				{
					show_ip_reset();
				}
				update_user_info(jsonStr.lookup.loginid);
			}
			else{				
				login_id=jsonStr.lookup.loginid;
				token = jsonStr.lookup.token;
				changeHip("captcha_img","captcha");//no i18n
				$("#captcha_container").show();
				$("#lookup_div .head_info").hide();
				update_user_info();
				$("#login_id_container").hide();
				$("#captcha_container #captcha").focus();
				$("#login_id").attr("disabled", true);
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("login_id",jsonStr.localized_message);//no i18n
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(errorCode == "U401" && digest_id == ""){
				var LOGIN_ID = $("#login_id").val().trim();
				var ID=LOGIN_ID.indexOf("-")!=-1?LOGIN_ID.split('-')[1]:LOGIN_ID;
				if(isPhoneNumber(ID)){
					errorMessage = I18N.get("IAM.AC.RECOVER.LOOKUP.ERROR.MOBILE");					
				}
				else{
					errorMessage = I18N.get("IAM.AC.RECOVER.LOOKUP.ERROR.EMAIL.OR.USERNAME");
				}
			}
			if(errorCode === "RIP102")//no i18N
			{
				errorMessage =jsonStr.errors[0].message;
			}
			if(errorCode === "U400")//no i18N
			{
		    	var deploymentUrl = jsonStr.data.redirect_uri;
		    	var loginurl = deploymentUrl + recoveryUri + "?"; //no i18n
		    	if(serviceName){
		    		loginurl += "&servicename="+euc(serviceName);	//no i18n
		    	}
		    	if(serviceUrl){   //todo need to handle it properly for cross dc 
		    		loginurl += "&serviceurl="+euc(serviceUrl);		//no i18n
		    	}
		    	if(signup_url){
		    		loginurl += "&signupurl="+euc(signup_url);		//no i18n
		    	}
		    	
				login_id = jsonStr.data.loginid ;
				if(login_id && (isEmailId(login_id) || isUserName(login_id)) || isPhoneNumber(login_id.split('-')[1]))
				{
					var oldForm = document.getElementById("recoveryredirection");
					if(oldForm) {
						document.documentElement.removeChild(oldForm);
					}
					var form = document.createElement("form");
					form.setAttribute("id", "recoveryredirection");
					form.setAttribute("method", "POST");
				    form.setAttribute("action", loginurl);
				    form.setAttribute("target", "_self");
					
					var hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "LOGIN_ID");
					hiddenField.setAttribute("value", login_id ); 
					form.appendChild(hiddenField);
			        
					
				   	document.documentElement.appendChild(form);
				  	form.submit();
				  	return false;
				}
			}
			if(errorCode == "DOMAIN500") //for domain verofocation
			{
				$(".recover_sections,.service_logo").hide();
				$(".error_header_container .error_header").hide();
				$(".error_header_container .access_denied").show();
				$(".error_portion .error_desc").addClass("red_text");
				$(".error_portion .error_desc").html(errorMessage);
				$(".error_portion .domain_wait_warn").show();
				$(".error_portion .bottom_option").hide();
				$(".error_portion #refresh").show();
				$(".error_portion").show();
			}
			else if(errorCode == "IN108")
			{
				hip_required=true;
				login_id=$('#login_id').val();
				token=JSON.parse(resp).token;
				$(".user_info > .menutext").text(login_id);
				$(".user_info").show();
				changeHip("captcha_img","captcha");//No i18N
				$("#captcha_container").show();
				$("#lookup_div .head_info").hide();
				$("#login_id_container").hide();
				$("#captcha_container #captcha").focus();
				$("#login_id").attr("disabled", true);
			}

			else if(digest_id != ""){
				$(".recover_sections,.service_logo").hide();
				$(".error_header_container .error_header").hide();
				var errArray = ["U401","U402","U403","IN101","IN123"];	//no i18n
				if(errArray.indexOf(errorCode) != -1){
					$(".error_header_container .error_"+errorCode).show();
				}
				else{
					$(".error_header_container .access_denied").show();
				}
				$(".error_portion .error_desc").html(errorMessage);
				$(".error_portion .bottom_option").hide();
				$(".error_portion #try_again").show();
				$(".error_portion").show();
			}
			else
			{
				showCommonError("login_id",errorMessage);//no i18n
			}
		}
	}
	else 
	{
		showCommonError("login_id",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;
}


function changeHip(cImg,cId) 
{
	$(".reloadcaptcha").addClass("load_captcha_btn");
	cId = isValid(cId) ? cId : "captcha"; //no i18N
	var captchaReqUrl = '/webclient/v1/captcha';//no i18n
	callRequestWithCallback(captchaReqUrl, '{"captcha":{"digest":"'+cdigest+'","usecase":"recovery"}}', false, handleChangeHip, undefined, false, false); //No I18N
	showHip(cdigest, cImg);
	$("#captcha_container #captcha").focus();
    de(cId).value = ''; //No I18N
	setTimeout(function(){
		$(".reloadcaptcha").removeClass("load_captcha_btn");
	}, 500);
}


function showHip(cdigest, cImg) 
{
	 var captcha_resp = isValid(cdigest) ? doGet(uriPrefix + '/webclient/v1/captcha/'+cdigest) : "";//no i18n
	 if(IsJsonString(captcha_resp)) {
		 captcha_resp = JSON.parse(captcha_resp);
	 }
	 var captchimgsrc = captcha_resp.cause==="throttles_limit_exceeded" || !isValid(cdigest) ? "../images/hiperror.gif": captcha_resp.captcha.image_bytes;//no i18N
	 cImg = isValid(cImg) ? cImg : "captcha_img"; //No I18N
	 de("captcha").value = '';//no i18n
	 var hipRow = de(cImg); 
	 var captchaImgEle = document.createElement("img");
	 captchaImgEle.setAttribute("name", "hipImg");
	 captchaImgEle.setAttribute("id", "hip");
	 $('.reloadcaptcha').attr("title", I18N.get("IAM.NEW.SIGNIN.TITLE.RANDOM"));
	 captchaImgEle.setAttribute("align", "left");
	 captchaImgEle.setAttribute("src", captchimgsrc);
	 if(!isMobile){ $(captchaImgEle).css("mix-blend-mode","multiply");}//no i18N
	 $(hipRow).html(captchaImgEle);
}

function handleChangeHip(resp)
{
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if(jsonStr.cause==="throttles_limit_exceeded"){
			cdigest = '';
			showHip(cdigest);
//			showCaptcha(I18N.get("IAM.NEXT"),false);;//no i18N
			return false;
		}
		cdigest = jsonStr.digest;
	}
	return false;
}

function lookToForgotPassword(jsonStr,statusCode)
{
	$("#login_id").val("");
	$("#captcha").val("");
	
	head_token=jsonStr.captchaverificationauth[0].jwt;
	$("#lookup_div").hide();
	recovery_modes=jsonStr.captchaverificationauth[0].modes;
	if(jsonStr.captchaverificationauth[0].org_details!=undefined)
	{
		org_name=jsonStr.captchaverificationauth[0].org_details.org_name;
		org_contact=jsonStr.captchaverificationauth[0].org_details.org_contact;
	}
	ipRestrictedForOrg=jsonStr.captchaverificationauth[0].orgIp!=undefined?true:false;
	ipPersonalRestriction=jsonStr.captchaverificationauth[0].userIp!=undefined?true:false;
	if(jsonStr.captchaverificationauth[0].modes.allowed_modes.indexOf("password")!=-1) //password exists for this account
	{
		$("#Last_password_div").show();
		$(".show_hide_password").removeClass("icon-show");
		$("#last_password").attr("type","password").focus();//no i18n
		if(jsonStr.captchaverificationauth[0].modes.allowed_modes.length==1)//only last password mode
		{
			$("#Last_password_div #dont_remember").html(I18N.get("IAM.NEW.SIGNIN.CONTACT.SUPPORT"));
		}
		else
		{
			$("#Last_password_div #dont_remember").html(I18N.get("IAM.AC.DONT.REMEMBER"));	
		}
	}
	else //initialize other modes
	{
		initialize_recoveryModes()
		
	}
}

function handleRecoveryDetails(resp)
{
	$("#nextbtn span").removeClass("zeroheight");
	$("#nextbtn").removeClass("changeloadbtn");
	$("#nextbtn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr =  JSON.parse(resp);
		var statusCode = jsonStr.status_code;

		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299	&&(jsonStr.captchaverificationauth!=undefined)) 
		{
			if(hip_required){
				zuid=jsonStr.captchaverificationauth[0].identifier;
				hip_required=false;
			}
			lookToForgotPassword(jsonStr,statusCode);
		}
		else if(jsonStr.cause==="throttles_limit_exceeded")
		{
			$("#captcha").blur();
			$("#captcha_container").addClass("margin_for_captcha_errors");
			$("#captcha_container + .captchafielderror").addClass("commonErrorlabelForCaptcha").html(jsonStr.localized_message).slideDown(200);
			return false;
		}
		else if(jsonStr.errors[0].code == 'U400'){//No I18Nn //dc switch
			handleLookupDetails(resp);
		}
		else if(jsonStr.errors[0].code == 'U401'){ //No I18N //user not exists
			change_user(jsonStr.localized_message);
			$("#login_id_container .fielderror").html(jsonStr.localized_message).addClass("errorlabel").show();
		}
		else if(jsonStr.errors[0].code == 'IN107'){ //invalid captcha
			$('.reloadcaptcha').click();
			showCommonError("captcha",jsonStr.localized_message);//no i18n
		}
		else
		{
			//policy errors
			$("#captcha").blur();
			$("#captcha_container").addClass("margin_for_captcha_errors");
			if(jsonStr.errors[0].code == 'RIP101')
			{
				//todo need to add chnage for login id prefilling
				$("#captcha_container + .captchafielderror").addClass("commonErrorlabelForCaptcha").html(jsonStr.localized_message).slideDown(200);
				return false;
			}
			$("#captcha_container + .captchafielderror").addClass("commonErrorlabelForCaptcha").html(jsonStr.localized_message).slideDown(200);
		}
	}
	else 
	{
		showCommonError("captcha",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;
	
}

function removeCaptchaError(){
	//only for captcha block outside errors
	$("#captcha_container").removeClass("margin_for_captcha_errors");
	$("#captcha_container + .captchafielderror").removeClass("commonErrorlabelForCaptcha").text("").slideUp(200);
}



function resendotp_checking(id)
{
	var resendtiming = 60;
	clearInterval(resendTimer);
	$('#'+id+' .resendotp').addClass('nonclickelem');
	$('#'+id+' .resendotp span').text(resendtiming);
	var attemptContent = resendcheck == 2 ? 'IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2' : resendcheck == 1 ? 'IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1' : resendcheck == 0 ? 'IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS' : "";
	if(resendcheck <= 2 && resendcheck>=0){
		$('#'+id+' .resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
		if(resendcheck == 0){$('#'+id+' .resendotp').html(I18N.get('IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS'));return false;}// no i18n
	}else{
		$('#'+id+' .resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
	}
	resendTimer = setInterval(function()
	{
		resendtiming--;
		$('#'+id+' .resendotp span').text(resendtiming);
		if(resendtiming === 0) 
		{
			clearInterval(resendTimer);
			$('#'+id+' .resendotp').html(I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
			$('#'+id+' .resendotp').removeClass('nonclickelem');
		}
	},1000);
}



function initialize_recoveryModes()
{
	$(".recover_sections").hide();
	$(".only_two_recmodes").hide();
	$(".rec_modes_other_options").hide();
	$(".rec_modes_contact_support").show();
	
	is_recovery_extra_modes=false;
	var only_usernameoption=false;
	if(recovery_modes.allowed_modes.indexOf("passkey") != -1)
	{
		$("#recover_via_passkey").show();
		is_recovery_extra_modes=true;
	}
	else
	{
		$("#recover_via_passkey").hide();
	}
	if(recovery_modes.allowed_modes.indexOf("lookup_id") != -1)
	{
		if( recovery_modes.allowed_modes.indexOf("passkey") == -1 )//if passkey is not there
		{
			$("#recovery_usernamescreen_bk").css("display","block");
			$("#recovery_usernamescreen_bk").attr("onclick","show_confirm_username_screen()");
			if(!is_recovery_extra_modes)
			{
				is_recovery_extra_modes=false;
				only_usernameoption=true;
			}
		}
		else // usename option will be removed and the lookup will be added straight email or otp since passkey is avaible
		{		
			$("#recovery_usernamescreen_bk").hide();
			if(!is_recovery_extra_modes)
			{
				is_recovery_extra_modes=false;
			}
			if(recovery_modes.lookup_id.data[0].email)//check if the lookup was done with email
			{
				recovery_modes.lookup_id.data[0].isLookupId = true;
				if(recovery_modes.email == undefined)
				{
					recovery_modes.allowed_modes.push("email");
					recovery_modes.email={};
					recovery_modes.email.data=[];
					recovery_modes.email.count=0;
				}
				recovery_modes.email.data.push(recovery_modes.lookup_id.data[0]);
				recovery_modes.email.count=recovery_modes.email.count+1;
			}
			else if(recovery_modes.lookup_id.data[0].r_mobile)
			{
				recovery_modes.lookup_id.data[0].isLookupId = true;
				recovery_modes.lookup_id.data[0].r_mobile = $("#recovery_user_info .menutext")[0].innerText;	//get from the change usr option from the top
				if(recovery_modes.otp == undefined)
				{
					recovery_modes.allowed_modes.push("otp");
					recovery_modes.otp={};
					recovery_modes.otp.data=[];
					recovery_modes.otp.count=0;
				}
				recovery_modes.otp.data.push(recovery_modes.lookup_id.data[0]);
				recovery_modes.otp.count=recovery_modes.otp.count+1;
			}
			delete recovery_modes.lookup_id;
			recovery_modes.allowed_modes.splice(recovery_modes.allowed_modes.indexOf("lookup_id"),1);
		}
	}	
	else 
	{
		$("#recovery_usernamescreen_bk").hide();
	}

	if(recovery_modes.allowed_modes.indexOf("otp") != -1)
	{
		$("#recover_via_mobile").show();
		is_recovery_extra_modes=true;
	}
	else
	{
		$("#recover_via_mobile").hide();
	}
	if(recovery_modes.allowed_modes.indexOf("email") != -1)
	{
		$("#recover_via_email").show();
		is_recovery_extra_modes=true;
	}
	else
	{
		$("#recover_via_email").hide();
	}
	
	if(recovery_modes.allowed_modes.indexOf("mzadevice") != -1)
	{
		$("#recover_via_device").show();
		is_recovery_extra_modes=true;
	}
	else
	{
		$("#recover_via_device").hide();
	}
	
	if(recovery_modes.allowed_modes.indexOf("domain") != -1)
	{
		$("#recover_via_domain").show();
		is_recovery_extra_modes=true;
	}
	else
	{
		$("#recover_via_domain").hide();
	}
	
	
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	
	if(is_recovery_extra_modes	||	(!is_recovery_extra_modes	&&	only_usernameoption)	)
	{
		$("#recovery_usernamescreen_bk").css("display","block");
		$(".support_bk_button").show();
		$(".support_bk_button").attr("onclick","show_other_options()");
		if(modes.length==1)
		{
			$(".only_two_recmodes").hide();
			$(".rec_modes_other_options").hide();
			$(".rec_modes_contact_support").show();
			if(only_usernameoption)
			{
				show_confirm_username_screen();
			}
			else if(modes[0]=="email")
			{
				show_recEmailScreen();
			}
			else if(modes[0]=="otp")
			{
				show_recMobScreen();
			}
			else if(modes[0]=="mzadevice")
			{
				show_recDeviceScreen();
			}
			else if(modes[0]=="domain")
			{
				show_recDomainScreen();
			}
		}
		else
		{
			$(".rec_modes_other_options").show();
			$(".rec_modes_contact_support").hide();
			$(".only_two_recmodes").show();
			if(modes.indexOf("lookup_id") != -1 && modes.indexOf("passkey") == -1) //lookup without passkey 
			{
				show_confirm_username_screen();
				$("#recovery_usernamescreen_bk").show();
			}
			else // show other options
			{
				$("#recovery_usernamescreen_bk").hide();
				$(".recover_sections").hide();
				$("#other_options_div").show();
			}
		}
	}
	else
	{
		$(".rec_modes_other_options").hide();
		$(".support_bk_button").hide();
		show_contactsupport(true);
	}
	
	return;
}

function show_other_options()
{
	first_otp_sent=false;
	clear_allerrors();
	$(".rec_modes_other_options").hide();
	$(".rec_modes_contact_support").hide();
	$("rec_modes_other_options").attr("onclick"," show_other_options()");	
	clearInterval(_time);
	var modes=recovery_modes.allowed_modes;
	var user_name_flag=false;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("lookup_id")!=-1)
	{
		$("#recovery_usernamescreen_bk").show();
		modes=modes.filter(function(e){ return e !== 'lookup_id'});
		user_name_flag=true;
	}
	else
	{
		$("#recovery_usernamescreen_bk").hide();
	}
	
	if(modes.length==1	&& user_name_flag)	// username and only one more option present
	{
		$(".only_two_recmodes").attr("onclick","show_confirm_username_screen()");
		$(".only_two_recmodes").show();
		$("#username_div .rec_modes_other_options").show();
		if(modes[0]=="email")
		{
			$("#email_confirm_div .rec_modes_other_options").hide();
			$("#email_confirm_div .rec_modes_contact_support").show();
			show_recEmailScreen();
		}
		else if(modes[0]=="otp")
		{
			$("#mobile_confirm_div .rec_modes_other_options").hide();
			$("#mobile_confirm_div .rec_modes_contact_support").show();
			show_recMobScreen();
		}
		else if(modes[0]=="mzadevice")
		{
			$("#recovery_device_div .rec_modes_other_options").hide();
			$("#recovery_device_div .rec_modes_contact_support").show();
			show_recDeviceScreen();
		}
		else if(modes[0]=="domain")
		{
			$("#recovery_domian_div .rec_modes_other_options").hide();
			$("#recovery_domian_div .rec_modes_contact_support").show();
			show_recDomainScreen();
		}
	}
	else if(modes.length<1	&& user_name_flag)	//only username option and from contact support page
	{
		$(".rec_modes_contact_support").show();
		$(".only_two_recmodes").hide();
		$("#email_confirm_div .only_two_recmodes").show();
		$("#mobile_confirm_div .only_two_recmodes").show();
		show_confirm_username_screen();
	}
	else if(modes.length<1)	//unhandled extra case
	{
		$(".only_two_recmodes").hide();
		show_contactsupport();
	}
	else	//show other options div as we have atleast 2 options excluding username
	{
		$(".rec_modes_other_options").show();
		$(".rec_modes_contact_support").hide();
		$(".only_two_recmodes").hide();
		$(".recover_sections").hide();
		$("#other_options_div").show();
	}
}




function show_confirm_username_screen()
{
	if(recovery_modes.lookup_id.data[0].email!=undefined)
	{
		$("#username_div .head_info").html(I18N.get("IAM.AC.SELECT.USERNAME.EMAIL.DESCRIPTION"));
	}
	else
	{
		$("#username_div .head_info").html(I18N.get("IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION"));
	}
	$(".recover_sections").hide();
	$("#username_div").show();
}


function call_recusernameScreen()
{
	if($("#confirm_otp_container").is(":visible")){
		$("#confirm_otp_container #otp_resend").hide();
		$("#confirm_otp_container #otp_sent").show().addClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SENDING"));
	}
	else{
		$("#username_select_action span").removeClass("zeroheight");
		$("#username_select_action").removeClass("changeloadbtn");
		$("#username_select_action").attr("disabled", false);
	}
	if(recovery_modes.lookup_id.data[0].email!=undefined)
	{
		var email_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mail/"+recovery_modes.lookup_id.data[0].e_email; //no i18N
		var jsonData = {'emailrecoveryauth':{'email_id':recovery_modes.lookup_id.data[0].email }};//no i18n
		
		callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleUsernameConfirm,undefined,true);
		return false;
	}
	else
	{
		var mobile_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mobile/"+recovery_modes.lookup_id.data[0].e_mobile; //no i18N
		var jsonData = {'mobilerecoveryauth':{'mobile':recovery_modes.lookup_id.data[0].r_mobile }};//no i18n
		
		callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleUsernameConfirm,undefined,true);
		return false;
	}
}

function handleUsernameConfirm(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var encrypt,decrypt;
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name=jsonStr.resource_name;
		if((primary_factor_otp_threshold >= 1 && resource_name == 'mobilerecoveryauth') || resource_name=="emailrecoveryauth"){
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
			{
				if(resource_name=="emailrecoveryauth")
				{
					encrypt= recovery_modes.lookup_id.data[0].e_email;
					decrypt=recovery_modes.lookup_id.data[0].email;
					$("#confirm_otp_div .head_info").html(formatMessage(I18N.get("IAM.NEW.SIGNUP.EMAIL.VERIFY.DESC")));
					resendcheck = undefined;
				}
				else
				{
					encrypt= recovery_modes.lookup_id.data[0].e_mobile;
					decrypt=recovery_modes.lookup_id.data[0].r_mobile;
					$("#confirm_otp_div .head_info").html(formatMessage(I18N.get("IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC")));
					primary_factor_otp_threshold--;
					resendcheck = primary_factor_otp_threshold;
				}
				
				$("#confirm_otp_div #otp_resend").attr("onclick","call_recusernameScreen()");
				resendotp_checking("confirm_otp_div");//no i18n
				setTimeout(function(){
					$("#confirm_otp_container #otp_sent").removeClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SUCCESS"));
				},500);
				setTimeout(function(){
					$("#confirm_otp_container #otp_resend").show();
					$("#confirm_otp_container #otp_sent").hide();
				},2000);
				var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) :  formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
				showTopNotification(formatMessage(I18N.get(otpsentmsg)));
				first_otp_sent=true;
				$("#otp_confirm_submit").attr("onclick","username_confimation_action()");
				show_recusernameScreen(); //entering one time pwd section
			}
			else
			{
				$("#confirm_otp_container #otp_resend").show();
				$("#confirm_otp_container #otp_sent").hide();
				if(jsonStr.cause==="throttles_limit_exceeded")
				{
					showTopErrNotification(jsonStr.localized_message);
					return false
				}
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				show_other_options();
				showTopErrNotification(errorMessage);
				return false
			}
		}else{
			showTopErrNotification(I18N.get('IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS'));
		}
		
	}
	else 
	{
		$("#confirm_otp_container #otp_resend").show();
		$("#confirm_otp_container #otp_sent").hide();
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false
	}
	return false;
}


function show_recusernameScreen(from_screen)
{
	$(".recover_sections").hide();
	$("#confirm_otp_div").show();
	
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	$("#confirm_otp_div .only_two_recmodes").hide();
	if(from_screen==undefined)
	{
		
		if(is_recovery_extra_modes	||(!is_recovery_extra_modes	&&	recovery_modes.allowed_modes.indexOf("lookup_id")))
		{
			$("#recovery_usernamescreen_bk").css("display","block"); 
		}  
		else
		{
			$("#recovery_usernamescreen_bk").hide();
		}
		if(modes.indexOf("lookup_id")!=-1)
		{
			modes=modes.filter(function(e){ return e !== "lookup_id"});
		}
		if(modes.length==0)
		{
			$("#confirm_otp_div .rec_modes_other_options").hide();
		}
		else
		{
			$("#confirm_otp_div .rec_modes_other_options").attr("onclick"," show_other_options()");
			$("#confirm_otp_div .rec_modes_other_options").show();
		}

	}
	else if(from_screen=="otp")//from otp screen for confirminng the mobile otp
	{
		$("#confirm_otp_div .only_two_recmodes").show();
		$("#confirm_otp_div .only_two_recmodes").attr("onclick",'$("#mobile_confirm_div #select_reocvery_mobile").hide();$("#mobile_confirm_div #confirm_reocvery_mobile").show();$(".recover_sections").hide();$("#mobile_confirm_div").show();');
		$("#confirm_otp_div .rec_modes_other_options").show();
		if(modes.indexOf("otp")!=-1)
		{
			modes=modes.filter(function(e){ return e !== "otp"});
		}
		if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#confirm_otp_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#confirm_otp_div .only_two_recmodes").hide();
			$("#confirm_otp_div .rec_modes_other_options").hide();
		}
		else
		{
			$("#confirm_otp_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}
	else if(from_screen=="email") //from otp screen for confirminng the email otp
	{
		$("#confirm_otp_div .only_two_recmodes").show();
		$("#confirm_otp_div .only_two_recmodes").attr("onclick",'$("#email_confirm_div #select_reocvery_email").hide();$("#email_confirm_div #confirm_reocvery_emaile").show();$(".recover_sections").hide();$("#email_confirm_div").show();');
		$("#confirm_otp_div .rec_modes_other_options").show();
		if(modes.indexOf("email")!=-1)
		{
			modes=modes.filter(function(e){ return e !== "email"});
		}
		if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#confirm_otp_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#confirm_otp_div .only_two_recmodes").hide();
			$("#confirm_otp_div .rec_modes_other_options").hide();
		}
		else
		{
			$("#confirm_otp_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}

	splitField.createElement('confirm_otp',{
		"splitCount":otp_length,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$("#confirm_otp .splitedText").attr("onkeypress","clearCommonError('confirm_otp')");
	$("#confirm_otp").click();
}

function username_confimation_action()
{
	var otp_confirm = $("#confirm_otp_full_value").val();
	if(!isValid(otp_confirm)) 
	{
		showCommonError("confirm_otp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if(!isValidCode(otp_confirm)) 
	{
		showCommonError("confirm_otp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( otp_confirm ) ) {
		showCommonError("confirm_otp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	$("#otp_confirm_submit span").addClass("zeroheight");
	$("#otp_confirm_submit").addClass("changeloadbtn");
	$("#otp_confirm_submit").attr("disabled", true);
	
	if(recovery_modes.lookup_id.data[0].email!=undefined)
	{
		var email_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mail/"+recovery_modes.lookup_id.data[0].e_email; //no i18N
		var jsonData = {'emailrecoveryauth':{'code':otp_confirm , "mdigest":mdigest }};//no i18n
		
		callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
	}
	else
	{
		var mobile_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mobile/"+recovery_modes.lookup_id.data[0].e_mobile; //no i18N
		var jsonData = {'mobilerecoveryauth':{'code':otp_confirm}};//no i18n
		
		callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
	}

	return false;
}

// first factor email

function show_recEmailScreen()
{
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("email")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "email"});
	}
	if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))//ONLY USERNAME OPTION IS AVAILABLE
	{
		$("#email_confirm_div .rec_modes_contact_support").show();
		$("#email_confirm_div .rec_modes_other_options").hide();
		$("#email_confirm_div .only_two_recmodes").show();
		$("#email_confirm_div .only_two_recmodes").attr("onclick","show_confirm_username_screen()");
	}
	else if(modes.length==0)//only email otpion
	{
		$("#email_confirm_div .rec_modes_contact_support").show();
		$("#email_confirm_div .rec_modes_other_options").hide();
		$("#email_confirm_div .only_two_recmodes").hide();
	}
	else
	{
		$("#email_confirm_div .rec_modes_contact_support").hide();
		$("#email_confirm_div .rec_modes_other_options").show();
		$("#email_confirm_div .only_two_recmodes").attr("onclick","show_other_options()");
		$("#email_confirm_div .rec_modes_other_options").hide();
		$("#email_confirm_div .only_two_recmodes").show();
	}
	
	
	var rec_emails=recovery_modes.email;
	if(rec_emails.count==1)
	{
		if(rec_emails.data[0].isLookupId) // if it was from lookup
		{
			show_recovery_email_confirmationscreen(rec_emails.data[0],true);
		}
		else
		{
			show_recovery_email_confirmationscreen(rec_emails.data[0]);
		}

	}
	else
	{
		$("#select_reocvery_email .head_info").html(formatMessage(I18N.get("IAM.IP.RECOVER.EMAIL_ID.DESCRIPTION.MULTI"),rec_emails.count.toString()));
		$("#select_reocvery_email .fieldcontainer").html("");
		
		var email_verify_template=$(".empty_email_template").html();;
		for(var i=0;i<rec_emails.count;i++)
		{
			$("#select_reocvery_email .fieldcontainer").append(email_verify_template);
			$("#select_reocvery_email .fieldcontainer #recovery_email").attr("id","recovery_email"+i);
			$("#select_reocvery_email .fieldcontainer #recovery_email"+i+" .option_title_try").html(rec_emails.data[i].email)
			if(rec_emails.data[i].isLookupId) // if it was from lookup
			{
				$("#select_reocvery_email .fieldcontainer #recovery_email"+i).attr("onclick","show_recovery_email_confirmationscreen("+JSON.stringify(rec_emails.data[i])+",true);");	//no i18N
			}
			else
			{				
				$("#select_reocvery_email .fieldcontainer #recovery_email"+i).attr("onclick","show_recovery_email_confirmationscreen("+JSON.stringify(rec_emails.data[i])+");");
			}
		}
		
		$("#email_confirm_div #select_reocvery_email").show();
		$("#email_confirm_div #confirm_reocvery_email").hide();
		$(".recover_sections").hide();
		$("#email_confirm_div").show();

	}
	
}


function show_recovery_email_confirmationscreen(email_data,isLookupId)
{
	clear_allerrors();
	$("#email_confirm_div .only_two_recmodes").show();
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("email")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "email"});
	}
	if(recovery_modes.email.count==1)
	{
		if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#email_confirm_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#email_confirm_div .only_two_recmodes").hide();
		}
		else
		{
			$("#email_confirm_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}
	else
	{
		$("#email_confirm_div .only_two_recmodes").attr("onclick","show_recEmailScreen()");
		$("#email_confirm_div .rec_modes_contact_support").hide();
		$("#email_confirm_div .rec_modes_other_options").show();
		if(modes.length==1 	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#email_confirm_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#email_confirm_div .rec_modes_contact_support").show();
			$("#email_confirm_div .rec_modes_other_options").hide();
		}
		else
		{
			$("#email_confirm_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}
	var email_digest= email_data.e_email;
	var enc_email=email_data.email;
	
	$("#email_confirm").val("");
	$("#confirm_reocvery_email .head_info").html(formatMessage(I18N.get("IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION"),enc_email.toString()));
	$("#confirm_reocvery_email .fieldcontainer #selected_encrypt_email").val(email_digest);
	
	$("#email_confirm_div #select_reocvery_email").hide();
	$(".recover_sections").hide();
	if(isLookupId) // if lookup skip the confimation page as he already entered it
	{
		$("#email_confirm").val(enc_email);
		email_confirmation(isLookupId);
		
	}
	else
	{
		$("#email_confirm_div,#email_confirm_div #confirm_reocvery_email").show();
	}
	$("#email_confirm").focus()

	
}

function email_confirmation(isLookupId)
{
	
	var email_confirm = $("#email_confirm").val().trim();
	if(!isValid(email_confirm)	||	!isEmailId(email_confirm))
	{
		showCommonError("email_confirm",I18N.get("IAM.AC.CONFIRM.EMAIL.VALID"));//no i18n
		return false;
	}
	$("#emailconfirm_action span").addClass("zeroheight");
	$("#emailconfirm_action").addClass("changeloadbtn");
	$("#emailconfirm_action").attr("disabled", true);
	
	var email_enc=$("#confirm_reocvery_email .fieldcontainer #selected_encrypt_email").val();
	
	var email_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mail/"+email_enc; //no i18N
	var jsonData = {'emailrecoveryauth':{'email_id':email_confirm }};//no i18n
	
	callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,function(resp){
		handleEmailConfirm(resp,isLookupId);
	},undefined,true);

	return false;
}

function handleEmailConfirm(resp,isLookupId)
{
	$("#emailconfirm_action span").removeClass("zeroheight");
	$("#emailconfirm_action").removeClass("changeloadbtn");
	$("#emailconfirm_action").attr("disabled", false);
	
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			var decrypt=$("#email_confirm").val();
			
			$("#confirm_otp_div .head_info").html(formatMessage(I18N.get("IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION"),decrypt));
			
			$("#confirm_otp_div #otp_resend").show();
			resendotp_checking("confirm_otp_div");//no i18n
			var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) : formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
			showTopNotification(formatMessage(I18N.get(otpsentmsg)));
			first_otp_sent=true;
			$("#otp_confirm_submit").attr("onclick","rec_email_confimation_action()");
			show_recusernameScreen("email");//no i18n
			if(isLookupId)
			{
				$("#confirm_otp_div .only_two_recmodes").attr("onclick",recovery_modes.email.count==1?'show_other_options()':'show_recEmailScreen()');
				$("#confirm_otp_div #otp_resend").attr("onclick","email_confirmation(true)");
			}
			else
			{
				//$("#confirm_otp_div .only_two_recmodes").attr("onclick",'$("#email_confirm_div #select_reocvery_email").hide();$("#email_confirm_div #confirm_reocvery_emaile").show();$(".recover_sections").hide();$("#email_confirm_div").show();');
				$("#confirm_otp_div #otp_resend").attr("onclick","email_confirmation()");
			}

		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("email_confirm",jsonStr.localized_message);//no i18n
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("email_confirm",errorMessage);//no i18n
			return false;
		}
	}
		
	else 
	{
		showCommonError("email_confirm",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;

}

function rec_email_confimation_action()
{
	var otp_confirm = $("#confirm_otp_full_value").val();
	if(!isValid(otp_confirm)) 
	{
		showCommonError("confirm_otp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if(!isValidCode(otp_confirm))
	{
		showCommonError("confirm_otp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( otp_confirm ) ) {
		showCommonError("confirm_otp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	$("#otp_confirm_submit span").addClass("zeroheight");
	$("#otp_confirm_submit").addClass("changeloadbtn");
	$("#otp_confirm_submit").attr("disabled", true);
	
	var e_email=$("#confirm_reocvery_email .fieldcontainer #selected_encrypt_email").val();
	
	var email_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mail/"+e_email; //no i18N
	var jsonData = {'emailrecoveryauth':{'code':otp_confirm}};//no i18n
	
	callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
}

//first factor mobile

function show_recMobScreen()
{
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("otp")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "otp"});
	}
	if(modes.length==1 	&&	(modes.indexOf("lookup_id")!=-1))//ONLY USERNAME OPTION IS AVAILABLE
	{
		$("#mobile_confirm_div .rec_modes_contact_support").show();
		$("#mobile_confirm_div .rec_modes_other_options").hide();
		$("#mobile_confirm_div .only_two_recmodes").attr("onclick","show_confirm_username_screen()");
		$("#mobile_confirm_div .only_two_recmodes").show();
	}
	else if(modes.length==0)//only email otpion
	{
		$("#mobile_confirm_div .rec_modes_contact_support").show();
		$("#mobile_confirm_div .rec_modes_other_options").hide();
		$("#mobile_confirm_div .only_two_recmodes").hide();
	}
	else
	{
		$("#mobile_confirm_div .rec_modes_contact_support").hide();
		$("#mobile_confirm_div .rec_modes_other_options").show();
		$("#mobile_confirm_div .only_two_recmodes").attr("onclick","show_other_options()");
		$("#mobile_confirm_div .rec_modes_other_options").hide();
		$("#mobile_confirm_div .only_two_recmodes").show();
	}
	
	
	var rec_mobs=recovery_modes.otp;
	if(rec_mobs.count==1)
	{
		if(rec_mobs.data[0].isLookupId)
		{
			show_recovery_mobilenum_confirmationscreen(rec_mobs.data[0],true);
		}
		else
		{
			show_recovery_mobilenum_confirmationscreen(rec_mobs.data[0]);
		}

	}
	else
	{
		$("#select_reocvery_mobile .head_info").html(formatMessage(I18N.get("IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI"),rec_mobs.count.toString()));
		$("#select_reocvery_mobile .fieldcontainer").html("");
		
		var mobile_verify_template=$(".empty_mobile_template").html();;
		for(var i=0;i<rec_mobs.count;i++)
		{
			$("#select_reocvery_mobile .fieldcontainer").append(mobile_verify_template);
			$("#select_reocvery_mobile .fieldcontainer #recovery_mob").attr("id","recovery_mob"+i);
			$("#select_reocvery_mobile .fieldcontainer #recovery_mob"+i+" .option_title_try").html(rec_mobs.data[i].r_mobile)
			if(rec_mobs.data[i].isLookupId)
			{
				$("#select_reocvery_mobile .fieldcontainer #recovery_mob"+i).attr("onclick","show_recovery_mobilenum_confirmationscreen("+JSON.stringify(rec_mobs.data[i])+",true);");	//no i18N
			}
			else
			{				
				$("#select_reocvery_mobile .fieldcontainer #recovery_mob"+i).attr("onclick","show_recovery_mobilenum_confirmationscreen("+JSON.stringify(rec_mobs.data[i])+");");
			}
		}
		
		$("#mobile_confirm_div #select_reocvery_mobile").show();
		$("#mobile_confirm_div #confirm_reocvery_mobile").hide();
		$(".recover_sections").hide();
		$("#mobile_confirm_div").show();

	}
}

function show_recovery_mobilenum_confirmationscreen(mob_data,isLookupId)
{
	$("#mobile_confirm_div .only_two_recmodes").show();
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("otp")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "otp"});
	}
	if(recovery_modes.otp.count==1)
	{
		if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#mobile_confirm_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#mobile_confirm_div .only_two_recmodes").hide();
		}
		else
		{
			$("#mobile_confirm_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}
	else
	{
		$("#mobile_confirm_div .only_two_recmodes").attr("onclick","show_recMobScreen()");
		$("#mobile_confirm_div .rec_modes_contact_support").hide();
		$("#mobile_confirm_div .rec_modes_other_options").show();
		if(modes.length==1 	&&	(modes.indexOf("lookup_id")!=-1))
		{
			$("#mobile_confirm_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
		}
		else if(modes.length==0)
		{
			$("#mobile_confirm_div .rec_modes_contact_support").show();
			$("#mobile_confirm_div .rec_modes_other_options").hide();
		}
		else
		{
			$("#mobile_confirm_div .rec_modes_other_options").attr("onclick"," show_other_options()");
		}
	}
	
	var mobile_digest= mob_data.e_mobile;
	var enc_mobile=mob_data.r_mobile;
	
	$("#mobile_confirm").val("");
	$("#confirm_reocvery_mobile .head_info").html(formatMessage(I18N.get("IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION"),(enc_mobile.split("-")[1]).toString()));
	$("#confirm_reocvery_mobile .fieldcontainer #selected_encrypt_mobile").val(mobile_digest);
	
	$("#mobile_confirm_div #select_reocvery_mobile").hide();
	$(".recover_sections").hide();
	if(isLookupId)
	{
		$("#mobile_confirm").val(enc_mobile.split('-')[1]);
		mobile_confirmation(isLookupId);
	}
	else
	{
		$("#mobile_confirm_div,#mobile_confirm_div #confirm_reocvery_mobile").show();
	}
	$("#mobile_confirm").focus();

}

function mobile_confirmation(isLookupId)
{
	var mobile_confirm = $("#mobile_confirm").val();
	if(!isValid(mobile_confirm)	|| !isPhoneNumber(mobile_confirm))
	{
		showCommonError("mobile_confirm",I18N.get("IAM.AC.CONFIRM.MOBILE.VAlID"));//no i18n
		return false;
	}
	
	if($("#confirm_otp_container").is(":visible")){
		$("#confirm_otp_container #otp_resend").hide();
		$("#confirm_otp_container #otp_sent").show().addClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SENDING"));
	}
	else{		
		$("#mobconfirm_action span").addClass("zeroheight");
		$("#mobconfirm_action").addClass("changeloadbtn");
		$("#mobconfirm_action").attr("disabled", true);
	}

	var mobile_enc=$("#confirm_reocvery_mobile .fieldcontainer #selected_encrypt_mobile").val();
	
	var mobile_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mobile/"+mobile_enc; //no i18N
	var jsonData = {'mobilerecoveryauth':{'mobile':mobile_confirm }};//no i18n
	
	callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,function(resp){
		handleMobileConfirm(resp,isLookupId);
	},undefined,true);

	return false;
}


function handleMobileConfirm(resp,isLookupId)
{
	$("#mobconfirm_action span").removeClass("zeroheight");
	$("#mobconfirm_action").removeClass("changeloadbtn");
	$("#mobconfirm_action").attr("disabled", false);
	
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if(primary_factor_otp_threshold >= 1){
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
			{
				var decrypt=$("#mobile_confirm").val();
				
				$("#confirm_otp_div .head_info").html(formatMessage(I18N.get("IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION"),decrypt));
				
				primary_factor_otp_threshold--;
				resendcheck = primary_factor_otp_threshold;
				resendotp_checking("confirm_otp_div");//no i18n
				setTimeout(function(){
					$("#confirm_otp_container #otp_sent").removeClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SUCCESS"));
				},500);
				setTimeout(function(){
					$("#confirm_otp_container #otp_resend").show();
					$("#confirm_otp_container #otp_sent").hide();
				},2000);
				var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) : formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
				showTopNotification(formatMessage(I18N.get(otpsentmsg)));
				first_otp_sent=true;
				$("#otp_confirm_submit").attr("onclick","rec_mobile_confimation_action()");
				show_recusernameScreen("otp");//no i18n
				if(isLookupId)
				{
					$("#confirm_otp_div .only_two_recmodes").attr("onclick",recovery_modes.otp.count==1?'show_other_options()':'show_recMobScreen()');
					$("#confirm_otp_div #otp_resend").attr("onclick","mobile_confirmation(true)");
				}
				else
				{
					//$("#confirm_otp_div .only_two_recmodes").attr("onclick",'$("#mobile_confirm_div #select_reocvery_mobile").hide();$("#mobile_confirm_div #confirm_reocvery_mobile").show();$(".recover_sections").hide();$("#mobile_confirm_div").show();');
					$("#confirm_otp_div #otp_resend").attr("onclick","mobile_confirmation()");
				}

			}
			else
			{
				$("#confirm_otp_container #otp_resend").show();
				$("#confirm_otp_container #otp_sent").hide();
				if(jsonStr.cause==="throttles_limit_exceeded")
				{
					showCommonError("mobile_confirm",jsonStr.localized_message);//no i18n
					return false;
				}
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				showCommonError("mobile_confirm",errorMessage);//no i18n
				return false;
			}
		}else{
			showTopErrNotification(I18N.get('IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS'));
		}
		
	}
	else 
	{
		$("#confirm_otp_container #otp_resend").show();
		$("#confirm_otp_container #otp_sent").hide();
		showCommonError("mobile_confirm",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;

}

function rec_mobile_confimation_action()
{
	var otp_confirm = $("#confirm_otp_full_value").val();
	if(!isValid(otp_confirm)) 
	{
		showCommonError("confirm_otp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if(!isValidCode(otp_confirm)) 
	{
		showCommonError("confirm_otp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( otp_confirm ) ) {
		showCommonError("confirm_otp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	$("#otp_confirm_submit span").addClass("zeroheight");
	$("#otp_confirm_submit").addClass("changeloadbtn");
	$("#otp_confirm_submit").attr("disabled", true);
	
	var e_mobile=$("#confirm_reocvery_mobile .fieldcontainer #selected_encrypt_mobile").val();
	
	var mobile_verify_url = recoveryUri + "/v1/primary/"+zuid+"/mobile/"+e_mobile; //no i18N
	var jsonData = {'mobilerecoveryauth':{'code':otp_confirm }};//no i18n
	
	callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
}



//first factor Device

function show_recDeviceScreen()
{
	var mzadevice = recovery_modes.mzadevice.data;
	var isSecondaryDevice=false;
	var optionElem = '';
	mzadevice.forEach(function(data,index)
	{
		optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
		isSecondaryDevice = true;
	});
	$('#recovery_device_select').html(optionElem); // no i18n
	
	if(isSecondaryDevice)
	{
		try 
		{ 
			isMobile ? mobileviewDevices("#recovery_device_select") : renderUV("#recovery_device_select", false, "", "", "", false, false, "Mobile", true, null, null, "value")//no i18n
			 if($("#recovery_device_select option").length<=1){
					$("#recovery_device_select .selectbox_arrow").hide();
					$('#recovery_device_select').addClass("nonclickelem")
			  }
		}
		catch(err)
		{
			$('#recovery_device_select').css('display','block');
			if(!($('#recovery_device_select option').length > 1 ))
			{
				$('#recovery_device_select').css("pointer-events", "none");
			}
			$('option').each(function() 
			{
				if(this.text.length > 20)
				{
					var optionText = this.text;
					var newOption = optionText.substring(0, 20);
					$(this).text(newOption + '...');
				}
			});
		}
	}
	
	changeRECOVERYSecDevice($('#recovery_device_select'));//no i18N
}


function changeRECOVERYSecDevice(elem)
{
	updatedevices(elem);
	var version = $(elem).children("option:selected").attr('version');
	var device_index = $(elem).children("option:selected").val();
	mzadevicepos = device_index;
	enableRECOVERYMyZohoDevice(device_index);
}



function enableRECOVERYMyZohoDevice(device_index)
{
	var devicedetails = recovery_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	prefoption = devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	
	var device_rec_url= recoveryUri + "/v1/primary/"+zuid+"/device/"+deviceid;//no i18N
	callRequestWithCallback(device_rec_url,"",true,handleRECOVERYdeviceDetails,undefined,true);
	return false;
}

function handleRECOVERYdeviceDetails(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);

	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		resource_name = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			tmp_token = jsonStr[resource_name].token;
			var successCode = jsonStr.code;
			if(successCode === "SI202"||successCode==="MFA302" || successCode==="SI302" || successCode==="SI201")
			{
				$("#device_rec_wait").hide();
				$("#device_rec_resend").show();
				$("#recovery_device_div .resend_label").hide();
				$(".recover_sections").hide();
				$("#recovery_device_div").show();
				handlewidthOfSelect("#recovery_device_select");//no i18n
				//$("#device_rec_wait span").addClass("zeroheight");
				$('#recovery_device_div .rnd_resend_push').css("display", "none");
				$('#recovery_device_div .resendotp').css("display", "block");
				$("#recovery_device_div .only_two_recmodes").hide();
				
				showTopNotification(formatMessage(I18N.get("IAM.RESEND.PUSH.MSG")));//no i18N
				device_recovery_state=true;
				var wmsid = jsonStr[resource_name].WmsId && jsonStr[resource_name].WmsId.toString();
				isVerifiedFromDevice(prefoption,true,wmsid,true);
				if(jsonStr.devicerecoveryauth.rnd){
					$('#recovery_device_div .head_info').html(I18N.get('IAM.AC.RECOVERY.MODES.DEVICE.DESCRIPTION.RANDOMNUMBER'));
					$('#rnd_number').html(jsonStr.devicerecoveryauth.rnd);
					$('#rnd_number').css("display", "block");
					$("#device_rec_resend").hide();
					$("#device_rec_wait").hide();
				}else{
				$("#device_rec_resend").hide();
				$("#device_rec_wait").css("display","block");
				$("#device_rec_wait").attr("class","btn");
				$("#device_rec_wait").attr("class","btn totp_loading");
				$("#device_rec_wait").attr("disabled", true);
				}
				var timeLimit = 20;
				clearInterval(resendTimer);
				$('#recovery_device_div .resendotp').addClass('nonclickelem');
				$('#recovery_device_div .resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
				$('#recovery_device_div .resendotp span').text(timeLimit);
				$("#recovery_device_div .resend_label").show();
				resendTimer = setInterval(function()
				{
					timeLimit--;
					$('#recovery_device_div .resendotp span').text(timeLimit);
					if(timeLimit === 0) 
					{
						clearInterval(resendTimer);
						if(jsonStr.devicerecoveryauth.rnd){
							$('#recovery_device_div .resendotp').removeClass('nonclickelem');
							$('#recovery_device_div .rnd_resend_push').attr("onclick" , "changeRECOVERYSecDevice($('#recovery_device_select'))")
							$('#recovery_device_div .resendotp').css("display", "none");
							$('#recovery_device_div .rnd_resend_push').css("display", "block");
						}else{
						$('#recovery_device_div .resendotp').text("");
						$('#recovery_device_div .resendotp').removeClass('nonclickelem');
						
						$("#device_rec_wait").hide();
						$("#device_rec_wait").removeClass('totp_loading');
						$("#device_rec_resend").show();
						$("#recovery_device_div .resend_label").hide();
					}
					}
				},1000);
				
				return false;
			}
		}
		else
		{
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}

			if(jsonStr.cause==="pattern_not_matched")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showTopErrNotification(errorMessage);
			return false;
	   }
		
	}
	else
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}

//first factor Domain

function show_recDomainScreen()
{
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("domain")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "domain"});
	}
	if(modes.length==1 	&&	(modes.indexOf("lookup_id")!=-1))//ONLY USERNAME OPTION IS AVAILABLE
	{
		$("#recovery_domian_div .rec_modes_contact_support").show();
		$("#recovery_domian_div .rec_modes_other_options").hide();
		$("#recovery_domian_div .only_two_recmodes").attr("onclick","show_confirm_username_screen()");
		$("#recovery_domian_div .only_two_recmodes").show();
	}
	else if(modes.length==0)//only domain otpion
	{
		$("#recovery_domian_div .rec_modes_contact_support").show();
		$("#recovery_domian_div .rec_modes_other_options").hide();
		$("#recovery_domian_div .only_two_recmodes").hide();
	}
	else
	{
		$("#recovery_domian_div .rec_modes_contact_support").hide();
		$("#recovery_domian_div .rec_modes_other_options").show();
		$("#recovery_domian_div .only_two_recmodes").attr("onclick","show_other_options()");
		$("#recovery_domian_div .rec_modes_other_options").hide();
		$("#recovery_domian_div .only_two_recmodes").show();
	}
	
	var rec_dom=recovery_modes.domain;
	if(rec_dom.count>1)
	{
		$("#select_domain_verification .head_info").html(formatMessage(I18N.get("IAM.AC.CHOOSE.DOMAIN.DESCRIPTION"),rec_dom.count.toString()));
		$("#select_domain_verification .fieldcontainer").html("");
		var domain_verify_template=$(".empty_domain_template").html();;
		for(var i=0;i<rec_dom.count;i++)
		{
			$("#select_domain_verification .fieldcontainer").append(domain_verify_template);
			$("#select_domain_verification .fieldcontainer #recovery_domain").attr("id","recovery_domain"+i);
			$("#select_domain_verification .fieldcontainer #recovery_domain"+i+" .option_title_try").html(rec_dom.data[i].r_domain)
			$("#select_domain_verification .fieldcontainer #recovery_domain"+i).attr("onclick","show_recovery_domain_confirmationscreen("+JSON.stringify(rec_dom.data[i])+");");
		}
	}
	$("#recovery_domian_div .domain_section").hide();
	$("#recovery_domian_div #domain_verification_infostep").show();
	$(".recover_sections").hide();
	$("#domain_email_confirm").val("");
	$("#domain_confirm").val("");
	$("#recovery_domian_div").show();
}

function domian_verification_select()
{
	var rec_dom=recovery_modes.domain;
	if(rec_dom.count==1)
	{
		if( $("#confirm_domain_verification").is(":visible"))
		{
			$("#recovery_domian_div .domain_section").hide();
			$("#recovery_domian_div #domain_verification_infostep").show();
			return false;
		}
		show_recovery_domain_confirmationscreen(rec_dom.data[0])
	}
	else
	{
		$("#recovery_domian_div .domain_section").hide();
		$("#recovery_domian_div #select_domain_verification").show();
		
	}
}

function show_recovery_domain_confirmationscreen(domain_data)
{
	var modes=recovery_modes.allowed_modes;
	if(modes.indexOf("password")!=-1)
	{
		modes=modes.filter(function(e){ return e !== 'password'});
	}
	if(modes.indexOf("domain")!=-1)
	{
		modes=modes.filter(function(e){ return e !== "domain"});
	}
	if(modes.length==1	&&	(modes.indexOf("lookup_id")!=-1))
	{
		$("#recovery_domian_div .rec_modes_contact_support").hide();
		$("#recovery_domian_div .rec_modes_other_options").show();
		$("#recovery_domian_div .rec_modes_other_options").attr("onclick"," show_confirm_username_screen()");
	}
	else if(modes.length==0)
	{
		$("#recovery_domian_div .rec_modes_contact_support").show();
		$("#recovery_domian_div .rec_modes_other_options").hide();
	}
	else
	{
		$("#recovery_domian_div .rec_modes_contact_support").hide();
		$("#recovery_domian_div .rec_modes_other_options").show();
		$("#recovery_domian_div .rec_modes_other_options").attr("onclick"," show_other_options()");
	}
	$("#confirm_domain_verification .head_info").html(formatMessage(I18N.get("IAM.AC.ENTER.DOMAIN.DESCRIPTION"),domain_data.r_domain.toString()));
	$("#confirm_domain_verification #selected_encrypt_domain").val(domain_data.e_domain);
	
	$("#recovery_domian_div .domain_section").hide();
	$("#domain_confirm").val("");
	$("#recovery_domian_div #confirm_domain_verification").show();
	$("#domain_confirm").focus();
}


function domian_verification_confim()
{
	var domain_confirm = $("#domain_confirm").val().trim();
	if(!isValid(domain_confirm))
	{
		showCommonError("domain_confirm",I18N.get("IAM.ERROR.EMPTY.FIELD"));//no i18n
		return false;
	}
	if(!(/^(?:(?:(?:[a-zA-z\-]+)\:\/{1,3})?(?:[a-zA-Z0-9])(?:[a-zA-Z0-9\-\.]){1,61}(?:\.[a-zA-Z]{2,})+|\[(?:(?:(?:[a-fA-F0-9]){1,4})(?::(?:[a-fA-F0-9]){1,4}){7}|::1|::)\]|(?:(?:[0-9]{1,3})(?:\.[0-9]{1,3}){3}))(?:\:[0-9]{1,5})?$/.test(domain_confirm)))
	{
		showCommonError("domain_confirm",I18N.get("IAM.AC.DOMAIN.INVALID.ERROR"));//no i18n
		return false;
	}
	$("#domain_confirm_submit span").addClass("zeroheight");
	$("#domain_confirm_submit").addClass("changeloadbtn");
	$("#domain_confirm_submit").attr("disabled", true);
	
	var domain_enc=$("#confirm_domain_verification .fieldcontainer #selected_encrypt_domain").val();
	
	var domain_verify_url = recoveryUri + "/v1/primary/"+zuid+"/domain/"+domain_enc; //no i18N
	var jsonData = {'domainrecoveryauth':{'domain':domain_confirm }};//no i18n
	
	callRequestWithCallback(domain_verify_url,JSON.stringify(jsonData),true,handleDomainConfirm,undefined,true);
	return false;
}

function handleDomainConfirm(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$("#recovery_domian_div .rec_modes_contact_support").show();
			$("#recovery_domian_div .rec_modes_other_options").hide();
			$("#domain_email_verification .domain-name .value-text").html($("#domain_confirm").val());
			$("#domain_confirm").val("");
			$("#recovery_domian_div .domain_section").hide();		
			$(".real_radiobtn").prop('checked', false);	
			$("#recovery_domian_div #choose_domain_verification_type").show();
			$("#domain_email_verification .fieldcontainer #contact_encrypt_domain").val($("#confirm_domain_verification .fieldcontainer #selected_encrypt_domain").val());
			$("#domain_email_confirm").focus();
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("domain_confirm",jsonStr.localized_message);//no i18n
				return false;
			}
			if(jsonStr.response==="error"	&& jsonStr.message)
			{
				showCommonError("domain_confirm",jsonStr.message);//no i18n
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("domain_confirm",errorMessage);//no i18n
			return false;
		}
	}
	else 
	{
		showCommonError("domain_confirm",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;
	
}

function verification_type_confirm(type){
	var ver_type;
	if(type == 0){
		ver_type = "HTML file"; //No I18N
	} else if(type == 1){
		ver_type = "CNAME record"; //No I18N
	} else if(type == 2){
		ver_type = "TXT record"; //No I18N
	}	
	
	$("#recovery_domian_div #choose_domain_verification_type").hide();
	$("#recovery_domian_div #domain_email_verification").show();
	$("#domain_email_verification .type .value-text").html(ver_type);
	//$("#domain_email_verification .domain-name .value-text").html(domain_name);
}

function domian_email_confim()
{
	var email_confirm = $("#domain_email_confirm").val().trim();
	if(!isValid(email_confirm)	||	!isEmailId(email_confirm))
	{
		showCommonError("domain_email_confirm",I18N.get("IAM.AC.CONFIRM.EMAIL.VALID"));//no i18n
		return false;
	}
	$("#domain_email_confirm_submit span").addClass("zeroheight");
	$("#domain_email_confirm_submit").addClass("changeloadbtn");
	$("#domain_email_confirm_submit").attr("disabled", true);
	
	var domain_enc=$("#domain_email_verification .fieldcontainer #contact_encrypt_domain").val();
	
	var domain_verify_url = recoveryUri + "/v1/primary/"+zuid+"/domain/"+domain_enc; //no i18N
	var jsonData = {'domainrecoveryauth':{'contact_mail':email_confirm , 'type': $('#choose_domain_verification_type input[name="options"]:checked').val()}};//no i18n
	
	callRequestWithCallback(domain_verify_url,JSON.stringify(jsonData),true,handleDomainEmailConfirm,"PUT",true);//no i18n
	return false;
}

function handleDomainEmailConfirm(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$("#domain_email_confirm").val("");
			$("#recovery_domian_div .domain_section").hide();
			$("#recovery_domian_div #domain_reset_instruction .head_info").html(jsonStr.localized_message);
			$("#recovery_domian_div #domain_reset_instruction").show();
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("domain_email_confirm",jsonStr.localized_message);//no i18n
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("domain_email_confirm",errorMessage);//no i18n
			return false;
		}
	}
	else 
	{
		showCommonError("domain_email_confirm",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;
}


//passkey -: first factor

function initPasskeyOption(){
	var passkeyUrl = recoveryUri+"/v1/primary/"+zuid+"/passkey/self";	//no i18N
	callRequestWithCallback(passkeyUrl,"",true,passkeyActivtedCallback,undefined,true);
	return false;
}

function passkeyActivtedCallback(resp){
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
			var successCode = jsonStr.code;
			if(successCode==="SI203"){
				getAssertion(jsonStr.passkeyrecoveryauth,true);
			}
		}
		else{
			if(jsonStr.cause==="throttles_limit_exceeded"){
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			showTopErrNotification(jsonStr.localized_message);
			return false;
		}
		return false;

	}else{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL")); //no i18n
		return false;
	}
}

function PasskeyAuthCallback(resp)
{
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var resource_name = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
				$(".recover_sections").hide();
				show_ip_reset();
				return false;
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showTopErrNotification(errorMessage);
		}
	}
	else 
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));//No I18N

	}
	return false;

}



//otp verification for first factor

function handleOTPConfirm(resp)
{
	$("#otp_confirm_submit span").removeClass("zeroheight");
	$("#otp_confirm_submit").removeClass("changeloadbtn");
	$("#otp_confirm_submit").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var resource_name = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$("#confirm_otp").val("");
			isOrgAdmin = jsonStr[resource_name].isOrgAdmin!=undefined?jsonStr[resource_name].isOrgAdmin:undefined
			var ipRestrictedForOrg=jsonStr[resource_name].ipRestrictedForOrg!=undefined?true:false;
			if(jsonStr.code=="MFA302")//user has configured mfa
			{
				mfa_modes=jsonStr[resource_name].modes;
				initialize_MFAModes();
			}
			else
			{
				show_ip_reset();
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("confirm_otp",jsonStr.localized_message);//no i18n
				return false
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("confirm_otp",errorMessage);//No I18N
		}
	}
	else 
	{
		showCommonError("confirm_otp",I18N.get("IAM.ERROR.GENERAL"));//No I18N

	}
	return false;

}


function show_ip_reset()
{
	if(ipRestrictedForOrg==true	&&	ipPersonalRestriction==true)// show choice option
	{
		show_reset_ipChoice();
	}
	else if(ipRestrictedForOrg==true)
	{
		show_org_reset_IP(false);
	}
	else
	{
		show_non_org_ipreset();
	}
}


//mfa start


function initialize_MFAModes()
{
	showGif();
	$(".recover_sections").hide();
	var only_onemode=false;
	mfa_modes_count=mfa_modes.allowed_modes.length;
	mfa_modes_count==1?only_onemode=true:only_onemode=false;

	$(".support_bk_button").show();
	if(!only_onemode)
	{
		$(".show_mfa_options").show();
		$(".show_mfa_support_options").hide();
		$(".support_bk_button").attr("onclick","show_mfa_other_options()");
	}
	else
	{
		$(".show_mfa_options").hide();
		$(".show_mfa_support_options").show();
	}
	
	if(mfa_modes.allowed_modes.indexOf("otp") != -1)
	{
		$("#mfa_via_otp").show();
		if(only_onemode)
		{
			show_MfaOtpScreen();
			$(".support_bk_button").attr("onclick","show_MfaOtpScreen()");
		}
	}
	else
	{
		$("#mfa_via_otp").hide();
	}
	
	if(mfa_modes.allowed_modes.indexOf("totp") != -1)
	{
		$("#mfa_via_totp").show();
		if(only_onemode)
		{
			show_MfaTotpScreen();
			$(".support_bk_button").attr("onclick","show_MfaTotpScreen()");
		}
	}
	else
	{
		$("#mfa_via_totp").hide();
	}
	
	if(mfa_modes.allowed_modes.indexOf("mzadevice") != -1)
	{
		$("#mfa_via_device").show();
		if(only_onemode)
		{
			show_MfaDeviceScreen();
			$(".support_bk_button").attr("onclick","show_MfaDeviceScreen()");
		}
	}
	else
	{
		$("#mfa_via_device").hide();
	}
	
	if(mfa_modes.allowed_modes.indexOf("yubikey") != -1)
	{
		$("#mfa_via_yubikey").show();
		if(only_onemode)
		{
			show_MfaYubikeyScreen();
			$(".support_bk_button").attr("onclick","show_MfaYubikeyScreen()");
		}
	}
	else
	{
		$("#mfa_via_yubikey").hide();
	}
	if(!only_onemode)
	{
		show_mfa_other_options();
	}
	hideGif();
	return;
}

function show_mfa_other_options()
{
	$(".recover_sections").hide();
	$("#other_mfaoptions_div").show();
	$(".support_bk_button").attr("onclick","show_mfa_other_options()");
}



//MFA OTP  

function show_MfaOtpScreen()
{
	var mfa_otps=mfa_modes.otp.data;
	splitField.createElement('mfa_otp',{
		"splitCount":otp_length,				// No I18N
		"charCountPerSplit" : 1,	// No I18N
		"isNumeric" : true,			// No I18N
		"otpAutocomplete": true,	// No I18N
		"customClass" : "customOtp",// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$("#mfa_otp .splitedText").attr("onkeypress","clearCommonError('mfa_otp')");
	$("#mfa_otp").click();

	if(mfa_modes.otp.data.length==1)
	{
		
		$("#mfa_otp_view_other_options").hide();
		if(mfa_modes.allowed_modes.length>1)
		{
			$("#mfa_otp_view_otherMFA_options").show();
			$("#mfa_otp_contactsupport").hide();
		}
		else
		{
			$("#mfa_otp_view_otherMFA_options").hide();
			$("#mfa_otp_contactsupport").show();
		}
		$("#mfa_otp_select .mfa_backoption").hide();
		showMFAOtpsfillscreen(mfa_modes.otp.data[0]);
	}
	else
	{
		$("#mfa_otp_view_otherMFA_options").hide();
		$("#mfa_otp_view_other_options").show();
		$("#mfa_otp_contactsupport").hide();
		
		
		var primary_otp_num=undefined;
		var MFAmobile_verify_template=$(".empty_mfa_mob_template").html();
		$("#mfa_otp_section #mfa_otp_select .fieldcontainer").html("");
		$("#mfa_otp_section #mfa_otp_select .head_info").html(formatMessage(I18N.get("IAM.IP.SELECT.MFA.MOBILE_NUMBER.DESCRIPTION"),mfa_modes.otp.data.length.toString()));
		for(var i=0;i<mfa_otps.length;i++)
		{
			$("#mfa_otp_section #mfa_otp_select .fieldcontainer").append(MFAmobile_verify_template);
			$("#mfa_otp_section #mfa_otp_select .fieldcontainer #mfa_mobile").attr("id","mfa_mobile"+i);
			$("#mfa_otp_section #mfa_otp_select .fieldcontainer #mfa_mobile"+i+" .option_title_try").html(mfa_otps[i].r_mobile)
			$("#mfa_otp_section #mfa_otp_select .fieldcontainer #mfa_mobile"+i).attr("onclick","showMFAOtpsfillscreen("+JSON.stringify(mfa_otps[i])+");");
			if(mfa_otps[i].is_primary)
			{
				primary_otp_num=mfa_otps[i];
			}
		}
		if(primary_otp_num!=undefined)
		{
			showMFAOtpsfillscreen(primary_otp_num);
			$("#mfa_otp_select .mfa_backoption").show();
			$("#mfa_otp_select .mfa_backoption").attr("onclick",'$("#mfa_otp_section #mfa_otp_select").hide();$("#mfa_otp_section #mfa_otp_confirm").show();');
		}
		else
		{
			show_mfa_otp_other_options();
			$("#mfa_otp_select .mfa_backoption").hide();
		}
		
	}
	
}

function show_mfa_otp_other_options()
{
	$("#mfa_otp_section #mfa_otp_select").show();
	$("#mfa_otp_section #mfa_otp_confirm").hide();
	if(mfa_modes.otp.data.length==1)
	{
		$("#mfa_otp_select .mfa_backoption").hide();
		show_mfa_other_options();
	}
	else
	{
		$("#mfa_otp_select .mfa_backoption").show();
		$("#mfa_otp_select .mfa_backoption").attr("onclick",'$("#mfa_otp_section #mfa_otp_select").hide();$("#mfa_otp_section #mfa_otp_confirm").show();');
	}
}


function showMFAOtpsfillscreen(mfa_otp_data)
{
	var mobile_digest= mfa_otp_data.e_mobile;
	var enc_mobile=mfa_otp_data.r_mobile;
	if($("#mfa_otp_container").is(":visible")){
		$("#mfa_otp_container #otp_resend").hide();
		$("#mfa_otp_container #otp_sent").show().addClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SENDING"));
	}
	$("#mfa_otp_section #mfa_otp_confirm .head_info").html(formatMessage(I18N.get("IAM.NEW.SIGNIN.MFA.SMS.HEADER"),enc_mobile.toString()));
	$("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_enc").val(mobile_digest);
	$("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_decoded").val(enc_mobile);
	
	var mfa_totp_url = recoveryUri + "/v1/secondary/"+zuid+"/mobile/"+mobile_digest; //no i18N
	callRequestWithCallback(mfa_totp_url,"",true,handleMFA_otp_Confirm,undefined,true);//no i18N

	return false;
	
}
function handleMFA_otp_Confirm(resp)
{
	if(IsJsonString(resp)) 
	{
		var encrypt,decrypt;
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name=jsonStr.resource_name;
		if(MFA_otp_threshold >= 1){
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
			{
				encrypt= $("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_enc").val();
				decrypt=$("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_decoded").val();
				var mfa_otpdata={"e_mobile":encrypt,"r_mobile":decrypt};	//no i18N
				$("#mfa_otp_confirm #otp_resend").attr("onclick","showMFAOtpsfillscreen("+JSON.stringify(mfa_otpdata)+");");
				MFA_otp_threshold--;
				resendcheck = MFA_otp_threshold;
				resendotp_checking("mfa_otp_confirm");//no i18n
				setTimeout(function(){
					$("#mfa_otp_container #otp_sent").removeClass("otp_sending").html(I18N.get("IAM.GENERAL.OTP.SUCCESS"));
				},500);
				setTimeout(function(){
					$("#mfa_otp_container #otp_resend").show();
					$("#mfa_otp_container #otp_sent").hide();
				},2000);
				$("#mfa_otp_select .mfa_backoption").show();
				$("#mfa_otp_select .mfa_backoption").attr("onclick",'$("#mfa_otp_section #mfa_otp_select").hide();$("#mfa_otp_section #mfa_otp_confirm").show();');
				var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) : formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
				showTopNotification(formatMessage(I18N.get(otpsentmsg)));
				first_otp_sent=true;
				$("#mfa_otp").val("");
				$("#mfa_otp_section #mfa_otp_select").hide();
				$("#mfa_otp_section #mfa_otp_confirm").show();
				$(".recover_sections").hide();
				$("#mfa_otp_section").show();
			}
			else
			{
				$("#mfa_otp_container #otp_resend").show();
				$("#mfa_otp_container #otp_sent").hide();
				if(jsonStr.cause==="throttles_limit_exceeded")
				{
					showTopErrNotification(jsonStr.localized_message);
					return false
				}
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				show_other_options();
				showTopErrNotification(errorMessage);
				return false
			}
		}else{
			showTopErrNotification(I18N.get('IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS'));
		}
		
	}
	else 
	{
		$("#mfa_otp_container #otp_resend").show();
		$("#mfa_otp_container #otp_sent").hide();
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false
	}
	return false;
}

function mfa_otp_confimration()
{
	var mfa_otp = $("#mfa_otp_full_value").val();
	if(!isValid(mfa_otp)) 
	{
		showCommonError("mfa_otp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if(!isValidCode(mfa_otp)) 
	{
		showCommonError("mfa_otp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( mfa_otp ) ) 
	{
		showCommonError("mfa_otp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	
	$("#mfa_otp_submit span").addClass("zeroheight");
	$("#mfa_otp_submit").addClass("changeloadbtn");
	$("#mfa_otp_submit").attr("disabled", true);
	
	var mfa_otp_url = recoveryUri + "/v1/secondary/"+zuid+"/mobile/"+$("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_enc").val(); //no i18N
	var jsonData = {'mobilesecrecoveryauth':{'code':mfa_otp}};//no i18n
	
	callRequestWithCallback(mfa_otp_url,JSON.stringify(jsonData),true,handleMFAConfirm,"PUT",true);//no i18N
		
	return false;
}



//MFA totp


function show_MfaTotpScreen()
{
	$(".recover_sections").hide();
	$("#mfa_totp_section").show();
	splitField.createElement('mfa_totp',{
		"splitCount":6,				// No I18N
		"charCountPerSplit" : 1,	// No I18N
		"isNumeric" : true,			// No I18N
		"otpAutocomplete": true,	// No I18N
		"customClass" : "customOtp",// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$("#mfa_totp .splitedText").attr("onkeypress","clearCommonError('mfa_totp')");
	$("#mfa_totp").click();
}

function mfa_totp_confimration()
{
	var totp = $("#mfa_totp_full_value").val();
	if(!isValid(totp)) 
	{
		showCommonError("mfa_totp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if($("#mfa_totp_full_value~input").length > totp.length) 
	{
		showCommonError("mfa_totp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( totp ) ) 
	{
		showCommonError("mfa_totp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}
	
	$("#mfa_totp_submit span").addClass("zeroheight");
	$("#mfa_totp_submit").addClass("changeloadbtn");
	$("#mfa_totp_submit").attr("disabled", true);
	
	
	var mfa_totp_url = recoveryUri + "/v1/secondary/"+zuid+"/totp"; //no i18N
	var jsonData = {'totpsecrecoveryauth':{'code':totp }};//no i18n
	callRequestWithCallback(mfa_totp_url,JSON.stringify(jsonData),true,handleMFAConfirm,undefined,true);

	return false;
}


//MFA device one auth 

function show_MfaDeviceScreen()
{
	var isSecondaryDevice = false;
	var optionElem = '';
	showGif();
	var isSecondaryDevice=false;
	if(mfa_modes.mzadevice.data)
	{
		var mzadevice = mfa_modes.mzadevice.data;
		mzadevice.forEach(function(data,index)
		{
			optionElem += "<option value="+index+" version='"+data.app_version+"'>"+data.device_name+"</option>";
			isSecondaryDevice = true;
		});
	}
	$('#mfa_device_select').html(optionElem); // no i18n
	
	if(isSecondaryDevice)
	{
		try 
		{ 
			isMobile ? mobileviewDevices("#mfa_device_select") : renderUV("#mfa_device_select", false, "", "", "", false, false, "Mobile", true, null, null, "value")//no i18n
			if($("#mfa_device_select option").length<=1){
				$("#mfa_device_select ~ .selectbox_arrow").addClass("hideArrow");
				$('#mfa_device_select').addClass("nonclickelem")
		  }
		}
		catch(err)
		{
			$('#mfa_device_select').css('display','block');
			if(!($('#mfa_device_select option').length > 1 ))
			{
				$('#mfa_device_select').css("pointer-events", "none");
			}
			$('option').each(function() 
			{
				if(this.text.length > 20)
				{
					var optionText = this.text;
					var newOption = optionText.substring(0, 20);
					$(this).text(newOption + '...');
				}
			});
		}
		
	}
	
	changeMFADevice($('#mfa_device_select'));//no i18N
	return false;
}

function changeMFADevice(elem)
{
	show_device_prefmode();
	updatedevices(elem);
	if($(elem).children("option:selected").val() == prev_MFA_option){return false;}
	var version = $(elem).children("option:selected").attr('version');
	var device_index = $(elem).children("option:selected").val();
	mzadevicepos = device_index;
	enableMFAMyZohoDevice(device_index);
	if(prev_MFA_option == undefined){prev_MFA_option = $(elem).children("option:selected").val();}
}

function enableMFAMyZohoDevice(device_index)
{
	var devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	prefoption = devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	
	var device_mfa_url= recoveryUri + "/v1/secondary/"+zuid+"/device/"+deviceid;//no i18N
	var jsonData = {'devicesecrecoveryauth':{'devicepref':prefoption }};//no i18N
	callRequestWithCallback(device_mfa_url,JSON.stringify(jsonData),true,handleMFA_ACDetails,undefined,true);
	
	return false;
}
function handleMFA_ACDetails(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	hideGif();
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name = jsonStr.resource_name;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			var successCode = jsonStr.code;
			if(successCode === "SI202"||successCode==="MFA302" || successCode==="SI302" || successCode==="SI201")
			{
				if(isValid(jsonStr[resource_name].token))
				{
					tmp_token = jsonStr[resource_name].token;
				}
				
				$(".recover_sections").hide();
				$(".mfa_device_sliodes").hide();
				$("#mfa_device_section").show();
				device_recovery_state=false;
    			if(prefoption==="totp")
    			{
    				splitField.createElement('mfa_device_totp',{
    					"splitCount":6,					// No I18N
    					"charCountPerSplit" : 1,		// No I18N
    					"isNumeric" : true,				// No I18N
    					"otpAutocomplete": true,		// No I18N
    					"customClass" : "customOtp",	// No I18N
    					"inputPlaceholder":'&#9679;',	// No I18N
    					"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
    				});
    				$("#mfa_device_totp .splitedText").attr("onkeypress","clearCommonError('mfa_device_totp')");
    				
    				$("#mfa_device_totp_slide").show();
    				$("#mfa_device_totp").click();
    			}
    			else if(prefoption==="push")
    			{
    				verifyCount=0;
    				$("#mfa_device_push_slide .resend_label").hide();
    				$("#mfa_device_push_slide").show();
    				$("#device_MFA_wait").css("display","block");
    				handlewidthOfSelect("#mfa_device_select");//no i18n
    				$("#device_MFA_resend").hide();
    				//$("#device_MFA_wait span").addClass("zeroheight");
    				//$("#device_MFA_wait").addClass('changeloadbtn');
    				$("#device_MFA_wait").attr("disabled", true);
    				showTopNotification(formatMessage(I18N.get("IAM.RESEND.PUSH.MSG")));//no i18N
    				var wmsid = jsonStr[resource_name].WmsId && jsonStr[resource_name].WmsId.toString();
    				isVerifiedFromDevice(prefoption,true,wmsid,false);
    				$("#device_MFA_wait").attr("class","btn totp_loading");
    				
    				var timeLimit = 20;
    				$('#mfa_device_push_slide .resendotp').addClass('nonclickelem');
    				$('#mfa_device_push_slide .resendotp').html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
    				$('#mfa_device_push_slide .resendotp span').text(timeLimit);
    				$("#mfa_device_push_slide .resend_label").show();
    				clearInterval(resendTimer);
    				resendTimer = setInterval(function()
    				{
    					timeLimit--;
    					$('#mfa_device_push_slide .resendotp span').text(timeLimit);
    					if(timeLimit === 0) 
    					{
    						clearInterval(resendTimer);
    						$('#mfa_device_push_slide .resendotp').text("");
    						$('#mfa_device_push_slide .resendotp').removeClass('nonclickelem');
    						
    						$("#device_MFA_wait").hide();
    						$("#device_MFA_wait").removeClass('totp_loading');
        					$("#device_MFA_resend").show();
        					$("#mfa_device_push_slide .resend_label").hide();
    					}
    				},1000);
    				return false;
    			}
    			else if(prefoption==="scanqr")
    			{
    				
    				var qrcodeurl = jsonStr[resource_name].img;
    				qrtempId =  jsonStr[resource_name].temptokenid;
    				$("#qrimg").attr("src",qrcodeurl);//no i18n
					$("#mfa_device_qr_slide").show();
					var wmsid = jsonStr[resource_name].WmsId && jsonStr[resource_name].WmsId.toString();
					isVerifiedFromDevice(prefoption,true,wmsid,false);
					
    			}
				return false;
			}
		}
		else
		{
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			if(errorCode === "D105")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}

			if(jsonStr.cause==="pattern_not_matched")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showTopErrNotification(errorMessage);
			return false;
	   }
		
	}
	else
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}


function show_mfa_device_other_options(from_slide)
{
	$('.verify_device_qr_container').slideUp(200);
	$('.verify_device_totp_container').slideUp(200);
	$('.optionstry').removeClass("toggle_active");
	$(".mfa_device_sliodes").hide();
	$(".mfa_device_bk_button").show();
	$("#mfa_device_options_slide .optionstry").hide();
	
	if(mfa_modes_count==1)
	{
		$("#mfa_device_section .show_mfa_options").hide();
		$("#mfa_device_section .show_mfa_support_options").show();
	}
	else
	{
		$("#mfa_device_section .show_mfa_options").show();
		$("#mfa_device_section .show_mfa_support_options").hide();
	}
	
	if(from_slide==1)//push
	{
		$("#mfa_via_device_totp").show();
		$("#mfa_via_device_qr").show();
		$(".mfa_device_bk_button").attr("onclick","$('.mfa_device_sliodes').hide();$('#mfa_device_push_slide').show();show_device_prefmode();");
		$("#mfa_device_options_slide").show();
		
		//clear the previous push server calls
		clearInterval(resendTimer);
		$('#mfa_device_push_slide .resendotp').text("");
		$('#mfa_device_push_slide .resendotp').removeClass('nonclickelem');
		
		$("#device_MFA_wait").hide();
		$("#device_MFA_wait").removeClass('totp_loading');
		$("#device_MFA_resend").show();
		$("#mfa_device_push_slide .resend_label").hide();
		clearInterval(_time);
	}
	else if(from_slide==2)//totp
	{
	//	$("#mfa_via_device_qr").show();
	//	$("#mfa_via_device_qr").click();
		$(".mfa_device_bk_button").attr("onclick","$('.mfa_device_sliodes').hide();$('#mfa_device_totp_slide').show();show_device_prefmode();");
		//ONLY NEED TO SHOW QR option directly.
		$("#mfa_device_section .mfa_device_screens").hide();
		enableSecondaryDevicemodes("scanqr");//no i18N
	}
	else//qr
	{
	//	$("#mfa_via_device_totp").show();
	//	$("#mfa_via_device_totp").click();
		$(".mfa_device_bk_button").attr("onclick","$('.mfa_device_sliodes').hide();$('#mfa_device_qr_slide').show();show_device_prefmode();");
		//only need to show totp option directly.
		$("#mfa_device_section .mfa_device_screens").hide();
	}
	
}

function show_device_prefmode()
{
	$("#mfa_device_section .mfa_device_screens").show();
	$("#mfa_device_section .show_mfa_options").hide();
	$("#mfa_device_section .show_mfa_support_options").hide();
	$(".mfa_device_bk_button").hide();
}

function tryThisOption(ele)
{
	id=ele.id;
	if(!$('#'+id).hasClass("toggle_active"))
	{
		$('.verify_device_qr_container').slideUp(200);
		$('.verify_device_totp_container').slideUp(200);
		$('.optionstry').removeClass("toggle_active");
		if($('#'+id+' .option_detail').hasClass("verify_qr"))
		{
			$('.verify_qr .loader,.verify_qr .blur').show();
			enableSecondaryDevicemodes("scanqr");//no i18N
		}
		else
		{
			clearInterval(_time);
			enableSecondaryDevicemodes("totp");//no i18N
		}
	}
}

function enableSecondaryDevicemodes(prefoption)
{
	
	var version = $('#mfa_device_select').children("option:selected").attr('version');
	var device_index = $('#mfa_device_select').children("option:selected").val();
	devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	
	var device_url = recoveryUri + "/v1/secondary/"+zuid+"/device/"+deviceid;//no i18N
	var jsonData = {'devicesecrecoveryauth':{'devicepref':prefoption}};//no i18n
	
	if(prefoption=="scanqr")
	{
		callRequestWithCallback(device_url,JSON.stringify(jsonData),true,handle_alternate_QRCodeImg,undefined,true);
		$('#mfa_via_device_qr').addClass("toggle_active");
	}
	else
	{
		//callRequestWithCallback(device_url,JSON.stringify(jsonData),true,handle_alternate_TOTPCode,undefined,true);  //server call not need for this function
		handle_alternate_TOTPCode();
		$('#mfa_via_device_totp').addClass("toggle_active");
	}
	return;
}

function handle_alternate_TOTPCode()
{
			var version = $('#mfa_device_select').children("option:selected").attr('version');
			var device_index = $('#mfa_device_select').children("option:selected").val();
			devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
			deviceid= devicedetails.device_id;
			prefoption = devicedetails.prefer_option;//primary option in that device
			if(prefoption =="push")//show in mfa_device_options_slide
			{
				splitField.createElement('verify_device_totp',{
					"splitCount":6,					// No I18N
					"charCountPerSplit" : 1,		// No I18N
					"isNumeric" : true,				// No I18N
					"otpAutocomplete": true,		// No I18N
					"customClass" : "customOtp",	// No I18N
					"inputPlaceholder":'&#9679;',	// No I18N
					"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
				});
				$("#verify_device_totp .splitedText").attr("onkeypress","clearCommonError('verify_device_totp')");				
				$('#mfa_via_device_totp .option_detail').slideDown({
					duration: 200,
					start: function(){$(this).css("display","flex")},	// No I18N
					done : function(){$("#verify_device_totp .splitedText:first").focus()}
				});
			}
			else	//show in full screen
			{
				splitField.createElement('mfa_device_totp',{
					"splitCount":6,					// No I18N
					"charCountPerSplit" : 1,		// No I18N
					"isNumeric" : true,				// No I18N
					"otpAutocomplete": true,		// No I18N
					"customClass" : "customOtp",	// No I18N
					"inputPlaceholder":'&#9679;',	// No I18N
					"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
				});
				$("#mfa_device_totp .splitedText").attr("onkeypress","clearCommonError('mfa_device_totp')");
				$('#mfa_device_totp_slide').show();
				$("#mfa_device_totp .splitedText:first").focus();
			}
	return false;
}

function handle_alternate_QRCodeImg(resp)
{
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var resource_name = jsonStr.resource_name;
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			tmp_token = jsonStr[resource_name].token;
			var qrcodeurl = jsonStr[resource_name].img;
			qrtempId =  jsonStr[resource_name].temptokenid;
			var wmsid = jsonStr[resource_name].WmsId && jsonStr[resource_name].WmsId.toString();
			isVerifiedFromDevice("scanqr",true,wmsid,false);//no i18n
			
			var version = $('#mfa_device_select').children("option:selected").attr('version');
			var device_index = $('#mfa_device_select').children("option:selected").val();
			devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
			deviceid= devicedetails.device_id;
			prefoption = devicedetails.prefer_option;//primary option in that device
			if(prefoption =="push")//show in mfa_device_options_slide
			{
				$("#verify_qrimg").attr("src",qrcodeurl);//no i18n
				$('.verify_qr .loader,.verify_qr .blur').hide();
				$('#mfa_via_device_qr .option_detail').slideDown(200);
				if(isMobile){
					qrtempId = jsonStr[resource_name].temptokenid;
					isValid(qrtempId) ? $("#openoneauth").show() : $("#openoneauth").hide();
				}
			}
			else
			{
				$("#qrimg").attr("src",qrcodeurl);//no i18n
				$("#mfa_device_qr_slide").show();
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			var error_resp = jsonStr.errors && jsonStr.errors[0];
			var errorCode = error_resp && error_resp.code;
			showTopErrNotification(jsonStr.localized_message);
			return false;
	   }
		
	}else
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		return false;
	}
	return false;
}



function mfa_devicetotp_confimration(is_othermodes)
{
	
	var totp;
	if(is_othermodes)
	{
		totp = $("#verify_device_totp_full_value").val();
		if(!isValid(totp)) 
		{
			showTopErrNotification(I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));
			return false;
		}
		if($("#verify_device_totp_full_value~input").length > totp.length) 
		{
			showTopErrNotification(I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
			return false;
		}
		if( /[^0-9\-\/]/.test( totp ) ) 
		{
			showTopErrNotification(I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));
			return false;
		}
		
		$("#mfa_device_totp_verifybtn span").addClass("zeroheight");
		$("#mfa_device_totp_verifybtn").addClass("changeloadbtn");
		$("#mfa_device_totp_verifybtn").attr("disabled", true);
		
	}
	else
	{
		totp = $("#mfa_device_totp_full_value").val();
		if(!isValid(totp)) 
		{
			showCommonError("mfa_device_totp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
			return false;
		}
		if($("#mfa_device_totp_full_value~input").length > totp.length) 
		{
			showCommonError("mfa_device_totp",I18N.get("IAM.ERROR.VALID.OTP"));//no i18n
			return false;
		}
		if( /[^0-9\-\/]/.test( totp ) ) 
		{
			showCommonError("mfa_device_totp",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
			return false;
		}
		
		$("#mfa_device_TOTP_submit span").addClass("zeroheight");
		$("#mfa_device_TOTP_submit").addClass("changeloadbtn");
		$("#mfa_device_TOTP_submit").attr("disabled", true);
	}
	
	var device_index = $("#mfa_device_select").children("option:selected").val();
	var devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	prefoption = "totp";//no i18N
	devicename = devicedetails.device_name;
	var mfa_totp_url = recoveryUri + "/v1/secondary/"+zuid+"/device/"+deviceid+"?"; //no i18N
	mfa_totp_url+="polling="+false ;//no i18N
	var jsonData = {'devicesecrecoveryauth':{'code':totp ,"devicepref":prefoption}};//no i18n
		
	callRequestWithCallback(mfa_totp_url,JSON.stringify(jsonData),true,handleMFAConfirm,"put",true);//no i18N

	return false;

}

// yubikey 

function show_MfaYubikeyScreen()
{
	$('#mfa_yubikey_select,#list_mfa_yubikeys').hide();
	enable_YubikeyDevice();
}

function changeMFAYubikey(elem)
{
	enable_YubikeyDevice();
	return;
}
function enable_YubikeyDevice()
{
	if(!isWebAuthNSupported()){
		showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	$("#mfa_yubikey_section .head_info").html(I18N.get("IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW")); //no i18N
	var mfa_yubikey_url = recoveryUri + "/v1/secondary/"+zuid+"/yubikey/self" //no i18N
	callRequestWithCallback(mfa_yubikey_url,"",true,handleMFA_yubikey_Confirm,undefined,true);//no i18N
	return false;

	
}

function getAssertion(parameters,forPasskey) {
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
	requestOptions.extensions.uvm = true;
	return navigator.credentials.get({
		"publicKey": requestOptions//No I18N
	}).then(function(assertion){
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
			showTopErrNotification(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse"), supportEmailAddr));
	    }
	    if (assertion.getClientExtensionResults) {
	      if (assertion.getClientExtensionResults().uvm != null) {
	        publicKeyCredential.uvm = serializeUvm(assertion.getClientExtensionResults().uvm);
	      }
	    }

	    var _response = assertion.response;

	    publicKeyCredential.response = {
	      clientDataJSON:     binToStr(_response.clientDataJSON),
	      authenticatorData:  binToStr(_response.authenticatorData),
	      signature:          binToStr(_response.signature),
	      userHandle:         binToStr(_response.userHandle)
	    };
	    if(forPasskey)
	    {
	    	var passkey_data ={};
	    	passkey_data.passkeyrecoveryauth = publicKeyCredential;
			callRequestWithCallback(recoveryUri + "/v1/primary/"+zuid+"/passkey/self",JSON.stringify(passkey_data),true,PasskeyAuthCallback,"PUT",true);//no i18N
	    }
	    else
	    {
			var yubikey_sec_data ={};
			yubikey_sec_data.yubikeysecrecoveryauth = publicKeyCredential;
			callRequestWithCallback(recoveryUri + "/v1/secondary/"+zuid+"/yubikey/self",JSON.stringify(yubikey_sec_data),true,handleMFAConfirm,"PUT",true);//no i18N
	    }
	     
	}).catch(function(err){
		$(".btn span").removeClass("zeroheight");
		$(".btn").removeClass("changeloadbtn");
		$("#mfa_yubikey_submit .loadwithbtn").hide();
		$("#mfa_yubikey_submit").attr("disabled", false);
	  	$("#mfa_yubikey_submit .waittext").html(I18N.get("IAM.EXCEPTION.RELOAD"));
		if(err.name == 'NotAllowedError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError"));
		}else if(err.name == 'InvalidStateError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError"));
		} else if (err.name == 'AbortError') {
			showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.NotAllowedError"));
		} else if(err.name == 'UnknownError') {
			showTopErrNotification(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.UnknownError"), supportEmailAddr));
		} else {
			showTopErrNotification(formatMessage(I18N.get("IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred"), supportEmailAddr)+ '<br>' +err.toString());
		}
	});
}

function handleMFA_yubikey_Confirm(resp) 
{
	if(!isWebAuthNSupported()){
		showTopErrNotification(I18N.get("IAM.WEBAUTHN.ERROR.BrowserNotSupported"));
		return false;
	}
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			getAssertion(jsonStr.yubikeysecrecoveryauth);
			$("#mfa_yubikey_submit .waittext").html(I18N.get("IAM.NEW.SIGNIN.WAITING.APPROVAL"));
			$("#mfa_yubikey_submit .loadwithbtn").show();
			$("#mfa_yubikey_submit").attr("disabled", true);
			
			$(".recover_sections").hide();
			$("#mfa_yubikey_section").show();
			
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			showTopErrNotification(jsonStr.localized_message);
			return false;
		}
		return false;
	   	
	}
	else
	{
		showTopErrNotification(jsonStr.localized_message);
		return false;	
	}
	return false;

}



//first factior and mfa device verfication 


function isVerifiedFromDevice(prefmode,isMyZohoApp,WmsID,is_recoverymode) 
{
	if(isWmsRegistered === false && isValid(WmsID) && WmsID != "undefined" )
	{
		wmscallmode=prefmode;wmscallapp=isMyZohoApp;wmscallid=WmsID;
		try 
		{
			WmsLite.setNoDomainChange();
	 		WmsLite.registerAnnon('AC', WmsID ); //No I18N
	 		isWmsRegistered=true;
	 		
	 	} catch (e) 
	 	{
		//no need to handle failure
	 	}
	}
	prefmode = prefmode === undefined ? wmscallmode:prefmode;
    isMyZohoApp = isMyZohoApp === undefined ? wmscallapp : isMyZohoApp;
    WmsID = WmsID === undefined ? wmscallid : WmsID;
	clearInterval(_time);
	if(verifyCount > 15) 
	{
		return false;
	}
	if(typeof is_recoverymode=='undefined')
	{
		is_recoverymode=device_recovery_state;
	}
	
	if(is_recoverymode)
	{
		var device_url = recoveryUri + "/v1/primary/"+zuid+"/device/"+deviceid+"?";//no i18N
		device_url+="polling="+true ;//no i18N
		
		callRequestWithCallback(device_url,"",false,VerifySuccess,"PUT",true);//no i18N
	}
	else
	{
		var device_url = recoveryUri + "/v1/secondary/"+zuid+"/device/"+deviceid+"?";//no i18N
		device_url+="polling="+true ;//no i18N
		var jsonData = {'devicesecrecoveryauth':{'devicepref':prefmode}};//no i18n
		
		callRequestWithCallback(device_url,JSON.stringify(jsonData),false,VerifySuccess,"PUT",true);//no i18N
	}

	verifyCount++;
	
	if(isValid(WmsID) && WmsID!="undefined")
	{
		wmscount++;
		var callIntervalTime = wmscount < 6 ? 5000 : 25000;
		_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\","+is_recoverymode+")", callIntervalTime);//No I18N
		return false;
	}
	else
	{
		_time = setInterval("isVerifiedFromDevice(\""+prefmode+"\","+isMyZohoApp+",\""+WmsID+"\","+is_recoverymode+")", 3000);//No I18N
	}
	return false;
}

function VerifySuccess(res) 
{
	if(IsJsonString(res)) 
	{
		var jsonStr = JSON.parse(res);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			var successCode = jsonStr.code;
			var resourcename = jsonStr.resource_name;
			var statusmsg = jsonStr[resourcename].status;
			clearInterval(_time);
			isOrgAdmin = jsonStr[resourcename].isOrgAdmin!=undefined?jsonStr[resourcename].isOrgAdmin:undefined
			if(resourcename=="devicerecoveryauth")	//for recovery device
			{
				if(jsonStr.code=="MFA302")//user has configured mfa
				{
					mfa_modes=jsonStr[resourcename].modes;
					initialize_MFAModes();
					return false;
				}
				else
				{
					show_ip_reset();
					return false;
				}
			}
			else if(resourcename=="devicesecrecoveryauth")//for mfa device
			{
				show_ip_reset();
				return false;
			}
			showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
			return false
		}
	}
	return false;
}

function handleMFAConfirm(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	var error_txtbox=$('.otp_container:visible').attr("id")!=undefined?$('.otp_container:visible').attr("id"):undefined;//no i18N
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name=undefined;
		if(isValid(jsonStr.resource_name))
		{
			resource_name=jsonStr.resource_name;
		}
		else
		{
			showCommonError(error_txtbox,I18N.get("IAM.ERROR.GENERAL"));//No I18N
		}
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			isOrgAdmin = jsonStr[resource_name].isOrgAdmin!=undefined?jsonStr[resource_name].isOrgAdmin:undefined
			show_ip_reset();
			return false;
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError(error_txtbox,jsonStr.localized_message);
			}
			else
			{
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				showCommonError(error_txtbox,errorMessage);
			}
		}
	}
	else 
	{
		showCommonError(error_txtbox,I18N.get("IAM.ERROR.GENERAL"));//No I18N

	}
	return false;
}





//reset IP section

function show_non_org_ipreset()
{
	$(".recover_sections").hide();
	$("#reset_ip_INFO .fieldcontainer").hide();
	$("#reset_ip_INFO .head_info").html(I18N.get("IAM.IP.RESET.USER_VERIFICATION.SUCCESS"));
	$("#resetip_bk_arrow").hide();
	$("#reset_ip_INFO #user_reset_info").show();
	$("#reset_ip_INFO").show();
}

function show_reset_ipChoice()
{
	$(".recover_sections").hide();
	$("#reset_ip_INFO .fieldcontainer").hide();
	$("#resetip_bk_arrow").hide();
	$("#reset_ip_INFO .head_info").html(I18N.get("IAM.IP.RESET.USER_VERIFICATION.SUCCESS"));
	$("#reset_ip_INFO #resetip_org .option_description").html(formatMessage(I18N.get("IAM.IP.RESET.SECTION.CHOOSE.ORG.DESCRIPTION"),org_name));
	$("#reset_ip_INFO #choose_ip_reset_info").show();
	$("#reset_ip_INFO").show();
}


function show_user_reset_IP()
{
	$(".recover_sections").hide();
	$("#reset_ip_INFO .fieldcontainer").hide();
	$(".self_confirmation").hide();
	$("#resetip_bk_arrow").show();
	$("#reset_ip_INFO .head_info").html(I18N.get("IAM.IP.RESET.SECTION.USER.DESCRIPTION"));
	$("#reset_ip_INFO #user_reset_info").show();
	$("#reset_ip_INFO").show();
	
	return;
}
function show_org_reset_IP(show_bk_option)
{
	$(".recover_sections").hide();
	$("#reset_ip_INFO .fieldcontainer").hide();
	$("#reset_ip_INFO .backoption").show();
	if(!show_bk_option)
	{
		$("#reset_ip_INFO .backoption").hide();
	}
	$("#reset_ip_INFO .head_info").html(formatMessage(I18N.get("IAM.IP.RESET.SECTION.ORG.DESCRIPTION"),org_name));
	$("#reset_ip_INFO #ORG_reset_info").show();
	$("#reset_ip_INFO").show();
	
	return;
}
function remove_ip_restriction(mode)
{
	
	$("#reset_ip_INFO button span").addClass("zeroheight");
	$("#reset_ip_INFO button").addClass("changeloadbtn");
	$("#reset_ip_INFO button").attr("disabled", true);
	
	
	var reset_ip_url = recoveryUri + "/v1/reset/"+zuid+"/resetIP"; //no i18N
	var jsonData = {'resetip':{'option':mode }};//no i18n
	callRequestWithCallback(reset_ip_url,JSON.stringify(jsonData),true,handleresetIPConfirm,undefined,true);

	return false;
	
}


function handleresetIPConfirm(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name=undefined;
		if(isValid(jsonStr.resource_name))
		{
			resource_name=jsonStr.resource_name;
		}
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			redirect_url=jsonStr[resource_name].redirect_url;
			if(jsonStr[resource_name].selectedOpt=="userIp")
			{
				$(".recover_sections").hide();
				$("#allowedipform #current_ip .ip_blue").html(jsonStr[resource_name].current_ip);
				$("#allowedipform #get_ip #cur_ip").val(jsonStr[resource_name].current_ip);
				$("#self_resetIP_confimation").show();
				return false;
			}
			else
			{
				$(".recover_sections,.service_logo").hide();
				$(".success_portion .success_header").html(I18N.get("IAM.RESETIP.SUCCESS.ORG.RESET"));
				$(".success_portion .reset_ip_success_msg").html(I18N.get("IAM.RESETIP.SUCCESS.ORG.RESET.DESC"));
				$(".success_portion").show();
				return false;
			}
			
		}
	}
	showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	return false;
	
	
}


function swicth_to_signin()
{
	if(redirect_url!=undefined)
	{
		switchto(redirect_url);
		return false;
	}
	showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	return false;

}

function setup_new_IP()
{
	$("#setup_ip_bk").attr("onclick",'$(".recover_sections").hide();$("#self_resetIP_confimation").show();$("input[name=ip_select]").unbind();');
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
	$(".recover_sections").hide();
	$("#setup_new_ip_section .head_info").html(I18N.get("IAM.RESETIP.NEW.CONFIGURE.DESC"));
	$("#setup_new_ip_section #get_ip").show();
	$('#current_ip_sel').prop("checked", true);
	$("#setup_new_ip_section #get_name").hide();
	$('input[name=ip_select]').change(function () {
        var val=$(this).val();
        clearIPError('static_ip_field');clearIPError('from_ip_field');clearIPError('to_ip_field'); // No I18N
        $(".field_error").remove();	
        if(val=="1")
        {
        	$("#static_ip").slideUp(300);
        	$("#range_ip").slideUp(300);
        }
        else if(val=="2")
        {
        	splitField.createElement('static_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	$("#static_ip_field .splitedText").attr("onkeypress","clearIPError('static_ip_field')");
        	$("#static_ip").slideDown(300);
        	$("#range_ip").slideUp(300);
        	$("#static_ip_field .splitedText:first").focus();
        }
        else
        {
        	splitField.createElement('from_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	splitField.createElement('to_ip_field',{
        		"isIpAddress": true,		// No I18N
        		"separator":"&#xB7;",			// No I18N
        		"separateBetween" : 1,		// No I18N
        		"customClass" : "ip_address_field"	// No I18N
        	});
        	$("#from_ip_field .splitedText").attr("onkeypress","clearIPError('from_ip_field')");
        	$("#to_ip_field .splitedText").attr("onkeypress","clearIPError('to_ip_field')");
        	$("#static_ip").slideUp(300);
        	$("#range_ip").slideDown(300);////for inline block
        	$("#from_ip_field .splitedText:first").focus();
        }
    });
	$("#setup_new_ip_section").show(0,function(){
		$("#range_ip").hide();
		$("#static_ip").hide();	
		$("#popup_ip_new .real_radiobtn:first").focus();
	});
	
	
}


function isIP(str) 
{
    str = str.trim();
    var pattern =/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    return pattern.test(str);
}

function addipaddress(f)
{
	var val= f.ip_select.value.trim();
	var fip;
    var tip;
	if(val==1)
	{
		fip=tip=f.cur_ip.value.trim();
	}
	else if(val==2)
	{
		fip=tip=$("#static_ip_field_full_value").val();
		tip=tip.trim();
		fip=fip.trim();
	}
	else if(val==3)
	{
		fip=$("#from_ip_field_full_value").val();
		tip=$("#to_ip_field_full_value").val();
		tip=tip.trim();
		fip=fip.trim();
		clearIPError('from_ip_field');clearIPError('to_ip_field');// No I18N
	}
    if(isEmpty(fip)) 
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		show_ip_error("static_ip",I18N.get("IAM.ALLOWEDIP.STATIC.EMPTY"));// No I18N
    	}
    	else
    	{
    		show_ip_error("from_ip_field",I18N.get("IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY"));// No I18N
    	}
    }
    else if(!isIP(fip)) 
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		show_ip_error("static_ip",I18N.get("IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID"));// No I18N
    	}
    	else
    	{
    		show_ip_error("from_ip_field",I18N.get("IAM.ALLOWEDIP.FROMIP.NOTVALID"));// No I18N
    	}
    }
    else if(isEmpty(tip))  
    {
    	show_ip_error("to_ip_field",I18N.get("IAM.ALLOWEDIP.TOIP.ERROR.EMPTY"),true);// No I18N

    }
    else if(!isIP(tip))//invalid To ip address
    {
    	show_ip_error("to_ip_field",I18N.get("IAM.ALLOWEDIP.TOIP.NOT_VALID"),true);// No I18N
    }
    else 
    {
    	show_get_name(fip,tip);
    	
    }
    $("#ip_name").focus();
    return false;
}

function show_ip_error(field,msg,isright)
{
	$('.fielderror').val('');
	var space =$("#"+field+" .ip_field_div").length==0?'#'+field:"#"+field+" .ip_field_div";
	$(space).addClass("errorborder");
	var container=$("#"+field).closest(".ip_cell_parent").attr("id");
	
	$("#"+container+ " .fielderror").addClass("errorlabel");
	if(isright)
	{
		$("#"+container+ " .fielderror").addClass("field_error_right");
	}
	$("#"+container+ " .fielderror").html(msg);
	$("#"+container+ " .fielderror").slideDown(200);
	return false;

}

function clearIPError(field)
{
	var container=$("#"+field).closest(".ip_cell_parent").attr("id");
	$("#"+field).removeClass("errorborder");
	$("#"+field).nextAll(".fielderror").removeClass("field_error_right");
	$("#"+field).nextAll(".fielderror").slideUp(100);
	$("#"+field).nextAll(".fielderror").removeClass("errorlabel");
	$("#"+field).nextAll(".fielderror").text("");
}




function show_get_name(fip,tip)
{
	clear_allerrors();
	$("#setup_ip_bk").attr("onclick",'$("input[name=ip_select]").unbind();setup_new_IP()');

	$("#setup_new_ip_section #get_ip").hide();
	$("#setup_new_ip_section #get_name").show();
	$(".ip_impt_note").show();
	
	
	if(fip && tip)
	{
		$("#fip").val(fip);
		$("#tip").val(tip);
		if(fip==tip)
		{
			$("#ip_range_forNAME").text(fip);
			$("#setup_new_ip_section .head_info").html(I18N.get("IAM.RESETIP.NEW.CONFIGURE.STATIC.DESC"));
		}
		else
		{
			$("#ip_range_forNAME").text(fip+" - "+tip);
			
			$("#setup_new_ip_section .head_info").html(I18N.get("IAM.RESETIP.NEW.CONFIGURE.RANGE.DESC"));
		}
	}
	$("#allowedipform").attr("onsubmit","return add_ip_with_name(this)");
	$("#ip_name").focus();
	return false;
}


function add_ip_with_name(f)
{
	var name = f.ip_name.value.trim();
	
	if(name == undefined || name == '')
	{
		$('#ip_name').nextAll('.fielderror:first').html(I18N.get("IAM.ALLOWEDIP.IPNAME.EMPTY")); //No I18n
    	$('#ip_name').nextAll('.fielderror:first').show();
    	$('#ip_name').focus();
    	return false;
	}
	var from = $("#fip").val();
	var to = $("#tip").val();
	var iplist = [];
	if(from){
		iplist.push(from);
	}
	if(to && to != from){
		iplist.push(to);
	}
	
	$("#add_new_ip span").addClass("zeroheight");
	$("#add_new_ip").addClass("changeloadbtn");
	$("#add_new_ip").attr("disabled", true);
	
	var ip_add_url = recoveryUri + "/v1/reset/"+zuid+"/addIP"; //no i18N
	var jsonData = {'addauthorizedip':{'ip_name':name,'ips':[iplist],'client_apps':'[0]' }};//no i18n
	callRequestWithCallback(ip_add_url,JSON.stringify(jsonData),true,handlenewIPsetup,undefined,true);

	return false;
}


function handlenewIPsetup(resp)
{
	$(".btn span").removeClass("zeroheight");
	$(".btn").removeClass("changeloadbtn");
	$(".btn").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		var resource_name=undefined;
		if(isValid(jsonStr.resource_name))
		{
			resource_name=jsonStr.resource_name;
		}
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$(".recover_sections,.service_logo").hide();
			$(".success_portion .success_header").html(I18N.get("IAM.IP.RESTRICTION.RECONFIGURED"));
			$(".success_portion .reset_ip_success_msg").html(I18N.get("IAM.IP.RESTRICTION.RECONFIGURED.DESC"));
			$(".success_portion").show();
			return false;
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
				return false;
			}
			showTopErrNotification(jsonStr.localized_message);
			return false;
		}
		return false;
	}
	showCommonError("ip_name",I18N.get("IAM.ERROR.GENERAL"));//No I18N
	return false;
	
	
}



//support contact 


function show_contactsupport(no_modes)
{
	$(".support_sections").hide();
	clearInterval(_time);
	if(no_modes==true)// no recovery modes avaiable so show general error and continue.
	{
		$("#no_recovery_mode_support").show();
		if(	org_contact!=undefined)
		{
			$("#no_recovery_mode_support .no_recovery_mode_support_contactid").html(formatMessage(I18N.get("IAM.AC.CONTACT.SUPPORT.NO_OPTION.CONTACT"),org_contact.toString()));
		}
		$("#contact_support_div #support_norm_desc").hide();
		$("#contact_support_div #support_help_article").hide();
		$("#contact_support_div #support_go_bk").css("display","flex");
	}
	else
	{
		$("#contact_support_div #support_norm_desc").show();
		$("#contact_support_div #support_help_article").css("display","flex");
		$("#contact_support_div #support_go_bk").hide();
		if(org_name!=undefined	&&	org_contact!=undefined)
		{
			$("#org_contact_support").show();
			$("#org_contact_support .head_info").html(formatMessage(I18N.get("IAM.IP.CONTACT.ORG.SUPPORT.DESC"),org_name.toString(),org_contact.toString(),org_contact.toString()));
		}
		else
		{
			if(contact_support_email==undefined)
			{
				contact_support_email=login_id;
			}
			$("#normal_contact_support").show();
		}
	}
//	$("#contact_support_div .head_info .normal_mode_support_contactid").html(formatMessage(I18N.get("IAM.AC.CONTACT.SUPPORT.DESCRIPTION"),contact_support_email));
	$(".recover_sections").hide();
	$("#contact_support_div").show();

}

function goto_signin()
{
	switchto(window.location.origin + uriPrefix + "/signin"); //no i18N
}



//contact support contains a todo
/*
function change_contactemail()
{
	$(".support_sections").hide();
	$("#change_contact_support").val("");
	$("#change_contactemail_support").show();
}

function change_contact_support()
{
	var contact_support = $("#change_contact_support").val();
	if(!isValid(email_confirm)	&&	!isEmailId(email_confirm))
	{
		showCommonError("change_contact_support",I18N.get("IAM.AC.CONFIRM.EMAIL.VALID"));//no i18n
		return false;
	}
	$("#change_contact_support_action span").addClass("zeroheight");
	$("#change_contact_support_action").addClass("changeloadbtn");
	$("#change_contact_support_action").attr("disabled", true);
	
	//todo 1 change email for support 
	
	var contact_supp_change_url = recoveryUri + "/v1/primary/"+zuid+"/support"; //no i18N
	var jsonData = {'changecontactemail':{'email':contact_support}};//no i18n
	
	callRequestWithCallback(contact_supp_change_url,JSON.stringify(jsonData),true,handleChnageContactEmailConfirm,undefined,true);
	
}

function handleChnageContactEmailConfirm(resp)
{
	$("#change_contact_support_action span").removeClass("zeroheight");
	$("#change_contact_support_action").removeClass("changeloadbtn");
	$("#change_contact_support_action").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$(".support_sections").hide();
			$("#verify_contact_support").val("");
			$("#contact_support_div #confirm_contact_support .head_info .normal_mode_support_contactid").html(formatMessage(I18N.get("IAM.AC.CONTACT.SUPPORT.DESCRIPTION"),$("#change_contact_support").val()));
			$("#confirm_contact_support").show();
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("confirm_otp",jsonStr.localized_message);//no i18n
				return false
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("change_contact_support",errorMessage);//No I18N
		}
	}
	else 
	{
		showCommonError("change_contact_support",I18N.get("IAM.ERROR.GENERAL"));//No I18N
	
	}
	return false;
}


function confirm_change_contact_support()
{
	
	
	var otp_confirm = $("#verify_contact_support").val();
	if(!isValid(otp_confirm)) 
	{
		showCommonError("verify_contact_support",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if( /[^0-9\-\/]/.test( otp_confirm ) ) {
		showCommonError("verify_contact_support",I18N.get("IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"));//No I18N
		return false;
	}

	$("#confirm_contact_support_action span").removeClass("zeroheight");
	$("#confirm_contact_support_action").removeClass("changeloadbtn");
	$("#confirm_contact_support_action").attr("disabled", false);
	
	//todo 1 change email for support 
	
	var contact_supp_change_url = $("#change_contact_support").val();
	var mobile_verify_url = recoveryUri + "/v1/primary/"+zuid+"/support"+contact_support; //no i18N
	var jsonData = {'changecontactemail':{'code':otp_confirm}};//no i18n
	
	callRequestWithCallback(contact_supp_change_url,JSON.stringify(jsonData),true,handleVerifyContactSupportConfirm,"PUT",true);//no i18N
}

function handleVerifyContactSupportConfirm()
{
	$("#change_contact_support_action span").removeClass("zeroheight");
	$("#change_contact_support_action").removeClass("changeloadbtn");
	$("#change_contact_support_action").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			contact_support_email= $("#change_contact_support").val();
			show_contactsupport();
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("verify_contact_support",jsonStr.localized_message);//no i18n
				return false
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("verify_contact_support",errorMessage);//No I18N
		}
	}
	else 
	{
		showCommonError("verify_contact_support",I18N.get("IAM.ERROR.GENERAL"));//No I18N
	
	}
	return false;
}

function show_contactsupport()
{
	if(contact_support_email==undefined)
	{
		contact_support_email=login_id;
	}
	$(".recover_sections").hide();
	$(".support_sections").hide();
	$("#contact_supportexpl").val("");
	$("#contact_support_div #main_contact_support .head_info .normal_mode_support_contactid").html(formatMessage(I18N.get("IAM.AC.CONTACT.SUPPORT.DESCRIPTION"),contact_support_email));
	$("#contact_support_container").show();
	$("#main_contact_support").show();
	
}


function contact_support()
{
	if(!isValid(contact_support_email)	&&	!isEmailId(contact_support_email))
	{
		change_contactemail();
		showTopNotification(I18N.get("IAM.AC.CONFIRM.EMAIL.VALID"));
		return false;
	}
	
	var issue_to_support=$("#contact_supportexpl").val();
	if(!isValid(issue_to_support))
	{
		showCommonError("contact_supportexpl",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	
	$("#main_contact_support_action span").addClass("zeroheight");
	$("#main_contact_support_action").addClass("changeloadbtn");
	$("#main_contact_support_action").attr("disabled", true);
	
	//todo 1 change email for support 
	
	var contact_supp_url = recoveryUri + "/v1/primary/"+zuid+"/support"; //no i18N
	var jsonData = {'changecontactemail':{'problem':issue_to_support}};//no i18n
	
	callRequestWithCallback(contact_supp_url,JSON.stringify(jsonData),true,handlereportedToSupport,undefined,true);
}

function handlereportedToSupport(resp)
{
	//todo 2 clinet side fir final response.
}


*/
