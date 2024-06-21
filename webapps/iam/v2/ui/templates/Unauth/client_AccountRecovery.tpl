<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
	<head>
		<title><@i18n key="IAM.ACCOUNT.RECOVEY.TITLE" /></title>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<#include "client_recovery_static.tpl">
	</head>
	
	<body>
		<div class="bg_one"></div>
		
		<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
    	<div class="Errormsg"> <span class="error_icon"></span> <span class="error_message"></span> </div>
    	
    	<div class="recovery_container">
    		<div class='loader'></div> 
    		<div class='blur_elem blur'></div>
			
			<div class="recovery_box" id="recovery_flow">
				
				<div class="titlename service_logo">${Encoder.encodeHTML(app_display_name)}</div>
				
				<div class="error_portion">
					<div class="titlename" style="text-align:center">${Encoder.encodeHTML(app_display_name)}</div>
					<div class="error_content">
						<div class="restrict_icon"></div>
						<div class="error_header_container">
    						<div class="error_header error_IN123 error_IN101"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.NOT.EXIST.HEADER"/></div>
    						<div class="error_header error_U401"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER"/></div>
    						<div class="error_header error_U402 error_U403"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.INACTIVE.ACCOUNT.HEADER"/></div>
    						<div class="error_header access_denied"><@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER"/></div>
						</div>
						<div class="error_desc"></div>
						<div class="bottom_option" id="try_again" style="margin:auto;" onclick="backToLookup()"><@i18n key="IAM.TRY.AGAIN"/></div>
					</div>
    			</div>
				
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
    					<span id="headtitle"><@i18n key="IAM.FORGOT.PASSWORD.HEAD"/></span>
    					<div class="head_info"><@i18n key="IAM.FORGOT.PASSWORD.DESCRIPTION" /></div>
					</div>
					
					<div class="fieldcontainer">
							<#include "client_recovery_loginId_form.tpl">
					</div>
    			</div>
    			
    			<div id="lookup_err_div" class="recover_sections hide">
	    			
					<div class="info_head">
					
						<div class="user_info_space user_info" id="recovery_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
				        
						<span id="headtitle"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.SSO.ACCOUNT.HEADER"/></span>
    					<div class="head_info" style="color:#D61212;"><@i18n key="IAM.ACCOUNT.RECOVERY.CUSTOM.AUTH.NOT.ALLOWED"/></div>
					</div>
	    			
	    			
	    		</div>
	    			
    			<div id="terminate_session_div"  class="recover_sections">
					<div class="info_head">
    					<span id="headtitle"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD"/></span>
    					<div class="head_info"><@i18n key="IAM.PASSWORD.QUITSESSIONS.DECRIPTION"/></div>
					</div>
								
					<div class="fieldcontainer">
						<#include "client_recovery_terminate_session_form.tpl">
					</div>
								
					<div class="bottom_line_opt"><div class='bottom_option org_admin_content' id='contact_support' onclick='show_contactsupport()'></div></div>

    			</div>
    			
    			<div id="Last_password_div"  class="recover_sections">
					<div class="info_head">
						<div class="user_info_space user_info" id="recovery_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
						<span id="headtitle"><@i18n key="IAM.FORGOT.PASSWORD.HEAD"/></span>
    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.OLD_PASSWORD.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">
						<#include "client_recovery_last_pwd_form.tpl">
					</div>
					<div class="bottom_line_opt"><div class='bottom_option' id='dont_remember' onclick='initialize_recoveryModes()'><@i18n key="IAM.AC.DONT.REMEMBER"/></div></div>
    			</div>
    			
    			
    			<div id="password_matched_div"  class="recover_sections">
					<div class="info_head">
						<div class="user_info_space user_info" id="recovery_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
						<span id="headtitle"><@i18n key="IAM.AC.PASSWORD.MATCHED"/></span>
    					<div class="head_info"><@i18n key="IAM.AC.PASSWORD.MATCHED.DESC"/></div>
					</div>
					
					<div class="fieldcontainer">
							<button class="btn blue" onclick="last_pwd_redirect('signin')" id="last_pwd_audit" tabindex="2"><span><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT"/></span></button>
					</div>
					
					<div class="bottom_line_opt"><div class='bottom_option' id='continue_pwd_reset' onclick="last_pwd_redirect('fp')"><@i18n key="IAM.AC.CONTINUE.PWD_CHANGE"/></div></div>
    			</div>
    			
    			
    			<div id="username_div"  class="recover_sections">
					<div class="info_head">
						<div class="user_info_space user_info" id="recovery_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
						<span id="headtitle"><@i18n key="IAM.FORGOT.PASSWORD.HEAD"/></span>
    					<div class="head_info"><@i18n key="IAM.AC.SELECT.USERNAME.MOBILE.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">
							<button class="btn blue" id="username_select_action" onclick="call_recusernameScreen()" id="nextbtn" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
					</div>
					
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support org_admin_content hide'  onclick='show_contactsupport()'></div></div>
    			</div>
    			
    			
    			<div id="other_options_div"  class="recover_sections">
					<div class="info_head">
						<div class="user_info_space user_info" id="recovery_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
						<div><span class="icon-backarrow backoption" onclick="show_confirm_username_screen()" id="recovery_usernamescreen_bk"></span>
						<span id="headtitle"><@i18n key="IAM.VERIFY.IDENTITY"/></span></div>
    					<div class="head_info"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">						
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

						<div class="bottom_line_opt"><div class='bottom_option org_admin_content' id='contact_support' onclick='show_contactsupport()'></div></div>
					</div>
				</div>
				
				
				<div id="confirm_otp_div"  class="recover_sections">
					<div class="info_head">
						<div class="user_info_space user_info" id="rec_username_user_info" onclick="change_user()">
			                <span class="menutext"></span>
			                <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
				        </div>
						<div><span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
						<span id="headtitle"><@i18n key="IAM.FORGOT.PASSWORD.HEAD"/></span></div>
    					<div class="head_info"><@i18n key="IAM.AC.CONFIRM.OTP.MOBILE.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">
								<#include "client_recovery_confirm_otp_form.tpl">
						
						<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
						<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support org_admin_content hide'  onclick='show_contactsupport()'></div></div>
					</div>
				</div>
				
				
				<div id="recovery_device_div"  class="recover_sections">
					<div class="info_head">
						<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.DEVICE.HEADING"/></span>
    					<div class="head_info"><@i18n key="IAM.AC.RECOVERY.MODES.DEVICE.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">
						<div class="devices">
							<div class="device_title"><@i18n key="IAM.AC.DEVICENAME"/></div>
							<select class='secondary_devices' id="recovery_device_select" onchange='changeRECOVERYSecDevice(this);'></select>
						</div>
						
						<button class="btn blue hide" id="device_rec_wait" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.WAITING.APPROVAL"/></span></button>
						<button class="btn blue hide" id="device_rec_resend" onclick="changeRECOVERYSecDevice($('#recovery_device_select'))" tabindex="1"><span><@i18n key="IAM.PUSH.RESEND.NOTIFICATION"/></span></button>
						<div class="resend_label">
							<span id="otp_resend" class="resendotp push_resend" ></span>
						</div>
					</div>
					
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_other_options' onclick='show_other_options()'><@i18n key="IAM.AC.VIEW.OPTION"/></div></div>
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support org_admin_content hide'  onclick='show_contactsupport()'></div></div>
				</div>
				
				
				<div id="email_confirm_div"  class="recover_sections">
					<div id="confirm_reocvery_email">
						<div class="info_head">
							<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
	    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"/></span>
	    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION"/></div>
						</div>
						
						<div class="fieldcontainer">
							<#include "client_recovery_email_confirm_form.tpl">
						</div>
					</div>
							
					<div id="select_reocvery_email">
						<div class="info_head">
							<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
	    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.EMAIL.HEADING"/></span>
	    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.EMAIL_ID.DESCRIPTION.MULTI"/></div>
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
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support org_admin_content hide'  onclick='show_contactsupport()'></div></div>
				</div>
				
				
				<div id="mobile_confirm_div"  class="recover_sections">
					<div id="confirm_reocvery_mobile">
						<div class="info_head">
							<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
	    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING"/></span>
	    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION"/></div>
						</div>
						
						<div class="fieldcontainer">
								<#include "client_recovery_mobile_confirm_form.tpl">
							
						</div>
						
					</div>
					
					<div id="select_reocvery_mobile">
						<div class="info_head">
							<span class="icon-backarrow backoption only_two_recmodes" onclick="show_confirm_username_screen()"></span>
	    					<span id="headtitle"><@i18n key="IAM.AC.CHOOSE.OTHER_MODES.MOBILE.HEADING"/></span>
	    					<div class="head_info"><@i18n key="IAM.AC.RECOVER.MOBILE_NUMBER.DESCRIPTION.MULTI"/></div>
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
					<div class="bottom_line_opt"><div class='bottom_option rec_modes_contact_support org_admin_content hide'  onclick='show_contactsupport()'></div></div>
				</div>
				
				<div id="mfa_totp_section"  class="recover_sections">

								<div class="info_head">
									<span id="headtitle"><@i18n key="IAM.AC.MFA.MODES.HEAD"/></span>
									<div class="head_info"><@i18n key="IAM.NEW.SIGNIN.MFA.TOTP.HEADER"/></div>
								</div>

								<div class="fieldcontainer">

									<#include "client_recovery_mfa_totp_form.tpl">

								</div>

								<div class="bottom_line_opt"><div class='bottom_option show_mfa_options' onclick='show_mfa_other_options()'><@i18n key="IAM.AC.MFA.VIEW.OPTION"/></div></div>
								<div class="bottom_line_opt"><div class='bottom_option show_mfa_support_options org_admin_content'onclick='show_contactsupport()'></div></div>

				</div>
				
				<div id="change_password_div"  class="recover_sections">
					<div class="info_head">
    					<span id="headtitle"><@i18n key="IAM.AC.RESTET.PASSWORD.HEADDING"/></span>
    					<div class="head_info"><@i18n key="IAM.AC.RESTET.PASSWORD.DESCRIPTION"/></div>
					</div>
					
					<div class="fieldcontainer">
						<#include "client_recovery_reset_pwd_form.tpl">
					</div>
					
					<div class="bottom_line_opt"><div class='bottom_option org_admin_content' onclick='show_contactsupport()'></div></div>
				</div>
				
				
				<div id="contact_support_div"  class="recover_sections">
					<div id="org_contact_support" class="support_sections">
						<div class="info_head">
							<span class="icon-backarrow backoption support_bk_button" id="support_bk_button"></span>
							<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.ADMIN.TITLE"/></span>
							<div class="head_info"><@i18n key="IAM.AC.CONTACT.ORG.SUPPORT.DESC"/></div>
						</div>
					</div>
					
					<div id="no_recovery_mode_support" class="support_sections">
						<div class="info_head">
							<span id="headtitle"><@i18n key="IAM.NEW.SIGNIN.CONTACT.SUPPORT"/></span>
				    		<div class="head_info">
	    						<div style="margin-bottom:20px"><@i18n key="IAM.AC.CONTACT.SUPPORT.HELP.DESC"/> </div>
	    						<div style="margin-bottom:20px"><@i18n key="IAM.AC.CONTACT.SUPPORT.NO_OPTION.DESC"/></div>
	    						<div class="no_recovery_mode_support_contactid"><@i18n key="IAM.AC.CONTACT.SUPPORT.NO_OPTION.CONTACT" /></div>
	    					</div>
						</div>						
					</div>
					<div id="support_go_bk" onclick="change_user()" class="bottom_line_opt bottom_option hide"><@i18n key="IAM.AC.CONTACT.SUPPORT.GO_BACK"/></div>
					
				</div>
			</div>	
    	</div>
	</body>
</html>