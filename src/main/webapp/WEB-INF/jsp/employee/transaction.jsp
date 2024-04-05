<%@page import="utility.ConstantsUtil.TransactionType"%>
<%@page import="modules.Transaction"%>
<%@page import="modules.Account"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Transfer</title>
<%@include file="../include/head.jsp"%>
</head>


<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Transfer</h3>
	<form action="authorization" class="container" method="post"
		style="width: 50%;">
		<!-- 
		 <div
			style="display: flex; flex-direction: row; width: 100%; justify-content: space-between;">
			<div style="width: 49%;">
		 -->
		<div class="dual-element-row">
			<label for="type">Transaction Type</label> <select name="type"
				id="type" required>
				<option style="display: none" value="null">Select
					Transaction Type</option>
				<option value="<%=TransactionType.CREDIT%>">DEPOSIT</option>
				<option value="<%=TransactionType.DEBIT%>">WITHDRAW</option>
			</select>
		</div>
		<div class="dual-element-row">
			<label for="accountNumber">Account Number</label> <input
				type="number" name="accountNumber"
				placeholder="Enter Account Number" required>
		</div>
		<!-- 
			</div>
			<div style="width: 49%;">
			 -->
		<div class="dual-element-row">
			<label for="amount">Transaction Amount</label> <input type="number"
				step=".01" name="amount" placeholder="Enter Amount"
				inputmode="numeric" required>
		</div>

		<!-- 
				  <div class="dual-element-row">
					<label for="remarks">Remarks</label> <input type="text"
						placeholder="Enter remarks" name="remarks" id="remarks" required>
				</div>
			</div>
		</div>
				 -->
		<span id="error-message" style="color: red;"></span> <input
			type="hidden" name="operation" value="authorize_transaction">
		<input type="submit" style="margin-left: auto" value="Proceed"
			class="dual-element-row" onclick="validateAccountSelection()">
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