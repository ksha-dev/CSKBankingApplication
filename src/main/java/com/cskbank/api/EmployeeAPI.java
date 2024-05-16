package com.cskbank.api;

import java.util.Map;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Account;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;

public interface EmployeeAPI extends UserAPI {

	public int createCustomer(CustomerRecord customer) throws AppException;

	public long createAccount(Account account) throws AppException;

	public boolean changeAccountStatus(Account account) throws AppException;

	public int getNumberOfPagesOfAccounts(int branchId) throws AppException;

	public Map<Long, Account> viewAccountsInBranch(int branchID, int pageNumber) throws AppException;

	public long depositAmount(Transaction depositTransaction) throws AppException;

	public long withdrawAmount(Transaction withdrawTransaction) throws AppException;

}
