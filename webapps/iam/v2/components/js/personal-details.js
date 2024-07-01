//$Id$  
var oldilan="";
var all_timezones=[];
var all_countries=[];
var contry_timzones=[];
var timezoneNotInList = true;
function load_userdetails(Policies,userDetails)
{
	if(jQuery.isEmptyObject(all_timezones))
	{
		$('#localeTz option').each(function(){
			if(this.value == "Etc/GMT+12") {
				this.textContent = this.textContent.split("( Etc/GMT+12 )")[0].trim();
			}
			all_timezones.push({ "value" : this.value, "text" : this.textContent });
		});
	}
	if(jQuery.isEmptyObject(all_countries))
	{
		$('#localeCn option').each(function(){
			all_countries.push({ "value" : this.value, "text" : this.textContent });
		});
	}
	if(jQuery.isEmptyObject(contry_timzones))
	{
		$('#country_Tz option').each(function(){
			contry_timzones.push({ "value" : this.value, "text" : this.textContent });
		});
	}
	if(!$("#localeLn").hasClass("def_langu_populated"))
	{
		var Lcn=0;
		$('#localeLn option').each(function()
		{
			if($('#localeLn option')[Lcn].text.indexOf("(")!=-1)
			{
				$('#localeLn option')[Lcn].text=$('#localeLn option')[Lcn].text.replace(/[(]/g, '- '); 
				$('#localeLn option')[Lcn].text=$('#localeLn option')[Lcn].text.replace(/[)]/g, '');
				$('#localeLn option').eq(Lcn).attr("data-text",$('#localeLn option').eq(Lcn).attr("data-text").replace(/[(]/g, '- '));//No I18N
				$('#localeLn option').eq(Lcn).attr("data-text",$('#localeLn option').eq(Lcn).attr("data-text").replace(/[)]/g, ''));//No I18N
			}
			if(	( ($('#localeLn option')[Lcn].text).trim() !=   ($('#localeLn option').eq(Lcn).attr("data-text")).trim()	)		&&		!isEmpty($('#localeLn option').eq(Lcn).attr("data-text").trim()) )	// if the default value is not same as normal value show both
			{
				$('#localeLn option')[Lcn].text= $('#localeLn option')[Lcn].text+" ( "+ $('#localeLn option').eq(Lcn).attr("data-text")+" )";//No I18N
				
				//					$('#localeLn option')[Lcn].text= $('#localeLn option')[Lcn].text+" <span class='text'>( "+ $('#localeLn option').eq(Lcn).attr("data-text")+" )</span>";//No I18N

				
			}
			Lcn++;
		});
		$("#localeLn").addClass("def_langu_populated")
	}
	
	if(userDetails.photo_url!=undefined)
	  {
	    //$("#edit_delete_photo_profile").html('<div class="profile_options" id="edit_photo">'+edit+'</div><div class="profile_options" id="delete_photo" onclick="deletePhoto()" >'+deleted+'</div>');
		$("#dp_pic").attr("onerror", "handleDpOption(this)");//No i18N
		$("#dp_pic").attr("src",userDetails.photo_url);//No i18N
		$(".dp_pic_blur_bg").css("background-image","url("+userDetails.photo_url+")");
	  }
	  $("#profile_email").text(isPhoneNumber(userDetails.primary_email.trim()) ? phonePattern.setMobileNumFormat(userDetails.primary_email):userDetails.primary_email);
	  
	  $("#profile_Fname_edit").val(decodeHTML(userDetails.first_name));
	  $("#profile_Lname_edit").val(decodeHTML(userDetails.last_name));
	  
	  var FullName=userDetails.first_name+" "+userDetails.last_name;
	  
	  $("#profile_name").text(decodeHTML(FullName));
	  $("#profile_name_edit").val(decodeHTML(FullName));
	  
	  
	  //$("#profile_email_edit").val(userDetails.profile_email);
	  $("#profile_nickname").val(decodeHTML(userDetails.display_name));
	  $("#gender_select option[value='"+userDetails.gender+"']").length != 0 ? $("#gender_select").val(userDetails.gender) : $("#gender_select").val("");
	  $("#gdpr_us_state").hide();
	  $("#localeState").find('option').not(':first').remove();// remove previous countries state details exepct the default one i.e. select state
	  if(userDetails.country!=""){ 
		  $("#localeCn").val(userDetails.country.toLowerCase());
		  if($("#localeCn").val()==""	||	$("#localeCn").val()==null	||	$("#localeCn").val()==undefined)// user country is of a random value that is not present in the select
	      {
			  $("#localeCn").val($("#localeCn option:first").val())
	      }
		  if(states_details[profile_data.country.toLowerCase()]){
			  
			  $("#localeState").html(($("#localeState").html()+states_details[profile_data.country.toLowerCase()]));
			  if(userDetails.state!=""	&&	userDetails.state!=undefined){
				  $("#localeState").val(userDetails.state);
				  $("#gdpr_us_state").show();
			  }
		  }
	  }
	  if(userDetails.language!="")
	  { 
		  $("#localeLn").val(userDetails.language);
	  }
	  if(userDetails.timezone!="")
	  {  
		  all_timezones.find(function(eachTz){
			  if(eachTz.value === userDetails.timezone){
				  $("#localeTz").val(userDetails.timezone);
				  timezoneNotInList = false;
			  }
		  });
	  }
	  displayAllTimeZone();
	  
		$("#gender_select").uvselect('ViewMode');
	    $("#localeLn").uvselect({
	    	ViewMode : true
	    });
	    $("#localeCn").uvselect({
    		"country-flag" : true, //no i18n
    		ViewMode : true
    	});
	    $("#localeState").uvselect('ViewMode');
	    
    //if(!isMobile){
	    $("#localeTz").uvselect({
	    	width: '400px', //No I18N
	    	ViewMode : true,
	    	"onDropdown:open" : function(){ //No I18N
	    		$(".timeZone_show").remove();
		    	var dropdown = uvselect.getCurrentDropdown();
				dropdown.children('.dropdown_header').append("<div class='timeZone_show' >"+$("#displayall_timezone").html()+"</div>");
		    	dropdown.children('.dropdown_header').children(".selectbox_search_container").css("width","auto");	//No I18N
		    	$(".timeZone_show #timezone_toggle").attr("id","timezone_toggle_inside_select");
		        $(".timeZone_show label").attr("for","timezone_toggle_inside_select");
		        $('#timezone_show_type').is(':checked')?$('#timezone_toggle_inside_select').prop("checked", true):$('#timezone_toggle_inside_select').prop("checked", false);
	    	}
	    });
	  
	  //initDefaultTimeZoneOptions();
	 if(timezoneNotInList){
		 if(isMobile){
			 $("#localeTz").val(userDetails.timezone);
			 $("#localeTz .dummy").text(userDetails.timezone);
		 }
		 else{
			 $(".select_input[jsid=localeTz]")[0].value = userDetails.timezone;
		 }	
	 }
	 if(userDetails.is_photo_permission_disabled || isClientPortal){
		 $(".icon-Profilepicturevisibility").parent().remove();
	 }
	 
}


