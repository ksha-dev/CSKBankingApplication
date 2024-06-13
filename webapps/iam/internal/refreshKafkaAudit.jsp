<%-- $Id$ --%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.zoho.resource.AuthHeader"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.adventnet.iam.internal.audit.IAMKafkaPartitioner"%>
<%
	String[] ip = request.getParameterValues("ips");
	if (ip != null) {
		String iscSignature = SecurityUtil.sign();
		String actionUrl = "internal/refreshKafkaAudit.jsp?action=clear"; //No I18N
		//Pass ISCSignature in Header
		Map<String, String> headers = new HashMap<String, String>();
		headers.put(AuthHeader.SYSTEM_AUTHORIZATION, "SystemAuth "+ iscSignature); // No I18N
		if(Util.isParamIscSignatureEnabled()) {
			actionUrl = actionUrl + "&iscsignature="+iscSignature; // No I18N
		}
		for (String i : ip) {
			i = i.trim();
			if (!i.contains(":")) {
				i += ":8080"; //No I18N
			}
			if (!i.endsWith("/")) {
				i += "/";//No I18N
			}
			response.getWriter().println(i + "::::" + com.adventnet.iam.internal.Util.getResponseAsProperties("http://" + i + actionUrl, 30000, headers)); //NO OUTPUTENCODING //No I18N
			response.getWriter().println("<br>"); //No I18N //NO OUTPUTENCODING
		}
	} else {
		IAMKafkaPartitioner.refreshMessageRate();
		out.println("Producer Refreshed"); //No I18N
	}	
%>