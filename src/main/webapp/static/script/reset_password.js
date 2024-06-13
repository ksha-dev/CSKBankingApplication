var form;
function initialize() {
	form = document.getElementById('reset-password-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	userIdCheck();
	emailCheck();
	captchaCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());
