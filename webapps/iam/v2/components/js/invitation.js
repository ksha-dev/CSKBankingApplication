//$Id$
var isFormSubmitted = false;



/***************************** Group Inviataion *********************************/



var GInvitation = ZResource.extendClass({
	  				resourceName: "GInvitation",//No I18N
	 				identifier: "digest",//No I18N
	 				attrs : ["firstname","lastname","country","country_state","newsletter","password","tos"]	//No I18N  
				});

function reject_group_invitation(ele) {
	if(isFormSubmitted) {
		return false;
	}
	isFormSubmitted = true;
	handleDisableBtn(ele);
	new URI(GInvitation,digest).DELETE().then(function(resp) {
	      showResultPopup(false,resp.redirect_link);
	},
  	function(resp) {
		show_group_invitation_error(getErrorMessage(resp));
  	}); 
}
function addBtnLoaderAndDisable(ele) {
	$(ele).find("span").addClass("loader");
	$(ele).addClass("btndisabled");
}

function removeBtnLoaderAndDisable(ele) {
	$(ele+" span").removeClass("loader");
	$(ele).removeClass("btndisabled");
}
function accept_group_invitation(signupRequired,ele) {
	if(isFormSubmitted) {
		return false;
	}
	err_remove();
	if(signupRequired) {	 
		var form = document.signup_form;
		if($(".group-input-form").is(":visible")){
			if(form.first_name.value.trim()==""){
				$(form.first_name).parent().append("<span class='err_text'>"+I18N.get("IAM.NEW.SIGNUP.FIRSTNAME.VALID")+"</span>");
				$(form.first_name).focus();
				return false;
			}
			if(form.password.value==""){
				  $(form.password).after("<span class='err_text'>"+I18N.get("IAM.ERROR.ENTER_PASS")+"</span>");
				  $(form.password).focus();
				  return false;
			}
			if(!validatePassword('#signup_pass')){
				$(form.password).after("<span class='err_text'>"+I18N.get("IAM.ERROR.CODE.U110")+"</span>");
				$(form.password).focus();
			  	return false;
			}
			if(form.tos_check.checked == false ){
				 $(form.tos_check).parent().after("<div class='err_text'>"+I18N.get("IAM.ERROR.TERMS.POLICY")+"</div");
				 return false;
			}
			var parms={
					"firstname"	:form.first_name.value,		//No I18N
					"lastname"	:form.last_name.value,		//No I18N
					"country"	:form.country.value,		//No I18N
					"newsletter":form.news_letter.checked,		//No I18N
					"password"	:form.password.value.trim(),			//No I18N
					"tos"       :form.tos_check.checked     // No I18N 
			};
			if(states_details[$("#localeCn").val().toLowerCase().trim()] && $("#locale_state").val() != null)
			{
				parms.country_state = form.country_state.value;
			}
		}
		else{
			$("#acceptGroupInvite").hide(0,function(){
				$("#signup_container").show();
			});	
			$(form.first_name).focus();
			setFooterPosition();
			return false;
		}
  	} else {
  		var parms={};
  	}
	encryptData.encrypt([parms.password]).then(function(encryptedpassword) {
		if(isValid(encryptedpassword)){
			parms.password =  typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value
		} 
		var payload = GInvitation.create(parms);
	    isFormSubmitted = true;
	    handleDisableBtn(ele);
	    payload.PUT(digest).then(function(resp) {
	        showResultPopup(true,resp.ginvitation.redirect_url);
	    },
	    function(resp) {
	    	show_group_invitation_error(getErrorMessage(resp));
	    });
		return false;
	}).catch(function(error) {
		// handle error
	});
}
function showResultPopup(isAccepted,link){
	var signupRequired = $(".group-user-signup").is(":visible");
	$(".main-container").addClass("hide");
	if(isAccepted){
		link+="/home#groups"; //No I18N
		$("#result_popup_accepted").removeClass("hide");
		$("#result_popup_accepted button").attr("onclick","redirectLink('"+link+"',this)");
		removeBtnLoaderAndDisable(".group-accept-btn"); //No I18N
	}
	else {
		if(signupRequired){
			link = I18N.get("IAM.HOME.LINK");
			$("#result_popup_rejected .button").html(I18N.get("IAM.GROUPINVITATION.GO.TO"));
		}
		$("#result_popup_rejected").removeClass("hide");
		$("#result_popup_rejected button").attr("onclick","redirectLink('"+link+"',this)");
		removeBtnLoaderAndDisable(".group-reject-btn"); //No I18N
	}
	$(".result_popup_box").removeClass("hide");
}
function showSignUpForm(){
	$(".signup-invite-box").hide();
	$(".group-input-form").removeClass("hide");
	$(".group-input-form #first_name").focus();
	validatePasswordPolicy().init('#signup_pass'); //No I18N
	setFooterPosition();
}