function check_state()
{
	if(states_details[document.locale.country.value.trim()]){
		  $("#localeState").find('option').not(':first').remove();// remove previous countries state details exepct the default one i.e. select state
		  $("#gdpr_us_state").show();
		  $("#localeState").html($("#localeState").html()+states_details[document.locale.country.value.trim()]);
		  if(profile_data.state!=""	&&	profile_data.state!=undefined && document.locale.country.value.trim() == profile_data.country.toLowerCase()){
			  $("#localeState").val(profile_data.state);
		  }
		  $("#localeState").uvselect();
	}else{
		$("#gdpr_us_state").hide();
		$("#localeState #default_state").prop("selected", true);
		$("#localeState #default_state").val();
	}
}
//
//function format (option) {		//select2 result format changing function result with flag
//	
//    if (!option.id) { return option.text; }
//       var getPos = $(option.element).attr("position");
//       getPos=getPos.split(" ");
//    var ob = '<div class="pic" style="background-position-x:'+getPos[0]+';background-position-y:'+getPos[1]+';"></div><span class="cn">'+option.text+'</span>';
//    return ob;
//};

function editProfile()
{
	uvselect.disableViewMode("#gender_select,#localeLn,#localeCn,#localeState,#localeTz"); //No I18N
	remove_error();	
	control_Enter("a"); //No I18N
	 $("#Full_Name").hide();
	 $("#First_Name").css("display","inline-block");
	 $("#Last_Name").css("display","inline-block");
	
	$("#savebtnid").slideDown(200);
	$(".textbox_div").removeClass("editmode");
	
	
	$(".profile_mode").addClass("profile_editmode");
	$('.edit_display').css("display","inline-block");
	$('.field').addClass("mob_edit");
	isMobile ? $('#displayall_timezone').show() : $('#displayall_timezone').hide();
		
	$(".profile_mode").attr("disabled",false);
    if(!profile_data.Policies.CHANGE_FULL_NAME)
    {
    	$("#profile_Fname_edit").attr("readonly",true);
    	$("#profile_Fname_edit").removeClass("profile_editmode");
    	$("#profile_Lname_edit").attr("readonly",true);
    	$("#profile_Lname_edit").removeClass("profile_editmode");
    	$(".profileinfo_form .mandate_field_star").hide();
    }
    if(!profile_data.Policies.CHANGE_DISPLAY_NAME)
    {
    	$("#profile_nickname").attr("readonly",true);
    	$("#profile_nickname").removeClass("profile_editmode");
    }
    if(profile_data.display_name === (profile_data.first_name+" "+profile_data.last_name))
    {
    	$("#profile_nickname").val("");
    }
//    if(!user.disabled_email)
//    {
//    	$("#profile_email_edit").attr("readonly",true);
//    	$("#profile_email_edit").removeClass("profile_editmode");
//    }
    $(".lable_editmode").slideDown(200);
    $("#save_cancel_btn").show();
    $("#editprofile").addClass("hide_btn");
    $("#editonmobile").addClass("hide_btn");
    if($("#profile_Fname_edit").attr("readonly")==undefined){
    	$("#profile_Fname_edit").focus();
    }
    else{
    	$("#profile_nickname").focus();    	
    }
	
    if(!profile_data.Policies.CHANGE_TIMEZONE){
    	$("#localeTz").prop("disabled", true);
    	$("#localeTz").parents(".textbox_div").removeClass("mobileSelectArrow");	//No I18N
    	$("#displayall_timezone").hide();
    }
    
    $("#saveprofile").addClass("pref_disable_btn");
	$("#saveprofile").removeClass("primary_btn_check");
	$("#saveprofile").attr("disabled", "disabled");
   
	$("#timezone_toggle").keypress(function(event){
    	if(event.keyCode==13){
    		$(this).prop("checked", !$(this).prop("checked"));
    	}
    });
	if(states_details[profile_data.country.toLowerCase()]){
		 $("#gdpr_us_state").show();
	}
    	$(".profileinfo_form").keydown(function(e) {   
    		if(e.keyCode == 27) {
    			undochanges();
    		}
    	});
    	$(".profileinfo_form .profile_editmode").on("change input",function(){
    		show_save();
    	});

    return false;
	
};

