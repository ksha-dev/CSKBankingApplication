<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <#if action?? && action == 0><@i18n key="IAM.REMOVE.EMAIL"/> | <#elseif action?? && action == 1><@i18n key="IAM.DELETE.ACCOUNT"/> | </#if><@i18n key="IAM.ZOHO.ACCOUNTS" />
    </title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/js/zresource.js" />
    <@resource path="/v2/components/js/uri.js" attributes="async" />
    <@resource path="/v2/components/js/splitField.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <@resource path="/v2/components/css/${customized_lang_font}" />
   	<style>
        @font-face {
            font-family: 'Announcement';
            src: url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
            src: url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
            font-weight: normal;
            font-style: normal;
            font-display: block;
        }
        [class^="icon-"],
        [class*=" icon-"] {
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

        .icon-warning:before {
            content: "\e962";
        }

        .icon-reload:before {
            content: "\e961";
        }

        body {
            margin: 0;
            box-sizing: border-box;
        }
        .content_container {
            max-width: 540px;
            padding-top: 80px;
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
            user-select: none;
        }
        [class*="_desc"] {
            font-size: 16px;
            line-height: 24px;
            margin-bottom: 20px;
            cursor: default;
            user-select: none;
        }
        .otp_sent_desc,
        .enter_eml_mob_desc {
            margin-bottom: 30px;
        }
        .enter_eml_mob_desc{
        	color: #E56000;
        }
        .valueemailormobile {
            display: inline-block;
			word-break: break-all;
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
        [class*="_input_container"] {
            width: 300px;
            margin-bottom: 30px;
        }
        .emailormobile {
            font-weight: 600;
        }
        .resend_otp {
            font-size: 14px;
            line-height: 26px;
            margin: 10px 0 20px 0;
            cursor: pointer;
            font-weight: 500;
            color: #0093ff;
            width: max-content;
        }
      	.check_container{
        	position: relative;
        }
        .check_container > div{
        	margin-left: 22px;
        	font-size: 14px;
        	line-height: 20px;
        	user-select: none;
        }
        .check_container + .error_msg{
        	margin-top: 10px;
        }
        [id*="_input"] {
            height: 44px;
            padding: 12px 15px 14px 15px;
            line-height: 30px;
            width: 300px;
            border: 1px solid #0f090933;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            font-family: "ZohoPuvi";
            transition: 0.2s all ease-in-out;
            user-select: none;
        }
        [id*="_input"]:focus-visible {
            outline: none;
        }
        input#otp_input {
            margin-bottom: 0px;
            padding: 14px 15px;
        }
        #check_input{
        	width: 0px;
        	height: 0px;
        	position: absolute;
        	display: none;
        }
        [class*="_btn"] {
            font: normal normal 600 14px/30px ZohoPuvi;
            padding: 5px 30px;
            border-radius: 4px;
            color: white;
            border: none;
            background: #1389e3 0% 0% no-repeat padding-box;
            cursor: pointer;
        }
        [class*="_btn"]:hover {
            background-color: #0779CF;
        }
        .send_otp_btn span {
            font-size: 12px
        }
        .send_otp_btn span.loader {
            margin-left: 10px;
            margin-right: 0px;
        }
        .cont_btn{
        	display: block;
        	margin: auto;
        	margin-top: 20px;
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
            <#if action?? && action == 0>
            background: url("${SCL.getStaticFilePath("/v2/components/images/email_detach_remove.svg")}") no-repeat;
            <#else>
            background: url("${SCL.getStaticFilePath("/v2/components/images/email_detach_delete.svg")}") no-repeat;
            </#if>
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
        .close_btn {
            display: inline-block;
            border-radius: 50%;
            cursor: pointer;
            position: absolute;
            right: 0px;
            top: 0px;
            width: 18px;
            height: 18px;
            transition: transform 0.1s;
            z-index: 1;
            margin: 4px;
			padding: 0px;
			background: unset;
        }
        .close_btn:before,
        .close_btn:after {
            display: block;
            content: "";
            height: 12px;
            width: 2px;
            background-color: #DECD98;
            margin: auto;
            border-radius: 1px;
            transform: rotate(-45deg);
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
            transition: transform 0.1s;
        }
        .close_btn:after {
			transform: rotate(45deg);
        }
        .close_btn:hover {
            transform: scale(1.2);
            background: unset;
        }
        #error_space {
            position: fixed;
            width: fit-content;
            width: -moz-fit-content;
            left: 0px;
            right: 0px;
            margin: auto;
            border: 1px solid #FCD8DC;
            display: flex;
            align-items: center;
            padding: 18px 30px;
            background: #FFECEE;
            border-radius: 4px;
            color: #000;
            top: -150px;
            transition: all .3s ease-in-out;
            box-sizing: border-box;
            max-width: 400px;
        }
        #error_space:hover {
            transform: scale(1.05);
        }
        .top_msg {
            font-size: 14px;
            color: #000;
            line-height: 24px;
            float: left;
            margin-left: 10px;
            font-weight: 500;
            text-align: center;
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
            flex-shrink: 0;
        }
        .show_error {
            top: 70px !important;
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
        #footer a {
            color: #727272;
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
            height: 5px;
            width: 0px;
            animation: 0.6s ease-in-out 0s 1 forwards running tick;
            margin-right: 0px;
            margin-left: 10px;
            left: -10px;
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
        .succfail-btns {
            display: flex;
            max-width: 500px;
            justify-content: space-between;
            margin: 28px 0px;
            align-items: center;
            gap: 30px;
        }
        .link-btn {
            margin: 20px 0 0 20px;
            font-size: 12px;
            color: #0093ff;
            letter-spacing: 0.2px;
            font-weight: 600;
            font-family: "ZohoPuvi";
            background: none;
            border: none;
            cursor: pointer;
            padding: 0px;
        }
        .warning_icon {
            background: #EDB211;
        }
        #error_space.warning_space {
            border: 1px solid #EBE0BE;
            background-color: #FFF9E7;
            cursor: pointer;
        }
        .form_container .errorborder {
            border: 2px solid #ff8484 !important;
        }
        @keyframes anim_r {
            0% {
                right: 0px;
            }
            100% {
                right: -20px;
            }
        }
        form[name="confirm_form"] label{
        	position: absolute;
        	left: 0;
        	cursor: pointer;
        }
        form[name="confirm_form"] label:hover:before {
    		border-color: #1389E3;
        }
        form[name="confirm_form"] label:before {
    		content: "";
    		width: 16px;
    		display: inline-block;
    		height: 16px;
    		border: 2px solid #C7C7C7;
    		border-radius: 3px;
    		box-sizing: border-box;
    		background: #fff;
    		position: absolute;
    		left: 0px;
    		top: 2px;
    		transition: 0.2s all ease-out;
		}
		form[name="confirm_form"] label:after {
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
		form[name="confirm_form"] input:checked ~ label:before {
    		background-color: #1389E3;
    		border-color: #1389E3;
        }
		a {
    		text-decoration: none;
    		color: #159AFF;
		}
		body.result_pop {
    		height: auto;
   			width: 100%;
    		background-color: rgb(252 252 252);
    		margin: 0px;
		}
		.result{
			position: absolute;
			width: 100%;
			height: 100%;
			z-index: -1;
			opacity: 0;
			transition: opacity 0.3s ease-in-out;
			background-color: #ffffff;
			padding: 0 10px;
			box-sizing: border-box;
			transition-delay: 0.3s;
		}
		.result_popup {
    		margin: auto;
    		height: auto;
    		background: #fff;
    		box-sizing: border-box;
    		padding: 30px;
    		border: 1px solid #E5E5E5;
    		overflow: hidden;
    		border-radius: 16px;
   			margin-top: 60px;
    		position: relative;
    		max-width: 580px;
		}
		.result .rebrand_partner_logo {
        	height: 40px;
        	background: url("../images/newZoho_logo.svg") no-repeat;
        	background-size: auto 40px;
        	width: 94px;
        	margin: auto;
        	margin-top: 100px;
        	margin-bottom: 20px;
      	}
      	.pop_bg {
    		width: auto;
    		height: 50%;
    		position: absolute;
    		left: 0px;
    		right: 0px;
    		top: 0px;
    		background: transparent linear-gradient(180deg, #00F22214 0%, #FFFFFF14 100%) 0% 0% no-repeat padding-box;
		}
		.pop_bg.error{
			background: transparent linear-gradient(180deg, #FEEBEB 0%, #FFFFFF14 100%) 0% 0% no-repeat padding-box;	
		}
      	.result_popup .pop_icon {
    		width: 40px;
    		height: 40px;
    		border-radius: 50%;
    		overflow: hidden;
    		font-size: 44px;
    		position: relative;
    		color: #939393;
    		margin: 30px auto 16px;
    		font-weight: 600;
    		background: #4BBF5D;
    		box-shadow: inset -3px -3px 0px #00000014;
		}
      	#result_popup_error .pop_icon.error {
    		background: #E92B2B;
		}
		.result_popup .pop_icon:after{
			display: inline-block;
    		content: "";
    		width: 16px;
  			height: 7px;
    		border-bottom: 3px solid #fff;
  			border-left: 3px solid #fff;
  			transform: rotate(-45deg);
  			position: absolute;
  			top:13px;
  			left: 10px;
		}
		.result_popup .pop_icon.error:before,
		.result_popup .pop_icon.error:after {
    		display: block;
    		content: "";
    		height: 14px;
    		width: 3px;
    		background-color: #fff;
    		margin: auto;
    		border-radius: 2px;
    		transform: rotate(-45deg);
    		position: absolute;
    		top: 13px;
    		right: 0px;
    		left: 0px;
    		z-index: 1;
		}
		.result_popup .pop_icon.error:after {
    		transform: rotate(45deg);
    		border: 0;
		}
		.result_popup .grn_text {
    		text-align: center;
    		color: #000000;
    		font-weight: 500;
    		font-size: 18px;
    		font-weight: 600;
		}
		.result_popup .defin_text {
    		text-align: center;
    		margin: 10px 0px;
    		font-size: 14px;
    		line-height: 20px;
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
            .countNameAddDiv,
            .phone_code_label+select {
                position: absolute;
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
            button {
                width: 100%;
            }
            [class*="_input_container"],
            [id*="_input"] {
                width: 100% !important;
            }
            .countNameAddDiv,
            .phone_code_label+select {
                position: absolute;
                height: 44px;
            }
            .remind_me_later {
                display: block;
                width: max-content;
                margin: auto;
            }
            .succfail-btns {
                flex-direction: column;
            }
        }
    </style>

    <script>
        var resendTimer, resendtiming, altered;
		var errormap = ${errors};
		var supportMail = "${supportEmail}";
		var email = <#if email?has_content>"${email}"<#else>""</#if>;
		var digest, encEmail;
        I18N.load({
            "IAM.GENERAL.ERROR.INVALID.OTP": '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
            "IAM.ERROR.ENTER.VALID.OTP": '<@i18n key="IAM.ERROR.ENTER.VALID.OTP" />',
            "IAM.GENERAL.OTP.SENDING": '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
            "IAM.GENERAL.OTP.SUCCESS": '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
            "IAM.VERIFIED": '<@i18n key="IAM.VERIFIED"/>',
            "IAM.TFA.RESEND.OTP.COUNTDOWN": '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
            "IAM.ERROR.EMPTY.FIELD": '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
            "IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL"/>',
            "IAM.PLEASE.CONNECT.INTERNET": '<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>',
            "IAM.ERROR.SESSION.EXPIRED": '<@i18n key="IAM.ERROR.SESSION.EXPIRED"/>',
            "IAM.ERROR.TERMS.POLICY": '<@i18n key="IAM.ERROR.TERMS.POLICY"/>',
            "IAM.OAUTH.GENERAL.ERROR": '<@i18n key="IAM.OAUTH.GENERAL.ERROR"/>',
            "IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.EXPIRED.HEADER": '<@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.EXPIRED.HEADER"/>',
            "IAM.URL.EXPIRED.DESC": '<@i18n key="IAM.URL.EXPIRED.DESC"/>',
            "IAM.FURTHER.ASSISTANCE": '<@i18n key="IAM.FURTHER.ASSISTANCE"/>',
            "IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER": '<@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER"/>',
            "IAM.URL.INVALID.DESC": '<@i18n key="IAM.URL.INVALID.DESC"/>',
            "IAM.EMAIL.ALREADY.CONF": '<@i18n key="IAM.EMAIL.ALREADY.CONF"/>',
            "IAM.EMAIL.ALREADY.CONF.DESC": '<@i18n key="IAM.EMAIL.ALREADY.CONF.DESC"/>',
            "IAM.UNABLE.REMOVE.EMAIL": '<@i18n key="IAM.UNABLE.REMOVE.EMAIL"/>',
            "IAM.UNABLE.REMOVE.EMAIL.DESC": '<@i18n key="IAM.UNABLE.REMOVE.EMAIL.DESC"/>',
            "IAM.UNABLE.REMOVE.EMAIL.DESC2": '<@i18n key="IAM.UNABLE.REMOVE.EMAIL.DESC2"/>',
            "IAM.UNABLE.REMOVE.EMAIL.DESC3": '<@i18n key="IAM.UNABLE.REMOVE.EMAIL.DESC3"/>',
            "IAM.ERROR.CODE.U104": '<@i18n key="IAM.ERROR.CODE.U104"/>',
            "IAM.EMIAL.NO.EXISTS.DESC": '<@i18n key="IAM.EMIAL.NO.EXISTS.DESC"/>',
            "IAM.ACCOUNT.NOT.EXIST": '<@i18n key="IAM.ACCOUNT.NOT.EXIST"/>',
            "IAM.ACCOUNT.NOT.EXIST.DESC": '<@i18n key="IAM.ACCOUNT.NOT.EXIST.DESC"/>',
            "IAM.UNABLE.DELETE.ACC": '<@i18n key="IAM.UNABLE.DELETE.ACC"/>',
            "IAM.UNABLE.DELETE.ACC.DESC": '<@i18n key="IAM.UNABLE.DELETE.ACC.DESC"/>',
            "IAM.EMAIL.REMOVED.DESC": '<@i18n key="IAM.EMAIL.REMOVED.DESC"/>',
            "IAM.EMAIL.REMOVED": '<@i18n key="IAM.EMAIL.REMOVED"/>',
            "IAM.ACCOUNT.DELETED": '<@i18n key="IAM.ACCOUNT.DELETED"/>',
            "IAM.ACCOUNT.DELETED.DESC": '<@i18n key="IAM.ACCOUNT.DELETED.DESC"/>',
        });

        var EmailDetach = ZResource.extendClass({
            resourceName: "EmailDetachAction",//No I18N
            identifier: "digest",	//No I18N 
            attrs: ["tos", "code"], // No i18N
        });
        function handleOtpSent(resp) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    clearError('#otp_split_input');
                    $(".enter_eml_mob_desc, [name=confirm_form] .succfail-btns, .check_container").slideUp(200);
                    $(".send_otp_btn").removeAttr("disabled");
                    $(".send_otp_btn span").removeClass("loader");
                    $(".otp_input_container, [name=confirm_form1] .succfail-btns, .otp_sent_desc").slideDown(200);
                    encEmail = resp.emaildetachaction.encryptedEmail;
                    setTimeout(function () {
                        $(".resend_otp").html("<div class='tick'></div>" + I18N.get('IAM.GENERAL.OTP.SUCCESS'));
                        setTimeout(function () {
                            resendOtpChecking();
                        }, 1000);
                        $(".otp_split_input_otp")[0].focus();
                    }, 250);
                } else {
                    $(".send_otp_btn").removeAttr("disabled");
                    $(".send_otp_btn span").removeClass("loader");
                    if ($("#otp_split_input").is(":visible")) {
                        classifyError(resp, "#otp_split_input");
                    } else {
                        classifyError(resp);
                    }
                }
            }
        }
        function resendOTP() {
            $(".resend_otp").html("<div class='loader'></div>" + I18N.get('IAM.GENERAL.OTP.SENDING'));
            var params = {tos: true};
            var payload = EmailDetach.create(params);
            payload.PUT(encEmail).then(function (resp) {
				handleOtpResent(resp)
            }, function (resp) {
				handleOtpResent(resp)
            });
        }
        function handleOtpResent(resp) {
            if (resp.status_code >= 200 && resp.status_code <= 299) {
				setTimeout(function () {
					$(".resend_otp").html("<div class='tick'></div>" + I18N.get('IAM.GENERAL.OTP.SUCCESS'));
					setTimeout(function () {
                        resendOtpChecking();
                    }, 1000);
                }, 800);
            } else {
                $(".resend_otp").html("<@i18n key="IAM.TFA.RESEND.OTP"/>");
                $(".resend_otp").removeClass("nonclickelem");
                classifyError(resp);
            }
        }
        function verifyCode(e) {
            e.preventDefault();
            var Code = document.querySelector("#otp_split_input_full_value").value;
            if (Code == "") {
                show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
                return false;
            }
            if (!isValidCode(Code)) {
                show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.ENTER.VALID.OTP"));//No I18N
                return false;
            }
            if ($(".error_msg").length < 1) {
                //clearError('#otp_split_input');
                $(".verify_btn span").html("<div class='loader white'></div>");
                $(".verify_btn").prop("disabled", true);
                var params = { tos: true, code: Code };
                var payload = EmailDetach.create(params);
                payload.PUT(encEmail).then(function (resp) {
                    handleVerifyCode(resp)
                }, function (resp) {
                    handleVerifyCode(resp)
                });
            }
        }
        function handleVerifyCode(resp) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    $(".resend_otp").css("visibility", "hidden");
                    setTimeout(function () {
                        $(".verify_btn").prop("disabled", false);
                        $(".verify_btn").html("<div class='tick verified_tick white'></div>" + I18N.get('IAM.VERIFIED'));
                        $(".result .cont_btn").attr("onclick", "window.location.replace('"+ resp.redirectUrl +"')")
                        <#if action?? && action == 0>
                        $(".result .grn_text").text(I18N.get("IAM.EMAIL.REMOVED"));
                        $(".result .defin_text").html(Util.format(I18N.get("IAM.EMAIL.REMOVED.DESC"), email));
                        <#elseif action?? && action == 1>
                        $(".result .grn_text").text(I18N.get("IAM.ACCOUNT.DELETED"));
                        $(".result .defin_text").html(Util.format(I18N.get("IAM.ACCOUNT.DELETED.DESC"), email));
                        </#if>
                        $(".result .cont_btn").show();
                        $(".result").css({"z-index": "4","opacity": "1"})
                    }, 1000);
                    
                } else {
                    $(".verify_btn span").html("");
                    $(".verify_btn").prop("disabled", false);
                    classifyError(resp, "#otp_split_input");
                }
            }
        }
        function updateEmlMblValue(e) {
			var tos = document.querySelector("#check_input").checked;
			if(!tos){
				show_error_msg(".check_container", I18N.get("IAM.ERROR.TERMS.POLICY"), true);
				return;
			}
			e.target.setAttribute("disabled", '');
            e.target.querySelector("span").classList.add("loader");
            var params = {tos: true};
            var payload = EmailDetach.create(params);
			payload.POST(digest).then(function (resp) {
            	handleOtpSent(resp);
            }, function (resp) {
                handleOtpSent(resp);
            });
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
                if (!altered) {
                    $(".send_otp_btn span").css("margin-left", "5px");
                    $(".send_otp_btn span").html(resendtiming + "s");
                }
                if (resendtiming === 0) {
                    clearInterval(resendTimer);
                    $(".resend_otp").html("<@i18n key="IAM.TFA.RESEND.OTP"/>");
                    $(".send_otp_btn span").html("");
                    $(".resend_otp").removeClass("nonclickelem");
                    $(".send_otp_btn").removeAttr("disabled");
                }
            }, 1000);
        }
        function isValidCode(code) {
            if (code.trim().length != 0) {
                var codePattern = new RegExp("^([0-9]{${otp_length}})$");
                if (codePattern.test(code)) {
                    return true;
                }
            }
            return false;
        }
        function classifyError(resp, siblingClassorID) {
        	if(resp && (resp.code && classifyPageError(resp.code)) || (resp.errors && classifyPageError(resp.errors[0].code))){
        		return;
        	} else if ('status_code' in resp && resp.status_code === 0) {
                showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
            } else if (resp.code === "Z113") {
                showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
            }  else if (resp.localized_message && siblingClassorID) {
                show_error_msg(siblingClassorID, resp.localized_message)
            } else if (resp.localized_message) {
                showErrMsg(resp.localized_message)
            } else {
                showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
            }
        }
        function show_error_msg(siblingClassorID, msg, tos) {
            $(".error_msg").remove();
            var errordiv = document.createElement("div");
            errordiv.classList.add("error_msg");
            $(errordiv).html(msg);
            $(errordiv).insertAfter(siblingClassorID);
            if(!tos){
            	$(siblingClassorID).addClass("errorborder");
            }
            $(".error_msg").slideDown(150);
        }
        function showErrMsg(msg, isRelogin) {
            document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
            document.getElementById("error_space").classList.remove("warning_space") //No I18N
            document.querySelector("#error_space .close_btn").style.display = "none";
            if (isRelogin) {
                document.getElementsByClassName("error_icon")[0].classList.add("warning_icon");//No I18N
                document.getElementById("error_space").classList.add("warning_space") //No I18N
                document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
                document.getElementById("error_space").setAttribute("resp", isRelogin.redirect_url)
                document.getElementById("error_space").addEventListener("click", reloginRedirect)
                document.querySelector("#error_space .close_btn").style.display = "inline-block";
            } else {
                document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
            }
            document.getElementsByClassName('top_msg')[0].innerHTML = msg;
            document.getElementById("error_space").classList.add("show_error");
            if (!isRelogin) setTimeout(function () {
                document.getElementById("error_space").classList.remove("show_error");
            }, 5000);
        }
        function clearError(ClassorID, e) {
            if (e && e.keyCode == 13 && $(".error_msg:visible").length) {
                return;
            }
            $(ClassorID).removeClass("errorborder")
            $(".errorborder").removeClass("errorborder");
            $(".error_msg").remove();
        }
        function classifyPageError(errorCode){
        	pe = false;
			var futherSupport = Util.format(I18N.get("IAM.FURTHER.ASSISTANCE"), supportMail);
			switch( errorCode ){
				case 'IN123':
					$(".result .grn_text").html(I18N.get("IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.EXPIRED.HEADER"));
					$(".result .defin_text").html(I18N.get("IAM.URL.EXPIRED.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'IN101':
					$(".result .grn_text").html(I18N.get("IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER"));
					$(".result .defin_text").html(I18N.get("IAM.URL.INVALID.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'AC500': 
				case 'IN122':
					$(".result .grn_text").html(I18N.get("IAM.EMAIL.ALREADY.CONF"));
					$(".result .defin_text").html(I18N.get("IAM.EMAIL.ALREADY.CONF.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'CA201':
					$(".result .grn_text").html(I18N.get("IAM.UNABLE.DELETE.ACC"));
					$(".result .defin_text").html(I18N.get("IAM.UNABLE.DELETE.ACC.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'U101':
					$(".result .grn_text").html(I18N.get("IAM.ACCOUNT.NOT.EXIST"));
					$(".result .defin_text").html(I18N.get("IAM.ACCOUNT.NOT.EXIST.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'EMAIL102':
					$(".result .grn_text").html(I18N.get("IAM.ERROR.CODE.U104"));
					$(".result .defin_text").html(I18N.get("IAM.EMIAL.NO.EXISTS.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'ACS101':
					$(".result .grn_text").html(I18N.get("IAM.UNABLE.REMOVE.EMAIL"));
					$(".result .defin_text").html(I18N.get("IAM.UNABLE.REMOVE.EMAIL.DESC") +" "+ futherSupport);
					pe = true
					break;
				case 'EMAIL503':
					$(".result .grn_text").html(I18N.get("IAM.UNABLE.REMOVE.EMAIL"));
					$(".result .defin_text").html(Util.format(I18N.get("IAM.UNABLE.REMOVE.EMAIL.DESC2"), email) +" "+ futherSupport);
					pe = true
					break;
				case 'EMAIL504':
					$(".result .grn_text").html(I18N.get("IAM.UNABLE.REMOVE.EMAIL"));
					$(".result .defin_text").html(I18N.get("IAM.UNABLE.REMOVE.EMAIL.DESC3") +" "+ futherSupport);
					pe = true
					break;
			}
			if(pe){
				$(".flex-container").css("display","none");
				$(".result .pop_bg").addClass("error");
				$(".result .pop_icon").addClass("error");
				$(".result .cont_btn").css("display","none");
				$(".result").css({"display": "block", "opacity": "1"})
			}
			return pe;				
        }
    </script>
</head>

<body>
    <#include "../zoho_line_loader.tpl">
    <div id="error_space">
        <span class="error_icon">&#33;</span>
        <span class="top_msg"></span>
        <span class="close_btn" style="display: none"></span>
	</div>
	<div class="result">
		<div class="rebrand_partner_logo"></div>
		<div class="result_popup" id="result_popup_error">
			<div class="pop_bg">
			</div>
			<div class="pop_icon"><span class="inner_circle"></span></div>
			<div class="content_space">
				<div class="grn_text" id="result_content"></div>
				<div class="defin_text"></div>
				<button class="cont_btn" style="display: none" onclick="window.location.replace('')"><span></span><@i18n key="IAM.GROUPINVITATION.GO.TO"/></button>
			</div>
		</div>
	</div>
        <div class="flex-container container" style="visibility: hidden; opacity: 0">
            <div class="content_container">
                <div class="rebrand_partner_logo"></div>
                <div class="announcement_header">
                	<@i18n key="IAM.EMAIL.CLAIM.HEAD"/>
                   <#-- <#if action?? && action == 0>
                    	<@i18n key="IAM.REMOVE.EMAIL"/>
                    <#elseif action??>
                    	<@i18n key="IAM.DELETE.ACCOUNT"/>
                    </#if> -->
                </div>
                <div class="account_verify_desc">
					<@i18n key="IAM.EMAIL.CLAIM.DESC" arg0="${email}"/>
                </div>
                <div class="otp_sent_desc" style="display: none">
                    <span class="email_sent">
                        <@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL" />
                    </span>
                  <#--  <span class="emailormobile">
                        <div class="valueemailormobile">
                        	<span><#if email?has_content>${email}<#else>""</#if></span>
                        </div>
                    </span> -->
                    <span class="email_sent">
                    <#if action?? && action == 0>
                    	<@i18n key="IAM.EMAIL.CLAIM.REMOVE.SENT"/>
                    <#elseif action??>
                    	<@i18n key="IAM.EMAIL.CLAIM.DELETE.SENT"/>
                    </#if>
                    </span>
                </div>
                <div class="enter_eml_mob_desc">
                    <#if action?? && action == 0>
                        	<@i18n key="IAM.EMAIL.CLAIM.REMOVE"/>
                        <#else>
                            <@i18n key="IAM.EMAIL.CLAIM.DELETE"/>
                    </#if>
                </div>
                <div class="form_container">
                    <form name="confirm_form" onsubmit="return false">
                        <div class="check_container">
                        	<div>
                        		<input type="checkbox" id="check_input" autocomplete="email"
                                 		onchange="clearError('.check_container')" />
             					<label for="check_input" class="checklabel">
                    			</label>
                           		<@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" />
                           </div>
                        </div>
                        <div class="succfail-btns">
                            <button class="send_otp_btn" onclick="updateEmlMblValue(event)">
                                <@i18n key="IAM.SEND.OTP"/><span></span>
                            </button>
                        </div>
                    </form>
                    <form name="confirm_form1" onsubmit="verifyCode(event);return false;" novalidate>
                        <div class="otp_input_container" style="display: none">
                            <label for="otp_split_input_full_value" class="emolabel">
                                <@i18n key="IAM.VERIFICATION.CODE" />
                            </label>
                            <div id="otp_split_input" class="otp_container"></div>
                            <div class="resend_otp" onclick="resendOTP()"><span></span>
                                <@i18n key="IAM.TFA.RESEND.OTP" />
                            </div>
                        </div>
                        <div class="succfail-btns" style="display: none">
                            <button class="verify_btn" type="submit" onclick="verifyCode(event)"><span></span>
                                <@i18n key="IAM.VERIFY" />
                            </button>
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
		URI.options.contextpath = "${za.contextpath}/webclient/v1";//No I18N
        URI.options.csrfParam = "${za.csrf_paramName}";
        URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
        if(errormap && errormap.error_code){
        	classifyPageError(errormap.error_code);
		}else{
			$(".flex-container").css({"opacity":"1", "visibility":"visible"})
			<#if digest??> digest = "${digest}" </#if>
			splitField.createElement("otp_split_input", {
				splitCount: ${otp_length},
				charCountPerSplit: 1,
				isNumeric: true,
				otpAutocomplete: true,
				customClass: "customOtp",
				inputPlaceholder: "&#9679;",
				placeholder: "<@i18n key="IAM.ENTER.CODE"/>",
			});
			$("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input', event)");
		}
        setFooterPosition();
    };
</script>
</html>