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
	<form action="authorization" id="transferForm" class="container"
		style="width: 50%;" method="post">
		<div class="dual-element-row">
			<label for="transferWithinBank">Transfer Within Bank</label>
			<div style="justify-content: start; width: 45%;">
				<input id="transferWithinBank" type="checkbox"
					name="transferWithinBank" onclick="ifscDisplay();">
			</div>
		</div>
		<div class="dual-element-row">
			<label for="from-account">Select Account</label> <select
				name="from-account" id="from-account" required>
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
			<label for="to-account">Receipent Account Number</label> <input
				id="to-account" type="number" name="to-account"
				placeholder="Enter Account Number" required>
		</div>



		<div class="dual-element-row" id="ifsc">
			<label for="ifsc">Receipent IFSC Code</label> <input type="text"
				id="ifscCode" name="ifsc" placeholder="Enter IFSC Code">
		</div>

		<div class="dual-element-row">
			<label for="amount">Amount to Transfer</label> <input type="number"
				step=".01" id="amount" name="amount" placeholder="Enter Amount"
				inputmode="numeric" required>
		</div>

		<div class="dual-element-row">
			<label for="remarks">Remarks</label> <input type="text"
				placeholder="Enter remarks" name="remarks" id="remarks" required>
		</div>
		<span id="error-message" style="color: red;"></span> <input
			type="hidden" name="operation" value="authorize_transaction">
		<input type="submit" value="Submit" class="dual-element-row"
			onclick="validateAccountSelection()">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
	<script>
		function validateAccountSelection() {
			const fromAccount = document.getElementById("from-account");
			const transferWithinBank = document
					.getElementById("transferWithinBank");
			const ifscField = document.getElementById("ifscCode");
			const error = document.getElementById("error-message");
			error.textContent = "";
			if (fromAccount.value === "null") {
				error.textContent = "Please Select any one of the accounts";
				event.preventDefault();
			}

			if (!transferWithinBank.checked) {
				if (ifscField.value === "") {
					error.textContent = "Please Enter IFSC Code";
					event.preventDefault();
				}
			}
		}

		function ifscDisplay() {
			const transferWithinBank = document
					.getElementById("transferWithinBank");
			const ifscField = document.getElementById("ifsc");
			ifscField.style.display = 'none';

			if (!transferWithinBank.checked) {
				ifscField.style.display = 'flex';
			}
		}
		// document
		// 	.getElementById("transferForm")
		// 	.addEventListener(
		// 		"submit",
		// 		function (event) {
		// 			event.preventDefault();
		// 			const fromAccount = document
		// 				.getElementById("from-account");

		// 			console.log(fromAccount);
		// 			if (fromAccount.value === "null") {
		// 				document.getElementById("error-message").textContent = "Please Select any one of the accounts";
		// 				event.preventDefault();
		// 			} else {
		// 				var confirmation = confirm("Confirmation of Transfer\nOn confirmation, do not press back before the transaction completes");
		// 				if (confirmation) {
		// 					this.submit();
		// 				}
		// 			}
		// 		});
	</script>
</body>

</html>