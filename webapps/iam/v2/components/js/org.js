//$Id$
function loadDomains(Domain_detail){
	if(Object.keys(Domain_detail).length == 0 || (Object.keys(Domain_detail.verified).length == 0 && Object.keys(Domain_detail.unVerified).length == 0)){		
		$("#domain_content").hide();
		$("#no_domain").show();
		return false;
	}
	var verified_domain = Object.keys(Domain_detail.verified).sort(function(a,b){return ignoreCaseSensitive(a,b)});
	var unverified_domain = Object.keys(Domain_detail.unVerified).sort(function(a,b){return ignoreCaseSensitive(a,b)});
	var expired_domain = Object.keys(Domain_detail.expired).sort(function(a,b){return ignoreCaseSensitive(a,b)});
	var aboutToExpire_domain = Object.keys(Domain_detail.aboutToExpire).sort(function(a,b){return ignoreCaseSensitive(a,b)});
	
	$(".expired_domain,.abouttoexpire_domain,.unverified_domain,.verified_domain").text("");
	$("#domain_verify_warn").hide();
	var delete_prop;
	if(unverified_domain.length > 0  || expired_domain.length > 0 || aboutToExpire_domain.length > 0){
		$("#domain_verify_warn").show();
	}
	
	var count=0;
	for(var a in expired_domain){
		count++;
		$("#domain_content #domain_verify_warn").show();
		$("#domain_content .expired_domain").append("<div class='domain_tab domain_expired_"+count+"' >"+$(".domain_temp").html()+"</div>"); //No I18N
		$(".domain_expired_"+count+" .domain_name").text(expired_domain[a]);
		$(".domain_expired_"+count+" .email_dp").addClass(color_classes[gen_random_value()]);
		$(".domain_expired_"+count+" .reverify_button").attr("onclick","checkStatusBeforePopup('"+expired_domain[a]+"',2)");
		delete_prop = $('.domain_expired_'+count+' .delete_button').attr("onclick");
		delete_prop = delete_prop.split(");");
		delete_prop[0]+=",'"+expired_domain[a]+"');";
		$(".domain_expired_"+count+" .delete_button").hide();
		$(".domain_expired_"+count).attr("onclick","showMobileDomain(this,'"+expired_domain[a]+"',2)");
		$(".domain_expired_"+count+" .verify_button").remove();
	}
	var count=0;
	for(var a in aboutToExpire_domain){
		count++;
		$("#domain_content #domain_verify_warn").show();
		$("#domain_content .abouttoexpire_domain").append("<div class='domain_tab domain_abouttoexpire_"+count+"' >"+$(".domain_temp").html()+"</div>"); //No I18N
		$(".domain_abouttoexpire_"+count+" .domain_name").text(aboutToExpire_domain[a]);
		$(".domain_abouttoexpire_"+count+" .email_dp").addClass(color_classes[gen_random_value()]);
		$(".domain_abouttoexpire_"+count+" .abouttoexpire_content span").first().html(formatMessage(i18nSessionkeys["IAM.DOMAIN.ABOUT.TO.EXPIRE"], org_data.DOMAINDETAILS.aboutToExpire[aboutToExpire_domain[a]].expiryDate)); //No I18N
		//$(".domain_abouttoexpire_"+count+" .abouttoexpire_content .what_to_do").attr("onclick","checkStatusBeforePopup('"+aboutToExpire_domain[a]+"',1)");
		$(".domain_abouttoexpire_"+count+" .abouttoexpire_content .what_to_do").attr("onclick","showDomainVerifyPopup('"+aboutToExpire_domain[a]+"',1)");
		delete_prop = $('.domain_abouttoexpire_'+count+' .delete_button').attr("onclick");
		delete_prop = delete_prop.split(");");
		delete_prop[0]+=",'"+aboutToExpire_domain[a]+"');";
		$(".domain_abouttoexpire_"+count+" .delete_button").hide();
		$(".domain_abouttoexpire_"+count).attr("onclick","showMobileDomain(this,'"+aboutToExpire_domain[a]+"',1)");
		$(".domain_abouttoexpire_"+count+" .verify_button").remove();
		$(".domain_abouttoexpire_"+count+" .reverify_button").remove();
		
		if(isMobile){
			//$(".domain_abouttoexpire_"+count+" .domain_type .domain_tap_to_more").show();
			$(".domain_abouttoexpire_"+count+" .abouttoexpire_content .what_to_do").attr("onclick","mobilePopupCallback(function(){showDomainVerifyPopup('"+aboutToExpire_domain[a]+"',1)})");//No I18N
			$(".domain_abouttoexpire_"+count+" .abouttoexpire_content .what_to_do").hide();
		}
				
	}
	
	
	var count=0;
	for(var a in unverified_domain){
		count++;
		$("#domain_content .unverified_domain").append("<div class='domain_tab domain_unverified_"+count+"' >"+$(".domain_temp").html()+"</div>"); //No I18N
		$(".domain_unverified_"+count+" .domain_name").text(unverified_domain[a]);
		$(".domain_unverified_"+count+" .email_dp").addClass(color_classes[gen_random_value()]);
		$(".domain_unverified_"+count+" .verify_button").attr("onclick","showDomainVerifyPopup('"+unverified_domain[a]+"', 3)");
		delete_prop = $('.domain_unverified_'+count+' .delete_button').attr("onclick");
		delete_prop = delete_prop.split(");");
		delete_prop[0]+=",'"+unverified_domain[a]+"');";
		$(".domain_unverified_"+count+" .delete_button").attr("onclick",delete_prop[0]);
		$(".domain_unverified_"+count).attr("onclick","showMobileDomain(this,'"+unverified_domain[a]+"',3)");
		$(".domain_unverified_"+count+" .reverify_button").remove();
	}
	count=0;
	for(var a in verified_domain){
		count++;
		$("#domain_content .verified_domain").append("<div class='domain_tab domain_verified_"+count+"' >"+$(".domain_temp").html()+"</div>"); //No I18N
		$(".domain_verified_"+count+" .domain_name").text(verified_domain[a]);
		$(".domain_verified_"+count+" .email_dp").addClass(color_classes[gen_random_value()]);
		$(".domain_verified_"+count+" .verify_button").remove();
		$(".domain_verified_"+count+" .reverify_button").remove();
		$(".domain_verified_"+count+" .delete_button").remove();
	}
	if(isMobile){
		$(".domain_tab .action_icon").remove();
	}
	else{		
		tooltipSet(".domain_tab .delete_button"); //No I18N
	}
	$(".verified_domain .ver_content").show();
	$(".unverified_domain .unver_content").show();
	$(".expired_domain .expired_content").show();
	$(".abouttoexpire_domain .abouttoexpire_content").show();
}

function showMobileDomain(ele,domain, domainType, isRenewed){
	if(isMobile){
		popup_blurHandler('6');
		var delete_prop;
		$("#domain_popup_for_mobile").show(0,function(){
			$("#domain_popup_for_mobile").addClass("pop_anim");		
		});
		$("#domain_popup_for_mobile .popuphead_details").html("");
		$("#domain_popup_for_mobile .popuphead_details").append($(ele).find(".email_dp")[0].outerHTML);
		$("#domain_popup_for_mobile .popuphead_details").append($(ele).find(".domain_info")[0].outerHTML);
		if(domainType == 2){	// Already expired case	
			if(org_data.DOMAINDETAILS.expired[domain] != undefined){
					$("#domain_popup_for_mobile #btn_to_verify").hide();
					$("#domain_popup_for_mobile #btn_to_reverify").show();
					$("#domain_popup_for_mobile #btn_to_reverify").attr("onclick","mobilePopupCallback(function(){checkStatusBeforePopup('"+domain+"','"+domainType+"')})");//No I18N
			}
		} else if(domainType == 1){ // About to expire case
			if(org_data.DOMAINDETAILS.aboutToExpire[domain] != undefined){				
				$("#domain_popup_for_mobile #btn_to_verify").hide();
				$("#domain_popup_for_mobile #btn_to_reverify").hide();
				$("#domain_popup_for_mobile .popuphead_details .abouttoexpire_content .what_to_do").show();
				$("#domain_popup_for_mobile #btn_to_reverify").attr("onclick","mobilePopupCallback(function(){checkStatusBeforePopup('"+domain+"','"+domainType+"')})");//No I18N
			}
		} else { //Unverified case
			var isVerified = org_data.DOMAINDETAILS.unVerified[domain] != undefined ? false : true;
			if(!isVerified){
					$("#domain_popup_for_mobile #btn_to_reverify").hide();
					$("#domain_popup_for_mobile #btn_to_verify").show();
					$("#domain_popup_for_mobile #btn_to_verify").attr("onclick","mobilePopupCallback(function(){showDomainVerifyPopup('"+domain+"','"+domainType+"')})");//No I18N
			}
		}
		
		delete_prop = $('#domain_popup_for_mobile #btn_to_delete_domain').attr("onclick");
		delete_prop = delete_prop.split(")");
		delete_prop[0]+=",'"+domain+"');";
		$("#domain_popup_for_mobile #btn_to_delete_domain").attr("onclick","mobilePopupCallback(function(){"+delete_prop[0]+"},true)");//No I18N
		$("#domain_popup_for_mobile #btn_to_delete_domain").show();
		closePopup(close_domain_mobile_specific,"domain_popup_for_mobile");//No I18N
		
	}
}
function mobilePopupCallback(callback,resetOnclick){
	if(resetOnclick){
		var onclickValue = callback.toLocaleString();
		onclickValue = onclickValue.slice(onclickValue.indexOf('()')+3);
		onclickValue = onclickValue.split(',');
		onclickValue = onclickValue[0]+","+onclickValue[1]+");";
		$("#domain_popup_for_mobile #btn_to_delete_domain").attr('onclick',onclickValue);
	}
	$("#domain_popup_for_mobile").removeClass("pop_anim");
	$("#domain_popup_for_mobile").fadeOut(200,function(){
		callback();
	});
}

function close_domain_mobile_specific(){
	popupBlurHide("#domain_popup_for_mobile"); //No I18N
}

function checkStatusBeforePopup(domain, domainType){
	var payload;
	if(domainType == 2){ // Already expired case, check status first with domaintype = 0
		payload = DomainObj.create({"domain_type": 0});//No I18N
	} else { //About to expire case
		payload = DomainObj.create({"domain_type": 1});//No I18N
		disabledButton("#verify_domain .abtToExpireDomain_content");
	}
	
	payload.build();
	
	$(".reverify_button").attr("disabled", "disabled").addClass("button_disable");
	payload.PUT("self",domain).then(function(resp)	//No I18N
	{			
		if(resp.code=="DOMAIN202" && domainType==1){
			org_data.DOMAINDETAILS.verified[domain]=org_data.DOMAINDETAILS.aboutToExpire[domain]
			delete org_data.DOMAINDETAILS.aboutToExpire[domain];
			showDomainRenewedSuccess();	
			return;
		}
		$(".reverify_button").removeAttr("disabled").removeClass("button_disable");
		showDomainVerifyPopup(domain, domainType, true);
	},
	function(resp)
	{
		$(".reverify_button").removeAttr("disabled").removeClass("button_disable");
		removeButtonDisable("#verify_domain .abtToExpireDomain_content"); //No I18N
		
		if(resp.cause && resp.cause.trim() === "invalid_password_token"){
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N
		} else {
			if(resp.errors[0].code=="DOMAIN203" && domainType==2){  // Domain purchase extention needed case
				showDomainVerifyPopup(domain, domainType, false);
			} else if(resp.errors[0].code=="DOMAIN203" && domainType==1){
				showErrorMessage(getErrorMessage(resp));				
			} else if(resp.errors[0].code=="DOMAIN500"){
				$(".domain_err_content").html(resp.localized_message);
				$(".domain_err_content").show();
				var errHeight= $(".domain_err_content")[0].scrollHeight + $('#verify_domain .popup_header')[0].scrollHeight+$('.verify_option')[0].scrollHeight+$('.dom_verify_actions')[0].scrollHeight;
				errHeight= !isMobile ? errHeight+90 : errHeight+64;
				$(".domain_err_content").hide()
				$(".domain_err_content").slideDown(200);
				$(".step_box:visible").css("max-height","calc(100% - "+(errHeight)+"px)"); //No I18N
			} else {
				showErrorMessage(getErrorMessage(resp));
			}						
		}
	});	
}

