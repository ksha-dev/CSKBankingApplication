package com.cskbank.utility;

import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.User;

import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.exceptions.messages.InvalidInputMessage;

public class ConstantsUtil {

	public static final int LIST_LIMIT = 10;
	public static final int MAX_PAGE_COUNT = 10;
	public static final double MINIMUM_DEPOSIT_AMOUNT = 2000.0;
	public static final List<ModifiableField> USER_MODIFIABLE_FIELDS;
	public static final List<ModifiableField> EMPLOYEE_MODIFIABLE_FIELDS;
	public static final List<ModifiableField> ADMIN_MODIFIABLE_FIELDS;

	public static final int CACHE_SIZE = 30;
	private static final long ONE_MONTH_MILLIS = 2592000000L;
	private static final long ONE_DAY_MILLIS = 86400000;
	private static final int API_VALID_DAYS = 5;

	public static long getAPIValidityTime() {
		return ONE_DAY_MILLIS * API_VALID_DAYS;
	}

	public static enum CachePort {
		ACCOUNTS(6379), USER_RECORD(6000);

		private int cachePort;

		private CachePort(int cachePort) {
			this.cachePort = cachePort;
		}

		public int getPort() {
			return this.cachePort;
		}
	}

	static {
		List<ModifiableField> tempList = new ArrayList<>();
		tempList.addAll(List.of(ModifiableField.ADDRESS, ModifiableField.EMAIL));
		USER_MODIFIABLE_FIELDS = List.copyOf(tempList);

		tempList.addAll(List.of(ModifiableField.FIRST_NAME, ModifiableField.LAST_NAME, ModifiableField.GENDER,
				ModifiableField.PHONE, ModifiableField.DATE_OF_BIRTH, ModifiableField.AADHAAR_NUMBER,
				ModifiableField.PAN_NUMBER));
		EMPLOYEE_MODIFIABLE_FIELDS = List.copyOf(tempList);

		tempList.addAll(List.of(ModifiableField.BRANCH_ID, ModifiableField.TYPE));
		ADMIN_MODIFIABLE_FIELDS = List.copyOf(tempList);
	}

	public static enum PersistanceIdentifier {
		MySQL
	}

	public static enum ModifiableField {
		ADDRESS, PHONE, EMAIL, DATE_OF_BIRTH, GENDER, AADHAAR_NUMBER, PAN_NUMBER, FIRST_NAME, LAST_NAME, BRANCH_ID,
		STATUS, TYPE
	}

	public static enum RequestStatus {
		SUCCESS, FAILED, UNAUTHORIZED;

		public String toString() {
			return this.name().toLowerCase();
		}

	}

	public static final List<Status> ADMIN_MODIFIABLE_USER_STATUS = List.of(Status.ACTIVE, Status.FROZEN,
			Status.BLOCKED);

	public static enum Status {
		ACTIVE, INACTIVE, CLOSED, FROZEN, BLOCKED, VERIFICATION;
	}

	public static enum TransactionType {
		CREDIT(1), DEBIT(0);

		private int transactionTypeId;

		private TransactionType(int transactionTypeId) {
			this.transactionTypeId = transactionTypeId;
		}

		public int getTransactionTypeId() {
			return this.transactionTypeId;
		}

		public static TransactionType getTransactionType(int transactionTypeId) throws AppException {
			switch (transactionTypeId) {
			case 0:
				return DEBIT;
			case 1:
				return CREDIT;
			default:
				throw new AppException(InvalidInputMessage.INVALID_INTEGER_INPUT);
			}
		}

		public static TransactionType convertStringToEnum(String label) throws AppException {
			try {
				return valueOf(label);
			} catch (IllegalArgumentException e) {
				throw new AppException("Invalid Identifier Obtained");
			}
		}
	}

	public static enum Gender {
		MALE, FEMALE, OTHER;

	}

	public static enum TransactionHistoryLimit {
		RECENT, ONE_MONTH, THREE_MONTH, SIX_MONTH;

		public long getDuration() {
			long transactionDuration = ONE_MONTH_MILLIS;
			switch (this) {
			case ONE_MONTH:
				transactionDuration *= 1;
				break;
			case THREE_MONTH:
				transactionDuration *= 3;
				break;
			case SIX_MONTH:
				transactionDuration *= 6;
				break;
			default:
				transactionDuration = 0;
				break;
			}
			return System.currentTimeMillis() - transactionDuration;
		}

		public static TransactionHistoryLimit convertStringToEnum(String label) throws AppException {
			try {
				return valueOf(label);
			} catch (IllegalArgumentException e) {
				throw new AppException("Invalid Identifier Obtained");
			}
		}
	}

	public static enum LogOperation {
		// Accounts
		CREATE_ACCOUNT, UPDATE_ACCOUNT_STATUS, UPDATE_ACCOUNT_TYPE, AMOUNT_CREDITED, AMOUNT_DEBITED, VIEW_ACCOUNT,
		CLOSE_ACCOUNT,

		// Users
		UPDATE_USER_FIRST_NAME, UPDATE_USER_LAST_NAME, UPDATE_USER_DATE_OF_BIRTH, UPDATE_USER_ADDRESS,
		UPDATE_USER_MOBILE, UPDATE_USER_EMAIL, UPDATE_USER_TYPE, UPDATE_USER_GENDER, UPDATE_PROFILE, USER_BLOCKED,
		USER_UNBLOCKED, USER_VERIFICATION, USER_STATUS_CHANGE,

		// Customers
		CREATE_CUSTOMER, CREATE_CUSTOMER_AT_SIGNUP, UPDATE_AADHAAR_NUMBER, UPDATE_PAN_NUMBER, VIEW_CUSTOMER,
		CREATE_CUSTOMER_AND_ACCOUNT,

		// Employees
		CREATE_EMPLOYEE, UPDATE_BRANCH_ID, UPDATE_ROLE, VIEW_EMPLOYEE,

		// Credentials
		CREATE_CREDENTIALS, UPDATE_PASSWORD, UPDATE_PIN,

		// Transactions
		USER_TRANSACTION, EMPLOYEE_TRANSACTION,

		// Branch
		CREATE_BRANCH, UPDATE_BRANCH_ADDRESS, UPDATE_BRANCH_IFSC_CODE, UPDATE_BRANCH_EMAIL, UPDATE_EMAIL_PHONE,
		VIEW_BRANCH,

		// Login
		USER_LOGIN, USER_AUTHORIZATION,

		// API Keys
		CREATE_API_KEY, INVALIDATE_API_KEY,

		// OTP
		OTP_SENT_TO_USER, WRONG_OTP_ENTERED, OTP_REGENERATED
	}

	public static enum OperationStatus {
		SUCCESS, FAILURE, PROCESSING;
	}

	public static enum SessionUser {
		user, blocked_user, unverified_user;
	}

	public static final int MAX_RETRY_COUNT = 5;
	public static final int MAX_REGENERATION_COUNT = 3;
	public static final long EXPIRY_DURATION_SECONDS = 300;
	public static final long EXPIRY_DURATION_MILLIS = EXPIRY_DURATION_SECONDS * 1000;

}
