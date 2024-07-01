




					<div class="box big_box" id="deleteacc_box">
					
						<div class="box_blur"></div>
						<div class="loader"></div>
			
						<div class="box_info">
							<div class="box_head"><@i18n key="IAM.CLOSE.ACCOUNT" /><span class="icon-info"></span></div>
							<div class="box_discrption personal_user_desc old_flow_desc"><@i18n key="IAM.CLOSEACCOUNT.DEFINITION" arg0="${closeaccount_help_doc_old_flow}"/> </div>
							<div class="box_discrption admin_user_desc old_flow_desc"><@i18n key="IAM.CLOSEACCOUNT.ORG.ADMIN.DEFINITION" arg0="${closeaccount_help_doc_old_flow}"/> </div>
							<div class="box_discrption personal_user_desc new_flow_desc"><@i18n key="IAM.CLOSEACCOUNT.DEFINITION" arg0="${closeaccount_help_doc_new_flow}"/> </div>
							<div class="box_discrption admin_user_desc new_flow_desc"><@i18n key="IAM.CLOSEACCOUNT.ORG.ADMIN.DEFINITION" arg0="${closeaccount_help_doc_new_flow}"/> </div>
						</div>
						
						<div id="CloseAccount" class="box_content_div">
							<div class="no_data no_data_closeACC"></div>
							
							<div id="close_info_text">
								<div class="no_data_text hide" id="partner_info"><@i18n key="IAM.CLOSEACCOUNT.MESSAGE.FOR.PARTNERADMIN" /> </div>
								<div class="no_data_text hide" id="org_owner_info"><@i18n key="IAM.CLOSEACCOUNT.MSG.ORGOWNER" /> </div>
								<div class="no_data_text hide" id="new_org_owner_info"><@i18n key="IAM.CLOSEACCOUNT.NEW.MSG.ORGOWNER" /> </div>
								<div class="no_data_text hide" id="blank_org_owner_info"><@i18n key="IAM.CLOSEACCOUNT.MSG.ORGOWNER.BLANK_ORGNAME" /> </div>
								<div class="no_data_text hide" id="contact_admin"><@i18n key="IAM.CLOSE.CONTACT.ADMIN.TEXT" /> </div>
								<div class="no_data_text hide" id="blank_org_contact_admin"><@i18n key="IAM.CLOSE.CONTACT.ADMIN.TEXT.BLANK_ORGNAME" /> </div>
								<div class="no_data_text hide" id="anti_spam"><@i18n key="IAM.REGISTER.ANTISPAM_ERROR" /> </div>
								<div class="no_data_text hide" id="downgrade_service"><@i18n key="IAM.CLOSEACCOUNT.PAYMENT_DOWNGRADE" /></div>
								<div class="no_data_text" id="personal_acc_delete"><@i18n key="IAM.CLOSE.TEXT" />  </div>
								<div class="no_data_text hide" id="conti_close_flow">
										<span class="for_org_user"><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS.DESC" /></span>
										<span class="for_personal_user"><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS.DESC.ACCOUNT" /></span>
								</div>
							</div>
							
							<div id="close_info_button">
								<button class="primary_btn_check center_btn "  >
									<span class="hide" id="support_mail"><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" /> </span>
									<span class="hide" id="org_cancel"><@i18n key="IAM.CANCEL.ORG" />  </span>
									<span class="hide" id="unsubcribe"><@i18n key="IAM.GROUP.UNSUBCRIBE" /> </span>
									<span id="personal_user_close"><@i18n key="IAM.CLOSE.ACCOUNT" /></span>
								</button>
							
							</div>
							<div id="flow_cnt_btns">
								<button id="continueClsProcess" onclick="backToPreviousFlow()" class="primary_btn_check red_btn" ><span><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS" /></span></button>
								<button id="cancelClsProcess" class="primary_btn_check cancel_btn"><span><@i18n key="IAM.CANCEL" /></span></button>
							</div>
		 				</div>
		 				
		 			</div>
		 			
		 			
		 			
		 			
		 		<div class="hide popup" id="popup_deleteaccount_close" tabindex="1">
					<div class="popup_header ">
						<div class="popuphead_details">
							<span class="popuphead_text"><@i18n key="IAM.CLOSE.ACCOUNT" /></span>
						</div>
						<div class="close_btn" onclick="close_deleteaccount()"></div>
					</div>
					<div id="delete_acc_final" class='popup_padding'>
					
						<span class="popuphead_define"><@i18n key="IAM.CLOSEACCOUNT.DEFINITION" arg0="${closeaccount_help_doc_old_flow}" /></span>					
						<form id=closeform name=closeform onsubmit="return false" >
							
							
							
							<div class="field full noindent">
		                  		<label class="textbox_label"><@i18n key="IAM.CLOSE.CLOSING_REASON" /></label>
								<select class="select_field" data-validate="zform_field" name="reason" id="delete_acc_reason" >

										<option value="NOT_HAPPY"><@i18n key="IAM.NOT.HAPPY" /></option>
										<option value="NOT_USEFUL"><@i18n key="IAM.NOT.USEFUL" /></option>
										<option value="MOVING_TO_ALTERNATIVE"><@i18n key="IAM.CLOSE.MOVE_ALTERNATE" /></option>
	
								</select>
							</div>
							
							<div class="field full" >
		                  		<label class="textbox_label"><@i18n key="IAM.CLOSE.ACCOUNT.FEEDBACK" /></label>
								<span class="deleteacc_cmnd_parent" >
									<textarea id="deleteacc_cmnd" class="deleteacc_cmnd" tabindex="0" maxlength="1000" data-validate="zform_field" oninput="showLength(this)" name="comments" placeholder="<@i18n key="IAM.FEEDBACK" />"></textarea>
									<label for="deleteacc_cmnd" id="feedback_length" class="feedback_length"></label>
								</span>
							</div>
							
							<button class="primary_btn_check red_btn" tabindex="0" id="confirm_close_account" onclick="CLOSE_ACCOUNT();" ><span><@i18n key="IAM.CLOSE.ACCOUNT" /></span></button>
							<button class="primary_btn_check high_cancel" tabindex="0" onclick="close_deleteaccount();" ><span><@i18n key="IAM.CANCEL" /></span></button>
						</form>

					</div>
				</div>
				
				
				
				
				
				
				<div class="hide popup" id="popup_deleteaccount_downgrade">
					<div class="popup_header ">
						<div class="popuphead_details">
							<span class="popuphead_text"><@i18n key="IAM.CLOSE.ACCOUNT" /></span>
							<span class="popuphead_define"><@i18n key="IAM.CLOSEACCOUNT.PAYMENT_DOWNGRADE" /> </span>
						</div>
						<div class="close_btn" onclick="close_downgradepopup()"></div>
					</div>
					<div id="delete_acc_info">
					</div>
				</div>
				
				
				<div id="empty_app_format" class="hide">
					    
					    <div class="Field_session" id="service_info"> 
							<div class="info_tab">	
								<div class="authtoken_div">
									<i class="product-icon bg">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
										<span class="path4"></span>
										<span class="path5"></span>
										<span class="path6"></span>
										<span class="path7"></span>
										<span class="path8"></span>
										<span class="path9"></span>
										<span class="path10"></span>
										<span class="path11"></span>
										<span class="path12"></span>
										<span class="path13"></span>
										<span class="path14"></span>
										<span class="path15"></span>
										<span class="path16"></span>
									</i>
									<span class="authtoken_details closeacc_name">
										<span class="authtoken_name"></span>
									</span>
								</div>
							</div>
						</div>
						
				</div>
				
				
				