//$Id$
function setFormat() 
{
    var selected=de("format").value;//No i18N
    if(selected=="custom") 
    {
        if(de('customizeFormat')) 
        {
            $('#customizeFormat').show();
            $('#custom').val(settings_data.UserPreferences.date_format);
            de('custom').focus();//No i18N
        }
    }else 
    {
    	$('#customizeFormat').hide();
    }
}

function check_disable(ele){
	if(ele.value.length>0){
	if(ele.value===settings_data.UserPreferences.date_format){
		$(savedateformat).children("button").addClass("pref_disable_btn");
		$(savedateformat).children("button").removeClass("primary_btn_check");
		$(savedateformat).children("button").attr("disabled", "disabled");
	}
	else{
		$(savedateformat).children("button").removeAttr("disabled");
		$(savedateformat).children("button").removeClass("pref_disable_btn");
		$(savedateformat).children("button").addClass("primary_btn_check");
	}
	}
}
function load_Preferencedetails(Policies,Preferences)
{
	if(Preferences.exception_occured!=undefined	&&	Preferences.exception_occured)
	{
		return;
	}
    if(!isEmpty(Preferences.date_format)) 
    {
    	$("#popup_user-preference_contents option").prop('selected', false);
    	if(Preferences.is_custom_date_format==undefined	||	!Preferences.is_custom_date_format) 
    	{
    		de(Preferences.date_format).setAttribute("selected", "selected");
    		$("#current_date_format").html(date_and_time_desc);
    	}
    	else
    	{
    		var option = document.createElement("option");
    		option.value = Preferences.date_format;
    		option.innerText = Preferences.date_format +" ("+ custom_dateformat +")"; //No I18N
    		$(option).insertBefore('select#format option:nth-child(2)');
    		$('select#format option:nth-child(2)').prop("selected", true); //No I18N
    	}
    }
    
	if(Preferences.photo_permission!=undefined) 
	{
		//de(Preferences.photo_permission).setAttribute("selected", "selected");//No i18N
		$("#ppviewid #user_pref_photoview_permi #"+Preferences.photo_permission).prop('selected', true);
    }

    if(de('password_expiry')	||	de('sign_in_notification')) 
    {
    	if(Preferences.password_notification) 
        {
        	$("#password_notification").prop("checked", true);
        }
    	else
    	{
    		$("#password_notification").prop("checked", false);
    	}
    	
    }
    var newsletter=Preferences.newsletter_subscription;
    if(newsletter!=undefined) 
    {
        if(newsletter=="0")
        {
        	$("#subscription_values").html(no_subscription);
        	$('#news_letter').removeAttr("checked");
       	}
        else 
        {
        	de('news_letter').setAttribute('checked', "checked");
        	$("#subscription_values").html(no_subscription);
        }
   	}
    
    $("#dateformatid #format").uvselect({
    	width:"220px", //No I18N
    	"dropdown-align": "right", //No I18N
    	"searchable": true, //No I18N
    	"onDropdown:select" : function(selected_option){ //No I18N
    		var selected_date = selected_option.value;
    		get_date_and_time(selected_date);
    	},
    	"break-option-text": "(", //No I18N
    	"onDropdown:open" : function(dropdown){ //No I18N
    		$(dropdown).find('.option_text_span_2').css({"color":"#999999","font-size": "13px"}); //No I18N
    	}
    });

    $("#ppviewid #user_pref_photoview_permi").uvselect();
    if(Preferences.is_photo_permission_disabled){    	
    	$("#user_pref_photoview_permi+.uvselect").addClass("disabled_option");
    	$("#ppviewid .disabled_tag").show();
    	$("#ppviewid .disable_tooltip span").html(escapeHTML($("select#user_pref_photoview_permi option:selected").html()));
    }else{
    	$("#ppviewid .disabled_tag").hide();	
    }
    
    var suspicious_sign = Preferences.signin_alert_enabled;
    if(suspicious_sign != undefined && suspicious_sign) {
    	$("#sign_in_notification").prop("checked", true);
    }
    
    var mail_client = Preferences.mc_alert_enabled;
    if(mail_client != undefined && mail_client) {
    	$("#tparty_access_notification").prop("checked", true);
    }
    
    var is_signin_alert_enforced_by_admin = Preferences.signin_alert_enforced;
    if(is_signin_alert_enforced_by_admin != undefined && is_signin_alert_enforced_by_admin) {
    	//Enforced by admin tag 
    	$("#user_signin_notifications").find(".pref_enforced_tag_box").removeClass("hide");
    	$("#user_signin_notifications").find(".togglebase").addClass("pref_toggle_disabled");
    	$("#sign_in_notification").prop("disabled", true);
    }
    
    var is_mailclient_alert_enforced_by_admin = Preferences.mc_alert_enforced;
    if(is_mailclient_alert_enforced_by_admin != undefined && is_mailclient_alert_enforced_by_admin) {
    	//Enforced by admin tag
    	$("#third_party_access_notifications").find(".pref_enforced_tag_box").removeClass("hide");
    	$("#third_party_access_notifications").find(".togglebase").addClass("pref_toggle_disabled");
    	$("#tparty_access_notification").prop("disabled", true);
    }
}
function showuser_pref_dateformat(heading,description,button,action)
{
	set_popupinfo(heading,description);
	$('#popup_user-preference_action span').html(button);
	
	$("#popuphead_icon").attr('class','')
	$('#popuphead_icon').addClass("settings_icon");
	
	
	$("#popup_user-preference_contents form").attr("name",action);
	
	
	$('#popup_user-preference_action').attr("onclick","save_date_format(document."+action+")");
	
	$("#user_pref_dateformat").show();
	$("#user_pref_photoview_permi").hide();
	if(de("user_pref_notifications"))
	{
		$("#user_pref_notifications").hide();
	}
	if(de("user_pref_subscriptions"))
	{
		$("#user_pref_subscriptions").hide();
	}
	$("#pop_action").html($("#popup_user-preference_contents").html()); //load into popuop
//	if(!isMobile){
//		$('#pop_action #format').select2({
//			width:"320px"		//No I18N
//			}).on("select2:close", function (e) { 
//				$(e.target).siblings(".select2").find(".select2-selection--single").focus();
//		});
//		$('#pop_action #hours_type').select2({
//			width:"320px",//No I18N
//			minimumResultsForSearch: Infinity
//		});
//		$("#format").select2({
//			language: {
//		        noResults: function(){
//		            return iam_no_result_found_text;
//		        }
//		    }
//		});
//	}
	
	$(savedateformat).children("button").addClass("pref_disable_btn");
	$(savedateformat).children("button").removeClass("primary_btn_check");
	$(savedateformat).children("button").attr("disabled", "disabled");
	
	$("#pop_action select").change(function(){
		if(document.savedateformat.date_format.value!=settings_data.UserPreferences.date_format){
			$(savedateformat).children("button").removeClass("pref_disable_btn");
			$(savedateformat).children("button").addClass("primary_btn_check");
			$(savedateformat).children("button").removeAttr("disabled");
		}
		else
		{
			$(savedateformat).children("button").addClass("pref_disable_btn");
			$(savedateformat).children("button").removeClass("primary_btn_check");
			$(savedateformat).children("button").attr("disabled", "disabled");
		}
	});
	setFormat();
	$("#common_popup .close_btn").click(function(){
		$("#dateformatid #format").val(settings_data.UserPreferences.date_format).trigger('change');
	});
	closePopup(close_popupscreen,"common_popup");//No I18N
	$("#popup_user-preference_contents form").attr("name","");
	$("#user_pref_dateformat .select2-selection:first").focus(); 
}