function show_save(){
	var doc = document.locale;
	var gen_val = profile_data.gender == undefined ? "" : profile_data.gender ;
	var con_val = profile_data.country == undefined ? "" : profile_data.country ;
	var lan_val = profile_data.language == undefined ? "" : profile_data.language ;
	var tim_val = profile_data.timezone == undefined ? "" : profile_data.timezone ;
	var state_val = profile_data.state == undefined ? "" : profile_data.state ;
	var show_var = false;
	if(doc.first_name.value.trim() != profile_data.first_name){
		show_var = true;
	}
	else if(doc.last_name.value.trim() != profile_data.last_name){
		show_var = true;
	}
	else if(doc.display_name.value.trim() != profile_data.display_name){
		show_var = true;
	}
	else if(doc.gender.value != gen_val){
		show_var = true;
	}
	else if(doc.country.value != con_val){
		show_var = true;
	}
	else if(doc.language.value != lan_val){
		show_var = true;
	}
	else if(doc.timezone.value != tim_val){
		show_var = true;
	}
	else if(doc.state.value != state_val)
	{
		show_var = true;
	}
	else{
		show_var = false;
	}
	
	if(show_var){
		$("#saveprofile").removeClass("pref_disable_btn");
		$("#saveprofile").addClass("primary_btn_check");
		$("#saveprofile").removeAttr("disabled");
	}
	else{
		$("#saveprofile").addClass("pref_disable_btn");
		$("#saveprofile").removeClass("primary_btn_check");
		$("#saveprofile").attr("disabled", "disabled");
	}
};


