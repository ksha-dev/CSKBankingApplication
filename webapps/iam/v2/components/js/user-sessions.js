// $Id$ 


function load_Sessionsdetails(Policies,Active_Sessions)
{
	if(de("sessions_exception"))
	{
		$("#sessions_exception").remove();
	}
	if(Active_Sessions.exception_occured!=undefined	&&	Active_Sessions.exception_occured)
	{
		$("#sessions_box .box_info" ).after("<div id='sessions_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#sessions_exception #reload_exception").attr("onclick","reload_exception(ActiveSessions,'sessions_box')");
		return;
	}

	var sessions=timeSorting(Active_Sessions.sessions);
	handleSessionAlerts(Active_Sessions);
	$("#other_sesion").html("");
	var count =0;
	var othersession=0;
	$("#sessions_showall").hide();	
	tooltip_Des(".Field_session .asession_browser");//No I18N
	tooltip_Des(".Field_session .asession_os");	//No I18N
	for(iter=0;iter<Object.keys(sessions).length;iter++)
	{
		count++;
		var current_session=Active_Sessions.sessions[sessions[iter]];
		session_format = $("#empty_sessions_format").html();
		if(current_session.is_current_session)
		{
			$("#current_sesion").html(session_format);
			$("#all_sessions_active #activesession_entry .activesession_entry_info .session_logout").remove();
			$("#all_sessions_active #activesession_info #current_session_logout").remove();
			$("#all_sessions_active #select_session_").remove();
		}
		else
		{
			othersession++;
			$("#other_sesion").append(session_format);
			$("#all_sessions_active #activesession_entry .activesession_entry_info .current").remove();
			$("#all_sessions_active #activesession_info #current_session_logout").attr("onclick","deleteTicket('"+current_session.session_ticket+"');");
			if(othersession > 2)
			{
				$("#other_sesion #activesession_entry").addClass("activesession_entry_hidden tetraSlideExtra");  
			}
			$("#all_sessions_active #select_session_").attr("id","select_session_"+count);
		}
		$("#all_sessions_active #activesession_entry").attr("id","activesession_entry"+count);
		$("#all_sessions_active #activesession_info").attr("id","activesession_info"+count);
		var device_class="device_"+current_session.device_info.device_img;//No I18N
		$("#activesession_entry"+count).attr("onclick","show_all_sessions("+count+");");
		
		addDeviceIcon($("#activesession_entry"+count+" .device_pic"), current_session.device_info);

		$("#activesession_entry"+count+" .device_name").html(current_session.device_info.device_name);
		$("#activesession_entry"+count+" .device_time").html(current_session.created_time_elapsed);
		var os_class=(current_session.device_info.os_img).toLowerCase().replace(/\s/g, '');
		if(de("select_session_"+count))
		{
			$("#select_session_"+count+" .checkbox_check").attr("id",current_session.session_ticket);
		}
		$("#activesession_entry"+count+" .activesession_entry_info .asession_os").addClass("icon-os_"+os_class);
		$("#activesession_entry"+count+" .activesession_entry_info .asession_os").html(fontIconBrowserToHtmlElement[os_class]);
		if(current_session.device_info.version==undefined)
		{
			$("#activesession_entry"+count+" .activesession_entry_info .asession_os").attr("title",current_session.device_info.os_name);
			$("#activesession_info"+count+" #pop_up_os").append("<span>"+current_session.device_info.os_name+"</span>");
		}
		else
		{
			$("#activesession_entry"+count+" .activesession_entry_info .asession_os").attr("title",current_session.device_info.os_name+" "+current_session.device_info.version);
			$("#activesession_info"+count+" #pop_up_os").append("<span>"+current_session.device_info.os_name+" "+current_session.device_info.version+"</span>");

		}
		var browser_class=(current_session.browser_info.browser_image).toLowerCase().replace(/\s/g, '');
		
		$("#activesession_entry"+count+" .activesession_entry_info .asession_browser").addClass("icon-"+browser_class);
		$("#activesession_entry"+count+" .activesession_entry_info .asession_browser").html(fontIconBrowserToHtmlElement[browser_class]);
		if(current_session.ip_address != undefined){
			$("#activesession_entry"+count+" .activesession_entry_info .asession_ip").html(current_session.ip_address);
			$("#activesession_info"+count+" .asession_popup_ip").html(current_session.ip_address);
		}
		else{
			$("#activesession_info"+count+" .asession_popup_ip").parents(".info_div").hide();
		}
		if(current_session.location!=undefined)
		{
			$("#activesession_entry"+count+" .asession_location").removeClass("location_unavail");
			$("#activesession_entry"+count+" .asession_location .location_text").html(current_session.location.toLowerCase());
			$("#activesession_info"+count+" #pop_up_location").removeClass("unavail");
			$("#activesession_info"+count+" #pop_up_location").html(current_session.location.toLowerCase());
		}
		else{
			$("#activesession_entry"+count+" .asession_location .icon-info").hide();
		}
		$("#activesession_info"+count+" #pop_up_time").html(current_session.created_date);
		$("#activesession_info"+count+" #pop_up_os .asession_os_popup").addClass("icon-os_"+os_class);
		$("#activesession_info"+count+" #pop_up_os .asession_os_popup").html(fontIconBrowserToHtmlElement[os_class]);

		$("#activesession_info"+count+" #pop_up_browser .asession_browser_popup").addClass("icon-"+browser_class);
		$("#activesession_info"+count+" #pop_up_browser .asession_browser_popup").html(fontIconBrowserToHtmlElement[browser_class]);
		var browser_name = current_session.browser_info.bversion && current_session.browser_info.bversion != "-1" ?  current_session.browser_info.browser_name+" "+current_session.browser_info.bversion : current_session.browser_info.browser_name;
		$("#activesession_info"+count+" #pop_up_browser").append("<span>"+browser_name+"</span>");
		$("#activesession_entry"+count+" .activesession_entry_info .asession_browser").attr("title",browser_name);
	}
	sessiontipSet(".Field_session .asession_browser");//No I18N
	sessiontipSet(".Field_session .asession_os");//No I18N
	if(count>3)//more THAN 3
	{
		$("#sessions_showall").show();	
		if(count>4)
		{
			$("#sessions_showall").html(formatMessage(i18nSessionkeys["IAM.VIEWMORE.SESSIONS"],count-3)); //NO I18N
		}
		else
		{
			$("#sessions_showall").html(formatMessage(i18nSessionkeys["IAM.VIEWMORE.SESSION"],count-3)); //NO I18N
		}
	}
}

function display_removeselected_session(e) {
	if(e) {
		e.stopPropagation();
	}
	var selected = [];
	$('#other_sesion input:checked').each(function() {
	    selected.push($(this).attr('id'));
	});
	if(selected.length > 0) {
		var allowedCount = 25;
		if(selected.length > allowedCount) {
			$(e.target).prop('checked', false);
			showErrorMessage(formatMessage(i18nSessionkeys["IAM.SESSION.MAX.ALLOWED.SESSION"], allowedCount));
			return false;
		}
		if($("#sideview").hasClass("show_sideview")){
			$("#sideview").bind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd",function(){
				$("#sideview").html("").unbind().hide();
				$(".full_view_more_first").attr("id","").hide();
				$(".full_view_more_second").attr("id","").hide();
				$("#sideview").unbind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd");
			});
			$("#sideview").removeClass("show_sideview");
			$("#user_sessions_footer").slideDown(200);
		}
		$("#selected_session_txt").html(selected.length === 1 ? formatMessage(i18nSessionkeys["IAM.SESSIONS.TERMINATE.ONE.COUNT"]) : formatMessage(i18nSessionkeys["IAM.SESSIONS.TERMINATE.COUNT"],selected.length)); //NO I18N
		$("#user_sessions_footer .session_selected").show();
		$("#deleted_selected_sessions").show();
		if(selected.length >= (allowedCount - 5)) {
			$("#session_allowed_limit").html(formatMessage(i18nSessionkeys["IAM.SESSION.MAX.ALLOWED.SESSION"], allowedCount)); //NO I18N
			$("#session_allowed_limit").show(); 
		} else {
			$("#session_allowed_limit").hide();
		}
		if(isMobile){
			$("#user_sessions_footer .red_btn").hide();
		}
	} else {
		$("#user_sessions_footer .session_selected").hide();
		$("#selected_session_txt").html('');
		$("#deleted_selected_sessions").hide();
		if(isMobile){
			$("#user_sessions_footer .red_btn").show();
		}
	}
	if($("#sessions_sideview").is(":visible")) {
		$("#sessions_sideview").focus();
	}
}