function save_date_format(f)
{
	
	var selected=f.custom.value.trim();
	custom=1;
	disabledButton(f);
	var parms=
	{
		"dateformat":selected//No I18N
	};
	
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		settings_data.UserPreferences.date_format= f.custom.value;
		settings_data.UserPreferences.is_custom_date_format=true;

		close_popupscreen();
		removeButtonDisable(f);
		SuccessMsg(getErrorMessage(resp));
		load_Preferencedetails(settings_data.Policies,settings_data.UserPreferences);
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
		removeButtonDisable(f);
	});	
}

function get_date_and_time(selected) {
	if(selected=="custom")
	{
		custom=1;
		showuser_pref_dateformat(date_and_time_title,date_and_time_desc,date_and_time_cta,'savedateformat'); //NO I18N
	} else {
		selected=selected.trim();
		custom=0;
		new_save_date_format(selected, custom);
	}
}

function new_save_date_format(selected, custom)
{
	var parms=
	{
		"dateformat":selected//No I18N
	};
	
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		if(custom==1)
		{
			settings_data.UserPreferences.date_format= selected;
			settings_data.UserPreferences.is_custom_date_format=true;
		}
		else
		{
			settings_data.UserPreferences.date_format= selected;
			settings_data.UserPreferences.is_custom_date_format=false;
		}
		SuccessMsg(getErrorMessage(resp));
		load_Preferencedetails(settings_data.Policies,settings_data.UserPreferences);
	},
	function(resp)
	{
		
		if(resp.cause && resp.cause.trim() === "invalid_password_token") 
		{
			$("#dateformatid #format").val(settings_data.UserPreferences.date_format).trigger('change');
			relogin_warning();
			var service_url = euc(window.location.href);
			$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
		}
		else
		{
			$("#dateformatid #format").val(settings_data.UserPreferences.date_format).trigger('change');
			showErrorMessage(getErrorMessage(resp));				
		}
		
	});
	
	
}



function showuser_pref_photoview_permi(heading,description,button,action)
{
	set_popupinfo(heading,description);
	$('#popup_user-preference_action span').html(button);
	
	$("#popuphead_icon").attr('class','')
	$('#popuphead_icon').addClass("settings_icon");
	
	
	$("#popup_user-preference_contents form").attr("name",action);
	
	
	$('#popup_user-preference_action').attr("onclick","save_photoview_permi(document."+action+")");
	
	$("#user_pref_dateformat").hide();
	$("#user_pref_photoview_permi").show();
	if(de("user_pref_notifications"))
	{
		$("#user_pref_notifications").hide();
	}
	if(de("user_pref_subscriptions"))
	{
		$("#user_pref_subscriptions").hide();
	}
	
	$("#pop_action").html($("#popup_user-preference_contents").html()); //load into popuop
	
	$("#popup_user-preference_contents form").attr("name","");
	$(savephotoview_permi).children("button").addClass("pref_disable_btn");
	$(savephotoview_permi).children("button").removeClass("primary_btn_check");
	$(savephotoview_permi).children("button").attr("disabled", "disabled");
	
	$(".photo_radio").change(function(){
		if($(".photo_radio:visible:checked").attr("id")!=settings_data.UserPreferences.photo_permission){
			$(savephotoview_permi).children("button").removeClass("pref_disable_btn");
			$(savephotoview_permi).children("button").addClass("primary_btn_check");
			$(savephotoview_permi).children("button").removeAttr("disabled");			
		}
		else
		{
			$(savephotoview_permi).children("button").addClass("pref_disable_btn");
			$(savephotoview_permi).children("button").removeClass("primary_btn_check");
			$(savephotoview_permi).children("button").attr("disabled", "disabled")
		}
	});
	//$("#common_popup .real_radiobtn:first").focus();
	
	
	$("#common_popup").focus();
	closePopup(close_popupscreen,"common_popup");//No I18N
}

