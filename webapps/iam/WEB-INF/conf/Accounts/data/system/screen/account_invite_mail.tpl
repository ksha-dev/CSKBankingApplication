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
	                		
	                		<!--Customize  ServiceOrg Invite Mail Tempate-->
	                		
	                			<#if ztpl.IS_SERVICEORG >
		                			<tr>
	                    				<td>
		                    			<#if ztpl.USE_APPSERVICE_LOGO>
		                      				<div style="display: block;width: 80px;height: 80px;"><img src="cid:23abc@pc27" style="display: block;height:60px; width: 100%;" /></div>
		                  			 	<#else>
		                      				<a href="<@i18n key="IAM.HOME.LINK" />" style="display:inline-block;"><img src="cid:23abc@pc27" style="display:block; height:60px; width: auto;" /></a>
	                    				</#if>
	                  				 	</td>
	                    			</tr>
	                    			<tr>
					                    <td style="padding:8px 0 0 12px;font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
	                    				</td>
	                   				</tr>
	                   				<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
											<#if ztpl.DISABLE_REJECT>
												<@i18n key="IAM.MAIL.ORG.MIGRATE.INVITE.SUBHEADER"  arg0="${ztpl.ACCOUNT_NAME}"/>
											<#else>
												<@i18n key="IAM.MAIL.ORG.INVITE.SUBHEADER"  arg0="${ztpl.ACCOUNT_NAME}"/>
											</#if>
											<br/>
					                    </td>
				                    </tr>
	                    			<tr>
										<td style="padding:20px 0 0 12px;">
											<a style="text-decoration:none;color: #ffffff;display: inline-block;border-top:12px solid #339E72;border-right:40px solid #339E72;border-bottom:12px solid #339E72;border-left:40px solid #339E72;font-size: 16px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;background-color:#339E72;" href="${ztpl.URL}"><@i18n key="IAM.MAIL.SORGINVITATION.TOACCEPT" /></a>
										</td>
	                    			</tr>
		                          	<tr>
		                           	 	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						                        <i><@i18n key="IAM.ORG.INVITAION.EXPIRY.CONTENT" arg0="${ztpl.EXPIRY_DAYS}"/></i>
					                    </td>
	                    			</tr>
	                    			<#if !ztpl.is_serviceorg_invite>
		                    			<tr>
						                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						                        <@i18n key="IAM.MAIL.ORG.INVITE.NOTE" />
						                    </td>
		                    			</tr>
	                    			</#if>
	                    			<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
					                        <@i18n key="IAM.NEW.MAIL.TPL.CONTACT.SUPPORT" arg0="${ztpl.SUPPORT_EMAIL}"/>
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
	                    		<#else>
	                    		
	                		<!--Customize  AppAccount Invite Mail Tempate-->
	                		
	                    		    <tr>
	                    				<td>
		                    			<#if ztpl.USE_APPSERVICE_LOGO>
		                      				<div style="display: block;width: 80px;height: 80px;"><img src="cid:23abc@pc27" style="display: block;width: 100%;" /></div>
		                  			 	<#else>
		                      				<a href="<@i18n key="IAM.HOME.LINK" />" style="display:inline-block;"><img src="cid:23abc@pc27" style="display: block;height: 60px;width: auto" /></a>
	                    				</#if>
	                  				 	</td>
	                    			</tr>
	                    			<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 24px;line-height: 48px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
			                        <b><a href="#" rel="nofollow" style="text-decoration:none !important;cursor: default !important;color: #222 !important;"><@i18n key="IAM.NEW.HI.USERNAME" arg0="${ztpl.FIRST_NAME}"/></a></b>
	                    				</td>
	                   				</tr>
	                   				<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
											<#if ztpl.DISABLE_REJECT>
												<@i18n key="IAM.MAIL.ORG.MIGRATE.INVITE.SUBHEADER"  arg0="${ztpl.ACCOUNT_NAME}"/>
											<#else>
												<@i18n key="IAM.MAIL.ORG.INVITE.SUBHEADER"  arg0="${ztpl.ACCOUNT_NAME}"/>
											</#if>
											<br/>
					                    </td>
				                    </tr>
	                    			<tr>
										<td style="padding:20px 0 0 12px;">
											<a style="text-decoration:none;color: #ffffff;display: inline-block;border-top:12px solid #339E72;border-right:40px solid #339E72;border-bottom:12px solid #339E72;border-left:40px solid #339E72;font-size: 16px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;background-color:#339E72;" href="${ztpl.URL}"><@i18n key="IAM.MAIL.SORGINVITATION.TOACCEPT" /></a>
										</td>
	                    			</tr>
		                          	<tr>
		                           	 	<td style="padding:0 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						                        <i><@i18n key="IAM.ORG.INVITAION.EXPIRY.CONTENT" arg0="${ztpl.EXPIRY_DAYS}"/></i>
					                    </td>
	                    			</tr>
	                    			<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
					                        <@i18n key="IAM.MAIL.ORG.INVITE.NOTE" />
					                    </td>
	                    			</tr>
	                    			<tr>
					                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
					                        <@i18n key="IAM.NEW.MAIL.TPL.CONTACT.SUPPORT" arg0="${ztpl.SUPPORT_EMAIL}"/>
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
	                    	   	</#if>
	                		</table>
	                		<table>
									<tr>
						                <td style="padding:10px 0 10px 12px;font-size: 12px;color:#757575;line-height: 22px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
						                    <@i18n key="IAM.TPL.ZOHO.ADDRESS" /><br><@i18n key="IAM.NEW.TPL.SPAM.TEXT" args0="${ztpl.ABUSE_ID}"/>
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
