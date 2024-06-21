<%-- $Id$ --%>
<%@page import="com.adventnet.iam.IAMUtil,com.adventnet.iam.Service,com.adventnet.iam.internal.Util"%>
<%@page import="java.util.Collection"%>
<%
    //clear LB related configuration cache in the respective service instance
    String redisStatus;
    long count  =0;
    if((count = Util.notifyViaRedisMessage(null, "clearconfig", true)) >= 0){//No I18N
    	redisStatus = "Broadcast via redis succesfull. Sent Count : "  + count; //No I18N
    }
    else {
    	redisStatus = "Broadcast via redis failed. Count : " + count;//No I18N
    }
%>
<html>
    <head>
        <title><%=Util.getI18NMsg(request,"IAM.ZOHO.ACCOUNTS")%></title><%-- NO OUTPUTENCODING --%>
        <style type="text/css">
            body {
                font-size: 12px;
            }
            div {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
            <div>Redis Broadcast Status :-</div><%-- No I18N --%>
            <ul><%=redisStatus%></ul><%-- NO OUTPUTENCODING --%>
    </body>
</html>
<%
%>