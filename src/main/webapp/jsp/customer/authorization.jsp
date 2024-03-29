<%@page import="modules.Transaction"%>
<%@page import="utility.ValidatorUtil"%>
<%@page import="exceptions.AppException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Authorization</title>
<%@include file="../../include/head.jsp"%>
</head>

<body>
	<form action="app" method="post" class="login-container"
		style="width: 300px; display: flex; flex-direction: column; align-items: start;">
		<h3>
			Authorization
			<%=request.getParameter("redirect")%>
		</h3>
		<br>
		<p style="text-align: justify;">The four digit iPIN is required to
			complete the transaction. Please enter your iPIN below</p>
		<br> <input type="password" name="pin" placeholder="iPIN"
			inputmode="numeric" pattern="[0-9]{4}"
			title="PIN must contain 4 digits exactly" required> <input
			type="hidden" name="route"
			value="<%=request.getParameter("redirect")%>"> <br>
		<button class="button-85" type="submit">Submit</button>
	</form>
</body>

</html>