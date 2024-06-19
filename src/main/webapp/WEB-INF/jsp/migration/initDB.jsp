
<%@page import="com.cskbank.test.MickeyLiteTest"%>
<%
MickeyLiteTest.initDB();
request.getSession().setAttribute("error", "Database initialized");
response.sendRedirect("/");
%>