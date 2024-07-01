<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
    	<#if !isPolicy>
        	<@i18n key="IAM.ADD.CONTACT.MOBILE"/>
		<#else>
        	<@i18n key="IAM.ADD.RECOVERY.MOBILE.TITLE"/>
        </#if>	
    </title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/tp_pkg/xregexp-all.js" />
    <@resource path="/v2/components/js/splitField.js" />
	<@resource path="/v2/components/js/flagIcons.js" />
	<@resource path="/v2/components/js/uvselect.js" />
	<@resource path="/v2/components/css/uvselect.css" />
	<@resource path="/v2/components/css/flagIcons.css" />
    <script>
	   var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
    </script> 
    <@resource path="/v2/components/js/phonePatternData.js" />
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
      .icon-ccomplete:before{
      	content: "\e926";
      }
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

[class^="icon2-"], [class*=" icon2-"] {
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
      .icon2-pebble:after {
  		content: "\e90b";
	  }
	  .icon2-Mobile:before {
  		content: "\e909";
	  }
      body {
        margin: 0;
        box-sizing: border-box;
      }
      .content_container {
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
      .announcement_header {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        cursor: default;
      }
      .account_verify_desc,
      .otp_sent_desc,
      .already_existing_desc {
        font-size: 16px;
        line-height: 24px;
        margin-bottom: 20px;
        cursor: default;
      }
      .otp_sent_desc,
      .enter_eml_mob_desc {
      	line-height: 24px;
        margin-bottom: 30px;
      }
      .valueemailormobile{
      	display:inline-block;
      }
      .emolabel {
        font-size: 12px;
        line-height: 14px;
        display: block;
        margin-bottom: 4px;
        font-weight: 600;
        letter-spacing: 0px;
        color: #000000b3;
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
      .resend_otp {
        font-size: 14px;
        line-height: 26px;
        margin:12px 0 20px 0;
        cursor: pointer;
        font-weight: 500;
        color: #0093ff;
        width: max-content;
      }
      #email_input,
      #mobile_input {
        height: 44px;
        padding: 12px 15px;
        line-height: 30px;
        width: 288px;
        border: 1px solid #0f090933;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }
      #email_input:focus-visible, #mobile_input:focus-visible{
      	outline: none;
      }
      input#otp_input {
        margin-bottom: 0px;
        padding: 14px 15px;
      }
      .edit_option {
        font-size: 16px;
        line-height: 24px;
        margin-left: 10px;
        color: #0093ff;
        cursor: pointer;
      }
      .primary_btn_check {
      	margin-top: 15px;
      }
      .primary_btn_check,
      .send_otp_btn,
      .verify_btn,
      .update_send_otp_btn {
        font: normal normal 600 14px/30px sans-serif;
        padding: 5px 30px;
        border-radius: 4px;
        color: white;
        border: none;
        background: #1389e3 0% 0% no-repeat padding-box;
        cursor: pointer;
      }
      .primary_btn_check:hover,
      .send_otp_btn:hover,
      .verify_btn:hover,
      .update_send_otp_btn:hover{
      	background-color: #0779CF;
      }
      .send_otp_btn span{
	   	margin-left: 10px;
	  	font-size: 10px;
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
        background: url("${SCL.getStaticFilePath("/v2/components/images/ann_addmobilenumber.svg")}") no-repeat;
      }
      .flex-container {
        display: flex;
        max-width: 1200px;
        gap: 50px;
        margin: auto;
      }
      .illustration-container {
        padding-top: 120px;
        padding-right: 10%;
      }
      .unverContainer{
      	border: 1px solid #d8d8d8;
      	border-radius: 10px;
      	max-width: 460px;
      }
      .unverHeader{
      	font-size: 14px;
      	font-weight: 600;
      	line-height: 24px;
      	border-bottom: 1px solid #d8d8d8;
      	padding: 20px 20px;
      }
      .mobile-icon {
        width: 30px;
        height: 30px;
        font-size: 30px;
        color: #1389e3;
        position: relative;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
        margin-right: 10px;
      }
      .mobile-icon::before {
      	font-size: 16px;
      	margin: auto;
      	height: max-content;
      	align-self: center;
      }
      .mobile-icon::after{
      	position: absolute;
      	left: 0;
      	opacity:0.1;
      }
      .numb-details{
      	font-size: 14px;
      	line-height: 20px;
      	cursor: default;
      }
      .numb-cont{
      	display: flex;
      	padding: 15px 20px;
      	align-items:center;
      }
      .verify-tick{
      	margin-left: auto;
      	opacity: 0.5;
      	display: flex;
   		align-items: center;
    	gap: 5px;
    	font-size: 14px;
    	padding: 12px;
    	border-radius: 22px;
      }
      .verify-tick:hover{
      	opacity: 1;
      	cursor: pointer;
      	background-color: #eee;
      }
      .link-btn{
      	font-size: 14px;
      	font-weight: 600;
      	color: #0093FF;
      	line-height: 20px;
      	outline: none;
      	text-decoration: none;
      	padding: 0px;
      	border: none;
      	background: none;
      	cursor: pointer;
      }
      .add-new{
      	margin:20px 20px 30px 30px;
      }
      .back_btn{
      	outline: none;
      	padding: 12px 30px;
      	border: none;
      	cursor: pointer;
      	border-radius: 4px;
      	background: #ededed;
      	font-size: 14px;
      	font-weight: 600;
      	color: #4E4E4E;
      	margin-left: 20px;
      }
      .numb-cont:hover{
      	background-color: #f8f8f8;
      }
      .content_container {
        padding-left: 10%;
      }
      .otp_input_container {
        position: relative;
      }
      .textbox, .otp_container {
        display: flex;
        justify-content: space-around;
        width: 100%;
        height: 44px;
        box-sizing: border-box;
        border-radius: 4px;
        font-size: 16px;
        outline: none;
        padding: 0px 15px;
        transition: all 0.2s ease-in-out;
        background: #ffffff;
        border: 1px solid #dddddd;
        text-indent: 0px;
      }
      .otp_container::after {
        content: attr(placeholder);
        height: 44px;
        line-height: 44px;
        font-size: 14px;
        position: absolute;
        color: #b9bcbe;
        left: 15px;
        z-index: 1;
        cursor: text;
      }
      .customOtp {
        border: none;
        outline: none;
        background: transparent;
        height: 100%;
        font-size: 14px;
        text-align: left;
        width: 22px;
        padding: 0px;
      }
      .hidePlaceHolder::after {
        z-index: -1 !important;
      }
      #otp_split_input input::placeholder {
        color: #b9bcbe;
      }
	  .error_msg {
        font-size: 14px;
        font-weight: 500;
        line-height: 18px;
        margin-top: 4px;
        margin-bottom: 10px;
        color: #e92b2b;
        display: none;
        white-space: normal;
      }
      .errorborder {
        border: 2px solid #ff8484 !important;
      }
      .already_added, .add_new_number {
      	color: #0093ff;
      	font-weight: 500;
      	font-size: 14px;
      	margin-top: 12px;
      	margin-bottom:20px;
      	cursor: pointer;
      	width:max-content;
	  }
      #mobile_input {
        text-indent: 60px;
        width: 300px;
        line-height: 40px;
        letter-spacing: 0.5px;
        height: 42px;
        outline: none;
        box-sizing: border-box;
        font-size: 14px;
        font-family: "ZohoPuvi";
        display: inline-block;
        box-sizing: border-box;
        outline: none;
        border-radius: 4px;
        border: 1px solid #dddddd;
        padding: 12px 15px 12px 6px;
      }
      b {
        font-weight: 500;
      }
      user agent stylesheet b {
        font-weight: bold;
      }
      .cc {
        float: right;
      }
      .cn {
        margin-left: 10px;
        float: left;
        max-width: 170px;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      .phone_code_label
	  {
    	width: 60px;
    	height: 42px;
     	display: inline-block;
    	float: left;
    	position: absolute;
    	line-height: 42px;
    	text-align: center;
    	font-size:14px;
    	color:black;
	  }
	  .phone_code_label:after{
	    content: "";
    	border-color: transparent #E6E6E6 #E6E6E6 transparent;
    	border-style: solid;
    	transform: rotate(45deg);
    	border-width: 2px;
    	height: 5px;
   		width: 5px;
    	position: absolute;
    	right: 2px;
    	top: 14px;
    	border-radius: 1px;
    	display: inline-block;
	  }
	  .pcl_edit{
	  	pointer-events: none;
	  }
	  .pcl_edit:after{
	  	display: none;
	  }
      /* UV */
      .mobile_input.selectbox--focus {
		border: 1px solid #1389e3 !important;
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
		.top_msg{
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
		.error_icon{
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
      #footer {
		    width: 100%;
		    height: 20px;
		    font-size: 14px;
		    color: #727272;
		    position: absolute;
		    margin: 20px 0px;
		    text-align: center;
	  }
	  #footer a{
		color:#727272;
	  }
	  
		.loader,
		.loader:after {
  			border-radius: 50%;
  			width: 10px;
  			height: 10px;
		}
		.loader {
			display: inline-block;
  			font-size: 10px;
  			position: relative;
  			top: 2px;
  			margin-right: 10px;
  			text-indent: -9999em;
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
	  .tick {
        display: inline-block;
        margin-right: 10px;
        width: 10px;
        height: 5px;
        border-left: 2px solid #0093ff;
        border-bottom: 2px solid #0093ff;
        transform: rotate(-45deg);
        position: relative;
        top: -4px;
      }
      .verified_tick{
       height:5px;
       width:0px;
       animation: 0.6s ease-in-out 0s 1 forwards running tick;
       margin-right: 0px;
       margin-left: 10px;
       left:-10px;
      }
	  @keyframes tick {
        0% {
          width: 0px;
        }
        100% {
          width: 10px;
        }
      }
      .white{
		border-bottom-color: #ffffff;
		border-left-color: #ffffff;
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
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
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
        .otp_input_container {
          width: 100%;
        }
        .mobile_input_container {
          width: 100%;
        }
        #mobile_input {
          width: 100%;
        }
        button {
          width: 100%;
        }
        .add-new{
		  margin: auto;
		  margin-top: 20px;
		  margin-bottom: 30px;
        }
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
      }
    </style>
    <@resource path="/v2/components/css/flagStyle.css" />
    <script>
      	var csrfParam= "${za.csrf_paramName}";
      	var csrfCookieName = "${za.csrf_cookieName}";
      	var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
      	var resendTimer, resendtiming, altered;
      	var countryDialCode = "";
    	var countryCode = "";
    	var mobile = "";
    	var showMobileNoPlaceholder = ${mob_plc_holder?c};
    	<#if req_country??>var IPcountry = "${req_country}";</#if>
		var isMobile = ${is_mobile?c};
		//var unverifiedMobiles = ${mobiles};
		var emailormobilevalue = "+" + countryDialCode+" "+mobile+countryCode;
		var mode = "mobile"; //since this is a mobile based annoucement .. else we dont need to set the mode.
		var isEdit = true; //since number will not be enforced in this
		var otp_length = ${otp_length};
		I18N.load({
      	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
      	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
      	"IAM.GENERAL.ERROR.INVALID.OTP" : '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
      	"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP" />',
      	"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID"/>',
      	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
	  	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
	  	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
	  	"IAM.VERIFIED" : '<@i18n key="IAM.VERIFIED"/>',
	  	"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
	  	"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL"/>',
	  	"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
	  });
	  var iam_search_text = '<@i18n key="IAM.SEARCHING" />';
	  var iam_no_result_found_text = '<@i18n key="IAM.NO.RESULT.FOUND" />';
	  var cryptData;
	  <#if nxt_preann_url??>var next = "${nxt_preann_url}";</#if>
	  function handleEditOption(mode) {
	  	initMobileSelect();
	  	clearError("#"+ mode +"_input");
        $(".otp_input_container, .otp_sent_desc").slideUp(200);
        document.querySelector(".enter_eml_mob_desc").style.display = "block";
        document.querySelector(".send_otp_btn").style.display = "inline-block";
        altered = false
        if (!resendtiming == 0) {
          $(".send_otp_btn").prop("disabled", true);
        }
        $(document.confirm_form1).slideDown(200);
        if($(".unverContainer").length>0){
        	$(".back_btn").show();
        }
        document.querySelector("." + mode + "_input_container").style.display = "block";
        document.querySelector("#" + mode + "_input").focus();
        if(mode === "email"){
        document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        }else{
        if(countryCode){
		reqCountry = "#"+countryCode.toUpperCase();
      	$('#countNameAddDiv option:selected').removeAttr('selected');
      	$("#countNameAddDiv "+reqCountry).prop('selected', true);
      	$("#countNameAddDiv "+reqCountry).trigger('change');
		}
        document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobile.toString());
        }
      }
	  
	  function sendOTP(mode, emailormobilevalue, isExistingUnverfied) {
      	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
      	$(".send_otp_btn").prop("disabled", true);
        if (mode === "email") {
        	if (isEmailId(emailormobilevalue)) {
        		$("div.valueemailormobile").html(emailormobilevalue);
            	var params = { blockunconfirmeduser: { login_id: emailormobilevalue } };
            	sendRequestWithCallback("/webclient/v1/announcement/pre/loginmobile", JSON.stringify(params), true, handleOtpSent, "POST")
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
             $(".send_otp_btn").removeAttr("disabled");
          	}
        } else if (mode === "mobile") {
          	if (isPhoneNumber(mobile)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		emailormobilevalue = emailormobilevalue.substring(0,emailormobilevalue.length-2);
          		$("div.valueemailormobile").html(emailormobilevalue);
           		var params = { addmobilerecovery: { mobile: mobile, countrycode: countryCode } };
           		sendRequestWithCallback("/webclient/v1/announcement/pre/addrecovery", JSON.stringify(params), true,  function(res) {
           			handleOtpSent(res, params);
           		}, "POST")
          	} else {
          		show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          		$(".send_otp_btn").removeattr("disabled");
          	}
        }
      }
      
      function handleOtpSent(respStr, params){
		if(respStr!="" && respStr!= undefined){
			$(".send_otp_btn").removeAttr("disabled");
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
				clearError('#otp_split_input');
				if(isEdit){
					document.querySelector(".edit_option").style.display = "inline-block";
				}
				$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container, .existing_numbers_container, .update_send_otp_btn, .back_btn").slideUp(200);
				$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.addmobilerecovery.encrypted_data){
					cryptData = resp.addmobilerecovery.encrypted_data;
				}
			}
			else{
				if(mode === "email"){
					show_error_msg("#email_input", resp.localized_message);
				}else if(mode === "mobile"){
					function errHandler(res) {
						if($("[jsid='verfied_phnnum'].uvselect").is(":visible")){
	          				show_error_msg("[jsid='verfied_phnnum'].selectbox", res.localized_message);
	          			} else {
							show_error_msg("#mobile_input", res.localized_message);
						}
					}
					if(handleCaptcha().isRequired(resp)) {
						handleCaptcha(resp, {
							callbacks : {
								beforeInit: function() {
									$('form[name="confirm_form1"]').slideUp(200);
								}
							}
						})
						.init('#add-rec-mob-captcha', sendRequestWithCallback, ["/webclient/v1/announcement/pre/addrecovery", params]).then(handleOtpSent, function(err){
							$('form[name="confirm_form1"]').slideDown(300);
							errHandler(err);
						});
					} else {
						errHandler(resp);
					}
				}
			}
	  	} else{
	  		showErrMsg("<@i18n key="IAM.ERROR.GENERAL"/>");
	  	}
	  }
	  
	  function resendOTP(){
	  $(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	var params= {};
	  	sendRequestWithCallback("/webclient/v1/announcement/pre/addrecovery/"+cryptData, "", true, handleOtpResent, "PUT");
	  }
	  
	  function handleOtpResent(respStr){
	  	if(respStr!="" && respStr!= undefined){
	  	var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
			}
			else{
			show_error_msg("#otp_split_input", resp.localized_message);
			}
	  	}
	  }
	  function updateEmlMblValue() {
        clearError('#'+mode+'_input');
        var splitinput = document.querySelectorAll("input.splitedText");
        for (var x=0;x<splitinput.length;x++){
        	splitinput[x].value = "";
        }
        if (mode === "email") {
          var login_id = $("#email_input").val();
          if (isEmailId(login_id)) {
          	emailormobilevalue = login_id;
            sendOTP(mode, login_id);
          }else{
            show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
          }
        }
        else if (mode === "mobile"){
          var login_id = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
          if (isPhoneNumber(login_id)) {
          	mobile = login_id;
          	var dialCode = $('#countNameAddDiv option:selected').attr("data-num");
          	var countryCode = $('#countNameAddDiv option:selected').attr("id");
          	emailormobilevalue=dialCode+" "+login_id+countryCode;
          	sendOTP(mode, emailormobilevalue);
          }else{
          show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          }
        }
      }
	  
	  function resendOtpChecking() {
        resendtiming = 60;
        clearInterval(resendTimer);
        $(".resend_otp").addClass("nonclickelem");
        $(".resend_otp span").text(resendtiming);
        $(".resend_otp").html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
        $(".send_otp_btn").prop("disabled", true);
        resendTimer = setInterval(function () {
          resendtiming--;
          $(".resend_otp span").html(resendtiming);
          if(!altered){
          $(".send_otp_btn span").css("margin-left","5px");
          $(".send_otp_btn span").html(resendtiming+"s");
          }
          if (resendtiming === 0) {
            clearInterval(resendTimer);
            $(".resend_otp").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
            $(".send_otp_btn span").html("");
            $(".send_otp_btn span").css("margin","0px");
            $(".resend_otp").removeClass("nonclickelem");
            $(".send_otp_btn").removeAttr("disabled");
          }
        }, 1000);
      }
      
      function verifyCode(e) {
      	e.preventDefault();
        var Code = document.querySelector("#otp_split_input_full_value").value;
        if(Code == ""){
			show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
			return false;
		}
		if(!isValidCode(Code)){
			show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.VALID.OTP"));//No I18N
			return false;
		}
        if($(".error_msg").length<1){
        	clearError('#otp_split_input');
        	$(".verify_btn span").html("<div class='loader white'></div>");
        	$(".verify_btn").prop("disabled", true);
        	var params = { addmobilerecovery : { code: Code } };
        	sendRequestWithCallback("/webclient/v1/announcement/pre/addrecovery/"+cryptData, JSON.stringify(params), true, handleVerifyCode, "PUT")
        }
      }
		
	  function handleVerifyCode(respStr){
		if(respStr!="" && respStr!= undefined){
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
			$(".resend_otp").css("visibility","hidden");
			setTimeout(function(){
			$(".verify_btn").prop("disabled", false);
			$(".verify_btn").html("<div class='tick verified_tick white'></div>"+I18N.get('IAM.VERIFIED'));
			setTimeout(function(){
				window.location.href = next;
			}, 1000);
			},1000);
			}
			else{
			$(".verify_btn span").html("");
        	$(".verify_btn").prop("disabled", false);
        	show_error_msg("#otp_split_input", resp.localized_message);
			}
		}
	  }

	  function show_error_msg(siblingClassorID, msg) {
	  	$(".error_msg").remove();
        var errordiv = document.createElement("div");
        errordiv.classList.add("error_msg");
        $(errordiv).html(msg);
        $(errordiv).insertAfter(siblingClassorID);
        $(siblingClassorID).addClass("errorborder");
        $(".error_msg").slideDown(150);
      }
      
      function clearError(ClassorID, e){
      	if( e && e.keyCode == 13 && $(".error_msg:visible").length){
			return;
		}
      	$(ClassorID).removeClass("errorborder")
        $(".error_msg").remove();
      }

      function selectAlreadyNumbers(){
      	$(".mobile_input_container, .enter_eml_mob_desc, .send_otp_btn").slideUp(200);
      	$(".existing_numbers_container, .update_send_otp_btn").slideDown(200);
      	$(document.confirm_form2.verified_nums).uvselect({
			"searchable" : true, //No I18N
			"dropdown-align": "left", //No I18N
			"embed-icon-class": "flagIcons", //No I18N
			"country-flag" : true, //No I18N
			"use-attr-as-value" : "id", //No I18N
			"onDropdown:open" : function(){ //No I18N
				clearError("[jsid='verfied_phnnum'].selectbox");
			}
		});
      }
	  function addNewNumber(){
	  	$(".mobile_input_container, .enter_eml_mob_desc").slideDown(200);
	  	$(".send_otp_btn").css("display","inline-block");
	  	$(".existing_numbers_container, .update_send_otp_btn").slideUp(200);
	  	document.querySelector("#" + mode + "_input").focus();
	  }
     
      function updateAlreadyMblValue(){
      	var countryCode = $('#verfied_phnnum option:selected').attr("value");
      	var dialCodeMobile =  $('#verfied_phnnum option:selected').text();
      	mobile = dialCodeMobile.split(" ")[1];
      	emailormobilevalue = dialCodeMobile + countryCode;
      	sendOTP(mode, emailormobilevalue);
      }

      function allowSubmit(e) {
        if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mode === "mobile" && mobile === e.target.value.replace(/[+ \[\]\(\)\-\.\,]/g,'') || mobile === ""){
        	altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        } 
        else {
        altered = true;
          $(".send_otp_btn span").html("");
          $(".send_otp_btn").prop("disabled", false);
        }
      }

      function phonecodeChangeForMobile(ele){
		$(ele).css({'opacity':'0','width':'60px','height':'42px'});
		$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
		$(ele).change(function(){
			$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
	    })
	  }

	  function sendRequestWithCallback(action, params, async, callback,method){
		if (typeof contextpath !== 'undefined') {
			action = contextpath + action;
		}
    	var objHTTP = xhr();
    	objHTTP.open(method?method:'POST', action, async);
    	objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    	objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
    	if(async){
			objHTTP.onreadystatechange=function() {
	    	if(objHTTP.readyState==4) {
	    		if (objHTTP.status === 0 ) {
					showErrMsg("<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>");
					$(".resend_otp").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
					$(".verify_btn").html("<@i18n key="IAM.NEW.SIGNIN.VERIFY"/>");
					$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", true);
					checkNetConnection();
					return false;
				}
				if(callback) {
					if(JSON.parse(objHTTP.responseText).code === "Z113"){
						showErrMsg("<@i18n key="IAM.ERROR.SESSION.EXPIRED"/>");
						return false;
					}
					callback(objHTTP.responseText);
				}
			}
		};
    	}
		objHTTP.send(params);
		if(!async) {
		if(callback) {
			callback(objHTTP.responseText);
			}
			}
	  }
	  function checkNetConnection(){
	  	setInterval(function(){
	  		if(window.navigator.onLine){
	  			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
	  		}
	  	}, 2000)
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
	  function caseCheck(){
	  	document.querySelector(".enter_eml_mob_desc").style.display = "block";
	  	document.querySelector(".mobile_input_container").style.display = "block";
	  	document.querySelector(".send_otp_btn").style.display = "inline-block";
	  	initMobileSelect();
		if(countryCode!=""){
			$(document.confirm_form1.countrycode).val(countryCode);
			$(document.confirm_form1.countrycode).trigger('change');
		}
		document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobile.toString());
		if(!isEdit){
			$(document.confirm_form1.mobile_no).attr("readonly",true);
			$(".selectbox_arrow").remove();
			$("#countNameAddDiv").css("pointer-events", "none");
			$(".phone_code_label").addClass("pcl_edit")
			document.querySelector("#mobile_input").style.backgroundColor = "#f9f9f9";
			document.querySelector("#mobile_input").style.textIndent = "72px";
			document.querySelector("#mobile_input").classList.remove("textindent66");
			if(document.querySelector(".already_added")){
				document.querySelector(".already_added").style.display = "none";
			}
		}
		if( mobile == "" && countryCode == "" && IPcountry!=""){
			$(document.confirm_form1.countrycode).val(IPcountry);
			$(document.confirm_form1.countrycode).trigger('change');
		}
		setTimeout(function(){
			$("#mobile_input").focus();
		}, 200)
		
	  }
	  
	  function initMobileSelect(){
	  	if (mode === "mobile") {
	  		if(!isMobile) {
			$(document.confirm_form1.countrycode).uvselect({
				"width": '80px', //No i18N
				"searchable" : true, //No i18N
				"dropdown-width": "300px", //No i18N
				"dropdown-align": "left", //No i18N
				"embed-icon-class": "flagIcons", //No i18N
				"country-flag" : true, //No i18N
				"country-code" : true  //No i18N
			});
        	phonePattern.intialize(document.confirm_form1.countrycode);
        	 $(".phone_code_label").css("visibility" ,"hidden")
      		} else {
       		phonecodeChangeForMobile(document.confirm_form1.countrycode);
      		}
    	}
	  }
	  function backToUnverified(){
	  	$(document.confirm_form1).slideUp(200);
	  	$(".unverContainer").slideDown(200);
	  }
	  function verifyNumber(e,dCode, cCode, mob){
	  	emailormobilevalue="+"+dCode+" "+mob+cCode;
	  	mode="mobile";
	  	mobile= mob;
	  	$(".back_btn").show();
	  	$(e.target).css({"opacity":1});
	  	$(".verify-tick").css("pointer-events","none");
	  	sendOTPUnverified(mode, emailormobilevalue);
	  }
	  function sendOTPUnverified(mode, emailormobilevalue){
	  	if(mode==="mobile"){
	  		if (isPhoneNumber(mobile)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		emailormobilevalue = emailormobilevalue.substring(0,emailormobilevalue.length-2);
          		$("div.valueemailormobile").html(emailormobilevalue);
           		var params = { addmobilerecovery: { mobile: mobile, countrycode: countryCode } };
           		sendRequestWithCallback("/webclient/v1/announcement/pre/addrecovery", JSON.stringify(params), true, function(res) {
           			handleOtpSentUnverfied(res, params);
           		}, "POST")
          	} else {
          		showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
          		$(".verify-tick").css({"opacity":0.5,"pointer-events":"all"});
          	}
	  	}
	  }
	  function handleOtpSentUnverfied(respStr, params){
	  	if(respStr!="" && respStr!= undefined){
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
				clearError('#otp_split_input');
				if(isEdit){
					document.querySelector(".edit_option").style.display = "inline-block";
				}
				$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container, .existing_numbers_container, .update_send_otp_btn").slideUp(200);
				$(".unverContainer").slideUp(200);
				$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.addmobilerecovery.encrypted_data){
					cryptData = resp.addmobilerecovery.encrypted_data;
				}
				$(".verify-tick").css({"opacity":0.5,"pointer-events":"all"});
			}
			else{
				if(mode === "mobile"){
					function errHandler(res) {
						showErrMsg(res.localized_message);					
						$(".verify-tick").css({"opacity":0.5,"pointer-events":"all"});
					}
					if(handleCaptcha().isRequired(resp)) {
						handleCaptcha(resp, {
							callbacks: {
								beforeInit: function() {
									$('.unverContainer').slideUp(200);
								}
							}
						})
						.init('#add-rec-mob-captcha', sendRequestWithCallback, ["/webclient/v1/announcement/pre/addrecovery", params]).then(handleOtpSentUnverfied, function(err){
							$('.unverContainer').slideDown(300);
							errHandler(err);
						});
					} else {
						errHandler(resp);
					}
				}
			}
		}
	  }
	  function addNewNumber(e){
	  	$(".unverContainer").slideUp(200);
	  	$(document.confirm_form1).slideDown(200, function(){
	  		document.querySelector("#" + mode + "_input").focus();
	  	});
	  	$(".back_btn").show();
	  }
	  </script>
    </head>
    <body>
    <#include "../utils/captcha-handler.tpl">
    <div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
    <div class="flex-container container">
    	<div class="content_container">
        	<div class="rebrand_partner_logo"></div>
       		<#if !isPolicy>
        	<div class="announcement_header"><@i18n key="IAM.ADD.CONTACT.MOBILE"/></div>
			<div class="account_verify_desc"><@i18n key="IAM.ADD.RECOVERY.ORGADMIN.DESC"/></div>
			<div class="account_verify_desc"><@i18n key="IAM.ADD.RECOVERY.REC.ADMIN.DESC"/></div>
			<#else>
        	<div class="announcement_header"><@i18n key="IAM.ADD.RECOVERY.MOBILE.TITLE"/></div>
        	<div class="account_verify_desc"><@i18n key="IAM.ADD.RECOVERY.ORGUSER.DESC"/></div>
			<div class="account_verify_desc"><@i18n key="IAM.ADD.RECOVERY.REC.DESC"/></div>
        	</#if>	
        		<div class="otp_sent_desc" style="display: none">
        		<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>
          		<span class="emailormobile">
            	<div class="valueemailormobile"></div> 
            	<#if edit_mobile?? && edit_mobile>
            	<span class="edit_option" onclick="handleEditOption(mode)"><@i18n key="IAM.EDIT"/></span>
            	<#else>
            	<span class="edit_option" onclick="handleEditOption(mode)" style="display: none"><@i18n key="IAM.EDIT"/></span>
            	</#if>
          		</span>
        	</div>
        	
        	<form name="confirm_form" onsubmit="verifyCode(event);return false">
        		<div class="otp_input_container" style="display: none">
              		<label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
              		<div id="otp_split_input" class="otp_container"></div>
              		<div class="resend_otp" onclick="resendOTP()"><span></span><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></div>
              		<button class="verify_btn" onclick="verifyCode(event)"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
            	</div>
        	</form>
        	<#if !(mobiles?has_content)>
        	<form name="confirm_form1" onsubmit="return false">
        	<#else>
        	<div class="unverContainer">
        	<div class="unverHeader">
        		<@i18n key="IAM.UNVERIFIED.MOBILE.NO"/>
        	</div>
        	<#list mobiles as x>
        		<div class="numb-cont">
                    <div class="mobile-icon icon2-pebble icon2-Mobile"></div>
                    <div class="numb-details">
                      	<span class="unverified-number">+${x.dialCode}</span> <span>${x.mobile}</span>
                    </div>
                   <div class="verify-tick" onclick='verifyNumber(event,"${x.dialCode}","${x.countryCode}","${x.mobile}")'><div class="icon-ccomplete"></div><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></div>
                </div>
        	</#list>
        	<button class="link-btn add-new" onclick='addNewNumber(event)'><@i18n key="IAM.MFA.ADD.NEW.MOBILE.NUMBER"/></button>
        	</div>
        	
        	<form name="confirm_form1" onsubmit="return false" style="display: none">
        	</#if>
        		<div class="enter_eml_mob_desc" style="display: none">
				<#if edit_mobile?? && edit_mobile>
					<@i18n key="IAM.MOBILE.SEND.OTP.VERIFY"/>
				<#else>
					<@i18n key="IAM.ADD.LOGIN.SEND.OTP.ENFORCED.VERIFY"/>
				</#if>
            	</div>
        	 	<div class="mobile_input_container field" style="display: none" id="select_phonenumber">
              	<label for="mobile_input" class="emolabel"><@i18n key="IAM.NEW.SIGNIN.MOBILE"/></label>
              	<label for="countNameAddDiv" class="phone_code_label"></label>
              	<select
                	id="countNameAddDiv"
               		data-validate="zform_field"
                	autocomplete="country-name"
                	name="countrycode"
                	class="countNameAddDiv"
                	style="width: 300px"
              	>
              	<#list country_list as dialingcode>
				<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
              	</#list>
              	</select>
              	<input
                	class="textbox mobile_input"
                	tabindex="0"
                	data-validate="zform_field"
                	autocomplete="phonenumber"
                	onkeydown="clearError('#mobile_input', event)"
                	name="mobile_no"
                	id="mobile_input"
                	maxlength="15"
                	data-type="phonenumber"
                	type="tel"
                	oninput="allowSubmit(event)"
              	/>
            	</div>
            	<button class="send_otp_btn" onclick="updateEmlMblValue()" style="display: none"><@i18n key="IAM.SEND.VERIFY"/><span style="margin:0"></span></button>
        		<button class="back_btn" onclick="backToUnverified()" style="display: none"><@i18n key="IAM.BACK"/></button>
        	</form>
        	<div id="add-rec-mob-captcha"></div>
    	</div>
    	<div class="illustration-container">
        	<div class="illustration"></div>
      	</div>
    </div>
    </body>
  	<footer id="footer">
  		<#include "../Unauth/footer.tpl">
  	</footer>
    <script>
    	window.onload = function () {
    		caseCheck();
    		splitField.createElement("otp_split_input", {
        		splitCount: otp_length, 
        		charCountPerSplit: 1, 
        		isNumeric: true, 
        		otpAutocomplete: true, 
        		customClass: "customOtp", 
        		inputPlaceholder: "&#9679;", 
        		placeholder: "<@i18n key="IAM.ENTER.CODE"/>", 
      		});
      		$("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input', event)");
      		setFooterPosition();
      	}
	</script>
</html>