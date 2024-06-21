<!DOCTYPE html>
<html>
<head>
<title><@i18n key="IAM.CREATE.ZACCOUNT" /></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script type="text/javascript" src="/accounts/p/${signup.portalid}/register/script?${signup.scriptParams}&loadcss=false&tvisit=true"></script>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}" type="text/javascript"></script>
<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
<link href="${SCL.getStaticFilePath("/accounts/css/signupnew.css")}" type="text/css" rel="stylesheet" />
<link href="${SCL.getStaticFilePath("/accounts/css/flagStyle.css")}" type="text/css" rel="stylesheet"/>
<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" type="text/javascript"></script>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
</head>
<body style="visibility: hidden;">
<#if signup.isEnabled>
	<div class="bg_one"></div>
	<div class="Alert"> <span class="tick_icon"></span> <span class="alert_message"></span> </div>
	<div align="center" class="main">
		<div class="inner-container">
		<div class='loader'></div>
    	<div class='blur_elem blur'></div>
    		<div class="signuptitle"><@i18n key="IAM.NEW.SIGNUP.TITLE"/></div>
    		<div id="formcontainer">
    			<div class="otpmobile force_signupuser" style="display:none">
					<span id="login_user"></span>
				</div>		
				<form action="${za.contextpath}/register.ac" name="signupform" method="post" class="form">
					<section class="signupcontainer">
						<dl class="za-fullname-container" style="display:none">
	     					<dd>
	     						<div class="name_division" style="margin-right: 5%">
	     							<input type="text" placeholder='<@i18n key="IAM.FIRST.NAME" />' name="firstname" maxlength="100" id="firstname" />
	     						</div>
	     						<div class="name_division">
	     							<input type="text" placeholder='<@i18n key="IAM.LAST.NAME" />' name="lastname" maxlength="100" id="lastname" />
	     						</div>
	     					</dd>
	     				</dl>
	     				<dl class="za-username-container">
	     					<dd>
	     						<input type="text" placeholder='<@i18n key="IAM.GENERAL.USERNAME" />' name="username" maxlength="100" />
	     					</dd>
	     				</dl>
	     				<dl class="za-emailormobile-container">
	     					<dd>
	     						<div class="za-country_code-container">
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-emailormobile" ></select>
								</div>
								<#if signup.mobileNumber?has_content>
	     							<input <#if signup.showMobileNoPlaceholder> type="text" <#else> type="number" </#if> placeholder='<@i18n key="IAM.EMAIL.ADDRESS.OR.MOBILE" />'onkeyup ="checking()" onkeydown="checking()" name="emailormobile" maxlength="100" id="phonenumber" value="${signup.mobileNumber}">
	     						<#else>
	     							<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS.OR.MOBILE" />'onkeyup ="checking()" onkeydown="checking()" name="emailormobile" maxlength="100" id="phonenumber" value="${signup.emailId}">
	     						</#if>
	     					</dd>
	     				</dl>	
	     				<dl class="za-mobile-container">
		     				<dd>	
		     					<div class="za-country_code-container">
		     						<label for='country_code_select' class='select_country_code'></label>
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-code" ></select>
								</div>
								<input <#if signup.showMobileNoPlaceholder> type="text" <#else> type="number" </#if> placeholder='<@i18n key="IAM.PHONE.NUMBER" />' onkeyup ="checking()" onkeydown="checking()" name="mobile" id="mobilefield" value="${signup.mobileNumber}" inputmode="numeric" oninput="allownumonly(this)"/>
							</dd>
						</dl>	
						<dl class="za-rmobile-container">
							<dd>
		     					<div class="za-country_code-container">
									<select class="form-input1 countryCnt1 za-country-select-code" name="country_code" id="country-coderecovery" ></select>
								</div>
								<input <#if signup.showMobileNoPlaceholder> type="text" <#else> type="number" </#if> placeholder='<@i18n key="IAM.PHONE.NUMBER" />' onkeyup ="checking()" onkeydown="checking()" name="rmobile" id="rmobilefield" value="${signup.mobileNumber}" inputmode="numeric" oninput="allownumonly(this)"/>
							</dd>
						</dl>		
						<dl class="za-email-container">
							<dd>
								<#if signup.emailId?has_content>
									<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS" />' name="email" class="form-input" id="emailfield"  value="${signup.emailId}" >
								<#else>
									<input type="text" placeholder='<@i18n key="IAM.EMAIL.ADDRESS" />' name="email" class="form-input" id="emailfield"  >
								</#if>
							</dd>
						</dl>
						<dl class="za-password-container">
							<dd>
								<input type="password" placeholder='<@i18n key="IAM.PASSWORD" />' name="password" id="password" class="form-input" onblur="$('.pwderror').hide()" onkeydown="checkPasswordStrength(event)" onkeyup="checkPasswordStrength(event)" >
								<span class="icon-hide show_hide_password"  id="show-password-icon" onclick=togglePasswordField(${signup.minpwdlen});></span>
								<div class="pwderror"></div>
							</dd>
						</dl>
						<dl class="za-country-container" style="display:none">
							<dd>
								<select class="form-input countryCnt za-country-select" name="country" id="country" onchange="changeDomainName(this.value);return false;"  placeholder='<@i18n key="IAM.TFA.SELECT.COUNTRY" />' ></select>
							</dd>
						</dl>
						<dl class="za-country_state-container" style="display:none">
							<dd>
								<select class="form-input countryCnt" name="country_state" id="country_state"></select>
							</dd>
						</dl>
						<dl class="za-captcha-container" style='position:relative;'>
							<dd>
								<input type="text" placeholder='<@i18n key="IAM.NEW.SIGNIN.ENTER.CAPTCHA" />' name="captcha" maxlength="10" class="form-input" id="captchafield"> 
								<div class="form-input" style="text-align:left">
								<div class='captcha_container'>
									<img src="${za.contextpath}/images/spacer.gif" class="za-captcha">
									<span class="za-refresh-captcha" onclick="changeHip(document.signupform)"></span></div>
								</div>
							</dd>
						</dl>
						<dl class="za-domain-container" style="display:none;">
							<dd>
								<div class='domain_text'>
									<span><@i18n key="IAM.NEW.SIGNUP.DOMAIN.CHANGE.DESC" /></span>
									<span style="color: #159AFF;cursor: pointer;" onclick="changeCountryDomain();"><@i18n key="IAM.SIGNUP.CHANGE" /></span>
								</div>
							</dd>
						</dl>
						<dl class="za-tos-container">
								<dd>
									<label for="tos" class="tos-signup">
										<span class="icon-medium unchecked" id="signup-termservice"></span>
		                           	 	<span><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${signup.termsOfServiceUrl}" arg1="${signup.privacyPolicyUrl}"/></span>
		                            	<input class="za-tos" type="checkbox" id="tos" name="tos" value="true" onclick="toggleTosField()"/>
		                       	 </label>
								</dd>
							</dl>
						<dl class="za-newsletter-container" style="display:none">
							<dd>
								<label for="newsletter" class="news-signup">
	                            	<input class="za-newsletter" type="checkbox" id="newsletter" name="newsletter" value="true" onclick="toggleNewsletterField()"/>
	                            	<span class="icon-medium icon-checkbox_on" id="signup-newsletter"></span>
	                           	 	<span><@i18n key="IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1.PORTAL"/></span>
	                       	 </label>
							</dd>
						</dl>
						<div class="clearBoth"></div>
						<dl class="za-submitbtn">
							<dd>
								<button class="signupbtn" id="nextbtn"><span><@i18n key="IAM.LINK.SIGNUP.SIGNUP"/></span></button>
								<div class="loadingImg"></div>
							</dd>
						</dl>
				</section>
				<section class="signupotpcontainer" style="display:none">
							<div class="verifytitle"><@i18n key="IAM.NEW.SIGNUP.VERIFY.TITLE"/></div>
							<div class="verifyheader"><@i18n key="IAM.NEW.SIGNUP.MOBILE.VERIFY.DESC"/></div>
							<div class="otpmobile">
								<span id="mobileotp"></span>
								<#if !signup.hide_change>
									<span class="change" onclick="gobacktosignup()"><@i18n key="IAM.SIGNUP.CHANGE"/></span>
								</#if>
							</div>
							<dl class="za-otp-container">
								<dd>
									<input type="text" inputmode="numeric" class="form-input" name="otp" id="otpfield" placeholder='<@i18n key="IAM.VERIFY.CODE" />' onkeydown="clearCommonError();" maxlength='10'>
									<span onclick="resendOTP()" class="resendotp"><@i18n key="IAM.SIGNUP.RESEND.OTP" /></span>
								</dd>
							</dl>
							<dl class="za-submitbtn-otp">
								<dd>
									<input type="button" class="signupbtn"  value='<@i18n key="IAM.NEW.SIGNIN.VERIFY" />' onclick="validateOTP()" name="otpfield">
									<div class="loadingImg"></div>
								</dd>
							</dl>
				</section>
				</form>
			</div>
		</div>
	</div>
