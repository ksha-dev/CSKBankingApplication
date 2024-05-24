var form;
function initialize() {
	form = document.getElementById('login-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	userIdCheck();
	passwordCheck();
	captchaCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());