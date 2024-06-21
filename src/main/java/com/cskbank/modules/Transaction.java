package com.cskbank.modules;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.TransactionType;

public class Transaction {

	private long transactionId;
	private int userId;
	private long viewerAccountNumber;
	private long transactedAccountNumber;
	private TransactionType transactionType;
	private double transactionAmount;
	private double closingBalance;
	private long timeStamp;
	private String remarks;
	private int modifiedBy;
	private long createdAt;
	private long modifiedAt;
	private boolean transferWithinBank = false;

	public Transaction() throws AppException {
	}

	// Setters

	public void setTransactionId(long transactionId) throws AppException {
		ValidatorUtil.validatePositiveNumber(transactionId);
		this.transactionId = transactionId;
	}

	public void setUserId(int userId) throws AppException {
		ValidatorUtil.validatePositiveNumber(userId);
		this.userId = userId;
	}

	public void setViewerAccountNumber(long viewerAccountNumber) throws AppException {
		ValidatorUtil.validatePositiveNumber(viewerAccountNumber);
		this.viewerAccountNumber = viewerAccountNumber;
	}

	public void setTransactedAccountNumber(long transactedAccountNumber) throws AppException {
		ValidatorUtil.validatePositiveNumber(transactedAccountNumber);
		this.transactedAccountNumber = transactedAccountNumber;
	}

	public void setTransactionType(int transactionTypeId) throws AppException {
		this.transactionType = TransactionType.getTransactionType(transactionTypeId);
	}

	public void setTransactedAmount(double amount) {
		this.transactionAmount = amount;
	}

	public void setClosingBalance(double closingBalance) {
		this.closingBalance = closingBalance;
	}

	public void setTimeStamp(long timeStamp) {
		this.timeStamp = timeStamp;
	}

	public void setRemarks(String remarks) throws AppException {
		ValidatorUtil.validateObject(remarks);
		this.remarks = remarks;
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

	public void setTransferWithinBank() {
		this.transferWithinBank = true;
	}

	public void setTransferOutsideBank() {
		this.transferWithinBank = false;
	}

	// Getters

	public long getTransactionId() {
		return this.transactionId;
	}

	public int getUserId() {
		return this.userId;
	}

	public long getViewerAccountNumber() {
		return this.viewerAccountNumber;
	}

	public long getTransactedAccountNumber() {
		return this.transactedAccountNumber;
	}

	public TransactionType getTransactionType() {
		return this.transactionType;
	}

	public double getTransactedAmount() {
		return this.transactionAmount;
	}

	public double getClosingBalance() {
		return this.closingBalance;
	}

	public long getTimeStamp() {
		return this.timeStamp;
	}

	public String getRemarks() {
		return this.remarks;
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

	public boolean getTransferWithinBank() {
		return this.transferWithinBank;
	}
}
