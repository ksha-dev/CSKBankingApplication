<%@page import="com.cskbank.filters.Parameters"%>
<%@page import="java.util.Objects"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="java.util.Map"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page
	import="com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Statement</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/statement.js"></script>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Statement</h3>
	<form action="statement" method="post" class="container"
		style="width: 50%;" id="statement-form">
		<%
		String accountNumber = request.getParameter("accountNumber");
		long selectedAccount = 0;
		if (!Objects.isNull(accountNumber)) {
			selectedAccount = Long.parseLong(accountNumber);
		}
		if (user.getType() == UserRecord.Type.CUSTOMER) {
		%>
		<div class="dual-element-row">
			<label>Account</label> <select id="accountNumber"
				name="accountNumber" required>
				<option style="display: none" value="null">Select Account</option>
				<%
				Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
				for (Account account : accounts.values()) {
					out.print("<option value='" + account.getAccountNumber() + "' ");
					if (selectedAccount == account.getAccountNumber()) {
						out.print("selected");
					}
					out.print(">" + account.getAccountType() + " - " + account.getAccountNumber() + "</option>");
				}
				%>
			</select>
		</div>
		<%
		} else {
		%>
		<div class="dual-element-row">
			<label>Account</label> <input type="number"
				placeholder="Enter Account Number" id="accountNumber"
				<%=(selectedAccount > 0 ? "value=\"" + selectedAccount + "\"" : "")%>
				name="accountNumber" required>
		</div>
		<%
		}
		%>
		<span id="e-accountNumber" class="error-text"></span>
		<div class="dual-element-row">
			<label>Duration</label> <select name="transactionLimit"
				onclick="triggerTransactionLimit()" id="transactionLimit" required>
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
		<span id="e-transactionLimit" class="error-text"></span>
		<div style="width: 100%; display: none;" id="customDates">
			<div class="dual-element-row">
				<label>Start Date</label> <input type="date" id="startDate"
					name="startDate" max="2024-04-03">
			</div>
			<span id="e-startDate" class="error-text"></span>

			<div class="dual-element-row">
				<label>End Date</label> <input type="date" id="endDate"
					name="endDate" max="2024-04-03">
			</div>
			<span id="e-endDate" class="error-text"></span>

		</div>
		<span id="error" class="error-text"></span> <input type="hidden"
			name="<%=Parameters.PAGECOUNT.parameterName()%>" value="0"> <input
			type="hidden" name="<%=Parameters.CURRENTPAGE.parameterName()%>"
			value="1"> <input class="dual-element-row" type="submit"
			value="View Statement">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>
<!-- <script>
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
 -->
</html>