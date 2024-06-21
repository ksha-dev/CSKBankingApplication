<%@page import="java.util.Iterator"%>
<%@page import="java.io.IOException"%>
<%@page import="com.cskbank.exceptions.AppException"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@ page import="com.adventnet.iam.security.*"%>
<%@ page isErrorPage="true"%>
<%
IAMSecurityException iamExp = (IAMSecurityException) request.getAttribute(IAMSecurityException.class.getName());
AppException appExp = (AppException) request.getAttribute(AppException.class.getName());
ServletException exp = (ServletException) request.getAttribute(ServletException.class.getName());
IOException ioExp = (IOException) request.getAttribute(IOException.class.getName());
%>
<html>
<body>
	<b>CSKBANK | Server error occured. Please try again after sometime</b>
	<br>

	<%
	Iterator<String> it = request.getAttributeNames().asIterator();
	while (it.hasNext()) {
		String name = it.next();
		out.println(name + " : " + request.getAttribute(name) + "<br><br>");
	}

	if (iamExp != null) {
		out.print(iamExp);
		out.print("<p>" + iamExp.getMessage() + "<br>" + iamExp.getErrorCode() + "</p>");
		iamExp.printStackTrace(response.getWriter());
	}
	if (appExp != null) {
		out.print(appExp);
		out.print("<p>" + appExp.getMessage() + "</p>");
		appExp.printStackTrace(response.getWriter());
	}
	if (exp != null) {
		out.print(exp);
		out.print("<p>" + exp.getMessage() + "</p>");
		exp.printStackTrace(response.getWriter());
	}

	if (ioExp != null) {
		out.print(ioExp);
		out.print("<p>" + ioExp.getMessage() + "</p>");
		ioExp.printStackTrace(response.getWriter());
	}
	%>
</body>
</html>