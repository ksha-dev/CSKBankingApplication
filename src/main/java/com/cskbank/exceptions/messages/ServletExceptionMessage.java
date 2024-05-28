package com.cskbank.exceptions.messages;

public enum ServletExceptionMessage {

	INVALID_VALUE("The value obtained is invalid"), INVALID_AMOUNT("The amount obtained is invalid."),
	TRANSACTION_TIMED_OUT("Transaction has been expired"),
	INVALID_OBJECT("Cannot process the request. Invalid object obtained"),
	PASSWORDS_DONT_MATCH("New password and confirm password do not match"),
	PASSWORD_RESET_LINK_EXPIRED("Reset Password Link Expired");

	private String message;

	private ServletExceptionMessage(String message) {
		this.message = message;
	}

	public String toString() {
		return this.message;
	}
}
