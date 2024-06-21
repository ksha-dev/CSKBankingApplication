 <form name="mfa_totp_container" onsubmit="return false;" >
	<div class="searchparent" id="mfa_totp_container">
		<div class="textbox_div">
			<div id="mfa_totp" class="otp_container"></div>
			<div class="fielderror"></div>
		</div>
	</div>

	<button class="btn blue" onclick="mfa_totp_confimration()" id="mfa_totp_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
</form>