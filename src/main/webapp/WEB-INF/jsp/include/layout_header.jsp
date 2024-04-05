
<%@page import="utility.ConstantsUtil.UserType"%>
<%@page import="modules.UserRecord"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%
String path = request.getServletPath();
String currentMenu = path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
UserRecord user = (UserRecord) session.getAttribute("user");
%>


<section id="menu">
	<div class="logo">
		<img src="../../static/images/logo.png" alt="CSK Bank Logo">
		<h2>CSK Bank</h2>
	</div>

	<div class="items">
		<%
		switch (user.getType()) {
			case CUSTOMER : {
		%>
		<a id="a-account" href="account">
			<li id='li-account'><i class="material-icons">account_balance</i>Account</li>
		</a> <a id="a-statement" href="statement">
			<li id="li-statement"><i class="material-icons">receipt_long</i>Statement</li>
		</a> <a id="a-transfer" href="transfer">
			<li id="li-transfer"><i class="material-icons">payments</i>Transfer</li>
		</a>
		<%
		}
		break;
		case ADMIN : {
		%>
		<!-- <a id="a-branch_accounts" href="branch_accounts">
			<li id='li-branch_accounts'><i class="material-icons">account_balance</i>Branch
				Accounts</li>
		</a> -->
		<%
		}
				case EMPLOYEE: {
		%>
		<a id="a-branch_accounts" href="branch_accounts">
			<li id='li-branch_accounts'><i class="material-icons">account_balance</i>Branch
				Accounts</li>
		</a> <a id="a-open_account" href="open_account">
			<li id="li-open_account"><i class="material-icons">library_add</i>Open
				Account</li>
		</a><a id="a-statement" href="statement">
			<li id="li-statement"><i class="material-icons">receipt_long</i>Statement</li>
		</a> <a id="a-transaction" href="transaction">
			<li id="li-transaction"><i class="material-icons">payments</i>Transaction</li>
		</a>
		<%
		}
		break;
		}
		%>
		<a id="a-change_password" href="change_password">
			<li id="li-change_password"><i class="material-icons">lock_reset</i>Change
				Password</li>
		</a> <a href="#" onclick="logout()">
			<li><i class="material-icons">logout</i>Logout</li>
		</a>
	</div>
</section>

<script>
	const url = window.location.pathname;
	const fileName = url.substring(url.lastIndexOf('/') + 1);
	document.getElementById('li-' + fileName).style = "border-left: 5px solid #fff; background: #0d1117; color: white;";
	document.getElementById('a-' + fileName).href = '#';
</script>

<section id="content-area">
	<div class="nav-bar">
		<div></div>
		<div class="profile">
			<div
				style="align-items: end; display: flex; flex-direction: column; padding-right: 15px;">
				<h3><%=user.getFirstName()%>
				</h3>
				<p style="font-size: 14px;">
					User ID :
					<%=user.getUserId()%>
				</p>
			</div>
			<a id='profile' href="profile"> <img
				src="../../static/images/profile.jpg" alt="Profile">
			</a>
		</div>
	</div>


	<div class="content-board">