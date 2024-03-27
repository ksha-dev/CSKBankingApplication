<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | CSK Bank</title>
<link rel="stylesheet" href="css/styles.css">
</head>

<body class="login">
	<div class="login-align">
		<div class="login-container">
			<h1 class="login-element">Login</h1>
			<p class="login-element" style="margin-bottom: 20px;">Enter your
				User ID and Password</p>
			<form action="app" id="login-form" method="post">
				<label for="userId" style="margin-bottom: 10px;">User ID</label> <input
					type="number" name="userId" class="login-element" required>
				<label for="password" class="login-element">Password</label> <input
					type="password" name="password" class="login-element"
					pattern="(?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20}"
					title="Must start with a letter, contain at least one number, uppercase, lowercase letter, special character and at least 8 or more characters"
					required> <input class="login-element" type="submit"
					value="Login" style="margin-top: 20px;"> <input
					type="hidden" name="route" value="login"> <span
					id="passwordError" style="color: red;"></span>
			</form>
		</div>
	</div>
</body>



</html>