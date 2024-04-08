<%@page import="modules.Branch"%>
<%@page import="modules.EmployeeRecord"%>
<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Branch branch = (Branch) request.getAttribute("branch");
%>
<!DOCTYPE html>
<html>
<head>
<title>Branch Details</title>
<%@include file="../include/head.jsp"%>
</head>

<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		if (fileName !== "search") {
			document.getElementById('li-branches').style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
			document.getElementById('a-branches').href = '#';
		}
	</script>
	<button style="z-index: 0;" type="button" onclick="history.back()">
		<i style="padding-right: 10px;" class="material-icons">arrow_back</i>Back
	</button>

	<div class="container">
		<h3 class="profile-element">Branch Details</h3>

		<div class="divider"></div>

		<div
			style="display: flex; justify-content: space-between; width: 100%;">

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Branch ID</p>
					<h4 class="profile-element"><%=branch.getBranchId()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Branch IFSC</p>
					<h4 class="profile-element"><%=branch.getIfscCode()%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Address</p>
					<h4 class="profile-element"><%=branch.getAddress()%></h4>
				</div>
			</div>

			<div style="width: 100%;">
				<div class="dual-element-row">
					<p class="profile-element">Phone</p>
					<h4 class="profile-element"><%=branch.getPhone()%></h4>
				</div>
				<div class="dual-element-row">
					<p class="profile-element">Account Status</p>
					<h4 class="profile-element"><%=branch.getEmail()%></h4>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>