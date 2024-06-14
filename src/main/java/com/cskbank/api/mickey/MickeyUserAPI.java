package com.cskbank.api.mickey;

import java.util.List;
import java.util.Map;

import com.cskbank.api.UserAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;

public class MickeyUserAPI implements UserAPI {

	@Override
	public boolean userAuthentication(int userID, String password) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean userConfimration(int userID, String pin) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public UserRecord getUserDetails(int userID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserRecord getUserRecordDetails(Integer userID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateProfileDetails(UserRecord user, ModifiableField field, Object value) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updatePassword(int customerID, String oldPassword, String newPassword) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean resetPassword(int customerId, String newPassword) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doesEmailExist(String email) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doesEmailBelongToUser(int userId, String email) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Branch getBranchDetails(int branchID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Branch getBranchDetails(Integer branchId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<Long, Account> getAccountsOfUser(int userID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Account getAccountDetails(long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Account getAccountDetails(Long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Transaction transferAmount(Transaction transaction, boolean isTransferOutsideBank) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber,
			TransactionHistoryLimit timeLimit) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, TransactionHistoryLimit timeLimit) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, long startDate, long endDate) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean logOperation(AuditLog auditLog) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public APIKey getAPIKey(int akId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public APIKey getAPIKey(String akId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public APIKey invalidateApiKey(APIKey apiKey) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

}
