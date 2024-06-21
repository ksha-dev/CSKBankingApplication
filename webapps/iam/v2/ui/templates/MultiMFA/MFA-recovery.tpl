
		
		<!-- mfa device clear -->
		
		<div class="hide popup" tabindex="1" id="mfa_signout_space">
		
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text"><@i18n key="IAM.PASSWORD.QUITSESSIONS.HEAD" />  </span>
				</div>
				<div class="close_btn" onclick="mfa_session_clear()"></div>
			</div>
			
			<div class="tfa_verify_butt popup_padding" >					  
				<span class="popuphead_define"><@i18n key="IAM.MFA.QUITSESSIONS.DECRIPTION"/></span>

				<form id="mfa_esc_devices" name="mfa_esc_devices" class="" onsubmit="return signout_devices(this,mfa_session_clear)">
					<div  id="change_second">
					<div class="checkbox_div" id="terminate_web_sess" style="padding: 10px;margin:10px 0px 0px 0px;">
						<input data-validate="zform_field" id="ter_all" name="clear_web" class="checkbox_check" type="checkbox">
						<span class="checkbox">
							<span class="checkbox_tick"></span>
						</span>
						<label for="ter_all" class="session_label">
							<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
							<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
						</label>
					</div>
					<div class="checkbox_div" id="terminate_mob_apps" style="padding: 10px;margin:10px 0px 0px 0px;">
						<input data-validate="zform_field" id="ter_mob" name="clear_mobile" onchange="showOneAuthTerminate(this)" class="checkbox_check" type="checkbox">
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
					<div class="checkbox_div" id="terminate_api_tok" style="padding: 10px;margin:10px 0px 0px 0px;">
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
					<button  class="primary_btn_check " ><span><@i18n key="IAM.CONTINUE" /></span></button>
				</form>
				
	    	</div>
			
		</div>
		
		
		
		<!-- TFA Backup Codes Remainder -->
		
		<div class="hide popup" tabindex="1" id="backupcodes_NOTICE">
			
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text"><@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" /> </span>
				</div>
				<#if !isBackupCodeDowloadMandatory><div class="close_btn" onclick="close_tfa_backupcode_NOTICE()"></div></#if>
			</div>
			
			
			<div class="tfa_verify_butt popup_padding" >					  
				<span class="popuphead_define"><@i18n key="IAM.LIST.BACKUPCODES.NOTICE" /> </span>
  	  			<button class="primary_btn_check " tabindex="1" onclick="show_backupcodes()" ><span><@i18n key="IAM.TFA.GENERATE.NEW" /> </span></button>
	    	</div>
	    	
		</div>
			
			
			
		<div class="box" id="recovery_space">
		
			<div class="box_info">
				<span class="reduce_width">
				<div class="box_head"><@i18n key="IAM.MFA.RECOVERY.OPTION" /></div>
				<div class="box_discrption"><@i18n key="IAM.MULTI.MFA.RECOVERY.DESC" /></div>
			</div>

			<div class="mfa_recovery_warning hide">
				<span class="mfa_recovery_icon_warn icon-warningfill"></span>
				<span class="mfa_recovery_warn_description"><@i18n key="IAM.MFA.NORECOVERY.WARN.DESCRIPTION" /></span>
			</div>
			<div class="mfa_recovery_options">	
				<div class="option_grid" id="backup_code_grid">	
					<div id="tfa_bk_new_space" class="hide">
						<div class="mfa_backupcode_main">
							<div class="tfa_sub_head"><@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" /> </div>
							<div class="tfa_sub_head_desc" id="tfa_bk_description" style="margin-bottom: 20px;"><@i18n key="IAM.TFA.BKP.DESCRIPTION" /></div>
							<div class="tfa_sub_head_desc" id="tfa_bk_time" style="color: #EB8135; margin-bottom: 20px;"></div>
							<button class="primary_btn_check circlebtn_mobile_edit " onclick="show_backupcodes()" style="margin-top: auto;"><span><@i18n key="IAM.TFA.GENERATE.NEW" /> </span></button>
						</div>
						<div class="tfa_footer_warning hide"></div>
					</div>
				</div>
				<div class="option_grid" id="mfa_passphrase_grid">
					<div id="mfa_passphrase">
						<div class="mfa_passphrase_main">
							<div class="tfa_sub_head"><@i18n key="IAM.MFA.BACKUP.PASSPHRASE" /> </div>
							<div class="tfa_sub_head_desc" id="mfa_passphrase_description" style="margin-bottom: 20px;"><@i18n key="IAM.MFA.BACKUP.PASSPHRASE.DESCRIPTION" /></div>
							<div class="tfa_sub_head_desc hide" id="mfa_passphrase_time" style="color: #EB8135;"></div>							
							<button class="primary_btn_check circlebtn_mobile_edit hide" onclick="show_passphrase()"><span><@i18n key="IAM.MFA.BACKUP.GENERATE.PASSPHRASE" /> </span></button>
						</div>
						<div class="tfa_footer_warning"></div>
					</div>				
				</div>
			</div>
			
		</div>
		
		
				
	<!--	TFA Backup Codes Space -->
	
		<div class="backup_verficationspace hide popup" tabindex="1" id="backupcodes_tfa">
			
				<div class="popup_header ">
					<div class="popuphead_details">
						<span class="popuphead_text"><@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" /> </span>
					</div>
					<div class="close_btn" onclick="close_tfa_backupcode()" <#if isBackupCodeDowloadMandatory>style="display:none"</#if>></div>
				</div>
				<div class="popup_padding">
					<span class="popuphead_define"><@i18n key="IAM.LIST.BACKUPCODES.DESCRPRITION" /> </span>
					<div id="bkup_code_space" class="tfa_bkup_grid">
						<div id="bk_codes"></div>
						<div id="bkup_cope">
							<span class="backup_but" id="downcodes"><@i18n key="IAM.DOWNLOAD.APP" /> </span>
							<span class="backup_but tooltipbtn" id="printcodesbutton" onmouseout="remove_copy_tooltip();"><@i18n key="IAM.COPY" /> 
								<span class="tooltiptext copy_to_clpbrd"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></span>
								<span class="tooltiptext code_copied hide"><span class="tick-mark"></span><@i18n key="IAM.APP.PASS.COPIED" /> </span>
							</span>
							<span class="bk_code_save hide" onclick="send_email_code();"><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" />  </span>
						</div>
						<span class="cut_position"></span>
					</div>
					
					<div class="hide">
						<span class="tfa_info_text"><@i18n key="IAM.GENERATE.ON" /> </span>
						<span class="tfa_info_text" id="createdtime"></span>
					</div>
					
					<ul class="mfa_points_list">
						<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT1" /> </li>
						<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT2" /> </li>
						<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT3" /> </li>
					</ul>
					
					<div class="tfa_verify_butt hide">					  
		  	  			<button class="primary_btn_check " tabindex="1" onclick="show_backupcodes()" ><span><@i18n key="IAM.TFA.GENERATE.NEW" /> </span></button>
						<button class="primary_btn_check high_cancel" tabindex="1" onclick="close_tfa_backupcode()"><span><@i18n key="IAM.CLOSE" /> </span></button>
			    	</div>
			    </div>
			    <#if isBackupCodeDowloadMandatory>
		    	     <div class="popup_footer_close hide">
		    	     	<button class="primary_btn_check high_cancel" tabindex="1" onclick="close_tfa_backupcode()"><span><@i18n key="IAM.CLOSE" /> </span></button>
			    	 </div>
				   	 <div class="popup_footer">
				    	<div class="popup_close_desc"><@i18n key="IAM.TFA.BACKUPCODES.POPUP.CLOSE" /></div>
				    </div>
			    </#if>
			</div>
			
		<!-- sending email is yet to be decided -->
			
			<form onsubmit="return false;" tabindex="1" class="hide popup" id="send_bkcode_email">
			
				<div class="popup_header ">
					<div class="popuphead_details">
						<span class="popuphead_text"><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" /> </span>
						<span class="popuphead_define">
							<@i18n key="IAM.TFA.RECOVERY.EMAIL.SUBTXT" />
							<@i18n key="IAM.NOTE" />&nbsp;:&nbsp;<@i18n key="IAM.TFA.RECOVERY.EMAIL.WARNING" />
						</span>
					</div>
					<div class="close_btn" onclick="close_send_bkcode_emailpopup()"></div>
				</div>
				
				<div class="field full" id="tfa_email_space"> 
					<div class="textbox_label" id="tfa_confim"><@i18n key="IAM.ENTER.EMAIL" /> </div>
					<input class="textbox" data-optional="true" onkeypress="remove_error()" type="text" id="send_backup_em">
				</div>
				
				<div class="field full" id="tfa_email_space_pass"> 
					<div class="textbox_label" ><@i18n key="IAM.CURRENT.PASS" /></div>
					<input class="textbox" data-optional="true" autocomplete="off" onkeypress="remove_error()" id="send_backup_pass" type="password">
				</div>
				
				<div class="tfa_verify_butt" >					  
	  	  			<button class="primary_btn_check " onclick="sendBackupCodesEmail();" ><span><@i18n key="IAM.TFA.GENERATE.NEW" /> </span></button>
					<button class="primary_btn_check high_cancel" onclick="return close_send_bkcode_emailpopup()"><span><@i18n key="IAM.CLOSE" /> </span></button>
		    	</div>
		    	
			</form>