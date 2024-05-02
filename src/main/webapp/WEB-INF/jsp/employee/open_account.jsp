
<!DOCTYPE html>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@page import="com.cskbank.utility.ConstantsUtil.AccountType"%>
<html>
<head>
<title>Accounts</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<%
	if (user.getType() == UserType.ADMIN) {
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
					<label for="select-account">Select Account Type</label> <select
						id="account-type" name="type" required>
						<option value=null style="display: none;">Account Type</option>
						<%
						for (AccountType type : AccountType.values()) {
						%>
						<option value="<%=type%>"><%=type%></option>
						<%
						}
						%>
					</select>
				</div>
				<div class="dual-element-row" id="select-customer">
					<label for="select-customer">Select Customer Type</label> <select
						name="customerType" id="customer-select" required>
						<option value=null style="display: none;">Customer Type</option>
						<option value="new">New Customer</option>
						<option value="existing">Existing Customer</option>
					</select>
				</div>
				<span id="error-1" style="color: red"></span>
			</div>
			<div style="width: 50%;">
				<div class="dual-element-row">
					<label for="amount">Deposit Amount</label> <input type="number"
						name="amount" placeholder="Enter Deposit Amount" required>
				</div>
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
							name="firstName" placeholder="Enter First Name"
							pattern="^[a-zA-Z]{3,}" required>
					</div>
					<div class="dual-element-row">
						<label for="lastName">Last Name</label> <input type="text"
							name="lastName" placeholder="Enter Last Name" required>
					</div>
					<div class="dual-element-row">
						<label >Date of Birth</label required> <input type="date"
							name="dateOfBirth" required>
					</div>

					<div class="dual-element-row">
						<label for="gender">Gender</label> <select name="gender"
							id="gender" required>
							<option value=null style="display: none;">Select</option>
							<%
							for (Gender gender : Gender.values()) {
							%>
							<option value="<%=gender.getGenderId()%>"><%=gender%></option>
							<%
							}
							%>
						</select>
					</div>
					<div class="dual-element-row">
						<label for="address">Address</label required> <input type="text"
							placeHolder="Enter Address" name="address" required>
					</div>
				</div>

				<div style="width: 50%;">
					<div class="dual-element-row">
						<label for="phone">Mobile</label> <input type="number"
							name="phone" placeholder="Enter Mobile Number"
							pattern="[7-8]\\d{9}" required>
					</div>
					<div class="dual-element-row">
						<label for="email">Email ID</label> <input type="email"
							name="email" placeholder="Enter Email ID" required>
					</div>
					<div class="dual-element-row">
						<label for="aadhaar">Aadhaar Number</label> <input type="text"
							name="aadhar" placeholder="Enter Aadhaar Number" required>
					</div>
					<div class="dual-element-row">
						<label for="pan">PAN</label> <input type="text" name="pan"
							placeholder="Enter PAN Number" required>
					</div>
				</div>
			</div>
			<span id="error-2" style="color: red"></span>
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
							name="userId" placeholder="Enter Customer ID" required>
					</div>

				</div>

				<div style="width: 50%;"></div>
			</div>
		</div>

		<input type="hidden" value="authorize_open_account" name="operation">
		<button id="submit-button"
			style="display: none; margin-left: auto; margin-right: 50px;"
			type="submit" onclick="validateDropDowns()">Finish</button>
	</form>

	</div>
	</section>

	<script>
		const openAccountForm = document.getElementById('open-account-form');
		const selectField = document
				.getElementById('customer-select')
				.addEventListener(
						'change',
						function(event) {
							var newCustomerFields = document
									.getElementById('new-customer-fields');
							var existingCustomerFields = document
									.getElementById('existing-customer-fields');

							if (this.value === "new") {
								newCustomerFields.style.display = "flex";
								openAccountForm
										.removeChild(existingCustomerFields);
							} else if (this.value === "existing") {
								existingCustomerFields.style.display = "flex";
								openAccountForm.removeChild(newCustomerFields);
							}
							document.getElementById('submit-button').style.display = "block";
							document.getElementById('select-customer').style.display = "none";
						});

		function validateDropDowns() {
			const accountType = document.getElementById('account-type').value;
			const customerSelect = document.getElementById('customer-select').value;
			const error1 = document.getElementById('error-1');
			error1.textContent = "";
			if (accountType === "null") {
				error1.textContent = 'Please select an account type';
				event.preventDefault();
			} else if (customerSelect === "null") {
				error1.textContent = 'Please select customer type';
				event.preventDefault();
			} else if (customerSelect === 'new') {
				const gender = document.getElementById('gender').value;
				const error2 = document.getElementById('error-2');
				error2.textContent = "";
				if (gender === "null") {
					error2.textContent = 'Please select a gender';
					event.preventDefault();
				}
			}

		}
	</script>
</body>

</html>