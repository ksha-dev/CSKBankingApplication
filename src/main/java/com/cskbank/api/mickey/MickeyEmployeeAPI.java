package com.cskbank.api.mickey;

import java.util.Map;

import javax.transaction.TransactionManager;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.QueryConstants;
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
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;

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
			throw new AppException(e);
		}
	}

	protected void createUserRecord(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);

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

		try {
			DataObject newUserDO = new WritableDataObject();
			newUserDO.addRow(newUserRow);
			user.setUserId(DataAccess.add(newUserDO).getFirstRow(USER.TABLE).getInt(USER.USER_ID));
			createCredentialRecord(user);
		} catch (DataAccessException e) {
			throw new AppException(e);
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
			newCustomerRow.set(CUSTOMER.AADHAAR, customer.getAadhaarNumber());
			newCustomerRow.set(CUSTOMER.PAN, customer.getPanNumber());

			DataObject newCustomerDO = new WritableDataObject();
			newCustomerDO.addRow(newCustomerRow);
			newCustomerDO = DataAccess.add(newCustomerDO);

			transactionManager.commit();
			return customer.getUserId();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (Exception e1) {
				e.initCause(e1);
			}
			throw new AppException(e);
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

		try {
			Branch branch = getBranchDetails(account.getBranchId());
			branch.setAccountsCount(branch.getAccountsCount() + 1);
			account.setAccountNumber(
					Long.parseLong(String.format("%d%010d", branch.getBranchId(), branch.getAccountsCount())));

			Row accountRow = new Row(ACCOUNT.TABLE);
			accountRow.set(ACCOUNT.ACCOUNT_NUMBER, account.getAccountNumber());
			accountRow.set(ACCOUNT.USER_ID, account.getUserId());
			accountRow.set(ACCOUNT.BRANCH_ID, account.getBranchId());
			accountRow.set(ACCOUNT.TYPE, account.getAccountType().getTypeID());
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
			return account.getAccountNumber();
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.ACCOUNT_CREATION_FAILED, e);
		}
	}

	@Override
	public boolean changeAccountStatus(Account account) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int getNumberOfPagesOfAccountsInBranch(int branchId) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<Long, Account> viewAccountsInBranch(int branchID, int pageNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Account getClosedAccountDetails(Long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isAccountClosed(long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public long depositAmount(Transaction depositTransaction) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long withdrawAmount(Transaction withdrawTransaction) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

}
