//$Id$
var closeAccountReqID = undefined;
function setVaribaleValue(){
	if(!fromSSOKit){
		closeAccountReqID = settings_data.CloseAccounts.request_id;
	}
	else{
		if(request_id){closeAccountReqID = request_id;}
	}
}

function disabledButton(form_ele,specificButton){
	if(specificButton){
		$(specificButton).attr("disabled", "disabled");
		$(specificButton).addClass("button_disable");
		$(specificButton).removeClass("primary_btn_check");
		return;
	}
	$(form_ele).find("button").attr("disabled", "disabled");
	$(form_ele).find("button:visible:not(.browse_btn):first").addClass("button_disable");
	$(form_ele).find("button:visible:not(.browse_btn):first").removeClass("primary_btn_check");
}
function removeButtonDisable(form_ele,specificButton){
	if(specificButton){
		$(specificButton).removeAttr("disabled");
		$(specificButton).addClass("primary_btn_check");
		$(specificButton).removeClass("button_disable");
		return;
	}
	$(form_ele).find("button").removeAttr("disabled");
	$(form_ele).find(".button_disable").addClass("primary_btn_check");
	$(form_ele).find(".primary_btn_check").removeClass("button_disable");
}
function redirectToReauth(redirectURL){
	var reauth_url = redirectURL+"?serviceurl="+encodeURIComponent(window.location.href);		//No I18N
	if(isMobile || fromSSOKit){
		window.open(reauth_url, '_self');
	}
	else{
		window.open(reauth_url+"&post="+true, '_blank');
	}
	
}

function cancelCloseProcess(zid){
	new URI(NewCloseAccountsObj,"self","self",zid).DELETE().then(function(resp)	//No I18N
	{
		SuccessMsg(resp.message);
		if(fromSSOKit){
			go_to_link(sso_redirect_url,false);
		}
		else{
			delete settings_data.CloseAccounts.step;
			delete settings_data.CloseAccounts.request_id;
			closeAccountSteps = undefined;
			$("#final_step_to_close #delete_acc_reason")[0].selectedIndex=0;
			$("#deleteacc_command").val("");
			load_closeddetails(settings_data.Policies,settings_data.CloseAccounts);
			if(!fromSSOKit){cancelInitiateOption();}
		}
	},
	function(resp)
	{
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			redirectToReauth(resp.redirect_url);
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});
}

function openCloseOrgOption(){
	$("body").css("overflow","hidden");
	$("body,html").css("height","100%");//No I18N
	window.onresize="";
	$(".processing_block,#preference_space,#authorizedsites_space,#linkedaccounts_space,#preference_box,#settingsubmenu,#closeaccount_space,.start_process").hide();
	$(".org_close_aligner,.start_process,.start_process_for_web").show();
	$(window).scrollTop(0);
	if(!fromSSOKit && isPersonalUser){
		$(".steps_block_sep .desc_abt_domains").hide();
		$(".steps_block_sep .desc_abt_subscription").addClass("blur_from_bottom");
		$(".steps_block_sep .desc_abt_app_orgs").find(".icon_box").text("3");
		$(".steps_block_sep .desc_abt_close_org").find(".icon_box").text("4");
	}
	
}

function cancelInitiateOption(){
	$("body").css("overflow","auto");
	$("body,html").css("height","unset");//No I18N
	$("#preference_space,#authorizedsites_space,#linkedaccounts_space,#preference_box,#settingsubmenu,#closeaccount_space,.start_process").show();
	if(!fromSSOKit && !isPersonalUser){
		$(".checkbox_area [name='delete_type']:checked").prop('checked', false);
		$(".initate_btn").attr("disabled","disabled");
	}
	$(".org_close_aligner,.start_process,.redtext_for_close_acc").hide();
  	window.onresize=function() {
		setHeightForCover();
	};
	$(window).scrollTop(window.innerHeight);
}

