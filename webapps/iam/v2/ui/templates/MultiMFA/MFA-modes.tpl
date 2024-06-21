		 
	<script type="text/javascript">
	    var i18nMFAkeys = {
	    		"IAM.VIEWMORE.NUMBER" : '<@i18n key="IAM.VIEWMORE.NUMBER" />',
				"IAM.VIEWMORE.NUMBERS" : '<@i18n key="IAM.VIEWMORE.NUMBERS" />',
				"IAM.CHANGE.PRIMARY.PASSWORDLESS.WARNING" : '<@i18n key="IAM.CHANGE.PRIMARY.PASSWORDLESS.WARNING" />',
				"IAM.MFA.DEL.PREF.NUMB": '<@i18n key="IAM.MFA.DEL.PREF.NUMB" />',
				"IAM.MFA.DEL.PREF.NUMB.DESC": '<@i18n key="IAM.MFA.DEL.PREF.NUMB.DESC" />',
				"IAM.MFA.DEL.PREF.SUCC.MSG": '<@i18n key="IAM.MFA.DEL.PREF.SUCC.MSG" />',
				"IAM.ZOHO.ONEAUTH.APP": '<@i18n key="IAM.ZOHO.ONEAUTH.APP" />',
				"IAM.MOBILE.OTP.REMAINING.COUNT" : '<@i18n key="IAM.MOBILE.OTP.REMAINING.COUNT" />',
				"IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT" : '<@i18n key="IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT" />',
				"IAM.MOBILE.OTP.MAX.COUNT.REACHED" : '<@i18n key="IAM.MOBILE.OTP.MAX.COUNT.REACHED" />',
				"IAM.PASSKEY.WEBAUTHN.TYPEERROR" : '<@i18n key="IAM.WEBAUTHN.ERROR.TYPE.ERROR" />',
				"IAM.PASSKEY.SUPPORT" : '<@i18n key="IAM.WEBAUTHN.ERROR.HELP.HOWTO" />',
				"IAM.TFA.ADD.MOBILE.NUMBER" : '<@i18n key="IAM.TFA.ADD.MOBILE.NUMBER" />',
				"IAM.TFA.VERIFY.MOBILE.NUMBER" : '<@i18n key="IAM.TFA.VERIFY.MOBILE.NUMBER" />',
				"IAM.GENERAL.USERNAME" : '<@i18n key="IAM.GENERAL.USERNAME" />',
				"IAM.MFA.BACKUPCODE.FILE.TEXT" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.TEXT" />',
				"IAM.MFA.BACKUPCODE.FILE.NOTES" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES" />',
				"IAM.LIST.BACKUPCODES.POINT1" : '<@i18n key="IAM.LIST.BACKUPCODES.POINT1" />',
				"IAM.LIST.BACKUPCODES.POINT3" : '<@i18n key="IAM.LIST.BACKUPCODES.POINT3" />',
				"IAM.MFA.BACKUPCODE.FILE.NOTES3" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES3" />',
				"IAM.MFA.BACKUPCODE.FILE.NOTES4" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES4" />',
				"IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE" />',
				"IAM.GENERATE.ON" : '<@i18n key="IAM.GENERATE.ON" />',
				"IAM.MFA.BACKUPCODE.FILE.HELP.LINK" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.HELP.LINK" />',
				"IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK" arg0="${accountRecoveryHelpLink}"/>',
				"IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK" arg0="${newBackupCodeHelpLink}"/>',
				"IAM.CONFIRM.POPUP.DELETE.MFA.NUMBER" : '<@i18n key="IAM.CONFIRM.POPUP.DELETE.MFA.NUMBER"/>',
				"IAM.CONFIRM.POPUP.DELETE.ONEAUTH" : '<@i18n key="IAM.CONFIRM.POPUP.DELETE.ONEAUTH"/>',
				"IAM.MFA.BACKUPCODE.FILE.TEXT" : '<@i18n key="IAM.MFA.BACKUPCODE.FILE.TEXT"/>',
				"IAM.MFA.BACKUP.CODE.LAST.GENERATED" : '<@i18n key="IAM.MFA.BACKUP.CODE.LAST.GENERATED"/>',
				"IAM.MFA.PASSPHRASE.LAST.CHANGED" : '<@i18n key="IAM.MFA.PASSPHRASE.LAST.CHANGED"/>',
				"IAM.MFA.PASSPHRASE.LAST.SET" : '<@i18n key="IAM.MFA.PASSPHRASE.LAST.SET"/>',
				"IAM.MFA.BACKUP.PASSPHRASE.CHANGE.DESCRIPTION.FOOTER" : '<@i18n key="IAM.MFA.BACKUP.PASSPHRASE.CHANGE.DESCRIPTION.FOOTER"/>',
				"IAM.MFA.BACKUP.PASSPHRASE.SET.DESCRIPTION.FOOTER" : '<@i18n key="IAM.MFA.BACKUP.PASSPHRASE.SET.DESCRIPTION.FOOTER"/>',
				"IAM.MFA.DISABLED.BACKUP.PASSPHRASE.DESCRIPTION.FOOTER" : '<@i18n key="IAM.MFA.DISABLED.BACKUP.PASSPHRASE.DESCRIPTION.FOOTER"/>',
				"IAM.MFA.BACKUP.ONEAUTH.DISABLED.DESCRIPTION.FOOTER" : '<@i18n key="IAM.MFA.BACKUP.ONEAUTH.DISABLED.DESCRIPTION.FOOTER"/>',
				"IAM.MFA.NORECOVERY.WARN.DESCRIPTION" : '<@i18n key="IAM.MFA.NORECOVERY.WARN.DESCRIPTION"/>',
				"IAM.MFA.BACKUP.CODE.DISABLED" : '<@i18n key="IAM.MFA.BACKUP.CODE.DISABLED"/>',
				"IAM.MFA.BACKUP.PASSPHRASE.DESCRIPTION.AFTER.SET" : '<@i18n key="IAM.MFA.BACKUP.PASSPHRASE.DESCRIPTION.AFTER.SET"/>'
				
				
		};	    	    
	</script> 
		 
		 
		 <div class="box  tfa_status_box" id="modes_space">
		 		
				<div class="box_info mfa_header">
					
					<span class="reduce_width">
					<div class="box_head"><@i18n key="IAM.MFA.MODES.TITLE" /></div>
					<div class="box_discrption"><@i18n key="IAM.MULTI.MFA.MODES.DESC" /></div>
					</span>
					<div class="mfa_disabled_lable disbaled_indicator"><@i18n key="IAM.GENERAL.DISABLED.BY.ADMIN" /><span class="mfa_indi_tooltip"><@i18n key="IAM.MFA.DISABLED.BY.ADMIN.TOOLTIP" /></span></div>
					<div class="mfa_disabled_lable primary_indicator "><@i18n key="IAM.GENERAL.ENFORCED.BY.ADMIN" /><span class="mfa_indi_tooltip"><@i18n key="IAM.MFA.ENFORCED.BY.ADMIN.TOOLTIP" /></span></div>
					<div class="toggle_field tfa-main-toggle hide" id="tfa_status">
						<div class="togglebtn_div">
							<input class="real_togglebtn suscription_radio" id="tfa_active" onchange="change_tfa_status();" type="checkbox">
							<div class="togglebase">
								<div class="toggle_circle"></div>							
							</div>
							
						</div>					
					</div>
					
				</div>
				
				<div id="mfa_options" class="mfa_options">
					
					<#if canSetup_mfa_device>
					<!-- One auth mode --> 
					
					<div class="option_grid" id="mfa_oneauth_mode">
				
							<div class="option_information blue_banner" id="oneauth_mode_info">
								<div id="mfa_link_space" class="mfa_link_space">
									<div class="oneauth_fill_and_stroke"></div>
									<div class="oneauth_outline"></div>
									<div class="oneauth_fill"></div>
									<div class="product-icon-oneauth3 one_auth_icon">
										<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span>
									</div>
									<div class="mfa_banner_head"><@i18n key="IAM.ZONE.ONEAUTH" /></div>
									<div class="mfa_banner_define"><@i18n key="IAM.MFA.ONEAUTH.DEFINE"/></div>						
									<div class="mfa_action_div">
										<div class="setup_now"><span onclick="showOneauthPop()"><@i18n key="IAM.BTNMSG.SETUP.NOW"/></span></div>
										<div class="learn_more_link"><span onclick="window.open(mfa_panel_oneauth_link, '_blank');"><@i18n key="IAM.TFA.LEARN.MORE"/></span><div class="learn_more_arrow"><b></b></div></div>
									</div>
								</div>
								<div class="oneauth_phone_img"></div>
							</div>
						
							<div class="hide option_preference" id="oneauth_mode_preference">
							
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont"><@i18n key="IAM.ZONE.ONEAUTH"/></div>
									<div class="mfa_option_desc">
										<span class="passwordless"><@i18n key="IAM.MFA.PASSWORDLESS"/> &#43; </span>
										<span class="mfa_push"><@i18n key="IAM.PUSH.NOTIFICATION"/></span>
										<span class="mfa_totp"><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></span>
										<span class="mfa_qr"><@i18n key="IAM.SCAN.QR"/></span>
									</div>
									<div class="mfa_mode_status_butt">
										<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
										<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
										<div class="secondary_indicator hide" id="one_auth_primary_toggle"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
									</div>
								</div>
							
								<div class="mfa_option_deatils" id="mfa_devices">
									
									<div id="all_tfa_devices">
										<div class="MFAdevice_primary"></div>
										<div class="MFAdevice_BKUP "></div>
									</div>
									<div class="tfa_viewmore view_more hide" id="view_only_devices" onclick="show_all_devices();">
										<span class="moreThenTwo"><@i18n key="IAM.MFA.MORE.DEVICES.BUTTON" /></span>
										<span class="lessThenTwo"><@i18n key="IAM.MFA.MORE.DEVICE.BUTTON" /></span>
									</div>
								</div>
					
							</div>
					
					</div>
					</#if>
				
					<!-- SMS mode -->
				
					<div class="option_grid" id="mfa_sms_mode">
					
							<div class="option_information" id="sms_mode_info">
								<div class="mode_div">
									<span class="mfa_option_icon sms_icon"></span>
									<span class="mfa_option_head"><@i18n key="IAM.TFA.SMS.HEAD"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.USE.MOBILE.DESC" /></div>
									<div class="mfa_setupnow" onclick="inititate_sms_setup(this)" id="goto_sms_mode"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
								</div>
							</div>
							<input type="hidden" id="userChoosedCountry" name="userCountryCode">
							<input type="hidden" id="userPhoneNumber" name="userNumber">
							<div class="hide option_preference" id="sms_mode_preference">
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont"><@i18n key="IAM.TFA.SMS.HEAD"/></div>
									<div class="mfa_option_desc hide"></div>
									<div class="mfa_mode_status_butt">
										<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
										<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
										<div class="secondary_indicator hide" onclick="MFA_changeMODE_confirm('<@i18n key="IAM.MFA.CHANGE.PRIMARY.MODE.TITLE"/>','<@i18n key="IAM.TFA.SMS.HEAD"/>','0')"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
									</div>
								</div>
								
								<div class="mfa_option_deatils" id="mfa_phonenumbers">
									<div id="all_tfa_numbers">
										<div class="MFAnumber_primary"></div>
										<div class="MFAnumber_BKUP "></div>
									</div>
									
									<div id="tfa_phone_add_view_more" class="hide">
										<div class="view_more half" id="view_only_tfa" onclick="show_all_Mfa_phonenumbers()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div> 
										<div class="addnew half" id="add_tfa_phone" onclick="add_Mfa_backup()"><span><@i18n key="IAM.ADDNEW.MOBILE" /></span></div>
									</div>
									<div class="tfa_viewmore addnew hide" id="add_more_backup_num" onclick="add_Mfa_backup();"><span><@i18n key="IAM.ADDNEW.MOBILE" /></span></div>
									<div class="tfa_viewmore view_more hide" id="show_backup_num_diabledMFA" onclick="show_all_Mfa_phonenumbers();"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
								</div>
							</div>
					
					</div>
					
					
					<!-- Google Auth mode -->
					
					<div class="option_grid" id="mfa_app_auth_mode">
					
							<div class="option_information" id="sms_app_auth_info">
								<div class="mode_div">
									<span class="mfa_option_icon totp_icon"></span>
									<span class="mfa_option_head"><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.TFA.BANNER.GOOGLE.AUTHENTICATOR.DESCRIPTION" /></div>
									<div class="mfa_setupnow" onclick="inititate_auth_setup()" id="configure_authmode"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
								</div>
							</div>
						
							<div class="hide option_preference" id="app_auth_mode_preference">
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont"><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></div>
									<div class="mfa_option_desc hide"></div>
									<div class="mfa_mode_status_butt">
										<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
										<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
										<div class="secondary_indicator hide"  onclick="MFA_changeMODE_confirm('<@i18n key="IAM.MFA.CHANGE.PRIMARY.MODE.TITLE"/>','<@i18n key="IAM.GOOGLE.AUTHENTICATOR"/>','1')"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
									</div>
								</div>
								
								<div class="mfa_option_deatils">					

									<div class="mfa_field_mobile" id="mfa_auth_detils">
	
										<span class="mobile_dp icon-phone"></span>   
										<span class="mobile_info">
											<div class="emailaddress_text"><@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" /></div>
											<div class="emailaddress_addredtime"></div>
										</span>
										
										<div class="phnum_hover_show" id="mfa_auth_hover">   
											<span class="action_icons_div_ph">	 			
												<span class="action_icon icon-delete" id="icon-delete" onclick="MFA_delete_confirm('<@i18n key="IAM.CONFIRM.POPUP.DELETE.MFA.MODE"/>','<@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR"/>','1')" title="<@i18n key="IAM.DELETE"/>"</span>
											</span>
										</div>
	
									</div>
									<div class="configure" id="change_configure_Gauthmode" onclick="inititate_auth_setup()" ><@i18n key="IAM.CHANGE.CONFIGURATION" /></div>
								</div>
							</div>
					
					</div>
					
					
					
					<!-- Yubikey Auth mode -->
					
					
					<div class="option_grid" id="mfa_yubikey_mode">
					
							<div class="option_information" id="yubikey_mode_info">
								<div class="mode_div">
									<span class="mfa_option_icon yubikey_icon"></span>
									<span class="mfa_option_head"><@i18n key="IAM.MFA.YUBIKEY"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.TFA.YUBIKEY.DESC" /></div>
									<div class="mfa_setupnow" onclick="inititate_yubikey_setup()" id="goto_yubikey_mode"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
								</div>
							</div>
					
							<div class="hide option_preference" id="yubikey_mode_preference">
								
									<div class="mfa_option_head">
										<div class="mfa_option_head_cont"><@i18n key="IAM.MFA.YUBIKEY"/></div>
										<div class="mfa_option_desc hide"></div>
										<div class="mfa_mode_status_butt">
											<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
											<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
											<div class="secondary_indicator hide"  onclick="MFA_changeMODE_confirm('<@i18n key="IAM.MFA.CHANGE.PRIMARY.MODE.TITLE"/>','<@i18n key="IAM.MFA.YUBIKEY"/>','8')" ><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
										</div>
									</div>
								
								<div class="mfa_option_deatils">
									<div id="mfa_yubikey_detils">
										<div class="MFA_yubiKey_primary"></div>
										<div class="MFA_yubiKey_BKUP "></div>
									</div>
	
									<div id="tfa_Yubikey_view_more" style="padding-top: 10px;padding-bottom: 30px;" class="hide">
										<div class="view_more half" id="view_only_tfa" onclick="show_all_YubiKey()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div> 
										<div class="addnew half" id="add_YubiKey" onclick="inititate_yubikey_setup()"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.MFA.YUBIKEY"/></span></div>
									</div>
									<div class="tfa_viewmore addnew configure hide" id="configure_yubikey_mode" onclick="inititate_yubikey_setup();"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.MFA.YUBIKEY"/></span></div>
								</div>
							</div>
					
					</div>
					
					
					<!-- Passkey Auth mode -->
					
					<div class="option_grid" id="mfa_passkey_auth_mode">
					
							<div class="option_information" id="passkey_auth_info">
								<div class="mode_div">
									<span class="mfa_option_icon icon-passkey_fill"></span>
									<span class="mfa_option_head"><@i18n key="IAM.TFA.PASSKEY"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.TFA.PASSKEY.DESC" /></div>
									<div class="mfa_setupnow" onclick="inititate_passkey_setup()" id="configure_passkey"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
								</div>
							</div>
						
							<div class="hide option_preference" id="appkey_auth_mode_preference">
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont"><@i18n key="IAM.TFA.PASSKEY"/></div>
									<div class="mfa_option_desc">
										<span class="conf_via_mobile hide"><@i18n key="IAM.TFA.PASSKEY.CONFIGURED.VIA.MOBILE"/></span>
										<span class="conf_via_web"><@i18n key="IAM.TFA.PASSKEY.CONFIGURED.VIA.WEB"/></span>
									</div>
									<div class="mfa_mode_status_butt">
										<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
										<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
										<div class="secondary_indicator hide"  onclick="MFA_changeMODE_confirm('<@i18n key="IAM.MFA.CHANGE.PRIMARY.MODE.TITLE"/>','<@i18n key="IAM.GOOGLE.AUTHENTICATOR"/>','1')"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
									</div>
								</div>
								
								<div class="mfa_option_deatils">					

									<div class="mfa_field_mobile hide" id="mfa_auth_detils">
										<span class="mobile_dp icon-passkey_outline"></span>   
										<span class="mobile_info">
											<div class="emailaddress_text"></div>
											<div class="emailaddress_addredtime"></div>
										</span>
										
										<div class="phnum_hover_show" id="mfa_auth_hover">   
											<span class="action_icons_div_ph">				
												<span class="action_icon icon-delete" id="icon-delete" onclick="showDeletePasskeyQuestion('<@i18n key="IAM.CONFIRM.POPUP.DELETE.PASSKEY"/>')" title="<@i18n key="IAM.DELETE"/>"</span>
											</span>
										</div>
									</div>
									<div class="passkey_container">
									</div>
									<div id="passkey_view_more" style="padding-top: 10px;padding-bottom: 30px;" class="hide">
										<div class="view_more half" id="view_only_tfa" onclick="show_all_passkey()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div> 
										<div class="addnew half" id="add_passkey" onclick="inititate_passkey_setup()"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.TFA.PASSKEY"/></span></div>
									</div>
									<div class="tfa_viewmore view_more hide" id="show_passkey_diabled_conf" onclick="show_all_passkey();" ><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
									<div class="tfa_viewmore addnew configure hide" id="configure_passkey_mode" onclick="inititate_passkey_setup()"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.TFA.PASSKEY"/></span></div>
								</div>
							</div>
					
					</div>
					
					<div class="option_grid" id="mfa_exo_mode">
						
							<div class="option_information" id="exo_mode_info">
							
								<div class="mode_div">
									<span class="mfa_option_icon exo_icon"></span>
									<span class="mfa_option_head"><@i18n key="IAM.EXO.AUTHENTICATE"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.TFA.EXOAUTH.DESCRIPTION" /></div>
									<div class="mfa_setupnow" onclick="inititate_exo_setup()" id="goto_exo_mode"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
								</div>
							
							</div>
					
							<div class="hide option_preference" id="exo_mode_preference">
								
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont"><@i18n key="IAM.EXO.AUTHENTICATE"/></div>
									<div class="mfa_option_desc hide"></div>
									<div class="mfa_mode_status_butt">
										<div class="primary_indicator"><@i18n key="IAM.MFA.PRIMARY.MODE" /></div>
										<div class="disbaled_indicator"><@i18n key="IAM.MFA.MODE.DISABLED" /></div>
										<div class="secondary_indicator hide" onclick="MFA_changeMODE_confirm('<@i18n key="IAM.MFA.CHANGE.PRIMARY.MODE.TITLE"/>','<@i18n key="IAM.EXO.AUTHENTICATE"/>','6')"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></div>
									</div>
								</div>
								
								<div class="mfa_option_deatils" id="mfa_exo_detils">
								
									<span class="mfa_option_icon exo_icon"></span>   
									<span class="mobile_info">
										<div class="emailaddress_text"><@i18n key="IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR" /></div>
										<div class="emailaddress_addredtime"></div>
									</span>
									
									<div class="phnum_hover_show" id="mfa_exomode_hover">   
										<span class="action_icons_div_ph">				
											<span class="action_icon icon-delete" id="icon-delete" onclick="MFA_delete_confirm('<@i18n key="IAM.EXO.AUTHENTICATE"/>','6')" title="<@i18n key="IAM.DELETE"/>"</span>
										</span>
									</div>
								
								</div>
								
								<div class="configure" id="configure_exo_mode" onclick="inititate_exo_setup()" ><@i18n key="IAM.CHANGE.CONFIGURATION" /></div>
						
							</div>
					
					</div>
					
					
				</div>
				
				

		</div>
		
		
		
	<!-- temp activate and deactive mfa status -->
		
		<div class="hide popup" id="delete_tfa_popup" tabindex="0">
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text tfa_is_activated hide"><@i18n key="IAM.TFA.DISABLE.TITLE" /> </span>
					<span class="popuphead_text tfa_not_activated hide"><@i18n key="IAM.TFA.REENABLE.HEADING" /> </span>
				</div>
				<div class="close_btn" onclick="close_delete_tfa_popup(false)"></div>
			</div>
			
			<div class="popup_padding">
				<span class="popuphead_define tfa_is_activated hide"><@i18n key="IAM.MFA.DISABLE.TXT" /></span>
				<span class="popuphead_define tfa_not_activated hide"><@i18n key="IAM.TFA.REENABLE.TXT" /> </span>
				<div class="tfa_verify_butt" >
					<button class="primary_btn_check hide" id="tfa_deactivate" onclick="disableTFA()"><span><@i18n key="IAM.TURN.OFF.TFA" /> </span></button>
					<button class="primary_btn_check hide" id="tfa_activate"  onclick="return re_enableTFA()"><span><@i18n key="IAM.TURN.ON.TFA" /> </span></button>				
				</div>
			</div>
		</div>
		
		
		
	<!-- TFA choose new primary -->
	
	<div class="hide popup" tabindex="1" id="CHprimary_NOTICE">
			
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text"><@i18n key="IAM.MFA.DELETE.PRIMARY.HEAD" /> </span>
					<span class="popuphead_define"><@i18n key="IAM.MFA.DELETE.PRIMARY.DESC" /> </span>
				</div>
				<div class="close_btn" onclick="close_tfa_CHprimary_notice()" style="display:none;"></div>
				
				<div class="mfa_select_primary field">
					<select id="mfa_primary_select">
					</select>	
				</div>
				
				<div class="tfa_verify_butt" >					  
	  	  			<button class="primary_btn_check " tabindex="1" onclick="change_new_primary()" ><span><@i18n key="IAM.UPDATE" /> </span></button>
		    	</div>
				
			</div>
		    	
	</div>
			
	<!-- Mfa prefered numb delete -->

	<div class="hide popup" id="mfa_prefnumb_del_popup">
		<div class="delpref_popup">
			<div class="popuphead_desc"></div>
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
		</div>
	</div>
		
		
		<!--tfa add backup number space-->

		<div class="hide popup common_center_popup" tabindex="0" id="add_tfa_backup_popup">
		
			<div class="top_popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text"><@i18n key="IAM.TFA.ADD.MOBILE.NUMBER" /></span>
					<span class="popuphead_define"></span>
				</div>
				<div class="close_btn" onclick="close_add_new_tfa_popup()"></div>
			</div>
			
