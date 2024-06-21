<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">

 <script type="text/javascript">

 var i18nSessionkeys = {
				"IAM.DEVICELOGINS.REMOVE.LIMIT" : '<@i18n key="IAM.DEVICELOGINS.REMOVE.LIMIT" />',
				"IAM.DEVICE.SIGNIN.DELETE.COUNT" : '<@i18n key="IAM.DEVICE.SIGNIN.DELETE.COUNT" />',
				"IAM.DEVICE.SIGNIN.DELETE.ONE.COUNT" : '<@i18n key="IAM.DEVICE.SIGNIN.DELETE.ONE.COUNT" />'
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
		"browserunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"osunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>'
	};
 </script>


	<div class=" hide popup" tabindex="1" id="Device_logins_pop">
		
		<div class="on_popup">
			<span class="" id="platform_img"></span>
			<span class="device_platform_details">
				<span class="device_name range_name"></span>					
			</span>
		</div>
		
		<div class="close_btn" onclick="closeview_selected_Device_logins_view()"></div>

		<div class="select_all_div">
			<div class="select_holder hide" id="device_select">
				<input data-validate="zform_field" id="device_select_all" onchange="selectAllLocation(this)" name="" class="checkbox_check" type="checkbox">
				<span class="checkbox">
						<span class="checkbox_tick"></span>
				</span>
			</div>
			<div><label for="device_select_all" class="select_all_text"><@i18n key="IAM.SELECT.ALL.TEXT" /></label></div>
		</div>
		<div id="Device_logins_current_info">
		</div>
		<div class="delete_location" style="">
			<div class="select_count_desc">
				<div class="selected_count"></div>
				<div class="limit_reached_desc"></div>
			</div>
			<button class="primary_btn_check right_btn red_btn deleted_location_selected" style="margin:0px;" id="deleted_selected_locations" onclick="deleteSelectedLocations()" ><@i18n key="IAM.DELETE" /></button>	
		</div>	
	</div>



	<div class="box big_box" id="Device_logins_box">
	
		<div class="box_blur"></div>
		<div class="loader"></div>
		
		<div class="box_info">
			<div style="flex:1">
				<div class="box_head"><@i18n key="IAM.DEVICE.LOGINS.TITLE" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.DEVICE.LOGINS.DEFINITION" /> </div>
			</div>
			<button class="primary_btn_check right_btn red_btn header_btn" onclick='showDeleteAllDeviceLoginsConf("<@i18n key="IAM.DEVICE.SIGNIN.DELETE.LOCATION.CONFIRMATION.TITLE" />","<@i18n key="IAM.DEVICE.SIGNIN.DELETE.LOCATION.CONFIRMATION.DESCRIPTION" />")'><@i18n key="IAM.DEVICE.SIGNIN.DELETE.OTHER.LOCATIONS" /></button>
		</div>
		
		<div id="show_Device_logins">
			
			<div id="no_Devices" class="box_content_div">
				<div class="no_data "></div>
				<div class="no_data_text" id="nodata_withTFA"><@i18n key="IAM.DEVICELOGINS.UNAVAILABLE" /></div>
			</div>
			
			<div id="display_all_Devices" class="hide">
			
			</div>
				
		</div>
		
		<div class="view_more hide" id="Device_logins_viewmore" onclick="show_all_device_logins()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>
		
	</div>
	
	
		<div class="hide viewall_popup popupshowanimate_2" tabindex="0" id="Device_logins_web_more" >
		
			<div class="menu_header">
				<div class="box_info">
					<div class="expand_closebtn" onclick="closeview_Device_logins_view()"></div>
					<div class="box_head"><@i18n key="IAM.DEVICE.LOGINS.TITLE" /></span> </div>
					<div class="box_discrption"><@i18n key="IAM.DEVICE.LOGINS.DEFINITION.VIEW.MORE.OPTION" /> </div>
				</div>
			</div>
			<div id="view_all_Device_logins" class="all_elements_space"></div>
			<div class="delete_all_space">
					<div class="select_count_desc">
						<div class="selected_count"></div>
						<div class="limit_reached_desc"></div>
					</div>
					<button class="primary_btn_check right_btn red_btn deleted_selected" id="deleted_selected_sessions" onclick="deleteSelectedDevice();" ><@i18n key="IAM.DELETE" /></button>	
			</div>
		</div>
		
		
		<div id="empty_Device_logins_format" class="hide">
			
			<div class="devicelogins_entry" id="Device_logins_entry">

				<div class="info_tab">	
					<div class="select_holder hide" id="select_device_">
						<input data-validate="zform_field" id="device_check" onchange="handleDeviceGroup(this)" name="" class="checkbox_check device_parent_check" type="checkbox">
						<span class="checkbox">
								<span class="checkbox_tick"></span>
						</span>
					</div>
					<div class="devicelogin_div">
						<span class="mail_client_logo"></span>
						<span class="device_platform_details">
							<span class="device_name field_value"></span>
						</span>
					</div>
					
					<span class="activesession_entry_info">
						<span class="asession_location location_unavail"></span>
					</span>
					
					<div class="asession_action current hide"><@i18n key="IAM.DEVICE.LOGINS.CURRENT.DEVICE" /></div>
				</div>
				
				<div class="aw_info" id="Device_logins_info">

					
				</div>
				
			</div>
				
		</div>
		
		
		
		<div id="empty_Devices_format" class="hide">
		
			<div class="" id="Devices_entry">
			
					<div class="devicelogins_devicedetails">	
						<div class="select_holder hide" id="select_device_browser_">
							<input data-validate="zform_field" id="device_browser_check" onchange="handleChildCheckbox(this)" name="" class="checkbox_check" type="checkbox">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
						</div>
						<div class="devicelogin_div">
							<span class="asession_browser"></span>
							<span class="devicelogin_details">
								<span class="device_name field_value"></span>
								<span class="device_login_tim"></span>
							</span>
						</div>
						<div class="asession_action current"><@i18n key="IAM.USERSESSIONS.CURRENT.SESSION" /></div>
						<div class="devicelogins_entry_info">
						
							<div class="asession_os"></div>
																
							<div class="asession_ip hide"></div>

							<div class="asession_location location_unavail"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>

							<span class="deleteicon action_icon icon-delete" title="<@i18n key="IAM.DELETE" />"></span>
							
						</div>
						
						
					</div>
							
			</div>
		
		</div>