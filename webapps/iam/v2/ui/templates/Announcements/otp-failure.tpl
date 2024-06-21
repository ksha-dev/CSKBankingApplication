<!DOCTYPE html>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
	<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
	<style>
		@font-face {
			font-family: 'Announcement';
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
			font-weight: normal;
			font-style: normal;
			font-display: block;
	  	}
		[class^="icon-"], [class*=" icon-"] {
		  font-family: 'Announcement' !important;
		  speak: never;
		  font-style: normal;
		  font-weight: normal;
		  font-variant: normal;
		  text-transform: none;
		  line-height: 1;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		}

		.icon-Zoho-oneAuth-logo {
			width: 60px;
			height: 60px;
			display: flex;
    		justify-content: center;
    		align-items: center;
    		font-size: 42px;
			border-radius: 10px;
    		position: absolute;
			top: 0px;
		}
		
		.icon-Zoho-oneAuth-logo .path1:before {
			content: "\e916";
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path2:before {
			content: "\e917";
			margin-left: -1.0009765625em;
			color: rgb(246, 204, 27);
		}
		.icon-Zoho-oneAuth-logo .path3:before {
			content: "\e918";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path4:before {
			content: "\e919";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path5:before {
			content: "\e91a";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path6:before {
			content: "\e91b";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path7:before {
			content: "\e91c";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-pebble:after {
			content: "\e90b";
		}
		.icon-newtab:before {
			content: "\e90a";
		}
		.icon-newtab{
			color: #0093FF;
			font-size: 14px;
			margin-left: 5px;
			display: none;
		}
		body {
			margin:0px;
			color:#000;
		}
		.container{
			margin-top: 80px;
		    width: 940px;
		    display: block;
		    margin-left: auto;
		    margin-right: auto;
		    display: flex;
		}
		.announcement_img {
		    background: url("${SCL.getStaticFilePath('/v2/components/images/sms_delay_illustrations.svg')}") no-repeat;
		    max-width: 350px;
		    height: 340px;
		    background-size: 100% auto;
		    display: inline-block;
		    margin-left: 50px;
		    float: right;
		    flex: 1;
		}
		
		.announcement_content {
			width: 540px;
		    display: inline-block;
		}
		.announcement_heading {
		    font-size: 24px;
		    margin-bottom: 10px;
		    font-weight: 600;
		}
		.announcement_description {
		    font-weight: 400;
		    font-size: 16px;
		    line-height: 24px;
		}
		.zoho_logo {
			display: block;
		    height: 40px;
		    margin-bottom: 20px;
		    background: url("${SCL.getStaticFilePath('/v2/components/images/newZoho_logo.svg')}") no-repeat;
		    background-size: auto 100%;
		    cursor: pointer;
		}
		.oneauth_content_text .why_oneauth_ques
		{
			font-size:16px;
   			margin-bottom: 20px;
   			color: #4E5BBE;
			font-weight: 500;
		}
		.blue_btn {
			background: #1389E3;
			border-radius: 4px;
			margin-top: 30px;
			border: none;
			cursor: default;
			font-size: 14px;
			color: #FFFFFF;
			text-align: center;
			display: inline-block;
			font-weight: 600;
			box-sizing: border-box;
			padding: 12px 24px;
			font-family: 'ZohoPuvi', Georgia !important;
			outline: none;
			cursor: pointer;
		    text-decoration: none;
		}
		.blue_btn:hover {
			background-color: #057AD3;
		}
		.continue_button:hover{
			background: #0779CF;
		}
		.blue_text
		{
			color:#00A7FF;
			font-size:14px;
			font-weight:600;
			cursor:pointer;
			text-decoration: none;
			display:inline-block;
		    margin-top: 20px;
		}
		.announcement_description_text {
			margin-bottom: 20px;
		}
		.announcement_oneauth_box {
			border: 1px dashed #CECECE;
			border-radius: 10px;
			padding: 24px;
			overflow: hidden;
		}
		.announcement_oneauth_content {
			display: flex;
			align-items: flex-start;
			justify-content: space-between;
		}
		.oneauth_list_header {
			padding-left: 12px;
			margin: 0px;
		}
		.oneauth_list_header .oneauth_list_item {
			font-size: 14px;
			margin: 0px;
			padding: 0px;
			margin-top: 12px;
			line-height: 20px;
		}
		.announcement_oneauth_content .oneauth_content_qrcode {
			text-align: center;
		}
		.qrcode_img_box {
			width: 106px;
			height: 106px;
			position: relative;
			border: 3px solid #6E7193;
		}
		.qrcode_img_box .vertical-box {
			width: 80px;
			height: 120px;
			background: white;
		}
		.qrcode_img_box .horizontal-box {
			width: 120px;
			height: 80px;
			background: white;
		}
		.qrcode_img {
			background: url("${SCL.getStaticFilePath('/v2/components/images/sms_delay_oascanqr.png')}") no-repeat;
			width: 90px;
			height: 90px;
   			background-size: contain;
		}
		.oneauth_content_qrcode .qrcode_scan_text {
			font-size: 12px;
			opacity: 0.8;
			font-weight: 600;
			max-width: 104px;
			word-break: break-word;
		}
		.oneauth_download_links {
			display: flex;
			gap: 10px;
			margin-top: 20px;
			flex-wrap: wrap;
		}
		.oneauth_download_links .oneauth_download_link {
			height: 30px;
			cursor: pointer;
			background-size: contain;
		}
		.oneauth_playstore {
			background: url("${SCL.getStaticFilePath('/v2/components/images/Playstore_svg.svg')}") no-repeat;
			width: 102px;
		}
		.oneauth_appstore {
			background: url("${SCL.getStaticFilePath('/v2/components/images/Appstore_svg.svg')}") no-repeat;
			width: 90px;
		}
		.oneauth_macstore {
			background: url("${SCL.getStaticFilePath('/v2/components/images/Macstore_svg.svg')}") no-repeat;
			width: 118px;
			display: none;
		}
		.oneauth_winstore {
			background: url("${SCL.getStaticFilePath('/v2/components/images/Winstore_svg.svg')}") no-repeat;
			width: 90px;
			display: none;
		}
		.oneauth_setup_instruct {
			display: inline-block;
			color: #000;
			font-size: 14px;
			text-decoration: underline;
			opacity: 0.7;
			cursor: pointer;
			margin-top: 20px;
		}
		.announcement_description_btn {
			display: flex;
   			margin-top: 30px;
   			justify-content: space-between;
   			align-items: center;
   			gap: 30px;
		}
		.announcement_description_btn .blue_btn {
			margin-top: 0px;
		}
		.absolute-align-center {
			position: absolute;
			transform: translate(-50%, -50%);
			top: 50%;
			left: 50%;
		}
		.one-auth__icon {
			position: relative;
		}
		.icon-pebble {
			color: #4E5BBE;
			font-size: 60px;
		}
		.oneauth_content_text_box2 .oneauth_content_text:hover .icon-newtab {
			display: inline-block;
		}
		.oneauth_content_text_box2 .oneauth_content_text:hover .oneauth_text_header {
			color: #0093FF;
		}
		.oneauth_content_text_box2 .announcement_oneauth_content {
			display: flex;
			align-items: center;
			margin-bottom: 0px;
			justify-content: space-around;
		}
		.oneauth_content_text_box2 .oneauth_content_wrapper {
			flex: 1;
		}
		.oneauth_content_text_box2 .oneauth_content_text {
			display: flex;
			align-items: center;
			gap: 10px;
			cursor: pointer;
		}
		.oneauth_content_text_box2 .oneauth_text {
			line-height: 18px;
		}
		.oneauth_content_text_box2 .oneauth_text_header {
			font-size: 18px;
		}
		.oneauth_content_text_box2 .oneauth_text_tagline {
			font-size: 14px;
			opacity: 0.6;
		}
		.oneauth_after_install {
			margin-bottom: 20px;
		}
		.oneauth_after_install_box {
			margin-top: 20px;
		}
		.after_install_header {
			font-size: 14px;
			font-weight: 600;
			margin-bottom: 12px;
		}
		.after_install_steps {
			margin: 0px;
			padding: 0px;
			list-style-type: none;
			padding-left: 10px;
			font-size: 14px;
		}
		.after_install_step {
			margin-top: 12px;
			line-height: 20px;
		}
		.oneauth-next-text {
			font-size: 14px;
		}
		.how-to-sign-text {
			font-weight: 500;
			color: #0091FF;
			font-size: 14px;
			text-decoration: none;
		}
		.reminder-btn {
			color: #8B8B8B;
			font-weight: 500;
			text-decoration: none;
			border-bottom: 1px dashed #acacac;
			opacity: 1;
			left: 0px;
			background-color: white;
			position: relative;
			transition : left .4s ease-in;
			font-size: 14px;
			margin-top: 0px;
			cursor: pointer;
		}
		.reminder-btn:hover {
			color: #666666;
		}
		.remind_loader{
			left: -20px;
			pointer-events: none;
  		}
  		.remind_loader::after{
  			content:"";
  			display: inline-block;
  			position: absolute;
  			top: 4px;
  			right: 0px;
			z-index: -2;
			border: 2px solid rgba(255, 255, 255, 0.2);
			border-left: 2px solid;
			border-bottom: 2px solid;
			-webkit-animation: load 1s infinite linear;
			animation: load .7s infinite linear, anim_r .4s 1 forwards ease-in;
			width: 7px;
			height: 7px;
			border-radius: 50px;
		}
		@keyframes anim_r{
			  0%{
			  	right: 0px;
			  }
			  100%{
			  	right: -20px;
			  }
		  }
		.buttdisabled{
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
		.hide {
			display: none;
		}
		@media only screen and (max-width: 800px) and (min-width: 435px)
		{			
			.announcement_img{
				display:none;
			}
			.container{
				width:540px;
			}
		}
		
		@media only screen and (max-width : 435px)
		{
			.announcement_oneauth_box {
				padding: 20px;
			}	
			.announcement_img{
				display:none;
			}
			.oneauth_content_qrcode {
				display: none;
			}
			.container{
			    width: 100%;
			    padding: 0px 20px;
			    box-sizing: border-box;
		        display: block;
	            margin-top: 30px;
			}
			.announcement_content{
			    width: 100%;
			}
			.oneauth-next-text {
				display: inline;
			}
			.oneauth_macstore, .oneauth_winstore {
				display: none !important;
			}
			.blue_btn{
				width: 100%;
			}
			.announcement_description_btn{
				flex-direction: column;
			}
		}
	</style> 
</head>
<body>
<#include "../Unauth/announcement-logout.tpl">	
	 <div class="container">
        <div class="announcement_content">
            <div class="zoho_logo"></div>

            <div class="announcement_heading"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.QUESTION.HEADER"/></div>
            <div class="announcement_heading" style="margin-bottom:20px"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.HEADER"/></div>
            <div class="announcement_description">
            	<div class="announcement_description_text"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.DESCRIPTION"/></div>
        		<div class="announcement_oneauth_box">
	        			<div class="announcement_oneauth_content">
							<div>
								<div class="oneauth_content_text_box1">
									<div class="oneauth_content_text hide-text">
										<div class="why_oneauth_ques"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.WHY.ONEAUTH.QUESTION"/></div>
										<ul class="oneauth_list_header">
											<li class="oneauth_list_item"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.WHY.ONEAUTH.LIST1"/></li>
											<li class="oneauth_list_item"><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.WHY.ONEAUTH.LIST2"/></li>
										</ul>
									</div>
									<div class="oneauth_content_text_box2 hide">
										<div class="oneauth_content_text" onclick="window.open('https://zurl.to/sms_delay_oaweb', '_blank');">
											<div class="one-auth__icon">
												<span class="icon-pebble"></span>
												<span class="icon-Zoho-oneAuth-logo">
													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>
													<span class="path6"></span>
													<span class="path7"></span>
												</span>
											</div>
											<div class="oneauth_text">
												<div class="oneauth_text_header"><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR"/><span class="icon-newtab"></span></div>
												<div class="oneauth_text_tagline"><@i18n key="IAM.ONEAUTH.MFA.TAG"/></div>
											</div>
										</div>
									</div>
									<div class="oneauth_download_links">
										<span class="oneauth_download_link oneauth_playstore" onclick="window.open('https://zurl.to/sms_delay_oaplay', '_blank')"></span>
										<span class="oneauth_download_link oneauth_appstore" onclick="window.open('https://zurl.to/sms_delay_oaips', '_blank')"></span>
										<span class="oneauth_download_link oneauth_macstore" onclick="window.open('https://zurl.to/sms_delay_oamac', '_blank')"></span>
										<span class="oneauth_download_link oneauth_winstore" onclick="window.open('https://zurl.to/sms_delay_msstore', '_blank')"></span>
									</div>
								</div>
							</div>
							<div class="oneauth_content_qrcode">
								<div class="qrcode_img_box">
									<div class="vertical-box absolute-align-center"></div>
									<div class="horizontal-box absolute-align-center"></div>
		        					<div class="qrcode_img absolute-align-center"></div>
								</div>
								<span class="qrcode_scan_text"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN"/></span>
		        			</div>
	        			</div>
						<div class="oneauth_setup_instruct" onclick="showOneAuthDownloadInstruction();"><@i18n key="IAM.INSTRUCTIONS.SET.UP"/></div>
						<div class="oneauth_after_install_box hide">
							<div class="oneauth_after_install">
							<div class="after_install_header"><@i18n key="IAM.AFTER.INSTALLING.ONEAUTH"/></div>
							<ul class="after_install_steps">
								<li class="after_install_step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP1"/></li>
								<li class="after_install_step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP2"/></li>
								<li class="after_install_step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3"/></li>
							</ul>
						</div>
						<div class="oneauth-next-text"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT"/></div>
						<a class="how-to-sign-text" href="https://zurl.to/sms_delay_oaworks" target="_blank"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK"/></a>
        		</div>
            </div>
	    	<div class="announcement_description_btn">
	    		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="blue_btn" onclick ="(function(e){e.target.classList.add('buttdisabled');e.target.querySelector('span').classList.add('loader')})(event);"><span></span><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.SETUP.BUTTON.TEXT"/></a>
	    		<a class="reminder-btn" href="${Encoder.encodeHTMLAttribute(remindme_url)}" onclick="(function(e){e.target.classList.add('remind_loader')})(event);"><@i18n key="IAM.TFA.BANNER.REMIND.LATER"/></a> 
	    	</div>
        </div>
     	</div>
		<div class="announcement_img"></div>
	 </div>
	 <#include "../Unauth/footer.tpl">
	 <script>
		window.onload=function() {
			if(/Mac|Macintosh|OS X/i.test(navigator.userAgent)){
				$(".oneauth_download_links .oneauth_winstore").hide();
				$(".oneauth_download_links .oneauth_macstore").show();
			} else if(/windows|Win|Windows|Trident/i.test(navigator.userAgent)){
				$(".oneauth_download_links .oneauth_macstore").hide();
				$(".oneauth_download_links .oneauth_winstore").show();
			} else {
				$(".oneauth_download_links .oneauth_winstore").show();
				$(".oneauth_download_links .oneauth_macstore").show();
			}
		}
	 	function showOneAuthDownloadInstruction(){
			$(".announcement_description_text").slideUp();
			$(".oneauth_content_text.hide-text").slideUp();
			$(".oneauth_content_text_box2").slideDown(300);
			$(".oneauth_setup_instruct").hide();
			$(".oneauth_after_install_box").slideDown();
		}
	 </script>
</body>
</html>