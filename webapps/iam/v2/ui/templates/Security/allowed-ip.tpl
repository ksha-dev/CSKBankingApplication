<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">

 <script type="text/javascript">
	    var i18nIPkeys = {
	    		"IAM.VIEWMORE.IP" : '<@i18n key="IAM.VIEWMORE.IP" />',
				"IAM.VIEWMORE.IPs" : '<@i18n key="IAM.VIEWMORE.IPS" />',
				"IAM.ORG.IP.RESTRICT.EMPTY.WARN" : '<@i18n key="IAM.ORG.IP.RESTRICT.EMPTY.WARN" />',
				"IAM.ORG.IP.RESTRICT.EXIST.WARN" : '<@i18n key="IAM.ORG.IP.RESTRICT.EXIST.WARN" />',
				"IAM.ALLOWEDIP.SESSION.BROWSER" : '<@i18n key="IAM.ALLOWEDIP.SESSION.BROWSER" />',
				"IAM.ALLOWEDIP.SESSION.IMAP" : '<@i18n key="IAM.ALLOWEDIP.SESSION.IMAP" />',
				"IAM.ALLOWEDIP.IPNAME.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.IPNAME.EMPTY" />',
				"IAM.ALLOWEDIP.STATIC.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.STATIC.EMPTY" />',
				"IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY" />',
				"IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID" : '<@i18n key="IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID" />',
				"IAM.ALLOWEDIP.TOIP.NOT_VALID" : '<@i18n key="IAM.ALLOWEDIP.TOIP.NOT_VALID" />',
				"IAM.ALLOWEDIP.UNAMED" : '<@i18n key="IAM.ALLOWEDIP.UNAMED" />',
				"IAM.ALLOWEDIP.IPNAME.ALREADY.EXISTS" : '<@i18n key="IAM.ALLOWEDIP.IPNAME.ALREADY.EXISTS" />',
				"IAM.ALLOWEDIP.EDIT.NO.CHANGES.MADE" : '<@i18n key="IAM.ALLOWEDIP.EDIT.NO.CHANGES.MADE" />',
				"IAM.ALLOWEDIP.FROMIP.NOTVALID" : '<@i18n key="IAM.ALLOWEDIP.FROMIP.NOTVALID" />',
				"IAM.ALLOWEDIP.TOIP.ERROR.EMPTY" : '<@i18n key="IAM.ALLOWEDIP.TOIP.ERROR.EMPTY" />',
				"IAM.ALLOWEDIP.STATICIP.ALREADY.EXIST" : '<@i18n key="IAM.ALLOWEDIP.STATICIP.ALREADY.EXIST" />',
				"IAM.ALLOWEDIP.RANGEIP.ALREADY.EXIST" : '<@i18n key="IAM.ALLOWEDIP.RANGEIP.ALREADY.EXIST" />',
				"IAM.ALLOWEDIP.ERROR.NOT.IN.RANGE" : '<@i18n key="IAM.ALLOWEDIP.ERROR.NOT.IN.RANGE" />'
					
		};
	</script>


		<div class=" hide popup popup_padding" tabindex="1" id="allowed_ip_pop">
		
			<div class="device_div on_popup">
				<span class="device_pic"></span>
				<span class="device_details">
					<span class="device_name range_name"></span>
					
						<span id="edit_ip_name" title="<@i18n key='IAM.EDIT'/>"></span>
					
					<span class="device_ip"></span>
					
				</span>
			</div>
			
			<div class="close_btn" onclick="closeview_selected_ip_view()"></div>

			<div id="ip_current_info">

			</div>
			
		</div>

		<div class="hide popup" tabindex="0" id="edit_allowed_ip_pop" style="width: 700px;">
		
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text_new"><@i18n key="IAM.ALLOWED.IPADDRESS.EDIT" /> </span>
				</div>
				<div class="close_btn" onclick="close_edit_ip_popup()"></div>
			</div>
			<div class="popuphead_warning">
				<span class="popup_icon_warn icon-warningfill"></span>
				<span class="popuphead_warninfas"><@i18n key="IAM.ADD.ALLOWEDIP.EDIT.DEFINITION" /></span>
			</div>
			<div id="edit_ip_info" class="popup_padding">
				<form name ="editip"  id="editipform" onsubmit="return save_edited_ip(this)">
					<div id="edit_ip">
						<div class="field" id="edit_ip_name_container">
							<div class="textbox_label"><@i18n key="IAM.IP.NAME" /></div>
							<input type="text" class="textbox" tabindex="1" autocomplete="off" name="ip_name_edit" id="ip_name_edit" data-limit="100">
							<div class="textbox_tip"><i><@i18n key="IAM.TFA.PASSKEY.CONFIGURATION.NAME.DESC" /></i></div>
						</div>
						
						<div id="edit_static_ip" class="hide">
							<div class="edit_ip_heading"><@i18n key="IAM.IPADDRESS" /> </div>
							<div class="static_ip_desc" style="margin-top: 8px;"><@i18n key="IAM.IP.RANGE.IP.DESC"/></div>
							<div id="edit_static_ip_field" class="hide"></div>
							<div class="static_ip_container">
								<div class="add_more_static_ip add-circle" onclick="add_more_ip('edit_');"></div>
							</div>
						</div>
						
						<div id="edit_range_ip" class="hide">
							<div class="edit_ip_heading"><@i18n key="IAM.ADD.ALLOWEDIP.RANGE" /> </div>
							<div class="range_ip_desc" style="margin-top: 8px;"><@i18n key="IAM.IP.RANGE.IP.DESC"/></div>
							<div id="edit_range_container" class="hide">
									<div id="edit_from_ip_field" class="ip_field_div from_ip"></div>
									<div id="edit_to_ip_field" class="ip_field_div to_ip"></div>
							</div>
							<div class="range_ip_container">
								<div class="heading_container">
									<div class="heading"><@i18n key="IAM.ALLOWEDIP.FROMIP.ADDRESS"/></div>								
									<div class="heading" style="margin-left: 14px;"><@i18n key="IAM.ALLOWEDIP.TOIP.ADDRESS"/></div>
								</div>
								<!-- <div id="range_container" style="display:none;">
										<div id="from_ip_field" class="ip_field_div from_ip"></div>	
										<div id="to_ip_field" class="ip_field_div to_ip"></div>
								</div>  -->
								
								<div class="add_more_ip_range add-circle" onclick="add_more_ip_range('edit_');"></div>
								
							</div>							
						</div>

						<button type="submit" class="primary_btn_check" id="save_edited_button" style="margin-top: 28px;"><span><@i18n key="IAM.SAVE" /> </span></button>

					</div>
					
				</form>
						
			</div>
				
		</div>
		
		<div class="hide popup" tabindex="0" id="popup_ip_new" style="width: 700px; top:100px;">
		
			<div class="popup_header ">
				<div class="popuphead_details">
					<span class="popuphead_text_new"><@i18n key="IAM.ALLOWED.IPADDRESS" /> </span>
				</div>
				<div class="close_btn" onclick="close_new_ip_popup()"></div>
			</div>
			<div class="popuphead_warning">
				<span class="popup_icon_warn icon-warningfill"></span>
				<span class="popuphead_warninfas"><@i18n key="IAM.ADD.ALLOWEDIP.DEFINITION" />  <br /><span class="ip_impt_note"><@i18n key="IAM.IMPT.NOTE" /></span></span>
			</div>
			<div id="ip_new_info" class="popup_padding">				
				<form name ="addip"  id="allowedipform" onsubmit="return addipaddress(this)">					
					<div id="get_ip">
						<div class="field" id="ip_name_container">
							<div class="textbox_label"><@i18n key="IAM.IP.NAME" /></div>
							<input type="text" class="textbox" tabindex="1" autocomplete="off" name="ip_name" id="ip_name" data-limit="100">
							<div class="textbox_tip"><i><@i18n key="IAM.TFA.PASSKEY.CONFIGURATION.NAME.DESC" /></i></div>
						</div>
						<div id="current_ip" class="radiobtn_div hide">
							<input class="real_radiobtn photo_radio" checked="checked" type="radio" name="ip_select" id="current_ip_sel" value="1">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
							<label for="current_ip_sel" class="radiobtn_text_new"><@i18n key="IAM.IP.ADD.CURRENT" /><label>
						</div>
						<div id="show_current_ip" class="hide ip_cell_parent">
							<div class="current_ip_desc"><@i18n key="IAM.IP.CURRENT.IP.DESC"/></div>
						</div>
						<input type="hidden" id="cur_ip" name="cur_ip" value=""/> 
							
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ip_select" id="static_ip_sel" value="2">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
							<label for="static_ip_sel" class="radiobtn_text_new"><@i18n key="IAM.IP.ADD.STATIC" /> </label>
						</div>						
						<div id="static_ip" class="hide ip_cell_parent">
							<div class="static_ip_desc"><@i18n key="IAM.IP.STATIC.IP.DESC"/></div>							
							<div class="static_ip_container">
								<div class="heading"><@i18n key="IAM.IPADDRESS"/></div>
								<div id="static_ip_field_0" class="ip_field_div"></div><div class="add_more_static_ip add-circle" onclick="add_more_ip();"></div>
							</div>
						</div>
							
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" name="ip_select" id="range_ip_sel" value="3">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
							<label for="range_ip_sel" class="radiobtn_text_new"><@i18n key="IAM.IP.ADD.RANGE" /> </label>
						</div>
						<div id="range_ip" class="ip_cell_parent hide">
							<div class="range_ip_desc"><@i18n key="IAM.IP.RANGE.IP.DESC"/></div>
							<div class="range_ip_container">
								<div class="heading_container">
									<div class="heading"><@i18n key="IAM.ALLOWEDIP.FROMIP.ADDRESS"/></div>								
									<div class="heading" style="margin-left: 14px;"><@i18n key="IAM.ALLOWEDIP.TOIP.ADDRESS"/></div>
								</div>
								<!-- <div id="range_container" style="display:none;">
										<div id="from_ip_field" class="ip_field_div from_ip"></div>	
										<div id="to_ip_field" class="ip_field_div to_ip"></div>
								</div>  -->
								<div id="range_container_0" class="range_field_div">
										<div id="from_ip_field_0" class="ip_field_div from_ip"></div>	
										<div id="to_ip_field_0" class="ip_field_div to_ip"></div>									
								</div>
								<div class="add_more_ip_range add-circle" onclick="add_more_ip_range();"></div>
								
							</div>							
						</div>

						<button type="submit" tabindex="1" class="primary_btn_check " style="margin-top: 28px;"><span><@i18n key="IAM.NEXT" /> </span></button>

					</div>
					
					<div class="hide" id="session_type">
						
						<div class="preview_ip">
							<div class="left_container">
								<div class="info_lable preview_lable"><@i18n key="IAM.IP.NAME" /> </div>
								<div class="info_value" id="given_ip_name"></div>
							</div>
							<div class="right_container">
								<div class="info_lable preview_lable"><@i18n key="IAM.IP.YOUR.ADDRESS" /> </div>
								<div class="info_value" id="given_ip_address"></div> 
							</div>
							<div class="edit_ip" onclick="edit_new_ip()">
								<span class="ip_blue"><@i18n key="IAM.EDIT" /></span>
							</div>
						</div>
						<div class="session_container">
							<span class="sessions_heading"><@i18n key="IAM.ALLOWEDIP.APPLICABLE.TO"/></span>
							<div class="sessions">
								<div style="display: flex;">
									<div>
										<input id="browser_session" class="checkbox_check" type="checkbox" style="left: 47px;">
										<span class="checkbox">
											<span class="checkbox_tick"></span>
										</span>
									</div>
									<label for="browser_session" class="checkbox_label" style="line-height: 15px; margin-left: 10px;">
										<span style="font-weight: 500;"><@i18n key="IAM.ALLOWEDIP.BROWSER.SESSION"/></span>
										<span style="width: unset; max-width: 460px;" class="session_desc"><@i18n key="IAM.ALLOWEDIP.BROWSER.SESSION.DESC"/></span>
										
									</label>
								</div>
								<div style="margin-top: 20px; display: flex;">
									<div>
										<input id="imap_session" class="checkbox_check" type="checkbox" style="left: 47px;">
										<span class="checkbox">
											<span class="checkbox_tick"></span>
										</span>
									</div>
									<label for="imap_session" class="checkbox_label" style="line-height: 15px; margin-left: 10px;">
										<span style="font-weight: 500;"><@i18n key="IAM.ALLOWEDIP.IMAP.SESSION"/></span>
										<span style="width: unset; max-width: 460px;" class="session_desc"><@i18n key="IAM.ALLOWEDIP.IMAP.SESSION.DESC"/></span>
									</label>
								</div>
							</div>
						</div>
			    		<input type="text" class="ip_hide" name="iplist" id="iplist"/>
			    		<button type="submit" class="primary_btn_check " ><span><@i18n key="IAM.ALLOWEDIP.ADD.IP.ADDRESS" /> </span></button>
					</div>
					
					<div class="hide" id="">
						
						<div class="info_div">
							<div class="info_lable"><@i18n key="IAM.IP.YOUR.ADDRESS" /> </div>
							<div class="info_value" id="ip_range_forNAME"></div>
						</div>
						
						<div class="field full">
							<div class="textbox_label "><@i18n key="IAM.IP.NAME" /> </div>
							<input class="textbox" data-optional=true data-validate="zform_field" tabindex="0" name="ip_name" id="ip_name_test" type="text">
						</div>
						
						<input type="text" class="ip_hide" data-validate="zform_field" name="fip" autocomplete="address-line1" id="fip"/>
						<input type="text" class="ip_hide" data-validate="zform_field" name="tip" autocomplete="address-line2" id="tip"/>
						
						<div id="" style="display: block;">
			    			
			    			<button class="primary_btn_check" tabindex="0"  id="add_new_ip"><span><@i18n key="IAM.ADD" /> </span></button>
							<button class="primary_btn_check high_cancel" tabindex="0" id="ip_name_bak" onclick="return back_to_addip();"><span><@i18n key="IAM.BACK" /> </span></button>

				
			    		</div>
			    		
					</div>
					
				</form>
						
			</div>
				
		</div>	
		
		
		<div class="box big_box" id="AllowedIP_box">
		
			<div class="box_blur"></div>
			<div class="loader"></div>
			
			<div class="box_info">
				<div class="box_head"><@i18n key="IAM.ALLOWED.IPADDRESS" /><span class="icon-info"></span></div>
				<div class="box_discrption"><@i18n key="IAM.ALLOWED_IP.DEFINITION" /> </div>
			</div>
			
			<div id="all_ip_show">
				<div id="org_iprest_warn" style="display:none;"><span class="icon_warnn icon-warningfill"></span><span class="iprestrict_msg"></span></div>
				<div id="no_ip_add_here" class="box_content_div">
					<div class="no_data no_ip"></div>
					<div class="no_data_text hide"><@i18n key="IAM.ALLOWEDIP.IP_NODISPLAY" /></div>
					<button type="submit" class="primary_btn_check center_btn" onclick="add_new_ip_popup();" id="allowedip_change"><span><@i18n key="IAM.ALLOWEDIP.ADD.BUTTON" /> </span></button>
		 		</div>
		 		
		 		<div id="IP_content" class="hide">
		 		
		 			<div class="allowed_ip_entry always_hover not_included_current hide" id="allowed_ip_entry0">
					
						<div class='alone_current_ip'></div>
						
						<div class="asession_action current ip_add_btn"><@i18n key="IAM.ADD" /> </div>
							
							<div class="aw_info" id="allowed_ip_info0">
								
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.IP.YOUR.ADDRESS" /> </div>
									<div class="info_value" id="ip_range_forNAME"></div>
								</div>
								
								<div class="field full">
										<div class="textbox_label "><@i18n key="IAM.IP.NAME" /> </div>
										<input class="textbox " name="ip_name" id="new_ip_name" type="text">
								</div>
								
								<div class="primary_btn_check" id="add_current_ip" style="display:inline-block;"><@i18n key="IAM.ADD" /> </div>							
							
							</div>
							
					</div>
					
					<div id="IPdisplay_others">
		        
					</div>
						
		 		
		 		</div>
		 		
			</div>

	 		<div id="IP_add_view_more" class="hide">
					<div class="view_more half" onclick="show_all_ip()"><span><@i18n key="IAM.VIEWMORE.IP" /></span></div>   
					<div class="addnew half " onclick="add_new_ip_popup();" ><@i18n key="IAM.ALLOWEDIP.ADD.BUTTON" /></div>
			</div>
				
			<div class="addnew hide" id="ip_justaddmore" onclick="add_new_ip_popup();" ><@i18n key="IAM.ALLOWEDIP.ADD.BUTTON" /></div>	
					
		</div>
				
		<div class="hide viewall_popup popupshowanimate_2" id="allow_ip_web_more" tabindex="0" >
			<div class="menu_header">
				<div class="box_info">
					<div class="expand_closebtn" onclick="closeview_all_ip_view()"></div>
					<div class="box_head"><@i18n key="IAM.ALLOWED.IPADDRESS" /><span class="icon-info"></span> </div>
					<div class="box_discrption"><@i18n key="IAM.ALLOWED_IP.DEFINITION" /></div>
				</div>
				
			</div>
			
			<div id="view_all_allow_ip" class="all_elements_space"></div>
		</div>
		
		 
		<div id="empty_ip_format" class="hide">
		
			<div class="allowed_ip_entry" id="allowed_ip_entry">

				<div class="info_tab">	
					<div class="device_div">
						<span class="device_pic"></span>
						<span class="device_details">
							<div class="device_name">
								<span id="range_name"></span>
								<span id="ip_pencil"></span>
							</div>
							<div class="device_ip"></div>
							
						</span>
					</div>
					
					<div class="activesession_entry_info">

						<div class=session_type_info>
							<div class="browser_session" style="display:none">
								<div class="browser_dot"></div>
								<div style="margin-left: 4px; margin-right: 12px;"><@i18n key="IAM.ALLOWEDIP.SESSION.BROWSER" /></div>
							</div>
							<div class="imap_session" style="display:none">
								<div class="imap_dot"></div>
								<div style="margin-left: 4px; margin-right: 12px;"><@i18n key="IAM.ALLOWEDIP.SESSION.IMAP" /></div>								
							</div>
						</div>
						
						
						
						<div class="asession_action ip_delete"><div class="icon-delete"></div></div>
						<div class="asession_action ip_edit" onclick="edit_selected_ip('',event);"><div class="icon-edit"></div><span><@i18n key="IAM.EDIT" /></span></div>
					</div>
					
				</div>
				
				<div class="aw_info" id="allowed_ip_info">
					
					<div class="info_container">
						<div class="left_box">
							<div class="info_lable "><@i18n key="IAM.IP.NAME" /> </div>
							<div class="info_value" id="pop_up_ip_name"></div>
							
							<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.ALLOWED.IPADDRESS" /> </div>
									<div class="info_value range hide"  ></div>
									<div class="info_value static hide" ></div>
							</div>
						</div>
						<div class="right_box">
							
							<div class="info_lable"><@i18n key="IAM.ALLOWEDIP.ADDED.ON" /> </div>
							<div class="info_value" id="pop_up_time"></div>
							
							<div class="info_div hide" id="session_info">
								<div class="info_lable"><@i18n key="IAM.ALLOWEDIP.APPLICABLE.TO" /> </div>
								<div class="info_value" id="session_type_info"></div>
							</div>
						</div>
					</div>
					
					<!-- 
					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.USERSESSIONS.STARTED.TIME" /> </div>
						<div class="info_value" id="pop_up_time"></div>
					</div>

					<div class="info_div">
						<div class="info_lable"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /> </div>
							<div class="info_value unavail" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /> </div>
				
							<div class="info_ip"></div>
					</div>  -->
					
					<a class="primary_btn_check negative_btn_red" tabindex="1" id="current_session_logout"><span><@i18n key="IAM.ALLOWEDIP.DELETE.IP" /></span></a>
				</div>
				
				<div class="aw_info_rename" id="allowed_ip_info_rename">
				</div>
				
			</div>
			
		</div>
				
		