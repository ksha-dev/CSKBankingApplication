<%-- $Id$ --%>
<%@ page import = "com.adventnet.client.components.table.web.*, com.adventnet.client.util.web.*"%>
<%@page import="com.zoho.authentication.AuthenticationUtil"%>

<%
String viewName = request.getParameter("VIEWNAME");
String sortColumn = request.getParameter("SORTCOLUMN");
String order = request.getParameter("SORTORDER");
String pageLength = request.getParameter("PAGELENGTH");
if(sortColumn != null){
	TablePersonalizationUtil.updateSortForView(viewName, AuthenticationUtil.getAccountID(), sortColumn, order);
}
if(pageLength != null){
	TablePersonalizationUtil.updatePageLengthForView(viewName, AuthenticationUtil.getAccountID(), Integer.parseInt(pageLength));
}
%>
