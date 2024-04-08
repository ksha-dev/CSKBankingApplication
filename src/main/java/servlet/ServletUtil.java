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

public class ServletUtil {

	private AppOperations operation;

	public ServletUtil() throws AppException {
		operation = new AppOperations();
	}

	public static void dispatchRequest(HttpServletRequest request, HttpServletResponse response, String url)
			throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}

	public static HttpSession session(HttpServletRequest request) throws ServletException, IOException {
		return request.getSession(false);
	}

	public static String nextURL(HttpServletRequest request, String url) {
		return request.getContextPath() + request.getServletPath() + url;
	}

	public static UserRecord getUser(HttpServletRequest request) throws AppException, ServletException, IOException {
		HttpSession currentSession = ServletUtil.session(request);
		return (UserRecord) currentSession.getAttribute("user");
	}

	public static String getStringFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		if (Objects.isNull(parameterValue)) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
		return parameterValue;
	}

	public static int getIntFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Integer.parseInt(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	public static long getLongFromParameter(HttpServletRequest request, String parameter) throws AppException {
		ValidatorUtil.validateObject(parameter);
		ValidatorUtil.validateObject(request);
		String parameterValue = request.getParameter(parameter);
		try {
			return Long.parseLong(parameterValue);
		} catch (Exception e) {
			throw new AppException(parameter, ServletExceptionMessage.INVALID_VALUE);
		}
	}

	public static double getDoubleFromParameter(HttpServletRequest request, String parameter) throws AppException {
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
			int userId = ServletUtil.getIntFromParameter(request, "userId");
			String password = ServletUtil.getStringFromParameter(request, "password");
			try {
				UserRecord user = operation.getUser(userId, password);
				ServletUtil.session(request).setAttribute("user", user);
				response.sendRedirect(user.getType().toString().toLowerCase() + "/home");

			} catch (AppException e) {
				ServletUtil.session(request).invalidate();
				request.getSession();
				request.setAttribute("alert", e.getMessage());
				ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/login.jsp");
			}
		} else {
			response.sendRedirect(ServletUtil.nextURL(request, "/login"));
			return;
		}
	}

	public void statementPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		long accountNumber = ServletUtil.getLongFromParameter(request, "account_number");
		String limitString = ServletUtil.getStringFromParameter(request, "transaction_limit");
		int currentPage = ServletUtil.getIntFromParameter(request, "currentPage");
		int pageCount = ServletUtil.getIntFromParameter(request, "pageCount");

		if (pageCount < currentPage || currentPage < 1) {
			currentPage = 1;
		}
		try {
			List<Transaction> transactions;
			if (limitString.equals("custom")) {
				String startDateString = ServletUtil.getStringFromParameter(request, "startDate");
				String endDateString = ServletUtil.getStringFromParameter(request, "endDate");
				long startDate = ConvertorUtil.dateStringToMillis(startDateString);
				long endDate = ConvertorUtil.dateStringToMillisWithCurrentTime(endDateString);
				if (pageCount < 0) {
					pageCount = operation.getPageCountOfTransactions(accountNumber, startDate, endDate);
				}
				transactions = operation.getTransactionsOfAccount(accountNumber, currentPage, startDate, endDate);
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
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_view.jsp");
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			ServletUtil.dispatchRequest(request, response, "/WEB-INF/jsp/common/statement_select.jsp");
		}
	}

	public void passwordChangeAuthorizationPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = ServletUtil.getStringFromParameter(request, "oldPassword");
		String newPassword = ServletUtil.getStringFromParameter(request, "newPassword");
		try {
			operation.getUser(ServletUtil.getUser(request).getUserId(), oldPassword);
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
		String oldPassword = (String) ServletUtil.session(request).getAttribute("oldPassword");
		String newPassword = (String) ServletUtil.session(request).getAttribute("newPassword");
		String pin = ServletUtil.getStringFromParameter(request, "pin");

		try {
			operation.updatePassword(ServletUtil.getUser(request).getUserId(), oldPassword, newPassword, pin);
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