<!--			<div id="tfa_recover_tobackup" class="hide">
			
				<form name="addbackup">
					<div class="field full noindent" id="select_existing_phone">
                  		<label class="textbox_label"><@i18n key="IAM.PHONE.NUMBER" /> </label>

                  		<select class="select_field" name="verifiedmobilesbackup" id="verifiedmobilesbackup"></select>
                  		
						<span class="blue" tabindex="0" onclick="show_addnewbackup();"><@i18n key="IAM.ADDNEW" /> </span>
					</div>
					
					<div class="tfa_verify_butt" >					  
		  	  			<button class="primary_btn_check " tabindex="0" onclick="addAsBackupNumber();" ><span><@i18n key="IAM.UPDATE" />  </span></button>
						<button class="primary_btn_check high_cancel" tabindex="0" onclick="return close_add_new_tfa_popup()"><span><@i18n key="IAM.CLOSE" /> </span></button>
	    			</div>
	    		</form>
	    		
	    	</div>
-->
	    	<div id="tfa_new_tobackup" class="profile_popup_body hide">
				<form id="newphone" onsubmit="return false;">
				<span class="popuphead_define"><@i18n key="IAM.MFA.ADD.MOBILE.NUMBER" /></span>
					<div class="field full noindent" id="select_phonenumber">
                  		<label class="textbox_label"><@i18n key="IAM.NEW.SIGNIN.MOBILE" />  </label>
						<label class="phone_code_label" for="countNameAddDiv"></label>
                  		<select id="countNameAddDiv" name="countNameAddDiv" class="countNameAddDiv" style="width: 67px;">
                  			<#list country_code as dialingcode>
                          		<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
                           	</#list>
                  		</select>
						
						<input class="textbox" id="mobileno" maxlength="15" data-type="phonenumber" type="tel">
					</div>
					
					<div class="sms_warn"><span class="icon-MFA tfa_warnicon"></span><@i18n key="IAM.SMS.TEXT.WARN" /> </div>
					<div id="verified_num_cta" onclick="show_mfa_phn_numbers('newphone', 'verified_num');" class="note_text blue_link hide"><@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER" /></div>
					<div class="tfa_verify_butt" >					  
		  	  			<button class="primary_btn_check " tabindex="0" onclick="add_tfa_bkup();" ><span><@i18n key="IAM.ADD" /> </span></button>
						<!-- <button class="primary_btn_check high_cancel" tabindex="0" onclick="return close_add_new_tfa_popup()"><span><@i18n key="IAM.CLOSE" /> </span></button> -->
	    			</div>
	    			
				</form>
				
				<form id="verified_num" onsubmit="return false;" class="hide">
				<span class="popuphead_define"><@i18n key="IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER.DESC" /></span>
					<div class="field full noindent" id="select_verified_number">
                  		<label class="textbox_label"><@i18n key="IAM.VERIFIED.MOBILE.NUMBER" />  </label>
						<label class="phone_code_label" for="countNameAddDiv"></label>
		              	<select class="profile_mode" id="verfied_phnnum" data-validate="zform_field" name="verified_nums"> 
		                </select>
					</div>
					<div class="sms_warn"><span class="icon-MFA tfa_warnicon"></span><@i18n key="IAM.SMS.VERIFIED.NUMBER.TEXT.WARN" /> </div>
					<div onclick="show_mfa_phn_numbers('verified_num','newphone');" class="note_text blue_link"><@i18n key="IAM.MFA.ADD.NEW.MOBILE.NUMBER" /></div>
					<div class="tfa_verify_butt" >					  
		  	  			<button class="primary_btn_check " tabindex="0" onclick="verified_num_mfa('verified_num','verfied_phnnum');" ><span><@i18n key="IAM.ADD" /> </span></button>
	    			</div>
				</form>
						
				<form id="confirm_phone" onsubmit="verify_tfa_bkup();return false;">
							
					<div class="tfa_info_text"><@i18n key="IAM.TFA.VERIFY.SMS_MESSAGE" /></div>
					
					<div class="field full otp_field" id="verfiy_code_tfa_bkup_space">
						<div class="textbox_label" id="verfiy_code_tfa"><@i18n key="IAM.VERIFY.CODE" /> </div>
						<div class="split_otp_container" id="vcode"></div>
						<div class="resend_with_block">
							<span class="desc_about_block_otp"></span>
							<div id="tfa_resend" class="resend_link otp_resend" onclick="resend_verify_otp(this,false)"><a href="javascript:;"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" /> </a></div>
							<div class="resend_text otp_sent" style="display:none;" id="otp_sent"><@i18n key="IAM.GENERAL.OTP.SENDING" /></div>
						</div>
					</div>
													
					
					<div class="tfa_verify_butt" >					  
		  	  			<button class="primary_btn_check "><span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /> </span></button>
						<button class="primary_btn_check high_cancel" type="button" onclick="return backToAddMfaNumber()"><span><@i18n key="IAM.BACK" /> </span></button>
	    			</div>
	    			
				</form>
				
			</div>
			
		</div>	
				
				
				
		<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="tfa_phonenumber_web_more">
					
			<div class="box_info">
				<div class="expand_closebtn" onclick="closeview_all_tfanumber_view()"></div>
				
				<div class="hide" id="mfa_show_all_otp">
					<div class="box_head"><@i18n key="IAM.TFA.SMS.HEAD" /></div>
					<div class="box_discrption"><@i18n key="IAM.USE.MOBILE.DESC" /></div>
				</div>
				
				<div class="hide" id="mfa_show_all_oneauth">
					<div class="box_head"><@i18n key="IAM.ZONE.ONEAUTH" /></div>
					<div class="box_discrption"><@i18n key="IAM.TFA.ONEAUTH.DESC" /></div>
				</div>
				
				
			</div>
			
			<div class="viewall_popup_content" id="view_all_tfa_phonenumber" tabindex="1"></div>
					
		</div>
		
		
		<!-- Zoho OneAuth setup popup -->
		
		<div class="oneauth-popup" style="display: none">
				<div class="oneauth-headerandoptions">
					<div class="oneauth-header">
						<div class="oneauth-header-icon"><span class="path1 onelogopop"></span><span class="path2 onelogopop"></span><span class="path3 onelogopop"></span><span class="path4 onelogopop"></span><span class="path5 onelogopop"></span><span class="path6 onelogopop"></span><span class="path7 onelogopop"></span></div>
						<div class="oneauth-header-texts">
							<div class="oneauth-name"><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /></div>
							<div class="oneauth-desc"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div>
						</div>
					</div>
					<div class="oneauth-download-options">
						<div  class="oneauth-d-options">
							<div class="download playstore-icon" onclick="storeRedirect('https://zurl.to/ac_mfa_oaandroid')"></div>
							<div class="download appstore-icon" onclick="storeRedirect('https://zurl.to/ac_mfa_oaappstore')"></div>
							<div class="download macstore-icon" onclick="storeRedirect('https://zurl.to/ac_mfa_oamac')"></div>
							<div class="download microsoftstore-icon" onclick="storeRedirect('https://zurl.to/ac_mfa_msstore')"></div>						
						</div>
					</div>
					<div class="qr_enclosure">	
						<div class="scanqr">
							<div class="qr_corner_box" style="border-width: 3px 0px 0px 3px;"></div>
							<div class="qr_corner_box" style="border-width: 3px 3px 0px 0px; right: 0px;"></div>
							<div class="qr-image"></div>
							<div class="qr_corner_box" style="border-width: 0px 3px 3px 0px; right: 0px; bottom: 0px;"></div>
							<div class="qr_corner_box" style="border-width: 0px 0px 3px 3px; bottom: 0px;"></div>
						</div>
						<div class="scan-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
					</div>
				</div>
				<div class="oneauth-steps">
					<div class="big_oneauth_circle"></div>
					<div class="big_oneauth_outline"></div>
					<div class="small_oneauth_circle"></div>
					<div class="small_oneauth_outline"></div>
					<div class="oneauth-step-header"><@i18n key="IAM.AFTER.INSTALLING.ONEAUTH" /></div>
					<div style="margin-left:10px;">	
						<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP1" /></div>
						<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP2" /></div>
						<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3" /></div>
						<div class="oneauth-step">
							<@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP4" />				
						</div>
					</div>
				<div class="oneauth_footer">
					<@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT" />
					<span onclick="window.open(how_to_sign_in_link, '_blank');" style="color: #0291FF; cursor:pointer;"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK" /></span>
				</div>
				</div>								
			</div>
		
		<div class="msg-popups" style="display: none" tabindex="1" onkeydown="escape(event)">
      			<div class="popup-header">
        			<div class="popup-icon icon-success"></div>
        			<div class="popup-heading"></div>
        			<div class="pop-close-btn" onclick="close_popupscreen()"></div>
      			</div>
      			<div class="popup-body"></div>
      			<div class="pop-close-btn" onclick="close_popupscreen()"></div>
    		</div>
		

						