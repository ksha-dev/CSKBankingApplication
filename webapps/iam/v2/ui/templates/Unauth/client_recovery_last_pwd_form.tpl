<form name="last_password_container" onsubmit="return false;" novalidate>
	<div class="searchparent" id="last_password_container">
		<div class="textbox_div">
			<input id="last_password" placeholder="<@i18n key="IAM.AC.ENTER.PASSWORD"/>" type="password" name="last_password" class="textbox" required="" onkeypress="clearCommonError('last_password')" autocapitalize="off" autocorrect="off" tabindex="1" />
			<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
			<div class="fielderror"></div>						
		</div>
	</div>
	
	<button class="btn blue" onclick="last_pwd_ckeck()" id="last_pwd_submit" tabindex="2"><span><@i18n key="IAM.AC.VERIFY.PASSWORD"/></span></button>
</form>