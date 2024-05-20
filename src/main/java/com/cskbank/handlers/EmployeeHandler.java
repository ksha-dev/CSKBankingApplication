package com.cskbank.handlers;

import java.util.Map;

import com.cskbank.api.EmployeeAPI;
import com.cskbank.api.UserAPI;
import com.cskbank.api.mysql.MySQLEmployeeAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.Account;
import com.cskbank.modules.Account.AccountType;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
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

public class EmployeeHandler {
	private EmployeeAPI api = new MySQLEmployeeAPI();

	public EmployeeHandler(PersistanceIdentifier obj) throws AppException {
		try {
			@SuppressWarnings("unchecked")
			Class<EmployeeAPI> persistanceClass = (Class<EmployeeAPI>) Class
					.forName("com.cskbank.api." + obj.toString().toLowerCase() + "." + obj.toString() + "EmployeeAPI");
			api = persistanceClass.getConstructor().newInstance();
		} catch (Exception e) {
			throw new AppException(ActivityExceptionMessages.CANNOT_LOAD_CONNECTOR);
		}
	}

	public EmployeeRecord getEmployeeRecord(int employeeId) throws AppException {
		UserRecord user = CachePool.getUserRecordCache().get(employeeId);
		if (!(user.getType() == UserRecord.Type.EMPLOYEE || user.getType() == UserRecord.Type.ADMIN)) {
			throw new AppException(ActivityExceptionMessages.INVALID_EMPLOYEE_RECORD);
		}
		return (EmployeeRecord) user;
	}

	public Account getAccountDetails(long accountNumber) throws AppException {
		return CachePool.getAccountCache().get(accountNumber);
	}

	public CustomerRecord getCustomerRecord(int customerId) throws AppException {
		ValidatorUtil.validateId(customerId);
		UserRecord user = CachePool.getUserRecordCache().get(customerId);
		if (user.getType() != UserRecord.Type.CUSTOMER) {
			throw new AppException(ActivityExceptionMessages.NO_CUSTOMER_RECORD_FOUND);
		}
		return (CustomerRecord) user;
	}

	public Branch getBrachDetails(int branchId) throws AppException {
		return CachePool.getBranchCache().get(branchId);
	}

	public int getBranchAccountsPageCount(int employeeId) throws AppException {
		return api.getNumberOfPagesOfAccounts(getEmployeeRecord(employeeId).getBranchId());
	}

	public Map<Long, Account> getListOfAccountsInBranch(int employeeId, int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.viewAccountsInBranch(getEmployeeRecord(employeeId).getBranchId(), pageNumber);
	}

	public Map<Long, Account> getAssociatedAccountsOfCustomer(int customerId) throws AppException {
		getCustomerRecord(customerId);
		return api.getAccountsOfUser(customerId);
	}

	public void createNewCustomerFromSignup(CustomerRecord customer) throws AppException {
		ValidatorUtil.validateObject(customer);
		customer.setType(UserRecord.Type.CUSTOMER);
		customer.setStatus(Status.VERIFICATION);
		customer.setCreatedAt(System.currentTimeMillis());
		customer.setModifiedBy(1);
		customer.setUserId(api.createCustomer(customer));
	}

