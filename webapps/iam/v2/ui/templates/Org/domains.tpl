<script>
var i18nSessionkeys = {
	"IAM.ORG.DOMAIN.POPUP.HEADER" : '<@i18n key="IAM.ORG.DOMAIN.POPUP.HEADER" />',
	"IAM.ORG.DOMAIN.EXPIRED.POPUP.HEADER" : '<@i18n key="IAM.ORG.DOMAIN.EXPIRED.POPUP.HEADER" />',
	"IAM.ORG.DOMAIN.ABOUT.EXPIRE.POPUP.HEADER" : '<@i18n key="IAM.ORG.DOMAIN.ABOUT.EXPIRE.POPUP.HEADER" />',
	"IAM.VERIFY.NOW" : '<@i18n key="IAM.VERIFY.NOW"/>',
	"IAM.REVERIFY.NOW" : '<@i18n key="IAM.REVERIFY.NOW"/>',
	"IAM.DOMAIN.ABOUT.TO.EXPIRE" : '<@i18n key="IAM.DOMAIN.ABOUT.TO.EXPIRE"/>',
	"IAM.ORG.DOMAIN.POPUP.TEXT.FOOTER" : '<@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.FOOTER"/>',
	"IAM.ORG.DOMAIN.POPUP.CNAME.FOOTER" :'<@i18n key="IAM.ORG.DOMAIN.POPUP.CNAME.FOOTER"/>'
};
</script>
<div class="box big_box" id="domain_box">
				
		<div class="box_blur"></div>
		<div class="loader"></div>
	
		<div class="box_info">
			<div class="box_head"><@i18n key="IAM.HEADER.DOMAINS" /></div>
			<div class="box_discrption mob_hide"><@i18n key="IAM.HEADER.DOMAINS.DESCRIPTION" arg0="${domainsAddHelpLink}" /></div>
		</div>
		<div class="hide domain_temp">
			<span class="icon-domain email_dp dp_blue"></span>
			<span class="domain_info">
				<div class="domain_name"></div>
				<div class="domain_type">
					<span class="ver_content hide"><@i18n key="IAM.DOMAIN.VERIFIED"/></span>
					<span class="unver_content hide"><@i18n key="IAM.DOMAIN.UNVERIFIED"/></span>
					<span class="expired_content hide"><@i18n key="IAM.DOMAIN.EXPIRED"/></span>
					<span class="abouttoexpire_content hide"><span><@i18n key="IAM.DOMAIN.ABOUT.TO.EXPIRE"/></span><span class="what_to_do" style=color:#0091FF;margin-left:4px;cursor:pointer;" onclick="checkStatusBeforePopup()"><@i18n key="IAM.DOMAIN.WHAT.TO.DO"/></span></span>
					<span class="domain_tap_to_more hide">Tap to more</span>
				</div>
			</span>
			<span class="delete_button action_icon icon-delete" title='<@i18n key="IAM.DELETE"/>' onclick="deleteDomain('<@i18n key="IAM.CONFIRM.POPUP.DELETE.DOMAIN"/>','<@i18n key="IAM.DOMAIN.CONFIRM.DELETE.DESCRIPTION"/>');"></span>
			<span class="verify_button action_icon" onclick="showDomainVerifyPopup()"><span class="domain_ver_icon icon-verify"></span><@i18n key="IAM.VERIFY.NOW" /></span>
			<button class="reverify_button action_icon" onclick="showDomainReVerifyPopup()"><span class="domain_ver_icon icon-verify"></span><@i18n key="IAM.DOMAIN.REVERIFY.NOW" /></button>
			<!-- <span class="whattodo_button action_icon" onclick="showDomainVerifyPopup()"><span class="domain_ver_icon icon-verify"></span><@i18n key="IAM.DOMAIN.WHAT.TO.DO" /></span>  -->
		</div>
		<div id="domain_content">
			<div id="domain_verify_warn" class="hide"><span class="icon_warnn icon-warningfill"></span><span class="domain_verify_msg"><@i18n key="IAM.HEADER.DOMAINS.WARN"  arg0="${domainsAddHelpLink}" /></span></div>
			<div class="expired_domain"></div>
			<div class="abouttoexpire_domain"></div>
			<div class="unverified_domain"></div>
			<div class="verified_domain"></div>
		</div>
		<div id="no_domain" class="box_content_div hide">
			<div class="no_data no_data_SQ"></div>
			<div class="no_data_text"><@i18n key="IAM.ORG.DOMAIN.EMPTY.STATE" /></div>
		</div>
