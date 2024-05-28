<%@page import="com.cskbank.utility.ConstantsUtil.TransactionType"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Transfer</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/transaction.js"></script>
</head>


<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Transfer</h3>
	<form action="authorization" class="container" method="post"
		id="transaction-form" style="width: 50%;">
		<div class="dual-element-row">
			<label>Transaction Type</label> <select name="type"
				id="transactionType" required>
				<option style="display: none" value="null">Select
					Transaction Type</option>
				<option value="<%=TransactionType.CREDIT%>">DEPOSIT</option>
				<option value="<%=TransactionType.DEBIT%>">WITHDRAW</option>
			</select>
		</div>
		<span id="e-transactionType" class="error-text"></span>
		<div class="dual-element-row">
			<label>Account Number</label> <input id="accountNumber" type="number"
				name="accountNumber" placeholder="Enter Account Number" required>
		</div>
		<span id="e-accountNumber" class="error-text"></span>
		<div class="dual-element-row">
			<label for="amount">Transaction Amount</label> <input type="number"
				id="amount" step=".01" name="amount" placeholder="Enter Amount"
				inputmode="numeric" required>
		</div>
		<span id="e-amount" class="error-text"></span> <input type="hidden"
			name="operation" value="authorize_transaction"> <input
			type="submit" value="Proceed" class="dual-element-row">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
	<script>
		const error = document.getElementById("error-message");
		function validateAccountSelection() {
			const type = document.getElementById("type");
			error.textContent = "";
			if (type.value === "null") {
				error.textContent = "Please Select Transaction Type";
				event.preventDefault();
			}
		}
	</script>
</body>

</html>