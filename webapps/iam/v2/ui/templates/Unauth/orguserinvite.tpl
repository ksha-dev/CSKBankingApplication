<#if is_network?has_content && is_network>

	<#assign type = "SORG" type2="SORGINVITATION">

<#else>

	<#assign type = "ORG" type2="ORGINVITATION">

</#if>	



<#if (error_code)?has_content>

	<html>
		<head>
			<title><@i18n key="IAM.${type}.INVITATION.TITLE" /></title>
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			<@resource path="/v2/components/css/${customized_lang_font}" />
			<@resource path="/v2/components/css/accountsInviatation.css" />
			<style>
				body .zohologo{
					 background : url("${SCL.getStaticFilePath('/v2/components/images/newZoho_logo.svg')}") no-repeat;
					 background-position : center;
  					 background-size : auto 40px;
				}
				.zohologo.Vani{background-image : url("${SCL.getStaticFilePath('/v2/components/images/apps/Vani.svg')}")}
			</style>
			<script>
				function logout_olduser(link)
				{
					window.open(link+"&serviceurl="+ encodeURIComponent(window.location.href),"_self");
				}
				
				function switchto(url) 
				{
					if (url.indexOf("http") != 0) 
					{ 
						var serverName = window.location.origin;
						if (!window.location.origin) {
							serverName = window.location.protocol + "//"+ window.location.hostname+ (window.location.port ? ':' + window.location.port : '');
						}
						if (url.indexOf("/") != 0) {
							url = "/" + url;
						}
						url = serverName + url;
					}
					window.top.location.href = url;
				}
			</script>
		</head>
		<body>
		
		<div class="zohologo ${service_logo_name}"></div>
			
		<div class="result_popup" id="result_popup_error">
			<div class="error_pop_bg"></div>
			<div class="reject_icon"><span class="inner_circle"></span></div>
			<div class="content_space">
				
			<#if (Error_heading)?has_content>
				<div class="grn_text" id="result_content">${Error_heading}</div>
			<#else>
				<div class="grn_text" id="result_content"><@i18n key="IAM.${type2}.ERROR.HEADER.INVALID"/></div>
			</#if>	
				<div class="defin_text">${Error_message}</div>
				<#if (error_code=="OI106")>
				
					<button class="button center_btn" onclick="switchto('${redirect_link}')"><@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.PORTAL" /></button>
				
				<#elseif (error_code=="OI104")>
				
					<button class="blue_btn logout_btn" id="logout_btn" onclick="logout_olduser('${LogoutURL}')"><@i18n key="IAM.ORGINVITATION.FAILED.LOGOUT_USER" /></button>
					
				</#if>	
			</div>
		</div>
		
		</body>
	</html>

<#elseif ((multi_dc_invite)?has_content	&&	multi_dc_invite=="true")>
	<#include "orgUserInviteMultiDC.tpl">
<#elseif ((link_idp)?has_content	&&	link_idp=="true")>


	<html>
		<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
		<script>
			$( document ).ready(function() {
			    var parent = window.opener;
			    var target_origin = parent.location.href;    
			    parent.show_blur_screen();  
			    parent.idp_confirmation_exiting_account();  
			    window.close();	
			});
		</script>
	</html>


<#elseif ((idp_confirmation)?has_content	&&	idp_confirmation=="true")>


	<html>
			<@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
			<script>
			
				<#if curr_country?has_content>
					var curr_country = "${curr_country}";
				<#else>
					var curr_country = undefined;
				</#if>
					
				var response_obj = {
						"idp_provider" : "${idp_provider}",
						"first_name" : "${first_name}",
						"last_name" : "${last_name}",
						"idp_email" : "${idp_email}",
						"curr_country" : curr_country,
						"idp_dp" : "${idp_dp}"
				}
				$( document ).ready(function() {
				    var parent = window.opener;
				    parent.idp_signup_section(response_obj);  
				    window.close();	
				});
			</script>
		</html>


