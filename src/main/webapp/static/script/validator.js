function regexValidator(elementId, displayName, regex) {
	const value = document.getElementById(elementId).value;
	if (value === null) {
		spanErrorMessageBelowInput(elementId, "Enter your " + displayName);
	} else if (new RegExp(regex).test(value) === false) {
		spanErrorMessageBelowInput(elementId, "Not a valid " + displayName);
	}
}

function nullValidator(elementId, displayName) {
	const value = document.getElementById(elementId).value;
	if (value === null || value === "null" || value === "") {
		spanErrorMessageBelowInput(elementId, "Enter your " + displayName);
	}
}

function nonZeroPositiveNumberCheck(elementId, displayName) {
	nullValidator(elementId, displayName);
	if ($("#" + elementId).val() <= 0) {
		spanErrorMessageBelowInput(elementId, displayName + " cannot be negative or zero");
	}
}


function userIdCheck() {
	regexValidator("userId", "User ID", "^[1-9]\\d*$");
}

function inputPasswordCheck() {
	passwordCheck('password', "Password");
}

function passwordCheck(elementId, displayName) {
	const password = document.getElementById(elementId).value;
	if (password === null) {
		spanErrorMessageBelowInput(elementId, "Enter your " + displayName);
	} else if (new RegExp("^((?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20})$").test(password) === false) {
		spanErrorMessageBelowInput(elementId, "Invalid Password");
		runtimeError("Password must start with a letter, " +
			"contain atleast one speical character, " +
			"<br>number, mixed cases and should range " +
			"between 8 to 20 characters");
	}
}


function captchaCheck() {
	const captchaResponse = grecaptcha.enterprise.getResponse();
	if (captchaResponse.length < 1) {
		spanErrorMessageBelowInput("captcha", "Please click here to verify");
	}
}

function firstNameCheck() {
	regexValidator("firstName", "First Name", "^[A-Za-z]{4,}$");
}

function lastNameCheck() {
	regexValidator("lastName", "Last Name", "^[A-Za-z]{1,}$");
}

function dateOfBirthCheck() {
	nullValidator("dateOfBirth", "Date of Birth");
	const dateOfBirth = new Date(document.getElementById('dateOfBirth').value);
	if (dateOfBirth > new Date()) {
		action.preventDefault();
		spanErrorMessageBelowInput("dateOfBirth", "Invalid Date of Birth");
	}
}

function phoneNumberCheck() {
	regexValidator("phone", "Phone Number", "^[7-9]\\d{9}$");
}

function genderCheck() {
	nullValidator("gender", "Gender");
}

function emailCheck() {
	regexValidator("email", "Email ID", "^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
}

function addressCheck() {
	nullValidator("address", "Address");
}

function aadhaarCheck() {
	regexValidator("aadhaar", "Aadhaar Number", "^[2-9]\\d{11}$")
}

function panCheck() {
	regexValidator("pan", "PAN", "^[A-Z]{3}[ABCFGHLJPT][A-Z]\\d{4}[A-Z]$");
}

function accountTypeCheck() {
	nullValidator("accountType", "Account Type");
}

function amountCheck() {
	nonZeroPositiveNumberCheck("amount", "Amount");
}

function customerTypeCheck() {
	nullValidator('customerType', "Customer Type");
}

function searchByCheck() {
	nullValidator('searchBy', "Search By");
}

function searchValueCheck() {
	nonZeroPositiveNumberCheck('searchValue', "Search Value");
}

function oldPasswordCheck() {
	passwordCheck('oldPassword', "Old Password");
}

function newPasswordCheck() {
	passwordCheck('newPassword', "New Password");
	if ($("#newPassword").val() === $("#oldPassword").val()) {
		spanErrorMessageBelowInput("newPassword", "New password cannot be same as Old password");
	}
}

function confirmPasswordCheck() {
	passwordCheck('confirmPassword', 'Confirm Password');
	if ($("#newPassword").val() !== $("#confirmPassword").val()) {
		spanErrorMessageBelowInput("confirmPassword", "Password do not match");
	}
}

function fromAccountCheck() {
	nonZeroPositiveNumberCheck("fromAccount", "Sender Account");
}

function toAccountCheck() {
	nonZeroPositiveNumberCheck("toAccount", "Receipient Account");
}

function remarksCheck() {
	nullValidator("remarks", "Remarks");
	if ($("#remarks").val().length < 5) {
		spanErrorMessageBelowInput("remarks", "Remarks must contain a minimum of 5 characters");
	}
}

function accountNumberCheck() {
	nonZeroPositiveNumberCheck("accountNumber", "Account Number");
}

function transactionLimitCheck() {
	nullValidator("transactionLimit", "Transaction Limit");
}



function customDateCheck() {
	nullValidator("startDate", "Start Date");
	nullValidator("endDate", "End Date");

	const startDate = new Date($("#startDate").val());
	const endDate = new Date($("#endDate").val());
	const today = new Date();

	console.log(startDate);
	console.log(endDate);

	if (startDate > today) {
		spanErrorMessageBelowInput("startDate", "Please select a valid start date.");
	}

	if (endDate > today) {
		spanErrorMessageBelowInput("endDate", "Please select a valid start date.");
	}

	if (startDate >= endDate) {
		spanErrorMessageBelowInput("endDate", "End date should be greater than Start date");
	}
}

function transactionTypeCheck() {
	nullValidator("transactionType", "Transaction Type");
}

function branchIdCheck() {
	nonZeroPositiveNumberCheck("branchId", "Branch ID");
}

function roleCheck() {
	nullValidator("role", "Employee Role")
}