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
<link rel="stylesheet" href="../static/css/styles.css">
<script src="../static/script/script.js"></script>
<script src="../static/script/validator.js"></script>
<script src="../static/script/reset_password_input.js"></script>
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
			<form action="complete_reset_password" id="reset-password-input-form"
				method="post">
				<label style="margin-bottom: 10px;">New Password</label> <input
					id="newPassword" type="password"
					name="<%=Parameters.NEWPASSWORD.parameterName()%>"
					class="login-element" required> <span class="error-text"
					id="e-newPassword"></span> <label class="login-element">Confirm
					Password</label> <input id="confirmPassword" type="password"
					name="<%=Parameters.CONFIRM_PASSWORD.parameterName()%>"
					class="login-element" required> <span class="error-text"
					id="e-confirmPassword"></span> <input type="hidden" name="id"
					value="<%=request.getParameter("id")%>"> <input
					class="login-element" type="submit" value="Submit"
					style="margin-top: 20px;">
			</form>
		</div>
	</div>
</body>

</html>