<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title><@i18n key="IAM.ANNOUNCEMENT.LANGUAGE.TAB.TITLE"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
<@resource path="/v2/components/js/uvselect.js" />
<@resource path="/v2/components/css/uvselect.css" />
<@resource path="/v2/components/css/${customized_lang_font}"/>
<style>
body{
	padding:0px;
	margin:0px;
}
.lang_lable{
	color:#000000B3;
	font-size:12px;
	font-weight:500;
	margin-bottom:4px;
	display: block;
}
.announcement_img{
    background: url('${SCL.getStaticFilePath("/v2/components/images/language_update.svg")}') no-repeat;
    background-size: 100% auto;
    width: 30%;
    max-width: 320px;
    height: 340px;
    margin-left: 80px;
    margin-top:40px;
    display: inline-block;
    float:right;
}
.zoho_logo {
    display: block;
    height: 40px;
    width: auto;
    margin-bottom: 20px;
    background: url('${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}') no-repeat;
    background-size: auto 100%;
    cursor: pointer;
}
.announcement_heading {
    font-weight: 600;
    font-size: 24px;
    margin-bottom: 20px;
}
.announcement_description {
    font-weight: 400;
    font-size: 16px;
    line-height: 24px;
    color: #000000;
    opacity: 0.8;
    margin-bottom: 30px;
}
.box_container {
    margin-top: 120px;
    width: 944px;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.announcement_content {
    width: 540px;
    height: 500px;
    display: inline-block;
}
.update_profile {
    background: #1389E3;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-weight: 600;
    font-size: 13px;
    color: #FFFFFF;
    padding: 12px 28px;
    text-align: center;
}
.cancel_btn {
    background: #ebebeb;
    border-radius: 4px;
    margin-left: 20px;
    border: none;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    color: #000000;
    opacity: 0.6;
    padding: 12px 28px;
    text-align: center;
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
.selectbox_options_container--open{
	border-color: #0000004D;
}
.basic_selectbox,.selectbox--focus{
	border-color: #0000004D !important;
}
@-webkit-keyframes spin
{
	0% {-webkit-transform: rotate(0deg);}
100% {-webkit-transform:rotate(360deg);}
}
@keyframes spin
{
	0% {transform: rotate(0deg);}
	100% {transform:rotate(360deg);}
}
.load_state{
  opacity: 0.7;
  pointer-events: none;
}
.load_state:after{
	content: "";
    border: 2px solid white;
    border-top: 2px solid transparent;
    border-radius: 50%;
    width: 12px;
    display: inline-block;
    height: 12px;
    background: transparent;
    position: relative;
    left: 5px;
    top: 1px;
    box-sizing: border-box;
    animation: spin 1s linear infinite;
}
@media only screen and (max-width: 960px) and (min-width: 601px){
	.announcement_img {
 	   		display: none;
	}
	.announcement_content {
  			width: 100%;
	}
	.box_container {
   		max-width: 540px;
   		width: 75%;
   		margin-top: 90px;
	}
}
@media only screen and (max-width: 600px){
	.announcement_img {
 	   		display: none;
	}
	.box_container {
 	   width: 90%;
 	   margin: auto;
	   margin-top: 30px;
	}
	.select_container,.announcement_content{
		width:100%;
	}
}
</style>
</head>
<body>
<#include "../zoho_line_loader.tpl">
<#include "../Unauth/announcement-logout.tpl">
	<div id="error_space" class="error_space">
		<span class="error_icon">!</span> <span id="top_error_text" class="top_msg"></span>
	</div>
	<div class="container" id="container">
		<div class="box_container">
			<div class="announcement_content">
				<div class="zoho_logo"></div>
				<div class="announcement_heading"><@i18n key="IAM.ANNOUNCEMENT.LANGUAGE.UPDATE.CONTAINER.TITLE"/></div>
				<#if preferedLanguage??>
					<div class="announcement_description"><@i18n key="IAM.ANNOUNCEMENT.LANGUAGE.UPDATE.CONTAINER.DESCRIPTION" arg0='${serviceLanguage}' arg1='${preferedLanguage}'/></div>
				<#else>	
					<div class="announcement_description"><@i18n key="IAM.ANNOUNCEMENT.LANGUAGE.UPDATE.CONTAINER.DESCRIPTION.NOT.PREF.LANGUAGE" arg0='${serviceLanguage}'/></div>		
				</#if>
				<div style="margin-bottom:30px">
					<label class="lang_lable"><@i18n key="IAM.ANNOUNCEMENT.LANGUAGE.UPDATE.TITLE"/></label>
					<select class="drop_down" id="lang_dropdown">
						<#list languages as Languagedata>
						<option value="${Languagedata.getLanguageCode()}"  id="${Languagedata.getLanguageCode()}" data-text="<#if Languagedata.getDefaultDisplayName()?has_content>  ${Languagedata.getDefaultDisplayName()} </#if>">${Languagedata.getDisplayName()}</option>
                   		</#list>
					</select>
				</div>
				<button class="update_profile" id="updateLanguage" ><@i18n key="IAM.UPDATE"/></button>
				<button class="cancel_btn" id="skipBanner" ><@i18n key="IAM.SKIP"/></button>
			</div>
			<div class="announcement_img"></div>
		</div>
	</div>
</body>

<script nonce="${nonce}">
var isMobile = ${is_mobile?c}; //Used in uvselect and logout option
var contextpath = '${contextpath}';
function de(id) {
    return document.getElementById(id);
}

function isJSONString(str) {
    try {
        JSON.parse(str);
        return true;
    } catch (e) {
        return false;
    }
}

de('skipBanner').onclick=function(){
		window.location.href = '<#if skip_url??>${Encoder.encodeJavaScript(skip_url)}</#if>';
}
function getCookie(cookieName) 
{
	var nameEQ = cookieName + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i].trim();
		if (c.indexOf(nameEQ) == 0) {return c.substring(nameEQ.length,c.length);}
	}
	return null;
}
de('updateLanguage').onclick=function(){
	de("updateLanguage").classList.add('load_state');
	var param = {"user" : {"language" : de("lang_dropdown").value}};
	
	$.ajax({
    	type: 'PUT',			//NO I18N
   		headers: {
    		'Content-Type': 'application/json;charset=UTF-8',				//NO I18N
    		'X-ZCSRF-TOKEN': '${za.csrf_paramName}='+encodeURIComponent(getCookie('${za.csrf_cookieName}'))		//NO I18N
    	},
   		url: "/webclient/v1/account/self/user/self",		//NO I18N
   		data: JSON.stringify(param),
   		success: function(resp) {
   			var statusCode = resp.status_code;
    		if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
			{
				window.location.href = '<#if redirect_url??>${Encoder.encodeJavaScript(redirect_url)}</#if>';
			}
			else{
				de("updateLanguage").classList.remove('load_state');
				de('top_error_text').innerHTML=resp.localized_message ? resp.localized_message : resp.message;
				de('error_space').classList.add('show_error');
				setTimeout(function(){
					de('error_space').classList.remove('show_error');
				}, 3000);
			}
   		},
   		error: function(jqXHR, textStatus, err) {
		   		de("updateLanguage").classList.remove('load_state');
     			de('error_space').classList.add('show_error');
     			de('top_error_text').innerHTML = '<@i18n key="IAM.ERROR.REFRESH"/>';
				setTimeout(function(){
					de('error_space').classList.remove('show_error');
				}, 3000);
   		}
  	});
}

window.onload = function(){
	setTimeout(function(){
		document.querySelector(".load-bg").classList.add("load-fade");
		setTimeout(function(){
			document.querySelector(".load-bg").style.display = "none";
		}, 300)
	}, 500)
	$("#lang_dropdown").val('${serviceLangCode}');
	if($("#lang_dropdown").val()==null){$("#lang_dropdown option:first").attr("selected",'selected');}
	$("#lang_dropdown").uvselect({
		"searchable" : true
	});
	$("#container").show();
};
</script>
</html>