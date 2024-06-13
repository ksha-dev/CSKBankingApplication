<#if (error_code)?has_content>

<html>
	<head>
		<title><@i18n key="IAM.GRPINVITATION.TITLE" /></title>
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/accountUnauthStyle.css")}" rel="stylesheet"type="text/css" />
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		
		<script>
				function logout_olduser(link)
				{
					window.open(link+"&serviceurl="+ encodeURIComponent(window.location.href),"_self");
				}
		</script>
	</head>
	<body>
    	<div style="overflow:auto">
			<div class="centerContainer container" >
				<div class="header error_header" id="header">
   					<div class="zoho_logo_new"></div>  
					<div class="page_type_indicator icon-invalid"></div>
	        	</div>

	        	<div class="wrap">  
		        	<div class="info">
					    <div id="msgboard">
					    	<div class="head_text">${error_head}</div>
					    	<div class="description">${error_desc}</div>
					    	
					    	<#if (error_code=="GI103")>
				
								<button class="group-accept-btn" style="margin: auto;margin-top: 10px;display: block;" id="logout_btn" onclick="logout_olduser('${LogoutURL}')"><@i18n key="IAM.ORGINVITATION.FAILED.LOGOUT_USER" /></button>
								
							</#if>	
							
						</div>
					</div>
				</div>
			</div>
			<#include "footer.tpl">
		</div>
	</body>
</html>


<#else>


