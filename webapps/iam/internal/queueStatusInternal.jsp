<%-- $Id$ --%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.accounts.internal.util.Util"%>
<%
JSONObject obj = Util.getAllQueueInfo();
out.print(obj.toString());
%>