<%@page import="modules.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Transaction Status</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%
	boolean status = (boolean) request.getAttribute("status");
	String message = (String) request.getAttribute("message");
	String operation = (String) request.getAttribute("operation");
	String redirect = (String) request.getAttribute("redirect");
	%>
	<form action="<%=redirect%>" method="get" class="login-container"
		style="width: 300px; display: flex; flex-direction: column; align-items: center;">

		<h3>
			<%=status ? "Success" : "Unable to Process"%>
		</h3>
		<br>
		<p style="text-align: center;"><%=message%></p>
		<br> <br>
		<button class="button-85" type="submit">Finish</button>
	</form>
</body>

</html>