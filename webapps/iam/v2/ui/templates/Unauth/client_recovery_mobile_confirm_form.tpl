<form name="mobile_confirm_container" onsubmit="return false;" >
	<div class="searchparent" id="mobile_confirm_container">
		<div class="textbox_div">
			<input type="hidden" class="hide" id="selected_encrypt_mobile"/>
			<input id="mobile_confirm" placeholder="<@i18n key="IAM.ENTER.PHONE.NUMBER"/>" name="mobile_confirm" class="textbox" required="" oninput="this.value = this.value.replace(/[^\d]+/g,'')" onkeypress="clearCommonError('mobile_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
			<div class="fielderror"></div>						
		</div>
	</div>
	
	<button class="btn blue" id="mobconfirm_action" onclick="mobile_confirmation()" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
</form>