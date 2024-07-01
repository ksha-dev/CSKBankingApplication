<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html lang="${lang}">
	<head>
	
		<title><@i18n key="IAM.IP.RESET.TITLE" /></title>
		
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
		<meta name="description" content="resetip"/>
		<style type="text/css">
			.load-bg{top:0px}
			.darkmode .load-bg{background-color: #191A23}
			.line_loader{transform: scale(1);}
		</style>
		<#include "../zoho_line_loader.tpl">
		
		<@resource path="/v2/components/css/${customized_lang_font}" />
		<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
    	<@resource path="/v2/components/tp_pkg/xregexp-all.js" attributes="defer" />
    	<@resource path="/v2/components/tp_pkg/u2f-api.js" attributes="defer" />
    	<@resource path="/v2/components/tp_pkg/tippy.all.min.js" attributes="defer" />
    	<script type="text/javascript" src="${za.iam_contextpath}/encryption/script"></script>
		<@resource path="/v2/components/js/security.js" />
		<#if Enable_zlabs?has_content	&&		Enable_zlabs==true>
    	
    		<@resource path="/v2/components/tp_pkg/captcha.min.js" attributes="defer" />
    	</#if>    	
    	 <!-- Commmon webauthn methods moved to webauthn.js and called in mfa.js and signin.js -->
		<script src="${za.wmsjsurl}" integrity="${za.wmsjsintegrity}" crossorigin="anonymous" type="text/javascript" defer></script>
		<meta name="robots" content="noindex, nofollow"/>
		
		<script type='text/javascript'>
		
			var login_id="${Encoder.encodeJavaScript(login_id)}";
			var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var reqCountry="${req_country}";
			var isMobile = Boolean("<#if is_mobile>true</#if>");
			var contextpath = "${context_path}";
			var UrlScheme = "${url_scheme}";
			var isDarkMode = parseInt("${isDarkmode}");
			var uriPrefix = "${uri_prefix}";
			var digest_id = "";
			var supportEmailAddr = "${support_email_address}";
			var recoveryUri = "${recovery_uri}";
			var otp_length = ${otp_length};
			var org_name, org_contact;
			var hip_required,ipRestrictedForOrg,ipPersonalRestriction;
			var isWindowLoaded = false;
			var wmsSRIValues = ${za.wmsSRIValues};
			var docHead = document.head || document.getElementsByTagName("head" )[0] || document.documentElement;
			var serviceUrl,signup_url,serviceName,redirect_url,signin_redirect_url,resendTimer,isOrgAdmin,zuid,cdigest,mdigest,head_token,mfa_modes,mzadevicepos,mfa_modes_count,isWmsRegistered,wmscallmode,wmscallid,wmscallapp,_time,is_recovery_extra_modes;
			<#if (('${service_url}')?has_content)>
				serviceUrl = '${Encoder.encodeJavaScript(service_url)}';
				escapeServiceUrlHash();
			</#if>
			var aCParams= getACParms();
			
			var type,audio_timer,captchaType,zlabs_captcha_params,zlabsCaptchaObj;
			var captcha_usecase ="${captcha_usecase}";
			var ZlabsCapthca_enabled =${Enable_zlabs?c};
			
			<#if (('${digest_id}')?has_content)>
			digest_id = "${Encoder.encodeJavaScript(digest_id)}";
			</#if>
			var resIntegrity = {};
			<#if (('${resIntegrity}')?has_content)>
				resIntegrity = ${resIntegrity};		
			</#if>
			window.onload = function() {
				windowLoaded();
				return false;
			}
			function escapeServiceUrlHash() {
				var locationUrl = window.location.href;
				var tmpserviceurl = serviceUrl;
				try {
					if(locationUrl.indexOf('serviceurl=') !== -1) {
						var surl = decodeURIComponent(locationUrl.substring(locationUrl.indexOf('serviceurl=')+11));
						if(surl.indexOf('#') !== -1) {
							if(surl.indexOf('&') !== -1) {
								surl = surl.substr(0, surl.indexOf('&'));
							}
							serviceUrl = surl;	
						}
					}
				}catch (e) {
					serviceUrl = tmpserviceurl;
				}
			}
			function includeScript(url, callback, excatch) {
				var script = document.createElement("script"); 
				script.src = url; 
				if(resIntegrity && resIntegrity[url]) {
					script.integrity = resIntegrity[url];
					script.crossOrigin = "anonymous"; //No I18N
				}
				if(excatch){
					script.onerror = function() {
						callback();
					};
				}
				if (callback) { 
					script.onload = script.onreadystatechange = function() { 
						if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete") {
							callback(); 
							script.onload = script.onreadystatechange = null; // To avoid calling repeatedly in IE 
						}
					};
				}
				docHead.appendChild(script); 
			};
			function windowLoaded(){
				if(isWindowLoaded){
					onZAScriptLoad();
				}
				isWindowLoaded = true;
			}
			
			function onZAScriptLoad(){
				I18N.load({
					"IAM.PLEASE.CONNECT.INTERNET" : '<@i18n key="IAM.PLEASE.CONNECT.INTERNET" />',
					"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD" />',
					"IAM.AC.ERROR.LOGIN.NOT.VALID" : '<@i18n key="IAM.AC.ERROR.LOGIN.NOT.VALID" />',
					"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" />',
					"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />',
					"IAM.SIGNIN.ERROR.CAPTCHA.INVALID" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID" />',
					"IAM.AC.RECOVER.LOOKUP.ERROR.MOBILE" : '<@i18n key="IAM.AC.RECOVER.LOOKUP.ERROR.MOBILE" />',
					"IAM.AC.RECOVER.LOOKUP.ERROR.EMAIL.OR.USERNAME" : '<@i18n key="IAM.AC.RECOVER.LOOKUP.ERROR.EMAIL.OR.USERNAME" />',
					"IAM.ERROR.USER.ACTION" : '<@i18n key="IAM.ERROR.USER.ACTION" />',
					"IAM.NEW.SIGNIN.TITLE.RANDOM" : '<@i18n key="IAM.NEW.SIGNIN.TITLE.RANDOM" />',
					"IAM.NEW.IP.NOT.FOUND.MSG" : '<@i18n key="IAM.NEW.IP.NOT.FOUND.MSG" />',
					"IAM.NEXT" : '<@i18n key="IAM.NEXT" />',
					"IAM.AC.SELECT.USERNAME.EMAIL.DESCRIPTION" : '<@i18n key="IAM.AC.SELECT.USERNAME.EMAIL.DESCRIPTION" />',
					"IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION" : '<@i18n key="IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION" />',
					"IAM.NEW.SIGNUP.EMAIL.VERIFY.DESC" : '<@i18n key="IAM.NEW.SIGNUP.EMAIL.VERIFY.DESC" />',
					"IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC" : '<@i18n key="IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC" />',
					"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN" />',
					"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" />',
					"IAM.NEW.SIGNIN.OTP.SENT" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT" />',
					"IAM.VERIFY.CODE" : '<@i18n key="IAM.VERIFY.CODE" />',
					"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" />',
					"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP" />',
					"IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE" : '<@i18n key="IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE" />',
					"IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" : '<@i18n key="IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" />',
					"IAM.IP.RECOVER.EMAIL_ID.DESCRIPTION.MULTI" : '<@i18n key="IAM.IP.RECOVER.EMAIL_ID.DESCRIPTION.MULTI" />',
					"IAM.AC.CONFIRM.EMAIL.VALID" : '<@i18n key="IAM.AC.CONFIRM.EMAIL.VALID" />',
					"IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION" : '<@i18n key="IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION" />',
					"IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" : '<@i18n key="IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" />',
					"IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION" : '<@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION" />',
					"IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION" : '<@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION" />',
					"IAM.AC.CONFIRM.MOBILE.VAlID" : '<@i18n key="IAM.AC.CONFIRM.MOBILE.VAlID" />',
					"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
					"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
					"IAM.AC.RECOVERY.MODES.DEVICE.DESCRIPTION.RANDOMNUMBER" : '<@i18n key="IAM.AC.RECOVERY.MODES.DEVICE.DESCRIPTION.RANDOMNUMBER" />',
					"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
					"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
					"IAM.AC.CHOOSE.DOMAIN.DESCRIPTION": '<@i18n key="IAM.AC.CHOOSE.DOMAIN.DESCRIPTION" />',
					"IAM.AC.ENTER.DOMAIN.DESCRIPTION": '<@i18n key="IAM.AC.ENTER.DOMAIN.DESCRIPTION" />',
					"IAM.AC.DOMAIN.INVALID.ERROR": '<@i18n key="IAM.AC.DOMAIN.INVALID.ERROR" />',
					"IAM.WEBAUTHN.ERROR.UnknownError": '<@i18n key="IAM.WEBAUTHN.ERROR.UnknownError" />',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse" : '<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidResponse" />',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported" />',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.ErrorOccurred"/>',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.AUTHENTICATION.InvalidStateError"/>',
					"IAM.RESEND.PUSH.MSG" : '<@i18n key="IAM.RESEND.PUSH.MSG" />',
					"IAM.IP.SELECT.MFA.MOBILE_NUMBER.DESCRIPTION" : '<@i18n key="IAM.IP.SELECT.MFA.MOBILE_NUMBER.DESCRIPTION" />',
					"IAM.NEW.SIGNIN.MFA.SMS.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.MFA.SMS.HEADER" />',
					"IAM.EXCEPTION.RELOAD" : '<@i18n key="IAM.EXCEPTION.RELOAD" />',
					"IAM.NEW.SIGNIN.WAITING.APPROVAL" : '<@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL" />',
					"IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" : '<@i18n key="IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" />',
					"IAM.NEW.SIGNIN.VERIFY.PUSH" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.PUSH" />',
					"IAM.IP.RESET.SECTION.ORG.DESCRIPTION" : '<@i18n key="IAM.IP.RESET.SECTION.ORG.DESCRIPTION" />',
					"IAM.IP.RESET.SECTION.USER.DESCRIPTION" : '<@i18n key="IAM.IP.RESET.SECTION.USER.DESCRIPTION" />',
					"IAM.IP.RESET.USER_VERIFICATION.SUCCESS" : '<@i18n key="IAM.IP.RESET.USER_VERIFICATION.SUCCESS" />',
					"IAM.IP.RESET.SECTION.CHOOSE.ORG.DESCRIPTION" : '<@i18n key="IAM.IP.RESET.SECTION.CHOOSE.ORG.DESCRIPTION" />',
					"IAM.RESETIP.SUCCESS.ORG.RESET" : '<@i18n key="IAM.RESETIP.SUCCESS.ORG.RESET" />',
					"IAM.RESETIP.SUCCESS.ORG.RESET.DESC" : '<@i18n key="IAM.RESETIP.SUCCESS.ORG.RESET.DESC" />',
					"IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY" />',
					"IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID" : '<@i18n key="IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID" />',
					"IAM.ALLOWEDIP.TOIP.NOT_VALID" : '<@i18n key="IAM.ALLOWEDIP.TOIP.NOT_VALID" />',
					"IAM.RESETIP.NEW.CONFIGURE.DESC" : '<@i18n key="IAM.RESETIP.NEW.CONFIGURE.DESC" />',
					"IAM.RESETIP.NEW.CONFIGURE.STATIC.DESC" : '<@i18n key="IAM.RESETIP.NEW.CONFIGURE.STATIC.DESC" />',
					"IAM.RESETIP.NEW.CONFIGURE.RANGE.DESC" : '<@i18n key="IAM.RESETIP.NEW.CONFIGURE.RANGE.DESC" />',
					"IAM.ALLOWEDIP.NAME.NOTVALID" : '<@i18n key="IAM.ALLOWEDIP.NAME.NOTVALID" />',
					"IAM.IP.RESTRICTION.RECONFIGURED" : '<@i18n key="IAM.IP.RESTRICTION.RECONFIGURED" />',
					"IAM.IP.RESTRICTION.RECONFIGURED.DESC" : '<@i18n key="IAM.IP.RESTRICTION.RECONFIGURED.DESC" />',
					"IAM.IP.CONTACT.ORG.SUPPORT.DESC" : '<@i18n key="IAM.IP.CONTACT.ORG.SUPPORT.DESC" />',
					"IAM.ALLOWEDIP.STATIC.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.STATIC.EMPTY" />',
					"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" />',
					"IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" : '<@i18n key="IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" />',
					"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" />',
					"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID" />',
					"IAM.NEW.SIGNIN.OTP.SENT.RESEND" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT.RESEND" />',
					"IAM.ALLOWEDIP.IPNAME.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.IPNAME.EMPTY" />',
					"IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW"/>',
					"IAM.AC.SIGNIN.EMAIL.ADDRESS.OR.MOBILE" : '<@i18n key="IAM.AC.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>',
					"IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" />',	
					"IAM.ALLOWEDIP.TOIP.ERROR.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.TOIP.ERROR.EMPTY" />',
					"IAM.ALLOWEDIP.FROMIP.NOTVALID" : '<@i18n key="IAM.ALLOWEDIP.FROMIP.NOTVALID" />',
					"IAM.NO.IP.RESTRICTION.FOUND" : '<@i18n key="IAM.NO.IP.RESTRICTION.FOUND" />',				
					"IAM.NO.IP.RESTRICTION" : '<@i18n key="IAM.NO.IP.RESTRICTION" />',				
				});
				
				$("#nextbtn").removeAttr("disabled"); 
				onRecoveryReady();
				<#if (('${login_id}')?has_content)>
					fetchLookupDetails("${Encoder.encodeJavaScript(login_id)}");
				</#if>
				<#if (('${digest_id}')?has_content)>
				fetchLookupDetails("${Encoder.encodeJavaScript(digest_id)}");
				</#if>
				<#if !(('${digest_id}')?has_content) && !(('${login_id}')?has_content)>
					$(".recovery_container").css("visibility","visible");
					hideCommonLoader(); 
				</#if>
				
				if(!isMobile)
				{
				
					tippy('.captcha_icons span[class*="Captchaicon-"]', 
					{
						animation: 'scale',
			  			arrow: true,
						distance: 15,
						maxWidth: "200px",
			  			placement:'bottom'//No I18N
					});
				}
			}
			
			function zaOnLoadHandler() {
				var cssURLs,jsURLs;
				<#if (('${cssURLs}')?has_content)>
					cssURLs = "${cssURLs}";		
				</#if>
				<#if (('${jsURLs}')?has_content)>
					jsURLs = "${jsURLs}";		
				</#if>
				// Include CSS
				if(cssURLs) {
					cssURLs = cssURLs.split(","); 
					for(var i = 0, len = cssURLs.length; i < len; i++) {
						var style = document.createElement("link");
						style.href = cssURLs[i]; 
						style.rel = "stylesheet"; 
						if(resIntegrity && resIntegrity[cssURLs[i]]) {
							style.integrity = resIntegrity[cssURLs[i]];
							style.crossOrigin = "anonymous";	// No I18N
						}
						docHead.appendChild(style); 
					}
				}
				
				// Synchronously Include Scripts
				if(jsURLs) {
					jsURLs = jsURLs.split(","); 
					var scriptIdx = 0; 
					(function _jsOnLoad() {
						if (scriptIdx == jsURLs.length) { // Last script, all scripts were loaded. So, call the users handler.  
							windowLoaded();
						}else{
							var jsURL = jsURLs[scriptIdx++]; 
							if((jsURL.indexOf("jquery-3.6.0.min") != -1 && window.I18N)) { // Don't include jQuery, If it is already included in the page.
								 _jsOnLoad(); 
							} else { 
								includeScript(jsURL, _jsOnLoad); 
							}
						}
					})();
				}
			};
			
			zaOnLoadHandler();
			
			function getACParms()
			{
				var params="";
				<#if (('${service_name}')?has_content)>
					params += "servicename=" + encodeURIComponent('${service_name}');
					serviceName=encodeURIComponent('${service_name}');
				</#if>
				<#if (('${signup_url}')?has_content)>
					params += "&signupurl="+encodeURIComponent('${Encoder.encodeJavaScript(signup_url)}');//no i18N
					signup_url = '${Encoder.encodeJavaScript(signup_url)}';
				</#if>
				<#if (('${service_language}')?has_content)>
					params += "&service_language="+encodeURIComponent('${Encoder.encodeJavaScript(service_language)}');//no i18N
				</#if>
				<#if (('${hide_signup}')?has_content)>
					params += "&hide_signup="+${hide_signup};
				</#if>
				<#if (('${isDarkmode}') == '1' )>
					params += "&darkmode=true";
				</#if>
				<#if (('${service_url}')?has_content)>
					params += "&serviceurl="+encodeURIComponent(serviceUrl);
				</#if>
				
				
				return params;
			}
			
			
		</script>
			
	</head>
	
	<body <#if (isDarkmode == 1) > class="darkmode"</#if> <#if (rtl == 1) >dir = "rtl" </#if>>
	
		<div class="bg_one"></div>
		
		<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
    	<div class="Errormsg"> <span class="error_icon"></span> <span class="error_message"></span> </div>
    	
    	
    	
    	
    		<div class="recovery_container container" style="visibility: hidden;">
    			<div class='loader'></div> 
    			<div class='blur_elem blur'></div>
    			
    			<div class="recovery_box" id="recovery_flow">
    			
    				<div class="error_portion">
    					<#if is_portal_logo_url>
    						<div class=""><img class="portal_logo" style="margin:auto;margin-bottom:20px;" src="${portal_logo_url}"/></div>
						<#else>
							<div class='zoho_logo ${service_name}' style="background-position:center;"></div>
    					</#if>
    					<div class="error_content">
    						<div class="restrict_icon"></div>
    						<div class="error_header_container">
	    						<div class="error_header error_IN123 error_IN101"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.NOT.EXIST.HEADER"/></div>
	    						<div class="error_header error_U401"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER"/></div>
	    						<div class="error_header error_U402 error_U403"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.INACTIVE.ACCOUNT.HEADER"/></div>
	    						<div class="error_header access_denied"><@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER"/></div>
    						</div>
    						<div class="error_desc"></div>
    						<div class="domain_wait_warn hide"><@i18n key="IAM.DOMAIN.WAIT.WARNING"/></div>
    						<div class="bottom_option" id="try_again"style="margin:auto;" onclick="backToLookup()"><@i18n key="IAM.TRY.AGAIN"/></div>
    						<div class="bottom_option hide"id="refresh" style="margin:auto;" onclick="Refresh()"><@i18n key="IAM.REFRESH"/></div>
    					</div>
    				</div>
    			
    			
	    			<#if is_portal_logo_url>
						<div class="service_logo"><img class="portal_logo" src="${portal_logo_url}"/></div>
					<#else>
						<div class='service_logo zoho_logo ${service_name}'></div>
					</#if>
					
					<div id="loading_div" class="recover_sections recovery_box_blink">
					
						<div class="info_head box_header_load">
							<span id="headtitle" class="box_head_load"></span>
							<div class="head_info box_define_load"></div>
						</div>
						
						<div class="fieldcontainer" style="margin-top: 70px;">
							<button class="btn blue blink_btn" tabindex="2" disabled="disabled"></button>							
						</div>
					
					</div>
    			
		    			<div id="lookup_div" class="recover_sections">
		    					
							<div class="info_head">
								<div class="user_info" id="recovery_user_info">
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
					           	</div>
					           	
					           	<div class="lookup_head">
			    					<span id="headtitle"><@i18n key="IAM.IP.RESET.HEADING"/></span>
			    					<div class="head_info"><@i18n key="IAM.IP.RESET.DESCRIPTION"/></div>
			    				</div>
			    				
			    				<div class="hide capatcha_head">
			    					<span id="headtitle"><@i18n key="IAM.VERIFY.CAPCTHA.HEAD"/></span>
			    					<div class="head_info"><@i18n key="IAM.VERIFY.CAPCTHA.DESC"/></div>
			    				</div>
			    				
							</div>
							
								
								<form name="login_id_container" onsubmit="return accountLookup(event);" novalidate >
									<div class="searchparent" id="login_id_container">
										<div class="textbox_div">
											<select id="country_code_select" onchange="changeCountryCode();"  name="countryselect">
			                  					<#list country_code as dialingcode>
		                          					<option data-num="${dialingcode.code}" value="${dialingcode.dialcode}" id="${dialingcode.code}" >${dialingcode.display}</option>
		                           				</#list>
											</select>
											<input id="login_id" placeholder="<@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>" value="${Encoder.encodeHTMLAttribute(login_id)}":type="text" name="LOGIN_ID" class="textbox" required="" onkeydown="clearCommonError('login_id')" oninput="input_checking()" autocapitalize="off" autocomplete="on" autocorrect="off" tabindex="1" />
											<div class="fielderror"></div>						
										</div>
									</div>
									
									<div class="textbox_div" id="captcha_container">
											<div id="captcha_img" name="captcha" class="textbox"></div>
											<span class="reloadcaptcha icon-reload" onclick="changeHip()"> </span>
											<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required="" onkeydown="clearCommonError('captcha'),removeCaptchaError('captcha')" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8"/>
											<div class="fielderror"></div> 
									</div>
									<span class="captchafielderror"></span>
									<button class="btn blue" id="nextbtn" tabindex="2" disabled="disabled"><span><@i18n key="IAM.NEXT"/></span></button>
										
									<#include "Zcaptcha.tpl">	
																
									</form>
									<div id='try_signin' class="bottom_line_opt hide"><div class='bottom_option'><@i18n key="IAM.IP.TRY.SIGNIN"/></div></div>
								
		    			
			    		</div>
			    		
			    		
			    		<div id="lookup_err_div" class="recover_sections hide">
	    			
    						<div class="info_head">
							
								<div class="user_info_space user_info" id="recovery_user_info" >
					                <span class="menutext"></span>
					                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
						        </div>
						        
								<span id="headtitle"></span>
		    					<div class="head_info" style="color:#D61212;"></div>
							</div>
	    			
	    				</div>
	    				
	    				<div id="username_div"  class="recover_sections">
	    			
							<div class="info_head">
							
								<div class="user_info_space user_info" id="recovery_user_info">
					                <span class="menutext"></span>
					                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
						        </div>
						        
								<span id="headtitle"><@i18n key="IAM.VERIFY.IDENTITY"/></span>
		    					<div class="head_info"><@i18n key="IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION"/></div>
							</div>
							
							<div class="fieldcontainer">
									<button class="btn blue" id="username_select_action" onclick="call_recusernameScreen()" id="nextbtn" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
							</div>
							
							<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
								
							<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
		    				
		    			</div>
		    			
		    			<div id="other_options_div"  class="recover_sections">
					
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info" >
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
									<div><span class="icon-backarrow backoption" onclick="show_confirm_username_screen()" id="recovery_usernamescreen_bk"></span>
									<span id="headtitle"><@i18n key="IAM.VERIFY.IDENTITY"/></span></div>
			    					<div class="head_info"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DESCRIPTION"/></div>
								</div>
								
								<div class="fieldcontainer">
																
									<div class="optionstry optionmod" id="recover_via_passkey" onclick="initPasskeyOption()" >
										<div class="img_option_try img_option icon-password"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.RELOGIN.VERIFY.VIA.PASSKEY"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.VERIFY.PASSKEY.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="recover_via_device" onclick="show_recDeviceScreen()" >
										<div class="img_option_try img_option icon-device"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DEVICE.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="recover_via_email" onclick="show_recEmailScreen()" >
										<div class="img_option_try img_option icon-email"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="recover_via_mobile" onclick="show_recMobScreen()" >
										<div class="img_option_try img_option icon-otp"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="recover_via_domain" onclick="show_recDomainScreen()" >
										<div class="img_option_try img_option icon-domain"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DOMAIN.HEADING"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DOMAIN.DESCRIPTION"/></div>
										</div>
									</div>
									
									
									<div class="bottom_line_opt"><div class='bottom_option' id='contact_support' onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
		
								</div>
					
						</div>
						
						<div id="confirm_otp_div"  class="recover_sections">
						
									<div class="info_head">
										
										<div class="user_info_space user_info" id="rec_username_user_info" >
							                <span class="menutext"></span>
							                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
								        </div>
										<div><span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
										<span id="headtitle"><@i18n key="IAM.VERIFY.IDENTITY"/></span></div>
				    					<div class="head_info"><@i18n key="IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION"/></div>
									</div>
									
									<div class="fieldcontainer">
										
										<form name="confirm_otp_container" onsubmit="return false;" >
											<div class="searchparent" id="confirm_otp_container">
												<div class="textbox_div">
													<div id="confirm_otp" class="otp_container"></div>
													<input type="hidden" class="hide" id="username_mdigest" />
													<div class="textbox_actions">
														<span id="otp_resend" class="bluetext_action resendotp nonclickelem"></span>
														<div class="resend_text otp_sent" id="otp_sent" style="display:none"><@i18n key="IAM.GENERAL.OTP.SENDING"/></div>
													</div>
													<div class="fielderror"></div>	
												</div>
											</div>
					
											<button class="btn blue" onclick="username_confimation_action()" id="otp_confirm_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
										</form>
										
										<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
										
										<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
										
									</div>
					
						</div>
						
						<div id="recovery_domian_div"  class="recover_sections">
						
							<div class="hide domain_section" id="domain_verification_infostep">
							
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info" >
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
							        <div><span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
									<span id="headtitle"><@i18n key="IAM.AC.SELECT.DOMAIN.MODE.HEADING"/></span></div>
							        
								</div>
								
								<div class="fieldcontainer">
								
									<ol class="domain_verifictaion_steps">
										<li><div class="list-numbering">1</div><div class="step-text"><@i18n key="IAM.AC.DOMAIN.MODE.STEP1"/></div></li>
									  	<div class="list-line" style="top:28px;"></div>
									  	<li><div class="list-numbering">2</div><div class="step-text"><@i18n key="IAM.AC.DOMAIN.MODE.STEP2"/></div></li>
									  	<div class="list-line" style="top:100px;"></div>
									  	<li><div class="list-numbering">3</div><div class="step-text"><@i18n key="IAM.AC.DOMAIN.MODE.STEP3"/></div></li>
									  	<div class="list-line" style="top:172px;"></div>
									  	<li><div class="list-numbering">4</div><div class="step-text"><@i18n key="IAM.IP.DOMAIN.MODE.STEP4"/></div></li>										  
									</ol>
								
								
									<button class="btn blue" onclick="domian_verification_select()" id="otp_confirm_submit" tabindex="2"><span><@i18n key="IAM.CONTINUE"/></span></button>
								
								</div>
								
							</div>
							
							<div class="hide domain_section" id="select_domain_verification">
	
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info" >
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
							        <div><span class="icon-backarrow backoption" onclick='$("#recovery_domian_div .domain_section").hide();$("#recovery_domian_div #domain_verification_infostep").show();'></span>
									<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.DOMAIN"/></span></div>
							        
			    					<div class="head_info"><@i18n key="IAM.AC.CHOOSE.DOMAIN.DESCRIPTION"/></div>
								</div>
								
								<div class="fieldcontainer">
								
								</div>						
							
								<div class="hide empty_domain_template">
										
									<div class="optionstry optionmod" id="recovery_domain"  onclick="show_recovery_domain_confirmationscreen()" >
										<div class="img_option_try img_option icon-domain"></div>
										<div class="option_details_try">
											<div class="option_title_try"></div>
										</div>
									</div>
										
								</div>
									
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
											
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
							
							</div>	
							
							<div class="hide domain_section" id="confirm_domain_verification">
							
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info" >
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
							        <div><span class="icon-backarrow backoption" onclick='domian_verification_select();'></span>
									<span id="headtitle"><@i18n key="IAM.AC.ENTER.DOMAIN"/></span></div>
							        
			    					<div class="head_info"><@i18n key="IAM.AC.ENTER.DOMAIN.DESCRIPTION"/></div>
								</div>
								
								<div class="fieldcontainer">
								
									<form name="domain_confirm_container" onsubmit="return false;" >
										<div class="searchparent" id="domain_confirm_container">
											<div class="textbox_div">
												<input type="hidden" class="hide" id="selected_encrypt_domain"/>
												<input id="domain_confirm" maxlength="253" placeholder="<@i18n key="IAM.AC.ENTER.DOMAIN"/>" name="domain_confirm" class="textbox" required="" onkeydown="clearCommonError('domain_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
												<div class="fielderror"></div>						
											</div>
										</div>
										
										<button class="btn blue" onclick="domian_verification_confim()" id="domain_confirm_submit" tabindex="2"><span><@i18n key="IAM.NEXT"/></span></button>
									</form>
								
								
								</div>	
								
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
											
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
							
							
							</div>
							
							<div class="hide domain_section" id="choose_domain_verification_type">
						
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info">
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
							        <div><span class="icon-backarrow backoption" onclick='$("#recovery_domian_div .domain_section").hide();$("#recovery_domian_div #domain_verification_infostep").show();'></span>
									<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DOMAIN.HEADING"/></span></div>
							        
			    					<div class="head_info"><@i18n key="IAM.AC.CHOOSE.DOMAIN.VERIFICATION.TYPE"/></div>
								</div>
								
								<div class="fieldcontainer">
															
											<div class="domain_options">
												<div class="radiobtn_div">
													<input class="real_radiobtn" onchange="verification_type_confirm(this.value)" type="radio" name="options" id="cname" value="1" >
													<div class="outer_circle">
													<div class="inner_circle"></div></div>
													<label class="radiobtn_text" for="cname"><@i18n key="IAM.AC.DOMAIN.VERIFY.OPTION.CNAME"/></label>
												</div>
												<div class="radiobtn_div" style="border-radius: 4px 0px 0px 4px;border-right:0;">
													<input class="real_radiobtn" onchange="verification_type_confirm(this.value)" type="radio" name="options" id="txt" value="2">
													<div class="outer_circle">
													<div class="inner_circle"></div></div>
													<label class="radiobtn_text" for="txt"><@i18n key="IAM.AC.DOMAIN.VERIFY.OPTION.TXT"/></label>
												</div>											
												<div class="radiobtn_div" style="border-radius: 0px 4px 4px 0px;border-left:0;">
													<input class="real_radiobtn" type="radio" onchange="verification_type_confirm(this.value)" name="options" id="html" value="0">
													<div class="outer_circle">
													<div class="inner_circle"></div></div>
													<label class="radiobtn_text" for="html"><@i18n key="IAM.AC.DOMAIN.VERIFY.OPTION.HTML"/></label>
												</div>
											</div>																																										
								
								</div>	
								
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
											
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
							
							
							</div>
							
							<div class="hide domain_section" id="domain_email_verification">
							
								<div class="info_head">
									
									<div class="user_info_space user_info" id="recovery_user_info">
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
							        
							        <div><span class="icon-backarrow backoption" onclick='$("#recovery_domian_div .domain_section").hide();$("#recovery_domian_div #domain_verification_infostep").show();'></span>
									<span id="headtitle"><@i18n key="IAM.AC.ENTER.DOMAIN.CONTACT_ID.HEADING"/></span></div>
							        
			    					<div class="head_info"><@i18n key="IAM.AC.ENTER.DOMAIN.CONTACT_ID.DESCRIPTION"/></div>
								</div>
								
								<div class="fieldcontainer">
								
									<form name="domain_email_confirm_container" onsubmit="return false;" >
										<div class="searchparent" id="domain_email_confirm_container">
											<div class="show-very-type">
												<div class="type">
													<div class="heading"><@i18n key="IAM.AC.DOMAIN.VERIFY.TYPE"/></div>
													<div class="value-text"></div>
												</div>
												<div class="domain-name">
													<div class="heading"><@i18n key="IAM.AC.DOMAIN.VERIFY.DOMAIN.NAME"/></div>
													<div class="value-text"></div>
												</div>
											</div>
											<div class="textbox_div">
												<input type="hidden" class="hide" id="contact_encrypt_domain"/>
												<input id="domain_email_confirm" maxlength="320" placeholder="<@i18n key="IAM.ENTER.EMAIL"/>" name="domain_email_confirm" class="textbox" required="" onkeydown="clearCommonError('domain_email_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
												<div class="fielderror"></div>						
											</div>
										</div>
										
										<button class="btn blue" onclick="domian_email_confim()" id="domain_email_confirm_submit" tabindex="2"><span><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL"/></span></button>
									</form>
								
								
								</div>	
								
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
											
								<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
							
							
							</div>
							
							<div class="hide domain_section" id="domain_reset_instruction">
								<div class="info_head" style="padding-top:10px;">
									<div class="icon-sucessfill"></div>
									<div id="headtitle" style="margin-top:16px; text-align:center;"><@i18n key="IAM.AC.DOMAIN.INSTRUCTION.HEADING"/></div>
									<div class="head_info"><@i18n key="IAM.AC.DOMAIN.RESET.INSTRUCTION"/></div>								
								</div>
								<div class="footer">
									<@i18n key="IAM.IP.DOMAIN.RESET.DESCRIPTION"/>
								</div>															
							</div>
									
						
						</div>
						
						<div id="recovery_device_div"  class="recover_sections">
	    					
									<div class="info_head">
										<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
				    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING"/></span>
				    					<div class="head_info"><@i18n key="IAM.AC.RECOVERY.MODES.DEVICE.DESCRIPTION"/></div>
									</div>
									
									<div class="fieldcontainer">
										<div class="devices" onclick="updateIcon();">
											<select class='secondary_devices' id="recovery_device_select" onchange='changeRECOVERYSecDevice(this);'></select>
										</div>
										<div id=rnd_number style="display:none;"></div>
										<button class="btn blue hide" id="device_rec_wait" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span></button>
										<button class="btn blue hide" id="device_rec_resend" onclick="resendRecoveryPush($('#recovery_device_select'))" tabindex="1"><span><@i18n key="IAM.PUSH.RESEND.NOTIFICATION"/></span></button>
										<div class="resend_label">
											<span id="otp_resend" class="resendotp push_resend" ></span>
											<span class="rnd_resend_push"><@i18n key="IAM.PUSH.RESEND.NOTIFICATION"/></span>
										</div>
			
									</div>
								
										<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
										
										<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
	    				</div>
						
						
						
						<div id="email_confirm_div"  class="recover_sections">
	    				
			    					<div id="confirm_reocvery_email">
			    					
										<div class="info_head">
											<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
					    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"/></span>
					    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION"/></div>
										</div>
										
										<div class="fieldcontainer">
											
											<form name="email_confirm_container" onsubmit="return false;" >
												<div class="searchparent" id="email_confirm_container">
													<div class="textbox_div">
														<input type="hidden" class="hide" id="selected_encrypt_email"/>
														<input id="email_confirm" placeholder="<@i18n key="IAM.ENTER.EMAIL"/>" name="email_confirm" class="textbox" required="" onkeydown="clearCommonError('email_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
														<div class="fielderror"></div>						
													</div>
												</div>
												
												<button class="btn blue" id="emailconfirm_action" onclick="email_confirmation()" id="nextbtn" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
											</form>
											
										</div>
										
									</div>
									
							
									<div id="select_reocvery_email">
									
										<div class="info_head">
											<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
					    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"/></span>
					    					<div class="head_info"><@i18n key="IAM.IP.RECOVER.EMAIL_ID.DESCRIPTION.MULTI"/></div>
										</div>
										
										<div class="fieldcontainer">
										</div>
										
										<div class="hide empty_email_template">
										
											<div class="optionstry optionmod" id="recovery_email"  onclick="show_recovery_email_confirmationscreen()" >
												<div class="img_option_try img_option icon-email"></div>
												<div class="option_details_try">
													<div class="option_title_try"></div>
													<input type="hidden" class="hide" id="encrypt_recovery_email" />
												</div>
											</div>
											
										</div>
									
									</div>
									
									<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
										
									<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
							
	    				</div>
	    				
	    				<div id="mobile_confirm_div"  class="recover_sections">
	    				
			    					<div id="confirm_reocvery_mobile">
			    					
										<div class="info_head">
											<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
					    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING"/></span>
					    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION"/></div>
										</div>
										
										<div class="fieldcontainer">
											
											<form name="mobile_confirm_container" onsubmit="return false;" >
												<div class="searchparent" id="mobile_confirm_container">
													<div class="textbox_div">
														<input type="hidden" class="hide" id="selected_encrypt_mobile"/>
														<input id="mobile_confirm" maxlength="15" placeholder="<@i18n key="IAM.ENTER.PHONE.NUMBER"/>" name="mobile_confirm" class="textbox" required="" oninput="this.value = this.value.replace(/[^\d]+/g,'')" onkeydown="clearCommonError('mobile_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
														<div class="fielderror"></div>						
													</div>
												</div>
												
												<button class="btn blue" id="mobconfirm_action" onclick="mobile_confirmation()" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
											</form>
											
										</div>
										
									</div>
									
									<div id="select_reocvery_mobile">
									
										<div class="info_head">
											<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
					    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING"/></span>
					    					<div class="head_info"><@i18n key="IAM.IP.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI"/></div>
										</div>
										
										<div class="fieldcontainer">
										</div>
										
										<div class="hide empty_mobile_template">
										
											<div class="optionstry optionmod" id="recovery_mob" onclick="show_recovery_mobilenum_confirmationscreen()" >
												<div class="img_option_try img_option icon-otp"></div>
												<div class="option_details_try">
													<div class="option_title_try"></div>
												</div>
											</div>
											
										</div>
									
									</div>
									
									<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
										
									<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support hide'  onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
			    				
	    				</div>
	    				
	    				<div id="other_mfaoptions_div"  class="recover_sections">
    						
								<div class="info_head">
									<div class="user_info_space user_info" id="recovery_user_info" >
						                <span class="menutext"></span>
						                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
							        </div>
									<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
			    					<div class="head_info"><@i18n key="IAM.IP.CHOOSE.MFA.OTHER_MODES.DESCRIPTION"/></div>
								</div>
								
								<div class="fieldcontainer">
								
								
									<div class="optionstry optionmod" id="mfa_via_device" onclick="show_MfaDeviceScreen()" >
										<div class="img_option_try img_option icon-device"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MFADEVICE.HEADING"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.CHOOSE.OTHER.MFA_MODES.DEVICE.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="mfa_via_totp" onclick="show_MfaTotpScreen()" >
										<div class="img_option_try img_option icon-totp"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.SIGNIN.VERIFY.VIA.AUTHENTICATOR.DESC"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="mfa_via_otp" onclick="show_MfaOtpScreen()" >
										<div class="img_option_try img_option icon-otp"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.SMS.MODE"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.PROFILE.PHONENUMBERS.ADD.NUMBER.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="mfa_via_yubikey" onclick="show_MfaYubikeyScreen()" >
										<div class="img_option_try img_option icon-yubikey"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.YUBIKEY"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.AC.MFA.YUBIKEY.DESCRIPTION"/></div>
										</div>
									</div>
									
									
									<div class="bottom_line_opt"><div class='bottom_option' onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
		
								</div>
    				
    				</div>
    				
    				<div id="mfa_totp_section"  class="recover_sections">
    					
								<div class="info_head">
			    					<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
			    					<div class="head_info"><@i18n key="IAM.NEW.SIGNIN.MFA.TOTP.HEADER"/></div>
								</div>
								
								<div class="fieldcontainer">
								
									 <form name="mfa_totp_container" onsubmit="return false;" > 	
										<div class="searchparent" id="mfa_totp_container">
											<div class="textbox_div">
												<div id="mfa_totp" class="otp_container"></div>
												<div class="fielderror"></div>						
											</div>
										</div>
										
										<button class="btn blue" onclick="mfa_totp_confimration()" id="mfa_totp_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
						 			 </form>
						 			
								</div>
								
								<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
								<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
								
    				</div>
    				
    				<div id="mfa_otp_section"  class="recover_sections">
    				
		    					<div id="mfa_otp_confirm" class="hide">
		    					
									<div class="info_head">
				    					<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
				    					<div class="head_info"><@i18n key="IAM.NEW.SIGNIN.MFA.SMS.HEADER"/></div>
									</div>
									
									<div class="fieldcontainer">
										
										<form name="mfa_otp_container" onsubmit="return false;" > 
											<div class="searchparent" id="mfa_otp_container">
												<div class="textbox_div">
													<input type="hidden" id="mfa_otp_decoded" class="hide"/>
													<input type="hidden" id="mfa_otp_enc" class="hide"/>
													<input type="hidden" id="mfa_otp_mdigest" class="hide"/>
													<div id="mfa_otp" class="otp_container"></div>
													<div class="textbox_actions">
														<span id="otp_resend" class="bluetext_action resendotp nonclickelem"></span>
														<div class="resend_text otp_sent" id="otp_sent" style="display:none"><@i18n key="IAM.GENERAL.OTP.SENDING"/></div>
													</div>
													<div class="fielderror"></div>						
												</div>
											</div>
											
											<button class="btn blue" onclick="mfa_otp_confimration()" id="mfa_otp_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
										</form> 
										
									</div>
									
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_otp_options'id="mfa_otp_view_otherMFA_options" onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_options'id="mfa_otp_view_other_options" onclick='show_mfa_otp_other_options()'><@i18n key="IAM.AC.VIEW.OTP.OTHER.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'id="mfa_otp_contactsupport" onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
								
								</div>
								
								<div id="mfa_otp_select" class="hide">
								
									<div class="info_head">
										<span class="icon-backarrow backoption mfa_backoption" onclick="show_mfa_other_options()"></span>
				    					<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.SELECT.MFA.MOBILE_NUMBER.DESCRIPTION"/></div>
									</div>
									
									<div class="fieldcontainer">
									</div>
									
									<div class="hide empty_mfa_mob_template">
									
										<div class="optionstry optionmod" id="mfa_mobile"  onclick="select_mfa_mob()" >
											<div class="img_option_try img_option icon-otp"></div>
											<div class="option_details_try">
												<div class="option_title_try"></div>
											</div>
										</div>
									</div>
									
									
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
									
								</div>
								
    				</div>
    				
    				<div id="mfa_yubikey_section" class="recover_sections">
    					
								<div class="info_head">
									<span class="icon-backarrow backoption mfa_backoption" onclick="show_mfa_other_options()"></span>
			    					<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
			    					<div class="head_info"><@i18n key="IAM.NEW.SIGNIN.YUBIKEY.HEADER.NEW"/></div>
								</div>
								
								<div class="fieldcontainer">
									
									
									
									<div class="devices" id="list_mfa_yubikeys">
										<select class='secondary_devices' id="mfa_yubikey_select" onchange='changeMFAYubikey(this);'></select>
									</div>
									
									<button class="btn blue" onclick="changeMFAYubikey($('#mfa_yubikey_select'))" id="mfa_yubikey_submit" style="display: inline-block;">
										<span class="loadwithbtn hide"></span>
										<span class="waittext"><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span>
									</button>
								
								</div>
								
								<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
								<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
    				
    				</div>
    				
    				<div id="mfa_device_section"  class="recover_sections">
    					
    							<div id="mfa_device_push_slide" class="mfa_device_sliodes hide">
    							
									<div class="info_head">
				    					<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.VERIFY.PUSH"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.MFA.PUSH.HEADER"/></div>
									</div>
									
									<div class="fieldcontainer">
									
										<div class="devices" id="list_mfa_devices" onclick="updateIcon();">
											<select class='secondary_devices' id="mfa_device_select" onchange='changeMFADevice(this);'></select>
										</div>
										
										<button class="btn hide" id="device_MFA_wait" tabindex="1"><span><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span></button>
										<button class="btn blue hide" id="device_MFA_resend" onclick="resendMFAPush($('#mfa_device_select'))" tabindex="1"><span><@i18n key="IAM.PUSH.RESEND.NOTIFICATION"/></span></button>
										<div class="resend_label hide">
											<span id="otp_resend" class="resendotp push_resend" ></span>
										</div>
									</div>
									
									<div class="bottom_line_opt"><div class='bottom_option mfa_device_screens' onclick='show_mfa_device_other_options("1")'><@i18n key="IAM.AC.MFA.TRY.ANOTHERWAY"/></div></div>
									
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
									
								</div>
								
								<div id="mfa_device_totp_slide" class="mfa_device_sliodes hide">
								
									<div class="info_head">
										<span class="icon-backarrow backoption mfa_device_bk_button" id=""></span>
				    					<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.TOTP"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.MFA.DEVICE.TOTP.DESC"/></div>
									</div>
									
									<div class="fieldcontainer">
									
										<div class="searchparent" id="mfa_device_totp_container">
											<div class="textbox_div">
												<div id="mfa_device_totp" class="otp_container textbox"></div>
												<div class="fielderror"></div>						
											</div>
										</div>
										
										<button class="btn blue" onclick="mfa_devicetotp_confimration()" id="mfa_device_TOTP_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
		
									</div>	
									
									<div class="bottom_line_opt"><div class='bottom_option mfa_device_screens' onclick='show_mfa_device_other_options("2")'><@i18n key="IAM.AC.MFA.TRY.ANOTHERWAY"/></div></div>
									
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
										
								</div>
									
								<div id="mfa_device_qr_slide" class="mfa_device_sliodes hide">
								
									<div class="info_head">
										<span class="icon-backarrow backoption mfa_device_bk_button" id=""></span>
				    					<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.QR.CODE"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.MFA.QR.HEADER"/></div>
									</div>
									
									<div class="fieldcontainer">
									
										<div class="qrcodecontainer">
											<span class="qr_before"></span>
										    <img id="qrimg" src=""/>
										    <span class="qr_after"></span>
										</div>
										 
									</div>
									
									<div class="bottom_line_opt"><div class='bottom_option mfa_device_screens' onclick='show_mfa_device_other_options("3")'><@i18n key="IAM.AC.MFA.TRY.ANOTHERWAY"/></div></div>
									
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
									<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
									
		
								</div>	
								
								<div id="mfa_device_options_slide" class="mfa_device_sliodes hide">
									
									<div class="info_head">
										<span class="icon-backarrow backoption mfa_device_bk_button" id=""></span>
										<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.HEADER"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.CHOOSE.MFA.OTHER_MODES.DESCRIPTION"/></div>
									</div>
									
									<div class="fieldcontainer">
									
										
										<div class="optionstry optionmod" id="mfa_via_device_totp" onclick="tryThisOption(this)" >
											<div class="img_option_try img_option icon-totp"></div>
											<div class="option_details_try">
												<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.TOTP.TITLE"/></div>
												<div class="option_description try_option_desc"><@i18n key="IAM.IP.MFA.DEVICE.TOTP.DESC"/></div>
											</div>
											<div class='otp_verify option_detail verify_device_totp_container hide' id='verify_device_totp_container'> 
												<div id="verify_device_totp" class="otp_container mini_txtbox"></div> 
												<button class="btn blue mini_btn" id="mfa_device_totp_verifybtn" tabindex="2" onclick="mfa_devicetotp_confimration('true')" >
													<span class="loadwithbtn hide"></span>
													<span class="waittext"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span>
												</button>
												<div class="fielderror"></div>
											</div>
										</div>
										
										<div class="optionstry optionmod" id="mfa_via_device_qr" onclick="tryThisOption(this)" >
											<div class="img_option_try img_option icon-qr"></div>
											<div class="option_details_try">
												<div class="option_title_try"><@i18n key="IAM.NEW.SIGNIN.TRY.ANOTHERWAY.SCANQR.TITLE"/></div>
												<div class="option_description try_option_desc"><@i18n key="IAM.AC.MFA.QR.DESC"/></div>
											</div>
											<div class='verify_qr option_detail verify_device_qr_container hide' id='verify_device_qr_container'> 
												<div class="qrcodecontainer">
													<div>
														<span class='qr_before'></span>
													    <img id="verify_qrimg" src=""/>
													   	<span class='qr_after'></span>
													   	<div class="loader"></div>
													   	<div class="blur_elem blur"></div>
												   	</div>												   	
												</div>
												<#if is_mobile>
												<div class="btn blue waitbtn" id="openoneauth" onclick="QrOpenApp()">
													<span class="oneauthtext"><@i18n key="IAM.NEW.SIGNIN.OPEN.ONEAUTH"/></span>
												</div>
												</#if>
											</div>
										</div>
											
										<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
										<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options'onclick='show_contactsupport()'><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div></div>
								
									</div>
									
								</div>
								
						</div>
						
						<div id="reset_ip_INFO"  class="recover_sections">
	    			
							<div class="info_head">
								<div class="user_info_space user_info" id="recovery_user_info" >
					                <span class="menutext"></span>
					                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
						        </div>
						        <div><span class="icon-backarrow backoption" onclick="show_reset_ipChoice()" id="resetip_bk_arrow"></span>
								<span id="headtitle"><@i18n key="IAM.IP.RESET.HEADING"/></span></div>
		    					<div class="head_info"><@i18n key="IAM.IP.RESET.USER_VERIFICATION.SUCCESS"/></div>
							</div>
							
							<div class="fieldcontainer hide" id="user_reset_info">
							
									<div class="self_confirmation"><@i18n key="IAM.IP.RESET.SECTION.USER.DESCRIPTION"/></div>
									
									<button class="btn blue" onclick="remove_ip_restriction('userIp')" id="remove_ip" tabindex="2"><span><@i18n key="IAM.REMOVE"/></span></button>
							</div>
							
							<div class="fieldcontainer hide" id="ORG_reset_info">
									
									<button class="btn blue" onclick="remove_ip_restriction('orgIp')" id="remove_ip" tabindex="2"><span><@i18n key="IAM.REMOVE"/></span></button>
							</div>
							
							<div class="fieldcontainer hide" id="choose_ip_reset_info">
								
									<div class="ip_choose_desc"><@i18n key="IAM.IP.RESET.SECTION.CHOOSE.DESCRIPTION"/></div>
									
									<div class="optionstry optionmod" id="resetip_self" onclick="show_user_reset_IP()" >
										<div class="img_option_try img_option icon-device"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.IP.RESET.SECTION.SELF.TITLE"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.IP.RESET.SECTION.CHOOSE.SELF.DESCRIPTION"/></div>
										</div>
									</div>
									
									<div class="optionstry optionmod" id="resetip_org" onclick="show_org_reset_IP(true)" >
										<div class="img_option_try img_option icon-totp"></div>
										<div class="option_details_try">
											<div class="option_title_try"><@i18n key="IAM.IP.RESET.SECTION.ORG.TITLE"/></div>
											<div class="option_description try_option_desc"><@i18n key="IAM.IP.RESET.SECTION.CHOOSE.ORG.DESCRIPTION"/></div>
										</div>
									</div>
							</div>
								    				
	    				</div>
	    				
	    				<div id="self_resetIP_confimation"  class="recover_sections">
    					
								<div class="info_head">
									<div class="user_info" id="recovery_user_info" >
							                <span class="menutext"></span>
							                <span class="change_user" onclick="change_user()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
						           	</div>
			    					<span id="headtitle"><@i18n key="IAM.RESETIP.SUCCESS.ORG.RESET"/></span>
			    					<div class="head_info grn_txt"><@i18n key="IAM.RESETIP.SUCCESS.USER.RESET.DESC"/></div>
								</div>
								
								<div class="fieldcontainer" id="setup_ip_desc">
									<div class="user_newIP_setup"><@i18n key="IAM.RESETIP.RECONFIGURE.DESC"/></div>
									<button class="btn blue nocaps" onclick="setup_new_IP()" id="setup_ip" tabindex="2"><span><@i18n key="IAM.RESETIP.RECONFIGURE"/></span></button>
								</div>
								
								<div class="bottom_line_opt"><div class='bottom_option' id='skip_newsetup' onclick='swicth_to_signin()'><@i18n key="IAM.DOIT.LATER"/></div></div>
								
						</div>
						
						<div id="setup_new_ip_section"  class="recover_sections">
						
								<div class="info_head">
			    					<div><span class="icon-backarrow backoption" id="setup_ip_bk" onclick="$(".recover_sections").hide();$("#self_resetIP_confimation").show();"></span>
									<span id="headtitle"><@i18n key="IAM.RESETIP.NEW.CONFIGURE"/></span></div>
			    					<div class="head_info"><@i18n key="IAM.RESETIP.NEW.CONFIGURE.DESC"/></div>
								</div>
								
								<div class="fieldcontainer" id="setup_ip_space">
									
									 <form name ="addip"  id="allowedipform" onsubmit="return addipaddress(this)" >
						
										<div id="get_ip">
												
											<div id="current_ip" class="radiobtn_div">
												<input class="real_radiobtn photo_radio" checked="checked" type="radio" name="ip_select" id="current_ip_sel" value="1">
												<div class="outer_circle">
													<div class="inner_circle"></div>
												</div>
												<label for="current_ip_sel" class="radiobtn_text"><@i18n key="IAM.IP.ADD.CURRENT" /> (<span class="ip_blue"></span>)<label>
											</div>
											<input type="hidden" id="cur_ip" name="cur_ip" value=""/>
												
											<div class="radiobtn_div">
												<input class="real_radiobtn photo_radio" type="radio" name="ip_select" id="static_ip_sel" value="2">
												<div class="outer_circle">
													<div class="inner_circle"></div>
												</div>
												<label for="static_ip_sel" class="radiobtn_text"><@i18n key="IAM.IP.ADD.STATIC" /> </label>
											</div>	
											<div id="static_ip" class="hide ip_cell_parent">
												<div id="static_ip_field" class="ip_field_div"></div>
												<div class="fielderror"></div>
											</div>
												
											<div class="radiobtn_div">
												<input class="real_radiobtn photo_radio" type="radio" name="ip_select" id="range_ip_sel" value="3">
												<div class="outer_circle">
													<div class="inner_circle"></div>
												</div>
												<label for="range_ip_sel" class="radiobtn_text"><@i18n key="IAM.IP.ADD.RANGE" /> </label>
											</div>
											<div id="range_ip" class="ip_cell_parent hide">
												<div>	
													<div id="from_ip_field" class="ip_field_div"></div>			
													<span class="range_to_sep"><@i18n key="IAM.TO" /> </span>				
													<div id="to_ip_field" class="ip_field_div"></div>
													<div class="fielderror"></div>
												</div>							
											</div>
											<button class="btn blue" type="button" id="setup_ip" onclick="addipaddress(document.forms['allowedipform']);" tabindex="2"><span><@i18n key="IAM.NEXT"/></span></button>
					
										</div>
										
										<div class="hide" id="get_name">
											
											<div class="ip_info_div">
												<div class="ip_info_lable"><@i18n key="IAM.IP.YOUR.ADDRESS" /> </div>
												<div class="info_value" id="ip_range_forNAME"></div>
											</div>
											
											
											<div class="searchparent" id="ip_name_container">
												<div class="textbox_div">
													<input id="ip_name" placeholder="<@i18n key="IAM.IP.NAME"/>" name="ip_name" class="textbox" onkeydown="clearCommonError('ip_name')" autocapitalize="off" autocorrect="off" tabindex="1" />
													<div class="ip_info_warn"><@i18n key="IAM.RESETIP.NEW.CONFIGURE.NAME.WARN" /></div>	
													<div class="fielderror"></div>						
												</div>
											</div>
											<input type="text" class="ip_hide" data-validate="zform_field" name="fip" autocomplete="address-line1" id="fip"/>
											<input type="text" class="ip_hide" data-validate="zform_field" name="tip" autocomplete="address-line2" id="tip"/>
											
								    		<button class="btn blue" type="submit" id="add_new_ip" tabindex="2"><span><@i18n key="IAM.ADD"/></span></button>
								    		
										</div>
										
									</form>
									
								</div>
								
    					</div>
	    				
	    				
	    				
	    				<div class="success_portion hide">
	    					<#if is_portal_logo_url>
	    						<div class=""><img class="portal_logo" style="margin:auto;margin-bottom:20px;" src="${portal_logo_url}"/></div>
							<#else>
								<div class='zoho_logo ${service_name}' style="background-position:center;"></div>
	    					</#if>
	    					<div class="error_content">
	    						<div class="blue_tick"></div>
	    						<div class="error_header_container">
		    						<div class="success_header"><@i18n key="IAM.RESETIP.SUCCESS.ORG.RESET"/></div>
	    						</div>
	    						<div class="reset_ip_success_msg"><@i18n key="IAM.RESETIP.SUCCESS.ORG.RESET.DESC"/></div>
	    						<button class="btn blue" onclick="swicth_to_signin()" id="remove_ip" tabindex="2"><span><@i18n key="IAM.CONTINUE"/></span></button>
	    					</div>
	    				</div>
	    				
						
						<div id="contact_support_div"  class="recover_sections">
					
								<div id="normal_contact_support" class="support_sections">
								
									<div class="info_head">
										<span class="icon-backarrow backoption support_bk_button" id="support_bk_button"></span>
			    						<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></span>
				    					<div class="head_info">
				    						<div style="margin-bottom:20px"><@i18n key="IAM.AC.CONTACT.SUPPORT.HELP.DESC"/> </div>
				    						<div class="normal_mode_support_contactid"><@i18n key="IAM.AC.CONTACT.SUPPORT.NO_OPTION.CONTACT" arg0="${support_email_address}"/></div>
				    					</div>
									</div>
									
								</div>
								
								<div id="org_contact_support" class="support_sections">
								
									<div class="info_head">
										<span class="icon-backarrow backoption support_bk_button" id="support_bk_button"></span>
			    						<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></span>
				    					<div class="head_info"><@i18n key="IAM.IP.CONTACT.ORG.SUPPORT.DESC"/></div>
									</div>

								</div>
								
								<div id="no_recovery_mode_support" class="support_sections">
								
									<div class="info_head">
			    						<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></span>
				    					<div class="head_info">
				    						<div style="margin-bottom:20px"><@i18n key="IAM.AC.CONTACT.SUPPORT.HELP.DESC"/> </div>
				    						<div style="margin-bottom:20px"><@i18n key="IAM.IP.CONTACT.SUPPORT.NO_OPTION.DESC"/></div>
				    						<div class="no_recovery_mode_support_contactid"><@i18n key="IAM.AC.CONTACT.SUPPORT.NO_OPTION.CONTACT" arg0="${support_email_address}"/></div>
				    					</div>
									</div>

								</div>
									
								<div id="support_norm_desc" class="fieldcontainer">
								
									<div class="support_temp_info"><@i18n key="IAM.AC.TEMP.SUPPORT.DESCRIPTION" /></div>
								</div>
								
								<div id="support_help_article" class="bottom_line_opt"><a href="${user_guide_link}" target="_blank" class="bottom_option "><@i18n key="IAM.NEW.PASSWORD.RECOVERY.HELP.ARTICLES"/></a></div>
									
								<div id="support_go_bk" onclick="change_user()" class="bottom_line_opt bottom_option hide"><@i18n key="IAM.AC.CONTACT.SUPPORT.GO_BACK"/></div>
								
								
								<div id="main_contact_support" class="support_sections">
								
									<div class="info_head">
			    						<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></span>
				    					<div class="head_info"><@i18n key="IAM.AC.CONTACT.SUPPORT.DESCRIPTION"/></div>
				    					<span class="change_cont_suport" onclick="change_contactemail()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
									</div>
								
									
									<div class="fieldcontainer">
									
										<div class="searchparent hide" id="contact_supportexpl_container">
											<div class="textbox_div">
												<textarea id="contact_supportexpl" placeholder="<@i18n key="IAM.AC.CONTACT.SUPPORT.PLACEHOLDER"/>" type="text" name="contact_supportexpl" class="textbox" required="" onkeydown="clearCommonError('contact_supportexpl')" autocapitalize="off" autocorrect="off" tabindex="1" ></textarea>
												<div class="fielderror"></div>						
											</div>
										</div>
										
										<button class="btn blue" id="main_contact_support_action" onclick="contact_support()" tabindex="2"><span><@i18n key="IAM.SUBMIT"/></span></button>
										
									</div>
								
								</div>
								
								<div id="change_contactemail_support" class="support_sections">
								
									<div class="info_head">
			    						<span id="headtitle"><@i18n key="IAM.AC.SIGNIN.CONTACT.CHANGE.EMAIL_HEAD"/></span>
				    					<div class="head_info"><@i18n key="IAM.AC.SIGNIN.CONTACT.CHANGE.EMAIL_DESCRIPTION"/></span></div>
									</div>
									
									<div class="fieldcontainer">
									
											<div class="searchparent hide" id="change_contact_support_container">
												<div class="textbox_div">
													<input id="change_contact_support" placeholder="<@i18n key=""/>" type="text" name="contact_support" class="textbox" required="" onkeydown="clearCommonError('change_contact_support')" autocapitalize="off" autocorrect="off" tabindex="1" />
													<div class="fielderror"></div>	
													<div class="text_warn"><@i18n key="IAM.AC.SIGNIN.CONTACT.CHANGE.EMAIL_WARNING"/></div>					
												</div>
											</div>
											
											<button class="btn blue" id="change_contact_support_action" onclick="change_contact_support()" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
											
									</div>
								
								</div>
								
								<div id="confirm_contact_support" class="support_sections">
								
									<div class="info_head">
			    						<span id="headtitle"><@i18n key="IAM.AC.SIGNIN.CONTACT.CONFIRM.CHANGE.EMAIL_HEAD"/></span>
				    					<div class="head_info"><@i18n key="IAM.AC.SIGNIN.CONTACT.CONFIRM.CHANGE.EMAIL_DESCRIPTION"/></span></div>
									</div>
									
									<div class="fieldcontainer">
									
											<div class="searchparent hide" id="verify_contact_support_container">
												<div class="textbox_div">
													<input id="verify_contact_support" placeholder="<@i18n key=""/>" type="text" name="contact_support" class="textbox" required="" onkeydown="clearCommonError('verify_contact_support')" autocapitalize="off" autocorrect="off" tabindex="1" />
													<div class="textbox_actions">
														<span id="otp_resend" class="bluetext_action resendotp nonclickelem"></span>
													</div>
													<div class="fielderror"></div>					
												</div>
											</div>
											
											<button class="btn blue" id="confirm_contact_support_action" onclick="confirm_change_contact_support()" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
											
									</div>
								
								</div>
    				
    					</div>
			    		
			    	</div>
	    	</div>
	    	<#include "footer.tpl">
	</body>
</html>
