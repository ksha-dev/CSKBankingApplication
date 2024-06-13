



		<script>
				var canSetupyubikey = Boolean("<#if canSetupyubikey>true</#if>");
				var canSetupGAuth = Boolean("<#if canSetupGAuth>true</#if>");
				var canSetupSMS = Boolean("<#if canSetupSMS>true</#if>");
				var canSetupExo = Boolean("<#if canSetupExo>true</#if>");
				var canSetup_mfa_device = Boolean("<#if canSetup_mfa_device>true</#if>");
				var canSetUpPasskey = Boolean("<#if canSetUpPasskey>true</#if>");
				var isBackupCodeDowloadMandatory = Boolean("<#if isBackupCodeDowloadMandatory>true</#if>");
		</script>
		
		
		<div id="MFA_space" class="page_head">	<@i18n key="IAM.MFA" />	</div>
		<div class="tfa_view_more_box hide" id="tfa_view_more_box" tabindex="1">
			<div class="view_more_header">
				<div id="header_content"></div>
				<span class="close_btn" onclick="closeview_all_mfanumber_view()"></span>
			</div>
			<div class="view_more_content">
			
			</div>
		</div>
		<div class="tfa_settings_sapce" onclick="clicked_tab('multiTFA', 'modes')">
			<#include "${location}/MultiMFA/MFA-modes.tpl">
		</div>
		
		<div class="tfa_settings_sapce" onclick="clicked_tab('multiTFA', 'recovery')">
			<#include "${location}/MultiMFA/MFA-recovery.tpl">
		</div>
		
		<div class="tfa_settings_sapce" onclick="clicked_tab('multiTFA', 'trusted_browser')">
			<#include "${location}/MultiMFA/MFA-trustedbrowser.tpl">
		</div>
		
		<div id="tfa_setup_sapce" class="">
			<#include "${location}/MultiMFA/MFA-setup.tpl">
		</div>
		
		<input type="hidden" id="tfa_method" value="">
		 
		