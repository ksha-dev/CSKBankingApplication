<%--$Id$--%>
<%@page import="com.zoho.accounts.internal.signin.DataHandler"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.zoho.accounts.internal.util.DataCenterConfiguration.GeoDCConfiguration"%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="com.zoho.accounts.internal.util.AppConfiguration"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.SignupMode"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.OAuth2ProviderConstants"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.zoho.accounts.handler.GeoDCHandler"%>
<%@page import="com.zoho.accounts.AgentResourceProto.ZAID.ZUID.Email"%>
<%@page import="com.zoho.accounts.internal.OpenIDUtil"%>
<%@page import="com.zoho.accounts.internal.fs.FSConsumerUtil"%>
<%@page import="com.zoho.accounts.internal.util.StaticContentLoader"%>
<%@page import="com.zoho.accounts.templateengine.util.HtmlResourceIncluder"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.zoho.accounts.dcl.DCLUtil"%>
<%@page import="com.zoho.accounts.SystemResourceProto.DCLocation"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="com.zoho.accounts.SystemResourceProto.ISDCode"%>
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.zoho.accounts.mail.MailUtil"%>
<%@ include file="../static/includes.jspf" %>
<html>
	<head>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<%= HtmlResourceIncluder.addResource("/v2/components/tp_pkg/jquery-3.6.0.min.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/js/common_unauth.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/tp_pkg/xregexp-all.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/js/splitField.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/js/uvselect.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/js/flagIcons.js") %><%-- NO OUTPUTENCODING --%>
		<%= HtmlResourceIncluder.addResource("/v2/components/css/uvselect.css") %>
		<%= HtmlResourceIncluder.addResource("/v2/components/css/zohoPuvi.css") %>
		<%= HtmlResourceIncluder.addResource("/v2/components/css/flagIcons.css") %>
		
		<style >		
		@font-face {
		  font-family: 'Federated';
		  src:  url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")%>');
		  src:  url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")%>') format('embedded-opentype'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")%>') format('truetype'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")%>') format('woff'),
		    	url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")%>') format('svg');
		 		font-weight: normal;
		 		font-style: normal;
		 		font-display: block;
		}
		
		[class^="icon-"], [class*=" icon-"] {
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'Federated' !important;
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

		.icon-link:before {
		  content: "\e90f";
		}
		.icon-Contacts:before {
		  content: "\e903";
		}
		.icon-Everyone:before {
		  content: "\e907";
		}
		.icon-Myself:before {
		  content: "\e904";
		}
		.icon-Zohousers:before {
		  content: "\e906";
		}
		.icon-info:before {
		  content: "\e90e";
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
				
		body
		{
			margin:0px;
			padding:0px;
		}
		b{
			font-weight:600;
		}
		.bg_one {
		    display: block;
		    position: fixed;
		    top: 0;
		    left: 0;
		    height: 100%;
		    width: 100%;
		    background: #F6F6F6;
		    background-size: auto 100%;
		    z-index: -1;
		}
		.main {
		    display: block;
		    width: 600px;
		    background-color: #fff;
		    box-shadow: 0px 2px 30px #ccc6;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    margin-top: 5%;
		    margin-bottom: 5%;
		    overflow: hidden;
		    border-radius: 40px;
		}
		.link_account_option
		{
		    position: relative;
			border: 2px solid #ECECEC;
			margin-top: 36px;
			padding: 20px;
			border-radius: 10px;
		}
		.inner-container {
		    padding: 40px 35px;
		    text-align: left;
		    margin-top: -40px;
		    background: white;
		    border-radius: 40px;
		    border: 2px solid #ECECEC;
		    box-sizing: border-box;
		}
		#footer {
		    width: 100%;
		    height: 20px;
		    font-family: 'ZohoPuvi', Georgia;
		    font-size: 14px;
		    color: #727272;
		    position: absolute;
		    margin: 20px 0px;
		    text-align: center;
		}
		#footer a{
			color:#727272;
		}
		.IDP_logo {
		    width: 70px;
		    height: 70px;
		    background: #FFFFFF;
		    border:2px solid #F5F5F5;
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
		    border-radius:50%;
		    background-color:white;
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
		
		.other_IDPs .IDP_logo[class*=" icon-"]{
			display:flex;
		    font-size:30px;
		    padding:18px;
		}
		.IDP_logo.zohologo{
			background : url('<%=StaticContentLoader.getStaticFilePath("/v2/components/images/newZoho_logo.svg")%>') no-repeat;
			background-position : center;
  			background-size : 80% auto;
  			background-color:white;
		}
		
		.other_IDPs .IDP_logo.icon-intuit{
			font-size:16px;
			padding-top: 24px;
    		padding-left: 14px;
		}
		.other_IDPs .IDP_logo.icon-adp{
			font-size:18px;
			padding-top: 24px;
			padding-left:14px;
		}
		
		.IDP_logo.icon-wechat{
			-webkit-text-fill-color: transparent;
  			 background: linear-gradient(to right,#07df6e, #0bcc67);
    		-webkit-background-clip: text;
		}
		
		.user_name_text
		{
    		font-weight: 500;
		    font-size: 20px;
		    margin-bottom:8px;
		}
		.desc_text
		{
			font-size:14px;
			line-height:20px;
		}
		.user_detail_form{
			padding-top: 24px;
		    display: flex;
		    justify-content: space-between;
		    flex-wrap: wrap;
		}
		.detail_box{
		    padding: 8px 10px;
		    border-radius: 4px;
		    border: 1px solid #C7C7C7;
		    width: 250px;
		    box-sizing: border-box;
		    margin-bottom: 24px;
		}
		.disbled_detail,.disbled_detail .user_detail_input{
			background:#F8F8F8;
		    color: #000;
		}
		.user_header{
		    font-size: 10px;
		    line-height: 14px;
		    margin-bottom: 4px;
		    font-weight: 500;
		    color: #00000080;
		}
		.user_detail
		{
			font-size:14px;
			line-height:20px;
		}
		.user_detail_input {
		    line-height: 20px;
		    border: none;
			-webkit-appearance: none;
		    appearance: none;
		    outline: none;
		    font-size: 14px;
		    height:20px;
		    padding: 0px;
		    width: 100%;
	        background: #fff;
            font-family: 'ZohoPuvi', Georgia;
		}
		.agree_checkbox
		{
		    cursor: pointer;
		    border: none;
		    outline: none;
		    width: 0px;
		    height: 0px;
		    position: relative;
		    margin: 2px 0px;
		    border-radius: 3px;
		    opacity:0;
		}
		.agree_checkbox+label:before
		{
		    content: "";
		    width: 16px;
		    display: inline-block;
		    height: 16px;
		    border: 2px solid #E9E9E9;
		    border-radius: 3px;
		    box-sizing: border-box;
		    background: #fff;
		    position: absolute;
			left: 0px;
			top: 2px;
		}
		.agree_checkbox+label:after
		{
		    content: "";
		    width: 5px;
		    display: inline-block;
		    height: 10px;
		    border: 3px solid #fff;
		    border-left: transparent;
		    border-top: transparent;
		    border-radius: 1px;
		    box-sizing: border-box;
		    position: absolute;
		    left: 5px;
		    top: 4px;
		    transform: rotate(45deg);
		}
		.agree_checkbox+label
		{
		    font-size: 14px;
		    letter-spacing: -0.3px;
		    line-height: 20px;
		    cursor: pointer;
		}
		.agree_checkbox+label a
		{
			text-decoration: none;
		    color: #1389E3;
		}
		.agree_checkbox:checked+label:before
		{
			background:#1389E3;
			border-color:#1389E3;
		}
		.check_container
		{
			position: relative;
		    display: grid;
		    grid-template-columns: 22px auto;
		}
		.newsletter-container{
			margin-top:20px;
		}
		.selected_div,.detail_box:focus-within
		{
			border: 1px solid #1389E3;
		}
		.selected_div .user_header,.detail_box:focus-within .user_header
		{
			color: #1389E3;
		}
		.err_box,.err_box:focus-within{
			border: 1px solid #EE3535;
		}
		.err_box .user_header,.err_box:focus-within .user_header
		{
			color: #EE3535;
		}
		.form_btn
		{
			padding: 0px 30px;
		    font-size: 13px;
		    color: #FFFFFF;
		    font-weight: 600;
		    background: #1389E3;
		    border: none;
		    outline: none;
		    border-radius: 5px;
		    margin-top: 30px;
		    cursor:pointer;
		    text-transform:uppercase;
		    box-sizing: border-box;
	        transition: all 0.3s ease-in-out;
		    height: 40px;
		}
		.form_btn:disabled {
		 	background: #a0d7ff;
		 	pointer-events:none;
		}
		.gray_btn
		{
			color:#969696;
			background:#FFFFFF;
			border:2px solid #E7E7E7;
			margin-left:20px;
		}
		.form_btn:hover,.form_btn:focus
		{
			background:#0777CC;
		}
		.gray_btn:hover,.gray_btn:focus
		{
			border-color:#C7C7C7;
		    color: #777777;
		    background:#fff;
		}
		.or_container
		{
		    border: 2px solid #ECECEC;
		    border-radius: 10px;
		    padding: 20px;
		    position: relative;
		    margin-top: 30px;
		}
		.or_header
		{
			font-size: 14px;
		    color: #111111;
		    letter-spacing: -0.2px;
		    line-height: 24px;
		    font-weight: 500;
		}
		.or_description
		{
			font-size: 12px;
		    color: rgba(17,17,17,0.70);
		    letter-spacing: -0.2px;
		    line-height: 20px;
		    margin-top: 5px;
		}
		.or_tag
		{
			margin: auto;
		    padding: 0px 10px;
		    display: inline-block;
		    position: absolute;
		    background: #FFF;
		    top: -11px;
		    left: 0px;
		    right: 0px;
		    width: fit-content;
		    width: -moz-fit-content;
		    width: -webkit-fit-content;
		}
		.or_button {
		    background: #ECF7FF;
		    border: 1px solid #D9EFFF;
		    padding: 0px 20px;
		    cursor: pointer;
		    margin: auto;
		    line-height: 32px;
		    display: inline-block;
		    position: relative;
		    border-radius: 4px;
		    font-size: 12px;
		    font-weight: 500;
		    color: #0091FF;
		    box-sizing: border-box;
		    height: 34px;
		    margin-right: 0px;
		    margin-left: 30px;
		    white-space: nowrap;
		    text-transform: uppercase;
		}
		.hook {
		    width: 30px;
		    height: 30px;
		    border: 2px solid #ECECEC;
		    border-radius: 50%;
		    text-align: center;
		    line-height: 26px;
		    box-sizing: border-box;
		    position: absolute;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		    top: 0px;
		    bottom: 0px;
		    background: #fff;
		    font-size: 12px;
		    color: #979797;
		}
		.separating_line {
		    width: 2px;
		    height: 100%;
		    display: block;
		    background: #ECECEC;
		    position: absolute;
		    top: 0px;
		    bottom: 0px;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		}
		.zoho_acc
		{
			flex:1;
		}
		.IDP_account
		{
			flex:1;
			text-align:right;
		}
		.acc_header
		{
			font-size:14px;
			line-height:18px;
			color:#969696;
			font-weight: 500;
		}
		.acc_email {
			font-size: 14px;
		    margin-top: 5px;
		    line-height: 16px;
		    word-break: break-word;
		    max-width: calc(100% - 15px)
		}
		.zoho_acc .acc_email
		{
		    margin-right: 15px;
		}
		.IDP_account .acc_email
		{
		    margin-left: 15px;
		}
		.change_option
		{
			color: #0091FF;
			font-size: 14px;
			margin-top:5px;
			font-weight: 500;
			cursor:pointer;
			display: inline-block;
		}
		.info_btn
		{
			position: relative;
		    color: #969696;
		    margin-left: 5px;
		    top: 1px;
		}
		.info_btn:hover
		{
			color:#000000b3;
		}
		.info_btn:after
		{
			    
			    margin-left: 5px;
			    color: #969696;
			    cursor: pointer;		
		}
		.info_btn:before
		{
			cursor:pointer;
		}
		.info_detail{
		    position: absolute;
		    width: 200px;
		    text-align: left;
		    background: #fff;
		    padding: 10px;
		    box-shadow: 0px 0px 16px #DFDFDF;
		    border: 1px solid #E5E5E5;
		    font-size: 12px;
		    border-radius: 8px;
		    right: -14px;
		    top: 24px;
		    line-height:16px;
		    color:#000000cc;
	        font-family: 'ZohoPuvi', Georgia;
			display:none;
		}
		.info_btn:after
		{
		    content: "";
		    display: none;
		    position: absolute;
		    background: #fff;
		    width: 10px;
		    height: 10px;
		    top: 19px;
		    border: 1px solid #E5E5E5;
		    border-right: transparent;
		    border-bottom: transparent;
		    right: 2px;
		    transform: rotate(45deg);
		}
		.info_btn:hover .info_detail,.info_btn:hover:after
		{
			display:block;
		}
		.DC_note,.change_DC
		{
			font-size: 14px;
			color: rgba(0,0,0,0.80);
			letter-spacing: -0.2px;
			line-height: 20px;
		}	
		.DC_note
		{
			margin-bottom:5px;
		}
		.DC_note span,.info_detail span
		{
		    text-transform: capitalize;	
		}
		.profile-img{
		    width: 64px;
		    height: 64px;
		    border-radius: 50%;
		    overflow: hidden;
		    position:relative;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    z-index: 3;
		}
		.profile-img .pro_pic_blur
		{
			filter: blur(5px);
		    position: absolute;
		    height: 100%;
		    width: 100%;
		    background-size: 100% 100%;
		}
		.profile-img img
		{
		    height: 100%;
		    width: 100%;
		    margin: auto;
		    position: relative;
		    z-index: 1;
		    display: block;
		}
		.permission_icon {
		    margin-right: 5px;
		    font-size: 14px;
		    position: relative;
		    top: 1px;
		}
		.selection
		{
		    border-radius: 2px;
		    font-size:14px;
		}
		.pic {
			width: 20px;
			height: 14px;
			background-size: 280px 252px;
			background-image: url("<%=StaticContentLoader.getStaticFilePath("/v2/components/images/Flags.png")%>");
			background-position: -180px -238px;
			float: left;
			margin-top: 1px;
		}
		.user_detail_input .customOtp {
		    border: none;
		    outline: none;
		    background: transparent;
		    height: 100%;
		    font-size: 14px;
		    text-align: left;
		    width: 20px;
		    padding: 0px;
		}
		.customOtp::placeholder {
		  color:#0000001a;
		}
		.customOtp:-ms-input-placeholder {
		  color: #0000001a;
		}
		.customOtp::-ms-input-placeholder {
		  color: #0000001a;
		}
		.resend_text
		{
			font-size: 12px;
			cursor:pointer;
		    color: #0091FF;
		    font-weight: 500;
	        display: inline-block;
		}
		.resend_otp_blocked
		{
		    color: #00000099;
	        cursor: default;
		}		
		.photo_permission_option
		{
			position: relative;
		    display: inline-block;
		    margin-right:16px;
		}
		.photo_permission .selectbox{
			opacity:.8;
		}
		.photo_permission .selectbox:hover,.photo_permission .selectbox--open{
			opacity:1;
		}
		.flex_link_container
		{
			display:flex;
			flex-wrap:nowrap;
		}
		.container_blur
		{
			display: block;
			position: absolute;
			left: 0px;
			right: 0px;
			bottom: 0px;
			top: 0px;
			height: 100%;
			width: 100%;
			background: #fff;
			z-index: 5;
			opacity: 0.9;
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
		.loading_round
		{
			border: 3px solid transparent;
		    border-radius: 50%;
		    border-top: 3px solid #1389E3;
		    border-right: 3px solid #1389E3;
		    border-bottom: 3px solid #1389E3;
		    width: 26px;
		    height: 26px;
		    -webkit-animation: spin 1s linear infinite;
		    animation: spin 1s linear infinite;
		    z-index: 4;
		    position: absolute;
		    top: 0px;
		    left: 0px;
		    bottom: 0px;
		    right: 0px;
		    margin: auto;
		    box-sizing: border-box;
		}
		.user_name_desc_text
		{
			font-size:14px;
			margin-top:10px;
			line-height:24px;
		}
		.country_300_width
		{
			width:300px !important;
		}
		.tos_error
		{
		    color: #EE3535;
			font-size: 14px;
			margin-top: 10px;
			display: none;
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
		
		.error_msg
		{
			cursor: pointer;
		    display: none;
		    position: fixed;
		    font-size: 14px;
		    max-width: 400px;
		    box-sizing: border-box;
		    z-index: 100;
		    background-color: #fff;
		    border-radius: 25px;
		    margin: auto;
		    margin-top: 10px;
		    box-shadow: 0px 0px 10px 0px #ccc;
		    right: 0px;
		    left: 0px;
		    top: -100px;
		    transition: all .2s ease-in-out;
		    width: fit-content;
    		width: -moz-fit-content;
		    width: -webkit-fit-content;
		}
		.err_icon_aligner {
		    display: table-cell;
		    width: 56px;
		    vertical-align: middle;
		}
		.error_msg_cross {
		    display: inline-block;
		    float: right;
		    height: 36px;
		    width: 36px;
		    margin: 7px 10px;
		    background-color: #ff5555;
		    border-radius: 50%;
		    box-sizing: border-box;
		    padding: 11px;
		    position: relative;
		}
		.crossline1 {
		    display: inline-block;
		    position: relative;
		    height: 14px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(-45deg);
		    left: 6px;
		}
		.crossline2 {
		    display: inline-block;
		    position: relative;
		    height: 14px;
		    width: 2px;
		    background-color: #fff;
		    margin: auto;
		    transform: rotate(45deg);
		    left: 4px;
		}
		.error_msg_text {
		    font-size: 13px;
		    line-height: 18px;
		    display: table-cell;
		    float: left;
		    padding: 16px 20px 16px 0px;
		    width: 100%;
		    box-sizing: border-box;
		}
		.sucess_msg .error_msg_cross {
			background-color: #20ba51;
		}
		.sucess_msg .tick {
			display: inline-block;
			position: relative;
			height: 5px;
			width: 11px;
			background-color: transparent;
			border-left: 2px solid #fff;
			border-bottom: 2px solid #fff;
			margin: auto;
			transform: rotate(-45deg);
			top:2px;
		}
		
		#user_mobile
		{
			text-indent:50px;
			transition: all 0.3s ease-in-out;
		}
		
		.mobile_country_select
		{
			position:relative;	
		}
		.otp_sent:before
		{
		    content: "";
		    width: 10px;
		    box-sizing: border-box;
		    margin-right: 5px;
		    border: 2px solid #0091FF;
		    height: 5px;
		    border-top: 2px solid transparent;
		    border-right: 2px solid transparent;
		    transform: rotate(-50deg);
		    position: relative;
		    top: -3px;
		    display: inline-block;
		}
		.otp_senting:before {
		    width: 10px;
		    height: 10px;
		    top: 0px;
		    border-radius: 10px;
		    border-top: 2px solid #0091FF;
		    -webkit-animation: spin 1s linear infinite;
		    animation: spin 1s linear infinite;
		}
		.uvselect .country_select_container{
			height:56px;
		}
		
		.uvselect .select_label{
			font-size:10px;
			font-weight: 500;
    		color: #00000080;
		}
		
		.uvselect .basic_selectbox{
			border: 0px;
   	 		height: 20px;
		}
		
		.uvselect .selectbox{
			min-height:unset;
		}
		
		.uvselect .leading_icon{
			margin:0px;
			margin-left:3px;
		}
		
		.uvselect .basic_selectbox , .uvselect .basic_selectbox:focus , .uvselect .basic_selectbox:hover{
			border:0px;
		}
		
		.uvselect .selectbox_arrow{
			margin: 0px;
   			margin-left: 30px;
		}
		
		.uvselect input[jsid="state_list"]{
			padding:0px;
		}
		
		
		.uvselect .select_container_cntry_code{
			margin-left: 0px;
		}
		
		input[jsid="user_mobile_country"].select_input{	
			padding: 0px;
    		width: 50px !important;
    	}
    	
    	.uvselect .mobile_country_select ,  .uvselect.user_mobile_country{
    		margin: 0px;
    	}
    	   
    	.mobile_country_select .selectbox_arrow{
    		margin: 0px;
    		margin-top: 7px;
    	}
    	
    	.photo_permission_option .uvselect  {
		    width: 38px !important;
    		height: 24px;
    		position:absolute;
    		top: 0px;
    		right: 0px;
    		z-index: 4;
		}
		
		.photo_permission_option .selectbox_arrow{
			margin-left:5px;
			margin-top:9px;
		}
		
		.photo_permission_option .basic_selectbox{
			height:24px;
		}
		
		#photo_perm_icon{
			padding: 4px 0px 4px 7px;
		    line-height: unset;
		    max-width: unset;
		    height: 24px;
		    box-sizing: border-box;
		    color: #666;
		    display: inline-block;
    	}
    	
    	.photo_permission_option .basic_selectbox{
    		border-radius: 12px;
    		box-shadow: 1px -1px 2px #00000021;
    	}
    	
    	.selectbox_options_container--open .photo_perm_list_icon{
    		display:inline-block;
    		margin-right:5px;
    	}
    	
    	.dcOptionDiv input[jsid="dc_option"]{
    		padding-left:0px
    	}
    	
    	.user_mobile_country_mobilemode{
    		width:50px;
    		height:20px;
    		position : absolute;
    		left:10px;
    		top:26px;
    		font-size:14px;
    		line-height:20px;
    	}
    	
    	.user_mobile_country_mobilemode:after{
    	    content: "";
		    display: inline-block;
		    width: 0px;
		    height: 0px;
		    border-right: 3px solid transparent;
		    border-left: 3px solid transparent;
		    border-top: 3.5px solid #666;
		    float: right;
		    position: relative;
		    top: 8px;
		}
		.profile_container{
			display:flex;
		}
		.select_container{
			width:230px;
		}
		.org_mail_alert{
		    border: 1px solid #EBBF6D;
		    padding: 12px 16px;
		    background: #FFF2DB;
		    border-radius: 4px;
		    margin-bottom:24px;
	        grid-template-columns: 24px auto;
	        margin-top: -12px;
		}
		.org_mail_alert .agree_checkbox+label:before{
		    top: 12px;
    		left: 16px;
    		border-color: #EBBF6D;
		}
		.org_mail_alert .agree_checkbox:checked+label:before{
		    border-color: #1389E3;
		}
		.org_mail_alert .agree_checkbox+label:after{
			top: 14px;
   			left: 21px;
		}
		.org_mail_alert .agree_checkbox+label{
			font-size: 12px;
    		letter-spacing: unset;
    		line-height:18px;
		}
		.org_mail_alert.check_container:after {
		    content: "";
		    display: inline-block;
		    width: 6px;
		    height: 6px;
		    position: absolute;
		    top: -4px;
		    border-right: 1px solid #EBBF6D;
		    border-top: 1px solid #EBBF6D;
		    transform: rotate(-45deg);
		    background: #FFF2DB;
		    left: 30px;
		}
		
   		@media only screen and (max-width : 435px)
		{
			.main
			{
			    width: 100%;
		        height: 100%;
			    margin-top: 0px;
			    margin-bottom: 0px;
    			border-radius: 0px;
			}
			.inner-container
			{
			    height: calc(100% - 130px);
			    overflow: auto;
			    border-radius: 30px 30px 0px 0px;
			    padding: 30px;
			}
			.detail_box,.form_btn
			{
				width:100% !important;
			}
			.gray_btn
			{
				margin-left:0px;
			}
			.IDP_account,.zoho_acc
			{
			    width: 100%;
			    flex:unset;
			}
			.separating_line
			{
				width: 100%;
			    height: 2px;
			}
			.IDP_account
			{
				margin-top:50px;
			    text-align: left;
			}
			.associate_account_detail,.flex_link_container
			{
				flex-wrap:wrap;
			}
			.or_button
			{
				margin-top: 20px;
			    margin-left: 0px;
			}
			.dcOptionDiv .user_header:after{
			    content: "";
			    display: inline-block;
			    width: 0px;
			    height: 0px;
			    border-right: 3px solid transparent;
			    border-left: 3px solid transparent;
			    border-top: 3.5px solid #666;
			    float: right;
			    position: relative;
			    top: 18px;
			}
			.zoho_acc .acc_email,.IDP_account .acc_email
			{
			    margin-right: 0px;
			    margin-left: 0px;
			}
			.info_detail
			{
			    left: 0px;
			    transform: translate(-60%, 0px);
				right:0px;
			}
			
				#user_mobile{
				width: calc(100% - 60px);
				text-indent:0px;
			}
			
			#user_mobile_country{
				opacity:0;
			}
			
			#dc_option{
				width:100%;
			}
			
			#dc_option, #dc_option:focus{
				border:none;
				outline:none;
			}
			
			select {
				-webkit-appearance: none;
  				-moz-appearance	: none;
  				-ms-appearance : none;
				appearance: none;
			}
		}

		
		</style>
		<title><%=Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title>
		<script>
		<%String servicename = (String) request.getAttribute("servicename");
			String emailId = (String) request.getAttribute(FSConsumerUtil.OAUTH_EMAIL_ID);
			int newsletter_mode = request.getAttribute("newsletterMode") != null ? (Integer)request.getAttribute("newsletterMode") : -1; 
			emailId = emailId != null ? emailId : "";
			Boolean skipDCSwitch = Boolean.TRUE == request.getAttribute("skipDCSwitch");
			DCLocation remoteDeployment = skipDCSwitch ? DCLUtil.getPresentLocation() : DCLUtil.getRemoteDeployment(request);
			String dcLocation = remoteDeployment != null ? remoteDeployment.getLocation() : null;
			String signupDefaultMode = GeoDCConfiguration.FEDERATED_SIGNUP_MODE.getConfigValue(dcLocation, servicename);
			signupDefaultMode = Util.isValid(signupDefaultMode) ? signupDefaultMode : GeoDCConfiguration.FEDERATED_SIGNUP_ENABLED_MODE.getConfigValue(dcLocation); 
			SignupMode signupMode = SignupMode.getEnum(signupDefaultMode);
			int otp_length = MailUtil.Generator.VerificationCode.getLength();
			if (signupMode == null || !signupMode.isFederatedMode) { // Taking default mode, If any invalid mode was configured
				signupMode = SignupMode.SIGNUP_WITHOUT_PASSWORD_USING_EMAIL;
			}
			if (!IAMUtil.isValidEmailId(emailId) && signupMode.isEmailRequired && !signupMode.isOTPRequired) {
				// Bugbounty issue https://bugbounty.zoho.com/bb/#/bug/101000005457293
				// Adding OpenId to an unverified email account leads to account takeover. So verifying email via OTP
				signupMode = SignupMode.SIGNUP_WITH_EMAIL_OTP;
			}
			Boolean isEmailRequired = signupMode.isEmailRequired; 
			Boolean isMobileRequired = signupMode.isMobileRequired; 
			Boolean isOTPRequired = signupMode.isOTPRequired; 
			Boolean isRecoveryRequired = signupMode.isRecoveryRequired; 
			Boolean isAssociate = request.getAttribute("isAssociateAction") == null ? false : true;
			String termsOfServiceUrl = null;
			String privacyPolicyUrl = null;
			String redirectURL = null;
			String userEmail = null;
			String federatedID = null;
			String name = (String) request.getAttribute(FSConsumerUtil.OAUTH_NAME);
			String IDP_name = (String) request.getAttribute(FSConsumerUtil.OAUTH_PROVIDER);
		    String contextpath = request.getContextPath();
			Boolean hasAccount = false;
			Boolean isMobile = Util.isMobileUserAgent(request);
			Boolean isNameFieldOptional = IDP_name.equals(OAuth2ProviderConstants.APPLE.name());
			String default_country=Util.getCountryCodeFromRequestUsingIP(request);
			JSONArray countryDialingList = DataHandler.getInstance().getCountryAndDialingCodeDetails();
			if(name == null) {
				name = "";
			}
			if(!isAssociate){
			    termsOfServiceUrl = Util.getTermsOfServiceURL(request, servicename);
			    privacyPolicyUrl = Util.getPrivacyURL(request, servicename);
				redirectURL = FSConsumerUtil.constructSignInURLFromReq(request, null);
				hasAccount = request.getAttribute("userExist") != null && (Boolean) request.getAttribute("userExist");
			}
			else{
				userEmail = (String) request.getAttribute("userEmailID");
				federatedID = (String) request.getAttribute("userFederatedID");
			}
			%>
		var countryDialingList = <%=countryDialingList%>;
		</script>
	</head>

	<body>
		<div class="error_msg " id="new_notification" onclick="Hide_Main_Notification()">
			<div style="display:table;width: 100%;">
				<div class="err_icon_aligner">
					<div class="error_msg_cross">
					</div>
				</div>
				<div class="error_msg_text"> 
					<span id="succ_or_err"></span>
					<span id="succ_or_err_msg">&nbsp;</span>
				</div>
			</div>
		</div>
		<div class="bg_one" id="bg_one"></div>
		<div align="center" id="main_container" class="main container">
			<div class="container_blur">
				<div class="loading_round"></div>
			</div>
			<div class="inner-header">
				<div class="header_bg">
					<div class="bg_rectangle"></div>
					<div class="center_semi_circle"></div>
					<div class="small_circle"></div>
					<div class="right_circle"></div>
				</div>
				<div class="IDP_log_container">
					<div class="IDP_logo zoho_icon zohologo">
					</div>
					<div class="other_IDPs">
						<div class="IDP_logo icon-<%=IDP_name.toLowerCase()%>">
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
			<div class="inner-container">
				<%if(isAssociate){%>
				<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.TITLE")%></div>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.DESCRIPTION",IDP_name.toLowerCase())%></div>
				<div class="or_container">
					<div class="show_linking_accounts">
						<span class="separating_line"></span>
						<div class="hook icon-link"></div>
						<div class="associate_account_detail" style="display:flex">
							<div class="zoho_acc">
								<div class="acc_header"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.ACCOUNT.TITLE")%></div>
								<div class="acc_email"><%=userEmail != null ? IAMEncoder.encodeHTML(userEmail) : ""%></div>	<%--No I18N--%>
							</div>
							<div class="IDP_account">
								<div class="acc_header"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ASSOCIATE.IDP.ACCOUNT.TITLE",IDP_name.toLowerCase())%></div>
								<%
								String fedID = federatedID != null ? IAMEncoder.encodeHTML(federatedID) : "";
								if(IAMUtil.isValidEmailId(federatedID)){
								%>
									<div class="acc_email"><%=fedID%></div>	<%--No I18N--%>
								<%}else{ %>
									<div style="position:relative" class="acc_email">ID - <%=fedID%><span class="info_btn icon-info"><span class="info_detail"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.IDP.ID.INFO",IDP_name.toLowerCase())%></span></span></div>	<%--No I18N--%>
								<%} %>
								
							</div>
						</div>
					</div>
				</div>
				<div class="button_container">
					<button id="associateFormAddBtn" class="form_btn" onclick="associateUser()"><%=Util.getI18NMsg(request,"IAM.CONTINUE")%></button>
					<button class="form_btn gray_btn" onclick="cancelAssociateOption()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
				</div>
				<%}
				else if(hasAccount){%>
						<div>
							<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.ACCOUNT.ALREADY.EXISTS")%></div>
							<div class="user_name_desc_text"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.OPTION.DESC",IAMEncoder.encodeHTML(emailId),IDP_name.toLowerCase())%></div>
						</div>
						<div class="button_container">
							<button class="form_btn" onclick="iamMoveToSignin('<%=redirectURL%>','<%=IAMEncoder.encodeHTMLAttribute(emailId)%>')"><%=Util.getI18NMsg(request,"IAM.CONTINUE")%></button>
							<button class="form_btn gray_btn" onclick="cancelFederateFlow()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
						</div>
				<%}
				else{ %>
				<div class="federated_signup_form">
				<form onsubmit="javascript:return false;" novalidate>
				<div class="profile_container">
				<div class="photo_permission_option">
					<div class="profile-img" id="profile-pic">
	   					<div class="pro_pic_blur"></div>
	   					<img src="<%=StaticContentLoader.getStaticFilePath("/v2/components/images/user_2.png")%>" width="100%" height="100%" title="" alt="" onerror="handleProPicError()"/> <%-- NO OUTPUTENCODING --%>
	   				</div>
	   				<select id="photo_permission" style="display: none">
   						<option value="1" id="Zohousers"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.ZOHO_USERS")%></option>
   						<option value="4" id="Contacts"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.CHAT_CONTACTS")%></option>
   						<option value="3" id="Everyone"><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.EVERYONE")%></option>
   						<option value="0" id="Myself" selected><%=I18NUtil.getMessage("IAM.PHOTO.PERMISSION.ONLY_MYSELF")%></option>
   					</select>
   				</div> 
				<div class="text_abt_profile">
				<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.CREATE.WELCOME",IAMEncoder.encodeHTML(name))%></div>
				<%if(!IAMUtil.isValidEmailId(emailId)){%>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.PAGE.DESC")%></div>	
				<%}else{ %>
				<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.PAGE.EMAIL.DESC",IAMEncoder.encodeHTML(emailId))%></div>
				<%} %>
				</div>
				</div>
				<div class="user_detail_form">
				<%if(!isNameFieldOptional){%>
					<div class="detail_box">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.FIRST.NAME")%></div>
						<input type="text" id="user_first_name" maxlength="100" class="user_detail_input" placeholder="<%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.FIRSTNAME")%>" value="<%=IAMEncoder.encodeHTML((String)(request.getAttribute(FSConsumerUtil.OAUTH_FIRST_NAME) != null ? request.getAttribute(FSConsumerUtil.OAUTH_FIRST_NAME) : ""))%>"/>
					</div>
					<div class="detail_box">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.LAST.NAME")%></div>
						<input type="text" id="user_last_name" maxlength="100" class="user_detail_input" placeholder="<%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.LASTNAME")%>" value="<%=IAMEncoder.encodeHTML((String)(request.getAttribute(FSConsumerUtil.OAUTH_LAST_NAME) != null ? request.getAttribute(FSConsumerUtil.OAUTH_LAST_NAME) : ""))%>" />
					</div>
				<%}
				if(!IAMUtil.isValidEmailId(emailId) && isEmailRequired && !isMobileRequired){%>
					<div class="detail_box" style="">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.EMAIL.ADDRESS")%></div>
						<input type="text" id="user_email_id" oninput="resetMailCheck()"  class="user_detail_input" onblur="checkOrgEmail(this)" placeholder="<%=Util.getI18NMsg(request, "IAM.USER.ENTER.EMAIL.PLACEHOLDER")%>"/>
					</div>
				<%} 
				if((isMobileRequired && !isEmailRequired) || isRecoveryRequired || (isMobileRequired && isEmailRequired && !IAMUtil.isValidEmailId(emailId))){ %>
					<div class="detail_box mobile_country_select" id="mobile_country_select">
					<%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.EMAIL.ADDRESS.OR.MOBILE")%></div>						
					<%}else{%>
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.MOBILE")%></div>	
					<%}%>
						<div class="user_mobile_country_mobilemode"></div>
						<select id="user_mobile_country" <%if(isMobile){%>onchange="change_label_mobile(this)" style="width:50px;height:20px;opacity:0;"<%}else{%>oninput=""<%}%> class="user_detail_input">
						</select>
						<input type="text" id="user_mobile" maxlength="15" <%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>oninput="checkEmailOrPhone(this)" onblur="checkOrgEmail(this)"<%}else{%>oninput="cursorIndent();this.value = this.value.replace(/[^\d]+/g,'')"<%}%> class="user_detail_input" value=""/>
					</div>			
				<%}%>
					<div class="alert_abt_org_mail" style="width:100%;display:none">
					<%if(IAMUtil.isValidEmailId(emailId)){%>
						<div class="detail_box disbled_detail" style="">
							<div class="user_header"><%=Util.getI18NMsg(request, "IAM.EMAIL.ADDRESS")%></div>
							<input type="text" id="" class="user_detail_input" disabled value="<%=IAMEncoder.encodeHTMLAttribute(emailId)%>"/>
						</div>
					<% } %>
						<div class="org_mail_alert check_container" style="position:relative;">
							<input tabindex="1" class="agree_checkbox" onchange="handleOrgMailCreation(this)" type="checkbox" id="org_mail" name="org_mail"/>
							<label for="org_mail"></label>
						</div>
					</div>
				</div>
				<%
				boolean hideDC = Boolean.TRUE == request.getAttribute("hideDC");
				String currentDC = "";
				String UserIPCountry = new Locale("",default_country.toUpperCase()).getDisplayCountry();
				boolean showRemote = remoteDeployment!=null && AccountsConfiguration.getConfigurationTyped("fs.multidc.location.choice", false); // No I18N
				if(remoteDeployment!=null){
					currentDC = remoteDeployment.getDescription().toUpperCase();
				} else {
					currentDC = DCLUtil.getPresentLocation().getDescription().toUpperCase();
				} %>
				<div style="margin-bottom:30px;font-size:14px;" class="show_cur_dc <%if(!hideDC && showRemote){%>hide<%}%>"><%=I18NUtil.getMessage("IAM.CROSSDC.SIGNUP.IP.SPECIFIC.DATACENTER.CONTENT", UserIPCountry, currentDC)%></div>
				<%
				if(!hideDC && showRemote) {
				%>
    			<div style="margin-bottom:30px;">
					<div class="DC_note"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.DATA.CENTER.IP.DESC",UserIPCountry)%></div>
					<div class="change_dc"><%=Util.getI18NMsg(request, "IAM.MULTIDC.SIGNUP.DATACENTER.CONTENT", currentDC)%> <span style="color:#0091FF;cursor:pointer" class="change_dc_btn" onclick="showDcOption(this)"><%=Util.getI18NMsg(request, "IAM.SIGNUP.CHANGE")%></span></div>
				</div>
				<div class="dcOptionDiv detail_box" style="display:none;" id="dc_option_div">
					<div class="user_header"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.DATA.CENTER.TITLE")%></div>
					<select id="dc_option" onchange="changeDCText(this)" class="signup-country">
						<option value="<%=remoteDeployment.getLocation().toLowerCase()%>"><%=currentDC%></option>
						<option value="<%=DCLUtil.getLocation().toLowerCase()%>"><%=DCLUtil.getPresentLocation().getDescription().toUpperCase()%></option>
					</select>
				</div>
    			<%
    			}
				%>
				<div class="tos-container check_container">
						<input tabindex="1" class="agree_checkbox" type="checkbox" id="tog_agree" name="agree" value="true"/>
						<label for="tog_agree"><%=Util.getI18NMsg(request, "IAM.SIGNUP.AGREE.TERMS.OF.SERVICE", termsOfServiceUrl, privacyPolicyUrl)%></label>
				</div>
				<div class="newsletter-container check_container">
						<input tabindex="1" class="agree_checkbox" type="checkbox" id="newsletter" name="newsletter" value="true"/>
						<label for="newsletter"><%=Util.getI18NMsg(request, "IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1",Util.getI18NMsg(request,"IAM.ZOHOCORP.LINK"))%></label>
				</div>
				<div class="tos_error"><%=Util.getI18NMsg(request, "IAM.ERROR.TERMS.POLICY") %></div>
				<button id="createFormAddBtn" class="form_btn" onclick="createUser()"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.CREATE.ACCOUNT.BUTTON") %></button>
				</form>
				<div class="link_account_option">
					<div class="or_tag"><%=Util.getI18NMsg(request, "IAM.OR") %></div>	<%--No I18N--%>
					<div class="flex_link_container">
						<div>
							<div class="or_header"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.LINK.ACCOUNT.OPTION.TITLE") %></div>	<%--No I18N--%>
							<div class="or_description"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.LINK.ACCOUNT.OPTION.ABOUT", IDP_name.toLowerCase()) %></div>
						</div>
						<div class="or_button" onclick="redirectLink('<%=redirectURL%>')"><%=Util.getI18NMsg(request, "IAM.FEDERATED.SIGNUP.ASSOCIATE.LINK.ACCOUNTS.TITLE") %></div>
					</div>
				</div>
				</div>
				<%}%>
				<form class="otp_container" id="otp_container" style="display:none;" onsubmit="verifyOTP(event);return false;">
					<div class="for_email">
						<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.EMAIL")%></div>
						<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.DESCRIPTION.EMAIL")%></div>
					</div>
					<div class="for_mobile">
						<div class="user_name_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.HEADER.MOBILE")%></div>
						<div class="desc_text"><%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.VERIFY.OTP.DESCRIPTION.MOBILE")%></div>
					</div>
					<div class="detail_box" style="margin-top:30px;margin-bottom:10px;">
						<div class="user_header"><%=Util.getI18NMsg(request, "IAM.VERIFY.CODE")%></div>	
						<div type="text" id="verification_otp" class="user_detail_input"></div>
					</div>
					<div class="resend_text" id="otp_resend" onclick="resendVerificationOTP()">
					<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.RESEND.OTP")%>
					</div>
					<div class="resend_text otp_sent" id="otp_sent" style="display:none">
					<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SENDING")%>
					</div>
					<div class="button_container">
						<button class="form_btn" id="otp_verify_btn" type="submit" onclick="verifyOTP(event)"><%=Util.getI18NMsg(request,"IAM.NEW.SIGNIN.VERIFY")%></button>
						<button class="form_btn gray_btn" type="button" onclick="cancelFederateFlow()"><%=Util.getI18NMsg(request,"IAM.CANCEL")%></button>
					</div>
				</form>
			</div>
		</div>
		<footer id="footer"><%@ include file="../unauth/footer.jspf" %></footer>  <%--No I18N--%>
	</body>
	<script>
	
		var contextpath = "<%=contextpath%>";
	    var csrfParam = "<%=SecurityUtil.getCSRFParamName(request)%>";
	    var csrfCookieName= "<%=SecurityUtil.getCSRFCookieName(request)%>";
	    var isMobile = <%=isMobile%>;
	    var isOTPRequired = <%=isOTPRequired%>;
	    var isEmailRequired = <%=isEmailRequired%>;
	    var isMobileRequired = <%=isMobileRequired%>;
	    var isRecoveryRequired = <%=isRecoveryRequired%>;
	    var otp_length = <%=otp_length%>;
	    var setTime;
	    var default_country = "<%=default_country%>";
	    var newsletter_mode = "<%=newsletter_mode%>";
	    window.onload= function(){
		$( "input" ).on({
			  change : function(){removeErr()},
			  keypress: function(){removeErr()}
		});
		var mobile_country_option = "";
		
		countryDialingList.forEach(function(country_obj){
		    if(country_obj.DIALING_CODE){mobile_country_option+="<option data-num='+"+country_obj.DIALING_CODE+"' value='"+country_obj.ISO2_CODE+"' >"+country_obj.DISPLAY_NAME+" ("+country_obj.DIALING_CODE+")</option>";}
		});
		$("#user_mobile_country").html(mobile_country_option);
		$("#user_mobile_country [value='"+default_country+"']").attr("selected","selected");	//no i18n
		if($(".dcOptionDiv select").length>0){
			if(!isMobile){
				$("#dc_option").uvselect({
					"width":"230px",//no i18n
					"dropdown-width":"250px",//no i18n
					"place-options-after" : "dc_option_div"//no i18n
				});
			}
		}

	    <% if(!hasAccount && !isAssociate){
		Object pic_with_logo = request.getAttribute(FSConsumerUtil.OAUTH_PIC_URL);
		String pic_logo_String = IAMUtil.isValid(pic_with_logo) ? pic_with_logo.toString() : "";
		%>
			$("#profile-pic img").attr("src","<%=IAMEncoder.encodeJavaScript(pic_logo_String)%>"); <%-- No I18N --%>
			<%if(!pic_logo_String.isEmpty()){%>	
			$("#profile-pic img").on('load',function(){
				$("#profile-pic .pro_pic_blur").css("background-image","url(<%=pic_logo_String%>)");	//No I18N
				$("#profile-pic img").css({"height":"auto","width":"auto"});	//No I18N
				if($("#profile-pic img").height() > $("#profile-pic img").width()){
					$("#profile-pic img").css({"height":"auto","width":"100%"});	//No I18N
				}
				else{
					$("#profile-pic img").css({"height":"100%","width":"auto"});	//No I18N				
				}
				
				$("#photo_permission").uvselect({
					"dropdown-width": "245px", //No i18N
					"prevent_mobile_style": true, //No i18N
					"onDropdown:select" : function(selected_option){ //No I18N
			    		$("#photo_perm_icon").attr("class","icon-"+selected_option.id); //No I18N
			    	},
					"onDropdown:open" : function(dropdown){ //No I18N
						$(dropdown).find("li:visible").each(function(ind,ele){
						    $(ele).find("p").before("<i class='photo_perm_list_icon icon-"+$(ele).attr("data-id")+"'></i>");		//No I18N
						});
			    	}});
				 $(".photo_permission .selectbox_overlay").after("<i id='photo_perm_icon' class='icon-"+$("#photo_permission option:selected").attr("id")+"'></i>");
				 $(".photo_permission .select_input").hide();
				 <%if(!emailId.isEmpty() && isEmailRequired){%>
					 checkOrgEmail();
				 <%}else{%>	
				 $(".container_blur").hide();
				 <%}%>	
				 $(".photo_permission_option").show();
		    });
			<%}else{%>
				$(".photo_permission_option").hide();
				<%if(!emailId.isEmpty() && isEmailRequired){%>
				 checkOrgEmail();
				 <%}else{%>	
				 $(".container_blur").hide();
				 <%}%>
				$(document.scrollingElement).animate({
			        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
			    }, 0);
			<%}%>
			
			if(!isMobile){
				if($("#user_mobile_country").length>0){
					$("#user_mobile_country").uvselect({
						"searchable" : true, //No i18N
						"dropdown-width": "250px", //No i18N
						"embed-icon-class": "flagIcons", //No i18N
						"country-flag" : true, //No i18N
						"country-code" : true, //No i18N
						"place-options-after" : "mobile_country_select" //No i18N
					});
					cursorIndent();
					$("#user_mobile_country").change(function(){
						cursorIndent();
					});
				}
				$(".user_mobile_country_mobilemode").hide();
			}
			else{
				if($("#user_mobile_country").length>0){
					$(".user_mobile_country_mobilemode").text($("#user_mobile_country option[selected]")[0].dataset.num);
					var length = $(".user_mobile_country_mobilemode").text().length;
					if(length == 2){
						$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:32px !important;"); //No I18N
					}
					else if(length == 3){
						$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:38px !important;"); //No I18N
					}
					else if(length == 4){
						$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:44px !important;"); //No I18N
					}
				}
			}
			
			<%if(isEmailRequired && isMobileRequired && !IAMUtil.isValidEmailId(emailId)){%>
			$(".mobile_country_select .select_container").hide();
			$("#user_mobile").attr("style","text-indent: 0px !important");	//No I18N
			<%}%>
			$(document.scrollingElement).animate({
		        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
		    }, 0);
		<% }else{%>
			$(".container_blur").hide();
		<%}%>
		handleNewsletterField(newsletter_mode);
		setFooterPosition();
		};
		
		<% if(!hasAccount && !isAssociate){%>
		
		function showDcOption(ele){
			$(".change_dc").parent().hide();
			$(".dcOptionDiv").slideDown(300,function(){
				setFooterPosition();
			});
		}
		
		function handleNewsletterField(newsletter_mode) {
				var SHOW_FIELD_WITH_CHECKED = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.SHOW_FIELD_WITH_CHECKED.getType()%>";			<%-- NO OUTPUTENCODING --%>
				var SHOW_FIELD_WITHOUT_CHECKED = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.SHOW_FIELD_WITHOUT_CHECKED.getType()%>";	<%-- NO OUTPUTENCODING --%>
				var DOUBLE_OPT_IN = "<%=AccountsInternalConst.NewsLetterSubscriptionMode.DOUBLE_OPT_IN.getType()%>";								<%-- NO OUTPUTENCODING --%>
				if(newsletter_mode == SHOW_FIELD_WITH_CHECKED) {
			        $('#newsletter').prop('checked', true);			 //No I18N
			        $('.newsletter-container').css('display',''); //No I18N
				} else if(newsletter_mode == SHOW_FIELD_WITHOUT_CHECKED || newsletter_mode == DOUBLE_OPT_IN) {
			        $('#newsletter').prop('checked', false);		 //No I18N
			        $('.newsletter-container').css('display',''); //No I18N
				} else {
			        $('#newsletter').prop('checked', true);			 //No I18N
			        $('.newsletter-container').css('display','none'); //No I18N
				}
		}	
		
		function handleProPicError(){
			$(".photo_permission_option,.photo_permission,.container_blur,.uvselect.photo_permission").hide();
			$(document.scrollingElement).animate({
		        scrollTop: ($("body")[0].scrollHeight-$("body")[0].clientHeight)/2
		    }, 0);
		}
		
		function changeDCText(ele){
			$(".dcOptionDiv,.DC_note").hide();
			if($("#dc_option option:first").val() == $("#dc_option").val()){
				$(".DC_note").show()
			}
			$(".change_dc").parent().show();
			$(".choosed_DC").text($(ele).find("option:selected").html());
		}
		<%}%>
		function addLoadingInButton(ele){
			$(ele).attr("disabled", "disabled").addClass("btn_loading");	//No I18N
		}
		
		function removeBtnLoading(ele){
			$(ele).removeAttr("disabled").removeClass("btn_loading");		//No I18N
		}
		function getToastTimeDuration(msg){
			var timing = (msg.split(" ").length) * 333.3;
			return timing > 3000 ? timing : 3000;
		}
		function showErrorMessage(msg) 
		{
			if(msg!=""	&& msg!=undefined)
			{
				$(".error_msg").show();
				$(".error_msg").removeClass("sucess_msg");
				$(".error_msg").removeClass("warning_msg");
				$("#succ_or_err").html("");
				$("#succ_or_err_msg").html(msg);
				$(".error_msg_cross").html("");
				$(".error_msg_cross").append("<span class='crossline1'></span><span class='crossline2'></span>");
			
				var height =($(".error_msg_text")[0].clientHeight/2)-18;		
				
				$(".error_msg").css("top","60px");		// No I18N

				if(setTime!=""){
					clearTimeout(setTime);
				}
				
				setTime = setTimeout(function() {
					$(".error_msg").css("top","-100px");		// No I18N
				}, getToastTimeDuration(msg));		

			}

		}		
		
		function Hide_Main_Notification()
		{
			$(".error_msg").css("top","-100px");		// No I18N
		}
		
		function IsJsonString(str) {
			try {
				$.parseJSON(str);
			} catch (e) {
				return false;
			}
			return true;
		}
		function handleConnectionError(){
			showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
			removeBtnLoading("button");									//No i18N
			return false;
		}
		function isNameString(str)
		{
			var objRegExp = new XRegExp("^[\\p{L}\\p{M}\\p{N}\\-\\_\\ \\.\\+\\!\\[\\]\\']+$","i")	//No i18N
			return objRegExp.test(str.trim());
		}
		
		function iamMoveToSignin(loginurl,loginid,country_code){
			var oldForm = document.getElementById("signinredirection");
			if(oldForm) {
				document.documentElement.removeChild(oldForm);
			}
			var form = document.createElement("form");
			form.setAttribute("id", "signinredirection");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", loginurl);
		    form.setAttribute("target", "_parent");
			
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "LOGIN_ID");
			hiddenField.setAttribute("value", loginid); 
			form.appendChild(hiddenField);
		    
		    if(country_code){
		        hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "CC");
				hiddenField.setAttribute("value", country_code); 
				form.appendChild(hiddenField);
		    }
			
		   	document.documentElement.appendChild(form);
		  	form.submit();
			return false;
		}
		
		<% if(!hasAccount && !isAssociate){%>
		var user_email = '<%=IAMEncoder.encodeJavaScript(emailId)%>';
		var resend_timer=undefined;
		var view_permission = 3;
		var Z_Authorization = "";
		
		function sendRequestWithCallbackAndHeader(action, params, async, callback,method) {
			if (typeof contextpath !== 'undefined') {
				action = contextpath + action;
			}
		    var objHTTP = xhr();
		    objHTTP.open(method?method:'POST', action, async);
		    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
		    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
		    if(Z_Authorization != ""){
		    	objHTTP.setRequestHeader('Z-Authorization',Z_Authorization);
		    }
		    if(async){
			objHTTP.onreadystatechange=function() {
			    if(objHTTP.readyState==4) {
			    	if (objHTTP.status === 0 ) {
						handleConnectionError();
						return false;
					}
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
		function handleOrgMailCreation(ele){
			if(ele.checked){
				$("#createFormAddBtn").attr("onclick","createUser()").removeAttr("disabled");	//No i18N
			}
			else{
				$("#createFormAddBtn").attr("disabled","disabled");	//No i18N
			}
		}
		var lastEnteredEmail = "";
		var mail_verified = false;
		function checkOrgEmail(ele,continue_to_create){
			<%if(emailId.isEmpty()){%>
				var enteredEmail = "";
			<%}else{%>
				var enteredEmail = "<%=IAMEncoder.encodeJavaScript(emailId)%>";
			<%}%>
			if(ele){enteredEmail = ele.value;}
			if(isEmpty(enteredEmail) || !isEmailId(enteredEmail) || lastEnteredEmail == enteredEmail){return false;}
			var param = {
					"signupvalidate" : {		//No i18N
						"email" : enteredEmail			//No i18N
					}
			}
			sendRequestWithCallback("/webclient/v1/register/field/validate", JSON.stringify(param),true, function(resp){		//No i18N
				$(".container_blur").hide();
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						mail_verified = true;
						if(continue_to_create){
							createUser();
						}
					}
					else{
						if(jsonStr.errors[0] && jsonStr.errors[0].code == "EMAIL105"){
							mail_verified = true;
							$(".org_mail_alert label").html(jsonStr.localized_message);
							$(".alert_abt_org_mail").slideDown(300);
							$("#createFormAddBtn").attr("disabled","disabled");			//No i18N
							$(ele).focus();
						}
						else{
							showErrorMessage(getErrorMessage(jsonStr));
						}
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
			lastEnteredEmail = enteredEmail;
		}
		
		function change_label_mobile(ele){
			$(".user_mobile_country_mobilemode").text($("#"+ele.id+" option[value="+'"'+ele.value+'"')[0].dataset.num);
			var length = $("#"+ele.id+" option[value="+'"'+ele.value+'"')[0].dataset.num.length;
			if(length == 2){
				$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:32px !important;"); //No I18N
			}
			else if(length == 3){
				$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:38px !important;"); //No I18N
			}
			else if(length == 4){
				$("#user_mobile_country , .user_mobile_country_mobilemode").attr("style","width:44px !important;"); //No I18N
			}
		}
		
		function createUser(){
			<%if(!isNameFieldOptional){%>
			var first_name = $("#user_first_name");
			var last_name = $("#user_last_name");
			var name_length = first_name.val().trim().length;
			if(last_name.val().trim() != ""){
				name_length = (first_name.val().trim() + " " + last_name.val().trim()).length;
			}
			if(name_length > 100){
				showErrorMessage('<%=Util.getI18NMsg(request,"IAM.ERROR.FULLNAME.MAXLEN",100)%>');
				return false;
			}
			if(isEmpty(first_name.val().trim())){
				first_name.parents(".detail_box").addClass("err_box");		//No i18N
				first_name.siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.NEW.SIGNUP.FIRSTNAME.VALID")%>'); //No I18N
				return false;
			}
			<%}%>
			if($("#user_email_id").length>0){
				user_email = $("#user_email_id").val().trim();
				if(!isEmailId(user_email)){
					$("#user_email_id").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_email_id").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.AC.CONFIRM.EMAIL.VALID")%>'); //No I18N
					return false;
				}
			}
			<%if((isMobileRequired && !isEmailRequired) || isRecoveryRequired || (isMobileRequired && isEmailRequired && !IAMUtil.isValidEmailId(emailId))){%>
			<%if(isEmailRequired && isMobileRequired && !IAMUtil.isValidEmailId(emailId)){%>
				if(!(/^(?:[0-9] ?){3,1000}[0-9]$/.test($("#user_mobile").val())) && !isEmailId($("#user_mobile").val())){
					$("#user_mobile").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.FEDERATED.SIGNUP.ERROR.EMAIL.OR.MOBILE")%>'); 	//No I18N
					return false;
				}
			<%}else{%>
				if(!(/^(?:[0-9] ?){3,1000}[0-9]$/.test($("#user_mobile").val()))){
					$("#user_mobile").parents(".detail_box").addClass("err_box");		//No i18N
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER")%>'); 	//No I18N
					return false;
				}
			<%}%>
			<%}%>
			if(!$("#tog_agree").is(":checked")){
				$(".tos_error").show();
				return false;
			}
			<%if(isEmailRequired){%>
				if(!mail_verified){
					checkOrgEmail($("#user_email_id").length == 1? $("#user_email_id")[0] : $("#user_mobile")[0],true);
					return false;
				}
			<%}%>
			if($(".photo_permission_option").is(":visible")){
				view_permission = $("#photo_permission").val();
			}
			var param = {
					"federatedsignup" : {									//No i18N
						<%if(isEmailRequired && !isMobileRequired){%>
						"email" : user_email,								//No i18N
						<%}%>
						"viewpermission" : parseInt(view_permission),					//No i18N
						<%if(isEmailRequired && isRecoveryRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"rmobile"		 : $("#user_mobile").val(),			//No i18N
						<%}else if(isEmailRequired && isMobileRequired){%>
							<%if(IAMUtil.isValidEmailId(emailId)){%>
							"emailormobile"		 : user_email,					//No i18N
							<%}else{%>
							"country_code"	 : $("#user_mobile_country").val(),	//No i18N
							"emailormobile"		 : $("#user_mobile").val(),		//No i18N
							<%}
						}else if(isMobileRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"mobile"		 : $("#user_mobile").val(),			//No i18N
						<%
						}
						if(!isNameFieldOptional){%>
						"firstname": $("#user_first_name").val(),			//No i18N
						"lastname": $("#user_last_name").val(),				//No i18N
						<%}%>
						"newsletter": $("#newsletter").is(":checked"),		//No i18N
						"tos" : $("#tog_agree").is(":checked")             //No i18N
					}
				}
			if($(".dcOptionDiv").length>0){
				param.federatedsignup.dclocation = $("#dc_option").val();
			}
			if($("#org_mail").is(":checked")){
				param.federatedsignup.orguser = true;
			}
			addLoadingInButton("#createFormAddBtn");					
			sendRequestWithCallback("/webclient/v1/fsregister/signup", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						if(isOTPRequired){
							$(".federated_signup_form").hide();
							$("#otp_container").show();
							var showMobContent = isMobileRequired || isRecoveryRequired;
							var otpSource = showMobContent ? $("#user_mobile").val() : user_email;
							if(isMobileRequired && isEmailRequired && isEmailId($("#user_mobile").val())){
								showMobContent = false;
								otpSource = $("#user_mobile").val();
							}
							if(jsonStr.federatedsignup.token){
								Z_Authorization = jsonStr.federatedsignup.token;
							}
							if(showMobContent){
								$(".for_email").hide();
								$(".for_mobile").show();
								$(".for_mobile .desc_text").text(formatMessage($(".for_mobile .desc_text").text(),otpSource));
							}
							else{
								$(".for_email").show();
								$(".for_mobile").hide();
								$(".for_email .desc_text").text(formatMessage($(".for_email .desc_text").text(),otpSource));
							}
							splitField.createElement('verification_otp',{
								"splitCount":otp_length,					// No I18N
								"charCountPerSplit" : 1,		// No I18N
								"isNumeric" : true,				// No I18N
								"otpAutocomplete": true,		// No I18N
								"customClass" : "customOtp",	// No I18N
								"inputPlaceholder":'&#9679;'	// No I18N
							});
							$('#verification_otp .customOtp').attr('onkeypress','removeErr()');	// No I18N
							resend_countdown();
							$('#verification_otp').click();
							setFooterPosition();
						}
						else{
							redirectLink(jsonStr.federatedsignup.redirect_uri);
						}
					}
					else{
						removeBtnLoading("#createFormAddBtn");							//No i18N
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					removeBtnLoading("#createFormAddBtn");							//No i18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		
		function cursorIndent(){
			var length = $("#user_mobile_country option:selected").attr("data-num").length;	//No I18N
			if(length == 2){
				$(".uvselect input[jsid='user_mobile_country']").attr("style","width:30px !important;"); //No I18N
			}
			else if(length == 3){
				$(".uvselect input[jsid='user_mobile_country']").attr("style","width:36px !important;"); //No I18N
			}
			else if(length == 4){
				$(".uvselect input[jsid='user_mobile_country']").attr("style","width:42px !important;"); //No I18N
			}	
			//below if block is for leaving empty space for country icon if flagicons.css gets load slowly
			if($(".leading_icon>span").width()== 0){
				$("#user_mobile").attr("style","text-indent:"+($(".uvselect.user_mobile_country").width()+26)+"px"+" !important;"); //No I18N
			}
			else{
				$("#user_mobile").attr("style","text-indent:"+($(".uvselect.user_mobile_country").width()+6)+"px"+" !important;"); //No I18N
			}
		}
		function resetMailCheck(){
			$(".alert_abt_org_mail").hide();
			$("#org_mail").prop("checked",false);		//No i18N
			mail_verified = false;
			$("#createFormAddBtn").removeAttr("disabled");	//No i18N
		}
		
		function checkEmailOrPhone(ele){
			var isMobileNumber = /^(?:[0-9] ?){2,1000}[0-9]$/.test(ele.value);
			resetMailCheck();
			if(isMobileNumber){
				$(".uvselect.user_mobile_country").show(); 
				$("#user_mobile").attr("maxlength","15");	//No I18N
				cursorIndent();
				mail_verified = true;
			}
			else{
				$(".uvselect.user_mobile_country").hide();
				$("#user_mobile").attr("style","text-indent:0px !important;");	//No I18N
				$("#user_mobile").attr("maxlength","100");	//No I18N
			}
		}
		
		function verifyOTP(e){
			e.preventDefault();
			var otp = $("#verification_otp_full_value").val();
			if(isEmpty(otp)|| !isValidCode(otp)){
				$("#verification_otp").parents(".detail_box").addClass("err_box");	//No I18N
				$("#verification_otp").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.ERROR.VALID.OTP")%>'); //No I18N
				return false;
			}
			var param = {
					"federatedsignupotp" : {									//No i18N
						<%if(isEmailRequired && !isMobileRequired){%>
						"email" : user_email,								//No i18N
						<%}%>
						"viewpermission" : parseInt(view_permission),					//No i18N
						<%if(isEmailRequired && isRecoveryRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"rmobile"		 : $("#user_mobile").val(),			//No i18N
						<%}else if(isEmailRequired && isMobileRequired){%>
							<%if(IAMUtil.isValidEmailId(emailId)){%>
							"emailormobile"		 : user_email,					//No i18N
							<%}else{%>
							"country_code"	 : $("#user_mobile_country").val(),	//No i18N
							"emailormobile"		 : $("#user_mobile").val(),		//No i18N
							<%}
						}else if(isMobileRequired){%>
						"country_code"	 : $("#user_mobile_country").val(),	//No i18N
						"mobile"		 : $("#user_mobile").val(),			//No i18N
						<%
						}
						if(!isNameFieldOptional){%>
						"firstname"			: $("#user_first_name").val(),		//No i18N
						"lastname"			: $("#user_last_name").val(),		//No i18N
						<%}%>
						"vercode" 			: otp,								//No i18N
						"newsletter"		: $("#newsletter").is(":checked"),	//No i18N
						"tos" : $("#tog_agree").is(":checked")             //No i18N
					}
				}
			if($(".dcOptionDiv").length>0){
				param.federatedsignupotp.dclocation = $("#dc_option").val();
			}
			addLoadingInButton("#otp_verify_btn");
			sendRequestWithCallbackAndHeader("/webclient/v1/fsregister/otp", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.federatedsignupotp.redirect_uri);
					}
					else{
						removeBtnLoading("#otp_verify_btn");							//No i18N
						showErrorMessage(getErrorMessage(jsonStr));
						$('#verification_otp').click();
					}
				}else{
					removeBtnLoading("#otp_verify_btn");							//No i18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		function resendVerificationOTP(){
			var param = {
					"federatedsignupotp" : {}			//No i18N
			}
			if($(".dcOptionDiv").length>0){
				param.federatedsignupotp.dclocation = $("#dc_option").val();
			}
			$("#otp_resend").hide();
			$("#otp_sent").show().addClass("otp_senting");
			$("#otp_sent").html("<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SENDING")%>");
			
			sendRequestWithCallbackAndHeader("/webclient/v1/fsregister/otp", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						resend_countdown();
						setTimeout(function(){
							$("#otp_sent").removeClass("otp_senting");
							$("#otp_sent").html("<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SUCCESS")%>");
						},1000);
						setTimeout(function(){
							$("#otp_resend").show();
							$("#otp_sent").hide().removeClass("otp_senting");
						},2000);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
						setTimeout(function(){
							$("#otp_resend").show();
							$("#otp_sent").hide().removeClass("otp_senting");
						},2000);
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
					setTimeout(function(){
						$("#otp_resend").show();
						$("#otp_sent").hide().removeClass("otp_senting");
					},2000);
				}
			},"PUT");									//No i18N
		}
		
		function resend_countdown()
		{
			$("#otp_resend").html("<%=Util.getI18NMsg(request, "IAM.RESEND.OTP.COUNTDOWN")%>");
			$("#otp_resend").addClass("resend_otp_blocked");
			$("#otp_resend").attr("onclick","");		//No i18N
			var time_left=59;
			clearInterval(resend_timer);
			resend_timer=undefined;
			resend_timer = setInterval(function()
			{
				$("#otp_resend span").text(time_left);
				time_left-=1;
				if(time_left<=0)
				{
					clearInterval(resend_timer);
					$("#otp_resend").removeClass("resend_otp_blocked");
					$("#otp_resend").html("<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.RESEND.OTP")%>");
					$("#otp_resend").attr("onclick","resendVerificationOTP()");		//No i18N
				}
			}, 1000);
		}
		<%}%>
		
		function cancelFederateFlow(){
			var param = {
					"federatedsignup" : {}					//No i18N
				}
			sendRequestWithCallback("/webclient/v1/fsregister/signup", JSON.stringify(param),true, function(resp){		// No I18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.federatedsignup.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			},"PUT");																	//No i18N
		}
		
		function removeErr(){
			$(".tos_error").hide();
			$(".detail_box").removeClass("err_box");
			if($("#user_email_id")){
				$("#user_email_id").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.EMAIL.ADDRESS")%>'); //No I18N
			}
			if($("#verification_otp")){
				$("#verification_otp").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.VERIFY.CODE")%>'); //No I18N
			}
			if($("#user_mobile")){
				<%if(isEmailRequired && !isRecoveryRequired && !IAMUtil.isValidEmailId(emailId)){%>
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.EMAIL.ADDRESS.OR.MOBILE")%>'); //No I18N
				<%}else{%>
					$("#user_mobile").siblings(".user_header").text('<%=Util.getI18NMsg(request,"IAM.NEW.SIGNIN.MOBILE")%>'); //No I18N
				<%}%>
			}
			<%if(!isNameFieldOptional){%>
			$("#user_first_name").siblings(".user_header").html('<%=Util.getI18NMsg(request,"IAM.FIRST.NAME")%>'); //No I18N
			$("#user_last_name").siblings(".user_header").html('<%=Util.getI18NMsg(request,"IAM.LAST.NAME")%>'); //No I18N
			<%}%>
		}
		<%if(isAssociate){%>
		function associateUser(){
			addLoadingInButton("#associateFormAddBtn");		// No I18N
			var param = {
					"associatefederatedaccount" : {						//No i18N
						"preference" : "associate"						//No i18N
					}
				}
			sendRequestWithCallback("/webclient/v1/fsregister/associate", JSON.stringify(param),true, function(resp){		//No i18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.associatefederatedaccount.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
						removeBtnLoading("#associateFormAddBtn");	// No I18N
					}
				}else{
					removeBtnLoading("#associateFormAddBtn");	// No I18N
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		function cancelAssociateOption(){
			var param = {
					"associatefederatedaccount" : {						//No i18N
						"preference" : "deny"							//No i18N
					}
				}
			sendRequestWithCallback("/webclient/v1/fsregister/associate", JSON.stringify(param),true, function(resp){	//No i18N
				if(IsJsonString(resp)) 
				{
					var jsonStr = JSON.parse(resp);
					var statusCode = jsonStr.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
					{
						redirectLink(jsonStr.associatefederatedaccount.redirect_uri);
					}
					else{
						showErrorMessage(getErrorMessage(jsonStr));
					}
				}else{
					showErrorMessage("<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>");
				}
			});
		}
		
		<%}%>
		
	</script>
</html>