function showDomainVerifyPopup(domain, domainType, isRenewed){	
	$(".domain_err_content").hide();
	$("#verify_domain").show(0,function(){
		$("#verify_domain").addClass("pop_anim");
	});
	var data;
	popup_blurHandler('6');
	$("#verify_domain").focus();
	if(domainType == 2){	// Already expired case	
		$("#verify_domain .popuphead_text").html(i18nSessionkeys["IAM.ORG.DOMAIN.EXPIRED.POPUP.HEADER"]); //No I18N		
		$("#verify_domain .expiredDomain_content").show();
		$("#verify_domain_action span").html(i18nSessionkeys["IAM.REVERIFY.NOW"]); //No I18N
		if(!isRenewed){
			disabledButton("#verify_domain .expiredDomain_content");
			$("#expired_domain_action").addClass("remove_after");
			//$("#verify_domain .expiredDomain_content #expired_domain_action").attr("disabled", "disabled");
		} else {
			//$("#verify_domain .expiredDomain_content #expired_domain_action").removeAttr("disabled");
			removeButtonDisable("#verify_domain .expiredDomain_content"); //No I18N			
		}
		data = org_data.DOMAINDETAILS.expired[domain];		
	} else if(domainType == 1){ // About to expire case
		$("#verify_domain .popuphead_text").html(i18nSessionkeys["IAM.ORG.DOMAIN.ABOUT.EXPIRE.POPUP.HEADER"]); //No I18N		
		$("#verify_domain .abtToExpireDomain_content").show();
		$("#verify_domain .abtToExpireDomain_content #abtToExpire_domain_action").attr("onclick","checkStatusBeforePopup('"+domain+"','"+domainType+"')");
		$("#verify_domain_action span").html(i18nSessionkeys["IAM.REVERIFY.NOW"]); //No I18N
		data = org_data.DOMAINDETAILS.aboutToExpire[domain];
		return;
	} else { //Unverified case
		$("#verify_domain .popuphead_text").html(i18nSessionkeys["IAM.ORG.DOMAIN.POPUP.HEADER"]); //No I18N 		
		$("#verify_domain .verifyDomain_content").show();		
		$("#verify_domain_action span").html(i18nSessionkeys["IAM.VERIFY.NOW"]); //No I18N	
		data = org_data.DOMAINDETAILS.unVerified[domain] != undefined ? org_data.DOMAINDETAILS.unVerified[domain] : org_data.DOMAINDETAILS.verified[domain];		
	}
	
	
	$(".domain_options #txt").click();
	$(".domainNameWithContent").text(domain);
	//var data = org_data.DOMAINDETAILS.unVerified[domain] != undefined ? org_data.DOMAINDETAILS.unVerified[domain] : org_data.DOMAINDETAILS.verified[domain];
	var html_name = data.html.url.split("/")[data.html.url.split("/").length-1];
	$(".html_content .domain_html").text(html_name);
	$(".html_content .url_examp").text(data.html.url);
	$(".html_domain_box").attr("onclick","downloadFile('"+html_name+"','"+data.html.Vcode+"')");//No I18N
	$(".cname_content .host_name").text(data.cname.host);
	$(".cname_content .host_value").text(data.cname.destination);
	
	$(".txt_content .host_value").text(data.txt);
	$("#verify_domain .blue").attr("title",err_app_pass_copied);
	tippy("#verify_domain .blue",{//No I18N
		trigger:"click",//No I18N
		arrow:true,
		hideOnClick: false, // if you want
		onShow(instance) {
		   setTimeout(function() {
		     instance.hide();
		   }, 800);
		}
	});
	$("#verify_domain #verify_domain_action").attr("onclick","verifyTheDomain('"+domain+"','"+domainType+"')");
	closePopup(close_domain_edit,"verify_domain");//No I18N
	changeDomainOption($(".domain_options #txt"));
}

function taketoVerify(){
	$("#verify_domain .expiredDomain_content").hide();
	$("#verify_domain .abtToExpireDomain_content").hide();
	$("#verify_domain .verifyDomain_content").show();
}

function showDomainRenewedSuccess(){
	$("#verify_domain .expiredDomain_content").hide();
	$("#verify_domain .abtToExpireDomain_content").hide();
	$("#verify_domain .verifyDomain_content").hide();
	$("#verify_domain .popup_header").hide();
	//$("#verify_domain").css({"width":"540px","min-width":"540px"});
	$("#verify_domain .renewed_success_content").show();	
	loadDomains(org_data.DOMAINDETAILS);
}

/*function showDomainReVerifyPopup(domain){
	$(".domain_err_content").hide();
	$("#reverify_domain").show(0,function(){
		$("#reverify_domain").addClass("pop_anim");
	});
	popup_blurHandler('6');
	
	$(".domainNameWithContent").text(domain);	
	
	$("#reverify_domain #expired_domain_action").attr("onclick","close_reverify_domain();showDomainVerifyPopup('"+domain+"')");
	closePopup(close_reverify_domain,"reverify_domain");//No I18N	
	$("#reverify_domain").focus();
}*/

function ignoreCaseSensitive(a,b){
	  var nameA = a.toUpperCase();
	  var nameB = b.toUpperCase();
	  if (nameA < nameB) {
	    return -1;
	  }
	  if (nameA > nameB) {
	    return 1;
	  }
	  return 0;
}



function clickToCopy(tippyTarget,copyTarget){
	var range = document.createRange();
    range.selectNode(document.getElementById(copyTarget));
    window.getSelection().removeAllRanges();
    window.getSelection().addRange(range);
    document.execCommand("copy");//No I18N
    window.getSelection().removeAllRanges();  
}
function close_domain_edit(){
	popupBlurHide("#verify_domain",function(){	//No I18N
		remove_error();
		removeButtonDisable("#verify_domain");	//No I18N
	});
	$("#verify_domain .popup_header").show();
	$("#verify_domain .expiredDomain_content").hide();
	$("#verify_domain .abtToExpireDomain_content").hide();
	$("#verify_domain .verifyDomain_content").hide();
	$("#verify_domain .renewed_success_content").hide();	
}
function close_reverify_domain(){
	popupBlurHide("#reverify_domain",function(){	//No I18N
		remove_error();
		removeButtonDisable("#reverify_domain");	//No I18N
	});
}
function changeDomainOption(ele){
	var id = $(ele).attr("id");
	$(".step_box").hide();
	$(".domain_err_content").hide();
	$("."+$(ele).attr("id")+"_content").show();
	if($(ele).attr("id")=="html"){
		$(".verify_option_detail .domain_info_content").hide();
	} else if(id == "txt"){ //No I18N
		$(".verify_option_detail .domain_info_content").show();
		$(".verify_option_detail .domain_info_content").html(i18nSessionkeys["IAM.ORG.DOMAIN.POPUP.TEXT.FOOTER"]); //No I18N
	} else {
		$(".verify_option_detail .domain_info_content").show();
		$(".verify_option_detail .domain_info_content").html(i18nSessionkeys["IAM.ORG.DOMAIN.POPUP.CNAME.FOOTER"]); //No I18N
	}
	//setDomainPopHeight();
}
function setDomainPopHeight(){
	$(".step_box:visible").css("max-height","unset");
	$(".verify_option_detail").css("height",$("#verify_domain").height()+"px");//No I18N
	if(isMobile){
		$("#verify_domain").css("height",312+$(".step_box:visible")[0].scrollHeight+"px");
	}else{
		$("#verify_domain").css("height",298+$(".step_box:visible")[0].scrollHeight+"px");
	}
	var errHeight= $(".domain_err_content")[0].scrollHeight + $('#verify_domain .popup_header')[0].scrollHeight+$('.verify_option')[0].scrollHeight+$('.dom_verify_actions')[0].scrollHeight;
	errHeight= !isMobile ? errHeight+70 : errHeight+44;
	$(".step_box").css("max-height","calc(100% - "+(errHeight)+"px)"); //No I18N
}
function verifyTheDomain(domain, domainType){
	$(".domain_err_content").hide();
	setDomainPopHeight();

	var payload = DomainObj.create({"type":$(".domain_options").find("input:checked").val(), "domain_type": domainType});//No I18N
	payload.build();
	disabledButton("#verify_domain");	//No I18N
	payload.PUT("self",domain).then(function(resp)	//No I18N
	{
		removeButtonDisable("#verify_domain");	//No I18N
		org_data.DOMAINDETAILS.verified[domain]=org_data.DOMAINDETAILS.unVerified[domain]
		delete org_data.DOMAINDETAILS.unVerified[domain];
		SuccessMsg(getErrorMessage(resp));
		close_domain_edit();
		loadDomains(org_data.DOMAINDETAILS);
	},
	function(resp)
	{
		removeButtonDisable("#verify_domain");	//No I18N
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			if(resp.errors[0].code=="DOMAIN500"){
				$(".domain_err_content").html(resp.localized_message);
				$(".domain_err_content").show();
				var errHeight= $(".domain_err_content")[0].scrollHeight + $('#verify_domain .popup_header')[0].scrollHeight+$('.verify_option')[0].scrollHeight+$('.dom_verify_actions')[0].scrollHeight;
				errHeight= !isMobile ? errHeight+90 : errHeight+64;
				$(".domain_err_content").hide()
				$(".domain_err_content").slideDown(200);
				$(".step_box:visible").css("max-height","calc(100% - "+(errHeight)+"px)"); //No I18N
			}
			else{
				showErrorMessage(getErrorMessage(resp));
			}
		}
	});	
}

function deleteDomain(title,delete_descrtion,domain){
	show_confirm(title,formatMessage(delete_descrtion, domain),
		    function() 
		    {
				new URI(DomainObj,"self",domain).DELETE().then(function(resp)	//No I18N
						{
							SuccessMsg(getErrorMessage(resp));
							delete org_data.DOMAINDETAILS.unVerified[domain];
							loadDomains(org_data.DOMAINDETAILS);
						},
						function(resp)
						{
							if(resp.cause && resp.cause.trim() === "invalid_password_token") 
							{
								relogin_warning();
								var service_url = euc(window.location.href);
								$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
							}
							else
							{
								showErrorMessage(getErrorMessage(resp));
							}
						});
		    },function(){
		    	return false;
		    }
	);
}
/*********************************SAML***************************************/

