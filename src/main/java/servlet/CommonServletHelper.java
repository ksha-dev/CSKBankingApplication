package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.AppException;
import filters.Parameters;
import modules.AuditLog;
import modules.Transaction;
import modules.UserRecord;
import utility.ConvertorUtil;
import utility.ServletUtil;
import utility.ConstantsUtil.LogOperation;
import utility.ConstantsUtil.OperationStatus;
import utility.ConstantsUtil.TransactionHistoryLimit;
import utility.ConstantsUtil.UserType;

class CommonServletHelper {

	public void loginPostRequest(HttpServletRequest request, HttpServletResponse response)
			throws AppException, ServletException, IOException {
		int userId = ConvertorUtil.convertStringToInteger(request.getParameter(Parameters.USERID.parameterName()));
		String password = request.getParameter(Parameters.PASSWORD.parameterName());
		try {
			UserRecord user = AppServlet.appOperations.getUser(userId, password);
			ServletUtil.session(request).setAttribute("user", user);
			System.out.println(user);
			response.sendRedirect(user.getType().toString().toLowerCase() + "/home");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(userId);
			log.setLogOperation(LogOperation.USER_LOGIN);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(user.getType() + "(ID : " + userId + ") has successfully logged in");
			log.setModifiedAtWithCurrentTime();
			AppServlet.auditLogService.log(log);

		} catch (AppException e) {
			e.printStackTrace();
			request.getSession(false).setAttribute("error", e.getMessage());
			response.sendRedirect(request.getContextPath() + "/login");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(userId);
			log.setLogOperation(LogOperation.USER_LOGIN);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("User(ID : " + userId + ") login failed - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			AppServlet.auditLogService.log(log);
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
				AppServlet.customerOperations.getAccountDetails(accountNumber, user.getUserId());
			}
			List<Transaction> transactions;
			if (limitString.equals("custom")) {
				String startDateString = request.getParameter(Parameters.STARTDATE.parameterName());
				String endDateString = request.getParameter(Parameters.ENDDATE.parameterName());
				long startDate = ConvertorUtil.dateStringToMillis(startDateString);
				long endDate = ConvertorUtil.dateStringToMillisWithCurrentTime(endDateString);
				if (pageCount <= 0) {
					pageCount = AppServlet.appOperations.getPageCountOfTransactions(accountNumber, startDate, endDate);
				}
				transactions = AppServlet.appOperations.getTransactionsOfAccount(accountNumber, currentPage, startDate,
						endDate);
				request.setAttribute("startDate", startDateString);
				request.setAttribute("endDate", endDateString);
			} else {
				TransactionHistoryLimit limit = TransactionHistoryLimit.valueOf(limitString);
				if (pageCount <= 0) {
					pageCount = AppServlet.appOperations.getPageCountOfTransactions(accountNumber, limit);
				}
				transactions = AppServlet.appOperations.getTransactionsOfAccount(accountNumber, currentPage, limit);
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
			AppServlet.appOperations.getUser(ServletUtil.getUser(request).getUserId(), oldPassword);
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
		UserRecord user = ServletUtil.getUser(request);

		try {
			AppServlet.appOperations.updatePassword(user.getUserId(), oldPassword, newPassword, pin);
			request.setAttribute("status", true);
			request.setAttribute("message", "New password has been updated<br>Click Finish to Logout");
			request.setAttribute("redirect", "logout");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setLogOperation(LogOperation.UPDATE_PASSWORD);
			log.setOperationStatus(OperationStatus.SUCCESS);
			log.setDescription(user.getType() + "(ID : " + user.getUserId() + ") has changed the password");
			log.setModifiedAtWithCurrentTime();
			AppServlet.auditLogService.log(log);
		} catch (AppException e) {
			request.setAttribute("status", false);
			request.setAttribute("message", e.getMessage());
			request.setAttribute("redirect", "change_password");

			// Log
			AuditLog log = new AuditLog();
			log.setUserId(user.getUserId());
			log.setLogOperation(LogOperation.UPDATE_PASSWORD);
			log.setOperationStatus(OperationStatus.FAILURE);
			log.setDescription("Password update failed - " + e.getMessage());
			log.setModifiedAtWithCurrentTime();
			AppServlet.auditLogService.log(log);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/common/transaction_status.jsp");
		dispatcher.forward(request, response);
		// Log

	}
}