function save_photoview_permi(f)
{
	var selected=f.ppview.value;
	
	var parms=
	{
		"photo_Permission":selected//No I18N
	};
	disabledButton(f);
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		$(".photo_radio").removeAttr( "checked" );
		$("#popup_user-preference_contents #"+selected).attr("checked","checked");
		settings_data.UserPreferences.photo_permission=photoPermission=selected;
		close_popupscreen();
		removeButtonDisable(f);
		SuccessMsg(getErrorMessage(resp));
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

function new_save_photoview_permi(selected) {
	var parms=
	{
		"photo_Permission":selected//No I18N
	};
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		if(settings_data){
			settings_data.UserPreferences.photo_permission = photoPermission = selected;
		}
		else{
			profile_data.photo_permission = photoPermission = selected;
		}
		
		SuccessMsg(getErrorMessage(resp));
	},
	function(resp)
	{
		if($("#profile_photoview_permi").length != 0){
			$("#profile_photoview_permi").uvselect("destroy");
			$("#profile_photoview_permi").val(profile_data.photo_permission).uvselect({
				"dropdown-width": "245px", //No i18N
				"onDropdown:open" : function(dropdown){ //No I18N
					$(dropdown).find("li:visible").each(function(ind,ele){
					    $(ele).find("p").before("<i class='photo_perm_list_icon icon-"+$(ele).attr("data-id")+"'></i>");		//No I18N
					});
		    	}
			});
			$(".profile_photoview_permi .selectbox_overlay").after("<i id='photo_perm_icon' class='icon-"+$("#profile_photoview_permi option:selected").attr("id")+"'></i>");
			$(".profile_photoview_permi .select_input").hide();
		}
		else{
			$("#ppviewid #user_pref_photoview_permi").uvselect("destroy");
			$("#ppviewid #user_pref_photoview_permi").val(settings_data.UserPreferences.photo_permission).uvselect();
		}
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

function showuser_pref_notifications(heading,description,button,action)
{
	set_popupinfo(heading,description);
	$('#popup_user-preference_action span').html(button);
	
	$("#popuphead_icon").attr('class','')
	$('#popuphead_icon').addClass("settings_icon");
	
	
	$("#popup_user-preference_contents form").attr("name",action);
	
	
	$('#popup_user-preference_action').attr("onclick","save_notification_changes(document."+action+")");
	
	$("#user_pref_dateformat").hide();
	$("#user_pref_photoview_permi").hide();
	if(de("user_pref_notifications"))
	{
		$("#user_pref_notifications").show();
	}
	if(de("user_pref_subscriptions"))
	{
		$("#user_pref_subscriptions").hide();
	}
	
	$("#pop_action").html($("#popup_user-preference_contents").html()); //load into popuop
	
	$(".pp_popup").addClass("custom_date_popup");
	
	$("#popup_user-preference_contents form").attr("name","");
		
	$(save_email_notification).children("button").addClass("pref_disable_btn");
	$(save_email_notification).children("button").attr("disabled", "disabled");
	$(save_email_notification).children("button").removeClass("primary_btn_check");
	
	 
	if(de("password_expiry"))
	{
		$("#password_expiry").change(function()
		{
			if($("#sign_in_notification"). prop("checked")!=settings_data.UserPreferences.password_notification)
			{
				$(save_email_notification).children("button").removeClass("pref_disable_btn");
				$(save_email_notification).children("button").addClass("primary_btn_check");
				$(save_email_notification).children("button").removeAttr("disabled");
			}
			else
			{
				$(save_email_notification).children("button").addClass("pref_disable_btn");
				$(save_email_notification).children("button").removeClass("primary_btn_check");
				$(save_email_notification).children("button").attr("disabled", "disabled");
			}
		});
	}
	
	
	closePopup(close_popupscreen,"common_popup");//No I18N
	$("#common_popup").focus();
}

function new_showuser_pref_notifications(notify_option) {		
		var password=$('#'+notify_option).prop('checked');
		var parms=
		{
			"pass_expiry":password//No I18N
		};
		var payload = PreferencesObj.create(parms);
		
		payload.PUT("self","self").then(function(resp)	//No I18N
		{		
			SuccessMsg(getErrorMessage(resp));
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
			revert_toggle(notify_option);						
		});	
}

function revert_toggle(toggle_id) {
	var toggle_val = $("#"+toggle_id).prop("checked");
	if(toggle_val) {
		$('#'+toggle_id).prop('checked', false);
	} else {
		$('#'+toggle_id).prop('checked', true);
	}
}

function undo_action(toggle_id, toggle_val, callback ) {
	revert_toggle(toggle_id);
	callback(toggle_id);
}

function save_notification_changes(f)
{	
	var password=$('#password_expiry').prop('checked');
	var parms=
	{
		"pass_expiry":password//No I18N
	};
	disabledButton(f);
	var payload = PreferencesObj.create(parms);
	
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
			
		settings_data.UserPreferences.password_notification=password;
		$("#sign_in_notification").unbind()
		close_popupscreen();
		load_Preferencedetails(settings_data.Policies,settings_data.UserPreferences);
		removeButtonDisable(f);
		SuccessMsg(getErrorMessage(resp));
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




function showuser_pref_subscriptions(heading,description,button,action)
{
	set_popupinfo(heading,description);
	$('#popup_user-preference_action span').html(button);
	
	$("#popuphead_icon").attr('class','')
	$('#popuphead_icon').addClass("settings_icon");
	
	
	$("#popup_user-preference_contents form").attr("name",action);
	
	
	$('#popup_user-preference_action').attr("onclick","save_subscription_changes(document."+action+")");
	
	$("#user_pref_dateformat").hide();
	$("#user_pref_photoview_permi").hide();
	if(de("user_pref_notifications"))
	{
		$("#user_pref_notifications").hide();
	}
	if(de("user_pref_subscriptions"))
	{
		$("#user_pref_subscriptions").show();
	}
	
	$("#pop_action").html($("#popup_user-preference_contents").html()); //load into popuop
	
	$(".pp_popup").addClass("user_suscription_popup");
	
	$("#popup_user-preference_contents form").attr("name","");
	
	
	$(save_browser_subscriptions).children("button").addClass("pref_disable_btn");
	$(save_browser_subscriptions).children("button").removeClass("primary_btn_check");
	$(save_browser_subscriptions).children("button").attr("disabled", "disabled");
	
	
	$("#news_letter").change(function(){	  
		var init_val = settings_data.UserPreferences.newsletter_subscription!=0?true:false; 
		if(init_val!=$('#news_letter').is(':checked')){
			$(save_browser_subscriptions).children("button").removeClass("pref_disable_btn");
			$(save_browser_subscriptions).children("button").addClass("primary_btn_check");
			$(save_browser_subscriptions).children("button").removeAttr("disabled");
		}
		else
		{
			$(save_browser_subscriptions).children("button").addClass("pref_disable_btn");
			$(save_browser_subscriptions).children("button").removeClass("primary_btn_check");
			$(save_browser_subscriptions).children("button").attr("disabled", "disabled");
		}
	});

	closePopup(close_popupscreen,"common_popup");//No I18N
	
	
	
	$("#common_popup").focus();
	
}

function save_subscription_changes(f)
{	
    var userSubscription = $('#news_letter').is(':checked');//No I18N
    
	var parms=
	{
			"subscription":userSubscription//No I18N
	};
	
	var payload = PreferencesObj.create(parms);
	disabledButton(f);
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		var userSubscription=resp.preferences.userSubscription;
		settings_data.UserPreferences.newsletter_subscription=userSubscription;
		if(userSubscription==0)
		{
			$("#subscription_values").html(no_subscription);
			$('#popup_user-preference_contents #news_letter').removeAttr('checked');
        	$("#double_opt").addClass("hide");
		}
		else
		{
			$('#popup_user-preference_contents #news_letter').attr('checked', "checked");
			if(userSubscription==2)
			{
				$("#subscription_values").html($("#double_opt").html());
				$("#double_opt").removeClass("hide");
			}
			else
			{
				$("#subscription_values").html(newsletter_suscribed);
				$("#double_opt").addClass("hide");
			}
			
		}
		close_popupscreen();
		removeButtonDisable(f);
		SuccessMsg(getErrorMessage(resp));
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

function new_save_subscription_changes( alert_notify_option ) {
	
	var user_subscription = $('#'+alert_notify_option).is(':checked');//No I18N
	var parms=
	{
			"subscription": user_subscription//No I18N
	};
	
	var payload = PreferencesObj.create(parms);

	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		var userSubscription=resp.preferences.userSubscription;
		settings_data.UserPreferences.newsletter_subscription=userSubscription;
		$("#subscription_values").html(no_subscription);
		SuccessMsg(getErrorMessage(resp));

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
		revert_toggle(alert_notify_option);		
	});	
	
}

function new_signin_alert_notifications( signin_alert_option) {
	var suspicious_alert = $('#'+signin_alert_option).is(':checked');//No I18N
	var parms=
	{
			"signin_alert": suspicious_alert//No I18N
	};
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		settings_data.UserPreferences.signin_alert_enabled = suspicious_alert;
		SuccessMsg(getErrorMessage(resp));
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
		revert_toggle(signin_alert_option);
	});

}