function deleteSelectedSessions()
{
	var selected = [];
	$('#other_sesion input:checked').each(function() {
	    selected.push($(this).attr('id'));
	});
	new URI(ActiveSessionsObj,"self","self",selected).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				for(i=0;i<selected.length;i++)
				{
					delete sessions_data.activesessions.sessions[selected[i]];
				}				
//				$("#deleted_selected_sessions").hide();
				load_Sessionsdetails(sessions_data.Policies,sessions_data.activesessions);
				//closeview_selected_sessions_view();
//				if(($("#sessions_web_more").is(":visible")))
//				{
//					tooltip_Des("#sessions_web_more .Field_session .asession_browser");//No I18N
//					tooltip_Des("#sessions_web_more .Field_session .asession_os");//No I18N
//					removeButtonDisable($("#sessions_web_more .aw_info"));
//					$("#sessions_web_more").hide();
//					$("#view_all_sessions").html("");
//					show_all_sessions();
//				
//				}
				reintSessionFullView();

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

 function closeview_selected_sessions_view() {
	$("#sideview").removeClass("show_sideview");
	setTimeout(function () {
		$("#sideview").hide().html("").removeClass("sessions_sideview");
		if($("#sessions_box .tetraElements").length > 1){
			$("#user_sessions_footer").slideDown();	
		}
		$(".full_view_more_first").attr("id","").hide();
		$(".full_view_more_second").attr("id","").hide();
		$(".full_view_side_info .heading_div").html("");
		$(".full_view_side_info .all_elements_space").html("");
		$(".Field_session").removeClass("selected_device_entry");
		$("#sessions_box").unbind("click").focus();
	}, 300);
 }
 


function commonTetradSlide(classes,footer,closingCallback,slideCallback,id){
	var ele = document.getElementsByClassName(classes)[0].closest(".big_box");
	var position = $(ele)[0].getBoundingClientRect();
	if(!$(".big_box_full_view").is(":visible")){
		var parent = $($("#"+ele.parentElement.id));
		$("#sideview").removeClass("animationClosed");
		$(ele).unbind();
		$("#"+ele.parentElement.id+" .view_more").slideUp(200);
		parent.next().css("margin-top","60px");// no i18n
		parent.find(".tetraSlideExtra").slideDown(200);
		parent.css("height",$(document.getElementsByClassName(classes)[0].closest(".big_box")).height());//no i18n
		$(ele).css({"top": position.top, "left": position.left, "position":"fixed", "width":$("#"+ele.parentElement.id).css("width")});//No I18N
		setTimeout(function ()  {
			$(ele).addClass("transition big_box_full_view");
			if(slideCallback){
				setTimeout(function(){
					if(!$("#sideview").hasClass("animationClosed")){
						slideCallback(id);
					}
				},200);
			}
			if(isMobile	&& screen.width<500) {
				$(ele).css({"top": "48px", "left": "0px","height":"100%", "width":"100%", "z-index": "1","padding-bottom": "110px"});//No I18N	
				if(footer){$("#user_sessions_footer").css({"width":"100%"});}
			} else {
				$(ele).css({"top": "48px", "left": $("#mainmenupanel").css("width"),"height":"100%", "width":'calc( 100% - '+$("#mainmenupanel").css("width")+')', "z-index": "1","padding-bottom": "110px"});//No I18N	
				if(footer){$("#user_sessions_footer").css({"width":'calc( 100% - '+$("#mainmenupanel").css("width")+')'});}
			}
			if($("#"+ele.id +" ."+classes).length > 1 && footer && (id=='' || id==undefined) && !$("#sideview").hasClass("animationClosed") ){
				$("#"+ele.parentElement.id +" .tetraSlideFooter").slideDown();
			}
		},200);
		$("#"+ele.id +" .expand_closebtn").show();
		closePopup(closingCallback,ele.id);
		$(ele).focus();
		$("html").addClass("donnotscroll");
	}
	else{
		if(slideCallback){
			$("#"+ele.parentElement.id +" .tetraSlideFooter").slideUp();
			slideCallback(id);
		}
	}
}


 
function show_all_sessions(id)
{
	if(!$(".big_box_full_view").is(":visible")){
		if($('#other_sesion input:checked').length) {
			$('#other_sesion input:checked').each(function() {
			    $(this).prop('checked', false);
			});
			display_removeselected_session();
		}
		$("#other_sesion .select_holder").removeClass("remove0width").show();
		$("#all_sessions_active .device_div").addClass("slide");
		$("#other_sesion .checkbox").show(200);
	}	
	if(id != undefined && id != ""){
		var slideCallback = function(id){
						var disp_id;
						$("#sideview").addClass("sessions_sideview").html($("#sessions_sideview").html()).show().unbind();
						if($(".full_view_more_first").is(":visible")){
							disp_id=".full_view_more_second";//No I18N
							clear_id=".full_view_more_first";//No I18N
						} else {
							disp_id=".full_view_more_first";//No I18N
							clear_id=".full_view_more_second";//No I18N
						}
			
						if($(clear_id).attr("id")!=undefined	&&	($(clear_id).attr("id")).slice("session_sideview_".length)==id)	 {
							if($("#sideview").is(":visible")){
								closePopup(closeview_selected_sessions_view,"sideview");//no i18n
								$("#sessions_box").click(function(){
									$("#sideview").focus();
								})
							}
							return;
						}
						
						$(disp_id).attr("id","session_sideview_"+id);
						$(".Field_session").removeClass("selected_device_entry");
						$("#activesession_entry"+id).addClass("selected_device_entry");
						$(disp_id+" .heading_div").html($("#activesession_entry"+id+" .device_div").html());
						$(disp_id+" #view_all_info").html($("#activesession_entry"+id+" #activesession_info"+id).html());
						var isCurrent;
						if($("#activesession_info"+id+" #current_session_logout").length!=0){
							$(disp_id+" .menu_header .current_session").hide();
							isCurrent = false;
						} else {
							$(disp_id+" .menu_header .current_session").show();
							isCurrent = true;
						}
						
						if(!$(".full_view_side_info").hasClass("show_sideview")) {
							$(disp_id).show();
							$(".full_view_side_info").addClass("show_sideview");
						} else {	
							previ_id=($(clear_id).attr("id")).slice("session_sideview_".length);//No I18N
							var prevCurrent = $(clear_id).find('.current_session:visible').length;
							if(isCurrent || (previ_id > id && !prevCurrent)) {
								$(disp_id).css("top","-100%");
								$(disp_id).show();
								$(clear_id).animate({'top': '100%'}, 300, function() {
									$(clear_id).hide();
									$(clear_id).css("top","0%");
									$(clear_id+" .heading_div").html("");
									$(clear_id+" .all_elements_space").html("");
							    });
								$(disp_id).animate({'top': '0px'}, 300);
							} else { // slide from bottom
								$(disp_id).css("top","100%");
								$(disp_id).show();
								$(clear_id).animate({'top': '-100%'}, 300, function()  {
									$(clear_id).hide();
									$(clear_id).css("top","0%");
									$(clear_id+" .heading_div").html("");
									$(clear_id+" .all_elements_space").html("");
							    });
								$(disp_id).animate({'top': '0px'}, 300);
							}
							$(clear_id).attr("id","");
						}
						$("#sessions_box").unbind().click(function(){
							$("#sideview").focus();
						});
						closePopup(close_user_sessions_bigview,"sessions_box") // no i18n
						closePopup(closeview_selected_sessions_view,"sideview");//No I18N
						$("#sideview").focus();
						$("#sessions_box").unbind("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd");
					}
			commonTetradSlide("Field_session",true,close_user_sessions_bigview,slideCallback,id);//no i18n
		}
		else{
			commonTetradSlide("Field_session",true,close_user_sessions_bigview);//no i18n
		}
}

function deleteTicket(t) 
{
  //  var url=contextpath+"/u/sessions";//No i18N

//	if($("#sessions_web_more").is(":visible")){
//		disabledButton($("#sessions_web_more .aw_info:visible"));	
//	}
//	else{
		disabledButton($("#view_all_info"));
//	}
	new URI(ActiveSessionsObj,"self","self",t).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete sessions_data.activesessions.sessions[t];
				load_Sessionsdetails(sessions_data.Policies,sessions_data.activesessions);
				closeview_selected_sessions_view();				
//				if(($("#sessions_web_more").is(":visible")))
//				{
//					
//					tooltip_Des("#sessions_web_more .Field_session .asession_browser");//No I18N
//					tooltip_Des("#sessions_web_more .Field_session .asession_os");//No I18N
//					removeButtonDisable($("#sessions_web_more .aw_info"));
//					$("#sessions_web_more").hide();
//					$("#view_all_sessions").html("");
//					show_all_sessions();
//
//				}
//				else{
					removeButtonDisable($("#view_all_info"));
//				}
				reintSessionFullView();
			},
			function(resp)
			{
//				if($("#sessions_web_more").is(":visible")){
//					removeButtonDisable($("#sessions_web_more .aw_info"));	
//				}
//				else{
					removeButtonDisable($("#view_all_info"));
//				}
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

function deleteAllSessions() 
{
	disabledButton("","#delete_all_sessions");
	new URI(ActiveSessionsObj,"self","self").DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var dataKeys = Object.keys(sessions_data.activesessions.sessions);
				for(var a=0; a<dataKeys.length; a++)
				{
					if(!sessions_data.activesessions.sessions[dataKeys[a]].is_current_session)
					{
						delete sessions_data.activesessions.sessions[dataKeys[a]];
					}
				}
				load_Sessionsdetails(sessions_data.Policies,sessions_data.activesessions);
//				closeview_all_sessions_view();
				removeButtonDisable("","#delete_all_sessions");
				close_user_sessions_bigview();
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
				removeButtonDisable("","#delete_all_sessions");
			});
}


function closeview_all_sessions_view()
{
	tooltip_Des("#sessions_web_more .Field_session .asession_browser");//No I18N
	tooltip_Des("#sessions_web_more .Field_session .asession_os");//No I18N
	popupBlurHide("#sessions_web_more",function(){	//No I18N
		$("#view_all_sessions").html("");		
	});
}


function close_user_sessions_bigview() {
		var div = $("#useractivesessions_space~div:first");
		var position = div[0].getBoundingClientRect();
		$("#sideview").addClass("animationClosed");
		$("#user_sessions_footer").hide();
		if(document.querySelectorAll("#other_sesion .activesession_entry_hidden").length >0 ){
			$("#other_sesion .activesession_entry_hidden").slideUp(200,function(){
			$("#useractivesessionstab_space").next().css("margin-top","30px");
			$("#user_sessions_close_megaview").hide();
			$("#sessions_box").css({"top": position.top, "left":position.left, "width":div.css("width")});//No I18N
			setTimeout(function () 
			{
				$("#other_sesion .checkbox").hide();
				$("#other_sesion .select_holder").addClass("remove0width");
				$("#all_sessions_active .device_div").removeClass("slide");
				div.css("height","unset");//no i18n
				$("#sessions_box").removeClass("big_box_full_view").css({"top":"unset", "left":"unset", "width":"auto", "height":"auto","position":"relative","padding-bottom":"30px"});	//No I18N
			}, 200);
			$("html").removeClass("donnotscroll");
			if(Object.keys(sessions_data.activesessions.sessions).length>3)
			{
				$("#sessions_showall").show();
			}
			});
		}
		else{
			$("#user_sessions_close_megaview").hide();
			$("#useractivesessionstab_space").next().css("margin-top","30px");
			$("#sessions_box").css({"top": position.top, "left":position.left, "width": div.css("width")});//No I18N
			setTimeout(function () 
			{
				$("#other_sesion .checkbox").hide();
				$("#other_sesion .select_holder").addClass("remove0width");
				$("#all_sessions_active .device_div").removeClass("slide");
				div.css("height","unset");//no i18n
				$("#sessions_box").removeClass("big_box_full_view");
				$("#sessions_box").css({"top":"unset", "left":"unset", "width":"auto", "height":"auto","position":"relative","padding-bottom":"30px"});	//No I18N
			}, 200);
			$("html").removeClass("donnotscroll");
			if(Object.keys(sessions_data.activesessions.sessions).length>3)
			{
				$("#sessions_showall").show();
			}
		}
}

