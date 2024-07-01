<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <@i18n key="IAM.VERIFY.ACC.DETAILS" /> | <@i18n key="IAM.ZOHO.ACCOUNTS" />
    </title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/tp_pkg/xregexp-all.js" />
    <@resource path="/v2/components/js/zresource.js" />
    <@resource path="/v2/components/js/uri.js" attributes="async" />
    <@resource path="/v2/components/js/splitField.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <@resource path="/v2/components/css/${customized_lang_font}" />
    <@resource path="/v2/components/js/security.js" />
    <script type="text/javascript" src="${za.contextpath}/encryption/script"></script>
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

        [class^="icon2-"],
        [class*=" icon2-"] {
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

        .icon2-Mail:before {
            content: "\e908";
        }

        .icon2-delete:before {
            content: "\e914";
        }

        .icon2-warning:before {
            content: "\e962";
        }

        .icon2-reload:before {
            content: "\e961";
        }

        .icon2-Verify:before {
            content: "\e964";
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
        }
        [class*="_desc"] {
            font-size: 16px;
            line-height: 24px;
            margin-bottom: 20px;
            cursor: default;
        }
        .review_desc {
        	font-size: 12px;
        	line-height: 20px;
        	margin-top: 20px;
        	max-width: 460px;
        }
        .review_desc a {
        	font-size: 12px;
        	font-weight: 500;
        }
        .otp_sent_desc,
        .enter_eml_mob_desc {
            margin-bottom: 30px;
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
            margin: 12px 0 20px 0;
            cursor: pointer;
            font-weight: 500;
            color: #0093ff;
            width: max-content;
        }
        [id*="_input"], #captcha {
            height: 44px;
            padding: 12px 15px;
            line-height: 30px;
            width: 300px;
            border: 1px solid #0f090933;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            font-family: "ZohoPuvi";
            transition: 0.2s all ease-in-out;
        }
        [id*="_input"]:focus-visible, #captcha:focus-visible {
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
            margin-left: 10px;
            font-size: 10px;
        }
        .captcha-wrapper {
		    position: relative;
		}
		.captcha-wrapper .succfail-btns {
		    position: absolute;
		    margin: 12px 0px;
		    right: 0;
		    bottom: 0;
		}
		form.captchaForm .primary_btn_check {
		    max-width: fit-content;
		}
        .succfail-btns, .primary_btn_check {
            display: flex;
            max-width: 500px;
            justify-content: space-between;
            margin: 30px 0px;
            align-items: center;
            gap: 30px;
        }
        [name=confirm_form] .succfail-btns {
            justify-content: unset;
            gap: unset;
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
            padding-top: 100px;
            padding-right: 10%;
        }
        .unverContainer {
            border: 1px solid #d8d8d8;
            border-radius: 10px;
            max-width: 460px;
        }
        .unverHeader {
            font-size: 14px;
            font-weight: 600;
            border-bottom: 1px solid #d8d8d8;
            padding: 20px 20px;
        }
        .email-icon,
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
            flex-shrink: 0;
            pointer-events: none;
            margin-right: 10px;
        }
        .email-icon::before,
        .mobile-icon::before {
            font-size: 16px;
            margin: auto;
            height: max-content;
            align-self: center;
        }
        .email-icon::after,
        .mobile-icon::after {
            position: absolute;
            left: 0;
            opacity: 0.1;
        }
        .icon-wrap {
            display: flex;
            align-items: center;
            margin-left: auto;
        }
        .icon2-Verify {
            margin-right: 5px;
            pointer-events: none;
        }
        .delete-icon {
            width: 32px;
            height: 32px;
            border-radius: 22px;
            cursor: pointer;
            opacity: 0.6;
            position: relative;
            transition: 0.2s all ease-in-out;
        }
        .delete-icon:hover {
            opacity: 1;
            background-color: #eee;
        }
        .delete-icon:hover::before {
            opacity: 1;
        }
        .delete-icon::before {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translateX(-50%) translateY(-50%);
        }
        .delete-desc {
            font-size: 14px;
            line-height: 20px;
        }
        .delete-desc b{
			font-weight: 500;
			word-break: break-word;
        }
        .delete-popup {
            position: fixed;
            z-index: 10;
            top: 0px;
            left: 0;
            right: 0;
            margin: auto;
            border-radius: 0px 0px 10px 10px;
            min-height: 0px;
            width: 600px;
            transition: transform .2s ease-in-out;
            transform: translateY(-50px);
        }

        .delete-popup:focus-visible,
        .msg-popups:focus-visible {
            outline: none;
        }

        .delete-popup .popup-header {
            border-radius: 0px;
        }
        .pop_anim {
            transform: translateY(0px) !important;
        }
        .popup-heading {
            font-size: 18px;
            font-weight: 500;
        }
        .popup-body {
            padding: 30px 30px 40px 30px;
            background-color: #ffffff;
            border-radius: 0 0 10px 10px;
        }
        .delete-popup .popup-header {
            border-radius: 0px;
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
        .popup-header {
            background-color: #fbfbfb;
            border-radius: 10px 10px 0 0;
            display: flex;
            padding: 20px 60px 20px 30px;
            align-items: center;
        }
        .emailnumb-details {
            line-height: 20px;
            cursor: default;
            max-width: 260px;
            word-break: break-all;
        }
        .emailnumb-cont {
            display: flex;
            padding: 15px 20px;
            align-items: center;
            transition: 0.2s all ease-in-out;
            font-size: 14px;
            font-weight: 500;
        }
        .emailnumb-cont:last-child {
            margin-bottom: 20px;
        }
        .verify-tick {
            opacity: 0.6;
            display: flex;
            align-items: center;
            padding: 8px 16px 8px 12px;
            border-radius: 22px;
            transition: 0.2s all ease-in-out;
        }
        .verify-tick:hover, .ver-load {
            opacity: 1;
            cursor: pointer;
            background-color: #eee;
        }
        .verify-tick.ver-load {
            pointer-events: none;
        }
        .verify-tick.verified {
            color: #15AA65;
            pointer-events: none;
        }
        .verify-tick span{
			pointer-events: none;
        }
        .link-btn {
            font-family: "ZohoPuvi";
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
        .back_btn,
        .cancel_btn {
            background: #f0f0f0;
            color: #4E4E4E;
            margin-left: 20px;
        }
        .back_btn:hover,
        .cancel_btn:hover {
            background-color: #EBEAEA;
        }
        .cancel_btn {
            margin-top: 30px;
        }
        .delete_btn {
            margin-top: 30px;
            background-color: #DF5B5B;
        }
        .delete_btn:hover {
            background-color: #D34A4A;
        }
        .emailnumb-cont:hover {
            background-color: #f8f8f8;
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
            font-weight: 300;
            font-weight: lighter;
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
        .already_added,
        .add_new_number {
            color: #0093ff;
            font-weight: 500;
            font-size: 14px;
            margin-top: 12px;
            margin-bottom: 20px;
            cursor: pointer;
            width: max-content;
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
        .remind_me_later {
            color: #8b8b8b;
            height: 18px;
            border-bottom: 1px dashed #acacac;
            text-decoration: none;
            outline: none;
            line-height: 16px;
            font-size: 14px;
            left: 0px;
            background-color: white;
            position: relative;
            transition: left .4s ease-in;
            height: 18px;
            margin-top: 0px;
        }
        .remind_me_later div {
            display: inline-block;
            font-weight: 500;
        }
        .remind_loader {
            left: -20px;
            pointer-events: none;
        }
        .remind_loader::after {
            content: "";
            display: inline-block;
            position: absolute;
            top: 4px;
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
        .remind_me_later:hover {
            color: #666666;
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
            top: -130px;
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
        .show_error {
            top: 60px !important;
        }
        .warning_icon {
            background: #EDB211;
        }
        #error_space.success_space {
            border: 1px solid #CAEDE3;
            background-color: #E7FCF6;
        }
        #error_space.warning_space {
            border: 1px solid #EBE0BE;
            background-color: #FFF9E7;
            cursor: pointer;
        }
        .verified-selected {
            position: relative;
            border: 1px solid #56D64B;
            background-color: #56D64B;
        }
        .verified-selected::before {
            content: "";
            display: inline-block;
            border-right: 2px solid white;
            border-bottom: 2px solid white;
            width: 3px;
            height: 6px;
            position: absolute;
            top: 2px;
            left: 4px;
            transform: rotate(45deg);
        }
        .error_icon.verified-selected::before {
            width: 5px;
            height: 10px;
            top: 3px;
            left: 7px;
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
        @keyframes anim_r {
            0% {
                right: 0px;
            }

            100% {
                right: -20px;
            }
        }
        .icon2-Verify.loader{
			top: 0px;
			margin-right: 5px;
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
        .sm svg {
            transform: scale(0.7);
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
            button,
            delete-popup,
            .otp_input_container {
                width: 100%;
            }
            .emailnumb-cont {
                gap: 5px;
            }
            .countNameAddDiv,
            .phone_code_label+select {
                position: absolute;
            }
            .remind_me_later {
                display: block;
                width: max-content;
                margin: auto;
            }
            .succfail-btns {
                flex-direction: column;
            }
            .back_btn,
            .cancel_btn {
                margin-left: 0;
                margin-top: 30px;
            }
        }
    </style>
    <script>
        var csrfParam = "${za.csrf_paramName}";
        var csrfCookieName = "${za.csrf_cookieName}";
        var contextpath = <#if context_path??> "${context_path}" <#else > "" </#if>;
        var resendTimer, resendtiming, altered, mode;
        var emailormobilevalue;
        var isEdit = false;
        var mResendCount = 3;
        I18N.load({
            "IAM.GENERAL.OTP.SENDING": '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
            "IAM.GENERAL.OTP.SUCCESS": '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
            "IAM.GENERAL.ERROR.INVALID.OTP": '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
            "IAM.ERROR.VALID.OTP": '<@i18n key="IAM.ERROR.VALID.OTP" />',
            "IAM.ERROR.EMAIL.INVALID": '<@i18n key="IAM.ERROR.EMAIL.INVALID"/>',
            "IAM.PHONE.ENTER.VALID.MOBILE_NUMBER": '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
            "IAM.GENERAL.OTP.SENDING": '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
            "IAM.GENERAL.OTP.SUCCESS": '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
            "IAM.VERIFIED": '<@i18n key="IAM.VERIFIED"/>',
            "IAM.TFA.RESEND.OTP.COUNTDOWN": '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
            "IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL"/>',
            "IAM.ERROR.EMPTY.FIELD": '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
            "IAM.ERROR.RELOGIN.UPDATE": '<@i18n key="IAM.ERROR.RELOGIN.UPDATE"/>',
            "IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL"/>',
            "IAM.PLEASE.CONNECT.INTERNET": '<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>',
            "IAM.ERROR.SESSION.EXPIRED": '<@i18n key="IAM.ERROR.SESSION.EXPIRED"/>',
            "IAM.MOBILE.ERROR.SURE.DELETE.PHONE": '<@i18n key="IAM.MOBILE.ERROR.SURE.DELETE.PHONE"/>',
            "IAM.DELETE.YOUR.EMAIL": '<@i18n key="IAM.DELETE.YOUR.EMAIL"/>',
            "IAM.CONFIRM.POPUP.PHONENUMBER": '<@i18n key="IAM.CONFIRM.POPUP.PHONENUMBER"/>',
            "IAM.CONFIRM.POPUP.EMAIL": '<@i18n key="IAM.CONFIRM.POPUP.EMAIL"/>',
            "IAM.N.UNVERIFIED.EMAILS.NUMBERS": '<@i18n key="IAM.N.UNVERIFIED.EMAILS.NUMBERS"/>',
            "IAM.N.UNVERIFIED.EMAIL.ADD": '<@i18n key="IAM.N.UNVERIFIED.EMAIL.ADD"/>',
            "IAM.N.UNVERIFIED.EMAIL.ADDS": '<@i18n key="IAM.N.UNVERIFIED.EMAIL.ADDS"/>',
            "IAM.N.UNVERIFIED.MOBILE.NUMBER": '<@i18n key="IAM.N.UNVERIFIED.MOBILE.NUMBER"/>',
            "IAM.N.UNVERIFIED.MOBILE.NUMBERS": '<@i18n key="IAM.N.UNVERIFIED.MOBILE.NUMBERS"/>',
            "IAM.PLEASE.VERIFY.IT": '<@i18n key="IAM.PLEASE.VERIFY.IT"/>',
            "IAM.PLEASE.VERIFY.THEM": '<@i18n key="IAM.PLEASE.VERIFY.THEM"/>',
            "IAM.REDIRECTING.SERVICE": '<@i18n key="IAM.REDIRECTING.SERVICE"/>',
            "IAM.REDIRECTING.NO.UNVERIFIED.DESC": '<@i18n key="IAM.REDIRECTING.NO.UNVERIFIED.DESC"/>',
            "IAM.REDIRECTING": '<@i18n key="IAM.REDIRECTING"/>',
            "IAM.DIGIT.VER.CODE.SENT.EMAIL": '<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>',
            "IAM.DIGIT.VER.CODE.SENT.MOBILE": '<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>',
        });
        var cryptData;
        var unverifiedCount = ${unverifieds?size};
        <#if visited_url??>var next = "${visited_url}";</#if>
        <#if skip_url??>var skipnow = '${Encoder.encodeJavaScript(skip_url)}'</#if>
		var Account = ZResource.extendClass({
                resourceName: "Account",
                identifier: "zaid"
            });
        var User = ZResource.extendClass({
            resourceName: "User",
            identifier: "zuid",
            parent: Account
        });
        var Email = ZResource.extendClass({
            resourceName: "Email",
            identifier: "emailID",
            attrs: ["email_id", "code"],
            parent: User
        });
        var Phone = ZResource.extendClass({
            resourceName: "Phone",
            identifier: "phonenum",
            attrs: ["countrycode", "mobile", "code", "cdigest", "captcha"],
            parent: User
        });
        function handleEditOption(mode) {
            clearError("#" + mode + "_input");
            $(".otp_input_container, .otp_sent_desc").slideUp(200);
            document.querySelector(".enter_eml_mob_desc").style.display = "block";
            document.querySelector(".send_otp_btn").style.display = "inline-block";
            altered = false
            if (!resendtiming == 0) {
                $(".send_otp_btn").prop("disabled", true);
            }
            $(document.confirm_form1).slideDown(200);
            if ($(".unverContainer").length > 0) {
                $(".back_btn").show();
            }
            document.querySelector("." + mode + "_input_container").style.display = "block";
            document.querySelector("#" + mode + "_input").focus();
            if (mode === "email") {
                document.querySelector("#" + mode + "_input").value = emailormobilevalue;
            } else {
                if (countryCode) {
                    reqCountry = "#" + countryCode.toUpperCase();
                    $('#countNameAddDiv option:selected').removeAttr('selected');
                    $("#countNameAddDiv " + reqCountry).prop('selected', true);
                    $("#countNameAddDiv " + reqCountry).trigger('change');
                }
                document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobile.toString());
            }
        }
        function sendOTP(mode, emailormobilevalue) {
            $(".resend_otp").html("<div class='loader'></div>" + I18N.get('IAM.GENERAL.OTP.SENDING'));
            if (mode === "email") {
                if (isEmailId(emailormobilevalue)) {
                    $("div.valueemailormobile span")[0].textContent = emailormobilevalue;
                    encryptData.encrypt([emailormobilevalue]).then(function(encryptedloginid) {
						encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
						var params = { email_id: encryptedloginid };
	                    var payload = Email.create(params);
	                    payload.POST("self", "self").then(function (resp) {
	                        handleOtpSent(resp);
	                    }, function (resp) {
	                        handleOtpSent(resp);
	                    });
					});
                    
                } else {
                    show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
                }
            } else if (mode === "mobile") {
                if (isPhoneNumber(mobile)) {
                    countryCode = emailormobilevalue.substring(emailormobilevalue.length - 2);
                    emailormobilevalue = emailormobilevalue.substring(0, emailormobilevalue.length - 2);
                    $("div.valueemailormobile span")[0].textContent = emailormobilevalue;
                    encryptData.encrypt([mobile]).then(function(encryptedloginid) {
						encryptedloginid = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
						var params = { mobile: encryptedloginid, countrycode: countryCode };
	                    var payload = Phone.create(params);
	                    payload.POST("self", "self").then(function (resp) {
	                        handleOtpSent(resp);
	                    }, function (resp) {
	                    	if(handleCaptcha().isRequired(resp)) {
	                    		handleCaptcha(resp, {
	                    			callbacks: {
	                    				relogin: classifyError,
	                    				beforeInit: function() {
	                    					$(".verify-tick").removeClass("ver-load");
	                    	                $(".verify-tick .icon2-Verify").removeClass("loader");
	                    	                $(".unverContainer, [name=confirm_form1] .succfail-btns, .review_desc ").slideUp(200, function(){
	                    	                	$(".captcha-wrapper").show();
	                        	                $("#verify-mob-captcha, .captcha-wrapper .succfail-btns").slideDown(300);
	                    	                });
	                    				},
	                    				beforeDestroy: function() {
	                    	                $("#verify-mob-captcha, .captcha-wrapper .succfail-btns").slideUp(200);
	                    					$(".captcha-wrapper").hide();
	                    				}
	                  				}
	                    		}).init('#verify-mob-captcha', payload, ["self", "self"]).then(handleOtpSent, function(err){
	                    			$(".unverContainer, [name=confirm_form1] .succfail-btns, .review_desc ").slideDown(300);
	                    			classifyError(err);
	                    		});
	                    	} else {
	                            handleOtpSent(resp);
	                    	}
	                    });
					});
                } else {
                    show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
                }
            }
        }
        function handleOtpSent(resp) {
            if (resp != "" && resp != undefined) {
                $(".verify-tick").removeClass("ver-load")
                $(".verify-tick .icon2-Verify").removeClass("loader")
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    clearError('#otp_split_input');
                    if (isEdit) {
                        document.querySelector(".edit_option").style.display = "inline-block";
                    }
                    mResendCount = 3;
                    $(".enter_eml_mob_desc, .send_otp_btn, ." + mode + "_input_container, .existing_numbers_container, .update_send_otp_btn").slideUp(200);
                    if ($(".unverContainer:visible").length && $(".emailnumb-cont").length) {
                        $(".unverContainer, [name=confirm_form1] .succfail-btns, .review_desc ").slideUp(200);
                    }
                    if(mode === "email"){
                    	$(".otp_sent_desc .sent_desc").text(I18N.get("IAM.DIGIT.VER.CODE.SENT.EMAIL"))
                    } else {
                    	$(".otp_sent_desc .sent_desc").text(I18N.get("IAM.DIGIT.VER.CODE.SENT.MOBILE"))
                    }
                    $(".otp_input_container, .otp_sent_desc").slideDown(200);
                    setTimeout(function () {
                        $(".resend_otp").html("<div class='tick'></div>" + I18N.get('IAM.GENERAL.OTP.SUCCESS'));
                        setTimeout(function () {
                            resendOtpChecking();
                        }, 1000);
                    }, 800);
                    if (resp.resource_name) {
                        cryptData = resp[resp.resource_name].encrypted_data;
                    }
                } else {
                    classifyError(resp, "#" + mode + "_input");
                }
            } else {
                showErrMsg("<@i18n key="IAM.ERROR.GENERAL"/>");
            }
        }
        function resendOTP() {
            $(".resend_otp").html("<div class='loader'></div>" + I18N.get('IAM.GENERAL.OTP.SENDING'));
            var params = {};
			if (mode === "email") {
				var payload = Email.create(params);
			} else if (mode === "mobile") {
				var payload = Phone.create(params);
			}
            payload.PUT("self", "self", cryptData).then(function (resp) {
                handleOtpResent(resp)
            }, function (resp) {
                handleOtpResent(resp)
            });
        }
        function handleOtpResent(resp) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
					if (mode == "mobile") {
						mResendCount--;
					}
                    setTimeout(function () {
                        $(".resend_otp").html("<div class='tick'></div>" + I18N.get('IAM.GENERAL.OTP.SUCCESS'));
                        setTimeout(function () {
							if (mResendCount < 1) {
                                $(".resend_otp").slideUp(250);
                            }
                            resendOtpChecking();
                        }, 1000);
                    }, 800);
                } else {
                    $(".resend_otp").html("<@i18n key="IAM.TFA.RESEND.OTP"/>");
                    $(".resend_otp").removeClass("nonclickelem");
                    classifyError(resp, "#otp_split_input");
                }
            }
        }
        function updateEmlMblValue() {
            clearError('#' + mode + '_input');
            var splitinput = document.querySelectorAll("input.splitedText");
            for (var x = 0; x < splitinput.length; x++) {
                splitinput[x].value = "";
            }
            if (mode === "email") {
                var login_id = $("#email_input").val();
                if (isEmailId(login_id)) {
                    emailormobilevalue = login_id;
                    sendOTP(mode, login_id);
                } else {
                    show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
                }
            }
            else if (mode === "mobile") {
                var login_id = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g, '');
                if (isPhoneNumber(login_id)) {
                    mobile = login_id;
                    var dialCode = $('#countNameAddDiv option:selected').attr("data-num");
                    var countryCode = $('#countNameAddDiv option:selected').attr("id");
                    emailormobilevalue = dialCode + " " + login_id + countryCode;
                    sendOTP(mode, emailormobilevalue);
                } else {
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
                if (!altered) {
                    $(".send_otp_btn span").css("margin-left", "5px");
                    $(".send_otp_btn span").html(resendtiming + "s");
                }
                if (resendtiming === 0) {
                    clearInterval(resendTimer);
                    $(".resend_otp").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
                    $(".send_otp_btn span").html("");
                    $(".send_otp_btn span").css("margin", "0px");
                    $(".resend_otp").removeClass("nonclickelem");
                    $(".send_otp_btn").removeAttr("disabled");
                }
            }, 1000);
        }
        function verifyCode(e) {
            e.preventDefault();
            var mode = e.target.dataset.mode;
            var targetEle = e.target.dataset.target;
            var Code = document.querySelector("#otp_split_input_full_value").value;
            if (Code == "") {
                show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));
                return false;
            }
            if (!isValidCode(Code)) {
                show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.VALID.OTP"));
                return false;
            }
            if ($(".error_msg").length < 1) {
                clearError('#otp_split_input');
                $(".verify_btn span").html("<div class='loader white'></div>");
                $(".verify_btn").prop("disabled", true);
                var params = { code: Code };
                if (mode === "email") {
                    var payload = Email.create(params);
                } else if (mode === "mobile") {
                    var payload = Phone.create(params);
                }
                payload.PUT("self", "self", cryptData).then(function (resp) {
                    handleVerifyCode(resp, targetEle)
                }, function (resp) {
                    handleVerifyCode(resp)
                });
            }
        }
        function handleVerifyCode(resp, targetID) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    unverifiedCount--;
                    if (unverifiedCount < 1) {
                        $(".resend_otp").css("visibility", "hidden");
                        setTimeout(function () {
                            $(".verify_btn").prop("disabled", false);
                            $(".verify_btn").html("<div class='tick verified_tick white'></div>" + I18N.get('IAM.VERIFIED'));
                            setTimeout(function () {
                                window.location.href = next;
                            }, 1000);
                        }, 1000);
                    } else if (targetID != null) {
                        $(".verify_btn span").html("");
                        $(".verify_btn").prop("disabled", false);
                        targetEle = document.querySelector("#" + targetID);
                        $(targetEle).closest(".emailnumb-cont")[0].classList.remove("email-cont", "mobile-cont");
                        $("#" + targetID + " span").html(I18N.get('IAM.VERIFIED'));
                        $("#" + targetID).addClass("verified");
                        caseCheck();
                        $(".continue_btn").show();
                        backToUnverified();
                    }
                } else {
                    $(".verify_btn span").html("");
                    $(".verify_btn").prop("disabled", false);
                    classifyError(resp, "#otp_split_input");
                }
            }
        }
        function redirect(e) {
            e.target.setAttribute("disabled", '');
            e.target.querySelector("span").classList.add("loader");
            window.location.href = next;
        }
        function closeRelogin(e) {
            e.stopPropagation();
            document.getElementById("error_space").classList.remove("show_error");
            document.querySelector("#error_space .close_btn").removeEventListener("onclick", closeRelogin);
            document.querySelector("#error_space .close_btn").style.display = "none"
        }
        function reloginRedirect() {
            var service_url = euc(window.location.href);
            window.open(contextpath + $("#error_space")[0].getAttribute("resp") + "?serviceurl=" + service_url + "&post=" + true, '_blank') //No i18N
            document.getElementById("error_space").classList.remove("show_error");
        }
        function classifyError(resp, siblingClassorID) {
            if (resp.status_code && resp.status_code === 0) {
                showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
            } else if (resp.code === "Z113") {//No I18N
                showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
            } else if (resp.code === "PP112") {
                showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), resp);
            } else if (resp.code === "Z101") {
                showErrMsg(resp.localized_message)
            } else if (resp.localized_message && siblingClassorID) {
                show_error_msg(siblingClassorID, resp.localized_message)
            } else if (resp.localized_message) {
                showErrMsg(resp.localized_message)
            } else {
                showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
            }
        }
        function showErrMsg(msg, isRelogin, isSuccess) {
            $(".error_icon").removeClass("warning_icon verified-selected");
            $("#error_space").removeClass("warning_space success_space");
            document.querySelector("#error_space .close_btn").removeEventListener("onclick", closeRelogin);
            document.querySelector("#error_space .close_btn").style.display = "none";
            if (isRelogin) {
                document.getElementsByClassName("error_icon")[0].classList.add("warning_icon")
                document.getElementById("error_space").classList.add("warning_space")
                document.getElementsByClassName("error_icon")[0].innerHTML = "!";
                document.getElementById("error_space").setAttribute("resp", isRelogin.redirect_url)
                document.getElementById("error_space").addEventListener("click", reloginRedirect)
                document.querySelector("#error_space .close_btn").addEventListener("click", closeRelogin)
                document.querySelector("#error_space .close_btn").style.display = "inline-block";
            } else if (isSuccess) {
                document.getElementById("error_space").classList.add("success_space")
                document.getElementsByClassName("error_icon")[0].classList.add("verified-selected")
                document.getElementsByClassName("error_icon")[0].innerHTML = "";
            } else {
                document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error")
                document.getElementsByClassName("error_icon")[0].innerHTML = "!";
            }
            document.getElementsByClassName('top_msg')[0].innerHTML = msg;
            document.getElementById("error_space").classList.add("show_error");
            if (!isRelogin) setTimeout(function () {
                document.getElementById("error_space").classList.remove("show_error");
            }, 5000);
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
        function clearError(ClassorID, e) {
            if (e && e.keyCode == 13 && $(".error_msg:visible").length) {
                return;
            }
            $(ClassorID).removeClass("errorborder")
            $(".errorborder").removeClass("errorborder")
            $(".error_msg").remove()
        }
        function allowSubmit(e) {
            if (mode === "email" && emailormobilevalue === e.target.value || emailormobilevalue === "") {
                altered = false;
                if (!resendtiming == 0) {
                    $(".send_otp_btn").prop("disabled", true);
                }
            }
            else if (mode === "mobile" && mobile === e.target.value.replace(/[+ \[\]\(\)\-\.\,]/g, '') || mobile === "") {
                altered = false;
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
        function caseCheck() {
            var em = $(".email-cont").length;
            var mo = $(".mobile-cont").length;
            if (em && mo) {
                $(".account_verify_desc span").html(I18N.get("IAM.N.UNVERIFIED.EMAILS.NUMBERS") + " " + I18N.get("IAM.PLEASE.VERIFY.THEM"));
            } else if (em && !mo) {
                if (em == 1) {
                    $(".account_verify_desc span").html(I18N.get("IAM.N.UNVERIFIED.EMAIL.ADD") + " " + I18N.get("IAM.PLEASE.VERIFY.IT"));
                } else {
                    $(".account_verify_desc span").html(I18N.get("IAM.N.UNVERIFIED.EMAIL.ADDS") + " " + I18N.get("IAM.PLEASE.VERIFY.THEM"));
                }
            } else if (mo && !em) {
                if (mo == 1) {
                    $(".account_verify_desc span").html(I18N.get("IAM.N.UNVERIFIED.MOBILE.NUMBER") + " " + I18N.get("IAM.PLEASE.VERIFY.IT"));
                } else {
                    $(".account_verify_desc span").html(I18N.get("IAM.N.UNVERIFIED.MOBILE.NUMBERS") + " " + I18N.get("IAM.PLEASE.VERIFY.THEM"));
                }
            }
            $(".account_verify_desc span").show();
            $(".unverContainer").show();
        }
        function deleteEmailMobile(e, val, mode) {
            e.stopPropagation();
            deleteTarget = e.target.id;
            switch (mode) {
                case "mobile":
                    $(".delete-popup .popup-heading").html(I18N.get("IAM.CONFIRM.POPUP.PHONENUMBER"));
                    $(".delete-desc").html(I18N.get("IAM.MOBILE.ERROR.SURE.DELETE.PHONE", val));
                    break;
                case "email":
                    $(".delete-popup .popup-heading").html(I18N.get("IAM.CONFIRM.POPUP.EMAIL"));
                    $(".delete-desc").html(I18N.get("IAM.DELETE.YOUR.EMAIL", val));
                    break;
            }
            $(".delete_btn")[0].dataset.mode = mode;
            $(".delete_btn")[0].dataset.val = val;
            $(".delete_btn")[0].dataset.targetID = deleteTarget;
            $(".delete-popup").fadeIn(100);
            popup_blurHandler(6);
            $(".delete-popup").addClass("pop_anim");
            $(".delete-popup").focus();
        }
        function handleDeleteEmailMobile(e) {
            e.stopPropagation();
            e.preventDefault();
            deleteTargetID = e.target.dataset.targetID;
            mode = e.target.dataset.mode;
            val = e.target.dataset.val;
            var uri;
            e.target.setAttribute("disabled", '');
            e.target.querySelector("span").classList.add("loader",);
            if (mode === "email") {
                uri = new URI(Email, "self", "self", val)
            } else if (mode === "mobile") {
                uri = new URI(Phone, "self", "self", val)
            }
            uri.DELETE().then(function (resp) {
                handleDelete(resp, deleteTargetID)
            }, function (resp) {
                handleDelete(resp)
            });
        }
        function handleDelete(resp, deleteTargetID) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    unverifiedCount--;
                    $(".delete_btn").removeAttr("disabled");
                    $(".delete_btn span").removeClass("loader");
                    if (unverifiedCount < 1) {
                        $(".cancel_btn").hide();
                        $(".delete-popup .popup-header").html(I18N.get("IAM.REDIRECTING.SERVICE"));
                        $(".delete-desc").html(I18N.get("IAM.REDIRECTING.NO.UNVERIFIED.DESC"));
                        $(".delete_btn")[0].textContent = I18N.get("IAM.REDIRECTING");
                        $(".delete_btn span").addClass("loader");
                        setTimeout(function () {
                            window.location.href = next;
                        }, 300)

                    } else if (unverifiedCount >= 1) {
                        var parentCont = $("#"+deleteTargetID).closest(".emailnumb-cont")[0];
                        parentCont.classList.remove("email-cont", "mobile-cont");
                        caseCheck();
                        $(".delete-popup").slideUp(250, function () {
                            $(parentCont).animate({ "padding": "0px", "height": "0px", "font-size": "0px" }, 200, function () {
                                $(this).remove();
                            });
                            $(parentCont.querySelector("." + mode + "-icon")).fadeOut(200);
                        })
                        removeBlur();
                        showErrMsg(resp.localized_message, false, true);
                    }

                } else {
                    $(".delete_btn").removeAttr("disabled");
                    $(".delete_btn span").removeClass("loader");
                    cancelDelete();
                    classifyError(resp);
                }
            }
        }
        function cancelDelete() {
            $(".delete-popup").removeClass("pop_anim");
            $(".delete-popup").fadeOut(200, function () {
                removeBlur();
            });
        }
        function escape(e) {
            if (e.keyCode == 27) {
                cancelDelete();
            }
        }
        function removeBlur() {
            $(".blur").css({ "opacity": "0" });
            $("body").css("overflow", "auto");
            $(".blur").hide();
            $(".blur").unbind();
        }
        function backToUnverified() {
            $(".otp_input_container, .otp_sent_desc").slideUp(200);
            $(".unverContainer, [name=confirm_form1] .succfail-btns, .review_desc").slideDown(200, function(){
				$(".resend_otp").show();
            });
        }
        function verifyEmailMobile(e, value, vMode) {
            if (vMode == "email") {
                emailormobilevalue = value;
                mode = "email"
            } else if (vMode == "mobile") {
                emailormobilevalue = "+" + arguments[4] + " " + value + arguments[3];
                mode = "mobile";
                mobile = value;
            }
            e.target.classList.add("ver-load");
            e.target.querySelector(".icon2-Verify").classList.add("loader");
            document.querySelector(".otp_input_container .verify_btn").dataset.mode = vMode
            document.querySelector(".otp_input_container .verify_btn").dataset.target = e.target.id
            sendOTP(mode, emailormobilevalue);
        }
        function popup_blurHandler(ind) {
            $(".blur").show();
            $(".blur").css({ "z-index": ind, "background-color": "#00000099", opacity: "1" });
            $("body").css({
                overflow: "hidden" //No I18N
            });
            $(".blur").bind("click", function () {
                $(".cancel_btn").click();
            })
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
        function manage(){
			window.open("${Encoder.encodeJavaScript(email_url)}", "_blank");
			window.open(next, "_self");
        }
    </script>
</head>

<body>
    <div style="display: none">
        <#include "../zoho_line_loader.tpl">
    </div>
    <#include "../Unauth/announcement-logout.tpl">
	<#include "../utils/captcha-handler.tpl">
        <div class="blur"></div>
        <div id="error_space">
            <span class="error_icon">&#33;</span>
            <span class="top_msg"></span>
            <span class="close_btn" style="display: none"></span>
        </div>
        <div class="delete-popup" style="display: none" tabindex="1" onkeydown="escape(event)">
            <div class="popup-header">
                <div class="popup-heading"></div>
            </div>
            <div class="popup-body">
                <div class="delete-desc"></div>
                <button class="delete_btn" onclick="handleDeleteEmailMobile(event)"><span></span>
                    <@i18n key="IAM.CONFIRM" />
                </button>
                <button class="cancel_btn" onclick="cancelDelete()">
                    <@i18n key="IAM.CANCEL" />
                </button>
            </div>
        </div>
        <div class="flex-container container">
            <div class="content_container">
                <div class="rebrand_partner_logo"></div>
                <div class="announcement_header">
                    <@i18n key="IAM.VERIFY.YOUR.ACC.DETAILS" />
                </div>
                <div class="account_verify_desc">
                    <span style="display: none"></span>
                </div>
                <div class="otp_sent_desc" style="display: none">
                	<span class="sent_desc">
          			</span>
                    <span class="emailormobile">
                        <div class="valueemailormobile">
                        <span></span>
                        <span class="edit_option" onclick="handleEditOption(mode)" style="display: none">
                            <@i18n key="IAM.EDIT" />
                        </span>
                        </div>

                    </span>
                </div>
                <form name="confirm_form" onsubmit="return false;">
                    <div class="otp_input_container" style="display: none">
                        <label for="otp_split_input" class="emolabel">
                            <@i18n key="IAM.VERIFICATION.CODE" />
                        </label>
                        <div id="otp_split_input" class="otp_container"></div>
                        <div class="resend_otp" onclick="resendOTP()"><span></span>
                            <@i18n key="IAM.NEW.SIGNIN.RESEND.OTP" />
                        </div>
                        <div class="succfail-btns">
                            <button class="verify_btn" onclick="verifyCode(event)"><span></span>
                                <@i18n key="IAM.NEW.SIGNIN.VERIFY" />
                            </button>
                            <button class="back_btn" onclick="backToUnverified()">
                                <@i18n key="IAM.BACK" />
                            </button>
                        </div>
                    </div>
                </form>
                <form name="confirm_form1" onsubmit="return false;">
                    <div class="unverContainer" style="display: none">
                        <div class="unverHeader">
                            <@i18n key="IAM.UNVERIFIED.DETAILS" />
                        </div>
                        <#list unverifieds as x>
                            <#if x.email??>
                                <div class="emailnumb-cont email-cont" id="cont${x?index}">
                                    <div class="email-icon icon2-pebble icon2-Mail"></div>
                                    <div class="emailnumb-details">
                                        <span>${x.email}</span>
                                    </div>
                                    <div class="icon-wrap">
                                        <div class="verify-tick" onclick='verifyEmailMobile(event,"${x.email}","email")'
                                            id="verify-tick${x?index}">
                                            <div class="icon2-Verify"></div><span>
                                                <@i18n key="IAM.NEW.SIGNIN.VERIFY" /><span>
                                        </div>
                                        <div class="delete-icon icon2-delete" id="delete${x?index}"
                                            onclick='deleteEmailMobile(event,"${x.email}","email")'></div>
                                    </div>
                                </div>
                            </#if>
                            <#if x.mobile??>
                                <div class="emailnumb-cont mobile-cont" id="cont${x?index}">
                                    <div class="email-icon icon2-pebble icon2-Mobile"></div>
                                    <div class="emailnumb-details">
                                        <span>+${x.dialCode} ${x.mobile}</span>
                                    </div>
                                    <div class="icon-wrap">
                                        <div class="verify-tick"
                                            onclick='verifyEmailMobile(event,"${x.mobile}","mobile", "${x.countryCode}", "${x.dialCode}")'
                                            id="verify-tick${x?index}">
                                            <div class="icon2-Verify"></div><span>
                                                <@i18n key="IAM.NEW.SIGNIN.VERIFY" />
                                            </span>
                                        </div>
                                        <div class="delete-icon icon2-delete" id="delete${x?index}"
                                            onclick='deleteEmailMobile(event,"${x.mobile}","mobile")'></div>
                                    </div>
                                </div>
                            </#if>
                        </#list>
                    </div>
                    <div class="review_desc"><@i18n key="IAM.REVIEW.PROFILE.SECTION"/></div>
                    <div class="succfail-btns">
                        <#if unverifieds?size gt 1>
                            <button class="continue_btn" onclick="redirect(event)" style="display: none"><span></span>
                                <@i18n key="IAM.CONTINUE" />
                            </button>
                        </#if>
                        <button class="remind_me_later link-btn"
                            onclick="(function(e){window.location.href=skipnow; e.target.classList.add('remind_loader')})(event);"><span></span>
                            <div>
                                <@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" />
                                <div>
                        </button>
                    </div>
                </form>
                <div class="captcha-wrapper" style="display: none">
					<div id="verify-mob-captcha" style="display: none"></div>
					<div class="succfail-btns" style="display: none">
                        <button class="remind_me_later link-btn"
                            onclick="(function(e){window.location.href=skipnow; e.target.classList.add('remind_loader')})(event);"><span></span>
                            <@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" />
                        </button>
                    </div>
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
        URI.options.contextpath = "${za.contextpath}/webclient/v1";//No I18N
        URI.options.csrfParam = "${za.csrf_paramName}";
        URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
        caseCheck();
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
        setFooterPosition();
    }
</script>
</html>