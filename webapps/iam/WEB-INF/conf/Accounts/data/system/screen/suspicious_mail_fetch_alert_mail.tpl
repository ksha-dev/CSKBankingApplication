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
                        <a href="<@i18n key="IAM.HOME.LINK" />" style="display:inline-block;"><img src="cid:23abc@pc27" style="display: block;height: 60px;width: auto;" /></a>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:8px 0 0 12px;font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    	<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                    	<#if ztpl.IS_MAIL_CLIENT>
                    		<@i18n key="IAM.FETCH.MAIL.ALERT.TITLE" arg0="${ztpl.PROTOCOL}" arg1="${ztpl.EMAIL_ID}" arg2="${ztpl.LOGIN_TIME}"/>
                		<#else>
                			<@i18n key="IAM.THIRDPARTY.APP.ALERT.TITLE" arg0="${ztpl.PROTOCOL}" arg1="${ztpl.EMAIL_ID}" arg2="${ztpl.LOGIN_TIME}"/>
                     	</#if>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                         <b style="color:#000;width:80px;display:inline-table;"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION"/></b> ${ztpl.LOCATION}
                         <br>
						<#if !(ztpl.CONSUMER_PRIVACY?has_content)>
						<span style="color:#666;font-size:12px;display:inline-block;margin-left:84px"><@i18n key="IAM.SIGNIN.ALERT.IPADDRESS.INFO" arg0="${ztpl.IP_ADDRESS}"/></span>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.MAIL.THIRD.PARTY.GENERAL.DESC1" /> <@i18n key="IAM.MAIL.THIRD.PARTY.GENERAL.DESC2" arg0="${ztpl.LEARN_MORE_URL}" /> <@i18n key="IAM.MAIL.THIRD.PARTY.GENERAL.DESC3" />
                    </td>
                    </tr>
						<#else>
					</td>
                    </tr>
                    <tr>
                        <td style="padding: 10px 0 0 12px">
                          <tr>
                            <td style="border: 1px solid #fdcc60;border-radius:5px;background-color: #fffaf0;background-repeat: no-repeat;font-size: 14px;line-height: 24px;font-family: 'Open Sans', 'Trebuchet MS', sans-serif;padding: 20px;">
                              <@i18n key="IAM.MAIL.RELAY.ALERT.DESC1" arg0="${ztpl.IP_ADDRESS}" arg1="${ztpl.CONSUMER_PRIVACY}"/> <@i18n key="IAM.MAIL.RELAY.ALERT.DESC2" arg0="${ztpl.CONSUMER_PRIVACY}"; />
                              <a href="${ztpl.CPN_HELP_DOC}" style="color: #0091ff; text-decoration: none" target="_blank"><@i18n key="IAM.TFA.LEARN.MORE" /></a>
                            </td>
                          </tr>
                        </td>
                    </tr>
						</#if>
	                <tr>
	                <td style="padding:30px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                	<b><@i18n key="IAM.MAIL.THIRD.PARTY.STILL.CONCERNED" /></b>
	                </td>
	                </tr>
	                <tr>
	                <td style="padding:0px 0 0px 12px;font-size: 14px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                	<ul style="padding-inline-start:20px;line-height:20px">
	                	<li >
						<#if !ztpl.IS_APP_PWD><a href="${ztpl.RESET_PWD_URL}" style="color:#0091FF;text-decoration:none;" target="_blank"><@i18n key="IAM.NEW.EMAIL.CHANGE.PASSWORD.OTP.SUBJECT"/>.</a> <#else> <@i18n key="IAM.MAIL.THIRD.PARTY.GENERATE.NEW.APP" arg0="${ztpl.APP_PWD_URL}"/></#if>
						</li>
						<li style="padding:10px 0 0 0;">
						<@i18n key="IAM.MAIL.THIRD.PARTY.DEVICE.CHECK" arg0="${ztpl.DEVICE_LOGINS_URL}"/>
	                	</li>
	                	<li style="padding:10px 0 0 0;">
	                	<@i18n key="IAM.MAIL.THIRD.PARTY.CONTACT.SUPPORT" arg0="${ztpl.CONTACT_ID}"/>
	                	</li>
	                	</ul>
	                </td>
	                </tr>
	                <#if !ztpl.IS_APP_PWD>
	                <tr>
	                <td style="padding:16px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                	<@i18n key="IAM.MAIL.THIRD.PARTY.APP.PASS.REC" arg0="${ztpl.APP_PWD_URL}"/>
	                </td>
	                </tr>
	                </#if>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.TPL.REGARDS"/><br>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <b><@i18n key="IAM.TPL.ZOHO.TEAM"/></b><br>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <a href="<@i18n key="IAM.HOME.LINK" />" style="color:#2696eb;text-decoration:none;"><@i18n key="IAM.HOME.LINK.TEXT"/></a>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:0 0 0 12px;">
                    	<div style="border-bottom: 3px solid #339e72;">
                        <img src="<@image cid="23abc@pc29" img_path="${ztpl.IMG_PATH}/mailbottomimg.gif" />" style="display: block;width: 100%;height: auto !important;" />
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