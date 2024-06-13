<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">

 <script type="text/javascript">

 var i18nSessionkeys = {
 				"IAM.DEVICE.NAME.GOOGLE_PIXEL" : '<@i18n key="IAM.DEVICE.NAME.GOOGLE_PIXEL" />',
 				"IAM.SESSIONS.TERMINATE.LIMIT.REACHED" : '<@i18n key="IAM.SESSIONS.TERMINATE.LIMIT.REACHED" />',
	    		"IAM.VIEWMORE.SESSION" : '<@i18n key="IAM.VIEWMORE.SESSION" />',
				"IAM.VIEWMORE.SESSIONS" : '<@i18n key="IAM.VIEWMORE.SESSIONS" />',
				"IAM.SESSION_ALERT.ACTION.LEARN" : '<@i18n key="IAM.SESSION_ALERT.ACTION.LEARN" />',
				"IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.MANAGE.SESSION.ACTION" : '<@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.MANAGE.SESSION.ACTION" />',
				"IAM.SESSION_ALERT.DAILY.WARN.HEADING" : '<@i18n key="IAM.SESSION_ALERT.DAILY.WARN.HEADING" />',
				"IAM.SESSION_ALERT.DAILY.WARN.ONE.HEADING" : '<@i18n key="IAM.SESSION_ALERT.DAILY.WARN.ONE.HEADING" />',
				"IAM.SESSION_ALERT.DAILY.WARN.DESCRIPTION.TODAY" : '<@i18n key="IAM.SESSION_ALERT.DAILY.WARN.DESCRIPTION.TODAY" />',
				"IAM.SESSION_ALERT.DAILY.WARN.DESCRIPTION.TOMORROW" : '<@i18n key="IAM.SESSION_ALERT.DAILY.WARN.DESCRIPTION.TOMORROW" />',
				"IAM.SESSION_ALERT.DAILY.ERROR.HEADING" : '<@i18n key="IAM.SESSION_ALERT.DAILY.ERROR.HEADING" />',
				"IAM.SESSION_ALERT.DAILY.ERROR.DESCRIPTION.TODAY" : '<@i18n key="IAM.SESSION_ALERT.DAILY.ERROR.DESCRIPTION.TODAY" />',
				"IAM.SESSION_ALERT.DAILY.ERROR.DESCRIPTION.TOMORROW" : '<@i18n key="IAM.SESSION_ALERT.DAILY.ERROR.DESCRIPTION.TOMORROW" />',
				"IAM.SESSION_ALERT.MAX_SESSION.WARN.HEADING" : '<@i18n key="IAM.SESSION_ALERT.MAX_SESSION.WARN.HEADING" />',
				"IAM.SESSION_ALERT.MAX_SESSION.WARN.ONE.HEADING" : '<@i18n key="IAM.SESSION_ALERT.MAX_SESSION.WARN.ONE.HEADING" />',
				"IAM.SESSION_ALERT.MAX_SESSION.WARN.DESCRIPTION" : '<@i18n key="IAM.SESSION_ALERT.MAX_SESSION.WARN.DESCRIPTION" />',
				"IAM.SESSION_ALERT.MAX_SESSION.ERROR.HEADING" : '<@i18n key="IAM.SESSION_ALERT.MAX_SESSION.ERROR.HEADING" />',
				"IAM.SESSION_ALERT.MAX_SESSION.ERROR.DESCRIPTION" : '<@i18n key="IAM.SESSION_ALERT.MAX_SESSION.ERROR.DESCRIPTION" />',
				"IAM.SESSIONS.TERMINATE.ONE.COUNT" : '<@i18n key="IAM.SESSIONS.TERMINATE.ONE.COUNT" />',
				"IAM.SESSIONS.TERMINATE.COUNT" : '<@i18n key="IAM.SESSIONS.TERMINATE.COUNT" />',
				"IAM.SESSION.MAX.ALLOWED.SESSION": '<@i18n key="IAM.SESSION.MAX.ALLOWED.SESSION" />'
		};

	var fontIconBrowserToHtmlElement = {
		"osx": "",
		"ios": "",
		"windows": "",
		"android": "",
		"linux": "",
		"googlechrome":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"safari":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"firefox": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"microsoftedge":'<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"internetexplorer":"",
		"opera": '<span class="path1"></span><span class="path2"></span>',
		"zohocliq": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"arattai": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"browserunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"osunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>'
	};
 </script>

	<div class=" hide popup popup_padding" id="activesessions_pop" tabindex="1">
	
		<div class="device_div on_popup">
			
			<span id="device_pic" ></span>
			<span class="device_details">
				<span class="device_name"></span>
				<span class="device_time"></span>
			</span>
			
		</div>
		
		<div class="close_btn" onclick="closeview_selected_sessions_view()"></div>

		<br><br><br>

		<div id="sessions_current_info" class="list_show">
		</div>
		
	</div>
	
	
	
	<div class="box big_box" id="sessions_box" tabindex="1">
	
		<div class="box_blur"></div>
		<div class="loader"></div>
		
		<div class="box_info">
			<div class="expand_closebtn hide tetraSlideClose" id="user_sessions_close_megaview" onclick="close_user_sessions_bigview()"></div>
			<div class="box_head"><@i18n key="IAM.ACTIVESESSIONS" /><span class="icon-info"></span></div>
			<div class="box_discrption"><@i18n key="IAM.ACTIVESESSIONS.DESCRIPTION" /> </div>
		</div>
	
		<div class="session-alert">
			<svg class="canvas_board" width="58px" height="58px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
				<g transform="translate(50,50)">
					<circle cx="0" cy="0" fill="none" r="40" stroke="#E0E0E0" stroke-width="20" stroke-dasharray="250 250">
					</circle>
					<circle id="session_circle" cx="0" cy="0" fill="none" r="40" stroke-width="20" stroke-dasharray="0 250">
					</circle>
				</g>
			</svg>
			<div>
				<h4 id="ss_alert_heading"></h4>
				<p><span id="ss_alert_desc"></span><a href="" target="_blank" id="ss_alert_learn_doc"><@i18n key="IAM.SESSION_ALERT.ACTION.LEARN" /></a></p>
			</div>
			<div class="alert-icon">
				<a id="ss_alert_learn"></a>
			</div>
		</div>
		<div id="all_sessions_active">
			<div id="current_sesion"> 
			</div>
			<div id="other_sesion"> 
			</div>
		
		</div>

		<div class="view_more hide full_view_trigger tetraViewMore" id="sessions_showall" onclick="show_all_sessions()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
		<div class="hide tetraSlideFooter" id="user_sessions_footer">
			<div>
				<div class="session_selected hide">
					<span id="selected_session_txt"></span>
					<p class="hide" id="session_allowed_limit"></p>
				</div>
				<button class="primary_btn_check right_btn hide deleted_selected" id="deleted_selected_sessions" onclick="deleteSelectedSessions();" ><@i18n key="IAM.SESSION.LOGOUT.SELECTED" /></button>	
				<button class="primary_btn_check right_btn red_btn" id="delete_all_sessions" onclick="deleteAllSessions()"><@i18n key="IAM.SESSIONS.TERMINATE.ALL.OTHER.SESSIONS" /></button>	
			</div>
		</div>
	</div>
		
		
		
		
		<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="sessions_web_more">
			
			<div class="box_info">
				<div class="expand_closebtn" onclick="closeview_all_sessions_view()"></div>
				<div class="box_head"><@i18n key="IAM.ACTIVESESSIONS" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.ACTIVESESSIONS.DESCRIPTION" /></div>
			</div>
			
			<div id="view_all_sessions"class="viewall_popup_content selected_delete_popup">
			</div>
			
			<div class="delete_all_space">
				<button class="primary_btn_check right_btn red_btn" onclick="deleteAllSessions()"><@i18n key="IAM.SESSIONS.TERMINATE.ALL.OTHER.SESSIONS" /></button>	
				<button class="primary_btn_check right_btn hide deleted_selected" id="deleted_selected_sessions" onclick="deleteSelectedSessions();" ><@i18n key="IAM.DELETE.SELECTED" /></button>
			</div>

		</div>
		<div id="sessions_sideview" tabindex="1" >
		
			<div class="hide full_view_more_first" tabindex="0" >
			
				<div class="menu_header">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_selected_sessions_view()"></div>
						<div class="heading_div"></div>
						<span class="current_session"><@i18n key="IAM.USERSESSIONS.CURRENT.SESSION" /></span>
					</div>
				</div>
				
				<div id="view_all_info" class="all_elements_space"></div>
			</div>
			
			<div class="hide full_view_more_second" tabindex="0" >
			
				<div class="menu_header">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_selected_sessions_view()"></div>
						<div class="heading_div"></div>
						<span class="current_session"><@i18n key="IAM.USERSESSIONS.CURRENT.SESSION" /></span>
					</div>
				</div>
				
				<div id="view_all_info" class="all_elements_space"></div>
			</div>
			
		</div>
		
		<div id="empty_sessions_format" class="hide">
		
					<div class="Field_session tetraElements" id="activesession_entry" >
							
						<div class="info_tab">	
								<div class="select_holder hide" id="select_session_">
									<input data-validate="zform_field" id="session_check" onclick="display_removeselected_session(event);" name="signoutfromweb" class="checkbox_check" type="checkbox">
									<span class="checkbox">
											<span class="checkbox_tick"></span>
									</span>
								</div>
								<div class="device_div">
									<span class="device_pic"></span>
									<span class="device_details">
										<span class="device_name"></span>
										<span class="device_time"></span>
										
									</span>
								</div>
								<div class="activesession_entry_info">
									<div class="asession_os"></div>
									
									<div class="asession_browser"></div>
									
									<div class="asession_ip hide"></div>
	
									<div class="asession_location location_unavail">
										<span class="location_text"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></span>
										<span class="icon-info" onmouseover="showToopTip(this,'<@i18n key="IAM.ACTIVESESSIONS.IP.TOOLTIP.DESCRIPTION"/>')" onmouseout="hideTooltip()"></span>
									</div>

									<div class="asession_action current"><@i18n key="IAM.USERSESSIONS.CURRENT.SESSION" /></div>
									<div class="asession_action session_logout"><@i18n key="IAM.TERMINATE" /></div>
								</div>
							</div>
						
							<div class="aw_info" id="activesession_info">
	
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.USERSESSIONS.STARTED.TIME" /></div>
									<div class="info_value" id="pop_up_time"></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.OS.NAME.HEADING" /></div>
									<div class="info_value" id="pop_up_os" ><div class="asession_os_popup"></div></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.LOGINHISTORY.BROWSERAGENT.APP" /></div>
									<div class="info_value" id="pop_up_browser"><span class="asession_browser_popup "></span></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.IPADDRESS" /></div>
									<div class="info_value" id="pop_up_ip"><span class="asession_popup_ip"></span></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /></div>
									
									<div class="info_value location_unavail" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>
									 
									<div class="info_ip"></div>
								</div>
									<button class="primary_btn_check negative_btn_red inline" tabindex="1" id="current_session_logout"><span><@i18n key="IAM.TERMINATE" /></span></button>									
							</div>
						
						
					</div>
		
		
		</div>
		
		
		