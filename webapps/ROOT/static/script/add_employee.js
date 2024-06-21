var form;
var customerType;
function initialize() {
	initializeDOBMax();
	form = document.getElementById('add-employee-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	firstNameCheck();
	lastNameCheck();
	dateOfBirthCheck();
	phoneNumberCheck();
	genderCheck();
	roleCheck();
	emailCheck();
	addressCheck();
	branchIdCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());