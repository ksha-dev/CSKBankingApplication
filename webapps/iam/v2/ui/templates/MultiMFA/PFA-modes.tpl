 <script type="text/javascript">
	    var i18nPFAKeys = {
	    		"IAM.OTHER.AVAIL.MODES" : '<@i18n key="IAM.OTHER.AVAIL.MODES" />',
		}
</script>
 <div class="box  tfa_status_box" id="pfamodes_space">
	<div class="box_info mfa_header">
		<span class="reduce_width">
			<div class="box_head"><@i18n key="IAM.FIRST.FACTOR.SIGN.MODES" /></div>
			<div class="box_discrption"><@i18n key="IAM.FIRST.FACTOR.DESC" /></div>
		</span>
		<div class="mfa_disabled_lable hide disbaled_indicator"><@i18n key="IAM.GENERAL.DISABLED.BY.ADMIN" /><span class="mfa_indi_tooltip"><@i18n key="IAM.MFA.DISABLED.BY.ADMIN.TOOLTIP" /></span></div>
		<div class="mfa_disabled_lable primary_indicator "><@i18n key="IAM.ENFORCED.ADMIN" /><span class="mfa_indi_tooltip"><@i18n key="IAM.MODES.ENFORCED.ADMIN.DESC" /></span></div>
	</div>
				
				<div id="mfa_options" class="mfa_options">
					
					<!-- One auth mode --> 
					
					<div class="option_grid hide" id="mfa_oneauth_mode">
				
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
				
					<!-- SMS mode -->
				
				<#--	<div class="option_grid" id="mfa_sms_mode">
					
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

					</div> -->

					<!-- Google Auth mode -->

					<div class="option_grid hide" id="pfa_app_auth_mode">
						<div class="option_information" id="pfa_auth_app_info">
							<div class="mode_div">
								<span class="mfa_option_icon totp_icon"></span>
								<span class="mfa_option_head"><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></span>
							</div>
							<div class="mode_desc">
								<div class="mfa_option_define"><@i18n key="IAM.TFA.BANNER.GOOGLE.AUTHENTICATOR.DESCRIPTION" /></div>
								<div class="mfa_setupnow" onclick="inititate_auth_setup(false, true)" id="configure_authmode"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
							</div>
						</div>
						<div class="hide option_preference" id="pfa_auth_mode_preference">
							<div class="mfa_option_head">
								<div class="mfa_option_head_cont"><@i18n key="IAM.GOOGLE.AUTHENTICATOR"/></div>
								<div class="mfa_option_desc hide"></div>
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
								<div class="configure" id="change_configure_Gauthmode" onclick="inititate_auth_setup(false, true)" ><@i18n key="IAM.CHANGE.CONFIGURATION" /></div>
							</div>
						</div>
					</div>


					<!-- Yubikey Auth mode -->
					
					
				<#--	<div class="option_grid" id="mfa_yubikey_mode">
					
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
					
					</div> -->
					
					
					<!-- Passkey Auth mode -->
					
					<div class="option_grid hide" id="mfa_passkey_auth_mode">
					
							<div class="option_information" id="passkey_auth_info">
								<div class="mode_div">
									<span class="mfa_option_icon icon-passkey_fill"></span>
									<span class="mfa_option_head"><@i18n key="IAM.TFA.PASSKEY"/></span>
								</div>
								<div class="mode_desc">
									<div class="mfa_option_define"><@i18n key="IAM.TFA.PASSKEY.DESC" /></div>
									<div class="mfa_setupnow" onclick="inititate_passkey_setup(true)" id="configure_passkey"><@i18n key="IAM.BTNMSG.SETUP.NOW" /></div>
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
										<div class="addnew half" id="add_passkey" onclick="inititate_passkey_setup(true)"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.TFA.PASSKEY"/></span></div>
									</div>
									<div class="tfa_viewmore view_more hide" id="show_passkey_diabled_conf" onclick="show_all_passkey();" ><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
									<div class="tfa_viewmore addnew configure hide" id="configure_passkey_mode" onclick="inititate_passkey_setup(true)"><span><@i18n key="IAM.ADD" /> <@i18n key="IAM.TFA.PASSKEY"/></span></div>
								</div>
							</div>
					
					</div>
					
					<!-- Other Auth modes -->
					
					<div class="option_grid" id="mfa_other_auth_mode">
	
							<div class="option_preferences" id="other_auth_mode_preference">
								<div class="mfa_option_head">
									<div class="mfa_option_head_cont pfa_other_head"><@i18n key="IAM.AVAILABLE.MODES" /></div>
									<#-- <div class="mfa_option_desc">
										<span class="conf_via_mobile hide"><@i18n key="IAM.TFA.PASSKEY.CONFIGURED.VIA.MOBILE"/></span>
										<span class="conf_via_web"><@i18n key="IAM.TFA.PASSKEY.CONFIGURED.VIA.WEB"/></span>
									</div> -->
								</div>
								<div class="mfa_option_deatils">					
									<div class="pfa_other_modes hide" id="email_auth_mode">
										<span class="authmode_dp icon-email"></span>   
										<span class="mode_info">
											<div class="emailaddress_text"><@i18n key="IAM.EMAIL.OTP" /></div>
										</span>
										<button class="pfa_other_manage"><@i18n key="IAM.USER.PROFILE.REVIEW.MANAGE"/></button>
									</div>
									<div class="pfa_other_modes hide" id="mobile_auth_mode">
										<span class="authmode_dp icon-call"></span>   
										<span class="mode_info">
											<div class="emailaddress_text"><@i18n key="IAM.TFA.SMS.HEAD" /></div>
										</span>
										<button class="pfa_other_manage"><@i18n key="IAM.USER.PROFILE.REVIEW.MANAGE"/></button>
									</div>
									<div class="pfa_other_modes hide" id="fed_auth_mode">
										<span class="authmode_dp icon-federated"></span>
										<span class="mode_info">
											<div class="emailaddress_text"><@i18n key="IAM.LINKED.ACCOUNTS" /></div>
										</span>
										<button class="pfa_other_manage"><@i18n key="IAM.USER.PROFILE.REVIEW.MANAGE"/></button>
									</div>
									<div class="pfa_other_modes hide" id="password_auth_mode">
										<span class="authmode_dp icon-mprivacy"></span>   
										<span class="mode_info">
											<div class="emailaddress_text"><@i18n key="IAM.PASSWORD" /></div>
										</span>
										<button class="pfa_other_manage"><@i18n key="IAM.USER.PROFILE.REVIEW.MANAGE"/></button>
									</div>
								</div>
							</div>
					
					</div>
					
					
				</div>
				
				

		</div>
		