<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">


 <script type="text/javascript">

 var i18nAppLoginskeys = {
	    		"IAM.VIEWMORE.LOGINS" : '<@i18n key="IAM.VIEWMORE.LOGINS" />',
				"IAM.VIEWMORE.LOGIN" : '<@i18n key="IAM.VIEWMORE.LOGIN" />'
		};
 var deviceImgToDeviceModelJson = {
 				"iphone": '<@i18n key="IAM.DEVICE.NAME.IPHONE" />',
 				"macbook": '<@i18n key="IAM.DEVICE.NAME.MACBOOK" />',
 				"ipad": '<@i18n key="IAM.DEVICE.NAME.IPAD" />',
 				"googlenexus": '<@i18n key="IAM.DEVICE.NAME.NEXUS" />',
 				"samsungtab": '<@i18n key="IAM.DEVICE.NAME.SAMSUNG.TAB" />',
 				"samsung": '<@i18n key="IAM.DEVICE.NAME.SAMSUNG" />',
 				"androidtablet": '<@i18n key="IAM.DEVICE.NAME.ANDROID.TAB" />'
       };
 </script>


		<div class=" hide popup" tabindex="1" id="App_logins_pop">
		
			<div class="on_popup">
				<i id="product-icon" class="bg">
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
				<span class="devicelogin_details">
					<span class="device_name range_name"></span>					
					<span class="device_time"></span>
				</span>
			</div>
			
			<div class="close_btn" onclick="closeview_selected_App_logins_view()"></div>

			<div id="App_logins_current_info">
			</div>
			
		</div>





		<div class="box big_box" id="App_logins_box" tabindex="1">
		
			<div class="box_blur"></div>
			<div class="loader"></div>
	
			 <div class="box_info">
			 	<div class="expand_closebtn hide tetraSlideClose" id="app_login_close_megaview" onclick="closeApp_logins_bigview()"></div>
				<div class="box_head"><@i18n key="IAM.APP.LOGINS" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.CONNECTED.MOBILEAPPS_DEFINITION" /> </div>
			</div>
			
			 
			<div id="show_App_logins">
			
				<div id="no_App_logins" class="box_content_div hide">
					<div class="no_data no_data_SQ"></div>
					<div class="no_data_text" id="nodata_withTFA"><@i18n key="IAM.CONNECTEDMOBILEAPPS.NOT_PRESENT" /></div>
				</div>
				
				<div id="display_App_logins" class="hide">
				
				</div>
				
			</div>
			
			<div class="view_more hide App_logins_viewmoew tetraViewMore" id="App_logins_viewmoew" onclick="show_all_App_logins();" ><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>	
		
		</div>
		
		
		<div id="app_login_sideview" tabindex="1" class="hide">
		
			<div class="hide App_logins_web_more_first" tabindex="0" >
			
				<div class="menu_header">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_App_logins_view()"></div>
						<div class="devicelogin_div">
						</div>
						<span class="signin_mode"><@i18n key="IAM.APPLOGINS.SIGNEDIN.MODE.ONEAUTH" /></span>
					</div>
				</div>
				
				<div id="view_all_device_info" class="all_elements_space"></div>
			</div>
			
			<div class="hide App_logins_web_more_second" tabindex="0" >
			
				<div class="menu_header">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_App_logins_view()"></div>
						<div class="devicelogin_div">
						</div>
						<span class="signin_mode"><@i18n key="IAM.APPLOGINS.SIGNEDIN.MODE.ONEAUTH" /></span>
					</div>
				</div>
				
				<div id="view_all_device_info" class="all_elements_space"></div>
			</div>
			
		</div>
		
		
		
		
		
		
		
		<div id="empty_App_logins_format" class="hide">
			
			<div class="devicelogins_entry tetraElements" id="App_logins_entry">

				<div class="info_tab">	
					<div class="devicelogin_div">
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
						<span class="devicelogin_details">
							<span class="device_name field_value"></span>
							<span class="device_time"></span>
						</span>
					</div>
					
					<span id="product_oneauthsignin" class="signin_mode"><@i18n key="IAM.APPLOGINS.SIGNEDIN.MODE.ONEAUTH" /></span>
					
					<span class="activesession_entry_info">
						<span class="asession_location location_unavail"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></span>
					</span>
					
				</div>
				
				<div class="aw_info" id="App_logins_info">

					
				</div>
				
			</div>
				
		</div>
		
		
		<div id="empty_Devices_format" class="hide">
		
				<div class="device_entry" id="Devices_entry" onclick="show_deviceentry_info(this)">
				
						<div class="devicelogins_devicedetails">	
							<div class="device_details_head">
								<div class="devicelogin_div">
									<span class="device_pic"></span>
									<span class="devicelogin_details">
										<span class="device_name field_value"></span>
										<span class="device_time"></span>
									</span>
								</div>
								<span id="current_mfadevice" class="primary_device"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.PREF.LABEL" /></span>
								<span id="device_oneauthsignin" class="signin_mode"><@i18n key="IAM.APPLOGINS.SIGNEDIN.MODE.ONEAUTH" /></span>
								
							</div>
							
							<div class="device_aw_info hide" id="device_info">
							
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.AC.DEVICENAME" /></div>
									<div class="info_value" id="pop_up_name" ><div class="asession_os_popup"></div></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.APPLOGINS.DEVICE.MODEL" /></div>
									<div class="info_value" id="pop_up_model"></div>
								</div>
								<!--<div class="info_div hide" id="oneauth_check">
									<div class="info_lable"><@i18n key="IAM.APPLOGINS.SIGNEDIN.MODE" /></div>
									<div class="info_value" id="pop_up_mode"></div>
								</div>-->
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.APPLOGINS.STARTED.TIME" /></div>
									<div class="info_value" id="pop_up_time"></div>
								</div>
								<div class="info_div" id="ip_info">
									<div class="info_lable"><@i18n key="IAM.IPADDRESS" /></div>
									<div class="info_value" id="pop_up_ip"><span class="asession_popup_ip"></span></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /></div>
									
									<div class="info_value location_unavail" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>
									 
									<div class="info_ip"></div>
								</div>
								<button class="primary_btn_check negative_btn_red inline" tabindex="1" id="terminate_device"><span><@i18n key="IAM.REMOVE" /></span></button>	
							</div>
						</div>
								
	                </div>
		
		</div>
		
		
		