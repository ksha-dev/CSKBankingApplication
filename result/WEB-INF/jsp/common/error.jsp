<%@page import="org.json.JSONObject"%>
<%@ page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@ page import="com.adventnet.iam.security.*"%>
<%@ page isErrorPage="true"%>
<%
IAMSecurityException ex = (IAMSecurityException) request.getAttribute(IAMSecurityException.class.getName());
Exception exp = (ServletException) request.getAttribute(ServletException.class.getName());
String errorCode = null;
if (ex != null && (errorCode = ex.getErrorCode()) != null) {
	SecurityRequestWrapper secRequest = SecurityRequestWrapper.getInstance(request);
	ActionRule rule = secRequest.getURLActionRule();
	if (rule != null) {
		if (errorCode.equals(IAMSecurityException.INVALID_METHOD)) {
	response.getWriter().println("showmsg('Error ....');");
	return;
		} else if ("/api/token/create".equals(rule.getPath())
		&& errorCode.equals(IAMSecurityException.PATTERN_NOT_MATCHED)) {
	response.setContentType("application/json;charset=UTF-8");
	JSONObject obj = new JSONObject();
	obj.put("result", "failure");
	obj.put("cause", "Invalid input");

	response.getWriter().println(obj.toString());
	return;
		}
	} else {
%>
<html>
<body>
	<b>Server error occured. Please try again after sometime</b>
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
}
%>