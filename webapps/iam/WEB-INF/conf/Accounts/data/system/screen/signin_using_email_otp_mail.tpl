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
		                    	<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.HI.USERNAME.EXCLAMATION" arg0="${ztpl.FIRST_NAME}"/></a></b>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                    	<@i18n key="IAM.NEW.TPL.MAIL.OTP.SIGNIN.TEXT" arg0="${ztpl.OTP_VALIDITY}" arg1="${ztpl.VALIDITY_TIME}"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 22px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <b>${ztpl.VERIFICATION_CODE}</b>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.NEW.MAIL.TPL.UKNOWN.ACTION.TEXT" arg0="${ztpl.SUPPORT_EMAIL_ID}"/>
		                    </td>
		                </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.NEW.TPL.REGARDS"/>
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
		                        <img src="<@image cid="23abc@pc28" img_path="${ztpl.IMG_PATH}/zohoRegionLogo.gif" />" style="display: block;width: 100%;height: auto !important;" /> 
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