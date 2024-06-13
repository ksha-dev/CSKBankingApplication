<!DOCTYPE html>
<html>
<head>
<title><@i18n key="IAM.CLIENT.SIGNUP.ADMIN.TAB.TITLE" /></title>
<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<style type=text/css>
		*{
			padding:0;
			margin:0;
		}
		@font-face {
		  font-family: 'signinicon';
		  src:  url('../images/fonts/signinicon.eot');
		  src:  url('../images/fonts/signinicon.eot') format('embedded-opentype'),
		    url('../images/fonts/signinicon.woff2') format('woff2'),
		    url('../images/fonts/signinicon.ttf') format('truetype'),
		    url('../images/fonts/signinicon.woff') format('woff'),
		    url('../images/fonts/signinicon.svg') format('svg');
		  font-weight: normal;
		  font-style: normal;
		  font-display: block;
		}
		p{
			opacity:0.8;
		}
		.main{width: 570px;height: auto;margin: auto;box-sizing: border-box;margin-top:140px;}
		@media (max-width:600px){#userProfileName{display:none;}}
		@media (max-width:570px){.main{width:100%;padding:0px 30px 0px 30px;}}
	</style>
</head>
<body>
	<div class="main">
		<img src="${SCL.getStaticFilePath("/v2/components/images/SandClock.png")}" style="display: block;width: auto;height: 95px;margin: auto;">
		<div class="access_denied-heading" style="margin-top:40px;font-size: 24px;display: block;text-align: center; font-weight:600;">
			<span style="margin-top:40px;"><@i18n key="IAM.CLIENT.SIGNUP.ADMIN.TITLE" /></span>
		</div>
		<div class="access_denied-decsription" style="font-size: 16px;display: block;text-align: center;margin-top:20px;">
			<p><@i18n key="IAM.CLIENT.SIGNUP.ADMIN.DOMAIN.SAML.FED" arg0="${org_name}"/></p>
		</div>
		<div style="font-size: 16px;display: block;text-align: center;margin-top:20px;">
			<p><@i18n key="IAM.CLIENT.SIGNUP.ADMIN.CONTACT.MAIL.SAML.FED" arg0="${owner_email}"/></p>
		</div>
	</div>
</body>
</html>