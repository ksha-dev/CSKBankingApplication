<%-- $Id$ --%>
<%@page import="com.adventnet.iam.IAMException.IAMErrorCode"%>
<%@page import="com.zoho.logs.common.jsonorg.JSONException"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@page import="com.zoho.resource.Criteria.Comparator"%>
<%@page import="com.zoho.accounts.Accounts.RESOURCE.ACCOUNTMEMBER"%>
<%@page import="com.adventnet.iam.IAMException"%>
<%@page import="com.zoho.accounts.CloseAccountUtil.AccountCloseType"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.adventnet.iam.UserLite"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.adventnet.iam.ServiceOrg"%>
<%@page import="java.util.List"%>
<%@page import="com.adventnet.iam.User"%>
<%@page import="com.zoho.accounts.AccountsConstants.ZIDType"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.AppAccount.AppAccountService.AccountMember"%>
<%@page import="com.zoho.accounts.Accounts.RESOURCE.APPACCOUNTMEMBER"%>
<%@page import="com.adventnet.iam.internal.CloseAccountHandlerDispatcher"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="com.zoho.accounts.internal.util.CloseAccountInternalUtil"%>
<%@page import="com.zoho.accounts.CloseAccountUtil"%>
<%@page import="com.zoho.accounts.CloseAccountUtil.HandlerType"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.accounts.cache.MemCacheConstants"%>
<%@page import="com.zoho.accounts.cache.MemCacheUtil"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.zoho.accounts.Accounts"%>
<%@page import="com.adventnet.iam.AppAccount"%>
<%@page import="com.zoho.iam2.rest.RestProtoUtil"%>
<%@page import="com.zoho.resource.Criteria"%>
<%@page import="com.zoho.accounts.Accounts.RESOURCE.APPACCOUNT"%>
<%@page import="com.zoho.accounts.AccountsConstants.OrgType"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder,com.adventnet.iam.IAMUtil"%>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script><%-- NO OUTPUTENCODING --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js"></script><%-- NO OUTPUTENCODING --%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/css/select2.min.css" rel="stylesheet" ></link><%-- NO OUTPUTENCODING --%>

<script src="closeaccount.js" type="text/javascript"></script><%-- NO OUTPUTENCODING --%>
<link href="closeaccount.css"  rel="stylesheet" type="text/css"></link><%-- NO OUTPUTENCODING --%>

<%
	String type = request.getParameter("type");  
	String value = request.getParameter("value");
	String panel = request.getParameter("panel");
	String sName = request.getParameter("sname");
	String devSetupUrl = request.getParameter("dev_setup_url");
	boolean isRefresh = Boolean.parseBoolean(request.getParameter("refresh")); 
	
	OrgType orgType = null;
	if (Util.isValid(sName)) {
		try {
	orgType = OrgType.valueOf(sName.toUpperCase());
		} catch (Exception e){}
	}
	String ccPath = request.getContextPath();
%>

