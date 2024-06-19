package com.cskbank.api.mickey;

import com.adventnet.cskbank.CUSTOMER;
import com.adventnet.cskbank.EMPLOYEE;
import com.adventnet.cskbank.USER;
import com.adventnet.persistence.Row;

import com.cskbank.exceptions.AppException;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.Status;

class MickeyConverstionUtil {

	static EmployeeRecord convertToEmployeeRecord(Row employeeRow) throws AppException {
		EmployeeRecord employee = new EmployeeRecord();
		employee.setUserId(employeeRow.getInt(EMPLOYEE.USER_ID));
		employee.setBranchId(employeeRow.getInt(EMPLOYEE.BRANCH_ID));
		return employee;
	}

	static CustomerRecord convertToCustomerRecord(Row customerRow) throws AppException {
		CustomerRecord customer = new CustomerRecord();
		customer.setUserId(customerRow.getInt(CUSTOMER.USER_ID));
		customer.setAadhaarNumber(customerRow.getLong(CUSTOMER.AADHAAR));
		customer.setPanNumber(customerRow.getString(CUSTOMER.PAN));
		return customer;
	}

	static void updateUserRecord(Row userRow, UserRecord user) throws AppException {
		user.setFirstName(userRow.getString(USER.FIRST_NAME));
		user.setLastName(userRow.getString(USER.LAST_NAME));
		user.setDateOfBirth(userRow.getLong(USER.DOB));
		user.setGender(Gender.getGender(userRow.getInt(USER.GENDER)));
		user.setAddress(userRow.getString(USER.ADDRESS));
		user.setPhone(userRow.getLong(USER.PHONE));
		user.setEmail(userRow.getString(USER.EMAIL));
		user.setType(Type.getType(userRow.getInt(USER.TYPE)));
		user.setStatus(Status.getStatus(userRow.getInt(USER.STATUS)));
		user.setCreatedAt(userRow.getLong(USER.CREATED_AT));
		user.setModifiedBy(userRow.getInt(USER.MODIFIED_BY));
		user.setModifiedAt(userRow.getLong(USER.MODIFIED_AT));
	}
//
//	static Account convertToAccount(DataObject aco) throws AppException {
//	}
//
//	static Transaction convertToTransaction(DataObject tdo) throws AppException {
//	}
//
//	static Branch convertToBranch(DataObject bdo) throws AppException {
//	}
//
//	static APIKey convertToAPIKey(DataObject apido) throws AppException {
//	}

}
