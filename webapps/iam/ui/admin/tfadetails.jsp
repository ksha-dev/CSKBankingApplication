<%--$Id$--%>
<%@page import="com.zoho.accounts.AccountsConstants.MFAPreference"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.TotpType"%>
<%@page import="com.adventnet.iam.security.UserAgent"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.User.UserMobile"%>
<%@page import="com.adventnet.iam.internal.PhoneUtil"%>
<%@page import="com.zoho.iam2.rest.ProtoToZliteUtil"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst"%>
<%@page import="com.zoho.accounts.phone.SMSQueue"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="com.zoho.accounts.cache.MemCacheUtil"%>
<%@page import="com.adventnet.iam.internal.MemCacheInternalUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.User.Properties"%>
<%@page import="com.adventnet.iam.servlet.TFAPrefServlet"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.TFARecoveryPreference"%>
<%@ include file="../../static/includes.jspf" %>
<%@ include file="includes.jsp" %>
<%@page import="com.zoho.accounts.AccountsConstants.TFAPrefOption"%>
<%@page import="com.zoho.accounts.phone.SMSUtil"%>
<%@page import="com.zoho.accounts.Accounts"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.User.AppPassword"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.zoho.resource.Criteria"%>
<%@page import="com.zoho.accounts.Accounts.RESOURCE.USERSECRETKEY"%>
<%@page import="com.zoho.accounts.AccountsProto.Account.User.UserSecretKey"%>
<%@page import="com.zoho.accounts.cache.MemCacheConstants"%>
<%@page import="com.zoho.accounts.Accounts.RESOURCE.USERMOBILE"%>
<%@page import="java.util.Map"%>
<%@page import="com.zoho.accounts.webclient.util.WebClientUtil"%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.UserMobileMode"%>


<div id="tfasetting_maincontainer" style="font-size: 12px;padding: 10px;line-height: 20px;margin-left: 50px;">
<%
long zuid = IAMUtil.getLong(request.getParameter("zuid"));
User currentUser = Util.USERAPI.getUser(zuid);

boolean isCurrentUserAllowed = request.isUserInRole("IAMAdmininistrator");
boolean isTFAConfiguredByUser = Util.isTFAEnabled(currentUser);
UserPreference userPreference = Util.USERAPI.getUserPreference(currentUser.getZUID());

boolean usesGAuthenticator = false;
boolean usesSms = false;
boolean usesTouchid = false;
boolean usesQr = false;
boolean usesPush = false;
boolean usesTotp = false;
boolean usesYK = false;
boolean usesMYZoho = false;
boolean usesMYZohoBio = false;
boolean usesFaceid = false;


Map<Integer, Integer> configuredModes = WebClientUtil.getUserConfiguredModesVsCount(currentUser);
if(configuredModes != null && !configuredModes.isEmpty()){
	//user has configured MFA
	try {
		if(configuredModes.containsKey(MFAPreference.TOTP.dbValue())) {
			//User has configured TOTP
			usesGAuthenticator = true;			
		}
		if(configuredModes.containsKey(MFAPreference.SMS.dbValue())) {
			//User has configured SMS OTP					
			usesSms = true;
		}
		if(configuredModes.containsKey(MFAPreference.HARDWARE_KEY.dbValue())) {
			//User has configured Yubikey
			usesYK = true;
		}
		if(configuredModes.containsKey(MFAPreference.MYZOHO_APP.dbValue())) {
			usesMYZoho = true;
		}
		if(configuredModes.containsKey(MFAPreference.MYZOHO_BIOMETRIC.dbValue())){
			usesMYZohoBio = true;
		}
		if(configuredModes.containsKey(MFAPreference.ONEAUTH_TOUCH_ID.dbValue())){
			usesTouchid = true;
		}
		if(configuredModes.containsKey(MFAPreference.ONEAUTH_SCAN_QR.dbValue())){
			usesQr = true;
		}
		if(configuredModes.containsKey(MFAPreference.ONEAUTH_PUSH_NOTIF.dbValue())){
			usesPush = true;
		}
		if(configuredModes.containsKey(MFAPreference.ONEAUTH_TOTP.dbValue())){
			usesTotp = true;
		}
		if(configuredModes.containsKey(MFAPreference.ONEAUTH_FACE_ID.dbValue())){
			usesFaceid = true;
		}		
		
	} catch (Exception e) {
		usesFaceid = false;
	}
}

