<%@page import="com.cskbank.utility.ConvertorUtil"%>
<%@page import="com.cskbank.modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile</title>
<%@include file="../include/head.jsp"%>
</head>

<%
CustomerRecord customer = (CustomerRecord) request.getSession().getAttribute("user");
%>
<body>
	<%@include file="../include/layout_header.jsp"%>
	<script>
		document.getElementById('profile').href = "#";
	</script>
	<div
		style="display: flex; justify-content: space-between; padding-right: 50px;">
		<h3 class="content-title">User Info</h3>
		<form action="profile_edit">
			<button class="button-85" style="padding: 5px;" type="submit">
				<i class="material-icons">edit</i>
			</button>
		</form>
	</div>
	<div style="display: flex; width: 100%;">

		<div style="width: inherit;">
			<div class="container">
				<h3 class="profile-element">Customer Details</h3>
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
					<h4 class="profile-element"><%=ConvertorUtil.hiddenDate(customer.getDateOfBirth())%></h4>
				</div>
			</div>

			<div class="container">
				<h3 class="profile-element">KYC Information</h3>
				<div class="divider"></div>
				<div class="dual-element-row">
					<p class="profile-element">Aadhar</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenAadhar(customer.getAadhaarNumber())%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">PAN</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenPAN(customer.getPanNumber())%></h4>
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
					<h4 class="profile-element"><%=ConvertorUtil.hiddenPhone(customer.getPhone())%></h4>
				</div>

				<div class="dual-element-row">
					<p class="profile-element">Email ID</p>
					<h4 class="profile-element"><%=ConvertorUtil.hiddenEmail(customer.getEmail())%></h4>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../include/layout_footer.jsp"%>
</body>

</html>