function checkConfirmPassword(ele){
	return $(ele).val() == $(ele).parent().next().children("input").val() ? true : false; //No I18N
}

function show_group_invitation_error(cause) 
{
	isFormSubmitted = false;
	removeBtnLoaderAndDisable(".group-accept-btn"); //No I18N
	removeBtnLoaderAndDisable(".group-reject-btn"); //No I18N
	showErrorMessage(cause);
}


function togglePassHide(ele,id) {
	if($(ele).siblings("#"+id).attr("type")=="password"){
		$(ele).siblings("#"+id).attr("type","text");//No I18N
		$(ele).removeClass("pass_hide");
	}
	else{
		$(ele).siblings("#"+id).attr("type","password"); //No I18N
		$(ele).addClass("pass_hide");
	}
}
function handleDisableBtn(btn) {
	addBtnLoaderAndDisable(btn);
	$(btn).siblings().addClass("btndisabled");
}
function showTextDp() {
	$(".group-icon_img").addClass("hide");
	$(".group-icon_text").removeClass("hide");
}

/***************************** Org  Inviatation *********************************/


var OrgUserInvitation = ZResource.extendClass(
{
		resourceName: "OrgUserInvitation",//No I18N
		identifier: "digest",//No I18N
		attrs : ["firstname","lastname","country","newsletter","country_state","password","photoPermission","account_type","tos","external"]	//No I18N  
});

function idp_confirmation_exiting_account()
{
	var parms={"account_type":"existing"};//No I18N
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
    var payload = OrgUserInvitation.create(parms);
    payload.PUT(digest).then(function(resp) 
    {
        show_resultpopup(true,resp.orguserinvitation.redirectUrl,false);
       $(".container").hide();
        $(".issues_contact").hide();
    },
    function(resp) 
    {
    	show_org_invitation_error(getErrorMessage(resp));
    }); 
}
function signin_acceptidp(idp_url)
{
	if(!user_loggedIn)
	{
		invitationSigninRedirect();
	}
	else
	{
		window.open(idp_url)
		return;
	}
	
}

