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
<script src="static/script/validator.js"></script>
<script src="static/script/login.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://www.google.com/recaptcha/enterprise.js" async defer></script>
<script>
	
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("errorMessage('" + error + "')");
}%>
	
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
					id="userId" type="number"
					name="<%=Parameters.USERID.parameterName()%>" class="login-element"
					required> <span class="error-text" id="e-userId"></span> <label
					for="password" class="login-element">Password</label> <input
					id="password" type="password"
					name="<%=Parameters.PASSWORD.parameterName()%>"
					class="login-element" required> <span class="error-text"
					id="e-password"></span> <label>Human Verification</label>
				<div class="g-recaptcha" data-theme="dark" id="captcha"
					style="margin: 10px 0px"
					data-sitekey="6Lfk5-YpAAAAAI5tbo0SdcZFcNTX1FVikXO0jAxi"
					data-action="LOGIN"></div>
				<span class="error-text" id="e-captcha"></span> <input
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
</body>

</html>