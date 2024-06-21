<%-- $Id$ --%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.IAMStatusCode.StatusCode"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@ page isErrorPage="true"%>
<%
	response.setContentType("text/html;charset=UTF-8"); //No I18N
	String heading = null;
	String description = null;
	String refresh = null;
	String resetIPUrl =null;
	StatusCode code = (StatusCode) request.getAttribute("statuscode");//No I18N
	if (code == StatusCode.USER_NOT_ALLOWED_IP) {
		heading = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.TITLE");
		description = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.ERROR.DESC",IAMUtil.getRemoteUserIPAddress(request));
		refresh = Util.getI18NMsg(request, "IAM.ERRORJSP.IP.NOT.ALLOWED.ERROR.REFRESH");
		
		if("true".equals(AccountsConfiguration.getConfiguration("enable.reset.ip.recovery", "true")))
		{
			String requestURI = request.getRequestURI().toString();
			String serverUrl = null;
			if (requestURI.equals("/")) {
				serverUrl = request.getRequestURL().toString();
				serverUrl = serverUrl.substring(0, serverUrl.length() - 1); // removing last char
			} else {
				serverUrl = request.getRequestURL().toString().replace(requestURI, "");// No I18N
			}
			serverUrl = serverUrl.concat(request.getContextPath());
			resetIPUrl = new StringBuilder(serverUrl).append(Util.AccountsUIURLs.RESET_IP.getURI()).toString();
		}
		
	} else if (code == StatusCode.LOCATION_NOT_ALLOWED) {
		heading = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.TITLE");
		description = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.ERROR.DESC");
		refresh = Util.getI18NMsg(request, "IAM.ERRORJSP.LOCATION.NOT.ALLOWED.ERROR.REFRESH");
	}
%>
<html>
	<head>
		<title><%= Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%=StaticContentLoader.getStaticFilePath("/v2/components/css/zohoPuvi.css")%>" rel="stylesheet"type="text/css">
	</head>
	<style>
	body {
		width: 100%;
		font-family: 'ZohoPuvi', Georgia;
		margin: 0px;
	}
	
	.container {
		display: block;
		width: 70%;
		margin: auto;
		margin-top: 120px;
	}
	
	.zoho_logo {
		display: block;
		margin: auto;
		height: 40px;
		max-width: 200px;
		width: auto;
		background: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/newZoho_logo.svg")%>") no-repeat transparent;
		background-size: auto 100%;
		margin-bottom: 40px;
		background-position: center;
	}
	
	.error_img {
		display: block;
		height: 300px;
		margin-bottom: 40px;
		width: 100%;
	}
	
	.ip_block {
		background: url(<%=StaticContentLoader.getStaticFilePath("/v2/components/images/RestrictIP.svg")%>) no-repeat transparent;
		background-size: auto 100%;
		background-position: center;
	}
	
	.heading {
		display: block;
		text-align: center;
		font-size: 24px;
		margin-bottom: 10px;
		line-height: 34px;
		font-weight: 600;
	}
	
	.discrption {
		display: block;
		width: 500px;
		margin: auto;
		text-align: center;
		font-size: 16px;
		margin-bottom: 10px;
		line-height: 24px;
		color: #444;
	}
	
	.discrption p {
	    color: #E56000;
	}
	
	.refresh_btn
	{
	   	background-color: #1389E3;
	    color: #fff;
	    padding: 12px 30px;
	    border-radius: 5px;
	    font-size: 14px;
	    cursor: pointer;
		width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 600;
	    margin: auto;
	    margin-top: 30px;
	    border: none;
	    margin-right: 20px;
	}
	
	.whit_btn
	{
		background-color: #fff;
	    color: #1389E3;
	    padding: 12px 30px;
	    border-radius: 5px;
	    font-size: 14px;
	    cursor: pointer;
		width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 600;
	    margin: auto;
	    margin-top: 30px;
	    border: 1px solid #1389E3;
	}
	