function initiateCloseAccount(){
	disabledButton(fromSSOKit ? ".org_close_view .start_process" : ".org_close_view .start_process_for_web");
	var parms=
	{
		"includeCloseAcc":false		//No i18N
	};
	if(!isPersonalUser){
		parms.includeCloseAcc = $(".org_close_view #account_with_org").prop('checked');
	}
	
	var payload = NewCloseAccountsObj.create(parms);
	payload.POST("self","self").then(function(resp){		//No i18N
		removeButtonDisable(fromSSOKit ? ".org_close_view .start_process" : ".org_close_view .start_process_for_web");		//No i18N
		moveToNextOption(resp.closeaccount.request_id,resp.closeaccount.step);
	},function(resp){
		removeButtonDisable(fromSSOKit ? ".org_close_view .start_process" : ".org_close_view .start_process_for_web");		//No i18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			redirectToReauth(resp.redirect_url);
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});
}

function initiateFromSSOKit(){
	var parms=
	{
		"includeCloseAcc":false		//No i18N
	};
	var payload = NewCloseAccountsObj.create(parms);
	payload.POST("self","self").then(function(resp){		//No I18N
		moveToNextOption(resp.closeaccount.request_id,resp.closeaccount.step);
	},function(resp){
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			redirectToReauth(resp.redirect_url);
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});
}

var closeAccServiceData = {};
var closeAccountSteps;
function moveToNextOption(zid,selected_tab){
	closeOrgSlide();
	selected_tab = selected_tab.toLowerCase();		
	if(closeAccountSteps){
		new URI(NewCloseAccountsObj,"self","self",zid).include(selected_tab).GET().then(function(resp){	//No I18N
			if(fromSSOKit){
				$("#initiated_warning,#show_close_block").hide();
				$(".org_close_view .content_block").show();
			}
			if(resp.force_skipped_step == true ){
    			//Handling to process next step when a step has no data to be shown in UI.
				selected_tab = resp.redirected_step
				if(resp.STEPS){
					//Updating STEPS stored in client-side as it is updated in server side when skipping a step with empty data.
			    	closeAccountSteps = resp.STEPS;
				}
			}
			closeAccServiceData[selected_tab] = resp;
			if(closeAccountReqID){
				openCloseOrgOption();
				//moveToNextOption(settings_data.CloseAccounts.request_id,settings_data.CloseAccounts.step);
			}
			listCloseAccountData(zid,selected_tab);
		},function(resp){
			$(".org_close_view .refresh_option").removeClass("disabled_refresh");
			if(resp.cause && resp.cause.trim() === "invalid_password_token") 
			{
				redirectToReauth(resp.redirect_url);
			}
			else
			{
				showErrorMessage(getErrorMessage(resp));
			}
		});
	}
	else{
		new URI(NewCloseAccountsObj,"self","self",zid).include("steps").include(selected_tab).GET().then(function(resp){	//No I18N
			if(fromSSOKit){
				$("#initiated_warning,#show_close_block").hide();
				$(".org_close_view .content_block").show();
			}
	    	closeAccountSteps = resp.STEPS;
			closeAccServiceData[selected_tab] = resp;
			if(closeAccountReqID){
				openCloseOrgOption();
				//moveToNextOption(settings_data.CloseAccounts.request_id,settings_data.CloseAccounts.step);
			}
			listCloseAccountData(zid,selected_tab);
		},function(resp){
			$(".org_close_view .refresh_option").removeClass("disabled_refresh");
			if(resp.cause && resp.cause.trim() === "invalid_password_token") 
			{
				redirectToReauth(resp.redirect_url);
			}
			else
			{
				showErrorMessage(getErrorMessage(resp));
			}
		});
	}
	
}

