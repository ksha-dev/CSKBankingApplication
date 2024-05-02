<%@page import="com.cskbank.filters.Parameters"%>
<%@page import="java.util.Objects"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="java.util.Map"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Statement</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Statement</h3>
	<form action="statement" method="post" class="container"
		style="width: 50%;" id="statement_form">
		<%
		String accountNumber = request.getParameter("accountNumber");
		long selectedAccount = 0;
		if (!Objects.isNull(accountNumber)) {
			selectedAccount = Long.parseLong(accountNumber);
		}
		if (user.getType() == UserType.CUSTOMER) {
		%>
		<div class="dual-element-row">
			<label for="account_number">Account</label> <select
				id="account_number" name="accountNumber" required>
				<option style="display: none" value="null">Select Account</option>
				<%
				Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
				for (Account account : accounts.values()) {
				%>
				<option value="<%=account.getAccountNumber()%>"
					<%=(selectedAccount == account.getAccountNumber()) ? "selected" : ""%>>
					<%=account.getAccountNumber()%> -
					<%=account.getAccountType()%>
				</option>
				<%
				}
				%>
			</select>
		</div>
		<%
		} else {
		%>
		<div class="dual-element-row">
			<label for="account_number">Account</label> <input type="number"
				placeholder="Enter Account Number" id="account_number"
				<%=(selectedAccount > 0 ? "value=\"" + selectedAccount + "\"" : "")%>
				name="accountNumber" required>
		</div>
		<%
		}
		%>
		<div class="dual-element-row">
			<label for="transaction_limit">Duration</label> <select
				name="transactionLimit" id="transaction_limit" required>
				<option style="display: none" value="null">Statement
					Duration</option>
				<option value="<%=TransactionHistoryLimit.RECENT%>">Last 10
					Transactions</option>
				<option value="<%=TransactionHistoryLimit.ONE_MONTH%>">1
					Month</option>
				<option value="<%=TransactionHistoryLimit.THREE_MONTH%>">3
					Months</option>
				<option value="<%=TransactionHistoryLimit.SIX_MONTH%>">6
					Months</option>
				<option value="custom">Custom</option>
			</select>
		</div>
		<div style="width: 100%; display: none;" id="custom-dates">
			<div class="dual-element-row">
				<label for="startDate">Start Date</label> <input type="date"
					id="startDate" name="startDate" max="2024-04-03">
			</div>
			<div class="dual-element-row">
				<label for="endDate">End Date</label> <input type="date"
					id="endDate" name="endDate" max="2024-04-03">
			</div>
		</div>
		<span id="error" style="color: red;"></span> <input type="hidden"
			name="<%=Parameters.PAGECOUNT.parameterName()%>" value="0"> <input
			type="hidden" name="<%=Parameters.CURRENTPAGE.parameterName()%>"
			value="1"> <input class="dual-element-row" type="submit"
			onclick="validateStatementSelection()" value="View Statement">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>
<script>
	const customSelect = document.getElementById('custom-dates');
	const transactionLimit = document.getElementById('transaction_limit')
	const startDate = document.getElementById('startDate');
	const endDate = document.getElementById('endDate');
	var currentDate = new Date();

	var currentDateString = currentDate.toISOString().split('T')[0];

	startDate.max = currentDateString;
	endDate.max = currentDateString;

	transactionLimit.addEventListener('click', function() {
		if (this.value === "custom") {
			customSelect.style.display = 'block';
		} else {
			customSelect.style.display = 'none';
		}
	});
	function validateStatementSelection() {
		const error = document.getElementById('error');
		error.textContent = "";
		if (document.getElementById('account_number').value === "null") {
			error.textContent = "Please select an account";
			event.preventDefault();
		} else if (transactionLimit.value === "null") {
			error.textContent = "Please select a duration";
			event.preventDefault();
		} else if (transactionLimit.value === "custom") {
			if (startDate.value === '' || endDate.value === '') {
				error.textContent = 'Please select a valid range';
				event.preventDefault();
			} else {
				const startDateObject = new Date(startDate.value);
				const endDateObject = new Date(endDate.value);
				if (startDateObject >= endDateObject) {
					error.textContent = 'Start date cannot be greater than or equal to the end date';
					event.preventDefault();
				} else if (endDateObject > currentDate) {
					error.textContent = 'End date cannot be greater than current date';
					event.preventDefault();
				}
			}
		}
	}
</script>

</html>