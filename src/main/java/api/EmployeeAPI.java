package api;

import java.util.List;
import java.util.Map;

import exceptions.AppException;
import modules.Account;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import utility.ConstantsUtil.AccountType;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionHistoryLimit;

public interface EmployeeAPI extends UserAPI {

	public int createCustomer(CustomerRecord customer) throws AppException;

	public long createAccount(Account account) throws AppException;

	public boolean changeAccountStatus(Account account) throws AppException;

	public int getNumberOfPagesOfAccounts(int branchId) throws AppException;

	public Map<Long, Account> viewAccountsInBranch(int branchID, int pageNumber) throws AppException;

	public long depositAmount(Transaction depositTransaction) throws AppException;

	public long withdrawAmount(Transaction withdrawTransaction) throws AppException;

}
