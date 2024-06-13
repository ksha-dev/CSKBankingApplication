${za.config.js_content}
var docHead = document.head || document.getElementsByTagName("head" )[0] || document.documentElement;
window.userPasswordMinLen = '8'; 
window.userPasswordMaxLen = '254';
var zaConstants = ${zaConstants};
window.ZACountryCodeDetails = ${country_code_details};
window.ZADefaultCountry = '${default_country_code}';
window.ZADefaultState = "";
window.ZACountryStateDetails = ${country_state_details};
window.loadCountryOptions = false;
var uriPrefix = '${uri_prefix}';
var captchaPrefix = '${captcha_prefix}';
var isCDNEnabled = Boolean("<#if isCDNEnabled>true</#if>");
var temp_token = '${tempToken}';
var loginIdChanged =false;
var showMobileNoPlaceholder = Boolean("<#if showMobileNoPlaceholder>true</#if>");
var otp_length=${otp_length};
<#if (('${load_country}')?has_content)>
	window.loadCountryOptions = "${load_country}";
</#if>
var iam_contextpath = "";
window.requireEnabled = typeof window.require==='function'&&typeof window.requirejs==='function' && window.requirejs.config != undefined;
var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
function loadTPfileinRequire(tpfiles){
	requirejs.config({
		paths:{
			jquery:[tpfiles[0].split(".js")[0]],
			'jquery.validate':[tpfiles[1].split(".js")[0]],
			xregexp:[tpfiles[2].split(".js")[0]]
		},
		shim:{
			xregexp:{exports:'XRegExp'},
			jquery:{exports:'jQuery'},
			'jquery.validate': {deps:['jquery']}
		}
	});
	require(['xregexp','jquery','jquery.validate'],function(XRegExp,jQuery,jqValidation){
		window.XRegExp=XRegExp;
		window.$=jQuery;
		window.jQuery=jQuery;
		includeScript(tpfiles[3],onZAScriptLoad);
	})
}

function zaOnLoadHandler() {
	var cssURLs,jsURLs;
	var tpfiles =[];
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
				if(cssURLs[i].indexOf('http') != 0) { // is Relative URL ? // No I18N
					if(cssURLs[i].indexOf("/accounts/") == -1){	// No I18N
						cssURLs[i] = zaConstants.css_url + cssURLs[i]; // No I18n
					}
					else{
						cssURLs[i] = zaConstants.accountsServer + cssURLs[i]; // No I18n
					}
				} 
			}
			style.href = cssURLs[i]; 
			style.rel = "stylesheet"; 
			docHead.appendChild(style); 
		}
	}
	
	// Synchronously Include Scripts
	if(jsURLs) {
		jsURLs = jsURLs.split(","); 
		var scriptIdx = 0; 
		(function _jsOnLoad() {
			if (scriptIdx == jsURLs.length) { // Last script, all scripts were loaded. So, call the users handler.  
				if(window.requireEnabled){
					loadTPfileinRequire(tpfiles);
				}else{
					onZAScriptLoad();
				}
			} else {
				var jsURL = jsURLs[scriptIdx++]; 
				if((jsURL.indexOf("jquery-3.6.0.min") != -1 && window.jQuery)||(jsURL.indexOf("common.") != -1 && window.I18N)||(jsURL.indexOf("signin.min") != -1 && window.I18N)) { // Don't include jQuery, If it is already included in the page.
					tpfiles.push(jsURL);
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
					if(window.requireEnabled && (jsURL.indexOf("jquery-3.6.0.min") != -1  || jsURL.indexOf("jquery.validate") != -1 || jsURL.indexOf("xregexp") != -1 || jsURL.indexOf("signup-new.min") != -1)){
						tpfiles.push(jsURL);
						_jsOnLoad();
					}else{
						includeScript(jsURL, _jsOnLoad);
					}
				}
			}
		})();
	}
};

function includeScript(url, callback) {
	var script = document.createElement("script"); 
	script.src = url; 
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
		<#if (('${zaPasswordPolicy}')?has_content)>
			window.PasswordPolicyInfo = JSON.parse('${zaPasswordPolicy}');
		</#if>
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
	 	}
	 	window.onbeforeunload = unloadpopup; 
		   function unloadpopup(){ 
	 	      if(formvalidated){ 
		         return "Signup in progress"; 
	 	      }
		   }
}