boolean usesGAuthenticatorAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_SMART_PHONE);
boolean usesSmsAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_SMS);
boolean usesTouchidAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_TOUCH_ID);
boolean usesQrAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_QR);
boolean usesPushAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_PUSH);
boolean usesTotpAsPrimary= userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.ENABLE_TFA_TOTP);
boolean usesYKAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == MFAPreference.HARDWARE_KEY.dbValue());
boolean usesMYZohoAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.MYZOHO_APP);
boolean usesMYZohoBioAsPrimary = userPreference!= null && (userPreference.getTFAPrefOption() == TFAPrefOption.MYZOHO_BIOMETRIC);
boolean isEnforcedandNotSet = false;

if(currentUser.isOrgUser()) {
	boolean isTFAEnableduser = Util.USERAPI.isTFAPrefOptionEnabled(currentUser.getZUID());
	if(isTFAEnableduser) {
		if(userPreference == null) {
			isEnforcedandNotSet = true;
		}else {
			if(userPreference.isUsingTFA()){
				isEnforcedandNotSet = !Util.checkIfUserHasTFASpecificData(currentUser, userPreference);
			}
		}
	}
	if(isEnforcedandNotSet){
		isTFAConfiguredByUser = false;
	}
}
long recoveryCodesCount = Accounts.getRecoveryCodeURI(currentUser.getZaid(), currentUser.getZUID()).COUNT();
AppPassword[] appPasswords = Accounts.getAppPasswordURI(currentUser.getZaid(), currentUser.getZUID()).GETS();
List<UserSession> listSessions = CSPersistenceAPIImpl.getUserTFASession(currentUser.getZUID());

Properties saveTypeProperty = Accounts.getPropertiesURI(currentUser.getZaid(), currentUser.getZUID(),Util.appendIAMPropertyPrefix(TFAPrefServlet.TFA_RECOVERY_PREFERENCE)).GET();
boolean alreadySavedCodes = saveTypeProperty != null;
Properties backupinfoProperty = alreadySavedCodes ? Accounts.getPropertiesURI(currentUser.getZaid(), currentUser.getZUID(),Util.appendIAMPropertyPrefix(TFAPrefServlet.TFA_BKPCODES_INFO)).GET() : null;
boolean hasBackupInfo = backupinfoProperty != null;
String propJsonString = hasBackupInfo ? backupinfoProperty.getPropValue() : null;
JSONObject jsonBackupInfo = hasBackupInfo ? new JSONObject(propJsonString) : null;
List<UserPhone> phoneList = ProtoToZliteUtil.toUserPhoneNumbers((UserMobile[]) PhoneUtil.getUserTFANumbers(currentUser));
%>

<%
int dialingCode=-1;
List<UserPhone> backupNumbers = new ArrayList<UserPhone>();
List<UserPhone> unverifiedNumbers = ProtoToZliteUtil.toUserPhoneNumbers((UserMobile[]) PhoneUtil.getUserUnVerifiedNumber(currentUser));
List<UserPhone> allBackupPhones = new ArrayList<UserPhone>();
UserPhone tfaNumber=null;
if (phoneList != null) {
		for (UserPhone val : phoneList) {
			if(val.isPrimary() && usesSms){
				tfaNumber=val;
				dialingCode=SMSUtil.getISDCode(tfaNumber.getCountryCode());
			}else {
				backupNumbers.add(val);
			}
		}
	}
boolean hasBackupNumbers = (backupNumbers != null)&& (backupNumbers.size() > 0);
boolean hasUnverifiedNumbers = (unverifiedNumbers != null) && (unverifiedNumbers.size() > 0);
if(tfaNumber == null && hasBackupNumbers){
	tfaNumber = backupNumbers.get(0);
	dialingCode=SMSUtil.getISDCode(tfaNumber.getCountryCode());
	backupNumbers.remove(0);
}
%>

<div style="font-weight: bold;text-decoration: underline;">
	Primary MFA Mode <%-- No I18N --%>
