<%-- $Id$ --%>
<%@page import="com.zoho.accounts.AccountsConstants.OrgType"%>
<%@ include file="includes.jsp" %>
<div class="maincontent">
    <div class="menucontent">
		<div class="topcontent"><div class="contitle">Close AppAccount / ServiceOrg</div></div><%--No I18N--%>
		<div class="subtitle">Support Services</div><%--No I18N--%>
    </div>
    
    <div class="field-bg">
    
    	<div id="getUser">
             <form class="zform" name="zid" onsubmit="return getServiceDetails(document.zid)">
    			<div class="labelkey">Enter ZID : </div>  <%--No I18N--%>
    			<div class="labelvalue"><input class="input" value="" name="zid" autocomplete="off"></div>
                <div class="labelkey">Select the Service Type : </div><%--No I18N--%>
    			<div class="labelvalue">
    				<select class="select" name="servicetype">
    					<option value='' >Select A Service</option><%--No I18N--%>
                        <% for(OrgType type : OrgType.values()) {
                            if(type == OrgType.BCOrgType || type == OrgType.DEFAULT) {
                              continue;
    						}
    					%>
                        <option value='<%=IAMEncoder.encodeHTML(Integer.toString(type.getType())) %>' ><%= IAMEncoder.encodeHTML(type.getServiceName()) %></option>
                        <% } %>
    				</select>
    			</div>
    			<div class="accbtn Hbtn">
					<div class="savebtn" onclick="getServiceDetails(document.zid)">
						<span class="btnlt"></span> 
						<span class="btnco">Fetch</span><%--No I18N--%>
						<span class="btnrt"></span>
					</div>
				</div>
    		</form>
    		
    	</div>
		
		
		<div id="servicedetails" style="display:none">
		
		</div>
		
    
    </div>
</div>
