<#if ((fromSSOKit)?has_content)>
<html>
<head>
	<title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<script>
			var fromSSOKit = true;
			var ZUID = "${zuid}";
			var request_id = undefined;
			var isMobile = Boolean("<#if isMobile>true</#if>");
			<#if ((request_id)?has_content)>
			request_id = "${request_id}";
			var cur_step = '${step}';
			var sso_redirect_url = '${redirect_url}';
			</#if>;
			
	</script>
	<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<link href="${SCL.getStaticFilePath("/v2/components/css/zohoPuvi.css")}" rel="stylesheet"type="text/css">
	<link href="${SCL.getStaticFilePath("/v2/components/css/product-icon.css")}" rel="stylesheet"type="text/css">
	<link href="${SCL.getStaticFilePath("/v2/components/css/closeaccount.css")}" rel="stylesheet"type="text/css">
	<script src="${SCL.getStaticFilePath("/v2/components/js/close-account.js")}" type="text/javascript"></script>
	<script src="${SCL.getStaticFilePath("/v2/components/tp_pkg/jquery-3.6.0.min.js")}"></script>
	<script src="${SCL.getStaticFilePath("/v2/components/js/uvselect.js")}"></script>
	<link href="${SCL.getStaticFilePath("/v2/components/css/uvselect.css")}" rel="stylesheet"type="text/css">
	<script src="${SCL.getStaticFilePath("/v2/components/js/zresource.js")}" type="text/javascript"></script>  
	<script src="${SCL.getStaticFilePath("/v2/components/js/uri.js")}" type="text/javascript"></script>
	<script>
		var isPersonalUser = Boolean("<#if isPersonalUser>true</#if>");
		var Account = ZResource.extendClass({
			  resourceName: "Account",//No I18N
			  identifier: "zaid"	//No I18N  
		});
		var User  = ZResource.extendClass({
			  resourceName: "User",//No I18N
			  identifier: "zuid",	//No I18N 
			  attrs : [ "first_name","last_name","display_name","gender","country","language","timezone","state" ], // No i18N
			  parent : Account
		});
		var NewCloseAccountsObj =  ZResource.extendClass({ 
			  resourceName: "CloseAccount",//No I18N
			  identifier:"zuid",			//No I18N
			  attrs : [ "zuidToClose","includeCloseAcc","reason","comments"],// No i18N
			  parent : User
		});
		var color_classes = ["dp_green", "dp_green_lt", "dp_red", "dp_blue", "dp_blue_lt","dp_yellow","dp_violet","dp_pink","dp_orange_lt","dp_orange"];    //No I18N
		var pre_random = undefined;
		function gen_random_value(){
			do{
				var random_num_val = Math.floor(Math.random() * (10));
			}
			while(random_num_val==pre_random)
			pre_random=random_num_val;
			
			return random_num_val;
		}
		function de(ele){
    		return document.getElementById(ele);
		} 
		function openInNewTab(url) 
		{
		  var win = window.open(url, '_blank');
		  win.focus();
		}
		function escapeHTML(value) 
		{
			if(value) {
				value = value.split("<").join("&lt;");
				value = value.split(">").join("&gt;");
				value = value.split("\"").join("&quot;");	//No I18N
				value = value.split("'").join("&#x27;");
				value = value.split("/").join("&#x2F;");
		    }
		    return value;
		}
		function formatMessage() {
		    var msg = arguments[0];
		    if(msg != undefined) {
			for(var i = 1; i < arguments.length; i++) {
			    msg = msg.replace('{' + (i-1) + '}', escapeHTML(arguments[i].toString()));
			}
		    }
		    return msg;
		}
		function getCookie(cookieName) {
			var nameEQ = cookieName + "=";
			var ca = document.cookie.split(';');
			for (var i = 0; i < ca.length; i++) {
				var c = ca[i].trim();
				if (c.indexOf(nameEQ) == 0) {
					return c.substring(nameEQ.length, c.length)
				}
				;
			}
			return null;
		}
		window.onload=function(){
			$(".org_close_aligner").show();
			setVaribaleValue();
			try 
			{
    			URI.options.contextpath="${za.contextpath}/webclient/v1"//No I18N
    			URI.options.csrfParam = '${za.csrf_paramName}'; 
    			URI.options.csrfValue = getCookie('${za.csrf_cookieName}'); 
			}catch(e){}
			$(".org_close_view .start_process").show();
			<#if ((partner_name)?has_content) || ((has_orgcontact)?has_content) || ((request_id)?has_content)>
				$("#show_close_block").show();
				$(".org_close_view .content_block").hide();
				<#if ((request_id)?has_content)>
				$("#initiated_warning #continueClsProcess").attr("onclick","moveToNextOption('"+request_id+"','"+cur_step+"')");
					<#if isPersonalUser>
					$("#initiated_warning #cancelClsProcess").attr("onclick","showCancelConfirm('<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE" />','<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION.FOR.ACCOUNT" />','"+request_id+"')");
					<#else>
					$("#initiated_warning #cancelClsProcess").attr("onclick","showCancelConfirm('<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE" />','<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION" />','"+request_id+"')");
					</#if>
				</#if>
				<#if ((has_orgcontact)?has_content) && ((owner_name)?has_content)>
					$("#show_close_block .close_info_text a").removeAttr('href').css("font-weight","500");
				</#if>
			<#else>
				<#if isPersonalUser>
					$(".org_close_view .start_process").hide();
					$(".org_close_view .content_block").show();
					initiateFromSSOKit();
				</#if>
			</#if>
		};
	</script>
	<style>
	.org_close_aligner
	{
	    max-width: 1280px;
	    margin: auto;
	    margin-top: 0px;
	    max-height:unset;
	} 
	.org_close_view .top_header
	{
	    margin-bottom: 0px;
	    display: block;
	    width: 100%;
	    box-sizing: border-box;
	    padding: 24px 30px;
	    border-bottom: 2px solid #F5F5F5;
	    background-color: #FBFBFB;
	    border-radius: 5px 5px 0px 0px;
	    font-size: 20px;
	    line-height: 24px;
	    font-weight: 500;
	}
	</style>
