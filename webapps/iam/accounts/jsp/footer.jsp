<!-- $Id: $ -->
<%@page import="com.adventnet.iam.xss.IAMEncoder"%>
<%@page import="com.adventnet.iam.internal.Util"%>
<footer>
	<span><%=Util.getI18NMsg(request, "IAM.FOOTER.COPYRIGHT", Util.getCopyRightYear())%></span>
	<a href='<%=Util.getI18NMsg(request,"IAM.LINK.SECURITY")%>' target="_blank" rel="noreferrer"> <%=Util.getI18NMsg(request,"IAM.MENU.SECURITY")%></a>
	<a href='<%=Util.getI18NMsg(request,"IAM.LINK.PRIVACY")%>' target="_blank" rel="noreferrer"> <%=Util.getI18NMsg(request,"IAM.PRIVACY")%></a>
	<a href='<%=Util.getI18NMsg(request,"IAM.LINK.TOS")%>' target="_blank" rel="noreferrer"> <%=Util.getI18NMsg(request,"IAM.SIGNUP.TERMS.OFSERVICE")%></a>
	<a href='<%=Util.getI18NMsg(request,"IAM.LINK.ABOUT.US")%>' target="_blank" rel="noreferrer"> <%=Util.getI18NMsg(request,"IAM.ABOUT.US")%></a>
</footer>