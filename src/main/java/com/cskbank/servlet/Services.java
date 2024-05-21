package com.cskbank.servlet;

import com.cskbank.cache.CachePool;
import com.cskbank.cache.CachePool.CacheIdentifier;
import com.cskbank.exceptions.AppException;
import com.cskbank.handlers.AdminHandler;
import com.cskbank.handlers.AuditHandler;
import com.cskbank.handlers.CommonHandler;
import com.cskbank.handlers.CustomerHandler;
import com.cskbank.handlers.EmployeeHandler;
import com.cskbank.mail.OTPDatabase;
import com.cskbank.utility.ConstantsUtil.PersistanceIdentifier;

public class Services {
	public static CommonHandler appOperations;
	public static OTPDatabase otpDatabase;
	public static AuditHandler auditLogService;

	static EmployeeHandler employeeOperations;
	static CustomerHandler customerOperations;
	static AdminHandler adminOperations;

	private static final PersistanceIdentifier PERSISTANT_OBJECT = PersistanceIdentifier.MySQL;

	public static synchronized void initialize() throws AppException {
		if (appOperations == null)
			appOperations = new CommonHandler(PERSISTANT_OBJECT);
		if (employeeOperations == null)
			employeeOperations = new EmployeeHandler(PERSISTANT_OBJECT);
		if (customerOperations == null)
			customerOperations = new CustomerHandler(PERSISTANT_OBJECT);
		if (adminOperations == null)
			adminOperations = new AdminHandler(PERSISTANT_OBJECT);
		if (otpDatabase == null)
			otpDatabase = new OTPDatabase();
		if (auditLogService == null)
			auditLogService = new AuditHandler(appOperations.getUserAPI());
		CachePool.initializeCache(appOperations.getUserAPI(), CacheIdentifier.Redis);
	}
}
