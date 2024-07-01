<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
    	<#if (is_email && is_primary)> 
    		<@i18n key="IAM.ADD.CONTACT.EMAIL"/>
    	<#elseif  (is_email && !is_primary)>
    		<@i18n key="IAM.ADD.SECONDARY.EMAIL.TEXT"/>
    	<#elseif !is_recovery>
        	<@i18n key="IAM.ADD.CONTACT.MOBILE"/>
		<#else>
        	<@i18n key="IAM.ADD.RECOVERY.MOBILE.TITLE"/>
        </#if>	
    </title>
    <@resource path="/v2/components/css/${customized_lang_font}" />
    
   <#if !(block_add_recovery || block_mob_num_addition)>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
	<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
    <@resource path="/v2/components/js/common_unauth.js" />
    <@resource path="/v2/components/js/splitField.js" />
    <#if (!is_email || is_recovery)>
    <@resource path="/v2/components/css/uvselect.css" />
    <@resource path="/v2/components/css/flagIcons.css" />
	<script>
		var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
	</script>  
    <@resource path="/v2/components/js/phonePatternData.js" />
    <@resource path="/v2/components/js/uvselect.js" />
    <@resource path="/v2/components/js/flagIcons.js" />
    </#if>
    
    </#if>
    <style>
      
       @font-face {
		font-family: 'Announcement';
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


	  .icon-NewZoho{
	  	display:flex;
     	font-size: 40px;
     	margin-bottom:20px;
      }
	  .icon-NewZoho .path1:before {
  		content: "\e95a";
    	color: rgb(0, 0, 0);
	  }
	  .icon-NewZoho .path2:before {
  		content: "\e95b";
    	margin-left: -2.3466796875em;
   	 	color: rgb(4, 152, 73);
	  }
	 .icon-NewZoho .path3:before {
 	 	content: "\e95c";
   	 	margin-left: -2.3466796875em;
    	color: rgb(246, 177, 27);
	  }
	  .icon-NewZoho .path4:before {
  		content: "\e95d";
    	margin-left: -2.3466796875em;
    	color: rgb(226, 39, 40);
	  }
	  .icon-NewZoho .path5:before {
  		content: "\e95e";
    	margin-left: -2.3466796875em;
    	color: rgb(34, 110, 179);
	  }
	  .icon-NewZoho .path6:before {
  		content: "\e95f";
    	margin-left: -2.3466796875em;
    	color: rgb(34, 110, 179);
	  }
	  
	  .icon-warning:before{
	  	content:"\e962";
	  }
	  .icon-reload:before {
    	content: "\e961";
	  }
	  
	  .icon-search:before{
	  	content: "\e960";
	  }
	  
	  .icon-mail:before{
	    content:"\e908";
	  }
	  
	  .icon-copy:before{
	  	content:"\e963";
	  }
	  
      body {
        margin: 0;
        box-sizing: border-box;
      }
      
      .logo_center{
      	width:95px;
      	margin:0px auto;
      }
      .content_container {
        max-width: 578px;
        padding-top: 100px;
        padding-right: 4%;
        padding-left: 10%;
        display: inline-block;
      }
      .announcement_header {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        cursor: default;
      }
      .configure_desc,
      .captcha_desc {
        font-size: 16px;
        line-height: 24px;
        margin-bottom: 20px;
        cursor: default;
      }
      .otp_sent_desc{
      	line-height: 24px;
        margin-bottom: 30px;
      }
      .valueemailormobile{
      	word-break:break-all;
      	max-width:578px;
      }
      .emolabel {
        font-size: 12px;
        line-height: 14px;
        display: block;
        margin-bottom: 4px;
        font-weight: 600;
        letter-spacing: 0px;
        color: #000000b3;
      }
      .otp_input_container,
      .email_input_container,
      .mobile_input_container {
        width: 300px;
      }
      .emailormobile {
        font-weight: 600;
      }
      .resend_otp {
        font-size: 14px;
        line-height: 26px;
        margin:12px 0 0px 0;
        cursor: pointer;
        font-weight: 500;
        color: #0093ff;
        width: max-content;
      }
      #email_input,
      #mobile_input {
        height: 44px;
        padding: 12px 15px;
        line-height: 30px;
        width: 288px;
        border: 1px solid #0f090933;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }
      #email_input:focus-visible, #mobile_input:focus-visible{
      	outline: none;
      }
      input#otp_input {
        margin-bottom: 0px;
        padding: 14px 15px;
      }
      .edit_option {
        font-size: 16px;
        line-height: 24px;
        margin-left: 4px;
        color: #0093ff;
        cursor: pointer;
      }
      .send_otp_btn,
      .verify_btn,
      .captcha_btn{
        font: normal normal 600 14px/30px sans-serif;
        padding: 5px 30px;
        border-radius: 4px;
        color: white;
        border: none;
        background: #1389e3 0% 0% no-repeat padding-box;
        cursor: pointer;
        margin-top:30px;
        outline:none;
        border:none;
        white-space:nowrap;
      }
      .send_otp_btn:hover,
      .verify_btn:hover,
      .captcha_btn{
      	background-color: #0779CF;
      }
      .send_otp_btn span{
	   	margin-left: 10px;
	  	font-size: 10px;
	  }
      .nonclickelem {
        color: #626262;
        pointer-events: none;
        cursor: none;
      }
      button:disabled {
        opacity: 0.4;
        cursor:not-allowed;
      }
      
      <#if (!is_email || is_recovery)>
      
      .illustration {
        width: 350px;
        height: 350px;
        display: inline-block;
        background: url("${SCL.getStaticFilePath("/v2/components/images/mobilenumberverify.svg")}") no-repeat;
      }
      
      <#else>
      
      .illustration {
        width: 350px;
        height: 350px;
        display: inline-block;
        background: url("${SCL.getStaticFilePath("/v2/components/images/emailverify.svg")}") no-repeat;
      }
      
      </#if>
      
      
      .flex-container {
        display: flex;
        max-width: 1200px;
        gap: 50px;
        margin: auto;
      }
      .illustration-container {
        padding-top: 120px;
        padding-right: 10%;
      }
      .back_btn{
      	outline: none;
      	padding: 12px 30px;
      	border: none;
      	cursor: pointer;
      	border-radius: 4px;
      	background: #ededed;
      	font-size: 14px;
      	font-weight: 600;
      	color: #4E4E4E;
      	margin-left: 20px;
      }
      .otp_input_container {
        position: relative;
      }
      .otp_container {
        display: flex;
        justify-content: space-around;
        width: 100%;
        height: 44px;
        box-sizing: border-box;
        border-radius: 4px;
        font-size: 16px;
        outline: none;
        padding: 0px 15px;
        transition: all 0.2s ease-in-out;
        background: #ffffff;
        border: 1px solid #dddddd;
        text-indent: 0px;
      }
      .otp_container::after {
        content: attr(placeholder);
        height: 44px;
        line-height: 44px;
        font-size: 14px;
        position: absolute;
        color: #b9bcbe;
        left: 15px;
        z-index: 1;
        cursor: text;
      }
      .customOtp {
        border: none;
        outline: none;
        background: transparent;
        height: 100%;
        font-size: 14px;
        text-align: left;
        width: 22px;
        padding: 0px;
      }
      .hidePlaceHolder::after {
        z-index: -1 !important;
      }
      #otp_split_input input::placeholder {
        color: #b9bcbe;
      }
	  .error_msg {
        font-size: 14px;
        font-weight: 500;
        line-height: 18px;
        margin-top: 8px;
        color: #e92b2b;
        display: none;
        white-space: normal;
      }
      #mobile_input {
        text-indent: 60px;
        width: 300px;
        line-height: 40px;
        letter-spacing: 0.5px;
        height: 42px;
        outline: none;
        box-sizing: border-box;
        font-size: 14px;
        font-family: "ZohoPuvi";
        display: inline-block;
        box-sizing: border-box;
        outline: none;
        border-radius: 4px;
        border: 1px solid #dddddd;
        padding: 12px 15px 12px 6px;
      }
      .noindent {
        position: relative;
      }
      .phone_code_label
	  {
    	width: 60px;
    	height: 42px;
     	display: inline-block;
    	float: left;
    	position: absolute;
    	line-height: 42px;
    	text-align: center;
    	font-size:14px;
    	color:black;
	  }
	  .phone_code_label:after{
	    content: "";
    	border-color: transparent #E6E6E6 #E6E6E6 transparent;
    	border-style: solid;
    	transform: rotate(45deg);
    	border-width: 2px;
    	height: 5px;
   		width: 5px;
    	position: absolute;
    	right: 2px;
    	top: 14px;
    	border-radius: 1px;
    	display: inline-block;
	  }
      .pic {
        width: 20px;
        height: 14px;
        background-size: 280px 252px;
        background-image: url("../images/Flags.png");
        background-position: -180px -238px;
        float: left;
        margin-top: 1px;
      }
     

      #error_space{
			position: fixed;
		    width: fit-content;
		    width: -moz-fit-content;
		    left: 0px;
		    right: 0px;
		    margin: auto;
		    border: 1px solid #FCD8DC;
		    display: inline-block;
		    padding: 18px 30px;
		    background: #FFECEE;
		    border-radius: 4px;
		    color: #000;
		    top: -150px;
		    transition: all .3s ease-in-out;
		    box-sizing: border-box;
	        max-width: 400px;
	        cursor:pointer;
	        display:flex;
		}
		.top_msg
		{
			font-size: 14px;
			color: #000;
			line-height: 24px;
			float: left;
			margin-left: 10px;
		    font-weight: 500;
			text-align: left;
		    max-width: 304px;
		}
		.error_icon
		{
		    position: relative;
		    background: #FD395D;
		    width: 24px;
		    height: 24px;
		    min-width:24px;
		    min-height:24px;
		    float: left;
		    box-sizing: border-box;
		    border-radius: 50%;
		    display: inline-block;
		    color: #fff;
		    font-weight: 700;
		    font-size: 12px;
		    text-align: center;
		    line-height: 24px;
		}
		.show_error{
			top:60px !important;
		}
		
		#blocking_container{
			display:flex;
			height:100vh;
			flex-direction:column;
			justify-content:center;
			align-items:center;
			position:relative;
			top: -150px;
		}
		
      #footer {
		    width: 100%;
		    height: 20px;
		    font-size: 14px;
		    color: #727272;
		    position: absolute;
		    margin: 20px 0px;
		    text-align: center;
		    position:absolute;
		    bottom:0px;
	  }
	  #footer a{
		color:#727272;
	  }
	  
		.loader {
			display: inline-block;
  			font-size: 10px;
  			position: relative;
  			top: 2px;
  			margin-right: 10px;
  			text-indent: -9999em;
  			border: 2px solid rgba(255, 255, 255, 0.2);
  			border-left: 2px solid;
  			border-bottom: 2px solid;
  			transform: translateZ(0);
  			-webkit-animation: load 1s infinite linear;
  			animation: load 1s infinite linear;
		}
		
		.loader,
		.loader:after {
  			border-radius: 50%;
  			width: 10px;
  			height: 10px;
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
	  .tick {
        display: inline-block;
        margin-right: 10px;
        width: 10px;
        height: 5px;
        border-left: 2px solid #0093ff;
        border-bottom: 2px solid #0093ff;
        transform: rotate(-45deg);
        position: relative;
        top: -4px;
      }
      .verified_tick{
       height:5px;
       width:0px;
       animation: 0.3s ease-in-out 0s 1 forwards running tick;
       margin-right: 0px;
       margin-left: 10px;
       left:-10px;
      }
	 
      
      
      #select_phonenumber_input{
      	width: 100%;
	    line-height: 40px;
	    display: inline-block;
	    height: 42px;
	    letter-spacing: 0.5px;
	    font-size: 14px;
	    outline: none;
	    box-sizing: border-box;
	    border: 1px solid #DCDCDC;
      }
      
      /** captcha */
      
    #captcha_container {
	    display: none;
	    border: 1px solid #DDDDDD;
	    width: 250px;
	    padding: 12px;
	    box-sizing: border-box;
	    margin-top: 8px;
	    border-radius: 4px;
	    max-width:240px;
	}

	#captcha{
		width:100%;
		margin-top:10px;
	}
	#captcha.errorborder{
		border:2px solid #ff8484;
	}
	
	#captcha_img img {
	    height: 50px;
	    max-width:150px;
	    width: calc(100% - 50px);
	    box-sizing: border-box;
	    margin: 0px;
	}
	
	#reload{
		position:absolute;
		top:20px;
		right:20px;
		width:36px;
		height:36px;
		border-radius:50%;
		background-color:#F7F7F7;
		cursor:pointer;
	}
	
	#reload.icon-reload::before {
	    position: absolute;
	    text-align: center;
	    top: 11px;
	    opacity: 0.5;
	    left: 10px;
	}
	
	.errorborder{
		border:2px solid #ff8484;
	}
	
	.captcha_field_error0,.captcha_field_error1
	{
		font-size: 14px;
	}
	
	
	.margin_captcha_field_error{
		margin-top:10px;
	}
	
	.errorlabel {
	    color: #E92B2B;
	}
	
	.load_captcha_btn {
	    animation: spin 0.5s linear infinite;
	}
	
	.box_blur {
    background-color: #fff;
    opacity: 0.95;
    position: absolute;
    top: 0px;
    bottom: 0px;
    width: 100%;
    z-index: 4;
    display: none;
    left: 0px;
    right: 0px;
	}

	.captchaloader{
		border: 3px solid transparent;
	    border-radius: 50%;
	    border-top: 3px solid #1389e3 ;
	    border-right: 3px solid #1389e3 ;
	    border-bottom: 3px solid #1389e3 ;
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
	    display: none;
	}
   
	   /*result style*/
	   
	 #blocking_container .icon-NewZoho{
	 	margin-bottom:20px;
	 }
	   
	 #blocking_container .mail{
	 	font-size:14px;
	 	font-weight:500;
	 	display:inline-block;
	 	position:relative;
	 	padding:12px;
	 	margin-top: 24px;
   	 	margin-bottom: 12px;
	 	cursor:pointer;
	 	border: 1px solid #EFEFEF;
		border-radius: 3px;
	 	background-color:#FCFCFC;
	 }
	 
	 #blocking_container .mail:hover{
		background-color:#F8F8F8;
		border: 1px solid #E8E8E8;
	 }
	 
	 .icon-mail{
		display: inline-block;
	    margin-right: 8px;
	    float: left;
	    margin-top: 2px;
     }
     
     .icon-copy{
     	margin-left:8px;
     	color:#CCCCCC;
     	float:right;
     	margin-top:1px;
     }
     
     .icon-copy:hover{
     	color:#AFAFAF;
     }
	 
	 #blocking_container .mail .tooltip{
	  	position:absolute;
	  	width:auto;
	  	text-align:center;
	  	border-radius:5px;
	  	padding:8px;
	  	background-color:#000000b5;	
	  	transition:all ease-in-out 0.3s;
	  	color:#fff;
	  	font-weight:500;
	  	font-size:12px;
	  	white-space:nowrap;
	  	left: 50%;
	  	top:15px;
	  	opacity:0;
   		transform: translateX(-50%);
	  }
	 
	 #blocking_container .mail:hover .tooltip {
	 	opacity:1;
	 	top:32px;
	 }
	 
	 .tooltip::after {
	    content: "";
	    position: absolute;
	    bottom: 100%;
	    left: 50%;
	    margin-left: -5px;
	    border-width: 5px;
	    border-style: solid;
	    border-color: transparent transparent #555 transparent;
	 }
	 
	 .tooltip-tick{
	 	display:inline-block;
	 	width:9px;
	 	height:3px;
	 	margin-bottom:3px;
	 	margin-right: 5px;
	 	border-left: 2px solid #10bc83;
   	 	border-bottom: 2px solid #10bc83;
   	 	transform: rotate(-45deg);
	 }
	   
	 body .result_popup {
	  z-index: 4;
	  border-radius: 20px;
	  position:relative;
	  height: auto;
	  width: 578px;
	  background: #fff;
	  outline: none;
	  box-sizing: border-box;
	  transition: transform 0.2s ease-in-out;
	  border: 1px solid #E5E5E5;
	  overflow: hidden;
	  border-radius: 30px;
	  text-align:center;
	  margin:0px auto;
	}
	
	body .result_popup .pop_bg{
		position:relative;
		top:0px;
		left:0px;
	}
	
	body .result_popup .grn_text {
	  text-align: center;
	  color: #000000;
	  font-size: 18px;
	  margin-top: 0px;
	  font-weight: 500;
	}
	body .result_popup .defin_text {
	  text-align: center;
	  margin-top: 10px;
	  font-size: 14px;
	  line-height: 24px;
	  opacity:0.7;
	}
	
	body .result_popup .success_icon, body .result_popup .reject_icon , body .result_popup .org_icon {
	  width: 40px;
	  height: 40px;
	  border-radius: 50%;
	  overflow: hidden;
	  font-size: 44px;
	  margin: auto;
	  color: #939393;
	  margin-top: 12px;
	  font-weight: 600;
	  background: #16C188;
	  position: absolute;
	  left: 0px;
	  right: 0px;
	  bottom: 24px;
	}
	body .result_popup .success_icon:before {
	  content: "";
	  display: inline-block;
	  width: 40px;
	  height: 40px;
	  border-radius: 50%;
	  background: #41D05B;
	  position: relative;
	  top: -3px;
	  left: -3px;
	}
	body .result_popup .success_icon:after {
	  content: "";
	  display: inline-block;
	  position: absolute;
	  left: 10px;
	  top: 13px;
	  width: 16px;
	  height: 6px;
	  border-bottom: 3px solid #fff;
	  border-left: 3px solid #fff;
	  transform: rotate(-45deg);
	}
	body .result_popup .reject_icon {
	  background: #989898;
	}
	body .result_popup .reject_icon .inner_circle  {
	  display: inline-block;
	  width: 40px;
	  height: 40px;
	  position: relative;
	  top: -3px;
	  left: -3px;
	  background: #F66363;
	  border-radius: 50%;
	}
	body .result_popup .reject_icon:before {
	  display: block;
	  content: "";
	  height: 18px;
	  width: 3px;
	  background-color: #fff;
	  margin: auto;
	  border-radius: 1px;
	  transform: rotate(-45deg);
	  position: absolute;
	  top: 11px;
	  right: 0px;
	  left: 0px;
	  z-index: 1;
	}
	body .result_popup .reject_icon:after {
	  display: block;
	  content: "";
	  height: 18px;
	  width: 3px;
	  border-radius: 1px;
	  background-color: #fff;
	  position: absolute;
	  margin: auto;
	  top: 11px;
	  transform: rotate(45deg);
	  right: 0px;
	  left: 0px;
	}
	body #result_popup_error .reject_icon {
	  background: #dd5757;
	}
	body #result_popup_rejected .inner_circle {
	  background: #ADADAD;
	}
	
	
	
	body .result_popup .org_icon {
	  background: #989898;
	}
	body .result_popup .org_icon .inner_circle  {
	  display: inline-block;
	  width: 40px;
	  height: 40px;
	  position: relative;
	  top: -3px;
	  left: -3px;
	  background: #ADADAD;
	  border-radius: 50%;
	}
	body .result_popup .org_icon:before {
	  display: block;
	  height: 16px;
	  width: 3px;
	  font-size:16px;
	  margin: auto;
	  border-radius: 1px;
	  position: absolute;
	  color:white;
	  top: 11px;
	  right: 0px;
	  left: -2px;
	  z-index: 1;
	}
	
	body #result_popup_error .org_icon {
	  background: #9f9f9f;
	}
	body #result_popup_rejected .inner_circle {
	  background: #ADADAD;
	}
	
	  
	body .result_popup .success_otp_redirection_url
	{
		width:auto;
		height:40px;
		font-weight:600;
		text-align:center;
		padding:12px 30px;
		border-radius:3px;
		background-color:#1389E3;
		outline:none;
		border:none;
		color:white;
		cursor:pointer;
		margin-bottom:30px;
	}
	
	.flex-container.result_align{
		padding-top:10%;
	}
	
	.primary_btn_check {
	    height: 40px;
	    line-height: 40px;
	    margin-left: auto;
	    margin-top: 20px;
	}
	
	.textbox, .split_otp_container {
	    display: inline-block;
	    width: 320px;
	    height: 42px;
	    border: none;
	    outline: none;
	    box-sizing: border-box;
	    border: 1px solid #DCDCDC;
	    border-radius: 6px;
	    font-size: 14px;
	    text-indent: 10px;
	}
	
	@keyframes spin
	{
		0% {transform: rotate(0deg);}
		100% {transform:rotate(360deg);}
	}
	
	#footer{
		font-size: 14px;
		color: #727272;
		text-align: center;
	}
	
	#footer a{
		text-decoration:none;
	}
	
	.center{
		justify-content:center;
	}
	
	.result_align{
		justify-content: center;
		position:relative;
	}
	
	.result_align .content_container{
		padding:0px;
	}
	
	
	.selectbox--focus, textbox {
		 border:1px solid #0f090933 !important;
	}
  
      .selectbox_arrow b{
      	top:-4px;
      }
      
      .select_icon + .select_input{
      	width: auto !important;
      	margin-left: 5px;
    	margin-right: 3px;
    	padding:0px !important;
    	text-align:left;
      }
      
      .select_container_cntry_code{
      	margin-left:0px;
      }
      
      .selectbox--open{
      	border: 1px solid #1389e3 !important;
    	border-radius: 4px 4px 0px 0px;
      }
      
      .select_container_cntry_code ~ input.textindent58 {
        text-indent: 76px !important;
      }
      .select_container_cntry_code ~ input.textindent66 {
        text-indent: 83px !important;
      }
      .select_container_cntry_code ~ input.textindent78 {
        text-indent: 92px !important;
      }
      
      .didnt_receive{
      	font-weight:500;
      	color:black;
      	display:inline-block;
      	color:#626262;
      }
         
      #mobile_input,#email_input{
      	border:1px solid #D6D6D6;
      }
      
      #mobile_input:hover, #mobile_input:focus , #email_input:hover , #email_input:focus , #otp_split_input:hover , #otp_split_input:focus , #captcha:hover , #captcha:focus {
      	border:1px solid #B2B2B2 !important;
      }
      
      .errorborder , #mobile_input.errorborder:focus  , #email_input.errorborder:focus , #otp_split_input.errorborder:focus , #captcha.errorborder:focus {
        border: 2px solid #ff8484 !important;
      }
      
      .configure_desc b{
      	text-transform:capitalize;
      }
      
      #error_space.yellow_error{
      	background-color:#FFF9E7;
      	border:1px solid #EBE0BE;
      	transition:transform 0.3s;
      }
      
      .yellow_error .error_icon{
      	background-color:#EDB211;	
      }
      
      #error_space.yellow_error:hover{
      	transform:scale(1.05);
      }
      
      .close_btn{
        display: inline-block;
	    border-radius: 5px;
	    cursor: pointer;
	    position: absolute;
	    right: 0px;
	    top: 0px;
	    width: 18px;
	    height: 18px;
	    transition: transform 0.1s;
	    z-index:1;
	    margin:4px;
      }
      
      .close_btn:before {
	    display: block;
	    content: "";
	    height: 12px;
	    width: 2px;
	    background-color: #DECD98;
	    margin: auto;
	    border-radius: 1px;
	    transform: rotate(-45deg);
	    position: absolute;
	    top: 0px;
	    left: 0px;
	    right: 0px;
	    bottom: 0px;
	    transition: transform 0.1s;
	}
	
	.close_btn:after {
	    display: block;
	    content: "";
	    height: 12px;
	    width: 2px;
	    border-radius: 1px;
	    background-color: #DECD98;
	    position: absolute;
	    margin: auto;
	    top: 0px;
	    right: 0px;
	    bottom: 0px;
	    left: 0px;
	    transform: rotate(45deg);
	    transition: transform 0.1s;
	}
	
	.close_btn:hover::before{
		transform: scale(1.2) rotate(-45deg);
	}
	
	.close_btn:hover::after{
		transform: scale(1.2) rotate(45deg);
	}
	
	
	.hide{
    	display: none;
	}
	
	 .white{
		border-bottom-color: #ffffff;
		border-left-color: #ffffff;
	  }
	   
	   
	   
	 @keyframes tick {
        0% {
          width: 0px;
        }
        100% {
          width: 10px;
        }
      }
   
      @media only screen and (min-width: 435px) and (max-width: 980px) {
        .flex-container {
          padding: 50px 25px 0px 25px;
        }
        .illustration-container {
          display: none;
        }
        .content_container {
          padding: 0;
          margin: auto;
        }
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
      }
      
      @media only screen and (max-width : 500px){
		body .result_popup{
		 	width:90%;
		 }
		 	 
		 .email_input_container{
		 	width:100%;
		 }
		 
		 #email_input{
		 	width:100%;
		 }
		 .flex-container.result_align{
			padding-top:20%;
		}
		body .result_popup .reject_icon,body .result_popup .success_icon,body .result_popup .org_icon, {
			bottom:10px;
		}
			 
	}
     

	@media only screen and (max-width: 435px){
	
		 .flex-container {
          padding: 50px 20px 0px 20px;
        }
        .content_container {
          width: 100%;
          padding: 0;
        }
        .illustration-container {
          display: none;
        }
        .otp_input_container {
          width: 100%;
        }
        .mobile_input_container {
          width: 100%;
        }
        #mobile_input {
          width: 100%;
        }
        button {
          width: 100%;
        }
        .countNameAddDiv,.phone_code_label+select
		{
			position:absolute;
		}
		
		#countNameAddDiv{
			height:42px;
		}
		
		 #select_phonenumber_input{
		 	text-indent:65px;
		 }
		 
		 body .result_popup{
		 	width:90%;
		 	
		 }
		 
		 .selectbox_options_container--open{
		 	width: calc(100% - 40px) !important;
		 }
	
		body .result_popup .org_icon , body .result_popup .reject_icon , body .result_popup .success_icon
			 {
			 	bottom:11%;
		 	}
		 	#footer a, #footer {
    			font-size: 12px;
		 	} 
	}
	
	@media only screen and (max-width: 320px){
		body .result_popup .org_icon , body .result_popup .reject_icon , body .result_popup .success_icon
			 {
			 	bottom:9%;
		 	}
	}
	
	   
    </style>
    <#if !(block_add_recovery || block_mob_num_addition)>
    <script>
      	var csrfParam= "${za.csrf_paramName}";
      	var csrfCookieName = "${za.csrf_cookieName}";
      	var contextpath = "${za.contextpath}";
      	var resendTimer, resendtiming, altered;
     	<#if country_code??>var countryDialCode = "${user_dialing_code}"; </#if>
     	<#if req_country??>var userCountryCode = "${req_country}";</#if>
		var isMobile = <#if is_mobile_ua> true; <#else> false; </#if>
		var mobileNumber="";
		var emailormobilevalue = "";
		var mobileScreen=<#if is_email>false<#else>true</#if>;	
		var is_recovery = <#if is_recovery>true<#else>false</#if>;
		var is_primary = <#if is_primary>true<#else>false</#if>;
		var prefilledEmail = <#if email??>"${email}";<#else>"";</#if>
		var showMobileNoPlaceholder = <#if mob_plc_holder>true;<#else>false;</#if>
		var captcha_digest = "";
		var iam_search_text = "<@i18n key="IAM.SEARCHING"/>";
		var iam_no_result_found_text = "<@i18n key="IAM.NO.RESULT.FOUND"/>";
		var resendCount=3;
		var app_display_name = "${app_display_name}";
		var otp_length = ${otp_length};
		var captcha_error_img = "${SCL.getStaticFilePath("/v2/components/images/hiperror.gif")}";
		<#if redirect_url??>var redirection = "${redirect_url}";</#if>
		
		
		I18N.load({
      	"IAM.GENERAL.OTP.SUCCESS" : '<@i18n key="IAM.GENERAL.OTP.SUCCESS"/>',
      	"IAM.ERROR.VALID.OTP" : '<@i18n key="IAM.ERROR.VALID.OTP"/>',
      	"IAM.GENERAL.ERROR.INVALID.OTP" : '<@i18n key="IAM.GENERAL.ERROR.INVALID.OTP"/>',
      	"IAM.ERROR.EMAIL.INVALID" : '<@i18n key="IAM.ERROR.EMAIL.INVALID"/>',
      	"IAM.PHONE.ENTER.VALID.MOBILE_NUMBER" : '<@i18n key="IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"/>',
	  	"IAM.GENERAL.OTP.SENDING" : '<@i18n key="IAM.GENERAL.OTP.SENDING"/>',
	  	"IAM.VERIFIED" : '<@i18n key="IAM.VERIFIED"/>',
	  	"IAM.TFA.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.TFA.RESEND.OTP.COUNTDOWN"/>',
	  	"IAM.ERROR.GENERAL" : '<@i18n key="IAM.ERROR.GENERAL"/>',
	  	"IAM.ERROR.RELOGIN.UPDATE" : '<@i18n key="IAM.ERROR.RELOGIN.UPDATE"/>',
	  	"IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"/>',
	  	"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND"/>',
	  	"IAM.SEARCHING": '<@i18n key="IAM.SEARCHING"/>',
	  	"IAM.ERROR.EMPTY.FIELD":'<@i18n key="IAM.ERROR.EMPTY.FIELD"/>',
	  	"IAM.MOBILE.OTP.REMAINING.COUNT" : '<@i18n key="IAM.MOBILE.OTP.REMAINING.COUNT"/>',
	  	"IAM.RESEND.OTP.COUNTDOWN" : '<@i18n key="IAM.RESEND.OTP.COUNTDOWN"/>',
	  	"IAM.MOBILE.OTP.MAX.COUNT.REACHED" : '<@i18n key="IAM.MOBILE.OTP.MAX.COUNT.REACHED"/>',
	  	"IAM.NEW.SIGNIN.RESEND.OTP" : '<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>',
	  	"IAM.CONFIG.RESEND" : '<@i18n key="IAM.CONFIG.RESEND"/>',
	  	"IAM.ERROR.MAX.SIZE.FIELD" : '<@i18n key="IAM.ERROR.MAX.SIZE.FIELD"/>',
	  	"IAM.SIGNIN.ERROR.CAPTCHA.INVALID" : '<@i18n key="IAM.SIGNIN.ERROR.CAPTCHA.INVALID"/>'
	  });
	  
	  function handleEditOption(mode) {
	  	$(".resend_otp").removeClass("nonclickelem").html("<span class='loader'></span><@i18n key='IAM.GENERAL.OTP.SENDING'/>");
	  	clearError("#"+ mode +"_input");
	  	$(document.confirm_form).show();
	  	$(".captcha_desc").hide();
	  	$(".verify_btn").hide();
	  	$(".otp_input_container, .otp_sent_desc").hide();
        $(".mobile_input_container").show();
        $(".email_input_container").show();
	  	document.querySelector(".send_otp_btn").style.display = "inline-block";
        altered = false
        
        
        if (!resendtiming == 0) {
          $(".send_otp_btn").prop("disabled", true);
        }
       
        document.querySelector("#" + mode + "_input").focus();
        if(!mobileScreen){
       	 document.querySelector("#" + mode + "_input").value = emailormobilevalue;
        }else{
        	if(showMobileNoPlaceholder){
	       	 	document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobileNumber.toString());
	       	 }
	       	 else{
	       	 	document.querySelector("#" + mode + "_input").value =  mobileNumber;
	       	 }
        }
        
        $(".verify_btn").html("<@i18n key="IAM.NEW.SIGNIN.VERIFY"/>");
        $(".verify_btn").prop("disabled", true);
        $(".send_otp_btn .loading").html("").hide();
      }
	  
	  function sendOTP(mode, emailormobilevalue, isExistingUnverfied) {
      	$("#error_space").removeAttr("onclick");
      	$(".send_otp_btn").prop("disabled", true);
        if (!mobileScreen) {
        	if (isEmailId(emailormobilevalue)) {
        		emailormobilevalue=emailormobilevalue.trim();
        		$("span.valueemailormobile").html(emailormobilevalue);
        		$(".send_otp_btn span.loading").html("<div class='loader'></div>").show();
        		if(is_primary){
        			var params = "email=" + euc(emailormobilevalue)+ "&primary=true";
            	}
            	else{
            		var params = "email=" + euc(emailormobilevalue);
            	}
            	sendRequestWithCallback("/setup/email/otp/send",params, true, handleOtpSent, "POST");
          	} else {
             show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
             $(".send_otp_btn").removeAttr("disabled");
          	}
        } else{
          	if (isPhoneNumber(mobileNumber)) {
          		countryCode = emailormobilevalue.substring(emailormobilevalue.length-2);
          		emailormobilevalue = emailormobilevalue.substring(0,emailormobilevalue.length-2);
          		$("span.valueemailormobile").html(emailormobilevalue);	
        		$(".send_otp_btn span.loading").html("<div class='loader'></div>").show();
          		var params = "mobile=" + mobileNumber + "&country_code="+countryCode;
          		if(!is_recovery){
           			sendRequestWithCallback("/setup/screenmobile/otp/send", params, true, handleOtpSent, "POST");
           		}
           		else{
           		 	sendRequestWithCallback("/setup/recoverymobile/otp/send", params, true, handleOtpSent, "POST");
           		}
          	} else {
          		show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          		$(".send_otp_btn").removeattr("disabled");
          	}
        }
      }
      
      function handleOtpSent(respStr){
      	var mode = (mobileScreen)?"mobile":"email";
      	respStr=JSON.parse(respStr);
      	if(respStr.status == "success"){
      		if(respStr.message == "vercode"){
      			$("#error_space").remove("show_error");
      			$(".close_btn").hide();
      			$(".captcha_desc").hide();
      			clearError('#otp_split_input');
				document.querySelector(".edit_option").style.display = "inline-block";
				if($("#captcha_container").is(":visible")){
					$("#captcha_container").slideUp(200);
				}
				$(document.forms.confirm_form1).attr("onsubmit","verifyCode(event);return false");
				$(".verify_btn").html("<@i18n key="IAM.NEW.SIGNIN.VERIFY"/>").show();
				$(".send_otp_btn, ."+ mode +"_input_container,.back_btn").slideUp(200);
      			$(".otp_input_container, .otp_sent_desc").slideDown(200,function(){
      				$("#otp_split_input").click();
      			});
				setTimeout(function(){
					$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
					setTimeout(function(){
						resendOtpChecking();
					}, 1000);
				}, 800);
      		}
      		else{//email already verified
	      			show_error_msg("#email_input","<@i18n key="IAM.EMAIL.ALREADY.VERIFIED.TEXT"/>");
	      			$(".send_otp_btn").removeAttr("disabled");
	      			
      		}
      	}
      	
      	else if(respStr.code=="U136"){ //invalid session
      		$(".configure_header,.configure_desc,.form_container,.otp_sent_desc,.illustration-container").hide(0,function(){
      				$("#result_popup_error .result_probability").addClass("reject_icon");
		      		$("#result_content").html("<@i18n key="IAM.CONFIG.SESSION.EXPIRED"/>");
		      		$(".defin_text").html("<@i18n key="IAM.CONFIG.SESSION.EXPIRED.REFRESH"/>");
		      		$("#result_popup_error svg path")[0].style.fill="#FF00000A";
		      		$(".success_otp_redirection_url").attr("onclick","window.location.href=''").html("<@i18n key="IAM.REFRESH"/>");
      				$(".flex-container").addClass("result_align");
					$(".icon-NewZoho").addClass("center");
					$(".result_popup").show();
			});
      	}
      	
      	else if(respStr.code == "PP112"){//relogin
      		var service_url = window.location.href;
      		$("#error_space").addClass("yellow_error").attr("onclick","window.open('"+contextpath + respStr.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");
      		showErrMsg(I18N.data["IAM.ERROR.RELOGIN.UPDATE"]);
      		$(".send_otp_btn").removeAttr("disabled");
      		setTimeout(function(){
      			$(".close_btn").show();
      		},10000);
      	}
      	else if(respStr.code == "IN108"){//captcha required
      		$(".captcha_desc").show();
      		loadCircleAnimation(true);
      		$(document.forms.confirm_form1).attr("onsubmit","return verifyCaptcha(document.confirm_form1)");
      		$(".verify_btn").html("<span></span><@i18n key="IAM.NEXT"/>").show();
      		$(document.confirm_form).hide();
      		showHip(respStr);
      	}
     	else if(respStr.code == "IN107"){//incorrect captcha
     		 showCaptchaError(respStr.error_msg,1);
     		 captcha_digest = respStr.cdigest;
     		 $("#reload").addClass("load_captcha_btn");
     		 showHip(respStr);
     		 setTimeout(function(){
				$("#reload").removeClass("load_captcha_btn");
			 },500);
     	}
      	else if(respStr.code == "PH105" || respStr.code == "PH109"){//invalid mobile number  //OTP couldn't be sent. Please try again after some time.
      		//this flow comes from after captcha entered
      	
      		show_error_msg("#mobile_input",respStr.message);
      		$(".send_otp_btn").removeAttr("disabled");
      		if($("#captcha_container").is(":visible")){
      			setTimeout(function(){
      				$("#captcha_container").hide(0,function(){
      					$(document.confirm_form1).children(".verify_btn").hide();
      					$(document.confirm_form).show();
      					$(".mobile_input_container").show();
	      				document.querySelector("#" + mode + "_input").value = phonePattern.setSeperatedNumber(phonePattern.getCountryObj($("#countNameAddDiv").val()), mobileNumber.toString());
      				});
	      		},500);	
      		}
      	}
      	else if(respStr.code == "U138" || respStr.code == "U106" || respStr.code == "AS112"){//mobile number already registered  //marked as spam
      		if(mobileScreen){
      			show_error_msg("#mobile_input",respStr.message);
      		}
      		else{
      			show_error_msg("#email_input",respStr.message);
      		}
      		
      		$(".send_otp_btn").removeAttr("disabled");
      	}
      	else{
      		if("message" in respStr){
	  			if(mobileScreen){
	  				if($("#captcha_container").is(":visible")){
	  					showCaptchaError(respStr.message,1);
	  				}
	  				else{
	  					show_error_msg("#mobile_input",respStr.message);
	  				}
  					
  				}
  				else{
  					show_error_msg("#email_input",respStr.message);
  				}
	  		}
	  		else{
	  			if(mobileScreen){
  					if($("#captcha_container").is(":visible")){
	  					showCaptchaError(respStr.localized_message,1);
	  				}
	  				else{
	  					show_error_msg("#mobile_input",respStr.localized_message);
	  				}
  				}
  				else{
  					show_error_msg("#email_input",respStr.localized_message);
  				}
	  		}
      		$(".send_otp_btn").removeAttr("disabled");
      	}
      	$(".verify_btn span").html("");
      	$(".verify_btn").prop("disabled",false);
      	$(".send_otp_btn .loading").html("").prop("disabled",false).hide();
	  }
	  
	  function resendOTP(){
	  	$(".resend_otp").html("<div class='loader'></div>"+I18N.get('IAM.GENERAL.OTP.SENDING'));
	  	if(!mobileScreen){
	  		var params = "email=" + euc(emailormobilevalue);
	        sendRequestWithCallback("/setup/email/otp/resend",params, true, handleOtpResent, "POST");
	    }
	    else{
	    	var params = "mobile=" + mobileNumber;
	    	if(!is_recovery){
           			sendRequestWithCallback("/setup/screenmobile/otp/resend", params, true, handleOtpResent, "POST");
           		}
           		else{
           		 	sendRequestWithCallback("/setup/recoverymobile/otp/resend", params, true, handleOtpResent, "POST");
           		}
	   		 }
	  }
	  
	  function handleOtpResent(respStr){
	  	respStr=JSON.parse(respStr);
	  	if(respStr.status == "success"){
	  		--resendCount;
	  		$("#error_space").remove("show_error");
      		$(".close_btn").hide();
	  		setTimeout(function(){
				$(".resend_otp").html("<div class='tick'></div>"+I18N.get('IAM.GENERAL.OTP.SUCCESS'));
				setTimeout(function(){
					resendOtpChecking();
				}, 1000);
			}, 800);
	  	}
	  	else if(respStr.code == "PP112"){
      		var service_url = window.location.href;
      		$("#error_space").addClass("yellow_error").attr("onclick","window.open('"+contextpath + respStr.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");
      		showErrMsg(I18N.data["IAM.ERROR.RELOGIN.UPDATE"]);
      		$(".send_otp_btn").removeAttr("disabled");
      		
      		if(mobileScreen){
	      		if(resendCount == 3){
		  			$(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
		  		}
		  		else{
		  			$(".resend_otp").html('<span class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</span> ',""+resendCount) + I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
		  		}
		  	}
		  	else{
		  		$(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
		  	}
	  		setTimeout(function(){
      			$(".close_btn").show();
      		},10000);
      	}
	  	else{
	  		if("message" in respStr){	
	  			show_error_msg("#otp_split_input",respStr.message);
	  		}
	  		else{
	  			show_error_msg("#otp_split_input",respStr.localized_message);
	  		}
	  		if(mobileScreen){
	      		if(resendCount == 3){
		  			$(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
		  		}
		  		else{
		  			$(".resend_otp").html('<span class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</span> ',""+resendCount) + I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
		  		}
		  	}
		  	else{
		  		$(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
		  	}	
	  	}
	  }
	  function updateEmlMblValue(mode) {
        clearError('#'+mode+'_input');
        var splitinput = document.querySelectorAll("input.splitedText");
        for (var x=0;x<splitinput.length;x++){
        	splitinput[x].value = "";
        }
        if (!mobileScreen) {
          var login_id = $("#email_input").val().trim();
          if (isEmailId(login_id)) {
          	emailormobilevalue = login_id;
          	if(!(login_id.trim().length<=100)){
          		show_error_msg("#email_input", I18N.get("IAM.ERROR.MAX.SIZE.FIELD"));
          		return false;
          	}
            sendOTP(mode, login_id);
          }else{
            show_error_msg("#email_input", I18N.get("IAM.ERROR.EMAIL.INVALID"));
          }
        }
        else{
          var login_id = $("#mobile_input").val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
          if (isPhoneNumber(login_id)) {
          	mobileNumber = login_id;
          	var dialCode = $('#countNameAddDiv option:selected').attr("data-num");
          	var countryCode = $('#countNameAddDiv option:selected').attr("id");
          	emailormobilevalue=dialCode+" "+login_id+countryCode;
          	sendOTP(mode, emailormobilevalue);
          }else{
          show_error_msg("#mobile_input", I18N.get("IAM.PHONE.ENTER.VALID.MOBILE_NUMBER"));
          }
        }
      }
	  
	  function resendOtpChecking() {
	  
	  <#if is_email>
	  	resendtiming = 60;
        clearInterval(resendTimer);
        $(".resend_otp").addClass("nonclickelem");
        $(".resend_otp .seconds").text(resendtiming);
        $(".resend_otp").html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
        $(".send_otp_btn").prop("disabled", true);
        resendTimer = setInterval(function () {
          resendtiming--;
          $(".resend_otp span").html(resendtiming);
          $(".send_otp_btn .seconds").show();
          if(!altered){
          $(".send_otp_btn .seconds").css("margin-left","5px").html(resendtiming+"s");
          }
          if (resendtiming === 0) {
            clearInterval(resendTimer);
            $(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
            $(".send_otp_btn .seconds").css("margin","0px").html("").hide();
            $(".send_otp_btn").removeAttr("disabled");
            if($(".email_input_container").is(":visible")){
            	$(".resend_otp").removeClass("nonclickelem").html("<span class='loader'></span><@i18n key='IAM.GENERAL.OTP.SENDING'/>");
            }
          }
        }, 1000);
        
        
	  <#else>
	  
	  
	  	resendtiming = 60;
        clearInterval(resendTimer);
        $(".resend_otp").addClass("nonclickelem");
        if(resendCount < 3 ){
	        if(resendCount > 0){
	       		$(".resend_otp").html('<span class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</span> ',""+resendCount) + I18N.get('IAM.RESEND.OTP.COUNTDOWN'));
	        }
	        else{
        		$(".resend_otp").addClass("nonclickelem").html(I18N.get("IAM.MOBILE.OTP.MAX.COUNT.REACHED"));
       		}
        }
        else{
        	$(".resend_otp").html(I18N.get('IAM.TFA.RESEND.OTP.COUNTDOWN'));
        }
        $(".send_otp_btn").prop("disabled", true);
        resendTimer = setInterval(function () {
        resendtiming--;
         if(resendCount < 3 ){
         	if(resendCount > 0){
        		$(".resend_otp").html('<div class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</div> ',""+resendCount) + I18N.get('IAM.RESEND.OTP.COUNTDOWN'));
        		$(".resend_otp span").html(resendtiming);
        	}
        	else{
        		$(".resend_otp").addClass("nonclickelem").html(I18N.get("IAM.MOBILE.OTP.MAX.COUNT.REACHED"));
       		}
         
         }
         else{
         	$(".resend_otp span").html(resendtiming);
         }
          
          if(!altered){
          $(".send_otp_btn span.seconds").css("margin-left","5px").html(resendtiming+"s").show();
          }  
          if (resendtiming === 0) {
            clearInterval(resendTimer);
            if(resendCount < 3 ){
	         	if(resendCount > 0){
	        		$(".resend_otp").html('<span class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</span> ',""+resendCount) + I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
	        	}
        	}
            else{
            	$(".resend_otp").addClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
            }
            
            if(resendCount > 0){
            	$(".resend_otp").removeClass("nonclickelem");
            }
            if($(".mobile_input_container").is(":visible")){
            	$(".resend_otp").removeClass("nonclickelem").html("<span class='loader'></span><@i18n key='IAM.GENERAL.OTP.SENDING'/>");
            }
            
            $(".send_otp_btn span.seconds").css("margin","0px").html("").hide();
            $(".send_otp_btn").removeAttr("disabled");
          }
        }, 1000);
	  </#if>
      }
      
      function verifyCode(event) {
      	$("#error_space").removeAttr("onclick");
      	clearError("#otp_split_input");
        var Code = document.querySelector("#otp_split_input_full_value").value;
        if(Code == ""){
			show_error_msg("#otp_split_input", I18N.get("IAM.ERROR.EMPTY.FIELD"));//No I18N
			return false;
		}
        if(isValidCode(Code)){
	        clearError('#otp_split_input',event);
	        $(".verify_btn").html("<span><div class='loader white'></div></span>"+"<@i18n key="IAM.NEW.SIGNIN.VERIFY"/>");
	        $(".verify_btn").prop("disabled", true);
	       	if(!mobileScreen){        
	        	if(is_primary){
	        		var params = "primary=true&email=" + euc(emailormobilevalue) + "&otp="+Code;
	        	}
	        	else{
	        		var params = "email=" + euc(emailormobilevalue) + "&otp="+Code;
	        		
	        	}
	        	sendRequestWithCallback("/setup/email/otp/verify",params, true, handleVerifyCode, "POST");
	        }
	        else{
	        	var params = "mobile=" + mobileNumber + "&otp="+Code;
	        	if(!is_recovery){
	        		sendRequestWithCallback("/setup/screenmobile/otp/verify",params, true, handleVerifyCode, "POST");
	        	}
	        	else{
	        		sendRequestWithCallback("/setup/recoverymobile/otp/verify",params, true, handleVerifyCode, "POST");
	        	}
	        	
	        } 
        }
        else{
	        $(".verify_btn span").html("");
	        $(".verify_btn").prop("disabled", false);
	        show_error_msg("#otp_split_input", I18N.get('IAM.ERROR.VALID.OTP'));
        }
      }
		
	  function handleVerifyCode(respStr){
	  
	  	respStr=JSON.parse(respStr);
	  	
	  	if(respStr.status == "success"){
	  		$(".resend_otp").css("visibility","hidden");
	  		$("#error_space").remove("show_error");
      		$(".close_btn").hide();
			setTimeout(function(){
				$(".configure_header,.configure_desc,.form_container,.otp_sent_desc,.illustration-container").hide(0,function(){
					if(mobileScreen){
						emailormobilevalue=emailormobilevalue.slice(0,emailormobilevalue.length-2);
					}
					if(window.location.href.indexOf("servicename") > -1  ){
						$(".success_otp_redirection_url span").show();
					}
					else{
						$(".success_otp_redirection_url span").hide();
					}
					$(".result_popup .defin_text").html(formatMessage($(".result_popup .defin_text").html(),emailormobilevalue));
					$(".result_popup .result_probability").addClass("success_icon");
					$(".flex-container").addClass("result_align");
					$(".icon-NewZoho").addClass("center");
					$(".result_popup").show();
				});
				
				$(".success_otp_redirection_url").attr("onclick","window.location.href='"+redirection+"'");
			},1000);
	  	}
	  	else if(respStr.code == "PP112"){
      		var service_url = window.location.href;
      		$("#error_space").addClass("yellow_error").attr("onclick","window.open('"+contextpath + respStr.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");
      		showErrMsg(I18N.data["IAM.ERROR.RELOGIN.UPDATE"]);
      		$(".verify_btn").removeAttr("disabled");
      		$(".verify_btn span").html("");
      		setTimeout(function(){
      			$(".close_btn").show();
      		},10000);
      	}
      	
	  	else{
	  		if("message" in respStr){
	  			show_error_msg("#otp_split_input",respStr.message);
	  		}
	  		else{
	  			show_error_msg("#otp_split_input",respStr.localized_message);
	  		}
	  		$(".verify_btn span").html("");
	  		$(".verify_btn").prop("disabled", false);
	  	}
	  }
	  
	  function show_error_msg(siblingClassorID, msg) {
	  	$(".error_msg").remove();
        var errordiv = document.createElement("div");
        errordiv.classList.add("error_msg");
        $(errordiv).html(msg);
        $(errordiv).insertAfter(siblingClassorID);
        $(siblingClassorID).addClass("errorborder")
        $(".error_msg").slideDown(150);
      }
      
      function clearError(ClassorID,e){
      	if( e && e.keyCode == 13 && $(".error_msg:visible").length){
			return;
		}
      	$(ClassorID).removeClass("errorborder");
        $(".error_msg").remove();
      }
      
      
      
	   
      function allowSubmit(e) {
        if (!mobileScreen && (emailormobilevalue === e.target.value || emailormobilevalue === "")) {
          altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        }
        else if(mobileScreen && (mobileNumber === e.target.value.replace(/[+ \[\]\(\)\-\.\,]/g,'') || mobileNumber === "")){
        	altered=false;
          if (!resendtiming == 0) {
            $(".send_otp_btn").prop("disabled", true);
          }
        } 
        else {
        altered = true;
        resendCount=3;
          $(".send_otp_btn span").html("");
          $(".send_otp_btn").prop("disabled", false);
        }
      }
      
      function phonecodeChangeForMobile(ele){
		$(ele).css({'opacity':'0','width':'60px','height':'42px'});
		$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
		$(ele).change(function(){
			$(ele).siblings(".phone_code_label").html($(ele).children("option:selected").attr("data-num"));
	    })
	  }
	  
	  function sendRequestWithCallback(action, params, async, callback,method){
		if (typeof contextpath !== 'undefined' && contextpath!="") {
			action = contextpath + action;
		}
    	var objHTTP = xhr();
    	objHTTP.open(method?method:'POST', action, async);
    	if(method != "GET"){
    		objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    	}
    	objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+euc(getCookie(csrfCookieName)));
    	if(async){
			objHTTP.onreadystatechange=function() {
	    	if(objHTTP.readyState==4) {
	    		if (objHTTP.status === 0 ) {
					showErrMsg("<@i18n key="IAM.PLEASE.CONNECT.INTERNET"/>");
					if(resendCount == 3){
	  					$(".resend_otp").removeClass("nonclickelem").html("<@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/>");
	  				}
	  				else{
	  					$(".resend_otp").html('<span class="didnt_receive">'+formatMessage(I18N.get("IAM.MOBILE.OTP.REMAINING.COUNT")+'</span> ',""+resendCount) + I18N.get('IAM.NEW.SIGNIN.RESEND.OTP'));
	  				}
					$(".verify_btn").html("<@i18n key="IAM.NEW.SIGNIN.VERIFY"/>");
					$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", true);
					checkNetConnection();
					return false;
				}
				if(callback) {
					if(JSON.parse(objHTTP.responseText).code === "Z113"){
						$(".configure_header,.configure_desc,.form_container,.otp_sent_desc,.illustration-container").hide(0,function(){
	      				$("#result_popup_error .result_probability").addClass("reject_icon");
			      		$("#result_content").html("<@i18n key="IAM.CONFIG.SESSION.EXPIRED"/>");
			      		$(".defin_text").html("<@i18n key="IAM.CONFIG.SESSION.EXPIRED.REFRESH"/>");
			      		$("#result_popup_error svg path")[0].style.fill="#FF00000A";
			      		$(".success_otp_redirection_url").attr("onclick","window.location.href=''").html("<@i18n key="IAM.REFRESH"/>");
	      				$(".flex-container").addClass("result_align");
						$(".icon-NewZoho").addClass("center");
						$(".result_popup").show();
					});
					return false;
					}
					callback(objHTTP.responseText);
				}
			}
		};
    	} 
    	if(params == "" || params == undefined || params == null){
    		objHTTP.send();
    	}
		else{
			objHTTP.send(params);
		}
		if(!async) {
			if(callback) {
				callback(objHTTP.responseText);
			}
		}
	  }
	  
	  function checkNetConnection(){
	  	setInterval(function(){
	  		if(window.navigator.onLine){
	  			$(".verify_btn, .resend_otp, .send_otp_btn").prop("disabled", false);
	  			$(".verify_btn span").html("");
	  			$(".send_otp_btn span.loading").html("").hide();
	  			if($("#captcha_container").is(":visible")){
	  				$(".verify_btn").html("<span></span><@i18n key="IAM.NEXT"/>");
	  			}
	  			setTimeout(function(){
	  				$("#error_space").remove("show_error");
					$(".top_msg").html("");
					$("#error_space").hide();
	  			},2000);
	  		}
	  	}, 2000)
	  }
 
	  function showErrMsg(msg)
	  {
		document.getElementById("error_space").classList.remove("show_error");
	    document.getElementsByClassName('top_msg')[0].innerHTML = msg; //No I18N
	    document.getElementsByClassName("error_icon")[0].classList.add("cross_mark_error");
	    $("#error_space").show();
	    document.getElementById("error_space").classList.add("show_error");
	    
		$("#error_space").click(function(){
			$("#error_space").remove("show_error yellow_error");
			$(".top_msg").html("");
			$("#error_space").hide();
		})
	  }
	  
	 
	  
	 //captcha block
	 
	 function loadCircleAnimation(add){
		if(add){
			$(".confirm_form").hide();
			$("#captcha_container .captchaloader").show().css("z-index",'5');
			$("#captcha_container .box_blur").show();
			$("#captcha_container").show();
		}
		else{
			$("#captcha_container .box_blur").hide();
			$("#captcha_container .captchaloader").hide();
		}
	}

	function showHip(resp){
		if(typeof resp == "string"){
			resp = JSON.parse(resp);
		}
		if(resp.cause==="throttles_limit_exceeded"){
			captcha_digest="";
			showCaptchaImg();
		}
		if('cdigest' in resp){
			captcha_digest=resp.cdigest;
		}
		else if('digest' in resp){
			captcha_digest=resp.digest;
		}
		sendRequestWithCallback("/webclient/v1/captcha/"+captcha_digest,"",true,showCaptchaImg,"GET");
	}
	
	function reloadCaptcha(){
		var params={"captcha":{"digest":captcha_digest,"usecase":"sms"}};//no i18N
		params= JSON.stringify(params);
		$("#reload").addClass("load_captcha_btn");
		sendRequestWithCallback("/webclient/v1/captcha",params,true,showHip,"POST");
		setTimeout(function(){
			$("#reload").removeClass("load_captcha_btn");
		},500);
	}
		
	function showCaptchaImg(resp){
		resp=JSON.parse(resp);
		if(captcha_digest == '' || resp.cause == "throttles_limit_exceeded" || resp.image_bytes == '' ){
			$("#hip")[0].src=captcha_error_img;
			return false;
		}
		else if(resp.status_code == 200 && (resp.captcha.image_bytes!='' && resp.captcha.image_bytes != null )){
			$("#captcha").val("");
			$("#hip")[0].src=resp.captcha.image_bytes;
			$("#captcha").attr('onclick','removeCaptchaError()');
		}
	}
	
	function verifyCaptcha(form){
		clearError("#captcha_container");//no i18N
		removeCaptchaError();
		var captchavalue = $("#captcha").val();
		if(captchavalue == null || captchavalue == "" || captchavalue == "null") 
		{		
			showCaptchaError(I18N.data["IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"],1);
			return false;
		}
		else if(!(/^[a-zA-Z0-9]*$/.test( captchavalue )) || captchavalue.length<6){
			showCaptchaError(I18N.data["IAM.SIGNIN.ERROR.CAPTCHA.INVALID"],1);
			return false;
		}
		$(".verify_btn span").html("<div class='loader white'></div>");
	    $(".verify_btn").prop("disabled", true);
		var params = "mobile=" + mobileNumber + "&country_code="+countryCode  + "&captcha=" + $("#captcha").val().trim() +"&cdigest=" + captcha_digest;    
        if(!is_recovery){
           	sendRequestWithCallback("/setup/screenmobile/otp/send", params, true, handleOtpSent, "POST");
        }
        else{
  		 	sendRequestWithCallback("/setup/recoverymobile/otp/send", params, true, handleOtpSent, "POST");
        }
        return false;
	}
	
	function removeCaptchaError(){
		$("#captcha").removeClass("errorborder");
		$(".captcha_field_error0,.captcha_field_error1").removeClass("errorlabel margin_captcha_field_error").text("").slideUp(200);
	}
	
	function showCaptchaError(message,num){
		$("#captcha").addClass("errorborder");
		$(".captcha_field_error"+num).addClass("errorlabel margin_captcha_field_error").html(message).slideDown(200);
		$("#captcha_container").attr('onkeypress','removeCaptchaError()').focus();
	}
	
	function closeReloginPopup(e){
		e.stopPropagation();
		$(".close_btn").hide();
		$("#error_space").remove("show_error yellow_error");
		$(".top_msg").html("");
		$("#error_space").hide();
	}
	
	function textIndent(length){
		$(".select_input.select_input_cntry_code").attr("size",length);
		if(length == 2){
			$(".textbox.select_phonenumber_input").addClass("textindent58");
			$(".textbox.select_phonenumber_input").removeClass("textindent66 textindent78");
		}
		else if(length == 3){
			$(".textbox.select_phonenumber_input").addClass("textindent66");
			$(".textbox.select_phonenumber_input").removeClass("textindent58 textindent78");
		}
		else{
			$(".textbox.select_phonenumber_input").addClass("textindent78");
			$(".textbox.select_phonenumber_input").removeClass("textindent58 textindent66");
		}
	}
	
	</script>
	</#if>
    </head>
    <body>
    <div id="error_space" style="top:-150px;">
		<span class="error_icon icon-warning"></span> <span class="top_msg"></span> <span class="close_btn hide" onclick="closeReloginPopup(event)"></span>
	</div>
	
	
	<#if (block_add_recovery || block_mob_num_addition)>
		<div id="blocking_container">
			<div class="icon-NewZoho logo_center">
	    		<span class="path1"></span>
	    		<span class="path2"></span>
	    		<span class="path3"></span>
	    		<span class="path4"></span>
	    		<span class="path5"></span>
	    		<span class="path6"></span>
		    </div>
			<div class="result_popup" id="result_popup_error">
				<div class="pop_bg">
					<svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 578 118">
						<path id="Path_4619" data-name="Path 4619" d="M4394,8408.59s-55.223,29.924-95.023,29.924c-97.791,0-173.495-49.193-282.564-49.193S3816,8434.855,3816,8434.855V8320.514h578Z" transform="translate(-3816 -8320.514)" fill="#F2F2F2"/>
					</svg>
					<div class="org_icon icon-warning"><span class="inner_circle"></span></div>
				</div>	
				<div class="content_space" style="padding:40px;padding-top:0px;padding-bottom:20px;">
						<#if block_mob_num_addition>
							<div class="grn_text" id="result_content"><@i18n key="IAM.MOBILE.NUMBER.RESTRICTED"/></div>
							<div class="defin_text"><@i18n key="IAM.CONFIG.BLOCK.ADD.LOGIN.NUMBER"/></div>
						<#else>
							<div class="grn_text" id="result_content"><@i18n key="IAM.MOBILE.NUMBER.RESTRICTED"/></div>
							<div class="defin_text"><@i18n key="IAM.CONFIG.BLOCK.ADD.RECOVERY.NUMBER"/></div>
						</#if>
						<span class="mail" onclick="copyClipboard(this)"><span class="icon-mail"></span>${org_contact}<div class="tooltip"><@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD"/></div><span class="icon-copy"></span></span>
						
				</div>
			</div>
		</div>	
	<#else>
	
	
		
	
	        	
	    <div class="flex-container container">
	    	<div class="content_container">
	        	<div class="icon-NewZoho">
	        		<span class="path1"></span>
	        		<span class="path2"></span>
	        		<span class="path3"></span>
	        		<span class="path4"></span>
	        		<span class="path5"></span>
	        		<span class="path6"></span>
	        	</div>
	        	<div class="result_popup" id="result_popup_error" style="display:none;">
				<div class="pop_bg">
					<svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 578 118">
						<path id="Path_4619" data-name="Path 4619" d="M4394,8408.59s-55.223,29.924-95.023,29.924c-97.791,0-173.495-49.193-282.564-49.193S3816,8434.855,3816,8434.855V8320.514h578Z" transform="translate(-3816 -8320.514)" fill="#DEFAE2"/>
					</svg>
					<div class="result_probability"><span class="inner_circle"></span></div>
				</div>
				<div class="content_space" style="padding:40px;padding-top:0px;padding-bottom:20px;">
					<#if (is_email && !is_primary)>
		        		<div class="grn_text" id="result_content"><@i18n key="IAM.CONFIG.EMAIL.ADDED.SUCCESSFULLY"/></div>
						<div class="defin_text"><@i18n key="IAM.CONFIG.SECONDARY.EMAIL.ADDED.SUCCESSFULLY.DESC"/></div>
					<#elseif ( is_email && is_primary)>
		        		<div class="grn_text" id="result_content"><@i18n key="IAM.CONFIG.EMAIL.ADDED.SUCCESSFULLY"/></div>
						<div class="defin_text"><@i18n key="IAM.CONFIG.EMAIL.ADDED.SUCCESSFULLY.DESC"/></div>
					<#elseif is_recovery>
						<div class="grn_text" id="result_content"><@i18n key="IAM.CONFIG.MOBILE.NUMBER.ADDED.SUCCESSFULLY"/></div>
						<div class="defin_text"><@i18n key="IAM.CONFIG.MOBILE.NUMBER.ADDED.SUCCESSFULLY.DESC"/></div>
					<#else>
						<div class="grn_text" id="result_content"><@i18n key="IAM.CONFIG.MOBILE.NUMBER.ADDED.SUCCESSFULLY"/></div>
						<div class="defin_text"><@i18n key="IAM.CONFIG.LOGIN.NUMBER.ADDED.SUCCESSFULLY.DESC"/></div>
	        		</#if>
				</div>
				<button class="success_otp_redirection_url"><@i18n key="IAM.CONFIG.SUCCESS.BUTTON" arg0="${app_display_name}"/></button>
		</div>
	        	
	        	
	        	
	       		<#if (is_email && !is_primary)>
	        		<div class="configure_header announcement_header"><@i18n key="IAM.CONFIG.MAIL.HEADER"/></div>
					<div class="configure_desc"><@i18n key="IAM.CONFIG.SECONDARYMAIL.HEADER.DESC" arg0="${app_display_name}"/></div>
				<#elseif ( is_email && is_primary)>
	        		<div class="configure_header announcement_header"><@i18n key="IAM.CONFIG.MAIL.HEADER"/></div>
					<div class="configure_desc"><@i18n key="IAM.CONFIG.PRIMARYMAIL.HEADER.DESC"/></div>
				<#elseif is_recovery>
					<div class="configure_header announcement_header"><@i18n key="IAM.CONFIG.NUMBER.HEADER"/></div>
					<div class="configure_desc"><@i18n key="IAM.CONFIG.NUMBER.DESC" arg0="${app_display_name}"/></div>
				<#else>
					<div class="configure_header announcement_header"><@i18n key="IAM.CONFIG.NUMBER.HEADER"/></div>
					<div class="configure_desc"><@i18n key="IAM.CONFIG.NUMBER.DESC" arg0="${app_display_name}"/></div>
	        	</#if>
	        	
	        	<div class="captcha_desc hide"><@i18n key="IAM.CONFIG.CAPTCHA.DESC"/></div>
	        	
	        		
	        	<div class="otp_sent_desc" style="display: none">
	        		<#if is_email>
	          			<@i18n key="IAM.DIGIT.VER.CODE.SENT.EMAIL"/>
	          		<#else>
	          			<@i18n key="IAM.DIGIT.VER.CODE.SENT.MOBILE"/>
	         		</#if>
	          		<div class="emailormobile">
	            		<span class="valueemailormobile"></span> 
	            		<#if is_email>
	           		 		<span class="edit_option" onclick="handleEditOption('email')"><@i18n key="IAM.EDIT"/></span>
	           		 	<#else>
	            			<span class="edit_option" onclick="handleEditOption('mobile')"><@i18n key="IAM.EDIT"/></span>
	            		</#if>
	          		</div>
	        	</div>
	        	
	        	<div class="form_container">
	          		<form name="confirm_form" onsubmit="return false">          		
	              		<#if is_email>
	          				<div class="enter_eml_mob_des hide"><@i18n key="IAM.EMAIL.SEND.OTP.VERIFY"/></div>
	          				<div class="email_input_container">
	           					<label for="email_input" class="emolabel" style="text-transform:capitalize;"><@i18n key="IAM.EMAIL.ADDRESS"/></label>
	             				<input type="text" id="email_input" autocomplete="off" onkeydown="clearError('#email_input')" oninput="allowSubmit(event)" />
	            			</div>
	            			<button class="send_otp_btn" onclick="updateEmlMblValue('email')"><span class="loading hide"></span><@i18n key="IAM.SEND.VERIFY"/><span class="seconds hide"></span></button>
	          			<#else>
	          				<div class="mobile_input_container" id="select_phonenumber">
	  							<label for="mobile_input" class="emolabel" style="text-transform:capitalize;"><@i18n key="IAM.NEW.SIGNIN.MOBILE"/></label>
	  							<#if is_mobile_ua><label for="countNameAddDiv" class="phone_code_label"></label><#else><label for="countNameAddDiv"></label></#if>	  							
	  							<select id="countNameAddDiv" class="profile_mode def_langu_populated" name="countrycode" id="localeLn" searchable="true" width="67px" embed-icon-class="flagIcons">
	  							<#list country_code as dialingcode>
									<option data-num="${dialingcode.dialcode}" value="${dialingcode.code}" id="${dialingcode.code}" >${dialingcode.display}</option>
	  							</#list>
	  							</select>
	  							<input class="textbox select_phonenumber_input" tabindex="0" autocomplete="off" onkeypress="clearError('#mobile_input')" name="mobile_no" id="mobile_input" maxlength="15" data-type="phonenumber" type="tel" oninput="allowSubmit(event)">
								<button class="send_otp_btn" onclick="updateEmlMblValue('mobile')"><span class="loading hide"></span><@i18n key="IAM.SEND.VERIFY"/><span  class="seconds hide" style="margin:0"></span></button>
							</div>
	         			</#if>	
	           		</form>
		           <form name="confirm_form1" onsubmit="verifyCode(event);return false" novalidate>
		              <div class="otp_input_container hide">
		              	<label for="otp_input" class="emolabel"><@i18n key="IAM.VERIFICATION.CODE"/></label>
		              	<div id="otp_split_input" class="otp_container"></div>
		              	<div class="resend_otp" onclick="resendOTP()"><span class="loader"></span><@i18n key="IAM.GENERAL.OTP.SENDING"/></div>
		              </div>
		              
		              <div class="field hide noindent" id="captcha_container">
						<div class="box_blur hide"></div>
						<div class="captchaloader hide"></div>
						<div id="captcha_img" name="captcha">
							<img id="hip" onload="loadCircleAnimation(false)">
						</div>
						<span class="reloadcaptcha icon-reload" id="reload" onclick="reloadCaptcha();removeCaptchaError()"></span>
						<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8">
						<div class="captcha_field_error0"></div>
					  </div>
					  <div class="captcha_field_error1"></div>
					  <button class="verify_btn hide"><span></span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></button>
		          </form>
	        </div>
	       </div> 	
	        	
	    	<div class="illustration-container">
	        	<div class="illustration"></div>
	      	</div>
	    </div>
    </#if>
    
    <footer id="footer">
		<span>
			<#assign corp_link><@i18n key="IAM.ZOHOCORP.LINK"/></#assign>
			<@i18n key="IAM.ZOHOCORP.FOOTER" arg0="${za.copyright_year}" arg1="${corp_link}"/>
		</span>
	</footer>
    
    
   </body>
   <script>
   		<#if !(block_add_recovery || block_mob_num_addition)>
	    	window.onload = function () {
	    		$(".configure_desc b").html(app_display_name);
	    		splitField.createElement("otp_split_input", {
	        		splitCount: otp_length, 
	        		charCountPerSplit: 1, 
	        		isNumeric: true, 
	        		otpAutocomplete: true, 
	        		customClass: "customOtp", 
	        		inputPlaceholder: "&#9679;", 
	        		placeholder: "<@i18n key="IAM.ENTER.CODE"/>", 
	      		});
	      		$("#otp_split_input .splitedText").attr("onkeydown", "clearError('#otp_split_input',event)");
	      		
	      		setFooterPosition();
	      		
	      		if(prefilledEmail != undefined && prefilledEmail != "" && prefilledEmail != null){
	      			$("#email_input").val(prefilledEmail);
	      		}
	      		if(userCountryCode != undefined && userCountryCode != null && userCountryCode!="" && mobileScreen){
		      		$("#countNameAddDiv option[value='"+userCountryCode+"']")[0].selected="selected";
		      	}
	      		if(mobileScreen){
	      			if(!isMobile){
		      			$("#countNameAddDiv").uvselect({
			      			"searchable" : true,
							"dropdown-width": "300px",
							"dropdown-align": "left",
							"embed-icon-class": "flagIcons",
							"country-flag" : true,
							"country-code" : true
		      			});
	      			}		
	      			else{
	      				phonecodeChangeForMobile(document.confirm_form.countrycode);
	      			}
	      			phonePattern.intialize($("#countNameAddDiv")[0]);
	      			if(!isMobile){
		      			$(".uvselect").click(function(){
				      		$(".selectbox_options .option").click(function(){
				      		   	textIndent(this.dataset.num.length);
				      		});	
			      		});
			      		textIndent($("#countNameAddDiv").val().length+1);
		      		}
	      			$("#mobile_input").focus();
	      		}
	      	}
	     <#else>
	     	var isMobile = <#if is_mobile_ua> true; <#else> false; </#if>
	     	function copyClipboard(element) {
			  var tickElement = document.createElement("span");
			  tickElement.classList.add("tooltip-tick"); //No I18n
			  element.querySelector(".tooltip").innerText="";
			  navigator.clipboard.writeText(element.textContent);
			  element.querySelector(".tooltip").innerText = "<@i18n key="IAM.APP.PASS.COPIED"/>"; //No I18n
			  element.querySelector(".tooltip").prepend(tickElement); //No I18n
			  setTimeout(function(){
			  	element.querySelector(".tooltip").innerText = "<@i18n key="IAM.LIST.BACKUPCODES.COPY.TO.CLIPBOARD"/>"; //No I18n
			  },1000);
			  return;
			}
	     </#if>
	</script>
</html>