package handlers;

import java.util.List;

import org.json.JSONObject;

import api.UserAPI;
import cache.CachePool;
import exceptions.AppException;
import exceptions.messages.APIExceptionMessage;
import exceptions.messages.ActivityExceptionMessages;
import modules.APIKey;
import modules.Transaction;
import modules.UserRecord;
import utility.ConstantsUtil;
import utility.ConvertorUtil;
import utility.ValidatorUtil;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.OperationStatus;
import utility.ConstantsUtil.PersistanceIdentifier;
import utility.ConstantsUtil.TransactionHistoryLimit;

public class CommonHandler {

	private UserAPI api;

	public CommonHandler(PersistanceIdentifier identifier) throws AppException {
		try {
			@SuppressWarnings("unchecked")
			Class<UserAPI> persistanceClass = (Class<UserAPI>) Class
					.forName("api." + identifier.toString().toLowerCase() + "." + identifier.toString() + "UserAPI");
			api = persistanceClass.getConstructor().newInstance();
		} catch (Exception e) {
			throw new AppException(ActivityExceptionMessages.CANNOT_LOAD_CONNECTOR);
		}
	}

	public UserAPI getUserAPI() {
		return api;
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

	public APIKey getAPIKey(String apiKeyValue) throws AppException {
		ValidatorUtil.validateAPIKey(apiKeyValue);
		return api.getAPIKey(apiKeyValue);
	}

	public void validateAPIKey(String apiKeyValue) throws AppException {
		ValidatorUtil.validateAPIKey(apiKeyValue);
		APIKey apiKey = api.getAPIKey(apiKeyValue);

		if (System.currentTimeMillis() > apiKey.getValidUntil()) {
			apiKey.setModifiedAt(System.currentTimeMillis());
			apiKey.setIsActive(false);
			api.invalidateApiKey(apiKey);
			throw new AppException(ActivityExceptionMessages.API_KEY_EXPIRED);
		}
	}
}
