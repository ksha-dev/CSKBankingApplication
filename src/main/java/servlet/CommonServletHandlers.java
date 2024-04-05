package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import exceptions.AppException;
import exceptions.messages.ServletExceptionMessage;
import modules.Account;
import modules.Transaction;
import modules.UserRecord;
import operations.AppOperations;
import utility.ConvertorUtil;
import utility.ValidatorUtil;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;

public class CommonServletHandlers {

	private AppOperations operation;

	public CommonServletHandlers() throws AppException {
		operation = new AppOperations();
	}

	private void dispatchRequest(HttpServletRequest request, HttpServletResponse response, String url)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	private HttpSession session(HttpServletRequest request) throws ServletException, IOException {
		return request.getSession(false);
	}

	private String nextURL(HttpServletRequest request, String url) {
		return request.getContextPath() + request.getServletPath() + url;
	}

	private UserRecord getUser(HttpServletRequest request) throws AppException, ServletException, IOException {
		HttpSession currentSession = session(request);
		return (UserRecord) currentSession.getAttribute("user");
	}

	private static String getStringFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		if (Objects.isNull(parameterValue)) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
		return parameterValue;
	}

	private static int getIntFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Integer.parseInt(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	private static long getLongFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Long.parseLong(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	private static double getDoubleFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Double.parseDouble(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_AMOUNT);
		}
	}

	public void loginPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		Map<String, String[]> parameters = request.getParameterMap();
		if (parameters.containsKey("userId") && parameters.containsKey("password")) {
			int userId = getIntFromParameter(request, "userId");
			String password = getStringFromParameter(request, "password");
			try {
				UserRecord user = operation.getUser(userId, password);
				session(request).setAttribute("user", user);
				if (user.getType() == UserType.CUSTOMER) {
					response.sendRedirect("customer/account");
				} else if (user.getType() == UserType.EMPLOYEE) {
					response.sendRedirect("employee/branch_accounts");
				} else if (user.getType() == UserType.ADMIN) {
					response.sendRedirect("employee/branch_accounts");
				}
			} catch (AppException e) {
				session(request).invalidate();
				request.getSession();
				request.setAttribute("alert", e.getMessage());
				dispatchRequest(request, response, "/WEB-INF/jsp/login.jsp");
			}
		} else {
			response.sendRedirect(nextURL(request, "/login"));
			return;
		}
	}

	public void statementPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		long accountNumber = getLongFromParameter(request, "account_number");
		String limitString = getStringFromParameter(request, "transaction_limit");
		int currentPage = getIntFromParameter(request, "currentPage");
		int pageCount = getIntFromParameter(request, "pageCount");
		if (pageCount < currentPage || currentPage < 1) {
			currentPage = 1;
		}
		try {
			List<Transaction> transactions;
			if (limitString.equals("custom")) {
				String startDateString = getStringFromParameter(request, "startDate");
				String endDateString = getStringFromParameter(request, "endDate");
				long startDate = ConvertorUtil.dateStringToMillis(startDateString);
				long endDate = ConvertorUtil.dateStringToMillisWithCurrentTime(endDateString);
				if (pageCount < 0) {
					pageCount = operation.getPageCountOfTransactions(accountNumber, startDate, endDate);
				}
				transactions = operation.getTransactionsOfAccount(accountNumber, 1, startDate, endDate);
				request.setAttribute("startDate", startDateString);
				request.setAttribute("endDate", endDateString);
			} else {
				TransactionHistoryLimit limit = TransactionHistoryLimit.valueOf(limitString);
				if (pageCount < 0) {
					pageCount = operation.getPageCountOfTransactions(accountNumber, limit);
				}
				transactions = operation.getTransactionsOfAccount(accountNumber, currentPage, limit);
			}
			request.setAttribute("limit", limitString);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("accountNumber", accountNumber);
			request.setAttribute("transactions", transactions);
			dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_view.jsp");
		} catch (AppException e) {
			e.printStackTrace();
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("operation", "statement");
			request.setAttribute("redirect", "statement");
			dispatchRequest(request, response, "/WEB-INF/jsp/common/transaction_status.jsp");
		}
	}

	public void passwordChangeAuthorizationPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = getStringFromParameter(request, "oldPassword");
		String newPassword = getStringFromParameter(request, "newPassword");
		try {
			operation.getUser(getUser(request).getUserId(), oldPassword);
			request.getSession(false).setAttribute("oldPassword", oldPassword);
			request.getSession(false).setAttribute("newPassword", newPassword);
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/WEB-INF/jsp/customer/authorization.jsp?redirect=process_change_password");
			dispatcher.forward(request, response);
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("operation", "password_change");
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "change_password");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
			dispatcher.forward(request, response);
		}
	}

	public void passwordChangeProcessPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = (String) session(request).getAttribute("oldPassword");
		String newPassword = (String) session(request).getAttribute("newPassword");
		String pin = getStringFromParameter(request, "pin");

		try {
			operation.updatePassword(getUser(request).getUserId(), oldPassword, newPassword, pin);
			request.setAttribute("status", true);
			request.setAttribute("operation", "password_change");
			request.setAttribute("message", "New password has been updated<br>Click Finish to Logout");
			request.setAttribute("redirect", "logout");
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("operation", "password_change");
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "change_password");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/customer/transaction_status.jsp");
		dispatcher.forward(request, response);
	}
}
