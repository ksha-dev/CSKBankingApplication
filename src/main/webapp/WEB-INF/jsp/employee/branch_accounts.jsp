<%@page import="modules.Branch"%>
<%@page import="modules.UserRecord"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="java.util.Map"%>
<%@page import="modules.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
UserRecord user = (UserRecord) session.getAttribute("user");
Branch branch = (Branch) request.getAttribute("branch");
%>

<!DOCTYPE html>
<html>
<head>
<title>Accounts</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="layout_header.jsp"%>
	<h3 class="content-title">
		Accounts in
		<%=branch.getAddress()%>
		Branch
	</h3>
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
					<td>Trasaction Date</td>
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
					<td>Rs. <%=account.getBalance()%></td>
					<td><%=ConvertorUtil.formatToDate(account.getOpeningDate())%></td>
					<td><%=ConvertorUtil.formatToDate(account.getLastTransactedAt())%></td>
					<td><%=account.getStatus()%></td>
					<td><a
						href="account_details?account_number=<%=account.getAccountNumber()%>"><i
							class="material-icons">keyboard_arrow_right</i></a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<%
	}
	%>
	</div>
	</section>
</body>

</html>