function load_samldetails(SAML_details)
{
	if(de("saml_exception"))
	{
		$("#saml_exception").remove();
	}
	if(SAML_details.exception_occured!=undefined	&&	SAML_details.exception_occured)
	{
		$("#saml_box .box_info" ).after("<div id='saml_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#saml_exception #reload_exception").attr("onclick","reload_exception(SAML,'saml_box')");
		return;
	}
	
	if(SAML_details!=undefined)
	{	
		if(SAML_details.issaml_loginenabled)
		{
			$("#saml_notActivated").hide();
			$("#saml_activated").show();
			$("#saml_info_show").show();
//			$(".saml-setup_info").show();
			
			if(SAML_details.issaml_enabled)
			{
				$("#toggle_saml").attr("checked","checked");
				if(SAML_details.issaml_logoutEnabled)
				{
					$("#saml_logout_check").attr("checked","checked");
					$("#edit_logout_url").removeAttr("data-optional");
				}
				else
				{
					$("#saml_logout_check").removeAttr("checked");
					$("#edit_logout_url").attr("data-optional","true");
				}
				
			}
			else
			{
				$("#toggle_saml").removeAttr("checked");
				$("#saml_logout_check").removeAttr("checked");
			}
			
			$("#saml_info_show #login_url").html(SAML_details.saml_login_url);
			$("#saml_info_show #logout_url").html(SAML_details.saml_logout_url);
			$("#saml_info_show #password_url").html(SAML_details.saml_password_url);
			$("#saml_info_show #saml_algorithm").html(SAML_details.saml_algorithm);
			$("#saml_info_show #SAMLservice_name").html(SAML_details.saml_service);
			
			
			$("#edit_login_url").val(SAML_details.saml_login_url);
			$("#edit_logout_url").val(SAML_details.saml_logout_url);
			$("#edit_password_url").val(SAML_details.saml_password_url);
			if(SAML_details.issaml_logoutEnabled && SAML_details.issaml_enabled)
			{
				$("#downalod_logout_response").show();
			}
			else
			{
				$("#downalod_logout_response").hide();
			}
			$('#edit_saml_algorithm option[value='+SAML_details.saml_algorithm+']').prop('selected', true);
			$('#edit_SAMLservice_name option[value='+SAML_details.saml_service+']').prop('selected', true);
			
			if(SAML_details.issaml_jit_enabled)
			{
				$("#SAML_JIT_indicator").show();
				
				$("#saml_jit_check").attr("checked","checked");
				$("#saml_JIT_fields").html("");
				$("#saml_JIT_fields").show();
				if(SAML_details.jit_attributes)
				{
					if(SAML_details.jit_attributes.first_name)
					{
						init_jit_fields();
						$("#saml_JIT_fields select:last").val("first_name");
						$("#saml_JIT_fields .inputText:last input")[0].name="first_name";
						$("#saml_JIT_fields .inputText:last input")[0].value=SAML_details.jit_attributes.first_name;
					}
					if(SAML_details.jit_attributes.last_name)
					{
						init_jit_fields();
						$("#saml_JIT_fields select:last").val("last_name");
						$("#saml_JIT_fields .inputText:last input")[0].name="last_name";
						$("#saml_JIT_fields .inputText:last input")[0].value=SAML_details.jit_attributes.last_name;
					}
					if(SAML_details.jit_attributes.display_name)
					{
						init_jit_fields();
						$("#saml_JIT_fields select:last").val("display_name");
						$("#saml_JIT_fields .inputText:last input")[0].name="display_name";
						$("#saml_JIT_fields .inputText:last input")[0].value=SAML_details.jit_attributes.display_name;
					}
					$("#saml_JIT_fields .saml_jit_select").select2();
				}
				else
				{
					init_jit_fields();
				}
				
			}
			else
			{
				$("#SAML_JIT_indicator").hide();
			}
			
		}
		else
		{
			$("#samlform")[0].reset();
			$("#saml_info_show").hide();
			$(".saml-setup_info").hide();
			$("#saml_notActivated").show();
			$("#saml_notActivated .no_data_text").html(formatMessage(saml_setup_description,SAML_details.org_name));	
			$("#saml_activated").hide();
		}
		
		//moved to template resource
//		var services=Object.keys(SAML_details.services);
//		$('#edit_SAMLservice_name').find('option').remove();
//		for(iter=0;iter<services.length;iter++)
//		{
//			var current_service=SAML_details.services[services[iter]];
//			$("#edit_SAMLservice_name").append("<option value="+current_service.servicename+">"+current_service.displayname+"</option>");
//		}
	}
}


function updateSaml(f) 
{
	assignHash("setting", "org_saml");//No I18N
	if(validateForm(f))
	{
		var login_url = f.login_url.value.trim();
		var logout_url = f.logout_url.value.trim();
		var change_pwd_url = f.password_url.value.trim();
		var servicename=f.service[f.service.selectedIndex].value.trim();
		var algorithm =f.algorithm[f.algorithm.selectedIndex].value.trim();
		var public_key = f.publickey.value.trim();
		var publickey_upload = f.publickey_upload.value;
		var logout_check=$('#saml_logout_check').prop('checked');
		var enable_saml_jit=$('#saml_jit_check').prop('checked');
	    
	    
			if(enable_saml_jit)
			{
				if(f.first_name && f.first_name.length>1)
				{
					showErrorMessage(saml_jit_duplicate);
					return false;
				}
				if(f.last_name && f.last_name.length>1)
				{
					showErrorMessage(saml_jit_duplicate);
					return false;
				}
				if(f.display_name && f.display_name.length>1)
				{
					showErrorMessage(saml_jit_duplicate);
					return false;
				}
			}
			var lastname = f.last_name?f.last_name.value:"" ;
			var firstname = f.first_name?f.first_name.value:"";
			var displayname = f.display_name?f.display_name.value:"";
		   disabledButton(f);
		   if(isEmpty(public_key) && isEmpty(publickey_upload)) 
		   {
			   showErrorMessage(err_samlsetup_enter_publickey);
			   removeButtonDisable(f);
		    	f.saml_publickey.focus();
		   }
		   else
		   {
				var parms=
				{
						"login_url":login_url,//No I18N
						"logout_url":logout_url,//No I18N
						"password_url":change_pwd_url,//No I18N
						"publickey":public_key,//No I18N
						"algorithm":algorithm,//No I18N
						"service":servicename,//No I18N
						"enable_saml_logout":logout_check,//No I18N
						"enable_saml_jit":enable_saml_jit,//No I18N
						"last_name":lastname,//No I18N
						"first_name":firstname,//No I18N
						"display_name":displayname,//No I18N
						"__form":$('#'+f.id)//No I18N	
				};
				
				var payload = SAMLObj.create(parms);
				payload.build();
				payload.POST("self").then(function(resp)	//No I18N
				{
					SuccessMsg(getErrorMessage(resp));
					org_data.SAML.issaml_loginenabled=true;
					org_data.SAML.issaml_enabled=true;
					org_data.SAML.issaml_logoutEnabled=logout_check;
					
					org_data.SAML.saml_login_url=login_url;
					org_data.SAML.saml_logout_url=logout_url;
					org_data.SAML.saml_password_url=change_pwd_url;
					org_data.SAML.saml_algorithm=algorithm;
					org_data.SAML.saml_service=servicename;
					if(enable_saml_jit)
					{
						org_data.SAML.issaml_jit_enabled=true;
						org_data.SAML.jit_attributes={};	
						if(firstname)
						{
							org_data.SAML.jit_attributes.first_name=firstname;
						}
						if(lastname)
						{
							org_data.SAML.jit_attributes.last_name=lastname;
						}
						if(displayname)
						{
							org_data.SAML.jit_attributes.display_name=displayname;
						}
					}
					else
					{
						org_data.SAML.issaml_jit_enabled=false;
					}
	
					load_samldetails(org_data.SAML);
					close_SAML_edit();
					removeButtonDisable(f);
				},
				function(resp)
				{
					removeButtonDisable(f);
					if(resp.cause && resp.cause.trim() === "invalid_password_token") 
					{
						relogin_warning();
						var service_url = euc(window.location.href);
						$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
					}
					else
					{
						showErrorMessage(getErrorMessage(resp));
					}
				});	
	   		
		   }
	   }
    return false;
}

function updateSamlStatus(f) 
{
	var enablesaml =$('#toggle_saml').is(":checked");
	if(enablesaml!=null)
	{
		var parms=
		{
				"saml_status":enablesaml//No I18N
		};
		
		var payload = SAMLObj.create(parms);
		payload.build();
		payload.PUT("self").then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));
			org_data.SAML.is_saml_enabled = enablesaml;
			loadSamlDetails(org_data.SAML);
		},
		function(resp)
		{
			$('#toggle_saml').prop("checked", enablesaml ? false : true);
			if(resp.cause && resp.cause.trim() === "invalid_password_token") 
			{
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			}
			else
			{
				showErrorMessage(getErrorMessage(resp));
			}
		});	
		
	}
	else
	{
		return false;
    }
}

function show_jit_fields()
{
	if($('#saml_jit_check').is(":checked"))
	{
		$("#saml_JIT_fields").html("");
		$("#saml_JIT_fields").show();
		init_jit_fields();
	}
	else
	{
		$("#saml_JIT_fields").hide();
		$("#saml_JIT_fields").html("");
	}
	return;
}

function change_logout_response()
{
	if($('#saml_logout_check').is(":checked"))
	{
		$("#edit_logout_url").removeAttr("data-optional");
	}
	else
	{
		$("#edit_logout_url").attr("data-optional","true");
	}
	return;
}

function init_jit_fields()
{
	var JIT_var=[];
	$("#empty_jit_fields_format .saml_jit_select option").each(function()
	{
		JIT_var.push($(this).val());
	});
	
	if($("#saml_JIT_fields").children().length<JIT_var.length)
	{
		$("#empty_jit_fields_format").children().clone().appendTo("#saml_JIT_fields"); //No I18N
    	if($("#saml_JIT_fields .inputText").children().hasClass("saml_jit_fieldaction"))
    	{
    		$("#saml_JIT_fields .saml_jit_fieldaction").remove();
    	}
    	$("#saml_JIT_fields .inputText").not(":last").append(" <div class='saml_jit_fieldaction icon-cadd remove_field' onclick='removeEle(this)'></div>");
    	$("#saml_JIT_fields .inputText:last").append("<div class='saml_jit_fieldaction icon-cadd add_field' onclick='init_jit_fields()'></div>");
    	if($("#saml_JIT_fields").children().length==3)
    	{
        	$("#saml_JIT_fields .inputText:last .add_field").remove();
    	}
    	for(i=0;i<JIT_var.length;i++)
    	{
    		if($("#samlform input[name="+JIT_var[i]+"]").length==0)
    		{
    			$("#saml_JIT_fields select:last").val(JIT_var[i]);
				$("#saml_JIT_fields .inputText:last input")[0].name=JIT_var[i];
				break;
    		}
    	}
    	
    	$("#saml_JIT_fields .saml_jit_select").select2({
    		minimumResultsForSearch: Infinity,
    		theme:"saml" //No I18N
    	});
	}
	$("#saml_set").scrollTop($("#saml_set")[0].scrollHeight);
}

function inputName(ele)
{
	  $(ele).parents(".field").find(".namebox").attr("name",$(ele).val()); //No I18N
}

function removeEle(ele)
{
	$(ele).parents(".field").remove();
  	if($("#saml_JIT_fields .inputText").children().hasClass("saml_jit_fieldaction"))
	{
		$("#saml_JIT_fields .saml_jit_fieldaction").remove();
	}
	$("#saml_JIT_fields .inputText").not(":last").append(" <div class='saml_jit_fieldaction icon-cadd remove_field' onclick='removeEle(this)'></div>");
	$("#saml_JIT_fields .inputText:last").append("<div class='saml_jit_fieldaction icon-cadd add_field' onclick='init_jit_fields()'></div>");
}


function showSamlsetupOption() 
{
	
		$(".saml_opendiv").show(0,function(){
			$(".saml_opendiv").addClass("pop_anim");
		});
		closePopup(close_SAML_edit,"saml_open_cont");//No I18N
		popup_blurHandler('6');
		if(!isMobile){			
			$("#edit_saml_algorithm").select2({
				minimumResultsForSearch: Infinity
			});
			$("#edit_SAMLservice_name").select2({
				language: {
			        noResults: function(){
			            return iam_no_result_found_text;
			        }
			    },
			    escapeMarkup: function (m) {
			    	return m;
			    }
			 }).on("select2:open", function(){
				 $(".select2-search__field").attr("placeholder", iam_search_text);//No I18N
			 });
		}
		$("#saml_open_cont input:first").focus();//No I18N
}

function showSamlDownloadDropDown() {
	$(".saml-download_lists").toggle();
}

function closeSamlsetupMenu()
{
	popupBlurHide();
	$(".saml-setup_menu").removeClass("show-saml-setup");
	$('body').css({
	    overflow: 'auto'//No i18N
	});
	var blurTimeOut = setInterval(function(){
		$(".blur").css("z-index","-1");
		clearTimeout(blurTimeOut);	
	},300);
	$(".saml-setup_menu").removeClass("samlEdited1 samlEdited2 samlEdited3");
	$('#saml-setup_menu').unbind();
	$(".isSamlEdited").unbind();
	$("#saml-publickey_upload").unbind();
	removePublickeyError();
	resetSamlSetupMenu();
	enableSamlSubmitBtn();
	return false;
}

