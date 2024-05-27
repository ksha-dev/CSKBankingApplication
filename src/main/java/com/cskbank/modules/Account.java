package com.cskbank.modules;

import java.io.Serializable;
import java.time.LocalDate;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.ConstantsUtil.Status;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ValidatorUtil;

public class Account implements Serializable {

	public static enum AccountType {
		SAVINGS, CURRENT, SALARY;

		public static AccountType convertStringToEnum(String label) throws AppException {
			try {
				return valueOf(label);
			} catch (IllegalArgumentException e) {
				throw new AppException("Invalid Identifier Obtained");
			}
		}
	}

	private long accountNumber;
	private int userId;
	private int branchId;
	private Account.AccountType type;
	private long openingDate;
	private long lastTransactionAt;
	private double balance;
	private Status status;
	private int modifiedBy;
	private long createdAt;
	private long modifiedAt;

	public Account() {
	}

	// Setters

	public void setAccountNumber(long accoutNumber) throws AppException {
		ValidatorUtil.validatePositiveNumber(accoutNumber);
		this.accountNumber = accoutNumber;
	}

	public void setUserId(int userId) throws AppException {
		ValidatorUtil.validatePositiveNumber(userId);
		this.userId = userId;
	}

	public void setBranchId(int branchId) throws AppException {
		ValidatorUtil.validatePositiveNumber(branchId);
		this.branchId = branchId;
	}

	public void setOpeningDate(long openingDate) throws AppException {
		ValidatorUtil.validatePositiveNumber(openingDate);
		this.openingDate = openingDate;
	}

	public void setLastTransactedAt(long lastTransactionDateTime) throws AppException {
		ValidatorUtil.validatePositiveNumber(lastTransactionDateTime);
		this.lastTransactionAt = lastTransactionDateTime;
	}

	public void setStatus(String status) throws AppException {
		this.status = ConvertorUtil.convertToEnum(Status.class, status);
	}

	public void setStatus(Status status) throws AppException {
		ValidatorUtil.validateObject(status);
		this.status = status;
	}

	public void setType(String type) throws AppException {
		this.type = ConvertorUtil.convertToEnum(AccountType.class, type);
	}

	public void setType(AccountType type) throws AppException {
		ValidatorUtil.validateObject(type);
		this.type = type;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public void setCreatedAt(long dateTime) {
		this.createdAt = dateTime;
	}

	public void setModifiedBy(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		this.modifiedBy = userId;
	}

	public void setModifiedAt(long dateTime) {
		this.modifiedAt = dateTime;
	}

	// Getters

	public long getAccountNumber() {
		return this.accountNumber;
	}

	public int getUserId() {
		return this.userId;
	}

	public int getBranchId() {
		return this.branchId;
	}

	public Account.AccountType getAccountType() {
		return this.type;
	}

	public Status getStatus() {
		return this.status;
	}

	public long getOpeningDate() {
		return this.openingDate;
	}

	public long getLastTransactedAt() {
		return this.lastTransactionAt;
	}

	public LocalDate getOpeningDateInLocalDateTime() {
		return ConvertorUtil.convertLongToLocalDate(this.openingDate);
	}

	public double getBalance() {
		return this.balance;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public long getCreatedAt() {
		return this.createdAt;
	}

	public long getModifiedAt() {
		return this.modifiedAt;
	}
}
