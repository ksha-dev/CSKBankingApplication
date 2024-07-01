//$Id$
function WmsliteImpl(){}

WmsliteImpl.serverdown=function(){
	wmsConnectionFailure();
}
WmsliteImpl.serverup=function(){
	wmsRegisterSuccess();
}
WmsliteImpl.handleLogout=function(reason){
	$(window).unbind('beforeunload');
    sendRequestWithCallback(contextpath+"/u/clearusercache", "nocache="+((new Date()).getTime()), true, function() {window.location.href="/";}); //No I18N
}
WmsliteImpl.handleMessage=function(mtype,msgObj){
    if(mtype && mtype === '37') {//Language changed
        sendRequestWithCallback(contextpath+"/u/clearusercache", "nocache="+((new Date()).getTime()), true, function() {}); //No I18N
    }
    else if(mtype && mtype == '2'){
		if(msgObj == "checkStatus"){ //No I18N
    		isVerifiedFromDevice();
		} else if(msgObj == "OAInstall"){ //No I18N
			wmsMessageCallBack(msgObj);
		} else if(msgObj == "CodeGen"){ //No I18N
			wmsMessageCallBack(msgObj);
		} else if(msgObj == "mfaConfig"){ //No I18N
			wmsMessageCallBack(msgObj);
		}
    }
}               
WmsliteImpl.handleAccountDisabled=function(reason){}
WmsliteImpl.handleServiceMessage=function(msg){}

function wmsRegisterSuccess(){};
function wmsConnectionFailure(){};