<%@page import="com.cskbank.utility.ConstantsUtil.Gender"%>
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
<title>OTP Verification | CSK Bank</title>
<link rel="stylesheet" href="../static/css/styles.css">
<script src="../static/script/script.js"></script>
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("<script>errorMessage('" + error + "')</script>");
}%>
</head>

<body class="login">
	<div class="login-align">
		<div class="signup-container" style="max-width: 40%;">
			<h1 class="login-element">Verification</h1>
			<p class="login-element" style="margin-bottom: 20px;">An email
				was sent to the email address you have provided. Please enter the
				one time password (OTP) displayed in the mail. If the OTP is entered
				incorrectly for five consecutive times, sign up process will be
				blocked</p>
			<form action="verification" method="post" style="display: block;">
				<input type="text" name="otp" placeholder="Enter OTP"
					pattern="^\d{6}$" title="OTP must be of 6 digits" min="0"
					max="999999" required> <br> <br> <input
					type="submit" value="Verify OTP">
			</form>
			<p class="login-element">
				<a href="resend" style="color: white; font-weight: bold;">Resend
					OTP</a>
			</p>
		</div>
	</div>
</body>
</html>