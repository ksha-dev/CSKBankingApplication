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

	static EmployeeHandler employeeOperations;
	static CustomerHandler customerOperations;
	static AdminHandler adminOperations;
	static AuditHandler auditLogService;

	private static final PersistanceIdentifier PERSISTANT_OBJECT = PersistanceIdentifier.MySQL;

	public static void initialize() throws AppException {
		appOperations = new CommonHandler(PERSISTANT_OBJECT);
		employeeOperations = new EmployeeHandler(PERSISTANT_OBJECT);
		customerOperations = new CustomerHandler(PERSISTANT_OBJECT);
		adminOperations = new AdminHandler(PERSISTANT_OBJECT);
		otpDatabase = new OTPDatabase();

		auditLogService = new AuditHandler(appOperations.getUserAPI());
		CachePool.initializeCache(appOperations.getUserAPI(), CacheIdentifier.Redis);
	}
}
