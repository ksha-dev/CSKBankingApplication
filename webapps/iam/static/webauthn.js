//$Id$
function strToBin(str) {
  return Uint8Array.from(atob(str), function (c) {
    return c.charCodeAt(0);
  });
}

function binToStr(bin) {
  return btoa(new Uint8Array(bin).reduce(function (s, byte) {
    return s + String.fromCharCode(byte);
  }, ''));
}
function isWebAuthNSupported() {
	if (!window.PublicKeyCredential) {
		return false;
	}else {
		return true;
	}
}

function credentialListConversion(list) {
	return list.map(function(item){
		var cred = {
				type: item.type,
				id: strToBin(item.id)
		};
		if (item.transports != null && item.transports.length) {
			cred.transports = item.transports;
		}
		return cred;
	});
}