<%-- $Id$ --%>
<%@page import="com.zoho.accounts.internal.util.I18NUtil"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.internal.Util"%>

<%
response.setContentType("text/javascript;charset=UTF-8"); // No I18N
response.setHeader("Cache-Control", "private,max-age=86400");//No I18N
String supportEmailId = Util.getSupportEmailId();
String adminEmailId = null;
String adminEmailIdStr = AccountsConfiguration.ADMIN_EMAIL_ID.toStringValue();
if(adminEmailIdStr != null) {
	InternetAddress inetAddress = new InternetAddress(adminEmailIdStr);
	if(inetAddress != null) {
		adminEmailId = inetAddress.getAddress();
	}
	if(adminEmailId == null) {
		adminEmailId = adminEmailIdStr;
	}
}
%>

<!-- common -->
 var relogin_warning_msg = '<%=Util.getI18NMsg(request,"IAM.ERROR.RELOGIN.UPDATE")%>'; <%--No I18N--%>
 var thottle_reached_msg = '<%=Util.getI18NMsg(request,"IAM.NEW.URL.THOTTLE.ERROR")%>'; <%--No I18N--%>
 var photo_type_notsupported = '<%=Util.getI18NMsg(request,"IAM.UPLOAD.PHOTO.ERROR.IMAGE.NOT.SUPPORTED")%>'; <%--No I18N--%>
 

<!-- UNAUTH -->
 var err_try_again = '<%=Util.getI18NMsg(request,"IAM.ERROR.GENERAL")%>'; <%--No I18N--%>

 var empty_password_field = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.LOGINPASS")%>'; <%--No I18N--%>
 var invalid_password = '<%=Util.getI18NMsg(request,"IAM.ERROR.INVALID.CURRENT.PASSWORD")%>'; <%--No I18N--%>
 
 var success_reject_msg ='<%=Util.getI18NMsg(request, "IAM.GRPINVITATION.REJECT.SUCCESS")%>'; <%--No I18N--%> 
 var expired_digest ='<%=Util.getI18NMsg(request, "IAM.GROUPINVITATION.EXPIRED_DIGEST")%>'; <%--No I18N--%> 
 var invalid_digest ='<%=Util.getI18NMsg(request, "IAM.GROUPINVITATION.INVALID_DIGEST")%>'; <%--No I18N--%> 
 var success_accept_msg ='<%=Util.getI18NMsg(request, "IAM.GRPINVITATION.ACCEPT.SUCCESS")%>'; <%--No I18N--%> 
 
 var org_invalid_digest ='<%=Util.getI18NMsg(request, "IAM.ORGINVITATION.INVALID_DIGEST")%>'; <%--No I18N--%> 
 var org_expired_digest ='<%=Util.getI18NMsg(request, "IAM.ORGINVITATION.EXPIRED_DIGEST")%>'; <%--No I18N--%> 

 <!--	common	-->
 var err_cancel ='<%=Util.getI18NMsg(request, "IAM.CANCEL")%>'; <%--No I18N--%>
 var resend_otp_countdown ='<%=Util.getI18NMsg(request, "IAM.RESEND.OTP.COUNTDOWN")%>'; <%--No I18N--%>
 var resend_otp ='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.RESEND.OTP")%>'; <%--No I18N--%>

<!--  accounts -->
	var msg_link_to_reset_password = '<%=Util.getI18NMsg(request,"IAM.FORGOT.ZOHO.PASSWORD.USER.RESPONSE")%>'; <%--No I18N--%>
	var note = '<%=Util.getI18NMsg(request, "IAM.NOTE")%>';<%--No I18N--%>
	var iam_verify_phone_number = '<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.VERIFY")%>'; <%-- No I18N --%>  
	var err_invalid_verify_code = '<%=Util.getI18NMsg(request, "IAM.SIGNIN.ERROR.INVALID.VERIFICATION.CODE")%>'; <%--No I18N--%>
	var err_valid_otp_code = '<%=Util.getI18NMsg(request, "IAM.ERROR.VALID.OTP")%>'; <%--No I18N--%>
	var err_addphone_confirm='<%=Util.getI18NMsg(request, "IAM.CONFIRM")%>'; <%--No I18N--%>
	var awesome ='<%=Util.getI18NMsg(request, "IAM.AWESOME")%>'; <%--No I18N--%> 
 	var oops ='<%=Util.getI18NMsg(request, "IAM.OOPS")%>'; <%--No I18N--%> 
 	var mailpopup_password_title = '<%=Util.getI18NMsg(request,"IAM.ACCOUNT.RECOVEY.TITLE")%>'; <%-- No I18N --%>
 	var sendMail_butt ='<%=Util.getI18NMsg(request,"IAM.EMAIL.CONFIRMATION.SEND.EMAIL")%>';<%-- No I18N --%>
	var mailpopup_password_msg = '<%=Util.getI18NMsg(request,"IAM.MSG.POPUP.PASSWORD.MESSAGE")%>'; <%-- No I18N --%>
	var empty_field= '<%=Util.getI18NMsg(request,"IAM.ERROR.EMPTY.FIELD")%>'; <%-- No I18N --%>
	var max_size_field= '<%=Util.getI18NMsg(request,"IAM.ERROR.MAX.SIZE.FIELD")%>'; <%-- No I18N --%>
	var undo_text= '<%=Util.getI18NMsg(request,"IAM.UNDO")%>'; <%-- No I18N --%>
	
	<!-- profile -->
	    var err_fname = '<%=Util.getI18NMsg(request,"IAM.ERROR.FULLNAME.EMPTY")%>'; <%--No I18N--%>
	    var err_fname_maxlen = '<%=Util.getI18NMsg(request,"IAM.ERROR.FULLNAME.MAXLEN", 100)%>'; <%--No I18N--%>
	    var err_valid_name = '<%=Util.getI18NMsg(request,"IAM.ALLOWEDIP.NAME.NOTVALID")%>'; <%--No I18N--%>
	    var err_dname_maxlen = '<%=Util.getI18NMsg(request,"IAM.ERROR.DISPLAYNAME.MAX.LENGTH", 50)%>'; <%--No I18N--%>
	    var err_pinfo_cn_cannot_empty = '<%=Util.getI18NMsg(request, "IAM.PERSONAL_INFO.COUNTRY.CANNOT.EMPTY")%>'; <%--No I18N--%>
	    var err_pinfo_ln_cannot_empty = '<%=Util.getI18NMsg(request, "IAM.PERSONAL_INFO.LANG.CANNOT.EMPTY")%>'; <%--No I18N--%>
	    var err_pinfo_tz_cannot_empty = '<%=Util.getI18NMsg(request, "IAM.PERSONAL_INFO.TZONE.CANNOT.EMPTY")%>'; <%--No I18N--%>
	    var iam_search_text = '<%=Util.getI18NMsg(request, "IAM.SEARCHING")%>'; <%--No I18N--%>
	    var iam_no_result_found_text = '<%=Util.getI18NMsg(request, "IAM.NO.RESULT.FOUND")%>'; <%--No I18N--%>
	    var name_spl_char_errror = '<%=Util.getI18NMsg(request, "IAM.NAME.SPL.CHAR.ERROR")%>'; <%--No I18N--%>
