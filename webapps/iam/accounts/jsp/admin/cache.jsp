<%--$Id$ --%>
<%@page import="com.zoho.accounts.cache.MemCacheConstants.RedisAuth"%>
<%@page import="com.adventnet.iam.VOMap"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.zoho.accounts.internal.DeploymentSpecificConfiguration.SASDeployments"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="com.adventnet.sas.util.DBUtil"%>
<%@page import="com.zoho.resource.URI"%>
<%@page import="com.zoho.resource.Criteria"%>
<%@page import="com.zoho.resource.redis.JedisPoolUtil"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.CLUSTERNODE"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.NODERANGE"%>
<%@page import="com.zoho.accounts.AppResource"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.zoho.accounts.cache.MemCacheConstants"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.zoho.zat.guava.common.net.HostAndPort"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Map"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.internal.DeploymentSpecificConfiguration"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster.ClusterNode.NodeRange"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster.ClusterNode"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.jedis.v390.Jedis"%>
<%@page import="java.util.Properties"%>
<%@page import="org.json.JSONArray"%>
<%!
private class RedisClusterData {

	public final Logger LOGGER = Logger.getLogger(RedisClusterData.class.getName());

	private static final int PORT = 6379;
	private static final String GETSQL = "SELECT publicAddress.ADDRESS AS CIP, masterAddress.ADDRESS AS MIP, slaveAddress.ADDRESS AS SIP, secSlaveAddress.ADDRESS AS SSIP, PORT , MAXMEMORY, cat.CATEGORY FROM RedisCluster INNER JOIN GridAccount AS publicAccount ON publicAccount.ACCOUNTID = RedisCluster.CLUSTERID INNER JOIN GridAddress AS publicAddress ON publicAddress.ADDRESSID = publicAccount.ADDRESSID INNER JOIN GridAccount AS masterAccount ON masterAccount.ACCOUNTID = RedisCluster.MASTERID INNER JOIN GridAddress AS masterAddress ON masterAddress.ADDRESSID = masterAccount.ADDRESSID INNER JOIN GridAccount AS slaveAccount ON slaveAccount.ACCOUNTID = RedisCluster.SLAVEID INNER JOIN GridAddress AS slaveAddress ON slaveAddress.ADDRESSID = slaveAccount.ADDRESSID LEFT JOIN GridAccount AS secSlaveAccount ON secSlaveAccount.ACCOUNTID = RedisCluster.SECSLAVEID LEFT JOIN GridAddress AS secSlaveAddress ON secSlaveAddress.ADDRESSID = secSlaveAccount.ADDRESSID INNER JOIN RedisClusterCategory as cat on RedisCluster.CATEGORYID = cat.ID"; // No I18N

	public String clusterIp, masterIp, slaveIp, secondarySlaveIp, category;
	public long maxMem;
	public int port;

	RedisClusterData() {
		
	}
	
	RedisClusterData(List data) {
		this.clusterIp = (String) data.get(0);
		this.masterIp = (String) data.get(1);
		this.slaveIp = (String) data.get(2);
		this.secondarySlaveIp = (String) data.get(3);
		this.port = IAMUtil.getInt((String) data.get(4));
		this.maxMem = IAMUtil.getLong((String) data.get(5));
		this.category = (String) data.get(6);
	}

	public JSONObject toJson(String deployment) {
		JSONObject job = new JSONObject();
		job.put("cluster", clusterIp);//No I18N
		job.put("master", masterIp);//No I18N
		job.put("slave", slaveIp);//No I18N
		job.put("secondarySlave", secondarySlaveIp);//No I18N
		job.put("port", port);//No I18N
		job.put("category", category);//No I18N
		job.put("clusters", getCacheCluster(clusterIp, port));//No I18N
		JSONObject stats = getMachineStats(clusterIp, port, deployment);
		stats.put("maxMemory", (maxMem / 1024) + "GB");//No I18N
		job.put("stats", stats);//No I18N
		return job;
	}

