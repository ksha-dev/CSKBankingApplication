<%-- $Id$ --%>
<%@ include file="includes.jsp" %>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>

<div class="maincontent">
    <div class="menucontent">
	<div class="topcontent"><div class="contitle">Client Portal JWT</div></div> <%--No I18N--%>
	<div class="subtitle">Admin Services</div> <%--No I18N--%>
    </div>

    <div class="field-bg">
	<form name="clientportaljwt" id="clientportaljwt" class="zform" onsubmit="sendRequestToExternalAgent();" method="post">
	    <div class="labelmain">
	    <div class="labelkey">URL</div><%--No I18N--%> 
		<div class="labelvalue"><input type="text" id="url" name="url" class="input"/></div>
		<div class="labelkey">User Token</div><%--No I18N--%> 
		<div class="labelvalue"><input type="text" id="userToken" name="userToken" class="input"/></div>
	
		<div class="accbtn Hbtn" onclick="sendRequestToExternalAgent();">
		    <div class="savebtn">
			<span class="btnlt"></span>
			<span class="btnco">Send Request</span> <%--No I18N--%>
			<span class="btnrt"></span>
		    </div>
		</div>
		<input type="submit" class="hidesubmit" />
		</div>
		<div class="labelkey">Response</div><%--No I18N--%> 
	<textarea id="clientportaljwt_response" name="clientportaljwt_response"></textarea>
	</form>
    </div>
</div>
