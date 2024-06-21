var form;
function initialize() {
	initializeDOBMax();
	form = document.getElementById('signup-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	firstNameCheck();
	lastNameCheck();
	dateOfBirthCheck();
	phoneNumberCheck();
	genderCheck();
	emailCheck();
	addressCheck();
	aadhaarCheck();
	panCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());