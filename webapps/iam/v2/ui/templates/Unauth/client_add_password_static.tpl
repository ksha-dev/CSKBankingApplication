
<script src="${SCL.getStaticFilePath("/accounts/js/html5.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/tplibs/password_strength.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/common.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/ajax.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/form.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/validator.js")}" type="text/javascript"></script>
<script src="${SCL.getStaticFilePath("/accounts/js/addpassword.js")}" type="text/javascript"></script>

<script type="text/javascript">
var userPasswordMinLen = ${zpass.minlen};
var userPasswordMaxLen = ${zpass.maxlen};
	Util.paramConfigure({
		"_sh" : "header,footer,#title",
		"_embed" : {
			".containerbox" : {
				style : "width: 100%; height: 100%; margin: 0px;border: none;box-shadow:none;padding:0px;"
			},
			".addpasswordoutersection" : {
				style : "width: 100%;margin: 0 auto;"
			},
			".addpasswordcontainer" : {
				style : "margin: 0;"
			},
			".bodybg":{
            	style:"background:none repeat scroll 0 0 #FFFFFF !important;"
            },
            ".btn":{
        		'class':"btn"
        	}
		}
	});
	I18N.load({
		"IAM.ERROR.ENTER.LOGINPASS" : '<@i18n key="IAM.ERROR.ENTER.LOGINPASS" />',
		"IAM.ERROR.PASS.LEN" : '<@i18n key="IAM.ERROR.PASS.LEN" arg="${userPassword.minlen}" />',
		"IAM.ERROR.PASSWORD.MAXLEN" : '<@i18n key="IAM.ERROR.PASSWORD.MAXLEN" arg="${userPassword.maxlen}" />',
		"IAM.PASSWORD.POLICY.LOGINNAME" : '<@i18n key="IAM.PASSWORD.POLICY.LOGINNAME" />',
		"IAM.ERROR.WRONG.CONFIRMPASS" : '<@i18n key="IAM.ERROR.WRONG.CONFIRMPASS" />',
		"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL" />',
		"IAM.ERROR.EMAIL.EXISTS" : '<@i18n key="IAM.ERROR.EMAIL.EXISTS" />',
		"IAM.INVALID.INVITATION" : '<@i18n key="IAM.INVALID.INVITATION" />',
		"IAM.INVALID.REQUEST" : '<@i18n key="IAM.INVALID.REQUEST" />'
	});
	ZAConstants.load(${za});
</script>
