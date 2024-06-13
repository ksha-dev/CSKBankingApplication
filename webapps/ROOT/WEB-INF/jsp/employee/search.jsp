<%@page import="com.cskbank.modules.Transaction"%>
<%@page import="com.cskbank.modules.Account"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Search</title>
<%@include file="../include/head.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../../static/script/validator.js"></script>
<script src="../../static/script/search.js"></script>
</head>


<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Search</h3>
	<form action="search" id="search-form" class="container"
		style="width: 50%;" method="post">
		<div class="dual-element-row">
			<label>Search By</label><select name="searchBy" id="searchBy"
				required>
				<option style="display: none" value=null>Select Search By</option>
				<option value="accountNumber">Account Number</option>
				<option value="customerId">Customer ID</option>
				<%
				if (user.getType() == UserRecord.Type.ADMIN) {
				%>
				<option value="employeeId">Employee ID</option>
				<option value="branchId">Branch ID</option>
				<%
				}
				%>
			</select>
		</div>
		<span id="e-searchBy" class="error-text"></span>
		<div class="dual-element-row">
			<label>Search Value</label> <input id="searchValue" type="number"
				name="searchValue" placeholder="Enter Search Value" required>
		</div>
		<span id="e-searchValue" class="error-text"></span> <input
			type="submit" value="Search" class="dual-element-row">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>