var form;
function initialize() {
	form = document.getElementById('reset-password-input-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	newPasswordCheck();
	confirmPasswordCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());