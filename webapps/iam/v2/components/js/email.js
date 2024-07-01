	//$Id$
var d = new Date();
var n;

var  primary_email="";
var  login_mobile="";
var  preferred_mfa_num="";
var  disable_phoneNum_type="";
function load_emaildetails(policies,emailDetail)
{
	if(de("email_exception"))
	{
		$("#email_exception").remove();
	}
	if(emailDetail.exception_occured!=undefined	&&	emailDetail.exception_occured)
	{
		$( "#email_box .box_info" ).after("<div id='email_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#email_exception #reload_exception").attr("onclick","reload_exception(EMAIL,'email_box')");
		return;
	}
	tooltip_Des(".field_email .action_icon");//No I18N
	var email_keys=timeSorting(emailDetail);
	var primEmailEjs="";
	  if(Object.keys(profile_data.Email).length<1)
	  {
	    $("#no_email_add_here").removeClass("hide");
	    if(!$("#emailID_prim").hasClass("hide"))
	    {
	      $("#emailID_prim").addClass("hide");
	    }
	    if(!policies.ADD_SECONDARY_EMAIL)
	    {
	    	$("#no_email_add_here .primary_btn_check").hide();
	    }
	    else
	    {
	    	$("#no_email_add_here .primary_btn_check").show();
	    }
	  }
	  else {
			primEmailEjs = profile_data.Email[$("#profile_email").text()].email_id_ejs;
		}
	  var sec_count=0;
	  $(".emailID_sec").html("");
	  $("#emailID_prim").addClass("hide");
//	  primary_email.email_id=profile_data.primary_email;
	  for(iter=0;iter<Object.keys(profile_data.Email).length;iter++)
	  {
		$("#email_content").removeClass("hide");
	    var current_email=profile_data.Email[email_keys[iter]];
	    var is_linked_email=false;
	    if(current_email.is_primary)
	    {
	    	$("#emailID_prim").removeClass("hide");
//	        primary_email=current_email;

	        $("#emailID_info0 .email_hover").html("");
	        $("#no_email_add_here").addClass("hide");
	        $(".email_popup_forgotpass").show();
	        var mail_del_onclick;
	        if(profile_data.primary_email==undefined)
	        {
	          $(".email_popup_forgotpass").hide();
	        }
    		if(current_email.hasOwnProperty("idp_info") && current_email.idp_info[0] != -1 && !isClientPortal) {
    	    	is_linked_email = true;
    	    	if(current_email.idp_info.length === 1) { 
    	    		$("#emailID_prim .linked_email_tag").removeClass("icon-link");
    	    		var toolTipElement = $("#emailID_prim .linked_email_tag .tooltiptext");
					$("#emailID_prim .linked_email_tag").addClass("sml_idp_icon "+ idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[0]].iconClassName).html(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[0]].iconElement).append(toolTipElement); //NO I18N
    	    	} else {
    	    		$("#emailID_prim .linked_email_tag").addClass("icon-link");
    	    		$("#emailID_prim .all_linked_icons").empty().html("<span class='sml_idp_icon'></span>");
        	    	for(var ic=0; ic < current_email.idp_info.length; ic++) {
	      				if(ic != 0) {
	      					$("#emailID_prim .all_linked_icons").append("<span class='sml_idp_icon'></span>");
	      				}
	    				$("#emailID_prim .sml_idp_icon:eq("+ic+")").removeClass().attr("class", "profile_tags sml_idp_icon"); //NO I18N
						$("#emailID_prim .sml_idp_icon:eq("+ic+")").addClass(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[ic]].iconClassName).append(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[ic]].iconElement);  				
	      			}
    	    	}
    	    	if(profile_data.enable_thirdparty_signin) {
    	    		$("#emailID_prim .saml_enforced_desc").addClass("hide");
    	    		$("#emailID_prim .linked_email_tag .profile_tags_tooltip_desc").html(i18nkeys["IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION"]); //NO I18N
    	    	} else {
    	    		$("#emailID_prim .saml_enforced_desc").removeClass("hide");
    	    		$("#emailID_prim .linked_email_tag .profile_tags_tooltip_desc").html(i18nkeys["IAM.PROFILE.LINKED.EMAIL.SAML.DESCRIPTION"]); //NO I18N	
    	    	}
    	    	$("#emailID_prim .linked_email_tag").removeClass("hide");
      		  } else {
      			$("#emailID_prim .sml_idp_icon").removeClass().attr("class", "profile_tags sml_idp_icon hide");
      			$("#emailID_prim .linked_email_tag").addClass("hide");
      		  }
    		
	        if(current_email.email_id_ejs)
	        {
	          $("#emailID_prim").removeClass("hide");
	          $(".primary_emailid").html(current_email.email_id);
	          if(isMobile)
	          {
	            $(".email_hover_show").addClass("hide");
	            $("#email_content .profile_tags").addClass("hide");
	          }
	          if(de("em_icon_delete_0") && profile_data.login_mobile!=undefined)
	          {
	        	  $('#em_icon_delete_0').show();
	        	  
	        	  mail_del_onclick = $('#em_icon_delete_0').attr("onclick");
	        	  mail_del_onclick = mail_del_onclick.split(",");
		          	if(mail_del_onclick.length == 1) {
		          		mail_del_onclick = $('#em_icon_delete_0').attr("onclick");
		          		mail_del_onclick = mail_del_onclick.split(");");
		          	} 
	        	  
	        	  mail_del_onclick[0]+=",'"+current_email.email_id_ejs+"','"+primEmailEjs+"',"+is_linked_email+");";
	        	  $('#em_icon_delete_0').attr("onclick",mail_del_onclick[0]);
	        	  $("#emailID_num_0").attr("onclick",'for_mobile_specific_email(\'emailID_num_0\')');
	          }
	          else
        	  {
	        	  $('#em_icon_delete_0').hide();
	        	  $("#em_icon_delete_0").attr("onclick","deleteEmail('"+i18nkeys['IAM.CONFIRM.POPUP.EMAIL']+"');");
        	  }
	          
	          if(!current_email.is_verified)//not confirmed
	          {
				$("#emailID_num_0 .email_dp").removeClass("email_dp icon-email").addClass("unverified_email_dp icon-unverified-email");
				$("#emailID_num_0").attr("onclick",'for_mobile_specific_email(\'emailID_num_0\')');
	            $("#PrimConfim").removeClass("hide");	            
	            if(isMobile){
					$("#prim_tap_to_more").removeClass("hide");
				} else {
					$("#prim_em_verify_now_0").removeClass("hide");
				}                        
	            $("#prim_em_time").hide();
	              
	            /*if(de("em_icon_resend_0"))
	            {
	            	$('#em_icon_resend_0').show();
	            }*/
	            
	            $("#emailID_num_0 .email_info .verify_now_text").attr("onclick",'show_verify_now_popup(\''+current_email.email_id_ejs+'\',\'0\')');//No i18N	            
	            //$("#emailID_num_"+sec_count + ".email_info").attr("onclick",'for_mobile_specific_email(\'emailID_num_'+sec_count+'\')');
	            //$("#resend_0 .resend_grn_btn").attr("onclick",'resendConfirmation(\''+current_email.email_id_ejs+'\',\'0\')');	            	            
	            
	            /*$("#resend_0 .resend_em_text").html(formatMessage(em_resend_conf, current_email.email_id));
	            $("#resend_0 .resend_grn_btn").attr("onclick",'resendConfirmation(\''+current_email.email_id_ejs+'\',\'0\')');
	            tippy("#em_icon_resend_0", {		  //No I18N
	    			animation: 'scale',					//No I18N
	    			trigger: 'click mouseenter',				//No I18N
	    			appendTo:document.querySelector('#em_icon_resend_0').parentNode,//No I18N
	    			theme:'light',				//No I18N
	    			livePlacement: false,
	    			maxWidth: '300px',			//No I18N
	    			arrow: true,
	    			html: '#resend_0',		//No I18N
	    			hideOnClick: true,
	    			interactive: true
	    		});*/
	          }
	          else
	          {
	        	$("#PrimConfim").addClass("hide");
	        	$("#prim_tap_to_more").addClass("hide");
	        	$("#prim_em_verify_now_0").addClass("hide");
	        	$("#prim_em_time").show();
	            $("#prim_em_time").html(current_email.created_time_elapsed);
	            $("#emailID_num_0 .unverified_email_dp").removeClass("unverified_email_dp icon-unverified-email").addClass("email_dp icon-email");
	            if(de("em_icon_resend_0"))
	            {
	            	$('#em_icon_resend_0').hide();
	            }
	          }
	          if(!policies.CHANGE_FULL_NAME)
	          {
	        	  $("#em_icon_edit_0").hide();
	          }
	          else
	          {
	        	  $("#em_icon_edit_0").show();
	          }
	        }  
	    }
	    else
	    {  
	      ++sec_count;
	      
	      secondary_format = $("#empty_secondary_format").html();
	      var sec_em_id=current_email.created_time+"_secondary";//No i18N
	      
	      $(".emailID_sec").append(secondary_format);
	      
	      $(".emailID_sec #sec_emailDetails").attr("id","emailID_num_"+sec_count);
	      
	      $("#emailID_num_"+sec_count).attr("onclick",'for_mobile_specific_email(\'emailID_num_'+sec_count+'\')');
	      $("#emailID_num_"+sec_count+" .verify_now_text").attr("id","secondary_verify_now_"+sec_count); //No i18N
	      
	      if(current_email.hasOwnProperty("idp_info") && current_email.idp_info[0] != -1 && !isClientPortal) {
	    	is_linked_email = true;
	    	if(current_email.idp_info.length === 1) { 
	    		$("#emailID_num_"+sec_count+" .linked_email_tag").removeClass("icon-link");
				$("#emailID_num_"+sec_count+" .linked_email_tag").addClass("sml_idp_icon "+ idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[0]].iconClassName).append(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[0]].iconElement);
	    	} else {
	    		$("#emailID_num_"+sec_count+" .linked_email_tag").addClass("icon-link");
	    		$("#emailID_num_"+sec_count+" .all_linked_icons").empty().html("<span class='sml_idp_icon'></span>");
	  			for(var ic=0; ic < current_email.idp_info.length; ic++) {
	  				if(ic != 0) {
	  					$("#emailID_num_"+sec_count+" .all_linked_icons").append("<span class='sml_idp_icon'></span>");
	  				}
					$("#emailID_num_"+sec_count+" .sml_idp_icon:eq("+ic+")").removeClass().attr("class", "profile_tags sml_idp_icon"); //NO I18N
					$("#emailID_num_"+sec_count+" .sml_idp_icon:eq("+ic+")").addClass(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[ic]].iconClassName).append(idpInfoValueToHtmlElement["idpValue_"+current_email.idp_info[ic]].iconElement);  				
	  			}
	    	}
	    	$("#emailID_num_"+sec_count+" .linked_email_tag").removeClass("hide");
	    	if(profile_data.enable_thirdparty_signin) {
	    		$("#emailID_num_"+sec_count+" .saml_enforced_desc").addClass("hide");
	    		$("#emailID_num_"+sec_count+" .linked_email_tag .profile_tags_tooltip_desc").html(i18nkeys["IAM.PROFILE.LINKED.EMAIL.ADDRESS.DESCRIPTION"]); //NO I18N
	    	} else {
	    		$("#emailID_num_"+sec_count+" .saml_enforced_desc").removeClass("hide");
	    		$("#emailID_num_"+sec_count+" .linked_email_tag .profile_tags_tooltip_desc").html(i18nkeys["IAM.PROFILE.LINKED.EMAIL.SAML.DESCRIPTION"]); //NO I18N	
	    	}
  		  } else {
  			$("#emailID_num_"+sec_count+" .sml_idp_icon").removeClass().attr("class", "profile_tags sml_idp_icon hide");
  			$("#emailID_num_"+sec_count+" .linked_email_tag").addClass("hide");
  		  }
	      
	      if(sec_count > 2)
	      {
	        $("#emailID_num_"+sec_count).addClass("extra_emailids");  
	      }
	      
	      $("#emailID_num_"+sec_count+" .email_info .emailaddress_text").attr("id",sec_em_id);//No i18N
	        $("#emailID_num_"+sec_count+" .email_info .emailaddress_text").html(current_email.email_id);
	      $("#emailID_num_"+sec_count+" .email_hover_show").attr("id",'emailID_info'+sec_count);
	              
	      if(!current_email.is_verified)//not confirmed	
	      {
			$("#emailID_num_"+sec_count+" .email_dp").removeClass("email_dp icon-email").addClass("unverified_email_dp icon-unverified-email");
	        $("#emailID_num_"+sec_count+" .email_info #secondary_unconfirmed").removeClass("hide");
	        $("#emailID_num_"+sec_count+" .email_info #secondary_time").hide();	        
	        
	        if(isMobile){
				$("#emailID_num_"+sec_count+" .email_info #secondary_tap_to_more").removeClass("hide");
			} else {
				$("#emailID_num_"+sec_count+" .email_info #secondary_verify_now_"+sec_count).removeClass("hide");
			}  
	        
	        
	        //Adding NEW
	        $("#emailID_num_"+sec_count+" .email_info .verify_now_text").attr("onclick",'show_verify_now_popup(\''+current_email.email_id_ejs+'\',\''+sec_count+'\')');//No i18N

	        /*$("#emailID_info"+sec_count+" .resendconfir").attr("id",'em_icon_resend_'+sec_count);
	        
	        $("#emailID_info"+sec_count+" .resend_options").attr("id",'resend_'+sec_count);
	       
	        $("#resend_"+sec_count+" .resend_em_text").html(formatMessage(em_resend_conf, current_email.email_id));
	        $("#resend_"+sec_count+" .resend_grn_btn").attr("onclick",'resendConfirmation(\''+current_email.email_id_ejs+'\',\''+sec_count+'\')');
            tippy("#em_icon_resend_"+sec_count, {		  //No I18N
    			animation: 'scale',					//No I18N
    			trigger: 'click mouseenter',				//No I18N
    			appendTo:document.querySelector('#em_icon_resend_'+sec_count).parentNode,//No I18N
    			theme:'light',				//No I18N
    			livePlacement: false,
    			maxWidth: '300px',			//No I18N
    			arrow: true,
    			html: '#resend_'+sec_count,		//No I18N
    			hideOnClick: true,
    			interactive: true
    		});*/
    		
    		          
	                                  
	            
	            
	            /*if(de("em_icon_resend_0"))
	            {
	            	$('#em_icon_resend_0').show();
	            }*/	            	            
    		
	        
            $("#emailID_info"+sec_count+" .action_icons_div .mkeprimary").remove();
            
	      }
	      else
	      {
	    	  $("#emailID_num_"+sec_count+" .email_info #secondary_unconfirmed").hide();
	          $("#emailID_num_"+sec_count+" .email_info #secondary_time").show();
	          $("#emailID_num_"+sec_count+" .email_info #secondary_time").html(current_email.created_time_elapsed);
	          
	          $("#emailID_info"+sec_count+" .resendconfir").remove();
	          $("#emailID_info"+sec_count+" .resend_options").remove();
	    	  if(policies.CHANGE_PRIMARY_EMAIL)//make primary
		       {
	         	 	$("#emailID_info"+sec_count+" .action_icons_div .mkeprimary").attr("onclick",'showEmail_changePrimary(\''+sec_em_id+'\',\'setAsPrimary\');');
	         	 	$("#emailID_info"+sec_count+" .action_icons_div .mkeprimary").attr("id","em_icon_MKprim_"+sec_count);
		       }
	    	   else
	    	   {
	    		   $("#emailID_info"+sec_count+" .action_icons_div .mkeprimary").remove();
	    	   }
	      }
	          $("#emailID_info"+sec_count+" .action_icons_div .icon-delete").attr("id","em_icon_delete_"+sec_count);
		      mail_del_onclick = $("#emailID_info"+sec_count+" .action_icons_div .icon-delete").attr("onclick");
	    	  mail_del_onclick = mail_del_onclick.split(",");
	    	  if(mail_del_onclick.length == 1) {
	          		mail_del_onclick = $('#em_icon_delete_'+sec_count).attr("onclick");
	          		mail_del_onclick = mail_del_onclick.split(");");
	          	}
	    	  mail_del_onclick[0]+=",'"+current_email.email_id_ejs+"','"+primEmailEjs+"',"+is_linked_email+");";
	    	  $("#emailID_info"+sec_count+" .action_icons_div .icon-delete").attr("onclick",mail_del_onclick[0]);
	          $("#emailID_info"+sec_count+" .action_icons_div .icon-delete").show();
	    }
	    $("#emailID_num_"+iter+" .email_dp").addClass(color_classes[gen_random_value()]);
	    $("#emailID_num_"+iter+" .unverified_email_dp").addClass(color_classes[gen_random_value()]);
	  }
	  if(isMobile)
	  {
	    $("#email_content .email_hover_show").addClass("hide");
	  }
	  $("#email_box .addnew").show();
	  $("#email_add_view_more").show();
	  if(policies.ADD_SECONDARY_EMAIL && (Object.keys(profile_data.Email).length>0))//CAN ADD AND NOT EMPTY
	  {
		  if(sec_count<3)//less THAN 3
		  {
			  $("#email_justview").hide();
			  $("#email_add_view_more").hide();
		  }
		  else
		  {
			  $("#email_justaddmore").hide();
			  $("#email_justview").hide();
		  }
	  }
	  else if(!policies.ADD_SECONDARY_EMAIL && (Object.keys(profile_data.Email).length>0)) //cant add but more than 3
	  {
		  if(sec_count>2)
		  {	  
			  $("#email_add_view_more").hide();
			  $("#email_justaddmore").hide();	  
		  }
		  else
		  {
			  $("#email_justaddmore").hide();
			  $("#email_justview").hide();
			  $("#email_justview").hide();
			  $("#email_add_view_more").hide();
		  }
	  }
	  else
	  {
		  $("#email_justaddmore").hide();
		  $("#email_justview").hide();
		  $("#email_justview").hide();
		  $("#email_add_view_more").hide();
	  }
	  if(Object.keys(profile_data.Email).length>4)
	  {
		  $("#email_add_view_more .view_more").html(formatMessage(i18nkeys["IAM.VIEWMORE.EMAILS"],Object.keys(profile_data.Email).length-3)); //NO I18N
	  }
	  else
	  {
		  $("#email_add_view_more .view_more").html(formatMessage(i18nkeys["IAM.VIEWMORE.EMAIL"],Object.keys(profile_data.Email).length-3)); //NO I18N
	  }
	  if(!isMobile){
		  tooltipSet(".field_email .action_icon");//No I18N
	  }
	  adjust_email_width();
	  $('#emailID_num_0').hover(function() {
		if(hasOneEmailNoOtherRecovery()){
		    $('#em_icon_delete_0').hide();
		    $("#em_icon_delete_0").attr("onclick","deleteEmail('"+i18nkeys['IAM.CONFIRM.POPUP.EMAIL']+"');");
		}
		else {
			$('#em_icon_delete_0').show();
        	  mail_del_onclick = $('#em_icon_delete_0').attr("onclick");
        	  mail_del_onclick = mail_del_onclick.split(",");
	          	if(mail_del_onclick.length == 1) {
	          		mail_del_onclick = $('#em_icon_delete_0').attr("onclick");
	          		mail_del_onclick = mail_del_onclick.split(");");
	          	} 
        	  var isLinkedMail = false;
        	  var PrimaryEmailObj = profile_data.Email[$("#profile_email").text()];
        	  if(PrimaryEmailObj.hasOwnProperty("idp_info") && PrimaryEmailObj.idp_info[0] != -1 && !isClientPortal ){
				isLinkedMail = true;
			  }
        	  mail_del_onclick[0]+=",'"+primEmailEjs+"','"+primEmailEjs+"',"+isLinkedMail+");";
        	  $('#em_icon_delete_0').attr("onclick",mail_del_onclick[0]);
        	  $("#emailID_num_0").attr("onclick",'for_mobile_specific_email(\'emailID_num_0\')');
			}
		});
}