<%-- 	    var err_psaved = '<%=Util.getI18NMsg(request,"IAM.ERROR.PERSONAL.SAVED")%>'; No I18N --%>
	    var err_envalid_user_fname = '<%=Util.getI18NMsg(request, "IAM.ERROR.FNAME.INVALID.CHARACTERS")%>'; <%-- No I18N --%>
	    var err_envalid_user_lname = '<%=Util.getI18NMsg(request, "IAM.ERROR.LNAME.INVALID.CHARACTERS")%>'; <%-- No I18N --%>
	    var err_envalid_user_dname = '<%=Util.getI18NMsg(request, "IAM.ERROR.DISPLAYNAME.INVALID.CHARACTERS")%>'; <%-- No I18N --%> 
	    var err_cnt_error_occurred = '<%=Util.getI18NMsg(request,"IAM.ERROR.GENERAL")%>'; <%--No I18N--%>
	    var err_delete_display_pic = '<%=Util.getI18NMsg(request,"IAM.ERROR.DLT_PHOTO")%>'; <%--No I18N--%>
	    
	<!--     email -->
	    var Fbaccount = '<%=Util.getI18NMsg(request,"IAM.FACEBOOK.USER.ACCOUNT")%>'; <%--No I18N--%>
	    var em_resend_conf = '<%=Util.getI18NMsg(request,"IAM.MSG.POPUP.EMAIL.CONFIRM.MSG")%>'; <%--No I18N--%>
	    
	    var err_validemail = '<%=Util.getI18NMsg(request,"IAM.ERROR.EMAIL.INVALID")%>'; <%--No I18N--%>
	    var err_email_maxlen = '<%=Util.getI18NMsg(request,"IAM.ERROR.EMAIL.MAX.LENGTH", 100)%>'; <%--No I18N--%>
	    var err_enter_pass = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER_PASS")%>'; <%--No I18N--%>
	    var err_password_maxlen = '<%=Util.getI18NMsg(request,"IAM.ERROR.PASSWORD.MAXLEN")%>'; <%--No I18N--%>
	    var err_email_primary_notdlt = '<%=Util.getI18NMsg(request,"IAM.ERROR.PRIMARY.NOTDELETE")%>'; <%--No I18N--%>
	    var err_email_sure_delete1 = '<%=Util.getI18NMsg(request,"IAM.EMAIL.DELETE.SECONDARY")%>'; <%--No I18N--%>
	    var err_email_sure_delete_prim = '<%=Util.getI18NMsg(request,"IAM.EMAIL.DELETE.PRIMARY")%>'; <%--No I18N--%>
	    var err_enter_currpass = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.CURRENT.PASSWORD")%>'; <%--No I18N--%>
	    var err_email_sure_delete = '<%=Util.getI18NMsg(request,"IAM.ERROR.SURE.DELETE.CONTACTS")%>'; <%--No I18N--%>
	    var confirm_fb_delete = '<%=Util.getI18NMsg(request, "IAM.FACEBOOK.SURE_DELETE")%>'; <%-- No I18N --%>
	    var delete_EMAIL ='<%=Util.getI18NMsg(request, "IAM.DELETE.EMAIL")%>'; <%--No I18N--%>
	    var mailpopup_email_tip = '<%=Util.getI18NMsg(request, "IAM.EMAIL.TIP",adminEmailId , adminEmailId.split("@")[1])%>';<%-- No I18N --%>
		var resend_tooltip ='<%=Util.getI18NMsg(request, "IAM.EMAIL.RESEND.CONFIRMATION.MAIL")%>'; <%--No I18N--%> 
		var add_email_id='<%=Util.getI18NMsg(request, "IAM.ADD.CONTACT.EMAIL")%>'; <%--No I18N--%> 
		var verify_email_id='<%=Util.getI18NMsg(request, "IAM.PROFILE.EMAIL.VERIFY.HEADING")%>'; <%--No I18N--%> 
		var linked_email_del='<%=Util.getI18NMsg(request, "IAM.PROFILE.EMAIL.ADDRESS.LINKED.EMAIL.DELETION")%>'; <%--No I18N--%>
