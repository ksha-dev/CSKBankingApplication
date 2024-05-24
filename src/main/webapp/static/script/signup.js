var form;
function initialize() {
	form = document.getElementById('signup-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	e.preventDefault();
	firstNameCheck();
	lastNameCheck();
	dateOfBirthCheck();
	phoneNumberCheck();
	genderCheck();
	emailCheck();
	addressCheck();
	aadhaarCheck();
	panCheck();
	captchaCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());