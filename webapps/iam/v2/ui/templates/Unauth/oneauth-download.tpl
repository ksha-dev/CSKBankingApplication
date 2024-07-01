<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
        <@i18n key="IAM.REV.OA.INSTALL" /> | <@i18n key="IAM.ZOHO.REBRAND" />
    </title>
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <@resource path="/v2/components/js/zresource.js" />
    <@resource path="/v2/components/js/uri.js" attributes="async"/>
    <@resource path="/v2/components/css/${customized_lang_font}" />
    <style>
        @font-face {
            font-family: 'Announcement';
            src: url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}');
            src: url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.eot")}') format('embedded-opentype'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.ttf")}') format('truetype'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.woff")}') format('woff'),
            url('${SCL.getStaticFilePath("/v2/components/images/fonts/Announcement.svg")}') format('svg');
            font-weight: normal;
            font-style: normal;
            font-display: block;
        }
        [class^="icon-"],
        [class*=" icon-"] {
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
        .icon-warning:before {
            content: "\e962";
        }
        .icon-reload:before {
            content: "\e961";
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
        html, body {
            margin: 0;
            box-sizing: border-box;
            min-height: 100%;
            height: 100%;
            width: 100%;
            background-image: linear-gradient(to bottom, #F4F4F4 35%, #ffffff 35%);
        }
        .flex-container {
            display: flex;
            flex-direction: column;
            margin: auto;
            min-height: 100%
        }
        .container{
        	transition: visibility 0.4s ease-in-out;
        }
        .rebrand-partner-logo {
            height: 40px;
            margin: auto;
            margin-top: 50px;
            margin-bottom: 20px;
            background: url("${SCL.getStaticFilePath("/v2/components/images/newZoho_logo.svg")}") no-repeat;
            background-size: auto 40px;
            background-position: center;
        }
        .logo-cont{
        	/*background-color: #262F91;*/
        }
        .install-cont{
        	padding: 20px;
        	/*background-image: linear-gradient(to bottom, #262F91 45%, #ffffff 45%);*/
        }
        .install-sub{
        	background-color: #ffffff;
        	padding: 24px;
        	border-radius: 8px;
        	border: 1px solid #E0E0E0;
        	max-width: 600px;
        	margin: auto;
        }
        .oneauth-logo{
        	width: 70px;
        	height: 70px;
        	padding: 10px;
        	border-radius: 20px;
        	background-color: #4C53A1;
        	font-size: 70px;
			margin: auto;
			margin-bottom: 16px;
        }
        .app-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 16px;
            cursor: default;
            text-align: center;
        }
        .redirect-note{
        	text-align: center;
        	font-size: 14px;
        	opacity: 0.6;
        	font-style: italic;
        	margin-top: 16px;
        }
        [class*="-desc"] {
            font-size: 14px;
            line-height: 20px;
            margin-bottom: 20px;
            cursor: default;
            opacity: 0.8;
            text-align: center;
            user-select: none;
        }
        .avail-desc{
        	color: #ffffff;
        }
		.install-btn {
			font-family: "ZohoPuvi";
			text-decoration: none;
			background-color: #262F91;
			padding: 16px;
			color: #ffffff;
			border: navajowhite;
    		border-radius: 8px;
    		width: 100%;
    		font-size: 20px;
    		line-height: 20px;
    		font-weight: 500;
		}
		.install-btn:disabled {
			opacity: 0.6;
		}
		.install-btn .loader {
			margin-left: 10px;
		}
		.badges-cont{
			margin-top: auto;
			background-color: #000000;
			padding: 30px;
		}
		.store-links{
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
		.download {
    		width: 110px;
    		height: 36px;
    		cursor: pointer;
	  	}
	  	.playstore-icon{
			background: url("/v2/components/images/Playstore_svg.svg") no-repeat;
			background-size: 120px 36px;
			width: 120px;
	 		order: 1;
	  	}
	  	.appstore-icon{
			background: url("/v2/components/images/Appstore_svg.svg") no-repeat;
	  		background-size: 108px 36px;
	  		width: 108px;
	  		order: 2;
	  	}
	  	.macstore-icon{
			background: url("/v2/components/images/Macstore_svg.svg") no-repeat;
			background-size: 140px 36px;
	  		width: 140px;
	  		order: 3;
	  	}
	  	.winstore-icon{
			background: url("/v2/components/images/Winstore_svg.svg") no-repeat;
			background-size: 100px 36px;
	  		width: 100px;
	  		order: 3;
	  	}
	  	.app-small{
	  		height: 30px;
	  		width: 88px;
	  		background-size: 88px 30px;
	  	}
	  	.play-small{
	  		height: 30px;
	  		width: 96px;
	  		background-size: 96px 30px;
	  	}
	  	.mac-small{
	  		height: 30px;
	  		width: 115px;
	  		background-size: 115px 30px;
	  	}
	  	.win-small{
	  		height: 30px;
	  		width: 85px;
	  		background-size: 85px 30px;
	  	}
        .loader,
        .loader:after {
            border-radius: 50%;
            width: 12px;
            height: 12px;
        }
        .loader {
            display: inline-block;
            font-size: 10px;
            margin-right: 10px;
            text-indent: -9999em;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-left: 2px solid;
            border-bottom: 2px solid;
            transform: translateZ(0);
            -webkit-animation: load 0.8s infinite linear;
            animation: load 0.8s infinite linear;
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
        @media only screen and (max-width: 435px) {
            .remind_me_later {
                display: block;
                width: max-content;
                margin: auto;
            }
            .succfail-btns {
                flex-direction: column;
            }
        }
        .check_container{
        	position: relative;
        	margin-bottom: 32px;
        	display: flex;
        	justify-content: center;
        	flex-direction: column;
        }
        .check_container > div{
        	margin-left: 22px;
        	font-size: 14px;
        	line-height: 20px;
        	user-select: none;
        	position: relative;
        }
        #check_input{
        	width: 0px;
        	height: 0px;
        	position: absolute;
        	display: none;
        }
        label{
        	position: absolute;
        	left: -22px;
        	cursor: pointer;
        }
  		label:hover:before {
    		border-color: #262F91;
        }
     	label:before {
    		content: "";
    		width: 16px;
    		display: inline-block;
    		height: 16px;
    		border: 2px solid #C7C7C7;
    		border-radius: 3px;
    		box-sizing: border-box;
    		background: #fff;
    		position: absolute;
    		left: 0px;
    		top: 2px;
    		transition: 0.2s all ease-out;
		}
	label:after {
    		content: "";
    		width: 5px;
    		display: inline-block;
    		height: 10px;
    		border: 2px solid #fff;
    		border-left: transparent;
    		border-top: transparent;
    		border-radius: 1px;
    		box-sizing: border-box;
    		position: absolute;
    		left: 5px;
    		top: 4px;
    		transform: rotate(45deg);
		}
		 input:checked ~ label:before {
    		background-color: #262F91;
    		border-color: #262F91;
        }
		.unselect_desc{
			display: none;
			color: #EF8112;
			margin-top: 12px;
		}
		.check_container > div.unselect_desc{
			margin-left: 0px;
		}
		.show{
			display: block;
		}
    </style>
    <script>
    var rl = {
    	ps: "https://zurl.to/smart-qr-playstore",
    	as: "https://zurl.to/smart-qr-appstore",
    	ms: "https://zurl.to/smart-qr-msstore",
    	unknown: "https://zurl.to/smart-qr-unkn"
    }
    var rl2 = {
    	ps: "https://zurl.to/rev-qrsign-playstore",
    	as: "https://zurl.to/rev-qrsign-appstore",
    	ms: "https://zurl.to/rev-qrsign-msstore",
    	unknown: "https://zurl.to/qr-signin-unknown"
    }
    var redirectURI;
	function installData(e) {
		var target;
		if(e && e.target){
			e.target.setAttribute("disabled","");
			e.target.children[0].classList.add("loader");
			target = e.target;
			setTimeout(function(tar){
				tar.removeAttribute("disabled");
				tar.children[0].classList.remove("loader");
			}, 5000, target)
		}
		var code = document.location.href;
		if(document.querySelector("#check_input").checked){
       	navigator.clipboard.writeText( code ).then(function(){
       		window.location.href = redirectURI;
       		if(target){
       			setTimeout(function(){
       				target.removeAttribute("disabled");
					target.children[0].classList.remove("loader");
       			}, 5000);
       		}
       		removeBG(5000, 300)
       	}).catch(function(){
       		if(target){
       			setTimeout(function(){
       				target.removeAttribute("disabled");
					target.children[0].classList.remove("loader");
       			}, 500);       		
       		}
			removeBG(400, 200);
       	})
       	}else{
       		window.location.href = redirectURI;
       	}
    }
    function removeBG(fadetime, nodisplaytime){
    	setTimeout(function(){
			document.querySelector(".load-bg").classList.add("load-fade");
			setTimeout(function(){
				document.querySelector(".load-bg").style.display = "none";
			}, nodisplaytime)
		}, fadetime)    	
		document.querySelector(".container").style.visibility = "unset";
    }
    function redirectStore(){
		window.location.href = redirectURI;
    }
    function showAlert(){
    	document.querySelector('.unselect_desc').classList.toggle("show");
    }
    </script>
</head>
<body>
		<#include "../zoho_line_loader.tpl">
        <div class="flex-container container" style="visibility: hidden">
        	<div class="logo-cont">
        		<div class="rebrand-partner-logo"></div>
        	</div>
            <div class="install-cont">
               <div class="install-sub">
                <div class="oneauth-logo icon-Zoho-oneAuth-logo"><span class="path1 onepathlogo"></span><span class="path2 onepathlogo"></span><span class="path3 onepathlogo"></span><span class="path4 onepathlogo"></span><span class="path5 onepathlogo"></span><span class="path6 onepathlogo"></span><span class="path7 onepathlogo"></span></div>
                <div class="app-name"><@i18n key="IAM.USE.AUTH.APP.SETUP.HEADING" /></div>
                <div class="check_container">
                	<div>
                    	<input type="checkbox" id="check_input" checked onchange="showAlert()"/>
             			<label for="check_input" class="checklabel"></label>
                        <@i18n key="IAM.OA.DOWN.TAP.COPY" />
                    </div>
                    <div class="unselect_desc"><@i18n key="IAM.OA.DOWN.UNSELECTED" /></div>
                </div>
          		<div class="app-desc" style="display: none"><@i18n key="IAM.OA.APP.DESC" /></div>
                <button class="install-btn"><@i18n key="IAM.INSTALL" /><span></span></button>
                <div class="redirect-note ps" style="display: none"><@i18n key="IAM.OA.DOWN.REDIRECTED" arg0="Play store"/></div>
                <div class="redirect-note as" style="display: none"><@i18n key="IAM.OA.DOWN.REDIRECTED" arg0="App store"/></div>
                <div class="redirect-note ms" style="display: none"><@i18n key="IAM.OA.DOWN.REDIRECTED" arg0="Microsoft store"/></div>
                </div>
            </div>
     		<div class="badges-cont" style="display: none">
            	<div class="avail-desc">Available on</div>
            	<div class="store-links">
                	<div class="download playstore-icon play-small"></div>
                	<div class="download appstore-icon app-small"></div>
                	<div class="download winstore-icon win-small"></div>
                </div>
            </div>
            </div>
        </div>
</body>
<script>
    window.onload = function(){
		var qrType = window.location.search.indexOf("qrtype=2");
		var UA = navigator.userAgent.toLowerCase();
		if(/android/i.test(UA)){
			store = "ps"
		} else if(/iphone|ipad|ipod/i.test(UA)){
			store = "as"
		} else if(/windows|win64/i.test(UA)){
			store = "ms"
		} else {
			store = "unknown"
		}
		if(qrType > 0){
			redirectURI = rl2[store];
			if(store != "unknown"){
				document.querySelector(".redirect-note."+store).style.display = "block";
			}
			document.querySelector(".install-btn").addEventListener("click", installData);
			removeBG(300, 200);
		}else{
			redirectURI = rl[store];
			document.querySelector(".install-btn").addEventListener("click", redirectStore);
			removeBG(300, 200);
			document.querySelector(".badges-cont").style.display="block";
			document.querySelector(".app-desc").style.display="block";
			document.querySelector(".check_container").style.display="none";
		}
	}
</script>
</html>