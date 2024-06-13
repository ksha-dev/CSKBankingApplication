<!DOCTYPE html>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
	<style>
		body {
			margin:0px;
			color:#000;
		}
		.container{
			margin-top: 120px;
		    width: 940px;
		    display: block;
		    margin-left: auto;
		    margin-right: auto;
		    display: flex;
		}
		.announcement_img {
		    background: url("${SCL.getStaticFilePath('/v2/components/images/ConcurrentBlock.svg')}") no-repeat;
		    max-width: 350px;
		    height: 340px;
		    background-size: 100% auto;
		    display: inline-block;
		    margin-left: 50px;
		    float: right;
		    flex: 1;
		}
		
		.announcement_content {
			width: 540px;
		    display: inline-block;
		}
		.announcement_heading {
		    font-size: 24px;
		    margin-bottom: 20px;
		    font-weight: 600;
		}
		.announcement_description {
		    font-weight: 400;
		    font-size: 16px;
		    line-height: 24px;
		}
		.logo_text
		{
			font-weight: 500;
			font-size: 26px;
			line-height: 30px;
			margin-bottom: 20px;
		}
		.blue_btn {
			background: #1389E3;
			border-radius: 4px;
			margin-top: 30px;
			border: none;
			cursor: default;
			font-size: 14px;
			color: #FFFFFF;
			text-align: center;
			display: inline-block;
			font-weight: 600;
			box-sizing: border-box;
			padding: 12px 24px;
			font-family: 'ZohoPuvi', Georgia !important;
			outline: none;
			cursor: pointer;
		    text-decoration: none;
		}
		.blue_btn:hover{
			background: #0779CF;
		}
		@-webkit-keyframes spin
		{
			0% {-webkit-transform: rotate(0deg);}
			100% {-webkit-transform:rotate(360deg);}
		}
		@keyframes spin
		{
			0% {transform: rotate(0deg);}
			100% {transform:rotate(360deg);}
		}
		.loading_btn:before
		{
			content: "";
		    width: 10px;
		    height: 10px;
		    display: inline-block;
		    border: 2px solid #fff;
		    border-radius: 50%;
		    border-top: 2px solid transparent;
			margin-right: 5px;
			animation: spin 1s linear infinite;
			position: relative;
			top: 2px;
		}
		.action_div
		{
		    padding: 15px 20px;
		    border-top: 1px solid #D8D8D8;
		}
		.to_instructions,.instructions li
		{
			margin-top: 20px;
		}
		.instructions
		{
			margin:0px;
			padding: 0px 0px 0px 18px;
		}
		#error_space{
			position: fixed;
		    width: fit-content;
		    width: -moz-fit-content;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		    border: 1px solid #FCD8DC;
		    display: inline-block;
		    padding: 18px 30px;
		    background: #FFECEE;
		    border-radius: 4px;
		    color: #000;
		    top: -100px;
		    transition: all .3s ease-in-out;
		    box-sizing: border-box;
	        max-width: 400px;
		}
		.top_msg
		{
			font-size: 14px;
			color: #000;
			line-height: 24px;
			float: left;
			margin-left: 10px;
		    font-weight: 500;
		    font-size: 14px;
    		text-align: center;
    		line-height: 24px;
		    max-width: 304px;
		}
		.error_icon
		{
		    position: relative;
		    background: #FD395D;
		    width: 24px;
		    height: 24px;
		    float: left;
		    box-sizing: border-box;
		    border-radius: 50%;
		    display: inline-block;
		    color: #fff;
		    font-weight: 700;
		    font-size: 16px;
		    text-align: center;
		    line-height: 24px;
		}
		.show_error{
			top:60px !important;
		}
		@media only screen and (max-width: 800px) and (min-width: 435px)
		{			
			.announcement_img{
				display:none;
			}
			.container{
				width:540px;
			}
		}
		
		@media only screen and (max-width : 435px)
		{
			.announcement_img{
				display:none;
			}
			.container{
			    width: 100%;
			    padding: 0px 20px;
			    box-sizing: border-box;
		        display: block;
		        margin-top: 50px;
			}
			.announcement_content{
			    width: auto;
			}
		}
	</style> 
