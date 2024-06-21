<%--$Id$ --%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<html>
<body>
	<div class='maincontent'>
		<div class='menucontent'>
			<div class='topcontent'>
				<div class='contitle' id='restoretitle'>Zoho Test Accounts</div> <%--No I18N--%>
			</div>
			<div class='subtitle'>Admin Services</div> <%--No I18N--%>
		</div>
		<div class='restorelink' id='view'>
			<a href='javascript:;' id='downloadlink' onclick='displayTestAccountSpace("downloadselect");loadSche();' class='disablerslink'>Download</a>&nbsp/&nbsp<%--No I18N--%>
			<a href='javascript:;' id='closeuserlink' onclick='displayTestAccountSpace("closeuserselect");loadSche();' class='activerslink'>Close Users</a>&nbsp/&nbsp<%--No I18N--%>
			<a href='javascript:;' id='corplink' onclick='displayTestAccountSpace("corpselect");loadSche();' class='activerslink'>Zoho Corp</a>&nbsp/&nbsp<%--No I18N--%>
			<a href='javascript:;' id='deactivatelink' onclick='displayTestAccountSpace("deactivateselect");loadSche();' class='activerslink'>Deactivate Accounts</a><%--No I18N--%>
		</div>

		<div id='corp' style="display: none">
			<form method="post" class="zform" action="<%=request.getContextPath()%>/admin/testaccount/check" target="uploadaction" enctype="multipart/form-data" id="testAccountCheck" name="testAccountCheck">
				<input type="hidden" name="<%=SecurityUtil.getCSRFParamName(request)%>" value="<%=SecurityUtil.getCSRFCookie(request)%>"/> <%-- NO OUTPUTENCODING --%>
				<input type="submit" class="hidesubmit" />
				<div class="labelmain" style="overflow: hidden">
					<div class="labelkey" style="padding-top: 12px">Corp Email Test Account check - File:</div><%--No I18N--%>
					<div class="labelvalue">
						<input name="accountfile" type="file" id="accountfile" class="input">
						 <div class="labelvalue">Note: Supported file format (*.txt)</div> <%--No I18N--%>
					</div> 
					<div id='labelvalue'>
						<div class="accbtn Hbtn">
							<div class="savebtn" onclick="checkTestAccounts(document.testAccountCheck)">
								<span class="btnlt"></span> 
								<span class="btnco">Submit</span><%--No I18N--%>
								<span class="btnrt"></span>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div id='corpResp' style="margin-left:5%"></div>
		</div>
		
		<div id='deactivate' style="display: none">
			<form method="post" class="zform" id="deactivateTestAccount" name="deactivateTestAccount">
				<input type="hidden" name="<%=SecurityUtil.getCSRFParamName(request)%>" value="<%=SecurityUtil.getCSRFCookie(request)%>"/> <%-- NO OUTPUTENCODING --%>
				<div class="labelmain" style="overflow: hidden">
					<div class="labelkey" style="padding-top: 12px">Deactivate Test Account - File:</div><%--No I18N--%>
					<div class="labelvalue">
						<input name="accountfile" type="file" id="accountfile" class="input">
						 <div class="labelvalue">Note: Supported file format (*.txt)</div> <%--No I18N--%>
					</div> 
					<div id='labelvalue'>
						<div class="accbtn Hbtn">
							<div class="savebtn" onclick="deactiveTestAccounts(document.deactivateTestAccount)">
								<span class="btnlt"></span> 
								<span class="btnco">Submit</span><%--No I18N--%>
								<span class="btnrt"></span>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div id='deactivateResp' style="margin-left:5%"></div>
		</div>
		
		<div id='download' >
			<form name="downloadAccounts" class="zform" action="<%=request.getContextPath()%>/admin/testaccount/download" target="uploadaction" onsubmit="return false;" method="post">
			<div class='labelkey'>Download :</div><%--No I18N--%>
				<div id='labelvalue'>
					<div class="accbtn Hbtn">
						<div class="savebtn" onclick="downloadTestAccounts()">
							<span class="btnlt"></span> <span class="btnco">Download</span><%--No I18N--%>
							<span class="btnrt"></span>
						</div>
					</div>
				</div>
			<input type="hidden" name="<%=SecurityUtil.getCSRFParamName(request)%>" value="<%=SecurityUtil.getCSRFCookie(request)%>"/> <%-- NO OUTPUTENCODING --%>
			</form>
			
			<form name="countAccounts" class="zform" action="<%=request.getContextPath()%>/admin/testaccount/count" target="uploadaction" onsubmit="return false;" method="post">
			<div class='labelkey'>Count :</div><%--No I18N--%>
			<div id='labelvalue'>
				<div class="accbtn Hbtn">
					<div class="savebtn" onclick="countTestAccounts()">
						<span class="btnlt"></span> <span class="btnco">Count</span><%--No I18N--%>
						<span class="btnrt"></span>
					</div>
				</div>
			</div>
			<input type="hidden" name="<%=SecurityUtil.getCSRFParamName(request)%>" value="<%=SecurityUtil.getCSRFCookie(request)%>"/> <%-- NO OUTPUTENCODING --%>
			</form>
			<div id='downloadOut' style="margin-left:5%"></div>
		</div>
		
		<div id='closeuser' style="display: none">	
			<form method="post" class="zform" id="deleteAccounts" name="deleteAccounts">
				<input type="hidden" name="<%=SecurityUtil.getCSRFParamName(request)%>" value="<%=SecurityUtil.getCSRFCookie(request)%>"/> <%-- NO OUTPUTENCODING --%>
				<div class="labelmain" style="overflow: hidden">
					<div class="labelkey" style="padding-top: 12px">Close test Account - File :</div><%--No I18N--%>
					<div class="labelvalue">
						<input name="accountfile" type="file" id="accountfile" class="input">
						 <div class="labelvalue">Note: Supported file format (*.txt)</div> <%--No I18N--%>
					</div> 
					<div id='labelvalue'>
						<div class="accbtn Hbtn">
							<div class="savebtn" onclick="closeTestAccounts(document.deleteAccounts)">
								<span class="btnlt"></span> 
								<span class="btnco">Submit</span><%--No I18N--%>
								<span class="btnrt"></span>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div id='closeResp' style="margin-left:5%"></div>
		</div>
	</div>
	<iframe name="uploadaction" id="uploadaction" class="hide" frameborder="0" height="0%" width="0%"></iframe>
</body>
</html>