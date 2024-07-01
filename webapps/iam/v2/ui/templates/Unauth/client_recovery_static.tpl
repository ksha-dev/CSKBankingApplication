
	<@resource path="/v2/components/css/uvselect.css" />	
    <#if (('${css_url}')?has_content)>
		<link href="${css_url}" type="text/css" rel="stylesheet"/>
	<#else>
	    <@resource path="/v2/components/css/clientaccountrecoveryStyle.css" />
	</#if>
	<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
	<@resource path="/v2/components/js/zresource.js" /> 
	<@resource path="/v2/components/js/uri.js" /> 
	<@resource path="/v2/components/js/common_unauth.js" />
	<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
	<@resource path="/v2/components/css/${customized_lang_font}" />
	<@resource path="/v2/components/css/flagStyle.css" />
	<@resource path="/v2/components/js/splitField.js" /> 
	<@resource path="/v2/components/js/uvselect.js" />
	<@resource path="/v2/components/js/flagIcons.js" />
	<@resource path="/v2/components/css/flagIcons.css" />
	<@resource path="/v2/components/css/uv_unauthStatic.css" />
	<@resource path="/v2/components/js/accountrecovery.js" />
	<script type="text/javascript" src="${uri_prefix}/encryption/script"></script>
	<@resource path="/v2/components/js/security.js" />
	<meta name="robots" content="noindex, nofollow"/>
	<script type='text/javascript'>
			var aCParams = getACParms();
			var login_id = "${Encoder.encodeJavaScript(login_id)}";
			var csrfParam = "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var reqCountry = "${req_country}";
			var isMobile = Boolean("<#if is_mobile>true</#if>");
			var isDarkMode = parseInt("${isDarkmode}");
			var contextpath = "${context_path}";
			var uriPrefix = "${uri_prefix}";
			var wmscount = 0;
			var digest_id = "";
			var isClientPortal = parseInt("${isClientPortal}");
			var ZlabsCapthca_enabled = false;
			var supportEmailAddr = "";
			var recoveryUri = "${recovery_uri}";
			var otp_length = ${otp_length};
			var totp_size = ${totp_size};
			var wmsSRIValues = ${za.wmsSRIValues};
			<#if (('${digest_id}')?has_content)>
			digest_id = "${digest_id}";
			</#if>
			var serviceUrl, serviceName, signin_redirect_url, zuid, cdigest, head_token, resendTimer, mdigest, recovery_modes, recovery_extra_modes, contact_support_email, password_policy, mzadevicepos, isWmsRegistered, wmscallmode, wmscallid, wmscallapp, _time;
			var org_name, org_contact, reload_page, token, orgType;
			
			I18N.load({
				"IAM.PLEASE.CONNECT.INTERNET" : '<@i18n key="IAM.PLEASE.CONNECT.INTERNET" />',
				"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD" />',
				"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" />',
				"IAM.AC.ERROR.LOGIN.NOT.VALID" : '<@i18n key="IAM.AC.ERROR.LOGIN.NOT.VALID" />',
				"IAM.SIGNIN.ERROR.CAPTCHA.INVALID" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID" />',
				"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
				"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
				"IAM.NEXT" : '<@i18n key="IAM.NEXT" />',
				"IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION" : '<@i18n key="IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION" />',
				"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN" />',
				"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" />',
				"IAM.NEW.SIGNIN.OTP.SENT" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT" />',
				"IAM.VERIFY.CODE" : '<@i18n key="IAM.VERIFY.CODE" />',
				"IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION" : '<@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION" />',
				"IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION.MULTI" : '<@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION.MULTI" />',
				"IAM.AC.CONFIRM.EMAIL.VALID" : '<@i18n key="IAM.AC.CONFIRM.EMAIL.VALID" />',
				"IAM.AC.CONFIRM.MOBILE.VAlID" : '<@i18n key="IAM.AC.CONFIRM.MOBILE.VAlID" />',
				"IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION" : '<@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION" />',
				"IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" : '<@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI" />',
				"IAM.AC.CONTACT.SUPPORT.DESCRIPTION" : '<@i18n key="IAM.AC.CONTACT.SUPPORT.DESCRIPTION" />',
				"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" />',
				"IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE" : '<@i18n key="IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE" />',
				"IAM.RESETPASS.PASSWORD.MIN" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN" />',
				"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" />',
				"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" />',
				"IAM.PASS_POLICY.CASE" : '<@i18n key="IAM.PASS_POLICY.CASE" />',
				"IAM.PASSWORD.POLICY.HEADING" : '<@i18n key="IAM.PASSWORD.POLICY.HEADING" />',
				"IAM.RESETPASS.PASSWORD.MIN" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN" />',
				"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" />',
				"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" />',
				"IAM.RESETPASS.PASSWORD.MIN.NO.WITH" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH" />',
				"IAM.INCLUDE" : '<@i18n key="IAM.INCLUDE" />',
				"IAM.AC.NEW.PASSWORD.EMPTY.ERROR" : '<@i18n key="IAM.AC.NEW.PASSWORD.EMPTY.ERROR" />',
				"IAM.AC.NEW.PASSWORD.POLICY.CHECK" : '<@i18n key="IAM.AC.NEW.PASSWORD.POLICY.CHECK" />',
				"IAM.AC.REENTER.PASSWORD.EMPTY.ERROR" : '<@i18n key="IAM.AC.REENTER.PASSWORD.EMPTY.ERROR" />',
				"IAM.NEW.SIGNIN.WAITING.APPROVAL" : '<@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL" />',
				"IAM.AC.CHOOSE.OTHER_MODES.USERNAME.DESCRIPTION" : '<@i18n key="IAM.AC.CHOOSE.OTHER_MODES.USERNAME.DESCRIPTION" />',
				"IAM.AC.ERROR.REFRESH.OPTION" : '<@i18n key="IAM.AC.ERROR.REFRESH.OPTION" />',
				"IAM.NEW.SIGNUP.EMAIL.VERIFY.DESC" : '<@i18n key="IAM.NEW.SIGNUP.EMAIL.VERIFY.DESC" />',
				"IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC" : '<@i18n key="IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC" />',
				"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
				"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP" />',
				"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />',
				"IAM.PUSH.TITLE.PASSWORD.CHANGED.ALERT" : '<@i18n key="IAM.PUSH.TITLE.PASSWORD.CHANGED.ALERT" />',
				"IAM.AC.SELECT.USERNAME.EMAIL.DESCRIPTION" : '<@i18n key="IAM.AC.SELECT.USERNAME.EMAIL.DESCRIPTION" />',
				"IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION" : '<@i18n key="IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION" />',
				"IAM.AC.CONTACT.ORG.SUPPORT.DESC" : '<@i18n key="IAM.AC.CONTACT.ORG.SUPPORT.DESC" />',
				"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
				"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
				"IAM.AC.RECOVER.LOOKUP.ERROR.EMAIL.OR.USERNAME" : '<@i18n key="IAM.AC.RECOVER.LOOKUP.ERROR.EMAIL.OR.USERNAME" />',
				"IAM.AC.RECOVER.LOOKUP.ERROR.MOBILE" : '<@i18n key="IAM.AC.RECOVER.LOOKUP.ERROR.MOBILE" />',
				"IAM.NEW.SIGNIN.TITLE.RANDOM" : '<@i18n key="IAM.NEW.SIGNIN.TITLE.RANDOM" />',
				"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
				"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
				"IAM.PASS_POLICY.SPL" : '<@i18n key="IAM.PASS_POLICY.SPL" />',
				"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
				"IAM.PASS_POLICY.NUM" : '<@i18n key="IAM.PASS_POLICY.NUM" />',
				"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
				"IAM.AC.DONT.REMEMBER": '<@i18n key="IAM.AC.DONT.REMEMBER" />',
				"IAM.NEW.SIGNIN.CONTACT.SUPPORT": '<@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT" />',
				"IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE": '<@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE" />',
				"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" />',
				"IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" : '<@i18n key="IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" />',
				"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" />',
				"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID" />',
				"IAM.NEW.SIGNIN.OTP.SENT.RESEND" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT.RESEND" />',
				"IAM.AC.SIGNIN.EMAIL.ADDRESS.OR.MOBILE" : '<@i18n key="IAM.AC.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>',
				"IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" />',
			});
				
			function getACParms()
			{
				var params="";
				<#if (('${service_name}')?has_content)>
					params += "servicename=" + euc('${service_name}');
					serviceName=euc('${service_name}');
				</#if>
				<#if (('${service_url}')?has_content)>
					params += "&serviceurl="+euc('${Encoder.encodeJavaScript(service_url)}');
					serviceUrl = '${Encoder.encodeJavaScript(service_url)}';
				</#if>	
				<#if (('${org_type}')?has_content)>
					params+="&orgtype="+euc('${org_type}');
					orgType = euc('${org_type}');
				</#if>
				
				return params;
			}
		
			window.onload = function() 
			{
				<#if !(('${is_preview_fp}')?has_content)>
					$("#nextbtn").removeAttr("disabled");
				</#if>
				onRecoveryReady();
				<#if (('${login_id}')?has_content)>
					fetchLookupDetails("${Encoder.encodeJavaScript(login_id)}");
				</#if>
				<#if (('${digest_id}')?has_content)>
					fetchLookupDetails("${Encoder.encodeJavaScript(digest_id)}");
				</#if>
				$(".bottom_option,.backoption,.change_user").click(function(){
					$(".errorborder").removeClass("errorborder");
					$(".fielderror").slideUp(100);
					$(".fielderror").removeClass("errorlabel");
					$(".fielderror").text("");
				});
			}
		</script>