</div>
<%if( userPreference == null || userPreference.getUserTFAStatus() == 0 || userPreference.getTFAPrefOption() == -1 || (!isTFAConfiguredByUser && ( phoneList == null || isEnforcedandNotSet ))) {%>
	<%if(isEnforcedandNotSet){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #FEE1E1;border: 1px solid #FAB9B9;padding: 4px;float: left;font-size: 11px;">
	<div>MFA is Enforced on this user by the org admin, but the user has not configured MFA.</div> <%-- No I18N --%>
	<div>Possible reasons could be</div> <%-- No I18N --%>
	<ul>
	<li>
		User has not logged in after MFA is enforced. <%-- No I18N --%>
	</li>
	<li>
		Admin has reset MFA for this user. <%-- No I18N --%>
	</li>
	</ul>
	</div>
	<%}else{ %>
		<div style="margin: 0px 0px 19px 0px;background-color: #FEE1E1;border: 1px solid #FAB9B9;padding: 4px;float: left;font-size: 11px;">
			User has not configured MFA <%-- No I18N --%>
		</div>
	<%} %>
<%} else {%>
	<div style="margin: 0px 0px 19px 0px;background-color: #C7EAC7;border: 1px solid #98CE98;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <%-- No I18N --%>
			<span style="font-weight: bold;">						
				<%if(usesGAuthenticatorAsPrimary){ %>		
						Google Authenticator	<%-- No I18N --%>	
				<%}else if(usesTouchidAsPrimary){ %>
						Touch ID <%-- No I18N --%>
				<%}else if(usesQrAsPrimary){ %>
						Scan QR <%-- No I18N --%>
				<%}else if(usesPushAsPrimary){ %>
						Push Notification <%-- No I18N --%>
				<%}else if(usesTotpAsPrimary){ %>
						Time-based OTP <%-- No I18N --%>
				<%}else if(usesYKAsPrimary){ %>
						Hardware Key <%-- No I18N --%>
				<%}else if(usesMYZohoAsPrimary){ %>
						MYZoho App <%-- No I18N --%>
				<%}else if(usesMYZohoBioAsPrimary){ %>		
						MYZoho Biometric <%-- No I18N --%>
				<%}else if(usesSmsAsPrimary){ %>		
						SMS Text Message <%-- No I18N --%>		
				<%} %>
			</span>
			as Primary Mode. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>		
	
	<div style="font-weight: bold;text-decoration: underline;">
		Other Modes <%-- No I18N --%>
	</div>
	<%if(usesSms && !usesSmsAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">SMS Text Message</span> <%-- No I18N --%>			
	</div>
	<div style="clear: both;"></div>
	<%}if(usesGAuthenticator && !usesGAuthenticatorAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Google Authenticator</span> <%-- No I18N --%>			
	</div>
	<div style="clear: both;"></div>
	<%}if(usesTouchid && !usesTouchidAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Touch ID</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesQr && !usesQrAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Scan QR</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesPush && !usesPushAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Push Notification</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesTotp && !usesTotpAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Time-based OTP</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesYK && !usesYKAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">Hardware Key</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesMYZoho && !usesMYZohoAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">MYZoho App</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>
	<%}if(usesMYZohoBio && !usesMYZohoBioAsPrimary){ %>
	<div style="margin: 0px 0px 19px 0px;background-color: #e0e4e5;border: 1px solid #999;padding: 4px;float: left;font-size: 11px;">
			User has Configured MFA using <span style="font-weight: bold;">MYZoho Biometric</span>. <%-- No I18N --%>
	</div>
	<div style="clear: both;"></div>	
	<%} %>
<%} %>
<div style="clear: both;"></div>	
<div style="font-weight: bold;text-decoration: underline;">
	MFA Number <%-- No I18N --%>
