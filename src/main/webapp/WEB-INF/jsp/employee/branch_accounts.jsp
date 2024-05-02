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
Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
Branch branch = (Branch) request.getAttribute("branch");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");
%>

<!DOCTYPE html>
<html>
<head>
<title>Accounts</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<div style="display: flex; justify-content: space-between;">
		<h3 class="content-title">
			Accounts in
			<%=branch.getAddress()%>
			Branch
		</h3>
		<form action="account_details">
			<input type="number" name="account_number"
				placeholder="Search account number" style="margin-right: 50px"
				required="required">
		</form>
	</div>
	<%
	if (accounts.isEmpty()) {
	%>
	<div class="container">Customers are yet to open accounts in this
		branch</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Account Number</td>
					<td>Customer ID</td>
					<td>Account Type</td>
					<td>Available Balance</td>
					<td>Opening Date</td>
					<td>Last TXN Date</td>
					<td>Status</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<%
				for (Account account : accounts.values()) {
				%>
				<tr>
					<td><%=account.getAccountNumber()%></td>
					<td><%=account.getUserId()%></td>
					<td><%=account.getAccountType()%></td>
					<td class="pr"><%=ConvertorUtil.amountToCurrencyFormat(account.getBalance())%></td>
					<td><%=ConvertorUtil.formatToDate(account.getOpeningDate())%></td>
					<td><%=ConvertorUtil.formatToDate(account.getLastTransactedAt())%></td>
					<td><%=account.getStatus()%></td>
					<td><a
						href="account_details?accountNumber=<%=account.getAccountNumber()%>"><i
							class="material-icons">keyboard_arrow_right</i></a></td>

				</tr>
				<%
				}

				if (currentPage == pageCount) {
				int remainingCount = ConstantsUtil.LIST_LIMIT - accounts.size();
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

	<form action="<%=pageCount == 1 ? "#" : "branch_accounts"%>"
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