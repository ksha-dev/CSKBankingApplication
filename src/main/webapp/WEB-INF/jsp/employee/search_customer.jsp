<%@page import="modules.EmployeeRecord"%>
<%@page import="modules.CustomerRecord"%>
<%@page import="modules.Branch"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.Account"%>
<%@page import="modules.Transaction"%>
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
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(customer.getDateOfBirth())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">PAN</p>
					<h4 class="profile-element"><%=customer.getPanNumber()%></h4>
				</div>
			
			</div>

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Mobile</p>
					<h4 class="profile-element"><%=customer.getPhone()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Email</p>
					<h4 class="profile-element"><%=customer.getEmail()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<h4 class="profile-element"><%=customer.getAddress()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Aadhar</p>
					<h4 class="profile-element"><%=customer.getAadhaarNumber()%></h4>
				</div>
			</div>
		</div>
	</div>
	<br>

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
					<td><%=ConvertorUtil.convertLongToLocalDate(account.getOpeningDate()).format(DateTimeFormatter.ISO_DATE)%></td>
					<td><%=ConvertorUtil.convertLongToLocalDate(account.getLastTransactedAt()).format(DateTimeFormatter.ISO_DATE)%></td>
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

	</div>
	</section>


</body>

</html>