/**
 * check if the email can be accommodated in single row and reduce letter spacing accordingly
 * @param elem        element to check
 * @param spacing     spacing to reduce
 * @param max_spacing maximum spacing that can be applied
 * @returns void
 */
function reduce_spacing(elem, spacing,max_spacing) {
	if($(elem).height() > 20 && spacing < max_spacing) {
		$(elem).css('letter-spacing',-spacing);
		reduce_spacing(elem, spacing+0.1, max_spacing);
	}
}



/**
 * to adjust email width as follows 
 * 1. for desktop it will match the width of the email that has max characters
 * 2. for mobile it'll reduce the letter spacing and try to accommodate in single line
 * @returns void
 */
function adjust_email_width() {
	if(!isMobile) {
		$('.email_table .email_info').width('');
		max_width = Math.max.apply(null,$('.email_table .email_info').map(function(){ return this.clientWidth }).get());
		if(max_width) {
			$('.email_table .email_info').width(max_width+2);
		}
	} else {
		$('.email_table .email_info .emailaddress_text').map(function(){ 
			if(this.clientWidth) {
				reduce_spacing(this, 0, 1);
			}
		})
	}
}

//add email
function showaddemail_popup()
{
	remove_error();
	popup_blurHandler('6');

	$("#add_email_popup").show(0,function(){
		$("#add_email_popup").addClass("pop_anim");		
	});
	$("#create_description").show();
	$("#email_otp_description").hide();
	$("#NEWemail_add").show();
	$("#add_email_popup .popuphead_text").text(add_email_id);
	$("#NEWemail_confirmation").hide();
	$('#addemailform')[0].reset();
	control_Enter(".blue"); //No I18N
	$("#add_email_popup .textbox:first").focus();
	closePopup(close_addemail_popup,"add_email_popup");//No I18N
}


function close_addemail_popup()
{
	clearInterval(resend_timer);
	$(".blue").unbind(); 
	popupBlurHide("#add_email_popup");	//No I18N
}

