
<script src="${SCL.getStaticFilePath("/accounts/js/html5.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/common.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/ajax.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/form.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/validator.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/confirm.js")}" type="text/javascript"></script>
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