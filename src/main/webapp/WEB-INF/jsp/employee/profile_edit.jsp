<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Profile</title>
<%@include file="../include/head.jsp"%>
</head>
<%
CustomerRecord customer = (CustomerRecord) request.getSession().getAttribute("user");
%>
<body>
	<%@include file="layout_header.jsp"%>
	<form action="authorization" method="post">
		<div
			style="display: flex; justify-content: space-between; padding-right: 50px;">
			<h3 class="content-title">Update Profile Details</h3>
			<div style="display: flex;">
				<button class="button-85" type="button"
					onclick="location.href = 'profile'">Cancel</button>
				<div style="width: 20px;"></div>
				<button class="button-85" type="submit">Update</button>
			</div>
		</div>
		<div style="display: flex; width: 100%;">

			<div style="width: inherit;">
				<div class="container">
					<h3 class="profile-element">Customer Details</h3>
					<div class="divider"></div>
					<div class="dual-element-row-read-only">
						<p class="profile-element">Customer ID</p>
						<h4 class="profile-element"><%=customer.getUserId()%></h4>
					</div>

					<div class="dual-element-row-read-only">
						<p class="profile-element">Customer Name</p>
						<h4 class="profile-element"><%=customer.getFirstName()%>
							<%=customer.getLastName()%></h4>
					</div>

					<div class="dual-element-row-read-only">
						<p class="profile-element">Date of Birth</p>
						<h4 class="profile-element"><%=ConvertorUtil.hiddenDate(customer.getDateOfBirth())%></h4>
					</div>
				</div>

				<div class="container">
					<h3 class="profile-element">KYC Information</h3>
					<div class="divider"></div>
					<div class="dual-element-row-read-only">
						<p class="profile-element">Aadhar</p>
						<h4 class="profile-element"><%=ConvertorUtil.hiddenAadhar(customer.getAadhaarNumber())%></h4>
					</div>

					<div class="dual-element-row-read-only">
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
						<input type="hidden" name="old_address"
							value="<%=customer.getAddress()%>"> <input type="text"
							name="new_address" value="<%=customer.getAddress()%>">
					</div>

					<div class="dual-element-row-read-only">
						<p class="profile-element">Mobile</p>
						<h4 class="profile-element"><%=ConvertorUtil.hiddenPhone(customer.getPhone())%></h4>
					</div>

					<div class="dual-element-row">
						<p class="profile-element">Email ID</p>
						<input type="hidden" name="old_email"
							value="<%=ConvertorUtil.hiddenEmail(customer.getEmail())%>">
						<input type="email" name="new_email"
							value="<%=ConvertorUtil.hiddenEmail(customer.getEmail())%>">
						<input type="hidden" name="operation"
							value="authorize_profile_update">
					</div>
				</div>
			</div>
		</div>
	</form>
	<%@include file="../include/layout_footer.jsp"%>
</body>
</html>