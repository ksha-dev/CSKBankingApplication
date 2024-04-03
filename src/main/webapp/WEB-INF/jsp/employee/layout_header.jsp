
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%
String path = request.getServletPath();
String currentMenu = path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
%>


<section id="menu">
	<div class="logo">
		<img src="../../static/images/logo.png" alt="CSK Bank Logo">
		<h2>CSK Bank</h2>
	</div>

	<div class="items">
		<a id="a-branch_accounts" href="branch_accounts">
			<li id='li-branch_accounts'><i class="material-icons">account_balance</i>Branch
				Accounts</li>
		</a> <a id="a-open_account" href="open_account">
			<li id="li-open_account"><i class="material-icons">library_add</i>Open
				Account</li>
		</a><a id="a-statement" href="statement">
			<li id="li-statement"><i class="material-icons">receipt_long</i>Statement</li>
		</a> <a href="transfer">
			<li><i class="material-icons">payments</i>Transfer</li>
		</a><a href="deposit">
			<li><i class="material-icons">add_card</i>Deposit</li>
		</a> </a><a href="withdraw">
			<li><i class="material-icons">currency_rupee</i>Withdraw</li>
		</a> </a> <a href="schange_password">
			<li><i class="material-icons">lock_reset</i>Change Password</li>
		</a> <a href="#" onclick="logout()">
			<li><i class="material-icons">logout</i>Logout</li>
		</a>
	</div>
</section>

<script>
	const url = window.location.pathname;
	const fileName = url.substring(url.lastIndexOf('/') + 1);
	console.log(fileName);
	document.getElementById('li-' + fileName).style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
	document.getElementById('a-' + fileName).href = '#';
</script>

<section id="content-area">
	<div class="nav-bar">
		<div></div>
		<div class="profile">
			<a id='profile' href="profile"> <img
				src="../../static/images/profile.jpg" alt="Profile">
			</a>
		</div>
	</div>


	<div class="content-board">