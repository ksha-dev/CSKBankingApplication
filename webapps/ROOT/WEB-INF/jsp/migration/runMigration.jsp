
<%@page import="com.cskbank.exceptions.AppException"%>
<%@page import="com.cskbank.utility.ServletUtil"%>
<%@page import="com.cskbank.test.MickeyLiteTest"%>
<%
try {
	MickeyLiteTest.initDB();
	request.getSession().setAttribute("error", "Database initialized");
	response.sendRedirect("/login");
} catch (Exception e) {
	ServletUtil.redirectError(request, response, new AppException(e));
}
%>