</header>
<body>
		<div class="error_msg " id="new_notification" onclick="Hide_Main_Notification()">
			<div style="display:table;width: 100%;">
				<div class="err_icon_aligner">
					<div class="error_msg_cross">
					</div>
				</div>
				<div class="error_msg_text"> 
					<span id="succ_or_err"></span>
					<span id="succ_or_err_msg">&nbsp;</span>
				</div>
			</div>
		</div>
		<div class="blur"></div>
		<div class=" hide popup confirmpopup" tabindex="1" id="confirm_popup">
			<div class="popup_header confirm_pop_header"></div>
			<div class="popup_padding">
			<div class="confirm_text"></div>
			<div id="confirm_btns">
				<button tabindex="1" class="primary_btn_check  " id="return_true"><span><@i18n key="IAM.CONFIRM"/></span></button>
				<button tabindex="1" class="primary_btn_check  cancel_btn" id="return_false"><span><@i18n key="IAM.CANCEL"/></span></button>
			</div>
			</div>
		</div>
</#if>
 <script type="text/javascript">
	 var isPersonalUser = Boolean("<#if isPersonalUser>true</#if>");
	 var i18nkeys = {
	 			"IAM.APPID" : '<@i18n key="IAM.APPID" />',
	 			"IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE" : '<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE" />',
	 			"IAM.ERROR.GENERAL": '<@i18n key="IAM.ERROR.GENERAL" />',
	    		"IAM.DOMAIN.VERIFIED" : '<@i18n key="IAM.DOMAIN.VERIFIED" />',
				"IAM.DOMAIN.UNVERIFIED" : '<@i18n key="IAM.DOMAIN.UNVERIFIED" />',
				"IAM.CLOSE.ACCOUNT.USED.SERVICE.COUNT" : '<@i18n key="IAM.CLOSE.ACCOUNT.USED.SERVICE.COUNT" />',
				"IAM.CLOSE.ACCOUNT.CLOSE.PORTAL" : '<@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.PORTAL" />',
				"IAM.CLOSE.ACCOUNT.CLOSE.PORTAL.BE.DELETED" : '<@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.PORTAL.BE.DELETED" />',
				"IAM.CLOSE.ACCOUNT.GO.TO.MAIL" : '<@i18n key="IAM.CLOSE.ACCOUNT.GO.TO.MAIL" />',
				"IAM.CLOSE.ACCOUNT.DOMAIN.HOSTED.WITH.MAIL" : '<@i18n key="IAM.CLOSE.ACCOUNT.DOMAIN.HOSTED.WITH.MAIL" />',
				"IAM.CLOSE.ACCOUNT.REASON.OPTION.ERROR" : '<@i18n key="IAM.CLOSE.ACCOUNT.REASON.OPTION.ERROR" />',
				"IAM.CLOSE.ACCOUNT.FEEDBACK.ERROR" : '<@i18n key="IAM.CLOSE.ACCOUNT.FEEDBACK.ERROR" />',
				"IAM.CLOSE.ACCOUNT.DATA.DELETE.ACCOUNT.CONCERN" : '<@i18n key="IAM.CLOSE.ACCOUNT.DATA.DELETE.ACCOUNT.CONCERN" />',
				"IAM.CLOSE.ACCOUNT.APP.SPECIFIC.ORG" : '<@i18n key="IAM.CLOSE.ACCOUNT.APP.SPECIFIC.ORG" />',
				"IAM.CLOSE.ACCOUNT.DATA.DELETE.CONCERN" : '<@i18n key="IAM.CLOSE.ACCOUNT.DATA.DELETE.CONCERN" />',
				"IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION" : '<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION" />',
				"IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION.FOR.ACCOUNT" : '<@i18n key="IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION.FOR.ACCOUNT" />'
	 };
	 function changeCloseAccNote(){
	 	$(".initate_btn").removeAttr("disabled");
	 	$(".redtext_for_close_acc").show();
		if($(".checkbox_area [name='delete_type']:checked").val() == "close_acc_with_org"){
			$(".note_for_close_org_and_acc,.close_service_form .cancel_org_with_account").show();$(".note_for_close_org,.close_service_form .cancel_org").hide();
		}
		else{
			$(".note_for_close_org_and_acc,.close_service_form .cancel_org_with_account").hide();$(".note_for_close_org,.close_service_form .cancel_org").show();
		}
	 }
 </script>
