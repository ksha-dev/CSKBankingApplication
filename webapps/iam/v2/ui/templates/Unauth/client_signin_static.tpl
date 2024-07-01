		<#if (('${signin.redirectURL}')?has_content)>
			<script>
				var load_iframe = parseInt("${signin.load_iframe}");
				var url = "${signin.redirectURL}";
				if(url.indexOf("http") != 0) {
					var serverName = window.location.origin;
					if (!window.location.origin) {
						serverName = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
					}
					if(url.indexOf("/") != 0) {
						url = "/" + url;
					}
					url = serverName + url;
				}
				if(load_iframe){
					window.location.href = url; 
				}else{
					window.top.location.href=url;
				}
			</script>
		<#else>
		<@resource path="/v2/components/css/uvselect.css" />
		<@resource path="/v2/components/css/flagIcons.css" />
		<@resource path="/v2/components/css/uv_unauthStatic.css" />
		<#if (('${signin.css_url}')?has_content)>
			<link href="${signin.css_url}" type="text/css" rel="stylesheet"/>
		<#else>
			<@resource path="/v2/components/css/clientsignin.css" />
		</#if>
		<@resource path="/v2/components/css/fedsignin.css" />
        <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
        <@resource path="/v2/components/js/password_expiry.js" />
        <@resource path="/v2/components/js/common_unauth.js" />
        <@resource path="/v2/components/js/uvselect.js" />
		<@resource path="/v2/components/js/flagIcons.js" />
		<@resource path="/v2/components/js/signin.js" />
        <@resource path="/v2/components/tp_pkg/xregexp-all.js" />
		<script type="text/javascript" src="${signin.uri_prefix}/encryption/script"></script>
		<@resource path="/v2/components/js/security.js" />
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
			var totp_size = ${signin.totp_size};
			var canShowResetIP= false;
			var wmsSRIValues = ${za.wmsSRIValues};
			
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
					"IAM.SIGNIN.ERROR.CAPTCHA.INVALID" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID" />',
					"IAM.NEW.SIGNIN.PASSWORD" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORD" />',
					"IAM.LDAP.PASSWORD.PLACEHOLDER" : '<@i18n key="IAM.LDAP.PASSWORD.PLACEHOLDER" />',
					"IAM.NEW.SIGNIN.WITH.LDAP" : '<@i18n key="IAM.NEW.SIGNIN.WITH.LDAP" />',
					"IAM.NEW.SIGNIN.LDAP.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.LDAP.HEADER" />',
					"IAM.NEW.PASSWORD.EXPIRY.HEAD" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.HEAD" />',
					"IAM.NEW.PASSWORD.EXPIRY.ONE.TIME.DESC" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.ONE.TIME.DESC" />',
					"IAM.NEW.PASSWORD.EXPIRY.DESC" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.DESC" />',
					"IAM.NEW.PASSWORD.EXPIRY.POLICY.UPDATED.DESC" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.POLICY.UPDATED.DESC" />',
					"IAM.NEW.PASSWORD.NOT.MATCHED.ERROR.MSG" : '<@i18n key="IAM.NEW.PASSWORD.NOT.MATCHED.ERROR.MSG" />',
					"IAM.PASSWORD.CONFIRM.PASSWORD" : '<@i18n key="IAM.PASSWORD.CONFIRM.PASSWORD" />',
					"IAM.NEW.PASSWORD.EXPIRY.POLICY.SESSION.TERMINATED" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.POLICY.SESSION.TERMINATED" />',
					"IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED.DESC" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED.DESC" />',
					"IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED" : '<@i18n key="IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED" />',
					"IAM.NEWSIGNIN.USE.ALTER.WAY" : '<@i18n key="IAM.NEWSIGNIN.USE.ALTER.WAY" />',
					"IAM.NEWSIGNIN.USE.ALTER.WAY.DESC" : '<@i18n key="IAM.NEWSIGNIN.USE.ALTER.WAY.DESC" />',
					"IAM.NEW.SIGNIN.CONTACT.SUPPORT" : '<@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.MZADEVICE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.MZADEVICE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.TOTP" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.TOTP" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.OTP" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.OTP" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.YUBIKEY" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.YUBIKEY" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.RECOVERYCODE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.RECOVERYCODE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.PASSPHRASE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.PASSPHRASE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.MZADEVICE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.MZADEVICE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.TOTP" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.TOTP" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.OTP" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.OTP" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.YUBIKEY" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.YUBIKEY" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.RECOVERYCODE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.RECOVERYCODE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.PASSPHRASE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC.PASSPHRASE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.TITLE" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.TITLE" />',
					"IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.SEC.FACTOR.DESC" />',
					"IAM.NEWSIGNIN.BACKUP.DESC.PASSWORD" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.DESC.PASSWORD" />',
					"IAM.NEWSIGNIN.BACKUP.DESC.OTP" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.DESC.OTP" />',
					"IAM.NEWSIGNIN.BACKUP.DESC.JWT" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.DESC.JWT" />',
					"IAM.NEWSIGNIN.BACKUP.DESC.SAML" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.DESC.SAML" />',
					"IAM.NEWSIGNIN.VERIFY.FIRST.FACTOR" : '<@i18n key="IAM.NEWSIGNIN.VERIFY.FIRST.FACTOR" />',
					"IAM.NEWSIGNIN.BACKUP.LAST.DEVICE" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.LAST.DEVICE" />',
					"IAM.NEWSIGNIN.BACKUP.LAST.DEVICE.DESC" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.LAST.DEVICE.DESC" />',
					"IAM.CONTACT.SUPPORT.DESC" : '<@i18n key="IAM.CONTACT.SUPPORT.DESC" />',
					"IAM.CONTACT.EMAIL.US.ON" : '<@i18n key="IAM.CONTACT.EMAIL.US.ON" />',
					"IAM.CONTACT.SUPPORT.SLA" : '<@i18n key="IAM.CONTACT.SUPPORT.SLA" />',
					"IAM.CONTACT.SUPPORT.FAQ" : '<@i18n key="IAM.CONTACT.SUPPORT.FAQ" />',
					"IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH.OTHER.OPTION" : '<@i18n key="IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH.OTHER.OPTION" />',
					"IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH" : '<@i18n key="IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH" />',
					"IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH.DESC" : '<@i18n key="IAM.NEWSIGNIN.UNABLE.REACH.ONEAUTH.DESC" />',
					"IAM.NEWSIGNIN.BACKUP.STEP" : '<@i18n key="IAM.NEWSIGNIN.BACKUP.STEP" />',
					"IAM.NEW.SIGNIN.USING.TOTP" : '<@i18n key="IAM.NEW.SIGNIN.USING.TOTP" />',
					"IAM.NEW.SIGNIN.USING.PASSKEY" : '<@i18n key="IAM.NEW.SIGNIN.USING.PASSKEY" />',
					"IAM.NEW.SIGNIN.ENTER.TOTP.FIRST.FACTOR" : '<@i18n key="IAM.NEW.SIGNIN.ENTER.TOTP.FIRST.FACTOR" />',
					"IAM.NEW.SIGNIN.USING.ONEAUTH.FIRST.FACTOR" : '<@i18n key="IAM.NEW.SIGNIN.USING.ONEAUTH.FIRST.FACTOR" />',
					"IAM.NEW.SIGNIN.USING.PASSWORD" : '<@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD" />'
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
	</#if>