<%@page import="modules.EmployeeRecord"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<%
	EmployeeRecord customer = (EmployeeRecord) user;
	%>
	<script>
		document.getElementById('profile').href = "#";
	</script>
	<div
		style="display: flex; justify-content: space-between; padding-right: 50px;">
		<h3 class="content-title">Employee Profile</h3>
	</div>
	<div style="display: flex; width: 100%;">

		<div style="width: inherit;">
			<div class="container">
				<h3 class="profile-element">Employee Details</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Customer ID</p>
					<h4 class="profile-element"><%=customer.getUserId()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Customer Name</p>
					<h4 class="profile-element"><%=customer.getFirstName()%>
						<%=customer.getLastName()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Date of Birth</p>
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(customer.getDateOfBirth())%></h4>
				</div>
			</div>

			<div class="container">
				<h3 class="profile-element">Role Information</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Role</p>
					<h4 class="profile-element"><%=customer.getType()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Branch ID</p>
					<h4 class="profile-element"><%=customer.getBranchId()%></h4>
				</div>
			</div>
		</div>

		<div style="width: inherit;">
			<div class="container">
				<h3 class="profile-element">Contact Information</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<h4 class="profile-element"><%=customer.getAddress()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Mobile</p>
					<h4 class="profile-element"><%=customer.getPhone()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Email ID</p>
					<h4 class="profile-element"><%=customer.getEmail()%></h4>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>