<div class="org_close_aligner hide">
	<div class="org_close_view box">
		<div class="top_header box_info box_head">
			<#if ((fromSSOKit)?has_content)><span id="go_to_back" class="go_to_back icon-arrow_back hide"></span></#if>
		<#if isPersonalUser>
			<@i18n key="IAM.CLOSE.ACCOUNT" />
		<#else>
			<@i18n key="IAM.CANCEL.ORG" />
		</#if>
		
			<div class="refresh_option"><span class="icon-RotateRight"></span><span class="header_refresh_text"><@i18n key="IAM.REFRESH"/></span></div>
		</div>
		<div class="box_content_div hide" id="show_close_block">
			<#if ((request_id)?has_content)>
				<div id="initiated_warning">
					<div class="no_data no_data_closeACC"></div>
					<div class="close_info_text"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS.DESC.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS.DESC"/></#if></div>
					<div id="flow_cnt_btns" style="">
						<button id="continueClsProcess" onclick="" class="primary_btn_check red_btn"><span><@i18n key="IAM.CLOSE.ACCOUNT.RESUME.PROCESS"/></span></button>
						<button id="cancelClsProcess" class="primary_btn_check cancel_btn" ><span><@i18n key="IAM.CANCEL"/></span></button>
					</div>
				</div>
			<#elseif ((partner_name)?has_content)>
				<div class="no_data no_data_closeACC"></div>
				<div class="close_info_text"><@i18n key="IAM.CLOSEACCOUNT.MESSAGE.FOR.PARTNERADMIN" arg0="${partner_name}" arg1="${support_email}" arg2="${support_email}"/></div>
				<button id="sendPartnerEmail" onclick="window.location.href = 'mailto:${support_email}'" class="primary_btn_check center_btn"><span><@i18n key="IAM.EMAIL.CONFIRMATION.SEND.EMAIL" /></span></button>
			<#elseif ((has_orgcontact)?has_content)>
				<div class="no_data no_data_closeACC"></div>
				<#if ((business_url)?has_content)>
					<#if ((org_name)?has_content)>
					<div class="close_info_text"><@i18n key="IAM.CLOSEACCOUNT.MSG.ORGOWNER" arg0="${org_name}" arg1="${support_email}" arg2="${support_email}"/></div>
					<#else>
					<div class="close_info_text"><@i18n key="IAM.CLOSEACCOUNT.MSG.ORGOWNER.BLANK_ORGNAME" arg0="${support_email}" arg1="${support_email}"/></div>
					</#if>
					<button id="sendOrgEmail" onclick="openInNewTab('${business_url}')" class="primary_btn_check center_btn"><span><@i18n key="IAM.CANCEL.ORG" /></span></button>
				<#else>
					<#assign org_contact = ((owner_email)?has_content)?then(owner_email,owner_name) >
					<#if ((org_name)?has_content)>
					<div class="close_info_text"><@i18n key="IAM.CLOSE.CONTACT.ADMIN.TEXT" arg0="${org_name}" arg1="${org_contact}" arg2="${org_contact}"/></div>
					<#else>
					<div class="close_info_text"><@i18n key="IAM.CLOSE.CONTACT.ADMIN.TEXT.BLANK_ORGNAME" arg0="${org_contact}" arg1="${org_contact}"/></div>
					</#if>
				</#if>
			</#if>
		</div>
		<div class="content_block">
			<#if ((fromSSOKit)?has_content)>
			<div class="start_process hide">
				<div class="desc_tip"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.TEXT.ABOUT.PROCEED.PERSONAL.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.TEXT.ABOUT.PROCEED"/></#if><div style="margin-top:10px;"><@i18n key="IAM.CLOSEACCOUNT.INSTRUCTION.WITH.HELP.DOC" arg0="${closeaccount_help_doc}"/></div></div>				
				<div class="close_acc_steps">
					<span class="icon_box icon-Review-your-service"></span>
					<span class="desc_box">
						<div class="bold_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.USEDAPPS"/></div>
						<div class="desc_about_step"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.USEDAPPS.PERSONAL.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.USEDAPPS"/></#if></div>
					</span>
				</div>
				<div class="close_acc_steps">
					<span class="icon_box icon-unsubscribe-service"></span>
					<span class="desc_box">
						<div class="bold_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.SUBSCRIPTIONS"/></div>
						<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.SUBSCRIPTIONS"/></div>
					</span>
				</div>
				<#if !isPersonalUser>
				<div class="close_acc_steps">
					<span class="icon_box icon-domain"></span>
					<span class="desc_box">
						<div class="bold_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.DOMAINS"/></div>
						<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.DOMAINS"/></div>
					</span>
				</div>
				</#if>
				<div class="close_acc_steps">
					<span class="icon_box icon-Role-change"></span>
					<span class="desc_box">
						<div class="bold_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.PORTALS"/></div>
						<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.PORTALS"/></div>
					</span>
				</div>
				<div class="close_acc_steps">
					<span class="icon_box icon-morg"></span>
					<span class="desc_box">
						<div class="bold_title"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT" /><#else><@i18n key="IAM.CANCEL.ORG" /></#if></div>
						<div class="desc_about_step"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.CLOSE.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.CLOSE.ORG"/></#if></div>
					</span>
				</div>
				<div class="bot_description"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.ABOUT.ACCOUNT.DELETE"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.ABOUT.ORG.DELETE"/></#if></div>
				<#if !isPersonalUser>
				<div class="close_acc_type">
					<div class="header_14"><@i18n key="IAM.CLOSE.ACCOUNT.SELECT.OPTION"/></div>
					<div class="checkbox_area" style="flex-direction: column;">
						<div class="check_set">
							<input class="hide" type="radio" id="org_only" name="delete_type" onclick="changeCloseAccNote()" value="close_org">
							<label for="org_only">
								<div class="checkbox_ui_comp">
									<span class="outer_circle"><span class="inner_circle"></span></span>
								</div>
								<div class="text_block">
									<div class="checkbx_title"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ONLY.ORG"/></div>
									<div class="desc_for_checkbox"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ONLY.ORG.DESC"/></div>
								</div>
							</label>
						</div>
						<div class="check_set" style="margin-top:10px">
							<input class="hide" type="radio" id="account_with_org" name="delete_type" onclick="changeCloseAccNote()" value="close_acc_with_org">
							<label for="account_with_org">
								<div class="checkbox_ui_comp">
									<span class="outer_circle"><span class="inner_circle"></span></span>
								</div>
								<div class="text_block">
									<div class="checkbx_title"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ACCOUNT.AND.ORG"/></div>
									<div class="desc_for_checkbox"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ACCOUNT.AND.ORG.DESC"/></div>
								</div>
							</label>
						</div>
					</div>
				</div>
				<div class="red_text redtext_for_close_acc hide">
					<span style="display:inline-block;margin-right:5px;" class="icon-info"></span>
					<span class="note_for_close_org hide"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.ONLY.ORG"/></span>
					<span class="note_for_close_org_and_acc hide"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.ACCOUNT.AND.ORG"/></span>
				</div>
				</#if>
				<button class="primary_btn_check initate_btn" <#if !isPersonalUser>disabled</#if> onclick="initiateCloseAccount()"><@i18n key="IAM.PROCEED"/></button>
				<#if (!(fromSSOKit)?has_content)>
				<button class="primary_btn_check cancel_btn" onclick="cancelInitiateOption()"><@i18n key="IAM.CANCEL"/></button>
				</#if>
			</div>
			<#else>
			<div class="start_process_for_web">
				<div class="desc_tip"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.TEXT.ABOUT.PROCEED.PERSONAL.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.TEXT.ABOUT.PROCEED"/></#if><div style="margin-top:10px;"><@i18n key="IAM.CLOSEACCOUNT.INSTRUCTION.WITH.HELP.DOC" arg0="${closeaccount_help_doc_new_flow}"/></div></div>				
				<div class="steps_block">
					<div class="steps_block_sep">
						<div class="steps close_acc_steps desc_abt_used_apps">
							<span class="icon_box">1</span>
							<span class="icon_box_line"></span>
							<span class="desc_box">
								<div class="bold_title close_account_steps_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.USEDAPPS"/></div>
								<div class="desc_about_step"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.USEDAPPS.PERSONAL.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.USEDAPPS"/></#if></div>
							</span>
						</div>
						<div class="steps close_acc_steps desc_abt_subscription">
							<span class="icon_box">2</span>
							<span class="icon_box_line"></span>
							<span class="desc_box">
								<div class="bold_title close_account_steps_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.SUBSCRIPTIONS"/></div>
								<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.SUBSCRIPTIONS"/></div>
							</span>
						</div>
						<div class="steps close_acc_steps desc_abt_domains blur_from_bottom">
							<span class="icon_box">3</span>
							<span class="icon_box_line "></span>
							<span class="desc_box">
								<div class="bold_title close_account_steps_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.DOMAINS"/></div>
								<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.DOMAINS"/></div>
							</span>
						</div>
					</div>
					<div class="steps_block_sep" style="margin-left:70px">
						<div class="steps close_acc_steps desc_abt_app_orgs">
							<span class="icon_box">4</span>
							<span class="icon_box_line"></span>
							<span class="desc_box">
								<div class="bold_title close_account_steps_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.PORTALS"/></div>
								<div class="desc_about_step"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.PORTALS"/></div>
							</span>
						</div>
						<div class="steps close_acc_steps desc_abt_close_org">
							<span class="icon_box">5</span>
							<span class="desc_box">
								<div class="bold_title close_account_steps_title"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT" /><#else><@i18n key="IAM.CANCEL.ORG" /></#if></div>
								<div class="desc_about_step"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.CLOSE.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.DESC.CLOSE.ORG"/></#if></div>
							</span>
						</div>
					</div>
				</div>
				<#if !isPersonalUser>
				<div class="close_acc_type">
					<div class="header_14"><@i18n key="IAM.CLOSE.ACCOUNT.SELECT.OPTION"/></div>
					<div class="checkbox_area">
						<div class="check_set">
							<input class="hide" type="radio" id="org_only" name="delete_type" onclick="changeCloseAccNote()" value="close_org">
							<label for="org_only">
								<div class="checkbox_ui_comp">
									<span class="outer_circle"><span class="inner_circle"></span></span>
								</div>
								<div class="text_block">
									<div class="checkbx_title"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ONLY.ORG"/></div>
									<div class="desc_for_checkbox"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ONLY.ORG.DESC"/></div>
								</div>
							</label>
						</div>
						<div class="check_set" style="margin-left:10px;">
							<input class="hide" type="radio" id="account_with_org" name="delete_type" onclick="changeCloseAccNote()" value="close_acc_with_org">
							<label for="account_with_org">
								<div class="checkbox_ui_comp">
									<span class="outer_circle"><span class="inner_circle"></span></span>
								</div>
								<div class="text_block">
									<div class="checkbx_title"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ACCOUNT.AND.ORG"/></div>
									<div class="desc_for_checkbox"><@i18n key="IAM.CLOSE.ACCOUNT.CHOOSE.ACCOUNT.AND.ORG.DESC"/></div>
								</div>
							</label>
						</div>
					</div>
				</div>
				</#if>
				<div class="red_text redtext_for_close_acc hide">
					<span style="display:inline-block;margin-right:5px;" class="icon-info"></span>
					<span class="note_for_close_org hide"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.ONLY.ORG"/></span>
					<span class="note_for_close_org_and_acc hide"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.ACCOUNT.AND.ORG"/></span>
				</div>
				<button class="initate_btn primary_btn_check" <#if !isPersonalUser>disabled</#if> onclick="initiateCloseAccount()"><@i18n key="IAM.PROCEED"/></button>
				<button class="primary_btn_check cancel_btn" onclick="cancelInitiateOption()"><@i18n key="IAM.CANCEL"/></button>
			</div>
			</#if>
			
			<div class="processing_block hide">
				<div class="left_block status_viewer">
					<div class="status_info">
						<div class="status_tab services" id="used_serice">
							<input class="tab_value" id="services" type="hidden" value="0">
							<span class="outer_circle"><span class="line_from_circle"></span></span>
							<span class="tab_text"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.USEDAPPS"/></span>
						</div>
						<div class="status_tab subscriptions" id="unsubscribe">
							<input class="tab_value" id="subscriptions" type="hidden" value="1">
							<span class="outer_circle"><span class="line_from_circle"></span></span>
							<span class="tab_text"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.SUBSCRIPTIONS"/></span>
						</div>
						<div class="status_tab domains" id="delete_domain">
							<input class="tab_value" id="domains" type="hidden" value="2">
							<span class="outer_circle"><span class="line_from_circle"></span></span>
							<span class="tab_text"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.DOMAINS"/></span>
						</div>
						<div class="status_tab accounts_to_be_closed" id="close_portal">
							<input class="tab_value" id="accounts_to_be_closed" type="hidden" value="3">
							<span class="outer_circle"><span class="line_from_circle"></span></span>
							<span class="tab_text"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.PORTALS"/></span>
						</div>
						<div class="status_tab confirm_close_account" id="delete_org">
							<input class="tab_value" id="confirm_close_account" type="hidden" value="4">
							<span class="outer_circle"></span>
							<span class="tab_text" id="delete_org"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT" /><#else><@i18n key="IAM.CANCEL.ORG" /></#if></span>
						</div>
					</div>
				</div>
				<div class="right_block">
					<div class="mobile_status_bar"><div class="mobile_status_indicator"></div></div>
					<div class="right_block_header">
						<div class="used_serice_header_details">
							<div class="right_block_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.USEDAPPS"/></div>
							<div class="right_block_desc"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.USEDAPPS.ACCOUNT"/><#else><@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.USEDAPPS"/></#if></div>
						</div>
						<div class="unsubscribe_header_details head_with_btn">
							<div class="header_content_wrap">
								<div class="right_block_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.SUBSCRIPTIONS"/></div>
								<div class="right_block_desc">
									<#if isPersonalUser>
									<@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.SUBSCRIPTIONS.ACCOUNT"/>
									<#else>
									<@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.SUBSCRIPTIONS"/>
									</#if>
								</div>
							</div>
							<div class="header_btn">
								<button class="primary_btn_check"  id="un_subscrib" onclick="go_to_store()"><@i18n key="IAM.CLOSE.ACCOUNT.GOTO.STORE"/></button>
							</div>
						</div>
						<div class="close_portal_header_details">
							<div class="right_block_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.PORTALS"/></div>
							<div class="right_block_desc"><@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.PORTALS"/></div>
						</div>
						<div class="delete_domain_header_details">
							<div class="right_block_title"><@i18n key="IAM.CLOSE.ACCOUNT.INITIATE.FLOW.HEADER.DOMAINS"/></div>
							<div class="right_block_desc"><@i18n key="IAM.CLOSE.ACCOUNT.RIGHT.BLOCK.HEADER.DOMAINS"/></div>
						</div>
					</div>
					<div class="content_about_close_org">
					
					</div>
					<div class="hide" id="final_step_to_close">
						<div class="center_aligner">
							<div class="header_for_acc_dlt" id="close_org"><#if isPersonalUser><#if (!(fromSSOKit)?has_content)><span id="go_to_back" class="go_to_back icon-arrow_back"></span></#if><@i18n key="IAM.CLOSE.ACCOUNT" /><#else><#if (!(fromSSOKit)?has_content)><span id="go_to_back" class="go_to_back icon-arrow_back"></span></#if><@i18n key="IAM.CANCEL.ORG" /></#if></div>
							<form class="close_service_form" onsubmit="return false;">
							<div class="textbox_div field">
		                  		<label class="textbox_label"><@i18n key="IAM.CLOSE.CLOSING_REASON" /></label>
									<select class="select_field" onchange="remove_error(this)" data-validate="zform_field" name="reason" id="delete_acc_reason" >
											<option disabled selected><@i18n key="IAM.CLOSE.ACCOUNT.FORM.SELECT.REASON" /></option>
											<option value="1"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.SUBSCRIPTION.TOO.EXPENSIVE" /></option>
											<option value="2"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.FEATURE.NOT.AVAILABLE" /></option>
											<option value="3"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.COMPLICATED" /></option>
											<option value="4"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.SUPPORT.NOT.SUFFICIENT" /></option>
											<option value="5"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.NEW.ACCOUNT" /></option>
											<option value="6"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.JOIN.COMPANY.ORG" /></option>
											<option value="7"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.WRONG.DC" /></option>
											<option value="8"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.CREATED.BY.MISTAKE" /></option>
											<option value="9"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.TESTING.OUR.APPS" /></option>
											<option value="10"><@i18n key="IAM.CLOSEACCOUNT.USER.REASON.OTHER.REASON" /></option>
									</select>
								</div>
								
								<div class="textbox_div " >
			                  		<label class="textbox_label"><@i18n key="IAM.CLOSE.ACCOUNT.FEEDBACK" /></label>
									<textarea class="deleteacc_cmnd" onkeypress="remove_error(this)" tabindex="0" data-limit="250" data-validate="zform_field" name="comments" placeholder="<@i18n key="IAM.CLOSE.ACCOUNT.FORM.ENTER.FEEDBACK" />"></textarea>
								</div>
								<#if isPersonalUser>
								<div class="red_text desc_for_close_acc" style="font-size:14px;max-width:610px">
									<span style="display:inline-block;margin-right:5px;" class="icon-info"></span>
									<span class="note_for_close_org"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.ACCOUNT" arg0="${gdpr_privacy_link}"/></span>
								</div>
								<#else>
								<div class="red_text desc_for_close_acc" style="font-size:14px;max-width:610px">
									<span style="display:inline-block;margin-right:5px;" class="icon-info"></span>
									<span class="note_for_close_org"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.DELETE.ORG" arg0="${gdpr_privacy_link}"/></span>
									<span class="note_for_close_org_and_acc hide"><@i18n key="IAM.CLOSE.ACCOUNT.NOTE.DELETE.APP.WITH.ORG" arg0="${gdpr_privacy_link}"/></span>
								</div>
								</#if>
								<div class="cls_acc_checkbox_div" id="confirmation_for_action" style="">
 									<input id="confirm_account_del" name="" class="checkbox_check" onchange="$(this).parent().siblings('.field_error').remove()" type="checkbox" />
 									<span class="checkbox">
 										<span class="checkbox_tick"></span>
 									</span>
 									<label for="confirm_account_del" class="checkbox_label"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.ACCOUNT.CHECKBOX" /><#else><span class="cancel_org_with_account"><@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.ORG.AND.ACCOUNT.CHECKBOX" /></span><span class="cancel_org"><@i18n key="IAM.CLOSE.ACCOUNT.CLOSE.ORG.CHECKBOX" /></span></#if></label>
 								</div>
								<button id="initiate_cls_button" class="primary_btn_check red_btn" onclick="initiateFinalStep()"><#if isPersonalUser><@i18n key="IAM.CLOSE.ACCOUNT" /><#else><span class="cancel_org"><@i18n key="IAM.CANCEL.ORG" /></span><span class="cancel_org_with_account"><@i18n key="IAM.CLOSE.ACCOUNT.FINAL.STEP.BUTTON.CLOSE.TEXT" /></span></#if></button>
								<button id="cancelCloseProcess" class="primary_btn_check high_cancel" onclick=""><@i18n key="IAM.CANCEL"/></button>
								
							</form>
						</div>
					</div>
				</div>
				<div id="close_acc_right_slider" class="close_acc_right_slider"></div>
				<div class="button_container">
					<div class="close_acc_actions_desc">
						<#if (!(fromSSOKit)?has_content)>
						<span class="hide used_apps_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.USED.APPS"/></span>
						<span class="hide subscription_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.SUBSCRIPTION.INITIAL"/></span>
						<span class="hide subscription_succ_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.SUBSCRIPTION.SUCCESS"/></span>
						<span class="hide subscription_succ_single_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.SUBSCRIPTION.SUCCESS.SIGNLE.APP"/></span>
						<span class="hide domain_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.DOMAIN.INITIAL"/></span>
						<span class="hide domain_text_empty"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.DOMAIN.EMPTY"/></span>
						<span class="hide domain_not_enabled_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.DOMAIN.HOST.NOT.ENABLED"/></span>
						<span class="hide domain_not_enabled_single_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.DOMAIN.HOST.NOT.ENABLED.SINGLE.DOMAIN"/></span>
						<span class="hide app_portal_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.APP.PORTAL.INITIAL"/></span>
						<span class="hide app_portal_succ_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.APP.PORTAL.SUCCESS"/></span>
						<span class="hide app_portal_succ_single_text"><@i18n key="IAM.CLOSE.ACCOUNT.BOTTOM.TEXT.FOR.APP.PORTAL.SUCCESS.SINGLE"/></span>
						</#if>
					</div>
					<div style="display: flex;flex-wrap: nowrap;">
						<button class="primary_btn_check high_cancel" id="prev_step" onclick=""><@i18n key="IAM.BACK"/></button>
						<button class="primary_btn_check"  id="next_step" onclick=""><@i18n key="IAM.NEXT"/></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<#if ((fromSSOKit)?has_content)>
