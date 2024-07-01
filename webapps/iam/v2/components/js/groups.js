//$Id$
var frequented_contacts=[];
var new_group_with_dp = false;
var groupDescSpecialCharsNotAllowed = '~`#%^&*()=+[]{}|\\;\"<>';


function get_groupFrom_GID(G_id)
{

	for(iter=0;iter<groups_data.length;iter++)
	{
		if(groups_data[iter].group_id==G_id)
		{
			return iter;
			break;
		}
	}
	return null;
}



function load_groups()
{
  if(groups_data!=undefined && groups_data.length>0)//empty check 
  {
	  $("#empty_groups").hide();
	  $("#groupexist").show(); 
	  $("#all_groups").html("");
	  for(iter=0;iter<groups_data.length;iter++)
	  {
		  var current_grp=groups_data[iter];
		  var group_format = $("#empty_group_format").html();
		  
		  $("#all_groups").append(group_format);
		  $("#all_groups #grpid").attr("id",current_grp.group_id);
		  $("#"+current_grp.group_id).addClass("grp_"+iter);

		  $("#"+current_grp.group_id).attr("onclick","groupFromInfo('"+current_grp.group_id+"',event)");
		  $("#"+current_grp.group_id+" #group_info").attr("onclick","group_operation('groupinfo','"+current_grp.group_id+"',event)");


		  if(current_grp.is_moderator)
		  {
			  $("#"+current_grp.group_id+" #moderator_power").show();
			  if(!(current_grp.is_admin))
			  {
			  	$("#"+current_grp.group_id+" #moderator_power #delete_group").text(i18nGroupkeys["IAM.GROUP.UNSUBCRIBE"]);
			  }
			  
			  $("#"+current_grp.group_id+" #unsuscribe_group").remove();
			  
			  $("#"+current_grp.group_id+" #edit_group").attr("onclick","group_operation('groupedit','"+current_grp.group_id+"',event)");
			  if($("#create_groups_template").length)
			  {
				  $("#"+current_grp.group_id+" #invite_to_group").attr("onclick","group_operation('groupinvite','"+current_grp.group_id+"',event)");
			  }
			  $("#"+current_grp.group_id+" #delete_group").attr("onclick","deleteGroup(this,'"+current_grp.group_id+"',event)");
		  }
		  else
		  {
			  $("#"+current_grp.group_id+" .as_admin").remove();//remove star
			  
			  $("#"+current_grp.group_id+" #moderator_power").remove();//No I18N
			  $("#"+current_grp.group_id+" #unsuscribe_group").show();
			  $("#"+current_grp.group_id+" #unsuscribe_group").attr("onclick","unsubscribe('"+current_grp.group_id+"')");
		  }
		  setPhotoUrlWithCache($("#"+current_grp.group_id+" .group_dp"),current_grp.group_photo_url);
		  $("#"+current_grp.group_id+" .group_name").html(current_grp.group_name);
		  $("#"+current_grp.group_id+" .group_members").html(current_grp.group_strength+" "+(current_grp.group_strength>1?i18nGroupkeys["IAM.GROUP.MEMBERS"]:i18nGroupkeys["IAM.GROUP.MEMBER"]));
		  var members=Object.keys(current_grp.group_members);
		  
		  if(current_grp.group_strength==1)
		  {
			  $("#"+current_grp.group_id+" .group_actions .only1").show();
			  $("#"+current_grp.group_id+" .group_actions .only1").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[0]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
		  }
		  else
		  if(current_grp.group_strength==2)
		  {
			  $("#"+current_grp.group_id+" .group_actions .only2").show();
			  $("#"+current_grp.group_id+" .group_actions .only2 .dp1").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[0]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  $("#"+current_grp.group_id+" .group_actions .only2 .dp2").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[1]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
		  }
		  else
		  if(current_grp.group_strength==3)
		  {
			  $("#"+current_grp.group_id+" .group_actions .only3").show();
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp3_plus").hide();
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp1").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[0]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp2").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[1]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp3").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[2]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
		  }
		  else
		  {
			  $("#"+current_grp.group_id+" .group_actions .only3").show();
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp3").hide();
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp1").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[0]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp2").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[1]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp3").css("background","url('"+current_grp.group_members[Object.keys(current_grp.group_members)[2]].member_photo_url+"'),url("+user_2_png+") no-repeat transparent");
			  var other_memebrs=current_grp.group_strength-2>99?"99+":"+"+current_grp.group_strength-2;
			  $("#"+current_grp.group_id+" .group_actions .only3 .dp_number").html(other_memebrs);
		  }
		  
	          tippy(".grp_"+iter+" .showmenu_div", {		  //No I18N
	    			animation: 'scale',					//No I18N
	    			trigger: 'click',				//No I18N
	    			theme:'grp',				//No I18N
	    			appendTo:document.querySelector('.grp_'+iter),		//No I18N
	    			livePlacement: false,
	    			placement:"bottom",			//No I18N
	    			maxWidth: '130px',			//No I18N
	    			duration: 200,
	    			arrow: true,
	    			html: ".grp_"+iter+" .group_options",		//No I18N
	    			hideOnClick: true,
	    			interactive: true,
	    			onHide: grpHighlightRemove,
	    			onShown: grpHighlight
	    		});
	  }
  }
  else
  {
	  $("#empty_groups").show();
	  $("#groupexist").hide();
  }
}
function grpHighlightRemove(event){
	$(".showmenu_div").children().removeClass("dot_highlight");
	$(".group_div").removeClass("selected_grp");
}


function grpHighlight(event){
	$(event.reference).parents(".group_div").children(".showmenu_div").children().addClass("dot_highlight");
	$(event.reference).parents(".group_div").addClass("selected_grp");

}

//$(document).on("click", function (e) 
//		{ 
//			var className = $(e.target).prop('class');
//			$(".group_options").removeClass("showgroup_menu");
//			$(".showmenu_dot").removeClass("dot_highlight");
////			console.log(className+"   "+$(e.target).prop('id'));
//			if(className=="showmenu_div")
//			{			
//				$(e.target).next(".group_options").toggleClass("showgroup_menu");
//				$(e.target).find(".showmenu_dot").toggleClass("dot_highlight");
//			}
//			else if(className=="showmenu_dot")
//			{
//				$(e.target).parent().next(".group_options").toggleClass("showgroup_menu");
//				$(e.target).find(".showmenu_dot").toggleClass("dot_highlight");
//			}
////			if(className=="dp_number")
////			{
////				id=$(e.target).prop('id');
////				$("#"+id+" .group_info_option").click();			
////			}
////			else if(className=="group_div")
////			{
////				id=$(e.target).prop('id');
////				$("#"+id+" .group_info_option").click();			
////			}
////			else 
//		});


//function show_grp_menu(id)
//{
//	$(".group_options").removeClass("showgroup_menu");
//	$(".showmenu_dot").removeClass("dot_highlight");
//	
//	$("#"+id+" .group_options").toggleClass("showgroup_menu");
//	$("#"+id+" .showmenu_dot").toggleClass("dot_highlight");
//}

function close_edit_grp_popup(gid)
{
	if($("#grp_popup").is(":visible"))//remove uploaded pic
	{
		$("#create_groups_template .profile_picture").attr("src",group_2_png); 
		$("#create_groups_template .bg_blur_grp").css("background-image","");
	}
	
	$("#grp_popup").removeClass("pop_anim");
	$("#grp_popup").fadeOut(200,function(){
		$("#grp_popup").removeClass("create_pp_style");
		$("#grp_popup").html(""); 
		if(!$("#grp_info_side").is(":visible")){
			$('body').css({
			    overflow: 'auto' //No I18N
			});
			$(".blur").css("z-index","-1");
		}
		else{
			 $("#grp_info_side").removeClass("grp_info_back");
				if(gid!=undefined)
				{
					group_operation('groupinfo',gid,event);
				}
		}
	});
	if(!$("#grp_info_side").is(":visible")){
		$(".blur").css("opacity","0");
	}
	remove_error();
	assignHash('groups',"");
	return false;
}

function close_group_info_display_space()
{
	remove_error();
	$("#grp_info_side #edit_grp_dp").unbind();
	swicth_to_accepted(true);
    $('#grp_info_side').animate({right:"-50%"},300,function(){
    	$('#grp_info_side').hide();
    	$("#group_info_div .profile_picture").attr("src","");
    	$(".blur").css({"z-index":"-1"});
    	$('html, body').css({
    		overflow: 'auto' //No I18N
    	});
    });
	$(".blur").css("opacity","0");
	if($("#group_action_div").is(":visible"))
	{
		$("#group_action_div").slideUp(200,function(){
			search_areaHeight();
			$("#group_action_div").html("");
		});
	}
	//$("#group_info_display_space").html(""); 
	$('#grp_info_side').unbind();
	assignHash('groups',"");
}