function idp_signup_section(response_obj)
{
	$("#localeCn").select2('destroy');
	$("#signup_section #first_name").val(response_obj.first_name);
	$("#signup_section #last_name").val(response_obj.last_name);
	if(response_obj.curr_country!=undefined)
	{
		$("#signup_section #localeCn").val(response_obj.curr_country.toUpperCase());
	}
	setSelect2WithFlag('#localeCn');//No I18N
	
	$("#dp_pic").attr("onerror", "handleDpOption(this)");//No i18N
	$("#dp_pic").attr("src",response_obj.idp_dp);//No i18N
	
	$("#idp_heading").text(formatMessage(I18N.get("IAM.ORG.INVITATION.INVITE.HEADING"),response_obj.first_name+" "+response_obj.last_name));
	
	$("#profile-pic img").on('load',function(){
		$("#profile-pic .pro_pic_blur").css("background-image","url("+response_obj.idp_dp+")");	//No I18N
		$("#profile-pic img").css({"height":"auto","width":"auto"});	//No I18N
		if($("#profile-pic img")[0].height > $("#profile-pic img")[0].width){
			$("#profile-pic img").css({"height":"auto","width":"100%"});	//No I18N
		}
		else{
			$("#profile-pic img").css({"height":"100%","width":"auto"});	//No I18N				
		}

		$("#photo_permission").select2({
			theme : "photo_permission_theme",	//No I18N
			minimumResultsForSearch: Infinity,
			dropdownParent : $("#photo_permission").parents(".photo_permission_option"),		// No I18N
			templateResult: function(option){
				if (!option.id) { return option.text;}
				var ob = '<span class="permission_icon icon2-'+$(option.element).attr("id")+'"></span><span>'+option.text+'</span>';	//No I18N
				return ob;
			},
			templateSelection: function (option) {
				return '<span class="permission_icon icon2-'+$(option.element).attr("id")+'"></span>';
			},
			escapeMarkup: function (m) {
				return m;
			}
		});
		$(".photo_permission_option").show();
	});
	
	
	$(".content_box").hide();
	$("#signup_section").show();
	$(".container .invite_details").addClass("small_logo");
}

function updateHeading()
{
	$("#idp_heading").text(formatMessage(I18N.get("IAM.ORG.INVITATION.INVITE.HEADING"),$("#signup_form #first_name").val()+" "+$("#signup_form #last_name").val()));
}

function handleDpOption(ele)
{
	ele.src = user_2_png;
}

function signin_redirect()
{
	if(!user_loggedIn)
	{
		invitationSigninRedirect();
	}
	else
	{
		showmsg(I18N.get("IAM.ORG.INVITATION.SIGNIN_SUCCESSFUl")); 
		$("#accept_btn").html(I18N.get("IAM.CONTACTS.ACCEPT"));
		$("#accept_btn").attr("onclick","accept_org_invitation()");
	}
	return;
}

function check_restictuser_check()
{
	if($('#restrictorg_user').is(":checked"))
	{
		$("#accept_btn").attr("disabled", false);
		$("#accept_btn").removeClass("disabled_btn");
	}
	else
	{
		$("#accept_btn").attr("disabled", true);
		$("#accept_btn").addClass("disabled_btn");
	}
}

function invitationSigninRedirect()
{
	var oldForm = document.getElementById("invite_signin_redirect");
	if(oldForm) {
		document.documentElement.removeChild(oldForm);
	}
	var actionUrl = "";
	if(typeof(service_name) != "undefined" && service_name != undefined && service_name != null && service_name != "") {
		actionUrl = contextpath + "/signin?servicename=" + service_name + "&serviceurl="+euc(window.location.href); //no i18n
	} else {
		actionUrl = contextpath + "/signin?serviceurl="+euc(window.location.href); //no i18n	
	}
	var form = document.createElement("form");
	form.setAttribute("id", "invite_signin_redirect");
	form.setAttribute("method", "POST");
    form.setAttribute("action", actionUrl);
    form.setAttribute("target", "_self");
    
    var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "LOGIN_ID");
	hiddenField.setAttribute("value", login_id);
	form.appendChild(hiddenField);
	document.documentElement.appendChild(form);
	form.submit();
	return false;
}

function show_idp_signup_confirmation()
{
	$("#popup_signup").show(0,function(){
		$("#popup_signup").addClass("pop_anim");
	});
	$("#idp_signup_form").show();
	
	$(".blur").css({"z-index":'6',"opacity":'.5'});
	$('body').css({
	    overflow: "hidden" //No I18N
	});
	$("#idp_signup_form input:first").focus();
}

