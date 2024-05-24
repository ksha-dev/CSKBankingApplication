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


function userIdCheck() {
	regexValidator("userId", "User ID", "^[1-9]\\d*$");
}

function passwordCheck() {
	const password = document.getElementById('password').value;
	if (password === null) {
		spanErrorMessageBelowInput("password", "Enter your password");
	} else if (new RegExp("^((?=[^\\d])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!_+-@^#$%&]).{8,20})$").test(password) === false) {
		spanErrorMessageBelowInput("password", "Invalid Password");
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
