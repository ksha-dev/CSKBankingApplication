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
			</a>
			<li
				style="border-left: 5px solid #fff; background: #0d1117; color: white;"><i
				class="material-icons">receipt_long</i><a href="#">Statement</a></li> <a
				href="app?route=transfer">
				<li><i class="material-icons">payments</i>Transfer</li>
			</a> <a href="app?route=change_password">
				<li><i class="material-icons">lock_reset</i>Change Password</li>
			</a> <a href="#" onclick="logout()">
				<li><i class="material-icons">logout</i>Logout</li>
			</a>

		</div>
	</section>


	<section id="content-area">
		<div class="nav-bar">
			<div class="search">
				<i class="material-icons">search</i> <input type="text"
					placeholder="Search">
			</div>

			<div class="profile">
				<a href="profile.html"> <img src="images/profile.jpg"
					alt="Profile">
				</a>
			</div>
		</div>


		<div class="content-board">
			<h3 class="content-title">Statement</h3>
			<form action="app" method="post" class="container"
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
				<!-- 
			 	<div id="duration-field" style="display: block;">
			 -->
				<div class="dual-element-row" id="transaction_limit"
					style="display: none;">
					<label for="transaction_limit">Duration</label> <select
						name="transaction_limit" required>
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
				<!-- 
				 </div>
				 -->
				<input type="hidden" name="route" value="statement_view"> <input
					id="submit_button" class="dual-element-row" type="submit"
					value="View Statement" style="display: none;">
			</form>
		</div>
	</section>
	<script type="text/javascript">
		const account = document.getElementById('account_number');
		const duration = document.getElementById('transaction_limit');
		const submitButton = document.getElementById('submit_button');
		account.addEventListener('change', function() {
			duration.style.display = 'flex';
			duration.addEventListener('change', function() {
				submitButton.style.display = 'block';
			});
		});
	</script>
</body>

</html>