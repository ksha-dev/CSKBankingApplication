				
<!--	#Mobile UI FOR DEVICES AND OTP MODE	-->			
				
					<div class="hide popup" tabindex="1" id="tfaphone_mobile_ui">
					    <div class="popup_header popup_header_for_mob">
							<div class="popuphead_details">
							</div>
						    <div class="close_btn" onclick="close_MFA_mobile_specific()"></div>
					    </div>
					    <div class="mob_popu_btn_container">
					        <button class id="btn_to_chng_primary" ><span class="icon-makeprimary"></span><span><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></span></button>
					        <button id="btn_to_delete" ><span class="icon-delete"></span><span><@i18n key="IAM.REMOVE" /></span></button>
					    </div>
					    <div class="option_container">
					    	<div class="mob_popuphead_define">
					    		
					    	</div>
					    	<div class="option_button">
						        <button id="action_granted"><@i18n key="IAM.CONTINUE"/></button>
						        <button id="" onclick="close_MFA_mobile_specific()"><@i18n key="IAM.CANCEL" /></button>
					    	</div>
					    </div>
					</div>	
				
			
<!--	#Mobile Number MFA		-->
			
				<div id="empty_MFAphone_format" class="hide">
					
					<div class="mfa_field_mobile secondary" id="mfa_phoneDetails">
						
						<span class="mobile_dp icon-call"></span>   
						<span class="mobile_info">
							<div class="emailaddress_text"></div>
							<div class="emailaddress_addredtime" id="mfa_ph_time"></div>
							<div class="pri_sec_indicator">
								<div class="pri_indicator"><@i18n key="IAM.MFA.PRIMARY"/></div>
								<!-- <div class="sec_indicator"><@i18n key="IAM.MFA.SECONDARY"/></div> -->
							</div>
						</span>
						<div class="phnum_hover_show" id="mfa_ph_over">   
							<span class="action_icons_div_ph">				
								<span class="action_icon icon-makeprimary" id="icon-primary" onclick="<@i18n key="IAM.MYEMAIL.MAKE.PRIMARY"/>"><span class="set_as_tag"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></span></span>								
								<span class="action_icon icon-delete" id="icon-delete" title="<@i18n key="IAM.DELETE"/>" onclick="<@i18n key="IAM.CONFIRM.POPUP.DELETE.SECURITY.KEY"/>"></span>
							
							</span>
						</div>
					</div>
				
				</div>
				
				
				<div class="box_info hide" id="sms_mode_head">
					<div class="box_discrption mob_hide"><@i18n key="IAM.SETUP.TFA.MOBILE.DESC" /> </div>
					<div class="box_verify_discrption"><@i18n key="IAM.NEW.SIGNIN.OTP.SENT" /> </div>
					
					<input type="hidden" id="enc_mob"/>
					<input type="hidden" id="newmobile"/>
					<input type="hidden" id="countrycode"/>
				</div>
				
				<div class="hide" id="mfa_sms_mode_popups">
					
					<div class="tfa_blur"></div>
					<div class="loader"></div>	
					
					<form class="tfa_setup_work_space" id="sms_setup" onsubmit="return false;">
						<div class="field" id="enter_num_tfa_space">
							<label class="textbox_label"><@i18n key="IAM.NEW.SIGNIN.MOBILE" /></label>
							<div class="select_text">
								<label for="tfa_numbers_code" class="phone_code_label"></label>
								<select id="tfa_numbers_code">
									<#list country_code as dialingcode>
	                          			<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>                          			
	                           		</#list>
								</select>
								<input class="textbox" id="tfa_number_input" onkeypress="remove_error()" maxlength="15" data-type="phonenumber" type="tel" >
							</div>
	
	
						</div>
						<div class="sms_warn"><span class="icon-MFA tfa_warnicon"></span><@i18n key="IAM.SMS.TEXT.WARN" /> </div>
						<div id="set_verified_num_cta" onclick="show_mfa_phn_numbers('sms_setup', 'set_verified_num', tfa_sms_setup_add_desc);" class="note_text blue_link"><@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER" /></div>
						
				   		<button tabindex="0" class="primary_btn_check " onclick="add_mfa_Mobile()" ><span><@i18n key="IAM.NEXT" /> </span></button>

					</form>
					
					
					<div id="add-mobile-captcha"></div>
					<form id="set_verified_num" onsubmit="return false;" class="hide">
						<div class="field full noindent" id="set_select_verified_number">
	                  		<label class="textbox_label"><@i18n key="IAM.VERIFIED.MOBILE.NUMBER" />  </label>
							<label class="phone_code_label" for="countNameAddDiv"></label>
			              	<select class="profile_mode" id="set_verfied_phnnum" data-validate="zform_field" name="verified_nums">
			                </select>
						</div>
						<div class="sms_warn"><span class="icon-MFA tfa_warnicon"></span><@i18n key="IAM.SMS.VERIFIED.NUMBER.TEXT.WARN" /> </div>
						<div onclick="show_mfa_phn_numbers('set_verified_num','sms_setup', tfa_sms_setup_desc);" class="note_text blue_link"><@i18n key="IAM.MFA.ADD.NEW.MOBILE.NUMBER" /></div>
						<div class="tfa_verify_butt" >					  
			  	  			<button class="primary_btn_check " tabindex="0" onclick="verified_num_mfa('set_verified_num','set_verfied_phnnum','setup');" ><span><@i18n key="IAM.ADD" /> </span></button>
		    			</div>
					</form>
					
				</div>
				
				

						