function showSamlsetupMenu()
{
	remove_error();
	popup_blurHandler('6');
	$(".saml-setup_menu").addClass("show-saml-setup");
	$(".saml-setup_menu").focus();
	$(".saml-setup__body").scrollTop(0);
	closePopup(closeSamlsetupMenu,"saml-setup_menu");//No I18N
	if(!isMobile){
			$(".saml-name-identifier").select2({
				minimumResultsForSearch: Infinity,
				theme: "saml-name-identifier" //no I18N
			});
			$(".saml-signin__list, .saml-signout__list").select2({	
			minimumResultsForSearch: Infinity,
			theme: "samlSignList" //no I18N
		});
		$("#edit-SAMLservice_name").select2({
			templateResult: function(option){
				var ob,service;
				service = $(option.element).attr("value");
				var serviceDisplayName = $(option.element).text();
				serviceDisplayName = serviceDisplayName ? serviceDisplayName : service;
				if(service){
					ob = '<i class="service_icon product_icon product-icon-'+service.toLowerCase().replace(/\s/g, '')+'" ><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span><span class="path11"></span><span class="path12"></span><span class="path13"></span><span class="path14"></span><span class="path15"></span><span class="path16"></span></i><span class="org_name">'+serviceDisplayName+"</span>" ;
				}
				return ob;
			},
			templateSelection: function(option){
				var service = $(option.element).attr("value");
				var serviceDisplayName = $(option.element).text();
				serviceDisplayName = serviceDisplayName ? serviceDisplayName : service;
	              $(option.element).addClass("service_icon product_icon product-icon-"+service.toLowerCase().replace(/\s/g, ''));
	              samlSetServiceIcon(option.element,$("#edit-SAMLservice_name+.select2"));
	              return serviceDisplayName;
			},
			theme: "saml-setup-service", //no I18N
			escapeMarkup: function (m) { //this function used to convert return string to html element
			       return m;
			}
		});
		$("#edit-SAMLservice_name+.select2 .select2-selection").append("<i id='saml_setup_service' class='selectedService'><span class='path1'></span><span class='path2'></span><span class='path3'></span><span class='path4'></span><span class='path5'></span><span class='path6'></span><span class='path7'></span><span class='path8'></span><span class='path9'></span><span class='path10'></span></i>");
		samlSetServiceIcon($("#edit-SAMLservice_name option:selected"),$("#edit-SAMLservice_name+.select2"));
	}
	$(".saml-setup__modes .params_select").select2({
		minimumResultsForSearch: Infinity,
		theme: "saml-sign__param" //no I18N
	});
	$(".saml-setup__modes .saml-setup__JIT-select").select2({
		minimumResultsForSearch: Infinity,
		theme: "saml-JIT__select" //no I18N
	});
	$("#saml-generate-key").parent().show();
	if(org_data.SAML.has_sp_certificate){
		$("#saml-generate-key").parent().hide();
	}
	$(".saml-setup__modes .mode_description_warning, .mode_description_warning .warning_message1,.mode_description_warning .warning_message2").hide();
	$("#saml-jit .mode_message").css("cursor","pointer");
	if(jQuery.isEmptyObject(org_data.DOMAINDETAILS.verified)) {
		$(".saml-JIT-btn").prop("disabled",true);
		$(".saml-setup__modes .mode_description_warning").show();
		$("#saml-jit .mode_message").css("cursor","not-allowed");
		if(org_data.SAML.issaml_jit_enabled){
			org_data.SAML.issaml_jit_enabled = false;
			delete org_data.SAML.jit_attributes;
		}
		if(jQuery.isEmptyObject(org_data.DOMAINDETAILS.verified) && jQuery.isEmptyObject(org_data.DOMAINDETAILS.unVerified)){
			$(".mode_description_warning .warning_message1").show();
		}
		else{
			$(".mode_description_warning .warning_message2").show();
		}
	}	
		$("#saml-upload-input").change(function(){
			if($(this)[0].files[0]){
				try {
					var fileName = ($(this)[0].files[0]).name;
					if(!isValidMetaDatafile(fileName)) {
						throw i18nSamlsetupKeys['IAM.SAMLSETUP.INVALID.METADATA.FILE'];  //no I18N
					}
					var fr=new FileReader();
			        fr.onload=function(){
			            if(fillSamlMetadata(fr.result)){
							$(".saml-setup__update-message .saml_message_head").text(fileName);
						}
			        }    
			        fr.readAsText($(this)[0].files[0]);
				}
		        catch(err){
		    		showErrorMessage(err);
		    		$("#saml-upload-input").val("");
		    	}		
			}
		});
		applySamlPublicKeyuploadEvent();
	return false;	
}

function applySamlPublicKeyuploadEvent(){
	$("#saml-publickey_upload").change(function () 
	{
		try {
			if($(this).val()){
				if(!isValidPublicKeyFile(($(this)[0].files[0]).name)) {
					throw i18nSamlsetupKeys['IAM.SAMLSETUP.INVALID.CERTIFICATE.FILE'];  //no I18N
				}
				$("#saml-filename").val($("#saml-publickey_upload").prop("files")[0].name);
				$("#saml-file_space").show();
				$("#saml-publickey").hide();
				$(".saml-setup__forms .close-circle").show();
			}
		}
		catch(err) {
			showErrorMessage(err);
		}
		return;
	});
	return;
}

function isValidMetaDatafile(fileName){
	var re = /(\.xml)$/i;
	return re.exec(fileName);
}

function samlSetServiceIcon(ele,selectEle) {
	  var service = $(ele).attr("value");
	  if(service) {
	     $(selectEle).find(".selectedService").attr("class","selectedService product_icon product-icon-"+service.toLowerCase().replace(/\s/g, ''));
	  }
	  return false;
}

function resetSamlSetupMenu() {
	removeMetadata();
	removePublicKey();
	$(".saml-setup__mode-label").each(function() {
		if($(this).find(".real_togglebtn").prop("checked")){
			$(this)[0].click();
		}
	});
	return false;
}


