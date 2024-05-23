package com.cskbank.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import javax.crypto.SecretKey;

import com.cskbank.api.mysql.MySQLUserAPI;
import com.cskbank.api.mysql.ServerConnection;
import com.cskbank.consoleRunner.utility.LoggingUtil;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;

public class TableEncryptionTest {

	public static MySQLUserAPI api = new MySQLUserAPI();

	public static void main(String[] args) throws Exception {
		getUserIDs();
	}

	public static List<Integer> getUserIDs() throws AppException {
		List<Integer> userID = new LinkedList<Integer>();
		String getUserIdsQuery = "SELECT user_id FROM users order by user_id;";
		try (ResultSet result = ServerConnection.getServerConnection().prepareStatement(getUserIdsQuery)
				.executeQuery()) {
			while (result.next()) {
				userID.add(result.getInt(1));
				addEncryptedUserData(result.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userID;
	}

	public static void addEncryptedUserData(int userID) throws AppException {
		UserRecord user = api.getUserDetails(userID);

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement("INSERT INTO encrypted_user_data VALUE(?, ?, ?, ?)");) {
			SecretKey key = SecurityUtil.getSecretKey(user);
			statement.setInt(1, userID);
			statement.setString(2, SecurityUtil.encryptText(user.getDateOfBirth() + "", key));
			statement.setString(3, SecurityUtil.encryptText(user.getPhone() + "", key));
			statement.setString(4, SecurityUtil.encryptText(user.getEmail(), key));

			statement.executeUpdate();

			if (user.getType() == UserRecord.Type.CUSTOMER) {
				CustomerRecord customer = (CustomerRecord) user;
				try (PreparedStatement statement2 = ServerConnection.getServerConnection()
						.prepareStatement("INSERT INTO encrypted_customer_data VALUE(?, ?, ?)");) {
					statement2.setInt(1, userID);
					statement2.setString(2, SecurityUtil.encryptText(customer.getAadhaarNumber() + "", key));
					statement2.setString(3, SecurityUtil.encryptText(customer.getPanNumber(), key));
					statement2.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
