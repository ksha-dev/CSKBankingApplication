<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
   	<@resource path="/v2/components/css/${customized_lang_font}" /> 
   	<@resource path="/v2/components/css/product-icon.css" /> 
   	<style>
   	body{
		font-size: 14px;
		margin: 0;
	}
    .btn {
		cursor: pointer;
		font-size: 14px;
		font-weight: bold;
		border-radius: 4px;
		padding: 12px 30px;
		background-color: #1389E3;
		color: #fff;
		border: none;
		margin:15px 0px;
		margin-right: 10px;
	}
    .cancel {
		cursor: pointer;
		color: #000;
		background-color: #F5F5F5;
		margin: 15px 0px;
		padding: 12px 30px;
		font-size: 14px;
		font-weight: bold; 
		border-radius:4px;
		border: none;
	}
	.app_verifiy_container {
		margin: auto;
		max-width: 420px;
		padding: 0px 10px;
		margin-top: 80px;
	}
	.app_div {
		text-align: center;
		margin: 24px 0px;
	}
	.icon_div {
		margin: auto;
		width: 40px;
	}
	.profile_div {
		height: 86px;
		width: auto;
		border: 1px solid #D8D8D8;
		border-radius: 6px;
		background: #FFFFFF03 0% 0% no-repeat padding-box;
		margin: 24px 0px;
	}
	.app_verify_profile_pic {
		height: 54px;
		width: 54px;
		display: inline-block;
		margin: 16px 8px 16px 16px;
		border: 2px solid #1389E3;
		border-radius: 50px;
		opacity: 1;
	}
	.user_div {
		display: inline-block;
		position: absolute;
		margin-top: 24px;
	}
	.verify_code_div {
		margin: 24px 0px;
	}
	.app_verify_icon {
		font-size: 40px;
	}
	.app_permission_text {
		font-size: 18px;
		margin-top: 16px;
		margin-left: 15%;
		margin-right: 15%;
	}
	.user_name {
		font-size: 16px;
		font-weight: 500;
		display: block;
	}
	.user_email {
		opacity: 70%;
	}
	.btn_div {
		display: inline-block;
		height: 40px;
	}
	.btn_allow, .btn_deny {
		margin-top: 0px;
	}
	btn_deny {
		opacity: 60%;
	}
	.user_info_div {
		margin-top: 40px;
		font-size: 12px;
	}
	.profile_change {
		color: #1389E3;
		font-weight: 600;
		float: right;
		margin-top: 35px;
		margin-right: 16px;
		cursor: pointer;
	}
	.user_info_div a {
		color: #1389E3;
		font-weight: bold;
		cursor: pointer;
	}
	.verify_code_label {
		font-weight: 500;
		margin-top: 24px;
		font-size: 12px;
	}
	.verify_code_box {
		margin-top: 4px;
		width: 240px;
		height: 44px;
		border: 1px solid #0F090933;
		border-radius: 4px;
		padding-left: 15px;
	}
	.verify_code_box ::placeholder {
		letter-spacing: 1.4px;
		color: #0000004D;
		opacity: 1;
	}
	.user_info_bullet {
		content: "";
		height: 6px;
		width: 6px;
		border-radius: 4px;
		background: #EF9B53;
		float: left;
		margin-top: 3px;
	}
	.user_info_txt {
		margin-left: 12px;
		margin-bottom: 16px;
		color: #000000CC;
	}
	#msg_space{
		position: fixed;
		width: fit-content;
		width: -moz-fit-content;
		left: 0px;
		right: 0px;
		margin: auto;
		display: inline-block;
		padding: 18px 30px;
		border-radius: 4px;
		color: #000;
		top: -100px;
		transition: all .3s ease-in-out;
		box-sizing: border-box;
	    max-width: 400px;
	}
	.error_space {
    	border: 1px solid #FCD8DC;
		background: #FFECEE;
	}
	.success_space {
    	border: 1px solid #CAEDE3;
		background: #E7FCF6;
	}
	.msg_icon {
	    position: relative;
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
	.error_icon {
	    background-color: #FD395D;
	    border: 1px solid #FD395D;
	}
	.success_icon {
		border: 1px solid #56D64B;
		background-color: #56D64B;
	}
	.success_icon::before {
		content: "";
		display: inline-block;
		border-right: 2px solid white;
		border-bottom: 2px solid white;
		width: 3px;
		height: 6px;
		position: absolute;
		top: 2px;
		left: 4px;
		transform: rotate(45deg);
	}
	.msg_icon.success_icon::before {
		width: 5px;
		height: 10px;
		top: 3px;
		left: 7px;
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
	.show_msg{
	  	top:60px !important;
	}
	</style>
    <script>
    var csrfParam= "${csrf_paramName}";
    var csrfCookieName = "${csrf_cookieName}";
    
	var i18nkeys = {
      	"IAM.OAUTH.APPVERIFY.PLEASE.ENTER.CODE" : '<@i18n key="IAM.OAUTH.APPVERIFY.PLEASE.ENTER.CODE"/>',
      	"IAM.OAUTH.APPVERIFY.APPROVED" : '<@i18n key="IAM.OAUTH.APPVERIFY.APPROVED"/>',
      	"IAM.OAUTH.APPVERIFY.REJECTED" : '<@i18n key="IAM.OAUTH.APPVERIFY.REJECTED"/>',
	};
    
    function submitVerify(allow) {
	
		clear_msg();
		var verifyCode = "";

		<#if ('${verify_code}')?has_content>
			verifyCode = "${verify_code}"; //No I18N
		<#else>
			verifyCode = $('#verify_code').val().trim();
			if(!verifyCode || verifyCode == '') {
				show_msg(i18nkeys["IAM.OAUTH.APPVERIFY.PLEASE.ENTER.CODE"],false);
				$('#verify_code').focus();
				return false;
			}
			verifyCode = btoa(verifyCode);
		</#if>

		var params = { userverify : { vCode : verifyCode, allow : allow}};
		sendRequestWithCallback("${submit_url}", JSON.stringify(params), true, handleResponse, "PUT");
	}
	
	function handleResponse(respStr){
		if(respStr!="" && respStr!= undefined){
	  		var resp = JSON.parse(respStr);
			if(resp.status_code >= 200 && resp.status_code <= 299){
				$(".btn_allow").attr("disabled", "disabled");
				$(".btn_deny").attr("disabled", "disabled");
				if(resp.userverify.status == 1) {
					show_msg(i18nkeys["IAM.OAUTH.APPVERIFY.APPROVED"],true);
				} else if(resp.userverify.status == 2) {
					show_msg(i18nkeys["IAM.OAUTH.APPVERIFY.REJECTED"],true);
				}
			} else{
				show_msg(resp.errors[0].message,false);
			}
	  	}
	}
	
	function show_msg(msg, success) {
		clear_msg();
		$('.top_msg').html(msg);
		if(success) {
			$('#msg_space').addClass('success_space');
			$('.msg_icon').addClass('success_icon');
			$('.msg_icon').html("");
		} else {
			$('#msg_space').addClass('error_space');
			$('.msg_icon').addClass('error_icon');
			$('.msg_icon').html("!");
			setTimeout(function() {
				clear_msg();
		    }, 5000);;
		}
		$('#msg_space').addClass('show_msg');
	}
	
	function clear_msg() {
		$('#msg_space').removeClass('show_msg');
		$('#msg_space').removeClass('success_space');
		$('#msg_space').removeClass('error_space');
		$('.msg_icon').removeClass('success_icon');
		$('.msg_icon').removeClass('error_icon');
	}
	
	function sendRequestWithCallback(action, params, async, callback, method){
		if (typeof contextpath !== 'undefined') {
			action = contextpath + action;
		}
    	var objHTTP = xhr();
    	objHTTP.open(method?method:'POST', action, async);
    	objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    	objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+encodeURIComponent(getCookie(csrfCookieName)));
    	if(async){
			objHTTP.onreadystatechange=function() {
	    	if(objHTTP.readyState==4) {
				if(callback) {
					callback(objHTTP.responseText);
				}
			}
		};
    	}
		objHTTP.send(params);
		if(!async) {
			if(callback) {
				callback(objHTTP.responseText);
			}
		}
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
	
	function getCookie(cookieName) {
		var nameEQ = cookieName + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i].trim();
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}

	</script>
  </head>
  <body>
        <div id="msg_space">
			<span class="msg_icon"></span> <span class="top_msg"></span>
		</div>
		<div class="app_verifiy_container" id="app_verification_container">
			<div class="wrap">
	        	<div class="app_div">
	        		<div class="icon_div">
	        			<i class="product-icon-${app_name} app_verify_icon" ><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span><span class="path11"></span><span class="path12"></span><span class="path13"></span><span class="path14"></span><span class="path15"></span><span class="path16"></span></i>
	                </div>
	                <div class="app_permission_text"><@i18n key="IAM.OAUTH.APPVERIFY.PERMISSION.DESC" arg0="${client_name}"/></div>
		        </div>
		        <div class="profile_div">
	                <span class="app_verify_profile_pic"></span>
	                <div class="user_div">
		                <span class="user_name">${user_name}</span>
		                <span class="user_email">${user_email}</span>
		            </div>
	                <span class="profile_change" id="profile_change"><@i18n key="IAM.OAUTH.APPVERIFY.PROFILE.CHANGE" /></span>
	            </div>
	            <#if !('${verify_code}')?has_content>
	            <div class="verify_code_div" id="verify_code_div">
		        	<div><@i18n key="IAM.OAUTH.APPVERIFY.ENTER.CODE" /></div>
		        	<div class="verify_code_label"><@i18n key="IAM.VERIFICATION.CODE" /></div>
		        	<input class="verify_code_box" id="verify_code" type="text" maxlength="9" placeholder="<@i18n key='IAM.OAUTH.APPVERIFY.CODE.PLACEHOLDER' />">
		        </div>
				</#if>
                <div class="btn_div">
	                <button class="btn btn_allow" onclick="submitVerify(true)"><@i18n key="IAM.OAUTH.APPVERIFY.ALLOW" /></button>
	                <#if ('${verify_code}')?has_content>
	                <button class="cancel btn_deny" onclick="submitVerify(false)"><@i18n key="IAM.OAUTH.APPVERIFY.DENY" /></button>
	                </#if>
	            </div>
                <div class="user_info_div">
                	<span class="user_info_bullet"></span><div class="user_info_txt"><@i18n key="IAM.OAUTH.APPVERIFY.USER.INFO.1" /></div>
                	<span class="user_info_bullet"></span><div class="user_info_txt" id="connected_apps_link"><@i18n key="IAM.OAUTH.APPVERIFY.USER.INFO.2" /></div>
			   	</div>
			</div>
		</div>
    <footer id="footer"><#include "../Unauth/footer.tpl"></footer>
  </body>
  <script>
  	window.onload = function () {
  		var offset= $("#height").outerHeight()-165;// 20 for footer and 120for top
		$(".wrap").css("min-height", offset);	//No I18N
	
		$( window ).resize(function() {	
	    	offset= $("#height").outerHeight()-165;// 20 for footer and 120for top
	    	$(".wrap").css("min-height", offset);	//No I18N
		});
	
		$(".app_verify_profile_pic").css({"background":'url("${profile_pic}") no-repeat transparent 0px 0px', "background-size":"100%"});   
	
		$("input").keypress(function(){
			clear_msg();
		});
	    $("#profile_change").click(function(){
	    	window.parent.location.href = "${logout_url}";
	    });
		$("#connected_apps_link a").click(function(){
	    	window.open("${connected_apps_url}","_blank");
	    });
		
	    $('#verify_code').keyup(function()
		{
			var key = event.keyCode || event.charCode;
			if(	(key<37 || key>40) && ( key != 8 && key != 46 )) // go in only when you type numbers and characters and not directions and backspace
			{
				if($('#verify_code').val().length==4)
				{
					$('#verify_code').val($('#verify_code').val()+'-');
				}
				else if($('#verify_code').val().length>4)
				{
					$('#verify_code').val($('#verify_code').val().replace(/-/g, ""));
					var res1=$('#verify_code').val().substring(0, 4);
					var res2=$('#verify_code').val().substring(4,$('#verify_code').val().length );
					$('#verify_code').val(res1+"-"+res2);
				}
			}
			if( key == 8 || key == 46 )
			{
				if($('#verify_code').val().length==5)
			    {
			    	$('#verify_code').val($('#verify_code').val().substring(0,$('#verify_code').val().length-2 ));
			    }
			    else if($('#verify_code').val().length>4)
			    {
					$('#verify_code').val($('#verify_code').val().replace(/-/g, ""));
					var res1=$('#verify_code').val().substring(0, 4);
					var res2=$('#verify_code').val().substring(4,$('#verify_code').val().length );
					$('#verify_code').val(res1+"-"+res2);
			   	}
			}
			    
		});
	    $('#verify_code').bind('cut copy paste', function (e) {
	        e.preventDefault();
	    });
  	}
  </script>
</html>
