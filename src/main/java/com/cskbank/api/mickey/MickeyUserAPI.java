package com.cskbank.api.mickey;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.transaction.TransactionManager;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.APIKEY;
import com.adventnet.cskbank.AUDITLOG;
import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.TRANSACTION;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.DataSet;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.QueryConstructionException;
import com.adventnet.ds.query.Range;
import com.adventnet.ds.query.SelectQuery;
import com.adventnet.ds.query.SelectQueryImpl;
import com.adventnet.ds.query.SortColumn;
import com.adventnet.ds.query.Table;
import com.adventnet.ds.query.UpdateQuery;
import com.adventnet.ds.query.UpdateQueryImpl;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.api.UserAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;
import com.cskbank.utility.ConstantsUtil.TransactionType;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.LogUtil;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;

public class MickeyUserAPI implements UserAPI {

	@Override
	public boolean userAuthentication(int userID, String password) throws AppException {
		try {
			Row criteriaRow = new Row(CREDENTIAL.TABLE);
			criteriaRow.set(CREDENTIAL.USER_ID, userID);
			DataObject credentialDO = DataAccess.get(CREDENTIAL.TABLE, criteriaRow);
			if (credentialDO.isEmpty()) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}
			Row credentialRow = credentialDO.getFirstRow(CREDENTIAL.TABLE);
			if (credentialRow.getString(CREDENTIAL.PASSWORD).equals(SecurityUtil.encryptPasswordSHA256(password))) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
			}
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED, e);
		}
	}

	@Override
	public boolean userConfimration(int userID, String pin) throws AppException {
		ValidatorUtil.validateId(userID);
		ValidatorUtil.validatePIN(pin);

		Criteria confirmationCriteria = new Criteria(Column.getColumn(CREDENTIAL.TABLE, CREDENTIAL.USER_ID), userID,
				QueryConstants.EQUAL);
		try {
			String encryptedPIN = DataAccess.get(CREDENTIAL.TABLE, confirmationCriteria).getFirstRow(CREDENTIAL.TABLE)
					.getString(CREDENTIAL.PIN);
			if (!encryptedPIN.equals(SecurityUtil.encryptPasswordSHA256(pin))) {
				throw new AppException(APIExceptionMessage.USER_CONFIRMATION_FAILED);
			}
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	private CustomerRecord getCustomerRecord(int customerID) throws AppException {
		try {
			Row customerRow = new Row(CUSTOMER.TABLE);
			customerRow.set(CUSTOMER.USER_ID, customerID);
			DataObject customerDO = DataAccess.get(CUSTOMER.TABLE, customerRow);
			if (customerDO.isEmpty()) {
				throw new AppException(APIExceptionMessage.CUSTOMER_RECORD_NOT_FOUND);
			}
			customerRow = customerDO.getFirstRow(CUSTOMER.TABLE);
			return MickeyConverstionUtil.convertToCustomerRecord(customerRow);
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	private EmployeeRecord getEmployeeRecord(int employeeID) throws AppException {
		try {
			Row employeeRow = new Row(EMPLOYEE.TABLE);
			employeeRow.set(EMPLOYEE.USER_ID, employeeID);
			DataObject employeeDO = DataAccess.get(EMPLOYEE.TABLE, employeeRow);
			if (employeeDO.isEmpty()) {
				throw new AppException(APIExceptionMessage.EMPLOYEE_RECORD_NOT_FOUND);
			}
			employeeRow = employeeDO.getFirstRow(EMPLOYEE.TABLE);
			return MickeyConverstionUtil.convertToEmployeeRecord(employeeRow);
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public UserRecord getUserDetails(int userID) throws AppException {
		ValidatorUtil.validateId(userID);
		try {
			Row userRow = new Row(USER.TABLE);
			userRow.set(USER.USER_ID, userID);
			DataObject userDO = DataAccess.get(USER.TABLE, userRow);
			if (userDO.isEmpty()) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}
			LogUtil.logString(userDO.toString());
			userRow = userDO.getFirstRow(USER.TABLE);

			UserRecord.Type type = Type.getType(userRow.getInt(USER.TYPE));
			UserRecord user = null;
			switch (type) {
			case CUSTOMER:
				user = getCustomerRecord(userID);
				break;

			case EMPLOYEE:
			case ADMIN:
				user = getEmployeeRecord(userID);
				break;

			default:
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}

			MickeyConverstionUtil.updateUserRecord(userRow, user);
			return user;

		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public UserRecord getUserRecordDetails(Integer userID) throws AppException {
		return getUserDetails((int) userID);
	}

	@Override
	public boolean updateProfileDetails(UserRecord user, ModifiableField field, Object value) throws AppException {
		UpdateQuery update = new UpdateQueryImpl(USER.TABLE);
		Criteria whereCondition = new Criteria(new Column(USER.TABLE, USER.USER_ID), user.getUserId(),
				QueryConstants.EQUAL);
		update.setCriteria(whereCondition);
		update.setUpdateColumn(field.toString().toUpperCase(), value);
		try {
			DataAccess.update(update);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.UPDATE_FAILED, e);
		}
	}

	@Override
	public boolean updatePassword(int customerID, String oldPassword, String newPassword) throws AppException {
		ValidatorUtil.validateId(customerID);
		ValidatorUtil.validatePassword(newPassword);
		ValidatorUtil.validatePassword(newPassword);

		Criteria whereCondition = new Criteria(new Column(CREDENTIAL.TABLE, CREDENTIAL.USER_ID), customerID,
				QueryConstants.EQUAL);

		try {
			DataObject currentDO = DataAccess.get(CREDENTIAL.TABLE, whereCondition);
			if (currentDO.getFirstRow(CREDENTIAL.TABLE) == null) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}
			if (!SecurityUtil.encryptPasswordSHA256(oldPassword)
					.equals(currentDO.getFirstRow(CREDENTIAL.TABLE).getString(CREDENTIAL.PASSWORD))) {
				throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
			}
			if (oldPassword.equals(newPassword)) {
				throw new AppException(APIExceptionMessage.SAME_PASSWORD);
			}

			UpdateQuery passwordUpdate = new UpdateQueryImpl(CREDENTIAL.TABLE);
			passwordUpdate.setCriteria(whereCondition);
			passwordUpdate.setUpdateColumn(CREDENTIAL.PASSWORD, SecurityUtil.encryptPasswordSHA256(newPassword));

			DataAccess.update(passwordUpdate);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.UPDATE_FAILED, e);
		}
	}

	@Override
	public boolean resetPassword(int customerId, String newPassword) throws AppException {
		ValidatorUtil.validatePositiveNumber(customerId);
		ValidatorUtil.validatePassword(newPassword);

		UpdateQuery passwordResetUpdate = new UpdateQueryImpl(CREDENTIAL.TABLE);
		Criteria changePasswordOfCondition = new Criteria(new Column(CREDENTIAL.TABLE, CREDENTIAL.USER_ID), customerId,
				QueryConstants.EQUAL);
		passwordResetUpdate.setCriteria(changePasswordOfCondition);
		passwordResetUpdate.setUpdateColumn(CREDENTIAL.PASSWORD, SecurityUtil.encryptPasswordSHA256(newPassword));
		passwordResetUpdate.setUpdateColumn(CREDENTIAL.MODIFIED_BY, customerId);
		passwordResetUpdate.setUpdateColumn(CREDENTIAL.MODIFIED_AT, System.currentTimeMillis());

		try {
			DataAccess.update(passwordResetUpdate);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.UPDATE_FAILED);
		}
	}

	@Override
	public boolean doesEmailExist(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		Row emailRow = new Row(USER.TABLE);
		emailRow.set(USER.EMAIL, email);
		try {
			DataObject dataObject = DataAccess.get(USER.TABLE, emailRow);
			return ValidatorUtil.isObjectNull(dataObject);
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.EMAIL_CHECK_FAILED, e);
		}
	}

	@Override
	public boolean doesEmailBelongToUser(int userId, String email) throws AppException {
		Criteria userEmailCheck = new Criteria(Column.getColumn(USER.TABLE, USER.USER_ID), userId,
				QueryConstants.EQUAL);
		userEmailCheck.and(Column.getColumn(USER.TABLE, USER.EMAIL), email, QueryConstants.EQUAL);

		try {
			DataObject emailDO = DataAccess.get(USER.TABLE, userEmailCheck);
			return !emailDO.isEmpty();
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public Branch getBranchDetails(int branchID) throws AppException {
		ValidatorUtil.validateId(branchID);

		Row branchRow = new Row(BRANCH.TABLE);
		branchRow.set(BRANCH.BRANCH_ID, branchID);
		try {
			DataObject branchDO = DataAccess.get(BRANCH.TABLE, branchRow);
			if (branchDO.isEmpty()) {
				throw new AppException(APIExceptionMessage.BRANCH_DETAILS_NOT_FOUND);
			}
			return MickeyConverstionUtil.convertToBranch(branchDO.getFirstRow(BRANCH.TABLE));
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public Branch getBranchDetails(Integer branchId) throws AppException {
		return getBranchDetails((int) branchId);
	}

	@Override
	public Map<Long, Account> getAccountsOfUser(int userID) throws AppException {
		Criteria whereCondition = new Criteria(new Column(ACCOUNT.TABLE, ACCOUNT.USER_ID), userID,
				QueryConstants.EQUAL);
		whereCondition.and(new Column(ACCOUNT.TABLE, ACCOUNT.STATUS), Status.CLOSED, QueryConstants.NOT_EQUAL);

		try {
			DataObject accountDO = DataAccess.get(ACCOUNT.TABLE, whereCondition);
			Iterator<?> it = accountDO.getRows(ACCOUNT.TABLE);
			Map<Long, Account> userAccounts = new LinkedHashMap<Long, Account>();
			while (it.hasNext()) {
				Account account = MickeyConverstionUtil.convertToAccount((Row) it.next());
				userAccounts.put(account.getAccountNumber(), account);
			}
			return userAccounts;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public Account getAccountDetails(long accountNumber) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		Criteria whereCondition = new Criteria(new Column(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER), accountNumber,
				QueryConstants.EQUAL);
		whereCondition.and(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.STATUS), Status.CLOSED, QueryConstants.NOT_EQUAL);

		try {
			Row accountRow = DataAccess.get(ACCOUNT.TABLE, whereCondition).getFirstRow(ACCOUNT.TABLE);
			if (ValidatorUtil.isObjectNull(accountRow)) {
				throw new AppException(APIExceptionMessage.ACCOUNT_RECORD_NOT_FOUND);
			}
			return MickeyConverstionUtil.convertToAccount(accountRow);
		} catch (Exception e) {
			throw new AppException(e);
		}
	}

	@Override
	public Account getAccountDetails(Long accountNumber) throws AppException {
		return getAccountDetails((long) accountNumber);
	}

	@Override
	public Transaction transferAmount(Transaction transaction, boolean transferWithinBank) throws AppException {
		TransactionManager txnMg = DataAccess.getTransactionManager();

		try {
			txnMg.begin();
			Account payeeAccount = getAccountDetails(transaction.getViewerAccountNumber());
			payeeAccount.setModifiedBy(transaction.getModifiedBy());
			payeeAccount.setModifiedAt(transaction.getCreatedAt());
			payeeAccount.setBalance(transaction.getClosingBalance());
			payeeAccount.setLastTransactedAt(transaction.getCreatedAt());
			if (!MickeyAPIUtil.updateBalanceInAccount(payeeAccount, true)) {
				throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
			}

			String remarks = transaction.getRemarks();
			transaction.setRemarks("DB-TRANSFER-ACC-" + transaction.getTransactedAccountNumber() + "-" + remarks);
			MickeyAPIUtil.createSenderTransactionRecord(transaction);

			if (transferWithinBank) {
				Account recepientAccount = getAccountDetails(transaction.getTransactedAccountNumber());
				recepientAccount.setModifiedBy(payeeAccount.getModifiedBy());
				recepientAccount.setModifiedAt(payeeAccount.getModifiedAt());
				recepientAccount.setBalance(ConvertorUtil
						.convertToTwoDecimals(recepientAccount.getBalance() + transaction.getTransactedAmount()));

				if (!MickeyAPIUtil.updateBalanceInAccount(recepientAccount, false)) {
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

				MickeyAPIUtil.createReceiverTransactionRecord(reverseTransactionRecord);
			}
			txnMg.commit();
			return transaction;
		} catch (Exception e) {
			try {
				txnMg.rollback();
			} catch (Exception e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.TRANSACTION_FAILED, e);
		}
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber,
			TransactionHistoryLimit timeLimit) throws AppException {

		Criteria transactionsCriteria = new Criteria(new Column(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT),
				accountNumber, QueryConstants.EQUAL);
		if (timeLimit != TransactionHistoryLimit.RECENT) {
			transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP),
					timeLimit.getDuration(), QueryConstants.GREATER_EQUAL);
			transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP),
					System.currentTimeMillis(), QueryConstants.LESS_EQUAL);
		}

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(TRANSACTION.TABLE));
			query.addSortColumn(new SortColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP),
					timeLimit != TransactionHistoryLimit.RECENT));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));
			query.setCriteria(transactionsCriteria);

			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.USER_ID));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.RECEIVER_ACCOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.AMOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.CLOSING_BALANCE));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TYPE));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.REMARKS));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.CREATED_AT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.MODIFIED_BY));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.MODIFIED_AT));

			Iterator<?> it = DataAccess.get(query).getRows(TRANSACTION.TABLE);
			List<Transaction> transactions = new LinkedList<Transaction>();
			while (it.hasNext()) {
				Transaction transaction = MickeyConverstionUtil.convertToTransaction((Row) it.next());
				transactions.add(transaction);
			}
			return transactions;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException {

		Criteria transactionsCriteria = new Criteria(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT),
				accountNumber, QueryConstants.EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP), startDate,
				QueryConstants.GREATER_EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP), endDate,
				QueryConstants.LESS_EQUAL);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(TRANSACTION.TABLE));
			query.addSelectColumn(new Column(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID).count());
			query.addSortColumn(new SortColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID), true));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));
			query.setCriteria(transactionsCriteria);

			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.USER_ID));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.RECEIVER_ACCOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.AMOUNT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.CLOSING_BALANCE));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TYPE));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.REMARKS));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.CREATED_AT));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.MODIFIED_BY));
			query.addSelectColumn(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.MODIFIED_AT));

			Iterator<?> it = DataAccess.get(query).getRows(TRANSACTION.TABLE);
			List<Transaction> transactions = new LinkedList<Transaction>();
			while (it.hasNext()) {
				Transaction transaction = MickeyConverstionUtil.convertToTransaction((Row) it.next());
				transactions.add(transaction);
			}
			return transactions;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}

	}

	@Override
	public int numberOfTransactionPages(long accountNumber, TransactionHistoryLimit timeLimit) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateObject(timeLimit);

		if (timeLimit == TransactionHistoryLimit.RECENT) {
			return 1;
		}

		Criteria transactionsCriteria = new Criteria(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT),
				accountNumber, QueryConstants.EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP), timeLimit.getDuration(),
				QueryConstants.GREATER_EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP),
				System.currentTimeMillis(), QueryConstants.LESS_EQUAL);
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(TRANSACTION.TABLE));
			query.addSelectColumn(new Column(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID).count());
			query.setCriteria(transactionsCriteria);

			DataSet dataSet = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataSet.next()) {
				return GetterUtil.getPageCount((int) dataSet.getValue(1));
			} else
				throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);

		} catch (SQLException | QueryConstructionException e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, long startDate, long endDate) throws AppException {
		Criteria transactionsCriteria = new Criteria(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.SENDER_ACCOUNT),
				accountNumber, QueryConstants.EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP), startDate,
				QueryConstants.GREATER_EQUAL);
		transactionsCriteria.and(Column.getColumn(TRANSACTION.TABLE, TRANSACTION.TIME_STAMP), endDate,
				QueryConstants.LESS_EQUAL);
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(TRANSACTION.TABLE));
			query.addSelectColumn(new Column(TRANSACTION.TABLE, TRANSACTION.TRANSACTION_ID).count());
			query.setCriteria(transactionsCriteria);

			DataSet dataSet = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataSet.next()) {
				return GetterUtil.getPageCount((int) dataSet.getValue(1));
			} else
				throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);

		} catch (SQLException | QueryConstructionException e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public boolean logOperation(AuditLog auditLog) throws AppException {
		ValidatorUtil.validateId(auditLog.getUserId());
		ValidatorUtil.validateId(auditLog.getTargetId());
		ValidatorUtil.validateObject(auditLog.getLogOperation());
		ValidatorUtil.validateObject(auditLog.getOperationStatus());
		ValidatorUtil.validateObject(auditLog.getDescription());

		Row auditLogRow = new Row(AUDITLOG.TABLE);
		auditLogRow.set(AUDITLOG.USER_ID, auditLog.getUserId());
		auditLogRow.set(AUDITLOG.TARGET_ID, auditLog.getTargetId());
		auditLogRow.set(AUDITLOG.OPERATION, auditLog.getLogOperation());
		auditLogRow.set(AUDITLOG.STATUS, auditLog.getOperationStatus());
		auditLogRow.set(AUDITLOG.DESCRIPTION, auditLog.getDescription());
		auditLogRow.set(AUDITLOG.MODIFIED_AT, auditLog.getModifiedAt());

		DataObject auditLogDO = new WritableDataObject();
		try {
			auditLogDO.addRow(auditLogRow);
			DataAccess.add(auditLogDO);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.LOGGING_FAILED, e);
		}
	}

	@Override
	public APIKey getAPIKey(int akId) throws AppException {
		ValidatorUtil.validateId(akId);

		Row apiKeyRow = new Row(APIKEY.TABLE);
		apiKeyRow.set(APIKEY.AK_ID, akId);

		try {
			return MickeyConverstionUtil
					.convertToAPIKey(DataAccess.get(APIKEY.TABLE, apiKeyRow).getFirstRow(APIKEY.TABLE));
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND, e);
		}
	}

	@Override
	public APIKey getAPIKey(String apiKeyValue) throws AppException {
		ValidatorUtil.validateAPIKey(apiKeyValue);
		Row apiKeyRow = new Row(APIKEY.TABLE);
		apiKeyRow.set(APIKEY.API_KEY, apiKeyValue);

		try {
			return MickeyConverstionUtil
					.convertToAPIKey(DataAccess.get(APIKEY.TABLE, apiKeyRow).getFirstRow(APIKEY.TABLE));
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.API_KEY_NOT_FOUND, e);
		}
	}

	@Override
	public APIKey invalidateApiKey(APIKey apiKey) throws AppException {
		ValidatorUtil.validateObject(apiKey);

		try {
			UpdateQuery update = new UpdateQueryImpl(APIKEY.TABLE);
			update.setCriteria(
					new Criteria(Column.getColumn(APIKEY.TABLE, APIKEY.AK_ID), apiKey.getAkId(), QueryConstants.EQUAL));
			update.setUpdateColumn(APIKEY.IS_ACTIVE, apiKey.getIsActive());
			update.setUpdateColumn(APIKEY.MODIFIED_AT, apiKey.getModifiedAt());

			DataAccess.update(update);
			return apiKey;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

}
