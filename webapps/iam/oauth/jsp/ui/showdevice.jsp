<%-- $Id: $ --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.internal.oauth2.OAuth2Util"%>
<%@ include file="../../../static/includes.jspf" %>
<%
boolean isMobile = Util.isMobileUserAgent(request);
User user = IAMUtil.getCurrentUser();
String zaid = IAMUtil.getCurrentClientPortal();
String forwardUrl = "/oauth/v3/device/verify";//No I18N
if(IAMUtil.isValid(zaid)){
	forwardUrl = "/accounts/p/"+zaid+"/oauth/v3/device/verify";//No I18N
}
%>
<html>
<head>
<title><%=Util.getI18NMsg(request, "IAM.ZOHO.ACCOUNTS")%></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<script src="<%=jsurl%>/jquery-3.6.0.min.js" type="text/javascript"></script> <%-- NO OUTPUTENCODING --%>
<link href="<%=cssurl%>/oauthdevice.css" type="text/css" rel="stylesheet"  /><%-- NO OUTPUTENCODING --%>
<script type="text/javascript">
function submitDeviceCode() {
	
	$( ".error_notif" ).remove();
	var deviceCode = $('#verify_code').val().trim();
	if(!deviceCode || deviceCode === '') {
		$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.ENTER.DEVICE.CODE")%></div>' );
		$('#verify_code').focus();
		return false;
	}
	var params = "Vcode=" + encodeURIComponent(deviceCode) + "&" +getcsrfParams(); //No I18N
	var resp = getPlainResponse("<%=forwardUrl%>", params); 
	if(!resp) {
		return false;
	}
	resp = resp.trim();
	if(resp.indexOf('ERROR_') != -1) {
		var errorCode = resp.split("ERROR_")[1];
		if(errorCode == "invalid_code") {
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.PHONE.INVALID.VERIFY.CODE")%></div>' );
		} else if(errorCode == "already_verified") { //No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.DEVICE.CODE.ALREADY.USE")%></div>' );
		} else if(errorCode == "access_denied") { //No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.RESTRICT.SIGNIN.HEADER")%></div>' );
		} else if(errorCode == "expired") { //No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.DEVICE.CODE.EXPIRED")%></div>' );
		} else if(errorCode == "invalid_client") { //No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.CLIENT.AUTH.FAILED")%></div>' );
		} else if(errorCode == "restricted_scope"){//No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.RESTRICTED.SCOPE")%></div>' );
		} else if(errorCode == "unconfirmed_user"){//No I18N
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.OAUTH.UNCONFIRMED.USER")%></div>' );
		} else {
			$('#get_ver_code').append( '<div class="error_notif"><%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%></div>' );
		}
		$('#verify_code').focus();
		return false;
	} else {
		$('#device_verification_container').hide();
		$('#device_container').show();
		$('#device_container').html(resp);
	}
	return false;
}

function getPlainResponse(action, params) {
    if(params.indexOf("&") === 0) {
	params = params.substring(1);
    }
    var objHTTP,result;objHTTP = xhr();
    objHTTP.open('POST', action, false);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    if(!params || params === '') {
        params = "__d=e"; //No I18N
    }
    objHTTP.setRequestHeader('Content-length', params.length);
    objHTTP.send(params);
    return objHTTP.responseText;
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

$(function() 
{
	var offset= $("#height").outerHeight()-165;// 20 for footer and 120for top
	$(".wrap").css("min-height", offset);	//No I18N



	$( window ).resize(function() {	
    	offset= $("#height").outerHeight()-165;// 20 for footer and 120for top
    	$(".wrap").css("min-height", offset);	//No I18N
	});
	
	

		$(".profile_pic").css({"background":'url("<%=cPath%>/file?fs=thumb&ID=<%=user.getZUID()%>")no-repeat transparent 0px 0px', "background-size":"100%"});   <%-- NO OUTPUTENCODING --%> <%-- No I18N --%>

	<%if(isMobile) 
	{%>
		$(".profile_pic_enlarge").css({"background":'url("<%=cPath%>/file?fs=thumb&ID=<%=user.getZUID()%>")no-repeat transparent 0px 0px', "background-size":"100%"});   <%-- NO OUTPUTENCODING --%> <%-- No I18N --%>
	<%}%>
	$("input").keypress(function(){
		
		
		$( ".error_notif" ).remove();
	
	
	});
	
    $("#log_out").click(function(){
    	var logoutUrl = '<%=IAMUtil.getLogoutURL(com.zoho.accounts.internal.util.Util.getAppName(request.getParameter("servicename")), "/oauth/v3/device")%>';
    	window.parent.location.href = logoutUrl;
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
    
    $('.profile_pic').click(function(){
    	
    	$('.mob_logout').show();
    });
    
    $('.exit_profile').click(function(){
    	$('.mob_logout').hide();
    });

});
</script>
</head>
<body>
        <div id="height"></div>
        <div id="error_space">
        <div class="top_div">
            <span class="cross_mark">
                <span class="crossline1"></span>
                <span class="crossline2"></span> 
            </span>
            <span class="top_msg"></span>
        </div>
        </div>
         <%if(!isMobile) {%>
		    <div class="profile">
                <span class="profile_pic"></span>
                <span class="profile_name"><%=IAMEncoder.encodeHTML(user.getDisplayName())%></span>
                <span class="hide logout" id="log_out"><%=Util.getI18NMsg(request, "IAM.SIGN.OUT")%></span>
            </div>
		
		<%}
        else
        {	
        %>
		    <div class="mob_profile">
            	<span class="profile_pic"></span>
            </div>
            <div class="mob_logout">
            	<div class="exit_profile"><span class="close_X"></span></div>
            	<span class="profile_pic_enlarge"></span>
            	<div class="profile_info">
            		<div class="white mob_name"><%=IAMEncoder.encodeHTML(user.getDisplayName())%></div>
            		<div class="white mob_emailid"><%=IAMEncoder.encodeHTML(user.getPrimaryEmail())%></div>
            		<button class="btn log_out" id="log_out"><%=Util.getI18NMsg(request, "IAM.SIGN.OUT")%></button>
        		</div>
        	</div>
       <% 	
        }
        %>
            <div id="device_container" style="display:none;"></div>
		<div class="container" id="device_verification_container">
            
            <div class="wrap">
                <img class="logo" src="<%=IAMEncoder.encodeHTML(StaticContentLoader.getStaticFilePath("/v2/components/images/newZoho_logo.svg"))%>">
                <div class="head_text"><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.VERIFY.DEVICECODE")%></div>
		           <div class="normal_text">
		 	                <%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.VERIFYCODE.SENT",OAuth2Util.DEVICE_TOKEN_EXPIRY/60000)%>
		           </div>
	               <div class="form_field" id="get_ver_code">
        				<input class="text_box"  id="verify_code" type="text" required="">
        				<span class="bar"></span>
        				<label><%=Util.getI18NMsg(request, "IAM.DEVICEOAUTH.ENTER.DISPLAYED.TOKEN")%></label>
    				</div> 


		           <button class="btn"  onclick="submitDeviceCode()"><%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.VERIFY")%></button>
		    </div>
            <footer id="footer">
    			<div style="font-size:14px;text-align:center;padding:5px 0px;">
					<span>
						<%=Util.getI18NMsg(request,"IAM.ZOHOCORP.FOOTER", Util.getCopyRightYear(), Util.getI18NMsg(request,"IAM.ZOHOCORP.LINK"))%>
					</span>
				</div>
		    </footer>
		</div>
</body>
</html>