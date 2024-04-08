<%@page import="modules.Transaction"%>
<%@page import="modules.Account"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Search</title>
<%@include file="../include/head.jsp"%>
</head>


<body>
	<%@include file="../include/layout_header.jsp"%>
	<h3 class="content-title">Search</h3>
	<form action="search" id="transferForm" class="container"
		style="width: 50%;" method="post">
		<div class="dual-element-row">
			<label for="search_by">Search By</label><select name="search_by"
				id="search_by" required>
				<option style="display: none" value="null">Select Search By</option>
				<option value="accountNumber">Account Number</option>
				<option value="userId">Customer ID</option>
				<%
				if (user.getType() == UserType.ADMIN) {
				%>
				<option value="employeeId">Employee ID</option>
				<option value="branchId">Branch ID</option>
				<%
				}
				%>
			</select>
		</div>
		<div class="dual-element-row">
			<label for="id">Search Value</label> <input id="id" type="number"
				name="id" placeholder="Enter Search Value" required>
		</div>
		<span id="error-message" style="color: red;"></span> <input
			type="submit" value="Search" class="dual-element-row"
			onclick="validateSearchBy()">
	</form>
	<%@include file="../include/layout_footer.jsp"%>
	<script>
		function validateSearchBy() {
			const searchBy = document.getElementById("search_by");
			const error = document.getElementById("error-message");
			error.textContent = "";
			if (searchBy.value === "null") {
				error.textContent = "Please choose any one of the search by field";
				event.preventDefault();
			}
		}
	</script>
</body>

</html>