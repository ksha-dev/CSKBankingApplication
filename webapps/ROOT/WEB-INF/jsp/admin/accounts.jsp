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
	<div
		style="display: flex; justify-content: space-between; align-items: center; margin-right: 40px;">
		<h3 class="content-title">Accounts in Bank</h3>
		<button type="submit" onclick="location.href='open_account'">Open
			Account</button>
	</div>
	<%
	if (accounts.isEmpty()) {
	%>
	<div class="container">Customers are yet to open accounts</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Account Number</td>
					<td>Customer ID</td>
					<td>Branch ID</td>
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
					<td><%=account.getBranchId()%></td>
					<td><%=account.getAccountType()%></td>
					<td class="pr"><%=ConvertorUtil.amountToCurrencyFormat(account.getBalance())%></td>
					<td><%=ConvertorUtil.formatToDate(account.getOpeningDate())%></td>
					<td><%=account.getLastTransactedAt() == 0 ? "-" : ConvertorUtil.formatToDate(account.getLastTransactedAt())%></td>
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
					out.println("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
				}
				}
				%>
			</tbody>
		</table>
	</div>

	<form action="<%=pageCount == 1 ? "#" : "accounts"%>"
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