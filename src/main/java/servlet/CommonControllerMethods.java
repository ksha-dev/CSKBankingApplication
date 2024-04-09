package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import filters.Parameters;
import modules.Transaction;
import modules.UserRecord;
import operations.AppOperations;
import operations.CustomerOperations;
import utility.ConvertorUtil;
import utility.ServletUtil;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;

public class CommonControllerMethods {

	public CommonControllerMethods() throws AppException {
	}

	private AppOperations operation = new AppOperations();

	public void loginPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		int userId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		String password = request.getParameter(Parameters.PASSWORD.parameterName());
		try {
			UserRecord user = operation.getUser(userId, password);
			ServletUtil.session(request).setAttribute("user", user);
			response.sendRedirect(user.getType().toString().toLowerCase() + "/home");
		} catch (AppException e) {
			request.getSession(false).setAttribute("error", e.getMessage());
			response.sendRedirect(request.getContextPath() + "/login");
		}

	}

	public void statementPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		long accountNumber = ConvertorUtil
				.convertStringToLong(request.getParameter(Parameters.ACCOUNTNUMBER.parameterName()));
		String limitString = request.getParameter(Parameters.TRANSACTIONLIMIT.parameterName());
		int currentPage = ConvertorUtil
				.convertStringToInteger(request.getParameter(Parameters.CURRENTPAGE.parameterName()));
		int pageCount = ConvertorUtil
				.convertStringToInteger(request.getParameter(Parameters.PAGECOUNT.parameterName()));
		if (pageCount < currentPage) {
			currentPage = 1;
		}
		try {
			UserRecord user = ServletUtil.getUser(request);
			if (user.getType() == UserType.CUSTOMER) {
				new CustomerOperations().getAccountDetails(accountNumber, user.getUserId());
			} 
			List<Transaction> transactions;
			if (limitString.equals("custom")) {
				String startDateString = request.getParameter(Parameters.STARTDATE.parameterName());
				String endDateString = request.getParameter(Parameters.ENDDATE.parameterName());
				long startDate = ConvertorUtil.dateStringToMillis(startDateString);
				long endDate = ConvertorUtil.dateStringToMillisWithCurrentTime(endDateString);
				if (pageCount <= 0) {
					pageCount = operation.getPageCountOfTransactions(accountNumber, startDate, endDate);
				}
				transactions = operation.getTransactionsOfAccount(accountNumber, currentPage, startDate, endDate);
				request.setAttribute("startDate", startDateString);
				request.setAttribute("endDate", endDateString);
			} else {
				TransactionHistoryLimit limit = TransactionHistoryLimit.valueOf(limitString);
				if (pageCount <= 0) {
					pageCount = operation.getPageCountOfTransactions(accountNumber, limit);
				}
				transactions = operation.getTransactionsOfAccount(accountNumber, currentPage, limit);
			}
			request.setAttribute("limit", limitString);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("accountNumber", accountNumber);
			request.setAttribute("transactions", transactions);
			request.getRequestDispatcher("/WEB-INF/jsp/common/statement_view.jsp").forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("statement");
		}
	}

	public void passwordChangeAuthorizationPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = request.getParameter(Parameters.OLDPASSWORD.parameterName());
		String newPassword = request.getParameter(Parameters.NEWPASSWORD.parameterName());
		try {
			operation.getUser(ServletUtil.getUser(request).getUserId(), oldPassword);
			request.getSession(false).setAttribute("oldPassword", oldPassword);
			request.getSession(false).setAttribute("newPassword", newPassword);
			request.getRequestDispatcher("/WEB-INF/jsp/common/authorization.jsp?redirect=process_change_password")
					.forward(request, response);
		} catch (AppException e) {
			ServletUtil.session(request).setAttribute("error", e.getMessage());
			response.sendRedirect("change_password");
		}
	}

	public void passwordChangeProcessPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		String oldPassword = (String) ServletUtil.session(request).getAttribute("oldPassword");
		String newPassword = (String) ServletUtil.session(request).getAttribute("newPassword");
		String pin = request.getParameter(Parameters.PIN.parameterName());

		try {
			operation.updatePassword(ServletUtil.getUser(request).getUserId(), oldPassword, newPassword, pin);
			request.setAttribute("status", true);
			request.setAttribute("message", "New password has been updated<br>Click Finish to Logout");
			request.setAttribute("redirect", "logout");
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "change_password");
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp");
		dispatcher.forward(request, response);
	}
}
