<%-- $Id$ --%>
<%@page import="com.zoho.accounts.AccountsConstants.OrgType"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@ include file="includes.jsp" %>
<div class="maincontent">
    <div class="menucontent">
		<div class="topcontent"><div class="contitle" id='appacctitle'>Change AppAccount / ServiceOrg Owner</div></div> <%--No I18N--%>
		<div class="subtitle">Support Services</div> <%--No I18N--%>
	</div>
    <div class="field-bg">
    
        <div id="owner">
            <form name="owner" class="zform" onsubmit="return updateOwner(document.owner);" method="post">
    			<div class="labelkey">Select the Service</div> <%--No I18N--%>
    			<div class="labelvalue">
                    <select class='select select2Div' name='subtype' onchange='getRoles(document.owner)'>
    					<option value=''>Select The Service</option> <%--No I18N--%>
    					<% for(OrgType type : OrgType.values()) {
    						if(type == OrgType.BCOrgType || type == OrgType.DEFAULT) {
    							continue;
    						}
    					%>
    						<option value='<%=type.getType() %>'><%=type.getServiceName() %></option>
    					<% } %>
    				</select>
    			</div>
                <div class="labelkey">Enter the ZID </div> <%--No I18N--%>
                <div class="labelvalue"><input type='text' name='zid' class='input' placeholder='ZAAID / ZSOID' value='' autocomplete="off"></div>
    			<div class="labelkey">Select the Role For Current Owner</div> <%--No I18N--%>
    			<div class="labelvalue">
    				<select class="select select2Div" name='role'>
    				</select>
    			</div>    			
                <div class="labelkey">Enter New Owner ZUID</div> <%--No I18N--%>
                <div class="labelvalue"><input type='text' name='zuid' class='input' placeholder='ZUID' value='' autocomplete="off"></div>
    			<div class="accbtn Hbtn">
                    <div class="savebtn" onclick="updateOwner(document.owner)">
						<span class="btnlt"></span>
						<span class="btnco">Update Owner</span> <%--No I18N--%>
						<span class="btnrt"></span>
		    		</div>
				</div>
    		</form>
    	</div>
    </div>
</div>