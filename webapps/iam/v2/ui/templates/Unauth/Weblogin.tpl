<html>
	<head>
		<@resource path="/v2/components/css/weblogin.css" />
		<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
		<@resource path="/v2/components/js/weblogin.js" />
		<script src="${za.wmsjsurl}" integrity="${za.wmsjsintegrity}" crossorigin="anonymous" type="text/javascript" defer></script>
		<@resource path="/v2/components/js/wmsliteimpl.js" attributes="defer" />
		<meta name="robots" content="noindex, nofollow"/>
        <script type='text/javascript'>
        	var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var cookieDomain="${signin.cookieDomain}";
			var iam_reload_cookie_name="${signin.iam_reload_cookie_name}";
			var isKeepMeSignin = parseInt('${signin.isKeepMeSignin}');
			var loginParams= getLoginParams();
			var signinUrl = getSigninUrl();
			var smartSignin = false;
			var isDarkMode = false;
			var wmsSRIValues = ${za.wmsSRIValues};
        	window.onload = function() {
        		$(".qrloginlink").attr("href", signinUrl);
        		generateQrcode();
	   		}
	   		function getLoginParams(){
				var params = "cli_time=" + new Date().getTime();
				<#if (('${signin.servicename}')?has_content)>
					params += "&servicename=" + euc('${signin.servicename}');
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					params += "&serviceurl="+euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
				</#if>
				<#if (('${signin.enforceqr}')?has_content)>
					params += "&enforceqr="+euc('${Encoder.encodeJavaScript(signin.enforceqr)}');
				</#if>
				return params;
			}
			function getSigninUrl(){
				var signinUrl = "/signin?";
				<#if (('${signin.servicename}')?has_content)>
					signinUrl += "servicename=" + euc('${signin.servicename}');
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					signinUrl += "&serviceurl=" + euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
				</#if>
				<#if (('${signin.enforceqr}')?has_content)>
					signinUrl += "&enforceqr="+euc('${Encoder.encodeJavaScript(signin.enforceqr)}');
				</#if>
				return signinUrl+"&QRLogin=false";
			}
        </script>
	</head>
	<body>
		<div class="wh100 outer-container">
    <div id="background_bg" class="background-bg"></div>
    <div class="wh100 main-container">
    	<div class="showTopNotificationMsg"><span class="topNotificationText"></span></div>
        <div class="logo-item-wrap flexM">
            <div class="logo-item"></div>
        </div>
        <div class="container">
        <div class="login-container signin_container">
            <div id="qr_main_container" class="qr-container flexM posrel">
                <div class="qr-container-dom posrel">
                    <img id="qr_container_dom" class="wh100"/>
                </div>
                <div class="qr-reload-container flexM" onclick="generateQrcode();hideReload();">
                    <div class="qr-reload-btn flexM">
                        <div class="qr-reload-icon"></div>
                        <div class="qr-reload-txt"><@i18n key="IAM.WEB.QR.LOGIN.RELOAD"/></div>
                    </div>
                </div>
            </div>
         <#if (signin.isKeepMeSignin == 1) >
            <div style="margin-top: 10px;">
                <label class="flexC">
                    <input type="checkbox"  name='remember' id='remember' checked/>
                    <div class="clr-S" style="margin-left: 5px;">Keep me signed in</div>
                </label>
            </div>
         </#if>
            <div style="margin-top: 32px; text-align: left;">
                <div class="clr-M" style="font-size: 20px; line-height: 24px; margin-bottom: 20px;"><b><@i18n key="IAM.WEB.QR.LOGIN.HEADER"/></b></div>
                <div style="color: #333; font-size: 15px; line-height: 18px;">
                    <div style="margin-bottom: 14px;"><@i18n key="IAM.WEB.QR.LOGIN.DESC1"/></div>
                    <div style="margin-bottom: 14px;" class="flexC"><@i18n key="IAM.WEB.QR.LOGIN.DESC2"/></div>
                    <div style="margin-bottom: 14px;"><@i18n key="IAM.WEB.QR.LOGIN.DESC3"/></div>
                </div>
            </div>
            <div class="separator"></div>
            <div class="flexM clr-S" style="font-size: 14px; line-height: 17px;"><@i18n key="IAM.WEB.QR.LOGIN.MOBILE.NUMBER" arg0=""/></div>
        </div>
        </div>
        <div id="enableCookie" style='display:none;text-align:center'>
	            <div style="text-align: center;padding: 10px;"><@i18n key="IAM.ERROR.COOKIE_DISABLED"/></div>
		</div>
    </div>
	</div>
	<#include "footer.tpl">
	</body>
</html>