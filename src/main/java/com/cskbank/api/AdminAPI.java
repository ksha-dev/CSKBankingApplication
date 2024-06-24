package com.cskbank.api;

import java.util.List;
import java.util.Map;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil.ModifiableField;

public interface AdminAPI extends EmployeeAPI {

	// Employee
	public boolean createEmployee(EmployeeRecord employee) throws AppException;

	public void addEmployeeRecord(EmployeeRecord employee) throws AppException;

	public boolean updateEmployeeDetails(int employeeId, ModifiableField field, Object value, int adminId)
			throws AppException;

	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException;

	public int getPageCountOfEmployees() throws AppException;

	// Branch
	public int createBranch(Branch branch) throws AppException;

	public boolean updateBranchDetails(Branch branch, ModifiableField field, Object value) throws AppException;

	public Map<Integer, Branch> getBranchesInBank(int pageNumber) throws AppException;

	public int getPageCountOfBranches() throws AppException;

	// Accounts
	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException;

	public int getPageCountOfAccountsInBank() throws AppException;

	// API Keys

	public int getPageCountOfAPIKeys() throws AppException;

	public List<APIKey> getListOfAPIKeys(int pageNumber) throws AppException;

	public boolean generateApiKey(APIKey apiKey) throws AppException;

	public boolean isDBInitialized();

}
