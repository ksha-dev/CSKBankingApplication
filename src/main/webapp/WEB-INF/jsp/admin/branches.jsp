<%@page import="com.cskbank.utility.ConstantsUtil"%>
<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.modules.EmployeeRecord"%>
<%@page import="com.cskbank.modules.Branch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Map<Integer, Branch> branches = (Map) request.getAttribute("branches");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");
%>

<!DOCTYPE html>
<html>
<head>
<title>Branches</title>
<%@include file="../include/head.jsp"%>
</head>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<div
		style="display: flex; justify-content: space-between; align-items: center">
		<h3 class="content-title">List of Branches</h3>
		<a href="add_branch" style="color: white; padding-left: 10px"> <i
			class="material-icons">add_circle</i>
		</a>
		<div style="margin: auto"></div>
	</div>

	<%
	if (branches.isEmpty()) {
	%>
	<div class="container">No branch has been opened yet</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Branch ID</td>
					<td>Branch Address</td>
					<td>Phone</td>
					<td>Email</td>
					<td>IFSC</td>
					<td>Accounts Count</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (Branch branch : branches.values()) {
				%>
				<tr>
					<td><%=branch.getBranchId()%></td>
					<td><%=branch.getAddress()%></td>
					<td><%=branch.getPhone()%>
					<td><%=branch.getEmail()%></td>
					<td><%=branch.getIfscCode()%></td>
					<td><%=branch.getAccountsCount()%></td>
					<td><a
						href="branch_accounts?branchId=<%=branch.getBranchId()%>"><i
							class="material-icons">keyboard_arrow_right</i></a></td>
				</tr>
				<%
				}

				if (currentPage == pageCount) {
				int remainingCount = ConstantsUtil.LIST_LIMIT - branches.size();
				for (int t = 0; t < remainingCount; t++) {
					//out.println(
					//"<tr><td>-</td><td>-</td><td>-</td><td class=\"pr\">-</td><td class=\"pr\">-</td><td>-</td><td>-</td></tr>");
					out.println("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<form action="<%=pageCount == 1 ? "#" : "branches"%>"
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
</body>
</html>