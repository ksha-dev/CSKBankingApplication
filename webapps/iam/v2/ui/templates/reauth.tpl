<!DOCTYPE html>
<#if (multiDC)>
<script>
var userAuthModes = JSON.parse('${Encoder.encodeJavaScript(primaryAuthModes)}');
window.onload = function(){
	var redirectURL = userAuthModes.multidc.data.redirect_uri; // no i18n
	var oldForm = document.getElementById("multi_dc_redirection");
	if (oldForm) {
		document.documentElement.removeChild(oldForm);
	}
	var form = document.createElement("form");
	form.setAttribute("id", "multi_dc_redirection");
	form.setAttribute("method", "POST");
	form.setAttribute("action", redirectURL);
	form.setAttribute("target", "_parent");

	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "LOGIN_ID");
	hiddenField.setAttribute("value", "${userEmailAddress}" );
	form.appendChild(hiddenField);

	document.documentElement.appendChild(form);
	form.submit();
	return false;
}
</script>
<#else>
<html>
	<head>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    	<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    	<link href="${SCL.getStaticFilePath("/v2/components/css/relogin.css")}" rel="stylesheet"type="text/css">
    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" type="text/javascript"></script>
    	<#if (isAuth)>
    	<script src="${wmsjsurl}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/wmsliteimpl.js")}" type="text/javascript"></script>
    	</#if>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/splitField.js")}" type="text/javascript"></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}" type="text/javascript"></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/webauthn.js")}" type="text/javascript"></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}" type="text/javascript"></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/relogin.js")}" type="text/javascript"></script>
    	<script>var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;</script/>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/phonePatternData.js")}" type="text/javascript"></script>
    	<script>
    		var csrfParam = "${csrfParam}";  
			var csrfCookieName= "${csrfCookieName}";
			var contextpath = "${contextpath}";
			var service_url = <#if ((service_url)?has_content)>"${Encoder.encodeJavaScript(service_url)}"<#else>''</#if>;
			var service_name = '${Encoder.encodeJavaScript(service_name)}';
			var close_account = Boolean("<#if closeaccount>true</#if>");
    		var email = '${userEmail}';
    		var resetPassUrl = '${Encoder.encodeJavaScript(resetPassUrl)}';
    		var reloginAuthMode,emobile,rmobile;
    		var post_action = false;
    		var zuid = '${zuid}';
    		var logoutURL = '${Encoder.encodeJavaScript(LogoutURL)}';
    		var iam_URL = '${Encoder.encodeJavaScript(iam_URL)}';
    		var UrlScheme = '${UrlScheme}';
    		var actionid = <#if ((actionid)?has_content)>"${actionid}"<#else>''</#if>;
    		var userAuthModes = JSON.parse('${Encoder.encodeJavaScript(primaryAuthModes)}');
    		var support_email = <#if ((supportEmailID)?has_content)>"${supportEmailID}"<#else>''</#if>;
    		var passkeyHelpDoc = '${passKeyHelpDoc}';
    		var otp_length = ${otp_length};
    		<#if (post_action) >
    			post_action = true;
    		</#if>
    		
    		
    		I18N.load({
    			"IAM.ENTER.PASS" : '<@i18n key="IAM.ZOHO.ACCOUNTS" />',
    			"IAM.NEW.SIGNIN.VERIFY" : '<@i18n key='IAM.NEW.SIGNIN.VERIFY'/>',
    			"IAM.PLEASE.CONNECT.INTERNET" : '<@i18n key='IAM.PLEASE.CONNECT.INTERNET'/>',
    			"IAM.ERROR.ENTER.LOGINPASS" : '<@i18n key="IAM.ERROR.ENTER.LOGINPASS" />',
    			"IAM.VERIFY.CODE" : '<@i18n key='IAM.VERIFY.CODE' />',
    			"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key='IAM.TFA.RESEND.OTP.COUNTDOWN'/>',
    			"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key='IAM.NEW.SIGNIN.RESEND.OTP'/>',
    			"IAM.ERROR.GENERAL" : '<@i18n key='IAM.ERROR.GENERAL'/>',
    			"IAM.NEW.SIGNIN.OTP.SENT" : '<@i18n key='IAM.NEW.SIGNIN.OTP.SENT'/>',
    			"IAM.CONFIRM.PASS" : '<@i18n key='IAM.CONFIRM.PASS'/>',
    			"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" : '<@i18n key='IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY' />',
    			"IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING" : '<@i18n key='IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING' />',
    			"IAM.RELOGIN.VERIFY.WITH.PASSWORD.TITLE" : '<@i18n key='IAM.RELOGIN.VERIFY.WITH.PASSWORD.TITLE'/>',
    			"IAM.RELOGIN.VERIFY.VIA.PASSWORD.HEADER" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.PASSWORD.HEADER'/>',
    			"IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING" : '<@i18n key='IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING'/>',
    			"IAM.RELOGIN.VERIFY.ANOTHER.WAY" : '<@i18n key='IAM.RELOGIN.VERIFY.ANOTHER.WAY'/>',
    			"IAM.RELOGIN.VERIFY.VIA.IDENTITY.PROVIDER.TITLE" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.IDENTITY.PROVIDER.TITLE'/>',
    			"IAM.VERIFY.IDENTITY" : '<@i18n key='IAM.VERIFY.IDENTITY'/>',
    			"IAM.RELOGIN.PASSWORDLESS.PUSH.DESC" : '<@i18n key='IAM.RELOGIN.PASSWORDLESS.PUSH.DESC'/>',
    			"IAM.NEW.SIGNIN.TOTP" : '<@i18n key='IAM.NEW.SIGNIN.TOTP'/>',
    			"IAM.RELOGIN.PASSWORDLESS.TOTP.DESC" : '<@i18n key='IAM.RELOGIN.PASSWORDLESS.TOTP.DESC'/>',
    			"IAM.NEW.SIGNIN.QR.CODE" : '<@i18n key='IAM.NEW.SIGNIN.QR.CODE'/>',
    			"IAM.RELOGIN.PASSWORDLESS.SCANQR.DESC" : '<@i18n key='IAM.RELOGIN.PASSWORDLESS.SCANQR.DESC'/>',
    			"IAM.NEW.SIGNIN.WAITING.APPROVAL" : '<@i18n key='IAM.NEW.SIGNIN.WAITING.APPROVAL'/>',
    			"IAM.PUSH.RESEND.NOTIFICATION" : '<@i18n key='IAM.PUSH.RESEND.NOTIFICATION'/>',
    			"IAM.RELOGIN.TROUBLE.IN.ONEAUTH" : '<@i18n key='IAM.RELOGIN.TROUBLE.IN.ONEAUTH'/>',
    			"IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" : '<@i18n key='IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR'/>',
    			"IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC" : '<@i18n key='IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC'/>',
    			"IAM.PASSWORD.VERIFICATION" : '<@i18n key='IAM.PASSWORD.VERIFICATION'/>',
    			"IAM.RELOGIN.VERIFY.VIA.MFA.PASSWORD.DESC" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.MFA.PASSWORD.DESC'/>',
    			"IAM.RELOGIN.VERIFY.WITH.SAML.TITLE" : '<@i18n key='IAM.RELOGIN.VERIFY.WITH.SAML.TITLE'/>',
    			"IAM.NEW.SIGNIN.SAML.HEADER" : '<@i18n key='IAM.NEW.SIGNIN.SAML.HEADER'/>',
    			"IAM.NEW.SIGNIN.OTP.HEADER" : '<@i18n key='IAM.NEW.SIGNIN.OTP.HEADER'/>',
    			"IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER" : '<@i18n key='IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER'/>',
    			"IAM.RELOGIN.VERIFY.USING.JWT" : '<@i18n key='IAM.RELOGIN.VERIFY.USING.JWT'/>',
    			"IAM.RELOGIN.VERIFY.USING.SAML" : '<@i18n key='IAM.RELOGIN.VERIFY.USING.SAML'/>',
    			"IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH" : '<@i18n key='IAM.NEW.SIGNIN.VERIFY.VIA.ONEAUTH'/>',
    			"IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.ONEAUTH.DESC'/>',
    			"IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN" : '<@i18n key='IAM.NEW.SIGNIN.RESEND.PUSH.COUNTDOWN'/>',
    			"IAM.NEW.SIGNIN.RESEND.PUSH" : '<@i18n key='IAM.NEW.SIGNIN.RESEND.PUSH'/>',
    			"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key='IAM.WEBAUTHN.ERROR.BrowserNotSupported'/>',
    			"IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse" : '<@i18n key='IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidResponse'/>',
    			"IAM.WEBAUTHN.ERROR.NotAllowedError" : '<@i18n key='IAM.WEBAUTHN.ERROR.NotAllowedError'/>',
    			"IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError" : '<@i18n key='IAM.WEBAUTHN.ERROR.AUTHENTICATION.PASSKEY.InvalidStateError'/>',
    			"IAM.RELOGIN.VERIFY.VIA.PASSKEY" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.PASSKEY'/>',
    			"IAM.RELOGIN.VERIFY.VIA.PASSKEY.DESC" : '<@i18n key='IAM.RELOGIN.VERIFY.VIA.PASSKEY.DESC'/>',
    			"IAM.WEBAUTHN.ERROR.TYPE.ERROR" : '<@i18n key='IAM.WEBAUTHN.ERROR.TYPE.ERROR'/>',
    			"IAM.WEBAUTHN.ERROR.HELP.HOWTO" : '<@i18n key='IAM.WEBAUTHN.ERROR.HELP.HOWTO'/>',
    			"IAM.RESEND.PUSH.MSG" : '<@i18n key='IAM.RESEND.PUSH.MSG'/>',
    			"IAM.ERROR.VALID.OTP" : '<@i18n key='IAM.ERROR.VALID.OTP'/>'
    		});
    		
    		
			
			window.onload=function() {
				if(!$("#login_id").text().indexOf("@") > -1){
					var codeSplit = $("#login_id").text().split("-")[0].trim(); 
					for(var code in phoneData){
						if(phoneData[code].code.split("+")[1] == codeSplit && phoneData[code].example.length == $("#login_id").text().split("-")[1].trim().length){
							$("#login_id").text(phonePattern.setMobileNumFormat($("#login_id").text().split("-")[1].trim(),code));
							break;
						}
					}
				}
				$("#relogin_password_input").focus();
				setReloginForm(false);
				setFooterPosition();
				<#if (isAuth)>
				if(!$('.fed_div').is(":visible") && $('.fed_div').length === 1){
					$('.fed_2show,.line').hide();
				}
				try {
					WmsLite.setNoDomainChange();
					WmsLite.setConfig(64);//64 is value of WMSSessionConfig.CROSS_PRD
					WmsLite.registerZuid('AC',"${zuid}","${Encoder.encodeJavaScript(userLoginName)}", true);
				}catch(e){}
				</#if>
			}
		
    	</script>
	</head>
	<#if (isDarkmode)>
	<body class="darkmode">
	<#else>
	<body>
	</#if>
		<div class="bg"></div>
		<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
    	<div class="Errormsg"> <span class="error_icon"></span> <span class="error_message"></span><span class="helplink"></span><div class="error_close_icon hide" onclick="closeTopErrNotification()"></div></div>
		<div class="container">
   			<div class='loader'></div> 
  			<div class='blur_elem blur'></div>
			<form class="zform"  name="pcform" id="relogin" onsubmit="javascript:return verifyUserAuthFactor(this)" novalidate="novalidate"  autocomplete="off">  
       
      			<div class="zoho_logo" onclick="location.reload()"></div>
      			<div class="header_content">
		        	<span class="head_text"><@i18n key="IAM.VERIFY.IDENTITY"/></span>
			        <div class="mail_id">
			        	<span class="name" id="login_id">${userEmail}</span>
			        	<#if !hideUserChange>
			        	<span class="notyoulink"  onclick="return logoutFuntion();"><@i18n key="IAM.NOT.YOU"/></span> 
			        	</#if>
			        </div>
			        <div class="reauth_desc"><@i18n key="IAM.RELOGIN.VERIFY.REASON.DESC"/></div>
		        </div>
		        
		        <div class="header_for_oneauth">
			        <div class="mail_id">
			        	<span class="name" id="login_id">${userEmail}</span>
			        	<#if !hideUserChange>
			        	<span class="notyoulink"  onclick="return logoutFuntion();"><@i18n key="IAM.NOT.YOU"/></span> 
			        	</#if>
			        </div>
		        	<span class="head_text"></span>
					<div class="reauth_desc"><@i18n key="IAM.RELOGIN.VERIFY.REASON.DESC"/></div>
					<span class="header_desc"></span>
		        </div>
		
				<div id="relogin_password">
					<div class="relogin_primary_container" id="relogin_primary_container">
					<div class="password_field" id="password_container">
						<div class="textbox_div forms" id="forms_error" >
							<input class="text_box" type="text" autocomplete="off" name="current" onkeydown="remove_err();" placeholder="<@i18n key="IAM.ENTER.PASS"/>" id ="relogin_password_input" required="">
							<span class="pass_icon icon-hide" onclick="pass_show_hide()"></span>
						</div>
						<div class="error_msg fielderror"></div>
						<div class="textbox_actions" id="enableotpoption">
							<span class="bluetext_action" id="reloginwithotp" onclick="showAndGenerateOtp()"><@i18n key="IAM.RELOGIN.VERIFY.USING.OTP"/></span>
							<#if (showForgotPwdLink)>
								<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
							</#if>
						</div>
						<div class="textbox_actions" id="enableforgot">
							<#if (showForgotPwdLink)>
								<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
							</#if>
						</div>
						<div class="textbox_actions textbox_actions_saml" id="enablesaml">
							<span class="bluetext_action reloginwithsaml" onclick="enableSamlAuth();"><@i18n key="IAM.RELOGIN.VERIFY.USING.SAML"/></span>
							<#if (showForgotPwdLink)>
								<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
							</#if>
						</div>
						<div class="textbox_actions textbox_actions_saml" id="enablejwt">
							<a href="" class="bluetext_action reloginwithjwt"><@i18n key="IAM.RELOGIN.VERIFY.USING.JWT"/></a>
							<#if (showForgotPwdLink)>
								<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
							</#if>
						</div>
										
						

					</div>
					
					<div class="textbox_div" style="display:none" id="mfa_device_container">
						<div class="devices">
							<select class='secondary_devices' onchange='changeSecDevice(this);'></select>
							<div class="deviceparent">
								<span class="deviceinfo icon-device"></span>
								<span class="devicetext"></span>
							</div>
						</div>
						<div class='rnd_container'>
							<div id="rnd_number"></div>
							<div class="bluetext_action rnd_resend resendotp" onclick="javascript:return enableMyZohoDevice();"><@i18n key="IAM.NEW.SIGNIN.RESEND.PUSH"/></div>
						</div>
					</div>
					
					<div id="otp_container">
						<div class="textbox_div" >
							<div class="header_desc email_otp_description"><@i18n key="IAM.RELOGIN.VERIFY.VIA.EMAIL.DESC"/></div>
							<div class="header_desc mobile_otp_description"><@i18n key="IAM.RELOGIN.VERIFY.VIA.MOBILE.DESC"/></div>
							<div class="otp_input" id="otp_input_box" ></div>
							<div class="error_msg fielderror"></div>
							<div class="textbox_actions otp_actions">
								<span class="bluetext_action" id="verifywithpass" onclick="showPassword()"><@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD"/></span>
								<span class="bluetext_action reloginwithsaml" onclick="enableSamlAuth();"><@i18n key="IAM.RELOGIN.VERIFY.USING.SAML"/></span>
								<a href="" class="bluetext_action reloginwithjwt" ><@i18n key="IAM.RELOGIN.VERIFY.USING.JWT"/></a>
								<span class="bluetext_action showmorereloginoption" onclick="showMoreReloginOption()"><@i18n key="IAM.RELOGIN.TRY.ANOTHER.WAY"/></span>
								<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
							</div>
						</div>
					</div>
					
					<div class="textbox_div" id="mfa_totp_container">
						<div id="mfa_totp_field" class="otp_input" style="margin-top:30px;"></div>
						<div class="error_msg fielderror"></div>
					</div>
		
					<div class="qrcodecontainer" id="mfa_scanqr_container" style="margin-top:30px;">
						<div>
							<span class="qr_before"></span>
						    <div id="qrimg"></div>
						    <span class="qr_after"></span>
						</div>
					</div>
					<#if (isMobile == 1) >
						<div class="btn blue waitbtn" id="openoneauth" onclick="QrOpenApp()">
							<span class="oneauthtext"><@i18n key="IAM.NEW.SIGNIN.OPEN.ONEAUTH"/></span>
						</div>
					</#if>
					<button style="display:none" class="btn  blue waitbtn" id="waitbtn">
						<span class="loadwithbtn"></span>
						<span class="waittext"><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span>
					</button>
					</div>
					<div class="textbox_actions_more" id="enablemore">
						<span class="bluetext_action showmorereloginoption" onclick="showMoreReloginOption()"><@i18n key="IAM.RELOGIN.TRY.ANOTHER.WAY"/></span>
						<#if (showForgotPwdLink)>
						<span class="bluetext_action bluetext_action_right blueforgotpassword" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
						</#if>
						<span class="bluetext_action bluetext_action_right resendotp" id="resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
					</div>	
					
					<div class="passwordless_opt_container">
						<div id="trytitle"></div>
						<div class="relogin_head verify_title"><@i18n key="IAM.RELOGIN.VERIFY.ANOTHER.WAY"/></div>
						<div class="optionstry optionmod" id="trytotp" onclick="tryAnotherway('totp')" >
							<div class="img_option_try img_option icon-totp"></div>
							<div class="option_details_try">
								<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.TOTP.TITLE"/></div>
								<div class="option_description try_option_desc"><@i18n key="IAM.RELOGIN.TROUBLE.IN.ONEAUTH.TOTP.DESC"/></div>
							</div>
							<div class='mfa_totp_verify verify_totp hide' id='verify_totp_container'> 
								<div id="verify_totp" class="otp_container mini_txtbox"></div>
								<button class="btn blue mini_btn" id="totpverifybtn" tabindex="2" >
									<span class="loadwithbtn"></span>
									<span class="waittext"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span>
								</button>
								<div class="fielderror"></div>
							</div>
						</div>
						<div class="optionstry optionmod" id="tryscanqr" onclick="tryAnotherway('qr')" >
							<div class="img_option_try img_option icon-qr"></div>
							<div class="option_details_try">
								<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.SCANQR.TITLE"/></div>
								<div class="option_description try_option_desc"><@i18n key="IAM.RELOGIN.TROUBLE.IN.ONEAUTH.SCANQR.DESC"/></div>
							</div>
							<div class="verify_qr" id="verify_qr_container">
								<div class="qrcodecontainer">
									<div>
										<span class='qr_before'></span>
										<div id="verify_qrimg"></div>
										<span class='qr_after'></span>
										<div class="loader"></div>
										<div class="blur_elem blur"></div>
									</div>
								</div>
								<#if (isMobile == 1) >
								<div class="btn blue waitbtn" id="openoneauth" onclick="QrOpenApp()">
									<span class="oneauthtext"><@i18n key="IAM.NEW.SIGNIN.OPEN.ONEAUTH"/></span>
								</div>
								</#if>
							</div>
						</div>
						<span class="close_icon error_icon" onclick="hideTryanotherWay()"></span>
						<div class='text16 pointer nomargin' id='recoverybtn_mob' onclick='showCantAccessDevice()'><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></div>
					</div>
					
					<div id="other_relogin_options"></div>

					<div id="problemreloginui"></div>
							
					<button class="btn" id="reauth_button"><span><@i18n key="IAM.CONFIRM.PASS"/></span></button>
					<div class="tryAnotherBlueText" id="tryAnotherSAMLBlueText" onclick ="showMoreReloginOption()"><@i18n key="IAM.RELOGIN.TRY.ANOTHER.WAY"/></div>
					<div class="tryanother text16" onclick ="showTryanotherWay()"><@i18n key="IAM.RELOGIN.VERIFY.ANOTHER.WAY"/></div>	
					<div class="text16 pointer nomargin" id="problemrelogin" onclick="showproblemrelogin(this)"><@i18n key="IAM.RELOGIN.TROUBLE.IN.ONEAUTH"/></div>
					<div class="text16 pointer nomargin" id="try_other_options" onclick="showproblemrelogin(this)"><@i18n key="IAM.RELOGIN.TRY.OTHER.OPTIONS"/></div>
	 			</div>	
	 	<#if (IDP_Count?has_content)>
	 			<#if (!isPasswordExists && !isZohoAccount)>
	 			<div class="fed_2show" style="margin-top:30px">
	 			<#else>
	 			<div class="line" id="lineseparator"></div>
	 			<div class="fed_2show">
	 			</#if>
					<span class="relogin_fed_text"><@i18n key="IAM.NEW.SIGNIN.FEDERATED.VERIFY.TITLE"/></span>
					<div id="all_idps">
					<#if ((idpList.GOOGLE)?has_content)>
						<span class="fed_div small_box google_icon" onclick="createandSubmitOpenIDForm('google');" title="<@i18n key="IAM.FEDERATED.SIGNIN.GOOGLE"/>" > 
							<div class="fed_center_google">
								<span class="fed_icon icon-google_small">
									<span class="path1"></span>
				                	<span class="path2"></span>
				                	<span class="path3"></span>
				                	<span class="path4"></span>
								</span>
								<span class="fed_text_avoid"><@i18n key="IAM.GOOGLE" /></span>
							</div>
						</span>
					</#if>
					<#if ((idpList.AZURE)?has_content)>
						<span class="fed_div small_box MS_icon" onclick="createandSubmitOpenIDForm('azure');" title="<@i18n key="IAM.FEDERATED.SIGNIN.MICROSOFT"/>">
				            <div class="fed_center">
				                <span class="fed_icon icon-azure_small">
				                	<span class="path1"></span>
				                	<span class="path2"></span>
				                	<span class="path3"></span>
				                	<span class="path4"></span>
				                </span>
				                <span class="fed_text"></span>
				            </div>
				        </span>	
					</#if>
					<#if ((idpList.LINKEDIN)?has_content)>
						 <span class="fed_div small_box linkedin_icon linkedin_fed" onclick="createandSubmitOpenIDForm('linkedin');" title="<@i18n key="IAM.FEDERATED.SIGNIN.LINKEDIN"/>">
                         	<div class="fed_center">
                           	<span class="fed_icon linked_fed_icon icon-linkedin_small"></span>
                            </div>
                         </span>
					</#if>
					<#if ((idpList.FACEBOOK)?has_content)>
						<span class="fed_div small_box fb_icon" onclick="createandSubmitOpenIDForm('facebook');" title="<@i18n key="IAM.FEDERATED.SIGNIN.FACEBOOK"/>">
					        <div class="fed_center">
                          	<div class="fed_icon fb_fedicon icon-facebook_small"></div>
                               <span class="fed_text"></span>
                            </div>
				        </span>
					</#if>
					<#if ((idpList.TWITTER)?has_content)>
						 <span class="fed_div small_box twitter_icon"  onclick="createandSubmitOpenIDForm('twitter');" title="<@i18n key="IAM.FEDERATED.SIGNIN.TWITTER"/>">
				            <div class="fed_center">
				                <span class="fed_icon icon-twitter_small"></span>
				                <span class="fed_text"></span>
				            </div>
				        </span>
					</#if>
					<#if ((idpList.YAHOO)?has_content)>
						<span class="fed_div small_box yahoo_icon" onclick="createandSubmitOpenIDForm('yahoo');" title="<@i18n key="IAM.FEDERATED.SIGNIN.YAHOO"/>">
				            <div class="fed_icon yahoo_fedicon icon-yahoo_small"></div>
				        </span>
					</#if>
					<#if ((idpList.SLACK)?has_content)>
						<span class="fed_div small_box slack_icon" onclick="createandSubmitOpenIDForm('slack');" title="<@i18n key="IAM.FEDERATED.SIGNIN.SLACK"/>">
				          <div class="fed_center">
				            <div class="fed_icon slack_fedicon icon-slack_small">
				            	<span class="path1"></span>
				                <span class="path2"></span>
				                <span class="path3"></span>
				                <span class="path4"></span>
				            </div>
				           </div>
				        </span>
					</#if>
					<#if ((idpList.DOUBAN)?has_content)>
						<span class="fed_div small_box douban_icon" onclick="createandSubmitOpenIDForm('douban');" title="<@i18n key="IAM.FEDERATED.SIGNIN.DOUBAN"/>">
				           <div class="fed_center">
				            <div class="fed_icon douban_fedicon icon-douban_small"></div>
				           </div>
				        </span>
					</#if>
					<#if ((idpList.QQ)?has_content)>
						<span class="fed_div small_box qq_icon" onclick="createandSubmitOpenIDForm('qq');" title="<@i18n key="IAM.FEDERATED.SIGNIN.QQ"/>">
				           <div class="fed_center">
				            <div class="fed_icon qq_fedicon icon-qq_small">
				            	<span class="path1"></span>
				                <span class="path2"></span>
				                <span class="path3"></span>
				                <span class="path4"></span>
				                <span class="path5"></span>
				                <span class="path6"></span>
				                <span class="path7"></span>
				                <span class="path8"></span>
				            </div>
				           </div>
				        </span>
					</#if>
					<#if ((idpList.WECHAT)?has_content)>
						<span class="fed_div small_box wechat_icon" onclick="createandSubmitOpenIDForm('wechat');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WECHAT"/>">
				            <div class="fed_center">
				                <span class="fed_icon icon-wechat_small"></span>
				                <span class="fed_text"></span>
				            </div>
				        </span>
					</#if>
					<#if ((idpList.WEIBO)?has_content)>
						<span class="fed_div small_box weibo_icon" onclick="createandSubmitOpenIDForm('weibo');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WEIBO"/>">
				            <div class="fed_center">
				                <span class="fed_icon icon-weibo_small">
				                	<span class="path1"></span>
				                	<span class="path2"></span>
				                	<span class="path3"></span>
				                	<span class="path4"></span>
				                	<span class="path5"></span>
				                </span>
				                <span class="fed_text weibo_text"></span>
				            </div>
				        </span>
					</#if>
					<#if ((idpList.BAIDU)?has_content)>
						<span class="fed_div small_box baidu_icon" onclick="createandSubmitOpenIDForm('baidu');" title="<@i18n key="IAM.FEDERATED.SIGNIN.BAIDU"/>">
				          <div class="fed_center">
				            <div class="fed_icon baidu_fedicon icon-baidu_small"></div>
				          </div>
				        </span>
					</#if>
					<#if ((idpList.APPLE)?has_content)>
						<span class="fed_div small_box apple_normal_icon apple_fed" onclick="createandSubmitOpenIDForm('apple');"  title="<@i18n key="IAM.FEDERATED.SIGNIN.APPLE"/>">
				         <div class="fed_center">
				            <div class="fed_icon apple_normal_large icon-apple_small"></div>
				        </div>
				        </span>
					</#if>
					<#if ((idpList.INTUIT)?has_content)>
						<span class="fed_div small_box intuit_icon"  onclick="createandSubmitOpenIDForm('intuit');" title="<@i18n key="IAM.FEDERATED.SIGNIN.INTUIT"/>">
				          <div class="fed_center">
				            <div class="fed_icon intuit_fedicon icon-intuit_small"></div>
				          </div>
				        </span>
					</#if>
					<#if ((idpList.ADP)?has_content)>
				         <span class="fed_div small_box adp_icon" onclick="createandSubmitOpenIDForm('adp');" title="<@i18n key="IAM.FEDERATED.SIGNIN.ADP"/>">
				           <div class="fed_center">
				            <div class="fed_icon adp_fedicon icon-adp_small"></div>
				           </div>
				        </span>
					</#if>
					<#if ((idpList.GITHUB)?has_content)>
				         <span class="fed_div small_box github_icon" onclick="createandSubmitOpenIDForm('github');" title="<@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB"/>">
				           <div class="fed_center">
				            <div class="fed_icon github_fedicon icon-github_small"></div>
				             <span class="fed_text"></span>
				           </div>
				        </span>
					</#if>
					</div>	
				</div>	
		</#if>
	  			<div class="nopassword_container">
					<div class="nopassword_icon icon-hint"></div>
					<div class="nopassword_message"><@i18n key="IAM.NEW.SIGNIN.NO.PASSWORD.MESSAGE" arg0="goToForgotPassword();"/></div>
				</div>
			</form>
		</div> 
		
		<#include "Unauth/footer.tpl">
	</body>
</html>
</#if>