<!-- 	    phone -->
		var err_mobile_sure_delete1 = '<%=Util.getI18NMsg(request,"IAM.MOBILE.DELETE.MESSAGE")%>'; <%--No I18N--%>  
		var primary_mobile_change_sure = '<%=Util.getI18NMsg(request,"IAM.MFA.MOBILE.PRIMARY.CHANGE")%>'; <%--No I18N--%>  
		var err_update_success = '<%=Util.getI18NMsg(request,"IAM.ERROR.UPDATE.SUCCESS.MESSAGE")%>'; <%--No I18N--%>
		var err_enter_valid_mobile = '<%=Util.getI18NMsg(request, "IAM.PHONE.ENTER.VALID.MOBILE_NUMBER")%>'; <%--No I18N--%>
		var delete_Mobile ='<%=Util.getI18NMsg(request, "IAM.DELETE.MOBILE")%>'; <%--No I18N--%>
		var iam_continue ='<%=Util.getI18NMsg(request, "IAM.CONTINUE")%>'; <%--No I18N--%>
 		var unverfied ='<%=Util.getI18NMsg(request, "IAM.UNVERIFIED")%>'; <%--No I18N--%>
 		var otp_description ='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.OTP.SENT")%>'; <%--No I18N--%>
 		var mob_resend_conf = '<%=Util.getI18NMsg(request,"IAM.MSG.POPUP.MOBILE.CONFIRM.MSG")%>'; <%--No I18N--%>
 		var resend_otp_title ='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.RESEND.OTP")%>'; <%--No I18N--%>
 		var primay_mobile_definition ='<%=Util.getI18NMsg(request, "IAM.PROFILE.PHONENUMBERS.MAKE.PRIMARY.DESCRIPTION")%>'; <%--No I18N--%>
 		var iam_change ='<%=Util.getI18NMsg(request, "IAM.SIGNUP.CHANGE")%>'; <%--No I18N--%>
 		var tfa_not_allowed ='<%=Util.getI18NMsg(request, "IAM.MFA.MOBILE.ERROR.NUMBER.NOT.ALLOWED")%>'; <%--No I18N--%>
 		var disabled_mfa_number='<%=Util.getI18NMsg(request, "IAM.PROFILE.MFA.DISABLED.NUMBER.DESCRIPTION")%>'; <%--No I18N--%>
 		var OTP_sending='<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SENDING")%>'; <%--No I18N--%>
 		var OTP_resent='<%=Util.getI18NMsg(request, "IAM.GENERAL.OTP.SUCCESS")%>'; <%--No I18N--%>
 
 <!-- 		user Preferences -->
<%--  		var err_pref_invalid_dateformat = '<%=Util.getI18NMsg(request,"IAM.USERPREFERENCE.ERROR.INVALID.DATEFORMAT")%>'; No I18N --%>
		var write_operation_not_allowed = '<%=Util.getI18NMsg(request, "IAM.WRITEOPERATION.NOT.ALLOWED")%>'; <%-- No I18N --%>
 		var password_expiry_notif='<%=Util.getI18NMsg(request,"IAM.SETTINGS.NOTIFICATION.PASSWORD")%>'; <%--No I18N--%>
 		var notif_none='<%=Util.getI18NMsg(request,"IAM.SETTINGS.PASSWORD.EXPIRATION.DESC")%>'; <%--No I18N--%>
 		var no_subscription='<%=Util.getI18NMsg(request,"IAM.SETTINGS.SUSCRIPTIONS.NONE",Util.getI18NMsg(request,"IAM.ZOHOCORP.LINK"))%>'; <%--No I18N--%>
 		var newsletter_suscribed='<%=Util.getI18NMsg(request,"IAM.SETTINGS.SUSCRIPTIONS.DONE")%>'; <%--No I18N--%>
 		
 		var current_to_wanrning ='<%=Util.getI18NMsg(request,"IAM.ALLOWEDIP.NOTIN_RANGE")%>'; <%--No I18N--%>
 		var date_and_time_title='<%=Util.getI18NMsg(request,"IAM.SETTINGS.DATEFORMAT.HEADDING")%>'; <%--No I18N--%>
 		var date_and_time_desc='<%=Util.getI18NMsg(request,"IAM.SETTINGS.DATEFORMAT.DESCRIPTION")%>'; <%--No I18N--%>
 		var date_and_time_cta='<%=Util.getI18NMsg(request,"IAM.SAVE")%>'; <%--No I18N--%>
 		var custom_dateformat = '<%=Util.getI18NMsg(request,"IAM.USERPREFERENCE.CUSTOM")%>'; <%--No I18N--%>
 		
 <!-- 		close account -->
  		var partner_close_account_msg ='<%=Util.getI18NMsg(request,"IAM.CLOSEACCOUNT.MSG_PARTNERADMIN")%>'; <%--No I18N--%>
 		
  <!-- 		Password -->		
		var password_last_modified='<%=Util.getI18NMsg(request,"IAM.LAST.MODIFIED.TIME")%>'; <%--No I18N--%>
		var password_never_modified='<%=Util.getI18NMsg(request,"IAM.PASSWORD.NEVER.MODIFED")%>'; <%--No I18N--%>
		var password_last_changed='<%=Util.getI18NMsg(request,"IAM.LAST.CHANGE.TIME")%>'; <%--No I18N--%>
		
		