function new_third_pty_access_notifications(tparty_alert_option) {
	
	var tparty_alert = $('#'+tparty_alert_option).is(':checked');//No I18N
	var parms=
	{
			"mc_alert": tparty_alert//No I18N
	};
	var payload = PreferencesObj.create(parms);
	
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		settings_data.UserPreferences.mc_alert_enabled = tparty_alert;
		SuccessMsg(getErrorMessage(resp));
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
		revert_toggle(tparty_alert_option);
	});
}



/***************************** authorized websites *********************************/


function load_AuthWebsitesdetails(Policies,Auth_websites)
{
	if(de("auth_websites_exception"))
	{
		$("#auth_websites_exception").remove();
		$("#no_authwebistes").removeClass("hide");
	}
	if(Auth_websites.exception_occured!=undefined	&&	Auth_websites.exception_occured)
	{
		$("#auth_websites_box .box_info" ).after("<div id='auth_websites_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#auth_websites_exception #reload_exception").attr("onclick","reload_exception(AuthorizedWebsites,'auth_websites_box')");
		$("#no_authwebistes").addClass("hide");
		return;
	}
	
	if(Auth_websites!=undefined && !jQuery.isEmptyObject(Auth_websites))
	{
		var domains=timeSorting(Auth_websites);
		$("#no_authwebistes").hide();
		$("#all_webistes_authorized").show();
		var count=0;
		$("#all_webistes_authorized").html("");
		for(iter=0;iter<Object.keys(domains).length;iter++)
		{
			count++;
			var current_domain=Auth_websites[domains[iter]];
			
			webistes_format = $("#empty_AuthSites_format").html();
			$("#all_webistes_authorized").append(webistes_format);
			
			$("#all_webistes_authorized #authdomain_entry").attr("id","authdomain_entry"+count);
			$("#all_webistes_authorized #authdomain_info").attr("id","authdomain_info"+count);
			
			$("#authdomain_entry"+count).attr("onclick","show_revokeAccess("+count+");");
			if(count > 3)
			{
				$("#authdomain_entry"+count).addClass("authweb_entry_hidden");  
			}
			 $("#authdomain_entry"+count+" #popup_head").attr("id","popup_head"+count);
			 $("#authdomain_entry"+count+" .aw_dp").addClass(color_classes[gen_random_value()]);
			 $("#popup_head"+count+" .aw_dp").html((current_domain.domian_name).substring(0,2).toUpperCase());
			 $("#popup_head"+count+" .aw_name").html(current_domain.domian_name);
			 $("#popup_head"+count+" .aw_time").html(current_domain.created_time_elapsed);
			 
			 $("#authdomain_info"+count+" #authdomain_date .info_value").html(current_domain.created_date);
			 if(current_domain.ip_address!=null && current_domain.ip_address!="")
			 {
				 $("#authdomain_info"+count+" #authdomain_ip").show();
				 $("#authdomain_info"+count+" #authdomain_ip .info_value").html(current_domain.ip_address);
			 }
			
			if(current_domain.location!=undefined)
			{
					$("#authdomain_info"+count+" #location_div .info_value").removeClass("unavail");
					$("#authdomain_info"+count+" #location_div .info_value").html(current_domain.location.toLowerCase());
			}
			$("#authdomain_info"+count+" #authdomain_action").attr("onclick","revokeAccess('"+current_domain.domian_name+"');");
		}
		if(count>3)
		{
			$("#auth_websites_viewall").show();
			if(count>4)
			{
				$("#auth_websites_viewall").html(formatMessage(i18nAuthoWebkeys["IAM.VIEWMORE.WEBSITES"],count-3)); //NO I18N
			}
			else
			{
				$("#auth_websites_viewall").html(formatMessage(i18nAuthoWebkeys["IAM.VIEWMORE.WEBSITE"],count-3)); //NO I18N
			}
		}
		else{
			$("#auth_websites_viewall").hide();
		}
	}
	else
	{
		$("#no_authwebistes").show();
		$("#all_webistes_authorized").hide();
		$("#auth_websites_viewall").hide();
	}
	
}

function close_authorized_web_screen()
{
	popupBlurHide("#popup_authorized-web_contents",function(){		//No I18N 
		$("#authweb_popup_head").html(""); 
		$("#authweb_popup_info").html("");
	});
}

