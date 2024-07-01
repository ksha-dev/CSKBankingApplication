<html>
<head>
	<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <@resource path="/v2/components/js/uvselect.js" />
	<@resource path="/v2/components/js/flagIcons.js" />
    <@resource path="/v2/components/js/signin.js" />
    <@resource path="/v2/components/tp_pkg/xregexp-all.js" />
    <title><@i18n key="IAM.CLIENT.SIGNIN.TITLE"/></title>
    <@resource path="/v2/components/css/${customized_lang_font}" />   
	<script type='text/javascript'>
		var uriPrefix = "${uriPrefix}";
		var digest = "${digest}";
		var csrfCookieName= "${csrfCookieName}";
		var csrfParam = "${csrfParam}";
		var servicename = "${servicename}";
		var serviceurl = "${serviceurl}";
	
	function handleAssociateAction(action){
			var form = document.createElement("form");
			var params = "&action="+action+"&servicename="+servicename+"&serviceurl="+euc('${Encoder.encodeJavaScript(serviceurl)}');
			if(action === 'signin'){
			params = params+"&hide_fs=true";
			}
			var url = uriPrefix+"/clientidpassociate?state="+digest+params;
			form.setAttribute("id", "form");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", url);
		    form.setAttribute("target", "_parent");

		   	document.documentElement.appendChild(form);
		  	form.submit();
	}
		
	</script>
	<style>
	@font-face {
		  font-family: 'fed_icons';
		  src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
		  src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
		    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
		    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
		    	url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
		 		font-weight: normal;
		 		font-style: normal;
		 		font-display: block;
		}
		
		[class^="icon-"], [class*=" icon-"] {
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'fed_icons' !important;
		  speak: never;
		  font-style: normal;
		  font-weight: normal;
		  font-variant: normal;
		  text-transform: none;
		  line-height: 1;
		
		  /* Better Font Rendering =========== */
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		}
		body{
			margin:0px;
			padding:0px;
		}
		.main {
		    display: block;
		    width: 600px;
		    background-color: #fff;
		    box-shadow: 0px 2px 30px #ccc6;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    margin-top: 100px;
		    margin-bottom: 5%;
		    overflow: hidden;
		    border-radius: 16px;
		    border:1px solid #E0E0E0;
		}
		.inner-header {
			height:80px;
		    position: relative;
		    z-index: -1;
		    display: flex;
		    border-bottom: 1px solid #E0E0E0;
		    justify-content: center;
		    align-items: center;
		}
		.IDP_log_container {
		    display: inline-block;
		    overflow: auto;
		    display: flex;
	        align-items: center;
   			justify-content: center;
		}
		.IDP_logo {
		    width: 108px;
		    height: 30px;
		    box-sizing: border-box;
		    border-radius: 50%;
		    float: left;
		    position: relative;
		    z-index: 1;
		}
		.text_container{
			padding:36px;
		}
		.other_IDPs .IDP_logo[class*=" icon-"] {
		    display: flex;
		    font-size: 30px;
		}
		
		.icon-twitter:before {
  		  content: "\e959";
    	  color: #199df1;
		}
		.icon-adp:before {
    		content: "\e933";
 		    color: #ef221d;
		}
		.icon-apple:before {
 		   content: "\e934";
		}
		.icon-baidu:before {
    	   content: "\e935";
    	   color: #2319dc;
		}
		.icon-douban:before {
 		   content: "\e936";
  		   color: #29983a;
     	}
     	.icon-facebook:before {
 		   content: "\e937";
    	   color: #1177f2;
		}
		.icon-feishu .path1:before {
    		content: "\e938";
   			color: rgb(0, 214, 185);
		}
		.icon-feishu .path2:before {
    		content: "\e939";
  			margin-left: -1em;
    		color: rgb(51, 112, 255);
		}
		.icon-feishu .path3:before {
    		content: "\e93a";
    		margin-left: -1em;
    		color: rgb(19, 60, 154);
		}
		.icon-github:before {
    		content: "\e93b";
		}
		.icon-google .path1:before {
    		content: "\e93c";
    		color: rgb(66, 133, 244);
		}
		.icon-google .path2:before {
  		  content: "\e93d";
 		  margin-left: -1em;
    	  color: rgb(52, 168, 83);
		}
		.icon-google .path3:before {
    	  content: "\e93e";
          margin-left: -1em;
          color: rgb(251, 188, 5);
        }
        .icon-google .path4:before {
    	  content: "\e93f";
    	  margin-left: -1em;
          color: rgb(234, 67, 53);
 		}
 		.icon-intuit:before {
  		  content: "\e940";
 		  color: #1d6cff;
		}
		.icon-linkedin:before {
  		  content: "\e941";
  		  color: #0a66c2;
		}
		.icon-azure .path1:before {
    	  content: "\e942";
    	  color: rgb(107, 190, 0);
		}
		.icon-azure .path2:before {
   		  content: "\e943";
   		  margin-left: -1em;
  		  color: rgb(255, 62, 0);
		}
		.icon-azure .path3:before {
   		  content: "\e944";
 		  margin-left: -1em;
    	  color: rgb(0, 165, 246);
		}
		.icon-azure .path4:before {
    	  content: "\e945";
          margin-left: -1em;
          color: rgb(255, 183, 0);
		}
		.icon-qq .path1:before {
    	  content: "\e946";
    	  color: rgb(250, 171, 7);
		}
		.icon-qq .path2:before {
    	  content: "\e947";
          margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.icon-qq .path3:before {
    	  content: "\e948";
   		  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.icon-qq .path4:before {
          content: "\e949";
          margin-left: -1em;
    	  color: rgb(250, 171, 7);
		}
		.icon-qq .path5:before {
    	  content: "\e94a";
    	  margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.icon-qq .path6:before {
 		  content: "\e94b";
    	  margin-left: -1em;
    	  color: rgb(255, 255, 255);
		}
		.icon-qq .path7:before {
    	  content: "\e94c";
   		  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.icon-qq .path8:before {
    	  content: "\e94d";
    	  margin-left: -1em;
    	  color: rgb(235, 25, 35);
		}
		.icon-slack .path1:before {
  		  content: "\e94e";
    	  color: rgb(224, 30, 90);
		}
		.icon-slack .path2:before {
    	  content: "\e94f";
    	  margin-left: -1em;
    	  color: rgb(54, 197, 240);
		}
		.icon-slack .path3:before {
    	  content: "\e950";
    	  margin-left: -1em;
    	  color: rgb(46, 182, 125);
		}
		.icon-slack .path4:before {
  		  content: "\e951";
   		  margin-left: -1em;
  		  color: rgb(236, 178, 46);
		}
		.icon-wechat:before {
   		  content: "\e952";
		}
		.icon-yahoo:before {
    	  content: "\e958";
   		  color: #7e1fff;
		}
		.icon-weibo .path1:before {
   		  content: "\e953";
    	  color: rgb(255, 255, 255);
		}
		.icon-weibo .path2:before {
 	      content: "\e954";
          margin-left: -1em;
          color: rgb(230, 22, 45);
 		}
 		.icon-weibo .path3:before {
 		  content: "\e955";
    	  margin-left: -1em;
          color: rgb(255, 153, 51);
		}
		.icon-weibo .path4:before {
   		  content: "\e956";
    	  margin-left: -1em;
    	  color: rgb(255, 153, 51);
		}
		.icon-weibo .path5:before {
   		  content: "\e957";
 	      margin-left: -1em;
    	  color: rgb(0, 0, 0);
		}
		.cross_mark {
		    position: relative;
		    padding: 0px 16px;
		    width: 40px;
		    height:30px;
    		box-sizing: border-box;
		}
		.cross_mark:after, .cross_mark:before {
		    content: "";
		    width: 1px;
		    display: inline-block;
		    height: 9px;
		    background: #707070;
		    position: absolute;
		    top: 10px;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		}
		.cross_mark:after{
		    transform: rotate(45deg);
		}
		.cross_mark:before{
		    transform: rotate(-45deg);
		}
		.form_btn {
		    padding: 0px 30px;
		    font-size: 13px;
		    color: #FFFFFF;
		    font-weight: 600;
		    background: #1389E3;
		    border: none;
		    outline: none;
		    border-radius: 5px;
		    margin-top: 30px;
		    cursor: pointer;
		    text-transform: uppercase;
		    box-sizing: border-box;
		    transition: all 0.3s ease-in-out;
		    height: 40px;
		}
		.gray_btn {
		    color: #969696;
		    background: #FFFFFF;
		    border: 2px solid #E7E7E7;
		    margin-left: 20px;
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
		.btn_loading:after {
		    content: "";
		    border: 2px solid white;
		    border-top: 2px solid transparent;
		    border-radius: 50%;
		    width: 12px;
		    display: inline-block;
		    height: 12px;
		    background: transparent;
		    position: relative;
		    left: 5px;
		    top: 1px;
		    box-sizing: border-box;
		    animation: spin 1s linear infinite;
		}
		.gray_btn:after{
		    border-color: #969696;
   			border-top-color: transparent;
		}
		.title_text{
			font-size: 20px;
		    font-weight: 500;
		}
		.page_desc{
		    font-size: 14px;
		    margin-top: 8px;
		    line-height: 20px;
		}
		.portal_title_name{
			text-align: right;
		    line-height: 16px;
		    font-size: 14px;
		    font-weight: 500;
		    display: flex;
		    align-items: center;
		    justify-content: end;
		    width:160px;
		    height:auto;
		}
		.link_detail_box{
			border-radius: 4px;
		    border: 1px solid #E0E0E0;
		    padding: 20px 16px;
		    margin-top: 24px;
		    display: flex;
		}
		.link_detail_box [class*="_detail"]{
			flex:1;
		}
		.blue_text_title{
			font-size: 12px;
			font-weight: 600;
			color: #149AFF;
		    line-height: 14px;
		}
		.mail_text{
		    margin-top: 4px;
		    font-size: 14px;
		    line-height: 16px;
		}
		.header_bg {
		    position: absolute;
		    z-index: -1;
		    width: 100%;
		    height: 100%;
		    left: 0px;
		    right: 0px;
		    top: 0px;
		    background:#F4F4F4;
		    overflow:hidden;
		}
		.bg_rectangle {
		    width: 96px;
		    height: 65px;
		    position: absolute;
		    background: #FAFAFA;
		    left: -37px;
		    top: -23px;
		    transform: rotate(-45deg);
		}
		.center_semi_circle {
		    position: absolute;
		    width: 50px;
		    height: 50px;
		    right: 122px;
		    border-radius: 50%;
		    background: #EFEFEF;
		    bottom: -34px;
		}
		.small_circle {
		    position: absolute;
		    width: 20px;
		    height: 20px;
		    border-radius: 50%;
		    left: 126px;
		    background: #FAFAFA;
		    bottom: 20px;
		}
		.right_circle {
		    width: 114px;
		    height: 114px;
		    position: absolute;
		    background: #EFEFEF;
		    right: -62px;
		    bottom: 20px;
		    border-radius: 50%;
		}
		
		
		@media only screen and (max-width: 435px){
			.main {
			    width: 100%;
			    height: 100%;
			    margin-top: 0px;
			    margin-bottom: 0px;
			    border-radius: 0px;
			}
			.form_btn {
			    width: 100% !important;
		        margin-left: 0px;
			}
			.link_detail_box{
			    flex-direction: column;
			}
			.link_detail_box .cross_mark{
			    width: 100%;
			}
		}
	</style>
</head>
<body>
	<div class="main container">
		<div class="inner-header">
			<div class="header_bg">
				<div class="bg_rectangle"></div>
				<div class="center_semi_circle"></div>
				<div class="small_circle"></div>
				<div class="right_circle"></div>
			</div>
			<div class="IDP_log_container">
				<div class="IDP_logo zoho_icon portal_title_name">${appDisplayName}</div>
				<div class="cross_mark"></div>
				<div class="other_IDPs">
					<div class="IDP_logo icon-google">
						<span class="path1"></span>
						<span class="path2"></span>
						<span class="path3"></span>
						<span class="path4"></span>
						<span class="path5"></span>
						<span class="path6"></span>
						<span class="path7"></span>
						<span class="path8"></span>
					</div>
				</div>
			</div>
		</div>
		
	<#if isAssociate>
	<div class="text_container">
		<div class="concern_option">
			<div>
				<div class="title_text"><@i18n key="IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.TITLE"/></div>
				<div class="page_desc"><@i18n key="IAM.PORTAL.FEDERATED.LINK.WITH.PORTAL" arg0="${providerName}" arg1="${appDisplayName}"/></div>
			</div>
			<div class="link_detail_box">
				<div class="portal_detail">
					<div class="blue_text_title">${appDisplayName}</div>
					<div class="mail_text">${emailID}</div>
				</div>
				<div class="cross_mark"></div>
				<div class="federated_detail">
					<div class="blue_text_title">${providerName}</div>
					<div class="mail_text">${emailID}</div>
				</div>
			</div>
			<div>
				<button class="form_btn" onclick="handleAssociateAction('associate')"><@i18n key="IAM.CONTINUE"/></button>
				<button class="form_btn gray_btn" onClick="handleAssociateAction('logout')"><@i18n key="IAM.CANCEL"/></button>
			</div>
		</div>
	</div>	
		
	<#else>
	<div class="text_container">
		<div>
			<div class="title_text"><@i18n key="IAM.PORTAL.FEDERATED.LINK.WITH.EXISTING"/></div>
			<div class="page_desc"><@i18n key="IAM.PORTAL.FEDERATED.LINK.WITH.EXISTING.DESCRIPTION" arg0="${appDisplayName}" arg1="${emailID}" arg2="${providerName}"/></div>
		</div>
		<div>
			<button class="form_btn" onclick="handleAssociateAction('signin')"><@i18n key="IAM.PROCEED.TO.VERIFY"/></button>
			<button class="form_btn gray_btn" onClick="handleAssociateAction('cancel')"><@i18n key="IAM.CANCEL"/></button>
		</div>
	</div>
	</#if>
		</div>
	</div>
</body>
</html>