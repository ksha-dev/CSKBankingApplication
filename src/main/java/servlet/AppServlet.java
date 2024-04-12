package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cache.CachePool;
import exceptions.AppException;
import filters.Parameters;
import handlers.AdminHandler;
import handlers.AuditHandler;
import handlers.CommonHandler;
import handlers.CustomerHandler;
import handlers.EmployeeHandler;
import utility.ConstantsUtil.PersistanceIdentifier;
import utility.ConstantsUtil.UserType;
import utility.ServletUtil;

public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final PersistanceIdentifier PERSISTANT_OBJECT = PersistanceIdentifier.MySQL;

	static CommonHandler appOperations;
	static EmployeeHandler employeeOperations;
	static CustomerHandler customerOperations;
	static AdminHandler adminOperations;
	static AuditHandler auditLogService;

	public AppServlet() throws AppException {
		appOperations = new CommonHandler(PERSISTANT_OBJECT);
		employeeOperations = new EmployeeHandler(PERSISTANT_OBJECT);
		customerOperations = new CustomerHandler(PERSISTANT_OBJECT);
		adminOperations = new AdminHandler(PERSISTANT_OBJECT);

		auditLogService = new AuditHandler(appOperations.getUserAPI());
		CachePool.initializeCache(appOperations.getUserAPI());
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
		System.out.println(path);
		try {
			if (path.startsWith("/customer/")) {
				customerPostController(request, response, path.replace("/customer/", ""));
			} else if (path.startsWith("/employee/")) {
				path = path.replace("/employee/", "");
				employeePostController(request, response, path);
			} else if (path.startsWith("/admin/")) {
				path = path.replace("/admin/", "");
				if (!adminPostController(request, response, path)) {
					employeePostController(request, response, path);
				}
			} else if (path.equals("/customer") || path.equals("/employee") || path.equals("/admin")) {
				homeRedirect(response, ServletUtil.getUser(request).getType());
			} else if (path.equals("/login")) {
				new CommonServletHelper().loginPostRequest(request, response);
			} else {
				request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			}
		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "history.back()");
			request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
		System.out.println(path);
		try {
			if (path.contains("/logout")) {
				request.getSession().invalidate();
				response.sendRedirect(request.getContextPath() + "/app/login");
			} else if (path.contains("/home")) {
				homeRedirect(response, ServletUtil.getUser(request).getType());
			} else if (path.startsWith("/customer/")) {
				path = path.replace("/customer/", "");
				customerGetController(request, response, path);
			} else if (path.startsWith("/employee/")) {
				path = path.replace("/employee/", "");
				employeeGetController(request, response, path);
			} else if (path.startsWith("/admin/")) {
				path = path.replace("/admin/", "");
				if (!adminGetController(request, response, path)) {
					employeeGetController(request, response, path);
				}
			} else if (path.equals("/customer") || path.equals("/employee") || path.equals("/admin")) {
				homeRedirect(response, ServletUtil.getUser(request).getType());
			} else {
				request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			}

		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "history.back()");
			request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp").forward(request, response);
		}
	}

	private void homeRedirect(HttpServletResponse response, UserType userType) throws IOException {
		switch (userType) {
		case CUSTOMER:
			response.sendRedirect("account");
			break;

		case EMPLOYEE:
			response.sendRedirect("branch_accounts");
			break;

		case ADMIN:
			response.sendRedirect("employees");
			break;
		}
	}

	private void customerGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CustomerServletHelper customerMethods = new CustomerServletHelper();

		switch (path) {
		case "home":
			response.sendRedirect("account");
			break;

		case "account":
			customerMethods.accountsGetRequest(request, response, "customer/accounts");
			break;

		case "account_details":
			customerMethods.accountDetailsGetRequest(request, response);
			break;

		case "statement":
			customerMethods.accountsGetRequest(request, response, "common/statement_select");
			break;

		case "transfer":
			customerMethods.accountsGetRequest(request, response, "customer/transfer");
			break;

		case "change_password":
			request.getRequestDispatcher("/WEB-INF/jsp/common/change_password.jsp").forward(request, response);
			break;

		case "profile":
			request.getRequestDispatcher("/WEB-INF/jsp/customer/profile.jsp").forward(request, response);
			break;

		case "profile_edit":
			request.getRequestDispatcher("/WEB-INF/jsp/customer/profile_edit.jsp").forward(request, response);
			break;

		default:
			request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			break;
		}
	}

	private void customerPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		CommonServletHelper commonMethods = new CommonServletHelper();
		CustomerServletHelper customerMethods = new CustomerServletHelper();

		switch (path) {
		case "statement":
			commonMethods.statementPostRequest(request, response);
			break;

		case "authorization": {
			String operation = request.getParameter(Parameters.OPERATION.parameterName());
			switch (operation) {
			case "authorize_transaction":
				customerMethods.authorizeTransactionPostRequest(request, response);
				break;

			case "process_transaction":
				customerMethods.processTransactionPostRequest(request, response);
				break;

			case "authorize_change_password":
				commonMethods.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonMethods.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_profile_update":
				customerMethods.authorizeProfileUpdatePostRequest(request, response);
				break;

			case "process_profile_update":
				customerMethods.processProfileUpdatePostRequest(request, response);
				break;

			default:
				request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
				break;
			}
		}
			break;

		default:
			request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			break;
		}
	}

	private void employeeGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		EmployeeServletHelper employeeMethods = new EmployeeServletHelper();
		switch (path) {
		case "home":
			response.sendRedirect("branch_accounts");
			break;

		case "branch_accounts":
			employeeMethods.branchAccountsRequest(request, response);
			break;

		case "account_details":
			employeeMethods.accountDetailsGetRequest(request, response);
			break;

		case "statement":
			employeeMethods.statementGetRequest(request, response);
			break;

		case "open_account":
			request.getRequestDispatcher("/WEB-INF/jsp/employee/open_account.jsp").forward(request, response);
			break;

		case "transaction":
			request.getRequestDispatcher("/WEB-INF/jsp/employee/transaction.jsp").forward(request, response);
			break;

		case "change_password":
			request.getRequestDispatcher("/WEB-INF/jsp/common/change_password.jsp").forward(request, response);
			break;

		case "profile":
			request.getRequestDispatcher("/WEB-INF/jsp/employee/profile.jsp").forward(request, response);
			break;

		case "search":
			request.getRequestDispatcher("/WEB-INF/jsp/employee/search.jsp").forward(request, response);
			break;

		default:
			request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			break;
		}
	}

	private void employeePostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, ServletException, IOException {
		EmployeeServletHelper employeeMethods = new EmployeeServletHelper();
		CommonServletHelper commonMethods = new CommonServletHelper();
		switch (path) {
		case "branch_accounts":
			employeeMethods.branchAccountsRequest(request, response);
			break;

		case "statement": {
			commonMethods.statementPostRequest(request, response);
		}
			break;

		case "search":
			employeeMethods.searchPostRequest(request, response);
			break;

		case "authorization": {
			String operation = request.getParameter(Parameters.OPERATION.parameterName());
			switch (operation) {
			case "authorize_transaction":
				employeeMethods.authorizeTransactionPostRequest(request, response);
				break;

			case "process_transaction":
				employeeMethods.processTransactionPostRequest(request, response);
				break;

			case "authorize_open_account":
				employeeMethods.authorizeOpenAccount(request, response);
				break;

			case "process_open_account":
				employeeMethods.processOpenAccountPostRequest(request, response);
				break;

			case "authorize_change_password":
				commonMethods.passwordChangeAuthorizationPostRequest(request, response);
				break;

			case "process_change_password":
				commonMethods.passwordChangeProcessPostRequest(request, response);
				break;

			case "authorize_close_account":
				employeeMethods.authorizeCloseAccountPostRequest(request, response);
				break;

			case "process_close_account":
				employeeMethods.processCloseAccountPostRequest(request, response);
				break;

			default:
				request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
				break;
			}
		}
			break;
		default:
			request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
			break;
		}
	}

	private boolean adminGetController(HttpServletRequest request, HttpServletResponse response, String path)
			throws IOException, AppException, ServletException {
		AdminServletHelper adminMethods = new AdminServletHelper();
		switch (path) {
		case "home":
			response.sendRedirect("employees");
			break;

		case "accounts":
			adminMethods.accountsRequest(request, response);
			break;

		case "employees":
			adminMethods.employeesRequest(request, response);
			break;

		case "branches":
			adminMethods.branchesRequest(request, response);
			break;

		case "add_employee":
			request.getRequestDispatcher("/WEB-INF/jsp/admin/add_employee.jsp").forward(request, response);
			break;

		case "add_branch":
			request.getRequestDispatcher("/WEB-INF/jsp/admin/add_branch.jsp").forward(request, response);
			break;

		default:
			return false;
		}
		return true;
	}

	private boolean adminPostController(HttpServletRequest request, HttpServletResponse response, String path)
			throws AppException, IOException, ServletException {
		AdminServletHelper adminMethods = new AdminServletHelper();
		switch (path) {
		case "accounts":
			adminMethods.accountsRequest(request, response);
			break;

		case "employees":
			adminMethods.employeesRequest(request, response);
			break;

		case "employee_details":
			adminMethods.employeeDetailsPostMethod(request, response);
			break;

		case "branches":
			adminMethods.branchesRequest(request, response);
			break;

		case "search":
			boolean check = adminMethods.searchPostRequest(request, response);
			System.out.println(check);
			if (!check) {
				return check;
			}
			break;

		case "authorization": {
			String operation = request.getParameter(Parameters.OPERATION.parameterName());
			switch (operation) {
			case "authorize_add_employee":
				adminMethods.authorizeAddEmployee(request, response);
				break;

			case "process_add_employee":
				adminMethods.processAddEmployeePostRequest(request, response);
				break;

			case "authorize_add_branch":
				adminMethods.authorizeAddBranch(request, response);
				break;

			case "process_add_branch":
				adminMethods.processAddBranchPostRequest(request, response);
				break;

			default:
				return false;
			}
		}
			break;

		default:
			return false;
		}
		return true;
	}

}
