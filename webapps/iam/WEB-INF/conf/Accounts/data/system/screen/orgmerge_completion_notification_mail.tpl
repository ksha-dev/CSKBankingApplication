<!DOCTYPE html>



<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0; padding:0; line-height:20px; font-family: 'Open Sans','Trebuchet MS',sans-serif;">
<div style="width:608px;">

	<!-- Merge failure case -->
	<#if !ztpl.SUCCESS>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;max-width: 608px; min-width: 320px;"> 
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; font-size: 16px; font-weight: 600;">
					<div style="width:94px; height:40px;">
						<img src="<@image cid="23abc@pc31" img_path="${ztpl.IMG_PATH}/new_zoho_logo.png" />" style="display: block;width: 100%;height: auto !important;" />
					</div>
				</td>
			</tr>
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; font-size: 16px; font-weight: 600;"><@i18n key="IAM.HELLO.USERNAME"  arg0="${ztpl.USER_NAME}"/></td>
			</tr>
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; margin-top: 12px; font-size: 20px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.STATUS.FAILED" /></td>
			</tr>
			<tr>
				<td align="center" style="padding:2px 2% 12px 2%;">
					<div style="font-size: 12px; width:500px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.STATUS.FAILED.DESCRIPTION" arg0="${ztpl.DATE}" arg1="${ztpl.TIME_OF_COMPLETION}"/></div>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%">						
						<tr>							
							<td>
								<div style="display: inline-block; width:188px; height:16px; vertical-align:bottom; border-radius:10px 0 0 0; border-top:1px solid #EAEAEA; border-left:1px solid #EAEAEA;"></div><div style="display: inline-block; width:230px; height:32px; line-height: 32px; background-color: #E22728; border-radius:16px; color: #FFFFFF; vertical-align: middle;text-align:center;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.DETAILS.HEADING" /></div><div style="display: inline-block; width:188px; height:16px; vertical-align:bottom; border-radius:0 10px 0 0; border-top:1px solid #EAEAEA; border-right:1px solid #EAEAEA;"></div>
								<div style="width: 608px; border:1px solid #EAEAEA;border-radius:0 0 10px 10px; box-sizing:border-box; border-top:none;">
									<div style="padding: 16px 32px;">
										<div style="display:inline-block; width:230px">
											<div style="color:#E22728; font-size:12px; line-height:14px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FROM" /></div>
											<div style="font-size:14px; line-height:16px; padding-top: 12px;">${ztpl.FROM_ORG_NAME}</div>
											<div style=" font-size:12px; line-height:14px; padding-top: 8px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.ORG.ID" arg0="${ztpl.FROM_ORG_ID}"/></div>
										</div>
										<div style="display:inline-block; width:20px; margin-left:18px; margin-right:20px; position:relative; top:-24px;">
											<img src="<@image cid="23abc@pc32" img_path="${ztpl.IMG_PATH}/merge_icon.png" />" style="display: block;width: 100%;height: auto !important;" />
										</div>
										<div style="display:inline-block; width:230px;">
											<div style="color:#E22728; font-size:12px; line-height:14px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.TO" /></div>
											<div style="font-size:14px; line-height:16px; padding-top: 12px;">${ztpl.TO_ORG_NAME}</div>
											<div style=" font-size:12px; line-height:14px; padding-top: 8px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.ORG.ID" arg0="${ztpl.TO_ORG_ID}"/></div>
										</div>
									</div>
									<div style="border-top:1px solid #EAEAEA; background-color:#F8F8F8;padding: 12px 24px; border-radius:0 0 10px 10px;">
										<div style="display:inline-block; width:237px; font-size:12px; line-height:18px; overflow:hidden; text-overflow:ellipsis;"><span style="opacity:0.6; text-wrap:nowrap;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.REQUESTED.BY" /></span><span style="text-wrap:nowrap;">${ztpl.REQUESTED_BY}</span> </div>
										<div style="display:inline-block; width:20px; margin-left:18px; margin-right:20px;"></div>
										<div style="display:inline-block; font-size:12px; line-height:18px; overflow:hidden; text-overflow:ellipsis;"><span style="opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.REQUESTED.TIME" /></span>${ztpl.REQUESTED_TIME}</div>
									</div>
								
								</div>
								
								
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			
	<#else>
		<!-- Merge Success Case -->	
		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;max-width: 608px; min-width: 320px;"> 
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; font-size: 16px; font-weight: 600;">
					<div style="width:94px; height:40px;">
						<img src="<@image cid="23abc@pc31" img_path="${ztpl.IMG_PATH}/new_zoho_logo.png" />" style="display: block;width: 100%;height: auto !important;" />
					</div>
				</td>
			</tr>
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; font-size: 16px; font-weight: 600;"><@i18n key="IAM.HELLO.USERNAME" arg0="${ztpl.USER_NAME}"/></td>
			</tr>
			<tr>
				<td align="center" style="padding:6px 2% 6px 2%; margin-top: 12px; font-size: 20px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.STATUS.SUCCESS" /></td>
			</tr>
			<tr>
				<td align="center" style="padding:2px 2% 12px 2%;">
					<div style="font-size: 12px; width:500px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.STATUS.SUCCESS.DESCRIPTION" arg0="${ztpl.DATE}" arg1="${ztpl.TIME_OF_COMPLETION}"/></div>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr>							
							<td style="padding-top:0;">
								<div style="display: inline-block; width:188px; height:16px; vertical-align:bottom; border-radius:10px 0 0 0; border-top:1px solid #EAEAEA; border-left:1px solid #EAEAEA;"></div><div style="display: inline-block; width:230px; height:32px; line-height: 32px; background-color: #4CAD66; border-radius:16px; color: #FFFFFF; vertical-align: middle;text-align:center;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.DETAILS.HEADING" /></div><div style="display: inline-block; width:188px; height:16px; vertical-align:bottom; border-radius:0 10px 0 0; border-top:1px solid #EAEAEA; border-right:1px solid #EAEAEA;"></div>
								<div style="width: 608px; border:1px solid #EAEAEA;border-radius:0 0 10px 10px; box-sizing:border-box; border-top:none;">
									<div style="padding: 16px 32px;">
										<div style="display:inline-block; width:230px">
											<div style="color:#4CAD66; font-size:12px; line-height:14px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FROM" /></div>
											<div style="font-size:14px; line-height:16px; padding-top: 12px;">${ztpl.FROM_ORG_NAME}</div>
											<div style=" font-size:12px; line-height:14px; padding-top: 8px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.ORG.ID" arg0="${ztpl.FROM_ORG_ID}"/></div>
										</div>
										<div style="display:inline-block; width:20px; margin-left:18px; margin-right:20px; position:relative; top:-24px;">
											<img src="<@image cid="23abc@pc32" img_path="${ztpl.IMG_PATH}/merge_icon.png" />" style="display: block;width: 100%;height: auto !important;" />
										</div>
										<div style="display:inline-block; width:230px;">
											<div style="color:#4CAD66; font-size:12px; line-height:14px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.TO" /></div>
											<div style="font-size:14px; line-height:16px; padding-top: 12px;">${ztpl.TO_ORG_NAME}</div>
											<div style=" font-size:12px; line-height:14px; padding-top: 8px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.ORG.ID" arg0="${ztpl.TO_ORG_ID}"/></div>
										</div>
									</div>
									<div style="border-top:1px solid #EAEAEA; background-color:#F8F8F8;padding: 12px 24px; border-radius: 0 0 10px 10px;">
										<div style="display:inline-block; width:237px; font-size:12px; line-height:18px; overflow:hidden; text-overflow:ellipsis;"><span style=opacity:0.6;; text-wrap:nowrap;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.REQUESTED.BY" /></span><span style="text-wrap:nowrap;">${ztpl.REQUESTED_BY}</span> </div>
										<div style="display:inline-block; width:20px; margin-left:18px; margin-right:20px;"></div>
										<div style="display:inline-block; font-size:12px; line-height:18px; overflow:hidden; text-overflow:ellipsis;"><span style="opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.REQUESTED.TIME" /></span>${ztpl.REQUESTED_TIME}</div>
									</div>
								
								</div>
								
								
							</td>
						</tr>
											
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%" style="margin-left:5px;">
						<tr>
							<td>
								<div style="width:608px; margin-top:14px;">
									<div style="display:inline-block; width:138px; border:1px solid #EAEAEA; padding: 16px 24px; border-radius:10px;">
										<div style="height:18px;width:18px;border-radius:50%; background-color:#E8FAED; padding: 7px;">
											<img src="<@image cid="23abc@pc33" img_path="${ztpl.IMG_PATH}/user_icon_green.png" />" style="display: block;width: 18px;height: auto !important;" />
										</div>
										<div style="font-size:14px; line-height: 20px; font-weight: 600; margin-top:6px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.USERS.MIGRATED" /></div>
										<div style="color:#4CAD66; font-size:40px; line-height:46px; font-weight: 600; margin-top:8px;">${ztpl.USERS_MIGRATED}</div>
									</div>
									
									<div style="display:inline-block; width:138px; border:1px solid #EAEAEA; padding: 16px 24px; border-radius:10px; margin-left: 17px;">
										<div style="height:18px;width:18px;border-radius:50%; background-color:#E8FAED; padding: 7px;">
											<img src="<@image cid="23abc@pc34" img_path="${ztpl.IMG_PATH}/group_icon_green.png" />" style="display: block;width: 18px;height: auto !important;" />
										</div>
										<div style="font-size:14px; line-height: 20px; font-weight: 600; margin-top:6px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.GROUPS.MIGRATED" /></div>
										<div style="color:#4CAD66; font-size:40px; line-height:46px; font-weight: 600; margin-top:8px;">${ztpl.GROUPS_MIGRATED}</div>
									</div>
									
									<div style="display:inline-block; width:138px; border:1px solid #EAEAEA; padding: 16px 24px; border-radius:10px; margin-left: 17px;">
										<div style="height:18px;width:18px;border-radius:50%; background-color:#E8FAED; padding: 7px;">
											<img src="<@image cid="23abc@pc35" img_path="${ztpl.IMG_PATH}/domain_icon_green.png" />" style="display: block;width: 18px;height: auto !important;" />
										</div>
										<div style="font-size:14px; line-height: 20px; font-weight: 600; margin-top:6px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.DOMAINS.MIGRATED" /></div>
										<div style="color:#4CAD66; font-size:40px; line-height:46px; font-weight: 600; margin-top:8px;">${ztpl.DOMAINS_MIGRATED}</div>
									</div>
								</div>
							</td>
						
						</tr>
					</table>
				</td>
			</tr>
			
			<#list ztpl.keys() as mainKey>
				<#if mainKey == "DATALOSS_APPACCOUNTS" || mainKey == "APPACCOUNTS_MIGRATED" || mainKey == "APPACCOUNTS_MERGED" || mainKey == "APPACCOUNTS_SKIPPED">	
					<tr>
						<td>
							<table width="100%" style="margin-top: 30px; margin-left:5px;">
								<#if mainKey == "DATALOSS_APPACCOUNTS">
									<tr><td style="font-size: 14px; line-height: 24px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.DATALOSS.APPACCOUNTS" /></td></tr>
									<tr><td style="font-size: 12px; line-height: 18px; font-weight: 500; opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.DATALOSS.APPACCOUNTS.DESCRIPTION" /></td></tr>
								<#elseif mainKey == "APPACCOUNTS_MIGRATED">
									<tr><td style="font-size: 14px; line-height: 24px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MIGRATED" /></td></tr>
									<tr><td style="font-size: 12px; line-height: 18px; font-weight: 500; opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MIGRATED.DESCRIPTION" /></td></tr>
								<#elseif mainKey == "APPACCOUNTS_MERGED">
									<tr><td style="font-size: 14px; line-height: 24px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MERGED" /></td></tr>
									<tr><td style="font-size: 12px; line-height: 18px; font-weight: 500; opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MERGED.DESCRIPTION" /></td></tr>
								<#else>
									<tr><td style="font-size: 14px; line-height: 24px; font-weight: 600;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MERGED" /></td></tr>
									<tr><td style="font-size: 12px; line-height: 18px; font-weight: 500; opacity:0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.APPACCOUNTS.MERGED.DESCRIPTION" /></td></tr>
								</#if>
								<#list ztpl[mainKey].keys() as service>
									<#assign value = ztpl[mainKey][service]>
									<#assign logoName = value.iterator()?sequence[0].LOGO_NAME>							
									<tr>
										<td style="padding-top:16px;">							
											<div style="width: 608px; border:1px solid #E8E8E8; border-radius: 10px; padding: 16px 8px 16px 8px; box-sizing: border-box;">
												<div style="display: inline-block; background-color: #E42527; border-radius: 10px; height: 32px; width:3px;vertical-align: top;margin-right: 12px; margin-top: 4px;"></div>
												<div style="display: inline-block; width: 132px; vertical-align: top; margin-right: 12px;margin-top:8px;">
													<div style="display: inline-block; width: 24px; height:24px;">
														<img src="<@image cid="23abc@pc${mainKey?index}0${service?index}" img_path="${ztpl.IMG_PATH}/product_logo_icons/${logoName}.png" />" style="display: block;width: 100%;height: auto !important;" />
													</div>
													<div style="display: inline-block; width: 100px;font-size:12px; line-height:22px; position:relative; vertical-align:top;">${service}</div>
												</div>
												<div style="display: inline-block;">
													<#list value.iterator() as appAcc>											
														<#if !appAcc?is_first>
															<div style="height:1px; background-color:#E8E8E8; width:80%; margin:auto; margin-top:16px;margin-bottom:16px;"></div>
														</#if>
														<div>
															<div style="display: inline-block; width: 210px; vertical-align: middle;  margin-right: 18px;">
																<div style="font-size:12px; line-height:18px;">${appAcc.ACCOUNT_NAME}</div>
																<div style="font-size:12px; line-height:24px; opacity: 0.6;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.ID" arg0="${appAcc.ZAAID}"/></div>
															</div>
															<div style="display: inline-block; width: 113px; vertical-align: middle;font-size:12px; line-height:24px;  margin-right: 8px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.MEMBER.COUNT" arg0="${appAcc.MEMBERS_COUNT}"/></div>
															<#if appAcc.STATUS == "InActive">														
																<div style="display: inline-block; width: 65px; vertical-align: middle;font-size:12px; line-height:14px; opacity:0.4;">
																	<span style="display:inline-block; width:6px; height:6px; border-radius:50%; margin-right:2px; background-color:black;"></span>
																	<span>${appAcc.STATUS}</span>
																</div>
															<#elseif appAcc.STATUS == "Active">
																<div style="display: inline-block; width: 65px; vertical-align: middle;font-size:12px; line-height:14px; color:#3AAD55;">
																	<span style="display:inline-block; width:6px; height:6px; border-radius:50%; margin-right:2px; background-color:#3AAD55;"></span>
																	<span>${appAcc.STATUS}</span>
																</div>
															<#else>
																<div style="display: inline-block; width: 65px; vertical-align: middle;font-size:12px; line-height:14px; color: #3AAD55;">${appAcc.STATUS}</div>
															</#if>
														</div>																				
													</#list>
												</div>
											</div>									
										</td>
									</tr>
								</#list>
							</table>
						</td>
					</tr>				
				
				<#else>
					<#continue>
				</#if>

			</#list>
			
		</table>
	</#if>
	<div style="margin-top:26px; font-size:14px; line-height:20px; margin-left:5px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FOOTER"/></div>
	<div style="margin-top:32px; font-size:12px; line-height:24px; margin-left:5px; opacity:0.6"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FOOTER.CHEERS"/></div>
	<div style="font-size:14px; line-height:24px; margin-left:5px;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FOOTER.ZOHO.IAM"/></div>
	<div style="font-size:14px; line-height:24px; margin-left:5px; color:#0177FF;"><@i18n key="IAM.NEW.MAIL.ORG.MERGE.FOOTER.ZOHO.URL"/></div>
</div>

</body>
</html>


