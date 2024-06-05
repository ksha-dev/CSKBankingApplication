<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../../static/css/styles.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="../../static/script/script.js"></script>

<%String error = (String) request.getSession(false).getAttribute("error");
if (error != null) {
	request.getSession(false).removeAttribute("error");
	out.print("<script>errorMessage('" + error + "');</script>");
}%>

