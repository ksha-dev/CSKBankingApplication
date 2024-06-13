    				
    				
    				
    		<div class="hide" id="popup_user-preference_contents">
				<form  method="post" onsubmit="return false;" novalidate>
					<div id="user_pref_dateformat" class="hide">
						
						<div class="field full noindent tab_inline_div">
    						<div class="field full hide" id="customizeFormat">
		                  		<label class="textbox_label"><@i18n key="IAM.USERPREFERENCE.ENTER.FORMAT" /> </label>
		                  		<input class="textbox" name="custom" oninput="check_disable(this)" id="custom" type="text">
							</div>
						</div>
						
						<div class="field hide full noindent">
							<div class="textbox_label "><@i18n key="IAM.TIME.FORMAT" /></div>
							<select id="hours_type" class="customised_select">
								<option><@i18n key="IAM.USER.PREF.12.HOURS" /> </option>
								<option><@i18n key="IAM.USER.PREF.24.HOURS" /> </option>
							</select>
						</div>
						
					</div>
					
					
						
						
					<div id="user_pref_photoview_permi" class="hide">

						
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ppview" id="3" value="3">

							<div class="outer_circle">
							<div class="inner_circle"></div></div>
							<label class="radiobtn_text" for="3"><@i18n key="IAM.PHOTO.PERMISSION.ZOHO_USERS" /> </label>
						</div>
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ppview" id="2"  value="2">
							<div class="outer_circle"><div class="inner_circle"></div></div>
							<label class="radiobtn_text" for="2"><@i18n key="IAM.PHOTO.PERMISSION.CHAT_CONTACTS" /></label>
						</div>
						
						<#if !isPersonalUser>
							<div class="radiobtn_div" id="org_photo">
								<input class="real_radiobtn photo_radio" type="radio" name="ppview" id="1" value="1">
	
								<div class="outer_circle">
								<div class="inner_circle"></div></div>
								<label class="radiobtn_text" for="1"><@i18n key="IAM.PHOTO.PERMISSION.ORG_USERS" /> </label>
							</div>
						</#if>
						
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ppview" id="4" value="4">
							<div class="outer_circle">
							<div class="inner_circle"></div></div>
							<label class="radiobtn_text" for="4"><@i18n key="IAM.PHOTO.PERMISSION.EVERYONE" /> </label>
						</div>
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ppview" id="0" value="0">
							<div class="outer_circle">
							<div class="inner_circle"></div></div>
							<label class="radiobtn_text" for="0"><@i18n key="IAM.PHOTO.PERMISSION.ONLY_MYSELF" /> </label>
						</div>					
					</div>
					
					
				<#if  is_password_expiry_notification>
					
					<div id="user_pref_notifications" class="hide">	
						
						
										
							<div class="toggle_block_field">
							
								<div class="toggle_block">
									<div class="toggle_head"><@i18n key="IAM.USERPREFERENCE.PASSEXPIRY_NOTIFICATION" /> </div>
									<div class="toggle_desc"><@i18n key="IAM.SETTINGS.PASSWORD.EXPIRY.DESC" /> </div>
								</div>
								
								<div class="togglebtn_div">
									<input class="real_togglebtn" id="password_expiry" type="checkbox">
									<div class="togglebase">
										<div class="toggle_circle"></div>
									</div>
									
								</div>
							</div>	
	
					</div>
				
				</#if>
					
				
				
					<div id="user_pref_subscriptions" class="hide">	

						<div class="toggle_field">
							<label class="toggle_text"><@i18n key="IAM.USERPREFERENCE.GENERAL" /> </label>
						<!--	<div class="togglebtn_div">
								<input class="real_togglebtn suscription_radio" id="news_letter" type="checkbox">
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>
							</div> -->
						</div>
						
						<div id="double_opt" class="hide"><@i18n key="IAM.NOTE.DOUBLE.OPT.IN.NOTIFICATION" /> </div>
				
					</div>
					
					
					
					
					<button class="primary_btn_check " tabindex="0" id="popup_user-preference_action" ><span></span></button>
								
				</form>
				
			</div>
				
    					
    				
    				
    				
    				<div class="box big_box" id="preference_box">
    				
    					<div class="box_blur"></div>
						<div class="loader"></div>
						
						<div class="box_info">
							<div class="box_head"><@i18n key="IAM.USERPREFERENCE" /><span class="icon-info"></span> </div>
							<div class="box_discrption"><@i18n key="IAM.USER.PREFERENCE.DESCRIPTION" /> </div>
						</div>
						

					
					<div class="pref_option field" id="dateformatid">
						<div class="option_desc">
							<div class="option_head"><@i18n key="IAM.USERPREFERENCE.SELECT.FORMAT" /> </div>
							<div class="option_values" id="current_date_format"><@i18n key="IAM.SETTINGS.DATEFORMAT.DESCRIPTION" /></div>
						</div>
						
						<select name="date_format" id="format"  onchange="setFormat()" class="visibleMobilesSelect customised_select">
							<option id="custom_" value="custom"><@i18n key="IAM.USERPREFERENCE.CUSTOM" /></option>
							<#list dateFormats as formats>
								<option value="${formats.format}" id="${formats.format}" >${formats.format} (${formats.example})</option>
                       		</#list>
    					</select>
					</div>
					
					
					<div class="pref_option field" id="ppviewid"> 	
						<div class="option_desc">
							<div class="option_head"><@i18n key="IAM.PROFILE.PICTURE.VISIBILITY" /> </div>
							<div class="option_values" id="photo_view_per"><@i18n key="IAM.SETTINGS.PHOTOVIEW.DESCRIPTION" /></div>
							<div class="option_values hide" id="disabled_photo_view_per"><@i18n key="IAM.USERPREFERENCE.ERROR.PHOTO.PERMISSION.RESTRICTED" /></div>
						</div>
						<div class="disabled_tag">
							<span class="icon-madmin"></span>
							<span style="margin-left:5px"><@i18n key="IAM.RESTRICTED.BY.ADMIN" /></span>
							<span class="disable_tooltip"><@i18n key="IAM.USERPREFERENCE.RESTRICTED.BY.ADMIN" /></span>
						</div>
						<select name="photo_permisn" id="user_pref_photoview_permi" class="visibleMobilesSelect customised_select" onchange=new_save_photoview_permi(this.value) size="medium"> 
							<option value="3" id="3"><@i18n key="IAM.PHOTO.PERMISSION.ZOHO_USERS" /></option>
							<option value="2" id="2"><@i18n key="IAM.PHOTO.PERMISSION.CHAT_CONTACTS" /></option>
							<#if !isPersonalUser>
								<option value="1" id="1"><@i18n key="IAM.PHOTO.PERMISSION.ORG_USERS" /></option>
							</#if>
							<option value="4" id="4"><@i18n key="IAM.PHOTO.PERMISSION.EVERYONE" /></option>
							<option value="0" id="0"><@i18n key="IAM.PHOTO.PERMISSION.ONLY_MYSELF" /></option>
	                	</select>
					</div>
					
					<div class="pref_box" id="email_notification">
						<div class="option_desc">
							<div class="option_head option_head_light"><@i18n key="IAM.SETTINGS.EMAIL.NOTIFICATION.TITLE" /> </div>
						</div>
		
						
		<!-- PASSWORD EXPIRY NOTIFICATION -->
	<#if is_password_expiry_notification >
				<div class="pref_option pref_email_option" id="notificationid">
					<div class="toggle_field">
							<div class="toggle_text toggle_text_email"><@i18n key="IAM.SETTINGS.NOTIFICATION.HEADDING" /> </div>
							<div class="togglebtn_div cc">
								<input class="real_togglebtn" id="password_notification" type="checkbox" onclick="new_showuser_pref_notifications('password_notification');">
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>
								
							</div>
							<div class="option_values pref_email_notif_desc" id="notification_value"><@i18n key="IAM.SETTINGS.PASSWORD.EXPIRATION.DESC" /></div>
					</div>
					</div>
		</#if>
					
					
		<!-- SUSPICIOUS / NEW SIGNIN ALERT  -->
					<div class="pref_option pref_email_option" id="user_signin_notifications">
						<div class="toggle_field">
							<div class="toggle_text toggle_text_email"><@i18n key="IAM.SETTINGS.NOTIFICATIONS.TITLE.SIGNIN" /> </div>
							<div class="togglebtn_div cc">
								<input class="real_togglebtn" id="sign_in_notification" type="checkbox" onclick="new_signin_alert_notifications('sign_in_notification');">
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>
							</div>
							
							<div class="profile_tags pref_enforced_tag_box  hide">
									<span class="menuicon icon-madmin pref_enforced_admin_icon"></span>
									<span class="pref_enforced_text"><@i18n key="IAM.SETTINGS.USERPREFERENCE.ENFORCED.BY.ADMIN" /></span>
									<span class="tooltiptext">
										<span class="pref_tags_tooltip_desc"><@i18n key="IAM.SETTINGS.PREFERENCE.SUSPICIOUS.ALERT.TOOLTIP" /></span>
									</span>
							</div>
							
							
							<div class="option_values pref_email_notif_desc"><@i18n key="IAM.SETTINGS.NOTIFICATIONS.TITLE.SIGNIN_DESCRIPTION" /></div>
						</div>
					</div>	


	
		<!-- THIRD PARTY ACCESS / MAIL CLIENT-->				
					<div class="pref_option pref_email_option" id="third_party_access_notifications">
						<div class="toggle_field">
							<div class="toggle_text toggle_text_email"><@i18n key="IAM.SETTINGS.THIRD.PARTY.ALERT.HEADING" /> </div>
							<div class="togglebtn_div cc">
								<input class="real_togglebtn" id="tparty_access_notification" type="checkbox" onclick="new_third_pty_access_notifications('tparty_access_notification')">
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>
							</div>
							
							<div class="profile_tags pref_enforced_tag_box  hide">
									<span class="menuicon icon-madmin pref_enforced_admin_icon"></span>
									<span class="pref_enforced_text"><@i18n key="IAM.SETTINGS.USERPREFERENCE.ENFORCED.BY.ADMIN" /></span>
									<span class="tooltiptext">
										<span class="pref_tags_tooltip_desc"><@i18n key="IAM.SETTINGS.PREFERENCE.MAIL.CLIENT.ALERT.TOOLTIP" /></span>
									</span>
							</div>
							
							
							<div class="option_values pref_email_notif_desc"><@i18n key="IAM.SETTINGS.THIRD.PARTY.ALERT.DESC" /></div>
						</div>
					</div>	
					
			
			
		<!-- NEWS LETTER SUBSCRIPTION -->
					<div class="pref_option pref_email_option" id="subscriptionsid">
					<div class="toggle_field">
							<div class="toggle_text toggle_text_email"><@i18n key="IAM.USERPREFERENCE.NEWSLETTER.SUBSCRIBE" /> </div>
							<div class="togglebtn_div cc">
								<input class="real_togglebtn" id="news_letter" type="checkbox" onclick="new_save_subscription_changes('news_letter');">
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>
								
							</div>
							<#assign corp_link>
								<@i18n key="IAM.ZOHOCORP.LINK"/>
							</#assign>
							<div class="option_values pref_email_notif_desc" id="subscription_values"><@i18n key="IAM.SETTINGS.SUSCRIPTIONS.NONE" arg0="${corp_link}"/></div>
						</div>
						
						
						
					</div>
					
					</div>


				</div>