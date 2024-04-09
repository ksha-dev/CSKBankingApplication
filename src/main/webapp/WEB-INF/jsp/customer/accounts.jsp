<%@page import="modules.UserRecord"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="java.io.IOException"%>
<%@page import="consoleRunner.utility.LoggingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="modules.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
%>

<!DOCTYPE html>
<html>
<head>
<title>Accounts</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Accounts</h3>
	<%
	if (accounts.isEmpty()) {
	%>
	<div class="container">You do not have any accounts currently</div>
	<%
	} else {
	%>
	<div id="accountsTable" class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>Account Number</td>
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
					<td><%=account.getAccountType()%></td>
					<td>Rs. <%=account.getBalance()%></td>
					<td><%=ConvertorUtil.convertLongToLocalDate(account.getOpeningDate()).format(DateTimeFormatter.ISO_DATE)%></td>
					<td><%=ConvertorUtil.convertLongToLocalDate(account.getLastTransactedAt()).format(DateTimeFormatter.ISO_DATE)%></td>
					<td><%=account.getStatus()%></td>
					<td><a
						href="account_details?accountNumber=<%=account.getAccountNumber()%>"><i
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
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>