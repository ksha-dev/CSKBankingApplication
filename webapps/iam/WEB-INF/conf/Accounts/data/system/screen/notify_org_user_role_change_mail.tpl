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
		                    	<#if ztpl.FIRST_NAME??>
		                        <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
		                    	<#else>
		                    	<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.HI" /></a></b>
		                    	</#if>
		                    </td>
	                    </tr>
	                    <#if ztpl.IS_NEW_USER>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
								<@i18n key="IAM.EMAIL.ADDED.AS.ADMIN.DESC" arg0="${ztpl.EMAIL_ID}" arg1="${ztpl.ORG_NAME}" arg2="${ztpl.ROLE}"/>
							</td>
	                    </tr>
	                    <#else>
						<tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
								<@i18n key="IAM.EMAIL.USER.ROLE.CHANGED.DESC" arg0="${ztpl.EMAIL_ID}" arg1="${ztpl.ORG_NAME}"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:30px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
								<b><@i18n key="IAM.EMAIL.NEW.ROLE"/></b>&nbsp;&nbsp;&nbsp;&nbsp;<#if ztpl.NEW_ROLE == "1">Admin<#elseif ztpl.NEW_ROLE == "2">Super Admin</#if>
		                    </td>
	                    </tr>
						<tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
								<b><@i18n key="IAM.EMAIL.PREVIOUS.ROLE"/></b>&nbsp;&nbsp;&nbsp;&nbsp;<#if ztpl.OLD_ROLE == "1">Admin<#elseif ztpl.OLD_ROLE == "0">User</#if>
		                    </td>
	                    </tr>
	                    <#if ztpl.CHNAGED_BY??>
						<tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
								<b><@i18n key="IAM.EMAIL.CHANGED.BY"/></b>   ${ztpl.CHANGED_BY}
		                    </td>
	                    </tr>
	                    </#if>
	                    </#if>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.NEW.TPL.REGARDS"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.TPL.ZOHO.TEAM"/><br>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <a href="<@i18n key="IAM.HOME.LINK" />" style="color:#0091FF; text-decoration:none;"><@i18n key="IAM.HOME.LINK.TEXT"/></a>
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