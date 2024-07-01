<%-- $Id: $ --%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.internal.OAuthException.OAuthErrorCode"%>
<%@page import="com.zoho.accounts.internal.OAuthException"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.templateengine.util.HtmlResourceIncluder"%>
<%@ include file="../../../static/includes.jspf" %>
<%= HtmlResourceIncluder.addResource("/v2/components/css/product-icon.css") %><%-- NO OUTPUTENCODING --%>
<%if(isCDNEnabled){%>
<%= HtmlResourceIncluder.addResource("/css/oauth.css") %> <%-- NO OUTPUTENCODING --%>
<%}else{ %>
<link href="<%=cssurl%>/oauth.css" type="text/css" rel="stylesheet"  /> <%-- NO OUTPUTENCODING --%>
<%}%>
<% 
OAuthException error = request.getAttribute("oauthExp") != null ? (OAuthException) request.getAttribute("oauthExp") : null;
error = error != null ? error : request.getAttribute("error") != null ?  (OAuthException)request.getAttribute("error") : null;
String digest = (String)request.getAttribute("digest") != null ? (String)request.getAttribute("digest") : null;
JSONArray userOrgs = request.getAttribute("userOrgs") != null ? (JSONArray)request.getAttribute("userOrgs") : new JSONArray();
String clientDescription = (String)request.getAttribute("clientDescription") != null ? (String)request.getAttribute("clientDescription") : null;
String invitedUserEmail = (String)request.getAttribute("invitedUserEmail") != null ? (String)request.getAttribute("invitedUserEmail") : null;
String invitedUserName = (String)request.getAttribute("invitedUserName") != null ? (String)request.getAttribute("invitedUserName") : null;
String serviceName = (String)request.getAttribute("serviceName") != null ? (String)request.getAttribute("serviceName") : null;
String remoteService = (String)request.getAttribute("remoteService") != null ? (String)request.getAttribute("remoteService") : null;
boolean isOrg = request.getAttribute("isOrg") != null ? (boolean)request.getAttribute("isOrg") : false;
String isSelected = userOrgs.length() == 1 ? "checked" : "";//No I18N
error = error != null ? error : isOrg && userOrgs.length() == 0 ? new OAuthException(OAuthErrorCode.no_org) : null;
%>
<html>
<style>
body
{
    font-family: 'Open Sans', sans-serif;
    margin: 0;
    height: 100%;
    width: 100%;
}
.blur {
    height: 100%;
    width: 100%;
    position: fixed;
    z-index: -1;
    background-color: #000;
    transition: opacity 0.2s ease-in-out;
    opacity: 0;
    top: 0px;
    left: 0px;
}
.page_bg
{
    width: 100%;
    background: url("<%=StaticContentLoader.getStaticFilePath("/images/CrossOrgInvitation.png")%>") no-repeat;
    background-size: auto 100%;
    position: fixed;
    z-index: -1;
    top: 0px;
    left: 0px;
    height: 100%;
    min-height: 800px;
    max-height: 1500px;
}
.container {
    display: block;
    height: auto;
    width: auto;
    padding-top: 130px;
    margin-right: 5%;
    margin-left: 50%;
    padding-bottom: 30px;
}
.head_text {
    font-size: 24px;
    line-height: 40px;
    margin-top: 30px;
    font-weight: 500;
}
.description {
    font-size: 16px;
    line-height: 30px;
    margin-top: 10px;
}
.btn {
    display: inline-block;
    height: 36px;
    box-sizing: border-box;
    border: none;
    border-radius: 2px;
    font-size: 13px;
    padding: 0px 30px;
    margin-top: 30px;
    font-weight: 600;
    margin-right: 20px;
    background: #eeeeee;
    outline: none;
    cursor: pointer;
    color: #686868;
    text-transform: uppercase;
    transition: all .1s ease-in-out;
}
.green_btn {
    background-color: #69C585;
    color: #fff;
}
.btn:hover {
    background-color: #e9e9e9;
}
.green_btn:hover {
    background-color: #54B772;
}
.service_icon {
    width: 36px;
    height: 36px;
    display: inline-block;
    float: left;
    margin-right:10px;
}
.service_text {
    font-size: 18px;
    display: inline-block;
    font-weight: 500;
    line-height: 36px;
    float: left;
}
.service_namex
{
  margin-top:30px;
}
.select_container
{
  margin-left:46px;
  display: flex;
  flex-wrap: wrap;
}
.round_check_container
{
  margin-top: 15px;
  width: 100%;
}
.round_check_container input[type="radio"]
{
  display:none;
}
.round_check_container label
{
  font-size: 14px;
  line-height: 20px;
  position: relative;
  font-weight: 500;
}
.round_check_container label::before
{
  content: "";
  width: 16px;
  height: 16px;
  border: 2px solid #ccc;
  box-sizing: border-box;
  display: inline-block;
  margin-right: 5px;
  position: relative;
  border-radius: 50%;
  top: 3px;
}
.round_check_container label::after
{
  content: "";
  width: 8px;
  height: 8px;
  background: #69C585;
  border-radius: 50%;
  display: none;
  position: absolute;
  left: 4px;
  top: 4px;
}
.round_check_container label:hover:before,.round_check_container input[type="radio"]:checked~label::before
{
  border: 2px solid #69C585;
}
.round_check_container input[type="radio"]:checked~label::after{
  display: block;
}
	 
