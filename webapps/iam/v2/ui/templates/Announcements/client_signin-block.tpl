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
		    background: url("${SCL.getStaticFilePath('/v2/components/images/Dailylimit.svg')}") no-repeat;
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
		.continue_button:hover{
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
		.blue_text
		{
			color:#00A7FF;
			font-size:14px;
			font-weight:600;
			cursor:pointer;
		}
		#svg_circle
		{
			transition: stroke-dasharray .6s ease-in-out;
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
			.border_container
			{
			    min-width: 100%;
			}
		}
	</style> 
</head>
<body>	
	 <div class="container">
        <div class="announcement_content">
            <div class="logo_text">${Encoder.encodeHTML(app_display_name)}</div>  
            <#if logins_left == 0>
            <div class="announcement_heading"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.HEADER.LIMIT.REACHED"/></div>
             <div class="announcement_description">
            	<div><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.DESC.LIMIT.REACHED" arg0="${threshold}"/>
            	</div>
            	<div class="alert_text"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.NEXT.TRY.DURATION"/></div>
          	<#else>
            <div class="announcement_heading"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.HEADER"/></div>
             <div class="announcement_description">
            	<div><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.DESC.ABOUT.LIMIT" arg0="${threshold}"/>
            	</div>
            </#if>
                        	
            </div>
            <div class="border_container">
            	<div class="session_cir_container">
            		<div class="session_header"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.BOX.TITLE"/></div>
            		<div class="canvas_area">
            			<svg class="canvas_board" id="canvas_board" style="background:#fff;display:block;" width="60px" height="60px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
							<g transform="translate(50,50)">
								<circle cx="0" cy="0" fill="none" r="40" stroke="#efefef" stroke-width="20" stroke-dasharray="250 250">
								</circle>
								<circle id="svg_circle" cx="0" cy="0" fill="none" r="40" stroke="#f45353" stroke-width="20" stroke-dasharray="0 250">
								</circle>
							</g>
						</svg>
            			<div style="overflow:auto">
	            			<div class="session_count bold"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.LIMIT.COUNT" arg0="${threshold-logins_left}"/></div>
	            			<#if logins_left == 0>
	            			<div class="remaining_count"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.SIGNIN.NO.MORE"/></div>
	            			<#else>
	            			<div class="remaining_count"><@i18n key="IAM.BLOCK.SIGNIN.ANNOUNCEMENT.REMAINING.COUNT" arg0="${logins_left}"/></div>
            				</#if>
            			</div>
            		</div>
            	</div>
	    	</div>
	    	
            <a class="blue_btn continue_button" id="continue_button" href="${visited_url}" id='continueButton' ><@i18n key="IAM.I.UNDERSTAND" /></a>
        </div>
        <div class="announcement_img"></div>
     </div>
</body>
<script>
	window.onload=function(){
		var totalCount = ${threshold};
		var remaining_login = ${logins_left};
		document.getElementById("svg_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * ((totalCount-remaining_login) / totalCount))+" "+(2 * Math.PI * 40));
		if(remaining_login == 0){
			document.getElementById("svg_circle").setAttribute("stroke","#f45353");
		}
		else{
			document.getElementById("svg_circle").setAttribute("stroke","#ffae00");
		}
	}
</script>
</html>