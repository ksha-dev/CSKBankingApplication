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
                    <td style="padding:8px 0 0 12px;font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		               <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                         <@i18n key="IAM.NEW.ALERT.SUSPICIOUS.LOGIN.DETECTED" arg0="${ztpl.EMAIL_ID}" arg1="${ztpl.LOGIN_TIME}"/>
                    </td>
                    </tr>
                    <tr>
					<td style="padding:10px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.DEVICE"/></b> ${ztpl.DEVICE}
					</td>
					</tr>
					<tr>
					<td style="padding:10px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.LOGINHISTORY.BROWSERAGENT.APP"/></b> ${ztpl.BROWSER}
					</td>
					</tr>
                    <tr>
					<td style="padding:10px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<b style="width:80px;display:inline-table;"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION"/></b> ${ztpl.LOCATION}
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
                              <a href="${ztpl.CPN_HELP_DOC}" style="color: #0091ff; text-decoration: none" target="_blank"><@i18n key="IAM.TFA.LEARN.MORE" /></a>
                            </td>
                          </tr>
                        </td>
                    </tr>
                    </#if>
					<tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.NEW.ALERT.SUSPICIOUS.CHECK.ACTIVITY" args0="${ztpl.RESET_PWD_URL}"/>
					</td>
					</tr>
					<tr>
					<td style="padding:0px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.NEW.ALERT.SUSPICIOUS.SUPPORT.MSG" args0="${ztpl.CONTACT_ID}"/>
					</td>
					</tr>
					<tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.NEW.ALERT.SUSPICIOUS.LEARN.MORE" args0="${ztpl.LEARN_MORE_URL}"/>
					</td>
					</tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.NEW.TPL.REGARDS"/>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                         <b><@i18n key="IAM.ALERT.TEAM" arg0="${ztpl.SERVICE_NAME}"/></b><br>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0px 0 0px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                	<a href="<@i18n key="IAM.ALERT.SUSPICIOUS.HOME.LINK" arg0="${ztpl.SERVICE}"/>" style="color:#0091FF;text-decoration:none;"><@i18n key="IAM.ALERT.SUSPICIOUS.HOME.LINK.TEXT" arg0="${ztpl.SERVICE}"/></a>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0 0 0 12px;">
                    	<div style="border-bottom: 3px solid #339e72;">
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