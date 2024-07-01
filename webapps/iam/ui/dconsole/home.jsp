<%--$Id$--%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%
String apiConsoleUrl = AccountsConfiguration.getConfiguration("iam.apiconsole.newurl", null); //No I18N
if(apiConsoleUrl != null) {
	response.sendRedirect(apiConsoleUrl);
	return;
}
response.sendError(404);
%>