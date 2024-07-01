<html>
		<script type="text/javascript">
			function remoteGet() {
				<#if (remotelogouturls)?has_content>
					var remotelogouturlsarr = '${remotelogouturls}';
					if(remotelogouturlsarr !== null) {
						var remotelogouturls = JSON.parse(remotelogouturlsarr);
		                for (jsonIdx in remotelogouturls) {
		                    try {
		                        var img = new Image();
		                        var url = remotelogouturls[jsonIdx];
		                        img.src = url;
		                        <#if (serviceurl)?has_content>
		                        img.onerror = function() {
		                        if ((jsonIdx + 1) >= remotelogouturls.length) {
										window.location.href='${Encoder.encodeJavaScript(serviceurl)}';
									}
		                        }
			                    img.onload = function() {
									if ((jsonIdx + 1) >= remotelogouturls.length) {
										window.location.href='${Encoder.encodeJavaScript(serviceurl)}';
									}
								}
								</#if>
		                    } catch (e) { }
						}
					}
				</#if>
			}
			
			
			window.onload = function() {
				remoteGet();		
				<#if (ACTION)?has_content>
				document.getElementById("submitform").submit();
				</#if>
				<#if (idp)?has_content>
					document.getElementById("main_container").style.display = "block";
					document.getElementById("bg_one").style.display = "block";					
					document.getElementById("IDP_name").onclick=function(){
						window.open("${Encoder.encodeJavaScript(idpurl)}","_blank");						
					};
					var timeCount = 10;
					document.getElementById("countdown_value").innerHTML = timeCount;
					setInterval(function(){
						timeCount = timeCount-1;
						if(timeCount<1){
							serviceRedirect();
							return false;
						}
						document.getElementById("countdown_value").innerHTML = timeCount;
					}, 1000);
				</#if>
			}
		</script>
	<#if (idp)?has_content>
	<head>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<@resource path="/v2/components/css/${customized_lang_font}" />
		<style >
		@font-face{
			font-family:Announcement;
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
				  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
			      url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
			      url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff2")}') format('woff2'),
			      url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
			font-weight: normal;
			font-style: normal;
			font-display: block;
			
		}
		
		[class^="logo_"], [class*="logo_"] {
		  font-family: 'Announcement' !important;
		  speak: never;
		  font-style: normal;
		  font-weight: normal;
		  font-variant: normal;
		  text-transform: none;
		  line-height: 1;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		}
		
		.logo_twitter:before {
  		  content: "\e959";
    	  color: #199df1;
		}
		.logo_adp:before {
    		content: "\e933";
 		    color: #ef221d;
		}
		.logo_apple:before {
 		   content: "\e934";
		}
		.logo_baidu:before {
    	   content: "\e935";
    	   color: #2319dc;
		}
		.logo_douban:before {
 		   content: "\e936";
  		   color: #29983a;
     	}
     	.logo_facebook:before {
 		   content: "\e937";
    	   color: #1177f2;
		}
		.logo_feishu .path1:before {
    		content: "\e938";
   			color: rgb(0, 214, 185);
		}
		.logo_feishu .path2:before {
    		content: "\e939";
  			margin-left: -1em;
    		color: rgb(51, 112, 255);
		}
		.logo_feishu .path3:before {
    		content: "\e93a";
    		margin-left: -1em;
    		color: rgb(19, 60, 154);
		}
		.logo_github:before {
    		content: "\e93b";
		}
		.logo_google .path1:before {
    		content: "\e93c";
    		color: rgb(66, 133, 244);
		}
		.logo_google .path2:before {
  		  content: "\e93d";
 		  margin-left: -1em;
    	  color: rgb(52, 168, 83);
		}
		.logo_google .path3:before {
    	  content: "\e93e";
          margin-left: -1em;
          color: rgb(251, 188, 5);
        }
        .logo_google .path4:before {
    	  content: "\e93f";
    	  margin-left: -1em;
          color: rgb(234, 67, 53);
 		}
 		.logo_intuit:before {
  		  content: "\e940";
 		  color: #1d6cff;
		}
		.logo_linkedin:before {
  		  content: "\e941";
  		  color: #0a66c2;
		}
		.logo_azure .path1:before {
    	  content: "\e942";
    	  color: rgb(107, 190, 0);
		}
		.logo_azure .path2:before {
   		  content: "\e943";
   		  margin-left: -1em;
  		  color: rgb(255, 62, 0);
		}
		.logo_azure .path3:before {
   		  content: "\e944";
 		  margin-left: -1em;
    	  color: rgb(0, 165, 246);
		}
		.logo_azure .path4:before {
    	  content: "\e945";
          margin-left: -1em;
          color: rgb(255, 183, 0);
		}
		.logo_qq .path1:before {
    	  content: "\e946";
    	  color: rgb(250, 171, 7);
		}
		.logo_qq .path2:before {
    	  content: "\e947";
          margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.logo_qq .path3:before {
    	  content: "\e948";
   		  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.logo_qq .path4:before {
          content: "\e949";
          margin-left: -1em;
    	  color: rgb(250, 171, 7);
		}
		.logo_qq .path5:before {
    	  content: "\e94a";
    	  margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.logo_qq .path6:before {
 		  content: "\e94b";
    	  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.logo_qq .path7:before {
    	  content: "\e94c";
   		  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.logo_qq .path8:before {
    	  content: "\e94d";
    	  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.logo_slack .path1:before {
  		  content: "\e94e";
    	  color: rgb(224, 30, 90);
		}
		.logo_slack .path2:before {
    	  content: "\e94f";
    	  margin-left: -1em;
    	  color: rgb(54, 197, 240);
		}
		.logo_slack .path3:before {
    	  content: "\e950";
    	  margin-left: -1em;
    	  color: rgb(46, 182, 125);
		}
		.logo_slack .path4:before {
  		  content: "\e951";
   		  margin-left: -1em;
  		  color: rgb(236, 178, 46);
		}
		.logo_wechat:before {
   		  content: "\e952";
		}
		.logo_yahoo:before {
    	  content: "\e958";
   		  color: #7e1fff;
		}
		.logo_weibo .path1:before {
   		  content: "\e953";
    	  color: rgb(255, 255, 255);
		}
		.logo_weibo .path2:before {
 	      content: "\e954";
          margin-left: -1em;
          color: rgb(230, 22, 45);
 		}
 		.logo_weibo .path3:before {
 		  content: "\e955";
    	  margin-left: -1em;
          color: rgb(255, 153, 51);
		}
		.logo_weibo .path4:before {
   		  content: "\e956";
    	  margin-left: -1em;
    	  color: rgb(255, 153, 51);
		}
		.logo_weibo .path5:before {
   		  content: "\e957";
 	      margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		
		
		
		body
		{
			margin:0px;
			padding:0px;
		}
		.bg_one {
		    display: block;
		    position: fixed;
		    top: 0px;
		    left: 0px;
		    height: 100%;
		    width: 100%;
		    background: #F6F6F6;
		    background-size: auto 100%;
		    z-index: -1;
		}
		.main {
		    display: block;
		    width: 620px;
		    background-color: #fff;
		    box-shadow: 0px 2px 30px #ccc6;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    margin-top: 8%;
		    overflow: hidden;
		    border-radius: 40px;
		}
		.inner-container {
		    padding: 40px 35px;
		    text-align: center;
		    margin-top: -40px;
		    background: white;
		    border-radius: 40px;
		    border: 2px solid #ECECEC;
		    box-sizing: border-box;
		}
		.IDP_logo {
		    width: 70px;
		    height: 70px;
		    background: #FFFFFF;
		    border:2px solid #F5F5F5;
		    display: inline-block;
	        box-sizing: border-box;
		    border-radius: 50%;
		}
		.inner-header {
		    padding: 30px;
		    background: linear-gradient(90deg,#1389E3,#0093E5);
		    padding-bottom: 70px;
		    position:relative;
		    z-index:-1;
		}
		.header_bg
		{
		    position: absolute;
		    z-index: -1;
		    width: 100%;
		    height: 100%;
		    left: 0px;
		    right: 0px;
		    top:0px;
		}
		.right_circle
		{
		    width: 194px;
		    height: 194px;
		    position: absolute;
		    background: #0000000d;
		    right: -59px;
		    bottom: 55px;
		    border-radius: 50%;
		}
		.center_semi_circle {
		    position: absolute;
		    width: 98px;
		    height: 98px;
		    right: 135px;
		    border-radius: 50%;
		    background: #0000000d;
		    top: 97px;
		}
		.small_circle {
		    position: absolute;
		    width: 48px;
		    height: 48px;
		    border-radius: 50%;
		    left: 123px;
		    background: #ffffff1a;
		    top: 67px;
		}
		.bg_rectangle {
			width: 250px;
		    height: 180px;
		    position: absolute;
		    background: #ffffff1a;
		    left: -118px;
		    top: -70px;
		    transform: rotate(-45deg);
		}
		.IDP_log_container
		{
		    display: inline-block;
		    overflow: auto;
		}
		.other_IDPs
		{
			display: inline-block;
		    float: left;
		    margin-left: -14px;
		}
		.zoho_icon
		{
			float:left;
		    position: relative;
		    z-index: 1;
		}
		.hide{
			display:none;
		}
		.user_name
		{
		    text-align: center;
		    font-weight: 500;
		    font-size: 20px;
		    margin-bottom: 10px;
		}
		.content_abt_IDP {
		    text-align: center;
		    font-size: 14px;
		    line-height: 24px;
		    margin-bottom: 20px;
	        letter-spacing: -.2;
		}
		.IDP_name
		{
	        font-weight: 500;
	        cursor:pointer;
	        color: #0091FF;
		    text-transform: capitalize;
		}
		.IDP_name_qq,.IDP_name_adp
		{
			text-transform: uppercase;
		}
		.logout_count {
		    text-align: center;
		    font-size: 13px;
		    letter-spacing: -0.19;
		    line-height: 24px;
		    margin-bottom:20px;
		}
		.redirect_btn {
		    background: #ECF7FF;
		    border: 1px solid #D9EFFF;
		    padding: 0px 15px;
		    cursor:pointer;
	        padding-right: 35px;
		    margin: auto;
		    line-height: 34px;
		    display: inline-block;
		    position: relative;
		    border-radius: 4px;
		    font-size: 14px;
		    font-weight: 500;
		    color: #0091FF;
		    box-sizing: border-box;
		    height: 36px;
		}
		.redirect_arrow {
		    display: inline-block;
		    transform: rotate(45deg);
		    font-size: 18px;
		    position: absolute;
		    right: 12px;
		    line-height: 34px;
		}
		.idp_inner_logo
		{
	 		display:inline-block;
			width:100%;
			height:100%;	
		}
		.zoho_icon .idp_inner_logo
		{
			width: 100%;
			height: 100%;
			border-radius: 50%;
			display: inline-block;
			overflow: hidden;
		    background : url(${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}) no-repeat;
			background-position : center;
  			background-size : 80% auto;
  			background-color:white;
		}
		.idp_inner_logo[class^="logo_"] ,.idp_inner_logo[class*="logo_"]{
			display:flex;
			padding:18px;
			font-size: 30px;
			box-sizing:border-box;
		}
		
		.idp_inner_logo.logo_adp{
    		font-size: 18px;
    		padding-top: 24px;
    		padding-left:14px;
		}
		
		.idp_inner_logo.logo_intuit {
   			font-size: 18px;
			padding-top: 24px;
			padding-left: 12px;
		}
		
		#footer
		{
		    width: 100%;
		    height: 20px;
		    font-family: ZohoPuvi,sans-serif;
		    font-size: 14px;
		    color: #727272;
		   	position:absolute;
		    margin:20px 0px;
		    z-index: 1;
		}
		
		#footer div
		{
		    text-align:center;
		    font-size: 14px;
		}
		
		#footer div a
		{
		    text-decoration:none;
		    color: #727272;
		    font-size: 14px;
		}

   		@media only screen and (max-width : 435px)
		{
			.main
			{
			    width: 100%;
		        height: calc(100% - 60px);
			    margin-top: 0px;
    			border-radius: 0px;
    			box-shadow: unset;
			}
			.inner-container
			{
				height:100%;
			}
			.bg_one
			{
				background: white;
			}
			
		}
		</style>
		<script type="text/javascript">
			function serviceRedirect(){
					window.open("${Encoder.encodeJavaScript(serviceurl)}","_self");
			}
		</script>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
	</head>
	</#if>
	<body>
		<#if (idp)?has_content>
		<div class="bg_one hide" id="bg_one" style="display:none"></div>
		<div align="center" id="main_container" class="main hide container">
			<div class="inner-header">
				<div class="header_bg">
					<div class="bg_rectangle"></div>
					<div class="center_semi_circle"></div>
					<div class="small_circle"></div>
					<div class="right_circle"></div>
				</div>
				<div class="IDP_log_container">
					<div class="IDP_logo zoho_icon">
						<span class="idp_inner_logo"></span>
					</div>
					<div class="other_IDPs">
						<div class="IDP_logo">
							<span class="idp_inner_logo logo_${idp?lower_case}">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
								<span class="path7"></span>
								<span class="path8"></span>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="inner-container">
				<div class="user_name"><@i18n key="IAM.FEDERATE.LOGOUT.HI.USER" arg0="${Encoder.encodeHTML(username)}"/></div>		
				<div class="content_abt_IDP"><@i18n key="IAM.FEDERATE.LOGOUT.DESCRIPTION.WITH.IDP" arg0="${idp?lower_case}"/></div>
				<div class="logout_count"><@i18n key="IAM.FEDERATE.LOGOUT.DESCRIPTION.TIMER"/></div>
				<div class="redirect_btn" onclick="serviceRedirect()"><@i18n key="IAM.REDIRECT.NOW"/><span class="redirect_arrow">&#8599;</span></div>
			</div>
		</div>
	
		<#elseif (ACTION)?has_content>
			<form id="submitform" name="logoutpost" action="${Encoder.encodeHTMLAttribute(LOGOUT_URL)}" method="post" enctype="application/x-www-form-urlencoded" >
		        <textarea name="${Encoder.encodeHTMLAttribute(ACTION)}" id="req" style="display:none;">${Encoder.encodeHTML(SAML_MSG)}</textarea>
		        <#if (RELAY_STATE_URL)?has_content>
		        	<input name="RelayState" type="hidden" id="relay" value="${Encoder.encodeHTMLAttribute(RELAY_STATE_URL)}" />
		        </#if>
		    </form>
	    </#if>
		<#include "footer.tpl">
	</body>
	
</html>