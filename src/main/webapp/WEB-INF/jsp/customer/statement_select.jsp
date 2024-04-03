<%@page import="modules.Account"%>
<%@page import="java.util.Map"%>
<%@page import="modules.Transaction"%>
<%@page import="utility.ConstantsUtil.TransactionHistoryLimit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Statement</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("pragma", "no-cache");
	response.setHeader("Expires", "0");
	%>
	<%@include file="layout_header.jsp"%>
	<h3 class="content-title">Statement</h3>
	<form action="statement" method="post" class="container"
		style="width: 50%;" id="statement_form">

		<div class="dual-element-row">
			<label for="account_number">Account</label> <select
				id="account_number" name="account_number" required>
				<option style="display: none" value="null">Select Account</option>
				<%
				Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
				for (Account account : accounts.values()) {
				%>
				<option value="<%=account.getAccountNumber()%>">
					<%=account.getAccountNumber()%> -
					<%=account.getAccountType()%>
				</option>
				<%
				}
				%>
			</select>
		</div>
		<div class="dual-element-row">
			<label for="transaction_limit">Duration</label> <select
				name="transaction_limit" id="transaction_limit" required>
				<option style="display: none" value="null">Statement
					Duration</option>
				<option value="<%=TransactionHistoryLimit.ONE_MONTH%>">1
					Month</option>
				<option value="<%=TransactionHistoryLimit.THREE_MONTH%>">3
					Months</option>
				<option value="<%=TransactionHistoryLimit.SIX_MONTH%>">6
					Months</option>
			</select>
		</div>
		<span id="error" style="color: red;"></span> <input type="hidden"
			name="route" value="statement_view"> <input
			class="dual-element-row" type="submit"
			onclick="validateStatementSelection()" value="View Statement">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>
<script>
	function validateStatementSelection() {
		const error = document.getElementById('error');
		if (document.getElementById('account_number').value === "null") {
			error.textContent = "Please select an account";
			event.preventDefault();
		} else if (document.getElementById('transaction_limit').value === "null") {
			error.textContent = "Please select a duration";
			event.preventDefault();
		}
	}
</script>
</html>