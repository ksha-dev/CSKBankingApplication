						<form name="login" id="login" onsubmit="javascript:return submitsignin(this);"  method="post" novalidate >
							<div class="fieldcontainer">
								<div class="searchparent" id="login_id_container">
									<div class="textbox_div" id="getusername">
									<span>
										<#if signin.emailOnly>
											<input id="login_id" placeholder="<@i18n key="IAM.EMAIL.ADDRESS"/>" value="${signin.loginId}" type="text" name="LOGIN_ID" class="textbox" required="" onkeydown="clearCommonError('login_id')" onkeyup ="checking()" autocapitalize="off" autocomplete="on" autocorrect="off" ${signin.readOnlyEmail} tabindex="1" />
										<#else>
											<label for='country_code_select' class='select_country_code'></label>
											<select id="country_code_select" onchange="changeCountryCode();"  name="countryselect">
			                  					<#list signin.country_code as dialingcode>
		                          					<option data-num="${dialingcode.code}" value="${dialingcode.dialcode}" id="${dialingcode.code}" >${dialingcode.display}</option>
		                           				</#list>
											</select>
											<#if signin.mobileOnly>
												<input id="login_id" placeholder="<@i18n key="IAM.NEW.SIGNIN.MOBILE"/>" value="${signin.loginId}" type="number" name="LOGIN_ID" class="textbox" required="" onkeydown="clearCommonError('login_id')" oninput="checking();allownumonly(this)" inputmode="numeric" autocapitalize="off" autocomplete="on" autocorrect="off" ${signin.readOnlyEmail} tabindex="1" />
											<#else>
												<input id="login_id" placeholder="<@i18n key="IAM.NEW.SIGNIN.EMAIL.ADDRESS.OR.MOBILE"/>" value="${signin.loginId}" type="text" name="LOGIN_ID" class="textbox" required="" onkeydown="clearCommonError('login_id')" oninput="checking()" autocapitalize="off" autocomplete="on" autocorrect="off" ${signin.readOnlyEmail} tabindex="1" />
											</#if>
										</#if>
										<div class="fielderror"></div>		
									</span>				
									</div>
								</div>
								<div class="getpassword zeroheight" id="password_container">
										<div class="hellouser">
											<div class="username"></div>
											<#if !signin.hide_change>
											<span class="Notyou bluetext" onclick="resetForm()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
											</#if>
										</div>
										<div class="textbox_div">
											<input id="password" placeholder="<@i18n key="IAM.NEW.SIGNIN.PASSWORD"/>" name="PASSWORD" type="password" class="textbox" required="" onfocus="this.value = this.value;" onkeydown="clearCommonError('password')" autocapitalize="off" autocomplete="password" autocorrect="off" maxlength="250"/> 
											<span class="icon-hide show_hide_password" onclick="showHidePassword();"></span>
											<div class="fielderror"></div>
											<div class="textbox_actions" id="enableotpoption">
												<span class="bluetext_action" id="signinwithotp" onclick="showAndGenerateOtp()"><@i18n key="IAM.NEW.SIGNIN.USING.OTP"/></span>
												
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
											<div class="textbox_actions" id="enableforgot">
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
											<div class="textbox_actions_saml" id="enablejwt" style="display:none;">
												<a href="#" class="bluetext_action signinwithjwt" style="text-decoration=none;"><@i18n key="IAM.NEW.SIGNIN.USING.JWT"/></a>
												<#if !signin.ishideFp>
													<span class="bluetext_action bluetext_action_right" id="blueforgotpassword" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></span>
												</#if>
											</div>
										</div> 
									</div>
									<div id="otp_container">
									<div class="hellouser">
										<div class="username"></div>
										<#if !signin.hide_change>
										<span class="Notyou bluetext" onclick="resetForm()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
										</#if>
									</div>
									<div class="textbox_div" >
										<input id="otp" placeholder="<@i18n key="IAM.VERIFY.CODE"/>" type="number" name="OTP" class="textbox" required="" onkeydown="clearCommonError('otp')" autocapitalize="off" oninput="allownumonly(this)" inputmode="numeric" autocorrect="off"/> 

										<div class="fielderror"></div>
										<div class="textbox_actions">
											<span class="bluetext_action" id="signinwithpass" onclick="showPassword()"><@i18n key="IAM.NEW.SIGNIN.USING.PASSWORD"/></span>
											<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
										</div>
									</div>
								</div>
								<div class="textbox_div" id="mfa_totp_container">
								<#if (signin.isMobile == 1) >
									<input id="mfa_totp" placeholder="<@i18n key="IAM.NEW.SIGNIN.VERIFY.CODE"/>" type="number" name="TOTP" class="textbox" required="" onkeydown="clearCommonError('mfa_totp')" autocapitalize="off" autocomplete="off" autocorrect="off"/> 
								<#else>
									<input id="mfa_totp" placeholder="<@i18n key="IAM.NEW.SIGNIN.VERIFY.CODE"/>" type="text" name="TOTP" class="textbox" required="" onkeydown="clearCommonError('mfa_totp')" autocapitalize="off" autocomplete="off" autocorrect="off"/> 
								</#if>	
								<div class="fielderror"></div>
								</div>
								<div class="textbox_div" id="mfa_otp_container">
								<#if (signin.isMobile == 1) >
									<input id="mfa_otp" placeholder="<@i18n key="IAM.VERIFY.CODE"/>" type="text" name="MFAOTP" class="textbox" required="" onkeydown="clearCommonError('mfa_otp')" autocapitalize="off" autocomplete="one-time-code" inputmode="numeric" autocorrect="off"/> 
								<#else>
									<input id="mfa_otp" placeholder="<@i18n key="IAM.VERIFY.CODE"/>" type="text" name="MFAOTP" class="textbox" required="" onkeydown="clearCommonError('mfa_otp')" autocapitalize="off" autocomplete="off" autocorrect="off"/>
								</#if>
								<div class="fielderror"></div>
								<div class="textbox_actions">
									<span class="bluetext_action bluetext_action_right resendotp" onclick="generateOTP(true)"><@i18n key="IAM.NEW.SIGNIN.RESEND.OTP"/></span>
								</div>
								</div>
								<div class="textbox_div" id="captcha_container">
									<input id="captcha" placeholder="<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA"/>" type="text" name="captcha" class="textbox" required="" onkeydown="clearCommonError('captcha')" autocapitalize="off" autocomplete="off" autocorrect="off" maxlength="8"/>
									<div id="captcha_img" name="captcha" class="textbox"></div>
									<span class="reloadcaptcha" onclick="changeHip()"> </span>
									<div class="fielderror"></div> 
								</div>
								<button class="btn blue" id="nextbtn" tabindex="2" disabled="disabled"><span><@i18n key="IAM.NEXT"/></span></button>
							</div>
							<div class='text16 pointer nomargin' id='recoverybtn' onclick='showCantAccessDevice()'><@i18n key="IAM.NEW.SIGNIN.CANT.ACCESS"/></div>
							<div class="text16 pointer nomargin" id="problemsignin" onclick="showproblemsignin()"><@i18n key="IAM.NEW.SIGNIN.PROBLEM.SIGNIN"/></div>
							<#if !signin.ishideFp>
								<div class="text16 pointer" id="forgotpassword"><a class="text16" onclick="goToForgotPassword();"><@i18n key="IAM.FORGOT.PASSWORD"/></a></div>
							</#if>
							<#if signin.showfs>
								<div class="line"></div>
								<div class="fed_2show">
									<div class="signin_fed_text"><@i18n key="IAM.NEW.SIGNIN.FEDERATED.LOGIN.TITLE"/></div>
										<#if signin.showzoho>
											<span class="fed_div zoho_fs_fed zoho_fed_box zoho_fed small_box show_fed" onclick="createandSubmitOpenIDForm('zoho');" title="<@i18n key="IAM.SIGNIN.USING.ZOHO.REAL.TEXT"/>">
									            <div class="fed_center">
									                <span class="fedicon-Zoho_common-2"></span>
									            </div>
									        </span>
										</#if>
										<#if signin.showapple>	
											<span class="fed_div large_box apple_normal_icon apple_fed" id="macappleicon" onclick="createandSubmitOpenIDForm('apple');" title="<@i18n key="IAM.FEDERATED.SIGNIN.APPLE"/>">
									             <div class="fed_center">
									                <span class="fedicon-apple_small"></span>
									            </div>
									        </span>
										</#if>
										<#if signin.showgoogle>
											<span class="fed_div large_box google_icon google_fed" onclick="createandSubmitOpenIDForm('google');" title="<@i18n key="IAM.FEDERATED.SIGNIN.GOOGLE"/>">
									            <div class="fed_center_google">
									                <span class="fedicon-google"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></span>
									            </div>
									        </span>
										</#if>
										<#if signin.showazure>
											<span class="fed_div large_box MS_icon azure_fed" onclick="createandSubmitOpenIDForm('azure');" title="<@i18n key="IAM.FEDERATED.SIGNIN.MICROSOFT"/>">
									            <div class="fed_center">
									                <span class="fedicon-azure_small"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></span>
									            </div>
									        </span>
										</#if>
										<#if signin.showlinkedin>
											 <span class="fed_div large_box linkedin_fed_box linkedin_fed" onclick="createandSubmitOpenIDForm('linkedin');" title="<@i18n key="IAM.FEDERATED.SIGNIN.LINKEDIN"/>">
									            <div class="fed_center">
									                <span class="fedicon-linkedin_small"></span>
									            </div>
									        </span>
										</#if>
										<#if signin.showfacebook>
											<span class="fed_div large_box fb_fed_box facebook_fed" onclick="createandSubmitOpenIDForm('facebook');" title="<@i18n key="IAM.FEDERATED.SIGNIN.FACEBOOK"/>">
												<div class="fed_center">
										            <div class="fedicon-facebook_small"></div>
										        </div>
									        </span>
										</#if>
										<#if signin.showapple>	
											<span class="fed_div large_box apple_normal_icon apple_fed" id="appleNormalIcon" onclick="createandSubmitOpenIDForm('apple');" title="<@i18n key="IAM.FEDERATED.SIGNIN.APPLE"/>">
									             <div class="fed_center">
									                <span class="fedicon-apple_small"></span>
									            </div>
									        </span>
										</#if>
								</div>
							</#if>
						</form>