package operations;

import java.util.Map;

import api.AdminAPI;
import api.mysql.MySQLAdminAPI;
import cache.CachePool;
import exceptions.AppException;
import exceptions.messages.ActivityExceptionMessages;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.UserRecord;
import utility.ConstantsUtil.ModifiableField;
import utility.ConstantsUtil.UserType;
import utility.ConstantsUtil;
import utility.ValidatorUtil;

public class AdminOperations {

	private AdminAPI api = new MySQLAdminAPI();

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

	public int getPageCountOfAccountsInBank() throws AppException {
		return api.getPageCountOfAccountsInBank();
	}

	public Map<Integer, Branch> viewBrachesInBank(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);
		return api.getBranchesInBank(pageNumber);
	}

	public int getPageCountOfBranches() throws AppException {
		return api.getPageCountOfBranches();
	}
}
