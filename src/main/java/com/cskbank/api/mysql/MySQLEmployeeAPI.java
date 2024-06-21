package com.cskbank.api.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;

import com.cskbank.api.EmployeeAPI;
import com.cskbank.api.mysql.MySQLQuery.Column;
import com.cskbank.api.mysql.MySQLQuery.Schemas;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;

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
			statement.setString(2, SecurityUtil.passwordGenerator(user));
			statement.setString(3, SecurityUtil.generatePIN(user));
			statement.setLong(4, user.getCreatedAt());
			statement.setInt(5, user.getModifiedBy());
			statement.setObject(6, null);

			statement.executeUpdate();
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	private void updateSecureUserData(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.update(Schemas.USERS);
		queryBuilder.setColumn(Column.DATE_OF_BIRTH);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.PHONE);
		queryBuilder.separator();
		queryBuilder.columnEquals(Column.EMAIL);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.USER_ID);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			SecretKey key = SecurityUtil.getSecretKey(user);
			statement.setString(1, SecurityUtil.encryptText(user.getDateOfBirth() + "", key));
			statement.setString(2, SecurityUtil.encryptText(user.getPhone() + "", key));
			statement.setString(3, SecurityUtil.encryptText(user.getEmail()));
			statement.setInt(4, user.getUserId());

			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			System.out.println(e.getSQLState());
			System.out.println(e.getLocalizedMessage());
			throw new AppException(e);
		}
	}

	@Override
	public void createUserRecord(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.USERS);
		queryBuilder.insertColumns(List.of(Column.FIRST_NAME, Column.LAST_NAME, Column.GENDER, Column.ADDRESS,
				Column.TYPE, Column.STATUS, Column.CREATED_AT, Column.MODIFIED_BY, Column.MODIFIED_AT));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery(), Statement.RETURN_GENERATED_KEYS)) {

			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setInt(3, MySQLAPIUtil.getIdFromConstantValue(Schemas.GENDER, user.getGender().toString()));
			statement.setString(4, user.getAddress());
			statement.setInt(5, MySQLAPIUtil.getIdFromConstantValue(Schemas.USER_TYPES, user.getType().toString()));
			statement.setInt(6, MySQLAPIUtil.getIdFromConstantValue(Schemas.STATUS, user.getStatus().toString()));
			statement.setLong(7, user.getCreatedAt());
			statement.setInt(8, user.getModifiedBy());
			statement.setObject(9, null);

			statement.executeUpdate();
			try (ResultSet result = statement.getGeneratedKeys()) {
				if (result.next()) {
					user.setUserId(result.getInt(1));
					updateSecureUserData(user);
					createCredentialRecord(user);
				} else {
					throw new AppException(APIExceptionMessage.USER_CREATION_FAILED);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getErrorCode());
			throw new AppException(e);
		}
	}

	@Override
	public int createCustomer(CustomerRecord customer) throws AppException {
		try {
			ServerConnection.startTransaction();
			createUserRecord(customer);

			MySQLQuery queryBuilder = new MySQLQuery();
			queryBuilder.insertInto(Schemas.CUSTOMERS);
			queryBuilder.insertValuePlaceholders(3);
			queryBuilder.end();

			try (PreparedStatement statement = ServerConnection.getServerConnection()
					.prepareStatement(queryBuilder.getQuery())) {
				SecretKey key = SecurityUtil.getSecretKey(customer);

				statement.setInt(1, customer.getUserId());
				statement.setString(2, SecurityUtil.encryptText(customer.getAadhaarNumber() + "", key));
				statement.setString(3, SecurityUtil.encryptText(customer.getPanNumber(), key));

				System.out.println(statement);

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
			throw new AppException(e);
		}
	}

	@Override
	public long createAccount(Account account) throws AppException {
		ValidatorUtil.validateObject(account);

		Branch branch = getBranchDetails(account.getBranchId());
		branch.setAccountsCount(branch.getAccountsCount() + 1);
		account.setAccountNumber(
				Long.parseLong(String.format("%d%010d", branch.getBranchId(), branch.getAccountsCount())));
		System.out.println(account.getAccountNumber());

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.insertInto(Schemas.ACCOUNTS);
		queryBuilder.insertColumns(List.of(Column.ACCOUNT_NUMBER, Column.USER_ID, Column.TYPE, Column.BRANCH_ID,
				Column.OPENING_DATE, Column.CREATED_AT, Column.MODIFIED_AT, Column.MODIFIED_BY));
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, account.getAccountNumber());
			statement.setInt(2, account.getUserId());
			statement.setInt(3,
					MySQLAPIUtil.getIdFromConstantValue(Schemas.ACCOUNT_TYPES, account.getAccountType().toString()));
			statement.setInt(4, account.getBranchId());
			statement.setLong(5, account.getOpeningDate());
			statement.setLong(6, account.getCreatedAt());
			statement.setLong(7, account.getCreatedAt());
			statement.setInt(8, account.getModifiedBy());
			ServerConnection.startTransaction();
			if (statement.executeUpdate() == 1) {
				branch.setModifiedBy(account.getModifiedBy());
				branch.setModifiedAt(account.getModifiedAt());

				MySQLQuery branchUpdateQuery = new MySQLQuery();
				branchUpdateQuery.update(Schemas.BRANCH);
				branchUpdateQuery.setColumn(Column.ACCOUNTS);
				branchUpdateQuery.separator();
				branchUpdateQuery.columnEquals(Column.MODIFIED_BY);
				branchUpdateQuery.separator();
				branchUpdateQuery.columnEquals(Column.MODIFIED_AT);
				branchUpdateQuery.where();
				branchUpdateQuery.columnEquals(Column.BRANCH_ID);
				branchUpdateQuery.end();
				System.out.println(branchUpdateQuery.getQuery());
				try (PreparedStatement branchUpdateStatement = ServerConnection.getServerConnection()
						.prepareStatement(branchUpdateQuery.getQuery())) {
					branchUpdateStatement.setLong(1, branch.getAccountsCount());
					branchUpdateStatement.setInt(2, branch.getModifiedBy());
					branchUpdateStatement.setLong(3, branch.getModifiedAt());
					branchUpdateStatement.setInt(4, branch.getBranchId());
					System.out.println(branchUpdateStatement);

					if (branchUpdateStatement.executeUpdate() == 1) {
						ServerConnection.endTransaction();
						return account.getAccountNumber();
					}
				}
			}
			throw new AppException(APIExceptionMessage.ACCOUNT_CREATION_FAILED);
		} catch (SQLException e) {
			ServerConnection.reverseTransaction();
			throw new AppException(e);
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
			throw new AppException(e);
		}
		return accounts;
	}

	@Override
	public int getNumberOfPagesOfAccountsInBranch(int branchId) throws AppException {
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
					return GetterUtil.getPageCount(countRS.getInt(1));
				} else {
					throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public long depositAmount(Transaction depositTransaction) throws AppException {
		ValidatorUtil.validateObject(depositTransaction);
		try {
			ServerConnection.startTransaction();

			Account transactionAccount = getAccountDetails(depositTransaction.getViewerAccountNumber());
			transactionAccount.setBalance(ConvertorUtil
					.convertToTwoDecimals(depositTransaction.getTransactedAmount() + transactionAccount.getBalance()));
			transactionAccount.setModifiedBy(depositTransaction.getModifiedBy());
			transactionAccount.setModifiedAt(depositTransaction.getCreatedAt());
			MySQLAPIUtil.updateBalanceInAccount(transactionAccount, true);

			depositTransaction.setClosingBalance(transactionAccount.getBalance());
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

			if (!MySQLAPIUtil.updateBalanceInAccount(transactionAccount, false)) {
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
			statement.setInt(1, MySQLAPIUtil.getIdFromConstantValue(Schemas.STATUS, account.getStatus().toString()));
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

	@Override
	public UserRecord changeUserStatus(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		MySQLQuery query = new MySQLQuery();
		query.update(Schemas.USERS);
		query.setColumn(Column.STATUS);
		query.separator();
		query.columnEquals(Column.MODIFIED_BY);
		query.separator();
		query.columnEquals(Column.MODIFIED_AT);
		query.where();
		query.columnEquals(Column.USER_ID);
		query.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection().prepareStatement(query.getQuery())) {
			statement.setInt(1, MySQLAPIUtil.getIdFromConstantValue(Schemas.STATUS, user.getStatus().toString()));
			statement.setInt(2, user.getModifiedBy());
			statement.setLong(3, user.getModifiedAt());
			statement.setInt(4, user.getUserId());

			if (statement.executeUpdate() == 1) {
				return user;
			} else
				throw new AppException();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new AppException(APIExceptionMessage.USER_STATUS_CHANGE_FAILED, "Status : " + user.getStatus());
		}
	}

	@Override
	public Account getClosedAccountDetails(Long accountNumber) throws AppException {
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
					return MySQLConversionUtil.convertToAccount(result);
				} else {
					throw new AppException(APIExceptionMessage.ACCOUNT_RECORD_NOT_FOUND);
				}
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	@Override
	public boolean isAccountClosed(long accountNumber) throws AppException {
		ValidatorUtil.validateId(accountNumber);

		MySQLQuery queryBuilder = new MySQLQuery();
		queryBuilder.selectCount(Schemas.ACCOUNTS);
		queryBuilder.where();
		queryBuilder.columnEquals(Column.ACCOUNT_NUMBER);
		queryBuilder.and();
		queryBuilder.columnEquals(Column.STATUS);
		queryBuilder.end();

		try (PreparedStatement statement = ServerConnection.getServerConnection()
				.prepareStatement(queryBuilder.getQuery())) {
			statement.setLong(1, accountNumber);
			statement.setInt(2, MySQLAPIUtil.getIdFromConstantValue(Schemas.STATUS, Status.CLOSED.toString()));
			try (ResultSet result = statement.executeQuery()) {
				return result.next() && result.getInt(1) == 1;
			}
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}
}