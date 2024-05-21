package com.cskbank.exceptions;

import com.cskbank.exceptions.messages.ServletExceptionMessage;

public class AppException extends Exception {
	private static final long serialVersionUID = 1L;

	public AppException() {
		super();
	}

	public AppException(String message) {
		super(message);
	}

	public <T> AppException(T customEnum) {
		super(customEnum.toString());
	}

	public <T extends Enum<?>> AppException(T customEnum, String message) {
		super(customEnum.toString() + " - " + message);
	}

	public AppException(String parameter, ServletExceptionMessage message) {
		super("Error occured at " + parameter.toUpperCase() + "\\n " + message);
	}
}