function group_operation(action, id, e)
{
	if(action=="allgroups")
	{
		return;
	}
	if(e!=undefined){
		if($(e.target).parents(".tippy-popper").siblings(".showmenu_div")[0]!=undefined){
			$(e.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
		}
	}
	if(action=="groupinfo")
	{
		var iter=get_groupFrom_GID(id);
		var needed_grp=groups_data[iter];
		if(!needed_grp)
		{
			showErrorMessage(incorret_GID);
			close_group_info_display_space();
			return;
		}
		// $('#grp_info_side').show('slide',{direction: 'right'});
		$('#grp_info_side').show(0,function(){
			$('#grp_info_side').animate({right: "0px"},300, function(){search_areaHeight();});
			popup_blurHandler('6');
		});
		$("#group_info_div img").removeClass("no-group-photo");
		group_info_show(iter);
		assignHash('groups', action+"?"+id);
		$("#grp_info_side").focus();
		if(!isMobile)
		{
			tooltipSet(".group_action");		//No I18N
		}
		closePopup(close_group_info_display_space,"grp_info_side");//No I18N
		$(".grp_info_side").removeClass("grp_info_back");
		$("#grp_info_side #edit_grp_dp").attr("onclick","");
		$("#grp_info_side .drop-down-container").hide();
		$("#grp_info_side #edit_grp_dp").attr("onclick","handleGrpPhotoDropDown("+id+");");
		if($("#"+id+" .as_admin").length>0)//check if the current user is an admin of this account using the star
		{
			$("#grp_info_side .upload-group-photo").attr("onclick","openUploadPhoto('group','"+id+"');");
		}
		 return;
	}
	
/*		if($(e.target).parents("#permission_infotab").length==0){
			$(".grp_info_side").addClass("grp_info_back")
		}*/
		
	//close_group_info_display_space();
	if(!$(".grp_info_side").is(":visible")){
		popup_blurHandler('6');
		$("#grp_popup").html("");
	}
	if(action=="creategroup")
	{	
		$("#grp_popup").html($("#create_groups_template").html());
		$("#create_grp_info").show();
		$("#create_grp_members").show();
		$("#creatgrp_butt1").show();
		$("#create_grp_dp").show();
		init_contacts("select_member_email");//No I18N
		$("#grp_popup").addClass("create_pp_style");
		$("#grp_popup").show(0,function(){
			$("#grp_popup").addClass("pop_anim");
		});
		$("#grp_popup  .profile_picture").removeAttr("style");
		assignHash("groups",action);//No I18N
		$("#create_grp_name").focus();
		closePopup(close_edit_grp_popup,"grp_popup");//No I18N

	}
	else if(action=="groupedit")
	{
		if (!$(".grp_info_side").is(":visible")) 
		{
			$("#grp_popup").html($("#edit_groups").html());
			$('#grp_popup #edit_grp_dp').mouseover(function(){ 
				$('#grp_popup .grp_dp_edit_screen').addClass('profile_picture_edit');   
			});
			$('#grp_popup #edit_grp_dp').mouseleave(function(){
				$('#grp_popup .grp_dp_edit_screen').removeClass('profile_picture_edit');   
			});
			$("#grp_popup").show(0,function(){
				$("#grp_popup").addClass("pop_anim");
			});
			group_edit_info(id);
			assignHash('groups', action+"?"+id);
			$(".textbox:first").focus();
			$("#grp_popup #edit_grp_dp").attr("onclick","handleGrpPhotoDropDown("+id+")");
			closePopup(close_edit_grp_popup,"grp_popup");//No I18N
		}
		else 
		{
			$("#group_action_div").html($("#edit_groups").html());
			
			$("#permission_infotab").hide();
			
			var iter=get_groupFrom_GID(id);
			var needed_grp=groups_data[iter];
			
			
			$("#group_action_div #grpdetails").find("input[name='gid']").val(id);
			$("#group_action_div #grpdetails").find("input[name='grpname']").val(decodeHTML(needed_grp.group_name));
			$("#group_action_div #grpdetails").find("textarea[name='grpdesc']").val(decodeHTML(needed_grp.group_description));
			
			$("#grpdetails").append('<button class="primary_btn_check high_cancel" onclick="return close_info_slide()" tabindex="0">'+err_cancel+'</button>');//No I18N
			$("#group_action_div").slideDown(300,function(){
				search_areaHeight();
			});
			$(".textbox:first").focus();
		}
	}
	else if(action=="groupinvite")
	{
		var iter=get_groupFrom_GID(id);
		var needed_grp=groups_data[iter];
		if(!needed_grp)
		{
			showErrorMessage(incorret_GID);
			close_edit_grp_popup();
			return;
		}
		if($("#group_member_limit").length==0 || groups_data[iter].group_strength < $("#group_member_limit").val())
		{
			if($("#grp_info_side").is(":hidden")){
				$("#grp_popup").html($("#invite_mem_groups").html());
				group_invite_info(iter);
				assignHash('groups', action+"?"+id);
				$("#grp_popup .close_btn").attr("onclick","close_edit_grp_popup('"+id+"');");
				closePopup(close_edit_grp_popup,"grp_popup");//No I18N
							
				init_contacts("invite_more_member");//No I18N
			}
			else
			{
				$("#permission_infotab").hide();
				$("#group_action_div").html($("#invite_mem_groups").html());
				group_invite_info(iter);
				init_contacts("invite_more_member");//No I18N
				$("#group_action_div #invitegrp").append('<button class="primary_btn_check high_cancel" onclick="return close_info_slide()" tabindex="0">'+err_cancel+'</button>');//No I18N	
				$("#group_action_div .field:first").hide();
			}
		}
		else
		{
			if($("#grp_info_side").is(":hidden")){
				$(".blur").css({"z-index":"-1","opacity":"0"});
				$('html, body').css({
					overflow: 'auto' //No I18N
				});
			}
			showErrorMessage(formatMessage(grp_member_limitReached,supportEmail,supportEmail));
		}

	}
}

function setHeightGrpPopup(){  
	if($('#grp_popup').is(':visible'))
	{
		try
		{
			$('#grp_popup').css('height','auto');
			if($('#grp_popup').css('padding-bottom') == '0px'){//addinmg 50px to prevent to scroll and error msg from hiding
				$('#grp_popup').css('height',($('.group_pp_cover:visible')[0].offsetHeight+50)+'px');
			}
			else{
			$('#grp_popup').css('height',($('.group_pp_cover:visible')[0].offsetHeight+80)+'px') //+30 is popup bottom padding +2 px for border
			}
		}
		catch(err)
		{
			$('#grp_popup').hide();
			close_edit_grp_popup();
			$('#grp_popup').unbind();
		}
		
	}
}

function close_info_slide(){
	remove_error();
	$("#permission_infotab").show();
	$("#group_action_div").slideUp(200,function(){
		search_areaHeight();
		$("#group_action_div").html("");
	});
	return false;
}

function init_contacts(id)
{
	if(jQuery.isEmptyObject(frequented_contacts))
	{
		new URI(Contacts,"self","self").GETS().then(function(resp)	//No I18N
				{
					if(resp._apiResponse.status_code==200)//get this checked
					{
						var keys=Object.keys(resp);
						for(iter=0;iter<resp.length;iter++)
						{   
							var current_contact=resp[keys[iter]]; 
							frequented_contacts.push({ 
						        'photoid' : current_contact.photoid,//No I18N
						        name  : current_contact.name,
						        id	: current_contact.id,
						        name_ejs  : current_contact.name_ejs,
						        id_ejs	: current_contact.id_ejs
						    });
						}
						call_othercontacts_search(id);//No I18N
						display_popup_with_conatcts();
					}
					else
					{
						change_conatcts_ele(id,false);
						display_popup_with_conatcts();
					}
				},
				function(resp)
				{
					change_conatcts_ele(id,false);
					display_popup_with_conatcts()
				});
	}	
	else
	{
		call_othercontacts_search(id);//No I18N
		display_popup_with_conatcts();
	}
}

function display_popup_with_conatcts()
{
	
	if(!$("#grp_info_side").is(":hidden"))
	{
		$("#group_action_div").slideDown(300,function(){
			search_areaHeight();
			if($("#grp_info_side #invite_more_member").hasClass("inputSelect")){
				$("#grp_info_side #invite_more_member~.uvselect .selectbox").focus();
			}
			else{			
				$("#grp_info_side #invite_more_member").focus();
			}
		});
	}
	else
	{
		$("#grp_popup").show(0,function(){
			$("#grp_popup").addClass("pop_anim");
			setHeightGrpPopup();
			if($("#grp_popup #invite_more_member").hasClass("inputSelect")){
				$("#grp_popup #invite_more_member~.uvselect .selectbox").focus();
			}
			else{			
				$("#grp_popup #invite_more_member").focus();
			}
		});
	}
}

function change_conatcts_ele(id,contacts_success){
	var id_ele = id=="select_member_email" ? "#grp_popup #create_grp_members":"#invitegrp";//No I18N
	var select_html='<select data-validate="zform_field" name="grpmembers" id="'+id+'" class="inputSelect"></select>';
	var text_html='<textarea id="'+id+'" class="deleteacc_cmnd big_textare" tabindex="0" autocomplete="email" type="emaillist" data-validate="zform_field" name="grpmembers" ></textarea>';
	if(contacts_success){
		$(id_ele+" .contacts_place").html(select_html);
	}
	else{
		$(id_ele+" .contacts_place").html(text_html);
		$(id_ele+" .contacts_place textarea").attr("placeholder",grp_email_placeholder+'('+grp_email_use_comma+')');//No I18N
	}

}

function call_othercontacts_search(id)
{
	change_conatcts_ele(id,true);
	$('#'+id).uvselect({
		width: "100%",
		"option-height": "60px", //No I18N
		multiple: true,
		"custom-option-handler": customValueHandler, //No I18N		
		"custom-option-templateSelection": formatCustomValueSelection, //No I18N
		"inline-search": true, //No I18N
		"prevent_mobile_style": true, //No I18N
		ajax: 
		 {
		    url: "/webclient/v1/account/self/user/self/contacts",//No I18N
		    dataType: 'json',//No I18N
		    delay: 150,
		    data: function (params) 
		    {
		      return {
		        q: params.term, // search term
		        page: params.page||1,
		        per_page: 30
		      };
		    },
		    processResults: function (data, params) 
		    {
		    	if(data.contacts) 
		    	{
		    		results = data.contacts;
		    	}
		    	else if(data!=undefined && data.status_code==404)
		    	{
		    		var mailid=$("#"+id).siblings(".uvselect").find(".multiselect_search_input").val();
		    		if(isEmailId( mailid ))
		    		{
		    			var search=[{id:mailid}]
			    		results=search;
		    		}
		    		else
		    		{
		    			var search=[{text:formatMessage(grp_error_email_invite,mailid)}]
			    		results=search;
		    		}
		    		
		    	}
		    	else if(data!=undefined)
		    	{
		    		results=data;
		    	}
		    	if(params!=undefined)
			    {
			       params.page = params.page;
			    }
			    else
			    {
			    	temp=[];temp.page=1;
			      	params=temp;
			    }
		      return {
		        results: results,
		        pagination: 
		        {
		          more: data.has_more
		        }
		      };
		    },
		    cache: true
		  },
		  templateResult: formatRepo,
		  templateSelection: formatRepoSelection
	});
}

//
//function formatRepo (repo) 
//{
//	if (repo.loading) 
//	{
//	    return repo.text;
//	}
//	else
//	{
//		var markup = repo.name ;
//		return markup;
//	}
//}

//function formatRepoSelection (repo) 
//{
//  return repo.name || repo.id;
//}

function formatRepo (repo)
{
	var gid=$('#invitegrp').find('input[name="gid"]').val();//No I18N
	if (repo.loading) 
	{
		return repo.text;
	}
	var markup=""
	if(repo.photoid)
	{
		//It is neccessary to set value attribute to the first parent element here
		markup = "<div class='uvselect-result-repository' value='"+ repo.id +"'>" + "<span class='uvselect-result-repository__avatar'><img onerror='setDefault_dp(this)' src='"+repo.photoid+"&nps=404' /></span>" +"<span class='uvselect-result-repository__meta'>" + "<div class='uvselect-result-repository__title'>" + repo.name + "</div>";
		markup += "<div class='uvselect-result-repository__statistics'><span class='uvselect-result-repository__stargazers'><i class='fa fa-star'></i> " + repo.id + "</span></div>";
		return markup;
	}
	else
	{
		if(repo.id	&&	isEmailId( repo.id ))
		{
			if(!isEmpty(gid) 	&&	Object.keys(groups_data[get_groupFrom_GID(gid)].group_members).indexOf(decodeHTML(repo.id))!=-1)
			{
				markup= formatMessage(i18nGroupkeys["IAM.GROUP.EXISTING.MEMBERINVITE.SELECTED"],repo.id);
			}
			else
			{
				markup = "<div value='"+ repo.id +"'>" + formatMessage(grp_new_user_invite,repo.id) + "</div>";
			}		
		}
		else
		{
			markup="<span>" + repo.text + "</span>";
		}
		return markup;
	}

}

function formatRepoSelection (repo)
{
	remove_error();
	var gid=$('#invitegrp').find('input[name="gid"]').val();//No I18N
	if(	gid!=""	&&	(Object.keys(groups_data[get_groupFrom_GID(gid)].group_members).indexOf(decodeHTML(repo.id))!=-1))
	{
		$(".contacts_place").append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.EXISTING.MEMBERINVITE.SELECTED"], repo.id)+'</div>' );
		return false;
	}
	else if(repo.photoid)
	{
		return "<img class='user_pic' onerror='setDefault_dp(this)' src='"+repo.photoid+"&nps=404' ><span class='user_name'>"+repo.name || repo.id+"</span>";
	}
	else if(isEmailId( repo.id ))
	{
		return "<span class='user_pic ' style='text-align:center; border-radius: 12px; background-color: beige;'>"+repo.id.slice(0,1)+"</span><span class='user_name'>"+repo.id+"</span>";
	}
	return false;
}

function customValueHandler(element, value)
{
	if(isEmailId(value)){
		return value;
	}
	return "";
}

function formatCustomValueSelection (value)
{
	remove_error();
	return "<span class='user_pic ' style='text-align:center; border-radius: 12px; background-color: beige;'>"+value.slice(0,1).toUpperCase()+"</span><span class='user_name'>"+value+"</span>";
}

//create group functions
function validateGroupInvite()
{
	remove_error();
	var gname= $("#create_grp_name").val();
	var gdescription = $("#create_grp_desc").val();
	var ginitialmembers = $("#select_member_email").val();
	if(isEmpty(gname))
	{
		$("#create_grp_name").parent().append( '<div class="field_error">'+err_groupname_empty+'</div>' );
		$("#create_grp_name").focus();
		 return false;
	}
	else if(hasEmoji(gname))
	{
		$("#create_grp_name").parent().append( '<div class="field_error">'+i18nGroupkeys["IAM.GROUP.ERROR.GROUPNAME.VALID"]+'</div>' );
		$("#create_grp_name").focus();
		 return false;
	}
    else if(gname.length > 100) 
    {
    	$("#create_grp_name").parent().append( '<div class="field_error">'+err_groupname_maxlen+'</div>' );
        return false;
    }
    else if(containsHtmlEntities(gdescription)){
    	$("#create_grp_desc").parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.DESCRIPTION.SYMBOL.ERROR"],groupDescSpecialCharsNotAllowed.split("").join(" "))+'</div>' );
    	$("#create_grp_desc").focus();
        return false;
	}
    else if(gdescription.length > 200) 
    {
    	$("#create_grp_desc").parent().append( '<div class="field_error">'+err_groupdesc_maxlen+'</div>' );
        return false;
    }
    else if(isEmpty(ginitialmembers))
    {
    	$("#select_member_email").parent().append( '<div class="field_error">'+err_enter_mememail+'</div>' );
    	$("#select_member_email").focus();
    	var objDiv = document.getElementById("create_grp");
        objDiv.scrollTop = objDiv.scrollHeight;
        return false;
    }
/*	$("#create_grp_info").hide();
	$("#create_grp_members").show();
	$("#creatgrp_butt1").hide();
	$("#creatgrp_butt2").show();
	$("#create_grp_dp").hide();
	$("#create_grp").attr("onsubmit","return createGrp(this)");
	$("#create_grp_members textarea").focus();*/
	return true;
}

/*function grp_create_back()
{
	$("#create_grp_info").show();
	$("#create_grp_members").hide();
	$("#creatgrp_butt1").show();
	$("#creatgrp_butt2").hide();
	$("#create_grp_dp").show();
	$("#create_grp").attr("onsubmit","return grp_create_next()");
	return false;
}*/

function createGrp(f) 
{
	if(!validateGroupInvite())
	{
		return false;
	}
    var gname=f.grpname.value.trim();
    var gdescription = f.grpdesc.value.trim();
    if($('#select_member_email').is('input, select'))
    {
    	var memeidsval = [];    
        $("#select_member_email :selected").each(function(){
        	memeidsval.push(decodeHTML(this.value));
        });
        var str=memeidsval;
    }
    else
    {
    var memeidsval=f.grpmembers.value.trim();
    var memsubstr=memeidsval.substring(0,memeidsval.lastIndexOf(","));
    var commaindex=memeidsval.lastIndexOf(",");
    var memeids=(commaindex+1) == memeidsval.length?memsubstr : memeidsval;
    var str=memeids.trim().split(',');
    }
//    disabledButton(f);

    if($("#group_member_limit").length==0)
	{
    	var grp_memberlimit=$("#group_member_limit").val();
	}
	else
	{
		var grp_memberlimit="-1";
	}

    if(str.length < 1) 
    {
    	$(f.grpmembers).parent().append( '<div class="field_error">'+err_enter_mememail+'</div>' );
        $(f[0]).find("textarea").focus();//No I18N
        return false;
    }
    else if(grp_memberlimit > 0 && str.length > grp_memberlimit) 
    {
    	if(grp_memberlimit == 1) 
    	{
//    		showErrorMessage(formatMessage(err_groupmembers_caninvite_one, grp_memberlimit));
    		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(err_groupmembers_caninvite_one, grp_memberlimit)+'</div>' );
    	} 
    	else 
    	{
    		//showErrorMessage(formatMessage(err_groupmembers_caninvite, grp_memberlimit));
    		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(err_groupmembers_caninvite, grp_memberlimit)+'</div>' );
        }
    	$(f[0]).find("textarea").focus();//No I18N
        return false;
    }
    var trimmedEmails = [];
    for(var i=0;i<str.length;i++) 
    {
    	str[i] = str[i].trim();
        var iseid=isEmailId(str[i]);
        if(!iseid) 
        {
        	//showErrorMessage(formatMessage(err_invalid_email, str[i]));
        	$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(err_invalid_email, str[i])+'</div>' );
            f.grpmembers.focus();
            handleScrollHeight("create_grp"); //No I18N
            removeButtonDisable(f);
            return false;
        }
        if(str[i].length > 100){
			$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.EMAIL.MAX.LENGTH"], str[i])+'</div>' );
			f.grpmembers.focus();
            handleScrollHeight("create_grp"); //No I18N
			return false;
		}
        if(trimmedEmails.indexOf(str[i])==-1)//to prevent same emails from adding again
        {
			trimmedEmails.push(str[i]);
		}
    }
    
    if(validateForm(f))
    {
    	disabledButton(f);
    	var parms=
		{
			"grpname":gname,//No I18N
			"grpdesc":gdescription,//No I18N
//			"lang":$('#'+f.id).find('select[name="lang"]').val(),//No I18N
			"grpmembers":trimmedEmails//No I18N
//			"message":$('#'+f.id).find('input[name="message"]').val()//No I18N
		};

		var payload = Groups.create(parms);
		payload.POST("self","self").then(function(resp)	//No I18N
		{
			SuccessMsg(getErrorMessage(resp));
			if(resp.groups.href!=undefined)
			{
				delete resp.groups.href
			}
			groups_data[(groups_data.length)]=resp.groups;
			if(new_group_with_dp==true)
			{
				new_group_with_dp=false;
				change_grp_pic(undefined,resp.groups.group_id);
			}
			else
			{
				load_groups();
				close_edit_grp_popup();
			}
			removeButtonDisable(f);
			
		},
		function(resp)
		{
			showErrorMessage(getErrorMessage(resp));
			removeButtonDisable(f);
		});
    }
    return false;
}

