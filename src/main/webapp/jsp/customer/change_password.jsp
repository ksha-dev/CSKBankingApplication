<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Change Password</title>
<%@include file="../../include/head.jsp"%>
</head>

<body>
	<section id="menu">
		<div class="logo">
			<img src="images/logo.png" alt="CSK Bank Logo">
			<h2>CSK Bank</h2>
		</div>

		<div class="items">

			<a href="app?route=account">
				<li><i class="material-icons">account_balance</i>Account</li>
			</a> <a href="app?route=statement_select">
				<li><i class="material-icons">receipt_long</i>Statement</li>
			</a> <a href="app?route=transfer">
				<li><i class="material-icons">payments</i>Transfer</li>
			</a>
			<li
				style="border-left: 5px solid #fff; background: #0d1117; color: white;"><i
				class="material-icons">lock_reset</i><a href="change_password.html">Change
					Password</a></li> <a href="#" onclick="logout()">
				<li><i class="material-icons">logout</i>Logout</li>
			</a>
		</div>
	</section>


	<section id="content-area">
		<div class="nav-bar">
			<div class="profile">
				<a href="app?route=customer_profile"> <img
					src="images/profile.jpg" alt="Profile">
				</a>
			</div>
		</div>


		<div class="content-board">
			<h3 class="content-title">Change Password</h3>
			<form id="resetPasswordForm" action="app" method="post"
				class="container" style="width: 50%;">

				<div class="dual-element-row">
					<label for="oldPassword">Old Password</label> <input
						type="password" id="oldPassword" placeholder="Enter old password"
						name="oldPassword"
						pattern="(?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20}"
						title="Must start with a letter, contain at least one number, uppercase, lowercase letter, special character and at least 8 or more characters"
						required>
				</div>

				<div class="dual-element-row">
					<label for="newPassword">New Password</label> <input
						type="password" id="newPassword" placeholder="Enter new password"
						name="newPassword"
						pattern="(?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20}"
						title="Must start with a letter, contain at least one number, uppercase, lowercase letter, special character and at least 8 or more characters"
						required>
				</div>

				<div class="dual-element-row">
					<label for="confirmPassword">Confirm New Password</label> <input
						type="password" id="confirmPassword"
						placeholder="Re-enter new password"
						pattern="(?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20}"
						title="Must start with a letter, contain at least one number, uppercase, lowercase letter, special character and at least 8 or more characters"
						required>
				</div>
				<input type="hidden" name="route"
					value="change_password_authorization_request"> <span
					id="passwordError" style="color: red;"></span> <input
					class="dual-element-row" type="submit" value="Submit">
			</form>
		</div>
	</section>

	<script>
		document
				.getElementById("resetPasswordForm")
				.addEventListener(
						"submit",
						function(event) {

							const oldPassword = document
									.getElementById("oldPassword").value;
							const newPassword = document
									.getElementById("newPassword").value;
							const confirmPassword = document
									.getElementById("confirmPassword").value;
							const passwordError = document
									.getElementById("passwordError");

							if (oldPassword === newPassword) {
								passwordError.textContent = "New password cannot be the same as old password";
								event.preventDefault();
							} else if (newPassword !== confirmPassword) {
								passwordError.textContent = "New password and confirm password must match.";
								event.preventDefault();
							}
						});
	</script>
</body>

</html>