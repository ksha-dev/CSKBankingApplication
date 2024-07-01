//$Id$



function showZcaptchaError(err_msg,is_refresh)
{
	if (type != 0)//unless audio captcha 
	{
		$(".background .Zcaptcha_error").html(err_msg);
		$(".background .Zcaptcha_error").slideToggle();
		setTimeout(function() {
			$(".Zcaptcha_error").hide();
		}, 2000);	
		if(is_refresh)//need to refresh the imagew
		{
			$("#zlabs_captcha_container #background").addClass("change_shake");
			setTimeout(function() 
			{
				$("#zlabs_captcha_container #background").removeClass("change_shake");
				showZLabsCaptcha()//refresh the captha
			}, 1000);
			
		}
	}
	else	//for audio caotcha
	{
		$(".audio .Zcaptcha_error").html(err_msg);
		$(".audio .Zcaptcha_error").slideToggle();
		setTimeout(function() {
			$(".Zcaptcha_error").hide();
			showZLabsCaptcha()//refresh the captha
		}, 2000); 
	}
	
	
}


function enable_captcha_submit()
{
	switch(type) 
	{
		case 0:
			{
				var captchavalue = $("#aoption").val();
				if(isValid(captchavalue)	&&	/^-?\d*$/.test( captchavalue )) 
				{
					$("#z_capctha_submit").attr("disabled", false);
					$("#z_capctha_submit").removeClass("disbale_butt");
				}
				else
				{
					$("#z_capctha_submit").attr("disabled", true);
					$("#z_capctha_submit").addClass("disbale_butt");
				}
				break;
			}
		case 1:
				if($('input[name="radio"]:checked').val())
				{
					$("#z_capctha_submit").attr("disabled", false);
					$("#z_capctha_submit").removeClass("disbale_butt");
				}
				break;
		case 2:
				if($("#slider").val()>1)
				{
					$("#z_capctha_submit").attr("disabled", false);
					$("#z_capctha_submit").removeClass("disbale_butt");
				}
				break;
		}
}

function play_audio(e)
{
	if(!($(".audio").hasClass("play_motion")))
	{
		$(".audio_bar").addClass("audio_animation");
		$(".audio").addClass("play_motion");
		audio_timer=setTimeout(function(){
			$(".audio_bar").removeClass("audio_animation");
			$(".audio").removeClass("play_motion");
		}, 4935);
	
	}
	else
	{
		e.stopPropagation();
	}
	return  false;
}






function showZLabsCaptcha(audio,adjust_footer,show_loading)
{
	clearTimeout(audio_timer);
	if(type==0	&& 	$(".audio").hasClass("play_motion"))
	{
		zlabsCaptchaObj.sound.pause();
	}
	$(".audio_bar").removeClass("audio_animation");
	$(".audio").removeClass("play_motion");
	$("#zlabs_captcha_container").addClass("height_set");
	if(show_loading==undefined || show_loading==true)
	{
		$("#zlabs_captcha_container .load-bg").show();
		$("#zlabs_captcha_container .load-bg").removeClass("load-fade"); //no i18N
	}
	else
	{
		$("#zlabs_captcha_container .load-bg").hide();
	}
	$(".Zcaptcha_error").hide();
	if(adjust_footer)
	{
		setFooterPosition();//chnage foorter postion if needed
	}
	
	if($("#zlabs_captcha_container .audio").is(":visible")	&&	audio==undefined)
	{
		audio=true;
	}
	//$("#zlabs_captcha_container").show();
	
	$("#z_capctha_submit span").addClass("no_height");
	$("#z_capctha_submit").addClass('show_laod_butt');
	$("#z_capctha_submit").attr("disabled", true);
	$(".audio").hide();$(".img").hide();
	$(".option").hide();
	$(".zlabs_slide").hide();
	$(".Captcha_btns").hide();
	
	$("#z_capctha_submit").attr("disabled", true);//disbale the submit button
	$("#z_capctha_submit").addClass("disbale_butt");
	//audio option
	$("#aoption").val("");
	// options
	$(".radio__label").text("");
	$("#op1").prop("checked", false);
	$("#op2").prop("checked", false);
	$("#op3").prop("checked", false);
	$("#op4").prop("checked", false);
	//slider
	$("#imgslide").removeClass("slider_shake");
	$("#imgslide").css("left", "0px");
	$("#slider").css("--value-percent","0%");
	
	
	localStorage.removeItem("did"); //No I18N
	zlabsCaptchaObj = null;
	
	zlabsCaptchaObj = captcha.captcha("audioObj", ".audio", null, null, null, handleZLabsCaptchaParams, null); //No I18N
	zlabsCaptchaObj.getCaptcha(audio ? getZLabsAudioCaptcha : getZLabsCaptcha);
}

function handleZLabsCaptchaParams(json)
{
	zlabs_captcha_params = "";
	for (var key in json) {
		zlabs_captcha_params += key + "=" + json[key] + "&";
	}
	zlabs_captcha_params = zlabs_captcha_params.substring(0, zlabs_captcha_params.length - 1);
}


