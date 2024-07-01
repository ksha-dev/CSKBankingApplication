<!-- tfa trusted browser popup -->
	
	
	
	
<script type="text/javascript">

 var i18nTrustedBrowserkeys = {
	    		"IAM.VIEWMORE.BROWSER" : '<@i18n key="IAM.VIEWMORE.BROWSER" />',
				"IAM.VIEWMORE.BROWSER" : '<@i18n key="IAM.VIEWMORE.BROWSERS" />'
		};
var fontIconBrowserToHtmlElement = {
		"osx": "",
		"ios": "",
		"windows": "",
		"android": "",
		"linux": "",
		"googlechrome":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"safari":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"firefox": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"microsoftedge":'<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"internetexplorer":"",
		"opera": '<span class="path1"></span><span class="path2"></span>',
		"browserunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"osunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>'
	};		
 </script>		
		
		
		
		<div class="box big_box hide" id="trusted_browser_space">
		
			<div class="menu_header">
				<div class="box_info">
					<div class="box_head"><@i18n key="IAM.TFA.TRUST.BROWSERS" /> </div>
					<div class="box_discrption box_discrption_with_limit"><@i18n key="IAM.TRUSTED.BROWSERS.SUBTITLES"/></div>
					<div class="box_discrption box_discrption_without_limit"><@i18n key="IAM.TRUSTED.BROWSERS.SUBTITLES.WITHOUT.DAYS" /> </div>
				</div>
			</div>
			
			<div class="box_content_div hide" id="tfa_empty_trustedbrowser">
				<div class="no_data"></div>
				<div class="no_data_text"><@i18n key="IAM.TFA.TRUST.BROWSERS.EMPTY" /> </div>
			</div>
			<div class="box_content_div hide" id="tfa_disabled_trustedbrowser">
				<div class="no_data disabled_trustedbrowser"></div>
				<div class="no_data_text"><@i18n key="IAM.TFA.TRUST.BROWSERS.DISABLED" /></div>
			</div>
			
			<div class="tfa_trusted_browsers hide">
			</div>
			
			<div class="view_more hide" id="sessions_showall" onclick="show_all_MFAtrusted_browsers()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
	
		</div>
		
		
		<div class=" hide popup popup_padding" tabindex="1" id="trustedbrowser_pop">
		
			<div class="device_div on_popup">
				<span class="device_pic"></span>
				<span class="device_details">
					<span class="device_name"></span>
					<span class="device_time"></span>
				</span>
			</div>
			
			<div class="close_btn" onclick="closeview_selected_browser_view()"></div>

			<br><br><br>

			<div id="sessions_current_info">

			</div>
			
		</div>
		
		
		<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="sessions_web_more">
			
			<div class="box_info">
				<div class="expand_closebtn" onclick="closeview_all_sessions_view()"></div>
				<div class="box_head"><@i18n key="IAM.TFA.TRUST.BROWSERS" /></div>
				<div class="box_discrption"><@i18n key="IAM.TRUSTED.BROWSERS.SUBTITLES" /></div>
			</div>
			
			<div id="view_all_sessions"class="viewall_popup_content">
			</div>

		</div>	
		
		

			
			
			
<!--	# trusted devices content		-->


				
			
		<div id="empty_sessions_format" class="hide">
		
					<div class="Field_session" id="trusted_browser" >
							
						<div class="info_tab">	
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
	
									<div class="asession_location location_unavail"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>

									<div class="asession_action session_logout"><@i18n key="IAM.REMOVE" /></div>
								</div>
							</div>
						
							<div class="aw_info" id="trusted_browser_info">
	
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.TRSUTEDBROWSER.SET.TIME" /></div>
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
									<div class="info_lable"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /></div>
									
									<div class="info_value location_unavail" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>
									 
									<div class="info_ip"></div>
								</div>
									<a class="primary_btn_check negative_btn_red inline" tabindex="1" id="current_session_logout"><span><@i18n key="IAM.REMOVE" /></span></a>									
							</div>
						
						
					</div>
		
		
		</div>
			
		
		
		
		
		