@media
    only screen and (-webkit-min-device-pixel-ratio: 2),
    only screen and ( min--moz-device-pixel-ratio: 2),
    only screen and ( -o-min-device-pixel-ratio: 2/1),
    only screen and ( min-device-pixel-ratio: 2),
    only screen and ( min-resolution: 192dpi),
    only screen and ( min-resolution: 2dppx) {
        .page_bg{
          background: url("<%=StaticContentLoader.getStaticFilePath("/images/CrossOrgInvitation2x.png")%>") no-repeat;
          background-size: auto 100%;
        }
}
@media only screen and (max-width: 950px) {
  .page_bg{
    display:none;
  }
  .container{
  	width:70%;
  	margin:auto;
  }
}
@media only screen and (max-width: 420px) {
  .container{
    width: 100%;
    padding: 0px 30px;
    padding-top: 30px;
    margin: auto;
    box-sizing: border-box;
    float: none;
  }
  .btn{
  	width:100%;
  }
}

.errorbox {
	display: block;
	width: 460px;
	height: auto;
	margin: auto;
	margin-top: 120px;
	box-shadow: 0px 0px 8px 0px #00000020;
	padding-bottom: 40px;
	border-radius: 2px;
}

.logo_bg {
	display: block;
	background-color: #FFF7F7;
	height: 140px;
	box-sizing: border-box;
	padding: 40px;
}

.error_icon {
	display: block;
	background-color: #FFDFDF;
	height: 60px;
	width: 60px;
	border-radius: 30px;
	margin: auto;
	margin-bottom: 20px;
	margin-top: -30px;
	background-size: 24px;
}

.success_icon{
	display: block;
	background-color: #54B772;
	height: 60px;
	width: 60px;
	border-radius: 30px;
	margin: auto;
	margin-bottom: 20px;
	margin-top: -30px;
	background-size: 24px;
}

