<!DOCTYPE html>
<html>
	<head>
		<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    	
    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/u2f-api.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/tippy.all.min.js")}"></script>
		<script src="${za.wmsjsurl}"></script>
		
		
		
		<script>
			var user_2_png = "${SCL.getStaticFilePath("/v2/components/images/user_2.png")}";
			var group_2_png = "${SCL.getStaticFilePath("/v2/components/images/group_2.png")}";
			var isAdmin = Boolean("<#if isAdmin>true</#if>");
			var user_photo_id = "${photoID}";
    		var isMobile = Boolean("<#if isMobile>true</#if>");
    		var hasProfilePic = Boolean("<#if isProfilePicExist>true</#if>");
    		var contextpath = "${za.contextpath}";
    		var mainmenu = 'home';
			var submenu = 'personal';
			var curr_country = '${current_country}';
			var supportEmail = '${support_email}';
			var csrfParam = '${csrfParam}'+"="+'${csrfValue}';
			var userPrimaryEmailAddress = "${userPrimaryEmail_JS}";
			var csrfParamName= "${za.csrf_paramName}";
		    var csrfCookieName = "${za.csrf_cookieName}";
			var accountCurrentDC = <#if ((DC_location)?has_content)>"${DC_location}"<#else>''</#if>;
		    var reloginUrlPath = "${reloginUrlPath}";
			
			var ZUID = "${zuId}";
			var show_geofenching = Boolean("<#if show_geofencing>true</#if>");
			var euserPassMaxLen=250; //default value
    		var tfa_android_Link ='${tfa_android_Link}';
    		var tfa_ios_Link = '${tfa_ios_Link}';
			var fta_oneauth_link ='${fta_oneauth_link}';
			var mfa_panel_oneauth_link ='${mfa_panel_oneauth_link}';
			var how_to_sign_in_link ='${how_to_sign_in_link}';
			var ztopbar_product_link = '${ztopbarProductLink}';
			var hide_pref_option,photoPermission;
			//var is_reauth_required=false;
			var mandate_reauth=true;
			var fromSSOKit = false;
			var showMobileNoPlaceholder = Boolean("<#if show_mobile_placeholder>true</#if>");
			var isClientPortal = Boolean("<#if isClientPortalAccount>true</#if>");			
			var captcha_error_img = "${SCL.getStaticFilePath("/v2/components/images/hiperror.gif")}";
			var passkeyURL= '${passkeyURL}';
			var passkeyHelpDoc= '${passkeyHelpDocURL}';
			var canShowResetIP ='${canShowResetIP}';
			var recoveryMandatoryHelpdoc='${recoveryMandatoryHelpdoc}';
			var otp_length = ${otp_length};
		</script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script>  
    	<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script>  
		<script>
	    	var newPhoneData = <#if ((newPhoneData)?has_content)>${newPhoneData}<#else>''</#if>;
    	</script>  
    	<script src="${SCL.getStaticFilePath("/v2/components/js/phonePatternData.js")}" type="text/javascript"></script> 
    	<script src="${SCL.getStaticFilePath("/v2/components/js/common_profile.js")}" type="text/javascript"></script>  
		<script src="${SCL.getStaticFilePath("/v2/components/js/init.js")}" type="text/javascript"></script>   
    	<script src="${SCL.getStaticFilePath("/v2/components/js/personal-details.js")}" type="text/javascript"></script>   
    	<script src="${SCL.getStaticFilePath("/v2/components/js/email.js")}" type="text/javascript"></script>	 
    	<script src="${SCL.getStaticFilePath("/v2/components/js/user-preference.js")}" type="text/javascript"></script>  
    	<script src="${SCL.getStaticFilePath("/v2/components/js/user-sessions.js")}" type="text/javascript"></script>  
    	<script src="${SCL.getStaticFilePath("/v2/components/js/groups.js")}" type="text/javascript"></script>  
    	<script src="${SCL.getStaticFilePath("/v2/components/js/password.js")}" type="text/javascript"></script>  
		<!-- Commmon webauthn methods moved to webauthn.js and called in mfa.js and signin.js -->
  	    <script src="${SCL.getStaticFilePath("/v2/components/js/webauthn.js")}" type="text/javascript" defer></script>
    	<script src="${SCL.getStaticFilePath("/v2/components/js/mfa.js")}" type="text/javascript"></script>  
     	<script src="${SCL.getStaticFilePath("/v2/components/js/privacy.js")}" type="text/javascript"></script>  
     	<script src="${SCL.getStaticFilePath("/v2/components/js/compliance.js")}" type="text/javascript"></script> 
     	<script src="${SCL.getStaticFilePath("/v2/components/js/org.js")}" type="text/javascript"></script>  
     	<script src="${SCL.getStaticFilePath("/v2/components/js/wmsliteimpl.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/splitField.js")}" type="text/javascript"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/product-icon.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/accountsstyle.css")}" rel="stylesheet"type="text/css">
		<script src="${SCL.getStaticFilePath("/v2/components/js/close-account.js")}" type="text/javascript"></script>
		<script src="${za.contextpath}/accounts-msgs?v=1&${errorMessage}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/uvselect.js")}" type="text/javascript"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/uvselect.css")}" rel="stylesheet"type="text/css">
		<script src="${SCL.getStaticFilePath("/v2/components/js/flagIcons.js")}" type="text/javascript"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/flagIcons.css")}" rel="stylesheet"type="text/css">
		
		
	<!--	<link rel="stylesheet" type="text/css" href="<%=cssURL%>/new_ui_servicelogo.css"></link> -->
	
	</head>
	
	<body>
	
		<!-- notfication push notification for web -->
		
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
		
		<!-- confirm popup -->
		
		<div class=" hide popup confirmpopup" tabindex="1" id="confirm_popup">
			<div class="popup_header confirm_pop_header"></div>
			<div class="popup_padding">
			<div class="confirm_text"></div>
			<div id="confirm_btns">
				<button tabindex="1" class="primary_btn_check  " id="return_true"><span><@i18n key="IAM.CONFIRM"/></span></button>
				<button tabindex="1" class="primary_btn_check  cancel_btn" id="return_false"><span><@i18n key="IAM.CANCEL"/></span></button>
			</div>
			</div>
		</div>
		
		<span class="tooltip_with_content"></span>
		
		<div class="blur"></div>
    	<div class="nav_blur"></div>
    	<div class="ztopbar">
    		<#include "${location}/header.tpl">
    	</div>
 		
 		<div class="header_pp_expand" tabindex=1>
			<div class="close_btn" id="close_pp_expand" onclick="close_pro_expand()"></div>
			<div class="pp_expand_info">
				<div class="pp_expand_pp icon-camera" onclick="showProPicOptions(this)">
					<div class="info_thumb_pic_blur_bg" style="background-image:url('${photoID}')"></div>
					<img id="info_thumb_pic" onload="setPhotoSize(this)" onerror='handleDpOption(this)' class="pp_expand_pic" src="${photoID}"/>
				</div>
				<div class="pp_expand_username"> ${userFullName} </div>
				<div class="pp_expand_email" id="logoutid" >${userPrimaryEmail_HTML}</div>
				<div class="pp_expand_userid"> <@i18n key="IAM.USER.ID"/> : ${zuId}<span class="ppexpand_userid_info"><span class="icon-info"></span></span><div class="userid_info_child"><@i18n key="IAM.USER.ID.TOOLTIP.INFO"/></div></div>
				<#if (showUserCurrentDC)>
					<div class="pp_expand_data_center">
						<span class="icon-datacenter"></span>
						<span><@i18n key="IAM.DC.LOCATION" arg0="${DC_location}"/></span>
					</div>
				</#if>
				<div class="pp_expand_signout" onclick="go_to_link('${LogoutURL}',false)"> <@i18n key="IAM.SIGN.OUT"/> </div>
			</div>
			<div class="profile_option_parent hide" style="left: 30px; top: 60px;">
				<div class="profile_pic_option">
					<div id="upload_option" onclick="openUploadPhoto('user','0')"><@i18n key="IAM.UPLOAD.NEW"/></div>
		   			<!--<div id="edit_option" onclick="editProPicture()"><@i18n key="IAM.EDIT"/></div> -->
		   			<div id="remove_option" onclick="removePicture('Remove Picture','Are you sure you want to remove your profile picture? Your contacts may find it difficult to identify you without a picture.')" style="color:#FF5F5F"><@i18n key="IAM.REMOVE"/></div>
				</div>
			</div>
		
			<#if (!hideHelpLinks) >
				<div class="help_documents">
					<div class="help_head_text"> <@i18n key="IAM.HELP.DOCUMENTS"/> </div>
					<div class="helplink_div" onclick="go_to_link('${userGuideLink}',true)">
						<span class="help_icon" id="icon-cuserguide">
							<span class="icon-cuserguide"></span>
						</span>
						<span class="help_text"> <@i18n key="IAM.USER.GUIDE"/> </span>
					</div>
					<div class="helplink_div" onclick="go_to_link('${developerGuideLink}',true)">
						<span class="help_icon" id="icon-cdeveloperguide">
							<span class="icon-cdeveloperguide"></span>
						</span>
						<span class="help_text"> <@i18n key="IAM.DEVELOPER.GUIDE"/> </span>
					</div>
					<div class="helplink_div" onclick="go_to_link('${faqsLink}',true)">
						<span class="help_icon" id="icon-cfaq">
							<span class="icon-cfaq"></span>
						</span>
						<span class="help_text"> <@i18n key="IAM.HEADER.FAQ"/> </span>
					</div>
					<div class="helplink_div" onclick="go_to_link('${bestPracticesLink}',true)">
						<span class="help_icon" id="icon-cbestpracticesforsecurity">
							<span class="icon-cbestpracticesforsecurity"></span>
						</span>
						<span class="help_text"> <@i18n key="IAM.BEST.PRACTICES"/> </span>
					</div>
					<div class="helplink_div" onclick="go_to_link('${contactUSLink}',true)">
						<span class="help_icon" id="icon-ccontactus">
							<span class="icon-ccontactus"></span>
						</span>
						<span class="help_text"> <@i18n key="IAM.CONTACT.US"/> </span>
					</div>
				</div>
			</#if>
				
		</div>
        <div class="navbar" id="mainmenupanel">
        
        	<!-- loading gif for index page -->
        	
            <div class="nav_bar" id="mainmenupanel_loading_gif">
            	<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
				<div class="load_menu">
					<span class="load_menu_circle"></span>
					<span class="load_menu_text"></span>
				</div>
            </div>
            
            <!-- navigation tabs section -->
            
            <div class="nav_cover">
            
	         <!-- <div class="menu"  id="home" onclick="loadTab('home','home','')">
	                <span class="menuicon icon-dashboard"></span>
	                <span class="menutext"><@i18n key="IAM.MENU.DASHBOARD"/> </span>
	            </div>  -->
	            
		        <div class="menu" id="profile" onclick="loadTab('profile','personal')">
	                <span class="menuicon icon-mprofile"></span>
	                <span class="menutext"><@i18n key="IAM.PROFILE"/> </span>
	            </div>
	            <div class="submenu_div" id="profilesubmenu">
	                <span class="submenu" id="personal" onclick="loadPage('profile','personal');"><@i18n key="IAM.PERSONAL.INFO"/> </span>
	                <span class="submenu" id="useremails" onclick="loadPage('profile','useremails');"><@i18n key="IAM.EMAIL.ADDRESS"/> </span>
	                <span class="submenu" id="phonenumbers" onclick="loadPage('profile','phonenumbers');"><@i18n key="IAM.MOBILE.NUMBERS"/> </span>
	            </div>
	            
	            <div class="menu" id="security" onclick="loadTab('security','security_pwd');">
	                <span class="menuicon icon-msecurity"></span>
	                <span class="menutext"><@i18n key="IAM.MENU.SECURITY"/> </span>
	            </div>
				<div class="submenu_div" id="securitysubmenu" >
					<span class="submenu" id="security_pwd" onclick="loadPage('security','security_pwd');"><@i18n key="IAM.PASSWORD"/> </span>
	<#if (show_geofencing)>
					<span class="submenu" id="geofencing" onclick="loadPage('security','geofencing');"><@i18n key="IAM.GEOFENCING"/> </span>
	</#if>
		            <span class="submenu" id="security_ips" onclick="loadPage('security','security_ips')"><@i18n key="IAM.ALLOWED.IPADDRESS"/>  </span>
	<#if (showAppPasswords)>
	               	<span class="submenu" id="app_password" onclick="loadPage('security','app_password')"><@i18n key="IAM.TFA.APP.PASSWORDS"/> </span>
	</#if>
	<#if (showDeviceLogins)>
	              	<span class="submenu" id="device_logins" onclick="loadPage('security','device_logins')"><@i18n key="IAM.DEVICE.LOGINS.TITLE"/> </span>
	</#if>
		        </div>
		        
		        
	<#if (canShowTFAPage)>
	            <div class="menu"  id="multiTFA" onclick="loadTab('multiTFA','modes');">
					<span class="menuicon icon-mmfa"></span>
					<span class="menutext"><@i18n key="IAM.MFA"/> </span>
				</div>
				<div class="submenu_div hide" id="multiTFAsubmenu">
					<span class="submenu" id="modes"  onclick="loadPage('multiTFA','modes');" ><@i18n key="IAM.MFA.MODES.TITLE"/> </span>
					<span class="submenu TFAPrefrences_menu hide" id="recovery"  onclick="loadPage('multiTFA','recovery');" ><@i18n key="IAM.MFA.RECOVERY.OPTION"/> </span>
					<span class="submenu TFAPrefrences_menu hide" id="trusted_browser"  onclick="loadPage('multiTFA','trusted_browser');" ><@i18n key="IAM.TFA.TRUST.BROWSERS"/> </span>
				</div>
    </#if>
			
				
				<div class="menu" id="setting" onclick="loadTab('setting','preference');">
	                <span class="menuicon icon-msettings"></span>
	                <span class="menutext"><@i18n key="IAM.SETTINGS"/> </span>
	            </div>
	            <div class="submenu_div" id="settingsubmenu">
					<span class="submenu" id="preference" onclick="loadPage('setting','preference'); "><@i18n key="IAM.USERPREFERENCE"/> </span>
	<#if (showSecurityNotifications)>
	                <span class="submenu" id="notifications" onclick="loadPage('setting','notifications'); "><@i18n key="IAM.SECURITY.NOTIFICATION.TITLE"/> </span>
	</#if>                    				
	               	<span class="submenu" id="authorizedsites" onclick="loadPage('setting','authorizedsites'); "><@i18n key="IAM.AUTHORIZED.WEBSITES"/> </span>
					<span class="submenu" id="linkedaccounts" onclick="loadPage('setting','linkedaccounts'); "><@i18n key="IAM.LINKED.ACCOUNTS"/> </span>
					<span class="submenu" id="closeaccount" onclick="loadPage('setting','closeaccount')"><@i18n key="IAM.CLOSE.ACCOUNT"/> </span>
				</div>
				
				
				<div class="menu" id="sessions" onclick="loadTab('sessions','useractivesessions')">
					<span class="menuicon icon-msessions"></span>
	                <span class="menutext"><@i18n key="IAM.MENU.SESSIONS"/> </span>
		        </div>
		        <div class="submenu_div" id="sessionssubmenu">
	               <span class="submenu" id="useractivesessions" onclick="loadPage('sessions','useractivesessions');"><@i18n key="IAM.ACTIVESESSIONS"/> </span>
	               <span class="submenu" id="userauthtoken" onclick="loadPage('sessions','userauthtoken');"><@i18n key="IAM.ACTIVETOKENS"/> </span>
	               <span class="submenu" id="useractivityhistory" onclick="loadPage('sessions','useractivityhistory')"><@i18n key="IAM.LOGINHISTORY"/>  </span>
	               <span class="submenu" id="userconnectedapps" onclick="loadPage('sessions','userconnectedapps')"><@i18n key="IAM.CONNECTEDAPPS"/> </span>
	               <span class="submenu" id="userapplogins" onclick="loadPage('sessions','userapplogins')"><@i18n key="IAM.APP.LOGINS"/> </span>
	               <#if  (show_thirdparty_access) ><span class="submenu" id="thirdpartyaccess" onclick="loadPage('sessions','thirdpartyaccess')"><@i18n key="IAM.THIRDPARTY.ACCESS"/> </span></#if>
	           </div>
	           
	<#if  (showGroupsPage) >
	            <div class="menu" id="groups" onclick="loadTab('groups','allgroups');">
	                <span class="menuicon icon-mgroups"></span>
	                <span class="menutext"><@i18n key="IAM.GROUPS"/> </span>
	            </div>
	            <div class="submenu_div hide" id="groupssubmenu">
	                <span class="submenu" id="groupinfo" ></span>
					<span class="submenu" id="groupedit" ></span>               
					<span class="submenu" id="groupinvite" ></span>
					<span class="submenu" id="allgroups" ></span>
		        </div>
    </#if> 
    <#if (showPrivacyPage == 1) >
				<div class="menu"  id="privacy" onclick="loadTab('privacy','dpa')">
					<span class="menuicon icon-mprivacy"></span>
					<span class="menutext"><@i18n key="IAM.MENU.PRIVACY"/> </span>
				</div>
				<div class="submenu_div" id="privacysubmenu">
					<span class="submenu" id="dpa" onclick="loadPage('privacy','dpa')"><@i18n key="IAM.GDPR.DPA"/> </span>
					<span class="submenu" id="myc" onclick="loadPage('privacy','myc')"><@i18n key="IAM.GDPR.KYC.NAV.SUBHEAD"/> </span>
				</div>
	</#if>
    <#if (showCertificatePage == 1) >			
    			<div class="menu"  id="compliance" onclick="loadTab('compliance','certifications')">
					<span class="menuicon icon-mcompliance"></span>
					<span class="menutext"><@i18n key="IAM.MENU.COMPLIANCE"/> </span>
				</div>
    </#if>			
	<#if (showSamlPage)>
			<div class="menu"  id="org" onclick="loadTab('org','org_saml')">
				<span class="menuicon icon-morg"></span>
				<span class="menutext"><@i18n key="IAM.MENU.ORGANIZATION"/> </span>
			</div>
   			<div class="submenu_div" id="orgsubmenu">
	            <span class="submenu" id="org_saml" onclick="loadPage('org','org_saml') "><@i18n key="IAM.SAMLSETUP.PAGE.TITLE"/> </span>
				<span class="submenu" id="org_domains" onclick="loadPage('org','org_domains')"><@i18n key="IAM.HEADER.DOMAINS"/> </span>
			</div>
	</#if> 
    <#if (isAdmin)>
				<div class="menu" id="admin" onclick="window.location.href='/admin';">
					<span class="menuicon icon-madmin"></span>
	                <span class="menutext"><@i18n key="IAM.ADMIN"/> </span>
	            </div>
	</#if>
	
				<div class="menu_more" onclick ="showNavpop()" id="more">
					<span class="menuicon icon-mmore"></span>
	                <span class="menutext"><@i18n key="IAM.VIEWMORE.INFO"/> </span>
	            </div>
	            
	            <div class="hidden_popup" style="display:none">
	            </div>  
	               
			</div>
		
    	</div>
    	
    	
    	<div class="right">
    		<div id="common_popup" tabindex="1" class="pp_popup hide">
				<div class="popup_header ">
					<div class="popuphead_details">
						<span class="popuphead_text"></span>
					</div>
					<div class="close_btn" onclick="close_popupscreen()"></div>
				</div>
				<div class="popup_padding">
					<div class="form_description"><span class="popuphead_define"></span></div>
					<div id="pop_action"></div>
				</div>
			</div>
			
			<div class="full_view_side_info hide" id="sideview" tabindex="1" ></div>
		
			<div class="hide" id="exception_tab">
				<div class="no_data exception_tab"></div>
				<div class="no_data_text"><@i18n key="IAM.ERROR.GENERAL"/>  </div>
				<button class="primary_btn_check  center_btn " id="reload_exception" ><span><@i18n key="IAM.EXCEPTION.RELOAD"/> </span></button>
			</div>

			<div class="hide" id="exception_page">
				<div id="bad_net">
					<div id="exception_page_img" class="no_data_exception"></div>
					<div class="no_data_text" id="exception_page_txt"><@i18n key="IAM.PLEASE.CONNECT_INTERNET"/> </div>
					<button class="primary_btn_check center_btn" id="reload_exception_page" onclick="document.location.reload()"><span><@i18n key="IAM.EXCEPTION.RELOAD"/> </span></button>
				</div>
			</div>

    		<div class="content_div"  id="zcontiner" style="display:none"></div>
    	</div>
    	
    	<div class="content" style="display:block">
			<div class="gif_box">
				<div class="box_header_load">
					<div class="box_head_load"></div>
					<div class="box_define_load"></div>
				</div>
			</div>			
		</div>

    	<div  class="content_div hide" id="portfolio-wrap"></div>

		<div class="photopopup">
		<#include "${location}/photo.tpl">
		</div>
		
    </body>
    <script>
    	 var corsXHR = function(options) {
	        var xhr = new XMLHttpRequest();
	        if ("withCredentials"in xhr) {
	            xhr.open(options.method, options.url, true);
	            xhr.withCredentials = true;
	        } else if (typeof XDomainRequest !== "undefined") {
	            xhr = new XDomainRequest();
	            xhr.open(options.method, options.url);
	        }
	        xhr.onreadystatechange=function() {
			    if(xhr.readyState==4) {
			    	if (xhr.status != 200) {
			    		$(".zoho_topbar_logo").css("margin-left","16px");
						return false;
					}
			    }
			}
	        xhr.onload = function() {
	            options.callback(JSON.parse(xhr.responseText));
	        };
	        return xhr;
    	};
    	function getIEBrowserVersion() { 
    		var ua = "";
	    	try {
			    ua = navigator.userAgent; 
			}catch(e){}
		    var msie = ua.indexOf('MSIE '); 
		    if (msie > 0) { 
		        return (parseInt(ua.substring(  msie + 5, ua.indexOf('.', msie)), 10)); 
		    } 
		    var trident = ua.indexOf('Trident/'); 
		    if (trident > 0) { 
		        var rv = ua.indexOf('rv:'); 
		        return (parseFloat(ua.substring(  rv + 3, rv + 7))); 
		    } 
		    return -1; 
		}
		function changeBanner(){
			var iebanner = "<div style='text-align: center; margin-top:75px;'>\
								<img src='../v2/components/images/BrowserUpdate.png' style='display: block;margin:auto;'/>\
								<div style='font-weight: 500;font-size: 24px;color: #000000;line-height: 40px;margin-top:30px;'><@i18n key="IAM.UPDATE.IE.BROWSER.TITLE"/></div>\
								<div style='font-weight: 400;font-size: 16px;color: #111111;line-height: 30px;width:500px;margin-top:10px;margin:auto;'><@i18n key="IAM.UPDATE.IE.BROWSER.DESC"/></div>\
								<div onclick=go_to_link('//www.microsoft.com/en-us/download/internet-explorer.aspx', true); style='font-weight: 500;font-size: 13px;line-height: 30px;width:176px;margin:auto;background: #1389E3;padding:8px 0;color: #FFFFFF;margin-top:30px;'><@i18n key="IAM.UPDATE.IE.BROWSER.BUTTOON.DESC"/><div>\
							</div>";
			de('mainmenupanel').style.display='none';
			document.getElementsByClassName('content')[0].style.position='static';
			document.getElementsByClassName('content')[0].innerHTML = iebanner;
			return false;
		}		
    	window.onload=function() {
    		$.fn.focus=function(){ 
				if(this.length){
					$(this)[0].focus();
				}
				return $(this);
			}
			try {
				WmsLite.setNoDomainChange();
				WmsLite.setConfig(64);//64 is value of WMSSessionConfig.CROSS_PRD
	    		WmsLite.registerZuid('AC',"${zuId}","${userLoginName}", true);
			}catch(e){}
			
			
			try {
    			var ieBrowserVersion = getIEBrowserVersion()
    			if(ieBrowserVersion != -1 && ieBrowserVersion < 11.5){
					changeBanner();
					return false;
				}
			}catch(e){}

			try 
			{
    			URI.options.contextpath="${za.contextpath}/webclient/v1"//No I18N
    			URI.options.csrfParam = '${csrfParam}'; 
    			URI.options.csrfValue = '${csrfValue}'; 
			}catch(e)
			{}
			loadHash();
 				setHeightForCover(); 
			if(ztopbar_product_link != ""){
				$(".ztopbar .zoho_logo").css("margin-left","56px");
				$(".ztopbar .zoho_topbar_logo").css("margin-left","56px");
				
				corsXHR({
			        method: 'GET',
			        url: ztopbar_product_link,
			        callback: function(data){
			        	var hamburgerMenuResponse = data[1];
				        // 2.  creating window level "zmwpHMConfig" object
				        window.zmwpHMConfig = $.extend(hamburgerMenuResponse, { 
					        appId : "accounts", 
				        	mask: true,
                            zIconParent: $(".right")[0],
                            hamburgerMenuParent: $(".right")[0],
                            maskType: "black",
                            isOneZohoBundle: false,
                            zIconTheme: "dark",
                            nightMode: false,
                            suite: true,
                            suiteAppList: [ 'mail','cliq','connect', 'writer', 'sheet', 'show', 'docs', 'showtime','meeting'],
                            allApps: true,
                            searchBox: true,
                            drawerClassnames: "accounts_product_menu",				//No I18N
                            searchBoxConfig: {
                                 variant: "outlined"			//No I18N
                            },
                            zOneConfig: {
   							 csrfName: '${csrfParam}',
							 getCsrfValue : '${csrfValue}'
							},
                            top: "54px", // hamburger menu's top position, eg: "0px"
                            arrow: isMobile && window.outerWidth<=420 ? "topRight" : "topLeft"
				        });
				
				        // 3. loading the initial javascript file
				        var tag = document.createElement("script");
				        tag.setAttribute("src", hamburgerMenuResponse.initialJS);
				        tag.setAttribute("charset", "utf-8");
				        document.body.appendChild(tag)
			        }
			    }).send();
			    if(isMobile && window.outerWidth<=420){
			    	$(".ztopbar .zoho_logo").css("margin-left","16px");
			    	$(".ztopbar .zoho_topbar_logo").css("margin-left","16px");
			    }
			}
			else{
				$(".ztopbar .zoho_logo").css("margin-left","16px");
				$(".ztopbar .zoho_topbar_logo").css("margin-left","16px");
			}
			if($("#logoutid").text()){
				var logOutIdText = $("#logoutid").text();
				$("#logoutid").text(isPhoneNumber(logOutIdText) ? phonePattern.setMobileNumFormat(logOutIdText):logOutIdText);
			}
    	}
    	
