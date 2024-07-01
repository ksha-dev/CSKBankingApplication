//$Id$

function isValid(instr) {
	return instr != null && instr != "" && instr != "null";
}

function IsJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

function xhr() {
    var xmlhttp;
    if (window.XMLHttpRequest) {
	xmlhttp=new XMLHttpRequest();
    }
    else if(window.ActiveXObject) {
	try {
	    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e) {
	    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
    }
    return xmlhttp;
}

function getCookie(cookieName) {
	var nameEQ = cookieName + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i].trim();
		if (c.indexOf(nameEQ) == 0){ 
			return c.substring(nameEQ.length,c.length)
		};
	}
	return null;
}

function handleRelogin(json, method) {
	var serviceurl = encodeURIComponent(window.location.href); 
	var redirecturl = json.redirect_url;
	var url = window.location.origin + redirecturl +'?serviceurl='+serviceurl;//No I18N
	if("post" == method) {
		window.open(url + "&post=true", "_blank");
	} else {
		window.location.href = url;
	}
	return;
}

function addDeviceIcon(device_info){
	var img = device_info.device_img;
	var os = device_info.os_img;
	var deviceType = device_info.device_type ? device_info.device_type.toLowerCase() : "";
	const paths = new Map([
		  ["windows", 5],
		  ["linux", 5],
		  ["osunknown", 4],
		  ["macbook", 8],
		  ["iphone", 9],
		  ["ipad", 7],
		  ["windowsphone", 8],
		  ["samsungtab", 6],
		  ["samsung", 8],
		  ["android", 8],
		  ["pixel", 8],
		  ["oppo", 8],
		  ["vivo", 6],
		  ["androidtablet",6],
		  ["oneplus", 9],
		  ["mobile", 7],
		  ["iphone13", 4],
		  ["iphone14", 8],
		  ["s23ultra", 8],
		  ["s20fe5g", 9]
		]);
	
	var no_of_paths;
	var icon_class;
	
	if(img == "personalcomputer"){
		os = os ? os : "osunknown"; //No I18N
		no_of_paths = paths.get(os);
		icon_class = os + "_uk"; //No I18N
	} else if (img == "macbook" || img == "iphone" || img == "windowsphone" || img == "androidtablet") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img + "_uk"; //No I18N
	} else if (img == "vivo" || img == "ipad" || img == "samsungtab" || img == "samsung" || img == "pixel" || img == "oppo" || img == "oneplus") { //No I18N
		no_of_paths = paths.get(img);
		icon_class = img;
	}else if (img == "googlenexus" || (img == "mobiledevice" && (os == "android" || deviceType == "android"))) { //No I18N
		no_of_paths = paths.get("android");
		icon_class = "android_uk"; //No I18N
	} 
	else if (img == "mobiledevice") { //No I18N
		no_of_paths = paths.get("mobile");
		icon_class = "mobile_uk"; //No I18N
	} 
	
	if(device_info.device_model){ //only for applogins the device_info which as device_model value
		var deviceModel = device_info.device_model.toLowerCase();
		deviceModel = deviceModel.replace(/\s+/g, '');
		if((/iphone13|iphone13pro|iphone13promax|iphone13mini|iphone14|iphone14plus/).test(deviceModel)){
			icon_class = "iphone_13"; //No I18N
			no_of_paths = paths.get("iphone13");
		} else if((/iphone14pro|iphone14promax|iphone15|iphone15plus|iphone15pro|iphone15promax|iphone15,4|iphone15,5|iphone16,1|iphone16,2/).test(deviceModel)){
			icon_class = "iphone_14"; //No I18N
			no_of_paths = paths.get("iphone14");
		} else if((/sm-s918b/).test(deviceModel)){
			icon_class = "samsung_s23_ultra"; //No I18N
			no_of_paths = paths.get("s23ultra");
		} else if((/sm-s908e/).test(deviceModel)){
			icon_class = "samsung_s22_ultra"; //No I18N
			no_of_paths = paths.get("s23ultra");
		} else if((/sm-g781b/).test(deviceModel)){
			icon_class = "samsung_s20"; //No I18N
			no_of_paths = paths.get("s20fe5g");
		} else if((/pixel7pro|gp4bc|ge2ae/).test(deviceModel)){
			icon_class = "pixelpro"; //No I18N
			no_of_paths = paths.get("pixel");
		} else if((/pixel7|gvu6c|gqml3/).test(deviceModel)){
			icon_class = "pixel"; //No I18N
			no_of_paths = paths.get("pixel");
		}
	}
	
	return "deviceicon-"+ icon_class;//No I18N
}
function loadAppDevice(){
	var device_con = "";
	
	sessions.forEach(function(devices){
		if(isValid(devices)){
			device_info = devices.device_info;
			var primaryDevice_con = primaryElemClass = "";
			var disabled_state= "";
			if(device_info.is_primary){
				primaryDevice_con ='<span class="device_time device_opt"></span>\
									<span class="device_time device_cont">Primary Device</span>\
									<span class="device_time" onclick="slidePopup()">\
									    <span class="esc_mark info_icon"></span>\
									</span>';
				primaryElemClass = "primaryDevice";//No I18N
				disabled_state = "disabled";//No I18N
			}
			device_con += '<label id="device'+device_info.device_name+'" class="checckbox_container '+primaryElemClass+' device_div" onclick="checkSeletedDevices()">\ <span class="device_pic '+addDeviceIcon(device_info)+'"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span>\
				                <span class="device_details">\
				                    <span class="device_name">'+device_info.device_name+'</span>\ <span class="device_time">'+devices.created_time_elapsed+'</span>'+primaryDevice_con+'\ </span>\
<input type="checkbox" '+disabled_state+' value='+devices.refresh_token_hash+' name="device">\
				                <span class="checkmark"></span>\
				            </label>'
				            
				        
        }
	});
	document.getElementById("session_list_parent").innerHTML = device_con;
	return false;
}

