package com.cskbank.api.mickey;

import java.util.List;
import java.util.Map;

import com.cskbank.api.AdminAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil.ModifiableField;

public class MickeyAdminAPI extends MickeyEmployeeAPI implements AdminAPI {

	@Override
	public boolean createEmployee(EmployeeRecord employee) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateEmployeeDetails(int employeeId, ModifiableField field, Object value, int adminId)
			throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPageCountOfEmployees() throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int createBranch(Branch branch) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean updateBranchDetails(Branch branch, ModifiableField field, Object value) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<Integer, Branch> getBranchesInBank(int pageNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPageCountOfBranches() throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPageCountOfAccountsInBank() throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getPageCountOfAPIKeys() throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<APIKey> getListOfAPIKeys(int pageNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean generateApiKey(APIKey apiKey) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

}
