<%--$Id$ --%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.internal.DeploymentSpecificConfiguration"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster.ClusterNode.NodeRange"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster.ClusterNode"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.CLUSTERNODE"%>
<%@page import="com.zoho.accounts.AppResource.RESOURCE.NODERANGE"%>
<%@page import="com.zoho.accounts.AppResource"%>
<%@page import="com.zoho.accounts.AppResource.CacheClusterURI"%>
<%@page import="com.zoho.accounts.AppResourceProto.CacheCluster"%>
<%@page import="com.zoho.accounts.internal.util.Util"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.jedis.v390.Jedis"%>
<%@page import="java.util.Properties"%>
<%@page import="com.zoho.accounts.cache.IAMCacheFactory"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.zoho.resource.RESTProperties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String dc = DeploymentSpecificConfiguration.getDeployment();
dc = dc.equals("DEP") ? "" : (dc + " - ");
%>
<title><%=dc%>R/C Stats</title> <%--NO I18N--%>
<style>

.container {
	background-color: white;
    height: auto;
    padding: 10px;
    transition: all .2s ease-in-out;
    box-sizing: border-box;
    margin: auto;
}

.tab {
    box-shadow: inset 0 -2px #E9ECEF;
}
.tab button.active {
    border-bottom: 3px solid black;
}
.tab button {
    font-size: 14px;
    line-height: 20px;
    height: 47px;
    background-color: inherit;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 14px 10px;
    transition: 0.3s;
    text-align: left;
    color: #8492A3;
    box-sizing: border-box;
    font-weight: 500;
 }
table {
	word-wrap:break-word;
	border:1px solid black;
	text-align:center;
    border-collapse: collapse;
    width:100%
}

h1{
	text-align:center;
}
th{
	background-color: black;
	color:white;
}

td, th{
	padding-top:1%;
	padding-bottom:1%;
	border-style: solid;
	border-width: 2px;
}

.fixTableHeader {
	overflow-y: auto;
	height: 750px;
}

.fixTableHeader thead  {
	position: sticky;
	top: 0;
}

.failed{
	background-color: red;
}

.hidden{
	display:none;
}
.redis, .success{
	background-color: lightgreen;
}

.abs{
	border:0px;
	background-color:lightgreen;
	float: right;
    margin-left: 1%;
}
.cachetype{
	color: black;
	padding: 0 3px 0 3px;
	margin-left: 2%;
}
.legend{
	padding: 10px;
    position: absolute;
    right: 10px;
    top: 50px;
}
.legend i {
    display: inline-block;
    border-radius: 50%;
    width: 12px;
    height: 12px;
    margin-right: 5px;
    border: 1px solid;
}
.alignm{
     margin-left: 5%;
}
.tabcontent {
	margin-top: 5px;
    background-color: white;
    font-size: 15px;
}
.rangespan {
    border-bottom: 1px solid black;
    padding: 2%;
    line-height: 20px;
}
</style>
</head>
<body class='hidden'>
	<h1 style="text-align: center;"> REDIS CLUSTER STATS </h1> <%--No I18N--%>
	
	<div id="container_id" class="container">
	<div class="head" style="position: relative;top: 15px;">
		<div id="title_bar_service">
			<div class="subdiv">
				<button class="refresh abs">Refresh</button><%--NO I18N--%>
				<div class="select_div " id="dcinfoDropdown" style="float: right">
					<select id='dcInfo' class="selectstyle" onchange="refresh()">
				<%
					String deployment = DeploymentSpecificConfiguration.getDeployment();
					deployment = deployment.equals("DEP") ? "LZ" : deployment;// NO I18N
					for(DeploymentSpecificConfiguration.DEPLOYMENTS dep : DeploymentSpecificConfiguration.DEPLOYMENTS.values()) {
						if(!dep.name().equals("DEFAULT")){
					%>  
					<option value ="<%= "_"+ IAMEncoder.encodeHTML(dep.name()) %>" <%if(deployment.equals(dep.name())){ %>selected<%} %>><%= IAMEncoder.encodeHTML(dep.name()) %></option>
					<%		
						}
					}
				%>
					</select>
				</div>
			</div>
		</div>
	</div>

	<div id="maincontenttab" class="content_box">
		<div class="tab">
			<button class="tablinks" onclick="openTab(event,this)" name="machine_info" id="defaultOpen">Machine Info</button><%--NO I18N--%>
			<button class="tablinks" onclick="openTab(event,this)" name="range_info">Range Info</button><%--NO I18N--%>
			<button class="tablinks" onclick="openTab(event,this)" name="cluster_info">Cluster Info</button><%--NO I18N--%>
		</div>
		<div id="machine_info" class="tabcontent maindiv"></div>
		<div id="range_info" class="tabcontent maindiv"></div>
		<div id="cluster_info" class="tabcontent maindiv"></div>
	</div>
</div>


