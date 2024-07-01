
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<script type="text/javascript">
	    var i18nkeys = {
			    "IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION" : '<@i18n key="IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION" />',
				"IAM.CONFIRM.POPUP.PHONENUMBER" : '<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER" />',
				"IAM.CONFIRM.POPUP.EMAIL" : '<@i18n key="IAM.CONFIRM.POPUP.EMAIL" />',
				"IAM.REMOVE" : '<@i18n key="IAM.REMOVE" />',
				"IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.POPUP.DESCRIPTION": '<@i18n key="IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.POPUP.DESCRIPTION" />',
				"IAM.INVITAION.VERIFY.MOBILE" : '<@i18n key="IAM.INVITAION.VERIFY.MOBILE" />',
				"IAM.PROFILE.EMAIL.VERIFY.HEADING" : '<@i18n key="IAM.PROFILE.EMAIL.VERIFY.HEADING" />',
				"IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION" : '<@i18n key="IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION" />',
				"IAM.PROFILE.LINKED.EMAIL.SAML.DESCRIPTION" : '<@i18n key="IAM.PROFILE.LINKED.EMAIL.SAML.DESCRIPTION" />',
				"IAM.ADD" : '<@i18n key="IAM.ADD" />',
				"IAM.ADD.CONTACT.EMAIL" : '<@i18n key="IAM.ADD.CONTACT.EMAIL" />',
				"IAM.VIEWMORE.EMAIL" : '<@i18n key="IAM.VIEWMORE.EMAIL" />',
				"IAM.VIEWMORE.EMAILS" : '<@i18n key="IAM.VIEWMORE.EMAILS" />',
				"IAM.ADD.CONTACT.MOBILE" : '<@i18n key="IAM.ADD.CONTACT.MOBILE" />',
				"IAM.EMAIL.CONFIRMATION.SEND.EMAIL" : '<@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" />',
				"IAM.CONFIRM": '<@i18n key="IAM.CONFIRM" />',
				"IAM.CONTINUE": '<@i18n key="IAM.CONTINUE" />',
				"IAM.BACK": '<@i18n key="IAM.BACK" />',
				"IAM.DELETE": '<@i18n key="IAM.DELETE" />'

		};
        
		var idpInfoValueToHtmlElement = {
				"idpValue_7":{
							"iconClassName": "icon-google_small",
							"iconElement":	'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
						},
				"idpValue_15":{
							"iconClassName": "icon-azure_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_9":{
							"iconClassName": "icon-linkedin_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_8":{
							"iconClassName": "icon-facebook_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_10":{
							"iconClassName": "icon-twitter_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_3":{
							"iconClassName": "icon-yahoo_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_24":{
							"iconClassName": "icon-slack_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_14":{
							"iconClassName": "icon-douban_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_13":{
							"iconClassName": "icon-qq_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>'
				},
				"idpValue_22":{
							"iconClassName": "icon-wechat_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_11":{
							"iconClassName": "icon-weibo_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>'
				},
				"idpValue_12":{
							"iconClassName": "icon-baidu_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_26":{
							"iconClassName": "icon-apple_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_20":{
							"iconClassName": "icon-intuit_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_27":{
							"iconClassName": "icon-adp_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
				},
				"idpValue_29":{
							"iconClassName": "icon-feishu_small",
							"iconElement": '<span class="path1"></span><span class="path2"></span><span class="path3">'
				},
				"idpValue_31":{
							"iconClassName":"icon-github_small",
							"iconElement":''
				}
		};
	</script>
<#--   ADD EMAIL POPUP -->



						<div tabindex="1" class="hide popup" id="add_email_popup">
							<div class="popup_header">
								<div class="popuphead_details">
									<span class="popuphead_text"><@i18n key="IAM.ADD.CONTACT.EMAIL" /></span>
								</div>
								<div class="close_btn" onclick="close_addemail_popup()"></div>
							</div>
							
							<div id="add_em_form" class="popup_padding">
								<div class="form_description">
									<span class="popuphead_define" id="create_description"><@i18n key="IAM.PROFILE.EMAILS.ADD.SECONDARY.DESC" /></span>
									<span class="popuphead_define hide" id="email_otp_description"></span>
									<span class="hide" id="email_otp_text"><@i18n key="IAM.PROFILE.EMAILS.ADD.SECONDARY.OTP.DESCRIPTION" /></span>
								</div>
								
								<div class="" id="NEWemail_add">
									<form method="post" name ="addemailid" id="addemailform" onsubmit="return false;" novalidate="">
										<div class="field full">
					                  		<label class="textbox_label"><@i18n key="IAM.USER.ENTER.EMAIL.PLACEHOLDER" /></label>
					                  		<input class="textbox" tabindex="1" data-validate="zform_field" autocomplete="email" name="email_id" data-limit="100" onkeypress="remove_error()" type="email">
										</div>
										
										<button class="primary_btn_check " tabindex="1" id="add_email_action" onclick="add_email(document.addemailid,add_email_callback);"><span><@i18n key="IAM.ADD" /></span></button>
									</form>	
								</div>
								<div class="hide" id="NEWemail_confirmation">
									<form method="post" name ="verifyemailid" id="addemailverifyform" onsubmit="return confirm_add_email(this,confirm_add_email_callback);return false;" novalidate="">
										<div class="field full otp_field" id="otp_emailaddress">
					                  		<label class="textbox_label"><@i18n key="IAM.VERIFY.CODE" /></label>
					                  		<div class="split_otp_container" id="otp_email_input"></div>
					                  		<div id="emailOTP_resend" class="otp_resend" onclick="emailOTP_resendcode(this);"><a href="javascript:;"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" /> </a></div>
											<div class="resend_text otp_sent" style="display:none;" id="otp_sent"><@i18n key="IAM.GENERAL.OTP.SENDING" /></div>
										</div>
										
										<button class="primary_btn_check " tabindex="1" id="add_email_verify_action" ><span><@i18n key="IAM.NEW.SIGNIN.VERIFY" /></span></button>
										<button class="primary_btn_check high_cancel" id="back_to_add_email" type="button" tabindex="0" onclick="backToAddEmail()"><span><@i18n key="IAM.BACK" /> </span></button>
									</form>
								</div>
									
							
							</div>
					</div>
		
		
<#--   SEND VERIFICATION EMAIL POPUP -->



						<div tabindex="1" class="hide popup" id="send_verification_email_popup">
							<div class="popup_header">
								<div class="popuphead_details">									
									<span class="popuphead_text"><@i18n key="IAM.PROFILE.EMAIL.VERIFY.HEADING" /></span>
								</div>
								<div class="close_btn" onclick="close_send_verification_email_popup()"></div>
							</div>
							
							<div id="send_verify_em_form" class="popup_padding">
								<div class="form_description" style="margin-bottom:10px;">
									<span class="popuphead_define" id="create_description" style="display:inline-block;"></span>									
								</div>
								
								<div class="" id="NEWemail_send_verify">
									<form method="post" name ="sendverifyemail" id="sendverifyemailform" onsubmit="return false;" novalidate="">																				
										<button class="primary_btn_check " tabindex="1" id="send_verification_email_action"><span><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" /></span></button>
									</form>	
								</div>																								
							</div>
					</div>
				
		
		
<#--   Change Primary EMAIL POPUP -->	


					<div class="hide popup" tabindex="1" id="change_primaryEM">
						<div class="popup_header ">
							<div class="popuphead_details">
								<span class="popuphead_text"><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></span>
							</div>
							<div class="close_btn" onclick="close_change_primaryEM()"></div>
						</div>
						
						<div id="change_em_form" class="popup_padding">
							<div class="form_description">
								<span class="popuphead_define" id="make_email_primary"><@i18n key="IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION" /></span>
							</div>
							<form method="post" name="setAsPrimary" class="zform" id="Changeemailform" onsubmit="return false;" novalidate="">
							
								<div class="field full hide">
			                  		<label class="textbox_label"><@i18n key="IAM.USER.ENTER.EMAIL.PLACEHOLDER" /></label>
			                  		<input class="textbox" tabindex="1" data-validate="zform_field" autocomplete="email" name="email_id" data-limit="100" id="selectedemail" type="text">
								</div>
								
								<button class="primary_btn_check " tabindex="1" id="mkprim_email_action"><span><@i18n key="IAM.MYEMAIL.MAKE.PRIMARY" /></span></button>
								
							</form>
						
						</div>
					</div>


<#--   			Mobile Email Option Popup				-->
					
					<div class="hide popup" tabindex="1" id="Email_popup_for_mobile">
					    <div class="popup_header popup_header_for_mob">
							<div class="popuphead_details">
							</div>
							<div class="profile_tags_wrapper">
								<span class="profile_info_tags primary_tag hide">
									<span class="icon-Primary"></span><span class="inf_txt"><@i18n key="IAM.PRIMARY.NUMBER" /></span>
								</span>
								<span class="profile_info_tags recovery_tag hide">
									<span class="icon-recoveryNum"></span><span class="inf_txt"><@i18n key="IAM.PROFILE.RECOVERY.NUMBER.TEXT" /></span>
								</span>
								<span class="profile_info_tags mfa_tag hide">
									<span class="icon-tfaNum"></span><span class="inf_txt"><@i18n key="IAM.PROFILE.MFA.NUMBER.TEXT" /></span>
								</span>
							</div>
						    <div class="close_btn" onclick="close_for_mobile_specific()"></div>
					    </div>
					    <div class="mob_popu_btn_container">
					    	<button id="btn_to_swap" >
					        <span class="icon-swapNum"></span><span><@i18n key="IAM.PROFILE.PHONENUMBER.SWAP.NUMBER.TEXT" /></span>
					        </button>
					        <button id="btn_to_mark_recovery" onclick=""><span class="icon-recoveryNum"></span><span><@i18n key="IAM.PROFILE.PHONENUMBER.MARK.AS.RECOVERY" /></span></button>
					        <button id="btn_to_resend" onclick=""><span class="icon-ccomplete" style="font-size:20px; color: #0091FF"></span><span style="color: #0091FF; line-height:20px;"><@i18n key="IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.EMAIL" /></span></button>
					        <button id="btn_to_resend_mb" onclick=""><span class="icon-ccomplete" style="font-size:20px; color: #0091FF"></span><span style="color: #0091FF; line-height:20px;"><@i18n key="IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.MOBILE" /></span></button>
					        <button class id="btn_to_chng_primary" onclick="show_mob_conform('primary','<@i18n key="IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.DESCRIPTION" />')"><span class="icon-Primary"></span><span class="set_signinNum_txt"><@i18n key="IAM.PROFILE.EMAIL.SET.PRIMARY" /></span></button>
					        <button class id="btn_to_chng_primary_mb" onclick="show_mob_conform('primary','<@i18n key="IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.DESCRIPTION" />')"><span class="icon-Primary"></span><span class="set_signinNum_txt"><@i18n key="IAM.PROFILE.PHONENUMBER.SET.SIGNIN.NUMBER" /></span></button>
					        <button id="btn_to_edit"><span class="icon-edit"></span><span><@i18n key="IAM.EDIT" /></span></button>
					        <button id="btn_to_remove_as_primary"><span class="icon-Primary"></span><span class="set_signinNum_txt"><@i18n key="IAM.PROFILE.PHONENUMBERS.REMOVE.AS.PRIMARY" /></span></button>
					        <button id="btn_to_delete" onclick="show_mob_conform('delete')"><span class="icon-delete"></span><span><@i18n key="IAM.REMOVE" /></span></button>
					    </div>
					    <div class="option_container">
					    	<div class="mob_popuphead_define">
					    		
					    	</div>
					    	<div class="option_button">
						        <button id="action_granted"><@i18n key="IAM.CONTINUE"/></button>
						        <button id="" onclick="close_for_mobile_specific()"><@i18n key="IAM.CANCEL" /></button>
					    	</div>
					    	<div class="otp_mobile_form">
					    	<form name="resend_otp_ver_form" class="resend_otp_ver_form" id="resend_otp_ver_form" onsubmit="return false;">
					    		<input type="text" id="email_conf_input" read-only style="display:none;" name="email_id">
					    		<input type="text" id="mobile_conf_input" read-only style="display:none;" name="mobile_no">
					    		<div class="field full otp_field" id="otp_phonenumber">
					            	<label class="textbox_label"><@i18n key="IAM.VERIFY.CODE" /></label>
					            	<div class="split_otp_container" id="mob_otp_email_input"></div>
					            	<div id="emailOTP_resend" class="otp_resend" onclick="emailOTP_resendcode(this);"><a href="javascript:;"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" /></a></div>
					            	<div class="mobile_resend_option">
						            	<span class="desc_about_block_otp"></span>
						            	<div id="mobileOTP_resend" class="otp_resend" onclick="resendverifyOTP(this, true);"><a href="javascript:;"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" /></a></div>
									</div>
									<div class="resend_text otp_sent" style="display:none;" id="otp_sent"><@i18n key="IAM.GENERAL.OTP.SENDING" /></div>
								</div>
								<button id="action_otp_conform" onclick="return confirm_add_email(document.otp_form_in_viewall,resendEmailConfirmLink_mobile_callback)"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
								<button id="" onclick="close_for_mobile_specific()"><@i18n key="IAM.CANCEL" /></button>
					    	</form>
					    	</div>
					    </div>
					</div>
					

<#--   			The UI BOX				-->
    




				<div class="box big_box" id="email_box">
				
							<div class="box_blur"></div>
							<div class="loader"></div>
				
					<div class="box_info">
						<div class="box_head"><@i18n key="IAM.MYEMAIL.ADDRESS" /></div>
						<div class="box_discrption mob_hide"><@i18n key="IAM.MYEMAIL.DESCRIPTION" /></div>
					</div>
					
					<div id="no_email_add_here" class="box_content_div hide">
						<div class="no_data no_data_SQ"></div>
						<div class="no_data_text hide"><@i18n key="IAM.EMAIL.LIST.EMPTY" /> </div>
						<a class="primary_btn_check  center_btn " onclick="showaddemail_popup();" ><span><@i18n key="IAM.ADD.CONTACT.EMAIL" /></span></a>
			 		</div>
			 		
			 		
					<div id="email_content" class="hide email_table">
						
						<div class="emailID_prim hide" id="emailID_prim">
						
							<!-- PRIMARY EMAIL -->	
							<div class="field_email primary" id="emailID_num_0" onclick="for_mobile_specific_email('emailID_num_0')">
								
								<span class="email_dp icon-email"></span>							
								<span class="email_info">
									<div id="primary_emailid" class="primary_emailid emailaddress_text"></div>
									<div  id="PrimConfim" class="hide red emailaddress_addredtime"><@i18n key="IAM.MSG.VERIFY.EMAIL" /></div>
									<div  id="prim_tap_to_more" class="hide red emailaddress_addredtime"><@i18n key="IAM.MSG.TAP.TO.MORE" /></div>	
									<div id="prim_em_time" class="emailaddress_addredtime"></div>
									<div id="prim_em_verify_now_0" class="hide verify_now_text"><@i18n key="IAM.VERIFY.NOW" /></div>
							<!--		<div class="emailaddress_addredtime primary_dot" title="Primary"><@i18n key="IAM.EMAIL.PRIMARY.EMAIL" /></div> -->
								</span>
								
								<span class="profile_tags primary_tag icon-Primary">
									<span class=" tooltiptext tooltiptext1">
										<span class="profile_tags primary_tag icon-Primary profile_tags_tooltip_icon"></span>
										<span class="profile_tags_tooltip_heading"><@i18n key="IAM.EMAIL.PRIMARY.EMAIL" /></span>
										<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.PRIMARY.EMAIL.ADDRESS.DESCRIPTION" /></span>
									</span>
								</span>
						
								   					
							<span class="profile_tags linked_email_tag icon-link hide">
									<span class=" tooltiptext tooltiptext1">
										<span class="profile_tags_tooltip_heading" style="margin-left: 0px;"><@i18n key="IAM.EMAIL.LINKED.EMAIL" /></span>
										<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION" /></span>
										<div class="saml_enforced_desc hide"><@i18n key="IAM.PROFILE.LINKED.EMAIL.SAML.ERROR" /></div>
										<span class="all_linked_icons">
											<span class="sml_idp_icon"></span>
										</span>
										<span class="tooltip_cta_text mfa_settings" onclick="loadPage('setting','linkedaccounts');"><@i18n key="IAM.PROFILE.LINKED.ACCOUNT.SETTINGS" /></span>
									</span>
							</span>
							<!-- PRIMARY EMAIL HOVER SECTION -->
								<div id="emailID_info0" class="email_hover_show">
									<span class="action_icons_div">																			
										<span class="deleteicon action_icon icon-delete" id="em_icon_delete_0" title="<@i18n key="IAM.DELETE" />" onclick="deleteEmail('<@i18n key="IAM.CONFIRM.POPUP.EMAIL" />');" ></span>
									</span>
								</div>
								
							</div>
							
						</div>
					
						<div class="emailID_sec ">
		        
						</div>
					
					</div>
					
					<div id="email_add_view_more" class="hide">
						<div class="view_more half" onclick="show_all_emails()"><span><@i18n key="IAM.VIEWMORE.EMAIL" /></span></div>   
						<div class="addnew half " onclick="showaddemail_popup();" ><@i18n key="IAM.ADD.CONTACT.EMAIL" /></div>
					</div>
					
					<div class="addnew hide" id="email_justaddmore" onclick="showaddemail_popup();" ><@i18n key="IAM.ADD.CONTACT.EMAIL" /></div>
					<div class="view_more hide" id="email_justview" onclick="show_all_emails()"><span><@i18n key="IAM.VIEWMORE.EMAIL" /></span></div>
				
				</div>


    
    			
             	<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="emails_web_more">
					
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_all_email_view()"></div>
						<div class="box_head"><@i18n key="IAM.MYEMAIL.ADDRESS" /></div>
						<div class="box_discrption"><@i18n key="IAM.MYEMAIL.DESCRIPTION" /></div>
					</div>
					
					<div class="viewall_popup_content email_table" id="view_all_email">
					</div>
				</div>
                

                
               	
               <div id="empty_secondary_format" class="hide">
               
	                <div class="field_email secondary" id="sec_emailDetails">
	                	
	                	<span class="email_dp icon-email"></span>
	                	<span class="email_info"> 
	                		<div class="emailaddress_text"></div>
	                		<div id="secondary_unconfirmed" class="hide red emailaddress_addredtime"><@i18n key="IAM.MSG.VERIFY.EMAIL" /></div>
	                		<div id="secondary_verify_now" class="hide verify_now_text"><@i18n key="IAM.VERIFY.NOW" /></div>	
	                		<div id="secondary_time" class="emailaddress_addredtime"></div> 
							<div  id="secondary_tap_to_more" class="hide red emailaddress_addredtime"><@i18n key="IAM.MSG.TAP.TO.MORE" /></div>							
	                		 
	                	</span>
	                	
						<span class="profile_tags linked_email_tag icon-link hide">
							<span class=" tooltiptext tooltiptext1">
								<span class="profile_tags_tooltip_heading" style="margin-left: 0px;"><@i18n key="IAM.EMAIL.LINKED.EMAIL" /></span>
								<span class="profile_tags_tooltip_desc"> <@i18n key="IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION" /></span>
								<div class="saml_enforced_desc hide"><@i18n key="IAM.PROFILE.LINKED.EMAIL.SAML.ERROR" /></div>
								<span class="all_linked_icons">
									<span class="sml_idp_icon"></span>
								</span>
								<span class="tooltip_cta_text mfa_settings" onclick="loadPage('setting','linkedaccounts');"><@i18n key="IAM.PROFILE.LINKED.ACCOUNT.SETTINGS" /></span>
							</span>
						</span>
	                	
	                	<div class="email_hover_show">
	                		<div class="action_icons_div">	                				                				                			
	                			<span class="mkeprimary action_icon icon-Primary"><span class="set_signinNum_txt"><@i18n key="IAM.PROFILE.EMAIL.SET.PRIMARY" /></span></span>	                				                			
	                			<span class="deleteicon hide action_icon icon-delete" title="<@i18n key="IAM.DELETE" />" onclick="deleteEmail('<@i18n key="IAM.CONFIRM.POPUP.EMAIL" />');"></span>
	                		
	                		</div>
	                	</div>
	                	
	                </div>
                	
                </div>
                
                