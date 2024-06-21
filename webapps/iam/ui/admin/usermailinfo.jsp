<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.OffsetDateTime"%>
<%@page import="com.zoho.accounts.oncloud.mail.transmail.TransMailUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<%@page import="com.zoho.accounts.AccountsConstants.CharacterEncoding"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.accounts.internal.util.CSUtil"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>

<%@ include file="includes.jsp" %>

<style>
.d-flex {
	display: flex;
}

.container {
	padding: 10px;
	background-color: #f6f6f6;
	border-radius: 2px;
	width: 98%;
	margin: 20px auto;
}

.container > h3 {
	text-align: center;
	margin-top: 0px;
	margin-bottom: 10px;
	margin-top: 0px;
	text-align: center;
}

.container > div {
	overflow: auto;
	text-align: center;
}

.container > .msg {
	margin: 30px 0px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

.container tr:nth-of-type(odd) {
	background: #f4f4f4;
}

.container tr:nth-of-type(even) {
	background: #fff;
}

th {
	background: #eaeaea;
	font-weight: bold;
}

td, th {
	padding: 10px;
	border: 1px solid #ccc;
	text-align: left;
	font-size: 13px;
	max-width: 800px;
	word-wrap: break-word;
}

.actions button {
	cursor: pointer;
}

.table-modal {
	position: fixed;
	display: none;
    width: 100vw;
    height: 100vh;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.3);
    z-index: 9999999;
    justify-content: center;
    align-items: center;
}

.table-modal .modal-content {
	width: 600px;
	background: #fff;
	display: flex;
	flex-direction: column;
}

.table-modal .modal-header {
	background: #eee;
	justify-content: space-between;
	align-items: center;
}

.table-modal .modal-header div {
	padding: 10px 20px
}

.table-modal .modal-body {
	padding: 20px 30px;
}

.table-modal th {
	width: 40%;
}
</style>
<%
    String qry = request.getParameter("qry");
    qry = Util.isValid(qry) ? qry : "";
%>

<div class="menucontent">
	<div class="topcontent"><div class="contitle">User Mail Info</div></div><%--No I18N--%>
	<div class="subtitle">Mail send status of Last 10 days</div><%--No I18N--%>
</div>
<div class="maincontent">
    <div class="field-bg">
	<div class="labelmain" id="searchuser">
	    <div class="labelkey" style="width:375px;">Enter UserName or Email Address or ZUID :</div><%--No I18N--%>
	    <div class="searchfielddiv">
                <input type="text" name="search" id="search"  autocomplete="off" style="height:22px;*height:12px;" value="<%=IAMEncoder.encodeHTMLAttribute(qry)%>" class="input" onmouseover="this.focus()" onkeypress="if(event.keyCode == 13){ searchMail();return false;}"/>
	    </div>
	    <div class="Hbtn searchbtn">
		<div class="savebtn" onclick="searchMail()" style="margin:0px;">
			<span class="btnlt"></span>
			<span class="btnco">Search</span> <%--No I18N--%>
			<span class="btnrt"></span>
		</div>
	    </div>
	</div>
    </div>
