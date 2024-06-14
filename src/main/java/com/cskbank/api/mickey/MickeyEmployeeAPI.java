package com.cskbank.api.mickey;

import java.util.Map;

import com.cskbank.api.EmployeeAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Account;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;

public class MickeyEmployeeAPI extends MickeyUserAPI implements EmployeeAPI {

	@Override
	public int createCustomer(CustomerRecord customer) throws AppException {
		// TODO Auto-generated method stub
		return 0;
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
