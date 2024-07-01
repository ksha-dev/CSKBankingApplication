<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title><@i18n key="IAM.TOS.ANNOUNCEMENT.HEADER.UPDATED" args0="${updated_content}"/></title>
<@resource path="/v2/components/css/${customized_lang_font}" />
<style>
[class^="icon-"], [class*=" icon-"] {
	/* use !important to prevent issues with browser extensions that change fonts */
	font-family: 'SignUp' !important;
	speak: none;
	font-style: normal;	
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	/* Better Font Rendering =========== */
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}
.continue {
	background-color: #6DA60A;
	border: 1px solid #65990B;
	color: #FFFFFF;
	font-size: 14px;
	padding: 6px 14px;
	text-decoration: none;
}

.mobileimage {
background: url(${SCL.getStaticFilePath("/images/banner-icons.png")}) no-repeat scroll 10px 0px;
    display: inline-block;
    height: 186px;
    margin-left: 34px;
    margin-top: 55px;
    width: 185px;
}
.container{
	margin-top: 120px;
    width:880px;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.announcement_img {
    background: url(${SCL.getStaticFilePath("/v2/components/images/TOS.png")}) no-repeat;
    width: 25%;
    max-width: 200px;
    height: 340px;
    background-size: 100% auto;
    display: inline-block;
    margin-left: 100px;
    margin-top: 75px;
    float: right;
}

.announcement_content {
	width: 540px;
    display: inline-block;
}

.zoho_logo {
	display: block !important;;
    height: 40px !important;
    width: auto;
    margin-bottom: 20px;
    background: url(${SCL.getStaticFilePath("/images/newZoho_logo.svg")}) no-repeat;
    background-size: auto 100% !important;
    cursor: pointer;
}

.announcement_heading {
	font-size: 24px;
	margin-bottom: 20px;
	font-weight: 600;
}

.announcement_description {
	font-weight: 400;
	font-size: 15px;
	line-height: 24px;
	margin-bottom: 20px;
}
.continue_button {
	background: #1389E3;
	border-radius: 4px;
	margin-top: 30px;
	border: none;
	cursor: default;
	font-size: 13px;
	color: #FFFFFF;
	text-align: center;
	display: block;
	font-weight: 600;
	box-sizing: border-box;
	padding: 12px 24px;
	font-family: 'ZohoPuvi', Georgia !important;
	outline: none;
	cursor: pointer;
}
.continue_button:hover{
	background: #0779CF;
}
.icon-medium {
    background: url(${SCL.getStaticFilePath("/images/icons.png")}) no-repeat;
    width: 18px;
    height: 18px;
    float: left;
    margin: 2px 5px 0 0px;
    transform: scale(1.2);
}
.unchecked{
	background-position: -114px -84px;
	color: #E4E4E4;
}

.checked {
	background-position: -79px -84px;
	color:#159AFF;
	font-size: 16px;
}
#tos{
	display: none;
}
#errMsg{
	display: none;
	color: #E92B2B;
    font-size: 14px;
    margin-top: 10px;
}
.tosaccept{
	cursor: pointer;
}
.service_list
{
    border: 1px solid #D8D8D8;
    border-radius: 10px;
	margin-bottom:20px;
}
.service_icon
{
    width: auto;
    height: 24px;
    display:none;
}
.me_service,.site247_service
{
	border-top: 1px solid #D8D8D8;
}
.zoho_serv_icon
{
	background: url(${SCL.getStaticFilePath("/images/newZoho_logo.svg")}) no-repeat;
    background-size: auto 100%;
}
.me_serv_icon
{
	background: url(${SCL.getStaticFilePath("/v2/components/images/ME.png")}) no-repeat;
    background-size: auto 100%;
}
.site247_serv_icon
{
	background: url(${SCL.getStaticFilePath("/v2/components/images/Sites2x.png")}) no-repeat;
    background-size: auto 100%;
}
.service_tab
{
	padding:20px 30px;
	position: relative;
	height: 64px;
    overflow: hidden;
    box-sizing: border-box;
    transition: height .3s ease-in-out;
}
.link_list
{
	overflow:auto;
}
.close_arrow
{
	height:24px;
	width:24px;
	position:absolute;
	top:15px;
	right:25px;
	cursor:pointer;
	transition: all .3s ease-in-out;
	opacity:1;
}
.close_arrow:before{
	content: "";
    display: block;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    border: 1px solid #888;
    position: absolute;
    top: 0px;
    bottom: 0px;
    left: 0px;
    right: 0px;
    margin: auto;
}
.close_arrow:after {
	content: "";
    display: block;
    width: 5px;
    height: 5px;
    border: 1px solid #888;
    border-top: transparent;
    border-left: transparent;
    left: 9px;
    top: 10px;
    position: relative;
    transform: rotate(-135deg);
}
.open_arrow
{
	opacity:.3;
    cursor: default;
    transform: rotate(180deg);
}
.link_list>div
{
    margin-top: 16px;
}
.link_list a
{
	color:#0091FF;
	font-size:14px;
	text-decoration: none;
}
.sep_dot:before
{
    content: "";
    display: inline-block;
    border: 2px solid #D4D4D4;
    border-radius: 50%;
    margin: 0px 10px 4px 10px;
}

