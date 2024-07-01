<html>
	<head>
		<#include "client_confirm_new_Static.tpl">
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
										<input id="singlepassword" placeholder="<@i18n key="IAM.ENTER.PASS"/>" name="password" type="password" class="textbox" required=""  autocapitalize="off" <#if (SCL.isPasswordAutoCompleteOff() == 'true')>autocomplete="off"<#else>autocomplete="current-password"</#if> autocorrect="off" onkeypress="clearCommonError('password')">
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
								<input id="password" placeholder="<@i18n key="IAM.ENTER.PASS"/>" name="password" type="password" class="textbox" required=""  autocapitalize="off" <#if (SCL.isPasswordAutoCompleteOff() == 'true')>autocomplete="off"<#else>autocomplete="new-password"</#if> autocorrect="off" onkeypress="clearCommonError('password');" onkeyup="validateinit();"/>
								<span class="icon-hide show_hide_password" onclick="showHidePassword('password');"></span>
								<div class="fielderror"></div>
							</div>
							<div id="cpassword_container">
								<input id="cpassword" placeholder="<@i18n key="IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER"/>" name="cpassword" type="password" class="textbox" required=""  autocapitalize="off" <#if (SCL.isPasswordAutoCompleteOff() == 'true')>autocomplete="off"<#else>autocomplete="new-password"</#if> autocorrect="off" onkeypress="clearCommonError('cpassword')"/>
								<span class="icon-hide show_hide_password" onclick="showHidePassword('cpassword');"></span>
								<div class="fielderror"></div>
							</div>
							<button class="btn blue" id="nextbtn" tabindex="2"><span class="capschar"><@i18n key="IAM.CONFIRM"/></span></button>
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