//$Id$
var challengeJSON={};
var credential_data = "";

function makeCredential(options,isPassKey, isPFA) {
  var makeCredentialOptions = {};
    makeCredentialOptions.rp = options.rp;
    makeCredentialOptions.user = options.user;
    makeCredentialOptions.user.id = strToBin(options.user.id);
    makeCredentialOptions.challenge = strToBin(options.challenge);
    makeCredentialOptions.pubKeyCredParams = options.pubKeyCredParams;
    makeCredentialOptions.timeout  = options.timeout;
    makeCredentialOptions.extensions = {};
    if ('extensions' in options) {
		if ('appidExclude' in options.extensions) {
			makeCredentialOptions.extensions.appidExclude = options.extensions.appidExclude;
		}
	}
    if ('excludeCredentials' in options) {
      makeCredentialOptions.excludeCredentials = credentialListConversion(options.excludeCredentials);
    }
    if ('authenticatorSelection' in options) {
      makeCredentialOptions.authenticatorSelection = options.authenticatorSelection;
    }
    if ('attestation' in options) {
      makeCredentialOptions.attestation = options.attestation;
    }
    navigator.credentials.create({
      "publicKey": makeCredentialOptions //No I18N
    }).then(function(attestation){
        var publicKeyCredential = {};
        if ('id' in attestation) {
          publicKeyCredential.id = attestation.id;
        }
        if ('type' in attestation) {
          publicKeyCredential.type = attestation.type;
        }
        if ('rawId' in attestation) {
          publicKeyCredential.rawId = binToStr(attestation.rawId);
        }
        if (!attestation.response) {
			isPassKey ? showErrorMessage(webauthn_PasskeyInvalidResponse) : showErrorMessage(webauthn_InvalidResponse);
        }
        var response = {};
        response.clientDataJSON = binToStr(attestation.response.clientDataJSON);
        response.attestationObject = binToStr(attestation.response.attestationObject);

        if (attestation.response.getTransports) {
          response.transports = attestation.response.getTransports();
        }

        publicKeyCredential.response = response;
        var attestationJson = {};
    	if(isPassKey){
    		attestationJson.mfapasskey = publicKeyCredential;
            credential_data = JSON.stringify(attestationJson);     
    		registerPasskey(credential_data,$("#common_popup #passkey_name").val().trim(), isPFA);
    	}
    	else{    	
    		attestationJson.mfayubikey = publicKeyCredential;
            credential_data = JSON.stringify(attestationJson);     
    		get_YUBIKEY_name();
    	}
      }).catch(function(err){
    	  close_yubikey_popup();
    	  if(err.name == 'NotAllowedError') {
    		  showErrorMessage(webauthn_NotAllowedError);
    	  } else if(err.name == 'InvalidStateError') {
    		  isPassKey ? showErrorMessage(webauthn_PasskeyInvalidStateError) : showErrorMessage(webauthn_InvalidStateError);;
    	  } else if(err.name == 'NotSupportedError') {
	    	  showErrorMessage(webauthn_NotSupportedError);
		  } else if(err.name == 'AbortError') {
			  showErrorMessage(webauthn_AbortError);
    	  }
		  else if(err.name == 'TypeError'){
			  showErrorMessage(formatMessage(i18nMFAkeys["IAM.PASSKEY.WEBAUTHN.TYPEERROR"]+" "+i18nMFAkeys["IAM.PASSKEY.SUPPORT"],passkeyURL));//no i18n
		  }
		  else {
    		  isPassKey ? showErrorMessage(formatMessage(webauthn_Passkeyregistration_error,accounts_support_contact_email_id) + '<br>' +err.toString()) : showErrorMessage(formatMessage(webauthn_registration_error,accounts_support_contact_email_id) + '<br>' +err.toString());
    	  }
      });
}

