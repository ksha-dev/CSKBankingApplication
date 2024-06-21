
		<link href="${SCL.getStaticFilePath("/v2/components/css/uvselect.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/flagIcons.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/uv_unauthStatic.css")}" rel="stylesheet"type="text/css">
		<#if (('${signin.css_url}')?has_content)>
			<link href="${signin.css_url}" type="text/css" rel="stylesheet"/>
		<#else>
			<link href="${SCL.getStaticFilePath("/v2/components/css/clientsignin.css")}" type="text/css" rel="stylesheet"/>
		</#if>
		<link href="${SCL.getStaticFilePath("/v2/components/css/fedsignin.css")}" type="text/css" rel="stylesheet"/>
        <script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
        <script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}" type="text/javascript"></script>
        <script src="${SCL.getStaticFilePath("/v2/components/js/uvselect.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/flagIcons.js")}" type="text/javascript"></script>
        <script src="${SCL.getStaticFilePath("/v2/components/js/signin.js")}" type="text/javascript"></script>
        <script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}" type="text/javascript"></script>
	<meta name="robots" content="noindex, nofollow"/>
	<script type='text/javascript'>
        	var serviceUrl,serviceName,orgType;
			var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var resetPassUrl = '${signin.resetPassUrl}';
			var queryString = window.location.search.substring(1);
			var signinParams= getSigninParms();
			var isMobile = parseInt('${signin.isMobile}');
			var loginID = "${Encoder.encodeJavaScript(signin.loginId)}";
			var isCaptchaNeeded ="${signin.captchaNeeded}";
			var UrlScheme = "${signin.UrlScheme}";
			var iamurl="${signin.iamurl}";
			var displayname = "${Encoder.encodeJavaScript(signin.app_display_name)}";
			var reqCountry="${signin.reqCountry}";
			var cookieDomain="${signin.cookieDomain}";
			var iam_reload_cookie_name="${signin.iam_reload_cookie_name}";
			var isDarkMode = parseInt("${signin.isDarkmode}");
			var isMobileonly = 0;
			var isClientPortal = parseInt("${signin.isClientPortal}");
			var uriPrefix = '${signin.uri_prefix}';
			var contextpath = "${za.contextpath}";
			var CC = '${signin.CC}';
			var isShowFedOptions = parseInt("<#if signin.showfs>1<#else>0</#if>");
			var fedlist = "";
			var magicdigest = "${signin.magicdigest}";
			var magicEndpoint = "";
			var isneedforGverify = 0;
			var isPreview = Boolean("<#if signin.is_preview_signin>true</#if>");
			var trySmartSignin = false;
			var load_iframe = parseInt("${signin.load_iframe}");
			var signin_info_urls;
			var IDPRequestURL = "${signin.IDPRequestURL}";
			var emailOnlySignin = Boolean("<#if signin.emailOnly>true</#if>");
			var isMobilenumberOnly = parseInt("${signin.mobileOnly}");
			var otp_length = ${otp_length};
			
			I18N.load({
					"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
					"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" />',
					"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.EMPTY" />',
					"IAM.SIGN_IN" : '<@i18n key="IAM.SIGN_IN" />', 
					"IAM.NEXT" : '<@i18n key="IAM.NEXT" />', 
					"IAM.NEW.SIGNIN.VERIFY" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY" />',
					"IAM.SEARCHING":'<@i18n key="IAM.SEARCHING"/>',
					"IAM.EMAIL.ADDRESS":'<@i18n key="IAM.EMAIL.ADDRESS"/>',
					"IAM.NO.RESULT.FOUND":'<@i18n key="IAM.NO.RESULT.FOUND"/>',
					"IAM.NEW.SIGNIN.ENTER.EMAIL.OR.MOBILE" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.EMAIL.OR.MOBILE" />',
					"IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST":'<@i18n key="IAM.SIGNIN.ERROR.USEREMAIL.NOT.EXIST"/>',
					"IAM.NEW.SIGNIN.SERVICE.NAME.TITLE":'<@i18n key="IAM.NEW.SIGNIN.SERVICE.NAME.TITLE"/>',
					"IAM.NEW.SIGNIN.RESEND.OTP":'<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>',
					"IAM.TFA.RESEND.OTP.COUNTDOWN":'<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
					"IAM.NEW.SIGNIN.OTP.SENT.DEVICE" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT.DEVICE" />',
					"IAM.NEW.SIGNIN.OTP.SENT" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT" />',
					"IAM.MOBILE.OTP.SENT" : '<@i18n key="IAM.MOBILE.OTP.SENT" />',
					"IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.OTP.MESSAGE.NEW" />',
					"IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW":'<@i18n key="IAM.NEW.SIGNIN.INVALID.EMAIL.MESSAGE.NEW"/>',
					"IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC.NOW":'<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.ORG.DESC.NOW"/>',
					"IAM.PASSWORD.POLICY.HEADING":'<@i18n key="IAM.PASSWORD.POLICY.HEADING"/>',
				    "IAM.RESETPASS.PASSWORD.MIN":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN"/>',
					"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY":'<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY"/>',
					"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY":'<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY"/>',
					"IAM.PASS_POLICY.CASE":'<@i18n key="IAM.PASS_POLICY.CASE"/>',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH":'<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH"/>',
					"IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.TITLE":'<@i18n key="IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.TITLE"/>',
					"IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.BUTTON":'<@i18n key="IAM.NEW.SIGNIN.PASS.EXPIRY.SUCCESS.BUTTON"/>',
					"IAM.TFA.TRUST.BROWSER.QUESTION" : '<@i18n key="IAM.TFA.TRUST.BROWSER.QUESTION" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.TOTP" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.TOTP" />',
					"IAM.NEW.SIGNIN.TRUST.HEADER.OTP" : '<@i18n key="IAM.NEW.SIGNIN.TRUST.HEADER.OTP" />',
					"IAM.GOOGLE.AUTHENTICATOR" : '<@i18n key="IAM.GOOGLE.AUTHENTICATOR" />',
					"IAM.NEW.SIGNIN.SMS.MODE" : '<@i18n key="IAM.NEW.SIGNIN.SMS.MODE" />',
					"IAM.NEW.SIGNIN.TOTP" : '<@i18n key="IAM.NEW.SIGNIN.TOTP" />',
					"IAM.NEW.SIGNIN.MFA.TOTP.HEADER":'<@i18n key="IAM.NEW.SIGNIN.MFA.TOTP.HEADER"/>',
					"IAM.NEW.SIGNIN.MFA.SMS.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.MFA.SMS.HEADER" />',		
					"IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE" />',
					"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER":'<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
					"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.TFA.USE.BACKUP.CODE" : '<@i18n key="IAM.TFA.USE.BACKUP.CODE" />',
					"IAM.NEW.SIGNIN.CANT.ACCESS" : '<@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS" />',
					"IAM.NEW.SIGNIN.BACKUP.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER" />',
					"IAM.NEW.SIGNIN.CONTACT.SUPPORT" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT" />',
					"IAM.NEW.SIGNIN.ENTER.VALID.BACKUP.CODE" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.VALID.BACKUP.CODE" />',
					"IAM.SIGNIN.ERROR.CAPTCHA.INVALID":'<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID"/>',
					"IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE":'<@i18n key="IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"/>',
					"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
					"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
					"IAM.PASS_POLICY.SPL" : '<@i18n key="IAM.PASS_POLICY.SPL" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PASS_POLICY.NUM" : '<@i18n key="IAM.PASS_POLICY.NUM" />',
					"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
					"IAM.ERROR.PASS.LEN":'<@i18n key="IAM.ERROR.PASS.LEN"/>',
					"IAM.PASSWORD.POLICY.LOGINNAME":'<@i18n key="IAM.PASSWORD.POLICY.LOGINNAME"/>',
					"IAM.NEW.SIGNIN.USING.MOBILE.OTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.MOBILE.OTP" />',
					"IAM.NEW.SIGNIN.USING.EMAIL.OTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.EMAIL.OTP" />',
					"IAM.NEW.GENERAL.SENDING.OTP" : '<@i18n key="IAM.NEW.GENERAL.SENDING.OTP" />',
					"IAM.NEW.SIGNIN.TITLE.RANDOM":'<@i18n key="IAM.NEW.SIGNIN.TITLE.RANDOM"/>',
					"IAM.SIGNIN.OTP.THRESHOLD.LIMIT2" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.LIMIT2" />',
					"IAM.SIGNIN.OTP.THRESHOLD.LIMIT.ENDS" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.LIMIT.ENDS" />',
					"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT2" />',
					"IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" : '<@i18n key="IAM.SIGNIN.OTP.MAX.COUNT.MFA.LIMIT.ENDS" />',
					"IAM.SIGNIN.OTP.THRESHOLD.LIMIT1" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.LIMIT1" />',
					"IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" : '<@i18n key="IAM.SIGNIN.OTP.THRESHOLD.MFA.LIMIT1" />',
					"IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE" />',
					"IAM.NEW.SIGNIN.CONTACT.ADMIN.DESC" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.DESC" />',
					"IAM.NEW.SIGNIN.OTP.SENT.RESEND" : '<@i18n key="IAM.NEW.SIGNIN.OTP.SENT.RESEND" />',
					"IAM.NEW.SIGNIN.JWT.TITLE":'<@i18n key="IAM.NEW.SIGNIN.JWT.TITLE"/>',
					"IAM.ERROR.VALID.OTP":'<@i18n key="IAM.ERROR.VALID.OTP"/>',
					"IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE" : '<@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>',
					"IAM.MOBILE" : '<@i18n key="IAM.MOBILE"/>',
					"IAM.SIGNIN.VIA.MAGIC.LINK" : '<@i18n key="IAM.SIGNIN.VIA.MAGIC.LINK"/>',
					"IAM.SIGNIN.VIA.MAGIC.LINK.DESC" : '<@i18n key="IAM.SIGNIN.VIA.MAGIC.LINK.DESC"/>',
					"IAM.PLEASE.CONNECT.INTERNET" : '<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>',
					"IAM.EMPTY.BACKUPCODE.ERROR" : '<@i18n key="IAM.EMPTY.BACKUPCODE.ERROR"/>',
					"IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" : '<@i18n key="IAM.NEW.SIGNIN.INVALID.LOOKUP.IDENTIFIER" />',
				});
			$(document).ready(function() {
				fediconsChecking();
				return false;
			});
			window.onload = function() {
				<#if !(('${signin.is_preview_signin}')?has_content)>
					$("#nextbtn").removeAttr("disabled");
				</#if>
				<#if (('${signin.idp}')?has_content)>
					handleMfaForIdpUsers('${signin.idp}');
					return false;
				</#if>
				<#if (('${signin.magicdigest}')?has_content)>
					handleMfaForIdpUsers('${signin.magicdigest}',true);
					return false;
				</#if>
				onSigninReady();
				<#if (('${signin.loginId}')?has_content)>
					handleCrossDcLookup("${Encoder.encodeJavaScript(signin.loginId)}");
				</#if>
			}
			function getSigninParms(){
				var params = "cli_time=" + new Date().getTime();
				<#if (('${signin.orgType}')?has_content)>
					params += "&orgtype="+ euc('${signin.orgType}');
					orgType = euc('${signin.orgType}');
				</#if>
				<#if (('${signin.servicename}')?has_content)>
					params += "&servicename=" + euc('${signin.servicename}');
					serviceName=euc('${signin.servicename}');
				</#if>
				<#if (('${signin.service_language}')?has_content)>
					params += "&service_language="+euc('${signin.service_language}');//no i18N
				</#if>
				<#if (('${signin.context}')?has_content)>
						params += "&context="+euc('${signin.context}');//no i18N
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					params += "&serviceurl="+euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
					serviceUrl = '${Encoder.encodeJavaScript(signin.serviceurl)}';
				</#if>
				<#if (('${signin.signupurl}')?has_content)>
					params += "&signupurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.signupurl)}');//no i18N
				</#if>
				return params;
			}
			function getRecoveryURL(){
				<#if (('${signin.recoveryurl}')?has_content)>
					return '${Encoder.encodeJavaScript(signin.recoveryurl)}';
				<#else>
				 	var tmpResetPassUrl = resetPassUrl;
				 	<#if (('${signin.servicename}')?has_content)>
						tmpResetPassUrl += "?servicename=" + euc('${signin.servicename}');
					</#if>
					<#if (('${signin.serviceurl}')?has_content)>
						tmpResetPassUrl += "&serviceurl="+euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
					</#if>
					<#if (('${signin.m_redirect}')?has_content)>
						tmpResetPassUrl += "&m_redirect=" + "${signin.m_redirect}";
					</#if>
					<#if (('${signin.service_language}')?has_content)>
						tmpResetPassUrl += "&service_language="+euc('${signin.service_language}');//no i18N
					</#if>
					<#if (('${signin.orgType}')?has_content)>
						tmpResetPassUrl += "&orgtype="+ euc('${signin.orgType}');
					</#if>
					return tmpResetPassUrl;
				</#if>
			}
			
		</script>