<!--  		AuthTokens Active -->			
		var authtoken_revoke_success = '<%=Util.getI18NMsg(request, "IAM.ACTIVETOKEN.REVOKE.SUCCESS")%>'; <%-- No I18N --%>
<!--  		SAML -->		
		var err_samlsetup_enter_loginurl = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.ENTER.LOGIN.URL")%>'; <%-- No I18N --%>
		var err_samlsetup_enter_logouturl = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.ENTER.LOGOUT.URL")%>'; <%-- No I18N --%>
		var err_samlsetup_enter_password_url = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.ENTER.CHANGE.PASSWORD.URL")%>'; <%-- No I18N --%>
		var err_samlsetup_enter_publickey = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.ENTER.PUBLICKEY")%>'; <%-- No I18N --%>
		var err_samlsetup_select_algorithm = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.SELECT.ALGORITHM")%>'; <%-- No I18N --%>
		var err_url_pattern = '<%=Util.getI18NMsg(request, "IAM.SAML.SETUP.URL.PATTERN")%>'; <%-- No I18N --%>
		var saml_setup_description = '<%=Util.getI18NMsg(request, "IAM.SAMLSETUP.AUTHENTICATION.MESSAGE")%>'; <%-- No I18N --%>
		var saml_logout_responce_on = '<%=Util.getI18NMsg(request, "IAM.SAML.LOGOUT.RESPONSE.ACTIVATED")%>'; <%-- No I18N --%>
		var saml_logout_responce_off = '<%=Util.getI18NMsg(request, "IAM.SAML.LOGOUT.RESPONSE.DEACTIVATED")%>'; <%-- No I18N --%>
		var saml_jit_duplicate = '<%=Util.getI18NMsg(request, "IAM.SAML.JIT.DUPLICATE")%>'; <%-- No I18N --%>
		
		
<%-- 		var err_unauthorized_access = '<%=Util.getI18NMsg(request, "IAM.RESERVE.UNAUTHORIZED.ACCESS")%>'; No I18N --%>
		var err_invalid_input = '<%=Util.getI18NMsg(request, "IAM.SAML.RESERVE.INVALID.INPUT")%>'; <%-- No I18N --%>
<%-- 	    var err_saml_invalid_certificate = '<%=Util.getI18NMsg(request, "IAM.SAML.INVALID.CERTIFICATE")%>'; No I18N --%>
<%-- 		var err_saml_process_failed = '<%=Util.getI18NMsg(request, "IAM.ERROR.PROCESS.FAILED")%>'; No I18N --%>
		
	
		
<!--  		GROUP -->
		var success_newpic_forgrp = '<%=Util.getI18NMsg(request,"IAM.GROUP.UPLOADED.NEW_GROUP")%>'; <%--No I18N--%>
		var err_view_grp = '<%=Util.getI18NMsg(request,"IAM.GRP.NOTIFICATION.SUCCESS.BUTTON")%>'; <%--No I18N--%>
		var err_groupname_empty = '<%=Util.getI18NMsg(request,"IAM.GROUP.ERROR.GROUPNAME.EMPTY")%>'; <%--No I18N--%>
		var err_pending_text = '<%=Util.getI18NMsg(request,"IAM.GROUP.PENDING")%>'; <%--No I18N--%>
		var err_groupname_maxlen = '<%=Util.getI18NMsg(request, "IAM.ERROR.GROUPNAME.MAXIMUM.LENGTH", 100)%>'; <%--No I18N--%>
		var err_groupdesc_maxlen = '<%=Util.getI18NMsg(request, "IAM.ERROR.GROUPDESC.MAXIMUM.LENGTH", 200)%>'; <%--No I18N--%>
    	var grp_update_error = '<%=Util.getI18NMsg(request,"IAM.GROUP.ERROR.UPDATE")%>'; <%--No I18N--%>		
    	var err_groupunsubscribe_sure = '<%=Util.getI18NMsg(request, "IAM.GROUP.SURE.UNSUBSCRIBE.CONFIRMATION")%>'; <%--No I18N--%>
    	var err_groupunsubscribe_header = '<%=Util.getI18NMsg(request, "IAM.GROUP.UNSUBCRIBE")%>'; <%--No I18N--%>
		var err_group_success_dlt = '<%=Util.getI18NMsg(request,"IAM.ERROR.GROUP.DELETED")%>'; <%--No I18N--%>
		var err_sure_dltgrp = '<%=Util.getI18NMsg(request,"IAM.ERROR.PROMPT.DLTGROUP")%>'; <%--No I18N--%>
		var err_sure_dltgrp_header = '<%=Util.getI18NMsg(request,"IAM.ERROR.PROMPT.DLTGROUP.HEADER")%>'; <%--No I18N--%>
		var err_enter_mememail = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.MEMBER.EMAIL")%>'; <%--No I18N--%>
		var err_groupmembers_cannot_invitemore_one='<%=Util.getI18NMsg(request, "IAM.ERROR.GROUPMEMBER.CANNOT.INVITEMORE_ONE")%>';<%--No I18N--%>
		var err_groupmembers_cannot_invitemore='<%=Util.getI18NMsg(request, "IAM.ERROR.GROUPMEMBER.CANNOT.INVITEMORE")%>';<%--No I18N--%>
		var err_groupmessage_maxlen = '<%=Util.getI18NMsg(request, "IAM.GROUP.LIMIT.MESSAGE.MAXIMUMLENGTH", 1000)%>'; <%--No I18N--%>
		var err_invalid_email = '<%=Util.getI18NMsg(request,"IAM.EMAIL.INVALID.ERROR")%>'; <%--No I18N--%>
	    var err_groupmembers_caninvite='<%=Util.getI18NMsg(request, "IAM.ERROR.GROUPMEMBER.LIMIT.CANINVITE")%>';<%--No I18N--%>
    	var err_groupmembers_caninvite_one='<%=Util.getI18NMsg(request, "IAM.GROUP.MEMBER.LIMIT.CANINVITE_ONE.ERROR")%>';<%--No I18N--%>
    	var err_group_create_success = '<%=Util.getI18NMsg(request,"IAM.ERROR.CREATE.SUCCESS")%>'; <%--No I18N--%>
        var err_group_existmember_delete_msg = '<%=Util.getI18NMsg(request, "IAM.GROUP.EXIST.MEMBER.SURE.DELETE")%>'; <%-- No I18N --%>
        var err_group_makemember_confirm_msg = '<%=Util.getI18NMsg(request, "IAM.GROUP.EXIST.MEMBER.SURE.MAKE.MEMBER")%>'; <%-- No I18N --%>
        var err_group_makemoderator_confirm_msg = '<%=Util.getI18NMsg(request, "IAM.GROUP.EXIST.MEMBER.SURE.MAKE.MODERATOR")%>'; <%-- No I18N --%>
		var err_group_invitedmember_delete_msg = '<%=Util.getI18NMsg(request, "IAM.GROUP.INVITEDMEMBER.SURE.DELETE.QUESTION")%>'; <%-- No I18N --%>
		var empty_pending='<%=Util.getI18NMsg(request,"IAM.GROUP.ERROR.EMPTY.INVITATIONS")%>';<%-- No I18N --%>
		var incorret_GID='<%=Util.getI18NMsg(request,"IAM.ERROR.GROUP.GID.INCORRECT")%>';<%-- No I18N --%>
		var grp_member_limitReached='<%=Util.getI18NMsg(request,"IAM.ERROR.GROUPMEMBER.LIMIT.EXCEEDED")%>';<%-- No I18N --%>
		var grp_mem_not_registered='<%=Util.getI18NMsg(request,"IAM.GROUP.INFO.REGISTERED")%>';<%-- No I18N --%>
		  var err_pending_text = '<%=Util.getI18NMsg(request,"IAM.GROUP.PENDING")%>'; <%--No I18N--%>
		  var grp_contacts_search = '<%=Util.getI18NMsg(request,"IAM.GROUP.MEMBER.SEARCH.DESC")%>'; <%--No I18N--%>
		var grp_email_placeholder = '<%=Util.getI18NMsg(request,"IAM.GROUP.MEMBER.EMAIL_ADDRESS")%>'; <%--No I18N--%>
		var grp_email_use_comma = '<%=Util.getI18NMsg(request,"IAM.GROUP.EMAIL_USECOMMA")%>'; <%--No I18N--%>
		var grp_new_user_invite = '<%=Util.getI18NMsg(request,"IAM.GROUPS.NEW.INVITE")%>'; <%--No I18N--%>
		var grp_error_email_invite = '<%=Util.getI18NMsg(request,"IAM.GROUPS.ERROR.INVITE.EMAIL")%>'; <%--No I18N--%>
		
