<script>
var csrfParam= "${za.csrf_paramName}";
var csrfCookieName = "${za.csrf_cookieName}";

 var i18nLinkedAcckeys = {
	    		"IAM.VIEWMORE.ACCOUNT" : '<@i18n key="IAM.VIEWMORE.ACCOUNT" />',
				"IAM.VIEWMORE.ACCOUNTS" : '<@i18n key="IAM.VIEWMORE.ACCOUNTS" />'
		};
		
 var fontIconIdpNameToHtmlElement = {
 	"GOOGLE_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
 	"AZURE_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
 	"LINKEDIN_SMALL":'',
 	"FACEBOOK_SMALL":'',
 	"TWITTER_SMALL":'',
 	"YAHOO_SMALL":'',
 	"SLACK_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
 	"DOUBAN_SMALL":'',
 	"QQ_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span>',
 	"WECHAT_SMALL":'',
 	"WEIBO_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
 	"BAIDU_SMALL":'',
 	"APPLE_SMALL":'',
 	"INTUIT_SMALL":'',
 	"ADP_SMALL":'',
 	"FEISHU_SMALL":'<span class="path1"></span><span class="path2"></span><span class="path3">',
 	"GITHUB_SMALL":''
 }
 var fontIconBrowserToHtmlElement = {
		"osx": "",
		"ios": "",
		"windows": "",
		"android": "",
		"linux": "",
		"googlechrome":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"safari":'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>',
		"firefox": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"microsoftedge":'<span class="path1"></span><span class="path2"></span><span class="path3"></span>',
		"internetexplorer":"",
		"opera": '<span class="path1"></span><span class="path2"></span>',
		"browserunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>',
		"osunknown": '<span class="path1"></span><span class="path2"></span><span class="path3"></span>'
	};
