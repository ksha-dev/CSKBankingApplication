var action;

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

function spanErrorMessageBelowInput(elementId, message) {
	action.preventDefault();
	$("#e-" + elementId).text(message);
	$("#" + elementId).addClass("error-input");
	setTimeout(() => {
		$("#e-" + elementId).text("");
		$("#" + elementId).removeClass("error-input");
	}, 5000);
}

function spanErrorMessage(elementId, message) {
	action.preventDefault();
	$("#e-" + elementId).text(message);
	setTimeout(() => {
		$("#e-" + elementId).text("");
	}, 5000);
} 
