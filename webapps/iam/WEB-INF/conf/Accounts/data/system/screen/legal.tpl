<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}
tr {
	page-break-inside: avoid;
}
td,th {
	font-size:12px;
	border: 1px solid #cac8c9;
	text-align: left;
	padding: 20px 12px;
	background-color: #e9e7e8;
}
.info {
	width: 60%;
	background-color: #f6f4f5;
} 
.legal_template {
 	background-color: #f6f4f5;
}
.auditcolumn {
	word-break: break-all;
}
</style>
<body>
<#assign userData = ztpl.user_details>
<#assign orgMapping = {} />
<#assign paymentsMapping = {} />
<#assign count = 1 />
<#list userData ? keys as userEmail>
<div style="width: 85%;margin: auto;"><hr size="0" color="black">
<#assign userinfo = userData[userEmail]>
<#if (userinfo.zoho_account_name ??)>
	<center style="font-size:20px;"><b>User Information</b></center></br>
<#else>
	<center style="font-size:20px;"><b>SignIn / SignOut History</b></center></br>
</#if>
	<h3> ${count}) ${userEmail} </h3>
	<#if (userinfo.zoho_account_name ??)>
	<table>
		<tr>
			<td> <b>ZOHO ACCOUNT NAME</b> </td>
			<td class="info"> ${userinfo.zoho_account_name} </td>
		</tr>
		<tr>
			<td><b>CURRENT PRIMARY EMAIL ADDRESS</b></td>
			<td class="info"> ${userinfo.primary_email_address} </td>
		</tr>
		<#if userinfo.secondary_email_address??>
			<tr>
				<td><b>SECONDARY EMAIL ADDRESS</b></td>
				<td class="info"> ${userinfo.secondary_email_address} </td>
			</tr>
		</#if>
		<tr>
			<td><b>USER FULL NAME</b></td>
			<td class="info"> ${userinfo.full_name} </td>
		</tr>
		<tr>
			<td><b>USER TYPE</b></td>
			<td class="info"> ${userinfo.user_type} </td>
		</tr>
		<tr>
			<td><b>USER STATUS</b></td>
			<td class="info"> ${userinfo.user_status} </td>
		</tr>
		<tr>
			<td><b>REGISTERED TIME</b></td>
			<td class="info"> ${userinfo.registered_time} </td>
		</tr>
		<tr>
			<td><b>REGISTRATION IP ADDRESS</b></td>
			<td class="info"> ${userinfo.registered_ip_address} </td>
		</tr>
		<tr>
			<td><b>USER IDENTIFIER</b></td>
			<td class="info"> ${userinfo.user_idp} </td>
		</tr>
		<tr>
			<td><b>LOCALE INFO</b></td>
			<td class="info"> ${userinfo.local_info}</td>
		</tr>
		<tr>
			<td><b>REFERRER</b></td>
			<td class="info"> ${userinfo.referrer} </td>
		</tr>
		<tr>
			<td><b>TELEPHONE NUMBER</b></td>
			<td class="info"> ${userinfo.phone_number}</td>
		</tr>
		<tr>
			<td><b>ACCOUNT TYPE</b></td>
			<td class="info"> ${userinfo.account_type} </td>
		</tr>
		<tr>
			<td><b>ACCESSED SERVICES</b></td>
			<td class="info" style="word-break: break-all;"> ${userinfo.accessed_services} </td>
		</tr>
	</table>
	</br>
	</#if>
	
	<#if (userinfo.org_details ??)>
		<#assign org_info = userinfo.org_details>
		<#assign zoid = org_info.zoid>
		<#if (orgMapping[zoid]??) >
			<h4> Org Details </h4>
				<p>&emsp; Refer <strong> ${orgMapping[zoid]} </strong> Org Details</p></br>	
		<#else>
			<h4> Org Details </h4>
			<table>
				<tr>
					<td><b>ORG NAME</b></td>
					<td class="info"> ${org_info.org_name} </td>
				</tr>
				<tr>
					<td><b>ORG DISPLAY NAME</b></td>
					<td class="info"> ${org_info.org_display_name} </td>
				</tr>
				<tr>
					<td><b>ORG CONTACT EMAIL</b></td>
					<td class="info"> ${org_info.org_contact_email} </td>
				</tr>
				<tr>
					<td><b>TOTAL USERS</b></td>
					<td class="info"> ${org_info.total_users} </td>
				</tr>
				<tr>
					<td><b>ACTIVE USERS</b></td>
					<td class="info"> ${org_info.active_users} </td>
				</tr>
				<tr>
					<td><b>CREATED TIME</b></td>
					<td class="info"> ${org_info.created_time} </td>
				</tr>
			</table>
			</br>
		
		    <#if (org_info.isOrgDomainExists)>
				<#assign domaininfo = org_info.org_domain_details>
				<h4> Org Domain Details </h4>
				<table>
					<tr>
						<th> DOMAIN NAME </th>
						<th> DOMAIN STATUS </th>
						<th> CREATED TIME </th>
					</tr>
					<#list 0 ..< domaininfo.length() as i>
					<#assign domain = domaininfo.get(i)>
		    			<tr>
							<td class="legal_template"> ${domain.domain_name} </td>
							<td class="legal_template"> ${domain.domain_status} </td>
							<td class="legal_template"> ${domain.created_time} </td>
						</tr>
					</#list>		     
				</table>
				</br>
			</#if>
		
			<#if (org_info.org_users ??)>	
				<#assign usersinfo = org_info.org_users>
				
				<h4> Org Users </h4>
				<table>
					<#list 0 ..< usersinfo.length() as i>
		    			<tr>
							<td class="legal_template"> ${usersinfo.get(i)} </td>
						</tr>
					</#list>
				</table>
				</br>
			</#if>
			<#assign orgMapping += {zoid : userEmail} />    
		</#if>			
	</#if>

	<#if (userinfo.payment_info ??)>
		<#assign payment_info = userinfo.payment_info>
		<h4> Payment Details </h4>		
		<#list 0 ..< payment_info.length() as i>
		<#assign payment = payment_info.get(i)>
			<#assign id = payment.profile_id>
			<#if (paymentsMapping[id]??) >
				<div class="info" style="padding: 2px;width: auto;">
					<p>&emsp; Refer <strong> ${paymentsMapping[id]} </strong> Payment Details for</p>
					<p>&emsp; ProfileId - ${id}</p>
				</div>
				</br>	
			<#else>
				<table>
					<tr>
						<td><b>PROFILE ID</b></td>
						<td class="info"> ${payment.profile_id}</td>
					</tr>
					<tr>
						<td><b>EMAIL ID</b></td>
						<td class="info"> ${payment.email_id} </td>
					</tr>
					<tr>
						<td><b>COMPANY NAME</b></td>
						<td class="info"> ${payment.company} </td>
					</tr>
					<tr>
						<td><b>COMPANY ADDRESS</b></td>
						<td class="info"> ${payment.address} </td>
					</tr>
					<tr>
						<td><b>TELEPHONE NUMBER</b></td>
						<td class="info"> ${payment.phone_number} </td>
					</tr>
					<tr>
						<td><b>PAYMENT MODE</b></td>
						<td class="info"> ${payment.payment_mode} </td>
					</tr>
					<#if (payment.isFourDigitExists)>
						<tr>
							<td><b>LAST FOUR DIGITS</b></td>
							<td class="info"> ${payment.last_four_digits} </td>
						</tr> 
					</#if>
				</table></br>
				<#assign paymentsMapping += {id : userEmail} />
			</#if>
		</#list>
	</#if>
	
	<#if (userinfo.signin_signout_history ? has_content)>
		<#assign audit_info = userinfo.signin_signout_history>
		<#if (userinfo.zoho_account_name ??)>
			<h4> SignIn / SignOut History </h4>
		</#if>
		<#assign iteration = 0 />
		<#assign no_of_month = audit_info.length() />
		<#list 0 ..< audit_info.length() as i>
		<#assign audit = audit_info.get(i)>
			<#list audit.keys() as month>
				<#assign login_history = audit[month]>
				<#if (login_history.length() != 0)>
					<p> ${month} </p>
					<table>
						<tr>
							<th>SERVICE_NAME</th>
							<th>IP_ADDRESS</th>
							<#if !ztpl.skip_referrer>
								<th>REFERRER</th>
							</#if>
							<th>OPERATION</th>
							<#if !ztpl.skip_user_agent_column>
								<th>USER_AGENT</th>
							</#if>
							<th>CREATED_TIME</th>
						</tr>
						
						<#list 0 ..< login_history.length() as i>
						<#assign audit_json = login_history.get(i)>
							<tr>
								<td class="legal_template"> ${audit_json.SERVICE_NAME} </td>
								<td class="legal_template">
									<#if audit_json.IP_ADDRESS?? > ${audit_json.IP_ADDRESS} <#else>	NULL </#if>
								</td>
								<#if !ztpl.skip_referrer>							
									<td class="legal_template auditcolumn"> 
										<#if audit_json.REFERRER?? > ${audit_json.REFERRER} <#else>	NULL </#if>
									</td>	
								</#if>
								<td class="legal_template auditcolumn"> ${audit_json.OPERATION_NAME} </td>
								<#if !ztpl.skip_user_agent_column>
									<td class="legal_template auditcolumn"> 
										<#if audit_json.USER_AGENT?? > ${audit_json.USER_AGENT} <#else>	NULL </#if>
									</td>
								</#if>
								<td class="legal_template auditcolumn"> ${audit_json.ACCESSED_TIME} </td>
								
							</tr>
						</#list>
					</table></br>
				<#else>
					<#assign iteration = iteration + 1>
				</#if>
			</#list>
		</#list>
		
		<#if (iteration == no_of_month)>
			<p>&emsp; SignIn/SignOut History not available for this user</p></br>
		</#if>
	<#elseif !(userinfo.export_only_user_info)>
		<h4> SignIn / SignOut History </h4><p>&emsp; SignIn/SignOut History not available for this user </p></br>
	</#if>
	
	<#assign count = count + 1>
</div>
</#list>
</body>
</html>