<%-- $Id: $ --%>
<!DOCTYPE html> <%-- No I18N --%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<html lang="en">
<head>
<meta charset="utf-8">
		<title><%=com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD")%> </title>

<% 
String jsurl = request.getContextPath() + "/static"; //No I18N
String imgurl = request.getContextPath();
String resetpassurl = new StringBuilder(Util.getServerUrl(request)).append(Util.AccountsUIURLs.RECOVERY_PAGE.getURI()).toString();
Boolean showFp = AccountsConfiguration.getConfigurationTyped("token.inactive.page.show.fp", false);//No I18N
Boolean isDarkMode = Boolean.parseBoolean(request.getParameter("darkmode"));
String mdmToken = request.getParameter("token");
%>
<script src="<%=IAMEncoder.encodeHTMLAttribute(jsurl)%>/jquery-3.6.0.min.js" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" type="text/css" rel="stylesheet" /><%-- NO OUTPUTENCODING --%>
<style>
	body 
	{
		margin: 0;
	}
	.signin_container {
		width: 100%;
		box-shadow: none;
		margin: 0 auto;
		position: relative;
		z-index: 1;
		margin-top: 100px;
		overflow: hidden;
	}
	.signin_box {
		width: 100%;
		max-width: 420px;
		padding: 0px 20px;
		min-height: 360px;
		height: auto;
		background: #fff;
		box-sizing: border-box;
		border-radius: 2px;
		transition: all .1s ease-in-out;
		float: left;
		overflow-y: auto;
	}
	.zoho_logo {
		display: block;
		height: 40px;
		width: auto;
		margin-bottom: 24px;
		background: url(/accounts/images/newoauth/newZoho_logo.svg) no-repeat transparent;
		background-size: auto 100%;
	}
	.signin_head {
		margin-bottom: 16px;
		display: block;
		font-size: 20px;
		font-weight: 500;
		transition: all .1s ease-in-out;
	}
	.service_name {
		display: block;
		font-size: 14px;
		opacity: 0.6;
		font-weight: 300;
		margin-top: 10px;
		line-height: 20px;
	}
	.hellouser {
		margin-bottom: 30px;
	}
	.userNameDiv{
	    width: max-content;
	    font-size: 14px;
	    display: grid;
	    line-height: 16px;;
	    grid-template-columns: 16px auto;
	    gap: 8px;
	    border: 1px solid #eaeaea;
	    border-radius: 4px;
	    padding: 13px 16px;
	    box-sizing: border-box;
	    max-width: 85%;
		word-wrap: anywhere;
		margin: 32px 0px;
	}
	.userIcon{
		fill: #7e7e7e;
	}
	.userName{opacity: 0.9}

	.bluetext {
		color: #309FF4;
		cursor: pointer;
	}
	.forgetPassword{
		width: 100%;
		text-align: center;
	}
	.forgetPassword span{
		cursor: pointer;
		font-size: 14px;
		color: #1389E3;
	}
	.textbox_div {
		display: block;
		margin-bottom: 30px;
		position: relative;
	}
	.textbox {
		background-color: #fff;
		border: none;
		border-bottom: 2px solid #EFEFEF;
		text-indent: 0px;
		border-radius: 0;
		display: block;
		width: 100%;
		height: 48px;
		box-sizing: border-box;
		font-size: 16px;
		outline: none;
		padding-right: 12px;
		transition: all .2s ease-in-out;
	}
	.show_hide_password {
		height: 11px;
		width: 16px;
		display: block;
		position: absolute;
		float: right;
		cursor: pointer;
		background-size: 100%;
		top: 15px;
		right: 16px;
	}
	#password::placeholder{opacity: 0.4; font-weight: 300}
	.show_hide_password .showIcon, .show_hide_password.hidetext .hideIcon{display: none;}
	.show_hide_password .hideIcon, .show_hide_password.hidetext .showIcon{display: block;}
	.btn {
		margin-top: 10px;
		border-radius: 4px;
		cursor: pointer;
		display: block;
		width: 100%;
		height: 48px;
		font-size: 14px;
		outline: none;
		border: none;
		margin: auto;
		margin-bottom: 44px;
		transition: all .2s ease-in-out;
		font-weight: 500;
	}
	.blue {
		box-shadow: 0px 2px 2px #fff;
		background-color: #007BD9;
		color: #fff;
	}
	.fielderror
	{
		display: none;
		color: #ff5151;
		margin-top: 10px;
		font-size: 14px;
	}
	@media only screen and (min-width: 420px) {
		.signin_container{
			width: max-content;
		}
	}
	.darkmode, .darkmode .signin_box,.darkmode .textbox{
		background-color: #121212;
		color: #fff;
	}
	.darkmode #password{border-bottom: 2px solid #5a5a5a}
	.darkmode .btn{box-shadow: none}
	.darkmode .userNameDiv{border-color: #5a5a5a; background-color: #272727}
	.darkmode .zoho_logo{background: url(/accounts/images/newoauth/newZoho_logo_dark.svg) no-repeat transparent;}
	.darkmode .forgetPassword span{color: #4EA6EA}
	.darkmode .userIcon{fill: #fff}
	
</style>
</head>
<body <%if(isDarkMode) {%> class="darkmode" <%} %> >
	<div class="signin_container">
		<div class="signin_box" id="signin_flow">
			<div class="zoho_logo"></div>
			<div id="signin_div">				
				<div class="signin_head">
					<span><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD")%></span>
					<div class="service_name"><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.VERIFY.PASSWORD.CHANGE.REVERIFY")%></div>
				</div>
				<div class="userNameDiv">
					<svg class="userIcon" width="16" height="16" viewBox="0 0 16 16"><path id="Combined-Shape" d="M14,5a8,8,0,1,1-8,8A8,8,0,0,1,14,5Zm-.055,11.586a4.986,4.986,0,0,0-2.664.587,3.194,3.194,0,0,0-.983.98,6.347,6.347,0,0,0,7.331.053,3.254,3.254,0,0,0-1-1.017A4.953,4.953,0,0,0,13.945,16.586ZM14,6.655A6.345,6.345,0,0,0,9.082,17.009c1.046-1.413,2.517-2.078,4.863-2.078,2.378,0,3.865.689,4.915,2.148A6.345,6.345,0,0,0,14,6.655ZM13.945,8.31a3.034,3.034,0,0,1,3.034,3.034h0V11.9A2.483,2.483,0,0,1,14.5,14.379h-1.1A2.483,2.483,0,0,1,10.91,11.9h0v-.552A3.034,3.034,0,0,1,13.945,8.31Zm0,1.655a1.379,1.379,0,0,0-1.379,1.379h0V11.9a.828.828,0,0,0,.828.828h1.1a.828.828,0,0,0,.828-.828h0v-.552A1.379,1.379,0,0,0,13.945,9.966Z" transform="translate(-6 -5)"/></svg><%-- No i18N --%>
					<div class="userName"><%=IAMEncoder.encodeHTML(String.valueOf(request.getAttribute("EMAIL")))%></div>
				</div>
				<div class="textbox_div">
					<input id="password" placeholder="Password" type="password" class="textbox" required="" autofocus>
					<span class="show_hide_password">
						<span class="showIcon"><svg style="fill: #7f7f7f" width="16" height="10.484" viewBox="0 0 16 10.484"><path id="Show" d="M51.173,80c2.573,0,5.091,1.411,7.553,4.17h0l.072.081a1.5,1.5,0,0,1,0,1.983c-2.484,2.812-5.026,4.25-7.625,4.25-2.573,0-5.091-1.411-7.553-4.17h0l-.072-.081a1.5,1.5,0,0,1,0-1.983C46.033,81.439,48.574,80,51.173,80Zm0,1.5c-2.111,0-4.278,1.226-6.5,3.744h0l.068.077c2.179,2.442,4.3,3.643,6.371,3.667h.063c2.111,0,4.278-1.226,6.5-3.744h0l-.068-.077c-2.179-2.442-4.3-3.643-6.371-3.667h-.063Zm0,.749a3,3,0,1,1-3,3A3,3,0,0,1,51.173,82.247Zm0,1.5a1.5,1.5,0,1,0,1.5,1.5A1.5,1.5,0,0,0,51.173,83.744Z" transform="translate(-43.173 -80)"/></svg></span><%-- No i18N --%>
						<span class="hideIcon"><svg style="fill: #7f7f7f" width="16" height="12.14" viewBox="0 0 726.379 550.986"><path id="Hide" d="M295.8,245.839l.685.666,63.189,63.184a388.581,388.581,0,0,1,54.081-21.436A330.5,330.5,0,0,1,512,273.067c116.69,0,230.9,63.664,342.585,188.178h0l3.26,3.653a68.267,68.267,0,0,1-2.879,93.706c-47.489,47.282-78.959,77.725-95.123,91.96h0l-3.795,3.3q-15.929,13.707-28.908,23.3L779.2,729.224a34.133,34.133,0,0,1-47.587,48.938l-.685-.666-64.309-64.3Q590.019,750.785,512,750.934c-116.783,0-231.081-63.765-342.85-188.475h0l-3.262-3.659a68.267,68.267,0,0,1,2.472-93.257c56.022-56.772,99.231-96.538,130.7-119.918l-50.847-50.848A34.133,34.133,0,0,1,295.8,245.839ZM347.985,394.55c-25.979,17.627-68.093,55.493-124.943,112.787h0l-6.091,6.156,3.092,3.468c98.872,110.318,195.21,164.616,289.112,165.691h0l2.845.016q51.114,0,103.011-21.083l-32.585-32.592A136.565,136.565,0,0,1,395.008,441.575ZM512,341.333a262.3,262.3,0,0,0-78.04,12.127q-11.241,3.483-22.536,7.977l32.3,32.3A136.569,136.569,0,0,1,630.26,580.278l47.889,47.9c8.375-5.53,19.109-13.853,32-24.885h0l3.693-3.185c11.866-10.345,35.708-33.2,71.074-68.163h0L806.8,510.224l-3.09-3.462C703.924,395.515,606.722,341.331,512,341.331Zm-65.583,151.65a68.322,68.322,0,0,0,84.6,84.6ZM512,443.733a68.379,68.379,0,0,0-16.322,1.964L578.3,528.323a68.326,68.326,0,0,0-66.3-84.59Z" transform="translate(-148.688 -236.508)"/></svg></span><%-- No i18N --%>
					</span>
					<div class="fielderror"><%I18NUtil.getMessage("IAM.CONFIRMATION.ERROR.PASSWORD.INVALID"); %></div> <%-- No I18N --%>
				</div>
				<button class="btn blue" id="nextbtn"><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.CONFIRM")%></button>
				<%if(showFp) {%>
					<div class="forgetPassword"><span onclick="gotoForgetPassword()"><%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.FORGOT.PASSWORD")%></span></div>
				<%} %>
			</div>
		</div>
	</div>
</body>
<script>
	var resetpassurl = "<%=resetpassurl%>";
	$(".show_hide_password").click(function() {
    	var passType = $("#password").attr("type");//no i18n
    	if(passType==="password")
		{
   			$("#password").attr("type","text");//no i18n		
   			$(".show_hide_password").addClass("hidetext");
    	}
		else
		{
   			$("#password").attr("type","password");//no i18n
   			$(".show_hide_password").removeClass("hidetext");
    	}
    });
	
	$("#nextbtn").unbind("click").click(function(){
	    var password = $("#password").val();
	    if(isEmpty(password)){
	    	$(".fielderror").text("<%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.ERROR.ENTER.LOGINPASS")%>");
	    	$(".fielderror").slideDown(200);
	    	return;
	    }
        $("#nextbtn").prop("disabled", true); <%-- No I18N --%>
		var xhttp = new XMLHttpRequest();
	   	var params = "pass="+encodeURIComponent(password) + "&" + getcsrfParams(); <%-- No I18N --%>
	   	<% if (Util.isValid(mdmToken)) {%>
	   		params = params + "&token=" + "<%= mdmToken %>"; // NO OUTPUTENCODING <%-- No I18N --%>
	   	<%} %>
	    xhttp.open("POST", "/oauth/v2/mobile/inactive/token/activate", true);
	    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhttp.send(params);
	    xhttp.onreadystatechange = function () {
	    	if(this.readyState == 4 && this.status == 200) {
	    		var response = this.responseText;
	    		response = JSON.parse(response);
	    		if(response.status == "success") {
	    			window.location=response.url;
	    			return;
	    		} else {
	    			$("#nextbtn").prop("disabled", false); <%-- No I18N --%>
	    			$(".fielderror").text(response.message);
	    			$(".fielderror").slideDown(200);
	    		}
	    	} else if(this.status != 200){
	    		$("#nextbtn").prop("disabled", false); <%-- No I18N --%>
	    		$(".fielderror").text("<%= com.adventnet.iam.internal.Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
	    		$(".fielderror").slideDown(200);
	    	}
	    }
	});

	function isEmpty(str) {
	    return str ? false : true;
	}
	
	function getcsrfParams() {
		var csrfParamName = "<%=SecurityUtil.getCSRFParamName(request)%>"; //NO OUTPUTENCODING
		var csrfCookieName = "<%=SecurityUtil.getCSRFCookieName(request)%>"; //NO OUTPUTENCODING
		var csrfQueryParam = csrfParamName + "=" + getCookieValue(csrfCookieName);
		return csrfQueryParam;
	}

	function getCookieValue(cookieName) {
	    var nameEQ = cookieName + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++) {
	        var c = ca[i].trim();
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return null;
	}
	function gotoForgetPassword(){
		tempFpUrl = resetpassurl + "?serviceurl=" + window.location.href; <%-- No I18N --%>
		window.location.href = tempFpUrl;
	}
</script>
</html>