function undochanges()
{
	remove_error();
	$(".nickname_info").hide();
	$("#savebtnid").slideUp(200,function(){
		$("#editprofile").removeClass("hide_btn");
		$("#editonmobile").removeClass("hide_btn");		
	});
	$(".textbox_div").addClass("editmode");
	
    $(".profile_mode").removeClass("profile_editmode");
    $('#displayall_timezone').hide();
    $(".gender_view").removeClass("gender_edit");
    
//	if(gendercode==0)
//	{
//		$('#maleid').addClass("hide");
//	}
//	else if(gendercode==1)
//	{
//		$('#femaleid').addClass("hide");
//	}
    
    $('.field').removeClass("mob_edit");
    $(".profile_mode").attr("disabled",true);
    $('.edit_display').hide();
     $(".lable_editmode").slideUp(200);
     $("#save_cancel_btn").hide();
     
     $("#Full_Name").show();
	 $("#First_Name").hide();
	 $("#Last_Name").hide();
	 
	 $("a").unbind();
	 $(".profileinfo_form .profile_editmode").unbind();
     load_userdetails(profile_data.Policies,profile_data);
     return false;
}

//function select_gender(gen)
//{
//	$(".gender_view").removeClass("highlight");
//	if($(".profile_mode").hasClass("profile_editmode"))
//		{
//			$(gen).addClass("highlight");
//		}
//}

function saveProfile(f)
{    
     oldilan=isEmpty(oldilan.trim())?(profile_data.language!=undefined)?profile_data.language:"":oldilan;
     if(validateForm(f))
 	 {
    	disabledButton(f);

    	var profileparams = ["first_name","last_name","display_name","gender","country","state","language","timezone"]; //No I18N
    	var params = {};
    	for (i=0;i<profileparams.length;i++)
    	{
    		if (profileparams[i]=="display_name")	//display name can be empty and take firstname and last name values
    		{
    			if(decodeHTML(profile_data[profileparams[i]]) != $(document[f.name][profileparams[i]]).val().trim())
    			{
    				if($(document[f.name][profileparams[i]]).val().trim())
    				{
    					params[profileparams[i]] = $(document[f.name][profileparams[i]]).val().trim();
    				}
    				else
    				{
						var fnameval = $(document[f.name].first_name).val().trim(); 
    					params[profileparams[i]]= fnameval;
    					$(document[f.name][profileparams[i]]).val(fnameval);
    				}
    			}
    		}
    		if (profileparams[i]=="last_name" || profileparams[i]=="first_name")	//display name can be empty
    		{
    			if(decodeHTML(profile_data[profileparams[i]]) != $(document[f.name][profileparams[i]]).val().trim())
    			{
    				params[profileparams[i]] = $(document[f.name][profileparams[i]]).val().trim();
    			}
    		}
    		else if(decodeHTML(profile_data[profileparams[i]]) != $(document[f.name][profileparams[i]]).val() && $(document[f.name][profileparams[i]]).val())
    		{
    			params[profileparams[i]] = $(document[f.name][profileparams[i]]).val();
    		}
    	}
    	
		var payload = User.create(params);
    	payload.PUT("self","self").then(function(resp)	//No I18N
		{
    		SuccessMsg(getErrorMessage(resp));
    		doneEditing(resp.user.aRP);
    		removeButtonDisable(f);
    	},
    	function(resp)
    	{
			if(resp.field && $('#'+f.id+' [name='+resp.field+']').parents('.field').is(":visible")){
				$('#'+f.id+' [name='+resp.field+']').parents('.field').append( '<div class="field_error">'+getErrorMessage(resp)+'</div>' );
				f[resp.field].focus();
			}
			else{
				showErrorMessage(getErrorMessage(resp));	
			}
    		removeButtonDisable(f);
    	});
    	
		//new URI(User,"self","self").include(EMAIL).include(PHONE).PUT(); //No I18N
		
		//phone.AddFromBackup(parms,callback,phnum);
 	 }
     
  return false;   
}
function doneEditing(reloadPage)
{
		 $(".nickname_info").hide();
		 var temp_fname=$("#profile_Fname_edit").val().trim();
		 var temp_lname=$("#profile_Lname_edit").val().trim();
		 var temp_dname=$("#profile_nickname").val().trim();
	     var templang=document.locale.language.value.trim();
	     var tempitzone=document.locale.timezone.value.trim();
	     var tempicountry=document.locale.country.value.trim();
	     var tempState="";
	     if(states_details[tempicountry])
	     {
	    	 tempState=document.locale.state.value.trim();
	     }
		 
		 profile_data.first_name = temp_fname;
		 profile_data.last_name = temp_lname;
		 profile_data.display_name = temp_dname;
		 if(temp_dname.trim() == ""){
			 profile_data.display_name = temp_lname != "" ? temp_fname+" "+temp_lname : temp_fname;
		 }
		 profile_data.gender=$('#locale').find('select[name="gender"]').val();

	  	 if(reloadPage) 
	  	 {
	  		window.location.reload();
	        return false;
	  	 }
		  profile_data.language=templang;
		  profile_data.timezone=tempitzone;
		  profile_data.country=tempicountry;
		  profile_data.state=tempState;
		  load_profile();
	
    $(".profile_mode").removeClass("profile_editmode");
    $('#displayall_timezone').hide();
    $(".gender_view").removeClass("gender_edit");
    $('.field').removeClass("mob_edit");
    $(".profile_mode").attr("disabled",true);

	 
	  
    var Fullname= $("#profile_Fname_edit").val()+" "+$("#profile_Lname_edit").val();
    $(".pp_expand_username").text(Fullname);
    $("#profile_name").text(Fullname);
    $("#profile_name_edit").val(Fullname);
    $("#Full_Name").show();
    $("#First_Name").hide();
    $("#Last_Name").hide();
    $('.edit_display').hide();

    
    $("#savebtnid").slideUp(200,function(){
        $("#editprofile").removeClass("hide_btn");
        $("#editonmobile").removeClass("hide_btn");
    });
	$(".textbox_div").addClass("editmode");
	
	 return false;
}