function idp_continue()
{
	err_remove();
	var form = document.signup_form;
	if(form.first_name.value=="")
	{
		$(form.first_name).parent().addClass("error_field_card");
		$(form.first_name).parent().append("<span class='err_text'>"+I18N.get("IAM.NEW.SIGNUP.FIRSTNAME.VALID")+"</span>");
		$(form.first_name).focus();
		return false;
	}
	if(form.tos_check.checked == false )
	{
		 $(form.tos_check).parent().append("<div class='chk_err_text'>"+I18N.get("IAM.ERROR.TERMS.POLICY")+"</div");
		 return false;
	}
	var parms=
	{
			"firstname"	  :form.first_name.value,		//No I18N
			"lastname"	  :form.last_name.value,		//No I18N
			"country"	  :form.country.value,		//No I18N
			"newsletter"  :form.news_letter.checked,		//No I18N
			"photoPermission"	:$("#photo_permission").val(),	//No I18N
			"account_type":"federated",					//No I18N
			"tos"       :form.tos_check.checked     // No I18N 
	};
	
	if(states_details[$("#localeCn").val().toLowerCase().trim()] && $("#locale_state").val() != null)	
	{ 
		parms.country_state=$('#'+form.id).find('select[name="state"]').val()//No I18N
	}
	
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
    var payload = OrgUserInvitation.create(parms);
    disabledButton("#signup_section .action_elements .blue_btn");
    payload.PUT(digest).then(function(resp) 
    {
    	$("#popup_signup").hide(0,function(){
    		$("#popup_signup").removeClass("pop_anim");
    	});
    	$("#idp_signup_form").hide();
        show_resultpopup(true,resp.orguserinvitation.redirectUrl,false);
       $(".container").hide();
        $(".issues_contact").hide();
    },
    function(resp) 
    {
    	show_org_invitation_error(getErrorMessage(resp));
    	removeButtonDisable("#signup_section .action_elements .blue_btn");//No I18N
    }); 
}

