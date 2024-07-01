<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0" />
<title>
	<#if is_loc_update_case?has_content && is_loc_update_case == true || is_improper_tz_case?has_content && is_improper_tz_case == true>
		<@i18n key="IAM.ANNOUNCEMENT.INVALID.TIMEZONE.TITLE" />
	<#else>
		<@i18n key="IAM.ANNOUN.REVIEW.LOCATION" />
	</#if>
</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<@resource path="/v2/components/css/zohoPuvi.css" />
<style>
@font-face {
  font-family: 'Announce';
  src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/Announcement.eot')}');
  src:  url('${SCL.getStaticFilePath('/v2/components/images/fonts/Announcement.eot')}') format('embedded-opentype'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/Announcement.ttf')}') format('truetype'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/Announcement.woff')}') format('woff'),
    url('${SCL.getStaticFilePath('/v2/components/images/fonts/Announcement.svg')}') format('svg');
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
[class^="icon-"], [class*=" icon-"] {
  font-family: 'Announce' !important;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.icon-Country:before {
  content: "\e907";
}
.icon-pebble:before {
  content: "\e90b";
}
.icon-Timezone:before {
  content: "\e910";
}

</style>

<@resource path="/static/jquery-3.6.0.min.js" />
<@resource path="/v2/components/js/common_unauth.js" />
<@resource path="/v2/components/css/flagIcons.css" />
<@resource path="/v2/components/css/uvselect.css" />
<@resource path="/v2/components/js/flagIcons.js" />
<@resource path="/v2/components/js/uvselect.js" />
<style>
body {
  margin: 0px;
}
.rebrand_partner_logo {
  height: 40px;
  margin-bottom: 20px;
  background: url("${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}") no-repeat;
  background-size: auto 40px;
}
.announcement_heading {
  font-weight: 600;
  font-size: 24px;
  margin-bottom: 10px;
}
.announcement_description {
  font-weight: 400;
  font-size: 16px;
  line-height: 24px;
  color: #000000;
  opacity: 0.8;
  margin-bottom: 30px;
}
.list_dropdown_box {
  width: 298px;
  border: 1px solid #c7c7c7;
  border-radius: 6px;
  margin-bottom: 30px;
  position: relative;
}

.list_dropdown_box_timezone {
  width: 398px;
}
.list_dropdown {
  display: none;
  margin-top: -2px;
  width: 316px;
  max-height: 200px;
  font-size: 15px;
  list-style: none;
  overflow: scroll;
  padding: 0px;
  z-index: 1;
  position: absolute;
  background: #ffffff;
  border: 2px solid #e9e9e9;
  color: #191818;
  border-radius: 2px;
}
.list_dropdown > option {
  padding: 8px 12px;
  width: auto;
  font-size: 15px;
  cursor: pointer;
}
.list_dropdown > option:hover {
  background-color: #f8f8f8;
}
.list_dropdown_box .basic_selectbox,
.list_dropdown_box .basic_selectbox:hover {
  border: none;
  padding-top: 14px;
}
.select_arrow {
  border: solid #dddddd;
  border-width: 0px 2px 2px 0px;
  display: inline-block;
  padding: 3px;
  float: right;
  margin-top: 14px;
}
.down {
  transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
}
.dropdown_label {
  font-size: 11px;
  display: block;
  color: #1389e3;
  pointer-events: none;
  margin-top: 8px;
  margin-left: 12px;
  font-weight: 500;
}
.selected_option_info {
  display: block;
  margin-bottom: 4px;
  cursor: default;
}
.default_value {
  margin-top: 2px;
  font-size: 15px;
}
.select_text {
  display: inline-block;
  width: 80%;
  margin-top: 8px;
  font-size: 15px;
  color: #c1c1c1;
}
.update_profile {
  background: #1389e3;
  border-radius: 4px;
  /* margin-top: 30px; */
  border: none;
  cursor: pointer;
  font-weight: 600;
  font-size: 13px;
  color: #ffffff;
  padding: 12px 28px;
  text-align: center;
}
.update_profile:hover {
  background: #0091ff;
}
.grey_text {
  font-weight: 500;
  font-size: 12px;
  cursor: pointer;
  text-decoration: underline;
  color: #9d9d9d;
  margin-top: 40px;
  float: right;
}
.container {
  display: none;
}
.user_locale_container {
  border: 1px solid #dcdcdc;
  border-radius: 16px;
  margin-bottom: 30px;
}
.container_header {
  padding: 20px;
  border-bottom: 1px solid #dcdcdc;
  font-size: 14px;
  font-weight: 600;
  cursor: default;
  display: flex
}
.container_body {
  padding: 25px 20px;
  font-size: 15px;
}
.edit_text {
  color: #0091ff;
  cursor: pointer;
  margin-left: auto;
  word-break: break-word;
}

.current_country_box {
  margin-bottom: 20px;
}
.current_locale_icon {
  font-size: 14px;
  padding: 8px;
  color: #1389e3;
  border-radius: 12px;
  background-color: rgba(19, 137, 227, 0.06);
  display: inline-block;
  margin-right: 10px;
}
.current_locale_value {
  display: inline-block;
  font-weight: 500;
  opacity: 0.8;
  width: auto;
  line-height: 1.2;
  vertical-align: text-top;
  text-transform: capitalize;
}
.timezone_value {
  width: 80%;
}
.leading_icon {
  margin-left: 14px;
  margin-bottom: 10px;
}
.dropdown_label {
  position: absolute;
  top: 0px;
  z-index: 1;
}
.select_input {
  padding-bottom: 10px;
}
.selectbox_arrow {
  width: 6px;
  height: 6px;
  border: 2px solid #a4a4a4;
  transform: rotate(45deg);
  border-top: none;
  border-left: none;
  margin-top: 6px;
}
.selectbox_arrow b {
  display: none;
}
.error_space {
  position: fixed;
  width: fit-content;
  width: -moz-fit-content;
  left: 0px;
  right: 0px;
  margin: auto;
  border: 1px solid #fcd8dc;
  display: flex;
  align-items: center;
  padding: 18px 30px;
  background: #ffecee;
  border-radius: 4px;
  color: #000;
  top: -180px;
  transition: all 0.3s ease-in-out;
  box-sizing: border-box;
  max-width: 400px;
  z-index: 20;
}
.top_msg {
  font-size: 14px;
  color: #000;
  line-height: 24px;
  float: left;
  margin-left: 10px;
  font-weight: 500;
  font-size: 14px;
  text-align: center;
  line-height: 24px;
  max-width: 304px;
  word-break: break-word;
}
.error_icon {
  position: relative;
  background: #fd395d;
  width: 24px;
  height: 24px;
  box-sizing: border-box;
  border-radius: 50%;
  display: inline-block;
  color: #fff;
  font-weight: 700;
  font-size: 16px;
  text-align: center;
  line-height: 24px;
  flex-shrink: 0;
}
.show_error {
  top: 50px !important;
}
.blur {
  height: 100%;
  width: 100%;
  position: fixed;
  z-index: 2;
  background-color: #000;
  transition: opacity 0.2s ease-in-out;
  opacity: 50%;
  top: 0px;
  left: 0px;
}
.profile_mode {
  display: inline-block;
  border: none;
  outline: none;
  width: 100%;
  background: transparent;
  font-size: 14px;
  /* text-indent: 5px;
	left: -2px;  */
  padding-block: 4px 8px;
  padding-inline: 12px;
  -webkit-appearance: none;
  -moz-appearance: none;
}
.flex-container {
  display: flex;
  max-width: 1200px;
  gap: 50px;
  margin: auto;
}
.illustration-container {
  padding-top: 100px;
  padding-right: 10%;
}
.content_container {
  max-width: 540px;
  padding-top: 80px;
  padding-right: 4%;
  display: inline-block;
  padding-left: 10%;
}
body.result_pop {
  height: auto;
  width: 100%;
  background-color: rgb(252 252 252);
  margin: 0px;
}
.result {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: -1;
  opacity: 0;
  transition: opacity 0.3s ease-in-out;
  background-color: #ffffff;
  padding: 0 10px;
  box-sizing: border-box;
  transition-delay: 0.3s;
}
.result_popup {
  margin: auto;
  height: auto;
  background: #fff;
  box-sizing: border-box;
  padding: 30px;
  border: 1px solid #e5e5e5;
  overflow: hidden;
  border-radius: 16px;
  margin-top: 60px;
  position: relative;
  max-width: 580px;
}
.result .rebrand_partner_logo {
  height: 40px;
  background: url("../images/newZoho_logo.svg") no-repeat;
  background-size: auto 40px;
  margin: auto;
  margin-top: 100px;
  margin-bottom: 20px;
  background-position: center;
}
.pop_bg {
  width: auto;
  height: 50%;
  position: absolute;
  left: 0px;
  right: 0px;
  top: 0px;
  background: transparent linear-gradient(180deg, #00f22214 0%, #ffffff14 100%) 0% 0% no-repeat padding-box;
}
.result_popup .pop_icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  overflow: hidden;
  font-size: 44px;
  position: relative;
  color: #939393;
  margin: 30px auto 16px;
  font-weight: 600;
  background: #4bbf5d;
  box-shadow: inset -3px -3px 0px #00000014;
}
.result_popup .pop_icon:after {
  display: inline-block;
  content: "";
  width: 16px;
  height: 7px;
  border-bottom: 3px solid #fff;
  border-left: 3px solid #fff;
  transform: rotate(-45deg);
  position: absolute;
  top: 13px;
  left: 10px;
}
.result_popup .grn_text {
  text-align: center;
  color: #000000;
  font-weight: 500;
  font-size: 18px;
  font-weight: 600;
}
.result_popup .defin_text {
  text-align: center;
  margin: 10px 0px;
  font-size: 14px;
  line-height: 20px;
}
[class*="_btn"] {
  font: normal normal 600 14px/30px ZohoPuvi;
  padding: 5px 30px;
  border-radius: 4px;
  color: white;
  border: none;
  background: #1389e3 0% 0% no-repeat padding-box;
  cursor: pointer;
}
[class*="_btn"]:hover {
  background-color: #0779cf;
}
.cont_btn {
  display: block;
  margin: auto;
  margin-top: 20px;
}
.cancel_btn {
  background: #f0f0f0;
  color: #000000;
  margin-left: 20px;
}
.cancel_btn:hover {
  background: #ebeaea;
}
.illustration {
  width: 350px;
  height: 350px;
  display: inline-block;
  background: url("${SCL.getStaticFilePath("/v2/components/images/UpdateLocale.svg")}") no-repeat;
  background-size: 350px auto;
}
.mobile_select_container {
  padding-top: 20px;
}
.mobile_uvselect_arrow b {
  top: 0px;
}
.warn_msg {
  color: red;
  position: relative;
  top: -20px;
  display: none;
  font-size: 14px;
}
.remind_later_link {
  margin-top: -26px;
  border-bottom: 1px dashed #9d9d9d;
  font-family: "ZohoPuvi";
  letter-spacing: 0.2px;
  text-decoration: none;
  left: 0px;
  background-color: white;
  position: relative;
  transition: left 0.4s ease-in;
}
.remind_loader {
  left: -20px;
  pointer-events: none;
}
.remind_loader::after {
  content: "";
  display: inline-block;
  position: absolute;
  top: 2px;
  right: 0px;
  z-index: -2;
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-left: 2px solid;
  border-bottom: 2px solid;
  -webkit-animation: load 0.6s infinite linear, anim_r 0.2s 1 forwards ease-in;
  animation: load 0.6s infinite linear, anim_r 0.2s 1 forwards ease-in;
  width: 7px;
  height: 7px;
  border-radius: 50px;
}
@keyframes load {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes anim_r {
  0% {
    right: 0px;
  }
  100% {
    right: -20px;
  }
}
.remind_later_link:hover {
  color: #666666;
}
.hide {
  display: none;
}
.btndisabled {
  opacity: 0.5;
  pointer-events: none;
}
.loader {
  display: inline-block;
  border-radius: 50%;
  width: 8px;
  height: 8px;
  position: relative;
  top: 2px;
  margin-right: 10px;
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-left: 2px solid;
  border-bottom: 2px solid;
  transform: translateZ(0);
  -webkit-animation: load 1s infinite linear;
  animation: load 1s infinite linear;
}
.note {
	font-size: 12px;
	line-height: 20px;
	margin-bottom: 30px;
	color: black;
}
.ip_note{
	font-weight: 400;
	margin-left: 4px;
	opacity: 0.6;
}
@media only screen and (min-width: 435px) and (max-width: 980px) {
  .flex-container {
    padding: 50px 25px 0px 25px;
  }
  .illustration-container {
    display: none;
  }
  .content_container {
    padding: 0;
    margin: auto;
  }
}
@media only screen and (max-width: 435px) {
  .flex-container {
    padding: 50px 20px 0px 20px;
  }
  .content_container {
    width: 100%;
    padding: 0;
  }
  .illustration-container {
    display: none;
  }
  button,
  delete-popup,
  .otp_input_container {
    width: 100%;
  }
  .remind_me_later {
    display: block;
    width: max-content;
    margin: auto;
  }
  .succfail-btns {
    flex-direction: column;
  }
  .back_btn,
  .cancel_btn {
    margin-left: 0;
    margin-top: 30px;
  }
  .list_dropdown_box {
    width: auto;
  }
  .update_profile {
    width: 100%;
  }
  .remind_later_link {
    float: unset;
    top: 30px;
    margin: auto;
    display: block;
    width: max-content;
  }
  .cancel_btn {
    margin-top: 30px;
    margin-left: 0;
    width: 100%;
  }
}
</style>
<script>
var csrfParam= '${za.csrf_paramName}='+euc(getCookie('${za.csrf_cookieName}'));
var csrfCookieName = "${za.csrf_cookieName}";
var contextpath = <#if context_path??>"${za.context_path}"<#else> "" </#if>;
var country_list = ${country_list};
var country_codes = ${country_codes};
var country_states = ${states};
var timezone_list = <#if timezone_list?has_content>${timezone_list}<#else> "" </#if>
var isMobile = ${isMobile?c};
<#if remindme_url??>var remindme = '${Encoder.encodeJavaScript(remindme_url)}'</#if>


var current_country_code, current_timezone_arr, current_country_name, current_timezone, current_state_name, user_country_name, user_timezone,user_state_val, user_country_code, timezone_gmt_id = "", statesForCountry = [], is_state_needed = false, is_timezone_update_needed = false;

is_timezone_update_needed = timezone_list && timezone_list.length > 0;

location_update = <#if is_loc_update_case?has_content>${is_loc_update_case?c}<#else>false</#if>
improper_tz = <#if is_improper_tz_case?has_content>${is_improper_tz_case?c}<#else>false</#if>
data_update = <#if is_data_update_case?has_content>${is_data_update_case?c}<#else>false</#if>
	
I18N.load({
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY" />',
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE" />',
	"IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE" : '<@i18n key="IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE" />',
	"IAM.US.STATE.SELECT" : '<@i18n key="IAM.US.STATE.SELECT" />',
	"IAM.TFA.SELECT.COUNTRY" : '<@i18n key="IAM.TFA.SELECT.COUNTRY" />',
	"IAM.ANNOUNCEMENT.TIMEZONE.SELECT" : '<@i18n key="IAM.ANNOUNCEMENT.TIMEZONE.SELECT" />',
	"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
	"IAM.ERROR.UPDATE.SUCCESS.MESSAGE" : '<@i18n key="IAM.ERROR.UPDATE.SUCCESS.MESSAGE" />',
	"IAM.SEARCHING" : '<@i18n key="IAM.SEARCHING" />',
	"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
	"IAM.TFA.SELECT.COUNTRY" : '<@i18n key="IAM.TFA.SELECT.COUNTRY" />',
	"IAM.US.STATE.SELECT" : '<@i18n key="IAM.US.STATE.SELECT" />',
	"IAM.TFA.SELECT.COUNTRY" : '<@i18n key="IAM.TFA.SELECT.COUNTRY"/>',
});
if(improper_tz){
	timezone_list.splice(0, 0, I18N.get("IAM.ANNOUNCEMENT.TIMEZONE.SELECT"));
}

var iam_search_text = '<@i18n key="IAM.SEARCHING" />';
var iam_no_result_found_text = '<@i18n key="IAM.NO.RESULT.FOUND" />';
function redirect(){
	window.location.href="${Encoder.encodeJavaScript(visited_url)}";
}

function close_popup() {
	$("#result_popup_failure, .blur_screen").slideUp(150);
}

function remove_remindlater_link() {
	$(".remind_later_link").hide();
	edit_details();
}
function isTimezoneInList(){
user_timezone_arr = get_timezone_arr("${user_timezone}");
var user_timezone_id = user_timezone_arr == null ? undefined : user_timezone_arr[1];
for(iter = 0; iter < timezone_list.length; iter++){
	var  timezone_val = timezone_list[iter];
	var timezone_val_arr = get_timezone_arr(timezone_val);
	var timezone_val_id = timezone_val_arr == null ? undefined : timezone_val_arr[1];
	if(timezone_val_id == user_timezone_id) {
		return true;
	}
}
return false;
}
var selected_country, selected_state;
function toggleCountryStates(selectCountryElement) {
	var select = $('#state_dropdown select[name=country_state]');
	var is_state_present = false;
	if(select.length > 0 && ZACountryStateDetails && ZACountryStateDetails.length > 0) {
		var countryOptionEle = selectCountryElement.options[selectCountryElement.selectedIndex];
		var countryCode = $("#country_dropdown_list").val();
		var countryStates = ZACountryStateDetails[0];
		var stateOptios = countryStates[countryCode.toLowerCase()];
		if(stateOptios != undefined) {
			select[0].innerHTML = stateOptios;			
			for (i = 0; i < document.getElementById("state_dropdown_list").length; ++i) {
				if((location_update || improper_tz) && current_state != ""){
					if(document.getElementById("state_dropdown_list").options[i].value.toLowerCase() == current_state.toLowerCase()){
			    		is_state_present = true;
			    		selected_state = $('#state_dropdown_list option:eq('+i+')').val();
			    		$('#state_dropdown_list option:eq('+i+')').prop('selected', true).trigger( "change" );
			    	}
				}else{
					if(document.getElementById("state_dropdown_list").options[i].value.toLowerCase() == user_state.toLowerCase()){
			    		is_state_present = true;
			    		selected_state = $('#state_dropdown_list option:eq('+i+')').val();
			    		$('#state_dropdown_list option:eq('+i+')').prop('selected', true).trigger( "change" );
			    	}
				}
			}
			is_state_needed = true;
			if(data_update || user_state == ""|| statesForCountry.indexOf(current_country_code.toLowerCase()) != -1 || stateOptios.indexOf(current_state) == -1){
				if(user_state == "" || selected_country != countryCode && stateOptios.indexOf(selected_state) == -1){
	 				$('#state_dropdown_list option:eq(0)').prop('selected', true).trigger( "change" );
	 			}
			}  			
			$('#state_dropdown').css('display',''); //No I18N
		} else {
			select[0].innerHTML = "";
			is_state_needed = false;
			$('#state_dropdown').css('display','none'); //No I18N
		}
		selected_country = countryCode;
	}
}

function populate_states() {
    if(country_states != null && country_states != '') {
		var stateJson = {};
    	var stateCountries_len = Object.keys(country_states).length;
     	for(country_no = 0; country_no < stateCountries_len; country_no++) {
			var stateCountry = Object.keys(country_states)[country_no];
			country_states[stateCountry].splice(0, 0, I18N.get("IAM.US.STATE.SELECT"));
     	 	var states = country_states[stateCountry];
     	 	var stateOptions = '';
     	 	for(state_no = 0; state_no < states.length; state_no++) {
     	 		stateOptions += "<option value=\"" + states[state_no] + "\">" + states[state_no] + "</option>";
     	 	}
			stateJson[stateCountry] = stateOptions.toString();
			statesForCountry.push(stateCountry);
     	}
     	var countryStateDetails = [];
     	countryStateDetails.push(stateJson);
     	window.ZACountryStateDetails = countryStateDetails;
	}
}

function showErrMsg(msg, isSuccessMsg){
	if(isSuccessMsg){
		document.getElementById("error_space").classList.add("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.add("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = ""; //No I18N
	}else{
		document.getElementById("error_space").classList.remove("success_space") //No I18N
		document.getElementsByClassName("error_icon")[0].classList.remove("verified-selected");//No I18N
		document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
	}
	document.getElementById("error_space").classList.remove("show_error"); //No I18N
	document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N

	document.getElementById("error_space").classList.add("show_error");//No I18N
	setTimeout(function() {
		document.getElementById("error_space").classList.remove("show_error");//No I18N
	}, 5000);;
}

function classifyError(resp, siblingClassorID){
	if(resp.status_code && resp.status_code === 0){
		showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
	}else if(resp.code && resp.code === "Z113"){//No I18N
		showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
	}else if(resp.localized_message && siblingClassorID){
		show_error_msg(siblingClassorID, resp.localized_message)
	}else if(resp.localized_message){
		showErrMsg(resp.localized_message)
	}else{
		showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
	}
}

$(document).ready(function() {
	populate_states();	
	current_country_name = "${current_country_name}";
	current_country_code = "${current_country_code}";
	current_timezone = "${current_timezone}";
	current_state = "${current_state_name}";
		 
	user_country_name = "${user_country_name}";
	user_country_code = "${user_country_code}";
	user_timezone = "${user_timezone}";
	user_state = "${user_state_name}";

	user_timezone_arr = get_timezone_arr(user_timezone);
		 
	if(current_state != '' && statesForCountry.indexOf(current_country_code.toLowerCase()) != -1) {
		$(".current_country_box").append("<span class='current_locale_value'> (" + current_state + ") </span>");
	} else if(user_state != '' && statesForCountry.indexOf(user_country_code.toLowerCase()) != -1)
		 
	if (current_timezone != "") {
		current_timezone_arr = get_timezone_arr(current_timezone);
		if(current_timezone_arr[1] == "Etc/GMT+12") {
			var cont_timezone_val = current_timezone.replace(current_timezone_arr[0], "").trim();
		 	$(".timezone_value").text(cont_timezone_val);
		 }
	}else if(user_timezone != "") {
		if(user_timezone_arr[1] == "Etc/GMT+12") {
			var cont_timezone_val = user_timezone.replace(user_timezone_arr[0], "").trim();
			$(".timezone_value").text(cont_timezone_val);
		}
	}	 
	content_for_form_container();
		
	if(location_update || improper_tz){
		$("#user_details_container").show();
	} else{
		$("#user_details_container").hide();
		edit_details();
		$(".cancel_btn").remove();
	}

		$("#country_dropdown_list").uvselect({
			"width": "298px",
			"searchable" : true,
			"dropdown-width": "300px",
			"dropdown-align": "left",
			"embed-icon-class": "flagIcons",
			"country-flag" : true,
			"onDropdown:open" : function() {
				$("#country_dropdown").addClass("highlight_select");
				$(".warn_msg.country").slideUp(200)
			},
			"onDropdown:select" : function() {
				var vall = $("#country_dropdown_list").val();
				toggleCountryStates($("#country_dropdown_list")[0]);
			},
			"onDropdown:close" : function() {
				$("#country_dropdown").removeClass("highlight_select");
			},
			"place-options-after" : "country_dropdown",
		})
		 
		 $("#state_dropdown_list").uvselect({
		 	"width": "298px",
		 	"dropdown-width": "300px",
		 	"searchable" : true,
		 	"onDropdown:open" : function() {
				$("#state_dropdown").addClass("highlight_select");
				$(".warn_msg.state").slideUp(200)
			},
			"onDropdown:close" : function() {
				$("#state_dropdown").removeClass("highlight_select");
				
			},
			"place-options-after" : "state_dropdown",
		 })
		
		 if(is_timezone_update_needed) {
		 	$("#timezone_dropdown_list").uvselect({
		 		"width": "398px",
		 		"searchable" : true,
		 		"dropdown-width": "400px",
		 		"onDropdown:open" : function() {
					$("#timezone_dropdown").addClass("highlight_select");
					$(".warn_msg.timezone").slideUp(200)
				},
				"onDropdown:close" : function() {
					$("#timezone_dropdown").removeClass("highlight_select");
				},
				"place-options-after" : "timezone_dropdown",
			})
		 }
	      
		$("#cancel_btn").click(function() {
			$("#locale_dropdown_container").hide();
			$("#user_details_container, .remind_later_link").show();
			content_for_form_container();
		});		
		$("#container").show();	
});

function get_timezone_arr (timezone_val) {
	var timezone_id = timezone_val.split(" ");
	timezone_id = timezone_id[(timezone_id.length)-1];
	var regExp = /\(([^)]+)\)/;
	var matches = regExp.exec(timezone_id);
    return matches;
}

function content_for_form_container() {
	var country_dropdown_length = $("#country_dropdown_list").children().length;
	for(var country_no = 0; country_no < country_list.length; country_no++) {
		var countryName = country_list[country_no];
		var country_Code = country_codes[country_no];
		if(country_dropdown_length == 0) {
			if((location_update || improper_tz) && current_country_name != ""){
				if(countryName.toLowerCase() !== current_country_name.toLowerCase()) {
					$("#country_dropdown_list").append("<option value="+country_Code+">"+countryName+"</option>");
				}else{
					$("#country_dropdown_list").append("<option selected='selected' value="+country_Code+">"+countryName+"</option>");
				}
	   		}else{
	   			if(countryName.toLowerCase() !== user_country_name.toLowerCase()) {
					$("#country_dropdown_list").append("<option value="+country_Code+">"+countryName+"</option>");
		   		} else {
			   		$("#country_dropdown_list").append("<option selected='selected' value="+country_Code+">"+countryName+"</option>");
		   		}
	   		}
		} else {
			if((location_update || improper_tz) && current_country_name != ""){
	   			if(countryName.toLowerCase() == current_country_name.toLowerCase()) {
	 	  			$('#country_dropdown_list option:eq('+country_no+')').prop('selected', true).trigger( "change" );
		   		}
	   		} else {
	   			if(countryName.toLowerCase() == user_country_name.toLowerCase()) {
					$('#country_dropdown_list option:eq('+country_no+')').prop('selected', true).trigger( "change" );
		   		}
	   		}
	  	}
	}
	if(data_update && user_country_code == "" || user_country_name == ""){
		$("#country_dropdown_list").prepend("<option value='Domain'>"+I18N.get("IAM.TFA.SELECT.COUNTRY")+"</option>");
		$("#country_dropdown_list option:eq(0)").prop('selected', true).trigger( "change" );
	}
	if(!isTimezoneInList() && timezone_list[0] !== I18N.get("IAM.ANNOUNCEMENT.TIMEZONE.SELECT")){
		timezone_list.splice(0, 0, I18N.get("IAM.ANNOUNCEMENT.TIMEZONE.SELECT"));
	}

	   if(is_timezone_update_needed) {
		   var timezone_dropdown_length = $("#timezone_dropdown_list").children().length;
		   var user_timezone_id = user_timezone_arr == null ? undefined : user_timezone_arr[1];
		   current_timezone_arr = current_timezone != "" ? get_timezone_arr(current_timezone) : ""; 
		   var current_timezone_id = current_timezone_arr == null ? undefined : current_timezone_arr[1];
	       for(var timezone_no = 0; timezone_no < timezone_list.length; timezone_no++) {
	       		var  timezone_val = timezone_list[timezone_no];
	            var timezone_val_arr = get_timezone_arr(timezone_val);
	            var timezone_val_id = timezone_val_arr == null ? undefined : timezone_val_arr[1];
	            if(timezone_dropdown_length == 0) {
	            	if((location_update || improper_tz) && current_timezone != ""){
	            		if(timezone_val_id !== current_timezone_id) {
		            		timezone_val = GMT12(timezone_val, timezone_val_id, timezone_val_arr);           	
		              		$("#timezone_dropdown_list").append("<option value='"+ timezone_val +"'>"+timezone_val+"</option>");
			       		} else {
			        		timezone_val = GMT12(timezone_val, timezone_val_id, timezone_val_arr);
			        		$("#timezone_dropdown_list").append("<option selected='selected' value='"+ timezone_val +"'>"+timezone_val+"</option>");
			       			$('#timezone_dropdown_list').trigger( "change" );
			        	}
	            	}else{
	            		if(timezone_val_id !== user_timezone_id) {
		            		timezone_val = GMT12(timezone_val, timezone_val_id, timezone_val_arr);           	
		              		$("#timezone_dropdown_list").append("<option value='"+ timezone_val +"'>"+timezone_val+"</option>");
			        	} else {
			        		timezone_val = GMT12(timezone_val, timezone_val_id, timezone_val_arr);
			        		$("#timezone_dropdown_list").append("<option selected='selected' value='"+ timezone_val +"'>"+timezone_val+"</option>");
			       			$('#timezone_dropdown_list').trigger( "change" );
			        	}
	            	}
	            } else {
	            	if((location_update || improper_tz) && current_timezone != ""){
	            		if(timezone_val_id == current_timezone_id) {
		                 $('#timezone_dropdown_list option:eq('+timezone_no+')').prop('selected', true).trigger( "change" );
			         }
	            	}else{
	            		if(timezone_val_id == user_timezone_id) {
		                 $('#timezone_dropdown_list option:eq('+timezone_no+')').prop('selected', true).trigger( "change" );
			         }
	            	}
	            } 	              
	     	}
	     	$("#timezone_dropdown").css("display", "block");
	     	 if(user_timezone == "" || improper_tz && (current_timezone ==  "" || user_timezone == "")) {
			   	  $('#timezone_dropdown_list option:eq(0)').prop('selected', true).trigger('change');
			 }
     	}
}

function GMT12(timezone_val, val_id, val_arr){
	if(val_id == "Etc/GMT+12") {
		timezone_gmt_id = val_id;
		timezone_val = timezone_val.replace(val_arr[0], "").trim();
	}
	return timezone_val;
}

function edit_details() {
	$("#user_details_container").css("display", "none");
	select = $('#country_dropdown select[name=country]')[0];
	if(user_country_name)
	toggleCountryStates(select);
	$("#locale_dropdown_container").css("display", "block");
}

function update_location_call(update_profile_data, e) {
	e.target.classList.add("btndisabled");
	e.target.querySelector("span").classList.add("loader");
	var params = JSON.stringify({"user" : update_profile_data}); //NO I18N
	var xhr=$.ajax({
		"beforeSend": function(xhr) { //NO I18N
			xhr.setRequestHeader("X-ZCSRF-TOKEN", csrfParam);
		},
		type: "PUT",// No I18N
		url: contextpath + "/webclient/v1/account/self/user/self", //NO I18N
		data: params,// No I18N
		dataType : "json", // No I18N
		success: function(obj) {
			setTimeout(function(e){
				e.target.classList.remove("btndisabled");
				e.target.querySelector("span").classList.remove("loader");
				if(obj.status_code == 200) {
					$(".result .cont_btn").show();
                	$(".result").css({"z-index": "4","opacity": "1"})
				} else {
					classifyError(resp)
				}
			}, 300, e)
		}
	});
}

function update_profile_new_location(event) {
	var update_profile_data = {};
	if(current_country_name != "") {
		$.extend(update_profile_data, { "country" : current_country_code.toLowerCase() }); //NO I18N
		if(current_timezone != "") {
			$.extend(update_profile_data, { "timezone" : get_timezone_arr(current_timezone)[1] }); //NO I18N
		}
		if(current_state != "" && statesForCountry.indexOf(current_country_code.toLowerCase()) != -1) {
			$.extend(update_profile_data, { "state" : current_state }); //NO I18N
		}
	} else {
		if(user_country_name != "" ){
			$.extend(update_profile_data, { "country" : user_country_code });
			if(user_state != ""){
				$.extend(update_profile_data, { "state" : user_state }); //NO I18N
			}
			if(user_timezone != null){
				$.extend(update_profile_data, { "timezone" : get_timezone_arr(user_timezone)[1] }); //NO I18N
			}
		}
	}
	if(Object.keys(update_profile_data).length > 0) {
		update_location_call(update_profile_data, event);
	} else {
		resp = {}
		classifyError(resp);
	}
}

function update_profile_edited_loc(event) {
	var new_country = $("#country_dropdown_list").val();
	if(new_country != undefined && new_country != "Domain") {
		var update_profile_data = {
			"country" : new_country.toLowerCase()
		}
		if(is_state_needed) {
			var new_state = $("#state_dropdown_list").val();
			if(new_state != undefined && new_state != I18N.get("IAM.US.STATE.SELECT")) {
				$.extend(update_profile_data, { "state" : new_state });
			} else {
				update_profile_data = null;
				$(".warn_msg.state").text(I18N.get("IAM.ANNOUNCEMENT.LOCALE.SELECT.STATE"));
			}
		}
		if(is_timezone_update_needed) {
			var new_timezone = $("#timezone_dropdown_list").val();
			if(new_timezone != undefined && new_timezone != I18N.get("IAM.ANNOUNCEMENT.TIMEZONE.SELECT")) {
				var new_timezone_arr = get_timezone_arr(new_timezone);
				if (new_timezone_arr == null && timezone_gmt_id != "") {
					new_timezone = timezone_gmt_id; 
				} else {
					new_timezone = new_timezone_arr[1];
				}
				$.extend(update_profile_data, { "timezone" : new_timezone });
			} else {
				update_profile_data = null;
				$(".warn_msg.timezone").text(I18N.get("IAM.ANNOUNCEMENT.LOCALE.SELECT.TIMEZONE"));
			}
		} 
	} else {
		update_profile_data = null;
		$(".warn_msg.country").text(I18N.get("IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY"));
	}
	if(update_profile_data == undefined || update_profile_data == null) {
		$(".warn_msg").css("display", "block");
	} else {
		update_location_call(update_profile_data, event);
	}
}
</script>
</head>
<body>
<#include "../Unauth/announcement-logout.tpl">
<div id="error_space" class="error_space">
	<span class="error_icon">&#33;</span> <span class="top_msg"></span>
</div>
<div class="result" style="display: block">
	<div class="rebrand_partner_logo"></div>
	<div class="result_popup" id="result_popup_succ">
		<div class="pop_bg"></div>
		<div class="pop_icon"><span class="inner_circle"></span></div>
		<div class="content_space">
			<#if is_loc_update_case?has_content && is_loc_update_case == true || is_improper_tz_case?has_content && is_improper_tz_case == true>
			<div class="grn_text" id="result_content"><@i18n key="IAM.TIMEZONE.UPDATED"/></div>
			<div class="defin_text"><@i18n key="IAM.ANNOUN.TZ.UPDATED.DESC"/> <@i18n key="IAM.ANNOUN.CONT.ACCESS.ACC"/></div>
			<#else>
			<div class="grn_text" id="result_content"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.SUCCESS.MESSAGE.HEADER"/></div>
			<div class="defin_text"><@i18n key="IAM.ANNOUN.LOCAT.UPDATED.DESC"/> <@i18n key="IAM.ANNOUN.CONT.ACCESS.ACC"/></div>
			</#if>
			<button class="cont_btn" style="display: none" id="continue" onclick="redirect()"><span></span><@i18n key="IAM.ACCESS.MY.ACC"/></button>
		</div>
	</div>
</div>
		<div class="flex-container container">
			<div class="content_container">			
				<div class="rebrand_partner_logo"></div>
				<div class="announcement_heading">
					<#if is_loc_update_case?has_content && is_loc_update_case == true || is_improper_tz_case?has_content && is_improper_tz_case == true>
						<@i18n key="IAM.ANNOUNCEMENT.INVALID.TIMEZONE.TITLE" />
					<#else>
						<@i18n key="IAM.ANNOUN.REVIEW.LOCATION" />
					</#if>
				</div>
				<div class="announcement_description"> 
					<#if is_loc_update_case?has_content && is_loc_update_case == true>
						<@i18n key="IAM.ANNOUN.LOCAT.CHANGE.DESC" />
					<#elseif is_improper_tz_case?has_content && is_improper_tz_case == true>
						<@i18n key="IAM.ANNOUNCEMENT.INVALID.TIMEZONE.DESCRIPTION" />
					<#else>
						<@i18n key="IAM.ANNOUNCEMENT.LOCALE.DESCRIPTION" />	
					</#if>
				</div>
				<div id="user_details_container" class="hide">
				<#if is_loc_update_case?has_content && is_loc_update_case == true || is_improper_tz_case?has_content && is_improper_tz_case == true>
				<div class="user_locale_container" style="margin-bottom: 10px">
				<#else>
				<div class="user_locale_container">
				</#if>
					<div class="container_header">
						<#if is_loc_update_case?has_content>
							<span><span style="margin-right:4px"><@i18n key="IAM.DETECTED.TIMEZONE" /></span><span class="ip_note"><@i18n key="IAM.ANNOUN.BASED.ON.IP" /></span></span>
						<#else>
							<span><@i18n key="IAM.ANNOUNCEMENT.TIMEZONE.NEW.FORMAT" /></span>
						</#if>
						<span class="edit_text" onclick="remove_remindlater_link();"><@i18n key="IAM.EDIT.UPDATE" /></span>
					</div>
					
					<div class="container_body">
						<div class="current_country_box">
							<span class="current_locale_icon icon-Country"></span>
							<#if (current_country_name)?has_content>
								<span class="current_locale_value">${current_country_name}</span>
							<#else>
								<span class="current_locale_value">${user_country_name}</span>
							</#if>
						</div>
						<div class="current_timezone_box">
							<span class="current_locale_icon icon-Timezone"></span>
							<#if (current_timezone)?has_content>
								<span class="current_locale_value timezone_value">${current_timezone}</span>
							<#else>
								<span class="current_locale_value timezone_value">${user_timezone}</span>
							</#if>
						</div>
					</div>
				</div>
				<#if is_loc_update_case?has_content && is_loc_update_case == true || is_improper_tz_case?has_content && is_improper_tz_case == true>
				<div class="note"><@i18n key="IAM.ANNOUN.LOCAT.CHANGE.NOTE" /></div>
				</#if>
				<button class="update_profile" onclick="update_profile_new_location(event);"><span></span><@i18n key="IAM.UPDATE" /></button>
				</div>
				
				<div id="locale_dropdown_container" class="container hide">
				<form onsubmit="return false;" name="country_form">
				<div class="list_dropdown_box" id="country_dropdown">
					<label class="dropdown_label"><@i18n key="IAM.COUNTRY" /></label>
					<select class="profile_mode" name="country" id="country_dropdown_list"></select>
				</div>
				<div class="warn_msg country"></div>
				<div class="list_dropdown_box" id="state_dropdown" style="display: none;">
					<label class="dropdown_label"><@i18n key="IAM.GDPR.DPA.ADDRESS.STATE" /></label>
					<select class="profile_mode" name="country_state" id="state_dropdown_list"></select>
				</div>
				<div class="warn_msg state"></div>
				<div class="list_dropdown_box list_dropdown_box_timezone" id="timezone_dropdown" style="display: none;" >
                	<label class="dropdown_label"><@i18n key="IAM.ANNOUNCEMENT.LOCALE.TIMEZONE.TITLE" /></label>
                    <select class="profile_mode long_div" id="timezone_dropdown_list"></select>
              	</div>
			    <div class="warn_msg timezone"></div>
			
				<#if is_data_update_case?has_content>
			   		<button class="update_profile" id="update_profile" onclick="update_profile_edited_loc(event);"><span></span><@i18n key="IAM.UPDATE" /></button>	
				<#else>
					<button class="update_profile" id="update_profile" onclick="update_profile_edited_loc(event);"><span></span><@i18n key="IAM.CONFIRM" /></button>
				</#if>
					<button class="cancel_btn" id="cancel_btn"><@i18n key="IAM.BACK" /></button>
				</form>
				</div>
				
				<span class="grey_text remind_later_link" onclick="(function(e){ window.location.href=remindme;e.target.classList.add('remind_loader')})(event);"><@i18n key="IAM.TFA.BANNER.REMIND.LATER" /></span>
			</div>
			 <div class="illustration-container">
                <div class="illustration"></div>
            </div>
			
			</div>
</body>
</html>