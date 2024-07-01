<!DOCTYPE html>
<html>
	<head>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=5.0"/>
	    <style>
	    * {
        	text-rendering: geometricPrecision;
      	}
      	body {
        	margin: 0;
        	box-sizing: border-box;
        	font-family: "ZohoPuvi";
      	}
		@font-face {
		   	font-family: "ZohoPuvi";
			src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.eot")}");
        	src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.eot")}") format("embedded-opentype"),
          	url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}") format("woff"),
           	url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.ttf")}") format("truetype");
			font-style: normal;
			font-weight: 400;
			text-rendering: optimizeLegibility;
      	}
     @font-face {
        font-family: "ZohoPuvi";
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.eot")}");
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.eot")}") format("embedded-opentype"),
			 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.woff")}") format("woff"),
			 url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.ttf")}") format("truetype");
        font-style: normal;
        font-weight: 500;
        text-rendering: optimizeLegibility;
      }
      @font-face {
        font-family: "ZohoPuvi";
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.eot")}");
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.eot")}") format("embedded-opentype"),
           url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.woff")}") format("woff"),
          url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.ttf")}") format("truetype");
        font-style: normal;
        font-weight: 600;
        text-rendering: optimizeLegibility;
      }
      @font-face {
        font-family: "ZohoPuvi";
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.eot")}"); /* IE9 Compat Modes */
        src: url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.eot")}") format("embedded-opentype"),
          url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}") format("woff"),
           url("${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.ttf")}") format("truetype");
        font-style: normal;
        font-weight: 700;
        text-rendering: optimizeLegibility;
      }
      @font-face {
		font-family: 'Announcement';
		src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
		src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
		font-weight: normal;
		font-style: normal;
		font-display: block;
	  }
	[class^="icon-"], [class*=" icon-"] {
		font-family: 'Announcement' !important;
		speak: never;
		font-style: normal;
		font-weight: normal;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
	@font-face {
  		font-family: 'Devices';	
		src:  url('../images/fonts/devices.eot');
		src:  url('../images/fonts/devices.eot') format('embedded-opentype'),
    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.ttf")}') format('truetype'),
    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.woff")}') format('woff'),
    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/devices.svg")}') format('svg');
  		font-weight: normal;
  		font-style: normal;
		font-display: block;
	}
	[class^="icon2-"], [class*=" icon2-"] {
  		font-family: 'Devices' !important;
  		speak: never;
  		font-style: normal;
  		font-weight: normal;
  		font-variant: normal;
  		text-transform: none;
  		line-height: 1;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
/* since its mfa banner and not enforcement*/
	.radio-cont{
		display: none;
	}
	@font-face {
		font-family: 'AccountsUI';
		src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}');
		src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}') format('embedded-opentype'),
    	url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.ttf')}') format('truetype'),
    	url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff')}') format('woff'),
    	url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff2')}') format('woff2'),
    	url('${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.svg')}') format('svg');
  		font-weight: normal;
  		font-style: normal;
  		font-display: block;
	}
	[class^="icon3-"], [class*=" icon3-"] {
		font-family: 'AccountsUI' !important;
		speak: never;
		font-style: normal;
		font-weight: normal;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
	.line_loader{
		transform: scale(1);
	}
    </style>

    <script>
    	var nModes;
		var contextpath = '${za.contextpath}';
    	<#if mfa_data??>
    	var mfaData = ${mfa_data};
    	var alreadyConfiguredModes = ${mfa_data.modes};
		var isMobile = ${is_mobile?c};
		var isMFAEnabled = ${mfa_data.is_mfa_activated?c};
    	</#if>
    	var mandatebackupconfig = ${mandate_backup_codes?c};
		var isBioEnforced =<#if oneauth_bio_type?has_content> true <#else> false </#if>
    	var showMobileNoPlaceholder = ${mob_plc_holder?c};
    	var csrfParam= "${za.csrf_paramName}";
      	var csrfCookieName = "${za.csrf_cookieName}";
		var next = '${Encoder.encodeJavaScript(visited_url)}';
		var wmsSRIValues = ${za.wmsSRIValues};
    	<#if remindme_url??>var remindme = '${Encoder.encodeJavaScript(remindme_url)}' //also used in mfa-banner.js</#if>
		var rev, isPhased=<#if enable_rev_sn?has_content > true <#else> false </#if>;
    </script>
		</head>
		<body>
		<#include "../zoho_line_loader.tpl">
		<@resource path="/v2/components/css/mfaenforcement.css" />
		<@resource path="/v2/components/css/mfabanner.css" />
			<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
			<@resource path="/v2/components/js/common_unauth.js" />
			<@resource path="/v2/components/js/splitField.js" attributes="defer" />
			<@resource path="/v2/components/js/webauthn.js" attributes="defer" />
		    <@resource path="/v2/components/js/zresource.js" />
			<@resource path="/v2/components/js/uri.js" />
			<script src="${za.wmsjsurl}" integrity="${za.wmsjsintegrity}" crossorigin="anonymous"></script>
			<@resource path="/v2/components/js/wmsliteimpl.js" />
			<@resource path="/v2/components/js/mfa-banner.js" />
			<@resource path="/v2/components/js/reverse-signin.js" />
			<@resource path="/v2/components/tp_pkg/lottie.min.js" attributes="defer" />

			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<#if !(enable_rev_sn?has_content) >
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/banner_oneauth_scan.png")}" type="image/png" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Playstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Appstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Macstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/Winstore_svg.svg")}" type="image/svg+xml" crossorigin="anonymous">
			</#if>
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}" type="font/ttf" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.woff")}" type="font/woff" crossorigin="anonymous">
			
			<script type="text/javascript">
				I18N.load({
					"IAM.ERROR.RELOGIN.UPDATE" : '<@i18n key="IAM.ERROR.RELOGIN.UPDATE"/>',
					"IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE" : '<@i18n key="IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE"/>',
					"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
					"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
					"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP" />',
					"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
					"IAM.ENTER.CODE": '<@i18n key="IAM.ENTER.CODE" />',
					"IAM.VERIFIED": '<@i18n key="IAM.VERIFIED" />',
					"IAM.PLEASE.CONNECT.INTERNET": '<@i18n key="IAM.PLEASE.CONNECT.INTERNET" />',
					"IAM.ERROR.SESSION.EXPIRED": '<@i18n key="IAM.ERROR.SESSION.EXPIRED" />',
					"IAM.USER.CREATED.TIME.ADDED": '<@i18n key="IAM.USER.CREATED.TIME.ADDED" />',
					"IAM.NEW.SIGNIN.VERIFY": '<@i18n key="IAM.NEW.SIGNIN.VERIFY" />',
					"IAM.MFA.ANNOUN.SUCC.HEAD": '<@i18n key="IAM.MFA.ANNOUN.SUCC.HEAD" />',
					"IAM.MFA.SHOW.OTHER.MODE.2": '<@i18n key="IAM.MFA.SHOW.OTHER.MODE.2" />',
					"IAM.MFA.CONFIRM.DELETE.MODE": '<@i18n key="IAM.MFA.CONFIRM.DELETE.MODE" />',
					"IAM.TFA.BACKUP.ACCESS.CODES": '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" />',
					"IAM.GENERATEDTIME": '<@i18n key="IAM.GENERATEDTIME" />',
					"IAM.TFA.BACKUP.ACCESS.CODES": '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" />',
					"IAM.JUST.NOW": '<@i18n key="IAM.JUST.NOW" />',
					"IAM.GENERATE.BACKUP.CODES": '<@i18n key="IAM.GENERATE.BACKUP.CODES" />',
					"IAM.MFA.BACKUPCODE.FILE.TEXT": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.TEXT" />',
					"IAM.MFA.BACKUPCODE.FILE.NOTES": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES" />',
					"IAM.LIST.BACKUPCODES.POINT1": '<@i18n key="IAM.LIST.BACKUPCODES.POINT1" />',
					"IAM.LIST.BACKUPCODES.POINT3": '<@i18n key="IAM.LIST.BACKUPCODES.POINT3" />',
					"IAM.MFA.BACKUPCODE.FILE.NOTES3": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES3" />',
					"IAM.MFA.BACKUPCODE.FILE.NOTES4": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES4" />',
					"IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE" />',
					"IAM.GENERAL.USERNAME": '<@i18n key="IAM.GENERAL.USERNAME" />',
					"IAM.GENERATE.ON": '<@i18n key="IAM.GENERATE.ON" />',
					"IAM.MFA.BACKUPCODE.FILE.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.HELP.LINK" />',
					"IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK" />',
					"IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK" />',
					"IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.TFA.BANNER.REMIND.LATER": '<@i18n key="IAM.TFA.BANNER.REMIND.LATER" />',
					"IAM.NEXT" : '<@i18n key="IAM.NEXT" />',
				});
				<#if allow_yubikey_mode??>
				I18N.load({
				"IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR" : '<@i18n key="IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR"/>',
					"IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" : '<@i18n key="IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE" />',
					"IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" : '<@i18n key="IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT" />',
					"IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" : '<@i18n key="IAM.MFA.YUBIKEY.ERROR.INVALID.REQUEST" />',
					"IAM.WEBAUTHN.ERROR.BrowserNotSupported" : '<@i18n key="IAM.WEBAUTHN.ERROR.BrowserNotSupported" />',
					"IAM.WEBAUTHN.ERROR.InvalidResponse" : '<@i18n key="IAM.WEBAUTHN.ERROR.InvalidResponse" />',
					"IAM.WEBAUTHN.ERROR.NotAllowedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError"/>',
					"IAM.WEBAUTHN.ERROR.InvalidStateError":'<@i18n key="IAM.WEBAUTHN.ERROR.InvalidStateError"/>',
					"IAM.WEBAUTHN.ERROR.NotSupportedError":'<@i18n key="IAM.WEBAUTHN.ERROR.NotSupportedError"/>',
					"IAM.WEBAUTHN.ERROR.ErrorOccurred":'<@i18n key="IAM.WEBAUTHN.ERROR.ErrorOccurred"/>',
					"IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED":'<@i18n key="IAM.SIGNIN.ERROR.YUBIKEY.VALIDATION.FAILED"/>',
					"IAM.WEBAUTHN.ERROR.NotAllowedError": '<@i18n key="IAM.WEBAUTHN.ERROR.NotAllowedError" />',
					"IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL" />',
					"IAM.MFA.YUBIKEY" : '<@i18n key="IAM.MFA.YUBIKEY" />',
					"IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR" : '<@i18n key="IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR" arg0="50"/>',
					"IAM.YUBIKEY.CONFIGURED.ONE": '<@i18n key="IAM.YUBIKEY.CONFIGURED.ONE" />',
					"IAM.YUBIKEY.CONFIGURED.MANY": '<@i18n key="IAM.YUBIKEY.CONFIGURED.MANY" />',
					"IAM.TFA.YUBIKEY.EXIST.MSG": '<@i18n key="IAM.TFA.YUBIKEY.EXIST.MSG" />',
					"IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY": '<@i18n key="IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY" />',
				});
				</#if>
				 <#if allow_oneauth_mode??>
				 I18N.load({
				 	"IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD" : '<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.HEAD" />',
				 	"IAM.DEVICE" : '<@i18n key="IAM.DEVICE" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL.DESC" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL.DESC" />',
				 	"IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD":'<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.POP.HEAD" />',
				 	"IAM.ZOHO.ONEAUTH.APP": '<@i18n key="IAM.ZOHO.ONEAUTH.APP" />',
				 	"IAM.DEVICE.CONFIGURED.ONE": '<@i18n key="IAM.DEVICE.CONFIGURED.ONE" />',
					"IAM.DEVICE.CONFIGURED.MANY": '<@i18n key="IAM.DEVICE.CONFIGURED.MANY" />',
					"IAM.MFA.ANNOUN.ONEAUTH.SETUP.HEAD": '<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SETUP.HEAD" />',
					"IAM.SCAN.QR": '<@i18n key="IAM.SCAN.QR"/>',
					"IAM.GOOGLE.AUTHENTICATOR": '<@i18n key="IAM.GOOGLE.AUTHENTICATOR"/>',
					"IAM.PUSH.NOTIFICATION": '<@i18n key="IAM.PUSH.NOTIFICATION"/>',
					"IAM.MFA.PASSWORDLESS": '<@i18n key="IAM.MFA.PASSWORDLESS"/>',
					"IAM.SMART.SIGNIN.EXPAND.CONTENT.UPDATE": '<@i18n key="IAM.SMART.SIGNIN.EXPAND.CONTENT.UPDATE"/>',
					"IAM.SMART.SIGNIN.CANCEL.CONTENT.UPDATE": '<@i18n key="IAM.SMART.SIGNIN.CANCEL.CONTENT.UPDATE"/>',
					"IAM.PASSWORD": '<@i18n key="IAM.PASSWORD"/>',
					"IAM.REV.BIO.ENABLED": '<@i18n key="IAM.REV.BIO.ENABLED"/>'
				 })
				 var fontDevicesToHtmlElement = {
					"samsung" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan samsunggrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>',
					"samsungtab" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan samsungtabgrad"></span><span class="path4"></span><span class="path5"></span>',
					"macbook" : '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4 gradientspan macbookgrad"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
					"iphone" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan iphonegrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span>',
					"ipad" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan ipadgrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>',
					"pixel" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan pixelgrad" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span>',
					"oneplus" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan oneplusgrad" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span>',
					"oppo" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan oppograd" style=""></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span>',
					"mobile_uk" : '<span class="path1"></span><span class="path2"></span><span class="path3 gradientspan mobile_ukgrad"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>'
				 }
				<#if enable_rev_sn?has_content >
					var revConfigSize = ${rev_otp_size};
					var downloadLott="${SCL.getStaticFilePath("/v2/components/images/json/rev-download.json")}"
				 	var OTPLott="${SCL.getStaticFilePath("/v2/components/images/json/rev-OTP.json")}"
				 	var settingLott="${SCL.getStaticFilePath("/v2/components/images/json/rev-setting.json")}"
				 	I18N.load({
				 		"IAM.REV.SCAN.CONT" : '<@i18n key="IAM.REV.SCAN.CONT" />',
				 		"IAM.REV.HELP0.QUEST" : '<@i18n key="IAM.REV.HELP1.QUEST" />',
				 		"IAM.REV.HELP0.TRUEYES" : '<@i18n key="IAM.REV.HELP1.TRUEYES" />',
				 		"IAM.REV.HELP2.QUEST" : '<@i18n key="IAM.REV.HELP2.QUEST" />',
				 		"IAM.REV.HELP2.TRUENO" : '<@i18n key="IAM.REV.HELP2.TRUENO" />',
				 		"IAM.REV.HELP2.FALSEYES" : '<@i18n key="IAM.REV.HELP2.FALSEYES" />',
						"IAM.REV.HELP3.QUEST" : '<@i18n key="IAM.REV.HELP3.QUEST" />',
						"IAM.REV.HELP3.TRUENO1" : '<@i18n key="IAM.REV.HELP3.TRUENO1" />',
						"IAM.REV.HELP3.TRUENO2" : '<@i18n key="IAM.REV.HELP3.TRUENO2" />',
				 		"IAM.REV.HELP3.FALSEYES" : '<@i18n key="IAM.REV.HELP3.FALSEYES" />',
				 		"IAM.REV.HELP4.QUEST" : '<@i18n key="IAM.REV.HELP4.QUEST" />',
				 		"IAM.REV.HELP4.TRUENO" : '<@i18n key="IAM.REV.HELP4.TRUENO" />',
				 		"IAM.REV.HELP4.FALSEYES" : '<@i18n key="IAM.REV.HELP4.FALSEYES" />',
				 		"IAM.REV.RESUME.SETUP" : '<@i18n key="IAM.REV.RESUME.SETUP" />',
				 		"IAM.REV.QR.EXPIRED" : '<@i18n key="IAM.REV.QR.EXPIRED" />',
				 		"IAM.REV.EXPIRED.CONTINUE" : '<@i18n key="IAM.REV.EXPIRED.CONTINUE" />',
						"IAM.REV.HELP1.QUEST" : '<@i18n key="IAM.REV.HELP1.QUEST" />',
						"IAM.REV.VERCODE.NEXT" : '<@i18n key="IAM.REV.VERCODE.NEXT" />',
						"IAM.ENABLED.MFA": '<@i18n key="IAM.ENABLED.MFA"/>',
						"IAM.REV.MFA.ENABLE.THROTTLE": '<@i18n key="IAM.REV.MFA.ENABLE.THROTTLE"/>',
						"IAM.ACCESS.MY.ACC": '<@i18n key="IAM.ACCESS.MY.ACC"/>',
				 	})
				</#if>
				 </#if>
				 <#if allow_totp_mode??>
				 I18N.load({
				 "IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" />',
				 "IAM.CONFIGURED" : '<@i18n key="IAM.CONFIGURED" />',
				 "IAM.MFA.ANNOUN.TOTP.CONF": '<@i18n key="IAM.MFA.ANNOUN.TOTP.CONF" />',
				 "IAM.MFA.COPY.CLIPBOARD" : '<@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" />',
				 "IAM.APP.PASS.COPIED" : '<@i18n key="IAM.APP.PASS.COPIED" />',
				 "IAM.TAP.TO.COPY" : '<@i18n key="IAM.TAP.TO.COPY" />',
				 })
				 var totpConfigSize = ${totp_config_size};
				 </#if>
				var err_try_again = '<@i18n key="IAM.ERROR.TRY.AGAIN" />';
				var sms_auth_text = '<@i18n key="IAM.TFA.SMS.HEAD" />';
				var accounts_support_contact_email_id = '${support_email}';
				var oneauthHeader = {"0": "", "1":"IAM.DEVICE.CONFIGURED.ONE", "2":"IAM.DEVICE.CONFIGURED.MANY"};
				var yubikeyHeader = {"0": "", "1":"IAM.YUBIKEY.CONFIGURED.ONE", "2":"IAM.YUBIKEY.CONFIGURED.MANY"};
			</script>
			<#include "../include_murphy.tpl">
			<#include "../Unauth/announcement-logout.tpl"> 
			<div id="help-playground" style="position: absolute; top:0"></div>
			<div class="blur"></div> 
			<div id="error_space" class="error_space">
				<span class="error_icon">&#33;</span> <span class="top_msg"></span>
			</div>
			<div class="delete-popup" style="display: none" tabindex="1" onkeydown="escape(event)">
				<div class="popup-header">
        			<div class="popup-heading"><@i18n key="IAM.CONFIRM.POPUP.DELETE.MFA.MODE" /></div>
      			</div>
      		    <div class="popup-body">
      			<div class="delete-desc"></div>
      			<button class="confirm-delete-btn common-btn"><span></span><@i18n key="IAM.CONFIRM" /></button>
      			<button class="delete-cancel-btn common-btn cancel-btn" onclick="cancelDelete()"><@i18n key="IAM.CANCEL" /></button>
      			</div>
			</div>
			<div class="msg-popups" style="display: none" tabindex="1" onkeydown="escape(event)">
      			<div class="popup-header">
        			<div class="popup-icon icon-success"></div>
        			<div class="popup-heading"></div>
        			<div class="pop-close-btn" onclick="closePopup()"></div>
      			</div>
      			<div class="popup-body"></div>
    		</div>
    		<div class="generate-backup" style="display: none">
				<div class="backup-codes-desc old-codes" style="display:none"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.OLD" /> <@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" /></div>
				<div class="backup-codes-desc new-codes"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.NEW" /> <@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" /></div>
				<button class="g-backup common-btn" onclick="generateBackupCode(event);"><span></span><@i18n key="IAM.TFA.GENERATE.NEW" /></button>
      			<button class="g-cancel common-btn cancel-btn" onclick="contSignin()"><@i18n key="IAM.CANCEL" /></button>
    		</div>
    		<div class="no-backup-redirect" style="display: none">
    			<div class="backup-codes-desc"><@i18n key="IAM.MFA.ANNOUN.SUCC.NO.BKC.DESC" /></div>
      			<button class="common-btn" onclick="contSignin()"><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT" /></button>
    		</div>
    		<div class="backup_code_container" style="display:none">
          		<div class="backup-desc">
					<@i18n key="IAM.BACKUP.CODES.GENERATED.DESC1" /> <@i18n key="IAM.BACKUP.CODES.GENERATED.DESC2" />
		  		</div>
				<div id="bkup_code_space" class="tfa_bkup_grid">
					<div id="bk_codes"></div>
					<div id="bkup_cope">
						<span class="backup_but" id="downcodes"><@i18n key="IAM.DOWNLOAD.APP" /> </span>
						<span class="backup_but tooltipbtn" id="printcodesbutton" onmouseout="remove_copy_tooltip();"><@i18n key="IAM.COPY" /> 
							<span class="tooltiptext copy_to_clpbrd"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></span>
							<span class="tooltiptext code_copied hide" style="display:none"><span class="tick-mark"></span><@i18n key="IAM.APP.PASS.COPIED" /> </span>
						</span> 
 					</div>
				</div>
        		<div class="down_copy_proceed"><@i18n key="IAM.BACKUP.VERIFY.CODES.PROCEED" /></div>
        		<ul class="mfa_points_list">
 					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT1" /></li>
					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT2" /> </li>
					<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT3" /> </li>
		  		</ul>
        		<button class="cont-signin common-btn" onclick="contSignin()" style="display:none"><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT" /></button>
        	</div>
        	<div class="new-success" style="display: none">
        		<div class="succ-zone">
        			<div class="succ-icon"><div> 
        			<svg viewBox="0 0 24 24" width="22px" height="22px" ><polyline class="path" fill="none" points="20,6 9,17 4,12"
            			stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathlength="1"/></svg>
            			</div>
            			</div>
        		</div>
        		<div class="succ-head"><@i18n key="IAM.MFA.ANNOUN.SUCC.HEAD"/></div>
        		<div class="succ-mode-cont">
          			<div class="mode-header">
            		<div class="mode-icon icon-pebble icon-Zoho-oneAuth-logo">
              			<span class="path1 onepathlogo"></span>
              			<span class="path2 onepathlogo"></span>
              			<span class="path3 onepathlogo"></span>
              			<span class="path4 onepathlogo"></span>
              			<span class="path5 onepathlogo"></span>
              			<span class="path6 onepathlogo"></span>
              			<span class="path7 onepathlogo"></span>
            		</div>
            		<div class="mode-header-texts">
              			<span><@i18n key="IAM.MFA.MODE" /></span>
              			<span><@i18n key="IAM.USE.AUTH.APP.SETUP.HEADING" /></span>
            		</div>
          		</div>
          <div class="oneauth-modes">
            <div class="mode-detail" style="display: none">
            <div class="mode-icon icon-pebble sm-icon"></div>
            <span class="mode-text"></span>
            </div>
          </div>
        </div>
            	<div class="generate-backup" style="display: none">
					<div class="backup-codes-desc old-codes" style="display:none"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.OLD" /> <@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" /></div>
					<div class="backup-codes-desc new-codes"><@i18n key="IAM.MFA.ANNOUN.SUCC.BKC.NEW" /> <@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" /></div>
					<button class="g-backup common-btn" onclick="generateBackupCode(event);"><span></span><@i18n key="IAM.TFA.GENERATE.NEW" /></button>
      				<button class="g-cancel common-btn cancel-btn" onclick="contSignin()"><@i18n key="IAM.CANCEL" /></button>
    			</div>
    			<div class="no-backup-redirect" style="display: none">
    				<div class="backup-codes-desc"><@i18n key="IAM.MFA.ANNOUN.SUCC.NO.BKC.DESC" /></div>
      				<button class="common-btn" onclick="contSignin()"><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT" /></button>
    			</div>
        	</div>
    <div class="help-cont up" style="display: none">
        <div class="help-box">
            <div class="help-wrap">
                <div class="help-btn">
                    <span class="icon-help"></span><span class="help-btn-txt"><@i18n key="IAM.HELP" /></span>
                </div>
                <div class="help-content">
                    <div class="help-desc"></div>
                    <div class="help-actions">
                        <button class="h-btn succ" data-value=true><@i18n key="IAM.YES" /></button>
                        <button class="h-btn fail" data-value=false><@i18n key="IAM.NO" /></button>
                        <div class="loader help-load"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="help-border">
            <svg style="shape-rendering: geometricPrecision; position: absolute; pointer-events: none;"
                class="line_loader">
                <rect x="1" y="1" rx="4" ry="4" class="path" pathLength="100"
                    style="stroke: rgb(19 147 255); stroke-width: 2; stroke-opacity: 1; fill: transparent; stroke-dasharray: 101; stroke-dashoffset: 101" />
            </svg>
        </div>
    </div>
    <div class="ans-cont" style="display: none">
    	<div class="ans-txt">
    		<#-- different answers parallel to one another-->	
    	</div>
    	<div class="help-actions" style="display: none">
    		<button class="h-btn" data-value="ans"><@i18n key="IAM.REV.SHOW.QR" /></button>
    		<div class="loader help-load"></div>
    	</div>
    </div>
        	<#if allow_oneauth_mode??>
			<div class="oneauth-popup" style="display: none">
				<div class="oneauth-headerandoptions2">
				<div class="header-flex">
					<div class="oneauth-header">
						<div class="oneauth-header-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onelogopop"></span><span class="path2 onelogopop"></span><span class="path3 onelogopop"></span><span class="path4 onelogopop"></span><span class="path5 onelogopop"></span><span class="path6 onelogopop"></span><span class="path7 onelogopop"></span></div>
						<div class="oneauth-header-texts">
							<div class="oneauth-name"><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /></div>
							<div class="oneauth-desc"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div>
						</div>
					</div>
					<div class="oneauth-download-options" style="height: unset;">
						<div  class="oneauth-d-options" style="position: relative;height: unset;">
						<div class="download playstore-icon" onclick="storeRedirect('https://zurl.to/mfa_banner_oaplay')"></div>
						<div class="download appstore-icon" onclick="storeRedirect('https://zurl.to/mfa_banner_oaips')"></div>
						<div class="download macstore-icon" onclick="storeRedirect('https://zurl.to/mfa_banner_oamac')"></div>
						<div class="download winstore-icon" onclick="storeRedirect('https://zurl.to/mfa_banner_msstore')"></div>
						</div>
					</div>
					</div>
					<div class="scanqr scanqr2">
							<div class="qr-image qr-image-banner">
								<div class="top left"></div>
								<div class="top right"></div>
								<div class="bottom right"></div>
								<div class="bottom left"></div>
							</div>
							<div class="scan-desc2"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
					</div>
					<div class="pop-close-btn one-close-btn" onclick="closePopup()"></div>
				</div>
				<div class="oneauth-steps2">
					<div class="oneauth-step-header"><@i18n key="IAM.AFTER.INSTALLING.ONEAUTH" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP1" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP2" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3" /></div>
					<div class="oneauth-footer"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT" /> <a href="https://zurl.to/mfa_banner_oaworks" target="_blank" class="onefoot-link"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK" /></a></div>
				</div>
				<button class="common-btn" style="margin-left:30px; margin-top: 0px" onclick="contSignin()"><@i18n key="IAM.ENABLED.MFA" /></button>
			</div>
			<div class="oneauth-bio" style="display:none">
				<div class="bio-steps">
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP1" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP2" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP3" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.STEP4" /></div>
					<div class="note_text"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.NOTE" /></div>
				</div>
				<button class="common-btn s-common-btn" style="margin-left:0px; margin-top: 20px" onclick="showReloginPop()"><@i18n key="IAM.NEXT" /></button>
			</div>
			<div class="oneauth-relogin" style="display:none">
				<div class="relogin-desc">
					<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.RELOGIN.DESC" />
				</div>
				<button class="common-btn" onclick="redirectSignin()"><@i18n key="IAM.GO.TO.SIGNIN.PAGE" /></button><button class="common-btn  cancel-btn" onclick="closePopup()"><@i18n key="IAM.CANCEL" /></button>
			</div>
			<div class="app-update" style="display:none">
				<div class="update-app"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.UP.LABEL" /> <span class="icon-info"></div>
			</div>
			</#if>
			<div class="pref-info" style="display:none">
				<div class="pref-text">
					<span></span>
					<span class="pref-icon icon-cinformation"></span>
					<div class="pref-desc"></div>
				</div>
			</div>
			
			<div class="flex-container">
				<div class="container" style="display: none">
					<div class="rebrand_partner_logo"></div>
					<div class="announcement_header"><span class="re-enable" style="display: none"><@i18n key="IAM.MFA.BANNER.ALREADY.TITLE"/></span><span class="new" style="display: none"><@i18n key="IAM.MFA.BANNER.NEW.TITLE"/></span></div>
					<div class="enforce_mfa_desc many" style="display: none">
						<span class="re-enable" style="display: none"><@i18n key="IAM.MFA.BANNER.ALREADY.DESC"/></span>
						<span class="new" style="display: none"><@i18n key="IAM.MFA.BANNER.NEW.DESCRIP"/></span>
        			</div>
        			<div class="enforce_mfa_desc one" style="display: none">
						<span class="re-enable" style="display: none"><@i18n key="IAM.MFA.BANNER.ALREADY.DESC"/></span>
						<span class="new" style="display: none"><@i18n key="IAM.MFA.BANNER.NEW.DESC"/></span>
        			</div>
					<div class="container-wrapper">
				<div class="modes-container" id="slide1">
					<#if allow_oneauth_mode??>
					<#if enable_rev_sn?has_content>
					<div class="oneauth-container rev mode-cont">
						<div class="mode-header" onclick="selectandslide(event)" style="flex-direction: column;">
							<div class="oneauth-header">
								<div class="tag">
									<span><@i18n key="IAM.RECOMMENDED" /><span class="icon-Sparkle"></span></span><div class="tag-pins"></div>
									<div class="svg-curve">
										<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10" height="32" viewBox="0 0 10 32">
										<defs>
											<linearGradient id="linear-gradient" y1="0.548" x2="1" y2="0.55" gradientUnits="objectBoundingBox">
												<stop offset="0" stop-color="#323ec9"/><stop offset="0.493" stop-color="#5360f8"/><stop offset="1" stop-color="#323ec9"/>
											</linearGradient>
										</defs>
										<path id="Path_3400" data-name="Path 3400" d="M0,0H5c4.983,0,5-2,5-2V25s0,5-5,5H0Z" transform="translate(0 2)" fill="url(#linear-gradient)"/>
										</svg>
									</div>
								</div>
								<div class="one-header ali-center">
									<div class="mode-icon icon-Zoho-oneAuth-logo icon-pebble"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
                					<div class="mode-header-texts">
										<span><@i18n key="IAM.USE.AUTH.APP.SETUP.HEADING"/></span>
                					</div>
            					</div>
        					</div>
            			</div>
        				<div class="mode-body">
        					<div class="oneauth-body">
								<div class="splitback">
									<div class="oneauth-desc"><@i18n key="IAM.OA.APP.DESC" /></div>
            						<div class="qrhelp-wrap">
										<div class="qrstep-cont step1-qr">
                							<div class="qr-cont-wrap active-qr" onclick="expandQR(event)">
                							<div class="qr-cont">
												<div class="init-loader"></div>
												<div class="qr-image" style="display: none;"></div>
												<div class="qr-refresh" onclick="refreshQr(event,'type',1)">
													<span class="icon-Reload"></span><span class="refresh-txt" style="display: none"><@i18n key="IAM.REFRESH" /></span><span class="restart-txt" style="display: none"><@i18n key="IAM.RESTART" /></span>
												</div>
                							</div>
                							<div class="tap-txt"><span class="icon-expand"></span><span class="txt"><@i18n key="IAM.SMART.SIGNIN.EXPAND.CONTENT.UPDATE" /></span></div>
                							</div>
                							<div class="install-steps">
                    							<div class="step-header"><@i18n key="IAM.SCAN.QR.BEGIN.SETUP" /></div>
                    							<ol>
                        							<li class="install-step"><@i18n key="IAM.REV.OPEN.CAMERA" /></li>
													<li class="install-step"><@i18n key="IAM.REV.FOLLOW.STEPS" /> <#-- <span class="link-btn" onclick="helpInQR()"><@i18n key="IAM.HELP" /><span class="icon-help" style="vertical-align:middle; margin-left:4px;font-size: 14px;"></span></span> --></li>
                    							</ol>
                							</div> 
            							</div>
            							<div class="msg-cont" style="display:none">
            								<div class="icon-Resume help-r"></div>
            								<div class="icon-help help-a"></div>
            								<div class="msg-wrap">
            									<div class="msg-head">
            										<span class="help-r"><@i18n key="IAM.REV.RESUME.SETUP" /></span>
            									</div>
            									<div class="help-desc">
            										<span class="help-r"><@i18n key="IAM.REV.RESUME.DESC" /></span>
            										<span class="help-a"><@i18n key="IAM.REV.HELP0.QUEST" /></span>
            									</div>
            								</div>
            								<div class="help-actions">
            									<div class="h-btn help-r" onclick="resumeStep(event)"><@i18n key="IAM.RESUME" /></div>
            									<div class="h-btn help-a" onclick="forcedStep('1'); 'murphy' in window && sendMurphyMsg('I_rev_help0_yes')"><@i18n key="IAM.REV.HELP0.TRUEYES" /></div><div class="h-btn help-a" style="display: none">No</div>
            								</div>
            							</div>
            						</div>
									<div class="store-links">
                						<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/mfa_ban_playstore')"></div>
                						<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/mfa_ban_appstore')"></div>
										<div class="download winstore-icon win-small" onclick="storeRedirect('https://zurl.to/mfa_ban_msstore')"></div>
            						</div>
									<div class="general-desc" style="margin-top: 16px;pointer-events:none;"><@i18n key="IAM.MFA.ONEAUTH.INSTALL.ENABLE" /></div>
									<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
        						</div>
                				<div class="already-verified-app already-cont" style="display: none">
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="verified-app-cont cloner" style="display: none" onclick="selectNumberDevice(event)">
                  						<div class="verified-checkbox"></div>
                    					<div class="device-image"></div>
                    					<div class="verified-app-details">
                      						<span class="verified-device name-detail"></span>
                      						<span class="added-period"></span>
                    					</div>
                    					<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteOneAuth, 'oneauth')"></div>
                  					</div>
                  					
                  					<button class="add-new-oneauth-but add-new-btn link-btn" 
                  					<#if is_mobile>
                  					onclick="showOneauthPop()"
                  					<#else>
                  					onclick="showReverseSignin()"
                  					</#if>
                  					><@i18n key="IAM.ADD.ANOTHER.DEVICE" /></button>
                					
                				</div>
                				<div class="add-new-oneauth add-new-cont" style="display: none">
									<div class="general-desc add-desc" style="display: none">
										<div class="down-badges">
											<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaplay')"></div>
											<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaips')"></div>
											<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oamac')"></div>
										</div>
										<div class="add-qr">
											<div class="qr qr-image-banner">
												<div class="top left"></div>
												<div class="top right"></div>
												<div class="bottom right"></div>
												<div class="bottom left"></div>
											</div>
											<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
										</div>
                  					</div>
                  					<div class="general-desc add-desc" style="margin-top: 20px;display: none"><@i18n key="IAM.MFA.ONEAUTH.INSTALL.ENABLE" /></div>
									<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;display: none"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
                				</div>
								<div class="warning-msg many" style="display:none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.WARN" /></div>
            					</div>
								<div class="warning-msg biometric-msg" style="display:none">
									<div class="warning-icon icon-Warning-Icon"></div>
									<div class="warning-desc">
									<div class="warning-heading"><b><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.HEAD" /></b></div> 
									<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.DESC" />
									</div>
									<button class="common-btn s-common-btn enable-bio" onclick="showBioPop()"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.ENABLE.BIOMETRICS" /></button>
								</div>
								<div class="warning-msg resume-msg" style="display:none">
									<div class="warning-icon icon-Resume"></div>
									<div class="warning-desc">
									<div class="warning-heading"><b><@i18n key="IAM.REV.RESUME.SETUP" /></b></div> 
									<@i18n key="IAM.REV.RESUME.DESC" />
									</div>
									<button class="common-btn s-common-btn enable-bio" onclick="resumeStep(event)"><@i18n key="IAM.RESUME" /></button>
								</div>
              				</div>
            			</div>
            			</div>
            			<#else>
            		<div class="oneauth-container mode-cont">
        				<div class="mode-header" onclick="selectandslide(event)" style="padding-right: 0;flex-direction: column ; gap: 20px;">
              				<div class="one-header">
              				<div class="mode-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
							<div class="mode-header-texts"><span><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /><div class="icon3-newtab"></div></span><div class="oneauth-desc or-text"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div></div>
							<div class="down-arrow" style="display: none"></div>
							<div class="tag">
								<span><@i18n key="IAM.RECOMMENDED" /><span class="icon-Sparkle"></span></span><div class="tag-pins"></div>
								<div class="svg-curve">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10" height="32" viewBox="0 0 10 32">
									<defs>
										<linearGradient id="linear-gradient" y1="0.548" x2="1" y2="0.55" gradientUnits="objectBoundingBox">
											<stop offset="0" stop-color="#323ec9"/><stop offset="0.493" stop-color="#5360f8"/><stop offset="1" stop-color="#323ec9"/>
    									</linearGradient>
  									</defs>
									<path id="Path_3400" data-name="Path 3400" d="M0,0H5c4.983,0,5-2,5-2V25s0,5-5,5H0Z" transform="translate(0 2)" fill="url(#linear-gradient)"/>
								</svg>
								</div>
							</div>
							</div>
							<div class="add-oneauth" style="display: none">
								<div class="down-badges">
									<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaplay')"></div>
									<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaips')"></div>
									<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oamac')"></div>
									<div class="download winstore-icon win-small" onclick="storeRedirect('https://zurl.to/mfa_banner_msstore')"></div>
								</div>
								<div class="add-qr">
									<div class="qr qr-image-banner">
										<div class="top left"></div>
										<div class="top right"></div>
										<div class="bottom right"></div>
										<div class="bottom left"></div>
									</div>
									<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
								</div>
								<div class="general-desc" style="margin-top: 20px;pointer-events:none;"><@i18n key="IAM.MFA.ONEAUTH.INSTALL.ENABLE" /></div>
								<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
                  			</div>
            			</div>
            			<div class="mode-body">
              				<div class="oneauth-body">
                				<div class="already-verified-app already-cont" style="display: none">
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="verified-app-cont cloner" style="display: none" onclick="selectNumberDevice(event)">
                  						<div class="verified-checkbox"></div>
                    					<div class="device-image"></div>
                    					<div class="verified-app-details">
                      						<span class="verified-device name-detail"></span>
                      						<span class="added-period"></span>
                    					</div>
                    					<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteOneAuth, 'oneauth')"></div>
                  					</div>
                  					<button class="add-new-oneauth-but add-new-btn link-btn" onclick="showOneauthPop()"><@i18n key="IAM.ADD.ANOTHER.DEVICE" /></button>
                				</div>
                				<div class="add-new-oneauth add-new-cont" style="display: none">
									<div class="general-desc add-desc" style="display: none">
										<div class="down-badges">
											<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaplay')"></div>
											<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oaips')"></div>
											<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/mfa_banner_oamac')"></div>
										</div>
										<div class="add-qr">
											<div class="qr qr-image-banner">
												<div class="top left"></div>
												<div class="top right"></div>
												<div class="bottom right"></div>
												<div class="bottom left"></div>
											</div>
											<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
										</div>
                  					</div>
                  					<div class="general-desc add-desc" style="margin-top: 20px;display: none"><@i18n key="IAM.MFA.ONEAUTH.INSTALL.ENABLE" /></div>
									<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;display: none"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
                				</div>
								<div class="warning-msg many" style="display:none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.WARN" /></div>
            					</div>
								<div class="warning-msg biometric-msg" style="display:none">
									<div class="warning-icon icon-Warning-Icon"></div>
									<div class="warning-desc">
									<div class="warning-heading"><b><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.HEAD" /></b></div> 
									<@i18n key="IAM.MFA.ANNOUN.ONEAUTH.BIO.DESC" />
									</div>
									<button class="common-btn s-common-btn enable-bio" onclick="showBioPop()"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.ENABLE.BIOMETRICS" /></button>
								</div>
              				</div>
            			</div>
          			</div>
            
            			</#if>
         			</#if>
         			<#if allow_totp_mode??>
          			<div class="totp-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-totp"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.GOOGLE.AUTHENTICATOR" /></span></div>
              				<div class="radio-cont"></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
              				<div class="totp-body">
                				<div class="already-totp-conf" style="display: none">
                					<div class="hidden-checkbox"></div>
									<div class="already-totp-conf-desc general-desc add-desc before">
                    					<@i18n key="IAM.MFA.ANNOUN.TOTP.ALREADY.BEFORE" />
                  					</div>
									<div class="already-totp-conf-desc general-desc add-desc after" style="display: none">
										<@i18n key="IAM.MFA.ANNOUN.TOTP.CONF" />
									</div>
									<button class="common-btn s-common-btn verify-btn verify-totp-pro-but" onclick="verifyOldTotp(event)"><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button>
                  					<button class="add-new-totp-but link-btn" onclick="addNewTotp(event)"><@i18n key="IAM.CHANGE.CONFIGURATION" /></button>
                  					<button class="delete-totp-conf link-btn" onclick="handleDelete(event,deleteConfTotp, 'totp')"><@i18n key="IAM.DELETE.CONFIGURATION" /></button>
                				</div>
                				<div class="add-new-totp add-new-cont">
                					<div class="add-new-totp-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.TOTP.NEW" />
                  					</div>
                  					<button class="add-new-totp-but common-btn s-common-btn" onclick="addNewTotp(event)"><@i18n key="IAM.CONFIGURE" /></button>
                				</div>
                				<div class="new-totp" style="display: none">
                  					<div class="new-totp-codes">
                    					<div class="new-totp-desc general-desc margin-desc"><@i18n key="IAM.MFA.ANNOUN.TOTP.SCAN.NEXT" /></div>
                   						<div class="tfa_setup_work_space">
                      						<div class="key_qr_space">
                        						<div id="tfa_qr_space" class="tfa_qr_space">
                          							<img id="gauthimg" class="qr_tfa" alt="barcode image" />
                        						</div>
                        						<div class="or-text hide"><@i18n key="IAM.OR" /></div>
                       							<div class="qr_key_box" onclick="copyQrKey(this)" onmouseleave="resetTooltipText(this)">
                          							<div class="qr_key_head"><@i18n key="IAM.MANUAL.ENTRY" /></div>
                          							<div class="tooltip-container">
                          								<div class="tfa_info_text" id="skey">
                          								</div>
                          								<div class="tooltip-text"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></div>
                          							</div>
                          							<div class="qr_key_note"><@i18n key="IAM.TFA.TOTP.SPACE.TIP" /></div>
                        						</div>
                      						</div>
                      						<div class="note_text">
                        						<@i18n key="IAM.USE.AUTH.APP.SETUP.NOTE" />
                      						</div>
											<button class="common-btn s-common-btn leftZero" id="auth_app_confirm" tabindex="0" onclick="showTotpOtp();">
                        						<span><@i18n key="IAM.NEXT" /></span>
                      						</button>
											<button class="common-btn s-common-btn back-btn" onclick="totpAlreadyStepBack()" style="display:none"><span></span><@i18n key="IAM.BACK" /></button>
                    					</div>
                  					</div>
                  					<form name="verify_totp_form" onsubmit="submitForm(event); return false" style="display: none">
                    				<div class="totp-verify-desc general-desc margin-desc">
                      					<@i18n key="IAM.VERIFY.TWO.FACTOR.DESC" />
                    				</div>
                    				<div class="totp_input_container">
                      					<label for="totp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      					<div id="totp_split_input" class="totp_container"></div>
										<button class="common-btn s-common-btn leftZero verify-btn" type="submit" onclick="verifyTotpCode(event)"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button>
										<button class="common-btn s-common-btn back-btn" type="button" onclick="totpStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    				</div>
                  				</form>
                				</div>
              				</div>
            			</div>
          			</div>
         			</#if>	
          			<#if allow_yubikey_mode??>
          			<div class="yubikey-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-Yubikey"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.MFA.YUBIKEY" /></span></div>
              				<div class="radio-cont"></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
            				<div class="yubikey-body">
            					<div class="already-yubikey-conf already-cont" style="display:none">
            						<div class="hidden-checkbox verified-selected"></div>
									<div class="descriptions">
									<div class="already-desc general-desc margin-desc many" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="new-added-desc general-desc margin-desc many" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<div class="new-added-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
            						</div>
            						<div class="verified-yubikey-cont" style="display:none">
            							<div class="yubikey-image"></div>
            							<div class="verified-yubikey-details">
            								<span class="verified-yubikey name-detail"></span>
                      						<span class="added-period"></span>
            							</div>
            							<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteYubikey, 'yubikey')"></div>
            						</div>
            						<button class="add-new-yubikey-but add-new-btn link-btn" onclick="addNewYubikey(event)"><@i18n key="IAM.ADD.ANOTHER.YUBIKEY" /></button>
            					</div>
            					<div class="add-new-yubikey add-new-cont">
                  					<div class="add-new-yubikey-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.YUBI.NEW" />
                  					</div>
                  					<button class="add-new-yubikey-but common-btn s-common-btn" onclick="addNewYubikey(event)"><@i18n key="IAM.CONFIGURE" /></button>
                				</div>
                				<div class="new-yubikey" style="display: none">
                  					<div class="yubikey-one">
									<#if !is_mobile>
                    					<div class="yubikey-one-desc general-desc add-desc"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD" /></div>
                    					<div class="yubikey-insert-desc add-desc" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
                    				<#else>
                    					<div class="for_mobile_setup">
											<div id="yubikey_pic" class="yubikey_options">
												<div class="yubikey_anim_container">
													<div class="pic_about_usb"></div>
													<div class="pic_about_nfc"></div>
												</div>
											</div>
											<div class="dot_status">
												<span class="dot dot_1"></span>
												<span class="dot dot_2"></span>
											</div>
											<div class="yubikey_head general-desc"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD.FOR.MOBILE" /></div>
											<div class="yubikey-insert-desc general-desc" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
										</div>
                    				</#if>
										<button class="common-btn s-common-btn next-btn" onclick="scanYubikey(event)"><span></span><@i18n key="IAM.NEXT" /></button>
										<button class="common-btn s-common-btn back-btn" onclick="yubikeyStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                  					</div>
                  					<div class="yubikey-two" style="display: none">
                    					<div class="yubikey-two-desc general-desc margin-desc add-desc"><@i18n key="IAM.TFA.YUBIKEY.TOUCH" /></div>
										<button class="waiting-btn common-btn s-common-btn"><@i18n key="IAM.GDPR.DPA.WAITING" /> <span class="dot-flash-cont"><div class="dot-flashing"></div></span></button>
                  					</div>
                  					<div class="yubikey-three" style="display: none">
                  						<form name="yubikey_name_form" onsubmit="return false">
                    						<div class="yubikey-three-desc general-desc margin-desc add-desc"><@i18n key="IAM.MFA.YUBIKEY.HEAD.NAME" /></div>
                    						<div>
                    						<input type="text" placeholder="<@i18n key="IAM.MFA.ANNOUN.YUBI.PLACEHOLDER" />" id="yubikey_input" oninput="clearError('#yubikey_input', event)"/>
											</div>
											<button class="common-btn s-common-btn configure-btn" onclick="configureYubikey(event)"><span></span><@i18n key="IAM.CONFIGURE" /></button>
											<button class="common-btn s-common-btn back-btn" onclick="yubikeyOneStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    					</form>
                  					</div>
                				</div>
                				<div class="warning-msg" style="display: none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.YUBI.WARN" /></div>
            					</div>
             				</div>
            			</div>
          			</div>
          			</#if>
					<button class="show-all-modes-but link-btn" style="display: none" onclick="showModes()"><@i18n key="IAM.MFA.SHOW.OTHER.MODE.GT.2" /></button>
				</div>
	<div class="reverse-container" style="display: none">
        <div class="install-header">
          <span class="back-arrow-btn icon-back" onclick="tempBack(event)"> </span>
          <span class="sub-head">
                <@i18n key="IAM.REV.SETUP.MFA.ONEAUTH" />
          </span>
        </div>
        <div class="modes-container" id="slide2">
          <div class="step1-container mode-cont">
            <div class="step-icon">
                        <svg viewBox="0 0 24 24" width="12px" height="12px" ><polyline class="path" fill="none" points="20,6 9,17 4,12"
            	stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathlength="1"/></svg>
              <div class="step-loader"></div>
              <div class="step-line"></div>
            </div>
            <div class="mode-header" onclick="selectandslide(event)">
              <div class="mode-header-texts">
                <span class="step-count"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP1" /></span>
                <span class="step-header"><@i18n key="IAM.REV.QR.SCANED" /></span>
              </div>
              <div class="down-arrow"></div>
            </div>
            <div class="mode-body">
          		<div class="step1-qr">
					<div class="qr-new-cont">
					<div class="qr-cont" >
						<div class="init-loader"></div>
						<div class="qr-image" style="display: none;"></div>
						<div class="qr-refresh" onclick="refreshQr(event,'type',1)"><span class="icon-Reload"></span><span class="refresh-txt"><@i18n key="IAM.REFRESH" /></span></div>
					</div>
					<div class="qr-content">
						<div>
							<span class="new-desc"><@i18n key="IAM.SCAN.QR.BEGIN.SETUP" /></span>
							<span class="cont-desc" style="display: none"><@i18n key="IAM.REV.SCAN.CONT" /></span>
						</div>
						<div>
							<span class="new-desc"><@i18n key="IAM.REV.RESEND.VER.CODE" /></span>
							<span class="cont-desc" style="display: none"><@i18n key="IAM.REV.RESEND.VER.CODE" /></span>
						</div>
					</div>
				</div>
             </div>
             <div id="help1" class="helpcont" style="min-height:30px"></div>
            </div>
          </div>
          <div class="step2-container mode-cont">
            <div class="step-icon">
                        <svg viewBox="0 0 24 24" width="12px" height="12px" ><polyline class="path" fill="none" points="20,6 9,17 4,12"
            	stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathlength="1"/></svg>
              <div class="step-loader"></div>
              <div class="step-line"></div>
            </div>
            <div class="mode-header" onclick="selectandslide(event)">
              <div class="mode-header-texts">
                <span class="step-count"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP2" /></span>
                <span class="step-header"><@i18n key="IAM.REV.OA.INSTALL" /></span>
              </div>
              <div class="down-arrow"></div>
            </div>
            <div class="mode-body">
            <div class="step2-body">
            	<div class="lott-icon">
             		<div id="download-lott"></div>
            	</div>            
				<div class="step-desc"><@i18n key="IAM.REV.OA.DOWN.INSTALL" /></div>
				<div class="step-warn"><@i18n key="IAM.REV.OPEN.OA" /></div>
				<div id="help2" class="helpcont" style="min-height:30px"></div>
             </div>
            </div>
          </div>
          <div class="step3-container mode-cont">
            <div class="step-icon">
                        <svg viewBox="0 0 24 24" width="12px" height="12px" ><polyline class="path" fill="none" points="20,6 9,17 4,12"
            	stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathlength="1"/></svg>
              <div class="step-loader"></div>
              <div class="step-line"></div>
            </div>
            <div class="mode-header" onclick="selectandslide(event)">
              <div class="mode-header-texts">
                <span class="step-count"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP3" /></span>
                <span class="step-header"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></span>
              </div>
              <div class="down-arrow"></div>
            </div>
            <div class="mode-body">
            <div class="step3-body">
            	<div class="lott-icon">
           			<div id="otp-lott"></div>
            	</div>
				<div class="step-desc"><@i18n key="IAM.REV.OA.VER.CODE" /></div>
				<form name="rev_form" onsubmit="return false;">
				<label for="rev_split_input_full_value" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE" /></label>
				<div class="rev_input_cont">
					<div class="rev_input_wrap">
					<div id="rev_split_input" class="rev-otp"></div>
					</div>
					<button class="common-btn rev-verify-btn">
						<span><svg style="display:none" viewBox="0 0 24 24" width="16px" height="16px"><polyline class="path" fill="none" points="20,6 9,17 4,12" stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathLength="1" style="stroke-dashoffset: 2;"></polyline></svg></span>
						<span class="vtxt"><@i18n key="IAM.VERIFY" /></span>
					</button>
				</div>
				</form>
				<div id="help3" class="helpcont" style="min-height:30px"></div>
			</div>
			<div class="step3-qr" style="display: none">
			<div class="qr-new-cont">
				<div class="qr-cont">
					<div class="init-loader"></div>
					<div class="qr-image" style="display: none;"></div>
					<div class="qr-refresh" onclick="refreshQr(event,'type',3)"><span class="icon-Reload"></span><span class="refresh-txt"><@i18n key="IAM.REFRESH" /></span></div>
				</div>
				<div class="qr-content">
					<div><@i18n key="IAM.REV.SCAN.CONT" /></div>
					<div><@i18n key="IAM.REV.HELP3.TRUENO1" /></div>
				</div>
			</div>
			</div>
            </div>
          </div>
          <div class="step4-container mode-cont">
            <div class="step-icon">
            <svg viewBox="0 0 24 24" width="12px" height="12px" ><polyline class="path" fill="none" points="20,6 9,17 4,12"
            	stroke="#ffffff" stroke-miterlimit="4" stroke-width="4" pathlength="1"/></svg>
              <div class="step-loader"></div>
              <div class="step-line"></div>
            </div>
            <div class="mode-header" onclick="selectandslide(event)">
              <div class="mode-header-texts">
                <span class="step-count"><@i18n key="IAM.STEP4" /></span>
                <span class="step-header"><@i18n key="IAM.MFA.ENABLE.MFA" /></span>
              </div>
              <div class="down-arrow"></div>
            </div>
            <div class="mode-body">
            	<div class="lott-icon">
            		<div id="setting-lott"></div>
            	</div>           
            	<div class="step-desc"><@i18n key="IAM.REV.OA.ENABLE.MFA" /></div>
				<div id="help4" class="helpcont" style="min-height:30px"></div>
            </div>
          </div>
        </div>
      </div>