//  SAML values validation and request call to server
function submitSamlsetupMenu()
{
	remove_error();
	assignHash("org", "org_saml");//No I18N
	var samlSetupFormContainer = $(".saml-setup__form-container")[0];
	var samlSetupForm = $("#saml-setup-form")[0];
	var signinUrl = samlSetupForm.querySelector(".saml-login-url");//No I18N
	var signoutUrl = samlSetupForm.querySelector(".saml-logout-url");//No I18N
	var nameIdentifier = samlSetupForm.querySelector(".saml-name-identifier");//No I18N
	var samlPublicKey = samlSetupForm.querySelector(".saml-publickey");//No I18N
	var submitBtn = samlSetupFormContainer.querySelector(".submitSamlBtn");//No I18N
	
	
	var signinUrlValue = signinUrl.value.trim();
	var signoutUrlValue = signoutUrl.value.trim();
	var login_binding = parseInt($(".saml-signin__list").find("option:selected").attr("id-value"));
	var logout_binding = parseInt($(".saml-signout__list").find("option:selected").attr("id-value"));
	var serviceValue = samlSetupFormContainer.service[samlSetupFormContainer.service.selectedIndex].value;
	var nameIdentifierIdValue = parseInt($(nameIdentifier).find("option:selected").attr("id-value"));
	var samlPublicKeyValue = samlPublicKey.value.trim();
	var samlPublicKeyFileValue = samlSetupForm.querySelector('#saml-publickey_upload').value; //No I18N
	var signinUsername="";
	var signinEmailaddress="";
	var signoutUsername="";
	var signoutEmailaddress="";
	var enable_saml_encryption = false;
	var generate_sp_cert = false;
	var enable_saml_logout = false;
	var enable_saml_jit = false;
	var last_name = "";
	var first_name = "";
	var display_name = "";
	var errorField = document.createElement("div");
	errorField.classList.add("field_error");//No I18N
	var errorOcurred = false;
	
	
	// sign-in url validation
	if(!signinUrlValue) {
		var currError = errorField.cloneNode(true);
		currError.innerHTML = empty_field;
		signinUrl.parentElement.appendChild(currError);
		errorOcurred = true;
		$(signinUrl).focus();
	}
	if(signinUrlValue && !isValidUrl(signinUrlValue)) {
		var currError = errorField.cloneNode(true);
		currError.innerHTML = i18nSamlsetupKeys['IAM.SAMLSETUP.SIGN.VALID.URL'];
		signinUrl.parentElement.appendChild(currError);
		errorOcurred = true;
		$(signinUrl).focus();
	}
	
	// publickey validation
	if(!samlPublicKeyValue && !samlPublicKeyFileValue && !org_data.SAML.saml_login_url){
		samlSetupForm.querySelector(".publickey-filetype__text").classList.add("publickey-filetype__text--highlight");//No I18N
		if(!errorOcurred) {
			$(samlPublicKey).focus();
		}
		errorOcurred = true;
	} else {
		if(samlPublicKeyValue){
			samlPublicKeyValue = "-----BEGIN CERTIFICATE----- "+samlPublicKeyValue+" -----END CERTIFICATE-----";//No I18N
		}
	}
	
	// Single logout
	if($("#saml-signout-response").find(".real_togglebtn").prop("checked")) {
		enable_saml_logout = true;
		if(!signoutUrlValue) {
			var currError = errorField.cloneNode(true);
			currError.innerHTML = empty_field;
			signoutUrl.parentElement.appendChild(currError);
			if(!errorOcurred) {
				$(signoutUrl).focus();
			}
			errorOcurred = true;
		}
	}
	
	// sign-out url validation
	if(signoutUrlValue && !isValidUrl(signoutUrlValue)) {
		var currError = errorField.cloneNode(true);
		currError.innerHTML = i18nSamlsetupKeys['IAM.SAMLSETUP.SIGN.VALID.URL'];
		signoutUrl.parentElement.appendChild(currError);
		if(!errorOcurred) {
			$(signoutUrl).focus();
		}
		errorOcurred = true;
	}
	
	
	// parameters values
	if($("#sign-param").find(".real_togglebtn").prop("checked")) {
		enable_signin_response = true;
		signinUsername= samlSetupFormContainer.saml_signin__param_userName ? samlSetupFormContainer.saml_signin__param_userName.value: "";
		signinEmailaddress= samlSetupFormContainer.saml_signin__param_emailAddress ? samlSetupFormContainer.saml_signin__param_emailAddress.value: "";
		signoutUsername= samlSetupFormContainer.saml_signout__param_userName ? samlSetupFormContainer.saml_signout__param_userName.value: "";
		signoutEmailaddress= samlSetupFormContainer.saml_signout__param_emailAddress ? samlSetupFormContainer.saml_signout__param_emailAddress.value: "";
		if(!signinUsername && !signinEmailaddress && !signoutUsername && !signoutEmailaddress){
			var currError = errorField.cloneNode(true);
			currError.innerHTML = empty_field;
			if($(samlSetupFormContainer.saml_signin__param_userName).is(":visible")){
				samlSetupFormContainer.saml_signin__param_userName.parentElement.appendChild(currError);
				if(!errorOcurred) {
					$(samlSetupFormContainer.saml_signin__param_userName).focus();
					samlSetupFormContainer.saml_signin__param_userName.scrollIntoView();
				}
			}
			else if($(samlSetupFormContainer.saml_signin__param_emailAddress)){
				samlSetupFormContainer.saml_signin__param_emailAddress.parentElement.appendChild(currError);
				if(!errorOcurred) {
					$(samlSetupFormContainer.saml_signin__param_emailAddress).focus();
					samlSetupFormContainer.saml_signin__param_emailAddress.scrollIntoView();
				}
			}
			errorOcurred = true;
		}
		else {
			if(signinUsername && !isValidNameString(signinUsername)){
				var currError = errorField.cloneNode(true);
				currError.innerHTML = i18nSamlsetupKeys["IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED"];
				samlSetupFormContainer.saml_signin__param_userName.parentElement.appendChild(currError);
				if(!errorOcurred) {
					samlSetupFormContainer.saml_signin__param_userName.focus();
					samlSetupFormContainer.saml_signin__param_userName.scrollIntoView();
					errorOcurred = true;
				}
			}
			if(signinEmailaddress && !isValidNameString(signinEmailaddress)){
				var currError = errorField.cloneNode(true);
				currError.innerHTML = i18nSamlsetupKeys["IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED"];
				samlSetupFormContainer.saml_signin__param_emailAddress.parentElement.appendChild(currError);
				if(!errorOcurred) {
					samlSetupFormContainer.saml_signin__param_emailAddress.focus();
					samlSetupFormContainer.saml_signin__param_emailAddress.scrollIntoView();
					errorOcurred = true;
				}
			}
			if(signoutUsername && !isValidNameString(signoutUsername)){
				var currError = errorField.cloneNode(true);
				currError.innerHTML = i18nSamlsetupKeys["IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED"];
				samlSetupFormContainer.saml_signout__param_userName.parentElement.appendChild(currError);
				if(!errorOcurred) {
					samlSetupFormContainer.saml_signout__param_userName.focus();
					samlSetupFormContainer.saml_signout__param_userName.scrollIntoView();
					errorOcurred = true;
				}
			}
			if(signoutEmailaddress && !isValidNameString(signoutEmailaddress)){
				var currError = errorField.cloneNode(true);
				currError.innerHTML = i18nSamlsetupKeys["IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED"];
				samlSetupFormContainer.saml_signout__param_emailAddress.parentElement.appendChild(currError);
				if(!errorOcurred) {
					samlSetupFormContainer.saml_signout__param_emailAddress.focus();
					samlSetupFormContainer.saml_signout__param_emailAddress.scrollIntoView();
					errorOcurred = true;
				}
			}
		}
	}
	
	// sign SAML requests
	if($("#saml-encryption").find(".real_togglebtn").prop("checked")) {
		enable_saml_encryption = true;
	}
	
	//Generate key pair
	if($("#saml-generate-key").find(".real_togglebtn").prop("checked")) {
		generate_sp_cert = true;
	}
	
	// jit values
	if($("#saml-jit").find(".real_togglebtn").prop("checked")) {
		enable_saml_jit = true;
		first_name = samlSetupFormContainer.jit_first_name ? samlSetupFormContainer.jit_first_name.value:"";
		last_name = samlSetupFormContainer.jit_last_name ? samlSetupFormContainer.jit_last_name.value:"";
		display_name = samlSetupFormContainer.jit_display_name ? samlSetupFormContainer.jit_display_name.value:"";
	}
	
	if(errorOcurred) {
		return;
	}
	var params ={};
	
	// Initialization of param object for SAML Edit/update request call 
	if(org_data.SAML.saml_login_url) {
		if(org_data.SAML.saml_login_url !== signinUrlValue) {
			params.login_url = signinUrlValue;
		}
		if((org_data.SAML.saml_logout_url || signoutUrlValue) &&  org_data.SAML.saml_logout_url !== signoutUrlValue) {
			params.logout_url = signoutUrlValue;
		}
		if(org_data.SAML.saml_service !== serviceValue) {
			params.service = serviceValue;
		}
		if(org_data.SAML.login_binding !==  login_binding) {
			params.login_binding = login_binding;
		}
		if(org_data.SAML.logout_binding !==  logout_binding) {
			params.logout_binding = logout_binding;
		}
		if(samlPublicKeyValue) {
			params.publickey = samlPublicKeyValue;
		}
		if(org_data.SAML.name_identifier !== nameIdentifierIdValue){
			params.name_identifier = nameIdentifierIdValue; 
		}
		if(org_data.SAML.is_signature_enabled !== enable_saml_encryption) {
			params.enable_signature = enable_saml_encryption;
		}
		if($("#saml-generate-key").is(":visible") && generate_sp_cert){
			params.generate_sp_cert = generate_sp_cert;
		}
		if(org_data.SAML.is_saml_logout_enabled !== enable_saml_logout) {
			params.enable_saml_logout = enable_saml_logout;
		}
		if(org_data.SAML.issaml_jit_enabled !== enable_saml_jit) {
			params.enable_saml_jit = enable_saml_jit;
			if(enable_saml_jit){
				params.jit_attr = {
						"first_name": first_name, //No I18N
						"last_name": last_name, //No I18N
						"display_name": display_name //No I18N
					};	
			}
		}
		if(org_data.SAML.issaml_jit_enabled && enable_saml_jit){
			if(org_data.SAML.jit_attributes){
				org_data.SAML.jit_attributes = isJsonObject(org_data.SAML.jit_attributes) ? JSON.parse(org_data.SAML.jit_attributes) : org_data.SAML.jit_attributes;
				if(org_data.SAML.jit_attributes.first_name!== first_name || org_data.SAML.jit_attributes.last_name !== last_name || org_data.SAML.jit_attributes.display_name !== display_name ){
					params.jit_attr = {
						"first_name": first_name, //No I18N
						"last_name": last_name, //No I18N
						"display_name": display_name //No I18N
					};	
				}	
			}
		}
		
		if(!org_data.SAML.login_params){
			org_data.SAML.login_params = {
					"ZLOGINID" : "",//No I18N
					"ZEMAIL" : ""//No I18N
			};
		}
		params.signin_params = {
			"to_be_deleted":[], //No I18N
			"to_be_updated":{}, //No I18N
			"to_be_added":{} //No I18N
		};
		if((org_data.SAML.login_params.ZLOGINID || signinUsername) && org_data.SAML.login_params.ZLOGINID !== signinUsername) {
			if(!signinUsername) {
				params.signin_params.to_be_deleted.push(org_data.SAML.login_params.ZLOGINID);
			}
			else if(org_data.SAML.login_params.ZLOGINID && signinUsername) {
				params.signin_params.to_be_updated.ZLOGINID = signinUsername;
			}
			else {
				params.signin_params.to_be_added.ZLOGINID = signinUsername;
			}
		}
		if((org_data.SAML.login_params.ZEMAIL || signinEmailaddress) && org_data.SAML.login_params.ZEMAIL !== signinEmailaddress) {
			if(!signinEmailaddress) {
				params.signin_params.to_be_deleted.push(org_data.SAML.login_params.ZEMAIL);
			}
			else if(org_data.SAML.login_params.ZEMAIL && signinEmailaddress){
				params.signin_params.to_be_updated.ZEMAIL =  signinEmailaddress;
			}
			else {
				params.signin_params.to_be_added.ZEMAIL =  signinEmailaddress;
			}
		}
		if(!org_data.SAML.logout_params){
			org_data.SAML.logout_params={
					"ZLOGINID" : "",//No I18N
					"ZEMAIL" : ""//No I18N
			};
		}
		params.signout_params = {
			"to_be_deleted":[], //No I18N
			"to_be_updated":{}, //No I18N
			"to_be_added":{} //No I18N
		};
		if((org_data.SAML.logout_params.ZLOGINID || signoutUsername) && org_data.SAML.logout_params.ZLOGINID !== signoutUsername) {
			if(!signoutUsername) {
					params.signout_params.to_be_deleted.push(org_data.SAML.logout_params.ZLOGINID);
			}
			else if(org_data.SAML.logout_params.ZLOGINID && signoutUsername){
				params.signout_params.to_be_updated.ZLOGINID = signoutUsername;
			}
			else {
				params.signout_params.to_be_added.ZLOGINID = signoutUsername;
			}
		}
		if((org_data.SAML.logout_params.ZEMAIL || signoutEmailaddress) && org_data.SAML.logout_params.ZEMAIL !== signoutEmailaddress) {
			if(!signoutEmailaddress) {
				params.signout_params.to_be_deleted.push(org_data.SAML.logout_params.ZEMAIL);
			}
			else if(org_data.SAML.logout_params.ZEMAIL && signoutEmailaddress){
				params.signout_params.to_be_updated.ZEMAIL =  signoutEmailaddress;
			}
			else {
				params.signout_params.to_be_added.ZEMAIL =  signoutEmailaddress;
			}
		}
		if(jQuery.isEmptyObject(params.signin_params.to_be_added)){
			delete params.signin_params.to_be_added;
		}
		if(jQuery.isEmptyObject(params.signin_params.to_be_updated)){
			delete params.signin_params.to_be_updated;
		}
		if(params.signin_params.to_be_deleted.length === 0){
			delete params.signin_params.to_be_deleted;
		}
		if(jQuery.isEmptyObject(params.signout_params.to_be_added)){
			delete params.signout_params.to_be_added;
		}
		if(jQuery.isEmptyObject(params.signout_params.to_be_updated)){
			delete params.signout_params.to_be_updated;
		}
		if(params.signout_params.to_be_deleted.length === 0){
			delete params.signout_params.to_be_deleted;
		}
		if(jQuery.isEmptyObject(params.signin_params)) {
			delete params.signin_params;
		} 
		if(jQuery.isEmptyObject(params.signout_params)) {
			delete params.signout_params;
		}
		if(!params.jit_attr || jQuery.isEmptyObject(params.jit_attr)) {
			delete params.jit_attr;
		}
		if(jQuery.isEmptyObject(params) && !samlPublicKeyFileValue) {
			closeSamlsetupMenu();
			return;
		}
		params.__form = $('.'+samlSetupFormContainer.id);
	}
	else {
		// Initialization of param object for new SAMLsetup request call 
		params = {
			"login_url": signinUrlValue, //No I18N
			"logout_url": signoutUrlValue, //No I18N
			"login_binding": login_binding, //No I18N
			"logout_binding": logout_binding, //No I18N
			"service": serviceValue, //No I18N
			"name_identifier": nameIdentifierIdValue, //No I18N
			"publickey": samlPublicKeyValue, //No I18N
			"enable_signature":enable_saml_encryption, //No I18N
			"signin_params": //No I18N
			{
				"to_be_added": { //No I18N
					"ZLOGINID": signinUsername, //No I18N
					"ZEMAIL": signinEmailaddress //No I18N
				}
			},
			"signout_params": //No I18N
			{
				"to_be_added": { //No I18N
					"ZLOGINID": signoutUsername, //No I18N
					"ZEMAIL": signoutEmailaddress //No I18N
				}
			},
			"jit_attr": //No I18N
			{
				"first_name": first_name, //No I18N
				"last_name": last_name, //No I18N
				"display_name": display_name //No I18N
			},
			"generate_sp_cert": generate_sp_cert, //No I18N
			"enable_saml_logout": enable_saml_logout, //No I18N
			"enable_saml_jit": enable_saml_jit, //No I18N
			"__form":$('.'+samlSetupFormContainer.id)//No I18N
		}
		for(var key in params.signin_params.to_be_added) {
			if(!params.signin_params.to_be_added[key]) {
				delete params.signin_params.to_be_added[key];
			}
			if(!params.signout_params.to_be_added[key]) {
				delete params.signout_params.to_be_added[key];
			}
		}
		if(jQuery.isEmptyObject(params.signin_params)){
			delete params.signin_params;
		}
		if(jQuery.isEmptyObject(params.signout_params)){
			delete params.signout_params;
		}
		for(var key in params.jit_attr) {
			if(!params.jit_attr[key]) {
				delete params.jit_attr[key];
			}
		}
		if(jQuery.isEmptyObject(params.jit_attr)){
			delete params.jit_attr;
		}	
	}
	buttonToLoader(submitBtn);
	var payload = SAMLObj.create(params);
	payload.build();
	$("#saml-publickey_upload").unbind();
	payload.POST("self").then(function(resp){ //No I18N
		SuccessMsg(getErrorMessage(resp));
		if(!org_data.SAML.saml_login_url){
			org_data.SAML.is_saml_enabled=true;
		}
		org_data.SAML.saml_login_url = signinUrlValue;
		org_data.SAML.saml_logout_url = signoutUrlValue;
		org_data.SAML.login_binding = login_binding;
		org_data.SAML.logout_binding = logout_binding;
		org_data.SAML.saml_service = serviceValue;
		org_data.SAML.name_identifier = nameIdentifierIdValue;
		if(signinUsername || signinEmailaddress){
				org_data.SAML.login_params = {
					"ZLOGINID" : signinUsername, //No I18N
					"ZEMAIL" : signinEmailaddress //No I18N
			};
		}
		else {
			delete org_data.SAML.login_params;
		}
		if(signoutUsername || signoutEmailaddress){
				org_data.SAML.logout_params = {
					"ZLOGINID" : signoutUsername, //No I18N
					"ZEMAIL" : signoutEmailaddress //No I18N
			};
		}
		else {
			delete org_data.SAML.logout_params;
		}
		org_data.SAML.is_signature_enabled = enable_saml_encryption;
		if(!org_data.SAML.has_sp_certificate) {
			org_data.SAML.has_sp_certificate = generate_sp_cert;	
		}
		org_data.SAML.is_saml_logout_enabled = enable_saml_logout; 
		org_data.SAML.issaml_jit_enabled = enable_saml_jit;
		org_data.SAML.jit_attributes = {
				"first_name" : first_name, //No I18N
				"last_name" : last_name, //No I18N
				"display_name" : display_name //No I18N
		};
		org_data.SAML.jit_attributes = JSON.stringify(org_data.SAML.jit_attributes);
		revertButtonToLoader(submitBtn);
		$("#saml-upload-input").unbind();
		loadSamlDetails(org_data.SAML);
	},function(resp){
		revertButtonToLoader(submitBtn);
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			showErrorMessage(getErrorMessage(resp));
		}
		applySamlPublicKeyuploadEvent();
	});
	return false;
}