<!--  		Change Password -->		
	    var err_wrong_pass = '<%=Util.getI18NMsg(request,"IAM.PASSWORD.ERROR.WRONG.CONFIRMPASS")%>'; <%--No I18N--%>
	    var err_loginName_same = '<%=Util.getI18NMsg(request, "IAM.PASSWORD.POLICY.SAME.LOGINNAME")%>'; <%--No I18N--%>
	    var err_pass_len = '<%=Util.getI18NMsg(request,"IAM.ERROR.PASS.LEN")%>'; <%--No I18N--%>
	    var err_enter_newpass = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.NEW.PASSWORD")%>'; <%--No I18N--%>
		var err_minmax_len_pass = '<%=Util.getI18NMsg(request,"IAM.RESETPASS.PASSWORD.MIN.MAX")%>'; <%--No I18N--%>
		
<!--  		SECURITY Questions -->
    	
		var err_enter_ques = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.QUES")%>'; <%--No I18N--%>
		var err_question_maxlen = '<%=Util.getI18NMsg(request, "IAM.ERROR.SECURITY.QUESTION_MAXLEN", 200)%>'; <%--No I18N--%>
    	var err_answer_maxlen = '<%=Util.getI18NMsg(request, "IAM.ERROR.SECURITY.ANSWER_MAXLEN", 50)%>'; <%--No I18N--%>
        var err_enter_ans = '<%=Util.getI18NMsg(request,"IAM.ERROR.ENTER.ANSWER")%>'; <%--No I18N--%>
        var err_pp_start ='<%=Util.getI18NMsg(request,"IAM.PASSWORD.POLICY.HEADING")%>';<%--No I18N--%>
    	var err_pp_minnum = '<%=Util.getI18NMsg(request,"IAM.RESETPASS.PASSWORD.MIN")%>'; <%--No I18N--%>
    	var err_pp_minnum_only = '<%=Util.getI18NMsg(request,"IAM.RESETPASS.PASSWORD.MIN.NO.WITH")%>'; <%--No I18N--%>
    	var err_pp_minnum_pp_no = '<%=Util.getI18NMsg(request,"IAM.RESETPASS.PASSWORD.MIN.NO.WITH")%>'; <%--No I18N--%>
    	var err_pp_cases ='<%=Util.getI18NMsg(request, "IAM.PASS_POLICY.CASE")%>';<%--No I18N--%>
    	var err_pp_heading = '<%=Util.getI18NMsg(request,"IAM.PASS_POLICY.HEADING")%>';<%--No I18N--%>
    	var err_pp_spl ='<%=Util.getI18NMsg(request, "IAM.PASS_POLICY.SPL")%>';<%--No I18N--%>
    	var err_pp_spl_sing ='<%=Util.getI18NMsg(request, "IAM.PASS_POLICY.SPL_SING")%>';<%--No I18N--%>
    	var err_pp_num = '<%=Util.getI18NMsg(request,"IAM.PASS_POLICY.NUM")%>';<%--No I18N--%>
    	var err_pp_num_sing = '<%=Util.getI18NMsg(request,"IAM.PASS_POLICY.NUM_SING")%>';<%--No I18N--%>
    	var err_pp_min_max = '<%=Util.getI18NMsg(request,"IAM.PASS_POLICY.MIN_MAX")%>';<%--No I18N--%>
    	var err_pp_case = '<%=Util.getI18NMsg(request,"IAM.PASS_POLICY.CASE")%>';<%--No I18N--%>
    	
    	var iam_include ='<%=Util.getI18NMsg(request, "IAM.INCLUDE")%>';<%--No I18N--%>
 <!--  		Allowed IPS -->   	
