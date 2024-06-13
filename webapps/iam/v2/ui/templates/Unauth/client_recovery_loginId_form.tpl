<form name="login_id_container" onsubmit="return accountLookup(event);" novalidate >
	<div class="searchparent" id="login_id_container">
		<div class="textbox_div">
			<label for='country_code_select' class='select_country_code'></label>
			<select id="country_code_select" onchange="changeCountryCode();" name="countryselect">
				<#list country_code as dialingcode>
  					<option data-num="${dialingcode.code}" value="${dialingcode.dialcode}" id="${dialingcode.code}" >${dialingcode.display}</option>
   				</#list>
			</select>
			<input id="login_id" placeholder="<@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>" value="${Encoder.encodeHTMLAttribute(login_id)}":type="text" name="LOGIN_ID" class="textbox" required="" onkeydown="clearCommonError('login_id')" oninput="input_checking()" autocapitalize="off" autocomplete="on" autocorrect="off" tabindex="1" />
			<div class="fielderror"></div>							
		</div>
	</div>
	
	<div class="user_info" id="recovery_user_info" onclick="change_user()">
        <span class="menutext"></span>
        <span class="change_user"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
	</div>
	
	<div class="textbox_div" id="captcha_container">
		<div id="captcha_img" name="captcha" class="textbox"></div>
	    <span class="reloadcaptcha icon-reload" onclick="changeHip()"> </span>
		<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required="" onkeydown="clearCommonError('captcha'),removeCaptchaError('captcha')" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8"/>
		<div class="fielderror"></div> 
	</div>
	<span class="captchafielderror"></span>
	
	<button class="btn blue" id="nextbtn" tabindex="2" disabled="disabled"><span><@i18n key="IAM.NEXT"/></span></button>								
</form>