<!--	#Authenticator APP		-->
				<#if canSetup_mfa_device?has_content>
				<div class="box_info hide" id="authenticator_oneauth">
					<div class="box_head"><@i18n key="IAM.USE.ONEAUTH.DOWNLOAD.HEADING" /></div>
					<div class="box_discrption mob_hide">
						<div id="authen-oneauth-download">
							<div class="authenticator-oneauth-download">
								<div class="authenticator-oneauth"  onclick="storeRedirect('<@i18n key="IAM.ONEAUTH.WEBSITE.LINK" />')">
									<div class="product-icon-oneauth3 one_auth_icon">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
										<span class="path7"></span>
									</div>
									<div class="authenticator-desc">
										<h4><@i18n key="IAM.USE.AUTH.APP.SETUP.HEADING" /></h4>
										<p><@i18n key="IAM.USE.AUTH.APP.SETUP.DESCRIPTION" /></p>
									</div>
								</div>
								<div  class="oneauth-d-options">
									<#if (isZohoCN)>
										<div class="download mistore-icon" onclick="storeRedirect('https://zurl.to/ac_totp_oamistore')"></div>							
									<#else>
										<div class="download playstore-icon" onclick="storeRedirect('https://zurl.to/ac_totp_oaandroid')"></div>
									</#if>	
									<div class="download appstore-icon" onclick="storeRedirect('https://zurl.to/ac_totp_oaappstore')"></div>
									<div class="download macstore-icon" onclick="storeRedirect('https://zurl.to/ac_totp_oamac')"></div>
									<div class="download microsoftstore-icon" onclick="storeRedirect('https://zurl.to/ac_totp_oamsstore')"></div>						
								</div>
								<div class="qr_enclosure">	
									<div class="scanqr">
										<div class="qr_corner_box" style="border-width: 3px 0px 0px 3px;"></div>
										<div class="qr_corner_box" style="border-width: 3px 3px 0px 0px; right: 0px;"></div>
										<div class="qr-image" style="background-image: url('/v2/components/images/ac_totp_oascanqr.png');"></div>
										<div class="qr_corner_box" style="border-width: 0px 3px 3px 0px; right: 0px; bottom: 0px;"></div>
										<div class="qr_corner_box" style="border-width: 0px 0px 3px 3px; bottom: 0px;"></div>
									</div>
									<div class="scan-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
								</div>
							</div>
						<div class="authenticator-oneauth-notes"><@i18n key="IAM.USE.ONEAUTH.DOWNLOAD.DESCRIPTION" /></div>
		  	  				<a class="primary_btn_check oneauth_totp_set" onclick="inititate_auth_setup(true)" ><span><@i18n key="IAM.NEXT" /> </span></a>
							<a tabindex="0" class="primary_btn_check high_cancel" onclick="inititate_auth_setup();"><span><@i18n key="IAM.BACK" /></span></a>
						</div>
					</div>
				</div>
				</#if>
				
				<div class="box_info hide" id="auth_mode_head">
					<div class="box_head"><@i18n key="IAM.USE.AUTH.APP" /> </div>
					<div class="box_discrption mob_hide">
					<#if canSetup_mfa_device?has_content>
						<div class="authenticator-oneauth with-bg"   onclick="storeRedirect('<@i18n key="IAM.ONEAUTH.WEBSITE.LINK" />')">
							<div class="product-icon-oneauth3 one_auth_icon">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
								<span class="path7"></span>
							</div>
							<div class="authenticator-desc">
								<h4><@i18n key="IAM.USE.AUTH.APP.SETUP.HEADING" /></h4>
								<p><@i18n key="IAM.USE.AUTH.APP.SETUP.DESCRIPTION" /></p>
							</div>
							<div class="setup_now"><span id="oa_setup_now" onclick="showNextStep(event)"><@i18n key="IAM.BTNMSG.SETUP.NOW"/></span></div>
						</div>
					</#if>
					</div>
					<div class="authen-oneauth-step">
						<div id="authen-oneauth-step">
							<h4><@i18n key="IAM.USE.ONEAUTH.STEP.HEADING"/></h4>
							<ol>
								<li><@i18n key="IAM.USE.ONEAUTH.STEP1"/></li>
								<li><@i18n key="IAM.USE.ONEAUTH.STEP2"/></li>
								<li><@i18n key="IAM.USE.ONEAUTH.STEP3"/></li>
								<li><@i18n key="IAM.USE.ONEAUTH.STEP4"/></li>
							</ol>
						</div>
					</div>
					
				</div>
				
				<div class="box_info hide" id="auth_mode_downloads">
					<div class="box_head"><@i18n key="IAM.DOWNLOAD.AUTHENTICATOR" /></span></div>
					<div class="box_discrption mob_hide"><@i18n key="IAM.DOWNLOAD.AUTHENTICATOR.DESC" /> </div>
				</div>
				
				<div class="hide" id="mfa_auth_mode_popups">
				
					<div class="tfa_setup_work_space <#if !(canSetup_mfa_device?has_content)>mtop_auth_pop</#if>">
							
						<div class="key_qr_space">
							<div id="tfa_qr_space" class="tfa_qr_space">
								<img id="gauthimg" class="qr_tfa" alt="barcode image" />
							</div>
							<div class="or-text hide"><@i18n key="IAM.OR" /></div>
							<div class="qr_key_box" onclick="copyQrKey(this)" onmouseleave="resetTooltipText(this)">
								<div class="qr_key_head"><@i18n key="IAM.MANUAL.ENTRY" />  </div>
								<div class="tooltip-container">
									<div class="tfa_info_text" id="skey"></div>
									<div class="tooltip-text"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></div>
								</div>
								<div class="qr_key_note"><@i18n key="IAM.TFA.TOTP.SPACE.TIP" /> </div>
							</div>
						</div>
						<div class="authenticator-oneauth-notes"><@i18n key="IAM.USE.AUTH.APP.SETUP.INFO" /></div>
			   			<!-- <div class="note_text"><@i18n key="IAM.USE.AUTH.APP.SETUP.NOTE" /> </div>  -->
						<div>
							<button class="primary_btn_check "id="auth_app_confirm" tabindex="0" onclick="verify_auth_qr();" ><span><@i18n key="IAM.NEXT" /> </span></button>
							<button tabindex="0" id="oneauth-step-cancel" class="primary_btn_check high_cancel hide" onclick="showNextStep();"><span><@i18n key="IAM.BACK" /></span></button>
	    				</div>
			  	  		<div class="tfa_goto_other hide">
			   				<span><@i18n key="IAM.NOT.HAVE.APP" /> </span> 
			   				<span class="blue_link" onclick="download_options();"><@i18n key="IAM.DOWNLOAD.APP" />  </span>
			   			</div>
		    			
					</div>
					
				</div>
				
				<div class="hide" id="mfa_auth_downloads_popups">
				
					<div class="tfa_setup_work_space">
					
						<div class="tfa_authapp_list">
						
						<#if ((canSetup_mfa_device)?has_content)>
							<div class="tfa_authapp">
								<span class="tfa_auth_logo one_auth"></span>
								<span class="app_text" onclick='window.open(fta_oneauth_link)' ><@i18n key="IAM.ZONE.ONEAUTH" /> (<@i18n key="IAM.RECOMMENDED" />)</span>
							</div>
						</#if>
							
							<div class="tfa_authapp">
								<span class="tfa_auth_logo google_auth"></span>
								<span class="app_text" onclick='window.open("${googleAuthenticator_link}")'><@i18n key="IAM.GOOGLE.AUTHENTICATOR" /> </span>
							</div>
						</div>
						<a tabindex="0" class="primary_btn_check high_cancel" onclick="inititate_auth_setup();"><span><@i18n key="IAM.BACK" /></span></a>
					</div>
					
				</div>



