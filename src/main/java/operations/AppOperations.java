package operations;

import java.util.List;

import api.UserAPI;
import api.mysql.MySQLUserAPI;
import cache.CachePool;
import exceptions.AppException;
import exceptions.messages.ActivityExceptionMessages;
import modules.Transaction;
import modules.UserRecord;
import utility.ValidatorUtil;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.OperationStatus;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionHistoryLimit;

public class AppOperations {

	private UserAPI api = new MySQLUserAPI();

	public AppOperations() throws AppException {
		CachePool.initializeCache(api);
	}

	public UserRecord getUser(int userID, String password) throws AppException {
		if (api.userAuthentication(userID, password)) {
			return CachePool.getUserRecordCache().get(userID);
		}
		return null;
	}

	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, TransactionHistoryLimit limit)
			throws AppException {
		ValidatorUtil.validatePositiveNumber(accountNumber);
		ValidatorUtil.validatePositiveNumber(pageNumber);
		ValidatorUtil.validateObject(limit);

		api.getAccountDetails(accountNumber);
		return api.getTransactionsOfAccount(accountNumber, pageNumber, limit);
	}

	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException {
		ValidatorUtil.validatePositiveNumber(accountNumber);
		ValidatorUtil.validatePositiveNumber(pageNumber);

		if (startDate > endDate) {
			throw new AppException(ActivityExceptionMessages.INVALID_START_DATE);
		}
		if (startDate == endDate) {
			throw new AppException(ActivityExceptionMessages.EQUAL_START_END_DATE);
		}
		if (endDate > System.currentTimeMillis()) {
			throw new AppException(ActivityExceptionMessages.INVALID_END_DATE);
		}

		api.getAccountDetails(accountNumber);
		return api.getTransactionsOfAccount(accountNumber, pageNumber, startDate, endDate);
	}

	public int getPageCountOfTransactions(long accountNumber, TransactionHistoryLimit limit) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateObject(limit);
		return api.numberOfTransactionPages(accountNumber, limit);
	}

	public int getPageCountOfTransactions(long accountNumber, long startDate, long endDate) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		return api.numberOfTransactionPages(accountNumber, startDate, endDate);
	}

	public boolean updatePassword(int customerId, String oldPassword, String newPassword, String pin)
			throws AppException {
		ValidatorUtil.validateId(customerId);
		ValidatorUtil.validatePassword(oldPassword);
		ValidatorUtil.validatePassword(newPassword);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(customerId, pin)) {
			return api.updatePassword(customerId, oldPassword, newPassword);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public synchronized void logOperationByUser(int userId, int targetId, LogOperation operation,
			OperationStatus status, String description, long modifiedAt) throws AppException {
		ValidatorUtil.validateId(userId);
		ValidatorUtil.validatePositiveNumber(targetId);
		ValidatorUtil.validateObject(operation);
		ValidatorUtil.validateObject(description);
		api.logOperation(userId, targetId, operation, status, description, modifiedAt);
	}

	public synchronized void logOperationByAndForUser(int userId, LogOperation operation, OperationStatus status,
			String description, long modifiedAt) throws AppException {
		ValidatorUtil.validateId(userId);
		ValidatorUtil.validateObject(operation);
		ValidatorUtil.validateObject(description);
		api.logOperation(userId, userId, operation, status, description, modifiedAt);
	}

}
