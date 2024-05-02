package com.cskbank.modules;

import com.cskbank.exceptions.AppException;
import com.cskbank.utility.ValidatorUtil;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;

public class AuditLog {
	private int userId;
	private int targetId;
	private LogOperation logOperation;
	private OperationStatus status;
	private String description;
	private long modifiedAt;

	// Setters
	public void setUserId(int userId) throws AppException {
		ValidatorUtil.validateId(userId);
		this.userId = userId;
	}

	public void setTargetId(int targetId) throws AppException {
		ValidatorUtil.validateId(targetId);
		this.targetId = targetId;
	}

	public void setLogOperation(LogOperation logOperation) throws AppException {
		ValidatorUtil.validateObject(logOperation);
		this.logOperation = logOperation;
	}

	public void setOperationStatus(OperationStatus status) throws AppException {
		ValidatorUtil.validateObject(status);
		this.status = status;
	}

	public void setDescription(String description) throws AppException {
		ValidatorUtil.validateObject(description);
		this.description = description;
	}

	public void setModifiedAt(long modifiedAt) {
		this.modifiedAt = modifiedAt;
	}

	public void setModifiedAtWithCurrentTime() {
		this.modifiedAt = System.currentTimeMillis();
	}

	// Getters
	public int getUserId() {
		return this.userId;
	}

	public int getTargetId() {
		if (targetId < 1) {
			return userId;
		}
		return targetId;
	}

	public LogOperation getLogOperation() {
		return logOperation;
	}

	public OperationStatus getOperationStatus() {
		return status;
	}

	public String getDescription() {
		return description;
	}

	public long getModifiedAt() {
		return modifiedAt;
	}
}
