<%-- $Id$ --%>
<%@page import="com.zoho.resource.task.TaskExecutor.QueueInfoKey"%>
<%@page import="com.zoho.accounts.internal.zac.ZACUtil"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.List"%>
<%@page import="com.zoho.accounts.internal.util.Util"%>
<%!private static final Logger LOGGER = Logger.getLogger("QueueStatus"); %>
<head>
	<style>
		table, th, td {
			border: 1px solid black;
			border-collapse: collapse;
			overflow-x: auto;
    			white-space: nowrap;
		}
		td{
			width: 25%;		
		}
	</style>
</head>
<body>
<table style="width:100%">
<% 
try{
	boolean isFirst = true;
	TreeSet<String> dataOrder = new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	Map<String, String> serverStatus = Util.getQueuesStatusOfAllServers(ZACUtil.getIAMServerIps());
	out.println("<h3>Audit Queue Status<br>Total Server count : "+serverStatus.keySet().size()+"</h3>"); //No I18N
	for(String serverIp: serverStatus.keySet()){
		try{
			JSONObject obj = new JSONObject(serverStatus.get(serverIp));
			if(com.adventnet.iam.internal.Util.isValid(obj)){
				if(isFirst){
					for(String key:obj.keySet()){
						dataOrder.add(key);
					}
					out.println("</tr><th>Server IpAddress</th>"); //No I18N
					for(String key:dataOrder){
						out.println("<th>"+key+"</th>"); //NO OUTPUTENCODING //No I18N
					}
					out.println("</tr>");
					isFirst = false;
				}
			%>
			<%
				out.println("<tr>"); //No I18N
				out.println("<td><p style=\"color:navy;text-align:center;\"><b>"+serverIp+"</p></b></td>"); //No I18N
				for(String key:dataOrder){
					float queuePerc = obj.getJSONObject(key).optFloat(QueueInfoKey.QUEUE_OCCUPIED_PERCENT.getValue(), 0);
					if(queuePerc>50f){
						out.println("<td bgcolor=\"red\" style=\"padding:10px\">");
					}else if(queuePerc>25f && queuePerc<50f){
						out.println("<td bgcolor=\"yellow\" style=\"padding:10px\">");
					}else if(obj.getJSONObject(key).optInt(QueueInfoKey.CURRENT_QUEUE_SIZE.getValue(), 0) > 0){
						out.println("<td bgcolor=\"lightgreen\" style=\"padding:10px\">");
					}else if(obj.getJSONObject(key).optInt(QueueInfoKey.ACTIVE_THREAD_COUNT.getValue(), 0) > 0){
						out.println("<td bgcolor=\"lightskyblue\" style=\"padding:10px\">");
					}else{
						out.println("<td style=\"padding:10px\">");	
					}
					for(String objKey:obj.getJSONObject(key).keySet()){
						if(obj.getJSONObject(key).getInt(objKey) == -1){
							out.print(objKey+" = INFINITE<br>");  //No I18N
						}else{
							out.print(objKey+" = "+obj.getJSONObject(key).getInt(objKey)+"<br>");	
						}
					}
					out.println("</td>"); //NO OUTPUTENCODING //No I18N	
				}
				out.println("</tr>"); //No I18N
			}else{
				LOGGER.log(Level.SEVERE,"Invalid object {0}", new Object[]{serverStatus.toString()});
			}
		}catch(Exception e){
			LOGGER.log(Level.SEVERE,"Error occured "+serverStatus.toString(), e);
		}
	}
}catch(Exception e){
	LOGGER.log(Level.WARNING, "Exception in getting status of queues",e);
	out.println("Exception in getting status of queues"); //No I18N
}
%>
</table>
</body>