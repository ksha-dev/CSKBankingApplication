<%@page import="modules.Transaction"%>
<%@page import="modules.Account"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Transfer</title>
<%@include file="../../include/head.jsp"%>
</head>


<body>
	<section id="menu">
		<div class="logo">
			<img src="images/logo.png" alt="CSK Bank Logo">
			<h2>CSK Bank</h2>
		</div>

		<div class="items">

			<a href="app?route=account">
				<li><i class="material-icons">account_balance</i>Account</li>
			</a><a href="app?route=statement_select">
				<li><i class="material-icons">receipt_long</i>Statement</li>
			</a>
			<li
				style="border-left: 5px solid #fff; background: #0d1117; color: white;"><i
				class="material-icons">payments</i><a href="#">Transfer</a></li> <a
				href="app?route=change_password">
				<li><i class="material-icons">lock_reset</i>Change Password</li>
			</a> <a href="#" onclick="logout()">
				<li><i class="material-icons">logout</i>Logout</li>
			</a>
		</div>
	</section>


	<section id="content-area">
		<div class="nav-bar">
			<!-- 
		 	<div class="search">
				<i class="material-icons">search</i> <input type="text"
					placeholder="Search">
			</div>
		 -->

			<div class="profile">
				<a href="app?route=customer_profile"> <img
					src="images/profile.jpg" alt="Profile">
				</a>
			</div>
		</div>


		<div class="content-board">
			<h3 class="content-title">Transfer</h3>
			<form action="app" id="transferForm" class="container"
				style="width: 50%;" method="post">
				<div class="dual-element-row">
					<label for="transferWithinBank">Transfer Within Bank</label>
					<div style="justify-content: start; width: 45%;">
						<input id="transferWithinBank" type="checkbox"
							name="transferWithinBank">
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
				<span id="error-message" style="color: red;"></span>
				<div class="dual-element-row">
					<label for="to-account">Receipent Account Number</label> <input
						id="to-account" type="number" name="to-account"
						placeholder="Enter Account Number" required>
				</div>

				<!-- <div class="dual-element-row">
									<label for="ifsc">Receipent IFSC Code</label> <input type="text" id="ifcs"
										name="ifsc" placeholder="Enter IFSC Code" required>
								</div> -->

				<div class="dual-element-row">
					<label for="amount">Amount to Transfer</label> <input type="number"
						id="amount" name="amount" placeholder="Enter Amount"
						inputmode="numeric" required>
				</div>

				<div class="dual-element-row">
					<label for="remarks">Remarks</label> <input type="text"
						placeholder="Enter remarks" name="remarks" id="remarks" required>
				</div>
				<input type="hidden" name="route" value="authorization_request">
				<input type="submit" value="Submit" class="dual-element-row"
					onclick="validateAccountSelection()">
			</form>
		</div>

	</section>

	<script>
		function validateAccountSelection() {
			const fromAccount = document.getElementById("from-account");

			console.log(fromAccount.value);

			if (fromAccount.value === "null") {
				document.getElementById("error-message").textContent = "Please Select any one of the accounts";
				event.preventDefault();
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