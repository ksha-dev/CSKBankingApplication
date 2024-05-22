function logout() {
	var confirmation = confirm("Press OK to confirm logout.\nPress Cancel or escape to cancel");
	if (confirmation) {
		location.href = "logout";
	}
}

function errorMessage(error) {
	document.addEventListener("DOMContentLoaded", function() {
		setTimeout(function() {
		}, 500);
		const errorElement = document.createElement('div');
		errorElement.className = 'error-popup';
		errorElement.innerHTML = '<p id="errorMessage">' + error + '</p>'
		document.body.appendChild(errorElement);
		setTimeout(function() {
			document.body.removeChild(errorElement);
		}, 5000);
	});
}

function runtimeError(error) {
	setTimeout(function() {
	}, 500);
	const errorElement = document.createElement('div');
	errorElement.className = 'error-popup';
	errorElement.innerHTML = '<p id="errorMessage">' + error + '</p>'
	document.body.appendChild(errorElement);
	setTimeout(function() {
		document.body.removeChild(errorElement);
	}, 5000);
}