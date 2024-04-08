package operations;

import java.util.List;
import java.util.Map;

import api.EmployeeAPI;
import api.mysql.MySQLEmployeeAPI;
import cache.CachePool;
import exceptions.AppException;
import exceptions.messages.ActivityExceptionMessages;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import modules.UserRecord;
import utility.ValidatorUtil;
import utility.ConstantsUtil;
import utility.ConstantsUtil.AccountType;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.Status;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;
import utility.ConvertorUtil;

public class EmployeeOperations {
	private EmployeeAPI api = new MySQLEmployeeAPI();

	public EmployeeRecord getEmployeeRecord(int employeeId) throws AppException {
		UserRecord user = CachePool.getUserRecordCache().get(employeeId);
		if (!(user.getType() == UserType.EMPLOYEE || user.getType() == UserType.ADMIN)) {
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
		if (user.getType() != UserType.CUSTOMER) {
			throw new AppException(ActivityExceptionMessages.NO_CUSTOMER_RECORD_FOUND);
		}
		return (CustomerRecord) user;
	}

	public Branch getBrachDetails(int branchId) throws AppException {
		return CachePool.getBranchCache().get(branchId);
	}

	public int getBranchAccountsPageCount(int branchId) throws AppException {
		return api.getNumberOfPagesOfAccounts(branchId);
	}

	public Map<Long, Account> getListOfAccountsInBranch(int employeeId, int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.viewAccountsInBranch(getEmployeeRecord(employeeId).getBranchId(), pageNumber);
	}

	public Map<Long, Account> getAssociatedAccountsOfCustomer(int customerId) throws AppException {
		getCustomerRecord(customerId);
		return api.getAccountsOfUser(customerId);
	}

	public Account createNewCustomerAndAccount(CustomerRecord customer, AccountType accountType, double depositAmount,
			int employeeId, String pin) throws AppException {
		customer.setType(UserType.CUSTOMER.getUserTypeId());
		ValidatorUtil.validateObject(customer);
		return createAccountForExistingCustomer(api.createCustomer(customer), accountType, depositAmount, employeeId,
				pin);
	}

	public Account createAccountForExistingCustomer(int customerId, AccountType accountType, double depositAmount,
			int employeeId, String pin) throws AppException {
		ValidatorUtil.validateId(customerId);
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateObject(accountType);
		ValidatorUtil.validatePositiveNumber((long) depositAmount);

		getCustomerRecord(customerId);
		if (depositAmount < ConstantsUtil.MINIMUM_DEPOSIT_AMOUNT) {
			throw new AppException(ActivityExceptionMessages.MINIMUM_DEPOSIT_REQUIRED);
		}
		long accountNumber = api.createAccount(customerId, accountType, getEmployeeRecord(employeeId).getBranchId());
		depositAmount(employeeId, accountNumber, depositAmount, pin);
		return CachePool.getAccountCache().get(accountNumber);
	}

	public long depositAmount(int employeeId, long accountNumber, double amount, String pin) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validatePositiveNumber((long) amount);
		System.out.println(ConvertorUtil.convertToTwoDecimals(amount));
		if (api.userConfimration(employeeId, pin)) {
			return api.depositAmount(accountNumber, amount, getEmployeeRecord(employeeId));
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public long withdrawAmount(int employeeId, long accountNumber, double amount, String pin) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validatePositiveNumber((long) amount);
		if (api.userConfimration(employeeId, pin)) {
			return api.withdrawAmount(accountNumber, amount, getEmployeeRecord(employeeId));
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean changeAccountStatus(long accountNumber, Status status, int employeeId, String pin)
			throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateObject(status);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(employeeId, pin)) {
			return api.changeAccountStatus(accountNumber, status, employeeId, pin);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean closeAccount(long accountNumber, int employeeId, String pin) throws AppException {
		ValidatorUtil.validateId(accountNumber);
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validatePIN(pin);
		if (getAccountDetails(accountNumber).getBalance() > 0) {
			throw new AppException(ActivityExceptionMessages.CLEAR_BALANCE_TO_CLOSE_ACCOUNT);
		}
		if (api.userConfimration(employeeId, pin)) {
			return api.changeAccountStatus(accountNumber, Status.CLOSED, employeeId, pin);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean updateCustomerDetails(int employeeId, int customerId, ModifiableField field, Object value,
			String pin) throws AppException {
		ValidatorUtil.validatePositiveNumber(customerId);
		ValidatorUtil.validateObject(field);
		if (!ConstantsUtil.EMPLOYEE_MODIFIABLE_FIELDS.contains(field)) {
			throw new AppException(ActivityExceptionMessages.MODIFICATION_ACCESS_DENIED);
		}
		ValidatorUtil.validateObject(value);
		getCustomerRecord(customerId);
		if (api.userConfimration(employeeId, pin)) {
			boolean status = api.updateProfileDetails(customerId, field, value);
			CachePool.getUserRecordCache().refreshData(customerId);
			return status;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean updatePassword(int customerId, String oldPassword, String newPassword) throws AppException {
		ValidatorUtil.validateId(customerId);
		ValidatorUtil.validatePassword(oldPassword);
		ValidatorUtil.validatePassword(newPassword);

		return api.updatePassword(customerId, oldPassword, newPassword);
	}
}