</script>


				<div class="hide popup popup_padding" tabindex="1"id="popup_linked-accounts_contents">
					<div class="authweb_popup_head" id="linked_acc_popup_head"></div>
					<div class="close_btn" onclick="close_linked_accounts_screen()"></div>
					<div id="link_account_info" class="list_show">
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.LINKEDACCOUNTS.ADDED.TIME" /></div>
									<div class="info_value" id="pop_up_time"></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.OS.NAME.HEADING" /></div>
									<div class="info_value" id="pop_up_os"><div class="asession_os_popup"></div></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.LOGINHISTORY.BROWSERAGENT.APP" /></div>
									<div class="info_value" id="pop_up_browser"><div class="asession_browser_popup"></div></div>
								</div>
								<div class="info_div">
									<div class="info_lable"><@i18n key="IAM.AUTHORIZED.WEBSITES.TRUSTED.LOCATION" /></div>
									<div class="info_value" id="pop_up_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>
									<div class="info_ip"></div>
								</div>
					</div>
					<span id="linked_acc_popup_info"></span>
				</div>
				
				
				<div class="box big_box " id="linked_acc_box">
				
					<div class="box_blur"></div>
					<div class="loader"></div>
				
					<div class="box_info" >
						<div class="box_head"><@i18n key="IAM.LINKED.ACCOUNTS" /><span class="icon-info"></span></div>
						<div class="box_discrption"><@i18n key="IAM.LINKEDACCOUNTS.DESCRIPTION" /></div>
					</div>
					
					<div id="saml_enforced_wrapper">
						<span class="icon-warningfill"></span> 
						<p><@i18n key="IAM.LINKEDACCOUNTS.SAML.ENFORCED"/></p>
					</div>
					<!-- listing all possible idps for this dc -->
					<div id="all_idps" style="padding-bottom: 30px; display: block;">
					
					<#if google>
					<div class="idp_option" onclick="thirdparty_authentication('GOOGLE');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.GOOGLE" /></div>					
					</div>
					</#if>
					
					<#if azure>
					<div class="idp_option" onclick="thirdparty_authentication('AZURE');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.MICROSOFT" /></div>					
					</div>
					</#if>
					
					<#if linkedin>
					<div class="idp_option" onclick="thirdparty_authentication('LINKEDIN');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.LINKEDIN" /></div>					
					</div>
					</#if>
					
					<#if facebook>
					<div class="idp_option" onclick="thirdparty_authentication('FACEBOOK');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.FACEBOOK" /></div>					
					</div>
					</#if>
							
					<#if twitter>
					<div class="idp_option" onclick="thirdparty_authentication('TWITTER');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.TWITTER" /></div>					
					</div>
					</#if>
					
					<#if yahoo>
					<div class="idp_option" onclick="thirdparty_authentication('YAHOO');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.YAHOO" /></div>					
					</div>
					</#if>
					
					
					<#if slack>
					<div class="idp_option" onclick="thirdparty_authentication('SLACK');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.SLACK" /></div>					
					</div>
					</#if>
					
					<#if douban>
					<div class="idp_option" onclick="thirdparty_authentication('DOUBAN');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.DOUBAN" /></div>					
					</div>
					</#if>
					
					<#if baidu>
					<div class="idp_option" onclick="thirdparty_authentication('BAIDU');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.BAIDU" /></div>					
					</div>
					</#if>
					
					<#if weibo>
					<div class="idp_option" onclick="thirdparty_authentication('WEIBO');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.WEIBO" /></div>					
					</div>
					</#if>
					
					<#if wechat>
					<div class="idp_option" onclick="thirdparty_authentication('WECHAT');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.WECHAT" /></div>					
					</div>
					</#if>
					
					<#if qq>
					<div class="idp_option" onclick="thirdparty_authentication('QQ');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.QQ" /></div>					
					</div>
					</#if>
					
					<#if apple>
					<div class="idp_option" onclick="thirdparty_authentication('APPLE');">
					<div class="idp_font_icon"></div>
					<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.APPLE" /></div>					
					</div>
					</#if>
								
					</div>
					
					
					<div id="no_linkedaccount" class="box_content_div">
						<div class="no_data no_data_SQ"></div>
						<div class="no_data_text"><@i18n key="IAM.LINKEDACCOUNT.NOT_PRESENT" /> </div>
		 			</div>
		 		
					<div id="all_linked_accounts" class="hide">
					</div>
					
					
					<!-- slide add idps div -->
					<div class="add_new_account_container">
					<div id="idps_slide_container">
					<div class="closeicon" id="IDP_container_slideup"></div>
					
					<div id="link_new_account_view_more_box" class="hide">
						<div class="view_more half" onclick="show_all_linked_account()"><span><@i18n key="IAM.VIEWMORE.INFO" /></span></div>   
						<div class="addnew addnew_account_heading half link_new_account" onclick="IDP_container_slidedown();"><@i18n key="IAM.LINKEDACCOUNTS.ADD.NEW.ACCOUNT" /></div>
					</div>					
					<div class="addnew half addnew_account_heading" id="link_new_account" onclick="IDP_container_slidedown();"><@i18n key="IAM.LINKEDACCOUNTS.ADD.NEW.ACCOUNT" /></div>
					<div class="idps_list" id="idps_list" style="display: none;">
					
					<#if google>
					<div class="idp_option idp_opt_slide idp_google" onclick="thirdparty_authentication('GOOGLE');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-google_small">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
							</div>
							<div class="idp_name text_google"><@i18n key="IAM.GOOGLE" /></div>
						</div>				
					</div>
					</#if>
					
					<#if azure>
					<div class="idp_option idp_opt_slide idp_azure" onclick="thirdparty_authentication('AZURE');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-azure_small">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
							</div>
							<div class="idp_name text_azure"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.MICROSOFT" /></div>
						</div>				
					</div>
					</#if>
										
					<#if linkedin>
					<div class="idp_option idp_opt_slide idp_linkedin" onclick="thirdparty_authentication('LINKEDIN');">
						<div class="idp_center">
							<div class="idp_font_icon icon-linkedIn_L"></div>
						</div>				
					</div>
					</#if>
					
					<#if facebook>
					<div class="idp_option idp_opt_slide idp_fb" onclick="thirdparty_authentication('FACEBOOK');">
						<div class="idp_center">
							<div class="idp_font_icon icon-facebook_small"></div>
							<div class="idp_name text_fb"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.FACEBOOK" /></div>	
						</div>				
					</div>
					</#if>
							
					<#if twitter>
					<div class="idp_option idp_opt_slide idp_twitter" onclick="thirdparty_authentication('TWITTER');">
						<div class="idp_center">
							<div class="idp_font_icon icon-twitter_small"></div>
							<div class="idp_name text_twitter"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.TWITTER" /></div>			
						</div>		
					</div>
					</#if>
					
					<#if yahoo>
					<div class="idp_option idp_opt_slide idp_yahoo" onclick="thirdparty_authentication('YAHOO');">
						<div class="idp_center">
							<div class="idp_font_icon icon-yahoo_L"></div>
						</div>				
					</div>
					</#if>
					
					<#if slack>
					<div class="idp_option idp_opt_slide idp_slack" onclick="thirdparty_authentication('SLACK');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-slack_L">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
							</div>
						</div>				
					</div>
					</#if>
					
					<#if douban>
					<div class="idp_option idp_opt_slide idp_douban" onclick="thirdparty_authentication('DOUBAN');">
						<div class="idp_center">
							<div class="idp_font_icon icon-douban_small"></div>
							<div class="idp_name"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.DOUBAN" /></div>
						</div>				
					</div>
					</#if>
					
					<#if qq>
					<div class="idp_option idp_opt_slide idp_qq" onclick="thirdparty_authentication('QQ');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-qq_small">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
								<span class="path7"></span>
								<span class="path8"></span>
							</div>
							<div class="idp_name text_qq"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.QQ" /></div>
						</div>			
					</div>
					</#if>
					
					<#if wechat>
					<div class="idp_option idp_opt_slide idp_wechat" onclick="thirdparty_authentication('WECHAT');">
						<div class="idp_center">
							<div class="idp_font_icon icon-wechat_small"></div>
							<div class="idp_name text_wechat"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.WECHAT" /></div>
						</div>					
					</div>
					</#if>
					
					<#if weibo>
					<div class="idp_option idp_opt_slide idp_weibo" onclick="thirdparty_authentication('WEIBO');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-weibo_small">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
							</div>
							<div class="idp_name text_weibo"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.WEIBO" /></div>	
						</div>				
					</div>
					</#if>
					
					<#if baidu>
					<div class="idp_option idp_opt_slide idp_baidu" onclick="thirdparty_authentication('BAIDU');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-baidu_L">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
								<span class="path4"></span>
								<span class="path5"></span>
								<span class="path6"></span>
								<span class="path7"></span>
								<span class="path8"></span>
							</div>
						</div>				
					</div>
					</#if>
					
					<#if apple>
					<div class="idp_option idp_opt_slide idp_apple" onclick="thirdparty_authentication('APPLE');">
						<div class="idp_center">
							<div class="idp_font_icon icon-apple_small"></div>
							<div class="idp_name text_apple"><@i18n key="IAM.FEDERATED.SIGNIN.WITH.APPLE" /></div>
						</div>				
					</div>
					</#if>
					
					<#if intuit>
					<div class="idp_option idp_opt_slide idp_intuit" onclick="thirdparty_authentication('INTUIT');">
						<div class="idp_center">
							<div class="idp_font_icon icon-intuit_small"></div>
						</div>					
					</div>
					</#if>
					
					<#if adp>
					<div class="idp_option idp_opt_slide idp_adp" onclick="thirdparty_authentication('ADP');">
						<div class="idp_center">
							<div class="idp_font_icon icon-adp_small"></div>
						</div>				
					</div>
					</#if>
					
					<#if feishu>
					<div class="idp_option idp_opt_slide idp_feishu" onclick="thirdparty_authentication('FEISHU');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-feishu_L">
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
								<span class="path11"></span>
								<span class="path12"></span>
							</div>
						</div>				
					</div>
					</#if>
					
					<#if github>
					<div class="idp_option idp_opt_slide idp_github" onclick="thirdparty_authentication('GITHUB');">
						<div class="idp_center">
							<div class="idp_font_icon multi_colour_icon icon-github_small"></div>
							<div class="idp_name text_github"><@i18n key="IAM.IDENTITY.PROVIDER.NAME.GITHUB" /></div>
						</div>				
					</div>
					</#if>
					
					</div>
					</div>				
					</div>
					
				</div>
				
				
				
				<div class="viewall_popup hide popupshowanimate_2" tabindex="1" id="authorized_linked_more">
					<div class="box_info">
						<div class="expand_closebtn" onclick="closeview_all_linked_acc()"></div>
						<div class="box_head"><@i18n key="IAM.LINKED.ACCOUNTS" /><span class="icon-info"></span></div>
						<div class="box_discrption"><@i18n key="IAM.LINKEDACCOUNTS.DESCRIPTION" /></div>
					</div>
					<div id="view_accounts_remove" class="viewall_popup_content">
					</div>
				</div>
				
				
				<div id="empty_LinkedSites_format" class="hide">
									
					<div class="list_show Field_session" id="linked_accountnum"> 				
						<div class="authweb_entry_headder">
							<div class="linked_acc_info">
								<span class="aw_dp_font_icon"></span>
								<div class="aw_disc linked_account_id">
									<div class="aw_name"></div>
									<div class="aw_time"></div>
								</div>
							</div>
							<div class="linked_acc_details browser_icon"></div>
							<div class="linked_acc_details os_icon"></div>
							<div class="linked_acc_details created_location"><@i18n key="IAM.SESSIONS.LOCATION.UNAVAILABLE" /></div>
							<span class="deleteicon hide action_icon icon-delete" style="float: right; margin-right: 30px;" title="<@i18n key="IAM.REMOVE" />" ></span>
						</div>
						
						<div class="aw_info " id="linked_account_info">				
							
							<button class="primary_btn_check negative_btn_red inline" id="linked_acc_action" tabindex="1" ><span><@i18n key="IAM.REMOVE" /> </span></button>
							
						</div>
					</div>
					
				</div>
