<%@page import="com.cskbank.filters.Parameters"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="com.cskbank.utility.ValidatorUtil"%>
<%@page import="com.cskbank.exceptions.AppException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Authorization</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<form action="authorization" method="post" class="login-container"
		style="width: 300px; display: flex; flex-direction: column; align-items: start;">
		<h3>Authorization</h3>
		<br>
		<p style="text-align: justify;">The four digit iPIN is required to
			complete the transaction. Please enter your iPIN below</p>
		<br> <input type="password"
			name="<%=Parameters.PIN.parameterName()%>" placeholder="iPIN"
			inputmode="numeric" pattern="[0-9]{4}"
			title="PIN must contain 4 digits exactly" required> <input
			type="hidden" name="<%=Parameters.OPERATION.parameterName()%>"
			value="<%=request.getSession(false).getAttribute("redirect")%>">
		<br>
		<button class="button-85" type="submit">Submit</button>
	</form>
</body>

</html>