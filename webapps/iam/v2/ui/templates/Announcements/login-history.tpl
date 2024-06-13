<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title> <@i18n key="IAM.SIGNIN.HISTORY.ANNOUN.PAGE.TITLE" /> </title>
    <link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
    <style>
    	* {
        	text-rendering: geometricPrecision;
      	}
        html,
        body {
            font-family: "ZohoPuvi", sans-serif;
            box-sizing: border-box;
            padding: 0;
            margin: 0;
        }
    </style>
    <script>
        var prevSelect;
		var historyData = ${LoginHistory};
      	var csrfParam= "${za.csrf_paramName}";
      	var csrfCookieName = "${za.csrf_cookieName}";
      	var contextpath = <#if context_path??>"${context_path}"<#else> "" </#if>;
        var visited = '${Encoder.encodeJavaScript(visited_url)}';
    </script>
</head>
<body>
	<#include "../zoho_line_loader.tpl">
	<link href="${SCL.getStaticFilePath("/v2/components/css/product-icon.css")}" rel="stylesheet"type="text/css">
    <link href="${SCL.getStaticFilePath("/v2/components/css/device-icon.css")}" rel="stylesheet"type="text/css">
    <link href="${SCL.getStaticFilePath("/v2/components/css/osbrowser-icon.css")}" rel="stylesheet"type="text/css">
    <link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/fonts/product-icons.woff")}" type="font/ttf" crossorigin="anonymous">
	<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_regular.woff")}" type="font/woff" crossorigin="anonymous">
	<link rel="preload" as="font" href="${SCL.getStaticFilePath("/v2/components/images/zohopuvi/zoho_puvi_bold.woff")}" type="font/woff" crossorigin="anonymous">
	<style>
	    .wrapper{
	    	padding-top: 80px;
	    }
        .wrap-body {
            max-width: 650px;
            margin: auto;
            padding: 0px 20px;
            height: calc(100vh - 200px);
        }
        .rebrand_partner_logo {
            height: 40px;
            background: url("/v2/components/images/newZoho_logo.svg") no-repeat;
            background-size: auto 40px;
            background-position: center;
        }
        .announcement-header {
            text-align: center;
            margin: 24px auto;
        }
        .history-container {
            border: 1px solid #D1D1D1;
            border-radius: 5px;
            max-height: 70%;
            position: relative;
            overflow: scroll;
            transition: .2s max-height linear;
        }
        ol {
            margin-block: 0;
            padding-inline-start: 0px;
            list-style-position: inside;
        }
        .activity-container {
            min-height: 30px;
            padding: 12px 30px 12px 30px;
            margin-top: 2px;
        }
        .activity-container:hover {
            background-color: #F8F8F8;
        }
        .activity-header::before {
            content: counter(listCount)".";
            display: inline-block;
            width: 24px;
            font-size: 14px;
            line-height: 24px;
            pointer-events: none;
        }
        .activity-header {
            display: inline-block;
            height: 50px;
            overflow: hidden;
        }
        .activity-header>div,
        .activity-header>i,
        .os-text,
        .service-text,
        .browser-text {
            display: inline-block;
            vertical-align: middle;
        }
        .device-icon {
            width: 50px;
            height: 50px;
            font-size: 50px;
            display: inline-block;
            pointer-events: none;
        }
        .browser-icon,
        .os-icon,
        .service-icon {
            height: 16px;
            font-size: 16px;
            margin-left: 24px;
        }
        .info .browser-icon,
        .info .os-icon,
        .info .service-icon {
            margin-left: 0px;
            display: inline-block;
            vertical-align: middle;
            margin-right: 8px;
        }
        i.service-icon {
            display: inline-block !important;
            position: relative;
            width: 16px;
        }
        .name-login-texts {
            margin-left: 12px;
            width: 130px;
            pointer-events: none;
        }
        .device-name {
            font-size: 16px;
            line-height: 20px;
            width: 100%;
    		white-space: nowrap;
    		overflow: hidden;
    		text-overflow: ellipsis;
        }
        .login-ago {
            font-size: 12px;
            line-height: 14px;
            color: #777777;
        }
        .location-text {
            font-size: 14px;
            line-height: 16px;
            margin-left: 24px;
            pointer-events: none;
        }
        .activity-body {
            padding-left: 30px;
            padding-bottom: 8px;
        }
        .bottom-gradient {
            background: transparent linear-gradient(180deg, #FFFFFF00 0%, #FFFFFF41 26%, #FFFFFF 100%) 0% 0% no-repeat padding-box;
            height: 16px;
            width: 99%;
            z-index: 10;
            position: relative;
            top: -17px;
            margin: auto;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        .announcement-note {
            font-size: 12px;
            color: #6F6F6F;
            font-style: italic;
            line-height: 14px;
        }
        .common-btn {
            font-family: "ZohoPuvi", sans-serif;
            background-color: #1389e3;
            border-radius: 4px;
            font-size: 14px;
            line-height: 20px;
            padding: 12px 30px;
            border: none;
            color: #ffffff;
            font-weight: bold;
            margin-top: 30px;
            cursor: pointer;
        }
        .common-btn:hover {
            background-color: #057AD3;
        }
        ol {
            cursor: pointer;
            outline: none;
        }
        ol:focus,
        ol:visited,
        ol:active {
            outline: none;
        }
        li {
            counter-increment: listCount;
        }
        .info {
            width: 40%;
            display: inline-block;
            font-size: 14px;
            line-height: 20px;
            margin-top: 20px;
            vertical-align: top;
            pointer-events: none;
            word-break: break-all
        }
        .info:nth-child(even) {
            margin-left: 12%;
        }
        .info-label {
            font-size: 12px;
            color: #777777;
            line-height: 14px;
            margin-bottom: 6px;
        }
        .info .location-text {
            margin-left: 0;
        }
        .activity-active {
            background-color: #F8F8F8;
        }
         .activity-active .activity-header{
         	width: 100%;
         }
        .activity-active .name-login-texts{
        	width: calc(100% - 100px);
        }
        .service-icon span {
            position: absolute;
            right: 0px;
            pointer-events:none;
        }
        .browser-icon span, .os-icon span{
        	pointer-events: none;
        }
        button:disabled {
            opacity: 0.4;
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
		i.important-hide{
			display: none !important;
		}
		.logout-icon-info:before { /* used from announcement-logout tpl font import since only one icon is need*/
			content: "\e934";
		}
		.info-icon{
			font-size: 14px;
			color: #7C7C7C;
			margin-left: 4px;
		}
		.tippy-tooltip {
			font-size: 14px !important;
		}
        @media only screen and (max-width: 650px) {
            .info {
                display: block;
                width: auto;
            }
            .info:nth-child(even) {
                margin-left: 0px;
            }
        }
        @media only screen and (max-width: 435px) {
        	.rebrand_partner_logo{
        		margin: 0px 20px;
        		background-position: left;
        	}
        	.announcement-header{
        		text-align: left;
        	}
	    	.wrapper{
	    		padding-top: 30px;
	    	}
            .wrap-body {
                height: calc(100vh - 160px);
            }
            .activity-container {
    			padding: 12px 16px 12px 16px;
			}
			.activity-body{
				padding-left: 12px;
				padding-right: 12px;
			}
			.activity-header{
				height: 36px;
				width: 100%;
			}
			.device-icon{
				width: 36px;
				height: 36px;
				font-size: 36px;
			}
			.activity-active .name-login-texts{
				width: calc(100% - 80px);
			}
			.device-name{
				font-size: 14px;	
			}
            .activity-header::before{
            	content: unset;
            }
            .common-btn{
            	width: 100%;
            }
            
        }
    </style>
	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
	<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}" type="text/javascript"></script>
	<#if !is_mobile>
	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/tippy.all.min.js")}"></script>
	</#if>
	<script>
        function addHistoryList(data){
        	historyData = data;
        	if (historyData) {
                for (i = 0; i < historyData.length; i++) {
                    var newli = document.getElementById("list-template").cloneNode(true);
                    newli.id = "list-" + i;
                    addDeviceIcon(newli.querySelector(".device-icon"), historyData[i].device_info);
                    newli.querySelector(".name-login-texts .device-name").textContent = historyData[i].device_info.device_name;
                    newli.querySelector(".name-login-texts .login-ago").textContent = historyData[i].created_time_elapsed;
                     newli.querySelector(".service-icon").setAttribute("title", historyData[i].service_name);
                    newli.querySelector(".service-icon").classList.add("product-icon-" + historyData[i].service_name.toLowerCase().replace(/\s/g, ''));
                    newli.querySelector(".browser-icon").setAttribute("title", historyData[i].browser_info.browser_name +" "+ (historyData[i].browser_info.bversion && historyData[i].browser_info.bversion != "-1" ? historyData[i].browser_info.bversion : ""));
                    addOSBrowserIcon(newli.querySelector(".browser-icon"), historyData[i].browser_info);
                    newli.querySelector(".os-icon").setAttribute("title", historyData[i].device_info.os_name +" "+ historyData[i].device_info.version);
                    addOSBrowserIcon(newli.querySelector(".os-icon"), historyData[i].device_info);
                    newli.querySelector(".location-text").textContent = historyData[i].location?historyData[dataIndex].location:"<@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" />";
                   	newli.querySelector(".info-icon").setAttribute("title","<@i18n key='IAM.ACTIVESESSIONS.IP.TOOLTIP.DESCRIPTION' />");
                    newli.addEventListener("click", selectAndSlide)
                    newli.addEventListener("keydown", keySelectAndSlide)
                    newli.style.display = "block";
                    parentOl.append(newli);
                }
                return true;
            } else {
            	return false;
            }
        }
        function selectAndSlide(e) {
            var currTarget = e.target;
            if (e.target.classList.contains("activity-header") || e.target.classList.contains("activity-body")) {
                currTarget = e.target.parentNode;
            }
            if(e.target.classList.contains("browser-icon") || e.target.classList.contains("service-icon") || e.target.classList.contains("os-icon")){
            	 currTarget = e.target.parentNode.parentNode;
            }
            var isContainerElement = currTarget.classList.contains("activity-container");
            if (isContainerElement) {
                if (!currTarget.lastElementChild.dataset.hasOwnProperty("created") && currTarget.lastElementChild.dataset.created != "true") {
                    index = currTarget.id.split("-")[1]
                    addBodyInfo(currTarget, index);
                }
                currTarget.classList.add("activity-active")
                currTarget.querySelector(".activity-header .os-icon").style.display = "none";
                currTarget.querySelector(".activity-header .browser-icon").style.display = "none";
                currTarget.querySelector(".activity-header .service-icon").classList.add("important-hide");
                currTarget.querySelector(".activity-header .location-text").style.display = "none";
                currTarget.querySelector(".activity-header .info-icon").style.display = "none";
                var tempPrev = prevSelect;
                $(currTarget.lastElementChild).slideDown(300, function(){       
					if(!tempPrev){
						$(".history-container").animate({scrollTop: $("#"+currTarget.id).offset().top - $(".history-container").offset().top + $(".history-container").scrollTop()},400);
					}
                });
            }
            if (prevSelect && isContainerElement) {
                prevSelect.classList.remove("activity-active");
                prevSelect.querySelector(".activity-header .os-icon").style.display = "inline-block";
                prevSelect.querySelector(".activity-header .browser-icon").style.display = "inline-block";
                prevSelect.querySelector(".activity-header .service-icon").classList.remove("important-hide")
                prevSelect.querySelector(".activity-header .location-text").style.display = "inline-block";
                prevSelect.querySelector(".activity-header .info-icon").style.display = "inline-block";
                $(prevSelect.lastElementChild).slideUp(300, function(){
					 $(".history-container").animate({scrollTop: $("#"+currTarget.id).offset().top - $(".history-container").offset().top + $(".history-container").scrollTop()},400);
                });
            }
            if (currTarget == prevSelect) {
                prevSelect = undefined;
            } else if(isContainerElement){
                prevSelect = currTarget;
            }
        }
        function keySelectAndSlide(e){
        	if(e.keyCode === 13){
        		e.target.click();
        	}
        }
        function addOSBrowserIcon(element, OSBrowser_info) { //
            var paths = new Map([["osx", 0], ["ios", 0], ["windows", 0], ["android", 0],
            ["linux", 0], ["googlechrome", 5], ["safari", 5],
            ["firefox", 3], ["microsoftedge", 3], ["internetexplorer", 0],
            ["opera", 2], ["browserunknown", 4], ["osunknown", 3], ["ulaa", 5]]);
            if (OSBrowser_info.browser_image) {
                if (paths.has(OSBrowser_info.browser_image)) {
                    icon_class = OSBrowser_info.browser_image.toLowerCase().replace(/\s/g, '');
                    no_paths = paths.get(OSBrowser_info.browser_image);
                } else {
                    icon_class = "browserunknown";
                    no_paths = 4
                }
            } else {
                if (paths.has(OSBrowser_info.os_img)) {
                    icon_class = OSBrowser_info.os_img.toLowerCase().replace(/\s/g, '');
                    no_paths = paths.get(OSBrowser_info.os_img);
                } else {
                    icon_class = "osunknown";
                    no_paths = 3
                }
            }
            element.classList.add("osbrowser-" + icon_class);
            for (var i = 1; i <= no_paths; i++) {
                var path = document.createElement('span');
                path.classList.add('path' + i); //No I18n
                element.append(path);
            }
        }
        function addDeviceIcon(element, device_info) {
            var img = device_info.device_img;
            var os = device_info.os_img;
            var paths = new Map([
                ["windows", 5], ["linux", 5], ["osunknown", 4], ["macbook", 8],
                ["iphone", 9], ["ipad", 7],
                ["windowsphone", 8], ["samsungtab", 6],
                ["samsung", 5], ["android", 8], ["pixel", 6],
                ["oppo", 8], ["vivo", 6],
                ["androidtablet", 6], ["oneplus", 7], ["mobile", 7]
            ]);
            var no_of_paths;
            var icon_class;
            if (img == "personalcomputer") {
                os = os ? os : "osunknown"; //No I18N
                no_of_paths = paths.get(os);
                icon_class = os + "_uk"; //No I18N
            } else if (img == "macbook" || img == "iphone" || img == "windowsphone" || img == "androidtablet") { //No I18N
                no_of_paths = paths.get(img);
                icon_class = img + "_uk"; //No I18N
            } else if (img == "vivo" || img == "ipad" || img == "samsungtab" || img == "samsung" || img == "pixel" || img == "oppo" || img == "oneplus") { //No I18N
                no_of_paths = paths.get(img);
                icon_class = img;
            } else if (img == "googlenexus" || (img == "mobiledevice" && os == "android")) { //No I18N
                no_of_paths = paths.get("android");
                icon_class = "android_uk"; //No I18N
            }
            else if (img == "mobiledevice") { //No I18N
                no_of_paths = paths.get("mobile");
                icon_class = "mobile_uk"; //No I18N
            }
            element.classList.add("deviceicon-" + icon_class);
            for (var i = 1; i <= no_of_paths; i++) {
                var path = document.createElement('span');
                path.classList.add('path' + i); //No I18n
                element.append(path);
            }
        }
        function addBodyInfo(element, dataIndex) {
            element.querySelector(".activity-body .login-text").textContent = historyData[dataIndex].created_time_formated;
            if (historyData[dataIndex].logout_date) {
                element.querySelector(".activity-body .logout-text").textContent = historyData[dataIndex].logout_date;
            } else {
                element.querySelector(".activity-body .logout-info").remove();
            }
            element.querySelector(".activity-body .ip-text").textContent = historyData[dataIndex].ip_address;
            element.querySelector(".activity-body .location-text").textContent = historyData[dataIndex].location?historyData[dataIndex].location:"<@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" />";
            element.querySelector(".activity-body .referrer-text").textContent = historyData[dataIndex].referrer;
            element.querySelector(".activity-body .browser-text").textContent = historyData[dataIndex].browser_info.browser_name+ " " +(historyData[dataIndex].browser_info.bversion && historyData[dataIndex].browser_info.bversion != "-1" ? historyData[dataIndex].browser_info.bversion : "" );
            element.querySelector(".activity-body .browser-texts").prepend(element.querySelector(".activity-header .browser-icon").cloneNode(true));
            element.querySelector(".activity-body .os-text").textContent = historyData[dataIndex].device_info.os_name + " " + historyData[dataIndex].device_info.version;
            element.querySelector(".activity-body .os-texts").prepend(element.querySelector(".activity-header .os-icon").cloneNode(true));
            element.querySelector(".activity-body .service-text").textContent = historyData[dataIndex].service_name;
            element.querySelector(".activity-body .service-texts").prepend(element.querySelector(".activity-header .service-icon").cloneNode(true));
            element.querySelector(".activity-body").dataset.created = "true"
        }
        function redirect(e) {
            e.target.setAttribute("disabled", "");
            e.target.children[0].classList.add("loader");
            window.location.href = visited;
        }
    </script>
    <div class="wrapper">
    <#include "../Unauth/announcement-logout.tpl">
        <header class="wrap-head">
            <div class="rebrand_partner_logo"></div>
        </header>
        <main class="wrap-body">
            <li id="list-template" class="activity-container" style="display: none;" tabindex="0">
                <div class="activity-header">
                    <div class="device-icon"></div>
                    <div class="name-login-texts">
                        <div class="device-name"></div>
                        <div class="login-ago"></div>
                    </div>
                 	<div class="browser-icon"></div>
                    <div class="os-icon"></div>
                    <i class="service-icon">
                        <span class="path1"></span>
                        <span class="path2"></span>
                        <span class="path3"></span>
                        <span class="path4"></span>
                        <span class="path5"></span>
                        <span class="path6"></span>
                        <span class="path7"></span>
                        <span class="path8"></span>
                        <span class="path9"></span>
                        <span class="path10"></span>
                        <span class="path11"></span>
                        <span class="path12"></span>
                        <span class="path13"></span>
                        <span class="path14"></span>
                        <span class="path15"></span>
                        <span class="path16"></span>
                    </i>
                    <div class="location-text"></div>
                    <div class="info-icon logout-icon-info"></div>
                </div>
                <div class="activity-body" style="display: none;">
                    <div class="info login-info">
                        <div class="info-label"><@i18n key="IAM.LOGINHISTORY.LOGINTIME" />
                        </div>
                        <div class="login-text"></div>
                    </div>
                    <div class="info logout-info">
                        <div class="info-label"><@i18n key="IAM.LOGINHISTORY.LOGOUTTIME" /></div>
                        <div class="logout-text"></div>
                    </div>
                    <div class="info os-info">
                        <div class="info-label"><@i18n key="IAM.OS.NAME.HEADING" /></div>
                        <div class="os-texts">
                            <div class="os-text"></div>
                        </div>
                    </div>
                    <div class="info service-info">
                        <div class="info-label"><@i18n key="IAM.SERVICE" /></div>
                        <div class="service-texts">
                            <div class="service-text"></div>
                        </div>
                    </div>
                    <div class="info browser-info">
                        <div class="info-label"><@i18n key="IAM.LOGINHISTORY.BROWSERAGENT.APP" /></div>
                        <div class="browser-texts">
                            <div class="browser-text"></div>
                        </div>
                    </div>
                    <div class="info referrer-info">
                        <div class="info-label"><@i18n key="IAM.LOGINHISTORY.REFERRER" /></div>
                        <div class="referrer-text"></div>
                    </div>
                    <div class="info ip-info">
                        <div class="info-label"><@i18n key="IAM.IPADDRESS" /></div>
                        <div class="ip-text"></div>
                    </div>
                    <div class="info location-info">
                        <div class="info-label"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /></div>
                        <div class="location-text"></div>
                    </div>
                </div>
            </li>
            <h2 class="announcement-header"><@i18n key="IAM.SIGNIN.HISTORY.ANNOUN.PAGE.HEADER" /></h2>
            <div class="history-container">
                <ol class="activity-order">
                </ol>
            </div>
            <div class="bottom-gradient"></div>
            <div class="announcement-note"><@i18n key="IAM.SIGNIN.HISTORY.ANNOUN.PAGE.NOTE" /></div>
            <button class="common-btn" tabindex="0" onclick="redirect(event)"><span></span><@i18n key="IAM.CONTINUE" /></button>
        </main>
    </div>
</body>
<script>
	var parentOl = document.querySelector(".activity-order");
    $(document).ready(function () {
       	if(historyData != "" && historyData != null){
        	if(addHistoryList(historyData)){
				setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500);
			}
		}
    })
	window.onload=function() {
		<#if !is_mobile>
		if(tippy){
			tippy('.activity-order .activity-header [class*="-icon"]', {
				animation: 'scale',
	  			arrow: true,
				distance: 15,
				maxWidth: "200px",
	  			placement:'bottom'//No I18N
			});
		}
		</#if>
	}
</script>
</html>