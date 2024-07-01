<#if ( redirect_to_oneauth?has_content )>
	<#include "../oauth/redirectToPage.tpl">
<#else>
	<!DOCTYPE html>
	<html>
		<head>
			<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=5.0" />
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

				.radio-cont {
					display: none;
				}

			</style>

			<script>
			<#if password_policy??>
    			var password_policy = ${password_policy};
    		</#if>
    			var mfaData = "";
				var nModes;
				var priortyOrder = ${primary_modes_order};
				var confData = <#if configured_data??>${configured_data}<#else>undefined</#if>
				var modesContainerMap = { otp: 'sms', devices: 'oneauth', yubikey: 'yubikey', totp: 'totp'}
				var isMobile = ${is_mobile?c};
				var showMobileNoPlaceholder = ${mob_plc_holder?c};
				var csrfParam= "${za.csrf_paramName}";
				var csrfCookieName = "${za.csrf_cookieName}";
				var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
				<#if nxt_preann_url??>var next = '${Encoder.encodeJavaScript(nxt_preann_url)}'</#if>
			</script>
		</head>
		<body>

			<#include "../zoho_line_loader.tpl">
			<@resource path="/v2/components/css/mfaenforcement.css" />
			<@resource path="/v2/components/css/uvselect.css" />
			<#if MOBILE_OTP>
			<@resource path="/v2/components/css/flagIcons.css" />
			<script>
	    		var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
    		</script>
    		<#include "../utils/captcha-handler.tpl">
			</#if>
			
			<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
			<@resource path="/v2/components/js/common_unauth.js" />
			<@resource path="/v2/components/js/splitField.js" attributes="defer" />
			<#include "../utils/webauthn-register.tpl">
			<#if MOBILE_OTP??>
			<@resource path="/v2/components/js/phonePatternData.js" attributes="defer" />
			<@resource path="/v2/components/js/flagIcons.js" attributes="defer" />
		   	</#if>
		   	<#if PASSWORD??>
		   	<@resource path="/v2/components/js/security.js" />
		   	<@resource path="/v2/components/tp_pkg/tippy.all.min.js" attributes="defer" />
		   	<script type="text/javascript" src="${za.contextpath}/encryption/script"></script>
		   	</#if>
		   	<@resource path="/v2/components/js/zresource.js" />
		   	<@resource path="/v2/components/js/uri.js" />
		   	<@resource path="/v2/components/js/uvselect.js" attributes="defer" />
		   	<@resource path="/v2/components/js/pfa-enforcement.js" />
			<#if EMAIL_OTP??>
				<@resource path="/v2/components/tp_pkg/xregexp-all.js" attributes="defer" />
			</#if>
			
			<link rel="preload" as="image" href="${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}" type="image/svg+xml" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_semibold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}" type="font/woff" crossorigin="anonymous">
			<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_medium.woff")}" type="font/woff" crossorigin="anonymous">
			<script type="text/javascript">
				I18N.load({
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
					"IAM.PFA.ANNOUN.SHOW.2": '<@i18n key="IAM.PFA.ANNOUN.SHOW.2" />',
					"IAM.MFA.CONFIRM.DELETE.MODE": '<@i18n key="IAM.MFA.CONFIRM.DELETE.MODE" />',
					"IAM.TFA.BACKUP.ACCESS.CODES": '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" />',
					"IAM.JUST.NOW": '<@i18n key="IAM.JUST.NOW" />',
					"IAM.CONFIGURE": '<@i18n key="IAM.CONFIGURE" />',
					"IAM.MFA.ANNOUN.USE.SAME.CONFIGURE": '<@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" />',
					"IAM.MFA.ANNOUN.USE.SAME.ENABLE": '<@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" />',
					"IAM.GENERAL.USERNAME": '<@i18n key="IAM.GENERAL.USERNAME" />',
					"IAM.GENERATE.ON": '<@i18n key="IAM.GENERATE.ON" />',
					"IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL" />',
					"ICREST.SUCCESS.MESSAGE": '<@i18n key="ICREST.SUCCESS.MESSAGE" />',
					"IAM.PFA.ANNOUN.DESC.ONE": '<@i18n key="IAM.PFA.ANNOUN.DESC.ONE" />',
					"IAM.PFA.MODE.SUCC" : '<@i18n key="IAM.PFA.MODE.SUCC" />',
					"IAM.APP.SESSION.MAX.LIMIT.GO.TO" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.GO.TO" />'
				});
				<#if PASSKEY??>
				 I18N.load({
					"IAM.PASSKEY.CONFIGURED.ONE" : '<@i18n key="IAM.PASSKEY.CONFIGURED.ONE" />',
					"IAM.PASSKEY.CONFIGURED.MANY" : '<@i18n key="IAM.PASSKEY.CONFIGURED.MANY" />',
					"IAM.TFA.PASSKEY" : '<@i18n key="IAM.TFA.PASSKEY" />'
				 });
				</#if>
				<#if PASSWORD??>
				 I18N.load({
					"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
					"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
					"IAM.PASS_POLICY.CASE" : '<@i18n key="IAM.PASS_POLICY.CASE" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PFA.ANNOUN.PASSWORD.SUCCESS": '<@i18n key="IAM.PFA.ANNOUN.PASSWORD.SUCCESS" />',
					"IAM.AC.REENTER.PASSWORD.EMPTY.ERROR" : '<@i18n key="IAM.AC.REENTER.PASSWORD.EMPTY.ERROR" />'
				 });
				</#if>
				<#if MOBILE_OTP??>
				 I18N.load({
				 	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" />',
					"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN" />',
					"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" />',
					"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
					"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
				 	"IAM.MFA.ANNOUN.SMS.SWAP.HEADING" : '<@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.HEADING" />',
				 	"IAM.NEW.SIGNIN.MOBILE" : '<@i18n key="IAM.NEW.SIGNIN.MOBILE" />',
				 	"IAM.MFA.ANNOUN.SMS.PREF.LABEL":'<@i18n key="IAM.MFA.ANNOUN.SMS.PREF.LABEL" />',
				 	"IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC":'<@i18n key="IAM.MFA.ANNOUN.SMS.PREF.LABEL.DESC" />',
					"IAM.MFA.ANNOUN.SMS.SWAP.HEADING": '<@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.HEADING" />',
					"IAM.NUMBER.CONFIGURED.ONE": '<@i18n key="IAM.NUMBER.CONFIGURED.ONE" />',
					"IAM.NUMBER.CONFIGURED.MANY": '<@i18n key="IAM.NUMBER.CONFIGURED.MANY" />',
					"IAM.MFA.ANNOUN.SMS.MANY.DESC": '<@i18n key="IAM.MFA.ANNOUN.SMS.MANY.DESC" />',
					"IAM.MFA.ANNOUN.SMS.ONE.DESC": '<@i18n key="IAM.MFA.ANNOUN.SMS.ONE.DESC" />',
					"IAM.MFA.DEL.PREF.NUMB.DESC": '<@i18n key="IAM.MFA.DEL.PREF.NUMB.DESC" />',
					"IAM.TFA.SMS.HEAD" : '<@i18n key="IAM.TFA.SMS.HEAD" />'
				 });
				 var IPcountry = "${req_country}";
				 var otp_length = ${otp_length};
				 </#if>
				<#if TOTP??>
				I18N.load({
					"IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" : '<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" />',
					"IAM.CONFIGURED" : '<@i18n key="IAM.CONFIGURED" />',
					"IAM.MFA.ANNOUN.TOTP.CONF": '<@i18n key="IAM.MFA.ANNOUN.TOTP.CONF" />',
					"IAM.MFA.COPY.CLIPBOARD" : '<@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" />',
					"IAM.APP.PASS.COPIED" : '<@i18n key="IAM.APP.PASS.COPIED" />',
					"IAM.TAP.TO.COPY" : '<@i18n key="IAM.TAP.TO.COPY" />',
					"IAM.GOOGLE.AUTHENTICATOR" : '<@i18n key="IAM.GOOGLE.AUTHENTICATOR" />',
				})
				var totpConfigSize = ${totp_config_size};
				</#if>
				<#if EMAIL_OTP??>
				I18N.load({
					"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID"/>',
					"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN" />',
					"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" />',
					"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS" />',
					"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING" />',
					"IAM.EMAIL.CONFIGURED.ONE": '<@i18n key="IAM.EMAIL.CONFIGURED.ONE" />',
					"IAM.EMAIL.CONFIGURED.MANY": '<@i18n key="IAM.EMAIL.CONFIGURED.MANY" />',
					"IAM.EMAIL.OTP" : '<@i18n key="IAM.EMAIL.OTP" />'
				})
				var otp_length = ${otp_length};
				</#if>
				var contextpath = '${za.contextpath}';
				var accounts_support_contact_email_id = '${support_email}';
				var mobileHeader = {"0": "", "1":"IAM.NUMBER.CONFIGURED.ONE", "2":"IAM.NUMBER.CONFIGURED.MANY"}
				var oneauthHeader = {"0": "", "1":"IAM.DEVICE.CONFIGURED.ONE", "2":"IAM.DEVICE.CONFIGURED.MANY"}
				var yubikeyHeader = {"0": "", "1":"IAM.YUBIKEY.CONFIGURED.ONE", "2":"IAM.YUBIKEY.CONFIGURED.MANY"}
				var passkeyHeader = {"0": "", "1":"IAM.YUBIKEY.CONFIGURED.ONE", "2":"IAM.YUBIKEY.CONFIGURED.MANY"}
				var emailHeader = {"0": "", "1":"IAM.EMAIL.CONFIGURED.ONE", "2":"IAM.EMAIL.CONFIGURED.MANY"}
				var modesHeaders= {"EMAIL_OTP" : "IAM.EMAIL.OTP", "MOBILE_OTP" : "IAM.TFA.SMS.HEAD", "TOTP" : "IAM.GOOGLE.AUTHENTICATOR", "PASSKEY" : "IAM.TFA.PASSKEY"};
				var iam_search_text = '<@i18n key="IAM.SEARCHING" />';
				var iam_no_result_found_text = '<@i18n key="IAM.NO.RESULT.FOUND" />';
			</script> 
			
			<div class="blur"></div> 
			<#if DEVICE??> 
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
					<div class="oneauth-step"><@i18n key="IAM.PFA.ANNOUN.ONEAUTH.STEP2" /></div>
					<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3" /></div>
					<div class="oneauth-footer"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT" /> <a href="https://zurl.to/mfa_banner_oaworks" target="_blank" class="onefoot-link"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK" /></a></div>
				</div>
				<button class="common-btn" style="margin-left:30px; margin-top: 0px" onclick="contSignin(event)"><@i18n key="IAM.ENABLED.MFA" /></button>
			</div>
			</#if>
			<div id="error_space" class="error_space">
				<span class="error_icon">&#33;</span> <span class="top_msg"></span>
			</div>
			<div class="delete-popup" style="display: none" tabindex="1" onkeydown="escape(event)">
				<div class="popup-header">
        			<div class="popup-heading"><@i18n key="IAM.CONFIRM.POPUP.DELETE.MFA.MODE" /></div>
      			</div>
      			<div class="popup-body">
      			<div class="delete-desc"></div>
      			<div class="textbox_label marg"><@i18n key="IAM.SELECT.NEW.PREF.NUMB" /></div>
      			<div class="delete_mfa_numb">
					<div class="radio_btn deleteMFAPref" style="display:none">
						<input id="mfamobilepref" type="radio" name="selectmode" class="real_radiobtn">
						<div class="outer_circle swapNum_outer_circle">
							<div class="inner_circle swapNum_inner_circle"></div>
						</div>
						<label class="radiobtn_text" for="mfamobilepref"></label>
					</div>
				</div>
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
			<#if allow_sms_mode??>
			<div class="number-swap" style="display:none">
				<div class="swap-desc1"><@i18n key="IAM.MFA.ANNOUN.SMS.SWAP.DESC" /></div>
				<button class="confirm-swap common-btn" onclick="swapNumber(event)"><span></span><@i18n key="IAM.SIGNUP.CHANGE" /></button>
				<button class="common-btn cancel-btn" onclick="closePopup()"><@i18n key="IAM.CANCEL" /></button>
			</div>
			</#if>
			<div class="pfa-success-desc" style="display: none">
    			<div class="backup-codes-desc"><@i18n key="IAM.PFA.SUCC.DESC" /></div>
      			<button class="common-btn" onclick="contSignin(event)"><span></span><@i18n key="IAM.CONTINUE" /></button>
    		</div>
			<div class="pref-info" style="display:none">
				<div class="pref-text">
					<span></span>
					<span class="pref-icon icon-cinformation"></span>
					<div class="pref-desc"></div>
				</div>
			</div>
			<div class="flex-container" >
				<div class="container" style="display:none">
					<div class="rebrand_partner_logo"></div>
					<div class="announcement_header">
						<div class="nomodes-enable"><@i18n key="IAM.PFA.ANNOUN.HEADER"/></div>
					</div>
					<div class="enforce_mfa_desc many" style="display: block">
						<div class="nomodes-enable" style="display: block">
							<@i18n key="IAM.PFA.ANNOUN.DESC.MANY" />
						</div>
        			</div>
        			<div class="enforce_mfa_desc one" style="display: none">
						<div class="nomodes-enable" style="display: block">
							<@i18n key="IAM.PFA.ANNOUN.DESC.ONE" arg0=""/>
						</div>
        			</div>
				<div class="modes-container pfa-modes">
					<#if PASSKEY??>
         			<div class="passkey-container mode-cont">
         				<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-passkey"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.TFA.PASSKEY" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
            				<div class="passkey-body">
            					<div class="already-passkey-conf already-cont" style="display:none">
            						<div class="hidden-checkbox verified-selected"></div>
									<#-- <#if mfa_data.is_mfa_activated>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<#else>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									</#if> -->
            						<div class="verified-passkey-cont" style="display:none">
            							<div class="verified-passkey-details">
            								<span class="verified-passkey name-detail"></span>
                      						<span class="added-period"></span>
            							</div>
            						<#--	<div class="delete-icon icon-delete" onclick="handleDelete(event, deleteYubikey, 'yubikey')"></div> -->
            						</div>
            						<button class="add-new-passkey-but add-new-btn link-btn" onclick="addNewPasskey(event)"><@i18n key="IAM.ADD.NEW.PASSKEY" /></button>
            					</div>
            					<div class="add-new-passkey add-new-cont">
                  					<div class="add-new-passkey-desc general-desc add-desc">
                    					<@i18n key="IAM.PASSKEY.EXP.DESC" />
                  					</div>
                  				<button class="add-new-yubikey-but common-btn s-common-btn" onclick="addNewPasskey(event)"><@i18n key="IAM.CONFIGURE" /></button> 
                  					<#-- <button class="add-new-yubikey-but common-btn s-common-btn" onclick="initPasskeySetup(event)"><span></span><@i18n key="IAM.CONFIGURE" /><span class="dot-flash-cont" style="display:none;"><div class="dot-flashing"></div></span></button> -->
                				</div>
                				<div class="new-passkey" style="display: none">
                  					<div class="passkey-one">
                    					<div class="passkey-one-desc general-desc add-desc"><@i18n key="IAM.PASSKEY.EXP.DESC" /></div>
                    					<ul class="general-desc add-desc passkey-points">
                    					<li class="passkey-insert-desc"><@i18n key="IAM.PASSKEY.SETUP.INS1" /></li>
                    					<li class="passkey-insert-desc"><@i18n key="IAM.PASSKEY.SETUP.INS2" /></li>
                    					</ul>
                    					<form name=passkey_name_form" onsubmit="return false">
                    						<div class="emolabel add-desc"><@i18n key="IAM.TFA.PASSKEY.CONFIGURATION.NAME" /></div>
                    						<div>
                    							<input type="text" id="passkey_input" onkeydown="clearError('#passkey_input', event)"/>
											</div>
											<button class="common-btn s-common-btn next-btn" onclick="initPasskeySetup(event)"><span></span><@i18n key="IAM.NEXT" /></button>
											<button class="common-btn s-common-btn back-btn" onclick="passkeyStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    					</form>
                  					</div>
                  					<div class="passkey-two" style="display: none">
                    					<div class="passkey-two-desc general-desc margin-desc add-desc"><@i18n key="IAM.PASSKEY.EXP.DESC" /></div>
										<button class="waiting-btn common-btn s-common-btn"><@i18n key="IAM.GDPR.DPA.WAITING" /> <span class="dot-flash-cont"><div class="dot-flashing"></div></span></button>
                  					</div>
                				</div>
                				<#-- <div class="warning-msg" style="display: none">
            						<div class="warning-icon icon-Warning-Icon"></div>
            						<div class="warning-desc"><@i18n key="IAM.MFA.ANNOUN.YUBI.WARN" /></div>
            					</div> -->
             				</div>
            			</div>
         			</div>
         			</#if>
         			<#if DEVICE??>
         			<div class="oneauth-container mode-cont">
        				<div class="mode-header" onclick="selectandslide(event)" style="flex-direction: column ; gap: 20px;">
              				<div class="one-header">
              				<div class="mode-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
							<div class="mode-header-texts"><span><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /><div class="icon3-newtab"></div></span><div class="oneauth-desc or-text"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div></div>
							<div class="down-arrow"></div>
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
								<div class="general-desc" style="margin-top: 20px;pointer-events:none;"><@i18n key="IAM.PFA.ANNOUN.ONEAUTH.INSTALL.ENABLE" /></div>
								<button class="common-btn s-common-btn oneauth-add-link" onclick="showOneauthPop()" style="margin-top: 16px;"><@i18n key="IAM.ENABLE.MFA.ONEAUTH" /></button>
                  			</div>
            			</div>
            			<div class="mode-body">
            			</div>
          			</div>
          			</#if>
         			<#if PASSWORD??>
         			<div class="password-container mode-cont">
         				<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-Myself"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
	            			<div class="password-body">
	            				<div class="new-password" style="">
	          						<div class="password-one-desc general-desc add-desc"><@i18n key="IAM.PFA.ANNOUN.PASSWORD.DESC" /></div>
	            					<div class="new-password-step-one add-new-cont" >
	            						<button class="common-btn s-common-btn next-btn" onclick="initPasswordSetup()"><span></span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET" /></button>
	            					</div>
	            					<div class="new-password-step-two add-new-cont" style="display:none" >
	            						<form name="password_form" onsubmit="return false" style="margin-top:20px;">											
											<div class="emolabel add-desc"><@i18n key="IAM.NEW.PASS" /></div>
											<div class="pfa_pass_field_con" style="margin-bottom: 20px;">
												<span class="pass_lock-icon icon-Myself"></span>
												<input class="pfa-input-field" type="password" id="password_input" autocomplete="off" oninput="clearError('#password_input', event);checkPassword();">
												<span class="pass_eye icon-hide" onclick="togglePassword(this)"></span>
											</div>
											<div class="emolabel add-desc"><@i18n key="IAM.CONFIRM.PASS" /></div>
											<div class="pfa_pass_field_con">
												<span class="pass_lock-icon icon-Myself"></span>
												<input class="pfa-input-field" type="password" id="confirm_password_input" autocomplete="off" oninput="clearError('#confirm_password_input', event);checkPassword();">
												<span class="pass_eye icon-hide" onclick="togglePassword(this)"></span>
											</div>
	            							<button id="set_pass" class="common-btn s-common-btn next-btn" onclick="setPassword()"><span></span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET" /></button>
	            						</form>
	            					</div>
	            				</div>
	            			</div>
            			</div>
         			</div>
         			</#if>
         			<#if FEDERATED_SIGNIN??>
         			<div class="IDP-container mode-cont">
         				<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-sign-in"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.PFA.ANNOUN.FED.SIGNIN" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
	            			<div class="password-body">
	            				<div class="new-password" style="">
	          						<div class="password-one-desc general-desc add-desc"><@i18n key="IAM.PFA.ANNOUN.FED.DESC" /></div>
	            					<div class="new-IDP-step add-new-cont" >
	         							<#if GOOGLE??>
	         							<div class="idp_option idp-google" onclick="thirdparty_authentication('GOOGLE');">
											<div class="idp_center">
												<div class="idp_font_icon icon-google">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												</div>
												<div class="idp_name text_google"><@i18n key="IAM.FEDERATED.SIGNIN.GOOGLE" /></div>
											</div>				
										</div>
										</#if>
										<#if AZURE??>
	            						<div class="idp_option idp-azure" onclick="thirdparty_authentication('AZURE');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-azure">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
												</div>
												<div class="idp_name text_azure"><@i18n key="IAM.FEDERATED.SIGNIN.MICROSOFT" /></div>
											</div>				
										</div>
										</#if>
										<#if LINKEDIN??>
										<div class="idp_option idp-linkedin" onclick="thirdparty_authentication('LINKEDIN');">
											<div class="idp_center">
												<div class="idp_font_icon icon-linkedin"></div>
												<div class="idp_name text_linkedid"><@i18n key="IAM.FEDERATED.SIGNIN.LINKEDIN" /></div>
											</div>
										</div>
										</#if>
										<#if FACEBOOK??>
										<div class="idp_option idp-fb" onclick="thirdparty_authentication('FACEBOOK');">
											<div class="idp_center">
												<div class="idp_font_icon icon-facebook"></div>
												<div class="idp_name text_fb"><@i18n key="IAM.FEDERATED.SIGNIN.FACEBOOK" /></div>	
											</div>				
										</div>
										</#if>
										<#if TWITTER??>
										<div class="idp_option idp-twitter" onclick="thirdparty_authentication('TWITTER');">
											<div class="idp_center">
												<div class="idp_font_icon icon-twitter"></div>
												<div class="idp_name text_twitter"><@i18n key="IAM.FEDERATED.SIGNIN.TWITTER" /></div>			
											</div>		
										</div>
										</#if>
										<#if YAHOO??>
										<div class="idp_option idp-yahoo" onclick="thirdparty_authentication('YAHOO');">
											<div class="idp_center">
												<div class="idp_font_icon icon-yahoo"></div>
												<div class="idp_name text_yahoo"><@i18n key="IAM.FEDERATED.SIGNIN.YAHOO" /></div>
											</div>				
										</div>
										</#if>
										<#if SLACK??>
										<div class="idp_option idp-slack" onclick="thirdparty_authentication('SLACK');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-slack">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</div>
												<div class="idp_name text_slack"><@i18n key="IAM.FEDERATED.SIGNIN.SLACK" /></div>
											</div>				
										</div>
										</#if>
										<#if DOUBAN??>
										<div class="idp_option idp-douban" onclick="thirdparty_authentication('DOUBAN');">
											<div class="idp_center">
												<div class="idp_font_icon icon-douban"></div>
												<div class="idp_name text_douban"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.DOUBAN" /></div>
											</div>				
										</div>
										</#if>
										<#if QQ??>
										<div class="idp_option idp-qq" onclick="thirdparty_authentication('QQ');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-qq">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
													<span class="path6"></span>
													<span class="path7"></span>
													<span class="path8"></span>
												</div>
												<div class="idp_name text_qq"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.QQ" /></div>
											</div>			
										</div>
										</#if>
										<#if WECHAT??>
										<div class="idp_option idp-wechat" onclick="thirdparty_authentication('WECHAT');">
											<div class="idp_center">
												<div class="idp_font_icon icon-wechat"></div>
												<div class="idp_name text_wechat"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.WECHAT" /></div>
											</div>					
										</div>
										</#if>
										<#if WEIBO??>
										<div class="idp_option idp-weibo" onclick="thirdparty_authentication('WEIBO');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-weibo">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
												</div>
												<div class="idp_name text_weibo"><@i18n key="IAM.FEDERATED.SIGNIN.WEIBO" /></div>	
											</div>				
										</div>
										</#if>
										<#if APPLE??>
										<div class="idp_option idp-apple" onclick="thirdparty_authentication('APPLE');">
											<div class="idp_center">
												<div class="idp_font_icon icon-apple"></div>
												<div class="idp_name text_apple"><@i18n key="IAM.FEDERATED.SIGNIN.APPLE" /></div>
											</div>				
										</div>
										</#if>
										<#if INTUIT??>
										<div class="idp_option idp-intuit" onclick="thirdparty_authentication('INTUIT');">
											<div class="idp_center">
												<div class="idp_font_icon icon-intuit"></div>
												<div class="idp_name text_intuit"><@i18n key="IAM.FEDERATED.SIGNIN.INTUIT" /></div>
											</div>					
										</div>
										</#if>
										<#if ADP??>
										<div class="idp_option idp-adp" onclick="thirdparty_authentication('ADP');">
											<div class="idp_center">
												<div class="idp_font_icon icon-adp"></div>
												<div class="idp_name text_adp"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.ADP" /></div>
											</div>				
									 	</div>
									 	</#if>
										<#if FEISHU??>
										<div class="idp_option idp-feishu" onclick="thirdparty_authentication('FEISHU');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-feishu">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
												</div>
												<div class="idp_name text_feishu"><@i18n key="IAM.FEDERATED.SIGNIN.FEISHU" /></div>
											</div>				
										</div>
										</#if>
										<#if GITHUB??>
										<div class="idp_option idp_opt_slide idp-github" onclick="thirdparty_authentication('GITHUB');">
											<div class="idp_center">
												<div class="idp_font_icon multi_colour_icon icon-github"></div>
												<div class="idp_name text_github"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.GITHUB" /></div>
											</div>				
										</div>
										</#if>
	            					</div>
	            				</div>
	            			</div>
            			</div>
         			</div>
         			</#if>
         			<#if TOTP??>
          			<div class="totp-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-totp"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.GOOGLE.AUTHENTICATOR" /></span></div>
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
								<#--	<button class="common-btn s-common-btn verify-btn verify-totp-pro-but" onclick="verifyOldTotp(event)"><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button> -->
                  					<button class="add-new-totp-but link-btn" onclick="addNewTotp(event)"><@i18n key="IAM.CHANGE.CONFIGURATION" /></button>
                  				<#--	<button class="delete-totp-conf link-btn" onclick="handleDelete(event,deleteConfTotp, 'totp')"><@i18n key="IAM.DELETE.CONFIGURATION" /></button> -->
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
                  					<form name="verify_totp_form" onsubmit="submitForm(event);return false;" novalidate style="display: none">
                    				<div class="totp-verify-desc general-desc margin-desc">
                      					<@i18n key="IAM.VERIFY.TWO.FACTOR.DESC" />
                    				</div>
                    				<div class="totp_input_container">
                      					<label for="totp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      					<div id="totp_split_input" class="totp_container"></div>
										<button class="common-btn s-common-btn leftZero verify-btn" type="submit" onclick="verifyTotpCode(event);"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button>
										<button class="common-btn s-common-btn back-btn" type="button" onclick="totpStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    				</div>
                  				</form>
                				</div>
              				</div>
            			</div>
          			</div>
         			</#if>
         			<#if EMAIL_OTP??>
          			<div class="email-container mode-cont">
            			<div class="mode-header" onclick="selectandslide(event)">
              				<div class="mode-icon icon-pebble icon-email"></div>
              				<div class="mode-header-texts"><span><@i18n key="IAM.EMAIL.OTP" /></span></div>
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
              				<div class="email-body">
                				<div class="already-verified-email already-cont" style="display: none">
                					<div class="hidden-checkbox verified-selected"></div>
								<#--	<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div> -->
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
            						<div class="verified-email-cont" style="display:none">
                    					<div class="verified-checkbox"></div>
                    					<div class="verified-email-details">
                      						<span class="verified-email name-detail"></span>
                      						<span class="added-period"></span>                      						
                    					</div>
                    				<#--	<div class="delete-icon icon-delete" onclick="handleDelete(event, deletePhNumber, 'sms')"></div> -->
                  					</div>
                  					<button class="add-new-email-but add-new-btn link-btn" onclick="addNewEmail(event)"><@i18n key="IAM.ADD.ANOTHER.EMAIL" /></button>
                				</div>
                				<div class="add-new-email add-new-cont">
                					<div class="add-new-email-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.TOTP.NEW" />
                  					</div>
                  					<button class="add-new-email-but common-btn s-common-btn" onclick="addNewEmail(event)"><@i18n key="IAM.ADD.NEW.EMAIL" /></button>
                				</div>
                				<div class="new-email" style="display: none">
                  					<div class="new-email-add">
                   						<form name="email_add_form" onsubmit="sendEmailOTP(event); return false">
                   							<div class="new-email-desc general-desc margin-desc add-desc"><@i18n key="IAM.EMAIL.SEND.OTP.VERIFY" /></div>
											<div class="email_input_container">
												<label for="email_input" class="emolabel"><@i18n key="IAM.EMAIL.ADDRESS"/></label>
												<input type="text" id="email_input" placeholder="<@i18n key="IAM.ENTER.EMAIL"/>" autocomplete="email" onkeydown="clearError('#email_input', event)" oninput="allowSubmit(event)" />
											</div>
											<button class="common-btn s-common-btn" type="submit"><@i18n key="IAM.SEND.OTP"/><span style="margin:0"></span></button>
										</form>
										<form name="verify_email_form" onsubmit="verifyEmailOTP(event); return false;" novalidate style="display: none">
        									<div class="otp-sent-desc general-desc margin-desc add-desc">
                      							<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>
                      							<span class="emailval">
                        							<div class="valueemail"></div>
                        							<span class="edit_option" onclick="editEmail()"><@i18n key="IAM.EDIT" /></span>
                      							</span>
                    						</div>
											<div class="otp_input_container">
												<label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
												<div id="emailotp_split_input" class="otp_container"></div>
												<div class="resend_otp" onclick="resendEmail()"><span></span><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></div>
												<button class="common-btn s-common-btn leftZero  verify_btn" type="submit"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
											</div>
										</form>
                  					</div>
                  					<#-- <form name="verify_email_form" onsubmit="submitForm(event);return false;" novalidate style="display: none">
                    				<div class="totp-verify-desc general-desc margin-desc">
                      					<@i18n key="IAM.VERIFY.TWO.FACTOR.DESC" />
                    				</div>
                    				<div class="email_input_container">
                      					<label for="totp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      					<div id="totp_split_input" class="totp_container"></div>
										<button class="common-btn s-common-btn leftZero verify-btn" type="submit" onclick="verifyTotpCode(event);"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button>
										<button class="common-btn s-common-btn back-btn" type="button" onclick="totpStepBack()"><span></span><@i18n key="IAM.BACK" /></button>
                    				</div>
                  				</form> -->
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
              				<div class="down-arrow"></div>
            			</div>
            			<div class="mode-body">
            				<div class="yubikey-body">
            					<div class="already-yubikey-conf already-cont" style="display:none">
            						<div class="hidden-checkbox verified-selected"></div>
									<#-- <#if mfa_data.is_mfa_activated>
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
									<#else> -->
									<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.YUBI.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
									<#-- </#if> -->
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
                    						<input type="text" placeholder="<@i18n key="IAM.MFA.ANNOUN.YUBI.PLACEHOLDER" />" id="yubikey_input" onkeydown="clearError('#yubikey_input', event)"/>
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
          			<#if MOBILE_OTP??>
					<div class="sms-container mode-cont">
						<div class="mode-header" onclick="selectandslide(event)">
							<div class="mode-icon icon-pebble icon-Mobile"></div>
							<div class="mode-header-texts"><span><@i18n key="IAM.TFA.SMS.HEAD" /></span></div>
							<div class="down-arrow"></div>
						</div>
            			<div class="mode-body">
              				<div class="sms-body">
                				<div class="already-verified already-cont" style="display: none">
                					<#-- <#if mfa_data.is_mfa_activated>
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.CONFIGURE" /></div>
                					<#else>
                					<div class="already-desc general-desc margin-desc many"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.MANY.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					<div class="already-desc general-desc margin-desc one" style="display: none"><@i18n key="IAM.MFA.ANNOUN.SMS.CONF.ONE.DESC" /> <@i18n key="IAM.MFA.ANNOUN.USE.SAME.ENABLE" /></div>
                					</#if> -->
                  					<div class="verified-numb-cont" style="display:none" onclick="selectNumberDevice(event)">
                    					<div class="verified-checkbox"></div>
                    					<div class="verified-numb-details">
                      						<span class="verified-number name-detail"></span>
                      						<span class="added-period"></span>                      						
                    					</div>
                    				<#--	<div class="delete-icon icon-delete" onclick="handleDelete(event, deletePhNumber, 'sms')"></div> -->
                  					</div>
                  					<#-- <button class="add-new-number-but add-new-btn link-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.ANOTHER.NUMBER" /></button> -->
                				</div>
                				<div class="add-new-number add-new-cont">
                  					<div class="add-new-number-desc general-desc add-desc">
                    					<@i18n key="IAM.MFA.ANNOUN.SMS.NEW" />
                  					</div>
                  					<button class="add-new-number-but common-btn s-common-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.CONTACT.MOBILE" /></button>
                				</div>
               					<div class="new-number" style="display: none">
                 					<form name="confirm_form" onsubmit="return false">
                    					<div class="new-number-desc general-desc margin-desc add-desc">
                      						<@i18n key="IAM.MFA.ANNOUN.SMS.INPUT.DESC" />
                    					</div>
                    					<div class="mobile_input_container field" id="select_phonenumber">
                      						<label for="mobile_input" class="emolabel"><@i18n key="IAM.NEW.SIGNIN.MOBILE" /></label>
                      						<label for="countNameAddDiv" class="phone_code_label"></label>
                      						<select
                        						id="countNameAddDiv" data-validate="zform_field"
                        						autocomplete="country-name" name="countrycode"
                        						class="countNameAddDiv" style="width: 300px">
                        						<#list country_list as dialingcode>
                    							<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
                    							</#list>
                      						</select>
                      						<input class="textbox mobile_input" tabindex="0"
                       		 					data-validate="zform_field" autocomplete="phonenumber"
                        						onkeydown="clearError('#mobile_input', event)" name="mobile_no"
                        						id="mobile_input" maxlength="15" data-type="phonenumber" type="tel" oninput="allowSubmit(event)"
                      						/>
                      						<div class="already-added-but link-btn" onclick="selectRecoveryNumbers()" style="display:none">
                        						<@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER" />
                      						</div>
                    					</div>
										<button class="common-btn s-common-btn send_otp_btn" type="submit" onclick="sendSms(event)"><@i18n key="IAM.SEND.VERIFY" /><span></span></button>
                    					<button class="common-btn s-common-btn back-btn" onclick="smsAlreadyStepBack()" style="display:none"><@i18n key="IAM.BACK" /></button>
                  					</form>
                  					<div id="mfa-mob-captcha" class="add-desc"></div>
                  					<div class="already-verified-recovery" style="display:none">
                  						<div class="verified-recovery-desc general-desc margin-desc many add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.ALREADY.REC.MANY" />
                  						</div>
                  						<div class="verified-recovery-desc general-desc margin-desc one add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.ALREADY.REC.ONE" />
                  						</div>
                  						<div class="suggest-recovery-desc general-desc margin-desc add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.SUGGESTION" />
                  						</div>
                  						<div class="already-recovery-desc general-desc margin-desc add-desc" style="display:none">
                  						<@i18n key="IAM.MFA.ANNOUN.SMS.USER.ENTER.REC" />
                  						</div>
                  						<button class="add-new-number-but add-new-btn link-btn" onclick="addNewNumber(event)"><@i18n key="IAM.ADD.CONTACT.MOBILE" /></button>
                  					</div>
                					<form name="verify_sms_form" onsubmit="submitForm(event); return false" style="display: none">
                    					<div class="otp-sent-desc general-desc margin-desc add-desc">
                      						<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE" />
                      						<span class="mobileval">
                        						<div class="valuemobile"></div>
                        						<span class="edit_option" onclick="editNumber()"><@i18n key="IAM.EDIT" /></span>
                      						</span>
                    					</div>
                    					<div class="otp_input_container">
                      						<label for="otp_input" class="emolabel"><@i18n key="IAM.TFA.ENTER.VERIFICATION.CODE" /></label>
                      						<div id="otp_split_input" class="otp_container"></div>
											<div class="resend_otp" onclick="resendSms(event)"><span></span><@i18n key="IAM.TFA.RESEND.CODE" /></div>
											<button class="common-btn s-common-btn leftZero verify-btn" onclick="verifySmsOtp(event)"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></button>
                   						</div>
                  					</form>
                				</div>
              				</div>
            			</div>
          			</div>
					</#if>
					<button class="show-all-modes-but link-btn" style="display: none" onclick="showModes()"><@i18n key="IAM.PFA.ANNOUN.SHOW.MANY" /></button>
				</div>
			<#--	<button class="common-btn enable-mfa" disabled="disabled" style="margin:30px 0px;display:none" onclick="enableMFA(event)"><span></span>
				<div class="enabled-configure" style="display:none">
				<@i18n key="IAM.CONFIGURE" />
				</div>
				<div class="nomodes-enable" style="display:none">
				<@i18n key="IAM.MFA.ENABLE.MFA" />
				</div>
				</button> -->
				<button class="common-btn pfa-continue" style="margin:30px 0px;display:none" onclick="contSignin(event)"><span></span>
				
				<@i18n key="IAM.CONTINUE" />
				
				</button>
			</div>
      		<div class="illustration-container">
        		<div class="illustration_pfa"></div>
			</div>
		</div>

		<div id="password_redir" style="display:none">
			<div style="font-size:14px;line-height:20px;"><@i18n key="IAM.PFA.ANNOUN.PASSWORD.SUCCESS.DESC" /></div>
			<button class="common-btn" onclick="window.location.href = next;"><@i18n key="IAM.CONTINUE" /></button>
		</div>
        <link rel="stylesheet" href="${SCL.getStaticFilePath("/accounts/css/flagStyle.css")}" type="text/css"/>
		</body>
		<script>
			window.onload=function() {
				setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500);
	    		alreadyConfiguredModes = Object.keys(confData);
	    		URI.options.contextpath="${za.contextpath}/webclient/v1";//No I18N
				URI.options.csrfParam = "${za.csrf_paramName}";
				URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
				nModes = $(".mode-cont").length;
				<#if TOTP??>
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
      		
				if(confData && Object.keys(confData).length){
      				$(".pfa-continue").show();
      			}
      			if(nModes === 1){
      				$(".enforce_mfa_desc.many").hide()
      				$(".enforce_mfa_desc.one .nomodes-enable").text(Util.format(I18N.get("IAM.PFA.ANNOUN.DESC.ONE"), $(".mode-header-texts").text()));
      				$(".enforce_mfa_desc.one").show()
      				$(".mode-header").click();
      			}
      			if(nModes === 2){
      				$(".show-all-modes-but").html(I18N.get("IAM.PFA.ANNOUN.SHOW.2"));
      			}
      		$(".container").show();

				if(alreadyConfiguredModes != undefined && alreadyConfiguredModes.length > 0 ){
					for(var i = 0; i<alreadyConfiguredModes.length; i++){
						displayAlreadyConfigured(alreadyConfiguredModes[i], confData[alreadyConfiguredModes[i]]);
					}
				} 
			}
			document.querySelector(".modes-container").addEventListener("click", checkEnable);
		</script>
	</html>
</#if>