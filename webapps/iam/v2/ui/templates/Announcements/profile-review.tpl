<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
    <link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    <style>
      @font-face {
        font-family: "accountsicon";
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.eot")}");
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.eot")}") format("embedded-opentype"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.ttf")}") format("truetype"), 
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.woff")}") format("woff"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/emailphonenewtabpebbledomain.svg")}") format("svg");
        font-weight: normal;
        font-style: normal;
        font-display: block;
      }
      [class^="icon-"],
      [class*=" icon-"] {
        font-family: "accountsicon" !important;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }
      .icon-Mail:before {
        content: "\e900";
      }
      .icon-Mobile:before {
        content: "\e901";
      }
      .icon-newtab:before {
        content: "\e902";
      }
      .mailicon:after {
        content: "\e903";
        position: absolute;
        left: 0px;
        opacity: 0.05;
        top: 1px;
        font-size: 30px;
      }
      .phoneicon:after {
        content: "\e903";
        position: absolute;
        opacity: 0.05;
        top: 1px;
        font-size: 30px;
        left: 0px;
      }
      .mailicon {
        font-size: 10px;
        color: #18c063;
        padding: 6px;
        position: relative;
        font-size: 18px;
        margin-right: 10px;
      }
      .phoneicon {
        font-size: 10px;
        color: #1389e3;
        padding: 6px;
        position: relative;
        font-size: 18px;
        margin-right: 10px;
      }
      .newtablinkicon {
        margin-left: 5px;
        font-size: 10px;
      }
      body {
        margin: 0px;
        padding: 0px;
      }
      .logo {
        background: url(${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")});
        height: 100%;
        background-repeat: no-repeat;
        width: auto;
        height: 40px;
        background-size: contain;
        margin-bottom: 20px;
      }
      .maincontainer {
        width: 500px;
        margin-bottom: 30px;
        font-family: "ZohoPuvi", Georgia;
        margin: auto;
        margin-top: 120px;
      }
      .headermsg {
        width: 100%;
        font-size: 20px;
        line-height: 30px;
        font-weight: 600;
        color: #1d2842;
        margin-bottom: 10px;
        margin-top: 20px;
        text-align: left;
      }
      .msgcontainer {
        width: 100%;
        font-size: 14px;
        font-weight: 400;
        line-height: 24px;
        margin-bottom: 30px;
      }
      .emailphonedetailscontainer {
        width: 440px;
        border-radius: 16px;
        border: 1px solid #dcdcdc;
        margin-bottom: 24px;
      }
      .myccontainer {
        width: 440px;
        border-radius: 16px;
        border: 1px solid #dcdcdc;
        box-sizing: border-box;
        padding: 20px;
        margin-bottom: 30px;
      }
      .succbutton {
        text-decoration: none;
        color: #ffffff;
        font-family: "ZohoPuvi", Georgia;
        font-weight: 600;
        font-size: 13px;
        margin-right: 20px;
        background-color: #1389e3;
        border-radius: 4px;
        padding: 12px 20px;
        display: inline-block;
      }
      .succbutton:hover {
        background-color: #1177c5;
      }
      .failbutton {
        text-decoration: none;
        color: #8b8b8b;
        font-family: "ZohoPuvi", Georgia;
        font-weight: 600;
        font-size: 12px;
        float: right;
        position: relative;
        top: 12px;
        border-bottom: 1px dashed #acacac;
        padding-bottom: 3px;
        left: 0px;
    	background-color: white;
    	transition : left .4s ease-in;
      }
      .headercontainer {
        font-size: 14px;
        font-weight: 600;
        box-sizing: border-box;
        padding: 20px 20px;
        border-bottom: 1px solid #dcdcdc;
      }
      .editlink {
        color: #0091ff;
        font-size: 12px;
        font-weight: 700;
        float: right;
        text-decoration: none;
      }
      .mycdetails {
        width: 440px;
        display: block;
        font-size: 12px;
        line-height: 20px;
        margin-bottom: 30px;
        letter-spacing: -0.2;
        color: black;
      }
      .spann {
        display: inline-block;
      }
      .emailphonecontainer {
        box-sizing: border-box;
        padding: 15px 20px;
        margin-top: 10px;
        display: flex;
      }
      .detailscontainer {
        box-sizing: border-box;
        font-size: 14px;
        font-weight: 600;
        letter-spacing: 1px;
        max-width: 300px;
        word-break: break-all;
        margin-bottom: 5px;
      }
      .detailsdatecontainer {
        font-size: 12px;
        line-height: 16px;
        font-weight: 500;
        color: #666666;
      }
      div .emailphonecontainer:last-child {
        margin-bottom: 20px;
      }
      .hideshow{
      	height: 18px;
      	width: 18px;
      	color: #f2f2f2;
      	display: inline-block;
      	align-self: center;
      	margin-left: auto;
      	cursor: pointer;
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
  		animation: load .7s infinite linear;
	  }
	  .remind_loader{
	  	left: -20px;
	  	pointer-events: none;
	  }
	  .remind_loader::after{
	  	content:"";
	  	display: inline-block;
    	position: absolute;
    	top: 2px;
    	right: 0px;
    	z-index: -2;
    	border: 2px solid rgba(255, 255, 255, 0.2);
    	border-left: 2px solid;
    	border-bottom: 2px solid;
    	-webkit-animation: load .6s infinite linear, anim_r .2s 1 forwards ease-in;
    	animation: load .6s infinite linear, anim_r .2s 1 forwards ease-in;
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
	  @keyframes anim_r{
	  	0%{
	  		right: 0px;
	  	}
	  	100%{
	  		right: -20px;
	  	}
	  }
      @media screen and (min-width: 435px) and (max-width: 900px) {
        .maincontainer {
          margin: auto;
          margin-top: 50px;
          width: 440px;
        }
        .body {
          width: 100%;
        }
      }
      @media screen and (max-width: 435px) {
        .maincontainer {
          margin-left: 0px;
          width: 100%;
          margin-bottom: 0px;
          margin-top: 0px;
        }
        .msgcontainer {
          width: 100%;
        }
        .emailphonedetailscontainer {
          width: 100%;
        }
        .mycdetails {
          width: 100%;
        }
        body {
          padding: 30px 20px;
        }
        .succbutton{
        	display:block;
        	margin: 0;
        	text-align: center;
        }
        .failbutton {
          float: unset;
          top: 30px;
          display: block;
          width: max-content;
          margin: auto;
        }
      }
    </style>
  </head>
  <body>
  	<#include "../Unauth/announcement-logout.tpl">
    <div class="maincontainer">
      <div class="logo"></div>
      <div class="headermsg"><@i18n key="IAM.USER.PROFILE.REVIEW.HEADER"/></div>
      <div class="msgcontainer"><@i18n key="IAM.USER.PROFILE.REVIEW.HEADER.MSG"/></div>

      <div class="emailphonedetailscontainer">
        <div class="headercontainer">
          <span><@i18n key="IAM.USER.PROFILE.REVIEW.EMAIL.AND.MOBILE"/></span>
          <a href="javascript:redirect()" class="editlink"><@i18n key="IAM.USER.PROFILE.REVIEW.MANAGE"/><span class="newtablinkicon icon-newtab"></span></a>
        </div>

	<#list profiles as  x>
	<#if x.morph_email??>
        <div class="emailphonecontainer">
          <span class="mailicon icon-Mail icon-pebble"></span>
          <span class="spann">
            <div class="detailscontainer" data-val=${x.email} data-morph=${x.morph_email}>${x.morph_email}</div>
            <div class="detailsdatecontainer">${x.created_time}</div>
          </span>
          <span class="hideshow" onclick=maskUnMask(event)></span>
        </div>
        </#if>
	<#if x.morph_mobile??>
        <div class="emailphonecontainer">
          <span class="phoneicon icon-Mobile icon-pebble"></span>
          <span class="spann">
            <div class="detailscontainer" data-val="${x.mobile}" data-morph="${x.morph_mobile}" data-mask=true>${x.morph_mobile}</div>
            <div class="detailsdatecontainer">${x.created_time}</div>
          </span>
           <span class="hideshow" onclick=maskUnMask(event)></span>
        </div>
        </#if>
	</#list>
      </div>
      <#if myc_url??>
      <div class="mycdetails"><@i18n key="IAM.USER.PROFILE.REVIEW.MYC.MSG"/></div>
      </#if>
      <a href="${Encoder.encodeHTMLAttribute(visited_url)}" onclick="(function(e){e.target.classList.add('buttdisabled'); e.target.querySelector('span').classList.add('loader')})(event);" class="succbutton"><span></span><@i18n key="IAM.CONFIRM"/></a>
      <a href="${Encoder.encodeHTMLAttribute(remindme_url)}" onclick="(function(e){e.target.classList.add('remind_loader')})(event);" class="failbutton"><@i18n key="IAM.TFA.BANNER.REMIND.LATER"/></a>
    </div>
    <script>
      function redirect() {
        window.open("${Encoder.encodeJavaScript(email_url)}", "_blank");
        window.open("${Encoder.encodeJavaScript(visited_url)}", "_self");
      }
      function redirect2(){
      	window.open("${Encoder.encodeJavaScript(myc_url)}", "_blank");
        window.open("${Encoder.encodeJavaScript(visited_url)}", "_self");
      }
      function maskUnMask(event){
      var parele = event.target.closest(".emailphonecontainer");
      var ele = parele.querySelector(".detailscontainer");
      	if(ele.dataset.mask == "true"){
      		ele.textContent = ele.dataset.val;
      		ele.dataset.mask = false;
      	}else{
      		ele.textContent = ele.dataset.morph;
      		ele.dataset.mask = true;
      	}
      }
    </script>
  </body>
</html>
