<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
	<script>
		 var i18nGeofencingkeys = {
 				"IAM.CHOOSE.COUNTRIES" : '<@i18n key="IAM.CHOOSE.COUNTRIES" />',
 				"IAM.LAST.CHANGED" : '<@i18n key="IAM.LAST.CHANGED" />',
 				"IAM.ERROR.FIELD.SELECT.LEAST" : '<@i18n key="IAM.ERROR.FIELD.SELECT.LEAST" />',
 				"IAM.SETTINGS.AUTHORIZED.SECONDS.AGO" : '<@i18n key="IAM.SETTINGS.AUTHORIZED.SECONDS.AGO" />',
 				"IAM.GEOFENCING.SELECTED.COUNTED" : '<@i18n key="IAM.GEOFENCING.SELECTED.COUNTED" />',
 				"IAM.GEOFENCING.ERROR.SELECT.COUNTRY" : '<@i18n key="IAM.GEOFENCING.ERROR.SELECT.COUNTRY" />',
 				"IAM.GEOFENCING.ERROR.SELECT.ALLOW" : '<@i18n key="IAM.GEOFENCING.ERROR.SELECT.ALLOW" />',
 				"IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY" : '<@i18n key="IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY" />',
 				"IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE" : '<@i18n key="IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE" />',
 				"IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY" : '<@i18n key="IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY" />',
 				"IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE" : '<@i18n key="IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE" />',
 				"IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.RESTRICTED.LIST.ERROR" : '<@i18n key="IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.RESTRICTED.LIST.ERROR" />',
 				"IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.ALLOWED.LIST.ERROR" : '<@i18n key="IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.ALLOWED.LIST.ERROR" />' 
		};
	</script>

	<div class="hide popup" tabindex="0" id="popup_geofencing">
	
		<div class="popup_header ">
			<div class="popuphead_details">
				<span class="popuphead_text"><@i18n key="IAM.GEOFENCING" /> </span>
			</div>
			<div class="close_btn" onclick="closeGeoFencingAddPopup()"></div>
		</div>
		<div class="yellow_desc" id="geofencing_desc_msg" style="">
			<div class="icon-warningfill alert_icon_medium"></div>
			<div class="password_usecases_info"><@i18n key="IAM.GEOFENCING.YELLOW.TAB.TEXT" /></div>
		</div>
		<div id="" class="popup_padding" style="padding-top:24px;">
			<form name ="geofencing_form"  id="geofencing_form" onsubmit="return false;">
				<div id="get_geofencing_data">
					<div id="country_field_cont">
						<div class="textbox_label"><@i18n key="IAM.COUNTRY.TITLE" /></div>
						<select id="country_list_for_geo_fencing" onchange="remove_error();setValueInSelectedList();" multiple embed-icon-class="flagIcons" searchable="true">
                      		<#list Countries as countrydata>
                      			<option value="${countrydata.getISO2CountryCode()}" id="${countrydata.getISO2CountryCode()}" >${countrydata.getDisplayName()}</option>
                       		</#list>
						</select>
					</div>
					<div class="option_for_geo_fencing">
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" onchange="remove_error()" type="radio" name="geo_fencing_value" id="allow_access" value="1">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
							<label for="allow_access" class="radiobtn_text"><@i18n key="IAM.GEOFENCING.ACCESS.ALLOW" /> </label>
						</div>	
							
						<div class="radiobtn_div">
							<input class="real_radiobtn photo_radio" type="radio" onchange="remove_error()" name="geo_fencing_value" id="restrict_access" value="0">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
							<label for="restrict_access" class="radiobtn_text"><@i18n key="IAM.GEOFENCING.ACCESS.RESTRICT" /> </label>
						</div>
					</div>
					<button type="submit" class="primary_btn_check " onclick="go_next_to_enableGeofencing()" ><span><@i18n key="IAM.NEXT" /> </span></button>
					<button class="primary_btn_check high_cancel" onclick="resetForm()" ><span><@i18n key="IAM.RESET" /> </span></button>
					<button class="primary_btn_check red_btn hide" id="geo_fencing_delete" onclick="popupBlurHide('#popup_geofencing',function(){show_confirm('<@i18n key="IAM.REMOVE.GEOFENCING"/>','<@i18n key="IAM.REMOVE.GEOFENCING.CONFORMATION"/>',function(){deleteGeoFencing()},function(){setTimeout(function(){showGeoFencingPopup(true)},300)})},true)" style="margin-right: 0px;float: right;"><span><@i18n key="IAM.DELETE" /> </span></button>
				</div>
				
				<div id="show_selected_view" class="hide">
					<div class="show_selected_value">
						<div class="grey_header allowed_header"><@i18n key="IAM.GEOFENCING.ALLOWED.COUNTRIES" /> </div>
						<div class="grey_header restricted_header"><@i18n key="IAM.GEOFENCING.RESTRICTED.COUNTRIES" /> </div>
						<div class="selected_country_list" style="margin-bottom: 16px;">
							<div class="country_listing_container"></div>
							<span class="blue_link" style="margin-bottom: 12px;font-size:12px;display:none;" onclick="$('.country_listing_container').addClass('show_full_list');$(this).hide();"></span>
						</div>
					</div>
					
					<div class="applicable_types" id="applicable_types">
						<div class="grey_header"><@i18n key="IAM.GEOFENCING.APPLICABLE.TO.HEADER" /> </div>
						<div class="textbox_div" id="" >
							<input id="geo_browser_session" name="browser_session" onchange="remove_error()" class="checkbox_check" type="checkbox" value="0" checked>
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="geo_browser_session" class="checkbox_label">
								<div><@i18n key="IAM.GEOFENCING.APPLICABLE.TO.BROWSER" /></div>
								<div class="desc_abt_checkbox"><@i18n key="IAM.GEOFENCING.APPLICABLE.TO.BROWSER.DESC" /></div>
							</label>
						</div>
						<div class="textbox_div" id="" >
							<input id="pop_imap" name="pop_imap" onchange="remove_error()" class="checkbox_check" type="checkbox" value="1">
							<span class="checkbox">
								<span class="checkbox_tick"></span>
							</span>
							<label for="pop_imap" class="checkbox_label">
								<div><@i18n key="IAM.GEOFENCING.APPLICABLE.TO.POP.IMAP" /></div>
								<div class="desc_abt_checkbox"><@i18n key="IAM.GEOFENCING.APPLICABLE.TO.POP.IMAP.DESC" /></div>
							</label>
						</div>
					</div>
					<button type="submit" class="primary_btn_check " onclick="enableGeofencing()" ><span><@i18n key="IAM.TURN.ON.TFA" /> </span></button>
					<button type="submit" class="primary_btn_check high_cancel" onclick="go_back_to_choose_country()"><span><@i18n key="IAM.BACK" /> </span></button>
				</div>
			</form>
		</div>
	</div>	




	<div class="box big_box" id="geofencing_box">
		<div class="box_blur"></div>
		<div class="loader"></div>

		<div class="box_info header_for_no_data">
			<div class="box_head"><@i18n key="IAM.GEOFENCING" /><span class="icon-info"></span></div>
			<div class="box_discrption"><@i18n key="IAM.GEOFENCING.TAB.DESC" /> </div>
		</div>
		
		<div id="empty_geofencing">
				<div id="no_geofencing_add_here" class="box_content_div">
					<div class="no_data no_geofencing"></div>
					<button type="submit" class="primary_btn_check center_btn" onclick="showGeoFencingPopup()" id="set_geofencing"><span><@i18n key="IAM.GEOFENCING.ENABLE.BUTTON" /> </span></button>
		 		</div>
		</div>
		
		<div class="box_info flex_container" id="geofencing_stored_data">
			<div class="password_name_and_time">
				<div class="box_head"><@i18n key="IAM.GEOFENCING" /></div>
				<div class="box_discrption" id="modified_time" style="">Last changed  1 year ago</div>
			</div>
			<div class="access_option">
				<span class="info_tag blue_tag"><@i18n key="IAM.GEOFENCING.TAG.BROWSER" /></span>
				<span class="info_tag organge_tag"><@i18n key="IAM.GEOFENCING.TAG.POP.IMAP" /></span>
			</div>
			<div class="password_button_and_tip">
				<button class="primary_btn_check center_btn " id="edit_geo_fencing_button" onclick="showGeoFencingPopup(true)"><@i18n key="IAM.GEOFENCING.BUTTON.EDIT" /></button>
			</div>
		</div>
		<div class="no_data_text box_bottom_content" id="usecase_abt_geofencing" style="background:#F3F3F3;padding: 12px 16px;">
			<div class="flag_list"></div>
			<div class="overflow_count hide">
				<div class="plus_count"></div>
				<div class="overflow_list">
					<div class="head_for_country_action">
						<div class="allowed hide"><@i18n key="IAM.GEOFENCING.ALLOWED.COUNTRIES" /></div>
						<div class="restricted show"><@i18n key="IAM.GEOFENCING.RESTRICTED.COUNTRIES" /></div>
					</div>
					<div class="country_list"></div>
					<div class="overflow_edit_btn" onclick="showGeoFencingPopup(true)"><@i18n key="IAM.GEOFENCING.BUTTON.EDIT" /></div>
				</div>
			</div>
			<div class="usecases_info"></div>				
		</div>

	</div>