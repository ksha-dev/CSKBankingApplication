<%@page import="utility.ConvertorUtil"%>
<%@page import="modules.CustomerRecord"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile</title>
<%@include file="../../include/head.jsp"%>
</head>

<%
CustomerRecord customer = (CustomerRecord) request.getSession().getAttribute("user");
%>
<body>
	<section id="menu">
		<div class="logo">
			<img src="images/logo.png" alt="CSK Bank Logo">
			<h2>CSK Bank</h2>
		</div>

		<div class="items">
			<a href="app?route=account">
				<li><i class="material-icons">account_balance</i>Account</li>
			</a><a href="app?route=statement_select">
				<li><i class="material-icons">receipt_long</i>Statement</li>
			</a> <a href="app?route=transfer">
				<li><i class="material-icons">payments</i>Transfer</li>
			</a> <a href="app?route=change_password">
				<li><i class="material-icons">lock_reset</i>Change Password</li>
			</a> <a href="#" onclick="logout()">
				<li><i class="material-icons">logout</i>Logout</li>
			</a>
		</div>
	</section>


	<section id="content-area">
		<div class="nav-bar">
			<div class="profile">
				<a href="#"> <img src="images/profile.jpg" alt="Profile">
				</a>
			</div>
		</div>

		<div class="content-board">
			<div
				style="display: flex; justify-content: space-between; padding-right: 50px;">
				<h3 class="content-title">User Info</h3>
				<form action="app">
					<input type="hidden" name="route" value="customer_profile_edit">
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
		</div>
	</section>


</body>

</html>