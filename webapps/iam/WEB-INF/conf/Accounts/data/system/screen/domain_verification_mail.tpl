<!DOCTYPE html>


<#if ztpl.RECOVERY_TYPE?has_content && ztpl.RECOVERY_TYPE=="resetip">
	<#assign type = "IP"  CTA = "IAM.IP.RESET.HEADING">
<#else>
	<#assign type = "AC"  CTA = "IAM.PASSWORD.CHANGE">
</#if>	

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
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                    	<@i18n key="IAM.${type}.DOMAIN.OWNERSHIP.INSTRUCTION" arg0="${ztpl.EMAIL_ID}" arg1="${ztpl.DOMAIN}"/>
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:10px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <#if ztpl.VERIFICATION_TYPE?has_content && ztpl.VERIFICATION_TYPE==1>
			                        <ul style="list-style-type: none;padding-left: 0;list-style-position: inside;">
				    					<li>1. <@i18n key="IAM.DOMAIN.OWNERSHIP.STEP1" arg0="${ztpl.DOMAIN}" /> </li>
				    					<li style="padding: 10px 0 0 0;">2. <@i18n key="IAM.DOMAIN.OWNERSHIP.STEP2"/> </li>
				    					<li style="padding: 10px 0 0 0;">3. <@i18n key="IAM.DOMAIN.OWNERSHIP.STEP3"/>
				    						<table border="0" cellpadding="0" cellspacing="0" width="50%" style="padding: 10px 0 0 15px;" >
				    							<tr style="line-height: 35px;">
				    								<td><b style="width:150px;display:inline-table;"><@i18n key="IAM.DOMAIN.CNAME"/></b></td>
				    								<td> ${ztpl.RANDOM_STRING}</td>
				    							</tr>
				    							<tr style="line-height: 35px;">
				    								<td><b style="width:150px;display:inline-table;"><@i18n key="IAM.DOMAIN.POINTS.DESTINATION"/></b></td>
				    								<td> ${ztpl.POINT_TO}</td>
				    							</tr>
				    							<tr style="line-height: 35px;">
				    								<td><b style="width:150px;display:inline-table;"><@i18n key="IAM.DOMAIN.TTL.IN.HOURS"/></b></td>
				    								<td> ${ztpl.TTL}</td>
				    							</tr>
				    						</table>
				    					</li>
				    					<li style="padding: 10px 0 0 0;">4. <@i18n key="IAM.${type}.DOMAIN.OWNERSHIP.STEP4"/> </li>
									</ul>
								<#elseif ztpl.VERIFICATION_TYPE?has_content && ztpl.VERIFICATION_TYPE==2>
									<ul style="list-style-type: none;padding-left: 0;list-style-position: inside;">
				    					<li>1. <@i18n key="IAM.DOMAIN.OWNERSHIP.STEP1" arg0="${ztpl.DOMAIN}" /> </li>
				    					<li style="padding: 10px 0 0 0;">2. <@i18n key="IAM.DOMAIN.OWNERSHIP.STEP2"/> </li>
				    					<li style="padding: 10px 0 0 0;">3. <@i18n key="IAM.DOMAIN.OWNERSHIP.TXT.STEP3"/>
				    						<table border="0" cellpadding="0" cellspacing="0" width="50%" style="padding: 10px 0 0 15px;" >
				    							<tr style="line-height: 35px;">
				    								<td><b style="width:150px;display:inline-table;text-transform:uppercase;"><@i18n key="IAM.NAME"/></b></td>
				    								<td>"@"</td>
				    							</tr>
				    							<tr style="line-height: 35px;">
				    								<td><b style="width:150px;display:inline-table;"><@i18n key="IAM.DOMAIN.TXT.VALUES"/></b></td>
				    								<td> ${ztpl.TXT_VALUE}</td>
				    							</tr>				    							
				    						</table>
				    					</li>
				    					<li style="padding: 10px 0 0 0;">4. <@i18n key="IAM.${type}.DOMAIN.OWNERSHIP.TXT.STEP4"/> </li>
									</ul>
								
								<#elseif ztpl.VERIFICATION_TYPE?has_content && ztpl.VERIFICATION_TYPE==0>
									<ul style="list-style-type: none;padding-left: 0;list-style-position: inside;">
				    					<li>1. <@i18n key="IAM.DOMAIN.OWNERSHIP.HTML.STEP1"/></li>
				    					<li style="padding: 10px 0 0 0;">2. <@i18n key="IAM.DOMAIN.OWNERSHIP.HTML.STEP2"/> </li>
				    					<li style="padding: 10px 0 0 0;">3. <@i18n key="IAM.DOMAIN.OWNERSHIP.HTML.STEP3" arg0="${ztpl.HTML_NAME}"/></li>
				    					<li style="padding: 10px 0 0 0;">4. <@i18n key="IAM.${type}.DOMAIN.OWNERSHIP.HTML.STEP4"/> </li>
									</ul>
								</#if>	
		                    </td>
	                    </tr>
	                    <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <a style="text-decoration:none;color: #ffffff;display: inline-block;border-top:14px solid #339E72;border-right:40px solid #339E72;border-bottom:14px solid #339E72;border-left:40px solid #339E72;font-size: 16px;font-weight: 600;font-family: 'Open Sans','Trebuchet MS',sans-serif;color: #ffffff;background-color:#339E72;" href="${ztpl.DIGEST_URL}"><@i18n key="${CTA}"/></a>
		                    </td>
		                </tr>
		                <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                    	<@i18n key="IAM.${type}.DOMAIN.URL.EXPIRY" arg0="${ztpl.DIGEST_EXPIRY_HOURS}" arg1="${ztpl.DIGEST_VALIDITY}"/>
		                    </td>
	                    </tr>
	                     <tr>
		                    <td style="padding:20px 0 0 12px;font-size: 14px;line-height: 24px;font-family: 'Open Sans','Trebuchet MS',sans-serif;">
		                        <@i18n key="IAM.AC.DOMAIN.CONTACT.SUPPORT" arg0="${ztpl.SUPPORT_EMAIL_ID}" />
		                    </td>
	                    </tr>
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


