package api.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;

import exceptions.AppException;
import modules.Account;
import modules.Branch;
import modules.CustomerRecord;
import modules.EmployeeRecord;
import modules.Transaction;
import modules.UserRecord;
import utility.ValidatorUtil;

class MySQLConversionUtil {

	// CONVERSIONS
	static EmployeeRecord convertToEmployeeRecord(ResultSet record) throws AppException {
		ValidatorUtil.validateObject(record);
		EmployeeRecord employeeRecord = new EmployeeRecord();
		try {
			employeeRecord.setUserId(record.getInt(1));
			employeeRecord.setBranchId(record.getInt(2));
		} catch (SQLException e) {
		}
		return employeeRecord;
	}

	static CustomerRecord convertToCustomerRecord(ResultSet record) throws AppException {
		ValidatorUtil.validateObject(record);
		CustomerRecord customerRecord = new CustomerRecord();
		try {
			customerRecord.setUserId(record.getInt(1));
			customerRecord.setAadhaarNumber(record.getLong(2));
			customerRecord.setPanNumber(record.getString(3));
		} catch (SQLException e) {
		}
		return customerRecord;
	}

	static void updateUserRecord(ResultSet record, UserRecord user) throws AppException {
		ValidatorUtil.validateObject(record);
		ValidatorUtil.validateObject(user);
		try {
			user.setUserId(record.getInt(1));
			user.setFirstName(record.getString(2));
			user.setLastName(record.getString(3));
			user.setDateOfBirth(record.getLong(4));
			user.setGender(Integer.parseInt(record.getString(5)));
			user.setAddress(record.getString(6));
			user.setPhone(record.getLong(7));
			user.setEmail(record.getString(8));
			user.setType(Integer.parseInt(record.getString(9)));
			user.setCreatedAt(record.getLong(10));
			user.setModifiedBy(record.getInt(11));
			user.setModifiedAt(record.getLong(12));
		} catch (SQLException e) {
		}
	}

	static Account convertToAccount(ResultSet accountRS) throws AppException {
		ValidatorUtil.validateObject(accountRS);
		Account account = new Account();
		try {
			account.setAccountNumber(accountRS.getLong(1));
			account.setUserId(accountRS.getInt(2));
			account.setType(Integer.parseInt(accountRS.getString(3)));
			account.setBranchId(accountRS.getInt(4));
			account.setOpeningDate(accountRS.getLong(5));
			account.setLastTransactedAt(accountRS.getLong(6));
			account.setBalance(accountRS.getDouble(7));
			account.setStatus(Integer.parseInt(accountRS.getString(8)));
			account.setCreatedAt(accountRS.getLong(9));
			account.setModifiedBy(accountRS.getInt(10));
			account.setModifiedAt(accountRS.getLong(11));
		} catch (SQLException e) {
		}
		return account;
	}

	static Transaction convertToTransaction(ResultSet transactionRS) throws AppException {
		ValidatorUtil.validateObject(transactionRS);
		Transaction transaction = null;
		try {
			transaction = new Transaction();
			transaction.setTransactionId(transactionRS.getLong(1));
			transaction.setUserId(transactionRS.getInt(2));
			transaction.setViewerAccountNumber(transactionRS.getLong(3));
			transaction.setTransactedAccountNumber(transactionRS.getLong(4));
			transaction.setTransactedAmount(transactionRS.getDouble(5));
			transaction.setTransactionType(Integer.parseInt(transactionRS.getString(6)));
			transaction.setClosingBalance(transactionRS.getDouble(7));
			transaction.setTimeStamp(transactionRS.getLong(8));
			transaction.setRemarks(transactionRS.getString(9));
			transaction.setCreatedAt(transactionRS.getLong(10));
			transaction.setModifiedBy(transactionRS.getInt(11));
			transaction.setModifiedAt(transactionRS.getLong(12));
		} catch (SQLException e) {
		}
		return transaction;
	}

	static Branch convertToBranch(ResultSet branchRS) throws AppException {
		ValidatorUtil.validateObject(branchRS);
		Branch branch = new Branch();
		try {
			branch.setBrachId(branchRS.getInt(1));
			branch.setAddress(branchRS.getString(2));
			branch.setPhone(branchRS.getLong(3));
			branch.setEmail(branchRS.getString(4));
			branch.setIfscCode(branchRS.getString(5));
			branch.setCreatedAt(branchRS.getLong(6));
			branch.setModifiedBy(branchRS.getInt(7));
			branch.setModifiedAt(branchRS.getLong(8));
		} catch (SQLException e) {
		}
		return branch;
	}
}