	public JSONObject getMachineStats(String ip, int port, String deployment) {
		Jedis client = null;
		JSONObject out = new JSONObject();
		try {
			client = new Jedis(ip, port);
			String[] authCred = getRedisAuthCred(deployment.replaceAll("_", ""));
			if(authCred != null) {
				client.auth(authCred[0], authCred[1]);
			}
			JSONObject keyCount = new JSONObject();
			String info = client.info();
			for (String data : info.split("\n")) {// No I18N
				if (data.contains("instantaneous_ops_per_sec")) {// No I18N
					String instantObject[] = data.split(":");// No I18N
					out.put("iops", instantObject[1].trim());//No I18N
				} else if (data.contains("evicted_keys")) {// No I18N
					String evicted[] = data.split(":");
					out.put("evictedKeys", evicted[1].trim());//No I18N
				} else if (data.contains("keyspace_hits")) {//No I18N
					String hits[] = data.split(":");//No I18N
					out.put("hits", hits[1].trim());//No I18N
				} else if (data.contains("keyspace_misses")) {//No I18N
					String misses[] = data.split(":");//No I18N
					out.put("misses", misses[1].trim());//No I18N
				} else if (data.contains("used_memory_human")) {// No I18N
					String memory[] = data.split(":");// No I18N
					out.put("memory", memory[1].trim());//No I18N
				} else if (data.contains("used_memory_peak_human")) {// No I18N
					String peak[] = data.split(":");// No I18N
					out.put("memorypeak", peak[1].trim());//No I18N
				} else if (data.startsWith("db")) {// No I18N
					String databases[] = data.split(":");//No I18N
					keyCount.put(databases[0].split("db")[1], databases[1].split(",")[0].split("=")[1].trim());//No I18N
				} else if (data.contains("connected_clients")) {// No I18N
					out.put("clients", data.split(":")[1].trim());// No I18N
				}
			}
			out.put("keys", keyCount);//No I18N
		} catch (Exception e) {
			out.put("error", e.getMessage());//No I18N
		} finally {
			if (client != null) {
				client.close();
			}
		}
		return out;
	}

	public List<RedisClusterData> getRedisClusters() throws Exception {
		List result = DBUtil.getResultAsList(GETSQL, 7);
		if (result != null && !result.isEmpty()) {
			List<RedisClusterData> data = new ArrayList<RedisClusterData>();
			for (int i = 0; i < result.size(); i++) {
				data.add(new RedisClusterData((List) result.get(i)));
			}
			return data;
		}
		return null;
	}

	public String getDB(String property) {
		Properties properties = JedisPoolUtil.toProps(property);
		return properties.getProperty("database", "1");
	}
	public JSONObject getCacheCluster(String clusterIp, int port) {
		if (port == -1) {
			port = PORT;
		}
		String serverIp = clusterIp + ":" + port;
		JSONObject clusterJson = new JSONObject();
		try {
			Criteria criteria = new Criteria(CLUSTERNODE.SERVER_IP_PORT, serverIp);
			ClusterNode[] nodes = AppResource.getClusterNodeURI(URI.JOIN).getQueryString().setCriteria(criteria).build().GETS();
			if (nodes != null) {
				clusterJson = new JSONObject();
				for (ClusterNode node : nodes) {
					String cluster = node.getParent().getClusterName().toLowerCase();
					if(!cluster.startsWith("dummy_")) {
						String db = getDB(node.getCacheProperties());
						if(clusterJson.has(db)) {
							cluster = clusterJson.get(db) + "<br>" + cluster;
						}
						clusterJson.put(db, cluster);
					}
				}
			}
		} catch (Exception e) {
			clusterJson.put("error", e.getMessage());//No I18N
		}
		return clusterJson;
	}
	