function getZLabsCaptcha(json)
{
	callRequestWithCallback(contextpath + uriPrefix + "/webclient/v1/zlabs/captcha?usecase="+captcha_usecase+"&did=" + json.did, null, true, handleZLabsCaptchaResponse, "GET", false, false); //No I18N
}

function getZLabsAudioCaptcha(json)
{
	callRequestWithCallback(contextpath + uriPrefix + "/webclient/v1/zlabs/captcha/audio?usecase="+captcha_usecase+"&did=" + json.did + "&format=" + json.format, null, true, handleZLabsCaptchaResponse, "GET", false, false); //No I18N
}


function handleZLabsCaptchaResponse(resp)
{
	
	if(IsJsonString(resp)) 
	{
		var jsonStr = JSON.parse(resp);
		if(jsonStr.cause==="throttles_limit_exceeded") // unreachable
		{
			cdigest = '';
			showHip(cdigest);
			showCaptcha(I18N.get("IAM.NEXT"),false); //No I18N
			return false;
		}
		if(jsonStr.cdigest) 
		{
			cdigest = jsonStr.cdigest;
			$("#zlabs_captcha_container").hide();
			$("#captcha_container").show();
			showHip(cdigest);
			$("#lookup_div #nextbtn").show();
			
			show_captcha();
				
			return;
		}
		if(jsonStr.type !== undefined){
			type = jsonStr.type;
		}
		if(jsonStr.data){
			jsonStr = jsonStr.data;
		}
		show_captcha(true);
		
		$(".ZCaptcha_desc div").hide();//hide all descriptions
		$(".captcha_icons span").show(); // show all font icons
		
		switch(type) {
			case 0:
				captchaType = "audio"; //No I18N
				$("#loader").hide();
				$("#imgdiv").hide();
				$(".audio_desc").show();
				$(".captcha_icons .audio_captcha").hide();
				$(".audio").show();
				break;
			case 1:
				captchaType = "option"; //No I18N
			    $(".option").show();
				$(".options_desc").show();
				$(".captcha_icons .img_captcha").hide();
				$(".slide").hide();
			    break;
			case 2:
				captchaType = "slide"; //No I18N
				$(".zlabs_slide").show();
				$(".slide").show();
				setTimeout(function()
				{
					$("#imgslide").addClass("slider_shake");
				}, 350);//wait for the loding gif to go and then shake the slider
			
				
				$(".slide_desc").show();
				$(".captcha_icons .img_captcha").hide();
				$('#slider').val(0);
				break;
		}
		if(type != 0) {
			zlabsCaptchaObj = captcha.captcha(captchaType + "Obj", "." + captchaType == "slide" ? "zlabs_slide" : captchaType, null, null, null, handleZLabsCaptchaParams, null); //No I18N
		}
		zlabsCaptchaObj.setCaptchaInUI(jsonStr);
		
		
		if(type==2)
		{
			var img_Wbg=$("#background").outerWidth();
			// our puzzel size is 43.7 so need to make it dynamically
			$("#imgslide").css("width",img_Wbg*43.7/350+"px");
			$("#slider").attr("max",parseInt($("#background").css("width"))-parseInt($("#imgslide").css("width")));//adjust the length of the slider to the image
			$("#imgdiv").css("width",$("#background").css("width"));//adjust the length of the bg img's parent div to the image
		}
		
		$(".Captcha_btns").show();
		$("#z_capctha_submit span").removeClass("no_height");
		$("#z_capctha_submit").removeClass("show_laod_butt");
		$("#z_capctha_submit").attr("disabled", true);
		
		
		$(".load-bg").addClass("load-fade")
			setTimeout(function(){
				$(".load-bg").hide();
			}, 300);
			
		if($("footer").length > 0	&&	$("footer").is(":visible"))	//if foorter is avaiable
		{
			setFooterPosition();//chnage foorter postion if needed
		}
		return;
	}
}


function submit_zlabs_capctha(parentURI)
{
	if (type != 2) 
	{
		$("#asubmit").click();
	}
	if (!isValid(zlabs_captcha_params))
	{
		showZcaptchaError(I18N.get("IAM.SIGNIN.ERROR.CAPTCHA.REQUIRED"));//no i18n
		return false;
	}
	var captcha_verify_url;
	if(captcha_usecase=='5')	//resetnip value
	{
		captcha_verify_url	= parentURI + "/v1/lookup/"+login_id+"/captcha?" + zlabs_captcha_params + "&type="+ type + "&token=" + token; //no i18N

	}
	else
	{
		captcha_verify_url = parentURI + "/v2/lookup/"+login_id+"/captcha?" + zlabs_captcha_params + "&type="+ type + "&token=" + token; //no i18N
	}
	$(".shine_cover").addClass("shine");//shine effcet to show verification
	$("#z_capctha_submit span").addClass("no_height");
	$("#z_capctha_submit").addClass('show_laod_butt');
	$("#z_capctha_submit").attr("disabled", true);
	return captcha_verify_url;
}