	public Account createNewCustomerAndAccount(CustomerRecord customer, Account.AccountType accountType,
			double depositAmount, int employeeId, String pin) throws AppException {
		ValidatorUtil.validateObject(customer);
		if (api.userConfimration(employeeId, pin)) {
			customer.setType(UserRecord.Type.CUSTOMER);
			customer.setStatus(Status.ACTIVE);
			customer.setCreatedAt(System.currentTimeMillis());
			customer.setModifiedBy(employeeId);
			return createAccountForExistingCustomer(api.createCustomer(customer), accountType, depositAmount,
					employeeId, pin);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public Account createAccountForExistingCustomer(int customerId, Account.AccountType accountType,
			double depositAmount, int employeeId, String pin) throws AppException {
		ValidatorUtil.validateId(customerId);
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateObject(accountType);
		ValidatorUtil.validatePositiveNumber((long) depositAmount);

		getCustomerRecord(customerId);
		if (depositAmount < ConstantsUtil.MINIMUM_DEPOSIT_AMOUNT) {
			throw new AppException(ActivityExceptionMessages.MINIMUM_DEPOSIT_REQUIRED);
		}
		if (api.userConfimration(employeeId, pin)) {
			Account account = new Account();
			account.setBranchId(getEmployeeRecord(employeeId).getBranchId());
			account.setType(accountType.getAccountTypeId());
			account.setModifiedBy(employeeId);
			account.setCreatedAt(System.currentTimeMillis());
			account.setUserId(customerId);
			account.setOpeningDate(account.getCreatedAt());

			long accountNumber = api.createAccount(account);
			depositAmount(employeeId, accountNumber, depositAmount, pin);
			return CachePool.getAccountCache().get(accountNumber);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public Transaction depositAmount(int employeeId, long accountNumber, double amount, String pin)
			throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateAmount(amount);
		System.out.println(ConvertorUtil.convertToTwoDecimals(amount));

		EmployeeRecord employee = getEmployeeRecord(employeeId);
		Account transactionAccount = getAccountDetails(accountNumber);
		if (api.userConfimration(employeeId, pin)) {
			Transaction depositTransaction = new Transaction();
			depositTransaction.setUserId(employeeId);
			depositTransaction.setViewerAccountNumber(accountNumber);
			depositTransaction.setTransactedAmount(amount);
			depositTransaction.setRemarks("CR-DEPOSIT-BID-" + employee.getBranchId() + "-EID-" + employee.getUserId());
			depositTransaction.setTransactionType(TransactionType.CREDIT.getTransactionTypeId());
			depositTransaction.setTimeStamp(System.currentTimeMillis());
			depositTransaction.setCreatedAt(System.currentTimeMillis());
			depositTransaction.setModifiedBy(employeeId);

			api.depositAmount(depositTransaction);
			CachePool.getAccountCache().refreshData(accountNumber);
			return depositTransaction;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public Transaction withdrawAmount(int employeeId, long accountNumber, double amount, String pin)
			throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validatePositiveNumber((long) amount);

		EmployeeRecord employee = getEmployeeRecord(employeeId);
		Account transactionAccount = getAccountDetails(accountNumber);
		if (transactionAccount.getStatus() == Status.FROZEN) {
			throw new AppException(APIExceptionMessage.ACCOUNT_FROZEN);
		}
		if (transactionAccount.getBalance() < amount) {
			throw new AppException(APIExceptionMessage.INSUFFICIENT_BALANCE);
		}

		if (api.userConfimration(employeeId, pin)) {
			Transaction withdrawTransaction = new Transaction();
			withdrawTransaction.setUserId(transactionAccount.getUserId());
			withdrawTransaction.setViewerAccountNumber(accountNumber);
			withdrawTransaction.setTransactedAmount(amount);
			withdrawTransaction.setTransactionType(TransactionType.DEBIT.getTransactionTypeId());
			withdrawTransaction
					.setClosingBalance(ConvertorUtil.convertToTwoDecimals(transactionAccount.getBalance() - amount));
			withdrawTransaction
					.setRemarks("DB-WITHDRAW-BID-" + employee.getBranchId() + "-EID-" + employee.getUserId());
			withdrawTransaction.setTimeStamp(System.currentTimeMillis());
			withdrawTransaction.setCreatedAt(System.currentTimeMillis());
			withdrawTransaction.setModifiedBy(employee.getUserId());

			api.withdrawAmount(withdrawTransaction);
			CachePool.getAccountCache().refreshData(accountNumber);
			return withdrawTransaction;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public Account changeAccountStatus(long accountNumber, Status status, int employeeId, String pin)
			throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateObject(status);
		ValidatorUtil.validatePIN(pin);

		EmployeeRecord employee = getEmployeeRecord(employeeId);
		Account account = getAccountDetails(accountNumber);
		if (employee.getType() == UserRecord.Type.EMPLOYEE && employee.getBranchId() != account.getBranchId()) {
			throw new AppException(ActivityExceptionMessages.EMPLOYEE_UNAUTHORIZED);
		}

		Status currentStatus = account.getStatus();
		if (currentStatus == Status.CLOSED) {
			throw new AppException(APIExceptionMessage.CANNOT_MODIFY_STATUS);
		} else if (currentStatus == status) {
			throw new AppException(APIExceptionMessage.STATUS_ALREADY_SET);
		}

		if (status == Status.CLOSED && account.getBalance() > 0) {
			throw new AppException(ActivityExceptionMessages.CLEAR_BALANCE_TO_CLOSE_ACCOUNT);
		}

		if (api.userConfimration(employeeId, pin)) {
			account.setStatus(status.getStatusId());
			account.setModifiedBy(employeeId);
			account.setModifiedAt(System.currentTimeMillis());

			api.changeAccountStatus(account);
			return account;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean blockUser(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		user.setStatus(Status.BLOCKED);
		user.setModifiedAt(System.currentTimeMillis());
		user.setModifiedBy(1);
		return api.changeUserStatus(user);
	}

	public boolean activateUserWithOTPVerification(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		user.setStatus(Status.ACTIVE);
		user.setModifiedAt(System.currentTimeMillis());
		user.setModifiedBy(1);
		return api.changeUserStatus(user);
	}

	public Account closeAccount(long accountNumber, int employeeId, String pin) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		return changeAccountStatus(accountNumber, Status.CLOSED, employeeId, pin);
	}

	public boolean updateCustomerDetails(int employeeId, int customerId, ModifiableField field, Object value,
			String pin) throws AppException {
		ValidatorUtil.validatePositiveNumber(customerId);
		CustomerRecord customer = getCustomerRecord(customerId);
		ValidatorUtil.validateObject(field);
		if (!ConstantsUtil.EMPLOYEE_MODIFIABLE_FIELDS.contains(field)) {
			throw new AppException(ActivityExceptionMessages.MODIFICATION_ACCESS_DENIED);
		}
		ValidatorUtil.validateObject(value);
		if (api.userConfimration(employeeId, pin)) {
			boolean status = api.updateProfileDetails(customer, field, value);
			CachePool.getUserRecordCache().refreshData(customerId);
			return status;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}
}
