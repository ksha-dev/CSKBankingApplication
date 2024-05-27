<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
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
<title>Insert title here</title>
<%@include file="../include/head.jsp"%>
</head>
<body style="width: 100%;">
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('li-branch_accounts').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-branch_accounts').href = '#';
	</script>

	<button style="z-index: 0;" type="button"
		onclick="location.href = 'branch_accounts';">
		<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
	</button>
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
					<p class="profile-element">Accont Type</p>
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
	</div>

	<div class="container">
		<h3 class="profile-element">Customer Details</h3>
		<div class="divider"></div>

		<div
			style="display: flex; justify-content: space-between; width: 100%;">

			<div style="width: 100%; padding-right: 50px">
				<div class="dual-element-row">
					<p class="profile-element">Customer ID</p>
					<h4 class="profile-element" style="padding-left: 15px;"><%=customer.getUserId()%></h4>
				</div>
				<div class="dual-element-row">
					<label for="firstName">First Name</label> <input type="text"
						name="firstName" id="firstName"
						value="<%=customer.getFirstName()%>">
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Last Name</p>
					<input type="text" name="lasttName" id="lastName"
						value="<%=customer.getLastName()%>">
				</div>
				<div class="dual-element-row">
					<label for="gender">Gender</label> <select name="gender"
						id="gender" required>
						<option value=null style="display: none;">Select</option>
						<%
						for (Gender gender : Gender.values()) {
						%>
						<option value="<%=gender%>"
							<%=customer.getGender() == gender ? "selected" : ""%>><%=gender%></option>
						<%
						}
						%>
					</select>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Date of Birth</p>
					<input type="date" name="dateOfBirth"
						value="<%=ConvertorUtil.formatToUTCDate(customer.getDateOfBirth())%>"
						max="<%=ConvertorUtil.formatToUTCDate(System.currentTimeMillis())%>">
				</div>

				<div class="dual-element-row">
					<form action="account_details_edit" method="get">
						<input type="hidden" value="<%=account.getAccountNumber()%>"
							name="account_number">
						<button type="submit">Edit Customer Details</button>
					</form>
				</div>

			</div>

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Mobile</p>
					<input type="number" name="phone" value="<%=customer.getPhone()%>">
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Email</p>
					<input type="email" name="email" value="<%=customer.getEmail()%>">
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<input type="text" name="address"
						value="<%=customer.getAddress()%>">
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Aadhar</p>
					<input type="number" name="aadhaar"
						value="<%=customer.getAadhaarNumber()%>">
				</div>
				<div class="dual-element-row">
					<p class="profile-element">PAN</p>
					<input type="text" name="pan" value="<%=customer.getPanNumber()%>">
				</div>
			</div>
		</div>
	</div>

	</div>
	</section>


</body>

</html>