function showDeviceList(){
	var session_parent_height = window.innerWidth < 600 ? window.outerHeight : window.innerHeight;
	document.getElementsByClassName("session_parent")[0].style.height = session_parent_height +"px";
	document.getElementsByClassName('hidden_class')[0].style.height = "0px";
	document.getElementsByClassName('session_img')[0].style.height = "0px";
	document.getElementsByClassName('session_title')[0].style.marginTop = "0px"; //No I18N
	document.getElementById('sessionlist').style.height = tranDeviceHeight+"px";
	document.getElementById('continueoption').style.bottom = "0px"; //No I18N
	checkSeletedDevices();
	var sesssion_list_height = window.innerWidth < 600 ? window.innerHeight - (document.getElementById("session_count_list").clientHeight + document.getElementsByClassName("session_title")[0].clientHeight+ document.getElementsByClassName("logo_parent")[0].clientHeight + document.getElementById("continueoption").clientHeight +66) : 370; //No I18N
	document.getElementById("session_list_parent").style.height = sesssion_list_height + "px";	
	return false;
}

function hideDeviceList(){
	var remaining_count_temp = threshold - totalSessions;
	var remaining_elem = document.getElementsByClassName("remaining_count")[0];
	var session_count_elem = document.getElementById('session_count');
	if(remaining_count_temp == 1){
		remaining_elem.innerHTML = I18N.get("IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT.ONE");//No I18N
	}
	else if(remaining_count_temp == 0){
		remaining_elem.innerHTML = I18N.get("IAM.SESSION.MANAGEMENT.ANNOUNCEMENT.NO.MORE");//No I18N
	}
	else{
		remaining_elem.innerHTML = I18N.get("IAM.APP.SESSION.MAX.LIMIT.USER.LIMIT");
		remaining_elem.childNodes[1].append(threshold - totalSessions)
	}
	if(totalSessions < threshold){document.getElementsByClassName('do_later')[0].style.display = "block";}
	session_count_elem.innerHTML = I18N.get("IAM.APP.SESSION.MAX.LIMIT.APP.LIMIT.SPAN");//No I18N
	session_count_elem.childNodes[1].append(totalSessions);
	document.getElementById("svg_circle").setAttribute("stroke-dasharray",(2 * Math.PI * 40 * (totalSessions / threshold))+" "+(2 * Math.PI * 40));
	document.getElementsByClassName('session_img')[0].style.height = "140px";
	document.getElementsByClassName('hidden_class')[0].style.height = tranConHeight+"px";
	document.getElementsByClassName('session_title')[0].style.marginTop = "30px"; //No I18N
	document.getElementById('sessionlist').style.height ="0px";
	document.getElementById('continueoption').style.bottom = "-200px"; //No I18N
	if(sessions_count > totalSessions){
		document.getElementsByClassName('do_later')[0].style.display = "block";
	}
	document.getElementsByClassName("session_parent")[0].style.height = "auto";
	return false;
}
function showConfirmationTemplate(){
	document.getElementsByClassName('success_img')[0].style = "height:50px;margin:50px auto 30px auto;";
	document.getElementsByClassName('session_desc')[1].childNodes[0].textContent = deletedCount +" "; 
	document.getElementsByClassName('session_title')[0].textContent = I18N.get("IAM.APP.SESSION.MAX.LIMIT.DELETED.HEADER");
	if(window.innerWidth > 600){
		document.getElementById('gotoSignin_conf_btn').style = "margin:20px auto 30px auto;";
		document.getElementsByClassName('do_later')[1].style = "margin: auto";
		document.getElementsByClassName('success_con')[0].style.height = 380 +"px";
	}else{document.getElementsByClassName('success_con')[0].style.height = tranSucHeight+"px";}
	document.getElementById('sessionlist').style.height ="0px";
	document.getElementById('continueoption').style.bottom = "-200px"; //No I18N
	document.getElementsByClassName("session_parent")[0].style.height = "auto";
	var validcount =  sessions_count - document.getElementsByClassName("primaryDevice").length; //No I18N
	if(deletedCount >= validcount) {
		document.getElementsByClassName('do_later')[1].style.display = "none";
	}
	var elem = document.getElementsByName("device");
	for (var i = 0; i < elem.length; i++) {
		if(elem[i].checked){
			elem[i].parentElement.remove();
		}
	}
	totalSessions = totalSessions - deletedCount;
	return false;
}

