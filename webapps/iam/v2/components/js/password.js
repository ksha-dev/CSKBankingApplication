//$Id$
function show_resetpassword_security()// not currently used
{
	//close_security_question();
	//close_password_change();
	//close_deleteaccount()
	if($("#popup_deleteaccount_close").is(":visible")){
		$("#popup_deleteaccount_close").removeClass("pop_anim");
		$("#popup_deleteaccount_close").fadeOut(200);
		$(".blue").unbind();
	}
	else if($("#popup_password_change").is(":visible")){
		$("#popup_password_change").removeClass("pop_anim");
		$("#popup_password_change").fadeOut(200,function(){
			$("#pass_esc_devices").hide();
		});
		remove_error();
		$("#passform").trigger('reset'); 
		$("#popup_password_change a").unbind();
	}
	else if($("#popup_security_question").is(":visible")){
		$("#popup_security_question").removeClass("pop_anim");
		$("#popup_security_question").fadeOut(200,function(){
			$("#sq_answer .textbox").val("");
			$("#custom_question_input").val("");
		});
	}
	setTimeout(show_resetpassword,250);
	$("#pop_action .primary_btn_check").focus();
	closePopup(close_popupscreen,"common_popup");//No I18N
}

/***************************** password change *********************************/

function load_passworddetails(policies,password_detail)
{
	
	//font icon small is used here.....google:4 denotes , google font icon is created by using 4 span tags and same facebook:0 is denotes the no span 
	var idps_icons_obj={
			google:4,
			azure:4,
			linkedin:0,
			facebook:0,
			twitter:0,		
			yahoo:0,
			intuit:0,
			slack:5,
			douban:0,
			apple:0,
			adp:0,
			qq:8,
			wechat:0,
			weibo:5,
			baidu:0,
			feishu:3,
			github:0
	};
    var idp_name;
    var expiry_color_percentage=[10,30];
	
	if(de("password_exception"))
	{
		$("#password_exception").remove();
		$("#password_box .box_content_div").removeClass("hide");
	}
	if(password_detail.exception_occured!=undefined	&&	password_detail.exception_occured)
	{
		$( "#password_box .box_info" ).after("<div id='password_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#password_exception #reload_exception").attr("onclick","reload_exception(PASSWORD,'password_box')");
		$("#password_box .box_content_div").addClass("hide");
		return;
	}

	if(!jQuery.isEmptyObject(password_detail))
	{
		$("#password_box .box_discrption").hide();
		$("#password_box .no_data_text").hide();
		if(password_detail.isPasswordChangeBlocked!=undefined && password_detail.isPasswordChangeBlocked ){ //org blocking change password
			if(password_detail.password_exists != undefined && !password_detail.password_exists){
				$("#NO_password_def").show();
				$("#passwordbutton").html(i18nPasswordKeys["IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"]);//no i18n
			}
			else{
				$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time).show();
				$("#org_policy_password_change_blocked > .password_usecases_info").text(i18nPasswordKeys["IAM.PASSWORD.ORG.RESTRICTION.HAVING.PASSWORD"]);//no i18n
			}
			
			$("#org_policy_password_change_blocked").show().children(".idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_medium");
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).prop("disabled","true");
			$("#password_box > .box_content_div").addClass("alert_password_sync_block");
			$("#password_head").addClass("no_bottom_border_radius");
			return false;
		}
		else if(password_detail.password_exists!=undefined && !password_detail.password_exists)
		{
			//for getting bgcolor of idp , so you can add (ex: .idp_azure) class to an element and get color of it and removeclass after you got 
			if(password_detail.idpname != undefined && password_detail.idpname.toLowerCase() != "zoho" && password_detail.idpname !=""){
				var color;
				var duplicateObj={};
				var idpContent="";
				password_detail.idpname.toLowerCase().split("/").forEach(function(idp){
					if(idp != "" && idp != null && idp != undefined){
						duplicateObj[idp] == undefined ? duplicateObj[idp]= 1 : duplicateObj[idp]++;
					}
				});
				if(Object.keys(duplicateObj).length>3){
					var element=document.createElement("div");
					$(element).addClass("more_idp_list").attr("id","more_idp");//no i18n
				}
				for(var key in duplicateObj){
					var idpElement=document.createElement("div");
					$(idpElement).addClass("idp_font_icon");
					$("#IDP_password > .password_usecases_info").before(idpElement);
					$("#IDP_password > .idp_font_icon:last").removeClass("hide").addClass("idp_"+key);
					color=$(".idp_"+key).css("background-color");
					$("#IDP_password > .idp_font_icon:last").removeClass("idp_"+key).addClass("icon-"+key+"_small").text("").css("color",color);
					for(var j=0;j<idps_icons_obj[key];j++){
						var span_element=document.createElement("span");
						$("#IDP_password > .idp_font_icon:last").append(span_element);
						span_element.className='path'+(j+1);
					}
					if(Object.keys(duplicateObj).length>3){
						var cloneNode=document.importNode($("#IDP_password > .idp_font_icon:last")[0],true);
						var div=document.createElement("div");
						div.className="more_idp_list_row";
						if(key == "adp" || key == "intuit"){
							$(div).addClass("intuitAndAdp");
						}
						if(key == "qq"){
							$(div).css("text-transform","uppercase");//no i18n
						}
						div.appendChild(cloneNode);
						var idpNameElement=document.createElement("span");
						if(key == "adp" || key == "intuit"){
							var textNode=document.createTextNode(duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : "");
						}
						else{
							if(key == "azure"){
								var textNode=document.createTextNode("microsoft" + ( duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : ""));//no i18n
							}
							else{
								var textNode=document.createTextNode(key + ( duplicateObj[key] > 1 ? " ("+duplicateObj[key]+")" : ""));
							}
						}
						idpNameElement.append(textNode);
						div.append(idpNameElement);
						$(element).append(div);
					}
						if(key == "qq"){
							key = "QQ";//no i18n
						}
						if(key == "adp"){
							key = "ADP";//no i18n
						}
						if(key == "azure"){
							idpContent+="microsoft" + ( duplicateObj[key.toLowerCase()] > 1 ? "("+duplicateObj[key.toLowerCase()]+")" : "") + ( Object.keys(duplicateObj).length > 1 && Object.keys(duplicateObj)[Object.keys(duplicateObj).length-1] != key ? ", " : "") ;//no i18n
						}
						else{
							idpContent+=key + ( duplicateObj[key.toLowerCase()] > 1 ? "("+duplicateObj[key.toLowerCase()]+")" : "") + ( Object.keys(duplicateObj).length > 1 && Object.keys(duplicateObj)[Object.keys(duplicateObj).length-1] != key ? ", " : "") ;
						}	
					}
					if(Object.keys(duplicateObj).length>3){
						for(var i=0;i<Object.keys(duplicateObj).length-3;i++){
							$("#IDP_password > .idp_font_icon:last").remove();
						}
						$("#IDP_password > .idp_font_icon:last").removeClass().html("").text('+'+(Object.keys(duplicateObj).length-2)).addClass("number_idp").css("color","rgb(0,0,0,0.5)").append(element);
						var linked_account_element=document.createElement("div");
						linked_account_element.className="linked_accounts";
						$("#IDP_password .more_idp_list").append(linked_account_element).css({"top":"30px","left":"-30px"});//no i18n
						$("#IDP_password .linked_accounts").text(i18nPasswordKeys["IAM.PROFILE.LINKED.ACCOUNT.SETTINGS"]).attr("onclick",'document.getElementById("linkedaccounts").click();');//no i18n
						var span=document.createElement("span");
						span.className="icon-rightarrow";
						linked_account_element.append(span);
					}
					$("#no_pp").hide();
					$("#NO_password_def").show();
					$("#password_box > .box_content_div").show().addClass("alert_password_idp");
					$("#IDP_password .password_usecases_info").html(formatMessage(i18nPasswordKeys["IAM.PASSWORD.IDPUSER.DESC"],idpContent));//no i18n
					$("#IDP_password").show();
					$("#passwordbutton").html(i18nPasswordKeys["IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"]).attr('onclick','goToForgotPwd()'); //No I18N
					$(".password_usecases_content .idp_font_icon").addClass("idp");
					$("#password_head").addClass("no_bottom_border_radius");
			}
			else{
				$("#no_pp").hide();
				$("#NO_password_def").show();		
				$("#password_head").addClass("no_bottom_border_radius");
				$("#passwordbutton").html(i18nPasswordKeys["IAM.NEW.SIGNIN.PASSWORD.EXPIRED.SET"]).attr('onclick','goToForgotPwd()'); //No I18N
			}			
		}
		else if(password_detail.isZohoBlocked!=undefined && password_detail.isZohoBlocked) //org user using saml authentication and not super admin
		{
			$("#contact_superadmin_def").show();
			$("#contact_superadmin_msg").show();
			$("#contact_superadmin_msg > .idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_medium");
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).prop("disabled","true");
			$("#password_box > .box_content_div").addClass("alert_password_sync_block");
			$("#password_head").addClass("no_bottom_border_radius");
		}
		else if(security_data.Password.PasswordPolicy.password_age_remaining!=undefined	&&	security_data.Password.PasswordPolicy.password_age_warning!=undefined)
		{
			$("#passwordbutton.primary_btn_check").addClass("no_after_before");
			$("#passwordbutton").css({"background-color":"#EBEBEB","color":"#ADADAD"}).removeAttr("onclick");
			$("#tip_password_reset").html(security_data.Password.PasswordPolicy.password_age_warning);
			$("#password_head").addClass("no_bottom_border_radius");
			$("#passwordbutton").hover(function(){
				$("#tip_password_reset").addClass("password_reset_hover");
			},function(){
				$("#tip_password_reset").removeClass("password_reset_hover");
			});
			
			if(password_detail.PasswordInfo.last_changed_time_millis!=-1)
			{
				$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time);
			}
			else
			{
				$("#no_pp").text(password_last_changed);
			}
			$("#no_pp").show();
			password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies)
		}
		else
		{
			password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies);
			$("#passwordbutton").attr("onclick", "show_password_change_popup()");
			
		}
		if(password_detail.PasswordPolicy!=undefined)
		{
			$("#newPassword").attr("onkeyup","check_pp("+password_detail.PasswordPolicy.mixed_case+","+password_detail.PasswordPolicy.min_spl_chars+","+password_detail.PasswordPolicy.min_numeric_chars+","+password_detail.PasswordPolicy.min_length+")");
			$("#change_password_call").attr("onclick","changepassword(document.passform,"+password_detail.PasswordPolicy.min_length+","+password_detail.PasswordPolicy.max_length+",'"+security_data.Password.login_name+"')");
		}	
	}
}

function password_expiration(idps_icons_obj,idp_name,expiry_color_percentage,password_detail,policies){
	$("#previous_modified_time").show();
	$("#password_def").hide();
	if(password_detail.PasswordInfo.last_changed_time_millis!=-1)
	{
		$("#no_pp").text(password_last_changed+" "+password_detail.PasswordInfo.last_changed_time);
	}
	else
	{
		$("#no_pp").text(password_never_changed);
	}
	
	if(password_detail.PasswordPolicy!=undefined	&&	 (password_detail.PasswordPolicy.expiry_days!=undefined	&& 	password_detail.PasswordPolicy.expiry_days!=-1 && password_detail.PasswordInfo.days_remaining!=undefined)	)
	{
		var str = null;
		if(password_detail.PasswordInfo.days_remaining > 0){
			if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[0]/100))){
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.ATTENTION"]);//No I18N
			}
			else if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[1]/100))){
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.MEDIUM"]);//No I18N
			}
			else{
				$("#password_expiration .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.CHANGE.NORMAL"]);//No I18N
			}
			str =$("#password_expiration").html();
			str=formatMessage(str,password_detail.PasswordInfo.org_name,(password_detail.PasswordPolicy.expiry_days).toString(),(password_detail.PasswordInfo.days_remaining).toString());
			$("#password_expiration").html(str);
			
			//password expiration attention status color
			if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[0]/100))){
				password_expiry_alerts_variation("high","medium","normal");	//No I18N
			}
			else if(password_detail.PasswordInfo.days_remaining < (password_detail.PasswordPolicy.expiry_days*(expiry_color_percentage[1]/100))){
				password_expiry_alerts_variation("medium","high","normal");	//No I18N
			}
			else{
				password_expiry_alerts_variation("normal","medium","high"); //No I18N
			}
			$("#password_expiration > .idp_font_icon").addClass("icon-warningfill");
			$("#password_head").addClass("no_bottom_border_radius");
			$("#password_expiration").show();
		} else {
			$("#password_expired .password_usecases_info").html(i18nPasswordKeys["IAM.PASSWORD.EXPIRED"]);//No I18N
			str = $("#password_expired").html();
			str=formatMessage(str,password_detail.PasswordInfo.org_name,(password_detail.PasswordPolicy.expiry_days),(password_detail.PasswordInfo.days_remaining));
			$("#password_expired").html(str).addClass("password_alert_high_attention").show();
			$("#password_expired > .idp_font_icon").addClass("icon-warningfill").addClass("alert_icon_high");
			$("#password_expired span").addClass("alert_days_high");
			$("#password_expiration").removeClass("password_alert_medium_attention").removeClass("password_alert_normal_attention");
			$("#password_expiration > .idp_font_icon").removeClass("alert_icon_medium").removeClass("alert_icon_normal");
			$("#password_expiration  span").removeClass("alert_days_medium").removeClass("alert_days_normal");
			$("#password_head").addClass("no_bottom_border_radius");
		}
	}
	$("#no_pp").show();
}

function password_expiry_alerts_variation(){
	$("#password_expiration").addClass("password_alert_"+arguments[0]+"_attention");				
	$("#password_expiration > .idp_font_icon").addClass("alert_icon_"+arguments[0]);
	$("#password_expiration  span").addClass("alert_days_"+arguments[0]);
	//removing classes needs when change color without reloading pages(when it happens : user change password)
	$("#password_expiration").removeClass("password_alert_"+arguments[1]+"_attention").removeClass("password_alert_"+arguments[2]+"_attention");
	$("#password_expiration > .idp_font_icon").removeClass("alert_icon_"+arguments[1]).removeClass("alert_icon_"+arguments[2]);
	$("#password_expiration  span").removeClass("alert_days_"+arguments[1]).removeClass("alert_days_"+arguments[2]);
}

function check_pp(cases,spl,num,minlen) {
	validatePasswordPolicy().validate('#new_password input'); //No i18N
}

function show_password_change_popup()
{
	$("#popup_password_change").show(0,function(){
		validatePasswordPolicy().init('#new_password input');//No I18N
		$("#popup_password_change").addClass("pop_anim");
	});
	$("#popup_password_change .popuphead_details .popuphead_text").html($("#change_password_desc .heading").html());
	$("#popup_password_change .popuphead_define").html($("#change_password_desc .description").html());
	$("#passform").show();
	$("#pass_esc_devices").hide();
	popup_blurHandler('6');
	control_Enter("#popup_password_change a");//No i18N
	$("#passform .field input").attr("type","password");
	$("#passform .pass_icon").removeClass("icon-show").addClass("icon-hide");
	$("#popup_password_change input:first").focus();
	closePopup(close_password_change,"popup_password_change");//No I18N
}

function togglePass(ele){
	if($(ele).siblings("input").attr("type")=="password"){
		$(ele).siblings("input").attr("type","text");//No I18N
		$(ele).addClass("icon-show").removeClass("icon-hide");
	}	
	else{
		$(ele).siblings("input").attr("type","password"); //No I18N
		$(ele).removeClass("icon-show").addClass("icon-hide");
	}
}

function close_password_change()
{
	popupBlurHide('#popup_password_change',function(){ //No I18N
		$("#pass_esc_devices").hide();
		if($(".oneAuthLable").is(":visible")){
			$(".oneAuthLable").slideUp();
		}
		$("#terminate_mob_apps").removeClass("displayBorder");
		$("#terminate_session_weband_mobile_desc").show();
	});
	remove_error();
	$("#passform").trigger('reset'); 
	$("#popup_password_change a").unbind();
}

function changepassword(f,min_Len,max_Len,login_name) 
{
	remove_error();
    var currentpass = f.currentPass.value.trim();
    var newpass = f.newPassword.value.trim();
    var confirmpass = f.cpwd.value.trim();
    var passwordErr = validatePasswordPolicy().getErrorMsg(newpass);
    if(isEmpty(currentpass)) 
    {
    	$('#curr_password').append( '<div class="field_error">'+err_enter_currpass+'</div>' );
    	f.currentPass.value="";
    	f.currentPass.focus();
    } else 
    if(isEmpty(newpass)) 
    {
    	$('#new_password').append( '<div class="field_error">'+err_enter_newpass+'</div>' );
        f.newPassword.value="";
        f.cpwd.value="";
        f.newPassword.focus();
    } else 
	if(passwordErr) 
    {
        f.newPassword.focus();
    } else 
    if(newpass == login_name) 
    {
    	$('#new_password').append( '<div class="field_error">'+err_loginName_same+'</div>' );
    	f.newPassword.focus();
    } else 
    if(isEmpty(confirmpass) || newpass != confirmpass) 
    {
    	$('#new_repeat_password').append( '<div class="field_error">'+err_wrong_pass+'</div>' );
        f.cpwd.value="";
        f.cpwd.focus();
    }
    else if(validateForm(f))
    {
    		disabledButton(f);
    		var parms=
    		{
    			"currpwd":$('#'+f.id).find('input[name="currentPass"]').val(),//No I18N
    			"pwd":$('#'+f.id).find('input[name="newPassword"]').val(),//No I18N
    			"incpwddata":true //No I18N
    		};


    		var payload = Password.create(parms);
    		payload.PUT("self","self").then(function(resp)	//No I18N
    		{
    			SuccessMsg(getErrorMessage(resp));
    			//change the modified time
				security_data.Password.PasswordInfo.last_changed_time=resp.password.last_changed_time;
				$("#ter_mob").removeClass("show_oneauth");
				if(security_data.Password.PasswordInfo.org_name!==undefined)
    			{
    				security_data.Password.PasswordInfo.org_name=resp.password.org_name;
    				security_data.Password.PasswordInfo.days_remaining=resp.password.days_remaining;
    			}
				load_passworddetails(security_data.Policies,security_data.Password);
				if(resp.password.sess_term_tokens!=undefined &&	resp.password.sess_term_tokens.length>0)
				{
					if(resp.password.sess_term_tokens.indexOf("rmwebses")==-1)
					{
						$("#terminate_web_sess").hide();
					}
					if(resp.password.sess_term_tokens.indexOf("rmappses")==-1)
					{
						$("#terminate_mob_apps").hide();
					}
					else if(resp.password.sess_term_tokens.indexOf("inconeauth")==-1)
					{
						$("#ter_mob").removeClass("show_oneauth");
					}
					else
					{
						$("#ter_mob").addClass("show_oneauth");
					}
					if(resp.password.sess_term_tokens.indexOf("rmapitok")==-1)
					{
						$("#terminate_api_tok").hide();
					}
					changeToDevice();
				}
				else
				{
					close_password_change()
				}
       			removeButtonDisable(f);    
    		},
    		function(resp)
    		{
    			showErrorMessage(getErrorMessage(resp));
    			removeButtonDisable(f)
    		});	
    }

    
    return false;
    
}

