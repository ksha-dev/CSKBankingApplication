package operations;

import java.util.Map;

import api.UserAPI;
import api.mysql.MySQLUserAPI;
import cache.CachePool;
import exceptions.AppException;
import exceptions.messages.APIExceptionMessage;
import exceptions.messages.ActivityExceptionMessages;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.Transaction;
import modules.UserRecord;
import utility.ConstantsUtil;
import utility.ConvertorUtil;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionType;
import utility.ConstantsUtil.UserType;
import utility.ValidatorUtil;

public class CustomerOperations {

	private UserAPI api = new MySQLUserAPI();

	public CustomerRecord getCustomerRecord(int customerId) throws AppException {
		UserRecord user = CachePool.getUserRecordCache().get(customerId);
		if (user.getType() != UserType.CUSTOMER) {
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
