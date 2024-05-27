package com.cskbank.servlet;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.cache.CachePool;
import com.cskbank.exceptions.AppException;
import com.cskbank.exceptions.messages.APIExceptionMessage;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.APIKey;
import com.cskbank.modules.AuditLog;
import com.cskbank.modules.Branch;
import com.cskbank.modules.CustomerRecord;
import com.cskbank.modules.EmployeeRecord;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.ConvertorUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ConstantsUtil.Gender;
import com.cskbank.utility.ConstantsUtil.LogOperation;
import com.cskbank.utility.ConstantsUtil.OperationStatus;
import com.cskbank.utility.ConstantsUtil.Status;

class AdminServletHelper {

	public void accountsRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		int pageCount = Services.adminOperations.getPageCountOfAccountsInBank();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("accounts", Services.adminOperations.viewAccountsInBank(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/accounts.jsp").forward(request, response);
	}

	public void branchesRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		int pageCount = Services.adminOperations.getPageCountOfBranches();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("branches", Services.adminOperations.viewBrachesInBank(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/branches.jsp").forward(request, response);
	}

	public void employeesRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		int pageCount = Services.adminOperations.getPageCountOfEmployees();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("employees", Services.adminOperations.getEmployees(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("branch", Services.adminOperations.getBranch(admin.getBranchId()));
		request.getRequestDispatcher("/WEB-INF/jsp/admin/employees.jsp").forward(request, response);
	}

	public void employeeDetailsPostMethod(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		int employeeId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		request.setAttribute("employee", Services.adminOperations.getEmployeeDetails(employeeId));
		request.getRequestDispatcher("/WEB-INF/jsp/admin/employee_details.jsp").forward(request, response);

		// Log
		AuditLog log = new AuditLog();
		log.setUserId(admin.getUserId());
		log.setTargetId(employeeId);
		log.setLogOperation(LogOperation.VIEW_EMPLOYEE);
		log.setOperationStatus(OperationStatus.SUCCESS);
		log.setDescription(
				"Employee details (ID : " + employeeId + ") was viewed by Admin (ID :  " + admin.getUserId() + ")");
		log.setModifiedAtWithCurrentTime();
		Services.auditLogService.log(log);
	}

	public boolean searchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		String searchBy = request.getParameter(Parameters.SEARCHBY.parameterName());
		String searchValue = request.getParameter(Parameters.SEARCHVALUE.parameterName());
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);

		try {
			if (searchBy.equals("employeeId")) {
				int userId = ConvertorUtil.convertStringToInteger(searchValue);
				request.setAttribute("employee", (EmployeeRecord) Services.adminOperations.getEmployeeDetails(userId));
				request.getRequestDispatcher("/WEB-INF/jsp/admin/employee_details.jsp").forward(request, response);

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(admin.getUserId());
				log.setTargetId(userId);
				log.setLogOperation(LogOperation.VIEW_EMPLOYEE);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Employee details (ID : " + userId + ") was searched and viewed by Admin (ID :  "
						+ admin.getUserId() + ")");
				log.setModifiedAtWithCurrentTime();
				Services.auditLogService.log(log);

			} else if (searchBy.equals("branchId")) {
				int branchId = ConvertorUtil.convertStringToInteger(searchValue);
				request.setAttribute("branch", Services.adminOperations.getBranch(branchId));
				request.getRequestDispatcher("/WEB-INF/jsp/admin/branch_details.jsp").forward(request, response);

				// Log
				AuditLog log = new AuditLog();
				log.setUserId(admin.getUserId());
				log.setLogOperation(LogOperation.VIEW_BRANCH);
				log.setOperationStatus(OperationStatus.SUCCESS);
				log.setDescription("Branch details (ID : " + branchId + ") was searched and viewed by Admin (ID :  "
						+ admin.getUserId() + ")");
				log.setModifiedAtWithCurrentTime();
				Services.auditLogService.log(log);

			} else {
				return false;
			}
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("search");
		}
		return true;
	}

	public void authorizeAddEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		try {
			EmployeeRecord employee = new EmployeeRecord();
			employee.setFirstName(request.getParameter(Parameters.FIRSTNAME.parameterName()));
			employee.setLastName(request.getParameter(Parameters.LASTNAME.parameterName()));
			employee.setDateOfBirth(
					ConvertorUtil.dateStringToMillis(request.getParameter(Parameters.DATEOFBIRTH.parameterName())));
			employee.setGender(
					ConvertorUtil.convertToEnum(Gender.class, request.getParameter(Parameters.GENDER.parameterName())));
			employee.setAddress(request.getParameter(Parameters.ADDRESS.parameterName()));
			employee.setPhone(
					ConvertorUtil.convertStringToLong(request.getParameter(Parameters.PHONE.parameterName())));
			employee.setEmail(request.getParameter(Parameters.EMAIL.parameterName()));
			employee.setType(request.getParameter(Parameters.ROLE.parameterName()));
			employee.setBranchId(
					ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.BRANCHID.parameterName())));
			ServletUtil.session(request).setAttribute("employee", employee);
			ServletUtil.session(request).setAttribute("redirect", "process_add_employee");
			response.sendRedirect("authorization");
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("employees");
		}
	}

	public void processAddEmployeePostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());
		try {
			EmployeeRecord employee = ServletUtil.getSessionObject(request, "employee");
			Services.adminOperations.createEmployee(employee, admin.getUserId(), pin);

			request.setAttribute("message", "New employee has been created<br>Employee ID : " + employee.getUserId());
			request.setAttribute("status", true);

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setTargetId(employee.getUserId());
			log.setLogOperation(LogOperation.CREATE_EMPLOYEE);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Employee (ID : " + employee.getUserId() + ") was created by Admin (ID : "
					+ admin.getUserId() + ")");
			log.setModifiedAt(employee.getCreatedAt());
			Services.auditLogService.log(log);

		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setLogOperation(LogOperation.CREATE_EMPLOYEE);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Employee creation failed [Admin ID : " + admin.getUserId() + "] - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			Services.auditLogService.log(log);
		}
		request.setAttribute("redirect", "employees");
		request.setAttribute("operation", "add_employee");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void authorizeAddBranch(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		try {
			Branch branch = new Branch();
			branch.setAddress(request.getParameter(Parameters.ADDRESS.parameterName()));
			branch.setPhone(ConvertorUtil.convertStringToLong(request.getParameter(Parameters.PHONE.parameterName())));
			branch.setEmail(request.getParameter(Parameters.EMAIL.parameterName()));

			ServletUtil.session(request).setAttribute("branch", branch);
			ServletUtil.session(request).setAttribute("redirect", "process_add_branch");
			response.sendRedirect("authorization");
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("branches");
		}
	}

	public void processAddBranchPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		String pin = request.getParameter(Parameters.PIN.parameterName());
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);

		try {
			Branch branch = ServletUtil.getSessionObject(request, "branch");
			branch = Services.adminOperations.createBranch(branch, admin.getUserId(), pin);

			request.setAttribute("message",
					"New Branch Record has been created<br>Branch ID : " + branch.getBranchId());
			request.setAttribute("status", true);

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setLogOperation(LogOperation.CREATE_BRANCH);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("New Branch (ID : " + branch.getBranchId() + ") was created by Admin (ID : "
					+ admin.getUserId() + ")");
			log.setModifiedAt(branch.getCreatedAt());
			Services.auditLogService.log(log);

		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setLogOperation(LogOperation.CREATE_BRANCH);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Branch creation failed [Admin ID : " + admin.getUserId() + "] - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			Services.auditLogService.log(log);
		}
		request.setAttribute("redirect", "branches");
		request.setAttribute("operation", "add_branch");
		request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
	}

	public void apiServiceRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		int pageCount = Services.adminOperations.getPageCountOfAPIKeys();
		int currentPage = 1;
		if (request.getMethod().equals("POST")) {
			currentPage = ConvertorUtil
					.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		}
		request.setAttribute("apiKeys", Services.adminOperations.getListofApiKeys(currentPage));
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageCount", pageCount);
		request.getRequestDispatcher("/WEB-INF/jsp/admin/api_service.jsp").forward(request, response);
	}

	public void createAPIKeyPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		String orgName = request.getParameter(Parameters.ORGNAME.parameterName());
		APIKey apikey = Services.adminOperations.generateAPIKey(orgName);
		ServletUtil.session(request).setAttribute("error", "API Key generated<br>API Key ID : " + apikey.getAkId());

		// Log
		AuditLog log = new AuditLog();
		log.setUserId(admin.getUserId());
		log.setLogOperation(LogOperation.CREATE_BRANCH);
		log.setOperationStatus(OperationStatus.SUCCESS);
		log.setDescription("API Key (AK ID : " + apikey.getAkId() + ") was created for orgranisation : "
				+ apikey.getOrgName() + " by Admin [Admin ID : " + admin.getUserId() + "]");
		log.setModifiedAt(apikey.getCreatedAt());
		Services.auditLogService.log(log);

		response.sendRedirect("api_service");
	}

	public void invalidateAPIKeyPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, AppException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		int akId = Integer.parseInt(request.getParameter(Parameters.AKID.parameterName()));
		try {
			APIKey key = Services.adminOperations.invalidateAPIKey(akId);
			// Log
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setLogOperation(LogOperation.INVALIDATE_API_KEY);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(
					"API Key (AK ID : " + akId + ") was invalidated  by Admin [Admin ID : " + admin.getUserId() + "]");
			log.setModifiedAt(key.getModifiedAt());
			Services.auditLogService.log(log);
		} catch (AppException e) {
			request.getSession(false).setAttribute("error", e.getMessage());
		}
		response.sendRedirect("api_service");
	}

	public void authorizeChangeStatus(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		int userId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		Status status = ConvertorUtil.convertToEnum(Status.class,
				(request.getParameter(Parameters.STATUS.parameterName())));
		String reason = request.getParameter(Parameters.REASON.parameterName());

		if (Services.employeeOperations.getCustomerRecord(userId).getStatus() == status) {
			throw new AppException(APIExceptionMessage.USER_STATUS_UNCHANGED);
		}

		ServletUtil.session(request).setAttribute("status", status);
		ServletUtil.session(request).setAttribute("reason", reason);
		ServletUtil.session(request).setAttribute("userId", userId);
		ServletUtil.session(request).setAttribute("redirect", "process_change_status");
		response.sendRedirect("authorization");
	}

	public void processChangeStatus(HttpServletRequest request, HttpServletResponse response)
			throws AppException, IOException, ServletException {
		EmployeeRecord admin = (EmployeeRecord) ServletUtil.getUser(request);
		String pin = request.getParameter(Parameters.PIN.parameterName());

		Status status = ServletUtil.getSessionObject(request, "status");
		String reason = ServletUtil.getSessionObject(request, "reason");
		int userId = ServletUtil.getSessionObject(request, "userId");

		try {
			UserRecord user = Services.adminOperations.changeUserStatus(userId, status, reason, admin.getUserId(), pin);
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setTargetId(userId);
			log.setLogOperation(LogOperation.USER_STATUS_CHANGE);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription("Admin(ID : " + admin.getUserId() + ") has changed User(ID : " + user.getUserId()
					+ ") status to " + status + ", Reason - " + reason);
			log.setModifiedAt(user.getModifiedAt());
			Services.auditLogService.log(log);
			ServletUtil.session(request).setAttribute("error", "Status changed successfully");
		} catch (AppException e) {
			AuditLog log = new AuditLog();
			log.setUserId(admin.getUserId());
			log.setTargetId(userId);
			log.setLogOperation(LogOperation.USER_STATUS_CHANGE);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Admin(ID : " + admin.getUserId() + ") failed to changed User(ID : " + userId
					+ ") status to " + status + ", Reason - " + reason);
			log.setModifiedAt(System.currentTimeMillis());
			Services.auditLogService.log(log);
			ServletUtil.session(request).setAttribute("error", e.getMessage());
		}
		response.sendRedirect("search");
	}
}
