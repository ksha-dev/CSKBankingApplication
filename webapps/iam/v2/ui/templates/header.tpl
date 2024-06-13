	<div class="ztopbar">
		<span class="showallservices">
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
			<span class="smallboxes"></span>
		</span>
		<span class="showallmenu_formobile">
			<span class="small_line"></span>
			<span class="small_line"></span>
			<span class="small_line"></span>
		</span>		
		<#if (isZohoDomain)>
			<span class="icon-NewZoho zoho_topbar_logo">
				<span class="path1"></span>
				<span class="path2"></span>
				<span class="path3"></span>
				<span class="path4"></span>
				<span class="path5"></span>
			</span>
			<span class="accounts_heading"><@i18n key="ZOHO.AaaServer.DISP"/></span>
		<#else>
			<span class="zoho_logo zoho_topbar_logo"></span>
		</#if>		
		<span class="topbar_pp">
			<div class="headder_thumb_pic_blur_bg" style="background-image:url('${photoID}')" ></div>
			<img class="top_bar_pic" onload="setPhotoSize(this)" id="headder_thumb_pic" onerror="this.src='${SCL.getStaticFilePath("/v2/components/images/user_2.png")}';" src="${photoID}" />
		</span>
    		</div>
    	</div>
	
	
	
	
	