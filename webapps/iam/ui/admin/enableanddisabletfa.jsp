<%-- $Id$ --%>
<%@ include file="includes.jsp" %>
<div class="maincontent">
    <div class="menucontent">
	<div class="topcontent"><div class="contitle">Manage Two Factor Authentication</div></div> <!-- No i18N -->
	<div class="subtitle">Manage TFA for users</div> <%-- No I18N --%>
    </div>
     <div class="field-bg" style="padding: 10px;">
     <div>
     <div id="enabletfaheader" class="tfafield-header tfasel" onclick="switchTFAClass(this)">Enable and Disable TFA</div> <%-- No I18N --%> 
     <div id="resettfaheader" class="tfafield-header" onclick="switchTFAClass(this)">Reset TFA</div> <%-- No I18N --%>
     <div id="smsstatusheader" class="tfafield-header" onclick="switchTFAClass(this)">SMS Status</div> <%-- No I18N --%> 
     <div id="generateRecoveryCodeheader" class="tfafield-header">Generate Recovery Code </div><br><%-- No I18N --%>
    	 <div id="genrecoveryredirect"></div>   <!-- No I18N --><%--No I18N--%>
    	 <div id="genrecoverylink" style="color:blue;"></a></div>
    	 <%boolean isRedirectEnabled = Boolean.parseBoolean(AccountsConfiguration.getConfiguration("aoc.generaterecovery.redirect", "false"));
    	   %>
 		<script> de("generateRecoveryCodeheader").addEventListener('click', function() {        
	    if (<%=isRedirectEnabled%>) {
	    	generateRecoveryCode('<%= IAMEncoder.encodeHTMLAttribute(AccountsConfiguration.getConfiguration("aoc.server.url", null) + "/admin#user/approvals") %>');
        } else {
        	switchTFAClass(this);
        }
    });
	     </script>
     <div style="clear:both;"></div>
     </div>
     
     <div id="enabletfa" class="tfafield-body" style="display:;">
     <div class="labelkey">Email ID or zuid :</div> <%-- No I18N --%> 
     <div class="labelvalue"><input type="text" id="useremail" class="input" autocomplete="off"/></div>
     <div class="labelkey">Option : </div> <%-- No I18N --%> 
     <div class="labelvalue">
     <input type="radio" name="changeprefradio" value="1" id="enable" checked/>
     <label for="enable">Enable</label> <!-- No i18N -->
     <input type="radio"  name="changeprefradio" value="2" id="disable"/>
     <label for="disable">Disable</label> <!-- No i18N -->
     </div>
     <br />
     <div class="labelkey">Enter Admin password :</div> <%-- No I18N --%>
     <div class="labelvalue"><input type="password" autocomplete="off" id="tfapassword" class="input" onkeyup="if(event.keyCode==13) saveTFAAdmin();"/></div>
     <div class="accbtn Hbtn">
		    <div class="savebtn" onclick="saveTFAAdmin();">
			<span class="btnlt"></span>
			<span class="btnco"><%=Util.getI18NMsg(request,"IAM.SAVE")%></span>
			<span class="btnrt"></span>
		    </div>
		</div>
	</div>

	<div id="resettfa" class="tfafield-body" style="display:none;">
	 <div class="labelkey">Email id or zuid :</div> <%-- No I18N --%> 
	 <div class="labelvalue"><input type="text" id="reset_email" class="input" autocomplete="off"/></div>
	  <div class="labelkey">Enter Admin password :</div> <%-- No I18N --%>
     <div class="labelvalue"><input type="password" autocomplete="off" id="tfareset_pass" class="input"/></div>
     <div class="labelkey">&nbsp;</div>
     <div class="labelvalue"><button style="background-color: red;color: #FFFFFF;border:1px solid red" onclick="resetTFA()" >Reset</button></div> <%-- No I18N --%>
	<div class="labelkey">Response From Server :</div> <%-- No I18N --%>
	<div class="labelvalue">
	<textarea rows="10" cols="96" id="tfaresetstatus" style="font-size:10px;background-color:#ddd;border: 1px solid #CCCCCC;" readonly></textarea>
	</div>
	</div>
	
	<div id="smsstatus" class="tfafield-body" style="display:none;">
	 <div class="labelkey">Reference ID :</div> <%-- No I18N --%> 
	 <div class="labelvalue"><input type="text" id="tfaref_id" style="width: 250px;" class="input"/></div>
	<div class="accbtn Hbtn">
		    <div class="savebtn" onclick="checktelesignref();">
			<span class="btnlt"></span>
			<span class="btnco"><%=Util.getI18NMsg(request,"IAM.REGISTER.CHECK")%></span>
			<span class="btnrt"></span>
		    </div>
	</div>
	<div class="labelkey">Response From TeleSign :</div> <%-- No I18N --%>
	<div class="labelvalue">
	<textarea rows="10" cols="96" id="telesignres" style="font-size:10px;background-color:#ddd;border: 1px solid #CCCCCC;" readonly></textarea>
	</div>
	</div>
	
	<div id="generateRecoveryCode" class="tfafield-body" style="display:none;">
	 <div class="labelkey">Email ID or zuid :</div> <%-- No I18N --%> 	
	 <div class="labelvalue"><input type="text" id="recEmail" class="input" autocomplete="off"/></div>
	 
	 <div class="mfa_mode" id="Authenticator_div">
		<div class="labelkey">Authenticator App: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='authenticator_mode' class="inputSelect unauthinputSelect-tfa"" name="authenticator_mode" style="background-color: white;width: 231px;background-position-x: 153px;">					
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>
				<option value="1">Not able to access mobile</option>	<%-- No I18N --%>		
				<option value="2">Change of mobile</option>	<%-- No I18N --%>
				<option value="3">Phone reset</option>	<%-- No I18N --%>
			</select>
		</div>
	</div>
	
	<div class="mfa_mode" id="SMS_div">
		<div class="labelkey">SMS OTP: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='sms_mode' class="inputSelect unauthinputSelect-tfa"" name="sms_mode" style="background-color: white;width: 231px;background-position-x: 153px;">	
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>				
				<option value="1">Not able to access mobile</option>	<%-- No I18N --%>		
				<option value="2">Change of mobile</option>	<%-- No I18N --%>
				<option value="3">OTP not received / network issue</option>	<%-- No I18N --%>
			</select>
		</div>
	</div>
	
	<div class="mfa_mode" id="Oneauth_div">
		<div class="labelkey">Oneauth: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='oneauth_mode' class="inputSelect unauthinputSelect-tfa"" name="oneauth_mode" style="background-color: white;width: 231px;background-position-x: 153px;">
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>					
				<option value="1">Not able to access mobile</option>	<%-- No I18N --%>		
				<option value="2">Change of mobile</option>	<%-- No I18N --%>
				<option value="3">Phone reset</option>	<%-- No I18N --%>
				<option value="4">Reinstalled third party app / oneauth app without backup</option>	<%-- No I18N --%>		
				<option value="5">Push not received</option>	<%-- No I18N --%>
				<option value="6">Verification failed</option>	<%-- No I18N --%>
			</select>
		</div>
	</div>
	
	<div class="mfa_mode" id="Yubikey_div">
		<div class="labelkey">Yubikey: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='yubikey_mode' class="inputSelect unauthinputSelect-tfa"" name="yubikey_mode" style="background-color: white;width: 231px;background-position-x: 153px;">
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>					
				<option value="1">Yubikey is not accessible</option>	<%-- No I18N --%>		
			</select>
		</div>
	</div>
	
	<div class="mfa_mode" id="TrustedBrow_div">
		<div class="labelkey">Trusted browser: </div><%-- No I18N --%>	
		<div class="labelvalue">
			<select id='TrustedBrow_mode' class="inputSelect unauthinputSelect-tfa"" name="TrustedBrow_mode" style="background-color: white;width: 231px;background-position-x: 153px;">		
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>			
				<option value="1">Not able to signin in trusted browser due to Cookie reset</option><%-- No I18N --%>
				<option value="2">Signin from new browser which is not trusted</option>		<%-- No I18N --%>	
			</select>
		</div>
	</div>
	
	
	<div  class="mfa_mode" id="Backupcode_div">
		<div class="labelkey">Not able to access backup codes: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='Backupcode_mode' class="inputSelect unauthinputSelect-tfa"" name="Backupcode_mode" style="background-color: white;width: 231px;background-position-x: 153px;">	
				<option value="-1" selected disabled>Choose here</option><%-- No I18N --%>				
				<option value="0">Temporarily</option><%-- No I18N --%>
				<option value="1">Permanently</option>	<%-- No I18N --%>		
			</select>
		</div>
	</div>
	
	<div  class="mfa_mode" id="Others_div">
		<div class="labelkey">Others: </div>	<%-- No I18N --%>
		<div class="labelvalue">
			<select id='Others_mode' onchange="check_Otherinfo()" class="inputSelect unauthinputSelect-tfa"" name="Others_mode" style="background-color: white;width: 231px;background-position-x: 153px;">					
				<option value="1">none</option><%-- No I18N --%>
				<option value="2">MFA set by ex employee/partner/tech person</option>	<%-- No I18N --%>	
				<option value="3">Other reasons</option><%-- No I18N --%>	
			</select>
		</div>
		<div id="Reason_space" style="display:none;">
	 		<div class="labelkey">Enter Reason</div> <%-- No I18N --%>
     		<div class="labelvalue"><input type="text" id="Otherreason" class="input"/></div>
    	</div>
	</div>
	
	 <div class="password_space">
	 	<div class="labelkey">Enter Admin password :</div> <%-- No I18N --%>
     	<div class="labelvalue"><input type="password" autocomplete="off" id="tfa_rec_password" class="input" onkeyup="if(event.keyCode==13) generateAdminRecoveryCode();"/></div>
     </div>
     
     <div class="accbtn Hbtn">
		    <div  id="recovery_code_button" class="savebtn" onclick="getMfaInfo();">
			<span class="btnlt"></span>
			<span class="btnco">Get Information</span><%-- No I18N --%>
			<span class="btnrt"></span>
		    </div>
	</div>
	
	<div class="accbtn Hbtn" id="clear_rec_code" style="display:none;">
		    <div  id="clear_code_button" class="savebtn" onclick="clear_recoverycode();">
			<span class="btnlt"></span>
			<span class="btnco">Back</span><%-- No I18N --%>
			<span class="btnrt"></span>
		    </div>
	</div>
	
		<div class="recoverycode_section" style="display:none;">
			<div class="labelkey">Recovery Code for User :</div> <%-- No I18N --%>
			<div class="labelvalue">
				<textarea rows="10" cols="52" id="recCodeResponse" style="font-size:12px;background-color:#ddd;border: 1px solid #CCCCCC;" readonly></textarea>
			</div>
		</div>
	</div>
	</div>
<iframe onload="de('useremail').focus();" frameborder="0" class="hide" width="0%" height="0%" src="<%=request.getContextPath()%>/static/blank.html" ></iframe> <%-- NO OUTPUTENCODING --%>
</div>