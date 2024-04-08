<%@page import="modules.EmployeeRecord"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
EmployeeRecord employee = (EmployeeRecord) request.getAttribute("employee");
%>
<!DOCTYPE html>
<html>
<head>
<title>Employee Details</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		if (fileName !== "search") {
			document.getElementById('li-employees').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
			document.getElementById('a-employees').href = '#';
		}
	</script>
	<button style="z-index: 0;" type="button" onclick="history.back()">
		<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
	</button>

	<div style="display: flex; width: 100%;">

		<div style="width: inherit;">
			<div class="container">
				<h3 class="profile-element">Employee Details</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Employee ID</p>
					<h4 class="profile-element"><%=employee.getUserId()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Employee Name</p>
					<h4 class="profile-element"><%=employee.getFirstName()%>
						<%=employee.getLastName()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Date of Birth</p>
					<h4 class="profile-element"><%=ConvertorUtil.formatToDate(employee.getDateOfBirth())%></h4>
				</div>
			</div>

			<div class="container">
				<h3 class="profile-element">Role Information</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Role</p>
					<h4 class="profile-element"><%=employee.getType()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Branch ID</p>
					<h4 class="profile-element"><%=employee.getBranchId()%></h4>
				</div>
			</div>
		</div>

		<div style="width: inherit;">
			<div class="container">
				<h3 class="profile-element">Contact Information</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<h4 class="profile-element"><%=employee.getAddress()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Mobile</p>
					<h4 class="profile-element"><%=employee.getPhone()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Email ID</p>
					<h4 class="profile-element"><%=employee.getEmail()%></h4>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>