<!--	#EXO STAR APP		-->


			<div class="box_info hide" id="exostar_mode_downloads">
				<div class="box_head"><@i18n key="IAM.CONFIG.EXOSTAR" /></span> </div>
				<div class="box_discrption mob_hide"><@i18n key="IAM.TFA.EXOAUTH.DESCRIPTION" /> </div>
				
				<input type="hidden" id="exo_type"/>
			</div>
			
			<div class="hide" id="mfa_exostar_mode_popups">
				
					<div class="radiobtn_div">
						<input class="real_radiobtn photo_radio" type="radio" name="exomodepref1" id="hardmodepref" value="hard" checked="checked">
						<div class="outer_circle">
							<div class="inner_circle"></div>
						</div>
						<label for="hardmodepref" class="radiobtn_text tfa_radio_text"><@i18n key="IAM.TFA.EXOAUTH.HARD" /> </label>
					</div>
					<div class="tfa_radio_desc" onclick="slect_option(this)"><@i18n key="IAM.TFA.EXOAUTH.OPTION.DESCRIPTION" /> </div>
					
					<div class="radiobtn_div">
						<input class="real_radiobtn photo_radio" type="radio" name="exomodepref1" id="softmodepref" value="soft" >
						<div class="outer_circle">
							<div class="inner_circle"></div>						
						</div>
						<label for="softmodepref" class="radiobtn_text tfa_radio_text"><@i18n key="IAM.TFA.EXOAUTH.SOFT" /> </label>
					</div>
					<div class="tfa_radio_desc" onclick="slect_option(this)"><@i18n key="IAM.TFA.EXOAUTH.MSG4" /> </div>
					
	  	  			<a class="primary_btn_check " onclick="showExoAuthVerify_popup()" ><span><@i18n key="IAM.NEXT" /> </span></a>
				
			</div>



