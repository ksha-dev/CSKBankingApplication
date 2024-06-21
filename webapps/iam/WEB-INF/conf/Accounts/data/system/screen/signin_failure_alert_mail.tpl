<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0;">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;max-width: 700px; min-width: 320px;width:100%;">
    <tr>
    <td align="left" style="padding:2% 2% 2% 0;">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr border="0">
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                    <td>
	                    <a href="<@i18n key="IAM.ALERT.SUSPICIOUS.HOME.LINK" arg0="${ztpl.SERVICE}"/>" style="display:inline-block;"><img src="cid:23abc@pc27" style="display: block;height: 60px;width: auto;" /></a>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:24px 0 0 12px;font-size: 16px;line-height: 18px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<div style="border: 1px solid #FEDD96; background-color:#FFFAF0; border-radius: 5px; padding: 16px 20px">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="width: 32px">
										<div style="border-radius:50%; background-color:#E69200; color:white; width:24px; padding:3px 0px; text-align: center">!</div>
									</td>
									<td>
										<@i18n key="IAM.MAIL.SINGIN.FAILURE.WARN"/>
                    				</td>
                    			</tr>
                    		</table>
                    	</div>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:34px 0 0 12px;font-size: 16px;line-height: 18px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		               <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:14px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    	<#if ztpl.ERROR_CODE == "IN102">
                        	<@i18n key="IAM.MAIL.SINGIN.FAILURE.DESC1.PASS" arg0="${ztpl.EMAIL_ID}"/>
                    	<#elseif ztpl.ERROR_CODE == "U404">
                        	<@i18n key="IAM.MAIL.SINGIN.FAILURE.DESC1.IP" arg0="${ztpl.EMAIL_ID}"/>
                    	<#else>
                        	<@i18n key="IAM.MAIL.SINGIN.FAILURE.DESC1.GEO" arg0="${ztpl.EMAIL_ID}"/>
                    	</#if>
                    </td>
                    </tr>
                    <tr>
					<td style="padding:32px 0 0 12px;font-size: 14px;line-height: 16px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b><@i18n key="IAM.MAIL.SINGIN.FAILURE.DETAILS"/></b>
					</td>
					</tr>
                    <tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.ALERT.SHOW.DEVICE"/></b> ${ztpl.DEVICE}
					</td>
					</tr>
					<tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.LOGINHISTORY.BROWSERAGENT.APP"/></b> ${ztpl.BROWSER}
					</td>
					</tr>
					<tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.TIME"/></b> ${ztpl.TIME}
					</td>
					</tr>
                    <tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.ALERT.SHOW.REGION"/></b> ${ztpl.LOCATION}
						<br>
					<#if !(ztpl.CONSUMER_PRIVACY?has_content)>
						<span style="color:#666;font-size:12px;display:inline-block;"><@i18n key="IAM.SIGNIN.ALERT.IPADDRESS.INFO" args0="${ztpl.IP_ADDRESS}"/></span>
					</td>
					</tr>
					<#else>
					</td>
					</tr>
					<tr>
                        <td style="padding: 20px 0 0 12px">
                          <tr>
                            <td style="border: 1px solid #fdcc60;border-radius:5px;background-color: #fffaf0;background-repeat: no-repeat;font-size: 14px;line-height: 24px;font-family: 'Open Sans', 'Trebuchet MS', sans-serif;padding: 20px;">
                              <@i18n key="IAM.MAIL.RELAY.ALERT.DESC1" arg0="${ztpl.IP_ADDRESS}" arg1="${ztpl.CONSUMER_PRIVACY}"/> <@i18n key="IAM.MAIL.RELAY.ALERT.DESC2" arg0="${ztpl.CONSUMER_PRIVACY}"/>
                              <a href="${ztpl.CPN_HELP_DOC}" style="color: #0091ff; text-decoration: none" target="_blank"><@i18n key="IAM.LEARN.LINK" /></a>
                            </td>
                          </tr>
                        </td>
                    </tr>
                    </#if>
					<tr>
					<td style="padding:32px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.MAIL.SINGIN.FAILURE.DESC2" arg0="${ztpl.ACTIVE_SESSIONS_PAGE}"/>
					</td>
					</tr>
					<tr>
					<td style="padding:32px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.NEW.ALERT.SUSPICIOUS.SUPPORT.MSG" args0="${ztpl.CONTACT_ID}"/>
					</td>
					</tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.NEW.TPL.REGARDS"/>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                         <@i18n key="IAM.NEW.TPL.ZOHO.TEAM"/><br>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<a href="<@i18n key="IAM.HOME.LINK" />" style="color:#0091FF; text-decoration:none;"><@i18n key="IAM.NEW.HOME.LINK.TEXT"/></a>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:32px 0 0 12px;">
                    	<div style="border-bottom: 3px solid #E69200;">
                        <img src="<@image cid="23abc@pc29" img_path="${ztpl.IMG_PATH}/zohoRegionLogo.gif" />" style="display: block;width: 100%;height: auto !important;" />
                    	</div>
                    </td>
                    </tr>
                </table>
            </td>
            </tr>
        </table>
        <table>
            <tr>	
                <td style="padding:10px 0 10px 12px;font-size: 12px;color:#333333;line-height: 22px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                      <@i18n key="${ztpl.OFFICE_ADDRESS_I18N_KEY}"/><br><@i18n key="IAM.NEW.TPL.SPAM.TEXT" args0="${ztpl.ABUSE_ID}"/>
                </td>
            </tr>
        </table>
    </td>
    </tr>
</table>
</table>
</body>
</html>