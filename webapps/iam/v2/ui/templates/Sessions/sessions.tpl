	<div id="useractivesessions_space" class="page_head">	<@i18n key="IAM.MENU.SESSIONS" />	</div>
	
	<div id="useractivesessionstab_space" class="tetraSlideParent" onclick="clicked_tab('sessions', 'useractivesessions')">
		<#include "${location}/Sessions/user-sessions.tpl">
	</div>
	
	<#if show_active_authtokens>
	<div id="userauthtoken_space" onclick="clicked_tab('sessions', 'userauthtoken')" >
		<#include "${location}/Sessions/api-tokens.tpl">
	</div>
	</#if>
	
	<#if show_active_history>
		<div id="useractivityhistory_space" onclick="clicked_tab('sessions', 'useractivityhistory')">
			<#include "${location}/Sessions/login-history.tpl">
		</div>
	</#if>
	
	<#if show_connected_apps>
		<div id="userconnectedapps_space" onclick="clicked_tab('sessions', 'userconnectedapps')">
			<#include "${location}/Sessions/connected-apps.tpl"> 
		</div>
	</#if>
	
	<#if show_app_signins>
		<div id="userapplogins_space" class="tetraSlideParent" onclick="clicked_tab('sessions', 'userapplogins')">
			<#include "${location}/Sessions/app-logins.tpl"> 
		</div>
	</#if>
	
	<#if show_thirdparty_access>
		<div id="thirdpartyaccess_space" class="tetraSlideParent" onclick="clicked_tab('sessions', 'thirdpartyaccess')">
			<#include "${location}/Sessions/thirdparty-access.tpl">
		</div>
	</#if>