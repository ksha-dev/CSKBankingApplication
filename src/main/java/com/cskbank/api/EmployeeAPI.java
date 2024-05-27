package com.cskbank.api;

import java.util.Map;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Account;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;

public interface EmployeeAPI extends UserAPI {

	// Customer
	public int createCustomer(CustomerRecord customer) throws AppException;

	public UserRecord changeUserStatus(UserRecord user) throws AppException;

	// Account
	public long createAccount(Account account) throws AppException;

	public boolean changeAccountStatus(Account account) throws AppException;

	public int getNumberOfPagesOfAccountsInBranch(int branchId) throws AppException;

	public Map<Long, Account> viewAccountsInBranch(int branchID, int pageNumber) throws AppException;

	// Transaction
	public long depositAmount(Transaction depositTransaction) throws AppException;

	public long withdrawAmount(Transaction withdrawTransaction) throws AppException;
}