/*    	window.setInterval(function()
		{
		  is_reauth_required=true;
		}, 270000);//change every 4.5 mins.

*/
    	    	
      	window.onresize=function() {
    		setHeightForCover();
    	};

    	window.setInterval("watchHash()", 1000);
    	
    	window.onhashchange = function(){
    		if($(".blur").css("opacity")>0){
    			$(".blur").click();
    		}
    	}
    	
     	function setHeightForCover(id){
     		//showNavpop();
    		var win_height = window.innerHeight-48;
    		var tab_limit = isAdmin ? 280 : 244;
    		if(isMobile){
    			$("#mainmenupanel").css("overflow","auto");
    			$("#mainmenupanel").css("height",win_height+"px");
    		}
    		else{
	    		$("#mainmenupanel").css("height","100%");
    			$("#mainmenupanel").css("overflow","unset");
    		}
    		if(win_height > tab_limit && !isMobile){
	    		if(win_height<395){
	     			$(".submenu_div").hide();
	     		}
	     		else{
	     			$(".menu_click").show();
	     		}
	     		var menuBarHeight = $(".menu")[0].offsetHeight;
	     		var subMenuHeight = $(".submenu_div:visible")[0] == undefined ? 0 : $(".submenu_div:visible")[0].clientHeight;
	    		var nav_height = $(".menu:visible").length*menuBarHeight;
	    		var menu_count = Math.floor((win_height-(subMenuHeight+menuBarHeight))/menuBarHeight);
	    		menu_count = menu_count > $(".menu").length ? $(".menu").length : menu_count;
	 
	 			if(id!=undefined){
	 	 			$("#"+id).show();
	 			}
	 			
		    	if(($(".menu:visible").length*56)+subMenuHeight+menuBarHeight > win_height ){ 
		    		for(i=0;i<$(".menu").length;i++){
		    			if(!$($(".menu")[i]).hasClass("menu_click")){    		
			    			$($(".menu")[i]).hide();    				
			    		}
			    		else if($($(".menu")[i]).hasClass("menu_click")){
			    			$($(".menu")[i-1]).hide();
			    		}
		    		}
		    		$(".menu_more").show();
	    		}
	
	 	    	if(subMenuHeight+($(".menu").length*menuBarHeight)+menuBarHeight<win_height)
		    	{
		    		$(".menu_more").hide();
		    		menu_count=menu_count+1;
		    	} 
	 	    	 if(menu_count>0){
	 	    		
	 	    		for(var i=0;i<menu_count;i++){
						if((i == menu_count && menu_count != $(".menu").length)){
							return;
						}
						if(!$($(".menu")[i]).hasClass("menu_click")){
							$($(".menu")[i]).show();	
						}	
					}
	 	    	} 
	    		if($(".menu_click")[0] != undefined && $(".menu_click")[0].offsetTop+subMenuHeight+(menuBarHeight*2)>=win_height){
	    			$(".menu_click:first").prevAll(".menu:visible:first").hide();  //No I18N
	    		}
	    		
	 	    	printHidden();
    		}
    		else{
    			$('.menu_more').removeClass("show_after");
         		$(".hidden_popup").hide();
         		$(".menu").show();
         		$(".menu_click").show();
         		$(".menu_more").hide();
    		}
    	}
     	function printHidden(){
     		$(".hidden_popup").html("");
     		tooltip_Des("#more");//No I18N
     		for(v=0;v<$(".menu:hidden").length;v++)
     		{
     			$(".hidden_popup").append("<div class='overflow_menu' style='width:270px;text-align:left;' onclick="+$($(".menu:hidden")[v]).attr("onclick")+">"+$($(".menu:hidden")[v]).html()+"</div>")	
     		}
     	}
     	function showNavpop(){
     		$('.menu_more').toggleClass("show_after"); //No I18N
     		$(".hidden_popup").toggle();
     	}
     	function select2_open_listener(event) {	
     		if (event && $(event.target).closest('.select2-selection').length) {		
     			$('.select2-dropdown').children('.select2-search').children('.select2-search__field')[0].focus();		
     		}			    
     	}
     	document.addEventListener('click', select2_open_listener, true);
	</script>
</html>
			
		
		
		
		