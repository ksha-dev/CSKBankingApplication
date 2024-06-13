<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">

<script>
var i18nPasswordKeys = {
				"IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET" : '<@i18n key="IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"/>',
				"IAM.PASSWORD.NOT.SET" : '<@i18n key="IAM.PASSWORD.CHANGE.DEFINITION" />',
				"IAM.PASSWORD.NOT.SET.FOR.IDP"	: '<@i18n key="IAM.PASSWORD.NOT.SET.WHILE.REMOVED.IDP" />',
				"IAM.PASSWORD.NOT.DESC" : '<@i18n key="IAM.PASSWORD.NOT.DESC" />',
				"IAM.PASSWORD.EXPIRY.DAYS" : '<@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG" />',
				"IAM.PASSWORD.EXPIRED" : '<@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG.PASSWORD.EXPIRED" />',
				"IAM.PASSWORD.CHANGE.NORMAL" : '<@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG.PASSWORD.NORMAL" />',
				"IAM.PASSWORD.CHANGE.MEDIUM" : '<@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG.PASSWORD.MEDIUM" />',
				"IAM.PASSWORD.CHANGE.ATTENTION" : '<@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG.PASSWORD.ATTENTION" />',
				"IAM.PASSWORD.RECOMMENDATION.DESC" : '<@i18n key="IAM.PASSWORD.RECOMMENDATION.DESC" />',
				"IAM.PASSWORD.IDPUSER.DESC" : '<@i18n key="IAM.PASSWORD.IDPUSER.DESC" />',
				"IAM.PROFILE.LINKED.ACCOUNT.SETTINGS" : '<@i18n key="IAM.PROFILE.LINKED.ACCOUNT.SETTINGS" />',
				"IAM.PASSWORD.ORG.RESTRICTION.HAVING.PASSWORD" : '<@i18n key="IAM.PASSWORD.ORG.RESTRICTION.HAVING.PASSWORD" />'
		};
		