//edit group 

function group_edit_info(G_id)
{
	
	var iter=get_groupFrom_GID(G_id);
	var needed_grp=groups_data[iter];
	
	if(needed_grp==null)
	{
		showErrorMessage(incorret_GID);
		close_edit_grp_popup();
	}
	$("#grp_popup #edit_grp_dp .profile_picture").removeClass("no-group-photo");
	setPhotoUrl($("#grp_popup #edit_grp_dp"),G_id);
	$("#grp_popup .profile_options").attr("onclick","handleGrpPhotoDropDown("+G_id+")");
	$("#grp_popup .view-group-photo").attr("onclick", "handleGroupPhotoView('"+$("#grp_popup #edit_grp_dp .profile_picture").attr("src")+"')");
	$("#grp_popup .delete-group-photo").attr("onclick", "deleteGroupPhoto('"+G_id+"' ,"+iter+")");
	$("#grp_popup .upload-group-photo").attr("onclick","openUploadPhoto('group','"+G_id+"');");
	
	$("#grp_popup #grpdetails").find("input[name='gid']").val(G_id);
	$("#grp_popup #grpdetails").find("input[name='grpname']").val(decodeHTML(needed_grp.group_name));
	$("#grp_popup #grpdetails").find("textarea[name='grpdesc']").val(decodeHTML(needed_grp.group_description));

}


