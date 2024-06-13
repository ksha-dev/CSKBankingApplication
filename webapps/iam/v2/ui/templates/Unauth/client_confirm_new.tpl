<html>
	<head>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<#if (('${css_url}')?has_content)>
			<link href="${css_url}" type="text/css" rel="stylesheet"/>
		<#else>
			<link href="${SCL.getStaticFilePath("/v2/components/css/confirmnew.css")}" type="text/css" rel="stylesheet"/>
		</#if>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/accounts/js/ajax.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/confirmnew.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/accounts/js/validator.js")}" type="text/javascript"></script>
		<script type='text/javascript'>
			var isPasswordExist = parseInt("${isPasswordExist}");
			var setSameSite = "${setSameSite}";
			var redirecturl = "${redirecturl}";
			var actionurl = "${actionurl}";
			var css_url = "${css_url}";
			var isppexist = parseInt("${isppexist}");
			var showForgotPassword =  parseInt("${showForgotPassword}");
			var resetPasswordLink = "${resetPasswordLink}";
			var redirecturl="${redirecturl}";
			var passwordPolicy=${passwordPolicy};
			var loadIframe = Boolean("<#if loadIframe>true</#if>");
			var isMobile = parseInt("${isMobile}")
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
					
			});
			window.onload = function() {
				setPasswordPolicy();
				return false;
			}
		</script>
	</head>
	<body>
	<div class="confirmaccount_container">
			<#if !isValidRequest || !isValidInvitation>
				<div class="urlexpired_container">
			 		<div class="expireicon"></div>
			 		<div class="urlexpired_title"><@i18n key="IAM.PORTAL.INVALID.INVITATION.TITLE"/></div>
			 		<div class="urlexpired_desc"><@i18n key="IAM.PORTAL.INVALID.INVITATION.DESC" arg0="${adminEmailId}"/></div>
			 	</div>
			<#else>
			<#if isDigestValidated>
			 	<div class="urlexpired_container">
			 		<div class="expireicon"></div>
			 		<div class="urlexpired_title"><@i18n key="IAM.ACCOUNT.RECOVERY.ERROR.DIGEST.EXPIRED.HEADER"/></div>
			 		<div class="urlexpired_desc"><@i18n key="IAM.PORTAL.NEW.EXPIRED.DESC"/></div>
			 	</div>
			<#elseif isPasswordExist == 1>
					<#if isConfirmedEmail>
						<div class="alreadyaccepted_container">
							<div class="successicon"></div>
					 		<div class="accepted_title"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.HEADER"/></div>
					 		<div class="accepted_desc"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.DESC" arg0="${emailid}" arg1="${redirecturl}" /></div>
					 	</div>
					<#elseif !isConfirmedEmail && isPasswordVerificationRequired>
						<div class="confirmpasswordcontainer">
							<form name="confirm" id="confirm" onsubmit="javascript:return confirmpassword(this);" action="${actionurl}" method="post" novalidate >
								<div class="confirm_head">
									<div class="confirmtitle"><@i18n key="IAM.PORTAL.NEW.VERIFY.PASSWORD.HEADER"/></div>
									<div class="confirmdesc"><@i18n key="IAM.PORTAL.NEW.VERIFY.PASSWORD.DESC"/></div>
									<div class="hellouser">
										<div class="username"><span class="icon-profile"></span>${emailid}</div>
									</div>
									<div id="password_container">
										<input id="singlepassword" placeholder="<@i18n key="IAM.ENTER.PASS"/>" name="password" type="password" class="textbox" required=""  autocapitalize="off" autocomplete="password" autocorrect="off" onkeypress="clearCommonError('password')">
										<span class="icon-hide show_hide_password" onclick="showHidePassword('singlepassword');"></span>
										<div class="fielderror"></div>
									</div>
									<button class="btn blue" id="nextbtn" tabindex="2"><span class="capschar"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
									<#if showForgotPassword ==1>
										<div class="text16 pointer" id="forgotpassword"><a class="text16" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></a></div>
									</#if>
								</div>
							</form>
						</div>
					<#else>
						<div class="account_verified_container">
							<div class="successicon"></div>
					 		<div class="accepted_title"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.HEADER"/></div>
					 		<div class="accepted_desc"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.DESC" arg0="${emailid}" arg1="${redirecturl}" /></div>
					 	</div>
						
					</#if>
			<#else>
				<div class="confirmpasswordcontainer">
					<form name="confirm" id="confirm" onsubmit="javascript:return addpassword(this);" action="${actionurl}" method="post" novalidate >
						<div class="confirm_head">
							<div class="confirmtitle"><@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.HEADER"/></div>
							<div class="confirmdesc"><@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.DESC"/></div>
							<div class="hellouser">
								<div class="username"><span class="icon-profile"></span>${emailid}</div>
							</div>
							<div id="password_container">
								<div class=passwordpolicy></div>
								<input id="password" placeholder="<@i18n key="IAM.ENTER.PASS"/>" name="password" type="password" class="textbox" required=""  autocapitalize="off" autocomplete="password" autocorrect="off" onkeypress="clearCommonError('password');" onkeyup="validatePasswordPolicy()" onfocus="showPasswordHint()" onfocusout="hidePasswordHint()"/>
								<span class="icon-hide show_hide_password" onclick="showHidePassword('password');"></span>
								<div class="fielderror"></div>
							</div>
							<div id="cpassword_container">
								<input id="cpassword" placeholder="<@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER"/>" name="cpassword" type="password" class="textbox" required=""  autocapitalize="off" autocomplete="password" autocorrect="off" onkeypress="clearCommonError('cpassword')"/>
								<span class="icon-hide show_hide_password" onclick="showHidePassword('cpassword');"></span>
								<div class="fielderror"></div>
							</div>
							<button class="btn blue" id="nextbtn" tabindex="2" onclick="validateFinal();" onkeypress="validateFinal();" disabled><span class="capschar"><@i18n key="IAM.CONFIRM"/></span></button>
						</div>
					</form>
				</div>
			</#if>
		</div>
		<div class="success_container">
			<div class="account_verified_container">
							<div class="successicon"></div>
					 		<div class="accepted_title"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.HEADER"/></div>
					 		<div class="accepted_desc"><@i18n key="IAM.PORTAL.NEW.ACCEPTED.DESC" arg0="${emailid}" arg1="${redirecturl}" /></div>
			</div>
		</div>
		</#if>
	</body>
</html>