<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   	<#if (email)?has_content>
   		<title><@i18n key="IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.EMAIL"/></title>
   	<#else>
   		<title>
   			<#if (hasPrimaryEmail)?has_content>
			    <@i18n key="IAM.ADD.SECONDARY.EMAIL.TEXT" />
			<#else>
			    <@i18n key="IAM.EMAIL.ADDRESS.TITLE.TEXT" />
			</#if>
   		</title>
   	</#if>
   	<style>
		body {
		   	margin: 0;
			box-sizing: border-box;
		}
   	</style>
    <@resource path="/v2/components/css/${customized_lang_font}" />
  </head>
  <body>
	<#include "../zoho_line_loader.tpl">
	<@resource path="/v2/components/css/add_secondary_email.css" />
	<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
	<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
	<@resource path="/v2/components/js/splitField.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <link rel="preload" as="image" href="${SCL.getStaticFilePath('/v2/components/images/newZoho_logo.svg')}" type="image/svg+xml" crossorigin="anonymous">
	<style>

    </style>
        <script>
      var csrfParam= "${za.csrf_paramName}";
      var csrfCookieName = "${za.csrf_cookieName}";
      var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
      var resendTimer, resendtiming , altered;
      <#if (email)?has_content> var isEdit = false;<#else> var isEdit = true;</#if>
      var mode = "email";
      var emailormobilevalue = "${email}";
      var otp_length = ${otp_length};
      <#if (action)?has_content>var action = "${action}";</#if>

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
	  	"IAM.SSOKIT.ADDEMAIL.EMAIL.ADDED.VERIFIED": '<@i18n key="IAM.SSOKIT.ADDEMAIL.EMAIL.ADDED.VERIFIED"/>'
	  });
      var cryptData;
      <#if nxt_preann_url??>var next = "${nxt_preann_url}";</#if>
      function handleEditOption(mode) {
     	clearError("#"+ mode +"_input");
        $(".otp_input_container, .otp_sent_desc").slideUp(200);
        document.querySelector(".enter_eml_mob_desc").style.display = "block";
        document.querySelector(".send_otp_btn").style.display = "block";
        if (!resendtiming == 0) {
          $(".send_otp_btn").prop("disabled", true);
        }
        document.querySelector("." + mode + "_input_container").style.display = "block";
        document.querySelector("#" + mode + "_input").focus();
       	if(mode === "email"){
			document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        }
      }
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
        if (mode === "email") {
        	if (isEmailId(emailormobilevalue)) {
        		$("div.valueemailormobile").html(emailormobilevalue);
        		<#if (action)?has_content>
            	var params = { email: { email: emailormobilevalue , action : action}};
            	<#else>
            	var params = { email: { email: emailormobilevalue }};
            	</#if>
            	sendRequestWithCallback("/webclient/v1/ssokit/email", JSON.stringify(params), true, handleOtpSent, "POST")
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
          	}
        }
      }

	  function handleOtpSent(respStr){
		if(respStr!="" && respStr!= undefined){
			var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
			clearError('#otp_split_input');
			if( isEdit ){
			document.querySelector(".edit_option").style.display = "inline-block";
			}
			$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container").slideUp(200);
			$(document.confirm_form1).css("display","block");
			$(".otp_input_container, .otp_sent_desc").slideDown(200);
				setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
				resendOtpChecking();
				}, 1000);
				}, 800);
				if(resp.email){
					<#if (action)?has_content>
					cryptData = resp.email.encrypted_data;
					<#else>
					cryptData = resp.email.email;
					</#if>
				}
			}
			else{
			if($("#otp_split_input").is(":visible")){
				show_error_msg("#otp_split_input", resp.errors[0].message);
			}
			else {
				if(mode === "email"){
					show_error_msg("#email_input", resp.errors[0].message);
				}
			}}
		}
	  }
	  
	  function resendOTP(){
	  	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	<#if (action)?has_content>
	  	var params= {email : {action : action}};
	  	<#else>
	  	var params= {};
	  	</#if>
		sendRequestWithCallback("/webclient/v1/ssokit/email/"+cryptData, JSON.stringify(params), true, handleOtpResent, "PUT")
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
			clearError('#otp_split_input');
			show_error_msg("#otp_split_input", resp.errors[0].message);
			resetResend();
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
        <#if (action)?has_content>
        var params = { email : { code: Code , action : action}};
        <#else>
        var params = { email : { code: Code }};
        </#if>
        sendRequestWithCallback("/webclient/v1/ssokit/email/"+cryptData, JSON.stringify(params), true, handleVerifyCode, "PUT")
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
			$(".result").css("display", "block");
			<#if (email)?has_content>
				resp.msg = '<@i18n key="IAM.SSOKIT.ADDEMAIL.EMAIL.VERIFIED" arg0="${email}" />';
			<#else>
				resp.msg = formatMessage(I18N.get("IAM.SSOKIT.ADDEMAIL.EMAIL.ADDED.VERIFIED"), emailormobilevalue);
			</#if>
			setTimeout(function(){
				showResultPop("newsuccess", resp);
			}, 1000);
			},1200);
			}
			else{
			$(".verify_btn span").html("");
			$(".verify_btn").prop("disabled", false);
			show_error_msg("#otp_split_input", resp.errors[0].message);
			}
		}
	  }
	  function showResultPop(type, resp){
	  	if(type = "alreadysuccess"){
	  		$(".result svg #Path_4619").css("fill", "#f2f2f2");
	  	} else if(type = "error"){
	  		$(".result svg #Path_4619").css("fill", "#fff2f2");
	  		$(".result .pop_icon").addClass("error")
	  	} else if(type = "newsuccess"){
	  		$(".result svg #Path_4619").css("fill", "#DEFAE2");
	  	}
	  	if(resp.redirect_url && resp.redirect_url != ''){
	  		$(".result .cont_btn").css("display","block");	
	  		$(".result .cont_btn").attr("onclick", "window.location.replace('"+resp.redirect_url+"')");
	  	}
	  	$(".defin_text").html(resp.msg);
	  	$(".result").css("opacity", "1");
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
			resetResend();
          }
        }, 1000);
      }
     function resetResend(){
            $(".resend_otp").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
            $(".send_otp_btn span").html("");
            $(".send_otp_btn span").css("margin","0px");
            $(".resend_otp").removeClass("nonclickelem");
            $(".send_otp_btn").removeAttr("disabled");
      }
      function allowSubmit(e) {
        if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mode === "mobile" && mobile === (e.target.value).replace(/[+ \[\]\(\)\-\.\,]/g,'') || mode === "mobile" && mobile === ""){
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
 	<div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
	<div class="result" style= "display:none">
	<div class="rebrand_partner_logo"></div>
	<div class="result_popup" id="result_popup_error">
		<div class="pop_bg">
			<svg xmlns="http://www.w3.org/2000/svg" width="578px" height="118px" viewBox="0 0 578 118">
				<path id="Path_4619" data-name="Path 4619" d="M4394,8408.59s-55.223,29.924-95.023,29.924c-97.791,0-173.495-49.193-282.564-49.193S3816,8434.855,3816,8434.855V8320.514h578Z" transform="translate(-3816 -8320.514)" fill="#DEFAE2"/>
			</svg>
		</div>
		<div class="pop_icon"><span class="inner_circle"></span></div>
		<div class="content_space">
			<div class="grn_text" id="result_content"></div>
			<div class="defin_text"></div>
		</div>
	</div>
	<button class="cont_btn" onclick="window.location.replace('')" style="display: none"><span></span><@i18n key="IAM.CONTINUE"/></button>
	</div>
    <div class="flex-container container">
      <div class="content_container">
        <div class="rebrand_partner_logo"></div>
        <div class="announcement_header">
            <span>
            <#if (email)?has_content>
				<@i18n key="IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.EMAIL"/>
            <#else>
				<#if (hasPrimaryEmail)?has_content>
			    	<@i18n key="IAM.ADD.SECONDARY.EMAIL.TEXT" />
				<#else>
			    	<@i18n key="IAM.EMAIL.ADDRESS.TITLE.TEXT" />
				</#if>
            </#if>
			</span>
        </div>
        <div class="otp_sent_desc" style="display: none">
        	<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>
        	<span class="emailormobile">
            	<div class="valueemailormobile"><#if email?has_content>${email}<#else>${mobile}</#if></div> 
            	<#if !(email)?has_content><span class="edit_option" onclick="handleEditOption(mode)" style="display: none"><@i18n key="IAM.EDIT"/></span></#if>
          	</span>
        </div>
        <div class="form_container">
          <form name="confirm_form" onsubmit="return false" style="display: none">
            <div class="enter_eml_mob_desc">
          		<@i18n key="IAM.EMAIL.SEND.OTP.VERIFY"/>
            </div>
            <div class="email_input_container" style="display: none">
              <label for="email_input" class="emolabel"><@i18n key="IAM.EMAIL.ADDRESS"/></label>
              <input type="text" id="email_input" autocomplete="email" onkeydown="clearError('#email_input')" oninput="allowSubmit(event)" />
            </div>
            <button class="send_otp_btn" onclick="updateEmlMblValue()"><@i18n key="IAM.SEND.OTP"/><span></span></button>
          </form>
          <form name="confirm_form1" onsubmit="return false" style="display: none">
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
  <footer id="footer">
	<#include "../Unauth/footer.tpl">
  </footer>

  <script>
    window.onload = function () {
		setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500);
		<#if (isVerified)?has_content && isVerified>
			$(".flex-container").css("display", "none");
			var resp= {};
			resp.msg = '<@i18n key="IAM.SSOKIT.ADDEMAIL.EMAIL.ALREADY.VERIFIED" arg0="${email}" />';
			resp.redirect_url = <#if redirect_uri?has_content>"${redirect_uri}"<#else>""</#if>;
			$(".result").css("display", "block");
			showResultPop("alreadysuccess",resp);
		<#else>
      	if(mode === "email"){
        document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        if(emailormobilevalue !== '' && isEmailId(emailormobilevalue)){
			$(".enter_eml_mob_desc, .send_otp_btn, ."+ mode +"_input_container").slideUp(200);
			$(".otp_input_container, .otp_sent_desc").slideDown(200);
			$(document. confirm_form1).css("display", "block")
			sendOTP(mode, emailormobilevalue);
        }
        else{
      		$(document. confirm_form).css("display", "block")
      		document.querySelector("." + mode + "_input_container").style.display = "block";
      		document.querySelector("." + mode + "_input_container input").focus();
     	}
      	}

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
      	setFooterPosition();
		</#if>
	};
  </script>
</html>
