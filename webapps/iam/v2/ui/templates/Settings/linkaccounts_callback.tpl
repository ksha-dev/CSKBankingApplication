	<head>
		<@resource path="/v2/components/css/zohoPuvi.css" />
		<style>

		
		
		@font-face 
		{
			/*======Font file Version : AccountsUI-v1.17===============*/
		  font-family: 'AccountsUI';
		  src:  url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}");
		  src:  url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.eot')}") format('embedded-opentype'),
		    url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.ttf')}") format('truetype'),
		    url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff')}") format('woff'),
		    url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.woff2')}") format('woff2'),
		    url("${SCL.getStaticFilePath('/v2/components/images/fonts/AccountsUI.svg')}") format('svg');
		  font-weight: normal;
		  font-style: normal;
		  font-display: block;
		}
		
		[class^="icon-"], [class*=" icon-"] 
		{
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'AccountsUI' !important;
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
		
		
		.icon-pin:before 
		{
		  content: "\e970";
		  color:#1f88e3;
		}
		
		
		.icon-baidu_L .path1:before {
		  content: "\e95f";
		  color: rgb(35, 25, 220);
		}
		.icon-baidu_L .path2:before {
		  content: "\e960";
		  margin-left: -2.9443359375em;
		  color: rgb(255, 255, 255);
		}
		.icon-baidu_L .path3:before {
		  content: "\e961";
		  margin-left: -2.9443359375em;
		  color: rgb(255, 255, 255);
		}
		.icon-baidu_L .path4:before {
		  content: "\e962";
		  margin-left: -2.9443359375em;
		  color: rgb(225, 6, 1);
		}
		.icon-baidu_L .path5:before {
		  content: "\e963";
		  margin-left: -2.9443359375em;
		  color: rgb(225, 6, 1);
		}
		.icon-baidu_L .path6:before {
		  content: "\e964";
		  margin-left: -2.9443359375em;
		  color: rgb(225, 6, 1);
		}
		.icon-baidu_L .path7:before {
		  content: "\e965";
		  margin-left: -2.9443359375em;
		  color: rgb(225, 6, 1);
		}
		.icon-baidu_L .path8:before {
		  content: "\e966";
		  margin-left: -2.9443359375em;
		  color: rgb(225, 6, 1);
		}
		.icon-feishu_L .path1:before {
		  content: "\e967";
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path2:before {
		  content: "\e968";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path3:before {
		  content: "\e969";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path4:before {
		  content: "\e96a";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path5:before {
		  content: "\e96b";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path6:before {
		  content: "\e96c";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path7:before {
		  content: "\e96d";
		  margin-left: -4.404296875em;
		  color: rgb(0, 0, 0);
		}
		.icon-feishu_L .path8:before {
		  content: "\e96e";
		  margin-left: -4.404296875em;
		  color: rgb(0, 214, 185);
		}
		.icon-feishu_L .path9:before {
		  content: "\e96f";
		  margin-left: -4.404296875em;
		  color: rgb(51, 112, 255);
		}
		.icon-feishu_L .path10:before {
		  content: "\e970";
		  margin-left: -4.404296875em;
		  color: rgb(19, 60, 154);
		}
		.icon-feishu_L .path11:before {
		  content: "\e971";
		  margin-left: -4.404296875em;
		  color: rgb(19, 60, 154);
		}
		.icon-feishu_L .path12:before {
		  content: "\e972";
		  margin-left: -4.404296875em;
		  color: rgb(19, 60, 154);
		}
		.icon-linkedIn_L:before {
		  content: "\e9c6";
		}
		.icon-slack_L .path1:before {
		  content: "\e974";
		  color: rgb(0, 0, 0);
		}
		.icon-slack_L .path2:before {
		  content: "\e975";
		  margin-left: -3.9443359375em;
		  color: rgb(224, 30, 90);
		}
		.icon-slack_L .path3:before {
		  content: "\e976";
		  margin-left: -3.9443359375em;
		  color: rgb(54, 197, 240);
		}
		.icon-slack_L .path4:before {
		  content: "\e977";
		  margin-left: -3.9443359375em;
		  color: rgb(46, 182, 125);
		}
		.icon-slack_L .path5:before {
		  content: "\e978";
		  margin-left: -3.9443359375em;
		  color: rgb(236, 178, 46);
		}
		.icon-yahoo_L:before {
		  content: "\e979";
		}
		.icon-adp_small:before {
		  content: "\e937";
		  color:#ef221d;
		}
		.icon-apple_small:before {
		  content: "\e9a6";
		}
		.icon-baidu_small:before {
		  content: "\e989";
		  color:#2319DC;
		}
		.icon-douban_small:before {
		  content: "\e988";
		  color:#29983b;
		}
		.icon-facebook_small:before {
		  content: "\e987";
		  color:#1177f2;
		}
		.icon-feishu_small .path1:before {
		  content: "\e95c";
		  color: rgb(0, 214, 185);
		}
		.icon-feishu_small .path2:before {
		    content: "\e95d";
		    margin-left: -1em;
		    color: rgb(51, 112, 255);;
		}
		.icon-feishu_small .path3:before {
		 	content: "\e95e";
		    margin-left: -1em;
		    color: rgb(19, 60, 154);
		}
		.icon-google_small .path1:before {
		  content: "\e958";
		  color: rgb(66, 133, 244);
		}
		.icon-google_small .path2:before {
		  content: "\e959";
		  margin-left: -1em;
		  color: rgb(52, 168, 83);
		}
		.icon-google_small .path3:before {
		  content: "\e95a";
		  margin-left: -1em;
		  color: rgb(251, 188, 5);
		}
		.icon-google_small .path4:before {
		  content: "\e95b";
		  margin-left: -1em;
		  color: rgb(234, 67, 53);
		}
		.icon-intuit_small:before {
		  content: "\e945";
		  color:#1d6cff;
		}
		.icon-linkedin_small:before {
		  content: "\e938";
		  color:#0a66c2;
		}
		.icon-qq_small .path1:before {
		 	content: "\e950";
		    color: rgb(250, 171, 7);
		}
		.icon-qq_small .path2:before {
		    content: "\e951";
		    margin-left: -1em;
		    color: rgb(0, 0, 0);
		}
		.icon-qq_small .path3:before {
		    content: "\e952";
		    margin-left: -1em;
		    color: rgb(255, 255, 255);
		}
		.icon-qq_small .path4:before {
		    content: "\e953";
		    margin-left: -1em;
		    color: rgb(250, 171, 7);
		}
		.icon-qq_small .path5:before {
		    content: "\e954";
		    margin-left: -1em;
		    color: rgb(0, 0, 0);
		}
		.icon-qq_small .path6:before {
		    content: "\e955";
		    margin-left: -1em;
		    color: rgb(255, 255, 255);
		}
		.icon-qq_small .path7:before {
			content: "\e956";
		    margin-left: -1em;
		    color: rgb(235, 25, 35);
		}
		.icon-qq_small .path8:before {
		    content: "\e957";
		    margin-left: -1em;
		    color: rgb(235, 25, 35);
		}
		.icon-slack_small .path1:before {
		  content: "\e94c";
		  color: rgb(224, 30, 90);
		}
		.icon-slack_small .path2:before {
		 	content: "\e94d";
		    margin-left: -1em;
		    color: rgb(54, 197, 240);
		}
		.icon-slack_small .path3:before {
		    content: "\e94e";
		    margin-left: -1em;
		    color: rgb(46, 182, 125);
		}
		.icon-slack_small .path4:before {
		 	content: "\e94f";
		    margin-left: -1em;
		    color: rgb(236, 178, 46);
		}
		.icon-twitter_small:before {
		  content: "\e94b";
		  color:#439EF0;
		}
		.icon-wechat_small:before {
		  content: "\e94a";
		  color:#2EC100;
		}
		.icon-weibo_small .path1:before {
		  content: "\e943";
		  color: rgb(255, 255, 255);
		}
		.icon-weibo_small .path2:before {
		  content: "\e944";
		  margin-left: -1em;
		  color:#e60f29;
		}
		.icon-weibo_small .path3:before {
		  content: "\e947";
		  margin-left: -1em;
		  color:#ff9a2f;
		}
		.icon-weibo_small .path4:before {
		  content: "\e948";
		  margin-left: -1em;
		  color:#ff9a2f;
		}
		.icon-weibo_small .path5:before {
		  content: "\e949";
		  margin-left: -1em;
		 color: rgb(0, 0, 0);
		}
		.icon-azure_small .path1:before {
		  content: "\e93a";
		  color: rgb(107, 190, 0);
		}
		.icon-azure_small .path2:before {
		  content: "\e93b";
		  margin-left: -1em;
		  color: rgb(255, 62, 0);
		}
		.icon-azure_small .path3:before {
		  content: "\e941";
		  margin-left: -1em;
		  color: rgb(0, 165, 246);
		}
		.icon-azure_small .path4:before {
		  content: "\e942";
		  margin-left: -1em;
		  color: rgb(255, 183, 0);
		}
		.icon-github_small:before{
		  content:"\e946";
		}
		.icon-yahoo_small:before {
		  content: "\e939";
		  color:#6001D2;
		}
		
		
		
		
		.zoho_icon, .provider_icon
		{
			font-size: 24px;
		    align-items: center;
		    display: flex;
		    margin-right: 8px;
	    }
		
		.icon-zoho_common .path1:before {
		  content: "\e95f";
		  color: rgb(255, 255, 255);
		}
		.icon-zoho_common .path2:before {
		  content: "\e960";
		  margin-left: -1em;
		  color: rgb(249, 178, 29);
		}
		.icon-zoho_common .path3:before {
		  content: "\e961";
		  margin-left: -1em;
		  color: rgb(34, 109, 180);
		}
		.icon-zoho_common .path4:before {
		  content: "\e962";
		  margin-left: -1em;
		  color: rgb(8, 153, 73);
		}
		.icon-zoho_common .path5:before {
		  content: "\e963";
		  margin-left: -1em;
		  color: rgb(228, 37, 39);
		}
		.icon-zoho_common .path6:before {
		  content: "\e964";
		  margin-left: -1em;
		  color: rgb(249, 178, 29);
		}
		
		.icon-Plus:before 
		{
			content: "\e995";
			color:#0071E3;
		}
		
		
		
		body 
		{
		    font-family: 'ZohoPuvi', Georgia;
		    font-weight: 400;
		}

		.zohologo
		{

		    display: flex;
		    height: 40px;
		    margin: auto;
		    margin-bottom: 20px;
		    margin-top: 100px;
		    background: url("${SCL.getStaticFilePath('/v2/components/images/newZoho_logo.svg')}") no-repeat;
		    background-size: auto 40px;
		    background-position: center;	    
		}

		.container
		{
		    display: block;
		    width: 90%;
		    max-width: 600px;
		    height: auto;
		    min-height: 200px;
		    border: 1px solid #EAEAEA;
		    border-radius: 16px;
		    margin: auto;
		    box-sizing: border-box;
		    box-shadow: 3px 6px 30px #00000008;
		    overflow: hidden;
		    padding: 36px 0px;
		}
		
		.content_box 
		{
		    padding: 0px 36px;
		}
		
		.linked_success .status_icon
		{
			background: url("${SCL.getStaticFilePath("/v2/components/images/linked_acc_success_icon.svg")}") no-repeat transparent !important;
		}
		 .status_icon
		{
		background: url("${SCL.getStaticFilePath("/v2/components/images/linked_acc_failed_icon.svg")}") no-repeat transparent !important;
			background-size: 100% 100%;
			height: 88px;
		    width: 222px;
		    margin: auto;
		    margin-bottom: 24px;
		}
		.Z_email_info{
			width: calc(100% - 30px);	
		}
		.header_center
		{
			text-align: center;
    		font-size: 20px;
    		margin-bottom: 8px;
    		font-weight: 600;
		}
		
		.discription_center
		{
			text-align: center;
    		font-size: 14px;
    		line-height: 20px;
    		opacity: 80%;
		}
		
		.link_details
		{
			border: 1px solid #E0E0E0;
		    border-radius: 4px;
		    display: flex;
		    margin-bottom: 12px;
		    margin-top: 24px;
		    justify-content: space-around;
   		}
   		
   		.link_details_tab 
   		{
		    width: calc(50% - 36px);
		    display: flex;
		    margin: 16px;
		}
		
		
		.linked_email {
		    font-size: 12px;
			overflow: hidden;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		}

		.linked_type 
		{
		    font-size: 12px;
		    color: #149AFF;
		    font-weight: 600;
		    margin-bottom: 4px;
		}
		
		
		.linked_msg 
		{
		    font-size: 14px;
    		line-height: 20px;
    		width: calc(100% - 44px);
    		opacity: 70%;
		}
		
		.linked_msg  span
		{
			font-weight: 500;
		}
		
		.linked_note
		{
			display: flex;
			align-items: center;	
		}
		
		.Separation_x 
		{
		    display: flex;
		    align-items: center;
		    font-size: 8px;
		    color:#707070;
		}
		
		.icon-linked:before 
		{
		    content: "\e972";
		}
				
		
		.bullet_pin
		{
		    border-radius: 50%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin-right: 12px;
   			float: left;
   		    width: 32px;
    		height: 32px;
   			background: #DBF0FD;
		}
		
		.blue_btn
		{
			cursor: pointer;
		    display: block;
		    height: 40px;
		    weight: auto;
		    border-radius: 4px;
		    font-size: 14px;
		    font-weight: 600;
		    outline: none;
		    border: none;
		    margin: auto;
		    transition: width .2s ease-in-out;
		    background-color: #159AFF;
		    padding: 0px 24px;
		    margin-top: 24px;
		}
		
		.blue_btn a
		{
			text-decoration:none;
			color: #fff;
		}
		
		
		.blue_text
		{
			color: #1389E3;
		    width: 100%;
		    display: flex;
		    justify-content: center;
		    position: relative;
		    margin-top: 24px;
		    font-weight: 600;
		    cursor: pointer;
		    text-decoration: underline;
		}
		
		.linked_successnotes
		{
			display:none;
		}
		.linked_success .linked_successnotes
		{
			display:block !important;
		}
		
		.expand
		{
			display:none;
			border-top: 1px solid #EAEAEA;
    		margin-top: 24px;
    		padding: 0px 36px;
		}
   		
   		.step_title 
   		{
		    font-size: 14px;
		    color: #2C2C2CCC;
		    font-weight: 600;
		}
		
		.expand_head 
		{
		    font-size: 16px;
		    text-decoration: underline;
		    font-weight: 600;
		    margin: 24px 0px;
		}
		
		.step_head
		{
		    display: flex;
		    justify-content: left;
		    align-items: center;
		}
		
		.step_point 
		{
		    width: 14px;
		    height: 14px;
		    display: flex;
		    background-color: #F0F9FF;
		    border-radius: 50%;
		    margin-right: 8px;
		    justify-content: center;
		    align-items: center;
		}
		
		.step_point:after 
		{
		    content: "";
		    height: 8px;
		    width: 8px;
		    border: 1px solid #6BB4EB;
		    border-radius: 50%;
		    background-color: #FFFFFF;
		    box-sizing: border-box;
		}
		
		ol
		{
    		margin-left: 7px;
		}
		
		.list_border
		{
			background-image: linear-gradient(to bottom, #A6D0F0 56%, rgba(255,255,255,0) 0%);
    		background-position: left;
    		background-size: 1px 14.5px;
    		background-repeat: repeat-y;
		}
		
		ol li 
		{
		    margin-left: 7px;
		    font-size: 14px;
		    margin-bottom: 12px;
		    padding-left: 5px;
		    line-height: 18px;
		}
		
		li span
		{
			font-weight:500;
		}
		
		.last_list
		{
			margin-bottom: 0px;
		}
		
		.last_list li
		{
			margin-bottom: 0px;
		}
		
		@media only screen and (max-width : 450px)
		{
		
			.zohologo 
			{
				margin-top: 40px;
				margin-bottom: 30px;
			}
			
			.container
			{
				width: 100%;
				border: unset;
				box-shadow: unset;
				padding: 0px;
			}
			
			.linked_msg 
			{
				width: calc(100% - 24px);
			}
			
			.linked_email 
			{
    			font-size: 14px;
    		}
    		
    		.expand 
    		{
    			margin: 24px 36px;
    			padding:0px;
    		}
			
			.bullet_pin 
			{
			    margin-right: 8px;
			    align-items: normal;
			    margin-top: 4px;
			}
			
			.link_details 
			{
				flex-direction: column;
				padding: 20px 0px;
				margin-bottom: 16px;
			}
			
			.link_details_tab 
			{
    			width: auto;
    			margin: 20px;
    			margin: 0px 20px;
    		}
    		
    		.Separation_x 
    		{
			    width: 100%;
			    justify-content: center;
			    margin: 14px 0px;
			}
		}

		
		
   		
		

		</style>
		<@resource path="/static/jquery-3.6.0.min.js" />
		<script>
		
			 <#if provider_name?has_content>
				<#assign Captalize_provider_name =provider_name?lower_case?cap_first>
				var provider="${provider_name}";
			</#if>
			
			 $(document).ready(function() {
			 	if($(".linked_successnotes").length>0)
			 	{
			 	
				 	var fontIconIdpNameToHtmlElement = 
					{
						"GOOGLE":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
					 	"AZURE":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
					 	"LINKEDIN":'',
					 	"FACEBOOK":'',
					 	"TWITTER":'',
					 	"YAHOO":'',
					 	"SLACK":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
					 	"DOUBAN":'',
					 	"QQ":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
					 	"WECHAT":'',
					 	"WEIBO":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
					 	"BAIDU":'',
					 	"APPLE":'',
					 	"INTUIT":'',
					 	"ADP":'',
					 	"FEISHU":'<span class="path1"></span><span class="path2"></span><span class="path3">',
					 	"GITHUB":'',
					 	"NEWZOHO":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>'
					 }
					 
					 $("#provider_details .provider_icon").html(fontIconIdpNameToHtmlElement[provider.toUpperCase()]);  //NO I18N
					 $("#provider_details .provider_icon").addClass("icon-"+provider.toLowerCase()+"_small");  //NO I18N
				}
				 
				 setFooterPosition();
			 
			 })
			 
			 function show_apple_resolve()
			 {
			 	$("#resolve_apple").hide();
			 	$(".expand").slideDown(200,function(){setFooterPosition();});
			 }
			 
			 
			function setFooterPosition() {
				var top_value = window.innerHeight-60;
				var container = document.querySelector(".container");	// No I18N
				var footer = document.getElementById("footer");	
				if(container && (container.offsetHeight + container.offsetTop + 30)<top_value){
					footer.style.top = top_value+"px"; // No I18N
				}
				else{
					footer.style.top = container && (container.offsetHeight + container.offsetTop + 30)+"px"; // No I18N
				}
			}
	        
			window.addEventListener("resize",function(){
				setFooterPosition();
			});
		
		</script>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	</head>
	<body>
		<div class="zohologo"></div>
		<div class="container">
           	<div class="content_box <#if status?has_content && status=="success">linked_success </#if> ">
               	<div class="status_icon"></div>
               	<div class="header_center">${title}</div> 
               	<div class="discription_center">${message}</div>
               	
               	
               	<#if usr_email?has_content && email?has_content>
               	
	               	<div class="linked_successnotes">
	               	
		               	<div class="link_details">
		               		<div class="link_details_tab">
		               			<span class="zoho_icon icon-zoho_common"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></span>
		               			<span class="Z_email_info">
		               				<div class="linked_type"><@i18n key="IAM.SIGNIN.VIA.ZA"/></div>
		               				<div class="linked_email">${Encoder.encodeHTMLAttribute(usr_email)}</div>
		               			</span>
		               		</div>
		               		
		               		<div class="Separation_x icon-linked"></div>
		               		
		               		<div class="link_details_tab" id="provider_details">
		               			<span class="provider_icon"></span>
		               			<span class="Z_email_info">
		               				<div class="linked_type"><@i18n key="IAM.LINKEDACCOUNTS.LINK.PROVIDER.ACCOUNT" arg0="${provider_name}"/></div>
		               				<div class="linked_email">${Encoder.encodeHTMLAttribute(email)}</div>
		               			</span>
		               		</div>
		               	</div>
		               	
		               	<div class="linked_note">
		               		<span class="bullet_pin icon-pin"></span>
		               		<span class="linked_msg"><@i18n key="IAM.LINKEDACCOUNTS.LINKED.RECOVERY_EMAIL.NOTE" arg0="${Captalize_provider_name}" arg1="${Encoder.encodeHTMLAttribute(email)}"/></span>
		               	</div>
		            </div>
		            
		        </#if>
		        
		        <#if showAppleError?has_content && showAppleError=="true">
		        
		        	<div class="blue_text" id="resolve_apple" onclick="show_apple_resolve()"><@i18n key="IAM.LINKEDACCOUNTS.ERROR.RESOLVE.TEXT"/></div>
		        	
		    </div> 
		        	
		        	<div class="expand">
		        	
		        		<div class="expand_head"><@i18n key="IAM.LINKEDACCOUNTS.ERROR.RESOLVE.TEXT"/></div>
		        		
		        		<div class="setps">
		        			
		        			<div class="step_head">
		        				<span class="step_point"></span>
		        				<span class="step_title"><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.FIRST.STEP"/></span>
		        			</div>
		        			
		        			<ol class="list_border">
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.CLEAR.FIRST.POINT"/></li>
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.CLEAR.SECOND.POINT"/></li>
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.CLEAR.THIRD.POINT"/></li>
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.CLEAR.FOURTH.POINT"/></li>
		        			</ol>
		        		
		        		</div>
		        		
		        		<div class="setps">
		        			
		        			<div class="step_head">
		        				<span class="step_point"></span>
		        				<span class="step_title"><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.SECOND.STEP"/></span>
		        			</div>
		        			
		        			<ol class="list_border">
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.ADD.FIRST.POINT"/></li>
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.ADD.SECOND.POINT"/></li>
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.ADD.THIRD.POINT"/></li>
		        			</ol>
		        		
		        		</div>
		        		
		        		<div class="setps">
		        			
		        			<div class="step_head">
		        				<span class="step_point"></span>
		        				<span class="step_title"><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.THIRD.STEP"/></span>
		        			</div>
		        			
		        			<ol class="last_list">
		        				<li><@i18n key="IAM.SIWA.SIGNUP.ERROR.RESOLVE.RETRY.POINT" arg0="${redirectURL}"/></li>
		        			</ol>
		        		
		        		</div>
		        		
		        		
		        	</div>
		        
		        <#elseif backToUrl?has_content>
		        	<button class="blue_btn"><a href="${backToUrl}">
		        	<#if showNextPreannouncement?has_content>
		        		<#if (showNextPreannouncement)>
		        			<@i18n key="IAM.CONTINUE"/>
		        		<#else>
		        			<@i18n key="IAM.AC.CONTACT.SUPPORT.GO_BACK"/>
		        		</#if>
		        	<#else>
		        		<@i18n key="IAM.BACKTO.HOME"/>
		        	</#if>
		        	</a></button>
		    </div>
		        </#if>
               	
               
        </div>          
       	<div id="footer" style="position:absolute;left:0px;right:0px;">
       		<#include "${location}/Unauth/footer.tpl">
       	</div>
	</body>

</html>