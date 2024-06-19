package com.cskbank.modules;

import java.io.Serializable;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.ValidatorUtil;

public class Branch implements Serializable {

	private int branchId;
	private String address;
	private long phone;
	private String email;
	private String ifscCode;
	private long accountsCount;
	private int modifiedBy;
	private long createdAt;
	private long modifiedAt;

	public Branch() {
	}

	// setters

	public void setBrachId(int branchId) throws AppException {
		ValidatorUtil.validatePositiveNumber(branchId);
		this.branchId = branchId;
	}

	public void setAddress(String address) throws AppException {
		ValidatorUtil.validateObject(address);
		this.address = address;
	}

	public void setPhone(long phone) throws AppException {
		ValidatorUtil.validateMobileNumber(phone);
		this.phone = phone;
	}

	public void setEmail(String email) throws AppException {
		ValidatorUtil.validateEmail(email);
		this.email = email;
	}

	public void setIfscCode(String ifscCode) throws AppException {
		ValidatorUtil.validateObject(ifscCode);
		this.ifscCode = ifscCode;
	}

	public void setAccountsCount(long accountsCount) throws AppException {
		ValidatorUtil.validatePositiveNumber(accountsCount);
		this.accountsCount = accountsCount;
	}

	public void setCreatedAt(long dateTime) {
		this.createdAt = dateTime;
	}

	public void setModifiedBy(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		this.modifiedBy = userId;
	}

	public void setModifiedAt(Long dateTime) {
		this.modifiedAt = dateTime == null ? 0 : dateTime;
	}

	// getters

	public int getBranchId() {
		return this.branchId;
	}

	public long getPhone() {
		return this.phone;
	}

	public String getAddress() {
		return this.address;
	}

	public String getEmail() {
		return this.email;
	}

	public String getIfscCode() {
		return this.ifscCode;
	}

	public long getAccountsCount() {
		return this.accountsCount;
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