function listCloseAccountData(zid,selected_tab){
	$(".start_process,.start_process_for_web,#final_step_to_close,.close_acc_actions_desc span").hide();
	$(".org_close_view .refresh_option").removeClass("disabled_refresh");
	$(".processing_block").removeClass("remove_btn_height");
	$(".processing_block").css("display","flex");
	$(".status_info>div").hide();
	$(".org_close_view .right_block_header,.button_container,.content_about_close_org").show();
	for(var step in closeAccountSteps){
		$(".status_info ."+closeAccountSteps[step].toLowerCase()).show();
	}
	$(".status_viewer .status_tab").removeClass("completed_tab").removeClass("selected_tab");
	$(".status_viewer .status_tab:first").addClass("selected_tab");
	if(selected_tab){
		var tab_ind = parseInt($(".status_info ."+selected_tab).find(".tab_value").val());
		for(var len = 0;len < tab_ind;len++){
			$($(".status_viewer .status_tab")[len]).addClass("selected_tab").addClass("completed_tab");
		}
		if($($(".status_viewer .status_tab")[tab_ind]).length != 0){
			$($(".status_viewer .status_tab")[tab_ind]).addClass("selected_tab");
		}
	}
	var icon_path = "";
	for(var path_count=1;path_count<=10;path_count++){
		icon_path=icon_path+"<span class='path"+path_count+"'></span>";		//No I18N
	}
	var cur_flow_status = $(".status_viewer .status_tab")[tab_ind] != undefined ? $(".status_viewer .status_tab")[tab_ind].id : "delete_org";
	$(".right_block_header>div").hide();
	$("."+cur_flow_status+"_header_details").show();
	if(cur_flow_status == "delete_domain" && isPersonalUser){cur_flow_status = "delete_org"}
	if(cur_flow_status == "used_serice"){
		$(".org_close_view #next_step").attr("onclick","moveToNextOption('"+zid+"','subscriptions')");
		$(".org_close_view #prev_step").hide();
		$(".content_about_close_org").html("<div id='servicetable'></div>");
		$(".content_about_close_org #servicetable").html("<div class='bundle_service_block' id='bundle_service_block'></div>");
		for(var bundle_name in closeAccServiceData.services.SERVICEDETAILS.bundle){
				var serviceDisplayName = closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name].display_name && closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name].display_name != "" ? closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name].display_name : bundle_name;
				$(".content_about_close_org #bundle_service_block").append("<div class='bundle_cover_div' id='bundle_"+bundle_name+"'></div>");
				$("#bundle_service_block #bundle_"+bundle_name).html("<div class='service_list_data'></div><div class='bundle_sub_service_list hide'></div>");
				$("#servicetable #bundle_"+bundle_name+" .service_list_data").attr("onclick","showServiceOrgs(this,'"+bundle_name+"')");
				$("#bundle_"+bundle_name+" .service_list_data").html("<i class='device_pic product_icon product-icon-"+bundle_name.toLowerCase()+"'></i><span class='servicename'>"+serviceDisplayName+"</span>");
	    		$("#bundle_"+bundle_name+" .service_list_data .product_icon").append(icon_path);
				var bundleOrgKeys = Object.keys(closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name]);
				for(var bundleID in bundleOrgKeys){
					if(bundleOrgKeys[bundleID] != "display_name"){
						$("#bundle_"+bundle_name+" .service_list_data").append("<span class='show_sub_service' onclick='showBundleList(this)'>"+formatMessage(i18nkeys["IAM.CLOSE.ACCOUNT.USED.SERVICE.COUNT"],Object.keys(closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name][bundleOrgKeys[bundleID]].child_services).length)+"</span>");
						for(var bundle_service in closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name][bundleOrgKeys[bundleID]].child_services){
							var serviceDisplayName = closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name][bundleOrgKeys[bundleID]].child_services[bundle_service].display_name != "" ? closeAccServiceData.services.SERVICEDETAILS.bundle[bundle_name][bundleOrgKeys[bundleID]].child_services[bundle_service].display_name : bundle_service;
							$("#bundle_"+bundle_name+" .bundle_sub_service_list").append("<div id='bundleService"+bundle_service+"' class='sub_service_hidden_list'></div>");
							$("#bundle_"+bundle_name+" #bundleService"+bundle_service).attr("onclick","showServiceOrgs(this,'"+bundle_service+"')");	//No I18N
							$("#bundle_"+bundle_name+" .bundle_sub_service_list #bundleService"+bundle_service).append("<i class='device_pic product_icon product-icon-"+bundle_service.toLowerCase()+"'></i><span class='servicename'>"+serviceDisplayName+"</span>");
							$("#bundle_"+bundle_name+" .bundle_sub_service_list #bundleService"+bundle_service+" .product_icon").append(icon_path);
						}
					}
				}
		}
		for(var servicename in closeAccServiceData.services.SERVICEDETAILS){
			if(servicename != "bundle" && servicename != "next_step"){
				var serviceDisplayName = closeAccServiceData.services.SERVICEDETAILS[servicename].display_name && closeAccServiceData.services.SERVICEDETAILS[servicename].display_name != "" ? closeAccServiceData.services.SERVICEDETAILS[servicename].display_name : servicename;
				$("#servicetable").append("<div class='service_list_data' id='service_"+servicename+"'></div>");
				$("#servicetable #service_"+servicename).attr("onclick","showServiceOrgs(this,'"+servicename+"')");
				$("#servicetable #service_"+servicename).html("<i class='device_pic product_icon product-icon-"+servicename.toLowerCase()+"'></i><span class='servicename'>"+serviceDisplayName+"</span>");
				$("#servicetable #service_"+servicename+" .product_icon").append(icon_path);
			}
		}
		$(".close_acc_actions_desc .used_apps_text").show();
		setCloseAccButtonFunc(zid,selected_tab,true);
	}
	else if(cur_flow_status == "unsubscribe"){
		$(".org_close_view #next_step").attr("onclick","moveToNextOption('"+zid+"','accounts_to_be_closed')");
		$(".org_close_view #prev_step").attr("onclick","moveToNextOption('"+zid+"','services')").show();
		$(".content_about_close_org").html("<div id='subscribed_table'></div>");
		for(var servicename in closeAccServiceData.subscriptions.SUBSCRIPTIONS){
			if(servicename != "bundle" && servicename != "service_url" && servicename != "next_step"){
				var serviceDisplayName = closeAccServiceData.subscriptions.SUBSCRIPTIONS[servicename].display_name && closeAccServiceData.subscriptions.SUBSCRIPTIONS[servicename].display_name != "" ? closeAccServiceData.subscriptions.SUBSCRIPTIONS[servicename].display_name : servicename;
				$("#subscribed_table").append("<div class='service_list_data' id='service_"+servicename+"'></div>");
				$("#subscribed_table #service_"+servicename).attr("onclick","showServiceOrgs(this,'"+servicename+"',true)");
				$("#subscribed_table #service_"+servicename).html("<i class='device_pic product_icon product-icon-"+servicename.toLowerCase()+"'></i><span class='servicename'>"+serviceDisplayName+"</span>");
				$("#subscribed_table #service_"+servicename+" .product_icon").append(icon_path);
			}
		}
		closeAccServiceData.subscriptions.SUBSCRIPTIONS.service_url != undefined ? $(".unsubscribe_header_details .header_btn").show() : $(".unsubscribe_header_details .header_btn").hide();
		setCloseAccButtonFunc(zid,selected_tab,closeAccServiceData.subscriptions.SUBSCRIPTIONS.next_step);
		if(closeAccServiceData.subscriptions.SUBSCRIPTIONS.next_step){
			Object.keys(closeAccServiceData.domains.DOMAINDETAILS).length == 2 ? $(".close_acc_actions_desc .subscription_succ_single_text").show() : $(".close_acc_actions_desc .subscription_succ_text").show();
		}
		else{
			$(".close_acc_actions_desc .subscription_text").show();
		}
	}
	else if(cur_flow_status == "close_portal"){
		$(".org_close_view #next_step").attr("onclick","moveToNextOption('"+zid+"','domains')");
		$(".org_close_view #prev_step").attr("onclick","moveToNextOption('"+zid+"','subscriptions')");
		$(".content_about_close_org").html("<div id='portal_table'></div>");
		if(closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED){
			for(var servicename in closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED){
				var portal_list = closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED[servicename];
				var serviceDisplayName = closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED[servicename].display_name && closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED[servicename].display_name != "" ? closeAccServiceData.accounts_to_be_closed.USER_ACTIONS_NEEDED[servicename].display_name : servicename;
				for(var portal_service_id in portal_list){
					if(portal_service_id != "display_name"){
						$("#portal_table").append("<div class='service_list_data' id='service_"+servicename+""+portal_service_id+"'></div>");
						$("#portal_table #service_"+servicename+""+portal_service_id).html("<i class='device_pic product_icon product-icon-"+servicename.toLocaleLowerCase()+"'></i>");	//No I18N
						$("#portal_table #service_"+servicename+""+portal_service_id+" .product_icon").append(icon_path);
						$("#portal_table #service_"+servicename+""+portal_service_id).append("<span class='portal_details'><div class='servicename'>"+serviceDisplayName+"</div><div class='portal_id'></div></span>");
						var portal_org_name = portal_list[portal_service_id].org_name;
						if(portal_org_name != undefined && portal_org_name != ""){
							$("#portal_table #service_"+servicename+""+portal_service_id+" .portal_id").html("<span class='portal_org_name'>"+escapeHTML(portal_org_name)+"</span><span>"+portal_service_id+"</span>");
						}
						else{
							$("#portal_table #service_"+servicename+""+portal_service_id+" .portal_id").html("<span>"+portal_service_id+"</span>");
						}
						$("#portal_table #service_"+servicename+""+portal_service_id).append("<span class='close_port_action'><span class='portal_blue_btn' onclick=go_to_link('"+portal_list[portal_service_id].service_url+"',true)><span class='icon-newtab'></span><span class='close_port_text'></span></span></span"); //No I18N
						$("#portal_table #service_"+servicename+""+portal_service_id+" .close_port_text").html(portal_list[portal_service_id].custom_action_label ? portal_list[portal_service_id].custom_action_label : i18nkeys["IAM.CLOSE.ACCOUNT.CLOSE.PORTAL"]);		//No I18N
						$("#portal_table #service_"+servicename+""+portal_service_id+" .close_port_action").append("<span class='close_portal_info icon-question'><span class='user_close_msg hide'></span></span>");
						$("#portal_table #service_"+servicename+""+portal_service_id+" .user_close_msg").html(portal_list[portal_service_id].localized_message);
						if(portal_list[portal_service_id].help_link){
							$("#portal_table #service_"+servicename+""+portal_service_id+" .user_close_msg").append("</br><span class='blue_link'>"+i18nkeys["IAM.TFA.LEARN.MORE"]+"</span>");
							$("#portal_table #service_"+servicename+""+portal_service_id+" .user_close_msg").find(".blue_link").attr("onclick","go_to_link('"+portal_list[portal_service_id].help_link+"',true)");
						}
					}
				}
			}
		}
		for(var servicename in closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED){
			var portal_list = closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED[servicename];
			var serviceDisplayName = closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED[servicename].display_name && closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED[servicename].display_name != "" ? closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED[servicename].display_name : servicename;
			for(var portal_service_id in portal_list){
				if(portal_service_id != "display_name"){
					$("#portal_table").append("<div class='service_list_data' id='service_"+servicename+""+portal_service_id+"'></div>");
					$("#portal_table #service_"+servicename+""+portal_service_id).html("<i class='device_pic product_icon product-icon-"+servicename.toLocaleLowerCase()+"'></i>");
					$("#portal_table #service_"+servicename+""+portal_service_id+" .product_icon").append(icon_path);
					$("#portal_table #service_"+servicename+""+portal_service_id).append("<span class='portal_details'><div class='servicename'>"+serviceDisplayName+"</div><div class='portal_id'></div></span>");
					var portal_org_name = portal_list[portal_service_id].org_name;
					if(portal_org_name != undefined && portal_org_name != ""){
						$("#portal_table #service_"+servicename+""+portal_service_id+" .portal_id").html("<span class='portal_org_name'>"+escapeHTML(portal_org_name)+"</span><span>"+portal_service_id+"</span>");
					}
					else{
						$("#portal_table #service_"+servicename+""+portal_service_id+" .portal_id").html("<span>"+portal_service_id+"</span>");
					}
		
					$("#portal_table #service_"+servicename+""+portal_service_id).append("<span class='portal_deleted_info'>"+i18nkeys["IAM.CLOSE.ACCOUNT.CLOSE.PORTAL.BE.DELETED"]+"</span>");
				}
			}
		}
		setCloseAccButtonFunc(zid,selected_tab,closeAccServiceData.accounts_to_be_closed.next_step);
		if(closeAccServiceData.accounts_to_be_closed.next_step){
			Object.keys(closeAccServiceData.accounts_to_be_closed.ACCOUNTS_TO_BE_CLOSED).length < 2 ? $(".close_acc_actions_desc .app_portal_succ_single_text").show() : $(".close_acc_actions_desc .app_portal_succ_text").show();
		}
		else{
			$(".close_acc_actions_desc .app_portal_text").show();
		}
	}
	else if(cur_flow_status == "delete_domain"){
		$(".org_close_view #next_step").attr("onclick","moveToNextOption('"+zid+"','confirm_close_account')");
		$(".org_close_view #prev_step").attr("onclick","moveToNextOption('"+zid+"','accounts_to_be_closed')");
		$(".content_about_close_org").html("<div id='domains_table'></div>");
		var count = 0;
		for(var domain in closeAccServiceData.domains.DOMAINDETAILS){
			if(domain != "next_step"){
				$("#domains_table").append("<div class='domain_list' id='domain_"+count+"'></div>");
				$("#domains_table #domain_"+count).html("<span class='icon-domain email_dp "+color_classes[gen_random_value()]+"'></span><span class='detail_abt_domain'></span>");
				$("#domains_table #domain_"+count+" .detail_abt_domain").html("<span class='domainname'>"+domain+"</span><span class='verified_status'></span>");
				$("#domains_table #domain_"+count+" .verified_status").text(closeAccServiceData.domains.DOMAINDETAILS[domain].isVerified ? i18nkeys["IAM.DOMAIN.VERIFIED"] : i18nkeys["IAM.DOMAIN.UNVERIFIED"]);	//No I18N
				if(closeAccServiceData.domains.DOMAINDETAILS[domain].isHosted){
					$("#domains_table #domain_"+count).append("<span class='hostbymail'><i class='device_pic product_icon product-icon-mail'></i><span class='text_abt_hosted'>"+i18nkeys["IAM.CLOSE.ACCOUNT.DOMAIN.HOSTED.WITH.MAIL"]+"</span></span>");
					$("#domains_table #domain_"+count+" .product_icon").append(icon_path);
					$("#domains_table #domain_"+count).append("<span class='close_port_action'><span class='port_action_icon icon-newtab'></span><span class='close_port_text go_to_mail' >"+i18nkeys["IAM.CLOSE.ACCOUNT.GO.TO.MAIL"]+"</span></span>");
					$("#domains_table #domain_"+count+" .close_port_action").attr("onclick","go_to_link('"+closeAccServiceData.domains.DOMAINDETAILS[domain].service_url+"',true)");
				}
				count++;
			}
		}
		setCloseAccButtonFunc(zid,selected_tab,closeAccServiceData.domains.DOMAINDETAILS.next_step);
		if(closeAccServiceData.domains.DOMAINDETAILS.next_step){
			var k_count = Object.keys(closeAccServiceData.domains.DOMAINDETAILS).length;
			if(k_count == 1){
				$(".close_acc_actions_desc .domain_text_empty").show();
			}else{				
				k_count < 3 ? $(".close_acc_actions_desc .domain_not_enabled_single_text").show() : $(".close_acc_actions_desc .domain_not_enabled_text").show();
			}
		}
		else{
			$(".close_acc_actions_desc .domain_text").show();
		}
	}
	else if(cur_flow_status == "delete_org"){
		$(".button_container,.content_about_close_org,.org_close_view .right_block_header").hide();
		$(".processing_block").addClass("remove_btn_height");
		$("#final_step_to_close #delete_acc_reason").uvselect({
			width:"100%"	//No I18N
		});
		$("#final_step_to_close").show();
		if(isPersonalUser || !closeAccServiceData.confirm_close_account.show_close_account)
		{
			$(".note_for_close_org_and_acc,.close_service_form .cancel_org_with_account").hide();$(".note_for_close_org,.close_service_form .cancel_org").show();
		}
		else{
			$(".note_for_close_org_and_acc,.close_service_form .cancel_org_with_account").show();$(".note_for_close_org,.close_service_form .cancel_org").hide();
		}
		showLength(document.getElementById("deleteacc_command"));
		$("#initiate_cls_button").attr("onclick","initiateFinalStep('"+zid+"')");
		setCloseAccButtonFunc(zid,selected_tab);
	}
	 
}

