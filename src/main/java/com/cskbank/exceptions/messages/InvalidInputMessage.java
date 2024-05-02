package com.cskbank.exceptions.messages;

public enum InvalidInputMessage {
	INVALID_FIRST_NAME("The first name must contain atleast 4 characters."),
	INVALID_LAST_NAME("The last name must contain atleast 1 characters."),
	INVALID_MOBILE_NUMBER("The mobile number should contain 10 digits. First digit should be between 7 and 9"),
	INVALID_EMAIL("The email address is invalid"), INVALID_AADHAAR_NUMBER("The Aadhaar number is invalid"),
	INVALID_PAN_NUMBER("The PAN number is invalid"),
	INVALID_DOB("The date of birth cannot exceed the current date and time and should be valid"),
	INVALID_ID("An Identifier value cannot be less than 1"), INVALID_GENDER("Invalid Gender"),
	INVALID_INTEGER_INPUT("A number is expected."), INVALID_DATE_INPUT("The date of birth entered is incorrect."),
	INVALID_DATE_STRING("Invalid Date Obtained"),
	INVALID_PASSWORD("The password must contain a minimum of 8 characters with both "
			+ "upper and lower case, start with a letter, have a special character and a number"),
	INVALID_AMOUNT("The minimum required amount for a transaction is Rs. 1.00"),
	INVALID_API_KEY("The API key obtained is invalid"), POSITIVE_INTEGER_REQUIRED("A positive value value is expected"),
	NULL_OBJECT_ENCOUNTERED("A valid object is expected");

	private String message;

	private InvalidInputMessage(String message) {
		this.message = message;
	}

	public String toString() {
		return message;
	}
}
