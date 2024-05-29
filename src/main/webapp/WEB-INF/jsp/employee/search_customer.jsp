<%@page import="com.cskbank.utility.ConstantsUtil"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Status"%>
<%@page import="com.cskbank.modules.EmployeeRecord"%>
<%@page import="com.cskbank.modules.CustomerRecord"%>
<%@page import="com.cskbank.modules.Branch"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
CustomerRecord customer = (CustomerRecord) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
<title>Search | Account</title>
<%@include file="../include/head.jsp"%>
</head>
<body style="width: 100%;">
	<%@include file="../include/layout_header.jsp"%>
	<div
		style="display: flex; justify-content: space-between; margin-right: 50px; align-items: center;">
		<button style="z-index: 0;" type="button" onclick="history.back()">
			<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
		</button>
	</div>

	<div class="container">
		<h3 class="profile-element">Customer Details</h3>
		<div class="divider"></div>

		<div
			style="display: flex; justify-content: space-between; width: 100%;">

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Customer ID</p>
					<h4 class="profile-element"><%=customer.getUserId()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Customer Name</p>
					<h4 class="profile-element"><%=customer.getFirstName()%>
						<%=customer.getLastName()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Gender</p>
					<h4 class="profile-element"><%=customer.getGender()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Date of Birth</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenDate(customer.getDateOfBirth())%></h4>
				</div>
				<div id="status">
					<div class="dual-element-row">
						<p class="profile-element">Status</p>
						<h4 class="profile-element"><%=customer.getStatus()%></h4>
					</div>
					<%if(user.getType()==UserRecord.Type.ADMIN) {%>
					<button onclick="editStatus()">Change Status</button>
					<%}%>
				</div>
			</div>

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Mobile</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenPhone(customer.getPhone())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Email</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenEmail(customer.getEmail())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<h4 class="profile-element"><%=customer.getAddress()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Aadhar</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenAadhar(customer.getAadhaarNumber())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">PAN</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenPAN(customer.getPanNumber())%></h4>
				</div>
			</div>
		</div>
	</div>
	<br>

	<%
	if (accounts != null && !accounts.isEmpty()) {
	%>
	<h1>Linked Accounts</h1>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Account Number</td>
					<td>Account Type</td>
					<td>Available Balance</td>
					<td>Opening Date</td>
					<td>Trasaction Date</td>
					<td>Status</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (Account account : accounts.values()) {
				%>
				<tr>
					<td><%=account.getAccountNumber()%></td>
					<td><%=account.getAccountType()%></td>
					<td>Rs. <%=account.getBalance()%></td>
					<td><%=ConvertorUtil.convertLongToLocalDate(account.getOpeningDate())%></td>
					<td><%=account.getLastTransactedAt() == 0 ? "-" : ConvertorUtil.formatToDate(account.getLastTransactedAt())%></td>
					<td><%=account.getStatus()%></td>
					<td>
						<form action="search" method="post">
							<input type="hidden" name="searchBy" value="accountNumber">
							<input type="hidden" name="searchValue"
								value="<%=account.getAccountNumber()%>">
							<button type="submit"
								style="background: none; border: none; padding: 0;">
								<i class="material-icons">keyboard_arrow_right</i>
							</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<%
	}
	%>

	</div>
	</section>
	<%if(user.getType()==UserRecord.Type.ADMIN) {%>
	<script>
	const status = document.getElementById('status');
		function cancelEditStatus() {
			status.innerHTML = '<div class="dual-element-row">'
			+'<p class="profile-element">Status</p><h4 class="profile-element"><%=customer.getStatus()%></h4>'
			+'</div></div><button onclick="editStatus()">Change Status</button>'
		}

		function editStatus() {
			status.innerHTML = '<form action="authorization" method="post" id="status"><div class="dual-element-row">'+
			'<p class="profile-element">Status</p><div class="profile-element"><select name="status" id="selected-status" required>'+
			'<option value=null style="display: none;"><%=customer.getStatus()%></option>'+
	<%
	if(customer.getStatus()==Status.BLOCKED) {
		out.println("'<option value=" + Status.VERIFICATION + ">" + Status.VERIFICATION + "</option>'+");
	} else {
	for (Status status : ConstantsUtil.ADMIN_MODIFIABLE_USER_STATUS) {
	if (customer.getStatus() != status) {
		out.println("'<option value=" + status + ">" + status + "</option>'+");
	}}
}%>
		'</select></div></div><div class="dual-element-row"><p class="profile-element">Reason</p>'
					+ '<div class="profile-element"><input id="reason" type="text" name="reason" placeholder="Enter the reason for status change" required></div></div>'
					+ '<div style="display: flex;"><input type="hidden" name="operation" value="authorize_change_status"><input type="hidden" name="userId" value="'+<%=customer.getUserId()%>
		+ '">'
					+ '<button type="submit" onclick="changeStatusValidation()">Confirm</button><button type="button" onclick="cancelEditStatus()" style="margin-left: 20px;">Cancel</button></div></form>';
		}

		function changeStatusValidation() {
			const changedStatus = document.getElementById('selected-status').value;
			if (changedStatus === 'null') {
				runtimeError('Status was not changed');
				event.preventDefault();
			}
		}
	</script>
	<%}%>

</body>

</html>