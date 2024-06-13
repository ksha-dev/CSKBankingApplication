<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
    <link rel="prefetch" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}" type="font/woff2" crossorigin="anonymous">
    <link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    <title>OneAuth V3</title>
    <style>
    
      @font-face {
        font-family: "Announcement";
		src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
		src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
			url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
        font-weight: normal;
        font-style: normal;
        font-display: block;
      }s
      [class^="icon-"],
      [class*=" icon-"] {
        font-family: "Announcement" !important;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }

      .icon-MDM .path1:before {
        content: "\e91d";
        color: rgb(235, 84, 67);
      }
      .icon-MDM .path2:before {
        content: "\e91e";
        margin-left: -0.8330078125em;
        color: rgb(1, 113, 187);
      }
      .icon-MDM .path3:before {
        content: "\e91f";
        margin-left: -0.8330078125em;
        color: rgb(78, 178, 66);
      }
      .icon-Microsoft .path1:before {
        content: "\e922";
        color: rgb(242, 80, 34);
      }
      .icon-Microsoft .path2:before {
        content: "\e923";
        margin-left: -1em;
        color: rgb(127, 186, 0);
      }
      .icon-Microsoft .path3:before {
        content: "\e924";
        margin-left: -1em;
        color: rgb(255, 185, 0);
      }
      .icon-Microsoft .path4:before {
        content: "\e925";
        margin-left: -1em;
        color: rgb(0, 164, 239);
      }
      .icon-OneAuth .path1:before {
        content: "\e926";
        color: rgb(76, 83, 161);
      }
      .icon-OneAuth .path2:before {
        content: "\e927";
        margin-left: -1em;
        color: rgb(255, 255, 255);
      }
      .icon-OneAuth .path3:before {
        content: "\e928";
        margin-left: -1em;
        color: rgb(246, 204, 27);
      }
      .icon-OneAuth .path4:before {
        content: "\e929";
        margin-left: -1em;
        color: rgb(255, 255, 255);
      }
      .icon-OneAuth .path5:before {
        content: "\e92a";
        margin-left: -1em;
        color: rgb(255, 255, 255);
      }
      .icon-OneAuth .path6:before {
        content: "\e92b";
        margin-left: -1em;
        color: rgb(255, 255, 255);
      }
      .icon-OneAuth .path7:before {
        content: "\e92c";
        margin-left: -1em;
        color: rgb(255, 255, 255);
      }
      .icon-OneAuth .path8:before {
        content: "\e92d";
        margin-left: -1em;
        color: rgb(255, 255, 255);
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
      .icon-Android:before {
        content: "\e921";
        color: #3ddb85;
      }
      .icon-Apple:before {
        content: "\e920";
      }
      .oneauthpath {
        font-size: 40px;
      }
      html,
      body {
        box-sizing: border-box;
        padding: 0;
        margin: 0;
        font-family:"ZohoPuvi"
      }
      .blur {
        height: 100%;
        width: 100%;
        position: fixed;
        z-index: -4;
        background-color: #000;
        transition: background-color 0.2s ease-in-out, opacity 0.2s ease-in-out;
        opacity: 0;
        top: 0px;
        left: 0px;
      }
      .close-btn {
        box-sizing: border-box;
        height: 30px;
        width: 30px;
        border-radius: 50%;
        cursor: pointer;
        position: absolute;
        right: 24px;
        top: 24px;
        background-color: #f3f3f3;
      }
      .close-btn:hover {
        background-color: #e6e6e6;
      }
      .close-btn:before,
      .close-btn:after {
        display: block;
        content: "";
        height: 14px;
        width: 2px;
        background-color: #ababab;
        margin: auto;
        border-radius: 1px;
        transform: rotate(-45deg);
        position: relative;
        top: 8px;
      }
      .close-btn:after {
        top: -6px;
        transform: rotate(45deg);
      }
      .wrapper {
        display: flex;
        justify-content: center;
        gap: 50px;
        flex: 1 0 600px;
      }
      .mainCont {
        display: inline-block;
        max-width: 600px;
        min-width: 300px;
        padding-top: 100px;
        padding-right: 4%;
        padding-left: 10%;
      }
      .illusCont {
        padding-top: 100px;
        padding-right: 10%;
      }
      .illustration {
        width: 350px;
        height: 350px;
        display: inline-block;
       	background: url("${SCL.getStaticFilePath("/v2/components/images/oneauth_v3_update.svg")}") no-repeat;

      }
      .headlogo {
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        background-color: #4e5bbe;
        border-radius: 15px;
        font-size: 44px;
      }
      .main-title {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
      }
      .version-details {
        margin-bottom: 30px;
      }
      .details-title {
        font-size: 16px;
        font-weight: 600;
        line-height: 20px;
        margin-bottom: 20px;
      }
      .detail-point {
        display: flex;
        gap: 15px;
        margin-bottom: 10px;
      }
      .det-icon::before {
        display: block;
        content: "";
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background-color: #848484;
      }
      .det-text {
        font-size: 14px;
        font-weight: 400;
        line-height: 20px;
      }
      .down-links {
        display: flex;
        max-width: 420px;
        flex-wrap: wrap;
        gap: 10px;
        row-gap: 20px;
        margin-bottom: 20px;
      }
      .dnlink {
        border: 1px solid #ebebeb;
        border-radius: 5px;
        background-color: #f8f8f8;
        cursor: pointer;
        position: relative;
        padding: 5px 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        min-width: 94px;
        box-sizing: content-box;
      }
      .close-btn {
        float: right;
      }
      .msg-popup {
        max-width: 600px;
        background-color: #ffffff;
        position: relative;
        z-index: 2;
        max-height: 0px;
        overflow: hidden;
      }
      .popup-body {
        font-size: 14px;
        line-height: 20px;
      }
      .textQr {
        display: flex;
        flex-direction: row;
        gap: 50px;
        justify-content: space-between;
      }
      .pop-qr {
        flex: 1 0 130px;
        min-height: 120px;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 4px;
      }
      .actbut {
        margin-top: 30px;
        display: flex;
        gap: 20px;
        align-items:center;
        max-width: 240px;
        flex-wrap: wrap;
      }
      .later {
        color: #00a7ff;
        font-weight: 600;
        font-size: 14px;
        line-height: 24px;
        cursor: pointer;
      }
      .proceed{
      	font-size:14px;
      	font-weight: 600;
      	line-height: 20px;
      	text-decoration: none;
      	color: #ffffff;
      	background-color: #1389E3;
      	padding: 10px 30px;
      	border-radius: 4px;
      	cursor: pointer;
      }
      .proceed.back{
      	background-color: #F8F8F8;
      	color: #000000;
      	font-weight: 500;
      }
      .pop-text > .msg > div {
        margin-bottom: 15px;
      }
      .warn {
        color: #ed473f;
      }
      .later {
        font-weight: 500;
        color: #000000;
        opacity: 0.7;
        text-decoration: underline;
      }
      .downref {
        color: #00a7ff;
        text-decoration: none;
        font-weight: 500;
      }
      @keyframes slideD {
        0% {
          top: 20px;
          opacity: 0;
        }
        100% {
          top: 36px;
          opacity: 1;
        }
      }
      .det-icon {
        position: relative;
        top: 8px;
      }
      button{
      	font-family: "ZohoPuvi";
      }
      .dntext {
        display: inline-block;
        pointer-events: none;
        text-align: left;
      }
      .dnlogo {
        display: inline-flex;
        pointer-events: none;
      }
      .dntext div:first-child {
        font-size: 10px;
        line-height: 12px;
        font-weight: 500;
      }
      .dntext div:last-child {
        font-size: 14px;
        line-height: 16px;
        font-weight: 600;
      }
      .dntext.other div{
      	font-size: 12px;
      	font-weight: 500;
      	line-height: 28px;
      }
      .linkblack {
        background-color: #000;
        color: #ffffff;
        border-color: #bababa;
      }
      .icon-Android {
        font-size: 20px;
      }
      .icon-Apple {
        font-size: 22px;
      }
      .icon-MDM {
        font-size: 22px;
      }
      .icon-microsoft{
      	font-size: 20px
      }
  	  .other-opts .icon-microsft{
  		font-size: 16px;
  	  }
      .rblur {
        animation: 0.5s ease-in-out opac forwards 1;
      }
      .testflight-qr {
        background: url("${SCL.getStaticFilePath("/v2/components/images/testflight_v3_qr.png")}") no-repeat;
      }
      .android-qr {
        background: url("${SCL.getStaticFilePath("/v2/components/images/android_v3_qr.png")}") no-repeat;
      }
      .canslink-qr {
        background: url("${SCL.getStaticFilePath("/v2/components/images/cans_v3_qr.png")}") no-repeat;
      }
      .microsoft-qr {
        background: url("${SCL.getStaticFilePath("/v2/components/images/windows_v3_qr.png")}") no-repeat;
      }
      .dot:first-child {
        margin-right: 20px;
      }
      .sub-head{
      	font-weight: 600;
      }
      .dot::before {
        content: "";
        display: inline-block;
        width: 6px;
        height: 6px;
        background-color: #b5b5b5;
        border-radius: 50%;
        margin-right: 5px;
        position: relative;
        top: -2px;
      }
      .qr {
        width: 110px;
        height: 110px;
        position: relative;
        background-size: 90px 90px;
        background-position: center;
      }
      .cont_note{
      	margin-top: 30px;
      	font-size: 14px;
      	line-height: 20px;
      	font-style: italic;
      	color: #E56000;
      }
      .qr-desc {
        font-weight: 600;
        margin-top: 10px;
        text-align: center;
        max-width: 130px;
      }
      .top,
      .bottom {
        position: absolute;
        width: 20px;
        height: 20px;
        pointer-events: none;
      }
      .top {
        top: 0;
        border-top: 3px solid #585858;
      }
      .bottom {
        bottom: 0;
        border-bottom: 3px solid #585858;
      }
      .left {
        left: 0;
        border-left: 3px solid #585858;
        border-top-left-radius: 4px;
      }
      .right {
        right: 0;
        border-right: 3px solid #585858;
        border-top-right-radius: 4px;
      }
      .bottom.left {
        border-top-left-radius: 0px;
        border-bottom-left-radius: 4px;
      }
      .bottom.right {
        border-top-right-radius: 0px;
        border-bottom-right-radius: 4px;
      }
      @keyframes slidedown {
        0% {
          top: 20px;
        }
        100% {
          top: 100px;
        }
      }
      @keyframes opac {
        0% {
          opacity: 1;
        }
        100% {
          opacity: 0;
        }
      }
      div.arrow{
      	display: inline-block;
    	border-bottom: 1px solid;
    	border-left: 1px solid;
    	width: 3px;
    	height: 3px;
    	transform: rotate(-45deg);
    	border-color: #A5A5A5;
    	pointer-events: none;
      }
      .wrap{
      	display: flex;
      	flex-direction: column;
      	max-width: 1200px;
      	margin: auto;
      	height: 100vh;
      }
      .footer-flex{
      	margin: 20px 0;
      	font-size: 14px;
      	line-height: 20px;
      	font-weight: 400;
      	color: #7E7E7E;
      	text-align: center;
      }
      .popups{
      	display: block;
     	transition: top 0.3s ease-in-out, opacity 0.3s ease-in-out;
      	position :absolute;
      	opacity: 0;
     	padding-right: 30px;
      }
      .main-details{
      	transition: opacity 0.2s ease-in-out .1s;
      }
      .mainslide{
      	opacity: 0;
      }
	  .popslide {
        /*top: 0 !important;*/
        opacity : 1;
      }
      .another-wrap{
      	position:relative;
      }
      @media only screen and (min-width: 435px) and (max-width: 980px) {
        .wrapper {
          padding: 50px 25px 0px 25px;
        }
        .mainCont {
          padding: 0;
         
        }
        .illusCont,
        .pop-qr,
        .mobhide {
          display: none;
        }
      }
      @media only screen and (max-width: 435px) {
        .wrapper {
          padding: 50px 30px 0px 30px;
        }
        .mainCont {
          width: 100%;
          padding: 0;
        }
        .illusCont,
        .pop-qr,
        .mobhide {
          display: none;
        }
      }
      }
    </style>
  </head>
  <body>
  	<#include "../Unauth/announcement-logout.tpl">
    <div style="display: none">
      <div class="microsoft-msg msg">
      	<div class="sub-head">Download for Windows</div>
        <div>
          1. if you've previously installed the OneAuth test build, uninstall that version(App setting > Uninstall).
          <span class="warn">Before uninstalling, make sure you're signed in to OneAuth on your mobile device.</span>
        </div>

        <div>
          2. Download and install the app from <a href="https://zurl.to/oa_windows_v3" tabindex="2" target="_blank" class="downref">Microsft Store</a>.
          <div class="mobhide">You can aslo scan the QR code to download</div>
        </div>
      </div>
      <div class="mdmapp-msg msg">
        <div class="sub-head">Update via MDM app</div>
		<div class="warn">Don’t uninstall the existing version of OneAuth.</div>
        <div>1. Open the MDM app on your Phone.</div>
        <div>2. Go to App Catalog.</div>
        <div>3. Update the OneAuth app.</div>
      </div>
      <div class="android-head"></div>
      <div class="android-msg msg">
        <div class="sub-head">Download APK for Android</div>
        <div class="warn">Don’t uninstall the existing version of OneAuth.</div>
        <div>
          1. Download the APK file from this <a href="https://zurl.to/oa_apk_v3" tabindex="2" target="_blank" class="downref">WorkDrive link</a>.
          <div class="mobhide">You can also scan the QR code to download.</div>
        </div>
        <div>2. Install the app.</div>
      </div>
      <div class="testflight-msg msg">
        <div class="sub-head">Update via TestFlight</div>
		<div class="warn">Don’t uninstall the existing version of OneAuth.</div>
        <div>1. Install the <a href="https://apps.apple.com/in/app/testflight/id899247664" target="_blank" tabindex="2" class="downref">TestFlight app</a> from App Store.</div>
        <div>
          2. Open this  <a href="https://zurl.to/oa_iostestflight_v3" target="_blank" tabindex="2" class="downref">invitation link</a> and install OneAuth 3.0.
          
        </div>
      </div>
      <div class="canslink-msg msg">
        <div class="sub-head">Download via CANS</div>
       <div class="warn">Don’t uninstall the existing version of OneAuth.</div>
        <div>1. Go to this <a href="https://zurl.to/oa_cans_v3" tabindex="2" target="_blank" class="downref">CANS link</a>.</div>
        <div>2. Select your device OS (iOS or Android).</div>
        <div>3. Download the file and install.</div>
      </div>
    </div>
    <div class="wrap">
    <main class="wrapper">
      <div class="mainCont">
        <div class="headlogo icon-Zoho-oneAuth-logo">
          <span class="path1"></span>
          <span class="path2"></span>
          <span class="path3"></span>
          <span class="path4"></span>
          <span class="path5"></span>
          <span class="path6"></span>
          <span class="path7"></span>
        </div>
        <div class="main-title">Update to the latest version of OneAuth (3.0)</div>
       <div class="another-wrap">
       <div class="main-details">
        <div class="version-details">
          <div class="details-title">What's included in this update?</div>
          <div class="detail-point">
            <div class="det-icon"></div>
            <div class="det-text">Folders to organize and sort your 2FA accounts.</div>
          </div>
          <div class="detail-point">
            <div class="det-icon"></div>
            <div class="det-text">A quick & easy way to import your 2FA accounts from Google Authenticator.</div>
          </div>
          <div class="detail-point">
            <div class="det-icon"></div>
            <div class="det-text">Integration with Zoho Vault extension to auto-fill OTPs during sign-in.</div>
          </div>
          <div class="detail-point">
            <div class="det-icon"></div>
            <div class="det-text">And, OneAuth is now available for Windows.</div>
          </div>
        </div>
        <div class="down-links" onclick="handleDownload(event)">
          <button class="dnlink android linkblack" style="order:1;">
            <div class="dnlogo icon-Android"></div>
            <div class="dntext">
              <div>Download .apk for</div>
              <div>Android</div>
            </div>
          </button>
          <button class="dnlink testflight linkblack" style="order:2;">
            <div class="dnlogo icon-Apple"></div>
            <div class="dntext">
              <div>Update via</div>
              <div>TestFlight</div>
            </div>
          </button>
           <button class="dnlink microsoft linkblack" style="display:none;order:3;">
            <div class="dnlogo icon-Microsoft">
              <span class="path1"></span>
              <span class="path2"></span>
              <span class="path3"></span>
              <span class="path4"></span>
            </div>
            <div class="dntext">
              <div>Download from</div>
              <div>Microsoft</div>
            </div>
          </button>
          <button class="dnlink other-opts" style="order:4;">
            <div class="dnlogo icon-Microsoft">
              <span class="path1"></span>
              <span class="path2"></span>
              <span class="path3"></span>
              <span class="path4"></span>
            </div>
            <div class="dnlogo icon-MDM">
              <span class="path1"></span>
              <span class="path2"></span>
              <span class="path3"></span>
            </div>
            <div class="dntext other">
              <div>other options</div>
            </div>
            <div class="arrow"></div>
          </button>
          <button class="dnlink mdmapp" style="display:none;order:5;">
            <div class="dnlogo icon-MDM">
              <span class="path1"></span>
              <span class="path2"></span>
              <span class="path3"></span>
            </div>
            <div class="dntext">
              <div>Download from</div>
              <div>MDM app</div>
            </div>
          </button>
          <button class="dnlink canslink" style="display:none;order:6;">
            <div class="dntext">
              <div>Download from</div>
              <div>CANS link</div>
            </div>
          </button>
        </div>
        <div class="cont_note">Update via one of these options to <span style="font-weight:600">Continue</span>.</div>
      
      </div>
      
      </div>
      <div class="popups">
      <div class="msg-popup" tabindex="1">
        <div class="popup-body">
          <div class="textQr">
            <div class="pop-text">
              <div class="actbut">
                <div class="proceed" onclick="redirect()" tabindex="2">Continue</div>
                <div class="proceed back" onclick="back(event)" tabindex="2">Back</div>
                <div class="later" onclick="redirectRemind()" tabindex=2">I’ll update later.</div>
              </div>
            </div>
            <div class="pop-qr">
              <div class="qr">
                <div class="top left"></div>
                <div class="top right"></div>
                <div class="bottom right"></div>
                <div class="bottom left"></div>
              </div>
              <div class="qr-desc">Scan to download</div>
            </div>
          </div>
        </div>
      </div>
    </div>
      </div>
     
      
      <div class="illusCont">
        <div class="illustration"></div>
      </div>
    </main>
    <div class="footer-flex">This announcement is only for Zoho Corp users</div>
    </div>
  </body>
  <script>
  	var isMob = ${is_mobile?c};
  	$(document).ready(function(){
  		document.querySelector(".popups").style.top = document.querySelector(".main-details").clientHeight + "px";
		if( navigator.userAgent.match(/windows|win/i) ){
			$(".dnlink.microsoft").css("order","0");
			$(".dnlink.microsoft").show();
			$(".other-opts .icon-Microsoft,.other-opts .icon-MDM").hide();
		}
  	})
    var msgpop = document.querySelector(".msg-popup");
    var src;
    function handleDownload(e) {
      if (e.target.classList.contains("microsoft")) {
        src = "microsoft";
      } else if (e.target.classList.contains("android")) {
        src = "android";
      } else if (e.target.classList.contains("testflight")) {
        src = "testflight";
      } else if (e.target.classList.contains("mdmapp")) {
        src = "mdmapp";
      } else if (e.target.classList.contains("canslink")) {
        src = "canslink";
      } else if(e.target.classList.contains("other-opts")){
      	src = "other-opts";
      	$(".dnlink.other-opts").hide();
      	$(".dnlink.microsoft, .dnlink.mdmapp , .dnlink.canslink").show();
      	return;
      }
      if (document.querySelector(".msg-popup." + src)) {
      if(isMob){
      	document.querySelector(".popups").style.top = ((window.innerHeight) -  document.querySelector(".msg-popup." + src + " .popup-body").offsetHeight  - 50 )+ "px";
      }else{
      	document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 30) + "px";
      }
        	
        document.querySelector(".msg-popup." + src).style.display = "block";
        document.querySelector(".msg-popup." + src).style.maxHeight ="unset";
       // document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 30) + "px";
        document.querySelector(".popups").classList.add("popslide");
        if(isMob){
        	 var bctop = (document.querySelector(".another-wrap").getBoundingClientRect().top - document.querySelector("body").getBoundingClientRect().top) + "px";
        }else{
        	 var bctop = document.querySelector(".another-wrap").getBoundingClientRect().top + "px";
        }
        
        $(".popups").css("top",bctop)
        document.querySelector(".msg-popup." + src).focus();
        document.querySelector(".main-details").classList.add("mainslide")
      } else {
        var newpop = msgpop.cloneNode(true);
        newpop.classList.add(src);
        newpop.querySelector(".pop-text").prepend(document.querySelector("." + src + "-msg").cloneNode(true));
        if (src === "testflight") {
          newpop.querySelector(".pop-qr .qr-desc").textContent = "Scan to open invitation";
        }
        if (src === "mdmapp") {
          newpop.querySelector(".pop-qr").remove();
        } else {
          newpop.querySelector(".qr").classList.add(src + "-qr");
        }
        newpop.querySelector(".proceed.back").dataset.src = src;
        document.querySelector(".popups").append(newpop);
        document.querySelector(".msg-popup." + src).style.display = "block";
        document.querySelector(".msg-popup." + src).style.maxHeight ="unset";
        if(src == "microsoft" || src =="canslink" || src == "mdmapp"){
        document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 50) + "px";
        } else {
        	document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 20) + "px";
        }
        document.querySelector(".popups").classList.add("popslide");
         if(isMob){
        	 var bctop = (document.querySelector(".another-wrap").getBoundingClientRect().top - document.querySelector("body").getBoundingClientRect().top) + "px";
        }else{
        	 var bctop = document.querySelector(".another-wrap").getBoundingClientRect().top + "px";
        }
        $(".popups").css("top",bctop)
        document.querySelector(".msg-popup." + src).focus();
        document.querySelector(".main-details").classList.add("mainslide")
      }
    }
    
    var next = '${Encoder.encodeJavaScript(visited_url)}';
    function redirect(){
    	window.location.href = next;
    }
    var remindme = '${Encoder.encodeJavaScript(remindme_url)}'
    function redirectRemind(){
    	window.location.href = remindme;	
    }
    function back(e){
    	var sor = e.target.dataset.src;
    	    	document.querySelector(".popups" ).classList.remove("popslide");
    	setTimeout(function(){
    		document.querySelector(".msg-popup." + sor).style.maxHeight = "0px";
    	},200)
    	document.querySelector(".main-details").classList.remove("mainslide")
    	setTimeout(function(){
    	//document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 30) + document.querySelector(".another-wrap").getBoundingClientRect().top + "px";
    	//document.querySelector(".popups").style.top= ((window.innerHeight) -  document.querySelector(".msg-popup." + src + " .popup-body").offsetHeight  - 50 )+ "px";
    	 if(isMob){
      	document.querySelector(".popups").style.top = ((window.innerHeight) -  document.querySelector(".msg-popup." + src + " .popup-body").offsetHeight  - 50 )+ "px";
      }else{
      	document.querySelector(".popups").style.top = (document.querySelector(".main-details").clientHeight - 20) + "px";
      }
    	},200);
    }
  </script>
</html>