</body>
<script>
var setTime="";
function popupBlurHide(ele,callback,preventBlur){
	$(ele).removeClass("pop_anim");
	$(ele).fadeOut(200,function(){
		if(preventBlur == undefined){
			$('body').css({
			    overflow: 'auto'//No i18N
			});
			$(".blur").css("z-index","-1");
		}
		if(callback != undefined){
			callback();
		}
	});
	if(preventBlur == undefined){
		$(".blur").css("opacity","0");
	}
	$(".blur").unbind();
	$(ele).unbind();
}
function popup_blurHandler(zin){
	$(".blur").css({"z-index":zin,"background-color":"#00000080","opacity":"1"});
	$('body').css({
	    overflow: "hidden" //No I18N
	});
}
function show_confirm(title,msg, yesCallback, noCallback)
{
	$(".blur").unbind();
	popup_blurHandler("8");
	
	$("#confirm_popup .confirm_pop_header").text(title);
	$(".confirm_text").html(msg);
	$("#confirm_popup").show(0,function(){
		$("#confirm_popup").addClass("pop_anim");
	});
	$("#confirm_popup").focus();
   // var dialog = $('#confirm_popup').dialog();
	
    $('#return_true').click(function() {
     //   dialog.dialog('close');
    	if($("#tfa_view_more_box").is(":visible")){
    		popupBlurHide("#confirm_popup",undefined,true);	//No I18N
    	}
    	else{
    		popupBlurHide("#confirm_popup");	//No I18N
    	}
	 	
	    yesCallback();
	    $('#return_false').unbind();
		$('#return_true').unbind();
    });
    
    $('#return_false').click(function() {
    //    dialog.dialog('close');
    	if($("#tfa_view_more_box").is(":visible")){
    		popupBlurHide("#confirm_popup",function(){ //No I18N
    			$("#confirm_popup #confirm_btns").removeClass('positive_conform');
        		$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();//No I18N
        	},true);
    	}
    	else{
    		popupBlurHide("#confirm_popup",function(){ //No I18N
    			$("#confirm_popup #confirm_btns").removeClass('positive_conform');
    		}); //No I18N
    	}
	 	noCallback();
	 	$('#return_false').unbind();
		$('#return_true').unbind();
		$('.blue').unbind();

    });
    $("#confirm_popup").keydown(function(e) {   
	    if (e.keyCode == 27) {
	    	$('#return_false').click();
	    }
	});
    $(".blur").click(function(){
    	$('#return_false').click();
    	$(".blur").unbind();
    });

}
function go_to_link(link,is_newtab)
{
	if(!is_newtab)
	{
		window.open(link,"_self");
		return;
	}
	window.open(link,"_blank");
}
function getToastTimeDuration(msg){
	var timing = (msg.split(" ").length) * 333.3;
	return timing > 3000 ? timing : 3000;
}
function showErrorMessage(msg) 
{
	if(msg!=""	&& msg!=undefined)
	{
		$(".error_msg").show();
		$(".error_msg").removeClass("sucess_msg");
		$(".error_msg").removeClass("warning_msg");
		$("#succ_or_err").html("");
		$("#succ_or_err_msg").html(msg);
		$(".error_msg_cross").html("");
		$(".error_msg_cross").append("<span class='crossline1'></span><span class='crossline2'></span>");
	
		
		var height =($(".error_msg_text")[0].clientHeight/2)-18;
    
		
		
		$(".error_msg").css("top","60px");
		

		if(setTime!=""){
			clearTimeout(setTime);
		}

		setTime = setTimeout(function() {
			$(".error_msg").css("top","-100px");
		}, getToastTimeDuration(msg));		

	}

}
function getErrorMessage(response) 
{
	if(response.cause && response.cause.trim() === "throttles_limit_exceeded") 
	{
		return thottle_reached_msg;
	}
	if(response.localized_message) 
	{
		return response.localized_message;
	}
	if(response.message) 
	{
		return response.message;
	}
	return i18nkeys['IAM.ERROR.GENERAL'];
}

function remove_error(ele)
{
	if(ele){
		$(ele).siblings(".field_error").remove();
	}
	else{
		$(".field_error").remove();	
	}
}

function SuccessMsg(msg, time_msec){
	if(msg!=""	&& msg!=undefined){
		if(!time_msec) {
			time_msec = getToastTimeDuration(msg);
		}
		$(".error_msg").show();
		$(".error_msg").addClass("sucess_msg");
		$(".error_msg").removeClass("warning_msg");
		$("#succ_or_err").html("");
		$("#succ_or_err_msg").html(msg);
		$(".error_msg_cross").html("");
		$(".error_msg_cross").append("<span class='tick'></span>");
    
		var height =($(".error_msg_text")[0].clientHeight/2)-18;
		
   		$(".error_msg").css("top","60px");
		
    	if(setTime!=""){
			clearTimeout(setTime);
		}
    
	    setTime = setTimeout(function() {
	   		$(".error_msg").css("top","-100px");
	    }, time_msec);
    
	}

}
function Hide_Main_Notification()
{
	$(".error_msg").css("top","-100px");
}
</script>
</html>
</#if>