</#if>
<script type="text/javascript">
		var countrycode = "${signup.countrycode}";
		var forcesignup = "${signup.force_signup}";
		var mobilenumber = "${signup.mobileNumber}";
		var emailId = $(".za-email-container input").val();
	 	function onSignupReady() {
			$(document.body).css("visibility", "visible");
			$(document.signupform).zaSignUp();
			var countrySelect = $(".za-rmobile-container").is(":visible") ? "country-coderecovery" : $(".za-mobile-container").is(":visible") ? "country-code": $(".za-emailormobile-container").is(":visible") ? "country-emailormobile":"";
			 if(countrySelect){
				$("#"+countrySelect).select2({
			        allowClear: true,
			        templateResult: format,
			        searchInputPlaceholder: '<@i18n key="IAM.SEARCH"/>',
			        templateSelection: function (option) {
			        	  selectFlag($("#"+countrySelect).find("option:selected"));
			              return option.text;
			        },
			        language: {
				        noResults: function(){
				            return '<@i18n key="IAM.NO.RESULT.FOUND"/>';
				        }
				    },
			        escapeMarkup: function (m) {
			          return m;
			        }
			      });
			      $("#"+countrySelect+"+.select2 .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
			      selectFlag($("#"+countrySelect).find("option:selected"));
			      $("#select2-"+countrySelect+"-container").html($("#"+countrySelect+" option:selected").attr("data_number"));
	      		 $(".select_"+countrySelect).html($("#"+countrySelect+" option:selected").attr("data_number"));
	      		 $("#"+countrySelect).change(function(){
			        $(".country_code").html($("#"+countrySelect+" option:selected").attr("data_number"));
			        $("#select2-"+countrySelect+"-container").html($("#"+countrySelect+" option:selected").attr("data_number"));
			     	setIndent($("#"+countrySelect).parent().siblings("input"));
		      });
		      }
		     if($(".za-country-container").is(":visible")){
		     	$("#country").select2({
		     		templateResult: function(option){
				        var spltext;
				    	if (!option.id) { return option.text; }
				    	spltext=option.text.split("(");
				    	var string_code = $(option.element).attr("value");
				    	var ob = '<div class="pic flag_'+string_code.toUpperCase()+'" ></div><span class="cn">'+spltext[0]+"</span>" ;
				    	return ob;
				    },
				    searchInputPlaceholder: '<@i18n key="IAM.SEARCH"/>',//no i18n
				    templateSelection: function (option) {
				    	selectFlag($(option.element));
	   		            return option.text;
				    },
				    language: {
				        noResults: function(){
				            return '<@i18n key="IAM.NO.RESULT.FOUND"/>';
				        }
				    },
				    escapeMarkup: function (m) {
				       return m;
				    }
		     	});
		     	$("#country+.select2 .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
		     	selectFlag($('#country').find("option:selected"));
		     	$("#country_state").select2();
		     }
		     checking();
		 	if(forcesignup){
		 		$(".loader, .blur").show();
		 		if(countrycode){
		 			 $('.za-country_code-container select[name=country_code]').val(countrycode);
		 			 $('.za-country_code-container select[name=country_code]').trigger('change');
		 			 checking();
		 		}
	 			toggleTosField();
	 			if((isValid(mobilenumber)|| isValid(emailId)) && !$(".za-password-container").is(":visible")){
	 				$(".force_signupuser").show()
	 				$(".za-username-container, .za-emailormobile-container, .za-mobile-container, .za-rmobile-container, .za-email-container, .za-password-container, .za-password-container, .za-country-container, .za-tos-container, .za-newsletter-container").hide();
	 				showAutoFilledUser();
	 			}
	 			$("[name='signupform']").submit();
	 		}
		 }
	</script>
</body>
</html>
