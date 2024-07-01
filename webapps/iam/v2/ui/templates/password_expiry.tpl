
<div class="password_expiry_container">
	<div class="passexpsuccess"></div>
		<div class="signin_head">
			<span id="headtitle"><@i18n key="IAM.NEW.PASSWORD.EXPIRY.HEAD"/></span>
			<div class="pass_name extramargin" id="password_desc"></div>
		</div>
		<div class="textbox_div" id="npassword_container">
				<input id="new_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.NEW.PASSWORD"/>' name="newPassword" type="password" class="textbox" required="" onkeydown="clearCommonError('npassword')" oninput="validateCP();" autocapitalize="off" <#if (SCL.isPasswordAutoCompleteOff() == 'true')>autocomplete="off"<#else>autocomplete="new-password"</#if> autocorrect="off" />
				<span class="icon-hide show_hide_Confpassword" onclick="showHidePassword('#new_password');"></span>
		</div>
		<div class="textbox_div" id="rpassword_container">
				<input id="new_repeat_password" onkeyup="setPassword(event)" placeholder='<@i18n key="IAM.CONFIRM.PASS"/>' name="cpwd" type="password" class="textbox" required="" onkeydown="clearCommonError('rpassword');" oninput="validateCP();" autocapitalize="off" <#if (SCL.isPasswordAutoCompleteOff() == 'true')>autocomplete="off"<#else>autocomplete="new-password"</#if> autocorrect="off" /> 
				<span class="icon-hide show_hide_Confpassword" onclick="showHidePassword('#new_repeat_password');"></span>
				<span class="icon-successTick show_Success"></span>
		</div>
		<button class="btn blue" id="changepassword" onclick="updatePassword();"><span><@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"/></span></button>
	</div>

<div class="terminate_session_container">
    				<div class="signin_head">
							<span id="headtitle"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD"/></span>
							<div class="pass_name extramargin" id="password_desc"><@i18n key="IAM.PASSWORD.QUITSESSIONS.DECRIPTION"/></div>
					</div>
					<form id="terminate_session_form" name="terminate_session_container" onsubmit="return send_terminate_session_request(this);" novalidate>
						<div class="checkbox_div" id="terminate_web_sess" style="padding: 10px;margin-top:10px;" onclick="checkboxEvent()">
							<input id="termin_web" name="signoutfromweb" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_web" class="session_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
								<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="checkbox_div" id="terminate_mob_apps" style="padding: 10px;margin-top:10px" onclick="checkboxEvent();">
							<input id="termin_mob" name="signoutfrommobile" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_mob" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.MOBILE.SESSION" /></span>
								<span id="terminate_session_weband_mobile_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.MOBILE.SESSION.DESC"/></span>
							</label>
						</div>
						<div class="oneAuthLable" onclick="checkboxEvent()">
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
						<div class="checkbox_div" id="terminate_api_tok" style="padding: 10px;margin-top:10px" onclick="checkboxEvent();">
							<input id="termin_api" name="signoutfromapiToken" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="termin_api" class="session_label big_checkbox_label">
								<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.DELETE.APITOKENS" /></span>
								<span id="terminate_session_web_desc_apitoken" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.REVOKE.CONNECTED.APPS.DESC"/></span>
							</label>
						</div>
						<div class="terminate_session_button">
							<button class="btn blue checkbox_mod skipbtn" id="terminate_session_skip" onclick="skipterminate();"><span><@i18n key="IAM.SKIP"/></span></button>
							<button class="btn blue checkbox_mod" id="terminate_session_submit" disabled="true"><span><@i18n key="IAM.CONTINUE"/></span></button>
						</div>
					</form>
    			</div>
    			<div id="success_pcontainer">
					<div class="pptick_icon"></div>
					<div class="ppsuccess_head"><@i18n key="IAM.NEW.PASSWORD.EXPIRY.POLICY.SESSION.TERMINATED"/></div>
					<div class="ppsuccess_desc"><@i18n key="IAM.NEW.PASSWORD.EXPIRY.POLICY.SESSION.TERMINATED.DESC"/></div>
					<button class="ppsuccess_button" onclick="window.location.reload();return false"><@i18n key="IAM.GO.TO.SIGN.IN"/></button>
					<div class="ppsuccess_timer"><@i18n key="IAM.NEW.PASSWORD.EXPIRY.REDIRCT.TO.SIGNIN"/></div>
				</div>
    			