<div class="maincontent" style="margin-left: 40%;">
	<table>
		<tr>
			<td>
		    	<select id='type' >
		    		<option value='email' <%if("email".equals(type)){%>selected<%}%>>EmailId</option><%--No I18N--%>
		    		<option value='zuid' <%if("zuid".equals(type)){%>selected<%}%>>ZUID </option><%--No I18N--%>
		    	</select>
		    </td>
		    <td> : </td>
			<td>
				<div class="searchfielddiv">
	                <input type="text" name="val" id="val" style="width:273px;height:26px;" value="<%=Util.isValid(value)?value:""%>"/>
			    </div>
			</td>
		</tr>
		<tr>
			<td style="float:right;padding-top:5px;">Service</td><%--No I18N--%>
			<td> : </td>
			<td>
				<select id="service" class="select2Div" style="width:273px;height:26px;" >
					<option <%if("select".equals(sName)){%>selected<%}%> value='select'>Select</option>  <%--No I18N--%>
					<%
						for(OrgType ot : OrgType.values()) {
					%>
						<option <%if(ot == orgType){%>selected<%}%> value="<%=ot.toString().toLowerCase()%>"><%=ot.getServiceName()+" ("+(ot.isAppAccountType()?"AA":"SO")+")"%></option>
					<%
						}
					%>
					<option <%if(orgType == null && Util.isValid(sName)){%>selected<%}%> value="others" >Others</option><%--No I18N--%>
				</select>
			</td>
			<td>
				<input id="others_sname" type="text" value="<%=(orgType == null && Util.isValid(sName))?sName:""%>" style="width:273px;height:26px;" hidden/>
			</td>
		</tr>
		<% if(Util.isDevelopmentSetup()) { %>
			<tr>
				<td>
			    	<div>Dev Setup URL</div><%--No I18N--%>
			    </td>
			    <td> : </td>
				<td>
					<input id="dev_setup_url" type="text" value="<%=Util.isValid(devSetupUrl)?devSetupUrl:""%>" style="width:273px;height:26px;"/>
				</td>
			</tr>
		<% } %>
		
		<tr>
			<td colspan="3" style="text-align: center;" >
				<button onclick="loadServicesForCloseAccount()" style="margin-top:10px;margin-left: 30%;margin-right: 30%;">List Service Portals</button><%--No I18N--%>
			</td>
		</tr>
	</table>
	<div id="err_div"></div>
	<script type="text/javascript">
		initSelect2ForCloseAcc();
	</script>
</div>

