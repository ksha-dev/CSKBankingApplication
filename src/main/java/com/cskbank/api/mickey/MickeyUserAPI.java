package com.cskbank.api.mickey;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.adventnet.cskbank.CREDENTIAL;
import com.adventnet.cskbank.CUSTOMER;
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
import com.cskbank.api.UserAPI;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.ModifiableField;
import com.cskbank.utility.ConstantsUtil.TransactionHistoryLimit;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ValidatorUtil;
import com.zoho.logs.logclient.v2.LogAPI;
import com.zoho.logs.logclient.v2.json.ZLMap;

public class MickeyUserAPI implements UserAPI {

	@Override
	public boolean userAuthentication(int userID, String password) throws AppException {
		try {
			Row criteriaRow = new Row(CREDENTIAL.TABLE);
			criteriaRow.set(CREDENTIAL.USER_ID, userID);
			DataObject credentialDO = DataAccess.get(CREDENTIAL.TABLE, criteriaRow);
			Row credentialRow = credentialDO.getFirstRow(CREDENTIAL.TABLE);
			if (credentialRow == null) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}
			if (credentialRow.getString(CREDENTIAL.PASSWORD).equals(SecurityUtil.encryptPasswordSHA256(password))) {
				return true;
			} else {
				throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
			}
		} catch (DataAccessException e) {
			throw new AppException(e);
		}
	}

	@Override
	public boolean userConfimration(int userID, String pin) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	private CustomerRecord getCustomerRecord(int customerID) throws AppException {
		try {
			Row customerRow = new Row(CUSTOMER.TABLE);
			customerRow.set(CUSTOMER.USER_ID, customerID);
			DataObject customerDO = DataAccess.get(CUSTOMER.TABLE, customerRow);
			customerRow = customerDO.getFirstRow(CUSTOMER.TABLE);
			if (ValidatorUtil.isObjectNull(customerRow)) {
				throw new AppException(APIExceptionMessage.CUSTOMER_RECORD_NOT_FOUND);
			}
			return MickeyConverstionUtil.convertToCustomerRecord(customerRow);
		} catch (DataAccessException e) {
			throw new AppException(e);
		}
	}

	private EmployeeRecord getEmployeeRecord(int employeeID) throws AppException {
		try {
			Row employeeRow = new Row(EMPLOYEE.TABLE);
			employeeRow.set(EMPLOYEE.USER_ID, employeeID);
			DataObject employeeDO = DataAccess.get(EMPLOYEE.TABLE, employeeRow);
			employeeRow = employeeDO.getFirstRow(EMPLOYEE.TABLE);
			if (employeeRow == null) {
				throw new AppException(APIExceptionMessage.EMPLOYEE_RECORD_NOT_FOUND);
			}
			return MickeyConverstionUtil.convertToEmployeeRecord(employeeRow);
		} catch (DataAccessException e) {
			throw new AppException(e);
		}
	}

	@Override
	public UserRecord getUserDetails(int userID) throws AppException {

		try {
			Row userRow = new Row(USER.TABLE);
			userRow.set(USER.USER_ID, userID);
			DataObject userDO = DataAccess.get(USER.TABLE, userRow);
			userRow = userDO.getFirstRow(USER.TABLE);

			if (ValidatorUtil.isObjectNull(userRow)) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}

			UserRecord.Type type = Type.getType(userRow.getInt(USER.TYPE));
			UserRecord user = null;
			switch (type) {
			case CUSTOMER:
				user = getCustomerRecord(userID);
				break;

			case EMPLOYEE:
			case ADMIN:
				user = getEmployeeRecord(userID);
				break;

			default:
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}

			MickeyConverstionUtil.updateUserRecord(userRow, user);
			LogAPI.log("mickey", new ZLMap().put("user", JSONObject.wrap(user).toString()));
			return user;

		} catch (Exception e) {
			throw new AppException(e);
		}
	}

	@Override
	public UserRecord getUserRecordDetails(Integer userID) throws AppException {
		return getUserDetails(userID);
	}

	@Override
	public boolean updateProfileDetails(UserRecord user, ModifiableField field, Object value) throws AppException {
		UpdateQuery update = new UpdateQueryImpl(USER.TABLE);
		Criteria whereCondition = new Criteria(new Column(USER.TABLE, USER.USER_ID), user.getUserId(),
				QueryConstants.EQUAL);
		update.setCriteria(whereCondition);
		update.setUpdateColumn(field.toString().toUpperCase(), value);
		try {
			DataAccess.update(update);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.UPDATE_FAILED, e);
		}
	}

	@Override
	public boolean updatePassword(int customerID, String oldPassword, String newPassword) throws AppException {
		ValidatorUtil.validateId(customerID);
		ValidatorUtil.validatePassword(newPassword);
		ValidatorUtil.validatePassword(newPassword);

		Criteria whereCondition = new Criteria(new Column(CREDENTIAL.TABLE, CREDENTIAL.USER_ID), customerID,
				QueryConstants.EQUAL);

		try {
			DataObject currentDO = DataAccess.get(CREDENTIAL.TABLE, whereCondition);
			if (currentDO.getFirstRow(CREDENTIAL.TABLE) == null) {
				throw new AppException(APIExceptionMessage.USER_NOT_FOUND);
			}
			if (!SecurityUtil.encryptPasswordSHA256(oldPassword)
					.equals(currentDO.getFirstRow(CREDENTIAL.TABLE).getString(CREDENTIAL.PASSWORD))) {
				throw new AppException(APIExceptionMessage.USER_AUNTHENTICATION_FAILED);
			}
			if (oldPassword.equals(newPassword)) {
				throw new AppException(APIExceptionMessage.SAME_PASSWORD);
			}

			UpdateQuery passwordUpdate = new UpdateQueryImpl(CREDENTIAL.TABLE);
			passwordUpdate.setCriteria(whereCondition);
			passwordUpdate.setUpdateColumn(CREDENTIAL.PASSWORD, SecurityUtil.encryptPasswordSHA256(newPassword));

			DataAccess.update(passwordUpdate);
			return true;
		} catch (DataAccessException e) {
			throw new AppException(APIExceptionMessage.UPDATE_FAILED, e);
		}
	}

	@Override
	public boolean resetPassword(int customerId, String newPassword) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doesEmailExist(String email) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doesEmailBelongToUser(int userId, String email) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Branch getBranchDetails(int branchID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Branch getBranchDetails(Integer branchId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<Long, Account> getAccountsOfUser(int userID) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Account getAccountDetails(long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Account getAccountDetails(Long accountNumber) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Transaction transferAmount(Transaction transaction, boolean isTransferOutsideBank) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber,
			TransactionHistoryLimit timeLimit) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionsOfAccount(long accountNumber, int pageNumber, long startDate, long endDate)
			throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, TransactionHistoryLimit timeLimit) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int numberOfTransactionPages(long accountNumber, long startDate, long endDate) throws AppException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean logOperation(AuditLog auditLog) throws AppException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public APIKey getAPIKey(int akId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public APIKey getAPIKey(String akId) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public APIKey invalidateApiKey(APIKey apiKey) throws AppException {
		// TODO Auto-generated method stub
		return null;
	}

}
