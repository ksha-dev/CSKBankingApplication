package com.cskbank.api.mickey;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.DataSet;
import com.adventnet.ds.query.QueryConstants;
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
import com.cskbank.api.EmployeeAPI;
import com.cskbank.cache.CachePool;
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
import com.zoho.ear.common.util.EARException;
import com.zoho.ear.encryptagent.EncryptAgent;

public class MickeyEmployeeAPI extends MickeyUserAPI implements EmployeeAPI {

	private void createCredentialRecord(UserRecord user) throws AppException {
		ValidatorUtil.validatePositiveNumber(user.getUserId());

		Row newCredentialRow = new Row(CREDENTIAL.TABLE);
		newCredentialRow.set(CREDENTIAL.USER_ID, user.getUserId());
		newCredentialRow.set(CREDENTIAL.PASSWORD, SecurityUtil.passwordGenerator(user));
		newCredentialRow.set(CREDENTIAL.PIN, SecurityUtil.generatePIN(user));
		newCredentialRow.set(CREDENTIAL.CREATED_AT, user.getCreatedAt());
		newCredentialRow.set(CREDENTIAL.MODIFIED_BY, user.getModifiedBy());

		try {
			DataObject newCredentialDO = new WritableDataObject();
			newCredentialDO.addRow(newCredentialRow);
			DataAccess.add(newCredentialDO);
		} catch (DataAccessException e) {
			throw new AppException("User Generated as : USER_ID " + user.getUserId(), e);
		}
	}

