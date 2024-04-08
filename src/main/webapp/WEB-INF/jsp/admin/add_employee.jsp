<%@page import="utility.ConvertorUtil"%>
<%@page import="utility.ConstantsUtil.Gender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>
<%@include file="../include/head.jsp"%>

</head>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('li-employees').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-employees').href = '#';
	</script>
	<h3 class="content-title">Add Employee</h3>
	<form action="authorization" style="width: auto;" method="post">

		<div class="container" style="flex-direction: column;">
			<h3 class="profile-element">Employee Details</h3>
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
						<label for="dob">Date of Birth</label> <input type="date" id="dob"
							name="dateOfBirth"
							max="<%=ConvertorUtil.formatToUTCDate(System.currentTimeMillis())%>"
							required>
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
						<label for="role">Role</label> <select name="role" id="role"
							required>
							<option value=null style="display: none;">Select</option>
							<option value="<%=UserType.EMPLOYEE.getUserTypeId()%>"><%=UserType.EMPLOYEE%></option>
							<option value="<%=UserType.ADMIN.getUserTypeId()%>"><%=UserType.ADMIN%></option>
						</select>

					</div>
				</div>

				<div style="width: 50%;">
					<div class="dual-element-row">
						<label for="address">Address</label required> <input type="text"
							placeHolder="Enter Address" name="address" required>
					</div>
					<div class="dual-element-row">
						<label for="mobile">Mobile</label> <input type="number"
							name="mobile" placeholder="Enter Mobile Number"
							pattern="[7-8]\\d{9}" required>
					</div>
					<div class="dual-element-row">
						<label for="email">Email ID</label> <input type="email"
							name="email" placeholder="Enter Email ID" required>
					</div>
					<div class="dual-element-row">
						<label for="branchId">Branch ID</label> <input type="number"
							name="branchId" placeholder="Enter Branch ID" required>
					</div>
				</div>
			</div>
			<span id="error" style="color: red"></span>
		</div>

		<input type="hidden" value="authorize_add_employee" name="operation">
		<button id="submit-button"
			style="margin-left: auto; margin-right: 50px;" type="submit"
			onclick="validateDropDowns()">Finish</button>
	</form>

	</div>
	</section>

	<script>
		function validateDropDowns() {
			const gender = document.getElementById('gender').value;
			const role = document.getElementById('role').value;
			const dob = document.getElementById('dob').value;
			const error = document.getElementById('error');
			error.textContent = "";
			if (gender === "null") {
				error.textContent = 'Please select a gender';
				event.preventDefault();
			}
			if (role === "null") {
				error.textContent = 'Please select the role of the employee';
				event.preventDefault();
			}
			if (dob === "") {
				error.textContent = 'Please enter date of birth';
				event.preventDefault();
			}
		}
	</script>
</body>

</html>