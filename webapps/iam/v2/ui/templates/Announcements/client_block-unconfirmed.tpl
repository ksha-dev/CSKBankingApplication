<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.BLOCK.UNCONFIRMED.TITLE"/></title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/tp_pkg/xregexp-all.js" />
    <@resource path="/v2/components/js/splitField.js" />
    <@resource path="/v2/components/js/flagIcons.js" />
	<@resource path="/v2/components/js/uvselect.js" />
	<@resource path="/v2/components/css/uvselect.css" />
	<@resource path="/v2/components/css/flagIcons.css" />
	<script type="text/javascript" src="${cp_contextpath}/encryption/script"></script>
	<@resource path="/v2/components/js/security.js" />
    <script>
	    var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
    </script> 
    <@resource path="/v2/components/js/phonePatternData.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <@resource path="/v2/components/css/${customized_lang_font}" />
    <style>
      body {
        margin: 0;
        box-sizing: border-box;
      }
      .content_container {
        max-width: 540px;
        padding-top: 120px;
        padding-right: 4%;
        display: inline-block;
      }
      .rebrand_partner_logo {
        height: 40px;
        width:auto;
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
        text-indent: 15px;
        line-height: 44px;
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
        background: url("${SCL.getStaticFilePath("/v2/components/images/ann_blockunconfirmed.svg")}") no-repeat;
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
      .content_container {
        padding-left: 10%;
      }
      .otp_input_container {
        position: relative;
      }
      .otp_container {
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
        line-height: 44px;
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
      }
      b {
        font-weight: 500;
      }
      user agent stylesheet b {
        font-weight: bold;
      }
      /* UV */
	  .selectbox--focus {
		border: 1px solid #1389e3 !important;
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
      .verified_tick {
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
      .white {
		border-bottom-color: #ffffff;
		border-left-color: #ffffff;
	  }
	  #error_space {
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
	  }
	  .error_icon {
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
		.cp_display_name{
			font-size: 16px;
    		margin-bottom: 20px;
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
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
      }
    </style>
    <script> 
      var csrfParam= "${za.csrf_paramName}";
      var csrfCookieName = "${za.csrf_cookieName}";
      var contextpath =<#if cp_contextpath??>"${cp_contextpath}"<#else> "" </#if>
      var resendTimer, resendtiming , altered;
      var isEdit = true;
      var otp_length = ${otp_length};
      <#if email?has_content>
      	var mode = "email"; 
      	var emailormobilevalue = "${email}"; 
      <#else> 
      	var mode = "mobile"; 
      	var mobile = "${mobile}";
      	var countryCode = "${country_code}";
      	var showMobileNoPlaceholder = ${mob_plc_holder?c};
      	var isMobile = ${is_mobile?c};
      	var emailormobilevalue;
      	var countryDialCode;
      </#if>
      I18N.load({
      	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
      	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
      	"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP"/>',
      	"IAM.GENERAL.ERROR.INVALID.OTP" : '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
      	"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID"/>',
      	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
	  	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
	  	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
	  	"IAM.VERIFIED" : '<@i18n key="IAM.VERIFIED"/>',
	  	"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
	  });
	  var iam_search_text = '<@i18n key="IAM.SEARCHING" />';
	  var iam_no_result_found_text = '<@i18n key="IAM.NO.RESULT.FOUND" />';
      var cryptData;
      <#if nxt_preann_url??>var next = "${nxt_preann_url}";</#if>
	  function showErrMsg(msg) {
		document.getElementById("error_space").classList.remove("show_error");
	    document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N
	    document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
	    document.getElementById("error_space").classList.add("show_error");  
	    setTimeout(function() {
	    	document.getElementById("error_space").classList.remove("show_error");
	    }, 5000);;
	  }
      function sendOTP(mode, emailormobilevalue) {
      	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
      	$(".send_otp_btn").prop("disabled", "disabled");
        if (mode === "email") {
        	if (isEmailId(emailormobilevalue)) {
        		$("div.valueemailormobile").html(emailormobilevalue);
        		encryptData.encrypt([emailormobilevalue]).then(function(encryptedloginid) {
					encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
					var params = { blockunconfirmeduser: { email_id: encryptedloginid } };
            		sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm", JSON.stringify(params), true, handleOtpSent, "POST")
				});
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
             $(".send_otp_btn").removeAttr("disabled");
          	}
        } else if (mode === "mobile") {
          	if (isPhoneNumber(mobile)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		$("div.valueemailormobile").html(emailormobilevalue.substring(0,emailormobilevalue.length-2));
          		emailormobilevalue = (emailormobilevalue.substring(0,emailormobilevalue.length-2)).split(" ")[1];
          		encryptData.encrypt([emailormobilevalue]).then(function(encryptedloginid) {
					encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
					var params = { blockunconfirmeduser: { mobile: encryptedloginid, countrycode: countryCode} };
          			sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm", JSON.stringify(params), true, handleOtpSent, "POST");
				});
          	} else {
             show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
             $(".send_otp_btn").removeAttr("disabled");
          	}
        }
      }
      
	  function handleOtpSent(respStr){	
		if(respStr!="" && respStr!= undefined){
			$(".send_otp_btn").removeAttr("disabled");
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
			clearError('#otp_split_input');
			$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container").slideUp(200);
			$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.blockunconfirmeduser.encrypted_data){
					cryptData = resp.blockunconfirmeduser.encrypted_data;
				}
			}
			else{
			if($("#otp_split_input").is(":visible")){
				show_error_msg("#otp_split_input", resp.localized_message);
			}
			else {
				if(mode === "email"){
					show_error_msg("#email_input", resp.localized_message);
				}else if(mode === "mobile"){
					show_error_msg("#mobile_input", resp.localized_message);
				}
			}}
		}
	  }
	  
	  function resendOTP(){
	  	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	var params= {};
	  	sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm/"+cryptData, "", true, handleOtpResent, "PUT")
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
	  
      function verifyCode() {
        var Code = document.querySelector("#otp_split_input_full_value").value;
        if($(".error_msg").length<1){
        if(isValidCode(Code)){
        clearError('#otp_split_input');
        $(".verify_btn span").html("<div class='loader white'></div>");
        $(".verify_btn").prop("disabled", true);
        var params = { blockunconfirmeduser : { code: Code } };
        sendRequestWithCallback("/webclient/v1/announcement/pre/blockunconfirm/"+cryptData, JSON.stringify(params), true, handleVerifyCode, "PUT")
        }
        else{
        $(".verify_btn span").html("");
        $(".verify_btn").prop("disabled", false);
        show_error_msg("#otp_split_input", I18N.get('IAM.ERROR.VALID.OTP'));
        }
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
				window.location.href= next;
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
          ////////has to be changed
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
      
      function allowSubmit(e) {
        if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mode === "mobile" && mobile === e.target.value || mode === "mobile" &&  mobile === ""){
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

      function phonecodeChangeForMobile(ele)
	  {
		$(ele).css({'opacity':'0','width':'60px', 'height':'42px'});
		$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
		$(ele).change(function(){
			$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
	    })
	  }
	  
	  function sendRequestWithCallback(action, params, async, callback,method) {
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

	  function show_error_msg(siblingClassorID, msg) {
        var errordiv = document.createElement("div");
        errordiv.classList.add("error_msg");
        $(errordiv).html(msg);
        $(errordiv).insertAfter(siblingClassorID);
        $(siblingClassorID).addClass("errorborder")
        $(".error_msg").slideDown(150);
      }
      
      function clearError(ClassorID){
      	$(ClassorID).removeClass("errorborder")
        $(".error_msg").remove();
      }
      
    </script>

  </head>
  <body>
 	<div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
    <div class="flex-container container">
      <div class="content_container">
        <div class="cp_display_name">${Encoder.encodeHTML(app_display_name)}</div>
        <div class="announcement_header"><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION"/></div>
        <div class="account_verify_desc">
          <#if email?has_content>
          	<@i18n key="IAM.BLOCK.UNCONFIRMED.EMAIL.DESC"/>
          <#else>
          	<@i18n key="IAM.BLOCK.UNCONFIRMED.MOBILE.DESC"/>
          </#if>
        </div>
        <div class="otp_sent_desc" style="display: none">
        	<#if email?has_content>
          		<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>
          	<#else>
          		<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>
         	</#if>
          <span class="emailormobile">
            <div class="valueemailormobile"><#if email?has_content>${email}<#else>${mobile}</#if></div> 
          </span>
        </div>
        <div class="form_container">
          <form name="confirm_form" onsubmit="return false">
            <div class="enter_eml_mob_desc">
            <#if email?has_content>
          		<@i18n key="IAM.EMAIL.SEND.OTP.VERIFY"/>
          	<#else>
          		<@i18n key="IAM.MOBILE.SEND.OTP.VERIFY"/>
         	</#if>
            </div>
            <div class="email_input_container" style="display: none">
              <label for="email_input" class="emolabel"><@i18n key="IAM.EMAIL.ADDRESS"/></label>
              <input type="text" id="email_input" autocomplete="email" onkeydown="clearError('#email_input')" oninput="allowSubmit(event)" readonly style="background-color: #f9f9f9; pointer-events: none"/>
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
    				onkeydown="clearError('#mobile_input')"
					oninput="allowSubmit(event)"
    				name="mobile_no"
    				id="mobile_input"
    				maxlength="15"
    				data-type="phonenumber"
    				type="tel"
    				readonly
    				style="background-color: #f9f9f9; pointer-events: none"
  				/>
			</div>
            <button class="send_otp_btn" onclick="updateEmlMblValue()"><@i18n key="IAM.SEND.OTP"/><span style="margin:0"></span></button>
           </form>
           <form name="confirm_form1" onsubmit="return false">
             <div class="otp_input_container" style="display: none">
              <label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
              <div id="otp_split_input" class="otp_container"></div>
              <div class="resend_otp" onclick="resendOTP()"><span></span><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></div>
              <button class="verify_btn" onclick="verifyCode()"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
            </div>
          </form>
        </div>
      </div>
      <div class="illustration-container">
        <div class="illustration"></div>
      </div>
    </div>
  </body>
  
  <script>
    window.onload = function () {
      if(mode === "email"){
        document.querySelector("#" + mode + "_input").value = emailormobilevalue;
      } else if(mode === "mobile"){
      	countryDialCode = $(document.confirm_form.countrycode).find("#"+countryCode).attr("data-num");
      	emailormobilevalue = countryDialCode + " " + mobile + countryCode;
        if(countryCode){
			reqCountry = "#"+(countryCode.toUpperCase());
			$('#countNameAddDiv option:selected').removeAttr('selected');
			$("#countNameAddDiv "+reqCountry).prop('selected', true);
			$("#countNameAddDiv "+reqCountry).trigger('change');
		}
        document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobile.toString());
      }
      document.querySelector("." + mode + "_input_container").style.display = "block";
      
      splitField.createElement("otp_split_input", {
        splitCount: otp_length, 
        charCountPerSplit: 1, 
        isNumeric: true, 
        otpAutocomplete: true, 
        customClass: "customOtp", 
        inputPlaceholder: "&#9679;", 
        placeholder: "<@i18n key="IAM.ENTER.CODE"/>", 
      });
      $("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input')");
      if (mode === "mobile") {
      	if(!isMobile) {
        	$(document.confirm_form.countrycode).uvselect({
				"width": '80px', //No i18N
				"searchable" : true, //No i18N
				"dropdown-width": "300px", //No i18N
				"dropdown-align": "left", //No i18N
				"embed-icon-class": "flagIcons", //No i18N
				"country-flag" : true, //No i18N
				"country-code" : true  //No i18N
			});
        	$(".phone_code_label").css("visibility" ,"hidden")
      	} else {
        	phonecodeChangeForMobile(document.confirm_form.countrycode);
      	}
      	phonePattern.intialize(document.confirm_form.countrycode);
      }
      setFooterPosition();
      setTimeout(function(){
        if(mode === "mobile"){
        	$(".uvselect .selectbox_arrow").hide();
        	$(".uvselect.select_container").css("pointer-events","none")
        	var last = $("#mobile_input").val().length
        	$("#mobile_input")[0].setSelectionRange(last, last)
      		$("#mobile_input").focus();
      	}else{
      		$("#email_input").focus();
      	}
      }, 300)
    };
  </script>
</html>
