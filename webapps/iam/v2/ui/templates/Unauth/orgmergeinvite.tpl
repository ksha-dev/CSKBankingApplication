<#if (error_code)?has_content>

	<html>
		<head>
			<title><@i18n key="IAM.ORG.INVITATION.TITLE" /></title>
			<meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			<@resource path="/v2/components/css/${customized_lang_font}" />
			<@resource path="/v2/components/css/accountsInviatation.css" />
		</head>
		<body>
		
		
			<div class="result_popup" id="result_popup_error">
				<div class="error_pop_bg"></div>
				<div class="reject_icon"><span class="inner_circle"></span></div>
				<div class="content_space">
					<div class="grn_text" id="result_content"><@i18n key="IAM.ORGINVITATION.ERROR.HEADER.INVALID"/></div>
					<div class="defin_text">${Error_message}</div>
				</div>
			</div>
		
	    	<div class="zohologo"></div>
		</body>
	</html>


<#else>



	<html>
		
		<head>
			<title><@i18n key="IAM.ORG.INVITATION.TITLE"/></title>
		    <meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
			<meta charset="UTF-8" />
			
			<@resource path="/v2/components/css/${customized_lang_font}" />
			<@resource path="/v2/components/css/accountsInviatation.css" />
		    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />	
		    <@resource path="/v2/components/tp_pkg/tippy.all.min.js" />
			<@resource path="/v2/components/js/zresource.js" /> 
			<@resource path="/v2/components/js/uri.js" /> 
			<@resource path="/v2/components/js/common_unauth.js" />
	    	<@resource path="/v2/components/tp_pkg/select2.full.min.js" />
	    	<@resource path="/v2/components/js/invitation.js" />
	    	
	    	<script>
	    	
	    	I18N.load
			({
	    		"IAM.SERVICE.COUNT" : '<@i18n key="IAM.SERVICE.COUNT" />',
	    		"IAM.APP.CLICK.COPY" : '<@i18n key="IAM.APP.CLICK.COPY" />',
	    		"IAM.APP.PASS.COPIED" : '<@i18n key="IAM.APP.PASS.COPIED" />',
	    	});
	    		
	    		var csrfParamName= "${za.csrf_paramName}";
					var csrfCookieName = "${za.csrf_cookieName}";
					var digest ="${digest}";
					var contextpath= "${za.contextpath}";
					var service_ids;
	    	
		    		$(function() 
					{	
						fetch_details();
					});
				
	    	</script>
	    	
		</head>
		
		<body>
		
			<div class="blur"></div>
			
			<#include "${location}/Unauth/invitation_errorToast.tpl">
	
			<div class="result_popup hide" id="result_popup_accepted">
				<div class="success_pop_bg"></div>
				<div class="success_icon"></div>
				<div class="content_space">
					<div class="grn_text" id="result_content"><@i18n key="IAM.INVITATION.ACCEPTED.TITLE"/></div>
					<div class="defin_text"></div>
				</div>
			</div>
	
			<div class="result_popup hide" id="result_popup_rejected">
				<div class="reject_pop_bg"></div>
				<div class="reject_icon"><span class="inner_circle"></span></div>
				<div class="content_space">
					<div class="grn_text" id="result_content"><@i18n key="IAM.INVITATION.REJECTED.TITLE"/></div>
					<div class="defin_text"><@i18n key="IAM.ORG.INVITATION.REJECT.SUCCESS.MESSAGE"/></div>
				</div>
			</div>
			
			<div class="zohologo"></div>
			
			<div class="org_merge_container container">
			
				<div class="invite_details org_merge_invite_details">
	                <div class="org_Name"><@i18n key="IAM.ORG.MERGE.INVITATION.TITLE"/></div>
	                <div class="Invitedby_Name"><@i18n key="IAM.ORG.MERGE.INVITATION.DESC" arg0="${initatior_contacat_email}" arg1="${invited_org_name}" arg2="${initatior_org_name}" /></div>
	            </div>
	            
	            <div class="loader"></div>
	            
	            <div class="merge_conflict hide">
	            	<div class="error_icon icon-warning2"></div>
	            	<div class="conflict_details"></div>
	            </div>
	            
	            <div class="org_merge_details hide">
	            	
	            	<div class="org_info">
	            	
	            		<div class="org_merge_subhead"><@i18n key="IAM.ORG.INFO"/></div>
	            		
	            		<div class="grid" id="user_count">
	            			<span class="menuicon icon-mprofile"></span>
	               			<span class="menutext"><@i18n key="IAM.ORG.USER"/> </span>
	               			<div class="grid_value"></div>
	            		</div>
	            		 
	            		<div class="grid" id="group_count">
	            			<span class="menuicon icon-mgroups"></span>
	               			<span class="menutext"><@i18n key="IAM.GROUPS"/> </span>
	               			<div class="grid_value"></div>
	            		</div>
	            		
	            		<div class="grid" id="domain_count">
	            			<span class="menuicon icon-domain"></span>
	               			<span class="menutext" style="text-transform:uppercase;"><@i18n key="IAM.HEADER.DOMAINS"/> </span>
	               			<div class="grid_value"></div>
	            		</div>
	            		
	            	</div>
	            	
	            	<div class="service_info">
	            		<div class="org_merge_subhead"><@i18n key="IAM.ORG.SERVICES.USED"/></div>
	            		
	            		<div id="app_accout_space" class="app_accout_space">
	            		</div>
	            		
	            	</div>
	            	
	            	<div class="action_elements">                    
	                    <button class="blue_btn" id="accept_btn" onclick="process_merge_request(true)" ><@i18n key="IAM.CONTACTS.ACCEPT" /> </button>
	                   	<button class="red_btn" onclick="process_merge_request(false)"><@i18n key="IAM.INVITE.REJECT" /></button>
	                </div>
	                
	                <ul class="org_merge_note">
  						<li><@i18n key="IAM.ORG.MERGE.NOTE1" /></li>
  						<li><@i18n key="IAM.ORG.MERGE.NOTE2" /></li>
  					</ul>
	                
	                
	            	
	            </div>
	            
               	 
            </div>
	           
	        <div class="issues_contact hide" id="contact_admin><@i18n key="IAM.ORG.ISSUES.CONATCT" arg0="${initatior_contacat_email}"/></div>
		      
		
		</body>
		
	</html>
			
</#if>		