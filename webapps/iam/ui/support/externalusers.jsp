<%-- $Id$ --%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.OrgTypeDetail"%>
<%@page import="com.zoho.accounts.AccountsConstants.OrgType"%>
<%@ include file="includes.jsp" %>
<div class="maincontent">
    <div class="menucontent">
		<div class="topcontent"><div class="contitle">External Users</div></div><%--No I18N--%>
		<div class="subtitle">Support Services</div><%--No I18N--%>
    </div>
    
    <div class="field-bg">
    	<div id="getZaaidDiv">
    		<form name="getZaaid" class="zform" onsubmit="return getExternalUsers(document.getZaaid);" method="post">
    			<div class="labelkey">Select AppAccount Type</div> <%--No I18N--%>
    			<div class="labelvalue">
    				<select class="select select2Div" name='type'>
    					<option value=''>Select AppAccountType</option> <%--No I18N--%>
    				<% for(OrgTypeDetail orgDetails : OrgTypeDetail.values()) { 
    						if(orgDetails.isExternalUserSupportAdded()) {%>
    					<option value='<%=orgDetails.getServiceOrgType().getType()%>'><%=orgDetails.getServiceOrgType().getServiceName()%></option>
    				<%}}%>
    				</select>
    			</div>
   				<div class="labelkey">Enter the AppAccount Id : </div><%--No I18N--%>
   				<div class="labelvalue"><input type="text" class="input" name="zaaid" placeholder="ZAAID" value='' autocomplete="off"></div>
	   			<div class="accbtn Hbtn">
			    	<div class="savebtn" onclick="getExternalUsers(document.getZaaid)">
						<span class="btnlt"></span>
						<span class="btnco">Fetch Users</span> <%--No I18N--%>
						<span class="btnrt"></span>
		    		</div>
				</div>
   			</form>
    	</div>
   	
   		<div id="externalUsersDiv" style="display:none;">
   		<form name='externalusers' class='zform' onsubmit='return removeAllUsers(this)' method='post'>
   			<div class='labelValue' id='externalList'></div>
   			<div class="accbtn Hbtn">
			  	<div class="savebtn" onclick="removeAllUsers(document.getZaaid)">
					<span class="btnlt"></span>
					<span class="btnco">Clear All</span> <%--No I18N--%>
					<span class="btnrt"></span>
		    	</div>
			</div>
   		</form>
 		</div>
   		<div id="nouser" class="nosuchusr" style="display:none;">
        	<p align="center">No such ZohoOne Org</p> <%--No I18N--%>
		</div>	
    </div>
</div>