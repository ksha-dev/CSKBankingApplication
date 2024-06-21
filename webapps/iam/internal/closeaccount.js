
function isEmpty(value) {
    return (
        value === null ||
        value === undefined ||
        value === '' ||
        (Array.isArray(value) && value.length === 0) ||
        (typeof value === 'object' && Object.keys(value).length === 0)	//No I18N
    );
}

//$Id$ 
function loadServicesForCloseAccount(){
	clearErrorMsg();
	var val = $('#val').val().trim();// No I18N
	var type=$('#type').val().trim();// No I18N
	var sName=$('#service').val();// No I18N
	var devSetupUrl=$('#dev_setup_url').val();//No I18N
	
	if(isEmpty(val)) {
        showerrormsg("Enter valid admin email or ZOID to close org"); // No I18N
        return false;
    }
	if(!isEmpty(devSetupUrl)) {
		var urlWithoutPathRegex = /^((ht|f)tp(s?)\:\/\/[-.\w]*)?(\/?)(:[0-9]{4})?$/i;
		if(!urlWithoutPathRegex.test(devSetupUrl)) {
			showerrormsg("Invalid Development Setup Url"); // No I18N
			return false;
		}
	}
	
	val = encodeURIComponent(val);
	if(sName == 'select') {
		showerrormsg("No service selected"); // No I18N
		return false;
	} else if (sName == 'others') {	//No I18N
		sName = $("#others_sname").val();
		if (isEmpty(sName)){
			showerrormsg("Enter valid service name"); // No I18N
	        return false;
		}
	}
	var url = "/internal/closeaccount.jsp?value="+val+"&type="+type+"&sname="+sName+"&panel=serlist";	//No I18N
	if(!isEmpty(devSetupUrl)) {
		url += "&dev_setup_url=" + encodeURIComponent(devSetupUrl); // No I18N
	}
	window.location.replace(url);
}


function closeAccount(params) {
	var zid = $("input[name='portals']:checked").val();
	if(isEmpty(zid)) {
		showerrormsg("Select a zid"); // No I18N
        return false;
	}
	window.location.replace("/internal/closeaccount.jsp?"+params+"&zid="+zid);	//No I18N
	initSelect2ForCloseAcc();
}

function closeMembers(params) {
	var selectedUsers = [];
	$('input:checkbox[name=email_cb]:checked').each(function() {
		selectedUsers.push($(this).val());
	});
	if(selectedUsers.length == 0){
		showerrormsg("Select atleast one user to continue"); // No I18N
        return false;
	}
	window.location.replace("/internal/closeaccount.jsp?"+params+"&members="+selectedUsers);
	initSelect2ForCloseAcc();
}

function initSelect2ForCloseAcc() {
	$(".select2Div").select2();
	$('#service').on('select2:select', function (e) {
		clearErrorMsg();
		var sName=$('#service').val();// No I18N
		if(sName == 'others') {
			$("#others_sname").show();
		} else {
			$("#others_sname").hide();
		}
	});
}

function addBeautifiedResponse(jsObj){
	var v = JSON.stringify(jsObj, null, 4); document.getElementById("closeAccRes").innerHTML = v;
}

function showerrormsg(msg) {
	$("#err_div").text(msg);
}

function clearErrorMsg() {
	$("#err_div").text("");
}
