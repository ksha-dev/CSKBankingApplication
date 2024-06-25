package com.cskbank.api.mickey;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.transaction.TransactionManager;

import com.adventnet.cskbank.ACCOUNT;
import com.adventnet.cskbank.APIKEY;
import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.DataSet;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.QueryConstructionException;
import com.adventnet.ds.query.Range;
import com.adventnet.ds.query.SelectQuery;
import com.adventnet.ds.query.SelectQueryImpl;
import com.adventnet.ds.query.SortColumn;
import com.adventnet.ds.query.Table;
import com.adventnet.ds.query.UpdateQuery;
import com.adventnet.ds.query.UpdateQueryImpl;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.api.AdminAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.LogUtil;
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
			} catch (Exception e1) {
				e.initCause(e1);
			}
			throw new AppException(APIExceptionMessage.EMPLOYEE_CREATION_FAILED, e);
		}
	}

	@Override
	public void addEmployeeRecord(EmployeeRecord employee) throws AppException {
		ValidatorUtil.validateObject(employee);
		Row newEmployeeRow = new Row(EMPLOYEE.TABLE);
		newEmployeeRow.set(EMPLOYEE.USER_ID, employee.getUserId());
		newEmployeeRow.set(EMPLOYEE.BRANCH_ID, employee.getBranchId());
		try {
			DataObject empDO = new WritableDataObject();
			empDO.addRow(newEmployeeRow);
			DataAccess.add(empDO);
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.EMPLOYEE_CREATION_FAILED, e);
		}
	}

	@Override
	public boolean updateEmployeeDetails(int employeeId, ModifiableField field, Object value, int adminId)
			throws AppException {
		throw new AppException(APIExceptionMessage.OPERATION_RESTRICTED);
	}

	@Override
	public Map<Integer, EmployeeRecord> getEmployees(int pageNumber) throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(EMPLOYEE.TABLE));
			query.addSortColumn(new SortColumn(Column.getColumn(EMPLOYEE.TABLE, EMPLOYEE.USER_ID), true));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));
			query.addSelectColumn(Column.getColumn(EMPLOYEE.TABLE, EMPLOYEE.USER_ID));
			query.addSelectColumn(Column.getColumn(EMPLOYEE.TABLE, EMPLOYEE.BRANCH_ID));

			Map<Integer, EmployeeRecord> employees = new LinkedHashMap<Integer, EmployeeRecord>();
			Iterator<?> it = DataAccess.get(query).getRows(EMPLOYEE.TABLE);
			while (it.hasNext()) {
				EmployeeRecord employee = MickeyConverstionUtil.convertToEmployeeRecord((Row) it.next());
				MickeyAPIUtil.updateUserRecord(employee);
				employees.put(employee.getUserId(), employee);
			}
			return employees;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public int getPageCountOfEmployees() throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(EMPLOYEE.TABLE));
			query.addSelectColumn(Column.getColumn(EMPLOYEE.TABLE, EMPLOYEE.USER_ID).count());

			DataSet dataset = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataset.next()) {
				return GetterUtil.getPageCount((int) dataset.getValue(1));
			} else {
				throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS);
			}
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public int createBranch(Branch branch) throws AppException {
		Row branchRow = new Row(BRANCH.TABLE);

		branchRow.set(BRANCH.NAME, branch.getAddress());
		branchRow.set(BRANCH.ADDRESS, branch.getAddress());
		branchRow.set(BRANCH.PHONE, branch.getPhone());
		branchRow.set(BRANCH.EMAIL, branch.getEmail());
		branchRow.set(BRANCH.CREATED_AT, branch.getCreatedAt());
		branchRow.set(BRANCH.MODIFIED_BY, branch.getModifiedBy());

		TransactionManager transactionManager = DataAccess.getTransactionManager();

		try {
			transactionManager.begin();
			DataObject newUserDO = new WritableDataObject();
			newUserDO.addRow(branchRow);
			branch.setBrachId(DataAccess.add(newUserDO).getFirstRow(BRANCH.TABLE).getInt(BRANCH.BRANCH_ID));

			UpdateQuery ifscUpdate = new UpdateQueryImpl(BRANCH.TABLE);
			ifscUpdate.setCriteria(new Criteria(Column.getColumn(BRANCH.TABLE, BRANCH.BRANCH_ID), branch.getBranchId(),
					QueryConstants.EQUAL));
			ifscUpdate.setUpdateColumn(BRANCH.IFSC_CODE, GetterUtil.getIfscCode(branch.getBranchId()));
			DataAccess.update(ifscUpdate);
			transactionManager.commit();
			return branch.getBranchId();
		} catch (Exception e) {
			try {
				transactionManager.rollback();
			} catch (Exception e2) {
				e.initCause(e2);
			}
			throw new AppException(APIExceptionMessage.BRANCH_CREATION_FAILED, e);
		}
	}

	@Override
	public boolean updateBranchDetails(Branch branch, ModifiableField field, Object value) throws AppException {
		throw new AppException(APIExceptionMessage.OPERATION_RESTRICTED);
	}

	@Override
	public Map<Integer, Branch> getBranchesInBank(int pageNumber) throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(BRANCH.TABLE));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));
			query.addSortColumn(new SortColumn(Column.getColumn(BRANCH.TABLE, BRANCH.BRANCH_ID), true));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.BRANCH_ID));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.ADDRESS));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.PHONE));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.EMAIL));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.ACCOUNTS_COUNT));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.IFSC_CODE));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.CREATED_AT));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.MODIFIED_BY));
			query.addSelectColumn(Column.getColumn(BRANCH.TABLE, BRANCH.MODIFIED_AT));

			Map<Integer, Branch> branches = new LinkedHashMap<Integer, Branch>();
			Iterator<?> it = DataAccess.get(query).getRows(BRANCH.TABLE);
			while (it.hasNext()) {
				Branch branch = MickeyConverstionUtil.convertToBranch((Row) it.next());
				branches.put(branch.getBranchId(), branch);
			}
			return branches;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public int getPageCountOfBranches() throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(BRANCH.TABLE));
			query.addSelectColumn(new Column(BRANCH.TABLE, BRANCH.BRANCH_ID).count());
			DataSet dataSet = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataSet.next()) {
				return GetterUtil.getPageCount((int) dataSet.getValue(1));
			}
		} catch (SQLException | QueryConstructionException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
		return 0;
	}

	@Override
	public Map<Long, Account> viewAccountsInBank(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(ACCOUNT.TABLE));
			query.addSortColumn(new SortColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER), false));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));

			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.USER_ID));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BRANCH_ID));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.TYPE));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.STATUS));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.LAST_TRANSACTED_AT));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.BALANCE));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.CREATED_AT));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.MODIFIED_BY));
			query.addSelectColumn(Column.getColumn(ACCOUNT.TABLE, ACCOUNT.MODIFIED_AT));

			Iterator<?> it = DataAccess.get(query).getRows(ACCOUNT.TABLE);
			Map<Long, Account> accounts = new LinkedHashMap<Long, Account>();
			while (it.hasNext()) {
				Account account = MickeyConverstionUtil.convertToAccount((Row) it.next());
				accounts.put(account.getAccountNumber(), account);
			}
			return accounts;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public int getPageCountOfAccountsInBank() throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(ACCOUNT.TABLE));
			query.addSelectColumn(new Column(ACCOUNT.TABLE, ACCOUNT.ACCOUNT_NUMBER).count());

			DataSet dataset = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataset.next()) {
				return GetterUtil.getPageCount((int) dataset.getValue(1));
			} else {
				throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
			}
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public int getPageCountOfAPIKeys() throws AppException {
		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(APIKEY.TABLE));
			query.addSelectColumn(new Column(APIKEY.TABLE, APIKEY.AK_ID).count());

			DataSet dataset = MickeyConstants.getRAPI().executeQuery(query, MickeyConstants.getRAPIConnection());
			if (dataset.next()) {
				return GetterUtil.getPageCount((int) dataset.getValue(1));
			} else {
				throw new AppException(APIExceptionMessage.UNKNOWN_ERROR);
			}
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.UNKNOWN_ERROR, e);
		}
	}

	@Override
	public List<APIKey> getListOfAPIKeys(int pageNumber) throws AppException {
		ValidatorUtil.validateId(pageNumber);

		try {
			SelectQuery query = new SelectQueryImpl(Table.getTable(APIKEY.TABLE));
			query.addSortColumn(new SortColumn(Column.getColumn(APIKEY.TABLE, APIKEY.CREATED_AT), false));
			query.setRange(new Range(ConvertorUtil.convertPageToOffset(pageNumber), ConstantsUtil.LIST_LIMIT));

			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.AK_ID));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.ORG_NAME));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.API_KEY));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.CREATED_AT));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.VALID_UNTIL));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.IS_ACTIVE));
			query.addSelectColumn(Column.getColumn(APIKEY.TABLE, APIKEY.MODIFIED_AT));

			Iterator<?> it = DataAccess.get(query).getRows(APIKEY.TABLE);
			List<APIKey> apiKeys = new LinkedList<APIKey>();
			while (it.hasNext()) {
				APIKey apiKey = MickeyConverstionUtil.convertToAPIKey((Row) it.next());
				apiKeys.add(apiKey);
			}
			return apiKeys;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
	}

	@Override
	public boolean generateApiKey(APIKey apiKey) throws AppException {
		ValidatorUtil.validateObject(apiKey);

		Row apikeyRow = new Row(APIKEY.TABLE);
		apikeyRow.set(APIKEY.ORG_NAME, apiKey.getOrgName());
		apikeyRow.set(APIKEY.API_KEY, apiKey.getAPIKey());
		apikeyRow.set(APIKEY.CREATED_AT, apiKey.getCreatedAt());
		apikeyRow.set(APIKEY.VALID_UNTIL, apiKey.getValidUntil());
		apikeyRow.set(APIKEY.IS_ACTIVE, true);

		try {
			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(apikeyRow);
			apiKey.setAkId(DataAccess.add(dataObject).getFirstRow(APIKEY.TABLE).getLong(APIKEY.AK_ID));
			return true;
		} catch (Exception e) {
			throw new AppException(APIExceptionMessage.API_GENERATION_FAILED, e);
		}
	}

	@Override
	public int isDBInitialized() throws AppException {
		try {
			Row userRow = new Row(USER.TABLE);
			DataObject userDO = DataAccess.get(USER.TABLE, userRow);
			userRow = userDO.getFirstRow(USER.TABLE);
			return userRow == null ? 0 : userRow.getInt(USER.USER_ID);
		} catch (DataAccessException e) {
			throw new AppException(e);
		}
	}

}