function show_all_websites()
{

	$("#view_more_contents").html($("#all_webistes_authorized").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_more_contents .authweb_entry_hidden").show();
	$("#view_more_contents .Field_session").addClass("viewall_authwebentry");
	$("#view_more_contents .Field_session").removeAttr("onclick");

	
	
	$("#authorized_web_more").show(0,function(){
		$("#authorized_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_more_contents .Field_session").click(function(){
		

		var id=$(this).attr('id');
		$("#view_more_contents .Field_session").addClass("autoheight");
		$("#view_more_contents .aw_info").slideUp(300);
		$("#view_more_contents .action_info").show();
		if($("#view_more_contents #"+id).hasClass("web_email_specific_popup"))
		{			
			$(".aw_info a").unbind();
			$("#view_more_contents #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_more_contents #"+id).removeClass("web_email_specific_popup");
				$("#view_more_contents .Field_session").removeClass("autoheight");
			});
		}
		else
		{
			$("#view_more_contents .Field_session").removeClass("web_email_specific_popup");
			$("#view_more_contents #"+id).addClass("web_email_specific_popup");
			$("#view_more_contents #"+id+" .action_info").hide();
			$("#view_more_contents #"+id+" .aw_info").slideDown(300,function(){
				control_Enter(".aw_info a");//No I18N
				$("#view_more_contents .Field_session").removeClass("autoheight");
			});

			//$("#authorized_web_more .primary_btn_check").focus();
		}

		
	});
	closePopup(closeview_all_autho_web,"authorized_web_more");//No I18N
	$("#authorized_web_more").focus();
}
function closeview_all_autho_web()
{
	popupBlurHide("#authorized_web_more",function(){		 //No I18N
		$("#view_more_contents").html("");
	});
}



function show_revokeAccess(id)
{
	$("#popup_authorized-web_contents #authweb_popup_head").html($("#popup_head"+id).html()); //load into popuop
	$("#popup_authorized-web_contents #authweb_popup_info").html($("#authdomain_info"+id).html()); //load into popuop
	
	
	popup_blurHandler('6');
	$("#popup_authorized-web_contents").show(0,function(){
		$("#popup_authorized-web_contents").addClass("pop_anim");
	});
	
	closePopup(close_authorized_web_screen,"popup_authorized-web_contents");//No I18N
	$("#popup_authorized-web_contents .primary_btn_check").focus();
}


function revokeAccess(domain)
{
	if($("#authorized_web_more").is(":visible")){
		disabledButton($("#authorized_web_more .aw_info:visible"));	
	}
	else{
		disabledButton($("#popup_authorized-web_contents"));
	}
    new URI(AuthWebsitesObj,"self","self",domain).DELETE().then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		delete settings_data.AuthorizedWebsites[domain];
	    close_authorized_web_screen();
		load_AuthWebsitesdetails(settings_data.Policies,settings_data.AuthorizedWebsites);
		var lenn=Object.keys(settings_data.AuthorizedWebsites).length;
		if(($("#authorized_web_more").is(":visible")==true)&&(lenn>1)){
				$("#authorized_web_more").hide();
				$("#view_more_contents").html("");
				removeButtonDisable($("#authorized_web_more .aw_info"));
				show_all_websites();
		}
		else{
			$(".blur").css({"z-index":"6","opacity":".5"});
			closeview_all_autho_web();
			removeButtonDisable($("#popup_authorized-web_contents"));
		}	

	},
	function(resp)
	{
		if($("#authorized_web_more").is(":visible"))
		{
			removeButtonDisable($("#authorized_web_more .aw_info"));
		}
		else{
			removeButtonDisable($("#popup_authorized-web_contents"));
		}
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












/***************************** linked accounts *********************************/


function load_Linked_Accountsdetails(Policies,Linked_Accounts)
{
	if(de("linked_acc_exception"))
	{
		$("#linked_acc_exception").remove();
		$("#no_linkedaccount").removeClass("hide");
	}
	if(Linked_Accounts.exception_occured!=undefined	&&	Linked_Accounts.exception_occured)
	{
		$("#linked_acc_box .box_info" ).after("<div id='linked_acc_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#linked_acc_exception #reload_exception").attr("onclick","reload_exception(LinkedAccounts,'linked_acc_box')");
		$("#no_linkedaccount").addClass("hide");
		return;
	}
	
	$("#settingsubmenu #linkedaccounts").show();
	$("#linkedaccounts_space").show();
	
	if(Linked_Accounts!=undefined && !jQuery.isEmptyObject(Linked_Accounts.Account_details))
	{
		$("#all_linked_accounts, .add_new_account_container").show();
		$("#no_linkedaccount, #all_idps").hide();
		var linkedAccount=Object.keys(Linked_Accounts.Account_details);
		var count=0;
		$("#all_linked_accounts").html("");
		for(iter=0;iter<linkedAccount.length;iter++)
		{
			count++;
			var current_account=Linked_Accounts.Account_details[linkedAccount[iter]];
			webistes_format = $("#empty_LinkedSites_format").html();
			$("#all_linked_accounts").append(webistes_format);
			
			$("#all_linked_accounts #linked_accountnum").attr("id","linked_accountnum"+count);
			$("#all_linked_accounts #linked_account_info").attr("id","linked_account_info"+count);
			$("#linked_accountnum"+count).attr("onclick","show_removelinkedaccount("+count+","+JSON.stringify(current_account)+",'"+current_account.created_date+"');");
			if(count > 3)
			{
				$("#linked_accountnum"+count).addClass("authweb_entry_hidden");  
			}
			
			//$("#linked_accountnum"+count+" .authweb_entry_headder .aw_dp").addClass("dp_"+current_account.idp_info);
			if(!(current_account.idp_name.indexOf("_small") > -1 || current_account.idp_name.indexOf("_SMALL") > -1 )){
				current_account.idp_name += "_SMALL";  //NO I18N
			}
			$("#linked_accountnum"+count+" .authweb_entry_headder .aw_dp_font_icon").addClass("icon-"+current_account.idp_name.toLowerCase()); //NO I18N
			$("#linked_accountnum"+count+" .authweb_entry_headder .aw_dp_font_icon").html(fontIconIdpNameToHtmlElement[current_account.idp_name]);  //NO I18N
			$("#linked_accountnum"+count+" .authweb_entry_headder .aw_disc .aw_name").html(current_account.idp_email);
			$("#linked_accountnum"+count+" .authweb_entry_headder .aw_disc .aw_time").html(current_account.created_time_elapsed);
			if(current_account.ip_info != undefined) {
				$("#linked_accountnum"+count+" .authweb_entry_headder .created_location").html(current_account.ip_info.toLowerCase());
				$("#link_account_info .info_div #pop_up_location").html(current_account.ip_info.toLowerCase());
			}
			$("#linked_account_info"+count+" #linked_acc_action").attr("onclick","removelinkedaccount('"+linkedAccount[iter]+"');");
			$("#linked_accountnum"+count).find(".browser_icon").addClass("icon-"+current_account.browser_info.browser_image +" asession_browser");
			var browser_name = current_account.browser_info.bversion && current_account.browser_info.bversion != "-1" ?  current_account.browser_info.browser_name+" "+current_account.browser_info.bversion : current_account.browser_info.browser_name;
			$("#linked_accountnum"+count).find(".browser_icon").attr("title",browser_name);
			$("#linked_accountnum"+count).find(".browser_icon").html(fontIconBrowserToHtmlElement[current_account.browser_info.browser_image]);
			$("#linked_accountnum"+count).find(".os_icon").addClass("icon-os_"+current_account.device_info.os_img+" asession_os"); //NO I18N
			$("#linked_accountnum"+count).find(".os_icon").attr("title",current_account.device_info.os_name + (current_account.device_info.version ? " "+current_account.device_info.version : "")); //NO I18N
			$("#linked_accountnum"+count).find(".os_icon").html(fontIconBrowserToHtmlElement[current_account.device_info.os_img]); //NO I18N
		}
		$("#link_new_account").removeClass("linked_accounts_view_more");
		$("#link_new_account_view_more_box").hide();
		$("#link_new_account").show();
		if(count>3)
		{
			$("#link_new_account_view_more_box").show();
			$("#link_new_account").addClass("linked_accounts_view_more");
			$("#link_new_account").hide();
			if(count>4)
			{
				$("#link_new_account_view_more_box .view_more").html(formatMessage(i18nLinkedAcckeys["IAM.VIEWMORE.ACCOUNTS"],count-3)); //NO I18N
			}
			else
			{
				$("#link_new_account_view_more_box .view_more").html(formatMessage(i18nLinkedAcckeys["IAM.VIEWMORE.ACCOUNT"],count-3)); //NO I18N
			}
		}
		if(Linked_Accounts.enable_thirdparty_signin)
		{
			$("#idps_slide_container").show();
			$("#saml_enforced_wrapper").hide();
		}
		else
		{
			$("#idps_slide_container").hide();
			$("#saml_enforced_wrapper").show();
		}
		$("#IDP_container_slideup").unbind("click").click(function() {
			IDP_container_slideup();
		});
		sessiontipSet(".Field_session .os_icon");//No I18N
		sessiontipSet(".Field_session .browser_icon");//No I18N
	}
	else
	{
		if(Linked_Accounts.enable_thirdparty_signin)
		{
			$(".add_new_account_container").show();
			$("#all_idps").hide();
			$("#no_linkedaccount").show();
			$("#all_linked_accounts").hide();
			$("#link_new_account_view_more_box").hide();
			$("#saml_enforced_wrapper").hide();
		}
		else
		{
			$("#settingsubmenu #linkedaccounts").hide();
			$("#linkedaccounts_space").hide();
		}
		
		$("#IDP_container_slideup").unbind("click").click(function() {
			IDP_container_slideup(true);
		});
	}
}

function link_account_response(resp_obj) {
	if(resp_obj.status == "success") {
		SuccessMsg(resp_obj.message, 5000);
		$settings.load("setting"); //NO I18N
		$(window).unbind('beforeunload');
	} else {
		showErrorMessage(resp_obj.message);
	}  
}

function thirdparty_authentication(idpProvider) {	
		if(idpProvider != null	&&	settings_data.LinkedAccounts.enable_thirdparty_signin) 
		{
			var oldForm = document.getElementById(idpProvider + "form");
			if(oldForm) 
			{
				document.documentElement.removeChild(oldForm);
			}
			var form = document.createElement("form");
			var action = encodeURI("/linkaccount/add?provider="+idpProvider.toUpperCase()); //No I18N
			var hiddenField = document.createElement("input");
	   	    hiddenField.setAttribute("type", "hidden");
	   	    hiddenField.setAttribute("name", csrfParam);
	        hiddenField.setAttribute("value", euc(getCookie(csrfCookieName))); 
	        form.appendChild(hiddenField);
			form.setAttribute("id", idpProvider + "form");
			form.setAttribute("method", "POST");
		    form.setAttribute("action", action);
		    form.setAttribute("target", "_blank");
	    	form.appendChild(hiddenField);
	    	document.documentElement.appendChild(form);
	    	form.submit();
		}
}

function show_removelinkedaccount(id, current_account, date)
{
	
	$("#popup_linked-accounts_contents #linked_acc_popup_head").html($("#linked_accountnum"+id+" .authweb_entry_headder").html()); //load into popuop
	$("#linked_acc_popup_head .aw_disc .aw_name").html(current_account.idp_name);
	$("#linked_acc_popup_head .aw_disc .aw_time").html(current_account.idp_email);
	$("#popup_linked-accounts_contents #linked_acc_popup_info").html($("#linked_account_info"+id).html()); //load into popuop
	$("#linked_acc_popup_head").find(".linked_acc_details").css("display", "none");
	$("#link_account_info").find("#pop_up_time").html(date);
	$("#pop_up_os, #pop_up_browser").find("span").remove();
	$("#popup_linked-accounts_contents #pop_up_location").text($("#linked_acc_popup_head .created_location").text().toLowerCase());
	var popOsElement = $("#pop_up_os").find(".asession_os_popup")[0];
	$(popOsElement).removeAttr("class");
	$(popOsElement).addClass("asession_os_popup");
	$("#pop_up_os .asession_os_popup").addClass("icon-os_"+current_account.device_info.os_img);
	$("#pop_up_os .asession_os_popup").html(fontIconBrowserToHtmlElement[current_account.device_info.os_img]);
	$("#pop_up_os").append("<span>"+current_account.device_info.os_name + (current_account.device_info.version ? " "+current_account.device_info.version : "")+"</span>");
	var popBrowserElement = $("#pop_up_browser").find(".asession_browser_popup")[0];
	$(popBrowserElement).removeAttr("class");
	$(popBrowserElement).addClass("asession_browser_popup");
	$("#pop_up_browser .asession_browser_popup").addClass("icon-"+current_account.browser_info.browser_image);
	$("#pop_up_browser .asession_browser_popup").html(fontIconBrowserToHtmlElement[current_account.browser_info.browser_image]);
	var browser_name = current_account.browser_info.bversion && current_account.browser_info.bversion != "-1" ?  current_account.browser_info.browser_name+" "+current_account.browser_info.bversion : current_account.browser_info.browser_name;
	$("#pop_up_browser").append("<span>"+browser_name+"</span>");
	popup_blurHandler('6');
	$("#popup_linked-accounts_contents").show(0,function(){
		$("#popup_linked-accounts_contents").addClass("pop_anim");
	});
	closePopup(close_linked_accounts_screen,"popup_linked-accounts_contents");//No I18N
	$("#popup_linked-accounts_contents .primary_btn_check").focus();
}

function close_linked_accounts_screen()
{
	popupBlurHide("#popup_linked-accounts_contents",function(){ //No I18N
		$("#linked_acc_popup_head").html(""); 
		$("#linked_acc_popup_info").html(""); 
	});
}



function closeview_all_linked_acc()
{
	popupBlurHide("#authorized_linked_more",function(){ //No I18N
		$("#view_accounts_remove").html("");		
	});
}



function removelinkedaccount(open_id)
{  
	if($("#authorized_linked_more").is(":visible")){
		disabledButton($("#authorized_linked_more .aw_info:visible"));	
	}
	else{
		disabledButton($("#linkedaccounts_space"));
	}
    new URI(LinkedAccountsObj,"self","self",open_id).DELETE().then(function(resp)	//No I18N
    		{
    			SuccessMsg(getErrorMessage(resp));
    			delete settings_data.LinkedAccounts.Account_details[open_id];
    		    close_linked_accounts_screen();
    			load_Linked_Accountsdetails(settings_data.Policies,settings_data.LinkedAccounts);
				var lenn=Object.keys(settings_data.LinkedAccounts.Account_details).length;
    			if(($("#authorized_linked_more").is(":visible")==true)&&(lenn>0)){
    				
    					$("#authorized_linked_more").hide();
    					$("#view_accounts_remove").html("");
    					show_all_linked_account();
    					removeButtonDisable($("#authorized_linked_more .aw_info"));
      			}
    			else{
    				$(".blur").css({"z-index":"6","opacity":".5"});
    				closeview_all_linked_acc();
    				removeButtonDisable($("#linkedaccounts_space"));
    			}
    		},
    		function(resp)
    		{
    			if($("#authorized_web_more").is(":visible"))
    			{
    				removeButtonDisable($("#authorized_linked_more .aw_info"));
    			}
    			else{
    				removeButtonDisable($("#linkedaccounts_space"));
    			}
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

function show_all_linked_account()
{
	$("#view_accounts_remove").html($("#all_linked_accounts").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_accounts_remove .authweb_entry_hidden").show();
	$("#view_accounts_remove .authweb_entry").addClass("viewall_authwebentry");
	$("#view_accounts_remove .Field_session").removeAttr("onclick");
//	$("#view_accounts_remove .aw_remove").hide();
	
	
	
	$("#authorized_linked_more").show(0,function(){
		$("#authorized_linked_more").addClass("pop_anim");
	});
	
	
	
	$("#view_accounts_remove .Field_session").click(function(){
	
		var id=$(this).attr('id');
		$("#view_accounts_remove .Field_session").addClass("autoheight");
		$("#view_accounts_remove .aw_info").slideUp(300);
		$("#view_accounts_remove .action_info").show();
		$(".aw_info a").unbind();
		if($("#view_accounts_remove #"+id).hasClass("web_email_specific_popup"))
		{
			$("#view_accounts_remove #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_accounts_remove #"+id).removeClass("web_email_specific_popup");
				$("#view_accounts_remove .Field_session").removeClass("autoheight");
			});
			
		}
		else
		{
			$("#view_accounts_remove .Field_session").removeClass("web_email_specific_popup");
			$("#view_accounts_remove #"+id).addClass("web_email_specific_popup");
			$("#view_accounts_remove #"+id+" .aw_info").slideDown(300,function(){
				$("#view_accounts_remove .Field_session").removeClass("autoheight");
			});
			control_Enter(".aw_info a");//No I18N
			$("#view_accounts_remove #"+id+" .action_info").hide();
		}
		
		
		
	});
	closePopup(closeview_all_linked_acc,"authorized_linked_more");//No I18N
	$("#authorized_linked_more").focus();
	
}



/***************************** Close Account  *********************************/


function load_closeddetails(Policies,Close_Accounts)
{
	if(de("deleteacc_exception"))
	{
		$("#deleteacc_exception").remove();
		$("#CloseAccount").removeClass("hide");
	}
	if(Close_Accounts.exception_occured!=undefined	&&	Close_Accounts.exception_occured)
	{
		$("#closeaccount_space .old_flow_desc,#closeaccount_space .new_flow_desc").remove();
		$("#deleteacc_box .box_info").css("min-height","auto");
		$("#deleteacc_box .box_info" ).after("<div id='deleteacc_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#deleteacc_exception #reload_exception").attr("onclick","reload_exception(CloseAccounts,'deleteacc_box')");
		$("#CloseAccount").addClass("hide");
		return;
	}
	
	$("#close_info_button .primary_btn_check").removeClass("red_btn");
	$("#flow_cnt_btns,#conti_close_flow").hide();
	$("#close_info_button").show();
	if(Close_Accounts.partner_name!=undefined)
	{
		$("#closeaccount_space .admin_user_desc").remove();
		$("#close_info_text .no_data_text").hide();
		$("#partner_info").show();
		
		var str=$("#partner_info").html();
		str=formatMessage(str,Close_Accounts.partner_name,supportEmail,supportEmail);
		$("#partner_info").html(str);
		
		$("#close_info_button .primary_btn_check").attr("target","");
		$("#close_info_button .primary_btn_check").attr("onclick","");
		$("#close_info_button .primary_btn_check span").hide();
		$("#support_mail").show();
		$("#close_info_button .primary_btn_check").attr("onclick","window.location.href = 'mailto:"+supportEmail+"'");
	}
	else if(Close_Accounts.has_orgcontact!=undefined)
	{
		if(Close_Accounts.business_url!=undefined)
		{
			$("#closeaccount_space .personal_user_desc").remove();
			$("#close_info_text .no_data_text").hide();
			if(isEmpty(settings_data.CloseAccounts.org_name))
			{
				$("#blank_org_owner_info").show();
				var str=$("#blank_org_owner_info").html();
				str=formatMessage(str,supportEmail,supportEmail);
				$("#blank_org_owner_info").html(str);
			}
			else
			{
				$("#org_owner_info").show();
				var str=$("#org_owner_info").html();
				str=formatMessage(str,Close_Accounts.org_name,supportEmail,supportEmail);
				$("#org_owner_info").html(str);
			}
			$("#close_info_button .primary_btn_check span").hide();
			$("#org_cancel").show();
			$("#close_info_button .primary_btn_check").attr("onclick","openInNewTab('"+Close_Accounts.business_url+"')");
		}
		else
		{
			$("#closeaccount_space .admin_user_desc").remove();
			$("#close_info_text .no_data_text").hide();		
			var org_owner_detail = Close_Accounts.owner_email ? Close_Accounts.owner_email : Close_Accounts.owner_name;
			if(isEmpty(settings_data.CloseAccounts.org_name))
			{
				$("#blank_org_contact_admin").show();
				var str=$("#blank_org_contact_admin").html();
				str=formatMessage(str,org_owner_detail,org_owner_detail);
				$("#blank_org_contact_admin").html(str);
				Close_Accounts.owner_name ? $("#blank_org_contact_admin a").removeAttr('href').css("font-weight","500") : "";
			}
			else
			{
				$("#contact_admin").show();
				var str=$("#contact_admin").html();
				str=formatMessage(str,Close_Accounts.org_name,org_owner_detail,org_owner_detail);
				$("#contact_admin").html(str);
				Close_Accounts.owner_name ? $("#contact_admin a").removeAttr('href').css("font-weight","500") : "";
			}
			
			$("#close_info_button .primary_btn_check").hide();
		}
	}
	else if(Close_Accounts.has_paid_services!=undefined && Close_Accounts.has_paid_services==true)
	{
		$("#closeaccount_space .admin_user_desc").remove();
		var services=Object.keys(Close_Accounts.paid_services);
		if(services.length>0)
		{	
			var count=0;
			
			$("#close_info_text .no_data_text").hide();
			$("#downgrade_service").show();
			
			$("#close_info_button .primary_btn_check span").hide();
			$("#unsubcribe").show();
			$("#close_info_button .primary_btn_check").attr("target","");
			$("#close_info_button .primary_btn_check").attr("onclick","show_downgradepopup();");
			
			for(iter=0;iter<services.length;iter++)
			{
				count++;
				var current_service=Close_Accounts.paid_services[services[iter]];
				
				service_format = $("#empty_app_format").html();
				$("#delete_acc_info").append(service_format);
				
				$("#delete_acc_info #service_info").attr("id","service_info"+count);
				$("#service_info"+count).attr("onclick","downgrade_sus('"+current_service.downgrade_service_url+"');");
				$("#service_info"+count+" .authtoken_div i[class^='product-icon'],#service_info"+count+" .authtoken_div i[class*=' product-icon']").addClass("product-icon-"+current_service.service_pic);
				$("#service_info"+count+" .authtoken_div .authtoken_name").html(current_service.service_display_name+" - "+current_service.service_title);
			}
		}
		else
		{
			$("#close_info_text .no_data_text").hide();
			$("#anti_spam").show();
			var str=$("#anti_spam").html();
			str=formatMessage(str,supportEmail);
			$("#anti_spam").html(str);
		}
	}
	else 
	{
		$("#closeaccount_space .admin_user_desc").remove();
		$("#close_info_button .primary_btn_check").attr("onclick","show_deletepopup();");
		$("#close_info_button .primary_btn_check").addClass("red_btn");
	}
	if(Close_Accounts.new_flow){
		$("#closeaccount_space .old_flow_desc").remove();
		$("#CloseAccount .no_data_text").hide();
		$("#close_info_button .primary_btn_check span").hide();
		$("#close_info_button .primary_btn_check").attr("onclick","openCloseOrgOption()").addClass("red_btn");
		if(isPersonalUser){
			$("#closeaccount_space .admin_user_desc").remove();
			$("#CloseAccount #personal_acc_delete").show();
			$("#close_info_button .primary_btn_check #personal_user_close").show();
		}
		else{
			$("#closeaccount_space .personal_user_desc").remove();
			$("#close_info_button .primary_btn_check,#close_info_button #org_cancel").show();
			$("#CloseAccount #new_org_owner_info").html(formatMessage($("#new_org_owner_info").html(),escapeHTML(settings_data.CloseAccounts.org_name))).show();
		}
		if(Close_Accounts.request_id){
			$("#close_info_text div,#close_info_button").hide();
			$("#flow_cnt_btns,#conti_close_flow").show();
			if(isPersonalUser){
				$("#CloseAccount #cancelClsProcess").attr("onclick","showCancelConfirm('"+i18nkeys['IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE']+"','"+i18nkeys['IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION.FOR.ACCOUNT']+"','"+Close_Accounts.request_id+"')");
				$("#conti_close_flow .for_org_user").hide();
				$("#conti_close_flow .for_personal_user").show();
			}
			else{				
				$("#CloseAccount #cancelClsProcess").attr("onclick","showCancelConfirm('"+i18nkeys['IAM.CLOSE.ACCOUNT.CANCEL.FLOW.TITLE']+"','"+i18nkeys['IAM.CLOSE.ACCOUNT.CANCEL.FLOW.CONFIRMATION']+"','"+Close_Accounts.request_id+"')");
				$("#conti_close_flow .for_org_user").show();
				$("#conti_close_flow .for_personal_user").hide();
			}
			$("#CloseAccount #continueClsProcess").attr("onclick","moveToNextOption('"+Close_Accounts.request_id+"','"+Close_Accounts.step+"')");
		}
	}
	else{
		$("#closeaccount_space .new_flow_desc").remove();
	}
}


function show_deletepopup()
{
	
	remove_error();
	
	document.closeform.reset();
	$("#popup_deleteaccount_close").show(0,function(){
		$("#popup_deleteaccount_close").addClass("pop_anim");
	});
	if(!isMobile)
	{
		$("#delete_acc_reason").select2({
			minimumResultsForSearch: Infinity
		});
	}
	popup_blurHandler('6');
	control_Enter(".blue"); //No i18N
	$("#delete_acc_reason~.select2 .select2-selection").focus();
	closePopup(close_deleteaccount,"popup_deleteaccount_close");//No I18N
	
}

function close_deleteaccount()
{
	popupBlurHide("#popup_deleteaccount_close");	//No I18N
	$(".blue").unbind();
}

function show_downgradepopup()
{
	$("#popup_deleteaccount_downgrade").show();
	popup_blurHandler('6');
}

function close_downgradepopup()
{
	$("#popup_deleteaccount_downgrade").hide();
	$(".blur").css({"z-index":"-1","opacity":"0"});
	$('html, body').css({
	    overflow: 'auto'//No i18N
	});
}

function downgrade_sus(url)
{
	window.open(url, '_blank');	
}

function closeaccount() 
{
	window.location.href="/";
}

function CLOSE_ACCOUNT()
{
	var f=document.closeform;
	if(validateForm(f))
	{
		disabledButton(f);
		var parms=
		{
				"reason":$('#'+f.id).find('select[name="reason"]').val(),//No I18N
				"comments":$('#'+f.id).find('textarea[name="comments"]').val()//No I18N
		};
		
		var payload = CloseAccountsObj.create(parms);
		payload.PUT("self","self","self").then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));
			close_deleteaccount();
			removeButtonDisable(f);
			setTimeout(function() {
				window.location.href=contextpath;
			}, 5000);	
			
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
	return false;
}

function IDP_container_slidedown() {
	$(".addnew_account_heading").removeClass("addnew half").addClass("enlarge_heading");
	$("#idps_list").slideDown(300);
	$(".add_new_account_container").addClass("bgchange");
	$(".closeicon").fadeIn(200);
	$("#no_linkedaccount").slideUp(300);
	if($("#link_new_account").hasClass("linked_accounts_view_more"))
	{
		$("#link_new_account_view_more_box").hide();
		$("#link_new_account").show();
	}
}

function IDP_container_slideup(show_empty_state) {
	$(".addnew_account_heading").addClass("addnew half").removeClass("enlarge_heading");
	$("#idps_list").slideUp(200);
	$(".add_new_account_container").removeClass("bgchange");
	$(".closeicon").fadeOut(200);
	if(show_empty_state) {
		$("#no_linkedaccount").slideDown(200);
	}
	if($("#link_new_account").hasClass("linked_accounts_view_more"))
	{
		$("#link_new_account").hide();
		$("#link_new_account_view_more_box").show();	
	}
}
function openCloseOrgOption(){
	$("body").css("overflow","hidden");
	window.onresize="";
	$("#preference_space,#authorizedsites_space,#linkedaccounts_space,#preference_box,#settingsubmenu,#closeaccount_space,.start_process").hide();
	$(".org_close_aligner,.start_process").show();
	settings_data.CloseAccounts.password_exists != undefined ? $(".start_process .cls_acc_checkbox_div").hide() : $(".start_process .cls_acc_checkbox_div").show(); 
}
function DateSelectformat(option){
	var splittext = option.text.split("(");
	if(splittext[1]){
		var obj = '<div>'+ splittext[0] +'<span style="color:#999999; font-size:13px; margin-left:6px">('+ splittext[1] +'</span></div>';
	}else {
		obj = option.text;
	}
	return obj;
}
