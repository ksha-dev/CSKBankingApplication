var form;
var customerType;
function initialize() {
	initializeDOBMax();
	form = document.getElementById('open-account-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function triggerCustomerType() {
	customerType = document.getElementById('customerType').value;
	if (customerType === "new") {
		document.getElementById('new-customer-fields').style.display = "block";
		document.getElementById('existing-customer-fields').style.display = "none";
	} else if (customerType === "existing") {
		document.getElementById('new-customer-fields').style.display = "none";
		document.getElementById('existing-customer-fields').style.display = "block";
	} else {
		document.getElementById('new-customer-fields').style.display = "none";
		document.getElementById('existing-customer-fields').style.display = "none";
	}
}

function submitValidation(e) {
	action = e;
	accountTypeCheck();
	amountCheck();
	customerTypeCheck();

	if (customerType === "new") {
		firstNameCheck();
		lastNameCheck();
		dateOfBirthCheck();
		phoneNumberCheck();
		genderCheck();
		emailCheck();
		addressCheck();
		aadhaarCheck();
		panCheck();
	} else if (customerType === "existing") {
		userIdCheck();
	} else {
		e.preventDefault();
	}
}

document.addEventListener('DOMContentLoaded', () => initialize());