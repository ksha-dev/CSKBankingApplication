${za.config.js_content}
var docHead = document.head || document.getElementsByTagName("head" )[0] || document.documentElement;
window.userPasswordMinLen = '8'; 
window.userPasswordMaxLen = '254';
var zaConstants = ${zaConstants};
window.ZACountryCodeDetails = ${country_code_details};
window.ZADefaultCountry = '${default_country_code}';
window.ZADefaultState = '${userState}';
window.ZACountryStateDetails = ${country_state_details};
window.loadCountryOptions = false;
window.signup_defaultmode = <#if (('${signup_defaultmode}')?has_content)>'${signup_defaultmode}'<#else>'01'</#if>;
var isDataCenterChangeNeeded = Boolean("<#if isDataCenterChangeNeeded>true</#if>");
var isDarkmode = parseInt('${isDarkmode}');
var isMobile = parseInt('${isMobile}');
var isSplitfield = Boolean("<#if isSplitfiled>true</#if>");
var SplitInputClone;
var uriPrefix="";
var captchaPrefix="";
var isCDNEnabled = Boolean("<#if isCDNEnabled>true</#if>");
var temp_token = '${tempToken}';
var loginIdChanged =false;
var enableCCSwitch = Boolean("<#if enableCCSwitch>true</#if>");
var fedlist = ${fedlist};
var iam_contextpath = "${za.iam_contextpath}";
var showMobileNoPlaceholder = Boolean("<#if showMobileNoPlaceholder>true</#if>");
var otp_length=${otp_length};
var zero_included_countrylist = ${zero_included_countrylist};
<#if (('${load_country}')?has_content)>
	window.loadCountryOptions = "${load_country}";
</#if>
var resIntegrity = {};
<#if (('${resIntegrity}')?has_content)>
	resIntegrity = ${resIntegrity};		
</#if>
var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
function iamMoveToSignin(loginurl,loginid,country_code){
	var oldForm = document.getElementById("signinredirection");
	if(oldForm) {
		document.documentElement.removeChild(oldForm);
	}
	if(isDarkmode){if(!(loginurl.indexOf("darkmode=true") != -1)){loginurl += "&darkmode=true"}}
	var form = document.createElement("form");
	form.setAttribute("id", "signinredirection");
	form.setAttribute("method", "POST");
    form.setAttribute("action", loginurl);
    form.setAttribute("target", "_parent");
	
	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "LOGIN_ID");
	hiddenField.setAttribute("value", loginid); 
	form.appendChild(hiddenField);
    
    if(country_code){
        hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "CC");
		hiddenField.setAttribute("value", country_code); 
		form.appendChild(hiddenField);
    }
	
   	document.documentElement.appendChild(form);
  	form.submit();
	return false;
}
window.zdtdomain='${zdtdomainUrl}';
function zaOnLoadHandler() {
	var cssURLs,jsURLs;
	<#if (('${cssURLs}')?has_content)>
		cssURLs = "${cssURLs}";		
	</#if>
	<#if (('${jsURLs}')?has_content)>
		jsURLs = "${jsURLs}";		
	</#if>
	// Include CSS
	if(cssURLs) {
		cssURLs = cssURLs.split(","); 
		for(var i = 0, len = cssURLs.length; i < len; i++) {
			var style = document.createElement("link");
			if(!isCDNEnabled){
				if(cssURLs[i].indexOf("/accounts/") == -1){	// No I18N
					cssURLs[i] = zaConstants.css_url + cssURLs[i]; // No I18n
				}
				else{
					cssURLs[i] = zaConstants.accountsServer + cssURLs[i]; // No I18n
				} 
			}
			style.href = cssURLs[i]; 
			style.rel = "stylesheet"; 
			if(resIntegrity && resIntegrity[cssURLs[i]]) {
				style.integrity = resIntegrity[cssURLs[i]];
				style.crossOrigin = "anonymous";	// No I18N
			}
			docHead.appendChild(style); 
		}
	}
	
	// Synchronously Include Scripts
	if(jsURLs) {
		jsURLs = jsURLs.split(","); 
		var scriptIdx = 0; 
		(function _jsOnLoad() {
			if (scriptIdx == jsURLs.length) { // Last script, all scripts were loaded. So, call the users handler.  
				onZAScriptLoad();
			} else {
				var jsURL = jsURLs[scriptIdx++]; 
				if((jsURL.indexOf("jquery-3.6.0.min") != -1 && window.jQuery)||(jsURL.indexOf("common.") != -1 && window.I18N)||(jsURL.indexOf("signin.min") != -1 && window.I18N)) { // Don't include jQuery, If it is already included in the page.
					 _jsOnLoad(); 
				} else { 
					if(!isCDNEnabled){
						if(jsURL.indexOf('http') != 0) { // is Relative URL ? 
							if(jsURL.indexOf("/accounts/") == -1){
								jsURL = zaConstants.js_url + jsURL; 
							}
							else{
								jsURL = zaConstants.accountsServer + jsURL;
							}
						}
					}
					includeScript(jsURL, _jsOnLoad); 
				}
			}
		})();
	}
};

