<!DOCTYPE html>
<meta name="IE_Compatible" http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
	<head>
		<meta name="robots" content="noindex, nofollow"/>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/multidc_signin.css")}" rel="stylesheet"type="text/css">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
		<style>
			body{margin: 0px;}
			.load-bg{top:0px}
			.darkmode .load-bg{background-color: #191A23}
		</style>
		<script>
			<#if (('${login_url}')?has_content)>
				goToSignin("${login_url}");
			</#if>
			window.onload = function(){
				var loader = document.getElementsByClassName("load-bg")[0];
				if(isElementVisible(loader)){
					setTimeout(function(){
						document.querySelector(".load-bg").classList.add("load-fade"); //No I18N
						setTimeout(function(){
							document.querySelector(".load-bg").style.display = "none";
						}, 300)
					}, 500);
				}
			}
			function isElementVisible(element) {
			    var style = window.getComputedStyle(element);
				return style.display !== "none" && style.visibility !== "hidden";
			}
			function goToSignin(loginUrl){
				var oldForm = document.getElementById("signinredirection");
				if(oldForm) {
					document.documentElement.removeChild(oldForm);
				}
				var form = document.createElement("form");
				form.setAttribute("id", "signinredirection");
				form.setAttribute("method", "POST");
			    form.setAttribute("action", loginUrl);
			    form.setAttribute("target", "_parent");
				
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "LOGIN_ID");
				hiddenField.setAttribute("value", '${cloned_user_email}' ); 
				form.appendChild(hiddenField);
				
			   	document.documentElement.appendChild(form);
			  	form.submit();
			}
		</script>
	</head>
	<body>
		<#include "../zoho_line_loader.tpl">
		<div class="bg_one"></div>
		<div class="signin_container">
			<div class='zoho_logo ${service_name}'></div>
			<div class="signin_head">
				<span id="headtitle"><@i18n key="IAM.SIGN_IN"/></span>
				<div class="service_name"><@i18n key="IAM.NEW.SIGNIN.SERVICE.NAME.TITLE" arg0="${service_display_name}" /></div>
			</div>
			<div class="hellouser">
				<div class="username">${cloned_user_email}</div>
				<a class="Notyou bluetext" href="${redirect_url}"><@i18n key="IAM.SIGNUP.CHANGE"/></a>
			</div>
			<div class='multiDC-con'><@i18n key="IAM.NEW.MULTIDC.SIGNOUT.CONTENT" arg0="${current_dc}"/></div>
			<div id='multiDC_container'>
				<div class="profile_head">
					<div class="profile_dp" id="profile_img">
						<label class="file_lab">
							<img id="dp_pic" draggable="false" src="${existing_user_logo}" onerror="this.src='/v2/components/images/user_2.png';" style="width: 100%; height: 100%;">
						</label>
					</div>
					<div class="profile_info">
						<div class="profile_name" id="profile_name">${existing_user_name}</div>
						<div class="profile_email" id="profile_email">${existing_user_email}</div>
					</div>
					<div class="DC_info"><span class="icon-datacenter"></span>${current_dc}</div>
				</div>
			</div>
			<a class="btn blue" href="${logout_url}"  id="nextbtn" tabindex="2"><span class=""><@i18n key="IAM.LOGOUT" /></span></a>
			<div class="text16" id="createaccount"><a class="text16" href="${signup_url}"><@i18n key="IAM.FEDERATED.SIGNUP.CREATE.ACCOUNT.BUTTON"/></a></div>
		</div>
	</body>
</html>