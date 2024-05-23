package com.cskbank.api.mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import com.cskbank.consoleRunner.utility.LoggingUtil;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.utility.ValidatorUtil;

public class ServerConnection {
	private static Connection serverConnection = null;
	private static final String SERVER_URL = "jdbc:mysql://localhost:3306";
	private static final String SERVER_USER_NAME = "admin";
	private static final String SERVER_PASSWORD = "password";
	private static final String DATABASE = "CSKBank";

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			serverConnection = DriverManager.getConnection(SERVER_URL, SERVER_USER_NAME, SERVER_PASSWORD);
			try (Statement statement = serverConnection.createStatement()) {
				statement.executeUpdate("USE " + DATABASE);
			}
		} catch (ClassNotFoundException | SQLException e) {
			LoggingUtil.DEFAULT_LOGGER.warning(APIExceptionMessage.NO_SERVER_CONNECTION.toString());
		}
	}

	public static Connection getServerConnection() throws AppException {
		if (ValidatorUtil.isObjectNull(serverConnection)) {
			throw new AppException(APIExceptionMessage.NO_SERVER_CONNECTION);
		}
		return serverConnection;
	}

	public static void closeServerConnection() {
		if (!ValidatorUtil.isObjectNull(serverConnection)) {
			try {
				serverConnection.close();
			} catch (SQLException e) {
			}
		}
	}

	static void startTransaction() throws AppException {
		try {
			getServerConnection().setAutoCommit(false);
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	static void endTransaction() throws AppException {
		try {
			getServerConnection().commit();
			getServerConnection().setAutoCommit(true);
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	static void reverseTransaction() throws AppException {
		try {
			getServerConnection().rollback();
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		} finally {
			try {
				getServerConnection().setAutoCommit(true);
			} catch (SQLException e) {
				throw new AppException(e.getMessage());
			}
		}
	}
}
