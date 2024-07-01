// $Id: $
var minLen,minNumber,minSpecialChar,mixedCase,maxLen;
var validatedVariable = 0;
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
		if(err_rules.length!=0){
			$("input[name=password]").focus();
			return false;
		}
		var cpassword = frm.cpassword.value.trim();
		var password = frm.password.value.trim();
		if(!isValid(password)) {
			showCommonError("password",I18N.get("IAM.ERROR.PASSWORD.INVALID"));//no i18n
			return false;
		}
		if(!isppexist){
			var minlen = passwordPolicy[0] && passwordPolicy[0].minLength;
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
		encryptData.encrypt([password]).then(function(encryptedpassword) {
			encryptedpassword = typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
			var params ="password="+euc(encryptedpassword)+"&digest="+digest+"&is_ajax=true&servicename="+servicename;//no i18N
			callConfirmPassword(params);
		})
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
function showHidePassword(id){
	 var passType = $("#"+id).attr("type");//no i18n
	 viewpassword++;
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

var isfocus = 0;
var ppValidator;
var err_rules;
var viewpassword = 0;
function validateinit(){ 
	isfocus=1;
	ppValidator = validatePasswordPolicy(passwordPolicy);
	ppValidator.init("input[name=password]");//No I18N
	$("input[name=password]").attr("onkeyup","check_pp()");
}
function check_pp() {
	ppValidator.validate("input[name=password]");//no i18N
}
function checkData(val){
	return isValid(val) ?  true : false;
}
function validatePasswordPolicy(passwordPolicy) {
	passwordPolicy = passwordPolicy || PasswordPolicy.data;
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
				value = $('input[name=password]').val();
	 			value = value || '';
	 			value = value=='' ? $('input[name=password]').val() : value==undefined ? '' : value;
	 			callback = callback || setErrCallback;
	 			var rules = [];
	 			for(var i=0;i<passwordPolicy.length;i++){
	 				var passPolicy = passwordPolicy[i];
	 				rules[i] = checkData(passPolicy.minLength)  ? 'MIN' : checkData(passPolicy.maxLength) ? 'MAX' : checkData(passPolicy.minSplChar) ? 'SPL' : checkData(passPolicy.minNUmChar) ? 'NUM' : (checkData(passPolicy.isEnabled) && passPolicy.ErrorCode == "PP109") ? 'CASE' : checkData(passPolicy.containsLoginName) ? 'SAMELOGIN': "" ;//no i18n
	 			}
	 			err_rules = []; 
	 			var err_msg = []; 
	 			if(!isInit) {
	 				$('.pass_policy_rule').addClass('success');//No I18N
	 			}
	 			for(var i = 0; i < rules.length; i++) {
	 				var passPolicy = passwordPolicy[i];
	 				switch (rules[i]) {
	 					case 'MIN': //No I18N
	 						if(value.length<passPolicy.minLength) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get("IAM.PORTAL.CONFIRM.MINIMUM.PASSLEN"), passPolicy.minLength.toString()) : undefined));
	 						}
	 						break;
	 					case 'MAX': //No I18N
	 						if(value.length >= passPolicy.maxLength || (value == "")) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get("IAM.PORTAL.CONFIRM.MAXIMUM.PASSLEN"), passPolicy.maxLength.toString()) : undefined));
	 						}
	 						break;
	 					case 'SPL': //No I18N
	 						if((passPolicy.minSplChar && value=="") ||  (((value.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length) < passPolicy.minSplChar)) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passPolicy.minSplChar===1 ? "IAM.PASS_POLICY.SPL_SING": "IAM.PASS_POLICY.SPL"),passPolicy.minSplChar.toString()) : undefined));//no i18n
	 						}
	 						break;
	 					case 'NUM': //No I18N
	 						if((passPolicy.minNUmChar > 0) &&  (((value.match(new RegExp("[0-9]","g")) || []).length) < passPolicy.minNUmChar)){
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passPolicy.minNUmChar===1 ? "IAM.PASS_POLICY.NUM_SING" :"IAM.PASS.POLICY.NUM"), passPolicy.minNUmChar.toString()) : undefined));//no i18n
	 						}
	 						break;
	 					case 'CASE': //No I18N
	 						if(((passPolicy.isEnabled && passPolicy.ErrorCode == "PP109") && !((new RegExp("[A-Z]","g").test(value))&&(new RegExp("[a-z]","g").test(value)))) || value=="") {
	 							err_rules.push(callback(rules[i], isInit ? I18N.get("IAM.PORTAL.CONFIRM.MINIMUM.MIXEDCASE") : undefined));
	 						}
	 						break;
	 					case 'SAMELOGIN' : //No I18n
	 						if((passPolicy.containsLoginName && value === "") || value === emailid){
								 err_rules.push(callback(rules[i], isInit ? I18N.get("IAM.PASSWORD.POLICY.LOGINNAME") : undefined));
							 }
	 				}
	 			}
				 if(err_rules.length == 0){
					isfocus = 0;
 			    	$('.hover-tool-tip').css('opacity', 0);//No I18N
 			    	var offset = document.querySelector('.hover-tool-tip').getBoundingClientRect();//No I18N
 		 			$('.hover-tool-tip').css({
 		 				top: -offset.height,
 		 				left: -(offset.width + 15)
 		 			});
				 }else{
					var offset = document.querySelector('input[name=password]').getBoundingClientRect();//No I18N 
 		 			$('.hover-tool-tip').css({
 		 				top: offset.bottom + $(window).scrollTop() + 8,
 		 				left: offset.x,
 		 				width: offset.width
 		 			});
 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
				 }
	 			return err_rules.length && err_rules;
			}
		},
		init: function(passInputID) {
 			$('.hover-tool-tip').remove();//No I18N
 			var tooltip = document.createElement('div');//No I18N
 			tooltip.setAttribute("class", "hover-tool-tip no-arrow");//No I18N
 			var p = document.createElement('p');//No I18N
 			p.textContent = I18N.get("IAM.PASS_POLICY.HEADING");//No I18N
 			var ul = document.createElement('ul');//No I18N
 			var errList = this.getErrorMsg(undefined, initCallback);
 			if(errList) {
 				errList.forEach(function(eachLi) {
	 	 			ul.appendChild(eachLi);
	 			});
	 			tooltip.appendChild(p);
	 			tooltip.appendChild(ul);
	 			document.querySelector('body').appendChild(tooltip);//No I18N
	 			if(isfocus){
	 				var offset = document.querySelector(passInputID).getBoundingClientRect();
 		 			$('.hover-tool-tip').css({
 		 				top: offset.bottom + $(window).scrollTop() + 8,
 		 				left: offset.x,
 		 				width: offset.width
 		 			});
 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
	 			}
	 			$(passInputID).on('focus blur', function(e){//No I18N
	 			    if(e.type === 'focus' && viewpassword==0) {//No I18N
	 			    	var offset = document.querySelector(passInputID).getBoundingClientRect();
	 		 			$('.hover-tool-tip').css({
	 		 				top: offset.bottom + $(window).scrollTop() + 8,
	 		 				left: offset.x,
	 		 				width: offset.width
	 		 			});
	 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
	 			    } else {
	 			    	isfocus = 0;
	 			    	$('.hover-tool-tip').css('opacity', 0);//No I18N
	 			    	var offset = document.querySelector('.hover-tool-tip').getBoundingClientRect();//No I18N
	 		 			$('.hover-tool-tip').css({
	 		 				top: -offset.height,
	 		 				left: -(offset.width + 15)
	 		 			});
	 			    }
	 			    if(viewpassword!=0){viewpassword = 0;}
	 			});
 			}
 		},
 		validate: function(passInputID) {
			var str=$(passInputID).val();
			this.getErrorMsg(str, setErrCallback);
 		}
 		
	}
}
