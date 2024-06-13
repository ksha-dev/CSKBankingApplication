<%@page import="org.json.JSONObject"%>
<%@ page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@ page import="com.adventnet.iam.security.*"%>
<%@ page isErrorPage="true"%>
<%
IAMSecurityException ex = (IAMSecurityException) request.getAttribute(IAMSecurityException.class.getName());
Exception exp = (ServletException) request.getAttribute(ServletException.class.getName());
String errorCode = null;
if (ex != null && (errorCode = ex.getErrorCode()) != null) {
%>
<html>
<body>
	<b>CSKBANK | Server error occured. Please try again after sometime</b>
	<p><%=(exp != null) ? exp.getMessage() : ""%></p>
	<p><%=(ex != null) ? ex.getMessage() : ""%></p>
	<p>
		<%
		if (ex != null)
			ex.printStackTrace();
		%>
	</p>
</body>
</html>
<%
}
%>