.heading {
	display: block;
	margin-bottom: 10px;
	font-size: 24px;
	line-height: 40px;
	font-weight: 600;
}
.discription {
	display: block;
	margin-bottom: 30px;
	font-size: 16px;
	line-height: 1.5;
	font-weight: 400;
}
.center_text {
	display: block;
	text-align: center;
	width: 380px;
	padding: 0px 40px;
}
.center_btn {
	display: block;
	margin: auto;
}
.green {
	background-color: #54B772;
	color: #fff;
}
.zoho_logox {
	display: block;
	height: 40px;
	width: auto;
	background: url('<%=StaticContentLoader.getStaticFilePath("/images/newZoho_logo.svg")%>') no-repeat transparent; <%-- NO OUTPUTENCODING --%>
	background-size: auto 100%;
	margin-bottom: 10px;
}
.center_logo {
	display: block;
	margin: auto;
	width: 100px;
}
.orgdescription {
    height: 16px;
    padding: 5px 0px 0px 20px;
    font-size: 14px;
}
.org_name {
	font-weight: 600;
	text-transform: capitalize;
}
.reasons_div {
    text-align: left;
    font-size: 13px;
    line-height: 1.5;
    margin-top: 20px;
    display: none;
}
.reasons_list {
	text-align: left;
    margin-block: 0px;
    padding-left: 32px;
    margin-top: 4px;
}
li {
	list-style: disc;
}
</style>
<html >
  <head>
    <meta charset="utf-8">
    <title>Cross Org Invitation</title> <%--No I18N--%>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
  </head>
  <body>
 				<%if(error == null){ %>
 				<div class="showprompt" id="showprompt">
 		<div class="blur"></div>
    	<div style="overflow:auto">
    			<div class="page_bg"></div>
    				<div class="container">
    				<div class="validationError" style="displa"></div>
    			<div class="header" id="header"> 
    					<img class="zoho_logox" src="<%=StaticContentLoader.getStaticFilePath("/images/newZoho_logo.svg")%>">
    				</div>
	    			<div class="wrap">
	    				<div class="info">
	    				<%if(Util.isValid(clientDescription)){%>
	    					<div class="head_text"><%=IAMEncoder.encodeHTML(clientDescription) %></div>
	    				<%}%>	
	    					<% if(isOrg) {%>
	    					<div class="description"> <%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVITATION.DESCRIPTION", remoteService, invitedUserName, invitedUserEmail, serviceName)%></div>
			                <div class="service_namex">
                              <div style="overflow:auto">
                                <i class="service-icon product-icon-<%=serviceName%>"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span><span class="path11"></span><span class="path12"></span><span class="path13"></span><span class="path14"></span><span class="path15"></span><span class="path16"></span></i><span class="service_text"><%=serviceName %></span>
                              </div>
                              <div class="select_container">
                              <%
                              for(int i=0; i<userOrgs.length(); i++){ 
                              JSONObject thisOrg = userOrgs.getJSONObject(i);
                              %>
                                <div class="round_check_container">
                                  <input type="radio" name="service_option" id="service<%=i%>" class="unauth_checkbox" value="<%=thisOrg.getString("orgId") %>" <%=isSelected %>>
                                  <label for="service<%=i%>"><%=thisOrg.getString("orgName") %></label>
                                  <div class="orgdescription"><%=thisOrg.optString("description") %></div>
                                </div>
                                <%} %>
                              </div>
                            </div>
                            <%} else {%>
			                <div class="description"> <%=I18NUtil.getMessage("IAM.OAUTH.CROSS.USER.INVITATION.DESCRIPTION", invitedUserEmail, invitedUserName, remoteService, serviceName)%></div>
			                <%} %>
                            <br>
                            <%if(Util.isValid((String)request.getAttribute("helpLink"))){%>
	                            <div><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.HELP.LINK",remoteService,serviceName,(String)request.getAttribute("helpLink"))%></div>
                            <%}%>
                            <div style="width">
				             <button id="" name="confirm_btn" class="btn green_btn " onclick="crossOrgSelect(true)">Confirm</button> <%--No I18N--%>
                            <button id="" name="confirm_btn" class="btn" onclick="crossOrgSelect(false)">reject</button> <%--No I18N--%>
	    					</div>
	    				</div>
	    			</div>
	    			     </div>
	    			 </div>    
      </div>
      <div class="errorbox" id="successBlock" style="display: none;">
      	<div class="logo_bg" style="background: #A8EAA8">
      		<div class="zoho_logox center_logo"></div>
      	</div>
      	<div class="success_icon" style="background: url('<%=StaticContentLoader.getStaticFilePath("/images/success.png")%>') no-repeat #A8EA74 18px 18px; background-size: 24px;"></div> <%-- NO OUTPUTENCODING --%>
      	<div class="heading center_text"><%=I18NUtil.getMessage("ICREST.SUCCESS.MESSAGE")%></div>
      	<div class="discription center_text"><span id="successResponse"></span></div>
      	<button class="btn green center_btn" onclick="homepage()"><%=I18NUtil.getMessage("IAM.GROUPINVITATION.GO.TO.ACCOUNTS")%></button>
      </div>
       <div class="errorbox" id="errorBlock" style="display: none;">
					<div class="logo_bg">
						<div class="zoho_logox center_logo"></div>
					</div>
					<div class="error_icon" style="background: url('<%=StaticContentLoader.getStaticFilePath("/images/Link.png")%>') no-repeat #FFDFDF 18px 18px; background-size: 24px;"></div> <%-- NO OUTPUTENCODING --%>
					<div class="heading center_text"><%=I18NUtil.getMessage("IAM.ACCOUNT.RECOVERY.ERROR.ACCOUNT.INVALID.HEADER")%></div> <!-- Invalid URL -->
					<div class="discription center_text"><span id="responseError"></span><div class="reasons_div" id="reasons_div"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION.REASONS")%></div></div>
					<button class="btn green center_btn" onclick="homepage()"><%=I18NUtil.getMessage("IAM.GROUPINVITATION.GO.TO.ACCOUNTS")%></button>
	</div>
      
		       <%} else {%>
		       <div class="errorbox">
					<div class="logo_bg">
						<div class="zoho_logox center_logo"></div>
					</div>
					<div class="error_icon" style="background: url('<%=StaticContentLoader.getStaticFilePath("/images/Link.png")%>') no-repeat #FFDFDF 18px 18px; background-size: 24px;"></div> <%-- NO OUTPUTENCODING --%>
					<% switch(error.getErrorCode()){ 
					case invalid_user:
						String forEmail = request.getAttribute("forEmail") != null ? (String)request.getAttribute("forEmail") : null;
					%>
					<div class="heading center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.USER.HEADER")%></div>
					<div class="discription center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.USER", forEmail)%></div>
					<%
					break;
					case already_verified:
						%>
					<div class="heading center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION.HEADER")%></div>
					<div class="discription center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVITATION.EXPIRED")%></div>
					<%
					break;
					case inactive_user:
						%>
						<div class="heading center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.USER.HEADER")%></div>
						<div class="discription center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.USER.ACCOUNT.INACTIVE", Util.getSupportEmailId())%></div>
						<%
						break;
					case no_org:
						%>
						<div class="heading center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION.HEADER")%></div>
						<div class="description center_text"> <%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.NO.ORG", serviceName, remoteService)%></div>
						<%
						break;
					default:
						%>
						<div class="heading center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION.HEADER")%></div>
						<div class="discription center_text"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION")%>
							<div class="reasons_div" style="display: block;"><%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION.REASONS")%></div>
						</div>
					<%
					} %>
					<button class="btn green center_btn" onclick="homepage()"><%=I18NUtil.getMessage("IAM.GROUPINVITATION.GO.TO.ACCOUNTS")%></button>
				</div>
				<%} %>
  </body>
  <script type="text/javascript">
  var digest = '<%=digest%>';
  function getcsrfParams() {
		var csrfParam = "<%=SecurityUtil.getCSRFParamName(request)%>"; //NO OUTPUTENCODING
		var csrfCookieName = "<%=SecurityUtil.getCSRFCookieName(request)%>"; //NO OUTPUTENCODING
		var params = csrfParam + "=" + getCookie(csrfCookieName);
		return params;
		 
	}
  function homepage(){
		window.location.href= '/'; // NO I18N
	}
  function getCookie(cookieName) {
	    var nameEQ = cookieName + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++) {
	        var c = ca[i].trim();
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return null;
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
  function getPlainResponse(action, params) {
	    if(params.indexOf("&") === 0) {
		params = params.substring(1);
	    }
	    var objHTTP,result;objHTTP = xhr();
	    objHTTP.open('POST', action, false);
	    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
	    if(!params || params === '') {
	        params = "__d=e"; //No I18N
	    }
	    objHTTP.setRequestHeader('Content-length', params.length);
	    objHTTP.send(params);
	    return objHTTP.responseText;
	 }
  
  function crossOrgSelect(bool){
	  var id = '';
	  var length = '<%=userOrgs!= null ? userOrgs.length(): 0%>';
	  var isOrg = <%=isOrg%>;
	  var remoteService = "<%=remoteService%>";
	  if(length != 0){
	  	for(var i=0; i<length; i++){
		  if(document.getElementById('service'+i).checked){
			  id=document.getElementById('service'+i).value;
			  break;
		  }
	    }
  	  }
	  if(id == '' && isOrg && bool){
		  alert("select an org to continue");//No I18N
		  return false;
	  }
	  var params = "id="+id+"&DIGEST="+digest+"&"+getcsrfParams()+"&action="+bool+"&isOrg="+isOrg;//No I18N
	  var resp = getPlainResponse("<%=request.getContextPath()%>/oauth/crossorg/invitation/action", params); //NO OUTPUTENCODING //No I18N
	  var jsonResp = JSON.parse(resp);
	  if(jsonResp.status == "success"){
		  document.getElementById("showprompt").style.display="none";
		  document.getElementById("successBlock").style.display="";
		  if(bool){
			  document.getElementById("successResponse").append("<%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVITATION.ACCEPT.SUCCESS")%>");
		  } else {
			  document.getElementById("successResponse").append("<%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVITATION.ACCEPT.REJECT")%>");
		  }
	  } else {
		  document.getElementById("showprompt").style.display="none";
		  document.getElementById("errorBlock").style.display="";
		  if(jsonResp.status == "already_verified"){
			  document.getElementById("responseError").append("<%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVITATION.EXPIRED")%>");
		  } else {
			  document.getElementById("responseError").innerHTML = "<%=I18NUtil.getMessage("IAM.OAUTH.CROSS.ORG.INVALID.INVITATION")%>";
			  document.getElementById("reasons_div").style.display="block";
		  }
	  }
	  return false;
  }
  </script>
</html>