function changeToDevice()
{
	$("#popup_password_change .popuphead_details .popuphead_text").html($("#quit_session_desc .heading").html());
	$("#popup_password_change .popuphead_define").html($("#quit_session_desc .description").html());
	$("#popup_password_change .checkbox_check").prop("checked",false);
	$(".showOneAuthLable").removeClass("showOneAuthLable");
	$("#passform").hide();
	$(".oneAuthLable").hide();
	$("#pass_esc_devices").show();
	if(isMobile){
		var heightForCheckBox=window.innerHeight-($("#popup_password_change .popup_header ").outerHeight(true) + $("#popup_password_change .form_description").outerHeight(true) + $("#pass_esc_devices .primary_btn_check").outerHeight(true)+parseInt($("#pass_esc_devices .primary_btn_check").css("margin-top").replace("px",''))+parseInt($(".change_pass_cont.popup_padding").css("padding-Top").replace("px",''))+parseInt($("#change_second").css("margin-top").replace("px",'')));
		var tem=0;
		if($("#popup_password_change").innerHeight() <= window.innerHeight){
			tem=heightForCheckBox-$("#change_second").innerHeight();
		}
		$("#change_second").css("overflow","auto");
		$("#change_second").css("height",heightForCheckBox-tem+"px");
	}
}

