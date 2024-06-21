<%-- $Id$ --%>
<%@page import="java.util.List"%>
<%@page import="com.zoho.accounts.internal.util.Util"%>
<%@page import="com.zoho.zat.guava.common.net.HostAndPort"%>
<%
        String[] ip = request.getParameterValues("ips");
        String csmode = request.getParameter("csmode");
		String usecases = request.getParameter("usecases"); 
		List<String> resp = Util.clearCache(ip, csmode, usecases);       
        for (String r : resp) {
            response.getWriter().println(r); //NO OUTPUTENCODING
            response.getWriter().println("<br>"); //No I18N
        }
%>