<hr style="margin-top:30px;margin-bottom:30px">
	<%
		User u = null;
		if(Util.isValid(panel)) {
	 		u = getUser(type, value);
	 		String errorMsg = validateAndReturnErrorMsg(u, devSetupUrl);
	 		if(Util.isValid(errorMsg)) {
				%><script type="text/javascript">showerrormsg('<%=errorMsg%>');</script><%--No I18N--%><%
				return;
			}
		}
					
		if("serlist".equals(panel)) {
			List<String> portalIds = new ArrayList();
			if(orgType == null || (!u.isOrgUser() && orgType.isAppAccountType())) {
				Set<String> orgServices = CloseAccountInternalUtil.getOrgBasedServices(u);
				if(orgServices.contains(sName)) {
					portalIds.add(u.isOrgUser() ? u.getZoid() : u.getZuid());
				}
			} else if(orgType.isAppAccountType()) {
				List<com.zoho.accounts.AccountsProto.Account.AppAccount> appAccounts = getAppAccounts(u, orgType);
				if(appAccounts != null) {
					appAccounts.forEach(aAcc -> portalIds.add(aAcc.getZaaid()));
				}
			} else {
				List<ServiceOrg> serviceOrgs = u.isOrgAdmin() ?  getServiceOrgs(orgType.getType(), u.getZOID()) : Util.serviceOrgAPI.getServiceOrgs(orgType.getType(), u.getZUID());
				if(serviceOrgs != null) {
					serviceOrgs.forEach(sOrg -> portalIds.add(sOrg.getZsoid()));
				}
			}
			if(portalIds.isEmpty()) {
				%><br><div style="color:red;">No Accounts found under selected service</div><%--No I18N--%><%
				return;
			}
			
			String nextPage = "type="+type+"&value="+IAMEncoder.encodeURL(value)+"&sname="+sName+"&panel=precheck";	//No I18N			
			if(Util.isValid(devSetupUrl)) {
				nextPage+="&dev_setup_url="+IAMEncoder.encodeURL(devSetupUrl);	//No I18N
			}
			
		%>
			<table id="portal_details" style="margin-left: 30%;">
				<tr>
					<th style="width: 10%;"></th>
					<th style="width: 30%;">ZID</th><%--No I18N--%>
				</tr>
				<%	for(String serPortalId : portalIds) {	%>
					<tr>
						<td><input type="radio" id="html" name="portals" value=<%=serPortalId%>></td>
						<td><%=serPortalId%></td>						
					</tr>
				<%	}	%>
			</table>
				
			<div class="accbtn Hbtn" style="padding-top:30px">
				<button onclick="closeAccount('<%=nextPage+"&handlerType="+HandlerType.pre_close_account_check%>')">Close Account- PreCheck</button><%--No I18N--%>
				<button onclick="closeAccount('<%=nextPage+"&handlerType="+HandlerType.pre_close_members_check%>')">Close Members- PreCheck</button><%--No I18N--%>
			</div>
		<%
			}
				
				else if ("precheck".equals(panel)) {
			String zidToClose = u.getZuid(); 
			User currentUser = IAMUtil.getCurrentUser();
			String requestId = CloseAccountInternalUtil.getRequestId(String.valueOf(zidToClose));
			if(!Util.isValid(requestId))
			{
			 requestId = CloseAccountInternalUtil.initiateRequest(String.valueOf(zidToClose),true);
			}
			AccountCloseType closeType = CloseAccountInternalUtil.getAccountCloseType(requestId);
			
			long zid = Long.valueOf(request.getParameter("zid"));
			String handler = request.getParameter("handlerType");
			HandlerType handlerType = HandlerType.valueOf(handler);
			if(!isRefresh) {
				List<User> users = null;
				List<String> orgAccounts = null;
				List<AppAccount> appAccounts = null;
				List<ServiceOrg> serviceOrgs = null;
				
				if(orgType == null || (!u.isOrgUser() && orgType.isAppAccountType())) {
					orgAccounts = Collections.singletonList(sName);
				} else if (orgType.isAppAccountType()) {
					AppAccount appAccount = Util.appAccountVOAPI.getAppAccount(orgType.getType(), zid);
					appAccounts = Collections.singletonList(appAccount);
				} else if (orgType.isServiceOrg()) {
					ServiceOrg serviceOrg = Util.serviceOrgAPI.getServiceOrg(orgType.getType(), zid);
					serviceOrgs = Collections.singletonList(serviceOrg);
				}				
				requestId = CloseAccountInternalUtil.getRequestId(String.valueOf(zidToClose));
				CloseAccountHandlerDispatcher.enQ(handlerType, zidToClose, closeType, requestId ,serviceOrgs, appAccounts, orgAccounts, devSetupUrl);
			}
			Thread.sleep(3000);
			String res = getResponseFromCache(requestId, handlerType, orgType, sName, String.valueOf(zid));
			if(!isValidStatusCode(res)) {
				out.print(getInvalidErrorCodeMsg());
			}
			
			String paidStatus = CloseAccountInternalUtil.isPaidAccount(requestId, String.valueOf(zid));
			String refreshUrl = request.getRequestURL()+"?"+request.getQueryString() + ((isRefresh) ? "" : "&requestId="+requestId+"&refresh=true");	//No I18N
			boolean isCloseMem = HandlerType.pre_close_members_check.equals(handlerType);
			String nextPage = request.getRequestURL()+"?type="+type+"&value="+IAMEncoder.encodeURL(value)+"&sname="+sName+"&zid="+zid+"&requestId="+requestId+"&panel="+(isCloseMem?"userslist":"closeacc");	//No I18N
			if(Util.isValid(devSetupUrl)) {
				nextPage+="&dev_setup_url="+IAMEncoder.encodeURL(devSetupUrl);	//No I18N
			}
			String nextPageName = isCloseMem?"List Members":"Close Account";	//No I18N
		%>
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle">Close Account request ID: '<%=requestId%>'</div><%--No I18N--%>				
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle">ZSOID or ZAAID: '<%=zid%>'</div><%--No I18N--%>				
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle"><%=handlerType.toString()%> Response :</div><%--No I18N--%>
			
			
			<textarea id="closeAccRes" readonly="" style="font-size:10px;margin-left:22%;background-color:#EEF2F4" name="closeAccRes" rows="25" cols="50"></textarea>
			<script>addBeautifiedResponse( <%=res%> );</script>
			<div class="accbtn Hbtn" style="padding-top:30px">
				<button onclick="window.location.replace('<%=refreshUrl%>')">Refresh</button><%--No I18N--%>
				<button onclick="window.location.replace('<%=nextPage%>')"><%=nextPageName%></button><%--No I18N--%>
			</div>
			
		<%
			}
				
					
	else if("userslist".equals(panel)) {	//No I18N
			String zid = request.getParameter("zid");
			String requestId = request.getParameter("requestId");
		%>	
		<div style="margin-left: 30%; margin-bottom:30px;" class="subtitle">Select Users To Close</div> 
		<div style="width:500px; height:500px; border-style:solid; border-width:thin;margin-left:22%;overflow:scroll;">	
		<%

		String nextPage = "type="+type+"&value="+IAMEncoder.encodeURL(value)+"&sname="+sName+"&zid="+zid+"&panel=closeacc";	//No I18N
		if(Util.isValid(devSetupUrl)) {
			nextPage+="&dev_setup_url="+IAMEncoder.encodeURL(devSetupUrl);	//No I18N
		}
		List<User> users = getUsersUnderPortal(orgType, u, Long.valueOf(zid));
		String preCloseMemRes = getResponseFromCache(requestId, HandlerType.pre_close_members_check, orgType, sName, zid);
		if(Util.isValid(preCloseMemRes)) {
			if(!isValidStatusCode(preCloseMemRes)) {
				out.print(getInvalidErrorCodeMsg());
			}
			JSONObject cricticalUsersObj = new JSONObject(preCloseMemRes).optJSONObject("critical_users");	//No I18N
			for (User ul : users) {
				JSONObject criticalUser = (cricticalUsersObj!=null) ? cricticalUsersObj.optJSONObject(String.valueOf(ul.getZuid())):null;
			%>
					<div>
						<input type="checkbox" name="email_cb" value="<%=ul.getZuid()%>" <%=(criticalUser!=null)?"disabled":""%>><%--No I18N--%>
						<label for="<%=ul.getZuid()%>" <%=(criticalUser!=null)?"style='color:red;'":""%>> <%=ul.getPrimaryEmail() + ((criticalUser!=null)?"  "+String.valueOf(criticalUser):"")%></label><br>
					</div>
				<%
					}
				%>
				</div>
				<button style="margin-left: 30%; margin-top:30px;" onclick="closeMembers('<%= nextPage %>')">Close Members</button><%--No I18N--%>
			<%

		} else { %>
			<div style='margin-left: 20%; margin-bottom:30px;'>Response not received from service yet.</div>"
		<% }
	}

				
			else if ("closeacc".equals(panel)) {
			String zid = request.getParameter("zid");
			String m = request.getParameter("members");
			
			String zidToClose = u.getZuid(); 			
			User currentUser = IAMUtil.getCurrentUser();
			String requestId = CloseAccountInternalUtil.getRequestId(zidToClose);
			AccountCloseType closeType = CloseAccountInternalUtil.getAccountCloseType(requestId);
			HandlerType handlerType = (m == null) ? HandlerType.close_account : HandlerType.close_members; 
			
			if(!isRefresh) {
				List<AppAccount> appAcc = null;
				List<ServiceOrg> serOrg = null;
				List<String> orgOrPersonalService = null;
				List<User> users = null;
				
				if (orgType == null) {
					orgOrPersonalService = Collections.singletonList(sName);
				} else if(orgType.isAppAccountType()) {
					AppAccount aAcc = Util.appAccountVOAPI.getAppAccount(orgType.getType(), Long.valueOf(zid));
					if(aAcc !=null) {
						appAcc = Collections.singletonList(aAcc);
					}
				} else if(orgType.isServiceOrg()) {
					ServiceOrg sOrg = Util.serviceOrgAPI.getServiceOrg(orgType.getType(), Long.valueOf(zid));
					if(sOrg != null) {
						serOrg = Collections.singletonList(sOrg);
					}
				}
				if(Util.isValid(m)) {
					String[] members = m.split(",");
					//users = Util.USERAPI.getUsers(members);
					CloseAccountInternalUtil.addUsersSelectedToDelete(requestId, Arrays.asList(members));
				}
				if(handlerType == HandlerType.close_members)
				{
					CloseAccountHandlerDispatcher.enQ(HandlerType.handle_pre_close_members, zidToClose, closeType,  requestId, serOrg, appAcc, orgOrPersonalService, devSetupUrl); 
				}
				CloseAccountHandlerDispatcher.enQ(handlerType, zidToClose, closeType,  requestId, serOrg, appAcc, orgOrPersonalService, devSetupUrl); 
					
			}
			Thread.sleep(3000);
			String res = getResponseFromCache(requestId, handlerType, orgType, sName, zid);
			if(!isValidStatusCode(res)) {
				out.print(getInvalidErrorCodeMsg());
			}
			String refreshUrl = "/internal/closeaccount.jsp?"+request.getQueryString()+(isRefresh?"":"&refresh=true");	//No I18N
		%>
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle">Close Account request ID: '<%=requestId%>'</div><%--No I18N--%>				
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle">ZSOID or ZAAID: '<%=zid%>'</div><%--No I18N--%>				
			<div style="margin-left: 20%; margin-bottom:30px;" class="subtitle"><%=handlerType%> Response</div><%--No I18N--%>
			<textarea id="closeAccRes" readonly="" style="font-size:10px;margin-left:22%;background-color:#EEF2F4" name="closeAccRes" rows="25" cols="50"></textarea><br>
			<script>addBeautifiedResponse( <%= res %> );</script>
			<div class="accbtn Hbtn" style="padding-top:30px">
				<button onclick="window.location.replace('<%= refreshUrl %>')">Refresh</button><%--No I18N--%>
			</div>
	<%	} %>




