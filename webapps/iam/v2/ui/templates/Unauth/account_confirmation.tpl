<html>

	<head>
		<#if isUserConfirmed == "true">
		<title><@i18n key="IAM.EMAIL.VERIFICATION" /></title>
		<#else>
		<title><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION" /></title>
		</#if>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}"></script>	
		<script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script> 
		<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script> 
		<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/accountUnauthStyle.css")}" rel="stylesheet"type="text/css"/>
		
		<script type="text/javascript">
			var redirectUrl = "${redirectUrl}";
			<#if !((error_code)?has_content)>
				var passwordPolicy = '${passwordPolicy}';
				var digest ="${digest}";
				var isMobile = Boolean("<#if is_mobile>true</#if>");
				var hasPassword = ${hasPassword};
				var isPasswordRequired = ${isPasswordRequired};
				var LOGIN_ID = "${emailId}";
				var resetPassUrl = "${resetPassUrl}";
				var current_pass_err = '<@i18n key="IAM.ERROR.ENTER_PASS"/>';
				var new_pass_err = '<@i18n key="IAM.ERROR.ENTER.NEW.PASSWORD"/>';
				var valid_pass_err = '<@i18n key="IAM.PASSWORD.INVALID.POLICY"/>';
				var password_mismatch_err = '<@i18n key="IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS"/>';
				var network_common_err = '<@i18n key="IAM.ERROR.GENERAL"/>'
				var reenter_err = '<@i18n key="IAM.REENTER.PASSWORD"/>';
				var enter_valid_pass = '<@i18n key="IAM.AC.NEW.PASSWORD.EMPTY.ERROR"/>';
				if(passwordPolicy!=""){
					PasswordPolicy.data = JSON.parse(passwordPolicy);
					var mixed_case='${passwordPolicy.mixed_case?c}';
					var	min_spl_chars='${passwordPolicy.min_spl_chars}';
					var	min_numeric_chars='${passwordPolicy.min_numeric_chars}';
					var	min_length='${passwordPolicy.min_length}';
				}
				I18N.load
				({
					"IAM.PASSWORD.POLICY.HEADING" : '<@i18n key="IAM.PASSWORD.POLICY.HEADING" />',
					"IAM.RESETPASS.PASSWORD.MIN" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN" />',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH" />',
					"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" />',
					"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" />',
					"IAM.PASS_POLICY.CASE" : '<@i18n key="IAM.PASS_POLICY.CASE" />',
					"IAM.INCLUDE" : '<@i18n key="IAM.INCLUDE" />',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH" />',
					"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
					"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
					"IAM.PASS_POLICY.SPL" : '<@i18n key="IAM.PASS_POLICY.SPL" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PASS_POLICY.NUM" : '<@i18n key="IAM.PASS_POLICY.NUM" />',
					"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />'
				});
			</#if>
		</script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/account_confirmation.js")}"></script>
		
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		
	</head>
	<body class="new_acc_confirm_bg">
		<div id="error_space">
			<div class="top_div">
				<span class="cross_mark"> <span class="crossline1"></span> <span
					class="crossline2"></span>
				</span> <span class="top_msg"></span>
			</div>
		</div>
		<div class="blur"></div>
		<div style="overflow:auto">
		
			<#if ((error_code)?has_content)>
			<div class="container centerContainer">			
			<#if (error_code == ErrorCode.DIGEST_ALREADY_VALIDATED)>
				<div class="header " id="header">			
			<#else>
				<div class="header error_header" id="header">
			</#if>
					<img class="zoho_logo" src="${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}"/>

					<#if (error_code == ErrorCode.DIGEST_ALREADY_VALIDATED)>
					<div class="page_type_indicator icon-tick"></div>
					<#else>
					<div class="page_type_indicator icon-invalid"></div>
					</#if>
				</div>
				
				<div class="wrap normal_text">
					<div class="info">
	    										
						<#if error_code == ErrorCode.DIGEST_ALREADY_VALIDATED>
						
							<div class="head_text"><@i18n key="IAM.EMAIL.ALREADYCONFIRM.TITLE"/></div>
							<div class="description"><@i18n key="IAM.ACCOUNTCONFIRM.ALREADYCONFIRMED.DESC" arg0="${emailId}"/></div>
							<button class="btn green_btn center_btn" onclick="redirectLink(redirectUrl,this)"><@i18n key="IAM.CONTINUE"/></button>
						
						<#else>
						
							<div class="head_text"><@i18n key="IAM.ACCOUNTCONFIRM.URLINVALID"/></div>
							<div class="description"><@i18n key="IAM.ERROR.INVALID.URL.DESC"/></div>
						
						</#if>
	    			</div>
	    		</div>
			</div>
    		<#else>
			<div class="acc_confirm_illustration"></div>
				<div class="container" id="account_confirmation">
    				<div class="header" id="header">
    					<img class="zoho_logo" src="${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}">  
    				</div>
	    			<div class="wrap">  
	    				<div class="info">
	    				<#if isUserConfirmed == "true">
	    				<div class="head_text"><@i18n key="IAM.PROFILE.EMAIL.VERIFY.HEADING"/></div>
	    				<#else>
						<div class="head_text"><@i18n key="IAM.REGISTER.ACCOUNT.CONFIRMATION"/></div>
						</#if>
							<form name="confirm_form" class="" novalidate onsubmit="return false;" id="acc_confirm_form">
		    					
		    					<#if hasPassword == "false">
		    							<div class="description"><@i18n key="IAM.ACCOUNTCONFIRM.PASSWORD.CREATE" arg0="${emailId}"/></div>
										<div class="textbox_div error_space_card" id="password_field">
											<input name="password" class="real_textbox" tabindex="1" id="passs_input"  onkeypress="err_remove()" onkeyup="check_pp(mixed_case, min_spl_chars, min_numeric_chars, min_length, '#acc_confirm_form', '#passs_input')" autocomplete="off" required="" type="password" />
											<label class="textbox_label" for="password"><@i18n key="IAM.PASSWORD" /></label>
										</div>
										<div class="textbox_div error_space_card" id="password_field">
											<input name="password" class="real_textbox" tabindex="1" id="confirm_pass_input"  onkeypress="err_remove()" autocomplete="off" required="" type="password" />
											<label class="textbox_label" for="password"><@i18n key="IAM.CONFIRM.PASS" /></label>
										</div>
			                	<#elseif isPasswordRequired == "true">
			                			<#if isUserConfirmed == "true">
			                			<div class="description"><@i18n key="IAM.EMAILCONFIRM.PASSWORD.ENTER" arg0="${emailId}"/></div>
			                			<#else>
										<div class="description"><@i18n key="IAM.ACCOUNTCONFIRM.PASSWORD.ENTER" arg0="${emailId}"/></div>
										</#if>
											<div class="textbox_div error_space_card" id="password_field">
											<input name="password" class="real_textbox" tabindex="1" id="confirm_pass_input"  onkeypress="err_remove()" autocomplete="off" required="" type="password" />
											<label class="textbox_label" for="password"><@i18n key="IAM.PASSWORD" /></label>
											<div class="textbox_icon icon2-hide" onclick="show_hide_password()"></div>
										</div>
										<div id="forgot_password" onclick="goToForgotPassword()"><@i18n key="IAM.FORGOT.PASSWORD" /></div>
			                	<#else>
		    						<#if isUserConfirmed == "true">
		    						<div class="description"><@i18n key="IAM.ACCOUNTCONFIRM.VERIFY.TEXT" arg0="${emailId}"/></div>
		    						<#else>
		    						<div class="description"><@i18n key="IAM.ACCOUNTCONFIRM.EMAIL.VERIFY.TEXT" arg0="${emailId}"/></div>
		    						</#if>
	    							<div class="textbox_div" style="margin-top:0px;"></div>
		    					</#if>
		    					<div class="tos_consent">
									<span class="note p0"><@i18n key="IAM.PARTNER.INVITATION.TOS.PRIVACY.TEXT" arg0="${tos_link}" arg1="${privacy_link}"/></span>
								</div>
								<button id="accountconfirm" class="btn green_btn" name="confirm_btn" onclick="confirmAccount()"><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
	    					</form>
	    				</div>
	    			</div>
					<div id="result_popup" class="hide result_popup">
						<div class="success_icon icon-tick"></div>
						<#if isUserConfirmed == "true">
						<div class="grn_text"><@i18n key="IAM.CONFIRMATION.SUCCESS.VERIFIED.EMAIL"/></div>
						<div class="defin_text"><@i18n key="IAM.EMAILCONFIRM.VERIFIED.TEXT" arg0="${emailId}"/></div>
						<#else>
						<div class="grn_text"><@i18n key="IAM.CONFIRMATION.SUCCESS.VERIFIED.HEAD"/></div>
						<div class="defin_text"><@i18n key="IAM.ACCOUNTCONFIRM.VERIFIED.TEXT" arg0="${emailId}"/></div>
						</#if>
						<button class="btn green_btn center_btn" onclick="redirectLink(redirectUrl,this)"><@i18n key="IAM.CONFIRMATION.CONTINUE_ACCOUNT"/></button>
					</div>	
    			</#if>
		</div>
		<#include "footer.tpl">
	</body>
	<script>
		window.onload=function() {
			try 
			{
    			URI.options.contextpath="${za.contextpath}/webclient/v1";//No I18N
				URI.options.csrfParam = "${za.csrf_paramName}";
				URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
			}catch(e){}

		}
		$.ready = function(){
		if(!hasPassword){
			show_pass_policy();
		}
		}
	</script>
</html>