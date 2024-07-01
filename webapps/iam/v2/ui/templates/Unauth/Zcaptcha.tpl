	<div id="zlabs_captcha_container" class="hide">
		
		
		<#include "../zoho_line_loader.tpl">
		
		
		
		<div class="ZCaptcha_desc">
			<div class="slide_desc hide"><@i18n key="IAM.SLIDE.CAPCTHA.DESC"/></div>
			<div class="options_desc hide"><@i18n key="IAM.OPTIONS.CAPCTHA.DESC"/></div>
			<div class="audio_desc hide"><@i18n key="IAM.AUDIO.CAPCTHA.DESC"/></div>
		</div>
		
		<div id="loader">
			<div class="aaloader"></div>
		</div>
		
		<div class="Z_captcha_result_container hide">
			
			<div class="Z_captcha_success">
				
				<div class="succ_icon">
					<div class="success_tick"> <span class="white_tick"></span> </div>
					<div class="tick_beat"></div>
				</div>
				
				<div class="Z_captcha_success_msg"><@i18n key="IAM.CAPCTHA.VERIFIED"/></div>
			</div>
			
		</div>
		
		<div class="Z_captcha_error_container hide">
			
				<div class="reject_icon"><span class="reject-red-circle"></span></div>
				<div class="Z_captcha_reject_header hide"></div>
				<div class="Z_captcha_error_msg"></div>
			
		</div>
		
		<div class="img" id="imgdiv">
			
			<div class="background">
				<img id="background">
				<div class="shine_container"> <div class="shine_cover"></div> </div>
				<div class="hide Zcaptcha_error"></div>
			</div>
			
			<div class="slide">
				<img id="imgslide">
				
				
				<div class="zlabs_slide">
					<div class="slider">
						<input type="range" oninput="enable_captcha_submit()" min="1" max="350" value="0" class="slider" id="slider">
					</div>
				</div>
				
				
			</div>
			
			<div class="option">
			
			<div class="capctha_options1">
					
						
					<div class="radio">
						<input class="option_radiobtn"  type="radio"  onchange="enable_captcha_submit()" name="radio" id="op1">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
						<label for="op1" class="radio__label" id="label-op1"><label>
					</div> 
					
					
					<div class="radio">
						<input class="option_radiobtn"  type="radio"  onchange="enable_captcha_submit()" name="radio" id="op2">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
						<label for="op2" class="radio__label" id="label-op2"><label>
					</div> 
				
				</div>
				
				<div class="capctha_options1">
				
					<div class="radio">
						<input class="option_radiobtn"  type="radio"  onchange="enable_captcha_submit()" name="radio" id="op3">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
						<label for="op3" class="radio__label" id="label-op3"><label>
					</div> 
					
					
					<div class="radio">
						<input class="option_radiobtn"  type="radio"  onchange="enable_captcha_submit()" name="radio" id="op4">
							<div class="outer_circle">
								<div class="inner_circle"></div>
							</div>
						<label for="op4" class="radio__label" id="label-op4"><label>
					</div> 
						
				</div>
				
			</div>
			
		</div>
		
		<div class="audio">
			<div id="aloader">
						<div class="aaloader"></div>
			</div>
			
			<div class="audio_content"><@i18n key="IAM.AUDIO.CAPCTHA.INFO" /></div>
		
			<div class="audio_play_area">
				<div class="audio_bar">
				</div>
				<div class="play_cover" onclick="play_audio(event);">
					<div id="play" class="Captchaicon-Playbutton"></div>
				</div>
			</div>
			
			<input type="number"  oninput="enable_captcha_submit()"; id="aoption" placeholder="<@i18n key="IAM.AUDIO.CAPCTHA.INPUT.DESC" />" class="textbox" required="">
			
			<div class="hide Zcaptcha_error"></div>
		</div>
		
		
		<div class="Captcha_btns">
			
			<div class="captcha_icons">
				<span class="refresh_captcha Captchaicon Captchaicon-Refresh" title="<@i18n key="IAM.CAPCTHA.REFRESH" />" onclick="showZLabsCaptcha(undefined,true);"> </span>
				<span class="img_captcha Captchaicon Captchaicon-Image" title="<@i18n key="IAM.TRY.IMAGE" />" onclick="showZLabsCaptcha(false,true);"> </span>
				<span class="audio_captcha Captchaicon Captchaicon-Audio" title="<@i18n key="IAM.TRY.AUDIO" />" onclick="showZLabsCaptcha(true,true);"> </span>
			</div>
			
			<button type="submit" disabled="disabled" onclick="return accountLookup(event);" id="z_capctha_submit" class="blue Captcha_btnblue" ><span><@i18n key="IAM.VERIFY"/></span></button>
			
		</div>
		
		<div id="asubmit" style="display: none;"><@i18n key="IAM.NEXT"/></div>
												
	</div>
	
									
	