<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
 
 
 				<div class="hide popup popup_padding" id="popup_active-history_contents" tabindex="1">
					<div class="authweb_popup_head" id="tp_history_popup_head"></div>
					<div class="close_btn" onclick="close_selected_history_screen()"></div>
					<span id="tp_history_popup_info"></span>
				</div>
    					<div class="box big_box" id="tp_history_box">
    						
    						<div class="box_blur"></div>
							<div class="loader"></div>
							
							<div class="box_info">
								<div class="box_head"><@i18n key="IAM.THIRDPARTY.ACCESS" /><span class="icon-info"></span></div>
								<div class="box_discrption"><@i18n key="IAM.THIRDPARTY.ACCESS.DESCRIPTION" /></div>
							</div>
							
							<div id="tp_history_screen" class="box_content_div">
								
								<div class="no_data no_data_SQ"></div>
								<div class="no_data_text hide" id="empty_tp_history_screen"><@i18n key="IAM.LOGINHISTORY.SHOW" /> </div>
								<div class="no_data_text hide" id="tp_history_unavaiable"><@i18n key="IAM.LOGIN_HISTORY.EMPTY" /> </div>
								<button class="primary_btn_check center_btn " onclick="show_thirdparty_history()"><span><@i18n key="IAM.THIRDPARTY.ACCESS.SHOW.BUTTON" /></span></button>
							</div>
							
							<div class="tp_column_heading hide">
								<div class="service_details"><@i18n key="IAM.THIRDPARTY.ACCESS.SERVICE.DETAILS" /></div>
								<div class="email_details"><@i18n key="IAM.THIRDPARTY.ACCESS.USED.EMAIL" /></div>
								<div class="ip_details"><@i18n key="IAM.THIRDPARTY.ACCESS.IP.ADDRESS" /></div>
								<div class="agent_details"><@i18n key="IAM.THIRDPARTY.ACCESS.USER.AGENT" /></div>
							</div>	
							<div id="tp_history_space" class="hide">
								
							</div>
							
							<div class="view_more hide" id="tp_history_showall" onclick="show_all_tphistory()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>

						</div>
						
				<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="tp_history_web_more">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_all_tpHistoy()"></div>
						<div class="box_head"><@i18n key="IAM.THIRDPARTY.ACCESS" /><span class="icon-info"></span></div>
						<div class="box_discrption"><@i18n key="IAM.THIRDPARTY.ACCESS.DESCRIPTION" /></div>
					</div>
					<div class="tp_column_heading hide">
						<div class="service_details"><@i18n key="IAM.THIRDPARTY.ACCESS.SERVICE.DETAILS" /></div>
						<div class="email_details"><@i18n key="IAM.THIRDPARTY.ACCESS.USED.EMAIL" /></div>
						<div class="ip_details"><@i18n key="IAM.THIRDPARTY.ACCESS.IP.ADDRESS" /></div>
						<div class="agent_details"><@i18n key="IAM.THIRDPARTY.ACCESS.USER.AGENT" /></div>
					</div>	
					<div id="view_all_tpHistory"class="viewall_popup_content">
					</div>
				</div>
				
				<div id="empty_thirdparty_histroy_format" class="hide">
					
					
					<div class="Field_session" id="tphistory_entry" >
						
						<div class="info_tab">
							
							<div class="tp_history_div">
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
								<span class="tp_service_details">
									<span class="tp_service_name"></span>
									<span class="tp_service_time"></span>
								</span>
							</div>
							
							<div class="tp_entry_info">
								<div class="tp_email"></div>
								<div class="tp_ip"></div>
								<div class="tp_user_agent"></div>
							</div>
							
						</div>
							
							
					</div>
				
				</div>