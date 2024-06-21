package com.cskbank.test;

import java.util.Iterator;

import com.adventnet.cskbank.BRANCH;
import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.USER;
import com.adventnet.ds.query.Column;
import com.adventnet.ds.query.Criteria;
import com.adventnet.ds.query.QueryConstants;
import com.adventnet.ds.query.UpdateQuery;
import com.adventnet.ds.query.UpdateQueryImpl;
import com.adventnet.persistence.DataAccess;
import com.adventnet.persistence.DataAccessException;
import com.adventnet.persistence.DataObject;
import com.adventnet.persistence.Row;
import com.adventnet.persistence.WritableDataObject;
import com.cskbank.exceptions.AppException;
import com.cskbank.modules.Branch;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.SecurityUtil;
import com.zoho.logs.logclient.v2.LogAPI;
import com.zoho.logs.logclient.v2.json.ZLMap;

public class MickeyLiteTest {

	public static void initDB() throws DataAccessException, AppException {
		int userId = initUser();
		initCredential(userId);
		int branchID = initBranch(userId);
		initAdmin(userId, branchID);
	}

	private static void initAdmin(int userId, int branchID) throws DataAccessException {
		Row newEmployeeRow = new Row(EMPLOYEE.TABLE);
		newEmployeeRow.set(EMPLOYEE.USER_ID, userId);
		newEmployeeRow.set(EMPLOYEE.BRANCH_ID, branchID);

		DataObject empDO = new WritableDataObject();
		empDO.addRow(newEmployeeRow);
		DataAccess.add(empDO);
	}

	private static int initBranch(int userId) throws AppException, DataAccessException {
		Branch branch = new Branch();
		branch.setAccountsCount(0);
		branch.setAddress("CSK Head Branch");
		branch.setPhone(9000090000L);
		branch.setEmail("head@cskbank.in");
		branch.setModifiedBy(userId);
		branch.setCreatedAt(System.currentTimeMillis());

		Row branchRow = new Row(BRANCH.TABLE);

		branchRow.set(BRANCH.NAME, branch.getAddress());
		branchRow.set(BRANCH.ADDRESS, branch.getAddress());
		branchRow.set(BRANCH.PHONE, branch.getPhone());
		branchRow.set(BRANCH.EMAIL, branch.getEmail());
		branchRow.set(BRANCH.CREATED_AT, branch.getCreatedAt());
		branchRow.set(BRANCH.MODIFIED_BY, branch.getModifiedBy());

		DataObject newUserDO = new WritableDataObject();
		newUserDO.addRow(branchRow);
		branch.setBrachId(DataAccess.add(newUserDO).getFirstRow(BRANCH.TABLE).getInt(BRANCH.BRANCH_ID));
		int branchID = branch.getBranchId();

		UpdateQuery ifscUpdate = new UpdateQueryImpl(BRANCH.TABLE);
		ifscUpdate.setCriteria(
				new Criteria(Column.getColumn(BRANCH.TABLE, BRANCH.BRANCH_ID), branchID, QueryConstants.EQUAL));
		ifscUpdate.setUpdateColumn(BRANCH.IFSC_CODE, GetterUtil.getIfscCode(branch.getBranchId()));
		DataAccess.update(ifscUpdate);
		return branchID;
	}

	private static void initCredential(int userId) throws DataAccessException {
		Row newCredentialRow = new Row(CREDENTIAL.TABLE);
		newCredentialRow.set(CREDENTIAL.USER_ID, userId);
		newCredentialRow.set(CREDENTIAL.PASSWORD, SecurityUtil.encryptPasswordSHA256("Admin@2024"));
		newCredentialRow.set(CREDENTIAL.PIN, SecurityUtil.encryptPasswordSHA256("1234"));
		newCredentialRow.set(CREDENTIAL.CREATED_AT, System.currentTimeMillis());
		newCredentialRow.set(CREDENTIAL.MODIFIED_BY, userId);

		DataObject newCredentialDO = new WritableDataObject();
		newCredentialDO.addRow(newCredentialRow);
		DataAccess.add(newCredentialDO);
	}

	private static int initUser() throws DataAccessException {
		Row newUserRow = new Row(USER.TABLE);
		newUserRow.set(USER.FIRST_NAME, "SUPER");
		newUserRow.set(USER.LAST_NAME, "ADMIN");
		newUserRow.set(USER.GENDER, Gender.OTHER.getGenderID());
		newUserRow.set(USER.DOB, 946665000000L);
		newUserRow.set(USER.ADDRESS, "CSK Bank");
		newUserRow.set(USER.PHONE, 9000000000L);
		newUserRow.set(USER.EMAIL, "superadmin@cskbank.in");
		newUserRow.set(USER.TYPE, Type.ADMIN.getTypeID());
		newUserRow.set(USER.STATUS, Status.ACTIVE.getStatusID());
		newUserRow.set(USER.CREATED_AT, System.currentTimeMillis());
		newUserRow.set(USER.MODIFIED_BY, 1);

		DataObject newUserDO = new WritableDataObject();
		newUserDO.addRow(newUserRow);
		int userId = DataAccess.add(newUserDO).getFirstRow(USER.TABLE).getInt(USER.USER_ID);
		return userId;
	}

	public static void test() throws AppException {

		try {
			Row u = new Row(USER.TABLE);
			u.set(USER.FIRST_NAME, "Sharan");
			u.set(USER.LAST_NAME, "K");
			u.set(USER.DOB, 100);
			u.set(USER.GENDER, Gender.MALE.getGenderID());
			u.set(USER.ADDRESS, "Chennai");
			u.set(USER.PHONE, 9999988889L);
			u.set(USER.EMAIL, "sharan@gmail.com");
			u.set(USER.TYPE, Type.CUSTOMER.getTypeID());
			u.set(USER.STATUS, Status.ACTIVE.getStatusID());
			u.set(USER.CREATED_AT, System.currentTimeMillis());
			u.set(USER.MODIFIED_BY, 1);
			DataObject dataObject = new WritableDataObject();
			dataObject.addRow(u);
			dataObject = DataAccess.add(dataObject);

			LogAPI.log("mickey",
					new ZLMap().put("firstRow", dataObject.getFirstRow(USER.TABLE).getString(USER.FIRST_NAME)));

			Iterator<?> it = dataObject.getRows(USER.TABLE);
			while (it.hasNext()) {
				Row row = (Row) it.next();
				LogAPI.log("mickey", new ZLMap().put(row.getInt(USER.USER_ID) + "", row.getString(USER.FIRST_NAME)));
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new AppException(e.getMessage());
		}

	}
}
