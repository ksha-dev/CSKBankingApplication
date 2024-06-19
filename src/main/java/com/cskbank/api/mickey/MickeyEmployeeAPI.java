package com.cskbank.api.mickey;

import java.util.Map;

import javax.transaction.TransactionManager;

import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.USER;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.api.EmployeeAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Account;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long createAccount(Account account) throws AppException {
		// TODO Auto-generated method stub
		return 0;
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