<%!	public static String validateAndReturnErrorMsg(User user, String devSetupUrl) {
	if(user == null) {
		return "No User found";	//No I18N
	}
	String email = user.getPrimaryEmail();
	if(email==null || !email.matches("[\\w]([\\w\\-\\.\\+\\']*)@zohotest.com$")) {
		return "Only zohotest.com emails allowed";	//No I18N
	} else if(user.isOrgUser() && !user.isOrgAdmin()) {
		return "User should be Org Admin or Personal User";	//No I18N
	}
	if(Util.isValid(devSetupUrl)) {
		if(!Util.isDevelopmentSetup()) {
			return "Custom Service URL only allowed in Development setup";	//No I18N
		} else if(!IAMUtil.isTrustedDomain(devSetupUrl)) {
			return "Custom Service URL is not from Trusted Domain";	//No I18N
		}
	}
	return null;
}	%>

<%!private static User getUser(String type, String val) {
	User user = null;
	try{
		if("email".equals(type)) {
			user = Util.USERAPI.getUser(val);
		} else if("zuid".equals(type)){//No I18N
			user = Util.USERAPI.getUserFromZUID(val);
		}
	} catch (Exception e){}
	return user;
}%>

<%!private static List<ServiceOrg> getServiceOrgs(int typeId, long zoid) throws Exception {
	List<ServiceOrg> sOrgs = new ArrayList<>();
	Iterator<UserLite> ulItr = Util.ORGAPI.getOrgUserLitesIterator(zoid);
	while(ulItr.hasNext()){
		List<ServiceOrg> sOrgsUnderZuid = Util.serviceOrgAPI.getServiceOrgs(typeId, ulItr.next().getZuid());
		if(sOrgsUnderZuid != null) {
			sOrgs.addAll(sOrgsUnderZuid);
		}
	}
	HashSet<Object> seen=new HashSet<>();
	sOrgs.removeIf(a->!seen.add(a.getZsoid()));  
	return sOrgs.isEmpty() ? null : sOrgs;
}%>

