package com.cskbank.servlet;

import com.cskbank.exceptions.AppException;
import com.cskbank.handlers.AdminHandler;
import com.cskbank.handlers.AuditHandler;
import com.cskbank.handlers.CommonHandler;
import com.cskbank.handlers.CustomerHandler;
import com.cskbank.handlers.EmployeeHandler;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;
import com.cskbank.utility.ValidatorUtil;

public class HandlerObject {
	private static CommonHandler commonHandler;

	private static AuditHandler auditHandler;
	private static EmployeeHandler employeeHandler;
	private static CustomerHandler customerHandler;
	private static AdminHandler adminHandler;

	private static boolean objectsInitialized = false;

	public static synchronized void initialize(PersistanceIdentifier persistanceIdentifier) throws AppException {
		if (!objectsInitialized) {
			commonHandler = new CommonHandler(persistanceIdentifier);
			employeeHandler = new EmployeeHandler(persistanceIdentifier);
			customerHandler = new CustomerHandler(persistanceIdentifier);
			adminHandler = new AdminHandler(persistanceIdentifier);
			auditHandler = new AuditHandler(commonHandler.getUserAPI());

			objectsInitialized = true;
		}
	}

	public static CommonHandler getCommonHandler() throws AppException {
		ValidatorUtil.validateObject(commonHandler);
		return commonHandler;
	}

	public static CustomerHandler getCustomerHandler() throws AppException {
		ValidatorUtil.validateObject(customerHandler);
		return customerHandler;
	}

	public static EmployeeHandler getEmployeeHandler() throws AppException {
		ValidatorUtil.validateObject(employeeHandler);
		return employeeHandler;
	}

	public static AdminHandler getAdminHandler() throws AppException {
		ValidatorUtil.validateObject(adminHandler);
		return adminHandler;
	}

	public static AuditHandler getAuditHandler() throws AppException {
		ValidatorUtil.validateObject(auditHandler);
		return auditHandler;
	}

}
