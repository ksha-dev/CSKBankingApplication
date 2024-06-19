<%@page import="com.cskbank.exceptions.AppException"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@ page import="com.adventnet.iam.security.*"%>
<%@ page isErrorPage="true"%>
<%
IAMSecurityException iamExp = (IAMSecurityException) request.getAttribute(IAMSecurityException.class.getName());
AppException appExp = (AppException) request.getAttribute(AppException.class.getName());
ServletException exp = (ServletException) request.getAttribute(ServletException.class.getName());
%>
<html>
<body>
	<b>CSKBANK | Server error occured. Please try again after sometime</b>
	<%
	if (iamExp != null) {
		out.print(iamExp);
		out.print("<p>" + iamExp.getMessage() + "<br>" + iamExp.getErrorCode() + "</p>");
	}
	if (appExp != null) {
		out.print(appExp);

		out.print("<p>" + appExp.getMessage() + "</p>");
	}
	if (exp != null) {
		out.print(exp);
		out.print("<p>" + exp.getMessage() + "</p>");
	}
	%>
</body>
</html>