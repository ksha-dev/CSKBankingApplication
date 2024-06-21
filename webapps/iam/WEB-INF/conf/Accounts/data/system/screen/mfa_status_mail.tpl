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
                      	<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
                        
                    </td>
                    </tr>
                    <#if ztpl.activated>
	                    <tr>
	                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                       <@i18n key="IAM.NEW.MAIL.MFA.ENABLED" arg0="${ztpl.MFA_TYPE}"/>
	                    </td>
	                    </tr>
		                    <tr>
			                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <b><@i18n key="IAM.TFA.AUTH.MODE"/></b>
			                    </td>
		                    </tr> 
		                    <#if ztpl.tfapref == 0>
			                    <tr>
			                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <@i18n key="IAM.TFA.SMS.TEXT.MESSAGE"/>
			                    </td>
			                    </tr>
			                <#elseif ztpl.tfapref == 1>              
			                    <tr>
			                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <@i18n key="IAM.GOOGLE.AUTHENTICATOR"/>
			                    </td>
			                    </tr>
			                <#elseif ztpl.tfapref == 8>
			                    <tr>
			                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <@i18n key="IAM.MFA.YUBIKEY"/>
			                    </td>
			                    </tr>                                 
		                    <#elseif ztpl.tfapref == 2>                                     
			                    <tr>
				                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
				                        <@i18n key="IAM.TOUCHID"/>
				                    </td>
			                    </tr>
			                <#elseif ztpl.tfapref == 3>              
			                    <tr>
			                    	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        	<@i18n key="IAM.SCAN.QR"/>
			                    	</td>
			                    </tr>  
			                <#elseif ztpl.tfapref == 4>                 
			                    <tr>
			                    	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        	<@i18n key="IAM.PUSH.NOTIFICATION"/>
			                    	</td>
			                    </tr>                       
			                <#elseif ztpl.tfapref == 5>                    
			                    <tr>
			                    	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        	<@i18n key="IAM.GOOGLE.AUTHENTICATOR"/>
			                    </td>
			                    </tr>
			                <#elseif ztpl.tfapref == 7>                    
			                    <tr>
			                    	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        	<@i18n key="IAM.FACEID"/>
			                    	</td>
			                    </tr>
		                    </#if>
	                    <#if ztpl.has_configured_device>
		                    <tr>
			                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <@i18n key="IAM.NEW.MAIL.MFA.DEVICE" arg0="${ztpl.configured_device_name}"/>
			                    </td>
		                    </tr>                    
	                    </#if>
	                    <tr>
	                    	<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                        	<@i18n key="IAM.NEW.MAIL.MFA.SETTINGS.MANAGE" arg0="${ztpl.SERVER_LINK}"/>
	                    	</td>
	                    </tr>
	                    <#if ztpl.MFA_TYPE == "OneAuth" >
	                    	<tr>
	                    		<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                        		<@i18n key="IAM.NEW.MAIL.MFA.UNINSTALL.NOTE" arg0="${ztpl.ONEAUTH_APP}"/>
	                    		</td>
	                    	</tr>
	                    <#elseif ztpl.tfapref == 1>
	                    	<tr>
	                    		<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                        		<@i18n key="IAM.NEW.MAIL.MFA.UNINSTALL.NOTE" arg0="${ztpl.MFA_TYPE}"/>
	                    		</td>
	                    	</tr>
	                    </#if> 
	                    <tr>
	                    	<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                       		<@i18n key="IAM.NEW.MAIL.MFA.HELP.GUIDE" arg0="${ztpl.HELP_GUIDE}"/>
	                    	</td>
	                    </tr>
                    <#else>
	                    <tr>
	                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                       <@i18n key="IAM.NEW.MAIL.MFA.DISABLED"/>
	                    </td>
	                    </tr>
	                    <tr>
	                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                       <@i18n key="IAM.NEW.MAIL.MFA.SETTINGS.MANAGE" arg0="${ztpl.SERVER_LINK}"/>
	                    </td>
	                    </tr>
	                    <tr>
	                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
	                       <@i18n key="IAM.NEW.MAIL.TPL.UKNOWN.ACTION.TEXT" arg0="${ztpl.SUPPORT_EMAIL}"/>
	                    </td>
	                    </tr>
                    </#if>
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