<%!private static List<com.zoho.accounts.AccountsProto.Account.AppAccount> getAppAccounts(User u, OrgType orgType) throws IAMException {
	List<com.zoho.accounts.AccountsProto.Account.AppAccount> appAccounts = null;
	Criteria c = new Criteria(APPACCOUNT.SERVICE_TYPE, orgType.getType());
	if(!u.isOrgAdmin()) {
		c = c.and(new Criteria(ACCOUNTMEMBER.ZID, u.getZuid()).and(ACCOUNTMEMBER.IS_ACTIVE,Comparator.NOT_EQUALS,AccountsConstants.AppAccountMemberStatus.CLOSED));
	}
	com.zoho.accounts.AccountsProto.Account.AppAccount[] appAccountsArr = (com.zoho.accounts.AccountsProto.Account.AppAccount[])RestProtoUtil.GETS(Accounts.getAppAccountURI(u.getZoid()).getQueryString().setCriteria(c).build());
	if(appAccountsArr != null) {
		appAccounts = Arrays.asList(appAccountsArr);
		HashSet<Object> seen=new HashSet<>();
		appAccounts.removeIf(a->!seen.add(a.getZaaid()));
	}
	return appAccounts;
}%>

<%!private static List<User> getUsersUnderPortal(OrgType orgType, User u, long zid) throws Exception {
	List<User> usersUnderPortal = new ArrayList<>();
	List<Long> usersUnderOrg = new ArrayList<>();
	if(u.isOrgUser()) {
		Iterator<UserLite> uItr = Util.ORGAPI.getOrgUserLitesIterator(u.getZOID());
		while(uItr.hasNext()) {
			UserLite user = uItr.next();
			usersUnderOrg.add(user.getZuid());
		}
	} else {
		usersUnderOrg.add(u.getZUID());
	}
	
	if (orgType != null) {
		Long[] zuids = usersUnderOrg.toArray(new Long[usersUnderOrg.size()]);
		if (orgType.isAppAccountType()) {
			usersUnderPortal = CloseAccountInternalUtil.getUsersUnderZaaid(orgType.getType(),String.valueOf(zid), zuids);
		} else if (orgType.isServiceOrg()) {
			usersUnderPortal = CloseAccountInternalUtil.getUsersUnderZsoid(orgType.getType(),String.valueOf(zid), zuids);
		}
	}
	return usersUnderPortal;  
}%>

