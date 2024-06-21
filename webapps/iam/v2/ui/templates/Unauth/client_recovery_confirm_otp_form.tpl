<form name="confirm_otp_container" onsubmit="username_confimation_action(); return false;" >
	<div class="searchparent" id="confirm_otp_container">
		<div class="textbox_div">
			<div id="confirm_otp" class="otp_container"></div>
			<input type="hidden" class="hide" id="username_mdigest" />
			<div class="textbox_actions">
				<span id="otp_resend" class="bluetext_action resendotp nonclickelem"></span>
				<div class="resend_text otp_sent" id="otp_sent" style="display:none"><@i18n key="IAM.GENERAL.OTP.SENDING"/></div>
			</div>
			<div class="fielderror"></div>	
		</div>
	</div>

	<button class="btn blue" id="otp_confirm_submit" tabindex="2"><span><@i18n key="IAM.NEW.SIGNIN.VERIFY"/></span></button>
</form>