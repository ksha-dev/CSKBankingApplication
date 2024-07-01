<!DOCTYPE html>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<@resource path="/v2/components/css/${customized_lang_font}" />
	<@resource path="/v2/components/js/common_unauth.js" />
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
		    background: url("${SCL.getStaticFilePath('/v2/components/images/Concurrent.svg')}") no-repeat;
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
		    margin-bottom: 20px;
		}
		.alert_text
		{
			margin-top:20px;
		}
		.logo_text
		{
			font-weight: 500;
			font-size: 26px;
			line-height: 30px;
			margin-bottom: 20px;
		}
		[class*="_btn"] {
			font-family: 'ZohoPuvi', Georgia;
			box-sizing: border-box;
			background: #1389E3 0% 0% no-repeat padding-box;
			border: none;
			cursor: pointer;
			text-decoration: none;
			padding: 12px 30px;
			border-radius: 4px;
			font-weight: 600;
			font-size: 14px;
			margin-top: 30px;
		}
		.blue_btn {
			color: #FFFFFF;
			text-align: center;
			display: inline-block;
			padding: 12px 24px;
			outline: none;
		}
		#continue_button:hover{
			background: #0779CF;
		}
		.border_container
		{
			border: 1px solid #D8D8D8;
    		border-radius: 6px;
	        max-width: fit-content;
	        min-width: 420px;
		}
		.session_cir_container
		{
			padding: 20px 20px 25px 20px;
		}
		.session_cir_container .session_header
		{
			font-size: 12px;
		    font-weight: 600;
		    color: #00000099;
		}
		.canvas_board
		{
		    margin-right: 10px;
	        transform: rotate(90deg);
		}
		.canvas_area
		{
			margin-top:16px;
			display:flex;
		}
		.session_count
		{
			font-size: 16px;
			font-weight: 600;
			margin-top: 10px;
		}
		.remaining_count
		{
			margin-top: 6px;
		    font-size: 13px;
		    color: #FF5757;
		    font-weight: 500;
		}
		.action_div {
		    border-top: 1px solid #D8D8D8;
		}
		.action_div .blue_text {
		    padding: 15px 20px;
		    display:block;		
		}
		.blue_text{
			color:#00A7FF;
			font-size:14px;
			font-weight:600;
			cursor:pointer;
			text-decoration: none;
		}
		.remind_me_later {
            color: #8b8b8b;
            height: 18px;
            border-bottom: 1px dashed #acacac;
            text-decoration: none;
            outline: none;
            line-height: 16px;
            font-size: 14px;
            font-weight: 500;
            left: 0px;
            background-color: white;
            position: relative;
            transition: left .4s ease-in, right .4s ease-in;
            margin-top: 0px;
            cursor:pointer;
        }
        .remind_me_later.right {
        	right: 0px;
        	left: unset;
        }
        .remind_me_later div {
            display: inline-block;
            font-weight: 500;
        }
        .buttdisabled{
			opacity: 0.5;
			pointer-events: none;
		}
		.loader {
			display: inline-block;
			border-radius: 50%;
  			width: 10px;
  			height: 10px;
  			position: relative;
  			top: 2px;
  			margin-right: 10px;
  			border: 2px solid rgba(255, 255, 255, 0.2);
  			border-left: 2px solid;
  			border-bottom: 2px solid;
  			transform: translateZ(0);
  			-webkit-animation: load 1s infinite linear;
  			animation: load 1s infinite linear;
	  	}
	  	@keyframes load {
  			0% {
    			-webkit-transform: rotate(0deg);
    			transform: rotate(0deg);
  			}
  			100% {
    			-webkit-transform: rotate(360deg);
    			transform: rotate(360deg);
  			}
	  	}
      	.blur {
			height: 100%;
        	width: 100%;
        	position: fixed;
        	z-index: -4;
        	background-color: #000;
        	transition: background-color 0.2s ease-in-out, opacity 0.2s ease-in-out;
        	opacity: 0;
        	top: 0px;
        	left: 0px;
      	}
		#svg_circle{
			transition: stroke-dasharray .6s ease-in-out;
		}
		.popup-header {
        	background-color: #fbfbfb;
        	border-radius: 10px 10px 0 0;
        	display: flex;
        	padding: 20px 60px 20px 30px;
        	align-items: center;
        	font-size: 18px;
      		font-weight: 500;
      	}
		.popup-body {
        	padding: 30px 30px 40px 30px;
        	background-color: #ffffff;
        	border-radius: 0 0 10px 10px;
      	}
		.delete-popup{
	  		position: fixed;
	  		/*z-index:10;*/
	  		/*top:0px;*/
	  		left: 0;
	  		right:0;
	  		margin:auto;
	  		border-radius: 0px 0px 10px 10px;
	  		min-height: 0px;
	  		width: 600px;
	  		opacity: 0;
	  		z-index: -2;
	  		top: -30px;
	  		transition: 0.3s top ease-in-out, 0.2s all ease-in-out;
	  	}
	  	.delete-popup:focus-visible, .msg-popups:focus-visible {
    		outline: none;
	  	}
	  	.delete-popup .popup-header{
	  		border-radius: 0px;
	  	}
	  	.show.delete-popup{
	  		top: 0px;
	  		z-index: 10;
	  		opacity: 1;
	  	}
	  	.delete-desc {
        	font-size: 14px;
        	font-weight: 500;
        	line-height: 20px;
      	}
      	.confirm-delete_btn{
      		color: #FFFFFF;
      		background-color: #DF5B5B;
      	}
	  	.confirm-delete_btn:hover{
			background-color: #D34A4A;
      	}
      	.cancel_btn {
        	margin-left: 10px;
        	background-color: #f0f0f0;
        	color: #000000cc;
      	}
      	.cancel_btn:hover{
      		background-color: #EBEAEA;
      	}
      	.remind_loader {
            left: -20px;
            pointer-events: none;
        }
        .remind_loader.right{
        	 right: -20px;
        	 left: unset;
        }
        .remind_loader::after {
            content: "";
            display: inline-block;
            position: absolute;
            top: 4px;
            right: 0px;
            z-index: -2;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-left: 2px solid;
            border-bottom: 2px solid;
            -webkit-animation: load .6s infinite linear, anim_r .2s 1 forwards ease-in;
            animation: load .6s infinite linear, anim_r .2s 1 forwards ease-in;
            width: 7px;
            height: 7px;
            border-radius: 50px;
        }
        .remind_loader.right::after{
        	left: 0px;
        	right: unset;
        	-webkit-animation: load .6s infinite linear, anim_l .2s 1 forwards ease-in;
        	animation: load .6s infinite linear, anim_l .2s 1 forwards ease-in;
        }
        @keyframes anim_r{
	  		0%{
	  		right: 0px;
	  		}
	  		100%{
	  		right: -20px;
	  		}
	  	}
        @keyframes anim_l{
	  		0%{
	  		left: 0px;
	  		}
	  		100%{
	  		left: -20px;
	  		}
	  	}
	  	 .tick {
            display: inline-block;
            margin-right: 10px;
            width: 10px;
            height: 5px;
            border-left: 2px solid #0093ff;
            border-bottom: 2px solid #0093ff;
            transform: rotate(-45deg);
            position: relative;
            top: -4px;
        }
	  	        .verified_tick {
            height: 5px;
            width: 0px;
            animation: 0.6s ease-in-out 0s 1 forwards running tick;
            margin-right: 0px;
            margin-left: 10px;
            left: -10px;
        }
                @keyframes tick {
            0% {
                width: 0px;
            }

            100% {
                width: 10px;
            }
        }
        .white {
            border-bottom-color: #ffffff;
            border-left-color: #ffffff;
        }
        #error_space {
            position: fixed;
            width: fit-content;
            width: -moz-fit-content;
            left: 0px;
            right: 0px;
            margin: auto;
            border: 1px solid #FCD8DC;
            display: flex;
            align-items: center;
            padding: 18px 30px;
            background: #FFECEE;
            border-radius: 4px;
            color: #000;
            top: -130px;
            transition: all .3s ease-in-out;
            box-sizing: border-box;
            max-width: 400px;
        }
        #error_space:hover {
            transform: scale(1.05);
        }
        .top_msg {
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
        .error_icon {
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
        .show_error {
            top: 60px !important;
        }
        .warning_icon {
            background: #EDB211;
        }
        .cp_display_name{
			font-size: 16px;
			margin-bottom: 20px;
		}
		@media only screen and (max-width: 800px) and (min-width: 435px){			
			.announcement_img{
				display:none;
			}
			.container{
				width:540px;
			}
		}	
		@media only screen and (max-width : 435px){
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
			.border_container
			{
			    min-width: 100%;
			}
		}
	</style> 
</head>
<script>
var csrfParam = "${za.csrf_paramName}";
var csrfCookieName = "${za.csrf_cookieName}";
var contextpath = <#if cp_contextpath??> "${cp_contextpath}" <#else > "" </#if>;
function showDeleteConfirm(e){
	e.target.classList.add('buttdisabled');
	var blur = document.querySelector(".blur");
	blur.style.zIndex = "2";
	blur.style.opacity = "0.5";
	blur.addEventListener('click', cancelDelete);
	document.querySelector(".delete-popup").classList.add("show")
}
function confirmDelete(e){
	e.target.classList.add('buttdisabled');
	e.target.querySelector('span').classList.add('loader');
	document.querySelector(".delete-cancel-btn").classList.add('buttdisabled');
	sendRequestWithCallback("/webclient/v1/account/self/user/self/activesessions", '', true, handleTerminate, "DELETE");
}
function cancelDelete(){
	document.querySelector(".delete-cancel-btn").classList.remove('buttdisabled');
	var confD = document.querySelector(".confirm-delete_btn");
	confD.classList.remove('buttdisabled');
	confD.querySelector('span').classList.remove('loader');
	document.querySelector(".delete-popup").classList.remove("show")
	var blur = document.querySelector(".blur");
	blur.removeEventListener('click', cancelDelete);
	blur.style.opacity = "0";
	setTimeout( function(){
		blur.style.zIndex = "-4";
	},200)
	document.querySelector(".blue_btn").classList.remove('buttdisabled');
}
function handleTerminate(respStr){
	if(respStr!="" && respStr!= undefined){
		var resp = JSON.parse(respStr);
		if(resp.status_code >= 200 && resp.status_code <= 299){
			window.location.href = "${Encoder.encodeJavaScript(visited_url)}";
		}else{
			cancelDelete();
			classifyError(resp);
		}
	}else{
		showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
	}
}
 function classifyError(resp, siblingClassorID) {
            if (resp.status_code && resp.status_code === 0) {
                showErrMsg(I18N.get("IAM.PLEASE.CONNECT.INTERNET"));
            } else if (resp.code === "Z113") {//No I18N
                showErrMsg(I18N.get("IAM.ERROR.SESSION.EXPIRED"));
            } else if (resp.code === "PP112") {
                showErrMsg(I18N.get("IAM.ERROR.RELOGIN.UPDATE"), resp);
            } else if (resp.localized_message) {
                showErrMsg(resp.localized_message)
            } else {
                showErrMsg(I18N.get("IAM.ERROR.GENERAL"));
            }
        }
        function showErrMsg(msg, isRelogin, isSuccess) {
            document.querySelector(".error_icon").classList.remove("warning_icon","verified-selected");
            document.querySelector("#error_space").classList.remove("warning_space","success_space");
            //document.querySelector("#error_space .close_btn").removeEventListener("onclick", closeRelogin);
            document.querySelector("#error_space .close_btn").style.display = "none";
            if (isRelogin) {
                document.getElementsByClassName("error_icon")[0].classList.add("warning_icon")
                document.getElementById("error_space").classList.add("warning_space")
                document.getElementsByClassName("error_icon")[0].innerHTML = "!";
                document.getElementById("error_space").setAttribute("resp", isRelogin.redirect_url)
                document.getElementById("error_space").addEventListener("click", reloginRedirect)
                document.querySelector("#error_space .close_btn").addEventListener("click", closeRelogin)
                document.querySelector("#error_space .close_btn").style.display = "inline-block";
            } else if (isSuccess) {
                document.getElementById("error_space").classList.add("success_space")
                document.getElementsByClassName("error_icon")[0].classList.add("verified-selected")
                document.getElementsByClassName("error_icon")[0].innerHTML = "";
            } else {
                document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error")
                document.getElementsByClassName("error_icon")[0].innerHTML = "!";
            }
            document.getElementsByClassName('top_msg')[0].innerHTML = msg;
            document.getElementById("error_space").classList.add("show_error");
            if (!isRelogin) setTimeout(function () {
                document.getElementById("error_space").classList.remove("show_error");
            }, 5000);
        }
</script>
<body>	
	<div class="blur"></div>
	 <div id="error_space">
            <span class="error_icon">&#33;</span>
            <span class="top_msg"></span>
            <span class="close_btn" style="display: none"></span>
        </div>
	<div class="delete-popup" tabindex="1" onkeydown="escape(event)">
		<div class="popup-header">
    		<div class="popup-heading"><@i18n key="IAM.SESSIONS.TERMINATE.ALL.OTHER.SESSIONS" /></div>
    	</div>
    	<div class="popup-body">
    		<#assign remaining_sess = session_count - 1 >
    		<#if session_count - 1 == 1>
    		<div class="delete-desc"><@i18n key="IAM.SESSION.MNG.SIGNOUT.ONE"/></div>
    		<#else>
    		<div class="delete-desc"><@i18n key="IAM.SESSION.MNG.SIGNOUT.N"  arg0="${remaining_sess}"/></div>
    		</#if>
      		
      		<button class="confirm-delete_btn" onclick="confirmDelete(event)"><span></span><@i18n key="IAM.TERMINATE" /></button>
      		<button class="delete-cancel-btn cancel_btn" onclick="cancelDelete(event)"><@i18n key="IAM.CANCEL" /></button>
      	</div>
	</div>
	 <div class="container">
        <div class="announcement_content">
            <div class="cp_display_name">${Encoder.encodeHTML(app_display_name)}</div>
            <#if session_count gte threshold>
            <div class="announcement_heading"><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.LIMIT.REACHED.HEADER"/></div>
            <div class="announcement_description">
            	<div><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.LIMIT.REACHED.DESCRIPTION" arg0="${session_count - 1}"/></div>
            	<div class="alert_text" style="color:#ED473F"><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.ALERT.TEXT"/></div>
            <#else>
            <div class="announcement_heading"><@i18n key="IAM.SESSION.MNG.ANNOUN.HEADER"/></div>
            <div class="announcement_description">
            	<div><@i18n key="IAM.SESSION.MNG.ANNOUN.LIMIT.REACHED.DESC" arg0="${threshold}"/></div>
            	<div class="alert_text"><@i18n key="IAM.SESSION.TERMINATE.AVOID.INTERRUPTION"/></div>
            </#if>
            
            </div>
            <div class="border_container">
            	<div class="session_cir_container">
            		<div class="session_header"><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.BOX.TITLE"/></div>
            		<div class="canvas_area">
            			<svg class="canvas_board" id="canvas_board" style="background:#fff;display:block;" width="60px" height="60px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
							<g transform="translate(50,50)">
								<circle cx="0" cy="0" fill="none" r="40" stroke="#efefef" stroke-width="20" stroke-dasharray="250 250">
								</circle>
								<circle id="svg_circle" cx="0" cy="0" fill="none" r="40" <#if is_warning> stroke="#f4a352" <#else> stroke="#f45353" </#if> stroke-width="20" stroke-dasharray="0 250">
								</circle>
							</g>
						</svg>
            			<div style="overflow:auto">
	            			<div class="session_count bold"><@i18n key="IAM.SESSION.MNG.ANNOUN.LIMIT.COUNT" arg0="${session_count}"/></div>
	            			<#if session_count gte threshold>
	            			<div class="remaining_count"><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.NO.MORE"/></div>
							<#else>
	            			<div class="remaining_count"><@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.REMAINING.COUNT" arg0="${threshold - session_count}"/></div>
	            			</#if>
            			</div>
            		</div>
            	</div>
	    	</div>
	    	<div>
	    		<a class="blue_btn" id="continue_button" onclick="showDeleteConfirm(event)" id='continueButton' ><@i18n key="IAM.SESSIONS.TERMINATE.ALL.OTHER.SESSIONS" /></a>
	    		<a class="remind_me_later right" href="${Encoder.encodeHTMLAttribute(skip_url)}" onclick="(function(e){e.target.classList.add('remind_loader')})(event);" style="margin-left:24px;"><@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW"/></a>
	    	</div>
        </div>
        <div class="announcement_img"></div>
     </div>
</body>
<script>
	window.onload=function(){
		document.getElementById("svg_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * (${session_count} / ${threshold}))+" "+(2 * Math.PI * 40));
	}
</script>
</html>