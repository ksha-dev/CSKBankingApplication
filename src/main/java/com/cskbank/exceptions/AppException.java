package com.cskbank.exceptions;

import java.sql.SQLException;

import com.cskbank.exceptions.messages.ServletExceptionMessage;

public class AppException extends Exception {
	private static final long serialVersionUID = 1L;

	public AppException() {
		super();
	}

	public AppException(String message) {
		super(message);
	}

	public AppException(Enum<?> customEnum, Throwable e) {
		this(customEnum);
		this.initCause(e);
	}

	public AppException(SQLException sqlEx) {
		this("An Error occured. STATE_CODE : " + sqlEx.getSQLState() + " ERROR_CODE : " + sqlEx.getErrorCode());
	}

	public <T> AppException(Enum<?> customEnum) {
		super(customEnum.toString());
	}

	public AppException(Throwable e) {
		super(e.getMessage());
		this.initCause(e);
	}

	public AppException(String message, Throwable e) {
		super(message, e);
	}

	public <T extends Enum<?>> AppException(T customEnum, String message) {
		super(customEnum.toString() + " - " + message);
	}

	public AppException(String parameter, ServletExceptionMessage message) {
		super("Error occured at " + parameter.toUpperCase() + "\\n " + message);
	}
}
