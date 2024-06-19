package com.cskbank.api.mickey;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.USER;
import com.adventnet.persistence.Row;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.Account;
import com.cskbank.modules.Account.AccountType;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ValidatorUtil;

class MickeyConverstionUtil {

	static EmployeeRecord convertToEmployeeRecord(Row employeeRow) throws AppException {
		if (employeeRow == null) {
			throw new AppException(APIExceptionMessage.EMPLOYEE_RECORD_NOT_FOUND);
		}
		EmployeeRecord employee = new EmployeeRecord();
		employee.setUserId(employeeRow.getInt(EMPLOYEE.USER_ID));
		employee.setBranchId(employeeRow.getInt(EMPLOYEE.BRANCH_ID));
		return employee;
	}

	static CustomerRecord convertToCustomerRecord(Row customerRow) throws AppException {
		if (customerRow == null) {
			throw new AppException(APIExceptionMessage.CUSTOMER_RECORD_NOT_FOUND);
		}
		CustomerRecord customer = new CustomerRecord();
		customer.setUserId(customerRow.getInt(CUSTOMER.USER_ID));
		customer.setAadhaarNumber(customerRow.getLong(CUSTOMER.AADHAAR));
		customer.setPanNumber(customerRow.getString(CUSTOMER.PAN));
		return customer;
	}

	static void updateUserRecord(Row userRow, UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		ValidatorUtil.validateObject(userRow);

		user.setFirstName(userRow.getString(USER.FIRST_NAME));
		user.setLastName(userRow.getString(USER.LAST_NAME));
		user.setDateOfBirth(userRow.getLong(USER.DOB));
		user.setGender(Gender.getGender(userRow.getInt(USER.GENDER)));
		user.setAddress(userRow.getString(USER.ADDRESS));
		user.setPhone(userRow.getLong(USER.PHONE));
		user.setEmail(userRow.getString(USER.EMAIL));
		user.setType(Type.getType(userRow.getInt(USER.TYPE)));
		user.setStatus(Status.getStatus(userRow.getInt(USER.STATUS)));
		user.setCreatedAt(userRow.getLong(USER.CREATED_AT));
		user.setModifiedBy(userRow.getInt(USER.MODIFIED_BY));
		user.setModifiedAt(userRow.getLong(USER.MODIFIED_AT));
	}

	static Account convertToAccount(Row accountRow) throws AppException {
		if (accountRow == null) {
			throw new AppException(APIExceptionMessage.ACCOUNT_RECORD_NOT_FOUND);
		}
		Account account = new Account();
		account.setAccountNumber(accountRow.getLong(ACCOUNT.ACCOUNT_NUMBER));
		account.setUserId(accountRow.getInt(ACCOUNT.USER_ID));
		account.setBranchId(accountRow.getInt(ACCOUNT.BRANCH_ID));
		account.setType(AccountType.getType(accountRow.getInt(ACCOUNT.TYPE)));
		account.setOpeningDate(accountRow.getLong(ACCOUNT.CREATED_AT));
		account.setLastTransactedAt(accountRow.getLong(ACCOUNT.LAST_TRANSACTED_AT));
		account.setBalance(accountRow.getDouble(ACCOUNT.BALANCE));
		account.setStatus(Status.getStatus(accountRow.getInt(ACCOUNT.STATUS)));
		account.setCreatedAt(accountRow.getLong(ACCOUNT.CREATED_AT));
		account.setModifiedBy(accountRow.getInt(ACCOUNT.MODIFIED_BY));
		account.setModifiedAt(accountRow.getLong(ACCOUNT.MODIFIED_AT));
		return account;
	}
//
//	static Transaction convertToTransaction(DataObject tdo) throws AppException {
//	}

//	static APIKey convertToAPIKey(DataObject apido) throws AppException {
//	}

	static Branch convertToBranch(Row branchRow) throws AppException {
		if (branchRow == null) {
			throw new AppException(APIExceptionMessage.BRANCH_DETAILS_NOT_FOUND);
		}
		Branch branch = new Branch();
		branch.setBrachId(branchRow.getInt(BRANCH.BRANCH_ID));
		branch.setAddress(branchRow.getString(BRANCH.ADDRESS));
		branch.setEmail(branchRow.getString(BRANCH.EMAIL));
		branch.setPhone(branchRow.getLong(BRANCH.PHONE));
		branch.setAccountsCount(branchRow.getLong(BRANCH.ACCOUNTS_COUNT));
		branch.setCreatedAt(branchRow.getLong(BRANCH.CREATED_AT));
		branch.setModifiedBy(branchRow.getInt(BRANCH.MODIFIED_BY));
		branch.setModifiedAt(branchRow.getLong(BRANCH.MODIFIED_AT));
		return branch;
	}

}
