<html lang="${signin.lang}">
	<head>
		<@resource path="/v2/components/css/${customized_lang_font}" />
		<@resource path="/v2/components/css/smartsignin.css" />
		<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
		<@resource path="/v2/components/tp_pkg/lottie.min.js" />
		<@resource path="/v2/components/js/weblogin.js" />
		<script src="${za.wmsjsurl}" integrity="${za.wmsjsintegrity}" crossorigin="anonymous" type="text/javascript" defer></script>
		<@resource path="/v2/components/js/wmsliteimpl.js" attributes="defer" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
    	<meta name="description" content="signin"/>
		<meta name="robots" content="noindex, nofollow"/>
		<title><@i18n key="IAM.SMART.SIGNIN.TITLE"/></title>
        <script type='text/javascript'>
        	var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var cookieDomain="${signin.cookieDomain}";
			var isKeepMeSignin = parseInt('${signin.isKeepMeSignin}');
			var loginParams= getLoginParams();
			var signinUrl = getSigninUrl();
			var smartSignin = true;
			var isDarkMode = parseInt("${signin.isDarkmode}");
			var wmsSRIValues = ${za.wmsSRIValues};
			I18N.load({
				"IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER" : '<@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER"/>', 
				"IAM.NEW.SIGNIN.RESTRICT.SIGNIN.DESC" : '<@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.DESC"/>', 
				"IAM.TRY.AGAIN" : '<@i18n key="IAM.TRY.AGAIN"/>',
				"IAM.NEW.SIGNIN.RESTRICT.SIGNIN.ONEAUTH.TITLE" : '<@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.ONEAUTH.TITLE"/>',
				"IAM.NEW.SIGNIN.RESTRICT.SIGNIN.ONEAUTH.DESC" : '<@i18n key="IAM.NEW.SIGNIN.RESTRICT.SIGNIN.ONEAUTH.DESC"/>',
				"IAM.SMART.SIGNIN.BACKTO.EMAIL" : '<@i18n key="IAM.SMART.SIGNIN.BACKTO.EMAIL"/>',
				"IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE" : '<@i18n key="IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE"/>' 
			});
			var iam_reload_cookie_name="${signin.iam_reload_cookie_name}";
        	window.onload = function() {
        		loadAnimation();
        		generateQrcode();
        		onSigninReady();
	   		}
	   		function getLoginParams(){
				var params = "cli_time=" + new Date().getTime();
				<#if (('${signin.servicename}')?has_content)>
					params += "&servicename=" + euc('${signin.servicename}');
				</#if>
				<#if (('${signin.serviceurl}')?has_content)>
					params += "&serviceurl="+euc('${Encoder.encodeJavaScript(signin.serviceurl)}');
				</#if>	
				<#if (('${signin.token}')?has_content)>
					params += "&token="+encodeURIComponent('${Encoder.encodeJavaScript(signin.token)}');//no i18N
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
				<#if (('${signin.hide_signup}')?has_content)>
					signinUrl += "&hide_reg_link="+${Encoder.encodeJavaScript(signin.hide_signup)};
				</#if>
				<#if (('${signin.appname}')?has_content)>
					signinUrl += "&appname="+encodeURIComponent('${Encoder.encodeJavaScript(signin.appname)}');
				</#if>
				<#if (('${signin.getticket}')?has_content)>
					signinUrl += "&getticket=true";
				</#if>
				<#if (('${signin.service_language}')?has_content)>
					signinUrl += "&service_language="+encodeURIComponent('${Encoder.encodeJavaScript(signin.service_language)}');//no i18N
				</#if>
				<#if (('${signin.portal_id}')?has_content)>
					signinUrl += "&portal_id="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_id)}');
				</#if>
				<#if (('${signin.portal_name}')?has_content)>
					signinUrl += "&portal_name="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_name)}');
				</#if>
				<#if (('${signin.portal_domain}')?has_content)>
					signinUrl += "&portal_domain="+encodeURIComponent('${Encoder.encodeJavaScript(signin.portal_domain)}');
				</#if>
				<#if (('${signin.context}')?has_content)>
					signinUrl += "&context="+encodeURIComponent('${Encoder.encodeJavaScript(signin.context)}');//no i18N
				</#if>
				<#if (('${signin.IAM_CID}')?has_content)>
					signinUrl += "&IAM_CID="+encodeURIComponent('${Encoder.encodeJavaScript(signin.IAM_CID)}');//no i18N
				</#if>
				<#if (('${signin.token}')?has_content)>
					signinUrl += "&token="+encodeURIComponent('${Encoder.encodeJavaScript(signin.token)}');//no i18N
				</#if>
				<#if (('${signin.signupurl}')?has_content)>
					signinUrl += "&signupurl="+encodeURIComponent('${Encoder.encodeJavaScript(signin.signupurl)}');//no i18N
				</#if>
				<#if (('${signin.isDarkmode}') == "1" )>
					signinUrl += "&darkmode=true";
				</#if>
				<#if signin.hiderightpanel>
					signinUrl += "&hiderightpanel=true";//no i18N
				</#if>
				
				return signinUrl;
			}
			function gotosignin(){
				if(localStorage && localStorage.getItem("isZohoSmartSigninDone")){localStorage.removeItem("isZohoSmartSigninDone")}
    			window.location.href=signinUrl;
    			return false;
			}
			function loadAnimation(){
				 var animationJson = bodymovin.loadAnimation({
				    container: document.getElementById('animation_rightside'),
				    path: '../../../../v2/components/images/json/smartsignin.json',
				    renderer: 'svg',
				    loop: true, 
				    autoplay: true,
				    name: "Smart sign-in animation",
				});
			}
        </script>
		
	</head>
	<body <#if (signin.isDarkmode == 1) > class="darkmode"</#if> <#if (signin.rtl == 1) > dir='rtl' </#if>>
		<div class="bg_one"><div class="greylayer" onclick=closeQRview()></div></div>
		<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
    	<div class="Errormsg"> <span class="error_icon"></span> <span class="error_message"></span> </div>
    	<div class="container">
    		<div class="signin_container">
    			<div class="greylayer" onclick=closeQRview()></div>
    			<div class="signin_box" id="signin_flow">
    				<#if signin.isPortalLogoURL>
    						<div><img class="portal_logo" src="${signin.portalLogoURL}"/></div>
						<#else>
							<div class='zoho_logo ${signin.servicename}'></div>
    					</#if>
    					<div id="signin_div">
    						<div class="signin_head">
			    					<span id="headtitle"><@i18n key="IAM.SMART.SIGNIN.TITLE"/></span>
									<div class="fielderror"></div>
							</div>
							<div class="verify_qr" id="verify_qr_container">
								<div class="smartsign-initial-loading-position">
									<div class="qr-reload-icon icon-Reload smartsign-initial-loading" id='qr_loading_animation'></div>
								</div>
								<div class="qr-reload-container flexM" onclick="generateQrcode();hideReload();">
				                    <div class="qr-reload-btn reload-content flexC">
				                        <div class="qr-reload-icon icon-Reload"></div>
				                        <div class="qr-reload-txt"><@i18n key="IAM.SMART.SIGNIN.RELOAD"/></div>
				                    </div>
				                </div>
								<div class="qrcodecontainer qr_act_view">
									<div class="qr-container-dom">
										<img id="qr_container_dom" class="wh100"/>
										<div class="expand_qr">
											<span class="icon-Expand"></span>
											<span><@i18n key="IAM.SMART.SIGNIN.EXPAND.CONTENT.UPDATE"/><span>
										</div>
									</div>
								</div>
								<div class="qrcodecontainer container_expand" onclick=closeQRview()>
									<div class="qr-container-dom" onclick=closeQRview()>
										<img id="qr_container_dom2" class="wh100"/>
										<div class="cancel_qr" onclick="closeQRview();statechange();">
											<span class="icon-Collapse"></span>
											<span><@i18n key="IAM.SMART.SIGNIN.CANCEL.CONTENT.UPDATE"/><span>
										</div>
									</div>
								</div>
								<div class="scanqrtitle"><@i18n key="IAM.SMART.SIGNIN.SCAN.QR.TITLE.UPDATE"/></div>
							</div>
							<div class="line">
				    			<span class="line_con">
				    				<span><@i18n key="IAM.OR"/></span>
				    			</span>
			    			</div>
							<div class="gobacktoemail" onclick="gotosignin()"><@i18n key="IAM.SMART.SIGNIN.BACKTO.EMAIL"/></div>
    					</div>
    					<div id="restrict_signin">
							<div class='signin_head restrict_head'></div>
							<div class='icon-Denied restrict_icon'></div> 
							<div class='restrict_desc service_name'></div>
							<div class="gobacktoemail Restrict_btn" id="restict_btn" onclick="RestrictSigninRedirect()"></div>
						</div>
    			</div>
    			<div class="rightside_box">
    					<div class="oneauthslider">
    						<div class="oneauthcontainer" id="animation_rightside"></div>
    					</div>
						<div class="smartsigninheader">
							<div class="smartsignintitle"><@i18n key="IAM.SMART.SIGNIN.STEPS.TO"/></div>
							<div class="smartsigincontent1"><@i18n key="IAM.SMART.SIGNIN.STEPS.TO.ONE.UPDATE"/></div>
							<div class="smartsigincontent2"><@i18n key="IAM.SMART.SIGNIN.STEPS.TO.TWO"/></div>
							<div class="smartsigincontent3"><@i18n key="IAM.SMART.SIGNIN.STEPS.TO.THREE"/></div>
						</div>
    			</div>
    		</div>
    		<div id="enableCookie" style='display:none;text-align:center'>
	            <#if signin.isPortalLogoURL>
	                    <div><img class='zoho_logo_position_center' src="${signin.portalLogoURL}" height="46"/></div>
	            <#else>
	                   <div class='zoho_logo ${signin.servicename} zoho_logo_position_center'></div>
	            </#if>
	            <div style="text-align: center;padding: 10px;"><@i18n key="IAM.ERROR.COOKIE_DISABLED"/></div>
		    </div>
    	</div>
    	<#include "footer.tpl">
	</body>
</html>