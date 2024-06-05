package com.cskbank.exceptions;

import java.sql.SQLException;

import com.cskbank.exceptions.messages.ServletExceptionMessage;
import com.mysql.cj.exceptions.MysqlErrorNumbers;
import com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping;

public class AppException extends Exception {
	private static final long serialVersionUID = 1L;

	public AppException() {
		super();
	}

	public AppException(String message) {
		super(message);
	}

	public AppException(SQLException sqlEx) {
		this("An Error occured. STATE_CODE : " + sqlEx.getSQLState() + " ERROR_CODE : " + sqlEx.getErrorCode());
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