function reintSessionFullView() {
	if($("#sessions_box").hasClass("big_box_full_view")) {
		if(Object.keys(sessions_data.activesessions.sessions).length === 1){
			close_user_sessions_bigview()
		} else {
			$("#deleted_selected_sessions").hide();
			$("#sessions_showall").hide();
			$("#other_sesion .activesession_entry_hidden").show();
			$("#all_sessions_active .device_div").addClass("slide");
			$("#other_sesion .select_holder").show();
			$("#user_sessions_footer .session_selected").hide();
			$("#selected_session_txt").html('');
			if(isMobile){
				$("#user_sessions_footer .red_btn").show();
			}	
		}
	}
}

function handleSessionAlerts(sessionObj) {
	var init = function(threshold, utilised, isDaylimit) {
		var isError = threshold === utilised;
		var prefix = isDaylimit ? "IAM.SESSION_ALERT.DAILY" : "IAM.SESSION_ALERT.MAX_SESSION"; //No I18n
		prefix += isError ? ".ERROR" : ".WARN"; //No I18n
		var remaining = threshold - utilised;
		var singular = (!isError && remaining === 1) ? '.ONE': ''; //No I18n
		var description =  prefix+".DESCRIPTION"; //No I18n
		$('#ss_alert_heading').html(formatMessage(i18nSessionkeys[prefix+singular+".HEADING"], remaining)); //No I18n
		if(isDaylimit) {
			description += sessionObj.daily_session.is_today? '.TODAY': '.TOMORROW';//No I18n
			if(isError) {
				$('#ss_alert_desc').html(formatMessage(i18nSessionkeys[description], threshold, sessionObj.daily_session.expiry_time)); //No I18n		
			} else {
				$('#ss_alert_desc').html(formatMessage(i18nSessionkeys[description], utilised, threshold, sessionObj.daily_session.expiry_time)); //No I18n	
			}
			$('#ss_alert_learn').html(formatMessage(i18nSessionkeys["IAM.SESSION_ALERT.ACTION.LEARN"])); //No I18n
			$('#ss_alert_learn').attr("onclick",""); //No I18n
			$('#ss_alert_learn').removeClass('viewMoreHide'); //No I18n
			$('#ss_alert_learn').attr("href", sessionObj.daily_session.link); //No I18n
			$('#ss_alert_learn').attr("target", '_blank'); //No I18n
			$('#ss_alert_learn_doc').hide();//No I18n
		} else {
			$('#ss_alert_desc').html(formatMessage(i18nSessionkeys[description], isError ? threshold : utilised, threshold)); //No I18n
			$('#ss_alert_learn').html(formatMessage(i18nSessionkeys["IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.MANAGE.SESSION.ACTION"])); //No I18n
			$('#ss_alert_learn').removeAttr("target"); //No I18n
			$('#ss_alert_learn').attr("onclick","show_all_sessions()"); //No I18n
			$('#ss_alert_learn').addClass('viewMoreHide'); //No I18n
			$('#ss_alert_learn_doc').show();//No I18n
			$('#ss_alert_learn_doc').attr("href", sessionObj.max_session.link); //No I18n
		}
		$('.session-alert').addClass(isError ? 'error': 'warn'); //No I18n
		$('.session-alert').css('display', 'table'); //No I18n
		setTimeout(function() {
			document.getElementById("session_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * (utilised / threshold))+" "+(2 * Math.PI * 40)); //No I18n
		}, 0)
	}
	var sessionCount = Object.keys(sessionObj.sessions).length;
	if (sessionObj && sessionObj.max_session && sessionCount > 1){
		init(sessionObj.max_session.threshold, (sessionCount < sessionObj.max_session.utilised) ? sessionCount : sessionObj.max_session.utilised);
	} else if(sessionObj && sessionObj.daily_session) {
		init(sessionObj.daily_session.threshold, sessionObj.daily_session.utilised, true);
	} else {
		$('.session-alert').hide(); 
		$('#ss_alert_heading').html('');
		$('#ss_alert_desc').html('');
		$('#ss_alert_learn').html('');
		$('#ss_alert_learn_doc').hide();
		$('.session-alert').removeClass('error warn');
	}
} 


/***************************** Active Authtokens *********************************/


function load_Authtokensdetails(Policies,Auth_tokens)
{
	if(de("auth_tokens_exception"))
	{
		$("#auth_tokens_exception").remove();
		$("#authokens_nodata").removeClass("hide");
	}
	if(Auth_tokens.exception_occured!=undefined	&&	Auth_tokens.exception_occured)
	{
		$("#auth_tokens_box .box_info" ).after("<div id='auth_tokens_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#auth_tokens_exception #reload_exception").attr("onclick","reload_exception(ActiveAuthtokens,'auth_tokens_box')");
		$("#authokens_nodata").addClass("hide");
		return;
	}

	if(Auth_tokens!=undefined && !jQuery.isEmptyObject(Auth_tokens))
	{
		$("#authokens_nodata").hide();
		$("#all_set_api_tokens").show();
		
		var tokens=timeSorting(Auth_tokens);
		$("#all_set_api_tokens").html("");
		var count =0;
		for(iter=0;iter<Object.keys(tokens).length;iter++)
		{
			count++;
			var current_apitoken=Auth_tokens[tokens[iter]];
			apitoken_format = $("#empty_apitoken_format").html();
			$("#all_set_api_tokens").append(apitoken_format);
			
			$("#all_set_api_tokens #api_token").attr("id","api_token"+count);
			$("#all_set_api_tokens #select_apitoken_").attr("id","select_apitoken_"+count);
			$("#all_set_api_tokens #apitoken_info").attr("id","apitoken_info"+count);
			if(count > 3)
			{
				$("#api_token"+count).addClass("authweb_entry_hidden");  
			}
			var name;
			if(current_apitoken.authtoken_name.indexOf(" ")!=-1)
			{
				var temp_name=current_apitoken.authtoken_name.split(" ");
				name=(temp_name[0][0]+temp_name[1][0]).toUpperCase();
			}
			else
			{
				name=(current_apitoken.authtoken_name).substring(0,2).toUpperCase();
			}

			if(de("select_apitoken_"+count))
			{
				$("#select_apitoken_"+count+" .checkbox_check").attr("id",tokens[iter]);
			}
			$("#api_token"+count).attr("onclick","show_removeapitoken("+count+");");
			$("#api_token"+count+" .info_tab .email_dp").addClass(color_classes[gen_random_value()]);
		    $("#api_token"+count+" .info_tab .email_dp").html(name);
		    $("#api_token"+count+" .info_tab .authtoken_name").html(current_apitoken.authtoken_name);
		    if(current_apitoken.authtoken_name!=current_apitoken.authtoken_ticket)
		    {
		    	$("#apitoken_info"+count+" #pop_up_name").html(current_apitoken.authtoken_name);
		    }
		    else
		    {
		    	$("#apitoken_info"+count+" #authoken_name").remove();
		    }
		    $("#api_token"+count+" .info_tab .authtoken_time").html(current_apitoken.created_time_elapsed);
		    $("#apitoken_info"+count+" #pop_up_generatedtime").html(current_apitoken.created_time_formated);
		    $("#apitoken_info"+count+" #pop_up_lasttime").html(current_apitoken.last_accesed_time);
		    $("#apitoken_info"+count+" #pop_up_scope").html(current_apitoken.authtoken_scope);
		    $("#apitoken_info"+count+" #token_view").attr("id","token_view_"+count);
		    $("#apitoken_info"+count+" #token_hide").attr("id","token_hide_"+count);
		    $("#apitoken_info"+count+" #token_hide_"+count+" .blue").attr("onclick","token_hide('"+count+"')"); 
		    $("#apitoken_info"+count+" #token_view_"+count+" .blue").attr("onclick","show_token_full('"+count+"','"+tokens[iter]+"')"); 
		    $("#apitoken_info"+count+" #pop_up_ticket").html(current_apitoken.authtoken_ticket);

		    if(current_apitoken.location!=undefined)
			{
				$("#api_token"+count+" .asession_location").removeClass("location_unavail");
				$("#api_token"+count+" .asession_location").html(current_apitoken.location.toLowerCase());
				$("#apitoken_info"+count+" #pop_up_location").removeClass("unavail");
				$("#apitoken_info"+count+" #pop_up_location").html(current_apitoken.location.toLowerCase());
			}
		    
		    if(current_apitoken.last_accessed_ip!=undefined && (current_apitoken.last_accessed_device!=undefined && current_apitoken.last_accessed_device!=""))
		    {
		    	$("#apitoken_info"+count+" #pop_up_lastIP").html(current_apitoken.last_accessed_ip);
		    	$("#apitoken_info"+count+" #pop_up_last_device").html(current_apitoken.last_accessed_device);
		    }
		    else
		    {
		    	$("#apitoken_info"+count+" .usage_exist").hide();
		    }
		    $("#apitoken_info"+count+" #authoken_remove").attr("onclick","deleteToken('"+tokens[iter]+"');");


		}
		if(count>3)
		{
			$("#api_token_viewall").show();
		}
	}
	else
	{
		$("#authokens_nodata").show();
		$("#all_set_api_tokens").hide();
		$("#api_token_viewall").hide();
	}
}

function display_removeselected_apitokens()
{
	var selected = [];
	$('#view_api_tokens_remove input:checked').each(function() {
	    selected.push($(this).attr('id'));
	});
	if(selected.length > 0)
	{
		$("#deleted_selected_apitokens").show();
		if(isMobile){
			$(".delete_all_space .red_btn").hide();
		}
	}
	else
	{
		$("#deleted_selected_apitokens").hide();
		if(isMobile){
			$(".delete_all_space .red_btn").show();
		}
	}
}

function deleteAlltokens() 
{
	new URI(ActiveAuthtokensObj,"self","self").DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				var dataKeys = Object.keys(sessions_data.authtokens);
				for(var a=0; a<dataKeys.length; a++)
				{
					delete sessions_data.authtokens[dataKeys[a]];
				}
				load_Authtokensdetails(sessions_data.Policies,sessions_data.authtokens);
				closeview_all_apitokens_acc();
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

function deleteSelectedAuthtokens()
{
	var selected = [];
	$('#view_api_tokens_remove input:checked').each(function() {
	    selected.push($(this).attr('id'));
	});
	
	new URI(ActiveAuthtokensObj,"self","self",selected).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				for(i=0;i<selected.length;i++)
				{
					delete sessions_data.authtokens[selected[i]];
				}				
				load_Authtokensdetails(sessions_data.Policies,sessions_data.authtokens);
				close_apitoken_screen();
				$("#deleted_selected_apitokens").hide();
				if(($("#api_tokens_more").is(":visible")))
				{
					var lenn=Object.keys(sessions_data.authtokens).length;
					if(lenn>0)
					{
						show_all_apitokens();
					}
					else
					{
						closeview_all_apitokens_acc();
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

function close_apitoken_screen()
{
	popupBlurHide("#popup_active-authtokens_contents",function(){		//No I18N
		$("#apitoken_popup_head").html(""); 
		$("#apitoken_popup_info").html(""); 
	});

	
}


function show_token_full(count,token)
{
	new URI(ActiveAuthtokensObj,"self","self",token).GET().then(function(resp)	//No I18N
			{
				if($("#api_tokens_more").is(":visible")){
					$("#api_tokens_more #token_view_"+count).hide();
					$("#api_tokens_more #token_hide_"+count+" #pop_up_clear_ticket").html(resp.clear_token);
					$("#api_tokens_more #token_hide_"+count).css("display","inline-block");
				}
				else{
					$("#popup_active-authtokens_contents #token_view_"+count).hide();
					$("#popup_active-authtokens_contents #token_hide_"+count+" #pop_up_clear_ticket").html(resp.clear_token);
					$("#popup_active-authtokens_contents #token_hide_"+count).css("display","inline-block");
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

function token_hide(count)
{
	if($("#api_tokens_more").is(":visible")){
		$("#api_tokens_more #token_view_"+count).show();
		$("#api_tokens_more #token_hide_"+count).hide();
		$("#api_tokens_more #token_hide_"+count+" #pop_up_clear_ticket").html("");
	}
	else{
		$("#popup_active-authtokens_contents #token_view_"+count).show();
		$("#popup_active-authtokens_contents #token_hide_"+count).hide();
		$("#popup_active-authtokens_contents #token_hide_"+count+" #pop_up_clear_ticket").html("");
	}
	
}

function show_removeapitoken(id)
{
	
	$("#popup_active-authtokens_contents #apitoken_popup_head").html($("#api_token"+id+" .authtoken_div").html()); //load into popuop
	$("#popup_active-authtokens_contents #apitoken_popup_info").html($("#apitoken_info"+id).html()); //load into popuop
	popup_blurHandler('6');

	$("#popup_active-authtokens_contents").show(0,function(){
		$("#popup_active-authtokens_contents").addClass("pop_anim");
	});
	closePopup(close_apitoken_screen,"popup_active-authtokens_contents");//No I18N
	$("#popup_active-authtokens_contents #authoken_remove").focus();
}

function deleteToken(token) 
{    
	if($("#api_tokens_more").is(":visible")){
		disabledButton($("#api_tokens_more .aw_info:visible"));	
	}
	else{
		disabledButton($("#apitoken_popup_info"));
	}
	new URI(ActiveAuthtokensObj,"self","self",token).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				delete sessions_data.authtokens[token];
				load_Authtokensdetails(sessions_data.Policies,sessions_data.authtokens);
				close_apitoken_screen();
				if($("#api_tokens_more").is(":visible"))
				{
					var lenn=Object.keys(sessions_data.authtokens).length;
					if(lenn>0){
						$("#api_tokens_more").hide();
						$("#view_api_tokens_remove").html("");
						$("#api_tokens_more .select_holder").hide();
						show_all_apitokens();
					}
					else{
						$(".blur").css({"z-index":"6","opacity":".5"});
						closeview_all_apitokens_acc();
					}
					removeButtonDisable($("#api_tokens_more .aw_info"));
				}
				else{
					removeButtonDisable($("#apitoken_popup_info"));	
				}

			},
			function(resp)
			{
				if($("#api_tokens_more").is(":visible"))
				{
					removeButtonDisable($("#api_tokens_more .aw_info"));
				}
				else{
					removeButtonDisable($("#apitoken_popup_info"));
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
    
}


function closeview_all_apitokens_acc()
{
	$(".blur").css("opacity","0");
	popupBlurHide("#api_tokens_more",function(){ //No I18N 
		$("#view_api_tokens_remove").html("");
		$("#api_tokens_more .select_holder").hide();
	});
}

function show_all_apitokens()
{
	$("#view_api_tokens_remove").html($("#all_set_api_tokens").html()); //load into popuop

	
	popup_blurHandler('6');
	
	$("#view_api_tokens_remove .authweb_entry_hidden").show();
	//$("#view_api_tokens_remove .Field_session").after( "<br />" );
	$("#view_api_tokens_remove .Field_session").removeAttr("onclick");
	
	
	
	$("#api_tokens_more").show(0,function(){
		$("#api_tokens_more").addClass("pop_anim");
	});
	
	
	
	$("#view_api_tokens_remove .Field_session").click(function(event){
		if($(event.target).parents().hasClass("select_holder")){
			return;
		}
		if($(event.target).parents().hasClass("authtoken_container")||$(event.target).hasClass("authtoken_container")){	
			return;
		}
		var id=$(this).attr('id');
		$("#view_api_tokens_remove .Field_session").addClass("autoheight");
		$("#view_api_tokens_remove .aw_info").slideUp("fast");
		$("#view_api_tokens_remove .activesession_entry_info").show();
		if($("#view_api_tokens_remove #"+id).hasClass("web_email_specific_popup"))
		{
			$(".aw info a").unbind();
			$("#view_api_tokens_remove #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_api_tokens_remove #"+id).removeClass("web_email_specific_popup");
				$("#view_api_tokens_remove .Field_session").removeClass("autoheight");
			});
		}
		else
		{
			$("#view_api_tokens_remove .Field_session").removeClass("web_email_specific_popup");		
			$("#view_api_tokens_remove #"+id).addClass("web_email_specific_popup");
			$("#view_api_tokens_remove #"+id+" .activesession_entry_info").hide();	
			$("#view_api_tokens_remove #"+id+" .aw_info .hide").hide();	
			$("#view_api_tokens_remove #"+id+" .aw_info").slideDown("fast",function(){
				control_Enter(".aw_info a") //No I18N
				$("#view_api_tokens_remove .Field_session").removeClass("autoheight");
			});
			
		
		}
		
		
	});
	$("#api_tokens_more .select_holder").show();
	closePopup(closeview_all_apitokens_acc,"api_tokens_more");//No I18N
	
	$("#api_tokens_more").focus();
	
	
}



/***************************** Active HISTORY *********************************/

function load_History()
{
	if(de("history_exception"))
	{
		$("#history_exception").remove();
		$("#history_screen").removeClass("hide");
	}
	if(history_data.exception_occured!=undefined	&&	history_data.exception_occured)
	{
		$("#history_box .box_info" ).after("<div id='history_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#history_exception #reload_exception").attr("onclick","show_history()");
		$("#history_screen").addClass("hide");
		return;
	}

	if(history_data!=undefined && !jQuery.isEmptyObject(history_data))
	{
		$("#history_screen").hide();
		$("#history_space").show();
		var history=timeSorting(history_data, true);
		$("#history_space").html("");
		var count =0;
		for(iter=0;iter<Object.keys(history).length;iter++)
		{
			count++;
			var current_history=history_data[history[iter]];
			apitoken_format = $("#empty_histroy_format").html();
			$("#history_space").append(apitoken_format);
			$("#history_space #activehistory_entry").attr("id","activehistory_entry"+count);
			$("#history_space #activehistory_info").attr("id","activehistory_info"+count);
			if(count > 3)
			{
				$("#activehistory_entry"+count).addClass("activesession_entry_hidden");  
			}
			$("#activehistory_entry"+count).attr("onclick","show_selected_history("+count+");");
			$("#activehistory_entry"+count+" .history_div i[class^='product-icon'],#activehistory_entry"+count+" .history_div i[class*=' product-icon']").addClass("product-icon-"+current_history.service_name.toLowerCase().replace(/\s/g, ''));
			$("#activehistory_entry"+count+" .history_div .authtoken_name").html(current_history.service_name);
			$("#activehistory_entry"+count+" .history_div .authtoken_time").html(current_history.created_time_elapsed);
			var device_class="device_"+(current_history.device_info.device_img).toLowerCase().replace(/\s/g, '');//No I18N
			addDeviceIcon($("#activehistory_entry"+count+" .activesession_entry_info .history_device"),current_history.device_info);
			$("#activehistory_entry"+count+" .activesession_entry_info .history_device").attr("title",current_history.device_info.device_name);
			var os_class=(current_history.device_info.os_img);
			$("#activehistory_entry"+count+" .activesession_entry_info .asession_os").addClass("icon-os_"+os_class);
			$("#activehistory_entry"+count+" .activesession_entry_info .asession_os").html(fontIconBrowserToHtmlElement[os_class]);
			if(current_history.device_info.version==undefined){
				$("#activehistory_entry"+count+" .activesession_entry_info .asession_os").attr("title",current_history.device_info.os_name);
				$("#activehistory_info"+count+" #pop_up_os").append(current_history.device_info.os_name);

			}
			else{
				$("#activehistory_entry"+count+" .activesession_entry_info .asession_os").attr("title",current_history.device_info.os_name+" "+current_history.device_info.version);
				$("#activehistory_info"+count+" #pop_up_os").append(current_history.device_info.os_name+" "+current_history.device_info.version);
			}
			var browser_class=(current_history.browser_info.browser_image).toLowerCase().replace(/\s/g, '');

			$("#activehistory_entry"+count+" .activesession_entry_info .asession_browser").addClass("icon-"+browser_class);
			$("#activehistory_entry"+count+" .activesession_entry_info .asession_browser").html(fontIconBrowserToHtmlElement[browser_class]);
			if(current_history.ip_address != undefined){
				$("#activehistory_entry"+count+" #pop_ip").html(current_history.ip_address);
			}
			else{
				$("#activehistory_entry"+count+" #pop_ip").parents(".info_div").hide();
			}
			if(current_history.location!=undefined)
			{
				$("#activehistory_entry"+count+" .asession_location").removeClass("location_unavail");
				$("#activehistory_entry"+count+" .asession_location .location_text").html(current_history.location.toLowerCase());
				$("#activehistory_entry"+count+" #pop_up_location").removeClass("unavail");
				$("#activehistory_entry"+count+" #pop_up_location").html(current_history.location.toLowerCase());
			}
			else{
				$("#activehistory_entry"+count+" .asession_location .icon-info").hide();
			}
			$("#activehistory_info"+count+" #pop_up_time").html(current_history.created_time_formated);
			if(current_history.logout_date!=undefined)
			{
				$("#activehistory_info"+count+" #pop_up_logout_time").html(current_history.logout_date);
			}
			else
			{
				$("#activehistory_info"+count+" #history_logout_time").remove();
			}
			$("#activehistory_info"+count+" #pop_up_os .asession_os_popup").addClass("icon-os_"+os_class);
			$("#activehistory_info"+count+" #pop_up_os .asession_os_popup").html(fontIconBrowserToHtmlElement[os_class]);
			
			var browser_name = current_history.browser_info.bversion && current_history.browser_info.bversion != "-1" ? current_history.browser_info.browser_name + " " + current_history.browser_info.bversion : current_history.browser_info.browser_name;
			$("#activehistory_entry"+count+" .activesession_entry_info .asession_browser").attr("title",browser_name);
			$("#activehistory_info"+count+" #pop_up_browser").append(browser_name);				
			$("#activehistory_info"+count+" #pop_up_browser .asession_browser_popup").addClass("icon-"+browser_class);
			$("#activehistory_info"+count+" #pop_up_browser .asession_browser_popup").html(fontIconBrowserToHtmlElement[browser_class]);
			$("#activehistory_info"+count+" #pop_refer").html(current_history.referrer);
			addDeviceIcon($("#activehistory_info"+count+" #pop_up_device .asession_device_popup"),current_history.device_info);
			$("#activehistory_info"+count+" #pop_up_device").append(current_history.device_info.device_name);
			
		}
		sessiontipSet("#history_space .Field_session .history_device");//No I18N
		sessiontipSet("#history_space .Field_session .asession_browser");//No I18N
		sessiontipSet("#history_space .Field_session .asession_os");//No I18N
		if(count>3)
		{
			$("#history_showall").show();
		}
	}
	else
	{
		$("#history_screen").show();
		if(jQuery.isEmptyObject(history_data))	//if the data is empty
		{
			$("#history_screen .primary_btn_check").hide();
			$("#history_screen #history_unavaiable").show();
		}
		$("#history_space").hide();
		$("#history_showall").hide();
	}
}

function show_selected_history(id)
{

		$("#popup_active-history_contents #history_popup_head").html($("#activehistory_entry"+id+" .history_div").html()); //load into popuop
		$("#popup_active-history_contents #history_popup_info").html($("#activehistory_info"+id).html()); //load into popuop
		
		popup_blurHandler('6');
		$("#popup_active-history_contents").show(0,function(){
			$("#popup_active-history_contents").addClass("pop_anim");
		});
		
		closePopup(close_selected_history_screen,"popup_active-history_contents");//No I18N
		$("#popup_active-history_contents").focus();
}



function show_history()
{
	$("#history_box .box_blur").show();
	$("#history_box .loader").show();

	
	
	new URI(User,"self","self").include(LoginHistory).GET().then(function(resp)	//No I18N
			{
				history_data=resp.User.LoginHistory;
				load_History();
				$("#history_box .box_blur").hide();
				$("#history_box .loader").hide();
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
				$("#history_box .box_blur").hide();
				$("#history_box .loader").hide();
			});


}


function close_selected_history_screen()
{		
	popupBlurHide("#popup_active-history_contents",function(){	//No I18N
			$("#history_popup_head").html(""); 
			$("#history_popup_info").html(""); 
	});
}


function closeview_all_activeHistoy_acc()
{
	tooltip_Des("#history_web_more .Field_session .history_device");//No I18N
	tooltip_Des("#history_web_more .Field_session .asession_browser");//No I18N
	tooltip_Des("#history_web_more .Field_session .asession_os");//No I18N

	popupBlurHide("#history_web_more",function(){	//No I18N
		$("#view_all_activeHistory").html("");
	});
}

function show_all_activehistory()
{	
	tooltip_Des(".Field_session .history_device");//No I18N
	tooltip_Des(".Field_session .asession_browser");//No I18N
	tooltip_Des(".Field_session .asession_os");//No I18N
	$("#view_all_activeHistory").html($("#history_space").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_activeHistory .activesession_entry_hidden").show();
	//$("#view_all_activeHistory .Field_session").after( "<br />" );
	$("#view_all_activeHistory .Field_session").removeAttr("onclick");
	
	
	
	$("#history_web_more").show(0,function(){
		$("#history_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_activeHistory .Field_session").click(function(){
	
		var id=$(this).attr('id');
		$("#view_all_activeHistory .Field_session").addClass("autoheight");
		$("#view_all_activeHistory .aw_info").slideUp("fast");
		$("#view_all_activeHistory .activesession_entry_info").show();
		if($("#view_all_activeHistory #"+id).hasClass("web_email_specific_popup"))
		{
			$("#view_all_activeHistory #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_all_activeHistory #"+id).removeClass("web_email_specific_popup");
				$("#view_all_activeHistory .Field_session").removeClass("autoheight");
			});
			$("#view_all_activeHistory .activesession_entry_info").show();
		}
		else
		{
			$("#view_all_activeHistory .Field_session").removeClass("web_email_specific_popup");
			$("#view_all_activeHistory #"+id).addClass("web_email_specific_popup");
			$("#view_all_activeHistory #"+id+" .aw_info").slideDown("fast",function(){
				$("#view_all_activeHistory .Field_session").removeClass("autoheight");
			});
			$("#view_all_activeHistory #"+id+" .activesession_entry_info").hide();
		}
	});
	
	sessiontipSet(".Field_session .history_device");//No I18N
	sessiontipSet(".Field_session .asession_browser");//No I18N
	sessiontipSet(".Field_session .asession_os");//No I18N
	closePopup(closeview_all_activeHistoy_acc,"history_web_more");//No I18N
	$("#history_web_more").focus();
	
}


/***************************** Connected Apps *********************************/

function load_connected_apps_details(Policies,connected_apps_details)
{
	if(jQuery.isEmptyObject(connected_apps_details))
	{
		$("#no_connected_apps").show();
		$("#display_connected_apps").hide();
		return;
	}
	if(de("Connected_apps_exception"))
	{
		$("#Connected_apps_exception").remove();
	}
	if(connected_apps_details.exception_occured!=undefined	&&	connected_apps_details.exception_occured)
	{
		$("#Connected_apps_box .box_info" ).after("<div id='Connected_apps_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#Connected_apps_exception #reload_exception").attr("onclick","reload_exception(Connected_apps,'Connected_apps_box')");
		return;
	}

	$("#no_connected_apps").hide();
	$("#display_connected_apps").show();
	$("#display_connected_apps").html("");
	var count=0;
	var apps=timeSorting(connected_apps_details);
	for(iter=0;iter<apps.length;iter++)
	{
		count++;
		var current_app=connected_apps_details[apps[iter]];
		
		connected_apps_format = $("#empty_connected_apps_format").html();
		$("#display_connected_apps").append(connected_apps_format);
		
		$("#display_connected_apps #connected_apps_entry").attr("id","connected_apps_entry"+count);
		$("#display_connected_apps #connected_apps_info").attr("id","connected_apps_info"+count);
		
		
		$("#connected_apps_entry"+count).attr("onclick","show_selected_connected_apps_info("+count+");");
		
		if(count > 3)
		{
			$("#connected_apps_entry"+count).addClass("allowed_ip_entry_hidden");  
		}
		
		$("#connected_apps_entry"+count+" .device_name").html(current_app.client_name);
		$("#connected_apps_entry"+count+" .device_time").html(current_app.created_time_elapsed);
		$("#connected_apps_entry"+count+" .device_pic").addClass(color_classes[gen_random_value()]);
		if(current_app.client_name.indexOf(" ")==-1)
		{
			$("#connected_apps_entry"+count+" .device_pic").html(current_app.client_name.substr(0,2).toUpperCase());
		}
		else
		{
			var name=current_app.client_name.split(" ");
			$("#connected_apps_entry"+count+" .device_pic").html((name[0][0]+name[1][0]).toUpperCase());
		}
		if(current_app.primary_dc){
			$("#connected_apps_entry"+count+" .asession_location .DC_detail").html(current_app.primary_dc.toLowerCase());
			$("#connected_apps_info"+count+" #pop_up_app_DC .DC_text").html(current_app.primary_dc.toLowerCase());
			var hoverFuncWithArg = formatMessage($("#connected_apps_entry"+count+" .asession_location .icon-info").attr("onmouseover"),current_app.client_name,current_app.primary_dc,accountCurrentDC);
			$("#connected_apps_entry"+count+" .asession_location .icon-info,#connected_apps_info"+count+" #pop_up_app_DC .icon-info").attr("onmouseover",hoverFuncWithArg);
			$("#connected_apps_entry"+count+" .asession_location,#connected_apps_info"+count+" #pop_up_app_DC").addClass("diff_DC");
		}
		else{
			if(!isEmpty(accountCurrentDC)){
				$("#connected_apps_entry"+count+" .asession_location .DC_detail").html(accountCurrentDC.toLowerCase());
				$("#connected_apps_info"+count+" #pop_up_app_DC .DC_text").html(accountCurrentDC.toLowerCase());
				$("#connected_apps_entry"+count+" .icon-info,#connected_apps_info"+count+" .icon-info").remove();
			}
			else{
				$("#connected_apps_entry"+count+" .asession_location").hide();
				$("#connected_apps_info"+count+" #pop_up_app_DC").parents(".info_div").hide();
			}
		}
		
		if(current_app.location!=undefined)
		{
			$("#connected_apps_entry"+count+" .asession_location").removeClass("location_unavail");
			$("#connected_apps_entry"+count+" .asession_location .location_text").html(current_app.location.toLowerCase());
			$("#connected_apps_info"+count+" #pop_up_location").removeClass("unavail");
			$("#connected_apps_info"+count+" #pop_up_location").html(current_app.location.toLowerCase());
		}
		$("#connected_apps_info"+count+" #pop_up_time").html(current_app.created_date);
		$("#connected_apps_info"+count+" #pop_up_ip").html(current_app.ip_address);
		
		$("#connected_apps_entry"+count+" .connected_app_delete,#connected_apps_info"+count+" #delete_current_app").attr("onclick","confirmToRevoke(event,"+count+",'"+current_app.client_zid+"');");
	}
	if(count>3)
	{
		$("#connected_apps_view").show();
		if(count>4)
		{
			$("#connected_apps_view").html(formatMessage(i18nConnectedAppskeys["IAM.VIEWMORE.APPLICATIONS"],count-3)); //NO I18N
		}
		else
		{
			$("#connected_apps_view").html(formatMessage(i18nConnectedAppskeys["IAM.VIEWMORE.APPLICATION"],count-3)); //NO I18N
		}
	}
	else{
		$("#connected_apps_view").hide();
	}

}


function confirmToRevoke(e,iter_count,client_zid){
	if($(e.target).parents("#view_all_connected_apps").length != 0){
		$("#connected_apps_entry"+iter_count+" .deleteConfirmFromViewAll").hide();
		$("#connected_apps_entry"+iter_count+" #delete_connected_app").attr("onclick","deleteApp(event,'"+client_zid+"',"+iter_count+")");
		$("#connected_apps_entry"+iter_count+" #cancel_action").attr("onclick","closeRevokeConfirm(event,"+iter_count+")");
		if($(e.target).parents(".aw_info").length != 0){
			$("#connected_apps_entry"+iter_count+" .app_details").slideUp(300);				
			$("#connected_apps_entry"+iter_count+" .deleteConfirmFromViewAll").delay(300).slideDown(300,function(){				
				$("#connected_apps_entry"+iter_count+" #delete_connected_app").focus();
			});
			e.stopPropagation();
		}
		else{
			$("#connected_apps_entry"+iter_count+" .app_details").hide();
			$("#connected_apps_entry"+iter_count+" .deleteConfirmFromViewAll").show();
			$("#connected_apps_entry"+iter_count+" #delete_connected_app").focus();
		}
		return false;
	}
	if(!$("#Connected_apps_pop").is(":visible")){show_selected_connected_apps_info(iter_count)};
	$("#Connected_apps_pop .deleteConfirmFromViewAll").show();
	$("#Connected_apps_pop .app_details").hide();
	$("#Connected_apps_pop .deleteConfirmFromViewAll #delete_connected_app").attr("onclick","deleteApp(event,'"+client_zid+"',"+iter_count+")");
	$("#Connected_apps_pop .deleteConfirmFromViewAll #cancel_action").attr("onclick","closeRevokeConfirm(event,"+iter_count+")");
	$("#Connected_apps_pop").click().focus();
	e.stopPropagation();
}

function closeRevokeConfirm(e,iter)
{
	if($("#Connected_apps_pop").is(":visible")){
		closeview_selected_connected_apps_view();
	}
	else{
		$("#view_all_connected_apps #connected_apps_entry"+iter+" .aw_info").slideUp("fast",function(){
			$("#view_all_connected_apps #connected_apps_entry"+iter).removeClass("Active_ip_showall_hover");
			$("#view_all_connected_apps .Field_session").removeClass("autoheight");
		});
		$("#view_all_connected_apps .activesession_entry_info").show();
		$("#connected_apps_web_more").focus();
	}
	e.stopPropagation();
}


function deleteApp(e,client_zid,index)
{
	e.stopPropagation();
	new URI(ConnectedAppsOBJ,"self","self",client_zid).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				for ( i=0; i < sessions_data.connectedapps.length; i++) //due to sorting we need to find the new index.
				{
				   if ( sessions_data.connectedapps[i].client_zid== client_zid) 
				   {
					   index=i;
				   }
				}
				delete sessions_data.connectedapps[index];
				
				load_connected_apps_details(sessions_data.Policies,sessions_data.connectedapps);	
				
				
				closeview_selected_connected_apps_view();
				if($("#connected_apps_web_more").is(":visible")==true)
				{
					var lenn=Object.keys(sessions_data.connectedapps).length;
					if(lenn > 1)
					{
						$("#view_all_connected_apps").html("");
						show_all_connnected_apps();
					}
					else{
						closeview_connected_apps_view();
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


function show_selected_connected_apps_info(id)
{
	$("#Connected_apps_pop .device_pic").addClass($("#connected_apps_entry"+id+" .device_pic")[0].className);
	$("#Connected_apps_pop .device_pic").html($("#connected_apps_entry"+id+" .device_pic").html());
	$("#Connected_apps_pop .device_name").html($("#connected_apps_entry"+id+" .device_name").html()); //load into popuop
	$("#Connected_apps_pop .device_time").html($("#connected_apps_entry"+id+" .device_time").html()); //load into popuop
	
	$("#Connected_apps_pop #connected_app_current_info").html($("#connected_apps_info"+id).html()); //load into popuop
	$("#Connected_apps_pop .deleteConfirmFromViewAll").hide();
	$("#Connected_apps_pop .app_details").show();
	
	
	
	
	popup_blurHandler('6');
	$("#Connected_apps_pop").show(0,function(){
		$("#Connected_apps_pop").addClass("pop_anim");
	});
	$("#delete_current_app").focus();
	closePopup(closeview_selected_connected_apps_view,"Connected_apps_pop"); //No I18N
}


function closeview_selected_connected_apps_view()
{
	popupBlurHide("#Connected_apps_pop");	//No I18N
}



function show_all_connnected_apps()
{
	$("#view_all_connected_apps").html($("#display_connected_apps").html()); //load into popuop
	///$("#view_all_connected_apps .connected_app_delete").attr("onclick","");
	popup_blurHandler('6');
	
	$("#view_all_connected_apps .allowed_ip_entry_hidden").show();
	//$("#view_all_app_pass .authweb_entry").after( "<br />" );
	//$("#view_all_app_pass .authweb_entry").addClass("viewall_authwebentry");
	$("#view_all_connected_apps .Field_session").removeAttr("onclick");
	$("#view_all_connected_apps .info_tab").show();

//	$("#view_all_allow_ip .asession_action").hide();

	//$("#view_all_allow_ip .asession_action").hide();

	
	$("#connected_apps_web_more").show(0,function(){
		$("#connected_apps_web_more").addClass("pop_anim");
	});
	
	
	
	$("#view_all_connected_apps .Field_session").click(function(event){
		if($(event.target).parents().hasClass("select_holder")){
			return;
		}

		var id=$(this).attr('id');
		$("#view_all_connected_apps .Field_session").addClass("autoheight");
		$("#view_all_connected_apps .aw_info").slideUp(300);
		$("#view_all_connected_apps .activesession_entry_info").show();
		if($("#view_all_connected_apps #"+id).hasClass("Active_ip_showall_hover"))
		{
	
			$("#view_all_connected_apps #"+id+" .aw_info").slideUp("fast",function(){
				$("#view_all_connected_apps #"+id).removeClass("Active_ip_showall_hover");
				$("#view_all_connected_apps .Field_session").removeClass("autoheight");
				$(".deleteConfirmFromViewAll").hide();
			});
			$("#view_all_connected_apps .activesession_entry_info").show();
		}
		else
		{
			$("#view_all_connected_apps .Field_session").removeClass("Active_ip_showall_hover");
			$("#view_all_connected_apps .Field_session").removeClass("Active_ip_showcurrent");
			$("#view_all_connected_apps #"+id).addClass("Active_ip_showall_hover");
			if($(event.target).hasClass("connected_app_delete")){
				$("#view_all_connected_apps #"+id+" .app_details").hide();
				$("#view_all_connected_apps #"+id+" .deleteConfirmFromViewAll").show();
			}
			else{
				$("#view_all_connected_apps #"+id+" .app_details").show();
				$("#view_all_connected_apps #"+id+" .deleteConfirmFromViewAll").hide();
			}
			$("#view_all_connected_apps #"+id+" .aw_info").slideDown(300,function(){
				$("#view_all_connected_apps .Field_session").removeClass("autoheight");
			});
			$("#view_all_connected_apps #"+id+" .activesession_entry_info").hide();
	//		$("#view_all_allow_ip #"+id+" .primary_btn_check").focus();
		}
		
	});
	$("#connected_apps_web_more .select_holder").show();
	control_Enter("a");//No I18N
	closePopup(closeview_connected_apps_view,"connected_apps_web_more");//No I18N
	
	$("#connected_apps_web_more").focus();
}


function closeview_connected_apps_view()
{
	$(".aw_info a").unbind();	
	popupBlurHide("#connected_apps_web_more",function(){	//No I18N
		$("#connected_apps_web_more .select_holder").hide();
		$("#view_all_connected_apps").html("");
	});
}





/***************************** APP LOGINS *********************************/

function load_App_Logins_details(Policies,App_logins_details)
{
	if(de("App_logins_exception"))
	{
		$("#App_logins_exception").remove();
	}
	if(App_logins_details.exception_occured!=undefined	&&	App_logins_details.exception_occured)
	{
		$("#App_logins_box .box_info" ).after("<div id='App_logins_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#App_logins_exception #reload_exception").attr("onclick","reload_exception(App_logins,'App_logins_box')");
		return;
	}
	if(jQuery.isEmptyObject(App_logins_details))
	{
		$("#no_App_logins").show();
		$("#display_App_logins").hide();
	}
	else
	{
		$("#no_App_logins").hide();
		$("#display_App_logins").show();
		$("#display_App_logins").html("");
		var count=0;
		var product=Object.keys(App_logins_details);
		for(iter=0;iter<product.length;iter++)
		{
			count++;
			var current_app=App_logins_details[product[iter]];
			
			App_logins_format = $("#empty_App_logins_format").html();
			
			$("#display_App_logins").append(App_logins_format);
			
			$("#display_App_logins #App_logins_entry").attr("id","App_logins_entry"+count);
			$("#display_App_logins #App_logins_info").attr("id","App_logins_info"+count);
			$("#App_logins_entry"+count).attr("onclick","show_all_App_logins("+count+");");
			
			$("#App_logins_entry"+count+" .device_name").html(product[iter].split("_")[1]);		
			$("#App_logins_entry"+count+" i[class^='product-icon'],#App_logins_entry"+count+" i[class*=' product-icon']").addClass("product-icon-"+product[iter].split("_")[0].toLowerCase().replace(/\s/g, '')).addClass("product-icon-"+product[iter].split("_")[1].toLowerCase().replace(/\s/g, ''));

			var device_name=unamed_device;
			if(count > 3)
			{
				$("#App_logins_entry"+count).addClass("allowed_ip_entry_hidden tetraSlideExtra");  
			}
			var devices_count=0;
			var app_logins_sort=timeSorting(App_logins_details[product[iter]]);
			for(devices_iter=0;devices_iter<App_logins_details[product[iter]].length;devices_iter++)
			{
				devices_count++;
				var current_device=App_logins_details[product[iter]][app_logins_sort[devices_iter]];
				
				Device__format = $("#empty_Devices_format").html();
				$("#display_App_logins #App_logins_info"+count).append(Device__format);
				$("#display_App_logins #App_logins_info"+count+" #Devices_entry").attr("id","Devices_entry"+devices_count);
				$("#display_App_logins #App_logins_info"+count+" #Devices_entry"+devices_count+" #device_info").attr("id","device_info"+devices_count);
				
				if(current_device.device_info.device_name!=""	&&	current_device.device_info.device_name!=undefined)
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_name").html(current_device.device_info.device_name);
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_name").html(current_device.device_info.device_name);

				}
				else
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_name").html(unamed_device);
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_name").html(unamed_device);
				}
				
				if(current_device.device_info.device_model!=""	&&	current_device.device_info.device_model!=undefined)
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_model").html(current_device.device_info.device_model);
				}
				else
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_model").html(unknown_device);
				}
				if(current_device.device_info.device_img!=""  &&  current_device.device_info.device_img!=undefined)
				{
					addDeviceIcon($("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_pic") , current_device.device_info);
					if(current_device.device_info.device_model==""	||	current_device.device_info.device_model==undefined)
					{
						$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_model").html(deviceImgToDeviceModelJson[current_device.device_info.device_img]?deviceImgToDeviceModelJson[current_device.device_info.device_img]:unknown_device);
					}
				}
				else
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_pic").addClass("mail_client_logo");
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_pic").html(unknown_device.substr(0,2).toUpperCase());
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_pic").addClass(color_classes[gen_random_value()]);
				}
				$("#App_logins_info"+count+" #Devices_entry"+devices_count+" .device_time").html(current_device.created_time_elapsed);
				$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_time").html(current_device.created_date);
				if(current_device.location!=undefined)
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_location").html(current_device.location);
				}
				
				if(App_logins_details[product[iter]].ip_address!=undefined)
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #ip_info").show();
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #pop_up_ip").html(App_logins_details[product[iter]].ip_address);
				}
				else
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #ip_info").hide();
				}
				
				if(current_device.login_via_oneauth)
				{
					if(sessions_data.applogins[product[iter]].length>1)// number of device more than one
					{
						$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #device_oneauthsignin").show();
						$("#App_logins_entry"+count+" #product_oneauthsignin").remove();
					}
					else
					{
						$("#App_logins_entry"+count+" #product_oneauthsignin").show();
						$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #device_oneauthsignin").remove();
					}
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #terminate_device").remove();
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #current_mfadevice").remove();
				}
				else if(!current_device.device_info.is_primary)
				{
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #terminate_device").attr("onclick","delete_current_device_entry("+count+","+devices_count+",\'"+product[iter]+"\',\'"+current_device.client_id+"\',\'"+current_device.refresh_token_hash+"\');");
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #current_mfadevice").remove();
					$("#App_logins_entry"+count+" #product_oneauthsignin").remove();
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #device_oneauthsignin").remove();
				}
				else	//only primary mode
				{
					$("#App_logins_entry"+count+" #product_oneauthsignin").remove();
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #device_oneauthsignin").remove();
					$("#App_logins_info"+count+" #Devices_entry"+devices_count+" #terminate_device").remove();
				}
				
				
			}
			if(App_logins_details[product[iter]].length==1)
			{
				if(App_logins_details[product[iter]][0].device_name!="")
				{
					$("#App_logins_entry"+count+" .device_time:first").html(App_logins_details[product[iter]][0].device_info.device_name);
				}
				else
				{
					$("#App_logins_entry"+count+" .device_time:first").html(unamed_device);
				}
				if(App_logins_details[product[iter]][0].location!=undefined)
				{
					$("#App_logins_entry"+count+" .asession_location").html(App_logins_details[product[iter]][0].location);
				}
				
			}
			else
			{
				$("#App_logins_entry"+count+" .device_time:first").html(App_logins_details[product[iter]].length+" "+Devices);
				$("#App_logins_entry"+count+" .asession_location").html(App_logins_details[product[iter]].length+" "+Locations);
			}
		}
		if(count>3)
		{
			$("#App_logins_viewmoew").show();
			if(count>4)
			{
				$("#App_logins_viewmoew").html(formatMessage(i18nAppLoginskeys["IAM.VIEWMORE.LOGINS"],count-3)); //NO I18N
			}
			else
			{
				$("#App_logins_viewmoew").html(formatMessage(i18nAppLoginskeys["IAM.VIEWMORE.LOGIN"],count-3)); //NO I18N
			}
		}
	}
}

function show_deviceentry_info(ele)
{
	if($(".App_logins_web_more_first").is(":visible"))
	{
		parent_id=".App_logins_web_more_first";//No I18N
	}
	else
	{
		parent_id=".App_logins_web_more_second";//No I18N

	}
	if(($(parent_id+" #view_all_device_info .device_entry").length==1)		&&	($(parent_id+" #view_all_device_info #"+ele.id+" .device_aw_info").is(":visible")))
	{
		return;
	}
	$(parent_id+" #view_all_device_info .device_entry .device_aw_info").slideUp();
	if($(parent_id+" #view_all_device_info #"+ele.id+" .device_aw_info").is(":visible")){
		$(parent_id+" #view_all_device_info #"+ele.id+" .device_aw_info").slideUp();
	}
	else {
		$(parent_id+" #view_all_device_info #"+ele.id+" .device_aw_info").slideDown();
	}
}

function closeview_App_logins_view()
{
	
	$("#sideview").removeClass("show_sideview app_login_sideview");
	setTimeout(function () 
	{
		$("#sideview").html("").hide();
		$(".App_logins_web_more_first").attr("id","").hide();
		$(".App_logins_web_more_second").attr("id","").hide();
		$(".full_view_side_info .devicelogin_div").html("");
		$(".full_view_side_info .all_elements_space").html("");
		$(".devicelogins_entry").removeClass("selected_device_entry");
	}, 300);
	$("#App_logins_box").unbind("click").focus();
}

function closeview_selected_App_logins_view()
{
	popupBlurHide("#App_logins_pop");	//No I18N
}


function closeApp_logins_bigview()
{
	var ele = $("#App_logins_box");
	var position = $("#userapplogins_space")[0].getBoundingClientRect();
	$("#app_login_close_megaview").hide();
	ele.css({"top": position.top, "left": position.left, "width":$("#userapplogins_space").css("width")});//No I18N
	setTimeout(function () 
	{
		$("#display_App_logins .allowed_ip_entry_hidden").slideUp(200);
		$("#userapplogins_space").css("height","unset");
		ele.removeClass("big_box_full_view").css({"top":"unset", "left":"unset", "width":"auto", "height":"auto","position":"relative","padding-bottom":"30px"});	//No I18N
	}, 200);
	$("html").removeClass("donnotscroll");
	if(Object.keys(sessions_data.applogins).length>3)
	{
		$("#App_logins_viewmoew").show();
	}
	
}



function show_all_App_logins(id)
{	
	var slideCallback = function(){
		var disp_id;
		$("#sideview").addClass("app_login_sideview"); //remove this class in closing function
		$("#sideview").html($("#app_login_sideview").html()).show();
		if($(".App_logins_web_more_first").is(":visible"))
		{
			disp_id=".App_logins_web_more_second";//No I18N
			clear_id=".App_logins_web_more_first";//No I18N
		}
		else
		{
			disp_id=".App_logins_web_more_first";//No I18N
			clear_id=".App_logins_web_more_second";//No I18N
	
		}
		if($(clear_id).attr("id")!=undefined	&&	($(clear_id).attr("id")).slice("sideview_".length)==id)	//if it is reclicked
		{
			return;
		}
		
		$(disp_id).attr("id","sideview_"+id);
		
		$(".devicelogins_entry").removeClass("selected_device_entry");
		$("#App_logins_entry"+id).addClass("selected_device_entry");
		
		$(disp_id+" .devicelogin_div").html($("#App_logins_entry"+id+" .devicelogin_div").html());
		if($("#App_logins_entry"+id+" #product_oneauthsignin").length!=0)	//it is a signin via one auth
		{
			$(disp_id+" .menu_header .signin_mode").show();
		}
		else
		{
			$(disp_id+" .menu_header .signin_mode").hide();
		}
		
		$(disp_id+" #view_all_device_info").html($("#App_logins_entry"+id+" #App_logins_info"+id).html())
		
		
		if($(disp_id+" #view_all_device_info .device_entry").length==1)
		{
			$(disp_id+" #view_all_device_info .device_aw_info").show();
		}
		
		if(!$(".full_view_side_info").hasClass("show_sideview"))
		{
			$(disp_id).show();
			$(".full_view_side_info").addClass("show_sideview");
		}
		else
		{	
			previ_id=($(clear_id).attr("id")).slice("sideview_".length);//No I18N
			if(previ_id<id)// slide from bottom
			{
				
				$(disp_id).css("top","100%");
				$(disp_id).show();
				$(clear_id).animate({'top': '-100%'}, 300, function() 
				{
					$(clear_id).hide();
					$(clear_id).css("top","0%");
					$(clear_id+" .devicelogin_div").html("");
					$(clear_id+" .all_elements_space").html("");
			    });
				$(disp_id).animate({'top': '0px'}, 300);
			}
			else
			{
				$(disp_id).css("top","-100%");
				$(disp_id).show();
				$(clear_id).animate({'top': '100%'}, 300, function() 
				{
					$(clear_id).hide();
					$(clear_id).css("top","0%");
					$(clear_id+" .devicelogin_div").html("");
					$(clear_id+" .all_elements_space").html("");
			    });
				$(disp_id).animate({'top': '0px'}, 300);
			}
			$(clear_id).attr("id","");
		}
		$("#App_logins_box").unbind().click(function(){
			$("#sideview").focus();
		});
		closePopup(closeApp_logins_bigview,"App_logins_box");//No I18N
		closePopup(closeview_App_logins_view,"sideview");//No I18N
		$("#sideview").focus();
	}
	if(id!=undefined && id!=''){
		commonTetradSlide("devicelogins_entry",false,closeApp_logins_bigview,slideCallback,id);//no i18n
	}
	else{
		commonTetradSlide("devicelogins_entry",false,closeApp_logins_bigview);//no i18n
	}
}




function closeTetraSlide(callback){
	if($(".big_box_full_view").is(":visible") || $("#sideview").is(":visible") ){
		$("#sideview").removeClass("show_sideview");
		$("html").removeClass("donnotscroll");
		setTimeout(function(){
			if($(".big_box_full_view").is(":visible")){
				var popupId  = $(".big_box_full_view").prop("id");
				var id = $(".big_box_full_view").closest(".tetraSlideParent").prop("id");
		 		var position = $("#"+id)[0].getBoundingClientRect();
		 		$(".full_view_more_first,.full_view_more_second").hide();
		 		$("#sideview").html("").hide();
		 		$("#"+popupId+ " .tetraSlideFooter").hide();
				$("#"+popupId+ " .tetraSlideClose").hide();
				$("#"+popupId).css({"top": position.top, "left":position.left, "width":$("#"+id).css("width")});//No I18N
				setTimeout(function () 
			    {
					$("#"+popupId).removeClass("big_box_full_view").css({"top":"unset", "left":"unset", "width":"auto", "height":"auto","position":"relative","padding-bottom":"30px"});	//No I18N
					$("#"+id + " .tetraSlideExtra").slideUp(200);
					$("#"+id).next().attr("style","");
			 		if($("#"+popupId+ " .tetraElements").removeClass("selected_device_entry").length > 3){
						$("#"+popupId+ " .tetraViewMore").show();	 
					}
					$("#"+id+" .checkbox").hide();
					$("#"+id+" .info_tab").children(".slide").removeClass("slide");
					$("#"+id+" .select_holder").addClass("remove0width");
					$("#"+id).css("height","unset");//no i18n
			 		if(callback != undefined){
						callback();	 
					}
			 	}, 200);
		 	}	
		},200);
	}
}



function delete_current_device_entry(parent_id,device_id,product_name,client_id,refresh_token_hash)
{
	new URI(Applogin_devices,"self","self",refresh_token_hash,client_id).DELETE().then(function(resp)	//No I18N
			{
				SuccessMsg(getErrorMessage(resp));
				//var deleted=false;
				sessions_data.applogins[product_name].splice(device_id-1,1);
				//sessions_data.applogins[product_name].length--;
				//sessions_data.applogins[product_name].splice(device_id-1,1);
				
				if(sessions_data.applogins[product_name].length==0)
				{
					delete sessions_data.applogins[product_name];
					//deleted=true;
				}
				
				
				$("#App_logins_viewmoew").hide();
				
				$("#display_App_logins .allowed_ip_entry_hidden").show();
				
				var count=Object.keys(sessions_data.applogins).length;
				var sideView_id;
				if($(".App_logins_web_more_first").is(":visible"))
				{
					sideView_id=".App_logins_web_more_first";//No I18N
				}
				else
				{
					sideView_id=".App_logins_web_more_second";//No I18N

				}
				if(count==0)
				{
					closeview_App_logins_view();
					closeApp_logins_bigview();
					load_App_Logins_details(sessions_data.Policies,sessions_data.applogins);
					return;
				}
				else if($(sideView_id+" .device_entry").length>1)
				{
					$(sideView_id+" #Devices_entry"+device_id).remove();
					$(sideView_id+" .box_info .devicelogin_details .device_time").html($(sideView_id+" .device_entry").length+" "+Devices)
					if($(sideView_id+" .device_entry").length==1)
					{
						$(sideView_id+" .device_entry").click();
					}
				}
				else if($(sideView_id+" .device_entry").length==1)
				{
					$("#App_logins_entry"+parent_id).remove();
					closeview_App_logins_view();
				}
				load_App_Logins_details(sessions_data.Policies,sessions_data.applogins);
				$("#display_App_logins .allowed_ip_entry_hidden").show();
				$("#App_logins_viewmoew").hide();
				event.stopPropagation()
				
				
				
			/*	if($("#App_logins_web_more").is(":visible")==true)
				{
					 $("#view_all_App_logins").html("");
					 show_all_App_logins();
					if(!deleted)
					{
						$("#view_all_App_logins #App_logins_entry"+parent_id).click();
					}
				}
				else
				{
					if(deleted)
					{
						if(sessions_data.applogins[product_name] == undefined){
							closeview_selected_App_logins_view();	
						}
					}
					else
					{
						$("#App_logins_current_info #Devices_entry"+device_id).remove();
					}
				}*/
				

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

function addDeviceIcon(element, device_info){
	var img = device_info.device_img;
	var os = device_info.os_img;
	const paths = new Map([
		  ["windows", 5],
		  ["linux", 5],
		  ["osunknown", 4],
		  ["macbook", 8],
		  ["iphone", 9],
		  ["ipad", 7],
		  ["windowsphone", 8],
		  ["samsungtab", 6],
		  ["samsung", 5],
		  ["android", 8],
		  ["pixel", 6],
		  ["oppo", 8],
		  ["vivo", 6],
		  ["androidtablet",6],
		  ["oneplus", 7],
		  ["mobile", 7]
		]);
	
	var no_of_paths;
	var icon_class;
	
	if(img == "personalcomputer"){
		os = os ? os : "osunknown"; //No I18N
		no_of_paths = paths.get(os);
		icon_class = os + "_uk"; //No I18N
	} else if (img == "macbook" || img == "iphone" || img == "windowsphone" || img == "androidtablet") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img + "_uk"; //No I18N
	} else if (img == "vivo" || img == "ipad" || img == "samsungtab" || img == "samsung" || img == "pixel" || img == "oppo" || img == "oneplus") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img;
	}else if (img == "googlenexus" || (img == "mobiledevice" && os == "android")) { //No I18N
		no_of_paths = paths.get("android");
		icon_class = "android_uk"; //No I18N
	} 
	else if (img == "mobiledevice") { //No I18N
		no_of_paths = paths.get("mobile");
		icon_class = "mobile_uk"; //No I18N
	} 
	
	element.addClass("deviceicon-"+ icon_class);
	
	for(var i = 1; i <= no_of_paths; i++){
		var path = document.createElement('span');
		path.classList.add('path'+i); //No I18n
		element.append(path);
	}
	
		
}

/***************************** THIRD PARTY ACCESS *********************************/


function load_thirdpartyaccess()
{
	if(de("tp_history_exception"))
	{
		$("#tp_history_exception").remove();
		$("#tp_history_screen").removeClass("hide");
	}
	if(thirdpartyaccess_data.exception_occured!=undefined	&&	thirdpartyaccess_data.exception_occured)
	{
		$("#tp_history_box .box_info" ).after("<div id='tp_history_exception' class='box_content_div'>"+$("#exception_tab").html()+"</div>" );
		$("#tp_history_exception #reload_exception").attr("onclick","show_thirdparty_history()");
		$("#tp_history_screen").addClass("hide");
		return;
	}

	if(thirdpartyaccess_data!=undefined && !jQuery.isEmptyObject(thirdpartyaccess_data))
	{
		$("#tp_history_screen").hide();
		$("#tp_history_space").show();
		$(".tp_column_heading").show();
		var history=timeSorting(thirdpartyaccess_data, true);
		$("#tp_history_space").html("");
		var count =0;
		for(iter=0;iter<Object.keys(history).length;iter++)
		{
			count++;
			var current_history=thirdpartyaccess_data[history[iter]];
			thirdparty_format = $("#empty_thirdparty_histroy_format").html();
			
			$("#tp_history_space").append(thirdparty_format);
			$("#tp_history_space #tphistory_entry").attr("id","tphistory_entry"+count);
			$("#tp_history_space #tphistory_info").attr("id","tphistory_info"+count);
			if(count > 3)
			{
				$("#tphistory_entry"+count).addClass("tphistory_entry_hidden");
			}
			//$("#tphistory_entry"+count).attr("onclick","show_selected_history("+count+");");
			$("#tphistory_entry"+count+" .tp_history_div i[class^='product-icon'],#tphistory_entry"+count+" .history_div i[class*=' product-icon']").addClass("product-icon-"+current_history.service_name.toLowerCase().replace(/\s/g, ''));
			$("#tphistory_entry"+count+" .tp_history_div .tp_service_name").html(current_history.service_name);
			$("#tphistory_entry"+count+" .tp_history_div .tp_service_time").html(current_history.created_time_elapsed);
			
			
			
			$("#tphistory_entry"+count+" .tp_entry_info .tp_email").html(current_history.used_email.toLowerCase());
			$("#tphistory_entry"+count+" .tp_entry_info .tp_ip").html(current_history.ip_address.toLowerCase());
			$("#tphistory_entry"+count+" .tp_entry_info .tp_user_agent").html(current_history.user_agent.toUpperCase());
		}
		if(count>3)
		{
			$("#tp_history_showall").show();
		}
	}
	else
	{
		$("#tp_history_screen").show();
		if(jQuery.isEmptyObject(thirdpartyaccess_data))	//if the data is empty
		{
			$("#tp_history_screen .primary_btn_check").hide();
			$("#tp_history_screen #tp_history_unavaiable").show();
		}
		$("#tp_history_space").hide();
		$(".tp_column_heading").hide();
		$("#tp_history_showall").hide();
	}
}

function show_thirdparty_history()
{
	$("#tp_history_box .box_blur").show();
	$("#tp_history_box .loader").show();

	
	new URI(User,"self","self").include(ThirdPartyAccess).GET().then(function(resp)	//No I18N
			{
				thirdpartyaccess_data=resp.User.ThirdPartyAccess;
				load_thirdpartyaccess();
				$("#tp_history_box .box_blur").hide();
				$("#tp_history_box .loader").hide();
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
				$("#tp_history_box .box_blur").hide();
				$("#tp_history_box .loader").hide();
			});


}

function show_all_tphistory()
{	
	$("#view_all_tpHistory").append($("#tp_history_space").html()); //load into popuop
	popup_blurHandler('6');
	
	$("#view_all_tpHistory .tphistory_entry_hidden").show();
	
	$("#tp_history_web_more").show(0,function(){
		$("#tp_history_web_more").addClass("pop_anim");
	});
	
	
	closePopup(closeview_all_tpHistoy,"tp_history_web_more");//No I18N
	$("#tp_history_web_more").focus();
	
}

function closeview_all_tpHistoy()
{
	popupBlurHide("#tp_history_web_more",function(){	//No I18N
		$("#view_all_tpHistory").html("");
	});
}

