package com.cskbank.api.mickey;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.TransactionManager;

import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.USER;
import com.adventnet.db.api.RelationalAPI;
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
			throw new AppException(e);
		}
	}

	@Override
	public boolean updateBranchDetails(Branch branch, ModifiableField field, Object value) throws AppException {
		// TODO Auto-generated method stub
		return false;
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
			DataSet dataSet = RelationalAPI.getInstance().executeQuery(query,
					RelationalAPI.getInstance().getConnection());
			if (dataSet.next()) {
				return (int) dataSet.getValue(1);
			}
		} catch (SQLException | QueryConstructionException e) {
			throw new AppException(APIExceptionMessage.CANNOT_FETCH_DETAILS, e);
		}
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
