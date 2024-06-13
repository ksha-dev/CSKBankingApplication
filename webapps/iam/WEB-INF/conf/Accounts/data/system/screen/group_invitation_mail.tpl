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
		               <#if ztpl.user_exist=="true">
		               		<b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.HI.USERNAME.EXCLAMATION" arg0="${ztpl.user_name}"/></a></b>
		               <#else>
							<b><@i18n key="IAM.HI.USERNAME.EXCLAMATION" arg0="${ztpl.email_id}"/></b>
		               </#if>
		            </td>
		    	    </tr>
					<tr>
					<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						<@i18n key="IAM.GROUPINVITATION.MAIL.GROUP.NAME"/>
					</td>
					</tr>
					<br />
                    <tr>
                        <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                            <table border="0" cellpadding="0" cellspacing="0" min-width="100px">
                                <tr>
                                   <td> <b style="margin-right: 40px;"><@i18n key="IAM.GROUP.NAME" /></b></td>
                                   <td>: ${ztpl.grp_name}</td>
                                </tr>
                                <tr>
                                   <td> <b style="margin-right: 40px;"><@i18n key="IAM.INVITER" /></b></td>
                                   <td>: ${ztpl.inviter_name} (<a style="color:#2696eb;text-decoration:none;" href="mailto:${ztpl.inviter_email}">${ztpl.inviter_email}</a>)</td>
                                </tr>
                                <tr>
                                <td>
                                    <a style="text-decoration:none;color: #ffffff;display: inline-block;border-top:12px solid #339E72;border-right:40px solid #339E72;border-bottom:12px solid #339E72;border-left:40px solid #339E72;margin-top: 20px;font-weight: 600;color: #ffffff;background-color:#339E72;" href="${ztpl.invitation_url}"><b><@i18n key="IAM.VIEW.INVITE" /></b></a>
                                   
                                </td>
                                </tr>
                            </table>
                        </td>
                    </tr> 
                    <tr>
                        <td style="padding:10px 0 10px 12px;font-size: 14px;font-style: italic;color: #828282;color: #686868;font-family: 'Open Sans','Trebuchet MS',sans-serif;">Make sure the inviter is someone you know before accepting the invite. </td>
                    </tr>
					<#if  ztpl.user_exist=="false">
		 				<tr>
							<td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
									<@i18n key="IAM.GROUPINVITATION.MAIL.USERNOTEXIST.MESSAGE" arg0="${ztpl.email_id}"/>
							</td>
						</tr>
					</#if>
                    <tr>
                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.GROUPINVITATION.MAIL.MESSAGE.CONTACT.SUPPORT" arg0="${ztpl.support_mailId}"/>
                    </td>
                    </tr>
                    <tr>
                    <td style="padding:20px 0 20px 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
                        <@i18n key="IAM.REGARDS"/>,
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
                </table>
            </td>
            </tr>
        </table>
    </td>
    </tr>
</table>
</table>
</body>
</html>