</div>
<div class=" hide popup" tabindex="0" id="verify_domain" style="height:auto;">
	<div class="popup_header">
		<div class="close_btn" onclick="close_domain_edit()"></div>
		<div class="popuphead_text"></div>
	</div>
	<div class="expiredDomain_content hide">
		<div class="option_text"><@i18n key="IAM.ORG.DOMAIN.VERIFY.POPUP.TEXT"/></div>
		<div style="margin-top:20px;">
			<div class="option_text" style="font-weight:600;"><@i18n key="IAM.ORG.DOMAIN.VERIFY.POPUP.STEPS.HEADER"/></div>
			<ul style="list-style-type: decimal;">
				<li class="orange_font" style="margin-bottom: 12px;"><@i18n key="IAM.ORG.DOMAIN.VERIFY.POPUP.STEP1" /></li>
				<li class="orange_font" style="margin-bottom: 12px;"><@i18n key="IAM.ORG.DOMAIN.VERIFY.POPUP.STEP2" /></li>
			</ul>
		</div>
		<div>
			<button tabindex="0" class="primary_btn_check inline" id="expired_domain_action" onclick="taketoVerify()"><span><@i18n key="IAM.DOMAIN.REVERIFY.NOW"/></span></button>			
		</div>
	</div>
	<div class="abtToExpireDomain_content hide">	
		<div class="option_text"><@i18n key="IAM.ORG.DOMAIN.ABOUT.EXPIRE.POPUP.TEXT"/></div>		
		<div>
			<button tabindex="0" class="primary_btn_check inline" id="abtToExpire_domain_action" onclick="checkStatusBeforePopup()"><span><@i18n key="IAM.DOMAIN.RENEWED.ALREADY"/></span></button>			
		</div>
	</div>
	<div class="verifyDomain_content hide">
		<div class="verify_option">
			<div class="option_text"><@i18n key="IAM.ORG.DOMAIN.POPUP.VERIFY.TEXT"/></div>
			<div class="domain_options">
				<div class="radiobtn_div" style="border-radius: 4px 0px 0px 4px;border-right:0;">
					<input class="real_radiobtn" onchange="changeDomainOption(this)" type="radio" name="options" id="txt" value="2" checked="checked">
					<div class="outer_circle">
					<div class="inner_circle"></div></div>
					<label class="radiobtn_text" for="txt"><@i18n key="IAM.ORG.DOMAIN.POPUP.VERIFY.OPTION.TXT"/></label>
				</div>
				<div class="radiobtn_div">
					<input class="real_radiobtn" onchange="changeDomainOption(this)" type="radio" name="options" id="cname" value="1" >
					<div class="outer_circle">
					<div class="inner_circle"></div></div>
					<label class="radiobtn_text" for="cname"><@i18n key="IAM.ORG.DOMAIN.POPUP.VERIFY.OPTION.CNAME"/></label>
				</div>
				<div class="radiobtn_div" style="border-radius: 0px 4px 4px 0px;border-left:0;">
					<input class="real_radiobtn" type="radio" onchange="changeDomainOption(this)" name="options" id="html" value="0">
					<div class="outer_circle">
					<div class="inner_circle"></div></div>
					<label class="radiobtn_text" for="html"><@i18n key="IAM.ORG.DOMAIN.POPUP.VERIFY.OPTION.HTML"/></label>
				</div>
			</div>
		</div>
		<div class="verify_option_detail">
			<div class="step_box txt_content">
				<div class="steps step1">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP1"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.STEP1"/>
					</div>
				</div>
				<div class="steps step2">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP2"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.STEP2"/>
						<div class="gray_box_container">
							<div class="domainGrayBox">
								<div class="gray_header"><@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.HOST.NAME"/></div>
								<div class="host_name">"@"</div>
							</div>
							<div class="domainGrayBox">
								<div class="gray_header"><@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.HOST.VALUE"/></div>
								<div class="host_value" id="txt_host_value"></div>
								<div class="blue txt_copy" onclick="clickToCopy('txt_copy','txt_host_value')"><@i18n key="IAM.COPY"/></div>
							</div>
						</div>
					</div>
				</div>
				<div class="steps step3">	
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP3"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.STEP3"/>
					</div>
				</div>
			</div>
			<div class="hide step_box cname_content">
				<div class="steps step1">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP1"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.CNAME.STEP1"/>
					</div>
				</div>
				<div class="steps step2">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP2"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.CNAME.STEP2"/>
						<div class="gray_box_container">
							<div class="domainGrayBox">
								<div class="gray_header"><@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.HOST.NAME"/></div>
								<div class="host_name" id="cname_host_name"></div>
								<div class="blue cname_name_copy" onclick="clickToCopy('cname_name_copy','cname_host_name')"><@i18n key="IAM.COPY"/></div>
							</div>
							<div class="domainGrayBox">
								<div class="gray_header"><@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.HOST.VALUE"/></div>
								<div class="host_value" id="cname_host_value"></div>
								<div class="blue cname_value_copy" onclick="clickToCopy('cname_value_copy','cname_host_value')"><@i18n key="IAM.COPY"/></div>
							</div>
						</div>
					</div>
				</div>
				<div class="steps step3">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP3"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.CNAME.STEP3"/>
					</div>
				</div>
			</div>
			<div class="hide step_box html_content">
				<div class="steps step1">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP1"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.HTML.STEP1"/>
						<div class="gray_box_container">
							<div class="domainGrayBox html_domain_box">
								<span class="icon-html"></span>
								<div class="domain_html"></div>
								<span class="icon-download"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="steps step2">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP2"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.HTML.STEP2"/>
						<div><@i18n key="IAM.ORG.DOMAIN.POPUP.HTML.URL.EXAMPLE"/></div>
					</div>
				</div>
				<div class="steps step3">
					<div class="text_button text_grn_btn"><@i18n key="IAM.ORG.DOMAIN.POPUP.STEP3"/></div>
					<div class="steps_detail">
						<@i18n key="IAM.ORG.DOMAIN.POPUP.HTML.STEP3"/>
					</div>
				</div>
			</div>
			<div class="domain_info_content orange_font"><@i18n key="IAM.ORG.DOMAIN.POPUP.TEXT.FOOTER"/></div>
			<div class="domain_err_content"></div>
			<div class="dom_verify_actions">
				<button tabindex="0" class="primary_btn_check inline" id="verify_domain_action" onclick="verifyTheDomain()"><span></span></button>
				<button tabindex="0" class="primary_btn_check high_cancel" id="cancel_verification" onclick="close_domain_edit()"><span><@i18n key="IAM.DOMAIN.CHECK.STATUS.LATER"/></span></button>
			</div>
			
		</div>
	</div>
	<div class="renewed_success_content hide">
		<div class="close_btn" onclick="close_domain_edit()"></div>
		<div class="success_container">
			<span class="success_tick_icon icon-sucessfill"></span>
			<span class="success_header"><@i18n key="IAM.ORG.DOMAIN.POPUP.SUCCESS.HEADER"/></span>
			<span class="success_text"><@i18n key="IAM.ORG.DOMAIN.POPUP.SUCCESS.TEXT"/></span>
			<button tabindex="0" class="primary_btn_check high_cancel" style="margin: auto;margin-top: 24px;" onclick="close_domain_edit()"><span><@i18n key="IAM.OK"/></span></button>
		</div>
		
	</div>
</div>



<div class="hide popup" tabindex="0" id="domain_popup_for_mobile">
	<div class="popup_header popup_header_for_mob">
		<div class="popuphead_details">
	                	
		</div>
		<div class="close_btn" onclick="close_domain_mobile_specific()"></div>
	</div>
	<div class="mob_popu_btn_container">
		<button class="" id="btn_to_verify" onclick="" ><span class="icon-verify"></span><span><@i18n key="IAM.VERIFY.NOW"/></span></button>
		<button class="" id="btn_to_reverify" onclick="" ><span class="icon-verify"></span><span><@i18n key="IAM.DOMAIN.REVERIFY.NOW"/></span></button>
		<button class="" id="btn_to_delete_domain" onclick="deleteDomain('<@i18n key="IAM.CONFIRM.POPUP.DELETE.DOMAIN"/>','<@i18n key="IAM.DOMAIN.CONFIRM.DELETE.DESCRIPTION"/>');" ><span class="icon-delete"></span><span><@i18n key="IAM.DELETE"/></span></button>
	</div>
</div>