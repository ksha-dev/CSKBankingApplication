<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/add_employee.js"></script>
</head>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('li-employees').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-employees').href = '#';
	</script>
	<h3 class="content-title">Add Employee</h3>
	<form action="authorization" style="width: auto;" method="post"
		id="add-employee-form">

		<div class="container" style="flex-direction: column;">
			<h3 class="profile-element">Employee Details</h3>
			<div class="divider"></div>
			<div
				style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
				<div style="width: 50%; padding-right: 50px;">
					<div class="dual-element-row">
						<label>First Name</label> <input type="text" id="firstName"
							name="firstName" placeholder="Enter First Name" required>
					</div>
					<span id="e-firstName" class="error-text"></span>

					<div class="dual-element-row">
						<label for="lastName">Last Name</label> <input type="text"
							id="lastName" name="lastName" placeholder="Enter Last Name"
							required>
					</div>
					<span id="e-lastName" class="error-text"></span>

					<div class="dual-element-row">
						<label for="dob">Date of Birth</label> <input type="date"
							id="dateOfBirth" name="dateOfBirth"
							max="<%=ConvertorUtil.formatToUTCDate(System.currentTimeMillis())%>"
							required>
					</div>
					<span id="e-dateOfBirth" class="error-text"></span>

					<div class="dual-element-row">
						<label for="gender">Gender</label> <select name="gender"
							id="gender" required>
							<option value=null style="display: none;">Select</option>
							<%
							for (Gender gender : Gender.values())
								out.print("<option value='" + gender + "'>" + gender + "</option>");
							%>
						</select>
					</div>
					<span id="e-gender" class="error-text"></span>

					<div class="dual-element-row">
						<label for="role">Role</label> <select name="role" id="role"
							required>
							<option value=null style="display: none;">Select</option>
							<option value="<%=UserRecord.Type.EMPLOYEE%>"><%=UserRecord.Type.EMPLOYEE%></option>
							<option value="<%=UserRecord.Type.ADMIN%>"><%=UserRecord.Type.ADMIN%></option>
						</select>
					</div>
					<span id="e-role" class="error-text"></span>
				</div>

				<div style="width: 50%;">
					<div class="dual-element-row">
						<label>Address</label> <input type="text" id="address"
							placeHolder="Enter Address" name="address" required>
					</div>
					<span id="e-address" class="error-text"></span>

					<div class="dual-element-row">
						<label>Phone</label> <input type="number" id="phone" name="phone"
							placeholder="Enter Phone Number" required>
					</div>
					<span id="e-phone" class="error-text"></span>

					<div class="dual-element-row">
						<label>Email ID</label> <input type="email" id="email"
							name="email" placeholder="Enter Email ID" required>
					</div>
					<span id="e-email" class="error-text"></span>

					<div class="dual-element-row">
						<label>Branch ID</label> <input type="number" name="branchId"
							id="branchId" placeholder="Enter Branch ID" required>
					</div>
					<span id="e-branchId" class="error-text"></span>

				</div>
			</div>
		</div>

		<input type="hidden" value="authorize_add_employee" name="operation">
		<button id="submit-button"
			style="margin-left: auto; margin-right: 50px;" type="submit">Finish</button>
	</form>

	</div>
	</section>
</body>

</html>