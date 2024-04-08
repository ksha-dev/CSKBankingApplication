package api;

import java.util.Map;

import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.EmployeeRecord;
import utility.ConstantsUtil.ModifiableField;

public interface AdminAPI extends EmployeeAPI {

	// Employee
	public boolean createEmployee(EmployeeRecord employee) throws AppException;

	public boolean updateEmployeeDetails(int employeeId, ModifiableField field, Object value) throws AppException;

	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException;

	public int getPageCountOfEmployees() throws AppException;

	// Branch
	public int createBranch(Branch branch) throws AppException;

	public boolean updateBranchDetails(int branchId, ModifiableField field, Object value) throws AppException;

	public Map<Integer, Branch> getBranchesInBank(int pageNumber) throws AppException;

	public int getPageCountOfBranches() throws AppException;

	// Accounts
	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException;

	public int getPageCountOfAccountsInBank() throws AppException;
}