	@Override
	public void createUserRecord(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		try {
			Row newUserRow = new Row(USER.TABLE);
			newUserRow.set(USER.FIRST_NAME, user.getFirstName());
			newUserRow.set(USER.LAST_NAME, user.getLastName());
			newUserRow.set(USER.GENDER, user.getGender().getGenderID());
			newUserRow.set(USER.DOB, user.getDateOfBirth());
			newUserRow.set(USER.ADDRESS, user.getAddress());
			newUserRow.set(USER.PHONE, user.getPhone());
			newUserRow.set(USER.EMAIL, user.getEmail());
			newUserRow.set(USER.TYPE, user.getType().getTypeID());
			newUserRow.set(USER.STATUS, user.getStatus().getStatusID());
			newUserRow.set(USER.CREATED_AT, user.getCreatedAt());
			newUserRow.set(USER.MODIFIED_BY, user.getModifiedBy());

			DataObject newUserDO = new WritableDataObject();
			newUserDO.addRow(newUserRow);
			user.setUserId(DataAccess.add(newUserDO).getFirstRow(USER.TABLE).getInt(USER.USER_ID));
			createCredentialRecord(user);
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.USER_CREATION_FAILED, e);
		}
	}

	@Override
	public int createCustomer(CustomerRecord customer) throws AppException {
		ValidatorUtil.validateObject(customer);

		TransactionManager transactionManager = DataAccess.getTransactionManager();

		try {
			transactionManager.begin();
			createUserRecord(customer);

			Row newCustomerRow = new Row(CUSTOMER.TABLE);
			newCustomerRow.set(CUSTOMER.USER_ID, customer.getUserId());
			newCustomerRow.set(CUSTOMER.AADHAAR, customer.getAadhaarNumber() + "");
			newCustomerRow.set(CUSTOMER.PAN, customer.getPanNumber());

			DataObject newCustomerDO = new WritableDataObject();
			newCustomerDO.addRow(newCustomerRow);
			DataAccess.add(newCustomerDO);

			transactionManager.commit();
			return customer.getUserId();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (Exception e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.CUSTOMER_CREATION_FAILED, e);
		}
	}

	@Override
	public UserRecord changeUserStatus(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

		UpdateQuery statusUpdateQuery = new UpdateQueryImpl(USER.TABLE);
		statusUpdateQuery.setCriteria(
				new Criteria(Column.getColumn(USER.TABLE, USER.USER_ID), user.getUserId(), QueryConstants.EQUAL));
		statusUpdateQuery.setUpdateColumn(USER.STATUS, user.getStatus().getStatusID());
		statusUpdateQuery.setUpdateColumn(USER.MODIFIED_BY, user.getModifiedBy());
		statusUpdateQuery.setUpdateColumn(USER.MODIFIED_AT, user.getModifiedAt());
		try {
			DataAccess.update(statusUpdateQuery);
			return user;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.STATUS_UPDATE_FAILED, e);
		}
	}

	@Override
	public long createAccount(Account account) throws AppException {
		ValidatorUtil.validateObject(account);

		TransactionManager transactionManager = DataAccess.getTransactionManager();
		try {
			transactionManager.begin();
			Branch branch = getBranchDetails(account.getBranchId());
			branch.setAccountsCount(branch.getAccountsCount() + 1);
			account.setAccountNumber(
					Long.parseLong(String.format("%d%010d", branch.getBranchId(), branch.getAccountsCount())));

			Row accountRow = new Row(ACCOUNT.TABLE);
			accountRow.set(ACCOUNT.ACCOUNT_NUMBER, account.getAccountNumber());
			accountRow.set(ACCOUNT.USER_ID, account.getUserId());
			accountRow.set(ACCOUNT.BRANCH_ID, account.getBranchId());
			accountRow.set(ACCOUNT.TYPE, account.getAccountType().getTypeID());
			accountRow.set(ACCOUNT.STATUS, Status.ACTIVE.getStatusID());
			accountRow.set(ACCOUNT.CREATED_AT, account.getCreatedAt());
			accountRow.set(ACCOUNT.MODIFIED_BY, account.getModifiedBy());

			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(accountRow);
			DataAccess.add(dataObject);

			UpdateQuery accountsCountUpdate = new UpdateQueryImpl(BRANCH.TABLE);
			accountsCountUpdate.setCriteria(new Criteria(Column.getColumn(BRANCH.TABLE, BRANCH.BRANCH_ID),
					branch.getBranchId(), QueryConstants.EQUAL));
			accountsCountUpdate.setUpdateColumn(BRANCH.ACCOUNTS_COUNT, branch.getAccountsCount());
			accountsCountUpdate.setUpdateColumn(BRANCH.MODIFIED_BY, account.getModifiedBy());
			accountsCountUpdate.setUpdateColumn(BRANCH.MODIFIED_AT, account.getModifiedAt());
			DataAccess.update(accountsCountUpdate);

			CachePool.getBranchCache().remove(branch.getBranchId());
			transactionManager.commit();
			return account.getAccountNumber();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.ACCOUNT_CREATION_FAILED, e);
		}
	}

	@Override
	public boolean changeAccountStatus(Account account) throws AppException {
		ValidatorUtil.validateObject(account);

		UpdateQuery accountStatusUpdate = new UpdateQueryImpl(ACCOUNT.TABLE);
		accountStatusUpdate.setCriteria(new Criteria(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER),
				account.getAccountNumber(), QueryConstants.EQUAL));
		accountStatusUpdate.setUpdateColumn(ACCOUNT.STATUS, account.getStatus().getStatusID());
		accountStatusUpdate.setUpdateColumn(ACCOUNT.MODIFIED_BY, account.getModifiedBy());
		accountStatusUpdate.setUpdateColumn(ACCOUNT.MODIFIED_AT, account.getModifiedAt());

		try {
			DataAccess.update(accountStatusUpdate);
			return true;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.STATUS_UPDATE_FAILED, e);
		}
	}

	@Override
	public int getNumberOfPagesOfAccountsInBranch(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(ACCOUNT.TABLE));
			query.addSelectColumn(new Column(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER).count());
			query.setCriteria(
					new Criteria(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BRANCH_ID), branchId, QueryConstants.EQUAL));

			DataSet dataset = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataset.next()) {
				return GetterUtil.getPageCount((int) dataset.getValue(1));
			} else {
				throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
			}
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public Map<Long, Account> viewAccountsInBranch(int branchID, int pageNumber) throws AppException {
		ValidatorUtil.validateId(branchID);
		ValidatorUtil.validateId(pageNumber);

		Criteria branchAccountsCriteria = new Criteria(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BRANCH_ID), branchID,
				QueryConstants.EQUAL);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(ACCOUNT.TABLE));
			query.setCriteria(branchAccountsCriteria);
			query.addSortColumn(new SortColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER), false));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));

			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.USER_ID));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BRANCH_ID));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.TYPE));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.STATUS));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.LAST_TRANSACTED_AT));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BALANCE));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.CREATED_AT));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.MODIFIED_BY));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.MODIFIED_AT));

			Iterator<?> it = DataAccess.get(query).getRows(ACCOUNT.TABLE);
			Map<Long, Account> accounts = new LinkedHashMap<Long, Account>();
			while (it.hasNext()) {
				Account account = MickeyConverstionUtil.convertToAccount((Row) it.next());
				accounts.put(account.getAccountNumber(), account);
			}
			return accounts;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public Account getClosedAccountDetails(Long accountNumber) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		Criteria whereCondition = new Criteria(new Column(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER), accountNumber,
				QueryConstants.EQUAL);

		try {
			Row accountRow = DataAccess.get(ACCOUNT.TABLE, whereCondition).getFirstRow(ACCOUNT.TABLE);
			if (ValidatorUtil.isObjectNull(accountRow)) {
				throw new AppException(APIExceptionMessage.ACCOUNT_RECORD_NOT_FOUND);
			}
			return MickeyConverstionUtil.convertToAccount(accountRow);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public boolean isAccountClosed(long accountNumber) throws AppException {
		Criteria closeAccountCriteria = new Criteria(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER),
				accountNumber, QueryConstants.EQUAL);
		closeAccountCriteria.and(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.STATUS), Status.CLOSED.getStatusID(),
				QueryConstants.EQUAL);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(ACCOUNT.TABLE));
			query.setCriteria(closeAccountCriteria);
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER).count());

			DataSet dataset = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataset.next()) {
				return (int) dataset.getValue(1) == 1;
			} else
				throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public long depositAmount(Transaction depositTransaction) throws AppException {
		ValidatorUtil.validateObject(depositTransaction);

		TransactionManager transactionManager = DataAccess.getTransactionManager();

		try {
			transactionManager.begin();
			Account transactionAccount = getAccountDetails(depositTransaction.getViewerAccountNumber());
			transactionAccount.setBalance(ConvertorUtil
					.convertToTwoDecimals(depositTransaction.getTransactedAmount() + transactionAccount.getBalance()));
			transactionAccount.setModifiedBy(depositTransaction.getModifiedBy());
			transactionAccount.setModifiedAt(depositTransaction.getCreatedAt());
			transactionAccount.setLastTransactedAt(depositTransaction.getCreatedAt());

			MickeyAPIUtil.updateBalanceInAccount(transactionAccount, true);

			depositTransaction.setClosingBalance(transactionAccount.getBalance());
			MickeyAPIUtil.createSenderTransactionRecord(depositTransaction);
			transactionManager.commit();

			return depositTransaction.getTransactionId();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.TRANSACTION_FAILED, e);
		}
	}

	@Override
	public long withdrawAmount(Transaction withdrawTransaction) throws AppException {
		ValidatorUtil.validateObject(withdrawTransaction);

		TransactionManager transactionManager = DataAccess.getTransactionManager();

		try {
			transactionManager.begin();
			Account transactionAccount = getAccountDetails(withdrawTransaction.getViewerAccountNumber());
			transactionAccount.setModifiedBy(withdrawTransaction.getModifiedBy());
			transactionAccount.setModifiedAt(withdrawTransaction.getCreatedAt());
			transactionAccount.setLastTransactedAt(withdrawTransaction.getCreatedAt());
			transactionAccount.setBalance(withdrawTransaction.getClosingBalance());

			if (!MickeyAPIUtil.updateBalanceInAccount(transactionAccount, false)) {
				throw new AppException(APIExceptionMessage.TRANSACTION_FAILED);
			}

			MickeyAPIUtil.createSenderTransactionRecord(withdrawTransaction);
			transactionManager.commit();
			return withdrawTransaction.getTransactionId();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.TRANSACTION_FAILED, e);
		}
	}

}
