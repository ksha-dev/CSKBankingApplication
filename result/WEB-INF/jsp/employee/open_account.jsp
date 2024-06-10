<!DOCTYPE html>
<%@page import="com.cskbank.filters.Parameters"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<html>

<head>
<title>Accounts</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/open_account.js"></script>

</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<%
	if (user.getType() == UserRecord.Type.ADMIN) {
	%>
	<script>
		document.getElementById('li-accounts').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-accounts').href = '#';
	</script>
	<%
	}
	%>
	<h3 class="content-title">Open New Account</h3>
	<form action="authorization" id="open-account-form"
		style="width: auto;" method="post">
		<div class="container" style="flex-direction: row;">
			<div style="width: 50%; padding-right: 50px;">
				<div class="dual-element-row">
					<label>Select Account Type</label> <select id="accountType"
						name="<%=Parameters.TYPE.parameterName()%>">
						<option value=null style="display: none;">Account Type</option>
						<%
						for (Account.AccountType type : Account.AccountType.values()) {
						%>
						<option value="<%=type%>">
							<%=type%>
						</option>
						<%
						}
						%>
					</select>
				</div>
				<span id="e-accountType" class="error-text"></span>
				<div class="dual-element-row" id="select-customer">
					<label>Select Customer Type</label> <select
						onclick="triggerCustomerType()" name="customerType"
						id="customerType">
						<option value=null style="display: none;">Customer Type</option>
						<option value="new">New Customer</option>
						<option value="existing">Existing Customer</option>
					</select>
				</div>
				<span id="e-customerType" class="error-text"></span>
			</div>
			<div style="width: 50%;">
				<div class="dual-element-row">
					<label for="amount">Deposit Amount</label> <input type="number"
						id="amount" name="<%=Parameters.AMOUNT.parameterName()%>"
						placeholder="Enter Deposit Amount">
				</div>
				<span id="e-amount" class="error-text"></span>

			</div>

		</div>
		<div id="new-customer-fields" class="container"
			style="display: none; flex-direction: column;">
			<h3 class="profile-element">Customer Details</h3>
			<div class="divider"></div>
			<div
				style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
				<div style="width: 50%; padding-right: 50px;">
					<div class="dual-element-row">
						<label for="firstName">First Name</label> <input type="text"
							id="firstName" name="<%=Parameters.FIRSTNAME.parameterName()%>"
							placeholder="Enter First Name" pattern="^[a-zA-Z]{3,}">
					</div>
					<span id="e-firstName" class="error-text"></span>

					<div class="dual-element-row">
						<label for="lastName">Last Name</label> <input type="text"
							id="lastName" name="<%=Parameters.LASTNAME.parameterName()%>"
							placeholder="Enter Last Name">
					</div>
					<span id="e-lastName" class="error-text"></span>

					<div class="dual-element-row">
						<label>Date of Birth</label> <input type="date" id="dateOfBirth"
							name="<%=Parameters.DATEOFBIRTH.parameterName()%>">
					</div>
					<span id="e-dateOfBirth" class="error-text"></span>


					<div class="dual-element-row">
						<label for="gender">Gender</label> <select
							name="<%=Parameters.GENDER.parameterName()%>" id="gender">
							<option value=null style="display: none;">Select</option>
							<%
							for (Gender gender : Gender.values()) {
							%>
							<option value="<%=gender%>">
								<%=gender%>
							</option>
							<%
							}
							%>
						</select>
					</div>
					<span id="e-gender" class="error-text"></span>

					<div class="dual-element-row">
						<label for="address">Address</label> <input type="text"
							placeHolder="Enter Address" id="address"
							name="<%=Parameters.ADDRESS.parameterName()%>">
					</div>
					<span id="e-address" class="error-text"></span>

				</div>

				<div style="width: 50%;">
					<div class="dual-element-row">
						<label for="phone">Mobile</label> <input type="number" id="phone"
							name="<%=Parameters.PHONE.parameterName()%>"
							placeholder="Enter Phone Number">
					</div>
					<span id="e-phone" class="error-text"></span>

					<div class="dual-element-row">
						<label for="email">Email ID</label> <input type="email" id="email"
							name="<%=Parameters.EMAIL.parameterName()%>"
							placeholder="Enter Email ID">
					</div>
					<span id="e-email" class="error-text"></span>

					<div class="dual-element-row">
						<label for="aadhaar">Aadhaar Number</label> <input type="text"
							id="aadhaar" name="<%=Parameters.AADHAAR.parameterName()%>"
							placeholder="Enter Aadhaar Number">
					</div>
					<span id="e-aadhaar" class="error-text"></span>

					<div class="dual-element-row">
						<label for="pan">PAN</label> <input type="text"
							name="<%=Parameters.PAN.parameterName()%>" id="pan"
							placeholder="Enter PAN Number">
					</div>
					<span id="e-pan" class="error-text"></span>

				</div>
			</div>
		</div>

		<div id="existing-customer-fields" class="container"
			style="display: none; flex-direction: column;">
			<h3 class="profile-element">Customer Details</h3>
			<div class="divider"></div>
			<div
				style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
				<div style="width: 50%; padding-right: 50px;">
					<div class="dual-element-row">
						<label for="userId">Customer ID</label> <input type="number"
							id="userId" name="<%=Parameters.USERID.parameterName()%>"
							placeholder="Enter Customer ID">
					</div>
					<span id="e-userId" class="error-text"></span>

				</div>

				<div style="width: 50%;"></div>
			</div>
		</div>

		<input type="hidden" value="authorize_open_account" name="operation">
		<button id="submit-button"
			style="display: block; margin-left: auto; margin-right: 50px;"
			type="submit">Finish</button>
	</form>

	</div>
	</section>
</body>

</html>