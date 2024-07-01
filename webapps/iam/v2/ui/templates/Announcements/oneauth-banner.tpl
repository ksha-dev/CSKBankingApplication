<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
    	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
    	<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    	<@resource path="/v2/components/css/${customized_lang_font}" />
	</head>
	<style>
		@font-face {
			font-family: 'Announcement';
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
			src:  url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff2")}') format('woff2'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
				url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
			font-weight: normal;
			font-style: normal;
			font-display: block;
		}
		[class^="icon-"], [class*=" icon-"] {
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
		.icon-Zoho-oneAuth-logo .path1:before {
  			content: "\e916";
  			color: rgb(255, 255, 255);
	  	}
		.icon-Zoho-oneAuth-logo .path2:before {
			content: "\e917";
  			margin-left: -1.0009765625em;
  			color: rgb(246, 204, 27);
		}
		.icon-Zoho-oneAuth-logo .path3:before {
			content: "\e918";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path4:before {
			content: "\e919";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path5:before {
			content: "\e91a";
			margin-left: -1.0009765625em;
			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path6:before {
			content: "\e91b";
  			margin-left: -1.0009765625em;
  			color: rgb(255, 255, 255);
		}
		.icon-Zoho-oneAuth-logo .path7:before {
  			content: "\e91c";
  			margin-left: -1.0009765625em;
  			color: rgb(255, 255, 255);
		}
	  	.icon-pebble:after {
  			content: "\e90b";
		}
		.icon-newtab:before {
			content: "\e90a";
		}
		.icon-newtab{
			color: #0093FF;
			font-size: 14px;
			margin-left: 5px;
			display: none;
		}
		.onepathlogo {
			z-index: 2;
			font-size: 40px;
		}
		html,body {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Zohopuvi';
		}
		.wrapper {
			display: flex;
        	justify-content: center;
        	max-width: 1200px;
        	gap: 50px;
        	margin: auto;
      	}
      	.mainCont {
        	display: inline-block;
        	max-width: 540px;
        	min-width: 300px;
        	padding-top: 100px;
        	padding-left: 10%;
      	}
      	.illusCont {
        	padding-top: 100px;
        	padding-right: 10%;
        	flex: 0 1 350px;
      	}
      	.illustration {
        	width: 100%;
        	height: 350px;
        	max-width: 350px;
        	display: inline-block;
			background: url("${SCL.getStaticFilePath("/v2/components/images/oa_banner_illus.svg")}") no-repeat transparent;
			background-size: 100% 100%;
      	}
		.zoho_logo {
			display: block;
			height: 40px;
			background: url("${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}") no-repeat transparent;
			background-size: auto 100%;
		}
		.common-btn {
      		font-family: "ZohoPuvi";
        	background-color: #1389e3;
        	border-radius: 4px;
        	font-size: 14px;
        	line-height: 20px;
        	padding: 12px 30px;
        	border: none;
        	color: #ffffff;
        	font-weight: bold;
        	margin-top: 30px;
        	cursor: pointer;
      	}
      	.common-btn:hover {
			background-color: #057AD3;
		}
		.link-btn {
      		margin: 20px 0 0 20px;
        	font-size: 12px;
        	color: #0093ff;
        	letter-spacing: 0.2px;
        	font-weight: 600;
        	font-family: "ZohoPuvi";
        	background: none;
        	border: none;
        	cursor: pointer;
        	padding: 0px;
      	}
		.remind-later{
	  		color: #8b8b8b;
	  		border-bottom: 1px dashed #acacac;
	  		text-decoration: none;
    		outline: none;
    		line-height: 16px;
    		font-size: 14px;
    		font-weight: 500;
    		margin: 30px 20px 30px 0px;
    		margin-top: 42px;
    		float: right;
    		left: 0px;
			background-color: white;
			position: relative;
			transition : left .4s ease-in;
	   	}
	   	.remind_loader{
			left: -20px;
			pointer-events: none;
 		}
	   	.remind_loader::after{
	  		content:"";
	  		display: inline-block;
    		position: absolute;
    		top: 4px;
    		right: 0px;
    		z-index: -2;
    		border: 2px solid rgba(255, 255, 255, 0.2);
    		border-left: 2px solid;
    		border-bottom: 2px solid;
    		-webkit-animation: load 1s infinite linear, anim_r .4s 1 forwards ease-in;
    		animation: load .6s infinite linear, anim_r .4s 1 forwards ease-in;
    		width: 7px;
    		height: 7px;
    		border-radius: 50px;
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
 		@keyframes anim_r{
			0%{
				right: 0px;
			}
			100%{
				right: -20px;
			}
 		} 
		.remind-later:hover{
	  		color: #666666;
		}
		.btndisabled{
			opacity: 0.5;
			pointer-events: none;
		}
		.loader{
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
	   	.mainCont h2{
	   		width: 540px;
	   		font-weight: 600;
	   		line-height: 32px;
	   	}
	   	.oneauth-container{
	   		border-radius: 10px;
	   		border: 1px dashed #cecece;
	   	}
	   	.oneauth-banner-desc > div{
	   		line-height: 22px;
	   	}
	   	.oneauth-banner-desc ul{
    		padding-inline-start: 25px;
    		margin-block-start: 20px;
    		margin-block-end: 30px;
	   	}
	   	.oneauth-banner-desc li{
    		font-size: 14px;
    		line-height: 18px;
	   	}
	   	.oneauth-banner-desc ul > li{
    		margin-bottom: 16px;
	   	}
	   	.oneauth-header{
	   		padding: 20px 24px;
	   		position: relative;
	   		display: flex;
	   		flex-direction: column;
	   		gap: 20px;
	   	}
	   	.one-header{
	   		display: flex;
			align-items: center;
			cursor: pointer;
			width: max-content;
	   	}
	   	.add-oneauth{
	   		min-height: 50px;
	   	}
	   	.mode-icon {
        	width: 60px;
        	height: 60px;
        	font-size: 60px;
        	position: relative;
        	display: flex;
        	align-items: center;
        	justify-content: center;
        	pointer-events: none;
        	flex-shrink: 0;
    	}
	   	.mode-icon::before {
      		font-size: 16px;
      		margin: auto;
      		align-self: center;
    	}
    	.mode-icon::after{
      		position: absolute;
      		left: 0;
      		opacity:0.1;
      	}
	  	.oneauth-container .mode-icon::after, .oneauth-header-icon::after {
    		position: absolute;
    		opacity: 2;
    		-webkit-background-clip: text;
    		background-clip: text;
    		-webkit-text-fill-color: transparent;
    		background-color: #4E5BBE;
    		z-index: 1;
		}
		.mode-header-texts {
        	display: flex;
        	flex-direction: column;
        	font-size: 18px;
        	font-weight: 600;
        	justify-content: space-around;
       		pointer-events: none;
        	margin: 6px 0px 6px 10px;
      	}
		.oneauth-desc, .oneauth-step-header{
	  		font-size: 14px;
	  		line-height: 18px;
	  		color: #000000;
	  		opacity: 0.6;
	  		font-weight: 400;
			max-width: 280px;
	  	}
		.oneauth-steps{
			padding: 20px 30px;
			border-top: 1px solid #D8D8D8;
		}
	  	.oneauth-step-header{
			margin-bottom: 16px;
			line-height: 16px;
			opacity: 1;
			font-weight: 500;
		}
	  	.oneauth-footer{
			font-size: 14px;
			line-height: 16px;
			margin-top: 20px;
		}
	  	.onefoot-link{
			font-weight: 500;
			color: #0091FF;
			text-decoration: none;
			display: inline-block;
			line-height: 24px;
		}
	  	.oneauth-step{
			font-size: 14px;
			font-weight: 400;
			line-height: 20px;
			margin-bottom: 10px;
			margin-left: 10px;
		}
		.instruct-btn{
	  		width: max-content;
	  		color: black;
	  		font-weight: 500;
	  		text-decoration: underline;
	  		font-size: 14px;
	  		opacity: 0.7;
	  		margin: 0;
	  		margin-top: 20px;
	  		display: block;
		}
	  	.download {
    		width: 110px;
    		height: 36px;
    		cursor: pointer;
	  	}
	  	.playstore-icon{
			background: url("${SCL.getStaticFilePath('/v2/components/images/Playstore_svg.svg')}") no-repeat;
			height: 30px;
	  		width: 96px;
	  		background-size: 96px 30px;
	 		order: 1;
		}
		.appstore-icon{
			background: url("${SCL.getStaticFilePath('/v2/components/images/Appstore_svg.svg')}") no-repeat;
	  		height: 30px;
	  		width: 88px;
	  		background-size: 88px 30px;
	  		order: 2;
		}
		.macstore-icon{
			background: url("${SCL.getStaticFilePath('/v2/components/images/Macstore_svg.svg')}") no-repeat;
	  		height: 30px;
	  		width: 115px;
	  		background-size: 115px 30px;
	  		order: 3;
	  	}
	  	.winstore-icon{
			background: url("${SCL.getStaticFilePath('/v2/components/images/Winstore_svg.svg')}") no-repeat;
			background-size: 84px 30px;
	  		width: 84px;
	  		height: 30px;
	  		order: 4;
	  	}
	  	.down-badges{
	  		display: inline-flex;
	  		gap: 10px;
	  		flex-wrap: wrap;
			max-width: 330px;
	  	}
	  .add-new-oneauth{
	  	position: relative;
	  }
	  .add-qr{
	  	flex: 1 0 130px;
        min-height: 120px;
        display: flex;
        flex-direction: column;
        align-items: center;
        position: absolute;
        top: 20px;
        right: 30px;
        transition: all .25s ease-in-out;
        pointer-events: none;
	  }
      .qr-desc {
        font-weight: 600;
        margin-top: 4px;
        text-align: center;
        max-width: 104px;
        font-size: 12px;
        word-break: break-word;
        opacity: 0.8;
      }
	  .top,
      .bottom {
        position: absolute;
        width: 16px;
        height: 16px;
        pointer-events: none;
      }
      .top {
        top: 0;
        border-top: 3px solid #6E7193;
      }
      .bottom {
        bottom: 0;
        border-bottom: 3px solid #6E7193;
      }
      .left {
        left: 0;
        border-left: 3px solid #6E7193;
      }
      .right {
        right: 0;
        border-right: 3px solid #6E7193;
      }
      .bottom.left {
        border-top-left-radius: 0px;
      }
      .bottom.right {
        border-top-right-radius: 0px;
      }
	  .qr-image-banner{
	  	background-image: url("${SCL.getStaticFilePath('/v2/components/images/oa_banner_scanqr.png')}");
	  	width: 106px;
	  	height: 106px;
	  	background-size: 90px 90px;
	  	background-color: unset;
	  	position: relative;
	  	background-position: center;
        background-repeat: no-repeat;
	  }
	  .header-flex{
	  	width: max-content;
    	display: inline-flex;
    	flex-direction: column;
	  }
      .one-header:hover .icon-newtab{
      	display: inline-block;
      }
      .one-header:hover span{
		color: #0093FF;
	  }
		@media only screen and (min-width: 980px) and (max-width: 1130px) {
	  		.illusCont {
				padding-right: 7%;
			}
			.mainCont{
				padding-left: 7%;
			}
		}
		@media only screen and (min-width: 435px) and (max-width: 980px) {
        .wrapper {
          padding: 50px 25px 0px 25px;
        }
        .mainCont {
          padding: 0;
          margin: auto;
        }
        .illusCont {
          display: none;
        }
        .oneauth-container, .oneauth-banner-desc, .mainCont h2{
        	width: 100%;
        }
      }
      @media only screen and (max-width: 590px) {
      	.add-qr{
      		display: none;
      	}
      }
      @media only screen and (max-width: 435px) {
        .wrapper {
          padding: 30px 20px 30px 20px;
        }
        .mainCont {
          width: 100%;
          padding: 0;
        }
        .illusCont {
          display: none;
        }
        .macstore-icon, .winstore-icon{
			display: none !important;
        }
        .oneauth-banner-desc, .mainCont h2, .one-header, .common-btn{
        	width: 100%;
        }
        .mode-header-texts{
			margin-top: 0;
			margin-bottom: 0;
        }
        .remind-later {
        	padding-top: 30px;
        	float: unset;
        	display: block;
        	margin: auto;
        	top:0px;
        }
      }
	</style>
	<body>
  		<#include "../Unauth/announcement-logout.tpl">
  		
  		
  		<style>
  		      /*   Update announcment style chnages */
      
      
		      .update_oneAuth .oneauth-container .mode-icon::after, .oneauth-header-icon::after {
		    		background-color: transparent;
				}
		      
		      
		      	.icon-OneAuth .path1:before {
				  content: "\e976";
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path2:before {
				  content: "\e977";
				  margin-left: -1em;
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path3:before {
				  content: "\e978";
				  margin-left: -1em;
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path4:before {
				  content: "\e979";
				  margin-left: -1em;
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path5:before {
				  content: "\e97a";
				  margin-left: -1em;
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path6:before {
				  content: "\e97b";
				  margin-left: -1em;
				  color: rgb(34, 109, 180);
				}
				.icon-OneAuth .path7:before {
				  content: "\e97c";
				  margin-left: -1em;
				  color: rgb(249, 178, 29);
				}
				
				
				.update_oneAuth .oneauth-container{
			   		max-width: unset;
			   		border:none;
			   		background-image: url("data:image/svg+xml,%3csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3e%3crect width='100%25' height='100%25' fill='none' rx='10' ry='10' stroke='%23CECECEFF' stroke-width='3' stroke-dasharray='5%2c10' stroke-dashoffset='0' stroke-linecap='square'/%3e%3c/svg%3e");
			   		border-radius:10px;
			   	}
			   	
			   	 .update_oneAuth .oneauth-steps{
					margin: 0px;
					padding: 20px 24px;
					border:none;
					background-image: linear-gradient(to right, #cecece 59%, rgba(255,255,255,0) 0%);
				    background-position: top;
				    background-size: 15px 1.5px;
				    background-repeat: repeat-x;
				}
		      
		      
		         .update_oneAuth .update_DESC
			     {
			     	margin-bottom: 20px;
			     }
			     
			      .update_oneAuth .add-oneauth {
					    min-height: unset;
					}
			     
			     .update_oneAuth .qr-image-banner
			     {
			     	border: 4px solid #000000;
		    		border-top-left-radius: 5px;
		    		border-top-right-radius: 5px;
		    		width: 92px;
		    		height: 92px;
					background-size: 84px 84px;
		    		
			     }
			     
			     .update_oneAuth .qr-desc
			     {
			     	background-color: #000000;
				    width: 100%;
				    border: 4px solid #000000;
				    border-bottom-left-radius: 5px;
		    		border-bottom-right-radius: 5px;
				    color: white;
				    margin-top: -4px;
				    opacity: 1;
				    max-width: 106px;
				    max-width: 92px;
				    font-size: 10px;
			     }
			     
			     .update_oneAuth .oneauth-steps li
			     {
			     	list-style-type: none;
		    		text-indent: -1em;
			     }
			     
			     .update_oneAuth .add-qr
			     {
			        top: 23px;
				  }
			     
			     .update_oneAuth .oneauth-steps li::before
			     {
			     	content: "";
				    width: 6px;
				    height: 6px;
				    display: inline-block;
				    border-radius: 50%;
				    background-color: #b2b2b2;
				    margin-right: 8px;
				    top: -2px;
				    position: relative;
			     }
				
				.update_oneAuth .mode-icon 
				{
				    width: 64px;
				    height: 64px;
				    font-size: 64px;
				    border-radius: 16px;
		    		border: 1px solid #cecece;
				}
				
				.update_oneAuth .appstore-icon
				{
					height: 32px;
				    width: 107px;
				    background-size: 107px 32px;	
				}
				
				.update_oneAuth .playstore-icon
				{
					height: 32px;
				    width: 107px;
				    background-size: 107px 32px;		
				}
				
				.update_oneAuth .winstore-icon
				{
					height: 32px;
				    width: 89px;
				    background-size: 89px 32px;		
				}
				
				.update_oneAuth .macstore-icon
				{
					height: 32px;
				    width: 125px;
				    background-size: 125px 32px;		
				}
				
				.update_oneAuth .down-badges 
				{
		    		gap: 8px;
		    		max-width: unset;
		    	}
		    	
		    	
		      	
		      	.update_oneAuth .illustration {
					background: url("${SCL.getStaticFilePath("/v2/components/images/oa_banner_update_illus.svg")}") no-repeat transparent;
					background-size: 100% 100%;
		      	}
		      	
		      	.update_oneAuth .oneauth-step 
		      	{
    				font-size: 12px;
      			}
      			.update_oneAuth .oneauth-step-header 
      			{
    				font-size: 12px;
    				font-weight: 500;
      			}
	</style>
  		
  		
  		<#if (new_version_banner)?has_content>
			
			
			
				<main class="wrapper">
					<div class="update_oneAuth mainCont">
						<div class="zoho_logo"></div>
						<h2><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATE.HEADER" /></h2>
						<div class="oneauth-banner-desc update_DESC">
							<div><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATE.DESC" /></div>
						</div>
						
						<div class="oneauth-container">
							<div class="oneauth-header">
							<div class="one-header" onclick="storeRedirect('https://zurl.to/oa_banner_website')">
							<div class="mode-icon icon-OneAuth"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
									<div class="mode-header-texts"><span><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /><div class="icon-newtab"></div></span><div class="oneauth-desc or-text"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div></div>
							</div>
								<div class="add-oneauth">
									<div class="down-badges">
										<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/oa_banner_playstore')"></div>
										<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/oa_banner_appstore')"></div>
										<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/oa_banner_macstore')" style="display:none"></div>
										<div class="download winstore-icon win-small" onclick="storeRedirect('https://zurl.to/oa_banner_msstore')"  style="display:none"></div>
									</div>
									<div class="add-qr">
										<div class="qr-image-banner"></div>
										<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
									</div>
		                  		</div>
							</div>
							<ul class="oneauth-steps">
								<div class="oneauth-step-header"><@i18n key="IAM.ANNOUNCEMENT.WHATS.NEW" /></div>
								<li class="oneauth-step"><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATE1" /></li>
								<li class="oneauth-step"><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATE2" /></li>
								<li class="oneauth-step"><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATE3" /></li>
							</ul>
						</div>
						<button class="common-btn" onclick="continueToService(event)"><span></span><@i18n key="IAM.ANNOUNCEMENT.ONE_AUTH.UPDATED" /></button>
						<button class="link-btn remind-later" onclick="(function(e){window.location.href=remindme; e.target.classList.add('remind_loader')})(event);"><@i18n key="IAM.TFA.BANNER.REMIND.LATER"/></button>
						
					</div>
					<div class="illusCont">
						<div class="illustration"></div>
					</div>
		    	</main>
    	
    	
    		
		<#else>
  		
  		
  		
				<main class="wrapper">
					<div class="mainCont">
						<div class="zoho_logo"></div>
						<h2><@i18n key="IAM.ONEAUTH.ANNOUN.HEADING" /></h2>
						<div class="oneauth-banner-desc">
							<div><@i18n key="IAM.ONEAUTH.ANNOUN.DESC" /></div>
							<ul>
								<li><@i18n key="IAM.ONEAUTH.ANNOUN.PT1" /></li>
								<li><@i18n key="IAM.ONEAUTH.ANNOUN.PT2" /></li>
							</ul>
						</div>
						<div class="oneauth-container">
							<div class="oneauth-header">
							<div class="one-header" onclick="storeRedirect('https://zurl.to/oa_banner_website')">
							<div class="mode-icon icon-pebble icon-Zoho-oneAuth-logo"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
									<div class="mode-header-texts"><span><@i18n key="IAM.ZOHO.ONEAUTH.AUTHENTICATOR" /><div class="icon-newtab"></div></span><div class="oneauth-desc or-text"><@i18n key="IAM.ONEAUTH.MFA.TAG" /></div></div>
							</div>
								<div class="add-oneauth">
									<div class="down-badges">
										<div class="download playstore-icon play-small" onclick="storeRedirect('https://zurl.to/oa_banner_playstore')"></div>
										<div class="download appstore-icon app-small" onclick="storeRedirect('https://zurl.to/oa_banner_appstore')"></div>
										<div class="download macstore-icon mac-small" onclick="storeRedirect('https://zurl.to/oa_banner_macstore')" style="display:none"></div>
										<div class="download winstore-icon win-small" onclick="storeRedirect('https://zurl.to/oa_banner_msstore')" style="display:none"></div>
									</div>
									<div class="add-qr">
										<div class="qr-image-banner">
											<div class="top left"></div>
											<div class="top right"></div>
											<div class="bottom right"></div>
											<div class="bottom left"></div>
										</div>
										<div class="qr-desc"><@i18n key="IAM.MFA.ANNOUN.ONEAUTH.SCAN" /></div>
									</div>
									<button class="link-btn instruct-btn" onclick="showInstructions(event)"><@i18n key="IAM.INSTRUCTIONS.SET.UP" /></button>
		                  		</div>
							</div>
							<div class="oneauth-steps" style="display:none">
							<div class="oneauth-step-header"><@i18n key="IAM.AFTER.INSTALLING.ONEAUTH" /></div>
							<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP1" /></div>
							<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP2" /></div>
							<div class="oneauth-step"><@i18n key="IAM.MFA.PANEL.ONEAUTH.STEP3" /></div>
							<div class="oneauth-footer"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.TEXT" /> <a href="https://zurl.to/oa_banner_howworks" target="_blank" class="onefoot-link"><@i18n key="IAM.MFA.PANEL.ONEAUTH.FOOTER.LINK" /></a></div>
							</div>
						</div>
						<button class="common-btn" onclick="continueToService(event)"><span></span><@i18n key="IAM.ANNOUNCEMENT.SWITCH.ONEAUTH.SETUP.BUTTON.TEXT" /></button>
						<button class="link-btn remind-later" onclick="(function(e){window.location.href=remindme; e.target.classList.add('remind_loader')})(event);"><@i18n key="IAM.TFA.BANNER.REMIND.LATER"/></button>
					</div>
					<div class="illusCont">
						<div class="illustration"></div>
					</div>
		    	</main>
    	
    	
    	</#if>
    	
    	
    	<script>
			window.onload=function() {
				if(/Mac|Macintosh|OS X/i.test(navigator.userAgent)){
					$(".add-oneauth .down-badges .macstore-icon").show();
				} else if(/windows|Win|Windows|Trident/i.test(navigator.userAgent)){
					$(".add-oneauth .down-badges .winstore-icon").css({"order":-1});
					$(".add-oneauth .down-badges .macstore-icon").hide();
				} else {
					$(".add-oneauth .down-badges .winstore-icon").show();
					$(".add-oneauth .down-badges .macstore-icon").show();
				}
			}
			<#if remindme_url??>var remindme = '${Encoder.encodeJavaScript(remindme_url)}'</#if>
  				function continueToService(e){
  					window.location.href = '${Encoder.encodeJavaScript(visited_url)}';
					e.target.classList.add("btndisabled");
					e.target.querySelector("span").classList.add("loader");
  				}
 			function showInstructions(e){
 				$(e.target).slideUp(300)
 				$(".oneauth-steps").slideDown(300);
 				$(".oneauth-banner-desc").slideUp(300);
 			}
 			function storeRedirect(url){
				window.open(url, '_blank');
			}
    	</script>
	</body>
</html>
