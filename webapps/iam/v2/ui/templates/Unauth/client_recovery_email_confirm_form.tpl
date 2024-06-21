<form name="email_confirm_container" onsubmit="return false;" >
	<div class="searchparent" id="email_confirm_container">
		<div class="textbox_div">
			<input type="hidden" class="hide" id="selected_encrypt_email"/>
			<input id="email_confirm" placeholder="<@i18n key="IAM.ENTER.EMAIL"/>" name="email_confirm" class="textbox" required="" onkeypress="clearCommonError('email_confirm')" autocapitalize="off" autocorrect="off" tabindex="1" />
			<div class="fielderror"></div>						
		</div>
	</div>
	
	<button class="btn blue" id="emailconfirm_action" onclick="email_confirmation()" id="nextbtn" tabindex="2"><span><@i18n key="IAM.SEND.OTP"/></span></button>
</form>