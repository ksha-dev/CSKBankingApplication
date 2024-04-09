package api.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import api.UserAPI;
import api.mysql.MySQLQuery.Column;
import api.mysql.MySQLQuery.Schemas;
import consoleRunner.utility.LoggingUtil;
import exceptions.AppException;
import exceptions.messages.APIExceptionMessage;
import modules.Account;
import modules.Branch;
import modules.Transaction;
import modules.UserRecord;
import utility.ConvertorUtil;
import utility.ConstantsUtil;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.TransactionType;
import utility.ConstantsUtil.UserType;
import utility.ValidatorUtil;

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
					if (authenticationResult.getString(1).equals(ConvertorUtil.passwordHasher(password))) {
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
					if (authenticationResult.getString(1).equals(ConvertorUtil.passwordHasher(pin))) {
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
					UserType type = UserType.getUserType(Integer.parseInt(record.getString(Column.TYPE.toString())));
					switch (type) {
					case CUSTOMER:
						user = MySQLAPIUtil.getCustomerRecord(userId);
						break;
					case ADMIN:
					case EMPLOYEE:
						user = MySQLAPIUtil.getEmployeeRecord(userId);
						break;
					}
					MySQLConversionUtil.updateUserRecord(record, user);
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
			statement.setString(2, Status.CLOSED.getStatusId() + "");
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

			System.out.println(statement);
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

		System.out.println(queryBuilder.getQuery());

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
	public long transferAmount(Transaction transaction, boolean isTransferWithinBank) throws AppException {
		ValidatorUtil.validateObject(transaction);
		try {
			ServerConnection.startTransaction();
			Account payeeAccount = getAccountDetails(transaction.getViewerAccountNumber());
			LoggingUtil.logAccount(payeeAccount);
			if (payeeAccount.getStatus() == Status.FROZEN) {
				throw new AppException(APIExceptionMessage.ACCOUNT_RESTRICTED);
			}
			if (payeeAccount.getBalance() < transaction.getTransactedAmount()) {
				throw new AppException(APIExceptionMessage.INSUFFICIENT_BALANCE);
			}
			transaction.setClosingBalance(
					ConvertorUtil.convertToTwoDecimals(payeeAccount.getBalance() - transaction.getTransactedAmount()));
			if (!MySQLAPIUtil.updateBalanceInAccount(transaction.getViewerAccountNumber(),
					transaction.getClosingBalance())) {
				throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
			}
			transaction.setTransactionType(TransactionType.DEBIT.getTransactionTypeId());
			long transactionId = transaction.getTransactionId();
			String remarks = transaction.getRemarks();
			transaction.setRemarks("DB-TRANSFER-ACC-" + transaction.getTransactedAccountNumber() + "-" + remarks);
			MySQLAPIUtil.createSenderTransactionRecord(transaction);
			if (isTransferWithinBank) {
				Account recepientAccount = getAccountDetails(transaction.getTransactedAccountNumber());

				// update the balance in receiver account
				double recepientNewBalance = ConvertorUtil
						.convertToTwoDecimals(recepientAccount.getBalance() + transaction.getTransactedAmount());
				if (!MySQLAPIUtil.updateBalanceInAccount(transaction.getTransactedAccountNumber(),
						recepientNewBalance)) {
					throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
				}
				recepientAccount.setBalance(recepientNewBalance);

				// create receiver transaction
				Transaction reverseTransactionRecord = new Transaction();
				reverseTransactionRecord.setTransactionId(transactionId);
				reverseTransactionRecord.setUserId(recepientAccount.getUserId());
				reverseTransactionRecord.setViewerAccountNumber(transaction.getTransactedAccountNumber());
				reverseTransactionRecord.setTransactedAccountNumber(transaction.getViewerAccountNumber());
				reverseTransactionRecord.setTransactedAmount(transaction.getTransactedAmount());
				reverseTransactionRecord.setTransactionType(TransactionType.CREDIT.getTransactionTypeId());
				reverseTransactionRecord
						.setRemarks("CR-TRANSFER-ACC-" + transaction.getViewerAccountNumber() + "-" + remarks);
				reverseTransactionRecord.setClosingBalance(recepientAccount.getBalance());
				MySQLAPIUtil.createReceiverTransactionRecord(reverseTransactionRecord);
			}
			ServerConnection.endTransaction();
			return transactionId;
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
	public boolean updateProfileDetails(int userId, ModifiableField field, Object value) throws AppException {
		ValidatorUtil.validatePositiveNumber(userId);
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validateObject(field);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.USERS);
		queryBuilder.setColumn(Column.valueOf(field.toString()));
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setObject(1, value);
			statement.setInt(2, userId);
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
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setString(1, ConvertorUtil.passwordHasher(newPassword));
			statement.setInt(2, customerId);
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
					return countRS.getInt(1) / ConstantsUtil.LIST_LIMIT + 1;
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
					int pageCount = countRS.getInt(1) / ConstantsUtil.LIST_LIMIT + 1;
					return pageCount < 10 ? pageCount : 10;
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}
}