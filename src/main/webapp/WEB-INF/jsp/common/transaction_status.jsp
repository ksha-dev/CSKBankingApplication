<%@page import="modules.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Status</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%
	boolean status = (boolean) request.getAttribute("status");
	String message = (String) request.getAttribute("message");
	String redirect = (String) request.getAttribute("redirect");
	%>

	<form
		<%=redirect.equals("back") ? "" : "action=\"" + redirect + "\" method=\"get\""%>
		class="login-container"
		style="width: 300px; display: flex; flex-direction: column; align-items: center;">

		<h3>
			<%=status ? "Success" : "Unable to Process"%>
		</h3>
		<br>
		<p style="text-align: center;"><%=message%></p>
		<br> <br>
		<button class="button-85" type="submit"
			<%=redirect.equals("back") ? "onclick=\"history.back()\"" : ""%>>Finish</button>
	</form>
</body>

</html>