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
Account account = (Account) request.getAttribute("account");
CustomerRecord customer = (CustomerRecord) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
<title>Account Details</title>
<%@include file="../include/head.jsp"%>
</head>
<body style="width: 100%;">
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('li-branch_accounts').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-branch_accounts').href = '#';
	</script>
	<div
		style="display: flex; justify-content: space-between; margin-right: 50px; align-items: center;">
		<button style="z-index: 0;" type="button" onclick="history.back()">
			<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
		</button>
	</div>
	<div class="container">
		<h3 class="profile-element">Account Details</h3>

		<div class="divider"></div>

		<div
			style="display: flex; justify-content: space-between; width: 100%;">

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Account Number</p>
					<h4 class="profile-element"><%=account.getAccountNumber()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Account Type</p>
					<h4 class="profile-element"><%=account.getAccountType()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Opening Date</p>
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(account.getOpeningDate())%></h4>
				</div>
			</div>

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Available Balance</p>
					<h4 class="profile-element">
						Rs.
						<%=account.getBalance()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Account Status</p>
					<h4 class="profile-element"><%=account.getStatus()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Last Transaction Date</p>
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(account.getLastTransactedAt())%></h4>
				</div>
			</div>
		</div>
		<br>
		<div style="display: flex;">
			<form action="statement">
				<input type="hidden" value="<%=account.getAccountNumber()%>"
					name="accountNumber">
				<button type="submit">View Statement</button>
			</form>
			<form action="authorization" style="padding-left: 30px" method="post">
				<input type="hidden" name="operation"
					value="authorize_close_account"> <input type="hidden"
					name="accountNumber" value="<%=account.getAccountNumber()%>">
				<button type="submit">Close Account</button>
			</form>
		</div>
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
					<p class="profile-element">Aadhaar</p>
					<h4 class="profile-element"><%=customer.getAadhaarNumber()%></h4>
				</div>
			</div>
		</div>
	</div>

	</div>
	</section>


</body>

</html>