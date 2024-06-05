package com.cskbank.api.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.crypto.SecretKey;

import com.cskbank.api.mysql.MySQLQuery.Schemas;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.Account;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.Transaction;
import com.cskbank.modules.UserRecord;
import com.cskbank.modules.UserRecord.Type;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.SecurityUtil;
import com.cskbank.utility.ConstantsUtil;
import com.cskbank.utility.ValidatorUtil;

public class MySQLConversionUtil {

	// CONVERSIONS
	static EmployeeRecord convertToEmployeeRecord(ResultSet record) throws AppException {
		ValidatorUtil.validateObject(record);
		EmployeeRecord employeeRecord = new EmployeeRecord();
		try {
			employeeRecord.setUserId(record.getInt(1));
			employeeRecord.setBranchId(record.getInt(2));
		} catch (SQLException e) {
			throw new AppException(e);
		}
		return employeeRecord;
	}

	static CustomerRecord convertToCustomerRecord(ResultSet record, long createdAt) throws AppException {
		ValidatorUtil.validateObject(record);
		CustomerRecord customerRecord = new CustomerRecord();
		try {
			customerRecord.setUserId(record.getInt(1));

			SecretKey key = SecurityUtil.getSecreteKey(customerRecord.getUserId(), createdAt);

			customerRecord.setAadhaarNumber(
					ConvertorUtil.convertStringToLong(SecurityUtil.decryptCipher(record.getString(2), key)));
			customerRecord.setPanNumber(SecurityUtil.decryptCipher(record.getString(3), key));
		} catch (SQLException e) {
			throw new AppException(e);
		}
		return customerRecord;
	}

	static void updateUserRecord(ResultSet record, long createdAt, UserRecord user) throws AppException {
		ValidatorUtil.validateObject(record);
		ValidatorUtil.validateObject(user);
		try {
			user.setUserId(record.getInt(1));
			SecretKey key = SecurityUtil.getSecreteKey(user.getUserId(), createdAt);

			user.setFirstName(record.getString(2));
			user.setLastName(record.getString(3));
			user.setDateOfBirth(
					ConvertorUtil.convertStringToLong(SecurityUtil.decryptCipher(record.getString(4), key)));
			user.setGender(MySQLAPIUtil.getConstantFromId(Schemas.GENDER, record.getInt(5)));
			user.setAddress(record.getString(6));
			user.setPhone(ConvertorUtil.convertStringToLong(SecurityUtil.decryptCipher(record.getString(7), key)));
			user.setEmail(SecurityUtil.decryptCipher(record.getString(8)));
			user.setType(MySQLAPIUtil.getConstantFromId(Schemas.USER_TYPES, record.getInt(9)));
			user.setStatus(MySQLAPIUtil.getConstantFromId(Schemas.STATUS, record.getInt(10)));
			user.setCreatedAt(record.getLong(11));
			user.setModifiedBy(record.getInt(12));
			user.setModifiedAt(record.getLong(13));
		} catch (SQLException e) {
			throw new AppException(e);
		}
	}

	static Account convertToAccount(ResultSet accountRS) throws AppException {
		ValidatorUtil.validateObject(accountRS);
		Account account = new Account();
		try {
			account.setAccountNumber(accountRS.getLong(1));
			account.setUserId(accountRS.getInt(2));
			account.setType(MySQLAPIUtil.getConstantFromId(Schemas.ACCOUNT_TYPES, accountRS.getInt(3)));
			account.setBranchId(accountRS.getInt(4));
			account.setOpeningDate(accountRS.getLong(5));
			account.setLastTransactedAt(accountRS.getLong(6));
			account.setBalance(accountRS.getDouble(7));
			account.setStatus(MySQLAPIUtil.getConstantFromId(Schemas.STATUS, accountRS.getInt(8)));
			account.setCreatedAt(accountRS.getLong(9));
			account.setModifiedBy(accountRS.getInt(10));
			account.setModifiedAt(accountRS.getLong(11));
		} catch (SQLException e) {
			throw new AppException(e);
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
			throw new AppException(e);
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
			branch.setAccountsCount(branchRS.getLong(6));
			branch.setCreatedAt(branchRS.getLong(7));
			branch.setModifiedBy(branchRS.getInt(8));
			branch.setModifiedAt(branchRS.getLong(9));
		} catch (SQLException e) {
			throw new AppException(e);
		}
		return branch;
	}

	static APIKey convertToAPIKey(ResultSet apiKeyRS) throws AppException {
		ValidatorUtil.validateObject(apiKeyRS);
		APIKey apiKey = new APIKey();
		try {
			apiKey.setAkId(apiKeyRS.getLong(1));
			apiKey.setOrgName(apiKeyRS.getString(2));
			apiKey.setAPIKey(apiKeyRS.getString(3));
			apiKey.setCreatedAt(apiKeyRS.getLong(4));
			apiKey.setValidUntil(apiKeyRS.getLong(5));
			apiKey.setIsActive(apiKeyRS.getBoolean(6));
			apiKey.setModifiedAt(apiKeyRS.getLong(7));
		} catch (SQLException e) {
			throw new AppException(e);
		}
		return apiKey;
	}
}
