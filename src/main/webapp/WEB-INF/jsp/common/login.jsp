<%@page import="com.cskbank.filters.Parameters"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("pragma", "no-cache");
response.setHeader("Expires", "0");
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | CSK Bank</title>
<link rel="stylesheet" href="static/css/styles.css">
<script src="static/script/script.js"></script>
<script src="https://www.google.com/recaptcha/enterprise.js" async defer>
	</script>
<script>
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");%>
	errorMessage('<%=error%>');
<%}%>
</script>
</head>

<body class="login">
	<div class="login-align">
		<div class="login-container">
			<h1 class="login-element">Login</h1>
			<p class="login-element" style="margin-bottom: 20px;">Enter your
				User ID and Password</p>
			<form action="app/login" id="login-form" method="post">
				<label for="userId" style="margin-bottom: 10px;">User ID</label> <input
					type="number" name="<%=Parameters.USERID.parameterName()%>"
					class="login-element" required> <label for="password"
					class="login-element">Password</label> <input type="password"
					name="<%=Parameters.PASSWORD.parameterName()%>"
					class="login-element"
					pattern="(?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20}"
					title="Must start with a letter, contain at least one number, uppercase, lowercase letter, special character and at least 8 or more characters"
					required> <label>Human Verification</label>
				<div class="g-recaptcha" data-theme="dark" id="recaptch-element"
					style="margin: 10px 0px"
					data-sitekey="6LeyIuYpAAAAABrOOV8oTgPY0BXUAwbq1FXoIPtf"></div>
				<span id="error-captcha" style="color: red;"></span> <input
					class="login-element" type="submit" value="Login"
					style="margin-top: 20px;">
			</form>
			<br>
			<p>
				New User, <a href="signup" style="color: white; font-weight: bold;">Click
					here to Sign up</a>
			</p>
		</div>
	</div>
	<script>
		const form = document.getElementById('login-form');
		const error = document.getElementById('error-captcha');

		
		form.addEventListener('submit', (e) => {		
			const captchaResponse = grecaptcha.enterprise.getResponse();
			if(captchaResponse.length < 1) {
				e.preventDefault();
				error.textContent = 'Please click here to verify';
				setTimeout(() => {
					error.textContent = null;
				}, 5000);
			}
		});
	</script>
</body>
</html>