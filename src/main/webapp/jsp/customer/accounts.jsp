<%@page import="modules.UserRecord"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="java.io.IOException"%>
<%@page import="consoleRunner.utility.LoggingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="modules.Account"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Map<Long, Account> accounts = (Map<Long, Account>) request.getAttribute("accounts");
UserRecord user = (UserRecord) session.getAttribute("user");

%>

<!DOCTYPE html>
<html>
<head>
<title>Accounts</title>
<%@include file="../../include/head.jsp"%>
</head>

<body>
	<section id="menu">
		<div class="logo">
			<img src="images/logo.png" alt="CSK Bank Logo">
			<h2>CSK Bank</h2>
		</div>

		<div class="items">
			<li
				style="border-left: 5px solid #fff; background: #0d1117; color: white;"><i
				class="material-icons">account_balance</i><a href="#">Account</a></li> <a
				href="app?route=statement_select">
				<li><i class="material-icons">receipt_long</i>Statement</li>
			</a> <a href="app?route=transfer">
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
			<div id="searchInput" class="search">
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
			<h3 class="content-title">Accounts</h3>
			<div id="accountsTable" class="content-table">
				<table width="100%">
					<thead>
						<tr>
							<td>Account Number</td>
							<td>Account Type</td>
							<td>Available Balance</td>
							<td>Opening Date</td>
							<td>Trasaction Date</td>
							<td>Status</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<%
						for (Account account : accounts.values()) {
						%>
						<tr>
							<td><%=account.getAccountNumber()%></td>
							<td><%=account.getAccountType()%></td>
							<td>Rs. <%=account.getBalance()%></td>
							<td><%=ConvertorUtil.convertLongToLocalDate(account.getOpeningDate()).format(DateTimeFormatter.ISO_DATE)%></td>
							<td><%=ConvertorUtil.convertLongToLocalDate(account.getLastTransactedAt()).format(DateTimeFormatter.ISO_DATE)%></td>
							<td><%=account.getStatus()%></td>
							<td><a
								href="app?route=account_details&account_number=<%=account.getAccountNumber()%>"><i
									class="material-icons">keyboard_arrow_right</i></a></td>
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