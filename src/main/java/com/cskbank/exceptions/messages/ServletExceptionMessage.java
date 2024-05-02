package com.cskbank.exceptions.messages;

public enum ServletExceptionMessage {

	INVALID_VALUE("The value obtained is invalid"), INVALID_AMOUNT("The amount obtained is invalid.");

	private String message;

	private ServletExceptionMessage(String message) {
		this.message = message;
	}

	public String toString() {
		return this.message;
	}
}
