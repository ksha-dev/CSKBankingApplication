 <form id="reset_password_form" name="change_password_container" onsubmit="return chnage_password(event);" novalidate> 
	<div class="searchparent" id="change_password_container">
		<div class="textbox_div">
			<input id="change_password" placeholder="<@i18n key="IAM.NEW.PASS"/>" type="password" autocomplete="off" name="change_password" class="textbox" required="" onkeyup="check_pass();" autocapitalize="off" autocorrect="off" tabindex="1" />
			<span class="icon-hide show_hide_password" onclick="showHidePassword('change_password');"></span>
			<div class="fielderror"></div>		
		</div>
	</div>
	
	<div class="searchparent" id="reneter_password_container">
		<div class="textbox_div">
			<input id="reneter_password" placeholder="<@i18n key="IAM.CONFIRM.PASSWORD"/>" type="password" autocomplete="off" name="reneter_password" class="textbox" required="" onkeypress="clearCommonError('reneter_password')" autocapitalize="off" autocorrect="off" tabindex="1" />
			<span class="icon-hide show_hide_password" onclick="showHidePassword('reneter_password');"></span>
			<div class="fielderror"></div>		
		</div>
	</div>

	<button class="btn blue" type="submit" id="reset_password_submit" tabindex="2"><span><@i18n key="IAM.PASSWORD.CHANGE"/></span></button>
</form>