.logout-wrapper {
		min-width:108px;
	    position: absolute;
	    top: 25px;
	    right: 50px;
	    cursor: pointer;
	    border: solid 1px #fff;
	    border-radius: 8px;
	    font-size: 14px;
	    transition: .3s width, .3s height;    
	    z-index: 1;
	    overflow:hidden;
	}
	.logout-wrapper:hover {
	    border-color: #e0e0e0;
	    background-color: #fbfcfc;
	}
	.logout-wrapper .name {
		position: absolute;
	    top: 0px;
	    right: 38px;
	    margin: 0;
	    line-height: 30px;
	    display: block;
	    transition: right .3s ease-out,top .3s ease-out,width .3s ease-out;
	    white-space:nowrap;
	}
	.logout-wrapper img {
	    width: 30px;
	    height: 30px;
	    position: absolute;
	    right: 0px;
	    top: 0px;
	    transition: all .3s ease-out;     
	    border-radius: 50%;     
	}
	
	.logout-wrapper.open .name {
	    font-size: 16px;
	    font-weight: 500;
	    top: 116px;
	    line-height: 20px;
	    stext-overflow: unset;
	    overflow:unset;
	    width:260px;
	}
	
	.logout-wrapper.open img {
	    width: 80px;
	    height: 80px;
	    top: 20px;
	}
	
	.logout-wrapper.open {
	    border-color: #e0e0e0;
	    background-color: #fbfcfc;
	    box-shadow: 0px 0px 6px 8px #ececec85;   
	}
	p.muted {
	    font-size: 12px;
	    line-height: 14px;
	    color: #5b6367;
	    margin:0px;
	    padding-top: 8px;
	}
	div.dc {
	    padding: 10px 25px;
	    background: #ffffff;
	    border-top: solid 1px #e0e0e0;
	    border-radius: 0px 0px 8px 8px;
	    font-size: 10px;
	    color: #5b6367;
	    line-height: 16px;
	    white-space: nowrap;
	}
	div.dc span {
	    font-size: 16px;
	    margin-right: 6px;
	    vertical-align: middle;
	    line-height: 1;
	}
	
	a.err-btn {
	    background-color: #EF5E57;
	    cursor: pointer;
	    width: fit-content;
	    width: -moz-fit-content;
	    width: -webkit-fit-content;
	    font-weight: 500;
	    color: #fff;
	    padding: 10px 30px;
	    border-radius: 5px;
	    font-size: 12px;
	    border: none;
	    margin: 20px auto;
	    font-family: 'ZohoPuvi', 'Open Sans';
	    text-decoration: none;
	    display: block;
	}
	
	a.err-btn:focus, a.err-btn:focus-visible {
		outline: none;
	}
	
	.user-info {
	    position: absolute;
	    top: 0px;
	    right: 0px;
	    height: 30px;
	    margin: 8px 24px;
	    /* transition: all .3s; */
	}
	
	.more-info {
	    position: absolute;
	    visibility: hidden;
	    top: 0px;
	    text-align: center;
	    transition: top .3s;    
	    width: 100%;
	    display: table;
	}
	
	.logout-wrapper.open .more-info {
	    visibility: visible;
	    top: 138px;
	    right: 0px;
	    min-width:300px;
	}
	
	.logout-wrapper.open .user-info {
	    margin:0px;
	    width:300px;
	}
	
	.text-ellipsis{
		width:160px;
		text-overflow:ellipsis;
		overflow:hidden;
	}
	
	.text-ellipsis-withoutWidth{
		text-overflow:ellipsis;
		overflow:hidden;
	}
	
	.logout-wrapper.open .name.white-spaces{
		white-space: break-spaces;
		text-align:center;
		transition:right .3s ease-out,top .3s ease-out;
	}
	
	.max-width{
		max-width:260px;
	}
	
	.dummy_name{
		width:260px;
		line-height:20px;
		white-space:break-spaces;
		text-align: center;
	    position: absolute;
	    right: 20px;
	    font-size: 16px;
	    font-weight: 500;
	    opacity:0;
	    margin:0px;
	}
	
	@media only screen and (max-width: 435px) {
		.container {
			width: 90%;
			margin-top: 80px;
		}
		.discrption {
			width: 100%;
		}
		.error_img {
			display: block;
			max-width: 340px;
			background-size: 100% auto;
			margin: auto;
			margin-bottom: 40px;
		}
		.heading {
			display: block;
			text-align: center;
			font-size: 20px;
			margin-bottom: 10px;
			line-height: 30px;
			font-weight: 600;
		}
		.discrption {
			display: block;
			margin: auto;
			text-align: center;
			font-size: 14px;
			margin-bottom: 10px;
			line-height: 24px;
			color: #444;
		}		
		.user-info{
			margin:8px 12px;
		}
		.logout-wrapper{
			top:20px;
			right:10px;
		}
		.logout-wrapper{
			position : absolute;
		}
		.text-ellipsis{
			width:130px;
		}
		.logout-wrapper:hover {
		    border-color: transparent;
	    	background-color: unset;
		}
		.logout-wrapper.open {
		    border-color: #e0e0e0;
		    background-color: #fbfcfc;
		}
	}
	</style>
	
	<body>
		<div class="logout-wrapper">
			<div class="user-info">
				<p class="name"></p>
				<p class="dummy_name"></p>
				<img src="<%=StaticContentLoader.getStaticFilePath("/v2/components/images/user_2.png") %>" />
			</div>
			<div class="more-info">
				<p id="user-email"class="muted"></p>
				<a href="<%= IAMEncoder.encodeHTMLAttribute(Util.getCurrentLogoutURL(request, AccountsConstants.ACCOUNTS_SERVICE_NAME,"")) %>" class="err-btn"><%= Util.getI18NMsg(request,"IAM.SIGN.OUT")%></a> 
			</div>
		</div>
		<div class="container"> 
			<div class="zoho_logo"></div>
			<div class="error_img ip_block"></div>
			<div class="heading"><%= heading %></div>
			<div class="discrption">
				<%= description %>
				<p><%= refresh %></p>
				<button class="refresh_btn" onclick="location.reload();"><%= Util.getI18NMsg(request,"IAM.REFRESH_NOW")%></button>
				<% if(resetIPUrl !=null){%>
				<button class="whit_btn" onclick="switchto('<%=resetIPUrl%>');"><%= Util.getI18NMsg(request,"IAM.IP.RESET.ADDRESS")%></button>
				<% }%>
			</div>
		</div>
		<footer id="footer"> <%--No I18N--%>
			<%@ include file="../unauth/footer.jspf"%>
		</footer> <%--No I18N--%>
	</body>
	<script>
	
	var LOGIN_ID=undefined;
	
	function switchto(url)
	{
		if(url.indexOf("http") != 0) { //Done for startsWith(Not supported in IE) Check
			var serverName = window.location.origin;
			if (!window.location.origin) {
				serverName = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
			}
			if(url.indexOf("/") != 0) {
				url = "/" + url;
			}
			url = serverName + url;
		}
		if(isValid(LOGIN_ID)){
			var oldForm = document.getElementById("recoveryredirection");
			if(oldForm) {
				document.documentElement.removeChild(oldForm);
			}
			var form = document.createElement("form");
			form.setAttribute("id", "recoveryredirection");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", url);
		    form.setAttribute("target", "_parent");
			
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "LOGIN_ID");
			hiddenField.setAttribute("value", LOGIN_ID ); 
			form.appendChild(hiddenField);
			
		   	document.documentElement.appendChild(form);
		  	form.submit();
		  	return false;
		}
		window.location.href = url;
	}
	
	function isValid(instr) {
		return instr != null && instr != "" && instr != "null";
	}


		function setFooterPosition(){
			var container = document.getElementsByClassName("container")[0];
			var top_value = window.innerHeight-60;
			if(container && (container.offsetHeight+container.offsetTop+30)<top_value){
				document.getElementById("footer").style.top = top_value+"px"; // No I18N
			}
			else{
				document.getElementById("footer").style.top = container && (container.offsetHeight+container.offsetTop+30)+"px"; // No I18N
			}
		}
		window.addEventListener("resize",function(){
			setFooterPosition();
		});
		window.addEventListener("load",function(){
			setFooterPosition();
		});
		function xhr() {
		    var xmlhttp;
		    if (window.XMLHttpRequest) {
				xmlhttp=new XMLHttpRequest();
		    } else if(window.ActiveXObject) {
				try {
				    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e) {
				    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
		    }
		    return xmlhttp;
		}
		
		
		
		
		var objHTTP = xhr();
	   	objHTTP.open('GET', '/u/unauth/info', true);
		objHTTP.onreadystatechange=function() {
	    	if(objHTTP.readyState==4 && objHTTP.status === 200 ) {
	    		var info = objHTTP.responseText && JSON.parse(objHTTP.responseText);
	    		if(info && info.EMAIL_ID && info.DISPLAY_NAME){
	    			if(info.LOGIN_ID)
	    			{
	    				LOGIN_ID=info.LOGIN_ID;
	    			}
	    			
	    	
		    		var checkIsMobile = false;
					<%if(Util.isMobileUserAgent(request)){%>
						checkIsMobile = true;
					<%}%>
		    		var logWrap = document.querySelector('.logout-wrapper'); // No I18N
		    		var userWrap = document.querySelector('.logout-wrapper .user-info'); // No I18N
		    		var moreWrap = document.querySelector('.logout-wrapper .more-info'); // No I18N
		    		var nameDom = userWrap.querySelector('p'); // No I18N
		    		var dummyName = document.getElementsByClassName("dummy_name")[0];
		    		nameDom.innerHTML =  dummyName.innerHTML = info.DISPLAY_NAME;
		    		var imageWrap = document.querySelector('.logout-wrapper .user-info img'); // No I18N
		    		var overflow =false;
		    		var initialMaxWidth = 160;
		    		var nameWidth = tempNameWidth =  nameDom.offsetWidth;
		    		var nameHeight = document.getElementsByClassName("dummy_name")[0].scrollHeight;
		    		moreWrap.querySelector('#user-email').innerHTML = info.EMAIL_ID; // No I18N
		    		if(nameDom.offsetWidth > initialMaxWidth  ){
		    			overflow=true;
		    			nameDom.classList.add("text-ellipsis"); // No I18N
		    			tempNameWidth =  nameDom.offsetWidth;
		    		}
		    		moreWrap.setAttribute('style','top:80px');
		    		userWrap.setAttribute('style','width:'+(nameDom.offsetWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
		    		
		    		if(checkIsMobile){
		    			if(window.innerWidth <= 360 ){
		    					if(nameWidth >= 100){
		    						nameDom.setAttribute('style','width:110px;height:'+nameDom.offsetHeight+'px');
		    						nameDom.classList.add("text-ellipsis-withoutWidth");// No I18N
		    						userWrap.setAttribute('style','width:148px;height:'+(nameDom.offsetHeight)+'px');
		    						logWrap.setAttribute('style','width:'+(userWrap.offsetWidth+24)+'px;height:'+(userWrap.offsetHeight+16)+'px');
		    					}
		    					else{
		    						nameDom.setAttribute('style','width:'+nameWidth+'px;height:'+(nameDom.offsetHeight)+'px;');
		    						userWrap.setAttribute('style','width:'+( nameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
		    						logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');
		    					}
		    			}
		    			else{
		    				logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');	
		    			}
		    		}
		    		else{
		    			logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 40)+'px;height:'+(userWrap.offsetHeight+16)+'px');	
		    		}
		    		
		    		
		    		logWrap.addEventListener('click', function(event) {
		    			event.stopPropagation();
		    		
		    			if(!event.target.classList.contains('err-btn')) { // No I18N
		    				logWrap.classList.toggle('open');// No I18N
		    				if(logWrap.classList.contains('open')) {
		    					var fullWidth =300;
		    					nameDom.classList.remove("text-ellipsis");// No I18N
		    					nameDom.style.width=(fullWidth-40)+'px';
		    					nameDom.style.right ="20px";// No I18N
		    					nameDom.classList.add("white-spaces");// No I18N
		    					imageWrap.style.right = ((moreWrap.offsetWidth/2) - 40) + "px";// No I18N
		    					userWrap.setAttribute('style','width:'+fullWidth+'px;height:'+(138+(nameHeight-20))+'px');
		    					moreWrap.setAttribute('style','top:'+(138+(nameHeight-20))+'px;transition:all .3s ease-out');
		    					logWrap.setAttribute('style','width:'+fullWidth+'px;height:'+(userWrap.offsetHeight + moreWrap.offsetHeight)+'px');
		    				} else {
		    					moreWrap.setAttribute('style','top:80px;transition:none');
		    					closeLogout();
		    				}
		    			}
		    		});
		    		document.addEventListener('click', function(event) {
		    			if(!event.target.classList.contains('err-btn') && logWrap.classList.contains('open')) {
		    				moreWrap.setAttribute('style','top:80px');
		    				logWrap.classList.toggle('open');// No I18N
		    				closeLogout();
		    			}
		    		});
		    		
		    		
		    		function closeLogout(){
		    			nameDom.style.right = '38px';// No I18N
		    			imageWrap.style.right = '0px';// No I18N
		    			if(overflow){
		    				nameDom.style.width = "160px";
		    				nameDom.classList.add("text-ellipsis");// No I18N
		    			}
		    			else{
		    				nameDom.style.width = nameWidth + 'px';
		    			}
		    			nameDom.classList.remove("white-spaces");// No I18N
		    			userWrap.setAttribute('style','width:'+(tempNameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
		    			if(checkIsMobile){
		    				if(window.innerWidth <= 360 ){
		    					if(nameWidth >= 100){
		    						nameDom.setAttribute('style','width:110px;height:'+nameDom.offsetHeight+'px');// No I18N
		    						nameDom.classList.add("text-ellipsis-withoutWidth");// No I18N
		    						userWrap.setAttribute('style','width:148px;height:'+(nameDom.offsetHeight)+'px');
		    						logWrap.setAttribute('style','width:'+(userWrap.offsetWidth+24)+'px;height:'+(userWrap.offsetHeight+16)+'px');
		    					}
		    					else{
		    						nameDom.setAttribute('style','width:'+nameWidth+'px;height:'+(nameDom.offsetHeight)+'px;');
		    						userWrap.setAttribute('style','width:'+( nameWidth + 38)+'px;height:'+nameDom.offsetHeight+'px');
		    						logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');
		    					}
		    				
		    				}
		    				else{
		    					logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 24)+'px;height:'+(userWrap.offsetHeight+16)+'px;');	
		    				}
		    			}
		    			else{
		    				logWrap.setAttribute('style','width:'+(userWrap.offsetWidth + 40)+'px;height:'+(userWrap.offsetHeight+16)+'px');	
		    			}
		    		}
	    		}	
	    	}
		}
		
	   	objHTTP.send();
	</script>
</html>
