<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Change Password</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/change_password.js"></script>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Change Password</h3>
	<form id="change-password-form" action="authorization" method="post"
		class="container" style="width: 50%;">

		<div class="dual-element-row">
			<label for="oldPassword">Old Password</label> <input type="password"
				id="oldPassword" placeholder="Enter old password" name="oldPassword"
				required>
		</div>
		<span id="e-oldPassword" class="error-text"></span>
		<div class="dual-element-row">
			<label for="newPassword">New Password</label> <input type="password"
				id="newPassword" placeholder="Enter new password" name="newPassword"
				required>
		</div>
		<span id="e-newPassword" class="error-text"></span>
		<div class="dual-element-row">
			<label for="confirmPassword">Confirm New Password</label> <input
				type="password" id="confirmPassword"
				placeholder="Re-enter new password" required>
		</div>
		<span id="e-confirmPassword" class="error-text"></span> <input
			type="hidden" name="operation" value="authorize_change_password">
		<span id="passwordError" style="color: red;"></span> <input
			class="dual-element-row" type="submit" value="Submit">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>