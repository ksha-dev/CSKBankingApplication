var form;
function initialize() {
	form = document.getElementById('change-password-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	oldPasswordCheck();
	newPasswordCheck();
	confirmPasswordCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());