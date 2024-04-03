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
<%@include file="../include/head.jsp"%>
</head>
<body>
	<%@include file="layout_header.jsp"%>
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
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>