function backToDelete(){
	document.getElementsByClassName('do_later')[1].style = "";
	document.getElementsByClassName('success_img')[0].style = "height:0px;margin:0px auto;";
	document.getElementsByClassName('session_title')[0].textContent = I18N.get("IAM.APP.SESSION.MAX.LIMIT.HEADER");
	document.getElementsByClassName('success_con')[0].style.height = "0px";
	document.getElementById('sessionlist').style.height = tranDeviceHeight+"px";
	var elem = document.getElementsByName("device");
	for (var i = 0; i < elem.length; i++) {
		if(elem[i].checked){
			elem[i].parentElement.remove();
		}
	}
	var session_parent_height = window.innerWidth < 600 ? window.outerHeight : window.innerHeight;
	document.getElementsByClassName("session_parent")[0].style.height = session_parent_height +"px";
	document.getElementsByClassName('device_set')[0] = I18N.get("IAM.APP.SESSION.MAX.LIMIT.SELECT");
	document.getElementById('continueoption').style.bottom = "0px"; //No I18N
	checkSeletedDevices();
	deletedCount = 0;
	return false;
}

function toggleAllDevice(){
	var selected = document.getElementById("allDevice").checked;
	var elem = document.getElementsByName("device");
	for (var i = 0; i < elem.length; i++) {
		if(!elem[i].parentElement.classList.contains("primaryDevice")){
			elem[i].checked = selected;
		}
	}
	checkSeletedDevices();
	return false;
}

function checkSeletedDevices(){
	var selectedDeviceCount = 0;
	var elem = document.getElementsByName("device");
	for (var i = 0; i < elem.length; i++) {
		if(elem[i].checked){
			selectedDeviceCount++;
		}
	}
	document.getElementsByClassName("checckbox_container")[0].childNodes[0].textContent = I18N.get("IAM.APP.SESSION.MAX.LIMIT.ALL") + '(' + totalSessions + ')'; //No I18N
	var elem = document.getElementsByClassName("device_set")[0];
	var dltBtn = document.getElementsByClassName("dlt_btn")[0];
	var selectedCon = I18N.get("IAM.APP.SESSION.MAX.LIMIT.SELECT");
	dltBtn.disabled = true;
	if(selectedDeviceCount > 0){
		selectedCon = selectedDeviceCount + " " + I18N.get("IAM.APP.SESSION.MAX.LIMIT.SELECT");
		dltBtn.disabled = false;
	}
	elem.textContent = selectedCon;
}
		
