package com.cskbank.api.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.cskbank.api.EmployeeAPI;
import com.cskbank.api.mysql.MySQLQuery.Column;
import com.cskbank.api.mysql.MySQLQuery.Schemas;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.Account;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.AccountType;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConstantsUtil.TransactionType;

public class MySQLEmployeeAPI extends MySQLUserAPI implements EmployeeAPI {

	private void createCredentialRecord(UserRecord user) throws AppException {
		ValidatorUtil.validatePositiveNumber(user.getUserId());

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.CREDENTIALS);
		queryBuilder.insertValuePlaceholders(6);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, user.getUserId());
			statement.setString(2, ConvertorUtil.passwordGenerator(user));
			statement.setString(3, ConvertorUtil.pinGenerator(user));
			statement.setLong(4, user.getCreatedAt());
			statement.setInt(5, user.getModifiedBy());
			statement.setObject(6, null);

			statement.executeUpdate();
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	protected void createUserRecord(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.USERS);
		queryBuilder.insertColumns(List.of(Column.FIRST_NAME, Column.LAST_NAME, Column.DATE_OF_BIRTH, Column.GENDER,
				Column.ADDRESS, Column.PHONE, Column.EMAIL, Column.TYPE, Column.CREATED_AT, Column.MODIFIED_BY,
				Column.MODIFIED_AT));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery(), Statement.RETURN_GENERATED_KEYS)) {
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setLong(3, user.getDateOfBirth());
			statement.setString(4, user.getGender().getGenderId() + "");
			statement.setString(5, user.getAddress());
			statement.setLong(6, user.getPhone());
			statement.setString(7, user.getEmail());
			statement.setString(8, user.getType().getUserTypeId() + "");
			statement.setLong(9, user.getCreatedAt());
			statement.setInt(10, user.getModifiedBy());
			statement.setObject(11, null);

			statement.executeUpdate();
			try (ResultSet key = statement.getGeneratedKeys()) {
				if (key.next()) {
					user.setUserId(key.getInt(1));
					createCredentialRecord(user);
				} else {
					throw new AppException(APIExceptionMessage.USER_CREATION_FAILED);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public int createCustomer(CustomerRecord customer) throws AppException {
		try {
			ServerConnection.startTransaction();
			createUserRecord(customer);

			MySQLQuery queryBuilder = new MySQLQuery();
			queryBuilder.insertInto(Schemas.CUSTOMERS);
			queryBuilder.insertValuePlaceholders(5);
			queryBuilder.end();

			try (PreparedStatement statement = ServerConnection.getServerConnection()
					.prepareStatement(queryBuilder.getQuery())) {
				statement.setInt(1, customer.getUserId());
				statement.setLong(2, customer.getAadhaarNumber());
				statement.setString(3, customer.getPanNumber());

				int response = statement.executeUpdate();
				if (response == 1) {
					ServerConnection.endTransaction();
					return customer.getUserId();
				} else {
					throw new AppException(APIExceptionMessage.USER_CREATION_FAILED);
				}
			}
		} catch (SQLException e) {
			ServerConnection.reverseTransaction();
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public long createAccount(Account account) throws AppException {
		ValidatorUtil.validateObject(account);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.ACCOUNTS);
		queryBuilder.insertColumns(List.of(Column.USER_ID, Column.TYPE, Column.BRANCH_ID, Column.OPENING_DATE,
				Column.CREATED_AT, Column.MODIFIED_AT, Column.MODIFIED_BY));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery(), Statement.RETURN_GENERATED_KEYS)) {
			statement.setInt(1, account.getUserId());
			statement.setString(2, account.getAccountType().getAccountTypeId() + "");
			statement.setInt(3, account.getBranchId());
			statement.setLong(4, account.getOpeningDate());
			statement.setLong(5, account.getCreatedAt());
			statement.setInt(6, account.getModifiedBy());
			statement.setObject(7, null);

			int response = statement.executeUpdate();
			try (ResultSet key = statement.getGeneratedKeys()) {
				if (key.next() && response == 1) {
					return key.getLong(1);
				} else {
					throw new AppException(APIExceptionMessage.ACCOUNT_CREATION_FAILED);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e.getMessage());
		}
	}

	@Override
	public Map<Long, Account> viewAccountsInBranch(int branchId, int pageNumber) throws AppException {
		ValidatorUtil.validateId(branchId);
		ValidatorUtil.validateId(pageNumber);
		Map<Long, Account> accounts = new LinkedHashMap<Long, Account>();

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectColumn(Column.ALL);
		queryBuilder.fromSchema(Schemas.ACCOUNTS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.BRANCH_ID);
		queryBuilder.sortField(Column.ACCOUNT_NUMBER, true);
		queryBuilder.limit(ConstantsUtil.LIST_LIMIT);
		queryBuilder.offset(ConvertorUtil.convertPageToOffset(pageNumber));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, branchId);
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
	public int getNumberOfPagesOfAccounts(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.ACCOUNTS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.BRANCH_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setInt(1, branchId);

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

	@Override
	public long depositAmount(Transaction depositTransaction) throws AppException {
		ValidatorUtil.validateObject(depositTransaction);
		try {
			ServerConnection.startTransaction();

			Account transactionAccount = getAccountDetails(depositTransaction.getViewerAccountNumber());
			transactionAccount.setModifiedBy(depositTransaction.getModifiedBy());
			transactionAccount.setModifiedAt(depositTransaction.getCreatedAt());
			MySQLAPIUtil.updateBalanceInAccount(transactionAccount);

			MySQLAPIUtil.createSenderTransactionRecord(depositTransaction);
			ServerConnection.endTransaction();
			return depositTransaction.getTransactionId();

		} catch (AppException e) {
			ServerConnection.reverseTransaction();
			throw e;
		}
	}

	@Override
	public long withdrawAmount(Transaction withdrawTransaction) throws AppException {
		ValidatorUtil.validateObject(withdrawTransaction);
		try {
			ServerConnection.startTransaction();
			Account transactionAccount = getAccountDetails(withdrawTransaction.getViewerAccountNumber());
			transactionAccount.setModifiedBy(withdrawTransaction.getModifiedBy());
			transactionAccount.setModifiedAt(withdrawTransaction.getCreatedAt());
			transactionAccount.setLastTransactedAt(withdrawTransaction.getCreatedAt());
			transactionAccount.setBalance(withdrawTransaction.getClosingBalance());

			if (!MySQLAPIUtil.updateBalanceInAccount(transactionAccount)) {
				throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
			}

			MySQLAPIUtil.createSenderTransactionRecord(withdrawTransaction);
			ServerConnection.endTransaction();
			return withdrawTransaction.getTransactionId();

		} catch (AppException e) {
			ServerConnection.reverseTransaction();
			throw e;
		}
	}

	@Override
	public boolean changeAccountStatus(Account account) throws AppException {
		ValidatorUtil.validateObject(account);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.ACCOUNTS);
		queryBuilder.setColumn(Column.STATUS);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_BY);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.MODIFIED_AT);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.ACCOUNT_NUMBER);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setString(1, account.getStatus().getStatusId() + "");
			statement.setInt(2, account.getModifiedBy());
			statement.setLong(3, account.getModifiedAt());
			statement.setLong(4, account.getAccountNumber());

			System.out.println(statement);
			int response = statement.executeUpdate();
			if (response == 1) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.STATUS_UPDATE_FAILED);
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}
}