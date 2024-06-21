<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
		<head>
		<#include "client_signin_static.tpl">

        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <title><@i18n key="IAM.CLIENT.SIGNIN.TITLE"/></title>
        </head>
        <body>
			<div class="bg_one"></div>
			<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
			<div class="Errormsg"> <span class="error_icon"></span> <span class="error_message"></span> </div>
			<div class="signin_container">
				<div class="signin_box" id="signin_flow">
					<div class="titlename">${Encoder.encodeHTML(signin.app_display_name)}</div>
					<div id="signin_div">
						<div class="signin_head alt_signin_head">
			    					<span id="headtitle"><@i18n key="IAM.SIGN_IN"/></span>
			    					<span id="trytitle"></span>
									<div class="service_name"><@i18n key="IAM.NEW.SIGNIN.SERVICE.NAME.TITLE" arg0="${Encoder.encodeHTML(signin.app_display_name)}"/></div>
									<div class="fielderror"></div>
						</div>
						<#include "client_signin_form.tpl">
						<div id="recovery_container">
							<div class="signin_head recoveryhead">
								<table id="recoverytitle"><span class='icon-backarrow backoption' onclick='goBackToProblemSignin()'></span><span class="rec_head_text"><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></span></table>
							</div>
							<div id='recoverymodeContainer'></div>
							<div class='recoverymodes'>
								<div class="options options_hover" id="recoverOption" onclick="showBackupVerificationCode()">
									<div class="img_option icon-backup"></div>
									<div class="option_details">
										<div class="option_title"><@i18n key="IAM.TFA.USE.BACKUP.CODE"/></div>
										<div class="option_description"><@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER"/></div>
									</div>
								</div>
								<div class="options contact_support">
									<div class="img_option icon-support"></div>
									<div class="option_details">
										<div class="option_title"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></div>
										<div class="option_description contactsuprt"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT.DESC" arg0="${signin.supportEmailAddress}"/></div>
									</div>
								</div>
							</div>
							<div class="btn greytext" ></div>
						</div>
						<div id='backup_container'>
							<div class="signin_head backuphead">
								<span id="backup_title"><span class='icon-backarrow backoption' onclick='showCantAccessDevice()'></span><@i18n key="IAM.TFA.USE.BACKUP.CODE"/></span>
								<div class="backup_desc extramargin"><@i18n key="IAM.NEW.SIGNIN.BACKUP.HEADER"/></div>
							</div>
							<div class="textbox_div" id="backupcode_container">
								<input id="backupcode" placeholder='<@i18n key="IAM.BACKUP.VERIFICATION.CODE"/>' type="text" name="backupcode" class="textbox" required="" onkeydown="clearCommonError('backupcode')" onkeyup="submitbackup(event)" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="15"/>
								<div class="fielderror"></div>
								<span class="bluetext_action" id="recovery_passphrase" onclick="changeRecoverOption('passphrase')"><@i18n key="IAM.NEW.SIGNIN.MFA.PASSPHRASE.HEADER"/></span>
							</div>
							<button class="btn blue" onclick="verifyBackupCode()"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
							<div class="btn borderlessbtn back_btn"></div>
						</div>
					</div>
					<div class="nopassword_container">
    				<div class="nopassword_icon icon-hint"></div>
    				<div class="nopassword_message"><@i18n key="IAM.NEW.SIGNIN.NO.PASSWORD.MESSAGE" arg0="goToForgotPassword();"/></div>
    			</div>
					<div class="password_expiry_container">
    				<div class="passexpsuccess"></div>
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED"/></span>
							<div class="pass_name extramargin" id="password_desc"></div>
					</div>
					<div class="textbox_div" id="npassword_container">
							<input id="new_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.NEW.PASSWORD"/>' name="newPassword" type="password" class="textbox" required="" onkeydown="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" />
							<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
							<div class="fielderror"></div>
					</div>
					<div class="textbox_div" id="rpassword_container">
							<input id="new_repeat_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.CONFIRM.PASS"/>' name="cpwd" type="password" class="textbox" required="" onkeydown="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" /> 
					</div>
					<button class="btn blue" id="changepassword" onclick="updatePassword();"><span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"/></span></button>
    			</div>
    			<div class="terminate_session_container">
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD"/></span>
							<div class="pass_name extramargin" id="password_desc"><@i18n key="IAM.PASSWORD.QUITSESSIONS.DECRIPTION"/></div>
					</div>
					<form id="terminate_session_form" name="terminate_session_container" onsubmit="return send_terminate_session_request(this);" novalidate>
						<div class="checkbox_div" id="terminate_web_sess" style="padding: 10px;margin-top:10px;">
							<input id="termin_web" name="signoutfromweb" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_web" class="session_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
								<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="checkbox_div" id="terminate_mob_apps" style="padding: 10px;margin-top:10px;">
							<input id="termin_mob" name="signoutfrommobile" class="checkbox_check" type="checkbox" onchange="showOneAuthTerminate(this)">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_mob" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.MOBILE.SESSION" /></span>
								<span id="terminate_session_weband_mobile_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.MOBILE.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="oneAuthLable">
							<div class="oneauthdiv"> 
								<span class="oneauth_icon one_auth_icon_v2"></span>
								<span class="text_container">
									<div class="text_header"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH" /></div>
									<div class="text_desc"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH.DESC" /></div>
								</span>
								<div class="togglebtn_div include_oneAuth_button">
									<input class="real_togglebtn" id="include_oneauth" type="checkbox">
									<div class="togglebase">
										<div class="toggle_circle"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="checkbox_div" id="terminate_api_tok" style="padding: 10px;margin-top:10px;">
							<input id="termin_api" name="signoutfromapiToken" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_api" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.DELETE.APITOKENS" /></span>
								<span id="terminate_session_web_desc_apitoken" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.REVOKE.CONNECTED.APPS.DESC"/></span>
							</label>
						</div>
						<button class="btn blue checkbox_mod" id="terminate_session_submit"><span><@i18n key="IAM.CONTINUE"/></span></button>
					</form>
    			</div>
					
				<div class="trustbrowser_ui">
					<div class="signin_head">
						<span id="headtitle"><@i18n key="IAM.TFA.TRUST.BROWSER.QUESTION"/></span>
						<div class="service_name mod_sername"></div>
					</div>
					<button class="btn blue trustdevice trustbtn" onclick="updateTrustDevice(true)">
						<span class="loadwithbtn"></span>
						<span class="waittext"><@i18n key="IAM.TRUST"/></span>
					</button>
					<button class="btn grey trustdevice notnowbtn"  onclick="updateTrustDevice(false)">
						<span class="loadwithbtn"></span>
						<span class="waittext"><@i18n key="IAM.NOTNOW"/></span>
					</button>
				</div>
				</div>
			</div>
			<div id="enableCookie" style='display:none;text-align:center'>
	            <div style="text-align: center;padding: 10px;"><@i18n key="IAM.ERROR.COOKIE_DISABLED"/></div>
		    </div>
		    <script>
		    	I18N.load({
							"IAM.ERROR.ENTER.NEW.PASS" : '<@i18n key="IAM.ERROR.ENTER.NEW.PASS" />',
							"IAM.ERROR.WRONG.CONFIRMPASS" : '<@i18n key="IAM.ERROR.WRONG.CONFIRMPASS" />'
						});
				var enableServiceBasedBanner = false;
		    </script>
		</body>
</html>