<%!private static String getResponseFromCache(String requestId, HandlerType handlerType, OrgType orgType, String sName, String zid) throws Exception{
	Iterator<Map.Entry<String, String>> serVsResItr = CloseAccountInternalUtil.getMapIteratorFromCache(handlerType, requestId);
	if(serVsResItr != null) {
		String key = ((orgType != null) ? orgType.getType() : sName) + "_" + zid;
		while(serVsResItr.hasNext()) {
			Map.Entry<String, String> entry = serVsResItr.next();
			if(key.equals(entry.getKey())) {
				String response = entry.getValue();
				try {
					JSONObject json = new JSONObject(response);
				} catch(Exception e) {
					JSONObject json = new JSONObject();
					json.put(CloseAccountUtil.STATUS_CODE, response);
					return json.toString();
				}
				return response;
			}
		}
			
	}
	return null; 
}%>

<%! private static boolean isValidStatusCode(String response) {
	if(!Util.isValid(response)) {
		return true;
	}	
	JSONObject resObj = new JSONObject(response);
	String statusCode = resObj.optString("status_code");	//No I18N
	if(!Util.isValid(statusCode)) {
		return false;
	}
	if(isCloseAccountErrorCode(statusCode)) {
		JSONObject criticalUsers = resObj.optJSONObject("critical_users");	//No I18N
		if(criticalUsers != null) {
			for(String zuid : criticalUsers.keySet()) {
				String userStatusCode = criticalUsers.getJSONObject(zuid).optString("status_code");	//No I18N
				if(!(Util.isValid(userStatusCode) && isCloseAccountErrorCode(userStatusCode))) {
					return false;
				}
			}
		}
		return true;
	}
	return IAMErrorCode.getErrorCode(statusCode) != null;
}	%>

<%! private static boolean isCloseAccountErrorCode(String errorCode) {
	for(CloseAccountUtil.StatusCode code : CloseAccountUtil.StatusCode.values()) {
		if(code.getCode().equals(errorCode)) {
			return true;
		}
	}
	return false;
}	%>

<%! public static String getInvalidErrorCodeMsg() {
	return "<div style='margin-left: 20%; margin-bottom:30px;' class='subtitle'>Custom status code not allowed.<br> Kindly check <a href='https://learn.zoho.com/portal/zohocorp/manual/guide/article/close-account-testing-setup#_Toc5n4zqimadtr3'>here</a> for allowed status codes.</div>";	//No I18N
}	%>

