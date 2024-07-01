<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    
    <meta name="viewport"content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
   <title><@i18n key="IAM.ZOHO.ACCOUNTS" /></title>
	<@resource path="/v2/components/css/${customized_lang_font}" />
    <@resource path="/v2/components/css/verifyDomainAnnouncementStyle.css" />
    <@resource path="/v2/components/tp_pkg/jquery-3.6.0.min.js" />
    <script>
    var contextpath = "${za.contextpath}";

    function verifyRedirect(e){
		var link = contextpath+"/home#org/org_domains"; //No I18N
		window.open(link, "_blank");
	}
    </script>
  </head>
  <body>
	 <#include "./announcement-logout.tpl">
  <div class="verifymaincontainer">
	<div class="verifyzohologo"></div>
	<#if !expired?? && !aboutToExpire?? && unverified??>	      
	      <div class="verifyheadermsg"><@i18n key="IAM.USER.VERIFY.DOMAIN.HEADER"/></div>
	      <div class="verifymsgcontainer">
	      <#if unverified?size == 1>
	      <@i18n key="IAM.USER.VERIFY.DOMAIN.HEADER.MSG.SINGLE" arg0="${limited_days}"/>
	      <#else>
	      <@i18n key="IAM.USER.VERIFY.DOMAIN.HEADER.MSG.MULTIPLE" arg0="${unverified?size}" arg1="${limited_days}"/>
	      </#if>
	      </div>
	      <div class="verifydomaincontainer">
	      	<#if unverified?size == 1>
	        <div class="domainheader"><@i18n key="IAM.DOMAIN.UNVERIFIED"/></div>
	        <#else> 
	        <div class="domainheader"><@i18n key="IAM.USER.VERIFY.DOMAIN.UNVERIFIED.DOMAIN.MULTIPLE"/></div>
	        </#if>
	      	<#list unverified as domain, time>
	         	<#if domain?counter < 4 >
	         		<div class="domaincontainer">
	          			<span class="domainicon icon-Pebble"></span>
	          			<span style="display:inline-block">
	            			<div class="domaindetails">${domain}</div>
	            			<div class="domaincreated"><@i18n key="IAM.USER.CREATED.TIME.ADDED" arg0="${time}"/></div>
	           			</span>
	         		</div>
	         	</#if>
	        </#list>
	         <#if unverified?size == 4>
	          <p align="center" style="margin:15px 0px">
	           <a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains" onclick ="verifyRedirect()" ><@i18n key="IAM.USER.VERIFY.DOMAIN.MORE.UNVERIFIED.SINGLE" /></a> 
	          </p>
	         <#elseif  unverified?size gt 4 >
	          <p align="center" style="margin:15px 0px 20px 0px">
	           <a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.USER.VERIFY.DOMAIN.MORE.UNVERIFIED.MULTIPLE" arg0="${unverified?size-3}"/></a> 
	          </p>
	         </#if>
	      </div>
	      <div class="verifydomainnote">
	      <@i18n key="IAM.USER.VERIFY.DOMAIN.NOTE"/>
	      </div>
	    <a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="managedomains" onclick ="(function(e){verifyRedirect(e);e.target.classList.add('buttdisabled');e.target.querySelector('span').classList.add('loader')})(event);"><span></span><@i18n key="IAM.USER.VERIFY.DOMAIN.MANAGE.DOMAINS"/></a>
	    <a href="${Encoder.encodeHTMLAttribute(visited_url)}" onclick="(function(e){e.target.classList.add('remind_loader')})(event);" class="remindlaterdomains"><@i18n key="IAM.USER.BANNER.SKIP.FOR.NOW" /></a>
	 <#else>	 	
	 	<div class="verifyheadermsg"><@i18n key="IAM.REVERIFY.DOMAIN.ANNOUNCEMENT.HEADER"/></div>
            <div class="verifymsgcontainer">
		      <#if !expired?? && aboutToExpire?size == 1>
		      		<@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.HEADER.MSG.SINGLE" arg0="${aboutToExpire?keys[0]}"/>
		      		<div class="domainwarningheader"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.MSG"/></div>
		      <#elseif !expired?? && aboutToExpire?size gt 1>
		      		<@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.HEADER.MSG.MULTIPLE" arg0="${aboutToExpire?size}"/>
		      		<div class="domainwarningheader"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.MSG"/></div>
		      <#elseif !aboutToExpire?? && expired?size == 1>
		      		<@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.HEADER.MSG.SINGLE" arg0="${expired?keys[0]}"/>
		      		<div class="domainwarningheader"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.MSG"/></div>
		      <#elseif !aboutToExpire?? && expired?size gt 1>
		      		<@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.HEADER.MSG.MULTIPLE" arg0="${expired?size}"/>
		      		<div class="domainwarningheader"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.MSG"/></div>	      
		      <#else>
		     		 <@i18n key="IAM.REVERIFY.DOMAIN.EXPIREDANDTOBEEXPIRED.HEADER.MSG"/>
		     		 <div class="domainwarningheader"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.ABOUT.MIX.MSG"/></div>
		      </#if>		      
		      
		      <div>
		      	<ul>
			      	<li><span class="domainwarningmsg"><@i18n key="IAM.REVERIFY.DOMAIN.MSG.P1"/></span></li>
			      	<li><span class="domainwarningmsg"><@i18n key="IAM.REVERIFY.DOMAIN.MSG.P2"/></span></li>
			      	<li><span class="domainwarningmsg"><@i18n key="IAM.REVERIFY.DOMAIN.MSG.P3"/></span></li>
		      	</ul>
		      </div>
		      </div>
		      <div class="verifydomaincontainer">		      	
		      	 <#if aboutToExpire?? && !expired??>
		      	 	<#if aboutToExpire?size == 1>
				         <div class="domainheader"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.DOMAIN.SINGLE"/></div>
				   	<#else>
				    	<div class="domainheader"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.DOMAIN.MULTIPLE"/></div>
				   	</#if>		        
			         <#list aboutToExpire as domain, time>
				         <#if domain?counter < 4 >
					         <div class="domaincontainer">
					          <span class="domainicon icon-Pebble"></span>
					          <span style="display:inline-block">
					            <div class="domaindetails">${domain}</div>
					            <div class="domaincreated"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.TIME" arg0="${time}"/></div>
					           </span>
					         </div>
				         </#if>
			         </#list>		         				         
			          <p align="center" style="margin:15px 0px 20px 0px">
			          	<#if aboutToExpire?size == 4 >
			          		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.ABOUTTOEXPIRE.SINGLE" arg0="${aboutToExpire?size-3}"/></a>
			          	<#elseif aboutToExpire?size gt 4 >
			          		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.ABOUTTOEXPIRE.MULTIPLE" arg0="${aboutToExpire?size-3}"/></a>
			          	</#if> 
			          </p>
				         
			      <#elseif expired?? && !aboutToExpire??>
			      		<#if expired?size == 1>
					         <div class="domainheader"><@i18n key="IAM.DOMAIN.EXPIRED"/></div>
					   	<#else>
					    	<div class="domainheader"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.DOMAIN.MULTIPLE"/></div>
					   	</#if>			      				        
			        	<#list expired as domain, time>
				        	<#if domain?counter < 4 >
					        	<div class="domaincontainer">
					          	<span class="domainicon icon-Pebble"></span>
					          	<span style="display:inline-block">
					            <div class="domaindetails">${domain}</div>
					            <div class="domaincreated"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.TIME" arg0="${time}"/></div>
					           	</span>
					         	</div>
				         	</#if>
			         	</#list>
			         	<p align="center" style="margin:15px 0px 20px 0px">		         
				        	<#if expired?size == 4 >
				          		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.EXPIRED.SINGLE" arg0="${expired?size-3}"/></a> 				          				        
				         	<#elseif expired?size gt 4 >
				           		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.EXPIRED.MULTIPLE" arg0="${expired?size-3}"/></a> 
				         	</#if>
				        </p>
				  <#else>				  	
				  		<div class="domainheader"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.ABOUT.MIX.DOMAIN"/></div>			        
				         <#list expired as domain, time>
				         <#if domain?counter < 4 >
				         <div class="domaincontainer">
				          <span class="domainicon icon-Pebble"></span>
				          <span style="display:inline-block">
				            <div class="domaindetails">${domain}</div>
				            <div class="domaincreated"><@i18n key="IAM.REVERIFY.DOMAIN.EXPIRED.TIME" arg0="${time}"/></div>
				           </span>
				         </div>
				         </#if>
				         </#list>
				         <#list aboutToExpire as domain, time>
				         <#if domain?counter < (4-expired?size) >
				         <div class="domaincontainer">
				          <span class="domainicon icon-Pebble"></span>
				          <span style="display:inline-block">
				            <div class="domaindetails">${domain}</div>
				            <div class="domaincreated"><@i18n key="IAM.REVERIFY.DOMAIN.ABOUTTOEXPIRE.TIME" arg0="${time}"/></div>
				           </span>
				         </div>
				         </#if>
				         </#list>		         				         
				          <p align="center" style="margin:15px 0px 20px 0px">
				          	<#if (expired?size + aboutToExpire?size) == 4 >
				          		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.EXPIRED.ABOUT.MIX.SINLGE" arg0="${(expired?size + aboutToExpire?size)-3}"/></a>
				          	<#elseif (expired?size + aboutToExpire?size) gt 4 >
				          		<a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="moredomains"  onclick ="verifyRedirect()"><@i18n key="IAM.REVERIFY.DOMAIN.MORE.EXPIRED.ABOUT.MIX.MULTIPLE" arg0="${(expired?size + aboutToExpire?size)-3}"/></a>
				          	</#if> 
				          </p>
				         
				    			      	
			      </#if> 
			      
		      </div>		      
		      <a href="${Encoder.encodeHTMLAttribute(visited_url)}" class="managedomains" onclick ="(function(e){verifyRedirect(e);e.target.classList.add('buttdisabled');e.target.querySelector('span').classList.add('loader')})(event);"><span></span><@i18n key="IAM.SAMLSETUP.JIT.GO.TO.DOMAINS"/></a>
		      <a href="${Encoder.encodeHTMLAttribute(visited_url)}" onclick="(function(e){e.target.classList.add('remind_loader')})(event);" class="remindlaterdomains"><@i18n key="IAM.TFA.BANNER.REMIND.LATER" /></a>
	 </#if>
  </div>
  </body>
</html>