function refreshCloseAccFlow(zid,selected_tab){
	if($(".org_close_view .refresh_option").hasClass("disabled_refresh")){return false;}
	$(".org_close_view .refresh_option").addClass("disabled_refresh");
	moveToNextOption(zid,selected_tab)
};
function setCloseAccButtonFunc(zid,selected_tab,enableNext){
	var tab_name;
	$("#go_to_back").hide();	
	if(selected_tab == "domains" || selected_tab == "accounts_to_be_closed" || selected_tab == "subscriptions"){
		$(".org_close_view .refresh_option").attr("onclick","refreshCloseAccFlow('"+zid+"','"+selected_tab+"')").show();
	}
	else{
		$(".org_close_view .refresh_option").hide();
	}
	if($(".status_info ."+selected_tab).nextAll(":visible").first().length != 0){		
		tab_name = $(".status_info ."+selected_tab).nextAll(":visible").first().find(".tab_value").attr("id");	//No I18N
		$(".org_close_view #next_step").attr("onclick","moveToNextOption('"+zid+"','"+tab_name+"')").show();
		if(enableNext){
			$(".org_close_view #next_step").removeClass("disabled_primary_btn").removeAttr("disabled","disabled");
		}
		else{
			$(".org_close_view #next_step").addClass("disabled_primary_btn").attr("disabled","disabled");
		}
	}
	else{
		$(".org_close_view #next_step").hide();
	}
	if(selected_tab == "confirm_close_account"){
		if(isPersonalUser){
			$(".close_service_form #cancelCloseProcess").attr("onclick","showCancelConfirm('"+i18nkeys["IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE"]+"','"+i18nkeys["IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION.FOR.ACCOUNT"]+"','"+zid+"')").show();
		}
		else{
			$(".close_service_form #cancelCloseProcess").attr("onclick","showCancelConfirm('"+i18nkeys["IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE"]+"','"+i18nkeys["IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION"]+"','"+zid+"')").show();
		}
	}
	if($(".status_info ."+selected_tab).prevAll(":visible").first().length != 0){	
		tab_name = $(".status_info ."+selected_tab).prevAll(":visible").first().find(".tab_value").attr("id");	//No I18N
		$(".org_close_view #prev_step").attr("onclick","moveToNextOption('"+zid+"','"+tab_name+"')").show();
		if(selected_tab == "confirm_close_account"){
			$("#go_to_back").attr("onclick","moveToNextOption('"+zid+"','"+tab_name+"')").css("display","inline-block");	//No I18N
		}
	}
	else{
		$(".org_close_view #prev_step,#go_to_back").hide();	
	}
	$(".right_block .mobile_status_indicator").css("width",((($(".status_info ."+selected_tab).prevAll(":visible").length+1)/closeAccountSteps.length)*100)+"%");
}

