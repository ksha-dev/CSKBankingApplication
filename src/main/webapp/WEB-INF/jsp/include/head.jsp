
<%@page import="java.util.Objects"%>
<%
String error = (String) request.getSession(false).getAttribute("error");
%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="../../static/css/styles.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script src="../../static/script/script.js"></script>

<script>
	
<%if (!Objects.isNull(error)) {
	request.getSession(false).removeAttribute("error");%>
	setTimeout(function() {
		alert("<%=error%>
	");
	}, 100);
<%
}
%>
	function logout() {
		var confirmation = confirm("Press OK to confirm logout.\nPress Cancel or escape to cancel");
		if (confirmation) {
			location.href = "logout";
		}
	}
</script>



<!-- <a href="app?route=account">
	<li><i class="material-icons">account_balance</i>Account</li>
</a><a href="app?route=statement_select">
	<li><i class="material-icons">receipt_long</i>Statement</li>
</a> <a href="app?route=transfer">
	<li><i class="material-icons">payments</i>Transfer</li>
</a> <a href="app?route=change_password">
	<li><i class="material-icons">lock_reset</i>Change Password</li>
</a> <a href="#" onclick="logout()">
	<li><i class="material-icons">logout</i>Logout</li>
</a> -->