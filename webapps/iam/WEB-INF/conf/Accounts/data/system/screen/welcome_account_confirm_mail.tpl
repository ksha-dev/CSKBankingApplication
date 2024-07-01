<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0;">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;max-width: 700px; min-width: 300px;width:100%; border: 1px solid #eaeaea"> 
    <tr >
    <td align="left">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr border="0">
	            <td>
	                <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                	<tr>
                      		<td align="center">
                        		<a href="<@i18n key="IAM.HOME.LINK" />" style="display: block">
									<img src="cid:23abc@pc27" style="display: block;height: 60px;width: auto;"/>
								</a>
                    		</td>
                  		</tr>
                  		<tr bgcolor="#0D76D3" style="background-color:#0D76D3; background: linear-gradient(#0550B4 , #0D76D3); background-position: 1%;">
                      		<td style="font-family: 'Open Sans', 'Trebuchet MS', sans-serif; padding:5% 10%; font-size: 20px; line-height: 24px; color: #ffffff;" align="center">
                        		<b style="color: #ffffff">
                        			<@i18n key="IAM.HELLO.USERNAME" arg0="${ztpl.FIRST_NAME}"/><br>
                            		<#if ztpl.IMPORTED_USER>
										<@i18n key="IAM.MAIL.ADDED.TO.ORG.BY.ADMIN" arg0="${ztpl.ACCOUNT_NAME}" arg1="${ztpl.ADMIN_FULL_NAME}" arg2="${ztpl.ADMIN_EMAIL_ID}" />
									<#else>
										<@i18n key="IAM.MAIL.THANK.YOU.SIGN.UP"/></span>
									</#if>
								</b>
								<div style="font-size: 16px; margin-top: 16px; line-height: 20px; color: #ffffff;"><@i18n key="IAM.MAIL.WELCOME.EXPLORE"/></div>
                      		</td>
                    	</tr>
						<#if ztpl.SHOW_DIGEST_URL>
						<tr bgcolor="#0D76D3" style="background-color:#0D76D3; background: linear-gradient(#0D76D3 , #1389E3); background-position: 1%;" align="center">
							<td>
								<table style="width: 86%;" cellspacing="0" cellpadding="0">
									<tr>
										<td style="border-top-right-radius: 10px; border-top-left-radius: 10px;border: 1px solid #ddd;border-bottom: none; background-color: white;" align="center">
										<div style="font-size: 14px; line-height: 24px; margin-top: 32px; padding: 0px 5%">
										<#if ztpl.CONFIRMED_USER>
											<@i18n key="IAM.MAIL.RECEIVE.NOTIF.VERIFY" />
										<#else>
											<@i18n key="IAM.MAIL.GET.STARTED.CONFIRM"/>
										</#if>
										</div>
			                        		<a style="text-decoration:none;color: #ffffff;display: inline-block;padding: 14px 40px;font-size: 14px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;
			                        		background-color:#1389E3; border-radius: 3px; margin-top: 24px; margin-bottom: 24px;"
			                        		href="${ztpl.URL}">
			                        		<#if ztpl.CONFIRMED_USER>
			                        			<@i18n key="IAM.PROFILE.EMAIL.VERIFY.HEADING"/>
			                        		<#else>
			                        			<@i18n key="IAM.CONFIRM.ACCOUNT"/>
			                        		</#if>
			                        		</a>								
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center">
							<table style="width: 86%;" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom-right-radius:10px; border-bottom-left-radius:10px; border-bottom-right-radius:10px; padding: 20px 0px; border: 1px solid #ddd;border-top: 1px solid #ddd;
										background-color: #f6f6f6; color:#313131;" align="center">
										<i><@i18n key="IAM.MAIL.LINK.VALID.TILL" arg0="${ztpl.EXPIRY_DAYS}"/></i>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<#if ztpl.EMAIL_DETACH_URL?has_content>
		               	<tr>
                      		<td style="padding: 32px 7% 0px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
                        		 <@i18n key="IAM.MAIL.DINT.SIGNUP.LINK" arg0="${ztpl.EMAIL_DETACH_URL}" />
                      		</td>
                    	</tr>
                    	</#if>
						</#if>	
                    	<tr>
                      		<td style="padding: 32px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
                        		 <@i18n key="IAM.MAIL.QUESTIONS.ACCOUNT" arg0="${ztpl.SUPPORT_EMAIL_ID}" /> <@i18n key="IAM.MAIL.HERE.EVERY.STEP" />
                      		</td>
                    	</tr>
						<tr>
							<td style="padding: 0px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
						  		 <@i18n key="IAM.TPL.THANKS"/>,<br>
							</td>
					  	</tr>
					 	<tr>
							<td style="padding: 0px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
						  		<b><@i18n key="IAM.TPL.ZOHO.TEAM"/></b><br>
							</td>
					  	</tr>
					  	<tr>
							<td style="padding: 0px 7% 30px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;
							border-bottom: 1px solid #eaeaea;">
						  		 <a href="<@i18n key="IAM.HOME.LINK" />" style="color:#2696eb;text-decoration:none;"><@i18n key="IAM.HOME.LINK.TEXT"/></a>
							</td>
					  	</tr>
                    </table>
	            </td>
            </tr>           
        </table>
        <table> 
            <tr>
                <td style="padding:16px 10px 10px 10px;font-size: 12px;color:#333333;line-height: 22px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                      <@i18n key="${ztpl.OFFICE_ADDRESS_I18N_KEY}"/><br><@i18n key="IAM.NEW.TPL.SPAM.TEXT" arg0="${ztpl.ABUSE_ID}"/>
                </td>
            </tr>        
      	</table>
	</td>
	</tr>
</table>
</table>
</body>
</html>