
<@resource path="/accounts/js/html5.js" />
<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
<@resource path="/accounts/js/common.js" />
<@resource path="/accounts/js/ajax.js" />
<@resource path="/accounts/js/form.js" />
<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
<@resource path="/accounts/js/validator.js" />
<@resource path="/accounts/js/confirm.js" />
<script type='text/javascript'>
	I18N.load({
		"IAM.ERROR.ENTER.LOGINPASS" : '<@i18n key="IAM.ERROR.ENTER.LOGINPASS" />',
		"IAM.REGISTER.REMOTE.IP.LOCKED" : '<@i18n key="IAM.REGISTER.REMOTE.IP.LOCKED" />',
		"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />'
	});
	Util.paramConfigure({
		"_sh" : "header1,footer,#title,#invhints"
	});
	ZAConstants.load(${za});
</script>