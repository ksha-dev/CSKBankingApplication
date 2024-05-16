<%@page import="com.cskbank.utility.ConstantsUtil.TransactionType"%>
<%@page import="com.cskbank.modules.Branch"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Account account = (Account) request.getAttribute("account");
Branch branch = (Branch) request.getAttribute("branch");
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<%@include file="../include/head.jsp"%>
</head>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('li-search').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
		document.getElementById('a-search').href = '#';
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
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(account.getOpeningDate())%></h4>
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
						<%=ConvertorUtil.amountToCurrencyFormat(account.getBalance())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Account Status</p>
					<h4 class="profile-element"><%=account.getStatus()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Last Transaction Date</p>
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(account.getLastTransactedAt())%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">IFSC</p>
					<h4 class="profile-element"><%=branch.getIfscCode()%></h4>
				</div>
			</div>

		</div>
	</div>
	<div style="display: flex;">
		<form action="statement">
			<input type="hidden" value="<%=account.getAccountNumber()%>"
				name="accountNumber"> <input type="submit"
				value="View Statement">
		</form>

	</div>

	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>