function accept_org_invitation()
{
	if(isFormSubmitted) 
	{
		return false;
	}
	if(signupRequired) 
	{	 
		var form = document.signup_form;
		if($("#signup_form").is(":visible"))
		{
			err_remove();	
			if(form.first_name.value.trim()=="")
			{
				$(form.first_name).parent().addClass("error_field_card");
				$(form.first_name).parent().append("<span class='err_text'>"+I18N.get("IAM.NEW.SIGNUP.FIRSTNAME.VALID")+"</span>");
				$(form.first_name).focus();
				return false;
			}
			if(isPasswordRequired=='true')//check if its not a saml case
			{
				if(form.password.value=="")
				{
					$(form.password).parent().addClass("error_field_card");
					$(form.password).parent().append("<span class='err_text'>"+I18N.get("IAM.ERROR.ENTER_PASS")+"</span>"); 
					$(form.password).focus();
					return false;
				}
				if(validatePasswordPolicy().getErrorMsg(form.password.value))
				{		
					$(form.password).focus();
					return false;
				}  
				var parms=
				{
						"firstname"	  :form.first_name.value,		//No I18N
						"lastname"	  :form.last_name.value,		//No I18N
						"country"	  :form.country.value,		//No I18N
						"newsletter"  :form.news_letter.checked,		//No I18N
						"password"	  :form.password.value.trim(),			//No I18N
						"account_type":"normal",					//No I18N
						"tos"         :form.tos_check.checked     // No I18N 
				};
			}
			else
			{
				var parms=
				{
						"firstname"	  :form.first_name.value,		//No I18N
						"lastname"	  :form.last_name.value,		//No I18N
						"country"	  :form.country.value,		//No I18N
						"newsletter"  :form.news_letter.checked,		//No I18N
						"account_type":"federated",						//No I18N
						"tos"         :form.tos_check.checked     // No I18N 
				};
			}
			if(form.tos_check.checked == false )
			{
				 $(form.tos_check).parent().append("<div class='chk_err_text'>"+I18N.get("IAM.ERROR.TERMS.POLICY")+"</div");
				 return false;
			}
			if(states_details[$("#localeCn").val().toLowerCase().trim()] && $("#locale_state").val() != null)			
			{ 
				parms.country_state=$('#'+form.id).find('select[name="state"]').val()//No I18N
			}
		}
		else
		{
			show_signup_section();
			return false;
		}
  	} 
	else 
  	{
		var addAsExternal = $("#restrictorg_user:checked").length == 1;
  		var parms={"account_type":"existing", "external":addAsExternal};//No I18N
  	}
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
    var payload = OrgUserInvitation.create(parms);
    isFormSubmitted = true;
    var disable_ele = signupRequired ? "#signup_action" :"#accept_btn";	//No I18N
    disabledButton(disable_ele);
    encryptData.encrypt([parms.password]).then(function(encryptedpassword) {
    	if(encryptData.isValidData(encryptedpassword)){
    		parms.password = typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
    	}
		payload.PUT(digest).then(function(resp) 
			    {
			    	$("#popup_signup").hide(0,function(){
			    		$("#popup_signup").removeClass("pop_anim");
			    	});
			    	$("#signup_form").hide();
			        show_resultpopup(true,resp.orguserinvitation.redirectUrl,false);
			        $(".container").hide();
			        $(".issues_contact").hide();
			        removeButtonDisable(disable_ele);
			    },
			    function(resp) 
			    {
			    	if(resp.errors[0].code=='OI108')//user exists in another DC show dcoument
			    	{
			    		$(document.signup_form.tos_check).parent().append("<span class='err_text'>"+getErrorMessage(resp)+"</span>");
			    	}
					else if(resp.errors[0].code=='OI113') //service team invitation prevalidation failed
					{
						$("#result_popup_rejected .grn_text").html(I18N.get("IAM.INVITATION.PRECHECK.ERROR.TITLE"));
						if(isValid(resp.redirect_link))
						{
							var message = resp.localized_message +" "+ I18N.get("IAM.ORG.INVITATION.REDIRECT.MESSAGE");
						}
						else
						{
							var message = resp.localized_message;
						}
						$("#result_popup_rejected .defin_text").html(message);
				        show_resultpopup(false, resp.redirect_link, false);
				        $(".container").hide();
					}
			    	else
			    	{
			    		show_org_invitation_error(getErrorMessage(resp));
			    	}
			    	 isFormSubmitted = false;
			    	 removeButtonDisable(disable_ele);
			    });
	}).catch(function(error) {
		// handle error
	});
}

function check_pp(cases,spl,num,minlen){
	validatePasswordPolicy().validate("#signup_form","#signup_pass"); //No I18N
}


function show_hide_password()
{
	if($("#signup_section #password_field .textbox_icon").hasClass("visible_passsword"))
	{	
		$("#signup_section #password_field .textbox_icon").removeClass("icon-show")
		$("#signup_section #password_field .textbox_icon").addClass("icon-hide")
		$("#signup_section #password_field .textbox_icon").removeClass("visible_passsword")
		$("#signup_section #password_field #signup_pass").attr("type","password");	
	}
	else
	{
		$("#signup_section #password_field .textbox_icon").addClass("visible_passsword")
		$("#signup_section #password_field .textbox_icon").addClass("icon-show")
		$("#signup_section #password_field #signup_pass").attr("type","text");	//No I18N
	}
	return false;
}

function show_signup_section()
{
	validatePasswordPolicy().init("#signup_pass");//No I18N
	
	if(isPasswordRequired=='true')//check if its a saml case
	{
		$("#signup_section #password_field").show();
	}
	else
	{
		$("#signup_section #password_field").hide();
	}
		
//	$("#basic_info_box").slideUp(300,function()
//	{
		$("#basic_info_box").hide();
		$("#signup_section").show();
		//$(".container .invite_details").addClass("small_logo");
		
//	});
	
	
}

function back_toinfo()
{
//	$("#signup_section").slideUp(500,function()
//	{
		$("#signup_section").hide();
		$("#basic_info_box").show();
		$(".container .invite_details").removeClass("small_logo");
		
//	});
}