function buttonToLoader(button){
	$(button).attr("disabled", "disabled");
	$(button).addClass("button_disable");
	$(button).removeClass("primary_btn_check");
	return false;
}

function revertButtonToLoader(button){
	$(button).removeAttr("disabled");
	$(button).addClass("primary_btn_check");
	$(button).removeClass("button_disable");
	return false;
}

function loadSamlDetails(samlDetails) {
	if(samlDetails.saml_login_url) {
		closeSamlsetupMenu();
		$(".saml-enable_btn-div").css("display","inline");
		if(samlDetails.is_saml_enabled) {
			$("#toggle_saml").prop('checked', true);
		}
		$(".saml-header__right").show();
		$(".info-download-publickey").show();
		$(".saml-setup_info").show();
		$("#saml_notActivated").hide();
		if(isMobile) {
			$(".saml-header__right").hide();
			$(".saml-mb-view").show();
		}
		else{
			$(".saml-mb-view").hide();
		}
		$(".info-signin-url .info-value").html(samlDetails.saml_login_url);
		$(".info-signout-url .info-value").html(samlDetails.saml_logout_url);
		$(".info-zoho-service .info-value").html($("#edit-SAMLservice_name").find("option[value="+samlDetails.saml_service+"]").text());
		$(".info-name-identifier .info-value").html($(".saml-name-identifier").find("option[id-value="+samlDetails.name_identifier+"]").html());
		$(".info-parameters .info-value").html(samlDetails.login_params?i18nSamlsetupKeys["IAM.TFA.ENABLED"]:i18nSamlsetupKeys["IAM.MFA.MODE.DISABLED"]);//No I18N
		$(".info-request-encryption .info-value").html(samlDetails.is_signature_enabled?i18nSamlsetupKeys["IAM.TFA.ENABLED"]:i18nSamlsetupKeys["IAM.MFA.MODE.DISABLED"]);//No I18N
		$(".info-sign-out .info-value").html(samlDetails.is_saml_logout_enabled?i18nSamlsetupKeys["IAM.TFA.ENABLED"]:i18nSamlsetupKeys["IAM.MFA.MODE.DISABLED"]);//No I18N
		$(".info-jit .info-value").html(samlDetails.issaml_jit_enabled?i18nSamlsetupKeys["IAM.TFA.ENABLED"]:i18nSamlsetupKeys["IAM.MFA.MODE.DISABLED"]);//No I18N
		if(!org_data.SAML.is_saml_enabled || !org_data.SAML.has_sp_certificate) {
			$(".info-download-publickey").hide();
		}
	}
	else {
		$(".saml-setup_info").hide();
		$(".saml-header__right").hide();
		$("#saml_notActivated").show();
		$("#saml_notActivated .no_data_text").html(formatMessage(saml_setup_description,samlDetails.org_name));	
	}
	return false;
}


// Showing SAMLsetup UI in edit mode
function showEditSamlsetupMenu() {
	remove_error();
	showSamlsetupMenu();
	var samlSetupFormContainer = $(".saml-setup__form-container")[0];
	$(".saml-login-url").val(org_data.SAML.saml_login_url);
	$(".saml-logout-url").val(org_data.SAML.saml_logout_url);
	$('.saml-signin__list option[id-value='+org_data.SAML.login_binding+']').prop('selected', true);
	$('.saml-signout__list option[id-value='+org_data.SAML.logout_binding+']').prop('selected', true);
	$('#edit-SAMLservice_name option[value='+org_data.SAML.saml_service+']').prop('selected', true);
	$('.saml-name-identifier option[id-value='+org_data.SAML.name_identifier+']').prop('selected', true);
	$('.saml-signin__list,.saml-signout__list,#edit-SAMLservice_name,.saml-name-identifier').trigger("change");
	if(org_data.SAML.issaml_jit_enabled) {
		$(".saml-JIT-btn").prop("checked",true);
		showSamlSetupModeFields($("#saml-jit"));
		org_data.SAML.jit_attributes = isJsonObject(org_data.SAML.jit_attributes) ? JSON.parse(org_data.SAML.jit_attributes) : org_data.SAML.jit_attributes;
		$(".saml-setup__JIT .JIT-field__right input").attr("oninput","handleJitEdit();");
		if(org_data.SAML.jit_attributes) {
			var jitFieldLength = $("#empty-saml-setup__JIT .saml-setup__JIT-select option").length;
			for(var i=0; i<jitFieldLength-1; i++) {
				$(".saml-setup__mode .saml-setup__JIT .add-circle")[0].click();
			}
			for (var property in org_data.SAML.jit_attributes) {
				if(samlSetupFormContainer["jit_"+property]){
					samlSetupFormContainer["jit_"+property].value = org_data.SAML.jit_attributes[property];
				}
			}
			$(".saml-setup__mode .saml-setup__JIT").each(function(){
				if(!$(this).find("input").val()){
					$(this).find(".close-circle").click();
				}
			});
		}
		if($(".saml-setup__mode .saml-setup__JIT").length<2) {
		 	$(".saml-JIT-btn").prop("checked","true");
		}
	}
	if(samlAsParams()) {
		$(".param-btn").prop("checked","true");
	    showSamlSetupModeFields($("#sign-param"));
		var signParamLength = $("#empty-saml-sign__param option").length;
		$($(".saml-sign__param")).find(".param-field_right input").attr("oninput","handleParamEdit();"); //no I18N
		for(var i=0; i<signParamLength-1; i++) {
			$("#saml_signin__param .add-circle")[0].click();
			$("#saml_signout__param .add-circle")[0].click();
		}
		if(org_data.SAML.login_params) {
			org_data.SAML.login_params = isJsonObject(org_data.SAML.login_params)?JSON.parse(org_data.SAML.login_params):org_data.SAML.login_params;
			samlSetupFormContainer.saml_signin__param_userName.value = org_data.SAML.login_params.ZLOGINID ? org_data.SAML.login_params.ZLOGINID : "";
			samlSetupFormContainer.saml_signin__param_emailAddress.value = org_data.SAML.login_params.ZEMAIL? org_data.SAML.login_params.ZEMAIL: "";
		}
		if(org_data.SAML.logout_params) {
			org_data.SAML.logout_params = isJsonObject(org_data.SAML.logout_params)?JSON.parse(org_data.SAML.logout_params):org_data.SAML.logout_params;
			samlSetupFormContainer.saml_signout__param_userName.value = org_data.SAML.logout_params.ZLOGINID? org_data.SAML.logout_params.ZLOGINID: "";
			samlSetupFormContainer.saml_signout__param_emailAddress.value = org_data.SAML.logout_params.ZEMAIL? org_data.SAML.logout_params.ZEMAIL: "";
		}
		$(".mode-param-fields .param-field_right").each(function(){
			if(!$(this).find("input").val()){
				$(this).find(".close-circle").click();
			}
		});
	}
	if(org_data.SAML.is_signature_enabled) {
		$(".saml-encryp-btn").prop("checked","true");
		showSamlSetupModeFields($("#saml-encryption"));
	}
	if(org_data.SAML.is_saml_logout_enabled) {
		$("#saml-signout-response").click();
	}
	disableSamlSubmitBtn();
	$(".saml-setup__body").scrollTop(0);
	$(".isSamlEdited").on("change input",function(){
		var enableSubmitBtn = false;
		var samlForm = $("#saml-setup__form-container")[0];
		var samlFormSelectValues = ["login_binding","logout_binding","saml_name_identifier"]; //no I18N
		var samlFormInputValues = ["login_url","logout_url","service"]; //no I18N
		var samlformRadiobtnValues = ["saml-encryp-btn","signout-response","saml-JIT-btn"]; //no I18N
		
		// login,logout binding and identifier check
		for(var index in samlFormSelectValues){
			var value = samlForm[samlFormSelectValues[index]].value;
			if(parseInt($(samlForm[samlFormSelectValues[index]]).find("option[value="+value+"]").attr("id-value")) !== org_data.SAML[formValueToSamlDataValue[samlFormSelectValues[index]]]){
				enableSubmitBtn = true;
			}
		}
		// login, logout url and service check
		for(var index in samlFormInputValues){
			if(samlForm[samlFormInputValues[index]].value !== org_data.SAML[formValueToSamlDataValue[samlFormInputValues[index]]]){
				enableSubmitBtn = true;
			}
		}
		for(var index in samlformRadiobtnValues){
			if(samlForm[samlformRadiobtnValues[index]].checked !== org_data.SAML[formValueToSamlDataValue[samlformRadiobtnValues[index]]]){
				enableSubmitBtn = true;
			}
		}
		//publickey check
		if(samlForm.publickey.value || ($(".saml-publickey_upload")[0].files[0] && isValidPublicKeyFile(($(".saml-publickey_upload")[0].files[0]).name))){
				enableSubmitBtn = true;
		}
		if($(".param-btn").prop("checked") !== samlAsParams()){
			enableSubmitBtn = true;
		}
		if($("#saml-generate-key").is(":visible") && $("#saml-generate-key .idp-response").prop("checked")){
			enableSubmitBtn = true;
		}
		handleJitEdit();
		handleParamEdit();
		if(enableSubmitBtn){
			enableSamlSubmitBtn();
			$(".saml-setup_menu").addClass("samlEdited1");
		}
		else{
			$(".saml-setup_menu").removeClass("samlEdited1");
			if(!$(".saml-setup_menu").hasClass("samlEdited2") && !$(".saml-setup_menu").hasClass("samlEdited3")){
				disableSamlSubmitBtn();
			}
		}
		return;
	});
	return false;
}

function samlAsParams() {
	if(org_data.SAML.login_params && (org_data.SAML.login_params.ZLOGINID || org_data.SAML.login_params.ZEMAIL)){
		return true;
	}
	if(org_data.SAML.logout_params && (org_data.SAML.logout_params.ZLOGINID || org_data.SAML.logout_params.ZEMAIL)) {
		return true;
	}
	return false;
}

function disableSamlSubmitBtn() {
	$(".submitSamlBtn").addClass("pref_disable_btn");
	$(".submitSamlBtn").removeClass("primary_btn_check");
	$(".submitSamlBtn").attr("disabled", "disabled");
}

function enableSamlSubmitBtn() {
	$(".submitSamlBtn").removeClass("pref_disable_btn");
	$(".submitSamlBtn").addClass("primary_btn_check");
	$(".submitSamlBtn").removeAttr("disabled", "disabled");
}


// Handling of deleting SAML setup
function deleteSamlsetup(title,desc) {
	show_confirm(title,desc,
			function() 
		    {
				new URI(SAMLObj,"self").DELETE().then(function(resp)	//No I18N
					{
						SuccessMsg(getErrorMessage(resp));
						$(".saml-enable_btn-div").hide();
						org_data.SAML.is_saml_enabled=false;
						org_data.SAML.is_signature_enabled = false; 
						org_data.SAML.is_saml_logout_enabled = false; 
						org_data.SAML.issaml_jit_enabled = false;
						org_data.SAML.has_sp_certificate = false;
												
						delete org_data.SAML.login_binding;
						delete org_data.SAML.logout_binding;
						delete org_data.SAML.saml_login_url;
						delete org_data.SAML.saml_logout_url;
						delete org_data.SAML.saml_service;
						delete org_data.SAML.name_identifier;
						delete org_data.SAML.login_params;
						delete org_data.SAML.logout_params;
						delete org_data.SAML.jit_attributes;
						
						loadSamlDetails(org_data.SAML);
					},
					function(resp)
					{
						if(resp.cause && resp.cause.trim() === "invalid_password_token") 
						{
							relogin_warning();
							var service_url = euc(window.location.href);
							$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
						}
						else
						{
							showErrorMessage(getErrorMessage(resp));
						}
					});
		     },
			function() 
		    {
		    	return false;
		    });
}

