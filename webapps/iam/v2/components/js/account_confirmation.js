//$Id$
var accConfirmObj = ZResource.extendClass({
	resourceName: "Confirmation",//No I18N
	identifier: "digest",	//No I18N  
	attrs:["password"]
});
function confirmAccount(){
	err_remove();
	var parms={};
	if(!hasPassword){
		  var pass = $("#passs_input");
		  var conf_pass = $("#confirm_pass_input");
		  if(validatePasswordPolicy().getErrorMsg(pass.val()))
			{
				$(pass).focus();
				return false;
			}
		  if(conf_pass.val()==""){
			  $("#confirm_pass_input").parent().append("<span class='err_text'>"+reenter_err+"</span>");
			  $("#confirm_pass_input").focus();
			  return false;
		  }
		  if(pass.val() != conf_pass.val()){
			  $("#confirm_pass_input").parent().append("<span class='err_text'>"+password_mismatch_err+"</span>");
			  $("#confirm_pass_input").focus();
			  return false;
		  }
		  var parms=
		  {
				  "password":pass.val()//No I18N
		  };
	}
	else if(isPasswordRequired){
		var pass = $("#confirm_pass_input");

		  if(pass.val()==""){
			  pass.parent().append("<span class='err_text'>"+current_pass_err+"</span>");
			  pass.focus();
			  return false;
		  }
		  if(pass.val().length < min_length){
			  pass.parent().append("<span class='err_text'>"+enter_valid_pass+"</span>");
			  pass.focus();
			  return false;
		  }
		  var parms=
		  {
				  "password": pass.val()	//No I18N
		  };
	}
	else{
		var pass=$(".textbox_div:last");
	}
	disabledButton(document.confirm_form.confirm_btn);
	
	var payload = accConfirmObj.create(parms);	
	payload.PUT(digest).then(function(resp){		//No I18N
		if(resp.code === "AC200"){
			redirectUrl = resp.confirmation.redirectUrl;
			removeButtonDisable(document.confirm_form.confirm_btn);
			showSuccessSignin();
		}
	},
	function(resp){
		removeButtonDisable(document.confirm_form.confirm_btn);
		$(".pass_allow_indi").removeClass("show_pass_allow_indi");
		if(resp.errors[0]){
			if(pass.hasClass("textbox_div")){
				pass.append("<span class='err_text'>"+getErrorMessage(resp)+"</span>");
				pass.focus();
			}
			else{
				pass.parent().append("<span class='err_text'>"+getErrorMessage(resp)+"</span>");
			}
		}
		else{
			$(".textbox_div:last").append("<span class='err_text'>"+network_common_err+"</span>");
		}
	});
}

function showSuccessSignin(){
	show_blur_screen();
	 $("#result_popup").show(0,function()
	 {
	     $("#result_popup").addClass("pop_anim");        
	 });
}

function show_hide_password()
{
	if($(" #password_field .textbox_icon").hasClass("visible_passsword"))
	{
		$("#password_field .textbox_icon").removeClass("icon2-show")
		$("#password_field .textbox_icon").addClass("icon2-hide")
		$("#password_field .textbox_icon").removeClass("visible_passsword")
		$("#password_field #confirm_pass_input").attr("type","password");
	}
	else
	{
		$("#password_field .textbox_icon").addClass("visible_passsword")
		$("#password_field .textbox_icon").addClass("icon2-show")
		$("#password_field #confirm_pass_input").attr("type","text");	//No I18N
	}
	return false;
}
function goToForgotPassword(){
	var searchparams = new URLSearchParams(window.location.search);
	var servicename = searchparams.get("servicename");
	var serviceurl= searchparams.get("serviceurl");
	var tmpResetPassUrl= resetPassUrl;
	if(servicename){
		tmpResetPassUrl += "?servicename=" + servicename; //No I18N
	}
	if(serviceurl){
		tmpResetPassUrl += "&serviceurl=" + serviceurl; //No I18N
	}
	if(LOGIN_ID && isEmailId(LOGIN_ID)){
		var oldForm = document.getElementById("recoveryredirection");
		if(oldForm) {
			document.documentElement.removeChild(oldForm);
		}
		var form = document.createElement("form");
		form.setAttribute("id", "recoveryredirection");
		form.setAttribute("method", "POST");
	    form.setAttribute("action", tmpResetPassUrl);
	    form.setAttribute("target", "_parent");

	    var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "LOGIN_ID");
		hiddenField.setAttribute("value", LOGIN_ID );
		form.appendChild(hiddenField);

		document.documentElement.appendChild(form);
		form.submit();
		return false;
	}
	window.location.href = tmpResetPassUrl;
}
function show_pass_policy()
{
	validatePasswordPolicy().init("#passs_input");//No I18N
}