<%-- $Id$ --%>
<%@page import="com.adventnet.iam.ConditionalAccess.ConditionType"%>
<%@page import="com.adventnet.iam.ConditionalPolicy.ClientApp"%>
<%@page import="com.zoho.accounts.AccountsConstants.MFAPreference"%>
<%@page import="com.zoho.accounts.AccountsUtil"%>
<%@page import="com.zoho.accounts.AccountsConstants.SignInPrimaryModes"%>
<%@ include file="includes.jsp" %>
<%
	String type = request.getParameter("type");
    String value = request.getParameter("val");
    value = value != null ? value : "";
%>
<style>
hr{
	color: #d4d4d4;
    background-color: #d4d4d4;
    border: none;
    height: 1px;
}
</style>


<div class="maincontent">
    <div class="menucontent">
	<div class="topcontent"><div class="contitle">BitSet Parser</div></div> <%-- No I18N --%>
	<div class="subtitle">Admin Services</div> <%-- No I18N --%>
    </div>

    <div class="field-bg">
		<div class="labelmain" id="parseBitset">
			<div class="labelkey"> Select the preference : </div> <%-- No I18N --%>
			<div class="labelvalue">
	    		<select id="type" class="select select2Div" style="background-color: white;width: 98px;b;background-position-x: 19px;">
	    			<option value="Signin" <%if("Signin".equals(type)){ %>selected<%} %>>Signin Primary Mode</option> <%--No I18N--%>
	    			<option value="MFA" <%if("MFA".equals(type)){ %>selected<%} %>>MFA Preference</option> <%--No I18N--%>
	    			<option value="Client" <%if("Client".equals(type)){ %>selected<%} %>>Allowed Client (WebClient/MailClient)</option> <%--No I18N--%>
	    			<option value="ConditionType" <%if("ConditionType".equals(type)){ %>selected<%} %>>Condition Type(IPaddress/Platform)</option> <%--No I18N--%>
	    		</select>
	    	</div>
	    	<div class="labelkey"> Enter the bitset value :</div> <%-- No I18N --%>
	    	<div class="labelvalue"><input type="text" id="val" class="input" value="<%= value %>" autocomplete="off" /></div>
		    <div class="accbtn Hbtn">
			<div class="savebtn" onclick="bitsetParser()" style="position:  relative;top: 7px;">
				<span class="btnlt"></span>
				<span class="btnco">parse</span> <%--No I18N--%>
				<span class="btnrt"></span>
			</div>
		    </div>
		</div>
   	<%
   		if (IAMUtil.isValid(value)) {
   			if (type.equals("Signin")) {
	%>
   				<table class="usremailtbl" cellpadding="4">
				<tr>
					<td class="usrinfoheader">SignIn Primary Mode</td> <%--No I18N--%>
				</tr>
	<%
					BitSet bitset = AccountsUtil.toBitSet(value);
					for (SignInPrimaryModes mode : SignInPrimaryModes.values()) {
						if (bitset == null || bitset.get(mode.getPrimaryMode())) {
	%>
						<tr>
							<td class="usremailtd"><%=mode.name()%></td> <%-- NO OUTPUTENCODING --%>
						</tr>
	<%
						}
					}
	%>
				</table>
	<%
   			} else if (type.equals("MFA")) {
   				%>
   				<table class="usremailtbl" cellpadding="4">
				<tr>
					<td class="usrinfoheader">MFA Preference</td> <%--No I18N--%>
				</tr>
	<%
					BitSet bitset = AccountsUtil.toBitSet(value);
					for (MFAPreference mode : MFAPreference.values()) {
						if (bitset == null || bitset.get(mode.dbValue())) {
	%>
						<tr>
							<td class="usremailtd"><%=mode.name()%></td> <%-- NO OUTPUTENCODING --%>
						</tr>
	<%
						}
					}
	%>
				</table>
	<%
   			} else if (type.equals("Client")) {
   				%>
   				<table class="usremailtbl" cellpadding="4">
				<tr>
					<td class="usrinfoheader">Allowed Clients</td> <%--No I18N--%>
				</tr>
	<%
					BitSet bitset = AccountsUtil.toBitSet(value);
					for (ClientApp app : ClientApp.values()) {
						if (bitset == null || bitset.get(app.getValue())) {
	%>
						<tr>
							<td class="usremailtd"><%=app.name()%></td> <%-- NO OUTPUTENCODING --%>
						</tr>
	<%
						}
					}
	%>
			</table>
	<%
   			} else if (type.equals("ConditionType")) {
   				%>
   				<table class="usremailtbl" cellpadding="4">
				<tr>
					<td class="usrinfoheader">Condition Type</td> <%--No I18N--%>
				</tr>
	<%
					int valueInt = IAMUtil.getInt(value);
					BitSet bitset = valueInt == 0 ? null : AccountsUtil.toBitSet(valueInt);
					for (ConditionType ctype : ConditionType.values()) {
						if (bitset == null || bitset.get(ctype.getValue())) {
	%>
						<tr>
							<td class="usremailtd"><%=ctype.name()%></td> <%-- NO OUTPUTENCODING --%>
						</tr>
	<%
						}
					}
	%>
			</table>
	<%
   			}
   		}
   	%>
	</div>
	<div id="overflowdiv" style="float:left;width:100%; "><div id="output_mc" style="display:none;"></div></div>
</div>