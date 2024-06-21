<html>
	<head>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<style>
			body
			{
				margin:0px;
				padding:0px;
			}
			.bg_one 
			{
				display: block;
				position: fixed;
				top: 0px;
				left: 0px;
				height: 100%;
				width: 100%;
				background: url('${SCL.getStaticFilePath("/v2/components/images/bg.svg")}') transparent;
				background-size: cover;
				z-index: -1;
			}
			.container {
			    display: block;
			    width: 540px;
			    background-color: #fff;
			    box-shadow: 0px 2px 30px 0px #2b2b2b17;
			    margin: auto;
			    position: relative;
			    z-index: 1;
			    margin-top: 7%;
			    overflow: hidden;
			    border-radius: 4px;
			}
			.container_box {
			    width: 540px;
			    height: auto;
			    background: #fff;
			    box-sizing: border-box;
		        padding: 50px 60px;
			    transition: all .1s ease-in-out;
			    overflow-y: auto;
			    display: table-cell;
			}
			.logo {
			    display: none;
			    width: auto;
			    margin-bottom: 24px;
		        text-align: center;
			}
			.service_header
			{
				font-size:20px;
				text-align:center;
				font-weight:500;
				margin-bottom:16px;
				line-height:24px;
			}
			.service_desc
			{
				font-size:14px;
				text-align:center;
				line-height:24px;
			}
			.button_container
			{
				margin: 32px 30px 0px 30px;
				display: flex;
			}
			.btn
			{
			    padding: 14px 0px;
			    margin-left: 10px;
			    background: #fff;
			    outline: none;
			    border: none;
			    color: #159AFF;
			    font-size: 14px;
			    font-weight: 500;
			    border-radius: 4px;
			    font-family: 'ZohoPuvi', Georgia;
		        cursor: pointer;
		        flex:1;
			}
			.blue_btn
			{
		        background: #159AFF;
				margin:0px;
				color:#fff;
			}
			@media only screen and (max-width : 435px)
			{
				.bg_one
				{
					background: #fff;
				}
				.container
				{
				    width: 100%;
				    box-shadow: none;
				    margin-top: 0px;
				}
				.container_box
				{
					padding: 70px 20px
				}
				.button_container
				{
				    flex-wrap: wrap;
				}
				.btn{
				    margin-left: 0px;
				    margin-top: 10px;
					width: 100%;
				    flex: unset;
				}
				.blue_btn
				{
					margin:0px;
				}

			
			}
		</style>
		<script>
			function load_logo_size(ele){
				if(ele.width>ele.height){
					ele.height=28;
				}
				else{
					ele.height=40;
				}
				document.getElementsByClassName("logo")[0].style.display="block";
			}
	</script>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS"/></title>
	</head>
	<body>
		<div class="bg_one"></div>
		<div class="container">
			<div class="container_box" id="recovery_flow">
				<div class="logo"><img class='logo_position_center' src="${logourl}" onload="load_logo_size(this)"/></div>
				<div class="service_header"><@i18n key="IAM.SIGNOUT.SERVICE.HEADER" arg0="${servicename}"/></div>
				<div class="service_desc"><@i18n key="IAM.SIGNOUT.SERVICE.DESCRIPTION" arg0="${servicename}"/></div>
				<div class="button_container">
					<button class="btn blue_btn" onclick="window.open('${logouturl}','_self');"><@i18n key="IAM.SIGNOUT.BUTTON.PROCEED"/></button>
					<button class="btn" onclick="window.open('${Encoder.encodeHTMLAttribute(serviceurl)}','_self');"><@i18n key="IAM.CANCEL"/></div>
				</div>
			</div>
		</div>
		<#include "Unauth/footer.tpl">
 
	</body>
</html>