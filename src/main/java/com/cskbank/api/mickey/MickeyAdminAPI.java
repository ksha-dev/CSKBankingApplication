package com.cskbank.api.mickey;

import java.util.List;
import java.util.Map;

import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.api.AdminAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ValidatorUtil;

public class MickeyAdminAPI extends MickeyEmployeeAPI implements AdminAPI {

	@Override
	public boolean createEmployee(EmployeeRecord employee) throws AppException {
		ValidatorUtil.validateObject(employee);

		TransactionManager txnMg = DataAccess.getTransactionManager();
		try {
			txnMg.begin();
			createUserRecord(employee);

			Row newEmployeeRow = new Row(EMPLOYEE.TABLE);
			newEmployeeRow.set(EMPLOYEE.USER_ID, employee.getUserId());
			newEmployeeRow.set(EMPLOYEE.BRANCH_ID, employee.getBranchId());

			DataObject empDO = new WritableDataObject();
			empDO.addRow(newEmployeeRow);

			DataAccess.add(empDO);
			txnMg.commit();
			return true;
		} catch (Exception e) {
			try {
				txnMg.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e.initCause(e1);
			}
			throw new AppException(e);
		}
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
