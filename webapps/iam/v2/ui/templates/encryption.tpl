var accountsPublicKeyURL = "${accountsPublicKeyURL}";
var encWithTimeStamp = Boolean("<#if encWithTimeStamp>true</#if>");
var encryptData = {
	isValidData : function(instr){
		return instr != null && instr != "" && instr != "null";
	},
	loadFile : function(url){
		var docHead = document.head || document.getElementsByTagName("head" )[0] || document.documentElement; 
		var script = document.createElement("script"); 
		script.src = url;
		docHead.appendChild(script); 
	},
	enabled : Boolean("<#if isEncryptionEnabled>true</#if>"),
	encrypt : function(encDataArray,Base64decodeNeed){
		return new Promise(function(resolve, reject) {
			if(!encryptData.enabled || typeof ZSEC  == "undefined" || !encryptData.isValidData(encDataArray)){
				resolve(encDataArray);
			}
			var promises = [];
			encDataArray.forEach(function(encData){
				if(encryptData.isValidData(encData)){
					promises.push(ZSEC.Encryption.encryptData(encData,"common",ZSEC.configuration.setCSRF({paramName: "${za.csrf_paramName}",cookieName: "${za.csrf_cookieName}"})));
	            }
	        });
	        checkDefine();
        	Promise.allSettled(promises).then(function(encDataArray){
				if(encryptData.isValidData(encDataArray[0].value) && Base64decodeNeed){
					encDataArray[0].value = window.btoa(encDataArray[0].value);
				}
				resolve(encDataArray);
			}).catch(function(error) {
				reject(error);
			});
		});
	}
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
function checkDefine(){
	if (!Promise.allSettled) {
	    Promise.allSettled = function (promises) {
	        return Promise.all(promises.map(function (p) {
	            return p.then(function (value) {
	                return {
	                    status: "fulfilled",
	                    value: value
	                };
	            }).catch(function (reason) {
	                return {
	                    status: "rejected",
	                    reason: reason
	                };
	            });
	        }));
	    };
	}
}