</script>

	<div class="hide popup" tabindex="1" id="popup_password_change">
		
		<div class="popup_header ">
			<div class="popuphead_details">
				<span class="popuphead_text"></span>
			</div>
			<div class="close_btn" onclick="close_password_change()"></div>
		</div>
		
		<div class="change_pass_cont popup_padding">
			<div class="form_description">
				<span class="popuphead_define"></span>			
			</div>
			<form id=passform name=passform onsubmit="return false;">
			
				<div id="change_password_desc" class="hide">
					<span class="heading"><@i18n key="IAM.PASSWORD" /></span>
					<span class="description"><@i18n key="IAM.PASSWORD.CHANGE.DECRIPTION" /></span>
				</div>
				
				<div id="change_first">	
					<div class="field full" id="curr_password">
						<div class="textbox_label "><@i18n key="IAM.CURRENT.PASS" /></div>
						<input class="textbox" tabindex="1" autocomplete="off" onkeypress="remove_error()" data-validate="zform_field" name="currentPass" type="password">
						<span class="pass_icon icon-hide" onclick="togglePass(this)"></span>
	              		<a class="blue" tabindex="1" onclick="goToForgotPwd();"><@i18n key="IAM.FORGOT.PASSWORD" /></a>
					</div>
					<div class="field full" id="new_password">
						<div class="textbox_label "><@i18n key="IAM.NEW.PASS" /> </div>
						<input class="textbox" tabindex="1" autocomplete="off" id="newPassword" type="password" data-validate="zform_field" name="newPassword">
						<span class="pass_icon icon-hide" onclick="togglePass(this)"></span>
					</div>
					<div class="field full" id="new_repeat_password">
						<div class="textbox_label "><@i18n key="IAM.CONFIRM.PASSWORD" /></div>
						<input class="textbox" tabindex="1" autocomplete="off" onkeypress="remove_error()" name="cpwd" type="password">
						<span class="pass_icon icon-hide" onclick="togglePass(this)"></span>
					</div>
					
					<button  class="primary_btn_check " tabindex="1" onclick="changepassword(document.passform)" id="change_password_call" ><span><@i18n key="IAM.PASSWORD.CHANGE" /></span></button>

				</div>
			</form>
			
			<form id="pass_esc_devices" name="pass_esc_devices" class="hide" onsubmit="return signout_devices(this)">
				<div  id="change_second">
				
				<div id="quit_session_desc" class="hide">
					<span class="heading"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD" /></span>
					<span class="description"><@i18n key="IAM.PASSWORD.QUITSESSIONS.DECRIPTION" /></span>
				</div>
					
					<div class="checkbox_div" id="terminate_web_sess" style="padding:10px;margin-top:10px;">
						<input data-validate="zform_field" id="ter_all" name="clear_web" class="checkbox_check" type="checkbox">
						<span class="checkbox">
							<span class="checkbox_tick"></span>
						</span>
						<label for="ter_all" class="session_label">
							<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
							<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
						</label>
					</div>
					<div class="checkbox_div" id="terminate_mob_apps" style="padding:10px;margin-top:10px;">
						<input data-validate="zform_field" id="ter_mob" name="clear_mobile" class="checkbox_check" onchange="showOneAuthTerminate(this)" type="checkbox">
						<span class="checkbox">
							<span class="checkbox_tick"></span>
						</span>
						<label for="ter_mob" class="session_label big_checkbox_label">
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
					<div class="checkbox_div" id="terminate_api_tok" style="padding:10px;margin-top:10px">
						<input data-validate="zform_field" id="ter_apiToken" name="clear_apiToken" class="checkbox_check" type="checkbox">
						<span class="checkbox">
							<span class="checkbox_tick"></span>
						</span>
						<label for="ter_apiToken" class="session_label big_checkbox_label">
							<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.DELETE.APITOKENS" /></span>
							<span id="terminate_session_web_desc_apitoken" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.REVOKE.CONNECTED.APPS.DESC"/></span>
						</label>
					</div>
				</div>
				<button  class="primary_btn_check "><span><@i18n key="IAM.CONTINUE" /></span></button>
			</form>
		
		</div>
		
	</div>
	
	
	
	
	
	
	<div class="box big_box" id="password_box">
	
			<div class="box_blur"></div>
			<div class="loader"></div>
					
		<div class="box_info password_head" id="password_head">
			<div class="password_name_and_time">
				<div class="box_head"><@i18n key="IAM.PASSWORD" /><span class="icon-info"></span></div>
				<div class="box_discrption" id="no_pp"><@i18n key="IAM.PASSWORD.CHANGE.DEFINITION" /></div>
				<div class="box_discrption hide" id="password_def"><@i18n key="IAM.PASSWORD.CHANGE.DEFINITION" /></div>
				<div class="box_discrption hide" id="NO_password_def"><@i18n key="IAM.PASSWORD.CHANGE.DEFINITION" /></div>
				<div class="box_discrption hide" id="contact_superadmin_def"><@i18n key="IAM.PASSWORD.SAML.AUTHENTICATION" /></div>	
			</div>
			<div class="password_button_and_tip">
				<button class="primary_btn_check center_btn hide" id="passwordbutton"><@i18n key="IAM.PASSWORD.CHANGE" /></span></button>
				<div id="tip_password_reset"></div>	
			</div>
		</div> 		
		
		<div class="box_content_div password_usecases">
			<div class="no_data_text hide password_usecases_content" id="IDP_password" >
				<div class="password_usecases_info"></div>				
			</div>
			<div class="no_data_text hide password_usecases_content" id="contact_superadmin_msg" >
				<div class="idp_font_icon multi_colour_icon"></div>
				<div class="password_usecases_info"><@i18n key="IAM.PASSWORD.CONTACT.ADMIN" /></div>
			</div>
			<div class="no_data_text hide password_usecases_content" id="org_policy_password_change_blocked" >
				<div class="idp_font_icon multi_colour_icon"></div>
				<div class="password_usecases_info"><@i18n key="IAM.PASSWORD.ORG.POLICY.RESTRICT.CHANGE_BLOCKED" /></div>
			</div>
			<div class="no_data_text hide password_usecases_content" id="password_expiration">
				<div class="idp_font_icon multi_colour_icon"></div>
				<div class="password_usecases_info"><@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG" /></div>
			</div>
			<div class="no_data_text hide password_usecases_content" id="password_expired">
				<div class="idp_font_icon multi_colour_icon"></div>
				<div class="password_usecases_info"><@i18n key="IAM.PASSWORD.CHANGE.INFO.ORG.PASSWORD.EXPIRED" /></div>
			</div>
		</div>

	</div>	

		
	
	
	