<html>
	<head>
		<title><@i18n key="IAM.GRPINVITATION.TITLE" /></title>
		
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/xregexp-all.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>	
		<script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script> 
		<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script> 
    	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/select2.full.min.js")}" type="text/javascript"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/common_unauth.js")}"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
		<link href="${SCL.getStaticFilePath("/v2/components/css/accountUnauthStyle.css")}" rel="stylesheet"type="text/css" />
		<script src="${SCL.getStaticFilePath("/v2/components/js/invitation.js")}"></script>
		<script src="${SCL.getStaticFilePath("/v2/components/js/uvselect.js")}" type="text/javascript"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/uvselect.css")}" rel="stylesheet"type="text/css">
		<script src="${SCL.getStaticFilePath("/v2/components/js/flagIcons.js")}" type="text/javascript"></script>
		<link href="${SCL.getStaticFilePath("/v2/components/css/flagIcons.css")}" rel="stylesheet"type="text/css">
		
		<script type="text/javascript">
		
			var passwordPolicy = undefined;
			
			<#if ((passwordPolicy)?has_content)>
			 passwordPolicy = '${passwordPolicy}';
			</#if>
			
			<#if emailId_ejs?has_content>
				var login_id="${emailId_ejs}";
			</#if>
			
			var contextpath= "${za.contextpath}";
			 
			var digest ="${digest}";
			var signupRequired = ${signupRequired};
			if(passwordPolicy!=""	&&	passwordPolicy!=undefined){
				PasswordPolicy.data = JSON.parse(passwordPolicy);
			}
			var isMobile = ${is_mobile?c};
			var expiryTime = "${expiry_time}";
			I18N.load({
				"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
				"IAM.ERROR.ENTER.NEW.PASSWORD" : '<@i18n key="IAM.ERROR.ENTER.NEW.PASSWORD" />',
				"IAM.ERROR.CODE.U110" : '<@i18n key="IAM.ERROR.CODE.U110" />',
				"IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS" : '<@i18n key="IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS" />',
				"IAM.REENTER.PASSWORD" : '<@i18n key="IAM.REENTER.PASSWORD" />',
				"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD" />',
				"IAM.ERROR.TERMS.POLICY" : '<@i18n key="IAM.ERROR.TERMS.POLICY" />',
				"IAM.SEARCH" : '<@i18n key="IAM.SEARCH" />',
				"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
				"IAM.ERROR.FNAME.INVALID.CHARACTERS" : '<@i18n key="IAM.ERROR.FNAME.INVALID.CHARACTERS" />',
				"IAM.ERROR.LNAME.INVALID.CHARACTERS" : '<@i18n key="IAM.ERROR.LNAME.INVALID.CHARACTERS" />',
				"IAM.NEW.SIGNUP.FIRSTNAME.VALID" : '<@i18n key="IAM.NEW.SIGNUP.FIRSTNAME.VALID" />',
				"IAM.PASS_POLICY.MIN_MAX":'<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
				"IAM.PASS_POLICY.SPL_SING":'<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
				"IAM.PASS_POLICY.SPL":'<@i18n key="IAM.PASS_POLICY.SPL" />',
				"IAM.PASS_POLICY.NUM_SING":'<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
				"IAM.PASS_POLICY.NUM":'<@i18n key="IAM.PASS_POLICY.NUM" />',
				"IAM.PASS_POLICY.CASE":'<@i18n key="IAM.PASS_POLICY.CASE" />',
				"IAM.PASS_POLICY.HEADING":'<@i18n key="IAM.PASS_POLICY.HEADING" />',
				"IAM.SEARCHING":'<@i18n key="IAM.SEARCHING" />',
				"IAM.NO.RESULT.FOUND":'<@i18n key="IAM.NO.RESULT.FOUND" />',
				"IAM.HOME.LINK":'<@i18n key="IAM.HOME.LINK" />',
				"IAM.GROUPINVITATION.GO.TO":'<@i18n key="IAM.GROUPINVITATION.GO.TO" />'
			});
    		var iam_search_text = I18N.get("IAM.SEARCHING");
    		var iam_no_result_found_text = I18N.get("IAM.NO.RESULT.FOUND");
			$(function() {	
				if(signupRequired) {
					$("#localeCn").uvselect({
    					"country-flag" : true,
    					"width" : "260px"
    				});
					check_news_letter_check();
				}
			});
		</script>
		<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	</head>
	<body>
		<#assign tos_link><@i18n key="IAM.LINK.TOS" /></#assign> <#assign privacy_link><@i18n key="IAM.LINK.PRIVACY" /></#assign>
		<div class="blur"></div>
		<div id="error_space_id" class="error_space">
			<span class="error_icon">!</span>
			<span class="top_msg"></span>
		</div>
		<div class="result_popup_box hide">
			<div class="zoho_logo_new"></div>
			<div class="result_popup hide" id="result_popup_accepted">
				<div class="success_pop_bg"></div>
				<div class="success_icon"></div>
				<div class="content_space">
					<div class="defin_text"><@i18n key="IAM.GROUPINVITATION.ACCEPTED" arg0="${group.name}"/></div>
				</div>
				<button class="button center_btn"><@i18n key="IAM.GROUPINVITATION.GO.TO.GROUPS"/></button>
			</div>
		
			<div class="result_popup hide" id="result_popup_rejected">
				<div class="reject_pop_bg"></div>
				<div class="reject_icon"><span class="reject-red-circle"></span></div>
				<div class="content_space">
					<div class="defin_text"><@i18n key="IAM.GROUPINVITATION.REJECTED"/></div>
				</div>
				<button class="button center_btn"><@i18n key="IAM.GROUPINVITATION.GO.TO.ACCOUNTS"/></button>
			</div>
		</div>

    	<div style="overflow:auto">
    		<div class="container main-container">
    			<div class="left-container">
    				<div class="zoho_logo_new"></div>
    				<#if signupRequired=="true">
    					<div class="group-user-signup">
    					<div class="group-header"><@i18n key="IAM.GROUPINVITATION.SIGNUP.TO.JOIN" /></div>
    					<div class="group-header_description"><@i18n key="IAM.GROUPINVITATION.SIGNUP.INVITE" arg0="${inviter_name}" arg1="${group.name}"  arg2="${emailId}"/></div>
    					<div class="signup-invite-box">
	    					<div class="group-invite_box">
		    					<div class="invite-box_left">
		    						<div class="group-icon_circle">
		    							<span class="group-icon_text hide"></span>
		    							<img class="group-icon_img" onerror="showTextDp();" src="${group.photourl}" />
		    						</div>
		    					</div>
		    					<div class="invite-box_right">
		    						<div class="grp_name_text">${group.name}</div>
		    						<#if ((group.description)?has_content)>
		    							<div class="grp_description_text">${group.description}</div>
		    						<#else>
		    							<div class="grp_description_text"><@i18n key="IAM.GROUPINVITATION.DESCRIPTION.NOT.PROVIDED" /></div>
		    						</#if>
		    					</div>
		    				</div>
		    				<div class="group-expiry"><@i18n key="IAM.GROUPINVITATION.EXPIRY" /></div>
		    				<div class="group-btns">
		    					<div class="group-accept-btn" onclick="showSignUpForm();"><@i18n key="IAM.NEXT" /></div>
		    					<div class="group-reject-btn" onclick="reject_group_invitation(this)"><@i18n key="IAM.INVITE.REJECT" /><span></span></div>
		    				</div>
		    			</div>
    					<form class="group-input-form hide" name="signup_form" id="signup_form" novalidate onsubmit="return false;">
    						<div class="invite-form-fields">
	    						<div class="group-input-field_box" id="first_name_field">
	    							<label class="group-input-label" for="first_name" class=""><@i18n key="IAM.FIRST.NAME" /></label>
									<input name="first_name" maxlength="100" class="group-input-field" tabindex="1" id="first_name" autocomplete="off" onkeypress="err_remove()" required="" placeholder='<@i18n key="IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.FIRSTNAME" />' />
								</div>
								<div class="group-input-field_box" id="last_name_field">
	    							<label class="group-input-label" for="last_name" class=""><@i18n key="IAM.LAST.NAME" /></label>
									<input name="last_name" maxlength="100" class="group-input-field" tabindex="1" id="last_name" autocomplete="off" onkeypress="err_remove()" required="" placeholder='<@i18n key="IAM.FEDERATED.SIGNUP.CREATE.PLACEHOLDER.LASTNAME" />'/>
								</div>
								<div class="group-input-field_box" id="password_name_field">
	    							<label class="group-input-label" for="password" class=""><@i18n key="IAM.PASSWORD" /></label>
									<input name="password" maxlength="250" onkeyup="check_pp('${passwordPolicy.mixed_case?c}','${passwordPolicy.min_spl_chars}','${passwordPolicy.min_numeric_chars}','${passwordPolicy.min_length}')" type="password" class="group-input-field" tabindex="1" id="signup_pass" autocomplete="off" onkeypress="err_remove()" required="" placeholder='<@i18n key="IAM.NEW.SIGNIN.PASSWORD" />'/>
									<span class="pass_icon pass_hide" onclick="togglePassHide(this,'signup_pass')"></span>
								</div>
								<div class="group-input-field_box" id="pass_confirm_field">
	    							<label class="group-input-label" for="pass_confirm_name" class=""><@i18n key="IAM.CONFIRM.PASS" /></label>
									<input name="con_password" maxlength="250" type="password" class="group-input-field" tabindex="1" id="pass_confirm_name" onkeyup="validateConfirmPassword('#signup_pass')" autocomplete="off" onkeypress="err_remove()" required="" placeholder='<@i18n key="IAM.NEW.SIGNIN.PASSWORD" />'/>
									<span class="pass_icon pass_hide" onclick="togglePassHide(this,'pass_confirm_name')"></span>
								</div>
								<div class="group-input-field_box" id="country_name_field">
	    							<label class="group-input-label" for="" class=""><@i18n key="IAM.COUNTRY" /></label>
	    							<select class="group-input-field" autocomplete='country-name' name="country" id="localeCn" onchange="check_for_state()" embed-icon-class="flagIcons" searchable="true" placeholder="<@i18n key="IAM.SEARCHING"/>">
										<#list Countries as countrydata>
											<option value="${countrydata.code}" data-subscriptionmode="${countrydata.newsletterSubscriptionMode}" id="${countrydata.code}" >${countrydata.display_name}</option>
										</#list>
									</select>
	    						</div>
	    						<div class="group-input-field_box" id="state_name_field" style="display: none;">
	    							<label class="group-input-label" for="" class=""><@i18n key="IAM.GDPR.DPA.ADDRESS.STATE" /></label>
	    							<select class="profile_mode" autocomplete='country-state-name' name="country_state" id="locale-state" searchable="true">
											<option id="default" disabled selected><@i18n key="IAM.US.STATE.SELECT" /></option>
									</select>
	    						</div>
    						</div>
    						<div class="authorize_check news_letter_chk group_invite_checkbox">
									<input type="checkbox" onclick="err_remove()" class="trust_check" id="news_letter" name="news_letter"/>
									<span class="auth_checkbox">
										<span class="checkbox_tick"></span>
									</span> 
									<label for="news_letter"><@i18n key="IAM.USERPREFERENCE.NEWSLETTER.SUBSCRIBE" /></label>
							</div>
    						<div class="authorize_check">
    							<div class="term-of-service">
									<input type="checkbox" onclick="err_remove()" class="trust_check" id="tos_check" name="tos_check"/> 
									<span class="auth_checkbox"> 
										<span class="checkbox_tick"></span>
									</span> 
									<label for="tos_check"><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${tos_link}" arg1="${privacy_link}" /></label>
								</div>
							</div>
							<div class="group-btns">
		    					<button class="group-accept-btn" onclick="accept_group_invitation(${signupRequired},this)" type="submit"><@i18n key="IAM.GROUPINVITATION.SIGNUP.JOIN.GROUP" /><span></span></button>
		    					<button class="group-reject-btn" onclick="reject_group_invitation(this)"><@i18n key="IAM.INVITE.REJECT" /><span></span></button>
	    					</div>
    					</form>
    				</div>
    				<#else>
    				<div class="group-user-invite">
	    				<div class="group-header"><@i18n key="IAM.GROUPINVITATION.JOIN.GROUP" /></div>
	    				<div class="group-header_description"><@i18n key="IAM.GROUPINVITATION.INVITE.DESCRIPTION" arg0="${inviter_name}" arg1="${group.name}"/></div>
	    				<div class="group-invite_box">
	    					<div class="invite-box_left">
	    						<div class="group-icon_circle">
	    							<span class="group-icon_text hide"></span>
	    							<img class="group-icon_img" onerror="showTextDp();" src="${group.photourl}" />
	    						</div>
	    					</div>
	    					<div class="invite-box_right">
	    						<div class="grp_name_text">${group.name}</div>
	    						<#if ((group.description)?has_content)>
		    						<div class="grp_description_text">${group.description}</div>
		    					<#else>
		    						<div class="grp_description_text"><@i18n key="IAM.GROUPINVITATION.DESCRIPTION.NOT.PROVIDED" /></div>
		    					</#if>	    					
	    					</div>
	    				</div>
	    				<div class="group-expiry"><@i18n key="IAM.GROUPINVITATION.EXPIRY" /></div>
	    				<div class="group-btns">
	    				
	    				  <#if (!(user_loggedIn)?has_content)>
	    					<div id="grp_existing_accept" class="group-accept-btn" onclick="invitationSigninRedirect()"><@i18n key="IAM.ORGINVITATION.SIGNIN.TO.ACCEPT" /><span></span></div>
	    				  <#else>
	    				  	<div id="grp_existing_accept" class="group-accept-btn" onclick="accept_group_invitation(${signupRequired},this)"><@i18n key="IAM.JOIN" /><span></span></div>
	    				  </#if>
	    				  
	    					<div class="group-reject-btn" onclick="reject_group_invitation(this)"><@i18n key="IAM.INVITE.REJECT" /><span></span></div>
	    				</div>
    				</div>
    				</#if>
    			</div>
    			<div class="right-container"></div>
    		</div>
			<#include "footer.tpl">
    	</div>
	</body>
	<script>
		window.onload=function() {
			try {
    			URI.options.contextpath="${za.contextpath}/webclient/v1";//No I18N
				URI.options.csrfParam = "${za.csrf_paramName}";
				URI.options.csrfValue = getCookie("${za.csrf_cookieName}");
				$(".expiry-time").html(expiryTime);
				var groupName = "${group.name}";
				var groupNameSplit = groupName.split(" ");
				var groupIconText=groupNameSplit[0][0];
				if(groupNameSplit.lenght > 1){
					groupIconText+= groupNameSplit[1][0];
				}
				else {
					groupIconText+= groupNameSplit[0][1];
				}
				$(".group-icon_text").html(groupIconText.toUpperCase());
			}catch(e){}
		}
		var NewsLetterSubscriptionMode = {};
				<#if newsletter_subscription_mode?has_content>
					NewsLetterSubscriptionMode =JSON.parse('${newsletter_subscription_mode}');
				</#if>
		<#if CountryStates?has_content>
				var states_details = ${CountryStates};
					$("#locale-state").uvselect({
						"width" : "260px"
					});
			</#if>
		function check_for_state()
		{
			check_news_letter_check();
			if(states_details[$("#localeCn").val().toLowerCase().trim()])
			{	  
				  $("#locale-state").find('option').not(':first').remove();
				  $("#state_name_field").show();
				  $("#locale-state").html(($("#locale-state").html()+states_details[$("#localeCn").val().toLowerCase().trim()]));
				  $("#locale-state").uvselect();
			}
			else
			{
				$("#state_name_field").hide();
			}
			setFooterPosition();
		}	
	</script>
</html>

</#if>
