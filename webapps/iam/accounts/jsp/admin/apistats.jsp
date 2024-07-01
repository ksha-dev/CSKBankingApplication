<%-- $Id$ --%>
<%@page import="com.zoho.resource.Transferer.Method"%>
<%@page import="com.zoho.accounts.AccountsConstants"%>
<%@page import="com.zoho.accounts.AccountsConfiguration"%>
<%@page import="com.adventnet.iam.security.SecurityRequestWrapper"%>
<%@page import="java.security.Signature"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@page import="com.adventnet.iam.security.SecurityUtil"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.spec.X509EncodedKeySpec"%>
<%@page import="com.zoho.resource.ResourceException"%>
<%@page import="com.zoho.accounts.AppResource"%>
<%@page import="com.zoho.accounts.AppResourceProto.App.AppKeyStore"%>
<%@page import="com.zoho.accounts.oncloud.APIStatsLoader.StatData"%>
<%@page import="com.zoho.accounts.oncloud.APIStatsLoader"%>
<%@page import="com.adventnet.iam.Service"%>
<%@page import="java.util.Collection"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.adventnet.iam.internal.APIValidator"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%!
	private static AppKeyStore appKeyStore = null;
	private static boolean isKeyStoreInited = false;
	private String verifySignature(String authSignature) throws Exception {
		String publickey = null;
		String isVerified = "false"; //No I18N
		if(!isKeyStoreInited) {
			appKeyStore = AppResource.getAppKeyStoreURI(AccountsConstants.OrgType.ACCOUNTS.getServiceName(),"apiStats").GET();//No I18N
			isKeyStoreInited = true;
		}
		if(appKeyStore != null && appKeyStore.getPublicKey() != null) {
			publickey = appKeyStore.getPublicKey();
			String[] signParam = authSignature.split("-");
			String actualSign = signParam[1].trim();
			String data = signParam[2].trim();
			long signGeneratedTime = Long.parseLong(data);
			long diffTime = Math.abs(System.currentTimeMillis() - signGeneratedTime);
			if(diffTime > 600000) {
				isVerified = "Expired"; //No I18N
			} else {
				byte[] publicKeyBytes = ((byte[]) new Hex().decode(publickey));
				X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(publicKeyBytes);
				PublicKey publicKey1 = SecurityUtil.getKeyFactory().generatePublic(pubKeySpec);
				Signature verificationSign = Signature.getInstance("MD5withRSA"); //No I18N
				verificationSign.initVerify(publicKey1);
				verificationSign.update(data.getBytes());
				if(verificationSign.verify(SecurityUtil.BASE16_DECODE(actualSign))) {
					isVerified = "true"; //No I18N
				}
			}
		}
		return isVerified;
	}
%>
<%
	JSONObject result = new JSONObject();
	try{
		response.setContentType("application/json"); //No I18N
		String isVerified = "null"; //No I18N
		boolean ispre = false;
		if(!com.zoho.conf.Configuration.getBoolean("is.pre.accounts","false")) {  //No I18N
			result.put("status", "failure");  //No I18N
			result.put("message", "Not allowed");  //No I18N
		} else {
			if(request.getMethod() != null && request.getMethod().equalsIgnoreCase(Method.GET.name())) {
				isVerified = "true";
			} else {
				if(!AccountsConfiguration.getConfigurationTyped("apistats.auth.required", true)) { //No I18N
					isVerified = "Not Required";  //No I18N
				} else {
					SecurityRequestWrapper securedRequest = (SecurityRequestWrapper) request.getAttribute(SecurityRequestWrapper.class.getName());
					String authSignature = securedRequest.getParamOrStreamContent();
					if(authSignature != null) {
						isVerified = verifySignature(authSignature);
					}
				}
			}
			if(isVerified.equalsIgnoreCase("Expired")) {
				result.put("status", "failure"); //No I18N
				result.put("message", "SignExpired"); //No I18N
			} else if(isVerified.equalsIgnoreCase("true") || isVerified.equalsIgnoreCase("Not required")) { //No I18N
				int type = IAMUtil.getInt(request.getParameter("type"));
				try {
					JSONObject job = new JSONObject();
					if(type == 0) {
						job = new JSONObject(APIValidator.getAPIMethods());
					} else if(type == 1) {
						Collection<Service> services = Util.SERVICEAPI.getAllServicesByOrder();
						for(Service ser : services) {
							job.put(String.valueOf(ser.getServiceId()), ser.getServiceName());
						}
					} else if(type == 2) {
						long time = IAMUtil.getLong(request.getParameter("time"));
						StatData data = APIStatsLoader.getInstance().getStatData(time);
						job.put(data.getTime(), data.getFinalData());
					} else {
						result.put("status", "invalid"); //No I18N
					}
					if(!result.has("status")) {
						result.put("status", "success"); //No I18N
						result.put("result", job); //No I18N
						result.put("message",isVerified); //No I18N
					}
				} catch (Exception e) {
					result.put("status","failure"); //No I18N
					result.put("message",e.getMessage()); //No I18N
				}
			} else {
				result.put("status","failure"); //No I18N
				result.put("message", "Signature not passed / Signature Verification Failed"); //No I18N
			}
		}
	} catch(Exception e) {
		result.put("status","failure"); //No I18N
		result.put("message", e.getMessage()); //No I18N
	}
	out.print(result.toString());
%>