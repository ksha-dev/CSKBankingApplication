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
<script src="static/script/validator.js"></script>
<script src="static/script/signup.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://www.google.com/recaptcha/enterprise.js" async defer>
	
</script>
<script>
	
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("errorMessage('" + error + "')");
}%>
	
</script>
</head>

<body class="login">
	<div class="signup-align">
		<div class="signup-container">
			<h1 class="signup-element">Sign Up</h1>
			<p class="signup-element" style="margin-bottom: 20px;">Enter the
				following details to register user</p>
			<form action="app/signup" method="post" id="signup-form">
				<div class="signup-splitter">
					<label for="firstName" style="margin-bottom: 10px;">First
						Name</label> <input type="text" id="firstName"
						name="<%=Parameters.FIRSTNAME.parameterName()%>"
						class="login-element" required><span id="e-firstName"
						class="error-text""></span> <label for="lastName"
						style="margin-bottom: 10px;" class="login-element">Last
						Name</label> <input type="text" id="lastName"
						name="<%=Parameters.LASTNAME.parameterName()%>"
						class="login-element" required><span id="e-lastName"
						class="error-text""></span> <label for="dob"
						style="margin-bottom: 10px;">Date of Birth</label> <input
						id="dateOfBirth" type="date"
						name="<%=Parameters.DATEOFBIRTH.parameterName()%>"
						class="login-element" required><span id="e-dateOfBirth"
						class="error-text""></span> <label for="phone"
						style="margin-bottom: 10px;" class="login-element">Phone
						Number</label> <input type="number" id="phone"
						name="<%=Parameters.PHONE.parameterName()%>" class="login-element"
						required><span id="e-phone" class="error-text""></span> <label
						for="gender" style="margin-bottom: 10px;" class="login-element">Gender</label>
					<select name="gender" id="gender" style="" required>
						<option value=null style="display: none;">Select</option>
						<%for (Gender gender : Gender.values()) {%>
						<option value="<%=gender%>"><%=gender%></option>
						<%}%>
					</select><span id="e-gender" class="error-text""></span>
					<div class="g-recaptcha" data-theme="dark" id="recaptch-element"
						style="margin: 10px 0px"
						data-sitekey="6Lfk5-YpAAAAAI5tbo0SdcZFcNTX1FVikXO0jAxi"
						data-action="LOGIN"></div>
					<span id="e-captcha" class="error-text""></span><input
						class="login-element" type="submit" value="Sign Up">
				</div>
				<div class="signup-splitter">
					<label for="email" style="margin-bottom: 10px;">Email
						Address</label> <input type="email" id="email"
						name="<%=Parameters.EMAIL.parameterName()%>" class="login-element"
						required> <span id="e-email" class="error-text""></span><label
						for="address" class="login-element">Address</label> <input
						type="text" name="<%=Parameters.ADDRESS.parameterName()%>"
						id="address" class="login-element" required><span
						id="e-address" class="error-text""></span> <label for="aadhaar"
						style="margin-bottom: 10px;">Aadhaar Number</label> <input
						id="aadhaar" type="number"
						name="<%=Parameters.AADHAAR.parameterName()%>"
						class="login-element" required><span id="e-aadhaar"
						class="error-text""></span> <label for="pan" class="login-element">PAN
						Number</label> <input type="text" id="pan"
						name="<%=Parameters.PAN.parameterName()%>" class="login-element"
						required><span id="e-pan" class="error-text""></span>
				</div>
			</form>
			<br>
			<p class="signup-element">
				Registered user, <a href="login"
					style="color: white; font-weight: bold;">Click here to Login</a>
			</p>
		</div>
	</div>
</body>
</html>