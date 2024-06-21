<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title><@i18n key="IAM.TOS.ANNOUNCEMENT.HEADER"/></title>
<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
<style>
body {
	margin:0px;
	padding:0px;
}
@font-face {
	 font-family: 'TOS';
	 src:  url('${SCL.getStaticFilePath("/v2/components/images/tos.eot")}');
	 src:  url('${SCL.getStaticFilePath("/v2/components/images/tos.eot")}') format('embedded-opentype'),
	   url('${SCL.getStaticFilePath("/v2/components/images/fonts/tos.woff2")}') format('woff2'),
	   url('${SCL.getStaticFilePath("/v2/components/images/fonts/tos.ttf")}') format('truetype'),
	   url('${SCL.getStaticFilePath("/v2/components/images/fonts/tos.woff")}') format('woff'),
	   url('${SCL.getStaticFilePath("/v2/components/images/fonts/tos.svg")}') format('svg');
	 font-weight: normal;
	 font-style: normal;
	 font-display: block;
}
[class^="icon-"], [class*=" icon-"] {
	/* use !important to prevent issues with browser extensions that change fonts */
	font-family: 'TOS' !important;
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
.icon-up_small:before {
  content: "\e90d";
}
.icon-up_large:before {
  content: "\e90c";
}
.continue {
	background-color: #6DA60A;
	border: 1px solid #65990B;
	color: #FFFFFF;
	font-size: 14px;
	padding: 6px 14px;
	text-decoration: none;
}

.container{
	margin-top: 120px;
    width:880px;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.announcement_img {
    background: url('${SCL.getStaticFilePath("/v2/components/images/TOS.png")}') no-repeat;
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

.org_logo,.header_org_logo {
	display: block !important;;
    height: 32px !important;
    margin-bottom: 20px;
}
.announcement_heading {
	font-size: 24px;
	margin-bottom: 20px;
	font-weight: 500;
	line-height: 26px;
}
.header_announcement_heading
{
	font-size: 24px;
	font-weight: 500;
	line-height: 26px;
    width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.announcement_description {
	font-weight: 400;
	font-size: 15px;
	line-height: 24px;
	margin-bottom: 30px;
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
.continue_button:hover {
	background: #0779CF;
}
.continue_button:disabled {
    opacity: .8;
    cursor: not-allowed;
}
.tos_content {
	height: 340px;
	width:540px;
    margin-bottom: 30px;
    box-shadow: inset 0px 0px 20px #0000000F;
	border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
    line-height: 20px;
    overflow:auto;
}
.tos_content .container_with_border {
	border: 1px solid #EFEFEF;
	border-radius: 5px;
	overflow: hidden;
    height: 338px;
    width: 538px;
    position:absolute;
    transition: all .3s ease-in-out;
    outline: unset;
}
.tos_content .content_area {
    width: 100%;
    height:340px;
    overflow: auto;
    padding: 20px 30px;
    scroll-behavior: smooth;
    box-sizing: border-box;
}
.disable_transition
{
	transition:unset !important;
}
.agree_text {
	font-size:14px;
}

.tos-container {
	position: relative;
    display: grid;
    grid-template-columns: 22px auto;
}
.agree_checkbox {
    cursor: pointer;
    border: none;
    outline: none;
    width: 0px;
    height: 0px;
    position: relative;
    margin: 2px 0px;
    border-radius: 3px;
    opacity: 0;
}
.agree_checkbox+label {
    font-size: 14px;
    letter-spacing: -0.3px;
    line-height: 20px;
    cursor: pointer;
}
.agree_checkbox+label:before {
    content: "";
    width: 16px;
    display: inline-block;
    height: 16px;
    border: 2px solid #E9E9E9;
    border-radius: 3px;
    box-sizing: border-box;
    background: #fff;
    position: absolute;
    left: 0px;
    top: 2px;
}
.agree_checkbox+label:after {
    content: "";
    width: 5px;
    display: inline-block;
    height: 10px;
    border: 2px solid #fff;
    border-left: transparent;
    border-top: transparent;
    border-radius: 1px;
    box-sizing: border-box;
    position: absolute;
    left: 5px;
    top: 4px;
    transform: rotate(45deg);
}
.agree_checkbox:checked+label:before {
    background: #1389E3;
    border-color: #1389E3;
}
.tos-container:hover label:before {
    border-color: #1389E3;
}
.pop_float_btn {
	position: absolute;
    width: 30px;
    height: 30px;
    z-index:1;
    border-radius: 9px;
    border: 1px solid #F4F4F4;
    box-shadow: 0px 0px 12px #00000012;
    background: #fff;
    box-sizing: border-box;
    top: 20px;
    right:18px;
    cursor:pointer;
    opacity:.9;
    transition: all 0.3s ease-in-out;
}
.button-arrow
{
    position: absolute;
    font-size: 18px;
    color: #838383;
    transition: all 0.3s ease-in-out;
}
.top_arrow
{
    transform: rotate(45deg);
    left: 8px;
    top: 2px;
}
.bottom_arrow
{
	top: 8px;
    left: 2px;
	transform: rotate(225deg);
}
.pop_float_btn:hover {
	opacity:1;
}
.pop_float_btn:hover > .top_arrow
{
	left: 10px;
    top: 0px;
    color: #6A6A6A;
    transform: rotate(45deg) scale(1.1);
}
.pop_float_btn:hover > .bottom_arrow{
	top: 10px;
    left: 0px;
    color: #6A6A6A;
	transform: rotate(225deg) scale(1.1);
}
.close_btn .button-arrow,.close_btn:hover > .button-arrow{
	transform: unset;
    top: -2px;
    left: 8px
}
.close_btn .button-arrow::before {
    content: "";
    width: 12px;
    height: 2px;
    background-color: #838383;
    display: inline-block;
    border-radius: 2px;
}
.close_btn .top_arrow::before {
    transform: rotate(45deg);
}
.close_btn .bottom_arrow::before {
    transform: rotate(-45deg);
}
.popup_header
{
	position:absolute;
    padding: 30px 50px 15px 50px;
	top:0px;
    box-shadow: 0px 10px 20px 5px #fff;
	display:none;
    width: 100%;
    box-sizing: border-box;
    background: #fff;
}
.view_tos_content .popup_header
{
	display:block;
}
.scroll_flt_btn
{
    width: 30px;
    height: 30px;
    position: absolute;
    right:18px;
    bottom: -50px;
    transition: bottom .3s ease-in-out;
    border: 1px solid #F4F4F4;
    box-shadow: 0px 0px 12px #00000012;
    background: #fff;
    border-radius: 8px;
    opacity:.9;
    color:#838383;
    cursor:pointer;
    font-size: 20px;
    line-height: 30px;
    text-align: center;
}
.scroll_flt_btn:hover
{
	opacity:1;
}
.scroll_flt_btn:before
{
	transition: all .3s ease-in-out;
	display:inline-block;
}
.scroll_flt_btn:hover:before
{
    transform: scale(1.1);
}
.go_top
{
	bottom: 20px;
}
.white_blur
{
    position: absolute;
    bottom: -2px;
    left: 0px;
    right: 0px;
    border-radius: 0px 0px 8px 8px;
    height: 50px;
    background-image: linear-gradient(transparent,#fff);
}
.view_tos_content .container_with_border {
	position: fixed;
    width: 720px;
    bottom: 50px;
    top: 50px !important;
    height:auto;
    z-index:2;
}
.view_tos_content .content_area {
    width: 720px;
    height: 100%;
    padding: 138px 50px 30px 50px;
}
.view_tos_content .announcement_content>div,.view_tos_content .announcement_img,.view_tos_content button,.view_tos_content .continue_button{
	opacity:0;
}
.view_tos_content .announcement_content div.tos_content {
	opacity:1;
}
.view_tos_content .tos_content {
	box-shadow:unset;
}
.view_tos_content .white_blur {
    left: 0px;
    right: 0px;
    position: fixed;
    bottom: 51px;
    width: 720px;
    margin: auto;
    border-radius: unset;
}
.blur
{
	position: absolute;
    background: #fff;
    top: 0px;
    left: 0px;
    right: 0px;
    bottom: 0px;
    z-index: 1;
    display:none;
}
.btndisabled{
	opacity: 0.5;
	pointer-events: none;
}
.loader {
	display: inline-block;
	border-radius: 50%;
  	width: 10px;
  	height: 10px;
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
	.tos_content,.view_tos_content .content_area{
		width: 100%;
	}
	.tos_content .container_with_border{
		width: 90%;
	}
	.view_tos_content .container_with_border
	{
	    top: 0px !important;
	    bottom: 0px;
	    height: 100%;
	    width: 100%;
	}
	.view_tos_content .white_blur
	{
		display:none;
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
    		background: url('${SCL.getStaticFilePath("/v2/components/images/TOS2x.png")}') no-repeat;
    		background-size: 100% auto;
    	}
    }
</style>
<script>

</script>
</head>
<body>
<div class="container" id="container">
	<div class="announcement_content">
		<div class="org_logo"><#if ((logo_url)?has_content)><img height="32px" width="auto" src="${logo_url}" /></#if></div>
		<#if ((org_name)?has_content)>
		<div class="announcement_heading"><@i18n key="IAM.TOS.CUSTOM.ANNOUNCEMENT.HEADER" arg0="${org_name}" /></div>
		</#if>
	    <div class="announcement_description"><@i18n key="IAM.TOS.CUSTOM.ANNOUNCEMENT.DESC"/></div>
	    
	    <div class="tos_content" id="tos_content">
	    	<div class="container_with_border" id="container_with_border" tabindex="1">
	    		<div class="popup_header">
	    			<div class="header_org_logo"><#if ((logo_url)?has_content)><img height="32px" width="auto" src="${logo_url}" /></#if></div>
					<#if ((org_name)?has_content)>
					<div class="header_announcement_heading"><@i18n key="IAM.TOS.CUSTOM.ANNOUNCEMENT.HEADER" arg0="${org_name}" /></div>
					</#if>
	    		</div>
				<div class="pop_float_btn" id="pop_float_btn" onclick="toggleTOSContent()">
					<div class="button-arrow top_arrow icon-up_small"></div>
					<div class="button-arrow bottom_arrow icon-up_small"></div>
				</div>
		    	<div class="content_area" id="content_area">
		    	</div>
				<div class="white_blur"></div>
				<div class="scroll_flt_btn icon-up_large" id="scroll_flt_btn"></div>
			</div>
	    </div>
	    <div class="tos-container">
			<input tabindex="1" class="agree_checkbox" type="checkbox" id="tos_agree" name="agree" onclick="changeAgreedStatus()">
			<label for="tos_agree"><@i18n key="IAM.TOS.CUSTOM.ANNOUNCEMENT.AGREE.TOS" /></label>
		</div>

	    <button class="continue_button" id="continue_button" disabled onclick="window.open('${Encoder.encodeJavaScript(nxt_preann_url)}','_self');(function(e){e.target.classList.add('btndisabled'); e.target.querySelector('span').classList.add('loader')})(event);" id='continueButton' ><span></span><@i18n key="IAM.TOS.ANNOUNCEMENT.ACCEPT" /></button>
	</div>
	<div class="blur" id="bg_blur" onclick="toggleTOSContent()"></div>
	<div class="announcement_img"></div>
</div>
<#include "../Unauth/footer.tpl">
</body>
<script>
window.onload = function(){
	<#if ((tos)?has_content)>
	var tos_content_text = '${tos}';
	document.getElementById("content_area").innerHTML = tos_content_text;
	</#if>
	document.getElementById("container_with_border").classList.add("disable_transition");
	document.getElementById("container_with_border").style.left = document.getElementById("tos_content").offsetLeft+"px";
	document.getElementById("container_with_border").style.top = document.getElementById("tos_content").offsetTop+"px";
	document.getElementById("container_with_border").classList.remove("disable_transition");
	document.getElementById("content_area").onscroll = function(e){
		if(e.target.scrollTop > document.getElementById("container_with_border").clientHeight){
			document.getElementById("scroll_flt_btn").classList.add("go_top");
		}
		else{
			document.getElementById("scroll_flt_btn").classList.remove("go_top");
		}
	}
}
window.addEventListener("resize",function(){
	document.getElementById("container_with_border").classList.add("disable_transition");
	if(!document.getElementById("container").classList.contains("view_tos_content")){
		document.getElementById("container_with_border").style.left = document.getElementById("tos_content").offsetLeft+"px";
		document.getElementById("container_with_border").style.top = document.getElementById("tos_content").offsetTop+"px";
	}
	else{
		var popupLeftValue = (window.innerWidth - 720) / 2 ;
		document.getElementById("container_with_border").style.left = popupLeftValue > 0 ? popupLeftValue+"px" : 0+"px";
	}
	document.getElementById("container_with_border").classList.remove("disable_transition");
});

function toggleTOSContent(){
	if(!document.getElementById("container").classList.contains("view_tos_content")){
		document.getElementById("bg_blur").style.display = "block";
		document.getElementById("footer").style.display = "none";
		document.getElementById("pop_float_btn").classList.add("close_btn");
		document.getElementById("container").classList.add("view_tos_content");
		document.getElementById("tos_content").style.boxShadow = "unset";
		var popupLeftValue = (window.innerWidth - 720) / 2 ;
		document.getElementById("container_with_border").style.left = popupLeftValue > 0 ? popupLeftValue+"px" : 0+"px";
		document.getElementById("container_with_border").addEventListener("keydown",handleEsc);
		document.getElementById("container_with_border").focus();
	}
	else{
		document.getElementById("footer").style.display = "block";
		document.getElementById("bg_blur").style.display = "none";
		document.getElementById("pop_float_btn").classList.remove("close_btn");
		document.getElementById("container_with_border").style.left = document.getElementById("tos_content").offsetLeft+"px";
		document.getElementById("container_with_border").style.top = document.getElementById("tos_content").offsetTop+"px";
		document.getElementById("container").classList.remove("view_tos_content");
		document.getElementById("content_area").style.background = "#fff";
		document.getElementById("tos_content").style.boxShadow = "unset";
		document.getElementById("container_with_border").removeEventListener("keydown",handleEsc);
		setTimeout(function(){
			document.getElementById("content_area").style.background = "unset";
			document.getElementById("tos_content").style.boxShadow = "inset 0px 0px 20px #0000000f";
		},300);
	}
}
function handleEsc(event){
	if(event.keyCode == 27){toggleTOSContent()}
}
function changeAgreedStatus(){
	if(document.getElementById("tos_agree").checked){
		document.getElementById("continue_button").disabled = false;
		document.getElementById("content_area").scrollTop = document.getElementById("content_area").scrollHeight;
	}
	else{
		document.getElementById("continue_button").disabled = true;
	}
}
</script>
</html>