function deleteDeviceList(){
	var elem = document.getElementsByName("device");
	var selectedHash = [];
	for (var i = 0; i < elem.length; i++) {
		if(elem[i].checked){
			selectedHash.push(elem[i].value);
		}
	}
	if(selectedHash.length > 0){
		deletedCount += selectedHash.length;
		var deleteurl = "/webclient/v1/account/self/user/self/applogins/"+client_id+"/devices/"+selectedHash.toString();//No I18N
		if(selectedHash.length == 1){
			deleteurl = "/webclient/v1/account/self/user/self/applogins/"+selectedHash[0]+"/devices/"+client_id;//No I18N
		}
		if(document.getElementById("allDevice").checked){
			deleteurl = "/webclient/v1/account/self/user/self/applogins/all/devices/"+client_id;//No I18N
		}
		if(typeof mdm_token !== 'undefined'){
			deleteurl+= "?token="+mdm_token;//No I18N
		}
		sendRequestWithCallback(deleteurl, "" ,true, handleDeletedDetails,"DELETE");//No I18N
	}
	return false;
}

function handleDeletedDetails(jsonStr){
	if(IsJsonString(jsonStr)) {
		jsonStr = JSON.parse(jsonStr);
	}
	var statusCode = jsonStr.status_code;
	document.getElementsByClassName("dlt_btn")[0].disabled = false;
	if (!isNaN(statusCode) && statusCode >= 200 && statusCode <= 299) { 
		showConfirmationTemplate();
		return false;
	}else{
		if("PP112" == jsonStr.code) {
			handleRelogin(jsonStr, "post"); //No I18N
			return;
		}
		showErrorNotfication(jsonStr.localized_message);
		return false;
	}
}

function showErrorNotfication(msg){
	$(".error_message").html(msg);
	$(".Errormsg").css("top","20px");//No i18N
	window.setTimeout(function(){$(".Errormsg").css("top","-100px")},5000);
}

function sendRequestWithCallback(action, params, async, callback,method) {
	if (typeof contextpath !== 'undefined') {
		action = contextpath + action;
	}
    var objHTTP = xhr();
    objHTTP.open(method?method:'POST', action, async);
    objHTTP.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8');
    objHTTP.setRequestHeader('X-ZCSRF-TOKEN',csrfParam+'='+encodeURIComponent(getCookie(csrfCookieName)));
    if(async){
	objHTTP.onreadystatechange=function() {
	    if(objHTTP.readyState==4) {
	    	if (objHTTP.status === 0 ) {
				handleConnectionError();
				return false;
			}
			if(callback) {
			    callback(objHTTP.responseText);
			}
	    }
	};
    }
    objHTTP.send(params);
    if(!async) {
	if(callback) {
            callback(objHTTP.responseText);
        }
    }
} 

function redirectToApp(){
	window.open(visited_url, "_self");
}

function slidePopup(){
	if(document.getElementById('darkBlur').style.opacity == 0.6){
		document.getElementById('darkBlur').style= "opacity: 0; visibility: hidden";
		if(window.innerWidth > 600){
			document.getElementById('primary_info').style= "opacity: 0; top:-300px;";
		}else{document.getElementById('primary_info').style="bottom: -600px; opacity: 0;";}//No i18N
	}else{
		document.getElementById('darkBlur').style= "opacity: 0.6; visibility: visible";
		if(window.innerWidth > 600){
			document.getElementById('primary_info').style= "left:"+(Math.round(window.innerWidth/2) - 200)+"px; top: 12%; opacity: 1";
		}else{document.getElementById('primary_info').style="bottom: 0px; opacity: 1;";}//No i18N
	}
}

