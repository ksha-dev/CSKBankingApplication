/*$Id$*/
var ppValidator;
  function showPasswordExpiry(pwdpolicy,successCode){
		$("#signin_div,.rightside_box").hide();
		$(".password_expiry_container").show();
		$(".signin_container").addClass("mod_container");
		var expiry_days = pwdpolicy.expiry_days && pwdpolicy.expiry_days.toString();
		var descMsg = {"P500": formatMessage(I18N.get("IAM.NEW.PASSWORD.EXPIRY.DESC"),expiry_days), "P501" : I18N.get("IAM.NEW.PASSWORD.EXPIRY.ONE.TIME.DESC"), "P506" : I18N.get("IAM.NEW.PASSWORD.EXPIRY.POLICY.UPDATED.DESC")}; // no i18n
		$("#password_desc").html(descMsg[successCode]);
		if(pwdpolicy!=undefined)
		{
			$("#npassword_container").attr("onkeyup","check_pp()");
			var loginName = de("login_id").value;//no i18N
			$("#changepassword").attr("onclick",'updatePassword('+pwdpolicy.min_length+','+pwdpolicy.max_length+',"'+loginName+'")');
		}
		if(pwdpolicy==undefined)
		{
			var mix_cases=true,spl_char=1,num=1,minlen=8,maxlen=250;
		}
		else
		{
			var mix_cases=pwdpolicy.mixed_case;
			var spl_char=pwdpolicy.min_spl_chars;
			var num=pwdpolicy.min_numeric_chars;
			var minlen=pwdpolicy.min_length;
			var maxlen=pwdpolicy.max_length;
		}
		ppValidator = validatePasswordPolicy(pwdpolicy || {
			mixed_case: mix_cases,
			min_spl_chars : spl_char,
			min_numeric_chars: num,
			min_length: minlen,
			max_length: maxlen
		});
		ppValidator.init("#npassword_container input");//no i18n
		return false;
	}
  function checkboxEvent(){
	  $("#terminate_session_form input[type=checkbox]").change(function(){
	  if($(this).is(":checked")){
	  	$("#terminate_session_submit").attr("disabled",false);
	  	$("#terminate_session_submit").css("cursor","pointer");
	  }else{
	  	$("#terminate_session_form input[type=checkbox]:visible").each(function(){
	  		if($(this).is(":checked")){
	  			$("#terminate_session_submit").attr("disabled",false);
	  			return false;
	  		}else{
	  			$("#terminate_session_submit").attr("disabled",true);
	  			$("#terminate_session_submit").css("cursor","default");
	  		}
	  	});
	  	
	  	
	  }
  	}); 
  }
  function updatePassword(min_Len,max_Len,login_name) {
		remove_error();
	    var newpass = $('#new_password').val().trim();
	    var confirmpass = $('#new_repeat_password').val().trim();
	    var passwordErr = ppValidator.getErrorMsg(newpass);
	    if(isEmpty(newpass)) {
	    	if(!$('#npassword_container div').hasClass("fielderror")){
	    		$('#npassword_container').append( '<div class="fielderror"></div>' );
	    	}
	    	showCommonError("npassword", I18N.get('IAM.ERROR.ENTER.NEW.PASS'));//no i18n
	    	$('#new_password').val("");
	    	$('#new_repeat_password').val("");
	    	$('#new_password').focus();
	    	return false;
	    } else if(passwordErr){
	    	$('#new_password').focus();
	    	return false;
	    } else if(newpass == login_name) {
	    	if(!$('#npassword_container div').hasClass("fielderror")){
	    		$('#npassword_container').append( '<div class="fielderror"></div>' );
	    	}
	    	showCommonError("npassword", I18N.get('IAM.PASSWORD.POLICY.LOGINNAME'));//no i18n
	    	$('#new_password').focus();
	    	return false;
	    } else if(isEmpty(confirmpass)){
	    	if(!$('#rpassword_container div').hasClass("fielderror")){
	    		$('#rpassword_container').append( '<div class="fielderror"></div>' );
	    	}
	    	showCommonError("rpassword", I18N.get('IAM.PASSWORD.CONFIRM.PASSWORD'));//no i18n
	    	$('#new_repeat_password').focus();
	    	return false;
	    } else if(newpass != confirmpass){
	    	if(!$('#rpassword_container div').hasClass("fielderror")){
	    		$('#rpassword_container').append( '<div class="fielderror"></div>' );
	    	}
	    	showCommonError("rpassword", I18N.get('IAM.NEW.PASSWORD.NOT.MATCHED.ERROR.MSG'));//no i18n
	    	$('#new_repeat_password').focus();
	    	return false;
	    }
	    encryptData.encrypt([newpass]).then(function(encryptedpassword) {
	    	encryptedpassword = typeof encryptedpassword[0] == 'string' ? encryptedpassword[0] : encryptedpassword[0].value;
		    var loginurl = uriPrefix + "/signin/v2/password/"+zuid+"/expiry?";//no i18N
		    var jsonData = {'expiry':{'newpwd':encryptedpassword}};//no i18N
		    sendRequestWithTemptoken(loginurl,JSON.stringify(jsonData),true,handlePasswordExpiry);
		    $("#changepassword span").addClass("zeroheight");
			$("#changepassword").addClass("changeloadbtn");
			$("#changepassword").attr("disabled", true);
	    });
	    return false;
	}
	function handlePasswordExpiry(resp){
		if(IsJsonString(resp)) {
			var jsonStr = JSON.parse(resp);
			var statusCode = jsonStr.status_code;
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) {
				if(jsonStr.expiry.status === "success"){
					$("#termin_mob").removeClass("show_oneauth");
					$(".oneAuthLable").hide();
					if(jsonStr.expiry.sess_term_tokens!=undefined	&&	jsonStr.expiry.sess_term_tokens.length>0)
					{
						if(jsonStr.expiry.sess_term_tokens.indexOf("rmwebses")==-1)
						{
							$("#terminate_web_sess").hide();
						}
						if(jsonStr.expiry.sess_term_tokens.indexOf("rmappses")==-1)
						{
							$("#terminate_mob_apps").hide();
						}
						else if(jsonStr.expiry.sess_term_tokens.indexOf("inconeauth")==-1)
						{
							$("#termin_mob").removeClass("show_oneauth");
						}
						else
						{
							$("#termin_mob").addClass("show_oneauth");
						}
						if(jsonStr.expiry.sess_term_tokens.indexOf("rmapitok")==-1)
						{
							$("#terminate_api_tok").hide();
						}
						$(".password_expiry_container").hide();
						$(".terminate_session_container").show();
					}
					else
					{
						send_terminate_session_request(document.terminate_session_container);
					}
				}
			}else{
				if(!$('#npassword_container div').hasClass("fielderror")){
	    			$('#npassword_container').append( '<div class="fielderror"></div>' );
	    		}
				showCommonError("npassword",jsonStr.localized_message); //no i18n
			}
		}
		else 
		{
			showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		}
		$("#changepassword span").removeClass("zeroheight");
		$("#changepassword").removeClass("changeloadbtn");
		$("#changepassword").attr("disabled", false);
		return false;
	}

	function send_terminate_session_request(formElement)
	{
		var terminate_web=$('#'+formElement.id).find('input[name="signoutfromweb"]').is(":checked");
		var terminate_mob=$('#'+formElement.id).find('input[name="signoutfrommobile"]').is(":checked");
		var terminate_api=$('#'+formElement.id).find('input[name="signoutfromapiToken"]').is(":checked");
		var include_oneAuth=$('#'+formElement.id).find('#include_oneauth').is(":checked");
		
		if((terminate_web || terminate_mob || terminate_api || include_oneAuth) && !$("#terminate_session_skip").hasClass("triggerSkip")){
			var jsonData =
						{
							"expirysessionterminate"://No I18N
							{
								"rmwebses" :terminate_web,//No I18N  
								"rmappses" :terminate_mob,//No I18N  
								"inconeauth" :include_oneAuth,//No I18N 
								"rmapitok" :terminate_api//No I18N 
							}
						};
	   
			var terminate_session_url = uriPrefix + "/signin/v2/password/"+zuid+"/expiryclosesession"; //no i18N
			sendRequestWithTemptoken(terminate_session_url,JSON.stringify(jsonData),true,handle_terminate_session,"PUT");//no i18N
		}else{
			showPasswordConfirmation();
			$(".ppsuccess_head, .ppsuccess_desc").html("");
			$(".ppsuccess_head").html(I18N.get("IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED"));
			$(".ppsuccess_desc").html(formatMessage(I18N.get("IAM.NEW.PASSWORD.EXPIRY.PASSWORD.CHANGED.DESC"), deviceauthdetails.lookup.loginid));
		}
		
		$("#terminate_session_submit span").addClass("zeroheight");
		$("#terminate_session_submit").addClass("changeloadbtn");
		$("#terminate_session_submit").attr("disabled", true);
		
		return false;
	}
	function skipterminate(){
		$("#terminate_session_skip").addClass("triggerSkip");
	}
	function handle_terminate_session(resp)
	{
		if(IsJsonString(resp))
		{
			var jsonStr = JSON.parse(resp);
			var statusCode = jsonStr.status_code;
			if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) 
			{
				if(jsonStr.code=="SES200")
				{
					showPasswordConfirmation();
					return false;
				}
				else
				{
					showTopErrNotification(jsonStr.message);
					$("#terminate_session_submit span").removeClass("zeroheight");
					$("#terminate_session_submit").removeClass("changeloadbtn");
					$("#terminate_session_submit").attr("disabled", false);
				}
			}
			else
			{
				if(jsonStr.cause==="throttles_limit_exceeded")
				{
					showTopErrNotification(jsonStr.message);
				}
				else
				{
					var error_resp = jsonStr.errors[0];
					var errorCode=error_resp.code;
					var errorMessage = jsonStr.message;
					showTopErrNotification(jsonStr.message);
				}
			}
		}
		else
		{
			showTopErrNotification(I18N.get("IAM.ERROR.GENERAL"));
		}
		$("#terminate_session_submit span").removeClass("zeroheight");
		$("#terminate_session_submit").removeClass("changeloadbtn");
		$("#terminate_session_submit").attr("disabled", false);
		return false;
	}

	function showOneAuthTerminate(ele)
	{
		 $('#include_oneauth').attr('checked', false);
		 if(ele.checked && $("#termin_mob").hasClass("show_oneauth")){
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
	
	var redirectionTimer = 10
	function showPasswordConfirmation(){
		$("#success_pcontainer").show();
		$(".terminate_session_container,.password_expiry_container").hide();
		$(".zoho_logo").css("background-position","center")
		setInterval(function(){
			if(redirectionTimer <= 0){
				window.location.reload();
				return false;
			}
			$(".ppsuccess_timer span").text(redirectionTimer);
			redirectionTimer--;
		}, 1000);
	}
	function validateCP(){
		if(($("#new_password").val() && $("#new_repeat_password").val()) && $("#new_password").val().trim() === $("#new_repeat_password").val().trim()){
			$("#new_repeat_password ~ .show_hide_Confpassword").hide();
			$("#new_repeat_password ~ .show_Success").show()
		}else if(!$("#new_repeat_password ~ span").hasClass("icon-hide") || !$("#new_repeat_password ~ span").hasClass("icon-show")){
			$("#new_repeat_password ~ .show_hide_Confpassword").show();
			$("#new_repeat_password ~ .show_Success").hide();
		}
	}
	function validatePasswordPolicy(passwordPolicy) {
	passwordPolicy = passwordPolicy || PasswordPolicy.data;
	var initCallback = function(id, msg) {
		var li = document.createElement('li');//No I18N
		var span = document.createElement('span');//no i18n
		var p = document.createElement('p');//no i18n
		li.appendChild(span);
		li.appendChild(p);
        li.setAttribute("id","pp_"+id);//No I18N
        li.setAttribute("class","pass_policy_rule");//No I18N
        p.textContent = msg;
        return li;
	}
	var setErrCallback = function(id) {
		$("#pp_"+id+" span").removeClass('success').removeClass('failure');//no i18n
		$("#pp_"+id+" span").addClass('failure');//No I18N
		return id;
	}
	return {
		getErrorMsg: function(value, callback) {
			if(passwordPolicy) {
				var isInit = value ?  false : true;
	 			value = value ? value.trim() : '';
	 			callback = callback || setErrCallback;
	 			var rules = [ 'MIN_MAX', 'SPL', 'NUM', 'CASE']; //No I18N
	 			var err_rules = []; 
	 			var err_msg = []; 
	 			if(!isInit) {
					$('.pass_policy_rule span').removeClass('success').removeClass('failure');//No I18N
	 				$('.pass_policy_rule span').addClass('success');//No I18N
	 			}else{
					$('.pass_policy_rule span').removeClass('success').removeClass('failure');//No I18N
				}
	 			for(var i = 0; i < rules.length; i++) {
	 				switch (rules[i]) {
	 					case 'MIN_MAX': //No I18N
	 						if(value.length<passwordPolicy.min_length || value.length>passwordPolicy.max_length) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get("IAM.PASS_POLICY.MIN_MAX"), passwordPolicy.min_length.toString(), passwordPolicy.max_length.toString()) : undefined));
	 						}
	 						break;
	 					case 'SPL': //No I18N
	 						if((passwordPolicy.min_spl_chars > 0) &&  (((value.match(new RegExp("[^a-zA-Z0-9]","g")) || []).length) < passwordPolicy.min_spl_chars)) {
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passwordPolicy.min_spl_chars === 1 ? "IAM.PASS_POLICY.SPL_SING" : "IAM.PASS_POLICY.SPL"), passwordPolicy.min_spl_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'NUM': //No I18N
	 						if((passwordPolicy.min_numeric_chars > 0) &&  (((value.match(new RegExp("[0-9]","g")) || []).length) < passwordPolicy.min_numeric_chars)){
	 							err_rules.push(callback(rules[i], isInit ? formatMessage(I18N.get(passwordPolicy.min_numeric_chars === 1 ? "IAM.PASS_POLICY.NUM_SING" : "IAM.PASS_POLICY.NUM"), passwordPolicy.min_numeric_chars.toString()) : undefined));
	 						}
	 						break;
	 					case 'CASE': //No I18N
	 						if((passwordPolicy.mixed_case) && !((new RegExp("[A-Z]","g").test(value))&&(new RegExp("[a-z]","g").test(value)))) {
	 							err_rules.push(callback(rules[i], isInit ? I18N.get("IAM.PASS_POLICY.CASE") : undefined));
	 						}
	 						break;
	 				}
	 			}
	 			if(isInit){
					 $('.pass_policy_rule span').removeClass('success').removeClass('failure');//No I18N
				 }
	 			return err_rules.length && err_rules;
			}
		},
		init: function(passInputID) {
 			$('.hover-tool-tip').remove();//No I18N
 			var tooltip = document.createElement('div');//No I18N
 			tooltip.setAttribute("class",isMobile ? "hover-tool-tip no-arrow" : "hover-tool-tip");//No I18N
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
	 			$(passInputID).on('focus blur', function(e){//No I18N
	 			    if(e.type === 'focus') {//No I18N
	 			    	var offset = document.querySelector(passInputID).getBoundingClientRect();
	 			    	if( $("body").attr("dir") === "rtl"){
							 $('.hover-tool-tip').css(isMobile ? {
		 		 				top: offset.bottom + $(window).scrollTop() + 8,
		 		 				right: offset.x,
		 		 				width: offset.width - 40
	 		 				} : {
		 		 				top: offset.y + $(window).scrollTop(),
		 		 				right : offset.x + offset.width + 15
	 		 				});
						 }else{
							 $('.hover-tool-tip').css(isMobile ? {
		 		 				top: offset.bottom + $(window).scrollTop() + 8,
		 		 				left: offset.x,
		 		 				width: offset.width - 40
		 		 				} : {
			 		 				top: offset.y + $(window).scrollTop(),
			 		 				left : offset.x + offset.width + 15
		 		 			});
	 		 			
						 }
	 			    	$('.hover-tool-tip').css('opacity', 1);//No I18N
	 			    } else {
	 			    	$('.hover-tool-tip').css('opacity', 0);//No I18N
	 			    	var offset = document.querySelector('.hover-tool-tip').getBoundingClientRect();//No I18N
	 			    	if($("body").attr("dir") === "rtl"){
							 $('.hover-tool-tip').css({
	 		 				top: -offset.height,
	 		 				right: -(offset.width + 15)
	 		 			})
						}else{
		 		 			$('.hover-tool-tip').css({
		 		 				top: -offset.height,
		 		 				left: -(offset.width + 15)
		 		 			})
	 		 			}
	 			    }
	 			});
 			}
 		},
 		validate: function(formID, passInputID) {
			var str=$(passInputID).val();
			this.getErrorMsg(str, setErrCallback) ? $('.hover-tool-tip').css('opacity', 1):$('.hover-tool-tip').css('opacity', 0);
 		}
	}
}