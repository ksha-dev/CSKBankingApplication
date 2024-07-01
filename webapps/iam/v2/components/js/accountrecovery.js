//$Id$
var isCountrySelected = false;
var yubname;
var ppValidator;
var hip_required;
var primary_factor_otp_threshold = 4;
var MFA_otp_threshold = 4;
var resendcheck = undefined;
var first_otp_sent = false;
var prev_TFA_option;

function onRecoveryReady()
{
	$("input:not(:radio)").val(""); //No I18N
	$(".real_radiobtn").prop('checked', false);
	clear_user_info();
	$("#login_id").attr("disabled", false);
    $(".recover_sections").removeClass("allowed_mode");
	login_id= login_id != "" ? login_id : undefined;
	contact_support_email=undefined;
	zuid=undefined;
	signin_redirect_url=undefined;
	recovery_modes=undefined;
    mfa_modes=undefined;
    device_recovery_state=undefined;
    restrict_trust_mfa=undefined;
    qrtempId=undefined;
    trust_mfa_days=undefined;
    is_recovery_extra_modes=false;
    digest=undefined;
    password_policy=undefined;
    mfa_modes=undefined;
    mzadevicepos =  0;
    clearInterval(_time);
    wmscount =0;
    verifyCount = 0;
    org_name=undefined;
    org_contact=undefined;
    contactAdminHelpDoc = "";
    totalCount = 0;
    isWmsRegistered=false;
    wmscallmode,wmscallapp,wmscallid=undefined;
    reload_page ="";
    token = "";
    
    type = 0;
    audio_timer=undefined;
    captchaType = "";
    zlabs_captcha_params = "";
	zlabsCaptchaObj = null;


    if(isValid(reqCountry))
	{
      	reqCountry= isPhoneNumber(login_id && login_id.split("-")[1]) ? $("#country_code_select  option[value = " + "'+" + login_id.split("-")[0] + "']").attr("id").toUpperCase() : reqCountry.toUpperCase() ;
      	$('#country_code_select option:selected').removeAttr('selected');
      	$("#country_code_select #"+reqCountry).prop('selected', true);
      	$("#country_code_select #"+reqCountry).trigger('change');
    }
	
	if(isValid(login_id)	&&	(isUserName(login_id) || isEmailId(login_id) || isPhoneNumber(login_id.split('-')[1])))
	{
		login_id= isPhoneNumber(login_id.split("-")[1]) ? login_id.split("-")[1] : login_id;
		$("#login_id").val(login_id);
	}
	
	$(".select_country_code").text($("#country_code_select").val());
	if(!isMobile && isEmpty(digest_id)){
		renderUV("#country_code_select", true, "#login_id", "left", "flagIcons", true, true, "country_implement", undefined, "data-num", "value", "data-num");//no i18n
		$(".select_container--country_implement").hide();
		uvselect.setIntentForCntyCode("country_code_select"); //no i18N 
	}else if(isMobile){
		mobileflag();
	}
    $("#select2-country_code_select-container").html($("#country_code_select").val());
    $("#country_code_select").change(function()
    {
      $(".country_code").html($("#country_code_select").val());
    });
    hideGif();
    $("#login_id").focus();
    
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
	mobileflag();
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
        input_checking();
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

function showTopNotification(msg)
{
	$(".alert_message").html(msg);
	$(".Alert").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Alert").css("top","-150px")},5000);
}

function showTopErrNotification(msg)
{
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Errormsg").css("top","-150px")},5000);
}


function clearCommonError(field)
{
	var container=field+"_container";//no i18N
	$("#"+field).removeClass("errorborder");
	$("#"+field).nextAll(".fielderror").slideUp(100);
	$("#"+field).nextAll(".fielderror").removeClass("errorlabel");
	$("#"+field).nextAll(".fielderror").text("");
}

function input_checking()
{
	var a=$("#login_id").val().trim();
	var check=/^(?:[0-9] ?){0,1000}[0-9]$/.test(a);
	$(".select2-selection--single").attr("tabindex","-1");//no i18N
	if(!isCountrySelected)
	{
		var reqUrl = "/accounts/public/api/locate"; // no i18n
		callRequestWithCallback(reqUrl,"",true,handleRequestCountryCode, undefined, false); // no i18n
		isCountrySelected = true;
	}
	if((check==true)&&(a))
	{
		try{
			$(".select_container_cntry_code").show();
			//$(".select_container_cntry_code ~ input").attr("style","text-indent:105px !important");//no i18N
			if(isMobile)
			{
				$(".MobflagContainer").show()
		  		$('.select_country_code,#country_code_select').show();
		  		$("#login_id").addClass("textindent62");
		  	}else{
				uvselect.setIntentForCntyCode("country_code_select"); //no i18N  
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
		$(".MobflagContainer").hide();
		$('#country_code_select').hide();
		$('.select_country_code,#country_code_select,.select2').hide();
		$(".select_container_cntry_code").hide();
		if(!isMobile){
			uvselect.setIntentForCntyCode("country_code_select"); //no i18N 
			uvselect.setIntentForCntyCode("country_code_select"); //no i18N
		}
		//$(".select_container_cntry_code ~ input").attr("style","text-indent:10px");//no i18n
		$("#login_id").removeClass("textindent62");
		if($("#login_id").hasClass("placedHolder")){
			destroyPlaceholderPattern(document.login_id_container.countryselect, $("#login_id").val(), "#login_id"); //no i18n
		}
	}
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

function isUserName(str) {
	if(!str) {
        return false;
    }
	var objRegExp = new XRegExp("^[\\p{L}\\p{N}\\p{M}\\_\\.\\']+$","i"); // No I18N
    return XRegExp.test(str.trim(), objRegExp);
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

function IsJsonString(str) {
	try {
		$.parseJSON(str);
	} catch (e) {
		return false;
	}
	return true;
}


//Error

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



//lookup


function accountLookup(e)
{
	e.preventDefault();
	removeCaptchaError('captcha');//no i18n
	if(!$("#captcha_container").is(":visible") &&  !$("#zlabs_captcha_container").is(":visible"))	//if captcha is not visible then it is simple lookup call
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
		if((!isUserName(LOGIN_ID) && !isEmailId(LOGIN_ID))	&&	(!isPhoneNumber(LOGIN_ID.split("-")[1]?LOGIN_ID.split("-")[1]:LOGIN_ID.split("-")[0])) || isPhoneNumber(LOGIN_ID.split('-')[1]) && LOGIN_ID.split('-')[0].includes("+")) {
			showCommonError("login_id",I18N.get("IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER"));//no i18n
			return false;
		}
		
		$("#nextbtn span").addClass("zeroheight");
		$("#nextbtn").addClass('changeloadbtn');
		$("#nextbtn").attr("disabled", true);
		LOGIN_ID = ( isPhoneNumber(LOGIN_ID) ) ? $( "#country_code_select" ).val().split("+")[1]+'-'+LOGIN_ID : LOGIN_ID;
		LOGIN_ID = isPhoneNumber(LOGIN_ID.split('-')[1]) ? LOGIN_ID.split('-')[0].trim() + "-" + LOGIN_ID.split('-')[1].trim() : LOGIN_ID;
		var lookup_url = recoveryUri + "/v2/lookup/"+LOGIN_ID+"?mode=primary"; //no i18N
		callRequestWithCallback(lookup_url, "" ,true, handleLookupDetails);//No I18N
	}
	else
	{
		removeCaptchaError();
		var captcha_verify_url,params;
		if ($("#zlabs_captcha_container").is(":visible")) 
		{
			captcha_verify_url=submit_zlabs_capctha(recoveryUri);
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
		if( !(/^[a-zA-Z0-9]*$/.test( captchavalue )) || captchavalue.length<6) {
			showCommonError("captcha",I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.INVALID"));//no i18n
			return false;
		}
			$("#nextbtn span").addClass("zeroheight");
			$("#nextbtn").addClass('changeloadbtn');
			$("#nextbtn").attr("disabled", true);
			var captcha_verify_url = recoveryUri + "/v2/lookup/"+login_id+"/captcha"; //no i18N
			var params = "captcha=" + captchavalue + "&cdigest=" + cdigest + "&token=" + token; //no i18N
		}
		callRequestWithCallback(captcha_verify_url, params ,true, handleRecoveryDetails);

	}
	return false;
}

function update_user_info(user_id)
{
	var login_info = login_id!=undefined ? login_id : user_id ;
	$(".user_info .menutext").text(identifyEmailOrNum(login_info));
	$(".user_info").show();
}

function identifyEmailOrNum(login_id){
	if(isValid(login_id)){
		var userLogin = login_id;
		if(isPhoneNumber(userLogin.split('-')[1])){
			return "+"+userLogin.split('-')[0]+" "+userLogin.split('-')[1];
		}else{
			return userLogin;
		}
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
	MFA_otp_threshold = 4;
	resendcheck = undefined;
    var uID = $(event.target).parent().find(".menutext").text();
    var country_code = "";
    isValid(uID)?"":uID= $("#login_id").val().trim();
    if(isPhoneNumber(uID.split(" ")[1])){
    	if(uID[0]=="+"){uID = uID.slice(1,uID.length)}
    	country_code = uID.split(" ")[0];
    	uID = uID.split(" ")[1];
    	isCountrySelected = true;
    }
    if($("#zlabs_captcha_container").is(":visible")		&&		$(".audio").hasClass("play_motion"))
	{
		zlabsCaptchaObj.sound.pause();
		$(".audio_bar").removeClass("audio_animation");
		$(".audio").removeClass("play_motion");
	}

	onRecoveryReady();
	
	clear_user_info();
	
	$("#zlabs_captcha_container").removeClass("no_restriction_error");
	
	$("#login_id_container").show();
	$("#lookup_div .head_info").show();
	$(".recover_sections").hide();
	$("#captcha_container").hide();
	
	$(".lookup_head").show();
	$(".capatcha_head").hide();
	$("#zlabs_captcha_container").hide();
	$("#lookup_div #nextbtn").show();
	$(".shine_cover").removeClass("shine");
	$(".Z_captcha_result_container, .Z_captcha_error_container").hide();
	$(".Captcha_btns").show();
	$(".succ_icon").removeClass("success_animation");
	$(".Z_captcha_result_container").removeClass("Z_captcha_noHeaddesc");

	
	
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
	clear_allerrors();
	removeCaptchaError();
	hip_required=false;
	//$(".recover_sections").removeClass("allowed_mode");
}

function fetchLookupDetails(loginID)
{
	var lookup_url;
	if(digest_id.length>0){		
		lookup_url = recoveryUri + "/v2/lookup/"+digest_id+"?mode=digest"; //no i18N
	}
	else{
		$("#login_id").val(isPhoneNumber(login_id.split("-")[1]) ? login_id.split("-")[1] : login_id);
		lookup_url = recoveryUri + "/v2/lookup/"+loginID+"?mode=primary"; //no i18N
	}
	callRequestWithCallback(lookup_url, "" ,true, handleLookupDetails);//No I18N
	return false;
}

function handleLookupDetails(resp)
{
	$(".recovery_container").css("visibility","visible");
	hideCommonLoader();
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			zuid = jsonStr.lookup.identifier;
			if(digest_id.length>0 && jsonStr.lookup.token==undefined)// if new token is preset then its a new request
			{
				$("#nextbtn span").removeClass("zeroheight");
				$("#nextbtn").removeClass("changeloadbtn");
				$("#nextbtn").attr("disabled", false);
				
				
				head_token = jsonStr.lookup.jwt;
				serviceName = jsonStr.lookup.service_name;
				serviceUrl = jsonStr.lookup.service_url;
				aCParams = "servicename=" + euc(serviceName) +"&serviceurl="+euc(serviceUrl);	//no i18n
				var orgDetails = jsonStr.lookup.org_details;
				if(orgDetails != undefined) {
					org_name = orgDetails.org_name;
					org_contact = orgDetails.org_contact;
					contactAdminHelpDoc = orgDetails.doc_link;
					$(".org_admin_content").text(I18N.get("IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE"));
				}else{$(".org_admin_content").text(I18N.get("IAM.NEW.SIGNIN.CONTACT.SUPPORT"))}
				if(jsonStr.lookup.pwdpolicy){
					password_policy = jsonStr.lookup.pwdpolicy;
					show_reset_password();
				}
				else if(jsonStr.lookup.modes){
					mfa_modes = jsonStr.lookup.modes;
					initialize_MFAModes();
				}
				update_user_info(jsonStr.lookup.loginid);
			}
			else{	
					login_id=jsonStr.lookup.loginid;
					token = jsonStr.lookup.token;
	
					//changeHip("captcha_img","captcha");//no i18n
					//$("#captcha_container").show();
					if(!isClientPortal	&&	ZlabsCapthca_enabled)//when zlabs capctha is enabled for client portal we can remove and just call showZLabsCaptcha();
					{
						showZLabsCaptcha(false,true,false);
					}
					else
					{
						$("#nextbtn span").removeClass("zeroheight");
						$("#nextbtn").removeClass("changeloadbtn");
						$("#nextbtn").attr("disabled", false);
						
						
						changeHip("captcha_img","captcha");//no i18n
						$("#captcha_container").show();
						$("#lookup_div .head_info").hide();
						update_user_info();
						$("#login_id_container").hide();
						/* this case we show loading gif on entire page. loading gif hide function(hideCommonLoader) took some time to hide that gif so we should add delay to focus function */ 
						setTimeout(function(){$("#captcha_container #captcha")[0].focus();},150);
						$("#login_id").attr("disabled", true);
	
					}
			}
		}
		else
		{
			$("#nextbtn span").removeClass("zeroheight");
			$("#nextbtn").removeClass("changeloadbtn");
			$("#nextbtn").attr("disabled", false);
			
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("login_id",jsonStr.localized_message);//no i18n
				return false;
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
			if(errorCode === "U400" || errorCode === "U301")//no i18N
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
			else if(errorCode == "IN108"){
				hip_required=true;
				login_id=$('#login_id').val();
				login_id=  isPhoneNumber(login_id) ?  $("#country_code_select").val().split("+")[1] + '-' + login_id : login_id ;
				token=JSON.parse(resp).token;
				$(".user_info > .menutext").text(login_id);
				$(".user_info").show();
				
				
				//changeHip("captcha_img","captcha");//No i18N
				//$("#captcha_container").show();
				
				$(".lookup_head").hide();
				$(".capatcha_head").show();
				
				if(!isClientPortal	&&	ZlabsCapthca_enabled)//when zlabs capctha is enabled for client portal we can remove and just call showZLabsCaptcha();
				{
					
					$("#lookup_div #nextbtn").hide();
					showZLabsCaptcha();
					setFooterPosition();//chnage foorter postion if needed
				}
				else
				{
					$("#nextbtn span").removeClass("zeroheight");
					$("#nextbtn").removeClass("changeloadbtn");
					$("#nextbtn").attr("disabled", false);
					
					changeHip("captcha_img","captcha");//no i18n
					$("#captcha_container").show();
					$("#lookup_div .head_info").hide();
					update_user_info();
					$("#login_id_container").hide();
					/* this case we show loading gif on entire page. loading gif hide function(hideCommonLoader) took some time to hide that gif so we should add delay to focus function */ 
					setTimeout(function(){$("#captcha_container #captcha").focus();},150);
					$("#login_id").attr("disabled", true);

				}
				
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
		$("#nextbtn span").removeClass("zeroheight");
		$("#nextbtn").removeClass("changeloadbtn");
		$("#nextbtn").attr("disabled", false);
		
		showCommonError("login_id",I18N.get("IAM.ERROR.GENERAL"));//no i18n
	}
	return false;
}



function show_captcha(is_zlabs_capctha)
{
		if(is_zlabs_capctha)
		{
			$("#zlabs_captcha_container").show();
			$("#lookup_div #nextbtn, .lookup_head").hide();
			$(".capatcha_head").show();
		}
		$("#nextbtn span").removeClass("zeroheight");
		$("#nextbtn").removeClass("changeloadbtn");
		$("#nextbtn").attr("disabled", false);
		
		$("#lookup_div .lookup_head .head_info").hide();
		update_user_info();
		$("#login_id_container").hide();
		$("#captcha_container #captcha").focus();
		$("#login_id").attr("disabled", true);
}



function Refresh()
{
	window.location.reload();
	//window.location.href=location.href
}

function backToLookup(){
	var redirectURL = window.location.href.split("?")[0];
	window.location = getACParms() != "" ?  redirectURL +"?"+ getACParms() : redirectURL;
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
	 var captcha_resp = isValid(cdigest) ? doGet(uriPrefix + '/webclient/v1/captcha/'+cdigest,"darkmode="+Boolean(isDarkMode)) : "";//no i18n
	 if(IsJsonString(captcha_resp)) {
		 captcha_resp = JSON.parse(captcha_resp);
	 }
	 var captchimgsrc = captcha_resp.cause==="throttles_limit_exceeded" || !isValid(cdigest) ? "../images/hiperror.gif": captcha_resp.captcha.image_bytes;//no i18N
	 cImg = isValid(cImg) ? cImg : "captcha_img"; //No I18N
	 de("captcha").value = '';//no i18n
	 var hipRow = de(cImg); //No I18N
	 var captchaImgEle = document.createElement("img");
	 captchaImgEle.setAttribute("name", "hipImg");
	 captchaImgEle.setAttribute("id", "hip");
	 $('.reloadcaptcha').attr("title", I18N.get("IAM.NEW.SIGNIN.TITLE.RANDOM"));
	 captchaImgEle.setAttribute("align", "left");
	 captchaImgEle.setAttribute("src", captchimgsrc);
	 if(!isMobile && !isDarkMode){ $(captchaImgEle).css("mix-blend-mode","multiply");}//no i18N
	 $(hipRow).html(captchaImgEle);
}

function handleChangeHip(resp)
{
	if(IsJsonString(resp)) {
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if(jsonStr.cause==="throttles_limit_exceeded"){ // unreachable
			cdigest = '';
			showHip(cdigest); //no i18N 
			showCaptcha(I18N.get("IAM.NEXT"),false);;//no i18N
			return false;
		}
		cdigest = jsonStr.digest;
	}
	return false;
}


function lookToForgotPassword(jsonStr,statusCode){
	$("#login_id").val("");
	$("#captcha").val("");
	
	head_token=jsonStr.captchaverificationauth[0].jwt;
	$("#lookup_div").hide();
	recovery_modes=jsonStr.captchaverificationauth[0].modes;
	if(jsonStr.captchaverificationauth[0].org_details!=undefined)
	{
		org_name=jsonStr.captchaverificationauth[0].org_details.org_name;
		org_contact=jsonStr.captchaverificationauth[0].org_details.org_contact;
		contactAdminHelpDoc=jsonStr.captchaverificationauth[0].org_details.doc_link;
		$(".org_admin_content").text(I18N.get("IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE"));
	}else{$(".org_admin_content").text(I18N.get("IAM.NEW.SIGNIN.CONTACT.SUPPORT"))}
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
			if ($("#zlabs_captcha_container").is(":visible")) 
			{
				$("#zlabs_captcha_container").removeClass("height_set");
				$(".img, .audio, .Captcha_btns").slideUp();
				$(".Z_captcha_result_container").slideDown(function()
				{
					$(".succ_icon").addClass("success_animation");
				});
				
				$(".ZCaptcha_desc div").hide();
				$(".Z_captcha_result_container").addClass("Z_captcha_noHeaddesc");
				
				setTimeout(function(){
					$(".shine_cover").removeClass("shine");
					$(".succ_icon").removeClass("success_animation");
					$(".Z_captcha_result_container").hide();
					$(".Captcha_btns").show();
					lookToForgotPassword(jsonStr,statusCode);
				},3000);//set time out for css animation to end
			}
			else
			{
				lookToForgotPassword(jsonStr,statusCode);
			}

		}
		else if(	jsonStr.errors!=undefined && (jsonStr.errors[0].code=="SI502"	||	jsonStr.errors[0].code=="AR103"))//custom sso auth restriction
		{
			if ($("#zlabs_captcha_container").is(":visible")) 
			{
				
					$("#zlabs_captcha_container").removeClass("height_set");
					$(".ZCaptcha_desc div").hide();
					$("#captcha").blur();
					$("#captcha_container").addClass("margin_for_captcha_errors");
					
					$(".capatcha_head").hide();
					$("#zlabs_captcha_container").addClass("no_restriction_error");
					
					$(".Z_captcha_error_container .Z_captcha_reject_header").html($("#lookup_err_div #headtitle").html());//removing the a tag and keeping it separate
					$(".Z_captcha_reject_header").show();
					$(".Z_captcha_error_container .Z_captcha_error_msg").html(jsonStr.localized_message);//removing the a tag and keeping it separate
					$("#try_signin").css("display","hide");
					
					$(".img, .audio, .Captcha_btns").slideUp();
					$(".Z_captcha_error_container").slideDown();
			}
			else
			{
				$("#lookup_err_div .head_info").html(jsonStr.localized_message);
				if($("#lookup_err_div .head_info span").length)// check if we have an contact email id avaible
				{
					$("#lookup_err_div .head_info span").css({"color":"#000000e6","margin-top":"20px","display":"inline-block"})
				}
				$("#lookup_div").hide();
				$("#lookup_err_div").show();
			}
			
			
		}
		else if(jsonStr.cause==="throttles_limit_exceeded")
		{
			if ($("#zlabs_captcha_container").is(":visible")) 
			{
				$("#zlabs_captcha_container").removeClass("height_set");
				$(".Z_captcha_error_container .Z_captcha_error_msg").html(jsonStr.localized_message);
				$(".ZCaptcha_desc div").hide();
				$(".img, .audio, .Captcha_btns").slideUp();
				$(".Z_captcha_error_container").slideDown();
				return false;
			}
				$("#captcha").blur();
			    $("#captcha_container").addClass("margin_for_captcha_errors");
				$("#captcha_container + .captchafielderror").addClass("commonErrorlabelForCaptcha").html(jsonStr.localized_message).slideDown(200);
		}
		else if(jsonStr.errors[0].code == 'U400' || jsonStr.errors[0].code == 'U301'){//No I18Nn //dc switch
			handleLookupDetails(resp);
		}
		else if(jsonStr.errors[0].code == 'U401'){ //No I18N //user not exists
			change_user(jsonStr.localized_message);
			$("#login_id_container .fielderror").html(jsonStr.localized_message).addClass("errorlabel").show();
		}
		else if(jsonStr.errors[0].code == 'IN107'){ //invalid captcha
			if (!$("#zlabs_captcha_container").is(":visible")) 
			{
				$('.reloadcaptcha').click();
				showCommonError("captcha",jsonStr.localized_message);//no i18n
			}
			else
			{
				setTimeout(function(){
					$(".shine_cover").removeClass("shine");
					showZcaptchaError(jsonStr.localized_message,true);
				},800);//set time out for css animation to end
				
			}
		}
		else
		{
			//policy errors
			$("#captcha").blur();
			$("#captcha_container").addClass("margin_for_captcha_errors");
			if ($("#zlabs_captcha_container").is(":visible")) 
			{
				$("#zlabs_captcha_container").removeClass("height_set");
				$(".ZCaptcha_desc div").hide();
				$(".Z_captcha_error_container .Z_captcha_error_msg").html(jsonStr.localized_message);
				$(".img, .audio, .Captcha_btns").slideUp();
				$(".Z_captcha_error_container").slideDown();
				return false;
			}
			$("#captcha_container + .captchafielderror").addClass("commonErrorlabelForCaptcha").html(jsonStr.localized_message).slideDown(200);
		}
	}
	else 
	{
		if ($("#zlabs_captcha_container").is(":visible")) 
		{
			$(".ZCaptcha_desc div").hide();
			$("#zlabs_captcha_container").removeClass("height_set");
			$(".Z_captcha_error_container .Z_captcha_error_msg").html(I18N.get("IAM.ERROR.GENERAL"));
			$(".img, .audio, .Captcha_btns").slideUp();
			$(".Z_captcha_error_container").slideDown();
		}
		else
		{
			showCommonError("captcha",I18N.get("IAM.ERROR.GENERAL"));//no i18n
		}
	}
	return false;
	
}

function removeCaptchaError(){
	//only for captcha block outside errors
	$("#captcha_container").removeClass("margin_for_captcha_errors");
	$("#captcha_container + .captchafielderror").removeClass("commonErrorlabelForCaptcha").text("").slideUp(200);
}

function showHidePassword(password_field)
{
	 if(password_field==undefined)
	 {
		 password_field="last_password";//no i18n
	 }
	 var passType = $("#"+password_field).attr("type");//no i18n
	 var index = $("#"+password_field)[0].selectionStart;
	 if(passType==="password")
	 {
		$("#"+password_field).attr("type","text");//no i18n
		$("#"+password_field +"+ .show_hide_password").addClass("icon-show");
	 }
	 else
	 {
		$("#"+password_field).attr("type","password");//no i18n
		$("#"+password_field +"+ .show_hide_password").removeClass("icon-show");
	 }
	 $("#"+password_field).focus();
	 $("#"+password_field)[0].setSelectionRange(index,index);
}


function last_pwd_ckeck()
{
	var PASSWORD = $("#last_password").val();
	if(!isValid(PASSWORD)) 
	{
		showCommonError("last_password",I18N.get("IAM.ERROR.ENTER_PASS")); //no i18n
		return false;
	}
	else if(PASSWORD.length>=250)
	{
		showCommonError("last_password",I18N.get("IAM.AC.RECOVER.OLD_PASSWORD.ERROR.DESCRIPTION.TOO.LONG")); //no i18n
		return false;
	}
	$("#last_pwd_submit span").addClass("zeroheight");
	$("#last_pwd_submit").addClass('changeloadbtn');
	$("#last_pwd_submit").attr("disabled", true);
	
	var pwd_verify_url = recoveryUri + "/v2/primary/"+zuid+"/password"; //no i18N
	pwd_verify_url+="?cli_time=" + new Date().getTime();//no i18N
	//pwd_verify_url += "digest="+digest;//no i18n
	
	encryptData.encrypt([PASSWORD]).then(function(encryptedpassword) {
		encryptedpassword =  typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
		var jsonData = { 'passwordrecoveryauth': { 'password': encryptedpassword } };//no i18n
		callRequestWithCallback(pwd_verify_url, JSON.stringify(jsonData), true, handleLastPasswordDetails, undefined, true);
		return false;
	}).catch(function(error) {
		showCommonError("last_password", I18N.get("IAM.ERROR.GENERAL")) //no i18N
	});
	return false;
}

function handleLastPasswordDetails(resp)
{
	$("#last_pwd_submit span").removeClass("zeroheight");
	$("#last_pwd_submit").removeClass("changeloadbtn");
	$("#last_pwd_submit").attr("disabled", false);
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			$("#last_password").val("");
			
			
			if(jsonStr.passwordrecoveryauth.status=="failure")//correct password entered redirecting him to login page
			{
				initialize_recoveryModes();
				return false;
			}
			else //correct password entered redirecting him to login page
			{
				//signin_redirect_url=jsonStr.passwordrecoveryauth.redirect_uri;
				$(".recover_sections").hide();
				$("#password_matched_div").show();
				return false;
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError("last_password",jsonStr.localized_message);//no i18n
				return;
			}
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			showCommonError("last_password",errorMessage);//No I18N
		}
	}
	else 
	{
		showCommonError("last_password",I18N.get("IAM.ERROR.GENERAL"));//No I18N

	}
	return false;
}

function last_pwd_redirect(option)
{
	if(!isValid(option)	||	!(option=="fp"	|| option=="signin")	) 
	{
		showTopErrNotification(I18N.get("IAM.AC.ERROR.REFRESH.OPTION"));
		return false;
	}
	if(option=="fp")
	{
		initialize_recoveryModes();
		return false;
	}
	$("#last_pwd_audit span").addClass("zeroheight");
	$("#last_pwd_audit").addClass('changeloadbtn');
	$("#last_pwd_audit").attr("disabled", true);
	var last_pwd_stats_url = recoveryUri + "/v2/primary/"+zuid+"/rsignin"; //no i18N
	var jsonData = {'recoverysigninauth':{'option':option }};//no i18n
	callRequestWithCallback(last_pwd_stats_url,JSON.stringify(jsonData),true,last_pwd_response,undefined,true);
	return false;
	
}

function last_pwd_response(resp)
{
	
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			if(isValid(jsonStr.recoverysigninauth.redirect_uri))	//signin option selected
			{
				switchto(jsonStr.recoverysigninauth.redirect_uri);
				return false;
			}
			else //password rest option
			{
				initialize_recoveryModes();
				$("#last_pwd_audit span").removeClass("zeroheight");
				$("#last_pwd_audit").removeClass("changeloadbtn");
				$("#last_pwd_audit").attr("disabled", false);
				return false;
			}
		}
		else
		{
			var error_resp = jsonStr.errors[0];
			var errorCode=error_resp.code;
			var errorMessage = jsonStr.localized_message;
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(errorMessage);
				$("#last_pwd_audit span").removeClass("zeroheight");
				$("#last_pwd_audit").removeClass("changeloadbtn");
				$("#last_pwd_audit").attr("disabled", false);
				return false;
			}
			else if(errorCode=="SI505") //signin blocked due to multiple tries
			{
				$(".recover_sections,.service_logo").hide();
				$(".error_header_container .error_header").hide();
				$(".error_header_container .error_SI505").show();
				$(".error_portion .error_desc").addClass("red_text");
				$(".error_portion .error_desc").html(errorMessage);
				$(".error_portion .domain_wait_warn").hide();
				$(".error_portion .bottom_option").hide();
				$(".error_portion #try_again").show();
				$(".error_portion").show();
				return false;
			}
			showTopErrNotification(errorMessage);
		}
	}
	else 
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	}
	$("#last_pwd_audit span").removeClass("zeroheight");
	$("#last_pwd_audit").removeClass("changeloadbtn");
	$("#last_pwd_audit").attr("disabled", false);
	return false;
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
		if( recovery_modes.allowed_modes.indexOf("passkey") == -1 ){
			$("#recovery_usernamescreen_bk").css("display","block");
			$("#recovery_usernamescreen_bk").attr("onclick","show_confirm_username_screen()");
			if(!is_recovery_extra_modes){
				is_recovery_extra_modes=false;
				only_usernameoption=true;
			}
		}
		else{		
			$("#recovery_usernamescreen_bk").hide();
			if(!is_recovery_extra_modes){
				is_recovery_extra_modes=false;
			}
			if(recovery_modes.lookup_id.data[0].email){
				recovery_modes.lookup_id.data[0].isLookupId = true;
				if(recovery_modes.email == undefined){
					recovery_modes.allowed_modes.push("email");
					recovery_modes.email={};
					recovery_modes.email.data=[];
					recovery_modes.email.count=0;
				}
				recovery_modes.email.data.push(recovery_modes.lookup_id.data[0]);
				recovery_modes.email.count=recovery_modes.email.count+1;
			}
			else if(recovery_modes.lookup_id.data[0].r_mobile){
				recovery_modes.lookup_id.data[0].isLookupId = true;
				recovery_modes.lookup_id.data[0].r_mobile = $("#recovery_user_info .menutext")[0].innerText;
				if(recovery_modes.otp == undefined){
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
			if(modes.indexOf("lookup_id") != -1 && modes.indexOf("passkey") == -1)
			{
				show_confirm_username_screen();
				$("#recovery_usernamescreen_bk").show();
			}
			else
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
	//$("#recovery_domian_div #choose_domain_verification_type").show();
	
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
	
	var domain_verify_url = recoveryUri + "/v2/primary/"+zuid+"/domain/"+domain_enc; //no i18N
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
	
	var domain_verify_url = recoveryUri + "/v2/primary/"+zuid+"/domain/"+domain_enc; //no i18N
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

function initPasskeyOption(){
	var passkeyUrl = recoveryUri+"/v2/primary/"+zuid+"/passkey/self";	//no i18N
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
	return false;
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
				password_policy=jsonStr[resource_name].pwdpolicy
				show_reset_password();
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

function show_other_options()
{
	first_otp_sent=false;
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
		encryptData.encrypt([recovery_modes.lookup_id.data[0].email]).then(function(encryptedloginid) {
			encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
			var email_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mail/"+recovery_modes.lookup_id.data[0].e_email; //no i18N
			var jsonData = {'emailrecoveryauth':{'email_id':encryptedloginid }};//no i18n
			callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleUsernameConfirm,undefined,true);
			return false;
		});

	}
	else
	{
		encryptData.encrypt([recovery_modes.lookup_id.data[0].r_mobile]).then(function(encryptedloginid) {
			encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
			var mobile_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mobile/"+recovery_modes.lookup_id.data[0].e_mobile; //no i18N
			var jsonData = {'mobilerecoveryauth':{'mobile':encryptedloginid }};//no i18n
			callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleUsernameConfirm,undefined,true);
			return false;
		});

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
				var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) : formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
				showTopNotification(formatMessage(I18N.get(otpsentmsg)));
				first_otp_sent=true;
				$("#confirm_otp_div form").attr("onsubmit","username_confimation_action();return false;");
				show_recusernameScreen();
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

function resendotp_checking(id)
{
	var resendtiming = 60;
	clearInterval(resendTimer);
	$('#'+id+' .resendotp').addClass('nonclickelem');
	$('#'+id+' .resendotp span').text(resendtiming);
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
	if($("#otp_confirm_submit").attr("disabled") != undefined){
		return false;
	}
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
		var email_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mail/"+recovery_modes.lookup_id.data[0].e_email; //no i18N
		var jsonData = {'emailrecoveryauth':{'code':otp_confirm , "mdigest":mdigest }};//no i18n
		
		callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
	}
	else
	{
		var mobile_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mobile/"+recovery_modes.lookup_id.data[0].e_mobile; //no i18N
		var jsonData = {'mobilerecoveryauth':{'code':otp_confirm}};//no i18n
		
		callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
	}

	return false;
}

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
		if(rec_emails.data[0].isLookupId){
			show_recovery_email_confirmationscreen(rec_emails.data[0],true);
		}
		else{
			show_recovery_email_confirmationscreen(rec_emails.data[0]);
		}
	}
	else
	{
		$("#select_reocvery_email .head_info").html(formatMessage(I18N.get("IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION.MULTI"),rec_emails.count.toString()));
		$("#select_reocvery_email .fieldcontainer").html("");
		
		var email_verify_template=$(".empty_email_template").html();;
		for(var i=0;i<rec_emails.count;i++)
		{
			$("#select_reocvery_email .fieldcontainer").append(email_verify_template);
			$("#select_reocvery_email .fieldcontainer #recovery_email").attr("id","recovery_email"+i);
			$("#select_reocvery_email .fieldcontainer #recovery_email"+i+" .option_title_try").html(rec_emails.data[i].email)
			if(rec_emails.data[i].isLookupId){
				$("#select_reocvery_email .fieldcontainer #recovery_email"+i).attr("onclick","show_recovery_email_confirmationscreen("+JSON.stringify(rec_emails.data[i])+",true);");	//no i18N
			}else{				
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
	
	if(isLookupId){
		$("#email_confirm").val(enc_email);
		email_confirmation(isLookupId);
		
	}
	else{
		$("#email_confirm_div,#email_confirm_div #confirm_reocvery_email").show();
		$("#email_confirm").focus();
	}
}

function email_confirmation(isLookupId)
{
	
	var email_confirm = $("#email_confirm").val();
	if(!isValid(email_confirm)	||	!isEmailId(email_confirm))
	{
		showCommonError("email_confirm",I18N.get("IAM.AC.CONFIRM.EMAIL.VALID"));//no i18n
		return false;
	}
	$("#emailconfirm_action span").addClass("zeroheight");
	$("#emailconfirm_action").addClass("changeloadbtn");
	$("#emailconfirm_action").attr("disabled", true);
	
	
	encryptData.encrypt([email_confirm]).then(function(encryptedloginid) {
		encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var email_enc=$("#confirm_reocvery_email .fieldcontainer #selected_encrypt_email").val();
		var email_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mail/"+email_enc; //no i18N
		var jsonData = {'emailrecoveryauth':{'email_id':encryptedloginid }};//no i18n
		callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,function(resp){
			handleEmailConfirm(resp,isLookupId);
		},undefined,true);
		return false;
	});
	
	
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
			resendcheck = undefined;
			resendotp_checking("confirm_otp_div");//no i18n
			var otpsentmsg = first_otp_sent ? formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT.RESEND"),decrypt) : formatMessage(I18N.get("IAM.NEW.SIGNIN.OTP.SENT"),decrypt);
			showTopNotification(formatMessage(I18N.get(otpsentmsg)));
			first_otp_sent=true;
			$("#confirm_otp_div form").attr("onsubmit","rec_email_confimation_action();return false;");
			show_recusernameScreen("email");//no i18n
			if(isLookupId){
				$("#confirm_otp_div .only_two_recmodes").attr("onclick",recovery_modes.email.count==1?'show_other_options()':'show_recEmailScreen()');
				$("#confirm_otp_div #otp_resend").attr("onclick","email_confirmation(true)");
			}
			else{
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
	
	var email_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mail/"+e_email; //no i18N
	var jsonData = {'emailrecoveryauth':{'code':otp_confirm}};//no i18n
	
	callRequestWithCallback(email_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
}


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
	if(rec_mobs.count==1){
		if(rec_mobs.data[0].isLookupId){
			show_recovery_mobilenum_confirmationscreen(rec_mobs.data[0],true);
		}
		else{
			show_recovery_mobilenum_confirmationscreen(rec_mobs.data[0]);
		}
	}
	else
	{
		$("#select_reocvery_mobile .head_info").html(formatMessage(I18N.get("IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI"),rec_mobs.count.toString()));
		$("#select_reocvery_mobile .fieldcontainer").html("");
		
		var mobile_verify_template=$(".empty_mobile_template").html();;
		for(var i=0;i<rec_mobs.count;i++)
		{
			$("#select_reocvery_mobile .fieldcontainer").append(mobile_verify_template);
			$("#select_reocvery_mobile .fieldcontainer #recovery_mob").attr("id","recovery_mob"+i);
			$("#select_reocvery_mobile .fieldcontainer #recovery_mob"+i+" .option_title_try").html(rec_mobs.data[i].r_mobile)
			if(rec_mobs.data[i].isLookupId){
				$("#select_reocvery_mobile .fieldcontainer #recovery_mob"+i).attr("onclick","show_recovery_mobilenum_confirmationscreen("+JSON.stringify(rec_mobs.data[i])+",true);");	//no i18N
			}else{				
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
	if(isLookupId){
		$("#mobile_confirm").val(enc_mobile.split('-')[1]);
		mobile_confirmation(isLookupId);
	}
	else{
		$("#mobile_confirm_div,#mobile_confirm_div #confirm_reocvery_mobile").show();
		$("#mobile_confirm").focus();
	}
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
	
	encryptData.encrypt([mobile_confirm]).then(function(encryptedloginid) {
		encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var mobile_enc=$("#confirm_reocvery_mobile .fieldcontainer #selected_encrypt_mobile").val();
		var mobile_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mobile/"+mobile_enc; //no i18N
		var jsonData = {'mobilerecoveryauth':{'mobile':encryptedloginid }};//no i18n
		callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,function(resp){
			handleMobileConfirm(resp,isLookupId);
		},undefined,true);
		
		return false;
	});
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
		if(primary_factor_otp_threshold >= 1 ){
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
				$("#confirm_otp_div form").attr("onsubmit","rec_mobile_confimation_action();return false;");
				show_recusernameScreen("otp");//no i18n
				if(isLookupId){
					$("#confirm_otp_div .only_two_recmodes").attr("onclick",recovery_modes.otp.count==1?'show_other_options()':'show_recMobScreen()');
					$("#confirm_otp_div #otp_resend").attr("onclick","mobile_confirmation(true)");
				}
				else{
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
	if($("#otp_confirm_submit").attr("disabled") != undefined){
		return false;
	}
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
	
	var mobile_verify_url = recoveryUri + "/v2/primary/"+zuid+"/mobile/"+e_mobile; //no i18N
	var jsonData = {'mobilerecoveryauth':{'code':otp_confirm }};//no i18n
	
	callRequestWithCallback(mobile_verify_url,JSON.stringify(jsonData),true,handleOTPConfirm,"PUT",true);//no i18N
}


function show_recDeviceScreen()
{
	if($("#recovery_device_select ~ .uvselect").length || $("#recovery_device_select ~ .devicelist").length){
		show_RECScreen();
		return false;
	}
	var mzadevice = recovery_modes.mzadevice.data;
	var isSecondaryDevice=false;
	var optionElem = '';
	if(mzadevice[0].prefer_option != "push")
	{
		optionElem += "<option value='0' version='"+mzadevice[0].app_version+"'>"+escapeHTML(mzadevice[0].device_name)+"</option>";
		isSecondaryDevice = true;
	}
	else
	{
		mzadevice.forEach(function(data,index)
				{
					optionElem += "<option value="+index+" version='"+data.app_version+"'>"+escapeHTML(data.device_name)+"</option>";
					isSecondaryDevice = true;
				});
	}
	$('#recovery_device_select').html(optionElem); // no i18n
	
	if(isSecondaryDevice)
	{
		try 
		{ 
			isMobile ? mobileviewDevices("#recovery_device_select") : renderUV("#recovery_device_select", false, "", "", "", false, false, "Mobile", true, null, null, "value")//no i18n
			  if($("#recovery_device_select option").length<=1){
					$("#recovery_device_select .selectbox_arrow").hide();
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
	prev_TFA_option = undefined;
	changeRECOVERYSecDevice($('#recovery_device_select'));//no i18N
}
function changeRECOVERYSecDevice(elem)
{
	updatedevices(elem);
	var version = $(elem).children("option:selected").attr('version');
	if($(elem).children("option:selected").val() == prev_TFA_option){
		return false;
	}else{
		prev_TFA_option = $(elem).children("option:selected").val();
		resendRecoveryPush(elem);
	}
}
function resendRecoveryPush(elem){
	var device_index = $(elem).children("option:selected").val();
	mzadevicepos = device_index;
	enableRECOVERYMyZohoDevice(device_index);
}
function show_RECScreen() {
	$("#recovery_device_div").show();
	$("#other_options_div").hide();
	$("#contact_support_div").hide();
}

function enableRECOVERYMyZohoDevice(device_index)
{
	var devicedetails = recovery_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	prefoption = devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	
	var device_rec_url= recoveryUri + "/v2/primary/"+zuid+"/device/"+deviceid;//no i18N
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
							$('#recovery_device_div .rnd_resend_push').attr("onclick" , "resendRecoveryPush($('#recovery_device_select'))")
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
			if(jsonStr.code=="MFA302")//user has configured mfa
			{
				mfa_modes=jsonStr[resource_name].modes;
				initialize_MFAModes();
			}
			else
			{
				password_policy=jsonStr[resource_name].pwdpolicy
				show_reset_password();
				return false;
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
			$(".support_bk_button").attr("onclick","show_mfa_other_options()");
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
			$(".support_bk_button").attr("onclick","show_mfa_other_options()");
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
			$(".support_bk_button").attr("onclick","show_mfa_other_options()");
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
			$(".support_bk_button").attr("onclick","show_mfa_other_options()");
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
}

function show_MfaTotpScreen()
{
	$(".recover_sections").hide();
	$("#mfa_totp_section").show();
	splitField.createElement('mfa_totp',{
		"splitCount":totp_size,				// No I18N
		"charCountPerSplit" : 1,	// No I18N
		"isNumeric" : true,			// No I18N
		"otpAutocomplete": true,	// No I18N
		"customClass" : "customOtp",// No I18N
		"inputPlaceholder":'&#9679;',	// No I18N
		"placeholder":I18N.get("IAM.VERIFY.CODE")				// No I18N
	});
	$("#mfa_totp .splitedText").attr("onkeypress","clearCommonError('mfa_totp')");
	setTimeout(function(){$("#mfa_totp").click();},150);
	
}

function mfa_totp_confimration()
{
	var totp = $("#mfa_totp_full_value").val();
	if(!isValid(totp)) 
	{
		showCommonError("mfa_totp",I18N.get("IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY"));//no i18n
		return false;
	}
	if(totp_size > totp.length) 
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
	
	
	var mfa_totp_url = recoveryUri + "/v2/secondary/"+zuid+"/totp"; //no i18N
	var jsonData = {'totpsecrecoveryauth':{'code':totp }};//no i18n
	callRequestWithCallback(mfa_totp_url,JSON.stringify(jsonData),true,handleMFAConfirm,undefined,true);//no i18N

	return false;
}

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
	setTimeout(function(){$("#mfa_otp").click();},150);

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
		$("#mfa_otp_section #mfa_otp_select .head_info").html(formatMessage(I18N.get("IAM.AC.SELECT.MFA.MOBILE_NUMBER.DESCRIPTION"),mfa_modes.otp.data.length.toString()));
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
	
	var mfa_totp_url = recoveryUri + "/v2/secondary/"+zuid+"/mobile/"+mobile_digest; //no i18N
	first_otp_sent = false;
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
				first_otp_sent=true
				$("#mfa_otp").val("");
				$("#mfa_otp_section #mfa_otp_select").hide();
				$("#mfa_otp_section #mfa_otp_confirm").show();
				$(".recover_sections").hide();
				$("#mfa_otp_section").show();
				$("#mfa_otp").click();
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
	
	var mfa_otp_url = recoveryUri + "/v2/secondary/"+zuid+"/mobile/"+$("#mfa_otp_section #mfa_otp_confirm .fieldcontainer #mfa_otp_enc").val(); //no i18N
	var jsonData = {'mobilesecrecoveryauth':{'code':mfa_otp}};//no i18n
	
	callRequestWithCallback(mfa_otp_url,JSON.stringify(jsonData),true,handleMFAConfirm,"PUT",true);//no i18N
		
	return false;
}



function show_MfaDeviceScreen()
{
	if($("#mfa_device_select ~ .uvselect").length || $("#mfa_device_select ~ .devicelist").length){
		showMFA_screen();
		return false;
	}
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
			isMobile? mobileviewDevices("#mfa_device_select") : renderUV("#mfa_device_select", false, "", "", "", false, false, "Mobile", true, null, null, "value")//no i18n
			  if($("#mfa_device_select option").length<=1){
					$("#mfa_device_select ~ .selectbox_arrow").addClass("hideArrow");
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
	prev_TFA_option = undefined;
	changeMFADevice($('#mfa_device_select'));//no i18N
	return false;
}
function showMFA_screen() {
	$("#mfa_device_section").show();
	$("#mfa_device_options_slide").hide();
	$("#other_mfaoptions_div").hide();
	$(".show_mfa_support_options").hide();
	if (prefoption === "push") {
		$("#mfa_device_push_slide").show();
	} else if (prefoption === "totp") {//no i18n
		$("$mfa_device_totp_slide").show();
	} else {
		$("#mfa_device_qr_slide").show();
	}
}
function changeMFADevice(elem)
{
	show_device_prefmode();
	updatedevices(elem);
	if($(elem).children("option:selected").val() == prev_TFA_option){
		return false;
	}else{
		prev_TFA_option = $(elem).children("option:selected").val();
		resendMFAPush(elem);
	}
	var version = $(elem).children("option:selected").attr('version');
}
function resendMFAPush(elem){
	var device_index = $(elem).children("option:selected").val();
	mzadevicepos = device_index;
	enableMFAMyZohoDevice(device_index);
	if(prev_TFA_option == undefined){prev_TFA_option = $(elem).children("option:selected").val();}
}
function enableMFAMyZohoDevice(device_index)
{
	var devicedetails = mfa_modes.mzadevice.data[parseInt(device_index)];
	deviceid= devicedetails.device_id;
	prefoption = devicedetails.prefer_option;
	devicename = devicedetails.device_name;
	bioType = devicedetails.bio_type;
	
	var device_mfa_url= recoveryUri + "/v2/secondary/"+zuid+"/device/"+deviceid;//no i18N
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
    					"splitCount":totp_size,					// No I18N
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
	
	var device_url = recoveryUri + "/v2/secondary/"+zuid+"/device/"+deviceid;//no i18N
	var jsonData = {'devicesecrecoveryauth':{'devicepref':prefoption}};//no i18n
	
	if(prefoption=="scanqr")
	{
		callRequestWithCallback(device_url,JSON.stringify(jsonData),true,handle_alternate_QRCodeImg,undefined,true);//no i18N
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
					"splitCount":totp_size,					// No I18N
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
					"splitCount":totp_size,					// No I18N
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
		if(totp_size > totp.length) 
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
		if(totp_size > totp.length) 
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
	var mfa_totp_url = recoveryUri + "/v2/secondary/"+zuid+"/device/"+deviceid+"?"; //no i18N
	mfa_totp_url+="polling="+false ;//no i18N
	var jsonData = {'devicesecrecoveryauth':{'code':totp ,"devicepref":prefoption}};//no i18n
		
	callRequestWithCallback(mfa_totp_url,JSON.stringify(jsonData),true,handleMFAConfirm,"put",true);//no i18N

	return false;

}

function isVerifiedFromDevice(prefmode,isMyZohoApp,WmsID,is_recoverymode) 
{
	if(isWmsRegistered === false && isValid(WmsID) && WmsID != "undefined" )
	{
		wmscallmode=prefmode;wmscallapp=isMyZohoApp;wmscallid=WmsID;
		try 
		{
			WmsLite.setClientSRIValues(wmsSRIValues);
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
		var device_url = recoveryUri + "/v2/primary/"+zuid+"/device/"+deviceid+"?";//no i18N
		device_url+="polling="+true ;//no i18N
		
		callRequestWithCallback(device_url,"",false,VerifySuccess,"PUT",true);//no i18N
	}
	else
	{
		var device_url = recoveryUri + "/v2/secondary/"+zuid+"/device/"+deviceid+"?";//no i18N
		device_url+="polling="+true ;//no i18N
		var jsonData = {'devicesecrecoveryauth':{'devicepref':prefmode}};//no i18n
		
		callRequestWithCallback(device_url,JSON.stringify(jsonData),false,VerifySuccess,"PUT",true);//no i18N
	}

	verifyCount++;
	
	if(isValid(WmsID) && WmsID!="undefined")
	{
		wmscount++;
		var callIntervalTime = wmscount < 6 ? 5000 : 25000;
		_time = setInterval(function () {
			isVerifiedFromDevice(prefmode, isMyZohoApp, WmsID, is_recoverymode);
		}, callIntervalTime);
		return false;
	}
	else
	{
		_time = setInterval(function () {
			isVerifiedFromDevice(prefmode, isMyZohoApp, WmsID, is_recoverymode);
		}, 3000);
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
			if(resourcename=="devicerecoveryauth")	//for recovery device
			{
				if(jsonStr.code=="MFA302")//user has configured mfa
				{
					mfa_modes=jsonStr[resourcename].modes;
					initialize_MFAModes();
				}
				else if(jsonStr[resourcename].pwdpolicy!=undefined)
				{
					password_policy=jsonStr[resourcename].pwdpolicy
					show_reset_password();
					return false;
				}
				else
				{
					showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
					return false
				}
			}
			else if(resourcename=="devicesecrecoveryauth")//for mfa device
			{
				if(jsonStr[resourcename].pwdpolicy!=undefined)
				{
					password_policy=jsonStr[resourcename].pwdpolicy
					show_reset_password();
					return false;
				}
				else
				{
					showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
					return false
				}
			}
		}
	}
	return false;
}

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
	var mfa_yubikey_url = recoveryUri + "/v2/secondary/"+zuid+"/yubikey/self" //no i18N
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
	/*
	requestOptions.extensions.uvm = true;
	*/
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
	    /*
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
	    if(forPasskey){
	    	var passkey_data ={};
	    	passkey_data.passkeyrecoveryauth = publicKeyCredential;
			callRequestWithCallback(recoveryUri + "/v2/primary/"+zuid+"/passkey/self",JSON.stringify(passkey_data),true,PasskeyAuthCallback,"PUT",true);//no i18N
	    }
	    else{
			var yubikey_sec_data ={};
			yubikey_sec_data.yubikeysecrecoveryauth = publicKeyCredential;
			callRequestWithCallback(recoveryUri + "/v2/secondary/"+zuid+"/yubikey/self",JSON.stringify(yubikey_sec_data),true,handleMFAConfirm,"PUT",true);//no i18N
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
		var jsonStr = JSON.parse(resp); // no i18n
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
			password_policy=jsonStr[resource_name].pwdpolicy
			show_reset_password();
			return false;
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showCommonError(error_txtbox,jsonStr.localized_message);//no i18n
			}
			else
			{
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				showCommonError(error_txtbox,errorMessage);//No I18N
			}
		}
	}
	else 
	{
		showCommonError(error_txtbox,I18N.get("IAM.ERROR.GENERAL"));//No I18N

	}
	return false;
}


function show_reset_password()
{
	$(".support_bk_button").show();
	$(".support_bk_button").attr("onclick","show_reset_password()");
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
	ppValidator.init("#change_password");//no i18n
	$(".recover_sections").hide();
	$("#change_password_div").show();
	$("#change_password").focus();
	return false;
	
}


function chnage_password(e)
{
	e.preventDefault();
	clearCommonError('reneter_password');//no i18n
	check_pass();
	var new_password = $("#change_password").val();
	var err = ppValidator.getErrorMsg(new_password);
	if(err)//some error exists
	{
		showTopErrNotification(I18N.get("IAM.AC.NEW.PASSWORD.POLICY.CHECK"));
		$("#change_password").focus();
		return false;
	}
    
    if(!isValid($("#reneter_password").val()))
	{
		showCommonError("reneter_password",I18N.get("IAM.ERROR.EMPTY.FIELD"));//no i18n
		return false;
	}
    
	if(new_password!=$("#reneter_password").val())
	{
		showCommonError("reneter_password",I18N.get("IAM.AC.REENTER.PASSWORD.EMPTY.ERROR"));//no i18n
		return false;
	}
	
	$("#reset_password_submit span").addClass("zeroheight");
	$("#reset_password_submit").addClass("changeloadbtn");
	$("#reset_password_submit").attr("disabled", true);
	
	
	encryptData.encrypt([new_password]).then(function(encryptedpassword) {
		encryptedpassword =  typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
		var reset_pwd_url = recoveryUri + "/v2/reset/"+zuid+"/password"; //no i18N
		var jsonData = {'password':{'newpassword':encryptedpassword}};//no i18n
		reset_pwd_url+="?cli_time=" + new Date().getTime();//no i18N
		
		callRequestWithCallback(reset_pwd_url,JSON.stringify(jsonData),true,handleresetpassword,"PUT",true);//no i18N
		
		return false;
	}).catch(function(error) {
		showCommonError("last_password", I18N.get("IAM.ERROR.GENERAL")) //no i18N
	});
	
}

function check_pass()
{
	clearCommonError('reneter_password');//no i18n
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
	var str=$("#change_password").val();
	ppValidator = validatePasswordPolicy(password_policy || {
		mixed_case: mix_cases,
		min_spl_chars : spl_char,
		min_numeric_chars: num,
		min_length: minlen,
		max_length: maxlen
	});
	var err_str = ppValidator.getErrorMsg(str);
	if(str=="")
	{
		clearCommonError('change_password');//no i18n
		$("#change_password_container .fielderror").hide();
	}
	else
	{
		if(!err_str)
		{
			clearCommonError('change_password');	//no i18N
			return false;
		}
		$("#change_password").focus();
	}
}


function handleresetpassword(resp)
{
	
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			if(jsonStr.code=="PR200")
			{
				setTimeout(function(){
					$('#reset_password_submit').addClass('doneBtn');
				},1000);
				
				setTimeout(function()  //go to next screen after 3 secs
				{
					$("#ter_mob").removeClass("show_oneauth");
					$(".oneAuthLable").hide();
					if(jsonStr.password.sess_term_tokens!=undefined	&&	jsonStr.password.sess_term_tokens.length>0)
					{
						if(jsonStr.password.sess_term_tokens.indexOf("rmwebses")==-1)
						{
							$("#terminate_web_sess").hide();
						}
						if(jsonStr.password.sess_term_tokens.indexOf("rmappses")==-1)
						{
							$("#terminate_mob_apps").hide();
						}
						else if(jsonStr.password.sess_term_tokens.indexOf("inconeauth")==-1)
						{
							$("#ter_mob").removeClass("show_oneauth");
						}
						else
						{
							$("#ter_mob").addClass("show_oneauth");
						}
						if(jsonStr.password.sess_term_tokens.indexOf("rmapitok")==-1)
						{
							$("#terminate_api_tok").hide();
						}
						$("#change_password_div").hide();
						$("#terminate_session_div").show();
						$(".support_bk_button").attr("onclick","show_terminate_sessions()");
						showTopNotification(I18N.get("IAM.PUSH.TITLE.PASSWORD.CHANGED.ALERT"));
					}
					else
					{
						showTopNotification(jsonStr.localized_message);
						send_terminate_session_request(document.terminate_session_container);
					}
					if(window.PasswordCredential)
					{
						handle_save_password();
					}
				}, 1500);
				
				setTimeout(function(){
					$('#reset_password_submit').removeClass('doneBtn');
					$("#reset_password_submit span").removeClass("zeroheight");
					$("#reset_password_submit").removeClass("changeloadbtn");
					$("#reset_password_submit").attr("disabled", false);
				},2500);
				
				return false;
			}
			else
			{
				showTopErrNotification(jsonStr.localized_message);
				$("#reset_password_submit span").removeClass("zeroheight");
				$("#reset_password_submit").removeClass("changeloadbtn");
				$("#reset_password_submit").attr("disabled", false);
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
			}
			else
			{
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				showTopErrNotification(errorMessage);
			}
		}
	}
	else 
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	}
	$("#reset_password_submit span").removeClass("zeroheight");
	$("#reset_password_submit").removeClass("changeloadbtn");
	$("#reset_password_submit").attr("disabled", false);
	return false;
}

function show_terminate_sessions()
{
	$(".recover_sections").hide();
	$("#change_password_div").hide();
	$("#terminate_session_div").show();
}

function handle_save_password()
{
	var form = document.createElement("form");
    form.id = "dynamicform" + Math.random();
    form.setAttribute("method", "post");
    form.setAttribute("action", "#");
    form.setAttribute("style", "display: none");
    // Internet Explorer needs this
    form.setAttribute("onsubmit", "window.external.AutoCompleteSaveForm(document.getElementById('" + form.id + "'))");

    var hiddenField = document.createElement("input");
    // Internet Explorer needs a "password"-field to show the store-password-dialog
    hiddenField.setAttribute("type", "text");
    hiddenField.setAttribute("name", "username");
    hiddenField.setAttribute("autocomplete", "username email");
    hiddenField.setAttribute("value", login_id);

    form.appendChild(hiddenField);

    var hiddenField = document.createElement("input");
    // Internet Explorer needs a "password"-field to show the store-password-dialog
    hiddenField.setAttribute("type", "password");
    hiddenField.setAttribute("name", "password");
    hiddenField.setAttribute("autocomplete", "new-password");
    hiddenField.setAttribute("value",  $("#change_password").val());

    form.appendChild(hiddenField);
	document.body.appendChild(form);
	var e=document.getElementById(form.id);
	var c = new PasswordCredential(e);
	navigator.credentials.store(c);

	return false;
    
}

function handle_terminate_session(resp)
{
	if(IsJsonString(resp))
	{
		var jsonStr = JSON.parse(resp);
		var statusCode = jsonStr.status_code;
		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
		{
			if(jsonStr.code=="SES200")
			{
				var terminate_web=$('#ter_all').is(":checked");
				var terminate_mob=$('#ter_mob').is(":checked");
				var terminate_api=$('#ter_apiToken').is(":checked");
				if(terminate_web || terminate_mob || terminate_api)
				{
					showTopNotification(jsonStr.localized_message);
					setTimeout(function(){
						switchto(jsonStr.passwordsessionterminate.redirect_url);
					},3000);
				}
				else
				{
					switchto(jsonStr.passwordsessionterminate.redirect_url);
				}
				return false;
			}
			else
			{
				showTopErrNotification(jsonStr.localized_message);
				$("#terminate_session_submit span").removeClass("zeroheight");
				$("#terminate_session_submit").removeClass("changeloadbtn");
				$("#terminate_session_submit").attr("disabled", false);
			}
		}
		else
		{
			if(jsonStr.cause==="throttles_limit_exceeded")
			{
				showTopErrNotification(jsonStr.localized_message);
			}
			else
			{
				var error_resp = jsonStr.errors[0];
				var errorCode=error_resp.code;
				var errorMessage = jsonStr.localized_message;
				showTopErrNotification(errorMessage);
			}
		}
	}
	else
	{
		showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
	}
	$("#terminate_session_submit span").removeClass("zeroheight");
	$("#terminate_session_submit").removeClass("changeloadbtn");
	$("#terminate_session_submit").attr("disabled", false);
	return false;
}


function send_terminate_session_request(formElement)
{
	var terminate_web=$("#terminate_web_sess").is(":visible")	&&	$('#'+formElement.id).find('input[name="clear_web"]').is(":checked");
	var terminate_mob=$("#terminate_mob_apps").is(":visible")	&&	$('#'+formElement.id).find('input[name="clear_mobile"]').is(":checked");
	var terminate_api=$("#terminate_api_tok").is(":visible")	&&	$('#'+formElement.id).find('input[name="clear_apiToken"]').is(":checked");
	var include_oneAuth=$(".oneAuthLable").is(":visible")	&&  $('#'+formElement.id).find('#include_oneauth').is(":checked");
	
    var jsonData =
		    		{
		    			"passwordsessionterminate"://No I18N
		    			{
		    				"rmwebses" :terminate_web,//No I18N  
		    				"rmappses" :terminate_mob,//No I18N  
		    				"inconeauth" :include_oneAuth,//No I18N 
		    				"rmapitok" :terminate_api//No I18N 
		    			}
		    		};
    
	var terminate_session_url = recoveryUri + "/v2/reset/"+zuid+"/closesession"; //no i18N
	
	callRequestWithCallback(terminate_session_url,JSON.stringify(jsonData),true,handle_terminate_session,"PUT",true);//no i18N
	$("#terminate_session_submit span").addClass("zeroheight");
	$("#terminate_session_submit").addClass("changeloadbtn");
	$("#terminate_session_submit").attr("disabled", true);
		
	return false;
}

function showOneAuthTerminate(ele)
{
	 $('#include_oneauth').prop('checked', false);
	 if(ele.checked && $("#ter_mob").hasClass("show_oneauth")){
		 $(".oneAuthLable").slideDown(300).addClass("displayOneAuth");
		 $("#terminate_session_weband_mobile_desc").hide();
		 $(ele).parents(".checkbox_div").addClass("showOneAuthLable");
		 $(".showOneAuthLable").addClass("displayBorder");
	 }
	 else{
		 $(".oneAuthLable").removeClass("displayOneAuth");
		 $(".showOneAuthLable").removeClass("displayBorder");
		 $("#terminate_session_weband_mobile_desc").show();
		 $(".oneAuthLable").slideUp(300,function(){			 
			 $(ele).parents(".checkbox_div").removeClass("showOneAuthLable");
		 });
	 }
}


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
			$("#org_contact_support .head_info").html(formatMessage(I18N.get("IAM.AC.CONTACT.ORG.SUPPORT.DESC"),org_name.toString(),org_contact.toString(),contactAdminHelpDoc));
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
	
	var contact_supp_change_url = recoveryUri + "/v2/primary/"+zuid+"/support"; //no i18N
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
	var mobile_verify_url = recoveryUri + "/v2/primary/"+zuid+"/support"+contact_support; //no i18N
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
	
	var contact_supp_url = recoveryUri + "/v2/primary/"+zuid+"/support"; //no i18N
	var jsonData = {'changecontactemail':{'problem':issue_to_support}};//no i18n
	
	callRequestWithCallback(contact_supp_url,JSON.stringify(jsonData),true,handlereportedToSupport,undefined,true);
}

function handlereportedToSupport(resp)
{
	//todo 2 clinet side fir final response.
}


*/