	public List<CacheCluster> getDeploymentPools(String deployment) {
		try {
			CacheCluster[] clusters = (CacheCluster[]) AppResource.getCacheClusterURI().addSubResource(NODERANGE.table()).addSubResource(CLUSTERNODE.table()).GETS();
			if(clusters == null) {
				return null;
			}
			List<CacheCluster> deploymentPools = new ArrayList<CacheCluster>();
			for (CacheCluster cluster : clusters) {
				String clusterName = cluster.getClusterName();
				if ("".equals(deployment)) {
					deploymentPools.add(cluster);
				} else if (clusterName.toLowerCase().endsWith(deployment.toLowerCase())) {
					deploymentPools.add(cluster);
				}
			}
			return deploymentPools.size() > 0 ? deploymentPools : null;
		} catch (Exception e) {
			LOGGER.log(Level.WARNING, "Exception occured while fetching CacheCluster resource {0}", e);
		}
		return null;
		
	}
	
	public String getServiceName(String clusterName, String deployment) {
		if(!deployment.equals("")) {
			int index = clusterName.lastIndexOf('_');
			clusterName = clusterName.substring(0, index);
		}
		String serviceName = AccountsConstants.ACCOUNTS_SERVICE_NAME;
		switch(clusterName) {
		case "contacts"://No i18N
		case "zc_s"://No i18N
		case "zc_photo"://No i18N
		case "zc_cache_pool"://No i18N
			serviceName = AccountsConstants.CONTACTS_SERVICE_NAME;
			break;
		case "zohomts_optional_pool"://No i18N
		case "zohomts_user"://No i18N
			serviceName = "ZohoMTS";//No i18N
			break;
		case "zohoone_agent_pool"://No i18N
			serviceName = "ZohoOne";//No i18N
			break;
		default:
			break;
		}
		return serviceName;
	}
	