function edit_group_info(f)
{
	remove_error();
	var gid=$('#'+f.id).find('input[name="gid"]').val();//No I18N
	var Gname=$('#'+f.id).find('input[name="grpname"]').val().trim();//No I18N
	var Gdesc=$('#'+f.id).find('textarea[name="grpdesc"]').val().trim();//No I18N
	if(isEmpty(Gname))
	{
		$('#'+f.id).find('input[name="grpname"]').parent().append( '<div class="field_error">'+err_groupname_empty+'</div>' );
		 return false;
	}
	else if(hasEmoji(Gname))
	{
		$('#'+f.id).find('input[name="grpname"]').parent().append( '<div class="field_error">'+i18nGroupkeys["IAM.GROUP.ERROR.GROUPNAME.VALID"]+'</div>' );
		 return false;
	}
    else if(Gname.length > 100) 
    {
    	$('#'+f.id).find('input[name="grpname"]').parent().append( '<div class="field_error">'+err_groupname_maxlen+'</div>' );
        return false;
    }
    else if(containsHtmlEntities(Gdesc)){
		$('#'+f.id).find('textarea[name="grpdesc"]').parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.DESCRIPTION.SYMBOL.ERROR"],groupDescSpecialCharsNotAllowed.split("").join(" "))+'</div>' );
    	$('#'+f.id).find('textarea[name="grpdesc"]').focus();
    	return false;
	}
    else if(Gdesc.length > 200) 
    {
    	$('#'+f.id).find('textarea[name="grpdesc"]').parent().append( '<div class="field_error">'+err_groupdesc_maxlen+'</div>' );
         return false;
    }
	disabledButton(f);
	var parms=
	{
		"grpname":Gname,//No I18N
		"grpdesc":Gdesc//No I18N
	};
	var payload = Groups.create(parms);
	payload.PUT("self","self",gid).then(function(resp)	//No I18N
	{	
		SuccessMsg(getErrorMessage(resp));
		var iter=get_groupFrom_GID(gid);
		groups_data[iter].group_name=escapeInput(Gname);
		groups_data[iter].group_description=escapeInput(Gdesc);
		load_groups();
		removeButtonDisable(f);
		if($('#grp_info_side').is(":visible"))
		{
			group_operation('groupinfo',gid,event);
			close_info_slide();
		}
		else
		{
			close_edit_grp_popup();
		}
	},
	function(resp)
	{
		showErrorMessage(getErrorMessage(resp));
		removeButtonDisable(f);
	});
	return false;
}


//invite to group

function group_invite_info(iter)
{
	var needed_grp=groups_data[iter];
	if($(".grp_info_side").is(":visible"))
	{
		$("#group_action_div #invite_popup_groupName").remove();
		if($("#group_member_limit").length==0)
		{
			$("#group_action_div #invite_popup_grouplimit").val( $("#group_member_limit").val());
		}
		else
		{
			$("#group_action_div #invite_popup_grouplimit").val("-1");
		}
		$("#group_action_div #invitegrp").find("input[name='gid']").val(needed_grp.group_id);
	}
	else
	{
		
		$("#grp_popup #invite_popup_groupName").val(needed_grp.group_name);
		if($("#group_member_limit").length==0)
		{
			$("#grp_popup #invite_popup_grouplimit").val( $("#group_member_limit").val());
		}
		else
		{
			$("#grp_popup #invite_popup_grouplimit").val("-1");
		}
		$("#grp_popup #invitegrp").find("input[name='gid']").val(needed_grp.group_id);
	}
}


function Invitefriends(f) 
{
	
	
    if($('#invite_more_member').is('input, select'))
    {
    	var invitememeids = [];    
        $("#invite_more_member :selected").each(function(){
        	invitememeids.push(decodeHTML(this.value));
        });
        var str=invitememeids;
    }
    else
    {
        var invitememeids=f.grpmembers.value;
        var invitememsubstr=invitememeids.substring(0,invitememeids.lastIndexOf(","));
        var commaindex=invitememeids.lastIndexOf(",");
        invitememeids=(commaindex+1) == invitememeids.length?invitememsubstr : invitememeids;
        var str=invitememeids.trim().split(/\s*,\s*/);
    }
	remove_error();
    if($("#group_member_limit").length==0)
	{
    	var grp_memberlimit=$("#group_member_limit").val();
	}
	else
	{
		var grp_memberlimit="-1";
	}
    
    if(invitememeids.length < 1) 
    {
     	//showErrorMessage(err_enter_mememail);
     	$(f.grpmembers).parent().append( '<div class="field_error">'+err_enter_mememail+'</div>' );
     	f.grpmembers.focus();
        return false;
    }
    else if(grp_memberlimit > 0 && str.length > grp_memberlimit) 
    {
     	if(grp_memberlimit == 1) 
     	{
     		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(err_groupmembers_cannot_invitemore_one, grp_memberlimit)+'</div>' );
     	} else 
     	{
     		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(err_groupmembers_cannot_invitemore, grp_memberlimit)+'</div>' );
        }
        f.grpmembers.focus();
        return false;
    }
    else if(!isEmpty(str)) 
    {
    	var gid=$('#'+f.id).find('input[name="gid"]').val();//No I18N
    	var intersection = Object.keys(groups_data[get_groupFrom_GID(gid)].group_members).filter(element => str.includes(element));//checking if the user is previously added in group 
    	var trimmedEmails = [];
        for(var i=0;i<str.length;i++) 
        {
        	str[i] = str[i].trim();
            var iseid=isEmailId(str[i]);
            if(!iseid) 
            {
            	$(f.grpmembers).parent().append( '<div class="field_error"></div>' );
            	$(f.grpmembers).parent().children(".field_error").text(escapeInput(formatMessage(err_invalid_email, str[i])));
            	handleScrollHeight("invitegrp"); //No I18N
                f.grpmembers.focus();
                return false;
            }
            if(str[i].length > 100){
				$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.EMAIL.MAX.LENGTH"], str[i])+'</div>' );
                f.grpmembers.focus();
                handleScrollHeight("invitegrp"); //No I18N
                return false;
			}
            if(trimmedEmails.indexOf(str[i])==-1)//to prevent same emails from adding again
	        {
				trimmedEmails.push(str[i]);
			}
        }
        if(intersection.length>0	&&	!$('#invite_more_member').is('input, select')	)
        {
        	if(intersection.length == 1) 
         	{
         		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.EXISTING.MEMBER.INVITED.ERROR"], intersection[0])+'</div>' );
         	}
        	else
        	{
         		$(f.grpmembers).parent().append( '<div class="field_error">'+formatMessage(i18nGroupkeys["IAM.GROUP.EXISTING.MEMBERS.INVITED.ERROR"], intersection.length)+'</div>' );
        	}
        	$(f.grpmembers).parent().find(".field_error b").addClass("group_invite_err")
        	$(f.grpmembers).parent().find(".field_error b").attr("onclick","remove_from_invite('"+f.id+"',"+JSON.stringify(intersection)+");");//No I18N
         	f.grpmembers.focus();
            return false;
        }
        if( validateForm(f))
        {
        	disabledButton(f);
        	var parms=
    		{
//        			"lang":$('#'+f.id).find('select[name="lang"]').val(),//No I18N
        			"grpmembers":trimmedEmails//No I18N
//        			"message":$('#'+f.id).find('input[name="message"]').val()//No I18N
    		};

    		var payload = Groups.create(parms);
    		payload.PUT("self","self",gid).then(function(resp)	//No I18N
    		{    
    			SuccessMsg(getErrorMessage(resp));
    			var iter=get_groupFrom_GID(gid);
    			if(resp.groups.href!=undefined)
    			{
    				delete resp.groups.href
    			}
   				groups_data[iter].pending_invitations=resp.groups;  
   				if($('#grp_info_side').is(":visible"))
   				{
   					group_operation('groupinfo',gid,event);
   					close_info_slide();
   				}
   				else
   				{
   	   				close_edit_grp_popup();
   				}
   				removeButtonDisable(f);
    		},
    		function(resp)
    		{
    			showErrorMessage(getErrorMessage(resp));
    			removeButtonDisable(f);
    		});
        }
       

    }
    return false;
}