</div>
<div>
	<ul style="list-style-type: disc;">
	<%if(usesSms || usesTouchid || usesQr || usesPush || usesTotp || usesYK || usesMYZoho || usesMYZohoBio) { %>	
		<%if(tfaNumber!=null){%>
			<li style="margin-left: 20px;margin-bottom: 10px; display: list-item;">
				<%=IAMEncoder.encodeHTML("(+"+dialingCode+")"+((isCurrentUserAllowed)?tfaNumber.getPhoneNumber():tfaNumber.getPhoneNumber().substring(0, 3)+"*****"+tfaNumber.getPhoneNumber().substring(tfaNumber.getPhoneNumber().length()-2)))%>
				<%
				int mobileCount = 0;
				String displayHits = null;
				String displaybackup = null;
				String mobileHitCount = MemCacheUtil.get(MemCacheConstants.OPTIONAL_POOL, MemCacheConstants.getMobileThresholdkey(String.valueOf(dialingCode) + tfaNumber.getPhoneNumber()));  
				if(Util.isValid(mobileHitCount)){
					String[] mobileHitDetails = mobileHitCount.split("_");
					mobileCount = IAMUtil.getInt(mobileHitDetails[0]);
				}
				displayHits = " Mobile HitCount = "+ mobileCount;//No I18N%>
		 		<ul><%=IAMEncoder.encodeHTML(displayHits)%></ul>
				<script type="text/javascript" src="js/admin.js"></script>
				<div><a href="javascript:;" onclick="javascript:clearMobileCache('<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.getMobileThresholdkey(String.valueOf(dialingCode) + tfaNumber.getPhoneNumber())))%>', '<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.OPTIONAL_POOL))%>');  loadui('/ui/admin/userinfo.jsp?qry=<%=currentUser.getZUID() %>');  showTFADetails('.usrinfoactivediv','<%=currentUser.getZUID() %>')">CLEAR MOBILE CACHE </a></div> <%-- NO OUTPUTENCODING --%> <%-- No I18N --%>
			</li>
		<%}else{ %>
			User doesn't have a MFA number. <%-- No I18N --%>
		<%} %>
	<%}if(usesGAuthenticator) { 
		UserSecretKey usk = Accounts.getUserSecretKeyURI(currentUser.getZaid(), currentUser.getZUID()).getQueryString().setCriteria(new Criteria(USERSECRETKEY.IS_PRIMARY,true).and(new Criteria(USERSECRETKEY.IS_VERIFIED,true)).and(new Criteria(USERSECRETKEY.KEY_TYPE, TotpType.totp.getIntValue()))).build().GET();
		if(usk != null) { %>
		<li style="margin-left: 20px;margin-bottom: 10px; display: list-item;">
			User has Configured Google Authenticator using the label <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(usk.getKeyLabel())%></span> <%-- No I18N --%>
		</li>
		<%} %>	
	<%}%>
	</ul>
</div>
<div style="font-weight: bold;text-decoration: underline;margin-top: 15px;">
	MFA-Backup Number(s) <%-- No I18N --%>
</div>
<%if(hasBackupNumbers || hasUnverifiedNumbers){ %>
<div>User has <%-- No I18N --%>  
<%=backupNumbers.size() %> verified backup phones and <%= unverifiedNumbers != null ? unverifiedNumbers.size() : 0%> unverified phones</div>  <%-- NO OUTPUTENCODING --%> <%-- No I18N --%> 
<ol>
<%  //No I18N
allBackupPhones.addAll(backupNumbers);
if(hasUnverifiedNumbers){
	allBackupPhones.addAll(unverifiedNumbers);
}
String mobileHitCount = null; //No I18N
String displayHits = null; //No I18N
String verificationStatusMessage = null;
int mobileCount= 0;  //No I18N
  for(UserPhone phone : allBackupPhones) {
	dialingCode = -1;
	String displaybackup = null;
	if(phone.getCountryCode() != null){
		dialingCode = SMSUtil.getISDCode(phone.getCountryCode());		
		mobileHitCount = MemCacheUtil.get(MemCacheConstants.OPTIONAL_POOL, MemCacheConstants.getMobileThresholdkey(String.valueOf(dialingCode)+ phone.getPhoneNumber()));  
		if(Util.isValid(mobileHitCount)){
			String[] mobileHitDetails = mobileHitCount.split("_");
			mobileCount = IAMUtil.getInt(mobileHitDetails[0]);
		}
	}	
	if(!phone.isVerified()){
		verificationStatusMessage = " ( Unverified ) ";	//No I18N
	}
	else verificationStatusMessage = " ( Verified ) "; // No I18N
	
	String bnumber = ((isCurrentUserAllowed)?phone.getPhoneNumber():phone.getPhoneNumber().substring(0, 3)+"*****"+phone.getPhoneNumber().substring(phone.getPhoneNumber().length()-2));
	displaybackup = dialingCode != -1 ? "(+" + dialingCode + ") " + bnumber : bnumber;
	displayHits = " Mobile HitCount =  "+ mobileCount + " " + verificationStatusMessage;//No I18N
	mobileCount=0;%>
<li><%=IAMEncoder.encodeHTML(displaybackup)%></li>
<ul><%=IAMEncoder.encodeHTML(displayHits)%></ul>
<div><a href="javascript:clearMobileCache('<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.getMobileThresholdkey(String.valueOf(dialingCode) + phone.getPhoneNumber())))%>', '<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.OPTIONAL_POOL))%>');  loadui('/ui/admin/userinfo.jsp?qry=<%=currentUser.getZUID() %>');  showTFADetails('.usrinfoactivediv','<%=currentUser.getZUID() %>')">CLEAR MOBILE CACHE </a></div> <%-- NO OUTPUTENCODING --%> <%--No I18N--%>
<%}
	int zuidCount = 0;
	String zuidHitCount = MemCacheUtil.get(MemCacheConstants.OPTIONAL_POOL, MemCacheConstants.getZuidTFAThresholdkey(String.valueOf(currentUser.getZUID())));
	if(Util.isValid(zuidHitCount)){
		String []hits = zuidHitCount.split("_");
		zuidCount = IAMUtil.getInt(hits[0]);
		}
String displayZuidCount = " ZUID HitCount = " + zuidCount;	//No I18N
		%>
</ol>
<div><ul><%=IAMEncoder.encodeHTML(displayZuidCount)%></ul><a href="javascript:clearMobileCache('<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.getZuidTFAThresholdkey((String.valueOf(currentUser.getZUID())))))%>', '<%=IAMEncoder.encodeJavaScript(String.valueOf(MemCacheConstants.OPTIONAL_POOL))%>');  loadui('/ui/admin/userinfo.jsp?qry=<%=currentUser.getZUID() %>'); showTFADetails('.usrinfoactivediv','<%=currentUser.getZUID() %>')">CLEAR ZUID CACHE </a></div> <%-- NO OUTPUTENCODING --%> <%--No I18N--%>
<%}else {%>
<div>User has no backup phones</div> <%-- No I18N --%>
<%} %>
<div style="font-weight: bold;text-decoration: underline;margin-top: 15px;">
	Backup Verification Codes <%-- No I18N --%>
