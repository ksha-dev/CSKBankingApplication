	
	<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
		<@resource path="/v2/components/css/${customized_lang_font}"/>
		<#if (('${css_url}')?has_content)>
			<link href="${css_url}" type="text/css" rel="stylesheet"/>
		<#else>
			<@resource path="/v2/components/css/confirmnew.css" />
		</#if>
		<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
		<@resource path="/accounts/js/ajax.js" />
		<@resource path="/v2/components/js/confirmnew.js" />
		<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
		<@resource path="/accounts/js/validator.js" />
		<script type="text/javascript" src="${actionurlprefix}/encryption/script"></script>
		<@resource path="/v2/components/js/security.js" />
		<script type='text/javascript'>
			var isPasswordExist = parseInt("${isPasswordExist}");
			var setSameSite = "${setSameSite}";
			var redirecturl = "${redirecturl}";
			var actionurl = "${actionurlprefix}/pconfirm";
			var css_url = "${css_url}";
			var isppexist = parseInt("${isppexist}");
			var showForgotPassword =  parseInt("${showForgotPassword}");
			var resetPasswordLink = "${resetPasswordLink}";
			var redirecturl="${redirecturl}";
			var passwordPolicy=${passwordPolicy};
			var loadIframe = Boolean("<#if loadIframe>true</#if>");
			var isMobile = parseInt("${isMobile}");
			var emailid = "${emailid}";
			I18N.load({
					"IAM.ERROR.PASSWORD.INVALID" : '<@i18n key="IAM.ERROR.PASSWORD.INVALID" />',
					"IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.INVALID" : '<@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.INVALID" />',
					"IAM.ERROR.PASSWORD.MAXLEN" : '<@i18n key="IAM.ERROR.PASSWORD.MAXLEN" />',
					"IAM.INVALID.REQUEST" : '<@i18n key="IAM.INVALID.REQUEST" />',
					"IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.NOTMATCH" :'<@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.NOTMATCH" />',
					"IAM.ERROR.PASS.LEN":'<@i18n key="IAM.ERROR.PASS.LEN"/>',
					"IAM.PORTAL.CONFIRM.MINIMUM.MIXEDCASE":'<@i18n key="IAM.PORTAL.CONFIRM.MINIMUM.MIXEDCASE"/>',
					"IAM.PASS_POLICY.NUM_SING":'<@i18n key="IAM.PASS_POLICY.NUM_SING"/>',
					"IAM.PASS_POLICY.SPL_SING":'<@i18n key="IAM.PASS_POLICY.SPL_SING"/>',
					"IAM.PORTAL.CONFIRM.MINIMUM.PASSLEN":'<@i18n key="IAM.PORTAL.CONFIRM.MINIMUM.PASSLEN"/>',
					"IAM.PASS_POLICY.HEADING":'<@i18n key="IAM.PASS_POLICY.HEADING"/>',
					"IAM.PORTAL.CONFIRM.MAXIMUM.PASSLEN":'<@i18n key="IAM.PORTAL.CONFIRM.MAXIMUM.PASSLEN"/>',
					"IAM.PASS_POLICY.NUM":'<@i18n key="IAM.PASS_POLICY.NUM"/>',
					"IAM.PASS_POLICY.SPL":'<@i18n key="IAM.PASS_POLICY.SPL"/>', 
					"IAM.PASSWORD.POLICY.LOGINNAME" : '<@i18n key="IAM.PASSWORD.POLICY.LOGINNAME"/>',
					
			});
			window.onload = function() {
				validateinit();
				$("input[name=password]").focus();
				return false;
			}
		</script>