<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<title><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION" /></title>
<link  href="${SCL.getStaticFilePath("/accounts/css/common.css")}" type="text/css" rel="stylesheet" defer/>
<link  href="${SCL.getStaticFilePath("/accounts/css/form.css")}" type="text/css" rel="stylesheet" defer/>
<#if (('${zpass.css_url}')?has_content)>
	<link href="${zpass.css_url}" type="text/css" rel="stylesheet"/>
<#else>
	<link href="${SCL.getStaticFilePath("/accounts/css/addpassword.css")}" type="text/css" rel="stylesheet"/>
</#if>
<#include "client_add_password_static.tpl">
<script type="text/javascript">
$(document).ready(function() {
	$(document.passwordform).zaAddPassword({
		url : "${zpass.actionurl}"+"/pconfirm"// No I18N
	});
});
</script>
<style type="text/css">
.field-error input {
	background: none !important;
	padding-right: 0 !important;
	width: 350px !important;
	border-color: #D6D6D6 !important; 
}
.field-msg .error {
	border-radius: 0 !important;
	margin-top: 5px !important;
	background-color: transparent !important;
	border-color: transparent !important;
	padding: 0 !important;
	color: #DD4B39 !important;
}
input[type="text"], input[type="email"], input[type="password"], textarea {
	border-radius: 3px !important;

}
</style>
</head>
<body class="bodybg">
	<header>
		<div class="links">
			<a href='<@i18n key="IAM.LINK.ZOHO.HOME" />' target="_blank"><@i18n key="IAM.ZOHO.HOME" /></a>
			<#if !partner.isPartnerHideHeader>
			<#if !partner.isfujixerox>
			<a href='<@i18n key="IAM.LINK.BLOGS" />' target="_blank"><@i18n key="IAM.HEADER.BLOGS" /></a>
			<a href='<@i18n key="IAM.LINK.FORUMS" />' target="_blank"><@i18n key="IAM.HEADER.FORUMS" /></a>
			<a href='<@i18n key="IAM.LINK.FAQ" />' target="_blank"><@i18n key="IAM.HEADER.FAQ" /></a>
			</#if>
			</#if>
		</div>
		<div class="logo"></div>
		<div style="clear: both;"></div>
	</header>
	<section class="addpasswordoutersection">
		<section class="containerbox">
					<div id="title">
						<div class="head"><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION" /></div> 
						<div class="desc">
							<@i18n key="IAM.ADDPASSWORD.DESC" />
						</div>
						<div class="hrTop"></div>
					</div>
					<#if zpass.isvalidrequest>
					<div id="beforeclick" class="margin">
					<form name="passwordform" class="form" action="${zpass.actionurl}/pconfirm" method="post">
						<dl>
							<dt><@i18n key="IAM.PASSWORD" /></dt>
							<dd>
								<input type="password"  name="password">
							</dd>
						</dl>
						<dl>
							<dt><@i18n key="IAM.CONFIRM.PASS" /></dt>
							<dd>
								<input type="password" name="cpassword">
							</dd>
						</dl>
						<dl>
							<dd>
								<input type="submit" class="btn big-btn primary" value='<@i18n key="IAM.UPDATE" />' name="submit">
							</dd>
						</dl>
						<#if zpass.isppexist>
		<@i18n key="IAM.PASSWORD.POLICY.MINIMUMLENGTH" arg0="${zpass.minlen}"/><br>
		<@i18n key="IAM.PASSWORD.POLICY.MAXIMUMLENGTH" arg0="${zpass.maxlen}"/><br>
		<#if (zpass.minsplchar >0)>
		<@i18n key="IAM.PASSWORD.POLICY.MINSPECIALCHAR" arg0="${zpass.minsplchar}"/><br>
		</#if>
		<#if (zpass.minnumchar >0)>
		<@i18n key="IAM.PASSWORD.POLICY.MINNUMERICCHAR" arg0="${zpass.minnumchar}"/><br>
		</#if>
		<#if (zpass.passhistory>0)>
		<@i18n key="IAM.PASSWORD.POLICY.PASS_HISTORY" arg0="${zpass.passhistory}"/><br>
		</#if>
		<#if zpass.mixedcase>
		<@i18n key="IAM.PASSWORD.POLICY.MIXED_CASE"/><br>
		</#if>
		</#if>
					</form>
					</div>
					<#else>
					<p class="errortxt"><@i18n key="IAM.INVALID.REQUEST" /></p>
					</#if>
		</section>
	</section>
	<footer>
	<#if !partner.isPartnerHideHeader>
	<#if partner.isfujixerox>
		<a href='<@i18n key="IAM.LINK.TOS" />' target="_blank"><@i18n key="IAM.SIGNUP.TERMS.OFSERVICE" /></a>
		<a href='<@i18n key="IAM.LINK.PRIVACY" />' target="_blank"><@i18n key="IAM.PRIVACY" /></a>
		<a href='<@i18n key="IAM.CONTACT.LINK" />' target="_blank"><@i18n key="IAM.CONTACT.US" /></a>
	<#else>
		<span><@i18n key="IAM.FOOTER.COPYRIGHT" arg0="${zpass.copyrightYear}"/></span>
		<a href='<@i18n key="IAM.LINK.SECURITY" />' target="_blank"><@i18n key="IAM.MENU.SECURITY" /></a>
		<a href='<@i18n key="IAM.LINK.PRIVACY" />' target="_blank"><@i18n key="IAM.PRIVACY" /></a>
		<a href='<@i18n key="IAM.LINK.TOS" />' target="_blank"><@i18n key="IAM.SIGNUP.TERMS.OFSERVICE" /></a>
		<a href='<@i18n key="IAM.LINK.ABOUT.US" />' target="_blank"><@i18n key="IAM.ABOUT.US" /></a>
	</#if>
	</#if>
	</footer>
</body>
</html>