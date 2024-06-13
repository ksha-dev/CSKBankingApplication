<%--$Id$--%>
<%@page import="java.util.List"%>
<%@page import="com.zoho.accounts.cache.MemCacheConstants"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster.ClusterNode"%>
<%@page import="com.zoho.zat.guava.common.net.HostAndPort"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.zoho.accounts.internal.admin.CacheMetrics"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.zoho.jedis.v390.exceptions.JedisDataException"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.zoho.resource.RedisMessageProto.IAMNotification"%>
<%@page import="com.zoho.accounts.messaging.RedisMessageHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.adventnet.iam.IAMProxy"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@page import="com.zoho.resource.ResourceProto.ResourceMetaData.ChildResource"%>
<%@page import="com.zoho.resource.ResourceProto.ResourceMetaData"%>
<%@page import="com.zoho.resource.ResourceMetaDataUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.jedis.v390.Jedis"%>
<%@page import="com.zoho.resource.Representation"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.CLUSTERNODE"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.CACHECLUSTER"%>
<%@page import="com.zoho.accounts.AppResource"%>
<%@page import="com.zoho.resource.URI"%>
<%@page import="com.zoho.resource.redis.RedisStats"%>
<%
response.setHeader("Content-Type", "application/json"); //No I18N
if (request.getParameter("instances") != null) {
	CacheMetrics.getInstances(out);
} else if (request.getParameter("refresh") != null) {
	CacheMetrics.refreshStats();
} else if (request.getParameter("flush") != null) {
	if (AccountsConfiguration.getConfiguration("redis.stats.flush.allow", "$a").matches(IAMUtil.getCurrentUser().getZUID() + "")) { //No I18N
		CacheMetrics.flushStats();
	}
} else if (request.getParameter("get") != null) {
	CacheMetrics.get(request.getParameter("instance"), null, out);
} else if (request.getParameter("pget") != null) {
	CacheMetrics.get(request.getParameter("instance"), request.getParameter("pattern") + ".*", out);
} else if (request.getParameter("cachestats") != null) {
	int op = Integer.valueOf(request.getParameter("op"));
	switch (op) {
		case 1: {
			getInstances(out);
			break;
		}
		case 2: {
			getConnectedServices(request.getParameter("ip"), Integer.valueOf(request.getParameter("port")), out);
			break;
		}
		case 3: {
			getDistribution(out);
			break;
		}
		case 4: {
			CacheMetrics.reInitServiceMap();
			break;
		}
	}
} else if (request.getParameter("message") != null) {
		out.println("{\"data\" :  " + publishMessage(request.getParameter("target"), request.getParameter("pool"), request.getParameter("dep")) + "}");//No I18N
}

else {
%>
{"status":false}<%--No I18N--%>
<%
}
%>

