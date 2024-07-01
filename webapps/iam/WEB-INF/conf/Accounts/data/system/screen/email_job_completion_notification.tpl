<!DOCTYPE html>
<html>
	<head>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	</head>
	<body>
	<style>
		div.maincontent .outerTable { margin: 10px 0px; padding: 0px }
		div.maincontent .greetingDiv { padding: 10px 5px; line-height: 25px; text-transform: capitalize }
		div.maincontent .requestDetails { padding: 5px; line-height: 22px }
		div.maincontent .mailContent { padding: 10px 5px }
		div.maincontent .innerTable { background-color: rgba(0, 0, 0, 0.25); border-spacing: 1px }
		div.maincontent .innerTableHeader { background-color: grey; padding: 10px 15px; text-align: center }
		div.maincontent .innerTableData { background-color: white; padding: 10px 15px; text-align: center }
		div.maincontent .moreInfo { padding: 15px 10px }
		div.maincontent a { color:blue }
	</style>
	<div class="maincontent">
		<table cellspacing="0" cellpadding="0" class="outerTable">
			<tbody><tr>
				<td class="greetingDiv">
					<b><@i18n key="IAM.HI.USERNAME.EXCLAMATION" arg0="${ztpl.FIRST_NAME}"/></b>
				</td>
			</tr>
			<tr>
				<td class="requestDetails">
				<@i18n key="IAM.NOTIFY.VIEW.EMAILS.JOB.CONTENT" arg0="${ztpl.DOMAIN_NAME}"/>
				</td>
			</tr>
			<tr>
				<td class="mailContent">
					<table class="innerTable">
		                <tbody>
		                	<tr>
		                		<th class="innerTableHeader">JobId</th>
			               		<th class="innerTableHeader">Total no of Emails</th>
			                	<th class="innerTableHeader">Time Taken (sec)</th>
			                </tr>
			                <tr>
			                	<td class="innerTableData">${ztpl.JOB_ID}</td>
		                        <td class="innerTableData">${ztpl.DOMAINS_COUNT}</td>
		                        <td class="innerTableData">${ztpl.TIME_TAKEN}</td>
			                </tr>
		            	</tbody>
		            </table>
				</td>
			</tr>
				                
			<tr>
				<td class="moreInfo">
		    		<p><@i18n key="IAM.NOTIFY.VIEW.EMAILS.INFO"/></p>
					<p><@i18n key="IAM.TPL.REGARDS"/><p>
					<p>
						<b><@i18n key="IAM.TPL.ZOHO.TEAM"/></b>
					</p>
					<p><@i18n key="IAM.NOTIFY.VIEW.EMAILS.CONTACT"/><p>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</body>
</html>