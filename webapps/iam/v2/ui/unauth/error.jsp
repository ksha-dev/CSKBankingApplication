<%-- $Id$ --%>
<%@page import="com.zoho.accounts.internal.OAuthException.OAuthErrorCode"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.adventnet.iam.AccountsURLRule"%>
<%@page import="com.adventnet.iam.internal.filter.AccountsActionRule"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.ContentTypeString"%>
<%@page import="com.adventnet.iam.IAMStatusCode.StatusCode"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.ajax.AjaxResponse"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.adventnet.iam.IAMException.IAMErrorCode"%>
<%@page import="com.zoho.iam.rest.metadata.ICRESTMetaData"%>
<%@page import="com.adventnet.iam.security.SecurityRequestWrapper"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.security.IAMSecurityException"%>
<%@page import="com.zoho.iam.rest.ICRESTManager"%>
<%@page import="com.zoho.iam.rest.representation.ICRESTRepresentation"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@ page isErrorPage="true" %>
<%
response.setContentType("text/html;charset=UTF-8"); //No I18N
IAMSecurityException ex =  (IAMSecurityException) request.getAttribute(IAMSecurityException.class.getName());
if(ex != null && ex.getErrorCode() != null) {
    String errorCode = ex.getErrorCode();
    String requestUri = (String) request.getAttribute("javax.servlet.forward.request_uri");
   	if(errorCode.equals(IAMErrorCode.Z113.getErrorCode())){
   		if ("/webclient/v1/fsregister/signup".equals(requestUri) || "/webclient/v1/fsregister/associate".equals(requestUri) || "/webclient/v1/fsregister/otp".equals(requestUri) || "/oauth/v2/token/access".equals(requestUri) || "/webclient/v1/announcement/pre/mfa/self/mobile".equals(requestUri) || requestUri.contains("/webclient/v1/announcement/")) {
			JSONObject jsonresp = new JSONObject();
			jsonresp.put("response", "error"); // No I18N
			jsonresp.put("message", I18NUtil.getMessage("IAM.ERROR.SESSION.EXPIRED")); // No I18N
			if(requestUri.contains("/webclient/v1/announcement/")){
				jsonresp.put("redirect_url", "/signin");// No I18N
				jsonresp.put("code", IAMErrorCode.Z113); //No I18N
				jsonresp.put("servicename", request.getParameter("servicename")); //No I18N
				jsonresp.put("serviceurl", request.getParameter("serviceurl"));// No I18N
			}
			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
 			return;
		}
		String serviceUrl  = Util.getBackToURL(request.getParameter("servicename"), request.getParameter("serviceurl"));
		if(!IAMUtil.isTrustedDomain(serviceUrl)) {
			serviceUrl = Util.getRefererURL(request);
		}
		response.sendRedirect(serviceUrl); 
        return;
   	}
   	SecurityRequestWrapper req = SecurityRequestWrapper.getInstance(request);
   	AccountsActionRule rule = null;
   	try {
   		rule = (AccountsActionRule)req.getURLActionRule();
   	} catch(Exception e) {
   		Logger.getLogger("Error_JSP").log(Level.INFO, "exception in error page", e);//No I18N
   	}
   	if(rule != null) {
   		if(errorCode.equals(IAMErrorCode.Z223.getErrorCode()) || errorCode.equals(IAMErrorCode.Z114.getErrorCode())){
   	   		boolean isMobile = rule.isMobile();
   	   		String serviceUrl = Util.getServerUrl(request) + requestUri + (request.getQueryString() == null ? "" :"?"+request.getQueryString());
   	   		if("GET".equalsIgnoreCase(rule.getMethod()) && !"code".equals(AccountsURLRule.getAccountsURLRule(rule).getReauthResponse())){
   				response.sendRedirect(IAMUtil.getReauthURL(request, serviceUrl) + "&ismobile=" + isMobile); // No I18N
   				return;
   	   		} else {
   	   			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
   				JSONObject jsonresp = new JSONObject();
   				jsonresp.put("response", "error"); // No I18N
   				jsonresp.put("code", IAMErrorCode.PP112); //No I18N
   				jsonresp.put("cause", "invalid_password_token"); // No I18N
   				jsonresp.put("redirect_url", com.zoho.accounts.internal.util.Util.getReauthUrlPath()); // No I18N
   				if(errorCode.equals(IAMErrorCode.Z223.getErrorCode())) {
	   				jsonresp.put("mobile", isMobile); //No I18N
   				} else {
   					jsonresp.put("message", I18NUtil.getMessage("IAM.ERROR.RELOGIN.REFRESH")); // No I18N
   				}
   				response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   				return;
   	   		}
   	   	}
   	   	
   		String rulePath = rule.getPath();

		if (rulePath != null && (rulePath.contains("/api/v1/") || rulePath.contains("/ssokit/v1/"))) {
			if (errorCode.equals(IAMSecurityException.URL_ROLLING_THROTTLES_LIMIT_EXCEEDED)) {
				JSONObject jsonresp = new JSONObject();
				jsonresp.put("response", "error"); //No I18N
	   			jsonresp.put("code", IAMErrorCode.Z101); //No I18N
   				jsonresp.put("cause", "throttles_limit_exceeded"); //No I18N
	   			jsonresp.put("localized_message", I18NUtil.getUnencodedMessage("IAM.NEW.URL.THOTTLE.ERROR")); //No I18N
	   			response.getWriter().print(jsonresp);
	   			return;
			}
			ICRESTRepresentation representation = ICRESTManager.getErrorResponse(request);
			if (representation != null) {
				response.setStatus(200);
				ICRESTMetaData metaData = ICRESTManager.getResourceMetaData(request);
				ICRESTManager.writeResponse(request, response, metaData, representation);
				return;
			}
		}

	    if(("/accounts/addpass.ac".equals(rulePath) || Pattern.matches("/accounts/p/[a-zA-Z0-9]+/pconfirm",rulePath) || Pattern.matches("/cu/[a-zA-Z0-9]+/addpass.ac",rulePath) || ("/accounts/adduser.ac".equals(rulePath))  || ("/accounts/password.ac".equals(rulePath)) || ("/accounts/reset.ac".equals(rulePath)) || Pattern.matches("/cu/[0-9]+/secureconfirm.ac", rulePath) || "/accounts/secureconfirm.ac".equals(rulePath)) && errorCode.equals(IAMSecurityException.BROWSER_COOKIES_DISABLED))
	    {
	    	AjaxResponse ar = new AjaxResponse(AjaxResponse.Type.JSON).setResponse(response);
	    	ar.addError(Util.getI18NMsg(request, "IAM.ERROR.COOKIE.DISABLED")).print();//No I18N
	    	return;
	
	    }
	    
   		if(IAMSecurityException.PATTERN_NOT_MATCHED.equals(errorCode))
   		{
   			if(("/webclient/v1/register/initiate".equals(rulePath) || "/webclient/v1/fsregister/signup".equals(rulePath)) && (("firstname".equals(ex.getEmbedParameterName()) || "lastname".equals(ex.getEmbedParameterName()))))
   			{
   				JSONObject jsonresp = new JSONObject();
   	   	     	JSONArray errors = new JSONArray();
   				errors.put(new JSONObject().put("field",ex.getEmbedParameterName())); //No I18N
   	   			jsonresp.put("errors", errors); //No I18N
	   	   		if("firstname".equals(ex.getEmbedParameterName())){ //No I18N
	   	   			jsonresp.put("localized_message", I18NUtil.getMessage("IAM.ERROR.FNAME.INVALID.CHARACTERS")); // No I18N
	   			}else{
	   				jsonresp.put("localized_message", I18NUtil.getMessage("IAM.ERROR.LNAME.INVALID.CHARACTERS")); // No I18N
	   			}
   	   			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   	   			response.setStatus(200);
   	   			return;
   			}
   			if("/webclient/v1/account/self/user/self/email".equals(rulePath) && "email_id".equals(ex.getEmbedParameterName()))
   			{
   				JSONObject jsonresp = new JSONObject();
   	   			jsonresp.put("response", "error"); // No I18N
   	   			jsonresp.put("message", Util.getI18NMsg(request, "IAM.ERROR.EMAIL.INVALID")); // No I18N
   	   			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   	   			return;
   			}
   			if("/webclient/v1/account/self/user/self/allowedip".equals(rulePath)	&&	"ip_name".equals(ex.getEmbedParameterName())) 
   			{
   				JSONObject jsonresp = new JSONObject();
   	   			jsonresp.put("response", "error"); // No I18N
   	   			jsonresp.put("message", Util.getI18NMsg(request, "IAM.ALLOWEDIP.NAME.NOTVALID")); // No I18N
	   	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	   	   		return;
   		    }
   			if("/password/v2/primary/${ZID}/domain/${ciphertext}".equals(rulePath)	&&	"domain".equals(ex.getEmbedParameterName())) 
   			{
   				JSONObject jsonresp = new JSONObject();
   	   			jsonresp.put("response", "error"); // No I18N
   	   			jsonresp.put("message", Util.getI18NMsg(request, "IAM.AC.DOMAIN.INVALID.ERROR")); // No I18N
	   	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	   	   		return;
   		    }
   			else if("/webclient/v1/orguserinvitation/${digest_in_url}".equals(rulePath) || "/webclient/v1/ginvitation/${digest_in_url}".equals(rulePath))
   			{
   	   			JSONObject jsonresp = new JSONObject();
	   			JSONArray errors = new JSONArray();
   				errors.put(new JSONObject().put("field",ex.getEmbedParameterName())); //No I18N
   	   			jsonresp.put("errors", errors); //No I18N
	   	   		if("firstname".equals(ex.getEmbedParameterName())){
	   	   			jsonresp.put("localized_message", I18NUtil.getMessage("IAM.ERROR.FNAME.INVALID.CHARACTERS")); // No I18N
	   				response.getWriter().print(jsonresp); // NO OUTPUTENCODING
		   	   		return;
	   			}
				else if("lastname".equals(ex.getEmbedParameterName())){
					jsonresp.put("localized_message", I18NUtil.getMessage("IAM.ERROR.LNAME.INVALID.CHARACTERS")); // No I18N
					response.getWriter().print(jsonresp); // NO OUTPUTENCODING
		   	   		return;
	   			}
   			}
   	   		else if("/webclient/v1/account/self/user/self/groups".equals(rulePath))
   	   		{
   	   			if("grpname".equals(ex.getEmbedParameterName()))
   	   			{
	   	   			JSONObject jsonresp = new JSONObject();
	   	   			jsonresp.put("response", "error"); // No I18N
	   	   			jsonresp.put("message", Util.getI18NMsg(request, "IAM.GROUP.CREATE.ERROR.INVALID.GROUP")); // No I18N
		   	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
		   	   		return;
   	   			}
   	   		}
   	   		else if("/webclient/v1/account/self/user/self".equals(rulePath)){
	   	   		JSONObject jsonresp = new JSONObject();
	   			jsonresp.put("response", "error"); // No I18N
	   			if("first_name".equals(ex.getEmbedParameterName())){
	   				jsonresp.put("message",Util.getI18NMsg(request, "IAM.ERROR.FNAME.INVALID.CHARACTERS")); // No I18N
	   			}
				else if("last_name".equals(ex.getEmbedParameterName())){
					jsonresp.put("message",Util.getI18NMsg(request, "IAM.ERROR.LNAME.INVALID.CHARACTERS")); // No I18N
	   			}
	   			else if("display_name".equals(ex.getEmbedParameterName())){
	   				jsonresp.put("message",Util.getI18NMsg(request, "IAM.ERROR.DISPLAYNAME.INVALID.CHARACTERS")); // No I18N
	   			}
	   			else{
	   				jsonresp.put("message",Util.getI18NMsg(request, "IAM.ERROR.INVALID.INPUT")); // No I18N
	   			}
	   	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	   	   		return;
   	   		}
   	   		else if(("/webclient/v1/account/self/user/self/mfa/mode/otp/${iambase64}".equals(rulePath)	&&	"code".equals(ex.getEmbedParameterName()))	)
   	   		{
   	   			JSONObject jsonresp = new JSONObject();
	   			jsonresp.put("response", "error"); // No I18N
	   			jsonresp.put("message", Util.getI18NMsg(request, "IAM.PHONE.INVALID.BACKUP.CODE")); // No I18N
	   	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	   	   		return;
   	   		}
		   	else if(	(	"/webclient/v1/account/self/user/self/phone/${oz-phoneno}".equals(rulePath)	||	"/webclient/v1/account/self/user/self/email/${email}".equals(rulePath))		&&	("otp_code".equals(ex.getEmbedParameterName()))	)
			{
				JSONObject jsonresp = new JSONObject();
				jsonresp.put("response", "error"); // No I18N
				jsonresp.put("message", Util.getI18NMsg(request, "IAM.GENERAL.ERROR.INVALID.OTP")); // No I18N
		   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	 			return;
			}
   			if("/webclient/v1/fsregister/signup".equals(rulePath) && ("emailormobile".equals(ex.getEmbedParameterName()) || "mobile".equals(ex.getEmbedParameterName()))){
   				JSONObject jsonresp = new JSONObject();
   				jsonresp.put("response", "error"); // No I18N
   				jsonresp.put("message", I18NUtil.getMessage("IAM.ERROR.CODE.PH105")); //No I18N
   		   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	   		   	return;
   			}
   		}
   		if(IAMSecurityException.INVALID_FILE_EXTENSION.equals(errorCode) &&	"/webclient/v1/account/self/user/self/photo".equals(rulePath))
   		{
   			JSONObject jsonresp = new JSONObject();
			jsonresp.put("response", "error"); // No I18N
			jsonresp.put("message", Util.getI18NMsg(request, "IAM.UPLOAD.PHOTO.INVALID.IMAGE")); // No I18N
	   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
 			return;
   		}
   		
   		if(errorCode.equals(IAMSecurityException.URL_ROLLING_THROTTLES_LIMIT_EXCEEDED)) {
   			String urlThrottleMessage = null;
   			JSONObject jsonresp = new JSONObject();
   			if("/signin".equals(rulePath)) {
   				urlThrottleMessage = Util.getI18NMsg(request, "IAM.NEW.SIGNIN.URL.THOTTLE.ERROR");// No I18N
   			} else if("/linkaccount/add".equals(rulePath)){ //No I18N
   				request.setAttribute("provider", request.getParameter("provider"));
   				request.setAttribute("statuscode", StatusCode.LINKED_ACCOUNT_THROTTLE_EXCEEDED);
   				request.getRequestDispatcher("/v2/ui/unauth/ui-error.jsp").forward(request, response);//No I18N
   				return;
   			} else if(rulePath.startsWith("/relogin/v1")){//No I18N
   				jsonresp.put("cause", "reauth_threshold_exceeded");//No I18N
   				jsonresp.put("code", IAMErrorCode.Z225);//No I18N
   			} else {
   				urlThrottleMessage = Util.getI18NMsg(request, "IAM.NEW.URL.THOTTLE.ERROR");// No I18N
   			}
   			jsonresp.put("response", "error"); // No I18N
   			if(!jsonresp.has("code")){
	   			jsonresp.put("code", IAMErrorCode.Z101); //No I18N
   			}
   			if(!jsonresp.has("cause")){
   				jsonresp.put("cause", "throttles_limit_exceeded"); // No I18N
   			}
   			jsonresp.put("localized_message", urlThrottleMessage); // No I18N
   			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   			return;
   	    }
   		
   		if(errorCode.equals(IAMSecurityException.INVALID_OAUTHTOKEN) || errorCode.equals(IAMSecurityException.INVALID_OAUTHSCOPE)){
   			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
   			response.setContentType(ContentTypeString.JSON);
   			JSONObject jsonresp = new JSONObject();
   			jsonresp.put("response", "error"); // No I18N
   			jsonresp.put("cause",errorCode); // No I18N
   			response.getWriter().print(jsonresp);
   			return;
   		}
   		
   		if(errorCode.equals(IAMErrorCode.OA102.getErrorCode())){
   			if(rulePath.contains("/oauth/v2/mobile/addextrascopes") || rulePath.contains("/oauth/v2/internal/token/activate") || rulePath.contains("/oauth/v2/mobile/getremotejwt")) {
   				JSONObject jsonresp = new JSONObject();
   				jsonresp.put("status", "failure"); // No I18N
  				jsonresp.put("error", IAMErrorCode.OA102.getDescription()); // No I18N
  				response.setContentType(ContentTypeString.JSON);
  		   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
  		   		return;
   			}   			
   		}
   	
   		if(errorCode.equals(IAMSecurityException.URL_FIXED_THROTTLES_LIMIT_EXCEEDED)){
   			if(rulePath.contains("/oauth/") || rulePath.contains("/oauthapp/")){
   				if(rule.getMethod().equalsIgnoreCase("POST")) {
	  				JSONObject jsonresp = new JSONObject();
	  				jsonresp.put("error", I18NUtil.getMessage("IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER")); // No I18N
	  				jsonresp.put("error_description", I18NUtil.getMessage("IAM.OAUTH.ACCESS.DENIED.API.DESCRIPTION")); // No I18N
	  				response.setContentType(ContentTypeString.JSON);
	  		   		response.getWriter().print(jsonresp); // NO OUTPUTENCODING
	  		   		return;
   				} else {
   				request.setAttribute("statuscode", StatusCode.OAUTH_ACCESS_LIMIT_EXCEEDED);
   				}
   			}
   		}
   		
   		if(errorCode.equals(IAMSecurityException.IP_NOT_ALLOWED) && (rulePath.contains("/webclient/v1/account") ||  (rulePath.contains("/oauth/user/info")))){
   			JSONObject jsonresp = new JSONObject();
   			jsonresp.put("response", "error"); // No I18N
   			jsonresp.put("code", IAMErrorCode.T102); //No I18N
   			jsonresp.put("redirect_url", new StringBuilder(Util.getServerUrl(request)).append(Util.AccountsUIURLs.RESET_IP.getURI()).toString()); // No I18N
   			jsonresp.put("cause", IAMErrorCode.T102.getDescription()); // No I18N
   			jsonresp.put("localized_message", I18NUtil.getMessage("IAM.ERRORJSP.IP.NOT.ALLOWED.ACTION.ERROR",IAMUtil.getRemoteUserIPAddress(req))); // No I18N
   			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   			return;
   		}
   		if(errorCode.equals(IAMSecurityException.MORE_THAN_MAX_LENGTH) && rulePath.contains("/webclient/v1/register/field/validate")){
   			JSONObject jsonresp = new JSONObject();
   	     	JSONArray errors = new JSONArray();
			errors.put(new JSONObject().put("field",ex.getEmbedParameterName())); //No I18N
   			jsonresp.put("errors", errors); //No I18N
   			if("email".equals(ex.getEmbedParameterName())){ //No I18N
   				jsonresp.put("localized_message", I18NUtil.getMessage("IAM.USER.EMAIL.EXCEEDS.MAX.LENGTH")); // No I18N
   			}else{
   				jsonresp.put("localized_message",I18NUtil.getMessage("IAM.USER.MAX.LENGTH.EXCEEDS.ERROR")); // No I18N
   			}
   			response.getWriter().print(jsonresp); // NO OUTPUTENCODING
   			response.setStatus(200);
   			return;
   		}
   		if(errorCode.equals(IAMErrorCode.MDM001.getDescription())){
   			request.setAttribute("statuscode", StatusCode.MDM_TOKEN_BLOCKED);
   			request.setAttribute("code", IAMErrorCode.MDM001.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.MDM002.getDescription())){
   			request.setAttribute("statuscode", StatusCode.MDM_TOKEN_BLOCKED);
   			request.setAttribute("code", IAMErrorCode.MDM002.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.MDM003.getDescription())){
   			request.setAttribute("statuscode", StatusCode.MDM_TOKEN_BLOCKED);
   			request.setAttribute("code", IAMErrorCode.MDM003.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.MDM004.getDescription())){
   			request.setAttribute("statuscode", StatusCode.MDM_TOKEN_BLOCKED);
   			request.setAttribute("code", IAMErrorCode.MDM004.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.CAP100.getDescription())){
   	   		request.setAttribute("statuscode", StatusCode.CONDITIONAL_ACCESS_BLOCK);
   	   		request.setAttribute("code", IAMErrorCode.CAP100.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.CAP101.getDescription())){
   	   		request.setAttribute("statuscode", StatusCode.CONDITIONAL_ACCESS_BLOCK);
	   	   	request.setAttribute("code", IAMErrorCode.CAP101.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.CAP102.getDescription())){
   	   		request.setAttribute("statuscode", StatusCode.CONDITIONAL_ACCESS_BLOCK);
	   	   	request.setAttribute("code", IAMErrorCode.CAP102.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.CAP103.getDescription())){
   	   		request.setAttribute("statuscode", StatusCode.CONDITIONAL_ACCESS_BLOCK);
	   	   	request.setAttribute("code", IAMErrorCode.CAP103.getErrorCode());
   	   	}
   		if(errorCode.equals(IAMErrorCode.CAP104.getDescription())){
   	   		request.setAttribute("statuscode", StatusCode.CONDITIONAL_ACCESS_BLOCK);
	   	   	request.setAttribute("code", IAMErrorCode.CAP104.getErrorCode());
   	   	}

   	}else if(errorCode.equals(IAMSecurityException.URL_RULE_NOT_CONFIGURED)){
   		request.setAttribute("statuscode", StatusCode.URL_RULE_NOT_CONFIGURED);
   		//request.setAttribute("statuscode", StatusCode.USER_NOT_ALLOWED_IP);
   	}
   	if (errorCode.equals(IAMErrorCode.CAP100.getDescription())) {
   		request.setAttribute("statuscode", StatusCode.LOCATION_NOT_ALLOWED);
   		request.getRequestDispatcher("/v2/ui/unauth/ip_restriction.jsp").forward(request, response); //No I18N
   		return;
   	}
   	if(errorCode.equals(IAMSecurityException.IP_NOT_ALLOWED)){
   		request.setAttribute("statuscode", StatusCode.USER_NOT_ALLOWED_IP);
   		request.getRequestDispatcher("/v2/ui/unauth/ip_restriction.jsp").forward(request, response); //No I18N
   		return;
   	}
}else if(response.getStatus() == 404 ){//404 jsp/html/page not found
	Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "Unknown Error reached error.jsp:", new Exception());	
	request.setAttribute("statuscode", StatusCode.URL_RULE_NOT_CONFIGURED);
}
  	request.getRequestDispatcher("/v2/ui/unauth/ui-error.jsp").forward(request, response);//No I18N
%>
