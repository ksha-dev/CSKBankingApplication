<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<html>
    <head>
    	<script>
			var states_details =${States};
		</script>
    </head>

    <body>


			<div class="box profile_box">
                <button class="primary_btn_check right_btn circlebtn_mobile_edit onlyweb " id="editprofile" onclick="return editProfile();" ><span><@i18n key="IAM.EDIT" /></span></button>
				
				<div class="profile_head">
					<div class="profile_pic_container">
						<div class="profile_dp icon-camera" id="profile_img" onclick="showProPicOptions(this);">
							<div class="dp_pic_blur_bg"></div>
							<label id="file_lab">
								<img onload="setPhotoSize(this)" id="dp_pic" draggable=false>
							</label>
						</div>
						<select name="photo_permission" id="profile_photoview_permi" class="visibleMobilesSelect customised_select" onchange=new_save_photoview_permi(this.value) size="medium"> 
							<option value="3" id="Zohousers"><@i18n key="IAM.PHOTO.PERMISSION.ZOHO_USERS" /></option>
							<option value="2" id="mprofile"><@i18n key="IAM.PHOTO.PERMISSION.CHAT_CONTACTS" /></option>
							<#if (is_org_user)>
								<option value="1" id="morg"><@i18n key="IAM.PHOTO.PERMISSION.ORG_USERS" /></option>
							</#if>
							<option value="4" id="domain"><@i18n key="IAM.PHOTO.PERMISSION.EVERYONE" /></option>
							<option value="0" id="mprivacy"><@i18n key="IAM.PHOTO.PERMISSION.ONLY_MYSELF" /></option>
	                	</select>
					</div>
					<div class="profile_option_parent hide">
						<div class="profile_pic_option">
							<div id="upload_option" onclick="openUploadPhoto('user','0')"><@i18n key="IAM.UPLOAD.NEW"/></div>
				   			<!--<div id="edit_option" onclick="editProPicture()"><@i18n key="IAM.EDIT"/></div> -->
				   			<div id="remove_option" onclick="removePicture('<@i18n key="IAM.PHOTO.DELETE.POPUP.HEADER"/>','<@i18n key="IAM.PHOTO.DELETE.POPUP.DESCRIPTION"/>')" style="color:#FF5F5F"><@i18n key="IAM.REMOVE"/></div>
						</div>
					</div>
					<div class="profile_info">
						<div class="profile_name"id="profile_name"></div>
						<div class="profile_email"id="profile_email"></div>
					</div>
				</div>
				<form id="locale" name="locale" onsubmit="return saveProfile(this);">
					<div class="profileinfo_form" tabindex="0">
						
						<div class="textbox_div textbox_inline editmode" id="Full_Name">
							<label class="textbox_label"><@i18n key="IAM.FULL.NAME" /></label>
							<input type="text" class="textbox profile_mode" autocomplete="name" id="profile_name_edit" data-limit="100" disabled>
						</div>
						
						<div class="textbox_div textbox_inline editmode field hide" id="First_Name" >
							<label class="textbox_label"><@i18n key="IAM.FIRST.NAME" /><span class="mandate_field_star">&#42;</span></label>
							<input type="text" class="textbox profile_mode" tabinex="0" autocomplete="Fname" data-validate="zform_field" id="profile_Fname_edit" onkeypress="remove_error();checkMaxLimit(this);" oninput="remove_error()" name="first_name" data-limit="100"  disabled>
						</div>
						
						<div class="textbox_div textbox_inline editmode field hide" id="Last_Name">
							<label class="textbox_label"><@i18n key="IAM.LAST.NAME" /></label>
							<input type="text" class="textbox profile_mode" tabindex="0" data-optional="true" autocomplete="Lname" data-validate="zform_field" id="profile_Lname_edit" onkeypress="remove_error();checkMaxLimit(this);" oninput="remove_error()" name="last_name" data-limit="100"  disabled>
						</div>
						
						<div class="textbox_div textbox_inline editmode field">
							<label class="textbox_label"><@i18n key="IAM.GENERAL.DISPLAYNAME" /></label>
							<input type="text" oninput='showEmptyTooltip(this);remove_error(); 'class="textbox profile_mode" tabindex="0" data-optional="true" onkeypress="remove_error();checkMaxLimit(this);" id="profile_nickname" autocomplete="name" data-validate="zform_field" name="display_name" data-limit="100"  disabled>
							<div class="nickname_info"><@i18n key="IAM.PROFILE.DISPLAY.NAME.TOOLTIP"/></div>
						</div>
						
						<div class="field textbox_div textbox_inline editmode">					
							<select class="profile_mode" id="gender_select" label="<@i18n key="IAM.GENDER" />" data-validate="zform_field" name="gender" width="320px" disabled> 
								<option value="1" id="male_gender"><@i18n key="IAM.GENDER.MALE" /></option>
								<option value="0" id="female_gender"><@i18n key="IAM.GENDER.FEMALE" /></option>
								<option value="2" id="other_gender"><@i18n key="IAM.GENDER.OTHER" /></option>
								<option value="3" id="non_binary_gender"><@i18n key="IAM.GENDER.NON_BINARY" /></option>
	                        </select>
						</div>
						
						<div class="field textbox_div textbox_inline editmode">                             
                          	<select class="profile_mode" label="<@i18n key="IAM.COUNTRY" />" data-validate="zform_field" autocomplete='country-name' name="country" id="localeCn" disabled onchange="check_state()" embed-icon-class="flagIcons" searchable="true" width="320px">
                          		<#list Countries as countrydata>
                          			<option value="${countrydata.getISO2CountryCode()}" id="${countrydata.getISO2CountryCode()}" >${countrydata.getDisplayName()}</option>
                           		</#list>
                            </select>
                        </div>
                        
                        <div id="gdpr_us_state" class="hide field textbox_div textbox_inline editmode"> 
                          	<select class="profile_mode" label="<@i18n key="IAM.GDPR.DPA.ADDRESS.STATE" />" data-validate="zform_field" autocomplete='state-name' name="state" id="localeState" disabled searchable="true" width="320px">
								<option value="" id="default_state" disabled selected><@i18n key="IAM.US.STATE.SELECT" /></option>
                            </select>
                        </div>
						
						
						<div class="field textbox_div textbox_inline editmode">
							<select class="profile_mode" label="<@i18n key="IAM.LANGUAGE" />" data-validate="zform_field" name="language" id="localeLn" disabled searchable="true" width="320px">
								<#list Languages as Languagedata>
									<option value="${Languagedata.getLanguageCode()}"  id="${Languagedata.getLanguageCode()}" data-text="<#if Languagedata.getDefaultDisplayName()?has_content>  ${Languagedata.getDefaultDisplayName()} </#if>">${Languagedata.getDisplayName()}</option>
                           		</#list>
                            </select>
      					</div>
						
                        
						<div class="field textbox_div timezone_list textbox_inline editmode">
							<select class="profile_mode timezone_select" label="<@i18n key="IAM.TIMEZONE" />" data-validate="zform_field" name="timezone" id="localeTz" searchable="true" width="400px" disabled>
								<#list TimeZones as TimeZonedata>
                          			<option value="${TimeZonedata.getId()}" id="${TimeZonedata.getId()}" >(GMT ${TimeZonedata.getGMTString()}) ${TimeZonedata.getDisplayName()} ( ${TimeZonedata.getId()} )	</option>
                           		</#list>
                            </select>
                             <input id="timezone_show_type" style="display:none" class="checkbox_check" type="checkbox"/>
                             <div class="checkbox_div hide" style="display:none" id="displayall_timezone" >
								<input id="timezone_toggle" onchange="showZoneAfterCheck()" class="checkbox_check" type="checkbox"/>
								<span class="checkbox">
									<span class="checkbox_tick"></span>
								</span>
								<label for="timezone_toggle" class="checkbox_label"><@i18n key="IAM.PROFILE.LANGUAGE.DISPLAY.ALL" /></label>
							</div>
                        </div>
                        



						<div class="primary_btn_check circlebtn_mobile_edit onlymobile" id="editonmobile" onclick="return editProfile();" ><span><@i18n key="IAM.EDIT" /></span></div>

													
	                    <div id="savebtnid" class="hide">	            			
	            			<button class="primary_btn_check " tabindex="0" id="saveprofile" ><span><@i18n key="IAM.SAVE" /></span></button>
							<button class="primary_btn_check high_cancel" tabindex="0" id="undo_changes" onclick="return undochanges();"><span><@i18n key="IAM.CANCEL" /></span></button>
	            		</div>
					
					</div>
					
				</form>
				
				<select class="hide" name="country_Tz" id="country_Tz"  type="hidden" disabled>
					<#list CurrentTimeZonesList as CurrentTimeZonedata>
              			<option value="${CurrentTimeZonedata.zone_code}" id="${CurrentTimeZonedata.zone_code}" >${CurrentTimeZonedata.zone_name}</option>
               		</#list>
            	</select>	
            	
			</div>
                
                
    </body>
</html>
