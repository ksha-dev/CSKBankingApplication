<%-- $Id$ --%>
<%@ include file="includes.jsp" %>
<div class="maincontent">
    <div class="menucontent">
	<div class="topcontent"><div class="contitle">Close Account</div></div>
	<div class="subtitle">Admin Services</div>
    </div>

    <div class="field-bg">
    <%if(Boolean.parseBoolean(AccountsConfiguration.getConfiguration("aoc.closeaccount.redirect", "false"))){ %>
    	<div id="closeaccredirect">Please Access the Close Account from AOC:</div> <br>  <!-- No I18N --><%--No I18N--%>
    	<div id="closeredirectlink" style="color:blue;"><a href="<%= IAMEncoder.encodeHTMLAttribute(AccountsConfiguration.getConfiguration("aoc.server.url", null) + "/admin#user/approvals") %>" target="_blank">Click here</a></div>   <!-- No I18N --><%--No I18N--%>
    <%}
    	else{%>
	<form name="closeAccount" class="zform" onsubmit="return closeusraccount(this);" method="post">
	    <div class="labelmain">
		<div class="labelkey">Enter UserName or Email Address :</div>
		<div class="labelvalue"><input type="text" name="user" class="input" autocomplete="off"/></div>
		<div class="labelkey">Comment :</div> <%--No I18N--%>
		<div><textarea class="labelvalue" name="comment"  rows="4" cols="30"></textarea></div>
		<div class="labelkey">Enter the Admin Password :</div>
		<div class="labelvalue"><input type="password" autocomplete="off" name="pwd" class="input"/></div>
		<div class="accbtn Hbtn">
		    <div class="savebtn" onclick="closeusraccount(document.closeAccount)">
			<span class="btnlt"></span>
			<span class="btnco">Close</span>
			<span class="btnrt"></span>
		     </div>
		     <div onclick="loadservice();">
			<span class="btnlt"></span>
			<span class="btnco">Cancel</span>
			<span class="btnrt"></span>
		     </div>
		</div>
		<input type="submit" class="hidesubmit" />
	    </div>
	</form>
	<%} %>
    </div>
</div>