function includeScript(url, callback) {
	var script = document.createElement("script"); 
	script.src = url; 
	if(resIntegrity && resIntegrity[url]) {
		script.integrity = resIntegrity[url];
		script.crossOrigin = "anonymous"; //No I18N
	}
	if (callback) { 
		script.onload = script.onreadystatechange = function() { 
			if (!this.readyState || this.readyState === "loaded" || this.readyState === "complete") {
				callback(); 
				script.onload = script.onreadystatechange = null; // To avoid calling repeatedly in IE 
			}
		};
	}
	docHead.appendChild(script); 
};

if(document.readyState == "complete") { // Call the handler if DOM already loaded.
	zaOnLoadHandler(); 
} else { 
	// Should not use `window.onload` as it might be overridden by service team  
	if (window.addEventListener) {
	  window.addEventListener('load', zaOnLoadHandler, false);  
	} else if (window.attachEvent)  { 
	  window.attachEvent('onload', zaOnLoadHandler); 
	}
}
function onZAScriptLoad() {
	$.fn.focus=function(){ 
		if(this.length){
			$(this)[0].focus();
		}
		return $(this);
	}
	Validator.addDefaultMethods();
	Util.redirectToHTTPS();
	Util.paramConfigure({ 
			"_sh" : "header,footer"
	});
	ZAConstants.load(zaConstants);
	I18N.load(${i18nArray});
	window.NewsLetterSubscriptionMode = JSON.parse('${newsletter_subscription_mode}');
		window.PasswordPolicyInfo = JSON.parse('${zaPasswordPolicy}');
		Util.includeJSON2();
		var zaSignUpOptions = $.fn.zaSignUp.defaults;  
		$.extend(true, zaSignUpOptions, { 
			x_signup : ${signUpConfig} 
		}); 
		var appserviceurl = zaSignUpOptions.x_signup.service_url;
		appserviceurl = appserviceurl.split("?")[0];
		var urlpathArray = appserviceurl.split( '/' );
		var urlProtocol = urlpathArray[0];
		var urlHost = urlpathArray[2];
		var appURL = urlProtocol + '//'+urlHost;
		CrossServiceRequest.appURLs[zaSignUpOptions.x_signup.service_name] = appURL;
		if(window.onSignupReady) {
			window.onSignupReady(); 
			if(isMobile == 1){
				var $email = document.getElementById("firstname"); 
				if($email){
					$email.focus(); 
				}
			}
	 	}
	 	window.onbeforeunload = unloadpopup; 
		   function unloadpopup(){ 
	 	      if(formvalidated){ 
		         return "Signup in progress"; 
	 	      }
		   }
}
function getRegisterUrl(){
	var scriptParams = '${scriptParams}';
	if(Validator.isValid(scriptParams)){
		registerUrl = "/register/script?"+scriptParams+"&loadcss=false&tvisit=true";
		return removeParam("load_country", registerUrl);
	}else{
		return "/register/script?loadcss=false&tvisit=true";
	}
}