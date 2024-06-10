<%@page import="com.cskbank.handlers.CaptchaHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Captcha</title>
</head>
<body>
	<img alt="captch"
		src="data:image/png;base64, <%=CaptchaHandler.getCaptchaImageByteString()%>">
</body>
</html>