package servlet;

import cache.CachePool;
import cache.CachePool.CacheIdentifier;
import exceptions.AppException;
import handlers.AdminHandler;
import handlers.AuditHandler;
import handlers.CommonHandler;
import handlers.CustomerHandler;
import handlers.EmployeeHandler;
import utility.ConstantsUtil.PersistanceIdentifier;

public class ServletInit {
	static CommonHandler appOperations;
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

		auditLogService = new AuditHandler(appOperations.getUserAPI());
		CachePool.initializeCache(appOperations.getUserAPI(), CacheIdentifier.Redis);
	}
}
