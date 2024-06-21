<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <#if !(mobile_only??)><@i18n key="IAM.ADD.RECOVERY.OPTION" /><#else><@i18n key="IAM.ADD.RECOVERY.MOBILE.TITLE" /></#if> | <@i18n key="IAM.ZOHO.ACCOUNTS" />
    </title>
    <script src="${SCL.getStaticFilePath(" /v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/tp_pkg/xregexp-all.js")}"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/zresource.js")}" type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/uri.js")}" async type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/splitField.js")}" type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/common_unauth.js")}" type="text/javascript"></script>
    <link href="${SCL.getStaticFilePath(" /v2/components/css/zohoPuvi.css")}" rel="stylesheet" type="text/css">
    <link href="${SCL.getStaticFilePath(" /v2/components/css/uvselect.css")}" rel="stylesheet" type="text/css">
    <link href="${SCL.getStaticFilePath(" /v2/components/css/flagIcons.css")}" rel="stylesheet" type="text/css">
    <script src="${SCL.getStaticFilePath(" /v2/components/js/uvselect.js")}" type="text/javascript"></script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/flagIcons.js")}" type="text/javascript"></script>
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
            background: url("${SCL.getStaticFilePath(" /v2/components/images/newZoho_logo.svg")}") no-repeat;
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
        .otp_sent_desc,
        .enter_eml_mob_desc,
        .captcha_desc {
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
        }
        [id*="_input"]:focus-visible {
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
            font-size: 12px
        }
        .send_otp_btn span.loader {
            margin-left: 10px;
            margin-right: 0px;
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
            background: url("${SCL.getStaticFilePath(" /v2/components/images/ann_blockunconfirmed.svg")}") no-repeat;
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
            letter-spacing: 0.5px;
        }
        .captcha_input_container {
            position: relative;
            border: 1px solid #DDDDDD;
            width: 250px;
            padding: 12px;
            box-sizing: border-box;
            margin-top: 8px;
            border-radius: 4px;
        }
        #captcha_input {
            width: 100%;
            margin-top: 10px;
        }
        #reload {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #F7F7F7;
            cursor: pointer;
            transition: transform 0.4s ease-in-out;
        }
        #reload:hover {
            transform: rotate(360deg);
        }
        .reload_spin {
            animation: load 0.5s linear infinite;
        }
        #reload.icon-reload::before {
            position: relative;
            text-align: center;
            top: 10px;
            left: 10px;
            opacity: 0.5;
        }
        #hip {
            height: 50px;
            max-width: 150px;
            width: calc(100% - 50px);
            box-sizing: border-box;
            margin: 0px;
        }
        #captcha_img {
            display: flex;
            align-items: center;
            justify-content: space-evenly;
        }
        .sm svg {
            transform: scale(0.7);
        }
        /* uvselect styles*/
        .form_container .select_container_cntry_code {
            margin-left: 0px;
        }
        .form_container .leading_icon {
            margin-left: 14px;
        }
        .form_container .select_input_cntry_code {
            width: 3em !important;
            padding-left: 1px;
            padding-right: 1px;
        }
        .form_container .select_input_cntry_code~.selectbox_arrow {
            margin-left: 2px;
            margin-right: 5px;
        }
        .form_container .selectbox--focus {
            border: 1px solid #0f090933 !important;
        }
        .form_container .selectbox_cntry_code {
            min-height: 42px;
        }
        .noindent {
            position: relative;
        }
        .textindent58 {
            text-indent: 76px !important;
        }
        .textindent66 {
            text-indent: 83px !important;
        }
        .textindent78 {
            text-indent: 92px !important;
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
        .phone_code_label {
            width: 60px;
            height: 44px;
            display: inline-block;
            float: left;
            position: absolute;
            line-height: 44px;
            text-align: center;
            font-size: 14px;
            color: black;
        }
        .phone_code_label:after {
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
            margin: 30px 0px;
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
        .remind_me_later {
            color: #8b8b8b;
            height: 18px;
            border-bottom: 1px dashed #acacac;
            text-decoration: none;
            outline: none;
            line-height: 16px;
            font-size: 14px;
            font-weight: 500;
            left: 0px;
            background-color: white;
            position: relative;
            transition: left .4s ease-in;
            height: 18px;
            margin-left: auto;
            margin-top: 0px;
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
        var csrfParam = "${za.csrf_paramName}";
        var csrfCookieName = "${za.csrf_cookieName}";
        var contextpath = <#if context_path??> "${context_path}" <#else > "" </#if>;
        var newPhoneData = <#if ((newPhoneData) ? has_content) > ${ newPhoneData } <#else>''</#if>;
        var resendTimer, resendtiming, altered, inputType, mode, captcha_digest, char100 , mobile, emailormobilevalue;
        <#if mobile_only??> mode = "mobile"</#if >
		var isEdit = true;
        var mResendCount = 3;
        countryCode = <#if countrycode?has_content>${countrycode ? c}<#else>""</#if>
        var showMobileNoPlaceholder = ${mob_plc_holder?c};
        var isMobile = ${ is_mobile?c };
        var reqCountry = "${req_country}";
        var captcha_error_img = "${SCL.getStaticFilePath(" / v2 / components / images / hiperror.gif")}";
        I18N.load({
            "IAM.GENERAL.OTP.SENDING": '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
            "IAM.GENERAL.OTP.SUCCESS": '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
            "IAM.ERROR.ENTER.VALID.OTP": '<@i18n key="IAM.ERROR.ENTER.VALID.OTP"/>',
            "IAM.GENERAL.ERROR.INVALID.OTP": '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
            "IAM.ERROR.ENTER.VALID.OTP": '<@i18n key="IAM.ERROR.ENTER.VALID.OTP" />',
            "IAM.ERROR.ENTER.VALID.EMAIL": '<@i18n key="IAM.ERROR.ENTER.VALID.EMAIL"/>',
            "IAM.PHONE.ENTER.VALID.MOBILE": '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE"/>',
            "IAM.GENERAL.OTP.SENDING": '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
            "IAM.GENERAL.OTP.SUCCESS": '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
            "IAM.VERIFIED": '<@i18n key="IAM.VERIFIED"/>',
            "IAM.TFA.RESEND.OTP.COUNTDOWN": '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
            "IAM.ERROR.EMPTY.FIELD": '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
            "IAM.ERROR.RELOGIN.UPDATE": '<@i18n key="IAM.ERROR.RELOGIN.UPDATE"/>',
            "IAM.ERROR.EMPTY.FIELD": '<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
            "IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL"/>',
            "IAM.PLEASE.CONNECT.INTERNET": '<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>',
            "IAM.ERROR.SESSION.EXPIRED": '<@i18n key="IAM.ERROR.SESSION.EXPIRED"/>',
            "IAM.USER.EMAIL.EXCEEDS.MAX.LENGTH": '<@i18n key="IAM.USER.EMAIL.EXCEEDS.MAX.LENGTH"/>',
        });
        var cryptData;
        <#if visited_url??>var next = '${Encoder.encodeJavaScript(visited_url)}'</#if>
            <#if skip_url??>var skipnow = '${Encoder.encodeJavaScript(skip_url)}'</#if>
		var Account = ZResource.extendClass({
                resourceName: "Account",//No I18N
                identifier: "zaid"	//No I18N  
            });
        var User = ZResource.extendClass({
            resourceName: "User",//No I18N
            identifier: "zuid",	//No I18N 
            attrs: ["first_name", "last_name", "display_name", "gender", "country", "language", "timezone", "state"], // No i18N
            parent: Account
        });
        var Email = ZResource.extendClass({
            resourceName: "Email",//No I18N
            identifier: "emailID",	//No I18N 
            attrs: ["email_id", "code"], // No i18N
            parent: User
        });
        var Phone = ZResource.extendClass({
            resourceName: "Phone",//No I18N
            identifier: "phonenum",	//No I18N 
            attrs: ["countrycode", "mobile", "code", "cdigest", "captcha"], // No i18N
            parent: User
        });
        var Captcha = ZResource.extendClass({
            resourceName: "Captcha",//No I18N
            identifier: "digest",	//No I18N 
            attrs: ["digest", "usecase"] // No i18N
        });
        function handleEditOption(mode) {
            clearError("#" + mode + "_input");
            $(".otp_input_container, [name=confirm_form1] .succfail-btns, .otp_sent_desc").slideUp(200);
            document.querySelector(".send_otp_btn").style.display = "block";
            document.querySelector(".resend_otp").style.display = "block";
            $("[name=confirm_form] .succfail-btns, .enter_eml_mob_desc").slideDown(200);
            if (!resendtiming == 0) {
                $(".send_otp_btn").prop("disabled", true);
            }
            document.querySelector("." + mode + "_input_container").style.display = "block";
            document.querySelector("#" + mode + "_input").focus();
            altered = false;
            if (mode === "email") {
                document.querySelector("#" + mode + "_input").value = emailormobilevalue;
            } else {
                //document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobile.toString());
            }
        }
        function sendOTP(mode, emailormobilevalue) {
            $(".resend_otp").html("<div class='loader'></div>" + I18N.get('IAM.GENERAL.OTP.SENDING'));
            if (mode === "email" || inputType === "email") {
                if (isEmailId(emailormobilevalue)) {
                    $("div.valueemailormobile span")[0].textContent = emailormobilevalue;
                    var params = { email_id: emailormobilevalue };
                    var payload = Email.create(params);
                    payload.POST("self", "self").then(function (resp) {
                        handleOtpSent(resp);
                    }, function (resp) {
                        handleOtpSent(resp);
                    });
                } else {
                    show_error_msg("#email_input", I18N.get("IAM.ERROR.ENTER.VALID.EMAIL"));
                }
            } else if (mode === "mobile" || inputType === "mobile") {
                if (isPhoneNumber(mobile)) {
                    countryCode = emailormobilevalue.substring(emailormobilevalue.length - 2);
                    $("div.valueemailormobile span")[0].textContent = emailormobilevalue.substring(0, emailormobilevalue.length - 2);
                    emailormobilevalue = (emailormobilevalue.substring(0, emailormobilevalue.length - 2)).split(" ")[1];
                    var params = { mobile: emailormobilevalue, countrycode: countryCode };
                    var payload = Phone.create(params);
                    payload.POST("self", "self").then(function (resp) {
                        handleOtpSent(resp);
                    }, function (resp) {
                        handleOtpSent(resp);
                    });
                } else {
                    show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE"));
                }
            }
        }
        function handleOtpSent(resp) {
            if (resp != "" && resp != undefined) {
                if (resp.status_code >= 200 && resp.status_code <= 299) {
                    if ($(".captcha_input_container:visible").length) {
                        hideCaptcha();
                    }
                    clearError('#otp_split_input');
                    if (isEdit != undefined && isEdit) {
                        document.querySelector(".edit_option").style.display = "inline-block";
                    }
                    mResendCount = 3;
                    $(".enter_eml_mob_desc, [name=confirm_form] .succfail-btns, ." + mode + "_input_container").slideUp(200);
                    $(".send_otp_btn").removeAttr("disabled");
                    $(".send_otp_btn span").removeClass("loader");
                    $(".email_sent, .mobile_sent").hide();
                    mode == "emailormobile" ? $("." + inputType + "_sent").show() : $("." + mode + "_sent").show();
                    if (resp.resource_name) {
                        if (resp[resp.resource_name].encrypted_data) {
                            cryptData = resp[resp.resource_name].encrypted_data;
                        }
                    }
                    $(".otp_input_container, [name=confirm_form1] .succfail-btns, .otp_sent_desc").slideDown(200);
                    setTimeout(function () {
                        $(".resend_otp").html("<div class='tick'></div>" + I18N.get('IAM.GENERAL.OTP.SUCCESS'));
                        setTimeout(function () {
                            resendOtpChecking();
                        }, 1000);
                    }, 800);
                } else {
                    $(".send_otp_btn").removeAttr("disabled");
                    $(".send_otp_btn span").removeClass("loader");
                    if ($("#otp_split_input").is(":visible")) {
                        classifyError(resp, "#otp_split_input");
                    } else {
                        classifyError(resp, "#" + mode + "_input");
                    }
                }
            }
        }
        function resendOTP() {
            $(".resend_otp").html("<div class='loader'></div>" + I18N.get('IAM.GENERAL.OTP.SENDING'));
            var params = {};
            if (mode === "email" || inputType === "email") {
                var payload = Email.create(params);
            } else if (mode === "mobile" || inputType === "mobile") {
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
                    if (mode == "mobile" || inputType == "mobile") {
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
                clearError('#otp_split_input');
                $(".verify_btn span").html("<div class='loader white'></div>");
                $(".verify_btn").prop("disabled", true);
                var params = { code: Code };
                if (mode === "email" || inputType === "email") {
                    var payload = Email.create(params);
                } else if (mode === "mobile" || inputType === "mobile") {
                    var payload = Phone.create(params);
                }
                payload.PUT("self", "self", cryptData).then(function (resp) {
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
                        setTimeout(function () { window.location.href = next; }, 1000);
                    }, 1000);
                } else {
                    $(".verify_btn span").html("");
                    $(".verify_btn").prop("disabled", false);
                    classifyError(resp, "#otp_split_input");
                }
            }
        }

        function updateEmlMblValue(e) {
            clearError('#' + mode + '_input');
            if ($("#" + mode + "_input").val() == "") {
                show_error_msg("#" + mode + "_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));
                return;
            }
            e.target.setAttribute("disabled", '');
            e.target.querySelector("span").classList.add("loader");
            var splitinput = document.querySelectorAll("input.splitedText");
            for (var x = 0; x < splitinput.length; x++) {
                splitinput[x].value = "";
            }
            if (mode === "email" || inputType === "email") {
                var login_id = $("#" + mode + "_input").val();
                if (isEmailId(login_id)) {
                    emailormobilevalue = login_id;
                    sendOTP(mode, login_id);
                } else {
                    e.target.removeAttribute("disabled");
                    e.target.querySelector("span").classList.remove("loader",); //No i18N
                    show_error_msg("#" + mode + "_input", I18N.get("IAM.ERROR.ENTER.VALID.EMAIL"));
                }
            } else if (mode === "mobile" || inputType === "mobile") {
                var login_id = $("#" + mode + "_input").val().replace(/[+ \[\]\(\)\-\.\,]/g, '');
                if (isPhoneNumber(login_id)) {
                    mobile = login_id;
                    targetSel = "countNameAddDiv";
                    if(mode === "emailormobile"){
                    	targetSel = "countrySelect";
                    }
                    var dialCode = $('#'+targetSel+' option:selected').attr("data-num");
                    var countryCode = $('#'+targetSel+' option:selected').attr("id");
                    emailormobilevalue = dialCode + " " + login_id + countryCode;
                    sendOTP(mode, emailormobilevalue);
                } else {
                    e.target.removeAttribute("disabled");
                    e.target.querySelector("span").classList.remove("loader",); //No i18N
                    show_error_msg("#" + mode + "_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE"));
                }
            }
        }

        function loadCaptcha() {
            if ($(".captcha_input_container:visible").length) {
                $(".captcha_input_container .load-bg").fadeOut(200);
                return;
            }
            $(".account_verify_desc, .enter_eml_mob_desc").css("opacity", "0.6");
            var tempLoad = document.querySelector(".load-bg").cloneNode(true);
            tempLoad.classList.add("sm");
            $(".captcha_input_container").append(tempLoad);
            $("." + mode + "_input_container, [name=confirm_form] .succfail-btns").slideUp(200);
            $(".captcha_desc, .captcha_input_container, [name=confirm_form2] .succfail-btns").slideDown(200);
        }
        function showCaptcha(resp) {
            $("#reload").removeClass("reload_spin");
            if (resp.cause === "throttles_limit_exceeded") {
                captcha_digest = "";
                showCaptchaImg();
            }
            if ('cdigest' in resp) {
                captcha_digest = resp.cdigest;
            }
            else if ('digest' in resp) {
                captcha_digest = resp.digest;
            }
            Captcha.GET(captcha_digest).then(showCaptchaImg);
        }
        function showCaptchaImg(resp) {
            if (captcha_digest == '' || resp.cause == "throttles_limit_exceeded" || resp.image_bytes == '') {
                $("#hip")[0].src = captcha_error_img;
                return false;
            } else if (resp.status == "success" && resp.image_bytes != null) {
                $("#captcha_input").val("");
                $("#hip")[0].src = resp.image_bytes;
            } else {
                classifyError(resp, "#captcha_input");
            }
        }
        function reloadCaptcha() {
            var params = { "digest": captcha_digest, "usecase": "sms" };//no i18N
            var payload = Captcha.create(params);
            $("#reload").addClass("reload_spin");
            payload.POST().then(showCaptcha);
        }
        function verifyCaptcha(e) {
            clearError("#captcha_input")
            var captchavalue = $("#captcha_input").val();
            if (captchavalue == null || captchavalue == "" || /[^a-zA-Z0-9\-\/]/.test(captchavalue)) {
                show_error_msg("#captcha_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));
                return false;
            }
            if (/[^a-zA-Z0-9\-\/]/.test(captchavalue) || captchavalue.length < 6) {
                show_error_msg("#captcha_input", "Please enter a valid CAPTCHA");
                return false;
            }
            var parms = {
                "mobile": (emailormobilevalue.substring(0, emailormobilevalue.length - 2)).split(" ")[1],
                "countrycode": emailormobilevalue.substring(emailormobilevalue.length - 2),
                "cdigest": captcha_digest,
                "captcha": captchavalue
            };
            var payload = Phone.create(parms);
            payload.POST("self", "self").then(function (resp) {
                handleOtpSent(resp);
            },
                function (resp) {
                    classifyError(resp, "#captcha_input")
                });
        }
        function hideCaptcha() {
            $(".account_verify_desc, .enter_eml_mob_desc").css("opacity", "1");
            $(".captcha_desc, .captcha_input_container, [name=confirm_form2] .succfail-btns").slideUp(200);
            $("#captcha_input").val("");
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
        function allowSubmit(e) {
			if(e.target.value.length > 100 && (mode || inputType === "email")){
				if(char100){ return; }
				show_error_msg(e.target, I18N.get("IAM.USER.EMAIL.EXCEEDS.MAX.LENGTH"));
				char100 = true;
			}else{
				char100 = false;
			}
            if ((mode === "email" || inputType === "email") && emailormobilevalue === e.target.value || emailormobilevalue === "") {
                altered = false;
                if (!resendtiming == 0) {
                    $(".send_otp_btn").prop("disabled", true);
                }
            }
            else if ((mode === "mobile" || inputType === "mobile") && mobile === (e.target.value).replace(/[+ \[\]\(\)\-\.\,]/g, '') || mode === "mobile" && mobile === "") {
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
        function emailormobileInput(e) {
            var inputval = e.target.value.trim();
            var mobileTest = /^(?:[0-9] ?){2,1000}[0-9]$/.test(inputval);
            if (mobileTest) {
                $("#" + "emailormobile" + "_input").attr("type", "tel");
                $("#" + "emailormobile" + "_input").attr("maxlength", "15");
                if (!isMobile) {
                    $(".countrySelect.select_container_cntry_code").show();

                    $("#" + "emailormobile" + "_input").attr("style", "text-indent:78px !important");
                    if (inputType != "mobile") {
                        //phonePattern.intialize($("."+ mode +"_input_container #countrySelect")[0])
                        //$("#"+ "emailormobile" +"_input").value =  phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("."+ mode +"_input_container #countrySelect").val()), inputval.toString())
                    }
                } else {
                    phonecodeChangeForMobile(document.confirm_form.countrycode2);
                    $(".phone_code_label").show();
                    $("#" + "emailormobile" + "_input").attr("style", "text-indent:50px !important");
                }
                inputType = "mobile"
            } else {
                $(".countrySelect.select_container_cntry_code").hide();
                $(".phone_code_label").hide();
                $("#" + "emailormobile" + "_input").attr("type", "text");
                $("#" + "emailormobile" + "_input").removeAttr("maxlength");
                $("#" + "emailormobile" + "_input").attr("style", "text-indent:0px !important");

                inputType = "email"
            }
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

        function codelengthChecking(length_id, changeid) {
            var code_len = $(".select_input.select_input_cntry_code").val().length;
            var length_ele = $("#" + mode + "_input")
            length_ele.removeClass("textindent58 textindent66 textindent78");
            if (code_len == "2") {
                length_ele.addClass("textindent58");
            } else if (code_len == "3") {
                length_ele.addClass("textindent66");
            } else if (code_len == "4") {
                length_ele.addClass("textindent78");
            }
            length_ele.focus();
        }
        function phonecodeChangeForMobile(ele) {
            $(ele).css({ 'opacity': '0', 'width': '60px' });
            $(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
            $(ele).change(function () {
                $(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
            })
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
            if ('status_code' in resp && resp.status_code === 0) {
                showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
            } else if (resp.code === "Z113") {//No I18N
                showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
            } else if (resp.errors && resp.errors[0].code === "IN108") {
                loadCaptcha();
                showCaptcha(resp);
            } else if (resp.errors && resp.errors[0].code === "IN107") {
                captcha_digest = resp.cdigest;
                reloadCaptcha();
                show_error_msg(".captcha_input_container", resp.localized_message)
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
        function show_error_msg(siblingClassorID, msg) {
            $(".error_msg").remove();
            var errordiv = document.createElement("div");
            errordiv.classList.add("error_msg");
            $(errordiv).html(msg);
            $(errordiv).insertAfter(siblingClassorID);
            $(siblingClassorID).addClass("errorborder");
            $(".error_msg").slideDown(150);
        }
        function showErrMsg(msg, isRelogin) {
            document.getElementsByClassName("error_icon")[0].classList.remove("warning_icon");//No I18N
            document.getElementById("error_space").classList.remove("warning_space") //No I18N
            document.querySelector("#error_space .close_btn").removeEventListener("onclick", closeRelogin);
            document.querySelector("#error_space .close_btn").style.display = "none";
            if (isRelogin) {
                document.getElementsByClassName("error_icon")[0].classList.add("warning_icon");//No I18N
                document.getElementById("error_space").classList.add("warning_space") //No I18N
                document.getElementsByClassName("error_icon")[0].innerHTML = "!"; //No I18N
                document.getElementById("error_space").setAttribute("resp", isRelogin.redirect_url)
                document.getElementById("error_space").addEventListener("click", reloginRedirect)
                document.querySelector("#error_space .close_btn").addEventListener("click", closeRelogin);
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
			if(char100){
				return;
			}
            $(ClassorID).removeClass("errorborder")
            $(".errorborder").removeClass("errorborder");
            $(".error_msg").remove();
        }
        function initMobileSelect() {
            selectEle = document.confirm_form.countrycode;
            if (mode === "emailormobile") {
                selectEle = document.confirm_form.countrycode2;
            }
            if (!isMobile) {
                $(selectEle).uvselect({
                    "searchable": true,
                    "dropdown-width": "300px",
                    "dropdown-align": "left",
                    "embed-icon-class": "flagIcons",
                    "country-flag": true,
                    "country-code": true
                });
                $(".phone_code_label").css("visibility", "hidden")
            } else {
                phonecodeChangeForMobile(selectEle);
                $(".phone_code_label").hide();
            }
        }
    </script>
    <script src="${SCL.getStaticFilePath(" /v2/components/js/phonePatternData.js")}" type="text/javascript"></script>
</head>

<body>
    <div style="display: none">
        <#include "../zoho_line_loader.tpl">
    </div>
    <#include "../Unauth/announcement-logout.tpl">
        <div id="error_space">
            <span class="error_icon">&#33;</span>
            <span class="top_msg"></span>
            <span class="close_btn" style="display: none"></span>
        </div>
        <div class="flex-container container">
            <div class="content_container">
                <div class="rebrand_partner_logo"></div>
                <div class="announcement_header">
                    <#if !mobile_only??>
                        <@i18n key="IAM.ADD.RECOVERY.OPTION" />
                        <#else>
                            <@i18n key="IAM.ADD.RECOVERY.MOBILE.TITLE" />
                    </#if>
                </div>
                <div class="account_verify_desc">
                    <#if !mobile_only??>
                        <@i18n key="IAM.ADD.RECOVERY.OPTION.DESC1" /> <@i18n key="IAM.ADD.RECOVERY.OPTION.DESC2" />
                    <#else>
                        <@i18n key="IAM.ADD.RECOVERY.ORGADMIN.DESC" /> <@i18n key="IAM.ADD.RECOVERY.REC.ADMIN.DESC" />
                    </#if>
                </div>
                <div class="otp_sent_desc" style="display: none">
                    <span class="email_sent" style="display: none">
                        <@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL" />
                    </span>
                    <span class="mobile_sent" style="display: none">
                        <@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE" />
                    </span>
                    <span class="emailormobile">
                        <div class="valueemailormobile">
                        	<span>
                            	<#if email?has_content>${email}<#else>${mobile}</#if>
                            </span>
                            <span class="edit_option" onclick="handleEditOption(mode)">
								<@i18n key="IAM.EDIT" />
							</span>
                        </div>
                    </span>
                </div>
                <div class="enter_eml_mob_desc">
                    <#if !mobile_only??>
                        <@i18n key="IAM.EMAIL.MOBILE.SEND.OTP" />
                        <#else>
                            <@i18n key="IAM.MOBILE.SEND.OTP.VERIFY" />
                    </#if>
                </div>
                <div class="captcha_desc" style="display: none">
                    <@i18n key="IAM.CONFIG.CAPTCHA.DESC" />
                </div>
                <div class="form_container">
                    <form name="confirm_form" onsubmit="return false">
                        <div class="email_input_container" style="display: none">
                            <label for="email_input" class="emolabel">
                                <@i18n key="IAM.EMAIL.ADDRESS" />
                            </label>
                            <input type="text" id="email_input" autocomplete="email"
                                onkeydown="clearError('#email_input', event)" oninput="allowSubmit(event)" />
                        </div>
                        <div class="mobile_input_container field" style="display: none" id="select_phonenumber">
                            <label for="mobile_input" class="emolabel">
                                <@i18n key="IAM.MOBILE" />
                            </label>
                            <label for="countNameAddDiv" class="phone_code_label"></label>
                            <select id="countNameAddDiv" data-validate="zform_field" autocomplete="country-name" name="countrycode" class="countNameAddDiv" style="width: 66px">
                                <#list country_list as dialingcode>
                                    <option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}">${dialingcode.display}</option>
                                </#list>
                            </select>
                            <input class="textbox mobile_input" tabindex="0" data-validate="zform_field"
                                autocomplete="phonenumber" onkeydown="clearError('#mobile_input', event)"
                                oninput="allowSubmit(event)" name="mobile_no" id="mobile_input" maxlength="15"
                                data-type="phonenumber" type="tel" />
                        </div>
                        <div class="emailormobile_input_container" style="display: none">
                            <label for="emailormobile_input" class="emolabel">
                                <@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE" />
                            </label>
                            <label for="countrySelect" class="phone_code_label"></label>
                            <select id="countrySelect" data-validate="zform_field" autocomplete='country-name' name="countrycode2" class="countrySelect" style="width: 66px;">
                                <#list country_list as dialingcode>
                                    <option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}">${dialingcode.display}</option>
                                </#list>
                            </select>
                            <input type="text" id="emailormobile_input" autocomplete="on" autocorrect="off"
                                onkeydown="clearError('#emailormobile_input', event)"
                                oninput="allowSubmit(event),emailormobileInput(event)" placeholder="<@i18n key="IAM.ENTER.EMAIL.OR.MOBILE" />"/>
                        </div>
                        <div class="succfail-btns">
                            <button class="send_otp_btn" onclick="updateEmlMblValue(event)">
                                <@i18n key="IAM.SEND.OTP" /><span></span>
                            </button>
                            <button class="remind_me_later link-btn"
                                onclick="(function(e){window.location.href=skipnow; e.target.classList.add('remind_loader')})(event);"><span></span>
                                <@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" />
                            </button>
                        </div>
                    </form>
                    <form name="confirm_form1" onsubmit="verifyCode(event);return false;" novalidate>
                        <div class="otp_input_container" style="display: none">
                            <label for="otp_input" class="emolabel">
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
                            <button class="remind_me_later link-btn"
                                onclick="(function(e){window.location.href=skipnow; e.target.classList.add('remind_loader')})(event);"><span></span>
                                <@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" />
                            </button>
                        </div>
                    </form>
                    <form name="confirm_form2" onsubmit="return false;" novalidate>
                        <div class="captcha_input_container" style="display: none">
                            <div id="captcha_img" name="captcha">
                                <img id="hip" onload="loadCaptcha()">
                                <span class="reloadcaptcha icon-reload" id="reload"
                                    onclick="reloadCaptcha();clearError('#captcha_input',event)"></span>
                            </div>
                            <input type="text" id="captcha_input" maxlength="6" autocomplete="off" autocorrect="off"
                                onkeydown="clearError('#captcha_input', event)" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA" />"/>
                        </div>
                        <div class="succfail-btns" style="display: none">
                            <button class="captcha_btn" onclick="verifyCaptcha(event)"><span></span>
                                <@i18n key="IAM.NEXT" />
                            </button>
                            <button class="remind_me_later link-btn"
                                onclick="(function(e){window.location.href=skipnow; e.target.classList.add('remind_loader')})(event);"><span></span>
                                <@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" />
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
        URI.options.contextpath = "${za.contextpath}/webclient/v1";//No I18N
        URI.options.csrfParam = "${za.csrf_paramName}";
        URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
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
        if (reqCountry != undefined && reqCountry != "") {
            $(".countrySelect option[value=" + reqCountry.toUpperCase() + "]").prop('selected', true);
        }

        if (mode === "email") {
            document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        } else if (mode === "mobile") {
            $("#" + mode + "_input").attr("style", "text-indent:78px !important");
            phonePattern.intialize(document.confirm_form.countrycode);
        } else {
            mode = "emailormobile"
        }
        if (mode != "email") {
            initMobileSelect();
        }
        if (mode == "emailormobile") {
            $(".countrySelect.select_container_cntry_code").hide();
            $("#" + mode + "_input").attr("style", "text-indent:0px !important");
            inputType = "email";
        }
        document.querySelector("." + mode + "_input_container").style.display = "block";
        $("#" + mode + "_input").focus();
        setFooterPosition();
    };
</script>

</html>