function showServiceOrgs(ele,serviceName,fromSubscription){
	
	$(".service_list_data,.sub_service_hidden_list").removeClass("service_selected");
	if($(ele).parents(".bundle_service_block").length != 1){
		$(".bundle_sub_service_list").slideUp(300);
	}

	$(ele).addClass("service_selected");
	$("#close_acc_right_slider").addClass("show_right_slide");
	$("#close_acc_right_slider").html("<div class='slider_header'><i class='device_pic product_icon product-icon-"+serviceName.toLowerCase()+"'></i><span class='servicename'>"+serviceName+"</span><span class='close_btn close_icon' onclick='closeOrgSlide()'></span></div>");
	var icon_path = "";
	for(var path_count=1;path_count<=10;path_count++){
		icon_path=icon_path+"<span class='path"+path_count+"'></span>";		//No I18N
	}
	$("#close_acc_right_slider .product_icon").append(icon_path);
	$("#close_acc_right_slider").append("<div class='slider_sub_header'><span style='width:60%' class='sub_title'>"+i18nkeys['IAM.CLOSE.ACCOUNT.APP.SPECIFIC.ORG']+"</span><span class='title_zoid'>"+i18nkeys['IAM.APPID']+"</span></div><div id='slider_list_con'></div></div>");
	var serviceOrgData = "";
	if(closeAccServiceData.services){
		serviceOrgData = closeAccServiceData.services.SERVICEDETAILS[serviceName] != undefined ? closeAccServiceData.services.SERVICEDETAILS[serviceName] : closeAccServiceData.services.SERVICEDETAILS.bundle[serviceName];
	}
	var subscription_data = fromSubscription ? closeAccServiceData.subscriptions.SUBSCRIPTIONS[serviceName] : serviceOrgData;
	if($(ele).parents(".bundle_sub_service_list").length == 1){
		var temp_id_code = Object.keys(closeAccServiceData.services.SERVICEDETAILS.bundle[$(ele).parents(".bundle_cover_div").attr("id").split("bundle_")[1]])[0];
		subscription_data = closeAccServiceData.services.SERVICEDETAILS.bundle[$(ele).parents(".bundle_cover_div").attr("id").split("bundle_")[1]][temp_id_code].child_services[serviceName];
	}
	$("#close_acc_right_slider .slider_header .servicename").text(subscription_data.display_name != "" ? subscription_data.display_name : serviceName);
	for(var org in subscription_data){
		if(org != "display_name"){			
			$("#slider_list_con").append("<div class='portal_list' id='service_org_"+org+"'></div>");
			var serviceOrgName = subscription_data[org].org_name != undefined && subscription_data[org].org_name != "" ?  subscription_data[org].org_name : serviceName;
			var serviceOrgCreatedBy = subscription_data[org].created_by != undefined ? subscription_data[org].created_by : "";
			$("#service_org_"+org).html("<span class='detail_about_portal'><span class='portal_icon device_pic product_icon icon-morg'></span><span class='portal_detail'><span class='portal_name'>"+escapeHTML(serviceOrgName)+"</span><span class='portal_creator'>"+serviceOrgCreatedBy+"</span></span><span class='portal_zsiod'>"+org+"</span></span>");
		}
	}
}