function reject_org_invitation() 
{
	if(isFormSubmitted) 
	{
		return false;
	}
	
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
	isFormSubmitted = true;
	disabledButton("#signup_section .action_elements .grey_btn");//No I18N
	new URI(OrgUserInvitation,digest).DELETE().then(function(resp) 
	{
	      show_resultpopup(false,resp.redirectUrl!=undefined?resp.redirectUrl:"",false);
	     $(".container").hide();
        $(".issues_contact").hide();
	},
  	function(resp) 
  	{
		show_org_invitation_error(getErrorMessage(resp));
		removeButtonDisable("#signup_section .action_elements .grey_btn");//No I18N
  	}); 
}

function show_org_invitation_error(cause) 
{
	isFormSubmitted = false;
	removeButtonDisable(".disable_button");//No I18N
	showErrorMessage(cause);
}



function check_state()
{
	check_news_letter_check();
	if(states_details[$("#localeCn").val().toLowerCase().trim()])
	{ 
		  $("#locale_state").find('option').not(':first').remove();// remove previous countries state details exepct the default one i.e. select state
		  $("#gdpr_us_state").addClass("show_field");
		  $("#locale_state").html(($("#locale_state").html()+states_details[$("#localeCn").val().toLowerCase().trim()]));
	}
	else
	{
		$("#gdpr_us_state").removeClass("show_field");
	}
}

function check_news_letter_check()
{
	var newsletter_mode = $("#localeCn option:selected").attr("data-subscriptionmode");
	
	var newsletterEle = $('#news_letter');
	if(newsletter_mode == NewsLetterSubscriptionMode.SHOW_FIELD_WITH_CHECKED) {
		$("#news_letter").prop("checked", true);
        $('.news_letter_chk').css('display','grid'); //No I18N
	} else if(newsletter_mode == NewsLetterSubscriptionMode.SHOW_FIELD_WITHOUT_CHECKED || newsletter_mode == NewsLetterSubscriptionMode.DOUBLE_OPT_IN) {
		$("#news_letter").prop("checked", false);
        $('.news_letter_chk').css('display','grid'); //No I18N
	} else {
		newsletterEle.removeClass('unchecked').addClass('checked');
		$("#news_letter").prop("checked", true);
        $('.news_letter_chk').css('display','none'); //No I18N
	}
}

/***************************** org merge Inviataion *********************************/


var OrgMergeInvitation = ZResource.extendClass(
{
		resourceName: "OrgMerge",//No I18N
		identifier: "digest",//No I18N
		attrs : ["zaaids"]
});


