package com.cskbank.modules;

@SuppressWarnings("serial")
public class EmployeeRecord extends UserRecord {
	private int branchId;

	public EmployeeRecord() {
	}

	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}

	public int getBranchId() {
		return branchId;
	}
}
