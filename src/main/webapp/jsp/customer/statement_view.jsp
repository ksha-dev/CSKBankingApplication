<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="java.util.List"%>
<%@page import="modules.Transaction"%>
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
			<div class="profile">
				<a href="app?route=customer_profile"> <img
					src="images/profile.jpg" alt="Profile">
				</a>
			</div>
		</div>
		<div class="content-board">
			<button type="button" onclick="history.back()">
				<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
			</button>
			<br>
			<h3 class="content-title">Statement</h3>
			<div class="content-table">
				<table width="100%">
					<thead>
						<tr>
							<td>S. No</td>
							<td>TXN ID</td>
							<td>Date</td>
							<td>Title</td>
							<td>TXN Amount</td>
							<td>Closing Balance</td>
							<td>TXN Type</td>
							<td></td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<%
						List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
						int i = 1;
						for (Transaction transaction : transactions) {
						%>
						<tr>
							<td><%=i++%></td>
							<td><%=transaction.getTransactionId()%></td>
							<td><%=ConvertorUtil.convertLongToLocalDate(transaction.getTimeStamp()).format(DateTimeFormatter.ISO_DATE)%></td>
							<td><%=transaction.getRemarks()%></td>
							<td><%=transaction.getTransactedAmount()%></td>
							<td><%=transaction.getClosingBalance()%></td>
							<td><%=transaction.getTransactionType()%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

	</section>


</body>

</html>