// $Id: $
var minLen,minNumber,minSpecialChar,mixedCase,maxLen;
function confirmpassword(frm){
	var password = frm.password.value.trim();
	if(!isValid(password)) {
		showCommonError("password",I18N.get("IAM.ERROR.PASSWORD.INVALID"));//no i18n
		return false;
	}
	var digest = getParamFromURL("digest");//no i18n
	var servicename = getParamFromURL("servicename");//no i18n
	var params ="password="+euc(password)+"&digest="+digest+"&is_ajax=true&servicename="+servicename;//no i18N
	callConfirmPassword(params);
	return false;
}
function getParamFromURL(param){
	var url = window.location.href;
	url = new URL(url);
	var digest = url.searchParams.get(param);
	return digest;
}
function addpassword(frm){
		var cpassword = frm.cpassword.value.trim();
		var password = frm.password.value.trim();
		if(!isValid(password)) {
			showCommonError("password",I18N.get("IAM.ERROR.PASSWORD.INVALID"));//no i18n
			return false;
		}
		if(!isppexist){
			var minlen = passwordPolicy[0] && passwordPolicy[0].minlen;
			if(password.length < minlen){
				showCommonError("password",formatMessage(I18N.get("IAM.ERROR.PASS.LEN"),minlen+""));//no i18n
				return false;
			}
		}
		if(!isValid(cpassword)) {
			showCommonError("cpassword",I18N.get("IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.INVALID"));//no i18n
			return false;
		}
		if (password != cpassword) {
			frm.cpassword.value="";
			$("cpassword").focus();
			showCommonError("cpassword",I18N.get("IAM.PORTAL.NEW.CREATE.PASSWORD.REENTER.NOTMATCH"));//no i18n
            return false;
        }
		var digest = getParamFromURL("digest");//no i18n
		var servicename = getParamFromURL("servicename");//no i18n
		var params ="password="+euc(password)+"&digest="+digest+"&is_ajax=true&servicename="+servicename;//no i18N
		callConfirmPassword(params);
		return false;
}
function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}
function callConfirmPassword(params){
	$.ajax({
	      type: "POST",// No I18N
	      url: actionurl,
	      data: params,
	      success: function(data){
	    	  if(data.data && data.data.url){
	    		  if(loadIframe){
	    			  window.location.href = url; 
	    			  return false;
	    		  }
	    		  window.top.location.href = data.data.url;
	    		  return false;
	    	  }
	    	  else if(data.result === "success" || data.data && data.data.result === "success"){
		    	  //success implementaion
		    	  $(".confirmaccount_container").hide(); $(".success_container").show();
		    	  return false;
		      }
		      else if(data && data.error && data.error.msg){
		    		showCommonError("password",data.error.msg);//no i18n
		    		return false;
		    	}
		    	return false;
		      },
		  error:function(data){
			  var response =data.responseText;
			  response = JSON.parse(response);
		    	if(response && response.error && response.error.msg){
		    		showCommonError("password",response.error.msg);//no i18n
		    		return false;
		    }
		  }
	   });
	return false;
}
function showHidePassword(){
	var passType = $("#password").attr("type");//no i18n
	if(passType==="password"){
		$("#password").attr("type","text");//no i18n
		$(".show_hide_password").addClass("icon-show");
	}else{
		$("#password").attr("type","password");//no i18n
		$(".show_hide_password").removeClass("icon-show");
	}
	$("#password").focus();
}
function showCommonError(field,message){ 	
	$('.fielderror').val('');
	var container=field+"_container";//no i18N
	$("#"+field).addClass("errorborder");
	$("#"+container+ " .fielderror").addClass("errorlabel");
	$("#"+container+ " .fielderror").html(message);
	$("#"+container+ " .fielderror").slideDown(200);
	$("#"+field).focus();
	return false;
}
function clearCommonError(field){
	var container=field+"_container";//no i18N
	$("#"+field).removeClass("errorborder");
	$("#"+container+ " .fielderror").slideUp(100);
	$("#"+container+ " .fielderror").removeClass("errorlabel");
	$("#"+container+ " .fielderror").text("");
}
function setPasswordPolicy(){
	var listvalue = "<div class='ppheader'>"+I18N.get('IAM.PASS_POLICY.HEADING')+"</div><ul>";
	for (var i=0;i<passwordPolicy.length;i++) {
		var passInfo = passwordPolicy[i];
		if(passInfo.minlen){
			minLen = passInfo.minlen;
			listvalue+="<li class='minlen'>"+formatMessage(I18N.get("IAM.PORTAL.CONFIRM.MINIMUM.PASSLEN"),passInfo.minlen+"")+"</li>";
		}
		if(passInfo.minsplchar){
			minSpecialChar = passInfo.minsplchar;
			var templatecontent = minSpecialChar == 1 ? "IAM.PASS_POLICY.SPL_SING" : "IAM.PASS_POLICY.SPL";//no i18n
			listvalue+="<li class='specialchar'>"+formatMessage(I18N.get(templatecontent),passInfo.minsplchar+"")+"</li>";//no i18n
		}
		if(passInfo.minnumchar){
			minNumber = passInfo.minnumchar;
			var templatecontent = minNumber == 1 ? "IAM.PASS_POLICY.NUM_SING" : "IAM.PASS_POLICY.NUM";//no i18n
			listvalue+="<li class='numberchar'>"+formatMessage(I18N.get(templatecontent),passInfo.minnumchar+"")+"</li>";//no i18n
		}
		if(passInfo.mixedcase){
			mixedCase = passInfo.mixedcase;
			listvalue+="<li class='mixedcase'>"+I18N.get("IAM.PORTAL.CONFIRM.MINIMUM.MIXEDCASE")+"</li>";//no i18n
		}
		if(passInfo.maxlen){
			maxLen = passInfo.maxlen;
			listvalue+="<li class='maxlen'>"+formatMessage(I18N.get("IAM.PORTAL.CONFIRM.MAXIMUM.PASSLEN"),passInfo.maxlen+"")+"</li>";//no i18n
		}
	}
	listvalue+="</ul>";
	$(".passwordpolicy").html(listvalue);
}
var I18N = {
		data : {},
		load : function(arr) {
			$.extend(this.data, arr);
			return this;
		},
		get : function(key, args) {
			// { portal: "IAM.ERROR.PORTAL.EXISTS" }
			if (typeof key == "object") {
				for ( var i in key) {
					key[i] = I18N.get(key[i]);
				}
				return key;
			}
			var msg = this.data[key] || key;
			if (args) {
				arguments[0] = msg;
				return Util.format.apply(this, arguments);
			}
			return msg;
		}
};
function formatMessage() {
    var msg = arguments[0];
    if(msg != undefined) {
	for(var i = 1; i < arguments.length; i++) {
	    msg = msg.replace('{' + (i-1) + '}', escapeHTML(arguments[i]));
	}
    }
    return msg;
}
function escapeHTML(value) {
	if(value) {
		value = value.replace("<", "&lt;");
		value = value.replace(">", "&gt;");
		value = value.replace("\"", "&quot;");
		value = value.replace("'", "&#x27;");
		value = value.replace("/", "&#x2F;");
    }
    return value;
}
function euc(i) {
	return encodeURIComponent(i);
}
function showPasswordHint(){
	if(isppexist){
		var aspectpp = $("#password")[0].getBoundingClientRect();
		isMobile ? $(".passwordpolicy").css("top", aspectpp.height+10).css("width",aspectpp.width): $(".passwordpolicy").css("left",aspectpp.width+20).css("width",aspectpp.width - 40);
		$(".passwordpolicy").show();
	}
	return false;
}
function hidePasswordHint(){
	$(".passwordpolicy").hide();
	return false;
}
function validatePasswordPolicy(){
	var password = $("#password").val();
	var validatedVariable = 0;
	if(password.length >= minLen){
		$(".minlen").css("color","#008000");
		validatedVariable++;
	}
	if(minNumber && Validator.isNumberContains(password)){
		$(".numberchar").css("color","#008000");
		validatedVariable++;
	}
	if(minSpecialChar && Validator.isSpecialCharecterContains(password)){
		$(".specialchar").css("color","#008000");
		validatedVariable++;
	}
	if(mixedCase && Validator.isMixedCase(password)){
		$(".mixedcase").css("color","#008000");
		validatedVariable++;
	}
	if(password.length <= maxLen){
		$(".maxlen").css("color","#008000");
		validatedVariable++;
	}
	if(password.length < minLen){
		$(".minlen").css("color","#000");
	}
	if(minNumber && !Validator.isNumberContains(password)){
		$(".numberchar").css("color","#000");
	}
	if(minSpecialChar && !Validator.isSpecialCharecterContains(password)){
		$(".specialchar").css("color","#000");
	}
	if(mixedCase && !Validator.isMixedCase(password)){
		$(".mixedcase").css("color","#000");
	}
	if(password.length > maxLen || password.length == 0){
		$(".maxlen").css("color","#000");
	}
	return (validatedVariable == passwordPolicy.length-1) ? enablebutton() : false;
}
function enablebutton(){
	$("#nextbtn").prop("disabled", false);
	return true;
}
function validateFinal(){
	if($("#nextbtn").prop("disabled")){
		showPasswordHint();
	}else{
		return true;
	}
}
function showHidePassword(id){
	 var passType = $("#"+id).attr("type");//no i18n
	 if(passType==="password"){
		 $("#"+id).attr("type","text");//no i18n
		$("#"+id+"~.show_hide_password").addClass("icon-show");
	 }else{
		 $("#"+id).attr("type","password");//no i18n
		 $("#"+id+"~.show_hide_password").removeClass("icon-show");
	 }
	 var fieldval = $("#"+id).val();
	 $("#"+id).val("").val(fieldval).focus();
	 return false;
}