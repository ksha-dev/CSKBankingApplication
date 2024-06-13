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
<script src="../../static/script/transfer.js"></script>
</head>


<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Transfer</h3>
	<form action="authorization" id="transfer-form" class="container"
		style="width: 50%;" method="post">

		<div class="dual-element-row">
			<label>Select Account</label> <select name="fromAccount"
				id="fromAccount" required>
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
		<span id="e-fromAccount" class="error-text"></span>
		<div class="dual-element-row">
			<label>Receipent Account Number</label> <input id="toAccount"
				type="number" name="toAccount" placeholder="Enter Account Number"
				required>
		</div>
		<span id="e-toAccount" class="error-text"></span>
		<div class="dual-element-row">
			<label>Amount to Transfer</label> <input type="number" step=".01"
				id="amount" name="amount" placeholder="Enter Amount"
				inputmode="numeric" required>
		</div>
		<span id="e-amount" class="error-text"></span>
		<div class="dual-element-row">
			<label>Remarks</label> <input type="text" placeholder="Enter remarks"
				name="remarks" id="remarks" required>
		</div>
		<span id="e-remarks" class="error-text"></span><input type="hidden"
			name="operation" value="authorize_transaction"> <input
			id="transferWithinBank" type=hidden value="on"
			name="transferWithinBank"><input type="submit" value="Submit"
			class="dual-element-row">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>