function isJsonObject(str) {
	try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

function isValidUrl(url) {
	var expression = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/gi;
	var regex = new RegExp(expression);	
	if(url.match(regex)) {
		return true;
	}
	else {
		return false;
	}
}

// Handling of parameters, sign saml requests, single logout and jit in checked/unchecked modes 
function showSamlSetupModeFields(element)
{
	if($(element).find(".real_togglebtn").prop("checked")){
		if($(element).attr("id") === "saml-encryption") {
			if(org_data.SAML.has_sp_certificate && org_data.SAML.is_saml_enabled) {
				$(element).siblings().slideDown();
			}
			if(!org_data.SAML.has_sp_certificate) {
				$("#saml-generate-key .real_togglebtn").prop('checked', true);
				$("#saml-generate-key").addClass("sign-request-enabled");
				$("#saml-generate-key .real_togglebtn").prop("disabled", true);
				$("#saml-generate-key .mode_sub-description").slideDown();
			}	
		}
		else {
			$(element).siblings().slideDown();
		}
	}
	else{
		var siblingElement = $(element).siblings();
		if($(siblingElement).hasClass("mode-param-fields")) {
			$(".param-fields").html("");
			var emptyParamField = document.querySelector("#empty-saml-sign__param").children;//No I18N
			var paramField = emptyParamField[0].cloneNode(true);
			$(".param-fields").append($(paramField));
			$(".saml-setup__modes .params_select").select2({
				minimumResultsForSearch: Infinity,
				theme: "saml-sign__param" //no I18N
			});
			$(".saml-setup__modes .params_select").each(function(){
				updateSignparamInputName(this);
			});
			if(org_data.SAML.saml_login_url){
				$($(paramField)).find(".param-field_right input").attr("oninput","handleParamEdit();"); //no I18N
			}
		}
		else if($(siblingElement).hasClass("saml-encryp__request")) {
			if($("#saml-generate-key").hasClass("sign-request-enabled")){
				$("#saml-generate-key").removeClass("sign-request-enabled");
				$("#saml-generate-key .real_togglebtn").prop("disabled", false);
				$("#saml-generate-key .real_togglebtn").prop('checked', false);
				$("#saml-generate-key .mode_sub-description").slideDown();
				$("#saml-generate-key .mode_sub-description").slideUp();
			}
		}
		else if($(siblingElement).hasClass("saml-setup__JITs")) {
			resetJitFields();
		}
		$(siblingElement).slideUp();
	}
}

function resetJitFields() {
	$(".saml-setup__JITs").html("");
	var emptyJitField = document.querySelector("#empty-saml-setup__JIT").children;//No I18N
	var jitField = emptyJitField[0].cloneNode(true);
	$(".saml-setup__JITs").append(jitField);
	$(".saml-setup__modes .saml-setup__JIT-select").select2({
		minimumResultsForSearch: Infinity,
		theme: "saml-JIT__select" //no I18N
	});
	return;
}

function handleParamEdit() {
	var logParamFields = ["saml_signin__param_userName","saml_signin__param_emailAddress","saml_signout__param_userName","saml_signout__param_emailAddress"];//No I18N
	var logParamFieldsLength = logParamFields.length;
	var samlForm = $("#saml-setup__form-container")[0];
	var enableSubmitBtn= false;
	
		if(!org_data.SAML.login_params){
			org_data.SAML.login_params = {
					"ZLOGINID" : "",//No I18N
					"ZEMAIL" : ""//No I18N
			};
		}
		if(!org_data.SAML.logout_params){
			org_data.SAML.logout_params={
					"ZLOGINID" : "",//No I18N
					"ZEMAIL" : ""//No I18N
			};
		}
		for(var i=0; i<logParamFieldsLength; i++){
			var logParamArray = formValueToSamlDataValue[logParamFields[i]].split(".");
			var logParam= org_data.SAML;
				for(var j=0; j<logParamArray.length; j++){
					logParam = logParam[logParamArray[j]];
				}
				logParam = logParam ? logParam : "";
				if((logParam && !samlForm[logParamFields[i]]) || (samlForm[logParamFields[i]] && samlForm[logParamFields[i]].value !== logParam)){
					enableSubmitBtn= true;
				}
		}
		if(enableSubmitBtn){
			enableSamlSubmitBtn();
			$(".saml-setup_menu").addClass("samlEdited2");
		}
	   	else{
			$(".saml-setup_menu").removeClass("samlEdited2");
			if(!$(".saml-setup_menu").hasClass("samlEdited1") && !$(".saml-setup_menu").hasClass("samlEdited3")){
				disableSamlSubmitBtn();	
			}
		}
}

function handleJitEdit() {
	var samlForm = $("#saml-setup__form-container")[0];
	var jitFields = ["jit_first_name","jit_last_name","jit_display_name"]; //No I18N
	var jitFieldslength = jitFields.length;
	var enableSubmitBtn = false;
	org_data.SAML.jit_attributes = isJsonObject(org_data.SAML.jit_attributes) ? JSON.parse(org_data.SAML.jit_attributes) : org_data.SAML.jit_attributes;
	if(!org_data.SAML.jit_attributes){
		org_data.SAML.jit_attributes = {
			"first_name":"", //No I18N
			"last_name":"", //No I18N
			"display_name":"" //No I18N
		};
	}
		for(var i=0; i<jitFieldslength; i++){
			if(org_data.SAML.jit_attributes[formValueToSamlDataValue[jitFields[i]]] && !samlForm[jitFields[i]]){
				 enableSubmitBtn = true;
			}
			else if(samlForm[jitFields[i]] && samlForm[jitFields[i]].value !== org_data.SAML.jit_attributes[formValueToSamlDataValue[jitFields[i]]]){
				enableSubmitBtn = true;
			}
		}
	if(enableSubmitBtn){
		enableSamlSubmitBtn();
		$(".saml-setup_menu").addClass("samlEdited3");
	}
	else {
		$(".saml-setup_menu").removeClass("samlEdited3");
			if(!$(".saml-setup_menu").hasClass("samlEdited1") && !$(".saml-setup_menu").hasClass("samlEdited2")){
				disableSamlSubmitBtn();	
			}
	}
	return;
}


// XML to JSON conversion
function xmlToJson(xml) 
{
    // Create the return object
    var obj = {}, i, j, attribute, item, nodeName, old;

    if (xml.nodeType === 1) { // element
        // do attributes
        if (xml.attributes.length > 0) {
            obj["@attributes"] = {};//No I18N
            for (j = 0; j < xml.attributes.length; j = j + 1) {
                attribute = xml.attributes.item(j);
                obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
            }
        }
    } else if (xml.nodeType === 3) { // text
        var text = xml.nodeValue.trim();
        if(text) {
        	obj = text;
        }
        else {
        	return;
        }
    }

    // do children
    if (xml.hasChildNodes()) {
        for (i = 0; i < xml.childNodes.length; i = i + 1) {
            item = xml.childNodes.item(i);
            nodeName = item.nodeName;
            if ((obj[nodeName]) === undefined) {
                obj[nodeName] = xmlToJson(item);
            } else {
                if ((obj[nodeName].push) === undefined) {
                    old = obj[nodeName];
                    obj[nodeName] = [];
                    obj[nodeName].push(old);
                }
                obj[nodeName].push(xmlToJson(item));
            }
        }
    }
    return obj;
}


function fillSamlMetadata(metadataText)
{
	try{
		var parser = new DOMParser().parseFromString(metadataText,"text/xml");//No I18N
		var jsonValue = xmlToJson(parser);
		var EntityDescriptor = parser.children[0].tagName;
		var prefix = "";
		if(EntityDescriptor.split(":").length>1){
			prefix = EntityDescriptor.split(":")[0]+":";
		}
		var IDPSSODescriptor = prefix+"IDPSSODescriptor"; //No I18N
		var SingleSignOnService = prefix+"SingleSignOnService"; //No I18N
		var SingleLogoutService = prefix+"SingleLogoutService"; //No I18N
		var KeyDescriptor = prefix+"KeyDescriptor"; //No I18N
		var metadataValue = jsonValue[EntityDescriptor][IDPSSODescriptor];
		$('.saml-signin__list option[id-value=0],.saml-signout__list option[id-value=0]').prop('selected', true);
		$('.saml-signin__list,.saml-signout__list').trigger("change");
		var signUrlJson = {
			"signin" : { //No I18N
				"getUrl":"", //No I18N
				"postUrl":"" //No I18N
			},
			"signout" : { //No I18N
				"getUrl":"", //No I18N
				"postUrl":"" //No I18N
			}
		};
		updateSignUrl(metadataValue[SingleSignOnService],signUrlJson.signin);
		updateSignUrl(metadataValue[SingleLogoutService],signUrlJson.signout);
		
		$(".saml-login-url").val(signUrlJson.signin.getUrl);
		$(".saml-logout-url").val(signUrlJson.signout.getUrl);
		removePublicKey();
		$('.saml-signin__list, .saml-signout__list').bind("getPostchanged",function(){
			if($(this).val().toLowerCase() === "get") {
				if($(this).hasClass("saml-signin__list")) {
					$(".saml-login-url").val(signUrlJson.signin.getUrl);
				}
				else {
					$(".saml-logout-url").val(signUrlJson.signout.getUrl);
				}
			}
			else if($(this).val().toLowerCase() === "post") {
				if($(this).hasClass("saml-signin__list")) {
					$(".saml-login-url").val(signUrlJson.signin.postUrl);	
				}
				else {
					$(".saml-logout-url").val(signUrlJson.signout.postUrl);
				} 	
			}
		});
		if(metadataValue[KeyDescriptor].length>1){
			for(var key in metadataValue[KeyDescriptor]){
				if(metadataValue[KeyDescriptor][key]["@attributes"].use.toLowerCase() === "signing"){
					$(".saml-publickey").val(metadataValue[KeyDescriptor][key]["ds:KeyInfo"]["ds:X509Data"]["ds:X509Certificate"]["#text"]);//No I18N
					break;
				}
			}
		}
		else {
			$(".saml-publickey").val(metadataValue[KeyDescriptor]["ds:KeyInfo"]["ds:X509Data"]["ds:X509Certificate"]["#text"]);//No I18N
		}
		if(org_data.SAML.saml_login_url){
			$(".saml-publickey").trigger("change");
		}
		$(".saml-setup__upload-message").hide();
		$(".saml-setup__update-message").css("display", "flex");
		return true;
	}
	catch(err){
		showErrorMessage(i18nSamlsetupKeys['IAM.SAML.ERROR.INVALID.METADATA']);//No I18N
		$("#saml-upload-input").val("");
	}
	return false;
}

function getPostchange(){
	if($("#saml-upload-input").val()) {
		$('.saml-signin__list, .saml-signout__list').trigger("getPostchanged");
	}
}

function isSignGetUrl(element){
	return element["@attributes"].Binding.toLowerCase().includes("http-redirect") ? true : false; //No I18N
}

function isSignPostUrl(element){
	return element["@attributes"].Binding.toLowerCase().includes("http-post") ? true : false; //No I18N
}

function updateSignUrl(singleSignService,signUrlJson){
	if(singleSignService.length>1){
			for(var key in singleSignService) {
				if(isSignGetUrl(singleSignService[key])) {
					signUrlJson.getUrl = singleSignService[key]["@attributes"].Location;
					$(".saml-login-url").val(singleSignService[key]["@attributes"].Location);
				}
				else if(isSignPostUrl(singleSignService[key])) {
					signUrlJson.postUrl = singleSignService[key]["@attributes"].Location;
				}
			}
		}
		else {
			if(isSignGetUrl(singleSignService)) {
				signUrlJson.getUrl = singleSignService["@attributes"].Location; //No I18N
			}
			else if(isSignPostUrl(singleSignService)) {
				signUrlJson.postUrl = singleSignService["@attributes"].Location; //No I18N
			}
		}
}

function getMetadata(){
	$("#saml-upload-input").click();
}

function samlPublicKeyOptionUpload() {
	removePublicKey();
	$("#saml-publickey_upload").click();
}

function isValidPublicKeyFile(fileName){
	var re = /(\.cer|\.crt|\.cert|\.pem)$/i;
	return re.exec(fileName);
}


// Removing uploaded publickey
function removePublicKey() {
	$("#saml-filename").val("");
	$("#saml-publickey").val("");
	$("#saml-publickey_upload").val("");
	$(".saml-setup__forms .close-circle").hide();
	$("#saml-file_space").hide();
	$("#saml-publickey").show();
	$("#saml-publickey_upload").trigger("change");
}

function removePublickeyError() {
	$(".publickey-filetype__text").removeClass("publickey-filetype__text--highlight");
}


// Removing uploaded metadata file values
function removeMetadata(){
	$("#saml-upload-input").val("");
	$(".saml-login-url").val("");
	$(".saml-logout-url").val("");
	$(".saml-publickey").val("");
	$('.saml-signin__lists select option[value=GET]').prop('selected', true);
	$('.saml-name-identifier option[value=email-address]').prop('selected', true);
	$(".saml-setup__update-message").hide();
	$(".saml-setup__upload-message").show();
}


// Handling of add button in parameters
function newAddSignParamField(currElement) {
	var parentId = $(currElement).parents(".saml-sign__param").attr("id");
	var selectedValueArr = [];
	$("#"+parentId+" .param-fields").children().each(function(){
		selectedValueArr.push($(this).find("select").val());
	});
	var emptyParamField = document.querySelector("#empty-saml-sign__param").children;//No I18N
	var paramField = emptyParamField[0].cloneNode(true);
	for(i=0; i<selectedValueArr.length; i++) {
		$(paramField).find("option[value='"+selectedValueArr[i]+"']").remove();
	}
	$("#"+parentId+" .param-fields").append(paramField);
	$("#"+parentId+" .param-field:last-child").prev().find(".add-circle").addClass("close-circle").attr("onclick","newRemoveSignParamField(this);");//No I18N
	if($("#"+parentId+" .param-field").length === $(emptyParamField).find("option").length) {
		$("#"+parentId+" .param-field:last-child").find(".add-circle").addClass("close-circle").attr("onclick","newRemoveSignParamField(this);");//No I18N
	}
	var currSelectedValue = $(paramField).find("select").val();
	$("#"+parentId+" .param-fields").children().each(function(){
		if(this != paramField) {
			$(this).find("option[value='"+currSelectedValue+"']").remove();
		}
	});
	$($(paramField)).find(".param-field_right input").attr("name",parentId+"_"+currSelectedValue); //no I18N
	if(org_data.SAML.saml_login_url){
		$($(paramField)).find(".param-field_right input").attr("oninput","handleParamEdit();"); //no I18N
	}
	$("#"+parentId+" .params_select").select2({
		minimumResultsForSearch: Infinity,
		theme: "saml-sign__param" //no I18N
	});
}


// Handling of remove button in parameters
function newRemoveSignParamField(currElement) {
	var parentElement = $(currElement).parents(".saml-sign__param");
	var removedOption = $(currElement).parents(".param-field").find("select").val();
	var removedOptionText = $(parentElement).find("select option[value="+removedOption+"]").text().trim();
	var removedOptionElement = "<option value="+removedOption+">"+removedOptionText+"</option>";
	if(org_data.SAML.saml_login_url){
		$(currElement).parents(".param-field").find("input").val("");
		handleParamEdit();
	}
	$(currElement).parents(".param-field").remove();
	$(parentElement).find(".param-fields").children().each(function(){
		$(this).find("select").append(removedOptionElement);
	});
	if($(parentElement).find(".param-field").length === 1) {
		$(parentElement).find(".param-field").find(".close-circle").removeClass("close-circle").addClass("add-circle").attr("onclick","newAddSignParamField(this);");//No I18N
	}
}
 
function updateSignparamInputName(currElement) {
	var parentId = $(currElement).parents(".saml-sign__param").attr("id");
	var paramField = $(currElement).parents(".param-field");
	var currSelectedValue = $(paramField).find("select").val();
	var emptyParamfieldRight = document.querySelector("#empty-saml-sign__param .param-field_right").children; //no I18N
	var emptyParamFieldRightclone = $(emptyParamfieldRight).clone();
	$($(paramField)).find(".param-field_right").html(emptyParamFieldRightclone);
	$($(paramField)).find(".param-field_right input").attr("name",parentId+"_"+currSelectedValue); //no I18N
	$($(paramField)).find(".param-field_right input").val("");
	if(org_data.SAML.saml_login_url){
		$($(paramField)).find(".param-field_right input").attr("oninput","handleParamEdit();"); //no I18N
		handleParamEdit();
	}
}


// Handling of JIT field add button
function newAddJitField() {
	var parentElement = document.querySelector(".saml-setup__JITs");//No I18N
	var selectedValueArr = [];
	$(".saml-setup__JITs").children().each(function(){
		selectedValueArr.push($(this).find("select").val());
	});
	var emptyJitField = document.querySelector("#empty-saml-setup__JIT").children;//No I18N
	var jitField = emptyJitField[0].cloneNode(true);
	for(i=0; i<selectedValueArr.length; i++) {
		$(jitField).find("option[value='"+selectedValueArr[i]+"']").remove();
	}
	var currSelectedValue = $(jitField).find("select").val();
	$(".saml-setup__JITs").children().each(function(){
		$(this).find("option[value='"+currSelectedValue+"']").remove();
	});
	$(jitField).find(".saml-setup__JIT-select").select2({
		minimumResultsForSearch: Infinity,
		theme: "saml-JIT__select" //no I18N
	});
	$($(jitField)).find(".JIT-field__right input").attr("name","jit_"+currSelectedValue); //no I18N
	parentElement.appendChild(jitField);
	$(jitField).prev().find(".add-circle").remove();
	if($(".saml-setup__JITs .saml-setup__JIT-select").length === $($("#empty-saml-setup__JIT")[0]).find("option").length) {
		$(".saml-setup__JITs").find(".add-circle").remove();
	}
	if(org_data.SAML.saml_login_url){
		$($(jitField)).find(".JIT-field__right input").attr("oninput","handleJitEdit();"); //no I18N
	}
	$(".saml-setup__body").scrollTop($(".saml-setup__body")[0].scrollHeight);
}


// // Handling of JIT field remove button
function newRemoveJitField(currElement) {
	var parentElement = $(currElement).parents(".saml-setup__JIT");
	if($(".saml-setup__JITs .saml-setup__JIT-select").length === 1) {
		$(".saml-setup__JITs").slideUp();
		$(".saml-setup__JITs").parent().find(".real_togglebtn").prop("checked", false); //no I18N
		$(".saml-setup__JITs").parent().find(".real_togglebtn").trigger("change");
		resetJitFields();
		return;
	}
	var removedOption = $(parentElement).find("select").val();
	var removedOptionText = $(parentElement).find("select option[value="+removedOption+"]").text().trim();
	var removedOptionElement = "<option value="+removedOption+">"+removedOptionText+"</option>";
	var prevElement = $(parentElement).prev();
	if(org_data.SAML.saml_login_url){
		$(parentElement).find("input").val("");
		handleJitEdit();
	}
	$(parentElement).remove();
	var currJitLength = $(".saml-setup__mode .saml-setup__JIT .JIT-field__right").length;
	var lastJitRightField = $(".saml-setup__mode .saml-setup__JIT .JIT-field__right")[currJitLength-1]; 
	$(".saml-setup__JITs").children().each(function(){
		$(this).find("select").append(removedOptionElement);
	});
	$(prevElement).find(".close-circle").remove();
	if($(".saml-setup__JITs .saml-setup__JIT-select").length <= $($("#empty-saml-setup__JIT")[0]).find("option").length - 1) {
		$(".saml-setup__JITs .JIT-field__right").each(function(){
				$(this).find(".close-circle").remove();
				$(this).find(".add-circle").remove();
				$(this).append('<div class="close-circle" onclick="newRemoveJitField(this);"></div>');
		});
	}
	$(lastJitRightField).find(".close-circle").remove();
	$(lastJitRightField).find(".add-circle").remove();
	$(lastJitRightField).append('<div class="add-circle" onclick="newAddJitField();"></div><div class="close-circle" onclick="newRemoveJitField(this);"></div>');
	
}

function updateJitSelectOption(currElement) {
	var parentElement = $(currElement).parents(".saml-setup__JIT");
	var currSelectedValue = $(parentElement).find("select").val();
	if($(".saml-setup__JITs .saml-setup__JIT-select").length > 1 && $(".saml-setup__JITs .saml-setup__JIT-select").length < $($("#empty-saml-setup__JIT")[0]).find("option").length) {
		var allSelectedValueArr = [];
		
		$("#empty-saml-setup__JIT option").each(function(){
			allSelectedValueArr.push($(this).attr("value"));
		});
		
		$(".saml-setup__JITs").children().each(function(){
			if(this != parentElement[0]) {
				$(this).find("option[value='"+currSelectedValue+"']").remove();
			}
			allSelectedValueArr.splice($.inArray($(this).find("select").val(),allSelectedValueArr),1);
		});

		var addOptionText = $(parentElement).find("select option[value="+allSelectedValueArr[0]+"]").text().trim();
		var addOptionElement = "<option value="+allSelectedValueArr[0]+">"+addOptionText+"</option>";

		$(".saml-setup__JITs").children().each(function(){
			if(this != parentElement[0]) {
				$(this).find("select").append(addOptionElement);
			}	
		});
	}
	var emptyJitRightField = document.querySelector("#empty-saml-setup__JIT .JIT-field__right").children;//No I18N
	var emptyJitRightFieldClone = $(emptyJitRightField).clone();
	$($(parentElement)).find(".JIT-field__right").html(emptyJitRightFieldClone);
	$($(parentElement)).find(".JIT-field__right input").attr("name","jit_"+currSelectedValue); //no I18N
	if(org_data.SAML.saml_login_url){
		$($(parentElement)).find(".JIT-field__right input").attr("oninput","handleJitEdit();"); //no I18N
		handleJitEdit();
	}
}

function showOrgDomains() {
	closeSamlsetupMenu();
	assignHash("org", "org_domains");//No I18N
	$("#org_domains").click();
}

function showSamlEditOption()
{
	$(".saml_opendiv").show(0,function(){
		$(".saml_opendiv").addClass("pop_anim");
	});
	closePopup(close_SAML_edit,"saml_open_cont");//No I18N
	popup_blurHandler('6');
	$('#edit_SAMLservice_name option[value='+org_data.SAML.saml_service+']').prop('selected', true);
	$('#edit_SAMLservice_name').trigger("change");
	$(".saml_select").select2();
	$("#saml_logout_check").prop("checked",org_data.SAML.issaml_logoutEnabled);
	$("#saml_open_cont input:first").focus();//No I18N	
}

function close_SAML_edit()
{
	popupBlurHide(".saml_opendiv",function(){	//No I18N
		remove_error();
	});
	return false;
}

function deleteSaml(title,desc) 
{
	show_confirm(title,desc,
		    function() 
		    {
				new URI(SAMLObj,"self").DELETE().then(function(resp)	//No I18N
						{
							SuccessMsg(getErrorMessage(resp));
							org_data.SAML.issaml_loginenabled=false;
							org_data.SAML.issaml_enabled=false;
							org_data.SAML.issaml_logoutEnabled=false;
							
							delete org_data.SAML.jit_attributes;							
							delete org_data.SAML.saml_login_url;
							delete org_data.SAML.saml_logout_url;
							delete org_data.SAML.saml_password_url;
							delete org_data.SAML.saml_algorithm;
							delete org_data.SAML.saml_service;
							
							load_samldetails(org_data.SAML);
							
							close_SAML_edit();
						},
						function(resp)
						{
							if(resp.cause && resp.cause.trim() === "invalid_password_token") 
							{
								relogin_warning();
								var service_url = euc(window.location.href);
								$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
							}
							else
							{
								showErrorMessage(getErrorMessage(resp));
							}
						});
		    },
		    function() 
		    {
		    	return false;
		    }
		);
}



function samlPublicKeyOption(canShowUploadOption) 
{

	$("#saml_publickey").val("");
	$("#saml_publickey_upload").click();
	$("#saml_publickey_upload").change(function () 
	{
		$("#saml_filename").val($("#saml_publickey_upload").prop("files")[0].name);
		$("#saml_file_space").show();
		$("#saml_publickey").hide();
		$('#saml_publickey_upload').unbind();
	});
			
}


function changebacktotext()
{
	$("#saml_filename").val("");
	$("#saml_file_space").hide();
	$("#saml_publickey").show();
	$("#saml_publickey_upload").val("");
}