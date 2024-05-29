//package com.cskbank.test;
//
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//import javax.crypto.SecretKey;
//
//import com.cskbank.api.mysql.ServerConnection;
//import com.cskbank.exceptions.AppException;
//import com.cskbank.utility.SecurityUtil;
//
//class TableEncryptionTest {
//
//	private static String userTable = "users";
//	private static String customerTable = "customers";
//
//	void startEncryption() throws AppException {
//
//		String getUserQuery = "SELECT user_id, created_at, date_of_birth, phone, email, type FROM " + userTable + ";";
//
//		try (ResultSet result = ServerConnection.getServerConnection().prepareStatement(getUserQuery).executeQuery()) {
//			ServerConnection.startTransaction();
//			while (result.next()) {
//				encryptUserRecord(result);
//			}
//			ServerConnection.endTransaction();
//		} catch (Exception e) {
//			ServerConnection.reverseTransaction();
//			e.printStackTrace();
//		}
//	}
//
//	private static void encryptUserRecord(ResultSet result) throws Exception {
//		int userId = result.getInt(1);
//		long createdAt = result.getLong(2);
//		long dob = result.getLong(3);
//		long phone = result.getLong(4);
//		String email = result.getString(5);
//		int type = result.getInt(6);
//
//		String updateUserQuery = "UPDATE " + userTable
//				+ " SET date_of_birth = ?, phone = ?, email = ? WHERE user_id = ?";
//		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(updateUserQuery)) {
//			SecretKey key = SecurityUtil.getSecreteKey(userId, createdAt);
//			statement.setString(1, SecurityUtil.encryptText(dob + "", key));
//			statement.setString(2, SecurityUtil.encryptText(phone + "", key));
//			statement.setString(3, SecurityUtil.encryptText(email));
//			statement.setInt(4, userId);
//
//			System.out.println(statement);
//			statement.executeUpdate();
//			if (type == 1)
//				encryptCustomerRecord(userId, createdAt, key);
//		}
//
//	}
//
//	private static void encryptCustomerRecord(int userId, long createdAt, SecretKey key) throws Exception {
//		String getCustomerQuery = "SELECT aadhaar_number, pan_number from " + customerTable + " WHERE user_id = "
//				+ userId + ";";
//		try (ResultSet result = ServerConnection.getServerConnection().prepareStatement(getCustomerQuery)
//				.executeQuery()) {
//			if (result.next()) {
//				String updateCustomerQuery = "UPDATE " + customerTable
//						+ " SET aadhaar_number = ?, pan_number = ? WHERE user_id = ?;";
//				try (PreparedStatement statement = ServerConnection.getServerConnection()
//						.prepareStatement(updateCustomerQuery)) {
//					statement.setString(1, SecurityUtil.encryptText(result.getString(1), key));
//					statement.setString(2, SecurityUtil.encryptText(result.getString(2), key));
//					statement.setInt(3, userId);
//
//					System.out.println(statement);
//
//					statement.executeUpdate();
//				}
//			}
//		}
//	}
//
//}