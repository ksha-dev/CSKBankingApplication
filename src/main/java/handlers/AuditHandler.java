package handlers;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import api.UserAPI;
import exceptions.AppException;
import modules.AuditLog;
import utility.ValidatorUtil;

public class AuditHandler {

	private ExecutorService auditLogExecutor;
	private UserAPI api;

	public AuditHandler(UserAPI api) throws AppException {
		ValidatorUtil.validateObject(api);
		this.api = api;
		auditLogExecutor = Executors.newFixedThreadPool(3);
		auditLogExecutor = new ThreadPoolExecutor(0, Integer.MAX_VALUE, 60L, TimeUnit.SECONDS,
				new LinkedBlockingQueue<Runnable>());
	}

	public void log(AuditLog auditLog) throws AppException {
		ValidatorUtil.validateObject(auditLog);
		ValidatorUtil.validateId(auditLog.getUserId());
		ValidatorUtil.validateObject(auditLog.getLogOperation());
		ValidatorUtil.validateObject(auditLog.getOperationStatus());
		ValidatorUtil.validateObject(auditLog.getDescription());

		auditLogExecutor.execute(auditRunnable(auditLog));

	}

	private Runnable auditRunnable(AuditLog auditLog) {
		return new Runnable() {
			@Override
			public void run() {
				try {
					api.logOperation(auditLog);
				} catch (AppException e) {
				}
			}
		};
	}
}
