<html>
		<head>
			<title><@i18n key="IAM.ORG.INVITATION.TITLE" /></title>
		    <meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			
		    <@resource path="/v2/components/css/${customized_lang_font}" />
		    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
		    <@resource path="/v2/components/js/zresource.js" />
		    <@resource path="/v2/components/css/orgUserInviteMultiDC.css" />
		    <@resource path="/v2/components/js/uri.js" /> 
			<@resource path="/v2/components/js/common_unauth.js" />
			<@resource path="/v2/components/js/invitation.js" />
		    <script>
		    	var csrfParamName= "${za.csrf_paramName}";
				var csrfCookieName = "${za.csrf_cookieName}";
				var csrfParam= "${za.csrf_paramName}";
				var digest ="${digest}";
				var clone_dc = "${clone_dc}";
				var contextpath= "${za.contextpath}";
				var isFormSubmitted = false;
				var emailId = "${emailId}";
				var clone_zoid = "${clone_zoid}";
				var continueURL = "";
				<#if (!is_auth_page)>
					var auth_page_url = "${auth_page_url}";
				</#if>
				var OrgUserInvitation = ZResource.extendClass(
				{
						resourceName: "OrgUserInvitation",//No I18N
						identifier: "digest",//No I18N
				});
				var multiDCOrgInvitation = ZResource.extendClass(
				{
						resourceName: "MultiDC",//No I18N
						attrs : ["invitation_email", "clone_dc", "clone_zoid", "digest"]	//No I18N
				});
				var multiDCExportOrgInvitation = ZResource.extendClass(
				{
						resourceName: "Export",//No I18N
						identifier: "digest",//No I18N
						parent : multiDCOrgInvitation,
						attrs : ["invitation_email", "clone_dc", "clone_zoid", "digest"]	//No I18N
				});
				window.onload = function() {
					URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
					URI.options.csrfParam = csrfParamName;
					URI.options.csrfValue = getCookie(csrfCookieName);
				}
				function rejectOrgInvitationDiffDcAuth(){
					new URI (multiDCExportOrgInvitation,"",digest).addQueryParam("clone_dc", clone_dc).DELETE().then(function(resp){
						disabledButton(".rejectBtn")
						if(resp.redirectUrl!=undefined){
							$("#responseContainer").addClass("error");
							$(".responseHeader").html(resp.localized_message);
							$(".responseDesc").html("<@i18n key="IAM.ORG.INVITATION.REJECT.SUCCESS.MESSAGE"/><@i18n key="IAM.ORG.INVITATION.REDIRECT.MESSAGE"/>");
							$("#invitationContainer").hide();
							continueURL = resp.redirectUrl;
							$("#responseContainer, .responseBtn").show();
							setTimeout(function(){switchto(resp.redirectUrl!=undefined?resp.redirectUrl:"")}, 5000)
						}
						else{
						$("#responseContainer").addClass("error");
						$(".responseHeader").html(resp.localized_message);
						$(".responseDesc").html(resp.message);
						$(".responseBtn, #invitationContainer").hide();
						$("#responseContainer").show();
						}
					},function(){
						showErrorMessage(getErrorMessage(resp))
						removeButtonDisable(".rejectBtn");//No I18N
					});
				}
		    	function setPhotoSize(ele) {
					if($(ele).height()>$(ele).width()) {
						$("#dp_pic").css({"width":"auto","height":"100%"});
					}
					else if($(ele).height()<$(ele).width()) {
						$("#dp_pic").css({"width":"100%","height":"auto"});
					}
					else {
						$("#dp_pic").css({"width":"100%","height":"100%"});
					}
				}
				function rejectOrgInvitationDiffDC(){
					if(isFormSubmitted){ return false}
					isFormSubmitted = true;
					disabledButton(".rejectBtn");
					new URI(OrgUserInvitation,digest).DELETE().then(function(resp) 
					{
					      if(resp.redirectUrl!=undefined){
					      	switchto(resp.redirectUrl!=undefined?resp.redirectUrl:"");
					      }else{
					      	$("#responseContainer").addClass("neutral");
							$(".responseHeader").html(resp.localized_message);
							$(".responseDesc").html(resp.message);
							$(".responseBtn, .invitationContainer").hide();
							$("#responseContainer").show();
					      }
					},
				  	function(resp) 
				  	{
						showErrorMessage(getErrorMessage(resp))
						removeButtonDisable(".rejectBtn");//No I18N
				  	}); 
				}
				function handlelogo() {
					$(".sorg_Displaypicture").removeClass('sorg_Displaypicture').addClass('org_Displaypicture');
					$(".sorg_icon").removeClass('sorg_icon').addClass('org_icon');
					$("#dp_pic").remove();
					$(".org_icon").text("Z");
				}
				function acceptOrgInvitationDiffDC(){
					if(isFormSubmitted){ return false}
					$("#invitationContainer").hide();
					$(".load-bg").removeClass("load-fade");$(".load-bg").addClass("loadWithText")
					$(".load-bg").show();
					var params = {
						"multidcexport": {
							"invitation_email": emailId,
							"clone_dc": clone_dc,
							"clone_zoid": clone_zoid,
							"digest": digest
						}
					}
					isFormSubmitted = true;
					disabledButton(".acceptBtn");
					sendRequestWithCallback("/webclient/v1/multidc/export", JSON.stringify(params), false, handleResponseDetails, "POST")
				}
				
				function handleResponseDetails(resp){
					resp = JSON.parse(resp);
					var statusCode = resp.status_code;
					if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299){
						$("#responseContainer").addClass("success");
						continueURL = resp.multidcexport.redirect_url;
						$("#responseContainer").show();
					}else{
						$("#responseContainer").addClass("error");
						if(resp.localized_heading!=undefined){$(".responseHeader").html(resp.localized_heading)}else{$(".responseHeader").html("<@i18n key="IAM.ORGINVITATION.ERROR.HEADER.INVALID"/>")}
						$(".responseDesc").html(resp.localized_message);
						$(".responseBtn").hide();
						$("#responseContainer").show();
					}
					setTimeout(function(){$(".load-bg").addClass("load-fade");$(".load-bg").removeClass("loadWithText");setTimeout(function(){$(".load-bg").attr("style","display:none")}, 300)}, 500)
				}
				function switchto(url) 
				{
					if(url == ""){return false}
					if (url.indexOf("http") != 0) 
					{ 
						var serverName = window.location.origin;
						if (!window.location.origin) {
							serverName = window.location.protocol + "//"+ window.location.hostname+ (window.location.port ? ':' + window.location.port : '');
						}
						if (url.indexOf("/") != 0) {
							url = "/" + url;
						}
						url = serverName + url;
					}
					window.top.location.href = url;
				}
				$(function() 
				{	
					<#if (Org_details.logo_txt ? has_content && !Org_details.use_appservice_logo ? has_content)>
						$(".org_icon").text("${Org_details.logo_txt}".toUpperCase());
					<#elseif (Org_details.use_appservice_logo ? has_content)>
						$("#dp_pic").attr("src","${Org_details.use_appservice_logo}");
					<#else>
						$(".org_icon").text("Z");//Z if the org name is empty
					</#if>
					if($(".load-bg").is(":visible")){
						setTimeout(function(){document.querySelector(".load-bg").classList.add("load-fade");setTimeout(function(){document.querySelector(".load-bg").style.display = "none";}, 300)}, 500);
					}
					
				});
		    </script>
		</head>
		<#if (is_auth_page)>
		<body>
			<div class="load-bg">
				<div class="basic-box-s box-anim">
					<svg width="40" height="40" style="shape-rendering: geometricPrecision;" class="line_loader">
						<rect x="5" y="5" rx="6" ry="6" width="32" height="32" class="path" style="stroke: rgb(246, 177, 27); stroke-width: 4.3; stroke-opacity: 1; fill: transparent; stroke-dasharray: 384px; stroke-dashoffset: 0px"/>
						<rect x="5" y="5" rx="6" ry="6" width="32" height="32" class="path path1 path1-anim" style="stroke: rgb(226, 39, 40); stroke-width: 4; stroke-opacity: 1; fill: transparent"/>
						<rect x="5" y="5" rx="6" ry="6" width="32" height="32" class="path path2 path2-anim" style="stroke: rgb(4, 152, 73); stroke-width: 4; stroke-opacity: 1; fill: transparent" />
						<rect x="5" y="5" rx="6" ry="6" width="32" height="32" class="path path3 path3-anim" style="stroke: rgb(34, 110, 179); stroke-width: 4; stroke-opacity: 1; fill: transparent"/>
						<rect x="5" y="5" rx="6" ry="6" width="32" height="32" class="path path4 path4-anim" style="stroke: rgb(246, 177, 27); stroke-width: 4.3; stroke-opacity: 1; fill: transparent"/>
					</svg>
			  	</div>
			  <div class="loadTextDiv"><div class="loadText"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.LOAD.TEXT" arg0="${clone_dc}" /></div></div>
			</div>
			<#include "announcement-logout.tpl">
			
			<#include "${location}/Unauth/invitation_errorToast.tpl">
			
			<div class="zoho_logo"></div>
			<div class="invitationContainer" id="invitationContainer">
				<div class="invite_details">
	                <#if (Org_details.use_appservice_logo ? has_content)>
	                	<div class="sorg_Displaypicture">
	                		<div class="sorg_icon"><img onload="setPhotoSize(this)" id="dp_pic" draggable="false" onerror="handlelogo()" style="border-radius: 6%;"></div>
	                	</div>
	                <#else>
	                   	<div class="org_Displaypicture">	
	                		<div class="org_icon"></div>
	                   	</div>
	                </#if>
	                <div class="org_Name">${Org_details.name}</div>
	        		<#if ((inviter_name)?has_content)>
	                <div class="Invitedby_Name"><@i18n key="IAM.ORG.INVITED.BY" arg0="${inviter_name}" /></div>
	       		 	</#if>
	            </div>
				<div class="desc_Container">
					<div class="desc_title"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.TITLE" arg0="${clone_dc}"/></div>
					<div class="desc_desc"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.DESC" arg0="${clone_dc}"/></div>
					<#if ((learn_more_link)?has_content)>
						<div class="orange_container"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.ORANGE.DESC" arg0="${learn_more_link}"/></div>
					<#else>
						<div class="orange_container"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.ORANGE.DESC.WITHOUT.LEARN"/></div>
					</#if>
					<#if (is_tos_needed)>
						<div class="tos_container">
									<input type="checkbox" class="tos_check" id="tos_input" name="tos"/>
									<span class="auth_checkbox">
										<span class="checkbox_tick"></span>
									</span> 
									<label for="tos_input"><span><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${tos_link}" arg1="${privacy_link}"/></span></label>
						</div>
					</#if>

					<div class="button_div">
						<button class="acceptBtn" onclick="acceptOrgInvitationDiffDC()"><@i18n key="IAM.FEDERATED.SIGNUP.CREATE.ACCOUNT.BUTTON"/></button>
						<button class="rejectBtn" onclick="rejectOrgInvitationDiffDcAuth()"><@i18n key="IAM.CANCEL"/></button>
					</div>
				</div>
			</div>
			<div class="responseContainer" id="responseContainer" style="display: none;">
				<div class="responseIcon"></div>
				<div class="responseHeader"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.SUCCESS.RESPONSE.TITLE"/></div>
				<div class="responseDesc"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.SUCCESS.RESPONSE.DESC" arg0="${emailId}" arg1="${clone_dc}" arg2="${Org_details.name}"/></div>
				<div class="responseBtnDiv"><button onclick="switchto(continueURL)" class="responseBtn"><@i18n key="IAM.CONTINUE"/></button></div>
			</div>
		</body>
		<#else>
		<body>
		
			<#include "${location}/Unauth/invitation_errorToast.tpl">
			
			<div class="zoho_logo"></div>
			<div class="invitationContainer">
				<div class="invite_details">
	                <#if (Org_details.use_appservice_logo ? has_content)>
	                	<div class="sorg_Displaypicture">
	                		<div class="sorg_icon"><img onload="setPhotoSize(this)" id="dp_pic" draggable="false" onerror="handlelogo()" style="border-radius: 6%;"></div>
	                	</div>
	                <#else>
	                   	<div class="org_Displaypicture">	
	                		<div class="org_icon"></div>
	                   	</div>
	                </#if>
	                <div class="org_Name">${Org_details.name}</div>
	        		<#if ((inviter_name)?has_content)>
	                <div class="Invitedby_Name"><@i18n key="IAM.ORG.INVITED.BY" arg0="${inviter_name}" /></div>
	       		 	</#if>
	            </div>
				<div class="desc_Container">
					<div class="desc_title"><@i18n key="IAM.ORG.INVITATION.TITLE"/></div>
					<div class="desc_desc"><@i18n key="IAM.ORGINVITATION.SIGNEDIN.SUBTITLE"/></div>
					<div class="orange_container"><@i18n key="IAM.ORGINVITATION.CROSS.DC.DESC" arg0="${clone_dc}" arg1="${origin_dc}"/></div>
					<div class="button_div">
						<button class="acceptBtn" onclick="switchto(auth_page_url)"><@i18n key="IAM.CONTACTS.ACCEPT"/></button>
						<button class="rejectBtn" onclick="rejectOrgInvitationDiffDC()"><@i18n key="IAM.INVITE.REJECT"/></button>
					</div>
				</div>
			</div>
			<div class="responseContainer" id="responseContainer" style="display: none;">
				<div class="responseIcon"></div>
				<div class="responseHeader"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.SUCCESS.RESPONSE.TITLE"/></div>
				<div class="responseDesc"><@i18n key="IAM.ORGINVITATION.CROSS.DC.AUTH.PAGE.SUCCESS.RESPONSE.DESC" arg0="${emailId}" arg1="${clone_dc}" arg2="${Org_details.name}"/></div>
				<div class="responseBtnDiv"><button onclick="switchto(continueURL)" class="responseBtn"><@i18n key="IAM.CONTINUE"/></button></div>
			</div>
		</body>
</#if>
</html>