	public String[] getRedisAuthCred(String deployment) {
		if("true".equals(AccountsConfiguration.getConfiguration(RedisAuth.AUTH_ENABLED.getConfigName(), RedisAuth.AUTH_ENABLED.getDefaultValue()))) {
			String prefix = deployment + "_"; 
			String userName = AccountsConfiguration.getConfiguration(prefix + RedisAuth.AUTH_USER.getConfigName(), RedisAuth.AUTH_USER.getDefaultValue());
			String password = AccountsConfiguration.getConfiguration(prefix + RedisAuth.AUTH_PASS.getConfigName(), RedisAuth.AUTH_PASS.getDefaultValue());
			if(userName == null || password == null) {
				return null;
			}
			return new String[] {userName, password};
		}
		return null;
	}
}
%>
<%
String deployment = request.getParameter("dep") == null ? DeploymentSpecificConfiguration.getConfiguration("cachepool_suffix", "") : request.getParameter("dep"); // No I18N
if(deployment.equalsIgnoreCase("_" + SASDeployments.DEV.name())) {
	deployment = "";
}
String statsType = request.getParameter("statstype") == null ? "machine" : request.getParameter("statstype");//No i18N
if ("cluster".equals(statsType)) {
%>
<div class="legend">
	<span><i class="redis"></i>Redis</span><%--NO I18N--%>
	<span><i class="failed"></i>Failed</span><%--NO I18N--%>
</div>
<div class="fixTableHeader">
<table border="1" width="100%">
	<thead>
	<tr>
		<th>PoolName</th><%--No I18N--%>
		<th>IP</th><%--No I18N--%>
		<th>Node</th><%--No I18N--%>
		<th>Keys</th><%--No I18N--%>
		<th>Used Memory</th><%--No I18N--%>
		<th>Max Memory</th><%--No I18N--%>
		<th>Memory Peak</th><%--No I18N--%>
		<th>Hits</th><%--No I18N--%>
		<th>Hit Rate</th><%--No I18N--%>
		<th>IOPS (#Clients)</th><%--No I18N--%>
		<th>Evicted Keys</th><%--No I18N--%>
		<th>Range %</th><%--No I18N--%>
		<th>Sync Status</th><%--No I18N--%>
	</tr>
	</thead>
	<%
	List<CacheCluster> deploymentPools = new RedisClusterData().getDeploymentPools(deployment);
	if(deploymentPools != null) {
		for (CacheCluster pool : deploymentPools) {
			String syncStatus = pool.getIsSyncEnabled() ? (pool.getIsSyncEnabledForGet() ? "ONLINE(GET)" : "ONLINE") : "OFFLINE";//No I18N
			String ipPort = null;
			Double rangePercentage = 0.0, hitRate = 0.0;
			String keysCount = "0", cliCount = "0";//No I18N
			String iops = null;
			Long hits = null, misses = null;
			String memorypeak = null, evictedKeys = null, memory = null,
			maxmem = null;
			Properties props = null;
			if (pool.getClusterNodeCount() > 0) {
				for (ClusterNode node : pool.getClusterNodeList()) {
					try {
						ipPort = node.getServerIpPort();
						if(node.getCacheType().toLowerCase().equals("tarantool")) {
							if(pool.getClusterName().contains("pool") && !"true".equals(AccountsConfiguration.getConfiguration("iam3.tarantool.cache.enable", "false"))){
								out.print("<tr id='" + IAMEncoder.encodeHTMLAttribute(ipPort) + "' class='cluster failed'><td id='pname'>" + IAMEncoder.encodeHTML(pool.getClusterName()) + "</td><td>" + IAMEncoder.encodeHTML(ipPort) + "</td><td colspan=11>" + IAMEncoder.encodeHTML("Tarantool not enabled for IAM3") + "</td></tr>");//No I18N			
							}
							if(!pool.getClusterName().contains("pool") && !"true".equals(AccountsConfiguration.getConfiguration("iam2.tarantool.enabled", "false"))){
								out.print("<tr id='" + IAMEncoder.encodeHTMLAttribute(ipPort) + "' class='cluster failed'><td id='pname'>" + IAMEncoder.encodeHTML(pool.getClusterName()) + "</td><td>" + IAMEncoder.encodeHTML(ipPort) + "</td><td colspan=11>" + IAMEncoder.encodeHTML("Tarantool not enabled for IAM2") + "</td></tr>");//No I18N			
							}
							continue;
						}
						Long accum = 0L;
						if (!(node.getNodeRangeCount() == 0)) {
							for (int j = 0; j < node.getNodeRangeCount(); j++) {
								NodeRange range = node.getNodeRange(j);
								accum += (range.getEnd() - range.getStart());
							}
						}
						rangePercentage = (Double) ((accum / (1.0 * Long.MAX_VALUE)) * 100.0);
						int db = 1;
						if (node.getCacheProperties() != null && node.getCacheProperties().contains("database")) {
							for (String prop : node.getCacheProperties().split(",")) {
								if (prop.startsWith("database")) {
									db = Integer.parseInt(prop.split("=")[1]);
								}
							}
						}
						HostAndPort hostPort = HostAndPort.fromString(ipPort);
						Jedis cli = new Jedis(hostPort.getHost(), hostPort.getPort());
						String serviceName = new RedisClusterData().getServiceName(pool.getClusterName(), deployment);
						VOMap<String> redisAuthMap = Util.cacheAPI.getRedisAuthMap(serviceName, serviceName, deployment.replaceAll("_", ""));
						if(redisAuthMap != null && !redisAuthMap.isEmpty()) {
							String userName = redisAuthMap.get(RedisAuth.AUTH_USER.getConfigName());
							String pwd = redisAuthMap.get(RedisAuth.AUTH_PASS.getConfigName());
							cli.auth(userName, pwd);
						}
						cli.select(db);
						String tmp = cli.info("stats");//No I18N
						for (String line : tmp.split("\n")) {//No I18N
							if (line.contains("keyspace_hits")) {//No I18N
								String spl[] = line.split(":");//No I18N
								hits = Long.valueOf(spl[1].trim());
							} else if (line.contains("keyspace_misses")) {//No I18N
								String spl[] = line.split(":");//No I18N
								misses = Long.valueOf(spl[1].trim());
							} else if (line.contains("instantaneous_ops_per_sec")) {//No I18N
								String spl[] = line.split(":");//No I18N
								iops = spl[1];
							} else if (line.contains("evicted_keys")) {//No I18N
								String spl[] = line.split(":");
								evictedKeys = spl[1];
							}
						}
						hitRate = (Double) ((hits / (1.0 * (hits + misses))) * 100.0);
						tmp = cli.info("memory");//No I18N
						for (String line : tmp.split("\n")) {
							if (line.contains("used_memory_human")) {//No I18N
								String spl[] = line.split(":");//No I18N
								memory = spl[1];
							} else if (line.contains("used_memory_peak_human")) {//No I18N
								String spl[] = line.split(":");//No I18N
								memorypeak = spl[1];
							}
						}
						keysCount = Long.toString(cli.dbSize());
						tmp = cli.info("clients");//No I18N
						for (String line : tmp.split("\n")) { //No I18N
							if (line.contains("connected_clients")) {
								cliCount = line.split(":")[1];//No I18N 
							}
						}
						maxmem = cli.configGet("maxmemory").get(1);//No I18N
						cli.close();
						if (!maxmem.equals("0")) {//No I18N
							Double tmpMaxmem = Long.valueOf(maxmem) / ((1024 * 1024 * 1024) * 1.0);
							maxmem = String.format("%.2fG", tmpMaxmem);//No I18N
						}
						out.print("<tr id='" + IAMEncoder.encodeHTMLAttribute(ipPort + db) + "' class='cluster " + IAMEncoder.encodeHTML(pool.getClusterName()) + " " + IAMEncoder.encodeHTML(node.getCacheType()) + "'><td id='pname'>" + IAMEncoder.encodeHTML(pool.getClusterName()) + "</td><td>" + IAMEncoder.encodeHTML(ipPort) + " (" + IAMEncoder.encodeHTML(String.valueOf(db)) + ")</td><td>" + IAMEncoder.encodeHTML(node.getNodeName()) + "</td><td>" + IAMEncoder.encodeHTML(keysCount) + "</td><td>" + IAMEncoder.encodeHTML(memory) + "</td><td>" + IAMEncoder.encodeHTML(maxmem) + "</td><td>" + IAMEncoder.encodeHTML(memorypeak) + "</td><td>" + hits + "</td><td>" + IAMEncoder.encodeHTML(String.format("%.2f", hitRate.isNaN() ? 0.0 : hitRate)) + "%</td><td>" + IAMEncoder.encodeHTML(iops) + " (" + IAMEncoder.encodeHTML(cliCount) + ")</td><td>" + IAMEncoder.encodeHTML(evictedKeys) + "</td><td>" + IAMEncoder.encodeHTML(String.format("%.2f", rangePercentage)) + "%</td><td>" + IAMEncoder.encodeHTML(syncStatus) + "</td></tr>");//NO OUPUTENCODING //No I18N					
					} catch (Exception e) {
						out.print("<tr id='" + IAMEncoder.encodeHTMLAttribute(ipPort) + "' class='cluster failed'><td id='pname'>" + IAMEncoder.encodeHTML(pool.getClusterName()) + "</td><td>" + IAMEncoder.encodeHTML(ipPort) + "</td><td colspan=11>" + IAMEncoder.encodeHTML(e.getMessage()) + "</td></tr>");//No I18N			
					}
				}
			}
		}
%>
</table></div>
<%
}
} else if ("machine".equals(statsType)) { //No I18N
	JSONArray jsonArray = null;
%>
<div class="legend">
	<span><i class="success"></i>Present</span><%--NO I18N--%>
	<span><i class=""></i>Absent</span><%--NO I18N--%>
</div>
<div class="fixTableHeader">
<table border="1">
	<thead>
		<tr>
			<th rowspan="2">Category</th><%--No I18N--%>
			<th rowspan="3">Cluster Ip</th><%--No I18N--%>
			<th colspan="3">IAM Cache Clusters</th><%--No I18N--%>
			<th colspan="8">Stats</th><%--No I18N--%>
	        <th rowspan="2">Ips</th><%--No I18N--%>	
		</tr>
		<tr>
      	 	<th>Clusters</th><%--No I18N--%>
  			<th>DB</th><%--No I18N--%>    	 		
      		<th>Keys</th><%--No I18N--%>	
			<th>IOPS</th><%--No I18N--%>
			<th>Clients</th><%--No I18N--%>
			<th>Memory</th><%--No I18N--%>
			<th>Peak Mem</th><%--No I18N--%>
			<th>Max Mem</th><%--No I18N--%>
			<th>Hits</th><%--No I18N--%>
     		<th>Hit Rate</th><%--No I18N--%>
    		<th>Evicted Keys</th><%--No I18N--%>
		</tr>
	</thead>
	<tbody>
	<%
	try {
		List<RedisClusterData> redisClusters = new RedisClusterData().getRedisClusters();
		if (redisClusters != null) {
			jsonArray = new JSONArray();
			for (RedisClusterData data : redisClusters) {
				JSONObject clusterDataJSON = data.toJson(deployment);
				JSONObject clusterJson = clusterDataJSON.optJSONObject("clusters");//No i18N
				String stats = "";
				String className = "";
				int spanCount = 0;
				String remainingDB = "";
				JSONObject statJob = clusterDataJSON.optJSONObject("stats");//No i18N
				if (statJob.has("error")) {
					stats = statJob.getString("error");
					className = "failed"; //No i18N
				} else {
					JSONObject keysJson = statJob.getJSONObject("keys"); //No i18N
					Set<String> countKeys =  keysJson.keySet();
					className = clusterJson.length() > 0 ? "success" : ""; //No i18N
					int i = 0 ;
					for(String db : countKeys) {
						String clusterName = "";
						if(clusterJson.has(db)) {
							clusterName = clusterJson.getString(db);
							clusterJson.remove(db);
						}
						if(i == 0) {
							stats += "<td>" + clusterName + "</td>";//No i18N
							stats += "<td>" + db + "</td>";//No i18N
							stats += "<td>" + keysJson.getString(db) + "</td>";//No i18N
						} else {
							remainingDB += "<tr class="+ className +"><td>" + clusterName + "</td><td>" + db + "</td><td>" + keysJson.getString(db) + "</td></tr>";
						}
						i++;
					}
					for(String db : clusterJson.keySet()) {
						remainingDB += "<tr class=" + className + "><td>" + clusterJson.getString(db) + "</td><td>" + db + "</td><td>" + 0 + "</td></tr>";
						i++;
					}
					spanCount = i;
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("iops") + "</td>"; //No i18N
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("clients") + "</td>"; //No i18N
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("memory") + "</td>"; //No i18N
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("memorypeak") + "</td>"; //No i18N
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("maxMemory") + "</td>"; //No i18N
					Long hits = statJob.getLong("hits"); //No i18N
					stats += "<td rowspan=" + spanCount + ">" + hits + "</td>"; //No i18N
					Long misses = statJob.getLong("misses"); //No i18N
					Double hitRate = (Double) ((hits / (1.0 * (hits + misses))) * 100.0);
					stats += "<td rowspan=" + spanCount + ">" + IAMEncoder.encodeHTML(String.format("%.2f", hitRate)) + "% </td>"; //No i18N
					stats += "<td rowspan=" + spanCount + ">" + statJob.getString("evictedKeys") + "</td>"; //No i18N
					
				}
				out.println("<tr class=" + className + "><td rowspan=" + spanCount + ">" + clusterDataJSON.optString("category") + "</td>");
				out.println("<td rowspan=" + spanCount + ">" + clusterDataJSON.optString("cluster") + ":" + clusterDataJSON.optString("port") + "</td>");
				out.println(stats);
				out.println("<td rowspan=" + spanCount + "> Master Ip : " + clusterDataJSON.optString("master") + "<br> Slave Ip : " + clusterDataJSON.optString("slave") + "<br> Sec Slave Ip : " + clusterDataJSON.optString("secSlave") + "</td></tr>");//No i18N				
				if(IAMUtil.isValid(remainingDB)) {
					out.println(remainingDB);
				}
			}
		}
	} catch (Exception e) {
		e.printStackTrace(new PrintWriter(out));
	}
	%>
</table></div>
<%}
else if ("range".equals(statsType)) { //No I18N
	JSONArray jsonArray = null;
%>
<div class="fixTableHeader">
<table border="1">
	<thead>
	<tr>
		<th width="10%">Cluster</th><%--No I18N--%>
		<th width="10%">Redis Ip</th><%--No I18N--%>
		<th width="10%">Node</th><%--No I18N--%>
		<th width="10%">Properties</th><%--No I18N--%>
		<th width="10%">Range</th><%--No I18N--%>
		<th width="10%">Percentage</th><%--No I18N--%>
	</tr></thead>
	<%
	try {
		
		List<CacheCluster> deploymentPools = new RedisClusterData().getDeploymentPools(deployment);
		if(deploymentPools != null) {
			List<String> clusterPools = new ArrayList<>();
			for (CacheCluster cluster : deploymentPools) {
				clusterPools.add(cluster.getClusterName().toLowerCase());
				int nodeCount = cluster.getClusterNodeCount();
				if(nodeCount > 0) {
					out.println("<tr class='success'><td rowspan=" + nodeCount + ">" + cluster.getClusterName() + "</td>");
					int i =0;
					for(ClusterNode node : cluster.getClusterNodeList()) {
						if(i != 0) {
							out.println("<tr class='success'>");
						}
						out.println("<td>" + node.getServerIpPort() + "</td>");
						out.println("<td>" + node.getNodeName() + "</td>");
						String properties = node.getCacheProperties().replaceAll(",", "<br>");
						out.println("<td>" + properties + "</td>");
						int index = 0;
						int rangeCount = node.getNodeRangeCount();
						String rangeRowSpan = "";
						String percentageRowSpan = "";
						for(NodeRange range : node.getNodeRangeList()) {
							String rangeStr = "";
							long start = range.getStart();
							long end = range.getEnd();
							rangeStr += " Start : " + start; //No i18N
							rangeStr += "<br> End : " + end; //No i18N
							long avg = end - start;
							double percentage = ((double) avg / Long.MAX_VALUE) * 100;
							if(rangeCount == 1) {
								rangeRowSpan = rangeStr;
								percentageRowSpan = percentage + "%";
							} else {
								rangeRowSpan += (index < rangeCount-1) ? "<div class='rangespan'>" + rangeStr + "</div>" : "<div style='line-height: 20px;padding: 2%;'>" + rangeStr + "</div>";
								percentageRowSpan += (index < rangeCount-1) ? "<div class='rangespan' style='line-height: 40px;'>" + percentage + "% </div>" :  "<div style='line-height: 40px;padding: 2%;'>" + percentage + "%</div>";
								index++;
							}
						}
						String style = index == 0 ? "" : "style='padding:0;'";
						out.print("<td " + style + ">" + rangeRowSpan + "</td><td " + style + ">"  +percentageRowSpan + "</td></tr>");
						i++;
					}
				}
			}
			HashSet<String> constants = MemCacheConstants.getPools();
			for(String poolName : constants) {
				String cluster = poolName + deployment;
				if(!clusterPools.contains(cluster.toLowerCase())) {
					out.println("<tr class='failed'><td>" + poolName + "</td><td colspan='5'> " + poolName + " Pool not configured</td></tr>");
				}
			}
		}
	} catch (Exception e) {
		e.printStackTrace(new PrintWriter(out));
	}
	%>
</table></div>
<%}
%>