function remove_from_invite(id,extra_email)
{
	var invitememeids=$("#"+id+" #invite_more_member").val();
    var invitememsubstr=invitememeids.substring(0,invitememeids.lastIndexOf(","));
    var commaindex=invitememeids.lastIndexOf(",");
    invitememeids=(commaindex+1) == invitememeids.length?invitememsubstr : invitememeids;
    var str=invitememeids.trim().split(/\s*,\s*/);
    
    str = str.filter( function( el ) {
    	  return !extra_email.includes( el );
    	} );
 var txt="";
    for(i=0;i<str.length;i++)
    {
    	txt+=str[i]+",";
    }
    $("#"+id+" #invite_more_member").val(txt.slice(0,-1));
    remove_error();
}


//delete group
function deleteGroup(ele, ZGID, event) 
{   
	if(event!=undefined){
		if($(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]!=undefined){
			$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
		}
	}
	var grp_name=$("#"+ZGID+" .group_details .group_name").html();
	
	if($('#grp_info_side').is(":visible")){		
		//close_group_info_display_space();
		//$("#grp_info_side").addClass("grp_info_back");
		$("#group_action_div").append('<div class="confirm_text">'+formatMessage(err_sure_dltgrp,grp_name)+'</div>');
		$("#group_action_div").append('<button class="primary_btn_check" >'+iam_continue+'</button>');
		$("#group_action_div .primary_btn_check:first").attr("onclick","conformed_to_delete('"+ZGID+"','"+iter+"')");
		$("#group_action_div").append('<button class="primary_btn_check  cancel_btn" onclick="return close_info_slide()">'+err_cancel+'</button>');
		$("#permission_infotab").hide();
		$("#group_action_div").slideDown(200,function(){
			search_areaHeight();
		});
	}
	else{
		show_confirm(err_sure_dltgrp_header,formatMessage(err_sure_dltgrp,grp_name)
	    		,function()
	    				{
							conformed_to_delete(ZGID,iter);
	    				}
			    ,function()
			    		{
			    		if($('#grp_info_side').is(":visible")){	
			    			popup_blurHandler('6');
			    			$("#grp_info_side").removeClass("grp_info_back");
			    		}
			    		$('#grp_info_side').focus();
			    			return false;
			    		});
	}
	
    $("#confirm_popup button:first").focus();
}

function conformed_to_delete(ZGID,iter){
	new URI(Groups,"self","self",ZGID).DELETE().then(function(resp)	//No I18N
    		{
    			close_group_info_display_space();
    			SuccessMsg(getErrorMessage(resp));
    			var iter=get_groupFrom_GID(ZGID);
    			groups_data.splice(iter, 1);
    			load_groups();
    		},
    		function(resp)
    		{
    			showErrorMessage(getErrorMessage(resp));
    		});
}
//unsuscribe
function unsubscribe(gid) 
{   
	$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
	var grp_name=$("#"+gid+" .group_details .group_name").html();
    show_confirm(err_groupunsubscribe_header,formatMessage(err_groupunsubscribe_sure,grp_name)
    		,function()
    				{
						new URI(Groups,"self","self",gid).DELETE().then(function(resp)	//No I18N
							{
								SuccessMsg(getErrorMessage(resp));
								var iter=get_groupFrom_GID(gid);
								groups_data.splice(iter, 1);
								load_groups();
							},
							function(resp)
							{
								showErrorMessage(getErrorMessage(resp));
							});
    				}
		    ,function()
		    		{
		    			return false;
		    		});
}













function deleteMember(gid, memberEmail, event) 
{
		$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
        show_grp_confirm(formatMessage(err_group_existmember_delete_msg, memberEmail)
        		,function()
        				{
        					new URI(GMemeber,"self","self",gid,memberEmail).DELETE().then(function(resp)	//No I18N
        							{
        								SuccessMsg(getErrorMessage(resp));
        								var iter=get_groupFrom_GID(gid);
        								delete groups_data[iter].group_members[memberEmail]
        								var num=--groups_data[iter].group_strength;
        								$("#"+current_grp.group_id+" .group_members").html(current_grp.group_strength+" "+(current_grp.group_strength>1?i18nGroupkeys["IAM.GROUP.MEMBERS"]:i18nGroupkeys["IAM.GROUP.MEMBER"]));

        								$("#"+gid+" .group_members").html(num+" "+(num>1?i18nGroupkeys["IAM.GROUP.MEMBERS"]:i18nGroupkeys["IAM.GROUP.MEMBER"]));
        								group_operation('groupinfo',gid);	
        							},
        							function(resp)
        							{
        								showErrorMessage(getErrorMessage(resp));
        							});
        					
   
        				}
    		    ,function()
    		    		{
    		    			return false;
    		    		});

}



function deleteZInvite(gid, u_mailid, userExists, event) 
{
	$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
//	var _uid = uid;
	$("#grp_info_side").addClass("grp_info_back");
	show_grp_confirm(err_group_invitedmember_delete_msg
    		,function()
    				{
		
					new URI(GMemeber,"self","self",gid,u_mailid).DELETE().then(function(resp)	//No I18N
							{
								SuccessMsg(getErrorMessage(resp));
								var iter=get_groupFrom_GID(gid);
								delete groups_data[iter].pending_invitations[u_mailid];
								group_operation('groupinfo',gid);
								if($("#grp_search_space #group_search").is(":visible"))
								{
									searchMembers();
								}
							},
							function(resp)
							{
								showErrorMessage(getErrorMessage(resp));
								
							});

    				}
		    ,function()
		    		{
		    			if($('#grp_info_side').is(":visible")){	
		    				popup_blurHandler('6');
		    				$("#grp_info_side").removeClass("grp_info_back");
		    			}
		    			$('#grp_info_side').focus();
		    			return false;
		    		});
    
    
}



//Notification DIV accept and reject member invite

