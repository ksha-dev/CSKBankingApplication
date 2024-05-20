package com.cskbank.handlers;

import java.util.Map;

import com.cskbank.api.UserAPI;
import com.cskbank.api.mysql.MySQLUserAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConstantsUtil.TransactionType;

public class CustomerHandler {

	private UserAPI api;

	public CustomerHandler(PersistanceIdentifier obj) throws AppException {
		try {
			@SuppressWarnings("unchecked")
			Class<UserAPI> persistanceClass = (Class<UserAPI>) Class
					.forName("com.cskbank.api." + obj.toString().toLowerCase() + "." + obj.toString() + "UserAPI");
			api = persistanceClass.getConstructor().newInstance();
		} catch (Exception e) {
			throw new AppException(ActivityExceptionMessages.CANNOT_LOAD_CONNECTOR);
		}
	}

	public CustomerRecord getCustomerRecord(int customerId) throws AppException {
		UserRecord user = CachePool.getUserRecordCache().get(customerId);
		if (user.getType() != UserRecord.Type.CUSTOMER) {
			throw new AppException(ActivityExceptionMessages.NO_CUSTOMER_RECORD_FOUND);
		}
		return (CustomerRecord) user;
	}

	public Account getAccountDetails(long accountNumber, int userId) throws AppException {
		Account account = CachePool.getAccountCache().get(accountNumber);
		if (account.getUserId() != userId) {
			throw new AppException("Access denied!");
		}
		return account;
	}

	public Branch getBranchDetailsOfAccount(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);
		return CachePool.getBranchCache().get(branchId);
	}

	public Map<Long, Account> getAssociatedAccounts(int customerId) throws AppException {
		return api.getAccountsOfUser(customerId);
	}

	public Transaction tranferMoney(Transaction transaction, boolean transferWithinBank, String pin)
			throws AppException {
		ValidatorUtil.validateObject(pin);
		ValidatorUtil.validateObject(transaction);
		ValidatorUtil.validateAmount(transaction.getTransactedAmount());

		if (transaction.getViewerAccountNumber() == transaction.getTransactedAccountNumber()) {
			throw new AppException(ActivityExceptionMessages.CANNOT_TRANSFER_TO_SAME_ACCOUNT);
		}

		Account payeeAccount = getAccountDetails(transaction.getViewerAccountNumber(), transaction.getUserId());
		if (payeeAccount.getStatus() == Status.FROZEN) {
			throw new AppException(APIExceptionMessage.ACCOUNT_RESTRICTED);
		}
		if (payeeAccount.getBalance() < transaction.getTransactedAmount()) {
			throw new AppException(APIExceptionMessage.INSUFFICIENT_BALANCE);
		}

		transaction.setClosingBalance(
				ConvertorUtil.convertToTwoDecimals(payeeAccount.getBalance() - transaction.getTransactedAmount()));
		transaction.setTransactionType(TransactionType.DEBIT.getTransactionTypeId());
		transaction.setTimeStamp(System.currentTimeMillis());
		transaction.setCreatedAt(System.currentTimeMillis());
		transaction.setModifiedBy(transaction.getUserId());

		if (api.userConfimration(transaction.getUserId(), pin)) {
			Transaction processTransaction = api.transferAmount(transaction, transferWithinBank);
			CachePool.getAccountCache().refreshData(processTransaction.getViewerAccountNumber());
			if (transferWithinBank) {
				CachePool.getAccountCache().refreshData(processTransaction.getTransactedAccountNumber());
			}
			return processTransaction;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public UserRecord updateUserDetails(int userId, ModifiableField field, Object value, String pin)
			throws AppException {
		ValidatorUtil.validateId(userId);
		UserRecord user = getCustomerRecord(userId);
		ValidatorUtil.validateObject(field);
		if (!ConstantsUtil.USER_MODIFIABLE_FIELDS.contains(field)) {
			throw new AppException(ActivityExceptionMessages.MODIFICATION_ACCESS_DENIED);
		}
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(userId, pin)) {
			user.setModifiedAt(System.currentTimeMillis());
			user.setModifiedBy(userId);
			api.updateProfileDetails(user, field, value);
			return CachePool.getUserRecordCache().refreshData(userId);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}
}
