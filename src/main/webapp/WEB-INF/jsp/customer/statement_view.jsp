<%@page import="utility.ConstantsUtil"%>
<%@page import="utility.ConstantsUtil.TransactionHistoryLimit"%>
<%@page import="utility.ConstantsUtil.TransactionType"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="java.util.List"%>
<%@page import="modules.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
int pageCount = (int) request.getAttribute("pageCount");
int currentPage = (int) request.getAttribute("currentPage");
long accountNumber = (long) request.getAttribute("accountNumber");
%>

<!DOCTYPE html>
<html>
<head>
<title>Statement</title>
<%@include file="../include/head.jsp"%>
</head>
<body>
	<%@include file="layout_header.jsp"%>
	<button type="button" onclick="location.href='statement'">
		Back</button>
	<br>
	<h3 class="content-title">Statement</h3>
	<div class="content-table">
		<table width="100%">
			<thead>
				<tr>
					<td>TXN ID</td>
					<td>Date</td>
					<td class="pl">Particulars</td>
					<td class="pr">Debit</td>
					<td class="pr">Credit</td>
					<td class="pr">Balance</td>
				</tr>
			</thead>
			<tbody>
				<%for (Transaction transaction : transactions) {%>
				<tr>
					<td><%=transaction.getTransactionId()%></td>
					<td><%=ConvertorUtil.formatToDate(transaction.getTimeStamp())%></td>
					<td class="pl"><%=transaction.getRemarks()%></td>
					<td class="pr"><%=(transaction.getTransactionType() == TransactionType.DEBIT)
		? ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
		: "-"%></td>
					<td class="pr"><%=(transaction.getTransactionType() == TransactionType.CREDIT)
		? ConvertorUtil.amountToCurrencyFormat(transaction.getTransactedAmount())
		: "-"%></td>
					<td class="pr"><%=ConvertorUtil.amountToCurrencyFormat(transaction.getClosingBalance())%></td>
				</tr>
				<%}%>


				<%
				if (currentPage == pageCount) {
					int remainingCount = ConstantsUtil.LIST_LIMIT - transactions.size();
					for (int t = 0; t < remainingCount; t++) {
						out.println("<tr><td>&nbsp;</td></tr>");
					}
				}
				%>
			</tbody>
		</table>
	</div>

	<form action="<%=pageCount == 1 ? "#" : "statement"%>"
		class="pagination" method="post">
		<%
		TransactionHistoryLimit limit = (TransactionHistoryLimit) request.getAttribute("limit");
		if (currentPage != 1) {
		%>
		<button type="submit" name="currentPage" value="<%=currentPage - 1%>"
			style="margin-right: 20px;">&laquo;</button>
		<%
		}
		%>
		<%
		for (int i = 1; i <= pageCount; i++) {
		%>
		<button type="submit" name="currentPage" value="<%=i%>"
			<%if (currentPage == i)
	out.println("class=\"active\"");%>><%=i%></button>
		<%
		}
		%>
		<%
		if (currentPage != pageCount) {
		%>
		<br>
		<button type="submit" name="currentPage" value="<%=currentPage + 1%>"
			style="margin-left: 20px;">&raquo;</button>
		<%}%>
		<input type="hidden" name="pageCount" value="<%=pageCount%>">
		<input type="hidden" name="account_number" value="<%=accountNumber%>">
		<input type="hidden" name="transaction_limit" value="<%=limit%>">
	</form>

	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>