@media only screen and (max-width: 900px) {
	.announcement_img{
		display: none;
	}
	.container{
		max-width: 540px;
	    width: 75%;
	    margin-top: 90px;
	}
	.announcement_content{
		width: 100%;
	}
}
@media only screen and (max-width: 600px) {
	.container{
		width: 90%;
		margin: 30px;
	}
}
@media only screen and (max-width: 435px){
	.container {
	    width: 90%;
	    margin: auto;
	    margin-top: 40px;
	}
	.continue_button
	{
		width:100%;
	} 
}
@media only screen and (max-width: 900px)
.container {
    max-width: 540px;
    width: 80%;
    margin-top: 60px;
}
@media only screen and (-webkit-min-device-pixel-ratio: 2), not all, not all, not all, only screen and (min-resolution: 192dpi), only screen and (min-resolution: 2dppx)
    {
    	.announcement_img{	
    		background: url("${SCL.getStaticFilePath("/v2/components/images/TOS2x.png")}) no-repeat;
    		background-size: 100% auto;
    	}
		.me_serv_icon
		{
			background: url(${SCL.getStaticFilePath("/v2/components/images/ME2x.png")}) no-repeat;
		    background-size: auto 100%;
		}
		.site247_serv_icon
		{
			background: url(${SCL.getStaticFilePath("/v2/components/images/Sites2x.png")}) no-repeat;
		    background-size: auto 100%;
		}
    }
</style>
<script>
function redirect() {
	var button = document.getElementById('continue_button');
	button.setAttribute('href','javascript:void(0)');
    button.innerHTML = '<@i18n key="IAM.ANNOUNCEMENT.UPDATING" />';
    window.location.href = '${visited_url}';
	return;
}
window.onload = function(){
	if(document.getElementsByClassName("service_list")[0].children.length > 1){
		document.getElementsByClassName("service_list")[0].children[0].style.height = (document.getElementsByClassName("link_list")[0].offsetHeight+64)+"px";	//No I18N
		document.getElementsByClassName("service_list")[0].children[0].children[0].classList.add("open_arrow");
		<#if ((tos_urls.zoho) ??)>
			document.getElementsByClassName("zoho_serv_icon")[0].style.display = "block";
		</#if>
		<#if ((tos_urls.manageengine) ??)>
			document.getElementsByClassName("me_serv_icon")[0].style.display = "block";
		</#if>
		<#if ((tos_urls.site24x7) ??)>
			document.getElementsByClassName("site247_serv_icon")[0].style.display = "block";
		</#if>
	}
	else{
		document.getElementsByClassName("service_list")[0].children[0].children[0].style.display = "none";
		document.getElementsByClassName("service_list")[0].children[0].style.border = "unset";
		showLinks(document.getElementsByClassName("service_list")[0].children[0].children[0]);
		document.getElementsByClassName("service_list")[0].style.border = "unset";
		document.getElementsByClassName("service_list")[0].children[0].style.padding = "0px";
		document.getElementsByClassName("service_list")[0].children[0].children[1].style.display = "none";
		document.getElementsByClassName("service_list")[0].children[0].style.height = "auto";
		document.getElementsByClassName("service_list")[0].children[0].children[2].children[0].style.margin = "0px";
		document.getElementsByClassName("zoho_logo")[0].classList.add(document.getElementsByClassName("service_list")[0].children[0].children[1].classList[0]);
		document.getElementsByClassName("zoho_logo")[0].classList.add(document.getElementsByClassName("service_list")[0].children[0].children[1].classList[1]);
	}
}
function showLinks(ele){
	var ele_length = document.getElementsByClassName("service_tab").length;
	for (var nthEle = 0;nthEle<ele_length;nthEle++){
		var element = document.getElementsByClassName("service_tab")[nthEle];
   		element.style.height = "64px";		//No I18N
  		element.children[0].classList.remove("open_arrow");
	}
	ele.classList.add("open_arrow");
	ele.parentNode.style.height = (document.getElementsByClassName("link_list")[0].offsetHeight+64)+"px";	//No I18N
}
</script>
</head>
<body>
<#include "../Unauth/announcement-logout.tpl"> 
<div class='container'>
	<div class="announcement_content">		
		<div class="zoho_logo"></div>
		<div class="announcement_heading">
			<@i18n key="IAM.TOS.ANNOUNCEMENT.HEADER.UPDATED" args0="${updated_content}"/>
		</div>
	    <div class="announcement_description">
			<@i18n key="IAM.TOS.ANNOUNCEMENT.DESC1" args0="${updated_content}"/>
	    </div>
	    <div class="service_list">
	    	<#if ((tos_urls.zoho) ??)>
	    	<div class="zoho_service service_tab">
	    		<div class="close_arrow" onclick="showLinks(this)"></div>
	    		<div class="service_icon zoho_serv_icon"></div>
	    		<div class="link_list">
	    			<#if ((show_tos) ??)>
			    		<div class="tos_list">
			    			<a href="${tos_urls.zoho.zoho_tos_url}" target="_blank"><@i18n key="IAM.TOS.NEW.TOS.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.zoho.zoho_tos_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.zoho.zoho_tos_comparison_url}" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
			    	<#if ((show_privacy) ??)>
			    		<div class="privacy_list">
			       			<a href="${tos_urls.zoho.zoho_privacy_url}" target="_blank"><@i18n key="IAM.TOS.NEW.PRIVACY.POLICY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.zoho.zoho_privacy_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.zoho.zoho_privacy_comparison_url}" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
	    		</div>
	    	</div>
	    	</#if>
	    	<#if ((tos_urls.manageengine) ??)>
	    	<div class="me_service service_tab">
		    	<div class="close_arrow" onclick="showLinks(this)"></div>
	    		<div class="service_icon me_serv_icon"></div>
	    		<div class="link_list">
		    		<#if ((show_tos) ??)>
			    		<div class="tos_list">
			    			<a href="${tos_urls.manageengine.manageengine_tos_url}" target="_blank"><@i18n key="IAM.TOS.NEW.TOS.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.manageengine.manageengine_tos_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.manageengine.manageengine_tos_comparison_url}" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
		    		<#if ((show_privacy) ??)>
			    		<div class="privacy_list">
			       			<a href="${tos_urls.manageengine.manageengine_privacy_url}" target="_blank"><@i18n key="IAM.TOS.NEW.PRIVACY.POLICY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.manageengine.manageengine_privacy_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.manageengine.manageengine_privacy_comparison_url}" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
	    		</div>
	    	</div>
	    	</#if>
	    	<#if ((tos_urls.site24x7) ??)>
	    	<div class="site247_service service_tab" >
				<div class="close_arrow" onclick="showLinks(this)"></div>
	    		<div class="service_icon site247_serv_icon"></div>
	    		<div class="link_list">
	    			<#if ((show_tos) ??)>
			    		<div class="tos_list">
			    			<a href="${tos_urls.site24x7.site24x7_tos_url}" target="_blank"><@i18n key="IAM.TOS.NEW.TOS.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.site24x7.site24x7_tos_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.site24x7.site24x7_tos_comparison_url}" style="color:#2196F3;text-decoration: none;" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
			    	<#if ((show_privacy) ??)>
			    		<div class="privacy_list">
			       			<a href="${tos_urls.site24x7.site24x7_privacy_url}" target="_blank"><@i18n key="IAM.TOS.NEW.PRIVACY.POLICY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.site24x7.site24x7_privacy_summary_url}" target="_blank"><@i18n key="IAM.TOS.SUMMARY.DESC"/></a>
			    			<a class="sep_dot" href="${tos_urls.site24x7.site24x7_privacy_comparison_url}" target="_blank"><@i18n key="IAM.TOS.POLICY.COMPARISON"/></a>
			    		</div>
			    	</#if>
	    		</div>
	    	</div>
	    	</#if>
	    </div>
	    <div class="announcement_description">
		    <#if (country == "br")>
		    	<@i18n key="IAM.TOS.ANNOUNCEMENT.BRAZIL.DESC"/>
		    <#else>
		    	<@i18n key="IAM.TOS.ANNOUNCEMENT.NEW.DESC" arg0="${tos_live_date}" args1="${updated_content}"/>
		    </#if>
	    </div>
		 <div id='errMsg'><@i18n key="IAM.ERROR.TERMS.POLICY" /></div>
	    <button class="continue_button" id="continue_button" onclick='redirect()' id='continueButton' ><@i18n key="IAM.TOS.ANNOUNCEMENT.ACCEPT" /></button>	
	</div>
	<div class="announcement_img"></div>
</div>
</body>
</html>