<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
	<head>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
		<link  href="${SCL.getStaticFilePath("/accounts/css/common.css")}" type="text/css" rel="stylesheet" defer/>
	    <link  href="${SCL.getStaticFilePath("/accounts/css/form.css")}" type="text/css" rel="stylesheet" defer/>
	    <#if (('${css_url}')?has_content)>
			<link href="${css_url}" type="text/css" rel="stylesheet"/>
		<#else>
			<link href="${SCL.getStaticFilePath("/accounts/css/confirm.css")}" type="text/css" rel="stylesheet"/>
		</#if>
		<#include "client_confirm_static.tpl">
	</head>
	<body>
    	<table width="100%" height="90%" align="center" cellpadding="0" cellspacing="0">
    		<tr><td valign="top" align="center">
    			<div class="mainbodydiv">
					<#if isConfirmedEmail>
						<div class="title-1"><@i18n key="IAM.EMAIL.ALREADYCONFIRM.TITLE"/></div>
    				<#else>
						<div class="title-1"><@i18n key="IAM.EMAILCONFIRM.TITLE"/></div>
    				</#if>
					<div class="bdre2"></div>					
					<#if isConfirmedEmail>
					<div id="msgboard">
	    				<div class="successicon">&nbsp;</div>
	    				<div class="emailconfirmtxt"><@i18n key="IAM.EMAIL.ALREADYCONFIRM.TITLE"/></div>
	  				</div>
    				<#elseif !isValidDigest>
    				<div id="msgboard">
	    				<div class="erroricon">&nbsp;</div>
	    				<div class="expiredtxt"><@i18n key="IAM.EMAILCONFIRM.LINK.EXPIRED"/></div>
					</div>
					<#elseif isPasswordRequired>
					<div id="confirmpassword">
						<form name="confirmationform" class="form" action="${za.contextpath}/secureconfirm.ac" method="post">
							<div class="label">
		    					<div class="inlineLabel"><@i18n key="IAM.EMAIL.PRIMARY.EMAIL"/> </div>
		    					<div class="inputText">${emailId}</div>
							</div>
							<div class="label">
		    				<div class="inlineLabel"><@i18n key="IAM.LABEL.ENTER.ZOHO.PASSWORD"/> </div>
								<input type="password" name="password" class="unauthinputText" style="width: 300px;" onkeypress="hideMsg(this);">
								<a href="${reset_password_link}" class="forgoticon"></a>
							</div>
							<div class="label">
		    					<div class="inlineLabel">&nbsp;</div>
		    					<input type="submit" value="<@i18n key="IAM.CONFIRM"/>" class="redBtn">
							</div>
						</form>
					</div>
					<div id="msgboard" class="hide">
	    				<div class="successicon">&nbsp;</div>
	    				<div class="emailconfirmtxt"><@i18n key="IAM.EMAIL.ALREADYCONFIRM.TITLE"/>&nbsp;</div>
	  				</div>
					<#else>
					<div id="msgboard">
	    				<div class="successicon">&nbsp;</div>
	    				<div class="emailconfirmtxt"><@i18n key="IAM.CLIENTPORTAL.EMAILCONFIRM.SUCCESS" arg0="${emailId}"/>&nbsp;</div>
	  				</div>
	    			</#if>
				</div>
    		</td></tr>
			<tr><td valign="bottom">
			</td></tr>
    	</table>
    	<#if isPasswordRequired>
		<script type="text/javascript">
			$(document).ready(function() {
				$(document.body).css("visibility", "visible");
				$(document.confirmationform).zaConfirmation();
	    		document.confirmationform.password.focus();
			});
		</script>
		</#if>
    </body>
</html>