<!--	# Yubikey Settings	-->


	
	<div class="hide" id="mfa_yubikey_mode_popups">
	
		
		<div id="first_step" class="yubikey_content">
		
			<div class="popup_head center_text"><@i18n key="IAM.MFA.YUBIKEY.HEAD.SETUP" /> </div>
			<div class="close_btn centre_cross" onclick="close_yubikey_popup();"></div>
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
				
				<div class="yuikey_head"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD.FOR.MOBILE" /></div>
				<div class="yuikey_description" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
				
		  		<button class="primary_btn_check " id="yubikey_start_butt" tabindex="0" onclick="show_yubikey_configure()"><span><@i18n key="IAM.NEXT" /> </span></button>
			</div>
			<div class="for_web_setup">
				<div id="yubikey_pic" class="yubikey_pic"></div>
			
				<div class="yuikey_head"><@i18n key="IAM.MFA.YUBIKEY.INSERT.HEAD" /></div>
				<div class="yuikey_description" ><@i18n key="IAM.MFA.YUBIKEY.INSERT.DESCRIPTION" /></div>
				
				<div class="yubikey_verify_butt">					  
		  			<button class="primary_btn_check " id="yubikey_start_butt" tabindex="0" onclick="show_yubikey_configure()"><span><@i18n key="IAM.NEXT" /> </span></button>
					<button class="primary_btn_check high_cancel" id="yubikey_start_cancel" tabindex="0" onclick="close_yubikey_popup()"><span><@i18n key="IAM.CANCEL" /> </span></button>
				</div>
			</div>
		</div>

		<div id="second_step" class="hide yubikey_content">
		
			<div class="popup_head center_text"><@i18n key="IAM.MFA.YUBIKEY.HEAD.CONFIG" /> </div>
			<div class="close_btn centre_cross" onclick="close_yubikey_popup();"></div>
			
			<div id="yubikey_pic" class="yubikey_pic"></div>
			
			<div class="yuikey_head bold"><@i18n key="IAM.TFA.YUBIKEY.TOUCH" /></div>

			<div class="yubikey_verify_butt">					  
	  			<button class="button_disable yubikeyregis hide" id="ubkey_wait_butt" tabindex="0"><span><@i18n key="IAM.GDPR.DPA.WAITING" />  </span></button>
	  			<button class="primary_btn_check hide yubikeyregis" id="ubkey_tryagain_butt" tabindex="0" onclick="yubikey_register()"><span><@i18n key="IAM.TRY.AGAIN" />  </span></button>
				<button class="primary_btn_check high_cancel" id="yubikey_touch_cancel" tabindex="0" onclick="show_yubikey_step1()"><span><@i18n key="IAM.BACK" />  </span></button>
			</div>
			
		</div>
		
		<div id="third_step" class=" hide yubikey_content">
		
			<div class="popup_head center_text"><@i18n key="IAM.MFA.YUBIKEY.HEAD.NAME" /> </div>
			<div class="close_btn centre_cross" onclick="close_yubikey_popup();"></div>
		
			<form onsubmit="return false;">
				<div class="field full" id="yubikey_name_field">
					<div class="textbox_label" id="yubikey_name_label"><@i18n key="IAM.MFA.YUBIKEY.NAME" /></div>
					<input class="textbox" tabindex="0" autocomplete="off" id="yubikey_name" type="text" onkeypress="remove_yubikeyerror()">
					<div class="yubikey_name_desc"><@i18n key="IAM.YUBIKEY.NAME.DESC" /></div>
				</div>
	
				<div class="yubikey_verify_butt">		 			  
		  			<button class="primary_btn_check " id="yubikey_verfiy_butt" tabindex="0" onclick="configure_yubikey()"><span><@i18n key="IAM.CONFIGURE" />  </span></button>
					<button class="primary_btn_check high_cancel" id="yubikey_verify_cancel" tabindex="0" onclick="show_yubikey_step2();show_yubikey_step1();"><span><@i18n key="IAM.BACK" />  </span></button>
				</div>
			</form>
		</div>
		

		
	</div>	
	
