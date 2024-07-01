<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<html>
    <head>
    	<script>
			var states_details =${States};
			var i18KeysPersonalDetails = {
					"IAM.ZOHO.REBRAND" : '<@i18n key="IAM.ZOHO.REBRAND" />'
			};
		</script>
    </head>

    <body>
	    <div id="photo_container" class="photo_container" tabindex="1">
	    	<div class="photo_loader"></div>
	    	<div class="photo_blur_dp1"></div>
	    	<img id="photo_blur_dp2" class="photo_blur_dp2">
	    	<img id="photo_original_dp" class="photo_original_dp" onload="showImage(this)">
	    </div>
    	<div id="profile_pic_visibility_popup" tabindex="1" class="hide popup pop_anim">
    		<div class="visibility_main_wrapper">
    		<div class="popup_header">
    			<div class="popuphead_details">
    				<span class="popuphead_text"><@i18n key="IAM.PROFILE.PICTURE.VISIBILITY"/></span>
    			</div>
    			<div class="close_btn" onclick="closePhotoVisiabilityPopup()"></div>
    		</div>
    		<div class="visibility_popup_padding">
    		<div class="popup_padding">
    			<div class="popuphead_details">
    				<span class="visibility_select_text"><@i18n key="IAM.SETTINGS.PHOTOVIEW.DESCRIPTION"/></span>
    			</div>
    			<div class="visibility_option_boxes">
	    			<label class="zohousers-class" for="zohousers">
	    				<div class="visibility_option_box">
	    					<div class="option_icon">
		    					<span class="path1"></span>
		    					<span class="path2"></span>
		    					<span class="path3"></span>
		    					<span class="path4"></span>
		    					<span class="path5"></span>
		    					<span class="rebrand-text"></span>
	    					</div>
	    					<div class="option_text">
	    						<div class="option_text_heading"><@i18n key="IAM.PHOTO.PARTNER.USERS"/></div>
	    						<div class="option_text_description"><@i18n key="IAM.PHOTO.PARTNER.USERS.DESC"/></div>
	    					</div>
	    					<input class="real_radiobtn" type="radio" name="visibility_radiobtn" id="zohousers" value="3">
	    					<div class="outer_circle">
	    						<div class="inner_circle"></div>
							</div>
	    				</div>
	    			</label>
	    			<label for="zohocontacts">
	    				<div class="visibility_option_box">
	    					<div class="option_icon icon-mprofile"></div>
	    					<div class="option_text">
	    						<div class="option_text_heading"><@i18n key="IAM.PHOTO.MY.CONTACTS"/></div>
	    						<div class="option_text_description"><@i18n key="IAM.PHOTO.MY.CONTACTS.DESC"/></div>
	    					</div>
	    					<input class="real_radiobtn" type="radio" name="visibility_radiobtn" id="zohocontacts" value="2">
	    					<div class="outer_circle">
	    						<div class="inner_circle"></div>
							</div>
	    				</div>
	    			</label>
	    			<#if (is_org_user)>
		    			<label for="zohomorg">
		    				<div class="visibility_option_box">
		    					<div class="option_icon icon-morg"></div>
		    					<div class="option_text">
		    						<div class="option_text_heading"><@i18n key="IAM.PHOTO.MY.ORGANIZATION"/></div>
		    						<div class="option_text_description"><@i18n key="IAM.PHOTO.MY.ORGANIZATION.DESC"/></div>
		    					</div>
		    					<input class="real_radiobtn" type="radio" name="visibility_radiobtn" id="zohomorg" value="1">
		    					<div class="outer_circle">
		    						<div class="inner_circle"></div>
								</div>
		    				</div>
		    			</label>
	    			</#if>
	    			<label for="zohoeveryone">
	    				<div class="visibility_option_box">
	    					<div class="option_icon icon-domain"></div>
	    					<div class="option_text">
	    						<div class="option_text_heading"><@i18n key="IAM.PHOTO.ANYONE"/></div>
	    						<div class="option_text_description"><@i18n key="IAM.PHOTO.ANYONE.DESC"/></div>
	    					</div>
	    					<input class="real_radiobtn" type="radio" name="visibility_radiobtn" id="zohoeveryone" value="4">
	    					<div class="outer_circle">
	    						<div class="inner_circle"></div>
							</div>
	    				</div>
	    			</label>
	    			<label for="zohomyself">
	    				<div class="visibility_option_box">
	    					<div class="option_icon icon-mprivacy"></div>
	    					<div class="option_text">
	    						<div class="option_text_heading"><@i18n key="IAM.PHOTO.PERMISSION.ONLY_MYSELF"/></div>
	    						<div class="option_text_description"><@i18n key="IAM.PHOTO.MYSELF.DESC"/></div>
	    					</div>
	    					<input class="real_radiobtn" type="radio" name="visibility_radiobtn" id="zohomyself" value="0">
	    					<div class="outer_circle">
	    						<div class="inner_circle"></div>
							</div>
	    				</div>
	    			</label>
    			</div>
    		</div>
    		</div>
    		<div class="visibility_popup_footer">
    			<button id="visibility_change_apply" class="primary_btn_check pref_disable_btn" onclick="applyVisibilityChange()"><span><@i18n key="IAM.PHOTO.APPLY" /></span></button>
    		</div>
    		</div>
    	</div>

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
	                	<span class="drp-down-arrow" style="display: none;"></span>
					</div>
					<div class="profile_option_parent hide">
						<div class="profile_pic_option">
							<div class="profile_pic_option-item" onclick="openUploadPhoto('user','0')">
								<span class="icon-Upload-new"></span>
								<div id="upload_option" ><@i18n key="IAM.UPLOAD.NEW"/></div>
							</div>
							<div class="profile_pic_option-item" onclick="handleViewProfilePicture()">
								<span class="icon-expand_picture"></span>
								<div id="profile_photo_visibility" ><@i18n key="IAM.PHOTO.EXPAND.PICTURE"/></div>
							</div>
							<div class="profile_pic_option-item" onclick="handleProfilePhotoVisibility()">
								<span class="icon-Profilepicturevisibility"></span>
								<div id="profile_photo_visibility" ><@i18n key="IAM.PROFILE.PICTURE.VISIBILITY"/></div>
							</div>
							<div class="profile_pic_option-item" onclick="removePicture('<@i18n key="IAM.PHOTO.DELETE.POPUP.HEADER.MSG"/>','<@i18n key="IAM.PHOTO.DELETE.POPUP.DESC"/>','<@i18n key="IAM.REMOVE"/>')" style="color: #FF2626;">
								<span class="icon-Remove"></span>
								<div id="remove_option"><@i18n key="IAM.REMOVE"/></div>
							</div>
				   			<!--<div id="edit_option" onclick="editProPicture()"><@i18n key="IAM.EDIT"/></div> -->
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
								<option value="" id="default_gender" disabled="" selected=""><@i18n key="IAM.GENDER.DEFAULT" /></option>
								<option value="1" id="male_gender"><@i18n key="IAM.GENDER.MALE" /></option>
								<option value="0" id="female_gender"><@i18n key="IAM.GENDER.FEMALE" /></option>
								<#if (!enableArabCountriesGenderValues)>
								<option value="2" id="other_gender"><@i18n key="IAM.GENDER.OTHER" /></option>
								<option value="3" id="non_binary_gender"><@i18n key="IAM.GENDER.NON_BINARY" /></option>
								</#if>
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
