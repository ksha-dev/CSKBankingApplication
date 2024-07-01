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
                        			<@i18n key="IAM.HELLO.USERNAME" arg0="${ztpl.FIRST_NAME}"/>
								</b>
								<div style="font-size: 16px; margin-top: 16px; line-height: 20px; color: #ffffff;"><@i18n key="IAM.MAIL.WELCOME.EXPLORE"/></div>
                      		</td>
                    	</tr>
                    	<#if ztpl.ACCOUNT_NAME?has_content>
						<tr bgcolor="#0D76D3" style="background-color:#0D76D3; background: linear-gradient(#0D76D3 , #1389E3); background-position: 1%;" align="center">
							<td>
								<table style="width: 86%;" cellspacing="0" cellpadding="0">
									<tr>
										<td style="border-top-right-radius: 10px; border-top-left-radius: 10px;border: 1px solid #ddd;border-bottom: none; background-color: white;" align="center">
										<div style="font-size: 16px; line-height: 20px; margin-top: 24px; padding: 0px 5%; font-weight: 600">
											<@i18n key="IAM.ORG.DETAILS" />
										</div>									
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-bottom: 24px">
							<table style="width: 86%;" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border-bottom-right-radius:10px; border-bottom-left-radius:10px; border-bottom-right-radius:10px; padding: 20px 30px 24px 30px; border: 1px solid #ddd;border-top: 0px;
										color:#313131;" align="center">
										<div style="width: 100%; margin-right:3%;vertical-align: top;display: inline-block;max-width: 256px;margin-bottom: 10px;">
											<div style="width: 24px; max-height: 24px; display: inline-block; margin-right: 8px;vertical-align: top;">
		                        				<img src="<@image cid="23abc@pc29" img_path="${ztpl.IMG_PATH}/mailorg.png" />" style="display: block;width: 24px;height: 24px" />	
											</div>
											<div style="display: inline-block; text-align: left; max-width: 220px;">
												<div style="margin-bottom:4px; opacity: 0.6; font-size:10px; max-width: 220px;"> <@i18n key="IAM.ORGANIZATION.NAME" /> </div>
												<div style="font-size:12px; font-weight:500; word-break: break-all; max-width: 220px;">${ztpl.ACCOUNT_NAME}</div>
											</div>
										</div>
										<div style="width: 100%;vertical-align: top;display: inline-block;max-width: 256px;">
											<div style="width: 24px; max-height: 24px;display: inline-block;margin-right: 8px;vertical-align: top;" >
		                        				<img src="<@image cid="23abc@pc30" img_path="${ztpl.IMG_PATH}/mailinvited.png" />" style="display: block;width: 24px;height: 24px;" />			
											</div>
											<div style="display: inline-block; text-align: left; max-width: 220px;">
												<div style="margin-bottom:4px; opacity: 0.6; font-size:10px; max-width: 220px;"> <@i18n key="IAM.ORG.INVITED.BY" arg0="" /> </div>
												<div style="font-size:12px; font-weight:500; word-break: break-all; max-width: 220px;"><a style="color:rgb(0,0,0); text-decoration: none;">${ztpl.ADMIN_EMAIL_ID}</a></div>
											</div>
										</div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						</#if>
						<#if ztpl.ACCOUNT_NAME?has_content>
						<tr style="background-position: 1%;" align="center">
						<#else>
						<tr bgcolor="#0D76D3" style="background-color:#0D76D3; background: linear-gradient(#0D76D3 , #1389E3); background-position: 1%;" align="center">						
						</#if>
							<td>
								<table style="width: 86%;" cellspacing="0" cellpadding="0">
									<tr>
										<td style="border-top-right-radius: 10px; border-top-left-radius: 10px;border: 1px solid #ddd;border-bottom: none; background-color: white;" align="center">
										<div style="font-size: 14px; line-height: 24px; margin-top: 32px; padding: 0px 5%">
											<@i18n key="IAM.GET.STARTED.ACCESS" arg0="${ztpl.APP_NAME}"/>
										</div>
										<a style="text-decoration:none;color: #ffffff;display: inline-block;padding: 14px 40px;font-size: 14px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;
			                        		background-color:#1389E3; border-radius: 3px; margin-top: 24px; margin-bottom: 24px;"
			                        		href="${ztpl.URL}">
			                        			<@i18n key="IAM.ACCESS" arg0="${ztpl.APP_NAME}"/>
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
                    	<tr>
                      		<td style="padding: 32px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
                        		 <@i18n key="IAM.MAIL.QUESTIONS.ACCOUNT" arg0="${ztpl.SUPPORT_EMAIL_ID}" /> <@i18n key="IAM.MAIL.HERE.EVERY.STEP" />
                      		</td>
                    	</tr>
						<tr>
							<td style="padding: 0px 7%; font-size: 14px; line-height: 24px; font-family: 'Open Sans', 'Trebuchet MS', sans-serif;">
						  		 <@i18n key="IAM.TPL.CHEERS"/><br>
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