function getLocaleTz(t) 
{
	if(timezoneNotInList){
		var option = document.createElement("option");
		option.value = profile_data.timezone;
		option.classList.add("dummy"); //no i18n
		$('#localeTz').prepend(option); //no i18n
		$(".dummy").attr("selected",true);
	}
	var tzSelectedVal=de('localeTz').value;//No I18N
    for(var iter=0;iter<contry_timzones.length;iter++)
	{
    	var country_code=contry_timzones[iter].value;
		var timezones=contry_timzones[iter].text;
		if(country_code.trim()==t.trim())
		{
			if(tzSelectedVal)
			{
				if(timezones.indexOf(tzSelectedVal) === -1){
					if((profile_data.timezone == tzSelectedVal)||(timezones.indexOf(profile_data.timezone) != -1)){
						timezones=tzSelectedVal+","+timezones;
					}
					else{
						timezones=tzSelectedVal+","+timezones+","+profile_data.timezone;
					}
				}
			}
			var timezone_list=timezones.split(",");
			getTimeZoneFromList(timezone_list);
		}
	}
	resetTimeZoneOptions();
	$("#displayall_timezone").attr("checked",false);
}

function getTimeZoneFromList(timezones)
{
    de('locale').className = "";		
    var tz = de('localeTz');//No I18N
    tz.options.length = 0;
    if(isEmpty(profile_data.timezone.trim())) 
    {
        tz.appendChild(new Option());
    }
    var option;
    for ( var timeZ in timezones) 
    {
    	option = document.createElement("option");	
    	 for(var iter=0;iter<all_timezones.length;iter++)
    		{
    		 	if(all_timezones[iter].value.trim()==timezones[timeZ].trim())
    		 	{
    		    	option.innerText =all_timezones[iter].text;
    		    	option.value = all_timezones[iter].value;
    		 	}
    		}
    	if(!(isEmpty(option.value) && isEmpty(option.innerHTML)))
    	{
    		 tz.appendChild(option);
    	}
    }
	if(timezoneNotInList){
		var option = document.createElement("option");
		option.value = profile_data.timezone;
		option.classList.add("dummy"); //no i18n
		$('#localeTz').prepend(option); //no i18n
		$(".dummy").attr("selected",true);
		$(".dummy").attr("disabled",true);
	}
    if(profile_data.timezone!="")
	{  
    	$("#localeTz").val(profile_data.timezone);
	}
}

