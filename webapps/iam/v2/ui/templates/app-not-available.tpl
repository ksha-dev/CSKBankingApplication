<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><@i18n key="IAM.APP.NOT.AVAILABLE"/></title>
	<@resource path="/v2/components/css/${customized_lang_font}" />
	<style>
		@font-face {
		  font-family: 'signinicon';
		  src:  url('/v2/components/images/fonts/signinicon.eot');
		  src:  url('/v2/components/images/fonts/signinicon.eot') format('embedded-opentype'),
		    url('/v2/components/images/fonts/signinicon.woff2') format('woff2'),
		    url('/v2/components/images/fonts/signinicon.ttf') format('truetype'),
		    url('/v2/components/images/fonts/signinicon.woff') format('woff'),
		    url('/v2/components/images/fonts/signinicon.svg') format('svg');
		  font-weight: normal;
		  font-style: normal;
		  font-display: block;
		}
      	body {
        	margin: 0;
        	box-sizing: border-box;
        	font-family: "ZohoPuvi";
      	}
		.bg {
			display: block;
			position: fixed;
			top: 0px;
			left: 0px;
			height: 100%;
			width: 100%;
			background: url('/v2/components/images/smartsigninbg.svg') transparent; 
			background-size: auto 100%;
			z-index: -1;
		}
		.container{
			width: 460px;
			padding: 50px;
			background: #FFFFFF 0% 0% no-repeat padding-box;
			box-shadow: 0px 0px 16px #00000014;
			border: 1px solid #DBDBDB;
			border-radius: 8px;
			margin: auto;
		    margin-top: auto;
			margin-top: 150px;
			box-sizing: border-box;
		}
		.restrictionIcon:before {
			content: "\e974";
			font-size:80px;
		  	color:#D8454F;
		}
		.restrictionIcon{
			width: 80px;
			height: 80px;
			font-family: 'signinicon' !important;
			margin: auto;
			margin-bottom: 24px;
		}
		.zoho_logo{
			display: block;
			height: 40px;
			width: auto;
			margin:auto;
			background: url('/v2/components/images/newZoho_logo.svg') no-repeat transparent;
			background-size: auto 100%;
			background-position: center;
			margin-bottom: 20px;
		}
		.headContent{
			font: normal normal 600 20px/23px ZohoPuvi;
			text-align: center;
			margin-bottom: 24px;
		}
		.descContentOne,.descContentTwo,.goToHomePage{
			font-size: 14px;
			text-align: center;
			letter-spacing: 0.14px;
			margin-bottom: 24px;
		}
		.descContentTwo a{
			color: #1389E3;
			text-decoration: none;
		}
		.goToHomePage a{
			font: normal normal 600 14px/16px ZohoPuvi;
			letter-spacing: 0.14px;
			color: #1389E3;
			text-decoration: none;
			margin :auto;
		}
		@media only screen and (max-width: 600px) {
			.container {
				width:100%;
			    margin: 0px auto;
			    box-shadow: none;
			   	margin-top: 25%;
			   	height:auto;
			    border: none;
			    padding: 20px;
			}
			.bg{display: none}
		}
	</style>
</head>
<body>
	<#include "Unauth/announcement-logout.tpl">
	<div class="bg"></div>
	<div class="container">
		<div class="zoho_logo"></div>
		<div class="restrictionIcon"></div>
		<div class="headContent"><@i18n key="IAM.APP.NOT.AVAILABLE"/></div>
		<div class="descContentOne"><@i18n key="IAM.APP.NOT.AVAILABLE.DESCRIPTION.ONE" arg0="${current_dc}"/></div>
		<div class="descContentTwo"><@i18n key="IAM.APP.NOT.AVAILABLE.DESCRIPTION.TWO" arg0="${service_name}" arg1="${learn_how_link}"/></div>
		<div class="goToHomePage"><a target="_self" href="/home"><@i18n key="IAM.GOTO.ZOHO.ACCOUNTS"/></a></div>
	</div>
	<#include "Unauth/footer.tpl">
</body>
</html>