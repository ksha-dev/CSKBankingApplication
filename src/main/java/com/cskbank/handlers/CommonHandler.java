package com.cskbank.handlers;

import java.util.List;

import org.json.JSONObject;

import com.cskbank.api.UserAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;

public class CommonHandler {

	private UserAPI api;

	public CommonHandler(PersistanceIdentifier identifier) throws AppException {
		try {
			@SuppressWarnings("unchecked")
			Class<UserAPI> persistanceClass = (Class<UserAPI>) Class.forName(
					"com.cskbank.api." + identifier.toString().toLowerCase() + "." + identifier.toString() + "UserAPI");
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
			return CachePool.getUserRecordCache().refreshData(userID);
		}
		return null;
	}

	public List<Transaction> getTransactionsOfAccount(Account account, int pageNumber, TransactionHistoryLimit limit)
			throws AppException {
		ValidatorUtil.validateObject(account);
		ValidatorUtil.validatePositiveNumber(pageNumber);
		ValidatorUtil.validateObject(limit);
		return api.getTransactionsOfAccount(account.getAccountNumber(), pageNumber, limit);
	}

	public List<Transaction> getTransactionsOfAccount(Account account, int pageNumber, long startDate, long endDate)
			throws AppException {
		ValidatorUtil.validateObject(account);
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

		return api.getTransactionsOfAccount(account.getAccountNumber(), pageNumber, startDate, endDate);
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

	public boolean resetPassword(int customerId, String newPassword) throws AppException {
		ValidatorUtil.validateId(customerId);
		ValidatorUtil.validatePassword(newPassword);
		return api.resetPassword(customerId, newPassword);
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
		} else if (!apiKey.getIsActive()) {
			throw new AppException(ActivityExceptionMessages.API_KEY_EXPIRED);
		}
	}

	public boolean doesEmailExist(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		return api.doesEmailExist(email);
	}

	public boolean doesEmailBelongsToUser(int userId, String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		ValidatorUtil.validateId(userId);

		return api.doesEmailBelongToUser(userId, email);
	}

}