function fetch_details()
{
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
	new URI(OrgMergeInvitation,digest).GET().then(function(resp)
	{
		if(resp.status_code==404)
		{
			$(".merge_conflict .conflict_details").html(getErrorMessage(resp));
			$(".merge_conflict").show();
			$(".copy_txt").attr("onclick","clipboard_copy()");
			$(".copy_txt").attr("title",I18N.get("IAM.APP.CLICK.COPY"));//No i18N
			tippy(".copy_txt",{//No I18N
		    		trigger:"mouseenter",	//No I18N
		    		arrow:true
			})
		}
		else
		{
			$("#user_count .grid_value").text(resp.org_details.user_count);
			$("#group_count .grid_value").text(resp.org_details.group_count);
			$("#domain_count .grid_value").text(resp.org_details.domain_count);
			service_ids="";
			if(JSON.stringify(resp.app_accounts) != '{}')
			{
				var app_accounts=resp.app_accounts;
				var all_services=Object.keys(resp.app_accounts);
				var count = 0;
				service_ids="[";
				$("#app_accout_space").html();
				for(var i=0;i<all_services.length;i++)
				{
					var service_det=resp.app_accounts[all_services[i]];
					for(var j=0;j<service_det.length;j++)
					{
						$("#app_accout_space").append('<div class="service_grid" id="service_template"><span class="product_icon"></span><span class="service_text"></span></div>');
						var id=Object.keys(service_det[j]);
						service_ids+=parseInt(id)+",";
						count++;
						if(count>6)//more than 5 then show as view more
						{
							$("#app_accout_space #service_template").addClass("hide");
						}
						//params.zaaids.push({id}):
					//	String[] data = {"stringone", "stringtwo"};
						$("#app_accout_space #service_template").attr("id","service_"+id);
						$("#app_accout_space #service_"+Object.keys(service_det[j])+" .service_text").html(service_det[Object.keys(service_det)[j]][id]);
						$("#app_accout_space #service_"+Object.keys(service_det[j])+" .product_icon").addClass("icon_"+all_services[i].replace(/\s/g, ''));//No I18N
					}
				}
				
				if(count>6)
				{
					$("#app_accout_space").append('<div class="service_grid" id="extra_service_template" onclick="show_all_services()"><span class=" blue_txt service_text">'+formatMessage(I18N.get("IAM.SERVICE.COUNT"),(count-6)+"")+'</span></div>')
				}
				service_ids = service_ids.slice(0, -1) + "]";
			}
			else
			{
				$(".org_merge_container .service_info").hide();	
			}
			
			$(".org_merge_details").removeClass("hide");
			$("#contact_admin").show();
		}
		$(".loader").hide();
	},
	function(resp)
	{
		$(".merge_conflict .conflict_details").html(getErrorMessage(resp));
		$(".merge_conflict").show();
		$(".loader").hide();
		$(".copy_txt").attr("onclick","clipboard_copy()");
		$(".copy_txt").attr("title",I18N.get("IAM.APP.CLICK.COPY"));//No i18N
		tippy(".copy_txt",{//No I18N
	    		trigger:"mouseenter",	//No I18N
	    		arrow:true
		})
	});
}

function show_all_services()
{
	$("#extra_service_template").hide();
	$("#app_accout_space .service_grid").removeClass("hide");
	
}

function process_merge_request(status)
{
	URI.options.contextpath=contextpath+"/webclient/v1";//No I18N
	URI.options.csrfParam = csrfParamName;
	URI.options.csrfValue = getCookie(csrfCookieName);
	if(status)
	{
		if(service_ids!="")
		{
			var parms={"zaaids":JSON.parse(service_ids)}//No I18N
		}
		var parms={};
		var payload = OrgMergeInvitation.create(parms);
	    var disable_ele = "#accept_btn";	//No I18N
	    disabledButton(disable_ele);
	    payload.PUT(digest).then(function(resp) 
	    {
	    	$("#result_popup_accepted .defin_text").html(resp.localized_message);
	        show_resultpopup(true,"",true);
	        $(".container").hide();
	    },
	    function(resp) 
	    {
	    	show_org_invitation_error(getErrorMessage(resp));
	    	 isFormSubmitted = false;
	    });
	}
	else
	{
		new URI(OrgMergeInvitation,digest).DELETE().then(function(resp) 
		{
		    show_resultpopup(false,"",true);
		    $(".container").hide();
		},
	  	function(resp) 
	  	{
			show_org_invitation_error(getErrorMessage(resp));
	  	}); 
	}
}

/***************************** clipboard copy *********************************/

function clipboard_copy()
{	
	
    var range = document.createRange();
    range.selectNode(document.getElementsByClassName("copy_txt")[0]);
    window.getSelection().removeAllRanges();
    window.getSelection().addRange(range);
    document.execCommand("copy");//No I18N
    window.getSelection().removeAllRanges();
    if($(".copy_txt").attr("data-original-title")==I18N.get("IAM.APP.CLICK.COPY")){
    	$(".copy_txt")[0]._tippy.destroy();
    }   
    if(document.querySelector('.copy_txt[data-tippy]')==null){
    	$(".copy_txt").attr("title","<div class='tick'>"+I18N.get("IAM.APP.PASS.COPIED")+"</div>");
    	tippy(".copy_txt",{//No I18N
    		allowHTML: true,
    		arrow:true,
    		onHidden:tooltip_outFunc,
			trigger: 'click mouseenter'	//No I18N	
    	});
    }
	document.querySelector('.copy_txt[data-tippy]')._tippy.show();//No I18N
	
}

