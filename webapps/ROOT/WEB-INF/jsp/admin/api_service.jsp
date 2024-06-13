<%@page import="com.cskbank.modules.APIKey"%>
<%@page import="com.cskbank.utility.ConstantsUtil"%>
<%@page import="com.cskbank.modules.Branch"%>
<%@page import="com.cskbank.modules.UserRecord"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="java.util.Map"%>
<%@page import="com.cskbank.modules.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
List<APIKey> apiKeys = (List<APIKey>) request.getAttribute("apiKeys");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");
%>

<!DOCTYPE html>
<html>
<head>
<title>API Keys</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<form action="create_api_key" method=post>
		<div
			style="display: flex; justify-content: space-between; align-items: center; margin-right: 50px;">
			<h3 class="content-title">List of API Keys</h3>
			<div style="margin: auto"></div>
			<input type="text" name="orgName" placeholder="Organisation Name"
				required style="min-width: 200px; margin-right: 20px;"> <input
				type="submit" value="Create Key">
		</div>
	</form>
	<%
	if (apiKeys.isEmpty()) {
	%>
	<div class="container">No API Keys have been generated</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>API Key ID</td>
					<td>Organisation Name</td>
					<td>Created At</td>
					<td>Expires At</td>
					<td>API Key</td>
					<td>Status</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (APIKey apikey : apiKeys) {
				%>
				<tr>
					<td><%=apikey.getAkId()%></td>
					<td><%=apikey.getOrgName()%></td>
					<td><%=ConvertorUtil.formatToDate(apikey.getCreatedAt())%></td>
					<td><%=ConvertorUtil.formatToDate(apikey.getValidUntil())%></td>
					<td id="hiddenKey"><%=apikey.getAPIKey()%></td>
					<td style="color: <%=apikey.getIsActive() ? "green" : "red"%>"><%=apikey.getIsActive() ? "Active" : "Expired"%></td>
					<%
					if (apikey.getIsActive()) {
					%>
					<td>
						<form action="invalidate_api_key" method="post">
							<input type="hidden" name="ak_id" value="<%=apikey.getAkId()%>">
							<input type="submit" value="Invalidate"
								style="padding: auto; background: transparent; color: white;">
						</form>
					</td>
					<%
					}
					%>
				</tr>
				<%
				}

				if (currentPage == pageCount) {
				int remainingCount = ConstantsUtil.LIST_LIMIT - apiKeys.size();
				for (int t = 0; t < remainingCount; t++) {
					out.println("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<form action="<%=pageCount == 1 ? "#" : "api_service"%>"
		class="pagination" method="post">
		<button type="<%=currentPage == 1 ? "reset" : "submit"%>"
			name="currentPage" value="<%=currentPage - 1%>"
			style="margin-right: 20px;">&laquo;</button>
		<%
		for (int i = 1; i <= pageCount; i++) {
		%>
		<button type="<%=currentPage == i ? "reset" : "submit"%>"
			name="currentPage" value="<%=i%>"
			<%if (currentPage == i)
	out.println("class=\"active\"");%>><%=i%></button>
		<%
		}
		%>
		<br>
		<button type="<%=currentPage == pageCount ? "reset" : "submit"%>"
			name="currentPage" value="<%=currentPage + 1%>"
			style="margin-left: 20px;">&raquo;</button>
		<input type="hidden" name="pageCount" value="<%=pageCount%>">
		<%
		}
		%>
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>