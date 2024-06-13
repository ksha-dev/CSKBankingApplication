<%-- $Id$ --%>
<%@page import="com.zoho.accounts.internal.util.AccountsInternalConst.JVMCacheUseCase"%>
<%@page import="com.adventnet.iam.IAMUtil"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<% 
String usecases = request.getParameter("usecases");
if(IAMUtil.isValid(usecases)) {
	List<String> useCaseList = Arrays.asList(usecases.split(","));
	if(useCaseList != null && !useCaseList.isEmpty()) {
    	for(String usecase : useCaseList) {
    		JVMCacheUseCase.valueOf(usecase).clearCache();
    		return;
    	}
    }
}else {
	com.adventnet.iam.internal.Util.clearCache();
}
%>