</div>
<div>
<%if(recoveryCodesCount == 0){ %>
	User doesn't have any backup codes <%-- No I18N --%>
<%}else{ %>
	<span style="font-weight: bold;"><%=recoveryCodesCount%> un-used</span> backup codes&nbsp; <%-- No I18N --%>
	<%if(alreadySavedCodes){ 
				long savedTime = saveTypeProperty.getModifiedTime() != 0 ? saveTypeProperty.getModifiedTime() : saveTypeProperty.getCreatedTime();
				if(TFARecoveryPreference.SAVE_TEXT.getValue().equalsIgnoreCase(saveTypeProperty.getPropValue()) && (jsonBackupInfo != null)) {
					String browserName = jsonBackupInfo.optString(TFAPrefServlet.TFA_BROWSER_KEY);
					String oSName = jsonBackupInfo.optString(TFAPrefServlet.TFA_OS_KEY);
					if(Util.isValid(browserName) && Util.isValid(oSName) && savedTime != -1){%>
							<span>
								(Codes saved on <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(oSName)%></span> from <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(browserName)%></span> browser on <%=new Date(savedTime) %>) <%--No I18N--%>
							</span>		
					<%} else {%>
					<span>(Codes not saved)</span> <%-- No I18N --%>
					<%}
				} else if(TFARecoveryPreference.COPY.getValue().equalsIgnoreCase(saveTypeProperty.getPropValue()) && (jsonBackupInfo != null)) {
					String browserName = jsonBackupInfo.optString(TFAPrefServlet.TFA_BROWSER_KEY);
					String oSName = jsonBackupInfo.optString(TFAPrefServlet.TFA_OS_KEY);
					if(Util.isValid(browserName) && Util.isValid(oSName) && savedTime != -1){%>
							<span>
								(Codes copied on <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(oSName)%></span> from <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(browserName)%></span> browser on <%=new Date(savedTime) %>) <%--No I18N--%>
							</span>		
					<%} else {%>
					<span>(Codes not saved)</span> <%-- No I18N --%>
					<%}
				}  else if(TFARecoveryPreference.SUPPORT_ADMIN.getValue().equalsIgnoreCase(saveTypeProperty.getPropValue()) && (jsonBackupInfo != null)) {%>
					<span>
						(Codes generated by Support Admin on <%--No I18N--%>
						<%=new Date(savedTime) %>) 
					</span>												
				<%} else if(TFARecoveryPreference.PRINT_CODES.getValue().equalsIgnoreCase(saveTypeProperty.getPropValue()) && savedTime != -1) { %>
				<span>
				(<span style="font-weight: bold;">printed backup codes</span> on <%=new Date(savedTime)%>) <%-- No I18N --%>
				</span>
			<%}else if(TFARecoveryPreference.EMAIL.getValue().equalsIgnoreCase(saveTypeProperty.getPropValue()) && jsonBackupInfo != null) {
			String email = jsonBackupInfo.optString(TFAPrefServlet.TFA_RECOVERY_EMAIL_KEY);
			if(Util.isValid(email) && savedTime != -1) {%>
			<span>
			(Codes sent to email - <span style="font-weight: bold;"><%=IAMEncoder.encodeHTML(email) %></span> on <%= new Date(savedTime)%>) <%-- No I18N --%>
			</span>
			<%} else {%>
				<span>(Codes not saved)</span> <%-- No I18N --%>	
			<%}
			} 
		} else {%>
			<span>(Codes not saved)</span> <%-- No I18N --%>	
		<%} %>
<%} %>
</div>
<div style="font-weight: bold;text-decoration: underline;margin-top: 15px;">
	App Specific Passwords <%-- No I18N --%>
