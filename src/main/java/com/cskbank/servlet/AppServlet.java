package com.cskbank.servlet;

import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cskbank.exceptions.AppException;
import com.cskbank.filters.Parameters;
import com.cskbank.modules.UserRecord;
import com.cskbank.utility.GetterUtil;
import com.cskbank.utility.ServletUtil;
import com.cskbank.utility.ValidatorUtil;

public class AppServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public AppServlet() throws AppException {
		Services.initialize();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
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
			} else {
				switch (path) {
				case "/customer":
				case "/employee":
				case "/admin":
					homeRedirect(response, ServletUtil.getUser(request).getType());
					break;

				case "/login":
					new CommonServletHelper().loginPostRequest(request, response);
					break;

				case "/signup":
					new CommonServletHelper().signupPostRequest(request, response);
					break;

				case "/verification":
					new CommonServletHelper().verificationPostRequest(request, response);
					break;

				case "/reset_password":
					new CommonServletHelper().passwordResetRequestPostRequest(request, response);
					break;

				case "/complete_reset_password":
					new CommonServletHelper().passwordResetActionPostRequest(request, response);
					break;

				default:
					request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
					break;
				}
			}
		} catch (AppException e) {
			ServletUtil.redirectError(request, response, e);
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String path = request.getPathInfo();
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
			} else {
				switch (path) {
				case "/customer":
				case "/employee":
				case "/admin":
					homeRedirect(response, ServletUtil.getUser(request).getType());
					break;

				case "/verification":
					new CommonServletHelper().verificationGetRequest(request, response);
					break;

				case "/resend":
					new CommonServletHelper().resendGetRequest(request, response);
					break;

				case "/rp":
					new CommonServletHelper().passwordResetGetRequest(request, response);
					break;

				default:
					request.getRequestDispatcher("/static/html/page_not_found.html").forward(request, response);
					break;

				}
			}

		} catch (AppException e) {
			ServletUtil.redirectError(request, response, e);
		}
	}

	private void homeRedirect(HttpServletResponse response, UserRecord.Type userType) throws IOException {
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

		case "authorization":
			if (ValidatorUtil.isObjectNull(ServletUtil.session(request).getAttribute("redirect"))) {
				response.sendRedirect("home");
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp").forward(request, response);
			}
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

		case "authorization":
			if (ValidatorUtil.isObjectNull(ServletUtil.session(request).getAttribute("redirect"))) {
				response.sendRedirect("home");
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp").forward(request, response);
			}
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

			case "authorize_freeze_account":
				employeeMethods.authorizeFreezeAccountPostRequest(request, response);
				break;

			case "process_freeze_account":
				employeeMethods.processFreezeAccountPostRequest(request, response);
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

		case "api_service":
			adminMethods.apiServiceRequest(request, response);
			break;

		case "add_employee":
			request.getRequestDispatcher("/WEB-INF/jsp/admin/add_employee.jsp").forward(request, response);
			break;

		case "add_branch":
			request.getRequestDispatcher("/WEB-INF/jsp/admin/add_branch.jsp").forward(request, response);
			break;

		case "authorization":
			if (ValidatorUtil.isObjectNull(ServletUtil.session(request).getAttribute("redirect"))) {
				response.sendRedirect("home");
			} else {
				request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp").forward(request, response);
			}
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

		case "api_service":
			adminMethods.apiServiceRequest(request, response);
			break;

		case "branches":
			adminMethods.branchesRequest(request, response);
			break;

		case "search":
			boolean check = adminMethods.searchPostRequest(request, response);
			if (!check) {
				return check;
			}
			break;

		case "create_api_key":
			adminMethods.createAPIKeyPostRequest(request, response);
			break;

		case "invalidate_api_key":
			adminMethods.invalidateAPIKeyPostRequest(request, response);
			break;

		case "authorization": {
			String operation = request.getParameter(Parameters.OPERATION.parameterName());
			switch (operation) {
			case "authorize_add_employee":
				adminMethods.authorizeAddEmployee(request, response);
				break;

			case "authorize_change_status":
				adminMethods.authorizeChangeStatus(request, response);
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

			case "process_change_status":
				adminMethods.processChangeStatus(request, response);
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
