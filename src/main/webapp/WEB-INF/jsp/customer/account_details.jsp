<%@page import="modules.Branch"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.Account"%>
<%@page import="modules.Transaction"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Account account = (Account) request.getAttribute("account");
Branch branch = (Branch) request.getAttribute("branch");
List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<%@include file="../include/head.jsp"%>
</head>
<body style="width: 100%;">
	<%@include file="layout_header.jsp"%>
	<script>
		document.getElementById('li-account').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-account').href = '#';
	</script>
	<button style="z-index: 0;" type="button" onclick="history.back()">
		<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
	</button>
	<div class="container">
		<h3 class="profile-element">Account Details</h3>
		<div class="divider"></div>
		<div
			style="display: flex; justify-content: space-between; width: 100%;">
			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Account Number</p>
					<h4 class="profile-element"><%=account.getAccountNumber()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Account Type</p>
					<h4 class="profile-element"><%=account.getAccountType()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Opening Date</p>
					<h4 class="profile-element"><%=ConvertorUtil.convertLongToLocalDate(account.getOpeningDate()).format(DateTimeFormatter.ISO_DATE)%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Branch</p>
					<h4 class="profile-element"><%=branch.getAddress()%></h4>
				</div>
			</div>

			<div style="width: 100%;">

				<div class="dual-element-row">
					<p class="profile-element">Available Balance</p>
					<h4 class="profile-element">
						Rs.
						<%=account.getBalance()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Account Status</p>
					<h4 class="profile-element"><%=account.getStatus()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Last Transaction Date</p>
					<h4 class="profile-element"><%=ConvertorUtil.convertLongToLocalDate(account.getLastTransactedAt()).format(DateTimeFormatter.ISO_DATE)%></h4>
				</div>



				<div class="dual-element-row">
					<p class="profile-element">IFSC</p>
					<h4 class="profile-element"><%=branch.getIfscCode()%></h4>
				</div>
			</div>
		</div>
	</div>

	<h3 class="content-title" style="padding-top: 30px;">Recent
		Transactions</h3>

	<div class="content-table">
		<table width="100%">
			<thead>
				<tr>
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
				for (Transaction transaction : transactions) {
				%>
				<tr>
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
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>