<!--	# passkey Settings	-->

	<div class="box_info hide" id="passkey_mode_head">
		<div class="box_head"><@i18n key="IAM.TFA.USE.PASSKEY" /> </div>
		<span class="box_discrption mob_hide"><@i18n key="IAM.TFA.USE.PASSKEY.SETUP.DESCR" /> </span>
	</div>
	
	<div class="hide" id="mfa_passkey_mode_popups">
		<div class="tfa_setup_work_space passkey_definition">
			<div class="title_with_green_dot"><span class="dot_for_desc"></span><@i18n key="IAM.TFA.PASSKEY.PASSWORDLESS.SIGNIN" /></div>
			<div class="desc_abt_title"><@i18n key="IAM.TFA.PASSKEY.PASSWORDLESS.SIGNIN.DESCR" /></div>
		</div>
		<div class="tfa_setup_work_space passkey_definition">
			<div class="title_with_green_dot"><span class="dot_for_desc"></span><@i18n key="IAM.TFA.PASSKEY.PREFER" /></div>
			<div class="desc_abt_title"><@i18n key="IAM.TFA.PASSKEY.PREFERRED.DESCR" /></div>
		</div>
		<div class="tfa_setup_work_space passkey_definition alert_password_sync_block" id="passkey_Bluetooth_internet">
			<div class="idp_font_icon multi_colour_icon icon-warningfill alert_icon_medium"></div>
			<div class="desc_abt_title font"><@i18n key="IAM.TFA.PASSKEY.BLUETOOTH.AND.INTERNET" /></div>
		</div>
		<form name="passkey_form" onsubmit="return false;">
			<div class="field full" id="passkey_name_field">
				<div class="textbox_label" id=""><@i18n key="IAM.TFA.PASSKEY.CONFIGURATION.NAME" /></div>
				<input class="textbox" tabindex="0" autocomplete="off" onkeypress="removePasskeyError()" id="passkey_name" type="text">
				<div class="passkey_name_desc"><@i18n key="IAM.TFA.PASSKEY.CONFIGURATION.NAME.DESC" /></div>
			</div>
			<button class="primary_btn_check " id="passkey_add" tabindex="0" onclick="show_passkey_configure()"><span><@i18n key="IAM.NEXT" />  </span></button>
		</form>
	</div>
	