function add_email(form,callback)
{
	remove_error();
	if(!isEmailId(form.email_id.value)){
		$('#'+form.id).find('input[name="email_id"]').focus().parents(".field").append('<div class="field_error">'+err_validemail+'</div>');
		return;
	}
	if(validateForm(form))
	{
		disabledButton(form);
		var new_emailid=$('#'+form.id).find('input[name="email_id"]').val().trim();
		var payload;
		encryptData.encrypt([new_emailid]).then(function(encryptedloginid) {
			encryptedemailId = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
			var parms=
			{
				"email_id":encryptedemailId//No I18N
			};
			payload = Email.create(parms);
			payload.POST("self","self").then(function(resp)	//No I18N
			{
				callback(resp,new_emailid);
				removeButtonDisable(form);
			},
			function(resp)
			{
				removeButtonDisable(form);
				if(resp.cause && resp.cause.trim() === "invalid_password_token") 
				{
					relogin_warning();
					var service_url = euc(window.location.href);
					$("#new_notification").attr("onclick","window.open('"+contextpath + resp.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
				}
				else
				{
					if(resp.errors && resp.errors[0].code == "EMAIL505"){
						$("#addemailform [name='email_id']").parents('.field').append( '<div class="field_error">'+resp.localized_message+'</div>' );
						return false;
					}
					showErrorMessage(getErrorMessage(resp));
				}
			});	
		});
		
	}
	return false;
}

function show_verify_now_popup(email_id, sec_count){
	remove_error();
	popup_blurHandler('6');

	$("#send_verification_email_popup").show(0,function(){
		$("#send_verification_email_popup").addClass("pop_anim");		
	});
	$("#send_verify_em_form #create_description").html(formatMessage(em_resend_conf, email_id));
	$("#sendverifyemailform #send_verification_email_action").attr("onclick",'resendConfirmation(\''+email_id+'\',\'0\')');	
	
	control_Enter(".blue"); //No I18N
	$("#send_verification_email_popup .textbox:first").focus();
	closePopup(close_send_verification_email_popup,"send_verification_email_popup");//No I18N
}

function close_send_verification_email_popup()
{
	clearInterval(resend_timer);
	$(".blue").unbind(); 
	popupBlurHide("#send_verification_email_popup");	//No I18N
}

function add_email_callback(emailObj,new_emailid,disableBackOption)
{
	SuccessMsg(getErrorMessage(emailObj));
	if(!$("#add_email_popup").is(":visible"))
	{
		showaddemail_popup();
		$('#NEWemail_add').find('input[name="email_id"]').val(new_emailid);
	}
	cryptData = emailObj.email.encrypted_data;
	$("#NEWemail_add").hide();
	$("#add_email_popup .popuphead_text").text(verify_email_id);
	$("#NEWemail_confirmation").show();
	var str = $("#email_otp_text").html();
	$("#email_otp_description").html(formatMessage(str,new_emailid));//No I18N 	
	$("#create_description").hide();
	$("#email_otp_description").show();
	resend_countdown("#add_email_popup #emailOTP_resend");//No I18N 	
	splitField.createElement('otp_email_input',{
		"splitCount":otp_length,					// No I18N
		"charCountPerSplit" : 1,		// No I18N
		"isNumeric" : true,				// No I18N
		"otpAutocomplete": true,		// No I18N
		"customClass" : "customOtp",	// No I18N
		"inputPlaceholder":'&#9679;'	// No I18N
	});
	disableBackOption ?  $("#NEWemail_confirmation #back_to_add_email").hide() : $("#NEWemail_confirmation #back_to_add_email").show();
	$('#otp_email_input #otp_email_input_full_value').attr('data-validate','zform_field');
	$('#otp_email_input #otp_email_input_full_value').attr('name','otp_code');
	$('#otp_email_input .customOtp').attr('onkeypress','remove_error()');
	$("#otp_email_input").click();
	closePopup(close_addemail_popup,"add_email_popup",true);//No I18N
	//profile_data.Email[emailObj.email.email_id]=emailObj.email;
	//load_emaildetails(profile_data.Policies,profile_data.Email);
	
}

function backToAddEmail(){
	$("#NEWemail_confirmation,#email_otp_description").hide();
	$("#NEWemail_add,#create_description").show();
	$("#add_email_popup .popuphead_text").text(i18nkeys['IAM.ADD.CONTACT.EMAIL']);	//No I18N
}

function confirm_add_email(form,callback)
{
	if(validateForm(form))
	{
		if(!isMobile){
			disabledButton(form);			
		}
		
		if($("#emails_web_more").hasClass("pop_anim") && !isMobile){
			form = $(".viewall_popup").find(form)[0];
			code = $(".viewall_popup #"+form.id).find('input[name="otp_code"]').val(); //No I18N
		}
		else{
			code = $("#"+form.id).find('input[name="otp_code"]').val(); //No I18N
		}
		if(!isValidCode(code)){
			$(form).children("#otp_emailaddress").append('<div class="field_error">'+err_valid_otp_code+'</div>');
			$("#otp_email_input").click();
			removeButtonDisable(form)
			return false;
		}
		var parms=
		{
			"code": code //No I18N
		};
		var payload = Email.create(parms);
		payload.PUT("self","self",cryptData).then(function(resp)	//No I18N
		{
			callback(resp);
			if(!isMobile){
				removeButtonDisable(form);
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
			if(!isMobile){
				removeButtonDisable(form);
			}
		});	
	}
	return false;
}

function confirm_add_email_callback(emailObj)
{
	SuccessMsg(getErrorMessage(emailObj));
	if($("#emails_web_more").is(":visible")){
		closeview_all_email_view();
	}
	$("#NEWemail_add").show();
	$("#add_email_popup .popuphead_text").text(add_email_id);
	$("#NEWemail_confirmation").hide();
	
	profile_data.Email[decodeHTML(emailObj.email.email_id)]=emailObj.email;
	if(profile_data.Email[decodeHTML(emailObj.email.email_id)].is_primary){
		$("#profile_email,#logoutid").html(emailObj.email.email_id);
		profile_data.primary_email=emailObj.email.email_id_ejs;
		profile_data.login_name=emailObj.email.email_id_ejs;
	}
	load_emaildetails(profile_data.Policies,profile_data.Email);
	close_addemail_popup();
}
//delete email


function deleteEmail(title,emailid,priemail,is_linked_email) 
{
    if(priemail.trim() == emailid.trim()) //for deleting primary email
    {
    	show_confirm(title,formatMessage(err_email_sure_delete_prim, emailid),
			    function() 
			    {	new URI(Email,"self","self",emailid).DELETE().then(function(resp)	//No I18N
					{
						delete_email_callback(resp,emailid);
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
    	if(is_linked_email && $("#confirm_popup").find(".link_eml_del").length == 0) {
    		$("#confirm_popup .confirm_text").append("<span class='link_eml_del'></span>");    	
    		$(".link_eml_del").html(linked_email_del);
    	}
    }
    else // for deleting secondary email
    {

		show_confirm(title,formatMessage(err_email_sure_delete1, emailid),
			    function() 
			    {	new URI(Email,"self","self",emailid).DELETE().then(function(resp)	//No I18N
					{
						delete_email_callback(resp,emailid);
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
		if(is_linked_email && $("#confirm_popup").find(".link_eml_del").length == 0) {
    		$("#confirm_popup .confirm_text").append("<span class='link_eml_del'></span>");    	
    		$(".link_eml_del").html(linked_email_del);
    	}
	}
	deleteBtnTextChange();
    $("#confirm_popup button:first").focus();
}

function delete_email_callback(emailObj,emailid)
{
		SuccessMsg(getErrorMessage(emailObj));
		delete profile_data.Email[emailid];
		if($("#profile_email").text() === emailid.trim()){
			if(Object.keys(profile_data.Email).length === 0){
				profile_data.primary_email=profile_data.login_mobile;//no primary email as of now so we will use primary mobile
				profile_data.login_name=profile_data.login_mobile;
    			$("#profile_email,#logoutid").text(phonePattern.setMobileNumFormat(profile_data.login_mobile));
			}
			else {
				var currPrimeEmailId = Object.keys(profile_data.Email).sort()[0];
				profile_data.primary_email = currPrimeEmailId;
				profile_data.login_name=currPrimeEmailId;
				$("#profile_email,#logoutid").text(currPrimeEmailId);
				profile_data.Email[currPrimeEmailId].is_primary = true;
			}	
		}
		load_emaildetails(profile_data.Policies,profile_data.Email);
		load_phonedetails(profile_data.Policies,profile_data.Phone);
		if($("#emails_web_more").is(":visible")==true){
			var lenn=Object.keys(profile_data.Email).length;
			if(lenn>1){
				$("#view_all_email").html("");
				goback_mob();
				$("#emails_web_more").hide();
				show_all_emails();
			}
			else{
				closeview_all_email_view();
			}
		}
		else{
			closeview_all_email_view();
		}
}

//make primary email id
function showEmail_changePrimary(element)
{
	remove_error();
	$('#selectedemail').prop("readonly", false);

	$("#selectedemail").val($("#"+element).html());
	$("#selectedemail").attr("readonly","readonly");
	
	var sec_emailid = $("#"+element).html();
	$("#make_email_primary").html(formatMessage(i18nkeys["IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION"],sec_emailid));//No I18N
	$("#mkprim_email_action").attr("onclick", "changePrimary_popup('"+element+ "',changed_primaryemail)");
	
	popup_blurHandler("6");
	$("#change_primaryEM").show(0,function(){
		$("#change_primaryEM").addClass("pop_anim");
	});
	control_Enter("a"); //No I18N
	control_Enter(".blue"); //No I18N
	$("#mkprim_email_action").focus();
	closePopup(close_change_primaryEM,"change_primaryEM");//No I18N
}


function close_change_primaryEM()
{
	$(".blur").css({"opacity":"0"});
	popupBlurHide("#change_primaryEM",function(){   //No I18N
		$('#Changeemailform')[0].reset();
	});
	$("a").unbind();
	$(".blue").unbind();

}


function changePrimary_popup(element,callback)
{
		var emailid = $("#"+element).html();
		var payload = makePrimary.create();
		payload.PUT("self","self",emailid).then(function(resp)	//No I18N
		{
			callback(resp,emailid);
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
	return;	
}


function changePrimary(form,callback)
{
	
	if(validateForm(form))
	{
		var emailid =$('#'+form.id).find('input[name="email_id"]').val();

		var payload = makePrimary.create();
		payload.PUT("self","self",emailid).then(function(resp)	//No I18N
		{
			callback(resp,emailid);
		},
		function(resp)
		{
			if(resp.cause && resp.cause.trim() === "invalid_password_token") {
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
	return;
	
	
}

function changed_primaryemail(emailObj,emailid)
{
	SuccessMsg(getErrorMessage(emailObj));
	//delete profile_data.email_detail[emailid];
	
	if((!isEmpty(profile_data.primary_email))	&&	profile_data.primary_email!=profile_data.login_mobile && profile_data.Email.hasOwnProperty($("#primary_emailid").html()))
	{
		profile_data.Email[$("#primary_emailid").html()].is_primary=false;
	}
	profile_data.Email[emailid].is_primary=true;
	profile_data.primary_email=emailid;
	$("#profile_email,#logoutid").text(emailid);
	load_emaildetails(profile_data.Policies,profile_data.Email);
	
	close_change_primaryEM();
	
	if($("#emails_web_more").is(":visible")==true){
		//closeview_all_email_view();
		$("#view_all_email").html("");
		$("#emails_web_more").hide();
		show_all_emails();
	}
}

//resend confirmation for unverfied emails of the previous setup

function resendConfirmation(emid,id_cnt) 
{
	if(document.querySelector('#em_icon_resend_'+id_cnt)!=null)
	{
		document.querySelector('#em_icon_resend_'+id_cnt)._tippy.hide(); //No I18N
	}
	clearInterval(resend_timer);
	popupBlurHide("#send_verification_email_popup",undefined,true);	//No I18N
	var payload ;
	encryptData.encrypt([emid]).then(function(encryptedloginid) {
		encryptedemailId = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var parms=
		{
			"email_id":encryptedemailId//No I18N
		};
		payload = Email.create(parms);
		payload.POST("self","self").then(function(resp)	//No I18N
		{
			if(!$("#emails_web_more").is(":visible")){			
				add_email_callback(resp,emid,true);
			}
			else{
				$("#view_all_email .web_email_specific_popup .inline_action").slideUp(300,function(){
					$("#view_all_email .web_email_specific_popup .inline_action").html("<div id='email_otp_description' class='inline_action_discription'></div>");
	
					$("#view_all_email .web_email_specific_popup .inline_action").append($("#add_em_form").html());
					$("#view_all_email #otp_email_input").attr('id','viewmore_email_otp');
					if(!$("#NEWemail_add").is(":visible"))
					{
						$('#view_all_email #NEWemail_add').find('input[name="email_id"]').val(emid);
					}
					$("#view_all_email .web_email_specific_popup .inline_action form").attr("name","viewmore_otp");
					$("#view_all_email .web_email_specific_popup .inline_action form").attr("id","veri_otp_form");
					var str = $("#email_otp_text").html();
					$(".inline_action #email_otp_description").html(formatMessage(str,emid));//No I18N
					splitField.createElement('viewmore_email_otp',{
						"splitCount":otp_length,					// No I18N
						"charCountPerSplit" : 1,		// No I18N
						"isNumeric" : true,				// No I18N
						"otpAutocomplete": true,		// No I18N
						"customClass" : "customOtp",	// No I18N
						"inputPlaceholder":'&#9679;'	// No I18N
					});
					$('#viewmore_email_otp #viewmore_email_otp_full_value').attr('data-validate','zform_field');
					$('#viewmore_email_otp #viewmore_email_otp_full_value').attr('name','otp_code');
					$('#viewmore_email_otp .customOtp').attr('onkeypress','remove_error()');
					$("#view_all_email #NEWemail_add").hide();
					$("#view_all_email #NEWemail_confirmation").show();
					$("#view_all_email #NEWemail_confirmation #back_to_add_email").hide();
					cryptData = resp.email.encrypted_data;
					$("#veri_otp_form").attr("onsubmit","return confirm_add_email(this,confirm_add_email_callback)");
					$("#view_all_email .web_email_specific_popup .inline_action").slideDown(300,function(){					
						$("#viewmore_email_otp").click();
						resend_countdown(".web_email_specific_popup #emailOTP_resend");//No I18N 
					});
				});
			}
		},
		function(resp)
		{
			if(!$("#emails_web_more").is(":visible")){
				popupBlurHide("#send_verification_email_popup",undefined,undefined);	//No I18N
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
	});
	
}

function resendConfirmationCodeForMob(c_code,mobilenum,ele_id){
	if(document.querySelector('#mob_icon_resend_'+ele_id)!=null)
	{
		document.querySelector('#mob_icon_resend_'+ele_id)._tippy.hide(); //No I18N
	}
	var payload;
	encryptData.encrypt([mobilenum]).then(function(encryptedloginid) {
		encryptedmobilenumber = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var parms=
		{
			"mobile":encryptedmobilenumber,//No I18N
			"countrycode":c_code//No I18N
		};
		payload = Phone.create(parms);
	});
	var hasViewMore = $("#phonenumber_web_more").is(":visible");
	if(hasViewMore){
		disabledButton($("#phonenumber_web_more .inline_action"));
	}
	
	function successCallback(resp){ 
		removeButtonDisable($("#phonenumber_web_more .inline_action"))
		if(!hasViewMore){		
			$("#addphoneonly").trigger('click');
			$(document.addphonenum).find('input[name="mobile_no"]').val(mobilenum);
			Otp_verify_show(resp);
			$("#common_popup .popuphead_define").html(formatMessage(otp_description,phonePattern.setMobileNumFormat(mobilenum,c_code)));
			$("#common_popup #add_mobile_back").attr("onclick",'showVerifyMobileNum(\''+c_code+'\',\''+mobilenum+'\',\''+ele_id+'\')');
		}
		else{
			SuccessMsg(getErrorMessage(resp));		
			$("#view_all_phonenumber .web_email_specific_popup .inline_action").slideUp(300,function(){
				$("#view_all_phonenumber .web_email_specific_popup .inline_action").html("<div id='email_otp_description' class='inline_action_discription'></div>");

				$("#view_all_phonenumber .web_email_specific_popup .inline_action").append($("#phonenumber_popup_contents").html());
				$("#view_all_phonenumber #otp_phonenumber_input").attr('id','viewmore_phonenumber_otp');
				$("#view_all_phonenumber #empty_phonenumber").hide();
				$("#view_all_phonenumber #phonenumber_password").hide();
				$("#view_all_phonenumber #select_existing_phone").hide();
				$("#view_all_phonenumber #select_phonenumber").hide();
				$("#view_all_phonenumber #add_mobile_back").hide();
				$("#phonenumber_popup_contents form").attr("name","mobile_otp_resend_form_popup");
				$("#phonenumber_popup_contents form").attr("action","");
				$("#view_all_phonenumber #otp_phonenumber").show();
				
				$('#view_all_phonenumber #popup_mobile_action').html(iam_verify_phone_number);
				$("#view_all_phonenumber #email_otp_description").html(formatMessage(otp_description,phonePattern.setMobileNumFormat(mobilenum,c_code)));
				$($('#view_all_phonenumber #phoneNumberform')[0]).attr("id","mobile_resend_otp_form");	//No I18N
				$("#view_all_phonenumber #mobile_resend_otp_form").find('input[name="mobile_no"]').val(mobilenum);
				$('#view_all_phonenumber #popup_mobile_action').attr("onclick","verifyOTP($('#view_all_phonenumber #mobile_resend_otp_form')[0],new_phonum_callback);");
				splitField.createElement('viewmore_phonenumber_otp',{
					"splitCount":otp_length,					// No I18N
					"charCountPerSplit" : 1,		// No I18N
					"isNumeric" : true,				// No I18N
					"otpAutocomplete": true,		// No I18N
					"customClass" : "customOtp",	// No I18N
					"inputPlaceholder":'&#9679;'	// No I18N
				});
				$('#viewmore_phonenumber_otp #viewmore_phonenumber_otp_full_value').attr('data-validate','zform_field');
				$('#viewmore_phonenumber_otp #viewmore_phonenumber_otp_full_value').attr('name','otp_code');
				$('#viewmore_phonenumber_otp .customOtp').attr('onkeypress','remove_error()');
				$("#view_all_phonenumber .web_email_specific_popup .inline_action").slideDown(300,function(){
					$('#viewmore_phonenumber_otp').click();
					resend_countdown("#phonenumber_web_more #emailOTP_resend");//No I18N 
				});
			});
			if(resp.status_code == 201 && resp.code == 'MOB200') {
				cryptData = resp.phone.encrypted_data;
			}
		}
	}
	payload.POST("self","self").then(successCallback, //No I18N
	function(resp)
	{
		removeButtonDisable($("#phonenumber_web_more .inline_action"));
		function errHandler(err) {
			if(err.cause && err.cause.trim() === "invalid_password_token") {
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + err.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			} else {
				showErrorMessage(getErrorMessage(err));
			}
		}
		if (handleCaptcha().isRequired(resp)) {
			handleCaptcha(resp, {
				backBtn: !hasViewMore,
				callbacks: {
					relogin: errHandler,
					beforeInit: function() {
						if(!hasViewMore) {
							$('#popup_mobile_action').remove();
							$('#common_popup .popuphead_define').text(''); //No I18N	
						}
					}
				}
			}).init(!hasViewMore ? '#verify_mobile_captcha' : '#view_all_phonenumber .web_email_specific_popup .inline_action', payload, ["self","self"]).then(successCallback,function(e){ //No I18N
				if(!hasViewMore) {
					showVerifyMobileNum(c_code,mobilenum,ele_id);
				}
				if(e) {
					errHandler(e)
				}
			});
		} else {
			errHandler(resp);
		}
	});	
}

// resend the otp for email confirmation


function emailOTP_resendcode(ele)
{
	if(!$(ele).find('a').hasClass("resend_otp_blocked"))//countdown is over
	{
		var emid=	$(ele).parents("form").find('input[name="email_id"]').val();	
		if(emid!="")
		{	
			var parentContainer = "#add_email_popup";	//No I18N
			if($('#Email_popup_for_mobile').is(":visible")){parentContainer = "#Email_popup_for_mobile"}	//No I18N
			else if($('#emails_web_more').is(":visible")){parentContainer = ".web_email_specific_popup"}	//No I18N
			$(parentContainer+" .otp_resend").hide();
	    	$(parentContainer+" #otp_sent").show().addClass("otp_sending").html(OTP_sending);
			var parms= {};
			var payload = Email.create(parms);
			payload.PUT("self","self", cryptData).then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				if($('#Email_popup_for_mobile').is(":visible")){
					resend_countdown("#Email_popup_for_mobile #emailOTP_resend");//No I18N 
				}
				else if($('#emails_web_more').is(":visible")){
					resend_countdown(".web_email_specific_popup #emailOTP_resend");//No I18N 
				}
				else{					
					resend_countdown("#add_email_popup #emailOTP_resend");//No I18N 
				}
				setTimeout(function(){
					$(parentContainer+" #otp_sent").removeClass("otp_sending").html(OTP_resent);
				},500);
				setTimeout(function(){
					if($("#emailOTP_resend a").hasClass("resend_otp_blocked")){
						$(parentContainer+" #emailOTP_resend").show();					
					}
					else{$(parentContainer+" .otp_resend").show()}
					$(parentContainer+" #otp_sent").hide();
				},2000);
			},
			function(resp)
			{
				$(parentContainer+" .otp_resend").show()
		    	$(parentContainer+" #otp_sent").hide();
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
}


//for view more in emails

function for_mobile_specific_email(id)
{
	if(isMobile) {	
		remove_error();			
		if(!$("#emails_web_more").is(":visible")){
			popup_blurHandler("6");
		} else {
			popup_blurHandler("8");
		}		
		$("#Email_popup_for_mobile").show(0,function(){
			$("#Email_popup_for_mobile").addClass("pop_anim bottom_modal"); 
		});
		$(".mob_popu_btn_container").show();
		$(".option_container").hide();
		$(".mob_popu_btn_container button").hide();
		var email = $("#"+id+" .emailaddress_text").first().text();
		$('.profile_tags_wrapper .profile_info_tags').addClass('hide');
		
		$("#Email_popup_for_mobile .popuphead_details").html($("#"+id).html());
		$("#Email_popup_for_mobile .popuphead_details").find("#prim_tap_to_more").remove();
		$("#Email_popup_for_mobile .popuphead_details").find("#secondary_tap_to_more").remove();
		$("#Email_popup_for_mobile .popuphead_details").find(".emailaddress_text").css("font-size","16px"); //No I18N
		$("#Email_popup_for_mobile").focus();
		
		if($("#"+id+" .email_info #PrimConfim").is(':visible')){
			show_mob_conform('email_resend',formatMessage(em_resend_conf,email), false); //No I18N
			closePopup(close_for_mobile_specific,"Email_popup_for_mobile");//No I18N
			return;
		}
		var recoveryTxt = $("#"+id+" .recovery_tag .profile_tags_tooltip_heading").text();
		var primaryTxt = $("#"+id+" .primary_tag .profile_tags_tooltip_heading").text();
		if($("#"+id+" .action_icons_div").children().hasClass("icon-Primary")){
			$("#btn_to_chng_primary").show();
			$("#btn_to_chng_primary").attr("onclick","show_mob_conform('email_primary','"+formatMessage(i18nkeys["IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION"],email)+"')");//No I18N
			if(recoveryTxt) {
				$('.profile_tags_wrapper .profile_info_tags.recovery_tag .inf_txt').text(recoveryTxt);
				$('.profile_tags_wrapper .profile_info_tags.recovery_tag').removeClass('hide');	
			}		
		} else {
			if(recoveryTxt) {
				$('.profile_tags_wrapper .profile_info_tags.recovery_tag .inf_txt').text(recoveryTxt);
				$('.profile_tags_wrapper .profile_info_tags.recovery_tag').removeClass('hide');	
			}
			if(primaryTxt) {
				$('.profile_tags_wrapper .profile_info_tags.primary_tag .inf_txt').text(primaryTxt);
				$('.profile_tags_wrapper .profile_info_tags.primary_tag').removeClass('hide');	
			}
		}
		if($("#"+id+" .action_icons_div .icon-delete").css('display') != 'none'){
			showMobViewEmailDeleteBtn(email);
		}
		/*if($("#"+id+" .action_icons_div").children().hasClass("icon-delete")){
			$("#btn_to_delete").show();
			$("#btn_to_delete").attr("onclick","show_mob_conform('email_delete','"+formatMessage(err_email_sure_delete1,email)+"')");
			$("#btn_to_delete span:last-child").text(i18nkeys["IAM.CONFIRM.POPUP.EMAIL"]);//No I18N
		}*/
		if($("#"+id+" .email_info #secondary_unconfirmed").is(':visible')){ 
		   $('.profile_tags_wrapper .profile_info_tags').addClass('hide');
			$("#btn_to_resend").show();
			$("#btn_to_resend").attr("onclick","show_mob_conform('email_resend','"+formatMessage(em_resend_conf,email)+"')");
		}
		/*if($("#"+id+" .action_icons_div").children().hasClass("verify_icon")){
			$('.profile_tags_wrapper .profile_info_tags').addClass('hide');
			$("#btn_to_resend").show();
			$("#btn_to_resend").attr("onclick","show_mob_conform('email_resend','"+formatMessage(em_resend_conf,email)+"')");
		}*/
		if(hasOneEmailNoOtherRecovery()){
			$("#btn_to_delete").hide();
		}
		else{
			showMobViewEmailDeleteBtn(email);
		}		
		closePopup(close_for_mobile_specific,"Email_popup_for_mobile");//No I18N
	}
}

function showMobViewEmailDeleteBtn(email){
	$("#btn_to_delete").show();
	var emailDeleteMsg = profile_data.primary_email == email ? err_email_sure_delete_prim : err_email_sure_delete1;
	$("#btn_to_delete").attr("onclick","show_mob_conform('email_delete','"+formatMessage(emailDeleteMsg,email)+"')");
	$("#btn_to_delete span:last-child").text(i18nkeys["IAM.CONFIRM.POPUP.EMAIL"]);//No I18N
}


function closeview_all_email_view()
{
	$("#view_all_phonenumber").html("");
	popupBlurHide("#emails_web_more", function() { //No I18N
		adjust_email_width();
	});   
	goback_mob();
	$(".blue").unbind(); //No I18N
}

function show_all_emails()
{
	remove_error();
	tooltip_Des(".field_email .action_icon");//No I18N
	$(".resend_options").hide();
		goback_mob();
		if($("#emailID_prim").hasClass("hide")) {
			$("#view_all_email").html($(".emailID_sec").html()); //load into popuop
		} else {
			$("#view_all_email").html($(".emailID_prim").html() + $(".emailID_sec").html()); //load into popuop
		}
		popup_blurHandler('6')
		

		$("#emails_web_more").show(0,function(){
			$("#emails_web_more").addClass("pop_anim");
		});
		$("#view_all_email .extra_emailids").show();
//		$("#view_all_email .viewmore").hide();
		$("#view_all_email").show();
		$("#specific_emailID").hide();
		

	
		
		if(isMobile)
		{
			$("#view_all_email .email_hover_show").remove();
			$("#view_all_email .profile_tags").remove();
		}
		else
		{
			$("#view_all_email .primary").removeAttr("onclick");
			$("#view_all_email .secondary").removeAttr("onclick");
			$("#view_all_email #prim_em_verify_now_0").removeAttr("onclick");
			$("#view_all_email .verify_now_text").removeAttr("onclick");//No I18N
			$("#view_all_email .field_email .action_icons_div span").removeAttr("onclick");
			$("#view_all_email .field_email .action_icons_div span, #view_all_email #prim_em_verify_now_0, #view_all_email .verify_now_text").click(function(){
				
				var id=$(this).attr('id');
				var id_num=parseInt(id.match(/\d+$/)[0], 10);
				if($("#view_all_email #"+id).hasClass("selected_icons"))
				{
					return;
				}
				if(id!="em_icon_resend_"+id_num){
					if($("#"+id).attr("onclick"))
					{
						var args=$("#"+id).attr("onclick").split(",");
					}
					else
					{
						var args=$("#"+id).attr("onmouseover").split(",");
					}
				}
				else{
					if($("#"+id).find(".resend_grn_btn").attr("onclick"))
					{
						var args=$("#"+id).find(".resend_grn_btn").attr("onclick").split(",");
					}
					else
					{
						var args=$("#"+id).find(".resend_grn_btn").attr("onmouseover").split(",");
					}
				}
				var prev_num;
				if($("#view_all_email .inline_action").length)
				{
					prev_num = $("#view_all_email .inline_action").parents(".field_email").attr("id");
					prev_num = parseInt(prev_num.match(/\d+$/)[0], 10);

					if(prev_num == id_num)
					{
						$("#emailID_num_"+id_num+" .inline_action").slideUp(300);
					}
				}
				
				
				$("#view_all_email .action_icons_div").removeClass("show_icons");
				$("#view_all_email .field_email .action_icons_div span,#view_all_email #prim_em_verify_now_0,#view_all_email .verify_now_text").removeClass("selected_icons");
				if(id=="em_icon_resend_"+id_num || id == "prim_em_verify_now_"+id_num || id == "secondary_verify_now_"+id_num)
				{
					
					var emailID = $("#"+id).parents(".field_email").find(".emailaddress_text").html();
					var count=args[1].split(")")[0].replace(/'/g,'');
					
					$("#view_all_email #emailID_num_"+id_num+" .action_icons_div").addClass("show_icons");
					
					$("#view_all_email #"+id).addClass("selected_icons");
					
					$("#view_all_email #emailID_num_"+id_num).append('<div class="inline_action"></div>');
					if($("#view_all_email #emailID_num_"+id_num+" .inline_action").length==2)
					{
						var conf_ele = $("#view_all_email #emailID_num_"+id_num+" .inline_action" )[1];
					}
					else
					{
						var conf_ele=$("#view_all_email #emailID_num_"+id_num+" .inline_action" );
					}
					
					
					$(conf_ele).html('<div class="inline_action_discription">'+formatMessage(em_resend_conf, emailID)+'</div>');
					
					if(id == "prim_em_verify_now_"+id_num || id == "secondary_verify_now_"+id_num){
						$(conf_ele).append('<button id="delete_specific_email" class="primary_btn_check inline_btn nobottom_margin_btn delete_btn" onclick="resendConfirmation(\''+emailID+'\');">'+i18nkeys["IAM.EMAIL.CONFIRMATION.SEND.EMAIL"]+'</button>'); //No I18N
					}
					else{
						$(conf_ele).append('<button id="delete_specific_email" class="primary_btn_check inline_btn nobottom_margin_btn delete_btn" onclick="resendConfirmation(\''+emailID+'\');">'+$("#resend_"+id_num+" .resend_grn_btn").html()+'</button>');
					}					
					
				}			
				else if(id=="em_icon_MKprim_"+id_num)
				{
					
					
					var element=args[0].split("(")[1].replace(/'/g,'');
					var action=args[1].split(")")[0].replace(/'/g,'');
					
					

					
					$("#view_all_email #emailID_num_"+id_num+" .action_icons_div").addClass("show_icons");
					
					$("#view_all_email #"+id).addClass("selected_icons");
					
					
					
					
					
					$('#selectedemail').prop("readonly", false);
					
					$("#view_all_email #emailID_num_"+id_num).append('<div class="inline_action"></div>');
					
					if($("#view_all_email #emailID_num_"+id_num+" .inline_action").length==2)
					{
						var prim_ele = $("#view_all_email #emailID_num_"+id_num+" .inline_action" )[1];
					}
					else
					{
						var prim_ele = $("#view_all_email #emailID_num_"+id_num+" .inline_action" );
					}
					$(prim_ele).append('<div class="inline_action_discription">'+formatMessage(i18nkeys["IAM.PROFILE.EMAILS.MAKE.PRIMARY.DESCRIPTION"],$("#view_all_email #emailID_num_"+id_num+" .emailaddress_text").text())+'</div>');
					$(prim_ele).append($("#change_primaryEM #change_em_form").html());//load into popuop
					$("#view_all_email #emailID_num_"+id_num+" .inline_action #Changeemailform" ).attr("id","ViewallChangeemailform");
					$("#view_all_email #emailID_num_"+id_num+" .inline_action #ViewallChangeemailform").attr("name","Viewall"+action);
					$('#view_all_email #emailID_num_'+id_num+' .inline_action #mkprim_email_action').attr("onclick","changePrimary(document.ViewallsetAsPrimary,changed_primaryemail);");
					$("#view_all_email #emailID_num_"+id_num+" .inline_action #selectedemail").val($("#"+element).html());
					$("#view_all_email #emailID_num_"+id_num+" .inline_action #selectedemail").attr("readonly","readonly");
					control_Enter(".blue"); //No I18N
					control_Enter(".inline_action a"); //No I18N
				}
				else if(id=="em_icon_delete_"+id_num)
				{
					var emailid= $("#emailID_num_"+id_num+" .emailaddress_text").html();
						
						$("#view_all_email #emailID_num_"+id_num+" .action_icons_div").addClass("show_icons");
						$("#view_all_email #"+id).addClass("selected_icons");
						$("#view_all_email #emailID_num_"+id_num).append('<div class="inline_action"></div>');
						
						if($("#view_all_email #emailID_num_"+id_num+" .inline_action").length==2)
						{
							var deleteele=$("#view_all_email #emailID_num_"+id_num+" .inline_action" )[1];
						}
						else
						{
							var deleteele=$("#view_all_email #emailID_num_"+id_num+" .inline_action" );
						}
						if(id_num == 0) {
							$(deleteele).html('<div class="inline_action_discription">'+formatMessage(err_email_sure_delete_prim, emailid)+'</div>');
						} else {
							$(deleteele).html('<div class="inline_action_discription">'+formatMessage(err_email_sure_delete1, emailid)+'</div>');
						}
						if(!$("#view_all_email #emailID_num_"+id_num+" .linked_email_tag").hasClass("hide") && $(deleteele).find(".link_eml_del").length == 0) { //If this is a linked email id, we need to show note in desc
							$(deleteele).append("<span class='link_eml_del'></span>");
							$(deleteele).find(".link_eml_del").html(linked_email_del);
						}
						$(deleteele).append('<button id="delete_specific_email" class="primary_btn_check inline_btn nobottom_margin_btn delete_btn delete_btn_color">'+i18nkeys["IAM.DELETE"]+'</button>');
						$("#delete_specific_email").unbind();
						$("#view_all_email #emailID_num_"+id_num+" .inline_action #delete_specific_email").click(function(){	
				        		new URI(Email,"self","self",emailid).DELETE().then(function(resp)	//No I18N
				    					{
				    						delete_email_callback(resp,emailid);
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
						});
				}
				if(prev_num!=undefined)
				{
					if(prev_num != id_num)
					{
						$("#view_all_email .field_email").removeClass("web_email_specific_popup");
						
						$("#emailID_num_"+prev_num+" .inline_action").slideUp(300,function(){
							$("#emailID_num_"+prev_num+" .inline_action").remove();
						});
						$("#view_all_email #emailID_num_"+id_num+" .inline_action" ).slideDown(300,function(){
						});
					}
					else
					{
						var previous=$("#emailID_num_"+prev_num+" .inline_action")[0];
						var newele=$("#emailID_num_"+prev_num+" .inline_action")[1];
						$(previous).slideUp(300,function(){
							$(newele).slideDown(300,function(){
								$(previous).remove();
							});
							
						});
					}
				}
				else
				{
						$("#view_all_email #emailID_num_"+id_num+" .inline_action" ).slideDown(300,function(){
						});
						
				}
				$("#view_all_email #emailID_num_"+id_num).addClass("web_email_specific_popup");
			});
		}
		tooltipSet("#emails_web_more .action_icon");//No I18N
		tooltipSet(".field_email .action_icon");	//No I18N
		$("#emails_web_more").focus();
		adjust_email_width();
		closePopup(closeview_all_email_view,"emails_web_more");//No I18N
}

if(isMobile)
{
	$("#countNameAddDiv option").click(function()
	{
		$("#countNameAddDiv option:selected").text().split('(')[1].split(')')[0];
		return false;
	});
	
	$("#countNameAddDiv option").bind(function(e)
	{
		$("#countNameAddDiv option:selected").text().split('(')[1].split(')')[0];
		return false;
	});
}

function load_phonedetails(policies,phoneDetail)
{
	if(de("phone_exception"))
	{
		$("#phone_exception").remove();
		$("#no_phnum_add_here").removeClass("hide");
	}
	if(phoneDetail.exception_occured!=undefined	&&	phoneDetail.exception_occured)
	{
		$( "#phnum_box .box_info" ).after("<div id='phone_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#phone_exception #reload_exception").attr("onclick","reload_exception(PHONE,'phnum_box')");
		$("#no_phnum_add_here").addClass("hide");
		return;
	}
	tooltip_Des(".field_mobile .action_icon");//No I18N

		if(jQuery.isEmptyObject(phoneDetail))
		{
		      $("#no_phnum_add_here").removeClass("hide");
		      $(".phone_number_content").addClass("hide");
		      if(phoneDetail.block_add_recovery){
		    	  $("#no_phnum_add_here #add_mob_number_state").hide();
		    	  $("#no_phnum_add_here #disabled_add_recovery").show();
		      }
		      else{
		    	  $("#no_phnum_add_here #add_mob_number_state").show();
		    	  $("#no_phnum_add_here #disabled_add_recovery").hide();
		      }
		      $("#phone_add_view_more").addClass("hide");
		      $(".separate_addnew").hide();
		      
	    	  $("#add_newnobackup").show();
		}
		else
		{
			$("#no_phnum_add_here").addClass("hide");
			$(".phone_number_content").removeClass("hide");
			
			
			if(!jQuery.isEmptyObject(phoneDetail.tfa))
		    {
		      $('#backupnumber').find('option').remove();
		      var tfa_num = Object.keys(phoneDetail.tfa);
		      for(i=0;i<tfa_num.length;i++)
		      { 
		    	  var number= phoneDetail.tfa[tfa_num[i]];
		    	  $('#backupnumber').append($("<option></option>").attr("value",tfa_num[i]).text(phonePattern.setMobileNumFormat(number.display_number)));
		      }
	    	  $("#add_newnobackup").show();
	    	  if(	jQuery.isEmptyObject(phoneDetail.recovery)	&&	jQuery.isEmptyObject(phoneDetail.unverfied)	&& jQuery.isEmptyObject(phoneDetail.tfa))
	    	  {
	    		  $("#no_phnum_add_here").removeClass("hide");
			      $(".phone_number_content").addClass("hide");
			      if(phoneDetail.block_add_recovery){
			    	  $("#no_phnum_add_here #add_mob_number_state").hide();
			    	  $("#no_phnum_add_here #disabled_add_recovery").show();
			      }
			      else{
			    	  $("#no_phnum_add_here #add_mob_number_state").show();
			    	  $("#no_phnum_add_here #disabled_add_recovery").hide();
			      }
	    	  }
		    }
			else
			{
		    	  $("#add_newnobackup").show();
			}
			
	      //Recovery Numbers
			var sec_count=0;
			if(profile_data.login_mobile!=undefined)
			{
				sec_count++;
			}
			
			if(login_mobile=="")
	    	{
		    	if(profile_data.login_mobile!=undefined)
		    	{
		    		login_mobile=profile_data.login_mobile.split("-")[1]
		    	}
	    	}
			var swap_num_popup_body = $("#profile_popup").html();
			
			if(!jQuery.isEmptyObject(phoneDetail.recovery))
		    {
		      var phnum =timeSorting(phoneDetail.recovery);	      
		      if(primary_email==undefined)
		      {
		        $("#tfa_phonenumber_password .blue").hide();
		        $("#phonenumber_password .blue").hide();
		      }
		      else
		      {
		    	  $("#tfa_phonenumber_password .blue").show();
			        $("#phonenumber_password .blue").show();
		      }
		      
		      $(".phone_number_content").removeClass("hide");
		      $("#no_phnum_add_here").addClass("hide");
		      var primary_exist=false;
		      $('#editscreenname').find('option').remove();
		      $(".phonenumber_prim").addClass("hide");
		      $(".phonenumber_sec").html("");
		      var del_onclick;
		      for(i=0;i<phnum.length;i++)
		      { 
		    	var current_phone=phoneDetail.recovery[phnum[i]];
		    	if(current_phone.mobile==login_mobile)
		        {
		    		if(current_phone.mode == 0) {
		    			$("#mobile_num_0 .primary_tag").removeClass("hide");
		    			$("#mobile_num_0 .recovery_tag").removeClass("hide");
		    			$("#mobile_num_0 .mfa_tag").addClass("hide");
		    		}
		            primary_exist=true;
		            $(".phonenumber_prim").removeClass("hide");
		            $("#primary_mobid").html(phonePattern.setMobileNumFormat(current_phone.display_number));
		            $("#prim_mob_time").html(current_phone.created_time_elapsed);
		            $("#mobile_num_0 .mobile_dp").addClass(color_classes[gen_random_value()]);
		          
		            
		            //unset login remove number
		            $("#mobile_num_0 .remove_cta").attr("onclick","unset_login_number('"+ login_mobile +"') ");
		            $("#mobile_num_0 .action_icons_div_ph #swap_number").attr("id",'ph_icon_sawpNum_0');//No i18N
		            
		            if(phoneDetail.motp_allowed_by_org)
	          		{
		          		$("#mobile_num_0 .action_icons_div_ph #ph_icon_sawpNum_0").removeClass("hide");//No i18N
		          		$("#ph_icon_sawpNum_0").attr("onclick","swap_mfa_recovery_numbers_popup(0,\'"+current_phone.display_number+"\',\'"+current_phone.created_time_elapsed+"\',\'recoveryNum\',\'phnNum_type\')");
	          		} else {
	          			$("#mobile_num_0 .action_icons_div_ph #ph_icon_sawpNum_0").addClass("hide");//No i18N
	          		}
		            
		            if(isMobile)
		            {
		              $("#phonenumber_info0").addClass("hide");
		            }
		            if(phnum.length<=1)
		            {
		              $("#ph_icon_edit_0").hide();
		            }
		            else
		            {
		            	$("#ph_icon_edit_0").show();
		            }
		            if(de("ph_icon_delete_0")	&& isEmailId(profile_data.primary_email))
		            {
		            	$("#ph_icon_delete_0").show();
		            	$("#ph_icon_delete_0").attr("onclick", "deleteMobile('"+i18nMobkeys['IAM.CONFIRM.POPUP.PHONENUMBER']+"',)");
		            	del_onclick = $("#ph_icon_delete_0").attr("onclick");
			          	del_onclick = del_onclick.split(",");
			          	if(del_onclick.length == 1) {
			          		del_onclick = $("#ph_icon_delete_0").attr("onclick");
			          		del_onclick = del_onclick.split(");");
			          	} 
			          	del_onclick[0] = del_onclick[0].split(");");
			          	del_onclick[0]+=",'"+phonePattern.setMobileNumFormat(current_phone.display_number)+"');";
		            	$("#ph_icon_delete_0").attr("onclick",del_onclick[0]);
		            }	
		            else{
						$("#ph_icon_delete_0").hide();
		            	$("#ph_icon_delete_0").attr("onclick",'');
		            }	    	   
		        }
		        else
		        {
		        	sec_count++;
		          	secondary_format = $("#empty_phone_format").html();
		            $('#editscreenname').append($("<option></option>").attr("value",phnum[i]).text(phonePattern.setMobileNumFormat(current_phone.display_number)));
	
		          	$(".phonenumber_sec").append(secondary_format);
		          	$(".phonenumber_sec #sec_phoneDetails").attr("id","mobile_num_"+sec_count);
		          	
		          	if(sec_count > 3)
		          	{
		          		$("#mobile_num_"+sec_count).addClass("extra_phonenumbers"); 
		          	}
		          	$("#mobile_num_"+sec_count).attr("onclick","for_mobile_specific('mobile_num_"+sec_count+"') "); 
		          	
		          	$("#mobile_num_"+sec_count+" .mobile_info .emailaddress_text").html(phonePattern.setMobileNumFormat(current_phone.display_number));
		          	$("#mobile_num_"+sec_count+" .mobile_info .emailaddress_addredtime").html(current_phone.created_time_elapsed);
		          	$("#mobile_num_"+sec_count+" #phonenumber_infohover").attr("id",'phonenumber_info'+sec_count);
		          	var onclick;
		          	$("#mobile_num_"+sec_count+" .action_icons_div_ph #icon-primary").attr("id",'ph_icon_MKprim_'+sec_count);//No i18N
		          	$("#mobile_num_"+sec_count+" .action_icons_div_ph #swap_number").attr("id",'ph_icon_sawpNum_'+sec_count);//No i18N
		          	if(phoneDetail.motp_allowed_by_org)
	          		{
		          		$("#mobile_num_"+sec_count+" .action_icons_div_ph #ph_icon_sawpNum_"+sec_count).removeClass("hide");//No i18N
	          		} else {
	          			$("#mobile_num_"+sec_count+" .action_icons_div_ph #ph_icon_sawpNum_"+sec_count).addClass("hide");//No i18N
	          		}
		          	if(profile_data.Policies.CHANGE_PRIMARY_EMAIL==true)
	          		{
		          		$("#mobile_num_"+sec_count+" .action_icons_div_ph #ph_icon_MKprim_"+sec_count).removeClass("hide");//No i18N
	          		} else {
	          			$("#mobile_num_"+sec_count+" .action_icons_div_ph #ph_icon_MKprim_"+sec_count).addClass("hide");//No i18N
	          		}
		          	
		          	onclick = $("#ph_icon_MKprim_"+sec_count).attr("onclick");
		          	onclick=onclick.split(");");
		          	onclick[0]+=",'"+current_phone.display_number+"','editPrimary','sec_count','recovery');"
		          	$("#ph_icon_MKprim_"+sec_count).attr("onclick",onclick[0]);
		          	$("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-delete").attr("id",'ph_icon_delete_'+sec_count);//No i18N
		          	del_onclick = $("#ph_icon_delete_"+sec_count).attr("onclick");
		          	del_onclick = del_onclick.split(");");
		          	del_onclick[0]+=",'"+phonePattern.setMobileNumFormat(current_phone.display_number)+"');";
		          	$("#ph_icon_delete_"+sec_count).attr("onclick",del_onclick[0]);
		          	$("#ph_icon_sawpNum_"+sec_count).attr("onclick","swap_mfa_recovery_numbers_popup(\'"+sec_count+"\',\'"+current_phone.display_number+"\',\'"+current_phone.created_time_elapsed+"\',\'recoveryNum\',\'phnNum_type\')");
		        }
		    	$("#mobile_num_"+sec_count+" .mobile_dp").addClass(color_classes[gen_random_value()]);
		    	$("#mobile_num_"+sec_count+" .mfa_tag").remove();
		      }
	    	} else {
	    		$(".phonenumber_sec").html("");
	    	}
	      
	      if(!jQuery.isEmptyObject(phoneDetail.unverfied))
		  {	   
	    	  $(".phonenumber_unverfied").html("");
	    	  $(".phone_number_content").removeClass("hide");
		      //unverfied numbers
		      var unv_phnum = timeSorting(phoneDetail.unverfied);	  
		      for(i=0;i<unv_phnum.length;i++)
		      { 
			    	var current_phone=phoneDetail.unverfied[unv_phnum[i]];
			    	sec_count++;
	  	          
			    	secondary_format = $("#empty_phone_format").html();
		          	$(".phonenumber_unverfied").append(secondary_format);
		        	$(".phonenumber_unverfied #sec_phoneDetails").attr("id","mobile_num_"+sec_count);
		        	
		        	if(sec_count > 3)
		        	{
		        		$("#mobile_num_"+sec_count).addClass("extra_phonenumbers"); 
		        	}
		        	
		        	
		        	$("#mobile_num_"+sec_count).attr("onclick","for_mobile_specific('mobile_num_"+sec_count+"') "); 
		        	
		            $("#mobile_num_"+sec_count+" .mobile_dp").addClass(color_classes[gen_random_value()]);
		            $("#mobile_num_"+sec_count+" .mobile_info .emailaddress_text").html(phonePattern.setMobileNumFormat(current_phone.display_number));
					$("#mobile_num_"+sec_count+" .mobile_info .verify_now_text").attr("onclick",'showVerifyMobileNum(\''+current_phone.country_code+'\',\''+current_phone.mobile+'\',\''+sec_count+'\')'); //No i18N
					$("#mobile_num_"+sec_count+" .mobile_info .verify_now_text").attr("id",'unverified_mobile_'+sec_count); //No i18N
		            $("#mobile_num_"+sec_count+" .mobile_info .emailaddress_addredtime").addClass("red"); 
		            $("#mobile_num_"+sec_count+" #phonenumber_infohover").attr("id",'phonenumber_info'+sec_count);
	
		            $("#mobile_num_"+sec_count+" .action_icons_div_ph #icon-primary").remove();
		            $("#mobile_num_"+sec_count+" .action_icons_div_ph #swap_number").remove();
		            $("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-edit").remove();
		          
		            $("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-delete").attr("id",'ph_icon_delete_'+sec_count);//No i18N
		            del_onclick = $("#ph_icon_delete_"+sec_count).attr("onclick");
		          	del_onclick = del_onclick.split(");");
		          	del_onclick[0]+=",'"+phonePattern.setMobileNumFormat(current_phone.mobile,current_phone.country_code)+"');";
		            $("#ph_icon_delete_"+sec_count).attr("onclick",del_onclick[0]);
		            $("#mobile_num_"+sec_count+" .profile_tags").remove();
		            if(isMobile){
						$("#mobile_num_"+sec_count+" .mobile_info #unverified_tap_to_more").removeClass("hide");
					}
					else{
						$("#mobile_num_"+sec_count+" .mobile_info .verify_now_text").removeClass("hide");
					}
		      }
		  } else {
	    		$(".phonenumber_unverfied").html("");
		  }
	      
	      if(!jQuery.isEmptyObject(phoneDetail.tfa) || phoneDetail.tfa !== undefined) {
	    	  $(".phonenumber_tfa").html("");
	    	  $(".phone_number_content").removeClass("hide");
	    	  //tfa numbersc
	    	  var tfa_phnum = timeSorting(phoneDetail.tfa);
	    	  disable_phoneNum_type = phoneDetail.is_tfa_enabled == true ? "" : "mfa"; //NO I18N
	    	  
		      for(i=0;i<tfa_phnum.length;i++) {
		    	  var current_phone=phoneDetail.tfa[tfa_phnum[i]];	
		    	  if(phoneDetail.tfa[tfa_phnum[i]].is_primary && phoneDetail.pref_mfa_mode == "SMS" && phoneDetail.is_tfa_enabled) {
		    		  preferred_mfa_num = phoneDetail.tfa[tfa_phnum[i]].mobile;
		    	  } else if (!phoneDetail.is_tfa_enabled || phoneDetail.pref_mfa_mode != "SMS") { //NO I18N
		    		  preferred_mfa_num = ""; //NO I18N
		    	  }
		    	  
		          if(current_phone.mobile==login_mobile)  //if mfa number and login number are the same
			      {
		    		if(current_phone.mode == 1) {
		    			$("#mobile_num_0 .primary_tag").removeClass("hide");
		    			$("#mobile_num_0 .mfa_tag").removeClass("hide");
		    			$("#mobile_num_0 .recovery_tag").addClass("hide");
		    		}
		    		if(profile_data.Phone.block_add_recovery == undefined){
			    		$("#mobile_num_0 .action_icons_div_ph #swap_number").attr("id",'ph_icon_sawpNum_0');//No i18N
			    		$("#ph_icon_sawpNum_0").removeClass("hide");//No i18N
			    		$("#ph_icon_sawpNum_0").attr("onclick","swap_mfa_recovery_numbers_popup(0,\'"+current_phone.display_number+"\',\'"+current_phone.created_time_elapsed+"\',\'mfaNum\',\'phnNum_type\')");
		    		}
		    		else{
		    			$("#mobile_num_0 .action_icons_div_ph #swap_number").addClass("hide");//No i18N
		    		}
		    		if(!phoneDetail.motp_allowed_by_org)
	          	    {
		    			$("#mobile_num_0 .mfa_tag").addClass("disabled_mfa_tag");//No i18N
		    			$("#mobile_num_0 .disabled_mfa_tag .set_as_recovery").attr("onclick", "setNumRecovery(\'"+current_phone.display_number+"\',swap_phnNum_callback)"); //NO I18N
		          		$("#mobile_num_0 .profile_tags .profile_tags_tooltip_desc").text(disabled_mfa_number);
		          		$("#mobile_num_0 .mfa_settings ").addClass("hide");//No i18N
		          		$("#mobile_num_0 .set_as_recovery").removeClass("hide");//No i18N
	          	    }
		    		
		    		primary_exist=true;
		            $(".phonenumber_prim").removeClass("hide");
		            $("#primary_mobid").html(phonePattern.setMobileNumFormat(current_phone.display_number));
		            $("#prim_mob_time").html(current_phone.created_time_elapsed);
		            $("#mobile_num_0 .mobile_dp").addClass(color_classes[gen_random_value()]);
		            
		          //unset login remove number
		            $("#mobile_num_0 .remove_cta").attr("onclick","unset_login_number('"+ login_mobile +"') ");
		            
		            if(isMobile)
		            {
		              $("#phonenumber_info0").addClass("hide");
		            }
		            
		            if(tfa_phnum.length<=1)
		            {
		              $("#ph_icon_edit_0").hide();
		            }
		            else
		            {
		            	$("#ph_icon_edit_0").show();
		            }
		            if(de("ph_icon_delete_0")	&& isEmailId(profile_data.primary_email))
		            {
		            	$("#ph_icon_delete_0").show();
						$("#ph_icon_delete_0").attr("onclick", "deleteTFAMobile()");
		            }	else {
						$("#ph_icon_delete_0").hide();
		            	$("#ph_icon_delete_0").attr("onclick",'');
		            }	
		            
			      } else {
			    	  
			      sec_count++;
			      secondary_format = $("#empty_phone_format").html();
		          $(".phonenumber_tfa").append(secondary_format);
		          $(".phonenumber_tfa #sec_phoneDetails").attr("id","mobile_num_"+sec_count);
			          
		          if(sec_count > 3)
		          {
		        	$("#mobile_num_"+sec_count).addClass("extra_phonenumbers"); 
		          }
		          		          
		          var onclick;
		          $("#mobile_num_"+sec_count+" .action_icons_div_ph #icon-primary").attr("id",'ph_icon_MKprim_'+sec_count);//No i18N
		          $("#ph_icon_sawpNum_"+sec_count).removeClass("hide");//No i18N
		          $("#mobile_num_"+sec_count+" .action_icons_div_ph #swap_number").attr("id",'ph_icon_sawpNum_'+sec_count);//No i18N
		          if(phoneDetail.block_add_recovery == undefined && phoneDetail.motp_allowed_by_org){
		        	  $("#ph_icon_sawpNum_"+sec_count).attr("onclick","swap_mfa_recovery_numbers_popup(\'"+sec_count+"\',\'"+current_phone.display_number+"\',\'"+current_phone.created_time_elapsed+"\',\'mfaNum\',\'phnNum_type\')");
		          }else{
		        	  $("#ph_icon_sawpNum_"+sec_count).addClass("hide");//No i18N
		    	  }
		      	  if(profile_data.Policies.CHANGE_PRIMARY_EMAIL==true)
		          {
		      		  onclick = $("#ph_icon_MKprim_"+sec_count).attr("onclick");
			          onclick=onclick.split(");");
			          onclick[0]+=",'"+current_phone.display_number+"','editPrimary','sec_count','mfaNum');"
			          $("#ph_icon_MKprim_"+sec_count).attr("onclick",onclick[0]);
		          }else{
		        	  $("#ph_icon_MKprim_"+sec_count).addClass("hide");//No i18N
		    	  }
	        	  if(!phoneDetail.motp_allowed_by_org)
	          	  {
	          		$("#mobile_num_"+sec_count+" .mfa_tag").addClass("disabled_mfa_tag");//No i18N
	          		$("#mobile_num_"+sec_count+" .disabled_mfa_tag .set_as_recovery").attr("onclick", "setNumRecovery(\'"+current_phone.display_number+"\',swap_phnNum_callback)"); //NO I18N
	          		$("#mobile_num_"+sec_count+" .profile_tags .profile_tags_tooltip_desc").text(disabled_mfa_number);
	          		$("#mobile_num_"+sec_count+" .mfa_settings ").addClass("hide");//No i18N
	          		$("#mobile_num_"+sec_count+" .set_as_recovery").removeClass("hide");//No i18N
	          	  }
		          $("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-delete").attr("id",'ph_icon_delete_'+sec_count);//No i18N
		          $("#ph_icon_delete_"+sec_count).attr("onclick", "deleteTFAMobile()");
		          $("#mobile_num_"+sec_count+" .mobile_dp").addClass(color_classes[gen_random_value()]);
		          $("#mobile_num_"+sec_count).attr("onclick","for_mobile_specific('mobile_num_"+sec_count+"') ");
		          $("#mobile_num_"+sec_count+" .mobile_info .emailaddress_text").html(phonePattern.setMobileNumFormat(current_phone.display_number));
		          $("#mobile_num_"+sec_count+" .mobile_info .emailaddress_addredtime").html(current_phone.created_time_elapsed);
		          $("#mobile_num_"+sec_count+" #phonenumber_infohover").attr("id",'phonenumber_info'+sec_count);
		          $("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-delete").attr("id",'ph_icon_delete_'+sec_count);//No i18N			      	
		          $("#mobile_num_"+sec_count+" .action_icons_div_ph .icon-edit").remove();
		          $("#mobile_num_"+sec_count+" .recovery_tag").remove();
			      }  
		      }
	      } else {
	    	  disable_phoneNum_type = phoneDetail.is_tfa_enabled == true ? "" : "mfa";
	    	  $(".phonenumber_tfa").html("");
	      }
	      if(!primary_exist)
	      {
	    	  $(".phonenumber_prim").addClass("no_primaryexist");
	      }	 
	      else
	      {
	    	  $(".phonenumber_prim").removeClass("no_primaryexist");
	      }
	      if(isMobile)
	      {
	        $(".phone_number_content .phnum_hover_show").addClass("hide");
	        $(".phone_number_content .profile_tags").addClass("hide");
	      }
	      $("#phnum_box .addnew").show();
	      $("#phone_add_view_more").show();
	      if((sec_count > 3 && !primary_exist)  ||  (primary_exist && sec_count > 3))
	      {
	    	  $("#addphoneonly").hide();
	      }

	      else
	      {
	    	  $("#phone_add_view_more").hide();
	    	if(jQuery.isEmptyObject(phoneDetail.recovery)		&&		jQuery.isEmptyObject(phoneDetail.unverfied)    &&    jQuery.isEmptyObject(phoneDetail.tfa))
	    	{
	    		$("#addphoneonly").hide();
	    		$("#no_phnum_add_here").removeClass("hide");
			      if(phoneDetail.block_add_recovery){
			    	  $("#no_phnum_add_here #add_mob_number_state").hide();
			    	  $("#no_phnum_add_here #disabled_add_recovery").show();
			      }
			      else{
			    	  $("#no_phnum_add_here #add_mob_number_state").show();
			    	  $("#no_phnum_add_here #disabled_add_recovery").hide();
			      }
	    	}
	    	else
	    	{
		        	if(phoneDetail.block_add_recovery){
		        		$("#addphoneonly").hide();
		        	}
	    	}

	      }
	      if(phoneDetail.block_add_recovery && (!jQuery.isEmptyObject(phoneDetail.recovery) || !jQuery.isEmptyObject(phoneDetail.unverfied) || !jQuery.isEmptyObject(phoneDetail.tfa))){
	    	  $("#phone_add_view_more #addphone").hide();
	    	  $(".phone_number_content .recovery_tag").remove();
	    	  $("#phone_add_view_more #view_only").removeClass("half");
    		  $(".phone_number_content .recovery_disabled_tag").css("display","flex");
	      }
	      else{
	    	  $(".phone_number_content .recovery_disabled_tag").hide();
	      }
	      if(sec_count>4)
	      {
	      	$("#phone_add_view_more .view_more").html(formatMessage(i18nMobkeys["IAM.VIEWMORE.NUMBER"],sec_count-3)); //NO I18N
	      }
	      else
	      {
	      	$("#phone_add_view_more .view_more").html(formatMessage(i18nMobkeys["IAM.VIEWMORE.NUMBERS"],sec_count-3)); //NO I18N
	      }
	    }
    if(!isMobile){
		tooltipSet(".field_mobile .action_icon");//No I18N
    }
}
function deleteTFAMobile(){

		var title = decodeHTML(i18nMobkeys["IAM.MFA.MOBILE.CANT.DELETE"]);
		var tempdiv = document.createElement("div");
		tempdiv.classList.add("popdesc"); //No i18N
		tempdiv.textContent = decodeHTML(i18nMobkeys["IAM.MFA.MOBILE.CANT.DELETE.DESC"]);
		var templink = document.createElement("div");
		templink.setAttribute("onclick", "loadTab('multiTFA','modes');"); //No i18N
		templink.addEventListener("click" , clos);
		templink.classList.add("loadlink"); //No i18N
		templink.textContent = i18nMobkeys["IAM.MFA.GO.TO.MFA.SETTINGS"];
		tempdiv.append(templink);
		show_confirm(title, tempdiv, function(){
			$("#confirm_popup #confirm_btns").show();
		},
		function(){
			setTimeout(function(){
				$(".confirm_pop_header .close_btn").remove();
				$("#confirm_popup #confirm_btns").show();
			},500)
		});
		$("#confirm_popup #confirm_btns").hide();
		var closediv = document.createElement("div");
		closediv.classList.add("close_btn"); //No i18N
		closediv.addEventListener("click" , clos);
		$("#confirm_popup .confirm_pop_header").append(closediv)

}
function clos(e){
	document.querySelector('#confirm_popup #confirm_btns .cancel_btn').click() //No i18N
}

//delete Mobile Number
function deleteMobile(title,mobile) 
{
	var alertmsg = err_mobile_sure_delete1;
	
	show_confirm(title,formatMessage(alertmsg, mobile),
		    function() 
		    {
				mobile = mobile.replace(mobile.split(" ")[0],"").replace(/[+ \[\]\(\)\-\.\,]/g,'');
	    		new URI(Phone,"self","self",mobile).DELETE().then(function(resp)	//No I18N
						{
	    					delete_phonum_callback(resp,mobile);
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
								if(resp.errors[0]!= undefined  && resp.errors[0].code=="MOB502"){
									showErrorMessage(formatMessage(getErrorMessage(resp),recoveryMandatoryHelpdoc));
								}
								else{
									showErrorMessage(getErrorMessage(resp));
								}
								
							}
						});
			},
		    function() 
		    {
		    	return false;
		    }
		);
	deleteBtnTextChange();
	$("#confirm_popup button:first").focus();
}


//unset login phone number 
function unset_login_number(login_phnNum) {	
	new URI(removeloginnumber,"self","self",login_phnNum).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				if(profile_data.Phone.block_add_recovery && profile_data.Phone.recovery){
					delete profile_data.Phone.recovery[login_mobile];
				}
				login_mobile='';
				delete profile_data.login_mobile;
				if($("#Email_popup_for_mobile").is(":visible")){
					close_for_mobile_specific();
				}
				load_phonedetails(profile_data.Policies,profile_data.Phone);
				load_emaildetails(profile_data.Policies,profile_data.Email);
				if($("#phonenumber_web_more").is(":visible")==true){
					tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
					$("#view_all_phonenumber").html("");
					goback_mob();
					show_all_phonenumbers();
				}
				return false;
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
				return false;
			});
}


function delete_phonum_callback(phObj,phnum)
{	

		SuccessMsg(getErrorMessage(phObj));
		if(profile_data.Phone.recovery != undefined && profile_data.Phone.recovery[phnum])
		{
			delete profile_data.Phone.recovery[phnum];
		}
		if(profile_data.Phone.unverfied != undefined && profile_data.Phone.unverfied[phnum])
		{
			delete profile_data.Phone.unverfied[phnum];
		}
		if(profile_data.Phone.tfa != undefined && profile_data.Phone.tfa[phnum])
		{
			delete profile_data.Phone.tfa[phnum];
		}
		if(profile_data.Phone.recovery != undefined && jQuery.isEmptyObject(profile_data.Phone.recovery))
		{
			delete profile_data.Phone.recovery;
		}
		if(profile_data.Phone.unverfied != undefined && jQuery.isEmptyObject(profile_data.Phone.unverfied))
		{
			delete profile_data.Phone.unverfied;
		}
		if(profile_data.Phone.tfa != undefined && jQuery.isEmptyObject(profile_data.Phone.tfa))
		{
			delete profile_data.Phone.tfa;
		}
		if(profile_data.login_mobile!=undefined		&&	profile_data.login_mobile.split("-")[1]==phnum){
			delete profile_data.login_mobile;
			login_mobile='';
			$("#em_icon_delete_0").hide();
			$("#em_icon_delete_0").attr("onclick","deleteEmail('"+i18nkeys['IAM.CONFIRM.POPUP.EMAIL']+"');");
			}
		load_phonedetails(profile_data.Policies,profile_data.Phone);
		if($("#phonenumber_web_more").is(":visible")==true){
			var phone_num_length = profile_data.Phone.recovery != undefined ? Object.keys(profile_data.Phone.recovery).length : 0 ;
			var unverified_length = profile_data.Phone.unverfied != undefined ? Object.keys(profile_data.Phone.unverfied).length :0 ;
			var tfa_num_length = profile_data.Phone.tfa != undefined ? Object.keys(profile_data.Phone.tfa).length :0 ;
			var lenn=phone_num_length+unverified_length+tfa_num_length;
			if(lenn>1){
				tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
				$("#view_all_phonenumber").html("");
				goback_mob();
				show_all_phonenumbers();
			}
			else{
				closeview_all_phonenumber_view();
			}
		}	
}

//make recovery as Primary Phone Number
function showmake_prim_mobilescreen(heading,description,button,number,action,sec_count,number_type)
{
	if(number_type == 'mfaNum' && !profile_data.Phone.allow_login_and_tfa) {
		showErrorMessage(tfa_not_allowed); //No I18N
	} else {
		set_popupinfo(heading,formatMessage(description, phonePattern.setMobileNumFormat(number)),true);
		$('#popup_mobile_action span').html(button);
		$("#popuphead_icon").attr('class','')
		$("#phonenumber_popup_contents form").attr("name",action);
		$('#popup_mobile_action').attr("onclick","changePrimaryPhonenum_popup(document."+action+", '"+ number +"',changeprim_phonum_callback,'"+number_type+"');");		
	
		$("#popup_action").css("margin-top", "0px");
		$("#select_phonenumber").hide();
		$("#phonenumber_password").show();
		$("#select_existing_phone").hide();
		$("#otp_phonenumber").hide();
		
		$("#empty_phonenumber_input_code").attr("readonly","readonly");
		$("#pop_action").html($("#phonenumber_popup_contents").html()); //load into popuop
		$("#empty_phonenumber_input_code").val(number);
		$("#empty_phonenumber_input").val(number.split(')')[1]);
		
		$("#phonenumber_popup_contents form").attr("name","");		
		control_Enter("a"); //No I18N
		control_Enter(".blue"); //No I18N
		$("#popup_mobile_action").focus();
		closePopup(close_popupscreen,"common_popup");//No I18N
	}
}

function swap_number_disable_check(phnNumber, phnNumber_type) {
	$(".swapNum_description_recovery .recovery_disabled_desc").hide();
	if(disable_phoneNum_type == "mfa" && phnNumber_type != "mfaNum") {
		//disable mfa option
		$("#mfaNum, #mfaNum_specific, #swap_mobile_action").prop("disabled", true);
		$("#swap_mobile_action").addClass("pref_disable_btn");
		$("#mfa_div").addClass("disable_pointer_events");
		$(".phnNum_warning, .recovery_warning").show();
		$(".mfa_warning").hide();
		$(".mfa_heading").addClass("swapNum_radiobtn_text_disable");
		$(".swapNum_description_mfa").addClass("swapNum_description_disable");
	}
	else if(phnNumber == preferred_mfa_num) {
		//disbale recovery option
		$("#recoveryNum, #recoveryNum_specific, #swap_mobile_action").prop("disabled", true);
		$("#swap_mobile_action").addClass("pref_disable_btn");
		$("#recovery_div").addClass("disable_pointer_events");
		$(".phnNum_warning, .mfa_warning").show();
		$(".recovery_warning").hide();
		$(".recovery_heading").addClass("swapNum_radiobtn_text_disable");
		$(".swapNum_description_recovery").addClass("swapNum_description_disable");
	}
	else {
		$(".swapNum_radiobtn, #swap_mobile_action").prop("disabled", false);
		$("#swap_mobile_action").addClass("pref_disable_btn");
		$("#swap_mobile_action").prop("disabled", true);
		$(".phnNum_warning, .recovery_warning, .mfa_warning").hide();
		$(".swapNum_radiobtn_text").removeClass("swapNum_radiobtn_text_disable");
		$(".swapNum_description").removeClass("swapNum_description_disable");
	}
}

function swap_mfa_recovery_numbers_popup(phn_icon_no, phnNum, phn_info, phnNumber_type, phnTypename) {
//	set_profile_popupinfo
	var init= function() {

		$("#"+phnNumber_type).prop("checked", true);
		$("#swap_mobile_action").addClass("pref_disable_btn");
		$("#swap_mobile_action").prop("disabled", true);
		$(".swapNum_radiobtn_div").removeClass("disable_pointer_events");
		$(".swapNum_radiobtn_div").change(function() {
			var phnType_val = $("input[name='"+phnTypename+"']:checked").val();
			if( phnNumber_type != phnType_val) {
				$("#swap_mobile_action").removeClass("pref_disable_btn");
				$("#swap_mobile_action").prop("disabled", false);
			} else {
				$("#swap_mobile_action").addClass("pref_disable_btn");
				$("#swap_mobile_action").prop("disabled", true);
			}
		});
		
		$("#profile_popup").addClass("default_popup");
		var phn_icon = $("#mobile_num_"+phn_icon_no).find(".mobile_dp").attr("class");
		$("#phn_details .mobile_dp").removeClass().addClass(phn_icon);
		$("#phn_details").find(".emailaddress_text").text(phonePattern.setMobileNumFormat(phnNum));
		$("#phn_details").find(".emailaddress_addredtime").text(phn_info);
		
		$("#profile_popup").show(0,function(){
			$("#profile_popup").addClass("pop_anim");
		});
		if(!$("#phonenumber_web_more").is(":visible")){
			popup_blurHandler("6");
		} else {
			popup_blurHandler("8");
		}
		$("#profile_popup").focus();
		closePopup(close_profile_popupscreen,"profile_popup"); //No I18N
		phnNum = phnNum.split(")")[1].replace(/'/g,'').trim();
		swap_number_disable_check(phnNum.trim(), phnNumber_type);
		if(profile_data.Phone.block_add_recovery){
			$("#recovery_div #recoveryNum, #swap_mobile_action").prop("disabled", true);
			$("#swap_mobile_action").addClass("pref_disable_btn");
			$("#recovery_div .swapNum_radiobtn_text").addClass("swapNum_radiobtn_text_disable");
			$("#recovery_div .swapNum_description").addClass("swapNum_description_disable");
			$("#recoveryNum,#mfaNum").prop("checked", false);
			$(".swapNum_description_recovery .recovery_disabled_desc").show();
		}
		$('#swap_mobile_action').attr("onclick","swap_numbers(document.swapnumber,'"+ phnNum +"','phnNum_type', swap_phnNum_callback);");
	};
	if($("#Email_popup_for_mobile").is(":visible")){
		close_for_mobile_specific(init);
	} else {
		init();
	}
}

function setNumRecovery(phnNum, callback) {
	var payload = MakeRecoveryPhone.create();
	var phoneNum=phnNum.split(")")[1].replace(/'/g,'').trim();

	payload.PUT("self","self",phoneNum).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		if($("#Email_popup_for_mobile").is(":visible")){
			close_for_mobile_specific();
		}
		callback(resp, phoneNum, "recoveryNum"); //NO I18N
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

function swap_numbers(form, phnNum, phnTypename, callback) {
	var phnType_val = $("input[name='"+phnTypename+"']:checked").val();
	
	if(phnType_val == "mfaNum") {
		var payload = makemfa.create();
	} else {
		var payload = MakeRecoveryPhone.create();
	}

	payload.PUT("self","self",phnNum).then(function(resp)	//No I18N
	{
		SuccessMsg(getErrorMessage(resp));
		callback(resp, phnNum, phnType_val);
		
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

function swap_phnNum_callback(response, phnNum, phnType_val) {
		if(phnType_val == "mfaNum") {
			if(profile_data.Phone.tfa != undefined) {
				profile_data.Phone.tfa[phnNum] = profile_data.Phone.recovery[phnNum];
				profile_data.Phone.tfa[phnNum].mode = 1;
				delete profile_data.Phone.recovery[phnNum];
			} else {
				profile_data.Phone.tfa = new Array();
				profile_data.Phone.tfa[phnNum] = profile_data.Phone.recovery[phnNum];
				profile_data.Phone.tfa[phnNum].mode = 1;
				delete profile_data.Phone.recovery[phnNum];
			}
		} else {
			if(profile_data.Phone.recovery != undefined) {
				profile_data.Phone.recovery[phnNum] = profile_data.Phone.tfa[phnNum];
				profile_data.Phone.recovery[phnNum].mode = 0;
				delete profile_data.Phone.tfa[phnNum];
			} else {
				profile_data.Phone.recovery = new Array();
				profile_data.Phone.recovery[phnNum] = profile_data.Phone.tfa[phnNum];
				profile_data.Phone.recovery[phnNum].mode = 0;
				delete profile_data.Phone.tfa[phnNum];
			}
		}	
		
		if(profile_data.Phone.recovery != undefined && jQuery.isEmptyObject(profile_data.Phone.recovery))
		{
			delete profile_data.Phone.recovery;
		}
		if(profile_data.Phone.tfa != undefined && jQuery.isEmptyObject(profile_data.Phone.tfa))
		{
			delete profile_data.Phone.tfa;
		}
		
		load_phonedetails(profile_data.Policies,profile_data.Phone);
		close_profile_popupscreen();
		if($("#phonenumber_web_more").is(":visible")==true) {
			tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
			$("#view_all_phonenumber").html("");
			goback_mob();
			show_all_phonenumbers();
		}
}

function editLoginName(f,callback)
{
	$('#'+f.id).find('input[name="phone_input_code"]').val(f.editscreenname.selectedOptions[0].text.trim());
	changePrimaryPhonenum(f,callback)
}

function changePrimaryPhonenum_popup(form, phnum,callback,number_type)
{
		phnum=phnum.split(") ")[1];
		phnum=phnum.trim();
		var payload = MakeLoginNumberPhone.create();
		payload.PUT("self","self",phnum).then(function(resp)	//No I18N
		{
			callback(resp,phnum,number_type);
			removeButtonDisable(form);
		},
		function(resp)
		{
			removeButtonDisable(form);
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
		
	return;
}


function changePrimaryPhonenum(form,callback,number_type)
{
	if(number_type == 'mfaNum' && !profile_data.Phone.allow_login_and_tfa) {
		showErrorMessage(tfa_not_allowed); //No I18N
	} else {	
	if(validateForm(form))
	{
		disabledButton(form);
		var phnum =$('#'+form.id).find('input[name="phone_input_code"]').val();
		phnum=phnum.split(") ")[1];	
		phnum=phnum.trim();
		var payload = MakeLoginNumberPhone.create();
		payload.PUT("self","self",phnum).then(function(resp)	//No I18N
		{
			callback(resp,phnum,number_type);
			removeButtonDisable(form);
		},
		function(resp)
		{
			removeButtonDisable(form);
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
	return;
	}
}

function changeprim_phonum_callback(phObj,phnum,number_type)
{
		SuccessMsg(getErrorMessage(phObj));
		login_mobile=phnum;
		if(number_type && number_type == "mfaNum") {
			profile_data.login_mobile=profile_data.Phone.tfa[phnum].display_number.replace(/[^0-9 ]/g,"").replace(" ","-");
			profile_data.Phone.tfa[phnum].mode = 1;
		} else {
			profile_data.login_mobile=profile_data.Phone.recovery[phnum].display_number.replace(/[^0-9 ]/g,"").replace(" ","-");
			profile_data.Phone.recovery[phnum].mode = 0;
		}
		load_phonedetails(profile_data.Policies,profile_data.Phone);
		load_emaildetails(profile_data.Policies,profile_data.Email);
		close_popupscreen();
		if($("#phonenumber_web_more").is(":visible")==true){
			tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
			$("#view_all_phonenumber").html("");
			goback_mob();
			show_all_phonenumbers();
		}
}

//add Phone Number	
function show_add_mobilescreen(heading,description,button,action)
{
	$('#empty_phonenumber_input').prop("readonly", false);
	$("#common_popup").addClass("default_popup");
	$('#common_popup .popuphead_text').html(heading);
	$('#common_popup .popuphead_define').html(description);
	$("#common_popup").show(0,function(){
		$("#common_popup").addClass("pop_anim");		
	});
	popup_blurHandler("6");
	$('#popup_mobile_action span').html(button);;
	$("#phonenumber_popup_contents form").attr("name",action);
	$("#empty_phonenumber").hide();
	$("#phonenumber_password").hide();
	$("#select_existing_phone").hide();
	$("#otp_phonenumber").hide();
	$("#select_phonenumber").show();
	$("#pop_action").html($("#phonenumber_popup_contents").html()); //load into popuop
	$('#common_popup #phoneNumberform').attr("onsubmit","NewPhoneNO(this,Otp_verify_show);return false;");
	$(".pp_popup").addClass("addMob_popup");
	$("#phonenumber_popup_contents form").attr("name","");
	$("#phonenumber_popup_contents form").attr("action","");

	if(curr_country!=undefined	&&	curr_country!="")
	{
		$(".countNameAddDiv option[value="+curr_country.toUpperCase()+"]").prop('selected', true);
	}
	 phonePattern.intialize(document.addphonenum.countrycode);
	if(!isMobile)
	{
		$(document.addphonenum.countrycode).uvselect({
			//width: '300px', //No i18N
			"searchable" : true, //No i18N
			"dropdown-width": "300px", //No i18N
			"dropdown-align": "left", //No i18N
			"embed-icon-class": "flagIcons", //No i18N
			"country-flag" : true, //No i18N
			"country-code" : true  //No i18N
		});
	}
	else{
		phonecodeChangeForMobile(document.addphonenum.countrycode);
	}
	closePopup(close_popupscreen,"common_popup");//No I18N
	
	$("#select_phonenumber_input").focus();
}

function NewPhoneNO(form,callback)
{
		var NewPhone = $('#'+form.id).find('input[name="mobile_no"]').val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
		remove_error();
		if(!validateMobile(NewPhone)){
			$('input[name="mobile_no"]').focus().parents('.field').append( '<div class="field_error">'+err_enter_valid_mobile+'</div>' );
			return false;
		}
		disabledButton(form);
		var payload
		encryptData.encrypt([NewPhone]).then(function(encryptedloginid) {
			encryptedmobilenumber = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
			var parms=
			{
				"mobile":encryptedmobilenumber,//No I18N
				"countrycode":$('#'+form.id).find('select[name="countrycode"]').val()//No I18N
			};
			payload = Phone.create(parms);
			payload.POST("self","self").then(function(resp)	//No I18N
			{
				callback(resp);
				removeButtonDisable(form);
			},
			function(resp)
			{
				function errHandler(err){
					if(err.cause && err.cause.trim() === "invalid_password_token"){ //No i18N{
						relogin_warning();
						var service_url = euc(window.location.href);
						$("#new_notification").attr("onclick","window.open('"+contextpath + err.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
					}else{
						showErrorMessage(getErrorMessage(err));
					}
				}
				if (handleCaptcha().isRequired(resp)) {
					handleCaptcha(resp, {
						backBtn: true,
						callbacks: {
							relogin: errHandler,
							beforeInit: function() {
								$(form).hide();
								$('#common_popup .popuphead_define').text(''); //No I18N
							}
						}
					}).init('#add_mobile_captcha', payload, ["self","self"]).then(function(res) { //No I18N
						$(form).show();
						callback(res);
					},function(e){
						$(form).show();
						$("#common_popup .popuphead_define").html(i18nMobkeys['IAM.SETUP.TFA.MOBILE.DESC']);	//No I18N
						if(e) {
							errHandler(e)
						}
					});
				} else {
					errHandler(resp);
				}
				removeButtonDisable(form);
				
			});
		});
		return;
}

var cryptData;

function Otp_verify_show(phObj)
{	
	
	if(phObj.status_code == 201){
		if(phObj.code == 'MOB200'){
			SuccessMsg(getErrorMessage(phObj));		
			cryptData = phObj.phone.encrypted_data;
			$("#empty_phonenumber").hide();
			$("#phonenumber_password").hide();
			$("#select_existing_phone").hide();
			$("#otp_phonenumber").show();
			$("#select_phonenumber").hide();
			$('#popup_mobile_action').removeAttr("onclick").html(iam_verify_phone_number);//no i18n
			$('#common_popup .popuphead_text').html(i18nkeys["IAM.INVITAION.VERIFY.MOBILE"]);	// No I18N
			$("#common_popup .popuphead_define").html(formatMessage(otp_description,phonePattern.setMobileNumFormat($('#select_phonenumber').find('input[name="mobile_no"]').val(),$("#countNameAddDiv").find("option:selected").val()))); // No I18N
			$('#common_popup #phoneNumberform').attr("onsubmit","verifyOTP(document.addphonenum,new_phonum_callback);return false;");
			$('#popup_mobile_action').siblings("#add_mobile_back").show();
			$("#common_popup #emailOTP_resend").show();
			resend_countdown("#phoneNumberform #emailOTP_resend");//No I18N 
			$("#phoneNumberform #emailOTP_resend").attr("onclick","resendverifyOTP(this,undefined,3)");
			$("#phoneNumberform .desc_about_block_otp").hide();
			splitField.createElement('otp_phonenumber_input',{
				"splitCount":otp_length,					// No I18N
				"charCountPerSplit" : 1,		// No I18N
				"isNumeric" : true,				// No I18N
				"otpAutocomplete": true,		// No I18N
				"customClass" : "customOtp",	// No I18N
				"inputPlaceholder":'&#9679;'	// No I18N
			});
			$('#otp_phonenumber_input #otp_phonenumber_input_full_value').attr('data-validate','zform_field');
			$('#otp_phonenumber_input #otp_phonenumber_input_full_value').attr('name','otp_code');
			$('#otp_phonenumber_input .customOtp').attr('onkeypress','remove_error()');
			$("#otp_phonenumber_input").click();
			control_Enter("a"); //No I18N
			closePopup(close_popupscreen,"common_popup",true);//No I18N
		}
	}
}

function cancelOTPVerify(){
	event.preventDefault();
	$("#otp_phonenumber").hide();
	$("#select_phonenumber").show();
	$('#common_popup .popuphead_text').html(i18nkeys["IAM.ADD.CONTACT.MOBILE"]);	//No I18N
	$('#popup_mobile_action').html(i18nkeys["IAM.ADD"]).removeAttr("onclick").siblings("#add_mobile_back").hide();//no i18n
	$('#common_popup #phoneNumberform').attr("onsubmit","NewPhoneNO(this,Otp_verify_show);return false;");
	$("#common_popup .popuphead_define").html(i18nMobkeys['IAM.SETUP.TFA.MOBILE.DESC']);	//No I18N
}

function PhoneOTP_resendcode()
{
	if(!$("#phoneNumberform #emailOTP_resend a").hasClass("resend_otp_blocked"))//countdown is over
	{
		var PHid=	$('#select_phonenumber').find('input[name="mobile_no"]').val();	
		if(PHid!="")
		{	
			var payload;
			encryptData.encrypt([PHid]).then(function(encryptedloginid) {
				encryptedmobilenumber = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
				var parms=
				{
					"mobile":encryptedmobilenumber,//No I18N
					"countrycode":$('#select_phonenumber').find('select[name="countrycode"]').val()	//No I18N
				};
				payload = Phone.create(parms);
				payload.POST("self","self").then(function(resp)	//No I18N
				{
					SuccessMsg(getErrorMessage(resp));
					resend_countdown("#phoneNumberform #emailOTP_resend");//No I18N 
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
			});
			
		}
	}
}
function resendverifyOTP(ele, from_btmmodal,rem_count)
{
	if(!$(ele).find("a").hasClass("resend_otp_blocked"))
	{	
		if(from_btmmodal) {
			var phun = $('#Email_popup_for_mobile').find('input[name="mobile_no"]').val();
		} else {
			var phun = $('#phonenumber_web_more').is(':visible')?$("#view_all_phonenumber #mobile_resend_otp_form").find('input[name="mobile_no"]').val():$('#select_phonenumber').find('input[name="mobile_no"]').val();	
		}
		phun = phun.replace(/[+ \[\]\(\)\-\.\,]/g,'');
		var parms = {};
		var parentContainer = "#otp_phonenumber";	//No I18N
		if(from_btmmodal){parentContainer = "#Email_popup_for_mobile"}
		else if($('#phonenumber_web_more').is(":visible")){parentContainer = ".web_email_specific_popup"}
		$(parentContainer+" .otp_resend").hide();
    	$(parentContainer+" #otp_sent").show().addClass("otp_sending").html(OTP_sending);
		var payload = Phone.create(parms);
		payload.PUT("self","self", cryptData).then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));
			$("#Email_popup_for_mobile .desc_about_block_otp,#phoneNumberform .desc_about_block_otp").removeClass("otp_blocked");
			if(from_btmmodal) {
				if(rem_count>1){
					rem_count = --rem_count;
					resend_countdown("#Email_popup_for_mobile #mobileOTP_resend");//No I18N 
	                $("#Email_popup_for_mobile .desc_about_block_otp").text(rem_count == 1 ? i18nMobkeys["IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT"] : formatMessage(i18nMobkeys["IAM.MOBILE.OTP.REMAINING.COUNT"],rem_count)).show();//No I18N 
	                $("#Email_popup_for_mobile #mobileOTP_resend").attr("onclick","resendverifyOTP(this,true,"+rem_count+")");	//No I18N 
				}
				else{
					 $("#Email_popup_for_mobile .desc_about_block_otp").text(i18nMobkeys["IAM.MOBILE.OTP.MAX.COUNT.REACHED"]).addClass("otp_blocked");//No I18N 
				}
				
			} else {
				if($('#phonenumber_web_more').is(":visible")){
					resend_countdown(".web_email_specific_popup #emailOTP_resend");//No I18N 
				}
				else{   
					if(rem_count>1){
						rem_count = --rem_count;
		                resend_countdown("#phoneNumberform #emailOTP_resend");//No I18N 
		                $("#phoneNumberform .desc_about_block_otp").text(rem_count == 1 ? i18nMobkeys["IAM.MOBILE.OTP.REMAINING.SINGLE.COUNT"] : formatMessage(i18nMobkeys["IAM.MOBILE.OTP.REMAINING.COUNT"],rem_count)).show();//No I18N 
		                $("#phoneNumberform #emailOTP_resend").attr("onclick","resendverifyOTP(this,undefined,"+rem_count+")");	//No I18N 
					}
					else{
						 $("#phoneNumberform .desc_about_block_otp").text(i18nMobkeys["IAM.MOBILE.OTP.MAX.COUNT.REACHED"]).addClass("otp_blocked");//No I18N 
					}
				}
			}
			setTimeout(function(){
				$(parentContainer+" #otp_sent").removeClass("otp_sending").html(OTP_resent);
			},500);
			setTimeout(function(){
				if($("#mobileOTP_resend a").hasClass("resend_otp_blocked")){
					$(parentContainer+" #mobileOTP_resend").show();					
				}
				else{$(parentContainer+" .otp_resend").show()}
				$(parentContainer+" #otp_sent").hide();
				if($("#phoneNumberform .desc_about_block_otp").hasClass("otp_blocked")||$("#Email_popup_for_mobile .desc_about_block_otp").hasClass("otp_blocked")){
					 $("#common_popup #emailOTP_resend,#Email_popup_for_mobile #mobileOTP_resend,"+parentContainer+" .otp_resend").hide();
				}
			},2000);

		},
		function(resp)
		{
			$(parentContainer+" .otp_resend").show();
	    	$(parentContainer+" #otp_sent").hide();
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
	return;
}

function verifyOTP(form,callback)
{
	if(validateForm(form))
	{	
		disabledButton(form);
		var phun=$('#'+form.id).find('input[name="mobile_no"]').val().replace(/[+ \[\]\(\)\-\.\,]/g,'');
		var oldnum =$('#'+form.id).find('input[name="old_phone"]').val();
		var code = $('#'+form.id).find('input[name="otp_code"]').val()//No I18N
		if(!isValidCode(code)){
			$(form).children("#otp_phonenumber").append('<div class="field_error">'+err_valid_otp_code+'</div>');
			$("#otp_phonenumber_input").click();
			removeButtonDisable(form)
			return false;
		}
		var parms=
		{
			"code": code //No I18N
		};
		var payload = Phone.create(parms);
		payload.PUT("self","self",cryptData).then(function(resp)	//No I18N
		{
			callback(resp,phun,oldnum);
			removeButtonDisable(form);
		},
		function(resp)
		{
			removeButtonDisable(form);
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
	return;
}



function new_phonum_callback(phdet,newPH,old_num)
{
	var divElement = $('<div />').html(getErrorMessage(phdet));
	divElement.find("span").html(phonePattern.setMobileNumFormat(divElement.find("span").text()));
	SuccessMsg(divElement[0].innerHTML);
	

	close_popupscreen();
	
	if(!jQuery.isEmptyObject(profile_data.Phone)	&&	!jQuery.isEmptyObject(profile_data.Phone.recovery)	&&	profile_data.Phone.recovery[newPH])
	{
		delete profile_data.Phone.recovery[newPH];
	}
	
	if(profile_data.Phone==undefined)
	{
		profile_data.Phone=[];
	}
	if(profile_data.Phone.recovery==undefined)
	{
		profile_data.Phone.recovery=[];
	}
	
	profile_data.Phone.recovery[newPH]=phdet.phone.mobile_num;
	
	if(old_num)
	{
		$("#old_mob").val("");
		delete profile_data.Phone.recovery[old_num];
	}
	if(profile_data.Phone.unverfied!=undefined&&profile_data.Phone.unverfied[newPH] != undefined){
		profile_data.Phone.recovery[newPH] = profile_data.Phone.unverfied[newPH];
		delete profile_data.Phone.unverfied[newPH];
	}	
	load_phonedetails(profile_data.Policies,profile_data.Phone);
	if($("#Email_popup_for_mobile").is(":visible")){
		close_for_mobile_specific();
	}
	if($("#phonenumber_web_more").is(":visible")==true)
	{
		//closeview_all_phonenumber_view();
		tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
		$("#view_all_phonenumber").html("");
		goback_mob();
		show_all_phonenumbers();
	}
	else
	{
		closeview_all_phonenumber_view();
	}
}


function resendConfirmationCodeForPhone_mob(c_code,mobilenum) {
	var payload;
	encryptData.encrypt([mobilenum]).then(function(encryptedloginid) {
		encryptedmobilenumber = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var parms=
		{
			"mobile":encryptedmobilenumber,//No I18N
			"countrycode":c_code//No I18N
		};
		payload = Phone.create(parms);
	});
	disabledButton($("#Email_popup_for_mobile .option_button"));
	function successCallback(resp){
		removeButtonDisable($("#Email_popup_for_mobile .option_button"));
		SuccessMsg(getErrorMessage(resp));
		cryptData = resp.phone.encrypted_data;
		$("#Email_popup_for_mobile .option_button").slideUp(300,function(){
			$("#Email_popup_for_mobile .option_button").hide();
			$("#Email_popup_for_mobile .popuphead_details").html('<span class="popuphead_text">'+i18nkeys["IAM.INVITAION.VERIFY.MOBILE"]+'</span>');
			$("#Email_popup_for_mobile .mob_popuphead_define").html(formatMessage(otp_description,phonePattern.setMobileNumFormat(mobilenum,c_code)));
			$("#Email_popup_for_mobile .otp_field").attr("id","otp_phonenumber");
			$("#Email_popup_for_mobile .otp_mobile_form").show();	
			$("#Email_popup_for_mobile #mob_otp_email_input").val("");
			splitField.createElement('mob_otp_email_input',{
				"splitCount":otp_length,					// No I18N
				"charCountPerSplit" : 1,		// No I18N
				"isNumeric" : true,				// No I18N
				"otpAutocomplete": true,		// No I18N
				"customClass" : "customOtp",	// No I18N
				"inputPlaceholder":'&#9679;'	// No I18N
			});
			$('#mob_otp_email_input #mob_otp_email_input_full_value').attr('data-validate','zform_field');
			$('#mob_otp_email_input #mob_otp_email_input_full_value').attr('name','otp_code');
			$('#mob_otp_email_input .customOtp').attr('onkeypress','remove_error()');
			$("#Email_popup_for_mobile .otp_mobile_form form").attr('name','resend_otp_ver_form_mb');
			$("#Email_popup_for_mobile .otp_mobile_form form").attr('id','resend_otp_ver_form_mb');
			$("#Email_popup_for_mobile  #mobile_conf_input").val(mobilenum);	
			$("#Email_popup_for_mobile #mobileOTP_resend").show();
			$("#Email_popup_for_mobile .option_container").slideDown(300,function(){
				resend_countdown("#Email_popup_for_mobile #mobileOTP_resend");//No I18N
				$("#Email_popup_for_mobile #mobileOTP_resend").attr("onclick","resendverifyOTP(this,true,3)").show();
				$("#Email_popup_for_mobile .desc_about_block_otp").hide();
				$("#mob_otp_email_input").click();
			});
			
			$("#Email_popup_for_mobile #action_otp_conform").attr('onclick','return verifyOTP(document.resend_otp_ver_form_mb,new_phonum_callback)');
		})
	}
	payload.POST("self","self").then(successCallback, function(resp){ //No I18N
		removeButtonDisable($("#Email_popup_for_mobile .option_button"));
		function errHandler(err) {
			if(err.cause && err.cause.trim() === "invalid_password_token") { //No I18N
				relogin_warning();
				var service_url = euc(window.location.href);
				$("#new_notification").attr("onclick","window.open('"+contextpath + err.redirect_url +"?serviceurl="+service_url+"&post="+true+"', '_blank');");//No I18N 
			} else {
				showErrorMessage(getErrorMessage(err));
			}
		}
		if (handleCaptcha().isRequired(resp)) {
			handleCaptcha(resp, {
				callbacks: {
					relogin: errHandler,
					beforeInit: function() {
						$('#Email_popup_for_mobile .option_button').hide(); //No I18N	
					}
				}
			}).init('#Email_popup_for_mobile .mob_popuphead_define', payload, ["self","self"]).then(successCallback,function(e){ //No I18N
				show_mob_conform('pho_resend', formatMessage(mob_resend_conf,mobilenum)); //No I18N
				$('#Email_popup_for_mobile .option_button').show();  //No I18N
				errHandler(e);
			});
		} else {
			errHandler(resp);
		}
	});	
}

//for viewmorw phonenumbers.jsp
function resendEmailConfirmLink_mobile(emailid){
	var payload;
	encryptData.encrypt([emailid]).then(function(encryptedloginid) {
		encryptedemailId = typeof encryptedloginid[0] == 'string' ? encryptedloginid[0] : encryptedloginid[0].value;
		var parms=
		{
			"email_id":encryptedemailId//No I18N
		};
		payload = Email.create(parms);
		disabledButton($("#Email_popup_for_mobile .option_button"));
		payload.POST("self","self").then(function(resp)	//No I18N
		{	
			removeButtonDisable($("#Email_popup_for_mobile .option_button"));
			SuccessMsg(getErrorMessage(resp));
			cryptData = resp.email.encrypted_data;
			var str = $("#email_otp_text").html();
			$("#Email_popup_for_mobile .option_container").slideUp(300,function(){
				$("#Email_popup_for_mobile .option_button").hide();
				$("#Email_popup_for_mobile .popuphead_details").html('<span class="popuphead_text">'+i18nkeys["IAM.PROFILE.EMAIL.VERIFY.HEADING"]+'</span>');
				$("#Email_popup_for_mobile .mob_popuphead_define").html(formatMessage(str,emailid));
				$("#Email_popup_for_mobile .otp_mobile_form").show();
				$("#Email_popup_for_mobile .otp_field").attr("id","otp_emailaddress");
				$("#Email_popup_for_mobile #mob_otp_email_input").val("");
				splitField.createElement('mob_otp_email_input',{
					"splitCount":otp_length,					// No I18N
					"charCountPerSplit" : 1,		// No I18N
					"isNumeric" : true,				// No I18N
					"otpAutocomplete": true,		// No I18N
					"customClass" : "customOtp",	// No I18N
					"inputPlaceholder":'&#9679;'	// No I18N
				});
				$('#mob_otp_email_input #mob_otp_email_input_full_value').attr('data-validate','zform_field');
				$('#mob_otp_email_input #mob_otp_email_input_full_value').attr('name','otp_code');
				$('#mob_otp_email_input .customOtp').attr('onkeypress','remove_error()');
				$("#Email_popup_for_mobile .otp_mobile_form form").attr('name','resend_otp_ver_form');
				$("#Email_popup_for_mobile .otp_mobile_form form").attr('id','resend_otp_ver_form');
				$("#Email_popup_for_mobile  #email_conf_input").val(emailid);
				$("#Email_popup_for_mobile .option_container").slideDown(300,function(){	
					resend_countdown("#Email_popup_for_mobile #emailOTP_resend");//No I18N
					$("#Email_popup_for_mobile #emailOTP_resend").show();
					$("#mob_otp_email_input").click();
				});
				
				$("#Email_popup_for_mobile #action_otp_conform").attr('onclick','return confirm_add_email(document.resend_otp_ver_form,resendEmailConfirmLink_mobile_callback)');
			});
		},
		function(resp)
		{
			removeButtonDisable($("#Email_popup_for_mobile .option_button"));
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
	});
	
}

function resendEmailConfirmLink_mobile_callback(emailObj){
	SuccessMsg(getErrorMessage(emailObj));
	close_for_mobile_specific(function(){
		profile_data.Email[decodeHTML(emailObj.email.email_id)]=emailObj.email;
		load_emaildetails(profile_data.Policies,profile_data.Email);		
		if($("#emails_web_more").is(":visible")){
			show_all_emails();
		}
		else{
			close_for_mobile_specific();
		}
	});
}

function removeEmailForMobile(emailid){
	
	new URI(Email,"self","self",emailid).DELETE().then(function(resp)	//No I18N
			{
				close_for_mobile_specific(function(){
					delete_email_callback(resp,emailid);
				});
				return false;
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
				return false;
			});
}
function emailMakePrimaryForMobile(emailid){
	var payload = makePrimary.create();
	payload.PUT("self","self",emailid).then(function(resp)	//No I18N
			{
				close_for_mobile_specific(function(){
					changed_primaryemail(resp,emailid);					
				});
				return false;
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
				return false;
			});
}
function makePrimaryMobileForMobile(phnum){
	var payload = MakeLoginNumberPhone.create();
	
	payload.PUT("self","self",phnum).then(function(resp)	//No I18N
	{
		close_for_mobile_specific(function(){
			var num_type="";
			if(!jQuery.isEmptyObject(profile_data.Phone.recovery) && !jQuery.isEmptyObject(profile_data.Phone.recovery[phnum])) {
				num_type = "recovery"; //No I18N
			}
			else if(!jQuery.isEmptyObject(profile_data.Phone.tfa) && !jQuery.isEmptyObject(profile_data.Phone.tfa[phnum])){
				num_type = "mfaNum"; //No I18N
			}
			changeprim_phonum_callback(resp,phnum,num_type);
		});
		return false;
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
		return false;
	});
}

function deleteMobileNumber_MobileUi(phnum){
	new URI(Phone,"self","self",phnum).DELETE().then(function(resp)	//No I18N
			{
				close_for_mobile_specific(function(){
					delete_phonum_callback(resp,phnum);					
				});
				return false;
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
				return false;
			});
}
function close_for_mobile_specific(callback){
	popupBlurHide("#Email_popup_for_mobile",function(){//No I18N
		$(".mob_popu_btn_container").show();
		$(".mob_popu_btn_container button").hide();
		$(".option_container").hide();
		$(".option_button").show();
		$(".otp_mobile_form").hide();
		$("#btn_to_delete span:last-child").text(i18nkeys["IAM.REMOVE"]);//No I18N
		$("#Email_popup_for_mobile .option_button #action_granted").html(i18nkeys["IAM.CONTINUE"]).removeClass("delete_btn_color");//No I18N
		if($("#phonenumber_web_more").is(":visible")||$("#emails_web_more").is(":visible")){
			popup_blurHandler("6");
		} 
		$('#Email_popup_for_mobile').removeClass('bottom_modal');
		if(callback){
			callback();
		}
	}); 
	$(".option_button #action_granted").unbind();
}

function show_mob_conform(action_type,def, animation){
	if(animation == undefined || animation == true){
		$(".mob_popu_btn_container").slideUp(300,function(){
			$(".option_container").slideDown(300);
		});
	} else {
		$(".mob_popu_btn_container").css("all","unset"); //No I18n
		$(".option_container").css("display","block");
	}
	
	if(action_type == "mfa_pho_delete"){
		$(".option_container .mob_popuphead_define").html(getMfaDeleteContent());
		$(".option_container .option_button").hide();
		return;
	}
	if(action_type.toLowerCase().indexOf("delete")!= -1){
		$(".option_container #action_granted").html(i18nkeys["IAM.DELETE"]); //No I18N
		$("#Email_popup_for_mobile .option_button #action_granted").addClass("delete_btn_color");
	}
	$(".option_container .mob_popuphead_define").html(def);
	
	if(action_type == "email_resend" ){				
		$("#Email_popup_for_mobile .option_button #action_granted").html(i18nkeys["IAM.EMAIL.CONFIRMATION.SEND.EMAIL"]); //No I18N	
	}
	
	$("#Email_popup_for_mobile .option_button #action_granted").click(function(){	
		if(action_type == "email_primary" ){
			var emailid =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			emailMakePrimaryForMobile(emailid);
			return false;
		}
		if(action_type == "email_delete" ){
			var emailid =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			removeEmailForMobile(emailid);
			return false;
		}
		if(action_type == "email_resend" ){
			var emailid =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			resendEmailConfirmLink_mobile(emailid);
			return false;
		}
		if(action_type == "pho_primary" ){
			var phnum =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			phnum=phnum.replace(phnum.split(" ")[0],"").replace(/[ \-\.]/g,'');	
			makePrimaryMobileForMobile(phnum);
			return false;
		}
		if(action_type == "pho_delete" ){
			var phnum =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			phnum=phnum.replace(phnum.split(" ")[0],"").replace(/[ \-\.]/g,'');	
			deleteMobileNumber_MobileUi(phnum);
			return false;
		}
		if(action_type == "pho_resend"){
			var phnum =$('#Email_popup_for_mobile').find('.emailaddress_text').html();
			phnum=phnum.replace(phnum.split(" ")[0],"").replace(/[ \-\.]/g,'');	
			var phoneObj = profile_data.Phone.unverfied[phnum];
			resendConfirmationCodeForPhone_mob(phoneObj.country_code, phoneObj.mobile);
			return false;
		}
	});
}

function for_mobile_specific(id)
{
	if(isMobile) {
		remove_error();	
		if(!$("#phonenumber_web_more").is(":visible")){
			popup_blurHandler("6");
		} else {
			popup_blurHandler("8");
		}
		$("#Email_popup_for_mobile").show(0,function(){
			$("#Email_popup_for_mobile").addClass("pop_anim  bottom_modal");
		});
		var displayNum = $("#"+id+" .emailaddress_text").first().text();
		var mobile_num = displayNum.replace(displayNum.split(" ")[0],"").replace(/[ \-\.]/g,'');
		$('.profile_tags_wrapper .profile_info_tags').addClass('hide');
		$('.profile_tags_wrapper .profile_info_tags.mfa_tag').removeClass('disabled_mfa_tag');
		if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-Primary")){
			$("#btn_to_chng_primary_mb").show();
			$("#btn_to_chng_primary_mb").attr("onclick","show_mob_conform('pho_primary','"+formatMessage(i18nkeys["IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.POPUP.DESCRIPTION"],displayNum)+"')");//No I18N
		} else {
			$('.profile_tags_wrapper .profile_info_tags.primary_tag .inf_txt').html($("#"+id+" .primary_tag .profile_tags_tooltip_heading").text());
			$('.profile_tags_wrapper .profile_info_tags.primary_tag').removeClass('hide');
		}
		if(profile_data.Phone.recovery && profile_data.Phone.recovery[mobile_num] && $("#"+id+" .recovery_tag").length != 0) {
			$('.profile_tags_wrapper .profile_info_tags.recovery_tag .inf_txt').html($("#"+id+" .recovery_tag .profile_tags_tooltip_heading").text());
			$('.profile_tags_wrapper .profile_info_tags.recovery_tag').removeClass('hide');
		}
		if(profile_data.Phone.tfa && profile_data.Phone.tfa[mobile_num]) {
			$('.profile_tags_wrapper .profile_info_tags.mfa_tag .inf_txt').html($("#"+id+" .mfa_tag .profile_tags_tooltip_heading").text());
			$('.profile_tags_wrapper .profile_info_tags.mfa_tag').removeClass('hide');
			if(!profile_data.Phone.motp_allowed_by_org) {
				$('.profile_tags_wrapper .profile_info_tags.mfa_tag').addClass('disabled_mfa_tag');
				$("#btn_to_mark_recovery").attr("onclick", $("#"+id+" .tooltip_cta_text.set_as_recovery").first().attr('onclick'));//No I18N
				$("#btn_to_mark_recovery").show();
			} else {
				var callback_action  =  $("#"+id+" .action_icons_div_ph .icon-swapNum").first().attr('onclick');
				$("#btn_to_swap").attr("onclick",callback_action);//No I18N
				$("#btn_to_swap").show();	
			}
		}else if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-swapNum") && !$("#"+id+" .action_icons_div_ph .icon-swapNum").hasClass("hide")){
			var callback_action  =  $("#"+id+" .action_icons_div_ph .icon-swapNum").first().attr('onclick');
			$("#btn_to_swap").attr("onclick",callback_action);//No I18N
			$("#btn_to_swap").show();
		}
		if($("#"+id+" .action_icons_div_ph").children().hasClass("icon-delete")){
			$("#btn_to_delete").show();
			if(profile_data.Phone.tfa && profile_data.Phone.tfa[mobile_num]){
				$("#btn_to_delete").attr("onclick","show_mob_conform('mfa_pho_delete','"+formatMessage(err_mobile_sure_delete1,displayNum)+"')");
			}
			else {
				$("#btn_to_delete").attr("onclick","show_mob_conform('pho_delete','"+formatMessage(err_mobile_sure_delete1,displayNum)+"')");
			}
			$("#btn_to_delete span:last-child").text(i18nkeys["IAM.CONFIRM.POPUP.PHONENUMBER"]);//No I18N
		}
		if($("#"+id+" .tooltip_cta_text").hasClass('remove_cta')) {
			$("#btn_to_remove_as_primary").attr("onclick", $("#"+id+" .tooltip_cta_text.remove_cta").first().attr('onclick'));//No I18N
			$("#btn_to_remove_as_primary").show();
		}
		if($("#"+id+" .mobile_info #unverified_tap_to_more").is(":visible")){
			$('.profile_tags_wrapper .profile_info_tags').addClass('hide');
			$("#btn_to_resend_mb").show();
			$("#btn_to_resend_mb").attr("onclick","show_mob_conform('pho_resend','"+formatMessage(mob_resend_conf,displayNum)+"')");
		}
		if($("#"+id+" .action_icons_div_ph .icon-swapNum").hasClass("hide")){
			$("#btn_to_swap").hide();
		}
		$("#Email_popup_for_mobile .popuphead_details").html($("#"+id).html()); 
		$("#Email_popup_for_mobile").focus();
		if($("#Email_popup_for_mobile #unverified_tap_to_more").is(":visible")){
			$("#Email_popup_for_mobile #unverified_tap_to_more").addClass("hide");
		}
		closePopup(close_for_mobile_specific,"Email_popup_for_mobile");//No I18N
	}
}


function closeview_all_phonenumber_view()
{
	tooltip_Des("#phonenumber_web_more .action_icon");//No I18N
	$("#view_all_phonenumber").html("");
	popupBlurHide('#phonenumber_web_more');//No I18N
	goback_mob();
	$(".blue").unbind();
	$("a").unbind();
}

function show_all_phonenumbers()
{
		goback_mob();
		tooltip_Des(".field_mobile .action_icon");//No I18N
		$("#view_all_phonenumber").html("");
		if( $( ".phonenumber_prim" ).is(":visible") ) 
		{
			$("#view_all_phonenumber").append($(".phonenumber_prim").html());
		}
		if( $( ".phonenumber_sec" ).length ) 
		{
			$("#view_all_phonenumber").append($(".phonenumber_sec").html());
		}
		if( $( ".phonenumber_unverfied" ).length ) 
		{
			$("#view_all_phonenumber").append($(".phonenumber_unverfied").html());
		}
		if( $( ".phonenumber_tfa" ).length )
		{
			$("#view_all_phonenumber").append($(".phonenumber_tfa").html());
		}
		popup_blurHandler('6');	
		$("#phonenumber_web_more").show(0,function(){
			$("#phonenumber_web_more").addClass("pop_anim");
		});
		
		$("#view_all_phonenumber .extra_phonenumbers").show();
		$("#view_all_phonenumber").show();
		$("#specific_phoneNUM").hide();
		if(isMobile)
		{
			$("#view_all_phonenumber .phnum_hover_show").remove();
			$("#view_all_phonenumber .profile_tags").remove();
		}
		else
		{
			$("#view_all_phonenumber .primary").removeAttr("onclick");
			$("#view_all_phonenumber .secondary").removeAttr("onclick");
			$("#view_all_phonenumber .field_mobile .action_icons_div_ph span").removeAttr("onclick");
			$("#view_all_phonenumber .verify_now_text").removeAttr("onclick");//No I18N
			$("#view_all_phonenumber .field_mobile .action_icons_div_ph span,#view_all_phonenumber .field_mobile .verify_now_text").click(function(){
				var id=$(this).attr('id');
				var id_num=parseInt(id.match(/\d+$/)[0], 10);
				if($("#view_all_phonenumber #"+id).hasClass("selected_icons"))
				{
					return;
				}
					if($("#"+id).attr("onclick"))
					{
						var args=$("#"+id).attr("onclick").split(",");
					}
					else
					{
						var args=$("#"+id).attr("onmouseover").split(",");
					}
				var len=args.length;
				var prev_num;
				if($("#view_all_phonenumber .inline_action").length)
				{
					prev_num = $("#view_all_phonenumber .inline_action").parents(".field_mobile").attr("id");
					prev_num = parseInt(prev_num.match(/\d+$/)[0], 10);

					if(prev_num == id_num)
					{
						$("#mobile_num_"+id_num+" .inline_action").slideUp(300);
					}
				}
				$("#view_all_phonenumber .field_mobile").removeClass("web_email_specific_popup");//No I18N
				$("#view_all_phonenumber .action_icons_div_ph").removeClass("show_icons");
				$("#view_all_phonenumber .field_mobile .action_icons_div_ph span,#view_all_phonenumber .field_mobile .verify_now_text").removeClass("selected_icons");
				
				if(id=="mob_icon_resend_"+id_num || id=="unverified_mobile_"+id_num)
				{
					var Ccode=args[0].split("(")[1].replace(/'/g,'');
					var phoneNumber=args[1].split(")")[0].replace(/'/g,'');
					$("#view_all_phonenumber #mobile_num_"+id_num+" .action_icons_div_ph").addClass("show_icons");
					$("#view_all_phonenumber #"+id).addClass("selected_icons");
					$("#view_all_phonenumber #mobile_num_"+id_num).append('<div class="inline_action"></div>');
					if($("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action").length==2)
					{
						var conf_ele = $("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" )[1];
					}
					else
					{
						var conf_ele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" );
					}
					$(conf_ele).html('<div class="inline_action_discription">'+formatMessage(em_resend_conf, phonePattern.setMobileNumFormat(phoneNumber,Ccode))+'</div>');
					$(conf_ele).append('<button id="resend_specific_mob" class="primary_btn_check inline_btn nobottom_margin_btn delete_btn">'+i18nMobkeys["IAM.SEND.OTP"]+'</button>');
					$("#view_all_phonenumber #resend_specific_mob").attr("onclick",'resendConfirmationCodeForMob(\''+Ccode+'\',\''+phoneNumber+'\',\''+id_num+'\')');
				}
				else if(id=="ph_icon_delete_"+id_num)
				{
					if(args[0]=="deleteTFAMobile()"){
						$("#view_all_phonenumber #mobile_num_"+id_num+" .action_icons_div_ph").addClass("show_icons");
						
						$("#view_all_phonenumber #mobile_num_"+id_num).append('<div class="inline_action"></div>');
						if($("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action").length==2)
						{
							var deleteele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" )[1];
						}
						else
						{
							var deleteele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" );
						}
						deleteele.append(getMfaDeleteContent());
					}
					else{
						mobile=args[1].split(")")[0].replace(/'/g,'');
						$("#view_all_phonenumber #mobile_num_"+id_num+" .action_icons_div_ph").addClass("show_icons");
						
						$("#view_all_phonenumber #mobile_num_"+id_num).append('<div class="inline_action"></div>');
						if($("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action").length==2)
						{
							var deleteele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" )[1];
						}
						else
						{
							var deleteele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" );
						}
						$(deleteele).html('<div class="inline_action_discription">'+formatMessage(err_mobile_sure_delete1, mobile)+'</div>');
						$(deleteele).append('<button id="delete_specific_mob" class="primary_btn_check inline_btn nobottom_margin_btn delete_btn delete_btn_color">'+i18nkeys["IAM.DELETE"]+'</button>');
						$("#delete_specific_mob").unbind();
						$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #delete_specific_mob").click(function()
						{
							mobile = mobile.replace(mobile.split(" ")[0],"").replace(/[ \-\.]/g,'')
							new URI(Phone,"self","self",mobile).DELETE().then(function(resp)	//No I18N
									{
				    					delete_phonum_callback(resp,mobile);
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
						});
					}
				}
				else if(id=="ph_icon_MKprim_"+id_num)
				{
					var heading=args[0].split("(")[1].replace(/'/g,'');
					var button=args[2].replace(/'/g,'');
					var number=args[3].replace(/'/g,'');
					var description=formatMessage(args[1].replace(/'/g,''),phonePattern.setMobileNumFormat(number));
					var action=args[4].split(")")[0].replace(/'/g,'');
					var num_type=args[6].split(")")[0].replace(/'/g,'');
					description = formatMessage(description, number);
					
					$("#view_all_phonenumber #mobile_num_"+id_num+" .action_icons_div_ph").addClass("show_icons");
					$("#view_all_phonenumber #"+id).addClass("selected_icons");
					$("#phonenumber_popup_contents form").attr("name","Viewmore"+action); 
					$("#select_phonenumber").hide();
					$("#phonenumber_password").show();
					$("#select_existing_phone").hide();
					$("#otp_phonenumber").hide();
					$("#empty_phonenumber_input_code").attr("readonly","readonly");
					$("#view_all_phonenumber #mobile_num_"+id_num).append('<div class="inline_action"></div>');
					if($("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action").length==2)
					{
						var prim_ele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" )[1];
					}
					else
					{
						var prim_ele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" );
					}
					
					$(prim_ele).html('<div class="inline_action_discription">'+description+'</div>');
					$(prim_ele).append($("#phonenumber_popup_contents").html()); //load into popuop
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .popup_header" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #popup_mobile_action" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #close_popup_mobile" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #add_mobile_back" ).remove();
					$(prim_ele).children("form").append('<button class="primary_btn_check inline_btn nobottom_margin_btn delete_btn" onclick="changePrimaryPhonenum(document.Viewmore'+action+',changeprim_phonum_callback,\''+num_type+'\');">'+button+'</button>');
					$("#view_all_phonenumber #empty_phonenumber_input_code").val(number);
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form").attr("id","phoneNumberform_specific");
					$("#phonenumber_popup_contents form").attr("name","");
					//$("#phonenumber_popup_contents form").attr("action","");
					control_Enter(".blue"); //No I18N
					
				}
				else if(id=="ph_icon_sawpNum_"+id_num)
				{
					var phnNumber=args[1].split(")")[1].replace(/'/g,'').trim();
					var phnNum_type=args[3].split(")")[0].replace(/'/g,'');
					$("#view_all_phonenumber #mobile_num_"+id_num+" .action_icons_div_ph").addClass("show_icons");
					$("#view_all_phonenumber #"+id).addClass("selected_icons");
					$("#phonenumber_popup_contents form").attr("name","Viewmore"+action); 
					
					$("#select_phonenumber").hide();
					$("#phonenumber_password").show();
					$("#select_existing_phone").hide();
					$("#otp_phonenumber").hide();
					
					$("#empty_phonenumber_input_code").attr("readonly","readonly");
					
					$("#view_all_phonenumber #mobile_num_"+id_num).append('<div class="inline_action"></div>');
					
					if($("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action").length==2)
					{
						var prim_ele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" )[1];
					}
					else
					{
						var prim_ele=$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" );
					}
					$(prim_ele).append($("#profile_popup").html()); //load into popuop
					
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .profile_popup_body" ).removeClass();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .top_popup_header" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .popuphead_details" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .close_btn" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #swap_mobile_action" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #swap_popup_close" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .phnNum_popup_btns" ).remove();
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #recovery_div input").attr("id", "recoveryNum_specific");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #recovery_div label").attr("for", "recoveryNum_specific");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #mfa_div input").attr("id", "mfaNum_specific");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #mfa_div label").attr("for", "mfaNum_specific");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form .swapNum_radiobtn").attr("name", "phnNum_type_specific");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action #"+phnNum_type+"_specific").prop("checked", true);
					$(prim_ele).children("form").append('<button class="primary_btn_check inline_btn nobottom_margin_btn delete_btn pref_disable_btn" disabled= "disabled" onclick="swap_numbers(document.swapnumber,'+phnNumber+',\'phnNum_type_specific\', swap_phnNum_callback);">'+iam_change+'</button>');					
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form .swapNum_radiobtn_div").removeClass("disable_pointer_events");
					$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action .swapNum_radiobtn_div").change(function() {
						var phnType_val = $("input[name='phnNum_type_specific']:checked").val();
						if(phnType_val != phnNum_type) {
							$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form button").removeClass("pref_disable_btn");
							$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form button").prop("disabled", false);
						} else {
							$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form button").addClass("pref_disable_btn");
							$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action form button").prop("disabled", true);
						}						
					});
					swap_number_disable_check(phnNumber.trim(), phnNum_type);
					if(profile_data.Phone.block_add_recovery){
						$("#recoveryNum_specific, #swap_mobile_action").prop("disabled", true);
						$("#swap_mobile_action").addClass("pref_disable_btn");
						$("#recovery_div .swapNum_radiobtn_text").addClass("swapNum_radiobtn_text_disable");
						$("#recovery_div .swapNum_description").addClass("swapNum_description_disable");
						$("#recoveryNum_specific,#phnNum_type_specific").prop("checked", false);
						$(".swapNum_description_recovery .recovery_disabled_desc").show();
					}
				}
			
				if(prev_num!=undefined)
				{
					if(prev_num != id_num)
					{
						$("#view_all_phonenumber .field_mobile").removeClass("web_email_specific_popup");
						
						$("#mobile_num_"+prev_num+" .inline_action").slideUp(300,function(){
							$("#mobile_num_"+prev_num+" .inline_action").remove();
						});
						$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" ).slideDown(300,function(){
						});
					}
					else
					{
						var previous=$("#mobile_num_"+prev_num+" .inline_action")[0];
						var newele=$("#mobile_num_"+prev_num+" .inline_action")[1];
						$(previous).slideUp(300,function(){
							$(newele).slideDown(300,function(){
								$(previous).remove();
							});
						});
					}
				}
				else
				{
						$("#view_all_phonenumber #mobile_num_"+id_num+" .inline_action" ).slideDown(300,function(){
						});
				}
				$("#view_all_phonenumber #mobile_num_"+id_num).addClass("web_email_specific_popup");
			});
		}
		tooltipSet("#phonenumber_web_more .action_icon"); //No I18N
		tooltipSet(".field_mobile .action_icon");//No I18N
		$("#phonenumber_web_more").focus();
		closePopup(closeview_all_phonenumber_view,"phonenumber_web_more");//No I18N
}


function Otp_verify_show_specific()
{
	if(isMobile)
		{
			$("#show_specific_ph_info #empty_phonenumber").hide();
			$("#show_specific_ph_info #phonenumber_password").hide();
			$("#show_specific_ph_info #select_existing_phone").hide();
			$("#show_specific_ph_info #otp_phonenumber").show();
			$("#show_specific_ph_info #select_phonenumber").hide();
			$('#show_specific_ph_info #popup_mobile_action').html(iam_verify_phone_number);
			$('#show_specific_ph_info #popup_mobile_action').attr("onclick","verifyOTP(document.Viewmoreaddphonenum,new_phonum_callback);");
			$('#show_specific_ph_info #otp_phonenumber_input').val('');
		}
		else
		{
			$("#view_all_phonenumber #empty_phonenumber").hide();
			$("#view_all_phonenumber #phonenumber_password").hide();
			$("#view_all_phonenumber #select_existing_phone").hide();
			$("#view_all_phonenumber #otp_phonenumber").show();
			$("#view_all_phonenumber #select_phonenumber").hide();
			$('#view_all_phonenumber #popup_mobile_action').html(iam_verify_phone_number);
			$('.web_email_specific_popup button').attr("onclick","verifyOTP(document.Viewmoreaddphonenum,new_phonum_callback);");
			$('#view_all_phonenumber #otp_phonenumber_input').val('');
		}
}

function goback_mob()
{
	$("#view_all_phonenumber").show();
	$("#specific_phoneNUM").hide();
	$("#show_specific_ph_info").html("");
	$(".small_circle").removeClass("small_circle_selected");
}

function specific_showmake_prim_mobilescreen(heading,description,button,number,action,id)
{
	$("#show_specific_ph_info").html("");
	$("#specific_phoneNUM .small_circle").removeClass("small_circle_selected");
	$("#specific_phoneNUM #resendconfir_circle").addClass("small_circle_selected");
	$("#show_specific_ph_info").html('<br /><div class="popup_header "><div class="popuphead_details"><span class="popuphead_text">'+heading+'</span><span class="popuphead_define">'+description+'</span></div></div>');
	$('#popup_mobile_action span').html(button);;
	
	$("#phonenumber_popup_contents form").attr("name",action);
	$("#phonenumber_popup_contents form").attr("action",contextpath+"/u/updateMobilePrimary");//No I18N
	$('#popup_mobile_action').attr("onclick","editLoginName(document."+action+",changeprim_phonum_callback);"); //No I18N
	$("#empty_phonenumber").show();
	$("#select_phonenumber").hide();
	$("#phonenumber_password").show();
	$("#select_existing_phone").hide();
	$("#otp_phonenumber").hide();
	$("#empty_phonenumber_input_code").attr("readonly","readonly");
	$("#show_specific_ph_info").append($("#phonenumber_popup_contents").html()); //load into popuop
	$("#show_specific_ph_info #empty_phonenumber_input_code").val(number);
	$("#specific_phoneNUM #show_specific_ph_info form").attr("id","phoneNumberform_specific");
	$("#phonenumber_popup_contents form").attr("name","");
	$("#phonenumber_popup_contents form").attr("action","");

}

function specific_showchange_prim_mobilescreen(heading,description,button,action)
{
	$("#show_specific_ph_info").html("");
	$("#specific_phoneNUM .small_circle").removeClass("small_circle_selected");
	$("#specific_phoneNUM #icon-pencil_circle").addClass("small_circle_selected");
	$("#show_specific_ph_info").html('<br /><div class="popup_header "><div class="popuphead_details"><span class="popuphead_text">'+heading+'</span><span class="popuphead_define">'+description+'</span></div></div>');
	$('#popup_mobile_action span').html(button);;
	$("#phonenumber_popup_contents form").attr("name",action);
	$("#phonenumber_popup_contents form").attr("action",contextpath+"/u/updateMobilePrimary");//No I18N
	$('#popup_mobile_action').attr("onclick","editLoginName(document."+action+",changeprim_phonum_callback);"); //No I18N
	$("#empty_phonenumber").hide();
	$("#phonenumber_password").show();
	$("#select_existing_phone").show();
	$("#otp_phonenumber").hide();
	$("#select_phonenumber").hide();
	$("#show_specific_ph_info").append($("#phonenumber_popup_contents").html()); //load into popuop
	$("#specific_phoneNUM #show_specific_ph_info form").attr("id","phoneNumberform_specific");
	$("#phonenumber_popup_contents form").attr("name","");
	$("#phonenumber_popup_contents form").attr("action","");
}


function specific_show_editMobile(heading,description,button,number,action)
{
	
	$("#show_specific_ph_info").html("");
	
	$("#specific_phoneNUM .small_circle").removeClass("small_circle_selected");
	$("#specific_phoneNUM #icon-pencil_circle").addClass("small_circle_selected");
	
	$("#show_specific_ph_info").html('<br /><div class="popup_header "><div class="popuphead_details"><span class="popuphead_text">'+heading+'</span><span class="popuphead_define">'+description+'</span></div></div>');
	
	$('#popup_mobile_action span').html(button);
	
	$("#phonenumber_popup_contents form").attr("name",action);
	$("#phonenumber_popup_contents form").attr("action",contextpath+"/u/updateMobileAdd");//No I18N
	$('#popup_mobile_action').attr("onclick","validateForm(document.addemailid,Otp_verify_show_specific);");
	$("#empty_phonenumber").hide();
	$("#select_phonenumber").show();
	$("#phonenumber_password").hide();
	$("#select_existing_phone").hide();
	$("#otp_phonenumber").hide();
	$("#show_specific_ph_info").append($("#phonenumber_popup_contents").html()); //load into popuop
	$("#specific_phoneNUM #show_specific_ph_info form").attr("id","phoneNumberform_specific");

	$("#show_specific_ph_info #empty_phonenumber_input").val(number);
	$("#phonenumber_popup_contents form").attr("name","");
	$("#show_specific_ph_info #select_phonenumber_input").val(number.split(') ')[1]);
	$("#show_specific_ph_info #old_mob").val(number.split(') ')[1]);
	$("#phonenumber_popup_contents form").attr("name","");
	$("#phonenumber_popup_contents form").attr("action","");
}

function specific_deleteMobile(mobile) 
{
	
	$("#show_specific_ph_info").html("");
	$("#specific_phoneNUM .small_circle").removeClass("small_circle_selected");
	$("#specific_phoneNUM #deleteicon_circle").addClass("small_circle_selected");
	$("#show_specific_ph_info").html('<br /><div class="popup_header "><div class="popuphead_details"><span class="popuphead_text">'+delete_Mobile+'</span><span class="popuphead_define">'+formatMessage(err_mobile_sure_delete1, mobile)+'</span></div></div>');
	$("#show_specific_ph_info").append('<input class="primary_btn_check  " id="delete_specific_mob" type="button" value="'+iam_continue+'">');
	$("#delete_specific_mob").click(function(){
		
		var params = "mobile="+euc(mobile.trim())+"&"+csrfParam;//No I18N
		var url=contextpath+"/u/deleteMobile";//No i18N
		sendRequestURI(url,params,delete_phonum_callback);    
	    return false;
		
	});
}

function close_profile_popupscreen(callback)
{
	popupBlurHide("#profile_popup",function(){		//No I18N
		$("#profile_popup #pop_action").html("");
		if($("#phonenumber_web_more").is(":visible")){
			popup_blurHandler("6");
		}
		if(callback){
			callback();
		}
	});
}

function hasOneEmailNoOtherRecovery() {
	if(Object.keys(profile_data.Email).length === 1 && jQuery.isEmptyObject(profile_data.Phone.recovery)){
		return true;
	}
	return false;
}

function showVerifyMobileNum(countryCode,mobileNum,sec_count){
	set_popupinfo(i18nkeys["IAM.INVITAION.VERIFY.MOBILE"],formatMessage(mob_resend_conf, phonePattern.setMobileNumFormat(mobileNum,countryCode)),true);
	$("#pop_action").html(`<div id="verify_mobile_captcha"></div><button tabindex="0" class="primary_btn_check" id="popup_mobile_action" onclick='resendConfirmationCodeForMob("${countryCode}","${mobileNum}","${sec_count}")'><span>${i18nMobkeys["IAM.SEND.OTP"]}</span></button>`);
	closePopup(close_popupscreen,"common_popup");//No I18N
}

function getMfaDeleteContent(){
	var tempdiv = document.createElement("div");
    tempdiv.textContent = decodeHTML(i18nMobkeys["IAM.MFA.MOBILE.CANT.DELETE.DESC"]);
    var templink = document.createElement("div");
    templink.setAttribute("onclick", "loadTab('multiTFA','modes');"); //No i18N
    templink.classList.add("loadlink"); //No i18N
    templink.textContent = i18nMobkeys["IAM.MFA.GO.TO.MFA.SETTINGS"];
    tempdiv.append(templink);
    return tempdiv;
}

function deleteBtnTextChange(){
	var oldTrueBtnText = $("#return_true").text();
	$("#return_true").text(i18nkeys["IAM.DELETE"]); //No I18N
	$('#return_false').click(function() {
		popupBlurHide("#confirm_popup"); //No I18N
		setTimeout(function(){
			$('#return_true').text(oldTrueBtnText);
		},200);
		$('#return_false').unbind();
	});
}