function resetTimeZoneOptions() 
{
	if(!isMobile)
	{
		if($('.select_container.localeTz').length > 0)
		{
			$("#localeTz").uvselect('destroy');
			$('#localeTz').uvselect({
		    	width: '400px', //No I18N
		    	"onDropdown:open" : function(){ //No I18N
		    		$(".timeZone_show").remove();
			    	var dropdown = uvselect.getCurrentDropdown();
					dropdown.children('.dropdown_header').append("<div class='timeZone_show' >"+$("#displayall_timezone").html()+"</div>");
			    	dropdown.children('.dropdown_header').children(".selectbox_search_container").css("width","auto");	//No I18N
			    	$(".timeZone_show #timezone_toggle").attr("id","timezone_toggle_inside_select");
			        $(".timeZone_show label").attr("for","timezone_toggle_inside_select");
			        $('#timezone_show_type').is(':checked')?$('#timezone_toggle_inside_select').prop("checked", true):$('#timezone_toggle_inside_select').prop("checked", false);
		    	}
		    });
		    $(".profileinfo_form .profile_editmode").unbind();
	    	$(".profileinfo_form .profile_editmode").on("change input",function(){
	    		show_save();
	    	});
			if(timezoneNotInList && !isMobile){
				 $(".select_input[jsid=localeTz]")[0].value = profile_data.timezone;
			 }
		}
	}
	else{
		if(timezoneNotInList && !$('#timezone_show_type').is(':checked')){
				 $("#localeTz").val(profile_data.timezone);
				 $("#localeTz .dummy").text(profile_data.timezone);
		}
	}
}

function showZoneAfterCheck(){
	if($('#timezone_toggle_inside_select').is(':checked') || $('#timezone_toggle').is(':checked')){
		$('#timezone_show_type').prop("checked", true);
	}
	else{
		$('#timezone_show_type').prop("checked", false);
	}
	var searchVal=$(".selectbox_search .select_search_input").val();
	displayAllTimeZone();
	$('#localeTz').uvselect('open');
    
    $(".selectbox_search .select_search_input").val(searchVal);
    $('.selectbox_search .select_search_input').trigger($.Event('keyup'));
}

function displayAllTimeZone() 
{
	if($('#timezone_show_type').is(':checked')) // display
	{
		showTimeZoneList();
		resetTimeZoneOptions();
	}
	else
	{
		getLocaleTz($("#localeCn").val());	
	}
}
function showEmptyTooltip(ele){
	if(ele.value.trim() == ""){
		$(ele).siblings(".nickname_info").slideDown(300);
	}
	else{
		$(ele).siblings(".nickname_info").slideUp(300);
	}
}
function showTimeZoneList()
{
    var tz = de('localeTz');//No I18N
    tz.options.length = 0;
    if(isEmpty(profile_data.timezone.trim())) {
        tz.appendChild(new Option());
    }
    var option;
    
    for(iter=0;iter<all_timezones.length;iter++)
	{
    	option = document.createElement("option");
    	option.innerText=all_timezones[iter].text;
    	option.value = all_timezones[iter].value;
    	if(all_timezones[iter].value.toLowerCase() == profile_data.timezone.toString().toLowerCase()){
		    option.selected = true;
		}
    	tz.appendChild(option);
	}
}

function checkMaxLimit(nameElement)
{
	var nameValue = $(nameElement).val();
	nameElement.maxLength = parseInt($(nameElement).attr("data-limit"));
	if(nameValue.length >= nameElement.maxLength)
	{
		if($(nameElement).parents('.field').is(":visible"))
		  {
			$(nameElement).parents('.field').append( '<div class="field_error">'+max_size_field+'</div>' );
		  }
	}
}

function closePhotoVisiabilityPopup(){
	$("#visibility_change_apply").addClass("pref_disable_btn");
	$("#visibility_change_apply").prop("disabled", true);
	popupBlurHide("#profile_pic_visibility_popup"); //No I18N
}

function handleProfilePhotoVisibility(){
	var popUpContainer = $("#profile_pic_visibility_popup");
	popup_blurHandler('6');
	popUpContainer.show(0,function(){
		popUpContainer.addClass("pop_anim");		
	});
	closePopup(closePhotoVisiabilityPopup,"profile_pic_visibility_popup"); //No I18N
	var rebrandText = i18KeysPersonalDetails["IAM.ZOHO.REBRAND"].toLowerCase().replace(/\s/g, ''); //No I18N
	var iconElement = popUpContainer.find(".zohousers-class .option_icon");
	if(rebrandText.indexOf("zoho")!= -1) {
		iconElement.addClass("icon-rebrand-zoho");
	}else {
		iconElement.addClass("default-icon-name");
		iconElement.find(".rebrand-text").text(rebrandText.split("")[0].toUpperCase());
	}
	var visibilityOptionBox = popUpContainer.find(".visibility_option_box");
	visibilityOptionBox.find("input[value='"+profile_data.photo_permission+"']").parent().addClass("visibility_selected").click();
	visibilityOptionBox.change(function(){
		visibilityOptionBox.removeClass("visibility_selected");
		$(this).addClass("visibility_selected");
		var visibilityChangeApplyBtn = popUpContainer.find("#visibility_change_apply");
		if(profile_data.photo_permission != parseInt($(this).find("input").val())){
			visibilityChangeApplyBtn.removeClass("pref_disable_btn");
			visibilityChangeApplyBtn.prop("disabled", false); //No I18N
		}
		else {
			visibilityChangeApplyBtn.addClass("pref_disable_btn");
			visibilityChangeApplyBtn.prop("disabled", true); //No I18N
		}
	});
	if(!isMobile){
		alignPopUpCenterVertically("profile_pic_visibility_popup"); //No I18N
	}
	var popUpBody = popUpContainer[0].querySelector(".popup_padding");
	if(popUpBody.style.overflow === "auto"){
		popUpBody.scrollTop=0;
	}	
}

