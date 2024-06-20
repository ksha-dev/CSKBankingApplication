package com.cskbank.handlers;

import java.util.List;
import java.util.Map;

import com.cskbank.api.AdminAPI;
import com.cskbank.api.UserAPI;
import com.cskbank.api.mysql.MySQLAdminAPI;
import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.exceptions.messages.ActivityExceptionMessages;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.servlet.HandlerObject;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.SecurityUtil;

public class AdminHandler {

	private AdminAPI api;

	public AdminHandler(PersistanceIdentifier obj) throws AppException {
		try {
			@SuppressWarnings("unchecked")
			Class<AdminAPI> persistanceClass = (Class<AdminAPI>) Class
					.forName("com.cskbank.api." + obj.toString().toLowerCase() + "." + obj.toString() + "AdminAPI");
			api = persistanceClass.getConstructor().newInstance();
		} catch (Exception e) {
			e.printStackTrace();
			throw new AppException(ActivityExceptionMessages.CANNOT_LOAD_CONNECTOR);
		}
	}

	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.getEmployees(pageNumber);
	}

	public EmployeeRecord getEmployeeDetails(int employeeId) throws AppException {
		ValidatorUtil.validateId(employeeId);
		UserRecord user = CachePool.getUserRecordCache().get(employeeId);
		if (user instanceof EmployeeRecord) {
			return (EmployeeRecord) user;
		} else {
			throw new AppException(ActivityExceptionMessages.NO_EMPLOYEE_RECORD_FOUND);
		}
	}

	public int getPageCountOfEmployees() throws AppException {
		return api.getPageCountOfEmployees();
	}

	public boolean createEmployee(EmployeeRecord employee, int adminId, String pin) throws AppException {
		ValidatorUtil.validateObject(employee);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(adminId, pin)) {
			employee.setStatus(Status.ACTIVE);
			employee.setCreatedAt(System.currentTimeMillis());
			employee.setModifiedBy(adminId);
			return api.createEmployee(employee);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean update(int employeeId, ModifiableField field, Object value, int adminId, String pin)
			throws AppException {
		ValidatorUtil.validateId(employeeId);
		ValidatorUtil.validateId(adminId);
		ValidatorUtil.validateObject(value);
		ValidatorUtil.validateObject(field);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(adminId, pin)) {
			boolean status = api.updateEmployeeDetails(employeeId, field, value, adminId);
			CachePool.getUserRecordCache().refreshData(employeeId);
			return status;
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public Branch getBranch(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);
		return CachePool.getBranchCache().get(branchId);
	}

	public Branch createBranch(Branch branch, int adminId, String pin) throws AppException {
		ValidatorUtil.validateObject(branch);
		if (api.userConfimration(adminId, pin)) {
			branch.setModifiedBy(adminId);
			branch.setCreatedAt(System.currentTimeMillis());
			int branchId = api.createBranch(branch);
			return CachePool.getBranchCache().get(branchId);
		} else {
			throw new AppException(ActivityExceptionMessages.USER_AUTHORIZATION_FAILED);
		}
	}

	public boolean updateBranchDetails(int branchId, ModifiableField field, Object value) throws AppException {
		ValidatorUtil.validateId(branchId);
		ValidatorUtil.validateObject(field);
		if (!ConstantsUtil.ADMIN_MODIFIABLE_FIELDS.contains(field)) {
			throw new AppException(ActivityExceptionMessages.MODIFICATION_ACCESS_DENIED);
		}
		ValidatorUtil.validateObject(value);

		boolean status = api.updateBranchDetails(getBranch(branchId), field, value);
		CachePool.getBranchCache().refreshData(branchId);
		return status;
	}

	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.viewAccountsInBank(pageNumber);
	}

	public List<APIKey> getListofApiKeys(int pageNumber) throws AppException {
		return api.getListOfAPIKeys(pageNumber);
	}

	public int getPageCountOfAccountsInBank() throws AppException {
		return api.getPageCountOfAccountsInBank();
	}

	public int getPageCountOfAPIKeys() throws AppException {
		return api.getPageCountOfAPIKeys();
	}

	public Map<Integer, Branch> viewBrachesInBank(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.getBranchesInBank(pageNumber);
	}

	public int getPageCountOfBranches() throws AppException {
		return api.getPageCountOfBranches();
	}

	public APIKey generateAPIKey(String orgName) throws AppException {
		APIKey apiKey = new APIKey();
		apiKey.setOrgName(orgName);
		apiKey.setAPIKey(SecurityUtil.generateAPIKey());
		apiKey.setCreatedAt(System.currentTimeMillis());
		apiKey.setModifiedAt(apiKey.getCreatedAt());
		apiKey.setValidUntil(apiKey.getCreatedAt() + ConstantsUtil.getAPIValidityTime());
		if (api.generateApiKey(apiKey)) {
			return apiKey;
		} else
			throw new AppException(APIExceptionMessage.API_GENERATION_FAILED);
	}

	public APIKey invalidateAPIKey(int akId) throws AppException {
		APIKey apikey = api.getAPIKey(akId);
		apikey.setIsActive(false);
		apikey.setModifiedAt(System.currentTimeMillis());
		return api.invalidateApiKey(apikey);
	}

	public UserRecord blockUser(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		user.setStatus(Status.BLOCKED);
		user.setModifiedAt(System.currentTimeMillis());
		user.setModifiedBy(1);
		user = api.changeUserStatus(user);
		CachePool.getUserRecordCache().refreshData(user.getUserId());
		return user;
	}

	public UserRecord activateUserWithOTPVerification(UserRecord user) throws AppException {
		ValidatorUtil.validateObject(user);
		user.setStatus(Status.ACTIVE);
		user.setModifiedAt(System.currentTimeMillis());
		user.setModifiedBy(1);
		user = api.changeUserStatus(user);
		CachePool.getUserRecordCache().refreshData(user.getUserId());
		return user;
	}

	public UserRecord changeUserStatus(int userId, Status status, String reason, int adminId, String pin)
			throws AppException {
		ValidatorUtil.validateId(userId);
		ValidatorUtil.validateObject(status);
		ValidatorUtil.validateObject(reason);
		ValidatorUtil.validateId(adminId);
		ValidatorUtil.validatePIN(pin);

		if (api.userConfimration(adminId, pin)) {
			UserRecord user = api.getUserDetails(userId);
			if (user.getStatus() == status) {
				throw new AppException(APIExceptionMessage.USER_STATUS_UNCHANGED);
			}
			if (user.getStatus() == Status.BLOCKED && status != Status.VERIFICATION) {
				throw new AppException(ActivityExceptionMessages.BLOCKED_USER_STATUS_CHANGE_DENIED);
			}
			user.setStatus(status);
			user.setModifiedBy(adminId);
			user.setModifiedAt(System.currentTimeMillis());
			api.changeUserStatus(user);
			CachePool.getUserRecordCache().refreshData(userId);
			return user;
		} else
			throw new AppException(APIExceptionMessage.USER_CONFIRMATION_FAILED);
	}

	public Map<Long, Account> getListOfAccountsInBranch(int branchId, int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		ValidatorUtil.validateId(branchId);
		return api.viewAccountsInBranch(branchId, pageNumber);
	}

	public int getPageCountOfAccountsInBranch(int branchId) throws AppException {
		ValidatorUtil.validateId(branchId);
		return api.getNumberOfPagesOfAccountsInBranch(branchId);
	}
}