<%-- 	    var ip_delete_success = '<%=Util.getI18NMsg(request, "IAM.ALLOWEDIP.DELETE")%>'; No I18N --%>
	    var err_enter_toip = '<%=Util.getI18NMsg(request, "IAM.ALLOWEDIP.TOIP.NOT_VALID")%>'; <%--No I18N--%>
<%--         var ip_address_exist = '<%=Util.getI18NMsg(request, "IAM.ALLOWEDIP.ERROR.IP_ALREADY_EXISTS")%>'; No I18N --%>
		
 <!--  		App password --> 
		var err_app_pass_click_text = '<%=Util.getI18NMsg(request, "IAM.APP.CLICK.COPY")%>'; <%--No I18N--%>
    	var err_app_pass_copied = '<%=Util.getI18NMsg(request, "IAM.APP.PASS.COPIED")%>'; <%--No I18N--%>
    	

<!--  	Device_logins -->      
		var Devices	='<%=Util.getI18NMsg(request, "IAM.DEVICES")%>'; <%--No I18N--%>
		var Locations	='<%=Util.getI18NMsg(request, "IAM.LOCATIONS")%>'; <%--No I18N--%>
		var mail_client	='<%=Util.getI18NMsg(request, "IAM.FETCH.DEVICE.HEADER")%>'; <%--No I18N--%>
		var last_accessed_on	='<%=Util.getI18NMsg(request, "IAM.ACTIVETOKEN.LAST.ACCESSED.ON")%>'; <%--No I18N--%>
		var unamed_device='<%=Util.getI18NMsg(request, "IAM.UNAMED.DEVICE")%>'; <%--No I18N--%>
		var unknown_device='<%=Util.getI18NMsg(request, "IAM.UNKNOWN.DEVICE")%>'; <%--No I18N--%>
		
		
		    
 <!--  	TFA --> 
 
 		var yubikey_invalid_req='<%=Util.getI18NMsg(request, "IAM.ERROR.GENERAL")%>';<%--No I18N--%> 
 		var yubikey_bad_req='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.YUBIKEY.ERROR.BADREQUEST")%>';<%--No I18N--%>  
 		var yubikey_device_ineligible='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.YUBIKEY.ERROR.DEVICEINELIGIBLE")%>';<%--No I18N--%> 
 		var yubikey_error_unsupported='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.YUBIKEY.ERROR.UNSUPPORTED")%>';<%--No I18N--%>
		var yubikey_error_timeout='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.YUBIKEY.ERROR.REGISTRATION.TIMEOUT")%>';<%--No I18N--%>   
 		var yubikey_invalid_name='<%=Util.getI18NMsg(request, "IAM.MFA.YUBIKEY.INVALID.YUBIKEY_NAME.ERROR")%>';<%--No I18N--%>
		var yubikey_already_registered='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.YUBIKEY.REGISTRATION.ERROR.DEVICEINELIGIBLE")%>';<%--No I18N--%>
		var Yubikey_repeated_conf_name='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.DUPLICATE.PASSKEY")%>';<%--No I18N--%>
		var name_validation_error_for_key_name='<%=Util.getI18NMsg(request, "IAM.TFA.PASSKEY.NAME.MAX.LENGTH.ERROR", 50)%>';<%--No I18N--%>

		var webauthn_NotAllowedError ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.NotAllowedError")%>';<%--No I18N--%>
		var webauthn_InvalidStateError ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.InvalidStateError")%>';<%--No I18N--%>
		var webauthn_not_supported ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.BrowserNotSupported")%>';<%--No I18N--%>
		var webauthn_InvalidResponse ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.InvalidResponse")%>';<%--No I18N--%>
		var webauthn_NotSupportedError ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.NotSupportedError")%>';<%--No I18N--%>
		var webauthn_registration_error ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.ErrorOccurred")%>';<%--No I18N--%>
		var webauthn_AbortError = '<%=Util.getI18NMsg(request,"IAM.WEBAUTHN.ERROR.NotAllowedError")%>';<%--No I18N--%>
		var accounts_support_contact_email_id= '<%=Util.getSupportEmailId()%>';<%--No I18N--%>
		
		var webauthn_PasskeyInvalidStateError ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.PASSKEY.InvalidStateError")%>';<%--No I18N--%>
		var webauthn_Passkeyregistration_error ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.PASSKEY.ErrorOccurred")%>';<%--No I18N--%>
		var webauthn_PasskeyInvalidResponse ='<%=Util.getI18NMsg(request, "IAM.WEBAUTHN.ERROR.PASSKEY.InvalidResponse")%>';<%--No I18N--%>
		
 		var mfa_confirm_account_err='<%=Util.getI18NMsg(request, "IAM.MFA.ERROR.CONFIRM.ACCOUNT")%>';<%--No I18N--%> 
   		var mfa_delete_device='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.VERIFY.VIA.AUTHENTICATOR")%>';<%--No I18N--%>  
    	var mfa_mode_details_otp='<%=Util.getI18NMsg(request, "IAM.NEW.SIGNIN.MOBILE")%>';<%--No I18N--%>  
    	var mfa_mode_details_totp='<%=Util.getI18NMsg(request, "IAM.GOOGLE.AUTHENTICATOR")%>';<%--No I18N--%>  
    	var mfa_mode_details_exo='<%=Util.getI18NMsg(request, "IAM.EXO.AUTHENTICATE")%>';<%--No I18N--%>  
    	var mfa_mode_details_yubikey='<%=Util.getI18NMsg(request, "IAM.MFA.YUBIKEY")%>';<%--No I18N--%>  
    	var mfa_mode_oneAuth='<%=Util.getI18NMsg(request, "IAM.ZONE.ONEAUTH")%>';<%--No I18N--%>  
   		var mfa_change_prim_device='<%=Util.getI18NMsg(request, "IAM.MFA.CHANGE.PRIM.DEVICE")%>';<%--No I18N--%>  
  		var mfa_delete_device='<%=Util.getI18NMsg(request, "IAM.MFA.DELETE.DEVICE")%>';<%--No I18N--%>  
 		var mfa_yubikey_mode='<%=Util.getI18NMsg(request, "IAM.MFA.YUBIKEY")%>';<%--No I18N--%>  
 		var mfa_change_primary='<%=Util.getI18NMsg(request, "IAM.MFA.CHANGE.PRIMARY")%>';<%--No I18N--%>
 		var mfa_delete_mode='<%=Util.getI18NMsg(request, "IAM.MFA.CONFIRM.DELETE.MODE")%>';<%--No I18N--%>		
 		var err_tfa_no_backupcodes='<%=Util.getI18NMsg(request, "IAM.TFA.NO.BACKUPCODES")%>';<%--No I18N--%>
		var err_tfa_setup_incomplete='<%=Util.getI18NMsg(request, "IAM.TFA.WARN.SETUP_COMPLETE")%>';<%--No I18N--%>
		var err_already_configured_mobile='<%=Util.getI18NMsg(request, "IAM.PHONE.TFA.ALREADY_CONFIGURED")%>';<%--No I18N--%>
		var err_verify_sms_message='<%=Util.getI18NMsg(request, "IAM.TFA.VERIFY.SMS_MESSAGE")%>'; <%--No I18N--%>
		var err_verify_qr_key ='<%=Util.getI18NMsg(request, "IAM.VERIFY.TWO.FACTOR.DESC")%>'<%--No I18N--%>
		var err_exoauth_verify_message='<%=Util.getI18NMsg(request, "IAM.TFA.EXOAUTH.VERIFY.MSG")%>'; <%--No I18N--%>
    	var err_exoauth_verify_message1='<%=Util.getI18NMsg(request, "IAM.TFA.EXOAUTH.VERIFY.MESSAGE1")%>'; <%--No I18N--%>
        var err_invalid_label='<%=Util.getI18NMsg(request, "IAM.TFA.INVALID_LABEL")%>'; <%--No I18N--%>
        var err_label_length_exceeded='<%=Util.getI18NMsg(request, "IAM.TFA.LABEL.LENGTH_EXCEEDED")%>'; <%--No I18N--%>
        var tfa_pass_msg ='<%=Util.getI18NMsg(request,"IAM.APP.PASSWORD.MESSAGE")%>';<%--No I18N--%>
        var tfa_generate_now =' <%=Util.getI18NMsg(request,"IAM.TFA.GENERATE")%>';<%--No I18N--%>
        var delete_app_pass_text=' <%=Util.getI18NMsg(request,"IAM.DELETE.APP.PASSWORD")%>';<%--No I18N--%>
    	var logout =' <%=Util.getI18NMsg(request,"IAM.REMOVE")%>';<%--No I18N--%>
    	var tfa_recovery_delete_warn =' <%=Util.getI18NMsg(request,"IAM.TFA.DELETE.BACKUP.WARN")%>';<%--No I18N--%>
        var err_invalid_password='<%=Util.getI18NMsg(request, "IAM.ERROR.INVALI.PASSWORD")%>'; <%--No I18N--%>
    	var tfa_new_backup='<%=Util.getI18NMsg(request, "IAM.TFA.SMS.SETUP.MESSAGE")%>'; <%--No I18N--%>
    	var tfa_delete ='<%=Util.getI18NMsg(request, "IAM.DELETE")%>'; <%--No I18N--%>
    	var mfa_backupcode_gen_time='<%=Util.getI18NMsg(request, "IAM.GENERATEDTIME")%>';<%--No I18N--%>
    	var err_backup_recommend_notes='<%=Util.getI18NMsg(request, "IAM.TFA.PRINTDOC.RECOMMEND_TIP")%>';<%--No I18N--%>
    	var tfa_mkeprim='<%=Util.getI18NMsg(request, "IAM.MYEMAIL.MAKE.PRIMARY")%>';<%--No I18N--%>
    	var pass_ver_head='<%=Util.getI18NMsg(request, "IAM.PASSWORD.VERIFICATION")%>';<%--No I18N--%>
    	var bk_totfa_ver_head='<%=Util.getI18NMsg(request, "IAM.TFA.MAKEPRIMARY_MSG")%>';<%--No I18N--%>
    	var tfa_mobily_verfiy='<%=Util.getI18NMsg(request,"IAM.MOBILE.REGISTARTION")%>'<%--No I18N--%>
    	var tfa_disable_head='<%=Util.getI18NMsg(request,"IAM.TFA.DISABLE.TITLE")%>'<%--No I18N--%>
    	var tfa_disable_desc='<%=Util.getI18NMsg(request,"IAM.TFA.DISABLE.TXT")%>'<%--No I18N--%>
		var tfa_delete_desc='<%=Util.getI18NMsg(request,"IAM.MFA.DISABLE.TXT")%>'<%--No I18N--%>
		var tfa_change_mode_title='<%=Util.getI18NMsg(request,"IAM.MFA.CHANGE.PRIMARY.MODE.TITLE")%>'<%--No I18N--%>
		var mfa_prim_indicator='<%=Util.getI18NMsg(request,"IAM.MFA.PRIMARY")%>'<%--No I18N--%>
		var mfa_pref_indicator='<%=Util.getI18NMsg(request,"IAM.MFA.ANNOUN.SMS.PREF.LABEL")%>'<%--No I18N--%>
		var tfa_preferred_num='<%=Util.getI18NMsg(request,"IAM.TFA.SET.PREFERRED.NUMBER.TITLE")%>'<%--No I18N--%>
		var tfa_preferred_num_text='<%=Util.getI18NMsg(request,"IAM.TFA.SET.PREFERRED.NUMBER")%>'<%--No I18N--%>
		var tfa_delete_num_text='<%=Util.getI18NMsg(request,"IAM.CONFIRM.POPUP.DELETE.MFA.NUMBER")%>'<%--No I18N--%>
		var tfa_delete_login_number='<%=Util.getI18NMsg(request, "IAM.MFA.LOGIN.DELETE.NUMBER")%>';<%--No I18N--%>

    	var tfa_device_verify='<%=Util.getI18NMsg(request, "IAM.VERIFY.DEVICE")%>'<%--No I18N--%>    	
    	
    	var tfa_reenable_head='<%=Util.getI18NMsg(request,"IAM.TFA.REENABLE.HEADING")%>'<%--No I18N--%>
    	var tfa_reenable_desc='<%=Util.getI18NMsg(request,"IAM.TFA.REENABLE.TXT")%>'<%--No I18N--%>
    	var tfa_sms_setup_desc='<%=Util.getI18NMsg(request,"IAM.SETUP.TFA.MOBILE.DESC")%>'<%--No I18N--%>
    	var tfa_sms_setup_add_desc='<%=Util.getI18NMsg(request,"IAM.MFA.ADD.VERIFIED.MOBILE.NUMBER.DESC")%>'<%--No I18N--%>
		var oneauth_verify_authenticator_desc ='<%=Util.getI18NMsg(request, "IAM.VERIFY.ONEAUTH.AUTHENTICATOR.DESC")%>'<%--No I18N--%>
		var verify_otp_heading ='<%=Util.getI18NMsg(request, "IAM.VERIFY.LABEL")%>'<%--No I18N--%>
    	
   <!-- privacy -->
	   var iam_gdpr_dpa_email_exist_err = '<%=Util.getI18NMsg(request, "IAM.PRIVACY.KYC.ALREADY.EMAIL.EXIST")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_com_reg_num_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.COMPANY.REGNUMBER.ERROR")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_street_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.ENTER.STREET.ERROR")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_city_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.ENTER.CITY.ERROR")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_state_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.ENTER.STATE.ERROR")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_z_code_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.ENTER.ZCODE.ERROR")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_role_err = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.SELECT.ROLE.ERROR")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_country_err = '<%=Util.getI18NMsg(request, "IAM.ANNOUNCEMENT.LOCALE.SELECT.COUNTRY")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_emp_count_err = '<%=Util.getI18NMsg(request, "IAM.PRIVACY.KYC.POPUP.EMPLOYEES.COUNT.ERROR")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_picode_err = '<%=Util.getI18NMsg(request, "IAM.PRIVACY.KYC.POPUP.PINCODE.ERROR")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_signed_with_parent_text = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.MERGED.PARENT")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_initiate_tooltip = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.INITIATED")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_complete_tooltip = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.COMPLETED")%>'; <%-- No I18N --%>
       var iam_gdpr_dpa_reject_tooltip = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.REJECTED")%>'; <%-- No I18N --%>
	   var iam_gdpr_dpa_initiate_text = '<%=Util.getI18NMsg(request, "IAM.GDPR.DPA.INITIATE.HEADER1")%>'; <%-- No I18N --%>
       var iam_gdpr_kyc_org_name_err = '<%=Util.getI18NMsg(request, "IAM.PRIVACY.KYC.ORGANIZATION.NAME.ERROR")%>'; <%-- No I18N --%>
       var iam_gdpr_kyc_valid_designation_err = '<%=Util.getI18NMsg(request, "IAM.PRIVACY.KYC.POPUP.VALID.DESIGNATION.ERROR")%>'; <%-- No I18N --%>
	   var iam_kyc_valid_firstname = '<%=Util.getI18NMsg(request, "IAM.NEW.SIGNUP.FIRSTNAME.VALID")%>'; <%-- No I18N --%>
	   var iam_kyc_valid_lastname = '<%=Util.getI18NMsg(request, "IAM.NEW.SIGNUP.LASTNAME.VALID")%>'; <%-- No I18N --%>      
     <!-- org -->