package com.cskbank.servlet;

import com.cskbank.exceptions.AppException;
import com.cskbank.handlers.AdminHandler;
import com.cskbank.handlers.AuditHandler;
import com.cskbank.handlers.CommonHandler;
import com.cskbank.handlers.CustomerHandler;
import com.cskbank.handlers.EmployeeHandler;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;

public class HandlerObject {
	public static CommonHandler commonHandler;
	static AuditHandler auditHandler;

	static EmployeeHandler employeeHandler;
	static CustomerHandler customerHandler;
	static AdminHandler adminHandler;

	public static synchronized void initialize(PersistanceIdentifier persistanceIdentifier) throws AppException {
		commonHandler = new CommonHandler(persistanceIdentifier);
		employeeHandler = new EmployeeHandler(persistanceIdentifier);
		customerHandler = new CustomerHandler(persistanceIdentifier);
		adminHandler = new AdminHandler(persistanceIdentifier);
		auditHandler = new AuditHandler(commonHandler.getUserAPI());
	}
}