function GroupInvitaion_Responce(zgid,status)
{
	var payload = GInvitation.create();

	payload.PUT("self","self",zgid,status).then(function(resp)	//No I18N
			{	
				if(window.location.hash.indexOf("#groups")!=-1)
				{
					window.location.reload();
				}
				else
				{
					$("#notification_"+zgid+" .zgid").text(getErrorMessage(resp));
					if(status=="accept")
					{
						$("#notification_"+zgid+" .notification_buttons_div .red_button").remove();
						$("#notification_"+zgid+" .notification_buttons_div .notification_button").html(err_view_grp);
						$("#notification_"+zgid+" .notification_buttons_div .notification_button").attr("onclick","goto_grps_notfication('"+zgid+"');");
						
					}
					else
					{
						$("#notification_"+zgid+" .notification_buttons_div").remove();
					}
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
			},
			function(resp)
			{
				showErrorMessage(getErrorMessage(resp));
			});
}

function goto_grps_notfication(zgid)
{
	$("#notification_"+zgid).remove();
	loadTab('groups','allgroups');//No I18N
}

//info actions

function group_info_show(iter)
{
	var needed_grp=groups_data[iter];
	setPhotoUrl($("#group_info_div #edit_grp_dp"),needed_grp.group_id);
	$("#group_info_div .info_group_name").text(decodeHTML(needed_grp.group_name));
	$("#group_info_div .info_group_discription").text(decodeHTML(needed_grp.group_description));
	$("#group_info_div .view-group-photo").attr("onclick", "handleGroupPhotoView('"+$("#group_info_div #edit_grp_dp .profile_picture").attr("src")+"')");
	$("#group_info_div .delete-group-photo").attr("onclick", "deleteGroupPhoto('"+needed_grp.group_id+"' ,"+iter+")");
	if(needed_grp.is_moderator)
	{
		$("#permission_infotab").show();
		$("#permission_infotab .icon-edit").attr("onclick","group_operation('groupedit','"+needed_grp.group_id+"',event)");
		  if($("#create_groups_template").length)
		  {
			  $("#permission_infotab .icon-addmember").attr("onclick","group_operation('groupinvite','"+needed_grp.group_id+"',event)");
		  }
		  if(needed_grp.is_admin)
		  {
			   $("#permission_infotab .icon-exit-group").hide();
			   $("#permission_infotab .icon-delete").show();
			   $("#permission_infotab .icon-delete").attr("onclick","deleteGroup(this,'"+needed_grp.group_id+"',event)");
		  }
		  else
		  {   $("#permission_infotab .icon-delete").hide();
			  $("#permission_infotab .icon-exit-group").show();
			  $("#permission_infotab .icon-exit-group").attr("onclick","deleteGroup(this,'"+needed_grp.group_id+"',event)");
		  }
		  $("#permission_infotab .icon-delete").attr("onclick","deleteGroup(this,'"+needed_grp.group_id+"',event)");
		  
		  //can see the pending inviations only if he is a moderator
		  $("#group_info_div #show_pendingtab").show();
		  
		  
		  //pending invitations
		  if(needed_grp.pending_invitations!=undefined)
		  {
			  $("#pending_member_space").html("");
			  $("#no_invitaions").hide();
			  var pendning_members=Object.keys(needed_grp.pending_invitations);
		      if(pendning_members.length<1)
		      {
		    	  if($("#grp_search_space").is(":visible")){ 
		    		  $("#pending_members").hide();
		    	  }
		    	  else{
		    		  $("#no_invitaions").show();
		    	  }
		    	  $("#group_info_div #show_pendingtab #pcont").html(pendning_members.length);
		      } 
		      else
		      {
		    	  $("#no_invitaions").hide();
		    	  $("#group_info_div #show_pendingtab #pcont").html(pendning_members.length);
		    	  for(var i=0;i<pendning_members.length;i++)
		    	  {
		    		    var current_member=needed_grp.pending_invitations[pendning_members[i]];
		    			member_format = $("#empty_member_format").html();
		    			$("#pending_member_space").append(member_format);	    			
		    			$("#pending_member_space #grp_user").remove();//No I18N
		    			$("#pending_member_space #grp_mod").remove();//No I18N
		    			$("#pending_member_space #accepted_member").remove();//No I18N
		    			
		    			var group_id=needed_grp.group_id;
		    			var ele_id=decodeHTML(current_member.invited_email);
		    			$("#pending_member_space #member").attr("id","mem"+"_"+ele_id);
		    			var element=de("mem"+"_"+ele_id);//No I18N
		    			$(element).addClass("pending_mem"+i);
		    			
		    			var isExistUser=false;
		    			if(current_member.invited_name_ejs!=undefined)//existing zoho user
		    			{	$(element).addClass("ExistUser");
		    				$(element).find(".member_name").html(current_member.invited_name);//No I18N
		    				$(element).find(".member_email a").html(current_member.invited_email);//No I18N
		    				$(element).find("#member_dp").css("background",'url("'+current_member.invited_photo_url+'"),url("'+user_2_png+'") no-repeat transparent');//No I18N
		    				isExistUser=true;
		    				$(element).find("#grp_admin").html(err_pending_text);	    				
		    			}
		    			else
		    			{
		    				$(element).find(".member_name").html(pendning_members[i]);//No I18N
		    				$(element).find(".member_email").html(grp_mem_not_registered);//No I18N
		    				$(element).find("#member_dp").html(pendning_members[i].slice(0,1));
		    				$(element).find("#member_dp").css("border","1px solid #c5c5c5");
		    				$(element).find("#grp_admin").html(err_pending_text);	
		    			}
		    			$(element).find(" #invited_memebr #pending_reinvite").attr("onclick","reinviteUser('"+group_id+"','"+ele_id+"','"+isExistUser+"',event);");//No I18N
	    				
		    			$(element).find(" #invited_memebr #pending_remove").attr("onclick","deleteZInvite('"+group_id+"','"+ele_id+"',"+isExistUser+",event);");//No I18N
		    			
		    			tippy(".pending_mem"+i+" .showmenu_div", {		  //No I18N
			    			animation: 'scale',					//No I18N
			    			trigger: 'click',				//No I18N
			    			theme:'grp',				//No I18N
			    			appendTo:document.querySelector(".pending_mem"+i),	//No I18N
			    			livePlacement: true,
			    			placement:"bottom",			//No I18N
			    			maxWidth: '130px',			//No I18N
			    			arrow: true,
			    			duration: 200,
			    			html: ".pending_mem"+i+" .group_options",		//No I18N
			    			hideOnClick: true,
			    			interactive: true,
			    			onHide:memHighlightRemove,
			    			onShown:memHighlight
			    		});
		    	  }
		      }
		  }
		  else
		  {
			  $("#pending_member_space").html("");
			  $("#group_info_div #show_pendingtab #pcont").html("0");
			  $("#no_invitaions").show();
		  }
		  $(".group_info_div #edit_grp_dp").addClass("icon-camera");  
	}
	else
	{
		$("#permission_infotab").hide();
		$(".group_info_div #edit_grp_dp").removeClass("icon-camera");
		$("#group_info_div #show_pendingtab").hide();
	}
	
	var accepted_members=Object.keys(needed_grp.group_members);
	$("#group_info_div #show_acceptedtab #grp_size").html(accepted_members.length);
	
	$("#member_admin_space").html("");
	$("#member_moderator_space").html("");
	$("#member_user_space").html("");
	$(".grup_member_space").show();
	$(".grup_moderator_space").show();
	var ismod_present=false;
	var ismem_present=false;
	for(var i=0;i<accepted_members.length;i++)
	{
		var current_member=needed_grp.group_members[accepted_members[i]];
		member_format = $("#empty_member_format").html();
		if(current_member.is_owner!=undefined && current_member.is_owner)
		{
			$("#member_admin_space").append(member_format);
			$("#member_admin_space #member").attr("id","member"+current_member.member_email);
			var element=de("member"+current_member.member_email);//No I18N
			$(element).find(".showmenu_div").remove();//No I18N
			$(element).find(".group_options").remove();//No I18N
			
			$(element).find("#member_dp").css("background",'url("'+current_member.member_photo_url+'"),url("'+user_2_png+'") no-repeat transparent');//No I18N

			
			$(element).find("#grp_user").remove();//No I18N
			$(element).find("#grp_mod").remove();//No I18N
			
			$(element).find(".member_name").html(current_member.member_name);//No I18N
			$(element).find(".member_email a").html(current_member.member_email);//No I18N
			$(element).find(".member_email a").attr("href","mailto:"+current_member.member_email);
		}
		else if(current_member.is_moderator!=undefined && current_member.is_moderator)
		{
			ismod_present=true;
			$("#member_moderator_space").append(member_format);
			$("#member_moderator_space #member").attr("id","member"+current_member.member_email);
			var element=de("member"+current_member.member_email);//No I18N
			$(element).addClass("moderator"+i);
			$(element).find("#member_dp").css("background","url('"+current_member.member_photo_url+"'),url('"+user_2_png+"') no-repeat transparent");//No I18N

			$(element).find(".member_name").html(current_member.member_name);//No I18N
			$(element).find(".member_email a").html(current_member.member_email);//No I18N
			$(element).find(".member_email a").attr("href","mailto:"+current_member.member_email);
			
			$(element).find("#grp_user").remove();//No I18N
			$(element).find("#grp_admin").remove();//No I18N
			if(current_member.member_email!=userPrimaryEmailAddress && needed_grp.is_moderator)//not current user and has permission
			{
				$(element).find(".group_options #invited_memebr").remove();//No I18N
				$(element).find(".group_options #accepted_member #member_promote").remove();//No I18N
				
				$(element).find(".group_options #accepted_member #member_depromote").attr("onclick","updateMember('"+needed_grp.group_id+"','"+current_member.member_email+"',true,event);");//No I18N
				$(element).find(".group_options #accepted_member #member_remove").attr("onclick","deleteMember('"+needed_grp.group_id+"','"+current_member.member_email+"',event);");//No I18N

    			tippy(".moderator"+i+" .showmenu_div", {		  //No I18N
	    			animation: 'scale',					//No I18N
	    			trigger: 'click',				//No I18N
	    			theme:'grp',				//No I18N
	    			appendTo:document.querySelector(".moderator"+i),	//No I18N
	    			livePlacement: false,
	    			placement:"bottom",			//No I18N
	    			maxWidth: '130px',			//No I18N
	    			arrow: true,
	    			html: ".moderator"+i+" .group_options",		//No I18N
	    			hideOnClick: true,
	    			interactive: true,
	    			duration: 200,
	    			onHide:memHighlightRemove,
	    			onShown:memHighlight
	    		});
			}
			else
			{
				$(element).find(".showmenu_div").remove();//No I18N
				$(element).find(".group_options").remove();//No I18N
			}
		}
		else
		{	ismem_present=true;
			$("#member_user_space").append(member_format);
			$("#member_user_space #member").attr("id","member"+current_member.member_email);
			var element=de("member"+current_member.member_email);//No I18N
			$(element).addClass("member"+i);
			$(element).find("#member_dp").css("background","url('"+current_member.member_photo_url+"'),url('"+user_2_png+"') no-repeat transparent");//No I18N

			$(element).find(".member_name").html(current_member.member_name);//No I18N
			$(element).find(".member_email a").html(current_member.member_email);//No I18N
			$(element).find(".member_email a").attr("href","mailto:"+current_member.member_email);
			
			$(element).find("#grp_mod").remove();//No I18N
			$(element).find("#grp_admin").remove();//No I18N
			
			if(needed_grp.is_moderator)//current user has permission
			{
				$(element).find(".group_options #invited_memebr").remove();//No I18N
				$(element).find(".group_options #accepted_member #member_depromote").remove();//No I18N
				
				$(element).find(".group_options #accepted_member #member_promote").attr("onclick","updateMember('"+needed_grp.group_id+"','"+current_member.member_email+"',false,event);");//No I18N
				$(element).find(".group_options #accepted_member #member_remove").attr("onclick","deleteMember('"+needed_grp.group_id+"','"+current_member.member_email+"',event);");//No I18N

    			tippy(".member"+i+" .showmenu_div", {		  //No I18N
	    			animation: 'scale',					//No I18N
	    			trigger: 'click',				//No I18N
	    			theme:'grp',				//No I18N
	    			appendTo:document.querySelector(".member"+i),	//No I18N
	    			livePlacement: false,
	    			placement:"bottom",			//No I18N
	    			maxWidth: '130px',			//No I18N
	    			arrow: true,
	    			html: ".member"+i+" .group_options",		//No I18N
	    			hideOnClick: true,
	    			duration: 200,
	    			interactive: true,
	    			onHide:memHighlightRemove,
	    			onShown:memHighlight
	    		});
			}
			else
			{
				$(element).find(".showmenu_div").remove();//No I18N
				$(element).find(".group_options").remove();//No I18N
			}
			
		}
	}//end of accepted member loop

	if(!ismod_present)
	{
		$(".grup_moderator_space").hide();
	}
	if(!ismem_present)
	{
		$(".grup_member_space").hide();
	}
	
}
function memHighlightRemove(event){
	$(".showmenu_div").children().removeClass("dot_highlight");
	$(".showmenu_div").removeClass("menu_show");
	$(".member").removeClass("selected_member");
}

function memHighlight(event){
	$(event.reference).parents(".member").children(".showmenu_div").children().addClass("dot_highlight");
	$(event.reference).parents(".member").children(".showmenu_div").addClass("menu_show");
	$(event.reference).parents(".member").addClass("selected_member");

}

function updateMember(zgid,memberEmail,isModerator,event)
{
	$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
	var grp_name=$("#"+zgid+" .group_details .group_name").html();
	if(isModerator)//update moderator to member
	{ 

		show_grp_confirm(formatMessage(err_group_makemember_confirm_msg, memberEmail,grp_name)
        		,function()
        				{
        					updateMember_continue(zgid, memberEmail,isModerator)
        				}
    		    ,function()
    		    		{
    		    			return false;
    		    		});
		
		
	}else//update member to moderator
	{ 

		
		show_grp_confirm(formatMessage(err_group_makemoderator_confirm_msg, memberEmail,grp_name)
        		,function()
        				{
        					updateMember_continue(zgid, memberEmail,isModerator)
        				}
    		    ,function()
    		    		{
    		    			return false;
    		    		});
	}
}


function updateMember_continue(zgid, memberEmail,isModerator,event)
{
	var parms=
	{
			"isModerator":isModerator//No I18N
	};
	var payload = GMemeber.create(parms);

	payload.PUT("self","self",zgid,memberEmail).then(function(resp)	//No I18N
			{	
				SuccessMsg(getErrorMessage(resp));
				var iter=get_groupFrom_GID(zgid);
				if(isModerator)
				{
					groups_data[iter].group_members[memberEmail].is_moderator=false;
				}
				else
				{
					groups_data[iter].group_members[memberEmail].is_moderator=true;
				}
				group_operation('groupinfo',zgid);
			},
			function(resp)
			{
				showErrorMessage(getErrorMessage(resp));
			});
}



function reinviteUser(gid, u_mailid, isExistUser) 
{    
	$(event.target).parents(".tippy-popper").siblings(".showmenu_div")[0]._tippy.hide();
	var parms=
	{
			"isReInvite":isExistUser//No I18N
	};
	var payload = GMemeber.create(parms);

	payload.PUT("self","self",gid,u_mailid).then(function(resp)	//No I18N
			{	
				SuccessMsg(getErrorMessage(resp));
			},
			function(resp)
			{
				showErrorMessage(getErrorMessage(resp));
			});
}






//info toggles






function swicth_to_accepted(ignore_check_height)
{
	 $(".acceptedtab").css("font-weight","500");
	 $(".pendingtab").css("font-weight","400");
	 $(".searchtab").css("font-weight","400");
	
	 $("#pending_members").hide();
	 $("#accepted_members").show();
	 if(!ignore_check_height)
	 {
		$("#grp_search_space").slideUp(200,function(){
		 search_areaHeight();
		 }); 
	 }
	 
	 
		var width = $(".acceptedtab").width();
		$(".highlight_tab").css({"margin-left":"0px","width":width+"px"});
		$("#group_search").val("");
		//searchMembers();
		
		$(".member_info_head").show();
		$(".active-member").show();
		$(".space_separation").removeClass("search_mode");
		$(".noresult").hide();
		$("#pendning_separator").hide();
}

function swicth_to_pending()
{
	$(".acceptedtab").css("font-weight","400");
	$(".pendingtab").css("font-weight","500");
	$(".searchtab").css("font-weight","400");
	
	$("#pending_members").show();
	$("#accepted_members").hide();
	$("#grp_search_space").slideUp(200,function(){
		search_areaHeight();
	});
	
	var width = $(".pendingtab").width();
	var left = $(".acceptedtab").width()+24;
	$(".highlight_tab").css({"margin-left":left+"px","width":width+"px"});
	$("#group_search").val("");
	//searchMembers();
	$(".member_info_head").show();
	$(".active-member").show();
	$(".space_separation").removeClass("search_mode");
	$(".noresult").hide();
	$("#pendning_separator").hide();
	if($("#pending_member_space .active-member ").length < 1)
	{
		$("#no_invitaions").show();
	}
}

function show_grp_search_bar()
{
	$(".acceptedtab").css("font-weight","400");
	$(".pendingtab").css("font-weight","400");
	$(".searchtab").css("font-weight","400");

	$("#pending_members").show();
	$("#accepted_members").show();
	$("#grp_search_space").slideDown(200,function(){
		search_areaHeight();
	});
	
	var width = $(".searchtab").width();
	$(".highlight_tab").css({"margin-left":"calc( 100% - "+width+"px - 70px" ,"width":width+"px"});
	$("#group_search").val("");
	searchMembers();
	$("#group_search").focus();
	
}


var old_val;
function searchMembers()
{
	
	var val=$("#group_search").val().toLowerCase();
	$(".noresult").hide();
	$("#pendning_separator").show();
	for(var i=0;i<$(".active-member").length;i++){
		var memberN=$(".active-member")[i].getElementsByClassName("member_name")[0].innerHTML;
		if($(".active-member")[i].getElementsByClassName("grpemaillink")[0]!=undefined){
			var memberM=$(".active-member")[i].getElementsByClassName("grpemaillink")[0].innerHTML;
		}
		
		if(memberN.indexOf("<span")!=-1){
			memberN=memberN.slice(0 , memberN.indexOf("<s"))+""+memberN.slice(memberN.indexOf("<s")+23,memberN.indexOf("<s")+23+old_val.length)+""+memberN.slice(memberN.indexOf("</s")+7);
			$($(".active-member")[i]).find(".member_name").text(memberN);
		}
		if(memberM.indexOf("<span")!=-1){
			memberM=memberM.slice(0 , memberM.indexOf("<s"))+""+memberM.slice(memberM.indexOf("<s")+23,memberM.indexOf("<s")+23+old_val.length)+""+memberM.slice(memberM.indexOf("</s")+7);
			$($(".active-member")[i]).find(".grpemaillink").text(memberM);
		}
	}
	if(val=="")
	{
		$(".member_info_head").show();
		$(".active-member").css("display","inline-block");
		$("#pendning_separator").show();
		$("#accepted_separator").show();
		$(".space_separation").show();
		$("#pending_members").show();
		check_showOrhide("accepted_members",1);	//No I18N
		check_showOrhide("pending_members",1);	//No I18N
		check_showOrhide("member_admin_space",2);	//No I18N
		check_showOrhide("member_moderator_space",2);	//No I18N
		check_showOrhide("member_user_space",2);	//No I18N
	}
	else if(val!="")
	{
		var gmembers = $(".active-member");
		$(".active-member").hide();
		//$(".member_info_head").hide();
		var	memName,memName_real;
		var memEmail;
		//$(".space_separation").addClass("search_mode");
		var nomember=true;
		for(var i=0;i<gmembers.length;i++) 
		{
			var currentmember =gmembers[i];
			if(gmembers[i].parentElement.id=="empty_member_format")
			{
				continue;
			}
			if(gmembers[i].parentElement.id=="pending_member_space")
			{
				if($(gmembers[i]).hasClass("isExistUser"))
				{
					memName=(currentmember.getElementsByClassName("member_name")[0].innerHTML).toLowerCase();
					memEmail= currentmember.getElementsByClassName("grpemaillink")[0].innerHTML;
				}
				else
				{
					memEmail= currentmember.getElementsByClassName("member_name")[0].innerHTML;
					memName=undefined;
				}
			}
			else
			{
				memName=(currentmember.getElementsByClassName("member_name")[0].innerHTML).toLowerCase();
				memName_real=currentmember.getElementsByClassName("member_name")[0].innerHTML;
				memEmail= currentmember.getElementsByClassName("grpemaillink")[0].innerHTML;
			}
			if(memName != undefined)
			{			
				if(memName.indexOf(val)!=-1)
				{
					nomember=false;
					currentmember.style.display="inline-block";
					var add_span=memName_real.slice(0 , memName.indexOf(val)) + "<span class='clr_blue'>"+memName_real.slice(memName.indexOf(val) , memName.indexOf(val)+val.length)+"</span>" + memName_real.slice(memName.indexOf(val)+val.length + Math.abs(0));
					$(currentmember).find(".member_name").html(add_span);
				}
			}
			if(memEmail)
			{
				if(memEmail.indexOf(val)!=-1)
				{
					nomember=false;
					currentmember.style.display="inline-block";
					var add_span=memEmail.slice(0 , memEmail.indexOf(val)) + "<span class='clr_blue'>"+memEmail.slice(memEmail.indexOf(val) , memEmail.indexOf(val)+val.length)+"</span>" + memEmail.slice(memEmail.indexOf(val)+val.length + Math.abs(0));
					if(gmembers[i].parentElement.id=="pending_member_space"){
						$(currentmember).find(".member_name").html(add_span);
					}
					else{
						$(currentmember).find(".grpemaillink").html(add_span);
					}
				}
			}
		}
		old_val=val;
		$("#accepted_members").show();
		$("#pending_members").show();
		$(".space_separation").show();
		if(nomember)
		{
			$(".noresult").show();
			$(".space_separation").hide();
			$("#pending_members").hide();
		}
		else
		{
			check_showOrhide("accepted_members",1);	//No I18N
			check_showOrhide("pending_members",1);	//No I18N
			check_showOrhide("member_admin_space",2);	//No I18N
			check_showOrhide("member_moderator_space",2);	//No I18N
			check_showOrhide("member_user_space",2);	//No I18N
		}
	}

}

function check_showOrhide(ele,type){
	if(type==1){
		if($("#"+ele+" .active-member").is(":visible"))
		{
			$("#"+ele).show();
		}
		else
		{
			$("#"+ele).hide();
		}
	}
	else{
	
		if($("#"+ele+" .active-member").is(":visible"))
		{
			$("#"+ele).parent().show();
		}
		else
		{
			$("#"+ele).parent().hide();
		}
	}
}

function show_grp_confirm(msg, yesCallback, noCallback)
{
	popup_blurHandler('6');
	$("#grp_info_side").addClass("grp_info_back");
	
	$(".confirm_text").html(msg);
	$("#confirm_popup").show(0,function(){
		$("#confirm_popup").addClass("pop_anim");
	});
	$("#confirm_popup").focus();
   // var dialog = $('#confirm_popup').dialog();
	
    $('#return_true').click(function() {
     //   dialog.dialog('close');
    	$("#confirm_popup").removeClass("pop_anim");
    	$("#confirm_popup").fadeOut(200,function(){
    		$("#grp_info_side").removeClass("grp_info_back");
    	});
	    yesCallback();
	    $('#return_false').unbind();
		$('#return_true').unbind();
    });
    
    $('#return_false').click(function() {
    //    dialog.dialog('close');
    	$("#confirm_popup").removeClass("pop_anim");
    	$("#confirm_popup").fadeOut(200,function(){
    		$("#grp_info_side").removeClass("grp_info_back");
    	});
	 	noCallback();
	 	$('#return_false').unbind();
		$('#return_true').unbind();
		$('.blue').unbind();
    });
    $("#confirm_popup").keydown(function(e) {   
	    if (e.keyCode == 27) {
	    	$('#return_false').click();
	    }
	});

}
//$("document").ready(function(){
//	$("#picsrc_grp").change(function(){		
//				$(".group_info_basic #edit_grp_dp").css("background-image", "url(" + this.result + ")");
//	});
//});

function upload_grp_pic(e)
{
	if(isEmpty(e.value))// the value of the photo deleted
	{
		$("#create_grp_dp .bg_blur_grp").css("background-image","");
		$("#create_grp_dp .profile_picture").attr("src","");
		$("#create_grp_dp .group_dp").removeClass("icon-loading");
		new_group_with_dp=false;
		return false;
	}
	new_group_with_dp=true;
	$("#grp_popup .icon-camera").addClass("icon-loading");
	SuccessMsg(success_newpic_forgrp);
	 var file = e.files[0];
     var reader = new FileReader();
     if (file) 
     {
         reader.readAsDataURL(file);
     } 
     reader.onloadend = function () 
     {
        var bg_image = new Image();
        bg_image.src = reader.result;
        bg_image.onload = function() 
        {
        	var wid = this.width;
        	var height = this.height;  
       		getOrientation(file,function(orientation)
       		{
            	$("#edit_grp_dp .profile_picture").attr("src",reader.result); 
            	$("#edit_grp_dp .bg_blur_grp").css("background-image", "url(" + reader.result + ")");
//            	
            	if (rotation[orientation]) 
            	{
            		$("#edit_grp_dp .profile_picture").css('transform',rotation[orientation]);
                	$("#edit_grp_dp .bg_blur_grp").css('transform',rotation[orientation]);
						
				}
				else
				{
            		$("#edit_grp_dp .profile_picture").css('transform', "rotate(0deg)");//No I18N
                	$("#edit_grp_dp .bg_blur_grp").css('transform', "rotate(0deg)");//No I18N
					
				}
            	$("#grp_popup .icon-camera").removeClass("icon-loading");
       		});
        };
     }
}



function change_grp_pic(e,GID)
{
		var parms=
		{
			"__form":$('#grp_photo_cropform')//No I18N	
		};
		var payload = GroupPhoto.create(parms);
		var slideOrPop = $("#grp_info_side").is(":visible") ? "#grp_info_side" : "#grp_popup";//No I18N	
		$(slideOrPop+" .icon-camera").addClass("icon-loading");
		payload.build();
		payload.POST("self","self",GID).then(function(resp)	//No I18N
		{
			
			var iter=get_groupFrom_GID(GID);
			var needed_grp=groups_data[iter];
			if($("#grp_info_side").is(":visible"))
			{
				setPhotoUrlWithCache($("#grp_info_side"),needed_grp.group_photo_url);
			}
			else if($("#grp_popup").is(":visible"))
			{
				setPhotoUrlWithCache($("#grp_popup"),needed_grp.group_photo_url);
			}
			SuccessMsg(getErrorMessage(resp));
			$(slideOrPop+" .icon-camera").removeClass("icon-loading");
			load_groups();
			close_edit_grp_popup();
		},    
		function(resp)
		{
			$(slideOrPop+" .icon-camera").removeClass("icon-loading");
			showErrorMessage(getErrorMessage(resp));
		});
}

function groupFromInfo(id,e){
	if((!$(e.target).parents().hasClass("tippy-popper"))&& !$(e.target).hasClass("showmenu_div")&& !$(e.target).parents().hasClass("showmenu_div")){
		group_operation("groupinfo",id,e);
	}
}
//function inviteMemResponse(txt) 
//{
//	de('invitegrp').reset(); //No I18N
//    close_edit_grp_popup();
//}

function search_areaHeight(){
	var height=$("#grp_info_side")[0].offsetHeight-($(".group_info_basic")[0].offsetHeight+$("#group_action_div")[0].offsetHeight+$(".group_members_tabs")[0].offsetHeight+ $("#grp_search_space")[0].offsetHeight);
	$(".search_result").height(height);
	return height;
}

function setNoImgClass(ele){
	$(ele).addClass("no-group-photo");
}

function handleGrpPhotoDropDown(groupId){
	if($(".grp_info_side").is(":visible")){
		if($("#"+groupId+" .as_admin").length>0){//check if the current user is an admin or moderator of this account using the star
			if($("#grp_info_side img").hasClass("no-group-photo")){
				openUploadPhoto('group',groupId); //No I18N
			}
			else {
				$("#group_info_div .drop-down-container").show();
			}
		}
		else{
			if(!$("#grp_info_side img").hasClass("no-group-photo")){
				$("#grp_info_side .view-group-photo").click();
			}
		}
	}
	else if($("#grp_popup").is(":visible")){
		if($("#"+groupId+" .as_admin").length>0){//check if the current user is an admin or moderator of this account using the star
			if($("#grp_popup img").hasClass("no-group-photo")){
				openUploadPhoto('group',groupId); //No I18N
			}
			else {
				$(".group_edit_info_basic .drop-down-container").show();
			}
		}
		else{
			if(!$("#grp_popup img").hasClass("no-group-photo")){
				$("#grp_popup .view-group-photo").click();
			}
		}
	}
}

function showGroupImage(ele){
	var imageContainer = ele.parentElement;
	fitPicture(ele);
	imageContainer.querySelector(".photo_loader").classList.add("hide"); //No I18N
	ele.classList.remove("hide"); //No I18N
	imageContainer.querySelector(".photo_blur_dp2").classList.add("hide"); //No I18N
}

function handleGroupPhotoView(imgUrl){
	var imageContainer = document.querySelector(".photo_container"); //No I18N
	var blurImg1 = imageContainer.querySelector(".photo_blur_dp1"); //No I18N
	var blurImg2 = imageContainer.querySelector(".photo_blur_dp2"); //No I18N
	var originalImg = imageContainer.querySelector(".photo_original_dp"); //No I18N
	var imageUrl = imgUrl;
	blurImg1.style.backgroundImage = "url("+imageUrl+")"; //No I18N
	blurImg2.src = imageUrl;
	originalImg.classList.add("hide"); //No I18N
	imageContainer.classList.add("show_photo_container"); //No I18N
	fitPicture(blurImg2);
	imageContainer.querySelector(".photo_loader").classList.remove("hide"); //No I18N
	imageContainer.querySelector(".photo_blur_dp2").classList.remove("hide"); //No I18N
	imageContainer.classList.remove("hide"); //No I18N
	if(imageUrl.indexOf("fs=thumb")!=0){
		imageUrl = imageUrl.replace("fs=thumb","fs=original");
	}
	originalImg.src = imageUrl;
	if(isMobile){
		imageContainer.style.height = imageContainer.clientWidth + "px";
	}
	imageContainer.focus();
	closePopup(closeViewGroupPicture,"photo_container"); //No I18N
	$(".group-back-drop").show();
	$(".group-back-drop").click(function(){
		closeViewGroupPicture();
	});
}

function closeViewGroupPicture(){
	$(".photo_container").removeClass("show_photo_container");
	$(".group-back-drop").hide();
	$(".group-back-drop").unbind();
	if($(".grp_info_side").is(":visible")) {
		$(".grp_info_side").focus();
		closePopup(close_group_info_display_space,"grp_info_side");//No I18N
	}
	else if($("#grp_popup").is(":visible")) {
		$("#grp_popup").focus();
		closePopup(close_edit_grp_popup,"grp_popup");//No I18N
	}
}

function fitPicture(ele){
	$(ele).css("width","auto");
	$(ele).css("height","auto");
	if(ele.width>ele.height)
	{
		$(ele).css("width","100%");
		$(ele).css("height","auto");
	}
	else if(ele.width<ele.height)
	{
		$(ele).css("width","auto");
		$(ele).css("height","100%");
	}
	else
	{
		$(ele).css("width","100%");
		$(ele).css("height","100%");
	}
}

function handleScrollHeight(id){
	var objDiv = document.getElementById(id);
	objDiv.scrollTop = objDiv.scrollHeight;
}

function deleteGroupPhoto(groupId,groupIndex){
	var slideOrPop = $("#grp_info_side").is(":visible") ? "#grp_info_side" : "#grp_popup";//No I18N	
	$(slideOrPop+" .icon-camera").addClass("icon-loading");
	new URI(GroupPhoto,"self","self",groupId).DELETE().then(function(resp) { //No I18N
		setPhotoUrlWithCache($(slideOrPop),groups_data[groupIndex].group_photo_url);
		$(slideOrPop+" .icon-camera").removeClass("icon-loading");
		close_edit_grp_popup(groupId);
		SuccessMsg(getErrorMessage(resp));
		load_groups();
	},
	function(resp){
		$(slideOrPop+" .icon-camera").removeClass("icon-loading");
		showErrorMessage(getErrorMessage(resp));
	}
	);
}

function setPhotoUrlWithCache(element, photoUrl){
	var ct = new Date().getTime();
	element.find(".bg_blur_grp").css("background-image","url('"+photoUrl+"&nocache="+ct+"&t=group')"); //for background blur photo //No I18N 
	element.find(".profile_picture").attr("src",photoUrl+"&nocache="+ct+"&t=group"); //for original photo //No I18N
}

function setPhotoUrl(element, groupId){
	var imgUrl = $("#"+groupId+" .group_dp img").attr("src");
	element.find(".bg_blur_grp").css("background-image","url('"+imgUrl+"')"); //No I18N
	element.find(".profile_picture").attr("src",imgUrl); //No I18N
}
