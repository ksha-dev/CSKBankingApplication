<!-- $Id$ -->
<%@page import="com.adventnet.iam.IAMException.IAMErrorCode"%>
<%@page import="com.adventnet.iam.IAMStatusCode.StatusCode"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.actions.ZohoActionSupport"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.zoho.accounts.internal.OAuthException.OAuthErrorCode"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<html>
<head>
<title><%=Util.getI18NMsg(request,"IAM.ERROR.SERVER.ERROR.OCCURED")%></title>
<style>
    body { margin:0px; padding:0px;font-family:"Open sans";font-weight: 300; }
    .errmaindiv {text-align: center;}
    .errmsgdiv {margin-top:5px; border:6px solid #BFCAFF;}
    .errtxtheader b {float:left; font-size:15px; margin:0px; padding:15px 0px 0px 5px;}
    .err-reason {font-size:13px;}
    .abusetxt {padding: 5px 0px 5px 5px; font-size: 13px; text-align: center; font-weight: 300; margin-top: 20px;}
    .abusetxt a {color:#085DDC; text-decoration:none;}
    .abusetxt a:hover {text-decoration:underline;}
    .logo-top {
  width: 100px;
  height: 35px;
  margin: 40px auto;
  background-repeat: no-repeat;}
    .title1{margin-top:-14px;font-size:30px;font-family: "Open sans";font-weight:300;text-align: center;}
	.title2 {font-size:18px;width: 500px;margin-bottom: 10px;margin-top: 10px;}
	.bdre2 { border-bottom: 2px solid #000; height: 1px; margin: 6px auto; width: 100px; }
	.errorLogo{background: url("<%=StaticContentLoader.getStaticFilePath("/images/unauthsprite.png")%>") no-repeat scroll 5px 10px transparent; height: 130px; width: 150px;}  <%-- NO OUTPUTENCODING --%>
	.error-reason{font-size: 13px; line-height: 22px; margin-top: 13px;font-weight: 300}
	@font-face {
    font-family: 'Open Sans';
	font-weight: 400;
	font-style: normal;
	src :local('Open Sans'),url('<%=StaticContentLoader.getStaticFilePath("/images/font.woff")%>') format('woff');  <%-- NO OUTPUTENCODING --%>
 }
</style>
</head>
<body>
    <table class="errtbl" align="center" cellpadding="0" cellspacing="0">
			<div class="logo-top"></div>
			<div class="title1"><%=Util.getI18NMsg(request, "IAM.ERROR.UH")%></div>
			<div class="bdre2"></div>
	<tr><td  valign="middle">
	    <div class="errmaindiv">
	    <div class="errorLogo" style=" margin: 11px auto; "></div>
		<div>
		    <div style="font-size: 16px; font-weight: 500;">
		    
<%
String errorMessage = "General error"; //No I18N
boolean showContactAdminMsg = true;

if(request.getAttribute("statuscode") != null) {
	StatusCode statusCode = (StatusCode) request.getAttribute("statuscode");
	switch(statusCode) {
		case UNAPPROVED_USERS_LIMIT_EXCEEDED:{
			String adminEmail = String.valueOf(request.getAttribute("admin_email"));
			errorMessage = I18NUtil.getMessage("IAM.SIGNIN.ERROR.UNAPPROVED.USERS.LIMIT.EXCEEDED", Util.isValid(adminEmail)?adminEmail:"admin");
			showContactAdminMsg = false;
			break;
		}
		case USER_NOT_APPROVED: {
			String adminEmail = String.valueOf(request.getAttribute("admin_email"));
			errorMessage = I18NUtil.getMessage("IAM.SIGNIN.ERROR.USER.NOT.APPROVED", Util.isValid(adminEmail)?adminEmail:"admin");
			showContactAdminMsg = false;
			break;
		}
	}
} else if(ZohoActionSupport.getValue("ERROR_MESSAGE") != null) {	//No I18N
	errorMessage = (String) ZohoActionSupport.getValue("ERROR_MESSAGE"); //No I18N
} else if(request.getParameter("error")!= null) {
	try {
		if("true".equalsIgnoreCase(request.getParameter("iamexp"))){
			IAMErrorCode errorCode = IAMErrorCode.valueOf(request.getParameter("error"));
			if(IAMErrorCode.U167.equals(errorCode)){
				errorMessage = I18NUtil.getMessage("IAM.PORTAL.IDP.EMAIL.UNCONFIRMED",request.getParameter("info"));
			}		
		}else{
			OAuthErrorCode errorCode = OAuthErrorCode.valueOf(request.getParameter("error"));
			if(OAuthErrorCode.invalid_redirect_uri.equals(errorCode)){
				errorMessage = I18NUtil.getMessage("IAM.OAUTH.INVALID.REDIRECT.URI");
			}else if(OAuthErrorCode.inactive_user.equals(errorCode)){
				errorMessage = I18NUtil.getMessage("USER.NOT.ACTIVE");
			} else if(OAuthErrorCode.untrusted_request_domain.equals(errorCode)){
				errorMessage = I18NUtil.getMessage("IAM.UNTRUSTED.DOMAIN.TITLE");
			} else{
				errorMessage = I18NUtil.getMessage(errorCode.getDescription());
			}
		}
	}catch(Exception e){
		
	}
}
%>
		    </div>
		    <div class="error-reason">
				<div style=" font-weight: 300; font-size: 13px; "><%=Util.getI18NMsg(request,"IAM.ERROR.POSSIBLE.REASONS.TITLE")%></div>
			    <div> <%= IAMEncoder.encodeHTML(errorMessage)%></div>
	    	    </div>
		</div>
	    </div>
	</td></tr>
<% 	if(showContactAdminMsg) {	%>
	<tr><td  valign="middle">
	    <div class="abusetxt"><%=Util.getI18NMsg(request,"IAM.CLIENT.ERROR.HELP")%></div>
	</td></tr>
<%	}	%>
    </table>
</body>
</html>