function applyVisibilityChange(){
	new_save_photoview_permi($(".visibility_selected").find("input").val());	
}

function alignPopUpCenterVertically(popUpId){
    var popUpContainer  = document.getElementById(popUpId);
    var windowHeight = window.innerHeight;
    if(popUpContainer.offsetHeight+200 > windowHeight){
		popUpContainer.style.top = (windowHeight-popUpContainer.offsetHeight)/2+"px";
	}
	if(popUpContainer.offsetTop<40 || popUpContainer.offsetHeight+popUpContainer.offsetTop>windowHeight){
		if(40+popUpContainer.offsetHeight < windowHeight-40){
			popUpContainer.style.top = "40px";
		}
		else{
			var popUpHeader = popUpContainer.querySelector(".popup_header"); //No I18N
			var popUpBody = popUpContainer.querySelector(".popup_padding"); //No I18N
			var popUpFooter = popUpContainer.querySelector(".visibility_popup_footer"); //No I18N
			popUpContainer.style.top = "40px";
			popUpBody.style.height = (windowHeight - 100 - popUpHeader.offsetHeight - popUpFooter.offsetHeight) + "px";
			popUpBody.style.overflow = "auto";
		}
	}
}

function showImage(ele){
	var imageContainer = ele.parentElement;
	imageContainer.querySelector(".photo_loader").classList.add("hide"); //No I18N
	ele.classList.remove("hide"); //No I18N
	imageContainer.querySelector(".photo_blur_dp2").classList.add("hide"); //No I18N
}

function handleViewProfilePicture(){
	popup_blurHandler('6');
	var imageContainer = document.querySelector(".photo_container"); //No I18N
	var blurImg1 = imageContainer.querySelector(".photo_blur_dp1"); //No I18N
	var blurImg2 = imageContainer.querySelector(".photo_blur_dp2"); //No I18N
	var originalImg = imageContainer.querySelector(".photo_original_dp"); //No I18N
	var imageUrl = document.querySelector(".dp_pic_blur_bg").style.backgroundImage.slice(4, -1).replace(/"/g, ""); //No I18N
	blurImg1.style.backgroundImage = "url("+imageUrl+")"; //No I18N
	blurImg2.src = imageUrl;
	originalImg.classList.add("hide"); //No I18N
	imageContainer.classList.add("show_photo_container"); //No I18N
	imageContainer.querySelector(".photo_loader").classList.remove("hide"); //No I18N
	imageContainer.querySelector(".photo_blur_dp2").classList.remove("hide"); //No I18N
	if(imageUrl.indexOf("fs=thumb")!=0){
		imageUrl = imageUrl.replace("fs=thumb","fs=original");
	}
	originalImg.src = imageUrl;
	if(isMobile){
		imageContainer.style.height = imageContainer.clientWidth + "px";
	}
	imageContainer.focus();
	closePopup(closeViewProfilePicture,"photo_container"); //No I18N
}

function closeViewProfilePicture(){
	$(".photo_container").removeClass("show_photo_container");
	popupBlurHide();
	$('body').css({
	    overflow: 'auto'//No i18N
	});
	var blurTimeOut = setInterval(function(){
		$(".blur").css("z-index","-1");
		clearTimeout(blurTimeOut);
	},300);
}

//function initDefaultTimeZoneOptions() {
//	if(de('localeCn')) {
//		getLocaleTz($("#localeCn").val());
//	}
//}