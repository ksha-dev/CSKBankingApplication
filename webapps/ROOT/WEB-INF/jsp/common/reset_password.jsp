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
<title>Reset Password | CSK Bank</title>
<link rel="stylesheet" href="static/css/styles.css">
<script src="static/script/script.js"></script>
<script src="static/script/validator.js"></script>
<script src="static/script/reset_password.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://www.google.com/recaptcha/enterprise.js" async defer></script>
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("<script>errorMessage('" + error + "')</script>");
}%>
</head>

<body class="login">
	<div class="login-align">
		<div class="login-container">
			<h1 class="login-element">Reset Password</h1>
			<p class="login-element" style="margin-bottom: 20px;">Enter your
				User ID and respective Email ID</p>
			<form action="app/reset_password" id="reset-password-form"
				method="post">
				<label for="userId" style="margin-bottom: 10px;">User ID</label> <input
					id="userId" type="number"
					name="<%=Parameters.USERID.parameterName()%>" class="login-element"
					required> <span class="error-text" id="e-userId"></span> <label
					class="login-element">Email ID</label> <input id="email"
					type="email" name="<%=Parameters.EMAIL.parameterName()%>"
					class="login-element" required> <span class="error-text"
					id="e-email"></span> <label>Human Verification</label>
				<div class="g-recaptcha" data-theme="dark" id="captcha"
					style="margin: 10px 0px"
					data-sitekey="6LeyIuYpAAAAABrOOV8oTgPY0BXUAwbq1FXoIPtf"
					data-action="LOGIN"></div>
				<span class="error-text" id="e-captcha"></span> <input
					class="login-element" type="submit" value="Proceed"
					style="margin-top: 20px;">
			</form>
			<br>
			<p>
				<a href="login" style="color: white; font-weight: bold;">Go back
					to login</a>
			</p>
		</div>
	</div>
</body>

</html>