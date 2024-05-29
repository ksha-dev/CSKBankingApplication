package com.cskbank.api.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.cskbank.api.UserAPI;
import com.cskbank.api.mysql.MySQLQuery.Column;
import com.cskbank.api.mysql.MySQLQuery.Schemas;
import com.cskbank.consoleRunner.utility.LoggingUtil;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;
import com.cskbank.utility.ConstantsUtil.TransactionType;

public class MySQLUserAPI implements UserAPI {

	@Override
	public boolean userAuthentication(int userId, String password) throws AppException {
		ValidatorUtil.validateId(userId);
		ValidatorUtil.validateObject(password);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.PASSWORD);
		queryBuilder.fromSchema(Schemas.CREDENTIALS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, userId);
			try (ResultSet authenticationResult = statement.executeQuery()) {
				if (authenticationResult.next()) {
					if (authenticationResult.getString(1).equals(SecurityUtil.encryptPasswordSHA256(password))) {
						return true;
					} else {
						throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
					}
				} else {
					throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public boolean userConfimration(int userId, String pin) throws AppException {
		ValidatorUtil.validateId(userId);
		ValidatorUtil.validatePIN(pin);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.PIN);
		queryBuilder.fromSchema(Schemas.CREDENTIALS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, userId);
			try (ResultSet authenticationResult = statement.executeQuery()) {
				if (authenticationResult.next()) {
					if (authenticationResult.getString(1).equals(SecurityUtil.encryptPasswordSHA256(pin))) {
						return true;
					} else {
						throw new AppException(APIExceptionMessage.USER_CONFIRMATION_FAILED);
					}
				} else {
					throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public UserRecord getUserDetails(int userId) throws AppException {
		ValidatorUtil.validateId(userId);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.USERS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, userId);
			try (ResultSet record = statement.executeQuery()) {
				if (record.next()) {
					UserRecord user = null;
					long createdAt = record.getLong(Column.CREATED_AT.toString());
					UserRecord.Type type = UserRecord.Type.convertStringToEnum(
							MySQLAPIUtil.getConstantFromId(Schemas.USER_TYPES, record.getInt(Column.TYPE.toString())));
					switch (type) {
					case CUSTOMER:
						user = MySQLAPIUtil.getCustomerRecord(userId, createdAt);
						break;
					case ADMIN:
					case EMPLOYEE:
						user = MySQLAPIUtil.getEmployeeRecord(userId);
						break;
					}
					MySQLConversionUtil.updateUserRecord(record, createdAt, user);
					return user;
				} else {
					throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public Map<Long, Account> getAccountsOfUser(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		Map<Long, Account> accounts = new LinkedHashMap<Long, Account>();

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.ACCOUNTS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.and();
		queryBuilder.not();
		queryBuilder.columnEquals(Column.STATUS);
		queryBuilder.sortField(Column.ACCOUNT_NUMBER, true);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, userId);
			statement.setInt(2, MySQLAPIUtil.getIdFromConstantValue(Schemas.STATUS, Status.CLOSED.toString()));
			try (ResultSet accountRS = statement.executeQuery()) {
				while (accountRS.next()) {
					accounts.put(accountRS.getLong(1), MySQLConversionUtil.convertToAccount(accountRS));
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
		return accounts;
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber,
			TransactionHistoryLimit timeLimit) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateId(pageNumber);
		ValidatorUtil.validateObject(timeLimit);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.TRANSACTIONS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.VIEWER_ACCOUNT_NUMBER);
		if (!(timeLimit == TransactionHistoryLimit.RECENT)) {
			queryBuilder.and();
			queryBuilder.columnBetweenTwoValues(Column.TIME_STAMP);
		}
		queryBuilder.sortField(Column.TRANSACTION_ID, timeLimit == TransactionHistoryLimit.RECENT);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			if (!(timeLimit == TransactionHistoryLimit.RECENT)) {
				statement.setLong(2, timeLimit.getDuration());
				statement.setLong(3, System.currentTimeMillis());
			}
			try (ResultSet transactionRS = statement.executeQuery()) {
				List<Transaction> transactions = new ArrayList<Transaction>();
				while (transactionRS.next()) {
					transactions.add(MySQLConversionUtil.convertToTransaction(transactionRS));
				}
				return transactions;
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateId(pageNumber);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.TRANSACTIONS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.VIEWER_ACCOUNT_NUMBER);
		queryBuilder.and();
		queryBuilder.columnBetweenTwoValues(Column.TIME_STAMP);
		queryBuilder.sortField(Column.TRANSACTION_ID, false);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			statement.setLong(2, startDate);
			statement.setLong(3, endDate);
			try (ResultSet transactionRS = statement.executeQuery()) {
				List<Transaction> transactions = new ArrayList<Transaction>();
				while (transactionRS.next()) {
					transactions.add(MySQLConversionUtil.convertToTransaction(transactionRS));
				}
				return transactions;
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public Account getAccountDetails(long accountNumber) throws AppException {
		ValidatorUtil.validateId(accountNumber);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.ACCOUNTS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.ACCOUNT_NUMBER);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			try (ResultSet result = statement.executeQuery()) {
				if (result.next()) {

					Account account = MySQLConversionUtil.convertToAccount(result);
					if (account.getStatus() == Status.CLOSED) {
						throw new AppException(APIExceptionMessage.ACCOUNT_CLOSED);
					}
					return account;
				} else {
					throw new AppException(APIExceptionMessage.ACCOUNT_RECORD_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public Transaction transferAmount(Transaction transaction, boolean transferWithinBank) throws AppException {
		ValidatorUtil.validateObject(transaction);
		try {
			ServerConnection.startTransaction();

			Account payeeAccount = getAccountDetails(transaction.getViewerAccountNumber());
			payeeAccount.setModifiedBy(transaction.getModifiedBy());
			payeeAccount.setModifiedAt(transaction.getCreatedAt());
			payeeAccount.setBalance(transaction.getClosingBalance());
			payeeAccount.setLastTransactedAt(transaction.getCreatedAt());
			if (!MySQLAPIUtil.updateBalanceInAccount(payeeAccount, true)) {
				throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
			}

			String remarks = transaction.getRemarks();
			transaction.setRemarks("DB-TRANSFER-ACC-" + transaction.getTransactedAccountNumber() + "-" + remarks);
			MySQLAPIUtil.createSenderTransactionRecord(transaction);

			if (transferWithinBank) {
				Account recepientAccount = getAccountDetails(transaction.getTransactedAccountNumber());
				recepientAccount.setModifiedBy(payeeAccount.getModifiedBy());
				recepientAccount.setModifiedAt(payeeAccount.getModifiedAt());
				recepientAccount.setBalance(ConvertorUtil
						.convertToTwoDecimals(recepientAccount.getBalance() + transaction.getTransactedAmount()));

				if (!MySQLAPIUtil.updateBalanceInAccount(recepientAccount, false)) {
					throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
				}

				// create receiver transaction
				Transaction reverseTransactionRecord = new Transaction();
				reverseTransactionRecord.setTransactionId(transaction.getTransactionId());
				reverseTransactionRecord.setUserId(recepientAccount.getUserId());
				reverseTransactionRecord.setViewerAccountNumber(transaction.getTransactedAccountNumber());
				reverseTransactionRecord.setTransactedAccountNumber(transaction.getViewerAccountNumber());
				reverseTransactionRecord.setTransactedAmount(transaction.getTransactedAmount());
				reverseTransactionRecord.setClosingBalance(recepientAccount.getBalance());
				reverseTransactionRecord.setTransactionType(TransactionType.CREDIT.getTransactionTypeId());
				reverseTransactionRecord
						.setRemarks("CR-TRANSFER-ACC-" + transaction.getViewerAccountNumber() + "-" + remarks);
				reverseTransactionRecord.setTimeStamp(transaction.getTimeStamp());
				reverseTransactionRecord.setCreatedAt(transaction.getCreatedAt());
				reverseTransactionRecord.setModifiedBy(transaction.getModifiedBy());

				MySQLAPIUtil.createReceiverTransactionRecord(reverseTransactionRecord);
			}
			ServerConnection.endTransaction();
			return transaction;
		} catch (AppException e) {
			ServerConnection.reverseTransaction();
			throw e;
		}
	}

	@Override
	public Branch getBranchDetails(int branchId) throws AppException {
		ValidatorUtil.validatePositiveNumber(branchId);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.BRANCH);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.BRANCH_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, branchId);
			try (ResultSet result = statement.executeQuery()) {
				if (result.next()) {
					return MySQLConversionUtil.convertToBranch(result);
				} else {
					throw new AppException(APIExceptionMessage.BRANCH_DETAILS_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
		}
	}

	@Override
	public boolean updateProfileDetails(UserRecord user, ModifiableField field, Object value) throws AppException {
		ValidatorUtil.validateObject(user);
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validateObject(field);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.USERS);
		queryBuilder.setColumn(Column.valueOf(field.toString()));
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setObject(1, value);
			statement.setInt(2, user.getUserId());
			statement.setLong(3, user.getModifiedAt());
			statement.setInt(4, user.getUserId());

			int response = statement.executeUpdate();
			if (response == 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
		}
	}

	@Override
	public boolean updatePassword(int customerId, String oldPassword, String newPassword) throws AppException {
		ValidatorUtil.validatePositiveNumber(customerId);
		ValidatorUtil.validatePassword(oldPassword);
		ValidatorUtil.validatePassword(newPassword);

		if (!userAuthentication(customerId, oldPassword)) {
			throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
		}

		if (newPassword.equals(oldPassword)) {
			throw new AppException(APIExceptionMessage.SAME_PASSWORD);
		}

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.CREDENTIALS);
		queryBuilder.setColumn(Column.PASSWORD);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setString(1, SecurityUtil.encryptPasswordSHA256(newPassword));
			statement.setInt(2, customerId);
			statement.setLong(3, System.currentTimeMillis());
			statement.setInt(4, customerId);
			int response = statement.executeUpdate();
			if (response == 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
		}
	}

	@Override
	public boolean resetPassword(int customerId, String newPassword) throws AppException {
		ValidatorUtil.validatePositiveNumber(customerId);
		ValidatorUtil.validatePassword(newPassword);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.CREDENTIALS);
		queryBuilder.setColumn(Column.PASSWORD);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setString(1, SecurityUtil.encryptPasswordSHA256(newPassword));
			statement.setInt(2, customerId);
			statement.setLong(3, System.currentTimeMillis());
			statement.setInt(4, customerId);
			int response = statement.executeUpdate();
			if (response == 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
		}
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, TransactionHistoryLimit timeLimit) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateObject(timeLimit);

		if (timeLimit == TransactionHistoryLimit.RECENT) {
			return 1;
		}

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.TRANSACTIONS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.VIEWER_ACCOUNT_NUMBER);
		queryBuilder.and();
		queryBuilder.columnBetweenTwoValues(Column.TIME_STAMP);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			statement.setLong(2, timeLimit.getDuration());
			statement.setLong(3, System.currentTimeMillis());

			try (ResultSet countRS = statement.executeQuery()) {
				if (countRS.next()) {
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, long startDate, long endDate) throws AppException {
		ValidatorUtil.validateId(accountNumber);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.TRANSACTIONS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.VIEWER_ACCOUNT_NUMBER);
		queryBuilder.and();
		queryBuilder.columnBetweenTwoValues(Column.TIME_STAMP);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			statement.setLong(2, startDate);
			statement.setLong(3, endDate);

			try (ResultSet countRS = statement.executeQuery()) {
				if (countRS.next()) {
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public boolean logOperation(AuditLog auditLog) throws AppException {
		ValidatorUtil.validateId(auditLog.getUserId());
		ValidatorUtil.validateId(auditLog.getTargetId());
		ValidatorUtil.validateObject(auditLog.getLogOperation());
		ValidatorUtil.validateObject(auditLog.getOperationStatus());
		ValidatorUtil.validateObject(auditLog.getDescription());

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.AUDIT_LOGS);
		queryBuilder.insertColumns(List.of(Column.USER_ID, Column.OPERATION, Column.STATUS, Column.DESCRIPTION,
				Column.MODIFIED_AT, Column.TARGET_ID));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery());) {
			statement.setInt(1, auditLog.getUserId());
			statement.setString(2, auditLog.getLogOperation().toString());
			statement.setString(3, auditLog.getOperationStatus().toString());
			statement.setString(4, auditLog.getDescription());
			statement.setLong(5, auditLog.getModifiedAt());
			statement.setInt(6, auditLog.getTargetId());

			int response = statement.executeUpdate();
			return response == 1;
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.LOGGING_FAILED);
		}
	}

	@Override
	public UserRecord getUserRecordDetails(Integer userID) throws AppException {
		ValidatorUtil.validateObject(userID);
		return getUserDetails((int) userID);
	}

	@Override
	public Branch getBranchDetails(Integer branchId) throws AppException {
		ValidatorUtil.validateObject(branchId);
		return getBranchDetails((int) branchId);
	}

	@Override
	public Account getAccountDetails(Long accountNumber) throws AppException {
		ValidatorUtil.validateObject(accountNumber);
		return getAccountDetails((long) accountNumber);
	}

	@Override
	public APIKey getAPIKey(int akId) throws AppException {
		ValidatorUtil.validateId(akId);
		MySQLQuery query = new MySQLQuery();
		query.selectColumn(Column.ALL);
		query.fromSchema(Schemas.API_KEYS);
		query.where();
		query.columnEquals(Column.AK_ID);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setLong(1, akId);
			try (ResultSet apiKeyRS = statement.executeQuery()) {
				if (apiKeyRS.next()) {
					return MySQLConversionUtil.convertToAPIKey(apiKeyRS);
				}
			}
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND);
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND);
		}
	}

	@Override
	public APIKey getAPIKey(String apiKeyValue) throws AppException {
		ValidatorUtil.validateAPIKey(apiKeyValue);
		MySQLQuery query = new MySQLQuery();
		query.selectColumn(Column.ALL);
		query.fromSchema(Schemas.API_KEYS);
		query.where();
		query.columnEquals(Column.API_KEY);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setString(1, apiKeyValue);
			try (ResultSet apiKeyRS = statement.executeQuery()) {
				if (apiKeyRS.next()) {
					return MySQLConversionUtil.convertToAPIKey(apiKeyRS);
				}
			}
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND);
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND);
		}
	}

	@Override
	public APIKey invalidateApiKey(APIKey apiKey) throws AppException {
		ValidatorUtil.validateObject(apiKey);
		MySQLQuery query = new MySQLQuery();
		query.update(Schemas.API_KEYS);
		query.setColumn(Column.MODIFIED_AT);
		query.separator();
		query.columnEquals(Column.IS_ACTIVE);
		query.where();
		query.columnEquals(Column.AK_ID);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setLong(1, apiKey.getModifiedAt());
			statement.setBoolean(2, apiKey.getIsActive());
			statement.setLong(3, apiKey.getAkId());
			statement.executeUpdate();

			return apiKey;
		} catch (SQLException e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
		}
	}

	@Override
	public boolean doesEmailExist(String email) throws AppException {
		ValidatorUtil.validateEmail(email);

		MySQLQuery query = new MySQLQuery();
		query.selectCount(Schemas.USERS);
		query.where();
		query.columnEquals(Column.EMAIL);
		query.limit(1);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setString(1, SecurityUtil.encryptText(email));

			try (ResultSet result = statement.executeQuery()) {
				if (result.next()) {
					return result.getInt(1) > 0;
				}
			}
			throw new AppException(APIExceptionMessage.EMAIL_CHECK_FAILED);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.EMAIL_CHECK_FAILED);
		}
	}

	@Override
	public boolean doesEmailBelongToUser(int userId, String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		ValidatorUtil.validateId(userId);

		MySQLQuery query = new MySQLQuery();
		query.selectCount(Schemas.USERS);
		query.where();
		query.columnEquals(Column.USER_ID);
		query.and();
		query.columnEquals(Column.EMAIL);
		query.limit(1);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setInt(1, userId);
			statement.setString(2, SecurityUtil.encryptText(email));

			try (ResultSet result = statement.executeQuery()) {
				if (result.next()) {
					return result.getInt(1) > 0;
				}
			}
			throw new AppException(APIExceptionMessage.USER_EMAIL_INCORRECT);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.USER_EMAIL_INCORRECT);
		}
	}
}