<%!//Temp Cache mon f/n s follow
	Logger logger = Logger.getLogger("RedisStats");//No I18N

	void getInstances(JspWriter out) throws Exception {
		URI clusterURI = AppResource.getCacheClusterURI();
		clusterURI.addSubResource(CLUSTERNODE.table());
		JSONArray response = new JSONArray();
		for (CacheCluster c : (CacheCluster[]) clusterURI.GETS()) {
			JSONObject cobj = new JSONObject();
			cobj.put("cluster_name", c.getClusterName());//No I18N
			JSONArray nodeArray = new JSONArray();
			for (ClusterNode node : c.getClusterNodeList()) {
				nodeArray.put(new JSONObject().put("node_name", node.getNodeName()).put("server_ip_port", node.getServerIpPort()).put("server_ip", node.getServerIpPort().split(":")[0])); //No I18N
			}
			cobj.put("nodes", nodeArray);//No I18N
			response.put(cobj.toString());
		}
		out.print(response.toString());
	}

	String lookupServiceFromIP(String ip) {
		return CacheMetrics.getServiceName(ip);
	}

	void getConnectedServices(String ip, int port, JspWriter out) throws Exception {
		JSONObject total = new JSONObject();
		JSONArray response = new JSONArray();
		try {
			Jedis cli = new Jedis(ip, port);
			HashMap<String, String> serviceMap = new HashMap<String, String>();
			String clients[] = cli.clientList().split("\n"); //No I18N
			String mem = cli.info("memory");//No I18N
			String repl = cli.info("replication");//No I18N
			cli.close();
			total.put("repl", repl);//No I18N
			total.put("mem", mem);//No I18N
			for (String client : clients) {
				HashMap<String, String> cMap = getClientMap(client);
				String cmd = cMap.get("cmd").toLowerCase();
				if (cmd.contains("hincrby") || cmd.contains("ping") || cmd.contains("replconf")) {//No I18N
					continue;
				}
				HostAndPort hostPort = HostAndPort.fromString(cMap.get("addr"));
				serviceMap.put(hostPort.getHost(), cMap.get("name"));//No I18N
			}
			for (String ipKey : serviceMap.keySet()) {
				JSONObject jobj = new JSONObject();
				jobj.put("IP", ipKey);//No I18N
				jobj.put("NAME", serviceMap.get(ipKey));//No I18N
				response.put(jobj);
			}
			total.put("data", response);//No I18N
		} catch (Exception e) {
			response.put(e.toString());
		}
		out.print(total);
	}

	private HashMap<String, String> getClientMap(String clientInfo) {
		HashMap<String, String> clientMap = new HashMap<String, String>();
		if (clientInfo != null && !clientInfo.isEmpty()) {
			String attributes[] = clientInfo.split(" ");
			for (String attribute : attributes) {
				String[] keyVal = attribute.split("=");
				if (keyVal.length != 2) {
					clientMap.put(keyVal[0], "Unknown"); //No I18N
				} else {
					clientMap.put(keyVal[0], keyVal[1]);
				}
			}
		}

		if (!clientMap.containsKey("name")) { //No I18N
			clientMap.put("name", "Unknown"); // No I18N
		}
		if (!clientMap.containsKey("cmd")) { //No I18N
			clientMap.put("cmd", "Unknown"); // No I18N
		}
		if (!clientMap.containsKey("addr")) { //No I18N
			clientMap.put("addr", "127.0.0.1:6379"); // No I18N
		}
		return clientMap;
	}

	void getAllTables(ResourceMetaData rmd, StringBuilder builder) {
		builder.append("\"" + rmd.getTableName() + "\",");
		for (ChildResource cr : rmd.getChildResourceList()) {
			getAllTables(ResourceMetaDataUtil.getInstance(cr.getResourceName()), builder);
		}
	}

	JSONArray publishMessage(String target, String pool, String deployment) {
		String method = "clearCacheConfiguration";//No I18N
		String className = RedisMessageHandler.class.getName();
		long recvCount = 0;
		long totalCount = 0;
		Jedis pubsubClient = null;
		JSONArray result = new JSONArray();
		int itr = 0;
		try {
			URI u = AppResource.getCacheClusterURI("messagepool" + deployment);//No I18N
			u.addSubResource(CLUSTERNODE.table());
			for(ClusterNode node : ((CacheCluster) u.GET()).getClusterNodeList()) {
				JSONObject data = new JSONObject();
				List<String> pools = new ArrayList<String>();
				itr++;
				HostAndPort hostPort = HostAndPort.fromString(node.getServerIpPort());
				data.put("ip", hostPort.getHost());//No I18N
				pubsubClient = new Jedis(hostPort.getHost(),hostPort.getPort());
				IAMNotification.Builder proto = IAMNotification.newBuilder();
				proto.setCreatedtime(System.currentTimeMillis());
				proto.setDestination(target);
				proto.setHandler(className);
				proto.setMethod(method);
				proto.setSource("AaaServer");//No I18N
				//Just for backward compatibility, can be removed after milestone movement
				if(pool.equals("all")) {//No I18N
					for(String cachepool : MemCacheConstants.getPools()) {
						JSONArray arr = new JSONArray();
						arr.put(IAMUtil.getCurrentTicket());
						arr.put(cachepool); 
						proto.setMessage(arr.toString());
						recvCount = pubsubClient.publish(target, proto.build().toByteString().toString("ISO-8859-1"));//No I18N
						totalCount += recvCount;
						pools.add(cachepool);
						pubsubClient.close();
					}
				}
				JSONArray arr = new JSONArray();
				arr.put(IAMUtil.getCurrentTicket());
				arr.put(pool);
				proto.setMessage(arr.toString());
				recvCount = pubsubClient.publish(target, proto.build().toByteString().toString("ISO-8859-1"));//No I18N
				totalCount += recvCount;
				pools.add(pool);
				data.put("count", totalCount);//No I18N
				data.put("pools", pools);//No I18N
				result.put(data);
				pubsubClient.close();
				totalCount = 0;
			}
		} catch (Exception e) {
			logger.log(Level.WARNING, "Exception while publishing message to {0}, pool {1}, dep {2}, {3}", new Object[]{target,pool,deployment, e});
		}
		return result;
	}

	void getDistribution(JspWriter out) throws Exception {
		JSONArray response = new JSONArray();
		try {
			URI clusterURI = AppResource.getCacheClusterURI();
			clusterURI.addSubResource(CLUSTERNODE.table());
			CacheCluster[] allClusters = (CacheCluster[]) clusterURI.GETS();
			for (CacheCluster cluster : allClusters) {
				if (!cluster.getClusterName().contains("_") || cluster.getClusterName().endsWith("_RC")) {//No I18N
					continue;
				}
				HostAndPort hostPort = HostAndPort.fromString(cluster.getClusterNode(0).getServerIpPort());
				Jedis cli = new Jedis(hostPort.getHost(), hostPort.getPort());
				HashMap<String, JSONArray> serviceSet = new HashMap<String, JSONArray>();
				String clients[] = cli.clientList().split("\n"); //No I18N
				cli.close();
				for (String client : clients) {
					String comp[] = client.split(" ");//No I18N
					String cmd = comp[17].toLowerCase();
					String ip = HostAndPort.fromString(comp[1].split("=")[1]).getHost();//No I18N
					if (cmd.contains("hincrby") || cmd.contains("subscribe") || cmd.contains("ping") || cmd.contains("replconf")) {//No I18N
						continue;
					}
					String sName = lookupServiceFromIP(ip) + '_' + hostPort.getHost();
					if (serviceSet.get(sName) == null) {
						serviceSet.put(sName, new JSONArray());
					}
					serviceSet.get(sName).put(ip);
				}
				for (Entry<String, JSONArray> service : serviceSet.entrySet()) {
					JSONObject obj = new JSONObject();
					obj.put("name", service.getKey().split("_")[0]);//No I18N
					obj.put("redis", service.getKey().split("_")[1]);//No I18N
					obj.put("ips", service.getValue());//No I18N
					obj.put("value", 30);//No I18N
					if (cluster.getClusterName().endsWith("_SV4") || cluster.getClusterName().endsWith("_LZ") || cluster.getClusterName().endsWith("_eu1")) {//No I18N
						obj.put("className", "sv4");//No I18N
					} else {
						obj.put("className", "ny4");//No I18N
					}
					response.put(obj);
				}
			}
		} catch (Exception e) {
		}
		out.print(response.toString());
	}
%>