<!--	# verification Space for all modes		-->


			<div class="hide" id="mfa_verify_space_popups">
			
				<div class="tfa_blur"></div>
				<div class="loader"></div>	
				
				<form class="tfa_setup_work_space" onsubmit="return false;">
					
					<div class="field otp_field" id="verfiy_code_tfa_space">
							<div class="textbox_label" id="verfiy_code_tfa"><@i18n key="IAM.VERIFY.CODE" /> </div>
							<div class="split_otp_container" id="prefcode"></div>
							<div class="resend_with_block">
								<span class="desc_about_block_otp"></span>
								<div id="tfa_resend" class="otp_resend" onclick="resend_verify_otp(this,true);"><a href="javascript:;"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" /> </a></div>
								<div class="resend_text otp_sent" style="display:none;" id="otp_sent"><@i18n key="IAM.GENERAL.OTP.SENDING" /></div>
							</div>
					</div>
					
					
				
					<div class="tfa_verify_butt" >					  
		  	  			<button class="primary_btn_check " id="tfa_verfiy_butt" tabindex="0"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /> </span></button>
						<button class="primary_btn_check high_cancel" type="button" id="tfa_verify_cancel" tabindex="0"><span><@i18n key="IAM.BACK" /> </span></button>
	    			</div>	
				</form>
				
			</div>
			
			<script>
				var i18MfaSetupKeys = {
					"IAM.MFA.COPY.CLIPBOARD" : '<@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" />',
					"IAM.APP.PASS.COPIED" : '<@i18n key="IAM.APP.PASS.COPIED" />',
					"IAM.TAP.TO.COPY" : '<@i18n key="IAM.TAP.TO.COPY" />'
				};
			</script>

<#include "${location}/utils/captcha-handler.tpl">
