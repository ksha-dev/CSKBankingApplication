<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.TFA.BACKUP.ACCESS.CODES" /></title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
   	 <@resource path="/v2/components/js/common_unauth.js" />
   	 <@resource path="/v2/components/css/${customized_lang_font}" />
    <style>
      @font-face {
        font-family: "AccountsUI";
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.eot")}");
        src: url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.eot")}") format("embedded-opentype"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.ttf")}") format("truetype"), url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.woff")}?zhy9kt") format("woff"),
          url("${SCL.getStaticFilePath("/v2/components/images/fonts/AccountsUI.svg")}") format("svg");
        font-weight: normal;
        font-style: normal;
        font-display: block;
      }
      [class^="icon-"],
      [class*=" icon-"] {
        font-family: "AccountsUI" !important;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }
      body {
        margin: 0;
        box-sizing: border-box;
		text-rendering: geometricPrecision;
      }
      .container {
        max-width: 540px;
        padding-top: 100px;
        padding-right: 4%;
        display: inline-block;
      }
      .rebrand_partner_logo {
        height: 40px;
        margin-bottom: 20px;
        background: url("${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}") no-repeat;
        background-size: auto 40px;
      }
      .announcement_header,
      .ann_header {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        cursor: default;
      }
      .account_verify_desc,
      .bcode_havent_desc,
      .acc_verify_desc {
        font-size: 16px;
        line-height: 24px;
        margin-bottom: 20px;
        cursor: default;
      }
      .bcode_havent_desc{
        margin-bottom: 30px;
        color: #ED473F;
      }
      .otp_input_container,
      .email_input_container,
      .mobile_input_container {
        width: 300px;
        margin-bottom: 30px;
      }
      .emailormobile {
        font-weight: 600;
      }

      .gen_now_btn, .cont_signin {
        font: normal normal 600 14px/30px ZohoPuvi;
        padding: 5px 30px;
        border-radius: 3px;
        color: white;
        border: none;
        background: #1389e3 0% 0% no-repeat padding-box;
        cursor: pointer;
      }
      .gen_now_btn:hover,
      .cont_signin:hover {
        background-color: #0779CF;
      }

      .nonclickelem {
        color: #626262;
        pointer-events: none;
        cursor: none;
      }
      button:disabled {
        opacity: 0.4;
      }
      .illustration {
        width: 350px;
        height: 350px;
        display: inline-block;
        background: url("${SCL.getStaticFilePath("/v2/components/images/ann_backupvcodes.svg")}") no-repeat;
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
      .container {
        padding-left: 10%;
      }
      .tfa_bkup_grid {
    	padding: 20px 30px;
    	border: 1px dashed #B5B5B5;
    	line-height: 26px;
    	margin-inline: 0px;
    	margin-top: 30px;
    	border-radius: 6px;
    	max-width: 300px;
	  }
	  .bkcodes {
    	margin: 0px;
    	line-height: 20px;
    	padding-left: 20px;
    	font-weight: 400;
	  }
	  .bkcodes_cell {
    	display: inline-block;
    	margin-left: 20px;
    	margin-bottom: 20px;
    	letter-spacing: 1px;
	  }
	  .backup_but {
    	background: #1389E31A 0% 0% no-repeat padding-box;
		border-radius: 6px;
    	color: #1389E3;;
    	font-size: 12px;
    	font-weight: 600;
    	padding: 12px 16px;
    	text-transform: uppercase;
    	margin-right: 10px;
    	cursor: pointer;
    	display: inline-block;
    	line-height: 14px;
    	border: 1px solid #D1E5F4;
	  }
	  .tooltipbtn .tooltiptext {
		visibility: hidden;
    	background-color: #555;
    	color: #fff;
    	white-space: nowrap;
    	text-align: center;
    	border-radius: 4px;
    	padding: 8px;
    	line-height: normal;
    	position: absolute;
    	z-index: 1;
    	bottom: 120%;
    	left: 75%;
    	font-size: 12px;
    	font-weight: 400;
    	text-transform: none;
    	margin-left: -75px;
    	opacity: 0;
    	transition: opacity 0.3s;
	  }
	  .tooltipbtn {
    	position: relative;
	  }
	  .tooltipbtn:hover .tooltiptext {
    	visibility: visible;
    	opacity: 1;
	  }
	  .tooltipbtn .tooltiptext::after {
    	content: "";
    	position: absolute;
    	top: 100%;
    	left: 50%;
    	margin-left: -5px;
    	border-width: 5px;
    	border-style: solid;
    	border-color: #555 transparent transparent transparent;
	  }
	  .tick-mark {
    	position: relative;
    	display: inline-block;
    	width: 12px;
    	height: 12px;
    	margin-right: 10px;
	  }
	  .tick-mark::before {
    	position: absolute;
    	left: 0;
    	top: 50%;
    	height: 50%;
    	width: 2px;
    	border-radius: 2px;
    	background-color: #01d356;
    	content: "";
    	transform: translateX(10px) rotate(-45deg);
    	transform-origin: left bottom;
	  }
	  .tick-mark::after {
    	position: absolute;
    	left: 0;
    	bottom: 0;
    	height: 2px;
    	width: 100%;
    	border-radius: 2px;
    	background-color: #01d356;
    	content: "";
    	transform: translateX(10px) rotate(-45deg);
    	transform-origin: left bottom;
	  }
	  .mfa_points_list {
    	margin: 0px;
    	padding-left: 16px;
    	cursor: default;
	  }
	  .mfa_list_item {
    	color: #E56000;
    	margin-top: 16px;
    	font-weight: 500;
    	font-size: 14px;
	  }
	  .down_copy_proceed{
  		margin-top: 20px;
  		font-size: 14px;
  		line-height: 24px;
  		font-weight: medium;
  		opacity: 0.7;
	  }
	  .remind_me {
    	color: #00A7FF;
    	font-weight: 600;
    	font-size: 14px;
    	font-family: 'ZohoPuvi';
    	line-height: 24px;
    	background: none;
   		border: none;
    	padding: 0;
    	cursor: pointer;
  		margin-left: 20px;
	  }
	  .error_msg {
     	font-size: 14px;
     	font-weight: 500;
     	line-height: 18px;
     	margin-top: 4px;
     	margin-bottom: 10px;
     	color: #e92b2b;
     	display: none;
	  }
      .errorborder {
        border: 2px solid #ff8484 !important;
      }
      .cont_signin {
		margin-top: 30px;
      }
       .noCodeBtn {
        border: none;
        outline: none;
        background: none;
        font-size: 14px;
        color: #00a7ff;
        font-weight: 600;
        line-height: 28px;
        cursor: pointer;
        margin-left: 30px;
        padding:0;
        position: relative;
        display: inline-block;
      }
      .noCodeBtn:focus-visible{
		text-decoration: underline;
      }
      .noCodeBtn::after {
        content: "";
		display: inline-block;
		border-color: transparent #00a7ff #00a7ff transparent;
		border-style: solid;
		border-width: 3px;
		transform: rotate(45deg);
		margin-left: 5px;
		margin-bottom: 3px;
      }
	  .dropPoint{
		display: block;
		width: 6px;
		height: 6px;
		position: absolute;
		top: -4px;
		left: 42px;
		border-top: 1px solid #e4e4e4;
		border-right: 1px solid #e4e4e4;
		background-color: white;
		transform: rotate(-45deg);
	  }
      .dropd {
        border: 1px solid #e4e4e4;
        border-radius: 4px;
        width: max-content;
        position: absolute;
        text-align: left;
      }
      .dropOpts {
        padding: 10px 20px;
        cursor: pointer;
        color: black;
        font-weight: 400;
        box-sizing: border-box;
        min-width: 160px;
        max-width: 180px;
        word-wrap: break-word;
        display: block;
        outline: none;
        font-family: 'ZohoPuvi';
        text-decoration:none;
        border: none;
        background-color: unset;
      }
      .dropOpts:first-of-type {
        margin-top: 5px;
      }
      .dropOpts:last-child {
        margin-bottom: 5px;
      }
      .dropOpts:focus,
      .dropOpts:hover{
        background-color: #f1f1f1;
      }
      #error_space{
		position: fixed;
		width: fit-content;
		width: -moz-fit-content;
		left: 0px;
		right: 0px;
		margin: auto;
		border: 1px solid #FCD8DC;
		display: inline-block;
		padding: 18px 30px;
		background: #FFECEE;
		border-radius: 4px;
		color: #000;
		top: -100px;
		transition: all .3s ease-in-out;
		box-sizing: border-box;
	    max-width: 400px;
	  }
	  .top_msg
	  {
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
	  }
	  .error_icon
	  {
	    position: relative;
	    background: #FD395D;
	    width: 24px;
	    height: 24px;
	    float: left;
	    box-sizing: border-box;
	    border-radius: 50%;
	    display: inline-block;
	    color: #fff;
	    font-weight: 700;
	    font-size: 16px;
	    text-align: center;
	    line-height: 24px;
	  }
	  .show_error{
	  	top:60px !important;
	  }
	  .loader,
	  .loader:after {
  		border-radius: 50%;
  		width: 10px;
  		height: 10px;
	  }
	  .loader {
		display: inline-block;
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
      @media only screen and (min-width: 435px) and (max-width: 980px) {
        .flex-container {
          padding: 50px 25px 0px 25px;
        }
        .illustration-container {
          display: none;
        }
        .container {
          padding: 0;
          margin: auto;
        }
      }
      @media only screen and (max-width: 435px) {
        .flex-container {
          padding: 50px 30px 0px 30px;
        }
        .container {
          width: 100%;
          padding: 0;
        }
        .illustration-container {
          display: none;
        }
        .remind_me{
          display: block;
          width: max-content;
          margin: auto;
          margin-top: 20px;
        }
        button {
          width: 100%;
        }
        .noCodeBtn{
        	display: block;
			margin: auto;
			margin-top: 20px;
			width: max-content;
        }
        .dropd{
        	left: -50%;
			text-align: center;
        }
      }
    </style>
    <script>
      var csrfParam= "${za.csrf_paramName}";
      var csrfCookieName = "${za.csrf_cookieName}";
      var userName = "${Encoder.encodeJavaScript(username)}";
      var contextpath = "${za.contextpath}";
	  I18N.load({
      	"IAM.TFA.BACKUP.ACCESS.CODES" : '<@i18n key="IAM.TFA.BACKUP.ACCESS.CODES"/>',
      	"IAM.GENERATEDTIME" : '<@i18n key="IAM.GENERATEDTIME" />',
      	"IAM.MFA.BACKUPCODE.FILE.TEXT": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.TEXT" />',
		"IAM.MFA.BACKUPCODE.FILE.NOTES": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES" />',
		"IAM.LIST.BACKUPCODES.POINT1": '<@i18n key="IAM.LIST.BACKUPCODES.POINT1" />',
		"IAM.LIST.BACKUPCODES.POINT3": '<@i18n key="IAM.LIST.BACKUPCODES.POINT3" />',
		"IAM.MFA.BACKUPCODE.FILE.NOTES3": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES3" />',
		"IAM.MFA.BACKUPCODE.FILE.NOTES4": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NOTES4" />',
		"IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE" />',
		"IAM.GENERAL.USERNAME": '<@i18n key="IAM.GENERAL.USERNAME" />',
		"IAM.GENERATE.ON": '<@i18n key="IAM.GENERATE.ON" />',
		"IAM.MFA.BACKUPCODE.FILE.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.HELP.LINK" />',
		"IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK" />',
		"IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK": '<@i18n key="IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK" />',
		"IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL" />',
      });
      function generateBackupCode(e){
      	e.target.setAttribute("disabled","");
		e.target.children[0].classList.add("loader");
		sendRequestWithCallback("/webclient/v1/account/self/user/self/backupcodes", "", true, handleBackupCodes, "PUT");
      }
	  function handleBackupCodes(respstr){
	  	document.querySelector(".gen_now_btn").removeAttribute("disabled");
+     	document.querySelector(".gen_now_btn").children[0].remove("loader");
		var resp = JSON.parse(respstr);
		var ar = resp.cause;
			if(resp.status_code >= 200 && resp.status_code <= 299){
				show_backup(resp.backupcodes[0]);
			}
			if(!isEmpty(ar)){
				ar = ar.trim();
			  	if(ar === "invalid_password_token") {
			    	var serviceurl = window.location.origin + window.location.pathname; 
			    	var redirecturl = resp.redirect_url; 
			   		window.location.href ="" + redirecturl +'?serviceurl='+euc(serviceurl);
			    	return;
				}
	  		} 
	  }
	  var recHelp= "https://zurl.to/bvc_banner_bvc_rec", newCodesHelp= "https://zurl.to/bvc_banner_bvc_gen", pmail;
	  function show_backup(resp)
	  {
		var codes = resp.recovery_code;
		var recoverycodes = codes.split(":");
		var createdtime = resp.created_date;
		var res ="<ol class='bkcodes'>"; //No I18N
		var recCodesForPrint = "";
		pmail = resp.primary_email
		for(idx in recoverycodes)
		{
			var recCode = recoverycodes[idx];
			if(recCode != ""){
				res += "<li><b><div class='bkcodes_cell'>"+recCode.substring(0, 4)+"</div><div class='bkcodes_cell'>"+recCode.substring(4, 8)+"</div><div class='bkcodes_cell'>"+recCode.substring(8) + "</div></b></li>"; //No I18N
				recCodesForPrint += recCode + ":";
			}
		}
		res += "</ol>";
		recCodesForPrint = recCodesForPrint.substring(0, recCodesForPrint.length -1); // Remove last ":"
		de('bk_codes').innerHTML = res;
		$("#printcodesbutton").attr('onclick','copy_code_to_clipboard(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("copy")'); //No I18N
		$("#downcodes").attr('onclick', 'downloadCodes(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("save_text")'); //No I18N
		$(".bcode_havent_desc, .form_container, .announcement_header, .account_verify_desc").slideUp(200);
		$(".backup_code_container").slideDown(200,function(){
			setFooterPosition();
		});
	  }
	  var recTxt = "";
	  function formatRecoveryCodes(createdtime, recoverycodes){
		recTxt = I18N.get("IAM.MFA.BACKUPCODE.FILE.TEXT")+"\n\n\n"; //No I18N
		recTxt = recTxt + I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES") + "\n"; //No I18N
		I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES").split("").forEach(function(){recTxt=recTxt+"-"}); //No I18N
		recTxt = recTxt + "\n# " + I18N.get("IAM.LIST.BACKUPCODES.POINT1") + "\n# " + I18N.get("IAM.LIST.BACKUPCODES.POINT3") + "\n# " //No I18N
						+ I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES3") + "\n# " + I18N.get("IAM.MFA.BACKUPCODE.FILE.NOTES4") + "\n\n\n"; //No I18N
		recTxt = recTxt + I18N.get("IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE") + "\n";		//No I18n
		I18N.get("IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE").split("").forEach(function(){recTxt=recTxt+"-";}); //No I18N
		recTxt = recTxt + "\n" + I18N.get("IAM.GENERAL.USERNAME") + ": " + pmail + "\n"; //No I18N

		recTxt = recTxt + I18N.get("IAM.GENERATE.ON") + ": " + createdtime + "\n\n"; //No I18N
		recoverycodes = recoverycodes.split(",");
		for(var idx=0; idx < recoverycodes.length; idx++){
			var recCode = recoverycodes[idx];
			if(recCode != ""){
				recTxt += "\n "+(idx+1)+". "+recCode.substring(0, 4)+" "+recCode.substring(4, 8)+" "+recCode.substring(8); //No I18N
			}
		}
		recTxt = recTxt + "\n\n\n" + I18N.get("IAM.MFA.BACKUPCODE.FILE.HELP.LINK") + "\n"; //No I18N
		I18N.get("IAM.MFA.BACKUPCODE.FILE.HELP.LINK").split("").forEach(function(){recTxt=recTxt+"-";}); //No I18N
		recTxt = recTxt + "\n\n# " + Util.format(I18N.get("IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK"), recHelp) + "\n# " + Util.format(I18N.get("IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK"),newCodesHelp);	//No I18n
	  }
	  function copy_code_to_clipboard (createdtime, recoverycodes) {
		if(recTxt == ""){
			formatRecoveryCodes(createdtime, recoverycodes);
		}
		navigator.clipboard.writeText(recTxt).then(function () {
			$(".copy_to_clpbrd").hide();
			$(".code_copied").show();
			$("#printcodesbutton .tooltiptext").addClass("tooltiptext_copied");
			$(".down_copy_proceed").hide();
			$(".cont_signin").show();
			$("html, body").animate({scrollTop: ($(".cont_signin").offset().top)-120,},1000);
			setFooterPosition();
		}).catch(function(){
			//error occured while copying
			showErrMsg(I18N.get("IAM.ERROR.GENERAL"))
		});
	  }
	  function remove_copy_tooltip() {
		$(".copy_to_clpbrd").show();
		$(".code_copied").hide();
		$("#printcodesbutton .tooltiptext").removeClass("tooltiptext_copied");
	  }
	  
	  function downloadCodes(createdtime, recoverycodes) {
	  	if(recTxt == ""){
			formatRecoveryCodes(createdtime, recoverycodes);
		}
		var filename = "RECOVERY-CODES-"+ userName; //No I18N
	  	var element = document.createElement('a');
	  	element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(recTxt));
	  	element.setAttribute('download', filename);
	  	element.style.display = 'none';
	  	document.body.appendChild(element);
		element.click();
		$(".down_copy_proceed").hide();
		$(".cont_signin").show();
		$("html, body").animate({scrollTop: ($(".cont_signin").offset().top)-120,},3000);
		setFooterPosition();
	  	document.body.removeChild(element);
	  }
	  function updateBackupStatus(mode){
		var params = { "status" : { "status" : mode}};
		sendRequestWithCallback("/webclient/v1/account/self/user/self/backupcodes/status", JSON.stringify(params), true, handleBackupStatus, "PUT");
	  }
	  function handleBackupStatus(respStr){
	  	respStr
	  }
	  function contSignin(){
		window.location.href = '${Encoder.encodeJavaScript(visited_url)}';
	  }
      function remove_error(ele) {
        if (ele) {
          $(ele).siblings(".field_error").remove();
        } else {
          $(".field_error").remove();
        }
      }
      function show_error_msg(sibilingClassorID, msg) {
        var errordiv = document.createElement("div");
        errordiv.classList.add("error_msg");
        errordiv.textContent = msg;
        $(errordiv).insertAfter(sibilingClassorID);
        $(".error_msg").slideDown(150);
      }
	  function handleConnectionError(){
	  	showErrMsg("<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>");
	  }
	  function showErrMsg(msg){
		document.getElementById("error_space").classList.remove("show_error");
	    document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N
	    document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
	    document.getElementById("error_space").classList.add("show_error");
	    setTimeout(function() {
			document.getElementById("error_space").classList.remove("show_error");
	    }, 5000);;
	  }
	  function dropDown(e){
	  if(e.target.classList.contains("generate")){
		window.location.href = '${Encoder.encodeJavaScript(remind_me_later_url)}';
	  }
	  if(e.target.classList.contains("redirect")){
		contSignin();
	  }if($(".dropOpts").is(":visible"))
		{
		$(".dropd").css("display" ,"none");
		var dwidth = document.querySelector(".dropd").offsetWidth;
		}
		else{
        $(".dropd").css("display" ,"block");
        var bwidth = document.querySelector(".noCodeBtn").offsetWidth;
        var dwidth = document.querySelector(".dropd").offsetWidth;
		if(bwidth > dwidth){
			$(".dropPoint").css("left",(dwidth-15)+"px");
		} else if(bwidth < dwidth){
			$(".dropPoint").css("left",(bwidth-7)+"px");
		}
		$(".dropd").css("visibility" ,"visible");
      }
      }
      function focusOut(e){
      	if(e.relatedTarget!=null && e.relatedTarget.classList.contains("dropOpts")){
      		return false;
      	}
        $(".dropd").css("visibility" ,"hidden");
        $(".dropd").css("display" ,"none");
      }
	</script>
  </head>
  <body>
  	<#include "../Unauth/announcement-logout.tpl">
  	<div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
    <div class="flex-container">
      <div class="container">
        <div class="rebrand_partner_logo"></div>
		<#if createdByAdmin??>
		<div class="announcement_header"><@i18n key="IAM.BACKUP.CODES.SELF.RECOVERY" /></div>
        <div class="account_verify_desc">
			<@i18n key="IAM.BACKUP.CODES.SELF.RECOVERY.DESC" />
		</div>
        <#elseif count == 0>
		<div class="announcement_header"><@i18n key="IAM.BACKUP.VERIFY.NO.CODES.TITLE" /></div>
        <div class="account_verify_desc">
			<@i18n key="IAM.BACKUP.VERIFY.NO.CODES.DESC" /><@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" />
		</div>
		<#elseif regenerate??>
		<div class="announcement_header"><@i18n key="IAM.BACKUP.VERIFY.LONG.AGO.TITLE" /></div>
        <div class="account_verify_desc">
			<@i18n key="IAM.BACKUP.VERIFY.GENERATED.LONG.DESC" /><@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" />
		</div>
		<#elseif count == 1>
		<div class="announcement_header"><@i18n key="IAM.BACKUP.VERIFY.ONE.CODE.TILE" /></div>
        <div class="account_verify_desc">
			<@i18n key="IAM.BACKUP.VERIFY.ONE.CODE.LEFT.DESC" /><@i18n key="IAM.BACKUP.VERIFY.CODES.ALLOW" />
		</div>
		</#if>
        <div class="bcode_havent_desc">
        <#if !(regenerate??)>
			<#if !(count == 1)>
				<@i18n key="IAM.BACKUP.VERIFY.CONTACT.DESC" />
			<#else>
				<@i18n key="IAM.BACKUP.VERIFY.NO.CODES.GENERATE" />
			</#if>
		<#else>
          <@i18n key="IAM.BACKUP.VERIFY.ACCESS.OLD.CODES" />
        </#if>
        </div>
        <div class="form_container">
          <form name="confirm_form" onsubmit="return false">
			<button class="gen_now_btn" onclick="generateBackupCode(event)"><span></span><@i18n key="IAM.TFA.GENERATE.NEW" /></button>
			<#if !(signin_using_bkp?has_content) || (signin_using_bkp?has_content && count == 1) || !(signin_using_bkp?has_content && count == 0)>
			<#if (regenerate??)>
				<div class="noCodeBtn" onclick="dropDown(event)" onfocusout="focusOut(event)" tabindex="0"><@i18n key="IAM.SKIP" />
					<div class="dropd" style="display: none;visibility: hidden">
						<button class="dropOpts generate"><@i18n key="IAM.BACKUP.VERIFY.HAVE.CODES" /></button>
						<div class="dropPoint"></div>
						<button class="dropOpts redirect"><@i18n key="IAM.TFA.BANNER.REMIND.LATER" /></button>
					</div>
				</div>
			<#else>
				<button class="remind_me" onclick="contSignin()"><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT" /></button>
			</#if>
			</#if>
          </form>
        </div>
        <div class="backup_code_container" style="display:none">
          <div class="ann_header"><@i18n key="IAM.BACKUP.CODES.GENERATED.TITLE" /></div>
          <div class="acc_verify_desc">
			<@i18n key="IAM.BACKUP.CODES.GENERATED.DESC1" /> <@i18n key="IAM.BACKUP.CODES.GENERATED.DESC2" />
		  </div>
          <ul class="mfa_points_list">
 				<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT1" /></li>
				<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT2" /> </li>
				<li class="mfa_list_item"><@i18n key="IAM.LIST.BACKUPCODES.POINT3" /> </li>
		  </ul>
		<div id="bkup_code_space" class="tfa_bkup_grid">
			<div id="bk_codes">
             </div>
			<div id="bkup_cope">
				<span class="backup_but" id ="downcodes" onclick="downloadCodes();"><@i18n key="IAM.DOWNLOAD.APP" /> </span>
				<span class="backup_but tooltipbtn" id="printcodesbutton" onmouseout="remove_copy_tooltip();"><@i18n key="IAM.COPY" /> 
					<span class="tooltiptext copy_to_clpbrd"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD" /></span>
					<span class="tooltiptext code_copied hide" style="display:none"><span class="tick-mark"></span><@i18n key="IAM.APP.PASS.COPIED" /> </span>
				</span> 
 			</div>
		</div>
        <div class="down_copy_proceed"><@i18n key="IAM.BACKUP.VERIFY.CODES.PROCEED" /></div>
        <button class="cont_signin" onclick="contSignin();(function(e){e.target.setAttribute('disabled',''); e.target.querySelector('span').classList.add('loader')})(event);" style="display:none"><span></span><@i18n key="IAM.AC.PASSWORD.MATCHED.SIGNIN.REDIRECT" /></button>
        </div>
      </div>
        <div class="illustration-container">
          <div class="illustration"></div>
        </div>
      </div>
    </div>
    <footer id="footer">
    <#include "../Unauth/footer.tpl"></footer>
  </body>
  <script>
  window.onload = function () {
  	setFooterPosition();
    <#if (regenerate??)>
    document.querySelector(".noCodeBtn").addEventListener("keydown", function(event){
    	if(event && event.keyCode == "13"){
      		event.target.click();
      	}
    })
    </#if>
  }
  </script>
</html>
