<!DOCTYPE html>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0" />
    <@resource path="/v2/components/css/${customized_lang_font}" />
    <@resource path="/v2/components/css/product-icon.css" />
	
	<style>
	   body {
			margin:0px;
			color:#000;
			padding: 0px;
			background-color: #fff;
		}
		@font-face {
		  font-family: 'NewDevices';
		  src:  url('/v2/components/images/fonts/NewDevices.eot');
		  src:  url('/v2/components/images/fonts/NewDevices.eot') format('embedded-opentype'),
		    url('/v2/components/images/fonts/NewDevices.woff2') format('woff2'),
		    url('/v2/components/images/fonts/NewDevices.ttf') format('truetype'),
		    url('/v2/components/images/fonts/NewDevices.woff') format('woff'),
		    url('/v2/components/images/fonts/NewDevices.svg') format('svg');
		  font-weight: normal;
		  font-style: normal;
		  font-display: block;
		}
		
		[class^="deviceicon-"], [class*=" deviceicon-"] {
		  /* use !important to prevent issues with browser extensions that change fonts */
		  font-family: 'NewDevices' !important;
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
		.session_img{
		    width: 244px;
		    height: 140px;
		    margin: auto;
		    margin-top: 26px;
		    background-image: url("/v2/components/images/Applimit.svg");
		}
		.success_img{
			width: 50px;
			margin: auto;
			transition: all 0.3s ease-in-out;
			background-image: url("/v2/components/images/tickicon.png");
			background-size: 100%;
		}
		.load-bg{top:0px}
		@media (prefers-color-scheme: dark){.load-bg{background-color: #121212 !important;}}
	</style> 
	
	<script>
			window.onload=function(){
				onAnnouceReady();
				return false;
			}

			function extend(a, b){
			    for(var key in b)
			        if(b.hasOwnProperty(key))
			            a[key] = b[key];
			    return a;
			}
			
			var tranConHeight,tranDeviceHeight,tranSucHeight;
			var deletedCount = 0;
			var sessions = ${sessions};
			var client_id = sessions[0].client_id;
			var producticon = "${appname}".toLowerCase();
			var threshold = parseInt("${threshold}");
			var sessions_count = parseInt("${sessions_count}");
			var csrfParam= "${za.csrf_paramName}";
			var csrfCookieName = "${za.csrf_cookieName}";
			var totalSessions = sessions_count;
			var productLogo = "${productLogo}";
			var visited_url = "${visited_url}";
			<#if (('${token}')?has_content)>
				var mdm_token = '${token}';
			</#if>
			var I18N = {
					data : {},
					load : function(arr) {
						extend(this.data, arr);
						return this;
					},
					get : function(key, args) {
						if (typeof key == "object") {
							for ( var i in key) {
								key[i] = I18N.get(key[i]);
							}
							return key;
						}
						var msg = this.data[key] || key;
						if (args) {
							arguments[0] = msg;
							return Util.format.apply(this, arguments);
						}
						return msg;
					}
			};
			I18N.load({
					"IAM.APP.SESSION.MAX.LIMIT.DELETED.HEADER" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETED.HEADER" />',
					"IAM.APP.SESSION.MAX.LIMIT.HEADER" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.HEADER" />',
					"IAM.APP.SESSION.MAX.LIMIT.SELECT" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.SELECT" />',
					"IAM.APP.SESSION.MAX.LIMIT.ALL" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.ALL" />',
					"IAM.APP.SESSION.MAX.LIMIT.DEVICE.COUNT" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.DEVICE.COUNT"/>',
					"IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT.ONE" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT.ONE" />',
					"IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.NO.MORE" : '<@i18n key="IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.NO.MORE" />',
					"IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT" />',
					"IAM.APP.SESSION.MAX.LIMIT.APP.LIMIT.SPAN" : '<@i18n key="IAM.APP.SESSION.MAX.LIMIT.APP.LIMIT.SPAN" />'
				});
			
			function onAnnouceReady(){
				loadAppDevice();
				document.getElementsByClassName("product-icon")[0].classList.add("product-icon-"+productLogo.split("_")[0].toLowerCase().replace(/\s/g, ''), "product-icon-"+productLogo.split("_")[1].toLowerCase().replace(/\s/g, ''));
				document.getElementsByClassName("remaining_count")[0].childNodes[1].append(threshold - sessions_count);
				tranConHeight = document.getElementsByClassName('hidden_class')[0].clientHeight;
				tranSucHeight = document.getElementsByClassName('success_con')[0].clientHeight;
				document.getElementsByClassName('hidden_class')[0].style.height = tranConHeight+"px";
				tranDeviceHeight = document.getElementById('sessionlist').clientHeight + 20;
				document.getElementById('sessionlist').style = document.getElementsByClassName('success_con')[0].style = "height:0px;visibility: visible;";
			    document.getElementById("svg_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * (sessions_count / threshold))+" "+(2 * Math.PI * 40));
			    transitionHeight = document.getElementsByClassName('hidden_class')[0].clientHeight;
			    document.getElementsByClassName('hidden_class')[0].style.height = transitionHeight+"px";
			    if(sessions_count >= threshold){
			    	document.getElementsByClassName('do_later')[0].style.display = "none";
			    	document.getElementsByClassName("remaining_count")[0].innerHTML = I18N.get("IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.NO.MORE");
			    }else if((threshold - sessions_count) == 1){document.getElementsByClassName("remaining_count")[0].innerHTML = I18N.get("IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT.ONE");}
			    setTimeout(function(){
					document.querySelector(".load-bg").classList.add("load-fade");
					setTimeout(function(){
						document.querySelector(".load-bg").style.display = "none";
					}, 300)
				}, 500);
			    return false;
			}
	</script>
	<@resource path="/v2/components/css/mobile-session-reminder.css" />
	<@resource path="/v2/components/js/mobile-session-reminder.js" />
</head>
<body>
	<#include "../zoho_line_loader.tpl">
	 <div class="Errormsg"> <div style="position:relative;display:flex;align-items:center;"> <span class="error_icon"></span> <span class="error_message"></span> </div> </div>
	 <div class="session_parent">
	 	<div id="session_update">
	 		 <div class="success_img"></div>
	         <div class="logo_parent">
	       		<i class="product-icon appicon">
					<span class="path1"></span>
					<span class="path2"></span>
					<span class="path3"></span>
					<span class="path4"></span>
					<span class="path5"></span>
					<span class="path6"></span>
					<span class="path7"></span>
					<span class="path8"></span>
					<span class="path9"></span>
					<span class="path10"></span>
					<span class="path11"></span>
					<span class="path12"></span>
					<span class="path13"></span>
					<span class="path14"></span>
					<span class="path15"></span>
					<span class="path16"></span>
				</i>
	             <span class="display_name">${appname}</span>
	         </div>
	         <div class="session_img transitionClass"></div>
	         <div class="session_title"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.HEADER" /></div>
	         <div class='hidden_class transitionClass'>
		         <div class="session_desc"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DESC"  arg0="${appname}" arg1="${threshold}" arg2="${appname}" /></div>
		
		         <div class="canvas_area">
		             <svg class="canvas_board" id="canvas_board" style="background:#fff;display:block;" width="60px" height="60px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
		                 <g transform="translate(50,50)">
		                     <circle cx="0" cy="0" fill="none" r="40" stroke="#efefef" stroke-width="20" stroke-dasharray="250 250">
		                     </circle>
		                     <circle id="svg_circle" cx="0" cy="0" fill="none" r="40" stroke="#F9B21D" stroke-width="20" stroke-dasharray="0 250">
		                     </circle>
		                 </g>
		             </svg>
		             <div style="overflow:auto">
		                 <div id="session_count" class="session_count"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.APP.LIMIT"  arg0="${sessions_count}"/></div>
		                 <div class="remaining_count"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT" /></div>
		             </div>
		         </div>
		         <div class="web_button_div">
			         <button class="btn" onclick='showDeviceList()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.MANAGE" /></button>
			         <a href="${visited_url}" target='_self'class="do_later" ><@i18n key="IAM.DOIT.LATER"/></a>
		         </div>
	         </div>
	         <div class="success_con transitionClass">
		     	<div class="session_desc"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETED.DESC"  arg0="${appname}" /></div>
		     	<button id="gotoSignin_conf_btn" class="btn" onclick='redirectToApp()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.GO.TO" arg0="${appname}" /></button>
			    <span class="do_later" onclick='backToDelete()'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.DELETE.MORE" /></span>
		     </div>
	     </div>
		<div id='sessionlist' class="transitionClass">
			<div id="session_count_list">
		         <div class="session_manage">
		             <label class="checckbox_container" id="totalcount" onclick="toggleAllDevice()"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.ALL" />
		                 <input type="checkbox" id="allDevice">
		                 <span class="checkmark"></span>
		             </label>
		             <span class="device_set"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.SELECT" /></span>
		         </div>
		         <div class="session_recommand">
		             <span class="esc_mark"></span>
		             <span class="session_note"><@i18n key="IAM.APP.SESSION.MAX.LIMIT.RECOMENDED" /></span>
		         </div>
	        </div>
	         <div id="session_list_parent"></div>
	         <div id='continueoption'>
	         	<span class="back_option" onclick="hideDeviceList()"><@i18n key="IAM.BACK" /></span>
	         	<button class="btn dlt_btn" onclick="deleteDeviceList()"><@i18n key="IAM.DELETE" /></button>	
	         </div>
	      </div>
	      <div id='primary_info'>
	      		<div>
	      			<span class='primary_title'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.INFO" /></span>
	      			<span class="close_icon" onclick='slidePopup()'></span>
	      		</div>
	      		<div class='primary_desc'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.HEADER" /></div>
	      		<div class='primary_con'><@i18n key="IAM.APP.SESSION.MAX.LIMIT.PRIMARY.DESC" /></div>
	      </div>
     </div>
     <div id='darkBlur' onclick="slidePopup()"></div>
</body>
</html>