</div>
				<div class="succfail-btns">
				<button class="common-btn enable-mfa" disabled="disabled" style="display: none" onclick="enableMFA(event)"><span></span>
				<@i18n key="IAM.MFA.ENABLE.MFA" />
				</button>
				<button class="remind_me_later link-btn" onclick="(function(e){window.location.href=remindme; e.target.classList.add('remind_loader')})(event);"><span></span><@i18n key="IAM.TFA.BANNER.REMIND.LATER"/></button>
				</div>
			</div>
      		<div class="illustration-container">
        		<div class="illustration"></div>
			</div>
		</div>
		</body>	
		<script>
			window.onload=function() {
				setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500)
	    		URI.options.contextpath="${za.contextpath}/webclient/v1"; //No I18N
				URI.options.csrfParam = "${za.csrf_paramName}";
				URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
				nModes = $(".mode-cont").length;
				<#if allow_totp_mode??>
				splitField.createElement("totp_split_input", {
					splitCount: totpConfigSize,
					charCountPerSplit: 1,
					isNumeric: true,
					otpAutocomplete: true,
					customClass: "customOtp", //No I18N
					inputPlaceholder: "&#9679;",
					placeholder: I18N.get("IAM.ENTER.CODE")
				});
				$("#totp_split_input .splitedText").attr("onkeydown", "clearError('#totp_split_input', event)");
				</#if>

 				if(mfaData.modes.length>0){
 					$(".enable-mfa").css("visibility","visible");
 					if(mfaData.modes.length === 1 && mfaData.modes[0] === "otp"){
 						$(".enable-mfa").css("visibility","hidden");
 						$(".announcement_header .new").show();
						$(".enforce_mfa_desc .new").show();
 					}else{
 						$(".enforce_mfa_desc .re-enable").show();
						$(".announcement_header .re-enable").show();
 					}
 					$(".enable-mfa").css("display","block");
				}else{
					$(".announcement_header .new").show();
					$(".enforce_mfa_desc .new").show();
 				}
      			if(nModes === 1){
      				$(".enforce_mfa_desc.one").show();
      				$(".enforce_mfa_desc.many").hide();
      				$(".mode-cont .radio-cont").hide();
      				$(".mode-header").click();
      			}
				if(nModes >= 2){
					$(".enforce_mfa_desc.many").show();
				}
      			if(nModes === 2){
      				$(".show-all-modes-but").html(I18N.get("IAM.MFA.SHOW.OTHER.MODE.2"));
      			}
      			<#if allow_oneauth_mode??>
					<#if enable_rev_sn?has_content >
						splitField.createElement("rev_split_input", {
							splitCount: revConfigSize,
							charCountPerSplit: 1,
							isNumeric: true,
							otpAutocomplete: true,
							customClass: "customOtp", //No I18N
							inputPlaceholder: "&#9679;",
							placeholder: I18N.get("IAM.ENTER.CODE")
						});
						$("#rev_split_input .splitedText").attr("onkeydown", "clearError('#rev_split_input', event)");
					</#if>
					if(nModes > 1 && (alreadyConfiguredModes.length == 0 || mfaData.devices ) || (alreadyConfiguredModes.length == 1 && mfaData.modes[0] == "otp")){
						$(".sms-container, .totp-container, .yubikey-container").slideUp(0);
						$(".show-all-modes-but").slideDown(0);
						<#if enable_rev_sn?has_content >
						if(!mfaData.devices){
							<#if !(is_mobile)>
							rev = reverseSignin();
							rev.init();
							</#if>
							$(".splitback").show();
						}else{
							$(".splitback").hide();
						}
						</#if>
						$(".oneauth-container .mode-header").click();
						setTimeout(function(){
							$(".container").show();
						},250)
      			 	}
					else{
						$(".container").show();
					}
					if(isMobile){
						if(/Android/i.test(navigator.userAgent)){
							$(".add-oneauth .down-badges .appstore-icon").hide()
							$(".add-oneauth .down-badges .macstore-icon").hide();
							$(".add-oneauth .down-badges .winstore-icon").hide();
						} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
							$(".add-oneauth .down-badges .appstore-icon").css({"order":1});
							$(".add-oneauth .down-badges .playstore-icon").hide();
							$(".add-oneauth .down-badges .macstore-icon").hide();
							$(".add-oneauth .down-badges .winstore-icon").hide();
						}
					}
					if(/Mac|Macintosh|OS X/i.test(navigator.userAgent)){
						$(".add-oneauth .down-badges .winstore-icon").hide();
						$(".oneauth-d-options .winstore-icon").hide();
					} else if(/windows|Win|Windows|Trident/i.test(navigator.userAgent)){
						$(".add-oneauth .down-badges .winstore-icon").css({"order":-1});
						$(".add-oneauth .down-badges .macstore-icon").hide();
						$(".oneauth-d-options .macstore-icon").hide();
					} else {
						$(".add-oneauth .down-badges .macstore-icon").hide();
						$(".oneauth-d-options .macstore-icon").hide();
					}
					if(/Mac|Macintosh|OS X/i.test(navigator.userAgent) && ($(window).width() < 620 && $(window).width() > 430)){
						$(".playstore-icon, .winstore-icon").hide()
					}
				<#else>
      			 	$(".container").show();
				</#if>
				if(alreadyConfiguredModes != undefined && alreadyConfiguredModes.length > 0 ){
					for(var i = 0; i<alreadyConfiguredModes.length; i++){
						displayAlreadyConfigured(alreadyConfiguredModes[i], mfaData[alreadyConfiguredModes[i]]);
					}
				}
			}
			document.querySelector(".modes-container").addEventListener("click", checkEnable);
		</script>
	</html>	
	