<%-- $Id$ --%>
<%@ include file="includes.jsp"%>

<div class="maincontent">
	<div class="menucontent">
		<div class="topcontent">
			<div class="contitle">Client Scopes</div><%--No I18N--%>
		</div>
		<div class="subtitle">Admin Services</div><%--No I18N--%>	
	</div>

	<div class="field-bg">
		<div class="labelmain">
			<div class="labelkey">Enter Client ID : </div><%--No I18N--%>
			<div class="labelvalue">
				<input type="text" id="client_id" name="client_id" required class="input" style="width: 280px"/>
			</div>

			<div class="accbtn Hbtn" onclick="getClientScopes();">
				<div class="savebtn">
					<span class="btnlt"></span> 
					<span class="btnco">Get Scopes</span><%--No I18N--%>
					<span class="btnrt"></span>
				</div>
			</div>
			<input type="submit" class="hidesubmit" />
		</div>
		<div class="labelkey">Default Scopes : </div><%--No I18N--%>
		<textarea id="clientscopes_resp" readonly cols="35" name="clientscopes_resp"></textarea>
	</div>
</div>