</head>
<body>	
	 <div id="error_space">
		<span class="error_icon">&#33;</span> <span class="top_msg"></span>
	</div>
	 <div class="container">
        <div class="announcement_content">
            <div class="logo_text">${Encoder.encodeHTML(app_display_name)}</div>  
            <div class="announcement_heading"><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.HEADER"/></div>
            <div class="announcement_description">
            	<div><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.LIMIT.DESCRIPTION" arg0="${threshold}"/>
            	</div>
            	<div class="to_instructions"><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.INSTRUCTION.FOLLOWING.TEXT"/></div>
            	<ul class="instructions">
            		<li><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.TERMINATE.INSTRUCTION1"/></li>
            		<div style="margin-top:20px;"><@i18n key="IAM.OR"/></div>
            		<li><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.TERMINATE.INSTRUCTION2" arg0="${threshold}"/></li>
            	</ul>
            </div>	    	
            <a class="blue_btn continue_button" id="continue_button" onclick="terminateAllSession()" id='continueButton' ><@i18n key="IAM.BLOCK.SESSION.ANNOUNCEMENT.TERMINATE" /></a>
        </div>
        <div class="announcement_img"></div>
     </div>
</body>
<script>
	function IsJsonString(str) {
		try {
			JSON.parse(str);
		} catch (e) {
			return false;
		}
		return true;
	}
	function getCookie(cookieName) 
	{
		var nameEQ = cookieName + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i].trim();
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}
	function showErrMsg(msg) 
	{
		document.getElementById("error_space").classList.remove("show_error");
	    document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N
	    document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
	    document.getElementById("error_space").classList.add("show_error");
	    
	    setTimeout(function() {
	    	document.getElementById("error_space").classList.remove("show_error");
	    }, 5000);;
	
	}
	function xhr() {
	    var xmlhttp;
	    if (window.XMLHttpRequest) {
		xmlhttp=new XMLHttpRequest();
	    }
	    else if(window.ActiveXObject) {
		try {
		    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e) {
		    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	    }
	    return xmlhttp;
	}
	function terminateAllSession(){
		document.getElementById("continue_button").classList.add("loading_btn");
		document.getElementById("continue_button").setAttribute("onclick", "");
		var csrfParam = "${za.csrf_paramName}";
		var csrfCookieName = "${za.csrf_cookieName}";
	    var objHTTP = xhr();
	    objHTTP.open('DELETE', "${cp_contextpath}"+"/webclient/v1/announcement/pre/blocksessions", true);
	    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
	    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+encodeURIComponent(getCookie(csrfCookieName)));
		objHTTP.onreadystatechange=function() 
		{
		    if(objHTTP.readyState==4) 
		    {
		    	if (objHTTP.status === 0 ) 
		    	{
					document.getElementById("continue_button").classList.remove("loading_btn");
					document.getElementById("continue_button").setAttribute("onclick", "terminateAllSession()");
					showErrMsg("<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>");
					return false;
				}
				else
				{
					if(IsJsonString(objHTTP.responseText)) 
					{				
						var jsonStr = JSON.parse(objHTTP.responseText);
						if(jsonStr.status_code.toString() === "204"){
							window.location.href = "${nxt_preann_url}";
						}
						else{
							document.getElementById("continue_button").classList.remove("loading_btn");
							document.getElementById("continue_button").setAttribute("onclick", "terminateAllSession()");
							showErrMsg("<@i18n key="IAM.ERROR.GENERAL"/>");
						}
					}
					else{
							document.getElementById("continue_button").classList.remove("loading_btn");
							document.getElementById("continue_button").setAttribute("onclick", "terminateAllSession()");
							showErrMsg("<@i18n key="IAM.ERROR.GENERAL"/>");
					}
				}
		    }
		};
	    objHTTP.send("");
	}
</script>
</html>