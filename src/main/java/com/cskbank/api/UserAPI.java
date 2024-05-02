package com.cskbank.api;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;

public interface UserAPI {

	// User
	public boolean userAuthentication(int userID, String password) throws AppException;

	public boolean userConfimration(int userID, String pin) throws AppException;

	public UserRecord getUserDetails(int userID) throws AppException;

	public UserRecord getUserRecordDetails(Integer userID) throws AppException;

	public boolean updateProfileDetails(UserRecord user, ModifiableField field, Object value) throws AppException;

	public boolean updatePassword(int customerID, String oldPassword, String newPassword) throws AppException;

	// Branch
	public Branch getBranchDetails(int branchID) throws AppException;

	public Branch getBranchDetails(Integer branchId) throws AppException;

	// Accounts
//	public int getNumberOfPagesOfAccounts(int userId, int pageNumber) throws AppException;

	public Map<Long, Account> getAccountsOfUser(int userID) throws AppException;

	public Account getAccountDetails(long accountNumber) throws AppException;

	public Account getAccountDetails(Long accountNumber) throws AppException;

	public Transaction transferAmount(Transaction transaction, boolean isTransferOutsideBank) throws AppException;

	// Transaction
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber,
			TransactionHistoryLimit timeLimit) throws AppException;

	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException;

	public int numberOfTransactionPages(long accountNumber, TransactionHistoryLimit timeLimit) throws AppException;

	public int numberOfTransactionPages(long accountNumber, long startDate, long endDate) throws AppException;

	// Audit Logs
	public boolean logOperation(AuditLog auditLog) throws AppException;

	// API Key
	public APIKey getAPIKey(int akId) throws AppException;

	public APIKey getAPIKey(String akId) throws AppException;

	public APIKey invalidateApiKey(APIKey apiKey) throws AppException;
}
