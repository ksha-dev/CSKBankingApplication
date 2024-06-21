 <form id="terminate_session_form" name="terminate_session_container" onsubmit="return send_terminate_session_request(this);" novalidate> 
	<div class="searchparent" id="terminate_web_sess">
		<div class="checkbox_div" style="padding:10px;">
			<input data-validate="zform_field" id="ter_all" name="clear_web" class="checkbox_check" type="checkbox">
			<span class="checkbox">
				<span class="checkbox_tick"></span>
			</span>
			<label for="ter_all" class="session_label">
				<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.WEB" /></span>
				<span id="terminate_session_web_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.SESSION.DESC"/></span>
			</label>
		</div>
	</div>
	
	<div class="searchparent" id="terminate_mob_apps">
		<div class="checkbox_div" style="padding:10px;margin-top:10px;">
			<input data-validate="zform_field" id="ter_mob" name="clear_mobile" class="checkbox_check" onchange="showOneAuthTerminate(this)" type="checkbox">
			<span class="checkbox">
				<span class="checkbox_tick"></span>
			</span>
			<label for="ter_mob" class="session_label big_checkbox_label">
				<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.SIGNOUT.MOBILE.SESSION" /></span>
				<span id="terminate_session_weband_mobile_desc" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.BROWSER.MOBILE.SESSION.DESC"/></span>
			</label>
		</div>
	</div>
	<div class="oneAuthLable">
		<div class="oneauthdiv"> 
			<span class="oneauth_icon one_auth_icon_v2"></span>
			<span class="text_container">
				<div class="text_header"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH" /></div>
				<div class="text_desc"><@i18n key="IAM.PASSWORD.TERMINATE.INCLUDE.ONEAUTH.DESC" /></div>
			</span>
			<div class="togglebtn_div include_oneAuth_button">
				<input class="real_togglebtn" id="include_oneauth" type="checkbox">
				<div class="togglebase">
					<div class="toggle_circle"></div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="searchparent" id="terminate_api_tok">
		<div class="checkbox_div" style="padding:10px;margin-top:10px">
			<input data-validate="zform_field" id="ter_apiToken" name="clear_apiToken" class="checkbox_check" type="checkbox">
			<span class="checkbox">
				<span class="checkbox_tick"></span>
			</span>
			<label for="ter_apiToken" class="session_label big_checkbox_label">
				<span class="checkbox_label"><@i18n key="IAM.RESET.PASSWORD.DELETE.APITOKENS" /></span>
				<span id="terminate_session_web_desc_apitoken" class="session_terminate_desc"><@i18n key="IAM.RESET.PASSWORD.REVOKE.CONNECTED.APPS.DESC"/></span>
			</label>
		</div>
	</div>

	<button id="terminate_session_submit"  class="btn blue" type="submit" tabindex="2"><span><@i18n key="IAM.CONTINUE" /></span></button>
</form>