</div>
<div>
<%if(appPasswords != null) { %>
User has <span style="font-weight: bold;"><%=appPasswords.length %></span> app specific passwords. <%-- NO OUTPUTENCODING --%> <%-- No I18N --%>
<div style="text-decoration: underline;">Key Labels :</div> <%-- No I18N --%>
<ol>
<%
for(AppPassword appPassword : appPasswords) {%>
	<li><%=IAMEncoder.encodeHTML(appPassword.getKeyLabel())%></li>
<%}%>
</ol>
<%}else{ %>
User doesn't have any app passwords. <%-- No I18N --%>
<%} %>
</div>
<div style="font-weight: bold;text-decoration: underline;margin-top: 15px;">
Trusted Browsers <%-- No I18N --%>
</div>
<div>
<%if(listSessions != null && listSessions.size() > 0){ 
%>
<table border="1" style="border:1px solid #a39e9e;border-collapse: collapse;width: 600px;margin-top: 10px;">
	<tr style="background-color: whitesmoke;">
		<td style="width:40%;padding:5px;">Started Time</td> <%-- No I18N --%>
		<td style="width:20%;padding:5px;">Browser</td> <%-- No I18N --%>
		<td style="width:40%;padding:5px;">Connected From IP Address</td> <%-- No I18N --%>
	</tr>
	<%for(UserSession us : listSessions) {
		UserAgent userAgent = new UserAgent(us.getUserAgent());
	    String browserclass = null;
	    if(userAgent != null) {
	    	if(userAgent.getBrowserName().toLowerCase().contains("firefox")) {
	    		browserclass = "firefox"; //No I18n
	    	}else if(userAgent.getBrowserName().toLowerCase().contains("chrome")) { //No I18n
	    		browserclass = "chrome"; //No I18n
	    	}else if(userAgent.getBrowserName().toLowerCase().contains("opera")) { //No I18n
	    		browserclass = "opera"; //No I18n
	    	}else if(userAgent.getBrowserName().toLowerCase().contains("safari")) { //No I18n
	    		browserclass = "safari"; //No I18n 
	    	}else if(userAgent.getBrowserName().toLowerCase().contains("ie")) { //No I18n
	    		browserclass = "ie"; //No i18N
	    	}
	    }
	%>
		<tr style="border:1px solid #a39e9e;">
		<td>
		<%=new Date(us.getStartTime())%> <%-- NO OUTPUTENCODING --%>		</td>
		<td>
		<div title="<%=IAMEncoder.encodeHTMLAttribute(us.getUserAgent())%>" style="cursor: help;">
			<span <%if(browserclass != null){ %>class="<%=browserclass%>" <%} %>></span>
			<span style="margin-left: 7px; display: inline-block; margin-top: 3px;"><%=IAMEncoder.encodeHTML(userAgent.getBrowserName())%></span>
		</div>
		</td>
		<td>
		<%=IAMEncoder.encodeHTML(us.getFromIP())%>
		</td>
		</tr>
	<%}%>
</table>
<%} else {%>
User doesn't have any trusted sessions. <%-- No I18N --%>
<%} %>
</div>
</div>