<%
	String cPath = request.getContextPath() + "/accounts";//No I18N
	String jsurl = cPath + "/js"; //No I18N
	%>
<script type="text/javascript" src="<%=jsurl%>/tplibs/jquery/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=jsurl%>/common.js"></script> 


<script type="text/javascript">

$(document).ready(function() { 
	document.getElementById('defaultOpen').click(); // No I18N
	removeDuplicates();
});


function removeDuplicates(){
	var presentIds = {};
	$('.cluster').each (function () {//No I18N
	    if (this.id in presentIds) {
	    	if($(presentIds[this.id]).find("#pname").length>0&&$(this).find("#pname").length>0){//No I18N
	    	   	if($(presentIds[this.id]).find("#pname").text().indexOf($(this).find("#pname").text())==-1){//No I18N
	    			$(presentIds[this.id]).find("#pname").append("<br/>"+$(this).find("#pname").text());//No I18N
	       		}
	    	}
	    	$(this).remove();
	   	} else {
	       presentIds[this.id] = this;
	    }
	});
	$(".hidden").toggleClass("hidden");//No I18N
}

function refresh() {
	
	var tablinks = document.getElementsByClassName("tablinks");//No i18N
	for (i = 0; i < tablinks.length; i++) {
		var tabName = tablinks[i].name;
		if ((tablinks[i].className).indexOf("active") != -1) { //No i18N
			var param = "";
			if(tabName == "cluster_info") { //No i18N
				param = "statstype=cluster"; //No i18N
			}  else if((tabName) == ("range_info")) { //No i18N
				param = "statstype=range"; //No i18N
			}
			var deployment = document.getElementById("dcInfo").value;
			param += param.length > 0 ? "&dep=" + deployment : "dep=" + deployment; //No I18n
			var resp = getOnlyGetPlainResponse('/accounts/admin/cache?' + param, ''); //No I18n
			$("#" + tabName).html('');	//No I18n
			$("#" + tabName).append(resp);	//No I18n
		} else {
			$("#" + tabName).html('');	//No I18n
			tablinks[i].className = tablinks[i].className.replace(" fetch", ""); //No i18N
		}
		removeDuplicates();
	}
}

$(".refresh").click(refresh);//No I18N

function openTab(evt, obj) {
	
	var tabName = $(obj).attr("name");//No i18N
		var tabLinks = $(obj).attr("class");//No i18N
		if (tabLinks.indexOf("active") == -1) {
			var tabdiv = $('#' + tabName).attr("class"); //No i18N
			var i, tabcontent, tablinks, tabsTitle;
			tabcontent = document.getElementsByClassName(tabdiv);
			tabsTitle = document.getElementsByClassName(tabLinks);
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none"; //No i18N
			}
			tablinks = document.getElementsByClassName(tabLinks);
			for (i = 0; i < tablinks.length; i++) {
				if ((tablinks[i].className).indexOf("active") != -1) { //No i18N
					tablinks[i].className = tablinks[i].className.replace(" active", ""); //No i18N
					tablinks[i].style.color = "#8492A3";//No i18N
				}
			}
			document.getElementById(tabName).style.display = "block"; //No i18N
			evt.target.className += " active";//No i18N
			evt.target.style.color = "black";//No i18N
			if (tabLinks.indexOf('fetch') == -1) {//No i18N
				fetchTabData();
				evt.target.className += " fetch";//No i18N
			}
		}
	}
	
	
function fetchTabData() {
	var tablinks = document.getElementsByClassName("tablinks");//No i18N
	for (i = 0; i < tablinks.length; i++) {
		if ((tablinks[i].className).indexOf("active") != -1) { //No i18N
			var tabName = tablinks[i].name;
			var tabId = "";
			var param  = "";
			var dc = document.getElementById('dcInfo').value;
			if((tabName) == ("cluster_info")) { //No i18N
				param = "statstype=cluster"; //No i18N
			} else if((tabName) == ("range_info")) { //No i18N
					param = "statstype=range"; //No i18N
			}
			var deployment = document.getElementById("dcInfo").value;
			param += param.length > 0 ? "&dep=" + deployment : "dep=" + deployment; //No I18n
			tabId = tabName;
			var resp = getOnlyGetPlainResponse('/accounts/admin/cache?' + param, ''); //No I18n
			$("#" + tabId).html('');	//No I18n
			$("#" + tabId).append(resp);	//No I18n
		}
	}
}
	
function getOnlyGetPlainResponse(action, params) {
	if(params.indexOf("&") === 0) {
	params = params.substring(1);
	}
	var objHTTP,result;objHTTP = xhr();
	objHTTP.open('GET', action, false);
	objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
	objHTTP.send(params);
	return objHTTP.responseText;
}

function xhr() {
	var xmlhttp;
	if (window.XMLHttpRequest) {
	xmlhttp=new XMLHttpRequest();
	}
	else if(window.ActiveXObject) {
	try {
		xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e) {
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	}
	return xmlhttp;
}

</script>