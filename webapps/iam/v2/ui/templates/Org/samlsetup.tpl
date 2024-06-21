

			<div class="box big_box" id="saml_box">
			
					<div class="box_blur"></div>
					<div class="loader"></div>
					
					<div class="box_info">
						<div class="saml-header__left">
							<div class="box_head saml_innerbox_head"><@i18n key="IAM.SAMLSETUP.PAGE.TITLE" /> </div>
							<span class="togglebtn_div saml-enable_btn-div hide" id="saml_activated">
								<input class="real_togglebtn"  id="toggle_saml" onchange="return updateSamlStatus((document.samlviewform))" type="checkbox" >								
								<div class="togglebase">
									<div class="toggle_circle"></div>
								</div>	
							</span>
							<div class="box_discrption"><@i18n key="IAM.SAMLSETUP.PAGE.SUBTITLE" /></div>
						</div>
							<div class="saml-header__right">
								<div class="saml-download_btn" onclick="showSamlDownloadDropDown()"><span class="icon-download"></span><@i18n key="IAM.DOWNLOAD.APP" /><span class="downward-arrow"></span></div>
								<div class="saml-download_lists">
									<a class="download-list-item" href="${za.contextpath}/accounts/samlsp/metadata"><@i18n key="IAM.SAML.METADATA" /></a>
									<a class="download-list-item info-download-publickey" href="${za.contextpath}/accounts/samlsp/certificate"><@i18n key="IAM.SAMLSETUP.INFO.DOWNLOAD.PUBLICKEY" /></a>
								</div>
							</div>
					</div>
					
					<#if !(is_org_user	&&	 is_org_admin)>
					
						<div class="no_data no_data_SQ"></div>
						<div class="no_data_text"><@i18n key="IAM.RESERVE.UNAUTHORIZED.ACCESS" />  </div>
					
					<#else>
					
						<div id="saml_notActivated" class="box_content_div hide">
							<div class="no_data"></div>
							<div class="no_data_text saml-configure-message"></div>
							<div class="saml-btn">
								<button class="primary_btn_check" id="setupsaml"onclick="showSamlsetupMenu()" id="allowedip_change"><span><@i18n key="IAM.BTNMSG.SETUP.NOW" /> </span></button>
								<a class="primary_btn_check download_meta_btn" id="metadata_download" href="${za.contextpath}/accounts/samlsp/metadata"><span class="icon-download"></span><@i18n key="IAM.SAML.DOWNLOAD.METADATA" /> </a>
							</div>
						</div>
						
						
						
						<div class="saml_info hide" id="saml_info_show">
							
							<div class="saml_div_aligner">
									<div class="info_div">
										<div class="info_lable"><@i18n key="IAM.SAMLSETUP.LOGIN.URL" /> </div>
										<div class="info_value" id="login_url"></div>
									</div>	
									<div class="info_div">
										<div class="info_lable"><@i18n key="IAM.SAMLSETUP.LOGOUT.URL" /></div>
										<div class="info_value" id="logout_url"></div>
										<div class="saml_response_downlaod icon-download" id="downalod_logout_response">
											<a class="saml_download " href="/accounts/samlsp/certificate"><@i18n key="IAM.SAML.LOGOUT_RESPONSE" /> </span></a>
										</div>
									</div>	
									
									
									
									<div class="info_div">
										<div class="info_lable"><@i18n key="IAM.SAMLSETUP.CHANGE.PASSWORD.URL" /> </div>
										<div class="info_value" id="password_url" ></div>
									</div>		
									<div class="info_div">
										<div class="info_lable"><@i18n key="IAM.SAMLSETUP.ALGORITHM" /> </div>
										<div class="info_value" id="saml_algorithm" ></div>
									</div>	
									<div class="info_div">
										<div class="info_lable"><@i18n key="IAM.SAMLSETUP.SERVICE.NAME" /> </div>
										<div class="info_value" id="SAMLservice_name"></div>
									</div>
								</div>
								
								<div class="info_div hide" id="SAML_JIT_indicator">
									<div class="info_value"><@i18n key="IAM.SAML.JIT.DEACTIVATED" /></div>
								</div>
									
								<a class="primary_btn_check " id="setsaml" href="${za.contextpath}/accounts/samlsp/metadata"><@i18n key="IAM.SAML.DOWNLOAD.METADATA" /> </span></a>
								<button class="primary_btn_check " onclick="showSamlEditOption()"><span><@i18n key="IAM.EDIT" /> </span></button>
								<button class="primary_btn_check negative_btn_red" onclick="deleteSaml('<@i18n key="IAM.CONFIRM.POPUP.DELETE.SAML" />','<@i18n key="IAM.SAML.SETUP.DELETE.CONFIRMATION" />')"><span><@i18n key="IAM.DELETE" /></span></button>

						</div>
					
					<div class="saml-setup_info hide">
						<div class="info-list">
							<div class="info-list-item info-signin-url">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.LOGIN.URL" /></div>
								<div class="info-value info_sign-url"></div>
							</div>
							<div class="info-list-item info-signout-url">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.LOGOUT.URL" /></div>
								<div class="info-value info_sign-url"></div>
							</div>
							<div class="info-list-item info-zoho-service">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.SERVICE.NAME" /></div>
								<div class="info-value"></div>
							</div>
							<div class="info-list-item info-name-identifier">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.NAME.IDENTIFIER" /></div>
								<div class="info-value"></div>
							</div>
							<div class="info-list-item info-parameters">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.MODE.PARAMETER.HEADER" /></div>
								<div class="info-value"></div>
							</div>
							<div class="info-list-item info-request-encryption">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.REQUEST.ENCRYPTION.HEADER" /></div>
								<div class="info-value"></div>
							</div>
							<div class="info-list-item info-sign-out">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.SINGLE.LOGOUT.RESPONSE" /></div>
								<div class="info-value"></div>
							</div>
							<div class="info-list-item info-jit">
								<div class="info-lable"><@i18n key="IAM.SAMLSETUP.JIT.HEADER" /></div>
								<div class="info-value"></div>
							</div>
						</div>
						<div class="saml-info-btns">
							<button class="primary_btn_check " onclick="showEditSamlsetupMenu()"><@i18n key="IAM.EDIT" /></button>
							<button class="primary_btn_check negative_btn_red" onclick="deleteSamlsetup('<@i18n key="IAM.CONFIRM.POPUP.DELETE.SAML" />','<@i18n key="IAM.SAML.SETUP.DELETE.CONFIRMATION" />')"><@i18n key="IAM.DELETE" /></button>
						</div>
						<div class="saml-header__right saml-mb-view">
								<div class="saml-download_btn" onclick="showSamlDownloadDropDown()"><span class="icon-download"></span><@i18n key="IAM.DOWNLOAD.APP" /><span class="downward-arrow"></span></div>
								<div class="saml-download_lists">
									<a class="download-list-item" href="${za.contextpath}/accounts/samlsp/metadata"><@i18n key="IAM.SAML.METADATA" /></a>
									<a class="download-list-item info-download-publickey" href="${za.contextpath}/accounts/samlsp/certificate"><@i18n key="IAM.SAMLSETUP.INFO.DOWNLOAD.PUBLICKEY" /></a>
								</div>
						</div>	
					</div>
					
					
						<div class="hide saml_opendiv popup" tabindex="0" id="saml_open_cont">
									
							<div class="popup_header">
									<div class="close_btn" onclick="close_SAML_edit()"></div>
									<div class="popuphead_text"><@i18n key="IAM.SAMLSETUP.PAGE.TITLE" /> </div>
							</div>					
							<div id="saml_set" class="saml_setup">							
								<form name="samlform" method="post" id="samlform" onsubmit="return false"  target="uploadaction1" enctype="multipart/form-data">
																			
										<div class="field">
											<div class="textbox_label"><@i18n key="IAM.SAMLSETUP.LOGIN.URL" /> </div>
											<input type="text" onkeypress="remove_error();" id="edit_login_url" type="text" data-validate="zform_field" name="login_url" class="textbox">
										</div>
										
										<div class="field">
											<div class="textbox_label"><@i18n key="IAM.SAMLSETUP.LOGOUT.URL" /> </div>
											<input type="text" data-optional="true" onkeypress="remove_error();" id="edit_logout_url" type="text" data-validate="zform_field" name="logout_url" class="textbox">
										</div>
										
										<div class="checkbox_div">
											<input class="checkbox_check" id="saml_logout_check" onchange="return change_logout_response()" data-validate="zform_field" name="enable_saml_logout" type="checkbox">
											<span class="checkbox">
												<span class="checkbox_tick"></span>
											</span>
											<label for="saml_logout_check" class="checkbox_label"><@i18n key="IAM.SAML.SETUP.ENABLE.SAML.LOGOUT" /> </label>
										</div>
										
										<div class="field">
											<div class="textbox_label "><@i18n key="IAM.SAMLSETUP.CHANGE.PASSWORD.URL" /> </div>
											<input type="text" data-optional="true" onkeypress="remove_error();" id="edit_password_url" data-validate="zform_field" name="password_url" class="textbox" />
										</div>
										
										<div class="field">
											<div class="textbox_label "><@i18n key="IAM.SAML.SETUP.PUBLICKEY" /> </div>
											<input type="text" onkeypress="remove_error();" data-validate="zform_field" name="publickey" id="saml_publickey" class="textbox" placeholder="<@i18n key="IAM.SAML.ENTER.UPLOAD.PUBLIC.KEY"/>"/>
											<span id="saml_file_space" class="hide">
												<input type="text" onkeypress="remove_error();" onclick="changebacktotext()" id="saml_filename" name="saml_filename" class="textbox "  readonly/>
											</span>
											<input type="file" id="saml_publickey_upload" data-validate="zform_field" name="publickey__upload" style="display: none;">
											<button type="button" class="browse_btn icon-upload"  onclick="samlPublicKeyOption(false)"/></button>
										</div>
										
										<div class="field">
											<div class="textbox_label "><@i18n key="IAM.SAMLSETUP.ALGORITHM" /> </div>
											<select data-validate="zform_field" id="edit_saml_algorithm" name="algorithm" class="saml_select customised_select">
												<option value="RSA" ><@i18n key="IAM.SAML.RSA" /> </option>
												<option value="DSA" ><@i18n key="IAM.SAML.DSA" /> </option>
											</select>
										</div>
										
										<div class="field">
											<div class="textbox_label selectLabelArrow"><@i18n key="IAM.SAMLSETUP.SERVICE.NAME" /> </div>
											<select data-validate="zform_field" id="edit_SAMLservice_name" name="service" class="saml_select customised_select">
											
												<#list services as formats>
				                          			<option value="${formats.servicename}" id="${formats.servicename}" >${formats.displayname}</option>
				                           		</#list>
	                           		
											</select>
										</div>
										
										<div class="checkbox_div">
											<input class="checkbox_check" id="saml_jit_check" data-validate="zform_field" onchange="return show_jit_fields()" name="enable_saml_jit" type="checkbox">
											<span class="checkbox">
												<span class="checkbox_tick"></span>
											</span>
											<label for="saml_jit_check" class="checkbox_label"><@i18n key="IAM.SAML.AUTOPROVISIONING" /> </label>
										</div>
										
										<div class="saml_JIT_fields hide" id="saml_JIT_fields">
										
										</div>
									
										<div class="pop_up_overflow_btn">
											<button class="primary_btn_check " id="setsaml" onclick="updateSaml(document.samlform)"><span><@i18n key="IAM.CONFIGURE" /> </span></button>
											<button class="primary_btn_check high_cancel" onclick="return close_SAML_edit()"><span><@i18n key="IAM.CLOSE" /> </span></button>
										</div>
									
									
								</form>
								
							</div>
							
						</div>

						<div class="saml-setup_menu" tabindex="1" id="saml-setup_menu">
							<div class="saml-setup__header">
								<div class="close_btn" onclick="closeSamlsetupMenu()"></div>
								<div class="popuphead_text"><@i18n key="IAM.SAMLSETUP.MENU.PAGE.TITLE" /> </div>
							</div>
							<div class="saml-setup__body">
								<div class="saml-setup__messages">
									<div class="saml-setup__upload-message">
										<span class="saml_message">
											<div class="saml_message_head"><@i18n key="IAM.SAMLSETUP.UPLOAD.METADATA" /></div>
											<div class="saml_message_description"><@i18n key="IAM.SAMLSETUP.METADATA.DESCRIPTION" /></div>
										</span>
										<span class="saml-upload-metadata">
											<label for="saml-upload-input">
												<input type="file" id='saml-upload-input' style="display: none;">
												<div class="upload-metadata-btn"><span class="icon-upload"></span><@i18n key="IAM.SAMLSETUP.UPLOAD.METADATA" /></div>
											</label>
										</span>	
									</div>
									<div class="saml-setup__update-message">
										<span class="saml-success__circle">
											<span class="circle-tick"></span>
										</span>
										<span class="saml_message">
											<div class="saml_message_head"></div>
											<div class="saml_message_description"><@i18n key="IAM.SAMLSETUP.UPDATE.METADATA.DESCRIPTION" /></div>
										</span>
										<span class="saml-metadata-action">
											<span class="saml-change-metadata" onclick="getMetadata()"><@i18n key="IAM.SAMLSETUP.CHANGE.METADATA" /></span>
											<span class="saml-remove-metadata" onclick="removeMetadata();"><@i18n key="IAM.REMOVE" /></span>
										</span>	
									</div>
								</div>
								<form id="saml-setup__form-container" method="post" class="saml-setup__form-container" onsubmit="return false;">
									<div class="saml-setup__forms">
										<div name="saml-setup-form" id="saml-setup-form" class="saml-form">
											<div class="field">
													<div class="textbox_label"><@i18n key="IAM.SAMLSETUP.LOGIN.URL" />
														<span class="mandate_field_star">&#42;</span>
														<span class="saml-signin__lists">
															<select class="saml-signin__list isSamlEdited" onchange= "getPostchange();" name="login_binding">
																<option value="GET" id-value="0"><@i18n key="IAM.SAMLSETUP.GET" /></option>
																<option value="POST" id-value="1"><@i18n key="IAM.SAMLSETUP.POST" /></option>
															</select>
														</span>  
													</div>
													<input type="text" oninput="remove_error();" maxlength="50000" name="login_url" placeholder="https://" class="textbox saml-login-url isSamlEdited">
											</div>
											<div class="field">
													<div class="textbox_label post-dropdown-parent"><@i18n key="IAM.SAMLSETUP.LOGOUT.URL" />
														<span class="saml-signin__lists">
															<select class="saml-signout__list isSamlEdited" onchange= "getPostchange();" name="logout_binding">
																<option value="GET" id-value="0"><@i18n key="IAM.SAMLSETUP.GET" /></option>
																<option value="POST" id-value="1"><@i18n key="IAM.SAMLSETUP.POST" /></option>
															</select>
														</span>  
													</div>
													 
													<input type="text" oninput="remove_error();" maxlength="50000" name="logout_url" placeholder="https://" class="textbox saml-logout-url isSamlEdited">
											</div>
											<div class="field">
													<div class="textbox_label"><@i18n key="IAM.SAMLSETUP.SERVICE.NAME" /> </div>
													<select id="edit-SAMLservice_name" name="service" class="saml_select customised_select isSamlEdited">
													
														<#list services as formats>
						                          			<option value="${formats.servicename}" id="${formats.servicename}" >${formats.displayname}</option>
						                           		</#list>
			                           		
													</select>
											</div>
											<div class="field">
													<div class="textbox_label selectLabelArrow"><@i18n key="IAM.SAMLSETUP.NAME.IDENTIFIER" /></div>
													<select class="saml-name-identifier customised_select isSamlEdited" name="saml_name_identifier">
														<option value="email-address" id-value="1" selected><@i18n key="IAM.EMAIL.ADDRESS" /></option>
														<option value="unspecified" id-value="0"><@i18n key="IAM.SAMLSETUP.IDENTIFIER.UNSPECIFIED" /></option>
														<option value="windows-domain-qualifiedname" id-value="3"><@i18n key="IAM.SAMLSETUP.IDENTIFIER.WINDOWS.DOMAIN" /></option>
													</select>
											</div>
											<div class="field">
													<div class="textbox_label "><@i18n key="IAM.SAML.SETUP.PUBLICKEY" /><span class="mandate_field_star">&#42;</span> </div>
													<input type="text" oninput="removePublickeyError();" name="publickey" maxlength="10000" id="saml-publickey" class="textbox saml-publickey isSamlEdited" placeholder="<@i18n key="IAM.SAML.ENTER.UPLOAD.PUBLIC.KEY"/>"/>
													<span id="saml-file_space" class="hide">
														<input type="text" oninput="remove_error();" onclick="changebacktotext()" id="saml-filename" name="saml-filename" class="textbox "  readonly/>
													</span>
													<span class="close-circle publickey-remove-btn hide" onclick="removePublicKey()"></span>
													<button type="button" class="browse_btn icon-upload"  onclick="samlPublicKeyOptionUpload()"/></button>
													<input type="file" oninput="removePublickeyError();" class="saml-publickey_upload isSamlEdited" id="saml-publickey_upload" name="publickey_upload" style="display: none;">
													<div class="textbox_label publickey-filetype__text"><@i18n key="IAM.SAMLSETUP.CERTIFICATE.FILE.TYPE" /></div>
											</div>
										</div>
									</div>
									<div class="saml-setup__modes" name="saml-setup__modes">
											<div class="saml-setup__mode">
												<label id="sign-param" onclick="showSamlSetupModeFields(this);" class="saml-setup__mode-label">
													<div class="mode_message">
														<div class="mode_header"><@i18n key="IAM.SAMLSETUP.MODE.PARAMETER.HEADER" /></div>
														<div class="mode_description"><@i18n key="IAM.SAMLSETUP.MODE.PARAMETER.DESCRIPTION" /></div>
													</div>
													<div class="togglebtn_div">
														<input class="real_togglebtn param-btn isSamlEdited" type="checkbox" name="samlParambtn">
														<div class="togglebase">
															<div class="toggle_circle"></div>
														</div>	
													</div>
												</label>
												<div class="mode-param-fields">
													<div id="saml_signin__param" class="saml-sign__param">
															<div class="param__header"><@i18n key="IAM.SAMLSETUP.SIGNIN.PARAMETERS" /></div>
															<div class="param-fields">
																<div class="param-field">
																	<div class="param-field_left field">
																		<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.VALUE" /></label>
																		<select class="select_field params_select" onchange="updateSignparamInputName(this)">
																			<option value="userName"><@i18n key="IAM.GENERAL.USERNAME" /></option>
																			<option value="emailAddress"><@i18n key="IAM.EMAIL.ADDRESS" /></option>
																		</select>
																	</div>
																	<div class="param-field_right field">
																		<label class="textbox_label"><@i18n key="IAM.NAME" /></label>
																		<input type="text" class="textbox" oninput="remove_error();" placeholder="<@i18n key="IAM.SAMLSETUP.SIGN.PARAMETER.PLACEHOLDER" />" maxlength="30" name="saml_signin__param_userName">
																		<div class="add-circle" onclick="newAddSignParamField(this);"></div>
																	</div>
																</div>
															</div>
													</div>
													<div id="saml_signout__param" class="saml-sign__param">
															<div class="param__header"><@i18n key="IAM.SAMLSETUP.SIGNOUT.PARAMETERS" /></div>
															<div class="param-fields">
																<div class="param-field">
																	<div class="param-field_left field">
																		<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.VALUE" /></label>
																		<select class="select_field params_select" onchange="updateSignparamInputName(this)">
																			<option value="userName"><@i18n key="IAM.GENERAL.USERNAME" /></option>
																			<option value="emailAddress"><@i18n key="IAM.EMAIL.ADDRESS" /></option>
																		</select>
																	</div>
																	<div class="param-field_right field">
																		<label class="textbox_label"><@i18n key="IAM.NAME" /></label>
																		<input type="text" class="textbox" oninput="remove_error();" placeholder="<@i18n key="IAM.SAMLSETUP.SIGN.PARAMETER.PLACEHOLDER" />" maxlength="30" name="saml_signout__param_userName">
																		<div class="add-circle" onclick="newAddSignParamField(this);"></div>
																	</div>
																</div>
															</div>
													</div>
												</div>
											</div>
											<div class="saml-setup__mode">
												<label id="saml-encryption" onclick="showSamlSetupModeFields(this);" class="saml-setup__mode-label">
													<div class="mode_message">
														<div class="mode_header"><@i18n key="IAM.SAMLSETUP.REQUEST.ENCRYPTION.HEADER" /></div>
														<div class="mode_description"><@i18n key="IAM.SAMLSETUP.REQUEST.ENCRYPTION.DESCRIPTION" /></div>
													</div>
													<div class="togglebtn_div">
														<input class="real_togglebtn saml-encryp-btn isSamlEdited" type="checkbox" name="saml-encryp-btn">
														<div class="togglebase">
															<div class="toggle_circle"></div>
														</div>	
													</div>
												</label>
												<div class="saml-encryp__request hide">
													<span class="saml-encryp__download">
														<@i18n key="IAM.SAMLSETUP.REQUEST.ENCRYPTION.LINK" arg0="${za.contextpath}/accounts/samlsp/certificate"/>
													</span>
												</div>
											</div>
											<div class="saml-setup__mode">
												<label id="saml-generate-key" class="saml-setup__mode-label">
													<div class="mode_message">
														<div class="mode_header"><@i18n key="IAM.SAMLSETUP.GENERATE.KEY.HEADER" /></div>
														<div class="mode_description"><@i18n key="IAM.SAMLSETUP.GENERATE.KEY.DESCRIPTION" /></div>
														<div class="mode_description mode_sub-description"><@i18n key="IAM.SAMLSETUP.GENERATE.KEY.SUBDESCRIPTION" /></div>
													</div>
													<div class="togglebtn_div">
														<input class="real_togglebtn idp-response isSamlEdited" type="checkbox" name="idp-response">
														<div class="togglebase">
															<div class="toggle_circle"></div>
														</div>	
													</div>
												</label>
											</div>
											<div class="saml-setup__mode">
												<label id="saml-signout-response" class="saml-setup__mode-label">
													<div class="mode_message">
														<div class="mode_header"><@i18n key="IAM.SAMLSETUP.SINGLE.LOGOUT.RESPONSE" /></div>
														<div class="mode_description"><@i18n key="IAM.SAMLSETUP.SINGLE.LOGOUT.RESPONSE.DESCRIPTION" /></div>
													</div>
													<div class="togglebtn_div">
														<input class="real_togglebtn signout-response isSamlEdited" type="checkbox" name="signout-response">
														<div class="togglebase">
															<div class="toggle_circle"></div>
														</div>	
													</div>
												</label>
											</div>
											<div class="saml-setup__mode">
												<div>
													<label id="saml-jit" onclick="showSamlSetupModeFields(this);" class="saml-setup__mode-label">
														<div class="mode_message">
															<div class="mode_header"><@i18n key="IAM.SAMLSETUP.JIT.HEADER" /></div>
															<div class="mode_description"><@i18n key="IAM.SAMLSETUP.JIT.DESCRIPTION" /></div>
														</div>
														<div class="togglebtn_div">
															<input class="real_togglebtn saml-JIT-btn isSamlEdited" type="checkbox" name="saml-JIT-btn">
															<div class="togglebase">
																<div class="toggle_circle"></div>
															</div>	
														</div>
													</label>
													<div class="saml-setup__JITs">
														<div class="saml-setup__JIT">
															<div class="JIT-field__left">
																<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.JIT.ORG.ATTRIBUTE" /></label>
																<select class="saml-setup__JIT-select" onchange="updateJitSelectOption(this);">
																	<option value="first_name"><@i18n key="IAM.FIRST.NAME" /></option>
																	<option value="last_name"><@i18n key="IAM.LAST.NAME" /></option>
																	<option value="display_name"><@i18n key="IAM.GENERAL.DISPLAYNAME" /></option>
																</select>
															</div>
															<div class="JIT-field__right">
																<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.JIT.IDP.ATTRIBUTE" /></label>
																<input type="text" name="jit_first_name" maxlength="200" class="textbox" placeholder="<@i18n key="IAM.SAMLSETUP.JIT.PLACEHOLDER" />">
																<div class="add-circle" onclick="newAddJitField();"></div>
																<div class="close-circle" onclick="newRemoveJitField(this);"></div>
															</div>
														</div>
													</div>
												</div>
												<div class="mode_description_warning">
													<span class="icon-warningfill" ></span>
													<span class="warning_message1"><@i18n key="IAM.SAMLSETUP.JIT.WARNING.MESSAGE1" arg0="${domainsAddHelpLink}"/></span>
													<span class="warning_message2"><@i18n key="IAM.SAMLSETUP.JIT.WARNING.MESSAGE2" /> <span class="move-to-domain_link" onclick="showOrgDomains();"><@i18n key="IAM.SAMLSETUP.JIT.GO.TO.DOMAINS" /></span></span>
												</div>
											</div>
									</div>
								<div class="saml-setup__footer">
									<div class="saml-setup_buttons">
										<button class="primary_btn_check submitSamlBtn" type="submit" tabindex="1" onclick="return submitSamlsetupMenu();"><span><@i18n key="IAM.SUBMIT" /> </span></button>
										<button class="primary_btn_check high_cancel " onclick="return closeSamlsetupMenu();"><span><@i18n key="IAM.CANCEL" /> </span></button>
									</div>
								</div>
							</form>
							<div class="hide">
								<div id="empty-saml-sign__param">
									<div class="param-field">
										<div class="param-field_left field">
											<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.VALUE" /></label>
											<select class="select_field params_select" onchange="updateSignparamInputName(this)">
												<option value="userName"><@i18n key="IAM.GENERAL.USERNAME" /></option>
												<option value="emailAddress"><@i18n key="IAM.EMAIL.ADDRESS" /></option>
											</select>
										</div>
										<div class="param-field_right field">
											<label class="textbox_label">Name</label>
											<input type="text" oninput="remove_error();" class="textbox" maxlength="30" placeholder="<@i18n key="IAM.SAMLSETUP.SIGN.PARAMETER.PLACEHOLDER" />">
											<div class="add-circle" onclick="newAddSignParamField(this);"></div>
										</div>
									</div>
								</div>
								<div id="empty-saml-setup__JIT">
									<div class="saml-setup__JIT">
										<div class="JIT-field__left">
											<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.JIT.ORG.ATTRIBUTE" /></label>
												<select class="saml-setup__JIT-select" onchange="updateJitSelectOption(this);">
													<option value="first_name"><@i18n key="IAM.FIRST.NAME" /></option>
													<option value="last_name"><@i18n key="IAM.LAST.NAME" /></option>
													<option value="display_name"><@i18n key="IAM.GENERAL.DISPLAYNAME" /></option>
												</select>
										</div>
										<div class="JIT-field__right">
											<label class="textbox_label"><@i18n key="IAM.SAMLSETUP.JIT.IDP.ATTRIBUTE" /></label>
											<input type="text" name="jit_first_name" maxlength="200" class="textbox" placeholder="<@i18n key="IAM.SAMLSETUP.JIT.PLACEHOLDER" />">
											<div class="add-circle" onclick="newAddJitField();"></div>
											<div class="close-circle" onclick="newRemoveJitField(this);"></div>
										</div>
									</div>
								</div>
							</div>
							
									
						</div>
						
						
														
						<div class="hide" id="empty_jit_fields_format">
						
							<div class="field">
								
								<select onchange="inputName(this)" class="saml_jit_select">
									<option value="first_name" ><@i18n key="IAM.FIRST.NAME" /></option>
									<option value="last_name" ><@i18n key="IAM.LAST.NAME" /></option>
									<option value="display_name" ><@i18n key="IAM.GENERAL.DISPLAYNAME" /></option>
								</select>
								
								<div class="inputText">
									<input type="text" class="textbox namebox" value="" placeholder=''/>
								</div>
								
							</div>
							
						
						</div>
											
					</#if>
					
				</div>
				
				<script>
					var i18nSamlsetupKeys = {
	    				"IAM.TFA.ENABLED" : '<@i18n key="IAM.TFA.ENABLED" />',
						"IAM.MFA.MODE.DISABLED" : '<@i18n key="IAM.MFA.MODE.DISABLED" />',
						"IAM.SAMLSETUP.INVALID.METADATA.FILE":'<@i18n key="IAM.SAMLSETUP.INVALID.METADATA.FILE" />',
						"IAM.SAML.ERROR.INVALID.METADATA":'<@i18n key="IAM.SAML.ERROR.INVALID.METADATA" />',
						"IAM.SAMLSETUP.INVALID.CERTIFICATE.FILE":'<@i18n key="IAM.SAMLSETUP.INVALID.CERTIFICATE.FILE" />',
						"IAM.SAMLSETUP.SIGN.VALID.URL":'<@i18n key="IAM.SAMLSETUP.SIGN.VALID.URL" />',
						"IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED":'<@i18n key="IAM.USER.ERROR.SPECIAL.CHARACTERS.NOT.ALLOWED" />'
					};
					var formValueToSamlDataValue = {
						"login_url":"saml_login_url",
						"login_binding":"login_binding",
						"logout_url":"saml_logout_url",
						"logout_binding":"logout_binding",
						"service":"saml_service",
						"saml_name_identifier":"name_identifier",
						"samlParambtn":"",
						"saml-encryp-btn":"is_signature_enabled",
						"idp-response":"has_sp_certificate",
						"signout-response":"is_saml_logout_enabled",
						"saml-JIT-btn":"issaml_jit_enabled",
						"saml_signin__param_userName":"login_params.ZLOGINID",
						"saml_signin__param_emailAddress":"login_params.ZEMAIL",
						"saml_signout__param_userName":"logout_params.ZLOGINID",
						"saml_signout__param_emailAddress":"logout_params.ZEMAIL",
						"jit_first_name":"first_name",
						"jit_last_name":"last_name",
						"jit_display_name":"display_name"
					};
					window.onclick = function(event) {
						if (!event.target.matches('.saml-download_btn') && !event.target.parentElement.matches('.saml-download_btn')) {
							$(".saml-download_lists").hide();
						}
					}
				</script>	
					
					
											
											