function registerYubikey(data,name){	
	data = JSON.parse(data);
	data = data.mfayubikey;
	var parms=
	{
			"key_name" : name,	//No I18N
			"id":data.id,		//No I18N
			"rawId":data.rawId,		//No I18N
			"response":data.response,		//No I18N
			"type":data.type		//No I18N
	};
	var payload = Yubikey_obj.create(parms);
	payload.PUT("self","self","mode","self").then(function(resp)	//No I18N
	{
		removeButtonDisable($("#common_popup #third_step"));
		if(resp.status_code == 200){
			SuccessMsg(getErrorMessage(resp));
			existingName.push(name);
			var display_bkup_popup=false;
			if(tfa_data.modes.indexOf("yubikey")==-1)
			{
				tfa_data.modes[tfa_data.modes.length]="yubikey";
				tfa_data.yubikey=[];
				tfa_data.yubikey.yubikey=[];
				display_bkup_popup=true;
			}
			tfa_data.yubikey.yubikey[tfa_data.yubikey.yubikey.length]=resp.mfayubikey.yubikey;
			tfa_data.yubikey.count=tfa_data.yubikey.yubikey.length;
			if(!tfa_data.is_mfa_activated)
			{
			tfa_data.is_mfa_activated=true;
			delete tfa_data.bc_cr_time.created_time
			if(tfa_data.primary=="-1")
			{
				tfa_data.primary=8;
			}
			show_mfa_device_clear(resp.mfayubikey.sess_term_tokens);
		}
		else
		{
			close_popupscreen(function(){load_mfa(display_bkup_popup)});
		}
		challengeJSON={};
		}
	},
	function(resp)
	{
		removeButtonDisable($("#common_popup #third_step"));
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

function clear_loading()
{
	$(".tfa_blur").hide();//tfa
	$(".loader").hide();//tfa

}

var mfa_deatils;//No i18N


function show_CHprimary_notice()
{
	popup_blurHandler('6');
	$("#CHprimary_NOTICE").show(0,function(){
		$("#CHprimary_NOTICE").addClass("pop_anim");
	});
	closePopup(close_tfa_CHprimary_notice,"CHprimary_NOTICE",true);//No I18N
	$('#mfa_primary_select').empty();
	var one_auth_check=false;
	
	for(i=0;i<tfa_data.modes.length;i++)
	{
		//TOUCH ID = 2; QR = 3; PUSH = 4; TOTP = 5; FACEID = 7;  BIOMETRIC = 11; MYZOHO_APP=12
		
		if(one_auth_check==false	&&	tfa_data.modes[i]=="devices")
		{
			one_auth_check=true;
			$('#mfa_primary_select').append($('<option>', { value : mfa_deatils.indexOf(tfa_data.modes[i]) }).text(mfa_mode_oneAuth));
		}
		else if(tfa_data.modes[i]=="otp")
		{
			$('#mfa_primary_select').append($('<option>', { value : mfa_deatils.indexOf(tfa_data.modes[i]) }).text(mfa_mode_details_otp));
		}
		else if(tfa_data.modes[i]=="totp")
		{
			$('#mfa_primary_select').append($('<option>', { value : mfa_deatils.indexOf(tfa_data.modes[i]) }).text(mfa_mode_details_totp));
		}
		else if(tfa_data.modes[i]=="exostar")
		{
			$('#mfa_primary_select').append($('<option>', { value : mfa_deatils.indexOf(tfa_data.modes[i]) }).text(mfa_mode_details_exo));
		}
		else if(tfa_data.modes[i]=="yubikey")
		{
			$('#mfa_primary_select').append($('<option>', { value : mfa_deatils.indexOf(tfa_data.modes[i]) }).text(mfa_mode_details_yubikey));
		}
	}
	
	$("#mfa_primary_select").uvselect({
		"searchable" : true //No I18N
	});
}

function change_new_primary()
{
	var mode=$('#mfa_primary_select').val();
	change_mode(mode);
	close_tfa_CHprimary_notice();
}
isPFAInited = isPFAPasskey = isPFADevice = false;
function load_PFA(pfaObject){
	for(key of Object.keys(tfa_data.pfa_data)) {
		switch(key){
			case "allowed_modes": //No I18N
			if(pfaObject[key].indexOf("EMAIL_OTP") > -1 || pfaObject[key].indexOf("MOBILE_OTP") > -1 || pfaObject[key].indexOf("FEDERATED_SIGNIN") > -1 || pfaObject[key].indexOf("PASSWORD") > -1){
				if(pfaObject[key].indexOf("EMAIL_OTP") > -1){
					$("#email_auth_mode").removeClass("hide")
					if(!isPFAInited){
						$("#email_auth_mode").on("click", function(){
							window.location.href = contextpath + '/home#profile/useremails';
						})
					}
				}
				if(pfaObject[key].indexOf("MOBILE_OTP") > -1){
					$("#mobile_auth_mode").removeClass("hide")
					if(!isPFAInited){
						$("#mobile_auth_mode").on("click", function(){
							window.location.href = contextpath + '/home#profile/phonenumbers';
						})
					}
				}
				if(pfaObject[key].indexOf("FEDERATED_SIGNIN") > -1){
					$("#fed_auth_mode").removeClass("hide")
					if(!isPFAInited){
						$("#fed_auth_mode").on("click", function(){
							window.location.href = contextpath + 'home#setting/linkedaccounts';
						})
					}
				}
				if(pfaObject[key].indexOf("PASSWORD") > -1){
					$("#password_auth_mode").removeClass("hide")
					if(!isPFAInited){
						$("#password_auth_mode").on("click", function(){
							window.location.href = contextpath + 'home#security/security_pwd';
						})
					}
				}
			}else{
				$("#mfa_other_auth_mode").remove();
			}
			if(pfaObject[key].indexOf("TOTP") > -1){
				$("#pfa_app_auth_mode").removeClass("hide");
			}
			if(pfaObject[key].indexOf("PASSKEY") > -1){
				isPFAPasskey = true;
				$("#mfa_passkey_auth_mode").removeClass("hide");
				$(".tfa_settings_sapce #mfa_passkey_auth_mode").remove();
			}
			if(pfaObject[key].indexOf("DEVICE") > -1){
				isPFADevice = true;
				$("#mfa_oneauth_mode").removeClass("hide");
				$(".tfa_settings_sapce #mfa_oneauth_mode").remove();
			}
				break;
			case "totp": //No I18N
				load_totp(pfaObject[key]);
				$("#pfa_app_auth_mode").removeClass("hide");
				break;
			case "passkey": //No I18N
				isPFAPasskey = true;
				$(".tfa_settings_sapce #mfa_passkey_auth_mode").remove();
				$("#mfa_passkey_auth_mode").removeClass("hide");
				break;
			case "oadevice": //No I18N
				isPFADevice = true;
				$(".tfa_settings_sapce #mfa_oneauth_mode").remove();
				$("#mfa_oneauth_mode").removeClass("hide");
				break;
		}
	}
	if(Object.keys(pfaObject).length >= 2){
		$(".pfa_other_head").text(i18nPFAKeys["IAM.OTHER.AVAIL.MODES"]); //NO i18n
	}
}
function load_mfa(display_bkup_popup)
{
	$("input[type=password]").val("");
	$("input[type=phonenumber]").val("");
	$(".option_information").show();
	$(".option_preference").hide();
	if(tfa_data.pfa_data && Object.keys(tfa_data.pfa_data).length > 0){
		load_PFA(tfa_data.pfa_data);
	}
	clear_loading();
	mfa_deatils=[];
	tooltip_Des(".action_icon");//No I18N
		
	$(".option_grid").removeClass("primary_mode");
	$(".child_flex").removeClass("column_order");
	$(".mfa_mode_status_butt .primary_indicator,#modes_space .mfa_disabled_lable").hide();
	$(".mfa_mode_status_butt .secondary_indicator,#add_tfa_phone,#add_YubiKey,#change_configure_Gauthmode,.mfa_setupnow").show();
	$(".mfa_mode_status_butt .disbaled_indicator").hide();
	$(".option_grid").removeClass("disabled_option_grid")
	$(".option_grid").css("order","6");
	var mfa_title;
	if(tfa_data.modes.indexOf("devices")>-1 || (tfa_data.pfa_data && tfa_data.pfa_data.oadevice))
	{
		var devices_list;
		if(isPFADevice && tfa_data.pfa_data.oadevice){
			$("#mfa_oneauth_mode").removeClass("primary_mode");
			$("#oneauth_mode_preference  .mfa_mode_status_butt").remove();
			devices_list = tfa_data.pfa_data.oadevice;
			devices_list.count = tfa_data.pfa_data.oadevice.length;
		}else if(!isPFADevice){
			$('#pfamodes_space #mfa_oneauth_mode').remove();
			devices_list = tfa_data.devices.device;
		}
		$("#oneauth_mode_info").hide();
		$("#oneauth_mode_preference").show();
//			mode details		 TOUCH ID = 2; QR = 3; PUSH = 4; TOTP = 5; FACEID = 7; oneauth =11 ; nio metirc =12
		if(tfa_data.primary==7	||tfa_data.primary==2	||tfa_data.primary==3	||tfa_data.primary==4	||tfa_data.primary==5	||tfa_data.primary==11	||tfa_data.primary==12)
		{
			$("#mfa_oneauth_mode").addClass("primary_mode");
			$("#"+$("#mfa_oneauth_mode").parent().attr("id")).addClass("column_order");
			$("#oneauth_mode_preference .mfa_mode_status_butt .primary_indicator").show();
			$("#oneauth_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
			$("#oneauth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").hide();
			$("#mfa_oneauth_mode").css("order",-1);
		}
		else
		{
			$("#mfa_oneauth_mode").css("order",tfa_data.modes.indexOf("devices")+1);
		}
		var primay_mode=undefined;
		$(".MFAdevice_BKUP").html("");
	    $(".MFAdevice_primary").html("");
	    var sec_count=0;
	    $("#view_only_devices").hide();
	    for(j=0;j<devices_list.length;j++)
		{
	    	$("#mfa_phoneDetails").find(".set_as_tag").text(tfa_mkeprim);
	    	$("#mfa_phoneDetails").find(".pri_indicator").text(mfa_prim_indicator);
	    	var mfa_device_format = $("#empty_MFAphone_format").html();
			if(devices_list[j].is_primary)
			{
				$("#all_tfa_devices .MFAdevice_primary").html(mfa_device_format);
				$("#all_tfa_devices .MFAdevice_primary #mfa_phoneDetails").attr("id","MFAdevice_primary");
				if(!isMobile){
					$("#MFAdevice_primary").attr("onclick","Mfa_mobile_ui_specific('MFAdevice_primary','"+devices_list[j].device_id+"')");
				}
				if(devices_list[j].device_name!=devices_list[j].device_info)
				{
					$("#MFAdevice_primary .emailaddress_text").html(devices_list[j].device_info+" - "+devices_list[j].device_name);
				}
				else
				{
					$("#MFAdevice_primary .emailaddress_text").html(devices_list[j].device_name);
				}
				$("#MFAdevice_primary #mfa_ph_time").html(devices_list[j].created_time_elapsed);
				$("#MFAdevice_primary .primary_dot").html(devices_list[j].preference_name);
				$("#MFAdevice_primary .mobile_dp").attr("class","one_auth_list_icon");
				if(devices_list[j].app_version != "1.0"){
					$("#MFAdevice_primary .one_auth_list_icon").addClass("one_auth_icon_v2");					
				}
				$("#MFAdevice_primary .sec_indicator").remove();
				$("#MFAdevice_primary .phnum_hover_show #icon-delete").attr("id","device-delete_primary");
				mfa_title = i18nMFAkeys["IAM.CONFIRM.POPUP.DELETE.ONEAUTH"];
				$("#MFAdevice_primary .phnum_hover_show #device-delete_primary").attr("onclick","remove_mfa_device('"+mfa_title+"','"+devices_list[j].device_id+"','MFAdevice_primary');"); 
				$("#MFAdevice_primary .phnum_hover_show #icon-primary").remove(); 
				$("#oneauth_mode_preference .mfa_option_desc span").hide();
				if(tfa_data.is_passwordless){
					$("#oneauth_mode_preference .mfa_option_desc .passwordless").show();
				}
				if(devices_list[j].prefer_option == "totp"){
					$("#oneauth_mode_preference .mfa_option_desc .mfa_totp").show();
				}
				if(devices_list[j].prefer_option == "push"){
					$("#oneauth_mode_preference .mfa_option_desc .mfa_push").show();
				}
				if(devices_list[j].prefer_option == "scanqr"){
					$("#oneauth_mode_preference .mfa_option_desc .mfa_qr").show();
				}
				sec_count++;
				primay_mode=devices_list[j].pref_option;
			}
			else
			{
				sec_count++;
				$("#all_tfa_devices .MFAdevice_BKUP").append(mfa_device_format);
				$("#all_tfa_devices .MFAdevice_BKUP #mfa_phoneDetails").attr("id","mfa_deviceDetails"+sec_count);
				if(!isMobile){
					$("#mfa_deviceDetails"+sec_count).attr("onclick","Mfa_mobile_ui_specific('mfa_deviceDetails"+sec_count+"','"+devices_list[j].device_id+"')");
				}
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .mobile_dp").addClass(color_classes[gen_random_value()]);
				
				if(devices_list[j].device_name!=devices_list[j].device_info)
				{
					$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .emailaddress_text").html(devices_list[j].device_info+" - "+devices_list[j].device_name);
				}
				else
				{
					$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .emailaddress_text").html(devices_list[j].device_name);
				}
				
				
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" #mfa_ph_time").html(devices_list[j].created_time_elapsed);
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .primary_dot").html(devices_list[j].preference_name);
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .pri_indicator").remove();
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .mobile_dp").attr("class","one_auth_list_icon");
				if(devices_list[j].app_version != "1.0"){
					$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .one_auth_list_icon").addClass("one_auth_icon_v2");
				}
				if(sec_count > 1)
	          	{
	          		$("#mfa_deviceDetails"+sec_count).addClass("extra_phonenumbers"); 
	          	}
				
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .phnum_hover_show #icon-delete").attr("id","device-delete"+sec_count); 
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .phnum_hover_show #icon-primary").attr("id","device-primary"+sec_count); 
				mfa_title = i18nMFAkeys["IAM.CONFIRM.POPUP.DELETE.ONEAUTH"];
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .phnum_hover_show #device-delete"+sec_count).attr("onclick","remove_mfa_device('"+mfa_title+"','"+devices_list[j].device_id+"','mfa_deviceDetails"+sec_count+"');"); 
				mfa_title = $(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .phnum_hover_show #device-primary"+sec_count).attr("onclick");
				$(".MFAdevice_BKUP #mfa_deviceDetails"+sec_count+" .phnum_hover_show #device-primary"+sec_count).attr("onclick","make_device_primary('"+mfa_title+"','"+devices_list[j].device_id+"','mfa_deviceDetails"+sec_count+"');"); 

			}
		}
	    if(primay_mode==undefined && tfa_data.devices && tfa_data.devices.device[0])
	    {
			$("#oneauth_mode_preference #one_auth_primary_toggle").attr("onclick","MFA_changeMODE_confirm('"+tfa_change_mode_title+"','"+mfa_mode_oneAuth+"',"+tfa_data.devices.device[0].pref_option+");");
			mfa_deatils[tfa_data.devices.device[0].pref_option]="devices";
	    }
	    else
	    {
	    	$("#oneauth_mode_preference #one_auth_primary_toggle").attr("onclick","MFA_changeMODE_confirm('"+tfa_change_mode_title+"','"+mfa_mode_oneAuth+"','"+primay_mode+"');");
	    	mfa_deatils[primay_mode]="devices";
	    }
	    if(sec_count==1)
	    {
	    	$("#mfa_oneauth_mode .pri_sec_indicator").hide();
	    }
	    else
	    {
	    	$("#MFAdevice_primary .phnum_hover_show #device-delete_primary").remove();
	    }
	    if(sec_count>1)
	    {
	    	$("#view_only_devices").show();
	    	if(sec_count <= 2){
	    		$("#view_only_devices .moreThenTwo").hide();
	    		$("#view_only_devices .lessThenTwo").show();
	    		$("#view_only_devices .lessThenTwo").text(formatMessage($("#view_only_devices .lessThenTwo").text(),sec_count-1));
	    	}
	    	else{
	    		$("#view_only_devices .moreThenTwo").show();
	    		$("#view_only_devices .lessThenTwo").hide();
	    		$("#view_only_devices .moreThenTwo").text(formatMessage($("#view_only_devices .moreThenTwo").text(),sec_count-1));
	    	}
	    	$("#view_only_devices span").css("margin","0px");
	    	if(primay_mode!=undefined)//no primary all are secondary devices
	    	{
	    		$(".MFAdevice_BKUP .secondary").addClass("extra_phonenumbers");
	    	}
	    }
	    if(!canSetup_mfa_device)
		{
			$("#oneauth_mode_preference .mfa_mode_status_butt div").hide();
			$("#mfa_passphrase_grid").hide();
			if(!tfa_data.is_update_allowed){
				$("#mfa_oneauth_mode").addClass("disabled_option_grid");
				$("#oneauth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
			}
		}
		
	    if(isMobile)
		{
	    	$("#all_tfa_devices .phnum_hover_show").addClass("hide");
		}
	}
	else if(!canSetup_mfa_device) 
	{
		if(!isPFADevice){
			$(".tfa_settings_sapce #mfa_oneauth_mode").remove();
			$("#mfa_passphrase_grid").hide();
		}
	}
	
	
	if(tfa_data.modes.indexOf("otp")>-1)
	{
		mfa_deatils[0]="otp";
		$("#sms_mode_info").hide();
		$("#sms_mode_preference").show();
		var primay_mob_present=false;
		if(tfa_data.primary==0)
		{
			$("#mfa_sms_mode").addClass("primary_mode");
			$("#"+$("#mfa_sms_mode").parent().attr("id")).addClass("column_order");
			$("#sms_mode_preference .mfa_mode_status_butt .primary_indicator").show();
			$("#sms_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
			$("#sms_mode_preference .mfa_mode_status_butt .disbaled_indicator").hide();
			$("#mfa_sms_mode").css("order",-1);
		}
		else
		{
			$("#mfa_sms_mode").css("order",tfa_data.modes.indexOf("otp")+1);
		}
		
		var mobile_list=tfa_data.otp.mobile;
		
		$(".MFAnumber_BKUP").html("");
	    $(".MFAnumber_primary").html("");
	    var sec_count=0;
	    for(j=0;j<mobile_list.length;j++)
		{
	    	$("#mfa_phoneDetails").find(".set_as_tag").text(tfa_preferred_num_text);
	    	$("#mfa_phoneDetails").find(".pri_indicator").text(mfa_pref_indicator);
	    	var mfa_phone_format = $("#empty_MFAphone_format").html();
			if(mobile_list[j].is_primary)
			{
				$("#mfa_phonenumbers .MFAnumber_primary").html(mfa_phone_format);
				$("#mfa_phonenumbers .MFAnumber_primary #mfa_phoneDetails").attr("id","mfa_num_primary");
				if(!isMobile){
					$("#mfa_num_primary").attr("onclick","Mfa_mobile_ui_specific('mfa_num_primary','"+mobile_list[j].e_mobile+"')");
				}
				
				$("#mfa_num_primary .emailaddress_text").html(phonePattern.setMobileNumFormat(mobile_list[j].r_mobile));
				$("#mfa_num_primary #mfa_ph_time").html(mobile_list[j].created_time_elapsed);
				$("#mfa_num_primary .primary_dot").remove();
				$("#mfa_num_primary #mfa_primary_title").css("display","none");
				$("#mfa_num_primary .sec_indicator").remove();
				$("#mfa_num_primary .phnum_hover_show #icon-delete").attr("id","mob-delete_primary");
				mfa_title = $("#mfa_num_primary .phnum_hover_show #mob-delete_primary").attr("onclick");
				if(mobile_list[j].hasOwnProperty('is_login_mobile')) {
					$("#mfa_num_primary .phnum_hover_show #mob-delete_primary").attr("onclick","remove_mfa_preferred('"+((mobile_list.length>1)?i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB"]:i18nMFAkeys["IAM.CONFIRM.POPUP.DELETE.MFA.NUMBER"])+"','"+i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB.DESC"]+"','"+mobile_list[j].e_mobile+"','mfa_num_primary');"); //No I18N
				} else {
					$("#mfa_num_primary .phnum_hover_show #mob-delete_primary").attr("onclick","remove_mfa_preferred('"+((mobile_list.length>1)?i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB"]:i18nMFAkeys["IAM.CONFIRM.POPUP.DELETE.MFA.NUMBER"])+"','"+i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB.DESC"]+"','"+mobile_list[j].e_mobile+"','mfa_num_primary');"); //No I18N
				}
				$("#mfa_num_primary .phnum_hover_show #icon-primary").remove(); 
				sec_count++;
				primay_mob_present=true;
			}
			else
			{
				sec_count++;
				$("#mfa_phonenumbers .MFAnumber_BKUP").append(mfa_phone_format);
				$("#mfa_phonenumbers .MFAnumber_BKUP #mfa_phoneDetails").attr("id","mfa_phoneDetails"+sec_count);
				if(!isMobile){
					$("#mfa_phoneDetails"+sec_count).attr("onclick","Mfa_mobile_ui_specific('mfa_phoneDetails"+sec_count+"','"+mobile_list[j].e_mobile+"')");
				}
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .mobile_dp").addClass(color_classes[gen_random_value()]);
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .emailaddress_text").html(phonePattern.setMobileNumFormat(mobile_list[j].r_mobile));
				$("#mfa_phoneDetails"+sec_count).data("encMob" , mobile_list[j].e_mobile);
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" #mfa_ph_time").html(mobile_list[j].created_time_elapsed);
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .primary_dot").remove();
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .pri_indicator").remove();
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" #mfa_primary_title").remove();
				if(sec_count > 1)
	          	{
	          		$("#mfa_phoneDetails"+sec_count).addClass("extra_phonenumbers"); 
	          	}
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #icon-delete").attr("id","mob-delete"+sec_count); 
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #icon-primary").attr("id","mob-primary"+sec_count);
				
				mfa_title = $(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #mob-delete"+sec_count).attr("onclick");
				if(mobile_list[j].hasOwnProperty('is_login_mobile')) {
					$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #mob-delete"+sec_count).attr("onclick","remove_mfa_backup('"+tfa_delete_num_text+"','"+tfa_delete_login_number+"','"+mobile_list[j].e_mobile+"','mfa_phoneDetails"+sec_count+"');"); //No I18N
				} else {
					$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #mob-delete"+sec_count).attr("onclick","remove_mfa_backup('"+tfa_delete_num_text+"','"+mfa_delete_mode+"','"+mobile_list[j].e_mobile+"','mfa_phoneDetails"+sec_count+"');"); //No I18N
				}
				mfa_title = $(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #mob-primary"+sec_count).attr("onclick");
				$(".MFAnumber_BKUP #mfa_phoneDetails"+sec_count+" .phnum_hover_show #mob-primary"+sec_count).attr("onclick","make_primary_backup('"+tfa_preferred_num+"','"+mobile_list[j].e_mobile+"','mfa_phoneDetails"+sec_count+"');"); 

			}
		}
	    $("#add_more_backup_num").hide();
    	$("#tfa_phone_add_view_more").hide();
    	$("#show_backup_num_diabledMFA").hide();
    	
		if(tfa_data.hasOwnProperty("otp") && tfa_data.otp.hasOwnProperty("recovery_mobile")) {
			list_recovery_numbers("verfied_phnnum", "verified_num_cta", "select_verified_number");//No I18N
		} else {
			$("#verified_num_cta").hide();
		}
    	
	    if(sec_count==1)
	    {
	    	$("#mfa_sms_mode .pri_sec_indicator").hide();
	    }
	    if(sec_count>1)
	    {
	    	$("#tfa_phone_add_view_more").show();
	    	if(sec_count>2)
			{
				$("#tfa_phone_add_view_more .view_more").html(formatMessage(i18nMFAkeys["IAM.VIEWMORE.NUMBERS"],sec_count-1)); //NO I18N
			}
			else
			{
				$("#tfa_phone_add_view_more .view_more").html(formatMessage(i18nMFAkeys["IAM.VIEWMORE.NUMBER"],sec_count-1)); //NO I18N
			}
	    	if(primay_mob_present)
	    	{
	    		$(".MFAnumber_BKUP .secondary").addClass("extra_phonenumbers");
	    	}
	    }
	    else
	    {
	    	$("#add_more_backup_num").show();
	    }
	    if(!canSetupSMS)
		{
			$("#sms_mode_preference .mfa_mode_status_butt div").hide();
			$("#add_more_backup_num").hide();
	    	$("#tfa_phone_add_view_more").hide();
	    	if(sec_count>1)
	    	{
	    		$("#show_backup_num_diabledMFA").show();
	    	}
			if(!tfa_data.is_update_allowed){
				$("#sms_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
				$("#mfa_sms_mode").addClass("disabled_option_grid");
			}
		}
	    if(isMobile)
		{
	    	$("#all_tfa_numbers .phnum_hover_show").addClass("hide");
		}
	}
	else if(!canSetupSMS) 
	{
		$("#mfa_sms_mode").remove();
	}
	
	if(tfa_data.modes.indexOf("totp")>-1)
	{
		mfa_deatils[1]="totp";
		$("#sms_app_auth_info").hide();
		$("#app_auth_mode_preference").show();
		if(tfa_data.primary==1)
		{
			$("#mfa_app_auth_mode").addClass("primary_mode");
			$("#"+$("#mfa_app_auth_mode").parent().attr("id")).addClass("column_order");
			$("#app_auth_mode_preference .mfa_mode_status_butt .primary_indicator").show();
			$("#app_auth_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
			$("#app_auth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").hide();
			$("#mfa_app_auth_mode").css("order",-1);
		}
		else
		{
			$("#mfa_app_auth_mode").css("order",tfa_data.modes.indexOf("totp")+1);
		}
		$("#mfa_app_auth_mode #configure_authmode").show();
		$("#mfa_app_auth_mode #change_configure_Gauthmode").show();
		if(!canSetupGAuth)
		{
			$("#app_auth_mode_preference .mfa_mode_status_butt div").hide();
			$("#mfa_app_auth_mode #configure_authmode").hide();
			$(".tfa_settings_sapce #mfa_app_auth_mode #change_configure_Gauthmode").hide();
			if(!tfa_data.is_update_allowed){
				$("#mfa_app_auth_mode").addClass("disabled_option_grid");
				$("#app_auth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
			}
		}

		$("#mfa_app_auth_mode #mfa_auth_detils .emailaddress_addredtime").html(tfa_data.totp.created_time_elapsed);
	}
	else if(!canSetupGAuth) 
	{
		$("#mfa_app_auth_mode").remove();
	}
	
	if(tfa_data.modes.indexOf("yubikey")>-1)
	{
		mfa_deatils[8]="yubikey";
		$("#yubikey_mode_info").hide();
		$("#yubikey_mode_preference").show();
		if(tfa_data.primary==8)
		{
			$("#mfa_yubikey_mode").addClass("primary_mode");
			$("#"+$("#mfa_yubikey_mode").parent().attr("id")).addClass("column_order");
			$("#yubikey_mode_preference .mfa_mode_status_butt .primary_indicator").show();
			$("#yubikey_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
			$("#yubikey_mode_preference  .mfa_mode_status_butt .disbaled_indicator").hide();
			$("#mfa_yubikey_mode").css("order",-1);
		}
		else
		{
			$("#mfa_yubikey_mode").css("order",tfa_data.modes.indexOf("yubikey")+1);
		}
		$("#configure_yubikey_mode").show();
		$("#goto_yubikey_mode").show();
		if(!canSetupyubikey)
		{
			$("#yubikey_mode_preference .mfa_mode_status_butt div").hide();
			$("#configure_yubikey_mode").hide();
			$("#goto_yubikey_mode").hide();
			if(!tfa_data.is_update_allowed){
				$("#yubikey_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
				$("#mfa_yubikey_mode").addClass("disabled_option_grid");
			}
		}
		$("#mfa_yubikey_detils .emailaddress_text").html(tfa_data.yubikey.key_name);//No I18N
		$("#mfa_yubikey_detils .emailaddress_addredtime").html(tfa_data.yubikey.created_time_elapsed);
		$("#mfa_yubikey_hover #icon-delete").attr("onclick","showDeleteYubikeyQuestion('"+tfa_data.yubikey.key_name+"');");
		var sec_count=0;
		var Yubikey_list = tfa_data.yubikey.yubikey;
		$("#mfa_phoneDetails").find(".set_as_tag").text(tfa_mkeprim);
		$("#mfa_phoneDetails").find(".pri_indicator").text(mfa_prim_indicator);
		var mfa_yubiKey_format = $("#empty_MFAphone_format").html();
		$(".MFA_yubiKey_BKUP").html("");
	    $(".MFA_yubiKey_primary").html("");
		for(j=0;j<Yubikey_list.length;j++)
		{
			if(Yubikey_list[j].is_primary)
			{
				$(".MFA_yubiKey_primary").html(mfa_yubiKey_format);
				$(".MFA_yubiKey_primary #mfa_phoneDetails").attr("id","mfa_yubiKey_primary");
				
				$("#mfa_yubiKey_primary .emailaddress_text").html(Yubikey_list[j].key_name);
				$("#mfa_yubiKey_primary #mfa_ph_time").text(Yubikey_list[j].created_time_elapsed);
				$("#mfa_yubiKey_primary .primary_dot").remove();
				$("#mfa_yubiKey_primary #mfa_primary_title").css("display","none");
				$("#mfa_yubiKey_primary .pri_sec_indicator").remove();
				$("#mfa_yubiKey_primary .mobile_dp").attr("class","mobile_dp icon-Yubikey");
				$("#mfa_yubiKey_primary .phnum_hover_show #icon-delete").attr("id","mob-delete_primary");
				mfa_title = $("#mfa_yubiKey_primary .phnum_hover_show #mob-delete_primary").attr("onclick");
				$("#mfa_yubiKey_primary .phnum_hover_show #mob-delete_primary").attr("onclick","showDeleteYubikeyQuestion('"+mfa_title+"','"+Yubikey_list[j].key_name+"','"+Yubikey_list[j].e_keyName+"');"); //No I18N
				$("#mfa_yubiKey_primary .phnum_hover_show #icon-primary").remove(); 
				sec_count++;
				//primay_mob_present=true;
			}
			else
			{
				sec_count++;
				$(".MFA_yubiKey_BKUP").append(mfa_yubiKey_format);
				$(".MFA_yubiKey_BKUP #mfa_phoneDetails").attr("id","mfa_yubiKeyDetails"+sec_count);
				if(!isMobile){
					$("#mfa_yubiKeyDetails"+sec_count).attr("onclick","Mfa_mobile_ui_specific('mfa_yubiKeyDetails"+sec_count+"','"+Yubikey_list[j].key_name+"')");
				}
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .emailaddress_text").html(Yubikey_list[j].key_name);
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" #mfa_ph_time").text(Yubikey_list[j].created_time_elapsed);
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .primary_dot").remove();
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .pri_indicator").remove();
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" #mfa_primary_title").remove();
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .mobile_dp").attr("class","mobile_dp icon-Yubikey");
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .phnum_hover_show #icon-delete").attr("id","mob-delete"+sec_count); 
				$("#mfa_yubikey_mode .icon-makeprimary").remove();
				mfa_title = $(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .phnum_hover_show #mob-delete"+sec_count).attr("onclick");
				$(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .phnum_hover_show #mob-delete"+sec_count).attr("onclick","showDeleteYubikeyQuestion('"+mfa_title+"','"+Yubikey_list[j].key_name+"','"+Yubikey_list[j].e_keyName+"');"); //No I18N 
				mfa_title = $(".MFA_yubiKey_BKUP #mfa_yubiKeyDetails"+sec_count+" .phnum_hover_show #mob-primary"+sec_count).attr("onclick");
			}
		}
		if(sec_count==1)
	    {
	    	$("#mfa_yubikey_mode .pri_sec_indicator").hide();
	    	if(canSetupyubikey){
	    		$("#configure_yubikey_mode").show();
	    	}
	    	else{
	    		$("#configure_yubikey_mode").hide();
	    	}
      		$("#tfa_Yubikey_view_more").hide();
	    }
	    else
	    {
	    	$("#configure_yubikey_mode").hide();
      		$("#tfa_Yubikey_view_more").show();
	    }
		if(sec_count>1){
			$(".MFA_yubiKey_BKUP .secondary").addClass("extra_phonenumbers");
			if(!$("#mfa_yubiKey_primary").length>0){
				$("#yubikey_mode_preference .MFA_yubiKey_BKUP .secondary:first").removeClass("extra_phonenumbers");
			}
		}
	}
	else if(!canSetupyubikey) 
	{
		$("#mfa_yubikey_mode").remove();
	}
	
	if(tfa_data.modes.indexOf("exostar")>-1)
	{
		mfa_deatils[6]="exostar";
		$("#exo_mode_info").hide();
		$("#exo_mode_preference").show();
		if(tfa_data.primary==6)
		{
			$("#mfa_exo_mode").addClass("primary_mode");
			$("#"+$("#mfa_exo_mode").parent().attr("id")).addClass("column_order");
			$("#exo_mode_preference .mfa_mode_status_butt .primary_indicator").show();
			$("#exo_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
			$("#exo_mode_preference  .mfa_mode_status_butt .disbaled_indicator").hide();
			$("#mfa_exo_mode").css("order",-1);
		}
		else
		{
			$("#mfa_exo_mode").css("order",tfa_data.modes.indexOf("yubikey")+1);
		}
		$("#configure_exo_mode").show();
		$("#goto_exo_mode").show();
		if(!canSetupExo)
		{
			$("#exo_mode_preference .mfa_mode_status_butt div").hide();
			$("#exo_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
			$("#mfa_exo_mode").addClass("disabled_option_grid");
			$("#configure_exo_mode").hide();
			$("#goto_exo_mode").hide();
		}
		
//			$("#mfa_exo_detils .emailaddress_text").html("devicename");//No I18N
		$("#mfa_exo_detils .emailaddress_addredtime").html(tfa_data.exostar.created_time_elapsed);
	}
	else if(!canSetupExo) 
	{
		$("#mfa_exo_mode").remove();
	}
		
	
	if(tfa_data.modes.length==1)
	{
		$(".primary_mode .primary_indicator").hide();//hiding the primary indicator when only one mode is present
	}
	if((tfa_data.primary=="-1"	||	tfa_data.primary==undefined	||	mfa_deatils[tfa_data.primary]==undefined)	&&	 tfa_data.is_mfa_activated==true && tfa_data.modes.length != 0)//check if primary mode is defined in the list of configured modes
	{
		setTimeout(function () {
			show_CHprimary_notice();
	    }, 300);
	}
		
	
	if(!jQuery.isEmptyObject(tfa_data.modes) 		||		tfa_data.is_mfa_activated)//tfa is deactivated and tfa data doesnt exist show setup
	{
		if(tfa_data.is_update_allowed)
		{
			$("#tfa_status").show();
		}
		if(tfa_data.is_mfa_activated)
		{
			$("#tfa_active").prop("checked","checked");
			
			//$("#backup_code_grid").show();
			$("#tfa_bk_new_space").show();
		}
		else
		{
			$("#tfa_active").prop("checked",false);
		}
	}
	else
	{
		$("#tfa_status").hide();
	}
	
	if(tfa_data.is_mfa_activated)	
	{
		$(".TFAPrefrences_menu").css("display","block");
		$(".disabled_primary").removeClass("disabled_primary");
		$("#tfa_bk_new_space").removeClass("remove_backup_border");
		$("#tfa_bk_new_space button").removeClass("disabled_recovery_button");
		$("#tfa_bk_new_space button").removeAttr("disabled");
		$("#trusted_browser_space,.TFAPrefrences_menu,.mfa_mode_status_butt").show(); //display trsuted browsers space
		$("#trusted_browsers_space").show();
		//$("#backup_code_grid").show();
		if(tfa_data.bc_cr_time.allow_codes		&&		tfa_data.bc_cr_time.created_time_elapsed!=undefined)
		{
			$('#tfa_bk_new_space #tfa_bk_time').html(formatMessage(i18nMFAkeys["IAM.MFA.BACKUP.CODE.LAST.GENERATED"],tfa_data.bc_cr_time.created_time_elapsed)); // No I18n
			//$('#tfa_bk_new_space #tfa_bk_description').hide();
			$('#tfa_bk_new_space #tfa_bk_time').css("display","block");
			$("#tfa_bk_new_space").removeClass("remove_backup_border");
		}
		else if(!tfa_data.bc_cr_time.allow_codes)
		{
			//$("#backup_code_grid").hide();
			$("#tfa_bk_new_space button").hide();
			$("#tfa_bk_time").hide();
			$("#tfa_bk_new_space .tfa_footer_warning").html(i18nMFAkeys["IAM.MFA.BACKUP.CODE.DISABLED"]); //No I18N
			$("#tfa_bk_new_space .tfa_footer_warning").show();
			$("#tfa_bk_new_space").addClass("remove_backup_border");
			$("#multiTFAsubmenu #recovery").hide();
		}
		else
		{
			$('#tfa_bk_new_space #tfa_bk_description').show();
			$('#tfa_bk_new_space #tfa_bk_time').hide();
			$("#tfa_bk_new_space").removeClass("remove_backup_border");
			if(mfa_deatils[tfa_data.primary]!=undefined		&&	display_bkup_popup && tfa_data.is_mfa_activated)
			{
				setTimeout(function () {
					MFA_backup_notice();
			    }, 300);
			}
			
		}
		if(!tfa_data.is_update_allowed){
			$(".tfa_status").hide();
			$(".mfa_header .primary_indicator").show();
		}
	}
	else
	{
		$(".TFAPrefrences_menu,.mfa_mode_status_butt,#add_tfa_phone,#add_YubiKey,.tfa_settings_sapce #mfa_app_auth_mode #change_configure_Gauthmode,#configure_yubikey_mode,#add_more_backup_num").hide();
		$("#all_tfa_devices .icon-makeprimary,#all_tfa_numbers .icon-makeprimary,#mfa_yubikey_detils .icon-makeprimary").remove();
		$("#mfa_options .primary_mode").find(".primary_indicator").addClass("disabled_primary");
		$("#mfa_options .primary_mode").find(".mfa_mode_status_butt").show();
		$("#mfa_options .option_grid").removeClass("primary_mode");
		$("#trusted_browser_space").hide(); //hide trusted browsers space
		//$("#backup_code_grid").hide();
		$("#tfa_bk_new_space button").prop("disabled", true);
		$("#tfa_bk_new_space button").addClass("disabled_recovery_button");
		$("#tfa_bk_time").hide();
		if(!tfa_data.is_update_allowed && tfa_data.modes.length != 0){
			$(".tfa_status,.primary_indicator").hide();
			$("#modes_space .disbaled_indicator").show();
		}
	}
	
	if(tfa_data.is_mfa_activated || (tfa_data.pfa_data && tfa_data.pfa_data.allowed_modes.indexOf("DEVICE") && tfa_data.pfa_data.oadevice)){
		if(tfa_data.modes.includes('devices') || (tfa_data.pfa_data && tfa_data.pfa_data.allowed_modes.indexOf("DEVICE") && tfa_data.pfa_data.oadevice)){
			if(tfa_data.passphrase_configured){
				$("#mfa_passphrase #mfa_passphrase_description").html(i18nMFAkeys["IAM.MFA.BACKUP.PASSPHRASE.DESCRIPTION.AFTER.SET"]); //No I18N
				if(tfa_data.passhrase_modified_time != undefined && tfa_data.passhrase_modified_time != tfa_data.passphrase_created_time){
					$("#mfa_passphrase #mfa_passphrase_time").html(formatMessage(i18nMFAkeys["IAM.MFA.PASSPHRASE.LAST.CHANGED"],tfa_data.passhrase_modified_time)); //No I18N
				} else {
					$("#mfa_passphrase #mfa_passphrase_time").html(formatMessage(i18nMFAkeys["IAM.MFA.PASSPHRASE.LAST.SET"],tfa_data.passphrase_created_time)); //No I18N
				}
				$("#mfa_passphrase #mfa_passphrase_time").show();
				$("#mfa_passphrase .tfa_footer_warning").html(i18nMFAkeys["IAM.MFA.BACKUP.PASSPHRASE.CHANGE.DESCRIPTION.FOOTER"]); //No I18N
			} else {
				$("#mfa_passphrase #mfa_passphrase_time").hide();
				$("#mfa_passphrase .tfa_footer_warning").html(i18nMFAkeys["IAM.MFA.BACKUP.PASSPHRASE.SET.DESCRIPTION.FOOTER"]); //No I18N
			}
			
		} else {
			$("#mfa_passphrase #mfa_passphrase_time").hide();
			$("#mfa_passphrase .tfa_footer_warning").html(i18nMFAkeys["IAM.MFA.BACKUP.ONEAUTH.DISABLED.DESCRIPTION.FOOTER"]); //No I18N
		}
		$("#mfa_passphrase .tfa_footer_warning").show();
		$("#mfa_passphrase").addClass("remove_backup_border");
		$("#mfa_passphrase button").hide();
		$("#mfa_passphrase button").removeClass("disabled_recovery_button");
	} else {
		
		$("#mfa_passphrase #mfa_passphrase_time").hide();
		$("#mfa_passphrase .tfa_footer_warning").hide();
		$("#mfa_passphrase button").show();
		$("#mfa_passphrase button").addClass("disabled_recovery_button");
		$("#mfa_passphrase").removeClass("remove_backup_border");
		//$("#mfa_passphrase .tfa_footer_warning").html(i18nMFAkeys["IAM.MFA.DISABLED.BACKUP.PASSPHRASE.DESCRIPTION.FOOTER"]); //No I18N
	}
	
	if(!tfa_data.is_mfa_activated && !(tfa_data.pfa_data && tfa_data.pfa_data.allowed_modes.indexOf("DEVICE") && tfa_data.pfa_data.oadevice)){
		$(".mfa_recovery_warning .mfa_recovery_warn_description").html(i18nMFAkeys["IAM.MFA.DISABLED.BACKUP.PASSPHRASE.DESCRIPTION.FOOTER"]); //No I18N
		$(".mfa_recovery_warning").css({"display" : "flex"});
	} else if((tfa_data.bc_cr_time.created_time_elapsed == undefined && (tfa_data.passphrase_configured == undefined || !tfa_data.passphrase_configured)) && !(tfa_data.pfa_data && tfa_data.pfa_data.allowed_modes.indexOf("DEVICE"))){
		$(".mfa_recovery_warning .mfa_recovery_warn_description").html(i18nMFAkeys["IAM.MFA.NORECOVERY.WARN.DESCRIPTION"]); //No I18N
		$(".mfa_recovery_warning").css({"display" : "flex"});
	} else {
		$(".mfa_recovery_warning").hide();
	}
	
	if(!tfa_data.is_mfa_activated && tfa_data.modes[0] != undefined){
		$(".tfa_settings_sapce .mfa_setupnow").hide();
	}
	
	if(tfa_data.trusted_browsers!=undefined	&&	!jQuery.isEmptyObject(tfa_data.trusted_browsers))
	{
		tooltip_Des(".Field_session .asession_browser");//No I18N
		tooltip_Des(".Field_session .asession_os");//No I18N
		var trusted_browsers=tfa_data.trusted_browsers;
		var sessions=timeSorting(trusted_browsers);
		$(".tfa_trusted_browsers").html("");
		var count =0;
		for(iter=0;iter<Object.keys(sessions).length;iter++)
		{
			count++;
			var current_session=trusted_browsers[sessions[iter]];
			session_format = $("#empty_sessions_format").html();
			$(".tfa_trusted_browsers").append(session_format);
			
			$(".tfa_trusted_browsers #trusted_browser").attr("id","trusted_browser"+count);
			$(".tfa_trusted_browsers #trusted_browser_info").attr("id","trusted_browser_info"+count);
	
			$(".tfa_trusted_browsers #trusted_browser_info"+count+" #current_session_logout").attr("onclick","deleteMFATicket('"+current_session.session_ticket+"','trusted_browser"+count+"');");
			if(count > 3)
			{
				$(".tfa_trusted_browsers #trusted_browser"+count).addClass("activesession_entry_hidden");  
			}
			$("#trusted_browser"+count).attr("onclick","show_selected_MFAbrowserinfo("+count+",'"+encodeURIComponent(JSON.stringify(current_session.device_info))+"');");
			addDeviceIcon($("#trusted_browser"+count+" .device_pic"),current_session.device_info);
			$("#trusted_browser"+count+" .device_name").html(current_session.device_info.device_name);
			$("#trusted_browser"+count+" .device_time").html(current_session.created_time_elapsed);
			var os_class=(current_session.device_info.os_img).toLowerCase().replace(/\s/g, '');
			$("#trusted_browser"+count+" .activesession_entry_info .asession_os").addClass("icon-os_"+os_class);
			$("#trusted_browser"+count+" .activesession_entry_info .asession_os").html(fontIconBrowserToHtmlElement[os_class]);
			if(current_session.device_info.version==undefined)
			{
				$("#trusted_browser"+count+" .activesession_entry_info .asession_os").attr("title",current_session.device_info.os_name);
				$("#trusted_browser_info"+count+" #pop_up_os").append("<span>"+current_session.device_info.os_name+"</span>");
			}
			else
			{
				$("#trusted_browser"+count+" .activesession_entry_info .asession_os").attr("title",current_session.device_info.os_name+" "+current_session.device_info.version);
				$("#trusted_browser_info"+count+" #pop_up_os").append("<span>"+current_session.device_info.os_name+" "+current_session.device_info.version+"</span>");

			}
			var browser_class=(current_session.browser_info.browser_image).toLowerCase().replace(/\s/g, '');
			$("#trusted_browser"+count+" .activesession_entry_info .asession_browser").addClass("icon-"+browser_class);
			$("#trusted_browser"+count+" .activesession_entry_info .asession_browser").html(fontIconBrowserToHtmlElement[browser_class]);
			var browser_version = current_session.browser_info.bversion && current_session.browser_info.bversion != "-1" ? current_session.browser_info.bversion  : "";	//No I18N
			$("#trusted_browser"+count+" .activesession_entry_info .asession_browser").attr("title",current_session.browser_info.browser_name+" "+browser_version);
			$("#trusted_browser"+count+" .activesession_entry_info .asession_ip").html(current_session.ip_address);

			if(current_session.location!=undefined)
			{
				$("#trusted_browser"+count+" .asession_location").removeClass("location_unavail");
				$("#trusted_browser"+count+" .asession_location").html(current_session.location.toLowerCase());
				$("#trusted_browser_info"+count+" #pop_up_location").removeClass("unavail");
				$("#trusted_browser_info"+count+" #pop_up_location").html(current_session.location.toLowerCase());
			}
			$("#trusted_browser_info"+count+" #pop_up_time").html(current_session.created_date);
			$("#trusted_browser_info"+count+" #pop_up_os .asession_os_popup").addClass("icon-os_"+os_class);
			$("#trusted_browser_info"+count+" #pop_up_os .asession_os_popup").html(fontIconBrowserToHtmlElement[os_class]);
			$("#trusted_browser_info"+count+" #pop_up_browser .asession_browser_popup").addClass("icon-"+browser_class);
			$("#trusted_browser_info"+count+" #pop_up_browser .asession_browser_popup").html(fontIconBrowserToHtmlElement[browser_class]);
			$("#trusted_browser_info"+count+" #pop_up_browser").append("<span>"+current_session.browser_info.browser_name+" "+browser_version+"</span>");
			
		}
		sessiontipSet(".Field_session .asession_browser");//No I18N
		sessiontipSet(".Field_session .asession_os");//No I18N
		if(count>3)//more THAN 3
		{
			$("#sessions_showall").show();	
			if(count>4)
			{
				$("#sessions_showall").html(formatMessage(i18nTrustedBrowserkeys["IAM.VIEWMORE.BROWSERS"],count-3)); //NO I18N
			}
			else
			{
				$("#sessions_showall").html(formatMessage(i18nTrustedBrowserkeys["IAM.VIEWMORE.BROWSER"],count-3)); //NO I18N
			}
		}
		else
		{
			$("#sessions_showall").hide();	
		}

		$("#trusted_browser_space .box_discrption_with_limit,#sessions_web_more .box_discrption").html(formatMessage($("#trusted_browser_space .box_discrption_with_limit").html(),tfa_data.trusted_days,tfa_data.tb_help));
		$(".box_discrption_with_limit").show();
		$(".box_discrption_without_limit").hide();
		$("#tfa_empty_trustedbrowser,#tfa_disabled_trustedbrowser").hide();
		$(".tfa_trusted_browsers").show();
	}
	else
	{
		if(tfa_data.trusted_days > 0){		
			$("#trusted_browser_space .box_discrption_with_limit,#sessions_web_more .box_discrption").html(formatMessage($("#trusted_browser_space .box_discrption_with_limit").html(),tfa_data.trusted_days,tfa_data.tb_help));
			$("#tfa_empty_trustedbrowser,.box_discrption_with_limit").show();
			$(".tfa_trusted_browsers,#tfa_disabled_trustedbrowser,.box_discrption_without_limit").hide();
		}
		else{
			$("#tfa_disabled_trustedbrowser,.box_discrption_without_limit").show();
			$("#trusted_browser_space .box_discrption_without_limit").html(formatMessage($("#trusted_browser_space .box_discrption_without_limit").html(),tfa_data.tb_help));
			$(".tfa_trusted_browsers,#tfa_empty_trustedbrowser,.box_discrption_with_limit").hide();
		}
	}
	var passkeydata;
	if(isPFAPasskey && tfa_data.pfa_data.passkey){
		passkeydata = tfa_data.pfa_data.passkey;
		passkeydata.count = tfa_data.pfa_data.passkey.length;
	}else if(!isPFAPasskey){
		passkeydata = tfa_data.passkey;
		$('#pfamodes_space #mfa_passkey_auth_mode').remove();
	}
	if(passkeydata && tfa_data.hidePasskey == false){	
		$("#passkey_auth_info").hide();
		$("#appkey_auth_mode_preference").show();
		$("#"+$("#mfa_passkey_auth_mode").parent().attr("id")).addClass("column_order");
		$("#appkey_auth_mode_preference .mfa_mode_status_butt .primary_indicator").hide();
		$("#appkey_auth_mode_preference .mfa_mode_status_butt .secondary_indicator").hide();
		$("#appkey_auth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").hide();
		$("#mfa_passkey_auth_mode").css("order",tfa_data.modes.length+1);
		$("#configure_passkey").show();
		$("#appkey_auth_mode_preference .passkey_container").html("");
		var passkey_temp = $("#appkey_auth_mode_preference .mfa_field_mobile")[0].outerHTML;
		for(var keycount=0; keycount<passkeydata.count;keycount++){
			$("#appkey_auth_mode_preference .passkey_container").append(passkey_temp);
			$("#appkey_auth_mode_preference .passkey_container .mfa_field_mobile:last").attr("id","passkey_"+keycount).show();
			if(isPFAPasskey){
				$("#passkey_"+keycount+" .emailaddress_addredtime").html(passkeydata[keycount].created_time_elapsed);
				$("#passkey_"+keycount+" .emailaddress_text").html(passkeydata[keycount].key_name);
				$("#passkey_"+keycount+" #icon-delete").attr("onclick",$("#appkey_auth_mode_preference .mfa_field_mobile #icon-delete").attr("onclick").split("')")[0]+"','"+passkeydata[keycount].e_keyName+"','"+ passkeydata[keycount].key_name +"', true)");	//No i18N
			}else{
				$("#passkey_"+keycount+" .emailaddress_addredtime").html(passkeydata.passkey[keycount].created_time_elapsed);
				$("#passkey_"+keycount+" .emailaddress_text").html(passkeydata.passkey[keycount].key_name);
				$("#passkey_"+keycount+" #icon-delete").attr("onclick",$("#appkey_auth_mode_preference .mfa_field_mobile #icon-delete").attr("onclick").split("')")[0]+"','"+passkeydata.passkey[keycount].e_keyName+"','"+ passkeydata.passkey[keycount].key_name +"')");	//No i18N
			}
			if(keycount>0){
				$("#mfa_passkey_auth_mode #passkey_"+keycount).addClass("extra_passkey").hide();
			}
		}
		if(passkeydata.count>1){
			$("#appkey_auth_mode_preference .tfa_viewmore").hide();
			$("#appkey_auth_mode_preference #passkey_view_more").show();
		}
		else{
			$("#appkey_auth_mode_preference #configure_passkey_mode").show();
			$("#appkey_auth_mode_preference #passkey_view_more").hide();
		}
		$("#appkey_auth_mode_preference .conf_via_mobile").hide();
		
		if(!canSetUpPasskey && !isPFAPasskey || (!tfa_data.is_mfa_activated && tfa_data.modes.length != 0)){
			$("#appkey_auth_mode_preference #passkey_view_more,.tfa_settings_sapce #appkey_auth_mode_preference #configure_passkey_mode").hide();
			passkeydata.count>1 ? $("#appkey_auth_mode_preference #show_passkey_diabled_conf").show() : "";
		}
	}


	if(tfa_data.hidePasskey || (!canSetUpPasskey && tfa_data.passkey == undefined)){
		if(!isPFAPasskey){$("#mfa_passkey_auth_mode").hide();}
	}
	if(!isMobile)
	{
		tooltipSet(".action_icon");//No I18N
	}
	
	closeNotification();//closing the MFA reminder in the notifications
	
	
}


function load_totp(data){
	$("#pfa_auth_app_info").hide();
	$("#pfa_auth_mode_preference").show();
	$("#pfa_app_auth_mode #configure_authmode").show();
	$("#pfa_app_auth_mode #change_configure_Gauthmode").show();
	$("#pfa_auth_mode_preference .mfa_mode_status_butt div").hide();
	//$("#pfa_app_auth_mode #configure_authmode").hide();
	//$("#pfa_app_auth_mode #change_configure_Gauthmode").hide();
	$("#pfa_app_auth_mode #icon-delete").attr("onclick", $("#pfa_app_auth_mode #icon-delete").attr("onclick").split(")")[0]+", true)")
	//if(!tfa_data.is_update_allowed){
	//	$("#mfa_app_auth_mode").addClass("disabled_option_grid");
	//	$("#app_auth_mode_preference  .mfa_mode_status_butt .disbaled_indicator").show();
	//}
	$("#pfa_app_auth_mode #mfa_auth_detils .emailaddress_addredtime").html(data.created_time_elapsed);
}

function load_passkey(data){
	
}
function open_android_location()
{
	window.open(tfa_android_Link, '_blank');
}

function open_IOS_location()
{
	window.open(tfa_ios_Link, '_blank');
}


//activate and deactive mfa temp

function change_tfa_status()
{
	if(tfa_data.is_update_allowed)
	{
		if(!$("#tfa_active").prop("checked"))
		{
			$("#delete_tfa_popup .tfa_not_activated").hide();
			$("#delete_tfa_popup .tfa_is_activated").show();
			$("#tfa_activate").hide();
			$("#tfa_deactivate").css("display","inline-block");
		}
		else
		{
			$("#delete_tfa_popup .tfa_is_activated").hide();
			$("#delete_tfa_popup .tfa_not_activated").show();
			$("#tfa_deactivate").hide();
	//		re_enableTFA();
			$("#tfa_activate").css("display","inline-block");
		}
		$("#delete_tfa_popup").show(0,function(){
			$("#delete_tfa_popup button:visible").focus();
			$("#delete_tfa_popup").addClass("pop_anim");
		});
		popup_blurHandler('6');
		closePopup(close_delete_tfa_popup,"delete_tfa_popup"); //No i18N
	}
}


function close_delete_tfa_popup(check,preventBlur)
{
	if(preventBlur){
		popupBlurHide('#delete_tfa_popup',function(){	//No i18N
			$("#tfa_activate").hide();
			$("#tfa_deactivate").hide();	
		},true);
	}
	else{
		popupBlurHide('#delete_tfa_popup',function(){	//No i18N
			$("#tfa_activate").hide();
			$("#tfa_deactivate").hide();	
		});
	}
	if(!check)
	{
		if(!$("#tfa_active").prop("checked"))
		{
			$("#tfa_active").prop("checked","checked");
		}
		else
		{
			$("#tfa_active").prop("checked",false);
		}
	}
}


function disableTFA()
{

	if(tfa_data.is_update_allowed)
	{	var parms=
		{
			"activate":false//No I18N
		};
		tfa_status_change(parms);
	}
		
}
	
function re_enableTFA()
{
	if(tfa_data.is_update_allowed)
	{
		var parms=
		{
			"activate":true//No I18N
		};
		tfa_status_change(parms);
	}
}

function tfa_status_change(parms)
{
	if(tfa_data.is_update_allowed)
	{
		var payload = MfaFetchOBJ.create(parms);
		payload.PUT("self","self","mode").then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));
			tfa_data.is_mfa_activated=parms.activate;
			tfa_data.trusted_browsers={};
			close_delete_tfa_popup(true,parms.activate);
			if(parms.activate==true)
			{
				delete tfa_data.bc_cr_time.created_time_elapsed;
				delete tfa_data.bc_cr_time.created_time;
				delete tfa_data.bc_cr_time.created_date;
				show_mfa_device_clear(resp.mfa.sess_term_tokens);
				$("#mfa_signout_space .config_message").hide();
			}
			else
			{
				load_mfa("true");
			}
			
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
	}
    return false;
}



//Delete Mode

function MFA_delete_confirm(title,mode_name,mode, isPFA)
{
	show_confirm(title,formatMessage(mfa_delete_mode, mode_name),
	    function() 
	    {
			if(mode==1)
			{
				delete_totp(isPFA);
			}
			else if(mode==6)
			{
				delete_exo();
			}
//			else
//			{
//				MFA_delete_mode(mode);
//			}
		},
	    function() 
	    {
	    	return false;
	    }
	);
}

function showDeleteYubikeyQuestion(title,name,e_name){
	show_confirm(title,formatMessage(mfa_delete_mode, name),
		    function() 
		    {
				delete_yubikey(e_name);
			},
		    function() 
		    {
		    	return false;
		    }
		);
}
function close_tfa_CHprimary_notice()
{
	popupBlurHide('#CHprimary_NOTICE');//No I18N
}


//backup codes function

function show_backup_notice()
{
	popup_blurHandler('6');
	$("#backupcodes_NOTICE").show(0,function(){
		$("#backupcodes_NOTICE").addClass("pop_anim");
	});
}

function close_tfa_backupcode_NOTICE()
{
	popupBlurHide('#backupcodes_NOTICE');//No I18N
}


function show_backupcodes()
{
	var payload = TfaBackupCodes.create();
	disabledButton($("#backupcodes_tfa"));
	payload.PUT("self","self").then(function(resp)	//No I18N
	{
		if($("#backupcodes_NOTICE").is(":visible") )
		{
			$("#backupcodes_NOTICE").hide().removeClass("pop_anim");
		}
		
		show_backup(resp.backupcodes);
		removeButtonDisable($("#backupcodes_tfa"));
		control_Enter("a");//No I18N
		if(isBackupCodeDowloadMandatory){
			$("#backupcodes_tfa .popup_close_desc").removeClass("red_desc"); //No I18N
			$("#backupcodes_tfa .popup_footer_close").hide(); //No I18N
			$("#backupcodes_tfa .popup_footer").show(); //No I18N
			closePopup(close_tfa_backupcode,"backupcodes_tfa",true);	//No I18N
			$(".blur:visible")[0].onclick= function(){
				$("#backupcodes_tfa .popup_close_desc").addClass("popup_desc_blink");	//No I18N
				setTimeout(function(){$("#backupcodes_tfa .popup_close_desc").removeClass("popup_desc_blink")},900);
			};
			setTimeout(function(){$("#backupcodes_tfa .popup_close_desc").addClass("red_desc")},20000);
		}else{
			closePopup(close_tfa_backupcode,"backupcodes_tfa");			//No I18N
		}
		$("#backupcodes_tfa").focus();
		control_Enter("a");//No I18N
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
		removeButtonDisable($("#backupcodes_tfa"));	
	});
}
var rcUserName;
function show_backup(obj)
{
	var codes = obj.recovery_code;
	var recoverycodes = codes.split(":");
	var createdtime = obj.created_date;
	var res ="<ol class='bkcodes'>"; //No I18N
	var recCodesForPrint = "";
	rcUserName = obj.user;
	for(idx in recoverycodes)
	{
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			res += "<li><b><div class='bkcodes_cell'>"+recCode.substring(0, 4)+"</div><div class='bkcodes_cell'>"+recCode.substring(4, 8)+"</div><div class='bkcodes_cell'>"+recCode.substring(8) + "</div></b></li>"; //No I18N
			recCodesForPrint += recCode + ":";
		}
	}
	res += "</ol>";
	recCodesForPrint = recCodesForPrint.substring(0, recCodesForPrint.length -1); // Remove last ":"
	recTxt = ""; 
	de('bk_codes').innerHTML = res; //No i18N
	$("#downcodes").attr('onclick', 'downloadCodes(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("save_text")'); //No I18N
	$("#printcodesbutton").attr('onclick','copy_code_to_clipboard(\''+createdtime+'\',\''+recoverycodes+'\'); updateBackupStatus("copy")'); //No I18N
	$('#createdtime').html(createdtime); //No i18N
	if(obj.created_time_elapsed)
	{
		$('#tfa_bk_new_space #tfa_bk_time span').html(obj.created_time_elapsed); //No i18N		
		$('#tfa_bk_new_space #tfa_bk_time').show();
		tfa_data.bc_cr_time.created_date=obj.created_date
		tfa_data.bc_cr_time.created_time=obj.created_time
		tfa_data.bc_cr_time.created_time_elapsed=obj.created_time_elapsed
	}
	popup_blurHandler('6');
	$("#backupcodes_tfa").show(0,function(){
		$("#backupcodes_tfa").addClass("pop_anim");
	});
}
var recTxt = "";
function formatRecoveryCodes(createdtime, recoverycodes){
	recTxt = i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.TEXT"]+"\n\n\n"; //No I18n
	
	recTxt = recTxt + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.NOTES"] + "\n";		//No I18n
	i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.NOTES"].split("").forEach(function(){recTxt=recTxt+"-"});	//No I18n
	recTxt = recTxt + "\n# " + i18nMFAkeys["IAM.LIST.BACKUPCODES.POINT1"] + "\n# " + i18nMFAkeys["IAM.LIST.BACKUPCODES.POINT3"] + "\n# " + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.NOTES3"] + "\n# " + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.NOTES4"] + "\n\n\n";	//No I18n
	
	recTxt = recTxt + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE"] + "\n";		//No I18n
	i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.GENERATED.CODE"].split("").forEach(function(){recTxt=recTxt+"-";});		//No I18n
	recTxt = recTxt + "\n" + i18nMFAkeys["IAM.GENERAL.USERNAME"] + ": " + userPrimaryEmailAddress + "\n";		//No I18n
	recTxt = recTxt + i18nMFAkeys["IAM.GENERATE.ON"] + ": " + createdtime + "\n\n";		//No I18n
	
	recoverycodes = recoverycodes.split(",");	//No I18n
	for(var idx=0; idx < recoverycodes.length; idx++){
		var recCode = recoverycodes[idx];
		if(recCode != ""){
			recTxt += "\n "+(idx+1)+". "+recCode.substring(0, 4)+" "+recCode.substring(4, 8)+" "+recCode.substring(8); //No I18n
		}
	}
	
	recTxt = recTxt + "\n\n\n" + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.HELP.LINK"] + "\n";	//No I18n
	i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.HELP.LINK"].split("").forEach(function(){recTxt=recTxt+"-";});	//No I18n
	
	recTxt = recTxt + "\n\n# " + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.RECOVERY.HELP.LINK"] + "\n# " + i18nMFAkeys["IAM.MFA.BACKUPCODE.FILE.NEW.CODE.HELP.LINK"];	//No I18n
	
}

function downloadCodes(createdtime, recoverycodes){
	if(recTxt == ""){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
	var filename = "RECOVERY-CODES-"+rcUserName; //No I18N
	if('showOpenFilePicker' in window){
		var file_option = {
							suggestedName: filename+".txt",	//No I18N
							types: [
							  {
								accept: {
								  'text/plain': ['.txt']	//No I18N
								}
							  }
							]
						};
		var fileHandle,writableFileStream;
		$.when(fileHandle = window.showSaveFilePicker(file_option)).then(function(fileHandle){
			$.when(writableFileStream = fileHandle.createWritable()).then(function(writableFileStream){
				var taBlob = new Blob([recTxt], {type: 'text/plain;charset=utf-8'});
				writableFileStream.write(taBlob);
				writableFileStream.close();
			});
		});
	}
	else{
		var element = document.createElement('a');
		element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(recTxt));
		element.setAttribute('download', filename);
		element.style.display = 'none';
		document.body.appendChild(element);
		element.click();
		document.body.removeChild(element);
	}
	$(".down_copy_proceed").hide();
	if(isBackupCodeDowloadMandatory){
		$("#backupcodes_tfa .close_btn").show(); //No I18N
		$("#backupcodes_tfa .popup_footer_close").show(); //No I18N
		$("#backupcodes_tfa .popup_footer").hide(); //No I18N
		$(".blur:visible")[0].onclick="";
		closePopup(close_tfa_backupcode,"backupcodes_tfa");	//No I18N
	}
}


function copy_code_to_clipboard (createdtime, recoverycodes) {
	
	if(recTxt == ""){
		formatRecoveryCodes(createdtime, recoverycodes);
	}
	navigator.clipboard.writeText(recTxt).then(function () {
		$(".copy_to_clpbrd").hide();
		$(".code_copied").show();
		$("#printcodesbutton .tooltiptext").addClass("tooltiptext_copied");
		if(isBackupCodeDowloadMandatory){
			$("#backupcodes_tfa .close_btn").show(); //No I18N
			$("#backupcodes_tfa .popup_footer_close").show(); //No I18N
			$("#backupcodes_tfa .popup_footer").hide(); //No I18N
			$(".blur:visible")[0].onclick="";
			closePopup(close_tfa_backupcode,"backupcodes_tfa");	//No I18N
		}
	}).catch(function(){
		//error occured while copying
		showErrorMessage(err_try_again);
	});

}

function remove_copy_tooltip() {
	$(".copy_to_clpbrd").show();
	$(".code_copied").hide();
	$("#printcodesbutton .tooltiptext").removeClass("tooltiptext_copied");
}

function updateBackupStatus(mode){
	var params = {"status":mode}; //No I18N
	var payload = BackupCodesStatus.create(params);
	payload.PUT("self","self").then(function(resp){ //No I18N
	});
}

function close_tfa_backupcode()
{
		isBackupCodeDowloadMandatory ? $("#backupcodes_tfa .close_btn").hide():"" ;
		$("#tfa_bk_time").html(formatMessage(i18nMFAkeys["IAM.MFA.BACKUP.CODE.LAST.GENERATED"],tfa_data.bc_cr_time.created_time_elapsed));//no i18n
		popupBlurHide('#backupcodes_tfa',function(){	//No i18N
			$("a").unbind();
		});
}

//mfa device clear

function show_mfa_device_clear(rm_options)
{
	remove_error();
	$("#ter_mob").removeClass("show_oneauth");
	$(".oneAuthLable").hide();
	if(rm_options!=undefined	&&	rm_options.length>0)
	{
		if(rm_options.indexOf("rmwebses")==-1)
		{
			$("#terminate_web_sess").hide();
		}
		if(rm_options.indexOf("rmappses")==-1)
		{
			$("#terminate_mob_apps").hide();
		}
		else if(rm_options.indexOf("inconeauth")==-1)
		{
			$("#ter_mob").removeClass("show_oneauth");
		}
		else
		{
			$("#ter_mob").addClass("show_oneauth");
		}
		if(rm_options.indexOf("rmapitok")==-1)
		{
			$("#terminate_api_tok").hide();
		}
		clearInterval(resend_timer);
		popupBlurHide("#common_popup",function(){		//No I18N
			$("#common_popup #pop_action").html("");
			popup_blurHandler('6');
			$("#mfa_signout_space").show(0,function(){
				$("#mfa_signout_space").addClass("pop_anim");
				if(isMobile){
					var heightForCheckBox=window.innerHeight-($("#mfa_signout_space .popup_header ").outerHeight(true) + $("#mfa_signout_space .popuphead_define").outerHeight(true) + $("#mfa_esc_devices .primary_btn_check").outerHeight(true)+parseInt($("#mfa_esc_devices .primary_btn_check").css("margin-top").replace("px",''))+parseInt($(".tfa_verify_butt.popup_padding").css("padding-Top").replace("px",''))+parseInt($("#change_second").css("margin-top").replace("px",'')));
					var tem=0;
					if($("#mfa_signout_space").innerHeight() <= window.innerHeight){
						tem=heightForCheckBox-$("#change_second").innerHeight();
					}
					$("#change_second").css("overflow","auto");
					$("#change_second").css("height",heightForCheckBox-tem+"px");
				}
			});
		},true);
	    $("#pop_action select").unbind();
	    $(".photo_radio").unbind();
	    $("#sign_in_notification").unbind();
	    $(".suscription_radio").unbind();
	}
	else
	{
		mfa_session_clear();
		close_popupscreen(function(){load_mfa("true")});
	}
	
}

function mfa_session_clear()
{
	popupBlurHide('#mfa_signout_space',function(){ //No I18N
        remove_error();
    	$("#mfa_esc_devices").trigger('reset'); 
	    load_mfa("true");
	    if($(".oneAuthLable").is(":visible")){
			$(".oneAuthLable").slideUp();
		}
	    $(".showOneAuthLable").removeClass("displayBorder");
	    $("#terminate_session_weband_mobile_desc").show();
	},true);
}

//Change mode

function MFA_changeMODE_confirm(title,mode_name,mode)
{
	$("#confirm_popup #confirm_btns").addClass('positive_conform');
//	mode details		 TOUCH ID = 2; QR = 3; PUSH = 4; TOTP = 5; FACEID = 7; oneauth =11 ; bio metric =12
	var content=mfa_change_primary;
	show_confirm(title,formatMessage(content, mode_name),
	    function() 
	    {
			change_mode(mode);
		},
	    function() 
	    {
	    	return false;
	    }
	);
	 if(tfa_data.is_passwordless)
	 {
		 var div = document.createElement('div');
		 div.innerText = formatMessage(i18nMFAkeys["IAM.CHANGE.PRIMARY.PASSWORDLESS.WARNING"], mode_name);
		 div.setAttribute('class', 'warn_msg'); 
		 document.querySelector(".confirm_text").appendChild(div);//No I18N
	//	 $("#confirm_popup .confirm_text").append("<div class='warn_msg'>"+formatMessage(i18nMFAkeys["IAM.CHANGE.PRIMARY.PASSWORDLESS.WARNING"], mode_name)+"</div>");
	 }
}


function change_mode(arg)
{
	var parms=
	{
		"makeprimary":true,//No I18N
		"mode":arg//No I18N
	};

	var payload = MfaFetchOBJ.create(parms);
	
	payload.PUT("self","self","mode").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		tfa_data.primary=arg;
		tfa_data.is_passwordless=false;

		if(tfa_data.bc_cr_time.created_time_elapsed){
			load_mfa();
		}
		else{			
			load_mfa("true");
		}
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
}

//Trusted Browsers

function closeview_selected_browser_view()
{
	popupBlurHide('#trustedbrowser_pop');	//No i18N
}

function show_selected_MFAbrowserinfo(id,device_info)
{
		$("#trustedbrowser_pop .device_name").html($("#trusted_browser"+id+" .device_name").html()); //load into popuop
		$("#trustedbrowser_pop .device_time").html($("#trusted_browser"+id+" .device_time").html()); //load into popuop
		$("#trustedbrowser_pop #sessions_current_info").html($("#trusted_browser_info"+id).html()); //load into popuop
		
		popup_blurHandler('6');
		$("#trustedbrowser_pop").show(0,function(){
			$("#trustedbrowser_pop").addClass("pop_anim");
		});
		$("#trustedbrowser_pop #current_session_logout").focus();
		closePopup(closeview_selected_browser_view,"trustedbrowser_pop");//No I18N
		control_Enter("#trustedbrowser_pop #current_session_logout");	//No I18N
		var devicePicElement = $("#trustedbrowser_pop .device_pic")[0];
		$(devicePicElement).html("");
		$(devicePicElement).removeAttr("class");
		$(devicePicElement).addClass("device_pic");
		addDeviceIcon($("#trustedbrowser_pop .device_pic"), JSON.parse(decodeURIComponent(device_info)));
}


function deleteMFATicket(ticket,id)
{
	var mode=$("#tfa_method").val();
	new URI(TfaBrowser,"self","self","mode",ticket).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete tfa_data.trusted_browsers[ticket]
				load_mfa();
				if($("#sessions_web_more").is(":visible"))
				{
					if(Object.keys(tfa_data.trusted_browsers).length>1)
					{
						show_all_MFAtrusted_browsers();
					}
				}
				else
				{
					closeview_selected_browser_view();
				}
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
	
}	


function show_all_passkey(){
	$("#mfa_show_all_otp,#mfa_show_all_oneauth").hide();
	$("#mfa_show_all_passkey").show();
	$("#view_all_tfa_phonenumber").html("");
	$(".tfa_view_more_box .view_more_content").html("");
	$(".tfa_view_more_box .view_more_content").append($("#appkey_auth_mode_preference .passkey_container").clone(true));
	$("#tfa_view_more_box #header_content").text($("#mfa_passkey_auth_mode .mfa_option_head_cont").html());
	$("#tfa_view_more_box #header_content").attr("class","");
	$("#tfa_view_more_box #header_content").addClass("appkey_auth_mode_preference");
	$("#tfa_view_more_box .icon-delete").attr("title",$("#tfa_view_more_box .icon-delete").attr("data-original-title"));
	$("#tfa_view_more_box .icon-delete").removeAttr("data-tippy");
	$("#tfa_view_more_box .icon-delete").removeAttr("data-original-title");
	$(".tfa_view_more_box .extra_passkey").show();
	popup_blurHandler('6');
	if(!$("#tfa_view_more_box").is(":visible")){
		$(".tfa_view_more_box").show(0,function(){
			$(".tfa_view_more_box").addClass("view_tfa_viewMore");
			$(".tfa_view_more_box").focus();
		});
	}
	closePopup(closeview_all_mfanumber_view,"tfa_view_more_box"); //No I18N
	tooltipSet(".action_icon");//No I18N
}

function show_all_MFAtrusted_browsers()
{	
	tooltip_Des(".Field_session .asession_browser");//No I18N
	tooltip_Des(".Field_session .asession_os");//No I18N

	$("#view_all_sessions").html($(".tfa_trusted_browsers").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_sessions .activesession_entry_hidden").show();
	$("#view_all_sessions .authweb_entry").after( "<br />" );
	$("#view_all_sessions .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_sessions .Field_session").removeAttr("onclick");
	$("#view_all_sessions .info_tab").show();
	//$("#view_all_sessions .asession_action").hide();
	$("#sessions_web_more").show(0,function(){
		$("#sessions_web_more").addClass("pop_anim")
	});
	
	
	
	$("#view_all_sessions .Field_session").click(function(){
		
		var id=$(this).attr('id');
		$("#view_all_sessions .Field_session").addClass("autoheight");
		$("#view_all_sessions .aw_info").slideUp("fast");
		$("#view_all_sessions .activesession_entry_info").show();
		if($("#view_all_sessions #"+id).hasClass("web_email_specific_popup"))
		{	
			$("#view_all_sessions #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_all_sessions .Field_session").removeClass("autoheight");
				$("#view_all_sessions #"+id).removeClass("web_email_specific_popup");
			});
			$("#view_all_sessions .activesession_entry_info").show();
		}
		else
		{
			
			$("#view_all_sessions .Field_session").removeClass("web_email_specific_popup");
			$("#view_all_sessions .Field_session").removeClass("Active_sessions_showall_hover_primary");
			$("#view_all_sessions #"+id).addClass("web_email_specific_popup");
			$("#view_all_sessions #"+id+" .aw_info").slideDown("fast",function(){
				$("#view_all_sessions .Field_session").removeClass("autoheight");
			});
			$("#view_all_sessions #"+id+" .activesession_entry_info").hide();
			$("#view_all_sessions #"+id+" .primary_btn_check").focus();
		}
		
	});
	sessiontipSet(".Field_session .asession_browser");//No I18N
	sessiontipSet(".Field_session .asession_os");//No I18N
	closePopup(closeview_all_sessions_view,"sessions_web_more");//No I18N
	
	$("#sessions_web_more").focus();
}



//TFA SMS MODE 



function validateMobile(val)
{
	var regex = /^\d{5,14}$/; 
	if(val.search(regex) == -1){
		return false; 
	}
	return true; 
}


function close_add_new_tfa_popup()
{
	popupBlurHide('#add_tfa_backup_popup');	//No i18N	
	remove_error();
	$("#confirm_phone input").val("");
	$("#newphone input").val("");
	$("#verified_num").hide(200);
	$(".blue").unbind();
}

function backToAddMfaNumber(){
	$("#confirm_phone").hide();
	$("#newphone,#tfa_bkup_confim_space").show();
	$("#add_tfa_backup_popup .popuphead_text").text(i18nMFAkeys["IAM.TFA.ADD.MOBILE.NUMBER"]);	//No i18N
}

function show_mfa_phn_numbers(hide_box, show_box, desc) {
	if(desc) {
		$("#common_popup .popuphead_define").html(desc);
	}
	$("#"+hide_box).hide();
	$("#"+show_box).show();
}

function inititate_sms_setup(ele)
{
	if(!tfa_data.confirmed_user){
		showErrorMessage(mfa_confirm_account_err);
		return false;
	}
	if(ele.id == "goto_sms_mode"){$("#userChoosedCountry,#userPhoneNumber").val("");}
	var description=$("#sms_mode_head .box_discrption").html();
	set_popupinfo(i18nMFAkeys["IAM.TFA.ADD.MOBILE.NUMBER"],description);	//No i18N
	
	$("#common_popup .close_btn").removeAttr("onclick")
	$("#common_popup .close_btn").on("click", close_add_mobile);
	$("#common_popup").addClass("common_center_popup");
	$("#pop_action").html($("#mfa_sms_mode_popups").html()); //load into popuop
	if(curr_country!=undefined	&&	curr_country!="")
	{
		$("#tfa_numbers_code option[value="+curr_country.toUpperCase()+"]").prop('selected', true);
	}
	$("#userChoosedCountry").val() != "" ? $("#tfa_numbers_code option[value="+$("#userChoosedCountry").val()+"]").prop('selected', true) : "";
	$("#userPhoneNumber").val() != "" ? phonePattern.intialize(document.getElementById("tfa_numbers_code"),$("#userPhoneNumber").val().replace(/[+ \[\]\(\)\-\.\,]/g,'').trim()) : phonePattern.intialize(document.getElementById("tfa_numbers_code"));	//No I18N
	$(".tfa_setup_work_space").attr("onsubmit","return false;");
	$("#newmobile").val("");
	if(!isMobile)
	{		
		$("#tfa_numbers_code").uvselect({
			"searchable" : true, //No i18N
			"dropdown-width": "300px", //No i18N
			"dropdown-align": "left", //No i18N
			"embed-icon-class": "flagIcons", //No i18N
			"country-flag" : true, //No i18N
			"country-code" : true  //No i18N
		});
		control_Enter(".primary_btn_check");//No I18N
	}
	else{
		phonecodeChangeForMobile("#tfa_numbers_code");//No I18N
	}
	if(tfa_data.hasOwnProperty("otp") && tfa_data.otp.hasOwnProperty("recovery_mobile")) {
		list_recovery_numbers("set_verfied_phnnum", "set_verified_num_cta", "set_select_verified_number");//No I18N
	} else {
		$("#set_verified_num_cta").hide();
	}
	$("#tfa_method").val(0);
	closePopup(close_add_mobile,"common_popup");//No I18N
	$("#common_popup #tfa_number_input").focus();
}
function close_add_mobile(){
	
	$("#common_popup .close_btn").off("click");
	$("#common_popup .close_btn").attr("onclick", "close_popupscreen()")
	close_popupscreen(function(){ setTimeout( function(){$("#common_popup").removeClass("common_center_popup")}, 300) })
}
function list_recovery_numbers(container_id, container_cta, select_id) {
		$('#'+container_id).empty();
		var recovery_mobile_list=tfa_data.otp.recovery_mobile;
		$("#"+container_cta).show();
		
		for(var j=0;j<recovery_mobile_list.length;j++)
		{
    		$('#'+container_id).append($('<option>', { value : recovery_mobile_list[j].country_code , id : j}).html(phonePattern.setMobileNumFormat(recovery_mobile_list[j].recovery_num)));
		}
		
		$("#"+container_id).uvselect({
			"searchable" : true, //No i18N
			"embed-icon-class": "flagIcons", //No i18N
			"country-flag" : true, //No i18N
			"use-attr-as-value" : "id" //No i18N
		});
}


function add_mfa_Mobile()
{
	
	remove_error();
	clearInterval(resend_timer);
	if(de('tfa_number_input').value.trim() == ""	&&	$("#newmobile").val()=="")
	{
		$("#enter_num_tfa_space").append( '<div class="field_error">'+empty_field+'</div>' );
		return;
	}
	var mobVal = de('tfa_number_input').value.trim()!=""?de('tfa_number_input').value.trim():$("#newmobile").val();  //No I18N
	mobVal=mobVal.replace(/[+ \[\]\(\)\-\.\,]/g,'');
	var countryCode = $("#countrycode").val()!=""?$("#countrycode").val():de('tfa_numbers_code').value.trim(); //No I18N
	if(validateMobile(mobVal) != true) 
	{
		$("#enter_num_tfa_space").append( '<div class="field_error">'+err_enter_valid_mobile+'</div>' );
		return;
	}
	$("#newmobile").val(mobVal);
	$("#countrycode").val(countryCode);
	
	disabledButton(".tfa_setup_work_space");//No I18N
	var parms=
	{
		"mobile":mobVal,//No I18N
		"countrycode":countryCode//No I18N
	};


	var payload = TFA_mobileOBJ.create(parms);
	var successCallback = function(resp) {
		clear_loading();
		var displayNumber = phonePattern.setMobileNumFormat($("#tfa_number_input").val(),$("#tfa_numbers_code").val());
		SuccessMsg(setMobileNumFormatInResponse(getErrorMessage(resp),displayNumber));
		$("#common_popup #tfa_resend").show();
		$("#add_tfa_backup_popup #tfa_resend").attr("onclick","resend_verify_otp(this,true,3)");//No I18N 
		$("#enc_mob").val(resp.mfamobile.encryptedMobile);
		$("#userChoosedCountry").val($("#tfa_numbers_code").val());
		$("#userPhoneNumber").val($("#tfa_number_input").val());
		verify_mfa_Otpcallback(displayNumber);
		$(".tfa_setup_work_space #tfa_resend").attr("onclick","resend_verify_otp(this,true,3);");
		$(".tfa_setup_work_space .desc_about_block_otp").hide();
		removeButtonDisable(".tfa_setup_work_space");//No I18N
	}
	payload.POST("self","self","mode").then(function(resp)	//No I18N
	{
		successCallback(resp);
	},
	function(resp)
	{
		function errCallback(res) {
			if(res.cause && res.cause.trim() === "invalid_password_token") {
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + res.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			} else {
				showErrorMessage(getErrorMessage(res));
			}
		}
		if (handleCaptcha().isRequired(resp)) {
			handleCaptcha(resp, {
				backBtn: true,
				callbacks: {
					relogin: errCallback,
					beforeInit: function() {
						$('#sms_setup').hide(); //No I18N
						$('#common_popup .popuphead_define').text(''); //No I18N
					}
				}
			}).init('#add-mobile-captcha', payload, ["self","self","mode"]).then(successCallback, function(err) { //No I18N
				$('#sms_setup').show(); //No I18N
				$('#common_popup .popuphead_define').html($("#sms_mode_head .box_discrption").html()); //No I18N
				if(err) {
					errCallback(err);
				}
			});
		} else {
			errCallback(resp);
		}
		clear_loading();
		$("#countrycode").val("");
		removeButtonDisable(".tfa_setup_work_space");//No I18N
	});
}

function verify_mfa_Otpcallback(mobVal)
{
	$(".tfa_setup_work_space .desc_about_block_otp").removeClass("otp_blocked");
	$("#tfa_resend").show();
	
	var heading = i18nMFAkeys["IAM.TFA.VERIFY.MOBILE.NUMBER"];	//No i18N
	var description=formatMessage($("#sms_mode_head .box_verify_discrption").text(),mobVal);
	set_popupinfo(heading,description);
	

	$(".tfa_setup_work_space").attr("onsubmit","verify_mfa_mobile();return false;");
	$("#mfa_verify_space_popups #tfa_verify_cancel").attr("onclick","inititate_sms_setup(this)");
	
	$("#pop_action").html($("#mfa_verify_space_popups").html()); //load into popuop
	splitField.createElement('prefcode',{
		"splitCount":otp_length,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;'	// No I18N
	});
	$('#prefcode .customOtp').attr('onkeypress','remove_error()');
	$("#pop_action #prefcode").click();
	resend_countdown("#pop_action #tfa_resend");//No I18N
	closePopup(close_popupscreen,"common_popup");//No I18N
}



function verify_mfa_mobile()
{
	$("#newmobile").val("");//clearing the value
	remove_error();
	var val = de('prefcode_full_value').value; //No I18N
	var mobileVal;
	
	if(!isEmpty( $('#enc_mob').val()))
	{
		mobileVal = $('#enc_mob').val().trim();
	}
	else
	{
		showErrorMessage(err_cnt_error_occurred);
	}	if(isEmpty(val))
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+empty_field+'</div>' );
		$("#prefcode").click();
		return;
	}
	if(isNaN(val)|| !isValidCode(val))
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+err_valid_otp_code+'</div>' );
		$("#prefcode").click();
		return;
	}
	
	var parms=
	{
		"code":val//No I18N
	};
	$(".tfa_blur").show();
	$(".loader").show();
	var payload = TFA_mobileOBJ.create(parms);
	
	payload.PUT("self","self","mode",mobileVal).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		$("#enc_mob").val("");
		$("#countrycode").val("");
		var display_bkup_popup=false;
		if(tfa_data.modes.indexOf("otp")==-1)
		{
			tfa_data.modes[tfa_data.modes.length]="otp"
			tfa_data.otp=[];
			tfa_data.otp.mobile=[];
			display_bkup_popup=true;
		}
		tfa_data.otp.mobile[tfa_data.otp.mobile.length]=resp.mfamobile;
		tfa_data.otp.count++;
		if(!tfa_data.is_mfa_activated)
		{
			tfa_data.is_mfa_activated=true;
			delete tfa_data.bc_cr_time.created_time;
			if(tfa_data.primary=="-1")
			{
				tfa_data.primary=0;
			}
			show_mfa_device_clear(resp.mfamobile.sess_term_tokens);
			$("#mfa_signout_space .config_message").show();
			
		}
		else
		{
			close_popupscreen(function(){load_mfa(display_bkup_popup)});
		}
		
	},
	function(resp)
	{
		clear_loading();
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
    return false;
}


function resend_mfa_otp(ele,is_primarymob)
{
	if(!$("#"+ele.id+" a").hasClass("resend_otp_blocked"))//countdown is over
	{
		if(is_primarymob)
		{
			add_mfa_Mobile();
		}
		else
		{
			add_tfa_bkup();
		}
	}
	return;
}

function resend_verify_otp(ele,is_primarymob,rem_count)
{
	if(!$("#"+ele.id+" a:visible").hasClass("resend_otp_blocked"))//countdown is over
	{
		remove_error();
		clearInterval(resend_timer);
		var mobNumber = $("#newmobile").val();
		if(showMobileNoPlaceholder && !isEmpty(mobNumber)){
			mobNumber = mobNumber.replace(new RegExp(phonePattern.getPhonePattern($("#countrycode").val())),phonePattern.getPhoneSpace($("#countrycode").val()));
		}
		if(is_primarymob)
		{
			$(".tfa_setup_work_space #tfa_resend").hide();
	    	$(".tfa_setup_work_space #otp_sent").show().addClass("otp_sending").html(OTP_sending);
			if(!isEmpty( $('#enc_mob').val()))
			{
				mobileVal = $('#enc_mob').val().trim();
			}
			else
			{
				showErrorMessage(err_cnt_error_occurred);
			}	
	
			var payload = TFA_mobileOBJ.create();
			
			payload.PUT("self","self","mode",mobileVal).then(function(resp)	//No I18N
			{
				clear_loading();
				var displayNumber = phonePattern.setMobileNumFormat($("#newmobile").val(),$("#countrycode").val());
				SuccessMsg(setMobileNumFormatInResponse(getErrorMessage(resp),displayNumber));
				$("#add_tfa_backup_popup #tfa_resend").attr("onclick","resend_verify_otp(this,true)");//No I18N 
				if(rem_count>1){
					rem_count = --rem_count;
					verify_mfa_Otpcallback(displayNumber);
	                $("#common_popup .desc_about_block_otp").text(rem_count == 1 ? i18nMFAkeys["IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT"] : formatMessage(i18nMFAkeys["IAM.MOBILE.OTP.REMAINING.COUNT"],rem_count)).show();//No I18N 
	                $("#common_popup #tfa_resend").attr("onclick","resend_verify_otp(this,true,"+rem_count+")");	//No I18N 
				}
				else{
					 $("#common_popup .desc_about_block_otp").text(i18nMFAkeys["IAM.MOBILE.OTP.MAX.COUNT.REACHED"]).addClass("otp_blocked");//No I18N 
				}
				setTimeout(function(){
					$(".tfa_setup_work_space #otp_sent").removeClass("otp_sending").html(OTP_resent);
				},500);
				setTimeout(function(){
					$(".tfa_setup_work_space #tfa_resend").show();
					$(".tfa_setup_work_space #otp_sent").hide();
					if($("#common_popup .desc_about_block_otp").hasClass("otp_blocked")){
						 $("#common_popup #tfa_resend").hide();
					}
				},2000);
				removeButtonDisable(".tfa_setup_work_space");//No I18N
			},
			function(resp)
			{
				$(".tfa_setup_work_space #tfa_resend").show();
		    	$(".tfa_setup_work_space #otp_sent").hide();
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
				clear_loading();
				removeButtonDisable(".tfa_setup_work_space");//No I18N
			});
		}
		else
		{
			var mobileVal;
			
			if(!isEmpty( $('#enc_mob').val()))
			{
				mobileVal = $('#enc_mob').val().trim();
			}
			else
			{
				showErrorMessage(err_cnt_error_occurred);
			}
			var parms=
			{
				"is_resend":true//No I18N
			};
			$("#verfiy_code_tfa_bkup_space #tfa_resend").hide();
	    	$("#verfiy_code_tfa_bkup_space #otp_sent").show().addClass("otp_sending").html(OTP_sending);
			disabledButton($("#newphone")[0]);
			var payload = TFA_mobileOBJ.create(parms);		
			payload.PUT("self","self","mode",mobileVal).then(function(resp)	//No I18N
			{
				var displayPhone = phonePattern.setMobileNumFormat(de('mobileno').value,$("#countNameAddDiv option:selected").val()); //No I18N
				SuccessMsg(setMobileNumFormatInResponse(getErrorMessage(resp),displayPhone));
				removeButtonDisable($("#newphone")[0]);
				$("#newphone").hide();
				$("#tfa_bkup_confim_space").hide();
				$("#add_tfa_backup_popup #tfa_resend").attr("onclick","resend_verify_otp(this,false)");
				$("#confirm_phone").show();
				if(rem_count>1){
					rem_count=rem_count-1;
					resend_countdown("#confirm_phone #tfa_resend");//No I18N
	                $("#add_tfa_backup_popup .desc_about_block_otp").text(rem_count == 1 ? i18nMFAkeys["IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT"] : formatMessage(i18nMFAkeys["IAM.MOBILE.OTP.REMAINING.COUNT"],rem_count)).show();//No I18N 
	                $("#add_tfa_backup_popup #tfa_resend").attr("onclick","resend_verify_otp(this,false,"+rem_count+")");	//No I18N 
				}
				else{
					 $("#add_tfa_backup_popup .desc_about_block_otp").text(i18nMFAkeys["IAM.MOBILE.OTP.MAX.COUNT.REACHED"]).addClass("otp_blocked");//No I18N 
				}
				setTimeout(function(){
					$("#verfiy_code_tfa_bkup_space #otp_sent").removeClass("otp_sending").html(OTP_resent);
				},500);
				setTimeout(function(){
					$("#verfiy_code_tfa_bkup_space #tfa_resend").show();
					$("#verfiy_code_tfa_bkup_space #otp_sent").hide();
					if($("#add_tfa_backup_popup .desc_about_block_otp").hasClass("otp_blocked")){
						 $("#add_tfa_backup_popup #tfa_resend").hide();
					}
				},2000);
				$("#vcode").focus();
				},
			function(resp)
			{
				$("#verfiy_code_tfa_bkup_space #tfa_resend").show();
		    	$("#verfiy_code_tfa_bkup_space #otp_sent").hide();
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
				removeButtonDisable($("#newphone")[0]);
				clear_loading();
			});
		}

	}
	return;
}


//tfa backup number addition 

function add_Mfa_backup(recovery_exists)
{	
	$("#add_tfa_backup_popup #phonenumber_password").hide();
	$("#add_tfa_backup_popup").show(0,function(){
		$("#add_tfa_backup_popup").addClass("pop_anim");
	});
		show_addnewbkup();
		

	popup_blurHandler('6');
	control_Enter(".blue");//No i18N
	closePopup(close_add_new_tfa_popup,"add_tfa_backup_popup");//No I18N
	
}


function show_addnewbkup()
{
	$("#delete_tfa_recovery_popup .popuphead_define").html(tfa_new_backup);
	$("#newphone").show();
	$('#tfa-mobile-captcha').html('');
	$("#confirm_phone").hide();
	if(curr_country!=undefined	&&	curr_country!="")
	{
		$("#countNameAddDiv option[value="+curr_country.toUpperCase()+"]").prop('selected', true);
	}
	$("#tfa_new_tobackup").show();
	if(!isMobile)
	{
		$("#countNameAddDiv").uvselect({
			//width: '300px', //No i18N
			"searchable" : true, //No i18N
			"dropdown-width": "320px", //No i18N
			"dropdown-align": "left", //No i18N
			"embed-icon-class": "flagIcons", //No i18N
			"country-flag" : true, //No i18N
			"country-code" : true  //No i18N
		});
	    phonePattern.intialize(document.getElementById("countNameAddDiv"));	//No I18N
	}
	else
	{
		phonecodeChangeForMobile($("#countNameAddDiv")[0]);
	}
	$("#tfa_recover_tobackup").hide();
	$("#mobileno").focus();
}


function verified_num_mfa(container_id, select_id, is_setup) {
	var Ver_phnNum = $("#"+select_id).find(":selected").text();
	var nth_phnNum = $("#"+select_id).find(":selected").attr("id");
	var phnNum = Ver_phnNum.replace(Ver_phnNum.split(" ")[0],"").replace(/[+ \[\]\(\)\-\.\,]/g,'');
	
	disabledButton($("#"+container_id)[0]);
	var payload = makemfa.create();
	payload.PUT("self","self",phnNum).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		removeButtonDisable($("#"+container_id)[0]);
		if(is_setup) {
			var display_bkup_popup=false;
			if(tfa_data.modes.indexOf("otp")==-1)
			{
				tfa_data.modes[tfa_data.modes.length]="otp";
				tfa_data.otp.mobile=[];
				display_bkup_popup=true;
			}
			tfa_data.otp.mobile[tfa_data.otp.mobile.length]=tfa_data.otp.recovery_mobile[nth_phnNum];
		    tfa_data.otp.mobile[tfa_data.otp.mobile.length-1].is_primary = true;
			tfa_data.otp.recovery_mobile.splice(nth_phnNum, 1);
			if(tfa_data.otp.recovery_mobile.length == 0) {
				delete tfa_data.otp.recovery_mobile;
			}
			tfa_data.otp.count++;
			if(!tfa_data.is_mfa_activated)
			{
				tfa_data.is_mfa_activated=true;
				delete tfa_data.bc_cr_time.created_time;
				if(tfa_data.primary=="-1")
				{
					tfa_data.primary=0;
				}
				show_mfa_device_clear(resp.makemfa.sess_term_tokens);
			}
			else
			{
				close_popupscreen(function(){load_mfa(display_bkup_popup)});
			}
		} else {
			close_add_new_tfa_popup();
			$("#enc_mob").val("");
			tfa_data.otp.mobile[tfa_data.otp.mobile.length]=tfa_data.otp.recovery_mobile[nth_phnNum];
			tfa_data.otp.mobile[tfa_data.otp.mobile.length-1].is_primary = false;
			tfa_data.otp.recovery_mobile.splice(nth_phnNum, 1);
			if(tfa_data.otp.recovery_mobile.length == 0) {
				delete tfa_data.otp.recovery_mobile;
			}
			load_mfa();
		}
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
		removeButtonDisable($("#"+container_id)[0]);
		clear_loading();
	});
}

function add_tfa_bkup()
{
	remove_error();
	clearInterval(resend_timer);
	var mobVal = de('mobileno').value.replace(/[+ \[\]\(\)\-\.\,]/g,'');  //No I18N
	if(mobVal == "")
	{
		$("#select_phonenumber").append( '<div class="field_error">'+empty_field+'</div>' );
		return;
	}
	if(validateMobile(mobVal) != true) 
	{
		$("#select_phonenumber").append( '<div class="field_error">'+err_enter_valid_mobile+'</div>' );
		return;	
	} 
	var countryCode = de('countNameAddDiv').value; //No I18N
	var parms=
	{
		"mobile":mobVal,//No I18N
		"countrycode":countryCode//No I18N
	};

	disabledButton($("#newphone")[0]);
	var payload = TFA_mobileOBJ.create(parms);
	var successCallback = function(resp)	
	{
		var displayPhone = phonePattern.setMobileNumFormat(de('mobileno').value,$("#countNameAddDiv option:selected").val()); //No I18N
		SuccessMsg(setMobileNumFormatInResponse(getErrorMessage(resp),displayPhone));
		removeButtonDisable($("#newphone")[0]);
		$("#newphone").hide();
		$("#tfa_bkup_confim_space").hide();
		$("#add_tfa_backup_popup #tfa_resend").attr("onclick","resend_verify_otp(this,false)");
		$("#enc_mob").val(resp.mfamobile.encryptedMobile);
		$("#confirm_phone,#add_tfa_backup_popup #tfa_resend").show();
		$("#add_tfa_backup_popup .popuphead_text").text(i18nMFAkeys["IAM.TFA.VERIFY.MOBILE.NUMBER"]);	//No i18N
		splitField.createElement('vcode',{
			"splitCount":otp_length,					// No I18N
			"charCountPerSplit" : 1,		// No I18N
			"isNumeric" : true,				// No I18N
			"otpAutocomplete": true,		// No I18N
			"customClass" : "customOtp",	// No I18N
			"inputPlaceholder":'&#9679;'	// No I18N
		});
		$('#vcode .customOtp').attr('onkeypress','remove_error()');
		resend_countdown("#confirm_phone #tfa_resend");//No I18N
		$("#tfa_new_tobackup #tfa_resend").attr("onclick","resend_verify_otp(this,false,3);");
		$("#tfa_new_tobackup .desc_about_block_otp").hide();
		$("#vcode").click();
		$('.tfa_info_text').html(formatMessage(err_verify_sms_message,displayPhone));		
	}
	payload.POST("self","self","mode").then(function(resp)	//No I18N
	{
		successCallback(resp)	
	},
	function(resp)
	{
		function errCallback(res) {
			if(res.cause && res.cause.trim() === "invalid_password_token") {
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + res.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			} else {
				showErrorMessage(getErrorMessage(res));
			}
		}
		if (handleCaptcha().isRequired(resp)) {
			handleCaptcha(resp, {
				backBtn: true,
				callbacks: {
					relogin: errCallback,
					beforeInit: function() {
						$('#newphone').hide();	//No I18N
					}
				}
			}).init('#tfa-mobile-captcha', payload, ["self","self","mode"]).then(function(resp){	//No I18N
				successCallback(resp);
			}, function(err) {
				$('#newphone').show();	//No I18N
				if(err) {
				   errCallback(err);
				}
			});
		} else {
			errCallback(resp);
		}
		removeButtonDisable($("#newphone")[0]);
		clear_loading();
	});

}




function closeview_all_tfanumber_view()
{
	tooltip_Des(".tfa_backupnumber .action_icon");//No I18N
	popupBlurHide('#tfa_phonenumber_web_more',function(){//No I18N
		$(".tfa_extra_num").hide();
		$("#view_all_tfa_phonenumber").html("");		
	});
}


function verify_tfa_bkup()
{
	remove_error();
	var code = $('#vcode #vcode_full_value').val().trim(); //No I18N
	if(isEmpty(code)) 
	{
		$("#verfiy_code_tfa_bkup_space").append( '<div class="field_error">'+empty_field+'</div>' );
		$("#vcode").click();
		return;
	}
	if(isNaN(code)||!isValidCode(code))
	{
		$("#verfiy_code_tfa_bkup_space").append( '<div class="field_error">'+err_valid_otp_code+'</div>' );
		$("#vcode").click();
		return;
	}
	
	var mobileVal;
	
	if(!isEmpty( $('#enc_mob').val()))
	{
		mobileVal = $('#enc_mob').val().trim();
	}
	else
	{
		showErrorMessage(err_cnt_error_occurred);
	}
	

	var parms=
	{
		"code":code//No I18N
	};
	disabledButton($("#confirm_phone"));
	var payload = TFA_mobileOBJ.create(parms);
	
	payload.PUT("self","self","mode",mobileVal).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		close_add_new_tfa_popup();
		$("#enc_mob").val("");
		removeButtonDisable($("#confirm_phone"));
	
		tfa_data.otp.mobile[tfa_data.otp.mobile.length]=resp.mfamobile;
		tfa_data.otp.count++;
		tfa_data.is_mfa_activated=true;
		load_mfa(true);
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
		removeButtonDisable($("#confirm_phone"));
		
	});
}




function remove_mfa_backup(title,mfa_delete_mode_text,encrypt_mob,id)
{
	var mobile=$("#"+id+" .emailaddress_text").html();
	
	show_confirm(title,formatMessage(mfa_delete_mode_text, mobile),
	    function() 
	    {
			remove_tfabk_confirm(encrypt_mob);
		},
	    function() 
	    {
	    	return false;
	    }
	);
}
function remove_mfa_preferred(title,text, encrypt_mob,id){
	if(tfa_data.otp.mobile.length > 1){
		var mobile=$("#"+id+" .emailaddress_text").html(); // No I18N
		var msg = document.createElement("DIV");
		msg.innerHTML = document.querySelector("#mfa_prefnumb_del_popup").innerHTML; // No I18N
		msg.querySelector(".popuphead_desc").innerHTML = formatMessage(i18nMFAkeys["IAM.MFA.DEL.PREF.NUMB.DESC"],mobile) // No I18N
		var backupnumbs = $("#sms_mode_preference .MFAnumber_BKUP .mfa_field_mobile"); // No I18N
		for(i=0;i<backupnumbs.length;i++){
			var eachbackup = document.querySelector(".radio_btn.deleteMFAPref").cloneNode(true); // No I18N
			eachbackup.querySelector("input").value = $(backupnumbs[i]).data("encMob") + "#" + backupnumbs[i].id; // No I18N
			eachbackup.querySelector(".radiobtn_text").textContent = backupnumbs[i].querySelector(".emailaddress_text").textContent; // No I18N
			eachbackup.querySelector(".radiobtn_text").style.pointerEvents = "none"; //No I18N
			eachbackup.style.display = "flex"; // No I18N
			msg.querySelector(".delete_mfa_numb").append(eachbackup); // No I18N
		}
		show_confirm(title, msg,
		function(){
			var primEar = $("input[name= 'selectmode']:checked").val();
			encrypt_mob = encrypt_mob +"?"+ primEar;
			remove_tfabk_confirm(encrypt_mob, true);
		},
		function(){
			$(".deleteMFAPref:visible").unbind(); // No I18N
			$(".confirmpopup .popup_padding").removeClass("lssBtnMrg"); // No I18N
			$("#return_true").removeAttr("disabled"); // No I18N
			return false;
		});
		$("#return_true").attr("disabled","disabled"); // No I18N
		$(".confirmpopup .popup_padding").addClass("lssBtnMrg"); // No I18N
		$(".delete_mfa_numb").on("click", function(e){
		if(e.target.classList.contains("deleteMFAPref")){
			$(e.target).children("#mfamobilepref").click();
		}else{
			e.target.click();
			if(e.target.name == "selectmode" && $(e.target).is(":checked")){
				$("#return_true").removeAttr("disabled");
			}
		}
	});
	}else{
		if(tfa_data.otp.mobile[0].hasOwnProperty('is_login_mobile')){
			text =	tfa_delete_login_number;
		}else{
			text = mfa_delete_mode;
		}
		remove_mfa_backup(title, text, encrypt_mob, id);
	}
}

function make_primary_backup(title,encrypt_mob,id)
{
	var mobile=$("#"+id+" .emailaddress_text").html();
	
	show_confirm(title,formatMessage(primary_mobile_change_sure, mobile),
	    function() 
	    {
			MK_primary_tfabk_confirm(encrypt_mob);
		},
	    function() 
	    {
	    	return false;
	    }
	);
	$("#confirm_popup #confirm_btns").addClass('positive_conform');
}


function MK_primary_tfabk_confirm(e_mobile)
{
	var parms={};

	var payload = tfa_makeprim.create(parms);
	payload.PUT("self","self","mode",e_mobile).then(function(resp)	//No I18N
    {
		SuccessMsg(getErrorMessage(resp));
		var mobile_list=tfa_data.otp.mobile;
	    for(j=0;j<mobile_list.length;j++)
		{
	    	if(mobile_list[j].is_primary)
			{
	    		delete tfa_data.otp.mobile[j].is_primary;
			}
	    	if(mobile_list[j].e_mobile==e_mobile)
	    	{
	    		tfa_data.otp.mobile[j].is_primary=true;
	    	}
		}
	    tfa_data.is_mfa_activated=true;
		load_mfa();
		if($("#tfa_view_more_box").is(":visible"))
		{
				show_all_Mfa_phonenumbers();
		}
    },
    function(resp)
	{
    	if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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

function remove_tfabk_confirm(e_mobile, isPreferred)
{	
	if(isPreferred){
		earMob = e_mobile.split("?");
		earMob2 = earMob[1].split("#")[0];
		primID = earMob[1].split("#")[1];
		var uri = new URI(TFA_mobileOBJ,"self","self","mode",earMob[0]).addQueryParam("primary",earMob2); // No I18N
		e_mobile=earMob[0];
	}else{
		var uri = new URI(TFA_mobileOBJ,"self","self","mode",e_mobile); // No I18N
	}
	uri.DELETE().then(function(resp)
	{
		if(isPreferred){
			SuccessMsg(i18nMFAkeys["IAM.MFA.DEL.PREF.SUCC.MSG"]);
			var mobList=tfa_data.otp.mobile;
			for(var x=0; x<mobList.length; x++){
				if(mobList[x].e_mobile==earMob2){
					tfa_data.otp.mobile[x].is_primary = true;
				}
			}
		}else {
			SuccessMsg(getErrorMessage(resp));
		}
				var mobile_list=tfa_data.otp.mobile;
			    for(j=0;j<mobile_list.length;j++)
				{
			    	if(mobile_list[j].e_mobile==e_mobile)
			    	{
			    		if(mobile_list.length!=j+1)
			    		{
			    			tfa_data.otp.mobile[j]=mobile_list[mobile_list.length-1];
			    			delete tfa_data.otp.mobile[mobile_list.length-1];
			    		}
			    		else
			    		{
			    			delete tfa_data.otp.mobile[j];
			    		}
			    		var display_bkup_popup=false;
			    		tfa_data.otp.mobile.length--
			    		if(tfa_data.otp.mobile.length==0)
			    		{
			    			delete tfa_data.otp.mobile;
			    			delete tfa_data.modes[tfa_data.modes.indexOf("otp")];
			    			delete mfa_deatils[0];
			    			if(tfa_data.primary==0)
							{
								tfa_data.primary="-1";
							}
			    			if(jQuery.isEmptyObject(mfa_deatils))
			    			{
			    				tfa_data.is_mfa_activated=false;
			    				delete tfa_data.bc_cr_time.created_time_elapsed;
			    			}
			    			display_bkup_popup=true;
			    		}
			    		break;
			    	}
				}
			    tfa_data.modes = tfa_data.modes.filter(function(){return true});
			    load_mfa(display_bkup_popup);
				if($("#tfa_view_more_box").is(":visible"))
				{
					if(tfa_data.otp.mobile.length>1)
					{
						show_all_Mfa_phonenumbers();
					}
					else
					{
						closeview_all_mfanumber_view();
					}
				}
				
			},
			function(resp)
			{
				if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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


function show_all_Mfa_phonenumbers()
{
	$("#mfa_show_all_otp").show();
	$("#mfa_show_all_oneauth").hide();
	$("#view_all_tfa_phonenumber").html("");
	$(".tfa_view_more_box .view_more_content").html("");
	//$("#view_all_tfa_phonenumber").append($("#all_tfa_numbers").html());
	$(".tfa_view_more_box .view_more_content").append($("#all_tfa_numbers").clone(true));
	$("#tfa_view_more_box #header_content").text($("#sms_mode_preference .mfa_option_head_cont").html());
	$("#tfa_view_more_box #header_content").attr("class","");
	$("#tfa_view_more_box #header_content").addClass("sms_mode_preference");
	$("#tfa_view_more_box .icon-delete").attr("title",$("#tfa_view_more_box .icon-delete").attr("data-original-title"));
	$("#tfa_view_more_box .icon-delete").removeAttr("data-tippy");
	$("#tfa_view_more_box .icon-delete").removeAttr("data-original-title");
	$(".tfa_view_more_box .extra_phonenumbers").show();
	popup_blurHandler('6');
	if(!$("#tfa_view_more_box").is(":visible")){
		$(".tfa_view_more_box").show(0,function(){
			$(".tfa_view_more_box").addClass("view_tfa_viewMore");
			$(".tfa_view_more_box").focus();
		});
	}
	closePopup(closeview_all_mfanumber_view,"tfa_view_more_box"); //No I18N
	sessiontipSet(".tfa_backupnumber .action_icon");//No I18N	
	tooltipSet(".action_icon");//No I18N
	
	
	
}


function closeview_all_mfanumber_view()
{
	tooltip_Des(".tfa_backupnumber .action_icon");//No I18N
//	popupBlurHide('#tfa_phonenumber_web_more',function(){//No I18N
//		$(".tfa_extra_num").hide();
//		$("#view_all_tfa_phonenumber").html("");		
//	});
	$(".tfa_view_more_box").removeClass("view_tfa_viewMore");
	popupBlurHide(".tfa_view_more_box",function(){  //No I18N
		$(".tfa_extra_num").hide();
		$(".tfa_view_more_box .view_more_content").html("");
	}); //No I18N

}

//MFA MOBILE SPECIFIC POPUP

function Mfa_mobile_ui_specific(id,enc_id)
{
	if(isMobile)
	{
		$(".mob_popu_btn_container").show();
		$(".option_container").hide();
		
		if(!$("#tfa_phonenumber_web_more").is(":visible"))
		{
			remove_error();	
			popup_blurHandler("6");
			$("#tfaphone_mobile_ui").show(0,function(){
				$("#tfaphone_mobile_ui").addClass("pop_anim");
			});
			
			if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-delete"))
			{
				$("#btn_to_delete").show();
				var name = $("#"+id+" .mobile_info .emailaddress_text").html();
				
				if(id=="MFAdevice_primary"	||	id.startsWith("mfa_deviceDetails"))//for device mode
				{
					$("#btn_to_delete").attr("onclick","show_MFA_mob_confirmUI('mfa_device_delete','"+formatMessage(mfa_delete_mode,name)+"','"+enc_id+"')");
				}
				else
				{
					$("#btn_to_delete").attr("onclick","show_MFA_mob_confirmUI('mfa_ph_delete','"+formatMessage(mfa_delete_mode,name)+"','"+enc_id+"')");
				}
			}
			if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-makeprimary"))
			{
				$("#btn_to_chng_primary").show();
				var name = $("#"+id+" .mobile_info .emailaddress_text").html();
				
				if(id=="MFAdevice_primary"	||	id.startsWith("mfa_deviceDetails"))//for device mode
				{
					$("#btn_to_chng_primary").attr("onclick","show_MFA_mob_confirmUI('mfa_device_primary','"+formatMessage(mfa_change_prim_device, name)+"','"+enc_id+"')");//No I18N
				}
				else
				{
					$("#btn_to_chng_primary").attr("onclick","show_MFA_mob_confirmUI('mfa_ph_primary','"+formatMessage(primary_mobile_change_sure, name)+"','"+enc_id+"')");//No I18N
				}
			}
			$("#tfaphone_mobile_ui .popuphead_details").html($("#"+id).html());
			$("#tfaphone_mobile_ui").focus();
			closePopup(close_MFA_mobile_specific,"tfaphone_mobile_ui");//No I18N
		}
		else
		{
			if(!$(event.target).parents().hasClass("inline_action"))
			{
				var prev_parent_id=undefined;
				if($("#view_all_tfa_phonenumber .inline_action").length)
				{
					prev_parent_id = $("#view_all_tfa_phonenumber .inline_action").parents(".mfa_field_mobile").attr("id");
					if(prev_parent_id == id)
					{
						$("#"+prev_parent_id+" .inline_action").slideUp(300,function(){
							$("#"+prev_parent_id+" .inline_action").remove();
						});
					}
				}
				
				$("#view_all_tfa_phonenumber .action_icons_div_ph").removeClass("show_icons");
				
				$("#view_all_tfa_phonenumber #"+id+" .action_icons_div_ph").addClass("show_icons");
				
				
				
				$("#view_all_tfa_phonenumber #"+id).append('<div class="inline_action"></div>');
				$("#view_all_tfa_phonenumber #"+id+" .inline_action").html($("#tfaphone_mobile_ui").html());
				
				
				if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-delete"))
				{
					$("#btn_to_delete").show();
					var name = $("#"+id+" .mobile_info .emailaddress_text").html();
					
					if(id=="MFAdevice_primary"	||	id.startsWith("mfa_deviceDetails"))//for device mode
					{
						$("#btn_to_delete").attr("onclick","show_MFA_mob_confirmUI_viewall('mfa_device_delete','"+formatMessage(mfa_delete_mode,name)+"','"+enc_id+"')");
					}
					else
					{
						$("#btn_to_delete").attr("onclick","show_MFA_mob_confirmUI_viewall('mfa_ph_delete','"+formatMessage(mfa_delete_mode,name)+"','"+enc_id+"')");
					}
				}
				if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-makeprimary"))
				{
					$("#btn_to_chng_primary").show();
					var name = $("#"+id+" .mobile_info .emailaddress_text").html();
					
					if(id=="MFAdevice_primary"	||	id.startsWith("mfa_deviceDetails"))//for device mode
					{
						$("#btn_to_chng_primary").attr("onclick","show_MFA_mob_confirmUI_viewall('mfa_device_primary','"+formatMessage(mfa_change_prim_device, name)+"','"+enc_id+"')");//No I18N
					}
					else
					{
						$("#btn_to_chng_primary").attr("onclick","show_MFA_mob_confirmUI_viewall('mfa_ph_primary','"+formatMessage(primary_mobile_change_sure, name)+"','"+enc_id+"')");//No I18N
					}
				}
				
				if(prev_parent_id!=undefined)
				{
					if(prev_parent_id != id)
					{
						$("#view_all_tfa_phonenumber #"+prev_parent_id+" .inline_action").slideUp(300,function(){
							$("#view_all_tfa_phonenumber #"+prev_parent_id+" .inline_action").remove();
							$("#view_all_tfa_phonenumber #"+id+" .inline_action" ).slideDown(300);
						});
						
					}
					else
					{
						var previous=$("#view_all_tfa_phonenumber #"+id+" .inline_action" )[0];
						var newele=$("#view_all_tfa_phonenumber #"+id+" .inline_action" )[1];
						$(previous).slideUp(300,function(){
							$(newele).slideDown(300,function(){
								$(previous).remove();
							});
						});
					}
				}
				else
				{
						$("#view_all_tfa_phonenumber #"+id+" .inline_action" ).slideDown(300);
				}
			
			}
		}
	}
}


function show_MFA_mob_confirmUI_viewall(action_type,def,enc_id)
{
	$(".inline_action").slideUp(300,function()
	{
		$(".inline_action .mob_popu_btn_container").hide();
		$(".inline_action .option_container").show();
		$(".inline_action").slideDown(300);		
	});
	$(".inline_action .option_container .mob_popuphead_define").html(def);
	
	$("#view_all_tfa_phonenumber .option_button #action_granted").click(function()
	{	
		if(action_type == "mfa_ph_primary" )
		{
			MK_primary_tfabk_confirm(enc_id)
			return false;
		}
		else if(action_type == "mfa_ph_delete" )
		{
			remove_tfabk_confirm(enc_id);
			return false;
		}
		else if(action_type == "mfa_device_delete" )
		{
			remove_device_confirm(enc_id);
			return false;
		}
		else if(action_type == "mfa_device_primary" )
		{
			MK_primary_device_confirm(enc_id);
			return false;
		}
			
	});
	
	
}

function show_MFA_mob_confirmUI(action_type,def,enc_id)
{
	$(".mob_popu_btn_container").slideUp(300,function()
	{
		$(".option_container").slideDown(300);
	});
	$(".option_container .mob_popuphead_define").html(def);
	
	$("#tfaphone_mobile_ui .option_button #action_granted").click(function()
	{	
		if(action_type == "mfa_ph_primary" )
		{
			MK_primary_tfabk_confirm(enc_id)
			return false;
		}
		else if(action_type == "mfa_ph_delete" )
		{
			remove_tfabk_confirm(enc_id);
			return false;
		}
		else if(action_type == "mfa_device_delete" )
		{
			remove_device_confirm(enc_id);
			return false;
		}
		else if(action_type == "mfa_device_primary" )
		{
			MK_primary_device_confirm(enc_id);
			return false;
		}
	});
}


function close_MFA_mobile_specific()
{
	if($("#tfa_phonenumber_web_more").is(":visible"))
	{
		$(".viewall_popup_content .inline_action").slideUp(300,function()
		{
			$(".viewall_popup_content .inline_action").remove();
		});
	}
	else{
		popupBlurHide("#tfaphone_mobile_ui",function()	//No I18N
		{

		}); 
	}
	$(".option_button #action_granted").unbind();
}



//Device setup 


function show_all_devices()
{
	$("#mfa_show_all_otp").hide();
	$("#mfa_show_all_oneauth").show();
	$("#view_all_tfa_phonenumber").html("");
    $(".tfa_view_more_box .view_more_content").html("");
	//$("#view_all_tfa_phonenumber").append($("#all_tfa_devices").html());
	$(".tfa_view_more_box .view_more_content").append($("#all_tfa_devices").html());
	$("#tfa_view_more_box #header_content").text($("#oneauth_mode_preference .mfa_option_head_cont").html());
	$("#tfa_view_more_box #header_content").attr("class","");
	$("#tfa_view_more_box #header_content").addClass("oneauth_mode_preference");
	$("#tfa_view_more_box .icon-delete").attr("title",$("#tfa_view_more_box .icon-delete").attr("data-original-title"));
	$("#tfa_view_more_box .icon-delete").removeAttr("data-tippy");
	$("#tfa_view_more_box .icon-delete").removeAttr("data-original-title");
    $(".tfa_view_more_box .extra_phonenumbers").show();
    
	popup_blurHandler('6');
	if(!$("#tfa_view_more_box").is(":visible")){
		$(".tfa_view_more_box").show(0,function(){
			$(".tfa_view_more_box").addClass("view_tfa_viewMore");
			$(".tfa_view_more_box").focus();
	    });
	}
    closePopup(closeview_all_mfanumber_view,"tfa_view_more_box"); //No I18N
	
	sessiontipSet(".tfa_backupnumber .action_icon");//No I18N
	tooltipSet(".action_icon");//No I18N
}



function remove_mfa_device(title,encrypt_device,id)
{
	var device_name=$("#"+id+" .emailaddress_text").html();
	
	show_confirm(title,formatMessage(mfa_delete_mode, device_name),
	    function() 
	    {
			remove_device_confirm(encrypt_device);
		},
	    function() 
	    {
	    	return false;
	    }
	);
}


function remove_device_confirm(encrypt_device)
{	
	new URI(TFA_deviceOBJ,"self","self","mode",encrypt_device).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var device_list;
				if(isPFADevice){	
					device_list = tfa_data.pfa_data.oadevice;
					for(j=0;j<device_list.length;j++)
					{
				    	if(device_list[j].device_id==encrypt_device)
				    	{
				    		if(device_list.length!=j+1)
				    		{
				    			tfa_data.pfa_data.oadevice[j]=device_list[device_list.length-1];
				    			delete tfa_data.pfa_data.oadevice[device_list.length-1];
				    		}
				    		else
				    		{
				    			delete tfa_data.pfa_data.oadevice[j];
				    		}
				    		tfa_data.pfa_data.oadevice.length--;
				    		var display_bkup_popup=false;
				    		if(tfa_data.pfa_data.oadevice.length==0)
				    		{
				    			delete tfa_data.pfa_data.oadevice;
				    			delete tfa_data.pfa_data.allowed_modes[tfa_data.modes.indexOf("DEVICE")];
				    			
				    			delete mfa_deatils[2];
				    			delete mfa_deatils[3];
				    			delete mfa_deatils[4];
				    			delete mfa_deatils[5];
				    			delete mfa_deatils[7];
				    			delete mfa_deatils[11];
				    			delete mfa_deatils[12];
				    			if(mfa_deatils[tfa_data.primary]==undefined)
								{
									tfa_data.primary="-1"
								}
				    			if(jQuery.isEmptyObject(mfa_deatils))
				    			{
				    				tfa_data.is_mfa_activated=false;
				    				delete tfa_data.bc_cr_time.created_time_elapsed;
				    			}
				    			display_bkup_popup=true;
				    		}
				    		break;
				    	}
					}
				    tfa_data.pfa_data.allowed_modes = tfa_data.pfa_data.allowed_modes.filter(function(){return true});
				}
				else{
					device_list = tfa_data.devices.device;
				    for(j=0;j<device_list.length;j++)
					{
				    	if(device_list[j].device_id==encrypt_device)
				    	{
				    		if(device_list.length!=j+1)
				    		{
				    			tfa_data.devices.device[j]=device_list[device_list.length-1];
				    			delete tfa_data.devices.device[device_list.length-1];
				    		}
				    		else
				    		{
				    			delete tfa_data.devices.device[j];
				    		}
				    		tfa_data.devices.device.length--;
				    		var display_bkup_popup=false;
				    		if(tfa_data.devices.device.length==0)
				    		{
				    			delete tfa_data.devices;
				    			delete tfa_data.modes[tfa_data.modes.indexOf("devices")];
				    			
				    			delete mfa_deatils[2];
				    			delete mfa_deatils[3];
				    			delete mfa_deatils[4];
				    			delete mfa_deatils[5];
				    			delete mfa_deatils[7];
				    			delete mfa_deatils[11];
				    			delete mfa_deatils[12];
				    			if(mfa_deatils[tfa_data.primary]==undefined)
								{
									tfa_data.primary="-1"
								}
				    			if(jQuery.isEmptyObject(mfa_deatils))
				    			{
				    				tfa_data.is_mfa_activated=false;
				    				delete tfa_data.bc_cr_time.created_time_elapsed;
				    			}
				    			display_bkup_popup=true;
				    		}
				    		break;
				    	}
					}
				    tfa_data.modes = tfa_data.modes.filter(function(){return true});
			    }
			    load_mfa(display_bkup_popup);
				if($("#tfa_view_more_box").is(":visible"))
				{ 
					var cur_device_data_length = isPFADevice ? tfa_data.pfa_data.oadevice.length : tfa_data.devices.device.length;
					if(cur_device_data_length==0)
					{
						closeview_all_mfanumber_view();
					}
					else
					{
						show_all_devices();
					}
				}
				
			},
			function(resp)
			{
				if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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

function make_device_primary(title,encrypt_device,id)
{
	var device_name=$("#"+id+" .emailaddress_text").html();
	
	show_confirm(title,formatMessage(mfa_change_prim_device, device_name),
	    function() 
	    {
			MK_primary_device_confirm(encrypt_device);
		},
	    function() 
	    {
	    	return false;
	    }
	);
	$("#confirm_popup #confirm_btns").addClass('positive_conform');
}


function MK_primary_device_confirm(encrypt_device)
{
	var payload = TFA_deviceOBJ.create();
	payload.PUT("self","self","mode",encrypt_device).then(function(resp)	//No I18N
    {
		SuccessMsg(getErrorMessage(resp));
		var device_list;
		if(isPFADevice){
			device_list=tfa_data.pfa_data.oadevice;
			for(j=0;j<device_list.length;j++){
		    	if(device_list[j].is_primary)
				{
		    		delete tfa_data.pfa_data.oadevice[j].is_primary;
				}
		    	if(device_list[j].device_id==encrypt_device)
		    	{
		    		tfa_data.pfa_data.oadevice[j].is_primary=true;
		    	}
			}
		}
		else{
		device_list=tfa_data.devices.device;
	    for(j=0;j<device_list.length;j++)
		{
	    	if(device_list[j].is_primary)
			{
	    		delete tfa_data.devices.device[j].is_primary;
			}
	    	if(device_list[j].device_id==encrypt_device)
	    	{
	    		tfa_data.devices.device[j].is_primary=true;
	    	}
		}
		}
	    tfa_data.is_mfa_activated=true;
		load_mfa();
		if($("#tfa_view_more_box").is(":visible"))
		{
			show_all_devices();
		}
    },
    function(resp)
	{
    	if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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









//Authn App setup 


function inititate_auth_setup(isOneAuthStep, isPFA)
{
	if(!tfa_data.confirmed_user){
		showErrorMessage(mfa_confirm_account_err);
		return false;
	}
	if(isPFA){
		var payload = pfaOTPObj.create();
	}else{
		var payload = OtpObj.create();
		isPFA = false;
	}

	payload.POST("self","self","mode").then(function(resp)	//No I18N
	{
		var heading = $("#auth_mode_head .box_head").html();
		var description= isOneAuthStep ? $("#auth_mode_head .authen-oneauth-step").html() : $("#auth_mode_head .box_discrption").html(); //No I18N
		set_popupinfo(heading,description,true,true);
		$("#pop_action").html($("#mfa_auth_mode_popups").html()); //load into popuop
		if(isOneAuthStep) {
			$('.tfa_setup_work_space .authenticator-oneauth-notes').hide(); //No I18N
			$('.tfa_setup_work_space #oneauth-step-cancel').show(); //No I18N
			
		} else {
			$('.tfa_setup_work_space .authenticator-oneauth-notes').show(); //No I18N
			$('.tfa_setup_work_space #oneauth-step-cancel').hide(); //No I18N
		}
		if(isPFA && $(".popup_padding .authenticator-oneauth #oa_setup_now:visible").length){
			$(".popup_padding .authenticator-oneauth #oa_setup_now").attr("onclick", $(".popup_padding .authenticator-oneauth #oa_setup_now").attr("onclick").split(")")[0]+", true)");
		}
		control_Enter(".primary_btn_check"); //No i18N
		control_Enter("#tfaremember_field"); //No i18N
		$("#tfa_auth_box .primary_btn_check:first").focus();
		closePopup(close_popupscreen,"common_popup");//No I18N
		$("#common_popup").focus();
		var data=resp.totp[0];
		de('gauthimg').src="data:image/jpeg;base64,"+data.qr_image;
		var key=data.secretkey;
		
		var displaykey = "<span>"+key.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+key.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+key.substring(8,12)+"</span>"+"<span style='margin-left:5px'>"+key.substring(12)+"</span>"; //No I18N
		$('#skey').html(displaykey); //No i18N
		
		$("#pop_action #auth_app_confirm").attr("onclick","verify_auth_qr('"+data.encryptedSecretKey+"',"+isOneAuthStep+","+isPFA+")");
		if(isMobile){
			$(".qr_key_note").text(i18MfaSetupKeys["IAM.TAP.TO.COPY"]); //No I18n
		}	
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
}


function download_options()
{
	var heading = $("#auth_mode_downloads .box_head").html();
	var description=$("#auth_mode_downloads .box_discrption").html();
	set_popupinfo(heading,description,true);
	
	$("#pop_action").html($("#mfa_auth_downloads_popups").html()); //load into popuop
	closePopup(close_popupscreen,"common_popup");//No I18N
}

function showNextStep(e, isPFA)
{
	if(e){
		e.preventDefault();
		e.stopPropagation();
	}
	var heading = $("#authenticator_oneauth .box_head").html();
	if(isMobile){
		if(/Android/i.test(navigator.userAgent)){
			//$("#authenticator_oneauth .box_discrption .appstore-icon").css("visibility","hidden");
			$("#authenticator_oneauth .box_discrption .macstore-icon").css("display","none");
			$("#authenticator_oneauth .box_discrption .microsoftstore-icon").css("display","none");
		} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
			$("#authenticator_oneauth .box_discrption .appstore-icon").css({"order":1});
			$("#authenticator_oneauth .box_discrption .playstore-icon").css({"order":2});
			$("#authenticator_oneauth .box_discrption .macstore-icon").css({"display":"none","order":2});
			$("#authenticator_oneauth .box_discrption .microsoftstore-icon").css("display","none");
		}
	} else {
		if(/Macintosh/i.test(navigator.userAgent)){		
			$("#authenticator_oneauth .box_discrption .microsoftstore-icon").css("display","none");
		} else {			
			$("#authenticator_oneauth .box_discrption .macstore-icon").css({"display":"none","order":4});
			$("#authenticator_oneauth .box_discrption .microsoftstore-icon").css({"order":3});
		}
	}
	var description=$("#authenticator_oneauth .box_discrption").html();
	set_popupinfo(heading,description,true, true);
	$("#pop_action").html(''); //load into popuop
	if(isPFA){
		$("#authen-oneauth-download .oneauth_totp_set").attr("onclick", $("#authen-oneauth-download .oneauth_totp_set").attr("onclick").split(")")[0]+", true)")
		$("#authen-oneauth-download .high_cancel").attr("onclick",$("#authen-oneauth-download .high_cancel").attr("onclick").split(")")[0]+"false, true)")
	}
//	closePopup(close_popupscreen,"common_popup");//No I18N
	return false;
}

function verify_auth_qr(key,isForOneauth, isPFA)
{
	var heading = verify_otp_heading;
	var description= isForOneauth? oneauth_verify_authenticator_desc : err_verify_qr_key;
	set_popupinfo(heading,description,false, true);
	
	$("#mfa_verify_space_popups #tfa_verify_cancel").attr("onclick","inititate_auth_setup("+isForOneauth+")");
	
	$("#pop_action").html($("#mfa_verify_space_popups").html()); //load into popuop
	$("#pop_action .resend_with_block").hide(); // No I18N
	$("#pop_action form.tfa_setup_work_space").attr("onsubmit", "verify_mfa_authOTP('"+key+"',"+ isPFA +");return false;")
	if(isPFA){
		$("#tfa_verify_cancel").attr("onclick", "inititate_auth_setup(false, true)")
	}
	splitField.createElement('prefcode',{
		"splitCount":totp_size,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;'	// No I18N
	});
	$('#prefcode .customOtp').attr('onkeypress','remove_error()');
	$("#tfa_resend").hide();

//	closePopup(close_popupscreen,"common_popup");//No I18N
	$("#common_popup #prefcode").click();
	
}


function verify_mfa_authOTP(key, isPFA)
{
	remove_error();
	var code = de('prefcode_full_value').value; //No I18N
	if(code == "")
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+empty_field+'</div>' );
		$("#prefcode").click();
		return;
	}
	else if(code.length<totp_size)
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+err_valid_otp_code+'</div>' );
		$("#prefcode").click();
		return;
	}
	
	var parms=
	{
		"code":code//No I18N
	};
	$(".tfa_blur").show();
	$(".loader").show();
	disabledButton($("#tfa_verify_box"));
	if(isPFA){
		var payload = pfaOTPObj.create(parms);
	}else{
		var payload = OtpObj.create(parms);
	}
	
	payload.PUT("self","self","mode",key).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));

		if(isPFA){
			tfa_data.pfa_data.totp = resp.totp;
			close_popupscreen(function(){load_mfa()});
			
		}else{
			if(tfa_data.modes.indexOf("totp")==-1)
			{
				tfa_data.modes[tfa_data.modes.length]="totp";
			}
			tfa_data.totp=resp.totp;
			if(!tfa_data.is_mfa_activated)
			{
				tfa_data.is_mfa_activated=true;
				delete tfa_data.bc_cr_time.created_time
				if(tfa_data.primary=="-1")
				{
					tfa_data.primary=1;
				}
				show_mfa_device_clear(resp.totp.sess_term_tokens);
				$("#mfa_signout_space .config_message").show();
			}
			else
			{
				close_popupscreen(function(){load_mfa("true")});
			}
		}
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
		clear_loading();
		removeButtonDisable($("#tfa_verify_box"));
	});	
}


function delete_totp(isPFA)
{
	if(isPFA){
		var uri = new URI(pfaOTPObj,"self","self","mode"); //No I18N
	}else{
		var uri = new URI(OtpObj,"self","self","mode");  //No I18N
	}
	uri.DELETE().then(function(resp)
			{
				SuccessMsg(getErrorMessage(resp));
				if(isPFA){
					delete tfa_data.pfa_data.totp;
					load_mfa();
				}else{
					tfa_data.modes = tfa_data.modes.filter(function(e){ return e !== 'totp'});	//No I18N
					delete tfa_data.totp;
					delete mfa_deatils[1];
					if(tfa_data.primary==1)
					{
						tfa_data.primary="-1";
					}
    				if(jQuery.isEmptyObject(mfa_deatils))
    				{
    					tfa_data.is_mfa_activated=false;
    					delete tfa_data.bc_cr_time.created_time_elapsed;
    				}
					load_mfa("true");
				}
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
}

function copyQrKey(element) {
  var copyText = element.querySelector("#skey"); //No I18n
  navigator.clipboard.writeText(copyText.textContent);
  var tickElement = document.createElement("span");
  tickElement.classList.add("tooltip-tick"); //No I18n
  element.querySelector(".tooltip-text").innerText = i18MfaSetupKeys["IAM.APP.PASS.COPIED"]; //No I18n
  element.querySelector(".tooltip-text").prepend(tickElement); //No I18n
  return;
}

function resetTooltipText(element) {
	const tooltipHide = setInterval(function() {
		element.querySelector(".tooltip-text").innerText = i18MfaSetupKeys["IAM.MFA.COPY.CLIPBOARD"]; //No I18n
		clearTimeout(tooltipHide);	
	}, 300);
	return;
}

//EXO STAR MODE 


function inititate_exo_setup()
{
	$("#tfa_method").val(6);
	var heading = $("#exostar_mode_downloads .box_head").html();
	var description=$("#exostar_mode_downloads .box_discrption").html();
	set_popupinfo(heading,description);
	
	$("#pop_action").html($("#mfa_exostar_mode_popups").html()); //load into popuop
	
	closePopup(close_popupscreen,"common_popup");//No I18N
}



function showExoAuthVerify_popup()
{
	var heading =tfa_device_verify;
	var description;
	if(de('hardmodepref').checked)
	{ 
		description = err_exoauth_verify_message;//No i18N
		$("#exo_type").val("hardtok");
	}
	else
	{ 
		description = err_exoauth_verify_message1; //No i18N 
		$("#exo_type").val("softtok");
	}
	
	set_popupinfo(heading,description);
	
	$("#prefcode").val("");
	$("#prefcode").focus();
	
	$("#mfa_verify_space_popups #tfa_verfiy_butt").attr("onclick","verify_mfa_exoOTP()");
	$("#mfa_verify_space_popups #tfa_verify_cancel").attr("onclick","inititate_exo_setup()");
	
	$("#pop_action").html($("#mfa_verify_space_popups").html()); //load into popuop
	$("#tfa_resend").hide();
	
	closePopup(close_popupscreen,"common_popup");//No I18N
}

function verify_mfa_exoOTP()
{
	remove_error();
	var val = de('prefcode').value; //No I18N
	if(isEmpty(val))
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+empty_field+'</div>' );
		return;
	}
	if(isNaN(val)	&&	val.length!=6)
	{
		$("#verfiy_code_tfa_space").append( '<div class="field_error">'+err_invalid_verify_code+'</div>' );
	}
	var type=$("#exo_type").val();
	
	$(".tfa_blur").show();
	$(".loader").show();
	var parms=
	{
		"code":val,//No I18N
		"type":type//No I18N
	};


	var payload = TFA_EXO_OBJ.create(parms);
	
	payload.POST("self","self","mode").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		if(tfa_data.modes.indexOf("exo")==-1)
		{
			tfa_data.modes[tfa_data.modes.length]="exo";
		}
		tfa_data.exo=resp.MFAEXOStar;
		if(!tfa_data.is_mfa_activated)
		{
			tfa_data.is_mfa_activated=true;
			delete tfa_data.bc_cr_time.created_time
			if(tfa_data.primary=="-1")
			{
				tfa_data.primary=6;
			}
			show_mfa_device_clear(resp.mfaexostar.sess_term_tokens);
			$("#mfa_signout_space .config_message").show();
		}
		else
		{
			close_popupscreen(function(){load_mfa("true")});
		}
	},
	function(resp)
	{
		showErrorMessage(getErrorMessage(resp));
		clear_loading();
	});
	
}

function delete_exo()
{
	new URI(TFA_EXO_OBJ,"self","self","mode").DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				tfa_data.modes = tfa_data.modes.filter(function(e){ return e !== 'exo'});	//No I18N
				delete tfa_data.exo;
				delete mfa_deatils[6];
				if(tfa_data.primary==6)
				{
					tfa_data.primary="-1";
				}
    			if(jQuery.isEmptyObject(mfa_deatils))
    			{
    				tfa_data.is_mfa_activated=false;
    				delete tfa_data.bc_cr_time.created_time_elapsed;
    			}
				load_mfa("true");
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
}

// YUBIKEY SETUP

var hardKeyTransition; 
function inititate_yubikey_setup()
{
	if(!isWebAuthNSupported()){
		showErrorMessage(webauthn_not_supported);
		return false;
	}
	if(!tfa_data.confirmed_user){
		showErrorMessage(mfa_confirm_account_err);
		return false;
	}
	//show the yubikey popup
	set_popupinfo("","");//no heading needed
	
	$("#common_popup").addClass("yubikey_popup");
	$("#pop_action").html($("#mfa_yubikey_mode_popups").html()); //load into popuop
	closePopup(close_yubikey_popup,"common_popup");//No I18N
	$("#common_popup #yubikey_start_butt").focus();
	if(isMobile){
		$(".dot_status .dot").removeClass('grow_width');
		$(".dot_status .dot_1").addClass("grow_width");
		hardKeyTransition = setInterval(function(){
		    var cur_grow = $(".dot_status .grow_width");
		    cur_grow.removeClass('grow_width');
		    cur_grow.siblings('.dot').addClass('grow_width'); //No I18N
		    $(".yubikey_anim_container").toggleClass('move_pic');
		},5000)
	}
}

function close_yubikey_popup()
{
	hardKeyTransition != undefined ? clearInterval(hardKeyTransition) : "";
	$(".dot_status .dot").removeClass('grow_width');
	close_popupscreen(function(){$("#common_popup").removeClass("yubikey_popup");});
	challengeJSON={};
}

function show_yubikey_configure()
{
	$("#tfa_method").val(8);
	
	var parms={};
	$("#common_popup").focus();
	var payload = Yubikey_obj.create(parms);
	payload.POST("self","self","mode").then(function(resp)	//No I18N
    {
		$("#pop_action .yubikeyregis").hide();
		$("#pop_action #ubkey_wait_butt").show();
		existingName = (resp.mfayubikey[0].existingKeyNames)?resp.mfayubikey[0].existingKeyNames:[];
		show_yubikey_step2();
		
		
		if(resp != null)
		{
			challengeJSON=resp.mfayubikey[0];
			$("#pop_action .yubikeyregis").hide();
			$("#pop_action #ubkey_wait_butt").show();
			makeCredential(challengeJSON, false, false);
		}
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

}

function show_yubikey_step1()
{
	$("#pop_action #first_step").show();
	$("#pop_action #second_step").hide();
}

function get_YUBIKEY_name()
{
	$("#pop_action #second_step").hide();
	$("#pop_action #third_step").show();
	$("#common_popup #yubikey_name").val("");
	$("#common_popup #yubikey_name").focus();
}

function show_yubikey_step2()
{
	remove_error();
	$("#pop_action #first_step").hide();
	$("#pop_action #third_step").hide();
	$("#pop_action #second_step").show();
	hardKeyTransition != undefined ? clearInterval(hardKeyTransition) : "";
	$(".dot_status .dot").removeClass('grow_width');
}

function configure_yubikey()
{
	remove_yubikeyerror();
	var name=$("#pop_action #yubikey_name").val().trim();
	if(isEmpty(name)	|| 	isBlank(name) )
	{
		$("#pop_action #yubikey_name_field").append( '<div class="yubikey_error field_error">'+empty_field+'</div>');
		$(".yubikey_name_desc").hide();
		return false;
	}
	if(name.length > 50){
		$("#pop_action #yubikey_name_field").append( '<div class="yubikey_error field_error">'+name_validation_error_for_key_name+'</div>');
		$(".yubikey_name_desc").hide();
		return false;
	}
	else if(!isValidSecurityKeyName(name) || hasEmoji(name))
	{
		$("#pop_action #yubikey_name_field").append( '<div class="yubikey_error field_error">'+yubikey_invalid_name+'</div>');
		$(".yubikey_name_desc").hide();
		return false;
	}
	else if(checkRepeatedName(name)){
		$("#pop_action #yubikey_name_field").append( '<div class="yubikey_error field_error">'+Yubikey_repeated_conf_name+'</div>');
		$(".yubikey_name_desc").hide();
		return false;
	}
	disabledButton($("#common_popup #third_step"));
	registerYubikey(credential_data,name);
}


function remove_yubikeyerror()
{
	$(".field_error").remove();
	$(".yubikey_name_desc").show();
}

function delete_yubikey(name)
{
	new URI(Yubikey_obj,"self","self","mode",name).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				tfa_data.yubikey.yubikey.some(function(data,i){
					if(data.e_keyName == name){
						var position = existingName.indexOf(data.key_name);
						existingName = existingName.slice(0,position).concat(existingName.slice(position+1));
			    		delete tfa_data.yubikey.yubikey[i];
			    		return true;
					}
				});
				tfa_data.yubikey.yubikey = tfa_data.yubikey.yubikey.filter(function(){return true});
				tfa_data.yubikey.count = tfa_data.yubikey.yubikey.length;
				var display_bkup_popup = false;
				if(tfa_data.yubikey.yubikey.length==0){					
					tfa_data.modes = tfa_data.modes.filter(function(e){ return e !== 'yubikey'});	//No I18N
					delete tfa_data.yubikey;
					delete mfa_deatils[8];
					if(tfa_data.primary==8)
					{
						tfa_data.primary="-1"
					}
					if(jQuery.isEmptyObject(mfa_deatils))
					{
						tfa_data.is_mfa_activated=false;
						delete tfa_data.bc_cr_time.created_time_elapsed;
					}
					display_bkup_popup =true;
				}
				load_mfa(display_bkup_popup);
				
				if($("#tfa_view_more_box").is(":visible"))
				{
					if(tfa_data.yubikey.yubikey.length>1)
					{
						show_all_YubiKey();
					}
					else
					{
						closeview_all_mfanumber_view();
					}
				}
			},
			function(resp)
			{
				if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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

function show_all_YubiKey()
{
	$(".tfa_view_more_box .view_more_content").html("");
	$(".tfa_view_more_box .view_more_content").append($("#mfa_yubikey_detils").html());
	$("#tfa_view_more_box #header_content").text($("#yubikey_mode_preference .mfa_option_head_cont").html());
	$("#tfa_view_more_box #header_content").attr("class","");
	$("#tfa_view_more_box #header_content").addClass("yubikey_mode_preference");
	$("#tfa_view_more_box .icon-delete").attr("title",$("#tfa_view_more_box .icon-delete").attr("data-original-title"));
	$("#tfa_view_more_box .icon-delete").removeAttr("data-tippy");
	$("#tfa_view_more_box .icon-delete").removeAttr("data-original-title");
	$(".tfa_view_more_box .extra_phonenumbers").show();
	popup_blurHandler('6');
	if(!$("#tfa_view_more_box").is(":visible")){
		$(".tfa_view_more_box").show(0,function(){
			$(".tfa_view_more_box").addClass("view_tfa_viewMore");
			$(".tfa_view_more_box").focus();
		});
	}
	closePopup(closeview_all_mfanumber_view,"tfa_view_more_box"); //No I18N
	sessiontipSet(".tfa_backupnumber .action_icon");//No I18N
		
	tooltipSet(".action_icon");//No I18N
}

function MFA_backup_notice()
{
	popup_blurHandler('6');
	$("#backupcodes_NOTICE").show(0,function(){
		$("#backupcodes_NOTICE").addClass("pop_anim");
	});
	closePopup(close_tfa_backupcode_NOTICE,"backupcodes_NOTICE",isBackupCodeDowloadMandatory);	//No I18N
	$("#backupcodes_NOTICE").focus();
}

//remove the notifiation askinf users to enable TFA
function remove_MFA_reminder()
{
 	$("#remind_TFA").remove();
 	var count=parseInt($("#pending_notif_count").attr("data-val"));
	count--;
	if(count<10	&&	count>0)
	{
		$("#pending_notif_count").html(count);
	}	
	else if(count==0)
	{
		$("#pending_notif_count").hide();
	}
}

function inititate_passkey_setup(isPFA){
	var heading = $("#passkey_mode_head .box_head").html();
	var description=$("#passkey_mode_head .box_discrption").html();
	set_popupinfo(heading,description,true);
	$("#pop_action").html($("#mfa_passkey_mode_popups").html());
	$("#common_popup .close_btn").attr("onclick","close_popupscreen(removeChallengeJson)")
	closePopup(close_popupscreen,"common_popup");//No I18N
	$("#common_popup #passkey_name").focus();
	$("#passkey_Bluetooth_internet a").attr("href",passkeyHelpDoc).attr("target","_blank");
	$("#common_popup").addClass("passkey_common_popup");
	if(isPFA){
		$("#passkey_add").attr("onclick", $("#passkey_add").attr("onclick").split(")")[0]+"true)");
	}
	if(isMobile){
		$("#common_popup").addClass("pp_popup_mobile");
		$("#common_popup .popup_header").addClass("popup_header_mobile");
		$("#common_popup .close_btn").addClass("close_btn_mobile");
		$("#common_popup .popup_padding").addClass("popup_padding_mobile");
		if(!(window.innerWidth > 500 && window.innerWidth <= 900)){
			$("#common_popup .dot_for_desc").hide();
		}
		$("#common_popup .title_with_green_dot").addClass("title_with_green_dot_mobile");
		$("#common_popup .desc_abt_title").addClass("desc_abt_title_mobile");
	}
}

function removeMobilePopupStyles(){
	$("#common_popup").removeClass("pp_popup_mobile");
	$("#common_popup .popup_header").removeClass("popup_header_mobile");
	$("#common_popup .close_btn").removeClass("close_btn_mobile");
	$("#common_popup .popup_padding").removeClass("popup_padding_mobile");
	$("#common_popup .dot_for_desc").show();
	$("#common_popup .title_with_green_dot").removeClass("title_with_green_dot_mobile");
	$("#common_popup .desc_abt_title").removeClass("desc_abt_title_mobile");
}

function removeChallengeJson(){
	challengeJSON = {};
	removePasskeyError();
	if(isMobile && $("#passkey_name").is(":visible")){
		// this if statement remove the styles for passkey mobile popup
		removeMobilePopupStyles();
	}
	$("#common_popup .close_btn").attr("onclick","close_popupscreen()");
	$("#common_popup").removeClass("passkey_common_popup");
}

function removePasskeyError(){
	$("#common_popup .field_error").remove();
	$("#common_popup .passkey_name_desc").show();
}
function show_passkey_configure(isPFA)
{
	//$("#tfa_method").val(8);
	removePasskeyError();
	var passkeyname = $("#common_popup #passkey_name").val().trim();
	if(isEmpty(passkeyname)){
		$("#pop_action #passkey_name_field").append( '<div class="field_error">'+empty_field+'</div>');
		$("#common_popup .passkey_name_desc").hide();
		return false;
	}
	if(passkeyname.length > 50){
		$("#pop_action #passkey_name_field").append( '<div class="field_error">'+name_validation_error_for_key_name+'</div>');
		$("#common_popup .passkey_name_desc").hide();
		return false;
	}
	if(!isValidSecurityKeyName(passkeyname) || hasEmoji(passkeyname)){
		$("#pop_action #passkey_name_field").append( '<div class="field_error">'+err_valid_name+'</div>');
		$("#common_popup .passkey_name_desc").hide();
		return false;
	}
	var parms={};
	$("#common_popup").focus();
	var payload = Passkey_obj.create(parms);
	disabledButton($("#common_popup"));
	if(checkRepeatedName(passkeyname)){
			removeButtonDisable($("#common_popup"));
			removePasskeyError();
			$(".blur:visible").css("z-index","6").unbind();
			closePopup(close_popupscreen,"common_popup");//No I18N
			$("#pop_action #passkey_name_field").append( '<div class="field_error">'+Yubikey_repeated_conf_name+'</div>');
			$(".passkey_name_desc").hide();
			return false;
	}
	payload.POST("self","self","mode").then(function(resp)	//No I18N
    {
		$(".blur:visible").css("z-index","10").unbind();
		if(resp != null)
		{
			challengeJSON=resp.mfapasskey[0];
			existingName = (resp.mfapasskey[0].existingKeyNames)?resp.mfapasskey[0].existingKeyNames:[];
			if(checkRepeatedName($("#passkey_name").val())){
				removeButtonDisable($("#common_popup"));
				removePasskeyError();
				$(".blur:visible").css("z-index","6").unbind();
				closePopup(close_popupscreen,"common_popup");//No I18N
				$("#pop_action #passkey_name_field").append( '<div class="field_error">'+Yubikey_repeated_conf_name+'</div>');
				$(".passkey_name_desc").hide();
				return false;
			}
			if(isPFA){
				makeCredential(challengeJSON,true, true);
			}else{
				makeCredential(challengeJSON,true, false);
			}
		}
    },
    function(resp)
	{
    	removeButtonDisable($("#common_popup"));
    	challengeJSON={};
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

function registerPasskey(data,keyname, isPFA){
	data = JSON.parse(data);
	data = data.mfapasskey;
	var parms=
	{
			"key_name" : keyname,	//No I18N
			"id":data.id,		//No I18N
			"rawId":data.rawId,		//No I18N
			"response":data.response,		//No I18N
			"type":data.type		//No I18N
	};
	var payload = Passkey_obj.create(parms);
	payload.PUT("self","self","mode","self").then(function(resp)	//No I18N
	{
		removeButtonDisable($("#common_popup"));
		challengeJSON={};
		if(resp.status_code == 200){
			SuccessMsg(getErrorMessage(resp));
			if(isPFA){
				if(tfa_data.pfa_data.passkey == undefined){
					tfa_data.pfa_data.passkey=[];
					
					tfa_data.pfa_data.passkey[0] = resp.mfapasskey.passkey;
					tfa_data.pfa_data.passkey.count = 1;
				}else{
					tfa_data.pfa_data.passkey.count = tfa_data.pfa_data.passkey.count + 1;
					tfa_data.pfa_data.passkey.push(resp.mfapasskey.passkey)
				}
			}else{
				if(tfa_data.passkey == undefined){
					tfa_data.passkey=[];
					tfa_data.passkey.passkey=[];
					tfa_data.passkey.passkey[0] = resp.mfapasskey.passkey;
					tfa_data.passkey.count = 1;
				} else {
					tfa_data.passkey.count = tfa_data.passkey.count+1
					tfa_data.passkey.passkey.push(resp.mfapasskey.passkey);
				}
			}
			close_popupscreen(function(){load_mfa()});
		}
		else
		{
			$(".blur:visible").css("z-index","6").unbind();
			closePopup(close_popupscreen,"common_popup");//No I18N
			showErrorMessage(getErrorMessage(resp));
		}
	},
	function(resp)
	{
		removeButtonDisable($("#common_popup"));
		challengeJSON={};
		$(".blur:visible").css("z-index","6").unbind();
		closePopup(close_popupscreen,"common_popup");//No I18N
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
function showDeletePasskeyQuestion(title,e_keyname, name, isPFA){
	var passkeyname = name;
	show_confirm(title,formatMessage(mfa_delete_mode, passkeyname),
		    function() 
		    {
				delete_Passkey(e_keyname, isPFA);
			},
		    function() 
		    {
		    	return false;
		    }
		);
}
var existingName = [];
function checkRepeatedName(name){
		name = name.toUpperCase();
		for(n = 0; n < existingName.length; n++){
			if(existingName[n].toUpperCase() == name){
				return true;
			}
		}
		return false;
}

function delete_Passkey(passkey, isPFA){
	new URI(Passkey_obj,"self","self","mode",passkey).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				if(isPFA){
					var passkey_arr = tfa_data.pfa_data.passkey;
					if(passkey_arr.length>1){					
						for(var x=0; x<passkey_arr.length; x++){
							if(passkey_arr[x].e_keyName == passkey){
								delete tfa_data.pfa_data.passkey[x];
								break;
							}
						}
						tfa_data.pfa_data.passkey = tfa_data.pfa_data.passkey.filter(function(){return true});
						tfa_data.pfa_data.passkey.count = tfa_data.pfa_data.passkey.length;
						load_mfa(false);
						if($("#tfa_view_more_box").is(":visible")){show_all_passkey();}
					}else{					
						delete tfa_data.pfa_data.passkey;
						load_mfa(false);
						closeview_all_mfanumber_view();
					}
				}else{
					var passkey_arr = tfa_data.passkey.passkey;
					if(passkey_arr.length>1){					
						for(var x=0; x<passkey_arr.length; x++){
							if(passkey_arr[x].e_keyName == passkey){
								delete tfa_data.passkey.passkey[x];
								break;
							}
						}
						tfa_data.passkey.passkey = tfa_data.passkey.passkey.filter(function(){return true});
						tfa_data.passkey.count = tfa_data.passkey.passkey.length;
						load_mfa(false);
						if($("#tfa_view_more_box").is(":visible")){show_all_passkey();}
					}else{					
						delete tfa_data.passkey;
						var display_bkup_popup = false;
						load_mfa(display_bkup_popup);
						closeview_all_mfanumber_view();
					}
				}
				
			},
			function(resp)
			{
				if(resp.cause && resp.cause.trim() === "invalid_password_token") 
				{
					if($("#tfa_view_more_box").is(":visible")){$("#"+$("#tfa_view_more_box #header_content").attr("class")+" .view_more").first().click();}
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

function showOneauthPop(){	
	document.querySelector(".msg-popups .popup-header").style.display = "none"; //No I18n
	document.querySelector(".msg-popups .popup-body").style.borderRadius = "10px"; //No I18n	
		
	document.querySelector(".msg-popups .popup-body").innerHTML = document.querySelector(".oneauth-popup").innerHTML;  //No I18n
	document.querySelector(".msg-popups .popup-body").classList.add("padding-oneauthpop");  //No I18n
	document.querySelector(".msg-popups .pop-close-btn").style.display = "block"; //No I18n
	if(isMobile){
		if(/Android/i.test(navigator.userAgent)){
			//$(".msg-popups .appstore-icon").css("visibility","hidden");
			$(".msg-popups .macstore-icon").css("visibility","hidden");
			$(".msg-popups .microsoftstore-icon").css("visibility","hidden");
		} else if(/iphone|ipad|ipod/i.test(navigator.userAgent)){
			$(".msg-popups .appstore-icon").css({"order":1});
			$(".msg-popups .playstore-icon").css({"order":2});
			$(".msg-popups .macstore-icon").css({"visibility":"hidden","order":2});
			$(".msg-popups .microsoftstore-icon").css("visibility","hidden");
		}
	} else {
		if(/Macintosh/i.test(navigator.userAgent)){		
			$(".msg-popups .microsoftstore-icon").css("visibility","hidden");
		} else {			
			$(".msg-popups .macstore-icon").css({"visibility":"hidden","order":4});
			$(".msg-popups .microsoftstore-icon").css({"order":3});
		}
	}
	
	$(".msg-popups").show(0,function(){
		$(".msg-popups").addClass("pop_anim");
	});
	popup_blurHandler("6");
	
	closePopup(close_popupscreen,"msg-popups");//No I18N
		
}

function storeRedirect(url){
	window.open(url, '_blank');
}

function setMobileNumFormatInResponse(msg,displayNumber){
	var divElement = $('<div />').html(msg);
	divElement.find("span").html(displayNumber);
	return divElement[0].innerHTML;
}

function addDeviceIcon(element, device_info){
	var img = device_info.device_img;
	var os = device_info.os_img;
	const paths = new Map([
		  ["windows", 5],
		  ["linux", 5],
		  ["osunknown", 4],
		  ["macbook", 8],
		  ["iphone", 9],
		  ["ipad", 7],
		  ["windowsphone", 8],
		  ["samsungtab", 6],
		  ["samsung", 8],
		  ["android", 8],
		  ["pixel", 8],
		  ["oppo", 8],
		  ["vivo", 6],
		  ["androidtablet",6],
		  ["oneplus", 9],
		  ["mobile", 7],
		  ["iphone13", 4],
		  ["iphone14", 8],
		  ["s23ultra", 8],
		  ["s20fe5g", 9]
		]);
	
	var no_of_paths;
	var icon_class;
	
	if(img == "personalcomputer"){
		os = os ? os : "osunknown"; //No I18N
		no_of_paths = paths.get(os);
		icon_class = os + "_uk"; //No I18N
	} else if (img == "macbook" || img == "iphone" || img == "windowsphone" || img == "androidtablet") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img + "_uk"; //No I18N
	} else if (img == "vivo" || img == "ipad" || img == "samsungtab" || img == "samsung" || img == "pixel" || img == "oppo" || img == "oneplus") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img;
	}else if (img == "googlenexus" || (img == "mobiledevice" && os == "android")) { //No I18N
		no_of_paths = paths.get("android");
		icon_class = "android_uk"; //No I18N
	} 
	else if (img == "mobiledevice") { //No I18N
		no_of_paths = paths.get("mobile");
		icon_class = "mobile_uk"; //No I18N
	} 
	
	element.addClass("deviceicon-"+ icon_class);
	
	for(var i = 1; i <= no_of_paths; i++){
		var path = document.createElement('span');
		path.classList.add('path'+i); //No I18n
		element.append(path);
	}
			
}

