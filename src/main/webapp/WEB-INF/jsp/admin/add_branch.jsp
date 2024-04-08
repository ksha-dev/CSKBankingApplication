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
		document.getElementById('li-branches').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-branches').href = '#';
	</script>
	<h3 class="content-title">Add Branch</h3>
	<form action="authorization" class="container" style="width: 50%;"
		method="post">
		<div class="dual-element-row">
			<label for="address">Address</label> <input type="text" minlength="5"
				name="address" placeholder="Enter Branch Address" required>
		</div>
		<div class="dual-element-row">
			<label for="phone">Phone</label> <input type="number" name="phone"
				minlength="10" placeholder="Enter Branch Phone Number" required>
		</div>
		<div class="dual-element-row">
			<label for="email">Email ID Prefix<br>
				<h5 style="font-weight: normal">
					(Enter only the user name)<br>
					<h6>Eg: example.someone</h6>
				</h5>
			</label> <input type="text" id="userName" name="email"
				placeholder="Enter User Name" pattern="^[a-z.]{5,}$"
				title="Must contain atleast 5 characters" required>
		</div>
		<span id="error" style="color: red;"></span> <input type="hidden"
			name="operation" value="authorize_add_branch"> <input
			type="submit" value="Submit" onclick="validateUserName()"
			class="dual-element-row">
	</form>
	<%@include file="../include/layout_footer.jsp"%>

	<script>
		function validateUserName() {
			const email = document.getElementById('userName').value;
			const error = document.getElementById('error');
			console.log(email.contains("@"));
			if (email.contains("@")) {
				error.textContent = "Please enter only the user name and not any other email characters";
			}
			event.preventDefault();
		}
	</script>
</body>

</html>