function go_to_store(){
	window.open(closeAccServiceData.subscriptions.SUBSCRIPTIONS.service_url,"_blank");
}

function closeOrgSlide(){
	$("#close_acc_right_slider").removeClass("show_right_slide");
	$(".service_list_data,.sub_service_hidden_list").removeClass("service_selected");
}

function showBundleList(parent_ele){
	event.stopPropagation();
	$(parent_ele).parents(".bundle_cover_div").find(".bundle_sub_service_list").toggle(300);
}

var account_req_id;
function showCancelConfirm(title,desc,request_id){
	account_req_id = request_id;
	show_confirm(title,desc,function(){
		cancelCloseProcess(account_req_id);
	},function(){});
}
function initiateFinalStep(zid){
	$(".field_error").remove();
	if($(".close_service_form #delete_acc_reason").val() === null){
		$(".close_service_form #delete_acc_reason").parents(".textbox_div ").append( '<div class="field_error">'+i18nkeys['IAM.CLOSE.ACCOUNT.REASON.OPTION.ERROR']+'</div>');
		return false;
	}
	if($(".close_service_form .deleteacc_cmnd").val().trim() === ''){
		$(".close_service_form .deleteacc_cmnd").parents(".textbox_div ").append( '<div class="field_error">'+i18nkeys['IAM.CLOSE.ACCOUNT.FEEDBACK.ERROR']+'</div>');
		return false;
	}
	if(!$(".close_service_form #confirm_account_del").prop("checked")){
		if(isPersonalUser){
			$(".close_service_form #initiate_cls_button").before('<div class="field_error">'+i18nkeys['IAM.CLOSE.ACCOUNT.DATA.DELETE.ACCOUNT.CONCERN']+'</div>');
		}else{
			$(".close_service_form #initiate_cls_button").before('<div class="field_error">'+i18nkeys['IAM.CLOSE.ACCOUNT.DATA.DELETE.CONCERN']+'</div>');
		}
		return false;
	}
	var parms=
	{
		"reason":$(".close_service_form #delete_acc_reason").val(),		//No I18N
		"comments":$(".close_service_form .deleteacc_cmnd").val()		//No i18N
	};
	disabledButton('.close_service_form');				//No I18N
	var payload = NewCloseAccountsObj.create(parms);
	payload.PUT("self","self",zid).then(function(resp)	//No I18N
	{
		removeButtonDisable('.close_service_form');		//No I18N
		SuccessMsg(resp.localized_message);
		setTimeout(function(){
			go_to_link(resp.redirect_url,false);
		},getToastTimeDuration(resp.localized_message)+1000);
	},
	function(resp)
	{
		removeButtonDisable('.close_service_form');		//No I18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			redirectToReauth(resp.redirect_url);
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
	});
}
function showLength(ele){
	var limit = parseInt($(ele).attr("maxlength"));
	var cur_length = $(ele).val().length;
	if(limit === cur_length){
		$(ele).parents(".deleteacc_cmnd_parent").addClass("limit_alert");
	}
	else{
		$(".deleteacc_cmnd_parent").removeClass("limit_alert");
	}
	$(ele).siblings(".feedback_length").text(cur_length+"/"+limit);
}