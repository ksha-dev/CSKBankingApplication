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
<title>Sign Up | CSK Bank</title>
<link rel="stylesheet" href="static/css/styles.css">
<script src="static/script/script.js"></script>
<script>
<%String error = (String) request.getSession(false).getAttribute("error");
if (error!=null) { request.getSession(false).removeAttribute("error");%>
	errorMessage('<%=error%>');
<%}%>
</script>
</head>

<body class="login">
	<div class="signup-align">
		<div class="signup-container">
			<h1 class="signup-element">Sign Up</h1>
			<p class="signup-element" style="margin-bottom: 20px;">Enter the
				following details to register user</p>
			<form action="app/signup" method="post">
				<div class="signup-splitter">
					<label for="firstName" style="margin-bottom: 10px;">First Name</label> 
					<input type="text" name="<%=Parameters.FIRSTNAME.parameterName()%>" class="login-element" required>
					<label for="lastName" style="margin-bottom: 10px;" class="login-element">Last Name</label> 
					<input type="text" name="<%=Parameters.LASTNAME.parameterName()%>" class="login-element" required> 
					<label for="dob" style="margin-bottom: 10px;">Date of Birth</label> 
					<input type="date" name="<%=Parameters.DATEOFBIRTH.parameterName()%>" class="login-element" id="dob" required>
					<label for="phone" style="margin-bottom: 10px;" class="login-element">Mobile Number</label> 
					<input type="number" name="<%=Parameters.PHONE.parameterName()%>" class="login-element" required>
					<label for="gender" style="margin-bottom: 10px;" class="login-element">Gender</label> 
					<select name="gender" id="gender" style="margin-top" required>
						<option value=null style="display: none;">Select</option>
						<%for (Gender gender : Gender.values()) {%>
						<option value="<%=gender%>"><%=gender%></option>
						<%}%>
					</select>
					<input class="login-element" type="submit" value="Sign Up" style="margin-top: 50px;">
				</div>
				<div class="signup-splitter">
					<label for="email" style="margin-bottom: 10px;">Email Address</label> 
					<input type="email" name="<%=Parameters.EMAIL.parameterName()%>" class="login-element" required>
					<label for="address" class="login-element">Address</label> 
					<input type="text" name="<%=Parameters.ADDRESS.parameterName()%>" class="login-element" required> 
					<label for="aadhaar" style="margin-bottom: 10px;">Aadhaar Number</label> 
					<input type="text" name="<%=Parameters.AADHAAR.parameterName()%>" class="login-element" required>
					<label for="pan" class="login-element">PAN Number</label> 
					<input type="text" name="<%=Parameters.PAN.parameterName()%>" class="login-element" required> 
				</div>
			</form>
			<br>
			<p class="signup-element">
				Registered user, <a href="login" style="color: white; font-weight: bold;">Click
					here to Login</a>
			</p>
		</div>
	</div>
</body>

<script>
	const dob = document.getElementById('dob');
	var currentDate = new Date();
	dob.max = currentDate.toISOString().split('T')[0];
</script>
</html>