function tooltip_outFunc()
{
		document.querySelector('.copy_txt[data-tippy]')._tippy.destroy();//No I18N
		$(".copy_txt").attr("title",I18N.get("IAM.APP.CLICK.COPY")); //No I18N
		tippy(".copy_txt",{//No I18N
    		arrow:true,
    		trigger: 'mouseenter'	//No I18N	
		});
}






/***************************** Common  Inviatation js functions *********************************/

function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}

function redirectnow(link,ele){
	if(ele)
	{
		disabledButton(ele);
	}
	if(_time!=undefined	&&	_time!="")
	{
		clearTimeout(_time);
	}
	 window.location.href = link;
}

function show_resultpopup(is_accepted,link,is_blur) {
	isFormSubmitted = false;
	removeButtonDisable(".disable_button");//No I18N
	is_blur==undefined?is_blur=true:"";
	if(is_blur)
	{
		show_blur_screen();
	}
	if(is_accepted){
		$("#result_popup_accepted").show(0,function() {
			$("#result_popup_accepted").addClass("pop_anim");   
			if(isValid(link))
			{
				$("#result_popup_accepted button").attr("onclick","redirectnow('"+link+"',this)");
				_time = setTimeout(function() 
				{
					redirectLink(link);
				}, 5000);
			}
			else
			{
				$("#result_popup_accepted button").hide();
			}

		});  
		
	} else{
		$("#result_popup_rejected").show(0,function() {
			$("#result_popup_rejected").addClass("pop_anim");  
			if(isValid(link))
			{
				$("#result_popup_rejected button").attr("onclick","redirectnow('"+link+"',this)");
				$("#result_popup_rejected button").show();
				if($(".redirect_txt").length!=0)
				{
					$(".redirect_txt").show();
				}
				_time = setTimeout(function() 
				{
					redirectLink(link);
				}, 5000);
			}
			else
			{
				$("#result_popup_rejected button").hide();
				if($(".redirect_txt").length!=0)
				{
					$(".redirect_txt").hide();
				}
			}
		}); 
		
	}
}


function setSelect2WithFlag(ele){
	$(ele).select2({
		width : "250px",	//No I18N
		templateResult: function(option){
	        var spltext;
	    	if (!option.id) { return option.text; }
	    	spltext=option.text.split("(");
	    	var string_code = $(option.element).attr("value");
	    	var ob = '<div class="pic flag_'+string_code.toUpperCase()+'" ></div><span class="cn">'+spltext[0]+"</span>" ;
	    	return ob;
		},
		language: {
	        noResults: function(){
	            return I18N.get("IAM.NO.RESULT.FOUND");
	        }
	    },
		templateSelection: function (option) {
		    selectFlag($(option.element));
		    return option.text;
		},
		escapeMarkup: function (m) {
			return m;
		}
	}).on("select2:open", function() {
	       $(".select2-search__field").attr("placeholder", I18N.get("IAM.SEARCH")+'...');//No I18N
	});
	$(ele+"+.select2 .select2-selection").append("<span id='selectFlag' class='selectFlag'></span>");
	selectFlag($(document.signup_form.country).find("option:selected"));	
}

function selectFlag(e){
    var flagpos = "flag_"+$(e).val().toUpperCase();//No i18N
    $(".select2-selection__rendered").attr("title","");
    e.parent().siblings(".select2").find("#selectFlag").attr("class","");//No i18N
    e.parent().siblings(".select2").find("#selectFlag").addClass("selectFlag"); //No I18N  
    e.parent().siblings(".select2").find("#selectFlag").addClass(flagpos); //No I18N  
}