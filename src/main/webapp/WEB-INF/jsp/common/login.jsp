<%@page import="filters.Parameters"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("pragma", "no-cache");
response.setHeader("Expires", "0");
String error = (String) request.getSession(false).getAttribute("error");
%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | CSK Bank</title>
<link rel="stylesheet" href="static/css/styles.css">

<%
if (!Objects.isNull(error)) {
	request.getSession(false).removeAttribute("error");%>
<script>
	setTimeout(function() {
		alert("<%=error%>");
	}, 100);
</script>
<%}%>
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
					required> <input class="login-element" type="submit"
					value="Login" style="margin-top: 20px;">
			</form>
		</div>
	</div>
</body>
</html>