function signout_devices(f,callback)
{
	var terminate_web=$("#terminate_web_sess").is(":visible")	&&	$('#'+f.id).find('input[name="clear_web"]').is(":checked");
	var terminate_mob=$("#terminate_mob_apps").is(":visible")	&&	$('#'+f.id).find('input[name="clear_mobile"]').is(":checked");
	var terminate_api=$("#terminate_api_tok").is(":visible")	&&	$('#'+f.id).find('input[name="clear_apiToken"]').is(":checked");
	var include_oneAuth=$(".oneAuthLable").is(":visible")	&&	$('#'+f.id).find('#include_oneauth').is(":checked");
	if(terminate_mob||terminate_web||terminate_api)
	{	
		if(validateForm(f))
	    {
				disabledButton(f);
	    		var parms=
	    		{
	    			"rmwebses":terminate_web,//No I18N
	    			"rmappses":terminate_mob,//No I18N
	    			"inconeauth":include_oneAuth,//No I18N
	    			"rmapitok":terminate_api//No I18N
	    		};
	
	
	    		var payload = SessionTerminateObj.create(parms);
	    		payload.PUT("self","self").then(function(resp)	//No I18N
	    		{
	    			SuccessMsg(getErrorMessage(resp));
	    			callback==undefined?close_password_change():callback();
	    			removeButtonDisable(f)
	    		},
	    		function(resp)
	    		{
	    			showErrorMessage(getErrorMessage(resp));
	    			removeButtonDisable(f);
	    		});	
	    }
	}
	else
	{
		callback==undefined?close_password_change():callback();
	}
	return false;
	
}
/***************************** Geo-fencing *********************************/
function load_geofencing_data(geofencing_data){
	if(geofencing_data.exception_occured!=undefined	&&	geofencing_data.exception_occured){
		$( "#geofencing_box #geofencing_exception" ).remove();
		$( "#geofencing_box .header_for_no_data" ).after("<div id='geofencing_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#geofencing_box #reload_exception").attr("onclick","reload_exception(GEOLOCATION,'geofencing_box')");
		$("#geofencing_box #set_geofencing,#geofencing_stored_data,#empty_geofencing,#usecase_abt_geofencing").hide();
		return;
	}
	if(geofencing_data.length == 0){
		$("#geofencing_box .header_for_no_data,#empty_geofencing").show();
		$("#geofencing_stored_data,#usecase_abt_geofencing").hide();
		$("#geofencing_box").css("padding-bottom","30px");
	}
	else{
		geofencing_data = geofencing_data[0];
		$("#geofencing_box #empty_geofencing,#geofencing_box .header_for_no_data,#geofencing_stored_data .info_tag").hide();
		$("#geofencing_stored_data,#usecase_abt_geofencing").show();
		$("#geofencing_box").css("padding","0px");
		if(geofencing_data.allowedClients.indexOf("0") != -1){
			$("#geofencing_stored_data .blue_tag").show();
		}
		if(geofencing_data.allowedClients.indexOf("1") != -1){
			$("#geofencing_stored_data .organge_tag").show();
		}
		$("#geofencing_stored_data #modified_time").text(formatMessage(i18nGeofencingkeys["IAM.LAST.CHANGED"],geofencing_data.created_time));//No I18N
		var country_list = geofencing_data.country;
		$("#usecase_abt_geofencing .flag_list,#usecase_abt_geofencing .country_list").html("");
		var country_names = "";
		country_list.forEach(function(val,count){
			country_names = country_names + $("#country_list_for_geo_fencing").find("#"+val).text() + ", ";
			if(count<2){
				var flagElement=document.createElement("div");
				flagElement.className="flag_container flag_name_"+val;			//No I18N
				$("#usecase_abt_geofencing .flag_list").append(flagElement);
				addFlagIcon($("#usecase_abt_geofencing .flag_name_"+val),val);
			}
			else{
				$("#usecase_abt_geofencing .overflow_count").show();
			}
			renderExtraCoutries(val);
		});
		country_names = country_names.slice(0, -2);
		if(geofencing_data.location_type == "1"){
			$(".head_for_country_action .allowed").show();
			$("#usecase_abt_geofencing .flag_list").addClass("geofencing_enabled").removeClass("geofencing_restricted");
			$(".head_for_country_action .restricted").hide();
			if(country_list.length>3){
				$("#usecase_abt_geofencing .usecases_info").html(formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE"],country_list.length));  //No I18N
			}
			else{
				$("#usecase_abt_geofencing .usecases_info").html(formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.ALLOWED.USECASE.INFO.WITH.COUNTRY"],country_names));		//No I18N
			}			
		}
		else{
			$("#usecase_abt_geofencing .flag_list").addClass("geofencing_restricted").removeClass("geofencing_enabled");
			$(".head_for_country_action .allowed").hide();
			$(".head_for_country_action .restricted").show();
			if(country_list.length<2){
				$("#usecase_abt_geofencing .usecases_info").html(formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY"],country_names));		//No I18N
			}
			else{
				$("#usecase_abt_geofencing .usecases_info").html(formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.RESTRICTED.USECASE.INFO.WITH.COUNTRY.MORE.THAN.THREE"],country_list.length));  //No I18N
			}
		}
		$("#usecase_abt_geofencing .plus_count").text("+"+(country_list.length-2));		//No I18N
	}
}
function renderExtraCoutries(val){
	var elementForFlagCont=document.createElement("div");
	elementForFlagCont.className="country_with_flag country_"+val;		//No I18N
	$("#usecase_abt_geofencing .country_list").append(elementForFlagCont);
	
	var elementForFlag=document.createElement("div");
	elementForFlag.className="flag_container flag_name_"+val;		//No I18N
	$("#usecase_abt_geofencing .country_"+val).append(elementForFlag);
	addFlagIcon($("#usecase_abt_geofencing .flag_name_"+val),val);
	
	var elementForName=document.createElement("div");
	elementForName.innerText = $("#country_list_for_geo_fencing").find("#"+val).text();
	elementForName.className="country_container country_name_"+val;		//No I18N
	$("#usecase_abt_geofencing .country_"+val).append(elementForName);
}
function go_next_to_enableGeofencing(){
	remove_error();
	var selected_country = $("#country_list_for_geo_fencing").val();
	if(selected_country.length == 0){
		$("#country_field_cont").append( '<div class="field_error">'+i18nGeofencingkeys["IAM.GEOFENCING.ERROR.SELECT.COUNTRY"]+'</div>' );
		return false;
	}
	if(document.geofencing_form.geo_fencing_value.value == ""){
		$(".option_for_geo_fencing").append( '<div class="field_error">'+i18nGeofencingkeys["IAM.GEOFENCING.ERROR.SELECT.ALLOW"]+'</div>' );
		return false;
	}

	var current_country_name = $("#country_list_for_geo_fencing").find("#"+curr_country.toLowerCase()).text();
	if(parseInt(document.geofencing_form.geo_fencing_value.value) && selected_country.indexOf(curr_country.toLowerCase()) == -1){
		$("#country_field_cont").append( '<div class="field_error">'+formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.ALLOWED.LIST.ERROR"],current_country_name)+'</div>' );
		$("#country_field_cont .field_error .blue_link").attr("onclick","handleCurCountry(true)");
		return false;
	}
	if(!parseInt(document.geofencing_form.geo_fencing_value.value) && selected_country.indexOf(curr_country.toLowerCase()) != -1){
		$("#country_field_cont").append( '<div class="field_error">'+formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.CURRENT.COUNTRY.NOT.IN.RESTRICTED.LIST.ERROR"],current_country_name)+'</div>' );
		$("#country_field_cont .field_error .blue_link").attr("onclick","handleCurCountry(false)");
		return false;
	}	
	if(parseInt(document.geofencing_form.geo_fencing_value.value)){
		$(".allowed_header").show();
		$(".restricted_header").hide();
	}else{
		$(".allowed_header").hide();
		$(".restricted_header").show();
	}
	$("#get_geofencing_data,#geofencing_desc_msg").hide();
	$("#show_selected_view").show();
	
}
function handleCurCountry(addCountry){
	remove_error();
	var country_list = $("#country_list_for_geo_fencing").val();
	if(addCountry){		
		country_list.push(curr_country.toLowerCase());
	}else{
		country_list.indexOf(curr_country.toLowerCase()) != -1 ? country_list.splice(country_list.indexOf(curr_country.toLowerCase()), 1) : "";
	}
	$("#country_list_for_geo_fencing").val(country_list);
	$("#country_list_for_geo_fencing").uvselect({
		"country-flag" : true, //no i18n
		"onDropdown:select" : function(){	 //no i18n
			setSelectWidth();
			setValueInSelectedList();
			uvselect.placeSelectOptionContainer("country_list_for_geo_fencing");	//no i18n
		},	
		"onDropdown:remove"	: function(){	//no i18n
			setSelectWidth();
			setValueInSelectedList();
		},
		"onDropdown:open" : function(){	//no i18n
			$(".country_list_for_geo_fencing .multiselect_search_input").hide();
			$(".country_list_for_geo_fencing.selectbox_options_container .select_search_input").focus();
			$(".country_list_for_geo_fencing.selectbox_options_container .select_search_input").focusout(function(){
				setSelectWidth();
			});
		}
	});
	$(".country_list_for_geo_fencing .select_search_input").attr("placeholder",i18nGeofencingkeys["IAM.CHOOSE.COUNTRIES"]);
	setValueInSelectedList();
	setSelectWidth();
}

function enableGeofencing(){
	remove_error();
	if(!document.geofencing_form.browser_session.checked && !document.geofencing_form.pop_imap.checked){
		$("#applicable_types").append( '<div class="field_error">'+i18nGeofencingkeys["IAM.ERROR.FIELD.SELECT.LEAST"]+'</div>' );
		return false;
	}
	var allowed_clients = [];
	$(".applicable_types .checkbox_check:checked").each(function(ind,ele){
		allowed_clients.push(parseInt(ele.value));
	});
	var location_info = [];
	$("#country_list_for_geo_fencing").val().forEach(function(val){
		location_info.push({"country" : val.toUpperCase()});
	});
	var parms=
	{
			"location_info" : location_info,									//No I18N
			"location_type" : document.geofencing_form.geo_fencing_value.value,	//No I18N
			"allowed_clients" : allowed_clients									//No I18N
	};

	disabledButton("#show_selected_view");
	var payload = GeoFencing.create(parms);
	payload.POST("self","self").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		removeButtonDisable("#show_selected_view"); 	//No I18N
		closeGeoFencingAddPopup();
		security_data.GeoLocations=[];
		security_data.GeoLocations[0]={}
		security_data.GeoLocations[0].location_type =  document.geofencing_form.geo_fencing_value.value;
		security_data.GeoLocations[0].allowedClients = allowed_clients.toString();
		security_data.GeoLocations[0].country = $("#country_list_for_geo_fencing").val();
		security_data.GeoLocations[0].created_time = i18nGeofencingkeys["IAM.SETTINGS.AUTHORIZED.SECONDS.AGO"];
		load_geofencing_data(security_data.GeoLocations);
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
		removeButtonDisable("#show_selected_view"); 	//No I18N
	});	
}
function go_back_to_choose_country(){
	$(".show_selected_value .blue_link,#show_selected_view").hide();
	$(".country_listing_container").removeClass("show_full_list")
	$("#get_geofencing_data,#geofencing_desc_msg").show();
}
function showGeoFencingPopup(edit_mode){
	$("#popup_geofencing").show(0,function(){
		$("#popup_geofencing").addClass("pop_anim");
	});
	popup_blurHandler('6');
	go_back_to_choose_country();
	$("#geo_fencing_delete").hide();
	resetForm(edit_mode);
	if(edit_mode){
		var goe_location_data = security_data.GeoLocations[0];
		if(goe_location_data.location_type == "1"){
			$("#get_geofencing_data #allow_access").prop("checked",true);
		}
		else{
			$("#get_geofencing_data #restrict_access").prop("checked",true);
		}
		$("#show_selected_view .checkbox_check").prop("checked",false);
		if(goe_location_data.allowedClients.indexOf("1") != "-1"){
			$("#show_selected_view #pop_imap").prop("checked",true);
		}
		if(goe_location_data.allowedClients.indexOf("0") != "-1"){
			$("#show_selected_view #geo_browser_session").prop("checked",true);
		}
		$("#geo_fencing_delete").show();
		setSelectWidth();
		setValueInSelectedList();
	}
	closePopup(closeGeoFencingAddPopup,"popup_geofencing");//No I18N
	$("#popup_geofencing").focus();
}
function resetForm(edit_mode){
	remove_error();
	$("#country_list_for_geo_fencing").val(edit_mode ? security_data.GeoLocations[0].country : "");
	$("#country_list_for_geo_fencing").uvselect({
		"country-flag" : true, //no i18n
		"onDropdown:select" : function(){	 //no i18n
			setSelectWidth();
			setValueInSelectedList();
			uvselect.placeSelectOptionContainer("country_list_for_geo_fencing");	//no i18n
		},	
		"onDropdown:remove"	: function(){	//no i18n
			setSelectWidth();
			setValueInSelectedList();
		},
		"onDropdown:open" : function(){	//no i18n
			$(".country_list_for_geo_fencing .multiselect_search_input").hide();
			$(".country_list_for_geo_fencing.selectbox_options_container .select_search_input").focus();
			$(".country_list_for_geo_fencing.selectbox_options_container .select_search_input").focusout(function(){
				setSelectWidth();
			});
		}
	});
	$(".country_list_for_geo_fencing .select_search_input").attr("placeholder",i18nGeofencingkeys["IAM.CHOOSE.COUNTRIES"]);
	$(document.geofencing_form.geo_fencing_value).prop("checked",false);
	setValueInSelectedList();
	$("#geofencing_form .checkbox_check").prop("checked",false);
	$("#geofencing_form #geo_browser_session").prop("checked",true);
}
function deleteGeoFencing(){
	new URI(GeoFencing,"self","self").DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				closeGeoFencingAddPopup();
				security_data.GeoLocations=[];
				load_geofencing_data(security_data.GeoLocations);

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

function setValueInSelectedList(){
	$("#popup_geofencing .country_listing_container").html("");
	var country_list = $("#country_list_for_geo_fencing").val();
	country_list.forEach(function(flag_code){
		var country_name = $("#country_list_for_geo_fencing").find("#"+flag_code).text();
		$("#popup_geofencing .country_listing_container").append("<div class='selected_countries'><span class='flag_container flag-"+flag_code+"'></span><span class='country_name'>"+country_name+"</span></div>");
		addFlagIcon($(".country_listing_container .flag-"+flag_code),flag_code);
	});
	if(country_list.length > 9){
		$(".show_selected_value .blue_link").text(formatMessage(i18nGeofencingkeys["IAM.GEOFENCING.SELECTED.COUNTED"],country_list.length - 9)).css("display","inline-block");	//no i18n
	}
}
function setSelectWidth(){
	var selectedCardLength = $(".country_list_for_geo_fencing .multiselect_input .option_card").length;
	
	if(selectedCardLength > 0){
		$(".country_list_for_geo_fencing .multiselect_search_input").hide();
	}
	else{
		$(".country_list_for_geo_fencing .multiselect_search_input").show();
	}
	if(selectedCardLength > 2){
		$(".select_container.country_list_for_geo_fencing").css("width","100%");
	}
	else{
		$(".select_container.country_list_for_geo_fencing").css("width","300px");
	}
	var dropdown_width = $(".select_container.country_list_for_geo_fencing").width()+"px";		//No I18N
	$(".selectbox_options_container.country_list_for_geo_fencing").css({"width":dropdown_width,"min-width":dropdown_width});
	$(".country_list_for_geo_fencing.selectbox_options_container .select_search_input").focus();
}
function closeGeoFencingAddPopup(){
	popupBlurHide("#popup_geofencing"); //No I18N
}

/***************************** Allowed IPs *********************************/

function createIpSplitField(identifier){
	splitField.createElement(identifier,{
			"isIpAddress": true,		// No I18N
			"separator":"&#xB7;",			// No I18N
			"separateBetween" : 1,		// No I18N
			"customClass" : "ip_address_field"	// No I18N
		});
}

function getIpFieldFullValue(id){
	id = id.replace("#","");
	return $("#"+id+"_full_value").val(); // No I18N
}

function gen_random_num(){
	var pre_random = undefined;
	do{
		var ran = Math.floor(Math.random() * (10));
		pre_random=ran;
	}
	while(ran!=pre_random)
	return ran;
}

function load_IPdetails(policies,IP_details)
{
	if(de("allowedIP_exception"))
	{
		$("#allowedIP_exception").remove();
		$("#AllowedIP_box #all_ip_show").removeClass("hide");
	}
	if(IP_details.exception_occured!=undefined	&&	IP_details.exception_occured)
	{
		$( "#AllowedIP_box .box_info" ).after("<div id='allowedIP_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#allowedIP_exception #reload_exception").attr("onclick","reload_exception(AllowedIP,'AllowedIP_box')");
		$("#AllowedIP_box #all_ip_show").addClass("hide");
		return;
	}
	var orgIPRestrict = IP_details.isUserIPRestrictionDisabled ? true: false;
	//var index = from_IP.indexOf("remote_ip");
	var count=0;
//	if(from_IP.length>1)
//	{
	if(!jQuery.isEmptyObject(IP_details.IPs))
	{
		//var from_IPs=timeSorting(IP_details.IPs);
		var ip_names=timeSorting(IP_details.IPs);
		if(orgIPRestrict){
			$(".iprestrict_msg").text(i18nIPkeys["IAM.ORG.IP.RESTRICT.EXIST.WARN"]); //no i18n
			$("#org_iprest_warn").show();
		}
		$("#no_ip_add_here").hide();
		$("#IP_content").show();
		var is_ip_within_range = ip_within_range(IP_details.IPs, IP_details.remote_ip);
		
		/*var iplist = [];
		for (var key in IP_details.IPs) {
		  if (IP_details.IPs.hasOwnProperty(key)) {
		    var val = IP_details.IPs[key];
		    for(var ip in val.ips){
		    	iplist.push(ip[0]);
		    }
		  }
		}*/
		
		if(is_ip_within_range)
		{
			$("#current_ip").hide();
			$("#allowed_ip_entry0").hide();
		}
		else
		{
			
			$("#current_ip").show();
			//$("#current_ip .ip_blue").html(IP_details.remote_ip);
			$("#show_current_ip .cur_ip_value").html(IP_details.remote_ip);
			
			$("#cur_ip").val(IP_details.remote_ip);
			
			//warning msg that the current ip is not allowed
			if(!is_ip_within_range && !orgIPRestrict) {
			$("#allowed_ip_entry0").show();
			$("#IP_content .alone_current_ip").html(formatMessage("<div class='note_ip'>"+note+" </div><div class='ip_note_desc'>"+current_to_wanrning+"</div>",IP_details.remote_ip));
			$("#allowed_ip_entry0").attr("onclick","show_session_type([['"+IP_details.remote_ip+"']],"+true+",0);");
			$("#allowed_ip_entry0 #ip_range_forNAME").html(IP_details.remote_ip);
			$("#allowed_ip_info0").attr("onclick","show_session_type([['"+IP_details.remote_ip+"']],"+true+",0);");
			} else {
				$("#allowed_ip_entry0").hide();
			}
			
		}
//		if (index > -1) 
//		{
//			from_IP.splice(index, 1);
//		}
		$("#IPdisplay_others").html("");
		
		for(iter=0;iter<Object.keys(IP_details.IPs).length;iter++)
		{
			count++;
			var display_name=ip_names[iter];
			if(isIP(display_name)){
				display_name = i18nIPkeys["IAM.ALLOWEDIP.UNAMED"];
			}
			var current_IP_name=IP_details.IPs[ip_names[iter]];
			
			
			IPdisplay_format = $("#empty_ip_format").html();
			$("#IPdisplay_others").append(IPdisplay_format);
			
			$("#IPdisplay_others #allowed_ip_entry").attr("id","allowed_ip_entry"+count);
			$("#IPdisplay_others #allowed_ip_info").attr("id","allowed_ip_info"+count);
			//$("#IPdisplay_others #allowed_ip_info_rename").attr("id","allowed_ip_info_rename"+count);
			
			$("#allowed_ip_entry"+count).attr("onclick","show_selected_ip_info("+count+");");
			
			$("#allowed_ip_entry"+count+" .ip_edit").attr("onclick","edit_selected_ip("+count+", event);");
		      
			if(count > 3)
			{
				$("#allowed_ip_entry"+count).addClass("allowed_ip_entry_hidden");  
			}

			$("#allowed_ip_entry"+count+" .range_name").html(display_name);
			$("#allowed_ip_entry"+count+" #range_name").html(display_name);
			
			
			if(current_IP_name.allowed_clients.includes(0) || current_IP_name.allowed_clients.includes("{}")){
				$("#allowed_ip_entry"+count+" .browser_session").show();
			}
			if(current_IP_name.allowed_clients.includes(1)){
				$("#allowed_ip_entry"+count+" .imap_session").show();
			}
			
			
			//$("#allowed_ip_entry"+count+" .device_time").html(current_from_IP.created_time_elapsed);	
			
			//$("#allowed_ip_entry"+count+" #ip_pencil").attr("onclick","show_get_name('"+current_from_IP.from_ip+"','"+current_from_IP.to_ip+"',true,"+count+");");
			if(orgIPRestrict){
				$("#allowed_ip_entry"+count+" .device_pic").addClass("dp_disabled");
			}else{
				$("#allowed_ip_entry"+count+" .device_pic").addClass(color_classes[gen_random_value()]);
			}
			$("#allowed_ip_entry"+count+" .device_pic").html(display_name.substr(0,2).toUpperCase());
			
			$("#allowed_ip_info"+count+" #pop_up_ip_name").html(display_name);
			$("#allowed_ip_info"+count+" #pop_up_time").html(current_IP_name.created_date);
			if(current_IP_name.ips[0][0]==current_IP_name.ips[0][1]||current_IP_name.ips[0][1]==undefined)//Static IP check
			{
				//$("#allowed_ip_entry"+count+" .IP_tab_info").html(current_from_IP.from_ip);
				var iplist = "";
				for(var x in current_IP_name.ips){
					iplist+=(current_IP_name.ips[x][0]);
					iplist+="<br>"
				}
				$("#allowed_ip_entry"+count+" .device_ip").html(current_IP_name.ips[0][0]);
				$("#allowed_ip_info"+count+" .static").html(iplist);
				$("#allowed_ip_info"+count+" .range").hide();
				$("#allowed_ip_info"+count+" .static").show();
				iplist = iplist.replaceAll("<br>",",");
				$("#allowed_ip_info"+count+" #current_session_logout").attr("onclick","deleteip('"+iplist+"','"+display_name+"')");
			}
			else
			{
				var iplist = "";
				for(var x in current_IP_name.ips){
					iplist+= current_IP_name.ips[x][0]+" - "+current_IP_name.ips[x][1];
					iplist+="<br>"
				}
				
				$("#allowed_ip_entry"+count+" .device_ip").html(current_IP_name.ips[0][0]+" - "+current_IP_name.ips[0][1]);
				$("#allowed_ip_info"+count+" .range").html(iplist);
				$("#allowed_ip_info"+count+" .range").show();
				$("#allowed_ip_info"+count+" .static").hide();
				iplist = iplist.split("<br>");
				iplist.pop();
				for(var x in iplist){
					iplist[x] = iplist[x].split(" - ")[0]; // only from IP needed for delete call
				}
				
				$("#allowed_ip_info"+count+" #current_session_logout").attr("onclick","deleteip('"+iplist+"','"+display_name+"')");
			}			
			
			
			var applicable_to_text = "";
			var x = false;
			if(current_IP_name.allowed_clients.includes(0) || current_IP_name.allowed_clients.includes("{}")){					
				applicable_to_text = i18nIPkeys["IAM.ALLOWEDIP.SESSION.BROWSER"];
				x = true;
			}
			if(current_IP_name.allowed_clients.includes(1)){
				if(x) {applicable_to_text += " and "};
				applicable_to_text += i18nIPkeys["IAM.ALLOWEDIP.SESSION.IMAP"];					
			}
			
			$("#allowed_ip_info"+count+" #session_type_info").html(applicable_to_text);
			$("#allowed_ip_info"+count+" #session_info").show();
			
						
			
			//$("#allowed_ip_entry"+count+" .session_type_info").html(current_from_IP.from_ip);
			
			
			if(current_IP_name.location!=undefined)
			{
				$("#allowed_ip_entry"+count+" .asession_location").removeClass("location_unavail");
				$("#allowed_ip_entry"+count+" .asession_location").text(current_IP_name.location.toLowerCase());
				$("#allowed_ip_info"+count+" #pop_up_location").removeClass("unavail");
				$("#allowed_ip_info"+count+" #pop_up_location").text(current_IP_name.location.toLowerCase());
			}
			//$("#allowed_ip_info"+count+" #current_session_logout").attr("onclick","deleteip('"+current_IP_name.ips[0][0]+"','"+current_IP_name.ips[0][1]+"')");
			
		}	 
		if(count<4)//less THAN 3
		{
			if(orgIPRestrict){
				$("#ip_justaddmore").hide();
			}else{
				$("#ip_justaddmore").show();
			}
			$("#IP_add_view_more").hide();
		}
		else
		{
			if(count>4){
				$("#IP_add_view_more .view_more").html(formatMessage(i18nIPkeys["IAM.VIEWMORE.IPs"],count-3)); //NO I18N
			} else {
				$("#IP_add_view_more .view_more").html(formatMessage(i18nIPkeys["IAM.VIEWMORE.IP"],count-3)); //NO I18N
			}
			if(orgIPRestrict){
				$("#IP_add_view_more .addnew").hide();
			}
			$("#ip_justaddmore").hide();
			$("#IP_add_view_more").show();
		}
	}
	else
	{
		if(orgIPRestrict){
			$(".no_ip").addClass("iprestrict_no_ip");
			$("#allowedip_change").hide();
			$(".iprestrict_msg").text(i18nIPkeys["IAM.ORG.IP.RESTRICT.EMPTY.WARN"]); //No i18n
			$("#org_iprest_warn").show();
		} else {
			$("#current_ip").show();
			//$("#current_ip .ip_blue").html(IP_details.remote_ip);
			$("#show_current_ip .cur_ip_value").html(IP_details.remote_ip);
			$("#cur_ip").val(IP_details.remote_ip);
		}
		$("#ip_justaddmore").hide();
		$("#IP_add_view_more").hide();
		$("#no_ip_add_here").show();
		$("#IP_content").hide();
		
	}
}


function ip_within_range(all_ips_details, remote_ip) {
	var valid_ips = 0;
	var is_browser_session = false;
	var ip_names = timeSorting(all_ips_details);
	for(iter=0;iter<Object.keys(all_ips_details).length;iter++)
	{
		var ip = all_ips_details[ip_names[iter]];
		if(ip.allowed_clients.includes("0")){
			is_browser_session = true;
			var iplist = all_ips_details[ip_names[iter]].ips;
		
			for(var x in iplist){
				var from_IP = iplist[x][0];
				var to_IP = iplist[x][1];
				if (ipRangeTest(remote_ip, from_IP, to_IP) ) { valid_ips += 1 };
			}
		}
		
		//var from_IP = all_ips_details[ip_names[iter]].from_ip;   
		//var to_IP = all_ips_details[from_IPs[iter]].to_ip;
		//if (ipRangeTest(remote_ip, from_IP, to_IP) ) { valid_ips += 1 };
	}
	return (!is_browser_session || (valid_ips > 0));
}

function ip_To_Num(ip) {
   var ip_as_num=0;
   var ip_arr=ip.split('.');
   for(var i=0; i < 4; i++){
	   ip_as_num = (ip_as_num *256) + parseInt(ip_arr[i], 10);  // to convert ip to a number
   }
   return ip_as_num;
}

function ipRangeTest(remote_ip, from_ip, to_ip) {
	  if(to_ip == undefined){
	    return ipRangeTest(remote_ip, from_ip, from_ip);
	  }
	  var startip=ip_To_Num(from_ip);
	  var endip=ip_To_Num(to_ip);
	  var testip=ip_To_Num(remote_ip);
	  return ((testip <= endip) && (testip >= startip)) ? true : false;
}

function show_selected_ip_info(id)
{	
	if(!$(popup_ip_new).is(":visible")){
		$("#allowed_ip_pop .device_pic").addClass($("#allowed_ip_entry"+id+" .device_pic")[0].className);
		$("#allowed_ip_pop .device_pic").html($("#allowed_ip_entry"+id+" .device_pic").html());
		$("#allowed_ip_pop .device_name").html($("#allowed_ip_entry"+id+" .device_name").html()); //load into popuop
		$("#allowed_ip_pop #edit_ip_name").attr("onclick",$("#allowed_ip_entry"+id+" #ip_pencil").attr("onclick"));
		$("#allowed_ip_pop .device_ip").html($("#allowed_ip_entry"+id+" .device_ip").html()); //load into popuop
		
		$("#allowed_ip_pop #ip_current_info").html($("#allowed_ip_info"+id).html()); //load into popuop
		
		
		popup_blurHandler('6');
		$("#allowed_ip_pop").show(0,function(){
			$("#allowed_ip_pop").addClass("pop_anim");
		});
		control_Enter("a"); ///No I18N
		$("#current_session_logout").focus();
		closePopup(closeview_selected_ip_view,"allowed_ip_pop"); //No I18N
	}
		
}

function edit_selected_ip(id, ev) {	
	ev.stopPropagation();
	remove_error();
	//closeview_all_ip_view();
	//closePopup(closeview_all_ip_view,"allow_ip_web_more");//No I18N
	if(!$(popup_ip_new).is(":visible")){
		/*$("#allowed_ip_pop .device_pic").addClass($("#allowed_ip_entry"+id+" .device_pic")[0].className);
		$("#allowed_ip_pop .device_pic").html($("#allowed_ip_entry"+id+" .device_pic").html());
		$("#allowed_ip_pop .device_name").html($("#allowed_ip_entry"+id+" .device_name").html()); //load into popuop
		$("#allowed_ip_pop #edit_ip_name").attr("onclick",$("#allowed_ip_entry"+id+" #ip_pencil").attr("onclick"));
		$("#allowed_ip_pop .device_ip").html($("#allowed_ip_entry"+id+" .device_ip").html()); //load into popuop
		
		$("#allowed_ip_pop #ip_current_info").html($("#allowed_ip_info"+id).html()); //load into popuop
		
		*/
		var display_name = $("#allowed_ip_entry"+id+" .device_name").text().trim();
		if(display_name == i18nIPkeys["IAM.ALLOWEDIP.UNAMED"]){ // No I18N
			display_name = '';
		} else {
			$("#edit_allowed_ip_pop #ip_name_edit").css({"opacity":"0.6", "pointer-events" : "none"});
		}
		$("#edit_allowed_ip_pop #ip_name_edit").val(display_name); //load into popuop
		
		
    	
    	if($("#allowed_ip_info"+id+" .static").text() != ''){
			$("#edit_range_ip").hide();
			$("#edit_static_ip").show();
			var static_ip_list = $("#allowed_ip_info"+id+" .static").html().split("<br>");
			static_ip_list.pop();
			
			var count = 0;
			$("#edit_static_ip .static_ip_container").children(':not(:last-child)').remove(); // clear old fields
			var static_clone = $("#edit_static_ip_field").clone().attr('id', 'edit_static_ip_field_'+count);
			static_clone.addClass("ip_field_div");
			$("#edit_static_ip .add_more_static_ip").before(static_clone);
			
			createIpSplitField('edit_static_ip_field_0'); // No I18N
			
			for(var index in static_ip_list){
				splitField.setValue('edit_static_ip_field_'+count, static_ip_list[index]); // No I18N
				if(index != (static_ip_list.length-1)){
					add_more_ip('edit_'); // No I18N
				}				
				splitField.disableSplitField("#edit_static_ip_field_"+count); //No I18n
				count++;
			}			
			
		} else if ($("#allowed_ip_info"+id+" .range").text() != '') {
			$("#edit_static_ip").hide();
			$("#edit_range_ip").show();
			
			var range_ip_list = $("#allowed_ip_info"+id+" .range").html().split("<br>");
			range_ip_list.pop();
			
			var count = 0;
			$("#edit_range_ip .range_ip_container").children(':not(:first-child) :not(:last-child)').remove(); // clear old fields
			
			var range_clone = $("#edit_range_container").clone().attr('id', 'edit_range_container_0');
			range_clone.addClass("range_field_div");
			range_clone.find("#edit_from_ip_field").attr('id', 'edit_from_ip_field_0'); // No I18N
			range_clone.find("#edit_to_ip_field").attr('id', 'edit_to_ip_field_0');	// No I18N
			
			$("#edit_range_ip .add_more_ip_range").before(range_clone);
			
			
			createIpSplitField('edit_from_ip_field_0'); // No I18N
			createIpSplitField('edit_to_ip_field_0'); // No I18N
			
			for(var index in range_ip_list){
				var ip_vals = range_ip_list[index].split(" - "); // From IP is 0th position and to IP is 1st position
				splitField.setValue('edit_from_ip_field_'+count, ip_vals[0]); // No I18N
				splitField.setValue('edit_to_ip_field_'+count, ip_vals[1]); // No I18N
				if(index != (range_ip_list.length-1)){
					add_more_ip_range('edit_'); // No I18N
				}
				splitField.disableSplitField("#edit_from_ip_field_"+count); //No I18n
				splitField.disableSplitField("#edit_to_ip_field_"+count); //No I18n		
				count++;
			}	
		}
		
		$("#editipform").attr("onsubmit","save_edited_ip(this,'"+id+"');return false;");
    	
    	//$("#allowed_ip_info"+id+" .static").html(iplist);
    	
    	popupBlurHide('#allow_ip_web_more',undefined,true); //No I18N 
		
		$("#edit_allowed_ip_pop").show(0,function(){
			$("#edit_allowed_ip_pop").addClass("pop_anim");
			popup_blurHandler('6');
		});
		control_Enter("a"); ///No I18N
		$("#save_edited_button").focus();
				
		closePopup(close_edit_ip_popup,"edit_allowed_ip_pop");//No I18N
		
	}
	
}

function closeview_selected_ip_view()
{
	popupBlurHide("#allowed_ip_pop"); //No I18N
	$("#allowed_ip_pop #edit_ip_name").attr("onclick","");
	$("#allowed_ip_pop a").unbind();
}

function closeview_all_ip_view(callback)
{
	popupBlurHide('#allow_ip_web_more',function(){ //No I18N
		$("#view_all_allow_ip").html("");
		if(callback)
		{
			callback();
		}
		
	});
	$(".aw_info a").unbind();
}

function show_all_ip()
{

	$("#view_all_allow_ip").html($("#all_ip_show").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_allow_ip .allowed_ip_entry_hidden").show();
	$("#view_all_allow_ip .authweb_entry").after( "<br />" );
	$("#view_all_allow_ip .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_allow_ip .allowed_ip_entry").removeAttr("onclick");
	if($("#view_all_allow_ip #allowed_ip_info0").length==1) 
	{ 
		$("#view_all_allow_ip #allowed_ip_info0").removeAttr("onclick"); 
		$("#view_all_allow_ip #allowed_ip_info0 #add_current_ip").attr("onclick","add_current_ip()"); 
		
	}
	
	$("#view_all_allow_ip .info_tab").show();

	//$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .ip_pencil").hide();
	
	$("#allow_ip_web_more").show(0,function(){
		$("#allow_ip_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_allow_ip .allowed_ip_entry").click(function(event){
		
		var id=$(this).attr('id');
		if($(event.target).hasClass("action_icon")){
			return;
		}

		if(id=="allowed_ip_entry0")
		{ 	
			if($("#view_all_allow_ip #"+id).hasClass("Active_ip_showall_hover"))
			{ 
				return; 
			} 
			
			show_session_type([[security_data.AllowedIPs.remote_ip]],true,0);
			return;
		}
	
		$("#view_all_allow_ip .allowed_ip_entry").addClass("autoheight");
		$("#view_all_allow_ip .aw_info").slideUp("fast");
		$("#view_all_allow_ip .activesession_entry_info").show();
		if($("#view_all_allow_ip #"+id).hasClass("Active_ip_showall_hover"))
		{

				$("#view_all_allow_ip #"+id+" .aw_info").slideUp("fast",function(){
					$("#view_all_allow_ip #"+id).removeClass("Active_ip_showall_hover");
					$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
				});
				$("#view_all_allow_ip .activesession_entry_info").show();
		}
		else
		{
			
			$("#view_all_allow_ip .allowed_ip_entry").removeClass("Active_ip_showall_hover");
			$("#view_all_allow_ip #"+id).addClass("Active_ip_showall_hover");
			$("#view_all_allow_ip .aw_info").slideUp(300);
			$("#view_all_allow_ip #"+id+" .aw_info").slideDown("fast",function(){

				control_Enter(".aw_info a"); //No I18N
				$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
				
			});
			$("#view_all_allow_ip #"+id+" .activesession_entry_info").hide();
		}

	});
	closePopup(closeview_all_ip_view,"allow_ip_web_more");//No I18N
	
	$("#allow_ip_web_more").focus();	
}





function add_new_ip_popup()
{

	document.addip.reset();
	remove_error();
	remove_error_border('.ip_field_div'); //No I18n
	
	$("#popup_ip_new").show(0,function(){
		$("#popup_ip_new").addClass("pop_anim");
		
		if(window.matchMedia('(max-width: 500px)').matches){
			$("#popup_ip_new #ip_new_info").css({"max-height":'calc( 100vh - 300px)'}); // 200px for top and bottom amrgin and 130px for heading and warning
			$("#popup_ip_new").css({"top":'0px'});
		} else {
			$("#popup_ip_new #ip_new_info").css({"max-height":'calc( 100vh - 350px)'}); // 200px for top and bottom amrgin and 130px for heading and warning
			if(window.innerHeight < 750){ //Maximum pop height 600px + margin-top 100px
				$("#popup_ip_new").css({"top":'10px'});
				$("#popup_ip_new #ip_new_info").css({"max-height":'calc( 100vh - 190px)'}); // 20px for top and bottom amrgin and 130px for heading and warning
				$("#popup_ip_new .static_ip_container").css({"max-height":'calc( 100vh - 540px)'});
				$("#popup_ip_new .range_ip_container").css({"max-height":'calc( 100vh - 540px)'});
			}
		}
		
		$("#popup_ip_new .static_ip_container").css({"max-height":'calc( 100vh - 650px)'});
		$("#popup_ip_new .range_ip_container").css({"max-height":'calc( 100vh - 650px)'});
		
		
		
		if($("#current_ip").css("display")=="none"){
			$('#static_ip_sel').prop("checked", true);
			
			$("[id^=static_ip_field_]").not('#static_ip_field_0').remove();
			$('.remove_static_ip').next("br").remove();
			$('.remove_static_ip').remove();
			createIpSplitField('static_ip_field_0'); // No I18N
	    	
	    	$("#static_ip_field_0 .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
			$("#range_ip").hide();
			$("#show_current_ip").hide();
			$("#static_ip").show();	
			$("#static_ip_field_0 .splitedText:first").focus();
		}
		else{
			$("#current_ip").css("display","flex");
			$('#current_ip_sel').prop("checked", true);
			$("#show_current_ip").show();
			$("#range_ip").hide();
			$("#static_ip").hide();	
			$("#popup_ip_new .real_radiobtn:first").focus();
		}
	});
	$("#ip_name_bak").show();
	$("#get_ip").show();
	$("#get_ip #ip_name").focus();
	$("#session_type").hide();
	popup_blurHandler('6');
	$("#ip_name_bak").show();
	$("#add_new_ip").show();
	$("#add_name_old_ip").hide();
	$("#back_name_old_ip").hide();
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
	registerOnchange();

	closePopup(close_new_ip_popup,"popup_ip_new");//No I18N
}

function registerOnchange(){
	$('input[name=ip_select]').change(function () {
        var val=$(this).val();
        remove_error();
        remove_error_border('.ip_field_div'); //No I18n
        if(val=="1")
        {
        	$("#static_ip").slideUp(300);
        	$("#range_ip").slideUp(300);
        	$("#show_current_ip").slideDown(300);
        }
        else if(val=="2")
        {
			$("[id^=static_ip_field_]").not('#static_ip_field_0').remove();
			$('.remove_static_ip').next("br").remove();
			$('.remove_static_ip').remove();
			createIpSplitField('static_ip_field_0'); // No I18N
        	
        	$("#static_ip_field_0 .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
        	$("#static_ip").slideDown(300);
        	$("#range_ip").slideUp(300);
        	$("#show_current_ip").slideUp(300);
        	$("#static_ip_field_0 .splitedText:first").focus();
        }
        else
        {
			$("[id^=range_container_]").not('#range_container_0').remove();
			$('.remove_range_ip').next("br").remove();
			$('.remove_range_ip').remove();			
			createIpSplitField('from_ip_field_0'); // No I18N
			createIpSplitField('to_ip_field_0'); // No I18N
        	
        	$("#from_ip_field_0 .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
        	$("#to_ip_field_0 .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
        	$("#static_ip").slideUp(300);
        	$("#show_current_ip").slideUp(300);
        	$("#range_ip").slideDown(300);////for inline block
        	$("#from_ip_field_0 .splitedText:first").focus();
        }
    });
	
}

function edit_new_ip(){
	$("#session_type").hide();
	$(".ip_impt_note").hide();
	$("#get_ip").show();
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
}

function add_more_ip(edit_id){
	if(edit_id == undefined){
		edit_id = '';
	}
	
	var count = $("#"+edit_id+"static_ip .ip_field_div").length;
	
	var static_ip_field = document.createElement('div');
	static_ip_field.id = edit_id+"static_ip_field_" + count;
	static_ip_field.classList.add('ip_field_div'); //No I18n
	
	static_ip_field.style.marginTop = '20px';  //No I18n
	//static_ip_field.style.marginTop = '20px';
	var prev_field = document.getElementById(edit_id+'static_ip_field_'+ (count-1));
	//prev_field.setAttribute('style', 'display:flex !important');	
		
	prev_field.after(static_ip_field);
	prev_field.after(document.createElement('br'));
	
	var remove_ip_icon = document.createElement('div');
	remove_ip_icon.classList.add('remove_static_ip','add-circle','close-circle'); //No I18n
	remove_ip_icon.setAttribute("id", edit_id+"remove_static_ip_" + (count-1));
	remove_ip_icon.setAttribute("onclick", "remove_static_field(" + (count-1) + ",'"+edit_id+"');");
		/*var cross_icon = document.createElement('span');
		  cross_icon.classList.add('icon-Plus','remove_ip_icon'); //No I18n
		
		  remove_ip_icon.append(cross_icon);*/
		
	prev_field.after(remove_ip_icon);
	
	
	splitField.createElement(edit_id+'static_ip_field_'+count,{
		"isIpAddress": true,		// No I18N
		"separator":"&#xB7;",			// No I18N
		"separateBetween" : 1,		// No I18N
		"customClass" : "ip_address_field"	// No I18N
	});
     
    $("#"+edit_id+"static_ip_field_"+count+" .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
    $("#"+edit_id+"static_ip_field_"+count+" .splitedText:first").focus();
    count++;
	
}

function remove_static_field(id, edit_id){
	if(edit_id == undefined){
		edit_id = '';
	}
	$("#"+edit_id+"static_ip_field_" + id).remove();
	$("#"+edit_id+"remove_static_ip_" + id).next().remove();
	$("#"+edit_id+"remove_static_ip_" + id).remove();
	
	for(var i = id; i < $("#"+edit_id+"static_ip .ip_field_div").length; i++){
		var old_val = getIpFieldFullValue(edit_id+"static_ip_field_" + (i+1)); // No I18N
		$("#"+edit_id+"static_ip_field_" + (i+1)).attr('id', edit_id+"static_ip_field_" + i); // No I18N	
		createIpSplitField(edit_id+'static_ip_field_'+i); // No I18N
		splitField.setValue(edit_id+'static_ip_field_'+i, old_val); // No I18N
		if(edit_id != ''){
			if(old_val != '' && isIPAlreadyExist([[old_val]]) != 'false'){
				splitField.disableSplitField("#"+edit_id+'static_ip_field_'+i); //No I18n
			}
		}
		
		$("#"+edit_id+"remove_static_ip_" + (i+1)).attr('onclick', "remove_static_field(" + i + ",'"+edit_id+"');"); // No I18N
		$("#"+edit_id+"remove_static_ip_" + (i+1)).attr('id', edit_id+"remove_static_ip_" + i); // No I18N
	}
	if(id == 0){
		$("#"+edit_id+"static_ip_field_0")[0].style.marginTop = '0px';
	}
		
}

function add_more_ip_range(edit_id){
	if(edit_id == undefined){
		edit_id = '';
	}
	var count = $("#"+edit_id+"range_ip .range_field_div").length;
	
	var range_container_clone = $("#"+edit_id+"range_container_0").clone().attr('id', edit_id+'range_container_'+count);
	range_container_clone.addClass("range_field_div");
	
	range_container_clone.find("#"+edit_id+"from_ip_field_0").removeClass("force_errorborder");
	range_container_clone.find("#"+edit_id+"from_ip_field_0").css({"pointer-events": "unset", "cursor": "unset"});
	range_container_clone.find("#"+edit_id+"from_ip_field_0").attr('id', edit_id+'from_ip_field_'+count); // No I18N
	range_container_clone.find("#"+edit_id+"to_ip_field_0").removeClass("force_errorborder");
	range_container_clone.find("#"+edit_id+"to_ip_field_0").css({"pointer-events": "unset", "cursor": "unset"});
	range_container_clone.find("#"+edit_id+"to_ip_field_0").attr('id', edit_id+'to_ip_field_'+count);	// No I18N
		
	
	//range_container_clone.show();
	range_container_clone[0].style.marginTop = '20px';
	
	var prev_container = document.getElementById(edit_id+'range_container_'+ (count-1));
	prev_container.after(range_container_clone[0]);	
	prev_container.after(document.createElement('br'));
	
	var remove_ip_icon = document.createElement('div');
	remove_ip_icon.classList.add('remove_range_ip','add-circle','close-circle'); //No I18n
	remove_ip_icon.setAttribute("id", edit_id+"remove_range_ip_" + (count-1));
	remove_ip_icon.setAttribute("onclick", "remove_range_field(" + (count-1) + ", '"+edit_id+"');");
		/*var cross_icon = document.createElement('span');
		  cross_icon.classList.add('icon-Plus','remove_ip_icon'); //No I18n
		
		  remove_ip_icon.append(cross_icon);*/
		
	prev_container.after(remove_ip_icon);
	
	
	splitField.createElement(edit_id+'from_ip_field_'+count,{
		"isIpAddress": true,		// No I18N
		"separator":"&#xB7;",			// No I18N
		"separateBetween" : 1,		// No I18N
		"customClass" : "ip_address_field"	// No I18N
	});
	splitField.createElement(edit_id+'to_ip_field_'+count,{
		"isIpAddress": true,		// No I18N
		"separator":"&#xB7;",			// No I18N
		"separateBetween" : 1,		// No I18N
		"customClass" : "ip_address_field"	// No I18N
	});	
			
	$("#"+edit_id+"from_ip_field_"+count+" .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
	$("#"+edit_id+"to_ip_field_"+count+" .splitedText").attr("onkeypress","remove_error();remove_error_border(this.parentElement);");
	
	$("#"+edit_id+"from_ip_field_"+count+" .splitedText:first").focus();	
	
	count++;
		
}

function remove_range_field(id, edit_id){
	if(edit_id == undefined){
		edit_id = '';
	}
	$("#"+edit_id+"range_container_" + id).remove();
	$("#"+edit_id+"remove_range_ip_" + id).next().remove();
	$("#"+edit_id+"remove_range_ip_" + id).remove();
	
	for(var i = id; i < $("#"+edit_id+"range_ip .range_field_div").length; i++){
				
		var old_from_val = getIpFieldFullValue(edit_id+"from_ip_field_" + (i+1)); // No I18N
		var old_to_val = getIpFieldFullValue(edit_id+"to_ip_field_" + (i+1)); // No I18N
		
		$("#"+edit_id+"from_ip_field_" + (i+1)).attr('id', edit_id+"from_ip_field_" + i); // No I18N
		$("#"+edit_id+"to_ip_field_" + (i+1)).attr('id', edit_id+"to_ip_field_" + i); // No I18N
		$("#"+edit_id+"range_container_" + (i+1)).attr('id', edit_id+"range_container_" + i); // No I18N
		
		createIpSplitField(edit_id+"from_ip_field_" + i); // No I18N
		createIpSplitField(edit_id+"to_ip_field_" + i); // No I18N
		splitField.setValue(edit_id+"from_ip_field_" + i, old_from_val); // No I18N
		splitField.setValue(edit_id+"to_ip_field_" + i, old_to_val); // No I18N
		
		if(edit_id != ''){
			if(old_from_val != '' && isIPAlreadyExist([[old_from_val]]) != 'false'){
				splitField.disableSplitField("#"+edit_id+'from_ip_field_'+i); //No I18n
				splitField.disableSplitField("#"+edit_id+'to_ip_field_'+i); //No I18n
			}
		}
		
		$("#"+edit_id+"remove_range_ip_" + (i+1)).attr('onclick', "remove_range_field(" + i + ",'"+edit_id+"');"); // No I18N
		$("#"+edit_id+"remove_range_ip_" + (i+1)).attr('id', edit_id+"remove_range_ip_" + i); // No I18N
	}
	
	if(id == 0){
		$("#"+edit_id+"range_container_0")[0].style.marginTop = '0px';
	}
		
}

function isNumberKey(evt)
{
	remove_error();
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
    {
    	return false;
    }
    return true;
}


function close_new_ip_popup()
{
	popupBlurHide('#popup_ip_new',function(){ //No I18N
		closeview_selected_ip_view();
	});
	
	$( ".ip_field_cell").unbind( "keyup" );

	$("#ip_name_bak").show();
	$("#add_new_ip").show();
	
	$("#add_name_old_ip").hide();
	$("#back_name_old_ip").hide();
	
	$("#get_ip").show();
	$("#session_type").hide();
	
	$(".ip_impt_note").hide();
}

function close_edit_ip_popup()
{
	popupBlurHide('#edit_allowed_ip_pop',function(){ //No I18N
		closeview_selected_ip_view();
	});
	
	$( ".ip_field_cell").unbind( "keyup" );

	$("#ip_name_bak").show();
	$("#add_new_ip").show();
	
	$("#add_name_old_ip").hide();
	$("#back_name_old_ip").hide();
	
	$("#get_ip").show();
	$("#session_type").hide();
	
	$(".ip_impt_note").hide();
}

function checkIfArrayIsPresent(iplist, ip){
	return iplist.some(function(subArray) {
	 	return JSON.stringify(subArray) === JSON.stringify(ip)
	});
}

function addipaddress(f)
{
	var iplist = [];
	remove_error();
	remove_error_border('.ip_field_div'); //No I18n
	
	var ip_name = $("#ip_name").val().trim();
	
	if(ip_name == undefined || ip_name == '')
	{
		$('#ip_name_container').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.IPNAME.EMPTY"]+'</div>' );
    	$('#ip_name_container #ip_name').focus();
    	return false;
	}
	else if(security_data.AllowedIPs.IPs && ip_name in security_data.AllowedIPs.IPs){
		$('#ip_name_container').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.IPNAME.ALREADY.EXISTS"]+'</div>' );
    	$('#ip_name_container #ip_name').focus();
    	return false;
	}
	
	var val= f.ip_select.value.trim();
	var fip;
    var tip;
    
	if(val==1)
	{
		fip=tip=f.cur_ip.value.trim();
		iplist.push([fip]);
	}
	else if(val==2)
	{
		var count = $("#static_ip .ip_field_div").length;
		for(let i=0; i<count; i++){
			fip=tip=$("#static_ip_field_"+ i +"_full_value").val();
			tip=tip.trim();
			fip=fip.trim();
			if(fip == '' && i != count-1){
				remove_static_field(i,'');
				i--;
				count--;
			} else if(fip != '') {
				var isPresent = checkIfArrayIsPresent(iplist, [fip]);
				if(!isPresent){
					iplist.push([fip]);
				}				
			}
		}
	}
	else if(val==3)
	{
		var count = $("#range_ip .range_field_div").length;
		for(let i=0; i<count; i++){
			fip=$("#from_ip_field_"+ i +"_full_value").val();
			tip=$("#to_ip_field_"+ i +"_full_value").val();
			tip=tip.trim();
			fip=fip.trim();

			
			if(fip == '' && tip == '' && i != count-1){
				remove_range_field(i,'');
				i--;
				count--;
			} else if(!(fip == '' && tip == '')){
				var isPresent = checkIfArrayIsPresent(iplist, [fip, tip]);
				if(!isPresent){
					iplist.push([fip, tip]);
				}	
			}			
		}
		
	}
	
    if(iplist.length === 0)
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		$('#static_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.STATIC.EMPTY"]+'</div>' );
    		$('#static_ip .splitedText:first').focus();
    	}
    	else
    	{
    		$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.STATIC.EMPTY"]+'<br /></div>' );
    		$('#from_ip_field_0 .splitedText:first').focus();
    	}
    }
    else if((failed_ip = isIPList(iplist)) != true) 
    {
    	if($('input[name=ip_select]:checked').val()=="2")
    	{
    		$('#static_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID"]+'</div>' );
    		
    		failed_ip = failed_ip.split(',')[0];
    	    		
    		$('#static_ip_field_'+failed_ip).addClass('force_errorborder');
    		$('#static_ip_field_'+failed_ip+' .splitedText:first').focus();
    	}
    	else
    	{
    		failed_ip = failed_ip.split(',');
    		var ip_field_id;
    		if(failed_ip[1] == 0){
				ip_field_id = 'from_ip_field_'+failed_ip[0];
				if(iplist[failed_ip[0]][0] == ''){
					$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY"]+'<br /></div>' );
				} else {		
					$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.FROMIP.NOTVALID"]+'<br /></div>' );
				}
			} else {
				ip_field_id = 'to_ip_field_'+failed_ip[0];
				if(iplist[failed_ip[0]][1] == ''){
					$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.TOIP.ERROR.EMPTY"]+'<br /></div>' );
				} else {
					$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.TOIP.NOT_VALID"]+'<br /></div>' );
				}
			}
			
    		$('#range_container_'+failed_ip[0]+' #'+ip_field_id+' .splitedText:first').focus();
    		$('#range_container_'+failed_ip[0]+' #'+ip_field_id).addClass('force_errorborder');
    	}
    } else if((failed_ip = isIPAlreadyExist(iplist)) != 'false'){
		if($('input[name=ip_select]:checked').val()=="2")
    	{
			$('#static_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.STATICIP.ALREADY.EXIST"]+'</div>' );
    		
    		//failed_ip = failed_ip.split(',')[0];
    	    		
    		$('#static_ip_field_'+failed_ip).addClass('force_errorborder');
    		$('#static_ip_field_'+failed_ip+' .splitedText:first').focus();
    		
		} else {
			var	ip_field_id = 'from_ip_field_'+failed_ip; //No I18n
			$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.RANGEIP.ALREADY.EXIST"]+'<br /></div>' );
			
    		$('#range_container_'+failed_ip+' #'+ip_field_id+' .splitedText:first').focus();
    		$('#range_container_'+failed_ip+' #'+ip_field_id).addClass('force_errorborder');
		}
	} else if($('input[name=ip_select]:checked').val()=="3" && (failed_ip = isIPinProperRange(iplist)) != 'true'){
		var	ip_field_id = 'from_ip_field_'+failed_ip; //No I18n
		$('#range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.ERROR.NOT.IN.RANGE"]+'<br /></div>' );
		
		$('#range_container_'+failed_ip+' #'+ip_field_id+' .splitedText:first').focus();
		$('#range_container_'+failed_ip+' #'+ip_field_id).addClass('force_errorborder');
	}
   /* else if(isEmpty(tip) || !isIP(tip))  //invalid To ip address
    {
		$('#range_ip').append( '<div class="field_error field_error_right">'+err_enter_ip+'<br /></div>' );
		$('#to_ip_field .splitedText:first').focus();

    }*/
    else 
    {
    	show_session_type(iplist,false);
    	
    }
    closePopup(close_new_ip_popup,"popup_ip_new",true);//No I18N

    //$("#ip_name").focus();
    return false;
}

function isIPinProperRange(iplist){
	for(var x in iplist){
		
	    const ip1Parts = iplist[x][0].split('.');
	    const ip2Parts = iplist[x][1].split('.');
	
	    for (let i = 0; i < 4; i++) {
	        const part1 = parseInt(ip1Parts[i], 10);
	        const part2 = parseInt(ip2Parts[i], 10);
	
	        if (part1 > part2) {
	            return x; // ip1 is less than ip2
	        } else if (part1 < part2){
				break;
			}
	    }
		/*if(iplist[x][0] > iplist[x][1]){
			return x;
		}*/
	}
	return 'true';
}

function isIPAlreadyExist(iplist){
	for(var x in  security_data.AllowedIPs.IPs){
	    //console.log(security_data.AllowedIPs.IPs[x].ips)
	    var ips = security_data.AllowedIPs.IPs[x].ips;
	    for( var z in ips){
	        //console.log(ips[z][0])
	        
	        for(var y in iplist){
				if(iplist[y][0] == ips[z][0]){
					return y;
				}
			}
	        /*if(iplist.includes(ips[z][0])){
				return iplist.indexOf(ips[z][0]);
			}*/
	    }
	}
	return 'false';
}

function isIPList(iplist){
	for(var x in iplist){
		if(typeof iplist[x] == 'string'){
			if(!isIP(iplist[x])){
				return false;	
			}
		} else {
			if(!isIP(iplist[x][0])){ //static IP case				
				return x+',0';
			}
			if(iplist[x][1] != undefined && (!isIP(iplist[x][1]))){  // IP range case			
				return x+',1';
			} 	
		}
	}
	return true;
}

function save_edited_ip(f, id){	
	remove_error();
	if(validateForm(f))
    {
		var ip_name = f.ip_name_edit.value.trim();
	
		var old_ip_data = security_data.AllowedIPs.IPs[ip_name];
				
		var count;
		var edited_iplist = [];
		var existing_iplist=[];
		var isRange = false;
		if($("#allowed_ip_info"+id+" .static").text() != ''){  // Static IP case
			existing_iplist = $("#allowed_ip_info"+id+" .static").html().split("<br>");
			existing_iplist.pop();
			count = $("#edit_static_ip .ip_field_div").length;
			
			for(let i=0; i<count; i++){
				var full_val =$("#edit_static_ip_field_"+ i +"_full_value").val().trim();		
				edited_iplist.push(full_val);
			}
			
		} else if($("#allowed_ip_info"+id+" .range").text() != ''){  // IP range case
			isRange = true;
			existing_iplist = $("#allowed_ip_info"+id+" .range").html().split("<br>");
			existing_iplist.pop();
			
			//for(var index in existing_iplist){
			//	existing_iplist[index] = existing_iplist[index].split(" - ")[0]; //getting only from ip value
			//}
			
			count = $("#edit_range_ip .range_field_div").length;
			
			for(let i=0; i<count; i++){
				var from_val =$("#edit_from_ip_field_"+ i +"_full_value").val().trim();
				var to_val =$("#edit_to_ip_field_"+ i +"_full_value").val().trim();
				edited_iplist.push(from_val +" - " + to_val);
			}
		}
		
		edited_iplist = edited_iplist.filter(function(element) {
		    return element !== ' - ' && element.trim() !== '';
		});
		
		var edited_iplist_array = [];
		for(var k in edited_iplist){
			edited_iplist_array.push(edited_iplist[k].split(' - '));
		}
		
		if(ip_name == undefined || ip_name == '')
		{
			$('#edit_ip_name_container').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.IPNAME.EMPTY"]+'</div>' );
	    	$('#edit_ip_name_container #ip_name_edit').focus();
	    	return;
		}
	    else if(edited_iplist.length === 0)
	    {
	    	if($("#allowed_ip_info"+id+" .static").text() != '')  // Static IP case
	    	{
	    		$('#edit_static_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.STATIC.EMPTY"]+'</div>' );
	    		$('#edit_static_ip .splitedText:first').focus();
	    	}
	    	else
	    	{
	    		$('#edit_range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.FROMIP.ERROR.EMPTY"]+'<br /></div>' );  
	    		$('#edit_from_ip_field_0 .splitedText:first').focus();
	    	}
	    	return;
	    }
	    else if(isIPList(edited_iplist_array) != true) 
	    {
	    	if($("#allowed_ip_info"+id+" .static").text() != '')
	    	{
	    		$('#edit_static_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID"]+'</div>' );
	    		$('#edit_static_ip .splitedText:last').focus();
	    	}
	    	else
	    	{
	    		$('#edit_range_ip').append( '<div class="field_error">'+i18nIPkeys["IAM.ALLOWEDIP.ERROR.FROM_IP_INVALID"]+'<br /></div>' );  
	    		$('#edit_from_ip_field_0 .splitedText:last').focus();
	    	}
	    	return;
	    }
		
		disabledButton(f);
		
		var deleted_iplist = existing_iplist.filter( function( el ) {
		  return edited_iplist.indexOf(el) < 0;
		});
		
		var newly_added_iplist = edited_iplist.filter( function( el ) {
		  return existing_iplist.indexOf(el) < 0;
		});
		
		if(deleted_iplist.length > 0){
			if(isRange){
				for(var x in deleted_iplist){
					deleted_iplist[x] = deleted_iplist[x].split(" - ")[0]; // only from IP needed for delete call
				}
			}
			deleted_iplist = deleted_iplist.toString();	
			deleteip(deleted_iplist, ip_name, f);
		}
		if(newly_added_iplist.length > 0){
			if(isRange){
				for(var x in newly_added_iplist){
					var temp = newly_added_iplist[x].split(" - ");
					newly_added_iplist[x] = [temp[0], temp[1]];
				}
			} else {
				for(var x in newly_added_iplist){
					newly_added_iplist[x] = [newly_added_iplist[x]];
				}
			}
			
			var session_types = []		
			if(old_ip_data.allowed_clients.includes(0) || old_ip_data.allowed_clients.includes("{}")){
				session_types.push(0); //browser session
			}
			if(old_ip_data.allowed_clients.includes(1)){
				session_types.push(1); // pop/imap session
			}
			post_ip(ip_name, newly_added_iplist, session_types, f);
		}
		if(deleted_iplist.length == 0 && newly_added_iplist.length == 0 ){
			removeButtonDisable(f);
			close_edit_ip_popup();
			SuccessMsg(i18nIPkeys["IAM.ALLOWEDIP.EDIT.NO.CHANGES.MADE"]);
		}
	}		
    return false;	
}

function show_session_type(iplist,is_directly,id)
{
//	if($("#allow_ip_web_more").is(":visible"))
//	{
//		$("#allow_ip_web_more #allowed_ip_info_rename"+id).html($("#popup_ip_new").html());
//			$("#allow_ip_web_more #allowed_ip_info_rename"+id+" .close_btn").remove();
//
//			$("#view_all_allow_ip .allowed_ip_entry").addClass("autoheight");
//			$("#view_all_allow_ip .activesession_entry_info").show();
//			var vis_check=false;
//			if($("#view_all_allow_ip .aw_info").is(":visible")){
//				vis_check=true;
//			}
//			$("#view_all_allow_ip .aw_info_rename").slideUp(300);
//			
//			if($("#view_all_allow_ip #allowed_ip_entry"+id).hasClass("Active_ip_showall_hover"))
//			{
//				if(vis_check){
//					$(".aw_info a").unbind();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info").slideUp("fast",function(){
//					//	$("#view_all_allow_ip #"+id).addClass("Active_ip_showall_hover");
//						$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideDown(300,function(){
//							$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//						});
//					});
//					$("#view_all_allow_ip .activesession_entry_info").show();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .activesession_entry_info").hide();
//				}
//				else{
//					$(".aw_info a").unbind();
//					$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideUp("fast",function(){
//						$("#view_all_allow_ip #allowed_ip_entry"+id).removeClass("Active_ip_showall_hover");
//						$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//					});
//					$("#view_all_allow_ip .activesession_entry_info").show();
//				}
//			}
//			else
//			{
//
//				$("#view_all_allow_ip .allowed_ip_entry").removeClass("Active_ip_showall_hover");
//				$("#view_all_allow_ip #allowed_ip_entry"+id).addClass("Active_ip_showall_hover");
//				$("#view_all_allow_ip .aw_info_rename").slideUp(300);
//				$("#view_all_allow_ip .aw_info").slideUp(300);
//				$("#view_all_allow_ip #allowed_ip_entry"+id+" .aw_info_rename").slideDown("fast",function(){
//					$("#view_all_allow_ip .allowed_ip_entry").removeClass("autoheight");
//				});
//				$("#view_all_allow_ip #allowed_ip_entry"+id+" .activesession_entry_info").hide();
//			}
//				
//			closePopup(closeview_all_ip_view,"allow_ip_web_more");//No i18N
//
//			$("#allowed_ip_info_rename"+id+" #get_ip").hide();
//			$("#allowed_ip_info_rename"+id+" #get_name").show();
//			if(is_directly)
//			{
//				$("#allowed_ip_info_rename"+id+" #ip_name_bak").hide();
//				$("#allowed_ip_info_rename"+id+" #back_name_old_ip").hide();
//
//				$("#allowed_ip_info_rename"+id+" #add_new_ip").hide();
//				$("#allowed_ip_info_rename"+id+" #add_name_old_ip").show();
//			}
//			else
//			{
//				$("#allowed_ip_info_rename"+id+" .ip_impt_note").show();
//			}
//			if($("#allowed_ip_pop").is(":visible"))
//			{
//				$("#allowed_ip_info_rename"+id+" #back_name_old_ip").show();
//			}
//			
//			if(fip && tip)
//			{
//				$("#fip").val(fip);
//				$("#tip").val(tip);
//				if(fip==tip)
//				{
//					$("#allowed_ip_info_rename"+id+" #ip_range_forNAME").html(fip);
//				}
//				else
//				{
//					$("#allowed_ip_info_rename"+id+" #ip_range_forNAME").html(fip+" - "+tip);
//				}
//			}
//			$("#get_name #ip_name").val($("#allowed_ip_entry"+id+" #range_name").html());
//	}
//	else
//	{
		closeview_selected_ip_view();
		$("#popup_ip_new").show(0,function(){			
			$("#popup_ip_new").addClass("pop_anim");
			$("#popup_ip_new #ip_new_info").css({"max-height":'calc( 100vh - 350px)'}); // 200px for top and bottom amrgin and 130px for heading and warning
			$("#popup_ip_new .static_ip_container").css({"max-height":'calc( 100vh - 650px)'});
			$("#popup_ip_new .range_ip_container").css({"max-height":'calc( 100vh - 650px)'});
			
			
			if(window.innerHeight < 750){ //Maximum pop height 600px + margin-top 100px
				$("#popup_ip_new").css({"top":'10px'});
				$("#popup_ip_new #ip_new_info").css({"max-height":'calc( 100vh - 190px)'}); // 20px for top and bottom amrgin and 130px for heading and warning
				$("#popup_ip_new .static_ip_container").css({"max-height":'calc( 100vh - 540px)'});
				$("#popup_ip_new .range_ip_container").css({"max-height":'calc( 100vh - 540px)'});
			}
		});

		if(is_directly)
		{
			$("#ip_name_bak").hide();
			$("#ip_name").val("Current IP");
			registerOnchange();
			$("#current_ip_sel").prop("checked", true).change();
		}
		$("#get_ip").hide();
		$("#session_type").show();
		if(security_data.AllowedIPs.hide_tpclient_ips){
			$(".session_container").hide();
		} else {
			$(".session_container").show();
			$("#browser_session").prop("checked", true);
		}	
		
		//$("#get_name").show();
//		if(is_directly)
//		{
//			$("#ip_name_bak").hide();
//			$("#back_name_old_ip").hide();
//			if(id==0)
//			{
//				$("#add_new_ip").show();
//				$("#add_name_old_ip").hide();
//			}
//			else
//			{
//				$("#add_new_ip").hide();
//				$("#add_name_old_ip").show();
//			}
//		}
//		else
//		{
			$(".ip_impt_note").show();
//		}
		if($("#allowed_ip_pop").is(":visible"))
		{
			$("#back_name_old_ip").show();
		}
		
		if(iplist.length > 0) //fip && tip
		{
			var given_ip_text = "";
			$("#given_ip_address").html("");
			iplist.forEach(function (item, index) {
			  	//$("#fip").val(fip);
				//$("#tip").val(tip);
				var fip = item[0];
				var tip = item[1];
				if(fip==tip || tip == undefined)
				{
					//$("#ip_range_forNAME").text(fip);
					//$("#given_ip_address").text(fip);
					
					//given_ip_text += fip;
					//given_ip_text += "<br>";
					
					var ip_div = document.createElement('div');//No I18N			        			       
			        ip_div.textContent = fip;
			        de("given_ip_address").append(ip_div); // No I18N
			        
			        
				}
				else
				{
					//$("#ip_range_forNAME").text(fip+" - "+tip);
					//$("#given_ip_address").text(fip+"  -  "+tip);
					//given_ip_text += (fip+"  -  "+tip);
					//given_ip_text += "<br>";
					
					var ip_div = document.createElement('div');//No I18N   
			        ip_div.textContent = fip+"    -    "+tip;
			        de("given_ip_address").append(ip_div); // No I18N
				}
			  
			});
			
			$("#iplist").data('iplist',iplist);
			
			//$("#given_ip_address").text(given_ip_text);
		}
		//$("#get_name #ip_name").val($("#allowed_ip_entry"+id+" #range_name").html());
		$(".preview_ip #given_ip_name").text($("#ip_name").val());
		
		popupBlurHide('#allow_ip_web_more',undefined,true); //No I18N 
		
		popup_blurHandler('6');
		$("#allowedipform").attr("onsubmit","return add_ip_with_name(this)");
		control_Enter("a");//No i18N
		closePopup(close_new_ip_popup,"popup_ip_new"); //No I18N
		//$("#ip_name").focus();
		return false;
//	}

}

function add_ip_with_name(form)
{
	
	if(validateForm(form))
    {
		disabledButton(form);
		//var from = $("#fip").val();
		//var to = $("#tip").val();
		var name=$("#get_ip #ip_name").val();
		var session_types = [];
		if($('#browser_session').is(":checked")){
			session_types.push(0);
		}
		if($('#imap_session').is(":checked")){
			session_types.push(1);
		}		
		
		//Default handling for browser session
		if(session_types.length == 0){
			session_types.push(0);
		}
		post_ip(name, $("#iplist").data('iplist'), session_types, form);
    }
	return false;
}

function post_ip(name, iplist, session_types, form){
	var params = {
			//"f_ip":from,//No I18N
			//"t_ip":to,//No I18N
			"ip_name":name, //No I18N
			"ips": iplist, //No I18N
			"client_apps": session_types // No I18N
		};
			
		var payload = AllowedIPObj.create(params);
		payload.POST("self","self").then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));

			if(security_data.AllowedIPs.IPs==undefined)
			{
				security_data.AllowedIPs.IPs=[];				
			} 
			if(security_data.AllowedIPs.IPs[name] == undefined){
				security_data.AllowedIPs.IPs[name]=resp.allowedip;
			} else {
				var old_ips = security_data.AllowedIPs.IPs[name].ips;
				if(old_ips == undefined || old_ips.length == 0){
					security_data.AllowedIPs.IPs[name]=resp.allowedip;
				} else {
					old_ips = old_ips.concat(iplist);
					security_data.AllowedIPs.IPs[name].ips=old_ips;
				}
			}
			
			
			
			load_IPdetails(security_data.Policies,security_data.AllowedIPs);
			
			$('#allowedipform')[0].reset();
			close_new_ip_popup();
			close_edit_ip_popup();
			
			removeButtonDisable(form);
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
			removeButtonDisable(form); 
		});	
}


function add_current_ip()
{
	var parms=
	{
			"f_ip":security_data.AllowedIPs.remote_ip,//No I18N
			"t_ip":security_data.AllowedIPs.remote_ip,//No I18N
			"ip_name":$("#view_all_allow_ip #allowed_ip_info0 #new_ip_name").val()//No I18N
	};


	var payload = AllowedIPObj.create(parms);
	payload.POST("self","self").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));

		security_data.AllowedIPs.IPs[resp.allowedip.from_ip]=resp.allowedip;
		
		load_IPdetails(security_data.Policies,security_data.AllowedIPs);
		
		$('#allowedipform')[0].reset();
		if($("#allow_ip_web_more").is(":visible")==true)
		{
			var lenn=Object.keys(security_data.AllowedIPs.IPs).length;
			if(lenn > 1){
				closeview_all_ip_view(show_all_ip);
			}
			else{
				closeview_all_ip_view();
			}
		}
		else{
			closeview_all_ip_view();
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

function deleteip(iplist,ip_name, form)
{		    
			new URI(AllowedIPObj,"self","self",iplist).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var old_data = security_data.AllowedIPs.IPs[ip_name];
				iplist = iplist.split(",");
				if(iplist[iplist.length-1] == ''){
					iplist.pop();
				}				
				for(var i in iplist){
					for(var x in old_data.ips){		
						if(old_data.ips[x][0] == iplist[i]){
							old_data.ips.splice(x, 1);
						}						
					}					
				}				
				if(old_data.ips.length == 0){
					delete security_data.AllowedIPs.IPs[ip_name];
				} else {
					security_data.AllowedIPs.IPs[ip_name] = old_data;
				}
				
				//
				load_IPdetails(security_data.Policies,security_data.AllowedIPs);
				closeview_selected_ip_view();
				close_edit_ip_popup();
				if($("#allow_ip_web_more").is(":visible")==true){
					lenn=Object.keys(security_data.AllowedIPs.IPs).length;
					if(lenn > 1)
					{
						closeview_all_ip_view(show_all_ip);
					}
					else
					{
						closeview_all_ip_view();
					}
				}
				removeButtonDisable(form);
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
				removeButtonDisable(form);
			});
}

function change_ip_only_name()
{
	var from = $("#fip").val();
	var to = $("#tip").val();
	var name=$("#get_name #ip_name").val();
	
	var parms=
	{
			"t_ip":to,//No I18N
			"ip_name":name//No I18N
	};
	var payload = AllowedIPObj.create(parms);
	payload.PUT("self","self",from).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		
		security_data.AllowedIPs.IPs.from_ip.display_name=name;
		
		load_IPdetails(security_data.Policies,security_data.AllowedIPs);
		$('#allowedipform')[0].reset();
		close_new_ip_popup();
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
		if($("#allow_ip_web_more").is(":visible")){
			closeview_all_ip_view(show_all_ip);
		}
		else{
			close_new_ip_popup();
		}
	});	
    return false;
}




function back_to_info()
{
	$("#popup_ip_new").hide();
	
}
function back_to_addip()
{
	$("#get_ip").show();
	$("#session_type").hide();
	$(".ip_impt_note").hide();
	$("#allowedipform").attr("onsubmit","return addipaddress(this)");
	return false;
}


/***************************** App Passwords *********************************/

function load_AppPasswords(Policies,AppPasswords)
{
	var isAppPwdAllowed = security_data.isAppPwdAllowed;
	if(de("App_Password_exception"))
	{
		$("#App_Password_exception").remove();
	}
	if(AppPasswords.exception_occured!=undefined	&&	AppPasswords.exception_occured)
	{
		$("#App_Password_box .box_info" ).after("<div id='App_Password_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#App_Password_exception #reload_exception").attr("onclick","reload_exception(AppPasswords,'App_Password_box')");
		return;
	}
	if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
	{
		$("#app_password_restricted").css("display", "flex");
		$("#generate_app_pass").css("display","none");
	} else {
		$("#generate_app_pass").css("display","block");
		$("#nodata_withoutTFA").hide();
		$("#nodata_withTFA").show();
	}
//	if(Policies.is_tfa_activated)
//	{
		
		
//	}
//	else
//	{
//		$("#generate_app_pass").hide();
//		$("#nodata_withoutTFA").show();
//		$("#nodata_withTFA").hide();
//	}
	
	if(!jQuery.isEmptyObject(security_data.AppPasswords))
	{
		var count=0;
		$("#no_app_passwords").hide();
		$("#display_app_passwords").show();
		$("#display_app_passwords").html("");
		var passwords=timeSorting(AppPasswords);
		for(iter=0;iter<Object.keys(passwords).length;iter++)
		{
			count++;
			var current_password=AppPasswords[passwords[iter]];
			app_password_format = $("#empty_app_pass_format").html();
			$("#display_app_passwords").append(app_password_format);
			
			$("#display_app_passwords #app_password_entry").attr("id","app_password_entry"+count);
			$("#display_app_passwords #app_password_info").attr("id","app_password_info"+count);
			
			
			$("#app_password_entry"+count).attr("onclick","show_selected_app_password_info("+count+");");
			
			if(count > 3)
			{
				$("#app_password_entry"+count).addClass("allowed_ip_entry_hidden");  
			}
			$("#app_password_entry"+count+" .device_name").html(current_password.app_name);
			$("#app_password_entry"+count+" .device_time").html(current_password.created_time_elapsed);
			$("#app_password_entry"+count+" .device_pic").addClass(color_classes[gen_random_value()]);
			if(current_password.app_name.indexOf(" ")==-1)
			{
				$("#app_password_entry"+count+" .device_pic").html(current_password.app_name.substr(0,2).toUpperCase());
			}
			else
			{
				var name=current_password.app_name.split(" ");
				$("#app_password_entry"+count+" .device_pic").html((name[0][0]+name[1][0]).toUpperCase());
			}
			if(current_password.location!=undefined)
			{
				$("#app_password_entry"+count+" .asession_location").removeClass("location_unavail");
				$("#app_password_entry"+count+" .asession_location").html(current_password.location.toLowerCase());
				$("#app_password_info"+count+" #pop_up_location").removeClass("unavail");
				$("#app_password_info"+count+" #pop_up_location").html(current_password.location.toLowerCase());
			}
			$("#app_password_info"+count+" #pop_up_time").html(current_password.created_date);
			$("#app_password_info"+count+" #pop_up_ip").html(current_password.created_ip);
			
			$("#app_password_info"+count+" #delete_generated_password").attr("onclick","delete_app_pass('"+count+"','"+current_password.app_pass_id+"')");
		}
		if(count > 3)
		{
			if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
			{	
				$("#app_pass_justviewmore").show();
				$("#app_pass_add_view_more").hide();				
			} else {
				$("#app_pass_add_view_more").show();				
			}
			$("#app_pass_justaddmore").hide();
			if(count>4)
			{
				$("#app_pass_add_view_more .view_more").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWDS"],count-3)); //NO I18N
				$("#app_pass_justviewmore").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWDS"],count-3)); //NO I18N
			}
			else
			{
				$("#app_pass_add_view_more .view_more").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWD"],count-3)); //NO I18N
				$("#app_pass_justviewmore").html(formatMessage(i18nAppPwdkeys["IAM.VIEWMORE.PWD"],count-3)); //NO I18N
			}
		}
		else
		{
			if(typeof isAppPwdAllowed !== "undefined" && !isAppPwdAllowed)
			{								
				$("#app_pass_justaddmore").hide();
			} else {				
				$("#app_pass_justaddmore").show();
			}			
			$("#app_pass_add_view_more").hide();
		}
	}
	else
	{
		$("#no_app_passwords").show();
		$("#display_app_passwords").hide();
		$("#app_pass_justaddmore").hide();
	}
	
}


function show_selected_app_password_info(id)
{
	
	$("#app_pass_pop .device_pic").addClass($("#app_password_entry"+id+" .device_pic")[0].className);
	$("#app_pass_pop .device_pic").html($("#app_password_entry"+id+" .device_pic").html());
	$("#app_pass_pop .device_name").html($("#app_password_entry"+id+" .device_name").html()); //load into popuop
	$("#app_pass_pop .device_time").html($("#app_password_entry"+id+" .device_time").html()); //load into popuop
	
	$("#app_pass_pop #app_current_info").html($("#app_password_info"+id).html()); //load into popuop
	
	popup_blurHandler('6');
	
	$("#app_pass_pop").show(0,function(){
		$("#app_pass_pop").addClass("pop_anim");
	});
	$("#delete_generated_password").focus();
	closePopup(closeview_selected_app_pass_view,"app_pass_pop"); //No I18N
}

function closeview_selected_app_pass_view()
{
	popupBlurHide('#app_pass_pop'); //No I18N
	$("#app_pass_pop a").unbind();
}


function delete_app_pass(count,pwdid)
{
	
	
	new URI(AppPasswordsObj,"self","self",pwdid).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete security_data.AppPasswords[pwdid];
				load_AppPasswords(security_data.Policies,security_data.AppPasswords);			
				closeview_selected_app_pass_view();
				if($("#app_password_web_more").is(":visible")==true)
				{					
					var lenn=Object.keys(security_data.AppPasswords).length;
					if(lenn > 1)
					{
						$("#app_password_web_more").hide();
						$("#view_all_app_pass").html("");
						show_all_app_passwords();
					}
					else{
						$(".blur").css({"z-index":"6","opacity":".5"});
						closeview_all_app_view();
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
			});
	
	
}

function show_generate_popup()
{
	$("#popup_apppass_new").show(0,function(){
		$("#popup_apppass_new").addClass("pop_anim");
	});
	$("#generate_new_pass").show();
	$("#generated_passsword").hide();
	
	popup_blurHandler('6');
	control_Enter("#popup_apppass_new a");//No i18N
	$("#popup_apppass_new input:first").focus();
	closePopup(close_new_app_pass_popup,"popup_apppass_new");//No I18N	
}















function close_new_app_pass_popup()
{
	popupBlurHide('#popup_apppass_new',function(){	//No i18N
		$("#generate_new_pass").show();
		$("#generated_passsword").hide();		
	});
	remove_error();
	$("#popup_apppass_new input").val(''); 
}






function generateAppPassword()
{
	remove_error();
	var label = de('applabel').value.trim(); //No i18N
	if(label == "")
	{
		$("#gene_app_space").append( '<div class="field_error">'+empty_field+'</div>' );
		return;
	}
	if(validatelabel(label) != true) 
	{
		$("#gene_app_space").append( '<div class="field_error">'+err_invalid_label+'</div>' );
		return;
	}

	if(label.length > 45)
	{
		$("#gene_app_space").append( '<div class="field_error">'+err_invalid_label+'</div>' );//No i18N
		return;
	}
//	pass = de('passapp').value.trim(); //No i18N
//	if(pass=="")
//	{
//		$("#gene_app_pass_space").append( '<div class="field_error">'+err_invalid_password+'</div>' );
//		return;
//	}
	
	disabledButton($("#generate_new_pass"));
	var parms=
	{
//		"password":pass,//No I18N
		"keylabel":label//No I18N
	};
	
	
	var payload = AppPasswordsObj.create(parms);
	//$("#generate_new_pass .tfa_blur").show();
	//$("#generate_new_pass .loader").show();
	
	payload.POST("self","self").then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		//$("#generate_new_pass .tfa_blur").hide();
		//$("#generate_new_pass .loader").hide();
		security_data.AppPasswords[resp.apppasswords.app_info.app_pass_id]=resp.apppasswords.app_info;
		load_AppPasswords(security_data.Policies,security_data.AppPasswords);
		generate_appcallback(resp.apppasswords.password)
		removeButtonDisable($("#generate_new_pass"));
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
		//$("#generate_new_pass .tfa_blur").hide();
		//$("#generate_new_pass .loader").hide();
		removeButtonDisable($("#generate_new_pass"));
	});

	return false;
}

function generate_appcallback(password)
{	
	
	$("#generate_new_pass").hide();
	$("#generated_passsword").show();
	
	$("#app_name").html(de('applabel').value.trim()); //No i18N
	var displayPass = "<span>"+password.substring(0, 4)+"</span>"+"<span style='margin-left:5px'>"+password.substring(4, 8)+"</span>"+"<span style='margin-left:5px'>"+password.substring(8)+"</span>"; //No I18N
	$('.app_password').html(displayPass); //No i18N
	//$('.password_key').val(password); //No i18N
	$(".app_pasword_info .app_info").html(formatMessage(tfa_pass_msg,de('applabel').value.trim()));//No i18N
	$(".app_password_grid").attr("title",err_app_pass_click_text);//No i18N
	tippy(".app_password_grid",{//No I18N
    		trigger:"mouseenter",	//No I18N
    		arrow:true
	});
	$("#popup_apppass_new").focus();
}


function show_all_app_passwords()
{
	$("#view_all_app_pass").html($("#display_app_passwords").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_app_pass .allowed_ip_entry_hidden").show();
	//$("#view_all_app_pass .authweb_entry").after( "<br />" );
	//$("#view_all_app_pass .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_app_pass .allowed_ip_entry").removeAttr("onclick");
	$("#view_all_app_pass .info_tab").show();

//	$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .asession_action").hide();

	
	$("#app_password_web_more").show(0,function(){
		$("#app_password_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_app_pass .allowed_ip_entry").click(function(){
		
		var id=$(this).attr('id');

		$("#view_all_app_pass .allowed_ip_entry").addClass("autoheight");
		$("#view_all_app_pass .aw_info").slideUp(300);
		$("#view_all_app_pass .activesession_entry_info").show();
		if($("#view_all_app_pass #"+id).hasClass("Active_ip_showall_hover"))
		{

			$("#view_all_app_pass #"+id).removeClass("Active_ip_showall_hover");
			$("#view_all_app_pass #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_all_app_pass .allowed_ip_entry").removeClass("autoheight");
			});
			$("#view_all_app_pass .activesession_entry_info").show();
		}
		else
		{
			$("#view_all_app_pass .allowed_ip_entry").removeClass("Active_ip_showall_hover");
			$("#view_all_app_pass .allowed_ip_entry").removeClass("Active_ip_showcurrent");
			$("#view_all_app_pass #"+id).addClass("Active_ip_showall_hover");
			$("#view_all_app_pass #"+id+" .aw_info").slideDown(300,function(){
				$("#view_all_app_pass .allowed_ip_entry").removeClass("autoheight");
			});
			$("#view_all_app_pass #"+id+" .activesession_entry_info").hide();
	//		$("#view_all_allow_ip #"+id+" .primary_btn_check").focus();
		}
		
	});
	closePopup(closeview_all_app_view,"app_password_web_more");//No I18N
	
	$("#app_password_web_more").focus();

}


function closeview_all_app_view()
{
	popupBlurHide('#app_password_web_more',function(){	//No i18N
		$("#view_all_app_pass").html("");		
	});
}



/***************************** Device Logins *********************************/

 function load_DeviceLogins(Policies,Devicelogins)
 {
	if(de("Device_logins_exception"))
	{
		$("#Device_logins_exception").remove();
		$("#show_Device_logins #no_Devices").removeClass("hide");
	}
	if(Devicelogins.exception_occured!=undefined	&&	Devicelogins.exception_occured)
	{
		$("#Device_logins_box .box_info" ).after("<div id='Device_logins_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#Device_logins_exception #reload_exception").attr("onclick","reload_exception(Device_logins,'Device_logins_box')");
		$("#show_Device_logins #no_Devices").addClass("hide");
		return;
	}
	
//	if(!jQuery.isEmptyObject(security_data.DeviceLogins))
	$("#display_all_Devices").html("");
	var count=0,device_loc_count=0;
	var hideCount = security_data.DeviceLogins.client_apps?2:3;
	if(!jQuery.isEmptyObject(security_data.DeviceLogins.Platform_Logins))
	{
		var platform_logins=security_data.DeviceLogins.Platform_Logins;
		$("#show_Device_logins #no_Devices").hide();
		$("#display_all_Devices").show();
		var devices=Object.keys(platform_logins);
		var isCurrentBrowserDevice = false;
		for(var iter=0;iter<devices.length;iter++)
		{
			var current_device=platform_logins[devices[iter]];
			Device_logins_format = $("#empty_Device_logins_format").html();
			$("#display_all_Devices").append(Device_logins_format);
			$("#display_all_Devices #Device_logins_entry").attr("id","Device_logins_entry"+count);
			$("#display_all_Devices #Device_logins_info").attr("id","Device_logins_info"+count);
			$("#display_all_Devices #select_device_").attr("id","select_device_"+count);
			
			$("#Device_logins_entry"+count).attr("onclick","show_selected_devicelogins_info("+count+");");
			$("#Device_logins_entry"+count).addClass("devicelogin_list");
			$("#Device_logins_entry"+count+" .device_name").html(devices[iter]);
			
			$("#Device_logins_entry"+count+" .mail_client_logo").html(devices[iter].substr(0,2).toUpperCase());//No I18N
			$("#Device_logins_entry"+count+" .mail_client_logo").addClass(color_classes[gen_random_value()]);
				
			if(platform_logins[devices[iter]].length==1)
			{
				var platform_location = platform_logins[devices[iter]][Object.keys(platform_logins[devices[iter]])[0]].location
				if(platform_location!=undefined)
				{
					$("#Device_logins_entry"+count+" .asession_location").html(platform_location.toLowerCase());
				}
				
			}
			else
			{
				$("#Device_logins_entry"+count+" .asession_location").html(Object.keys(platform_logins[devices[iter]]).length+" "+Locations);
			}
			if(count >= hideCount)
			{
				$("#Device_logins_entry"+count).addClass("allowed_ip_entry_hidden");  
			}
			
			var locations_count=0;
			isCurrentBrowserDevice = false;
			var alignedsDeviceData = {};
			var device_keys = Object.keys(platform_logins[devices[iter]]);
			for(var key in device_keys)
			{
				locations_count++;
				var current_browser = platform_logins[devices[iter]][device_keys[key]];
				alignedsDeviceData[current_browser.device_id] = current_browser;
				Device__format = $("#empty_Devices_format").html();
				
				$("#display_all_Devices #Device_logins_info"+count).append(Device__format);
				
				$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry").attr("id","Devices_entry"+locations_count);
				$("#display_all_Devices #Device_logins_info"+count+" #select_device_browser_").attr("id","select_device_browser_"+count+"_"+locations_count);
				$("#display_all_Devices #select_device_browser_"+count+"_"+locations_count+" .checkbox_check").attr("id",current_browser.device_id);
				
				$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" #devicelogins_entry_info").attr("id","devicelogins_entry_info"+locations_count);
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").addClass("icon-"+current_browser.browser_info.browser_image);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").html(fontIconBrowserToHtmlElement[current_browser.browser_info.browser_image]);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").attr('title',current_browser.browser_info.browser_version);
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_browser.browser_info.browser_name);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_login_tim").html(current_browser.last_accessed_elapsed);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").addClass("icon-os_"+getOsClassName(current_browser.device_info.os_name));
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").html(fontIconBrowserToHtmlElement[getOsClassName(current_browser.device_info.os_name)]);
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('title',current_browser.device_info.os_name);
				
				if(current_browser.location!=undefined)
				{
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_location").html(current_browser.location.toLowerCase());
				}
				
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .deleteicon").attr("onclick","delete_current_trusted_entry(\'"+current_browser.device_id+"\',\'"+devices[iter]+"\',"+count+","+locations_count+");");
				if(current_browser.is_current_session){
					isCurrentBrowserDevice = true;
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".deleteicon").remove();
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find("input[type='checkbox']").remove();
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".checkbox").addClass("disabled_checkbox");
					
					if(platform_logins[devices[iter]].length<2){
						$("#Device_logins_entry"+count+" .select_holder").find("input[type='checkbox']").remove();
						$("#Device_logins_entry"+count+" .select_holder").find(".checkbox").addClass("disabled_checkbox"); //No I18N
					}
				}
				else{
					$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".current").remove();
				}
				device_loc_count++;
			}
			if(isCurrentBrowserDevice){
				$("#Device_logins_entry"+count+" .current").show();
				var current_devi_template = $("#Device_logins_entry"+count);
				current_devi_template.removeClass("allowed_ip_entry_hidden").addClass("current_session");
				$("#Device_logins_entry"+count).remove();
				$("#display_all_Devices").prepend(current_devi_template);
			}
			else{
				$("#Device_logins_entry"+count+" .current").remove();				
			}
			security_data.DeviceLogins.Platform_Logins[devices[iter]] = alignedsDeviceData;
			count++;
		}
		if(hideCount<$(".devicelogin_list").not(".allowed_ip_entry_hidden").length){
			$(".devicelogin_list").not(".current_session").first().addClass("allowed_ip_entry_hidden");
		}
	}
	if(!jQuery.isEmptyObject(security_data.DeviceLogins.client_apps))
	{
		$("#show_Device_logins #no_Devices").hide();
		$("#display_all_Devices").show();
		Device_logins_format = $("#empty_Device_logins_format").html();
		$("#display_all_Devices").append(Device_logins_format);
		$("#display_all_Devices #Device_logins_entry").attr("id","Device_logins_entry"+count);
		$("#display_all_Devices #Device_logins_info").attr("id","Device_logins_info"+count);
		$("#display_all_Devices #select_device_").attr("id","select_device_"+count);
		
		$("#Device_logins_entry"+count).attr("onclick","show_selected_devicelogins_info("+count+");");
		$("#Device_logins_entry"+count).addClass("mailclient_list");
		$("#Device_logins_entry"+count+" .device_name").html(mail_client);
		$("#Device_logins_entry"+count+" .mail_client_logo").html(mail_client.substr(0,2).toUpperCase());//No I18N
		$("#Device_logins_entry"+count+" .mail_client_logo").addClass(color_classes[gen_random_value()]);
		$("#Device_logins_entry"+count+" .current").remove();
		var mail_client_logins=security_data.DeviceLogins.client_apps;
		var client_APPS=Object.keys(mail_client_logins);
		
		if(client_APPS.length==1)
		{
			//$("#Device_logins_entry"+count+" .device_time").html(Devicelogins[devices[iter]][0].device_name);
			if(mail_client_logins[client_APPS[0]].location!=undefined)
			{
				$("#Device_logins_entry"+count+" .asession_location").html(mail_client_logins[client_APPS[0]].location.toLowerCase());
			}
		}
		else
		{
			$("#Device_logins_entry"+count+" .asession_location").html(client_APPS.length+" "+Locations);
		}
		if(count > 3)
		{
			$("#Device_logins_entry"+count).addClass("allowed_ip_entry_hidden");  
		}
		var locations_count=0;
		for(var client_iter=0;client_iter<client_APPS.length;client_iter++)
		{
			locations_count++;
			device_loc_count++;
			var current_client=mail_client_logins[client_APPS[client_iter]];
			Device__format = $("#empty_Devices_format").html();
			$("#display_all_Devices #Device_logins_info"+count).append(Device__format);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry").attr("id","Devices_entry"+locations_count);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" #devicelogins_entry_info").attr("id","devicelogins_entry_info"+locations_count);
			$("#display_all_Devices #Device_logins_info"+count+" #Devices_entry"+locations_count+" .checkbox_check").attr("id",current_client.device_id);
			
			$("#display_all_Devices #Device_logins_info"+count+" #select_device_browser_").attr("id","select_device_browser_"+count+"_"+locations_count);
			$("#display_all_Devices #select_device_browser_"+count+"_"+locations_count+" .checkbox_check").attr("id",current_client.device_id);
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .asession_browser").attr('class', '');
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_client.location);
			 
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").addClass("device_client_name");
			
			if(current_client.location!=undefined)
			{
				$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_name").html(current_client.location);
			}
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .device_login_tim").html(current_client.last_accessed_elapsed);
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('class', '');
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_os").attr('title',"")
			

			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .devicelogins_entry_info .asession_location").html("");
			
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count+" .deleteicon").attr("onclick","delete_current_trusted_MailClient_entry("+count+","+locations_count+",\'"+client_APPS[client_iter]+"\',\'"+current_client.device_id+"\');");
			$("#Device_logins_info"+count+" #Devices_entry"+locations_count).find(".current").remove();
		}
		count++;
	}
	if(device_loc_count<2){
		$("#Device_logins_box .header_btn").hide();
	}else{
		$("#Device_logins_box .header_btn").show();
	}

	if(count>3)
	{
		$("#Device_logins_viewmore,#display_all_Devices .select_holder").show();
	}
	else if(count==0)
	{
		$("#display_all_Devices,#Device_logins_viewmore").hide();
		$("#display_all_Devices").html("");
		$("#show_Device_logins #no_Devices").show();
	}
	else{
		$("#Device_logins_viewmore").hide();
	}
	return;
	 
 }

 function  delete_current_trusted_MailClient_entry(platform_id,location_id,platform_name,device_id)
 {
	new URI(Mail_ClientLoginsObj,"self","self",device_id).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var deleted=false;
				if(security_data.DeviceLogins.client_apps!=undefined	&&	security_data.DeviceLogins.client_apps[platform_name]!=undefined)
				{
					if(security_data.DeviceLogins.client_apps[platform_name]!=undefined)
					{
						delete security_data.DeviceLogins.client_apps[platform_name];
						deleted=true;
					}
				}
				load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
				
				
				if($("#Device_logins_web_more").is(":visible")==true)
				{
					 $("#view_all_Device_logins").html("");
					show_all_device_logins();
					if(!deleted)
					{
						$("#view_all_Device_logins #Device_logins_entry"+platform_id).click();
					}
				}
				else
				{
					if(deleted)
					{
						closeview_selected_Device_logins_view();
					}
					else
					{
						$("#Device_logins_current_info #Devices_entry"+location_id).remove();
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
			});
	 
 }
 
 
 
function  delete_current_trusted_entry(device_id,platform_name,platform_id,location_id)
{
	new URI(DeviceLoginsObj,"self","self",device_id).DELETE().then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		var deleted=false;
		if(security_data.DeviceLogins.Platform_Logins!=undefined	&&	security_data.DeviceLogins.Platform_Logins[platform_name]!=undefined)
		{
			delete security_data.DeviceLogins.Platform_Logins[platform_name][device_id];
			if(Object.keys(security_data.DeviceLogins.Platform_Logins[platform_name]).length==0)
			{
				delete security_data.DeviceLogins.Platform_Logins[platform_name];
				deleted=true;
			}
		}
		load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
		
		
		if($("#Device_logins_web_more").is(":visible")==true)
		{
			 $("#view_all_Device_logins").html("");
			show_all_device_logins();
			if(!deleted)
			{
				$("#view_all_Device_logins #Device_logins_entry"+platform_id).click();
			}
		}
		else
		{
			if(deleted)
			{
				if(security_data.DeviceLogins.Platform_Logins[platform_name] == undefined){
					closeview_selected_Device_logins_view();
				}
			}
			else
			{
				$("#Device_logins_current_info #Devices_entry"+location_id).remove();
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
	});
}
function reflectPopupAction(for_location){
	if($("#Device_logins_pop").is(":visible")){
		$("#Device_logins_current_info .checkbox_check").each(function(index){
			var par_ID = $("#Device_logins_pop #device_select_all").attr("name");
			if($("#Device_logins_current_info .checkbox_check")[index].checked && !$("#Device_logins_current_info .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].checked = true;
			}
			else if($("#Device_logins_current_info .checkbox_check")[index].checked && $("#Device_logins_current_info .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].indeterminate = true;
			}
			else{
				$("#display_all_Devices #"+par_ID+" .aw_info").find(".checkbox_check")[index].checked = false;
			}
		});
	}
	else{
		$("#view_all_Device_logins .checkbox_check").each(function(index){
			var par_ID = $($("#display_all_Devices .checkbox_check")[index]).parents(".select_holder").attr("id"); //No I18N
			if($("#view_all_Device_logins .checkbox_check")[index].checked && !$("#view_all_Device_logins .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].checked = true;
			}
			else if($("#view_all_Device_logins .checkbox_check")[index].checked && $("#view_all_Device_logins .checkbox_check")[index].indeterminate){
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].indeterminate = true;
			}
			else{
				$("#display_all_Devices #"+par_ID).find(".checkbox_check")[0].checked = false;
			}
		});
	}
}
function handleDeviceGroup(checking_ele){
	var selected_count = $(checking_ele).parents(".devicelogins_entry").find(".aw_info input").length+$("#view_all_Device_logins .aw_info input:checked").length;
	if(showLimitOnPopup(selected_count) && checking_ele.checked){
		if($("#view_all_Device_logins .aw_info input:checked").length < 50){
			checking_ele.indeterminate = true;
		}
		else{
			checking_ele.checked = false;			
		}
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info input").slice(0,50 - $("#view_all_Device_logins .aw_info input:checked").length).prop('checked', true);
		if(!$("#Device_logins_web_more").is(":visible")){
			show_all_device_logins();
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).click();
			$("#Device_logins_web_more .deleteicon").show();
			$("#Device_logins_web_more .all_elements_space").css("height",isMobile ? "calc(100% - 155px)" : "calc(100% - 189px)");
			$("#Device_logins_web_more #deleted_selected_sessions,#Device_logins_web_more .selected_count").hide();
		}
	}
	else{
		deviceGroupSelectCallback(checking_ele);
		reflectPopupAction();
		if(showLimitOnPopup($("#view_all_Device_logins .aw_info input:checked").length)){
			checking_ele.checked = false;
			deviceGroupSelectCallback(checking_ele);
		}
	}
	handleSelectAllFunction();
}
function deviceGroupSelectCallback(checking_ele){
	if(checking_ele.checked ){
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check").each(function(i,ele){
			$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check")[i].checked = true;
		});
		if(!$("#Device_logins_web_more").is(":visible")){
			show_all_device_logins();
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).find(".aw_info .checkbox_check").each(function(i,ele){
				ele.checked = true;
			});
			$("#Device_logins_web_more #"+$(checking_ele).parents(".devicelogins_entry").attr("id")).click();
		}
	}
	else{
		$(checking_ele).parents(".devicelogins_entry").find(".aw_info .checkbox_check").each(function(i,ele){
			ele.checked = false;
		});
	}
}
function handleChildCheckbox(ele){
	handleChildCheckboxCallback(ele);
	reflectPopupAction();
    if(showLimitOnPopup($("#display_all_Devices .aw_info input:checked").length)){
    	ele.checked = false;
    	handleChildCheckboxCallback(ele);
    }
    handleSelectAllFunction();
}
function handleChildCheckboxCallback(ele){
	$("#show_Device_logins #"+$(ele).parent()[0].id).find(".checkbox_check")[0].checked = ele.checked;
	var childCheckbox = $(ele).parents(".aw_info").find(".checkbox_check");
    var parentCheckbox = $(ele).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0];
    var checkedChildCount = $(ele).parents(".aw_info").find(".checkbox_check:checked").length;
    if($("#Device_logins_pop").is(":visible")){
    	childCheckbox = $(ele).parents("#Device_logins_current_info").find(".checkbox_check");
    	parentCheckbox = $("#display_all_Devices #"+ele.id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0];
    	checkedChildCount = $(ele).parents("#Device_logins_current_info").find(".checkbox_check:checked").length;
    }
    if(parentCheckbox){
	    parentCheckbox.checked = checkedChildCount > 0;
	    $("#display_all_Devices #"+$(ele).parent()[0].id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0].checked = checkedChildCount > 0;
	    if(!$("#Device_logins_pop").is(":visible")){
	    	parentCheckbox.indeterminate = checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	    }
	    if($("#Device_logins_pop .select_all_div .checkbox_check")[0]){
	    	$("#Device_logins_pop .select_all_div .checkbox_check")[0].checked = checkedChildCount > 0;
	    	$("#Device_logins_pop .select_all_div .checkbox_check")[0].indeterminate =  checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	    }
	    $("#display_all_Devices #"+$(ele).parent()[0].id).parents(".devicelogins_entry").find(".info_tab .checkbox_check")[0].indeterminate =  checkedChildCount > 0 && checkedChildCount < childCheckbox.length;
	}
}
function handleSelectAllFunction(){
    if($("#view_all_Device_logins .info_tab .checkbox_check").length == $("#view_all_Device_logins .info_tab .checkbox_check:checked").length){
    	$("#Device_logins_web_more #device_select_all").prop('checked', true);
    }
    else{
    	$("#Device_logins_web_more #device_select_all").prop('checked', false);
    }
    if($("#view_all_Device_logins .checkbox_check:checked").length>0){
    	$("#Device_logins_web_more .delete_all_space,#Device_logins_web_more #deleted_selected_sessions").show();
    	$("#Device_logins_web_more .deleteicon").hide();
    	$("#Device_logins_web_more .all_elements_space").css("height", isMobile ? "calc(100% - 155px)" : "calc(100% - 189px)");
    }
    else{
    	$("#Device_logins_web_more .delete_all_space,#Device_logins_web_more #deleted_selected_sessions").hide();   
    	$("#Device_logins_web_more .deleteicon").show();
    	$("#Device_logins_web_more .all_elements_space").css("height",isMobile ? "calc(100% - 65px)" : "calc(100% - 100px)");
    }
    if($("#Device_logins_current_info .checkbox_check:checked").length>0){
    	$("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").show();
    	$("#Device_logins_pop .deleteicon").hide();
    }
    else{
    	$("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").hide();   
    	$("#Device_logins_pop .deleteicon").show();
    }
    reflectPopupAction();
    if($("#view_all_Device_logins").is(":visible")){
    	showLimitOnPopup($("#view_all_Device_logins .aw_info input:checked").length);
    }
    else{
    	showLimitOnPopup($("#display_all_Devices .aw_info input:checked").length);
    }
    
}
function showLimitOnPopup(count){
    var select_limit = 50;
    if(count > 0){
    	$("#Device_logins_pop .selected_count,#Device_logins_web_more .selected_count").html(count == 1 ? i18nSessionkeys["IAM.DEVICE.SIGNIN.DELETE.ONE.COUNT"] : formatMessage(i18nSessionkeys["IAM.DEVICE.SIGNIN.DELETE.COUNT"],count)).show();	//No I18N
    	count > select_limit - 5 ? $("#Device_logins_web_more .limit_reached_desc,#Device_logins_pop .limit_reached_desc").html(formatMessage(i18nSessionkeys["IAM.DEVICELOGINS.REMOVE.LIMIT"],select_limit)).show() : $("#Device_logins_web_more .limit_reached_desc,#Device_logins_pop .limit_reached_desc").hide();	//No I18N
    	//if($("#view_all_Device_logins .aw_info input").length == count){$("#Device_logins_pop .limit_reached_desc,#Device_logins_web_more .limit_reached_desc").hide()}
    }
    else{
    	$("#Device_logins_web_more .selected_count,#Device_logins_web_more .selected_count").hide();
    }
    return count > select_limit;
}
function deleteSelectedDevice(){
	var deviceLoginList = [];
	var mailClinetList = [];
	$('#view_all_Device_logins .devicelogin_list .aw_info input:checked').each(function() {
		deviceLoginList.push($(this).attr('id'));
	});
	$('#view_all_Device_logins .mailclient_list .aw_info input:checked').each(function() {
		mailClinetList.push($(this).attr('id'));
	});
	if(deviceLoginList.length != 0 && mailClinetList.length != 0){
		deviceLoginList = deviceLoginList.length == $('#view_all_Device_logins .devicelogin_list .aw_info input').length ? "" : deviceLoginList;
		mailClinetList = mailClinetList.length == $('#view_all_Device_logins .mailclient_list .aw_info input').length ? "" : mailClinetList;
		$.when( new URI(Mail_ClientLoginsObj,"self","self",mailClinetList).DELETE(), new URI(DeviceLoginsObj,"self","self",deviceLoginList).DELETE()).then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback(deviceLoginList,mailClinetList);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(deviceLoginList.length == 0){	
		mailClinetList = mailClinetList.length == $('#view_all_Device_logins .mailclient_list .aw_info input').length ? "" : mailClinetList;
		new URI(Mail_ClientLoginsObj,"self","self",mailClinetList).DELETE().then(function(resp){		//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback([],mailClinetList);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(mailClinetList.length == 0){
		deviceLoginList = deviceLoginList.length == $('#view_all_Device_logins .devicelogin_list .aw_info input').length ? "" : deviceLoginList;
		new URI(DeviceLoginsObj,"self","self",deviceLoginList).DELETE().then(function(resp)	//No I18N
				{
					SuccessMsg(getErrorMessage(resp));
					deletAllCallback(deviceLoginList,[]);
				},
				function(resp)
				{
					deleteFailureCallback(resp);
				});
	}
}

function deleteAllDeviceLocation(){
	if(security_data.DeviceLogins.client_apps && Object.keys(security_data.DeviceLogins.Platform_Logins).length>1){
		$.when( new URI(Mail_ClientLoginsObj,"self","self","").DELETE(), new URI(DeviceLoginsObj,"self","self","").DELETE()).then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback("","");
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else if(security_data.DeviceLogins.client_apps == undefined){
		new URI(DeviceLoginsObj,"self","self","").DELETE().then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback('',[]);
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	else{
		new URI(Mail_ClientLoginsObj,"self","self","").DELETE().then(function(resp){	//No I18N
			SuccessMsg(getErrorMessage(resp));
			deletAllCallback([],'');
		},function(resp){
			deleteFailureCallback(resp);
		});
	}
	
}

function deleteFailureCallback(resp){
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
}
function deletAllCallback(deviceList,mailList){
	if(deviceList === ""){
		deviceList = [];
		$('#display_all_Devices .devicelogin_list .aw_info').find("input").each(function() {
				deviceList.push($(this).attr('id'));
		});
	}
	if(Array.isArray(deviceList) && deviceList.length != 0){
		for(var index in deviceList){
			var platform_name = $("#show_Device_logins #"+deviceList[index]).parents(".devicelogins_entry").find(".device_platform_details").text().trim();
			if(security_data.DeviceLogins.Platform_Logins!=undefined	&&	security_data.DeviceLogins.Platform_Logins[platform_name]!=undefined)
			{
				delete security_data.DeviceLogins.Platform_Logins[platform_name][deviceList[index]];
				if(Object.keys(security_data.DeviceLogins.Platform_Logins[platform_name]).length==0)
				{
					delete security_data.DeviceLogins.Platform_Logins[platform_name];
				}
			}
		}
	}
	if(Array.isArray(mailList) && mailList.length != 0){
		for(var index in mailList){
			var platform_name = $("#show_Device_logins #"+mailList[index]).parents(".devicelogins_entry").find(".device_platform_details").text().trim();
			if(security_data.DeviceLogins.client_apps!=undefined	&&	security_data.DeviceLogins.client_apps[mailList[index]]!=undefined)
			{
					delete security_data.DeviceLogins.client_apps[mailList[index]];
			}
		}
		if(Object.keys(security_data.DeviceLogins.client_apps).length == 0){
			delete security_data.DeviceLogins.client_apps;
		}
	}
	else if(mailList === ""){
		delete security_data.DeviceLogins.client_apps;
	}
	load_DeviceLogins(security_data.Policies,security_data.DeviceLogins);
	if(!$("#Device_logins_pop").is(":visible")){
		if(Object.keys(security_data.DeviceLogins.Platform_Logins).length > 1)
		{
			$("#view_all_Device_logins").html("");
			show_all_device_logins();
		}
		else{
		 	popupBlurHide("#Device_logins_web_more",function(){		//No I18N
		 		$("#view_all_Device_logins").html("");
		 	});
		}
	}
}

function showDeleteAllDeviceLoginsConf(title,desc){
	show_confirm(title,desc,
		    function() 
		    {
				deleteAllDeviceLocation();
			},
		    function() 
		    {
		    	return false;
		    }
		);
}

 function show_selected_devicelogins_info(id)
 {
	 	if(event && $(event.target).parents().hasClass("select_holder")){return;}
	 	tooltip_Des("#Device_logins_current_info .action_icon");//No I18N
		tooltip_Des("#Device_logins_current_info .asession_os");	//No I18N
		$("#Device_logins_pop #platform_img").removeClass();
		$("#Device_logins_pop #platform_img").addClass($("#Device_logins_entry"+id+" .mail_client_logo:visible")[0].classList.value);
		$("#Device_logins_pop #platform_img").text($("#Device_logins_entry"+id+" .mail_client_logo:visible").text());
		$("#Device_logins_pop .device_name").html($("#Device_logins_entry"+id+" .device_name").html()); //load into popuop
		
		$("#Device_logins_pop #Device_logins_current_info").html($("#Device_logins_info"+id).html()); //load into popuop
		if($("#Device_logins_pop #Device_logins_current_info").children().length>2){
			$("#Device_logins_current_info .select_holder,#Device_logins_pop .select_all_div,#Device_logins_pop .select_all_div .select_holder").show();
			$("#Device_logins_pop .select_all_div input").attr("name","Device_logins_entry"+id);
			var location_type = $("#Device_logins_entry"+id).hasClass('mailclient_list') ? "mail_client" : "device";		//No I18N
			$("#Device_logins_pop #deleted_selected_locations").attr("onclick","deleteSelectedLocations('"+id+"','"+location_type+"')");		//No I18N
			$("#Device_logins_pop #device_select_all").prop('checked', $("#Device_logins_entry"+id).find("#device_check")[0].checked).prop('indeterminate', $("#Device_logins_entry"+id).find("#device_check")[0].indeterminate);
			if($("#Device_logins_entry"+id).find("#device_check")[0].checked && !$("#Device_logins_entry"+id).find("#device_check")[0].indeterminate){
				$("#Device_logins_pop .checkbox_check").prop('checked', true);
			}
			else{
				var checked_inputs = $("#Device_logins_entry"+id+" .aw_info .checkbox_check:checked");
				for(var index=0;index<checked_inputs.length;index++){
					$("#Device_logins_pop").find("#"+checked_inputs[index].id).prop('checked', true);
				}
			}
		    if($("#Device_logins_current_info .checkbox_check:checked").length>0){
		    	$("#Device_logins_pop .delete_location").show();
		    }
		    else{
		    	$("#Device_logins_pop .delete_location").hide();   
		    }
		}
		else{			
			$("#Device_logins_current_info .select_holder,#Device_logins_pop .delete_location").hide();
			$("#Device_logins_pop .select_all_div").hide();
		}
		
		popup_blurHandler('6');
		$("#Device_logins_pop").show(0,function(){
			$("#Device_logins_pop").addClass("pop_anim");
		});
		tooltipSet("#Device_logins_current_info .action_icon");//No I18N
		sessiontipSet("#Device_logins_current_info .asession_os");//No I18N
		closePopup(closeview_selected_Device_logins_view,"Device_logins_pop"); //No I18N
		$("#Device_logins_pop").focus();
 }
 
function deleteSelectedLocations(id,loc_type){
	var locationList = [];
	$('#Device_logins_current_info input:checked').each(function() {
		locationList.push($(this).attr('id'));
	});
	var locationObjType = loc_type == "mail_client" ? Mail_ClientLoginsObj : DeviceLoginsObj;	//No I18N
	if(locationList.length != 0){		
		disabledButton("#Device_logins_pop .delete_location");
		new URI(locationObjType,"self","self",locationList).DELETE().then(function(resp){		//No I18N
			SuccessMsg(getErrorMessage(resp));
			removeButtonDisable("#Device_logins_pop .delete_location");			//No I18N
			loc_type == "mail_client" ? deletAllCallback([],locationList) : deletAllCallback(locationList,[]);	//No I18N
			locationList.length != $("#Device_logins_current_info>div").length ? $("#Device_logins_entry"+id).click() : closeview_selected_Device_logins_view();
		},function(resp){
			removeButtonDisable("#Device_logins_pop .delete_location");			//No I18N
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
 
 function closeview_selected_Device_logins_view()
 {
	 $("#display_all_Devices .checkbox_check").prop('indeterminate', false).prop('checked', false);
	 popupBlurHide("#Device_logins_pop");	//No I18N
 }
 
 
 
 function show_all_device_logins()
 {
	 $("#view_all_Device_logins").html($("#display_all_Devices").html()); //load into popuop
	 tooltip_Des("#view_all_Device_logins .action_icon");//No I18N
	 tooltip_Des("#view_all_Device_logins .asession_os");	//No I18N
	 popup_blurHandler('6');
		//$("#view_all_app_pass .authweb_entry").after( "<br />" );
		//$("#view_all_app_pass .authweb_entry").addClass("viewall_authwebentry");
		$("#view_all_Device_logins .devicelogins_entry").removeAttr("onclick");
		$("#view_all_Device_logins .devicelogins_entry").show();
		
		$("#Device_logins_web_more").show(0,function(){
			$("#Device_logins_web_more").addClass("pop_anim");
		});
		
		$("#view_all_Device_logins .devicelogins_entry").click(function(event)
		{
			if($(event.target).parents().hasClass("select_holder")){
				if($(event.target).parents(".select_holder").find(".checkbox_check")[0].checked && $(event.target).parents(".devicelogins_entry").find(".aw_info").is(":visible") || $(event.target).parents().hasClass("aw_info")){					
					return;
				}
			}
			var id=$(this).attr('id');
			
			tooltip_Des(".devicelogins_entry .aw_info .action_icon");//No I18N
			
			$("#view_all_Device_logins .devicelogins_entry").addClass("autoheight");
			$("#view_all_Device_logins .aw_info").slideUp(300);
			$("#view_all_Device_logins .activesession_entry_info").show();
			if($("#view_all_Device_logins #"+id).hasClass("Active_ip_showall_hover"))
			{

				$("#view_all_Device_logins #"+id+" .aw_info").slideUp("fast",function(){
					$("#view_all_Device_logins #"+id).removeClass("Active_ip_showall_hover");
					$("#view_all_Device_logins .devicelogins_entry").removeClass("autoheight");
					$("#view_all_Device_logins #"+id+" .info_tab").find(".current").show();
				});
				$("#view_all_Device_logins .activesession_entry_info").show();
			}
			else
			{
				$("#view_all_Device_logins .devicelogins_entry").removeClass("Active_ip_showall_hover");
				$("#view_all_Device_logins .devicelogins_entry").removeClass("Active_ip_showcurrent");
				$("#view_all_Device_logins #"+id).addClass("Active_ip_showall_hover");
				$("#view_all_Device_logins #"+id+" .aw_info").slideDown(300,function(){
					$("#view_all_Device_logins .devicelogins_entry").removeClass("autoheight");
					tooltipSet(".devicelogins_entry .aw_info .action_icon");//No I18N
				});
				$("#view_all_Device_logins #"+id+" .info_tab").find(".current").hide();
				$("#view_all_Device_logins #"+id+" .activesession_entry_info").hide();
		//		$("#view_all_allow_ip #"+id+" .primary_btn_check").focus();
			}
			
		});
		tooltipSet("#view_all_Device_logins .action_icon");//No I18N
		sessiontipSet("#view_all_Device_logins .asession_os");//No I18N
		closePopup(closeview_Device_logins_view,"Device_logins_web_more");//No I18N
		$("#Device_logins_web_more .select_holder").show();
		$("#display_all_Devices .checkbox_check").each(function(index){
			var par_ID = $($("#display_all_Devices .checkbox_check")[index]).parents(".select_holder").attr("id"); //No I18N
		    if($("#display_all_Devices .checkbox_check")[index].checked && !$("#display_all_Devices .checkbox_check")[index].indeterminate){
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].checked = true;
		    }
		    else if($("#display_all_Devices .checkbox_check")[index].checked && $("#display_all_Devices .checkbox_check")[index].indeterminate){
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].indeterminate = true;
		    }
		    else{
		    	$("#view_all_Device_logins #"+par_ID).find(".checkbox_check")[0].checked = false;
		    }
		});
		handleSelectAllFunction();
		$("#Device_logins_web_more").focus();
 }
 
 function showOneAuthTerminate(ele)
 {
 	 $('#include_oneauth').prop('checked', false);
 	 if(ele.checked && $("#ter_mob").hasClass("show_oneauth")){
 		 $(".oneAuthLable").slideDown(300).addClass("displayOneAuth");
 		 $("#terminate_session_weband_mobile_desc").hide();
 		 $(ele).parents(".checkbox_div").addClass("showOneAuthLable");
 		 $(".showOneAuthLable").addClass("displayBorder");
 	 }
 	 else{
 		 $(".oneAuthLable").removeClass("displayOneAuth");
 		 $(".showOneAuthLable").removeClass("displayBorder");
 		 $("#terminate_session_weband_mobile_desc").show();
 		 $(".oneAuthLable").slideUp(300,function(){			 
 			 $(ele).parents(".checkbox_div").removeClass("showOneAuthLable");
 		 });
 	 }
 }
 function closeview_Device_logins_view()
 {
	reflectPopupAction();
	$("#display_all_Devices .checkbox_check").prop('indeterminate', false).prop('checked', false);
 	popupBlurHide("#Device_logins_web_more",function(){		//No I18N
 		$("#view_all_Device_logins").html("");
 	});
 }
 
 function selectAllLocation(ele){
	 var limit_reached = showLimitOnPopup($(ele).parents("#Device_logins_pop").find("#Device_logins_current_info input").length);
	 if(ele.checked && !limit_reached){
		 $("#Device_logins_current_info .checkbox_check,#display_all_Devices #"+ele.name+" #device_check").prop('indeterminate', false).prop('checked', true);
		 $("#Device_logins_pop .deleteicon").hide();
	 }
	 else if(limit_reached && $("#Device_logins_current_info .checkbox_check:checked").length < 50){
		 $("#Device_logins_current_info .checkbox_check").prop('checked', false).prop('indeterminate', false);
		 $("#Device_logins_current_info .checkbox_check").slice(0,50).prop('checked', true).prop('indeterminate', false);	//No I18N
		 $("#display_all_Devices #"+ele.name+" #device_check,#Device_logins_pop #device_select_all").prop('checked', false).prop('indeterminate', true);
		 $("#Device_logins_pop .limit_reached_desc").html(formatMessage(i18nSessionkeys["IAM.DEVICELOGINS.REMOVE.LIMIT"],50)).show();	//No I18N
		 $("#Device_logins_pop .selected_count").hide();
		 $("#Device_logins_pop .deleteicon").show();
		 $("#Device_logins_pop .delete_location,#Device_logins_pop #deleted_selected_locations").show();
	 }
	 else{
		 $("#Device_logins_current_info .checkbox_check,#display_all_Devices #"+ele.name+" #device_check").prop('checked', false).prop('indeterminate', false);
		 $("#Device_logins_pop #deleted_selected_locations,#Device_logins_pop .selected_count").show();
		 $("#Device_logins_pop .deleteicon").show();
		 $("#Device_logins_pop .delete_location").hide();
	 }
     if($("#Device_logins_pop .checkbox_check").length == $("#Device_logins_pop .checkbox_check:checked").length){
     	 $("#Device_logins_pop #device_select_all").prop('checked', true);
	   	 reflectPopupAction();
		 handleSelectAllFunction();
     }
     else{
    	 $("#Device_logins_pop #device_select_all").prop('checked', false);
     }
	 showLimitOnPopup($("#Device_logins_current_info .devicelogins_devicedetails input:checked").length);
 }
 
 function validatePasswordPolicy(passwordPolicy) {
	passwordPolicy = passwordPolicy || security_data.Password.PasswordPolicy;
	var initCallback = function(id, msg) {
		var li = document.createElement('li');//No I18N
        li.setAttribute("id","pp_"+id);//No I18N
        li.setAttribute("class","pass_policy_rule");//No I18N
        li.textContent = msg;
        return li;
	}
	var setErrCallback = function(id) {
		$("#pp_"+id).removeClass('success');//No I18N
		return id;
	}
 	return {
 		getErrorMsg: function(value, callback) {
 			if(passwordPolicy) {
	 			var isInit = value ?  false : true;
	 			value = value || '';
	 			callback = callback || setErrCallback;
	 			var rules = [ 'MIN_MAX', 'SPL', 'NUM', 'CASE']; //No I18N
	 			var err_rules = []; 
	 			var err_msg = []; 
	 			if(!isInit) {
	 				$('.pass_policy_rule').addClass('success');//No I18N
	 			}
	 			for(var i = 0; i < rules.length; i++) {
	 				switch (rules[i]) {
	 					case 'MIN_MAX': //No I18N
	 						if(value.length<passwordPolicy.min_length || value.length>passwordPolicy.max_length) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(err_pp_min_max, passwordPolicy.min_length.toString(), passwordPolicy.max_length.toString()) : undefined));
	 						}
	 						break;
	 					case 'SPL': //No I18N
	 						if((passwordPolicy.min_spl_chars > 0) &&  (((value.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length) < passwordPolicy.min_spl_chars)) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(passwordPolicy.min_spl_chars === 1 ? err_pp_spl_sing : err_pp_spl, passwordPolicy.min_spl_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'NUM': //No I18N
	 						if((passwordPolicy.min_numeric_chars > 0) &&  (((value.match(new RegExp("[0-9]","g")) || []).length) < passwordPolicy.min_numeric_chars)){
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(passwordPolicy.min_numeric_chars === 1 ? err_pp_num_sing: err_pp_num, passwordPolicy.min_numeric_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'CASE': //No I18N
	 						if((passwordPolicy.mixed_case) && !((new RegExp("[A-Z]","g").test(value))&&(new RegExp("[a-z]","g").test(value)))) {
	 							err_rules.push(callback(rules[i], isInit ? err_pp_case : undefined));
	 						}
	 						break;
	 				}
	 			}
	 			return err_rules.length && err_rules;
 			}
 		},
 		init: function(passInputID) {
 			$('.hover-tool-tip').remove();//No I18N
 			var tooltip = document.createElement('div');//No I18N
 			tooltip.setAttribute("class",isMobile ? "hover-tool-tip no-arrow" : "hover-tool-tip");//No I18N
 			var p = document.createElement('p');//No I18N
 			p.textContent = err_pp_heading;
 			var ul = document.createElement('ul');//No I18N
 			var errList = this.getErrorMsg(undefined, initCallback);
 			if(errList) {
 	 			errList.forEach(function(eachLi) {
 	 	 			ul.appendChild(eachLi);
 	 			});
 	 			tooltip.appendChild(p);
 	 			tooltip.appendChild(ul);
 	 			document.querySelector('body').appendChild(tooltip);//No I18N
 	 			$(passInputID).on('focus blur', function(e){//No I18N
 	 			    if(e.type === 'focus') {//No I18N
 	 			    	var offset = document.querySelector(passInputID).getBoundingClientRect();
 	 			    	$('.hover-tool-tip').css("z-index","9");
 	 		 			$('.hover-tool-tip').css(isMobile ? {
 	 		 				top: offset.bottom + $(window).scrollTop() + 8,
 	 		 				left: offset.x,
 	 		 				width: offset.width - 40
 	 		 			} : {
 	 		 				top: offset.y + $(window).scrollTop(),
 	 		 				left: offset.x + offset.width + 15
 	 		 			});
 	 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
 	 			    } else {
 	 			    	$('.hover-tool-tip').css("z-index","-1");
 	 			    	$('.hover-tool-tip').css('opacity', 0);//No I18N
 	 			    	var offset = document.querySelector('.hover-tool-tip').getBoundingClientRect();//No I18N
 	 		 			$('.hover-tool-tip').css({
 	 		 				top: -offset.height,
 	 		 				left: -(offset.width + 15)
 	 		 			})
 	 			    }
 	 			});
 			}
 		},
 		validate: function(passInputID) {
 			remove_error();
			var str=$(passInputID).val();
			this.getErrorMsg(str, setErrCallback);
 		}
 	}
 }
 
 function getOsClassName(osName){
	osName = osName.toLowerCase();
	if((/windows/).test(osName)){
		return "windows"; //No I18N
	} else if((/mac/).test(osName)){
		return "osx"; //No I18N
	} else if((/iphone|ipad/).test(osName)){
		return "ios"; //No I18N
	} else if((/linux|ubuntu/).test(osName)){
		return "linux"; //No I18N
	} else if((/android/).test(osName)){
		return "android"; //No I18N
	} else {
		return "osunknown"; //No I18N
	}
}