<#else>
	<#assign corp_link>
			<@i18n key="IAM.ZOHOCORP.LINK"/>
	</#assign>
	<html>
		<head>
			<title><@i18n key="IAM.${type}.INVITATION.TITLE" /></title>
		    <meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			
		    <@resource path="/v2/components/css/${customized_lang_font}" />
		    <@resource path="/v2/components/css/accountsInviatation.css" />
		    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
			<@resource path="/v2/components/js/zresource.js" /> 
			<@resource path="/v2/components/js/uri.js" /> 
			<@resource path="/v2/components/js/common_unauth.js" />
			<@resource path="/v2/components/tp_pkg/xregexp-all.js" />
	    	<@resource path="/v2/components/tp_pkg/select2.full.min.js" />
	    	<@resource path="/v2/components/css/product-icon.css" />
			<style>
				body .zohologo{
					 background : url("${SCL.getStaticFilePath('/v2/components/images/newZoho_logo.svg')}") no-repeat;
					 background-position : center;
  					 background-size : auto 40px;
				}
				.zohologo.Vani{background-image : url("${SCL.getStaticFilePath('/v2/components/images/apps/Vani.svg')}")}
			</style>
	    	<script type="text/javascript">

				var _time;
		  		var passwordPolicy = undefined;
		  		var isPasswordRequired = 'false';
				<#if isPasswordRequired> isPasswordRequired =  'true' </#if>
				
				<#if ((passwordPolicy)?has_content)>
				 passwordPolicy = '${passwordPolicy}';
				</#if>
				 
				var csrfParamName= "${za.csrf_paramName}";
				var csrfCookieName = "${za.csrf_cookieName}";
				var digest ="${digest}";
				var contextpath= "${za.contextpath}";
				var isMobile = Boolean("<#if is_mobile>true</#if>");
				var user_2_png = "${SCL.getStaticFilePath("/v2/components/images/user_2.png")}";
				
				var NewsLetterSubscriptionMode = {};
				<#if newsletter_subscription_mode?has_content>
					NewsLetterSubscriptionMode =JSON.parse('${newsletter_subscription_mode}');
				</#if>
				
				<#if signupRequired?has_content>
					var defaultCountry="${default_country_code}";
					var signupRequired = true;
				<#else>
					var signupRequired = false;
				</#if>
				
				<#if user_loggedIn?has_content>
					var user_loggedIn = true;
				<#else>
					var user_loggedIn = false;
				</#if>
				
				<#if idp_account?has_content>
					var idp_account = true;
				<#else>
					var idp_account = false;
				</#if>
				
				<#if States?has_content>
					var states_details =${States};
				</#if>	
				
				if(passwordPolicy!=""	&&	passwordPolicy!=undefined)
				{
					PasswordPolicy.data = JSON.parse(passwordPolicy);
				}  
				var service_name = "${servicename}";
				var mixed_case,min_spl_chars,min_numeric_chars,min_length;
				I18N.load
				({
					"IAM.ERROR.ENTER_PASS" : '<@i18n key="IAM.ERROR.ENTER_PASS" />',
					"IAM.ERROR.ENTER.NEW.PASSWORD" : '<@i18n key="IAM.ERROR.ENTER.NEW.PASSWORD" />',
					"IAM.ERROR.CODE.U110" : '<@i18n key="IAM.ERROR.CODE.U110" />',
					"IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS" : '<@i18n key="IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS" />',
					"IAM.REENTER.PASSWORD" : '<@i18n key="IAM.REENTER.PASSWORD" />',
					"IAM.ERROR.EMPTY.FIELD" : '<@i18n key="IAM.ERROR.EMPTY.FIELD" />',
					"IAM.ERROR.TERMS.POLICY" : '<@i18n key="IAM.ERROR.TERMS.POLICY" />',
					"IAM.SEARCH" : '<@i18n key="IAM.SEARCH" />',
					"IAM.CONTACTS.ACCEPT" : '<@i18n key="IAM.CONTACTS.ACCEPT" />',
					"IAM.ORG.INVITATION.SIGNIN_SUCCESSFUl" : '<@i18n key="IAM.ORG.INVITATION.SIGNIN_SUCCESSFUl" />',
					"IAM.PASSWORD.POLICY.HEADING" : '<@i18n key="IAM.PASSWORD.POLICY.HEADING" />',
					"IAM.RESETPASS.PASSWORD.MIN" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN" />',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH" />',
					"IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINSPECIALCHAR.ONLY" />',
					"IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" : '<@i18n key="IAM.RESET.PASSWORD.POLICY.MINNUMERICCHAR.ONLY" />',
					"IAM.PASS_POLICY.HEADING" : '<@i18n key="IAM.PASS_POLICY.HEADING" />',
					"IAM.PASS_POLICY.MIN_MAX" : '<@i18n key="IAM.PASS_POLICY.MIN_MAX" />',
					"IAM.PASS_POLICY.SPL" : '<@i18n key="IAM.PASS_POLICY.SPL" />',
					"IAM.PASS_POLICY.SPL_SING" : '<@i18n key="IAM.PASS_POLICY.SPL_SING" />',
					"IAM.PASS_POLICY.NUM" : '<@i18n key="IAM.PASS_POLICY.NUM" />',
					"IAM.PASS_POLICY.NUM_SING" : '<@i18n key="IAM.PASS_POLICY.NUM_SING" />',
					"IAM.PASS_POLICY.CASE" : '<@i18n key="IAM.PASS_POLICY.CASE" />',
					"IAM.INCLUDE" : '<@i18n key="IAM.INCLUDE" />',
					"IAM.RESETPASS.PASSWORD.MIN.NO.WITH" : '<@i18n key="IAM.RESETPASS.PASSWORD.MIN.NO.WITH" />',
					"IAM.SEARCH" : '<@i18n key="IAM.SEARCH" />',
					"IAM.ORG.INVITATION.INVITE.HEADING" : '<@i18n key="IAM.ORG.INVITATION.INVITE.HEADING" />',
					"IAM.NO.RESULT.FOUND" : '<@i18n key="IAM.NO.RESULT.FOUND" />',
					"IAM.ERROR.FNAME.INVALID.CHARACTERS" : '<@i18n key="IAM.ERROR.FNAME.INVALID.CHARACTERS" />',
					"IAM.ERROR.LNAME.INVALID.CHARACTERS" : '<@i18n key="IAM.ERROR.LNAME.INVALID.CHARACTERS" />',
					"IAM.INVITATION.PRECHECK.ERROR.TITLE" : '<@i18n key="IAM.INVITATION.PRECHECK.ERROR.TITLE" />',
					"IAM.ORG.INVITATION.REDIRECT.MESSAGE" : '<@i18n key="IAM.ORG.INVITATION.REDIRECT.MESSAGE" />',
					"IAM.NEW.SIGNUP.FIRSTNAME.VALID" : '<@i18n key="IAM.NEW.SIGNUP.FIRSTNAME.VALID" />'
					
				});
				
				var err_try_again = '<@i18n key="IAM.ERROR.GENERAL" />';
				<#if mobile_number?has_content>
					var login_id="${mobile_number}";
				<#else>
					var login_id="${emailId}";
				</#if>
				$(function() 
				{	
					<#if (Org_details.logo_txt ? has_content && !Org_details.use_appservice_logo ? has_content)>
						$(".org_icon").text("${Org_details.logo_txt}".toUpperCase());
					<#elseif (Org_details.use_appservice_logo ? has_content)>
						$("#dp_pic").attr("src","${Org_details.use_appservice_logo}");
					<#else>
						$(".org_icon").text("Z");//Z if the org name is empty
					</#if>
					
					<#if restricted_acess?has_content && restricted_acess=="true"	&&	 (user_loggedIn)?has_content && user_loggedIn=="true">
					//invitation is of restricted type and the user has logged in to view to invite
						check_restictuser_check();
						
					</#if>
					
					if(signupRequired) 
					{
						mixed_case='${passwordPolicy.mixed_case?c}';
						min_spl_chars='${passwordPolicy.min_spl_chars}';
						min_numeric_chars='${passwordPolicy.min_numeric_chars}';
						min_length='${passwordPolicy.min_length}';
						
						$('#gdpr_us_state select').select2().on("select2:open", function() {
						       $(".select2-search__field").attr("placeholder", I18N.get("IAM.SEARCH")+'...');//No I18N
						});
					    $('#gdpr_us_state select').on("select2:close", function (e) { 
							$(e.target).siblings(".select2").find(".select2-selection--single").focus();
						});
						
						if($('#country_field select[name=country]').length>0 && defaultCountry && $('#country_field select[name=country] option[value='+defaultCountry.toUpperCase()+']').length > 0){
							$('#country_field select[name=country]').val(defaultCountry.toUpperCase());
						}
						
						check_state();
						
						setSelect2WithFlag('#localeCn');
					}
					
					$("#signup_section #first_name").val('${Encoder.encodeJavaScript(first_name)}');
					$("#signup_section #last_name").val('${Encoder.encodeJavaScript(last_name)}');
				});
				
				function setPhotoSize(ele) {
					if($(ele).height()>$(ele).width()) {
						$("#dp_pic").css({"width":"auto","height":"100%"});
					}
					else if($(ele).height()<$(ele).width()) {
						$("#dp_pic").css({"width":"100%","height":"auto"});
					}
					else {
						$("#dp_pic").css({"width":"100%","height":"100%"});
					}
				}
				
				function handlelogo() {
					$(".sorg_Displaypicture").removeClass('sorg_Displaypicture').addClass('org_Displaypicture');
					$(".sorg_icon").removeClass('sorg_icon').addClass('org_icon');
					$("#dp_pic").remove();
					$(".org_icon").text("Z");
				}
				
				function handleProPicError(){
					$(".photo_permission_option,.select2-container--photo_permission_theme").hide();
				} 
				
		    </script>
		    
		    <@resource path="/v2/components/js/invitation.js" />
			<script type="text/javascript" src="${za.iam_contextpath}/encryption/script"></script>
			<@resource path="/v2/components/js/security.js" />

		</head>
		<body>
		  	<#assign tos_link><@i18n key="IAM.LINK.TOS" /></#assign> <#assign privacy_link><@i18n key="IAM.LINK.PRIVACY" /></#assign>
		  
		  	<div class="blur"></div>
			
			<#include "${location}/Unauth/invitation_errorToast.tpl">
			
			<div class="zohologo ${service_logo_name}"></div>
	
			<div class="result_popup hide" id="result_popup_accepted">
				<div class="success_pop_bg"></div>
				<div class="success_icon"></div>
				<div class="content_space">
					<div class="grn_text" id="result_content"><@i18n key="IAM.INVITATION.ACCEPTED.TITLE"/></div>
					<div class="defin_text"><@i18n key="IAM.${type}.INVITATION.ACCEPT.SUCCESS.MESSAGE"/></div>
				</div>
				<button class="button center_btn" ><@i18n key="IAM.REDIRECT.NOW"/></button>
			</div>
	
			<div class="result_popup hide" id="result_popup_rejected">
				<div class="reject_pop_bg"></div>
				<div class="reject_icon"><span class="inner_circle"></span></div>
				<div class="content_space">
					<div class="grn_text" id="result_content"><@i18n key="IAM.INVITATION.REJECTED.TITLE"/></div>
					<div class="defin_text"><@i18n key="IAM.${type}.INVITATION.REJECT.SUCCESS.MESSAGE"/> <span class="redirect_txt"><@i18n key="IAM.ORG.INVITATION.REDIRECT.MESSAGE"/></span> </div>
				</div>
				<button class="button center_btn" ><@i18n key="IAM.CONTINUE"/></button>
			</div>
			
			<div class="container org_inv_container">
			
	            <div class="invite_details">
	            	<#if servicename?? && servicename?has_content>
	            		<div class="invited_service_info">
	            			<div style="display:inline-block;">
	            				<div class="invited_service_logo product-icon-${servicename}">
	            					<span class="path1"></span>
	            					<span class="path2"></span>
	            					<span class="path3"></span>
	            					<span class="path4"></span>
	            					<span class="path5"></span>
	            					<span class="path6"></span>
	            					<span class="path7"></span>
	            					<span class="path8"></span>
	            					<span class="path9"></span>
	            					<span class="path10"></span>
	            				</div>
	            			</div>
	            			<div class="invited_service_name">${service_display_name}</div>
	            		</div>
	            	</#if>
	                <#if (Org_details.use_appservice_logo ? has_content)>
	                	<div class="sorg_Displaypicture">
	                		<div class="sorg_icon"><img onload="setPhotoSize(this)" id="dp_pic" draggable="false" onerror="handlelogo()" style="border-radius: 6%;"></div>
	                	</div>
	                <#else>
	                   	<div class="org_Displaypicture">	
	                		<div class="org_icon"></div>
	                   	</div>
	                </#if>
	                <div class="org_Name">${Org_details.name}</div>
	        		<#if ((inviter_name)?has_content)>
	                <div class="Invitedby_Name"><@i18n key="IAM.ORG.INVITED.BY.WITH.EMAIL" arg0="${inviter_name}" arg1="${contact_email}"/></div>
	       		 	</#if>	       		 	
	            </div>
				<div class="dashed_separator"></div>
	            <div class="content_box" id="basic_info_box">
	                <div class="content_box_header"><@i18n key="IAM.${type}.INVITATION.TITLE"/></div>
	                 <#if (idp_account?has_content	&& idp_account=="true")	&&	(signupRequired?has_content	&&	 signupRequired=="true")>
			          	<div class="content_box_discription"><@i18n key="IAM.${type2}.SUBTITLE.IDP_SIGNUP" arg0="${idp_provider}"/></div>
			         <#elseif  (idp_account?has_content	&& idp_account=="true")>
			        	<div class="content_box_discription"><@i18n key="IAM.${type2}.SUBTITLE.IDP_LINK" arg0="${idp_provider}" /></div>
			         <#elseif (signupRequired?has_content	&&	 signupRequired=="true")>
						<#if mobile_number?has_content>
							<div class="content_box_discription"><@i18n key="IAM.${type2}.MOBILE_SUBTITLE" arg0="${mobile_number}"/></div>
						<#else>
							<div class="content_box_discription"><@i18n key="IAM.${type2}.SUBTITLE" arg0="${emailId}"/></div>
						</#if>
					 <#elseif (user_loggedIn)?has_content && user_loggedIn=="true">
					 	<#if restricted_acess?has_content && restricted_acess=="true">
							<div class="content_box_discription"><@i18n key="IAM.${type2}.RESTRICTEDUSER.SIGNEDIN.SUBTITLE" arg0="${emailId}" arg1="${primary_org_name}" /></div>
						<#else>
							<div class="content_box_discription"><@i18n key="IAM.${type2}.SIGNEDIN.SUBTITLE" arg0="${service_display_name}" arg1="${Org_details.name}"/></div>
						</#if>
					 <#else>
						<div class="content_box_discription"><@i18n key="IAM.${type2}.SIGNIN.SUBTITLE" arg0="${service_display_name}" arg1="${Org_details.name}" arg2="${emailId}" /></div>
					 </#if>
					 
			<#if restricted_acess?has_content && restricted_acess=="true"	&&	 (user_loggedIn)?has_content && user_loggedIn=="true">
			
	  					<div class="restrictedInvite_warn_box">
	  					
	  						<div class="authorize_check restricted_invite_check">
								<input type="checkbox" onclick="err_remove()" onchange="check_restictuser_check()" class="trust_check" id="restrictorg_user" name="restrictorg_user"/> 
								<span class="auth_checkbox"> 
									<span class="checkbox_tick"></span>
								</span> 
								<label for="restrictorg_user"><@i18n key="IAM.ORG.INVITATION.EXTERNAL.USER.CHECK" /></label>
							</div>
	  					
	  					</div>
	  		</#if>
					
	                <div class="action_elements">
	                    
	        <#if (idp_account?has_content && idp_account=="true")	&&	(signupRequired?has_content	&&	 signupRequired=="true")>
	                  <#if idp_provider == "GOOGLE" >
						<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Google" /></span></button>
					  <#elseif idp_provider == "AZURE">
						<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Microsoft" /></span></button>					  
					  <#elseif idp_provider == "FACEBOOK">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Facebook" /></span></button>
					  <#elseif idp_provider == "TWITTER">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Twitter" /></span></button>
					  <#elseif idp_provider == "LINKEDIN">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Linkedin" /></span></button>
					  <#elseif idp_provider == "APPLE">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span></button>
					  <#elseif idp_provider == "YAHOO">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Yahoo" /></span></button>
					  <#elseif idp_provider == "SLACK">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Slack" /></span></button>
					  <#elseif idp_provider == "WECHAT">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="WeChat" /></span></button>
					  <#elseif idp_provider == "WEIBO">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Weibo" /></span></button>
					  <#elseif idp_provider == "QQ">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="QQ" /></span></button>
					  <#elseif idp_provider == "BAIDU">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Baidu" /></span></button>
					  <#elseif idp_provider == "DOUBAN">
					 	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Douban" /></span></button>
					  <#elseif idp_provider == "ADP">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0=" " /></span><span class="${idp_provider}_icon"></span></button>
					  <#elseif idp_provider == "INTUIT">
					  	<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0=" " /></span><span class="${idp_provider}_icon"></span></button>
					  <#elseif idp_provider == "FEISHU">
						<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Feishu" /></span></button>
					  <#elseif idp_provider == "GITHUB">
						<button class="blue_btn ${idp_provider}_btn idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><span class="${idp_provider}_icon"></span><span class="fed_text"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="Github" /></span></button>					  
					  <#else>
					  	<button class="blue_btn  idp_user" id="accept_btn" onclick="window.open('${idp_url}')"><@i18n key="IAM.ORGINVITATION.IDP.SIGNUP_ACCEPT" arg0="${idp_provider}" /></button>   
					  </#if> 
					<#elseif  (idp_account?has_content	&& idp_account=="true" && !(user_loggedIn)?has_content)>
						<button class="blue_btn existinguser_notsignedin" id="accept_btn" onclick="signin_acceptidp('${idp_url}')"><@i18n key="IAM.ORGINVITATION.SIGNIN.TO.ACCEPT" /></button>
					<#elseif (signupRequired?has_content	&&	 signupRequired=="true")>
						<button class="blue_btn newuser_normal" id="accept_btn" onclick="accept_org_invitation()"><@i18n key="IAM.ORGINVITATION.SIGNUP_ACCEPT" /></button>
					<#elseif (!(user_loggedIn)?has_content)>
						<button class="blue_btn existinguser_notsignedin" id="accept_btn" onclick="signin_redirect()"><@i18n key="IAM.ORGINVITATION.SIGNIN.TO.ACCEPT" /></button>
					<#else>
						<button class="blue_btn existinguser_signedin" id="accept_btn" onclick="accept_org_invitation()"><@i18n key="IAM.CONTACTS.ACCEPT" /></button>
					</#if>
					<#if (!disable_reject?has_content || !disable_reject)>
						<button class="grey_btn" onclick="reject_org_invitation()"><@i18n key="IAM.INVITE.REJECT" /></button>
					</#if>

	                </div>
	                
	                
	<#if restricted_acess?has_content	&&		restricted_acess=="true">
		
		<#if (user_loggedIn)?has_content && user_loggedIn=="true">
					<ul class="org_merge_note">
	  					<li><@i18n key="IAM.ORG.INVITATION.NOTE.EXTERNALUSER" arg0="${primary_org_name}"/></li>
	  				</ul>
	  	</#if>
	            
	<#elseif ((!is_network?has_content || !is_network) && (!is_serviceorg_invite?has_content || !is_serviceorg_invite))>

		            <ul class="org_merge_note">
	  					<li><@i18n key="IAM.ORG.INVITATION.AGREE.ADMIN.ACCESS.ACCOUNT_DETAILS" /></li>
	  					<li><@i18n key="IAM.ORG.INVITATION.AGREE.ADMIN.CHANGE.ACCOUNT_DETAILS" /></li>
	  				</ul>

	</#if>	

	            </div>	


	        <#if (!signupRequired?has_content	||	 signupRequired=="true")	&&	(!idp_account?has_content	||	 idp_account=="false") >
	            
	           	<div class="content_box hide" id="signup_section">
					<div class="content_box_header"><@i18n key="IAM.${type}.INVITATION.TITLE"/></div>
	                <div class="content_box_discription"><@i18n key="IAM.FEDERATED.SIGNUP.PAGE.EMAIL.DESC" arg0="${emailId}"/></div>
	                
	                <form name="signup_form" id="signup_form" class="signup_form" novalidate onsubmit="return false">
	                    <div class="text_box_aligner">
		                    <div class="textbox_div textbox_div_inline" id="first_name_field">
		                    	<input name="first_name" class="real_textbox" tabindex="1" id="first_name" autocomplete="off" onkeypress="err_remove()" required="" />
		                    	<label class="textbox_label" for="first_name"><@i18n key="IAM.FIRST.NAME" /></label>
		                    </div>
		                    
		                    <div class="textbox_div textbox_div_inline" id="last_name_field">
		                        <input name="last_name" class="real_textbox" id="last_name" tabindex="1" autocomplete="off" onkeypress="err_remove()" required=""/>
		                   		<label class="textbox_label" for="last_name"><@i18n key="IAM.LAST.NAME" /></label>
		                    </div>
	                    </div>
	                    <div class="textbox_div error_space_card" id="password_field">
	                        <input name="password" class="real_textbox" tabindex="1" id="signup_pass"s onkeyup="check_pp('${passwordPolicy.mixed_case?c}','${passwordPolicy.min_spl_chars}','${passwordPolicy.min_numeric_chars}','${passwordPolicy.min_length}')" onkeypress="err_remove()" autocomplete="off" required="" type="password" />
	                        <label class="textbox_label" for="password"><@i18n key="IAM.PASSWORD" /></label>
	                        <div class="textbox_icon icon-hide" onclick="show_hide_password()"></div>
	                    </div>
	                    <div class="text_box_aligner">
		                    <div class="textbox_div textbox_div_inline" id="country_field">
		                       <select class="profile_mode" autocomplete='country-name' name="country" id="localeCn" onchange="check_state()">
									<#list country_code_details as countrydata>
	                  					<option value="${countrydata.code}" data-subscriptionmode="${countrydata.newsletterSubscriptionMode}" id="${countrydata.code}" >${countrydata.display_name}</option>
									</#list>
								</select>
								<label class="textbox_label" for="country"><@i18n key="IAM.COUNTRY" /></label>
		                    </div>
		                    
		                    <div class="textbox_div textbox_div_inline hide" id="gdpr_us_state">
		                        <select class="profile_mode" autocomplete='state-name' name="state" id="locale_state">
	                  					<option value="" disabled selected><@i18n key="IAM.US.STATE.SELECT" /></option>
								</select>
								<label class="textbox_label" for="country"><@i18n key="IAM.GDPR.DPA.ADDRESS.STATE" /></label>
		                    </div>
	                    </div>
	                    <div class="authorize_check news_letter_chk">
							<input type="checkbox" onclick="err_remove()" class="trust_check" id="news_letter" name="news_letter"/>
							<span class="auth_checkbox">
								<span class="checkbox_tick"></span>
							</span> 
							<label for="news_letter"><@i18n key="IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1" arg0="${corp_link}"/></label>
						</div>

						<div class="authorize_check">
							<input type="checkbox" onclick="err_remove()" class="trust_check" id="tos_check" name="tos_check"/> 
							<span class="auth_checkbox"> 
								<span class="checkbox_tick"></span>
							</span> 
							<label for="tos_check"><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${tos_link}" arg1="${privacy_link}" /></label>
						</div>
						<div class="action_elements">                    
	                   		<button class="blue_btn" id="signup_action" onclick="accept_org_invitation()" ><@i18n key="IAM.ORGINVITATION.SIGNUP_ACCEPT" /></button>
	                    	<button class="grey_btn" onclick="back_toinfo()"><@i18n key="IAM.BACK" /></button>
	                	</div>	
	                </form>
	            </div>   


	        <#elseif (idp_account?has_content	||	 idp_account=="true") >
				
					<div class="content_box hide" id="signup_section">
					
						
					<div class="photo_permission_option">
						<div class="profile-img" id="profile-pic">
							<div class="pro_pic_blur"></div>
							<img class="display_pic" width="100%" height="100%" title="" alt="" onerror="handleProPicError()"/>
						</div>
						<select id="photo_permission" style="display: none">
							<option value="3" id="Zohousers" selected><@i18n key="IAM.PHOTO.PERMISSION.ZOHO_USERS" /> </option>
							<option value="2" id="Contacts"><@i18n key="IAM.PHOTO.PERMISSION.CHAT_CONTACTS" />  </option>
							<option value="1" id="Orgusers"><@i18n key="IAM.PHOTO.PERMISSION.ORG_USERS" /></option>
							<option value="4" id="Everyone"><@i18n key="IAM.PHOTO.PERMISSION.EVERYONE" />  </option>
							<option value="0" id="Myself"><@i18n key="IAM.PHOTO.PERMISSION.ONLY_MYSELF" />  </option>
						</select>
					</div>
					
				
	                <div id="idp_heading" class="content_box_header"></div>
	                <div class="content_box_discription"><@i18n key="IAM.${type2}.IDP.SUBTITLE" /></div>
	                
	                <form name="signup_form" id="signup_form" class="signup_form" novalidate onsubmit="return false">
                    	<div class="text_box_aligner">
	                    <div class="textbox_div textbox_div_inline" id="first_name_field">
	                    	<input name="first_name" class="real_textbox" onkeyup="updateHeading();" tabindex="1" id="first_name" autocomplete="off" onkeypress="err_remove()" required=""/>
	                    	<label class="textbox_label" for="first_name"><@i18n key="IAM.FIRST.NAME" /></label>
	                    </div>
	                    
	                    <div class="textbox_div textbox_div_inline" id="last_name_field">
	                        <input name="last_name" class="real_textbox" id="last_name" tabindex="1" autocomplete="off" onkeyup="updateHeading();" onkeypress="err_remove()" required=""/>
	                        <label class="textbox_label" for="last_name"><@i18n key="IAM.LAST.NAME" /></label>
	                    </div>
	                    </div>
	                    <div class="text_box_aligner">
	                    <div class="textbox_div textbox_div_inline" id="country_field">
	                       <select class="profile_mode" autocomplete='country-name' name="country" id="localeCn" onchange="check_state()">
								<#list country_code_details as countrydata>
                  					<option value="${countrydata.code}" data-subscriptionmode="${countrydata.newsletterSubscriptionMode}" id="${countrydata.code}" >${countrydata.display_name}</option>
								</#list>
							</select>
							<label class="textbox_label" for="country"><@i18n key="IAM.COUNTRY" /></label>
	                    </div>
                    
	                    <div class="textbox_div textbox_div_inline hide" id="gdpr_us_state">
	                        <select class="profile_mode" autocomplete='state-name' name="state" id="locale_state">
                  					<option value="" disabled selected><@i18n key="IAM.US.STATE.SELECT" /></option>
							</select>
							<label class="textbox_label" for="country"><@i18n key="IAM.COUNTRY" /></label>
	                    </div>
	                    </div>
	                    
	                     <div class="authorize_check">
							<input type="checkbox" onclick="err_remove()" class="trust_check" id="news_letter" name="news_letter"/>
							<span class="auth_checkbox">
								<span class="checkbox_tick"></span>
							</span> 
							<label for="news_letter"><@i18n key="IAM.TPL.ZOHO.NEWSLETTER.SUBSCRIBE1" arg0="${corp_link}"/></label>
						</div>

						<div class="authorize_check">
							<input type="checkbox" onclick="err_remove()" class="trust_check" id="tos_check" name="tos_check"/> 
							<span class="auth_checkbox"> 
								<span class="checkbox_tick"></span>
							</span> 
							<label for="tos_check"><@i18n key="IAM.SIGNUP.AGREE.TERMS.OF.SERVICE" arg0="${tos_link}" arg1="${privacy_link}" /></label>
						</div>
						
						<div class="action_elements">                    
	                    <button class="blue_btn" onclick="idp_continue()" ><@i18n key="IAM.ORGINVITATION.SIGNUP_ACCEPT" /> </button>
	                    <#if (!disable_reject?has_content || !disable_reject)>
                            <button class="grey_btn" onclick="reject_org_invitation()"><@i18n key="IAM.INVITE.REJECT" /></button>
						</#if>

	                </div>
							
                	</form>
                
	                
	            </div>
				
			</#if>
</#if>	    
	</div>
	<#if (contact_email)?has_content && (!(multi_dc_invite)?has_content) >

		<#if (is_contact_mobile) >
			<div class="issues_contact"><@i18n key="IAM.ORG.ISSUES.MOBILE.CONTACT" arg0="${contact_email}"/></div>
		<#else>
			<div class="issues_contact"><@i18n key="IAM.ORG.ISSUES.CONATCT" arg0="${contact_email}"/></div>
		</#if>
	
	</#if>	
	            
		</body>
	</html>