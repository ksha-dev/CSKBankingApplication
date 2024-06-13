
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("pragma", "no-cache");
response.setHeader("Expires", "0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Blocked | CSK Bank</title>
<link rel="stylesheet" href="../static/css/styles.css">
<script src="../static/script/script.js"></script>
<script>
<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");%>
	errorMessage('<%=error%>');
<%}%>
	
</script>
</head>

<body class="login">
	<div class="signup-align">
		<div class="login-container"
			style="align-items: flex-start; max-width: 30%;">
			<h1 class="signup-element">User Blocked</h1>
			<p class="signup-element" style="margin-bottom: 20px;">You have
				been blocked for malicious activities. Please contact Administrator
				for further instructions</p>
			<p class="signup-element">
				<a href="/CSKBankingApplication/login"
					style="color: white; font-weight: bold;">Home</a>
			</p>
		</div>
	</div>
</body>
</html>