</div>
<div style="width: 97%; margin: 70px auto;">
<%
	if (Util.isValid(qry)) {
		JSONArray jar = TransMailUtil.getMailInfo(qry, false);
		if (jar == null || jar.length() == 0) {
%>
		<div class="container">
			<h3>No Output to show</h3> <%-- No I18N --%>
		</div>
<%
		} else {
			for (int i = 0; i < jar.length(); i++) {
				JSONObject mailDetails = jar.getJSONObject(i);
				String title = mailDetails.getString("mailStatus"); // No I18N
				JSONArray mailArr = mailDetails.getJSONArray("Details"); // No I18N

				if (title.equalsIgnoreCase("toemails")) {
					title = "Emails received by the user"; // No I18N
				}
				if (title.equalsIgnoreCase("currentUseremail")) {
					title = "Emails sent by the user"; // No I18N
				}
%>
				<div class="container">
					<h3><%= title %></h3>
					<div>
						<table>
							<tr>
								<th>From</th> <%-- No I18N --%>
								<th>To</th> <%-- No I18N --%>
								<th>Mail Type</th> <%-- No I18N --%>
								<th>Status</th> <%-- No I18N --%>
								<th>Time</th> <%-- No I18N --%>
								<th>Actions</th> <%-- No I18N --%>
							</tr>
<%
				for (int j = 0; j < mailArr.length(); j++) {
					JSONObject mailInfo = mailArr.getJSONObject(j);
					JSONObject info = new JSONObject();

					String fromEmail = mailInfo.getString("From"); // No I18N
					String toEmail = mailInfo.getString("OrginalTo"); // No I18N
					String mailType = mailInfo.getString("MailType"); // No I18N
					String status = "unknown"; // No I18N
					String processedTime = "unknown"; // No I18N
					String events = "[]";
					
					info.put("MessageID", mailInfo.getString("MessageID")); // No I18N
					info.put("AppName", mailInfo.getString("AppName")); // No I18N
					info.put("CurrentUserZuid", "Unauthorized"); // No I18N
					info.put("IpAddress", mailInfo.getString("IpAddress")); // No I18N
					info.put("Key", mailInfo.getString("Key")); // No I18N
					info.put("OriginatedDeployment", mailInfo.getString("OriginatedDeployment")); // No I18N

					if (mailInfo.has("transMailRespose")) {
						JSONObject transMailDetails = mailInfo.getJSONObject("transMailRespose").getJSONArray("details").getJSONObject(0); // No I18N
						if (transMailDetails.has("event_data") && transMailDetails.getJSONArray("event_data").getJSONObject(0).has("details")) {
                        	events = transMailDetails.getJSONArray("event_data").getJSONObject(0).getJSONArray("details").toString(); // No I18N
                    	}
						JSONObject emailInfo = transMailDetails.getJSONObject("email_info"); // No I18N
						if (emailInfo.has("status")) {
							status = emailInfo.getString("status");
						}
						if (emailInfo.has("processed_time")) {
							processedTime = OffsetDateTime.parse(emailInfo.getString("processed_time")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm ZZZZ")); //No I18N
						}
						if (emailInfo.has("subject")) {
							info.put("subject", emailInfo.getString("subject")); // No I18N
						}
					}
					if (mailInfo.has("CurrentUserZuid")) {
						info.put("CurrentUserZuid", mailInfo.getString("CurrentUserZuid")); // No I18N
					}
					String infoStr = info.toString();
					
%>
							<tr class="table-content">
								<td><%= IAMEncoder.encodeHTML(fromEmail) %></td>
								<td><%= IAMEncoder.encodeHTML(toEmail) %></td>
								<td><%= IAMEncoder.encodeHTML(mailType) %></td>
								<td><%= IAMEncoder.encodeHTML(status) %></td>
								<td><%= IAMEncoder.encodeHTML(processedTime) %></td>
								<td class="actions">
									<button onclick="showTableModal('Events', <%= IAMEncoder.encodeHTML(events) %>)">Event</button> <%-- No I18N --%>
									<button onclick="showTableModal('Mail Details', <%= IAMEncoder.encodeHTML(infoStr) %>)">Info</button> <%-- No I18N --%>
								</td>
							</tr>
<%
				}
%>
						</table>
					</div>
				</div>
<%
			}
	  	}
	}
%>  
</div>
<div id='table-modal' class="table-modal">
	<div class="modal-content">
		<div class="modal-header d-flex">
			<div id='modal-title'>Events</div> <%-- No I18N --%>
			<div style="font-size: 20px; cursor: pointer;" onClick="document.getElementById('table-modal').style.display = 'none'">&times;</div> <%-- No I18N --%>
		</div>
		<div id="event-body" class="modal-body"></div>
	</div>
</div>
